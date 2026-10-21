'use client'

import { useState, useEffect, useRef } from 'react'
import { 
  PenTool, 
  Sparkles, 
  BookOpen, 
  CheckCircle2, 
  Award, 
  FileText, 
  Lightbulb, 
  Loader2, 
  Compass, 
  ArrowRight,
  RotateCcw
} from 'lucide-react'
import { toast } from 'sonner'
import { createClient } from '@/lib/supabase/client'
import { correctWritingAction } from './actions'
import { TopicSuggestions } from './components/topic-suggestions'
import { WritingCanvas } from './components/writing-canvas'
import { ResultOverview } from './components/result-overview'
import { ResultErrors } from './components/result-errors'
import { ResultPolished } from './components/result-polished'
import { ResultVocabulary } from './components/result-vocabulary'

interface AIResult {
  score: number
  level: string
  summary: string
  correctedText: string
  errors: Array<{
    original: string
    correction: string
    type: string
    severity: string
    explanation: string
    reason: string
  }>
  strengths: string[]
  weaknesses: string[]
  vocabularySuggestions: Array<{
    word: string
    pinyin: string
    meaning: string
    example: string
  }>
  learningSuggestions: string[]
  scoreDetails: {
    grammar: number
    vocabulary: number
    wordOrder: number
    naturalness: number
    coherence: number
    hskAppropriateness: number
  }
}

type ResultTabKey = 'overview' | 'errors' | 'polished' | 'vocabulary'

