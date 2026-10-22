'use client'

import { useState, useRef, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import {
  Bell,
  Bug,
  Lightbulb,
  Palette,
  BookOpen,
  HelpCircle,
  CheckCheck,
  Loader2,
  Inbox,
  AlertCircle,
} from 'lucide-react'
import {
  useAdminNotifications,
} from './admin-notification-context'
import type { AdminNotification } from '@/app/actions/notifications'

const CATEGORY_ICONS: Record<string, typeof Bug> = {
  bug: Bug,
  feature: Lightbulb,
  ui_ux: Palette,
  content: BookOpen,
  other: HelpCircle,
}

const CATEGORY_COLORS: Record<string, string> = {
  bug: 'bg-red-50 text-red-600 border-red-200',
  feature: 'bg-amber-50 text-amber-600 border-amber-200',
  ui_ux: 'bg-purple-50 text-purple-600 border-purple-200',
  content: 'bg-emerald-50 text-emerald-600 border-emerald-200',
  other: 'bg-blue-50 text-blue-600 border-blue-200',
}

const CATEGORY_LABELS: Record<string, string> = {
  bug: 'Báo lỗi',
  feature: 'Đề xuất',
  ui_ux: 'Giao diện',
  content: 'Nội dung',
  other: 'Ý kiến',
}

/** Hiển thị thời gian tương đối (ví dụ: "5 phút trước") */
function formatRelativeTime(dateStr: string): string {
  const now = Date.now()
  const then = new Date(dateStr).getTime()
  const diffSec = Math.floor((now - then) / 1000)

  if (diffSec < 60) return 'Vừa xong'
  if (diffSec < 3600) return `${Math.floor(diffSec / 60)} phút trước`
  if (diffSec < 86400) return `${Math.floor(diffSec / 3600)} giờ trước`
  if (diffSec < 604800) return `${Math.floor(diffSec / 86400)} ngày trước`
  return new Date(dateStr).toLocaleDateString('vi-VN')
}

export interface AdminNotificationBellProps {
  /** Optional ID của Admin (được cung cấp từ Provider) */
  adminId?: string
}

export function AdminNotificationBell({ adminId }: AdminNotificationBellProps = {}) {
  const router = useRouter()
  const [isOpen, setIsOpen] = useState(false)
  const [isMarkingAll, setIsMarkingAll] = useState(false)
  const dropdownRef = useRef<HTMLDivElement>(null)

  const {
    notifications,
    unreadCount,
    isLoading,
    hasError,
    hasNewAnimation,
    markAsRead,
    markAllAsRead,
    refetch,
  } = useAdminNotifications()

  // Đóng dropdown khi click ra ngoài
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setIsOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  // Nhấn vào một thông báo: đánh dấu đã đọc + điều hướng
  const handleNotificationClick = async (notification: AdminNotification) => {
    setIsOpen(false)

    if (!notification.is_read) {
      markAsRead(notification.id).catch(() => {})
    }

    // Điều hướng tới trang admin/feedback với highlight
    router.push(`/admin/feedback?highlight=${notification.id}`)
  }

  // Đánh dấu tất cả đã đọc
  const handleMarkAllRead = async () => {
    if (isMarkingAll || unreadCount === 0) return
    setIsMarkingAll(true)
    try {
      await markAllAsRead()
    } finally {
      setIsMarkingAll(false)
    }
  }

  return (
    <div className="relative" ref={dropdownRef}>
      {/* Nút Chuông thông báo */}
      <button
        type="button"
        onClick={() => setIsOpen(!isOpen)}
        className={`relative h-9 w-9 flex items-center justify-center rounded-xl border border-border/80 bg-card hover:border-app-accent/40 hover:shadow-2xs transition-all cursor-pointer ${
          hasNewAnimation ? 'animate-[bell-ring_0.5s_ease-in-out]' : ''
        }`}
        title="Thông báo quản trị"
        aria-label={`Thông báo quản trị${unreadCount > 0 ? ` (${unreadCount} chưa đọc)` : ''}`}
      >
        <Bell className={`h-4 w-4 transition-colors ${isOpen ? 'text-app-accent' : 'text-muted'}`} />

        {/* Badge số lượng chưa đọc */}
        {unreadCount > 0 && (
          <span className="absolute -top-1 -right-1 min-w-[18px] h-[18px] flex items-center justify-center px-1 text-[10px] font-sans font-bold bg-app-accent text-white rounded-full shadow-sm border-2 border-card animate-in zoom-in-50 duration-200">
            {unreadCount > 99 ? '99+' : unreadCount}
          </span>
        )}
      </button>

      {/* Dropdown Panel thông báo */}
      {isOpen && (
        <div className="fixed inset-x-3 top-16 sm:absolute sm:inset-auto sm:right-0 sm:top-full mt-2 sm:w-96 max-h-[80vh] flex flex-col bg-card border border-border rounded-2xl shadow-xl z-50 animate-in fade-in zoom-in-95 duration-150 overflow-hidden">
          {/* Header */}
          <div className="flex items-center justify-between px-4 py-3 border-b border-border/80 bg-page/40">
            <div className="flex items-center gap-2">
              <Bell className="w-4 h-4 text-app-accent" />
              <h3 className="text-sm font-serif font-bold text-title">Thông báo</h3>
              {unreadCount > 0 && (
                <span className="text-[10px] font-sans font-bold bg-app-accent/10 text-app-accent px-1.5 py-0.5 rounded-full">
                  {unreadCount} mới
                </span>
              )}
            </div>
            {unreadCount > 0 && (
              <button
                type="button"
                onClick={handleMarkAllRead}
                disabled={isMarkingAll}
                className="flex items-center gap-1 text-[11px] font-serif text-app-accent hover:text-app-accent/80 transition-colors cursor-pointer disabled:opacity-50"
              >
                {isMarkingAll ? (
                  <Loader2 className="w-3 h-3 animate-spin" />
                ) : (
                  <CheckCheck className="w-3 h-3" />
                )}
                <span>Đọc tất cả</span>
              </button>
            )}
          </div>

          {/* Danh sách thông báo */}
          <div className="max-h-[400px] overflow-y-auto no-scrollbar">
            {/* Loading state */}
            {isLoading && (
              <div className="p-6 flex flex-col items-center gap-2 text-muted">
                <Loader2 className="w-5 h-5 animate-spin text-app-accent" />
                <p className="text-xs font-serif">Đang tải thông báo...</p>
              </div>
            )}

            {/* Error state */}
            {!isLoading && hasError && (
              <div className="p-6 flex flex-col items-center gap-2 text-muted">
                <AlertCircle className="w-5 h-5 text-red-500" />
                <p className="text-xs font-serif text-red-600">Không thể tải thông báo</p>
                <button
                  type="button"
                  onClick={() => refetch()}
                  className="text-[11px] text-app-accent hover:underline cursor-pointer"
                >
                  Thử lại
                </button>
              </div>
            )}

            {/* Empty state */}
            {!isLoading && !hasError && notifications.length === 0 && (
              <div className="p-8 flex flex-col items-center gap-2 text-muted">
                <Inbox className="w-6 h-6 text-muted/50" />
                <p className="text-xs font-serif">Bạn chưa có thông báo nào</p>
              </div>
            )}

            {/* Notification items */}
            {!isLoading && !hasError && notifications.map((notification) => {
              const Icon = CATEGORY_ICONS[notification.category] || HelpCircle
              const colorClass = CATEGORY_COLORS[notification.category] || CATEGORY_COLORS.other
              const categoryLabel = CATEGORY_LABELS[notification.category] || 'Khác'

              return (
                <button
                  key={notification.id}
                  type="button"
                  onClick={() => handleNotificationClick(notification)}
                  className={`w-full text-left px-4 py-3 border-b border-border/50 last:border-b-0 hover:bg-page/60 transition-colors cursor-pointer group ${
                    !notification.is_read ? 'bg-app-accent/[0.03]' : ''
                  }`}
                >
                  <div className="flex gap-3 items-start">
                    {/* Icon danh mục */}
                    <div className={`w-8 h-8 rounded-lg flex items-center justify-center shrink-0 border ${colorClass}`}>
                      <Icon className="w-3.5 h-3.5" />
                    </div>

                    {/* Nội dung */}
                    <div className="flex-1 min-w-0 space-y-0.5">
                      <div className="flex items-center gap-1.5">
                        {/* Chấm chỉ thị chưa đọc */}
                        {!notification.is_read && (
                          <span className="w-1.5 h-1.5 rounded-full bg-app-accent shrink-0" />
                        )}
                        <span className={`text-[10px] font-sans px-1.5 py-0.5 rounded border ${colorClass}`}>
                          {categoryLabel}
                        </span>
                        <span className="text-[10px] text-muted font-sans ml-auto shrink-0">
                          {formatRelativeTime(notification.created_at)}
                        </span>
                      </div>

                      <p className={`text-xs font-serif leading-snug truncate ${
                        !notification.is_read ? 'font-bold text-title' : 'text-body'
                      }`}>
                        {notification.title}
                      </p>

                      <p className="text-[11px] text-muted font-sans truncate leading-tight">
                        {notification.message.slice(0, 80)}
                        {notification.message.length > 80 ? '...' : ''}
                      </p>

                      {/* Tên người gửi */}
                      {(notification.sender_name || notification.sender_email) && (
                        <p className="text-[10px] text-muted/70 font-sans truncate">
                          Từ: {notification.sender_name || notification.sender_email?.split('@')[0] || 'Ẩn danh'}
                        </p>
                      )}
                    </div>
                  </div>
                </button>
              )
            })}
          </div>
        </div>
      )}

      {/* CSS cho hiệu ứng chuông rung nhẹ */}
      <style jsx>{`
        @keyframes bell-ring {
          0% { transform: rotate(0); }
          15% { transform: rotate(8deg); }
          30% { transform: rotate(-8deg); }
          45% { transform: rotate(5deg); }
          60% { transform: rotate(-5deg); }
          75% { transform: rotate(2deg); }
          100% { transform: rotate(0); }
        }
      `}</style>
    </div>
  )
}
