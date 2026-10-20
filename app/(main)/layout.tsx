import { ReactNode, Suspense } from 'react'
import Link from 'next/link'
import { BookOpen, Search, PlusCircle, LogOut, LogIn } from 'lucide-react'
import { MobileHeader, MobileNav } from '@/components/dashboard/mobile-nav'
import { UserNav } from '@/components/dashboard/user-nav'
import { logout } from '@/app/auth/actions'
import { createClient } from '@/lib/supabase/server'
import { SidebarNav } from '@/components/dashboard/sidebar-nav'

export default async function DashboardLayout({ children }: { children: ReactNode }) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  let profile = null
  if (user) {
    const { data } = await supabase.from('profiles').select('*').eq('id', user.id).maybeSingle()
    profile = data
  }

  return (
    <div className="min-h-screen bg-page text-title font-serif flex relative overflow-x-hidden">
      {/* Notebook Background Pattern */}
      <div className="fixed inset-0 bg-[url('https://www.transparenttextures.com/patterns/notebook-dark.png')] opacity-10 pointer-events-none mix-blend-multiply z-0" />
      
      {/* Desktop Sidebar - Cố định hoàn toàn (Fixed Sidebar) */}
      <aside className="w-64 border-r border-border bg-page/95 backdrop-blur z-30 flex-col hidden md:flex fixed top-0 left-0 bottom-0 h-screen select-none">
        {/* Header Logo - Cố định ở đầu */}
        <div className="p-6 border-b border-border flex-shrink-0">
          <Link href="/" className="flex items-center gap-2">
            <BookOpen className="h-6 w-6 text-app-accent" />
            <span className="font-bold text-xl text-app-accent tracking-wide">漢字</span>
          </Link>
          <p className="text-xs text-muted mt-1 uppercase tracking-widest">Chinese Notebook</p>
        </div>
        
        {/* Dynamic Sidebar Navigation */}
        <Suspense
          fallback={
            <div className="flex-1 overflow-y-auto py-4 px-3 space-y-6 no-scrollbar">
              <div className="space-y-1">
                <div className="h-9 bg-black/5 rounded-md animate-pulse" />
                <div className="h-9 bg-black/5 rounded-md animate-pulse" />
                <div className="h-9 bg-black/5 rounded-md animate-pulse" />
                <div className="h-9 bg-black/5 rounded-md animate-pulse" />
                <div className="h-9 bg-black/5 rounded-md animate-pulse" />
              </div>
            </div>
          }
        >
          <SidebarNav isLoggedIn={!!user} />
        </Suspense>

        {/* Footer Đăng nhập / Đăng xuất - Cố định ở đáy Sidebar */}
        <div className="p-3 border-t border-border flex-shrink-0 bg-page/95 space-y-1">
          {user ? (
            <>
              <Link 
                href="/profile" 
                className="w-full flex items-center gap-2.5 px-3 py-2 text-title hover:text-app-accent hover:bg-black/5 transition-colors rounded-lg group"
                title="Xem thông tin cá nhân"
              >
                <div className="w-7 h-7 rounded-full bg-[#23272F] text-white flex items-center justify-center font-bold text-xs flex-shrink-0 shadow-xs">
                  {(profile?.display_name || user.email)?.[0]?.toUpperCase() || 'U'}
                </div>
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium text-title truncate group-hover:text-app-accent">
                    {profile?.display_name || user.email?.split('@')[0]}
                  </p>
                  <p className="text-[11px] text-muted truncate">Hồ sơ & Tiến độ</p>
                </div>
              </Link>
              <form action={logout}>
                <button className="w-full flex items-center justify-between px-3 py-1.5 text-xs text-muted hover:text-red-600 hover:bg-black/5 transition-colors rounded-lg group text-left">
                  <span>Đăng xuất</span>
                  <LogOut className="h-3.5 w-3.5 text-muted group-hover:text-red-600 flex-shrink-0" />
                </button>
              </form>
            </>
          ) : (
            <Link href="/login" className="w-full flex items-center gap-3 px-3 py-2 text-muted hover:text-app-accent hover:bg-black/5 transition-colors rounded-lg text-sm font-medium">
              <LogIn className="h-4 w-4" />
              <span>Đăng nhập</span>
            </Link>
          )}
        </div>
      </aside>

      {/* Main Content Area - Cách lề md:ml-64 để vừa vặn với Fixed Sidebar */}
      <div className="flex-1 md:ml-64 flex flex-col min-h-screen min-w-0 z-10">
        {/* Mobile Header */}
        <MobileHeader />

        {/* Desktop Header - Cố định trên đầu khi cuộn trang */}
        <header className="hidden md:flex h-16 border-b border-border bg-page/80 backdrop-blur items-center justify-between px-6 sticky top-0 z-20">
          <div className="flex items-center w-full max-w-md bg-transparent border-b-2 border-border-strong focus-within:border-app-accent transition-colors pb-1">
            <Search className="h-4 w-4 text-muted mr-2" />
            <input 
              type="text" 
              placeholder="Tìm kiếm từ vựng, bài học..." 
              className="bg-transparent border-none outline-none w-full text-body placeholder:text-muted text-sm font-serif h-8"
            />
          </div>
          <div className="flex items-center gap-3">
            <Link href="/lessons/create" className="flex items-center gap-2 bg-title hover:bg-[#2A3250] text-white px-4 py-2 rounded-md text-sm transition-colors shadow-sm">
              <PlusCircle className="h-4 w-4" />
              <span>Tạo bài học</span>
            </Link>
            <UserNav user={user} displayName={profile?.display_name} avatarUrl={profile?.avatar_url} />
          </div>
        </header>

        {/* Page Content */}
        <main className="flex-1 p-4 md:p-8 lg:p-10 min-w-0 pb-20 md:pb-12">
          {children}
        </main>
      </div>
      
      {/* Mobile Bottom Navigation */}
      <MobileNav isLoggedIn={!!user} />
    </div>
  )
}