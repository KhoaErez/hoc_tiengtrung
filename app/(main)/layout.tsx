import { ReactNode } from 'react'
import Link from 'next/link'
import { BookOpen, PenTool, BrainCircuit, Search, PlusCircle, LogOut, Home, LogIn } from 'lucide-react'
import { MobileHeader, MobileNav } from '@/components/dashboard/mobile-nav'
import { logout } from '@/app/auth/actions'
import { createClient } from '@/lib/supabase/server'
import { ProtectedLink } from '@/components/protected-link'

export default async function DashboardLayout({ children }: { children: ReactNode }) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  return (
    <div className="min-h-screen bg-page text-title font-serif flex relative overflow-hidden">
      {/* Notebook Background Pattern */}
      <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/notebook-dark.png')] opacity-10 pointer-events-none mix-blend-multiply" />
      
      {/* Desktop Sidebar */}
      <aside className="w-64 border-r border-border bg-page/90 backdrop-blur z-10 flex flex-col hidden md:flex h-screen sticky top-0">
        <div className="p-6 border-b border-border">
          <Link href="/" className="flex items-center gap-2">
            <BookOpen className="h-6 w-6 text-app-accent" />
            <span className="font-bold text-xl text-app-accent tracking-wide">漢字</span>
          </Link>
          <p className="text-xs text-muted mt-1 uppercase tracking-widest">Chinese Notebook</p>
        </div>
        
        <div className="flex-1 overflow-y-auto py-6">
          <nav className="space-y-1 px-4">
            <Link href="/" className="flex items-center gap-3 px-3 py-2 bg-app-accent-soft text-app-accent rounded-md border-l-4 border-app-accent">
              <Home className="h-4 w-4" />
              <span className="font-medium">Trang chủ </span>
            </Link>
            <Link href="/lessons" className="flex items-center gap-3 px-3 py-2 text-muted hover:bg-[#F3EEE6] hover:text-title rounded-md transition-colors">
              <BookOpen className="h-4 w-4" />
              <span>Chủ đề sưu tầm</span>
            </Link>
            <ProtectedLink href="/write" isLoggedIn={!!user} className="flex items-center gap-3 px-3 py-2 text-muted hover:bg-[#F3EEE6] hover:text-title rounded-md transition-colors">
              <PenTool className="h-4 w-4" />
              <span>Viết</span>
            </ProtectedLink>
            <ProtectedLink href="/review" isLoggedIn={!!user} className="flex items-center gap-3 px-3 py-2 text-muted hover:bg-[#F3EEE6] hover:text-title rounded-md transition-colors">
              <BrainCircuit className="h-4 w-4" />
              <span>Ôn tập</span>
            </ProtectedLink>
          </nav>
          
          <div className="mt-8 px-4">
            <h3 className="px-3 text-xs font-semibold text-muted uppercase tracking-wider mb-2">Chủ đề</h3>
            <nav className="space-y-1">
              {['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6', 'Giao tiếp', 'Công xưởng'].map((topic) => (
                <Link key={topic} href={"/topics?q=" + topic} className="flex items-center px-3 py-1.5 text-sm text-body hover:text-app-accent transition-colors">
                  <span className="w-1.5 h-1.5 rounded-full bg-border-strong mr-3"></span>
                  {topic}
                </Link>
              ))}
            </nav>
          </div>
        </div>
        
        <div className="p-4 border-t border-border">
          {user ? (
            <form action={logout}>
              <button className="w-full flex items-center gap-3 px-3 py-2 text-muted hover:text-app-accent transition-colors">
                <LogOut className="h-4 w-4" />
                <span className="text-sm font-medium">Đăng xuất</span>
              </button>
            </form>
          ) : (
            <Link href="/login" className="w-full flex items-center gap-3 px-3 py-2 text-muted hover:text-app-accent transition-colors">
              <LogIn className="h-4 w-4" />
              <span className="text-sm font-medium">Đăng nhập</span>
            </Link>
          )}
        </div>
      </aside>

      {/* Main Content */}
      <main className="flex-1 flex flex-col min-h-screen h-full z-10 md:pb-0 pb-16 min-w-0">
        
        {/* Mobile Header */}
        <MobileHeader />

        {/* Desktop Header */}
        <header className="hidden md:flex h-16 border-b border-border bg-page/80 backdrop-blur items-center justify-between px-6 sticky top-0 z-20">
          <div className="flex items-center w-full max-w-md bg-transparent border-b-2 border-border-strong focus-within:border-app-accent transition-colors pb-1">
            <Search className="h-4 w-4 text-muted mr-2" />
            <input 
              type="text" 
              placeholder="Tìm kiếm từ vựng, bài học..." 
              className="bg-transparent border-none outline-none w-full text-body placeholder:text-muted text-sm font-serif h-8"
            />
          </div>
          <Link href="/lessons/create" className="flex items-center gap-2 bg-title hover:bg-[#2A3250] text-white px-4 py-2 rounded-md text-sm transition-colors shadow-sm">
            <PlusCircle className="h-4 w-4" />
            <span>Tạo bài học</span>
          </Link>
        </header>

        {/* Page Content */}
        <div className="flex-1 p-4 md:p-10 overflow-y-auto overflow-x-hidden">
          {children}
        </div>
      </main>
      
      {/* Mobile Bottom Navigation */}
      <MobileNav isLoggedIn={!!user} />
    </div>
  )
}