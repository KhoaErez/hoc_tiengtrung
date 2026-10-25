'use client'

import React, { useState, useEffect, createContext, useContext, useMemo, useId, useCallback } from 'react'
import Link from 'next/link'
import { usePathname, useRouter, useSearchParams } from 'next/navigation'
import {
  Home,
  ChevronLeft,
  ChevronRight,
  ChevronDown,
  LogOut,
  GraduationCap,
  Keyboard,
  Menu,
  X,
  LogIn,
  UserPlus,
  ShieldCheck,
  BrainCircuit,
  Clock,
} from 'lucide-react'
import { logout } from '@/app/auth/actions'
import { ProtectedLink } from '@/components/protected-link'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import { BrandLogo } from '@/components/ui/brand-logo'
import { AdminNotificationBell } from '@/components/dashboard/admin-notification-bell'
import { formatNumber } from '@/lib/utils'
import { getLiveVocabCountsAction } from '@/app/actions/vocab-counts'
import {
  CORE_LEARNING_ITEMS,
  HSK_GROUP_CONFIG,
  HSK_STAGES_CONFIG,
  APPLIED_GROUP_CONFIG,
  APPLIED_ITEMS_CONFIG,
  FOUNDATION_GROUP_CONFIG,
  FOUNDATION_ITEMS_CONFIG,
  TOOLS_GROUP_CONFIG,
  TOOLS_ITEMS_CONFIG,
  ADMIN_ITEMS_CONFIG,
  isNavigationItemActive,
  getActiveGroupId,
  type NavItemConfig,
} from './navigation-config'

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

  // Khóa cuộn màn hình phía dưới an toàn khi Drawer mở và khôi phục chính xác
  useEffect(() => {
    if (isDrawerOpen) {
      const prevOverflow = document.body.style.overflow
      document.body.style.overflow = 'hidden'
      return () => {
        document.body.style.overflow = prevOverflow
      }
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
        {/* Nút mở Mobile Navigation Drawer (chuẩn touch target 44px) */}
        <button
          type="button"
          onClick={toggleDrawer}
          className="h-11 w-11 flex items-center justify-center rounded-xl text-muted hover:text-title hover:bg-black/5 active:bg-black/10 transition-colors -ml-1 mr-0.5 cursor-pointer touch-manipulation"
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
            className="h-11 w-11 flex items-center justify-center rounded-xl text-muted hover:text-title hover:bg-black/5 active:bg-black/10 transition-colors mr-1 cursor-pointer touch-manipulation"
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
            className="h-11 w-11 flex items-center justify-center rounded-xl hover:bg-black/5 active:bg-black/10 transition-colors touch-manipulation -mr-1"
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
            className="flex items-center gap-1.5 px-3 py-1.5 min-h-[44px] rounded-xl border border-border/80 bg-card text-xs font-serif text-title hover:text-app-accent hover:border-app-accent/40 active:bg-page transition-colors cursor-pointer shadow-2xs touch-manipulation"
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
  const searchParams = useSearchParams()
  const qParam = searchParams?.get('q')
  const { isDrawerOpen, toggleDrawer, closeDrawer } = useMobileNav()

  // 4 Tabs chính + 1 Tab mở Menu Drawer
  const coreNavItems = [
    { href: '/', icon: Home, label: 'Trang chủ', isProtected: false },
    { href: '/topics', icon: GraduationCap, label: 'HSK', isProtected: false },
    { href: '/typing', icon: Keyboard, label: 'Luyện gõ', isProtected: false },
    { href: '/review', icon: BrainCircuit, label: 'Ôn tập', isProtected: true },
  ]

  // Xác định liệu người dùng có đang ở mục mở rộng
  const activeGroup = getActiveGroupId(pathname, qParam)
  const isExtendedActive =
    isDrawerOpen ||
    activeGroup === 'applied' ||
    activeGroup === 'foundation' ||
    pathname.startsWith('/lessons') ||
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
                ? (pathname === '/topics' && (!qParam || qParam.startsWith('HSK'))) || pathname.startsWith('/hsk')
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
                  className={`text-[10px] sm:text-[11px] font-sans tracking-normal leading-tight text-center whitespace-nowrap px-0.5 transition-colors duration-200 ${
                    isActive ? 'font-bold text-app-accent' : 'font-medium text-muted'
                  }`}
                >
                  {item.label}
                </span>
              </>
            )

            const containerClasses =
              'flex flex-col items-center justify-center w-full h-full gap-0.5 transition-colors outline-none cursor-pointer touch-manipulation min-h-[48px]'

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
            className="flex flex-col items-center justify-center w-full h-full gap-0.5 transition-colors outline-none cursor-pointer touch-manipulation min-h-[48px]"
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
              className={`text-[10px] sm:text-[11px] font-sans tracking-normal leading-tight text-center whitespace-nowrap transition-colors duration-200 ${
                isExtendedActive ? 'font-bold text-app-accent' : 'font-medium text-muted'
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
// 4. MOBILE NAVIGATION DRAWER (4 NHÓM HỌC TẬP KHOA HỌC TRÊN DI ĐỘNG)
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
  const drawerAccordionId = useId()

  const [confirmLogout, setConfirmLogout] = useState(false)
  const [vocabCounts, setVocabCounts] = useState<Record<string, number | null> | undefined>(
    initialVocabCounts
  )

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

  // Lắng nghe sự kiện cập nhật từ vựng
  useEffect(() => {
    const handleUpdate = () => {
      getLiveVocabCountsAction()
        .then((res) => setVocabCounts(res.counts))
        .catch(() => {})
    }
    window.addEventListener('vocab-counts-updated', handleUpdate)
    return () => window.removeEventListener('vocab-counts-updated', handleUpdate)
  }, [])

  // 1. Quản lý trạng thái đóng/mở của các nhóm Accordion trên Mobile
  // Trên MOBILE: Mặc định luôn THU GỌN tất cả các nhóm (kể cả nhóm đang có active route)
  // Chỉ mở khi người dùng chủ động nhấn vào tiêu đề nhóm hoặc biểu tượng mũi tên
  const activeGroupId = getActiveGroupId(pathname, qParam)

  const [expandedGroups, setExpandedGroups] = useState<Record<string, boolean>>({
    hsk: false,
    applied: false,
    foundation: false,
    tools: false,
  })

  // Đặt lại các nhóm về mặc định thu gọn và reset xác nhận đăng xuất mỗi khi đóng Drawer
  useEffect(() => {
    if (!isOpen) {
      setConfirmLogout(false)
      setExpandedGroups({
        hsk: false,
        applied: false,
        foundation: false,
        tools: false,
      })
    }
  }, [isOpen])

  const toggleGroup = useCallback((groupId: string) => {
    setExpandedGroups((prev) => ({
      ...prev,
      [groupId]: !prev[groupId],
    }))
  }, [])

  // 2. Modal thông báo lộ trình HSK 7–9
  const [comingSoonModal, setComingSoonModal] = useState<{
    title: string
    message: string
  } | null>(null)

  const displayName = profile?.display_name || user?.email?.split('@')[0] || 'Học viên'
  const initial = displayName[0]?.toUpperCase() || 'U'

  // Render badge số lượng
  const renderBadge = (tag: string, defaultStatus?: string) => {
    const count = vocabCounts ? vocabCounts[tag] : undefined

    if (tag === 'HSK 7-9' || (count === 0 && defaultStatus === 'coming_soon')) {
      return (
        <span className="text-[10px] font-sans px-1.5 py-0.5 rounded shrink-0 whitespace-nowrap bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20">
          Sắp có
        </span>
      )
    }

    if (typeof count === 'number') {
      const active = isNavigationItemActive(pathname, qParam, { topic: tag })
      return (
        <span className={`text-[10px] font-sans px-1.5 py-0.5 rounded shrink-0 whitespace-nowrap font-medium ${
          active ? 'bg-app-accent/15 text-app-accent' : 'bg-black/[0.03] text-muted'
        }`}>
          {formatNumber(count)} từ
        </span>
      )
    }

    return null
  }

  // Render mục đơn trong Drawer
  const renderDrawerItem = (item: NavItemConfig) => {
    const Icon = item.icon
    const active = isNavigationItemActive(pathname, qParam, item)
    const linkClass = `flex items-center justify-between gap-2.5 px-3 py-2.5 min-h-[44px] text-xs rounded-xl border-l-[3px] transition-all select-none touch-manipulation cursor-pointer ${
      active
        ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
        : 'border-transparent text-muted hover:bg-black/5 hover:text-title active:bg-black/10'
    }`

    const content = (
      <>
        <div className="flex items-center gap-2.5 min-w-0">
          {Icon && <Icon className={`h-4 w-4 shrink-0 ${active ? 'text-app-accent' : 'text-muted'}`} />}
          <span className="truncate whitespace-nowrap">{item.label}</span>
        </div>
        {item.badge && (
          <span className="text-[10px] font-sans px-1.5 py-0.5 rounded bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20 shrink-0 whitespace-nowrap">
            {item.badge}
          </span>
        )}
      </>
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
        className="fixed top-0 bottom-0 left-0 w-[86vw] max-w-xs bg-page z-50 shadow-2xl flex flex-col border-r border-border/80 animate-in slide-in-from-left duration-250 ease-out"
        role="dialog"
        aria-label="Menu điều hướng hệ thống"
      >
        {/* Header Drawer */}
        <div className="h-14 border-b border-border/60 bg-page/95 px-4 flex items-center justify-between shrink-0">
          <BrandLogo variant="horizontal" size="xs" showSubtitle={false} />
          <button
            type="button"
            onClick={onClose}
            className="h-11 w-11 rounded-xl flex items-center justify-center text-muted hover:text-title hover:bg-black/5 transition-colors cursor-pointer touch-manipulation -mr-2"
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
                className="flex items-center justify-between p-2 rounded-xl bg-page border border-border/70 hover:border-app-accent/40 transition-colors group min-h-[44px] touch-manipulation"
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
                <div className="p-2.5 rounded-xl bg-red-500/10 border border-red-500/20 space-y-2 animate-in fade-in">
                  <p className="text-[11px] font-serif text-red-600 font-medium text-center">
                    Bạn có chắc muốn đăng xuất?
                  </p>
                  <div className="flex items-center gap-2">
                    <button
                      type="button"
                      onClick={() => setConfirmLogout(false)}
                      className="flex-1 py-2 rounded-lg border border-border text-[11px] font-serif text-muted hover:bg-page min-h-[40px] touch-manipulation"
                    >
                      Hủy
                    </button>
                    <form action={logout} className="flex-1">
                      <button
                        type="submit"
                        className="w-full py-2 rounded-lg bg-red-600 text-white text-[11px] font-serif font-semibold hover:bg-red-700 min-h-[40px] touch-manipulation cursor-pointer"
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
                  className="w-full flex items-center justify-between px-2.5 py-2 text-xs text-muted hover:text-red-600 hover:bg-red-500/5 transition-colors rounded-lg group cursor-pointer min-h-[40px] touch-manipulation"
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
                  className="flex-1 py-2.5 rounded-xl bg-title hover:bg-[#2A3250] text-white text-xs font-serif font-semibold shadow-2xs flex items-center justify-center gap-1.5 cursor-pointer touch-manipulation min-h-[44px]"
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
                  className="flex-1 py-2.5 rounded-xl border border-border text-title hover:bg-page text-xs font-serif font-medium shadow-2xs flex items-center justify-center gap-1.5 cursor-pointer touch-manipulation min-h-[44px]"
                >
                  <UserPlus className="w-3.5 h-3.5 text-muted" />
                  <span>Đăng ký</span>
                </button>
              </div>
            </div>
          )}
        </div>

        {/* Nội dung danh mục điều hướng (Scrollable Body) */}
        <div className="flex-1 overflow-y-auto overscroll-contain touch-pan-y py-3 px-3 pb-10 space-y-3.5 no-scrollbar font-serif">
          
          {/* ================================================================ */}
          {/* TỔNG QUAN (CORE LEARNING) */}
          {/* ================================================================ */}
          <div className="space-y-0.5">
            <div className="px-3 pb-1 text-[10px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
              Tổng quan
            </div>
            <nav className="space-y-0.5" aria-label="Menu tổng quan di động">
              {CORE_LEARNING_ITEMS.map(renderDrawerItem)}
            </nav>
          </div>

          {/* ================================================================ */}
          {/* NHÓM 1: LỘ TRÌNH HSK 3.0 (ACCORDION) */}
          {/* ================================================================ */}
          <div className="space-y-0.5 pt-0.5">
            <button
              id={`${drawerAccordionId}-header-hsk`}
              type="button"
              onClick={() => toggleGroup('hsk')}
              className={`w-full flex items-center justify-between px-3 py-2.5 min-h-[44px] text-xs font-bold font-sans tracking-normal transition-all rounded-xl select-none cursor-pointer touch-manipulation ${
                expandedGroups.hsk
                  ? 'text-title bg-black/[0.03] dark:bg-white/[0.04]'
                  : activeGroupId === 'hsk'
                  ? 'text-app-accent bg-app-accent/5'
                  : 'text-muted hover:text-title hover:bg-black/[0.02]'
              }`}
              aria-expanded={expandedGroups.hsk}
              aria-controls={`${drawerAccordionId}-content-hsk`}
            >
              <span className="flex items-center gap-2 font-sans min-w-0">
                <HSK_GROUP_CONFIG.icon className={`w-4 h-4 shrink-0 transition-colors ${expandedGroups.hsk || activeGroupId === 'hsk' ? 'text-app-accent' : 'text-muted'}`} />
                <span className="font-bold tracking-normal whitespace-nowrap truncate">{HSK_GROUP_CONFIG.title}</span>
              </span>
              <span className="flex items-center gap-1.5 shrink-0 ml-1.5">
                {!expandedGroups.hsk && (
                  <span className="text-[10px] font-mono text-muted/70 font-medium px-1.5 py-0.5 rounded bg-black/[0.04] dark:bg-white/[0.06] shrink-0 whitespace-nowrap">
                    HSK 1–9
                  </span>
                )}
                <ChevronDown
                  className={`w-3.5 h-3.5 shrink-0 text-muted transition-transform duration-250 ease-out ${
                    expandedGroups.hsk ? 'rotate-180 text-app-accent' : ''
                  }`}
                />
              </span>
            </button>

            <div
              id={`${drawerAccordionId}-content-hsk`}
              role="region"
              aria-labelledby={`${drawerAccordionId}-header-hsk`}
              className={`grid transition-[grid-template-rows,opacity] duration-250 ease-in-out ${
                expandedGroups.hsk ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0 pointer-events-none'
              }`}
            >
              <div className="overflow-hidden">
                <nav className="space-y-1.5 pl-1 pt-1 pb-1" aria-label="Danh sách HSK 3.0 di động">
                  {HSK_STAGES_CONFIG.map((stageGroup) => (
                    <div key={stageGroup.stage} className="space-y-0.5">
                      <div className="px-3 pt-1 pb-0.5 text-[9px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
                        {stageGroup.stage} ({stageGroup.stageZh})
                      </div>
                      {stageGroup.levels.map((hsk) => {
                        const active = isNavigationItemActive(pathname, qParam, { topic: hsk.topic })
                        const count = vocabCounts ? vocabCounts[hsk.data.tag] : undefined
                        const isComingSoon = hsk.isComingSoon || hsk.data.status === 'coming_soon' || (count === 0 && hsk.data.tag === 'HSK 7-9')

                        return (
                          <Link
                            key={hsk.topic}
                            href={hsk.href}
                            onClick={(e) => {
                              if (isComingSoon) {
                                e.preventDefault()
                                setComingSoonModal({
                                  title: hsk.label,
                                  message: hsk.data.friendlyNotice,
                                })
                              } else {
                                onClose()
                              }
                            }}
                            className={`flex items-center justify-between gap-2 px-3 py-2 min-h-[44px] text-xs rounded-xl border-l-[3px] transition-all touch-manipulation cursor-pointer ${
                              active
                                ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                                : 'border-transparent text-body hover:bg-black/5 hover:text-app-accent active:bg-black/10'
                            }`}
                          >
                            <div className="flex items-center gap-2 min-w-0">
                              <span
                                className={`w-1.5 h-1.5 rounded-full shrink-0 ${
                                  active ? 'bg-app-accent' : isComingSoon ? 'bg-amber-400' : 'bg-border-strong'
                                }`}
                              />
                              <span className="font-semibold whitespace-nowrap truncate">{hsk.label}</span>
                            </div>
                            {renderBadge(hsk.data.tag, hsk.data.status)}
                          </Link>
                        )
                      })}
                    </div>
                  ))}
                </nav>
              </div>
            </div>
          </div>

          {/* ================================================================ */}
          {/* NHÓM 2: GIAO TIẾP & ỨNG DỤNG (ACCORDION) */}
          {/* ================================================================ */}
          <div className="space-y-0.5 pt-0.5">
            <button
              id={`${drawerAccordionId}-header-applied`}
              type="button"
              onClick={() => toggleGroup('applied')}
              className={`w-full flex items-center justify-between px-3 py-2.5 min-h-[44px] text-xs font-bold font-sans tracking-normal transition-all rounded-xl select-none cursor-pointer touch-manipulation ${
                expandedGroups.applied
                  ? 'text-title bg-black/[0.03] dark:bg-white/[0.04]'
                  : activeGroupId === 'applied'
                  ? 'text-app-accent bg-app-accent/5'
                  : 'text-muted hover:text-title hover:bg-black/[0.02]'
              }`}
              aria-expanded={expandedGroups.applied}
              aria-controls={`${drawerAccordionId}-content-applied`}
            >
              <span className="flex items-center gap-2 font-sans min-w-0">
                <APPLIED_GROUP_CONFIG.icon className={`w-4 h-4 shrink-0 transition-colors ${expandedGroups.applied || activeGroupId === 'applied' ? 'text-app-accent' : 'text-muted'}`} />
                <span className="font-bold tracking-normal whitespace-nowrap truncate">{APPLIED_GROUP_CONFIG.title}</span>
              </span>
              <span className="flex items-center gap-1.5 shrink-0 ml-1.5">
                <ChevronDown
                  className={`w-3.5 h-3.5 shrink-0 text-muted transition-transform duration-250 ease-out ${
                    expandedGroups.applied ? 'rotate-180 text-app-accent' : ''
                  }`}
                />
              </span>
            </button>

            <div
              id={`${drawerAccordionId}-content-applied`}
              role="region"
              aria-labelledby={`${drawerAccordionId}-header-applied`}
              className={`grid transition-[grid-template-rows,opacity] duration-250 ease-in-out ${
                expandedGroups.applied ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0 pointer-events-none'
              }`}
            >
              <div className="overflow-hidden">
                <nav className="space-y-0.5 pl-1 pt-1 pb-1" aria-label="Menu giao tiếp & ứng dụng di động">
                  {APPLIED_ITEMS_CONFIG.map((item) => {
                    const Icon = item.icon
                    const active = isNavigationItemActive(pathname, qParam, item)
                    const countTag = item.topic || ''

                    return (
                      <Link
                        key={item.href}
                        href={item.href}
                        onClick={onClose}
                        className={`flex items-center justify-between gap-2 px-3 py-2 min-h-[44px] text-xs rounded-xl border-l-[3px] transition-all touch-manipulation cursor-pointer ${
                          active
                            ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                            : 'border-transparent text-body hover:bg-black/5 hover:text-app-accent active:bg-black/10'
                        }`}
                      >
                        <div className="flex items-center gap-2 min-w-0">
                          {Icon && <Icon className={`w-3.5 h-3.5 shrink-0 ${active ? 'text-app-accent' : 'text-muted'}`} />}
                          <span className="truncate whitespace-nowrap">{item.label}</span>
                        </div>
                        {item.data && renderBadge(countTag, item.data.status)}
                      </Link>
                    )
                  })}
                </nav>
              </div>
            </div>
          </div>

          {/* ================================================================ */}
          {/* NHÓM 3: NỀN TẢNG TIẾNG TRUNG (ACCORDION) */}
          {/* ================================================================ */}
          <div className="space-y-0.5 pt-0.5">
            <button
              id={`${drawerAccordionId}-header-foundation`}
              type="button"
              onClick={() => toggleGroup('foundation')}
              className={`w-full flex items-center justify-between px-3 py-2.5 min-h-[44px] text-xs font-bold font-sans tracking-normal transition-all rounded-xl select-none cursor-pointer touch-manipulation ${
                expandedGroups.foundation
                  ? 'text-title bg-black/[0.03] dark:bg-white/[0.04]'
                  : activeGroupId === 'foundation'
                  ? 'text-app-accent bg-app-accent/5'
                  : 'text-muted hover:text-title hover:bg-black/[0.02]'
              }`}
              aria-expanded={expandedGroups.foundation}
              aria-controls={`${drawerAccordionId}-content-foundation`}
            >
              <span className="flex items-center gap-2 font-sans min-w-0">
                <FOUNDATION_GROUP_CONFIG.icon className={`w-4 h-4 shrink-0 transition-colors ${expandedGroups.foundation || activeGroupId === 'foundation' ? 'text-app-accent' : 'text-muted'}`} />
                <span className="font-bold tracking-normal whitespace-nowrap truncate">{FOUNDATION_GROUP_CONFIG.title}</span>
              </span>
              <span className="flex items-center gap-1.5 shrink-0 ml-1.5">
                <ChevronDown
                  className={`w-3.5 h-3.5 shrink-0 text-muted transition-transform duration-250 ease-out ${
                    expandedGroups.foundation ? 'rotate-180 text-app-accent' : ''
                  }`}
                />
              </span>
            </button>

            <div
              id={`${drawerAccordionId}-content-foundation`}
              role="region"
              aria-labelledby={`${drawerAccordionId}-header-foundation`}
              className={`grid transition-[grid-template-rows,opacity] duration-250 ease-in-out ${
                expandedGroups.foundation ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0 pointer-events-none'
              }`}
            >
              <div className="overflow-hidden">
                <nav className="space-y-0.5 pl-1 pt-1 pb-1" aria-label="Menu nền tảng tiếng Trung di động">
                  {FOUNDATION_ITEMS_CONFIG.map((item) => {
                    const Icon = item.icon
                    const active = isNavigationItemActive(pathname, qParam, item)

                    return (
                      <Link
                        key={item.href}
                        href={item.href}
                        onClick={onClose}
                        className={`flex items-center justify-between gap-2 px-3 py-2 min-h-[44px] text-xs rounded-xl border-l-[3px] transition-all touch-manipulation cursor-pointer ${
                          active
                            ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                            : 'border-transparent text-body hover:bg-black/5 hover:text-app-accent active:bg-black/10'
                        }`}
                      >
                        <div className="flex items-center gap-2 min-w-0">
                          {Icon && <Icon className={`w-3.5 h-3.5 shrink-0 ${active ? 'text-app-accent' : 'text-muted'}`} />}
                          <span className="truncate whitespace-nowrap">{item.label}</span>
                        </div>
                        {item.badge && (
                          <span className={`text-[10px] font-sans px-1.5 py-0.5 rounded font-medium border shrink-0 whitespace-nowrap ${
                            active
                              ? 'bg-app-accent/15 text-app-accent border-app-accent/30'
                              : 'bg-black/[0.03] text-muted border-border/60'
                          }`}>
                            {item.badge}
                          </span>
                        )}
                      </Link>
                    )
                  })}
                </nav>
              </div>
            </div>
          </div>

          {/* ================================================================ */}
          {/* NHÓM 4: CÔNG CỤ & KỸ NĂNG (ACCORDION) */}
          {/* ================================================================ */}
          <div className="space-y-0.5 pt-0.5">
            <button
              id={`${drawerAccordionId}-header-tools`}
              type="button"
              onClick={() => toggleGroup('tools')}
              className={`w-full flex items-center justify-between px-3 py-2.5 min-h-[44px] text-xs font-bold font-sans tracking-normal transition-all rounded-xl select-none cursor-pointer touch-manipulation ${
                expandedGroups.tools
                  ? 'text-title bg-black/[0.03] dark:bg-white/[0.04]'
                  : activeGroupId === 'tools'
                  ? 'text-app-accent bg-app-accent/5'
                  : 'text-muted hover:text-title hover:bg-black/[0.02]'
              }`}
              aria-expanded={expandedGroups.tools}
              aria-controls={`${drawerAccordionId}-content-tools`}
            >
              <span className="flex items-center gap-2 font-sans min-w-0">
                <TOOLS_GROUP_CONFIG.icon className={`w-4 h-4 shrink-0 transition-colors ${expandedGroups.tools || activeGroupId === 'tools' ? 'text-app-accent' : 'text-muted'}`} />
                <span className="font-bold tracking-normal whitespace-nowrap truncate">{TOOLS_GROUP_CONFIG.title}</span>
              </span>
              <span className="flex items-center gap-1.5 shrink-0 ml-1.5">
                <ChevronDown
                  className={`w-3.5 h-3.5 shrink-0 text-muted transition-transform duration-250 ease-out ${
                    expandedGroups.tools ? 'rotate-180 text-app-accent' : ''
                  }`}
                />
              </span>
            </button>

            <div
              id={`${drawerAccordionId}-content-tools`}
              role="region"
              aria-labelledby={`${drawerAccordionId}-header-tools`}
              className={`grid transition-[grid-template-rows,opacity] duration-250 ease-in-out ${
                expandedGroups.tools ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0 pointer-events-none'
              }`}
            >
              <div className="overflow-hidden">
                <nav className="space-y-0.5 pl-1 pt-1 pb-1" aria-label="Menu công cụ di động">
                  {TOOLS_ITEMS_CONFIG.map((tool) => {
                    const Icon = tool.icon
                    const active = isNavigationItemActive(pathname, qParam, tool)

                    return (
                      <Link
                        key={tool.href}
                        href={tool.href}
                        onClick={onClose}
                        className={`flex items-center justify-between gap-2.5 px-3 py-2 min-h-[44px] text-xs rounded-xl border-l-[3px] transition-all select-none touch-manipulation cursor-pointer ${
                          active
                            ? 'border-app-accent bg-app-accent-soft text-app-accent font-semibold shadow-2xs'
                            : 'border-transparent text-muted hover:bg-black/5 hover:text-title active:bg-black/10'
                        }`}
                      >
                        <div className="flex items-center gap-2.5 min-w-0">
                          {Icon && <Icon className={`h-4 w-4 shrink-0 ${active ? 'text-app-accent' : 'text-muted'}`} />}
                          <span className="truncate whitespace-nowrap">{tool.label}</span>
                        </div>
                        {tool.badge && (
                          <span className="text-[10px] font-sans px-1.5 py-0.5 rounded bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20 font-medium shrink-0 whitespace-nowrap">
                            {tool.badge}
                          </span>
                        )}
                      </Link>
                    )
                  })}
                </nav>
              </div>
            </div>
          </div>

          {/* ================================================================ */}
          {/* KHU VỰC QUẢN TRỊ VIÊN (CHỈ HIỆN KHI LÀ ADMIN) */}
          {/* ================================================================ */}
          {isAdmin && (
            <div className="space-y-0.5 pt-1 border-t border-border/40">
              <div className="px-3 pb-1 text-[10px] font-semibold text-app-accent uppercase tracking-wider font-sans flex items-center gap-1.5">
                <ShieldCheck className="h-3.5 w-3.5 text-app-accent shrink-0" />
                <span>Quản trị hệ thống</span>
              </div>
              <nav className="space-y-0.5" aria-label="Menu quản trị di động">
                {ADMIN_ITEMS_CONFIG.map(renderDrawerItem)}
              </nav>
            </div>
          )}
        </div>

        {/* Footer Drawer */}
        <div
          className="p-3 border-t border-border/50 text-[11px] font-sans text-muted/80 text-center bg-page/95 shrink-0"
          style={{ paddingBottom: 'calc(0.75rem + env(safe-area-inset-bottom, 0px))' }}
        >
          <Link
            href="/about"
            onClick={onClose}
            className="hover:text-app-accent hover:underline transition-colors block py-1"
          >
            © 2026 Chinese Notebook • Về tác giả & Dự án
          </Link>
        </div>
      </aside>

      {/* Modal HSK 7–9 Coming Soon */}
      {comingSoonModal && (
        <div className="fixed inset-0 z-60 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs animate-in fade-in-0 duration-150">
          <div className="bg-card border border-border rounded-2xl max-w-sm w-full p-5 shadow-2xl space-y-4">
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-amber-500/10 border border-amber-500/20 text-amber-600 flex items-center justify-center shrink-0">
                  <Clock className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="font-serif font-bold text-base text-title">
                    Lộ trình {comingSoonModal.title}
                  </h3>
                  <span className="text-[11px] font-serif text-amber-700 dark:text-amber-400 font-medium">
                    Đang hoàn thiện nội dung
                  </span>
                </div>
              </div>
              <button
                onClick={() => setComingSoonModal(null)}
                className="text-muted hover:text-title p-1.5 rounded-lg hover:bg-page transition-colors cursor-pointer"
                aria-label="Đóng"
              >
                <X className="w-4 h-4" />
              </button>
            </div>

            <div className="p-3 rounded-xl bg-page border border-border/70 text-xs font-serif text-body leading-relaxed space-y-2">
              <p className="font-medium text-title">
                {comingSoonModal.message}
              </p>
              <p className="text-[11px] text-muted">
                Theo đề cương HSK 3.0 (GF 0025-2021), khối thi Cao cấp HSK 7–9 gồm 11.092 từ vựng. Dữ liệu đang được biên soạn kỹ lưỡng.
              </p>
            </div>

            <div className="flex items-center justify-end gap-2 pt-1">
              <button
                type="button"
                onClick={() => {
                  setComingSoonModal(null)
                  onClose()
                }}
                className="w-full py-2.5 rounded-xl text-xs font-serif font-bold bg-app-accent text-white hover:bg-accent-hover transition-colors shadow-2xs cursor-pointer min-h-[44px]"
              >
                Đã hiểu
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
