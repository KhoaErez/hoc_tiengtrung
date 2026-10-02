'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { redirect } from 'next/navigation'

export async function createLesson(formData: FormData) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    throw new Error('Unauthorized')
  }

  const title = formData.get('title') as string
  const subtitle = formData.get('subtitle') as string
  const original_text = formData.get('original_text') as string
  const hsk_level = formData.get('hsk_level') as string

  const { data, error } = await supabase
    .from('lessons')
    .insert({
      user_id: user.id,
      title,
      subtitle,
      original_text,
      hsk_level,
      source_type: 'text'
    })
    .select()
    .single()

  if (error) {
    console.error('Error creating lesson:', error)
    throw new Error('Failed to create lesson')
  }

  revalidatePath('/lessons')
  redirect('/lessons/' + data.id)
}

export async function analyzeLessonAction(lessonId: string) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    throw new Error('Unauthorized')
  }

  const { data: lesson } = await supabase
    .from('lessons')
    .select('original_text')
    .eq('id', lessonId)
    .single()

  if (!lesson || !lesson.original_text) {
    throw new Error('Lesson not found')
  }

  const { GoogleGenAI } = await import('@google/genai')
  const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY })

  const prompt = `Phân tích văn bản tiếng Trung sau đây để tạo thành một giáo trình học tập. 
Trả về MỘT OBJECT JSON duy nhất theo đúng cấu trúc sau (không dùng markdown):
{
  "words": [{"hanzi": "chữ", "pinyin": "pinyin", "vi": "nghĩa"}], // Tách toàn bộ văn bản thành từng từ một (kể cả dấu câu).
  "key_vocab": [{"hanzi": "chữ", "pinyin": "pinyin", "vi": "nghĩa"}], // Trích xuất 5-10 từ vựng quan trọng nhất trong bài.
  "pinyin_text": "Phiên âm toàn bộ đoạn văn bản thành pinyin (có dấu thanh điệu, viết liền thành câu).",
  "translation": "Dịch toàn bộ đoạn văn bản sang tiếng Việt sao cho tự nhiên nhất.",
  "grammar": [{"structure": "cấu trúc (vd: 离...很远)", "explanation": "giải thích cách dùng bằng tiếng Việt"}] // Trích xuất 1-3 cấu trúc ngữ pháp quan trọng trong bài (nếu có).
}

Văn bản:
${lesson.original_text}`;

  let response;
  let retries = 3;
  while (retries > 0) {
    try {
      response = await ai.models.generateContent({
        model: 'gemini-3.5-flash',
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
        await new Promise(r => setTimeout(r, 2000));
        continue;
      }
      console.error('AI Error:', error)
      throw new Error('Lỗi từ AI: ' + (err.message || 'Không rõ lỗi'))
    }
  }
  
  if (!response) {
    throw new Error('Lỗi từ AI: Server Google đang quá tải. Hãy thử lại sau.')
  }

  try {
    const resultText = response.text || "[]"
    await supabase.from('lessons').update({ pinyin: resultText }).eq('id', lessonId)
    revalidatePath('/lessons/' + lessonId)
  } catch (error: unknown) {
    console.error('Database Error:', error)
    const err = error instanceof Error ? error : new Error(String(error));
    throw new Error('Lỗi lưu Database: ' + err.message)
  }
}


export async function saveVocabularyAction(word: { hanzi: string, pinyin: string, vi: string }) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) throw new Error('Unauthorized')

  // Check if vocab exists
  let { data: vocab } = await supabase
    .from('vocabularies')
    .select('id')
    .eq('hanzi', word.hanzi)
    .single()

  if (!vocab) {
    const { data: newVocab, error } = await supabase
      .from('vocabularies')
      .insert({
        hanzi: word.hanzi,
        pinyin: word.pinyin,
        meaning_vi: word.vi,
        hsk_level: 'Chưa phân loại'
      })
      .select('id')
      .single()
      
    if (error) throw new Error('Failed to create vocabulary: ' + error.message)
    vocab = newVocab
  }

  // Save to user_vocabularies
  const { error: linkError } = await supabase
    .from('user_vocabularies')
    .upsert({
      user_id: user.id,
      vocabulary_id: vocab.id,
      status: 'learning',
    }, { onConflict: 'user_id,vocabulary_id' })

  if (linkError) throw new Error('Failed to save to notebook: ' + linkError.message)

  revalidatePath('/dashboard')
  revalidatePath('/review')
  return { success: true }
}

export async function updateLessonAiDataAction(lessonId: string, aiData: Record<string, unknown>) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) throw new Error('Unauthorized')

  await supabase.from('lessons').update({ pinyin: JSON.stringify(aiData) }).eq('id', lessonId)
  revalidatePath('/lessons/' + lessonId)
  return { success: true }
}

export async function deleteLessonAction(lessonId: string) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) throw new Error('Unauthorized')

  const { error } = await supabase.from('lessons').delete().eq('id', lessonId).eq('user_id', user.id)
  
  if (error) {
    console.error('Delete error:', error)
    throw new Error('Failed to delete lesson')
  }

  revalidatePath('/lessons')
  revalidatePath('/dashboard')
}
