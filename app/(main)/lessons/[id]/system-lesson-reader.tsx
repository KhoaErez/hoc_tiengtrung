'use client'

import { useState, useEffect, useCallback, useMemo } from 'react'
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
  Sparkles,
  RotateCcw,
  Check,
  ChevronRight,
  HelpCircle,
  SlidersHorizontal,
  BookmarkCheck,
  Loader2,
  Keyboard
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

  // -------------------------------------------------------------
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
              <Sparkles className="w-3.5 h-3.5" />
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
              className="w-full sm:w-auto font-serif text-xs h-10 px-5 rounded-xl gap-2 border-border hover:bg-black/5 cursor-pointer"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              <span>Học lại bài này</span>
            </Button>

            <Link
              href={`/typing?mode=hsk&hskLevel=${lesson.hsk_level ? lesson.hsk_level.replace('HSK', '').trim() : 1}&lessonId=${lesson.id}`}
              className="w-full sm:w-auto"
            >
              <Button
                variant="outline"
                className="w-full sm:w-auto font-serif text-xs h-10 px-4 rounded-xl gap-2 border-border hover:bg-page cursor-pointer"
              >
                <Keyboard className="w-3.5 h-3.5 text-app-accent" />
                <span>Luyện gõ câu ví dụ vừa học</span>
              </Button>
            </Link>

            {nextLesson ? (
              <Link href={`/lessons/${nextLesson.id}`} className="w-full sm:w-auto">
                <Button className="w-full font-serif bg-title hover:bg-[#2A3250] text-white text-xs h-10 px-5 rounded-xl gap-2 shadow-2xs cursor-pointer">
                  <span>Sang {nextLesson.title}</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </Button>
              </Link>
            ) : (
              <Button
                onClick={() => setIsLearning(false)}
                className="w-full sm:w-auto font-serif bg-app-accent hover:bg-accent-hover text-white text-xs h-10 px-5 rounded-xl gap-2 shadow-2xs cursor-pointer"
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
      <div className="max-w-xl mx-auto py-6 font-serif px-4 space-y-5 select-none">
        
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
            className={`transform-style-3d transition-transform duration-300 ease-out relative w-full min-h-[380px] sm:min-h-[420px] cursor-pointer ${
              showAnswer ? 'rotate-y-180' : ''
            }`}
            role="button"
            tabIndex={0}
            aria-label={showAnswer ? 'Mặt sau thẻ từ vựng' : 'Mặt trước thẻ từ vựng, chạm để lật thẻ'}
          >
            {/* MẶT TRƯỚC FLASHCARD */}
            <div className="backface-hidden absolute inset-0 w-full h-full rounded-3xl bg-card border border-border/80 p-6 sm:p-8 flex flex-col justify-between items-center shadow-xs hover:border-app-accent/40 transition-colors overflow-hidden">
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
                  <kbd className="px-1.5 py-0.5 bg-page border border-border rounded text-[10px] font-mono shadow-2xs">
                    Space
                  </kbd>
                  <span>để lật thẻ</span>
                </p>
              </div>
            </div>

            {/* MẶT SAU FLASHCARD */}
            <div className="backface-hidden rotate-y-180 absolute inset-0 w-full h-full rounded-3xl bg-card border border-border/80 p-6 sm:p-8 flex flex-col justify-between items-center shadow-xs overflow-y-auto no-scrollbar">
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
              className="w-full h-12 sm:h-13 text-sm sm:text-base font-serif bg-app-accent hover:bg-accent-hover text-white rounded-2xl shadow-xs flex items-center justify-center gap-2 cursor-pointer transition-all active:scale-[0.99]"
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
                className="flex-1 h-12 sm:h-13 text-xs sm:text-sm font-serif border-red-200 bg-red-50/70 hover:bg-red-100/80 text-red-700 rounded-2xl flex items-center justify-center gap-2 shadow-2xs cursor-pointer transition-all active:scale-[0.99] disabled:opacity-60"
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
                disabled={isLearnPending}
                className="flex-1 h-12 sm:h-13 text-xs sm:text-sm font-serif bg-jade hover:bg-jade/90 text-white rounded-2xl flex items-center justify-center gap-2 shadow-xs cursor-pointer transition-all active:scale-[0.99] disabled:opacity-60"
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
  // LESSON OVERVIEW & VOCABULARY LIST VIEW
  // -------------------------------------------------------------
  return (
    <div className="max-w-4xl mx-auto space-y-6 font-serif px-4 pb-20">
      {/* 1. Header Card */}
      <div className="bg-card border border-border/80 rounded-2xl p-6 md:p-8 shadow-2xs space-y-6">
        {/* Top Breadcrumb & Next/Prev Switcher */}
        <div className="flex items-center justify-between pb-4 border-b border-border/60 text-xs">
          <Link
            href={`/topics?q=${encodeURIComponent(lesson.hsk_level)}`}
            className="inline-flex items-center gap-1.5 text-muted hover:text-app-accent transition-colors font-medium"
          >
            <ArrowLeft className="w-3.5 h-3.5" />
            <span>Danh sách {lesson.hsk_level}</span>
          </Link>

          {/* Adjacent Lessons Navigation */}
          <div className="flex items-center gap-1.5">
            {prevLesson ? (
              <Link
                href={`/lessons/${prevLesson.id}`}
                className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg border border-border hover:border-app-accent/40 text-body hover:text-app-accent transition-all text-xs"
                title={prevLesson.title}
              >
                <ArrowLeft className="w-3 h-3" />
                <span className="hidden sm:inline">Bài {prevLesson.lesson_number}</span>
                <span className="sm:hidden">Trước</span>
              </Link>
            ) : (
              <span className="px-2.5 py-1 text-muted/40 text-xs select-none">
                Bài đầu tiên
              </span>
            )}

            {nextLesson ? (
              <Link
                href={`/lessons/${nextLesson.id}`}
                className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-title hover:bg-[#2A3250] text-white transition-all text-xs shadow-2xs"
                title={nextLesson.title}
              >
                <span className="hidden sm:inline">Bài {nextLesson.lesson_number}</span>
                <span className="sm:hidden">Sau</span>
                <ArrowRight className="w-3 h-3" />
              </Link>
            ) : (
              <span className="px-2.5 py-1 text-muted/40 text-xs select-none">
                Bài cuối cùng
              </span>
            )}
          </div>
        </div>

        {/* Title & Level Badge */}
        <div className="space-y-2">
          <div className="flex items-center gap-2 flex-wrap">
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-app-accent-soft text-app-accent border border-app-accent/20">
              {lesson.hsk_level} • Bài {lesson.lesson_number || '01'}
            </span>
            {(() => {
              const lvl = lesson.hsk_level || ''
              if (/HSK\s*[1-3]/i.test(lvl)) {
                return (
                  <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-sans font-medium bg-emerald-50 text-jade border border-jade/30">
                    HSK 3.0 • Sơ cấp (初等)
                  </span>
                )
              }
              if (/HSK\s*[4-6]/i.test(lvl)) {
                return (
                  <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-sans font-medium bg-amber-50 text-gold border border-gold/30">
                    HSK 3.0 • Trung cấp (中等)
                  </span>
                )
              }
              if (/HSK\s*(7|8|9|7-9)/i.test(lvl)) {
                return (
                  <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-sans font-medium bg-indigo-50 text-indigo-700 border-indigo-200">
                    HSK 3.0 • Cao cấp (高等)
                  </span>
                )
              }
              return null
            })()}
            {isAllCompleted && (
              <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-emerald-50 text-jade border border-jade/30">
                <Check className="w-3 h-3" />
                Đã thuộc hết từ
              </span>
            )}
          </div>

          <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-title tracking-tight">
            {lesson.title}
          </h1>

          {lesson.subtitle && (
            <p className="text-sm md:text-base text-muted font-sans leading-relaxed">
              {lesson.subtitle}
            </p>
          )}
        </div>

        {/* Dual Progress Matrix & CTA */}
        <div className="pt-4 border-t border-border/60 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="space-y-1.5 flex-1 max-w-sm">
            <div className="flex justify-between items-baseline text-xs">
              <span className="font-semibold text-muted uppercase tracking-wider text-[11px]">
                Tiến độ bài học
              </span>
              <span className="font-bold text-title">
                {learnedCount} / {totalVocabs} từ{' '}
                <span className="text-jade font-sans">({progressPercent}%)</span>
              </span>
            </div>
            {/* Visual Progress Bar */}
            <div className="w-full bg-black/5 rounded-full h-2.5 overflow-hidden">
              <div
                className="bg-jade h-full transition-all duration-500 rounded-full"
                style={{ width: `${progressPercent}%` }}
              />
            </div>
          </div>

          <div className="flex items-center gap-2.5 flex-wrap self-start sm:self-auto">
            <Link
              href={`/typing?mode=hsk&hskLevel=${lesson.hsk_level ? lesson.hsk_level.replace('HSK', '').trim() : 1}&lessonId=${lesson.id}`}
            >
              <Button
                variant="outline"
                className="font-serif border-border hover:bg-page text-title rounded-xl px-4 h-10 text-xs sm:text-sm gap-2 shadow-2xs cursor-pointer"
                title="Luyện đánh máy IME các câu ví dụ của bài học này"
              >
                <Keyboard className="w-4 h-4 text-app-accent" />
                <span>Luyện đánh máy</span>
              </Button>
            </Link>

            <Button
              onClick={() => {
                setLearningIndex(0)
                setShowAnswer(false)
                setUnlearnedInSession([])
                setIsLearning(true)
              }}
              className="font-serif bg-app-accent hover:bg-app-accent/90 text-white rounded-xl px-5 h-10 text-xs sm:text-sm gap-2 shadow-2xs cursor-pointer"
            >
              <PlayCircle className="w-4 h-4" />
              <span>Học bài này (Flashcard)</span>
            </Button>
          </div>
        </div>
      </div>

      {/* 2. Vocabulary List Toolbar */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-2">
        <div className="flex items-center gap-2">
          <h2 className="text-lg md:text-xl font-bold text-title">
            Danh sách từ vựng ({filteredVocabularies.length})
          </h2>
          <span className="text-xs text-muted font-sans">
            (Bấm vào nút trạng thái để đánh dấu đã thuộc)
          </span>
        </div>

        {/* Search & Filter */}
        <div className="flex items-center gap-2">
          <div className="relative">
            <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted" />
            <input
              type="text"
              placeholder="Tìm từ vựng..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-8 pr-3 py-1.5 text-xs bg-card border border-border rounded-lg outline-none focus:border-app-accent w-40 sm:w-48 font-sans"
            />
          </div>

          <div className="flex bg-page border border-border rounded-lg p-0.5 text-xs">
            <button
              onClick={() => setStatusFilter('all')}
              className={`px-2 py-1 rounded-md transition-all ${
                statusFilter === 'all'
                  ? 'bg-card text-title font-bold shadow-2xs'
                  : 'text-muted hover:text-title'
              }`}
            >
              Tất cả
            </button>
            <button
              onClick={() => setStatusFilter('unlearned')}
              className={`px-2 py-1 rounded-md transition-all ${
                statusFilter === 'unlearned'
                  ? 'bg-card text-title font-bold shadow-2xs'
                  : 'text-muted hover:text-title'
              }`}
            >
              Chưa thuộc
            </button>
            <button
              onClick={() => setStatusFilter('learned')}
              className={`px-2 py-1 rounded-md transition-all ${
                statusFilter === 'learned'
                  ? 'bg-card text-title font-bold shadow-2xs'
                  : 'text-muted hover:text-title'
              }`}
            >
              Đã thuộc
            </button>
          </div>

          <AudioSpeedSelector variant="dropdown" size="xs" />
        </div>
      </div>

      {/* 3. Redesigned Vocabulary Cards List */}
      <div className="space-y-3">
        {filteredVocabularies.length === 0 ? (
          <div className="bg-card border border-border/80 rounded-2xl p-10 text-center text-muted space-y-2">
            <HelpCircle className="w-8 h-8 mx-auto opacity-30 text-title" />
            <p className="text-sm font-medium">Không tìm thấy từ vựng phù hợp với bộ lọc.</p>
            <button
              onClick={() => {
                setSearchQuery('')
                setStatusFilter('all')
              }}
              className="text-xs text-app-accent hover:underline"
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
                className={`bg-card border rounded-2xl p-4 sm:p-5 shadow-2xs transition-all duration-150 hover:shadow-xs group ${
                  isLearned
                    ? 'border-jade/30 bg-card'
                    : 'border-border/80 hover:border-app-accent/30'
                }`}
              >
                <div className="flex flex-col md:flex-row md:items-start justify-between gap-4">
                  {/* Left Column: Index, Hanzi, Pinyin, Meaning */}
                  <div className="flex items-start gap-3.5 flex-1 min-w-0">
                    <span className="w-6 h-6 rounded-md bg-page text-muted text-[11px] font-mono flex items-center justify-center flex-shrink-0 mt-1 border border-border/60">
                      {String(index + 1).padStart(2, '0')}
                    </span>

                    <div className="space-y-2 flex-1 min-w-0">
                      {/* Character + Pinyin + Audio */}
                      <div className="flex flex-wrap items-baseline gap-2.5">
                        <span className="text-3xl sm:text-4xl font-serif font-bold text-title group-hover:text-app-accent transition-colors">
                          {vocab.hanzi}
                        </span>
                        <span className="text-sm font-sans text-app-accent font-semibold tracking-wider">
                          {vocab.pinyin}
                        </span>
                        <AudioButton
                          text={vocab.hanzi}
                          id={vocab.id}
                          size="xs"
                          variant="ghost"
                          tooltip="Nghe phát âm từ này"
                        />
                      </div>

                      {/* Meaning */}
                      <p className="text-sm md:text-base font-serif text-title font-semibold">
                        {vocab.meaning_vi}
                      </p>

                      {/* Example sentence block */}
                      {vocab.example_hanzi && (
                        <div className="bg-page/70 border border-border/70 rounded-xl p-3 space-y-1 text-xs">
                          <p className="text-[11px] font-sans text-muted">
                            {vocab.example_pinyin}
                          </p>
                          <div className="text-sm font-serif text-title flex items-center justify-between gap-2">
                            <span>{vocab.example_hanzi}</span>
                            <AudioButton
                              text={vocab.example_hanzi}
                              id={`ex-${vocab.id}`}
                              size="xs"
                              variant="subtle"
                              tooltip="Nghe câu ví dụ"
                            />
                          </div>
                          <p className="text-xs text-body font-serif italic">
                            {vocab.example_vi}
                          </p>
                        </div>
                      )}
                    </div>
                  </div>

                  {/* Right Column: Interactive Learned Status Toggle */}
                  <div className="flex items-center gap-2 self-end md:self-start flex-shrink-0 pt-1">
                    <button
                      type="button"
                      onClick={() => handleToggleLearned(vocab.id)}
                      disabled={isPendingToggle}
                      className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-sans font-medium transition-all cursor-pointer select-none active:scale-95 ${
                        isLearned
                          ? 'bg-emerald-50 text-jade border border-jade/40 hover:bg-emerald-100/60 shadow-2xs'
                          : 'bg-page text-muted border border-border hover:border-app-accent/40 hover:text-title'
                      }`}
                      title={isLearned ? 'Nhấn để chuyển sang Chưa thuộc' : 'Nhấn để đánh dấu Đã thuộc'}
                    >
                      {isLearned ? (
                        <>
                          <CheckCircle2 className="w-3.5 h-3.5 text-jade" />
                          <span>Đã thuộc</span>
                        </>
                      ) : (
                        <>
                          <span className="w-2 h-2 rounded-full border border-muted" />
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

      {/* Bottom Navigation Switcher */}
      <div className="pt-6 border-t border-border flex items-center justify-between text-xs">
        {prevLesson ? (
          <Link
            href={`/lessons/${prevLesson.id}`}
            className="flex items-center gap-2 text-body hover:text-app-accent transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
            <div className="text-left">
              <p className="text-[10px] text-muted uppercase">Bài trước</p>
              <p className="font-bold text-title">{prevLesson.title}</p>
            </div>
          </Link>
        ) : (
          <div />
        )}

        {nextLesson && (
          <Link
            href={`/lessons/${nextLesson.id}`}
            className="flex items-center gap-2 text-body hover:text-app-accent transition-colors text-right"
          >
            <div className="text-right">
              <p className="text-[10px] text-muted uppercase">Bài tiếp theo</p>
              <p className="font-bold text-title">{nextLesson.title}</p>
            </div>
            <ArrowRight className="w-4 h-4" />
          </Link>
        )}
      </div>
    </div>
  )
}
