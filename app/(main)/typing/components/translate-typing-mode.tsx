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
  const inputRef = useRef<HTMLInputElement | HTMLTextAreaElement | null>(null)

  // 4. Trạng thái đánh giá & Gợi ý
  const [isChecked, setIsChecked] = useState<boolean>(false)
  const [evaluation, setEvaluation] = useState<TranslationEvaluationResult | null>(null)
  const [hintLevel, setHintLevel] = useState<number>(0) // 0: chưa gợi ý, 1: từ vựng, 2: pinyin, 3: toàn bộ chữ Hán
  const [hintsUsedCount, setHintsUsedCount] = useState<number>(0)

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
  }, [hskLevel, selectedLessonId])

  // Khôi phục bản nháp hoặc tiến độ cũ của câu hiện tại
  useEffect(() => {
    if (!currentExercise) return
    const draft = getLocalTypingDraft(progressMode, `${exerciseStorageId}-${currentExercise.id}`)
    if (draft && draft.draftText && !isChecked) {
      setUserInput(draft.draftText)
    }
  }, [currentExercise?.id, exerciseStorageId, isChecked])

  // Quản lý đồng hồ tính giờ
  useEffect(() => {
    let timer: NodeJS.Timeout | null = null
    if (isTimerRunning && !isChecked) {
      timer = setInterval(() => {
        setElapsedSeconds((prev) => prev + 1)
      }, 1000)
    }
    return () => {
      if (timer) clearInterval(timer)
    }
  }, [isTimerRunning, isChecked])

  // Tự động lưu bản nháp ký tự với debounce 300ms
  const draftTimerRef = useRef<NodeJS.Timeout | null>(null)
  useEffect(() => {
    if (!currentExercise || isChecked || !userInput) return
    if (draftTimerRef.current) clearTimeout(draftTimerRef.current)

    draftTimerRef.current = setTimeout(() => {
      saveLocalTypingDraft(progressMode, `${exerciseStorageId}-${currentExercise.id}`, currentIndex, userInput)
    }, 300)

    return () => {
      if (draftTimerRef.current) clearTimeout(draftTimerRef.current)
    }
  }, [userInput, currentExercise, currentIndex, isChecked, exerciseStorageId])

  // Dừng TTS khi chuyển câu hoặc component unmount
  useEffect(() => {
    return () => {
      ttsEngine.stop()
    }
  }, [currentIndex])

  // Reset trạng thái khi sang câu mới
  const resetSentenceState = useCallback(() => {
    setUserInput('')
    setIsChecked(false)
    setEvaluation(null)
    setHintLevel(0)
    ttsEngine.stop()
    setIsAudioPlaying(false)
    setTimeout(() => {
      inputRef.current?.focus()
    }, 120)
  }, [])

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

  // Xử lý khi người dùng nhập liệu
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value
    if (!isTimerRunning && val.length > 0) {
      setIsTimerRunning(true)
    }
    setUserInput(val)
  }

  // Sự kiện Composition của bàn phím tiếng Trung IME
  const handleCompositionStart = () => {
    isComposingRef.current = true
    setIsComposing(true)
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
  }

  // Xử lý phím Enter: Nếu đang composition -> không submit; Nếu không -> submit hoặc chuyển câu
  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    // Nếu IME đang chọn chữ -> bỏ qua hoàn toàn sự kiện Enter
    if (isComposing || isComposingRef.current || e.nativeEvent?.isComposing || e.keyCode === 229) {
      return
    }

    if (e.key === 'Enter') {
      e.preventDefault()
      if (!isChecked && userInput.trim().length > 0) {
        handleCheckAnswer()
      } else if (isChecked) {
        handleNextSentence()
      }
    }
  }

  // Kiểm tra đáp án câu dịch
  const handleCheckAnswer = useCallback(async () => {
    if (!currentExercise || isChecked || !userInput.trim()) return

    const evalResult = evaluateTranslationInput(userInput, currentExercise.chineseAnswer)
    setEvaluation(evalResult)
    setIsChecked(true)
    setIsTimerRunning(false)
    ttsEngine.stop()
    setIsAudioPlaying(false)

    // Xóa bản nháp câu này sau khi đã kiểm tra
    clearLocalTypingDraft(progressMode, `${exerciseStorageId}-${currentExercise.id}`)

    const isMatch = evalResult.isExactMatch
    if (isMatch) {
      setCorrectCount((prev) => prev + 1)
      playTypingSfx('complete', 0.08)
    } else {
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

    // Cập nhật tiến độ học tập lên Supabase
    const progressPayload: TypingProgressDTO = {
      mode: progressMode,
      exerciseId: exerciseStorageId,
      currentSentenceIndex: currentIndex,
      completedSentences: currentIndex + 1,
      totalSentences: exercises.length,
      correctSentences: correctCount + (isMatch ? 1 : 0),
      errorSentences: reviewCount + (!isMatch ? 1 : 0),
      lastTypedLength: userInput.length,
      timeSpentSeconds: Math.max(elapsedSeconds, 1),
      status: currentIndex >= exercises.length - 1 ? 'completed' : 'in_progress',
      updatedAt: new Date().toISOString(),
    }

    saveLocalTypingProgress(progressPayload as any)
    if (isLoggedIn) {
      saveTypingProgressAction(progressPayload).catch(() => {})
    }
  }, [
    currentExercise,
    isChecked,
    userInput,
    exerciseStorageId,
    progressMode,
    currentIndex,
    exercises.length,
    correctCount,
    reviewCount,
    elapsedSeconds,
    isLoggedIn,
  ])

  // Luyện lại câu hiện tại
  const handleRetryCurrent = useCallback(() => {
    resetSentenceState()
  }, [resetSentenceState])

  // Chuyển sang câu tiếp theo
  const handleNextSentence = useCallback(() => {
    if (currentIndex < exercises.length - 1) {
      setCurrentIndex((prev) => prev + 1)
      resetSentenceState()
    } else {
      toast.success('Xuất sắc! Bạn đã hoàn thành toàn bộ bài luyện dịch này!', {
        description: `Kết quả: ${correctCount} câu trùng mẫu, ${reviewCount} câu cần xem lại.`,
        duration: 4000,
      })
    }
  }, [currentIndex, exercises.length, resetSentenceState, correctCount, reviewCount])

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
                {hintLevel < 3 && !isChecked && (
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
                disabled={isChecked}
                autoComplete="off"
                autoCorrect="off"
                autoCapitalize="off"
                spellCheck="false"
                placeholder={
                  isChecked
                    ? 'Bấm "Câu tiếp theo" hoặc phím Enter để sang câu mới.'
                    : 'Bật bộ gõ tiếng Trung (Pinyin), gõ pinyin rồi chọn chữ Hán tương ứng...'
                }
                className="w-full px-4 py-3.5 sm:py-4 bg-card border-2 border-[#E9DDD1] focus:border-app-accent rounded-2xl text-lg sm:text-2xl font-serif text-[#243047] placeholder:text-muted placeholder:text-sm focus:outline-none transition-colors shadow-inner"
                style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
              />

              {/* Chỉ báo trạng thái gõ IME composition */}
              {isComposing && (
                <div className="absolute right-3 top-3.5 px-2.5 py-1 bg-amber-500/15 border border-amber-400/40 text-amber-700 dark:text-amber-400 rounded-lg text-xs font-sans flex items-center gap-1.5 animate-pulse select-none">
                  <span className="w-2 h-2 rounded-full bg-amber-500" />
                  <span>Đang chọn chữ ({compositionText || 'pinyin'})...</span>
                </div>
              )}

              {/* Nút xóa nhanh khi chưa kiểm tra */}
              {!isChecked && userInput.length > 0 && !isComposing && (
                <button
                  type="button"
                  onClick={() => {
                    setUserInput('')
                    inputRef.current?.focus()
                  }}
                  className="absolute right-3 top-3.5 p-1 rounded-full text-muted hover:text-title hover:bg-page transition-colors cursor-pointer"
                  title="Xóa nội dung vừa gõ"
                >
                  <X className="w-4 h-4" />
                </button>
              )}
            </div>

            {/* Thông tin số ký tự & phím tắt */}
            <div className="flex items-center justify-between text-xs text-muted font-serif px-1">
              <span>
                Đã gõ: <strong className="text-title">{userInput.length}</strong> ký tự
              </span>
              <span className="hidden sm:inline">
                Phím tắt: <kbd className="px-1.5 py-0.5 rounded bg-page border border-border">Enter</kbd> để kiểm tra / tiếp tục
              </span>
            </div>
          </div>

          {/* 6. Hàng nút công cụ: Gợi ý & Kiểm tra đáp án */}
          {!isChecked && (
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
              >
                <CheckCircle2 className="w-4 h-4 shrink-0" />
                <span>Kiểm tra đáp án</span>
              </button>
            </div>
          )}

          {/* 7. Khối kết quả sau khi kiểm tra (Evaluation Result Card) */}
          {isChecked && evaluation && (
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
                        : 'Tiếng Trung có nhiều cách diễn đạt tương đương. Hãy đối chiếu câu mẫu bên dưới để tham khảo.'}
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
                    onClick={handleNextSentence}
                    className="flex items-center gap-1.5 px-4 sm:px-5 py-2 bg-[#B8322D] hover:bg-[#982923] text-white rounded-xl text-xs sm:text-sm font-serif font-semibold transition-all shadow-2xs active:scale-95 touch-manipulation min-h-[44px] cursor-pointer"
                  >
                    <span>{currentIndex >= exercises.length - 1 ? 'Hoàn thành' : 'Câu tiếp theo'}</span>
                    <ArrowRight className="w-4 h-4 shrink-0" />
                  </button>
                </div>
              </div>

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
              disabled={currentIndex === 0}
              className="flex items-center gap-1.5 px-3 py-2 text-xs sm:text-sm text-[#243047] hover:text-[#B8322D] disabled:opacity-35 disabled:cursor-not-allowed font-serif transition-colors touch-manipulation min-h-[44px] cursor-pointer"
            >
              <ArrowLeft className="w-4 h-4 shrink-0" />
              <span>Câu trước</span>
            </button>

            <button
              type="button"
              onClick={handleNextSentence}
              disabled={currentIndex >= exercises.length - 1 && isChecked}
              className="flex items-center gap-1.5 px-4 py-2 bg-[#FFF9F3] border border-[#E9DDD1] hover:border-app-accent hover:text-app-accent text-title rounded-xl text-xs sm:text-sm font-serif font-medium transition-all shadow-2xs touch-manipulation min-h-[44px] cursor-pointer ml-auto"
            >
              <span>{currentIndex >= exercises.length - 1 ? 'Đã hết câu' : 'Câu tiếp theo'}</span>
              <ArrowRight className="w-4 h-4 shrink-0" />
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
