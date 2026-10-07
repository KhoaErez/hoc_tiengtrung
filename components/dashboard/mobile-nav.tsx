'use client'

import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { Home, BookOpen, PenTool, BrainCircuit, ChevronLeft, LogOut, GraduationCap } from 'lucide-react'
import { logout } from '@/app/auth/actions'
import { ProtectedLink } from '@/components/protected-link'

export function MobileHeader() {
  const router = useRouter()
  const pathname = usePathname()
  
  // Don't show back button on main dashboard
  const isHome = pathname === '/'

  return (
    <header className="md:hidden h-16 border-b border-border bg-page/90 backdrop-blur-xl flex items-center justify-between px-4 sticky top-0 z-30 shadow-sm">
      <div className="flex items-center">
        {!isHome && (
          <button 
            onClick={() => router.back()} 
            className="mr-3 p-2 -ml-2 rounded-full hover:bg-border active:bg-border-strong transition-colors text-muted"
          >
            <ChevronLeft className="h-5 w-5" />
          </button>
        )}
        <div className="flex items-center gap-2">
          <BookOpen className="h-5 w-5 text-app-accent" />
          <span className="font-bold text-lg text-app-accent tracking-wide">漢字</span>
        </div>
      </div>
      
      <form action={logout}>
        <button 
          type="submit"
          className="p-2 -mr-2 rounded-full hover:bg-accent-soft transition-colors text-muted hover:text-app-accent"
          title="Đăng xuất"
        >
          <LogOut className="h-5 w-5" />
        </button>
      </form>
    </header>
  )
}

export function MobileNav({ isLoggedIn }: { isLoggedIn: boolean }) {
  const pathname = usePathname()
  
  const navItems = [
    { href: '/', icon: Home, label: 'Trang chủ' },
    { href: '/topics', icon: GraduationCap, label: 'HSK' },
    { href: '/lessons', icon: BookOpen, label: 'Sưu tầm' },
    { href: '/write', icon: PenTool, label: 'Viết' },
    { href: '/review', icon: BrainCircuit, label: 'Ôn tập' },
  ]

  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 h-16 bg-page/95 backdrop-blur-xl border-t border-border z-30 pb-safe shadow-[0_-4px_20px_rgba(0,0,0,0.02)]">
      <div className="flex items-center justify-around h-full px-2">
        {navItems.map((item) => {
          const isActive = pathname === item.href || pathname.startsWith(item.href + '/')
          if (item.href === '/write' || item.href === '/review') {
            return (
              <ProtectedLink
                key={item.href}
                href={item.href}
                isLoggedIn={isLoggedIn}
                className={`flex flex-col items-center justify-center w-full h-full space-y-1 transition-all ${
                  isActive ? 'text-app-accent' : 'text-muted hover:text-title'
                }`}
              >
                <div className={`relative p-1 rounded-xl transition-all duration-300 ${isActive ? 'bg-accent-soft' : 'bg-transparent'}`}>
                  <item.icon className={`h-6 w-6 transition-all duration-300 ${isActive ? 'scale-110' : 'scale-100'}`} />
                  {isActive && (
                    <span className="absolute -bottom-1 left-1/2 -translate-x-1/2 w-1 h-1 bg-app-accent rounded-full" />
                  )}
                </div>
                <span className={`text-[10px] font-serif transition-all duration-300 ${isActive ? 'font-medium' : 'font-normal'}`}>
                  {item.label}
                </span>
              </ProtectedLink>
            )
          }

          return (
            <Link 
              key={item.href} 
              href={item.href}
              className={`flex flex-col items-center justify-center w-16 h-full gap-1 transition-all duration-200 ${
                isActive ? 'text-app-accent' : 'text-muted hover:text-title'
              }`}
            >
              <div className={`p-1.5 rounded-full transition-all duration-300 ${
                isActive ? 'bg-accent-soft' : 'bg-transparent'
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
