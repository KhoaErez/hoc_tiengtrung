'use client'

import { useState } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import Link from 'next/link'
import { BookOpen, CheckSquare, Trash2 } from 'lucide-react'
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
              className={`relative block group rounded-2xl transition-all duration-300 ${isFeatured ? 'md:col-span-12 lg:col-span-8 p-6 md:p-8 bg-gradient-to-br from-red-50/40 to-orange-50/40 hover:shadow-md hover:bg-white border border-transparent hover:border-red-100' : 'md:col-span-6 lg:col-span-4 p-5 hover:bg-white hover:shadow-sm border border-transparent hover:border-slate-100'} ${
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
                <div className="absolute top-0 right-0 z-30 bg-white/80 p-1">
                  <div className={`w-5 h-5 rounded flex items-center justify-center border-2 ${isSelected ? 'bg-red-700 border-red-700' : 'border-slate-400 bg-white'}`}>
                    {isSelected && <CheckSquare className="w-4 h-4 text-white" />}
                  </div>
                </div>
              )}
              
              <div className="flex flex-col h-full">
                <header className="mb-3">
                  <div className="flex items-center gap-3 mb-3">
                    <span className="text-xs font-bold text-white bg-red-700 px-2 py-0.5 uppercase tracking-wider">
                      {lesson.hsk_level || 'Chưa phân loại'}
                    </span>
                    <time className="text-xs text-slate-500 font-sans uppercase tracking-widest">
                      {new Intl.DateTimeFormat('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric' }).format(new Date(lesson.created_at))}
                    </time>
                    {!isSelectMode && isOwner && (
                      <div className="ml-auto relative z-20">
                        <DeleteLessonButton id={lesson.id} />
                      </div>
                    )}
                  </div>
                  
                  <h2 className={`font-serif text-slate-900 group-hover:text-red-700 transition-colors leading-tight ${isFeatured ? 'text-3xl md:text-5xl mb-4' : 'text-xl md:text-2xl mb-2'} line-clamp-3`}>
                    {lesson.title}
                  </h2>
                  
                  {lesson.subtitle && (
                    <p className={`font-serif text-slate-600 italic ${isFeatured ? 'text-xl mb-4' : 'text-sm mb-2'}`}>{lesson.subtitle}</p>
                  )}
                </header>
                
                <div className={`font-serif text-slate-600 leading-relaxed opacity-80 ${isFeatured ? 'text-lg line-clamp-4 md:line-clamp-6' : 'text-base line-clamp-3'} flex-1`}>
                  {lesson.original_text}
                </div>
                
                {isFeatured && (
                  <div className="mt-6 text-red-700 font-serif font-bold text-sm tracking-widest uppercase flex items-center group-hover:underline relative z-10">
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
