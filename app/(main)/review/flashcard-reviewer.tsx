'use client'

import React, { useState, useEffect, useCallback, useRef, useMemo } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { updateReviewStatusAction, revalidateReviewSessionAction } from './actions'
import { 
  CheckCircle2, 
  RotateCcw, 
  ArrowRight, 
  GraduationCap, 
  Layers, 
  Check, 
  Trophy, 
  Sparkles, 
  Flame, 
  BrainCircuit, 
  BookOpen, 
  Compass, 
  Flag,
  HelpCircle,
  Lightbulb
} from 'lucide-react'
import { toast } from 'sonner'
import { AudioButton } from '@/components/ui/audio-button'
import { AudioSpeedSelector } from '@/components/ui/audio-speed-selector'
import { stopAllAudio } from '@/lib/tts/tts-engine'
import { MascotAvatar, MascotState } from '@/components/mascot/mascot-avatar'

export type Vocab = {
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

type CompanionState = 
  | 'greeting'
  | 'thinking'
  | 'evaluating'
  | 'correct'
  | 'incorrect'
  | 'milestone_25'
  | 'milestone_50'
  | 'milestone_75'
  | 'completion'

// Hàm tính kích thước chữ Hán linh hoạt theo độ dài ký tự
function getHanziSizeClass(hanzi: string) {
  const len = hanzi ? hanzi.trim().length : 0
  if (len <= 2) return 'text-6xl sm:text-7xl md:text-8xl'
  if (len <= 4) return 'text-4xl sm:text-5xl md:text-6xl'
  return 'text-3xl sm:text-4xl md:text-5xl'
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
  const [companionState, setCompanionState] = useState<CompanionState>('greeting')
  const [lastActionTime, setLastActionTime] = useState<number>(() => Date.now())

  const cardRef = useRef<HTMLDivElement>(null)
  const touchStartXRef = useRef<number | null>(null)
  const touchStartYRef = useRef<number | null>(null)
  const milestoneTimeoutRef = useRef<NodeJS.Timeout | null>(null)

  const currentVocab = vocabs[currentIndex]
  const isFinished = currentIndex >= vocabs.length
  const progressPercent = vocabs.length > 0 ? Math.round((currentIndex / vocabs.length) * 100) : 0

  // 1. Quản lý trạng thái và lời thoại của Bạn đồng hành Tiểu Bút (Panda)
  const speechDialogue = useMemo(() => {
    switch (companionState) {
      case 'greeting':
        return 'Chào bạn! Tiểu Bút đã sẵn sàng đồng hành cùng bạn mài giũa trí nhớ hôm nay!'
      case 'thinking':
        if (currentIndex === 0) {
          return 'Hãy quan sát chữ Hán này và thử nhớ lại cách đọc Pinyin cùng ý nghĩa nhé!'
        }
        return 'Tập trung vào cấu trúc chữ xem nào. Đừng vội, hãy phát âm thầm trong đầu trước khi lật!'
      case 'evaluating':
        return 'Đáp án đã hiện ra! Bạn có nhớ chính xác cách đọc và ý nghĩa của từ này không?'
      case 'correct':
        return 'Xuất sắc! Thêm một từ đã khắc sâu vào trí nhớ dài hạn của bạn! ✨'
      case 'incorrect':
        return 'Không sao cả! Lặp lại ngắt quãng chính là chìa khóa ghi nhớ bền vững. Tiểu Bút sẽ nhắc lại sớm nhé! 🌱'
      case 'milestone_25':
        return 'Tuyệt vời! Bạn đã vượt qua 1/4 chặng đường rồi! Giữ vững đà này nhé! 🚀'
      case 'milestone_50':
        return 'Đã được một nửa chặng đường rồi! Trí não của bạn đang hoạt động cực kỳ hiệu quả! ⭐'
      case 'milestone_75':
        return 'Sắp về đích rồi! Chỉ còn một vài từ nữa thôi, cố gắng lên nào! 🎯'
      case 'completion':
        return 'Hoan hô! Bạn đã hoàn thành toàn bộ mục tiêu ôn tập hôm nay! Bạn thật chăm chỉ và kiên trì! 🏆'
      default:
        return 'Tiểu Bút luôn ở đây cùng bạn chinh phục từng chữ Hán!'
    }
  }, [companionState, currentIndex])

  // Chọn hình ảnh đại diện của Mascot 3D Tiểu Bút phù hợp theo trạng thái
  const mascotAsset = useMemo(() => {
    switch (companionState) {
      case 'greeting':
        return {
          src: '/images/panda/panda-welcome.webp',
          alt: 'Tiểu Bút chào đón bạn',
          svgFallbackState: 'open' as MascotState,
        }
      case 'thinking':
        return {
          src: '/images/panda/panda-thinking.webp',
          alt: 'Tiểu Bút đang cùng suy nghĩ',
          svgFallbackState: 'thinking' as MascotState,
        }
      case 'evaluating':
        return {
          src: '/images/panda/panda-studying.webp',
          alt: 'Tiểu Bút đối chiếu đáp án',
          svgFallbackState: 'idle' as MascotState,
        }
      case 'correct':
      case 'milestone_25':
      case 'milestone_50':
      case 'milestone_75':
      case 'completion':
        return {
          src: '/images/panda/panda-celebration.webp',
          alt: 'Tiểu Bút ăn mừng cùng bạn',
          svgFallbackState: 'success' as MascotState,
        }
      case 'incorrect':
        return {
          src: '/images/panda/panda-studying.webp',
          alt: 'Tiểu Bút động viên bạn cố gắng',
          svgFallbackState: 'error' as MascotState,
        }
    }
  }, [companionState])

  // Chuyển sang trạng thái suy nghĩ khi bắt đầu thẻ mới
  useEffect(() => {
    if (isFinished) {
      setCompanionState('completion')
      return
    }
    if (!showAnswer) {
      // Khi ở mặt trước
      const timer = setTimeout(() => {
        setCompanionState('thinking')
      }, companionState === 'greeting' ? 2200 : 200)
      return () => clearTimeout(timer)
    } else {
      // Khi đã lật xem mặt sau
      setCompanionState('evaluating')
    }
  }, [currentIndex, showAnswer, isFinished])

  // Lật thẻ an toàn
  const handleFlip = useCallback(() => {
    if (!showAnswer) {
      setShowAnswer(true)
      setCompanionState('evaluating')
    }
  }, [showAnswer])

  // Xử lý đánh giá: Quên rồi (false) hoặc Đã nhớ (true) - Tối ưu Optimistic UI tức thì (0ms)
  const handleAnswer = useCallback((isRemembered: boolean) => {
    if (!currentVocab) return
    stopAllAudio()

    const targetVocab = currentVocab
    const nextIndex = currentIndex + 1
    const total = vocabs.length

    // 1. Phản hồi giao diện tức thì (Optimistic 0ms UI)
    if (isRemembered) {
      setRememberedCount((c) => c + 1)
    } else {
      setForgotCount((c) => c + 1)
    }

    // Kiểm tra các cột mốc hành trình (25%, 50%, 75%)
    const prevPercent = Math.round((currentIndex / total) * 100)
    const nextPercent = Math.round((nextIndex / total) * 100)

    let reachedMilestone: CompanionState | null = null
    if (prevPercent < 25 && nextPercent >= 25 && nextIndex < total) {
      reachedMilestone = 'milestone_25'
    } else if (prevPercent < 50 && nextPercent >= 50 && nextIndex < total) {
      reachedMilestone = 'milestone_50'
    } else if (prevPercent < 75 && nextPercent >= 75 && nextIndex < total) {
      reachedMilestone = 'milestone_75'
    }

    if (nextIndex >= total) {
      setCompanionState('completion')
    } else if (reachedMilestone) {
      setCompanionState(reachedMilestone)
      if (milestoneTimeoutRef.current) clearTimeout(milestoneTimeoutRef.current)
      milestoneTimeoutRef.current = setTimeout(() => {
        setCompanionState('thinking')
      }, 2500)
    } else {
      setCompanionState(isRemembered ? 'correct' : 'incorrect')
    }

    setShowAnswer(false)
    setCurrentIndex(nextIndex)
    setLastActionTime(Date.now())

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
        if (nextIndex >= total) {
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

  // Lắng nghe phím tắt: Space để lật, 1: Chưa nhớ, 2: Đã nhớ, Phím mũi tên
  useEffect(() => {
    if (isFinished) return

    const handleKeyDown = (e: KeyboardEvent) => {
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

  // Touch Swipe Gesture
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
  // 1. MÀN HÌNH HOÀN THÀNH PHIÊN ÔN TẬP (CELEBRATION JOURNEY)
  // ========================================================
  if (isFinished) {
    const accuracy = (rememberedCount + forgotCount) > 0 
      ? Math.round((rememberedCount / (rememberedCount + forgotCount)) * 100) 
      : 100

    return (
      <div className="max-w-2xl mx-auto py-8 sm:py-12 px-4 sm:px-8 rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] shadow-xs hover:shadow-md text-center space-y-6 sm:space-y-8 animate-in fade-in zoom-in-95 duration-300">
        
        {/* Banner chúc mừng cùng Mascot 3D */}
        <div className="flex flex-col items-center justify-center space-y-3">
          <div className="relative w-36 h-36 sm:w-44 sm:h-44 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs bg-[#FFF9F3] dark:bg-[#202B45] flex items-center justify-center mascot-animated">
            <Image
              src="/images/panda/panda-celebration.webp"
              alt="Tiểu Bút ăn mừng hoàn thành phiên ôn tập"
              fill
              sizes="(max-width: 640px) 144px, 176px"
              className="object-cover"
              priority
            />
          </div>

          <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-emerald-500/10 text-emerald-800 dark:text-emerald-300 text-xs font-serif font-bold border border-emerald-500/30">
            <Sparkles className="w-4 h-4 text-emerald-600 animate-spin" />
            <span>Mục Tiêu Ôn Tập Hoàn Thành Xuất Sắc!</span>
          </div>
        </div>

        {/* Bong bóng hội thoại chúc mừng của Tiểu Bút */}
        <div className="relative max-w-lg mx-auto bg-[#FFFDF9] dark:bg-[#1F2C47] border border-[#182238]/15 dark:border-white/10 rounded-2xl p-4 sm:p-5 shadow-xs text-left">
          <div className="flex items-start gap-3">
            <span className="text-2xl shrink-0">🐼</span>
            <div>
              <p className="text-xs font-bold text-[#B8322D] uppercase tracking-wider font-sans">
                Tiểu Bút nhắn nhủ bạn
              </p>
              <p className="text-sm font-serif text-[#182238] dark:text-white mt-0.5 leading-relaxed">
                &ldquo;Bạn đã hoàn thành toàn bộ <strong>{vocabs.length}</strong> từ vựng cần ôn hôm nay với tỷ lệ nhớ <strong>{accuracy}%</strong>! Thuật toán Spaced Repetition đã tự động lên lịch cho chu kỳ tiếp theo.&rdquo;
              </p>
            </div>
          </div>
        </div>

        {/* Bảng thống kê số liệu thực tế */}
        <div className="grid grid-cols-3 gap-3 p-4 sm:p-5 rounded-2xl bg-[#FAF7F2] dark:bg-[#141A23] border border-[#182238]/15 dark:border-white/10 max-w-md mx-auto text-center font-serif shadow-xs">
          <div>
            <p className="text-xs text-muted font-sans font-medium">Tổng số thẻ</p>
            <p className="text-2xl sm:text-3xl font-bold text-[#182238] dark:text-white mt-1">{vocabs.length}</p>
          </div>
          <div className="border-x border-[#182238]/15 dark:border-white/10">
            <p className="text-xs text-emerald-600 font-sans font-bold">Đã nhớ tốt</p>
            <p className="text-2xl sm:text-3xl font-bold text-emerald-600 mt-1">{rememberedCount}</p>
          </div>
          <div>
            <p className="text-xs text-[#B8322D] font-sans font-bold">Cần củng cố</p>
            <p className="text-2xl sm:text-3xl font-bold text-[#B8322D] mt-1">{forgotCount}</p>
          </div>
        </div>

        {/* Các nút điều hướng tiếp tục hành trình */}
        <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3 max-w-md mx-auto">
          <Link href="/typing" className="w-full sm:w-auto flex-1">
            <Button className="w-full font-serif bg-[#182238] hover:bg-[#2A3250] text-white rounded-2xl text-xs sm:text-sm h-12 px-6 gap-2 border border-[#182238]/20 shadow-xs cursor-pointer active:scale-[0.98]">
              <span>Luyện gõ bàn phím IME</span>
              <ArrowRight className="w-4 h-4" />
            </Button>
          </Link>

          <Link href="/topics?q=HSK 1" className="w-full sm:w-auto flex-1">
            <Button variant="outline" className="w-full font-serif border border-[#182238]/20 bg-white dark:bg-[#182238] hover:bg-[#FFF9F3] text-[#182238] dark:text-white rounded-2xl text-xs sm:text-sm h-12 px-6 gap-2 shadow-xs cursor-pointer active:scale-[0.98]">
              <GraduationCap className="w-4 h-4 text-[#B8322D]" />
              <span>Khám phá bài học mới</span>
            </Button>
          </Link>
        </div>
      </div>
    )
  }

  // ========================================================
  // 2. KHU VỰC ÔN TẬP VỚI BẠN ĐỒNG HÀNH (COMPANION LEARNING)
  // ========================================================
  return (
    <div className="w-full select-none">
      
      {/* ---------------------------------------------------- */}
      {/* A. MOBILE COMPANION BAR (HIỂN THỊ TRÊN MÀN HÌNH NHỎ < 1024PX) */}
      {/* ---------------------------------------------------- */}
      <div className="lg:hidden mb-5 space-y-3">
        {/* Thanh đồng hành nhỏ gọn ở đỉnh */}
        <div className="bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 rounded-2xl p-3 shadow-xs flex items-center gap-3">
          <div className="relative w-12 h-12 rounded-xl overflow-hidden border border-[#182238]/30 shrink-0 bg-[#FFF9F3]">
            <Image
              src={mascotAsset.src}
              alt={mascotAsset.alt}
              fill
              sizes="48px"
              className="object-cover"
            />
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center justify-between text-[11px] font-sans font-bold text-[#B8322D]">
              <span className="flex items-center gap-1">
                <span>Tiểu Bút 🐼</span>
                <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
              </span>
              <span className="text-muted font-normal">Thẻ {currentIndex + 1}/{vocabs.length}</span>
            </div>
            <p className="text-xs font-serif text-[#182238] dark:text-white truncate mt-0.5">
              {speechDialogue}
            </p>
          </div>
        </div>

        {/* Thanh tiến độ vi mô trên mobile */}
        <div className="space-y-1">
          <div className="flex items-center justify-between text-[11px] font-sans text-muted">
            <span>Tiến độ: {progressPercent}%</span>
            <span>Đã nhớ: {rememberedCount} • Cần ôn: {forgotCount}</span>
          </div>
          <div className="w-full bg-[#E5DFD5] dark:bg-slate-700 h-2 rounded-full overflow-hidden">
            <div 
              className="h-full bg-gradient-to-r from-[#B8322D] to-[#F59E0B] rounded-full transition-all duration-300"
              style={{ width: `${progressPercent}%` }}
            />
          </div>
        </div>
      </div>

      {/* ---------------------------------------------------- */}
      {/* B. BỐ CỤC CHÍNH (DESKTOP GRID 12 CỘT HOẶC FLEXBOX)   */}
      {/* ---------------------------------------------------- */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 lg:gap-8 items-start">
        
        {/* ==================================================== */}
        {/* CỘT TRÁI (7 CỘT TRÊN DESKTOP): SÂN KHẤU FLASHCARD   */}
        {/* ==================================================== */}
        <div className="lg:col-span-8 space-y-4">
          
          {/* 1. Header hành trình ôn tập trên Desktop */}
          <div className="hidden lg:flex items-center justify-between text-xs font-serif text-muted pb-1">
            <div className="flex items-center gap-2.5">
              <span className="font-sans font-bold text-sm text-[#182238] dark:text-white">
                Thẻ số #{currentIndex + 1}
              </span>
              <span className="text-border-strong">•</span>
              <span className="text-xs">Còn lại {vocabs.length - currentIndex} thẻ</span>
              {currentVocab.hsk_level && (
                <span className="px-2 py-0.5 rounded-full bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30 text-[10px] font-sans font-bold">
                  {currentVocab.hsk_level}
                </span>
              )}
            </div>

            <div className="flex items-center gap-3">
              {/* Tùy chỉnh tốc độ phát âm chuẩn */}
              <div className="flex items-center gap-1.5">
                <span className="text-[11px] font-sans text-muted">Tốc độ phát âm:</span>
                <AudioSpeedSelector variant="dropdown" size="xs" />
              </div>
            </div>
          </div>

          {/* 2. Thanh hành trình Milestone Nodes (25%, 50%, 75%, 100%) */}
          <div className="hidden lg:block relative py-2">
            {/* Thanh nền */}
            <div className="w-full bg-[#E5DFD5] dark:bg-slate-700 h-2 rounded-full overflow-hidden">
              <div 
                className="h-full bg-gradient-to-r from-[#B8322D] to-[#F59E0B] rounded-full transition-all duration-300"
                style={{ width: `${progressPercent}%` }}
              />
            </div>

            {/* Các điểm mốc chặng đường */}
            <div className="absolute top-1/2 -translate-y-1/2 left-0 right-0 flex justify-between px-1 pointer-events-none">
              {[
                { percent: 25, label: '25%' },
                { percent: 50, label: '50%' },
                { percent: 75, label: '75%' },
                { percent: 100, label: 'Đích' }
              ].map((m) => {
                const isPassed = progressPercent >= m.percent
                const isCurrent = progressPercent >= m.percent - 15 && progressPercent < m.percent
                return (
                  <div key={m.percent} className="flex flex-col items-center">
                    <div className={`w-4 h-4 rounded-full border-2 transition-all duration-200 flex items-center justify-center text-[8px] font-bold ${
                      isPassed
                        ? 'bg-[#B8322D] border-[#182238] text-white shadow-xs'
                        : isCurrent
                        ? 'bg-amber-400 border-[#182238] animate-pulse text-[#182238]'
                        : 'bg-white dark:bg-[#182238] border-muted/50 text-muted'
                    }`}>
                      {isPassed ? '✓' : ''}
                    </div>
                  </div>
                )
              })}
            </div>
          </div>

          {/* 3. KHỐI THẺ 3D FLIP TỰ NHIÊN */}
          <div className="perspective-1000 w-full">
            <div 
              ref={cardRef}
              onClick={handleFlip}
              onTouchStart={handleTouchStart}
              onTouchEnd={handleTouchEnd}
              className={`transform-style-3d transition-transform duration-300 ease-out relative w-full grid grid-cols-1 grid-rows-1 min-h-[380px] sm:min-h-[440px] cursor-pointer touch-pan-y ${
                showAnswer ? 'rotate-y-180' : ''
              }`}
              role="button"
              tabIndex={0}
              aria-label={showAnswer ? 'Mặt sau thẻ từ vựng' : 'Mặt trước thẻ từ vựng, chạm để lật thẻ'}
            >
              {/* ---------------------------------------------------- */}
              {/* MẶT TRƯỚC FLASHCARD (CHỮ HÁN NỔI BẬT & BỘ THỦ)       */}
              {/* ---------------------------------------------------- */}
              <div className={`col-start-1 row-start-1 w-full rounded-[22px] bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md p-5 sm:p-7 md:p-8 flex flex-col justify-between items-center transition-colors [backface-visibility:hidden] relative overflow-hidden ${
                showAnswer ? 'pointer-events-none select-none opacity-0 md:opacity-100' : 'opacity-100'
              }`}>
                
                {/* Dải màu accent đầu thẻ */}
                <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-[#182238] via-[#B8322D] to-[#F59E0B]" />

                {/* Họa tiết hoa văn chìm thư pháp cổ điển */}
                <div className="absolute -right-6 -bottom-8 select-none pointer-events-none opacity-[0.04] dark:opacity-[0.06] font-hanzi text-9xl font-bold text-[#182238] dark:text-white">
                  学
                </div>

                {/* Header thẻ mặt trước */}
                <div className="w-full flex items-center justify-between text-xs text-muted font-serif relative z-10">
                  <div className="flex items-center gap-2">
                    <span className="px-2.5 py-0.5 rounded-lg bg-[#FAF7F2] dark:bg-[#202B45] border border-[#182238]/15 text-[11px] font-sans font-bold text-[#182238] dark:text-slate-200">
                      Chữ Hán
                    </span>
                    {currentVocab.hsk_level && (
                      <span className="px-2.5 py-0.5 rounded-lg bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/20 text-[11px] font-sans font-bold">
                        {currentVocab.hsk_level}
                      </span>
                    )}
                  </div>
                  <span className="text-xs font-sans font-bold text-muted/80">
                    #{currentIndex + 1} / {vocabs.length}
                  </span>
                </div>

                {/* Trọng tâm: Chữ Hán kích thước lớn & Nút phát âm trực quan */}
                <div className="flex-1 w-full flex flex-col items-center justify-center py-6 space-y-4 relative z-10">
                  <div className="flex items-center justify-center gap-3 sm:gap-5 flex-wrap text-center">
                    <span className={`font-hanzi font-serif font-bold text-[#182238] dark:text-white tracking-wide leading-none drop-shadow-xs ${getHanziSizeClass(currentVocab.hanzi)}`}>
                      {currentVocab.hanzi}
                    </span>
                    <div onClick={(e) => e.stopPropagation()} className="shrink-0">
                      <AudioButton 
                        text={currentVocab.hanzi} 
                        id={`fc-front-${currentVocab.id}`} 
                        size="lg" 
                        variant="subtle" 
                        tooltip="Nghe phát âm chuẩn giọng Bắc Kinh" 
                      />
                    </div>
                  </div>

                  <p className="text-xs text-muted font-serif text-center max-w-xs">
                    Thử nhớ lại thanh điệu, phiên âm Pinyin và nghĩa tiếng Việt
                  </p>
                </div>

                {/* Footer thẻ: Gợi ý thao tác */}
                <div className="pt-2 text-center relative z-10">
                  <p className="text-xs text-muted font-serif flex items-center justify-center gap-1.5 bg-[#FAF7F2] dark:bg-[#141A23] px-3.5 py-1.5 rounded-full border border-[#182238]/10">
                    <Lightbulb className="w-3.5 h-3.5 text-amber-500 shrink-0" />
                    <span>Chạm vào thẻ hoặc nhấn [Space] để lật xem đáp án</span>
                  </p>
                </div>
              </div>

              {/* ---------------------------------------------------- */}
              {/* MẶT SAU FLASHCARD (PINYIN + NGHĨA + CÂU VÍ DỤ)       */}
              {/* ---------------------------------------------------- */}
              <div className={`col-start-1 row-start-1 w-full rounded-[22px] bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md p-5 sm:p-7 md:p-8 flex flex-col justify-between items-center [backface-visibility:hidden] [transform:rotateY(180deg)] relative overflow-hidden ${
                !showAnswer ? 'pointer-events-none select-none opacity-0 md:opacity-100' : 'opacity-100'
              }`}>
                
                {/* Dải màu accent son Chu Sa */}
                <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-[#B8322D] via-[#D97706] to-[#10B981]" />

                {/* Họa tiết hoa văn chìm */}
                <div className="absolute -left-6 -bottom-8 select-none pointer-events-none opacity-[0.04] dark:opacity-[0.06] font-hanzi text-9xl font-bold text-[#182238] dark:text-white">
                  记
                </div>

                {/* Header thẻ mặt sau */}
                <div className="w-full flex items-center justify-between text-xs text-muted font-serif relative z-10">
                  <div className="flex items-center gap-2">
                    <span className="px-2.5 py-0.5 rounded-lg bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30 text-[11px] font-sans font-bold">
                      Đáp án chi tiết
                    </span>
                    {currentVocab.hsk_level && (
                      <span className="px-2.5 py-0.5 rounded-lg bg-[#FAF7F2] dark:bg-[#202B45] border border-[#182238]/15 text-[11px] font-sans font-bold text-[#182238] dark:text-white">
                        {currentVocab.hsk_level}
                      </span>
                    )}
                  </div>
                  <span className="text-xs font-sans font-bold text-muted/80">
                    #{currentIndex + 1} / {vocabs.length}
                  </span>
                </div>

                {/* Nội dung chi tiết: Pinyin, Chữ Hán, Nghĩa & Ví dụ */}
                <div className="flex-1 w-full flex flex-col items-center justify-center py-4 space-y-3.5 text-center relative z-10">
                  
                  {/* Phiên âm Pinyin sắc nét */}
                  <p className="text-2xl sm:text-3xl font-sans tracking-widest text-[#B8322D] font-bold">
                    {currentVocab.pinyin}
                  </p>

                  {/* Chữ Hán to bản kèm nút nghe phát âm */}
                  <div className="flex items-center justify-center gap-3">
                    <span className="text-3xl sm:text-4xl font-hanzi font-serif font-bold text-[#182238] dark:text-white leading-tight">
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

                  {/* Nghĩa tiếng Việt đóng khung như ấn triện hoàng gia */}
                  <div className="bg-[#FFF5F5] dark:bg-[#B8322D]/10 border border-[#B8322D]/30 px-6 py-2.5 rounded-2xl max-w-md mx-auto shadow-xs">
                    <span className="text-base sm:text-xl font-serif text-[#182238] dark:text-white font-bold break-words">
                      {currentVocab.meaning_vi}
                    </span>
                  </div>

                  {/* Câu ví dụ ngữ cảnh nếu có */}
                  {currentVocab.example_hanzi && (
                    <div className="w-full bg-[#FAF7F2] dark:bg-[#141A23] border border-[#182238]/15 dark:border-white/10 rounded-2xl p-3 sm:p-4 max-w-md mx-auto text-center space-y-1">
                      <p className="text-xs sm:text-sm font-sans text-[#B8322D] font-medium tracking-wide">
                        {currentVocab.example_pinyin}
                      </p>
                      <div className="text-sm sm:text-base font-hanzi text-[#182238] dark:text-white flex items-center justify-center gap-2">
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
                      <p className="text-xs sm:text-sm font-sans text-muted">
                        {currentVocab.example_vi}
                      </p>
                    </div>
                  )}
                </div>

                {/* Footer thẻ: Gợi ý đánh giá */}
                <div className="pt-1 text-center relative z-10">
                  <p className="text-xs text-muted font-sans flex items-center justify-center gap-1">
                    <span>Đánh giá độ nhớ bên dưới để chuyển tiếp</span>
                  </p>
                </div>
              </div>
            </div>
          </div>

          {/* 4. CỤM NÚT ĐÁNH GIÁ MỨC ĐỘ GHI NHỚ THEO THUẬT TOÁN SM-2 */}
          <div className="pt-2">
            {!showAnswer ? (
              /* Nút lật thẻ khi đang ở mặt trước */
              <Button 
                onClick={handleFlip}
                className="w-full h-14 text-base font-serif font-bold rounded-2xl bg-[#B8322D] hover:bg-[#9E2A25] text-white border border-[#B8322D]/40 shadow-xs hover:shadow-md flex items-center justify-center gap-2 cursor-pointer transition-all active:scale-[0.98] select-none"
              >
                <span>Lật thẻ xem đáp án</span>
                <kbd className="hidden sm:inline-block px-2 py-0.5 bg-white/20 rounded-md text-xs font-mono text-white">
                  Space
                </kbd>
              </Button>
            ) : (
              /* Hai nút đánh giá khi đã xem đáp án */
              <div className="grid grid-cols-2 gap-3.5 w-full">
                <button 
                  type="button"
                  onClick={() => handleAnswer(false)}
                  className="w-full h-14 text-sm sm:text-base font-serif font-bold border border-[#EF4444]/40 bg-[#FEF2F2] hover:bg-[#FEE2E2] text-[#B91C1C] rounded-2xl flex items-center justify-center gap-2 shadow-xs hover:shadow-md cursor-pointer transition-all active:scale-[0.98] select-none"
                >
                  <RotateCcw className="w-4 h-4 text-[#EF4444] shrink-0" />
                  <span>Chưa nhớ</span>
                  <kbd className="hidden sm:inline-block px-2 py-0.5 bg-red-200/70 rounded-md text-xs font-mono text-red-900">
                    1
                  </kbd>
                </button>

                <button 
                  type="button"
                  onClick={() => handleAnswer(true)}
                  className="w-full h-14 text-sm sm:text-base font-serif font-bold border border-[#10B981]/40 bg-[#ECFDF5] hover:bg-[#D1FAE5] text-[#065F46] rounded-2xl flex items-center justify-center gap-2 shadow-xs hover:shadow-md cursor-pointer transition-all active:scale-[0.98] select-none"
                >
                  <Check className="w-4 h-4 text-[#10B981] shrink-0 stroke-[3]" />
                  <span>Đã nhớ</span>
                  <kbd className="hidden sm:inline-block px-2 py-0.5 bg-emerald-200/70 rounded-md text-xs font-mono text-emerald-900">
                    2
                  </kbd>
                </button>
              </div>
            )}
          </div>

          {/* Gợi ý phím tắt tiện ích */}
          <div className="text-center pt-1 hidden sm:block">
            <span className="text-[11px] text-muted font-sans">
              Phím tắt nhanh: <strong>[Space]</strong> lật thẻ • <strong>[1 / ←]</strong> Chưa nhớ • <strong>[2 / →]</strong> Đã nhớ
            </span>
          </div>
        </div>

        {/* ==================================================== */}
        {/* CỘT PHẢI (4 CỘT TRÊN DESKTOP): BẠN ĐỒNG HÀNH TIỂU BÚT */}
        {/* ==================================================== */}
        <div className="hidden lg:block lg:col-span-4 space-y-5 sticky top-24">
          
          {/* Card Bạn đồng hành Tiểu Bút 3D */}
          <div className="bg-white/95 dark:bg-[#182238]/95 backdrop-blur-md rounded-[22px] border border-[#182238]/12 dark:border-white/10 p-5 shadow-xs hover:shadow-md space-y-4">
            
            {/* Header Mascot */}
            <div className="flex items-center justify-between pb-3 border-b border-[#182238]/10 dark:border-white/10">
              <div className="flex items-center gap-2">
                <span className="w-2.5 h-2.5 rounded-full bg-emerald-500 animate-pulse" />
                <span className="text-xs font-bold font-sans text-[#182238] dark:text-white uppercase tracking-wider">
                  Bạn Đồng Hành
                </span>
              </div>
              <span className="text-[10px] font-sans font-bold px-2 py-0.5 rounded-full bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/20">
                Tiểu Bút 🐼
              </span>
            </div>

            {/* Mascot 3D Image & Lời thoại */}
            <div className="flex flex-col items-center space-y-3 pt-1">
              <div className="relative w-32 h-32 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs bg-[#FFF9F3] dark:bg-[#202B45] mascot-animated">
                <Image
                  src={mascotAsset.src}
                  alt={mascotAsset.alt}
                  fill
                  sizes="128px"
                  className="object-cover"
                  priority
                />
              </div>

              {/* Bong bóng hội thoại có đuôi chỉ vào Mascot */}
              <div className="relative w-full bg-[#FAF7F2] dark:bg-[#202B45] border border-[#182238]/15 dark:border-white/10 rounded-2xl p-3.5 shadow-xs">
                {/* Đuôi mũi tên bong bóng */}
                <div className="absolute -top-2 left-1/2 -translate-x-1/2 w-3 h-3 bg-[#FAF7F2] dark:bg-[#202B45] border-t border-l border-[#182238]/15 dark:border-white/10 rotate-45" />

                <p className="text-xs font-serif text-[#182238] dark:text-white leading-relaxed text-center">
                  &ldquo;{speechDialogue}&rdquo;
                </p>
              </div>
            </div>

            {/* Chỉ số hành trình phiên học */}
            <div className="pt-2 space-y-2 border-t border-[#182238]/10 dark:border-white/10">
              <div className="flex items-center justify-between text-xs font-serif text-muted">
                <span>Tiến độ phiên:</span>
                <strong className="text-[#182238] dark:text-white font-sans">{progressPercent}%</strong>
              </div>

              <div className="grid grid-cols-2 gap-2 text-center font-serif text-xs">
                <div className="bg-[#FAF7F2] dark:bg-[#141A23] p-2.5 rounded-xl border border-[#182238]/10">
                  <p className="text-[10px] text-emerald-600 font-sans font-bold">ĐÃ NHỚ</p>
                  <p className="text-lg font-bold text-emerald-600 mt-0.5">{rememberedCount}</p>
                </div>
                <div className="bg-[#FAF7F2] dark:bg-[#141A23] p-2.5 rounded-xl border border-[#182238]/10">
                  <p className="text-[10px] text-[#B8322D] font-sans font-bold">CẦN ÔN LẠI</p>
                  <p className="text-lg font-bold text-[#B8322D] mt-0.5">{forgotCount}</p>
                </div>
              </div>
            </div>

            {/* Chú thích thuật toán Spaced Repetition */}
            <div className="p-3 rounded-xl bg-amber-500/10 border border-amber-500/20 text-[11px] font-serif text-amber-900 dark:text-amber-200 flex items-start gap-2">
              <BrainCircuit className="w-3.5 h-3.5 text-amber-600 shrink-0 mt-0.5" />
              <span>
                Thuật toán <strong>SM-2</strong> tự động gia hạn chu kỳ từ 3–7 ngày cho từ đã nhớ, và ôn lại ngay hôm nay cho từ bạn quên.
              </span>
            </div>

          </div>

          {/* Card gợi ý phím tắt gọn gàng */}
          <div className="bg-white/80 dark:bg-[#182238]/80 rounded-[20px] border border-[#182238]/12 dark:border-white/10 p-3.5 text-xs font-serif space-y-1.5 text-muted shadow-xs">
            <p className="font-bold font-sans text-[11px] uppercase text-[#182238] dark:text-white">
              Phím tắt bàn phím
            </p>
            <div className="flex items-center justify-between text-[11px]">
              <span>Lật thẻ xem mặt sau</span>
              <kbd className="px-1.5 py-0.5 bg-[#FAF7F2] dark:bg-slate-700 border border-[#182238]/20 rounded font-mono font-bold text-[#182238] dark:text-white">Space</kbd>
            </div>
            <div className="flex items-center justify-between text-[11px]">
              <span>Đánh giá &ldquo;Chưa nhớ&rdquo;</span>
              <kbd className="px-1.5 py-0.5 bg-[#FAF7F2] dark:bg-slate-700 border border-[#182238]/20 rounded font-mono font-bold text-[#182238] dark:text-white">1 hoặc ←</kbd>
            </div>
            <div className="flex items-center justify-between text-[11px]">
              <span>Đánh giá &ldquo;Đã nhớ&rdquo;</span>
              <kbd className="px-1.5 py-0.5 bg-[#FAF7F2] dark:bg-slate-700 border border-[#182238]/20 rounded font-mono font-bold text-[#182238] dark:text-white">2 hoặc →</kbd>
            </div>
          </div>

        </div>

      </div>

    </div>
  )
}