export default function WritingClient() {
  const [text, setText] = useState('')
  const [level, setLevel] = useState('Chưa xác định')
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [result, setResult] = useState<AIResult | null>(null)
  const [errorMsg, setErrorMsg] = useState<string | null>(null)
  const [activeTab, setActiveTab] = useState<ResultTabKey>('overview')
  const [userId, setUserId] = useState<string | null>(null)
  const [lastSavedAt, setLastSavedAt] = useState<string | null>(null)

  const resultsRef = useRef<HTMLDivElement>(null)

  // 1. Load user ID and cached draft
  useEffect(() => {
    const supabase = createClient()
    supabase.auth.getUser().then(({ data: { user } }) => {
      const uid = user?.id || 'guest'
      setUserId(uid)

      try {
        const savedDraft = localStorage.getItem(`chinese_notebook_writing_draft_${uid}`)
        if (savedDraft) {
          const parsed = JSON.parse(savedDraft)
          if (parsed.text && typeof parsed.text === 'string') {
            setText(parsed.text)
            if (parsed.level) setLevel(parsed.level)
            if (parsed.savedAt) setLastSavedAt(parsed.savedAt)
          }
        }
      } catch (e) {
        console.error('Error loading writing draft:', e)
      }
    })
  }, [])

  // 2. Auto-save draft on text or level change (debounced 1000ms)
  useEffect(() => {
    if (!userId) return

    const timer = setTimeout(() => {
      if (text.trim().length > 0) {
        const now = new Date()
        const timeStr = now.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' })
        try {
          localStorage.setItem(
            `chinese_notebook_writing_draft_${userId}`,
            JSON.stringify({ text, level, savedAt: timeStr })
          )
          setLastSavedAt(timeStr)
        } catch (e) {
          console.error('Error auto-saving draft:', e)
        }
      }
    }, 1000)

    return () => clearTimeout(timer)
  }, [text, level, userId])

  // Clear draft
  const handleClear = () => {
    setText('')
    if (userId) {
      try {
        localStorage.removeItem(`chinese_notebook_writing_draft_${userId}`)
      } catch {}
    }
    setLastSavedAt(null)
  }

  // Handle Submit
  const handleSubmit = async () => {
    if (isSubmitting) return
    if (!text.trim()) {
      setErrorMsg('Vui lòng nhập bài viết tiếng Trung trước khi phân tích.')
      return
    }
    if (text.length > 5000) {
      setErrorMsg('Bài viết vượt quá giới hạn 5.000 ký tự. Vui lòng rút gọn.')
      return
    }

    setIsSubmitting(true)
    setErrorMsg(null)

    const toastId = toast.loading('AI đang kiểm tra ngữ pháp, từ vựng và chấm điểm theo HSK...')

    try {
      const res = await correctWritingAction(text, level)
      if (res.error) {
        setErrorMsg(res.error)
        toast.error(res.error, { id: toastId })
      } else if (res.data) {
        setResult(res.data)
        if (res.data.level && res.data.level.startsWith('HSK')) {
          setLevel(res.data.level)
        }
        toast.success('Phân tích bài viết hoàn tất!', { id: toastId })
        // Smooth scroll to results
        setTimeout(() => {
          resultsRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' })
        }, 150)
      }
    } catch (err: unknown) {
      const error = err as Error
      const msg = error.message || 'Lỗi không xác định khi kết nối với máy chủ AI.'
      setErrorMsg(msg)
      toast.error('Không thể phân tích bài viết. Vui lòng thử lại.', { id: toastId })
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <div className="max-w-6xl mx-auto pb-28 md:pb-24 space-y-6 font-serif">
      {/* 1. Page Header */}
      <div className="bg-card border border-border rounded-2xl p-6 shadow-2xs space-y-2">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 rounded-xl bg-app-accent-soft text-app-accent flex items-center justify-center border border-app-accent/20 shadow-2xs">
              <PenTool className="w-6 h-6" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h1 className="text-xl sm:text-2xl font-bold text-title">Luyện Viết Sổ Tay Hán Ngữ</h1>
                <span className="bg-app-accent text-white text-[10px] font-sans font-bold uppercase tracking-wider px-2 py-0.5 rounded-full">
                  AI Giáo Viên
                </span>
              </div>
              <p className="text-xs sm:text-sm text-muted mt-0.5">
                Không gian luyện viết tiếng Trung chuyên nghiệp: phát hiện lỗi ngữ pháp, tinh chỉnh văn phong và đối chiếu HSK 3.0
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* 2. Topic Suggestions: "Hôm nay viết gì?" */}
      <TopicSuggestions
        currentText={text}
        onSelectPrompt={(promptTemplate) => {
          setText(promptTemplate)
          toast.success('Đã nạp khung gợi ý vào bài viết!')
        }}
      />

      {/* 3. Writing Canvas Workspace */}
      <WritingCanvas
        text={text}
        setText={setText}
        level={level}
        setLevel={setLevel}
        isSubmitting={isSubmitting}
        onSubmit={handleSubmit}
        errorMsg={errorMsg}
        lastSavedAt={lastSavedAt}
        onClear={handleClear}
      />

      {/* 4. Loading State Skeleton while AI is analyzing */}
      {isSubmitting && (
        <div className="bg-card border border-app-accent/30 rounded-2xl p-8 sm:p-12 text-center space-y-4 shadow-sm animate-in fade-in">
          <div className="w-16 h-16 rounded-full bg-app-accent-soft text-app-accent flex items-center justify-center mx-auto border-2 border-app-accent/20 shadow-inner">
            <Loader2 className="w-8 h-8 animate-spin" />
          </div>
          <div className="space-y-1">
            <h3 className="text-base sm:text-lg font-bold text-title">AI đang đọc & chấm điểm bài viết...</h3>
            <p className="text-xs text-muted max-w-md mx-auto leading-relaxed">
              Hệ thống đang đối chiếu ngữ pháp, từ vựng, trật tự câu và độ tự nhiên theo chuẩn HSK 3.0. Quá trình này thường mất khoảng 3–8 giây.
            </p>
          </div>
          {/* Stepper indicators */}
          <div className="flex flex-wrap items-center justify-center gap-2 pt-2 text-[11px] text-muted">
            <span className="bg-page px-2.5 py-1 rounded-full border border-border">✓ Quét ngữ pháp</span>
            <span>→</span>
            <span className="bg-page px-2.5 py-1 rounded-full border border-border">✓ Đo độ tự nhiên</span>
            <span>→</span>
            <span className="bg-page px-2.5 py-1 rounded-full border border-border">✓ Viết bản trau chuốt</span>
          </div>
        </div>
      )}

      {/* 5. Empty State Guide (Before submitting) */}
      {!result && !isSubmitting && (
        <div className="bg-card border border-border rounded-2xl p-5 sm:p-6 shadow-2xs space-y-3.5">
          <div className="flex items-center gap-2 border-b border-border pb-2.5">
            <Sparkles className="w-4 h-4 text-gold" />
            <h3 className="font-bold text-xs sm:text-sm text-title">
              Quy trình 3 bước nâng cao kỹ năng viết cùng AI
            </h3>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-xs">
            <div className="bg-page/60 p-3.5 rounded-xl border border-border/80 space-y-1">
              <div className="font-bold text-title flex items-center gap-1.5">
                <span className="w-5 h-5 rounded-full bg-title text-white text-[10px] flex items-center justify-center font-bold">1</span>
                <span>Soạn thảo tự do</span>
              </div>
              <p className="text-muted leading-relaxed">
                Chọn chủ đề gợi ý hoặc tự viết nhật ký. Dùng bộ gõ Pinyin IME nhập liệu tự nhiên.
              </p>
            </div>

            <div className="bg-page/60 p-3.5 rounded-xl border border-border/80 space-y-1">
              <div className="font-bold text-title flex items-center gap-1.5">
                <span className="w-5 h-5 rounded-full bg-app-accent text-white text-[10px] flex items-center justify-center font-bold">2</span>
                <span>Phân tích 6 tiêu chuẩn</span>
              </div>
              <p className="text-muted leading-relaxed">
                AI đánh giá ngữ pháp, từ vựng, trật tự câu, độ mạch lạc và xếp hạng chuẩn HSK 3.0.
              </p>
            </div>

            <div className="bg-page/60 p-3.5 rounded-xl border border-border/80 space-y-1">
              <div className="font-bold text-title flex items-center gap-1.5">
                <span className="w-5 h-5 rounded-full bg-jade text-white text-[10px] flex items-center justify-center font-bold">3</span>
                <span>Luyện nghe & Mở rộng</span>
              </div>
              <p className="text-muted leading-relaxed">
                Nghe phát âm bản sửa hoàn chỉnh, đối chiếu lỗi sai và ghi nhớ từ vựng nâng cao.
              </p>
            </div>
          </div>
        </div>
      )}

      {/* 6. AI Results Workspace Hub */}
      {result && (
        <div ref={resultsRef} className="scroll-mt-6 space-y-4 animate-in fade-in slide-in-from-bottom-3 duration-300">
          {/* Results Navigation Bar */}
          <div className="bg-card border border-border rounded-2xl p-2 shadow-2xs flex items-center gap-1.5 overflow-x-auto no-scrollbar">
            <button
              type="button"
              onClick={() => setActiveTab('overview')}
              className={`flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-serif transition-colors cursor-pointer flex-shrink-0 ${
                activeTab === 'overview'
                  ? 'bg-app-accent text-white font-bold shadow-2xs'
                  : 'text-title hover:bg-page'
              }`}
            >
              <Award className="w-4 h-4" />
              <span>Tổng quan & Điểm ({result.score}đ)</span>
            </button>

            <button
              type="button"
              onClick={() => setActiveTab('errors')}
              className={`flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-serif transition-colors cursor-pointer flex-shrink-0 ${
                activeTab === 'errors'
                  ? 'bg-app-accent text-white font-bold shadow-2xs'
                  : 'text-title hover:bg-page'
              }`}
            >
              <CheckCircle2 className="w-4 h-4" />
              <span>Phân tích sửa lỗi ({result.errors?.length || 0})</span>
            </button>

            <button
              type="button"
              onClick={() => setActiveTab('polished')}
              className={`flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-serif transition-colors cursor-pointer flex-shrink-0 ${
                activeTab === 'polished'
                  ? 'bg-app-accent text-white font-bold shadow-2xs'
                  : 'text-title hover:bg-page'
              }`}
            >
              <FileText className="w-4 h-4" />
              <span>Bản viết hoàn chỉnh</span>
            </button>

            <button
              type="button"
              onClick={() => setActiveTab('vocabulary')}
              className={`flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-serif transition-colors cursor-pointer flex-shrink-0 ${
                activeTab === 'vocabulary'
                  ? 'bg-app-accent text-white font-bold shadow-2xs'
                  : 'text-title hover:bg-page'
              }`}
            >
              <Lightbulb className="w-4 h-4" />
              <span>Từ vựng & Mở rộng ({result.vocabularySuggestions?.length || 0})</span>
            </button>
          </div>

          {/* Active Tab View */}
          <div className="transition-all duration-200">
            {activeTab === 'overview' && (
              <ResultOverview
                score={result.score}
                level={result.level}
                summary={result.summary}
                scoreDetails={result.scoreDetails}
                strengths={result.strengths}
                weaknesses={result.weaknesses}
              />
            )}

            {activeTab === 'errors' && (
              <ResultErrors errors={result.errors || []} />
            )}

            {activeTab === 'polished' && (
              <ResultPolished
                originalText={text}
                correctedText={result.correctedText}
              />
            )}

            {activeTab === 'vocabulary' && (
              <ResultVocabulary
                vocabularySuggestions={result.vocabularySuggestions}
                learningSuggestions={result.learningSuggestions}
              />
            )}
          </div>
        </div>
      )}
    </div>
  )
}
