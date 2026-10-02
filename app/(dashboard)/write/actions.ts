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

  try {
    const response = await ai.models.generateContent({
      model: 'gemini-3.5-flash',
      contents: prompt,
      config: {
        responseMimeType: "application/json",
      }
    })
    
    return JSON.parse(response.text || "{}")
  } catch (error: unknown) {
    console.error('AI Error:', error)
    const err = error instanceof Error ? error : new Error(String(error));
    throw new Error('Lỗi từ AI: ' + err.message)
  }
}
