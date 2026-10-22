'use client'

import { useState, useMemo, useEffect, useCallback } from 'react'
import Link from 'next/link'
import { 
  BookOpen, 
  CheckCircle2, 
  ChevronRight, 
  ChevronLeft,
  Sparkles, 
  BookType, 
  GraduationCap, 
  WholeWord,
  Flame,
  Search,
  X,
  PlayCircle,
  LogIn,
  Layers,
  ArrowRight,
  Filter,
  Loader2,
  ArrowLeft,
  Clock
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { AudioButton } from '@/components/ui/audio-button'
import { AudioSpeedSelector } from '@/components/ui/audio-speed-selector'
import { HSK_LEVELS, HSK_AUDIT_DATA, getHskAuditData } from '@/data/hsk-curriculum'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import { getTopicVocabulariesAction, TopicVocabItem } from './actions'
import { formatNumber } from '@/lib/utils'

export type LessonItem = {
  id: string
  title: string
  subtitle?: string | null
  lesson_number?: number | null
  vocab_count: number
  learned_vocab_count?: number
  is_completed?: boolean
}

type GlobalVocab = {
  id: string
  hanzi: string
  pinyin: string
  meaning_vi: string
  example_hanzi?: string
  example_pinyin?: string
  example_vi?: string
}

type RecentVocab = {
  hanzi: string
  pinyin: string
  vi: string
}

interface HskDashboardClientProps {
  currentHsk: string
  lessons: LessonItem[]
  userVocabCount: number
  reviewVocabCount: number
  recentVocabs?: RecentVocab[]
  globalVocabs?: GlobalVocab[]
  totalLevelVocabCount?: number
  isLoggedIn: boolean
}

export default function HskDashboardClient({
  currentHsk,
  lessons,
  userVocabCount,
  reviewVocabCount,
  recentVocabs = [],
  globalVocabs = [],
  totalLevelVocabCount,
  isLoggedIn,
}: HskDashboardClientProps) {
  const { openLoginForm } = useAuthModal()
  const [activeTab, setActiveTab] = useState<'lessons' | 'vocab'>('lessons')
  const [searchQuery, setSearchQuery] = useState('')
  const [statusFilter, setStatusFilter] = useState<'all' | 'in_progress' | 'completed' | 'not_started'>('all')
  const [vocabSearchQuery, setVocabSearchQuery] = useState('')
  const [visibleLessonsCount, setVisibleLessonsCount] = useState(24)

  // Level info from curriculum (HSK 3.0: HSK 1 - 6, HSK 7-9)
  const levelNum = currentHsk === 'HSK 7-9' || currentHsk === 'HSK 7'
    ? 7
    : parseInt(currentHsk.replace('HSK ', ''), 10)
  const levelInfo = !isNaN(levelNum) ? HSK_LEVELS[levelNum] : null
  const auditData = getHskAuditData(currentHsk)

  // Số từ thực tế trong hệ thống & Số từ chuẩn theo tiêu chuẩn HSK 3.0
  const actualVocabCount = typeof totalLevelVocabCount === 'number'
    ? totalLevelVocabCount
    : auditData?.systemVocabCount ?? 0
  const standardVocabTarget = levelInfo?.vocabTarget || auditData?.standardTargetVocab || actualVocabCount
  const isComingSoon = auditData?.status === 'coming_soon' || (actualVocabCount === 0 && lessons.length === 0 && currentHsk === 'HSK 7-9')

  const stage = levelInfo 
    ? `${levelInfo.stage} (${levelInfo.stageZh})` 
    : currentHsk === 'Giao tiếp' 
    ? 'Thực hành' 
    : 'Chuyên ngành'

  const description = levelInfo 
    ? levelInfo.description 
    : currentHsk === 'Giao tiếp'
    ? 'Các bài học đàm thoại và mẫu câu giao tiếp tiếng Trung theo tình huống sinh hoạt thực tế.'
    : 'Hệ thống từ vựng và thuật ngữ chuyên ngành sản xuất, nhà máy, công xưởng và an toàn lao động.'

  const progressPercent = actualVocabCount > 0
    ? Math.min(100, Math.round((userVocabCount / actualVocabCount) * 100))
    : 0

  const completedLessonsCount = lessons.filter(l => l.is_completed).length
  const inProgressLessonsCount = lessons.filter(l => !l.is_completed && (l.learned_vocab_count || 0) > 0).length
  const notStartedLessonsCount = lessons.filter(l => !l.is_completed && (!l.learned_vocab_count || l.learned_vocab_count === 0)).length
  const lessonPercent = lessons.length > 0 ? Math.min(100, Math.round((completedLessonsCount / lessons.length) * 100)) : 0

  // Smart next lesson locator
  const nextLesson = useMemo(() => {
    if (!lessons.length) return null
    // 1. Pick first in-progress lesson
    const inProg = lessons.find(l => !l.is_completed && (l.learned_vocab_count || 0) > 0)
    if (inProg) return inProg
    // 2. Or first uncompleted lesson
    const uncompleted = lessons.find(l => !l.is_completed)
    if (uncompleted) return uncompleted
    // 3. Fallback to first lesson
    return lessons[0]
  }, [lessons])

  const nextLessonIndex = nextLesson ? lessons.findIndex(l => l.id === nextLesson.id) : 0

  // Filter lessons
  const filteredLessons = useMemo(() => {
    let result = [...lessons]

    // Text search
    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase().trim()
      result = result.filter(l =>
        l.title.toLowerCase().includes(q) ||
        (l.subtitle && l.subtitle.toLowerCase().includes(q)) ||
        (l.lesson_number && l.lesson_number.toString() === q) ||
        (l.lesson_number && `bài ${l.lesson_number}`.includes(q))
      )
    }

    // Status filter
    if (isLoggedIn) {
      if (statusFilter === 'completed') {
        result = result.filter(l => l.is_completed)
      } else if (statusFilter === 'in_progress') {
        result = result.filter(l => !l.is_completed && (l.learned_vocab_count || 0) > 0)
      } else if (statusFilter === 'not_started') {
        result = result.filter(l => !l.is_completed && (!l.learned_vocab_count || l.learned_vocab_count === 0))
      }
    }

    return result
  }, [lessons, searchQuery, statusFilter, isLoggedIn])

  // On-demand Vocabulary states
  const [vocabList, setVocabList] = useState<TopicVocabItem[]>(globalVocabs)
  const [vocabPage, setVocabPage] = useState(1)
  const [vocabTotalCount, setVocabTotalCount] = useState(actualVocabCount)
  const [isLoadingVocabs, setIsLoadingVocabs] = useState(false)
  const [hasMoreVocabs, setHasMoreVocabs] = useState(false)
  const [debouncedVocabSearch, setDebouncedVocabSearch] = useState('')

  // Debounce vocab search input (300ms)
  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedVocabSearch(vocabSearchQuery)
    }, 300)
    return () => clearTimeout(timer)
  }, [vocabSearchQuery])

  // Load vocabs on demand from server action
  const loadVocabs = useCallback(async () => {
    setIsLoadingVocabs(true)
    try {
      const res = await getTopicVocabulariesAction({
        hskLevel: currentHsk,
        page: vocabPage,
        pageSize: 30,
        search: debouncedVocabSearch,
      })
      if (res.success) {
        setVocabList(res.vocabs)
        setVocabTotalCount(res.totalCount)
        setHasMoreVocabs(res.hasMore)
      }
    } finally {
      setIsLoadingVocabs(false)
    }
  }, [currentHsk, vocabPage, debouncedVocabSearch])

  // Reset page and search when HSK level changes
  useEffect(() => {
    setVocabPage(1)
    setVocabSearchQuery('')
    setDebouncedVocabSearch('')
    setVisibleLessonsCount(24)
  }, [currentHsk])

  // Fetch when vocab tab is activated or pagination/search triggers
  useEffect(() => {
    if (activeTab === 'vocab') {
      loadVocabs()
    }
  }, [activeTab, loadVocabs])

  // Lessons to display with pagination
  const displayedLessons = useMemo(() => {
    if (searchQuery.trim()) return filteredLessons
    return filteredLessons.slice(0, visibleLessonsCount)
  }, [filteredLessons, searchQuery, visibleLessonsCount])

  const levelTabs = [
    'HSK 1',
    'HSK 2',
    'HSK 3',
    'HSK 4',
    'HSK 5',
    'HSK 6',
    'HSK 7-9',
    'Giao tiếp',
    'Công xưởng',
  ]

  return (
    <div className="min-h-full font-serif space-y-8 pb-12">
      
      {/* 1. LEVEL SELECTOR TAB BAR (Sticky, Glassmorphic on scroll below 56px fixed header) */}
      <div className="bg-page/90 backdrop-blur-md sticky top-14 z-10 -mx-4 md:-mx-8 lg:-mx-10 px-4 md:px-8 lg:px-10 py-2.5 sm:py-3 border-b border-border transition-all">
        <div className="max-w-5xl mx-auto relative">
          <div className="flex items-center gap-1.5 sm:gap-2 overflow-x-auto no-scrollbar py-0.5 scroll-smooth touch-pan-x">
            {levelTabs.map((level) => {
              const isActive = currentHsk === level
              return (
                <Link 
                  key={level} 
                  href={`/topics?q=${encodeURIComponent(level)}`}
                  className={`px-3.5 sm:px-4 py-2 sm:py-2 text-xs sm:text-sm font-serif rounded-xl border whitespace-nowrap transition-all duration-150 flex items-center shrink-0 select-none active:scale-[0.98] touch-manipulation ${
                    isActive 
                      ? 'border-[#B8322D] bg-[#B8322D] text-white font-bold shadow-2xs' 
                      : 'border-[#E9DDD1] bg-card text-[#243047]/80 hover:text-[#243047] hover:bg-[#FFF9F3] hover:border-[#D8C7B8]'
                  }`}
                >
                  <span 
                    className={`w-1.5 h-1.5 rounded-full mr-1.5 transition-colors ${
                      isActive ? 'bg-white' : 'bg-[#E9DDD1]'
                    }`} 
                  />
                  <span>{level}</span>
                </Link>
              )
            })}
          </div>
          {/* Subtle horizontal scroll fade cue for mobile */}
          <div className="pointer-events-none absolute right-0 top-0 bottom-0 w-6 bg-gradient-to-l from-page/90 to-transparent sm:hidden" />
        </div>
      </div>

      {isComingSoon ? (
        <div className="py-6 space-y-6">
          <section className="bg-card border border-border p-8 sm:p-12 rounded-2xl shadow-2xs text-center space-y-6 max-w-2xl mx-auto relative overflow-hidden">
            <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-amber-500 via-gold to-amber-600" />
            
            <div className="w-16 h-16 rounded-2xl bg-amber-500/10 border border-amber-500/20 text-amber-600 flex items-center justify-center mx-auto shadow-xs">
              <Clock className="w-8 h-8 animate-pulse" />
            </div>

            <div className="space-y-2">
              <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-serif font-bold bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20">
                <span>{currentHsk} • {stage}</span>
                <span>•</span>
                <span>Đang hoàn thiện</span>
              </div>
              <h1 className="text-2xl sm:text-3xl font-serif font-bold text-title tracking-tight">
                Lộ trình {currentHsk}
              </h1>
              <p className="text-sm sm:text-base text-body font-serif font-medium max-w-lg mx-auto pt-2 leading-relaxed">
                Nội dung HSK này đang được hoàn thiện và sẽ sớm được cập nhật. Vui lòng quay lại sau nhé!
              </p>
            </div>

            <div className="p-4 sm:p-5 rounded-xl bg-page border border-border/80 text-left text-xs font-serif text-muted space-y-2 max-w-xl mx-auto">
              <div className="font-semibold text-title flex items-center gap-1.5">
                <GraduationCap className="w-4 h-4 text-app-accent" />
                <span>Tiêu chuẩn HSK 3.0 (GF 0025-2021)</span>
              </div>
              <p className="leading-relaxed">
                Khối thi Cao cấp HSK 7–9 theo chuẩn Giáo dục Hán ngữ Quốc tế do Bộ Giáo dục Trung Quốc công bố gồm <strong>11,092 từ vựng tích lũy</strong>, <strong>3,000 chữ Hán</strong> và <strong>572 điểm ngữ pháp</strong>. Đội ngũ học thuật đang thẩm định nội dung để đảm bảo bài học đạt chất lượng tốt nhất.
              </p>
            </div>

            <div className="flex flex-col sm:flex-row items-center justify-center gap-3 pt-2">
              <Link href="/topics?q=HSK 1" className="w-full sm:w-auto">
                <Button className="w-full sm:w-auto font-serif bg-app-accent hover:bg-accent-hover text-white rounded-xl py-3 px-6 shadow-xs text-sm flex items-center justify-center gap-2">
                  <ArrowLeft className="w-4 h-4" />
                  <span>Quay lại lộ trình HSK 1 – 6</span>
                </Button>
              </Link>
              <Link href="/" className="w-full sm:w-auto">
                <Button variant="outline" className="w-full sm:w-auto font-serif border-border rounded-xl py-3 px-6 text-sm">
                  <span>Về trang chủ</span>
                </Button>
              </Link>
            </div>
          </section>
        </div>
      ) : (
        <div className="space-y-6 sm:space-y-8">
        
        {/* 2. HERO OVERVIEW & ACTION CARD */}
        <section className="bg-card border border-border p-4 sm:p-6 md:p-8 rounded-2xl shadow-2xs relative overflow-hidden transition-all">
          {/* Top accent bar */}
          <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-app-accent via-app-accent/80 to-gold" />

          <div className="flex flex-col lg:flex-row lg:items-start justify-between gap-5 sm:gap-6">
            <div className="space-y-3 max-w-2xl">
              {/* Badges */}
              <div className="flex flex-wrap items-center gap-2">
                <span className="px-2.5 py-0.5 rounded-lg text-xs font-serif font-bold bg-app-accent-soft text-app-accent border border-app-accent/20">
                  {currentHsk}
                </span>
                <span className="px-2.5 py-0.5 rounded-lg text-[11px] font-serif text-muted bg-page border border-border">
                  {stage}
                </span>
                {levelInfo && (
                  <span className="px-2 py-0.5 rounded-lg text-[10px] font-mono font-medium bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20">
                    HSK 3.0 • GF 0025-2021
                  </span>
                )}
                <span className="text-xs text-muted font-serif flex items-center gap-1.5 flex-wrap">
                  <span>•</span>
                  <span>Từ mới riêng cấp: <strong suppressHydrationWarning>{formatNumber(actualVocabCount)}</strong>{levelInfo?.newVocab ? ` / ${formatNumber(levelInfo.newVocab)}` : ''} từ</span>
                  {levelInfo?.vocabTarget && (
                    <>
                      <span>•</span>
                      <span>Tích lũy chuẩn HSK 3.0: <strong suppressHydrationWarning>{formatNumber(levelInfo.vocabTarget)}</strong> từ</span>
                    </>
                  )}
                  {levelInfo?.charTarget && (
                    <>
                      <span>•</span>
                      <span><strong suppressHydrationWarning>{formatNumber(levelInfo.charTarget)}</strong> chữ Hán</span>
                    </>
                  )}
                  {levelInfo?.grammarTarget && (
                    <>
                      <span>•</span>
                      <span><strong suppressHydrationWarning>{formatNumber(levelInfo.grammarTarget)}</strong> ngữ pháp</span>
                    </>
                  )}
                  <span>•</span>
                  <span><strong>{lessons.length}</strong> bài học</span>
                </span>
              </div>

              {/* Title & Description */}
              <h1 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-title tracking-tight">
                Lộ trình {currentHsk}
              </h1>
              <p className="text-xs sm:text-sm text-body font-serif leading-relaxed">
                {description}
              </p>

              {/* Thông báo phân loại trạng thái cấp độ HSK */}
              {(actualVocabCount >= (levelInfo?.newVocab || standardVocabTarget)) && (levelInfo?.newVocab || standardVocabTarget) > 0 ? (
                <div className="flex items-center gap-2 text-xs font-serif text-emerald-800 dark:text-emerald-300 bg-emerald-500/10 border border-emerald-500/20 px-3 py-2 rounded-xl">
                  <CheckCircle2 className="w-3.5 h-3.5 shrink-0 text-emerald-600 dark:text-emerald-400" />
                  <span>
                    Kho từ vựng <strong>{currentHsk}</strong> trong hệ thống đã đạt chuẩn hoàn chỉnh <strong>{formatNumber(actualVocabCount)}/{formatNumber(levelInfo?.newVocab || standardVocabTarget)} mục từ mới</strong> (mục tiêu tích lũy chuẩn HSK 1–{levelNum}: {formatNumber(standardVocabTarget)} từ) theo Đề cương thi HSK 3.0 chính thức với đầy đủ phát âm, phân loại từ và câu ví dụ.
                  </span>
                </div>
              ) : auditData?.status === 'partial' ? (
                <div className="flex items-center gap-2 text-xs font-serif text-amber-800 dark:text-amber-300 bg-amber-500/10 border border-amber-500/20 px-3 py-2 rounded-xl">
                  <Sparkles className="w-3.5 h-3.5 shrink-0 text-amber-600 dark:text-amber-400" />
                  <span>
                    Hệ thống hiện có <strong>{formatNumber(actualVocabCount)}</strong> từ vựng mới và <strong>{lessons.length}</strong> bài học thực tế. Nội dung đang tiếp tục được bổ sung theo khung chuẩn HSK 3.0 (mục tiêu {formatNumber(levelInfo?.newVocab || standardVocabTarget)} từ mới, tích lũy {formatNumber(standardVocabTarget)} từ).
                  </span>
                </div>
              ) : null}
            </div>

            {/* Smart Call To Action */}
            <div className="shrink-0 w-full sm:w-auto">
              {isLoggedIn ? (
                reviewVocabCount > 0 ? (
                  <Link href="/review" className="block">
                    <Button variant="primary" className="w-full sm:w-auto font-serif min-h-[46px] py-3 sm:py-3.5 px-5 sm:px-6 shadow-2xs text-sm group flex items-center justify-center gap-2 cursor-pointer">
                      <Flame className="w-4 h-4 text-white animate-pulse" />
                      <span>Ôn tập {reviewVocabCount} từ vựng</span>
                      <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                    </Button>
                  </Link>
                ) : nextLesson ? (
                  <Link href={`/lessons/${nextLesson.id}`} className="block">
                    <Button variant="tertiary" className="w-full sm:w-auto font-serif min-h-[46px] py-3 sm:py-3.5 px-5 sm:px-6 shadow-2xs text-sm group flex items-center justify-center gap-2 cursor-pointer">
                      <PlayCircle className="w-4 h-4 text-white" />
                      <span>
                        {(nextLesson.learned_vocab_count || 0) > 0 ? 'Tiếp tục học:' : 'Bắt đầu:'} Bài {nextLesson.lesson_number || (nextLessonIndex + 1)}
                      </span>
                      <ChevronRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                    </Button>
                  </Link>
                ) : (
                  <div className="inline-flex items-center justify-center w-full sm:w-auto gap-2 px-4 py-2.5 rounded-xl bg-jade-soft text-jade border border-jade/30 text-xs font-serif font-bold">
                    <CheckCircle2 className="w-4 h-4" />
                    <span>Đã hoàn thành toàn bộ bài học!</span>
                  </div>
                )
              ) : (
                <Button 
                  type="button"
                  variant="tertiary"
                  onClick={() => openLoginForm()}
                  className="w-full sm:w-auto font-serif min-h-[46px] py-3 sm:py-3.5 px-5 sm:px-6 shadow-2xs text-sm flex items-center justify-center gap-2 cursor-pointer"
                >
                  <LogIn className="w-4 h-4" />
                  <span>Đăng nhập để theo dõi</span>
                </Button>
              )}
            </div>
          </div>

          {/* DUAL PROGRESS MATRIX (When Logged In) */}
          {isLoggedIn ? (
            <div className="pt-6 mt-6 border-t border-border grid grid-cols-1 md:grid-cols-2 gap-5">
              {/* Progress 1: Vocabulary */}
              <div className="space-y-2 p-3.5 sm:p-4 rounded-xl bg-page/70 border border-border">
                <div className="flex items-center justify-between text-xs font-serif">
                  <span className="text-muted flex items-center gap-1.5 font-medium">
                    <WholeWord className="w-3.5 h-3.5 text-app-accent" />
                    Tiến độ từ vựng thực tế
                  </span>
                  <span className="font-bold text-title">
                    {userVocabCount} / {actualVocabCount} từ ({progressPercent}%)
                  </span>
                </div>
                <div className="w-full bg-track h-2 rounded-full overflow-hidden">
                  <div 
                    className="h-full rounded-full bg-app-accent transition-all duration-700 ease-out"
                    style={{ width: `${progressPercent}%` }}
                  />
                </div>
              </div>

              {/* Progress 2: Lessons Completed */}
              <div className="space-y-2 p-3.5 sm:p-4 rounded-xl bg-page/70 border border-border">
                <div className="flex items-center justify-between text-xs font-serif">
                  <span className="text-muted flex items-center gap-1.5 font-medium">
                    <CheckCircle2 className="w-3.5 h-3.5 text-jade" />
                    Bài học hoàn thành
                  </span>
                  <span className="font-bold text-title">
                    {completedLessonsCount} / {lessons.length} bài ({lessonPercent}%)
                  </span>
                </div>
                <div className="w-full bg-track h-2 rounded-full overflow-hidden">
                  <div 
                    className="h-full rounded-full bg-jade transition-all duration-700 ease-out"
                    style={{ width: `${lessonPercent}%` }}
                  />
                </div>
              </div>
            </div>
          ) : (
            <div className="pt-5 mt-5 border-t border-border flex items-center gap-3 text-xs text-muted font-serif">
              <GraduationCap className="w-4 h-4 text-gold shrink-0" />
              <span>Đăng nhập tài khoản để kích hoạt tính năng lưu tiến độ bài học và ghi nhớ ngắt quãng Spaced Repetition.</span>
            </div>
          )}
        </section>

        {/* 3. CONTENT TABS: LESSONS & VOCABULARY */}
        <section className="space-y-5">
          {/* Tab Selector Header */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 sm:gap-4 border-b border-border pb-3">
            <div className="grid grid-cols-2 sm:inline-flex w-full sm:w-auto p-1 rounded-2xl bg-card border border-[#E9DDD1] gap-1 shadow-2xs">
              <button
                type="button"
                onClick={() => setActiveTab('lessons')}
                className={`flex items-center justify-center gap-1.5 sm:gap-2 px-3 sm:px-4 py-2.5 sm:py-2 rounded-xl text-xs sm:text-sm font-serif font-medium transition-all active:scale-[0.98] touch-manipulation cursor-pointer ${
                  activeTab === 'lessons'
                    ? 'bg-[#B8322D] text-white shadow-2xs font-bold'
                    : 'text-[#243047]/80 hover:text-[#243047] hover:bg-[#FFF9F3]'
                }`}
              >
                <Layers className="w-3.5 h-3.5 sm:w-4 sm:h-4 shrink-0" />
                <span className="truncate">Bài học ({lessons.length})</span>
              </button>

              <button
                type="button"
                onClick={() => setActiveTab('vocab')}
                className={`flex items-center justify-center gap-1.5 sm:gap-2 px-3 sm:px-4 py-2.5 sm:py-2 rounded-xl text-xs sm:text-sm font-serif font-medium transition-all active:scale-[0.98] touch-manipulation cursor-pointer ${
                  activeTab === 'vocab'
                    ? 'bg-[#B8322D] text-white shadow-2xs font-bold'
                    : 'text-[#243047]/80 hover:text-[#243047] hover:bg-[#FFF9F3]'
                }`}
              >
                <WholeWord className="w-3.5 h-3.5 sm:w-4 sm:h-4 shrink-0" />
                <span className="truncate">Từ vựng ({vocabTotalCount})</span>
              </button>
            </div>

            {/* Stats summary label */}
            <div className="text-xs text-muted font-serif hidden md:block">
              {activeTab === 'lessons' 
                ? `Đang hiển thị ${displayedLessons.length} / ${filteredLessons.length} bài học`
                : `Đang hiển thị ${vocabList.length} / ${vocabTotalCount} từ vựng`
              }
            </div>
          </div>

          {/* TAB 1: LESSONS LIST */}
          {activeTab === 'lessons' && (
            <div className="space-y-4">
              {/* Toolbar: Search & Filter */}
              <div className="flex flex-col sm:flex-row gap-3 items-stretch sm:items-center justify-between">
                {/* Search input */}
                <div className="relative flex-1 max-w-md">
                  <Search className="w-4 h-4 text-muted absolute left-3 top-1/2 -translate-y-1/2 pointer-events-none" />
                  <input
                    type="text"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    placeholder="Tìm bài học theo tên hoặc số..."
                    className="w-full pl-9 pr-8 py-2 rounded-xl text-xs sm:text-sm font-serif bg-card border border-border text-title placeholder:text-muted focus:outline-none focus:border-app-accent/60 transition-colors shadow-2xs"
                  />
                  {searchQuery && (
                    <button
                      type="button"
                      onClick={() => setSearchQuery('')}
                      className="absolute right-2.5 top-1/2 -translate-y-1/2 text-muted hover:text-title"
                      title="Xóa tìm kiếm"
                    >
                      <X className="w-3.5 h-3.5" />
                    </button>
                  )}
                </div>

                {/* Filter Pills (if logged in) */}
                {isLoggedIn && (
                  <div className="flex items-center gap-1.5 overflow-x-auto no-scrollbar py-0.5">
                    <span className="text-xs text-muted font-serif mr-1 flex items-center gap-1 shrink-0">
                      <Filter className="w-3 h-3" />
                      Lọc:
                    </span>
                    <button
                      type="button"
                      onClick={() => setStatusFilter('all')}
                      className={`px-3 py-1.5 rounded-xl text-xs font-serif transition-colors whitespace-nowrap border cursor-pointer active:scale-[0.98] touch-manipulation ${
                        statusFilter === 'all'
                          ? 'bg-[#243047] text-white border-[#243047] font-medium'
                          : 'bg-card text-[#243047]/80 hover:text-[#243047] border-[#E9DDD1] hover:bg-[#FFF9F3]'
                      }`}
                    >
                      Tất cả ({lessons.length})
                    </button>
                    <button
                      type="button"
                      onClick={() => setStatusFilter('in_progress')}
                      className={`px-3 py-1.5 rounded-xl text-xs font-serif transition-colors whitespace-nowrap border cursor-pointer active:scale-[0.98] touch-manipulation ${
                        statusFilter === 'in_progress'
                          ? 'bg-[#B8322D] text-white border-[#B8322D] font-medium'
                          : 'bg-card text-[#243047]/80 hover:text-[#243047] border-[#E9DDD1] hover:bg-[#FFF9F3]'
                      }`}
                    >
                      Đang học ({inProgressLessonsCount})
                    </button>
                    <button
                      type="button"
                      onClick={() => setStatusFilter('completed')}
                      className={`px-3 py-1.5 rounded-xl text-xs font-serif transition-colors whitespace-nowrap border cursor-pointer active:scale-[0.98] touch-manipulation ${
                        statusFilter === 'completed'
                          ? 'bg-[#24856A] text-white border-[#24856A] font-medium'
                          : 'bg-card text-[#243047]/80 hover:text-[#243047] border-[#E9DDD1] hover:bg-[#FFF9F3]'
                      }`}
                    >
                      Đã xong ({completedLessonsCount})
                    </button>
                  </div>
                )}
              </div>

              {/* Lessons Grid / List */}
              {filteredLessons.length === 0 ? (
                <div className="p-10 rounded-2xl border border-dashed border-border bg-card/60 text-center space-y-3">
                  <BookOpen className="w-10 h-10 text-muted mx-auto opacity-50" />
                  <h3 className="font-serif font-bold text-base text-title">Không tìm thấy bài học phù hợp</h3>
                  <p className="text-xs text-muted font-serif max-w-sm mx-auto">
                    {searchQuery 
                      ? `Không có kết quả nào khớp với "${searchQuery}". Hãy thử tìm kiếm với từ khóa khác.`
                      : 'Chưa có bài học nào trong danh mục này.'
                    }
                  </p>
                  {searchQuery && (
                    <Button 
                      variant="outline" 
                      size="sm" 
                      onClick={() => setSearchQuery('')}
                      className="font-serif text-xs border-border"
                    >
                      Đặt lại tìm kiếm
                    </Button>
                  )}
                </div>
              ) : (
                <div className="space-y-3">
                  {displayedLessons.map((lesson, idx) => {
                    const lessonNum = lesson.lesson_number ?? (idx + 1)
                    const formattedNum = String(lessonNum).padStart(2, '0')
                    const isCompleted = lesson.is_completed
                    const learnedCount = lesson.learned_vocab_count || 0
                    const isInProgress = !isCompleted && learnedCount > 0

                    return (
                      <Link
                        key={lesson.id}
                        href={`/lessons/${lesson.id}`}
                        className="group block p-3.5 sm:p-5 rounded-xl sm:rounded-2xl border border-border bg-card hover:border-app-accent/40 hover:shadow-xs active:scale-[0.99] transition-all duration-200 relative overflow-hidden touch-manipulation"
                      >
                        <div className="flex items-center gap-3 sm:gap-5 justify-between">
                          
                          {/* Index Number Badge */}
                          <div 
                            className={`w-9 h-9 sm:w-11 sm:h-11 rounded-lg sm:rounded-xl flex items-center justify-center font-serif font-bold text-xs sm:text-base shrink-0 transition-colors border ${
                              isCompleted
                                ? 'bg-jade-soft text-jade border-jade/30'
                                : isInProgress
                                ? 'bg-amber-50 text-amber-700 border-amber-200/60'
                                : 'bg-page text-title border-border group-hover:border-app-accent/30 group-hover:text-app-accent'
                            }`}
                          >
                            {isCompleted ? <CheckCircle2 className="w-4 h-4 sm:w-5 sm:h-5 text-jade" /> : formattedNum}
                          </div>

                          {/* Lesson Info */}
                          <div className="flex-1 min-w-0">
                            <div className="flex flex-wrap items-center gap-1.5 sm:gap-2 mb-1">
                              <h3 className="font-serif font-bold text-sm sm:text-base text-title group-hover:text-app-accent transition-colors truncate">
                                {lesson.title}
                              </h3>

                              {/* Status Badge */}
                              {isLoggedIn && isCompleted && (
                                <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-serif font-medium bg-jade-soft text-jade border border-jade/20">
                                  <CheckCircle2 className="w-2.5 h-2.5" />
                                  Đã học xong
                                </span>
                              )}
                              {isLoggedIn && isInProgress && (
                                <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-serif font-medium bg-amber-50 text-amber-700 border border-amber-200/50">
                                  <Sparkles className="w-2.5 h-2.5" />
                                  Đang học ({learnedCount}/{lesson.vocab_count})
                                </span>
                              )}
                            </div>

                            {lesson.subtitle && (
                              <p className="text-xs text-muted font-serif line-clamp-1 mb-2">
                                {lesson.subtitle}
                              </p>
                            )}

                            {/* Meta & Mini Progress */}
                            <div className="flex items-center gap-3 text-xs font-serif text-muted">
                              <span className="inline-flex items-center gap-1 bg-page px-2 py-0.5 rounded-md border border-border text-[11px] text-body">
                                <WholeWord className="w-3 h-3 text-muted" />
                                {lesson.vocab_count} từ vựng
                              </span>

                              {isLoggedIn && isInProgress && (
                                <div className="hidden sm:flex items-center gap-2">
                                  <span className="text-[11px] text-muted">Tiến độ bài:</span>
                                  <div className="w-20 bg-track h-1.5 rounded-full overflow-hidden">
                                    <div 
                                      className="bg-amber-500 h-full rounded-full" 
                                      style={{ width: `${Math.min(100, Math.round((learnedCount / lesson.vocab_count) * 100))}%` }} 
                                    />
                                  </div>
                                </div>
                              )}
                            </div>
                          </div>

                          {/* Arrow CTA */}
                          <div className="shrink-0 w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-page group-hover:bg-app-accent group-hover:text-white text-muted flex items-center justify-center transition-colors">
                            <ChevronRight className="w-3.5 h-3.5 sm:w-4 sm:h-4 group-hover:translate-x-0.5 transition-transform" />
                          </div>

                        </div>
                      </Link>
                    )
                  })}

                  {/* Điều khiển phân trang / tải thêm bài học khi danh sách lớn */}
                  {!searchQuery.trim() && filteredLessons.length > visibleLessonsCount && (
                    <div className="flex flex-col sm:flex-row items-center justify-between gap-3 p-4 rounded-2xl bg-card border border-border mt-4 shadow-2xs">
                      <span className="text-xs font-serif text-muted">
                        Đang hiển thị <strong>{Math.min(visibleLessonsCount, filteredLessons.length)}</strong> trên tổng số <strong>{filteredLessons.length}</strong> bài học
                      </span>
                      <div className="flex items-center gap-2">
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => setVisibleLessonsCount((prev) => prev + 24)}
                          className="font-serif text-xs border-border hover:bg-page"
                        >
                          Xem thêm 24 bài tiếp theo
                        </Button>
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => setVisibleLessonsCount(filteredLessons.length)}
                          className="font-serif text-xs text-muted hover:text-title"
                        >
                          Xem tất cả ({filteredLessons.length} bài)
                        </Button>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          )}

          {/* TAB 2: VOCABULARY LIST */}
          {activeTab === 'vocab' && (
            <div className="space-y-4">
              {/* Vocab Search Toolbar */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div className="relative max-w-md w-full">
                  <Search className="w-4 h-4 text-muted absolute left-3 top-1/2 -translate-y-1/2 pointer-events-none" />
                  <input
                    type="text"
                    value={vocabSearchQuery}
                    onChange={(e) => {
                      setVocabSearchQuery(e.target.value)
                      setVocabPage(1)
                    }}
                    placeholder="Tìm từ vựng (chữ Hán, Pinyin hoặc nghĩa tiếng Việt)..."
                    className="w-full pl-9 pr-8 py-2 rounded-xl text-xs sm:text-sm font-serif bg-card border border-border text-title placeholder:text-muted focus:outline-none focus:border-app-accent/60 transition-colors shadow-2xs"
                  />
                  {vocabSearchQuery && (
                    <button
                      type="button"
                      onClick={() => {
                        setVocabSearchQuery('')
                        setVocabPage(1)
                      }}
                      className="absolute right-2.5 top-1/2 -translate-y-1/2 text-muted hover:text-title"
                      title="Xóa tìm kiếm"
                    >
                      <X className="w-3.5 h-3.5" />
                    </button>
                  )}
                </div>

                <div className="flex items-center gap-3 shrink-0">
                  <AudioSpeedSelector variant="dropdown" size="sm" />
                  <div className="text-xs text-muted font-serif">
                    Tổng cộng: <strong className="text-title">{vocabTotalCount}</strong> từ vựng
                  </div>
                </div>
              </div>

              {isLoadingVocabs ? (
                <div className="p-12 rounded-2xl border border-border bg-card/60 text-center space-y-3">
                  <Loader2 className="w-8 h-8 text-app-accent animate-spin mx-auto opacity-70" />
                  <p className="text-xs sm:text-sm font-serif text-muted">Đang tải danh sách từ vựng...</p>
                </div>
              ) : vocabList.length === 0 ? (
                <div className="p-10 rounded-2xl border border-dashed border-border bg-card/60 text-center space-y-2">
                  <WholeWord className="w-10 h-10 text-muted mx-auto opacity-50" />
                  <p className="text-sm font-serif text-title">Không tìm thấy từ vựng phù hợp</p>
                  <p className="text-xs text-muted font-serif">Thử lại với từ khóa khác.</p>
                </div>
              ) : (
                <>
                  <div className="space-y-3">
                    {vocabList.map((v, i) => {
                      const itemIndex = (vocabPage - 1) * 30 + i + 1
                      return (
                        <div 
                          key={v.id} 
                          className="p-3.5 sm:p-5 rounded-xl sm:rounded-2xl border border-border bg-card hover:border-app-accent/30 transition-all shadow-2xs group"
                        >
                          <div className="flex flex-col sm:flex-row sm:items-start gap-3 sm:gap-4">
                            
                            {/* Left: Index & Hanzi & Audio */}
                            <div className="flex items-center sm:items-start gap-2.5 sm:gap-3 sm:w-44 shrink-0">
                              <span className="text-xs font-serif text-muted/60 w-6 text-right shrink-0">
                                {itemIndex}
                              </span>
                              <div className="flex flex-col">
                                <div className="flex items-center gap-2">
                                  <span className="text-2xl sm:text-3xl font-serif font-bold text-title group-hover:text-app-accent transition-colors">
                                    {v.hanzi}
                                  </span>
                                  <AudioButton 
                                    text={v.hanzi} 
                                    id={`topic-v-${v.id}`} 
                                    size="xs" 
                                    variant="ghost" 
                                    tooltip="Phát âm từ vựng" 
                                  />
                                </div>
                                <span className="text-xs sm:text-sm font-sans text-app-accent/80 tracking-wide mt-0.5">
                                  {v.pinyin}
                                </span>
                              </div>
                            </div>

                            {/* Right: Meaning & Example Sentences */}
                            <div className="flex-1 min-w-0 sm:border-l sm:border-border sm:pl-5 space-y-2.5 pt-2 sm:pt-0">
                              <div className="flex items-center justify-between gap-2 flex-wrap">
                                <p className="text-sm sm:text-base font-serif font-medium text-title">
                                  {v.meaning_vi}
                                </p>
                                {v.word_type && (
                                  <span className="px-2 py-0.5 rounded-full text-[11px] font-sans font-medium bg-app-accent/10 text-app-accent border border-app-accent/20">
                                    {v.word_type}
                                  </span>
                                )}
                              </div>

                              {/* Multi-Example Sentences List */}
                              {v.examples && v.examples.length > 0 ? (
                                <div className="space-y-2 mt-2">
                                  {v.examples.map((ex, exIdx) => {
                                    const isBasic = ex.difficulty_level === 'basic' || exIdx === 0
                                    return (
                                      <div 
                                        key={ex.id || `ex-${v.id}-${exIdx}`} 
                                        className="p-3 rounded-xl bg-page/70 border border-border/80 space-y-1.5 transition-colors hover:border-app-accent/30"
                                      >
                                        <div className="flex items-center justify-between gap-2">
                                          <div className="flex items-center gap-2 flex-wrap">
                                            <span className={`px-1.5 py-0.5 rounded text-[10px] font-sans font-semibold uppercase tracking-wider ${
                                              isBasic 
                                                ? 'bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 border border-emerald-500/20' 
                                                : 'bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20'
                                            }`}>
                                              {isBasic ? 'Ví dụ 1 (Cơ bản)' : 'Ví dụ 2 (Ứng dụng)'}
                                            </span>
                                            <span className="text-sm sm:text-base font-serif text-title font-medium">
                                              {ex.chinese}
                                            </span>
                                          </div>
                                          <AudioButton 
                                            text={ex.chinese} 
                                            id={`topic-ex-${v.id}-${exIdx}`} 
                                            size="xs" 
                                            variant="subtle" 
                                            tooltip="Nghe câu ví dụ" 
                                          />
                                        </div>
                                        {ex.pinyin && (
                                          <p className="text-xs font-sans text-muted tracking-wide pl-0.5">
                                            {ex.pinyin}
                                          </p>
                                        )}
                                        {ex.meaning_vi && (
                                          <p className="text-xs sm:text-sm font-serif text-body italic pl-0.5">
                                            {ex.meaning_vi}
                                          </p>
                                        )}
                                      </div>
                                    )
                                  })}
                                </div>
                              ) : v.example_hanzi ? (
                                <div className="p-3 rounded-xl bg-page/70 border border-border/80 space-y-1 mt-2">
                                  <div className="flex items-center justify-between gap-2">
                                    <div className="flex items-center gap-2">
                                      <span className="px-1.5 py-0.5 rounded text-[10px] font-sans font-semibold bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 border border-emerald-500/20">
                                        Ví dụ
                                      </span>
                                      <span className="text-sm sm:text-base font-serif text-title font-medium">
                                        {v.example_hanzi}
                                      </span>
                                    </div>
                                    <AudioButton 
                                      text={v.example_hanzi} 
                                      id={`topic-ex-${v.id}`} 
                                      size="xs" 
                                      variant="subtle" 
                                      tooltip="Nghe câu ví dụ" 
                                    />
                                  </div>
                                  {v.example_pinyin && (
                                    <p className="text-xs font-sans text-muted tracking-wide">
                                      {v.example_pinyin}
                                    </p>
                                  )}
                                  {v.example_vi && (
                                    <p className="text-xs sm:text-sm font-serif text-body italic">
                                      {v.example_vi}
                                    </p>
                                  )}
                                </div>
                              ) : (
                                <div className="p-2.5 rounded-xl bg-page/40 border border-dashed border-border/60 text-xs text-muted font-serif italic mt-2 flex items-center gap-1.5">
                                  <Sparkles className="w-3.5 h-3.5 text-muted/60 shrink-0" />
                                  <span>Câu ví dụ thực tế đang được đồng bộ hóa...</span>
                                </div>
                              )}
                            </div>

                          </div>
                        </div>
                      )
                    })}
                  </div>

                  {/* Thanh phân trang từ vựng (Pagination Bar) */}
                  {vocabTotalCount > 30 && (
                    <div className="flex flex-col sm:flex-row items-center justify-between gap-3 p-3.5 sm:p-4 rounded-xl sm:rounded-2xl bg-card border border-border mt-4 shadow-2xs">
                      <span className="text-xs font-serif text-muted text-center sm:text-left">
                        Trang <strong>{vocabPage}</strong> / <strong>{Math.ceil(vocabTotalCount / 30)}</strong> ({vocabTotalCount} từ)
                      </span>

                      <div className="flex items-center justify-between sm:justify-end gap-2 w-full sm:w-auto">
                        <Button
                          variant="outline"
                          size="sm"
                          disabled={vocabPage <= 1 || isLoadingVocabs}
                          onClick={() => {
                            setVocabPage((p) => Math.max(1, p - 1))
                            window.scrollTo({ top: 350, behavior: 'smooth' })
                          }}
                          className="font-serif text-xs border-[#E9DDD1] hover:bg-[#FFF9F3] flex items-center justify-center gap-1 flex-1 sm:flex-initial min-h-[38px] px-3 active:scale-[0.98] touch-manipulation cursor-pointer"
                        >
                          <ChevronLeft className="w-3.5 h-3.5" />
                          <span>Trang trước</span>
                        </Button>

                        <Button
                          variant="outline"
                          size="sm"
                          disabled={!hasMoreVocabs || vocabPage >= Math.ceil(vocabTotalCount / 30) || isLoadingVocabs}
                          onClick={() => {
                            setVocabPage((p) => p + 1)
                            window.scrollTo({ top: 350, behavior: 'smooth' })
                          }}
                          className="font-serif text-xs border-[#E9DDD1] hover:bg-[#FFF9F3] flex items-center justify-center gap-1 flex-1 sm:flex-initial min-h-[38px] px-3 active:scale-[0.98] touch-manipulation cursor-pointer"
                        >
                          <span>Trang tiếp</span>
                          <ChevronRight className="w-3.5 h-3.5" />
                        </Button>
                      </div>
                    </div>
                  )}
                </>
              )}
            </div>
          )}
        </section>

        {/* 4. RECENT SAVED VOCABULARY SECTION (Preserved & Polished) */}
        {isLoggedIn && recentVocabs && recentVocabs.length > 0 && (
          <section className="space-y-4 pt-4 border-t border-border">
            <div className="flex items-center justify-between">
              <h2 className="text-base sm:text-lg font-serif font-bold text-title flex items-center gap-2">
                <Sparkles className="w-4 h-4 text-app-accent" />
                Từ vựng mới lưu trong cấp độ này
              </h2>
            </div>

            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
              {recentVocabs.map((word) => (
                <div 
                  key={word.hanzi} 
                  className="p-3.5 rounded-xl border border-border bg-card hover:border-app-accent/40 hover:shadow-2xs transition-all relative overflow-hidden flex flex-col items-center justify-center text-center group"
                >
                  <div className="absolute top-2 right-2 opacity-70 group-hover:opacity-100 transition-opacity">
                    <AudioButton 
                      text={word.hanzi} 
                      id={`recent-${word.hanzi}`} 
                      size="xs" 
                      variant="ghost" 
                      tooltip="Nghe phát âm" 
                    />
                  </div>
                  <span className="text-xs text-muted mb-1 font-sans">{word.pinyin}</span>
                  <span className="text-2xl font-serif font-bold text-title group-hover:text-app-accent transition-colors mb-1">
                    {word.hanzi}
                  </span>
                  <span className="text-xs text-body font-serif line-clamp-1 px-1">
                    {word.vi}
                  </span>
                </div>
              ))}
            </div>
          </section>
        )}

      </div>
      )}
    </div>
  )
}
