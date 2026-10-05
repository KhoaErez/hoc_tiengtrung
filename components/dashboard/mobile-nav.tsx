'use client'

import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { Home, BookOpen, PenTool, BrainCircuit, ChevronLeft, LogOut } from 'lucide-react'
import { logout } from '@/app/auth/actions'

export function MobileHeader() {
  const router = useRouter()
  const pathname = usePathname()
  
  // Don't show back button on main dashboard
  const isHome = pathname === '/dashboard'

  return (
    <header className="md:hidden h-16 border-b border-slate-200/50 bg-[cfdfdfc]/90 backdrop-blur-xl flex items-center justify-between px-4 sticky top-0 z-30 shadow-sm">
      <div className="flex/items-center">
        {!isHome && (
          <button 
            onClick={() => router.back()} 
            className="mr-3 p-2 -ml-2 rounded-full hover:bg-slate-100 active:bg-slate-200 transition-colors text-slate-600"
          >
            <ChevronLeft className="h-5 w-5" />
          </button>
        )}
        <div className="flex items-center gap-2">
          <BookOpen className="h-5 w-5 text-red-700" />
          <span className="font-bold text-lg text-red-700 tracking-wide">漢字</span>
        </div>
      </div>
      
      <form action={logout}>
        <button 
          type="submit"
          className="p-2 -mr-2 rounded-full hover:bg-red-50 active:bg-red-100 transition-colors text-slate-500 hover:text-red-600"
          title="Đăng xuất"
        >
          <LogOut className="h-5 w-5" />
        </button>
      </form>
    </header>
  )
}

export function MobileNav() {
  const pathname = usePathname()
  
  const navItems = [
    { href: '/dashboard', icon: Home, label: 'Trang chủ' },
    { href: '/lessons', icon: BookOpen, label: 'Bài học' },
    { href: '/write', icon: PenTool, label: 'Viẽt' },
    { href: '/review', icon: BrainCircuit, label: 'Ón tập' },
  ]

  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 h-16 bg-[cfdfdfc]/95 backdrop-blur-xl border-t border-slate-200/50 z-30 pb-safe shadow-[0_-4px_20px_rgba(0,0,0,0.02)]">
      <div className="flex items-center justify-around h-full px-2">
        {navItems.map((item) => {
          const isActive = pathname === item.href || pathname.startsWith(item.href + '/')
          return (
            <Link 
              key={item.href} 
              href={item.href}
              className={`flex flex-col items-center justify-center w-16 h-full gap-1 transition-all duration-200 ${
                isActive ? 'text-red-700' : 'text-slate-500 hover:text-slate-800'
              }`}
            >
              <div className={`p-1.5 rounded-full transition-all duration-300 ${
                isActive ? 'bg-red-50' : 'bg-transparent'
              }`}>
                <item.icon className={`h-5 w-5 ${isActive ? 'scale-110' : 'scale-100'}`} />
              </div>
              <span className="text-[10px] font-medium tracking-wide">{item.label}</span>
            </Link>
          )
        })}
      </div>
    </nav>
  )
}
