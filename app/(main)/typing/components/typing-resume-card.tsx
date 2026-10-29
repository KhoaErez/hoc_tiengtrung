'use client'

import React, { useState } from 'react'
import {
  Play,
  RotateCcw,
  Clock,
  BookOpen,
  ArrowRight,
  Flame,
  CheckCircle2,
  X,
  Sparkles,
} from 'lucide-react'
import { TypingProgressDTO } from '../actions'

interface TypingResumeCardProps {
  progress: TypingProgressDTO
  onResume: (progress: TypingProgressDTO) => void
  onRestart?: (progress: TypingProgressDTO) => void
  onDismiss?: () => void
  compact?: boolean // Dùng cho Widget nhỏ ở trang chủ hoặc Mobile
}

/**
 * Định dạng thời gian học gần nhất thân thiện (Relative time tiếng Việt)
 */
function formatRelativeTime(dateString?: string): string {
  if (!dateString) return 'Gần đây'
  try {
    const now = Date.now()
    const past = new Date(dateString).getTime()
    const diffSec = Math.floor((now - past) / 1000)

    if (diffSec < 60) return 'Vừa học xong'
    const diffMin = Math.floor(diffSec / 60)
    if (diffMin < 60) return `${diffMin} phút trước`
    const diffHour = Math.floor(diffMin / 60)
    if (diffHour < 24) return `${diffHour} giờ trước`
    const diffDay = Math.floor(diffHour / 24)
    if (diffDay === 1) return 'Hôm qua'
    if (diffDay < 7) return `${diffDay} ngày trước`
    return new Date(dateString).toLocaleDateString('vi-VN')
  } catch {
    return 'Gần đây'
  }
}

