import { createClient } from '@/lib/supabase/server'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import { ArrowLeft, Edit, Sparkles, BookOpen } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { analyzeLessonAction } from '../actions'
import LessonReader from './lesson-reader'

export default async function LessonDetailPage(props: { params: Promise<{ id: string }> }) {
  const params = await props.params;
  const id = params.id;
  
  const supabase = await createClient()
  
  const { data: lesson } = await supabase
    .from('lessons')
    .select('*')
    .eq('id', id)
    .single()

  if (!lesson) {
    notFound()
  }

  let aiData: any = null
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
