'use client'

import { useState, useTransition, useEffect, useRef, useMemo } from 'react'
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
  ArrowRight,
  ChevronLeft,
  ChevronRight,
  ChevronsLeft,
  ChevronsRight,
  Loader2,
  X,
  Radio,
  Activity,
  Wifi,
  WifiOff,
  Clock,
  Filter,
  GraduationCap,
  Sparkles,
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { MascotAvatar } from '@/components/mascot/mascot-avatar'
import {
  AdminUserItem,
  AdminStats,
  AdminPagination,
  toggleUserAdminRoleAction,
  getAdminUsersAction,
} from '@/app/actions/admin'
import { usePresence } from '@/components/presence/presence-context'

interface AdminPortalClientProps {
  initialUsers: AdminUserItem[]
  initialStats?: AdminStats
  initialPagination?: AdminPagination
  currentUserId?: string
  hasFeedbackTable: boolean
  hasIsAdminColumn: boolean
  hasLastSeenAtColumn?: boolean
  currentUserEmail?: string
}

const SQL_MIGRATION_SNIPPET = `-- 1. Bổ sung cột is_admin vào bảng profiles (nếu chưa có)
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS is_admin boolean DEFAULT false;

-- 2. Gán quyền Admin vĩnh viễn cho tài khoản gốc
UPDATE public.profiles 
SET is_admin = true 
WHERE lower(email) = 'khoadev27@gmail.com';

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

CREATE INDEX IF NOT EXISTS idx_feedback_status ON public.feedback(status);
CREATE INDEX IF NOT EXISTS idx_feedback_created_at ON public.feedback(created_at DESC);

-- 4. Kích hoạt RLS cho feedback
ALTER TABLE public.feedback ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can insert feedback" ON public.feedback;
CREATE POLICY "Anyone can insert feedback" ON public.feedback FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Users can view own feedback" ON public.feedback;
CREATE POLICY "Users can view own feedback" ON public.feedback FOR SELECT USING (auth.uid() = user_id);

-- 5. Hàm kiểm tra quyền Admin an toàn (Security Definer, Zero Recursion)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean LANGUAGE sql SECURITY DEFINER STABLE SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true
  );
$$;
REVOKE ALL ON FUNCTION public.is_admin() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_admin() TO authenticated;

-- Policy feedback cho Admin
DROP POLICY IF EXISTS "Admins can view all feedback" ON public.feedback;
CREATE POLICY "Admins can view all feedback" ON public.feedback FOR SELECT USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can update feedback" ON public.feedback;
CREATE POLICY "Admins can update feedback" ON public.feedback FOR UPDATE USING (public.is_admin());

-- 6. Cập nhật chính sách RLS cho bảng profiles (Sửa lỗi thiếu tài khoản)
DROP POLICY IF EXISTS "Users can view own profile." ON public.profiles;
DROP POLICY IF EXISTS "Profiles select policy" ON public.profiles;
CREATE POLICY "Profiles select policy" ON public.profiles FOR SELECT TO authenticated
USING (auth.uid() = id OR public.is_admin());

-- 7. Bảo vệ hồ sơ & chống leo thang đặc quyền (Privilege Escalation)
DROP POLICY IF EXISTS "Users can update own profile." ON public.profiles;
DROP POLICY IF EXISTS "Users can update own profile non-sensitive" ON public.profiles;
CREATE POLICY "Users can update own profile non-sensitive" ON public.profiles FOR UPDATE TO authenticated
USING (auth.uid() = id)
WITH CHECK (
  auth.uid() = id AND is_admin = (SELECT p.is_admin FROM public.profiles p WHERE p.id = auth.uid())
);

-- Trigger chặn sửa is_admin ở tầng DB Engine
CREATE OR REPLACE FUNCTION public.protect_profile_role_change()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, pg_temp AS $$
BEGIN
  IF (NEW.is_admin IS DISTINCT FROM OLD.is_admin) THEN
    IF NOT public.is_admin() THEN
      RAISE EXCEPTION 'Access Denied: Bạn không có quyền thay đổi vai trò quản trị.' USING errcode = '42501';
    END IF;
  END IF;
  RETURN NEW;
END;
$$;
REVOKE ALL ON FUNCTION public.protect_profile_role_change() FROM PUBLIC;
DROP TRIGGER IF EXISTS tr_protect_profile_role_change ON public.profiles;
CREATE TRIGGER tr_protect_profile_role_change BEFORE UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.protect_profile_role_change();

-- 8. RPC chuyên biệt để Admin đổi quyền tài khoản
CREATE OR REPLACE FUNCTION public.set_user_admin_role(target_user_id uuid, new_is_admin boolean)
RETURNS jsonb LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, pg_temp AS $$
DECLARE
  calling_user_id uuid; caller_is_admin boolean; target_email text;
BEGIN
  calling_user_id := auth.uid();
  IF calling_user_id IS NULL THEN
    RAISE EXCEPTION 'Unauthorized: Yêu cầu đăng nhập.' USING errcode = '28000';
  END IF;
  SELECT is_admin INTO caller_is_admin FROM public.profiles WHERE id = calling_user_id;
  IF caller_is_admin IS NOT TRUE THEN
    RAISE EXCEPTION 'Forbidden: Chỉ quản trị viên mới được thao tác.' USING errcode = '42501';
  END IF;
  IF calling_user_id = target_user_id AND new_is_admin = FALSE THEN
    RAISE EXCEPTION 'Bad Request: Không thể tự hạ quyền của chính mình.' USING errcode = '22000';
  END IF;
  UPDATE public.profiles SET is_admin = new_is_admin WHERE id = target_user_id RETURNING email INTO target_email;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Not Found: Không tìm thấy tài khoản.' USING errcode = 'P0002';
  END IF;
  RETURN jsonb_build_object('success', true, 'target_user_id', target_user_id, 'email', target_email, 'is_admin', new_is_admin);
END;
$$;
REVOKE ALL ON FUNCTION public.set_user_admin_role(uuid, boolean) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.set_user_admin_role(uuid, boolean) TO authenticated;

-- 9. Active Users Monitoring (last_seen_at và RPC touch_user_activity)
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS last_seen_at timestamp with time zone DEFAULT timezone('utc'::text, now());

CREATE INDEX IF NOT EXISTS idx_profiles_last_seen_at ON public.profiles(last_seen_at DESC);

CREATE OR REPLACE FUNCTION public.touch_user_activity()
RETURNS void LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, pg_temp AS $$
DECLARE
  current_uid uuid := auth.uid();
BEGIN
  IF current_uid IS NULL THEN RETURN; END IF;
  UPDATE public.profiles
  SET last_seen_at = now()
  WHERE id = current_uid
    AND (last_seen_at IS NULL OR last_seen_at < now() - interval '2 minutes');
END;
$$;
REVOKE ALL ON FUNCTION public.touch_user_activity() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.touch_user_activity() TO authenticated;`

