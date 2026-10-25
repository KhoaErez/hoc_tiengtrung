'use client'

import React, { useState } from 'react'
import { Copy, Check, ChevronDown, ChevronUp, GraduationCap, BookOpen } from 'lucide-react'
import { toast } from 'sonner'
import { AudioButton } from '@/components/ui/audio-button'
import type { GrammarItemWithExamples } from '@/app/(main)/grammar/actions'

interface GrammarCardProps {
  item: GrammarItemWithExamples
  isMastered?: boolean
  onToggleMastered?: (orderIndex: number) => void
}

// Bảng màu sắc tương phản cao, rõ ràng và học thuật cho từng nhóm chuyên đề ngữ pháp
const CATEGORY_STYLES: Record<string, { bg: string; text: string; border: string }> = {
  'Đại từ': { bg: 'bg-blue-100/90 dark:bg-blue-950/80', text: 'text-blue-900 dark:text-blue-200', border: 'border-blue-300 dark:border-blue-700' },
  'Số từ': { bg: 'bg-emerald-100/90 dark:bg-emerald-950/80', text: 'text-emerald-900 dark:text-emerald-200', border: 'border-emerald-300 dark:border-emerald-700' },
  'Lượng từ': { bg: 'bg-amber-100/90 dark:bg-amber-950/80', text: 'text-amber-950 dark:text-amber-200', border: 'border-amber-300 dark:border-amber-700' },
  'Phó từ': { bg: 'bg-purple-100/90 dark:bg-purple-950/80', text: 'text-purple-900 dark:text-purple-200', border: 'border-purple-300 dark:border-purple-700' },
  'Cấu trúc câu': { bg: 'bg-rose-100/90 dark:bg-rose-950/80', text: 'text-rose-950 dark:text-rose-200', border: 'border-rose-300 dark:border-rose-700' },
  'Động từ': { bg: 'bg-cyan-100/90 dark:bg-cyan-950/80', text: 'text-cyan-950 dark:text-cyan-200', border: 'border-cyan-300 dark:border-cyan-700' },
  'Động từ năng nguyện': { bg: 'bg-indigo-100/90 dark:bg-indigo-950/80', text: 'text-indigo-900 dark:text-indigo-200', border: 'border-indigo-300 dark:border-indigo-700' },
  'Giới từ': { bg: 'bg-teal-100/90 dark:bg-teal-950/80', text: 'text-teal-950 dark:text-teal-200', border: 'border-teal-300 dark:border-teal-700' },
  'Liên từ': { bg: 'bg-orange-100/90 dark:bg-orange-950/80', text: 'text-orange-950 dark:text-orange-200', border: 'border-orange-300 dark:border-orange-700' },
  'Trợ từ': { bg: 'bg-pink-100/90 dark:bg-pink-950/80', text: 'text-pink-950 dark:text-pink-200', border: 'border-pink-300 dark:border-pink-700' },
  'Câu hỏi': { bg: 'bg-violet-100/90 dark:bg-violet-950/80', text: 'text-violet-950 dark:text-violet-200', border: 'border-violet-300 dark:border-violet-700' },
  'Quy tắc biểu đạt': { bg: 'bg-sky-100/90 dark:bg-sky-950/80', text: 'text-sky-950 dark:text-sky-200', border: 'border-sky-300 dark:border-sky-700' },
}

/**
 * Hàm định dạng giải thích: Tách các đoạn chữ Hán và dấu ngoặc kép để luôn render với font-hanzi chuẩn,
 * triệt tiêu hoàn toàn hiện tượng ô vuông / lỗi font trên mọi hệ điều hành.
 */
