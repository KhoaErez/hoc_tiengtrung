'use client'

import { useEffect, useRef } from 'react'
import { usePathname } from 'next/navigation'
import { stopAllAudio } from '@/lib/tts/tts-engine'

/**
 * Trình quản lý vòng đời âm thanh toàn cục (Global Audio Lifecycle Manager)
 * Tự động dừng âm thanh Web Speech API, TTS Engine và AudioContext khi:
 * - Chuyển sang route / trang khác
 * - Đóng tab hoặc rời khỏi trang web (beforeunload / pagehide)
 */
export function AudioLifecycleManager() {
  const pathname = usePathname()
  const lastPathRef = useRef<string>(pathname)

  useEffect(() => {
    // Nếu pathname thay đổi (người dùng chuyển sang trang khác)
    if (lastPathRef.current !== pathname) {
      lastPathRef.current = pathname
      stopAllAudio()
    }
  }, [pathname])

  useEffect(() => {
    const handleUnload = () => {
      stopAllAudio()
    }

    if (typeof window !== 'undefined') {
      window.addEventListener('beforeunload', handleUnload)
      window.addEventListener('pagehide', handleUnload)
    }

    return () => {
      if (typeof window !== 'undefined') {
        window.removeEventListener('beforeunload', handleUnload)
        window.removeEventListener('pagehide', handleUnload)
      }
      stopAllAudio()
    }
  }, [])

  return null
}

export default AudioLifecycleManager
