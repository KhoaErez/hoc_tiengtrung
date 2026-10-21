'use client'

import React, { useState } from 'react'
import { Bookmark, Play, RotateCcw, X, AlertTriangle, CheckCircle2 } from 'lucide-react'
import { Button } from '@/components/ui/button'

interface TypingResumeBannerProps {
  currentSentenceIndex: number
  totalSentences: number
  completedSentences: number
  correctSentences: number
  onResume: () => void
  onRestart: () => void
  onDismiss?: () => void
}

export default function TypingResumeBanner({
  currentSentenceIndex,
  totalSentences,
  completedSentences,
  correctSentences,
  onResume,
  onRestart,
  onDismiss,
}: TypingResumeBannerProps) {
  const [showConfirmRestart, setShowConfirmRestart] = useState(false)
  const percent = Math.min(100, Math.round((completedSentences / Math.max(1, totalSentences)) * 100))

  return (
    <>
      <div className="relative overflow-hidden bg-gradient-to-r from-amber-500/15 via-amber-500/5 to-transparent border border-amber-500/35 dark:border-amber-500/25 rounded-2xl p-4 md:p-5 shadow-xs transition-all animate-in fade-in slide-in-from-top-2 duration-300">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="flex items-start gap-3.5">
            <div className="p-2.5 rounded-xl bg-amber-500/20 text-amber-800 dark:text-amber-300 shrink-0 mt-0.5">
              <Bookmark className="w-5 h-5" />
            </div>
            <div>
              <div className="flex items-center gap-2 flex-wrap">
                <h4 className="text-sm md:text-base font-serif font-bold text-title">
                  Khôi phục tiến độ học tập
                </h4>
                <span className="px-2 py-0.5 rounded-full text-[11px] font-sans font-semibold bg-amber-500/20 text-amber-800 dark:text-amber-300 border border-amber-500/30">
                  Câu {currentSentenceIndex + 1}/{totalSentences} ({percent}%)
                </span>
              </div>
              <p className="text-xs text-muted font-sans mt-1">
                Bạn đang học dở bài này. Đã hoàn thành {completedSentences} câu ({correctSentences} câu đúng).
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2 self-end sm:self-center shrink-0">
            <button
              onClick={() => setShowConfirmRestart(true)}
              className="flex items-center gap-1.5 px-3 py-2 rounded-xl border border-border/80 bg-card/80 hover:bg-card text-muted hover:text-title text-xs font-serif transition-colors"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              <span>Bắt đầu lại</span>
            </button>

            <button
              onClick={onResume}
              className="flex items-center gap-1.5 px-4 py-2 rounded-xl bg-app-accent hover:bg-accent-hover text-white text-xs md:text-sm font-serif font-semibold shadow-xs transition-all"
            >
              <Play className="w-3.5 h-3.5 fill-current" />
              <span>Tiếp tục câu {currentSentenceIndex + 1}</span>
            </button>

            {onDismiss && (
              <button
                onClick={onDismiss}
                className="p-1.5 rounded-lg text-muted hover:text-title hover:bg-page transition-colors"
                title="Đóng thông báo"
              >
                <X className="w-4 h-4" />
              </button>
            )}
          </div>
        </div>
      </div>

      {/* Modal xác nhận bắt đầu lại */}
      {showConfirmRestart && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs animate-in fade-in duration-200">
          <div className="bg-card border border-border rounded-2xl max-w-md w-full p-6 shadow-xl space-y-4">
            <div className="flex items-center gap-3 text-amber-600 dark:text-amber-400">
              <div className="p-2.5 rounded-xl bg-amber-500/15">
                <AlertTriangle className="w-5 h-5" />
              </div>
              <h3 className="text-base font-serif font-bold text-title">
                Bắt đầu lại từ câu 1?
              </h3>
            </div>

            <p className="text-xs md:text-sm text-body/90 font-serif leading-relaxed">
              Tiến độ của bài này sẽ được đặt lại về đầu.
              <br />
              <strong className="text-title">Lưu ý an toàn:</strong> Toàn bộ các câu bạn từng gõ sai vẫn được lưu giữ nguyên vẹn trong khu vực <span className="text-app-accent font-semibold">Ôn câu sai</span> để bạn có thể tiếp tục rèn luyện.
            </p>

            <div className="flex items-center justify-end gap-2.5 pt-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setShowConfirmRestart(false)}
                className="rounded-xl font-serif text-xs"
              >
                Hủy bỏ
              </Button>
              <Button
                variant="destructive"
                size="sm"
                onClick={() => {
                  setShowConfirmRestart(false)
                  onRestart()
                }}
                className="bg-app-accent hover:bg-accent-hover rounded-xl font-serif text-xs text-white"
              >
                Xác nhận bắt đầu lại
              </Button>
            </div>
          </div>
        </div>
      )}
    </>
  )
}
