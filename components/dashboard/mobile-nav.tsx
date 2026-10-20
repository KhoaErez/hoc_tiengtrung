'use client'

import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { Home, BookOpen, BrainCircuit, ChevronLeft, LogOut, GraduationCap, Component, Keyboard } from 'lucide-react'
import { logout } from '@/app/auth/actions'
import { ProtectedLink } from '@/components/protected-link'

import { useAuthModal } from '@/components/auth/auth-modal-context'
import { LogIn } from 'lucide-react'

export function MobileHeader({ isLoggedIn }: { isLoggedIn?: boolean }) {
  const router = useRouter()
  const pathname = usePathname()
  const { isLoggedIn: contextLoggedIn, openLoginForm } = useAuthModal()
  const authenticated = typeof isLoggedIn === 'boolean' ? isLoggedIn : contextLoggedIn
  
  // Don't show back button on main dashboard
  const isHome = pathname === '/'

  return (
    <header className="md:hidden h-16 border-b border-border bg-page/90 backdrop-blur-xl flex items-center justify-between px-4 sticky top-0 z-30 shadow-sm">
      <div className="flex items-center">
        {!isHome && (
          <button 
            onClick={() => router.back()} 
            className="mr-3 p-2 -ml-2 rounded-full hover:bg-border active:bg-border-strong transition-colors text-muted cursor-pointer"
          >
            <ChevronLeft className="h-5 w-5" />
          </button>
        )}
        <div className="flex items-center gap-2">
          <BookOpen className="h-5 w-5 text-app-accent" />
          <span className="font-bold text-lg text-app-accent tracking-wide">漢字</span>
        </div>
      </div>
      
      {authenticated ? (
        <form action={logout}>
          <button 
            type="submit"
            className="p-2 -mr-2 rounded-full hover:bg-accent-soft transition-colors text-muted hover:text-app-accent cursor-pointer"
            title="Đăng xuất"
          >
            <LogOut className="h-5 w-5" />
          </button>
        </form>
      ) : (
        <button
          type="button"
          onClick={() => openLoginForm()}
          className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-serif text-title hover:text-app-accent hover:bg-page transition-colors cursor-pointer"
        >
          <LogIn className="h-4 w-4 text-muted" />
          <span>Đăng nhập</span>
        </button>
      )}
    </header>
  )
}

export function MobileNav({ isLoggedIn }: { isLoggedIn: boolean }) {
  const pathname = usePathname() || '/'
  
  const navItems = [
    { href: '/', icon: Home, label: 'Trang chủ' },
    { href: '/topics', icon: GraduationCap, label: 'HSK' },
    { href: '/lessons', icon: BookOpen, label: 'Sưu tầm' },
    { href: '/radicals', icon: Component, label: 'Bộ thủ' },
    { href: '/typing', icon: Keyboard, label: 'Luyện gõ' },
    { href: '/review', icon: BrainCircuit, label: 'Ôn tập' },
  ]

  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-page/95 backdrop-blur-xl border-t border-border z-50 shadow-[0_-4px_20px_rgba(0,0,0,0.02)] box-border" style={{ paddingBottom: 'env(safe-area-inset-bottom)' }}>
      <div className="grid grid-cols-6 h-[60px] items-center px-0.5">
        {navItems.map((item) => {
          const isActive =
            item.href === '/'
              ? pathname === '/'
              : item.href === '/topics'
              ? pathname === '/topics' || pathname.startsWith('/topics/') || pathname.startsWith('/hsk')
              : pathname === item.href || pathname.startsWith(item.href + '/')
          
          const content = (
            <>
              <div className={`relative p-1.5 rounded-full transition-all duration-300 ${isActive ? 'bg-accent-soft' : 'bg-transparent'}`}>
                <item.icon className={`h-5 w-5 transition-all duration-300 ${isActive ? 'scale-110' : 'scale-100'}`} />
                {isActive && (
                  <span className="absolute -bottom-1 left-1/2 -translate-x-1/2 w-1 h-1 bg-app-accent rounded-full" />
                )}
              </div>
              <span className={`text-[10px] tracking-wide transition-all duration-300 ${isActive ? 'font-medium font-serif' : 'font-normal font-serif'}`}>
                {item.label}
              </span>
            </>
          )

          const containerClasses = `flex flex-col items-center justify-center w-full h-full gap-1 transition-all duration-200 outline-none select-none ${
            isActive ? 'text-app-accent' : 'text-muted hover:text-title'
          }`

          if (item.href === '/review') {
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
            <Link 
              key={item.href} 
              href={item.href}
              className={containerClasses}
            >
              {content}
            </Link>
          )
        })}
      </div>
    </nav>
  )
}
