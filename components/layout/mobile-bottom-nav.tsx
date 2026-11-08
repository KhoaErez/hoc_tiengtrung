'use client'

import React from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { 
  BookOpen, 
  GraduationCap, 
  Keyboard, 
  Layers, 
  Grid2X2 
} from 'lucide-react'
import { useMobileNav } from './mobile-nav-context'

interface NavTabItem {
  id: string
  label: string
  href: string
  icon: React.ComponentType<{ className?: string }>
  badge?: string
  isAction?: boolean
}

const BOTTOM_TABS: NavTabItem[] = [
  {
    id: 'home',
    label: 'Trang chủ',
    href: '/',
    icon: BookOpen,
  },
  {
    id: 'hsk',
    label: 'Lộ trình HSK',
    href: '/topics',
    icon: GraduationCap,
    badge: '1–9',
  },
  {
    id: 'typing',
    label: 'Luyện gõ',
    href: '/typing',
    icon: Keyboard,
  },
  {
    id: 'review',
    label: 'Ôn tập SM-2',
    href: '/review',
    icon: Layers,
  },
  {
    id: 'more',
    label: 'Chức năng',
    href: '#menu',
    icon: Grid2X2,
    isAction: true,
  },
]

export function MobileBottomNav() {
  const pathname = usePathname()
  const { isMenuOpen, toggleMenu } = useMobileNav()

  return (
    <nav
      aria-label="Thanh điều hướng nhanh phía dưới"
      className="fixed bottom-0 left-0 right-0 z-40 lg:hidden bg-[#FAF7F2]/95 dark:bg-[#182238]/95 backdrop-blur-xl border-t-2 border-[#182238] dark:border-[#384869] shadow-[0_-4px_16px_rgba(24,34,56,0.08)] px-2 pt-1.5 pb-[max(0.5rem,env(safe-area-inset-bottom,0px))] transition-transform duration-200"
    >
      <div className="flex items-center justify-around max-w-lg mx-auto">
        {BOTTOM_TABS.map((tab) => {
          const Icon = tab.icon
          const isActive = tab.isAction
            ? isMenuOpen
            : tab.href === '/'
            ? pathname === '/'
            : pathname.startsWith(tab.href)

          if (tab.isAction) {
            return (
              <button
                key={tab.id}
                type="button"
                onClick={toggleMenu}
                className={`flex flex-col items-center justify-center min-w-[56px] min-h-[44px] py-1 px-1.5 rounded-2xl transition-all cursor-pointer ${
                  isActive
                    ? 'text-[#B8322D] bg-[#B8322D]/10 font-bold'
                    : 'text-[#182238]/80 dark:text-slate-300 hover:text-[#B8322D] font-medium'
                }`}
                aria-label="Mở danh mục chức năng đầy đủ"
                aria-expanded={isMenuOpen}
              >
                <div className="relative">
                  <Icon className="w-5 h-5 transition-transform active:scale-90" />
                  <span className="w-1.5 h-1.5 rounded-full bg-[#B8322D] absolute -top-0.5 -right-0.5 animate-pulse" />
                </div>
                <span className="text-[10px] font-serif tracking-tight mt-0.5">
                  {tab.label}
                </span>
              </button>
            )
          }

          return (
            <Link
              key={tab.id}
              href={tab.href}
              className={`flex flex-col items-center justify-center min-w-[56px] min-h-[44px] py-1 px-1.5 rounded-2xl transition-all cursor-pointer ${
                isActive
                  ? 'text-[#B8322D] bg-[#B8322D]/10 font-bold'
                  : 'text-[#182238]/80 dark:text-slate-300 hover:text-[#B8322D] font-medium'
              }`}
            >
              <div className="relative">
                <Icon className="w-5 h-5 transition-transform active:scale-90" />
                {tab.badge && (
                  <span className="absolute -top-1 -right-2 px-1 py-0.2 bg-[#B8322D] text-white text-[8px] font-sans font-bold rounded-full">
                    {tab.badge}
                  </span>
                )}
              </div>
              <span className="text-[10px] font-serif tracking-tight mt-0.5">
                {tab.label}
              </span>
            </Link>
          )
        })}
      </div>
    </nav>
  )
}

