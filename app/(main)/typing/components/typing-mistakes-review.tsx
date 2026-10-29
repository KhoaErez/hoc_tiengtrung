'use client'

import React, { useState, useEffect, useMemo, useRef, useCallback } from 'react'
import {
  TypingMistakeItem,
  ReviewStatus,
  getLocalTypingMistakes,
  updateLocalMistakeReview,
  updateLocalMistakeStatus,
} from '@/lib/typing-storage'
import {
  getTypingMistakesAction,
  updateMistakeReviewResultAction,
  updateMistakeStatusAction,
  TypingMistakeDTO,
} from '../actions'
import {
  evaluateTranslationInput,
  TranslationEvaluationResult,
} from '@/lib/translation-typing-eval'
import { ttsEngine, TTS_SPEED_RATES, TTSSpeedRate } from '@/lib/tts/tts-engine'
import { playTypingSfx } from '@/lib/typing-sound'
import {
  isItemDue,
  formatDueText,
} from '@/lib/spaced-repetition'
import { AudioButton } from '@/components/ui/audio-button'
import {
  CheckCircle2,
  XCircle,
  RotateCcw,
  ArrowRight,
  ArrowLeft,
  Volume2,
  Filter,
  Layers,
  Award,
  AlertCircle,
  HelpCircle,
  Eye,
  EyeOff,
  Flame,
  Check,
  Play,
  Calendar,
  Clock,
  Sparkles,
  ChevronLeft,
  ChevronRight,
  Lightbulb,
  X,
  BookOpen,
  Headphones,
  PenTool,
  Loader2,
} from 'lucide-react'
import { toast } from 'sonner'

export type ReviewFilterStatus = 'all' | 'due' | 'need_review' | 'reviewing' | 'mastered'
export type PracticeReviewTab = 'translate' | 'listen'

export interface TypingMistakesReviewProps {
  isLoggedIn: boolean
  practiceType: PracticeReviewTab
  initialHskLevel?: number
  initialLessonId?: string
  onBackToPractice: () => void
}