/**
 * Format relative time (e.g., Vừa xong, 5 phút trước, 2 giờ trước)
 */
function formatRelativeTime(dateStr?: string | null): string {
  if (!dateStr) return 'Chưa ghi nhận'
  const time = new Date(dateStr).getTime()
  if (isNaN(time)) return 'Chưa ghi nhận'
  const diffSec = Math.floor((Date.now() - time) / 1000)

  if (diffSec < 60) return 'Vừa xong'
  if (diffSec < 3600) return `${Math.floor(diffSec / 60)} phút trước`
  if (diffSec < 86400) return `${Math.floor(diffSec / 3600)} giờ trước`
  if (diffSec < 172800) return 'Hôm qua'
  return new Date(dateStr).toLocaleDateString('vi-VN', {
    day: '2-digit',
    month: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
  })
}

export function AdminPortalClient({
  initialUsers,
  initialStats,
  initialPagination,
  currentUserId,
  hasFeedbackTable,
  hasIsAdminColumn,
  hasLastSeenAtColumn,
  currentUserEmail,
}: AdminPortalClientProps) {
  const [users, setUsers] = useState<AdminUserItem[]>(initialUsers)
  const [stats, setStats] = useState<AdminStats>(
    initialStats || {
      totalUsers: initialUsers.length,
      adminCount: initialUsers.filter((u) => u.is_admin).length,
      regularCount: initialUsers.filter((u) => !u.is_admin).length,
      active24hCount: 0,
      onlineFallbackCount: 0,
    }
  )
  const [referenceTime] = useState<number>(() => Date.now())

  // Lấy dữ liệu Presence tập trung từ PresenceProvider (dùng chung 1 WebSocket channel duy nhất toàn app)
  const {
    onlineCount: realtimeOnlineCount,
    onlineUserIds,
    realtimeStatus,
  } = usePresence()

  // Số lượng hiển thị: ưu tiên Realtime nếu đang kết nối, fallback DB nếu lỗi mạng, không hiển thị số 0 giả
  const onlineCount = realtimeStatus === 'error'
    ? (stats.onlineFallbackCount || realtimeOnlineCount)
    : (realtimeOnlineCount || stats.onlineFallbackCount || 0)

  const [roleFilter, setRoleFilter] = useState<'all' | 'online' | 'active24h' | 'admin' | 'regular'>('all')

  const [page, setPage] = useState<number>(initialPagination?.page || 1)
  const [pageSize] = useState<number>(initialPagination?.pageSize || 20)
  const [totalItems, setTotalItems] = useState<number>(initialPagination?.totalItems ?? initialUsers.length)
  const [totalPages, setTotalPages] = useState<number>(
    initialPagination?.totalPages || Math.max(1, Math.ceil((initialPagination?.totalItems ?? initialUsers.length) / 20))
  )

  const [searchInput, setSearchInput] = useState('')
  const [debouncedSearch, setDebouncedSearch] = useState('')
  const [copiedSql, setCopiedSql] = useState(false)
  const [showSqlModal, setShowSqlModal] = useState(!hasFeedbackTable || !hasIsAdminColumn || !hasLastSeenAtColumn)
  const [actionError, setActionError] = useState<string | null>(null)
  const [actionSuccess, setActionSuccess] = useState<string | null>(null)
  const [isPending, startTransition] = useTransition()

  const isInitialMount = useRef(true)
  const tableTopRef = useRef<HTMLDivElement>(null)

  // 1. Debounce search input (400ms)
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedSearch(searchInput.trim())
    }, 400)
    return () => clearTimeout(handler)
  }, [searchInput])

  // Helper: Load users from server
  const loadUsers = (targetPage: number, searchKeyword: string) => {
    setActionError(null)
    startTransition(async () => {
      const res = await getAdminUsersAction({
        page: targetPage,
        pageSize,
        search: searchKeyword,
      })

      if (res.success && res.users) {
        setUsers(res.users)
        setTotalItems(res.pagination.totalItems)
        setTotalPages(res.pagination.totalPages)
        setPage(res.pagination.page)
        if (res.stats) {
          setStats(res.stats)
        }
      } else if (res.error) {
        setActionError(res.error)
      }
    })
  }

  // 3. Trigger search when debounced keyword changes (always reset to page 1)
  useEffect(() => {
    if (isInitialMount.current) {
      isInitialMount.current = false
      return
    }
    setPage(1)
    loadUsers(1, debouncedSearch)
  }, [debouncedSearch])

  // Copy SQL script to clipboard
  const handleCopySql = () => {
    navigator.clipboard.writeText(SQL_MIGRATION_SNIPPET)
    setCopiedSql(true)
    setTimeout(() => setCopiedSql(false), 2500)
  }

  // Refresh current page
  const handleRefresh = () => {
    loadUsers(page, debouncedSearch)
  }

  // Page change handler with smooth scroll to table top
  const handlePageChange = (newPage: number) => {
    if (newPage === page || newPage < 1 || newPage > totalPages || isPending) return
    setPage(newPage)
    loadUsers(newPage, debouncedSearch)
    if (tableTopRef.current) {
      tableTopRef.current.scrollIntoView({ behavior: 'smooth', block: 'start' })
    }
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
        // Refresh from server to ensure global stats and database state are 100% in sync
        loadUsers(page, debouncedSearch)
        setTimeout(() => setActionSuccess(null), 4000)
      }
    })
  }

  // Lọc tài khoản theo tab filter
  const displayedUsers = useMemo(() => {
    const twentyFourHoursAgo = referenceTime - 24 * 60 * 60 * 1000
    return users.filter((u) => {
      if (roleFilter === 'online') {
        return onlineUserIds.has(u.id)
      }
      if (roleFilter === 'active24h') {
        if (!u.last_seen_at) return false
        return new Date(u.last_seen_at).getTime() >= twentyFourHoursAgo
      }
      if (roleFilter === 'admin') {
        return u.is_admin
      }
      if (roleFilter === 'regular') {
        return !u.is_admin
      }
      return true
    })
  }, [users, roleFilter, onlineUserIds, referenceTime])

  // Generate page numbers with ellipsis for large datasets
  const pageNumbers = useMemo(() => {
    if (totalPages <= 7) {
      return Array.from({ length: totalPages }, (_, i) => i + 1)
    }
    if (page <= 4) {
      return [1, 2, 3, 4, 5, 'ellipsis', totalPages]
    }
    if (page >= totalPages - 3) {
      return [1, 'ellipsis', totalPages - 4, totalPages - 3, totalPages - 2, totalPages - 1, totalPages]
    }
    return [1, 'ellipsis', page - 1, page, page + 1, 'ellipsis', totalPages]
  }, [page, totalPages])

  const itemFrom = totalItems === 0 ? 0 : (page - 1) * pageSize + 1
  const itemTo = Math.min(page * pageSize, totalItems)

  return (
    <div className="space-y-6 font-serif">
      {/* 1. Header & Navigation Hub (The Mandarin Lab Inspired EdTech Style) */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-white via-[#FFF9F3] to-[#FFFDF9] dark:from-[#182238] dark:to-[#1E293B] border-2 border-[#182238]/15 dark:border-[#384869] p-5 sm:p-7 shadow-[0_6px_0_#182238]/10 dark:shadow-[0_6px_0_#0D1322] space-y-4">
        {/* Top decorative accent line */}
        <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-title via-app-accent to-gold" />

        {/* Decorative Watermark */}
        <div className="absolute -right-4 -bottom-6 select-none pointer-events-none opacity-[0.04] dark:opacity-[0.07] font-hanzi text-8xl md:text-9xl font-bold text-title">
          管理
        </div>

        <div className="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-5">
          <div className="flex items-center gap-3.5">
            <div className="w-13 h-13 rounded-2xl bg-[#B8322D]/10 text-[#B8322D] flex items-center justify-center border-2 border-[#B8322D]/25 shadow-xs">
              <ShieldCheck className="w-7 h-7" />
            </div>
            <div>
              <div className="flex items-center gap-2 flex-wrap">
                <h1 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-title tracking-tight">
                  Trung tâm Quản trị & Phân quyền
                </h1>
                <span className="bg-[#B8322D] text-white text-[11px] font-sans font-bold uppercase tracking-wider px-2.5 py-0.5 rounded-full shadow-2xs">
                  Admin Portal
                </span>
              </div>
              <p className="text-xs sm:text-sm text-muted font-serif mt-1">
                Theo dõi học viên đang online thời gian thực và quản lý quyền hạn hệ thống
              </p>
            </div>
          </div>

          <div className="flex items-center gap-3 self-start md:self-center">
            {/* Mascot Avatar Widget */}
            <div className="hidden xl:flex items-center gap-2.5 px-3.5 py-1.5 rounded-2xl bg-white/80 dark:bg-[#1E2530] border border-[#182238]/15 shadow-2xs">
              <MascotAvatar state="idle" size="sm" />
              <div className="text-[11px] font-serif leading-tight">
                <p className="font-bold text-[#182238] dark:text-white">Tiểu Bút 🐼</p>
                <p className="text-muted text-[10px]">Hệ thống ổn định</p>
              </div>
            </div>

            <Link href="/admin/feedback">
              <Button
                variant="outline"
                className="font-serif text-xs min-h-[44px] px-4 gap-2 rounded-2xl border-2 border-[#182238]/20 bg-white hover:bg-[#FFF9F3] text-title shadow-[0_2px_0_#182238]/10 cursor-pointer"
              >
                <MessageSquareWarning className="w-4 h-4 text-app-accent" />
                <span>Hộp thư góp ý & Báo lỗi</span>
                <ArrowRight className="w-3.5 h-3.5 ml-1" />
              </Button>
            </Link>
          </div>
        </div>

        {/* Database Status Notice */}
        {(!hasFeedbackTable || !hasIsAdminColumn || !hasLastSeenAtColumn) && (
          <div className="bg-amber-50 dark:bg-amber-950/20 border border-amber-200 dark:border-amber-800/40 rounded-xl p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs">
            <div className="flex items-start sm:items-center gap-2.5 text-amber-900 dark:text-amber-200">
              <AlertTriangle className="w-4 h-4 text-amber-600 flex-shrink-0 mt-0.5 sm:mt-0" />
              <span>
                Cơ sở dữ liệu Supabase cần chạy Script SQL cập nhật để kích hoạt đầy đủ Active Users Monitoring, Phân quyền và Feedback.
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
            Để tính năng thống kê Online, hoạt động 24h và phân quyền hoạt động ổn định, bạn hãy copy đoạn script dưới đây và chạy trong <strong>Supabase Dashboard → SQL Editor</strong>:
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
            <span className="bg-page px-2 py-0.5 rounded border border-border">1. Nhấn nút &quot;Sao chép mã SQL&quot;</span>
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

      {/* 2. Global User Stats Cards (Vibrant EdTech Cards) */}
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-3 sm:gap-4">
        {/* Thẻ 1: Tổng số tài khoản */}
        <div className="rounded-2xl bg-gradient-to-br from-indigo-500/10 via-white to-indigo-500/5 dark:from-[#1E2530] dark:to-[#182238] border-2 border-indigo-200/80 dark:border-indigo-900/60 p-4 shadow-[0_4px_0_#C7D2FE] dark:shadow-[0_4px_0_#1E1B4B] transition-transform hover:-translate-y-0.5 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] text-indigo-900 dark:text-indigo-300 font-bold uppercase tracking-wider font-sans">Tổng tài khoản</span>
            <div className="w-8 h-8 rounded-xl bg-indigo-600 text-white flex items-center justify-center shadow-xs">
              <Users className="w-4 h-4" />
            </div>
          </div>
          <div className="mt-3">
            <div className="text-2xl sm:text-3xl font-extrabold text-indigo-950 dark:text-white font-serif">{stats.totalUsers}</div>
            <p className="text-[10px] text-indigo-800/70 dark:text-indigo-300/70 font-sans mt-0.5">Đã đăng ký hệ thống</p>
          </div>
        </div>

        {/* Thẻ 2: Đang Online (Realtime Presence) */}
        <div className="rounded-2xl bg-gradient-to-br from-emerald-500/15 via-white to-emerald-500/5 dark:from-[#1E2530] dark:to-[#182238] border-2 border-emerald-300 dark:border-emerald-800/80 p-4 shadow-[0_4px_0_#6EE7B7] dark:shadow-[0_4px_0_#064E3B] transition-transform hover:-translate-y-0.5 relative overflow-hidden flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] text-emerald-900 dark:text-emerald-300 font-bold uppercase tracking-wider font-sans flex items-center gap-1.5">
              <span className="relative flex h-2 w-2">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
              </span>
              <span>Đang online</span>
            </span>
            <div className="w-8 h-8 rounded-xl bg-emerald-600 text-white flex items-center justify-center shadow-xs">
              <Radio className="w-4 h-4 animate-pulse" />
            </div>
          </div>
          <div className="mt-3">
            <div className="flex items-baseline gap-2">
              <span className="text-2xl sm:text-3xl font-extrabold text-emerald-800 dark:text-emerald-300 font-serif">{onlineCount}</span>
              <span className="text-[10px] font-sans font-bold px-2 py-0.5 rounded-full bg-emerald-100 text-emerald-800 dark:bg-emerald-900/60 dark:text-emerald-200 border border-emerald-300 dark:border-emerald-700">
                {realtimeStatus === 'connected' ? 'Trực tiếp' : 'Đang kết nối'}
              </span>
            </div>
            <p className="text-[10px] text-emerald-800/70 dark:text-emerald-300/70 font-sans mt-0.5">Theo dõi Realtime Presence</p>
          </div>
        </div>

        {/* Thẻ 3: Hoạt động 24h */}
        <div className="rounded-2xl bg-gradient-to-br from-sky-500/10 via-white to-sky-500/5 dark:from-[#1E2530] dark:to-[#182238] border-2 border-sky-200/80 dark:border-sky-900/60 p-4 shadow-[0_4px_0_#BAE6FD] dark:shadow-[0_4px_0_#0C4A6E] transition-transform hover:-translate-y-0.5 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] text-sky-900 dark:text-sky-300 font-bold uppercase tracking-wider font-sans">Hoạt động 24h</span>
            <div className="w-8 h-8 rounded-xl bg-sky-500 text-white flex items-center justify-center shadow-xs">
              <Activity className="w-4 h-4" />
            </div>
          </div>
          <div className="mt-3">
            <div className="text-2xl sm:text-3xl font-extrabold text-sky-950 dark:text-white font-serif">{stats.active24hCount}</div>
            <p className="text-[10px] text-sky-800/70 dark:text-sky-300/70 font-sans mt-0.5">Tài khoản tương tác hôm nay</p>
          </div>
        </div>

        {/* Thẻ 4: Quản trị viên (Admin) */}
        <div className="rounded-2xl bg-gradient-to-br from-rose-500/10 via-white to-rose-500/5 dark:from-[#1E2530] dark:to-[#182238] border-2 border-rose-200/80 dark:border-rose-900/60 p-4 shadow-[0_4px_0_#FECDD3] dark:shadow-[0_4px_0_#4C0519] transition-transform hover:-translate-y-0.5 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] text-rose-900 dark:text-rose-300 font-bold uppercase tracking-wider font-sans">Quản trị viên</span>
            <div className="w-8 h-8 rounded-xl bg-[#B8322D] text-white flex items-center justify-center shadow-xs">
              <ShieldCheck className="w-4 h-4" />
            </div>
          </div>
          <div className="mt-3">
            <div className="text-2xl sm:text-3xl font-extrabold text-[#B8322D] dark:text-rose-400 font-serif">{stats.adminCount}</div>
            <p className="text-[10px] text-rose-800/70 dark:text-rose-300/70 font-sans mt-0.5">Quyền Admin hệ thống</p>
          </div>
        </div>

        {/* Thẻ 5: Học viên thường */}
        <div className="rounded-2xl bg-gradient-to-br from-amber-500/10 via-white to-amber-500/5 dark:from-[#1E2530] dark:to-[#182238] border-2 border-amber-200/80 dark:border-amber-900/60 p-4 shadow-[0_4px_0_#FDE68A] dark:shadow-[0_4px_0_#451A03] transition-transform hover:-translate-y-0.5 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] text-amber-900 dark:text-amber-300 font-bold uppercase tracking-wider font-sans">Học viên thường</span>
            <div className="w-8 h-8 rounded-xl bg-amber-500 text-white flex items-center justify-center shadow-xs">
              <GraduationCap className="w-4 h-4" />
            </div>
          </div>
          <div className="mt-3">
            <div className="text-2xl sm:text-3xl font-extrabold text-amber-950 dark:text-white font-serif">{stats.regularCount}</div>
            <p className="text-[10px] text-amber-800/70 dark:text-amber-300/70 font-sans mt-0.5">Người học tiêu chuẩn</p>
          </div>
        </div>
      </div>

      {/* 3. User Role Management Table with Server Pagination & Activity Filters */}
      <div ref={tableTopRef} className="scroll-mt-6 bg-white dark:bg-[#182238] border-2 border-[#182238]/15 dark:border-[#384869] rounded-3xl shadow-[0_6px_0_#182238]/8 dark:shadow-[0_6px_0_#0D1322] overflow-hidden">
        {/* Table Toolbar */}
        <div className="p-4 sm:p-5 border-b-2 border-[#182238]/10 dark:border-slate-700/80 bg-[#FAF7F2]/60 dark:bg-[#182238] flex flex-col lg:flex-row items-stretch lg:items-center justify-between gap-3.5">
          <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 flex-1">
            {/* Search Input */}
            <div className="relative flex-1 max-w-sm">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted" />
              <input
                type="text"
                placeholder="Tìm theo email hoặc tên..."
                value={searchInput}
                onChange={(e) => setSearchInput(e.target.value)}
                className="w-full pl-9 pr-8 py-2 text-xs bg-white dark:bg-[#1E2530] border-2 border-[#182238]/15 dark:border-slate-700 rounded-xl outline-none focus:border-app-accent font-serif shadow-xs"
              />
              {searchInput && (
                <button
                  type="button"
                  onClick={() => setSearchInput('')}
                  className="absolute right-2.5 top-1/2 -translate-y-1/2 text-muted hover:text-title p-0.5 rounded"
                  title="Xóa tìm kiếm"
                >
                  <X className="w-3.5 h-3.5" />
                </button>
              )}
            </div>

            {/* Filter Tabs (Tactile sticker pills) */}
            <div className="flex items-center gap-1.5 overflow-x-auto pb-1 sm:pb-0 no-scrollbar">
              <button
                type="button"
                onClick={() => setRoleFilter('all')}
                className={`px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer whitespace-nowrap border-2 ${
                  roleFilter === 'all'
                    ? 'bg-[#182238] text-white border-[#182238] shadow-[0_2px_0_#0D1322]'
                    : 'bg-white dark:bg-[#1E2530] text-[#182238]/80 dark:text-slate-200 hover:text-[#182238] border-[#182238]/15 dark:border-slate-700 shadow-2xs hover:bg-[#FFF9F3]'
                }`}
              >
                Tất cả ({totalItems})
              </button>
              <button
                type="button"
                onClick={() => setRoleFilter('online')}
                className={`px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer whitespace-nowrap flex items-center gap-1.5 border-2 ${
                  roleFilter === 'online'
                    ? 'bg-emerald-600 text-white border-emerald-700 shadow-[0_2px_0_#065F46]'
                    : 'bg-white dark:bg-[#1E2530] text-emerald-800 dark:text-emerald-300 border-[#182238]/15 dark:border-slate-700 shadow-2xs hover:bg-emerald-50/50'
                }`}
              >
                <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></span>
                <span>Online ({onlineUserIds.size})</span>
              </button>
              <button
                type="button"
                onClick={() => setRoleFilter('active24h')}
                className={`px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer whitespace-nowrap border-2 ${
                  roleFilter === 'active24h'
                    ? 'bg-sky-600 text-white border-sky-700 shadow-[0_2px_0_#0369A1]'
                    : 'bg-white dark:bg-[#1E2530] text-sky-800 dark:text-sky-300 border-[#182238]/15 dark:border-slate-700 shadow-2xs hover:bg-sky-50/50'
                }`}
              >
                Hoạt động 24h ({stats.active24hCount})
              </button>
              <button
                type="button"
                onClick={() => setRoleFilter('admin')}
                className={`px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer whitespace-nowrap border-2 ${
                  roleFilter === 'admin'
                    ? 'bg-[#B8322D] text-white border-[#9E2A25] shadow-[0_2px_0_#7A1D1A]'
                    : 'bg-white dark:bg-[#1E2530] text-[#B8322D] border-[#182238]/15 dark:border-slate-700 shadow-2xs hover:bg-rose-50/50'
                }`}
              >
                Admin ({stats.adminCount})
              </button>
              <button
                type="button"
                onClick={() => setRoleFilter('regular')}
                className={`px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer whitespace-nowrap border-2 ${
                  roleFilter === 'regular'
                    ? 'bg-amber-600 text-white border-amber-700 shadow-[0_2px_0_#B45309]'
                    : 'bg-white dark:bg-[#1E2530] text-amber-900 dark:text-amber-300 border-[#182238]/15 dark:border-slate-700 shadow-2xs hover:bg-amber-50/50'
                }`}
              >
                Học viên ({stats.regularCount})
              </button>
            </div>
          </div>

          <div className="flex items-center gap-2 justify-end">
            {isPending && (
              <div className="flex items-center gap-1.5 text-xs text-app-accent font-sans animate-in fade-in">
                <Loader2 className="w-3.5 h-3.5 animate-spin" />
                <span className="hidden sm:inline">Đang tải...</span>
              </div>
            )}
            <Button
              variant="outline"
              size="sm"
              onClick={handleRefresh}
              disabled={isPending}
              className="font-serif text-xs min-h-[38px] px-3.5 rounded-xl border-2 border-[#182238]/20 bg-white hover:bg-[#FFF9F3] text-title shadow-2xs cursor-pointer"
            >
              <RefreshCw className={`w-3.5 h-3.5 ${isPending ? 'animate-spin text-app-accent' : ''}`} />
              <span>Làm mới</span>
            </Button>
          </div>
        </div>

        {/* Mobile Card List (md:hidden) */}
        <div className={`md:hidden divide-y divide-border transition-opacity duration-150 ${isPending ? 'opacity-60' : 'opacity-100'}`}>
          {displayedUsers.length === 0 ? (
            <div className="py-12 px-4 text-center text-muted">
              <Users className="w-8 h-8 mx-auto mb-2 opacity-30" />
              <p className="font-semibold text-title">Không tìm thấy tài khoản nào phù hợp.</p>
              {debouncedSearch ? (
                <p className="text-xs text-muted mt-1 font-sans">
                  Không có kết quả nào khớp với từ khóa &ldquo;{debouncedSearch}&rdquo;.
                </p>
              ) : roleFilter !== 'all' ? (
                <p className="text-xs text-muted mt-1 font-sans">
                  Không có tài khoản nào thuộc bộ lọc đang chọn trên trang này.
                </p>
              ) : null}
            </div>
          ) : (
            displayedUsers.map((u) => {
              const isCurrent = u.id === currentUserId || (currentUserEmail && u.email.toLowerCase() === currentUserEmail.toLowerCase())
              const initial = (u.display_name || u.email)?.[0]?.toUpperCase() || 'U'
              const isOnline = onlineUserIds.has(u.id)

              return (
                <div
                  key={u.id}
                  className={`p-4 space-y-3 transition-colors ${
                    isCurrent ? 'bg-app-accent-soft/20' : 'bg-card'
                  }`}
                >
                  {/* Top: Avatar, Name, Email, Role badge */}
                  <div className="flex items-start justify-between gap-2.5">
                    <div className="flex items-center gap-2.5 min-w-0">
                      <div className="relative flex-shrink-0">
                        {u.avatar_url ? (
                          <img
                            src={u.avatar_url}
                            alt={u.display_name || u.email}
                            className="w-9 h-9 rounded-full object-cover border border-border"
                          />
                        ) : (
                          <div className="w-9 h-9 rounded-full bg-title text-white flex items-center justify-center font-bold text-xs">
                            {initial}
                          </div>
                        )}
                        {isOnline && (
                          <span
                            className="absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 bg-emerald-500 border-2 border-card rounded-full"
                            title="Đang online"
                          />
                        )}
                      </div>
                      <div className="min-w-0">
                        <div className="flex items-center gap-1.5 flex-wrap">
                          <p className="font-bold text-title text-sm truncate">
                            {u.display_name || 'Chưa đặt tên'}
                          </p>
                          {isCurrent && (
                            <span className="text-[10px] text-app-accent font-sans font-medium bg-app-accent-soft px-1.5 py-0.5 rounded">
                              Bạn
                            </span>
                          )}
                        </div>
                        <p className="text-xs text-muted font-sans truncate">
                          {u.email}
                        </p>
                      </div>
                    </div>

                    <div className="flex-shrink-0">
                      {u.is_admin ? (
                        <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-app-accent-soft text-app-accent border border-app-accent/30">
                          <ShieldCheck className="w-3 h-3" />
                          Admin
                        </span>
                      ) : (
                        <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[11px] font-sans text-muted bg-page border border-border">
                          <Users className="w-3 h-3" />
                          Học viên
                        </span>
                      )}
                    </div>
                  </div>

                  {/* Mid: Online Status & Created Date */}
                  <div className="flex items-center justify-between text-xs font-sans text-muted pt-1">
                    <div>
                      {isOnline ? (
                        <div className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-full text-[11px] font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200">
                          <span className="relative flex h-2 w-2">
                            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                            <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
                          </span>
                          <span>Đang online</span>
                        </div>
                      ) : (
                        <div className="flex items-center gap-1 text-muted text-xs">
                          <Clock className="w-3 h-3 text-muted/60" />
                          <span>{formatRelativeTime(u.last_seen_at)}</span>
                        </div>
                      )}
                    </div>
                    <span className="text-[11px] text-muted">
                      {u.created_at ? new Date(u.created_at).toLocaleDateString('vi-VN') : '—'}
                    </span>
                  </div>

                  {/* Bottom: Action */}
                  <div className="pt-2 border-t border-border/50">
                    {isCurrent ? (
                      <span className="text-[11px] text-muted italic block text-center py-1">
                        Không thể tự hạ quyền của chính mình
                      </span>
                    ) : u.is_admin ? (
                      <Button
                        size="sm"
                        variant="destructive"
                        disabled={isPending}
                        onClick={() => handleToggleRole(u)}
                        className="w-full font-serif text-xs min-h-[44px] gap-1.5 cursor-pointer"
                      >
                        <UserX className="w-3.5 h-3.5" />
                        <span>Hạ xuống Học viên</span>
                      </Button>
                    ) : (
                      <Button
                        size="sm"
                        variant="primary"
                        disabled={isPending}
                        onClick={() => handleToggleRole(u)}
                        className="w-full font-serif text-xs min-h-[44px] gap-1.5 cursor-pointer"
                      >
                        <UserCheck className="w-3.5 h-3.5" />
                        <span>Cấp quyền Admin</span>
                      </Button>
                    )}
                  </div>
                </div>
              )
            })
          )}
        </div>

        {/* Desktop Table Content (hidden md:block) */}
        <div className="hidden md:block overflow-x-auto relative">
          <table className="w-full text-left text-xs border-collapse">
            <thead>
              <tr className="border-b-2 border-[#182238]/15 bg-[#FAF7F2] text-[#182238] uppercase tracking-wider font-bold font-serif text-[11px]">
                <th className="py-3.5 px-4">Tài khoản</th>
                <th className="py-3.5 px-4">Email</th>
                <th className="py-3.5 px-4">Trạng thái / Hoạt động</th>
                <th className="py-3.5 px-4">Ngày tham gia</th>
                <th className="py-3.5 px-4">Vai trò hiện tại</th>
                <th className="py-3.5 px-4 text-right">Hành động phân quyền</th>
              </tr>
            </thead>
            <tbody className={`divide-y divide-[#182238]/10 transition-opacity duration-150 ${isPending ? 'opacity-60' : 'opacity-100'}`}>
              {displayedUsers.length === 0 ? (
                <tr>
                  <td colSpan={6} className="py-12 text-center text-muted">
                    <Users className="w-8 h-8 mx-auto mb-2 opacity-30" />
                    <p className="font-semibold text-title font-serif">Không tìm thấy tài khoản nào phù hợp.</p>
                    {debouncedSearch ? (
                      <p className="text-xs text-muted mt-1 font-sans">
                        Không có kết quả nào khớp với từ khóa &ldquo;{debouncedSearch}&rdquo;.
                      </p>
                    ) : roleFilter !== 'all' ? (
                      <p className="text-xs text-muted mt-1 font-sans">
                        Không có tài khoản nào thuộc bộ lọc đang chọn trên trang này.
                      </p>
                    ) : null}
                  </td>
                </tr>
              ) : (
                displayedUsers.map((u) => {
                  const isCurrent = u.id === currentUserId || (currentUserEmail && u.email.toLowerCase() === currentUserEmail.toLowerCase())
                  const initial = (u.display_name || u.email)?.[0]?.toUpperCase() || 'U'
                  const isOnline = onlineUserIds.has(u.id)

                  return (
                    <tr
                      key={u.id}
                      className={`hover:bg-[#FFF9F3] transition-colors ${
                        isCurrent ? 'bg-[#FAF7F2]/80' : ''
                      }`}
                    >
                      {/* Name & Avatar with Online status dot */}
                      <td className="py-3.5 px-4">
                        <div className="flex items-center gap-2.5">
                          <div className="relative flex-shrink-0">
                            {u.avatar_url ? (
                              <img
                                src={u.avatar_url}
                                alt={u.display_name || u.email}
                                className="w-8 h-8 rounded-xl object-cover border-2 border-[#182238]/20 shadow-2xs"
                              />
                            ) : (
                              <div className="w-8 h-8 rounded-xl bg-[#182238] text-white flex items-center justify-center font-bold text-xs shadow-2xs">
                                {initial}
                              </div>
                            )}
                            {isOnline && (
                              <span
                                className="absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 bg-emerald-500 border-2 border-white rounded-full animate-pulse"
                                title="Đang online"
                              />
                            )}
                          </div>
                          <div className="min-w-0">
                            <p className="font-bold text-title font-serif text-sm truncate">
                              {u.display_name || 'Chưa đặt tên'}
                            </p>
                            {isCurrent && (
                              <span className="text-[10px] text-app-accent font-sans font-bold bg-app-accent-soft px-1.5 py-0.2 rounded">
                                (Tài khoản của bạn)
                              </span>
                            )}
                          </div>
                        </div>
                      </td>

                      {/* Email */}
                      <td className="py-3.5 px-4 font-sans text-body">
                        {u.email}
                      </td>

                      {/* Online Status / Last Active */}
                      <td className="py-3.5 px-4 font-sans">
                        {isOnline ? (
                          <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[11px] font-bold bg-emerald-100 text-emerald-800 border border-emerald-300 shadow-2xs">
                            <span className="relative flex h-2 w-2">
                              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                              <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
                            </span>
                            <span>Đang online</span>
                          </div>
                        ) : (
                          <div className="flex items-center gap-1.5 text-muted text-xs font-serif" title={u.last_seen_at ? new Date(u.last_seen_at).toLocaleString('vi-VN') : undefined}>
                            <Clock className="w-3.5 h-3.5 text-muted/60" />
                            <span>{formatRelativeTime(u.last_seen_at)}</span>
                          </div>
                        )}
                      </td>

                      {/* Created Date */}
                      <td className="py-3.5 px-4 text-muted font-sans whitespace-nowrap">
                        {u.created_at ? new Date(u.created_at).toLocaleDateString('vi-VN') : '—'}
                      </td>

                      {/* Role Badge */}
                      <td className="py-3.5 px-4">
                        {u.is_admin ? (
                          <span className="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-serif font-bold bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30 shadow-2xs">
                            <ShieldCheck className="w-3.5 h-3.5" />
                            <span>Admin</span>
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-serif font-medium bg-[#182238]/5 text-[#182238] border border-[#182238]/15">
                            <Users className="w-3.5 h-3.5 text-muted" />
                            <span>Học viên</span>
                          </span>
                        )}
                      </td>

                      {/* Actions */}
                      <td className="py-3.5 px-4 text-right">
                        {isCurrent ? (
                          <span className="text-[11px] text-muted italic font-serif">
                            Không thể tự hạ quyền
                          </span>
                        ) : u.is_admin ? (
                          <button
                            type="button"
                            disabled={isPending}
                            onClick={() => handleToggleRole(u)}
                            className="font-serif text-xs min-h-[36px] px-3.5 py-1.5 rounded-xl bg-slate-700 hover:bg-slate-800 active:translate-y-0.5 text-white font-bold border-2 border-slate-900 shadow-[0_2px_0_#0F172A] cursor-pointer inline-flex items-center gap-1.5 transition-all"
                          >
                            <UserX className="w-3.5 h-3.5" />
                            <span>Hạ xuống Học viên</span>
                          </button>
                        ) : (
                          <button
                            type="button"
                            disabled={isPending}
                            onClick={() => handleToggleRole(u)}
                            className="font-serif text-xs min-h-[36px] px-3.5 py-1.5 rounded-xl bg-[#B8322D] hover:bg-[#9E2A25] active:translate-y-0.5 text-white font-bold border-2 border-[#7A1D1A] shadow-[0_2px_0_#7A1D1A] cursor-pointer inline-flex items-center gap-1.5 transition-all"
                          >
                            <UserCheck className="w-3.5 h-3.5" />
                            <span>Cấp quyền Admin</span>
                          </button>
                        )}
                      </td>
                    </tr>
                  )
                })
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination Bar */}
        <div className="p-3.5 border-t border-border bg-page/30 flex flex-col sm:flex-row items-center justify-between gap-3 text-xs">
          {/* Summary info */}
          <div className="text-muted text-xs font-sans text-center sm:text-left">
            {totalItems === 0 ? (
              <span>Đang hiển thị 0 tài khoản</span>
            ) : (
              <span>
                Đang hiển thị <strong className="text-title font-bold">{itemFrom}–{itemTo}</strong> trong tổng số <strong className="text-title font-bold">{totalItems}</strong> tài khoản
                {debouncedSearch && (
                  <span className="ml-1 text-[11px] text-app-accent font-medium">
                    (theo kết quả tìm kiếm)
                  </span>
                )}
              </span>
            )}
          </div>

          {/* Pagination Navigation */}
          {totalPages > 1 && (
            <div className="flex items-center gap-1.5 select-none">
              {/* First Page (Desktop) */}
              <Button
                variant="outline"
                size="sm"
                disabled={page <= 1 || isPending}
                onClick={() => handlePageChange(1)}
                className="hidden md:inline-flex h-8 w-8 p-0 border-border text-muted hover:text-title hover:border-app-accent"
                title="Về trang đầu"
              >
                <ChevronsLeft className="w-4 h-4" />
              </Button>

              {/* Prev Page Button */}
              <Button
                variant="outline"
                size="sm"
                disabled={page <= 1 || isPending}
                onClick={() => handlePageChange(page - 1)}
                className="h-8 min-h-[36px] sm:min-h-0 px-2.5 font-serif text-xs gap-1 border-border text-title hover:border-app-accent disabled:opacity-40 active:scale-95 touch-manipulation"
              >
                <ChevronLeft className="w-3.5 h-3.5" />
                <span className="hidden sm:inline">Trang trước</span>
              </Button>

              {/* Numbered Page Buttons */}
              <div className="flex items-center gap-1">
                {pageNumbers.map((p, idx) => {
                  if (p === 'ellipsis') {
                    return (
                      <span key={`ellipsis-${idx}`} className="px-1 text-muted text-xs select-none">
                        …
                      </span>
                    )
                  }
                  const isActive = p === page
                  return (
                    <button
                      key={p}
                      type="button"
                      disabled={isPending}
                      onClick={() => handlePageChange(p as number)}
                      className={`h-8 min-h-[36px] sm:min-h-0 min-w-[34px] px-2 rounded-lg font-serif text-xs transition-colors active:scale-95 touch-manipulation ${
                        isActive
                          ? 'bg-app-accent text-white font-bold shadow-2xs'
                          : 'bg-card hover:bg-page text-title border border-border hover:border-app-accent'
                      }`}
                      aria-current={isActive ? 'page' : undefined}
                    >
                      {p}
                    </button>
                  )
                })}
              </div>

              {/* Next Page Button */}
              <Button
                variant="outline"
                size="sm"
                disabled={page >= totalPages || isPending}
                onClick={() => handlePageChange(page + 1)}
                className="h-8 min-h-[36px] sm:min-h-0 px-2.5 font-serif text-xs gap-1 border-border text-title hover:border-app-accent disabled:opacity-40 active:scale-95 touch-manipulation"
              >
                <span className="hidden sm:inline">Trang sau</span>
                <ChevronRight className="w-3.5 h-3.5" />
              </Button>

              {/* Last Page (Desktop) */}
              <Button
                variant="outline"
                size="sm"
                disabled={page >= totalPages || isPending}
                onClick={() => handlePageChange(totalPages)}
                className="hidden md:inline-flex h-8 w-8 p-0 border-border text-muted hover:text-title hover:border-app-accent"
                title="Đến trang cuối"
              >
                <ChevronsRight className="w-4 h-4" />
              </Button>
            </div>
          )}
        </div>

        {/* Footer info */}
        <div className="px-4 py-2 border-t border-border bg-page/20 flex flex-col sm:flex-row items-center justify-between text-[11px] text-muted gap-1">
          <span>Trang {page} / {totalPages} (Tối đa 20 tài khoản / trang)</span>
          <span>Bảo mật: Chỉ tài khoản Admin mới có quyền truy cập khu vực này</span>
        </div>
      </div>
    </div>
  )
}
