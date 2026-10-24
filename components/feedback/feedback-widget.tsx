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
  const [isOpen, setIsOpen] = useState(false)
  const [isHovered, setIsHovered] = useState(false)
  const [showTooltip, setShowTooltip] = useState(false)
  const [hasDismissedTooltip, setHasDismissedTooltip] = useState(false)

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

  // Tooltip chào mừng xuất hiện sau 4 giây truy cập nếu chưa từng tắt
  useEffect(() => {
    if (hasDismissedTooltip || isOpen) return
    const timer = setTimeout(() => {
      setShowTooltip(true)
    }, 4000)
    return () => clearTimeout(timer)
  }, [hasDismissedTooltip, isOpen])

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

  return (
    <div ref={widgetRef} className="fixed z-40 select-none">
      
      {/* 1. CHATBOT MASCOT DIALOG WINDOW */}
      {isOpen && (
        <div 
          className="fixed bottom-24 right-4 sm:right-6 w-[calc(100vw-2rem)] sm:w-[410px] max-h-[84vh] bg-card border border-border shadow-2xl rounded-3xl flex flex-col overflow-hidden animate-in fade-in slide-in-from-bottom-4 duration-200"
          role="dialog"
          aria-labelledby="feedback-dialog-title"
          aria-modal="true"
        >
          {/* Accent decorative bar */}
          <div className="h-1.5 bg-gradient-to-r from-app-accent via-red-500 to-gold shrink-0" />

          {/* Window Header: Mascot & Assistant Name */}
          <div className="px-5 py-3.5 border-b border-border bg-page/95 flex items-center justify-between shrink-0">
            <div className="flex items-center gap-3">
              <div className="p-0.5 rounded-full bg-white border border-app-accent/20 shadow-xs">
                <MascotAvatar state={dialogMascotState} size="sm" />
              </div>
              <div>
                <h2 id="feedback-dialog-title" className="text-sm font-serif font-bold text-title flex items-center gap-1.5">
                  <span>Tiểu Bút</span>
                  <span className="text-[11px] font-sans font-normal text-muted">• Trợ lý Học tập</span>
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
              className="p-1.5 rounded-xl text-muted hover:text-title hover:bg-black/5 transition-colors cursor-pointer"
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
                  <label className="text-xs font-semibold text-title block">
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
                          className={`flex items-center gap-2 px-2.5 py-2 rounded-xl text-xs transition-all border text-left cursor-pointer ${
                            isSelected
                              ? 'bg-app-accent text-white font-medium border-app-accent shadow-2xs'
                              : 'bg-page border-border text-title hover:border-app-accent/40'
                          }`}
                        >
                          <Icon className={`w-3.5 h-3.5 shrink-0 ${isSelected ? 'text-white' : 'text-muted'}`} />
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
                  className="w-full py-2.5 bg-app-accent hover:bg-accent-hover text-white rounded-xl text-xs font-serif font-medium flex items-center justify-center gap-2 shadow-xs transition-all cursor-pointer"
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

      {/* 2. FLOATING MASCOT TRIGGER BUTTON (Tự ẩn khi bàn phím mở, đổi bên trên /typing để không che nút) */}
      <div 
        className={`fixed z-35 group transition-all duration-200 ${
          isKeyboardOpen ? 'opacity-0 pointer-events-none translate-y-8' : 'opacity-100 translate-y-0'
        } ${
          pathname.startsWith('/typing')
            ? 'bottom-20 left-3 md:bottom-6 md:left-auto md:right-6'
            : 'bottom-20 right-3 md:bottom-6 md:right-6'
        }`}
        onMouseEnter={() => setIsHovered(true)}
        onMouseLeave={() => setIsHovered(false)}
      >
        {/* Bong bóng chào hỏi thông minh (Smart Tooltip Bubble - chỉ hiển thị trên tablet/desktop sm:block để không che màn hình mobile nhỏ) */}
        {!isOpen && showTooltip && (
          <div className={`hidden sm:block absolute bottom-1 bg-card border border-border shadow-xl rounded-2xl p-3 w-56 sm:w-60 text-xs text-title font-serif animate-in fade-in duration-200 z-50 ${
            pathname.startsWith('/typing')
              ? 'left-full ml-3 slide-in-from-left-2'
              : 'right-full mr-3 slide-in-from-right-2'
          }`}>
            <div className="flex items-start justify-between gap-1.5">
              <p className="leading-relaxed">
                Chào bạn! Mình là <strong>Tiểu Bút</strong> 🐼. Hôm nay bạn học bài nào rồi? Cần gì cứ gọi mình nhé!
              </p>
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
            <div className={`absolute top-1/2 -translate-y-1/2 w-3 h-3 bg-card border-border rotate-45 ${
              pathname.startsWith('/typing')
                ? '-left-1.5 border-b border-l'
                : '-right-1.5 border-t border-r'
            }`} />
          </div>
        )}

        {/* Nút bấm Mascot hình tròn cao cấp (Tối ưu kích thước gọn trên mobile 48px) */}
        <button
          type="button"
          onClick={() => {
            setIsOpen(!isOpen)
            setShowTooltip(false)
            setHasDismissedTooltip(true)
          }}
          className={`w-12 h-12 md:w-16 md:h-16 rounded-full shadow-md flex items-center justify-center transition-all duration-200 cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/50 ${
            isOpen
              ? 'bg-title text-white rotate-0 scale-95 ring-4 ring-title/15'
              : 'bg-page hover:bg-card border-2 border-app-accent/40 hover:border-app-accent hover:scale-105 active:scale-95 shadow-app-accent/15 ring-3 ring-app-accent/10'
          }`}
          title="Trò chuyện & Góp ý cùng Tiểu Bút"
          aria-label={isOpen ? 'Đóng hộp thoại trợ lý' : 'Mở trợ lý Tiểu Bút'}
        >
          {isOpen ? (
            <X className="w-5 h-5 md:w-6 md:h-6 text-white" />
          ) : (
            <div className="relative flex items-center justify-center">
              <MascotAvatar state={buttonMascotState} size="md" className="hidden sm:inline-flex" />
              <MascotAvatar state={buttonMascotState} size="sm" className="sm:hidden" />
              {/* Huy hiệu online nhỏ góc dưới */}
              <span className="absolute bottom-0 right-0 w-3 h-3 md:w-3.5 md:h-3.5 rounded-full bg-emerald-500 border-2 border-white shadow-xs animate-pulse" />
            </div>
          )}
        </button>
      </div>

    </div>
  )
}

export default FeedbackWidget
