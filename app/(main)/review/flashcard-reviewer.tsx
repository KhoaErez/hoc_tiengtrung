'use client'

import { useState, useEffect, useCallback, useRef } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { updateReviewStatusAction, revalidateReviewSessionAction } from './actions'
import { 
  CheckCircle2, 
  XCircle, 
  RotateCcw, 
  ArrowRight, 
  GraduationCap, 
  Layers, 
  Volume2, 
  Volume1,
  Compass,
  Check,
  Loader2
} from 'lucide-react'
import { toast } from 'sonner'
import { AudioButton } from '@/components/ui/audio-button'
import { AudioSpeedSelector } from '@/components/ui/audio-speed-selector'
import { stopAllAudio } from '@/lib/tts/tts-engine'
import { MascotAvatar } from '@/components/mascot/mascot-avatar'
import Link from 'next/link'

type Vocab = {
  id: string // user_vocab_id
  hanzi: string
  pinyin: string
  meaning_vi: string
  hsk_level?: string
  example_hanzi?: string
  example_pinyin?: string
  example_vi?: string
  review_interval_days?: number
  ease_factor?: number
}

interface FlashcardReviewerProps {
  vocabs: Vocab[]
  totalLearnedCount?: number
  isGuestMode?: boolean
}

// Hàm tính kích thước chữ Hán linh hoạt theo độ dài ký tự
function getHanziSizeClass(hanzi: string) {
  const len = hanzi ? hanzi.trim().length : 0
  if (len <= 2) return 'text-5xl sm:text-7xl md:text-8xl'
  if (len <= 4) return 'text-4xl sm:text-5xl md:text-6xl'
  return 'text-2xl sm:text-3xl md:text-4xl'
}

