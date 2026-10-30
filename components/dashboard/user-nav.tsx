'use client'

import { useState, useRef, useEffect } from 'react'
import Link from 'next/link'
import { User, LogOut, ChevronDown, GraduationCap, Keyboard, Component, LogIn, UserPlus, ShieldAlert, ShieldCheck } from 'lucide-react'
import { logout } from '@/app/auth/actions'

import { useAuthModal } from '@/components/auth/auth-modal-context'

interface UserNavProps {
  user: {
    id: string
    email?: string
    user_metadata?: { full_name?: string }
  } | null
  displayName?: string
  avatarUrl?: string | null
  isAdmin?: boolean
}

export function UserNav({ user, displayName, avatarUrl, isAdmin }: UserNavProps) {
  const [isOpen, setIsOpen] = useState(false)
  const menuRef = useRef<HTMLDivElement | null>(null)
  const { openLoginForm, openRegisterForm } = useAuthModal()

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
        <button
          type="button"
          onClick={() => openLoginForm()}
          className="h-9 flex items-center gap-1.5 px-3 rounded-xl text-xs font-serif text-title hover:text-app-accent hover:bg-page transition-colors cursor-pointer"
        >
          <LogIn className="w-4 h-4 text-muted" />
          <span>Đăng nhập</span>
        </button>
        <button
          type="button"
          onClick={() => openRegisterForm()}
          className="h-9 flex items-center gap-1.5 px-3.5 rounded-xl text-xs font-serif bg-title hover:bg-[#2A3250] text-white transition-colors shadow-2xs cursor-pointer font-medium"
        >
          <UserPlus className="w-4 h-4" />
          <span>Đăng ký</span>
        </button>
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
        className="h-9 flex items-center gap-2 px-2.5 rounded-xl border border-border/80 bg-card hover:border-app-accent/40 hover:bg-[#FFF9F3] hover:shadow-2xs transition-all text-left cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/30"
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
        <div className="hidden sm:block text-left max-w-[150px]">
          <div className="flex items-center gap-1.5">
            <p className="text-xs font-serif font-bold text-title truncate leading-tight">{name}</p>
            {isAdmin && (
              <span className="bg-app-accent text-white text-[9px] font-sans font-bold uppercase px-1 py-0.2 rounded shadow-2xs">
                Admin
              </span>
            )}
          </div>
          <p className="text-[10px] text-muted font-sans truncate leading-none mt-0.5">{user.email}</p>
        </div>
        <ChevronDown className={`w-3.5 h-3.5 text-muted transition-transform duration-200 ${isOpen ? 'rotate-180' : ''}`} />
      </button>

      {/* Menu dropdown mở ra */}
      {isOpen && (
        <div className="absolute right-0 mt-2 w-64 bg-card border border-border rounded-xl shadow-lg p-1.5 z-50 animate-in fade-in zoom-in-95 duration-150 space-y-1">
          {/* Header trong menu */}
          <div className="p-3 border-b border-border/80 bg-page/40 rounded-lg">
            <div className="flex items-center justify-between">
              <p className="font-serif font-bold text-sm text-title truncate">{name}</p>
              {isAdmin && (
                <span className="inline-flex items-center gap-0.5 bg-app-accent-soft text-app-accent border border-app-accent/30 text-[10px] font-bold px-1.5 py-0.5 rounded-full">
                  <ShieldCheck className="w-3 h-3" />
                  Admin
                </span>
              )}
            </div>
            <p className="text-xs text-muted font-sans truncate mt-0.5">{user.email}</p>
          </div>

          {/* Admin link nếu là quản trị viên */}
          {isAdmin && (
            <div className="py-1 border-b border-border/80">
              <Link
                href="/admin"
                onClick={() => setIsOpen(false)}
                className="flex items-center gap-2.5 px-3 py-2 rounded-lg text-app-accent bg-app-accent-soft/30 hover:bg-app-accent-soft transition-colors"
              >
                <ShieldAlert className="w-4 h-4 text-app-accent flex-shrink-0" />
                <div className="min-w-0">
                  <p className="text-xs font-bold leading-tight">Quản trị & Phân quyền</p>
                  <p className="text-[10px] text-muted font-sans leading-none mt-0.5 truncate">Xem thành viên & báo lỗi</p>
                </div>
              </Link>
            </div>
          )}

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
              <Component className="w-4 h-4 text-app-accent" />
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
