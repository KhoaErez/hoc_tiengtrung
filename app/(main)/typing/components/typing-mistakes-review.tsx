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
import { playTypingSfx, speakChineseCharacter } from '@/lib/typing-sound'
import { AudioButton } from '@/components/ui/audio-button'
import { Button } from '@/components/ui/button'
import {
  CheckCircle2,
  XCircle,
  RotateCcw,
  Sparkles,
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
} from 'lucide-react'
import { toast } from 'sonner'

// Hàm chuẩn hóa ký tự dấu câu
function normalizeChar(char: string): string {
  if (!char) return ''
  const punctuationMap: Record<string, string> = {
    '，': ',',
    '。': '.',
    '！': '!',
    '？': '?',
    '：': ':',
    '；': ';',
    '“': '"',
    '”': '"',
    '‘': "'",
    '’': "'",
    '（': '(',
    '）': ')',
    '【': '[',
    '】': ']',
    '、': ',',
  }
  return punctuationMap[char] || char
}

function isCharMatch(c1: string, c2: string, allowNormalize = true): boolean {
  if (!c1 || !c2) return false
  if (c1 === c2) return true
  if (allowNormalize) {
    return normalizeChar(c1) === normalizeChar(c2)
  }
  return false
}

interface TypingMistakesReviewProps {
  isLoggedIn: boolean
  onBackToPractice?: () => void
}

