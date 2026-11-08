'use server'

import { createClient, getCachedAuthUser } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export interface VocabularyItem {
  id: string
  hanzi: string
  pinyin: string
  meaning_vi: string
  word_type?: string | null
  hsk_level?: string | null
  example_hanzi?: string | null
  example_pinyin?: string | null
  example_vi?: string | null
  isSaved?: boolean
}

export interface SearchVocabParams {
  search?: string
  hskLevel?: string
  topic?: string
  page?: number
  pageSize?: number
}

export interface SearchVocabResult {
  success: boolean
  vocabs: VocabularyItem[]
  totalCount: number
  page: number
  pageSize: number
  totalPages: number
  error?: string
}

export interface VocabularyOverview {
  totalCount: number
  countsByLevel: Record<string, number>
}

// Danh sách từ khóa lọc theo 9 chủ đề 3D
const TOPIC_KEYWORD_MAP: Record<string, string[]> = {
  family: ['gia đình', 'ba', 'mẹ', 'ông', 'bà', 'anh', 'chị', 'em', 'bố', 'mẹ', 'con', 'chồng', 'vợ'],
  daily: ['ăn', 'uống', 'ngủ', 'dậy', 'nói', 'xem', 'nghe', 'đi', 'đến', 'mua', 'bán', 'rửa'],
  school: ['học', 'trường', 'sách', 'bút', 'giáo viên', 'thầy', 'cô', 'lớp', 'bài tập', 'thi', 'đọc'],
  food: ['thực', 'cơm', 'trà', 'nước', 'thịt', 'rau', 'hoa quả', 'táo', 'bánh', 'quán', 'món'],
  jobs: ['làm', 'công việc', 'công ty', 'bác sĩ', 'kỹ sư', 'nhân viên', 'giám đốc', 'tiền', 'lương'],
  travel: ['đi', 'xe', 'tàu', 'máy bay', 'sân bay', 'vé', 'khách sạn', 'du lịch', 'đường', 'bến'],
  home: ['nhà', 'phòng', 'bàn', 'ghế', 'cửa', 'giường', 'bếp', 'tủ', 'đèn', 'quạt'],
  weather: ['trời', 'mưa', 'nắng', 'gió', 'tuyết', 'nóng', 'lạnh', 'ấm', 'mát', 'thời tiết'],
  animals: ['con', 'chó', 'mèo', 'chim', 'cá', 'ngựa', 'bò', 'gà', 'vịt', 'hổ', 'gấu'],
}

/**
 * Server Action: Tìm kiếm và phân trang kho từ vựng HSK 3.0
 */
