'use client'

import React, { useState, useEffect } from 'react'
import { Volume2, VolumeX, Loader2, Square } from 'lucide-react'
import { useChineseTTS } from '@/hooks/use-chinese-tts'
import { toast } from 'sonner'

export interface AudioButtonProps {
  /** Văn bản tiếng Trung cần phát âm */
  text: string
  /** Định danh duy nhất để xác định trạng thái phát (nếu không truyền sẽ dùng text) */
  id?: string
  /** Kích thước nút: xs (24px), sm (28px - mặc định), md (32px), lg (40px) */
  size?: 'xs' | 'sm' | 'md' | 'lg'
  /** Kiểu dáng: ghost, outline, subtle, solid */
  variant?: 'ghost' | 'outline' | 'subtle' | 'solid'
  /** Tốc độ phát âm: 0.75x, 1x, 1.25x... (mặc định 1.0) */
  rate?: number
  /** Hiển thị nhãn chữ kèm theo icon */
  showLabel?: boolean
  /** Nội dung nhãn tùy chỉnh */
  label?: string
  /** Tooltip gợi ý khi rê chuột */
  tooltip?: string
  /** Class tùy biến thêm */
  className?: string
  /** Callback khi bắt đầu phát */
  onPlayStart?: () => void
  /** Callback khi kết thúc phát */
  onPlayEnd?: () => void
}

export function AudioButton({
  text,
  id,
  size = 'sm',
  variant = 'ghost',
  rate = 1.0,
  showLabel = false,
  label = 'Nghe',
  tooltip = 'Nghe phát âm tiếng Trung',
  className = '',
  onPlayStart,
  onPlayEnd,
}: AudioButtonProps) {
  const { speak, stop, isSpeakingItem, hasChineseVoice, voices } = useChineseTTS()
  const [hasVoiceError, setHasVoiceError] = useState(false)

  const itemId = id || text
  const isPlayingThis = isSpeakingItem(itemId)

  // Tự động dừng phát khi component unmount nếu đang phát chính nút này
  useEffect(() => {
    return () => {
      if (isSpeakingItem(itemId)) {
        stop()
      }
    }
  }, [itemId, isSpeakingItem, stop])

  // Kích thước nút & Icon
  const sizeClasses = {
    xs: 'h-6 w-6 text-xs p-1 rounded-md',
    sm: 'h-7 w-7 text-xs p-1.5 rounded-lg',
    md: 'h-8 w-8 text-sm p-2 rounded-xl',
    lg: 'h-10 w-10 text-base p-2.5 rounded-2xl',
  }[size]

  const iconSizes = {
    xs: 'w-3.5 h-3.5',
    sm: 'w-4 h-4',
    md: 'w-4.5 h-4.5',
    lg: 'w-5 h-5',
  }[size]

  // Biến thể màu sắc hài hòa với design system Á Đông
  const variantClasses = {
    ghost: isPlayingThis
      ? 'text-app-accent bg-app-accent-soft/60 shadow-2xs'
      : 'text-muted hover:text-app-accent hover:bg-app-accent-soft/30 active:scale-95',
    outline: isPlayingThis
      ? 'text-app-accent bg-app-accent-soft/60 border border-app-accent/40 shadow-2xs'
      : 'text-title border border-border bg-card hover:border-app-accent/50 hover:text-app-accent active:scale-95',
    subtle: isPlayingThis
      ? 'text-app-accent bg-app-accent-soft border border-app-accent/30 shadow-2xs'
      : 'text-title bg-page hover:bg-app-accent-soft/40 hover:text-app-accent active:scale-95 border border-border/60',
    solid: isPlayingThis
      ? 'text-white bg-app-accent-hover shadow-sm'
      : 'text-white bg-app-accent hover:bg-accent-hover active:scale-95 shadow-2xs',
  }[variant]

  const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
    // Ngăn chặn sự kiện nổi bọt để không kích hoạt thẻ cha (ví dụ thẻ Card, Link, Accordion)
    e.preventDefault()
    e.stopPropagation()

    if (isPlayingThis) {
      stop()
      return
    }

    if (!text || !text.trim()) {
      return
    }

    // Kiểm tra xem thiết bị có giọng đọc tiếng Trung hay không
    if (!hasChineseVoice && voices.length > 0) {
      toast.info('Trình duyệt chưa tải xong giọng tiếng Trung hoặc thiết bị chưa cài gói giọng zh-CN.')
    }

    speak(text, {
      id: itemId,
      rate,
      onStart: () => {
        setHasVoiceError(false)
        onPlayStart?.()
      },
      onEnd: () => {
        onPlayEnd?.()
      },
      onError: () => {
        setHasVoiceError(true)
        toast.error('Không thể phát âm thanh trên thiết bị này.')
      },
    })
  }

  const currentTitle = isPlayingThis
    ? 'Nhấn để dừng phát âm'
    : hasVoiceError
    ? 'Lỗi phát âm'
    : tooltip

  return (
    <button
      type="button"
      onClick={handleClick}
      title={currentTitle}
      aria-label={currentTitle}
      className={`inline-flex items-center justify-center gap-1.5 transition-all select-none cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/50 shrink-0 ${
        showLabel ? 'w-auto px-2.5' : sizeClasses
      } ${variantClasses} ${className}`}
    >
      {isPlayingThis ? (
        <span className="relative flex items-center justify-center">
          <Volume2 className={`${iconSizes} text-app-accent animate-pulse`} />
          <span className="absolute -top-1 -right-1 w-2 h-2 rounded-full bg-app-accent animate-ping" />
        </span>
      ) : hasVoiceError ? (
        <VolumeX className={`${iconSizes} text-rose-500`} />
      ) : (
        <Volume2 className={iconSizes} />
      )}

      {showLabel && (
        <span className="font-serif text-xs font-medium">
          {isPlayingThis ? 'Đang đọc...' : label}
        </span>
      )}
    </button>
  )
}

export default AudioButton
