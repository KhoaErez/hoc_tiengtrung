'use client'

import React, { useState, useEffect, useRef, useMemo, useCallback } from 'react'
import {
  TranslationExerciseItem,
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
  Flame,
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
  onBackToNormalMode?: () => void
  onOpenMistakes?: (options?: { hskLevel?: number; lessonId?: string }) => void
}

export default function TranslateTypingMode({
  initialHskLevel = 1,
  initialLessonId = '',
  initialSentenceIndex,
  initialSentenceId,
  initialViewMode = 'practice',
  onBackToNormalMode,
  onOpenMistakes,
}: TranslateTypingModeProps) {
  const { user, isLoggedIn } = useAuthModal()

  // Chế độ hiển thị cục bộ: Luyện tập bài học vs Ôn câu sai của Dịch Việt -> Gõ Hán
  const [viewMode, setViewMode] = useState<'practice' | 'mistakes'>(initialViewMode)

  useEffect(() => {
    if (initialViewMode) {
      setViewMode(initialViewMode)
    }
  }, [initialViewMode])

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
  const userInputRef = useRef<string>('')
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

  // Cờ theo dõi ghi nhận thống kê cho câu hiện tại (tránh cộng dồn sai khi Enter nhiều lần)
  const hasRecordedMistakeForCurrentRef = useRef<boolean>(false)
  const hasCountedCorrectForCurrentRef = useRef<boolean>(false)

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
    }, 100)
  }, [updatePracticeStatus])

  // 7. Thẻ "Tiếp tục học" dành riêng cho Dịch Việt -> Gõ Hán
  const [latestTranslateProgress, setLatestTranslateProgress] = useState<TypingProgressDTO | null>(null)
  const pendingResumeTargetRef = useRef<{ id?: string; index?: number } | null>(null)

  // Tải tiến độ dở dang gần nhất của riêng chế độ Dịch Việt -> Gõ Hán
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

  // Xử lý khi nhấn "Tiếp tục học →" trong chế độ Dịch Việt -> Gõ Hán
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
        // Cùng bài học hiện tại, chuyển ngay đến câu đó
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
        // Khác bài học, đặt pending target để khi fetch exercises xong sẽ tự động chọn câu này
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

  // Xử lý khi nhấn "Học lại từ đầu" trong chế độ Dịch Việt -> Gõ Hán
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

  // Tải danh sách câu ví dụ từ Supabase và khôi phục vị trí học tiếp thông minh
  useEffect(() => {
    let isCancelled = false
    setLoadingExercises(true)
    resetSentenceState()

    getTranslationExercisesAction({
      hskLevel,
      lessonId: selectedLessonId || undefined,
      limit: 60,
    })
      .then(async (res) => {
        if (isCancelled) return
        setLoadingExercises(false)
        if (res.success && res.data && res.data.length > 0) {
          const list = res.data
          setExercises(list)

          // 0. Nếu có pending target từ nút "Tiếp tục học"
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
          } else if (initialSentenceId) {
            const foundIdx = list.findIndex(
              (item) => item.id === initialSentenceId || item.exampleId === initialSentenceId
            )
            if (foundIdx !== -1) targetIndex = foundIdx
          } else if (
            typeof initialSentenceIndex === 'number' &&
            initialSentenceIndex >= 0 &&
            initialSentenceIndex < list.length
          ) {
            targetIndex = initialSentenceIndex
          } else {
            // 2. Tự động kiểm tra tiến độ đã lưu trước đó (Cloud Supabase nếu đã đăng nhập, LocalStorage nếu là khách)
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
                // Ưu tiên tìm theo ID câu ổn định
                if (savedProgress.currentQuestionId) {
                  const matchById = list.findIndex(
                    (it) => it.id === savedProgress!.currentQuestionId || it.exampleId === savedProgress!.currentQuestionId
                  )
                  if (matchById !== -1) {
                    targetIndex = matchById
                  }
                }
                // Nếu không tìm thấy bằng ID, fallback an toàn sang index
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
                  toast.info(`Khôi phục tiếp tục câu ${targetIndex + 1}/${list.length}`, { duration: 3000 })
                }
              }
            } catch (err) {
              console.error('Lỗi khôi phục tiến độ câu dịch:', err)
            }
          }

          setCurrentIndex(targetIndex)
        } else {
          setExercises([])
          setCurrentIndex(0)
        }
      })
      .catch((err) => {
        if (!isCancelled) setLoadingExercises(false)
        console.error('Lỗi tải câu dịch từ Supabase:', err)
        setExercises([])
        setCurrentIndex(0)
      })

    return () => {
      isCancelled = true
    }
  }, [
    hskLevel,
    selectedLessonId,
    exerciseStorageId,
    progressMode,
    initialSentenceId,
    initialSentenceIndex,
    isLoggedIn,
    resetSentenceState,
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
      lessonTitle: currentExercise.lessonTitle || `HSK ${hskLevel}`,
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
        lessonTitle: currentExercise.lessonTitle || `HSK ${hskLevel}`,
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
        lessonTitle: nextExercise.lessonTitle || `HSK ${hskLevel}`,
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
      <div className="space-y-4 pb-28 md:pb-12 max-w-4xl mx-auto select-text animate-in fade-in duration-200">
        <TypingMistakesReview
          isLoggedIn={isLoggedIn}
          practiceType="translate"
          initialHskLevel={hskLevel}
          initialLessonId={selectedLessonId}
          onBackToPractice={() => {
            setViewMode('practice')
            refreshReviewCount()
          }}
        />
      </div>
    )
  }

  return (
    <div className="space-y-4 pb-28 md:pb-12 max-w-4xl mx-auto select-text">
      {/* 1. Thanh điều khiển bài tập: Bố cục 2 hàng phân chia có chủ đích, không bao giờ bị rơi HSK 5 */}
      <div className="bg-card border border-[#E9DDD1] rounded-2xl p-3 sm:p-4 shadow-2xs space-y-3">
        {/* Hàng 1: Badge HSK 3.0 & 5 nút chọn cấp độ HSK 1 - 5 (kích thước và chiều cao hoàn toàn đồng nhất) */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2.5 pb-2.5 border-b border-[#E9DDD1]/60">
          <div className="flex items-center gap-2 sm:gap-2.5 w-full">
            <span className="text-[11px] uppercase font-mono tracking-wider px-3 rounded-xl bg-app-accent/10 text-app-accent border border-app-accent/20 font-bold shrink-0 flex items-center justify-center h-11 min-h-[44px]">
              HSK 3.0
            </span>

            {/* 5 nút HSK 1 - 5 có chiều rộng và chiều cao hoàn toàn đồng nhất trên 1 hàng */}
            <div className="grid grid-cols-5 gap-1.5 sm:gap-2 flex-1 max-w-[480px]">
              {[1, 2, 3, 4, 5].map((lvl) => (
                <button
                  key={lvl}
                  type="button"
                  onClick={() => {
                    setHskLevel(lvl)
                    setSelectedLessonId('')
                  }}
                  className={`h-11 min-h-[44px] rounded-xl text-xs sm:text-sm font-serif font-semibold transition-all active:scale-95 cursor-pointer flex items-center justify-center touch-manipulation ${
                    hskLevel === lvl
                      ? 'bg-[#B8322D] text-white shadow-2xs ring-1 ring-[#B8322D]'
                      : 'bg-page border border-[#E9DDD1] text-[#243047]/80 hover:text-[#243047] hover:bg-[#FFF9F3]'
                  }`}
                >
                  HSK {lvl}
                </button>
              ))}
            </div>

            <div className="ml-auto hidden md:flex items-center gap-1.5 text-xs text-muted font-serif shrink-0">
              <BookOpen className="w-3.5 h-3.5 text-muted" />
              <span>{exercises.length > 0 ? `${exercises.length} câu ví dụ` : 'HSK 3.0'}</span>
            </div>
          </div>
        </div>

        {/* Hàng 2: Bộ chọn bài học, Danh sách chọn câu & Nút Ôn câu sai (Chiều cao đồng nhất 44px) */}
        <div className="grid grid-cols-1 sm:grid-cols-12 gap-2 sm:gap-2.5 items-center">
          {/* Bộ chọn bài học (5/12 cột trên tablet/desktop) */}
          <div className="sm:col-span-5 min-w-0">
            {loadingLessons ? (
              <div className="flex items-center gap-2 text-xs text-muted font-serif px-3 h-11 min-h-[44px] bg-page border border-[#E9DDD1] rounded-xl">
                <Loader2 className="w-3.5 h-3.5 animate-spin text-app-accent shrink-0" />
                <span className="truncate">Đang tải bài học...</span>
              </div>
            ) : (
              <select
                value={selectedLessonId}
                onChange={(e) => setSelectedLessonId(e.target.value)}
                className="w-full bg-page border border-[#E9DDD1] hover:border-[#D4C5B5] focus:border-app-accent rounded-xl text-xs sm:text-sm font-serif text-[#243047] px-3.5 h-11 min-h-[44px] focus:outline-none truncate cursor-pointer shadow-2xs transition-colors"
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

          {/* Danh sách chọn câu nhanh (4/12 cột trên tablet/desktop) */}
          <div className="sm:col-span-4 min-w-0">
            {exercises.length > 0 ? (
              <select
                value={currentIndex}
                onChange={(e) => {
                  const idx = parseInt(e.target.value, 10)
                  if (!isNaN(idx) && idx >= 0 && idx < exercises.length) {
                    setCurrentIndex(idx)
                    resetSentenceState()
                  }
                }}
                className="w-full bg-page border border-[#E9DDD1] hover:border-[#D4C5B5] focus:border-app-accent rounded-xl text-xs sm:text-sm font-serif text-[#243047] px-3.5 h-11 min-h-[44px] focus:outline-none truncate cursor-pointer shadow-2xs transition-colors"
                title="Chuyển nhanh đến câu bất kỳ"
              >
                {exercises.map((ex, idx) => (
                  <option key={ex.id || idx} value={idx}>
                    #{idx + 1}: {ex.vietnamesePrompt}
                  </option>
                ))}
              </select>
            ) : (
              <div className="h-11 min-h-[44px] px-3.5 bg-page/60 border border-[#E9DDD1]/60 rounded-xl text-xs font-serif text-muted flex items-center">
                <span>Chưa có câu</span>
              </div>
            )}
          </div>

          {/* Nút chuyển nhanh sang Ôn câu sai (3/12 cột trên tablet/desktop) */}
          <div className="sm:col-span-3 min-w-0">
            <button
              type="button"
              onClick={() => setViewMode('mistakes')}
              className="w-full flex items-center justify-center gap-2 px-3 py-2 rounded-xl border border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] hover:border-app-accent/40 text-xs sm:text-sm font-serif font-semibold text-[#243047] hover:text-[#B8322D] shadow-2xs transition-all active:scale-95 cursor-pointer h-11 min-h-[44px] whitespace-nowrap"
              title="Mở khu vực Ôn câu sai (Spaced Repetition) của chế độ Dịch"
            >
              <Flame className="w-4 h-4 text-[#B8322D] shrink-0" />
              <span className="truncate">Ôn câu sai</span>
              {reviewCount > 0 && (
                <span className="px-1.5 py-0.5 rounded-full text-[10px] font-sans font-bold bg-red-500/15 text-red-600 dark:text-red-400 shrink-0">
                  {reviewCount}
                </span>
              )}
            </button>
          </div>
        </div>
      </div>

      {/* 1.1. Thẻ "Tiếp tục học" thông minh riêng biệt cho Dịch Việt → Gõ Hán */}
      {latestTranslateProgress && (
        <TypingResumeCard
          progress={latestTranslateProgress}
          onResume={handleResumeTranslate}
          onRestart={handleRestartTranslate}
          onDismiss={() => setLatestTranslateProgress(null)}
        />
      )}

      {/* 2. Thanh tiến độ bài học & Thống kê ngắn */}
      {exercises.length > 0 && (
        <div className="flex items-center justify-between gap-3 px-3.5 sm:px-4 py-2.5 bg-card/75 backdrop-blur-xs border border-[#E9DDD1] rounded-xl text-xs font-serif text-muted shadow-2xs">
          <div className="flex items-center gap-2.5 flex-wrap">
            <span className="font-semibold text-title flex items-center gap-1.5">
              <span className="w-1.5 h-1.5 rounded-full bg-app-accent" />
              <span>Câu {currentIndex + 1} / {exercises.length}</span>
            </span>
            <span className="text-[#E9DDD1]">|</span>
            <span className="text-emerald-700 dark:text-emerald-400 font-medium flex items-center gap-1">
              <CheckCircle2 className="w-3.5 h-3.5" />
              <span>{correctCount} trùng mẫu</span>
            </span>
            {reviewCount > 0 && (
              <>
                <span className="text-[#E9DDD1]">|</span>
                <button
                  type="button"
                  onClick={() => setViewMode('mistakes')}
                  className="text-amber-700 dark:text-amber-400 font-medium hover:underline flex items-center gap-1 cursor-pointer"
                  title="Mở ngay danh sách câu sai để ôn tập"
                >
                  <Flame className="w-3.5 h-3.5 text-amber-600" />
                  <span>{reviewCount} câu cần xem lại →</span>
                </button>
              </>
            )}
          </div>

          <div className="flex items-center gap-1.5 font-mono text-[11px] text-muted shrink-0">
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
          <div className="bg-card border-2 border-[#E9DDD1] rounded-2xl p-5 sm:p-7 md:p-8 shadow-xs space-y-4">
            <div className="flex items-center justify-between gap-2 border-b border-[#E9DDD1]/60 pb-3">
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-app-accent" />
                <span className="text-xs sm:text-sm font-serif font-medium text-muted">
                  Dịch câu tiếng Việt sang chữ Hán:
                </span>
              </div>
              <span className="text-[11px] font-sans px-2.5 py-1 rounded-full bg-[#FFF9F3] border border-[#E9DDD1] text-title font-semibold shadow-2xs">
                {currentExercise.lessonTitle || `HSK ${hskLevel}`}
              </span>
            </div>

            {/* Câu tiếng Việt nổi bật */}
            <div className="py-2 sm:py-3">
              <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#243047] leading-relaxed tracking-normal select-text">
                &ldquo;{currentExercise.vietnamesePrompt}&rdquo;
              </h2>
            </div>

            {/* Thanh điều khiển âm thanh TTS tiếng Trung */}
            <div className="flex items-center justify-between gap-2.5 pt-3 border-t border-[#E9DDD1]/60 flex-wrap">
              <div className="flex items-center gap-2">
                <button
                  type="button"
                  onClick={handlePlayAudio}
                  className={`flex items-center gap-2 px-4 py-2 rounded-xl text-xs sm:text-sm font-serif font-semibold transition-all active:scale-95 cursor-pointer touch-manipulation min-h-[44px] shadow-2xs ${
                    isAudioPlaying
                      ? 'bg-app-accent text-white shadow-sm ring-2 ring-app-accent/20'
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
                    className="flex items-center gap-1.5 px-3 py-2 bg-page border border-[#E9DDD1] hover:border-app-accent/50 rounded-xl text-xs font-mono font-medium text-[#243047] transition-colors touch-manipulation min-h-[44px] cursor-pointer shadow-2xs"
                    title="Điều chỉnh tốc độ đọc"
                  >
                    <span>{speechRate}x</span>
                    <ChevronDown className="w-3 h-3 text-muted" />
                  </button>

                  {showSpeedMenu && (
                    <div className="absolute left-0 bottom-full mb-1 bg-card border border-[#E9DDD1] rounded-xl shadow-lg p-1 z-30 flex flex-col gap-0.5 min-w-[70px]">
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
                readOnly={practiceStatus === 'checking' || practiceStatus === 'transitioning'}
                autoComplete="off"
                autoCorrect="off"
                autoCapitalize="off"
                spellCheck="false"
                placeholder={
                  practiceStatus === 'correct'
                    ? 'Đã trùng khớp câu mẫu! Nhấn Enter để sang câu tiếp theo hoặc bấm "Câu tiếp theo"...'
                    : practiceStatus === 'incorrect'
                    ? 'Chưa chính xác. Chỉnh sửa câu của bạn rồi nhấn Enter để kiểm tra...'
                    : practiceStatus === 'checking'
                    ? 'Đang kiểm tra đáp án...'
                    : practiceStatus === 'transitioning'
                    ? 'Đang chuyển câu tiếp theo...'
                    : 'Bật bộ gõ tiếng Trung (Pinyin), gõ pinyin rồi chọn chữ Hán tương ứng...'
                }
                className={`w-full px-4 sm:px-5 py-3.5 sm:py-4 bg-white dark:bg-card border-2 rounded-2xl text-lg sm:text-2xl font-serif text-[#243047] placeholder:text-muted/70 placeholder:text-sm sm:placeholder:text-base focus:outline-none transition-all shadow-inner ${
                  practiceStatus === 'correct'
                    ? 'border-emerald-500 bg-emerald-50/20 ring-4 ring-emerald-500/10'
                    : practiceStatus === 'incorrect'
                    ? 'border-amber-500/80 bg-amber-50/15 ring-4 ring-amber-500/10'
                    : 'border-[#E9DDD1] focus:border-app-accent focus:ring-4 focus:ring-app-accent/10'
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
                    className="absolute right-3 top-3.5 p-1 rounded-full text-muted hover:text-title hover:bg-page transition-colors cursor-pointer"
                    title="Xóa nội dung vừa gõ"
                  >
                    <X className="w-4 h-4" />
                  </button>
                )}
            </div>

            {/* THÔNG BÁO TRẠNG THÁI THEO CHUẨN ENTER UX (Ngay dưới ô nhập liệu) */}
            {practiceStatus === 'correct' && (
              <div className="p-3 sm:p-3.5 rounded-xl bg-emerald-500/10 border border-emerald-500/30 text-emerald-800 dark:text-emerald-200 text-xs sm:text-sm font-serif flex items-center justify-between gap-3 animate-in fade-in duration-200">
                <div className="flex items-center gap-2">
                  <CheckCircle2 className="w-5 h-5 text-emerald-600 dark:text-emerald-400 shrink-0" />
                  <span>
                    <strong>Chính xác!</strong> Nhấn <kbd className="font-mono font-bold bg-white/90 dark:bg-emerald-950 px-1.5 py-0.5 rounded border border-emerald-400/40 text-emerald-900 dark:text-emerald-100 shadow-2xs">Enter</kbd> lần nữa để chuyển sang câu tiếp theo.
                  </span>
                </div>
                <button
                  type="button"
                  onClick={() => handleNextSentence()}
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-emerald-600 hover:bg-emerald-700 text-white font-semibold rounded-lg text-xs shadow-2xs transition-all active:scale-95 cursor-pointer shrink-0"
                  title="Chuyển sang câu tiếp theo"
                >
                  <span>Tiếp tục</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </button>
              </div>
            )}

            {practiceStatus === 'incorrect' && (
              <div className="p-3 sm:p-3.5 rounded-xl bg-amber-500/10 border border-amber-500/30 text-amber-900 dark:text-amber-200 text-xs sm:text-sm font-serif flex flex-col sm:flex-row sm:items-center justify-between gap-2.5 animate-in fade-in duration-200">
                <div className="flex items-start sm:items-center gap-2">
                  <AlertCircle className="w-5 h-5 text-amber-600 dark:text-amber-400 shrink-0 mt-0.5 sm:mt-0" />
                  <span>
                    Bạn cần trả lời đúng để chuyển sang câu tiếp theo. Hãy kiểm tra và sửa lại đáp án, hoặc chọn <strong className="font-semibold">Bỏ qua câu này</strong> nếu muốn chuyển tiếp.
                  </span>
                </div>
                <div className="flex items-center gap-2 self-end sm:self-auto shrink-0">
                  <button
                    type="button"
                    onClick={handleCheckAnswer}
                    disabled={userInput.trim().length === 0}
                    className="inline-flex items-center gap-1 px-3 py-1.5 bg-[#B8322D] hover:bg-[#982923] text-white rounded-lg text-xs font-serif font-semibold transition-all shadow-2xs active:scale-95 cursor-pointer"
                    title="Kiểm tra lại đáp án (hoặc nhấn Enter)"
                  >
                    <CheckCircle2 className="w-3.5 h-3.5" />
                    <span>Kiểm tra lại</span>
                  </button>
                  <button
                    type="button"
                    onClick={() => handleNextSentence({ isSkipManual: true })}
                    className="inline-flex items-center gap-1 px-3 py-1.5 bg-white/80 dark:bg-card border border-amber-400/50 hover:bg-white text-amber-900 dark:text-amber-300 rounded-lg text-xs font-serif font-medium transition-all shadow-2xs active:scale-95 cursor-pointer"
                    title="Bỏ qua câu này và chuyển sang câu tiếp theo (không tính đúng)"
                  >
                    <span>Bỏ qua câu này →</span>
                  </button>
                </div>
              </div>
            )}

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
                    để sang câu tiếp theo
                  </span>
                ) : (
                  <span className="text-body font-medium">
                    để kiểm tra
                  </span>
                )}
              </span>
            </div>
          </div>

          {/* 6. Hàng nút công cụ: Gợi ý & Kiểm tra (chỉ hiện khi đang nhập liệu, bỏ nút Kiểm tra lại trùng lặp khi sai) */}
          {practiceStatus === 'typing' && (
            <div className="flex items-center justify-between gap-2 pt-1">
              <button
                type="button"
                onClick={handleNextHint}
                disabled={hintLevel >= 3}
                className={`flex items-center gap-1.5 px-3.5 py-2.5 rounded-xl text-xs sm:text-sm font-serif font-medium transition-all active:scale-95 touch-manipulation min-h-[44px] cursor-pointer shadow-2xs ${
                  hintLevel >= 3
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
                disabled={userInput.trim().length === 0}
                className="flex items-center gap-2 px-5 sm:px-6 py-2.5 bg-[#B8322D] hover:bg-[#982923] disabled:opacity-40 disabled:cursor-not-allowed text-white rounded-xl text-xs sm:text-sm font-serif font-semibold transition-all shadow-2xs active:scale-95 touch-manipulation min-h-[44px] cursor-pointer ml-auto"
                title="Kiểm tra đáp án (hoặc nhấn phím Enter)"
              >
                <CheckCircle2 className="w-4 h-4 shrink-0" />
                <span>Kiểm tra</span>
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
                    title="Xóa câu đã nhập và luyện lại câu này từ đầu"
                  >
                    <RotateCcw className="w-4 h-4 shrink-0" />
                    <span>Luyện lại</span>
                  </button>

                  {evaluation.isExactMatch ? (
                    <button
                      type="button"
                      onClick={() => handleNextSentence()}
                      className="flex items-center gap-1.5 px-4 sm:px-5 py-2 bg-[#B8322D] hover:bg-[#982923] text-white rounded-xl text-xs sm:text-sm font-serif font-semibold transition-all shadow-2xs active:scale-95 touch-manipulation min-h-[44px] cursor-pointer"
                      title="Chuyển sang câu tiếp theo (hoặc nhấn phím Enter)"
                    >
                      <span>{currentIndex >= exercises.length - 1 ? 'Hoàn thành' : 'Câu tiếp theo'}</span>
                      <ArrowRight className="w-4 h-4 shrink-0" />
                    </button>
                  ) : (
                    <>
                      <button
                        type="button"
                        onClick={handleCheckAnswer}
                        disabled={userInput.trim().length === 0}
                        className="flex items-center gap-1.5 px-4 sm:px-5 py-2 bg-[#B8322D] hover:bg-[#982923] text-white rounded-xl text-xs sm:text-sm font-serif font-semibold transition-all shadow-2xs active:scale-95 touch-manipulation min-h-[44px] cursor-pointer"
                        title="Kiểm tra lại đáp án (hoặc nhấn phím Enter)"
                      >
                        <CheckCircle2 className="w-4 h-4 shrink-0" />
                        <span>Kiểm tra lại</span>
                      </button>
                      <button
                        type="button"
                        onClick={() => handleNextSentence({ isSkipManual: true })}
                        className="flex items-center gap-1.5 px-3 py-2 bg-[#FFF9F3] border border-[#E9DDD1] hover:bg-[#F6EDE3] rounded-xl text-xs sm:text-sm font-serif text-amber-900 dark:text-amber-300 transition-all active:scale-95 touch-manipulation min-h-[44px] cursor-pointer shadow-2xs"
                        title="Bỏ qua câu này và chuyển tiếp (không tính đúng)"
                      >
                        <span>Bỏ qua câu này →</span>
                      </button>
                    </>
                  )}
                </div>
              </div>

              {/* Hướng dẫn phím tắt trực quan trong khối kết quả */}
              {evaluation.isExactMatch ? (
                <div className="p-3 rounded-xl bg-emerald-500/10 border border-emerald-500/30 text-emerald-800 dark:text-emerald-300 text-xs sm:text-sm font-serif flex items-center justify-between gap-2 flex-wrap">
                  <span className="flex items-center gap-1.5 font-medium">
                    <Check className="w-4 h-4 text-emerald-600 shrink-0" />
                    <span>
                      Nhấn phím <kbd className="font-mono font-bold px-1.5 py-0.5 rounded bg-white/80 dark:bg-emerald-950/80 border border-emerald-400/40 text-emerald-900 dark:text-emerald-200">Enter</kbd> để sang câu tiếp theo, hoặc bấm nút &ldquo;Câu tiếp theo&rdquo;.
                    </span>
                  </span>
                </div>
              ) : (
                <div className="p-3 rounded-xl bg-amber-500/10 border border-amber-500/30 text-amber-800 dark:text-amber-300 text-xs sm:text-sm font-serif flex items-center justify-between gap-2 flex-wrap">
                  <span className="flex items-center gap-1.5 font-medium">
                    <AlertCircle className="w-4 h-4 text-amber-600 shrink-0" />
                    <span>
                      Chỉnh sửa câu ở ô nhập liệu rồi nhấn <kbd className="font-mono font-bold px-1.5 py-0.5 rounded bg-white/80 dark:bg-amber-950/80 border border-amber-400/40 text-amber-900 dark:text-amber-200">Enter</kbd> để kiểm tra, hoặc bấm <strong className="font-semibold">&ldquo;Câu tiếp theo&rdquo;</strong> để bỏ qua câu này.
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
                  : practiceStatus === 'correct'
                  ? 'Câu tiếp theo'
                  : 'Bỏ qua câu này →'}
              </span>
              <ArrowRight className="w-4 h-4 shrink-0" />
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