function renderExplanationText(text: string) {
  if (!text) return null
  // Regex tách chữ Hán (CJK Unified Ideographs: \u4e00-\u9fa5) và cụm từ tiếng Trung
  const parts = text.split(/([\u4e00-\u9fa5]+|"[^"]*")/g)

  return parts.map((part, index) => {
    if (!part) return null
    const isChinese = /[\u4e00-\u9fa5]/.test(part)
    if (isChinese) {
      return (
        <span
          key={index}
          className="font-hanzi font-semibold text-[#0F172A] dark:text-white px-0.5"
        >
          {part}
        </span>
      )
    }
    return <React.Fragment key={index}>{part}</React.Fragment>
  })
}

export function GrammarCard({ item, isMastered = false, onToggleMastered }: GrammarCardProps) {
  const [copiedPattern, setCopiedPattern] = useState(false)
  const [isExpanded, setIsExpanded] = useState(true)

  const catStyle = CATEGORY_STYLES[item.category] || {
    bg: 'bg-[#B8322D]/10 dark:bg-[#B8322D]/20',
    text: 'text-[#B8322D] dark:text-[#E27D60]',
    border: 'border-[#B8322D]/30 dark:border-[#B8322D]/40',
  }

  const handleCopyPattern = () => {
    navigator.clipboard.writeText(item.pattern)
    setCopiedPattern(true)
    toast.success('Đã sao chép công thức ngữ pháp!')
    setTimeout(() => setCopiedPattern(false), 2000)
  }

  const handleCopySentence = (text: string) => {
    navigator.clipboard.writeText(text)
    toast.success('Đã sao chép câu ví dụ!')
  }

  return (
    <article
      id={`grammar-point-${item.order_index}`}
      className={`group relative bg-white dark:bg-[#1B222C] border-2 transition-all duration-300 rounded-2xl overflow-hidden shadow-sm ${
        isMastered
          ? 'border-emerald-500/60 bg-emerald-50/[0.12] dark:bg-emerald-950/[0.1]'
          : 'border-[#E9DDD1] dark:border-slate-700/80 hover:border-[#B8322D]/60 hover:shadow-md'
      }`}
    >
      {/* Top Banner Accent Line */}
      <div
        className={`h-1.5 w-full ${
          isMastered
            ? 'bg-gradient-to-r from-emerald-600 via-teal-500 to-emerald-400'
            : 'bg-gradient-to-r from-[#B8322D] via-[#D97706] to-[#B8322D]/40'
        }`}
      />

      <div className="p-5 md:p-6 space-y-4 sm:space-y-5">
        {/* Header: Số thứ tự, Thể loại, Cấp độ, Trạng thái đã học */}
        <div className="flex items-start justify-between gap-3 flex-wrap sm:flex-nowrap">
          <div className="flex items-center gap-2 flex-wrap">
            {/* Badge STT */}
            <span className="inline-flex items-center justify-center min-w-[38px] h-8 px-2.5 rounded-lg bg-[#B8322D] text-white font-mono font-bold text-xs shadow-2xs">
              #{String(item.order_index).padStart(2, '0')}
            </span>

            {/* Pill Phân loại */}
            <span
              className={`inline-flex items-center px-3 py-1 rounded-lg text-xs font-bold border ${catStyle.bg} ${catStyle.text} ${catStyle.border} shadow-2xs`}
            >
              {item.category}
            </span>

            {/* Cấp độ HSK */}
            <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs font-semibold bg-[#FAF4ED] dark:bg-slate-800 text-[#78350F] dark:text-amber-300 border border-[#E4D4C5] dark:border-slate-700 shadow-2xs">
              <GraduationCap className="w-3.5 h-3.5 text-amber-600 dark:text-amber-400" />
              <span>HSK 1</span>
            </span>
          </div>

          {/* Nút đánh dấu đã nắm vững */}
          <button
            type="button"
            onClick={() => onToggleMastered?.(item.order_index)}
            aria-label={isMastered ? 'Đánh dấu chưa thuộc' : 'Đánh dấu đã nắm vững'}
            className={`inline-flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-bold transition-all cursor-pointer shadow-2xs touch-manipulation min-h-[40px] ${
              isMastered
                ? 'bg-emerald-600 border-2 border-emerald-600 text-white'
                : 'bg-white dark:bg-slate-800 border-2 border-[#DAC7B6] dark:border-slate-700 text-[#475569] dark:text-slate-300 hover:border-emerald-600 hover:text-emerald-700 hover:bg-emerald-50 dark:hover:bg-emerald-950/40'
            }`}
          >
            <Check className={`w-4 h-4 ${isMastered ? 'text-white' : 'text-slate-400'}`} />
            <span>{isMastered ? 'Đã thuộc' : 'Đánh dấu đã học'}</span>
          </button>
        </div>

        {/* Tên Điểm Ngữ Pháp */}
        <div>
          <h2 className="text-xl sm:text-2xl font-serif font-bold text-[#1E293B] dark:text-white tracking-tight leading-snug">
            {item.name}
          </h2>
        </div>

        {/* Khối CÔNG THỨC / CẤU TRÚC NGỮ PHÁP (Nổi bật, độ tương phản cao, dễ scan nhanh) */}
        <div className="relative rounded-xl bg-[#FFF9F3] dark:bg-[#141A23] border-2 border-[#EADCCF] dark:border-[#334155] p-4 sm:p-4.5 shadow-2xs transition-all space-y-2">
          <div className="flex items-center justify-between gap-3">
            <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded text-[11px] font-bold uppercase tracking-wider bg-[#B8322D] text-white shadow-2xs">
              <BookOpen className="w-3 h-3 text-amber-200" />
              Cấu trúc ngữ pháp
            </span>
            <button
              type="button"
              onClick={handleCopyPattern}
              title="Sao chép công thức"
              className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md text-xs font-semibold bg-white dark:bg-slate-800 border border-[#DAC7B6] dark:border-slate-700 text-[#334155] dark:text-[#E2E8F0] hover:text-[#B8322D] hover:border-[#B8322D]/60 hover:bg-[#FFF9F3] transition-all shadow-2xs cursor-pointer"
            >
              {copiedPattern ? (
                <>
                  <Check className="w-3.5 h-3.5 text-emerald-600" />
                  <span className="text-emerald-700 font-bold">Đã chép</span>
                </>
              ) : (
                <>
                  <Copy className="w-3.5 h-3.5" />
                  <span>Sao chép</span>
                </>
              )}
            </button>
          </div>
          <div className="pt-1">
            <code className="text-base sm:text-lg md:text-xl font-hanzi font-bold text-[#0F172A] dark:text-[#F8FAFC] tracking-wide whitespace-pre-wrap select-all leading-relaxed block">
              {item.pattern}
            </code>
          </div>
        </div>

        {/* Giải thích tiếng Việt (Tăng line-height, chữ rõ hơn, highlight chữ Hán sạch sẽ) */}
        <div className="text-sm sm:text-base leading-relaxed text-[#243047] dark:text-[#CBD5E1] font-sans whitespace-pre-line">
          {renderExplanationText(item.explanation_vi)}
        </div>

        {/* Khối các câu ví dụ thực tế */}
        {item.examples && item.examples.length > 0 && (
          <div className="pt-3 border-t-2 border-[#E9DDD1] dark:border-slate-700/80 space-y-3">
            <div className="flex items-center justify-between">
              <span className="text-xs font-bold uppercase tracking-wider text-[#64748B] dark:text-slate-400 flex items-center gap-1.5">
                <BookOpen className="w-4 h-4 text-[#B8322D]" />
                <span>Câu ví dụ mẫu ({item.examples.length})</span>
              </span>
              <button
                type="button"
                onClick={() => setIsExpanded(!isExpanded)}
                className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-[#F4ECE3] dark:bg-slate-800 text-[#334155] dark:text-[#E2E8F0] border border-[#E2D4C6] dark:border-slate-700 hover:border-[#B8322D] hover:text-[#B8322D] transition-colors cursor-pointer shadow-2xs touch-manipulation min-h-[36px]"
              >
                <span>{isExpanded ? 'Thu gọn' : 'Xem chi tiết'}</span>
                {isExpanded ? <ChevronUp className="w-3.5 h-3.5" /> : <ChevronDown className="w-3.5 h-3.5" />}
              </button>
            </div>

            {isExpanded && (
              <div className="space-y-3 pt-1">
                {item.examples.map((ex, exIdx) => (
                  <div
                    key={exIdx}
                    className="p-4 sm:p-4.5 rounded-xl bg-[#FAF7F2] dark:bg-[#141A23] border-2 border-[#E9DDD1] dark:border-slate-700/80 hover:border-[#B8322D]/50 transition-colors space-y-3 shadow-2xs"
                  >
                    {/* Hán tự và Nút Audio TTS */}
                    <div className="flex items-start justify-between gap-3">
                      <div className="space-y-1.5">
                        <div className="text-xl sm:text-2xl font-hanzi font-bold text-[#0F172A] dark:text-white tracking-wide leading-snug">
                          {ex.chinese}
                        </div>
                        {/* Pinyin tương phản cao, dấu thanh điệu to rõ ràng */}
                        <div className="text-sm sm:text-base font-sans font-bold text-app-accent dark:text-[#FBBF24] tracking-wide">
                          {ex.pinyin}
                        </div>
                      </div>

                      <div className="flex items-center gap-1.5 shrink-0 pt-0.5">
                        <AudioButton
                          text={ex.chinese}
                          id={`ex-${item.order_index}-${exIdx}`}
                          size="sm"
                          variant="outline"
                          tooltip="Phát âm câu ví dụ"
                          className="bg-white dark:bg-slate-800 border-[#DAC7B6] dark:border-slate-700 shadow-2xs hover:border-[#B8322D] hover:text-[#B8322D]"
                        />
                        <button
                          type="button"
                          onClick={() => handleCopySentence(ex.chinese)}
                          title="Sao chép câu"
                          className="p-2 rounded-lg bg-white dark:bg-slate-800 border border-[#DAC7B6] dark:border-slate-700 text-[#475569] dark:text-slate-300 hover:text-[#B8322D] hover:border-[#B8322D]/50 transition-colors shadow-2xs cursor-pointer touch-manipulation min-h-[36px] min-w-[36px] flex items-center justify-center"
                        >
                          <Copy className="w-3.5 h-3.5" />
                        </button>
                      </div>
                    </div>

                    {/* Dịch nghĩa tiếng Việt */}
                    <div className="text-sm sm:text-base text-[#1E293B] dark:text-[#F1F5F9] font-sans font-medium pl-3.5 border-l-[3.5px] border-[#B8322D] leading-relaxed">
                      {ex.translation_vi}
                    </div>

                    {/* Ghi chú ngữ pháp bổ trợ */}
                    {ex.explanation && (
                      <div className="text-xs sm:text-sm text-[#78350F] dark:text-amber-200 font-sans bg-amber-100/70 dark:bg-amber-950/40 border border-amber-300 dark:border-amber-800/60 p-3 rounded-lg flex items-start gap-2.5 leading-relaxed shadow-2xs">
                        <span className="shrink-0 text-sm">💡</span>
                        <span>{ex.explanation}</span>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    </article>
  )
}
