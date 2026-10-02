'use client'

import { Trash2 } from 'lucide-react'
import { deleteLessonAction } from './actions'
import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'

export default function DeleteLessonButton({ id }: { id: string }) {
  const [isDeleting, setIsDeleting] = useState(false)
  const [isOpen, setIsOpen] = useState(false)
  const [showSuccess, setShowSuccess] = useState(false)
  const router = useRouter()
  
  const handleDelete = async (e?: React.MouseEvent) => {
    if (e) {
      e.preventDefault() 
      e.stopPropagation()
    }
    
    setIsDeleting(true)
    try {
      await deleteLessonAction(id)
      setIsOpen(false)
      setShowSuccess(true)
      setTimeout(() => {
        setShowSuccess(false)
        router.refresh()
      }, 1500)
    } catch (err) {
      alert("Có lỗi xảy ra khi xóa bài học.")
      setIsDeleting(false)
    }
  }

  const handleOpenDialog = (e: React.MouseEvent) => {
    e.preventDefault()
    e.stopPropagation()
    setIsOpen(true)
  }

  return (
    <>
      <button 
        onClick={handleOpenDialog}
        disabled={isDeleting}
        className="text-slate-400 hover:text-red-600 transition-colors p-1.5 rounded-full hover:bg-red-50 disabled:opacity-50 relative z-20 cursor-pointer"
        title="Xóa bài học"
      >
        <Trash2 className="h-4 w-4" />
      </button>

      {/* Xác nhận xóa */}
      <Dialog open={isOpen} onOpenChange={(open) => !isDeleting && setIsOpen(open)}>
        <DialogContent onClick={(e) => e.stopPropagation()} className="sm:max-w-md border-red-700/20">
          <DialogHeader>
            <DialogTitle className="font-serif text-xl text-slate-800">Xác nhận xóa bài học</DialogTitle>
            <DialogDescription className="font-serif text-base text-slate-600">
              Bạn có chắc chắn muốn xóa bài học này không? Hành động này sẽ xóa vĩnh viễn dữ liệu và không thể hoàn tác.
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="mt-4 gap-2 sm:gap-0">
            <Button variant="outline" onClick={() => setIsOpen(false)} disabled={isDeleting} className="font-serif rounded-sm cursor-pointer">
              Hủy bỏ
            </Button>
            <Button onClick={() => handleDelete()} disabled={isDeleting} className="font-serif rounded-sm bg-red-600 hover:bg-red-700 text-white cursor-pointer shadow-md">
              {isDeleting ? "Đang xử lý..." : "Có, xóa ngay"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Thông báo thành công */}
      <Dialog open={showSuccess} onOpenChange={setShowSuccess}>
        <DialogContent className="sm:max-w-sm text-center p-8 border-green-500/20 shadow-xl" onClick={(e) => e.stopPropagation()}>
          <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-green-100 mb-2">
            <span className="text-green-600 text-2xl font-bold">✓</span>
          </div>
          <DialogTitle className="font-serif text-xl text-slate-800">Đã xóa thành công</DialogTitle>
          <DialogDescription className="font-serif text-slate-500">
            Bài học đã được xóa khỏi hệ thống.
          </DialogDescription>
        </DialogContent>
      </Dialog>
    </>
  )
}
