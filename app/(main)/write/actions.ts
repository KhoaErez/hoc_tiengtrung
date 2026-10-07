'use server'

import { createClient } from '@/lib/supabase/server'

export async function correctWritingAction(text: string, level: string = "Chưa xác định") {
  if (!text || text.trim().length === 0) {
    return { error: "Vui lòng nhập bài viết trước khi phân tích." };
  }
  if (text.length > 5000) {
    return { error: "Bài viết quá dài, vui lòng rút gọn dưới 5000 ký tự." };
  }

  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    return { error: "Vui lòng đăng nhập để sử dụng tính năng này." };
  }

  const OpenAI = (await import('openai')).default
  const ai = new OpenAI({ 
    apiKey: process.env.KIE_API_KEY || process.env.GEMINI_API_KEY,
    baseURL: process.env.KIE_BASE_URL || "https://api.kie.ai/v1" 
  })

  const prompt = `Bạn là một giáo viên dạy tiếng Trung.
Nhiệm vụ: Chấm điểm và sửa lỗi bài nhật ký tiếng Trung của học sinh. 
Trình độ mục tiêu được chọn: ${level}.

QUY TẮC PHÂN TÍCH LỖI VÀ CHẤM ĐIỂM (BẮT BUỘC):
1. TỔNG ĐIỂM (100) = Grammar (30) + Vocabulary (20) + Word Order (15) + Naturalness (15) + Coherence (10) + HSK Appropriateness (10). Điểm tổng phải LUÔN LUÔN BẰNG TỔNG 6 TIÊU CHÍ NÀY.
2. PHÂN BIỆT TUYỆT ĐỐI GIỮA ERROR VÀ SUGGESTION:
   - ERROR: Thực sự sai ngữ pháp, sai từ vựng, sai trật tự câu. BỊ TRỪ ĐIỂM.
   - SUGGESTION: Không sai nhưng có thể diễn đạt tự nhiên/tốt hơn. KHÔNG BỊ TRỪ ĐIỂM.
3. KHÔNG OVER-CORRECTION: Nếu câu học sinh viết đã đúng thì phải công nhận là ĐÚNG. Tuyệt đối không sửa một câu đúng chỉ vì bạn thích cách diễn đạt khác.
4. GIỮ NGUYÊN Ý NGHĨA: KHÔNG tự ý thêm nhân vật, thời gian, địa điểm, sự kiện, hành động, cảm xúc, thông tin mà người dùng không viết. Không biến bài viết thành một bài văn mới. Mục đích là phân tích và giúp học sinh sửa bài của CHÍNH MÌNH.
5. CHI TIẾT LỖI: Với mỗi lỗi/gợi ý, tạo 1 object trong mảng "errors". Nếu bài KHÔNG CÓ LỖI, mảng "errors" phải là [] (rỗng). Đừng cố tạo lỗi giả để làm bài phân tích chi tiết hơn.
6. HSK LEVEL: Đánh giá HSK phải dựa trên trình độ học sinh chọn. Không trừ điểm nếu dùng cấu trúc nâng cao nếu cấu trúc đó đúng.

TRẢ VỀ DUY NHẤT một JSON theo cấu trúc sau, tuyệt đối không dùng markdown, không giải thích gì thêm:
{
  "score": 85,
  "level": "HSK1 | HSK2 | HSK3 | HSK4 | HSK5 | HSK6 (Hãy đánh giá năng lực của bài viết và trả về 1 level phù hợp nhất)",
  "summary": "Nhận xét tổng quan bằng tiếng Việt...",
  "correctedText": "Bài viết hoàn chỉnh sau khi sửa. NHẮC LẠI: Phải giữ nguyên thông tin gốc!",
  "errors": [
    {
      "original": "câu gốc",
      "correction": "câu sửa",
      "type": "grammar | vocabulary | word_order | naturalness | coherence | punctuation",
      "severity": "error | suggestion",
      "explanation": "giải thích vì sao sai bằng tiếng Việt",
      "reason": "lý do ngắn gọn"
    }
  ],
  "strengths": ["điểm mạnh 1", "điểm mạnh 2"],
  "weaknesses": ["điểm yếu 1", "điểm yếu 2"],
  "vocabularySuggestions": [
    {
      "word": "chữ Hán",
      "pinyin": "pinyin",
      "meaning": "nghĩa tiếng Việt",
      "example": "câu ví dụ tiếng Trung"
    }
  ],
  "learningSuggestions": ["gợi ý 1", "gợi ý 2"],
  "scoreDetails": {
    "grammar": 25,
    "vocabulary": 18,
    "wordOrder": 12,
    "naturalness": 12,
    "coherence": 9,
    "hskAppropriateness": 9
  }
}

Bài viết của học sinh:
${text}
`

  let response;
  try {
    response = await ai.chat.completions.create({
      model: process.env.KIE_MODEL || 'gemini-3.8-flash-openai',
      messages: [{ role: "user", content: prompt }]
    });
    
    // Check non-standard error từ kie
    const resAny = response as unknown as Record<string, unknown>;
    if (resAny.code && resAny.msg) {
        throw new Error(String(resAny.msg));
    }
  } catch (error: unknown) {
    const err = error as { status?: number, message?: string };
    const status = err.status || (err.message && err.message.match(/(\d{3})/)?.[1]);
    let errorMessage = "Lỗi hệ thống AI. Vui lòng thử lại sau.";
    
    if (status) {
      const code = parseInt(String(status));
      if (code === 401) errorMessage = "API authentication không hợp lệ. Vui lòng kiểm tra cấu hình server.";
      else if (code === 403) errorMessage = "API không có quyền sử dụng model này.";
      else if (code === 404) errorMessage = "Model hoặc API endpoint không tồn tại.";
      else if (code === 429) errorMessage = "AI đang bận hoặc bạn đã đạt giới hạn sử dụng. Vui lòng thử lại sau.";
      else if (code === 402) errorMessage = "Tài khoản API đã hết credits.";
      else if (code === 503) errorMessage = "Dịch vụ AI hiện tạm thời không khả dụng. Vui lòng thử lại sau.";
      else if (code === 500) errorMessage = "Lỗi máy chủ AI. Vui lòng thử lại.";
      else errorMessage = "Lỗi HTTP " + code + " từ máy chủ AI.";
    }
    
    return { error: errorMessage };
  }

  const resData = response as unknown as Record<string, unknown>;
  if (!response || !resData.choices || !Array.isArray(resData.choices) || resData.choices.length === 0) {
    return { error: "Không nhận được phản hồi từ AI." };
  }

  try {
    const choice = resData.choices[0] as { message?: { content?: string } };
    const rawText = String(choice?.message?.content || "{}");
    const resultText = rawText.replace(/```(?:json)?\s*([\s\S]*?)\s*```/g, '$1').trim();
    const data = JSON.parse(resultText);
    return { data };
  } catch (parseError) {
    console.error('JSON Parse Error:', parseError);
    return { error: "Lỗi định dạng dữ liệu từ AI. Phản hồi không hợp lệ." };
  }
}
