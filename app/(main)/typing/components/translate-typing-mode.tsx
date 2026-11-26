'use client'

import React, { useState, useEffect, useRef, useCallback } from 'react'
import {
  TranslationExerciseItem,
  TranslateBootstrapData,
  getTranslationExercisesAction,
  getSystemLessonsForTypingAction,
  getTypingProgressAction,
  getLatestTypingProgressAction,
  saveTypingProgressAction,
  resetTypingProgressAction,
  recordTypingMistakeAction,
  getTypingMistakesAction,
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
  getLatestLocalTypingProgress,
  resetLocalTypingProgress,
  recordLocalTypingMistake,
  getLocalTypingMistakes,
} from '@/lib/typing-storage'
import TypingMistakesReview from './typing-mistakes-review'
import TypingResumeCard from './typing-resume-card'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import { toast } from 'sonner'
import {
  Volume2,
  RotateCcw,
  CheckCircle2,
  ArrowRight,
  ArrowLeft,
  Lightbulb,
  Clock,
  BookOpen,
  Loader2,
  AlertCircle,
  Check,
  ChevronDown,
  X,
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
  initialSentenceIndex?: number
  initialSentenceId?: string
  initialViewMode?: 'practice' | 'mistakes'
  externalViewMode?: 'practice' | 'mistakes'
  initialBootstrap?: TranslateBootstrapData
  onBackToNormalMode?: () => void
  onOpenMistakes?: (options?: { hskLevel?: number; lessonId?: string }) => void
  onViewModeChange?: (mode: 'practice' | 'mistakes') => void
  onReviewCountChange?: (count: number) => void
}