export default function FlashcardReviewer({ 
  vocabs, 
  totalLearnedCount = 0,
  isGuestMode = false 
}: FlashcardReviewerProps) {
  const [currentIndex, setCurrentIndex] = useState(0)
  const [showAnswer, setShowAnswer] = useState(false)
  const [rememberedCount, setRememberedCount] = useState(0)
  const [forgotCount, setForgotCount] = useState(0)
  const cardRef = useRef<HTMLDivElement>(null)
  const touchStartXRef = useRef<number | null>(null)
  const touchStartYRef = useRef<number | null>(null)

  const currentVocab = vocabs[currentIndex]
  const isFinished = currentIndex >= vocabs.length
  const progressPercent = vocabs.length > 0 ? Math.round(((currentIndex) / vocabs.length) * 100) : 0

  // Lật thẻ an toàn
  const handleFlip = useCallback(() => {
    if (!showAnswer) {
      setShowAnswer(true)
    }
  }, [showAnswer])

  // Xử lý đánh giá: Quên rồi (false) hoặc Đã nhớ (true) - Tối ưu Optimistic UI tức thì (0ms)
  const handleAnswer = useCallback((isRemembered: boolean) => {
    if (!currentVocab) return
    stopAllAudio()

    const targetVocab = currentVocab
    const nextIndex = currentIndex + 1

    // 1. Phản hồi giao diện tức thì (Optimistic 0ms UI)
    if (isRemembered) {
      setRememberedCount((c) => c + 1)
    } else {
      setForgotCount((c) => c + 1)
    }
    setShowAnswer(false)
    setCurrentIndex(nextIndex)

    // Nếu ở chế độ xem thử khách, không gọi server action
    if (isGuestMode) {
      return
    }

    // 2. Chạy Server Action đồng bộ ngầm phía sau (Background Sync)
    updateReviewStatusAction(
      targetVocab.id,
      isRemembered,
      targetVocab.review_interval_days,
      targetVocab.ease_factor
    )
      .then((res) => {
        if (!res?.success) {
          console.warn('Review update not successful')
        }
        if (nextIndex >= vocabs.length) {
          revalidateReviewSessionAction().catch(() => {})
        }
      })
      .catch((e: unknown) => {
        console.error('Review update background error:', e)
        const errorMsg = e instanceof Error ? e.message : String(e)
        if (errorMsg.includes('Server Action') || errorMsg.includes('was not found')) {
          toast.error('Mã nguồn vừa được cập nhật. Nhấn F5 để tải lại.', { duration: 4000 })
        }
      })
  }, [currentVocab, currentIndex, vocabs.length, isGuestMode])

  // Lắng nghe phím tắt: Space để lật, 1: Quên rồi, 2: Đã nhớ
  useEffect(() => {
    if (isFinished) return

    const handleKeyDown = (e: KeyboardEvent) => {
      // Bỏ qua nếu người dùng đang nhập trong input/textarea
      const target = e.target as HTMLElement
      if (target && (target.tagName === 'INPUT' || target.tagName === 'TEXTAREA' || target.isContentEditable)) {
        return
      }

      if (e.code === 'Space') {
        e.preventDefault()
        if (!showAnswer) {
          handleFlip()
        }
      } else if (showAnswer) {
        if (e.key === '1' || e.code === 'Digit1' || e.code === 'Numpad1' || e.code === 'ArrowLeft') {
          e.preventDefault()
          handleAnswer(false)
        } else if (e.key === '2' || e.code === 'Digit2' || e.code === 'Numpad2' || e.code === 'ArrowRight') {
          e.preventDefault()
          handleAnswer(true)
        }
      }
    }

    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [isFinished, showAnswer, handleFlip, handleAnswer])

  // Touch Swipe Gesture (Trượt trái: Chưa nhớ, Trượt phải: Đã nhớ)
  const handleTouchStart = (e: React.TouchEvent) => {
    touchStartXRef.current = e.touches[0].clientX
    touchStartYRef.current = e.touches[0].clientY
  }

  const handleTouchEnd = (e: React.TouchEvent) => {
    if (touchStartXRef.current === null || touchStartYRef.current === null) return
    const diffX = e.changedTouches[0].clientX - touchStartXRef.current
    const diffY = e.changedTouches[0].clientY - touchStartYRef.current
    touchStartXRef.current = null
    touchStartYRef.current = null

    // Nếu khoảng cách vuốt ngang > 50px và lớn hơn vuốt dọc
    if (Math.abs(diffX) > 50 && Math.abs(diffX) > Math.abs(diffY)) {
      if (showAnswer) {
        if (diffX > 0) {
          handleAnswer(true) // Vuốt sang phải -> Đã nhớ
        } else {
          handleAnswer(false) // Vuốt sang trái -> Chưa nhớ
        }
      } else {
        handleFlip() // Vuốt để lật thẻ
      }
    }
  }

  // ========================================================
  // 1. TRẠNG THÁI HOÀN THÀNH PHIÊN ÔN TẬP
  // ========================================================
  if (isFinished) {
    return (
      <div className="max-w-xl mx-auto py-12 px-6 rounded-3xl border border-border bg-card shadow-xs text-center space-y-6 animate-in fade-in zoom-in-95 duration-200">
        <div className="flex justify-center">
          <MascotAvatar state="success" size="2xl" />
        </div>

        <div className="space-y-2">
          <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-jade-soft text-jade text-xs font-serif font-bold border border-jade/20">
            <CheckCircle2 className="w-3.5 h-3.5" />
            <span>Hoàn thành xuất sắc phiên ôn tập!</span>
          </div>
          <h2 className="text-2xl sm:text-3xl font-serif text-title font-bold">
            Chúc mừng bạn đã hoàn tất!
          </h2>
          <p className="text-xs sm:text-sm text-muted font-serif max-w-sm mx-auto leading-relaxed">
            Thuật toán Spaced Repetition đã cập nhật chu kỳ ôn tập tiếp theo vào cơ sở dữ liệu của bạn.
          </p>
        </div>

        {/* Bảng thống kê kết quả phiên */}
        <div className="grid grid-cols-3 gap-3 p-4 rounded-2xl bg-page border border-border/80 max-w-sm mx-auto text-center font-serif">
          <div>
            <p className="text-[11px] text-muted">Tổng số thẻ</p>
            <p className="text-xl font-bold text-title mt-0.5">{vocabs.length}</p>
          </div>
          <div className="border-x border-border/80">
            <p className="text-[11px] text-jade font-medium">Đã nhớ tốt</p>
            <p className="text-xl font-bold text-jade mt-0.5">{rememberedCount}</p>
          </div>
          <div>
            <p className="text-[11px] text-red-600 font-medium">Cần củng cố</p>
            <p className="text-xl font-bold text-red-600 mt-0.5">{forgotCount}</p>
          </div>
        </div>

        {/* Các nút hành động tiếp theo */}
        <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
          <Link href="/topics?q=HSK 1" className="w-full sm:w-auto">
            <Button variant="tertiary" className="w-full sm:w-auto font-serif min-h-[44px] px-5 gap-2 cursor-pointer text-xs">
              <GraduationCap className="w-4 h-4" />
              <span>Học tiếp lộ trình HSK</span>
            </Button>
          </Link>
          <Link href="/" className="w-full sm:w-auto">
            <Button variant="outline" className="w-full sm:w-auto font-serif border-[#E9DDD1] hover:bg-[#FFF9F3] min-h-[44px] px-5 cursor-pointer text-xs">
              <span>Về Trang chủ</span>
            </Button>
          </Link>
        </div>
      </div>
    )
  }

  // ========================================================
  // 2. KHU VỰC ĐANG ÔN TẬP FLASHCARD
  // ========================================================
  return (
    <div className="max-w-xl mx-auto space-y-5 select-none">
      
      {/* Thanh điều khiển phiên & Tiến độ */}
      <div className="space-y-2">
        <div className="flex items-center justify-between text-xs font-serif text-muted">
          <div className="flex items-center gap-2">
            <span className="font-sans font-semibold text-title">
              Thẻ {currentIndex + 1} / {vocabs.length}
            </span>
            <span className="text-border-strong">•</span>
            <span className="text-[11px]">Còn {vocabs.length - currentIndex} thẻ</span>
          </div>

          <div className="flex items-center gap-2">
            {/* Tùy chọn tốc độ âm thanh 6 mức dùng chung toàn hệ thống */}
            <AudioSpeedSelector variant="dropdown" size="xs" />
          </div>
        </div>

        {/* Thanh tiến độ vi mô mượt mà */}
        <div className="w-full bg-track h-1.5 rounded-full overflow-hidden">
          <div 
            className="h-full bg-gradient-to-r from-app-accent to-gold rounded-full transition-all duration-300"
            style={{ width: `${progressPercent}%` }}
          />
        </div>
      </div>

      {/* ======================================================== */}
      {/* 3. KHỐI FLASHCARD CHÍNH (HIỆU ỨNG 3D FLIP TỰ NHIÊN, CSS GRID STACKING) */}
      {/* ======================================================== */}
      <div className="perspective-1000 w-full">
        <div 
          ref={cardRef}
          onClick={handleFlip}
          onTouchStart={handleTouchStart}
          onTouchEnd={handleTouchEnd}
          className={`transform-style-3d transition-transform duration-300 ease-out relative w-full grid grid-cols-1 grid-rows-1 min-h-[380px] sm:min-h-[420px] cursor-pointer touch-pan-y ${
            showAnswer ? 'rotate-y-180' : ''
          }`}
          role="button"
          tabIndex={0}
          aria-label={showAnswer ? 'Mặt sau thẻ từ vựng' : 'Mặt trước thẻ từ vựng, chạm để lật thẻ'}
        >
          {/* ---------------------------------------------------- */}
          {/* MẶT TRƯỚC FLASHCARD (CHỮ HÁN NỔI BẬT)                */}
          {/* ---------------------------------------------------- */}
          <div className={`col-start-1 row-start-1 w-full rounded-2xl sm:rounded-3xl bg-card border border-border/80 p-5 sm:p-7 md:p-8 flex flex-col justify-between items-center shadow-xs hover:border-app-accent/40 transition-colors [backface-visibility:hidden] relative ${
            showAnswer ? 'pointer-events-none select-none opacity-0 md:opacity-100' : 'opacity-100'
          }`}>
            
            {/* Thanh accent trên cùng */}
            <div className="absolute top-0 left-0 right-0 h-1 bg-border/60 rounded-t-2xl sm:rounded-t-3xl" />

            {/* Header thẻ: Huy hiệu thứ tự & Cấp HSK */}
            <div className="w-full flex items-center justify-between text-xs text-muted font-serif">
              <div className="flex items-center gap-1.5">
                <span className="px-2 py-0.5 rounded-md bg-page border border-border/60 text-[10px] font-sans">
                  Chữ Hán
                </span>
                {currentVocab.hsk_level && (
                  <span className="px-2 py-0.5 rounded-md bg-app-accent-soft text-app-accent border border-app-accent/20 text-[10px] font-sans font-semibold">
                    {currentVocab.hsk_level}
                  </span>
                )}
              </div>
              <span className="text-[11px] font-sans text-muted/70">
                #{currentIndex + 1}
              </span>
            </div>

            {/* Trọng tâm chữ Hán & Nút phát âm: Căn giữa hoàn hảo cả chiều ngang & dọc */}
            <div className="flex-1 w-full flex flex-col items-center justify-center py-6 space-y-4">
              <div className="flex items-center justify-center gap-3 sm:gap-4 flex-wrap text-center">
                <span className={`font-hanzi font-serif font-bold text-title tracking-wide leading-none ${getHanziSizeClass(currentVocab.hanzi)}`}>
                  {currentVocab.hanzi}
                </span>
                <div onClick={(e) => e.stopPropagation()}>
                  <AudioButton 
                    text={currentVocab.hanzi} 
                    id={`fc-front-${currentVocab.id}`} 
                    size="lg" 
                    variant="subtle" 
                    tooltip="Nghe phát âm chuẩn" 
                  />
                </div>
              </div>
            </div>

            {/* Footer thẻ: Gợi ý thao tác nhẹ nhàng */}
            <div className="pt-2 text-center">
              <p className="text-xs text-muted/70 font-serif flex items-center justify-center gap-1.5">
                <span>Chạm vào thẻ hoặc bấm nút bên dưới để xem đáp án</span>
              </p>
            </div>
          </div>

          {/* ---------------------------------------------------- */}
          {/* MẶT SAU FLASHCARD (PINYIN + NGHĨA + CÂU VÍ DỤ)       */}
          {/* ---------------------------------------------------- */}
          <div className={`col-start-1 row-start-1 w-full rounded-2xl sm:rounded-3xl bg-card border border-border/80 p-5 sm:p-7 md:p-8 flex flex-col justify-between items-center shadow-xs [backface-visibility:hidden] [transform:rotateY(180deg)] relative ${
            !showAnswer ? 'pointer-events-none select-none opacity-0 md:opacity-100' : 'opacity-100'
          }`}>
            
            {/* Thanh accent màu son trên cùng */}
            <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-app-accent via-app-accent/80 to-gold rounded-t-2xl sm:rounded-t-3xl" />

            {/* Header thẻ mặt sau */}
            <div className="w-full flex items-center justify-between text-xs text-muted font-serif">
              <div className="flex items-center gap-1.5">
                <span className="px-2 py-0.5 rounded-md bg-app-accent-soft text-app-accent border border-app-accent/20 text-[10px] font-sans font-medium">
                  Đáp án
                </span>
                {currentVocab.hsk_level && (
                  <span className="px-2 py-0.5 rounded-md bg-page border border-border/60 text-[10px] font-sans text-title font-medium">
                    {currentVocab.hsk_level}
                  </span>
                )}
              </div>
              <span className="text-[11px] font-sans text-muted/70">
                #{currentIndex + 1}
              </span>
            </div>

            {/* Nội dung chi tiết: Pinyin, Chữ Hán, Nghĩa & Ví dụ */}
            <div className="flex-1 w-full flex flex-col items-center justify-center py-4 space-y-3.5 text-center">
              
              {/* Pinyin thanh thoát */}
              <p className="text-xl sm:text-2xl font-sans tracking-widest text-app-accent font-semibold">
                {currentVocab.pinyin}
              </p>

              {/* Chữ Hán to bản kèm nút nghe */}
              <div className="flex items-center justify-center gap-3">
                <span className="text-3xl sm:text-4xl font-hanzi font-serif font-bold text-title leading-tight">
                  {currentVocab.hanzi}
                </span>
                <div onClick={(e) => e.stopPropagation()}>
                  <AudioButton 
                    text={currentVocab.hanzi} 
                    id={`fc-back-${currentVocab.id}`} 
                    size="md" 
                    variant="subtle" 
                    tooltip="Nghe lại phát âm" 
                  />
                </div>
              </div>

              {/* Nghĩa tiếng Việt đóng khung như triện ấn */}
              <div className="bg-app-accent-soft/40 border border-app-accent/20 px-5 py-2 rounded-2xl max-w-md mx-auto shadow-2xs">
                <span className="text-base sm:text-lg font-serif text-title font-bold break-words">
                  {currentVocab.meaning_vi}
                </span>
              </div>

              {/* Câu ví dụ minh họa nếu có */}
              {currentVocab.example_hanzi && (
                <div className="w-full bg-page/80 border border-border/70 rounded-2xl p-3.5 sm:p-4 max-w-md mx-auto text-center space-y-1.5">
                  <p className="text-sm sm:text-base font-sans text-app-accent font-medium tracking-wide">
                    {currentVocab.example_pinyin}
                  </p>
                  <div className="text-base sm:text-lg font-hanzi text-title flex items-center justify-center gap-2">
                    <span>{currentVocab.example_hanzi}</span>
                    <div onClick={(e) => e.stopPropagation()}>
                      <AudioButton 
                        text={currentVocab.example_hanzi} 
                        id={`fc-ex-${currentVocab.id}`} 
                        size="xs" 
                        variant="ghost" 
                        tooltip="Nghe câu ví dụ" 
                      />
                    </div>
                  </div>
                  <p className="text-sm font-sans text-body">
                    {currentVocab.example_vi}
                  </p>
                </div>
              )}
            </div>

            {/* Gợi ý phím tắt đánh giá */}
            <div className="pt-1 text-center">
              <p className="text-xs text-muted font-sans">
                Chọn mức độ nhớ bên dưới để chuyển sang từ tiếp theo
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* ======================================================== */}
      {/* 4. CỤM NÚT ĐIỀU HƯỚNG VÀ ĐÁNH GIÁ MỨC ĐỘ GHI NHỚ          */}
      {/* ======================================================== */}
      <div className="pt-3 sm:pt-4">
        {!showAnswer ? (
          /* Nút lật thẻ khi đang ở mặt trước */
          <Button 
            variant="primary"
            onClick={handleFlip}
            className="w-full min-h-[52px] text-base font-sans font-semibold rounded-2xl shadow-xs flex items-center justify-center gap-2 cursor-pointer transition-all active:scale-[0.98] touch-manipulation select-none"
          >
            <span>Lật thẻ xem đáp án</span>
            <kbd className="hidden sm:inline-block px-1.5 py-0.5 bg-white/20 rounded text-[10px] font-mono">
              Space
            </kbd>
          </Button>
        ) : (
          /* Hai nút đánh giá khi đã xem mặt sau */
          <div className="grid grid-cols-2 gap-3 w-full">
            <Button 
              variant="outline"
              onClick={() => handleAnswer(false)}
              className="w-full min-h-[52px] text-sm sm:text-base font-sans font-semibold border-[#FCA5A5] bg-[#FEF2F2] hover:bg-[#FEE2E2] text-[#B91C1C] rounded-2xl flex items-center justify-center gap-2 shadow-xs cursor-pointer transition-all active:scale-[0.98] touch-manipulation select-none"
            >
              <RotateCcw className="w-4 h-4 text-[#EF4444] shrink-0" />
              <span>Chưa nhớ</span>
              <kbd className="hidden sm:inline-block px-1.5 py-0.5 bg-red-200/60 rounded text-[10px] font-mono">
                1
              </kbd>
            </Button>

            <Button 
              variant="success"
              onClick={() => handleAnswer(true)}
              className="w-full min-h-[52px] text-sm sm:text-base font-sans font-semibold rounded-2xl flex items-center justify-center gap-2 shadow-xs cursor-pointer transition-all active:scale-[0.98] touch-manipulation select-none"
            >
              <Check className="w-4 h-4 shrink-0" />
              <span>Đã nhớ</span>
              <kbd className="hidden sm:inline-block px-1.5 py-0.5 bg-white/20 rounded text-[10px] font-mono">
                2
              </kbd>
            </Button>
          </div>
        )}
      </div>

    </div>
  )
}
