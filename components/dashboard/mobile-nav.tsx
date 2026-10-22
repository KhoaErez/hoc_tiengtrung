'use client'

import React, { useState, useEffect, useRef, createContext, useContext, useMemo } from 'react'
import Link from 'next/link'
import { usePathname, useRouter, useSearchParams } from 'next/navigation'
import {
  Home,
  BookOpen,
  BrainCircuit,
  ChevronLeft,
  ChevronRight,
  ChevronDown,
  LogOut,
  GraduationCap,
  Component,
  Keyboard,
  Menu,
  X,
  LogIn,
  UserPlus,
  ShieldCheck,
  MessageSquare,
  PenTool,
  Sparkles,
  User as UserIcon,
  ArrowRight,
  Clock
} from 'lucide-react'
import { logout } from '@/app/auth/actions'
import { ProtectedLink } from '@/components/protected-link'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import { BrandLogo } from '@/components/ui/brand-logo'
import { AdminNotificationBell } from '@/components/dashboard/admin-notification-bell'
import { HSK_AUDIT_DATA } from '@/data/hsk-curriculum'
import { formatNumber } from '@/lib/utils'
import { getLiveVocabCountsAction } from '@/app/actions/vocab-counts'

// ============================================================================
// 1. MOBILE NAVIGATION CONTEXT & HOOK
// ============================================================================
interface MobileNavContextValue {
  isDrawerOpen: boolean
  openDrawer: () => void
  closeDrawer: () => void
  toggleDrawer: () => void
}

const MobileNavContext = createContext<MobileNavContextValue | undefined>(undefined)

export function useMobileNav() {
  const context = useContext(MobileNavContext)
  if (!context) {
    throw new Error('useMobileNav must be used within a MobileNavProvider')
  }
  return context
}

