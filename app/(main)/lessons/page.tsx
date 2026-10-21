import { createClient } from '@/lib/supabase/server'
import LessonListClient from './lesson-list-client'

export default async function LessonsPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const { data: lessons } = await supabase
    .from('lessons')
    .select('*')
    .or('is_system.eq.false,is_system.is.null')
    .order('created_at', { ascending: false })

  return (
    <div className="max-w-7xl mx-auto space-y-6">
      <div className="border-b border-border/80 pb-5">
        <div className="space-y-1.5">
          <div className="flex items-center gap-2.5">
            <span className="w-2 h-6 bg-app-accent rounded-full" />
            <h1 className="text-2xl md:text-3xl font-serif text-title font-bold tracking-tight">Chủ đề sưu tầm</h1>
          </div>
          <p className="text-muted font-serif text-sm pl-4">Những bài học và chủ đề được sưu tầm từ cộng đồng</p>
        </div>
      </div>

      <LessonListClient lessons={lessons || []} currentUserId={user?.id} />
    </div>
  )
}

