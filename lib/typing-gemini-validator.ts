// Trình tạo Prompt và Xác thực dữ liệu Pinyin & Nghĩa từ Gemini cho Luyện đánh máy
import { TypingSegment } from './typing-storage'

export interface ValidationReport {
  isValid: boolean;
  canApply: boolean;
  errors: string[];
  warnings: string[];
  parsedSegments: TypingSegment[];
  matchedCount: number;
  totalSegments: number;
  coverageRatio: number; // 0 đến 1
}

// 1. Tạo Prompt chuẩn mực cho Gemini cá nhân
export function buildTypingPinyinPrompt(rawText: string): string {
  return `Bạn là một chuyên gia ngôn ngữ tiếng Trung Quốc và dịch thuật tiếng Việt sư phạm.
Nhiệm vụ của bạn là bổ sung phiên âm Pinyin và dịch nghĩa tiếng Việt cho bài luyện đánh máy tiếng Trung sau đây.

QUY TẮC CỰC KỲ QUAN TRỌNG (BẮT BUỘC TUÂN THỦ 100%):
1. BẢO TOÀN NGUYÊN VĂN CHỮ HÁN GỐC (trường "chinese"):
   - TUYỆT ĐỐI KHÔNG tự sửa câu, không sửa lỗi ngữ pháp, không thay đổi chữ giản thể/phồn thể.
   - Không tự ý thêm bớt từ ngữ, ký tự hay dấu câu của người dùng.
   - Giữ nguyên thứ tự các câu và đoạn văn theo đúng văn bản gốc từ đầu đến cuối.
2. PINYIN CHUẨN XÁC CÓ DẤU (trường "pinyin"):
   - Viết Hanyu Pinyin chuẩn quốc tế, có đầy đủ dấu thanh điệu (ā, á, ǎ, à, v.v.).
   - Phân tách từ theo cụm từ tự nhiên, ngắt câu rõ ràng tương ứng với câu chữ Hán.
3. DỊCH NGHĨA TIẾNG VIỆT TỰ NHIÊN (trường "meaning_vi"):
   - Dịch sát nghĩa, chuẩn xác và tự nhiên theo văn phong tiếng Việt hiện đại, đúng ngữ cảnh câu.
4. PHÂN ĐOẠN THEO CÂU:
   - Chia văn bản theo từng câu hoàn chỉnh (kết thúc bằng dấu chấm 。 hoặc dấu hỏi ？ hoặc dấu cảm ！ hoặc xuống dòng).
   - Nếu có đoạn hội thoại có tên người (ví dụ: 王明：...), hãy giữ nguyên cả phần tên người và lời thoại.
5. ĐỊNH DẠNG ĐẦU RA BẮT BUỘC:
   - CHỈ TRẢ VỀ DUY NHẤT MỘT KHỐI JSON HỢP LỆ (không có bất kỳ lời chào hay giải thích nào bên ngoài JSON).
   - Cấu trúc JSON bắt buộc:
{
  "segments": [
    {
      "chinese": "Văn bản chữ Hán câu 1 (nguyên văn)",
      "pinyin": "Pinyin có dấu câu 1",
      "meaning_vi": "Nghĩa tiếng Việt câu 1"
    }
  ]
}

VĂN BẢN TIẾNG TRUNG CẦN XỬ LÝ:
"""
${rawText}
"""`;
}

// 2. Làm sạch chuỗi JSON nếu Gemini trả về markdown fences ```json ... ```
export function cleanGeminiJsonString(raw: string): string {
  if (!raw) return '';
  let cleaned = raw.trim();
  // Xóa ```json ở đầu và ``` ở cuối nếu có
  cleaned = cleaned.replace(/^```(?:json)?\s*/i, '');
  cleaned = cleaned.replace(/\s*```$/i, '');
  return cleaned.trim();
}