export async function searchVocabulariesAction(params: SearchVocabParams): Promise<SearchVocabResult> {
  try {
    const supabase = await createClient()
    const user = await getCachedAuthUser()

    const page = Math.max(1, params.page || 1)
    const pageSize = Math.max(8, Math.min(60, params.pageSize || 24))
    const from = (page - 1) * pageSize
    const to = from + pageSize - 1

    let query = supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi', { count: 'exact' })

    // 1. Lọc theo cấp độ HSK
    if (params.hskLevel && params.hskLevel !== 'all') {
      query = query.eq('hsk_level', params.hskLevel)
      if (params.hskLevel === 'HSK 6') {
        query = query.in('validation_status', ['matched_target_syllabus', 'verified_target_syllabus', 'needs_tone_sense_review'])
      }
    }

    // 2. Lọc theo từ khóa tìm kiếm (hỗ trợ Chữ Hán, Pinyin và Tiếng Việt)
    if (params.search && params.search.trim()) {
      const q = params.search.trim().replace(/['"]/g, '')
      query = query.or(`hanzi.ilike.%${q}%,pinyin.ilike.%${q}%,meaning_vi.ilike.%${q}%`)
    }

    // 3. Lọc theo chủ đề 3D
    if (params.topic && params.topic !== 'all' && TOPIC_KEYWORD_MAP[params.topic]) {
      const keywords = TOPIC_KEYWORD_MAP[params.topic]
      const topicFilters = keywords.map((k) => `meaning_vi.ilike.%${k}%`).join(',')
      query = query.or(topicFilters)
    }

    // Sắp xếp thứ tự
    const { data, count, error } = await query
      .order('pinyin', { ascending: true })
      .range(from, to)

    if (error) {
      console.error('Lỗi truy vấn từ vựng:', error)
      return {
        success: false,
        vocabs: [],
        totalCount: 0,
        page,
        pageSize,
        totalPages: 0,
        error: error.message,
      }
    }

    const rawList = (data || []) as VocabularyItem[]
    const totalCount = count || 0
    const totalPages = Math.ceil(totalCount / pageSize) || 1

    // Kiểm tra các từ người dùng đã lưu vào sổ ôn tập SM-2
    let savedVocabIds = new Set<string>()
    if (user && rawList.length > 0) {
      const vocabIds = rawList.map((v) => v.id)
      const { data: savedData } = await supabase
        .from('user_vocabularies')
        .select('vocabulary_id')
        .eq('user_id', user.id)
        .in('vocabulary_id', vocabIds)

      if (savedData) {
        savedVocabIds = new Set(savedData.map((s) => s.vocabulary_id))
      }
    }

    const vocabs: VocabularyItem[] = rawList.map((item) => ({
      ...item,
      isSaved: savedVocabIds.has(item.id),
    }))

    return {
      success: true,
      vocabs,
      totalCount,
      page,
      pageSize,
      totalPages,
    }
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : 'Lỗi không xác định khi tra từ'
    return {
      success: false,
      vocabs: [],
      totalCount: 0,
      page: 1,
      pageSize: 24,
      totalPages: 0,
      error: message,
    }
  }
}

/**
 * Server Action: Lấy thống kê số lượng từ theo từng cấp độ
 */
export async function getVocabularyOverviewAction(): Promise<VocabularyOverview> {
  try {
    const supabase = await createClient()

    const { data, count } = await supabase
      .from('vocabularies')
      .select('hsk_level', { count: 'exact' })

    const countsByLevel: Record<string, number> = {}
    if (data) {
      for (const item of data) {
        const lvl = item.hsk_level || 'Chưa phân loại'
        countsByLevel[lvl] = (countsByLevel[lvl] || 0) + 1
      }
    }

    return {
      totalCount: count || 0,
      countsByLevel,
    }
  } catch (err) {
    console.error('Lỗi lấy thống kê kho từ vựng:', err)
    return {
      totalCount: 0,
      countsByLevel: {},
    }
  }
}

/**
 * Server Action: Lưu hoặc Hủy lưu từ vựng vào sổ cá nhân (Spaced Repetition SM-2)
 */
export async function toggleSaveVocabularyAction(vocabularyId: string): Promise<{ success: boolean; isSaved: boolean; error?: string }> {
  try {
    const supabase = await createClient()
    const user = await getCachedAuthUser()

    if (!user) {
      return { success: false, isSaved: false, error: 'Vui lòng đăng nhập để lưu từ vựng vào sổ tay ôn tập.' }
    }

    // Kiểm tra xem đã lưu chưa
    const { data: existing } = await supabase
      .from('user_vocabularies')
      .select('id')
      .eq('user_id', user.id)
      .eq('vocabulary_id', vocabularyId)
      .maybeSingle()

    if (existing) {
      // Đã lưu -> Hủy lưu
      const { error: delError } = await supabase
        .from('user_vocabularies')
        .delete()
        .eq('id', existing.id)

      if (delError) throw delError

      revalidatePath('/vocabulary')
      revalidatePath('/review')
      return { success: true, isSaved: false }
    } else {
      // Chưa lưu -> Thêm mới vào chu trình ôn tập SM-2
      const { error: insertError } = await supabase
        .from('user_vocabularies')
        .insert({
          user_id: user.id,
          vocabulary_id: vocabularyId,
          status: 'learning',
          repetitions: 0,
          review_interval_days: 1,
          ease_factor: 2.5,
          next_review_at: new Date().toISOString(),
        })

      if (insertError) throw insertError

      revalidatePath('/vocabulary')
      revalidatePath('/review')
      return { success: true, isSaved: true }
    }
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : 'Không thể lưu từ vựng'
    return { success: false, isSaved: false, error: message }
  }
}

