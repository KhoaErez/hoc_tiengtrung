'use server'

import { createClient, getCachedAuthUser } from '@/lib/supabase/server'
import { revalidatePath, updateTag } from 'next/cache'

export interface LessonSm2WordInput {
  hanzi: string
  pinyin: string
  meaningVi: string
  partOfSpeech?: string
  hskLevelLabel?: string
  exampleHanzi?: string
  examplePinyin?: string
  exampleVi?: string
}

export interface SaveLessonSm2Result {
  success: boolean
  savedCount: number
  requiresAuth?: boolean
  error?: string
}

/**
 * Lưu toàn bộ từ vựng mới học trong Lesson Player vào kho ôn tập SM-2 (user_vocabularies).
 * - Nếu từ chưa có trong bảng vocabularies (ví dụ thuật ngữ Công Xưởng), tự động thêm vào vocabularies.
 * - Khởi tạo chu trình SM-2 (interval = 1 ngày, ease = 2.5, next_review_at = hiện tại để sẵn sàng ôn tập).
 * - Nếu người học chưa đăng nhập, trả về requiresAuth: true để UI vẫn lưu local & gợi ý đăng nhập đồng bộ.
 */
export async function saveLessonWordsToSm2Action(
  words: LessonSm2WordInput[]
): Promise<SaveLessonSm2Result> {
  try {
    if (!Array.isArray(words) || words.length === 0) {
      return { success: true, savedCount: 0 }
    }

    const [supabase, user] = await Promise.all([createClient(), getCachedAuthUser()])
    if (!user) {
      return {
        success: false,
        savedCount: 0,
        requiresAuth: true,
        error: 'Đã lưu tạm trên trình duyệt. Đăng nhập để đồng bộ vào lịch ôn tập SM-2 trên mây!',
      }
    }

    const nowIso = new Date().toISOString()
    let savedCount = 0

    for (const item of words) {
      const cleanHanzi = (item.hanzi || '').trim()
      if (!cleanHanzi) continue

      let { data: vocab } = await supabase
        .from('vocabularies')
        .select('id')
        .eq('hanzi', cleanHanzi)
        .limit(1)
        .maybeSingle()

      if (!vocab) {
        const { data: insertedVocab, error: insertVocabErr } = await supabase
          .from('vocabularies')
          .insert({
            hanzi: cleanHanzi,
            pinyin: item.pinyin,
            meaning_vi: item.meaningVi,
            word_type: item.partOfSpeech || null,
            hsk_level: item.hskLevelLabel || 'Công xưởng',
            example_hanzi: item.exampleHanzi || null,
            example_pinyin: item.examplePinyin || null,
            example_vi: item.exampleVi || null,
          })
          .select('id')
          .maybeSingle()

        if (insertVocabErr || !insertedVocab) {
          console.error('Lỗi thêm từ mới vào vocabularies:', insertVocabErr)
          continue
        }
        vocab = insertedVocab
      }

      const { data: existingUserVocab } = await supabase
        .from('user_vocabularies')
        .select('id')
        .eq('user_id', user.id)
        .eq('vocabulary_id', vocab.id)
        .maybeSingle()

      if (existingUserVocab) {
        const { error: updateErr } = await supabase
          .from('user_vocabularies')
          .update({
            next_review_at: nowIso,
            status: 'reviewing',
          })
          .eq('id', existingUserVocab.id)
        if (!updateErr) savedCount++
      } else {
        const { error: linkErr } = await supabase.from('user_vocabularies').insert({
          user_id: user.id,
          vocabulary_id: vocab.id,
          status: 'learning',
          repetitions: 0,
          review_interval_days: 1,
          ease_factor: 2.5,
          next_review_at: nowIso,
        })
        if (!linkErr) savedCount++
      }
    }

    if (savedCount > 0) {
      revalidatePath('/review')
      revalidatePath('/topics')
      revalidatePath('/')
      try {
        updateTag('vocab-counts')
      } catch {
        // Bỏ qua nếu môi trường runtime không hỗ trợ tag revalidation
      }
    }

    return {
      success: savedCount > 0,
      savedCount,
    }
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : 'Không thể lưu vào ôn tập SM-2'
    return {
      success: false,
      savedCount: 0,
      error: message,
    }
  }
}
