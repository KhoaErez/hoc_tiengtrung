import { createClient, getCachedAuthUser } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import HskDashboardClient from './hsk-dashboard-client'
import { getCachedSystemLessonsByLevel, getCachedTotalVocabCountByLevel } from '@/lib/curriculum-cache'

export const dynamic = 'force-dynamic'

export default async function TopicsPage(props: { searchParams: Promise<{ q?: string; page?: string; tab?: string; vq?: string }> }) {
  const searchParams = await props.searchParams;
  const currentHsk = searchParams.q || 'HSK 1'
  const initialVocabPage = Math.max(1, parseInt(searchParams.page || '1', 10) || 1)
  const initialTab = searchParams.tab === 'vocab' || searchParams.page ? 'vocab' : 'lessons'
  const initialVocabSearch = searchParams.vq || ''
  
  // Validate HSK 3.0 level
  const validLevels = ['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6', 'HSK 7-9', 'Giao tiếp', 'Công xưởng']
  if (!validLevels.includes(currentHsk)) {
    redirect('/topics?q=HSK 1')
  }

  const supabase = await createClient()
  const user = await getCachedAuthUser()

  let userVocabCount = 0
  let reviewVocabCount = 0
  let recentVocabs: { hanzi: string; pinyin: string; vi: string }[] = []

  const now = new Date().toISOString()

  // Song song nạp dữ liệu giáo trình tĩnh (< 1ms từ cache) và dữ liệu tiến độ người dùng
  const [
    totalLevelVocabsCount,
    lessonsData,
    userVocabsRes,
    reviewCountRes,
    vocabDataRes,
  ] = await Promise.all([
    getCachedTotalVocabCountByLevel(currentHsk),
    getCachedSystemLessonsByLevel(currentHsk),
    user
      ? supabase
          .from('user_vocabularies')
          .select('vocabulary_id, vocabularies!inner()')
          .eq('user_id', user.id)
          .eq('vocabularies.hsk_level', currentHsk)
      : Promise.resolve({ data: null }),
    user
      ? supabase
          .from('user_vocabularies')
          .select('id, vocabularies!inner()', { count: 'exact', head: true })
          .eq('user_id', user.id)
          .eq('vocabularies.hsk_level', currentHsk)
          .lte('next_review_at', now)
      : Promise.resolve({ count: 0 }),
    user
      ? supabase
          .from('user_vocabularies')
          .select('id, vocabularies!inner(hanzi, pinyin, meaning_vi)')
          .eq('user_id', user.id)
          .eq('vocabularies.hsk_level', currentHsk)
          .order('created_at', { ascending: false })
          .limit(8)
      : Promise.resolve({ data: null }),
  ])

  // Set of learned vocabulary IDs for fast lookup
  const learnedVocabIdSet = new Set<string>()

  if (user) {
    const userVocabs = userVocabsRes.data || []
    userVocabCount = userVocabs.length

    userVocabs.forEach((uv: any) => {
      if (uv?.vocabulary_id) {
        learnedVocabIdSet.add(uv.vocabulary_id)
      }
    })

    reviewVocabCount = reviewCountRes.count || 0

    const vocabData = vocabDataRes.data || []
    recentVocabs = vocabData.map((r: unknown) => {
      const typedR = r as { vocabularies: { hanzi: string; pinyin: string; meaning_vi: string } | { hanzi: string; pinyin: string; meaning_vi: string }[] }
      const v = Array.isArray(typedR.vocabularies) ? typedR.vocabularies[0] : typedR.vocabularies
      return {
        hanzi: v?.hanzi || '',
        pinyin: v?.pinyin || '',
        vi: v?.meaning_vi || '',
      }
    })
  }

  // Format lessons with real user progress
  const lessons = lessonsData?.map(l => {
    const vocabCount = l.vocab_count ?? 0
    const vIds = l.vocab_ids || []
    const learnedCount = vIds.length > 0 
      ? vIds.filter(id => learnedVocabIdSet.has(id)).length 
      : 0
    const isCompleted = vocabCount > 0 && learnedCount >= vocabCount

    return {
      id: l.id,
      title: l.title,
      subtitle: l.subtitle,
      lesson_number: l.lesson_number ?? null,
      vocab_count: vocabCount,
      learned_vocab_count: learnedCount,
      is_completed: isCompleted,
    }
  }) || []

  return (
    <div className="max-w-5xl mx-auto pb-24 md:pb-12">
      <HskDashboardClient 
        currentHsk={currentHsk}
        lessons={lessons}
        userVocabCount={userVocabCount}
        reviewVocabCount={reviewVocabCount}
        recentVocabs={recentVocabs}
        totalLevelVocabCount={totalLevelVocabsCount || undefined}
        isLoggedIn={!!user}
        initialVocabPage={initialVocabPage}
        initialTab={initialTab}
        initialVocabSearch={initialVocabSearch}
      />
    </div>
  )
}