export function MobileNavProvider({ children }: { children: React.ReactNode }) {
  const [isDrawerOpen, setIsDrawerOpen] = useState(false)
  const pathname = usePathname()

  const openDrawer = () => setIsDrawerOpen(true)
  const closeDrawer = () => setIsDrawerOpen(false)
  const toggleDrawer = () => setIsDrawerOpen((prev) => !prev)

  // Tự động đóng drawer khi điều hướng sang trang khác
  useEffect(() => {
    setIsDrawerOpen(false)
  }, [pathname])

  // Đóng khi nhấn Escape
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape' && isDrawerOpen) {
        setIsDrawerOpen(false)
      }
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [isDrawerOpen])

  // Khóa cuộn màn hình phía dưới khi Drawer mở
  useEffect(() => {
    if (isDrawerOpen) {
      document.body.style.overflow = 'hidden'
    } else {
      document.body.style.overflow = ''
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [isDrawerOpen])

  const value = useMemo(
    () => ({ isDrawerOpen, openDrawer, closeDrawer, toggleDrawer }),
    [isDrawerOpen]
  )

  return <MobileNavContext.Provider value={value}>{children}</MobileNavContext.Provider>
}

// ============================================================================
// 2. MOBILE HEADER COMPONENT (CỐ ĐỊNH Ở ĐẦU TRANG DI ĐỘNG)
// ============================================================================
export interface MobileHeaderProps {
  isLoggedIn?: boolean
  isAdmin?: boolean
  adminId?: string
  user?: { id: string; email?: string } | null
  profile?: { display_name?: string | null; avatar_url?: string | null } | null
}

export function MobileHeader({
  isLoggedIn,
  isAdmin,
  adminId,
  user,
  profile,
}: MobileHeaderProps) {
  const router = useRouter()
  const pathname = usePathname()
  const { isLoggedIn: contextLoggedIn, openLoginForm } = useAuthModal()
  const authenticated = typeof isLoggedIn === 'boolean' ? isLoggedIn : contextLoggedIn
  const { toggleDrawer } = useMobileNav()

  const isHome = pathname === '/'
  const displayName = profile?.display_name || user?.email?.split('@')[0] || 'Học viên'
  const initial = displayName[0]?.toUpperCase() || 'U'

  return (
    <header className="md:hidden h-14 border-b border-border/60 bg-page/95 backdrop-blur-md flex items-center justify-between px-3 sm:px-4 fixed top-0 left-0 right-0 z-30 select-none">
      {/* Khối bên trái: Nút Menu Drawer, Nút Quay lại (nếu trang sâu) và Brand Logo */}
      <div className="flex items-center">
        {/* Nút mở Mobile Navigation Drawer */}
        <button
          type="button"
          onClick={toggleDrawer}
          className="h-10 w-10 flex items-center justify-center rounded-xl text-muted hover:text-title hover:bg-black/5 active:bg-black/10 transition-colors -ml-1 mr-0.5 cursor-pointer touch-manipulation"
          title="Menu điều hướng"
          aria-label="Mở menu điều hướng toàn trang"
        >
          <Menu className="h-5 w-5" />
        </button>

        {/* Nút quay lại chỉ hiện khi không ở trang chủ */}
        {!isHome && (
          <button
            type="button"
            onClick={() => router.back()}
            className="h-10 w-10 flex items-center justify-center rounded-xl text-muted hover:text-title hover:bg-black/5 active:bg-black/10 transition-colors mr-1 cursor-pointer touch-manipulation"
            aria-label="Quay lại"
            title="Quay lại"
          >
            <ChevronLeft className="h-5 w-5" />
          </button>
        )}

        <BrandLogo variant="horizontal" size="xs" showSubtitle={false} />
      </div>

      {/* Khối bên phải: Chuông thông báo Admin và Avatar Hồ sơ / Nút Đăng nhập */}
      <div className="flex items-center gap-1.5 sm:gap-2">
        {authenticated && isAdmin && adminId && (
          <AdminNotificationBell adminId={adminId} />
        )}

        {authenticated ? (
          <Link
            href="/profile"
            className="h-10 w-10 flex items-center justify-center rounded-xl hover:bg-black/5 active:bg-black/10 transition-colors touch-manipulation -mr-1"
            title="Xem hồ sơ & tiến độ"
            aria-label="Xem hồ sơ & tiến độ cá nhân"
          >
            {profile?.avatar_url ? (
              <img
                src={profile.avatar_url}
                alt={displayName}
                className="w-8 h-8 rounded-full object-cover border border-border shadow-2xs"
              />
            ) : (
              <div className="w-8 h-8 rounded-full bg-[#23272F] text-white flex items-center justify-center font-bold text-xs shadow-2xs font-serif">
                {initial}
              </div>
            )}
          </Link>
        ) : (
          <button
            type="button"
            onClick={() => openLoginForm()}
            className="flex items-center gap-1.5 px-3 py-1.5 h-9 rounded-xl border border-border/80 bg-card text-xs font-serif text-title hover:text-app-accent hover:border-app-accent/40 active:bg-page transition-colors cursor-pointer shadow-2xs touch-manipulation"
          >
            <LogIn className="h-3.5 w-3.5 text-muted" />
            <span>Đăng nhập</span>
          </button>
        )}
      </div>
    </header>
  )
}

// ============================================================================
// 3. MOBILE BOTTOM NAVIGATION (5 TABS CHUẨN QUỐC TẾ)
// ============================================================================
export interface MobileNavProps {
  isLoggedIn: boolean
  isAdmin?: boolean
  user?: { id: string; email?: string } | null
  profile?: { display_name?: string | null; avatar_url?: string | null } | null
  initialVocabCounts?: Record<string, number | null>
}

export function MobileNav({
  isLoggedIn,
  isAdmin = false,
  user = null,
  profile = null,
  initialVocabCounts,
}: MobileNavProps) {
  const pathname = usePathname() || '/'
  const { isDrawerOpen, toggleDrawer, closeDrawer } = useMobileNav()

  // 4 Tabs chính + 1 Tab mở Menu Drawer
  const coreNavItems = [
    { href: '/', icon: Home, label: 'Trang chủ', isProtected: false },
    { href: '/topics', icon: GraduationCap, label: 'HSK', isProtected: false },
    { href: '/typing', icon: Keyboard, label: 'Luyện gõ', isProtected: false },
    { href: '/review', icon: BrainCircuit, label: 'Ôn tập', isProtected: true },
  ]

  // Xác định liệu người dùng có đang ở mục mở rộng (Bộ thủ, Sưu tầm, Luyện viết, Admin, Profile)
  const isExtendedActive =
    isDrawerOpen ||
    pathname.startsWith('/lessons') ||
    pathname.startsWith('/radicals') ||
    pathname.startsWith('/write') ||
    pathname.startsWith('/admin') ||
    pathname.startsWith('/profile')

  return (
    <>
      <nav
        className="md:hidden fixed bottom-0 left-0 right-0 bg-page/95 backdrop-blur-md border-t border-border/60 z-40 shadow-[0_-4px_20px_rgba(0,0,0,0.03)] box-border select-none"
        style={{ paddingBottom: 'env(safe-area-inset-bottom, 0px)' }}
        aria-label="Thanh điều hướng chính di động"
      >
        <div className="grid grid-cols-5 h-[56px] items-center px-1">
          {coreNavItems.map((item) => {
            const isActive =
              item.href === '/'
                ? pathname === '/'
                : item.href === '/topics'
                ? pathname === '/topics' || pathname.startsWith('/topics/') || pathname.startsWith('/hsk')
                : pathname === item.href || pathname.startsWith(item.href + '/')

            const content = (
              <>
                <div
                  className={`relative p-1.5 rounded-full transition-all duration-200 ${
                    isActive ? 'bg-app-accent-soft text-app-accent' : 'text-muted'
                  }`}
                >
                  <item.icon
                    className={`h-5 w-5 transition-transform duration-200 ${
                      isActive ? 'scale-110 text-app-accent' : 'scale-100'
                    }`}
                  />
                  {isActive && (
                    <span className="absolute -bottom-0.5 left-1/2 -translate-x-1/2 w-1.5 h-1.5 bg-app-accent rounded-full" />
                  )}
                </div>
                <span
                  className={`text-[10px] tracking-tight transition-colors duration-200 ${
                    isActive ? 'font-semibold font-serif text-app-accent' : 'font-normal font-serif text-muted'
                  }`}
                >
                  {item.label}
                </span>
              </>
            )

            const containerClasses =
              'flex flex-col items-center justify-center w-full h-full gap-0.5 transition-colors outline-none cursor-pointer touch-manipulation'

            if (item.isProtected) {
              return (
                <ProtectedLink
                  key={item.href}
                  href={item.href}
                  isLoggedIn={isLoggedIn}
                  className={containerClasses}
                >
                  {content}
                </ProtectedLink>
              )
            }

            return (
              <Link key={item.href} href={item.href} className={containerClasses}>
                {content}
              </Link>
            )
          })}

          {/* Tab thứ 5: Mở Navigation Drawer Sheet */}
          <button
            type="button"
            onClick={toggleDrawer}
            className="flex flex-col items-center justify-center w-full h-full gap-0.5 transition-colors outline-none cursor-pointer touch-manipulation"
            aria-label="Mở menu mở rộng"
          >
            <div
              className={`relative p-1.5 rounded-full transition-all duration-200 ${
                isExtendedActive ? 'bg-app-accent-soft text-app-accent' : 'text-muted'
              }`}
            >
              <Menu
                className={`h-5 w-5 transition-transform duration-200 ${
                  isExtendedActive ? 'scale-110 text-app-accent' : 'scale-100'
                }`}
              />
              {isExtendedActive && (
                <span className="absolute -bottom-0.5 left-1/2 -translate-x-1/2 w-1.5 h-1.5 bg-app-accent rounded-full" />
              )}
            </div>
            <span
              className={`text-[10px] tracking-tight transition-colors duration-200 ${
                isExtendedActive ? 'font-semibold font-serif text-app-accent' : 'font-normal font-serif text-muted'
              }`}
            >
              Thêm
            </span>
          </button>
        </div>
      </nav>

      {/* Slide-over Navigation Drawer */}
      <MobileDrawer
        isOpen={isDrawerOpen}
        onClose={closeDrawer}
        isLoggedIn={isLoggedIn}
        isAdmin={isAdmin}
        user={user}
        profile={profile}
        initialVocabCounts={initialVocabCounts}
      />
    </>
  )
}

// ============================================================================
// 4. MOBILE NAVIGATION DRAWER (TOÀN BỘ CÂU TRÚC HỆ THỐNG TRÊN DI ĐỘNG)
// ============================================================================
interface MobileDrawerProps {
  isOpen: boolean
  onClose: () => void
  isLoggedIn: boolean
  isAdmin?: boolean
  user?: { id: string; email?: string } | null
  profile?: { display_name?: string | null; avatar_url?: string | null } | null
  initialVocabCounts?: Record<string, number | null>
}

function MobileDrawer({
  isOpen,
  onClose,
  isLoggedIn,
  isAdmin = false,
  user = null,
  profile = null,
  initialVocabCounts,
}: MobileDrawerProps) {
  const pathname = usePathname() || '/'
  const searchParams = useSearchParams()
  const qParam = searchParams?.get('q')
  const { openLoginForm, openRegisterForm } = useAuthModal()

  const [confirmLogout, setConfirmLogout] = useState(false)
  const [vocabCounts, setVocabCounts] = useState<Record<string, number | null> | undefined>(
    initialVocabCounts
  )
  const [isHskExpanded, setIsHskExpanded] = useState<boolean>(true)

  // Tải live counts nếu chưa có
  useEffect(() => {
    if (!initialVocabCounts) {
      getLiveVocabCountsAction()
        .then((res) => setVocabCounts(res.counts))
        .catch(() => {})
    } else {
      setVocabCounts(initialVocabCounts)
    }
  }, [initialVocabCounts])

  // Lắng nghe cập nhật từ vựng
  useEffect(() => {
    const handleUpdate = () => {
      getLiveVocabCountsAction()
        .then((res) => setVocabCounts(res.counts))
        .catch(() => {})
    }
    window.addEventListener('vocab-counts-updated', handleUpdate)
    return () => window.removeEventListener('vocab-counts-updated', handleUpdate)
  }, [])

  // Reset confirmation state khi đóng drawer
  useEffect(() => {
    if (!isOpen) {
      setConfirmLogout(false)
    }
  }, [isOpen])

  const displayName = profile?.display_name || user?.email?.split('@')[0] || 'Học viên'
  const initial = displayName[0]?.toUpperCase() || 'U'

  // Nhóm 1: Học tập
  const coreLearningItems = [
    { label: 'Trang chủ', href: '/', icon: Home, isProtected: false },
    { label: 'Chủ đề sưu tầm', href: '/lessons', icon: BookOpen, isProtected: false },
    { label: 'Ôn tập thẻ nhớ', href: '/review', icon: BrainCircuit, isProtected: true },
  ]

  // Nhóm 2: Lộ trình HSK 3.0
  const hskStages = [
    {
      stage: 'Sơ cấp (初等)',
      levels: [
        { label: 'HSK 1', level: '1', data: HSK_AUDIT_DATA['HSK 1'] },
        { label: 'HSK 2', level: '2', data: HSK_AUDIT_DATA['HSK 2'] },
        { label: 'HSK 3', level: '3', data: HSK_AUDIT_DATA['HSK 3'] },
      ],
    },
    {
      stage: 'Trung cấp (中等)',
      levels: [
        { label: 'HSK 4', level: '4', data: HSK_AUDIT_DATA['HSK 4'] },
        { label: 'HSK 5', level: '5', data: HSK_AUDIT_DATA['HSK 5'] },
        { label: 'HSK 6', level: '6', data: HSK_AUDIT_DATA['HSK 6'] },
      ],
    },
    {
      stage: 'Cao cấp (高等)',
      levels: [
        { label: 'HSK 7-9', level: '7', data: HSK_AUDIT_DATA['HSK 7-9'] },
      ],
    },
  ]

  const practicalTopics = [
    { label: 'Giao tiếp thực tế', topic: 'Giao tiếp', data: HSK_AUDIT_DATA['Giao tiếp'] },
    { label: 'Tiếng Trung công xưởng', topic: 'Công xưởng', data: HSK_AUDIT_DATA['Công xưởng'] },
  ]

  // Nhóm 3: Công cụ & Kỹ năng
  const practiceTools = [
    { label: 'Luyện đánh máy IME', href: '/typing', icon: Keyboard, isProtected: false },
    { label: '214 Bộ thủ Khang Hy', href: '/radicals', icon: Component, isProtected: false },
    { label: 'Luyện Viết AI', href: '/write', icon: PenTool, isProtected: false, badge: 'Sắp ra mắt' },
  ]

  const isHskItemActive = (topic: string) => {
    if (topic.startsWith('HSK ')) {
      const level = topic.replace('HSK ', '').trim()
      if (pathname === `/hsk/${level}` || pathname.startsWith(`/hsk/${level}/`)) {
        return true
      }
      if (pathname === '/topics') {
        if (qParam === topic) return true
        if (!qParam && topic === 'HSK 1') return true
      }
      return false
    }
    if (pathname === '/topics') {
      return qParam === topic
    }
    return false
  }

  if (!isOpen) return null

  return (
    <div className="md:hidden fixed inset-0 z-50 select-none animate-in fade-in duration-200">
      {/* 1. Backdrop làm mờ hậu cảnh */}
      <div
        className="fixed inset-0 bg-black/55 backdrop-blur-xs transition-opacity"
        onClick={onClose}
        aria-hidden="true"
      />

      {/* 2. Slide-over Sheet từ cạnh trái */}
      <aside
        className="fixed top-0 bottom-0 left-0 w-[84vw] max-w-xs bg-page z-50 shadow-2xl flex flex-col border-r border-border/80 animate-in slide-in-from-left duration-250 ease-out"
        role="dialog"
        aria-label="Menu điều hướng hệ thống"
      >
        {/* Header Drawer */}
        <div className="h-14 border-b border-border/60 bg-page/95 px-4 flex items-center justify-between shrink-0">
          <BrandLogo variant="horizontal" size="xs" showSubtitle={false} />
          <button
            type="button"
            onClick={onClose}
            className="h-9 w-9 rounded-xl flex items-center justify-center text-muted hover:text-title hover:bg-black/5 transition-colors cursor-pointer touch-manipulation"
            aria-label="Đóng menu"
          >
            <X className="h-5 w-5" />
          </button>
        </div>

        {/* Khối Thông tin Người dùng (User Profile & Auth Hub) */}
        <div className="p-3.5 border-b border-border/60 bg-card/60 shrink-0">
          {isLoggedIn && user ? (
            <div className="space-y-2.5">
              <Link
                href="/profile"
                onClick={onClose}
                className="flex items-center justify-between p-2 rounded-xl bg-page border border-border/70 hover:border-app-accent/40 transition-colors group"
              >
                <div className="flex items-center gap-2.5 min-w-0">
                  {profile?.avatar_url ? (
                    <img
                      src={profile.avatar_url}
                      alt={displayName}
                      className="w-8 h-8 rounded-full object-cover border border-border shrink-0 shadow-2xs"
                    />
                  ) : (
                    <div className="w-8 h-8 rounded-full bg-[#23272F] text-white flex items-center justify-center font-bold text-xs shrink-0 shadow-2xs font-serif">
                      {initial}
                    </div>
                  )}
                  <div className="min-w-0">
                    <div className="flex items-center gap-1.5">
                      <p className="text-xs font-serif font-bold text-title truncate group-hover:text-app-accent">
                        {displayName}
                      </p>
                      {isAdmin && (
                        <span className="bg-app-accent text-white text-[9px] font-sans font-bold uppercase px-1 py-0.2 rounded shrink-0">
                          Admin
                        </span>
                      )}
                    </div>
                    <p className="text-[10px] text-muted font-sans truncate">{user.email}</p>
                  </div>
                </div>
                <ChevronRight className="w-4 h-4 text-muted group-hover:text-app-accent transition-transform group-hover:translate-x-0.5" />
              </Link>

              {/* Nút đăng xuất an toàn có xác nhận */}
              {confirmLogout ? (
                <div className="p-2 rounded-xl bg-red-500/10 border border-red-500/20 space-y-1.5 animate-in fade-in">
                  <p className="text-[11px] font-serif text-red-600 font-medium text-center">
                    Bạn có chắc muốn đăng xuất?
                  </p>
                  <div className="flex items-center gap-2">
                    <button
                      type="button"
                      onClick={() => setConfirmLogout(false)}
                      className="flex-1 py-1 rounded-lg border border-border text-[11px] font-serif text-muted hover:bg-page"
                    >
                      Hủy
                    </button>
                    <form action={logout} className="flex-1">
                      <button
                        type="submit"
                        className="w-full py-1 rounded-lg bg-red-600 text-white text-[11px] font-serif font-semibold hover:bg-red-700"
                      >
                        Đăng xuất
                      </button>
                    </form>
                  </div>
                </div>
              ) : (
                <button
                  type="button"
                  onClick={() => setConfirmLogout(true)}
                  className="w-full flex items-center justify-between px-2.5 py-1.5 text-xs text-muted hover:text-red-600 hover:bg-red-500/5 transition-colors rounded-lg group cursor-pointer"
                >
                  <span className="font-serif">Đăng xuất khỏi thiết bị</span>
                  <LogOut className="h-3.5 w-3.5 text-muted group-hover:text-red-600" />
                </button>
              )}
            </div>
          ) : (
            <div className="space-y-2">
              <p className="text-xs font-serif text-muted leading-relaxed">
                Đăng nhập để lưu tiến độ bài học và đồng bộ câu sai.
              </p>
              <div className="flex items-center gap-2">
                <button
                  type="button"
                  onClick={() => {
                    onClose()
                    openLoginForm()
                  }}
                  className="flex-1 py-2 rounded-xl bg-title hover:bg-[#2A3250] text-white text-xs font-serif font-semibold shadow-2xs flex items-center justify-center gap-1.5 cursor-pointer touch-manipulation"
                >
                  <LogIn className="w-3.5 h-3.5" />
                  <span>Đăng nhập</span>
                </button>
                <button
                  type="button"
                  onClick={() => {
                    onClose()
                    openRegisterForm()
                  }}
                  className="flex-1 py-2 rounded-xl border border-border text-title hover:bg-page text-xs font-serif font-medium shadow-2xs flex items-center justify-center gap-1.5 cursor-pointer touch-manipulation"
                >
                  <UserPlus className="w-3.5 h-3.5 text-muted" />
                  <span>Đăng ký</span>
                </button>
              </div>
            </div>
          )}
        </div>

        {/* Nội dung danh mục điều hướng (Scrollable Body) */}
        <div className="flex-1 overflow-y-auto py-3 px-3 space-y-4 no-scrollbar font-serif">
          {/* 1. KHU VỰC HỌC TẬP (Core Learning) */}
          <div className="space-y-0.5">
            <div className="px-3 pb-1 text-[10px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
              Học tập
            </div>
            <nav className="space-y-0.5" aria-label="Menu học tập chính">
              {coreLearningItems.map((item) => {
                const Icon = item.icon
                const active = pathname === item.href || (item.href !== '/' && pathname.startsWith(item.href))
                const linkClass = `flex items-center justify-between gap-2.5 px-3 py-2 text-xs rounded-lg border-l-[3px] transition-all select-none ${
                  active
                    ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                    : 'border-transparent text-muted hover:bg-black/5 hover:text-title'
                }`

                const content = (
                  <div className="flex items-center gap-2.5">
                    <Icon className={`h-4 w-4 shrink-0 ${active ? 'text-app-accent' : 'text-muted'}`} />
                    <span>{item.label}</span>
                  </div>
                )

                if (item.isProtected) {
                  return (
                    <ProtectedLink
                      key={item.href}
                      href={item.href}
                      isLoggedIn={isLoggedIn}
                      onClick={onClose}
                      className={linkClass}
                    >
                      {content}
                    </ProtectedLink>
                  )
                }

                return (
                  <Link key={item.href} href={item.href} onClick={onClose} className={linkClass}>
                    {content}
                  </Link>
                )
              })}
            </nav>
          </div>

          {/* 2. KHU VỰC LỘ TRÌNH HSK 3.0 */}
          <div className="space-y-0.5 pt-1">
            <button
              type="button"
              onClick={() => setIsHskExpanded((prev) => !prev)}
              className="w-full flex items-center justify-between px-3 py-1.5 text-[10px] font-semibold uppercase tracking-wider text-muted hover:text-title transition-colors rounded-md select-none cursor-pointer"
            >
              <span className="flex items-center gap-1.5 font-sans">
                <GraduationCap className="w-3.5 h-3.5 text-app-accent" />
                <span>Lộ trình HSK 3.0</span>
              </span>
              <ChevronDown
                className={`w-3.5 h-3.5 text-muted transition-transform duration-200 ${
                  isHskExpanded ? 'rotate-180' : ''
                }`}
              />
            </button>

            {isHskExpanded && (
              <nav className="space-y-1.5 pl-1 pt-0.5" aria-label="Danh sách HSK 3.0">
                {hskStages.map((stageGroup) => (
                  <div key={stageGroup.stage} className="space-y-0.5">
                    <div className="px-3 pt-1 pb-0.5 text-[9px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
                      {stageGroup.stage}
                    </div>
                    {stageGroup.levels.map((hsk) => {
                      const topicName = hsk.label
                      const active = isHskItemActive(topicName)
                      const count = vocabCounts ? vocabCounts[hsk.data.tag] : undefined
                      const isComingSoon =
                        hsk.data.status === 'coming_soon' || (count === 0 && hsk.data.tag === 'HSK 7-9')

                      return (
                        <Link
                          key={topicName}
                          href={`/topics?q=${encodeURIComponent(topicName)}`}
                          onClick={onClose}
                          className={`flex items-center justify-between px-3 py-1.5 text-xs rounded-lg border-l-[3px] transition-all ${
                            active
                              ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                              : 'border-transparent text-body hover:bg-black/5 hover:text-app-accent'
                          }`}
                        >
                          <div className="flex items-center gap-2 min-w-0">
                            <span
                              className={`w-1.5 h-1.5 rounded-full shrink-0 ${
                                active ? 'bg-app-accent' : isComingSoon ? 'bg-amber-400' : 'bg-border-strong'
                              }`}
                            />
                            <span className="font-semibold">{hsk.label}</span>
                          </div>
                          {typeof count === 'number' ? (
                            <span className="text-[10px] font-sans text-muted">
                              {formatNumber(count)} từ
                            </span>
                          ) : isComingSoon ? (
                            <span className="text-[9px] font-sans px-1.5 py-0.2 rounded bg-amber-500/10 text-amber-700">
                              Sắp có
                            </span>
                          ) : null}
                        </Link>
                      )
                    })}
                  </div>
                ))}

                {/* Chuyên đề thực tế */}
                <div className="pt-1.5 space-y-0.5 border-t border-border/40">
                  <div className="px-3 pb-0.5 text-[9px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
                    Chuyên đề ứng dụng
                  </div>
                  {practicalTopics.map((item) => {
                    const active = isHskItemActive(item.topic)
                    const count = vocabCounts ? vocabCounts[item.topic] : undefined

                    return (
                      <Link
                        key={item.topic}
                        href={`/topics?q=${encodeURIComponent(item.topic)}`}
                        onClick={onClose}
                        className={`flex items-center justify-between px-3 py-1.5 text-xs rounded-lg border-l-[3px] transition-all ${
                          active
                            ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                            : 'border-transparent text-body hover:bg-black/5 hover:text-app-accent'
                        }`}
                      >
                        <div className="flex items-center gap-2 min-w-0">
                          <Sparkles className={`w-3 h-3 shrink-0 ${active ? 'text-app-accent' : 'text-muted'}`} />
                          <span className="truncate">{item.label}</span>
                        </div>
                        {typeof count === 'number' && (
                          <span className="text-[10px] font-sans text-muted">{formatNumber(count)} từ</span>
                        )}
                      </Link>
                    )
                  })}
                </div>
              </nav>
            )}
          </div>

          {/* 3. KHU VỰC CÔNG CỤ LUYỆN TẬP */}
          <div className="space-y-0.5 pt-1">
            <div className="px-3 pb-1 text-[10px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
              Công cụ & Kỹ năng
            </div>
            <nav className="space-y-0.5" aria-label="Menu công cụ">
              {practiceTools.map((tool) => {
                const Icon = tool.icon
                const active = pathname === tool.href || pathname.startsWith(tool.href + '/')

                return (
                  <Link
                    key={tool.href}
                    href={tool.href}
                    onClick={onClose}
                    className={`flex items-center justify-between gap-2.5 px-3 py-2 text-xs rounded-lg border-l-[3px] transition-all select-none ${
                      active
                        ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                        : 'border-transparent text-muted hover:bg-black/5 hover:text-title'
                    }`}
                  >
                    <div className="flex items-center gap-2.5 min-w-0">
                      <Icon className={`h-4 w-4 shrink-0 ${active ? 'text-app-accent' : 'text-muted'}`} />
                      <span className="truncate">{tool.label}</span>
                    </div>
                    {tool.badge && (
                      <span className="text-[9px] font-sans px-1.5 py-0.2 rounded bg-amber-500/10 text-amber-700 border border-amber-500/20 font-medium">
                        {tool.badge}
                      </span>
                    )}
                  </Link>
                )
              })}
            </nav>
          </div>

          {/* 4. KHU VỰC QUẢN TRỊ VIÊN (Chỉ hiện khi là Admin) */}
          {isAdmin && (
            <div className="space-y-0.5 pt-1">
              <div className="px-3 pb-1 text-[10px] font-semibold text-app-accent uppercase tracking-wider font-sans flex items-center gap-1.5">
                <ShieldCheck className="h-3.5 w-3.5 text-app-accent shrink-0" />
                <span>Quản trị hệ thống</span>
              </div>
              <nav className="space-y-0.5" aria-label="Menu quản trị">
                <Link
                  href="/admin"
                  onClick={onClose}
                  className={`flex items-center gap-2.5 px-3 py-2 text-xs rounded-lg border-l-[3px] transition-all ${
                    pathname === '/admin'
                      ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                      : 'border-transparent text-muted hover:bg-black/5 hover:text-title'
                  }`}
                >
                  <ShieldCheck className="h-4 w-4 shrink-0 text-app-accent" />
                  <span>Phân quyền tài khoản</span>
                </Link>

                <Link
                  href="/admin/feedback"
                  onClick={onClose}
                  className={`flex items-center gap-2.5 px-3 py-2 text-xs rounded-lg border-l-[3px] transition-all ${
                    pathname.startsWith('/admin/feedback')
                      ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                      : 'border-transparent text-muted hover:bg-black/5 hover:text-title'
                  }`}
                >
                  <MessageSquare className="h-4 w-4 shrink-0 text-app-accent" />
                  <span>Góp ý & Báo lỗi</span>
                </Link>
              </nav>
            </div>
          )}
        </div>

        {/* Footer Drawer */}
        <div
          className="p-3 border-t border-border/50 text-[11px] font-sans text-muted/80 text-center bg-page/95 shrink-0"
          style={{ paddingBottom: 'calc(0.75rem + env(safe-area-inset-bottom, 0px))' }}
        >
          Chinese Notebook • Hán ngữ hiện đại
        </div>
      </aside>
    </div>
  )
}
