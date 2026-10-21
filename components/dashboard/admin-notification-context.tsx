'use client'

import React, { createContext, useContext, useState, useEffect, useRef, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  getAdminNotificationsAction,
  markNotificationAsReadAction,
  markAllNotificationsAsReadAction,
  type AdminNotification,
} from '@/app/actions/notifications'

interface AdminNotificationContextValue {
  notifications: AdminNotification[]
  unreadCount: number
  isLoading: boolean
  hasError: boolean
  hasNewAnimation: boolean
  markAsRead: (id: string) => Promise<void>
  markAllAsRead: () => Promise<void>
  refetch: () => Promise<void>
}

const AdminNotificationContext = createContext<AdminNotificationContextValue>({
  notifications: [],
  unreadCount: 0,
  isLoading: false,
  hasError: false,
  hasNewAnimation: false,
  markAsRead: async () => {},
  markAllAsRead: async () => {},
  refetch: async () => {},
})

export function useAdminNotifications() {
  return useContext(AdminNotificationContext)
}

interface AdminNotificationProviderProps {
  children: React.ReactNode
  adminId?: string | null
}

/**
 * Provider quản lý DUY NHẤT 1 Realtime subscription cho toàn bộ Header (Desktop + Mobile)
 * Đảm bảo đồng bộ tuyệt đối số badge, trạng thái đã đọc và không bao giờ bị lỗi
 * "cannot add postgres_changes callbacks after subscribe()".
 */
export function AdminNotificationProvider({
  children,
  adminId,
}: AdminNotificationProviderProps) {
  const [notifications, setNotifications] = useState<AdminNotification[]>([])
  const [unreadCount, setUnreadCount] = useState(0)
  const [isLoading, setIsLoading] = useState(false)
  const [hasError, setHasError] = useState(false)
  const [hasNewAnimation, setHasNewAnimation] = useState(false)

  const knownIdsRef = useRef<Set<string>>(new Set())

  // Tải thông báo từ server
  const fetchNotifications = useCallback(async () => {
    if (!adminId) return
    try {
      setHasError(false)
      const result = await getAdminNotificationsAction(20)
      if (result.success) {
        setNotifications(result.notifications)
        setUnreadCount(result.unreadCount)
        knownIdsRef.current = new Set(result.notifications.map((n) => n.id))
      } else {
        setHasError(true)
      }
    } catch {
      setHasError(true)
    } finally {
      setIsLoading(false)
    }
  }, [adminId])

  // Lần đầu tải khi có adminId
  useEffect(() => {
    if (!adminId) {
      setNotifications([])
      setUnreadCount(0)
      return
    }
    setIsLoading(true)
    fetchNotifications()
  }, [adminId, fetchNotifications])

  // Thiết lập Supabase Realtime - Quản lý 1 channel duy nhất với tên ngẫu nhiên tránh trùng React StrictMode
  useEffect(() => {
    if (!adminId) return

    const supabase = createClient()
    const channelName = `admin-feedback-${adminId}-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`

    const channel = supabase
      .channel(channelName, {
        config: { broadcast: { self: false } },
      })
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'feedback',
        },
        (payload) => {
          const newFeedback = payload.new as any
          if (!newFeedback?.id) return

          // Chống nhận trùng sự kiện
          if (knownIdsRef.current.has(newFeedback.id)) return
          knownIdsRef.current.add(newFeedback.id)

          const newNotification: AdminNotification = {
            id: newFeedback.id,
            category: newFeedback.category || 'other',
            title: newFeedback.title || 'Phản hồi mới',
            message: newFeedback.message || '',
            created_at: newFeedback.created_at || new Date().toISOString(),
            sender_name: null,
            sender_email: null,
            is_read: false,
          }

          setNotifications((prev) => [newNotification, ...prev].slice(0, 20))
          setUnreadCount((prev) => prev + 1)

          // Hiệu ứng rung chuông
          setHasNewAnimation(true)
          setTimeout(() => setHasNewAnimation(false), 2000)
        }
      )
      .subscribe((status) => {
        if (status === 'SUBSCRIBED') {
          // Bù đắp dữ liệu phát sinh khi offline
          fetchNotifications()
        }
      })

    // Đồng bộ lại khi tab trở lại active
    const handleVisibilityChange = () => {
      if (document.visibilityState === 'visible') {
        fetchNotifications()
      }
    }
    document.addEventListener('visibilitychange', handleVisibilityChange)

    return () => {
      document.removeEventListener('visibilitychange', handleVisibilityChange)
      supabase.removeChannel(channel)
    }
  }, [adminId, fetchNotifications])

  // Đánh dấu 1 thông báo đã đọc
  const markAsRead = useCallback(async (id: string) => {
    setNotifications((prev) =>
      prev.map((n) => (n.id === id ? { ...n, is_read: true } : n))
    )
    setUnreadCount((prev) => Math.max(0, prev - 1))
    await markNotificationAsReadAction(id)
  }, [])

  // Đánh dấu tất cả thông báo đã đọc
  const markAllAsRead = useCallback(async () => {
    setNotifications((prev) => prev.map((n) => ({ ...n, is_read: true })))
    setUnreadCount(0)
    await markAllNotificationsAsReadAction()
  }, [])

  return (
    <AdminNotificationContext.Provider
      value={{
        notifications,
        unreadCount,
        isLoading,
        hasError,
        hasNewAnimation,
        markAsRead,
        markAllAsRead,
        refetch: fetchNotifications,
      }}
    >
      {children}
    </AdminNotificationContext.Provider>
  )
}
