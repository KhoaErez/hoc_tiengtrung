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
} from 'lucide-react'
import { Button } from '@/components/ui/button'
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
                Theo dõi tài khoản đang hoạt động gần thời gian thực và quản lý quyền hạn học viên
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2">
            <Link href="/admin/feedback">
              <Button
                variant="outline"
                className="font-serif text-xs min-h-[40px] gap-1.5 border-[#E9DDD1] hover:bg-[#FFF9F3] text-title cursor-pointer"
              >
                <MessageSquareWarning className="w-3.5 h-3.5 text-app-accent" />
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

      {/* 2. Global User Stats Cards (Tính trên toàn bộ database + Realtime Presence) */}
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-3.5">
        {/* Thẻ 1: Tổng số tài khoản */}
        <div className="bg-card border border-border rounded-xl p-3.5 sm:p-4 shadow-2xs">
          <p className="text-[11px] text-muted uppercase tracking-wider font-sans">Tổng tài khoản</p>
          <div className="flex items-baseline justify-between mt-1.5">
            <span className="text-xl sm:text-2xl font-bold text-title">{stats.totalUsers}</span>
            <Users className="w-4 h-4 sm:w-5 sm:h-5 text-muted/60" />
          </div>
          <p className="text-[10px] text-muted font-sans mt-1">Đã đăng ký hệ thống</p>
        </div>

        {/* Thẻ 2: Đang Online (Realtime Presence) */}
        <div className="bg-card border border-emerald-500/30 rounded-xl p-3.5 sm:p-4 shadow-2xs relative overflow-hidden bg-gradient-to-br from-card via-card to-emerald-50/20">
          <div className="flex items-center justify-between">
            <p className="text-[11px] text-emerald-800 uppercase tracking-wider font-sans font-semibold flex items-center gap-1.5">
              <span className="relative flex h-2 w-2">
                {realtimeStatus === 'connected' && (
                  <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                )}
                <span className={`relative inline-flex rounded-full h-2 w-2 ${
                  realtimeStatus === 'connected' ? 'bg-emerald-500' : realtimeStatus === 'error' ? 'bg-amber-500' : 'bg-blue-400'
                }`}></span>
              </span>
              <span>Đang online</span>
            </p>
            <Radio className="w-3.5 h-3.5 text-emerald-600 animate-pulse" />
          </div>
          <div className="flex items-baseline justify-between mt-1.5">
            <span className="text-xl sm:text-2xl font-bold text-emerald-700">
              {onlineCount}
            </span>
            <span className={`text-[9px] font-sans px-1.5 py-0.5 rounded-full border ${
              realtimeStatus === 'connected'
                ? 'bg-emerald-100/60 text-emerald-800 border-emerald-300'
                : realtimeStatus === 'error'
                ? 'bg-amber-100 text-amber-800 border-amber-300'
                : 'bg-blue-50 text-blue-700 border-blue-200'
            }`}>
              {realtimeStatus === 'connected' ? 'Trực tiếp' : realtimeStatus === 'error' ? 'Dự phòng DB' : 'Đang kết nối'}
            </span>
          </div>
          <p className="text-[10px] text-emerald-700/80 font-sans mt-1">
            {realtimeStatus === 'error' ? 'Dữ liệu xác nhận gần nhất' : 'Theo dõi Realtime Presence'}
          </p>
        </div>

        {/* Thẻ 3: Hoạt động 24h */}
        <div className="bg-card border border-border rounded-xl p-3.5 sm:p-4 shadow-2xs">
          <p className="text-[11px] text-muted uppercase tracking-wider font-sans">Hoạt động 24h</p>
          <div className="flex items-baseline justify-between mt-1.5">
            <span className="text-xl sm:text-2xl font-bold text-title">{stats.active24hCount}</span>
            <Activity className="w-4 h-4 sm:w-5 sm:h-5 text-blue-500/70" />
          </div>
          <p className="text-[10px] text-muted font-sans mt-1">Tài khoản tương tác hôm nay</p>
        </div>

        {/* Thẻ 4: Quản trị viên (Admin) */}
        <div className="bg-card border border-border rounded-xl p-3.5 sm:p-4 shadow-2xs">
          <p className="text-[11px] text-muted uppercase tracking-wider font-sans">Quản trị viên</p>
          <div className="flex items-baseline justify-between mt-1.5">
            <span className="text-xl sm:text-2xl font-bold text-app-accent">{stats.adminCount}</span>
            <ShieldCheck className="w-4 h-4 sm:w-5 sm:h-5 text-app-accent/60" />
          </div>
          <p className="text-[10px] text-muted font-sans mt-1">Quyền Admin hệ thống</p>
        </div>

        {/* Thẻ 5: Học viên thường */}
        <div className="bg-card border border-border rounded-xl p-3.5 sm:p-4 shadow-2xs">
          <p className="text-[11px] text-muted uppercase tracking-wider font-sans">Học viên thường</p>
          <div className="flex items-baseline justify-between mt-1.5">
            <span className="text-xl sm:text-2xl font-bold text-title">{stats.regularCount}</span>
            <Users className="w-4 h-4 sm:w-5 sm:h-5 text-jade/60" />
          </div>
          <p className="text-[10px] text-muted font-sans mt-1">Người học tiêu chuẩn</p>
        </div>
      </div>

      {/* 3. User Role Management Table with Server Pagination & Activity Filters */}
      <div ref={tableTopRef} className="scroll-mt-6 bg-card border border-border rounded-2xl shadow-2xs overflow-hidden">
        {/* Table Toolbar */}
        <div className="p-4 border-b border-border flex flex-col lg:flex-row items-stretch lg:items-center justify-between gap-3">
          <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 flex-1">
            {/* Search Input */}
            <div className="relative flex-1 max-w-sm">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted" />
              <input
                type="text"
                placeholder="Tìm theo email hoặc tên..."
                value={searchInput}
                onChange={(e) => setSearchInput(e.target.value)}
                className="w-full pl-9 pr-8 py-1.5 text-xs bg-page border border-border rounded-lg outline-none focus:border-app-accent font-sans"
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

            {/* Filter Tabs */}
            <div className="flex items-center gap-1.5 overflow-x-auto pb-1 sm:pb-0 no-scrollbar">
              <button
                type="button"
                onClick={() => setRoleFilter('all')}
                className={`px-2.5 py-1 rounded-lg text-xs font-sans transition-colors cursor-pointer whitespace-nowrap ${
                  roleFilter === 'all'
                    ? 'bg-title text-white font-semibold'
                    : 'bg-page text-muted hover:text-title border border-border'
                }`}
              >
                Tất cả ({totalItems})
              </button>
              <button
                type="button"
                onClick={() => setRoleFilter('online')}
                className={`px-2.5 py-1 rounded-lg text-xs font-sans transition-colors cursor-pointer whitespace-nowrap flex items-center gap-1.5 ${
                  roleFilter === 'online'
                    ? 'bg-emerald-600 text-white font-semibold'
                    : 'bg-page text-muted hover:text-emerald-700 border border-border'
                }`}
              >
                <span className="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                <span>Online ({onlineUserIds.size})</span>
              </button>
              <button
                type="button"
                onClick={() => setRoleFilter('active24h')}
                className={`px-2.5 py-1 rounded-lg text-xs font-sans transition-colors cursor-pointer whitespace-nowrap ${
                  roleFilter === 'active24h'
                    ? 'bg-blue-600 text-white font-semibold'
                    : 'bg-page text-muted hover:text-blue-700 border border-border'
                }`}
              >
                Hoạt động 24h ({stats.active24hCount})
              </button>
              <button
                type="button"
                onClick={() => setRoleFilter('admin')}
                className={`px-2.5 py-1 rounded-lg text-xs font-sans transition-colors cursor-pointer whitespace-nowrap ${
                  roleFilter === 'admin'
                    ? 'bg-app-accent text-white font-semibold'
                    : 'bg-page text-muted hover:text-app-accent border border-border'
                }`}
              >
                Admin ({stats.adminCount})
              </button>
              <button
                type="button"
                onClick={() => setRoleFilter('regular')}
                className={`px-2.5 py-1 rounded-lg text-xs font-sans transition-colors cursor-pointer whitespace-nowrap ${
                  roleFilter === 'regular'
                    ? 'bg-slate-700 text-white font-semibold'
                    : 'bg-page text-muted hover:text-title border border-border'
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
              className="font-serif text-xs h-8 gap-1.5 border-border hover:border-app-accent"
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
              <tr className="border-b border-border bg-page/40 text-muted uppercase tracking-wider font-semibold font-sans">
                <th className="py-3 px-4">Tài khoản</th>
                <th className="py-3 px-4">Email</th>
                <th className="py-3 px-4">Trạng thái / Hoạt động</th>
                <th className="py-3 px-4">Ngày tham gia</th>
                <th className="py-3 px-4">Vai trò hiện tại</th>
                <th className="py-3 px-4 text-right">Hành động phân quyền</th>
              </tr>
            </thead>
            <tbody className={`divide-y divide-border transition-opacity duration-150 ${isPending ? 'opacity-60' : 'opacity-100'}`}>
              {displayedUsers.length === 0 ? (
                <tr>
                  <td colSpan={6} className="py-12 text-center text-muted">
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
                      className={`hover:bg-page/50 transition-colors ${
                        isCurrent ? 'bg-app-accent-soft/20' : ''
                      }`}
                    >
                      {/* Name & Avatar with Online status dot */}
                      <td className="py-3 px-4">
                        <div className="flex items-center gap-2.5">
                          <div className="relative flex-shrink-0">
                            {u.avatar_url ? (
                              <img
                                src={u.avatar_url}
                                alt={u.display_name || u.email}
                                className="w-7 h-7 rounded-full object-cover border border-border"
                              />
                            ) : (
                              <div className="w-7 h-7 rounded-full bg-title text-white flex items-center justify-center font-bold text-xs">
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

                      {/* Online Status / Last Active */}
                      <td className="py-3 px-4 font-sans">
                        {isOnline ? (
                          <div className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-full text-[11px] font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200">
                            <span className="relative flex h-2 w-2">
                              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                              <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
                            </span>
                            <span>Đang online</span>
                          </div>
                        ) : (
                          <div className="flex items-center gap-1 text-muted text-xs" title={u.last_seen_at ? new Date(u.last_seen_at).toLocaleString('vi-VN') : undefined}>
                            <Clock className="w-3 h-3 text-muted/60" />
                            <span>{formatRelativeTime(u.last_seen_at)}</span>
                          </div>
                        )}
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
                            variant="destructive"
                            disabled={isPending}
                            onClick={() => handleToggleRole(u)}
                            className="font-serif text-xs min-h-[34px] px-3 gap-1 cursor-pointer"
                          >
                            <UserX className="w-3 h-3" />
                            <span>Hạ xuống Học viên</span>
                          </Button>
                        ) : (
                          <Button
                            size="sm"
                            variant="primary"
                            disabled={isPending}
                            onClick={() => handleToggleRole(u)}
                            className="font-serif text-xs min-h-[34px] px-3 gap-1 cursor-pointer"
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
