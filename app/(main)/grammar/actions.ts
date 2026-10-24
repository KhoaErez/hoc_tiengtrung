'use server'

import { createClient } from '@/lib/supabase/server'
import { ALL_HSK_GRAMMAR_DATA, type GrammarPointItem } from '@/data/hsk-grammar-full-data'

export interface GrammarItemWithExamples extends GrammarPointItem {
  id?: string
  source?: string
  validation_status?: string
}

export interface GrammarCategoryCount {
  name: string
  count: number
}

export interface GetGrammarPointsParams {
  level?: string
  page?: number
  pageSize?: number
  category?: string
  search?: string
  masteredFilter?: 'all' | 'unmastered' | 'mastered'
  masteredIndices?: number[]
}

export interface PaginatedGrammarResponse {
  success: boolean
  data: GrammarItemWithExamples[]
  totalCount: number
  page: number
  pageSize: number
  totalPages: number
  categories: GrammarCategoryCount[]
  isFromDb: boolean
  error?: string
}

/**
 * 1. Phân trang Server-side cho Điểm ngữ pháp HSK 1–6
 * Hỗ trợ tìm kiếm theo Tiếng Việt, Chữ Hán, Pinyin, Công thức
 * Hỗ trợ lọc theo Cấp độ, Thể loại, Đã học / Chưa học
 */
export async function getGrammarPointsPaginatedAction(
  params: GetGrammarPointsParams
): Promise<PaginatedGrammarResponse> {
  const level = params.level || 'HSK 1'
  const page = Math.max(1, params.page || 1)
  const pageSize = Math.max(5, Math.min(50, params.pageSize || 10))
  const category = params.category || 'all'
  const searchQuery = (params.search || '').trim().toLowerCase()
  const masteredFilter = params.masteredFilter || 'all'
  const masteredIndices = params.masteredIndices || []

  // Nếu người dùng chọn lọc "Đã học" nhưng chưa đánh dấu điểm nào
  if (masteredFilter === 'mastered' && masteredIndices.length === 0) {
    const allFallbackForLevel = ALL_HSK_GRAMMAR_DATA[level] || []
    const catMap = new Map<string, number>()
    allFallbackForLevel.forEach((p) => {
      catMap.set(p.category, (catMap.get(p.category) || 0) + 1)
    })
    return {
      success: true,
      data: [],
      totalCount: 0,
      page: 1,
      pageSize,
      totalPages: 0,
      categories: Array.from(catMap.entries()).map(([name, count]) => ({ name, count })),
      isFromDb: true,
    }
  }

  try {
    const supabase = await createClient()

    // 1. Tải toàn bộ danh mục của cấp độ hiện tại để render CategoryFilter chính xác
    const { data: allCategoriesData } = await supabase
      .from('grammar_points')
      .select('category')
      .eq('hsk_level', level)

    let categories: GrammarCategoryCount[] = []
    if (allCategoriesData && allCategoriesData.length > 0) {
      const catCountMap = new Map<string, number>()
      allCategoriesData.forEach((row: any) => {
        const cat = row.category || 'Khác'
        catCountMap.set(cat, (catCountMap.get(cat) || 0) + 1)
      })
      categories = Array.from(catCountMap.entries()).map(([name, count]) => ({ name, count }))
    }

    // 2. Tìm kiếm trong câu ví dụ (Chữ Hán, Pinyin, Dịch nghĩa) nếu có query
    let matchingExamplePointIds: string[] = []
    if (searchQuery) {
      try {
        const { data: exMatches } = await supabase
          .from('grammar_examples')
          .select('grammar_point_id, grammar_points!inner(hsk_level)')
          .eq('grammar_points.hsk_level', level)
          .or(
            `chinese.ilike.%${searchQuery}%,pinyin.ilike.%${searchQuery}%,translation_vi.ilike.%${searchQuery}%`
          )
          .limit(100)

        if (exMatches && exMatches.length > 0) {
          matchingExamplePointIds = Array.from(
            new Set(exMatches.map((m: any) => m.grammar_point_id).filter(Boolean))
          )
        }
      } catch {
        // Ignored
      }
    }

    // 3. Xây dựng truy vấn phân trang
    let query = supabase
      .from('grammar_points')
      .select(
        `
        id,
        name,
        pattern,
        category,
        explanation_vi,
        hsk_level,
        order_index,
        source,
        validation_status,
        grammar_examples (
          id,
          chinese,
          pinyin,
          translation_vi,
          explanation
        )
      `,
        { count: 'exact' }
      )
      .eq('hsk_level', level)

    // Lọc theo danh mục
    if (category !== 'all') {
      query = query.eq('category', category)
    }

    // Lọc theo trạng thái Đã học / Chưa học
    if (masteredFilter === 'unmastered' && masteredIndices.length > 0) {
      // Loại trừ các order_index đã thuộc
      query = query.not('order_index', 'in', `(${masteredIndices.join(',')})`)
    } else if (masteredFilter === 'mastered' && masteredIndices.length > 0) {
      // Chỉ lấy các order_index đã thuộc
      query = query.in('order_index', masteredIndices)
    }

    // Lọc theo từ khóa tìm kiếm (Tiếng Việt, Thuật ngữ, Công thức, Chữ Hán / Pinyin)
    if (searchQuery) {
      if (matchingExamplePointIds.length > 0) {
        query = query.or(
          `name.ilike.%${searchQuery}%,pattern.ilike.%${searchQuery}%,explanation_vi.ilike.%${searchQuery}%,id.in.(${matchingExamplePointIds.join(
            ','
          )})`
        )
      } else {
        query = query.or(
          `name.ilike.%${searchQuery}%,pattern.ilike.%${searchQuery}%,explanation_vi.ilike.%${searchQuery}%`
        )
      }
    }

    const from = (page - 1) * pageSize
    const to = from + pageSize - 1

    const { data: dbPoints, count, error } = await query
      .order('order_index', { ascending: true })
      .range(from, to)

    if (!error && count !== null && allCategoriesData && allCategoriesData.length > 0) {
      const totalCount = count || 0
      const totalPages = Math.max(1, Math.ceil(totalCount / pageSize))

      const formatted: GrammarItemWithExamples[] = (dbPoints || []).map((item: any) => ({
        id: item.id,
        order_index: item.order_index ?? 1,
        name: item.name,
        pattern: item.pattern,
        category: item.category ?? 'Ngữ pháp cơ bản',
        explanation_vi: item.explanation_vi,
        hsk_level: item.hsk_level ?? level,
        source: item.source,
        validation_status: item.validation_status,
        examples: (item.grammar_examples || []).map((ex: any) => ({
          chinese: ex.chinese,
          pinyin: ex.pinyin || '',
          translation_vi: ex.translation_vi || '',
          explanation: ex.explanation || '',
        })),
      }))

      return {
        success: true,
        data: formatted,
        totalCount,
        page,
        pageSize,
        totalPages,
        categories,
        isFromDb: true,
      }
    }
  } catch (err) {
    console.warn('Lỗi kết nối Supabase grammar_points, kích hoạt fallback bộ nhớ tĩnh:', err)
  }

  // 4. Fallback dự phòng hoàn chỉnh từ bộ nhớ tĩnh ALL_HSK_GRAMMAR_DATA (HSK 1 - 6)
  const fullLevelItems = ALL_HSK_GRAMMAR_DATA[level] || []

  // Tính danh mục
  const catCountMap = new Map<string, number>()
  fullLevelItems.forEach((p) => {
    catCountMap.set(p.category, (catCountMap.get(p.category) || 0) + 1)
  })
  const fallbackCategories = Array.from(catCountMap.entries()).map(([name, count]) => ({
    name,
    count,
  }))

  // Lọc
  let filtered = fullLevelItems.filter((item) => {
    if (category !== 'all' && item.category !== category) return false
    if (masteredFilter === 'unmastered' && masteredIndices.includes(item.order_index)) return false
    if (masteredFilter === 'mastered' && !masteredIndices.includes(item.order_index)) return false
    if (searchQuery) {
      const matchName = item.name.toLowerCase().includes(searchQuery)
      const matchPattern = item.pattern.toLowerCase().includes(searchQuery)
      const matchExp = item.explanation_vi.toLowerCase().includes(searchQuery)
      const matchEx = item.examples.some(
        (ex) =>
          ex.chinese.toLowerCase().includes(searchQuery) ||
          ex.pinyin.toLowerCase().includes(searchQuery) ||
          ex.translation_vi.toLowerCase().includes(searchQuery)
      )
      return matchName || matchPattern || matchExp || matchEx
    }
    return true
  })

  const totalCount = filtered.length
  const totalPages = Math.max(1, Math.ceil(totalCount / pageSize))
  const safePage = Math.min(page, totalPages)
  const start = (safePage - 1) * pageSize
  const paginated = filtered.slice(start, start + pageSize)

  return {
    success: true,
    data: paginated,
    totalCount,
    page: safePage,
    pageSize,
    totalPages,
    categories: fallbackCategories,
    isFromDb: false,
  }
}

