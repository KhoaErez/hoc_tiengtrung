'use client'

import { useState } from 'react'
import { 
  CheckCircle2, 
  Copy, 
  Check, 
  Columns, 
  FileText, 
  ArrowRight
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { PassageAudioPlayer } from '@/components/ui/passage-audio-player'
import { toast } from 'sonner'

interface ResultPolishedProps {
  originalText: string
  correctedText: string
}

export function ResultPolished({ originalText, correctedText }: ResultPolishedProps) {
  const [copied, setCopied] = useState(false)
  const [viewMode, setViewMode] = useState<'single' | 'compare'>('single')

  const handleCopy = () => {
    if (!correctedText) return
    navigator.clipboard.writeText(correctedText)
    setCopied(true)
    toast.success('Đã sao chép toàn bộ bài viết đã sửa!')
    setTimeout(() => setCopied(false), 2000)
  }

  return (
    <div className="space-y-4 font-serif">
      {/* Controls Bar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-card border border-border rounded-xl p-3 shadow-2xs text-xs">
        {/* Audio Player and Headline */}
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-2">
            <CheckCircle2 className="w-4 h-4 text-emerald-600" />
            <span className="font-bold text-title">Bản viết hoàn chỉnh</span>
          </div>

          <PassageAudioPlayer
            text={correctedText}
            title="Luyện nghe bài viết hoàn chỉnh"
            id="polished-full-audio"
            compact
          />
        </div>

        {/* View Mode Toggle & Copy Button */}
        <div className="flex items-center gap-2">
          {/* Mode Toggle */}
          <div className="flex items-center bg-page p-0.5 rounded-lg border border-border">
            <button
              type="button"
              onClick={() => setViewMode('single')}
              className={`flex items-center gap-1 px-2.5 py-1 rounded-md text-xs font-serif transition-colors cursor-pointer ${
                viewMode === 'single'
                  ? 'bg-card text-title font-bold shadow-2xs'
                  : 'text-muted hover:text-title'
              }`}
            >
              <FileText className="w-3.5 h-3.5" />
              <span>Bản sửa</span>
            </button>

            <button
              type="button"
              onClick={() => setViewMode('compare')}
              className={`flex items-center gap-1 px-2.5 py-1 rounded-md text-xs font-serif transition-colors cursor-pointer ${
                viewMode === 'compare'
                  ? 'bg-card text-title font-bold shadow-2xs'
                  : 'text-muted hover:text-title'
              }`}
            >
              <Columns className="w-3.5 h-3.5" />
              <span>So sánh song song</span>
            </button>
          </div>

          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={handleCopy}
            className="h-7 px-3 text-xs font-serif gap-1 border-border hover:border-app-accent"
          >
            {copied ? <Check className="w-3.5 h-3.5 text-jade" /> : <Copy className="w-3.5 h-3.5" />}
            <span>{copied ? 'Đã sao chép' : 'Sao chép'}</span>
          </Button>
        </div>
      </div>

      {/* Main Content Area */}
      {viewMode === 'single' ? (
        /* Single Polished View */
        <div className="bg-emerald-50/40 border border-emerald-200/80 rounded-2xl p-5 sm:p-7 shadow-2xs relative">
          <div className="flex items-center justify-between mb-3 text-xs text-emerald-800 font-sans font-semibold">
            <span className="flex items-center gap-1.5">
              <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600 inline" />
              <span>Văn phong đã được AI tinh chỉnh chuẩn xác:</span>
            </span>
          </div>
          <div className="text-base sm:text-lg font-serif leading-loose text-title whitespace-pre-wrap select-text">
            {correctedText}
          </div>
        </div>
      ) : (
        /* Side-by-Side Comparison View */
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {/* Left: Original */}
          <div className="bg-card border border-border rounded-2xl p-4 sm:p-5 shadow-2xs space-y-2">
            <div className="flex items-center justify-between text-xs text-muted font-sans border-b border-border pb-2">
              <span className="font-bold uppercase tracking-wider">Bài viết gốc của bạn</span>
              <span>{originalText.length} ký tự</span>
            </div>
            <div className="text-base font-serif leading-loose text-body whitespace-pre-wrap select-text min-h-[160px]">
              {originalText}
            </div>
          </div>

          {/* Right: Corrected */}
          <div className="bg-emerald-50/40 border border-emerald-200/80 rounded-2xl p-4 sm:p-5 shadow-2xs space-y-2">
            <div className="flex items-center justify-between text-xs text-emerald-800 font-sans border-b border-emerald-200 pb-2">
              <span className="font-bold uppercase tracking-wider flex items-center gap-1.5">
                <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600" />
                <span>Bản hoàn chỉnh đã sửa</span>
              </span>
              <span>{correctedText.length} ký tự</span>
            </div>
            <div className="text-base font-serif font-medium leading-loose text-title whitespace-pre-wrap select-text min-h-[160px]">
              {correctedText}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
