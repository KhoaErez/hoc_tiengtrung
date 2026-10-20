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
  BookmarkCheck
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { AudioButton } from '@/components/ui/audio-button'
import { useChineseTTS } from '@/hooks/use-chinese-tts'
import { markVocabLearnedAction } from '../../review/actions'
import { ttsEngine } from '@/lib/tts/tts-engine'
import { toast } from 'sonner'

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

  // State management
  const [localUserVocabs, setLocalUserVocabs] = useState<string[]>(userVocabs)
  const [isLearning, setIsLearning] = useState(false)
  const [learningIndex, setLearningIndex] = useState(0)
  const [showAnswer, setShowAnswer] = useState(false)
  const [isUpdating, setIsUpdating] = useState(false)
  const [searchQuery, setSearchQuery] = useState('')
  const [statusFilter, setStatusFilter] = useState<'all' | 'unlearned' | 'learned'>('all')
  const [speechRate, setSpeechRate] = useState<number>(1.0)
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
    } catch {
      // Rollback on failure
      setLocalUserVocabs((prev) =>
        isCurrentlyLearned ? [...prev, vocabId] : prev.filter((id) => id !== vocabId)
      )
      toast.error('Không thể lưu trạng thái. Vui lòng thử lại sau.')
    } finally {
      setUpdatingVocabId(null)
    }
  }

  // Answer handler in Flashcard Learning Mode
  const handleLearnAnswer = async (isRemembered: boolean) => {
    if (isUpdating) return
    setIsUpdating(true)
    const currentVocab = vocabularies[learningIndex]

    // Optimistically update
    if (isRemembered) {
      if (!localUserVocabs.includes(currentVocab.id)) {
        setLocalUserVocabs((prev) => [...prev, currentVocab.id])
      }
    } else {
      setUnlearnedInSession((prev) => Array.from(new Set([...prev, currentVocab.id])))
    }

    try {
      await markVocabLearnedAction(currentVocab.id, isRemembered)
    } catch {
      // Non-blocking toast for guest or transient error
      if (!isLoggedIn) {
        toast.info('Đăng nhập để lưu tiến độ vĩnh viễn vào tài khoản', { duration: 2500 })
      }
    } finally {
      setIsUpdating(false)
      setShowAnswer(false)
      setLearningIndex((prev) => prev + 1)
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
            speak(currentVocab.hanzi, { id: `fc-${currentVocab.id}`, rate: speechRate })
          }
        }
      } else if (showAnswer) {
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
  }, [isLearning, showAnswer, learningIndex, vocabularies, speechRate, isUpdating])

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
  // FLASHCARD / LEARNING MODE VIEW
  // -------------------------------------------------------------
  if (isLearning) {
    if (learningIndex >= vocabularies.length) {
      const sessionUnlearnedCount = unlearnedInSession.length

      return (
        <div className="max-w-xl mx-auto py-12 px-4 text-center font-serif space-y-6 animate-in fade-in zoom-in-95 duration-200">
          <div className="w-20 h-20 rounded-3xl bg-emerald-50 text-jade mx-auto flex items-center justify-center border border-jade/30 shadow-sm">
            <Sparkles className="w-10 h-10 text-jade" />
          </div>

          <div className="space-y-2">
            <h2 className="text-3xl font-bold text-title">Xuất sắc hoàn thành!</h2>
            <p className="text-sm text-muted">
              Bạn đã ôn tập xong toàn bộ {totalVocabs} từ vựng của{' '}
              <strong className="text-title">{lesson.title}</strong>.
            </p>
          </div>

          {/* Result Card */}
          <div className="bg-card border border-border/80 rounded-2xl p-5 shadow-2xs space-y-3 max-w-sm mx-auto text-left">
            <div className="flex justify-between items-center text-xs">
              <span className="text-muted">Tổng số từ trong bài:</span>
              <span className="font-bold text-title">{totalVocabs} từ</span>
            </div>
            <div className="flex justify-between items-center text-xs">
              <span className="text-muted">Đã thuộc tích lũy:</span>
              <span className="font-bold text-jade">{learnedCount} từ ({progressPercent}%)</span>
            </div>
            {sessionUnlearnedCount > 0 && (
              <div className="flex justify-between items-center text-xs">
                <span className="text-muted">Cần củng cố thêm:</span>
                <span className="font-bold text-amber-600">{sessionUnlearnedCount} từ</span>
              </div>
            )}
            <div className="w-full bg-black/5 rounded-full h-2 overflow-hidden">
              <div
                className="bg-jade h-full transition-all duration-500 rounded-full"
                style={{ width: `${progressPercent}%` }}
              />
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
              className="w-full sm:w-auto font-serif text-xs h-10 rounded-xl gap-2 border-border"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              <span>Học lại bài này</span>
            </Button>

            {nextLesson ? (
              <Link href={`/lessons/${nextLesson.id}`} className="w-full sm:w-auto">
                <Button className="w-full font-serif bg-title hover:bg-[#2A3250] text-white text-xs h-10 rounded-xl gap-2 shadow-2xs">
                  <span>Sang {nextLesson.title}</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </Button>
              </Link>
            ) : (
              <Button
                onClick={() => setIsLearning(false)}
                className="w-full sm:w-auto font-serif bg-app-accent hover:bg-app-accent/90 text-white text-xs h-10 rounded-xl gap-2 shadow-2xs"
              >
                <span>Xem danh sách từ</span>
              </Button>
            )}
          </div>
        </div>
      )
    }

    const currentVocab = vocabularies[learningIndex]

    return (
      <div className="max-w-xl mx-auto py-8 font-serif px-4 space-y-6">
        {/* Top bar controls */}
        <div className="flex justify-between items-center text-xs text-muted border-b border-border/80 pb-3">
          <button
            onClick={() => {
              ttsEngine.stop()
              setIsLearning(false)
            }}
            className="flex items-center gap-1.5 text-body hover:text-app-accent transition-colors font-medium"
          >
            <ArrowLeft className="w-4 h-4" />
            <span>Thoát chế độ học</span>
          </button>

          <div className="flex items-center gap-3">
            {/* Speed toggle */}
            <button
              onClick={() => setSpeechRate((r) => (r === 1.0 ? 0.75 : 1.0))}
              className="px-2 py-0.5 rounded-md border border-border text-[11px] font-mono hover:border-app-accent/40"
              title="Tốc độ phát âm"
            >
              Tốc độ: {speechRate}x
            </button>
            <span className="font-mono bg-page px-2 py-0.5 rounded-md border border-border">
              {learningIndex + 1} / {totalVocabs}
            </span>
          </div>
        </div>

        {/* Flashcard Box */}
        <div
          onClick={() => {
            if (!showAnswer) {
              setShowAnswer(true)
              speak(currentVocab.hanzi, { id: `fc-${currentVocab.id}`, rate: speechRate })
            }
          }}
          className={`w-full min-h-[340px] md:min-h-[380px] rounded-3xl border-2 transition-all duration-200 cursor-pointer p-6 flex flex-col items-center justify-center select-none shadow-sm ${
            showAnswer
              ? 'bg-card border-app-accent/30'
              : 'bg-[#FDFBF7] hover:border-app-accent/40 border-border active:scale-[0.99]'
          }`}
        >
          {!showAnswer ? (
            <div className="text-center space-y-4 py-8">
              <span className="text-6xl md:text-8xl font-serif text-title tracking-wide leading-none block">
                {currentVocab.hanzi}
              </span>
              <p className="text-xs text-muted flex items-center justify-center gap-1">
                <span>Chạm hoặc nhấn</span>
                <kbd className="px-1.5 py-0.5 bg-page border border-border rounded text-[10px] font-mono">
                  Space
                </kbd>
                <span>để lật thẻ</span>
              </p>
            </div>
          ) : (
            <div className="w-full text-center space-y-4 animate-in fade-in duration-150">
              {/* Pinyin */}
              <p className="text-lg md:text-xl text-body font-sans tracking-widest text-app-accent font-semibold">
                {currentVocab.pinyin}
              </p>

              {/* Hanzi + Audio */}
              <div className="flex items-center justify-center gap-3">
                <span className="text-5xl md:text-7xl font-serif text-title font-bold leading-tight">
                  {currentVocab.hanzi}
                </span>
                <AudioButton
                  text={currentVocab.hanzi}
                  id={`fc-${currentVocab.id}`}
                  size="md"
                  variant="subtle"
                  rate={speechRate}
                  tooltip="Nghe lại phát âm"
                />
              </div>

              {/* Meaning */}
              <div className="bg-app-accent-soft/40 border border-app-accent/20 px-6 py-2.5 rounded-xl inline-block max-w-md">
                <span className="text-lg md:text-xl font-serif text-title font-bold">
                  {currentVocab.meaning_vi}
                </span>
              </div>

              {/* Example sentence */}
              {currentVocab.example_hanzi && (
                <div className="bg-page border border-border/80 p-3.5 rounded-xl max-w-md mx-auto text-center space-y-1 mt-2">
                  <p className="text-[11px] font-sans text-muted">{currentVocab.example_pinyin}</p>
                  <div className="text-sm md:text-base font-serif text-title flex items-center justify-center gap-2">
                    <span>{currentVocab.example_hanzi}</span>
                    <AudioButton
                      text={currentVocab.example_hanzi}
                      id={`fc-ex-${currentVocab.id}`}
                      size="xs"
                      variant="ghost"
                      rate={speechRate}
                      tooltip="Nghe câu ví dụ"
                    />
                  </div>
                  <p className="text-xs text-body font-serif italic">{currentVocab.example_vi}</p>
                </div>
              )}
            </div>
          )}
        </div>

        {/* Action Controls */}
        <div className="flex gap-3 h-12">
          {!showAnswer ? (
            <Button
              className="w-full h-full text-sm font-serif bg-app-accent hover:bg-app-accent/90 text-white rounded-xl shadow-2xs gap-2"
              onClick={() => {
                setShowAnswer(true)
                speak(currentVocab.hanzi, { id: `fc-${currentVocab.id}`, rate: speechRate })
              }}
            >
              <span>Lật thẻ</span>
              <kbd className="hidden sm:inline-block px-1.5 py-0.2 bg-white/20 rounded text-[10px] font-mono">
                Space
              </kbd>
            </Button>
          ) : (
            <>
              <Button
                variant="outline"
                disabled={isUpdating}
                className="flex-1 h-full text-xs sm:text-sm font-serif border-red-200 text-red-700 hover:bg-red-50 rounded-xl gap-1.5"
                onClick={() => handleLearnAnswer(false)}
              >
                <XCircle className="w-4 h-4 text-red-500" />
                <span>Chưa thuộc</span>
                <kbd className="hidden sm:inline-block px-1 py-0.2 bg-black/5 rounded text-[10px] font-mono ml-1">
                  1
                </kbd>
              </Button>

              <Button
                disabled={isUpdating}
                className="flex-1 h-full text-xs sm:text-sm font-serif bg-jade hover:bg-jade/90 text-white rounded-xl shadow-2xs gap-1.5"
                onClick={() => handleLearnAnswer(true)}
              >
                <CheckCircle2 className="w-4 h-4" />
                <span>Đã thuộc</span>
                <kbd className="hidden sm:inline-block px-1 py-0.2 bg-white/20 rounded text-[10px] font-mono ml-1">
                  2
                </kbd>
              </Button>
            </>
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
          <div className="flex items-center gap-2">
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-app-accent-soft text-app-accent border border-app-accent/20">
              {lesson.hsk_level} • Bài {lesson.lesson_number || '01'}
            </span>
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

          <Button
            onClick={() => {
              setLearningIndex(0)
              setShowAnswer(false)
              setUnlearnedInSession([])
              setIsLearning(true)
            }}
            className="font-serif bg-app-accent hover:bg-app-accent/90 text-white rounded-xl px-6 h-10 text-xs sm:text-sm gap-2 shadow-2xs self-start sm:self-auto cursor-pointer"
          >
            <PlayCircle className="w-4 h-4" />
            <span>Học bài này (Flashcard)</span>
          </Button>
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
