import { unstable_cache } from 'next/cache'
import { createClient as createSupabaseClient } from '@supabase/supabase-js'

export type LevelLessonCounts = Record<number, number>

// Dữ liệu số lượng bài học chuẩn hóa dự phòng cho HSK 3.0 (Cấp 1 - 7 tương ứng HSK 1 - 6 và HSK 7-9)
export const DEFAULT_LEVEL_LESSON_COUNTS: LevelLessonCounts = {
  1: 18,
  2: 12,
  3: 24,
  4: 43,
  5: 91,
  6: 173,
  7: 0,
}

function getStaticSupabaseClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  if (!url || !anonKey) return null
  return createSupabaseClient(url, anonKey)
}

/**
 * Cache thống kê số bài học hệ thống theo từng cấp độ HSK 3.0.
 * Revalidate mỗi 3600 giây (1 giờ), hoặc khi tag 'curriculum-stats' được kích hoạt.
 * Không gọi `cookies()`, an toàn tuyệt đối cho Data Cache của Next.js Server Components.
 */
export const getCachedSystemLessonCounts = unstable_cache(
  async (): Promise<LevelLessonCounts> => {
    try {
      const supabase = getStaticSupabaseClient()
      if (!supabase) return DEFAULT_LEVEL_LESSON_COUNTS

      const { data: systemLessons, error } = await supabase
        .from('lessons')
        .select('id, hsk_level')
        .eq('is_system', true)

      if (error || !systemLessons) {
        return DEFAULT_LEVEL_LESSON_COUNTS
      }

      const counts: LevelLessonCounts = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0 }
      systemLessons.forEach((l) => {
        if (!l.hsk_level) return
        if (l.hsk_level === 'HSK 7-9' || l.hsk_level === 'HSK 7') {
          counts[7] = (counts[7] || 0) + 1
          return
        }
        const match = l.hsk_level.match(/HSK (\d)/)
        if (match) {
          const lvl = parseInt(match[1], 10)
          if (lvl >= 1 && lvl <= 6) {
            counts[lvl] = (counts[lvl] || 0) + 1
          } else if (lvl >= 7 && lvl <= 9) {
            counts[7] = (counts[7] || 0) + 1
          }
        }
      })
      return counts
    } catch {
      return DEFAULT_LEVEL_LESSON_COUNTS
    }
  },
  ['curriculum-system-lesson-counts-hsk3'],
  { revalidate: 3600, tags: ['curriculum-stats'] }
)

export type CachedLessonItem = {
  id: string
  title: string
  subtitle: string | null
  lesson_number: number | null
  vocab_count: number
  vocab_ids?: string[]
}

/**
 * Cache danh sách bài học hệ thống theo cấp HSK (không chứa dữ liệu người dùng).
 * Cực nhanh (< 1ms từ Data Cache), revalidate mỗi 3600 giây.
 */
export const getCachedSystemLessonsByLevel = unstable_cache(
  async (hskLevel: string): Promise<CachedLessonItem[]> => {
    try {
      const supabase = getStaticSupabaseClient()
      if (!supabase) return []

      const { data, error } = await supabase
        .from('lessons')
        .select('id, title, subtitle, lesson_number, lesson_vocabularies(vocabulary_id)')
        .eq('is_system', true)
        .eq('hsk_level', hskLevel)
        .order('lesson_number', { ascending: true })

      if (error || !data) return []

      return data.map((l: any) => {
        const vIds = Array.isArray(l.lesson_vocabularies)
          ? l.lesson_vocabularies.map((lv: any) => lv.vocabulary_id).filter(Boolean)
          : []
        return {
          id: l.id,
          title: l.title,
          subtitle: l.subtitle,
          lesson_number: l.lesson_number ?? null,
          vocab_count: vIds.length,
          vocab_ids: vIds,
        }
      })
    } catch {
      return []
    }
  },
  ['system-lessons-by-level-hsk3'],
  { revalidate: 3600, tags: ['curriculum-lessons'] }
)

/**
 * Cache tổng số từ vựng chính thức theo cấp HSK.
 */
export const getCachedTotalVocabCountByLevel = unstable_cache(
  async (hskLevel: string): Promise<number> => {
    try {
      const supabase = getStaticSupabaseClient()
      if (!supabase) return 0

      let query = supabase
        .from('vocabularies')
        .select('id', { count: 'exact', head: true })
        .eq('hsk_level', hskLevel)

      if (hskLevel === 'HSK 6') {
        query = query.in('validation_status', ['matched_target_syllabus', 'verified_target_syllabus', 'needs_tone_sense_review'])
      }

      const { count, error } = await query

      if (error || typeof count !== 'number') return 0
      return count
    } catch {
      return 0
    }
  },
  ['total-vocab-count-by-level-hsk3'],
  { revalidate: 3600, tags: ['curriculum-vocab-counts', 'vocab-counts'] }
)

export const SUPPORTED_VOCAB_LEVELS = [
  'HSK 1',
  'HSK 2',
  'HSK 3',
  'HSK 4',
  'HSK 5',
  'HSK 6',
  'HSK 7-9',
  'Giao tiếp',
  'Công xưởng',
] as const

export type VocabCountsMap = Record<string, number | null>

export interface AllVocabCountsResult {
  counts: VocabCountsMap
  hasError: boolean
  updatedAt: string
}

/**
 * Cache truy vấn số lượng từ vựng thực tế của toàn bộ hệ thống từ Supabase.
 * Sử dụng truy vấn song song HEAD (0 byte payload) để đếm chính xác từng cấp độ.
 * Revalidate mỗi 300 giây (5 phút), hoặc khi tag 'vocab-counts' được kích hoạt sau mutation.
 */
export const getCachedAllVocabCounts = unstable_cache(
  async (): Promise<AllVocabCountsResult> => {
    const defaultErrorCounts: VocabCountsMap = {
      'HSK 1': null,
      'HSK 2': null,
      'HSK 3': null,
      'HSK 4': null,
      'HSK 5': null,
      'HSK 6': null,
      'HSK 7-9': null,
      'Giao tiếp': null,
      'Công xưởng': null,
    }

    try {
      const supabase = getStaticSupabaseClient()
      if (!supabase) {
        return { counts: defaultErrorCounts, hasError: true, updatedAt: new Date().toISOString() }
      }

      const results = await Promise.all(
        SUPPORTED_VOCAB_LEVELS.map(async (lvl) => {
          let query = supabase
            .from('vocabularies')
            .select('*', { count: 'exact', head: true })
            .eq('hsk_level', lvl)

          if (lvl === 'HSK 6') {
            query = query.in('validation_status', ['matched_target_syllabus', 'verified_target_syllabus', 'needs_tone_sense_review'])
          }

          const { count, error } = await query

          if (error) {
            console.error(`Lỗi đếm số lượng từ vựng ${lvl}:`, error.message)
            return { lvl, count: null }
          }
          return { lvl, count: count ?? 0 }
        })
      )

      const counts: VocabCountsMap = {}
      let hasError = false
      results.forEach((r) => {
        counts[r.lvl] = r.count
        if (r.count === null) hasError = true
      })

      return { counts, hasError, updatedAt: new Date().toISOString() }
    } catch (err: any) {
      console.error('Lỗi ngoại lệ trong getCachedAllVocabCounts:', err?.message || err)
      return { counts: defaultErrorCounts, hasError: true, updatedAt: new Date().toISOString() }
    }
  },
  ['all-vocab-counts-supabase-live-v1'],
  { revalidate: 300, tags: ['vocab-counts', 'curriculum-vocab-counts'] }
)

