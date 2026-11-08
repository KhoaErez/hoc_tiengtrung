import Image from 'next/image'
import { createClient, getCachedAuthUser } from '@/lib/supabase/server'
import LessonListClient from './lesson-list-client'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { BookOpen, PlusCircle, Sparkles } from 'lucide-react'

export default async function LessonsPage() {
  const [supabase, user] = await Promise.all([
    createClient(),
    getCachedAuthUser(),
  ])

  const { data: lessons } = await supabase
    .from('lessons')
    .select('*')
    .or('is_system.eq.false,is_system.is.null')
    .order('created_at', { ascending: false })

  return (
    <div className="w-full max-w-[1500px] mx-auto space-y-6">
      {/* Studio Header Banner */}
      <div className="relative overflow-hidden rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] p-5 sm:p-7 md:p-8 shadow-xs hover:shadow-md">
        {/* Top accent line */}
        <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-title via-app-accent to-gold" />

        {/* Decorative Watermark */}
        <div className="absolute -right-4 -bottom-6 select-none pointer-events-none opacity-[0.05] dark:opacity-[0.08] font-hanzi text-8xl md:text-9xl font-bold text-title">
          课文
        </div>

        <div className="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-5">
          <div className="flex items-center gap-4 sm:gap-5 max-w-2xl">
            <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs shrink-0 relative bg-[#FFF9F3]">
              <Image
                src="/images/empty-states/empty-lessons.webp"
                alt="Kho bài đọc 3D"
                fill
                className="object-cover"
                sizes="96px"
                priority
              />
            </div>
            <div className="space-y-1.5">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold tracking-wide uppercase bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30">
                <BookOpen className="w-3.5 h-3.5" />
                <span>Thư Viện Bài Đọc & Chủ Đề Sưu Tầm</span>
              </div>

              <h1 className="text-2xl sm:text-3xl font-serif text-[#182238] dark:text-white font-bold tracking-tight">
                Kho Bài Đọc Tiếng Trung
              </h1>
              <p className="text-muted font-serif text-xs md:text-sm leading-relaxed">
                Khám phá và tự tạo những bài đọc, mẫu truyện ngắn và đoạn văn tiếng Trung có tích hợp AI phân tích từ vựng, ngữ pháp và phát âm giọng đọc bản ngữ.
              </p>
            </div>
          </div>

          <div className="shrink-0 flex items-center gap-2">
            <Link href="/lessons/create">
              <Button variant="primary" className="font-serif text-xs min-h-[44px] px-5 rounded-2xl shadow-xs border border-[#B8322D]/30 flex items-center gap-2 cursor-pointer active:scale-[0.98]">
                <PlusCircle className="w-4 h-4" />
                <span>Thêm bài học mới</span>
              </Button>
            </Link>
          </div>
        </div>
      </div>

      <LessonListClient lessons={lessons || []} currentUserId={user?.id} />
    </div>
  )
}