export default function TypingMistakesReview({
  isLoggedIn,
  onBackToPractice,
}: TypingMistakesReviewProps) {
  const [mistakes, setMistakes] = useState<TypingMistakeItem[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [statusFilter, setStatusFilter] = useState<ReviewStatus | 'all'>('all')
  const [modeFilter, setModeFilter] = useState<string>('all')
  const [hskFilter, setHskFilter] = useState<'all' | '1' | '2' | '3' | '4' | '5' | '6'>('all')

  // Helper trích xuất cấp độ HSK từ exerciseId
  const extractHskLevel = (exerciseId: string): number | null => {
    if (!exerciseId) return null
    const match = exerciseId.match(/hsk-?(\d)/i)
    if (match) return parseInt(match[1], 10)
    return null
  }

  // Trạng thái luyện tập ôn tập (Active Review Session)
  const [activeQueue, setActiveQueue] = useState<TypingMistakeItem[]>([])
  const [currentQueueIndex, setCurrentQueueIndex] = useState<number>(-1)
  const [userInput, setUserInput] = useState('')
  const [isComposing, setIsComposing] = useState(false)
  const [isCompleted, setIsCompleted] = useState(false)
  const [showPinyin, setShowPinyin] = useState(true)
  const [showMeaning, setShowMeaning] = useState(true)
  const inputRef = useRef<HTMLInputElement | null>(null)
  const isComposingRef = useRef(false)
  const committedLengthRef = useRef(0)

  // 1. Tải danh sách câu sai (từ Supabase nếu đăng nhập, từ Local nếu chưa đăng nhập)
  const loadMistakes = useCallback(async () => {
    setIsLoading(true)
    try {
      if (isLoggedIn) {
        const res = await getTypingMistakesAction()
        if (res.success && res.mistakes) {
          setMistakes(res.mistakes as TypingMistakeItem[])
          setIsLoading(false)
          return
        }
      }
      // Fallback local
      const localList = getLocalTypingMistakes()
      setMistakes(localList)
    } catch {
      const localList = getLocalTypingMistakes()
      setMistakes(localList)
    } finally {
      setIsLoading(false)
    }
  }, [isLoggedIn])

  useEffect(() => {
    loadMistakes()
  }, [loadMistakes])

  // Thống kê phân loại
  const stats = useMemo(() => {
    const total = mistakes.length
    const needReview = mistakes.filter((m) => m.reviewStatus === 'need_review').length
    const reviewing = mistakes.filter((m) => m.reviewStatus === 'reviewing').length
    const mastered = mistakes.filter((m) => m.reviewStatus === 'mastered').length
    return { total, needReview, reviewing, mastered }
  }, [mistakes])

  // Danh sách đã lọc theo trạng thái, chế độ và cấp độ HSK
  const filteredMistakes = useMemo(() => {
    return mistakes.filter((m) => {
      if (statusFilter !== 'all' && m.reviewStatus !== statusFilter) return false
      if (modeFilter !== 'all' && m.mode !== modeFilter) return false
      if (hskFilter !== 'all') {
        const lvl = extractHskLevel(m.exerciseId)
        if (lvl !== parseInt(hskFilter, 10)) return false
      }
      return true
    })
  }, [mistakes, statusFilter, modeFilter, hskFilter])

  // Câu đang ôn tập trong hàng đợi
  const currentReviewItem = currentQueueIndex >= 0 ? activeQueue[currentQueueIndex] : null

  // Đánh giá so khớp cho câu đang ôn
  const currentEvaluation = useMemo(() => {
    if (!currentReviewItem) return { isCorrect: false, errors: [] }
    const target = currentReviewItem.sentenceZh
    const input = userInput
    const errors: { index: number; expected: string; actual: string }[] = []

    for (let i = 0; i < input.length; i++) {
      if (i < target.length) {
        if (!isCharMatch(input[i], target[i], true)) {
          errors.push({ index: i + 1, expected: target[i], actual: input[i] })
        }
      } else {
        errors.push({ index: i + 1, expected: '(thừa)', actual: input[i] })
      }
    }

    const isMatchLength = input.length === target.length
    const isCorrect = isMatchLength && errors.length === 0
    return { isCorrect, errors }
  }, [currentReviewItem, userInput])

  // Bắt đầu ôn tập 1 câu đơn lẻ
  const startSingleReview = (item: TypingMistakeItem) => {
    setActiveQueue([item])
    setCurrentQueueIndex(0)
    setUserInput('')
    setIsCompleted(false)
    committedLengthRef.current = 0
    setTimeout(() => inputRef.current?.focus(), 100)
  }

  // Bắt đầu ôn tập toàn bộ danh sách hiện tại
  const startQueueReview = () => {
    const candidates = filteredMistakes.filter((m) => m.reviewStatus !== 'mastered')
    const listToReview = candidates.length > 0 ? candidates : filteredMistakes
    if (listToReview.length === 0) {
      toast.info('Không có câu nào cần ôn tập!')
      return
    }
    setActiveQueue(listToReview)
    setCurrentQueueIndex(0)
    setUserInput('')
    setIsCompleted(false)
    committedLengthRef.current = 0
    setTimeout(() => inputRef.current?.focus(), 100)
  }

  // Thoát chế độ luyện tập, quay lại danh sách
  const exitReviewSession = () => {
    setCurrentQueueIndex(-1)
    setActiveQueue([])
    setUserInput('')
    setIsCompleted(false)
    loadMistakes()
  }

  // Xử lý nộp kết quả ôn tập
  const handleSubmitReview = async () => {
    if (!currentReviewItem || isCompleted) return
    setIsCompleted(true)
    const isAllCorrect = currentEvaluation.isCorrect

    playTypingSfx(isAllCorrect ? 'complete' : 'error')

    // Lưu kết quả ôn tập lên server hoặc local
    if (isLoggedIn && currentReviewItem.id && !currentReviewItem.id.startsWith('local-')) {
      await updateMistakeReviewResultAction(currentReviewItem.id, isAllCorrect)
    } else {
      updateLocalMistakeReview(currentReviewItem.id, isAllCorrect)
    }

    if (isAllCorrect) {
      toast.success('Xuất sắc! Bạn đã gõ chính xác 100% câu này!')
    } else {
      toast.warning('Chưa chính xác! Hãy kiểm tra các ký tự sai bên dưới.')
    }
  }

  // Chuyển sang câu tiếp theo trong hàng đợi ôn tập
  const handleNextInQueue = () => {
    if (currentQueueIndex + 1 < activeQueue.length) {
      setCurrentQueueIndex((prev) => prev + 1)
      setUserInput('')
      setIsCompleted(false)
      committedLengthRef.current = 0
      setTimeout(() => inputRef.current?.focus(), 100)
    } else {
      toast.success('Đã hoàn thành lượt ôn tập các câu sai!')
      exitReviewSession()
    }
  }

  // Chuyển thủ công trạng thái thành thạo / cần ôn
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

  // Xử lý nhập liệu IME cho câu đang ôn
  const handleCommittedText = (newVal: string) => {
    const prevLen = committedLengthRef.current
    const newLen = newVal.length
    committedLengthRef.current = newLen
    setUserInput(newVal)

    if (newLen > prevLen && currentReviewItem) {
      let isMatch = true
      for (let i = prevLen; i < newLen; i++) {
        const targetChar = currentReviewItem.sentenceZh[i]
        if (!targetChar || !isCharMatch(newVal[i], targetChar, true)) {
          isMatch = false
        }
      }
      playTypingSfx(isMatch ? 'correct' : 'error')

      // TTS âm tiết vừa gõ
      const typed = newVal.slice(prevLen, newLen)
      if (typed.trim()) {
        speakChineseCharacter(typed)
      }
    }

    // Tự động kiểm tra khi gõ đủ độ dài
    if (currentReviewItem && newLen >= currentReviewItem.sentenceZh.length) {
      handleSubmitReview()
    }
  }

  // Đang ở trong phiên gõ ôn tập
  if (currentReviewItem) {
    return (
      <div className="space-y-6 animate-in fade-in duration-300">
        {/* Thanh header phiên ôn tập */}
        <div className="flex items-center justify-between gap-3 bg-card border border-border rounded-xl p-3 shadow-xs">
          <button
            onClick={exitReviewSession}
            className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg border border-border text-muted hover:text-title hover:bg-page text-xs font-serif transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
            <span>Thoát ôn tập</span>
          </button>

          <div className="flex items-center gap-2">
            <span className="text-xs text-muted font-sans">
              Câu {currentQueueIndex + 1} / {activeQueue.length}
            </span>
            <span className="w-24 h-2 bg-page border border-border rounded-full overflow-hidden inline-block">
              <span
                className="h-full bg-app-accent block transition-all duration-300"
                style={{
                  width: `${((currentQueueIndex + 1) / activeQueue.length) * 100}%`,
                }}
              />
            </span>
          </div>

          <div className="flex items-center gap-1.5">
            <button
              onClick={() => setShowPinyin(!showPinyin)}
              className={`px-2 py-1 rounded text-xs font-serif border ${
                showPinyin
                  ? 'bg-accent-soft text-app-accent border-app-accent/30 font-medium'
                  : 'bg-page text-muted border-border'
              }`}
            >
              Pinyin
            </button>
            <button
              onClick={() => setShowMeaning(!showMeaning)}
              className={`px-2 py-1 rounded text-xs font-serif border ${
                showMeaning
                  ? 'bg-accent-soft text-app-accent border-app-accent/30 font-medium'
                  : 'bg-page text-muted border-border'
              }`}
            >
              Nghĩa
            </button>
          </div>
        </div>

        {/* Thẻ câu ôn tập */}
        <div className="bg-card border border-border rounded-2xl p-6 md:p-8 shadow-sm space-y-6">
          <div className="flex items-center justify-between text-xs text-muted font-serif">
            <div className="flex items-center gap-2">
              <span className="px-2 py-0.5 rounded bg-page border border-border font-medium text-title">
                {currentReviewItem.mode === 'sentence'
                  ? 'Câu mẫu'
                  : currentReviewItem.mode === 'paragraph'
                  ? 'Đoạn văn'
                  : currentReviewItem.mode === 'vocabulary'
                  ? 'Từ vựng'
                  : currentReviewItem.mode === 'hsk'
                  ? 'Theo HSK'
                  : 'Tự tạo'}
              </span>
              <span>Đã sai: {currentReviewItem.mistakeCount} lần</span>
              <span>• Chuỗi đúng: {currentReviewItem.consecutiveCorrect}/2</span>
            </div>

            <AudioButton
              text={currentReviewItem.sentenceZh}
              id={`review-item-${currentReviewItem.id}`}
              size="sm"
              variant="subtle"
              showLabel
              label="Nghe đọc mẫu"
            />
          </div>

          {/* Vùng hiển thị câu mục tiêu */}
          <div className="space-y-3 bg-page/70 border border-border/70 rounded-xl p-5 md:p-6">
            {showPinyin && currentReviewItem.pinyin && (
              <p className="text-sm md:text-base text-muted font-sans tracking-wide">
                {currentReviewItem.pinyin}
              </p>
            )}

            {/* Dòng chữ Hán mục tiêu với tô màu realtime */}
            <div
              className="font-serif text-2xl md:text-4xl tracking-normal leading-relaxed select-none"
              style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
            >
              {currentReviewItem.sentenceZh.split('').map((char, idx) => {
                const typedChar = userInput[idx]
                const isCurrent = idx === userInput.length && !isCompleted
                let statusClasses = 'text-title/80'

                if (idx < userInput.length) {
                  if (isCharMatch(typedChar, char, true)) {
                    statusClasses = 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 rounded px-0.5'
                  } else {
                    statusClasses = 'bg-red-500/20 text-red-600 dark:text-red-400 rounded px-0.5 underline decoration-red-500 font-bold'
                  }
                } else if (isCurrent) {
                  statusClasses = 'border-b-2 border-app-accent bg-accent-soft/40 text-title font-bold animate-pulse'
                }

                return (
                  <span key={idx} className={`inline-block transition-colors ${statusClasses}`}>
                    {char}
                  </span>
                )
              })}
            </div>

            {showMeaning && currentReviewItem.meaningVi && (
              <p className="text-xs md:text-sm text-body/90 font-serif italic pt-1 border-t border-border/50">
                Ý nghĩa: {currentReviewItem.meaningVi}
              </p>
            )}
          </div>

          {/* Lỗi lần trước để rút kinh nghiệm */}
          {currentReviewItem.lastInputZh && (
            <div className="p-3 bg-red-500/5 border border-red-500/20 rounded-xl text-xs font-serif flex items-center gap-2">
              <AlertCircle className="w-4 h-4 text-red-500 shrink-0" />
              <div>
                <span className="text-muted">Lần trước bạn đã gõ: </span>
                <span className="text-red-600 font-semibold line-through">
                  {currentReviewItem.lastInputZh}
                </span>
              </div>
            </div>
          )}

          {/* Ô nhập liệu IME tiếng Trung */}
          <div className="space-y-2">
            <div className="relative">
              <input
                ref={inputRef}
                type="text"
                value={userInput}
                onChange={(e) => {
                  if (isComposingRef.current) {
                    setUserInput(e.target.value)
                    return
                  }
                  handleCommittedText(e.target.value)
                }}
                onCompositionStart={() => {
                  isComposingRef.current = true
                  setIsComposing(true)
                }}
                onCompositionEnd={(e) => {
                  isComposingRef.current = false
                  setIsComposing(false)
                  handleCommittedText((e.target as HTMLInputElement).value)
                }}
                disabled={isCompleted}
                autoComplete="off"
                autoCorrect="off"
                spellCheck="false"
                placeholder={
                  isCompleted
                    ? 'Đã hoàn thành câu ôn tập!'
                    : 'Gõ Pinyin và chọn chữ Hán chính xác...'
                }
                className="w-full px-4 py-3.5 bg-card border-2 border-border focus:border-app-accent rounded-xl text-lg md:text-2xl font-serif text-title placeholder:text-muted placeholder:text-sm focus:outline-none transition-colors shadow-inner"
                style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
              />

              {isComposing && (
                <div className="absolute right-3 top-3 px-2 py-1 bg-amber-500/15 border border-amber-400/30 text-amber-700 dark:text-amber-400 rounded-md text-xs font-sans animate-pulse">
                  Đang chọn chữ IME...
                </div>
              )}
            </div>

            <div className="flex items-center justify-between text-xs text-muted font-serif px-1">
              <span>
                Đã gõ: <strong className="text-title">{userInput.length}</strong> /{' '}
                {currentReviewItem.sentenceZh.length} ký tự
              </span>
              <span>Bấm phím Enter để kiểm tra hoặc chuyển câu</span>
            </div>
          </div>

          {/* Bảng tổng kết câu vừa ôn */}
          {isCompleted && (
            <div className="p-4 bg-page border border-border rounded-xl space-y-3 animate-in fade-in duration-200">
              <div className="flex items-center justify-between gap-3">
                <div className="flex items-center gap-2">
                  {currentEvaluation.isCorrect ? (
                    <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                  ) : (
                    <XCircle className="w-5 h-5 text-red-500" />
                  )}
                  <span className="font-serif font-bold text-sm text-title">
                    {currentEvaluation.isCorrect
                      ? 'Chính xác hoàn toàn! Câu này đã được củng cố!'
                      : `Chưa chuẩn xác (${currentEvaluation.errors.length} lỗi). Cần tiếp tục rèn luyện!`}
                  </span>
                </div>

                <div className="flex items-center gap-2">
                  <button
                    onClick={() => {
                      setUserInput('')
                      setIsCompleted(false)
                      committedLengthRef.current = 0
                      setTimeout(() => inputRef.current?.focus(), 50)
                    }}
                    className="flex items-center gap-1 px-3 py-1.5 rounded-lg border border-border hover:bg-card text-xs font-serif transition-colors"
                  >
                    <RotateCcw className="w-3.5 h-3.5" />
                    <span>Thử lại</span>
                  </button>

                  <button
                    onClick={handleNextInQueue}
                    className="flex items-center gap-1 px-3.5 py-1.5 rounded-lg bg-app-accent hover:bg-accent-hover text-white text-xs font-serif font-medium transition-all shadow-xs"
                  >
                    <span>
                      {currentQueueIndex + 1 < activeQueue.length ? 'Câu tiếp theo' : 'Hoàn thành'}
                    </span>
                    <ArrowRight className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* Nút hành động */}
          {!isCompleted && (
            <div className="flex items-center justify-between pt-2 border-t border-border/70">
              <button
                onClick={exitReviewSession}
                className="text-xs text-muted hover:text-title font-serif transition-colors"
              >
                Tạm dừng ôn tập
              </button>

              <button
                onClick={handleSubmitReview}
                disabled={userInput.length === 0}
                className="flex items-center gap-1.5 px-4 py-2 bg-app-accent hover:bg-accent-hover disabled:opacity-50 text-white rounded-xl text-xs md:text-sm font-serif font-medium transition-all shadow-xs"
              >
                <CheckCircle2 className="w-4 h-4" />
                <span>Kiểm tra kết quả</span>
              </button>
            </div>
          )}
        </div>
      </div>
    )
  }

  // Chế độ xem danh sách câu sai (Review Dashboard List)
  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      {/* 1. Header & Thống kê tổng hợp */}
      <div className="bg-card border border-border rounded-2xl p-5 md:p-6 shadow-sm space-y-5">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div>
            <h2 className="text-lg md:text-xl font-serif font-bold text-title flex items-center gap-2">
              <Flame className="w-5 h-5 text-app-accent" />
              <span>Sổ tay Câu sai cần ôn tập</span>
            </h2>
            <p className="text-xs md:text-sm text-muted font-serif mt-1">
              Hệ thống tự động ghi nhớ các câu bạn từng gõ sai để bạn rèn luyện lại cho đến khi thành thạo.
            </p>
          </div>

          <div className="flex items-center gap-2">
            {onBackToPractice && (
              <button
                onClick={onBackToPractice}
                className="px-3.5 py-2 rounded-xl border border-border hover:bg-page text-xs font-serif text-muted hover:text-title transition-colors"
              >
                Về bài luyện
              </button>
            )}

            <button
              onClick={startQueueReview}
              disabled={mistakes.length === 0}
              className="flex items-center gap-2 px-4 py-2 rounded-xl bg-app-accent hover:bg-accent-hover disabled:opacity-50 text-white text-xs md:text-sm font-serif font-semibold shadow-xs transition-all"
            >
              <Play className="w-4 h-4 fill-current" />
              <span>Ôn tập ngay ({filteredMistakes.length} câu)</span>
            </button>
          </div>
        </div>

        {/* 4 Thẻ chỉ số trạng thái */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 pt-2">
          <div
            onClick={() => setStatusFilter('all')}
            className={`p-3 rounded-xl border transition-all cursor-pointer ${
              statusFilter === 'all'
                ? 'bg-page border-title/50 shadow-2xs ring-1 ring-title/20'
                : 'bg-page/50 border-border hover:border-title/30'
            }`}
          >
            <p className="text-[11px] text-muted font-serif">Tổng số câu sai</p>
            <p className="text-xl font-serif font-bold text-title">{stats.total}</p>
          </div>

          <div
            onClick={() => setStatusFilter('need_review')}
            className={`p-3 rounded-xl border transition-all cursor-pointer ${
              statusFilter === 'need_review'
                ? 'bg-red-500/10 border-red-500/50 shadow-2xs ring-1 ring-red-500/30'
                : 'bg-page/50 border-border hover:border-red-500/30'
            }`}
          >
            <p className="text-[11px] text-red-600 dark:text-red-400 font-serif font-medium">
              Cần ôn tập
            </p>
            <p className="text-xl font-serif font-bold text-red-600 dark:text-red-400">
              {stats.needReview}
            </p>
          </div>

          <div
            onClick={() => setStatusFilter('reviewing')}
            className={`p-3 rounded-xl border transition-all cursor-pointer ${
              statusFilter === 'reviewing'
                ? 'bg-amber-500/10 border-amber-500/50 shadow-2xs ring-1 ring-amber-500/30'
                : 'bg-page/50 border-border hover:border-amber-500/30'
            }`}
          >
            <p className="text-[11px] text-amber-600 dark:text-amber-400 font-serif font-medium">
              Đang rèn luyện
            </p>
            <p className="text-xl font-serif font-bold text-amber-600 dark:text-amber-400">
              {stats.reviewing}
            </p>
          </div>

          <div
            onClick={() => setStatusFilter('mastered')}
            className={`p-3 rounded-xl border transition-all cursor-pointer ${
              statusFilter === 'mastered'
                ? 'bg-emerald-500/10 border-emerald-500/50 shadow-2xs ring-1 ring-emerald-500/30'
                : 'bg-page/50 border-border hover:border-emerald-500/30'
            }`}
          >
            <p className="text-[11px] text-emerald-600 dark:text-emerald-400 font-serif font-medium">
              Đã thành thạo
            </p>
            <p className="text-xl font-serif font-bold text-emerald-600 dark:text-emerald-400">
              {stats.mastered}
            </p>
          </div>
        </div>
      </div>

      {/* 2. Thanh bộ lọc phân loại */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-card border border-border rounded-xl p-3 shadow-xs">
        <div className="flex items-center gap-2 flex-wrap">
          <span className="text-xs text-muted font-serif flex items-center gap-1">
            <Filter className="w-3.5 h-3.5" />
            <span>Trạng thái:</span>
          </span>

          {[
            { id: 'all', label: 'Tất cả' },
            { id: 'need_review', label: 'Cần ôn' },
            { id: 'reviewing', label: 'Đang luyện' },
            { id: 'mastered', label: 'Đã thành thạo' },
          ].map((item) => (
            <button
              key={item.id}
              onClick={() => setStatusFilter(item.id as ReviewStatus | 'all')}
              className={`px-2.5 py-1 rounded-lg text-xs font-serif transition-colors ${
                statusFilter === item.id
                  ? 'bg-title text-white font-medium'
                  : 'bg-page border border-border text-muted hover:text-title'
              }`}
            >
              {item.label}
            </button>
          ))}
        </div>

        <div className="flex items-center gap-3 flex-wrap">
          <div className="flex items-center gap-2">
            <span className="text-xs text-muted font-serif">Chế độ:</span>
            <select
              value={modeFilter}
              onChange={(e) => setModeFilter(e.target.value)}
              className="bg-page border border-border rounded-lg text-xs font-serif text-title px-2.5 py-1 focus:outline-none focus:border-app-accent"
            >
              <option value="all">Tất cả bài</option>
              <option value="sentence">Câu mẫu</option>
              <option value="vocabulary">Từ vựng</option>
              <option value="paragraph">Đoạn văn</option>
              <option value="hsk">Theo HSK</option>
              <option value="custom">Tự tạo</option>
            </select>
          </div>

          {/* Bộ lọc cấp độ HSK 1 - 6 */}
          <div className="flex items-center gap-1 flex-wrap">
            <span className="text-xs text-muted font-serif mr-0.5">HSK:</span>
            {(['all', '1', '2', '3', '4', '5', '6'] as const).map((lvl) => (
              <button
                key={lvl}
                onClick={() => setHskFilter(lvl)}
                className={`px-2 py-0.5 rounded-md text-xs font-serif transition-colors ${
                  hskFilter === lvl
                    ? 'bg-app-accent text-white font-medium shadow-2xs'
                    : 'bg-page border border-border text-muted hover:text-title'
                }`}
              >
                {lvl === 'all' ? 'Tất cả' : `Cấp ${lvl}`}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* 3. Danh sách câu sai */}
      {isLoading ? (
        <div className="p-12 text-center text-muted font-serif text-sm">
          Đang tải dữ liệu câu sai...
        </div>
      ) : filteredMistakes.length === 0 ? (
        <div className="p-12 bg-card border border-border rounded-2xl text-center space-y-3 shadow-xs">
          <div className="w-12 h-12 mx-auto rounded-full bg-emerald-500/10 text-emerald-600 flex items-center justify-center">
            <CheckCircle2 className="w-6 h-6" />
          </div>
          <h3 className="font-serif font-bold text-base text-title">
            {mistakes.length === 0
              ? 'Tuyệt vời! Bạn chưa có câu sai nào!'
              : 'Không có câu nào khớp với bộ lọc hiện tại.'}
          </h3>
          <p className="text-xs md:text-sm text-muted font-serif max-w-md mx-auto">
            {mistakes.length === 0
              ? 'Hãy tiếp tục luyện đánh máy. Mỗi khi bạn hoàn thành một câu mà có chữ Hán chưa chính xác, hệ thống sẽ tự động lưu vào đây để bạn ôn luyện.'
              : 'Thử chuyển sang chế độ "Tất cả" để xem danh sách đầy đủ.'}
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 gap-3.5">
          {filteredMistakes.map((item) => (
            <div
              key={item.id}
              className="bg-card border border-border hover:border-app-accent/40 rounded-xl p-4 md:p-5 shadow-2xs hover:shadow-xs transition-all space-y-3"
            >
              <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-3">
                <div className="space-y-1.5 flex-1">
                  <div className="flex items-center gap-2 flex-wrap">
                    {/* Badge cấp độ HSK nếu có */}
                    {extractHskLevel(item.exerciseId) && (
                      <span className="px-2 py-0.5 rounded text-[11px] font-sans font-semibold bg-app-accent-soft text-app-accent border border-app-accent/20">
                        HSK {extractHskLevel(item.exerciseId)}
                      </span>
                    )}

                    {/* Badge trạng thái */}
                    {item.reviewStatus === 'need_review' && (
                      <span className="px-2 py-0.5 rounded text-[11px] font-sans font-semibold bg-red-500/15 text-red-600 dark:text-red-400 border border-red-500/20">
                        Cần ôn tập
                      </span>
                    )}
                    {item.reviewStatus === 'reviewing' && (
                      <span className="px-2 py-0.5 rounded text-[11px] font-sans font-semibold bg-amber-500/15 text-amber-700 dark:text-amber-400 border border-amber-500/20">
                        Đang luyện ({item.consecutiveCorrect}/2)
                      </span>
                    )}
                    {item.reviewStatus === 'mastered' && (
                      <span className="px-2 py-0.5 rounded text-[11px] font-sans font-semibold bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 border border-emerald-500/20">
                        Đã thành thạo
                      </span>
                    )}

                    <span className="text-xs text-muted font-serif">
                      • Sai {item.mistakeCount} lần
                    </span>
                    <span className="text-xs text-muted font-serif">
                      • Ôn đúng {item.reviewCorrectCount}/{item.reviewCount || 0}
                    </span>
                  </div>

                  {/* Chữ Hán câu mục tiêu */}
                  <h3
                    className="text-lg md:text-xl font-serif font-bold text-title tracking-wide pt-1"
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {item.sentenceZh}
                  </h3>

                  {item.pinyin && (
                    <p className="text-xs md:text-sm text-muted font-sans">{item.pinyin}</p>
                  )}

                  {item.meaningVi && (
                    <p className="text-xs md:text-sm text-body/90 font-serif italic">
                      {item.meaningVi}
                    </p>
                  )}

                  {/* Bản gõ sai gần nhất */}
                  {item.lastInputZh && (
                    <div className="pt-2 text-xs font-serif flex items-center gap-2">
                      <span className="text-muted">Đã gõ sai gần nhất:</span>
                      <span className="text-red-500 font-semibold line-through bg-red-500/10 px-1.5 py-0.5 rounded">
                        {item.lastInputZh}
                      </span>
                    </div>
                  )}
                </div>

                <div className="flex items-center gap-2 self-end sm:self-start shrink-0">
                  <AudioButton
                    text={item.sentenceZh}
                    id={`list-audio-${item.id}`}
                    size="sm"
                    variant="ghost"
                    tooltip="Nghe phát âm"
                  />

                  <button
                    onClick={(e) => handleToggleMastered(item, e)}
                    className="p-2 rounded-lg border border-border hover:bg-page text-muted hover:text-title text-xs transition-colors"
                    title={
                      item.reviewStatus === 'mastered'
                        ? 'Chuyển về Cần ôn tập'
                        : 'Đánh dấu Đã thành thạo'
                    }
                  >
                    {item.reviewStatus === 'mastered' ? (
                      <RotateCcw className="w-4 h-4" />
                    ) : (
                      <Check className="w-4 h-4 text-emerald-600" />
                    )}
                  </button>

                  <button
                    onClick={() => startSingleReview(item)}
                    className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-app-accent hover:bg-accent-hover text-white text-xs font-serif font-medium shadow-2xs transition-all"
                  >
                    <Play className="w-3.5 h-3.5 fill-current" />
                    <span>Luyện lại câu này</span>
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
