import { Metadata } from 'next'
import Link from 'next/link'
import { ShieldAlert, ArrowLeft } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { checkIsAdmin } from '@/app/actions/feedback'
import { getAdminUsersAction, checkDatabaseMigrationStatusAction } from '@/app/actions/admin'
import { AdminPortalClient } from './admin-portal-client'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'Trung tâm Phân quyền & Quản trị | Chinese Notebook',
  description: 'Quản lý quyền hạn tài khoản và cấu hình hệ thống Chinese Notebook.',
}

export default async function AdminPage() {
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
            Trang quản trị và phân quyền chỉ dành riêng cho tài khoản Quản trị viên của Chinese Notebook.
          </p>
          {user ? (
            <p className="text-xs text-body font-sans bg-page py-1.5 px-3 rounded-lg border border-border inline-block">
              Tài khoản hiện tại: <strong>{user.email}</strong> (Chưa được cấp quyền Admin)
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

  // 2. Fetch migration status and page 1 of user list (max 20 per page)
  const [migrationStatus, usersResult] = await Promise.all([
    checkDatabaseMigrationStatusAction(),
    getAdminUsersAction({ page: 1, pageSize: 20 }),
  ])

  return (
    <div className="max-w-6xl mx-auto py-4">
      <AdminPortalClient
        initialUsers={usersResult.users || []}
        initialStats={usersResult.stats}
        initialPagination={usersResult.pagination}
        currentUserId={user?.id}
        currentUserEmail={user?.email}
        hasFeedbackTable={migrationStatus.hasFeedbackTable}
        hasIsAdminColumn={migrationStatus.hasIsAdminColumn}
        hasLastSeenAtColumn={migrationStatus.hasLastSeenAtColumn}
      />
    </div>
  )
}
