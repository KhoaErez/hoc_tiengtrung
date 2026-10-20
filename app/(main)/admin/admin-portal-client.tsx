'use client'

import { useState, useTransition } from 'react'
import Link from 'next/link'
import {
  ShieldAlert,
  ShieldCheck,
  Users,
  MessageSquareWarning,
  Search,
  Copy,
  Check,
  AlertTriangle,
  ExternalLink,
  RefreshCw,
  UserCheck,
  UserX,
  Database,
  ArrowRight
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { AdminUserItem, toggleUserAdminRoleAction, getAdminUsersAction } from '@/app/actions/admin'

interface AdminPortalClientProps {
  initialUsers: AdminUserItem[]
  currentUserId?: string
  hasFeedbackTable: boolean
  hasIsAdminColumn: boolean
  currentUserEmail?: string
}

const SQL_MIGRATION_SNIPPET = `-- 1. Bổ sung cột is_admin vào bảng profiles (nếu chưa có)
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS is_admin boolean DEFAULT false;

-- 2. Gán quyền Admin ngay cho tài khoản của bạn
UPDATE public.profiles 
SET is_admin = true 
WHERE email = 'khoadev27@gmail.com';

-- 3. Tạo bảng lưu trữ phản hồi (feedback)
CREATE TABLE IF NOT EXISTS public.feedback (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  category text NOT NULL CHECK (category IN ('bug', 'feature', 'ui_ux', 'content', 'other')),
  title text NOT NULL,
  message text NOT NULL,
  steps_to_reproduce text,
  page_url text,
  device_info text,
  status text NOT NULL DEFAULT 'new' CHECK (status IN ('new', 'under_review', 'in_progress', 'resolved', 'wont_fix')),
  admin_note text,
  created_at timestamp WITH time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at timestamp WITH time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Index tra cứu nhanh
CREATE INDEX IF NOT EXISTS idx_feedback_status ON public.feedback(status);
CREATE INDEX IF NOT EXISTS idx_feedback_created_at ON public.feedback(created_at DESC);

-- 4. Kích hoạt Row Level Security (RLS)
ALTER TABLE public.feedback ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can insert feedback" ON public.feedback;
CREATE POLICY "Anyone can insert feedback" 
  ON public.feedback FOR INSERT 
  WITH CHECK (true);

DROP POLICY IF EXISTS "Users can view own feedback" ON public.feedback;
CREATE POLICY "Users can view own feedback" 
  ON public.feedback FOR SELECT 
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Admins can view all feedback" ON public.feedback;
CREATE POLICY "Admins can view all feedback" 
  ON public.feedback FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND (is_admin = true OR email = 'khoadev27@gmail.com')
    )
  );

DROP POLICY IF EXISTS "Admins can update feedback" ON public.feedback;
CREATE POLICY "Admins can update feedback" 
  ON public.feedback FOR UPDATE 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND (is_admin = true OR email = 'khoadev27@gmail.com')
    )
  );`

export function AdminPortalClient({
  initialUsers,
  currentUserId,
  hasFeedbackTable,
  hasIsAdminColumn,
  currentUserEmail,
}: AdminPortalClientProps) {
  const [users, setUsers] = useState<AdminUserItem[]>(initialUsers)
  const [search, setSearch] = useState('')
  const [copiedSql, setCopiedSql] = useState(false)
  const [showSqlModal, setShowSqlModal] = useState(!hasFeedbackTable || !hasIsAdminColumn)
  const [actionError, setActionError] = useState<string | null>(null)
  const [actionSuccess, setActionSuccess] = useState<string | null>(null)
  const [isPending, startTransition] = useTransition()

  // Copy SQL script to clipboard
  const handleCopySql = () => {
    navigator.clipboard.writeText(SQL_MIGRATION_SNIPPET)
    setCopiedSql(true)
    setTimeout(() => setCopiedSql(false), 2500)
  }

  // Refresh user list
  const handleRefresh = () => {
    startTransition(async () => {
      const res = await getAdminUsersAction(search)
      if (res.success && res.users) {
        setUsers(res.users)
      }
    })
  }

  // Toggle role for user
  const handleToggleRole = (user: AdminUserItem) => {
    const newRole = !user.is_admin
    const confirmMsg = newRole
      ? `Bạn có chắc muốn cấp quyền Quản trị viên (Admin) cho tài khoản ${user.email}?`
      : `Bạn có chắc muốn hạ quyền Admin của tài khoản ${user.email} xuống Học viên thường?`

    if (!window.confirm(confirmMsg)) return

    setActionError(null)
    setActionSuccess(null)

    startTransition(async () => {
      const res = await toggleUserAdminRoleAction(user.id, newRole)
      if (!res.success) {
        setActionError(res.error || 'Thao tác không thành công')
        if ((res as any).needsMigration) {
          setShowSqlModal(true)
        }
      } else {
        setActionSuccess(`Đã ${newRole ? 'cấp quyền Admin cho' : 'thu hồi quyền Admin của'} ${user.email} thành công!`)
        // Optimistic update
        setUsers((prev) =>
          prev.map((u) => (u.id === user.id ? { ...u, is_admin: newRole } : u))
        )
        setTimeout(() => setActionSuccess(null), 4000)
      }
    })
  }

  // Filter users by search term
  const filteredUsers = users.filter((u) => {
    const term = search.toLowerCase().trim()
    if (!term) return true
    return (
      u.email.toLowerCase().includes(term) ||
      (u.display_name && u.display_name.toLowerCase().includes(term))
    )
  })

  const adminCount = users.filter((u) => u.is_admin).length
  const regularCount = users.length - adminCount

  return (
    <div className="space-y-6 font-serif">
      {/* 1. Header & Navigation Hub */}
      <div className="bg-card border border-border rounded-2xl p-6 shadow-2xs space-y-4">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 rounded-xl bg-app-accent-soft text-app-accent flex items-center justify-center border border-app-accent/20 shadow-2xs">
              <ShieldCheck className="w-6 h-6" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h1 className="text-xl md:text-2xl font-bold text-title">Trung tâm Quản trị & Phân quyền</h1>
                <span className="bg-app-accent text-white text-[10px] font-sans font-bold uppercase tracking-wider px-2 py-0.5 rounded-full">
                  Admin
                </span>
              </div>
              <p className="text-xs md:text-sm text-muted mt-0.5">
                Quản lý quyền hạn người dùng và xử lý báo lỗi, góp ý từ học viên
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2">
            <Link href="/admin/feedback">
              <Button
                variant="outline"
                className="font-serif text-xs h-9 gap-1.5 border-border hover:border-app-accent hover:text-app-accent"
              >
                <MessageSquareWarning className="w-3.5 h-3.5" />
                <span>Hộp thư góp ý & Báo lỗi</span>
                <ArrowRight className="w-3.5 h-3.5 ml-1" />
              </Button>
            </Link>
          </div>
        </div>

        {/* Database Status Notice */}
        {(!hasFeedbackTable || !hasIsAdminColumn) && (
          <div className="bg-amber-50 dark:bg-amber-950/20 border border-amber-200 dark:border-amber-800/40 rounded-xl p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs">
            <div className="flex items-start sm:items-center gap-2.5 text-amber-900 dark:text-amber-200">
              <AlertTriangle className="w-4 h-4 text-amber-600 flex-shrink-0 mt-0.5 sm:mt-0" />
              <span>
                Cơ sở dữ liệu Supabase cần chạy Script SQL để kích hoạt đầy đủ tính năng Phân quyền và Bảng Feedback.
              </span>
            </div>
            <Button
              size="sm"
              onClick={() => setShowSqlModal(true)}
              className="bg-amber-600 hover:bg-amber-700 text-white font-serif text-xs h-7 px-3 rounded-lg flex-shrink-0"
            >
              <Database className="w-3 h-3 mr-1.5" />
              Xem mã SQL kích hoạt
            </Button>
          </div>
        )}
      </div>

      {/* SQL Migration Modal / Drawer */}
      {showSqlModal && (
        <div className="bg-card border-2 border-app-accent/30 rounded-2xl p-6 shadow-md space-y-4 animate-in fade-in">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2 text-title font-bold text-base">
              <Database className="w-5 h-5 text-app-accent" />
              <span>Hướng dẫn kích hoạt Supabase Database (1 phút thực hiện)</span>
            </div>
            <button
              onClick={() => setShowSqlModal(false)}
              className="text-xs text-muted hover:text-title px-2 py-1 rounded"
            >
              Đóng lại ✕
            </button>
          </div>

          <p className="text-xs text-muted leading-relaxed">
            Để tính năng phân quyền trực tiếp trên bảng và nhận phản hồi hoạt động bền vững, bạn hãy copy đoạn script dưới đây và chạy trong <strong>Supabase Dashboard → SQL Editor</strong>:
          </p>

          <div className="relative">
            <pre className="bg-[#1C2233] text-gray-200 p-4 rounded-xl text-xs font-mono overflow-x-auto max-h-60 border border-border">
              {SQL_MIGRATION_SNIPPET}
            </pre>
            <Button
              size="sm"
              onClick={handleCopySql}
              className={`absolute top-2.5 right-2.5 font-serif text-xs h-8 px-3 rounded-lg transition-all shadow-sm ${
                copiedSql
                  ? 'bg-emerald-600 text-white'
                  : 'bg-app-accent hover:bg-app-accent/90 text-white'
              }`}
            >
              {copiedSql ? (
                <>
                  <Check className="w-3.5 h-3.5 mr-1" />
                  Đã sao chép SQL!
                </>
              ) : (
                <>
                  <Copy className="w-3.5 h-3.5 mr-1" />
                  Sao chép mã SQL
                </>
              )}
            </Button>
          </div>

          <div className="flex flex-wrap items-center gap-2 pt-1 text-[11px] text-muted">
            <span>Các bước:</span>
            <span className="bg-page px-2 py-0.5 rounded border border-border">1. Nhấn nút "Sao chép mã SQL"</span>
            <span>→</span>
            <span className="bg-page px-2 py-0.5 rounded border border-border">2. Mở Supabase → SQL Editor</span>
            <span>→</span>
            <span className="bg-page px-2 py-0.5 rounded border border-border">3. Dán và nhấn Run</span>
          </div>
        </div>
      )}

      {/* Alert Messages */}
      {actionError && (
        <div className="p-3 bg-red-50 text-red-700 border border-red-200 rounded-xl text-xs flex items-center justify-between">
          <span>{actionError}</span>
          <button onClick={() => setActionError(null)} className="font-bold ml-2">✕</button>
        </div>
      )}

      {actionSuccess && (
        <div className="p-3 bg-emerald-50 text-emerald-800 border border-emerald-200 rounded-xl text-xs flex items-center justify-between">
          <span>{actionSuccess}</span>
          <button onClick={() => setActionSuccess(null)} className="font-bold ml-2">✕</button>
        </div>
      )}

      {/* 2. User Stats Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div className="bg-card border border-border rounded-xl p-4 shadow-2xs">
          <p className="text-xs text-muted uppercase tracking-wider">Tổng số tài khoản</p>
          <div className="flex items-baseline justify-between mt-1">
            <span className="text-2xl font-bold text-title">{users.length}</span>
            <Users className="w-5 h-5 text-muted/60" />
          </div>
        </div>

        <div className="bg-card border border-border rounded-xl p-4 shadow-2xs">
          <p className="text-xs text-muted uppercase tracking-wider">Quản trị viên (Admin)</p>
          <div className="flex items-baseline justify-between mt-1">
            <span className="text-2xl font-bold text-app-accent">{adminCount}</span>
            <ShieldCheck className="w-5 h-5 text-app-accent/60" />
          </div>
        </div>

        <div className="bg-card border border-border rounded-xl p-4 shadow-2xs">
          <p className="text-xs text-muted uppercase tracking-wider">Học viên thường</p>
          <div className="flex items-baseline justify-between mt-1">
            <span className="text-2xl font-bold text-title">{regularCount}</span>
            <Users className="w-5 h-5 text-jade/60" />
          </div>
        </div>
      </div>

      {/* 3. User Role Management Table */}
      <div className="bg-card border border-border rounded-2xl shadow-2xs overflow-hidden">
        {/* Table Toolbar */}
        <div className="p-4 border-b border-border flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3">
          <div className="relative flex-1 max-w-sm">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted" />
            <input
              type="text"
              placeholder="Tìm theo email hoặc tên..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="w-full pl-9 pr-3 py-1.5 text-xs bg-page border border-border rounded-lg outline-none focus:border-app-accent font-sans"
            />
          </div>

          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="sm"
              onClick={handleRefresh}
              disabled={isPending}
              className="font-serif text-xs h-8 gap-1.5"
            >
              <RefreshCw className={`w-3.5 h-3.5 ${isPending ? 'animate-spin' : ''}`} />
              <span>Làm mới</span>
            </Button>
          </div>
        </div>

        {/* Table Content */}
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs border-collapse">
            <thead>
              <tr className="border-b border-border bg-page/40 text-muted uppercase tracking-wider font-semibold">
                <th className="py-3 px-4">Tài khoản</th>
                <th className="py-3 px-4">Email</th>
                <th className="py-3 px-4">Ngày tham gia</th>
                <th className="py-3 px-4">Vai trò hiện tại</th>
                <th className="py-3 px-4 text-right">Hành động phân quyền</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border">
              {filteredUsers.length === 0 ? (
                <tr>
                  <td colSpan={5} className="py-12 text-center text-muted">
                    <Users className="w-8 h-8 mx-auto mb-2 opacity-30" />
                    <p>Không tìm thấy tài khoản nào phù hợp.</p>
                  </td>
                </tr>
              ) : (
                filteredUsers.map((u) => {
                  const isCurrent = u.id === currentUserId || (currentUserEmail && u.email.toLowerCase() === currentUserEmail.toLowerCase())
                  const initial = (u.display_name || u.email)?.[0]?.toUpperCase() || 'U'

                  return (
                    <tr
                      key={u.id}
                      className={`hover:bg-page/50 transition-colors ${
                        isCurrent ? 'bg-app-accent-soft/20' : ''
                      }`}
                    >
                      {/* Name & Avatar */}
                      <td className="py-3 px-4">
                        <div className="flex items-center gap-2.5">
                          {u.avatar_url ? (
                            <img
                              src={u.avatar_url}
                              alt={u.display_name || u.email}
                              className="w-7 h-7 rounded-full object-cover border border-border flex-shrink-0"
                            />
                          ) : (
                            <div className="w-7 h-7 rounded-full bg-title text-white flex items-center justify-center font-bold text-xs flex-shrink-0">
                              {initial}
                            </div>
                          )}
                          <div className="min-w-0">
                            <p className="font-bold text-title truncate">
                              {u.display_name || 'Chưa đặt tên'}
                            </p>
                            {isCurrent && (
                              <span className="text-[10px] text-app-accent font-sans font-medium">
                                (Tài khoản của bạn)
                              </span>
                            )}
                          </div>
                        </div>
                      </td>

                      {/* Email */}
                      <td className="py-3 px-4 font-sans text-body">
                        {u.email}
                      </td>

                      {/* Created Date */}
                      <td className="py-3 px-4 text-muted font-sans whitespace-nowrap">
                        {u.created_at ? new Date(u.created_at).toLocaleDateString('vi-VN') : '—'}
                      </td>

                      {/* Role Badge */}
                      <td className="py-3 px-4">
                        {u.is_admin ? (
                          <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-app-accent-soft text-app-accent border border-app-accent/30">
                            <ShieldCheck className="w-3 h-3" />
                            Admin
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[11px] font-sans text-muted bg-page border border-border">
                            <Users className="w-3 h-3" />
                            Học viên
                          </span>
                        )}
                      </td>

                      {/* Actions */}
                      <td className="py-3 px-4 text-right">
                        {isCurrent ? (
                          <span className="text-[11px] text-muted italic">
                            Không thể tự hạ quyền
                          </span>
                        ) : u.is_admin ? (
                          <Button
                            size="sm"
                            variant="outline"
                            disabled={isPending}
                            onClick={() => handleToggleRole(u)}
                            className="font-serif text-xs h-7 px-2.5 text-red-600 border-red-200 hover:bg-red-50 hover:border-red-300 gap-1"
                          >
                            <UserX className="w-3 h-3" />
                            <span>Hạ xuống Học viên</span>
                          </Button>
                        ) : (
                          <Button
                            size="sm"
                            disabled={isPending}
                            onClick={() => handleToggleRole(u)}
                            className="font-serif text-xs h-7 px-2.5 bg-title hover:bg-app-accent text-white gap-1"
                          >
                            <UserCheck className="w-3 h-3" />
                            <span>Cấp quyền Admin</span>
                          </Button>
                        )}
                      </td>
                    </tr>
                  )
                })
              )}
            </tbody>
          </table>
        </div>

        {/* Footer info */}
        <div className="p-3 border-t border-border bg-page/30 flex items-center justify-between text-[11px] text-muted">
          <span>Hiển thị {filteredUsers.length} tài khoản</span>
          <span>Bảo mật: Chỉ tài khoản Admin mới có quyền truy cập khu vực này</span>
        </div>
      </div>
    </div>
  )
}
