'use client'

import { useState } from 'react'
import Image from 'next/image'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import Link from 'next/link'
import { BookOpen, CheckSquare, Trash2, Edit3 } from 'lucide-react'
import DeleteLessonButton from './delete-lesson-button'
import { bulkDeleteLessonsAction } from './actions'
import { useRouter } from 'next/navigation'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from '@/components/ui/dialog'
import { toast } from 'sonner'

type Lesson = {
  id: string;
  title: string;
  subtitle?: string | null;
  hsk_level?: string | null;
  created_at: string;
  original_text?: string | null;
  user_id?: string | null;
}

export default function LessonListClient({ lessons, currentUserId }: { lessons: Lesson[], currentUserId?: string }) {
  const [isSelectMode, setIsSelectMode] = useState(false)
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set())
  const [isDeleting, setIsDeleting] = useState(false)
  const [showConfirmDialog, setShowConfirmDialog] = useState(false)
  const router = useRouter()

  const toggleSelectMode = () => {
    setIsSelectMode(!isSelectMode)
    setSelectedIds(new Set())
  }

  const toggleSelectLesson = (e: React.MouseEvent, id: string) => {
    if (!isSelectMode) return
    e.preventDefault()
    e.stopPropagation()
    const newSelected = new Set(selectedIds)
    if (newSelected.has(id)) {
      newSelected.delete(id)
    } else {
      newSelected.add(id)
    }
    setSelectedIds(newSelected)
  }

  const handleBulkDelete = async () => {
    if (selectedIds.size === 0) return
    setIsDeleting(true)
    const toastId = toast.loading(`Đang xóa ${selectedIds.size} bài học...`)
    try {
      await bulkDeleteLessonsAction(Array.from(selectedIds))
      setShowConfirmDialog(false)
      setSelectedIds(new Set())
      setIsSelectMode(false)
      toast.success('Xóa hàng loạt thành công', { id: toastId })
      router.refresh()
    } catch {
      toast.error('Có lỗi xảy ra khi xóa hàng loạt', { id: toastId })
    } finally {
      setIsDeleting(false)
    }
  }

  const handleCardClick = (e: React.MouseEvent, id: string) => {
    if (isSelectMode) {
      e.preventDefault()
      toggleSelectLesson(e, id)
    }
  }

  if (!lessons || lessons.length === 0) {
    return (
      <div className="text-center py-12 px-6 rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] shadow-xs hover:shadow-md space-y-4 max-w-md mx-auto">
        <div className="relative w-32 h-32 mx-auto rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs bg-[#FFF9F3]">
          <Image
            src="/images/empty-states/empty-lessons.webp"
            alt="Chưa có bài học"
            fill
            sizes="128px"
            className="object-cover"
          />
        </div>
        <div className="space-y-1">
          <h3 className="text-lg font-serif font-bold text-[#182238] dark:text-white">Chưa có bài học nào</h3>
          <p className="text-xs text-muted font-serif max-w-xs mx-auto">
            Hiện tại chưa có chủ đề nào trong danh sách. Hãy tạo bài học mới hoặc khám phá lộ trình HSK nhé!
          </p>
        </div>
      </div>
    )
  }

  return (
    <>
      {currentUserId && (
        <div className="flex justify-end mb-4">
          {isSelectMode ? (
            <div className="flex items-center gap-2">
              <span className="text-sm text-slate-500 font-serif mr-2">Đã chọn: {selectedIds.size}</span>
              <Button 
                variant="outline" 
                size="sm" 
                onClick={toggleSelectMode}
                className="font-serif"
              >
                Hủy chọn
              </Button>
              <Button 
                variant="destructive" 
                size="sm" 
                onClick={() => setShowConfirmDialog(true)}
                disabled={selectedIds.size === 0 || isDeleting}
                className="font-serif bg-red-600 hover:bg-red-700 text-white disabled:bg-slate-200 disabled:text-slate-400"
              >
                <Trash2 className="h-4 w-4 mr-2" />
                Xóa đã chọn
              </Button>
            </div>
          ) : (
            <Button 
              variant="outline" 
              size="sm" 
              onClick={toggleSelectMode}
              className="font-serif text-red-600 hover:text-red-700 hover:bg-red-50 border-red-200"
            >
              <CheckSquare className="h-4 w-4 mr-2" />
              Chọn để xóa
            </Button>
          )}
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-12 gap-8 md:gap-12 mt-8">
        {lessons.map((lesson, index) => {
          const isSelected = selectedIds.has(lesson.id)
          const isFeatured = index === 0;
          const isOwner = lesson.user_id === currentUserId;
          
          return (
            <article 
              key={lesson.id} 
              className={`relative block group rounded-[22px] transition-all duration-150 border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md hover:border-[#B8322D]/40 hover:-translate-y-0.5 active:scale-[0.98] ${isFeatured ? 'md:col-span-12 lg:col-span-8 p-6 md:p-8 bg-card-featured dark:bg-[#182238]' : 'md:col-span-6 lg:col-span-4 p-5 bg-card dark:bg-[#182238]'} ${
                isSelectMode && isOwner ? 'cursor-pointer' : 'cursor-default'
              }`}
              onClick={(e) => {
                if (isOwner) handleCardClick(e, lesson.id);
              }}
            >
              {!isSelectMode && (
                <Link href={"/lessons/" + lesson.id} className="absolute inset-0 z-10 focus:outline-none" aria-label={`Đọc bài ${lesson.title}`} />
              )}
              
              {isSelectMode && isOwner && (
                <div className="absolute top-2 right-2 z-30 bg-card/90 rounded-md p-0.5">
                  <div className={`w-5 h-5 rounded-md flex items-center justify-center border ${isSelected ? 'bg-app-accent border-app-accent text-white' : 'border-border bg-card'}`}>
                    {isSelected && <CheckSquare className="w-3.5 h-3.5" />}
                  </div>
                </div>
              )}
              
              <div className="flex flex-col h-full">
                <header className="mb-3">
                  <div className="flex items-center gap-3 mb-3">
                    <span className="text-[11px] font-bold text-white bg-app-accent px-2.5 py-0.5 rounded-md uppercase tracking-wider font-sans">
                      {lesson.hsk_level || 'Chưa phân loại'}
                    </span>
                    <time className="text-xs text-muted font-sans uppercase tracking-widest">
                      {new Intl.DateTimeFormat('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric' }).format(new Date(lesson.created_at))}
                    </time>
                    {!isSelectMode && isOwner && (
                      <div className="ml-auto relative z-20 flex items-center gap-1">
                        <Link 
                          href={`/lessons/${lesson.id}/edit`} 
                          className="text-slate-400 hover:text-blue-600 transition-colors p-1.5 rounded-full hover:bg-blue-50 relative z-20 cursor-pointer" 
                          onClick={(e) => e.stopPropagation()} 
                          title="Sửa bài học"
                        >
                          <Edit3 className="h-4 w-4" />
                        </Link>
                        <DeleteLessonButton id={lesson.id} />
                      </div>
                    )}
                  </div>
                  
                  <h2 className={`font-serif text-title group-hover:text-app-accent transition-colors leading-tight ${isFeatured ? 'text-3xl md:text-5xl mb-4' : 'text-xl md:text-2xl mb-2'} line-clamp-3`}>
                    {lesson.title}
                  </h2>
                  
                  {lesson.subtitle && (
                    <p className={`font-serif text-body italic ${isFeatured ? 'text-xl mb-4' : 'text-sm mb-2'}`}>{lesson.subtitle}</p>
                  )}
                </header>
                
                <div className={`font-serif text-body leading-relaxed opacity-80 ${isFeatured ? 'text-lg line-clamp-4 md:line-clamp-6' : 'text-base line-clamp-3'} flex-1`}>
                  {lesson.original_text}
                </div>
                
                {isFeatured && (
                  <div className="mt-6 text-app-accent font-serif font-bold text-sm tracking-widest uppercase flex items-center group-hover:underline relative z-10">
                    Đọc tiếp <span className="ml-2">→</span>
                  </div>
                )}
              </div>
            </article>
          )
        })}
      </div>

      <Dialog open={showConfirmDialog} onOpenChange={(open) => !isDeleting && setShowConfirmDialog(open)}>
        <DialogContent className="sm:max-w-md border-red-700/20">
          <DialogHeader>
            <DialogTitle className="font-serif text-xl text-slate-800">Xác nhận xóa hàng loạt</DialogTitle>
            <DialogDescription className="font-serif text-base text-slate-600">
              Bạn có chắc chắn muốn xóa {selectedIds.size} bài học đã chọn không? Hành động này sẽ xóa vĩnh viễn dữ liệu và không thể hoàn tác.
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="mt-4 gap-2 sm:gap-0">
            <Button variant="outline" onClick={() => setShowConfirmDialog(false)} disabled={isDeleting} className="font-serif rounded-sm cursor-pointer">
              Hủy bỏ
            </Button>
            <Button onClick={handleBulkDelete} disabled={isDeleting} className="font-serif rounded-sm bg-red-600 hover:bg-red-700 text-white cursor-pointer shadow-md">
              {isDeleting ? "Đang xử lý..." : "Có, xóa ngay"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  )
}
