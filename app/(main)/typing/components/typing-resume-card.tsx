'use client'

import React, { useState } from 'react'
import { RotateCcw, ArrowRight, X, History } from 'lucide-react'
import { TypingProgressDTO } from '../actions'

interface TypingResumeCardProps {
  progress: TypingProgressDTO
  onResume: (progress: TypingProgressDTO) => void
  onRestart?: (progress: TypingProgressDTO) => void
  onDismiss?: () => void
}

/**
 * Chuẩn hóa tên bài học hiển thị thân thiện, tuyệt đối không lộ slug/ID kỹ thuật (vd: hsk3-all -> HSK 3 - Tất cả bài học)
 */
export function formatFriendlyLessonName(progress: TypingProgressDTO): string {
  const rawId = (progress.exerciseId || '').trim()
  const rawTitle = (progress.lessonTitle || '').trim()

  const hskAllMatch = rawId.match(/^hsk(\d+)-all$/i)
  if (hskAllMatch) {
    if (
      rawTitle &&
      !/^hsk\s*\d+(-all)?$/i.test(rawTitle) &&
      !/^[0-9a-f-]{8,}$/i.test(rawTitle) &&
      !/^hsk\d+-/i.test(rawTitle)
    ) {
      return rawTitle
    }
    return `HSK ${hskAllMatch[1]} - Tất cả bài học`
  }

  const looksLikeRawSlug =
    !rawTitle ||
    /^hsk\d+-/i.test(rawTitle) ||
    /^[0-9a-f-]{12,}$/i.test(rawTitle) ||
    /^(par|sent|trans)-/i.test(rawTitle)

  if (!looksLikeRawSlug) {
    if (progress.hskLevel && !/^hsk\s*\d+/i.test(rawTitle)) {
      return `HSK ${progress.hskLevel} · ${rawTitle}`
    }
    return rawTitle
  }

  if (progress.hskLevel) {
    return progress.lessonId
      ? `HSK ${progress.hskLevel}`
      : `HSK ${progress.hskLevel} - Tất cả bài học`
  }

  const isTranslate =
    progress.practiceMode === 'translate' || progress.mode === 'translate_hsk'
  if (isTranslate) return 'Dịch Việt → Gõ Hán'
  if (progress.mode === 'paragraph') return 'Luyện gõ đoạn văn'
  if (progress.mode === 'sentence') return 'Câu mẫu luyện gõ'
  return 'Bài luyện tập gần nhất'
}

export default function TypingResumeCard({
  progress,
  onResume,
  onRestart,
  onDismiss,
}: TypingResumeCardProps) {
  const [showConfirmRestart, setShowConfirmRestart] = useState(false)

  const percent = Math.min(
    100,
    Math.round(((progress.completedSentences || 0) / Math.max(1, progress.totalSentences || 1)) * 100)
  )

  const questionIndex = (progress.currentSentenceIndex || 0) + 1
  const friendlyLesson = formatFriendlyLessonName(progress)

  return (
    <>
      {/* Slim Banner 1 dòng tinh gọn, viền mảnh nhẹ nhàng, không làm rối card chính */}
      <div className="w-full rounded-xl border border-amber-300/80 dark:border-amber-700/50 bg-[#FFFBF2] dark:bg-amber-950/30 px-3 py-2 flex flex-wrap sm:flex-nowrap items-center justify-between gap-2 text-xs font-serif animate-in fade-in duration-200">
        <div className="flex items-center gap-2 min-w-0 flex-1">
          <History className="w-3.5 h-3.5 text-amber-600 dark:text-amber-400 shrink-0" />
          <p className="text-[#182238] dark:text-slate-200 truncate">
            Đang dừng ở <strong className="font-bold">Câu {questionIndex}</strong>{' '}
            <span className="text-muted font-sans">
              ({friendlyLesson} · {percent}%)
            </span>
          </p>
        </div>

        <div className="flex items-center gap-1.5 shrink-0 ml-auto">
          <button
            type="button"
            onClick={() => onResume(progress)}
            className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-[#B8322D] hover:bg-[#982923] text-white text-xs font-serif font-bold transition-colors cursor-pointer whitespace-nowrap"
          >
            <span>Tiếp tục</span>
            <ArrowRight className="w-3 h-3" />
          </button>

          {onRestart && (
            <button
              type="button"
              onClick={() => setShowConfirmRestart(true)}
              className="inline-flex items-center gap-1 px-2 py-1 rounded-lg border border-amber-300/80 dark:border-white/15 bg-white/80 dark:bg-[#202B45] hover:bg-white text-[#182238]/85 dark:text-slate-200 text-xs font-serif transition-colors cursor-pointer whitespace-nowrap"
              title="Bắt đầu lại từ đầu"
            >
              <RotateCcw className="w-3 h-3" />
              <span>Làm lại</span>
            </button>
          )}

          {onDismiss && (
            <button
              type="button"
              onClick={onDismiss}
              className="p-1 rounded-lg text-muted hover:text-title hover:bg-black/5 dark:hover:bg-white/10 transition-colors cursor-pointer"
              title="Đóng thông báo tiếp tục học"
              aria-label="Đóng thông báo tiếp tục học"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          )}
        </div>
      </div>

      {/* Modal xác nhận bắt đầu lại từ đầu */}
      {showConfirmRestart && onRestart && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs animate-in fade-in duration-200">
          <div className="bg-card border border-[#E5E7EB] dark:border-white/15 rounded-2xl max-w-md w-full p-5 shadow-xl space-y-4">
            <div className="flex items-center gap-3 text-amber-600">
              <div className="p-2 rounded-xl bg-amber-500/15">
                <RotateCcw className="w-5 h-5 text-amber-700" />
              </div>
              <h3 className="text-base font-serif font-bold text-title">
                Học lại bài này từ câu 1?
              </h3>
            </div>

            <p className="text-xs sm:text-sm text-body/90 font-serif leading-relaxed">
              Tiến độ của bài này sẽ được đặt lại về câu đầu tiên.
              <br />
              <strong className="text-title font-bold">Lưu ý an toàn:</strong> Toàn bộ câu bạn từng gõ sai vẫn được lưu giữ nguyên vẹn trong khu vực{' '}
              <span className="text-[#B8322D] font-bold">Ôn câu sai</span>.
            </p>

            <div className="flex items-center justify-end gap-2 pt-1">
              <button
                type="button"
                onClick={() => setShowConfirmRestart(false)}
                className="px-3.5 py-1.5 rounded-xl border border-border bg-page text-muted hover:text-title font-serif text-xs transition-colors cursor-pointer"
              >
                Hủy bỏ
              </button>
              <button
                type="button"
                onClick={() => {
                  setShowConfirmRestart(false)
                  onRestart(progress)
                }}
                className="px-3.5 py-1.5 rounded-xl bg-[#B8322D] hover:bg-[#982923] text-white font-serif font-semibold text-xs transition-colors cursor-pointer"
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
