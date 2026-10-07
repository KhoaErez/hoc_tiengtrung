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
      <div className="flex justify-between items-end border-b-2 border-red-700/30 pb-4">
        <div>
          <h1 className="text-3xl font-serif text-slate-800">Chủ đề sưu tầm</h1>
          <p className="text-slate-500 font-serif mt-1">Những bài học và chủ đề được sưu tầm từ cộng đồng</p>
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