export default function TypingResumeCard({
  progress,
  onResume,
  onRestart,
  onDismiss,
  compact = false,
}: TypingResumeCardProps) {
  const [showConfirmRestart, setShowConfirmRestart] = useState(false)

  const percent = Math.min(
    100,
    Math.round(((progress.completedSentences || 0) / Math.max(1, progress.totalSentences || 1)) * 100)
  )

  const isTranslateMode =
    progress.practiceMode === 'translate' || progress.mode === 'translate_hsk'

  const modeTitle = isTranslateMode ? 'Dịch Việt → Gõ Hán' : 'Nghe & Gõ'

  // Chế độ con cho Nghe & Gõ (Câu mẫu / Đoạn văn / Theo HSK)
  const subModeTitle = !isTranslateMode
    ? progress.mode === 'sentence'
      ? 'Câu mẫu'
      : progress.mode === 'paragraph'
      ? 'Đoạn văn'
      : progress.mode === 'hsk'
      ? 'Theo HSK'
      : null
    : null

  const hskTitle = progress.hskLevel ? `HSK ${progress.hskLevel}` : null
  const lessonTitle = progress.lessonTitle || (progress.lessonId ? `Bài học` : null)
  const questionIndex = (progress.currentSentenceIndex || 0) + 1

  return (
    <>
      <div className="relative overflow-hidden rounded-3xl border-2 border-[#B8322D]/30 bg-gradient-to-r from-card via-[#FFF9F3] to-card p-5 sm:p-6 shadow-xs animate-in fade-in slide-in-from-top-2 duration-300">
        {/* Nền trang trí phong cách Á Đông */}
        <div className="absolute top-0 right-0 w-64 h-64 bg-[#B8322D]/5 rounded-full blur-3xl pointer-events-none" />

        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 relative z-10">
          <div className="space-y-3 flex-1 min-w-0">
            {/* Header: Tag Chế độ, Cấp HSK, Thời gian */}
            <div className="flex items-center gap-2 flex-wrap">
              <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-serif font-bold bg-[#B8322D] text-white shadow-2xs">
                <Sparkles className="w-3.5 h-3.5" />
                <span>Tiếp tục học</span>
              </span>

              <span className="px-2.5 py-0.5 rounded-full text-xs font-sans font-medium bg-page border border-[#E9DDD1] text-title">
                {modeTitle}
              </span>

              {subModeTitle && (
                <span className="px-2.5 py-0.5 rounded-full text-xs font-sans font-medium bg-[#FFF9F3] border border-[#E9DDD1] text-app-accent font-semibold">
                  {subModeTitle}
                </span>
              )}

              {hskTitle && (
                <span className="px-2 py-0.5 rounded-full text-xs font-sans font-bold bg-app-accent/10 text-app-accent border border-app-accent/20">
                  {hskTitle}
                </span>
              )}

              {lessonTitle && (
                <span className="px-2 py-0.5 rounded-full text-xs font-sans text-muted bg-page border border-border">
                  {lessonTitle}
                </span>
              )}

              <span className="text-[11px] font-sans text-muted flex items-center gap-1 ml-auto md:ml-0">
                <Clock className="w-3 h-3" />
                <span>{formatRelativeTime(progress.updatedAt)}</span>
              </span>
            </div>

            {/* Câu đang học dở */}
            <div>
              <p className="text-xs text-muted font-serif">Đang dừng ở:</p>
              <h3 className="text-base sm:text-lg md:text-xl font-serif font-bold text-[#243047] leading-relaxed truncate">
                Câu {questionIndex}: {progress.currentQuestionText ? `"${progress.currentQuestionText}"` : `Bài tập ${progress.exerciseId}`}
              </h3>
            </div>

            {/* Thanh tiến độ */}
            <div className="space-y-1.5 max-w-md">
              <div className="flex items-center justify-between text-xs font-serif text-muted">
                <span>
                  Đã hoàn thành <strong className="text-title">{progress.completedSentences}</strong>/{progress.totalSentences} câu
                </span>
                <span className="font-mono font-bold text-title">{percent}%</span>
              </div>
              <div className="w-full h-2 bg-page border border-border rounded-full overflow-hidden">
                <div
                  className="h-full bg-[#B8322D] transition-all duration-300 rounded-full"
                  style={{ width: `${percent}%` }}
                />
              </div>
            </div>
          </div>

          {/* Cụm nút bấm hành động */}
          <div className="flex items-center gap-2.5 shrink-0 self-end md:self-center pt-2 md:pt-0">
            {onRestart && (
              <button
                type="button"
                onClick={() => setShowConfirmRestart(true)}
                className="flex items-center gap-1.5 px-3.5 py-2.5 rounded-xl border border-[#E9DDD1] bg-card hover:bg-[#FFF9F3] text-[#243047]/80 hover:text-title text-xs font-serif transition-colors shadow-2xs h-11 min-h-[44px] cursor-pointer"
                title="Bắt đầu lại bài học này từ đầu"
              >
                <RotateCcw className="w-3.5 h-3.5" />
                <span className="hidden sm:inline">Học lại từ đầu</span>
              </button>
            )}

            <button
              type="button"
              onClick={() => onResume(progress)}
              className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-[#B8322D] hover:bg-[#982923] text-white text-xs sm:text-sm font-serif font-bold shadow-2xs transition-all active:scale-95 h-11 min-h-[44px] cursor-pointer"
            >
              <Play className="w-4 h-4 fill-current" />
              <span>Tiếp tục học →</span>
            </button>

            {onDismiss && (
              <button
                type="button"
                onClick={onDismiss}
                className="h-11 w-11 min-h-[44px] min-w-[44px] rounded-xl text-muted hover:text-title hover:bg-[#FFF9F3] border border-transparent hover:border-[#E9DDD1] transition-colors cursor-pointer flex items-center justify-center"
                title="Đóng thẻ tiếp tục học"
              >
                <X className="w-4 h-4" />
              </button>
            )}
          </div>
        </div>
      </div>

      {/* Modal xác nhận bắt đầu lại từ đầu */}
      {showConfirmRestart && onRestart && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs animate-in fade-in duration-200">
          <div className="bg-card border-2 border-[#E9DDD1] rounded-3xl max-w-md w-full p-6 shadow-xl space-y-4">
            <div className="flex items-center gap-3 text-amber-600">
              <div className="p-2.5 rounded-2xl bg-amber-500/15">
                <RotateCcw className="w-5 h-5 text-amber-700" />
              </div>
              <h3 className="text-base sm:text-lg font-serif font-bold text-title">
                Học lại bài này từ câu 1?
              </h3>
            </div>

            <p className="text-xs sm:text-sm text-body/90 font-serif leading-relaxed">
              Tiến độ của bài này sẽ được đặt lại về câu đầu tiên.
              <br />
              <strong className="text-title font-bold">Lưu ý an toàn:</strong> Toàn bộ câu bạn từng gõ sai vẫn được lưu giữ nguyên vẹn trong khu vực <span className="text-[#B8322D] font-bold">Ôn câu sai</span> để bạn tiếp tục ôn theo phương pháp lặp lại ngắt quãng.
            </p>

            <div className="flex items-center justify-end gap-2.5 pt-2">
              <button
                type="button"
                onClick={() => setShowConfirmRestart(false)}
                className="px-4 py-2 rounded-xl border border-border bg-page text-muted hover:text-title font-serif text-xs transition-colors"
              >
                Hủy bỏ
              </button>
              <button
                type="button"
                onClick={() => {
                  setShowConfirmRestart(false)
                  onRestart(progress)
                }}
                className="px-4 py-2 rounded-xl bg-[#B8322D] hover:bg-[#982923] text-white font-serif font-semibold text-xs transition-colors shadow-2xs"
              >
                Xác nhận bắt đầu lại
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  )
}

