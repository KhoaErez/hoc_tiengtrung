'use server'

import { createClient } from '@/lib/supabase/server'

export async function correctWritingAction(text: string) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    throw new Error('Unauthorized')
  }

  const { GoogleGenAI } = await import('@google/genai')
  const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY })

  const prompt = "Bạn là giáo viên dạy tiếng Trung. Hãy chấm điểm và sửa lỗi đoạn văn sau của học sinh. \n\nTrả về MỘT OBJECT JSON duy nhất (không markdown) với cấu trúc: \n{ \"score\": 8, \"corrected_text\": \"...\", \"feedback\": \"nhận xét chi tiết bằng tiếng Việt về ngữ pháp và từ vựng...\" }\n\nĐoạn văn:\n" + text

  let response;
  let retries = 3;
  while (retries > 0) {
    try {
      response = await ai.models.generateContent({
        model: 'gemini-3.8-flash',
        contents: prompt,
        config: {
          responseMimeType: "application/json",
        }
      });
      break;
    } catch (error: unknown) {
      const err = error instanceof Error ? error : new Error(String(error));
      if (err.message && err.message.includes("503") && retries > 1) {
        retries--;
        await new Promise(r => setTimeout(r, 2000)); // wait 2s before retrying
        continue;
      }
      console.error('AI Error:', error)
      throw new Error('Lỗi từ AI: ' + err.message)
    }
  }

  try {
    return JSON.parse(response?.text || "{}")
  } catch (parseError) {
    console.error('JSON Parse Error:', parseError)
    throw new Error('Lỗi định dạng dữ liệu từ AI')
  }
}
