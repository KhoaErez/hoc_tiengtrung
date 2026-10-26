'use client'

import React, { useState, useEffect, useRef, useMemo, useCallback } from 'react'
import {
  TranslationExerciseItem,
  getTranslationExercisesAction,
  getSystemLessonsForTypingAction,
  getTypingProgressAction,
  saveTypingProgressAction,
  recordTypingMistakeAction,
  TypingProgressDTO,
} from '../actions'
import {
  evaluateTranslationInput,
  TranslationEvaluationResult,
} from '@/lib/translation-typing-eval'
import { ttsEngine, TTS_SPEED_RATES, TTSSpeedRate } from '@/lib/tts/tts-engine'
import { playTypingSfx } from '@/lib/typing-sound'
import {
  saveLocalTypingDraft,
  getLocalTypingDraft,
  clearLocalTypingDraft,
  saveLocalTypingProgress,
  getLocalTypingProgress,
  recordLocalTypingMistake,
} from '@/lib/typing-storage'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import { toast } from 'sonner'
import {
  Volume2,
  VolumeX,
  Play,
  RotateCcw,
  CheckCircle2,
  ArrowRight,
  ArrowLeft,
  Lightbulb,
  HelpCircle,
  Clock,
  Layers,
  GraduationCap,
  BookOpen,
  Loader2,
  AlertCircle,
  Eye,
  Check,
  ChevronDown,
  X,
  Send,
} from 'lucide-react'

export type TranslationPracticeStatus =
  | 'typing'
  | 'checking'
  | 'incorrect'
  | 'correct'
  | 'transitioning'

export interface TranslateTypingModeProps {
  initialHskLevel?: number
  initialLessonId?: string
  onBackToNormalMode?: () => void
}

