import { createClient } from '@/lib/supabase/server'
import { Button } from '@/components/ui/button'
import Link from 'next/link'
import { PlusCircle } from 'lucide-react'
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
      <div className="flex flex-col md:flex-row md:justify-between md:items-end border-b border-border pb-6 gap-4">
        <div className="space-y-2">
          <div className="flex items-center gap-3">
            <div className="w-1.5 h-8 bg-primary rounded-full"></div>
            <h1 className="text-4xl md:text-5xl font-serif text-foreground font-bold tracking-tight">Chủ đề sưu tầm</h1>
          </div>
          <p className="text-muted-foreground font-serif text-lg pl-4">Những bài học và chủ đề được sưu tầm từ cộng đồng</p>
        </div>
        {user && (
          <Link href="/lessons/create">
            <Button className="font-serif">
              <PlusCircle className="mr-2 h-4 w-4" /> Thêm Bài Mới
            </Button>
          </Link>
        )}
      </div>

      <LessonListClient lessons={lessons || []} currentUserId={user?.id} />
    </div>
  )
}

