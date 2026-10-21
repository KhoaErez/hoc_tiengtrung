'use client'

import React, { createContext, useContext, useEffect, useRef, useState, useMemo } from 'react'
import { createClient } from '@/lib/supabase/client'
import type { RealtimeChannel } from '@supabase/supabase-js'

const ACTIVITY_THROTTLE_MS = 2 * 60 * 1000 // 2 phút throttle

export type RealtimeConnectionStatus = 'connecting' | 'connected' | 'reconnecting' | 'error'

interface PresenceContextValue {
  onlineCount: number
  onlineUserIds: Set<string>
  realtimeStatus: RealtimeConnectionStatus
  touchActivity: () => Promise<void>
}

const PresenceContext = createContext<PresenceContextValue>({
  onlineCount: 0,
  onlineUserIds: new Set(),
  realtimeStatus: 'connecting',
  touchActivity: async () => {},
})

/**
 * PresenceProvider: Quản lý duy nhất 1 Supabase Realtime Channel 'online-users' cho toàn bộ ứng dụng.
 * - Giải quyết triệt để lỗi "cannot add presence callbacks after subscribe()".
 * - Gắn đầy đủ các callback .on('presence') TRƯỚC KHI gọi .subscribe().
 * - Tự động khử trùng lặp multi-tab/thiết bị qua key: user.id.
 * - Throttled activity heartbeat 2 phút/lần ghi last_seen_at vào DB.
 * - Dừng heartbeat khi tab ẩn (visibilitychange), dọn dẹp khi unmount/đăng xuất/đóng tab.
 */
export function PresenceProvider({ children }: { children: React.ReactNode }) {
  const [onlineCount, setOnlineCount] = useState<number>(0)
  const [onlineUserIds, setOnlineUserIds] = useState<Set<string>>(new Set())
  const [realtimeStatus, setRealtimeStatus] = useState<RealtimeConnectionStatus>('connecting')

  const channelRef = useRef<RealtimeChannel | null>(null)
  const lastTouchTimeRef = useRef<number>(0)
  const intervalRef = useRef<NodeJS.Timeout | null>(null)
  const currentUserIdRef = useRef<string | null>(null)

  // 1. Throttled Touch Activity (Gọi RPC touch_user_activity)
  const touchActivity = async () => {
    const now = Date.now()
    if (now - lastTouchTimeRef.current < ACTIVITY_THROTTLE_MS) {
      return
    }
    lastTouchTimeRef.current = now

    try {
      const supabase = createClient()
      await supabase.rpc('touch_user_activity')
    } catch {
      // Bỏ qua lỗi im lặng để không làm gián đoạn học viên
    }
  }

  // 2. Khởi tạo và đăng ký Presence Channel
  useEffect(() => {
    const supabase = createClient()

    const cleanupPresence = () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current)
        intervalRef.current = null
      }

      if (channelRef.current) {
        try {
          channelRef.current.untrack()
          supabase.removeChannel(channelRef.current)
        } catch {
        }
        channelRef.current = null
      }
      currentUserIdRef.current = null
    }

    const setupPresence = (userId: string) => {
      if (currentUserIdRef.current === userId && channelRef.current) {
        return
      }

      cleanupPresence()
      currentUserIdRef.current = userId
      setRealtimeStatus('connecting')

      // Ghi nhận hoạt động ban đầu
      touchActivity()

      // Tạo channel duy nhất với presence key là user.id
      const channel = supabase.channel('online-users', {
        config: {
          presence: {
            key: userId,
          },
        },
      })

      // QUAN TRỌNG: Gắn tất cả các callback presence TRƯỚC KHI gọi subscribe()
      channel
        .on('presence', { event: 'sync' }, () => {
          try {
            const state = channel.presenceState()
            const ids = new Set<string>(Object.keys(state))
            setOnlineUserIds(ids)
            setOnlineCount(ids.size)
            setRealtimeStatus('connected')
          } catch {
            // Không set số 0 giả khi gặp lỗi đọc state
          }
        })
        .on('presence', { event: 'join' }, ({ key }) => {
          setOnlineUserIds((prev) => {
            const next = new Set(prev)
            next.add(key)
            setOnlineCount(next.size)
            return next
          })
        })
        .on('presence', { event: 'leave' }, ({ key }) => {
          setOnlineUserIds((prev) => {
            const next = new Set(prev)
            next.delete(key)
            setOnlineCount(next.size)
            return next
          })
        })
        .subscribe(async (status) => {
          if (status === 'SUBSCRIBED') {
            setRealtimeStatus('connected')
            try {
              await channel.track({
                user_id: userId,
                online_at: new Date().toISOString(),
              })
            } catch (err) {
              console.debug('[Presence] Track error:', err)
            }
          } else if (status === 'CHANNEL_ERROR' || status === 'TIMED_OUT') {
            setRealtimeStatus('error')
          } else if (status === 'CLOSED') {
            setRealtimeStatus('reconnecting')
          }
        })

      channelRef.current = channel

      // Thiết lập định kỳ chạm nhẹ (2 phút/lần) khi tab đang hoạt động
      if (intervalRef.current) clearInterval(intervalRef.current)
      intervalRef.current = setInterval(() => {
        if (typeof document !== 'undefined' && document.visibilityState === 'visible') {
          touchActivity()
        }
      }, ACTIVITY_THROTTLE_MS)
    }

    // Lấy session hiện tại
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session?.user?.id) {
        setupPresence(session.user.id)
      } else {
        setRealtimeStatus('connecting')
      }
    })

    // Lắng nghe sự kiện đăng nhập / đăng xuất
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
      if (session?.user?.id && (event === 'SIGNED_IN' || event === 'INITIAL_SESSION' || event === 'TOKEN_REFRESHED')) {
        setupPresence(session.user.id)
      } else if (event === 'SIGNED_OUT' || !session) {
        cleanupPresence()
        setOnlineCount(0)
        setOnlineUserIds(new Set())
      }
    })

    // Xử lý đổi tab (visibilitychange)
    const handleVisibilityChange = () => {
      if (document.visibilityState === 'visible' && currentUserIdRef.current) {
        touchActivity()
      }
    }
    document.addEventListener('visibilitychange', handleVisibilityChange)

    // Xử lý đóng tab
    const handleBeforeUnload = () => {
      if (channelRef.current) {
        channelRef.current.untrack()
      }
    }
    window.addEventListener('beforeunload', handleBeforeUnload)

    return () => {
      document.removeEventListener('visibilitychange', handleVisibilityChange)
      window.removeEventListener('beforeunload', handleBeforeUnload)
      subscription.unsubscribe()
      cleanupPresence()
    }
  }, [])

  const contextValue = useMemo(
    () => ({
      onlineCount,
      onlineUserIds,
      realtimeStatus,
      touchActivity,
    }),
    [onlineCount, onlineUserIds, realtimeStatus]
  )

  return (
    <PresenceContext.Provider value={contextValue}>
      {children}
    </PresenceContext.Provider>
  )
}

export function usePresence() {
  return useContext(PresenceContext)
}
