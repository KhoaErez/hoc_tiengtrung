'use client'

import React from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { 
  Sparkles, 
  Menu, 
  X, 
  User as UserIcon, 
  BookOpen, 
  GraduationCap, 
  Keyboard, 
  Library, 
  Layers, 
  ArrowRight,
  ShieldCheck,
  LogOut,
  BookMarked,
  Info,
  ChevronRight,
  Sparkle
} from 'lucide-react'
import { BrandLogo } from '@/components/ui/brand-logo'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import { useMobileNav } from './mobile-nav-context'
import { logout } from '@/app/auth/actions'
import type { User } from '@supabase/supabase-js'

interface PillNavbarProps {
  user?: User | null
  profile?: {
    display_name?: string | null
    avatar_url?: string | null
  } | null
  isAdmin?: boolean
}

export function PillNavbar({ user: initialUser, profile, isAdmin }: PillNavbarProps) {
  const pathname = usePathname()
  const { user: authUser, openLoginForm } = useAuthModal()
  const { isMenuOpen, toggleMenu, closeMenu } = useMobileNav()

  // Ưu tiên session từ AuthContext (nếu client vừa đăng nhập) hoặc fallback server user
  const currentUser = authUser || initialUser

  const desktopNavLinks = [
    { label: 'Trang chủ', href: '/', icon: BookOpen },
    { label: 'Lộ trình HSK', href: '/topics', icon: GraduationCap },
    { label: 'Luyện gõ', href: '/typing', icon: Keyboard },
    { label: 'Ôn tập SM-2', href: '/review', icon: Layers },
    { label: '214 Bộ thủ', href: '/radicals', icon: BookOpen },
    { label: 'Luyện viết AI', href: '/write', icon: Sparkles },
    { label: 'Ngữ pháp', href: '/grammar', icon: Library },
  ]

  // Danh mục menu mobile được phân nhóm rõ ràng theo chuẩn Mobile-First UX
  const mobileNavGroups = [
    {
      groupTitle: 'Lộ trình & Luyện tập',
      items: [
        { label: 'Trang chủ', href: '/', icon: BookOpen, desc: 'Tổng quan & Hành trình' },
        { label: 'Lộ trình HSK 1–9', href: '/topics', icon: GraduationCap, desc: 'Lộ trình bài học chuẩn hóa' },
        { label: 'Luyện gõ phím IME', href: '/typing', icon: Keyboard, desc: 'Phản xạ gõ Hán tự Pinyin' },
        { label: 'Ôn tập thẻ nhớ SM-2', href: '/review', icon: Layers, desc: 'Lặp lại ngắt quãng thông minh' },
      ],
    },
    {
      groupTitle: 'Kho tàng Tri thức & AI',
      items: [
        { label: '214 Bộ thủ Khang Hy', href: '/radicals', icon: BookOpen, desc: 'Cội nguồn cấu tạo chữ Hán' },
        { label: 'Cẩm nang Ngữ pháp', href: '/grammar', icon: Library, desc: 'Cấu trúc câu & ngữ pháp HSK' },
        { label: 'Thư viện bài đọc', href: '/lessons', icon: BookMarked, desc: 'Mẫu truyện & bài đọc tương tác' },
        { label: 'Luyện viết AI', href: '/write', icon: Sparkles, desc: 'Trợ lý sửa lỗi hành văn', badge: 'Sắp ra mắt' },
      ],
    },
    {
      groupTitle: 'Hệ thống & Tài khoản',
      items: [
        { label: 'Trang cá nhân', href: '/profile', icon: UserIcon, desc: 'Tiến độ học & Thống kê cá nhân' },
        ...(isAdmin
          ? [{ label: 'Trung tâm Quản trị Admin', href: '/admin', icon: ShieldCheck, desc: 'Giám sát học viên & Phân quyền', badge: 'Admin' }]
          : []),
        { label: 'Giới thiệu & Bản quyền', href: '/about', icon: Info, desc: 'Về dự án Chinese Notebook' },
      ],
    },
  ]

  return (
    <>
      <header className="sticky top-2 sm:top-4 z-40 px-2 sm:px-6 w-full sm:w-[94%] max-w-[1680px] mx-auto select-none">
        {/* Khung Pill Navbar chính (The Mandarin Lab inspired) */}
        <nav 
          aria-label="Thanh điều hướng chính"
          className="w-full rounded-2xl sm:rounded-full bg-[#FAF7F2]/95 dark:bg-[#182238]/95 backdrop-blur-md border-2 border-[#182238] dark:border-[#384869] shadow-[0_4px_0_#182238] dark:shadow-[0_4px_0_#0D1322] px-3 sm:px-6 py-2 sm:py-2.5 flex items-center justify-between transition-all min-h-[56px] sm:min-h-[60px]"
        >
          {/* 1. Bên trái: Logo Chinese Notebook (ẩn subtitle trên màn hình nhỏ để tránh tràn) */}
          <div className="flex items-center gap-2">
            <div className="hidden sm:block">
              <BrandLogo variant="horizontal" size="sm" />
            </div>
            <div className="sm:hidden">
              <BrandLogo variant="horizontal" size="xs" showSubtitle={false} />
            </div>
          </div>

          {/* 2. Ở giữa: Menu điều hướng (Desktop) */}
          <div className="hidden lg:flex items-center gap-1 xl:gap-2">
            {desktopNavLinks.map((link) => {
              const isActive = link.href === '/' ? pathname === '/' : pathname.startsWith(link.href)
              return (
                <Link
                  key={link.label}
                  href={link.href}
                  className={`px-3 py-1.5 rounded-full text-xs font-serif font-medium transition-all duration-150 ${
                    isActive
                      ? 'bg-[#182238] text-white shadow-xs'
                      : 'text-[#182238] dark:text-slate-200 hover:bg-[#182238]/10 dark:hover:bg-white/10'
                  }`}
                >
                  {link.label}
                </Link>
              )
            })}
          </div>

          {/* 3. Bên phải: Tài khoản & Nút CTA & Hamburger (Gọn gàng trên Mobile) */}
          <div className="flex items-center gap-2 sm:gap-2.5">
            {currentUser ? (
              <div className="flex items-center gap-2">
                {isAdmin && (
                  <Link
                    href="/admin"
                    className="hidden sm:inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-amber-500/15 border border-amber-500/30 text-amber-800 dark:text-amber-300 text-[11px] font-sans font-bold"
                    title="Bảng điều khiển quản trị"
                  >
                    <ShieldCheck className="w-3.5 h-3.5 text-amber-600" />
                    <span>Admin</span>
                  </Link>
                )}

                <Link
                  href="/profile"
                  className="flex items-center gap-1.5 p-1 sm:px-2.5 sm:py-1 rounded-full hover:bg-[#182238]/10 dark:hover:bg-white/10 transition-colors group"
                  title="Hồ sơ học viên"
                >
                  <div className="w-8 h-8 sm:w-7 sm:h-7 rounded-full bg-[#182238] text-white flex items-center justify-center text-xs font-bold border border-[#182238] shadow-xs">
                    {(profile?.display_name || currentUser.email)?.[0]?.toUpperCase() || 'U'}
                  </div>
                  <span className="hidden md:inline text-xs font-serif font-semibold text-[#182238] dark:text-slate-200 max-w-[100px] truncate">
                    {profile?.display_name || currentUser.email?.split('@')[0]}
                  </span>
                </Link>

                {/* Nút "Tiếp tục học" chỉ hiện trên Tablet & Desktop để nhường chỗ trên Mobile */}
                <Link href="/topics" className="hidden sm:inline-flex">
                  <button
                    type="button"
                    className="px-3.5 sm:px-4 py-1.5 rounded-full bg-[#B8322D] hover:bg-[#9E2A25] active:translate-y-0.5 text-white text-xs font-serif font-bold shadow-[0_2px_0_#7A1D1A] transition-all flex items-center gap-1.5 cursor-pointer touch-manipulation"
                  >
                    <span>Tiếp tục học</span>
                    <ArrowRight className="w-3.5 h-3.5" />
                  </button>
                </Link>
              </div>
            ) : (
              <div className="flex items-center gap-1.5 sm:gap-2">
                <button
                  type="button"
                  onClick={() => openLoginForm({ title: 'Đăng nhập Chinese Notebook' })}
                  className="px-3 py-1.5 rounded-full text-xs font-serif font-semibold text-[#182238] dark:text-slate-200 hover:bg-[#182238]/10 dark:hover:bg-white/10 transition-colors cursor-pointer"
                >
                  Đăng nhập
                </button>

                <Link href="/topics?q=HSK 1" className="hidden sm:inline-flex">
                  <button
                    type="button"
                    className="px-3 sm:px-4 py-1.5 rounded-full bg-[#B8322D] hover:bg-[#9E2A25] active:translate-y-0.5 text-white text-xs font-serif font-bold shadow-[0_2px_0_#7A1D1A] transition-all flex items-center gap-1 cursor-pointer touch-manipulation"
                  >
                    <span>Học miễn phí</span>
                    <Sparkles className="w-3.5 h-3.5 text-amber-200" />
                  </button>
                </Link>
              </div>
            )}

            {/* Nút Hamburger bật/tắt Drawer - Chuẩn kích thước chạm 44x44px trên Mobile */}
            <button
              type="button"
              onClick={toggleMenu}
              className="lg:hidden w-10 h-10 sm:w-11 sm:h-11 rounded-full border-2 border-[#182238] dark:border-[#384869] bg-white/90 dark:bg-[#182238] shadow-[0_2px_0_#182238] dark:shadow-[0_2px_0_#0D1322] flex items-center justify-center text-[#182238] dark:text-white hover:bg-[#FAF7F2] active:translate-y-0.5 transition-all cursor-pointer touch-manipulation"
              aria-label={isMenuOpen ? 'Đóng menu' : 'Mở menu điều hướng'}
              aria-expanded={isMenuOpen}
            >
              {isMenuOpen ? <X className="w-5 h-5 text-[#B8322D]" /> : <Menu className="w-5 h-5" />}
            </button>
          </div>
        </nav>
      </header>

      {/* FULL-HEIGHT MOBILE DRAWER / SHEET */}
      {isMenuOpen && (
        <div 
          className="fixed inset-0 z-50 lg:hidden flex justify-end"
          role="dialog"
          aria-modal="true"
          aria-label="Danh mục chức năng mobile"
        >
          {/* Lớp nền mờ Backdrop */}
          <div 
            className="fixed inset-0 bg-black/50 backdrop-blur-xs transition-opacity animate-in fade-in duration-200"
            onClick={closeMenu}
          />

          {/* Khung Drawer trượt từ cạnh phải sang */}
          <div className="relative w-full max-w-sm bg-[#FAF7F2] dark:bg-[#182238] border-l-2 border-[#182238] dark:border-[#384869] h-full flex flex-col shadow-2xl z-10 animate-in slide-in-from-right duration-200 overflow-hidden font-serif">
            {/* 1. Header của Drawer */}
            <div className="p-4 sm:p-5 border-b-2 border-[#182238]/15 dark:border-white/10 flex items-center justify-between bg-white dark:bg-[#141A23]">
              <BrandLogo variant="horizontal" size="xs" showSubtitle={false} />
              <button
                type="button"
                onClick={closeMenu}
                className="w-10 h-10 rounded-full border-2 border-[#182238] dark:border-[#384869] flex items-center justify-center text-title hover:bg-black/5 active:translate-y-0.5 cursor-pointer touch-manipulation"
                aria-label="Đóng menu"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* 2. Thẻ tóm tắt người dùng ở đỉnh */}
            <div className="p-4 bg-gradient-to-r from-white to-[#FFF9F3] dark:from-[#182238] dark:to-[#1F2C47] border-b border-[#182238]/10 dark:border-white/10">
              {currentUser ? (
                <div className="flex items-center gap-3">
                  <div className="w-11 h-11 rounded-2xl bg-[#182238] text-white flex items-center justify-center text-base font-bold border-2 border-[#182238] shadow-xs">
                    {(profile?.display_name || currentUser.email)?.[0]?.toUpperCase() || 'U'}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-bold text-title truncate">
                      {profile?.display_name || currentUser.email?.split('@')[0]}
                    </p>
                    <p className="text-[11px] text-muted truncate">{currentUser.email}</p>
                    {isAdmin && (
                      <span className="inline-block mt-1 px-2 py-0.2 bg-amber-500/15 border border-amber-500/30 text-amber-800 dark:text-amber-300 text-[9px] font-sans font-bold rounded-full">
                        Quản trị viên (Admin)
                      </span>
                    )}
                  </div>
                </div>
              ) : (
                <div className="space-y-2">
                  <p className="text-xs text-muted leading-relaxed">
                    Đăng nhập để lưu tiến độ học tập, điểm bài gõ và đồng bộ thuật toán ôn tập SM-2.
                  </p>
                  <button
                    type="button"
                    onClick={() => {
                      closeMenu()
                      openLoginForm()
                    }}
                    className="w-full py-2.5 rounded-xl bg-[#B8322D] hover:bg-[#9E2A25] text-white text-xs font-bold shadow-[0_2px_0_#7A1D1A] transition-all cursor-pointer"
                  >
                    Đăng nhập tài khoản
                  </button>
                </div>
              )}
            </div>

            {/* 3. Danh sách điều hướng phân nhóm cuộn mượt */}
            <div className="flex-1 overflow-y-auto p-4 space-y-6 no-scrollbar pb-24">
              {mobileNavGroups.map((group) => (
                <div key={group.groupTitle} className="space-y-2">
                  <p className="text-[11px] font-sans font-bold uppercase tracking-wider text-muted px-2">
                    {group.groupTitle}
                  </p>
                  <div className="space-y-1">
                    {group.items.map((item) => {
                      const Icon = item.icon
                      const isActive = item.href === '/' ? pathname === '/' : pathname.startsWith(item.href)
                      return (
                        <Link
                          key={item.href}
                          href={item.href}
                          onClick={closeMenu}
                          className={`flex items-center justify-between p-3 rounded-2xl border-2 transition-all cursor-pointer ${
                            isActive
                              ? 'bg-[#B8322D]/10 border-[#B8322D] text-[#B8322D] font-bold shadow-[0_2px_0_#B8322D]'
                              : 'bg-white dark:bg-[#1E2530] border-[#182238]/15 dark:border-white/10 text-title hover:border-[#182238] shadow-[0_2px_0_#182238]/5'
                          }`}
                        >
                          <div className="flex items-center gap-3">
                            <span className={`p-2 rounded-xl border ${
                              isActive
                                ? 'bg-[#B8322D] text-white border-[#B8322D]'
                                : 'bg-[#FAF7F2] dark:bg-[#182238] text-title border-[#182238]/20'
                            }`}>
                              <Icon className="w-4 h-4" />
                            </span>
                            <div>
                              <div className="flex items-center gap-2">
                                <span className="text-xs font-bold">{item.label}</span>
                                {item.badge && (
                                  <span className="text-[9px] font-sans px-1.5 py-0.2 rounded-full bg-[#B8322D]/15 text-[#B8322D] font-bold">
                                    {item.badge}
                                  </span>
                                )}
                              </div>
                              <p className="text-[10px] text-muted line-clamp-1">{item.desc}</p>
                            </div>
                          </div>
                          <ChevronRight className={`w-4 h-4 ${isActive ? 'text-[#B8322D]' : 'text-muted'}`} />
                        </Link>
                      )
                    })}
                  </div>
                </div>
              ))}
            </div>

            {/* 4. Chân Drawer: Đăng xuất an toàn */}
            {currentUser && (
              <div className="p-4 border-t-2 border-[#182238]/15 dark:border-white/10 bg-white dark:bg-[#141A23]">
                <form action={logout}>
                  <button
                    type="submit"
                    className="w-full py-2.5 px-4 rounded-xl border-2 border-red-500/30 bg-red-50 hover:bg-red-100 text-red-600 text-xs font-bold flex items-center justify-center gap-2 cursor-pointer transition-colors"
                  >
                    <LogOut className="w-4 h-4" />
                    <span>Đăng xuất tài khoản</span>
                  </button>
                </form>
              </div>
            )}
          </div>
        </div>
      )}
    </>
  )
}
