'use client'

import { useState, useEffect, useCallback, useRef } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { updateReviewStatusAction, revalidateReviewSessionAction } from './actions'
import { 
  CheckCircle2, 
  XCircle, 
  Sparkles, 
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
}

// Hàm tính kích thước chữ Hán linh hoạt theo độ dài ký tự
function getHanziSizeClass(hanzi: string) {
  const len = hanzi ? hanzi.trim().length : 0
  if (len <= 2) return 'text-6xl sm:text-7xl md:text-8xl'
  if (len <= 4) return 'text-5xl sm:text-6xl md:text-7xl'
  return 'text-4xl sm:text-5xl'
}

export default function FlashcardReviewer({ vocabs, totalLearnedCount = 0 }: FlashcardReviewerProps) {
  const [currentIndex, setCurrentIndex] = useState(0)
  const [showAnswer, setShowAnswer] = useState(false)
  const [rememberedCount, setRememberedCount] = useState(0)
  const [forgotCount, setForgotCount] = useState(0)
  const cardRef = useRef<HTMLDivElement>(null)

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
  }, [currentVocab, currentIndex, vocabs.length])

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
            <Sparkles className="w-3.5 h-3.5" />
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
            <Button className="w-full sm:w-auto font-serif bg-title hover:bg-[#2A3250] text-white rounded-xl text-xs h-10 px-5 gap-2 shadow-xs cursor-pointer">
              <GraduationCap className="w-4 h-4" />
              <span>Học tiếp lộ trình HSK</span>
            </Button>
          </Link>
          <Link href="/" className="w-full sm:w-auto">
            <Button variant="outline" className="w-full sm:w-auto font-serif border-border rounded-xl text-xs h-10 px-5 hover:bg-black/5 cursor-pointer">
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
      {/* 3. KHỐI FLASHCARD CHÍNH (HIỆU ỨNG 3D FLIP TỰ NHIÊN)       */}
      {/* ======================================================== */}
      <div className="perspective-1000 w-full">
        <div 
          ref={cardRef}
          onClick={handleFlip}
          className={`transform-style-3d transition-transform duration-300 ease-out relative w-full min-h-[380px] sm:min-h-[420px] cursor-pointer ${
            showAnswer ? 'rotate-y-180' : ''
          }`}
          role="button"
          tabIndex={0}
          aria-label={showAnswer ? 'Mặt sau thẻ từ vựng' : 'Mặt trước thẻ từ vựng, chạm để lật thẻ'}
        >
          {/* ---------------------------------------------------- */}
          {/* MẶT TRƯỚC FLASHCARD (CHỮ HÁN NỔI BẬT)                */}
          {/* ---------------------------------------------------- */}
          <div className="backface-hidden absolute inset-0 w-full h-full rounded-3xl bg-card border border-border/80 p-6 sm:p-8 flex flex-col justify-between items-center shadow-xs hover:border-app-accent/40 transition-colors overflow-hidden">
            
            {/* Thanh accent trên cùng */}
            <div className="absolute top-0 left-0 right-0 h-1 bg-border/60" />

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

            {/* Trọng tâm chữ Hán & Nút phát âm */}
            <div className="flex-1 flex flex-col items-center justify-center py-4 space-y-4">
              <div className="flex items-center justify-center gap-3 sm:gap-4">
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

            {/* Footer thẻ: Gợi ý lật thẻ */}
            <div className="pt-2 text-center">
              <p className="text-xs text-muted/80 font-serif flex items-center justify-center gap-1.5">
                <span>Chạm vào thẻ hoặc nhấn</span>
                <kbd className="px-1.5 py-0.5 bg-page border border-border rounded text-[10px] font-mono shadow-2xs">
                  Space
                </kbd>
                <span>để lật thẻ</span>
              </p>
            </div>
          </div>

          {/* ---------------------------------------------------- */}
          {/* MẶT SAU FLASHCARD (PINYIN + NGHĨA + CÂU VÍ DỤ)       */}
          {/* ---------------------------------------------------- */}
          <div className="backface-hidden rotate-y-180 absolute inset-0 w-full h-full rounded-3xl bg-card border border-border/80 p-6 sm:p-8 flex flex-col justify-between items-center shadow-xs overflow-y-auto no-scrollbar">
            
            {/* Thanh accent màu son trên cùng */}
            <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-app-accent via-app-accent/80 to-gold" />

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
            <div className="flex-1 w-full flex flex-col items-center justify-center py-3 space-y-4 text-center">
              
              {/* Pinyin thanh thoát */}
              <p className="text-xl sm:text-2xl font-sans tracking-widest text-app-accent font-semibold">
                {currentVocab.pinyin}
              </p>

              {/* Chữ Hán to bản kèm nút nghe */}
              <div className="flex items-center justify-center gap-3">
                <span className="text-4xl sm:text-5xl font-hanzi font-serif font-bold text-title leading-tight">
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
              <div className="bg-app-accent-soft/40 border border-app-accent/20 px-6 py-2 rounded-2xl max-w-md mx-auto shadow-2xs">
                <span className="text-lg sm:text-xl font-serif text-title font-bold">
                  {currentVocab.meaning_vi}
                </span>
              </div>

              {/* Câu ví dụ minh họa nếu có */}
              {currentVocab.example_hanzi && (
                <div className="w-full bg-page border border-border/70 rounded-2xl p-3.5 sm:p-4 max-w-md mx-auto text-center space-y-1">
                  <p className="text-[11px] font-sans text-muted tracking-wide">
                    {currentVocab.example_pinyin}
                  </p>
                  <div className="text-sm sm:text-base font-hanzi font-serif text-title flex items-center justify-center gap-2">
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
                  <p className="text-xs sm:text-sm font-serif text-body italic">
                    {currentVocab.example_vi}
                  </p>
                </div>
              )}
            </div>

            {/* Gợi ý phím tắt đánh giá */}
            <div className="pt-1 text-center">
              <p className="text-[11px] text-muted/70 font-serif">
                Nhấn phím 1 (Chưa nhớ) hoặc 2 (Đã nhớ) để qua thẻ tiếp theo
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* ======================================================== */}
      {/* 4. CỤM NÚT ĐIỀU HƯỚNG VÀ ĐÁNH GIÁ MỨC ĐỘ GHI NHỚ          */}
      {/* ======================================================== */}
      <div className="pt-2">
        {!showAnswer ? (
          /* Nút lật thẻ khi đang ở mặt trước */
          <Button 
            onClick={handleFlip}
            className="w-full h-12 sm:h-13 text-sm sm:text-base font-serif bg-app-accent hover:bg-accent-hover text-white rounded-2xl shadow-xs flex items-center justify-center gap-2 cursor-pointer transition-all active:scale-[0.99]"
          >
            <span>Lật thẻ xem đáp án</span>
            <kbd className="hidden sm:inline-block px-1.5 py-0.5 bg-white/20 rounded text-[10px] font-mono">
              Space
            </kbd>
          </Button>
        ) : (
          /* Hai nút đánh giá khi đã xem mặt sau */
          <div className="flex gap-3">
            <Button 
              variant="outline"
              onClick={() => handleAnswer(false)}
              className="flex-1 h-12 sm:h-13 text-xs sm:text-sm font-serif border-red-200 bg-red-50/70 hover:bg-red-100/80 text-red-700 rounded-2xl flex items-center justify-center gap-2 shadow-2xs cursor-pointer transition-all active:scale-[0.99]"
            >
              <RotateCcw className="w-4 h-4 text-red-500" />
              <span>Chưa nhớ</span>
              <kbd className="hidden sm:inline-block px-1.5 py-0.5 bg-red-200/60 rounded text-[10px] font-mono">
                1
              </kbd>
            </Button>

            <Button 
              onClick={() => handleAnswer(true)}
              className="flex-1 h-12 sm:h-13 text-xs sm:text-sm font-serif bg-jade hover:bg-jade/90 text-white rounded-2xl flex items-center justify-center gap-2 shadow-xs cursor-pointer transition-all active:scale-[0.99]"
            >
              <Check className="w-4 h-4" />
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
