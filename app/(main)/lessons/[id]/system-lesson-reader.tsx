'use client'

import { useState, useEffect, useCallback, useMemo } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import {
  ArrowLeft,
  ArrowRight,
  CheckCircle2,
  PlayCircle,
  Volume2,
  XCircle,
  BrainCircuit,
  Search,
  RotateCcw,
  Check,
  ChevronRight,
  HelpCircle,
  SlidersHorizontal,
  BookmarkCheck,
  Loader2,
  Keyboard,
  Sparkles,
  Layers,
  GraduationCap
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { AudioButton } from '@/components/ui/audio-button'
import { AudioSpeedSelector } from '@/components/ui/audio-speed-selector'
import { useChineseTTS } from '@/hooks/use-chinese-tts'
import { markVocabLearnedAction, revalidateReviewSessionAction } from '../../review/actions'
import { ttsEngine } from '@/lib/tts/tts-engine'
import { toast } from 'sonner'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import { MascotAvatar } from '@/components/mascot/mascot-avatar'

function getHanziSizeClass(hanzi: string) {
  const len = hanzi ? hanzi.trim().length : 0
  if (len <= 2) return 'text-6xl sm:text-7xl md:text-8xl'
  if (len <= 4) return 'text-5xl sm:text-6xl md:text-7xl'
  return 'text-4xl sm:text-5xl'
}

export type Vocabulary = {
  id: string
  hanzi: string
  pinyin: string
  meaning_vi: string
  example_hanzi?: string | null
  example_pinyin?: string | null
  example_vi?: string | null
}

export type AdjacentLesson = {
  id: string
  title: string
  lesson_number: number
} | null

interface SystemLessonReaderProps {
  lesson: {
    id: string
    title: string
    subtitle?: string | null
    hsk_level: string
    lesson_number: number
  }
  vocabularies: Vocabulary[]
  userVocabs: string[] // Array of learned vocabulary IDs
  prevLesson?: AdjacentLesson
  nextLesson?: AdjacentLesson
  isLoggedIn?: boolean
}

export default function SystemLessonReader({
  lesson,
  vocabularies,
  userVocabs,
  prevLesson,
  nextLesson,
  isLoggedIn = false,
}: SystemLessonReaderProps) {
  const { speak } = useChineseTTS()
  const { openLoginRequired } = useAuthModal()

  // State management
  const [localUserVocabs, setLocalUserVocabs] = useState<string[]>(userVocabs)
  const [isLearning, setIsLearning] = useState(false)
  const [learningIndex, setLearningIndex] = useState(0)
  const [showAnswer, setShowAnswer] = useState(false)
  const [pendingLearnAction, setPendingLearnAction] = useState<'learned' | 'unlearned' | null>(null)
  const isLearnPending = pendingLearnAction !== null
  const [searchQuery, setSearchQuery] = useState('')
  const [statusFilter, setStatusFilter] = useState<'all' | 'unlearned' | 'learned'>('all')
  const [updatingVocabId, setUpdatingVocabId] = useState<string | null>(null)

  // Track unlearned items during the session for targeted review
  const [unlearnedInSession, setUnlearnedInSession] = useState<string[]>([])

  // Cleanup TTS on unmount or navigation
  useEffect(() => {
    return () => {
      ttsEngine.stop()
    }
  }, [])

  // Toggle vocabulary learned status directly from the list (1-Click Optimistic UI)
  const handleToggleLearned = async (vocabId: string) => {
    if (!isLoggedIn) {
      const vocabItem = vocabularies.find((v) => v.id === vocabId)
      openLoginRequired({
        title: 'Bạn cần đăng nhập',
        description: vocabItem
          ? `Đăng nhập để đánh dấu từ "${vocabItem.hanzi}" đã thuộc và lưu tiến độ vào tài khoản.`
          : 'Đăng nhập để đánh dấu từ vựng đã học và đồng bộ tiến độ học tập của bạn.',
        onSuccess: () => {
          handleToggleLearned(vocabId)
        },
      })
      return
    }

    const isCurrentlyLearned = localUserVocabs.includes(vocabId)
    const newIsLearned = !isCurrentlyLearned

    // Optimistic UI update immediately (0ms latency)
    setLocalUserVocabs((prev) =>
      newIsLearned ? [...prev, vocabId] : prev.filter((id) => id !== vocabId)
    )
    setUpdatingVocabId(vocabId)

    try {
      await markVocabLearnedAction(vocabId, newIsLearned)
      if (newIsLearned) {
        toast.success('Đã ghi nhận thuộc từ vựng', { duration: 1500 })
      }
    } catch (err: unknown) {
      // Rollback on failure
      setLocalUserVocabs((prev) =>
        isCurrentlyLearned ? [...prev, vocabId] : prev.filter((id) => id !== vocabId)
      )
      const errorMsg = err instanceof Error ? err.message : String(err)
      if (errorMsg.includes('Server Action') || errorMsg.includes('was not found')) {
        toast.error('Mã nguồn vừa được cập nhật mới. Vui lòng nhấn F5 (Tải lại trang) để tiếp tục.', { duration: 4000 })
        return
      }
      toast.error('Không thể lưu trạng thái. Vui lòng thử lại sau.')
    } finally {
      setUpdatingVocabId(null)
    }
  }

  const handleLearnAnswer = async (isRemembered: boolean) => {
    if (isLearnPending) return
    setPendingLearnAction(isRemembered ? 'learned' : 'unlearned')
    const currentVocab = vocabularies[learningIndex]

    // Optimistically update
    if (isRemembered) {
      if (!localUserVocabs.includes(currentVocab.id)) {
        setLocalUserVocabs((prev) => [...prev, currentVocab.id])
      }
    } else {
      setUnlearnedInSession((prev) => Array.from(new Set([...prev, currentVocab.id])))
    }

    // Guest mode: do not call server action, advance smoothly with notification
    if (!isLoggedIn) {
      setShowAnswer(false)
      const nextIdx = learningIndex + 1
      setLearningIndex(nextIdx)
      setPendingLearnAction(null)
      toast.info('Đăng nhập để lưu tiến độ vĩnh viễn vào tài khoản', { duration: 2500 })
      return
    }

    try {
      await markVocabLearnedAction(currentVocab.id, isRemembered)
      setShowAnswer(false)
      const nextIdx = learningIndex + 1
      setLearningIndex(nextIdx)

      // Nếu đã hoàn thành thẻ cuối cùng, revalidate trong nền
      if (nextIdx >= vocabularies.length) {
        revalidateReviewSessionAction().catch(() => {})
      }
    } catch (err: unknown) {
      const errorMsg = err instanceof Error ? err.message : String(err)
      console.error('Learn answer error:', err)
      
      // Nếu là lỗi do trình duyệt mở từ trước khi sửa code (Server Action ID cũ)
      if (errorMsg.includes('Server Action') || errorMsg.includes('was not found')) {
        toast.error('Mã nguồn vừa được cập nhật mới. Vui lòng nhấn F5 (Tải lại trang) để tiếp tục.', { duration: 4000 })
        return
      }
      
      toast.error('Có lỗi khi lưu tiến độ. Bạn có thể bấm thử lại.')
    } finally {
      setPendingLearnAction(null)
    }
  }

  // Keyboard shortcuts in Flashcard Mode
  useEffect(() => {
    if (!isLearning || learningIndex >= vocabularies.length) return

    const handleKeyDown = (e: KeyboardEvent) => {
      // Ignore if user is typing in an input
      if (['INPUT', 'TEXTAREA'].includes((e.target as HTMLElement)?.tagName)) return

      if (e.code === 'Space' || e.code === 'Enter') {
        e.preventDefault()
        if (!showAnswer) {
          setShowAnswer(true)
          const currentVocab = vocabularies[learningIndex]
          if (currentVocab) {
            speak(currentVocab.hanzi, { id: `fc-${currentVocab.id}` })
          }
        }
      } else if (showAnswer && !isLearnPending) {
        if (e.key === '1' || e.key === 'ArrowLeft') {
          e.preventDefault()
          handleLearnAnswer(false)
        } else if (e.key === '2' || e.key === 'ArrowRight') {
          e.preventDefault()
          handleLearnAnswer(true)
        }
      }
    }

    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [isLearning, showAnswer, learningIndex, vocabularies, isLearnPending])

  // Filtered vocabularies for list view
  const filteredVocabularies = useMemo(() => {
    return vocabularies.filter((v) => {
      // 1. Status filter
      const isLearned = localUserVocabs.includes(v.id)
      if (statusFilter === 'learned' && !isLearned) return false
      if (statusFilter === 'unlearned' && isLearned) return false

      // 2. Search query filter
      if (searchQuery.trim()) {
        const q = searchQuery.trim().toLowerCase()
        const matchHanzi = v.hanzi.toLowerCase().includes(q)
        const matchPinyin = v.pinyin.toLowerCase().includes(q)
        const matchVi = v.meaning_vi.toLowerCase().includes(q)
        return matchHanzi || matchPinyin || matchVi
      }

      return true
    })
  }, [vocabularies, localUserVocabs, statusFilter, searchQuery])

  // Progress metrics
  const totalVocabs = vocabularies.length
  const learnedCount = localUserVocabs.filter((id) =>
    vocabularies.some((v) => v.id === id)
  ).length
  const progressPercent = totalVocabs > 0 ? Math.round((learnedCount / totalVocabs) * 100) : 0
  const isAllCompleted = totalVocabs > 0 && learnedCount >= totalVocabs

  const companionMessage = useMemo(() => {
    if (isAllCompleted) {
      return `Hoan hô! Bạn đã xuất sắc nắm vững toàn bộ ${totalVocabs} từ vựng của bài học này! Tiếp tục duy trì phong độ nhé! 🎉`
    }
    if (learnedCount > 0) {
      return `Rất tốt! Bạn đã thuộc ${learnedCount}/${totalVocabs} từ (${progressPercent}%). Hãy kiên trì học nốt những từ còn lại nhé!`
    }
    return `Chào bạn! Hãy cùng Tiểu Bút nghe phát âm, đối chiếu Pinyin và ghi nhớ từng từ vựng trong bài học này nhé!`
  }, [isAllCompleted, learnedCount, totalVocabs, progressPercent])

  // -------------------------------------------------------------
  // FLASHCARD / LEARNING MODE VIEW
  // -------------------------------------------------------------
  if (isLearning) {
    if (learningIndex >= vocabularies.length) {
      const sessionUnlearnedCount = unlearnedInSession.length

      return (
        <div className="max-w-xl mx-auto py-12 px-6 text-center font-serif space-y-6 rounded-3xl border border-border bg-card shadow-xs animate-in fade-in zoom-in-95 duration-200">
          <div className="flex justify-center">
            <MascotAvatar state="success" size="2xl" />
          </div>

          <div className="space-y-2">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-jade-soft text-jade text-xs font-serif font-bold border border-jade/20">
              <CheckCircle2 className="w-3.5 h-3.5" />
              <span>Hoàn thành xuất sắc bài học!</span>
            </div>
            <h2 className="text-2xl sm:text-3xl font-bold text-title">Xuất sắc hoàn thành!</h2>
            <p className="text-xs sm:text-sm text-muted max-w-sm mx-auto leading-relaxed">
              Bạn đã ôn tập xong toàn bộ {totalVocabs} từ vựng của{' '}
              <strong className="text-title font-semibold">{lesson.title}</strong>.
            </p>
          </div>

          {/* Result Card */}
          <div className="grid grid-cols-3 gap-2.5 p-4 rounded-2xl bg-page border border-border/80 max-w-sm mx-auto text-center font-serif">
            <div>
              <p className="text-[11px] text-muted">Tổng số từ</p>
              <p className="text-lg font-bold text-title mt-0.5">{totalVocabs}</p>
            </div>
            <div className="border-x border-border/80">
              <p className="text-[11px] text-jade font-medium">Đã thuộc</p>
              <p className="text-lg font-bold text-jade mt-0.5">{learnedCount}</p>
            </div>
            <div>
              <p className="text-[11px] text-amber-600 font-medium">Cần củng cố</p>
              <p className="text-lg font-bold text-amber-600 mt-0.5">{sessionUnlearnedCount}</p>
            </div>
          </div>

          {/* Action CTAs */}
          <div className="flex flex-col sm:flex-row items-center justify-center gap-3 pt-2">
            <Button
              variant="outline"
              onClick={() => {
                setLearningIndex(0)
                setShowAnswer(false)
                setUnlearnedInSession([])
              }}
              className="w-full sm:w-auto font-serif text-xs min-h-[44px] px-5 gap-2 border-[#E9DDD1] hover:bg-[#FFF9F3] cursor-pointer"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              <span>Học lại bài này</span>
            </Button>

            <Link
              href={`/typing?mode=hsk&hskLevel=${lesson.hsk_level ? lesson.hsk_level.replace('HSK', '').trim() : 1}&lessonId=${lesson.id}`}
              className="w-full sm:w-auto"
            >
              <Button
                variant="secondary"
                className="w-full sm:w-auto font-serif text-xs min-h-[44px] px-4 gap-2 cursor-pointer"
              >
                <Keyboard className="w-3.5 h-3.5 text-app-accent" />
                <span>Luyện gõ câu ví dụ vừa học</span>
              </Button>
            </Link>

            {nextLesson ? (
              <Link href={`/lessons/${nextLesson.id}`} className="w-full sm:w-auto">
                <Button variant="tertiary" className="w-full sm:w-auto font-serif text-xs min-h-[44px] px-5 gap-2 cursor-pointer">
                  <span>Sang {nextLesson.title}</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </Button>
              </Link>
            ) : (
              <Button
                variant="primary"
                onClick={() => setIsLearning(false)}
                className="w-full sm:w-auto font-serif text-xs min-h-[44px] px-5 gap-2 cursor-pointer"
              >
                <span>Xem danh sách từ</span>
              </Button>
            )}
          </div>
        </div>
      )
    }

    const currentVocab = vocabularies[learningIndex]
    const learningPercent = totalVocabs > 0 ? Math.round(((learningIndex) / totalVocabs) * 100) : 0

    return (
      <div className="w-full max-w-3xl mx-auto py-6 font-serif px-4 space-y-6 select-none">
        
        {/* Top bar controls */}
        <div className="space-y-2">
          <div className="flex justify-between items-center text-xs text-muted">
            <button
              onClick={() => {
                ttsEngine.stop()
                setIsLearning(false)
              }}
              className="flex items-center gap-1.5 text-body hover:text-app-accent transition-colors font-medium cursor-pointer"
            >
              <ArrowLeft className="w-4 h-4" />
              <span>Thoát chế độ học</span>
            </button>

            <div className="flex items-center gap-2.5">
              {/* Tùy chọn tốc độ âm thanh 6 mức toàn hệ thống */}
              <AudioSpeedSelector variant="dropdown" size="xs" />
              <span className="font-sans font-semibold text-title text-xs bg-page px-2 py-0.5 rounded-lg border border-border">
                {learningIndex + 1} / {totalVocabs}
              </span>
            </div>
          </div>

          {/* Mini Progress Bar */}
          <div className="w-full bg-track h-1.5 rounded-full overflow-hidden">
            <div 
              className="h-full bg-gradient-to-r from-app-accent to-gold rounded-full transition-all duration-300"
              style={{ width: `${learningPercent}%` }}
            />
          </div>
        </div>

        {/* 3D Flashcard Box */}
        <div className="perspective-1000 w-full">
          <div
            onClick={() => {
              if (!showAnswer) {
                setShowAnswer(true)
                speak(currentVocab.hanzi, { id: `fc-${currentVocab.id}` })
              }
            }}
            className={`transform-style-3d transition-transform duration-300 ease-out relative w-full min-h-[340px] sm:min-h-[420px] cursor-pointer touch-pan-y ${
              showAnswer ? 'rotate-y-180' : ''
            }`}
            role="button"
            tabIndex={0}
            aria-label={showAnswer ? 'Mặt sau thẻ từ vựng' : 'Mặt trước thẻ từ vựng, chạm để lật thẻ'}
          >
            {/* MẶT TRƯỚC FLASHCARD */}
            <div className="backface-hidden absolute inset-0 w-full h-full rounded-[22px] bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md p-4 sm:p-6 md:p-8 flex flex-col justify-between items-center transition-all overflow-hidden">
              <div className="absolute top-0 left-0 right-0 h-1 bg-border/60" />

              <div className="w-full flex items-center justify-between text-xs text-muted font-serif">
                <span className="px-2 py-0.5 rounded-md bg-page border border-border/60 text-[10px] font-sans">
                  Chữ Hán
                </span>
                <span className="text-[11px] font-sans text-muted/70">
                  #{learningIndex + 1}
                </span>
              </div>

              <div className="flex-1 flex flex-col items-center justify-center py-4 space-y-4">
                <div className="flex items-center justify-center gap-3 sm:gap-4">
                  <span className={`font-hanzi font-serif font-bold text-title tracking-wide leading-none ${getHanziSizeClass(currentVocab.hanzi)}`}>
                    {currentVocab.hanzi}
                  </span>
                  <div onClick={(e) => e.stopPropagation()}>
                    <AudioButton
                      text={currentVocab.hanzi}
                      id={`fc-${currentVocab.id}`}
                      size="lg"
                      variant="subtle"
                      tooltip="Nghe phát âm chuẩn"
                    />
                  </div>
                </div>
              </div>

              <div className="pt-2 text-center">
                <p className="text-xs text-muted/80 font-serif flex items-center justify-center gap-1.5">
                  <span>Chạm vào thẻ hoặc nhấn</span>
                  <kbd className="hidden sm:inline-block px-1.5 py-0.5 bg-page border border-border rounded text-[10px] font-mono shadow-2xs">
                    Space
                  </kbd>
                  <span>để lật thẻ</span>
                </p>
              </div>
            </div>

            {/* MẶT SAU FLASHCARD */}
            <div className="backface-hidden rotate-y-180 absolute inset-0 w-full h-full rounded-[22px] bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md p-4 sm:p-6 md:p-8 flex flex-col justify-between items-center overflow-y-auto no-scrollbar">
              <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-app-accent via-app-accent/80 to-gold" />

              <div className="w-full flex items-center justify-between text-xs text-muted font-serif">
                <span className="px-2 py-0.5 rounded-md bg-app-accent-soft text-app-accent border border-app-accent/20 text-[10px] font-sans font-medium">
                  Đáp án
                </span>
                <span className="text-[11px] font-sans text-muted/70">
                  #{learningIndex + 1}
                </span>
              </div>

              <div className="flex-1 w-full flex flex-col items-center justify-center py-3 space-y-4 text-center">
                <p className="text-xl sm:text-2xl font-sans tracking-widest text-app-accent font-semibold">
                  {currentVocab.pinyin}
                </p>

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

                <div className="bg-app-accent-soft/40 border border-app-accent/20 px-6 py-2 rounded-2xl max-w-md mx-auto shadow-2xs">
                  <span className="text-lg sm:text-xl font-serif text-title font-bold">
                    {currentVocab.meaning_vi}
                  </span>
                </div>

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

              <div className="pt-1 text-center">
                <p className="text-[11px] text-muted/70 font-serif">
                  Nhấn phím 1 (Chưa thuộc) hoặc 2 (Đã thuộc) để qua thẻ tiếp theo
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Action Controls */}
        <div className="pt-2">
          {!showAnswer ? (
            <Button
              variant="primary"
              className="w-full min-h-[50px] text-sm sm:text-base font-serif rounded-2xl shadow-2xs flex items-center justify-center gap-2 cursor-pointer transition-all active:scale-[0.98] touch-manipulation select-none"
              onClick={() => {
                setShowAnswer(true)
                speak(currentVocab.hanzi, { id: `fc-${currentVocab.id}` })
              }}
            >
              <span>Lật thẻ xem đáp án</span>
              <kbd className="hidden sm:inline-block px-1.5 py-0.5 bg-white/20 rounded text-[10px] font-mono">
                Space
              </kbd>
            </Button>
          ) : (
            <div className="flex gap-3">
              <Button
                variant="outline"
                disabled={isLearnPending}
                className="flex-1 min-h-[50px] text-xs sm:text-sm font-serif border-[#FCA5A5] bg-[#FEF2F2] hover:bg-[#FEE2E2] text-[#B91C1C] rounded-2xl flex items-center justify-center gap-2 shadow-2xs cursor-pointer transition-all active:scale-[0.98] touch-manipulation select-none disabled:opacity-60"
                onClick={() => handleLearnAnswer(false)}
              >
                {pendingLearnAction === 'unlearned' ? (
                  <>
                    <Loader2 className="w-3.5 h-3.5 animate-spin text-red-600" />
                    <span>Đang lưu...</span>
                  </>
                ) : (
                  <>
                    <XCircle className="w-4 h-4 text-red-500" />
                    <span>Chưa thuộc</span>
                  </>
                )}
                <kbd className="hidden sm:inline-block px-1.5 py-0.5 bg-red-200/60 rounded text-[10px] font-mono">
                  1
                </kbd>
              </Button>

              <Button
                variant="success"
                disabled={isLearnPending}
                className="flex-1 min-h-[50px] text-xs sm:text-sm font-serif rounded-2xl flex items-center justify-center gap-2 shadow-2xs cursor-pointer transition-all active:scale-[0.98] touch-manipulation select-none disabled:opacity-60"
                onClick={() => handleLearnAnswer(true)}
              >
                {pendingLearnAction === 'learned' ? (
                  <>
                    <Loader2 className="w-3.5 h-3.5 animate-spin text-white" />
                    <span>Đang lưu...</span>
                  </>
                ) : (
                  <>
                    <Check className="w-4 h-4" />
                    <span>Đã thuộc</span>
                  </>
                )}
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

  // -------------------------------------------------------------
  // LESSON OVERVIEW & VOCABULARY LIST VIEW (EXPANDED 2-COLUMN DESKTOP)
  // -------------------------------------------------------------
  return (
    <div className="w-full max-w-[1500px] mx-auto space-y-6 sm:space-y-8 font-serif pb-20 select-none">
      {/* 1. Header Card - Full Width Banner */}
      <div className="relative overflow-hidden bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 rounded-[22px] p-4 sm:p-6 md:p-8 shadow-xs hover:shadow-md transition-all space-y-5 sm:space-y-6">
        {/* Top accent line */}
        <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-[#182238] via-[#B8322D] to-[#F59E0B]" />

        {/* Decorative Watermark */}
        <div className="absolute -right-4 -bottom-6 select-none pointer-events-none opacity-[0.05] dark:opacity-[0.08] font-hanzi text-8xl md:text-9xl font-bold text-[#182238] dark:text-white">
          课文
        </div>

        {/* Top Breadcrumb & Next/Prev Switcher */}
        <div className="relative z-10 flex items-center justify-between pb-4 border-b border-border/60 text-xs">
          <Link
            href={`/topics?q=${encodeURIComponent(lesson.hsk_level)}`}
            className="inline-flex items-center gap-1.5 text-muted hover:text-[#B8322D] transition-colors font-medium"
          >
            <ArrowLeft className="w-3.5 h-3.5" />
            <span>Danh sách {lesson.hsk_level}</span>
          </Link>

          {/* Adjacent Lessons Navigation */}
          <div className="flex items-center gap-2">
            {prevLesson ? (
              <Link
                href={`/lessons/${prevLesson.id}`}
                className="inline-flex items-center gap-1 px-3 py-1.5 rounded-xl border-2 border-[#182238]/20 hover:border-[#182238] text-body hover:text-[#B8322D] transition-all text-xs active:scale-95 touch-manipulation shadow-xs"
                title={prevLesson.title}
              >
                <ArrowLeft className="w-3.5 h-3.5" />
                <span className="hidden sm:inline">Bài {prevLesson.lesson_number}</span>
                <span className="sm:hidden">Trước</span>
              </Link>
            ) : (
              <span className="px-3 py-1.5 text-muted/40 text-xs select-none">
                Bài đầu
              </span>
            )}

            {nextLesson ? (
              <Link
                href={`/lessons/${nextLesson.id}`}
                className="inline-flex items-center gap-1 px-3 py-1.5 rounded-xl bg-[#182238] hover:bg-[#2A3250] text-white transition-all text-xs shadow-[0_2px_0_#000] active:scale-95 touch-manipulation"
                title={nextLesson.title}
              >
                <span className="hidden sm:inline">Bài {nextLesson.lesson_number}</span>
                <span className="sm:hidden">Sau</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </Link>
            ) : (
              <span className="px-3 py-1.5 text-muted/40 text-xs select-none">
                Bài cuối
              </span>
            )}
          </div>
        </div>

        {/* Title & Level Badge */}
        <div className="space-y-2">
          <div className="flex items-center gap-2 flex-wrap">
            <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-sans font-bold bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30">
              {lesson.hsk_level} • Bài {lesson.lesson_number || '01'}
            </span>
            {(() => {
              const lvl = lesson.hsk_level || ''
              if (/HSK\s*[1-3]/i.test(lvl)) {
                return (
                  <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-sans font-medium bg-emerald-50 dark:bg-emerald-950/40 text-emerald-800 dark:text-emerald-300 border border-emerald-500/30">
                    HSK 3.0 • Sơ cấp (初等)
                  </span>
                )
              }
              if (/HSK\s*[4-6]/i.test(lvl)) {
                return (
                  <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-sans font-medium bg-amber-50 dark:bg-amber-950/40 text-amber-800 dark:text-amber-300 border border-amber-500/30">
                    HSK 3.0 • Trung cấp (中等)
                  </span>
                )
              }
              if (/HSK\s*(7|8|9|7-9)/i.test(lvl)) {
                return (
                  <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-sans font-medium bg-indigo-50 dark:bg-indigo-950/40 text-indigo-800 dark:text-indigo-300 border border-indigo-500/30">
                    HSK 3.0 • Cao cấp (高等)
                  </span>
                )
              }
              return null
            })()}
            {isAllCompleted && (
              <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-sans font-bold bg-emerald-100 dark:bg-emerald-900/40 text-emerald-800 dark:text-emerald-300 border border-emerald-500/40">
                <Check className="w-3.5 h-3.5 text-emerald-600" />
                <span>Đã thuộc hết {totalVocabs} từ</span>
              </span>
            )}
          </div>

          <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-[#182238] dark:text-white tracking-tight">
            {lesson.title}
          </h1>

          {lesson.subtitle && (
            <p className="text-xs sm:text-sm md:text-base text-muted font-sans leading-relaxed max-w-3xl">
              {lesson.subtitle}
            </p>
          )}
        </div>

        {/* Dual Progress Matrix & CTA */}
        <div className="pt-4 border-t border-border/60 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="space-y-1.5 flex-1 max-w-md w-full">
            <div className="flex justify-between items-baseline text-xs">
              <span className="font-bold text-muted uppercase tracking-wider text-[11px] font-sans">
                Tiến độ bài học
              </span>
              <span className="font-bold text-[#182238] dark:text-white">
                {learnedCount} / {totalVocabs} từ{' '}
                <span className="text-emerald-600 font-sans font-bold">({progressPercent}%)</span>
              </span>
            </div>
            {/* Visual Progress Bar */}
            <div className="w-full bg-[#E5DFD5] dark:bg-slate-700 rounded-full h-3 overflow-hidden">
              <div
                className="bg-gradient-to-r from-[#B8322D] to-[#10B981] h-full transition-all duration-500 rounded-full"
                style={{ width: `${progressPercent}%` }}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 sm:flex sm:items-center gap-2.5 w-full sm:w-auto">
            <Link
              href={`/typing?mode=hsk&hskLevel=${lesson.hsk_level ? lesson.hsk_level.replace('HSK', '').trim() : 1}&lessonId=${lesson.id}`}
              className="w-full sm:w-auto"
            >
              <Button
                variant="outline"
                className="w-full sm:w-auto font-serif border border-[#182238]/20 hover:border-[#B8322D] hover:bg-[#FFF9F3] text-[#182238] dark:text-white min-h-[44px] px-5 text-xs sm:text-sm gap-2 shadow-xs cursor-pointer active:translate-y-0.5 touch-manipulation"
                title="Luyện đánh máy các câu ví dụ của bài học này"
              >
                <Keyboard className="w-4 h-4 text-[#B8322D]" />
                <span>Luyện gõ bàn phím IME</span>
              </Button>
            </Link>

            <Button
              onClick={() => {
                setLearningIndex(0)
                setShowAnswer(false)
                setUnlearnedInSession([])
                setIsLearning(true)
              }}
              className="w-full sm:w-auto font-serif bg-[#B8322D] hover:bg-[#9E2A25] text-white min-h-[44px] px-6 text-xs sm:text-sm gap-2 border border-[#9E2A25] shadow-xs cursor-pointer active:translate-y-0.5 touch-manipulation font-bold"
            >
              <PlayCircle className="w-4 h-4" />
              <span>Học Flashcard bài này</span>
            </Button>
          </div>
        </div>
      </div>

      {/* 2. Main 2-Column Grid (Desktop lg:grid-cols-12) */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 lg:gap-8 items-start">
        
        {/* ==================================================== */}
        {/* CỘT CHÍNH (8-9 CỘT TRÊN DESKTOP): DANH SÁCH TỪ VỰNG  */}
        {/* ==================================================== */}
        <div className="lg:col-span-8 xl:col-span-9 space-y-4">
          
          {/* Toolbar tìm kiếm & bộ lọc */}
          <div className="bg-white dark:bg-[#182238] border-2 border-[#182238]/20 dark:border-[#384869] rounded-2xl p-3 sm:p-4 shadow-xs flex flex-col sm:flex-row sm:items-center justify-between gap-3">
            <div className="flex items-center gap-2">
              <h2 className="text-base sm:text-lg font-bold text-[#182238] dark:text-white">
                Danh sách từ vựng ({filteredVocabularies.length})
              </h2>
            </div>

            {/* Search & Filter & Speed */}
            <div className="flex items-center gap-2 flex-wrap">
              <div className="relative">
                <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted" />
                <input
                  type="text"
                  placeholder="Tìm từ vựng, pinyin..."
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  className="pl-8 pr-3 py-1.5 text-xs bg-[#FAF7F2] dark:bg-[#141A23] border border-[#182238]/20 rounded-xl outline-none focus:border-[#B8322D] w-36 sm:w-48 font-sans"
                />
              </div>

              <div className="flex bg-[#FAF7F2] dark:bg-[#141A23] border border-[#182238]/20 rounded-xl p-0.5 text-xs">
                <button
                  type="button"
                  onClick={() => setStatusFilter('all')}
                  className={`px-2.5 py-1 rounded-lg transition-all ${
                    statusFilter === 'all'
                      ? 'bg-white dark:bg-[#182238] text-[#182238] dark:text-white font-bold shadow-2xs border border-[#182238]/10'
                      : 'text-muted hover:text-title'
                  }`}
                >
                  Tất cả
                </button>
                <button
                  type="button"
                  onClick={() => setStatusFilter('unlearned')}
                  className={`px-2.5 py-1 rounded-lg transition-all ${
                    statusFilter === 'unlearned'
                      ? 'bg-white dark:bg-[#182238] text-[#B8322D] font-bold shadow-2xs border border-[#182238]/10'
                      : 'text-muted hover:text-title'
                  }`}
                >
                  Chưa thuộc
                </button>
                <button
                  type="button"
                  onClick={() => setStatusFilter('learned')}
                  className={`px-2.5 py-1 rounded-lg transition-all ${
                    statusFilter === 'learned'
                      ? 'bg-white dark:bg-[#182238] text-emerald-600 font-bold shadow-2xs border border-[#182238]/10'
                      : 'text-muted hover:text-title'
                  }`}
                >
                  Đã thuộc
                </button>
              </div>

              <AudioSpeedSelector variant="dropdown" size="xs" />
            </div>
          </div>

          {/* Danh sách thẻ từ vựng mở rộng (Horizontal Card trên Desktop) */}
          <div className="space-y-3.5">
            {filteredVocabularies.length === 0 ? (
              <div className="bg-white dark:bg-[#182238] border-2 border-dashed border-[#182238]/20 rounded-3xl p-10 text-center text-muted space-y-3">
                <HelpCircle className="w-10 h-10 mx-auto opacity-30 text-[#182238]" />
                <p className="text-sm font-medium">Không tìm thấy từ vựng phù hợp với bộ lọc hiện tại.</p>
                <button
                  type="button"
                  onClick={() => {
                    setSearchQuery('')
                    setStatusFilter('all')
                  }}
                  className="text-xs text-[#B8322D] font-bold hover:underline"
                >
                  Xóa bộ lọc tìm kiếm
                </button>
              </div>
            ) : (
              filteredVocabularies.map((vocab, index) => {
                const isLearned = localUserVocabs.includes(vocab.id)
                const isPendingToggle = updatingVocabId === vocab.id

                return (
                  <div
                    key={vocab.id}
                    className={`bg-white dark:bg-[#182238] border-2 rounded-2xl p-4 sm:p-5 transition-all duration-150 group ${
                      isLearned
                        ? 'border-emerald-600 dark:border-emerald-500 shadow-[0_4px_0_#059669]'
                        : 'border-[#182238] dark:border-[#384869] shadow-[0_4px_0_#182238] dark:shadow-[0_4px_0_#0D1322] hover:-translate-y-0.5 hover:shadow-[0_6px_0_#182238]'
                    }`}
                  >
                    {/* Bố cục ngang rộng trên Desktop (Horizontal Grid) */}
                    <div className="flex flex-col md:flex-row md:items-start justify-between gap-4">
                      
                      {/* Khu vực 1: Số thứ tự + Chữ Hán + Pinyin + Nút phát âm */}
                      <div className="flex items-start gap-3.5 shrink-0 min-w-[200px] xl:min-w-[240px]">
                        <span className="w-8 h-8 rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] text-muted text-xs font-mono font-bold flex items-center justify-center shrink-0 mt-1 border border-[#182238]/15">
                          {String(index + 1).padStart(2, '0')}
                        </span>

                        <div className="space-y-1">
                          <div className="flex items-center gap-2.5">
                            <span className="text-3xl sm:text-4xl font-hanzi font-bold text-[#182238] dark:text-white group-hover:text-[#B8322D] transition-colors leading-tight">
                              {vocab.hanzi}
                            </span>
                            <AudioButton
                              text={vocab.hanzi}
                              id={vocab.id}
                              size="sm"
                              variant="subtle"
                              tooltip="Nghe phát âm từ này"
                            />
                          </div>
                          <p className="text-base sm:text-lg font-sans text-[#B8322D] font-bold tracking-wide">
                            {vocab.pinyin}
                          </p>
                        </div>
                      </div>

                      {/* Khu vực 2: Nghĩa tiếng Việt + Câu ví dụ thực tế */}
                      <div className="flex-1 min-w-0 space-y-2">
                        <div className="inline-block bg-[#FAF7F2] dark:bg-[#141A23] border border-[#182238]/15 px-3 py-1 rounded-xl">
                          <span className="text-base sm:text-lg font-serif text-[#182238] dark:text-white font-bold">
                            {vocab.meaning_vi}
                          </span>
                        </div>

                        {/* Khối ví dụ thực tế */}
                        {vocab.example_hanzi && (
                          <div className="bg-[#FFFDF9] dark:bg-[#141A23] border border-[#182238]/15 rounded-xl p-3 sm:p-3.5 space-y-1 text-sm">
                            <p className="text-xs sm:text-sm font-sans text-[#B8322D] font-medium tracking-wide">
                              {vocab.example_pinyin}
                            </p>
                            <div className="text-sm sm:text-base font-hanzi text-[#182238] dark:text-white flex items-center justify-between gap-2">
                              <span>{vocab.example_hanzi}</span>
                              <AudioButton
                                text={vocab.example_hanzi}
                                id={`ex-${vocab.id}`}
                                size="xs"
                                variant="ghost"
                                tooltip="Nghe câu ví dụ"
                              />
                            </div>
                            <p className="text-xs sm:text-sm text-body font-sans leading-relaxed">
                              {vocab.example_vi}
                            </p>
                          </div>
                        )}
                      </div>

                      {/* Khu vực 3: Nút bấm Đã thuộc / Chưa thuộc (Full width trên Mobile, cố định bên phải trên Desktop) */}
                      <div className="flex items-center shrink-0 pt-1 justify-end w-full md:w-auto">
                        <button
                          type="button"
                          onClick={() => handleToggleLearned(vocab.id)}
                          disabled={isPendingToggle}
                          className={`w-full md:w-auto inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl text-xs sm:text-sm font-serif font-bold transition-all cursor-pointer select-none min-h-[44px] active:translate-y-0.5 touch-manipulation border-2 ${
                            isLearned
                              ? 'bg-[#ECFDF5] text-[#065F46] border-[#10B981] shadow-[0_3px_0_#059669] hover:bg-[#D1FAE5]'
                              : 'bg-white dark:bg-[#1E293B] text-muted border-[#182238]/20 hover:border-[#182238] hover:text-[#182238] hover:bg-[#FFF9F3] shadow-[0_2px_0_#182238]/10'
                          }`}
                          title={isLearned ? 'Nhấn để chuyển sang Chưa thuộc' : 'Nhấn để đánh dấu Đã thuộc'}
                        >
                          {isPendingToggle ? (
                            <>
                              <Loader2 className="w-4 h-4 animate-spin text-[#B8322D]" />
                              <span>Đang lưu...</span>
                            </>
                          ) : isLearned ? (
                            <>
                              <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0 stroke-[2.5]" />
                              <span>Đã thuộc</span>
                            </>
                          ) : (
                            <>
                              <span className="w-3 h-3 rounded-full border-2 border-muted shrink-0" />
                              <span>Chưa thuộc</span>
                            </>
                          )}
                        </button>
                      </div>

                    </div>
                  </div>
                )
              })
            )}
          </div>

          {/* Banner chúc mừng khi hoàn thành bài học */}
          {isAllCompleted && (
            <div className="p-5 sm:p-6 rounded-3xl bg-[#ECFDF5] dark:bg-emerald-950/40 border-2 border-emerald-600 text-center space-y-3 shadow-[0_4px_0_#059669]">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-emerald-600 text-white text-xs font-bold font-sans">
                <CheckCircle2 className="w-4 h-4" />
                <span>Chúc mừng! Bạn đã thuộc toàn bộ từ vựng bài học này</span>
              </div>
              <h3 className="text-lg sm:text-xl font-bold font-serif text-[#182238] dark:text-white">
                Tiếp tục hành trình học tập
              </h3>
              <div className="flex flex-col sm:flex-row items-center justify-center gap-3 pt-1">
                <Link href={`/typing?hskLevel=${encodeURIComponent(lesson.hsk_level)}&practice=hsk&lessonId=${lesson.id}`} className="w-full sm:w-auto">
                  <Button className="w-full sm:w-auto px-5 min-h-[46px] text-xs sm:text-sm gap-2 font-serif bg-[#182238] hover:bg-[#2A3250] text-white border-2 border-[#182238] shadow-[0_3px_0_#000]">
                    <Keyboard className="w-4 h-4 text-amber-400" />
                    <span>Luyện gõ từ vựng bài này</span>
                  </Button>
                </Link>
                {nextLesson && (
                  <Link href={`/lessons/${nextLesson.id}`} className="w-full sm:w-auto">
                    <Button variant="outline" className="w-full sm:w-auto px-5 min-h-[46px] text-xs sm:text-sm gap-2 font-serif border-2 border-[#182238] bg-white text-[#182238] shadow-[0_3px_0_#182238]">
                      <span>Học tiếp: Bài {nextLesson.lesson_number}</span>
                      <ArrowRight className="w-4 h-4 text-[#B8322D]" />
                    </Button>
                  </Link>
                )}
              </div>
            </div>
          )}

          {/* Bottom Switcher */}
          <div className="pt-6 border-t-2 border-[#182238]/10 flex items-center justify-between text-xs">
            {prevLesson ? (
              <Link
                href={`/lessons/${prevLesson.id}`}
                className="flex items-center gap-2 text-body hover:text-[#B8322D] transition-colors"
              >
                <ArrowLeft className="w-4 h-4" />
                <div className="text-left">
                  <p className="text-[10px] text-muted uppercase font-sans">Bài trước</p>
                  <p className="font-bold text-title">{prevLesson.title}</p>
                </div>
              </Link>
            ) : (
              <div />
            )}

            {nextLesson && (
              <Link
                href={`/lessons/${nextLesson.id}`}
                className="flex items-center gap-2 text-body hover:text-[#B8322D] transition-colors text-right"
              >
                <div className="text-right">
                  <p className="text-[10px] text-muted uppercase font-sans">Bài tiếp theo</p>
                  <p className="font-bold text-title">{nextLesson.title}</p>
                </div>
                <ArrowRight className="w-4 h-4" />
              </Link>
            )}
          </div>

        </div>

        {/* ==================================================== */}
        {/* CỘT PHỤ SIDEBAR (3-4 CỘT TRÊN DESKTOP: 280-320PX)    */}
        {/* ==================================================== */}
        <aside className="lg:col-span-4 xl:col-span-3 space-y-5 sticky top-24">
          
          {/* Card 1: Panda Learning Companion (Tiểu Bút 🐼) */}
          <div className="bg-white dark:bg-[#182238] border-2 border-[#182238] dark:border-[#384869] rounded-3xl p-5 shadow-[0_6px_0_#182238] dark:shadow-[0_4px_0_#0D1322] space-y-4">
            
            {/* Header Mascot */}
            <div className="flex items-center justify-between pb-3 border-b-2 border-[#182238]/10">
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

            {/* Mascot 3D Image & Speech Bubble */}
            <div className="flex flex-col items-center space-y-3 pt-1">
              <div className="relative w-28 h-28 rounded-2xl overflow-hidden border-2 border-[#182238] shadow-[0_4px_0_#182238] bg-[#FFF9F3] dark:bg-[#202B45] mascot-animated">
                <Image
                  src={isAllCompleted ? '/images/panda/panda-celebration.webp' : '/images/panda/panda-studying.webp'}
                  alt="Tiểu Bút đồng hành bài học"
                  fill
                  sizes="112px"
                  className="object-cover"
                  priority
                />
              </div>

              {/* Bong bóng hội thoại có đuôi */}
              <div className="relative w-full bg-[#FAF7F2] dark:bg-[#202B45] border-2 border-[#182238] dark:border-[#384869] rounded-2xl p-3.5 shadow-[0_3px_0_#182238]">
                <div className="absolute -top-2 left-1/2 -translate-x-1/2 w-3 h-3 bg-[#FAF7F2] dark:bg-[#202B45] border-t-2 border-l-2 border-[#182238] dark:border-[#384869] rotate-45" />
                <p className="text-xs font-serif text-[#182238] dark:text-white leading-relaxed text-center">
                  &ldquo;{companionMessage}&rdquo;
                </p>
              </div>
            </div>

            {/* Thống kê bài học */}
            <div className="pt-2 space-y-2 border-t-2 border-[#182238]/10">
              <div className="flex items-center justify-between text-xs font-serif text-muted">
                <span>Tiến độ bài học:</span>
                <strong className="text-[#182238] dark:text-white font-sans">{progressPercent}%</strong>
              </div>

              <div className="grid grid-cols-2 gap-2 text-center font-serif text-xs">
                <div className="bg-[#FAF7F2] dark:bg-[#141A23] p-2.5 rounded-xl border border-[#182238]/10">
                  <p className="text-[10px] text-emerald-600 font-sans font-bold">ĐÃ THUỘC</p>
                  <p className="text-lg font-bold text-emerald-600 mt-0.5">{learnedCount}</p>
                </div>
                <div className="bg-[#FAF7F2] dark:bg-[#141A23] p-2.5 rounded-xl border border-[#182238]/10">
                  <p className="text-[10px] text-[#B8322D] font-sans font-bold">CHƯA THUỘC</p>
                  <p className="text-lg font-bold text-[#B8322D] mt-0.5">{totalVocabs - learnedCount}</p>
                </div>
              </div>
            </div>
          </div>

          {/* Card 2: Lối tắt các chế độ học tập */}
          <div className="bg-white dark:bg-[#182238] border-2 border-[#182238]/20 dark:border-[#384869] rounded-2xl p-4 space-y-2.5 shadow-xs">
            <p className="text-xs font-bold font-sans uppercase text-[#182238] dark:text-white tracking-wide">
              Chế Độ Luyện Tập
            </p>

            <Button
              onClick={() => {
                setLearningIndex(0)
                setShowAnswer(false)
                setUnlearnedInSession([])
                setIsLearning(true)
              }}
              className="w-full h-11 text-xs font-serif font-bold bg-[#B8322D] hover:bg-[#9E2A25] text-white rounded-xl flex items-center justify-center gap-2 border-2 border-[#182238] shadow-[0_3px_0_#182238] cursor-pointer active:translate-y-0.5"
            >
              <PlayCircle className="w-4 h-4" />
              <span>Học Flashcard thông minh</span>
            </Button>

            <Link
              href={`/typing?mode=hsk&hskLevel=${lesson.hsk_level ? lesson.hsk_level.replace('HSK', '').trim() : 1}&lessonId=${lesson.id}`}
              className="block"
            >
              <Button
                variant="outline"
                className="w-full h-11 text-xs font-serif font-bold border-2 border-[#182238] bg-[#FAF7F2] hover:bg-white text-[#182238] dark:text-white rounded-xl flex items-center justify-center gap-2 shadow-[0_3px_0_#182238] cursor-pointer active:translate-y-0.5"
              >
                <Keyboard className="w-4 h-4 text-[#B8322D]" />
                <span>Luyện gõ bàn phím IME</span>
              </Button>
            </Link>

            <Link href="/review" className="block">
              <Button
                variant="outline"
                className="w-full h-11 text-xs font-serif font-bold border-2 border-[#182238]/30 bg-white hover:bg-[#FAF7F2] text-[#182238] dark:text-white rounded-xl flex items-center justify-center gap-2 shadow-xs cursor-pointer active:translate-y-0.5"
              >
                <Layers className="w-4 h-4 text-amber-500" />
                <span>Phòng Ôn tập SM-2</span>
              </Button>
            </Link>
          </div>

          {/* Card 3: Gợi ý bài học tiếp theo */}
          {nextLesson && (
            <div className="bg-[#FAF7F2] dark:bg-[#141A23] border-2 border-[#182238]/20 rounded-2xl p-4 space-y-2 shadow-xs">
              <span className="text-[10px] font-sans font-bold uppercase text-[#B8322D] tracking-wider">
                Gợi ý bài tiếp theo
              </span>
              <h4 className="text-sm font-bold font-serif text-[#182238] dark:text-white">
                Bài {nextLesson.lesson_number}: {nextLesson.title}
              </h4>
              <Link href={`/lessons/${nextLesson.id}`} className="block pt-1">
                <Button className="w-full h-9 text-xs font-serif bg-[#182238] hover:bg-[#2A3250] text-white rounded-xl gap-1.5 shadow-[0_2px_0_#000]">
                  <span>Vào học ngay</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </Button>
              </Link>
            </div>
          )}

        </aside>

      </div>
    </div>
  )
}
