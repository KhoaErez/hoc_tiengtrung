'use client'

import React, { useState, useEffect } from 'react'
import {
  Volume2,
  Play,
  Pause,
  Square,
  Gauge,
  Headphones,
  RotateCcw,
} from 'lucide-react'
import { useChineseTTS } from '@/hooks/use-chinese-tts'
import { Button } from '@/components/ui/button'
import { AudioSpeedSelector } from '@/components/ui/audio-speed-selector'

export interface PassageAudioPlayerProps {
  /** Toàn bộ văn bản tiếng Trung cần đọc */
  text: string
  /** Tiêu đề thanh nghe (ví dụ: "Nghe bài đọc", "Luyện nghe bài viết") */
  title?: string
  /** Định danh duy nhất cho đoạn văn */
  id?: string
  /** Lớp CSS tùy biến */
  className?: string
  /** Tùy chọn gọn (compact) cho thanh công cụ nhỏ */
  compact?: boolean
}

export function PassageAudioPlayer({
  text,
  title = 'Luyện nghe đoạn văn',
  id = 'passage-player',
  className = '',
  compact = false,
}: PassageAudioPlayerProps) {
  const {
    status,
    isPlaying,
    isPaused,
    rate,
    setRate,
    speak,
    pause,
    resume,
    stop,
    isSpeakingItem,
  } = useChineseTTS()

  const isCurrentPassageActive = isSpeakingItem(id)
  const isPlayingThis = isCurrentPassageActive && isPlaying
  const isPausedThis = isCurrentPassageActive && isPaused

  // Dọn dẹp an toàn khi component unmount: nếu đang phát chính trình phát này, dừng phát
  useEffect(() => {
    return () => {
      if (isSpeakingItem(id)) {
        stop()
      }
    }
  }, [id, isSpeakingItem, stop])

  const handlePlay = () => {
    if (isPausedThis) {
      resume()
      return
    }
    speak(text, { id, rate })
  }

  const handlePause = () => {
    pause()
  }

  const handleStop = () => {
    stop()
  }

  const handleRateChange = (newRate: number) => {
    setRate(newRate)
    // Nếu đang phát đoạn này, phát lại ngay với tốc độ mới
    if (isPlayingThis) {
      speak(text, { id, rate: newRate })
    }
  }

  if (compact) {
    return (
      <div
        className={`inline-flex items-center gap-1.5 p-1 bg-card border border-border rounded-xl shadow-2xs ${className}`}
      >
        {!isPlayingThis && !isPausedThis ? (
          <Button
            type="button"
            variant="ghost"
            size="sm"
            onClick={handlePlay}
            className="h-7 px-2.5 text-xs font-serif text-title hover:text-app-accent hover:bg-app-accent-soft/40 rounded-lg gap-1.5 cursor-pointer"
            title="Nghe toàn bộ đoạn văn"
          >
            <Play className="w-3.5 h-3.5 fill-current text-app-accent" />
            <span>Nghe toàn bài</span>
          </Button>
        ) : isPausedThis ? (
          <Button
            type="button"
            variant="ghost"
            size="sm"
            onClick={handlePlay}
            className="h-7 px-2.5 text-xs font-serif text-amber-700 dark:text-amber-400 bg-amber-500/10 rounded-lg gap-1.5 cursor-pointer"
            title="Tiếp tục nghe"
          >
            <Play className="w-3.5 h-3.5 fill-current" />
            <span>Tiếp tục</span>
          </Button>
        ) : (
          <Button
            type="button"
            variant="ghost"
            size="sm"
            onClick={handlePause}
            className="h-7 px-2.5 text-xs font-serif text-app-accent bg-app-accent-soft rounded-lg gap-1.5 cursor-pointer"
            title="Tạm dừng"
          >
            <Pause className="w-3.5 h-3.5 fill-current" />
            <span>Tạm dừng</span>
          </Button>
        )}

        {(isPlayingThis || isPausedThis) && (
          <Button
            type="button"
            variant="ghost"
            size="sm"
            onClick={handleStop}
            className="h-7 w-7 p-0 text-muted hover:text-rose-600 hover:bg-rose-50 rounded-lg cursor-pointer"
            title="Dừng phát"
          >
            <Square className="w-3.5 h-3.5 fill-current" />
          </Button>
        )}

        <div className="h-4 w-px bg-border mx-0.5" />

        {/* Nút chỉnh tốc độ đầy đủ 6 mức */}
        <AudioSpeedSelector variant="cycle" size="xs" onRateChange={handleRateChange} />
      </div>
    )
  }

  return (
    <div
      className={`bg-card border border-border rounded-2xl p-3 md:p-4 shadow-2xs space-y-3 transition-all ${className}`}
    >
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        {/* Tiêu đề & Trạng thái */}
        <div className="flex items-center gap-2.5 flex-wrap">
          <div className="w-8 h-8 rounded-xl bg-app-accent-soft flex items-center justify-center text-app-accent shrink-0">
            <Headphones className="w-4 h-4" />
          </div>
          <div>
            <h4 className="font-serif font-bold text-sm text-title">{title}</h4>
            <p className="text-[11px] font-serif text-muted">
              {isPlayingThis
                ? 'Đang phát âm thanh chuẩn Mandarin...'
                : isPausedThis
                ? 'Đang tạm dừng phát âm'
                : 'Giọng đọc chuẩn tiếng Trung phổ thông (zh-CN)'}
            </p>
          </div>

          {isPlayingThis && (
            <span className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-[10px] font-sans font-bold bg-emerald-500/15 text-jade border border-jade/30">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-ping" />
              <span>Đang đọc</span>
            </span>
          )}

          {isPausedThis && (
            <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-sans font-bold bg-amber-500/15 text-amber-700 dark:text-amber-400 border border-amber-500/30">
              <Pause className="w-3 h-3" />
              <span>Tạm dừng</span>
            </span>
          )}
        </div>

        {/* Bộ điều khiển phát & Tốc độ */}
        <div className="flex items-center gap-2 flex-wrap">
          {/* Tốc độ đọc 6 mức */}
          <AudioSpeedSelector variant="dropdown" size="sm" onRateChange={handleRateChange} />

          {/* Các nút phát âm thanh chính */}
          <div className="flex items-center gap-1.5">
            {!isPlayingThis && !isPausedThis ? (
              <Button
                type="button"
                onClick={handlePlay}
                size="sm"
                className="font-serif bg-app-accent hover:bg-accent-hover text-white rounded-xl text-xs gap-1.5 shadow-2xs cursor-pointer"
              >
                <Play className="w-3.5 h-3.5 fill-current" />
                <span>Nghe toàn bài</span>
              </Button>
            ) : isPausedThis ? (
              <Button
                type="button"
                onClick={handlePlay}
                size="sm"
                className="font-serif bg-amber-600 hover:bg-amber-700 text-white rounded-xl text-xs gap-1.5 shadow-2xs cursor-pointer"
              >
                <Play className="w-3.5 h-3.5 fill-current" />
                <span>Tiếp tục</span>
              </Button>
            ) : (
              <Button
                type="button"
                onClick={handlePause}
                size="sm"
                variant="outline"
                className="font-serif border-app-accent/40 text-app-accent hover:bg-app-accent-soft rounded-xl text-xs gap-1.5 cursor-pointer"
              >
                <Pause className="w-3.5 h-3.5 fill-current" />
                <span>Tạm dừng</span>
              </Button>
            )}

            {(isPlayingThis || isPausedThis) && (
              <Button
                type="button"
                onClick={handleStop}
                size="sm"
                variant="outline"
                className="font-serif border-border text-muted hover:text-rose-600 hover:border-rose-300 rounded-xl text-xs gap-1 cursor-pointer"
                title="Dừng phát âm thanh"
              >
                <Square className="w-3.5 h-3.5 fill-current" />
                <span>Dừng</span>
              </Button>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}

export default PassageAudioPlayer
