'use client'

import { useState, useRef, useEffect } from 'react'
import Link from 'next/link'
import { User, LogOut, ChevronDown, GraduationCap, Keyboard, Sparkles, LogIn, UserPlus } from 'lucide-react'
import { logout } from '@/app/auth/actions'

interface UserNavProps {
  user: {
    id: string
    email?: string
    user_metadata?: { full_name?: string }
  } | null
  displayName?: string
  avatarUrl?: string | null
}

export function UserNav({ user, displayName, avatarUrl }: UserNavProps) {
  const [isOpen, setIsOpen] = useState(false)
  const menuRef = useRef<HTMLDivElement | null>(null)

  // Đóng menu khi click ra ngoài
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (menuRef.current && !menuRef.current.contains(event.target as Node)) {
        setIsOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  if (!user) {
    return (
      <div className="flex items-center gap-2">
        <Link
          href="/login"
          className="flex items-center gap-1.5 px-3.5 py-1.5 rounded-lg text-xs md:text-sm font-serif text-title hover:text-app-accent hover:bg-page transition-colors"
        >
          <LogIn className="w-4 h-4 text-muted" />
          <span>Đăng nhập</span>
        </Link>
        <Link
          href="/register"
          className="flex items-center gap-1.5 px-3.5 py-1.5 rounded-lg text-xs md:text-sm font-serif bg-title hover:bg-[#2A3250] text-white transition-colors shadow-2xs"
        >
          <UserPlus className="w-4 h-4" />
          <span>Đăng ký</span>
        </Link>
      </div>
    )
  }

  const name = displayName || user.user_metadata?.full_name || user.email?.split('@')[0] || 'Học viên'
  const initial = name[0]?.toUpperCase() || 'U'

  return (
    <div className="relative" ref={menuRef}>
      {/* Nút bấm hiển thị Avatar & Tên */}
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="flex items-center gap-2.5 p-1.5 pl-2.5 pr-3 rounded-xl border border-border/80 bg-card hover:border-app-accent/40 hover:shadow-2xs transition-all text-left"
        title="Tài khoản người dùng"
      >
        {avatarUrl ? (
          <img
            src={avatarUrl}
            alt={name}
            className="w-7 h-7 rounded-full object-cover border border-border flex-shrink-0"
          />
        ) : (
          <div className="w-7 h-7 rounded-full bg-title text-white flex items-center justify-center font-bold text-xs flex-shrink-0 shadow-2xs">
            {initial}
          </div>
        )}
        <div className="hidden sm:block text-left max-w-[120px]">
          <p className="text-xs font-serif font-bold text-title truncate leading-tight">{name}</p>
          <p className="text-[10px] text-muted font-sans truncate leading-none mt-0.5">{user.email}</p>
        </div>
        <ChevronDown className={`w-3.5 h-3.5 text-muted transition-transform duration-200 ${isOpen ? 'rotate-180' : ''}`} />
      </button>

      {/* Menu dropdown mở ra */}
      {isOpen && (
        <div className="absolute right-0 mt-2 w-64 bg-card border border-border rounded-xl shadow-lg p-1.5 z-50 animate-in fade-in zoom-in-95 duration-150 space-y-1">
          {/* Header trong menu */}
          <div className="p-3 border-b border-border/80 bg-page/40 rounded-lg">
            <p className="font-serif font-bold text-sm text-title truncate">{name}</p>
            <p className="text-xs text-muted font-sans truncate">{user.email}</p>
          </div>

          {/* Các liên kết điều hướng tài khoản */}
          <div className="py-1 space-y-0.5 font-serif text-xs md:text-sm">
            <Link
              href="/profile"
              onClick={() => setIsOpen(false)}
              className="flex items-center gap-2.5 px-3 py-2 rounded-lg text-body hover:text-title hover:bg-page transition-colors"
            >
              <User className="w-4 h-4 text-app-accent" />
              <span>Thông tin cá nhân</span>
            </Link>

            <Link
              href="/profile#progress"
              onClick={() => setIsOpen(false)}
              className="flex items-center gap-2.5 px-3 py-2 rounded-lg text-body hover:text-title hover:bg-page transition-colors"
            >
              <GraduationCap className="w-4 h-4 text-gold" />
              <span>Tiến độ học tập</span>
            </Link>

            <Link
              href="/typing"
              onClick={() => setIsOpen(false)}
              className="flex items-center gap-2.5 px-3 py-2 rounded-lg text-body hover:text-title hover:bg-page transition-colors"
            >
              <Keyboard className="w-4 h-4 text-jade" />
              <span>Luyện đánh máy</span>
            </Link>

            <Link
              href="/radicals"
              onClick={() => setIsOpen(false)}
              className="flex items-center gap-2.5 px-3 py-2 rounded-lg text-body hover:text-title hover:bg-page transition-colors"
            >
              <Sparkles className="w-4 h-4 text-app-accent" />
              <span>214 Bộ thủ</span>
            </Link>
          </div>

          {/* Nút đăng xuất */}
          <div className="border-t border-border/80 pt-1">
            <form action={logout}>
              <button
                type="submit"
                className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-xs md:text-sm font-serif text-muted hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-950/20 transition-colors text-left"
              >
                <LogOut className="w-4 h-4" />
                <span>Đăng xuất</span>
              </button>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