export default function TranslateTypingMode({
  initialHskLevel = 1,
  initialLessonId = '',
  onBackToNormalMode,
}: TranslateTypingModeProps) {
  const { user, isLoggedIn } = useAuthModal()

  // 1. Bộ lọc cấp độ & Bài học
  const [hskLevel, setHskLevel] = useState<number>(() => {
    return initialHskLevel >= 1 && initialHskLevel <= 5 ? initialHskLevel : 1
  })
  const [selectedLessonId, setSelectedLessonId] = useState<string>(initialLessonId)
  const [systemLessons, setSystemLessons] = useState<
    { id: string; lessonNumber: number; title: string; subtitle: string; hskLevel: number }[]
  >([])
  const [loadingLessons, setLoadingLessons] = useState<boolean>(false)

  // 2. Danh sách câu bài tập từ Supabase
  const [exercises, setExercises] = useState<TranslationExerciseItem[]>([])
  const [loadingExercises, setLoadingExercises] = useState<boolean>(true)
  const [currentIndex, setCurrentIndex] = useState<number>(0)

  // 3. Trạng thái nhập liệu & IME
  const [userInput, setUserInput] = useState<string>('')
  const [isComposing, setIsComposing] = useState<boolean>(false)
  const [compositionText, setCompositionText] = useState<string>('')
  const isComposingRef = useRef<boolean>(false)
  const justEndedCompositionRef = useRef<boolean>(false)
  const justEndedCompositionTimerRef = useRef<NodeJS.Timeout | null>(null)
  const inputRef = useRef<HTMLInputElement | HTMLTextAreaElement | null>(null)

  // 4. State Machine quản lý kiểm tra đáp án & chuyển câu
  // typing: đang gõ/chỉnh sửa | checking: đang đánh giá | incorrect: sai | correct: đúng | transitioning: đang chuyển câu
  const [practiceStatus, setPracticeStatus] = useState<TranslationPracticeStatus>('typing')
  const practiceStatusRef = useRef<TranslationPracticeStatus>('typing')
  const [evaluation, setEvaluation] = useState<TranslationEvaluationResult | null>(null)
  const [hintLevel, setHintLevel] = useState<number>(0) // 0: chưa gợi ý, 1: từ vựng, 2: pinyin, 3: toàn bộ chữ Hán
  const [hintsUsedCount, setHintsUsedCount] = useState<number>(0)

  // Cập nhật state machine an toàn và đồng bộ ref ngay lập tức
  const updatePracticeStatus = useCallback((status: TranslationPracticeStatus) => {
    practiceStatusRef.current = status
    setPracticeStatus(status)
  }, [])

  // 5. Thống kê phiên luyện tập
  const [elapsedSeconds, setElapsedSeconds] = useState<number>(0)
  const [isTimerRunning, setIsTimerRunning] = useState<boolean>(false)
  const [correctCount, setCorrectCount] = useState<number>(0)
  const [reviewCount, setReviewCount] = useState<number>(0)

  // 6. Âm thanh TTS
  const [isAudioPlaying, setIsAudioPlaying] = useState<boolean>(false)
  const [speechRate, setSpeechRate] = useState<TTSSpeedRate>(1.0)
  const [showSpeedMenu, setShowSpeedMenu] = useState<boolean>(false)

  const currentExercise = exercises[currentIndex] || null
  const progressMode = 'translate_hsk'
  const exerciseStorageId = selectedLessonId ? `hsk${hskLevel}-lesson-${selectedLessonId}` : `hsk${hskLevel}-all`

  // Dọn dẹp timer IME khi component unmount
  useEffect(() => {
    return () => {
      if (justEndedCompositionTimerRef.current) {
        clearTimeout(justEndedCompositionTimerRef.current)
      }
    }
  }, [])

  // Tải danh sách bài học của cấp HSK hiện tại
  useEffect(() => {
    let isCancelled = false
    setLoadingLessons(true)

    getSystemLessonsForTypingAction(hskLevel)
      .then((res) => {
        if (isCancelled) return
        setLoadingLessons(false)
        if (res.success && res.data) {
          setSystemLessons(res.data)
        }
      })
      .catch((err) => {
        if (!isCancelled) setLoadingLessons(false)
        console.error('Lỗi tải bài học HSK:', err)
      })

    return () => {
      isCancelled = true
    }
  }, [hskLevel])

  // Reset trạng thái khi sang câu mới
  const resetSentenceState = useCallback(() => {
    setUserInput('')
    updatePracticeStatus('typing')
    setEvaluation(null)
    setHintLevel(0)
    ttsEngine.stop()
    setIsAudioPlaying(false)
    isComposingRef.current = false
    setIsComposing(false)
    justEndedCompositionRef.current = false
    setTimeout(() => {
      inputRef.current?.focus()
    }, 100)
  }, [updatePracticeStatus])

  // Tải danh sách câu ví dụ từ Supabase
  useEffect(() => {
    let isCancelled = false
    setLoadingExercises(true)
    setCurrentIndex(0)
    resetSentenceState()

    getTranslationExercisesAction({
      hskLevel,
      lessonId: selectedLessonId || undefined,
      limit: 60,
    })
      .then((res) => {
        if (isCancelled) return
        setLoadingExercises(false)
        if (res.success && res.data && res.data.length > 0) {
          setExercises(res.data)
        } else {
          setExercises([])
        }
      })
      .catch((err) => {
        if (!isCancelled) setLoadingExercises(false)
        console.error('Lỗi tải câu dịch từ Supabase:', err)
        setExercises([])
      })

    return () => {
      isCancelled = true
    }
  }, [hskLevel, selectedLessonId, resetSentenceState])

  // Khôi phục bản nháp hoặc tiến độ cũ của câu hiện tại
  useEffect(() => {
    if (!currentExercise) return
    const draft = getLocalTypingDraft(progressMode, `${exerciseStorageId}-${currentExercise.id}`)
    if (draft && draft.draftText && practiceStatusRef.current === 'typing') {
      setUserInput(draft.draftText)
    }
  }, [currentExercise?.id, exerciseStorageId])

  // Quản lý đồng hồ tính giờ
  useEffect(() => {
    let timer: NodeJS.Timeout | null = null
    if (isTimerRunning && practiceStatus !== 'correct') {
      timer = setInterval(() => {
        setElapsedSeconds((prev) => prev + 1)
      }, 1000)
    }
    return () => {
      if (timer) clearInterval(timer)
    }
  }, [isTimerRunning, practiceStatus])

  // Tự động lưu bản nháp ký tự với debounce 300ms (chỉ lưu khi đang ở trạng thái typing)
  const draftTimerRef = useRef<NodeJS.Timeout | null>(null)
  useEffect(() => {
    if (!currentExercise || practiceStatus !== 'typing' || !userInput) return
    if (draftTimerRef.current) clearTimeout(draftTimerRef.current)

    draftTimerRef.current = setTimeout(() => {
      saveLocalTypingDraft(progressMode, `${exerciseStorageId}-${currentExercise.id}`, currentIndex, userInput)
    }, 300)

    return () => {
      if (draftTimerRef.current) clearTimeout(draftTimerRef.current)
    }
  }, [userInput, currentExercise, currentIndex, practiceStatus, exerciseStorageId])

  // Dừng TTS khi chuyển câu hoặc component unmount
  useEffect(() => {
    return () => {
      ttsEngine.stop()
    }
  }, [currentIndex])

  // Xử lý phát âm TTS câu tiếng Trung mẫu mà KHÔNG để lộ chữ Hán
  const handlePlayAudio = useCallback(() => {
    if (!currentExercise?.chineseAnswer) return

    if (isAudioPlaying) {
      ttsEngine.stop()
      setIsAudioPlaying(false)
      return
    }

    ttsEngine.stop()
    setIsAudioPlaying(true)

    ttsEngine.speak(currentExercise.chineseAnswer, {
      id: `trans-${currentExercise.id}`,
      rate: speechRate,
      onStart: () => setIsAudioPlaying(true),
      onEnd: () => setIsAudioPlaying(false),
      onError: () => setIsAudioPlaying(false),
    })
  }, [currentExercise, isAudioPlaying, speechRate])

  // Xử lý mở gợi ý thông minh từng mức
  const handleNextHint = useCallback(() => {
    if (hintLevel < 3) {
      const nextLevel = hintLevel + 1
      setHintLevel(nextLevel)
      setHintsUsedCount((prev) => prev + 1)
      playTypingSfx('correct', 0.04)
    }
  }, [hintLevel])

  // Xử lý khi người dùng nhập liệu hoặc chỉnh sửa
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value
    if (!isTimerRunning && val.length > 0) {
      setIsTimerRunning(true)
    }
    setUserInput(val)

    // Khi người dùng chỉnh sửa đáp án:
    // Kết quả kiểm tra cũ bị vô hiệu hóa, trạng thái trở về 'typing' để chuẩn bị Enter kiểm tra lại
    if (practiceStatusRef.current === 'incorrect' || practiceStatusRef.current === 'correct') {
      updatePracticeStatus('typing')
      setEvaluation(null)
    }
  }

  // Sự kiện Composition của bàn phím tiếng Trung IME
  const handleCompositionStart = () => {
    isComposingRef.current = true
    setIsComposing(true)
    justEndedCompositionRef.current = false
    if (justEndedCompositionTimerRef.current) {
      clearTimeout(justEndedCompositionTimerRef.current)
      justEndedCompositionTimerRef.current = null
    }
    if (!isTimerRunning) setIsTimerRunning(true)
  }

  const handleCompositionUpdate = (e: React.CompositionEvent<HTMLInputElement>) => {
    setCompositionText(e.data || '')
  }

  const handleCompositionEnd = (e: React.CompositionEvent<HTMLInputElement>) => {
    isComposingRef.current = false
    setIsComposing(false)
    setCompositionText('')
    setUserInput(e.currentTarget.value)

    // Đặt cờ vừa kết thúc composition trong 150ms để chặn phím Enter xác nhận IME không bị kích hoạt kiểm tra
    justEndedCompositionRef.current = true
    if (justEndedCompositionTimerRef.current) {
      clearTimeout(justEndedCompositionTimerRef.current)
    }
    justEndedCompositionTimerRef.current = setTimeout(() => {
      justEndedCompositionRef.current = false
    }, 150)
  }

  // Kiểm tra đáp án câu dịch
  const handleCheckAnswer = useCallback(async () => {
    if (!currentExercise || practiceStatusRef.current !== 'typing' || !userInput.trim()) return

    updatePracticeStatus('checking')
    setIsTimerRunning(false)
    ttsEngine.stop()
    setIsAudioPlaying(false)

    const evalResult = evaluateTranslationInput(userInput, currentExercise.chineseAnswer)
    setEvaluation(evalResult)

    // Xóa bản nháp câu này sau khi đã kiểm tra
    clearLocalTypingDraft(progressMode, `${exerciseStorageId}-${currentExercise.id}`)

    const isMatch = evalResult.isExactMatch
    if (isMatch) {
      updatePracticeStatus('correct')
      setCorrectCount((prev) => prev + 1)
      playTypingSfx('complete', 0.08)
    } else {
      updatePracticeStatus('incorrect')
      setReviewCount((prev) => prev + 1)
      playTypingSfx('error', 0.06)

      // Ghi nhận câu khác câu mẫu vào danh sách câu sai/ôn tập
      const mistakeDetails = evalResult.diffTokens
        .filter((t) => t.type !== 'match')
        .map((t) => ({
          index: t.index + 1,
          expected: t.expectedChar || '(thiếu)',
          actual: t.userInputChar || '(khác)',
        }))

      const mistakePayload = {
        mode: progressMode,
        exerciseId: exerciseStorageId,
        sentenceIndex: currentIndex,
        sentenceZh: currentExercise.chineseAnswer,
        pinyin: currentExercise.pinyinAnswer,
        meaningVi: currentExercise.vietnamesePrompt,
        lastInputZh: userInput,
        mistakeDetails,
      }

      recordLocalTypingMistake(mistakePayload)
      if (isLoggedIn) {
        recordTypingMistakeAction(mistakePayload).catch(() => {})
      }
    }

    // Cập nhật tiến độ học tập lên Supabase & Local
    const progressPayload: TypingProgressDTO = {
      mode: progressMode,
      exerciseId: exerciseStorageId,
      currentSentenceIndex: currentIndex,
      completedSentences: isMatch ? currentIndex + 1 : currentIndex,
      totalSentences: exercises.length,
      correctSentences: correctCount + (isMatch ? 1 : 0),
      errorSentences: reviewCount + (!isMatch ? 1 : 0),
      lastTypedLength: userInput.length,
      timeSpentSeconds: Math.max(elapsedSeconds, 1),
      status: currentIndex >= exercises.length - 1 && isMatch ? 'completed' : 'in_progress',
      updatedAt: new Date().toISOString(),
    }

    saveLocalTypingProgress(progressPayload as any)
    if (isLoggedIn) {
      saveTypingProgressAction(progressPayload).catch(() => {})
    }

    // Giữ focus cho input để tiếp tục nhận phím tiếp theo
    setTimeout(() => {
      inputRef.current?.focus()
    }, 50)
  }, [
    currentExercise,
    userInput,
    exerciseStorageId,
    progressMode,
    currentIndex,
    exercises.length,
    correctCount,
    reviewCount,
    elapsedSeconds,
    isLoggedIn,
    updatePracticeStatus,
  ])

  // Chuyển sang câu tiếp theo (hoặc chuyển tự do qua nút "Câu tiếp theo")
  const handleNextSentence = useCallback((options?: { isSkipManual?: boolean }) => {
    // Ngăn chặn race condition chuyển câu 2 lần
    if (practiceStatusRef.current === 'transitioning') return

    const currentStatus = practiceStatusRef.current
    const isCurrentlyCorrect = currentStatus === 'correct'

    updatePracticeStatus('transitioning')

    // Dọn dẹp bản nháp câu cũ
    if (currentExercise) {
      clearLocalTypingDraft(progressMode, `${exerciseStorageId}-${currentExercise.id}`)
    }

    // Nếu người dùng bấm "Câu tiếp theo" để bỏ qua khi chưa kiểm tra (đang typing):
    // Cập nhật vị trí lưu tiến độ mà KHÔNG ghi nhận câu đúng
    if (currentStatus === 'typing' && currentExercise) {
      const skipProgressPayload: TypingProgressDTO = {
        mode: progressMode,
        exerciseId: exerciseStorageId,
        currentSentenceIndex: currentIndex + 1 < exercises.length ? currentIndex + 1 : currentIndex,
        completedSentences: currentIndex,
        totalSentences: exercises.length,
        correctSentences: correctCount,
        errorSentences: reviewCount,
        lastTypedLength: userInput.length,
        timeSpentSeconds: Math.max(elapsedSeconds, 1),
        status: currentIndex >= exercises.length - 1 ? 'completed' : 'in_progress',
        updatedAt: new Date().toISOString(),
      }
      saveLocalTypingProgress(skipProgressPayload as any)
      if (isLoggedIn) {
        saveTypingProgressAction(skipProgressPayload).catch(() => {})
      }
    }

    ttsEngine.stop()
    setIsAudioPlaying(false)

    // Xử lý khi đến câu cuối cùng
    if (currentIndex >= exercises.length - 1) {
      toast.success('Bạn đã hoàn thành bài luyện dịch này!', {
        description: `Kết quả: ${correctCount} câu trùng mẫu, ${reviewCount} câu cần xem lại.`,
        duration: 4000,
      })
      updatePracticeStatus(isCurrentlyCorrect ? 'correct' : 'typing')
      return
    }

    // Chuyển câu bình thường
    setCurrentIndex((prev) => prev + 1)
    resetSentenceState()
  }, [
    currentExercise,
    currentIndex,
    exercises.length,
    progressMode,
    exerciseStorageId,
    correctCount,
    reviewCount,
    userInput.length,
    elapsedSeconds,
    isLoggedIn,
    resetSentenceState,
    updatePracticeStatus,
  ])

  // Xử lý phím Enter:
  // - Lần đầu: kiểm tra đáp án
  // - Nếu đúng: Enter lần 2 mới chuyển câu
  // - Nếu sai: Enter KHÔNG chuyển câu, cho phép sửa rồi Enter kiểm tra lại
  // - Phải chặn IME composition hoàn toàn
  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    // 1. Chặn phím lặp do giữ phím Enter
    if (e.repeat) {
      if (e.key === 'Enter') e.preventDefault()
      return
    }

    // 2. Chặn tuyệt đối khi IME đang chọn chữ hoặc vừa kết thúc composition
    if (
      isComposing ||
      isComposingRef.current ||
      e.nativeEvent?.isComposing ||
      e.keyCode === 229 ||
      justEndedCompositionRef.current
    ) {
      return
    }

    if (e.key === 'Enter') {
      e.preventDefault()
      const currentStatus = practiceStatusRef.current

      // A. Nếu đang typing: kiểm tra đáp án nếu có nội dung
      if (currentStatus === 'typing') {
        if (userInput.trim().length > 0) {
          handleCheckAnswer()
        }
        return
      }

      // B. Nếu đang incorrect: KHÔNG chuyển câu, giữ nguyên cho phép sửa
      if (currentStatus === 'incorrect') {
        return
      }

      // C. Nếu đã correct: Chuyển sang câu tiếp theo
      if (currentStatus === 'correct') {
        handleNextSentence()
        return
      }

      // D. Nếu đang checking hoặc transitioning: bỏ qua tránh double-submit
      if (currentStatus === 'checking' || currentStatus === 'transitioning') {
        return
      }
    }
  }

  // Bổ sung listener toàn cục: Khi đã correct, dù click ra ngoài vẫn nhấn Enter chuyển câu được
  useEffect(() => {
    const handleGlobalKeyDown = (e: KeyboardEvent) => {
      if (document.activeElement === inputRef.current) return
      if (e.repeat) return
      if (
        e.isComposing ||
        e.keyCode === 229 ||
        isComposingRef.current ||
        justEndedCompositionRef.current
      ) {
        return
      }

      const tagName = (document.activeElement?.tagName || '').toLowerCase()
      if (tagName === 'input' || tagName === 'select' || tagName === 'textarea') return

      if (e.key === 'Enter') {
        const currentStatus = practiceStatusRef.current
        if (currentStatus === 'correct') {
          e.preventDefault()
          handleNextSentence()
        }
      }
    }

    window.addEventListener('keydown', handleGlobalKeyDown)
    return () => window.removeEventListener('keydown', handleGlobalKeyDown)
  }, [handleNextSentence])

  // Luyện lại câu hiện tại
  const handleRetryCurrent = useCallback(() => {
    resetSentenceState()
  }, [resetSentenceState])

  // Quay lại câu trước
  const handlePrevSentence = useCallback(() => {
    if (currentIndex > 0) {
      setCurrentIndex((prev) => prev - 1)
      resetSentenceState()
    }
  }, [currentIndex, resetSentenceState])

  return (
    <div className="space-y-4 pb-28 md:pb-12 max-w-4xl mx-auto select-text">
      {/* 1. Header chọn cấp HSK & Bài học */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-card border border-[#E9DDD1] rounded-2xl p-3 sm:p-4 shadow-2xs">
        <div className="flex items-center gap-2 flex-wrap">
          <span className="text-[11px] uppercase font-mono tracking-wider px-2 py-0.5 rounded bg-app-accent/10 text-app-accent border border-app-accent/20 font-bold">
            HSK 3.0
          </span>

          {/* Chọn cấp HSK 1 - 5 */}
          <div className="flex items-center gap-1">
            {[1, 2, 3, 4, 5].map((lvl) => (
              <button
                key={lvl}
                onClick={() => {
                  setHskLevel(lvl)
                  setSelectedLessonId('')
                }}
                className={`px-3 py-1.5 rounded-xl text-xs font-serif font-semibold transition-all active:scale-95 cursor-pointer touch-manipulation min-h-[36px] ${
                  hskLevel === lvl
                    ? 'bg-[#B8322D] text-white shadow-2xs'
                    : 'bg-page border border-border text-muted hover:text-title hover:bg-[#FFF9F3]'
                }`}
              >
                HSK {lvl}
              </button>
            ))}
          </div>
        </div>

        {/* Chọn bài học cụ thể */}
        <div className="flex items-center gap-2">
          <span className="text-xs text-muted font-serif hidden sm:inline">Bài học:</span>
          {loadingLessons ? (
            <div className="flex items-center gap-1 text-xs text-muted font-serif px-2.5 py-1.5 bg-page border border-border rounded-xl">
              <Loader2 className="w-3.5 h-3.5 animate-spin text-app-accent" />
              <span>Đang tải...</span>
            </div>
          ) : (
            <select
              value={selectedLessonId}
              onChange={(e) => setSelectedLessonId(e.target.value)}
              className="bg-page border border-[#E9DDD1] rounded-xl text-xs font-serif text-title px-3 py-1.5 focus:outline-none focus:border-app-accent max-w-[230px] truncate cursor-pointer shadow-2xs"
            >
              <option value="">Tất cả bài học (HSK {hskLevel})</option>
              {systemLessons.map((l) => (
                <option key={l.id} value={l.id}>
                  {l.title}
                </option>
              ))}
            </select>
          )}

          {/* Danh sách chọn câu nhanh */}
          {exercises.length > 0 && (
            <select
              value={currentIndex}
              onChange={(e) => {
                const idx = parseInt(e.target.value, 10)
                if (!isNaN(idx) && idx >= 0 && idx < exercises.length) {
                  setCurrentIndex(idx)
                  resetSentenceState()
                }
              }}
              className="bg-page border border-[#E9DDD1] rounded-xl text-xs font-serif text-title px-2.5 py-1.5 focus:outline-none focus:border-app-accent max-w-[140px] sm:max-w-[180px] truncate cursor-pointer shadow-2xs"
              title="Chuyển nhanh đến câu bất kỳ"
            >
              {exercises.map((ex, idx) => (
                <option key={ex.id || idx} value={idx}>
                  #{idx + 1}: {ex.vietnamesePrompt}
                </option>
              ))}
            </select>
          )}
        </div>
      </div>

      {/* 2. Thanh tiến độ bài học & Thống kê ngắn */}
      {exercises.length > 0 && (
        <div className="flex items-center justify-between gap-2 px-1 text-xs font-serif text-muted">
          <div className="flex items-center gap-2">
            <span className="font-semibold text-title">
              Câu {currentIndex + 1} / {exercises.length}
            </span>
            <span className="w-1 h-1 rounded-full bg-border" />
            <span className="text-emerald-700 dark:text-emerald-400 font-medium">
              {correctCount} trùng mẫu
            </span>
            {reviewCount > 0 && (
              <>
                <span className="w-1 h-1 rounded-full bg-border" />
                <span className="text-amber-700 dark:text-amber-400 font-medium">
                  {reviewCount} cần xem lại
                </span>
              </>
            )}
          </div>

          <div className="flex items-center gap-1.5">
            <Clock className="w-3.5 h-3.5 text-muted" />
            <span>{Math.floor(elapsedSeconds / 60)}:{String(elapsedSeconds % 60).padStart(2, '0')}</span>
          </div>
        </div>
      )}

      {/* 3. Khung nội dung chính */}
      {loadingExercises ? (
        <div className="p-12 text-center bg-card border border-[#E9DDD1] rounded-2xl space-y-3 shadow-2xs">
          <Loader2 className="w-8 h-8 text-app-accent animate-spin mx-auto" />
          <h3 className="text-base font-serif font-medium text-title">Đang tải câu dịch từ cơ sở dữ liệu...</h3>
          <p className="text-xs text-muted font-serif">Đang đồng bộ ví dụ song ngữ HSK {hskLevel}</p>
        </div>
      ) : !currentExercise ? (
        <div className="p-12 text-center bg-card border border-[#E9DDD1] rounded-2xl space-y-3 shadow-2xs">
          <BookOpen className="w-10 h-10 text-muted mx-auto" />
          <h3 className="text-base font-serif font-medium text-title">Chưa có câu ví dụ cho bài học này</h3>
          <p className="text-xs text-muted font-serif">Vui lòng chọn bài học hoặc cấp độ HSK khác.</p>
        </div>
      ) : (
        <div className="space-y-4">
          {/* Card đề bài: Câu tiếng Việt */}
          <div className="bg-card border-2 border-[#E9DDD1] rounded-2xl p-4 sm:p-6 md:p-8 shadow-xs space-y-4">
            <div className="flex items-center justify-between gap-2 border-b border-border/60 pb-3">
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-app-accent" />
                <span className="text-xs font-serif font-medium text-muted">
                  Dịch câu tiếng Việt sang chữ Hán:
                </span>
              </div>
              <span className="text-[11px] font-sans px-2 py-0.5 rounded-full bg-[#FFF9F3] border border-[#E9DDD1] text-title font-medium">
                {currentExercise.lessonTitle || `HSK ${hskLevel}`}
              </span>
            </div>

            {/* Câu tiếng Việt nổi bật */}
            <div className="py-2">
              <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#243047] leading-relaxed tracking-normal">
                &ldquo;{currentExercise.vietnamesePrompt}&rdquo;
              </h2>
            </div>

            {/* Thanh điều khiển âm thanh TTS tiếng Trung */}
            <div className="flex items-center justify-between gap-2 pt-2 border-t border-border/50 flex-wrap">
              <div className="flex items-center gap-2">
                <button
                  type="button"
                  onClick={handlePlayAudio}
                  className={`flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs md:text-sm font-serif font-medium transition-all active:scale-95 cursor-pointer touch-manipulation min-h-[44px] shadow-2xs ${
                    isAudioPlaying
                      ? 'bg-app-accent text-white shadow-sm'
                      : 'bg-[#FFF9F3] hover:bg-[#F6EDE3] border border-[#E9DDD1] text-[#243047]'
                  }`}
                  title="Nghe phát âm câu tiếng Trung của câu mẫu"
                >
                  <Volume2 className={`w-4 h-4 shrink-0 ${isAudioPlaying ? 'animate-pulse' : 'text-app-accent'}`} />
                  <span>{isAudioPlaying ? 'Đang phát...' : 'Nghe câu tiếng Trung'}</span>
                </button>

                {/* Chọn tốc độ đọc TTS */}
                <div className="relative">
                  <button
                    type="button"
                    onClick={() => setShowSpeedMenu((prev) => !prev)}
                    className="flex items-center gap-1 px-2.5 py-2 bg-page border border-[#E9DDD1] hover:border-app-accent/50 rounded-xl text-xs font-mono text-title transition-colors touch-manipulation min-h-[44px] cursor-pointer"
                    title="Điều chỉnh tốc độ đọc"
                  >
                    <span>{speechRate}x</span>
                    <ChevronDown className="w-3 h-3 text-muted" />
                  </button>

                  {showSpeedMenu && (
                    <div className="absolute left-0 bottom-full mb-1 bg-card border border-border rounded-xl shadow-lg p-1 z-30 flex flex-col gap-0.5 min-w-[70px]">
                      {TTS_SPEED_RATES.map((rate) => (
                        <button
                          key={rate}
                          type="button"
                          onClick={() => {
                            setSpeechRate(rate)
                            setShowSpeedMenu(false)
                          }}
                          className={`px-2.5 py-1 text-xs font-mono rounded-lg text-left transition-colors cursor-pointer ${
                            speechRate === rate
                              ? 'bg-app-accent text-white font-bold'
                              : 'text-title hover:bg-page'
                          }`}
                        >
                          {rate}x
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              </div>

              {/* Thông tin hỗ trợ */}
              <span className="text-[11px] text-muted font-serif hidden sm:inline">
                💡 Nghe phát âm hỗ trợ suy nghĩ chữ Hán mà không lộ đáp án
              </span>
            </div>
          </div>

          {/* 4. Khối Gợi ý thông minh (Multi-level hints) */}
          {hintLevel > 0 && (
            <div className="bg-amber-50/80 dark:bg-amber-950/20 border border-amber-300/60 dark:border-amber-800/50 rounded-2xl p-4 space-y-2.5 animate-in fade-in duration-200 shadow-2xs">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-1.5 text-xs font-serif font-bold text-amber-900 dark:text-amber-200">
                  <Lightbulb className="w-4 h-4 text-amber-600 dark:text-amber-400" />
                  <span>Gợi ý đã mở ({hintLevel}/3):</span>
                </div>
                {hintLevel < 3 && practiceStatus !== 'correct' && (
                  <button
                    type="button"
                    onClick={handleNextHint}
                    className="text-xs text-amber-800 dark:text-amber-300 font-serif hover:underline cursor-pointer"
                  >
                    Mở thêm gợi ý tiếp theo →
                  </button>
                )}
              </div>

              <div className="space-y-2 text-xs sm:text-sm font-serif">
                {/* Gợi ý 1: Từ vựng trọng tâm */}
                {hintLevel >= 1 && (
                  <div className="p-2.5 rounded-xl bg-white/80 dark:bg-amber-900/30 border border-amber-200/60 flex items-baseline gap-2">
                    <span className="text-amber-700 dark:text-amber-400 font-bold shrink-0">
                      Từ vựng trọng tâm:
                    </span>
                    <span className="text-base font-bold text-[#B8322D]" style={{ fontFamily: 'var(--font-chinese), sans-serif' }}>
                      {currentExercise.wordHanzi}
                    </span>
                    <span className="text-muted font-sans text-xs">
                      [{currentExercise.wordPinyin}]
                    </span>
                    <span className="text-body text-xs">
                      — {currentExercise.wordMeaning}
                    </span>
                  </div>
                )}

                {/* Gợi ý 2: Pinyin câu mẫu */}
                {hintLevel >= 2 && (
                  <div className="p-2.5 rounded-xl bg-white/80 dark:bg-amber-900/30 border border-amber-200/60 flex items-baseline gap-2">
                    <span className="text-amber-700 dark:text-amber-400 font-bold shrink-0">
                      Phiên âm Pinyin:
                    </span>
                    <span className="text-title font-sans font-medium tracking-wide">
                      {currentExercise.pinyinAnswer}
                    </span>
                  </div>
                )}

                {/* Gợi ý 3: Toàn bộ chữ Hán tham khảo */}
                {hintLevel >= 3 && (
                  <div className="p-2.5 rounded-xl bg-white/80 dark:bg-amber-900/30 border border-amber-200/60 flex items-baseline gap-2">
                    <span className="text-amber-700 dark:text-amber-400 font-bold shrink-0">
                      Chữ Hán tham khảo:
                    </span>
                    <span className="text-lg font-bold text-[#243047]" style={{ fontFamily: 'var(--font-chinese), sans-serif' }}>
                      {currentExercise.chineseAnswer}
                    </span>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* 5. Ô nhập liệu chữ Hán bằng Pinyin IME */}
          <div className="space-y-2">
            <div className="relative">
              <input
                ref={inputRef as React.RefObject<HTMLInputElement>}
                type="text"
                value={userInput}
                onChange={handleInputChange}
                onKeyDown={handleKeyDown}
                onCompositionStart={handleCompositionStart}
                onCompositionUpdate={handleCompositionUpdate}
                onCompositionEnd={handleCompositionEnd}
                readOnly={practiceStatus === 'correct' || practiceStatus === 'checking' || practiceStatus === 'transitioning'}
                autoComplete="off"
                autoCorrect="off"
                autoCapitalize="off"
                spellCheck="false"
                placeholder={
                  practiceStatus === 'correct'
                    ? 'Đã trùng khớp câu mẫu! Nhấn Enter lần nữa hoặc bấm "Câu tiếp theo" để tiếp tục...'
                    : practiceStatus === 'incorrect'
                    ? 'Chưa chính xác. Chỉnh sửa câu của bạn rồi nhấn Enter để kiểm tra lại...'
                    : practiceStatus === 'checking'
                    ? 'Đang kiểm tra đáp án...'
                    : practiceStatus === 'transitioning'
                    ? 'Đang chuyển câu tiếp theo...'
                    : 'Bật bộ gõ tiếng Trung (Pinyin), gõ pinyin rồi chọn chữ Hán tương ứng...'
                }
                className={`w-full px-4 py-3.5 sm:py-4 bg-card border-2 rounded-2xl text-lg sm:text-2xl font-serif text-[#243047] placeholder:text-muted placeholder:text-sm focus:outline-none transition-colors shadow-inner ${
                  practiceStatus === 'correct'
                    ? 'border-emerald-500 bg-emerald-50/20'
                    : practiceStatus === 'incorrect'
                    ? 'border-amber-500/80 bg-amber-50/15'
                    : 'border-[#E9DDD1] focus:border-app-accent'
                }`}
                style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
              />

              {/* Chỉ báo trạng thái gõ IME composition */}
              {isComposing && (
                <div className="absolute right-3 top-3.5 px-2.5 py-1 bg-amber-500/15 border border-amber-400/40 text-amber-700 dark:text-amber-400 rounded-lg text-xs font-sans flex items-center gap-1.5 animate-pulse select-none">
                  <span className="w-2 h-2 rounded-full bg-amber-500" />
                  <span>Đang chọn chữ ({compositionText || 'pinyin'})...</span>
                </div>
              )}

              {/* Nút xóa nhanh khi chưa kiểm tra hoặc khi đang sửa */}
              {practiceStatus !== 'correct' &&
                practiceStatus !== 'checking' &&
                practiceStatus !== 'transitioning' &&
                userInput.length > 0 &&
                !isComposing && (
                  <button
                    type="button"
                    onClick={() => {
                      setUserInput('')
                      if (practiceStatus === 'incorrect') {
                        updatePracticeStatus('typing')
                        setEvaluation(null)
                      }
                      inputRef.current?.focus()
                    }}
                    className="absolute right-3 top-3.5 p-1 rounded-full text-muted hover:text-title hover:bg-page transition-colors cursor-pointer"
                    title="Xóa nội dung vừa gõ"
                  >
                    <X className="w-4 h-4" />
                  </button>
                )}
            </div>

            {/* Thông tin số ký tự & phím tắt theo trạng thái */}
            <div className="flex items-center justify-between text-xs text-muted font-serif px-1 gap-2 flex-wrap">
              <span>
                Đã gõ: <strong className="text-title">{userInput.length}</strong> ký tự
              </span>
              <span className="flex items-center gap-1.5 flex-wrap justify-end">
                <span className="hidden sm:inline">Phím tắt:</span>
                <kbd className="px-1.5 py-0.5 rounded bg-page border border-border font-mono text-[11px] shadow-2xs font-semibold">
                  Enter
                </kbd>
                {practiceStatus === 'correct' ? (
                  <span className="text-emerald-700 dark:text-emerald-400 font-bold animate-pulse">
                    để chuyển sang câu tiếp theo →
                  </span>
                ) : practiceStatus === 'incorrect' ? (
                  <span className="text-amber-700 dark:text-amber-400 font-medium">
                    để kiểm tra lại
                  </span>
                ) : practiceStatus === 'checking' ? (
                  <span>đang kiểm tra...</span>
                ) : practiceStatus === 'transitioning' ? (
                  <span>đang chuyển câu...</span>
                ) : (
                  <span>để kiểm tra</span>
                )}
              </span>
            </div>
          </div>

          {/* 6. Hàng nút công cụ: Gợi ý & Kiểm tra đáp án */}
          {practiceStatus !== 'correct' && practiceStatus !== 'transitioning' && (
            <div className="flex items-center justify-between gap-2 pt-1">
              <button
                type="button"
                onClick={handleNextHint}
                disabled={hintLevel >= 3 || practiceStatus === 'checking'}
                className={`flex items-center gap-1.5 px-3.5 py-2.5 rounded-xl text-xs sm:text-sm font-serif font-medium transition-all active:scale-95 touch-manipulation min-h-[44px] cursor-pointer shadow-2xs ${
                  hintLevel >= 3 || practiceStatus === 'checking'
                    ? 'bg-page border border-border text-muted/60 cursor-not-allowed'
                    : 'bg-[#FFF9F3] border border-[#E9DDD1] hover:border-[#DDD0C2] text-[#243047]'
                }`}
                title="Mở thêm gợi ý từ vựng, phiên âm hoặc câu mẫu"
              >
                <Lightbulb className="w-4 h-4 text-amber-500 shrink-0" />
                <span>
                  {hintLevel === 0 ? 'Xem gợi ý' : `Gợi ý (${hintLevel}/3)`}
                </span>
              </button>

              <button
                type="button"
                onClick={handleCheckAnswer}
                disabled={userInput.trim().length === 0 || practiceStatus === 'checking'}
                className="flex items-center gap-2 px-5 sm:px-6 py-2.5 bg-[#B8322D] hover:bg-[#982923] disabled:opacity-40 disabled:cursor-not-allowed text-white rounded-xl text-xs sm:text-sm font-serif font-semibold transition-all shadow-2xs active:scale-95 touch-manipulation min-h-[44px] cursor-pointer ml-auto"
              >
                {practiceStatus === 'checking' ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin shrink-0" />
                    <span>Đang kiểm tra...</span>
                  </>
                ) : (
                  <>
                    <CheckCircle2 className="w-4 h-4 shrink-0" />
                    <span>{practiceStatus === 'incorrect' ? 'Kiểm tra lại' : 'Kiểm tra đáp án'}</span>
                  </>
                )}
              </button>
            </div>
          )}

          {/* 7. Khối kết quả sau khi kiểm tra (Evaluation Result Card) */}
          {(practiceStatus === 'correct' || practiceStatus === 'incorrect') && evaluation && (
            <div className="p-4 sm:p-6 bg-page border-2 border-[#E9DDD1] rounded-2xl space-y-4 animate-in fade-in duration-300 shadow-xs">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-border/80 pb-3">
                <div className="flex items-center gap-2.5">
                  {evaluation.isExactMatch ? (
                    <div className="p-2 rounded-xl bg-emerald-500/15 text-emerald-700 dark:text-emerald-400">
                      <CheckCircle2 className="w-5 h-5" />
                    </div>
                  ) : (
                    <div className="p-2 rounded-xl bg-amber-500/15 text-amber-700 dark:text-amber-400">
                      <AlertCircle className="w-5 h-5" />
                    </div>
                  )}

                  <div>
                    <h3 className="text-base sm:text-lg font-serif font-bold text-title flex items-center gap-2">
                      {evaluation.isExactMatch ? (
                        <span className="text-emerald-700 dark:text-emerald-400">
                          Trùng khớp câu mẫu!
                        </span>
                      ) : (
                        <span className="text-amber-700 dark:text-amber-400">
                          Khác câu mẫu — cần xem lại
                        </span>
                      )}
                    </h3>
                    <p className="text-xs text-muted font-serif">
                      {evaluation.isExactMatch
                        ? 'Chữ Hán và dấu câu khớp chính xác với đáp án chuẩn của bài học.'
                        : 'Tiếng Trung có nhiều cách diễn đạt tương đương. Hãy đối chiếu câu mẫu bên dưới để tham khảo hoặc chỉnh sửa lại câu của bạn.'}
                    </p>
                  </div>
                </div>

                <div className="flex items-center gap-2 self-end sm:self-auto">
                  <button
                    type="button"
                    onClick={handleRetryCurrent}
                    className="flex items-center gap-1.5 px-3.5 py-2 bg-[#FFF9F3] border border-[#E9DDD1] hover:bg-[#F6EDE3] rounded-xl text-xs sm:text-sm font-serif text-[#243047] transition-all active:scale-95 touch-manipulation min-h-[44px] cursor-pointer shadow-2xs"
                  >
                    <RotateCcw className="w-4 h-4 shrink-0" />
                    <span>Luyện lại</span>
                  </button>

                  <button
                    type="button"
                    onClick={() => handleNextSentence({ isSkipManual: !evaluation.isExactMatch })}
                    className="flex items-center gap-1.5 px-4 sm:px-5 py-2 bg-[#B8322D] hover:bg-[#982923] text-white rounded-xl text-xs sm:text-sm font-serif font-semibold transition-all shadow-2xs active:scale-95 touch-manipulation min-h-[44px] cursor-pointer"
                  >
                    <span>{currentIndex >= exercises.length - 1 ? 'Hoàn thành' : 'Câu tiếp theo'}</span>
                    <ArrowRight className="w-4 h-4 shrink-0" />
                  </button>
                </div>
              </div>

              {/* Hướng dẫn phím tắt trực quan trong khối kết quả */}
              {evaluation.isExactMatch ? (
                <div className="p-3 rounded-xl bg-emerald-500/10 border border-emerald-500/30 text-emerald-800 dark:text-emerald-300 text-xs sm:text-sm font-serif flex items-center justify-between gap-2 flex-wrap">
                  <span className="flex items-center gap-1.5 font-medium">
                    <Check className="w-4 h-4 text-emerald-600 shrink-0" />
                    <span>
                      Nhấn phím <kbd className="font-mono font-bold px-1.5 py-0.5 rounded bg-white/80 dark:bg-emerald-950/80 border border-emerald-400/40 text-emerald-900 dark:text-emerald-200">Enter</kbd> lần nữa hoặc bấm nút &ldquo;Câu tiếp theo&rdquo; để chuyển sang câu mới.
                    </span>
                  </span>
                </div>
              ) : (
                <div className="p-3 rounded-xl bg-amber-500/10 border border-amber-500/30 text-amber-800 dark:text-amber-300 text-xs sm:text-sm font-serif flex items-center justify-between gap-2 flex-wrap">
                  <span className="flex items-center gap-1.5 font-medium">
                    <AlertCircle className="w-4 h-4 text-amber-600 shrink-0" />
                    <span>
                      Chỉnh sửa câu ở ô nhập liệu bên trên rồi nhấn <kbd className="font-mono font-bold px-1.5 py-0.5 rounded bg-white/80 dark:bg-amber-950/80 border border-amber-400/40 text-amber-900 dark:text-amber-200">Enter</kbd> để kiểm tra lại, hoặc bấm <strong className="font-semibold">&ldquo;Câu tiếp theo&rdquo;</strong> để bỏ qua câu này.
                    </span>
                  </span>
                </div>
              )}

              {/* Bảng so sánh trực quan từng ký tự (Character Diff Viewer) */}
              <div className="space-y-3 bg-card border border-border/80 rounded-xl p-3 sm:p-4">
                <div className="space-y-1">
                  <p className="text-xs text-muted font-serif font-semibold">Câu của bạn đã nhập:</p>
                  <div
                    className="text-lg sm:text-xl font-serif leading-relaxed flex flex-wrap gap-1 items-baseline"
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {evaluation.diffTokens.map((token, i) => {
                      if (token.type === 'match') {
                        return (
                          <span
                            key={i}
                            className="bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 font-bold px-1 rounded"
                          >
                            {token.userInputChar}
                          </span>
                        )
                      }
                      if (token.type === 'diff' || token.type === 'extra') {
                        return (
                          <span
                            key={i}
                            className="bg-amber-500/20 text-amber-800 dark:text-amber-300 font-bold px-1 rounded underline decoration-amber-500"
                          >
                            {token.userInputChar}
                          </span>
                        )
                      }
                      return null
                    })}
                  </div>
                </div>

                {/* Câu mẫu chuẩn tham chiếu */}
                <div className="space-y-1.5 pt-2.5 border-t border-border/60">
                  <p className="text-xs text-muted font-serif font-semibold">Câu mẫu chuẩn hệ thống:</p>
                  <div
                    className="text-lg sm:text-xl font-bold text-[#243047] leading-relaxed"
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {currentExercise.chineseAnswer}
                  </div>
                  <p className="text-xs sm:text-sm font-sans text-muted tracking-wide">
                    {currentExercise.pinyinAnswer}
                  </p>
                </div>
              </div>
            </div>
          )}

          {/* 8. Thanh điều hướng câu trước/sau */}
          <div className="flex items-center justify-between gap-2 pt-2">
            <button
              type="button"
              onClick={handlePrevSentence}
              disabled={currentIndex === 0 || practiceStatus === 'checking' || practiceStatus === 'transitioning'}
              className="flex items-center gap-1.5 px-3 py-2 text-xs sm:text-sm text-[#243047] hover:text-[#B8322D] disabled:opacity-35 disabled:cursor-not-allowed font-serif transition-colors touch-manipulation min-h-[44px] cursor-pointer"
            >
              <ArrowLeft className="w-4 h-4 shrink-0" />
              <span>Câu trước</span>
            </button>

            <button
              type="button"
              onClick={() => handleNextSentence({ isSkipManual: practiceStatus !== 'correct' })}
              disabled={currentIndex >= exercises.length - 1 && practiceStatus === 'correct'}
              className={`flex items-center gap-1.5 px-4 py-2 rounded-xl text-xs sm:text-sm font-serif font-medium transition-all shadow-2xs touch-manipulation min-h-[44px] cursor-pointer ml-auto ${
                practiceStatus === 'correct'
                  ? 'bg-[#B8322D] hover:bg-[#982923] text-white font-semibold'
                  : 'bg-[#FFF9F3] border border-[#E9DDD1] hover:border-app-accent hover:text-app-accent text-title'
              }`}
              title={
                practiceStatus === 'correct'
                  ? 'Chuyển sang câu tiếp theo'
                  : 'Bỏ qua câu hiện tại và sang câu tiếp theo'
              }
            >
              <span>
                {currentIndex >= exercises.length - 1
                  ? practiceStatus === 'correct'
                    ? 'Đã hết câu'
                    : 'Hoàn thành bài'
                  : 'Câu tiếp theo'}
              </span>
              <ArrowRight className="w-4 h-4 shrink-0" />
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
