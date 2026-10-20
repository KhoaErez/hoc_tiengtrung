import { Metadata } from 'next'
import { createClient } from '@/lib/supabase/server'
import { notFound } from 'next/navigation'
import { analyzeLessonAction } from '../actions'
import LessonReader from './lesson-reader'
import SystemLessonReader from './system-lesson-reader'

export async function generateMetadata(props: { params: Promise<{ id: string }> }): Promise<Metadata> {
  const params = await props.params
  const id = params.id
  const supabase = await createClient()
  const { data: lesson } = await supabase
    .from('lessons')
    .select('title, subtitle, hsk_level')
    .eq('id', id)
    .maybeSingle()

  if (!lesson) {
    return {
      title: 'Chi tiết bài học | Chinese Notebook',
    }
  }

  return {
    title: `${lesson.title} - ${lesson.hsk_level || 'Bài học'} | Chinese Notebook`,
    description: lesson.subtitle || `Học từ vựng và luyện phát âm ${lesson.title} trên Chinese Notebook.`,
  }
}

export default async function LessonDetailPage(props: { params: Promise<{ id: string }> }) {
  const params = await props.params
  const id = params.id

  const supabase = await createClient()

  // 1. Parallel initial fetch: User session + Lesson details
  const [userResult, lessonResult] = await Promise.all([
    supabase.auth.getUser(),
    supabase
      .from('lessons')
      .select('id, title, subtitle, hsk_level, lesson_number, is_system, original_text, pinyin')
      .eq('id', id)
      .maybeSingle(),
  ])

  const user = userResult.data.user
  const lesson = lessonResult.data

  if (!lesson) {
    notFound()
  }

  // 2. Render System Curriculum Lesson (HSK 1 - 6)
  if (lesson.is_system) {
    const lessonNumber = lesson.lesson_number ?? 0

    // Parallel fetch: Vocabularies, Adjacent Lessons (Prev & Next)
    const [vocabMappingsResult, prevLessonResult, nextLessonResult] = await Promise.all([
      supabase
        .from('lesson_vocabularies')
        .select('sort_order, vocabularies(id, hanzi, pinyin, meaning_vi, example_hanzi, example_pinyin, example_vi)')
        .eq('lesson_id', id)
        .order('sort_order', { ascending: true }),
      supabase
        .from('lessons')
        .select('id, title, lesson_number')
        .eq('is_system', true)
        .eq('hsk_level', lesson.hsk_level)
        .lt('lesson_number', lessonNumber)
        .order('lesson_number', { ascending: false })
        .limit(1)
        .maybeSingle(),
      supabase
        .from('lessons')
        .select('id, title, lesson_number')
        .eq('is_system', true)
        .eq('hsk_level', lesson.hsk_level)
        .gt('lesson_number', lessonNumber)
        .order('lesson_number', { ascending: true })
        .limit(1)
        .maybeSingle(),
    ])

    const rawVocabs = vocabMappingsResult.data?.map((m: any) => m.vocabularies).filter(Boolean) || []
    const vocabularies = rawVocabs as any[]
    const vocabIds = vocabularies.map((v) => v.id)

    // User progress query if logged in
    let userVocabs: string[] = []
    if (user && vocabIds.length > 0) {
      const { data: uvData } = await supabase
        .from('user_vocabularies')
        .select('vocabulary_id')
        .eq('user_id', user.id)
        .in('vocabulary_id', vocabIds)

      userVocabs = uvData?.map((uv) => uv.vocabulary_id) || []
    }

    return (
      <SystemLessonReader
        lesson={lesson as any}
        vocabularies={vocabularies}
        userVocabs={userVocabs}
        prevLesson={prevLessonResult.data as any}
        nextLesson={nextLessonResult.data as any}
        isLoggedIn={Boolean(user)}
      />
    )
  }

  // 3. Custom / AI Analyzed Lesson
  let aiData: { words?: { hanzi: string, pinyin: string, vi: string }[], key_vocab?: { hanzi: string, pinyin: string, vi: string }[], pinyin_text?: string, translation?: string, grammar?: { structure: string, explanation: string }[] } | null = null
  let hasAiData = false
  if (lesson.pinyin) {
    try {
      let cleanJson = lesson.pinyin
      if (cleanJson.startsWith('```json')) {
        cleanJson = cleanJson.replace(/^```json\n?/, '').replace(/\n?```$/, '')
      }
      const parsed = JSON.parse(cleanJson)
      if (parsed) {
        aiData = Array.isArray(parsed) ? { words: parsed } : parsed
        hasAiData = true
      }
    } catch (e) {
      console.error('Failed to parse pinyin JSON', e)
    }
  }

  const runAiAction = analyzeLessonAction.bind(null, id)

  return (
    <div className="max-w-6xl mx-auto space-y-6 pb-20">
      <LessonReader
        lesson={lesson}
        aiData={aiData || {}}
        originalText={lesson.original_text || ''}
        runAiAction={runAiAction}
        hasAiData={hasAiData}
      />
    </div>
  )
}
