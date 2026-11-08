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
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-white border-2 border-[#182238] rounded-2xl p-3.5 shadow-[0_3px_0_#182238] text-xs">
        {/* Audio Player and Headline */}
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-2">
            <CheckCircle2 className="w-4 h-4 text-[#2E7D32]" />
            <span className="font-bold text-[#182238]">Bản viết hoàn chỉnh</span>
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
          <div className="flex items-center bg-[#FAF7F2] p-1 rounded-xl border border-[#182238]/20">
            <button
              type="button"
              onClick={() => setViewMode('single')}
              className={`flex items-center gap-1 px-3 py-1.5 rounded-lg text-xs font-serif transition-all cursor-pointer ${
                viewMode === 'single'
                  ? 'bg-[#182238] text-white font-bold shadow-2xs'
                  : 'text-muted hover:text-[#182238]'
              }`}
            >
              <FileText className="w-3.5 h-3.5" />
              <span>Bản sửa</span>
            </button>

            <button
              type="button"
              onClick={() => setViewMode('compare')}
              className={`flex items-center gap-1 px-3 py-1.5 rounded-lg text-xs font-serif transition-all cursor-pointer ${
                viewMode === 'compare'
                  ? 'bg-[#182238] text-white font-bold shadow-2xs'
                  : 'text-muted hover:text-[#182238]'
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
            className="h-8 px-3.5 text-xs font-serif font-bold gap-1.5 border-2 border-[#182238] rounded-xl shadow-[0_2px_0_#182238] active:translate-y-0.5 active:shadow-none hover:bg-[#FAF7F2]"
          >
            {copied ? <Check className="w-3.5 h-3.5 text-[#2E7D32]" /> : <Copy className="w-3.5 h-3.5" />}
            <span>{copied ? 'Đã sao chép' : 'Sao chép'}</span>
          </Button>
        </div>
      </div>

      {/* Main Content Area */}
      {viewMode === 'single' ? (
        /* Single Polished View */
        <div className="bg-white border-2 border-[#182238] rounded-3xl p-6 sm:p-8 shadow-[0_4px_0_#182238] relative">
          <div className="flex items-center justify-between mb-3 text-xs text-[#2E7D32] font-sans font-bold">
            <span className="flex items-center gap-1.5">
              <CheckCircle2 className="w-4 h-4 text-[#2E7D32] inline" />
              <span>Văn phong đã được AI tinh chỉnh chuẩn xác:</span>
            </span>
          </div>
          <div className="text-base sm:text-lg font-serif leading-loose text-[#182238] whitespace-pre-wrap select-text">
            {correctedText}
          </div>
        </div>
      ) : (
        /* Side-by-Side Comparison View */
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {/* Left: Original */}
          <div className="bg-white border-2 border-[#182238] rounded-3xl p-5 sm:p-6 shadow-[0_3px_0_#182238] space-y-2">
            <div className="flex items-center justify-between text-xs text-muted font-sans border-b border-[#182238]/15 pb-2">
              <span className="font-bold uppercase tracking-wider text-[#182238]">Bài viết gốc của bạn</span>
              <span>{originalText.length} ký tự</span>
            </div>
            <div className="text-base font-serif leading-loose text-body whitespace-pre-wrap select-text min-h-[160px]">
              {originalText}
            </div>
          </div>

          {/* Right: Corrected */}
          <div className="bg-white border-2 border-[#182238] rounded-3xl p-5 sm:p-6 shadow-[0_3px_0_#182238] space-y-2">
            <div className="flex items-center justify-between text-xs text-[#2E7D32] font-sans border-b border-[#182238]/15 pb-2">
              <span className="font-bold uppercase tracking-wider flex items-center gap-1.5">
                <CheckCircle2 className="w-4 h-4 text-[#2E7D32]" />
                <span>Bản hoàn chỉnh đã sửa</span>
              </span>
              <span>{correctedText.length} ký tự</span>
            </div>
            <div className="text-base font-serif font-bold leading-loose text-[#182238] whitespace-pre-wrap select-text min-h-[160px]">
              {correctedText}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
