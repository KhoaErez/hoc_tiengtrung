'use client'

import Link from 'next/link'
import { usePathname, useSearchParams } from 'next/navigation'
import { Home, BookOpen, Component, Keyboard, BrainCircuit } from 'lucide-react'
import { ProtectedLink } from '@/components/protected-link'

interface SidebarNavProps {
  isLoggedIn: boolean
}

export function SidebarNav({ isLoggedIn }: SidebarNavProps) {
  const pathname = usePathname() || '/'
  const searchParams = useSearchParams()
  const qParam = searchParams?.get('q')

  // Main menu items definition (Without 'Viết')
  const mainNavItems = [
    {
      label: 'Trang chủ',
      href: '/',
      icon: Home,
      isProtected: false,
      isActive: pathname === '/',
    },
    {
      label: 'Chủ đề sưu tầm',
      href: '/lessons',
      icon: BookOpen,
      isProtected: false,
      isActive: pathname === '/lessons' || pathname.startsWith('/lessons/'),
    },
    {
      label: 'Bộ thủ',
      href: '/radicals',
      icon: Component,
      isProtected: false,
      isActive: pathname === '/radicals' || pathname.startsWith('/radicals/'),
    },
    {
      label: 'Luyện đánh máy',
      href: '/typing',
      icon: Keyboard,
      isProtected: false,
      isActive: pathname === '/typing' || pathname.startsWith('/typing/'),
    },
    {
      label: 'Ôn tập',
      href: '/review',
      icon: BrainCircuit,
      isProtected: true,
      isActive: pathname === '/review' || pathname.startsWith('/review/'),
    },
  ]

  // Topics and HSK items
  const topicList = [
    'HSK 1',
    'HSK 2',
    'HSK 3',
    'HSK 4',
    'HSK 5',
    'HSK 6',
    'Giao tiếp',
    'Công xưởng',
  ]

  // Check if a topic item is active
  const isTopicActive = (topic: string) => {
    if (topic.startsWith('HSK ')) {
      const level = topic.replace('HSK ', '').trim()
      // Active if on /hsk/[level] or /hsk/[level]/...
      if (pathname === `/hsk/${level}` || pathname.startsWith(`/hsk/${level}/`)) {
        return true
      }
      // Active if on /topics with ?q=HSK [level]
      if (pathname === '/topics') {
        if (qParam === topic) return true
        // Default on /topics is HSK 1 if no q param specified
        if (!qParam && topic === 'HSK 1') return true
      }
      return false
    }

    // For other topics like 'Giao tiếp', 'Công xưởng'
    if (pathname === '/topics') {
      return qParam === topic
    }

    return false
  }

  return (
    <div className="flex-1 overflow-y-auto py-4 px-3 space-y-6 no-scrollbar">
      {/* 1. Main Navigation */}
      <nav className="space-y-1" aria-label="Menu chính">
        {mainNavItems.map((item) => {
          const Icon = item.icon
          const active = item.isActive

          const linkClassName = `flex items-center gap-3 px-3 py-2 text-sm rounded-md border-l-4 transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none ${
            active
              ? 'border-app-accent bg-app-accent-soft text-app-accent font-medium shadow-2xs'
              : 'border-transparent text-muted hover:bg-black/5 hover:text-title'
          }`

          if (item.isProtected) {
            return (
              <ProtectedLink
                key={item.href}
                href={item.href}
                isLoggedIn={isLoggedIn}
                className={linkClassName}
              >
                <Icon className={`h-4 w-4 transition-colors ${active ? 'text-app-accent' : 'text-muted'}`} />
                <span>{item.label}</span>
              </ProtectedLink>
            )
          }

          return (
            <Link
              key={item.href}
              href={item.href}
              className={linkClassName}
            >
              <Icon className={`h-4 w-4 transition-colors ${active ? 'text-app-accent' : 'text-muted'}`} />
              <span>{item.label}</span>
            </Link>
          )
        })}
      </nav>

      {/* 2. Topic Navigation (HSK 1 - 6 & Chủ đề) */}
      <div className="px-2">
        <h3 className="px-3 text-xs font-semibold text-muted uppercase tracking-wider mb-2">
          Chủ đề
        </h3>
        <nav className="space-y-0.5" aria-label="Danh sách chủ đề và HSK">
          {topicList.map((topic) => {
            const active = isTopicActive(topic)
            return (
              <Link
                key={topic}
                href={`/topics?q=${encodeURIComponent(topic)}`}
                className={`flex items-center px-3 py-1.5 text-sm rounded-md border-l-4 transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none ${
                  active
                    ? 'border-app-accent bg-app-accent-soft text-app-accent font-medium shadow-2xs'
                    : 'border-transparent text-body hover:text-app-accent hover:bg-black/5'
                }`}
              >
                <span
                  className={`w-1.5 h-1.5 rounded-full mr-3 transition-colors ${
                    active ? 'bg-app-accent' : 'bg-border-strong'
                  }`}
                />
                <span>{topic}</span>
              </Link>
            )
          })}
        </nav>
      </div>
    </div>
  )
}
