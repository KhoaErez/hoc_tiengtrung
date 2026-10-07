import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import HskDashboardClient from './hsk-dashboard-client'

export const dynamic = 'force-dynamic'

export default async function TopicsPage(props: { searchParams: Promise<{ q?: string }> }) {
  const searchParams = await props.searchParams;
  const currentHsk = searchParams.q || 'HSK 1'
  
  // Validate HSK level
  const validLevels = ['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6', 'Giao tiếp', 'Công xưởng']
  if (!validLevels.includes(currentHsk)) {
    redirect('/topics?q=HSK 1')
  }

  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  let lessons: { id: string; title: string; subtitle: string | null; lesson_number: number | null; vocab_count: number }[] = []
  let userVocabCount = 0
  let reviewVocabCount = 0
  let recentVocabs: { hanzi: string; pinyin: string; vi: string }[] = []
  let globalVocabs: { id: string; hanzi: string; pinyin: string; meaning_vi: string; example_hanzi?: string; example_pinyin?: string; example_vi?: string }[] = []

  // Fetch Curriculum Lessons (System Lessons)
  const { data: lessonsData } = await supabase
    .from('lessons')
    .select('id, title, subtitle, lesson_number, lesson_vocabularies(count)')
    .eq('is_system', true)
    .eq('hsk_level', currentHsk)
    .order('lesson_number', { ascending: true })

  lessons = lessonsData?.map(l => ({
    id: l.id,
    title: l.title,
    subtitle: l.subtitle,
    lesson_number: l.lesson_number,
    vocab_count: (l.lesson_vocabularies as unknown as [{ count: number }])?.[0]?.count || 0
  })) || []

  if (user) {
    // User is logged in, fetch user stats
    
    // Fetch global vocabularies for this HSK level (optional, if still keeping the tab)
    const { data: globalVocabsData } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, example_hanzi, example_pinyin, example_vi')
      .eq('hsk_level', currentHsk)
      .order('id', { ascending: true })
      
    globalVocabs = globalVocabsData || []

    // Count user vocabularies for this HSK level
    const { count: vocabCount } = await supabase
      .from('user_vocabularies')
      .select('id, vocabularies!inner(hsk_level)', { count: 'exact', head: true })
      .eq('user_id', user.id)
      .eq('vocabularies.hsk_level', currentHsk)
      
    userVocabCount = vocabCount || 0

    // Count vocabularies needing review
    const now = new Date().toISOString()
    const { count: reviewCount } = await supabase
      .from('user_vocabularies')
      .select('id, vocabularies!inner(hsk_level)', { count: 'exact', head: true })
      .eq('user_id', user.id)
      .eq('vocabularies.hsk_level', currentHsk)
      .lte('next_review_at', now)

    reviewVocabCount = reviewCount || 0

    // Fetch some recent vocabs to display
    const { data: vocabData } = await supabase
      .from('user_vocabularies')
      .select('id, vocabularies!inner(hanzi, pinyin, meaning_vi, hsk_level)')
      .eq('user_id', user.id)
      .eq('vocabularies.hsk_level', currentHsk)
      .order('created_at', { ascending: false })
      .limit(8)
      
    recentVocabs = vocabData?.map((r: unknown) => {
      const typedR = r as { vocabularies: { hanzi: string; pinyin: string; meaning_vi: string } | { hanzi: string; pinyin: string; meaning_vi: string }[] };
      const v = Array.isArray(typedR.vocabularies) ? typedR.vocabularies[0] : typedR.vocabularies;
      return {
        hanzi: v?.hanzi || '',
        pinyin: v?.pinyin || '',
        vi: v?.meaning_vi || ''
      }
    }) || []
  }

  return (
    <div className="max-w-5xl mx-auto pb-24 md:pb-12">
      <HskDashboardClient 
        currentHsk={currentHsk}
        lessons={lessons}
        userVocabCount={userVocabCount}
        reviewVocabCount={reviewVocabCount}
        recentVocabs={recentVocabs}
        globalVocabs={globalVocabs}
        isLoggedIn={!!user}
      />
    </div>
  )
}
