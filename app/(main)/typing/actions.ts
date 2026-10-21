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
 * 8. Lấy danh sách bài tập HSK trực tiếp từ Supabase Database (vocabulary_examples + vocabularies)
 * Có cơ chế fallback về static file cho HSK 6 hoặc khi offline
 */
export async function getHskTypingExercisesAction(
  hskLevel: number,
  lessonNumber?: number,
  target: 'word' | 'example' = 'example'
) {
  try {
    // 1. Đối với HSK 1 đến HSK 5: Ưu tiên truy vấn trực tiếp từ Supabase
    if (hskLevel >= 1 && hskLevel <= 5) {
      let lessonId: string | undefined = undefined

      if (lessonNumber && lessonNumber > 0) {
        const supabase = await createClient()
        const { data: lesson } = await supabase
          .from('lessons')
          .select('id')
          .eq('hsk_level', `HSK ${hskLevel}`)
          .eq('lesson_number', lessonNumber)
          .eq('is_system', true)
          .maybeSingle()

        if (lesson?.id) {
          lessonId = lesson.id
        }
      }

      const dbRes = await getTypingExercisesFromDBAction({
        hskLevel,
        lessonId,
        limit: 50,
      })

      if (dbRes.success && dbRes.data && dbRes.data.length > 0) {
        return {
          success: true,
          data: dbRes.data.map((item) => ({
            ...item,
            id: target === 'word' && item.wordHanzi ? `w-${item.id}` : item.id,
            hanzi: target === 'word' && item.wordHanzi ? item.wordHanzi : item.hanzi,
            pinyin: target === 'word' && item.wordPinyin ? item.wordPinyin : item.pinyin,
            meaning: target === 'word' && item.wordMeaning ? item.wordMeaning : item.meaning,
          })),
        }
      }
    }

    // 2. Fallback sang dữ liệu tĩnh nếu HSK 6 hoặc truy vấn DB không có dữ liệu
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

/**
 * 9. Lấy danh sách bài học hệ thống từ DB phục vụ bộ lọc Luyện đánh máy
 */
export async function getSystemLessonsForTypingAction(hskLevel: number) {
  try {
    const supabase = await createClient()
    const { data: lessons, error } = await supabase
      .from('lessons')
      .select('id, lesson_number, title, subtitle, hsk_level')
      .eq('hsk_level', `HSK ${hskLevel}`)
      .eq('is_system', true)
      .order('lesson_number', { ascending: true })

    if (error || !lessons) {
      return { success: false, data: [] }
    }

    return {
      success: true,
      data: lessons.map((l) => ({
        id: l.id,
        lessonNumber: l.lesson_number ?? 0,
        title: l.title,
        subtitle: l.subtitle || '',
        hskLevel,
      })),
    }
  } catch (err: any) {
    console.error('getSystemLessonsForTypingAction error:', err)
    return { success: false, data: [] }
  }
}

/**
 * 10. Lấy bài tập luyện đánh máy trực tiếp từ Supabase (vocabulary_examples + vocabularies)
 * Không duplicate dữ liệu, tận dụng 100% câu ví dụ song ngữ đã có sẵn
 */
export interface DBTypingExerciseItem {
  id: string
  exampleId?: string
  vocabId?: string
  titleZh: string
  titleVi: string
  hanzi: string
  pinyin: string
  meaning: string
  mode: 'hsk' | 'lesson' | 'unlearned'
  hskLevel?: number
  level: string
  category?: string
  wordHanzi?: string
  wordPinyin?: string
  wordMeaning?: string
  difficulty: 'easy' | 'medium' | 'hard'
  exampleHanzi?: string
  examplePinyin?: string
  exampleVi?: string
}

export async function getTypingExercisesFromDBAction(params: {
  hskLevel?: number
  lessonId?: string
  onlyUnlearned?: boolean
  limit?: number
}) {
  try {
    const supabase = await createClient()
    const limit = params.limit || 30
    const hskTag = params.hskLevel ? `HSK ${params.hskLevel}` : undefined

    // 1. Trường hợp theo bài học cụ thể (Lesson ID)
    if (params.lessonId) {
      const { data: lessonData } = await supabase
        .from('lessons')
        .select('title, lesson_number, hsk_level')
        .eq('id', params.lessonId)
        .maybeSingle()

      const lessonTitle = lessonData?.title || 'Bài học'

      const { data, error } = await supabase
        .from('lesson_vocabularies')
        .select(`
          sort_order,
          vocabularies!inner(
            id,
            hanzi,
            pinyin,
            meaning_vi,
            hsk_level,
            example_hanzi,
            example_pinyin,
            example_vi,
            vocabulary_examples(id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
          )
        `)
        .eq('lesson_id', params.lessonId)
        .order('sort_order', { ascending: true })

      if (error || !data) {
        return { success: false, data: [] }
      }

      const exercises: DBTypingExerciseItem[] = []
      for (const item of data) {
        const v = item.vocabularies as any
        if (!v) continue
        const examples = (v.vocabulary_examples as any[]) || []
        // Sắp xếp ví dụ câu cơ bản trước, ứng dụng sau
        examples.sort((a, b) => (a.order_index || 1) - (b.order_index || 1))

        if (examples.length > 0) {
          for (const ex of examples) {
            exercises.push({
              id: `db-ex-${ex.id}`,
              exampleId: ex.id,
              vocabId: v.id,
              titleZh: `${v.hanzi} [${v.pinyin}]`,
              titleVi: v.meaning_vi,
              hanzi: ex.chinese,
              pinyin: ex.pinyin,
              meaning: ex.meaning_vi,
              mode: 'lesson',
              hskLevel: params.hskLevel,
              level: `${lessonTitle} (Từ: ${v.hanzi})`,
              category: lessonTitle,
              wordHanzi: v.hanzi,
              wordPinyin: v.pinyin,
              wordMeaning: v.meaning_vi,
              difficulty: ex.difficulty_level === 'basic' ? 'easy' : 'medium',
              exampleHanzi: ex.chinese,
              examplePinyin: ex.pinyin,
              exampleVi: ex.meaning_vi,
            })
          }
        } else if (v.example_hanzi) {
          exercises.push({
            id: `db-v-${v.id}`,
            vocabId: v.id,
            titleZh: `${v.hanzi} [${v.pinyin}]`,
            titleVi: v.meaning_vi,
            hanzi: v.example_hanzi,
            pinyin: v.example_pinyin || v.pinyin,
            meaning: v.example_vi || v.meaning_vi,
            mode: 'lesson',
            hskLevel: params.hskLevel,
            level: `${lessonTitle} (Từ: ${v.hanzi})`,
            category: lessonTitle,
            wordHanzi: v.hanzi,
            wordPinyin: v.pinyin,
            wordMeaning: v.meaning_vi,
            difficulty: 'easy',
            exampleHanzi: v.example_hanzi,
            examplePinyin: v.example_pinyin,
            exampleVi: v.example_vi,
          })
        }
      }

      return { success: true, data: exercises }
    }

    // 2. Trường hợp từ vựng chưa thành thạo (Unlearned / Review)
    if (params.onlyUnlearned) {
      const { data: { user } } = await supabase.auth.getUser()
      if (user) {
        let uvQuery = supabase
          .from('user_vocabularies')
          .select(`
            vocabulary_id,
            vocabularies!inner(
              id,
              hanzi,
              pinyin,
              meaning_vi,
              hsk_level,
              example_hanzi,
              example_pinyin,
              example_vi,
              vocabulary_examples(id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
            )
          `)
          .eq('user_id', user.id)
          .eq('status', 'learning')
          .limit(limit)

        if (hskTag) {
          uvQuery = uvQuery.eq('vocabularies.hsk_level', hskTag)
        }

        const { data: uvData } = await uvQuery
        if (uvData && uvData.length > 0) {
          const exercises: DBTypingExerciseItem[] = []
          for (const item of uvData) {
            const v = item.vocabularies as any
            if (!v) continue
            const examples = (v.vocabulary_examples as any[]) || []
            const ex = examples[0]
            if (ex) {
              exercises.push({
                id: `db-ex-${ex.id}`,
                exampleId: ex.id,
                vocabId: v.id,
                titleZh: `${v.hanzi} [${v.pinyin}]`,
                titleVi: v.meaning_vi,
                hanzi: ex.chinese,
                pinyin: ex.pinyin,
                meaning: ex.meaning_vi,
                mode: 'unlearned',
                hskLevel: params.hskLevel,
                level: `Cần ôn luyện: ${v.hanzi}`,
                category: 'Từ chưa thuộc',
                wordHanzi: v.hanzi,
                wordPinyin: v.pinyin,
                wordMeaning: v.meaning_vi,
                difficulty: 'medium',
                exampleHanzi: ex.chinese,
                examplePinyin: ex.pinyin,
                exampleVi: ex.meaning_vi,
              })
            } else if (v.example_hanzi) {
              exercises.push({
                id: `db-v-${v.id}`,
                vocabId: v.id,
                titleZh: `${v.hanzi} [${v.pinyin}]`,
                titleVi: v.meaning_vi,
                hanzi: v.example_hanzi,
                pinyin: v.example_pinyin || v.pinyin,
                meaning: v.example_vi || v.meaning_vi,
                mode: 'unlearned',
                hskLevel: params.hskLevel,
                level: `Cần ôn luyện: ${v.hanzi}`,
                category: 'Từ chưa thuộc',
                wordHanzi: v.hanzi,
                wordPinyin: v.pinyin,
                wordMeaning: v.meaning_vi,
                difficulty: 'easy',
                exampleHanzi: v.example_hanzi,
                examplePinyin: v.example_pinyin,
                exampleVi: v.example_vi,
              })
            }
          }
          if (exercises.length > 0) {
            return { success: true, data: exercises }
          }
        }
      }
    }

    // 3. Mặc định theo Cấp độ HSK (HSK 1 - 5)
    let query = supabase
      .from('vocabulary_examples')
      .select(`
        id,
        chinese,
        pinyin,
        meaning_vi,
        difficulty_level,
        order_index,
        vocabularies!inner(
          id,
          hanzi,
          pinyin,
          meaning_vi,
          hsk_level
        )
      `)
      .order('order_index', { ascending: true })
      .limit(limit)

    if (hskTag) {
      query = query.eq('vocabularies.hsk_level', hskTag)
    }

    const { data: exData } = await query
    const exercises: DBTypingExerciseItem[] = []

    if (exData && exData.length > 0) {
      for (const row of exData as any[]) {
        const v = row.vocabularies
        if (!v) continue
        exercises.push({
          id: `db-ex-${row.id}`,
          exampleId: row.id,
          vocabId: v.id,
          titleZh: `${v.hanzi} [${v.pinyin}]`,
          titleVi: v.meaning_vi,
          hanzi: row.chinese,
          pinyin: row.pinyin,
          meaning: row.meaning_vi,
          mode: 'hsk',
          hskLevel: params.hskLevel,
          level: `${v.hsk_level} • ${v.hanzi}`,
          category: v.hsk_level,
          wordHanzi: v.hanzi,
          wordPinyin: v.pinyin,
          wordMeaning: v.meaning_vi,
          difficulty: row.difficulty_level === 'basic' ? 'easy' : 'medium',
          exampleHanzi: row.chinese,
          examplePinyin: row.pinyin,
          exampleVi: row.meaning_vi,
        })
      }
    }

    // Nếu số lượng câu từ bảng ví dụ chưa đủ limit, bù đắp từ câu ví dụ inline trong bảng vocabularies
    if (exercises.length < limit && hskTag) {
      const existingVocabIds = new Set(exercises.map(e => e.vocabId))
      const { data: fallbackVocabs } = await supabase
        .from('vocabularies')
        .select('id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi')
        .eq('hsk_level', hskTag)
        .not('example_hanzi', 'is', null)
        .limit(limit * 2)

      if (fallbackVocabs) {
        for (const fv of fallbackVocabs) {
          if (!fv.example_hanzi || existingVocabIds.has(fv.id)) continue
          exercises.push({
            id: `db-v-${fv.id}`,
            vocabId: fv.id,
            titleZh: `${fv.hanzi} [${fv.pinyin}]`,
            titleVi: fv.meaning_vi,
            hanzi: fv.example_hanzi,
            pinyin: fv.example_pinyin || fv.pinyin,
            meaning: fv.example_vi || fv.meaning_vi,
            mode: 'hsk',
            hskLevel: params.hskLevel,
            level: `${fv.hsk_level} • ${fv.hanzi}`,
            category: fv.hsk_level,
            wordHanzi: fv.hanzi,
            wordPinyin: fv.pinyin,
            wordMeaning: fv.meaning_vi,
            difficulty: 'easy',
            exampleHanzi: fv.example_hanzi,
            examplePinyin: fv.example_pinyin,
            exampleVi: fv.example_vi,
          })
          existingVocabIds.add(fv.id)
          if (exercises.length >= limit) break
        }
      }
    }

    return { success: exercises.length > 0, data: exercises }
  } catch (err: any) {
    console.error('getTypingExercisesFromDBAction error:', err)
    return { success: false, data: [] }
  }
}