export default function TypingMistakesReview({
  isLoggedIn,
  practiceType,
  initialHskLevel,
  initialLessonId,
  onBackToPractice,
}: TypingMistakesReviewProps) {
  // 1. Chế độ ôn tập hiện tại: Gắn chặt với practiceType của component cha
  const activeTab: PracticeReviewTab = practiceType
  const isTrans = practiceType === 'translate'

  // 2. Danh sách câu sai & trạng thái tải
  const [mistakes, setMistakes] = useState<TypingMistakeItem[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [loadError, setLoadError] = useState<string | null>(null)

  // 3. Bộ lọc trạng thái & HSK
  const [statusFilter, setStatusFilter] = useState<ReviewFilterStatus>('all')
  const [hskFilter, setHskFilter] = useState<'all' | '1' | '2' | '3' | '4' | '5' | '6'>(() => {
    if (initialHskLevel && initialHskLevel >= 1 && initialHskLevel <= 6) {
      return String(initialHskLevel) as any
    }
    return 'all'
  })

  // Đồng bộ cấp độ HSK từ props nếu có
  useEffect(() => {
    if (initialHskLevel && initialHskLevel >= 1 && initialHskLevel <= 6) {
      setHskFilter(String(initialHskLevel) as any)
    }
  }, [initialHskLevel])

  const [page, setPage] = useState<number>(1)
  const itemsPerPage = 8

  // 4. Trạng thái phiên ôn tập chủ động (Active SRS Session)
  const [activeQueue, setActiveQueue] = useState<TypingMistakeItem[]>([])
  const [currentQueueIndex, setCurrentQueueIndex] = useState<number>(-1)
  const [sessionCompleted, setSessionCompleted] = useState<boolean>(false)
  const [sessionStats, setSessionStats] = useState({
    reviewedCount: 0,
    correctCount: 0,
    lapsedCount: 0,
  })

  // 5. Trạng thái nhập liệu và kiểm tra cho câu đang ôn
  const [userInput, setUserInput] = useState<string>('')
  const userInputRef = useRef<string>('')
  const [practiceStatus, setPracticeStatus] = useState<'typing' | 'checking' | 'incorrect' | 'correct' | 'transitioning'>('typing')
  const practiceStatusRef = useRef<'typing' | 'checking' | 'incorrect' | 'correct' | 'transitioning'>('typing')
  const [evaluation, setEvaluation] = useState<TranslationEvaluationResult | null>(null)
  const [hintLevel, setHintLevel] = useState<number>(0)
  const [hintsUsedCount, setHintsUsedCount] = useState<number>(0)
  const [hadRetryCurrent, setHadRetryCurrent] = useState<boolean>(false)

  // Trạng thái hiển thị gợi ý riêng cho chế độ Nghe & Gõ
  const [showListenMeaningHint, setShowListenMeaningHint] = useState<boolean>(false)
  const [showListenLengthHint, setShowListenLengthHint] = useState<boolean>(false)
  const [listenSpeechRate, setListenSpeechRate] = useState<TTSSpeedRate>(1.0)

  // IME handling refs (5 tầng chống lỗi IME Enter)
  const [isComposing, setIsComposing] = useState<boolean>(false)
  const [compositionText, setCompositionText] = useState<string>('')
  const isComposingRef = useRef<boolean>(false)
  const justEndedCompositionRef = useRef<boolean>(false)
  const justEndedCompositionTimerRef = useRef<NodeJS.Timeout | null>(null)
  const inputRef = useRef<HTMLInputElement | null>(null)

  // TTS trong phiên ôn tập
  const [isAudioPlaying, setIsAudioPlaying] = useState<boolean>(false)
  const lastAutoSpokenMistakeIdRef = useRef<string | null>(null)

  // Helper trích xuất cấp độ HSK từ exerciseId
  const extractHskLevel = useCallback((exerciseId: string): number | null => {
    if (!exerciseId) return null
    const match = exerciseId.match(/hsk-?(\d)/i)
    if (match) return parseInt(match[1], 10)
    return null
  }, [])

  // Helper chuẩn hóa phân loại practiceType ('translate' vs 'listen')
  const getItemPracticeType = useCallback((item: TypingMistakeItem): 'translate' | 'listen' => {
    if (item.practiceType) return item.practiceType
    return item.mode?.includes('translate') ? 'translate' : 'listen'
  }, [])

  // Tải danh sách câu sai từ Supabase (hoặc localStorage) CHỈ cho đúng practiceType này
  const loadMistakes = useCallback(async () => {
    setIsLoading(true)
    setLoadError(null)
    try {
      if (isLoggedIn) {
        const res = await getTypingMistakesAction({ practiceType })
        if (res.success && res.mistakes) {
          setMistakes(res.mistakes as TypingMistakeItem[])
          setIsLoading(false)
          return
        }
      }
      const localList = getLocalTypingMistakes({ practiceType })
      setMistakes(localList)
    } catch (err: any) {
      console.error('Lỗi tải câu sai:', err)
      setLoadError('Không thể tải danh sách câu sai. Vui lòng bấm Thử lại.')
      const localList = getLocalTypingMistakes({ practiceType })
      setMistakes(localList)
    } finally {
      setIsLoading(false)
    }
  }, [isLoggedIn, practiceType])

  useEffect(() => {
    loadMistakes()
  }, [loadMistakes])

  // Danh sách câu sai của chế độ hiện tại
  const currentTabMistakes = useMemo(() => {
    return mistakes.filter((m) => getItemPracticeType(m) === practiceType)
  }, [mistakes, practiceType, getItemPracticeType])

  // Thống kê 4 Cards cho chế độ hiện tại
  const stats = useMemo(() => {
    const total = currentTabMistakes.length
    const dueCount = currentTabMistakes.filter((m) => isItemDue(m.dueAt)).length
    const needReview = currentTabMistakes.filter((m) => m.reviewStatus === 'need_review').length
    const reviewing = currentTabMistakes.filter((m) => m.reviewStatus === 'reviewing').length
    const mastered = currentTabMistakes.filter((m) => m.reviewStatus === 'mastered').length
    const lapsesCount = currentTabMistakes.filter((m) => (m.lapses || 0) > 0 || m.mistakeCount >= 2).length
    return { total, dueCount, needReview, reviewing, mastered, lapsesCount }
  }, [currentTabMistakes])

  // Lọc danh sách câu sai theo bộ lọc trạng thái & HSK
  const filteredMistakes = useMemo(() => {
    return currentTabMistakes.filter((m) => {
      // Lọc trạng thái
      if (statusFilter === 'due') {
        if (!isItemDue(m.dueAt)) return false
      } else if (statusFilter !== 'all') {
        if (m.reviewStatus !== statusFilter) return false
      }

      // Lọc HSK
      if (hskFilter !== 'all') {
        const lvl = extractHskLevel(m.exerciseId)
        if (lvl !== parseInt(hskFilter, 10)) return false
      }

      return true
    })
  }, [currentTabMistakes, statusFilter, hskFilter, extractHskLevel])

  // Phân trang danh sách câu
  const totalPages = Math.max(1, Math.ceil(filteredMistakes.length / itemsPerPage))
  const paginatedMistakes = useMemo(() => {
    const start = (page - 1) * itemsPerPage
    return filteredMistakes.slice(start, start + itemsPerPage)
  }, [filteredMistakes, page])

  useEffect(() => {
    setPage(1)
  }, [statusFilter, hskFilter, activeTab])

  // ==================== LOGIC PHIÊN ÔN TẬP SRS CHỦ ĐỘNG ====================

  const currentReviewItem = currentQueueIndex >= 0 ? activeQueue[currentQueueIndex] : null
  const currentReviewPracticeType = currentReviewItem ? getItemPracticeType(currentReviewItem) : activeTab

  // Đặt lại state cho câu ôn tập tiếp theo
  const resetReviewSentenceState = useCallback(() => {
    setUserInput('')
    userInputRef.current = ''
    practiceStatusRef.current = 'typing'
    setPracticeStatus('typing')
    setEvaluation(null)
    setHintLevel(0)
    setHintsUsedCount(0)
    setHadRetryCurrent(false)
    setShowListenMeaningHint(false)
    setShowListenLengthHint(false)
    ttsEngine.stop()
    setIsAudioPlaying(false)
    isComposingRef.current = false
    setIsComposing(false)
    justEndedCompositionRef.current = false
    setTimeout(() => {
      inputRef.current?.focus()
    }, 100)
  }, [])

  // Phát âm thanh TTS câu tiếng Trung mẫu
  const handlePlayAudio = useCallback((customRate?: TTSSpeedRate) => {
    if (!currentReviewItem?.sentenceZh) return
    const rateToUse = customRate ?? (currentReviewPracticeType === 'listen' ? listenSpeechRate : 1.0)

    if (isAudioPlaying) {
      ttsEngine.stop()
      setIsAudioPlaying(false)
      return
    }

    ttsEngine.stop()
    setIsAudioPlaying(true)
    ttsEngine.speak(currentReviewItem.sentenceZh, {
      id: `rev-${currentReviewItem.id}-${Date.now()}`,
      rate: rateToUse,
      onStart: () => setIsAudioPlaying(true),
      onEnd: () => setIsAudioPlaying(false),
      onError: () => setIsAudioPlaying(false),
    })
  }, [currentReviewItem, currentReviewPracticeType, listenSpeechRate, isAudioPlaying])

  // Tự động phát âm thanh câu mẫu khi chuyển câu trong chế độ Nghe & Gõ
  useEffect(() => {
    if (!currentReviewItem) return
    const itemType = getItemPracticeType(currentReviewItem)
    if (itemType === 'listen' && lastAutoSpokenMistakeIdRef.current !== currentReviewItem.id) {
      lastAutoSpokenMistakeIdRef.current = currentReviewItem.id
      const timer = setTimeout(() => {
        handlePlayAudio()
      }, 200)
      return () => clearTimeout(timer)
    }
  }, [currentReviewItem, getItemPracticeType, handlePlayAudio])

  // Bắt đầu ôn tập 1 câu đơn lẻ
  const startSingleReview = (item: TypingMistakeItem) => {
    setActiveQueue([item])
    setCurrentQueueIndex(0)
    setSessionCompleted(false)
    setSessionStats({ reviewedCount: 0, correctCount: 0, lapsedCount: 0 })
    resetReviewSentenceState()
  }

  // Bắt đầu ôn tập hàng đợi (chỉ ôn tập các câu thuộc Tab hiện tại)
  const startQueueReview = (mode: 'due_only' | 'all_filtered') => {
    let listToReview: TypingMistakeItem[] = []
    if (mode === 'due_only') {
      listToReview = currentTabMistakes.filter((m) => isItemDue(m.dueAt))
      if (listToReview.length === 0) {
        toast.info(
          activeTab === 'translate'
            ? 'Hiện không có câu Dịch nào đến hạn ôn hôm nay!'
            : 'Hiện không có câu Nghe & Gõ nào đến hạn ôn hôm nay!'
        )
        return
      }
    } else {
      listToReview = filteredMistakes.length > 0 ? filteredMistakes : currentTabMistakes
      if (listToReview.length === 0) {
        toast.info('Danh sách ôn tập đang trống!')
        return
      }
    }

    setActiveQueue(listToReview)
    setCurrentQueueIndex(0)
    setSessionCompleted(false)
    setSessionStats({ reviewedCount: 0, correctCount: 0, lapsedCount: 0 })
    resetReviewSentenceState()
  }

  // Thoát phiên ôn tập
  const exitReviewSession = () => {
    ttsEngine.stop()
    setCurrentQueueIndex(-1)
    setActiveQueue([])
    setSessionCompleted(false)
    loadMistakes()
  }

  // Mở thêm gợi ý trong chế độ Dịch
  const handleNextHint = useCallback(() => {
    if (hintLevel < 3) {
      const nextLvl = hintLevel + 1
      setHintLevel(nextLvl)
      setHintsUsedCount((prev) => Math.max(prev, nextLvl))
      playTypingSfx('correct', 0.04)
    }
  }, [hintLevel])

  // Xử lý kiểm tra đáp án gõ chữ Hán (Hỗ trợ cả Dịch và Nghe & Gõ)
  const handleCheckAnswer = useCallback(async () => {
    if (!currentReviewItem) return
    const curStatus = practiceStatusRef.current
    if (curStatus !== 'typing' && curStatus !== 'incorrect') return

    const rawVal = inputRef.current ? inputRef.current.value : userInputRef.current
    const val = (rawVal ?? '').trim()
    if (!val) return

    practiceStatusRef.current = 'checking'
    setPracticeStatus('checking')
    ttsEngine.stop()
    setIsAudioPlaying(false)

    // Đánh giá so khớp chuỗi chữ Hán
    const evalResult = evaluateTranslationInput(val, currentReviewItem.sentenceZh)
    setEvaluation(evalResult)

    if (evalResult.isExactMatch) {
      practiceStatusRef.current = 'correct'
      setPracticeStatus('correct')
      playTypingSfx('complete', 0.08)

      // Cập nhật thống kê phiên
      setSessionStats((prev) => ({
        ...prev,
        reviewedCount: prev.reviewedCount + 1,
        correctCount: prev.correctCount + 1,
      }))

      // Cập nhật SM-2 độc lập cho bản ghi câu này
      const srsOptions = {
        hintsUsed: currentReviewPracticeType === 'translate' ? hintsUsedCount : (showListenMeaningHint ? 1 : 0),
        hadRetry: hadRetryCurrent,
      }

      if (isLoggedIn && currentReviewItem.id && !currentReviewItem.id.startsWith('local-')) {
        updateMistakeReviewResultAction(currentReviewItem.id, true, srsOptions).catch(() => {})
      } else {
        updateLocalMistakeReview(currentReviewItem.id, true, srsOptions)
      }
    } else {
      practiceStatusRef.current = 'incorrect'
      setPracticeStatus('incorrect')
      setHadRetryCurrent(true)
      playTypingSfx('error', 0.06)

      // Ghi nhận trả lời sai vào SM-2
      const srsOptions = {
        hintsUsed: currentReviewPracticeType === 'translate' ? hintsUsedCount : (showListenMeaningHint ? 2 : 0),
        hadRetry: true,
      }

      if (isLoggedIn && currentReviewItem.id && !currentReviewItem.id.startsWith('local-')) {
        updateMistakeReviewResultAction(currentReviewItem.id, false, srsOptions).catch(() => {})
      } else {
        updateLocalMistakeReview(currentReviewItem.id, false, srsOptions)
      }

      setSessionStats((prev) => ({
        ...prev,
        lapsedCount: prev.lapsedCount + 1,
      }))
    }

    setTimeout(() => inputRef.current?.focus(), 50)
  }, [currentReviewItem, currentReviewPracticeType, hintsUsedCount, showListenMeaningHint, hadRetryCurrent, isLoggedIn])

  // Chuyển sang câu tiếp theo trong phiên ôn
  const handleNextSentence = useCallback((options?: { isSkipManual?: boolean }) => {
    if (practiceStatusRef.current === 'transitioning') return
    practiceStatusRef.current = 'transitioning'
    setPracticeStatus('transitioning')

    ttsEngine.stop()
    setIsAudioPlaying(false)

    // Nếu người dùng bấm bỏ qua khi chưa trả lời đúng: Ghi nhận là chưa nhớ
    if (options?.isSkipManual && currentReviewItem) {
      if (isLoggedIn && currentReviewItem.id && !currentReviewItem.id.startsWith('local-')) {
        updateMistakeReviewResultAction(currentReviewItem.id, false, { hintsUsed: 3, hadRetry: true }).catch(() => {})
      } else {
        updateLocalMistakeReview(currentReviewItem.id, false, { hintsUsed: 3, hadRetry: true })
      }
    }

    // Kiểm tra hết hàng đợi
    if (currentQueueIndex >= activeQueue.length - 1) {
      setSessionCompleted(true)
      return
    }

    setCurrentQueueIndex((prev) => prev + 1)
    resetReviewSentenceState()
  }, [currentQueueIndex, activeQueue.length, currentReviewItem, isLoggedIn, resetReviewSentenceState])

  // Xử lý bàn phím (5 tầng chống lỗi IME Enter)
  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.repeat) {
      if (e.key === 'Enter') e.preventDefault()
      return
    }

    // Chặn triệt để khi IME đang chọn chữ
    if (
      isComposing ||
      isComposingRef.current ||
      e.nativeEvent?.isComposing ||
      e.keyCode === 229 ||
      e.key === 'Process' ||
      justEndedCompositionRef.current
    ) {
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
      const curStatus = practiceStatusRef.current

      if (curStatus === 'typing' || curStatus === 'incorrect') {
        const textToCheck = (inputRef.current ? inputRef.current.value : userInputRef.current).trim()
        if (textToCheck.length > 0) {
          handleCheckAnswer()
        }
        return
      }

      if (curStatus === 'correct') {
        handleNextSentence()
        return
      }
    }
  }

  // Sự kiện Composition IME
  const handleCompositionStart = () => {
    isComposingRef.current = true
    setIsComposing(true)
    justEndedCompositionRef.current = false
    if (justEndedCompositionTimerRef.current) {
      clearTimeout(justEndedCompositionTimerRef.current)
      justEndedCompositionTimerRef.current = null
    }
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

    if (practiceStatusRef.current === 'incorrect' || practiceStatusRef.current === 'correct') {
      practiceStatusRef.current = 'typing'
      setPracticeStatus('typing')
      setEvaluation(null)
    }

    justEndedCompositionRef.current = true
    if (justEndedCompositionTimerRef.current) {
      clearTimeout(justEndedCompositionTimerRef.current)
    }
    justEndedCompositionTimerRef.current = setTimeout(() => {
      justEndedCompositionRef.current = false
    }, 120)
  }

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value
    userInputRef.current = val
    setUserInput(val)

    if (practiceStatusRef.current === 'incorrect' || practiceStatusRef.current === 'correct') {
      practiceStatusRef.current = 'typing'
      setPracticeStatus('typing')
      setEvaluation(null)
    }
  }

  // Chuyển đổi trạng thái câu thủ công trong Dashboard
  const handleToggleMastered = async (item: TypingMistakeItem, e?: React.MouseEvent) => {
    e?.stopPropagation()
    const nextStatus: ReviewStatus = item.reviewStatus === 'mastered' ? 'need_review' : 'mastered'

    if (isLoggedIn && item.id && !item.id.startsWith('local-')) {
      await updateMistakeStatusAction(item.id, nextStatus)
    } else {
      updateLocalMistakeStatus(item.id, nextStatus)
    }

    setMistakes((prev) =>
      prev.map((m) => (m.id === item.id ? { ...m, reviewStatus: nextStatus } : m))
    )
    toast.success(
      nextStatus === 'mastered'
        ? 'Đã chuyển thành "Đã thành thạo"'
        : 'Đã chuyển về "Cần ôn tập"'
    )
  }

  // ==================== VIEW 1: MÀN HÌNH TỔNG KẾT PHIÊN ÔN ====================
  if (sessionCompleted) {
    const isTrans = activeTab === 'translate'
    return (
      <div className="max-w-2xl mx-auto space-y-6 p-6 sm:p-8 bg-card border-2 border-[#E9DDD1] rounded-3xl shadow-sm text-center animate-in fade-in duration-300">
        <div className="w-16 h-16 mx-auto rounded-2xl bg-emerald-500/15 text-emerald-700 flex items-center justify-center">
          <Award className="w-8 h-8" />
        </div>

        <div className="space-y-2">
          <h2 className="text-xl sm:text-2xl font-serif font-bold text-title">
            Hoàn thành phiên ôn tập {isTrans ? 'Dịch Việt → Gõ Hán' : 'Nghe & Gõ'}!
          </h2>
          <p className="text-xs sm:text-sm text-muted font-serif max-w-md mx-auto">
            Các câu bạn trả lời đúng đã được thuật toán SM-2 tự động giãn cách lịch hẹn ôn tiếp theo độc lập cho chế độ này.
          </p>
        </div>

        {/* Khung chỉ số phiên */}
        <div className="grid grid-cols-3 gap-3 p-4 bg-page rounded-2xl border border-border">
          <div>
            <p className="text-xs text-muted font-serif">Đã ôn luyện</p>
            <p className="text-2xl font-serif font-bold text-title mt-1">{activeQueue.length}</p>
          </div>
          <div>
            <p className="text-xs text-emerald-700 dark:text-emerald-400 font-serif font-medium">Khớp chuẩn</p>
            <p className="text-2xl font-serif font-bold text-emerald-700 dark:text-emerald-400 mt-1">{sessionStats.correctCount}</p>
          </div>
          <div>
            <p className="text-xs text-amber-700 dark:text-amber-400 font-serif font-medium">Cần củng cố thêm</p>
            <p className="text-2xl font-serif font-bold text-amber-700 dark:text-amber-400 mt-1">{sessionStats.lapsedCount}</p>
          </div>
        </div>

        <div className="flex items-center justify-center gap-3 pt-2 flex-wrap">
          <button
            type="button"
            onClick={onBackToPractice}
            className="flex items-center gap-2 px-5 py-2.5 h-11 min-h-[44px] rounded-xl border-2 border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] text-title font-serif text-xs sm:text-sm transition-all shadow-2xs font-semibold cursor-pointer"
          >
            <ArrowLeft className="w-4 h-4 shrink-0" />
            <span>Quay lại luyện tập</span>
          </button>

          <button
            type="button"
            onClick={exitReviewSession}
            className="px-5 py-2.5 h-11 min-h-[44px] rounded-xl border border-[#E9DDD1] bg-card hover:bg-[#FFF9F3] text-title font-serif text-xs sm:text-sm transition-all cursor-pointer"
          >
            Danh sách câu sai
          </button>

          {stats.dueCount > 0 && (
            <button
              type="button"
              onClick={() => startQueueReview('due_only')}
              className="px-5 py-2.5 h-11 min-h-[44px] rounded-xl bg-[#B8322D] hover:bg-[#982923] text-white font-serif font-bold text-xs sm:text-sm transition-all shadow-2xs cursor-pointer"
            >
              Tiếp tục ôn {stats.dueCount} câu đến hạn
            </button>
          )}
        </div>
      </div>
    )
  }

  // ==================== VIEW 2: PHIÊN ÔN TẬP CHỦ ĐỘNG ====================
  if (currentReviewItem) {
    const isTransMode = currentReviewPracticeType === 'translate'
    const dueInfo = formatDueText(currentReviewItem.dueAt)
    const isAnswerRevealed = practiceStatus === 'correct' || practiceStatus === 'incorrect'

    return (
      <div className="space-y-4 max-w-4xl mx-auto select-text animate-in fade-in duration-300">
        {/* Header phiên ôn tập */}
        <div className="flex items-center justify-between gap-3 bg-card border border-[#E9DDD1] rounded-2xl p-3 sm:p-4 shadow-2xs">
          <button
            type="button"
            onClick={exitReviewSession}
            className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] text-xs font-serif text-title transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
            <span>Thoát</span>
          </button>

          <div className="flex items-center gap-2">
            <span className="text-xs font-serif font-semibold text-title">
              Câu {currentQueueIndex + 1} / {activeQueue.length}
            </span>
            <div className="w-20 sm:w-36 h-2 bg-page border border-border rounded-full overflow-hidden inline-block">
              <div
                className="h-full bg-[#B8322D] transition-all duration-300"
                style={{
                  width: `${((currentQueueIndex + 1) / activeQueue.length) * 100}%`,
                }}
              />
            </div>
          </div>

          <div className="flex items-center gap-1.5">
            <span className="text-[11px] font-sans px-2.5 py-1 rounded-full bg-page border border-[#E9DDD1] text-title font-medium flex items-center gap-1">
              {isTransMode ? (
                <>
                  <PenTool className="w-3 h-3 text-[#B8322D]" />
                  <span>Dịch Việt → Gõ Hán</span>
                </>
              ) : (
                <>
                  <Headphones className="w-3 h-3 text-[#B8322D]" />
                  <span>Nghe & Gõ</span>
                </>
              )}
            </span>
          </div>
        </div>

        {/* ================= KHỐI ĐỀ BÀI (TÁCH RIÊNG GIAO DIỆN GIỮA 2 CHẾ ĐỘ) ================= */}
        {isTransMode ? (
          /* A. GIAO DIỆN ĐỀ BÀI DỊCH VIỆT -> GÕ HÁN */
          <div className="bg-card border-2 border-[#E9DDD1] rounded-2xl p-4 sm:p-6 md:p-8 shadow-xs space-y-4">
            <div className="flex items-center justify-between gap-2 border-b border-border/60 pb-3">
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-app-accent" />
                <span className="text-xs font-serif font-medium text-muted">
                  Ôn tập Dịch — Chuyển ngữ câu tiếng Việt sang chữ Hán:
                </span>
              </div>
              {extractHskLevel(currentReviewItem.exerciseId) && (
                <span className="text-[11px] font-sans px-2 py-0.5 rounded-full bg-[#FFF9F3] border border-[#E9DDD1] text-title font-medium">
                  HSK {extractHskLevel(currentReviewItem.exerciseId)}
                </span>
              )}
            </div>

            {/* Câu tiếng Việt nổi bật làm đề bài */}
            <div className="py-2">
              <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#243047] leading-relaxed">
                &ldquo;{currentReviewItem.meaningVi || 'Hãy dịch câu sang chữ Hán'}&rdquo;
              </h2>
            </div>

            {/* Nút nghe âm thanh bổ trợ */}
            <div className="flex items-center justify-between gap-2 pt-2 border-t border-border/50 flex-wrap">
              <button
                type="button"
                onClick={() => handlePlayAudio()}
                className={`flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs md:text-sm font-serif font-medium transition-all active:scale-95 cursor-pointer touch-manipulation min-h-[44px] shadow-2xs ${
                  isAudioPlaying
                    ? 'bg-app-accent text-white shadow-sm'
                    : 'bg-[#FFF9F3] hover:bg-[#F6EDE3] border border-[#E9DDD1] text-[#243047]'
                }`}
                title="Nghe phát âm tiếng Trung của câu mẫu"
              >
                <Volume2 className={`w-4 h-4 shrink-0 ${isAudioPlaying ? 'animate-pulse' : 'text-app-accent'}`} />
                <span>{isAudioPlaying ? 'Đang phát...' : 'Nghe câu mẫu'}</span>
              </button>

              <span className="text-[11px] text-muted font-serif hidden sm:inline">
                💡 Tự chuyển ngữ bằng bộ gõ Pinyin IME để củng cố phản xạ
              </span>
            </div>
          </div>
        ) : (
          /* B. GIAO DIỆN ĐỀ BÀI NGHE & GÕ (MẶC ĐỊNH ẨN CHỮ HÁN TRƯỚC KHI TRẢ LỜI) */
          <div className="bg-card border-2 border-[#E9DDD1] rounded-2xl p-4 sm:p-6 md:p-8 shadow-xs space-y-5">
            <div className="flex items-center justify-between gap-2 border-b border-border/60 pb-3">
              <div className="flex items-center gap-2">
                <span className="w-2.5 h-2.5 rounded-full bg-emerald-500 animate-pulse" />
                <span className="text-xs font-serif font-bold text-title flex items-center gap-1.5">
                  <Headphones className="w-4 h-4 text-emerald-600" />
                  <span>Ôn tập Nghe & Gõ — Nghe âm thanh và gõ lại câu chữ Hán:</span>
                </span>
              </div>
              {extractHskLevel(currentReviewItem.exerciseId) && (
                <span className="text-[11px] font-sans px-2 py-0.5 rounded-full bg-[#FFF9F3] border border-[#E9DDD1] text-title font-medium">
                  HSK {extractHskLevel(currentReviewItem.exerciseId)}
                </span>
              )}
            </div>

            {/* Khối Âm thanh Trung tâm To Rõ */}
            <div className="p-5 sm:p-6 bg-page rounded-2xl border border-border flex flex-col items-center justify-center text-center space-y-4">
              <button
                type="button"
                onClick={() => handlePlayAudio()}
                className={`flex items-center gap-3 px-6 py-4 rounded-2xl text-base sm:text-lg font-serif font-bold transition-all active:scale-95 cursor-pointer touch-manipulation min-h-[56px] shadow-sm ${
                  isAudioPlaying
                    ? 'bg-emerald-600 text-white animate-pulse'
                    : 'bg-[#FFF9F3] hover:bg-[#F6EDE3] border-2 border-emerald-600/40 text-[#243047]'
                }`}
                title="Bấm để nghe âm thanh tiếng Trung"
              >
                <Volume2 className={`w-6 h-6 shrink-0 ${isAudioPlaying ? 'animate-bounce' : 'text-emerald-600'}`} />
                <span>{isAudioPlaying ? 'Đang phát âm thanh...' : '🎧 Bấm để nghe âm thanh câu'}</span>
              </button>

              {/* Tùy chỉnh tốc độ đọc */}
              <div className="flex items-center gap-2 pt-1">
                <span className="text-xs text-muted font-serif">Tốc độ đọc:</span>
                {( [0.8, 1.0, 1.2] as const ).map((r) => (
                  <button
                    key={r}
                    type="button"
                    onClick={() => {
                      setListenSpeechRate(r as TTSSpeedRate)
                      handlePlayAudio(r as TTSSpeedRate)
                    }}
                    className={`px-2.5 py-1 rounded-lg text-xs font-mono transition-all ${
                      listenSpeechRate === r
                        ? 'bg-[#243047] text-white font-bold'
                        : 'bg-card border border-border text-muted hover:text-title'
                    }`}
                  >
                    {r}x
                  </button>
                ))}
              </div>

              {/* Thẻ nhắc nhở ẩn chữ Hán */}
              {!isAnswerRevealed && (
                <div className="flex items-center gap-2 px-3 py-1.5 rounded-xl bg-amber-500/10 border border-amber-400/30 text-amber-800 dark:text-amber-300 text-xs font-serif">
                  <EyeOff className="w-3.5 h-3.5 shrink-0" />
                  <span>Mặt chữ Hán được ẩn mặc định để bạn rèn luyện phản xạ nghe trung thực.</span>
                </div>
              )}
            </div>

            {/* Các tùy chọn trợ giúp nhẹ trong chế độ nghe (không làm lộ đáp án chữ Hán) */}
            <div className="flex items-center justify-between gap-2 pt-2 border-t border-border/50 flex-wrap">
              <div className="flex items-center gap-2">
                {currentReviewItem.meaningVi && (
                  <button
                    type="button"
                    onClick={() => setShowListenMeaningHint((prev) => !prev)}
                    className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] text-xs font-serif text-[#243047] transition-all shadow-2xs"
                  >
                    {showListenMeaningHint ? <EyeOff className="w-3.5 h-3.5" /> : <Eye className="w-3.5 h-3.5 text-muted" />}
                    <span>{showListenMeaningHint ? 'Ẩn nghĩa tiếng Việt' : 'Xem gợi ý nghĩa (ngữ cảnh)'}</span>
                  </button>
                )}

                <button
                  type="button"
                  onClick={() => setShowListenLengthHint((prev) => !prev)}
                  className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] text-xs font-serif text-[#243047] transition-all shadow-2xs"
                >
                  <Lightbulb className="w-3.5 h-3.5 text-amber-600" />
                  <span>{showListenLengthHint ? 'Ẩn gợi ý độ dài' : 'Gợi ý số ký tự'}</span>
                </button>
              </div>

              {/* Gợi ý đã mở hiển thị ở đây */}
              <div className="text-xs font-serif text-muted">
                {showListenLengthHint && (
                  <span className="px-2.5 py-1 rounded-lg bg-page border border-border font-medium">
                    Câu có {currentReviewItem.sentenceZh.length} chữ Hán
                  </span>
                )}
              </div>
            </div>

            {showListenMeaningHint && currentReviewItem.meaningVi && (
              <div className="p-3 rounded-xl bg-amber-50/70 dark:bg-amber-950/20 border border-amber-200/60 text-xs sm:text-sm font-serif text-amber-900 dark:text-amber-200 animate-in fade-in duration-200">
                <strong>Nghĩa tiếng Việt gợi ý:</strong> &ldquo;{currentReviewItem.meaningVi}&rdquo;
              </div>
            )}
          </div>
        )}

        {/* Khối Gợi ý đa cấp cho chế độ Dịch */}
        {isTransMode && hintLevel > 0 && (
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
              {hintLevel >= 1 && (
                <div className="p-2.5 rounded-xl bg-white/80 dark:bg-amber-900/30 border border-amber-200/60 flex items-baseline gap-2">
                  <span className="text-amber-700 dark:text-amber-400 font-bold shrink-0">
                    Gợi ý 1 (Số ký tự):
                  </span>
                  <span className="text-body font-mono">
                    Câu chuẩn có {currentReviewItem.sentenceZh.length} ký tự chữ Hán.
                  </span>
                </div>
              )}

              {hintLevel >= 2 && currentReviewItem.pinyin && (
                <div className="p-2.5 rounded-xl bg-white/80 dark:bg-amber-900/30 border border-amber-200/60 flex items-baseline gap-2">
                  <span className="text-amber-700 dark:text-amber-400 font-bold shrink-0">
                    Gợi ý 2 (Pinyin):
                  </span>
                  <span className="text-title font-sans font-medium tracking-wide">
                    {currentReviewItem.pinyin}
                  </span>
                </div>
              )}

              {hintLevel >= 3 && (
                <div className="p-2.5 rounded-xl bg-white/80 dark:bg-amber-900/30 border border-amber-200/60 flex items-baseline gap-2">
                  <span className="text-amber-700 dark:text-amber-400 font-bold shrink-0">
                    Gợi ý 3 (Chữ Hán tham khảo):
                  </span>
                  <span className="text-lg font-bold text-[#243047]" style={{ fontFamily: 'var(--font-chinese), sans-serif' }}>
                    {currentReviewItem.sentenceZh}
                  </span>
                </div>
              )}
            </div>
          </div>
        )}

        {/* Ô nhập liệu chữ Hán Pinyin IME */}
        <div className="space-y-2">
          <div className="relative">
            <input
              ref={inputRef}
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
                  ? 'Đã khớp câu mẫu! Nhấn Enter để sang câu tiếp theo...'
                  : practiceStatus === 'incorrect'
                  ? 'Chưa chính xác. Chỉnh sửa câu của bạn rồi nhấn Enter...'
                  : isTransMode
                  ? 'Gõ Pinyin và chọn chữ Hán câu dịch, sau đó nhấn Enter để kiểm tra...'
                  : 'Nghe âm thanh và gõ chữ Hán, sau đó nhấn Enter để kiểm tra...'
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

            {isComposing && (
              <div className="absolute right-3 top-3.5 px-2.5 py-1 bg-amber-500/15 border border-amber-400/40 text-amber-700 dark:text-amber-400 rounded-lg text-xs font-sans flex items-center gap-1.5 animate-pulse select-none">
                <span className="w-2 h-2 rounded-full bg-amber-500" />
                <span>Đang chọn chữ ({compositionText || 'pinyin'})...</span>
              </div>
            )}

            {practiceStatus !== 'checking' && practiceStatus !== 'transitioning' && userInput.length > 0 && !isComposing && (
              <button
                type="button"
                onClick={() => {
                  setUserInput('')
                  userInputRef.current = ''
                  if (practiceStatus === 'incorrect' || practiceStatus === 'correct') {
                    practiceStatusRef.current = 'typing'
                    setPracticeStatus('typing')
                    setEvaluation(null)
                  }
                  inputRef.current?.focus()
                }}
                className="absolute right-3 top-3.5 p-1 rounded-full text-muted hover:text-title hover:bg-page transition-colors cursor-pointer"
                title="Xóa nội dung"
              >
                <X className="w-4 h-4" />
              </button>
            )}
          </div>

          <div className="flex items-center justify-between text-xs text-muted font-serif px-1 gap-2 flex-wrap">
            <span>
              Đã gõ: <strong className="text-title">{userInput.length}</strong> ký tự
            </span>
            <span className="flex items-center gap-1.5">
              <span>Phím tắt:</span>
              <kbd className="px-1.5 py-0.5 rounded bg-page border border-border font-mono text-[11px] shadow-2xs font-semibold">
                Enter
              </kbd>
              <span>{practiceStatus === 'correct' ? 'để sang câu tiếp' : 'để kiểm tra'}</span>
            </span>
          </div>
        </div>

        {/* Nút kiểm tra & Bỏ qua */}
        {practiceStatus === 'typing' && (
          <div className="flex items-center justify-between gap-2 pt-1">
            {isTransMode ? (
              <button
                type="button"
                onClick={handleNextHint}
                disabled={hintLevel >= 3}
                className="flex items-center gap-1.5 px-3.5 py-2.5 rounded-xl text-xs sm:text-sm font-serif font-medium bg-[#FFF9F3] border border-[#E9DDD1] hover:border-[#DDD0C2] text-[#243047] shadow-2xs min-h-[44px]"
              >
                <Lightbulb className="w-4 h-4 text-amber-500 shrink-0" />
                <span>{hintLevel === 0 ? 'Xem gợi ý' : `Gợi ý (${hintLevel}/3)`}</span>
              </button>
            ) : (
              <button
                type="button"
                onClick={() => handleNextSentence({ isSkipManual: true })}
                className="flex items-center gap-1.5 px-3.5 py-2.5 rounded-xl text-xs sm:text-sm font-serif font-medium bg-page border border-border hover:bg-[#F6EDE3] text-muted hover:text-title shadow-2xs min-h-[44px]"
                title="Bỏ qua câu này nếu không nghe ra được"
              >
                <span>Bỏ qua & Xem đáp án</span>
              </button>
            )}

            <button
              type="button"
              onClick={handleCheckAnswer}
              disabled={userInput.trim().length === 0}
              className="flex items-center gap-2 px-6 py-2.5 bg-[#B8322D] hover:bg-[#982923] disabled:opacity-40 text-white rounded-xl text-xs sm:text-sm font-serif font-semibold shadow-2xs min-h-[44px] ml-auto cursor-pointer"
            >
              <CheckCircle2 className="w-4 h-4 shrink-0" />
              <span>Kiểm tra</span>
            </button>
          </div>
        )}

        {/* Khối kết quả so khớp sau khi kiểm tra (Chữ Hán chuẩn & Diff Viewer) */}
        {(practiceStatus === 'correct' || practiceStatus === 'incorrect') && evaluation && (
          <div className="p-4 sm:p-6 bg-page border-2 border-[#E9DDD1] rounded-2xl space-y-4 animate-in fade-in duration-300 shadow-xs">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-border/80 pb-3">
              <div className="flex items-center gap-2.5">
                {evaluation.isExactMatch ? (
                  <div className="p-2 rounded-xl bg-emerald-500/15 text-emerald-700">
                    <CheckCircle2 className="w-5 h-5" />
                  </div>
                ) : (
                  <div className="p-2 rounded-xl bg-amber-500/15 text-amber-700">
                    <AlertCircle className="w-5 h-5" />
                  </div>
                )}
                <div>
                  <h3 className="text-base sm:text-lg font-serif font-bold text-title">
                    {evaluation.isExactMatch ? 'Khớp hoàn toàn câu mẫu chuẩn!' : 'Khác câu mẫu — Cần đối chiếu ký tự'}
                  </h3>
                  <p className="text-xs text-muted font-serif">
                    {evaluation.isExactMatch
                      ? 'Lịch ôn tập Spaced Repetition cho chế độ này đã được gia hạn tự động.'
                      : 'Hãy so sánh chi tiết ký tự bên dưới và nghe lại âm thanh để củng cố.'}
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-2 self-end sm:self-auto">
                <button
                  type="button"
                  onClick={() => handleNextSentence({ isSkipManual: !evaluation.isExactMatch })}
                  className="flex items-center gap-1.5 px-4 sm:px-5 py-2 bg-[#B8322D] hover:bg-[#982923] text-white rounded-xl text-xs sm:text-sm font-serif font-semibold shadow-2xs min-h-[44px] cursor-pointer"
                >
                  <span>{currentQueueIndex >= activeQueue.length - 1 ? 'Hoàn thành phiên' : 'Câu tiếp theo'}</span>
                  <ArrowRight className="w-4 h-4 shrink-0" />
                </button>
              </div>
            </div>

            {/* Diff Viewer trực quan */}
            <div className="space-y-3 bg-card border border-border/80 rounded-xl p-3 sm:p-4">
              <div className="space-y-1">
                <p className="text-xs text-muted font-serif font-semibold">Câu bạn vừa gõ:</p>
                <div
                  className="text-lg sm:text-xl font-serif leading-relaxed flex flex-wrap gap-1 items-baseline"
                  style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                >
                  {evaluation.diffTokens.map((token, i) => {
                    if (token.type === 'match') {
                      return (
                        <span key={i} className="bg-emerald-500/15 text-emerald-700 font-bold px-1 rounded">
                          {token.userInputChar}
                        </span>
                      )
                    }
                    return (
                      <span key={i} className="bg-amber-500/20 text-amber-800 font-bold px-1 rounded underline decoration-amber-500">
                        {token.userInputChar}
                      </span>
                    )
                  })}
                </div>
              </div>

              {/* Đáp án chữ Hán chuẩn & Pinyin (Mở ra sau khi kiểm tra) */}
              <div className="space-y-1.5 pt-2.5 border-t border-border/60">
                <div className="flex items-center justify-between">
                  <p className="text-xs text-muted font-serif font-semibold">Đáp án chữ Hán chuẩn:</p>
                  <button
                    type="button"
                    onClick={() => handlePlayAudio()}
                    className="flex items-center gap-1 text-xs text-app-accent font-serif hover:underline"
                  >
                    <Volume2 className="w-3.5 h-3.5" />
                    <span>Nghe lại để đối chiếu</span>
                  </button>
                </div>

                <div
                  className="text-lg sm:text-2xl font-bold text-[#243047] leading-relaxed"
                  style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                >
                  {currentReviewItem.sentenceZh}
                </div>

                {currentReviewItem.pinyin && (
                  <p className="text-xs sm:text-sm font-sans text-muted tracking-wide">
                    {currentReviewItem.pinyin}
                  </p>
                )}

                {currentReviewItem.meaningVi && (
                  <p className="text-xs sm:text-sm font-serif text-[#243047] pt-1">
                    Nghĩa: &ldquo;{currentReviewItem.meaningVi}&rdquo;
                  </p>
                )}
              </div>
            </div>
          </div>
        )}
      </div>
    )
  }

  // ==================== VIEW 3: BẢNG ĐIỀU KHIỂN & DANH SÁCH CÂU SAI ====================
  return (
    <div className="space-y-6 select-text animate-in fade-in duration-300">
      {/* Header & Nút hành động cho chế độ hiện tại */}
      <div className="bg-card border-2 border-[#E9DDD1] rounded-3xl p-5 sm:p-6 shadow-xs space-y-5">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="space-y-1">
            <h2 className="text-lg sm:text-xl font-serif font-bold text-[#243047] flex items-center gap-2">
              {isTrans ? (
                <PenTool className="w-5 h-5 text-[#B8322D] shrink-0" />
              ) : (
                <Headphones className="w-5 h-5 text-[#B8322D] shrink-0" />
              )}
              <span>
                {isTrans
                  ? 'Ôn câu sai — Dịch Việt → Gõ Hán'
                  : 'Ôn câu sai — Nghe & Gõ'}
              </span>
            </h2>
            <p className="text-xs sm:text-sm text-muted font-serif max-w-xl leading-relaxed">
              {isTrans
                ? 'Ôn lại các câu dịch từ tiếng Việt sang tiếng Trung chưa chính xác để củng cố phản xạ chuyển ngữ.'
                : 'Ôn lại các câu nghe hoặc gõ chưa chính xác để củng cố khả năng nghe hiểu và ghi nhớ chữ Hán.'}
            </p>
          </div>

          <div className="flex items-center gap-2.5 flex-wrap">
            <button
              type="button"
              onClick={onBackToPractice}
              className="flex items-center justify-center gap-2 px-4 py-2.5 h-11 min-h-[44px] rounded-xl border-2 border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] hover:border-[#DDD0C2] text-xs sm:text-sm font-serif font-semibold text-[#243047] transition-all shadow-2xs cursor-pointer active:scale-95"
            >
              <ArrowLeft className="w-4 h-4 shrink-0" />
              <span>Quay lại luyện tập</span>
            </button>

            <button
              type="button"
              onClick={() => startQueueReview('due_only')}
              disabled={stats.dueCount === 0}
              className="flex items-center justify-center gap-2 px-5 py-2.5 h-11 min-h-[44px] rounded-xl bg-[#B8322D] hover:bg-[#982923] disabled:opacity-40 disabled:cursor-not-allowed text-white text-xs sm:text-sm font-serif font-bold shadow-2xs transition-all active:scale-95 cursor-pointer"
            >
              <Clock className="w-4 h-4 shrink-0" />
              <span>Ôn các câu đến hạn</span>
              {stats.dueCount > 0 && (
                <span className="px-2 py-0.5 rounded-full text-xs font-sans font-bold bg-white text-[#B8322D] shrink-0">
                  {stats.dueCount}
                </span>
              )}
            </button>

            {stats.dueCount === 0 && filteredMistakes.length > 0 && (
              <button
                type="button"
                onClick={() => startQueueReview('all_filtered')}
                className="flex items-center justify-center gap-2 px-4 py-2.5 h-11 min-h-[44px] rounded-xl border border-[#E9DDD1] bg-card hover:bg-[#FFF9F3] text-[#243047] hover:text-[#B8322D] text-xs sm:text-sm font-serif font-semibold shadow-2xs transition-all cursor-pointer active:scale-95"
              >
                <Play className="w-3.5 h-3.5 fill-current shrink-0" />
                <span>Ôn toàn bộ ({filteredMistakes.length})</span>
              </button>
            )}
          </div>
        </div>

        {/* 4 Thẻ thống kê SRS riêng biệt */}
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 pt-2">
          {/* 1. Tổng số câu cần ôn */}
          <div
            onClick={() => setStatusFilter('all')}
            className={`p-3.5 sm:p-4 rounded-2xl border-2 transition-all cursor-pointer ${
              statusFilter === 'all'
                ? 'bg-[#FFF9F3] border-[#B8322D] shadow-2xs ring-1 ring-[#B8322D]/30'
                : 'bg-page/50 border-[#E9DDD1] hover:border-[#DDD0C2]'
            }`}
          >
            <p className="text-xs text-muted font-serif font-medium">Tổng số câu cần ôn</p>
            <p className="text-xl sm:text-2xl font-serif font-bold text-[#243047] mt-1">{stats.total}</p>
          </div>

          {/* 2. Số câu đến hạn hôm nay */}
          <div
            onClick={() => setStatusFilter('due')}
            className={`p-3.5 sm:p-4 rounded-2xl border-2 transition-all cursor-pointer ${
              statusFilter === 'due'
                ? 'bg-amber-500/10 border-amber-500 shadow-2xs ring-1 ring-amber-500/30'
                : 'bg-page/50 border-[#E9DDD1] hover:border-amber-400'
            }`}
          >
            <div className="flex items-center justify-between">
              <p className="text-xs text-amber-700 dark:text-amber-400 font-serif font-bold">
                Số câu đến hạn hôm nay
              </p>
              {stats.dueCount > 0 && (
                <span className="w-2 h-2 rounded-full bg-amber-500 animate-ping" />
              )}
            </div>
            <p className="text-xl sm:text-2xl font-serif font-bold text-amber-700 dark:text-amber-400 mt-1">
              {stats.dueCount}
            </p>
          </div>

          {/* 3. Số câu đã thành thạo */}
          <div
            onClick={() => setStatusFilter('mastered')}
            className={`p-3.5 sm:p-4 rounded-2xl border-2 transition-all cursor-pointer ${
              statusFilter === 'mastered'
                ? 'bg-emerald-500/10 border-emerald-500 shadow-2xs ring-1 ring-emerald-500/30'
                : 'bg-page/50 border-[#E9DDD1] hover:border-emerald-400'
            }`}
          >
            <p className="text-xs text-emerald-700 dark:text-emerald-400 font-serif font-medium">
              Số câu đã thành thạo
            </p>
            <p className="text-xl sm:text-2xl font-serif font-bold text-emerald-700 dark:text-emerald-400 mt-1">
              {stats.mastered}
            </p>
          </div>

          {/* 4. Số câu cần ôn lại sau khi trả lời sai */}
          <div
            onClick={() => setStatusFilter('need_review')}
            className={`p-3.5 sm:p-4 rounded-2xl border-2 transition-all cursor-pointer ${
              statusFilter === 'need_review'
                ? 'bg-red-500/10 border-red-500 shadow-2xs ring-1 ring-red-500/30'
                : 'bg-page/50 border-[#E9DDD1] hover:border-red-400'
            }`}
          >
            <p className="text-xs text-red-600 dark:text-red-400 font-serif font-medium">
              Số câu cần ôn lại sau khi trả lời sai
            </p>
            <p className="text-xl sm:text-2xl font-serif font-bold text-red-600 dark:text-red-400 mt-1">
              {stats.needReview}
            </p>
          </div>
        </div>
      </div>

      {/* 3. Thanh lọc theo Trạng thái & Cấp độ HSK */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-card border border-[#E9DDD1] rounded-2xl p-3 sm:p-4 shadow-2xs">
        {/* Lọc Trạng thái */}
        <div className="flex items-center gap-1.5 flex-wrap">
          <span className="text-xs text-muted font-serif flex items-center gap-1 mr-1">
            <Filter className="w-3.5 h-3.5" />
            <span>Xem:</span>
          </span>

          {[
            { id: 'all', label: 'Tất cả' },
            { id: 'due', label: `Đến hạn (${stats.dueCount})` },
            { id: 'need_review', label: 'Chưa nhớ' },
            { id: 'reviewing', label: 'Đang ôn' },
            { id: 'mastered', label: 'Đã nhớ' },
          ].map((item) => (
            <button
              key={item.id}
              type="button"
              onClick={() => setStatusFilter(item.id as ReviewFilterStatus)}
              className={`px-3 py-1.5 rounded-xl text-xs font-serif transition-colors cursor-pointer min-h-[36px] ${
                statusFilter === item.id
                  ? 'bg-[#B8322D] text-white font-semibold shadow-2xs'
                  : 'bg-page border border-border text-muted hover:text-title hover:bg-[#FFF9F3]'
              }`}
            >
              {item.label}
            </button>
          ))}
        </div>

        {/* Lọc Cấp HSK 1 - 6 */}
        <div className="flex items-center gap-1 flex-wrap">
          <span className="text-xs text-muted font-serif mr-1">HSK:</span>
          {(['all', '1', '2', '3', '4', '5', '6'] as const).map((lvl) => (
            <button
              key={lvl}
              type="button"
              onClick={() => setHskFilter(lvl)}
              className={`px-2.5 py-1 rounded-xl text-xs font-serif transition-colors cursor-pointer min-h-[36px] ${
                hskFilter === lvl
                  ? 'bg-[#B8322D] text-white font-semibold shadow-2xs'
                  : 'bg-page border border-border text-muted hover:text-title hover:bg-[#FFF9F3]'
              }`}
            >
              {lvl === 'all' ? 'Tất cả' : `HSK ${lvl}`}
            </button>
          ))}
        </div>
      </div>

      {/* 4. Danh sách câu sai */}
      {isLoading ? (
        <div className="p-12 text-center text-muted font-serif text-sm bg-card border-2 border-[#E9DDD1] rounded-3xl space-y-3 shadow-xs">
          <Loader2 className="w-6 h-6 animate-spin mx-auto text-[#B8322D]" />
          <p>Đang tải danh sách câu sai của chế độ {isTrans ? 'Dịch Việt → Gõ Hán' : 'Nghe & Gõ'}...</p>
        </div>
      ) : loadError && currentTabMistakes.length === 0 ? (
        <div className="p-8 bg-card border-2 border-red-200 rounded-3xl text-center space-y-3 shadow-xs">
          <AlertCircle className="w-8 h-8 text-red-500 mx-auto" />
          <p className="text-sm font-serif text-red-600">{loadError}</p>
          <div className="flex items-center justify-center gap-3 pt-1">
            <button
              type="button"
              onClick={loadMistakes}
              className="px-4 py-2 rounded-xl bg-[#B8322D] text-white text-xs font-serif font-semibold cursor-pointer"
            >
              Thử lại
            </button>
            <button
              type="button"
              onClick={onBackToPractice}
              className="px-4 py-2 rounded-xl border border-[#E9DDD1] bg-[#FFF9F3] text-xs font-serif text-[#243047] cursor-pointer"
            >
              Quay lại luyện tập
            </button>
          </div>
        </div>
      ) : currentTabMistakes.length === 0 ? (
        <div className="p-12 bg-card border-2 border-[#E9DDD1] rounded-3xl text-center space-y-4 shadow-xs">
          <div className="w-14 h-14 mx-auto rounded-2xl bg-emerald-500/10 text-emerald-600 flex items-center justify-center">
            <CheckCircle2 className="w-7 h-7" />
          </div>
          <div className="space-y-1.5">
            <h3 className="font-serif font-bold text-lg text-title">
              Bạn chưa có câu sai cần ôn ở chế độ này
            </h3>
            <p className="text-xs sm:text-sm text-muted font-serif max-w-md mx-auto leading-relaxed">
              {isTrans
                ? 'Khi bạn luyện dịch trong chế độ "Dịch Việt → Gõ Hán", những câu bạn dịch hoặc gõ chữ Hán khác câu mẫu sẽ được tự động lưu vào đây để ôn tập.'
                : 'Khi bạn luyện nghe trong chế độ "Nghe & Gõ", những câu bạn nghe hoặc gõ chưa chính xác sẽ được tự động lưu vào đây để ôn tập.'}
            </p>
          </div>
          <div className="pt-2">
            <button
              type="button"
              onClick={onBackToPractice}
              className="inline-flex items-center gap-2 px-5 py-2.5 h-11 min-h-[44px] rounded-xl bg-[#B8322D] hover:bg-[#982923] text-white font-serif font-semibold text-xs sm:text-sm shadow-2xs transition-all active:scale-95 cursor-pointer"
            >
              <ArrowLeft className="w-4 h-4 shrink-0" />
              <span>Quay lại luyện tập</span>
            </button>
          </div>
        </div>
      ) : filteredMistakes.length === 0 ? (
        <div className="p-10 bg-card border-2 border-[#E9DDD1] rounded-3xl text-center space-y-3 shadow-xs">
          <p className="font-serif font-bold text-base text-title">
            Không có câu nào khớp với bộ lọc hiện tại.
          </p>
          <button
            type="button"
            onClick={() => {
              setStatusFilter('all')
              setHskFilter('all')
            }}
            className="px-4 py-2 rounded-xl border border-[#E9DDD1] bg-[#FFF9F3] text-xs font-serif text-[#243047] cursor-pointer"
          >
            Xem tất cả ({currentTabMistakes.length} câu)
          </button>
        </div>
      ) : (
        <div className="space-y-3.5">
          {paginatedMistakes.map((item) => {
            const hskLevel = extractHskLevel(item.exerciseId)
            const dueInfo = formatDueText(item.dueAt)
            const itemType = getItemPracticeType(item)

            return (
              <div
                key={item.id}
                className="bg-card border-2 border-[#E9DDD1] hover:border-app-accent/50 rounded-2xl p-4 sm:p-5 shadow-2xs hover:shadow-xs transition-all space-y-3"
              >
                <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-3">
                  <div className="space-y-2 flex-1">
                    {/* Hàng badges: Phân loại, HSK, Lịch hẹn ôn, Trạng thái */}
                    <div className="flex items-center gap-2 flex-wrap">
                      <span className="px-2 py-0.5 rounded-md text-[11px] font-sans font-bold bg-[#FFF9F3] text-title border border-[#E9DDD1] flex items-center gap-1">
                        {itemType === 'translate' ? (
                          <>
                            <PenTool className="w-3 h-3 text-[#B8322D]" />
                            <span>Dịch câu</span>
                          </>
                        ) : (
                          <>
                            <Headphones className="w-3 h-3 text-[#B8322D]" />
                            <span>Nghe & Gõ</span>
                          </>
                        )}
                      </span>

                      {hskLevel && (
                        <span className="px-2 py-0.5 rounded-md text-[11px] font-sans font-bold bg-[#FFF9F3] text-title border border-[#E9DDD1]">
                          HSK {hskLevel}
                        </span>
                      )}

                      {/* Badge lịch đến hạn Spaced Repetition */}
                      <span
                        className={`px-2.5 py-0.5 rounded-md text-[11px] font-sans font-semibold border flex items-center gap-1 ${
                          dueInfo.isOverdue || dueInfo.isToday
                            ? 'bg-amber-500/15 text-amber-800 dark:text-amber-300 border-amber-400/50 animate-pulse'
                            : 'bg-page text-muted border-border'
                        }`}
                      >
                        <Clock className="w-3 h-3" />
                        <span>{dueInfo.text}</span>
                      </span>

                      {/* Badge trạng thái */}
                      {item.reviewStatus === 'need_review' && (
                        <span className="px-2 py-0.5 rounded-md text-[11px] font-sans font-semibold bg-red-500/15 text-red-600 dark:text-red-400 border border-red-500/20">
                          Chưa nhớ
                        </span>
                      )}
                      {item.reviewStatus === 'reviewing' && (
                        <span className="px-2 py-0.5 rounded-md text-[11px] font-sans font-semibold bg-amber-500/15 text-amber-700 dark:text-amber-400 border border-amber-500/20">
                          Đang ôn ({item.consecutiveCorrect || 0} lần đúng)
                        </span>
                      )}
                      {item.reviewStatus === 'mastered' && (
                        <span className="px-2 py-0.5 rounded-md text-[11px] font-sans font-semibold bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 border border-emerald-500/20">
                          Đã nhớ thành thạo
                        </span>
                      )}

                      <span className="text-xs text-muted font-serif">
                        • Sai {item.mistakeCount} lần
                      </span>
                      {item.intervalDays !== undefined && item.intervalDays > 0 && (
                        <span className="text-xs text-muted font-serif">
                          • Giãn cách: {item.intervalDays} ngày
                        </span>
                      )}
                    </div>

                    {/* Câu tiếng Việt */}
                    {item.meaningVi && (
                      <p className="text-base sm:text-lg font-serif font-bold text-[#243047] leading-relaxed">
                        &ldquo;{item.meaningVi}&rdquo;
                      </p>
                    )}

                    {/* Câu chữ Hán chuẩn */}
                    <div className="pt-1 space-y-1">
                      <p
                        className="text-lg sm:text-xl font-serif font-bold text-[#243047]"
                        style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                      >
                        {item.sentenceZh}
                      </p>
                      {item.pinyin && (
                        <p className="text-xs sm:text-sm text-muted font-sans tracking-wide">
                          {item.pinyin}
                        </p>
                      )}
                    </div>

                    {/* Ghi chú lần gõ sai gần nhất */}
                    {item.lastInputZh && (
                      <div className="pt-1.5 text-xs font-serif flex items-center gap-2">
                        <span className="text-muted">Đã gõ sai gần nhất:</span>
                        <span className="text-red-600 font-semibold line-through bg-red-500/10 px-2 py-0.5 rounded">
                          {item.lastInputZh}
                        </span>
                      </div>
                    )}
                  </div>

                  {/* Cụm nút hành động cho từng câu */}
                  <div className="flex items-center gap-2 self-end sm:self-start shrink-0 pt-1">
                    <AudioButton
                      text={item.sentenceZh}
                      id={`list-audio-${item.id}`}
                      size="sm"
                      variant="ghost"
                      tooltip="Nghe phát âm tiếng Trung"
                    />

                    <button
                      type="button"
                      onClick={(e) => handleToggleMastered(item, e)}
                      className="p-2 min-h-[40px] min-w-[40px] flex items-center justify-center rounded-xl border border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] text-title text-xs transition-colors shadow-2xs"
                      title={
                        item.reviewStatus === 'mastered'
                          ? 'Đánh dấu Cần ôn lại'
                          : 'Đánh dấu Đã thành thạo'
                      }
                    >
                      {item.reviewStatus === 'mastered' ? (
                        <RotateCcw className="w-4 h-4 text-muted" />
                      ) : (
                        <Check className="w-4 h-4 text-emerald-600" />
                      )}
                    </button>

                    <button
                      type="button"
                      onClick={() => startSingleReview(item)}
                      className="flex items-center gap-1.5 px-4 py-2 min-h-[40px] rounded-xl bg-[#B8322D] hover:bg-[#982923] text-white text-xs sm:text-sm font-serif font-semibold shadow-2xs transition-all active:scale-95"
                    >
                      <Play className="w-3.5 h-3.5 fill-current" />
                      <span>Ôn câu này</span>
                    </button>
                  </div>
                </div>
              </div>
            )
          })}

          {/* Phân trang (Pagination) */}
          {totalPages > 1 && (
            <div className="flex items-center justify-between gap-3 pt-3 px-1 text-xs font-serif text-muted">
              <span>
                Hiển thị {(page - 1) * itemsPerPage + 1} -{' '}
                {Math.min(page * itemsPerPage, filteredMistakes.length)} trên tổng số{' '}
                {filteredMistakes.length} câu
              </span>

              <div className="flex items-center gap-1">
                <button
                  type="button"
                  onClick={() => setPage((p) => Math.max(1, p - 1))}
                  disabled={page === 1}
                  className="p-1.5 rounded-lg border border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] disabled:opacity-30 disabled:cursor-not-allowed"
                >
                  <ChevronLeft className="w-4 h-4" />
                </button>
                <span className="px-2 font-mono font-semibold text-title">
                  {page} / {totalPages}
                </span>
                <button
                  type="button"
                  onClick={() => setPage((p) => Math.min(totalPages, p + 1))}
                  disabled={page === totalPages}
                  className="p-1.5 rounded-lg border border-[#E9DDD1] bg-[#FFF9F3] hover:bg-[#F6EDE3] disabled:opacity-30 disabled:cursor-not-allowed"
                >
                  <ChevronRight className="w-4 h-4" />
                </button>
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  )
}
