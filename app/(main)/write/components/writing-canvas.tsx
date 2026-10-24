'use client'

import { useState, useRef, useEffect } from 'react'
import { 
  BrainCircuit, 
  Loader2, 
  Copy, 
  Trash2, 
  Check, 
  CloudCheck, 
  AlertCircle, 
  BookMarked,
  RotateCcw
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea'
import { toast } from 'sonner'

interface WritingCanvasProps {
  text: string
  setText: (val: string) => void
  level: string
  setLevel: (val: string) => void
  isSubmitting: boolean
  onSubmit: () => void
  errorMsg: string | null
  lastSavedAt: string | null
  onClear: () => void
}

export function WritingCanvas({
  text,
  setText,
  level,
  setLevel,
  isSubmitting,
  onSubmit,
  errorMsg,
  lastSavedAt,
  onClear,
}: WritingCanvasProps) {
  const [copied, setCopied] = useState(false)
  const [showClearConfirm, setShowClearConfirm] = useState(false)
  const isComposingRef = useRef(false)
  const textareaRef = useRef<HTMLTextAreaElement>(null)

  // Real Chinese characters count (Regex \u4e00-\u9fa5)
  const hanziCount = (text.match(/[\u4e00-\u9fa5]/g) || []).length
  const totalLength = text.length
  const isTooLong = totalLength > 5000

  const handleCopy = () => {
    if (!text) return
    navigator.clipboard.writeText(text)
    setCopied(true)
    toast.success('Đã sao chép bài viết vào bộ nhớ tạm')
    setTimeout(() => setCopied(false), 2000)
  }

  const handleConfirmClear = () => {
    onClear()
    setShowClearConfirm(false)
    toast.info('Đã xóa nội dung bài viết')
    textareaRef.current?.focus()
  }

  return (
    <div className="bg-card border border-border rounded-2xl shadow-2xs overflow-hidden font-serif space-y-0">
      {/* 1. Canvas Top Toolbar */}
      <div className="p-3.5 sm:p-4 border-b border-border bg-page/40 flex flex-wrap items-center justify-between gap-3 text-xs">
        {/* HSK Level Selector */}
        <div className="flex items-center gap-2">
          <span className="font-semibold text-title flex items-center gap-1.5">
            <BookMarked className="w-4 h-4 text-app-accent" />
            <span>Mục tiêu trình độ:</span>
          </span>
          <select
            value={level}
            onChange={(e) => setLevel(e.target.value)}
            disabled={isSubmitting}
            className="bg-card border border-border rounded-lg px-2.5 py-1 text-xs font-serif text-title focus:border-app-accent outline-none shadow-2xs cursor-pointer"
          >
            <option value="Chưa xác định">Chưa xác định (Để AI tự đánh giá)</option>
            <option value="HSK 1">HSK 1 (Sơ cấp 1 • 500 từ)</option>
            <option value="HSK 2">HSK 2 (Sơ cấp 2 • 1,272 từ)</option>
            <option value="HSK 3">HSK 3 (Sơ cấp 3 • 2,245 từ)</option>
            <option value="HSK 4">HSK 4 (Trung cấp 4 • 3,245 từ)</option>
            <option value="HSK 5">HSK 5 (Trung cấp 5 • 4,316 từ)</option>
            <option value="HSK 6">HSK 6 (Trung cấp 6 • 5,456 từ)</option>
            <option value="HSK 7-9">HSK 7–9 (Cao cấp • 11,092 từ)</option>
          </select>
        </div>

        {/* Action Controls & Draft Save Indicator */}
        <div className="flex items-center gap-2">
          {lastSavedAt && (
            <div className="hidden sm:flex items-center gap-1 text-[11px] text-muted font-sans mr-1">
              <CloudCheck className="w-3.5 h-3.5 text-jade" />
              <span>Lưu nháp: {lastSavedAt}</span>
            </div>
          )}

          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={handleCopy}
            disabled={!text.trim() || isSubmitting}
            className="h-7 px-2.5 text-xs font-serif border-border hover:border-app-accent gap-1 text-title"
            title="Sao chép bài viết"
          >
            {copied ? <Check className="w-3.5 h-3.5 text-jade" /> : <Copy className="w-3.5 h-3.5" />}
            <span className="hidden sm:inline">{copied ? 'Đã chép' : 'Sao chép'}</span>
          </Button>

          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={() => setShowClearConfirm(true)}
            disabled={!text.trim() || isSubmitting}
            className="h-7 px-2.5 text-xs font-serif border-border hover:border-red-400 text-muted hover:text-red-600 gap-1"
            title="Xóa toàn bộ văn bản"
          >
            <Trash2 className="w-3.5 h-3.5" />
            <span className="hidden sm:inline">Xóa</span>
          </Button>
        </div>
      </div>

      {/* 2. Ruled Notebook Editor Body */}
      <div className="relative bg-[#FCFBF7] p-4 sm:p-6 min-h-[260px] md:min-h-[300px]">
        {/* Subtle Chinese Notebook Margin Lines */}
        <div className="absolute left-6 sm:left-8 top-0 bottom-0 w-[1.5px] bg-red-700/15 pointer-events-none" />
        <div className="absolute left-7 sm:left-9 top-0 bottom-0 w-[1px] bg-red-700/10 pointer-events-none" />

        <Textarea
          ref={textareaRef}
          value={text}
          onChange={(e) => setText(e.target.value)}
          onCompositionStart={() => { isComposingRef.current = true }}
          onCompositionEnd={() => { isComposingRef.current = false }}
          disabled={isSubmitting}
          placeholder="Nhập bài văn hoặc nhật ký tiếng Trung của bạn tại đây... (Ví dụ: 今天早上我七点起床，吃完早饭后去公司上班。天气非常好...)"
          className="w-full min-h-[240px] md:min-h-[280px] pl-6 sm:pl-8 pr-2 py-1 text-base sm:text-lg font-serif resize-y bg-transparent border-none focus-visible:ring-0 leading-loose tracking-wide text-title placeholder:text-muted/50 disabled:opacity-50"
        />
      </div>

      {/* 3. Error Banner if any */}
      {errorMsg && (
        <div className="mx-4 my-2 p-3 bg-red-50 text-red-700 border border-red-200 rounded-xl text-xs flex items-center gap-2">
          <AlertCircle className="w-4 h-4 shrink-0 text-red-600" />
          <span className="leading-relaxed">{errorMsg}</span>
        </div>
      )}

      {/* 4. Canvas Bottom Status & Primary CTA */}
      <div className="p-3.5 sm:p-4 border-t border-border bg-page/30 flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3 text-xs">
        {/* Counters */}
        <div className="flex items-center gap-3 text-muted font-sans text-xs">
          <div className="flex items-center gap-1.5">
            <span className="w-1.5 h-1.5 rounded-full bg-app-accent" />
            <span>Chữ Hán:</span>
            <strong className="text-title font-serif text-sm">{hanziCount}</strong>
          </div>
          <span className="text-border-strong">•</span>
          <div className="flex items-center gap-1.5">
            <span>Tổng ký tự:</span>
            <strong className={`font-serif text-sm ${isTooLong ? 'text-red-600 font-bold' : 'text-title'}`}>
              {totalLength}
            </strong>
            <span className="text-[11px] text-muted">/ 5.000</span>
          </div>
        </div>

        {/* Submit Button */}
        <div className="flex items-center justify-end">
          <Button
            type="button"
            onClick={onSubmit}
            disabled={!text.trim() || isSubmitting || isTooLong}
            className="font-serif text-xs sm:text-sm h-10 px-5 rounded-xl bg-app-accent hover:bg-accent-hover text-white shadow-sm hover:shadow transition-all gap-2 w-full sm:w-auto cursor-pointer"
          >
            {isSubmitting ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                <span>AI đang chấm điểm & sửa lỗi...</span>
              </>
            ) : (
              <>
                <BrainCircuit className="w-4 h-4 text-gold" />
                <span>Phân tích bài viết (AI sửa)</span>
              </>
            )}
          </Button>
        </div>
      </div>

      {/* Clear Confirmation Modal */}
      {showClearConfirm && (
        <div className="fixed inset-0 z-50 bg-black/40 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-card border border-border rounded-2xl max-w-sm w-full p-5 space-y-3.5 shadow-xl animate-in zoom-in-95">
            <h4 className="font-bold text-sm text-title flex items-center gap-2">
              <Trash2 className="w-4 h-4 text-red-600" />
              <span>Xóa nội dung bài viết?</span>
            </h4>
            <p className="text-xs text-muted leading-relaxed">
              Thao tác này sẽ xóa toàn bộ nội dung trong khung soạn thảo. Bản nháp cục bộ cũng sẽ được làm mới.
            </p>
            <div className="flex justify-end gap-2 pt-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setShowClearConfirm(false)}
                className="font-serif text-xs h-8"
              >
                Giữ lại
              </Button>
              <Button
                size="sm"
                onClick={handleConfirmClear}
                className="font-serif text-xs h-8 bg-red-600 hover:bg-red-700 text-white"
              >
                Xác nhận xóa
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
