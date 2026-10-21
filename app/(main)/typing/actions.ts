'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export type ReviewStatus = 'need_review' | 'reviewing' | 'mastered'

export interface TypingMistakeDetail {
  index: number
  expected: string
  actual: string
}

export interface TypingProgressDTO {
  id?: string
  mode: string
  exerciseId: string
  currentSentenceIndex: number
  completedSentences: number
  totalSentences: number
  correctSentences: number
  errorSentences: number
  lastTypedLength: number
  timeSpentSeconds: number
  status: 'not_started' | 'in_progress' | 'completed'
  updatedAt?: string
}

export interface TypingMistakeDTO {
  id?: string
  mode: string
  exerciseId: string
  sentenceIndex: number
  sentenceZh: string
  pinyin?: string
  meaningVi?: string
  lastInputZh: string
  mistakeDetails: TypingMistakeDetail[]
  mistakeCount?: number
  reviewStatus?: ReviewStatus
  reviewCount?: number
  reviewCorrectCount?: number
  consecutiveCorrect?: number
  lastErrorAt?: string
  lastReviewedAt?: string
}

/**
 * 1. Lấy tiến độ luyện gõ của bài tập
 */
export async function getTypingProgressAction(mode: string, exerciseId: string) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return { success: false, isGuest: true, progress: null }
    }

    const { data, error } = await supabase
      .from('typing_progress')
      .select('*')
      .eq('user_id', user.id)
      .eq('mode', mode)
      .eq('exercise_id', exerciseId)
      .maybeSingle()

    if (error) {
      // Bảng chưa tạo hoặc lỗi mạng
      return { success: false, error: error.message, isGuest: false, progress: null }
    }

    if (!data) {
      return { success: true, isGuest: false, progress: null }
    }

    return {
      success: true,
      isGuest: false,
      progress: {
        id: data.id,
        mode: data.mode,
        exerciseId: data.exercise_id,
        currentSentenceIndex: data.current_sentence_index,
        completedSentences: data.completed_sentences,
        totalSentences: data.total_sentences,
        correctSentences: data.correct_sentences,
        errorSentences: data.error_sentences,
        lastTypedLength: data.last_typed_length,
        timeSpentSeconds: data.time_spent_seconds,
        status: data.status,
        updatedAt: data.updated_at,
      } as TypingProgressDTO,
    }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi không xác định', isGuest: false, progress: null }
  }
}

/**
 * 2. Lưu / Cập nhật tiến độ bài luyện gõ (Upsert)
 */
export async function saveTypingProgressAction(input: TypingProgressDTO) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return { success: false, isGuest: true }
    }

    // Kiểm tra xung đột dữ liệu đa thiết bị nếu đây là bản ghi đồng bộ có timestamp
    if (input.updatedAt) {
      const { data: existing } = await supabase
        .from('typing_progress')
        .select('updated_at, completed_sentences, current_sentence_index')
        .eq('user_id', user.id)
        .eq('mode', input.mode)
        .eq('exercise_id', input.exerciseId)
        .maybeSingle()

      if (existing) {
        const existingTime = new Date(existing.updated_at).getTime()
        const incomingTime = new Date(input.updatedAt).getTime()
        // Nếu dữ liệu trên cloud mới hơn và tiến độ câu cao hơn hoặc bằng, không ghi đè dữ liệu cũ hơn
        if (existingTime > incomingTime && existing.completed_sentences >= input.completedSentences) {
          return { success: true, isStale: true }
        }
      }
    }

    const now = new Date().toISOString()
    const payload = {
      user_id: user.id,
      mode: input.mode,
      exercise_id: input.exerciseId,
      current_sentence_index: Math.max(0, input.currentSentenceIndex),
      completed_sentences: Math.max(0, input.completedSentences),
      total_sentences: Math.max(1, input.totalSentences),
      correct_sentences: Math.max(0, input.correctSentences),
      error_sentences: Math.max(0, input.errorSentences),
      last_typed_length: Math.max(0, input.lastTypedLength),
      time_spent_seconds: Math.max(0, input.timeSpentSeconds),
      status: input.status,
      updated_at: now,
    }

    const { data, error } = await supabase
      .from('typing_progress')
      .upsert(payload, {
        onConflict: 'user_id,mode,exercise_id',
      })
      .select()
      .single()

    if (error) {
      return { success: false, error: error.message }
    }

    return { success: true, data }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi lưu tiến độ' }
  }
}

/**
 * 3. Ghi nhận hoặc cập nhật câu gõ sai (Chống trùng lặp với ON CONFLICT)
 */