// Chuẩn hóa dấu câu và khoảng trắng để so sánh đối chiếu
function simplifyForMatch(str: string): string {
  if (!str) return '';
  return str
    .replace(/\s+/g, '')
    .replace(/[，,]/g, ',')
    .replace(/[。.!！?？:：;；"“”'‘’（）()【】\[\]]/g, '');
}

// 3. Phân tích và Kiểm tra tính hợp lệ của JSON từ Gemini đối chiếu với văn bản gốc
export function validateGeminiTypingJson(
  rawJsonInput: string,
  originalText: string
): ValidationReport {
  const errors: string[] = [];
  const warnings: string[] = [];

  if (!rawJsonInput || !rawJsonInput.trim()) {
    return {
      isValid: false,
      canApply: false,
      errors: ['Vui lòng dán kết quả JSON từ Gemini vào ô kết quả trước khi kiểm tra.'],
      warnings: [],
      parsedSegments: [],
      matchedCount: 0,
      totalSegments: 0,
      coverageRatio: 0,
    };
  }

  const cleaned = cleanGeminiJsonString(rawJsonInput);
  let parsedData: unknown = null;

  try {
    parsedData = JSON.parse(cleaned);
  } catch (err) {
    const error = err as Error;
    return {
      isValid: false,
      canApply: false,
      errors: [
        'Dữ liệu dán vào không phải là JSON hợp lệ. Chi tiết lỗi cú pháp: ' +
          (error?.message || 'Lỗi parse JSON') +
          '. Hãy đảm bảo bạn đã sao chép trọn vẹn phản hồi JSON từ Gemini (bao gồm cả dấu mở { và đóng }).',
      ],
      warnings: [],
      parsedSegments: [],
      matchedCount: 0,
      totalSegments: 0,
      coverageRatio: 0,
    };
  }

  // Kiểm tra cấu trúc object và mảng segments
  if (!parsedData || typeof parsedData !== 'object') {
    return {
      isValid: false,
      canApply: false,
      errors: ['Dữ liệu JSON không đúng cấu trúc object mong muốn { "segments": [...] }.'],
      warnings: [],
      parsedSegments: [],
      matchedCount: 0,
      totalSegments: 0,
      coverageRatio: 0,
    };
  }

  const dataObj = parsedData as Record<string, unknown>;
  const rawSegments = dataObj.segments;

  if (!rawSegments || !Array.isArray(rawSegments) || rawSegments.length === 0) {
    return {
      isValid: false,
      canApply: false,
      errors: ['Không tìm thấy mảng "segments" hoặc mảng segments rỗng trong dữ liệu JSON.'],
      warnings: [],
      parsedSegments: [],
      matchedCount: 0,
      totalSegments: 0,
      coverageRatio: 0,
    };
  }

  const parsedSegments: TypingSegment[] = [];
  let matchedCount = 0;
  let searchCursor = 0;
  let totalChineseChars = 0;

  for (let i = 0; i < rawSegments.length; i++) {
    const item = rawSegments[i] as Record<string, unknown>;
    const segNum = i + 1;

    const chinese = String(item?.chinese || '').trim();
    const pinyin = String(item?.pinyin || '').trim();
    const meaning_vi = String(item?.meaning_vi || '').trim();

    if (!chinese) {
      warnings.push(`Đoạn số ${segNum} bị thiếu trường chữ Hán ("chinese").`);
      continue;
    }

    if (!pinyin) {
      warnings.push(`Đoạn số ${segNum} ("${chinese.slice(0, 15)}...") bị thiếu phiên âm Pinyin.`);
    }

    if (!meaning_vi) {
      warnings.push(`Đoạn số ${segNum} ("${chinese.slice(0, 15)}...") bị thiếu nghĩa tiếng Việt.`);
    }

    // Kiểm tra đối chiếu với văn bản gốc
    const foundIdx = originalText.indexOf(chinese, searchCursor);

    if (foundIdx !== -1) {
      matchedCount++;
      searchCursor = foundIdx + chinese.length;
      totalChineseChars += chinese.length;
    } else {
      // Thử tìm nới lỏng (bỏ qua khoảng trắng / dấu câu nếu có lệch)
      const simplifiedSeg = simplifyForMatch(chinese);
      const simplifiedRest = simplifyForMatch(originalText.slice(searchCursor));

      if (simplifiedRest.includes(simplifiedSeg)) {
        matchedCount++;
        warnings.push(
          `Đoạn số ${segNum} ("${chinese.slice(0, 20)}...") có sự sai khác nhỏ về dấu câu hoặc khoảng trắng so với văn bản gốc.`
        );
        totalChineseChars += chinese.length;
      } else {
        warnings.push(
          `Đoạn số ${segNum} ("${chinese.slice(0, 25)}...") không tìm thấy nguyên văn trong đoạn văn bản gốc tương ứng.`
        );
      }
    }

    parsedSegments.push({
      chinese,
      pinyin,
      meaning_vi,
    });
  }

  if (parsedSegments.length === 0) {
    return {
      isValid: false,
      canApply: false,
      errors: ['Không có phân đoạn hợp lệ nào được trích xuất từ JSON.'],
      warnings,
      parsedSegments: [],
      matchedCount: 0,
      totalSegments: 0,
      coverageRatio: 0,
    };
  }

  const origNonSpaceCount = originalText.replace(/\s+/g, '').length || 1;
  const coverageRatio = Math.min(1, Math.round((totalChineseChars / origNonSpaceCount) * 100) / 100);

  const isValid = errors.length === 0 && parsedSegments.length > 0;
  const canApply = isValid;

  return {
    isValid,
    canApply,
    errors,
    warnings,
    parsedSegments,
    matchedCount,
    totalSegments: parsedSegments.length,
    coverageRatio,
  };
}

// 4. Khớp các segment với vị trí chính xác trong chuỗi văn bản gốc
export interface SegmentBlock {
  index: number;
  startIndex: number;
  endIndex: number;
  segment: TypingSegment;
}

export function mapSegmentsToIndices(
  originalText: string,
  segments: TypingSegment[]
): SegmentBlock[] {
  if (!originalText || !segments || segments.length === 0) return [];

  const blocks: SegmentBlock[] = [];
  let cursor = 0;

  for (let i = 0; i < segments.length; i++) {
    const seg = segments[i];
    if (!seg.chinese) continue;

    // 1. Thử tìm chính xác từ vị trí cursor
    let foundIdx = originalText.indexOf(seg.chinese, cursor);

    // 2. Nếu không tìm thấy, thử tìm từ đầu chuỗi (đề phòng thứ tự lệch nhẹ)
    if (foundIdx === -1) {
      foundIdx = originalText.indexOf(seg.chinese, 0);
    }

    if (foundIdx !== -1) {
      const end = foundIdx + seg.chinese.length;
      blocks.push({
        index: i,
        startIndex: foundIdx,
        endIndex: end,
        segment: seg,
      });
      cursor = Math.max(cursor, end);
    }
  }

  return blocks;
}
