import { ReactNode, Suspense } from 'react'
import Link from 'next/link'
import { LogOut, ShieldCheck } from 'lucide-react'
import { MobileHeader, MobileNav, MobileNavProvider } from '@/components/dashboard/mobile-nav'
import { UserNav } from '@/components/dashboard/user-nav'
import { logout } from '@/app/auth/actions'
import { SidebarNav } from '@/components/dashboard/sidebar-nav'
import { checkIsAdmin } from '@/app/actions/feedback'
import { AuthModalProvider } from '@/components/auth/auth-modal-context'
import { AuthModal } from '@/components/auth/auth-modal'
import { SidebarAuthButton } from '@/components/dashboard/sidebar-auth-button'
import { BrandLogo } from '@/components/ui/brand-logo'
import { getCachedAllVocabCounts } from '@/lib/curriculum-cache'
import { AdminNotificationBell } from '@/components/dashboard/admin-notification-bell'
import { AdminNotificationProvider } from '@/components/dashboard/admin-notification-context'
import { SiteFooter } from '@/components/layout/site-footer'

export default async function DashboardLayout({ children }: { children: ReactNode }) {
  const [{ isAdmin, user, profile }, vocabCountsRes] = await Promise.all([
    checkIsAdmin(),
    getCachedAllVocabCounts(),
  ])

  return (
    <AuthModalProvider initialUser={user}>
      <AdminNotificationProvider adminId={isAdmin ? user?.id : null}>
        <MobileNavProvider>
          <div className="min-h-screen bg-page text-title font-sans flex relative overflow-x-clip">
        {/* Notebook Background Pattern - Self-hosted for 0ms network latency */}
        <div className="fixed inset-0 bg-[url('/patterns/notebook-dark.png')] opacity-10 pointer-events-none mix-blend-multiply z-0" />
        
        {/* Desktop Sidebar - Cố định hoàn toàn (Fixed Sidebar) */}
        <aside className="w-[272px] border-r border-border/60 bg-page/95 backdrop-blur-md z-30 flex-col hidden md:flex fixed top-0 left-0 bottom-0 h-screen select-none">
          {/* Header Logo - Cố định ở đầu */}
          <div className="px-5 py-3.5 border-b border-border/50 flex-shrink-0">
            <BrandLogo variant="horizontal" size="md" />
          </div>
          
          {/* Dynamic Sidebar Navigation */}
          <Suspense
            fallback={
              <div className="flex-1 overflow-y-auto py-3 px-3 space-y-5 no-scrollbar">
                <div className="space-y-1">
                  <div className="h-8 bg-black/5 rounded-lg animate-pulse" />
                  <div className="h-8 bg-black/5 rounded-lg animate-pulse" />
                  <div className="h-8 bg-black/5 rounded-lg animate-pulse" />
                  <div className="h-8 bg-black/5 rounded-lg animate-pulse" />
                </div>
              </div>
            }
          >
            <SidebarNav 
              isLoggedIn={!!user} 
              isAdmin={isAdmin} 
              initialVocabCounts={vocabCountsRes.counts} 
            />
          </Suspense>

          {/* Footer Đăng nhập / Đăng xuất - Cố định ở đáy Sidebar */}
          <div className="p-3 border-t border-border/50 flex-shrink-0 bg-page/95 space-y-1">
            {user ? (
              <>
                <Link 
                  href="/profile" 
                  className="w-full flex items-center gap-2.5 px-3 py-2 text-title hover:text-app-accent hover:bg-black/5 transition-colors rounded-xl group"
                  title="Xem thông tin cá nhân"
                >
                  <div className="w-7 h-7 rounded-full bg-[#23272F] text-white flex items-center justify-center font-bold text-xs flex-shrink-0 shadow-2xs">
                    {(profile?.display_name || user.email)?.[0]?.toUpperCase() || 'U'}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-1.5">
                      <p className="text-xs font-serif font-bold text-title truncate group-hover:text-app-accent leading-tight">
                        {profile?.display_name || user.email?.split('@')[0]}
                      </p>
                      {isAdmin && (
                        <span className="bg-app-accent text-white text-[9px] font-sans font-bold uppercase px-1 py-0.2 rounded flex-shrink-0">
                          Admin
                        </span>
                      )}
                    </div>
                    <p className="text-[10px] text-muted font-sans truncate leading-none mt-0.5">
                      {isAdmin ? 'Quản trị viên' : 'Hồ sơ & Tiến độ'}
                    </p>
                  </div>
                </Link>
                <form action={logout}>
                  <button className="w-full flex items-center justify-between px-3 py-1.5 text-xs text-muted hover:text-red-600 hover:bg-red-500/5 transition-colors rounded-lg group text-left cursor-pointer">
                    <span>Đăng xuất</span>
                    <LogOut className="h-3.5 w-3.5 text-muted group-hover:text-red-600 flex-shrink-0 transition-transform group-hover:translate-x-0.5" />
                  </button>
                </form>
              </>
            ) : (
              <SidebarAuthButton />
            )}
          </div>
        </aside>

        {/* Main Content Area - Cách lề md:ml-[272px] để vừa vặn với Fixed Sidebar */}
        <div className="flex-1 md:ml-[272px] flex flex-col min-h-screen min-w-0 z-10">
          {/* Mobile Header */}
          <MobileHeader 
            isLoggedIn={!!user} 
            isAdmin={isAdmin} 
            adminId={user?.id}
            user={user}
            profile={profile}
          />

          {/* Desktop Header - Cố định ở đầu trang (Fixed Header), đồng bộ với fixed sidebar */}
          <header className="hidden md:flex h-14 border-b border-border/60 bg-page/85 backdrop-blur-md items-center justify-between px-6 sm:px-8 fixed top-0 right-0 left-0 md:left-[272px] z-20">
            {/* Nhãn văn hóa Đông Phương tinh tế thay thế khoảng trống tìm kiếm */}
            <div className="flex items-center gap-2 select-none">
              <span className="w-1.5 h-1.5 rounded-full bg-app-accent/80" />
              <span className="text-xs font-serif text-muted tracking-wide">
                Nền tảng học Hán ngữ & Luyện thi HSK
              </span>
            </div>

            {/* Cụm nút hành động chuẩn hóa chiều cao, font và bo góc */}
            <div className="flex items-center gap-2.5">
              {isAdmin && (
                <>
                  <AdminNotificationBell adminId={user!.id} />
                  <Link 
                    href="/admin" 
                    className="h-9 px-3.5 rounded-xl border border-app-accent/30 bg-app-accent-soft text-app-accent hover:bg-app-accent hover:text-white transition-all text-xs font-serif font-medium flex items-center gap-1.5 shadow-2xs select-none"
                    title="Trung tâm Quản trị & Phân quyền"
                  >
                    <ShieldCheck className="h-4 w-4" />
                    <span>Quản trị</span>
                  </Link>
                </>
              )}
              <UserNav 
                user={user} 
                displayName={profile?.display_name || undefined} 
                avatarUrl={profile?.avatar_url} 
                isAdmin={isAdmin}
              />
            </div>
          </header>

          {/* Spacer bù đắp chiều cao h-14 (56px) cho Fixed Header trên Desktop & Mobile */}
          <div className="h-14 flex-shrink-0" aria-hidden="true" />

          {/* Page Content */}
          <main className="flex-1 p-3.5 sm:p-6 md:p-8 lg:p-10 min-w-0 pb-3 md:pb-8">
            {children}
          </main>

          {/* Footer Bản quyền & Ghi nhận tác giả */}
          <SiteFooter />
        </div>
        
        {/* Mobile Bottom Navigation & Drawer */}
        <MobileNav 
          isLoggedIn={!!user} 
          isAdmin={isAdmin}
          user={user}
          profile={profile}
          initialVocabCounts={vocabCountsRes.counts}
        />

        {/* Global Authentication Modal (Luồng 1 & Luồng 2) */}
        <AuthModal />
      </div>
      </MobileNavProvider>
      </AdminNotificationProvider>
    </AuthModalProvider>
  )
}