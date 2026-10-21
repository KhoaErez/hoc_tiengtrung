'use server'

import { createClient } from '@/lib/supabase/server'

export interface VocabExampleItem {
  id?: string
  chinese: string
  pinyin: string
  meaning_vi: string
  difficulty_level?: 'basic' | 'applied' | 'standard'
  order_index?: number
}

export interface TopicVocabItem {
  id: string
  hanzi: string
  pinyin: string
  meaning_vi: string
  word_type?: string | null
  hsk_level?: string | null
  example_hanzi?: string | null
  example_pinyin?: string | null
  example_vi?: string | null
  examples?: VocabExampleItem[]
}

export interface GetTopicVocabulariesResponse {
  success: boolean
  vocabs: TopicVocabItem[]
  totalCount: number
  page: number
  pageSize: number
  hasMore: boolean
  error?: string
}

/**
 * Tải danh sách từ vựng theo phân trang và tìm kiếm cho cấp độ HSK
 * Giúp triệt tiêu tải hàng ngàn từ vựng cùng lúc vào payload SSR ban đầu
 */
export async function getTopicVocabulariesAction(params: {
  hskLevel: string
  page?: number
  pageSize?: number
  search?: string
}): Promise<GetTopicVocabulariesResponse> {
  try {
    const supabase = await createClient()
    const page = Math.max(1, params.page || 1)
    const pageSize = Math.max(10, Math.min(100, params.pageSize || 30))
    const from = (page - 1) * pageSize
    const to = from + pageSize - 1

    let query = supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi', { count: 'exact' })
      .eq('hsk_level', params.hskLevel)

    if (params.search && params.search.trim()) {
      const q = params.search.trim()
      query = query.or(`hanzi.ilike.%${q}%,pinyin.ilike.%${q}%,meaning_vi.ilike.%${q}%`)
    }

    const { data, count, error } = await query
      .order('id', { ascending: true })
      .range(from, to)

    if (error) {
      return {
        success: false,
        vocabs: [],
        totalCount: 0,
        page,
        pageSize,
        hasMore: false,
        error: error.message,
      }
    }

    const vocabList = data || []
    const vocabIds = vocabList.map((d) => d.id)

    // Tải câu ví dụ đa dạng từ bảng vocabulary_examples nếu đã có
    const examplesMap = new Map<string, VocabExampleItem[]>()
    if (vocabIds.length > 0) {
      try {
        const { data: exData, error: exErr } = await supabase
          .from('vocabulary_examples')
          .select('id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index')
          .in('vocabulary_id', vocabIds)
          .order('order_index', { ascending: true })

        if (!exErr && exData) {
          exData.forEach((ex: any) => {
            const list = examplesMap.get(ex.vocabulary_id) || []
            list.push({
              id: ex.id,
              chinese: ex.chinese,
              pinyin: ex.pinyin,
              meaning_vi: ex.meaning_vi,
              difficulty_level: ex.difficulty_level || 'standard',
              order_index: ex.order_index,
            })
            examplesMap.set(ex.vocabulary_id, list)
          })
        }
      } catch {
        // Fallback an toàn nếu bảng chưa được tạo
      }
    }

    const totalCount = count || 0
    return {
      success: true,
      vocabs: vocabList.map((row) => {
        let examples = examplesMap.get(row.id) || []
        // Nếu chưa có trong bảng vocabulary_examples nhưng có example_hanzi ở vocabularies, tạo 1 câu ví dụ
        if (examples.length === 0 && row.example_hanzi) {
          examples = [
            {
              chinese: row.example_hanzi,
              pinyin: row.example_pinyin || '',
              meaning_vi: row.example_vi || '',
              difficulty_level: 'basic',
              order_index: 1,
            },
          ]
        }

        return {
          id: row.id,
          hanzi: row.hanzi,
          pinyin: row.pinyin,
          meaning_vi: row.meaning_vi,
          word_type: row.word_type || null,
          hsk_level: row.hsk_level || null,
          example_hanzi: row.example_hanzi,
          example_pinyin: row.example_pinyin,
          example_vi: row.example_vi,
          examples,
        }
      }),
      totalCount,
      page,
      pageSize,
      hasMore: totalCount > to + 1,
    }
  } catch (err: any) {
    return {
      success: false,
      vocabs: [],
      totalCount: 0,
      page: params.page || 1,
      pageSize: params.pageSize || 30,
      hasMore: false,
      error: err?.message || 'Lỗi khi tải từ vựng',
    }
  }
}
