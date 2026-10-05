import { createClient } from '@/lib/supabase/server'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import Link from 'next/link'
import { PlusCircle, BookOpen } from 'lucide-react'
import DeleteLessonButton from './delete-lesson-button'

export default async function LessonsPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const { data: lessons } = await supabase
    .from('lessons')
    .select('*')
    .eq('user_id', user?.id)
    .order('created_at', { ascending: false })

  return (
    <div className="max-w-5xl mx-auto space-y-6">
      <div className="flex justify-between items-end border-b-2 border-red-700/30 pb-4">
        <div>
          <h1 className="text-3xl font-serif text-slate-800">Danh sách Bài học</h1>
          <p className="text-slate-500 font-serif mt-1">Các bài học bạn đã tạo hoặc lưu lại</p>
        </div>
        <Link href="/lessons/create">
          <Button className="font-serif">
            <PlusCircle className="mr-2 h-4 w-4" /> Thêm Bài Mới
          </Button>
        </Link>
      </div>

      {!lessons || lessons.length === 0 ? (
        <div className="text-center py-20 border-2 border-dashed border-slate-300 bg-white/30">
          <BookOpen className="h-12 w-12 text-slate-300 mx-auto mb-4" />
          <h3 className="text-lg font-serif text-slate-700">Chưa có bài học nào</h3>
          <p className="text-slate-500 mb-6">Hãy tạo bài học đầu tiên của bạn bằng cách nhập văn bản tiếng Trung.</p>
          <Link href="/lessons/create">
            <Button variant="outline" className="font-serif">
              Tạo bài học đầu tiên
            </Button>
          </Link>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {lessons.map((lesson) => (
            <div key={lesson.id} className="relative block h-full group">
              <Card className="rounded-sm border-2 border-slate-200 group-hover:border-red-700/50 group-hover:shadow-md transition-all bg-[#FDFBF7] h-full flex flex-col relative overflow-hidden cursor-pointer">
                <Link href={"/lessons/" + lesson.id} className="absolute inset-0 z-10" aria-label={`View lesson ${lesson.title}`} />
                
                {/* Trang trí góc giấy */}
                <div className="absolute top-0 right-0 w-8 h-8 bg-slate-200 rotate-45 translate-x-4 -translate-y-4 group-hover:bg-red-700/20 transition-colors z-0"></div>
                
                <CardHeader className="pb-3 border-b-2 border-slate-100 bg-white/50 relative z-20">
                  <div className="flex justify-between items-start">
                    <span className="text-xs font-bold text-red-700 bg-red-50 px-2 py-1 rounded-sm border border-red-100">
                      {lesson.hsk_level || 'Chưa phân loại'}
                    </span>
                    <div className="flex items-center gap-2">
                      <span className="text-xs text-slate-400 font-sans">
                        {new Intl.DateTimeFormat('vi-VN').format(new Date(lesson.created_at))}
                      </span>
                      <DeleteLessonButton id={lesson.id} />
                    </div>
                  </div>
                  <CardTitle className="font-serif text-xl mt-3 group-hover:text-red-700 transition-colors line-clamp-2">
                    {lesson.title}
                  </CardTitle>
                  {lesson.subtitle && (
                    <p className="text-sm text-slate-500 font-serif">{lesson.subtitle}</p>
                  )}
                </CardHeader>
                <CardContent className="pt-4 flex-1 relative z-0">
                  <p className="text-slate-600 font-serif line-clamp-3 opacity-70">
                    {lesson.original_text}
                  </p>
                </CardContent>
              </Card>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
