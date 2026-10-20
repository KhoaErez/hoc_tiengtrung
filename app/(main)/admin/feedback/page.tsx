import { Metadata } from 'next'
import Link from 'next/link'
import { ShieldAlert, ArrowLeft } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { checkIsAdmin, getAdminFeedbacksAction } from '@/app/actions/feedback'
import { FeedbackAdminClient } from './feedback-admin-client'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'Quản lý Phản hồi & Góp ý | Chinese Notebook Admin',
  description: 'Bảng quản trị phản hồi, báo lỗi và đề xuất của người dùng.',
}

export default async function FeedbackAdminPage() {
  const { isAdmin, user } = await checkIsAdmin()

  // 1. Guard against non-admin access
  if (!isAdmin) {
    return (
      <div className="max-w-md mx-auto py-16 px-4 text-center space-y-5 font-serif">
        <div className="w-16 h-16 rounded-2xl bg-red-50 text-app-accent mx-auto flex items-center justify-center border border-red-200 shadow-xs">
          <ShieldAlert className="w-8 h-8" />
        </div>
        <div className="space-y-2">
          <h1 className="text-2xl font-bold text-title">Khu vực Giới hạn</h1>
          <p className="text-xs sm:text-sm text-muted leading-relaxed">
            Trang quản trị chỉ dành riêng cho tài khoản quản trị viên của Chinese Notebook.
          </p>
          {user ? (
            <p className="text-xs text-body font-sans bg-page py-1.5 px-3 rounded-lg border border-border inline-block">
              Tài khoản hiện tại: <strong>{user.email}</strong> (Không có quyền Admin)
            </p>
          ) : (
            <p className="text-xs text-muted">
              Bạn chưa đăng nhập vào hệ thống.
            </p>
          )}
        </div>
        <div className="pt-2">
          <Link href="/">
            <Button className="font-serif bg-title hover:bg-[#2A3250] text-white rounded-xl text-xs gap-2">
              <ArrowLeft className="w-4 h-4" />
              <span>Quay về trang chủ</span>
            </Button>
          </Link>
        </div>
      </div>
    )
  }

  // 2. Fetch initial data for admin
  const res = await getAdminFeedbacksAction()
  const feedbacks = res.data || []
  const stats = res.stats || {
    total: 0,
    new: 0,
    under_review: 0,
    in_progress: 0,
    resolved: 0,
    wont_fix: 0,
    bug: 0,
    feature: 0,
    ui_ux: 0,
    content: 0,
    other: 0,
  }

  return (
    <div className="max-w-6xl mx-auto py-4">
      <FeedbackAdminClient
        initialFeedbacks={feedbacks as any}
        initialStats={stats}
      />
    </div>
  )
}