export async function recordTypingMistakeAction(input: TypingMistakeDTO) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return { success: false, isGuest: true }
    }

    const now = new Date().toISOString()

    // Kiểm tra xem câu này đã tồn tại trong danh sách câu sai chưa
    const { data: existing, error: fetchErr } = await supabase
      .from('typing_mistakes')
      .select('id, mistake_count, review_status')
      .eq('user_id', user.id)
      .eq('mode', input.mode)
      .eq('exercise_id', input.exerciseId)
      .eq('sentence_index', input.sentenceIndex)
      .maybeSingle()

    if (fetchErr) {
      return { success: false, error: fetchErr.message }
    }

    if (existing) {
      // Đã từng sai câu này -> Cập nhật tăng số lần sai, ghi nhận nội dung sai mới nhất, reset về need_review
      const { data, error: updateErr } = await supabase
        .from('typing_mistakes')
        .update({
          sentence_zh: input.sentenceZh,
          pinyin: input.pinyin || null,
          meaning_vi: input.meaningVi || null,
          last_input_zh: input.lastInputZh,
          mistake_details: input.mistakeDetails,
          mistake_count: (existing.mistake_count || 1) + 1,
          review_status: 'need_review',
          consecutive_correct: 0,
          last_error_at: now,
          updated_at: now,
        })
        .eq('id', existing.id)
        .select()
        .single()

      if (updateErr) return { success: false, error: updateErr.message }
      return { success: true, data, isUpdate: true }
    }

    // Câu sai lần đầu -> Chèn bản ghi mới
    const { data, error: insertErr } = await supabase
      .from('typing_mistakes')
      .insert({
        user_id: user.id,
        mode: input.mode,
        exercise_id: input.exerciseId,
        sentence_index: input.sentenceIndex,
        sentence_zh: input.sentenceZh,
        pinyin: input.pinyin || null,
        meaning_vi: input.meaningVi || null,
        last_input_zh: input.lastInputZh,
        mistake_details: input.mistakeDetails,
        mistake_count: 1,
        review_status: 'need_review',
        review_count: 0,
        review_correct_count: 0,
        consecutive_correct: 0,
        last_error_at: now,
        created_at: now,
        updated_at: now,
      })
      .select()
      .single()

    if (insertErr) return { success: false, error: insertErr.message }
    return { success: true, data, isUpdate: false }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi ghi nhận câu sai' }
  }
}

/**
 * 4. Lấy danh sách câu sai phục vụ ôn tập
 */
export async function getTypingMistakesAction(filter?: {
  mode?: string
  reviewStatus?: ReviewStatus | 'all'
}) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return { success: false, isGuest: true, mistakes: [] }
    }

    let query = supabase
      .from('typing_mistakes')
      .select('*')
      .eq('user_id', user.id)

    if (filter?.mode && filter.mode !== 'all') {
      query = query.eq('mode', filter.mode)
    }

    if (filter?.reviewStatus && filter.reviewStatus !== 'all') {
      query = query.eq('review_status', filter.reviewStatus)
    }

    const { data, error } = await query.order('last_error_at', { ascending: false })

    if (error) {
      return { success: false, error: error.message, isGuest: false, mistakes: [] }
    }

    const mapped: TypingMistakeDTO[] = (data || []).map((row) => ({
      id: row.id,
      mode: row.mode,
      exerciseId: row.exercise_id,
      sentenceIndex: row.sentence_index,
      sentenceZh: row.sentence_zh,
      pinyin: row.pinyin,
      meaningVi: row.meaning_vi,
      lastInputZh: row.last_input_zh,
      mistakeDetails: row.mistake_details || [],
      mistakeCount: row.mistake_count,
      reviewStatus: row.review_status,
      reviewCount: row.review_count,
      reviewCorrectCount: row.review_correct_count,
      consecutiveCorrect: row.consecutive_correct,
      lastErrorAt: row.last_error_at,
      lastReviewedAt: row.last_reviewed_at,
    }))

    return { success: true, isGuest: false, mistakes: mapped }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi tải danh sách câu sai', isGuest: false, mistakes: [] }
  }
}

/**
 * 5. Cập nhật kết quả một lượt ôn tập câu sai
 * Quy tắc: gõ đúng 2 lần liên tiếp -> 'mastered' (Đã thành thạo)
 */
export async function updateMistakeReviewResultAction(mistakeId: string, isCorrect: boolean) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return { success: false, isGuest: true }
    }

    const { data: current, error: getErr } = await supabase
      .from('typing_mistakes')
      .select('*')
      .eq('id', mistakeId)
      .eq('user_id', user.id)
      .single()

    if (getErr || !current) {
      return { success: false, error: 'Không tìm thấy câu sai' }
    }

    const now = new Date().toISOString()
    const newReviewCount = (current.review_count || 0) + 1

    let newReviewCorrectCount = current.review_correct_count || 0
    let newConsecutive = current.consecutive_correct || 0
    let newStatus: ReviewStatus = current.review_status

    if (isCorrect) {
      newReviewCorrectCount += 1
      newConsecutive += 1
      // Đạt 2 lần đúng liên tiếp -> Thành thạo, nếu 1 lần -> Đang luyện
      newStatus = newConsecutive >= 2 ? 'mastered' : 'reviewing'
    } else {
      newConsecutive = 0
      newStatus = 'need_review'
    }

    const { data, error: updateErr } = await supabase
      .from('typing_mistakes')
      .update({
        review_count: newReviewCount,
        review_correct_count: newReviewCorrectCount,
        consecutive_correct: newConsecutive,
        review_status: newStatus,
        last_reviewed_at: now,
        updated_at: now,
      })
      .eq('id', mistakeId)
      .select()
      .single()

    if (updateErr) return { success: false, error: updateErr.message }

    return { success: true, data, newStatus }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi cập nhật ôn tập' }
  }
}

