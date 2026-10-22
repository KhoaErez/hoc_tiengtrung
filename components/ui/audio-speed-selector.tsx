'use client'

import React, { useState, useRef, useEffect } from 'react'
import { Gauge, Check, ChevronDown } from 'lucide-react'
import { useTTSRate, TTS_SPEED_RATES, type TTSSpeedRate } from '@/hooks/use-chinese-tts'

export interface AudioSpeedSelectorProps {
  /** Kiểu hiển thị:
   * - 'dropdown': Nút bấm nhỏ gọn, nhấn vào mở danh sách 6 mức tốc độ
   * - 'segmented': Thanh ngang các nút bấm chọn trực tiếp
   * - 'cycle': Nút đơn giản nhấn để chuyển xoay vòng 0.5x -> 0.75x -> 1.0x -> 1.25x -> 1.5x -> 2.0x
   */
  variant?: 'dropdown' | 'segmented' | 'cycle'
  /** Kích thước: xs, sm, md */
  size?: 'xs' | 'sm' | 'md'
  /** Hiển thị chữ "Tốc độ" kèm icon */
  showLabel?: boolean
  /** Class tùy biến */
  className?: string
  /** Callback khi thay đổi tốc độ */
  onRateChange?: (newRate: number) => void
}

const SPEED_LABELS: Record<TTSSpeedRate, string> = {
  0.5: 'Rất chậm',
  0.75: 'Chậm',
  1.0: 'Bình thường',
  1.25: 'Nhanh',
  1.5: 'Rất nhanh',
  2.0: 'Tốc độ cao',
}

export function AudioSpeedSelector({
  variant = 'dropdown',
  size = 'sm',
  showLabel = true,
  className = '',
  onRateChange,
}: AudioSpeedSelectorProps) {
  const { rate, setRate, cycleNextRate } = useTTSRate()
  const [isOpen, setIsOpen] = useState(false)
  const menuRef = useRef<HTMLDivElement>(null)

  // Đóng menu khi click ra ngoài
  useEffect(() => {
    if (!isOpen) return
    const handleClickOutside = (e: MouseEvent) => {
      if (menuRef.current && !menuRef.current.contains(e.target as Node)) {
        setIsOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [isOpen])

  const handleSelectRate = (newRate: number) => {
    setRate(newRate)
    onRateChange?.(newRate)
    setIsOpen(false)
  }

  const handleCycle = () => {
    const nextRate = cycleNextRate()
    onRateChange?.(nextRate)
  }

  // 1. DẠNG CYCLE BUTTON (Nhấn để chuyển nhanh)
  if (variant === 'cycle') {
    return (
      <button
        type="button"
        onClick={handleCycle}
        className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-lg border border-border/80 bg-card hover:border-app-accent/40 font-mono text-muted hover:text-title transition-all cursor-pointer ${
          size === 'xs' ? 'text-[11px] h-6 px-2' : size === 'sm' ? 'text-xs h-7' : 'text-sm h-8'
        } ${className}`}
        title={`Tốc độ đọc hiện tại: ${rate}x (${SPEED_LABELS[rate as TTSSpeedRate] || 'Tùy chỉnh'}). Nhấn để đổi tốc độ.`}
      >
        <Gauge className={`${size === 'xs' ? 'w-3 h-3' : 'w-3.5 h-3.5'} text-app-accent`} />
        <span className="font-bold text-title">{rate}x</span>
        {rate === 1.0 && <span className="text-[10px] text-muted font-sans hidden sm:inline">(Chuẩn)</span>}
      </button>
    )
  }

  // 2. DẠNG SEGMENTED (Thanh nút ngang)
  if (variant === 'segmented') {
    return (
      <div className={`inline-flex items-center bg-page border border-border rounded-xl p-0.5 text-xs font-serif ${className}`}>
        {showLabel && (
          <span className="px-2 py-0.5 text-[11px] text-muted flex items-center gap-1 select-none">
            <Gauge className="w-3 h-3 text-muted" />
            <span className="hidden sm:inline">Tốc độ:</span>
          </span>
        )}
        <div className="flex items-center gap-0.5">
          {TTS_SPEED_RATES.map((r) => {
            const isActive = Math.abs(rate - r) < 0.05
            return (
              <button
                key={r}
                type="button"
                onClick={() => handleSelectRate(r)}
                className={`px-1.5 sm:px-2 py-0.5 rounded-lg text-xs font-sans transition-all cursor-pointer ${
                  isActive
                    ? 'bg-title text-white font-bold shadow-2xs'
                    : 'text-muted hover:text-title hover:bg-card'
                }`}
                title={`${r}x — ${SPEED_LABELS[r]}`}
              >
                {r}x
              </button>
            )
          })}
        </div>
      </div>
    )
  }

  // 3. DẠNG DROPDOWN (Mặc định - Gọn gàng, chuyên nghiệp)
  return (
    <div ref={menuRef} className={`relative inline-block text-left select-none ${className}`}>
      <button
        type="button"
        onClick={() => setIsOpen((prev) => !prev)}
        className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl border border-border/80 bg-card hover:border-app-accent/40 font-serif text-muted hover:text-title transition-all cursor-pointer shadow-2xs ${
          size === 'xs' ? 'text-[11px] h-6 px-2' : size === 'sm' ? 'text-xs h-7' : 'text-sm h-8'
        }`}
        title="Điều chỉnh tốc độ phát âm thanh tiếng Trung"
        aria-expanded={isOpen}
      >
        <Gauge className={`${size === 'xs' ? 'w-3 h-3' : 'w-3.5 h-3.5'} text-app-accent flex-shrink-0`} />
        {showLabel && <span className="text-muted font-sans text-[11px] hidden xs:inline">Tốc độ:</span>}
        <span className="font-bold text-title font-mono">{rate}x</span>
        <ChevronDown className={`w-3 h-3 text-muted transition-transform duration-200 ${isOpen ? 'rotate-180' : ''}`} />
      </button>

      {isOpen && (
        <div className="absolute right-0 mt-1.5 w-44 rounded-2xl bg-card border border-border shadow-lg py-1.5 z-50 animate-in fade-in zoom-in-95 duration-100 font-serif">
          <div className="px-3 py-1 border-b border-border/60 text-[10px] uppercase tracking-wider text-muted font-sans font-semibold">
            Tốc độ phát âm
          </div>
          <div className="py-1">
            {TTS_SPEED_RATES.map((r) => {
              const isSelected = Math.abs(rate - r) < 0.05
              return (
                <button
                  key={r}
                  type="button"
                  onClick={() => handleSelectRate(r)}
                  className={`w-full px-3 py-1.5 text-xs text-left flex items-center justify-between transition-colors cursor-pointer ${
                    isSelected
                      ? 'bg-app-accent-soft text-app-accent font-bold'
                      : 'text-title hover:bg-page'
                  }`}
                >
                  <div className="flex items-center gap-2">
                    <span className="font-mono w-10 font-bold">{r}x</span>
                    <span className="text-[11px] font-sans text-muted">
                      {SPEED_LABELS[r]}
                    </span>
                  </div>
                  {isSelected && <Check className="w-3.5 h-3.5 text-app-accent flex-shrink-0" />}
                </button>
              )
            })}
          </div>
        </div>
      )}
    </div>
  )
}

export default AudioSpeedSelector