/**
 * 2. Lấy danh sách toàn bộ điểm ngữ pháp theo cấp độ (Dùng cho SSR / Initial State)
 */
export async function getGrammarPointsAction(level: string = 'HSK 1'): Promise<{
  success: boolean
  data: GrammarItemWithExamples[]
  isFromDb: boolean
  count: number
}> {
  const paginatedRes = await getGrammarPointsPaginatedAction({
    level,
    page: 1,
    pageSize: 10,
    category: 'all',
    masteredFilter: 'all',
  })

  return {
    success: paginatedRes.success,
    data: paginatedRes.data,
    isFromDb: paginatedRes.isFromDb,
    count: paginatedRes.totalCount,
  }
}

/**
 * 3. Thống kê tổng số điểm ngữ pháp theo từng cấp độ HSK 1–6
 */
export async function getGrammarLevelsOverviewAction(): Promise<Record<string, number>> {
  const result: Record<string, number> = {
    'HSK 1': 48,
    'HSK 2': 78,
    'HSK 3': 79,
    'HSK 4': 104,
    'HSK 5': 110,
    'HSK 6': 123,
  }

  try {
    const supabase = await createClient()
    const { data, error } = await supabase.from('grammar_points').select('hsk_level')

    if (!error && data && data.length > 0) {
      const liveCounts: Record<string, number> = {}
      for (const row of data) {
        const lvl = row.hsk_level
        if (lvl) {
          liveCounts[lvl] = (liveCounts[lvl] || 0) + 1
        }
      }
      for (const lvl of Object.keys(result)) {
        if (typeof liveCounts[lvl] === 'number') {
          result[lvl] = liveCounts[lvl]
        }
      }
    }
  } catch (err) {
    console.warn('Lỗi khi lấy thống kê cấp độ ngữ pháp từ DB:', err)
  }

  return result
}