/**
 * 6. Đổi trạng thái câu sai thủ công (ví dụ đánh dấu "Đã thành thạo" hoặc "Cần ôn lại")
 */
export async function updateMistakeStatusAction(mistakeId: string, status: ReviewStatus) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return { success: false, isGuest: true }
    }

    const { data, error } = await supabase
      .from('typing_mistakes')
      .update({
        review_status: status,
        updated_at: new Date().toISOString(),
      })
      .eq('id', mistakeId)
      .eq('user_id', user.id)
      .select()
      .single()

    if (error) return { success: false, error: error.message }
    return { success: true, data }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi cập nhật trạng thái' }
  }
}

/**
 * 7. Bắt đầu lại tiến độ bài học (reset chỉ số bài mà KHÔNG xóa câu sai)
 */
export async function resetTypingProgressAction(mode: string, exerciseId: string) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return { success: false, isGuest: true }
    }

    const { data, error } = await supabase
      .from('typing_progress')
      .update({
        current_sentence_index: 0,
        completed_sentences: 0,
        correct_sentences: 0,
        error_sentences: 0,
        last_typed_length: 0,
        status: 'not_started',
        updated_at: new Date().toISOString(),
      })
      .eq('user_id', user.id)
      .eq('mode', mode)
      .eq('exercise_id', exerciseId)
      .select()
      .maybeSingle()

    if (error) return { success: false, error: error.message }
    return { success: true, data }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi làm lại bài' }
  }
}

/**
 * 8. Đồng bộ an toàn dữ liệu từ localStorage khi người dùng đăng nhập
 */
export async function syncLocalTypingDataAction(localData: {
  progressList: TypingProgressDTO[]
  mistakeList: TypingMistakeDTO[]
}) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return { success: false, error: 'Chưa đăng nhập' }
    }

    // 1. Đồng bộ tiến độ
    for (const p of localData.progressList || []) {
      await saveTypingProgressAction(p)
    }

    // 2. Đồng bộ câu sai
    for (const m of localData.mistakeList || []) {
      await recordTypingMistakeAction(m)
    }

    return { success: true }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi đồng bộ dữ liệu' }
  }
}

/**
 * 8. Lấy danh sách bài tập HSK theo cấp và bài học trên server
 * Tránh việc import trực tiếp file 1.73MB hsk-typing-vocabularies.ts vào client bundle
 */
export async function getHskTypingExercisesAction(
  hskLevel: number,
  lessonNumber?: number,
  target: 'word' | 'example' = 'example'
) {
  try {
    const { getHskWordsByLevel } = await import('@/data/hsk-typing-vocabularies')
    const words = getHskWordsByLevel(hskLevel, {
      lesson: lessonNumber && lessonNumber > 0 ? lessonNumber : undefined,
    })
    const isExampleMode = target === 'example'
    return {
      success: true,
      data: words.map((w) => ({
        id: isExampleMode ? `hsk-${w.id}-ex` : `hsk-${w.id}`,
        titleZh: isExampleMode ? `${w.hanzi} [${w.pinyin}]` : `Từ vựng HSK ${w.hskLevel}`,
        titleVi: w.meaning,
        hanzi: isExampleMode ? (w.exampleHanzi || w.hanzi) : w.hanzi,
        pinyin: isExampleMode ? (w.examplePinyin || w.pinyin) : w.pinyin,
        meaning: isExampleMode ? (w.exampleVi || w.meaning) : w.meaning,
        mode: 'hsk' as const,
        hskLevel: w.hskLevel,
        level: `HSK ${w.hskLevel} - Bài ${w.lessonNumber}`,
        category: w.category,
        difficulty: (w.hskLevel <= 2 ? 'easy' : w.hskLevel <= 4 ? 'medium' : 'hard') as 'easy' | 'medium' | 'hard',
        exampleHanzi: w.exampleHanzi,
        examplePinyin: w.examplePinyin,
        exampleVi: w.exampleVi,
      })),
    }
  } catch (err: any) {
    console.error('getHskTypingExercisesAction error:', err)
    return { success: false, data: [] }
  }
}