export default function TranslateTypingMode({
  initialHskLevel = 1,
  initialLessonId = '',
  initialSentenceIndex,
  initialSentenceId,
  initialViewMode = 'practice',
  externalViewMode,
  initialBootstrap,
  onViewModeChange,
  onReviewCountChange,
}: TranslateTypingModeProps) {
  const { isLoggedIn } = useAuthModal()

  // Chế độ hiển thị cục bộ: Luyện tập bài học vs Ôn câu sai của Dịch Việt -> Gõ Hán
  const [viewMode, setViewMode] = useState<'practice' | 'mistakes'>(externalViewMode || initialViewMode)

  useEffect(() => {
    if (externalViewMode) {
      setViewMode(externalViewMode)
    } else if (initialViewMode) {
      setViewMode(initialViewMode)
    }
  }, [externalViewMode, initialViewMode])

  const changeViewMode = useCallback(
    (next: 'practice' | 'mistakes') => {
      setViewMode(next)
      onViewModeChange?.(next)
    },
    [onViewModeChange]
  )

  const normalizedInitialLevel = initialHskLevel >= 1 && initialHskLevel <= 5 ? initialHskLevel : 1
  const normalizedInitialLesson = initialHskLevel >= 1 && initialHskLevel <= 5 ? initialLessonId : ''

  // 1. Bộ lọc cấp độ & Bài học (tận dụng dữ liệu SSR bootstrap nếu khớp cấu hình ban đầu)
  const [hskLevel, setHskLevel] = useState<number>(() => {
    if (initialBootstrap && !normalizedInitialLesson && initialHskLevel === 1) {
      return initialBootstrap.hskLevel
    }
    return normalizedInitialLevel
  })
  const [selectedLessonId, setSelectedLessonId] = useState<string>(() => {
    if (initialBootstrap && hskLevel === initialBootstrap.hskLevel && !normalizedInitialLesson) {
      return initialBootstrap.lessonId
    }
    return normalizedInitialLesson
  })

  const canUseInitialBootstrap = Boolean(
    initialBootstrap &&
      initialBootstrap.exercises.length > 0 &&
      hskLevel === initialBootstrap.hskLevel &&
      selectedLessonId === initialBootstrap.lessonId
  )

  const [systemLessons, setSystemLessons] = useState<
    { id: string; lessonNumber: number; title: string; subtitle: string; hskLevel: number }[]
  >(() => (initialBootstrap && hskLevel === initialBootstrap.hskLevel ? initialBootstrap.lessons : []))
  const [loadingLessons, setLoadingLessons] = useState<boolean>(false)

  // 2. Danh sách câu bài tập từ Supabase / Fallback
  const [exercises, setExercises] = useState<TranslationExerciseItem[]>(() =>
    canUseInitialBootstrap && initialBootstrap ? initialBootstrap.exercises : []
  )
  const [loadingExercises, setLoadingExercises] = useState<boolean>(() => !canUseInitialBootstrap)
  const [currentIndex, setCurrentIndex] = useState<number>(0)
  const [emptyAutoResolving, setEmptyAutoResolving] = useState<boolean>(false)

  const hasResolvedInitialDataRef = useRef<boolean>(Boolean(canUseInitialBootstrap))
  const shownBootstrapNoticeRef = useRef<boolean>(false)

  // 3. Trạng thái nhập liệu & IME
  const [userInput, setUserInput] = useState<string>('')
  const userInputRef = useRef<string>('')
  const [isComposing, setIsComposing] = useState<boolean>(false)
  const [compositionText, setCompositionText] = useState<string>('')
  const isComposingRef = useRef<boolean>(false)
  const justEndedCompositionRef = useRef<boolean>(false)
  const justEndedCompositionTimerRef = useRef<NodeJS.Timeout | null>(null)
  const inputRef = useRef<HTMLInputElement | HTMLTextAreaElement | null>(null)

  // 4. State Machine quản lý kiểm tra đáp án & chuyển câu
  const [practiceStatus, setPracticeStatus] = useState<TranslationPracticeStatus>('typing')
  const practiceStatusRef = useRef<TranslationPracticeStatus>('typing')
  const [evaluation, setEvaluation] = useState<TranslationEvaluationResult | null>(null)
  const [hintLevel, setHintLevel] = useState<number>(0) // 0: chưa gợi ý, 1: từ khóa & số chữ, 2: pinyin, 3: toàn bộ chữ Hán

  // Cờ theo dõi ghi nhận thống kê cho câu hiện tại
  const hasRecordedMistakeForCurrentRef = useRef<boolean>(false)
  const hasCountedCorrectForCurrentRef = useRef<boolean>(false)

  const updatePracticeStatus = useCallback((status: TranslationPracticeStatus) => {
    practiceStatusRef.current = status
    setPracticeStatus(status)
  }, [])

  // 5. Thống kê phiên luyện tập
  const [elapsedSeconds, setElapsedSeconds] = useState<number>(0)
  const [isTimerRunning, setIsTimerRunning] = useState<boolean>(false)
  const [correctCount, setCorrectCount] = useState<number>(0)
  const [reviewCount, setReviewCount] = useState<number>(0)

  useEffect(() => {
    onReviewCountChange?.(reviewCount)
  }, [reviewCount, onReviewCountChange])

  // Tải và đồng bộ số lượng câu sai thực tế của chế độ Dịch
  const refreshReviewCount = useCallback(async () => {
    try {
      if (isLoggedIn) {
        const res = await getTypingMistakesAction({ practiceType: 'translate' })
        if (res.success && res.mistakes) {
          setReviewCount(res.mistakes.length)
          return
        }
      }
      const localList = getLocalTypingMistakes({ practiceType: 'translate' })
      setReviewCount(localList.length)
    } catch {
      const localList = getLocalTypingMistakes({ practiceType: 'translate' })
      setReviewCount(localList.length)
    }
  }, [isLoggedIn])

  useEffect(() => {
    refreshReviewCount()
  }, [refreshReviewCount])

  // 6. Âm thanh TTS
  const [isAudioPlaying, setIsAudioPlaying] = useState<boolean>(false)
  const [speechRate, setSpeechRate] = useState<TTSSpeedRate>(1.0)
  const [showSpeedMenu, setShowSpeedMenu] = useState<boolean>(false)

  const currentExercise = exercises[currentIndex] || null
  const progressMode = 'translate_hsk'
  const exerciseStorageId = selectedLessonId ? `hsk${hskLevel}-lesson-${selectedLessonId}` : `hsk${hskLevel}-all`

  useEffect(() => {
    if (initialBootstrap?.notice && !shownBootstrapNoticeRef.current) {
      shownBootstrapNoticeRef.current = true
      toast.info(initialBootstrap.notice, { duration: 3500 })
    }
  }, [initialBootstrap])

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
    if (initialBootstrap && hskLevel === initialBootstrap.hskLevel && initialBootstrap.lessons.length > 0 && systemLessons.length > 0) {
      return
    }
    let isCancelled = false
    setLoadingLessons(true)

    getSystemLessonsForTypingAction(hskLevel)
      .then((res) => {
        if (isCancelled) return
        setLoadingLessons(false)
        if (res.success && res.data) {
          setSystemLessons(res.data)
          // Đảm bảo selectedLessonId (nếu có) thuộc cấp HSK hiện tại
          if (selectedLessonId && !res.data.some((l) => l.id === selectedLessonId)) {
            setSelectedLessonId('')
          }
        }
      })
      .catch((err) => {
        if (!isCancelled) setLoadingLessons(false)
        console.error('Lỗi tải bài học HSK:', err)
      })

    return () => {
      isCancelled = true
    }
  }, [hskLevel, initialBootstrap, selectedLessonId, systemLessons.length])

  // Reset trạng thái khi sang câu mới hoặc làm lại câu
  const resetSentenceState = useCallback(() => {
    setUserInput('')
    userInputRef.current = ''
    hasRecordedMistakeForCurrentRef.current = false
    hasCountedCorrectForCurrentRef.current = false
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
    }, 80)
  }, [updatePracticeStatus])

  // 7. Thẻ "Tiếp tục học" dành riêng cho Dịch Việt -> Gõ Hán
  const [latestTranslateProgress, setLatestTranslateProgress] = useState<TypingProgressDTO | null>(null)
  const pendingResumeTargetRef = useRef<{ id?: string; index?: number } | null>(null)

  useEffect(() => {
    let isCancelled = false

    async function loadLatestTranslateProgress() {
      try {
        let p: TypingProgressDTO | null = null
        if (isLoggedIn) {
          const res = await getLatestTypingProgressAction('translate')
          if (res.success && res.progress) {
            p = res.progress
          }
        }
        if (!p) {
          p = getLatestLocalTypingProgress('translate') as TypingProgressDTO | null
        }

        if (
          !isCancelled &&
          p &&
          p.status !== 'completed' &&
          (p.completedSentences > 0 || p.currentSentenceIndex > 0)
        ) {
          setLatestTranslateProgress(p)
        }
      } catch (err) {
        console.error('Lỗi tải tiến độ gần nhất cho Dịch Việt -> Gõ Hán:', err)
      }
    }

    loadLatestTranslateProgress()
    return () => {
      isCancelled = true
    }
  }, [isLoggedIn])

  const handleResumeTranslate = useCallback(
    (p: TypingProgressDTO) => {
      let levelChanged = false
      if (p.hskLevel && p.hskLevel !== hskLevel) {
        setHskLevel(p.hskLevel)
        levelChanged = true
      }
      let lessonChanged = false
      if (p.lessonId !== undefined && p.lessonId !== selectedLessonId) {
        setSelectedLessonId(p.lessonId || '')
        lessonChanged = true
      }

      if (!levelChanged && !lessonChanged) {
        let targetIdx = 0
        if (p.currentQuestionId) {
          const foundIdx = exercises.findIndex(
            (item) => item.id === p.currentQuestionId || item.exampleId === p.currentQuestionId
          )
          if (foundIdx !== -1) targetIdx = foundIdx
          else if (typeof p.currentSentenceIndex === 'number' && p.currentSentenceIndex < exercises.length) {
            targetIdx = p.currentSentenceIndex
          }
        } else if (typeof p.currentSentenceIndex === 'number' && p.currentSentenceIndex < exercises.length) {
          targetIdx = p.currentSentenceIndex
        }

        setCurrentIndex(targetIdx)
        resetSentenceState()
      } else {
        pendingResumeTargetRef.current = {
          id: p.currentQuestionId,
          index: p.currentSentenceIndex,
        }
      }

      setLatestTranslateProgress(null)
      toast.success('Đang khôi phục vị trí câu dịch dở...', { duration: 2500 })
      setTimeout(() => inputRef.current?.focus(), 100)
    },
    [hskLevel, selectedLessonId, exercises, resetSentenceState]
  )

  const handleRestartTranslate = useCallback(
    async (p: TypingProgressDTO) => {
      if (isLoggedIn) {
        await resetTypingProgressAction(p.mode, p.exerciseId)
      }
      resetLocalTypingProgress(p.mode, p.exerciseId)
      setLatestTranslateProgress(null)
      setCurrentIndex(0)
      setCorrectCount(0)
      setReviewCount(0)
      resetSentenceState()
      toast.info('Đã đặt lại tiến độ bài học về câu đầu tiên.')
      setTimeout(() => inputRef.current?.focus(), 100)
    },
    [isLoggedIn, resetSentenceState]
  )

  // Khôi phục vị trí câu đang học cho một danh sách câu đã nạp
  const resolveTargetSentenceIndex = useCallback(
    async (list: TranslationExerciseItem[]) => {
      let targetIndex = 0
      if (pendingResumeTargetRef.current) {
        const { id: pendingId, index: pendingIdx } = pendingResumeTargetRef.current
        pendingResumeTargetRef.current = null
        if (pendingId) {
          const foundIdx = list.findIndex(
            (item) => item.id === pendingId || item.exampleId === pendingId
          )
          if (foundIdx !== -1) targetIndex = foundIdx
          else if (typeof pendingIdx === 'number' && pendingIdx < list.length) targetIndex = pendingIdx
        } else if (typeof pendingIdx === 'number' && pendingIdx < list.length) {
          targetIndex = pendingIdx
        }
        return targetIndex
      }

      if (initialSentenceId) {
        const foundIdx = list.findIndex(
          (item) => item.id === initialSentenceId || item.exampleId === initialSentenceId
        )
        if (foundIdx !== -1) return foundIdx
      }

      if (
        typeof initialSentenceIndex === 'number' &&
        initialSentenceIndex >= 0 &&
        initialSentenceIndex < list.length
      ) {
        return initialSentenceIndex
      }

      try {
        let savedProgress: TypingProgressDTO | null = null
        if (isLoggedIn) {
          const cloudRes = await getTypingProgressAction(progressMode, exerciseStorageId)
          if (cloudRes.success && cloudRes.progress) {
            savedProgress = cloudRes.progress
          }
        }
        if (!savedProgress) {
          savedProgress = getLocalTypingProgress(progressMode, exerciseStorageId) as TypingProgressDTO | null
        }

        if (savedProgress && savedProgress.status !== 'completed') {
          if (savedProgress.currentQuestionId) {
            const matchById = list.findIndex(
              (it) => it.id === savedProgress!.currentQuestionId || it.exampleId === savedProgress!.currentQuestionId
            )
            if (matchById !== -1) targetIndex = matchById
          }
          if (
            targetIndex === 0 &&
            typeof savedProgress.currentSentenceIndex === 'number' &&
            savedProgress.currentSentenceIndex > 0 &&
            savedProgress.currentSentenceIndex < list.length
          ) {
            targetIndex = savedProgress.currentSentenceIndex
          }
          if (targetIndex > 0) {
            if (savedProgress.correctSentences) setCorrectCount(savedProgress.correctSentences)
            if (savedProgress.errorSentences) setReviewCount(savedProgress.errorSentences)
            toast.info(`Khôi phục tiếp tục câu ${targetIndex + 1}/${list.length}`, { duration: 2500 })
          }
        }
      } catch (err) {
        console.error('Lỗi khôi phục tiến độ câu dịch:', err)
      }
      return targetIndex
    },
    [exerciseStorageId, initialSentenceId, initialSentenceIndex, isLoggedIn, progressMode]
  )

  // Chuyển sang bài gần nhất hoặc tổng hợp cấp HSK có sẵn dữ liệu (CTA cho Empty State)
  const handleSwitchToNearestAvailable = useCallback(async () => {
    setEmptyAutoResolving(true)
    try {
      // 1. Thử các bài học khác trong cùng cấp HSK hiện tại
      for (const lesson of systemLessons) {
        if (lesson.id === selectedLessonId) continue
        const res = await getTranslationExercisesAction({ hskLevel, lessonId: lesson.id, limit: 60 })
        if (res.success && res.data && res.data.length > 0) {
          setSelectedLessonId(lesson.id)
          toast.success(`Đã chuyển sang "${lesson.title}" (${res.data.length} câu ví dụ).`)
          return
        }
      }
      // 2. Fallback sang tổng hợp cấp HSK hiện tại hoặc các cấp HSK khác có sẵn dữ liệu
      for (const candLevel of [hskLevel, 1, 2, 3, 4, 5].filter((v, i, a) => a.indexOf(v) === i)) {
        const res = await getTranslationExercisesAction({ hskLevel: candLevel, limit: 60 })
        if (res.success && res.data && res.data.length > 0) {
          setHskLevel(candLevel)
          setSelectedLessonId('')
          toast.success(`Đã chuyển sang tổng hợp HSK ${candLevel} (${res.data.length} câu ví dụ).`)
          return
        }
      }
    } finally {
      setEmptyAutoResolving(false)
    }
  }, [hskLevel, selectedLessonId, systemLessons])

  // Tải danh sách câu ví dụ từ Supabase (dùng SSR bootstrap nếu khớp và tự fallback khi khởi tạo trống)
  useEffect(() => {
    let isCancelled = false

    const useBootstrapNow =
      initialBootstrap &&
      initialBootstrap.exercises.length > 0 &&
      hskLevel === initialBootstrap.hskLevel &&
      selectedLessonId === initialBootstrap.lessonId

    if (useBootstrapNow && initialBootstrap) {
      setExercises(initialBootstrap.exercises)
      setLoadingExercises(false)
      hasResolvedInitialDataRef.current = true
      resolveTargetSentenceIndex(initialBootstrap.exercises).then((idx) => {
        if (!isCancelled) {
          setCurrentIndex(idx)
        }
      })
      return () => {
        isCancelled = true
      }
    }

    setLoadingExercises(true)
    resetSentenceState()

    getTranslationExercisesAction({
      hskLevel,
      lessonId: selectedLessonId || undefined,
      limit: 60,
    })
      .then(async (res) => {
        if (isCancelled) return
        if (res.success && res.data && res.data.length > 0) {
          hasResolvedInitialDataRef.current = true
          const list = res.data
          setExercises(list)
          const targetIndex = await resolveTargetSentenceIndex(list)
          if (!isCancelled) {
            setCurrentIndex(targetIndex)
            setLoadingExercises(false)
          }
          return
        }

        // Fallback tự động CHỈ KHI mới vào trang mà bộ lọc mặc định trả về rỗng
        if (!hasResolvedInitialDataRef.current) {
          if (selectedLessonId) {
            setSelectedLessonId('')
            return
          }
          for (const candLevel of [1, 2, 3, 4, 5]) {
            if (candLevel === hskLevel) continue
            const candRes = await getTranslationExercisesAction({ hskLevel: candLevel, limit: 60 })
            if (isCancelled) return
            if (candRes.success && candRes.data && candRes.data.length > 0) {
              hasResolvedInitialDataRef.current = true
              setHskLevel(candLevel)
              setSelectedLessonId('')
              setExercises(candRes.data)
              setCurrentIndex(0)
              setLoadingExercises(false)
              toast.info(`Đã tự động chọn HSK ${candLevel} có sẵn câu ví dụ.`)
              return
            }
          }
        }

        hasResolvedInitialDataRef.current = true
        setExercises([])
        setCurrentIndex(0)
        setLoadingExercises(false)
      })
      .catch((err) => {
        if (!isCancelled) {
          setLoadingExercises(false)
          setExercises([])
          setCurrentIndex(0)
        }
        console.error('Lỗi tải câu dịch từ Supabase:', err)
      })

    return () => {
      isCancelled = true
    }
  }, [
    hskLevel,
    selectedLessonId,
    initialBootstrap,
    resetSentenceState,
    resolveTargetSentenceIndex,
  ])

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
      playTypingSfx('correct', 0.04)
    }
  }, [hintLevel])

  // Xử lý khi người dùng nhập liệu hoặc chỉnh sửa
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value
    if (!isTimerRunning && val.length > 0) {
      setIsTimerRunning(true)
    }
    userInputRef.current = val
    setUserInput(val)

    // Khi người dùng chỉnh sửa đáp án:
    // Nếu trước đó đang 'correct' mà sửa -> hủy correct, trở về 'typing' để gõ và kiểm tra lại
    if (practiceStatusRef.current === 'correct') {
      if (hasCountedCorrectForCurrentRef.current) {
        hasCountedCorrectForCurrentRef.current = false
        setCorrectCount((prev) => Math.max(0, prev - 1))
      }
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
    const val = e.currentTarget.value
    userInputRef.current = val
    setUserInput(val)

    // Đặt lại trạng thái typing nếu người dùng vừa chọn chữ qua IME khi đang ở trạng thái correct
    if (practiceStatusRef.current === 'correct') {
      if (hasCountedCorrectForCurrentRef.current) {
        hasCountedCorrectForCurrentRef.current = false
        setCorrectCount((prev) => Math.max(0, prev - 1))
      }
      updatePracticeStatus('typing')
      setEvaluation(null)
    }

    // Đặt cờ vừa kết thúc composition trong 120ms để chặn phím Enter xác nhận IME
    justEndedCompositionRef.current = true
    if (justEndedCompositionTimerRef.current) {
      clearTimeout(justEndedCompositionTimerRef.current)
    }
    justEndedCompositionTimerRef.current = setTimeout(() => {
      justEndedCompositionRef.current = false
    }, 120)
  }

  // Kiểm tra đáp án câu dịch
  const handleCheckAnswer = useCallback(async () => {
    if (!currentExercise) return
    const currentStatus = practiceStatusRef.current
    // Chỉ kiểm tra khi đang typing hoặc khi đang incorrect cần kiểm tra lại
    if (currentStatus !== 'typing' && currentStatus !== 'incorrect') return

    // Lấy giá trị mới nhất từ input DOM hoặc ref để loại bỏ hoàn toàn stale state
    const rawVal = inputRef.current ? inputRef.current.value : userInputRef.current
    const val = (rawVal ?? '').trim()
    if (!val) return

    updatePracticeStatus('checking')
    setIsTimerRunning(false)
    ttsEngine.stop()
    setIsAudioPlaying(false)

    const evalResult = evaluateTranslationInput(val, currentExercise.chineseAnswer)
    setEvaluation(evalResult)

    // Xóa bản nháp câu này sau khi đã kiểm tra
    clearLocalTypingDraft(progressMode, `${exerciseStorageId}-${currentExercise.id}`)

    const isMatch = evalResult.isExactMatch
    if (isMatch) {
      updatePracticeStatus('correct')
      if (!hasCountedCorrectForCurrentRef.current) {
        hasCountedCorrectForCurrentRef.current = true
        setCorrectCount((prev) => prev + 1)
      }
      playTypingSfx('complete', 0.08)
    } else {
      updatePracticeStatus('incorrect')
      if (!hasRecordedMistakeForCurrentRef.current) {
        hasRecordedMistakeForCurrentRef.current = true
        setReviewCount((prev) => prev + 1)
      }
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
        mode: 'translate_vi_to_han',
        practiceType: 'translate' as const,
        exerciseId: exerciseStorageId,
        sentenceIndex: currentIndex,
        sentenceZh: currentExercise.chineseAnswer,
        pinyin: currentExercise.pinyinAnswer,
        meaningVi: currentExercise.vietnamesePrompt,
        lastInputZh: val,
        mistakeDetails,
      }

      recordLocalTypingMistake(mistakePayload)
      if (isLoggedIn) {
        recordTypingMistakeAction(mistakePayload).catch(() => {})
      }
    }

    const friendlyLessonLabel = selectedLessonId
      ? currentExercise.lessonTitle || `HSK ${hskLevel}`
      : `HSK ${hskLevel} - Tất cả bài học`

    // Cập nhật tiến độ học tập lên Supabase & Local
    const progressPayload: TypingProgressDTO = {
      mode: progressMode,
      exerciseId: exerciseStorageId,
      currentSentenceIndex: currentIndex,
      completedSentences: isMatch ? currentIndex + 1 : currentIndex,
      totalSentences: exercises.length,
      correctSentences: correctCount + (isMatch && !hasCountedCorrectForCurrentRef.current ? 1 : 0),
      errorSentences: reviewCount + (!isMatch && !hasRecordedMistakeForCurrentRef.current ? 1 : 0),
      lastTypedLength: val.length,
      timeSpentSeconds: Math.max(elapsedSeconds, 1),
      status: currentIndex >= exercises.length - 1 && isMatch ? 'completed' : 'in_progress',
      updatedAt: new Date().toISOString(),
      hskLevel,
      lessonId: selectedLessonId || undefined,
      lessonTitle: friendlyLessonLabel,
      currentQuestionId: currentExercise.id,
      currentQuestionText: currentExercise.vietnamesePrompt,
      practiceMode: 'translate',
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
    exerciseStorageId,
    progressMode,
    currentIndex,
    exercises.length,
    correctCount,
    reviewCount,
    elapsedSeconds,
    isLoggedIn,
    hskLevel,
    selectedLessonId,
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

    const friendlyLessonLabel = selectedLessonId
      ? currentExercise?.lessonTitle || `HSK ${hskLevel}`
      : `HSK ${hskLevel} - Tất cả bài học`

    // Nếu người dùng bấm "Câu tiếp theo" để bỏ qua khi chưa đúng (đang typing hoặc sai):
    // Cập nhật vị trí lưu tiến độ mà KHÔNG ghi nhận câu đúng
    if (currentExercise && !isCurrentlyCorrect) {
      const skipNextIdx = currentIndex + 1 < exercises.length ? currentIndex + 1 : currentIndex
      const skipNextEx = exercises[skipNextIdx]
      const skipProgressPayload: TypingProgressDTO = {
        mode: progressMode,
        exerciseId: exerciseStorageId,
        currentSentenceIndex: skipNextIdx,
        completedSentences: currentIndex,
        totalSentences: exercises.length,
        correctSentences: correctCount,
        errorSentences: reviewCount,
        lastTypedLength: userInputRef.current.length,
        timeSpentSeconds: Math.max(elapsedSeconds, 1),
        status: currentIndex >= exercises.length - 1 ? 'completed' : 'in_progress',
        updatedAt: new Date().toISOString(),
        hskLevel,
        lessonId: selectedLessonId || undefined,
        lessonTitle: friendlyLessonLabel,
        currentQuestionId: skipNextEx?.id || currentExercise.id,
        currentQuestionText: skipNextEx?.vietnamesePrompt || currentExercise.vietnamesePrompt,
        practiceMode: 'translate',
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

    // Chuyển câu bình thường và cập nhật vị trí câu mới vào tiến độ
    const nextIdx = currentIndex + 1
    setCurrentIndex(nextIdx)
    resetSentenceState()

    const nextExercise = exercises[nextIdx]
    if (nextExercise) {
      const nextProgressPayload: TypingProgressDTO = {
        mode: progressMode,
        exerciseId: exerciseStorageId,
        currentSentenceIndex: nextIdx,
        completedSentences: isCurrentlyCorrect ? nextIdx : currentIndex,
        totalSentences: exercises.length,
        correctSentences: correctCount,
        errorSentences: reviewCount,
        lastTypedLength: 0,
        timeSpentSeconds: Math.max(elapsedSeconds, 1),
        status: 'in_progress',
        updatedAt: new Date().toISOString(),
        hskLevel,
        lessonId: selectedLessonId || undefined,
        lessonTitle: selectedLessonId
          ? nextExercise.lessonTitle || `HSK ${hskLevel}`
          : `HSK ${hskLevel} - Tất cả bài học`,
        currentQuestionId: nextExercise.id,
        currentQuestionText: nextExercise.vietnamesePrompt,
        practiceMode: 'translate',
      }
      saveLocalTypingProgress(nextProgressPayload as any)
      if (isLoggedIn) {
        saveTypingProgressAction(nextProgressPayload).catch(() => {})
      }
    }
  }, [
    currentExercise,
    currentIndex,
    exercises,
    progressMode,
    exerciseStorageId,
    correctCount,
    reviewCount,
    elapsedSeconds,
    isLoggedIn,
    hskLevel,
    selectedLessonId,
    resetSentenceState,
    updatePracticeStatus,
  ])

  // Xử lý phím Enter:
  // - Khi typing hoặc incorrect: kiểm tra đáp án (không tự động chuyển câu)
  // - Khi correct: nhấn Enter lần tiếp theo mới chuyển sang câu tiếp theo
  // - Chặn triệt để IME composition và các phím Enter dùng để chọn chữ Hán
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
      e.key === 'Process' ||
      justEndedCompositionRef.current
    ) {
      // Tiêu thụ ngay cờ justEndedComposition khi gặp phím Enter xác nhận IME
      if (justEndedCompositionRef.current && e.key === 'Enter') {
        justEndedCompositionRef.current = false
        if (justEndedCompositionTimerRef.current) {
          clearTimeout(justEndedCompositionTimerRef.current)
          justEndedCompositionTimerRef.current = null
        }
      }
      return
    }

    if (e.key === 'Tab' && !e.shiftKey && !e.altKey && !e.ctrlKey && !e.metaKey) {
      e.preventDefault()
      handlePlayAudio()
      return
    }

    if (e.key === 'Enter') {
      e.preventDefault()
      const currentStatus = practiceStatusRef.current

      // A. Nếu đang typing HOẶC đang incorrect: kiểm tra đáp án nếu có nội dung
      if (currentStatus === 'typing' || currentStatus === 'incorrect') {
        const textToCheck = (inputRef.current ? inputRef.current.value : userInputRef.current).trim()
        if (textToCheck.length > 0) {
          handleCheckAnswer()
        }
        return
      }

      // B. Nếu đã correct: Chuyển sang câu tiếp theo
      if (currentStatus === 'correct') {
        handleNextSentence()
        return
      }

      // C. Nếu đang checking hoặc transitioning: bỏ qua tránh race condition
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
        e.key === 'Process' ||
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

  // Luyện lại câu hiện tại (xóa đáp án và bắt đầu lại câu này)
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

  // Nếu đang ở trạng thái Ôn câu sai: Hiển thị giao diện ôn tập tích hợp ngay trong chế độ Dịch
  if (viewMode === 'mistakes') {
    return (
      <div className="space-y-4 pb-12 md:pb-6 w-full select-text animate-in fade-in duration-200">
        <TypingMistakesReview
          isLoggedIn={isLoggedIn}
          practiceType="translate"
          initialHskLevel={hskLevel}
          initialLessonId={selectedLessonId}
          onBackToPractice={() => {
            changeViewMode('practice')
            refreshReviewCount()
          }}
        />
      </div>
    )
  }

  const targetCharCount = currentExercise ? Array.from(currentExercise.chineseAnswer.trim()).length : 0

  return (
    <div className="w-full pb-10 md:pb-4 select-text">
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
        {/* CỘT TRÁI (8/12): KHU VỰC HỌC CHÍNH (Dịch Việt -> Gõ Hán) */}
        <div className="lg:col-span-8 min-w-0 space-y-3.5">
          {/* Slim Banner "Tiếp tục học" 1 dòng gọn gàng phía trên card làm bài */}
          {latestTranslateProgress && (
            <TypingResumeCard
              progress={latestTranslateProgress}
              onResume={handleResumeTranslate}
              onRestart={handleRestartTranslate}
              onDismiss={() => setLatestTranslateProgress(null)}
            />
          )}

          {/* Khung nội dung trung tâm (nổi bật nhất trang với viền stone-900 đồng bộ Navbar) */}
          {loadingExercises ? (
        <div className="w-full p-10 text-center bg-white dark:bg-[#182238] border-2 border-[#182238]/20 rounded-3xl space-y-3 shadow-xs">
          <Loader2 className="w-8 h-8 text-[#B8322D] animate-spin mx-auto" />
          <h3 className="text-base font-serif font-semibold text-title">Đang tải câu ví dụ HSK {hskLevel}...</h3>
          <p className="text-xs text-muted font-serif">Đang chuẩn bị không gian luyện dịch Việt → Hán</p>
        </div>
      ) : !currentExercise ? (
        <div className="w-full p-8 sm:p-10 text-center bg-[#FAF7F2] dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl space-y-4 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322]">
          <div className="w-12 h-12 rounded-2xl bg-white dark:bg-[#202B45] border border-stone-300 flex items-center justify-center mx-auto">
            <BookOpen className="w-6 h-6 text-[#B8322D]" />
          </div>
          <div className="space-y-1.5">
            <h3 className="text-base sm:text-lg font-serif font-bold text-stone-900 dark:text-white">
              Chưa có câu ví dụ cho bài học này
            </h3>
            <p className="text-xs sm:text-sm text-muted font-serif max-w-md mx-auto">
              Bài học bạn vừa chọn chưa được gắn câu ví dụ song ngữ. Hãy chuyển ngay sang chế độ luyện tổng hợp hoặc bài gần nhất có sẵn.
            </p>
          </div>
          <div className="flex flex-col sm:flex-row items-center justify-center gap-2.5 pt-1">
            {selectedLessonId && (
              <button
                type="button"
                onClick={() => setSelectedLessonId('')}
                className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl bg-[#B8322D] hover:bg-[#982923] text-white text-xs sm:text-sm font-serif font-bold shadow-xs transition-all cursor-pointer min-h-[44px]"
              >
                <span>Luyện tổng hợp HSK {hskLevel}</span>
                <ArrowRight className="w-4 h-4" />
              </button>
            )}
            <button
              type="button"
              onClick={handleSwitchToNearestAvailable}
              disabled={emptyAutoResolving}
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl bg-white dark:bg-[#202B45] border border-stone-300 dark:border-white/20 text-stone-900 dark:text-white hover:bg-stone-50 text-xs sm:text-sm font-serif font-bold transition-all cursor-pointer min-h-[44px] disabled:opacity-60"
            >
              {emptyAutoResolving ? (
                <Loader2 className="w-4 h-4 animate-spin" />
              ) : (
                <ArrowRight className="w-4 h-4 text-[#0D9488]" />
              )}
              <span>Chuyển sang bài gần nhất có sẵn</span>
            </button>
          </div>
        </div>
      ) : (
        <div className="w-full">
          {/* Core Practice Card — Duy nhất khối này giữ viền đậm & đổ bóng tactile đồng bộ Navbar */}
          <div className="bg-[#FAF7F2] dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl p-5 sm:p-6 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322] space-y-4">
            {/* Tầng 1: Ngữ cảnh bài học + Nghe phát âm + Gợi ý */}
            <div className="flex items-center justify-between gap-2 flex-wrap pb-3 border-b border-[#182238]/10 dark:border-white/10">
              <div className="flex items-center gap-2 flex-wrap">
                <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-[#FAF7F2] dark:bg-[#202B45] border border-[#182238]/15 dark:border-white/15 text-[11px] font-serif font-bold text-[#182238] dark:text-slate-200">
                  <span className="w-1.5 h-1.5 rounded-full bg-[#B8322D]" />
                  <span>{currentExercise.lessonTitle || `HSK ${hskLevel}`}</span>
                </span>
                <span className="text-[11px] font-sans text-muted font-medium px-2 py-0.5 rounded-full bg-page border border-border/70">
                  {targetCharCount} ký tự
                </span>
              </div>

              {/* Cụm Nghe phát âm (không lộ chữ Hán) & Gợi ý ngay bên cạnh */}
              <div className="flex items-center gap-1.5 sm:gap-2">
                <button
                  type="button"
                  onClick={handlePlayAudio}
                  className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all cursor-pointer touch-manipulation min-h-[36px] border ${
                    isAudioPlaying
                      ? 'bg-[#B8322D] text-white border-[#182238] shadow-[0_2px_0_#7A1D1A]'
                      : 'bg-[#FFF9F3] dark:bg-[#202B45] text-[#182238] dark:text-white border-[#182238]/25 hover:border-[#182238]'
                  }`}
                  title="Nghe phát âm tiếng Trung không lộ chữ Hán (hoặc nhấn Tab)"
                >
                  <Volume2 className={`w-3.5 h-3.5 shrink-0 ${isAudioPlaying ? 'animate-pulse text-white' : 'text-[#B8322D]'}`} />
                  <span>{isAudioPlaying ? 'Đang phát' : 'Nghe phát âm'}</span>
                </button>

                {/* Tốc độ đọc */}
                <div className="relative">
                  <button
                    type="button"
                    onClick={() => setShowSpeedMenu((prev) => !prev)}
                    className="inline-flex items-center gap-1 px-2.5 py-1.5 bg-[#FAF7F2] dark:bg-[#202B45] border border-[#182238]/20 dark:border-white/15 hover:border-[#182238] rounded-xl text-xs font-mono font-bold text-[#182238] dark:text-white transition-all touch-manipulation min-h-[36px] cursor-pointer"
                    title="Điều chỉnh tốc độ đọc"
                  >
                    <span>{speechRate}x</span>
                    <ChevronDown className="w-3 h-3 text-muted" />
                  </button>

                  {showSpeedMenu && (
                    <div className="absolute right-0 top-full mt-1 bg-white dark:bg-[#182238] border-2 border-[#182238] rounded-xl shadow-[0_4px_0_#182238] p-1 z-30 flex flex-col gap-0.5 min-w-[76px]">
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
                              ? 'bg-[#B8322D] text-white font-bold'
                              : 'text-title hover:bg-page'
                          }`}
                        >
                          {rate}x
                        </button>
                      ))}
                    </div>
                  )}
                </div>

                {/* Nút Gợi ý thông minh */}
                <button
                  type="button"
                  onClick={handleNextHint}
                  disabled={hintLevel >= 3}
                  className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-serif font-bold transition-all touch-manipulation min-h-[36px] cursor-pointer border ${
                    hintLevel >= 3
                      ? 'bg-page border-border text-muted/60 cursor-not-allowed'
                      : hintLevel > 0
                      ? 'bg-amber-500/15 border-amber-500/40 text-amber-800 dark:text-amber-300'
                      : 'bg-[#FFF9F3] dark:bg-[#202B45] border-[#182238]/25 hover:border-amber-500 text-[#182238] dark:text-white'
                  }`}
                  title="Xem gợi ý từ vựng, Pinyin hoặc đáp án mẫu"
                >
                  <Lightbulb className="w-3.5 h-3.5 text-amber-500 shrink-0" />
                  <span>{hintLevel === 0 ? 'Gợi ý' : `Gợi ý ${hintLevel}/3`}</span>
                </button>
              </div>
            </div>

            {/* Tầng 2: Câu tiếng Việt trung tâm — cỡ chữ lớn, dễ đọc, thoáng mắt */}
            <div className="py-2 sm:py-3 text-center space-y-1.5">
              <p className="text-[11px] font-sans uppercase tracking-wider text-muted font-semibold select-none">
                Dịch câu tiếng Việt sang chữ Hán
              </p>
              <h2 className="text-2xl sm:text-[1.75rem] md:text-3xl font-serif font-bold text-[#182238] dark:text-white leading-snug tracking-tight select-text">
                {currentExercise.vietnamesePrompt}
              </h2>
            </div>

            {/* Gợi ý từng cấp (chỉ hiển thị gọn khi người dùng nhấn nút Gợi ý) */}
            {hintLevel > 0 && (
              <div className="bg-amber-50/85 dark:bg-amber-950/25 border border-amber-300/70 dark:border-amber-800/50 rounded-2xl p-3 space-y-1.5 text-xs sm:text-sm font-serif animate-in fade-in duration-150">
                <div className="flex flex-wrap items-baseline gap-x-2 gap-y-1">
                  <span className="font-bold text-amber-800 dark:text-amber-300 shrink-0">Từ trọng tâm:</span>
                  <span
                    className="font-bold text-base text-[#B8322D]"
                    style={{ fontFamily: 'var(--font-chinese), "Noto Sans SC", "PingFang SC", sans-serif' }}
                  >
                    {currentExercise.wordHanzi}
                  </span>
                  <span className="text-muted font-sans text-xs">[{currentExercise.wordPinyin}]</span>
                  <span className="text-body text-xs">— {currentExercise.wordMeaning}</span>
                </div>

                {hintLevel >= 2 && currentExercise.pinyinAnswer && (
                  <div className="flex flex-wrap items-baseline gap-2 pt-1 border-t border-amber-200/60">
                    <span className="font-bold text-amber-800 dark:text-amber-300 shrink-0">Pinyin:</span>
                    <span className="font-sans text-title font-medium tracking-wide">
                      {currentExercise.pinyinAnswer}
                    </span>
                  </div>
                )}

                {hintLevel >= 3 && (
                  <div className="flex flex-wrap items-baseline gap-2 pt-1 border-t border-amber-200/60">
                    <span className="font-bold text-amber-800 dark:text-amber-300 shrink-0">Chữ Hán mẫu:</span>
                    <span
                      className="text-base font-bold text-[#182238] dark:text-white"
                      style={{ fontFamily: 'var(--font-chinese), "Noto Sans SC", "PingFang SC", sans-serif' }}
                    >
                      {currentExercise.chineseAnswer}
                    </span>
                  </div>
                )}
              </div>
            )}

            {/* Tầng 3: Ô nhập chữ Hán lớn, font SC chuẩn + xử lý chuẩn IME composition */}
            <div className="space-y-2.5">
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
                  readOnly={practiceStatus === 'checking' || practiceStatus === 'transitioning'}
                  autoComplete="off"
                  autoCorrect="off"
                  autoCapitalize="off"
                  spellCheck="false"
                  aria-label="Nhập câu chữ Hán bằng bộ gõ Pinyin IME"
                  placeholder={
                    practiceStatus === 'correct'
                      ? 'Chính xác! Nhấn Enter để chuyển sang câu tiếp theo...'
                      : practiceStatus === 'incorrect'
                      ? 'Chỉnh sửa lại rồi nhấn Enter để kiểm tra...'
                      : 'Gõ Pinyin (nhờ bộ gõ tiếng Trung IME) rồi chọn chữ Hán...'
                  }
                  className={`w-full px-4 sm:px-5 py-3.5 sm:py-4 bg-[#FAF9F6] dark:bg-card border-[1.5px] rounded-2xl text-xl sm:text-2xl text-[#182238] dark:text-white placeholder:text-muted/65 placeholder:text-sm sm:placeholder:text-base placeholder:font-serif focus:outline-none transition-all ${
                    practiceStatus === 'correct'
                      ? 'border-emerald-500 bg-emerald-50/25 ring-2 ring-emerald-500/20'
                      : practiceStatus === 'incorrect'
                      ? 'border-amber-500 bg-amber-50/20 ring-2 ring-amber-500/20'
                      : 'border-[#CBD5E1] dark:border-[#384869] focus:bg-white focus:border-[#0D9488] focus:ring-2 focus:ring-[#0D9488]/20'
                  }`}
                  style={{ fontFamily: 'var(--font-chinese), "Noto Sans SC", "PingFang SC", "Microsoft YaHei", sans-serif' }}
                />

                {isComposing && (
                  <div className="absolute right-3 top-1/2 -translate-y-1/2 px-2.5 py-1 bg-amber-500/15 border border-amber-400/40 text-amber-800 dark:text-amber-300 rounded-lg text-xs font-sans flex items-center gap-1.5 animate-pulse select-none pointer-events-none">
                    <span className="w-2 h-2 rounded-full bg-amber-500" />
                    <span>Đang gõ Pinyin ({compositionText || '...'})</span>
                  </div>
                )}

                {practiceStatus !== 'checking' &&
                  practiceStatus !== 'transitioning' &&
                  userInput.length > 0 &&
                  !isComposing && (
                    <button
                      type="button"
                      onClick={() => {
                        setUserInput('')
                        userInputRef.current = ''
                        if (practiceStatus === 'incorrect') {
                          updatePracticeStatus('typing')
                          setEvaluation(null)
                        } else if (practiceStatus === 'correct') {
                          if (hasCountedCorrectForCurrentRef.current) {
                            hasCountedCorrectForCurrentRef.current = false
                            setCorrectCount((prev) => Math.max(0, prev - 1))
                          }
                          updatePracticeStatus('typing')
                          setEvaluation(null)
                        }
                        inputRef.current?.focus()
                      }}
                      className="absolute right-3 top-1/2 -translate-y-1/2 p-1.5 rounded-full text-muted hover:text-title hover:bg-page transition-colors cursor-pointer"
                      title="Xóa nội dung đã gõ"
                    >
                      <X className="w-4 h-4" />
                    </button>
                  )}
              </div>

              {/* Tầng 4: Thanh trạng thái phím tắt gọn nhẹ ngay bên dưới ô nhập */}
              <div className="flex items-center justify-between gap-2 px-1 text-[11px] sm:text-xs font-serif text-muted flex-wrap">
                <span>
                  Đã gõ: <strong className="text-title font-sans">{Array.from(userInput).length}</strong> / {targetCharCount} chữ
                </span>
                <div className="flex items-center gap-2.5 flex-wrap">
                  <span className="inline-flex items-center gap-1">
                    <kbd className="px-1.5 py-0.5 rounded bg-page border border-border font-mono text-[10px] font-bold text-title">
                      Enter
                    </kbd>
                    <span className={practiceStatus === 'correct' ? 'text-emerald-700 dark:text-emerald-400 font-bold' : ''}>
                      {practiceStatus === 'correct' ? 'Qua câu tiếp' : 'Kiểm tra'}
                    </span>
                  </span>
                  <span className="inline-flex items-center gap-1">
                    <kbd className="px-1.5 py-0.5 rounded bg-page border border-border font-mono text-[10px] font-bold text-title">
                      Tab
                    </kbd>
                    <span>Nghe lại</span>
                  </span>
                </div>
              </div>
            </div>

            {/* Tầng 5: Kết quả đối chiếu từng ký tự (Character-level diff) sau khi kiểm tra */}
            {(practiceStatus === 'correct' || practiceStatus === 'incorrect') && evaluation && (
              <div
                className={`p-3.5 sm:p-4 rounded-2xl border-2 space-y-3 animate-in fade-in duration-200 ${
                  evaluation.isExactMatch
                    ? 'bg-emerald-500/8 border-emerald-500/35'
                    : 'bg-amber-500/8 border-amber-500/35'
                }`}
              >
                <div className="flex items-center justify-between gap-2 flex-wrap">
                  <div className="flex items-center gap-2">
                    {evaluation.isExactMatch ? (
                      <CheckCircle2 className="w-5 h-5 text-emerald-600 dark:text-emerald-400 shrink-0" />
                    ) : (
                      <AlertCircle className="w-5 h-5 text-amber-600 dark:text-amber-400 shrink-0" />
                    )}
                    <span
                      className={`text-sm sm:text-base font-serif font-bold ${
                        evaluation.isExactMatch
                          ? 'text-emerald-800 dark:text-emerald-300'
                          : 'text-amber-800 dark:text-amber-300'
                      }`}
                    >
                      {evaluation.isExactMatch ? 'Trùng khớp câu mẫu!' : 'Khác câu mẫu — đối chiếu ký tự bên dưới'}
                    </span>
                  </div>

                  <span className="text-[11px] font-sans font-semibold px-2 py-0.5 rounded-full bg-white/80 dark:bg-card border border-border text-title">
                    Khớp {evaluation.matchPercentage}%
                  </span>
                </div>

                {/* Đối chiếu từng ký tự trực quan */}
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 bg-white/85 dark:bg-card border border-border/80 rounded-xl p-3">
                  <div className="space-y-1">
                    <p className="text-[11px] text-muted font-serif font-semibold">Bạn đã gõ:</p>
                    <div
                      className="text-lg sm:text-xl leading-relaxed flex flex-wrap gap-1 items-baseline"
                      style={{ fontFamily: 'var(--font-chinese), "Noto Sans SC", "PingFang SC", sans-serif' }}
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
                        if (token.type === 'diff') {
                          return (
                            <span
                              key={i}
                              title={`Đáp án mẫu: ${token.expectedChar}`}
                              className="bg-red-500/15 text-red-600 dark:text-red-400 font-bold px-1 rounded underline decoration-red-500"
                            >
                              {token.userInputChar}
                            </span>
                          )
                        }
                        if (token.type === 'extra') {
                          return (
                            <span
                              key={i}
                              title="Ký tự dư"
                              className="bg-red-500/15 text-red-600 dark:text-red-400 font-bold px-1 rounded line-through"
                            >
                              {token.userInputChar}
                            </span>
                          )
                        }
                        return (
                          <span
                            key={i}
                            title={`Còn thiếu: ${token.expectedChar}`}
                            className="px-1.5 rounded border border-dashed border-amber-500/60 text-amber-700 dark:text-amber-300 text-xs font-mono"
                          >
                            _{token.expectedChar}_
                          </span>
                        )
                      })}
                    </div>
                  </div>

                  <div className="space-y-1 sm:border-l sm:border-border/60 sm:pl-3">
                    <p className="text-[11px] text-muted font-serif font-semibold">Đáp án chuẩn &amp; Pinyin:</p>
                    <div
                      className="text-lg sm:text-xl font-bold text-[#182238] dark:text-white leading-snug"
                      style={{ fontFamily: 'var(--font-chinese), "Noto Sans SC", "PingFang SC", sans-serif' }}
                    >
                      {currentExercise.chineseAnswer}
                    </div>
                    {currentExercise.pinyinAnswer && (
                      <p className="text-xs font-sans text-[#C84B31] dark:text-orange-400 font-medium">
                        {currentExercise.pinyinAnswer}
                      </p>
                    )}
                    <p className="text-[11px] font-serif italic text-muted">
                      {currentExercise.vietnamesePrompt}
                    </p>
                  </div>
                </div>
              </div>
            )}

            {/* Tầng 6: Thanh thao tác chính (Mobile 2x2 rõ ràng / Desktop 1 hàng thoáng) */}
            <div className="pt-1 border-t border-[#182238]/10 dark:border-white/10">
              <div className="grid grid-cols-2 sm:flex sm:items-center sm:justify-between gap-2">
                <button
                  type="button"
                  onClick={handlePrevSentence}
                  disabled={currentIndex === 0 || practiceStatus === 'checking' || practiceStatus === 'transitioning'}
                  className="inline-flex items-center justify-center gap-1.5 px-3 py-2 rounded-xl border border-[#182238]/15 dark:border-white/15 bg-[#FAF7F2] dark:bg-[#202B45] text-xs sm:text-sm font-serif text-[#182238] dark:text-slate-200 hover:border-[#182238] disabled:opacity-35 disabled:cursor-not-allowed transition-all min-h-[44px] cursor-pointer"
                >
                  <ArrowLeft className="w-4 h-4 shrink-0" />
                  <span>Câu trước</span>
                </button>

                <button
                  type="button"
                  onClick={handleRetryCurrent}
                  className="inline-flex items-center justify-center gap-1.5 px-3 py-2 rounded-xl border border-[#182238]/15 dark:border-white/15 bg-[#FAF7F2] dark:bg-[#202B45] text-xs sm:text-sm font-serif text-[#182238] dark:text-slate-200 hover:border-[#182238] transition-all min-h-[44px] cursor-pointer sm:ml-auto"
                  title="Xóa và gõ lại câu này"
                >
                  <RotateCcw className="w-4 h-4 shrink-0" />
                  <span>Làm lại</span>
                </button>

                {practiceStatus !== 'correct' ? (
                  <button
                    type="button"
                    onClick={handleCheckAnswer}
                    disabled={userInput.trim().length === 0 || practiceStatus === 'checking'}
                    className="inline-flex items-center justify-center gap-1.5 px-4 sm:px-5 py-2 bg-[#B8322D] hover:bg-[#982923] disabled:opacity-40 disabled:cursor-not-allowed text-white rounded-xl text-xs sm:text-sm font-serif font-bold shadow-[0_2px_0_#7A1D1A] transition-all active:translate-y-0.5 active:shadow-none min-h-[44px] cursor-pointer"
                    title="Kiểm tra đáp án (hoặc nhấn phím Enter)"
                  >
                    <CheckCircle2 className="w-4 h-4 shrink-0" />
                    <span>{practiceStatus === 'incorrect' ? 'Kiểm tra lại' : 'Kiểm tra'}</span>
                  </button>
                ) : (
                  <div className="inline-flex items-center justify-center gap-1.5 px-3.5 py-2 rounded-xl bg-emerald-500/15 border border-emerald-500/35 text-emerald-700 dark:text-emerald-300 text-xs sm:text-sm font-serif font-bold min-h-[44px]">
                    <Check className="w-4 h-4 shrink-0" />
                    <span>Đã khớp</span>
                  </div>
                )}

                <button
                  type="button"
                  onClick={() => handleNextSentence({ isSkipManual: practiceStatus !== 'correct' })}
                  disabled={currentIndex >= exercises.length - 1 && practiceStatus === 'correct'}
                  className={`inline-flex items-center justify-center gap-1.5 px-4 py-2 rounded-xl text-xs sm:text-sm font-serif font-bold transition-all min-h-[44px] cursor-pointer ${
                    practiceStatus === 'correct'
                      ? 'bg-emerald-600 hover:bg-emerald-700 text-white shadow-[0_2px_0_#065F46]'
                      : 'bg-[#FFF9F3] dark:bg-[#202B45] border border-[#182238]/20 dark:border-white/15 hover:border-[#182238] text-[#182238] dark:text-white'
                  } disabled:opacity-45 disabled:cursor-not-allowed`}
                  title={practiceStatus === 'correct' ? 'Chuyển sang câu tiếp theo (Enter)' : 'Bỏ qua câu này'}
                >
                  <span>
                    {currentIndex >= exercises.length - 1
                      ? practiceStatus === 'correct'
                        ? 'Hoàn thành'
                        : 'Kết thúc'
                      : practiceStatus === 'correct'
                      ? 'Câu tiếp theo'
                      : 'Bỏ qua'}
                  </span>
                  <ArrowRight className="w-4 h-4 shrink-0" />
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
        </div>

        {/* CỘT PHẢI (4/12): BẢNG THỐNG KÊ TIẾN ĐỘ & BỘ LỌC CẤP ĐỘ / BÀI HỌC */}
        <aside className="lg:col-span-4 space-y-4 lg:sticky lg:top-24 min-w-0">
          {/* Card 1: Thanh tiến độ + Lưới thống kê 2x2 */}
          <div className="bg-white dark:bg-[#182238] border border-stone-300 dark:border-white/15 rounded-2xl p-4 shadow-sm space-y-3.5">
            <div className="flex items-center justify-between gap-2">
              <span className="text-xs font-serif font-bold uppercase tracking-wider text-stone-700 dark:text-slate-200">
                Tiến độ &amp; Thống kê
              </span>
              <span className="text-xs font-sans font-bold text-[#B8322D] tabular-nums">
                {exercises.length > 0
                  ? `${Math.min(
                      100,
                      Math.round(
                        ((currentIndex + (practiceStatus === 'correct' ? 1 : 0)) / exercises.length) * 100
                      )
                    )}%`
                  : '0%'}
              </span>
            </div>

            <div className="w-full h-2 bg-stone-100 dark:bg-[#202B45] rounded-full overflow-hidden">
              <div
                className="h-full bg-[#B8322D] rounded-full transition-all duration-300"
                style={{
                  width: `${
                    exercises.length > 0
                      ? Math.min(
                          100,
                          Math.round(
                            ((currentIndex + (practiceStatus === 'correct' ? 1 : 0)) / exercises.length) * 100
                          )
                        )
                      : 0
                  }%`,
                }}
              />
            </div>

            <div className="grid grid-cols-2 gap-2.5">
              <div className="rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-200 dark:border-white/10 p-2.5">
                <div className="flex items-center gap-1.5 text-[11px] font-serif text-stone-500 dark:text-slate-400">
                  <Clock className="w-3.5 h-3.5 text-[#0D9488] shrink-0" />
                  <span>Thời gian</span>
                </div>
                <p className="text-base font-sans font-bold text-stone-900 dark:text-white mt-0.5 tabular-nums">
                  {Math.floor(elapsedSeconds / 60)}:{String(elapsedSeconds % 60).padStart(2, '0')}
                </p>
              </div>

              <div className="rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-200 dark:border-white/10 p-2.5">
                <div className="flex items-center gap-1.5 text-[11px] font-serif text-stone-500 dark:text-slate-400">
                  <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600 shrink-0" />
                  <span>Trùng khớp</span>
                </div>
                <p className="text-base font-sans font-bold text-emerald-600 dark:text-emerald-400 mt-0.5 tabular-nums">
                  {correctCount} <span className="text-[11px] font-normal text-stone-500">câu</span>
                </p>
              </div>

              <div className="rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-200 dark:border-white/10 p-2.5">
                <div className="flex items-center gap-1.5 text-[11px] font-serif text-stone-500 dark:text-slate-400">
                  <AlertCircle className="w-3.5 h-3.5 text-[#B8322D] shrink-0" />
                  <span>Cần xem lại</span>
                </div>
                <p className="text-base font-sans font-bold text-[#B8322D] dark:text-red-300 mt-0.5 tabular-nums">
                  {reviewCount} <span className="text-[11px] font-normal text-stone-500">câu</span>
                </p>
              </div>

              <div className="rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-200 dark:border-white/10 p-2.5">
                <div className="flex items-center gap-1.5 text-[11px] font-serif text-stone-500 dark:text-slate-400">
                  <BookOpen className="w-3.5 h-3.5 text-stone-600 dark:text-slate-300 shrink-0" />
                  <span>Câu hiện tại</span>
                </div>
                <p className="text-base font-sans font-bold text-stone-900 dark:text-white mt-0.5 tabular-nums">
                  {exercises.length > 0 ? `${currentIndex + 1}/${exercises.length}` : '0/0'}
                </p>
              </div>
            </div>
          </div>

          {/* Card 2: Bộ lọc HSK / Bài học / Chọn câu + Điều khiển âm thanh */}
          <div className="bg-white dark:bg-[#182238] border border-stone-300 dark:border-white/15 rounded-2xl p-4 shadow-sm space-y-4">
            <div className="space-y-3">
              <div className="flex items-center justify-between gap-2">
                <span className="text-xs font-serif font-bold uppercase tracking-wider text-stone-700 dark:text-slate-200 flex items-center gap-1.5">
                  <BookOpen className="w-3.5 h-3.5 text-[#B8322D]" />
                  <span>Bộ lọc &amp; Chọn bài</span>
                </span>
                <span className="text-[11px] font-sans text-stone-500 tabular-nums">
                  {exercises.length} câu
                </span>
              </div>

              {/* 5 nút HSK 1 - 5 */}
              <div className="grid grid-cols-5 gap-1.5">
                {[1, 2, 3, 4, 5].map((lvl) => (
                  <button
                    key={lvl}
                    type="button"
                    onClick={() => {
                      setHskLevel(lvl)
                      setSelectedLessonId('')
                    }}
                    className={`h-8 rounded-lg text-[11px] font-serif font-bold transition-colors cursor-pointer flex items-center justify-center touch-manipulation border ${
                      hskLevel === lvl
                        ? 'bg-[#B8322D] text-white border-[#B8322D]'
                        : 'bg-[#FAF7F2] dark:bg-[#202B45] border-stone-200 dark:border-white/10 text-stone-700 dark:text-slate-200 hover:border-stone-400'
                    }`}
                  >
                    HSK {lvl}
                  </button>
                ))}
              </div>

              {/* Chọn bài học cụ thể */}
              <div>
                <label htmlFor="translate-hsk-lesson" className="sr-only">
                  Chọn bài học theo cấp HSK
                </label>
                {loadingLessons ? (
                  <div className="flex items-center gap-1.5 text-xs text-muted font-serif px-2.5 h-9 bg-[#FAF7F2] border border-stone-200 rounded-xl">
                    <Loader2 className="w-3.5 h-3.5 animate-spin text-[#B8322D] shrink-0" />
                    <span className="truncate">Đang tải danh sách bài...</span>
                  </div>
                ) : (
                  <select
                    id="translate-hsk-lesson"
                    value={selectedLessonId}
                    onChange={(e) => setSelectedLessonId(e.target.value)}
                    aria-label="Chọn bài học theo cấp HSK"
                    className="w-full h-9 px-2.5 rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-300 dark:border-white/15 hover:border-stone-400 focus:border-[#0D9488] text-xs font-serif font-medium text-stone-800 dark:text-white focus:outline-none truncate cursor-pointer transition-colors"
                    title="Chọn bài học cụ thể"
                  >
                    <option value="">Tất cả bài học (HSK {hskLevel})</option>
                    {systemLessons.map((l) => (
                      <option key={l.id} value={l.id}>
                        {l.title}
                      </option>
                    ))}
                  </select>
                )}
              </div>

              {/* Chọn nhanh câu: gọn dạng Câu 1 / N */}
              <div>
                <label htmlFor="translate-question-select" className="sr-only">
                  Chọn nhanh câu ví dụ
                </label>
                {exercises.length > 0 ? (
                  <select
                    id="translate-question-select"
                    value={currentIndex}
                    onChange={(e) => {
                      const idx = parseInt(e.target.value, 10)
                      if (!isNaN(idx) && idx >= 0 && idx < exercises.length) {
                        setCurrentIndex(idx)
                        resetSentenceState()
                      }
                    }}
                    aria-label="Chọn nhanh câu ví dụ"
                    className="w-full h-9 px-2.5 rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-300 dark:border-white/15 focus:border-[#0D9488] text-xs font-sans font-semibold text-stone-800 dark:text-white focus:outline-none cursor-pointer tabular-nums"
                    title="Nhấn để chuyển nhanh đến câu bất kỳ"
                  >
                    {exercises.map((ex, idx) => (
                      <option
                        key={ex.id || idx}
                        value={idx}
                        className="bg-white dark:bg-[#182238] text-stone-900 dark:text-white"
                      >
                        Câu {idx + 1} / {exercises.length}
                      </option>
                    ))}
                  </select>
                ) : (
                  <div className="h-9 px-2.5 rounded-xl bg-[#FAF7F2] border border-stone-200 flex items-center text-xs font-sans font-semibold text-muted tabular-nums">
                    0 / 0
                  </div>
                )}
              </div>
            </div>

            {/* Điều khiển âm thanh & Tốc độ phát âm */}
            <div className="pt-3.5 border-t border-stone-200 dark:border-white/10 space-y-2.5">
              <div className="flex items-center justify-between gap-2">
                <span className="text-[11px] font-serif font-semibold text-stone-600 dark:text-slate-300">
                  Âm thanh đọc mẫu
                </span>
                <button
                  type="button"
                  onClick={handlePlayAudio}
                  disabled={!currentExercise}
                  className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-serif font-bold border transition-colors cursor-pointer disabled:opacity-40 ${
                    isAudioPlaying
                      ? 'bg-[#B8322D] text-white border-[#B8322D]'
                      : 'bg-[#FAF7F2] dark:bg-[#202B45] border-stone-300 dark:border-white/15 text-stone-800 dark:text-white hover:border-[#B8322D]'
                  }`}
                >
                  <Volume2 className={`w-3.5 h-3.5 shrink-0 ${isAudioPlaying ? 'animate-pulse' : 'text-[#B8322D]'}`} />
                  <span>{isAudioPlaying ? 'Đang phát' : 'Nghe mẫu'}</span>
                </button>
              </div>

              <div className="flex items-center gap-1 flex-wrap">
                {TTS_SPEED_RATES.map((rate) => (
                  <button
                    key={rate}
                    type="button"
                    onClick={() => {
                      setSpeechRate(rate)
                      setShowSpeedMenu(false)
                    }}
                    className={`flex-1 py-1 px-1.5 rounded-lg text-[11px] font-sans font-semibold border transition-colors cursor-pointer tabular-nums ${
                      speechRate === rate
                        ? 'bg-[#1C1917] text-white border-[#1C1917] dark:bg-[#0D9488] dark:border-[#0D9488]'
                        : 'bg-[#FAF7F2] dark:bg-[#202B45] border-stone-200 dark:border-white/10 text-stone-600 dark:text-slate-300 hover:text-stone-900'
                    }`}
                  >
                    {rate}x
                  </button>
                ))}
              </div>
            </div>
          </div>
        </aside>
      </div>
    </div>
  )
}
