'use client'

import { useState, useEffect, useRef } from 'react'
import { usePathname } from 'next/navigation'
import { 
  MessageSquareQuote, 
  X, 
  Send, 
  CheckCircle2, 
  AlertCircle, 
  Bug, 
  Lightbulb, 
  Palette, 
  BookOpen, 
  HelpCircle,
  Loader2,
  ChevronLeft
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { submitFeedbackAction, FeedbackCategory } from '@/app/actions/feedback'

const CATEGORIES: {
  id: FeedbackCategory
  label: string
  icon: typeof Bug
  placeholder: string
  color: string
}[] = [
  {
    id: 'bug',
    label: 'Báo lỗi website',
    icon: Bug,
    placeholder: 'Ví dụ: Lỗi phát âm từ vựng bài 2 HSK 1...',
    color: 'hover:border-red-500 hover:text-red-600',
  },
  {
    id: 'feature',
    label: 'Đề xuất tính năng',
    icon: Lightbulb,
    placeholder: 'Ví dụ: Đề xuất thêm chế độ luyện viết chữ Hán theo bộ...',
    color: 'hover:border-amber-500 hover:text-amber-600',
  },
  {
    id: 'ui_ux',
    label: 'Góp ý giao diện',
    icon: Palette,
    placeholder: 'Ví dụ: Màu sắc tab trên điện thoại hơi chói...',
    color: 'hover:border-purple-500 hover:text-purple-600',
  },
  {
    id: 'content',
    label: 'Nội dung học tập',
    icon: BookOpen,
    placeholder: 'Ví dụ: Pinyin của từ vựng này bị sai dấu thanh...',
    color: 'hover:border-emerald-500 hover:text-emerald-600',
  },
  {
    id: 'other',
    label: 'Ý kiến khác',
    icon: HelpCircle,
    placeholder: 'Ví dụ: Cảm nghĩ chung hoặc thắc mắc của bạn...',
    color: 'hover:border-blue-500 hover:text-blue-600',
  },
]

export function FeedbackWidget() {
  const pathname = usePathname() || '/'
  const [isOpen, setIsOpen] = useState(false)
  const [category, setCategory] = useState<FeedbackCategory>('bug')
  const [title, setTitle] = useState('')
  const [message, setMessage] = useState('')
  const [stepsToReproduce, setStepsToReproduce] = useState('')
  const [isAnonymous, setIsAnonymous] = useState(false)

  // Status states
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [isSuccess, setIsSuccess] = useState(false)
  const [errorMessage, setErrorMessage] = useState<string | null>(null)
  const [cooldown, setCooldown] = useState(0)

  const widgetRef = useRef<HTMLDivElement>(null)

  // Cooldown countdown
  useEffect(() => {
    if (cooldown <= 0) return
    const timer = setInterval(() => {
      setCooldown((c) => Math.max(0, c - 1))
    }, 1000)
    return () => clearInterval(timer)
  }, [cooldown])

  // Close with Escape key
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape' && isOpen) {
        setIsOpen(false)
      }
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [isOpen])

  // Reset form
  const handleReset = () => {
    setTitle('')
    setMessage('')
    setStepsToReproduce('')
    setIsSuccess(false)
    setErrorMessage(null)
  }

  // Handle submit
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (isSubmitting || cooldown > 0) return

    if (!title.trim() || title.trim().length < 3) {
      setErrorMessage('Tiêu đề cần tối thiểu 3 ký tự')
      return
    }

    if (!message.trim() || message.trim().length < 5) {
      setErrorMessage('Nội dung cần tối thiểu 5 ký tự')
      return
    }

    setIsSubmitting(true)
    setErrorMessage(null)

    // Capture device info
    const deviceInfo = typeof window !== 'undefined' 
      ? `${navigator.userAgent.slice(0, 150)} | Screen: ${window.innerWidth}x${window.innerHeight}`
      : null

    const result = await submitFeedbackAction({
      category,
      title: title.trim(),
      message: message.trim(),
      steps_to_reproduce: category === 'bug' && stepsToReproduce.trim() ? stepsToReproduce.trim() : null,
      page_url: pathname,
      device_info: deviceInfo,
      is_anonymous: isAnonymous,
    })

    setIsSubmitting(false)

    if (result.success) {
      setIsSuccess(true)
      setCooldown(15) // 15 seconds anti-spam cooldown
    } else {
      setErrorMessage(result.error || 'Có lỗi xảy ra, vui lòng thử lại sau.')
    }
  }

  const currentCategoryObj = CATEGORIES.find((c) => c.id === category) || CATEGORIES[0]

  return (
    <div ref={widgetRef} className="fixed z-40 select-none">
      
      {/* 1. CHAT WINDOW PANEL */}
      {isOpen && (
        <div 
          className="fixed bottom-24 right-4 sm:right-6 w-[calc(100vw-2rem)] sm:w-[400px] max-h-[82vh] bg-card border border-border shadow-xl rounded-2xl flex flex-col overflow-hidden animate-in fade-in slide-in-from-bottom-4 duration-200"
          role="dialog"
          aria-labelledby="feedback-dialog-title"
          aria-modal="true"
        >
          {/* Accent decorative bar */}
          <div className="h-1 bg-gradient-to-r from-app-accent via-app-accent/80 to-gold shrink-0" />

          {/* Window Header */}
          <div className="px-5 py-3.5 border-b border-border bg-page/95 flex items-center justify-between shrink-0">
            <div className="flex items-center gap-2.5">
              <div className="w-8 h-8 rounded-xl bg-app-accent-soft text-app-accent flex items-center justify-center font-serif font-bold text-sm">
                汉
              </div>
              <div>
                <h2 id="feedback-dialog-title" className="text-sm font-serif font-bold text-title flex items-center gap-1.5">
                  Góp ý & Báo lỗi
                  <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
                </h2>
                <p className="text-[11px] text-muted font-serif">Chinese Notebook luôn lắng nghe bạn</p>
              </div>
            </div>

            <button
              type="button"
              onClick={() => setIsOpen(false)}
              className="p-1.5 rounded-lg text-muted hover:text-title hover:bg-black/5 transition-colors"
              aria-label="Đóng cửa sổ"
            >
              <X className="w-4 h-4" />
            </button>
          </div>

          {/* Window Body (Scrollable) */}
          <div className="flex-1 overflow-y-auto p-4 sm:p-5 space-y-4 no-scrollbar font-serif">
            {isSuccess ? (
              /* Success State */
              <div className="py-8 px-4 text-center space-y-4 animate-in fade-in zoom-in-95 duration-200">
                <div className="w-14 h-14 rounded-full bg-jade-soft text-jade mx-auto flex items-center justify-center">
                  <CheckCircle2 className="w-8 h-8" />
                </div>
                <div className="space-y-1.5">
                  <h3 className="text-lg font-bold text-title">Cảm ơn bạn đã góp ý!</h3>
                  <p className="text-xs text-muted leading-relaxed">
                    Phản hồi của bạn đã được ghi nhận an toàn vào hệ thống. Ban quản trị sẽ xem xét và cải tiến Chinese Notebook sớm nhất.
                  </p>
                </div>
                <div className="pt-2 flex flex-col gap-2">
                  <Button
                    type="button"
                    onClick={handleReset}
                    className="font-serif bg-title hover:bg-[#2A3250] text-white rounded-xl text-xs py-2.5"
                  >
                    Gửi thêm góp ý khác
                  </Button>
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => setIsOpen(false)}
                    className="font-serif border-border rounded-xl text-xs"
                  >
                    Đóng cửa sổ
                  </Button>
                </div>
              </div>
            ) : (
              /* Input Form */
              <form onSubmit={handleSubmit} className="space-y-4">
                
                {/* 1. Category Selection Chips */}
                <div className="space-y-1.5">
                  <label className="text-xs font-semibold text-title block">
                    1. Loại phản hồi:
                  </label>
                  <div className="grid grid-cols-2 gap-1.5">
                    {CATEGORIES.map((cat) => {
                      const Icon = cat.icon
                      const isSelected = category === cat.id
                      return (
                        <button
                          key={cat.id}
                          type="button"
                          onClick={() => {
                            setCategory(cat.id)
                            setErrorMessage(null)
                          }}
                          className={`flex items-center gap-2 px-2.5 py-2 rounded-xl text-xs transition-all border text-left ${
                            isSelected
                              ? 'bg-app-accent-soft border-app-accent/40 text-app-accent font-bold shadow-2xs'
                              : 'bg-page border-border text-body hover:border-title/30'
                          }`}
                        >
                          <Icon className={`w-3.5 h-3.5 shrink-0 ${isSelected ? 'text-app-accent' : 'text-muted'}`} />
                          <span className="truncate">{cat.label}</span>
                        </button>
                      )
                    })}
                  </div>
                </div>

                {/* 2. Title Input */}
                <div className="space-y-1">
                  <label htmlFor="feedback-title" className="text-xs font-semibold text-title block">
                    2. Tiêu đề tóm tắt:
                  </label>
                  <input
                    id="feedback-title"
                    type="text"
                    value={title}
                    onChange={(e) => setTitle(e.target.value)}
                    placeholder={currentCategoryObj.placeholder}
                    maxLength={150}
                    className="w-full px-3 py-2 text-xs sm:text-sm rounded-xl border border-border bg-page text-title placeholder:text-muted/70 focus:outline-none focus:border-app-accent transition-colors"
                  />
                </div>

                {/* 3. Detailed Message */}
                <div className="space-y-1">
                  <div className="flex items-center justify-between">
                    <label htmlFor="feedback-message" className="text-xs font-semibold text-title">
                      3. Chi tiết góp ý <span className="text-app-accent">*</span>:
                    </label>
                    <span className="text-[10px] text-muted font-sans">
                      {message.length}/3000
                    </span>
                  </div>
                  <textarea
                    id="feedback-message"
                    rows={3}
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                    placeholder="Mô tả cụ thể vấn đề hoặc ý kiến đề xuất của bạn..."
                    maxLength={3000}
                    className="w-full px-3 py-2 text-xs sm:text-sm rounded-xl border border-border bg-page text-title placeholder:text-muted/70 focus:outline-none focus:border-app-accent transition-colors resize-none"
                  />
                </div>

                {/* 4. Bug Steps To Reproduce (Optional, only for bugs) */}
                {category === 'bug' && (
                  <div className="space-y-1 animate-in fade-in duration-150">
                    <label htmlFor="feedback-steps" className="text-xs font-semibold text-title block">
                      Các bước tái hiện lỗi (nếu có):
                    </label>
                    <textarea
                      id="feedback-steps"
                      rows={2}
                      value={stepsToReproduce}
                      onChange={(e) => setStepsToReproduce(e.target.value)}
                      placeholder="Bước 1: Bấm vào... Bước 2: Thấy lỗi..."
                      maxLength={2000}
                      className="w-full px-3 py-2 text-xs rounded-xl border border-border bg-page text-title placeholder:text-muted/70 focus:outline-none focus:border-app-accent transition-colors resize-none"
                    />
                  </div>
                )}

                {/* 5. Metadata Context & Anonymous option */}
                <div className="p-2.5 rounded-xl bg-page/70 border border-border text-[11px] text-muted space-y-1.5">
                  <div className="flex items-center justify-between">
                    <span>Đường dẫn hiện tại:</span>
                    <span className="font-mono text-[10px] text-body truncate max-w-[180px]" title={pathname}>
                      {pathname}
                    </span>
                  </div>
                  <label className="flex items-center gap-2 cursor-pointer pt-0.5 text-body">
                    <input
                      type="checkbox"
                      checked={isAnonymous}
                      onChange={(e) => setIsAnonymous(e.target.checked)}
                      className="rounded border-border text-app-accent focus:ring-app-accent/30 w-3.5 h-3.5"
                    />
                    <span>Gửi ẩn danh (không đính kèm thông tin tài khoản)</span>
                  </label>
                </div>

                {/* Error Banner */}
                {errorMessage && (
                  <div className="p-2.5 rounded-xl bg-red-50 border border-red-200 text-xs text-red-700 flex items-center gap-2 animate-in fade-in">
                    <AlertCircle className="w-4 h-4 shrink-0 text-red-600" />
                    <span>{errorMessage}</span>
                  </div>
                )}

                {/* Submit Button */}
                <Button
                  type="submit"
                  disabled={isSubmitting || cooldown > 0}
                  className="w-full font-serif bg-app-accent hover:bg-accent-hover text-white rounded-xl py-2.5 text-xs sm:text-sm font-medium shadow-xs transition-all flex items-center justify-center gap-2 disabled:opacity-50"
                >
                  {isSubmitting ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      <span>Đang gửi phản hồi...</span>
                    </>
                  ) : cooldown > 0 ? (
                    <span>Vui lòng chờ {cooldown}s để gửi tiếp</span>
                  ) : (
                    <>
                      <Send className="w-4 h-4" />
                      <span>Gửi góp ý ngay</span>
                    </>
                  )}
                </Button>
              </form>
            )}
          </div>
        </div>
      )}

      {/* 2. FLOATING TRIGGER BUTTON */}
      <div className="fixed bottom-20 right-4 md:bottom-6 md:right-6">
        <button
          type="button"
          onClick={() => setIsOpen(!isOpen)}
          className={`w-12 h-12 md:w-14 md:h-14 rounded-full shadow-lg flex items-center justify-center transition-all duration-200 cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/50 ${
            isOpen
              ? 'bg-title hover:bg-[#2A3250] text-white rotate-90 scale-95'
              : 'bg-app-accent hover:bg-accent-hover text-white hover:scale-105 active:scale-95 shadow-app-accent/20'
          }`}
          title="Góp ý & Báo lỗi cho Chinese Notebook"
          aria-label={isOpen ? 'Đóng góp ý' : 'Mở góp ý & Báo lỗi'}
        >
          {isOpen ? (
            <X className="w-5 h-5 md:w-6 md:h-6" />
          ) : (
            <MessageSquareQuote className="w-5 h-5 md:w-6 md:h-6" />
          )}
        </button>
      </div>

    </div>
  )
}
