import { createClient } from '@/lib/supabase/server'
import { notFound } from 'next/navigation'
import { analyzeLessonAction } from '../actions'
import LessonReader from './lesson-reader'

import SystemLessonReader from './system-lesson-reader'

export default async function LessonDetailPage(props: { params: Promise<{ id: string }> }) {
  const params = await props.params;
  const id = params.id;
  
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const { data: lesson } = await supabase
    .from('lessons')
    .select('*')
    .eq('id', id)
    .single()

  if (!lesson) {
    notFound()
  }

  // All lessons are now public, no owner check needed

  // Render System Curriculum Lesson
  if (lesson.is_system) {
    const { data: vocabMappings } = await supabase
      .from('lesson_vocabularies')
      .select('vocabularies(*)')
      .eq('lesson_id', id)
      .order('sort_order', { ascending: true })
      
    const vocabularies = vocabMappings?.map(m => m.vocabularies) || []
    
    let userVocabs: string[] = []
    if (user) {
      const { data: uvData } = await supabase
        .from('user_vocabularies')
        .select('vocabulary_id')
        .eq('user_id', user.id)
        .in('vocabulary_id', vocabularies.map((v: any) => v.id))
      userVocabs = uvData?.map(uv => uv.vocabulary_id) || []
    }

    return <SystemLessonReader lesson={lesson} vocabularies={vocabularies as any} userVocabs={userVocabs} />
  }

  let aiData: { words?: { hanzi: string, pinyin: string, vi: string }[], key_vocab?: { hanzi: string, pinyin: string, vi: string }[], pinyin_text?: string, translation?: string, grammar?: { structure: string, explanation: string }[] } | null = null
  let hasAiData = false
  if (lesson.pinyin) {
    try {
      // Clean potential markdown artifacts from AI response
      let cleanJson = lesson.pinyin;
      if (cleanJson.startsWith('```json')) {
        cleanJson = cleanJson.replace(/^```json\n?/, '').replace(/\n?```$/, '');
      }
      
      const parsed = JSON.parse(cleanJson)
      if (parsed) {
        aiData = Array.isArray(parsed) ? { words: parsed } : parsed
        hasAiData = true
      }
    } catch(e) {
      console.error("Failed to parse pinyin JSON", e)
    }
  }
  
  const runAiAction = analyzeLessonAction.bind(null, id)

  return (
    <div className="max-w-6xl mx-auto space-y-6 pb-20">
      <LessonReader 
        lesson={lesson} 
        aiData={aiData || {}} 
        originalText={lesson.original_text}
        runAiAction={runAiAction}
        hasAiData={hasAiData}
      />
    </div>
  )
}
