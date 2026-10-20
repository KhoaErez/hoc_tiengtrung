import { notFound, redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { HSK_LEVELS } from '@/data/hsk-curriculum'
import HskLevelClient from './hsk-level-client'

export const dynamic = 'force-dynamic'

interface Props {
  params: Promise<{ level: string }>
}

export default async function HskLevelPage({ params }: Props) {
  const { level } = await params
  const levelNum = parseInt(level, 10)

  if (isNaN(levelNum) || levelNum < 1 || levelNum > 6) {
    notFound()
  }

  const levelInfo = HSK_LEVELS[levelNum]
  const hskTag = `HSK ${levelNum}`

  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  // 1. Fetch system lessons for this HSK level
  const { data: lessonsData } = await supabase
    .from('lessons')
    .select('id, title, subtitle, lesson_number, lesson_vocabularies(count)')
    .eq('is_system', true)
    .eq('hsk_level', hskTag)
    .order('lesson_number', { ascending: true })

  // 2. Fetch user's learned vocabularies in this level if logged in
  let userLearnedVocabIds = new Set<string>()
  const lessonLearnedCountMap: Record<string, number> = {}

  if (user) {
    const { data: userVocabs } = await supabase
      .from('user_vocabularies')
      .select('vocabulary_id, vocabularies!inner(hsk_level, lesson_id)')
      .eq('user_id', user.id)
      .eq('vocabularies.hsk_level', hskTag)

    userVocabs?.forEach((uv: unknown) => {
      const item = uv as { vocabulary_id: string; vocabularies: { lesson_id?: string } | { lesson_id?: string }[] }
      userLearnedVocabIds.add(item.vocabulary_id)
      const v = Array.isArray(item.vocabularies) ? item.vocabularies[0] : item.vocabularies
      if (v?.lesson_id) {
        lessonLearnedCountMap[v.lesson_id] = (lessonLearnedCountMap[v.lesson_id] || 0) + 1
      }
    })
  }

  // 3. Format lessons list
  const lessons = lessonsData?.map((l) => {
    const vocabCount = (l.lesson_vocabularies as unknown as [{ count: number }])?.[0]?.count || 0
    const learnedCount = lessonLearnedCountMap[l.id] || 0
    const isCompleted = vocabCount > 0 && learnedCount >= vocabCount

    return {
      id: l.id,
      title: l.title,
      subtitle: l.subtitle,
      lesson_number: l.lesson_number ?? 0,
      vocab_count: vocabCount,
      learned_vocab_count: learnedCount,
      is_completed: isCompleted,
    }
  }) || []

  const totalLessons = lessons.length
  const completedLessons = lessons.filter(l => l.is_completed).length
  const totalLearnedVocabs = userLearnedVocabIds.size

  return (
    <div className="max-w-6xl mx-auto space-y-8 pb-16">
      <HskLevelClient 
        levelInfo={levelInfo}
        lessons={lessons}
        stats={{
          totalLessons,
          completedLessons,
          totalLearnedVocabs,
          targetVocab: levelInfo.vocabTarget
        }}
        isLoggedIn={!!user}
      />
    </div>
  )
}
