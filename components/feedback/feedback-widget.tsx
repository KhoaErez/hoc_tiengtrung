'use client'

import { useState, useEffect, useRef } from 'react'
import { usePathname } from 'next/navigation'
import { 
  X, 
  Send, 
  AlertCircle, 
  Bug, 
  Lightbulb, 
  Palette, 
  BookOpen, 
  HelpCircle,
  Loader2,
  CheckCircle2
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { submitFeedbackAction, FeedbackCategory } from '@/app/actions/feedback'
import { MascotAvatar, MascotState } from '@/components/mascot/mascot-avatar'

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
  const [isMounted, setIsMounted] = useState(false)
  const [isOpen, setIsOpen] = useState(false)
  const [isHovered, setIsHovered] = useState(false)
  const [showTooltip, setShowTooltip] = useState(false)
  const [hasDismissedTooltip, setHasDismissedTooltip] = useState(false)

  useEffect(() => {
    setIsMounted(true)
  }, [])

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

  const [isKeyboardOpen, setIsKeyboardOpen] = useState(false)

  // Phát hiện bàn phím ảo mở trên thiết bị di động để tự động thu gọn/ẩn nút mascot
  useEffect(() => {
    if (typeof window === 'undefined' || !window.visualViewport) return
    const handleViewportChange = () => {
      const vv = window.visualViewport
      if (!vv) return
      // Khi chiều cao visualViewport giảm hơn 25% so với window.innerHeight thì bàn phím ảo đang mở
      setIsKeyboardOpen(vv.height < window.innerHeight * 0.75)
    }
    window.visualViewport.addEventListener('resize', handleViewportChange)
    return () => window.visualViewport?.removeEventListener('resize', handleViewportChange)
  }, [])

  const widgetRef = useRef<HTMLDivElement>(null)

  // Không tự động mở bong bóng chào hỏi khi tải trang để tránh che khuất nội dung học tập

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

  // Tính toán trạng thái của Mascot trong cửa sổ chat
  const dialogMascotState: MascotState = isSuccess
    ? 'success'
    : isSubmitting
    ? 'thinking'
    : errorMessage
    ? 'error'
    : 'open'

  // Trạng thái Mascot trên nút bấm nổi
  const buttonMascotState: MascotState = isOpen
    ? 'open'
    : isHovered
    ? 'hover'
    : 'idle'

  // Tránh hydration mismatch do usePathname hoặc visualViewport giữa server và client
  if (!isMounted) {
    return null
  }

  return (
    <div ref={widgetRef} className="fixed z-40 select-none">
      
      {/* 1. CHATBOT MASCOT DIALOG WINDOW */}
      {isOpen && (
        <div 
          className="fixed z-50 bottom-[calc(4.75rem+env(safe-area-inset-bottom,0px))] md:bottom-24 right-3 sm:right-6 w-[calc(100vw-1.5rem)] sm:w-[420px] max-h-[82vh] bg-white border-2 border-[#182238] shadow-[0_8px_0_#182238] rounded-3xl flex flex-col overflow-hidden animate-in fade-in slide-in-from-bottom-4 duration-200"
          role="dialog"
          aria-labelledby="feedback-dialog-title"
          aria-modal="true"
        >
          {/* Accent decorative bar */}
          <div className="h-1.5 bg-[#B8322D] shrink-0" />

          {/* Window Header: Mascot & Assistant Name */}
          <div className="px-5 py-3.5 border-b-2 border-[#182238]/15 bg-[#FAF7F2] flex items-center justify-between shrink-0">
            <div className="flex items-center gap-3">
              <div className="p-0.5 rounded-full bg-white border-2 border-[#182238] shadow-[0_2px_0_#182238]">
                <MascotAvatar state={dialogMascotState} size="sm" />
              </div>
              <div>
                <h2 id="feedback-dialog-title" className="text-sm font-serif font-bold text-[#182238] flex items-center gap-1.5">
                  <span>Tiểu Bút</span>
                  <span className="text-[11px] font-sans font-bold text-muted">• Trợ lý Học tập</span>
                  <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse ml-0.5" title="Sẵn sàng hỗ trợ" />
                </h2>
                <p className="text-[11px] text-muted font-serif">
                  Bạn đồng hành cùng Chinese Notebook
                </p>
              </div>
            </div>

            <button
              type="button"
              onClick={() => setIsOpen(false)}
              className="p-1.5 rounded-xl text-muted hover:text-[#182238] hover:bg-[#FAF7F2] border border-transparent hover:border-[#182238]/20 transition-all cursor-pointer"
              aria-label="Đóng cửa sổ"
            >
              <X className="w-4 h-4" />
            </button>
          </div>

          {/* Window Body (Scrollable) */}
          <div className="flex-1 overflow-y-auto p-4 sm:p-5 space-y-4 no-scrollbar font-serif">
            {isSuccess ? (
              /* Success State with Happy Mascot */
              <div className="py-6 px-3 text-center space-y-4 animate-in fade-in zoom-in-95 duration-200">
                <div className="mx-auto flex justify-center">
                  <MascotAvatar state="success" size="xl" />
                </div>
                <div className="space-y-1.5">
                  <h3 className="text-lg font-bold text-title flex items-center justify-center gap-1.5">
                    <CheckCircle2 className="w-4 h-4 text-emerald-600" />
                    <span>Tiểu Bút đã nhận được tin nhắn!</span>
                  </h3>
                  <p className="text-xs text-muted leading-relaxed max-w-xs mx-auto">
                    Cảm ơn bạn rất nhiều! Ý kiến đóng góp quý báu của bạn giúp Chinese Notebook ngày một hoàn thiện và thông minh hơn.
                  </p>
                </div>
                <div className="pt-2 flex flex-col gap-2">
                  <Button
                    type="button"
                    onClick={handleReset}
                    className="font-serif bg-app-accent hover:bg-accent-hover text-white rounded-xl text-xs py-2.5 shadow-xs"
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
              /* Input Form with Assistant Personality */
              <form onSubmit={handleSubmit} className="space-y-4">
                
                {/* Lời chào thân thiện từ Mascot */}
                <div className="p-3 rounded-2xl bg-app-accent-soft/50 border border-app-accent/20 flex items-start gap-2.5">
                  <span className="text-base leading-none mt-0.5">🎋</span>
                  <p className="text-xs text-body leading-relaxed">
                    Bạn gặp khó khăn khi học, phát hiện từ vựng bị lỗi hay muốn gợi ý tính năng mới? Hãy chia sẻ với Tiểu Bút ngay nhé!
                  </p>
                </div>

                {/* 1. Category Selection Chips */}
                <div className="space-y-1.5">
                  <label className="text-xs font-bold text-[#182238] block">
                    1. Bạn muốn trao đổi về chủ đề gì?
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
                          className={`flex items-center gap-2 px-3 py-2 rounded-xl text-xs transition-all border-2 text-left cursor-pointer font-serif ${
                            isSelected
                              ? 'bg-[#B8322D] text-white font-bold border-[#182238] shadow-[0_2px_0_#182238]'
                              : 'bg-white border-[#182238]/20 text-[#182238] hover:border-[#182238]'
                          }`}
                        >
                          <Icon className={`w-3.5 h-3.5 shrink-0 ${isSelected ? 'text-white' : 'text-[#B8322D]'}`} />
                          <span className="truncate">{cat.label}</span>
                        </button>
                      )
                    })}
                  </div>
                </div>

                {/* 2. Tiêu đề phản hồi */}
                <div className="space-y-1.5">
                  <label htmlFor="feedback-title" className="text-xs font-semibold text-title block">
                    2. Tóm tắt nội dung:
                  </label>
                  <input
                    id="feedback-title"
                    type="text"
                    value={title}
                    onChange={(e) => setTitle(e.target.value)}
                    placeholder={CATEGORIES.find(c => c.id === category)?.placeholder || 'Tóm tắt ngắn gọn...'}
                    maxLength={100}
                    className="w-full px-3 py-2 rounded-xl text-xs bg-page border border-border text-title placeholder:text-muted focus:outline-none focus:border-app-accent transition-colors shadow-2xs"
                  />
                </div>

                {/* 3. Chi tiết nội dung */}
                <div className="space-y-1.5">
                  <label htmlFor="feedback-message" className="text-xs font-semibold text-title block">
                    3. Chi tiết chia sẻ:
                  </label>
                  <textarea
                    id="feedback-message"
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                    rows={3}
                    placeholder="Mô tả cụ thể để ban quản trị hỗ trợ bạn nhanh chóng nhất..."
                    maxLength={1000}
                    className="w-full px-3 py-2 rounded-xl text-xs bg-page border border-border text-title placeholder:text-muted focus:outline-none focus:border-app-accent transition-colors shadow-2xs resize-none"
                  />
                </div>

                {/* Các bước tái hiện nếu báo lỗi */}
                {category === 'bug' && (
                  <div className="space-y-1.5">
                    <label htmlFor="feedback-steps" className="text-xs font-semibold text-title block">
                      Các bước dẫn đến lỗi (nếu có):
                    </label>
                    <textarea
                      id="feedback-steps"
                      value={stepsToReproduce}
                      onChange={(e) => setStepsToReproduce(e.target.value)}
                      rows={2}
                      placeholder="Ví dụ: Bấm vào bài 3 -> Chọn thẻ từ vựng -> Bấm nút loa..."
                      maxLength={500}
                      className="w-full px-3 py-2 rounded-xl text-xs bg-page border border-border text-title placeholder:text-muted focus:outline-none focus:border-app-accent transition-colors shadow-2xs resize-none"
                    />
                  </div>
                )}

                {/* Checkbox ẩn danh */}
                <div className="flex items-center gap-2 pt-1">
                  <input
                    type="checkbox"
                    id="anonymous-check"
                    checked={isAnonymous}
                    onChange={(e) => setIsAnonymous(e.target.checked)}
                    className="rounded border-border text-app-accent focus:ring-app-accent cursor-pointer"
                  />
                  <label htmlFor="anonymous-check" className="text-[11px] text-muted cursor-pointer">
                    Gửi ẩn danh (không đính kèm tài khoản của bạn)
                  </label>
                </div>

                {/* Thông báo lỗi */}
                {errorMessage && (
                  <div className="p-2.5 rounded-xl bg-red-500/10 border border-red-500/30 text-red-600 dark:text-red-400 text-xs flex items-center gap-2">
                    <AlertCircle className="w-4 h-4 shrink-0" />
                    <span>{errorMessage}</span>
                  </div>
                )}

                {/* Nút gửi */}
                <Button
                  type="submit"
                  disabled={isSubmitting || cooldown > 0}
                  className="w-full py-3 bg-[#B8322D] hover:bg-[#A32A26] text-white rounded-2xl text-xs font-serif font-bold flex items-center justify-center gap-2 border-2 border-[#182238] shadow-[0_3px_0_#182238] active:translate-y-0.5 active:shadow-[0_1px_0_#182238] transition-all cursor-pointer"
                >
                  {isSubmitting ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      <span>Tiểu Bút đang gửi tin nhắn...</span>
                    </>
                  ) : cooldown > 0 ? (
                    <span>Vui lòng chờ {cooldown}s để gửi tiếp</span>
                  ) : (
                    <>
                      <Send className="w-4 h-4" />
                      <span>Gửi tin nhắn cho Tiểu Bút</span>
                    </>
                  )}
                </Button>
              </form>
            )}
          </div>
        </div>
      )}

      {/* 2. FLOATING MASCOT TRIGGER BUTTON (Tự động ẩn trên mobile khi ở trang /typing để không che khuất cụm nút điều khiển và ô nhập liệu) */}
      <div 
        className={`fixed z-35 group transition-all duration-200 ${
          isKeyboardOpen ? 'opacity-0 pointer-events-none translate-y-8' : 'opacity-100 translate-y-0'
        } ${
          pathname.startsWith('/typing')
            ? 'hidden md:block md:bottom-6 md:right-6'
            : 'bottom-[calc(4.25rem+env(safe-area-inset-bottom,0px))] right-3 md:bottom-6 md:right-6'
        }`}
        onMouseEnter={() => {
          setIsHovered(true)
          if (!hasDismissedTooltip && !isOpen) setShowTooltip(true)
        }}
        onMouseLeave={() => {
          setIsHovered(false)
          setShowTooltip(false)
        }}
      >
        {/* Bong bóng chào hỏi thông minh (Smart Tooltip Bubble - chỉ hiển thị trên desktop khi hover) */}
        {!isOpen && showTooltip && (
          <div className={`hidden sm:block absolute bottom-1 bg-[#FAF7F2] dark:bg-[#182238] border-2 border-[#182238] dark:border-[#384869] shadow-[0_6px_0_#182238] dark:shadow-[0_6px_0_#0D1322] rounded-2xl p-3.5 w-60 sm:w-64 text-xs text-title font-serif animate-in fade-in duration-200 z-50 pointer-events-auto ${
            pathname.startsWith('/typing')
              ? 'left-full ml-3 slide-in-from-left-2'
              : 'right-full mr-3 slide-in-from-right-2'
          }`}>
            <div className="flex items-start justify-between gap-1.5">
              <div className="space-y-1">
                <div className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-full bg-[#182238]/10 dark:bg-white/10 text-[10px] font-sans font-bold text-[#B8322D] uppercase">
                  <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
                  <span>Trợ lý học tập AI</span>
                </div>
                <p className="leading-relaxed text-[#182238] dark:text-slate-200">
                  Chào bạn! Mình là <strong>Tiểu Bút 🐼</strong>. Bạn muốn tìm bài tập hay góp ý gì cứ nhắn mình nhé!
                </p>
              </div>
              <button
                type="button"
                onClick={(e) => {
                  e.stopPropagation()
                  setShowTooltip(false)
                  setHasDismissedTooltip(true)
                }}
                className="text-muted hover:text-title p-0.5 rounded-md -mr-1 -mt-1 cursor-pointer"
                title="Đóng lời chào"
              >
                <X className="w-3.5 h-3.5" />
              </button>
            </div>
            {/* Mũi tên trỏ vào nút mascot */}
            <div className={`absolute top-1/2 -translate-y-1/2 w-3 h-3 bg-[#FAF7F2] dark:bg-[#182238] border-[#182238] dark:border-[#384869] rotate-45 ${
              pathname.startsWith('/typing')
                ? '-left-1.5 border-b border-l'
                : '-right-1.5 border-t border-r'
            }`} />
          </div>
        )}

        {/* Nút bấm Mascot hình tròn cao cấp (Tối ưu kích thước gọn trên mobile 46px, desktop 58px) */}
        <button
          type="button"
          onClick={() => {
            setIsOpen(!isOpen)
            setShowTooltip(false)
            setHasDismissedTooltip(true)
          }}
          className={`w-12 h-12 md:w-15 md:h-15 rounded-full flex items-center justify-center transition-all duration-150 cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#182238] ${
            isOpen
              ? 'bg-[#182238] text-white rotate-0 scale-95 border-2 border-[#182238] shadow-[0_4px_0_#182238]'
              : 'bg-[#FAF7F2] hover:bg-white border-2 border-[#182238] dark:border-[#384869] shadow-[0_4px_0_#182238] dark:shadow-[0_4px_0_#0D1322] hover:shadow-[0_2px_0_#182238] hover:translate-y-0.5 active:translate-y-1 active:shadow-none'
          }`}
          title="Trò chuyện & Góp ý cùng Tiểu Bút"
          aria-label={isOpen ? 'Đóng hộp thoại trợ lý' : 'Mở trợ lý Tiểu Bút'}
        >
          {isOpen ? (
            <X className="w-5 h-5 text-white" />
          ) : (
            <div className="relative flex items-center justify-center">
              <MascotAvatar state={buttonMascotState} size="md" className="hidden sm:inline-flex" />
              <MascotAvatar state={buttonMascotState} size="sm" className="sm:hidden" />
              {/* Huy hiệu online nhỏ góc dưới */}
              <span className="absolute bottom-0 right-0 w-3 h-3 rounded-full bg-emerald-500 border-2 border-[#182238] shadow-xs animate-pulse" />
            </div>
          )}
        </button>
      </div>

    </div>
  )
}

export default FeedbackWidget
