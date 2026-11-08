'use client'

import { useState } from 'react'
import { XCircle, AlertCircle, CheckCircle, Volume2, Filter } from 'lucide-react'
import { AudioButton } from '@/components/ui/audio-button'

export interface WritingErrorItem {
  original: string
  correction: string
  type: string
  severity: string
  explanation: string
  reason: string
}

interface ResultErrorsProps {
  errors: WritingErrorItem[]
}

const TYPE_TRANSLATIONS: Record<string, string> = {
  grammar: 'Ngữ pháp',
  vocabulary: 'Từ vựng',
  word_order: 'Trật tự từ',
  naturalness: 'Độ tự nhiên',
  coherence: 'Tính mạch lạc',
  punctuation: 'Dấu câu',
}

export function ResultErrors({ errors }: ResultErrorsProps) {
  const [filter, setFilter] = useState<'all' | 'error' | 'suggestion'>('all')

  const totalErrors = errors.filter((e) => e.severity === 'error').length
  const totalSuggestions = errors.filter((e) => e.severity === 'suggestion').length

  const filteredErrors = errors.filter((err) => {
    if (filter === 'error') return err.severity === 'error'
    if (filter === 'suggestion') return err.severity === 'suggestion'
    return true
  })

  if (!errors || errors.length === 0) {
    return (
      <div className="bg-card border border-border rounded-2xl p-8 sm:p-12 text-center space-y-3 font-serif">
        <div className="w-14 h-14 rounded-full bg-emerald-50 text-emerald-600 flex items-center justify-center mx-auto border border-emerald-200">
          <CheckCircle className="w-8 h-8" />
        </div>
        <h3 className="text-base font-bold text-title">Không phát hiện lỗi đáng kể nào!</h3>
        <p className="text-xs text-muted max-w-md mx-auto leading-relaxed">
          Bài viết của bạn dùng từ rất chuẩn xác, cấu trúc ngữ pháp mạch lạc và diễn đạt tự nhiên theo tiêu chuẩn HSK.
        </p>
      </div>
    )
  }

  return (
    <div className="space-y-4 font-serif">
      {/* Filters Toolbar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-white border-2 border-[#182238] rounded-2xl p-3.5 shadow-[0_3px_0_#182238] text-xs">
        <div className="flex items-center gap-1.5 text-[#182238] font-bold font-serif">
          <Filter className="w-4 h-4 text-[#B8322D]" />
          <span>Bộ lọc phân loại ({errors.length} mục):</span>
        </div>

        <div className="flex items-center gap-1.5">
          <button
            type="button"
            onClick={() => setFilter('all')}
            className={`px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer ${
              filter === 'all'
                ? 'bg-[#182238] text-white shadow-2xs'
                : 'bg-white text-[#182238] border border-[#182238]/20 hover:border-[#182238]'
            }`}
          >
            Tất cả ({errors.length})
          </button>

          <button
            type="button"
            onClick={() => setFilter('error')}
            className={`px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer ${
              filter === 'error'
                ? 'bg-[#B8322D] text-white shadow-2xs'
                : 'bg-white text-[#B8322D] border border-[#B8322D]/30 hover:border-[#B8322D]'
            }`}
          >
            Lỗi sai ({totalErrors})
          </button>

          <button
            type="button"
            onClick={() => setFilter('suggestion')}
            className={`px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer ${
              filter === 'suggestion'
                ? 'bg-[#D97706] text-white shadow-2xs'
                : 'bg-white text-[#D97706] border border-[#D97706]/30 hover:border-[#D97706]'
            }`}
          >
            Gợi ý diễn đạt ({totalSuggestions})
          </button>
        </div>
      </div>

      {/* Error Cards List */}
      <div className="space-y-3.5">
        {filteredErrors.map((err, idx) => {
          const isError = err.severity === 'error'
          const typeName = TYPE_TRANSLATIONS[err.type] || err.type

          return (
            <div
              key={idx}
              className="bg-white border-2 border-[#182238] rounded-3xl p-5 sm:p-6 shadow-[0_4px_0_#182238] space-y-3 transition-all"
            >
              {/* Card Header: Type & Severity Badge */}
              <div className="flex items-center justify-between gap-2 flex-wrap">
                <div className="flex items-center gap-2">
                  <span
                    className={`inline-flex items-center gap-1 text-[11px] font-sans font-bold uppercase tracking-wider px-2 py-0.5 rounded-md ${
                      isError
                        ? 'bg-red-100 text-red-700 border border-red-200'
                        : 'bg-amber-100 text-amber-800 border border-amber-200'
                    }`}
                  >
                    {isError ? <XCircle className="w-3 h-3" /> : <AlertCircle className="w-3 h-3" />}
                    <span>{isError ? 'Lỗi cần sửa' : 'Gợi ý nâng cao'}</span>
                  </span>

                  <span className="text-[11px] font-sans bg-page text-muted px-2 py-0.5 rounded-md border border-border">
                    {typeName}
                  </span>
                </div>

                {err.reason && (
                  <span className="text-xs text-muted font-sans italic">
                    {err.reason}
                  </span>
                )}
              </div>

              {/* Comparison: Original vs Corrected */}
              <div className="space-y-2">
                {/* Original (with strikethrough/highlight) */}
                <div className="p-3 bg-red-50/40 rounded-xl border border-red-100 flex items-start gap-2.5">
                  <XCircle className="w-4 h-4 text-red-500 shrink-0 mt-1" />
                  <div className="text-sm sm:text-base font-serif text-slate-600 line-through decoration-red-400">
                    {err.original}
                  </div>
                </div>

                {/* Corrected with audio button */}
                <div className="p-3 bg-emerald-50/60 rounded-xl border border-emerald-200/80 flex items-center justify-between gap-2.5">
                  <div className="flex items-start gap-2.5 min-w-0">
                    <CheckCircle className="w-4 h-4 text-emerald-600 shrink-0 mt-1" />
                    <div className="text-sm sm:text-base font-serif font-bold text-title">
                      {err.correction}
                    </div>
                  </div>
                  <AudioButton
                    text={err.correction}
                    id={`err-corr-${idx}`}
                    size="xs"
                    variant="ghost"
                    tooltip="Nghe câu chuẩn"
                  />
                </div>
              </div>

              {/* Explanation in Vietnamese */}
              {err.explanation && (
                <div className="pt-2 border-t border-border/60 text-xs text-body leading-relaxed flex items-start gap-2">
                  <span className="font-bold text-title shrink-0">Giải thích:</span>
                  <span>{err.explanation}</span>
                </div>
              )}
            </div>
          )
        })}
      </div>
    </div>
  )
}
