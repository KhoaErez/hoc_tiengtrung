'use client'

import { useState, useMemo } from 'react'
import Link from 'next/link'
import { 
  BookOpen, 
  CheckCircle2, 
  ChevronRight, 
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
  Filter
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { AudioButton } from '@/components/ui/audio-button'
import { HSK_LEVELS } from '@/data/hsk-curriculum'
import { useAuthModal } from '@/components/auth/auth-modal-context'

const HSK_TOTAL_VOCAB: Record<string, number> = {
  'HSK 1': 150,
  'HSK 2': 150,
  'HSK 3': 300,
  'HSK 4': 600,
  'HSK 5': 1300,
  'HSK 6': 2500,
  'Giao tiếp': 150,
  'Công xưởng': 150,
}

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
  isLoggedIn: boolean
}

export default function HskDashboardClient({
  currentHsk,
  lessons,
  userVocabCount,
  reviewVocabCount,
  recentVocabs = [],
  globalVocabs = [],
  isLoggedIn,
}: HskDashboardClientProps) {
  const { openLoginForm } = useAuthModal()
  const [activeTab, setActiveTab] = useState<'lessons' | 'vocab'>('lessons')
  const [searchQuery, setSearchQuery] = useState('')
  const [statusFilter, setStatusFilter] = useState<'all' | 'in_progress' | 'completed' | 'not_started'>('all')
  const [vocabSearchQuery, setVocabSearchQuery] = useState('')

  // Level info from curriculum
  const levelNum = parseInt(currentHsk.replace('HSK ', ''), 10)
  const levelInfo = !isNaN(levelNum) ? HSK_LEVELS[levelNum] : null

  const stage = levelInfo 
    ? levelInfo.stage 
    : currentHsk === 'Giao tiếp' 
    ? 'Thực hành' 
    : 'Chuyên ngành'

  const description = levelInfo 
    ? levelInfo.description 
    : currentHsk === 'Giao tiếp'
    ? 'Các bài học đàm thoại và mẫu câu giao tiếp tiếng Trung theo tình huống sinh hoạt thực tế.'
    : 'Hệ thống từ vựng và thuật ngữ chuyên ngành sản xuất, nhà máy, công xưởng và an toàn lao động.'

  const totalVocab = levelInfo?.vocabTarget || HSK_TOTAL_VOCAB[currentHsk] || 150
  const progressPercent = Math.min(100, Math.round((userVocabCount / totalVocab) * 100))

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

  // Filter vocabs
  const filteredVocabs = useMemo(() => {
    if (!vocabSearchQuery.trim()) return globalVocabs
    const q = vocabSearchQuery.toLowerCase().trim()
    return globalVocabs.filter(v =>
      v.hanzi.includes(q) ||
      v.pinyin.toLowerCase().includes(q) ||
      v.meaning_vi.toLowerCase().includes(q)
    )
  }, [globalVocabs, vocabSearchQuery])

  const levelTabs = [
    'HSK 1',
    'HSK 2',
    'HSK 3',
    'HSK 4',
    'HSK 5',
    'HSK 6',
    'Giao tiếp',
    'Công xưởng',
  ]

  return (
    <div className="min-h-full font-serif space-y-8 pb-12">
      
      {/* 1. LEVEL SELECTOR TAB BAR (Sticky, Glassmorphic on scroll) */}
      <div className="bg-page/90 backdrop-blur-md sticky top-0 z-20 -mx-4 md:-mx-8 lg:-mx-10 px-4 md:px-8 lg:px-10 py-3 border-b border-border transition-all">
        <div className="max-w-5xl mx-auto">
          <div className="flex items-center gap-1.5 sm:gap-2 overflow-x-auto no-scrollbar py-0.5 scroll-smooth">
            {levelTabs.map((level) => {
              const isActive = currentHsk === level
              return (
                <Link 
                  key={level} 
                  href={`/topics?q=${encodeURIComponent(level)}`}
                  className={`px-3.5 sm:px-4 py-1.5 sm:py-2 text-xs sm:text-sm font-serif rounded-xl border whitespace-nowrap transition-all duration-150 flex items-center shrink-0 select-none ${
                    isActive 
                      ? 'border-app-accent bg-app-accent-soft text-app-accent font-bold shadow-2xs' 
                      : 'border-border bg-card text-muted hover:text-title hover:bg-black/5 hover:border-title/30'
                  }`}
                >
                  <span 
                    className={`w-1.5 h-1.5 rounded-full mr-1.5 transition-colors ${
                      isActive ? 'bg-app-accent' : 'bg-border-strong'
                    }`} 
                  />
                  <span>{level}</span>
                </Link>
              )
            })}
          </div>
        </div>
      </div>

      <div className="space-y-8">
        
        {/* 2. HERO OVERVIEW & ACTION CARD */}
        <section className="bg-card border border-border p-6 sm:p-8 rounded-2xl shadow-2xs relative overflow-hidden transition-all">
          {/* Top accent bar */}
          <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-app-accent via-app-accent/80 to-gold" />

          <div className="flex flex-col lg:flex-row lg:items-start justify-between gap-6">
            <div className="space-y-3 max-w-2xl">
              {/* Badges */}
              <div className="flex flex-wrap items-center gap-2">
                <span className="px-2.5 py-0.5 rounded-lg text-xs font-serif font-bold bg-app-accent-soft text-app-accent border border-app-accent/20">
                  {currentHsk}
                </span>
                <span className="px-2.5 py-0.5 rounded-lg text-[11px] font-serif text-muted bg-page border border-border">
                  {stage}
                </span>
                <span className="text-xs text-muted font-serif flex items-center gap-1">
                  <span>•</span>
                  <span>Mục tiêu: <strong>{totalVocab}</strong> từ vựng</span>
                  <span>•</span>
                  <span><strong>{lessons.length}</strong> bài học</span>
                </span>
              </div>

              {/* Title & Description */}
              <h1 className="text-2xl sm:text-3xl font-serif font-bold text-title tracking-tight">
                Lộ trình {currentHsk}
              </h1>
              <p className="text-xs sm:text-sm text-body font-serif leading-relaxed">
                {description}
              </p>
            </div>

            {/* Smart Call To Action */}
            <div className="shrink-0 w-full sm:w-auto">
              {isLoggedIn ? (
                reviewVocabCount > 0 ? (
                  <Link href="/review" className="block">
                    <Button className="w-full sm:w-auto font-serif bg-app-accent hover:bg-accent-hover text-white rounded-xl py-5 px-6 shadow-xs text-sm group flex items-center justify-center gap-2">
                      <Flame className="w-4 h-4 text-white animate-pulse" />
                      <span>Ôn tập {reviewVocabCount} từ vựng</span>
                      <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                    </Button>
                  </Link>
                ) : nextLesson ? (
                  <Link href={`/lessons/${nextLesson.id}`} className="block">
                    <Button className="w-full sm:w-auto font-serif bg-title hover:bg-[#2A3250] text-white rounded-xl py-5 px-6 shadow-xs text-sm group flex items-center justify-center gap-2">
                      <PlayCircle className="w-4 h-4 text-white" />
                      <span>
                        {(nextLesson.learned_vocab_count || 0) > 0 ? 'Tiếp tục học:' : 'Bắt đầu:'} Bài {nextLesson.lesson_number || (nextLessonIndex + 1)}
                      </span>
                      <ChevronRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                    </Button>
                  </Link>
                ) : (
                  <div className="inline-flex items-center gap-2 px-4 py-2.5 rounded-xl bg-jade-soft text-jade border border-jade/30 text-xs font-serif font-bold">
                    <CheckCircle2 className="w-4 h-4" />
                    <span>Đã hoàn thành toàn bộ bài học!</span>
                  </div>
                )
              ) : (
                <Button 
                  type="button"
                  onClick={() => openLoginForm()}
                  className="w-full sm:w-auto font-serif bg-title hover:bg-[#2A3250] text-white rounded-xl py-5 px-6 shadow-xs text-sm flex items-center justify-center gap-2 cursor-pointer"
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
                    Tiến độ từ vựng
                  </span>
                  <span className="font-bold text-title">
                    {userVocabCount} / {totalVocab} từ ({progressPercent}%)
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
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-border pb-3">
            <div className="inline-flex p-1 rounded-xl bg-card border border-border gap-1">
              <button
                type="button"
                onClick={() => setActiveTab('lessons')}
                className={`flex items-center gap-2 px-4 py-2 rounded-lg text-xs sm:text-sm font-serif font-medium transition-all ${
                  activeTab === 'lessons'
                    ? 'bg-title text-white shadow-2xs font-bold'
                    : 'text-muted hover:text-title hover:bg-black/5'
                }`}
              >
                <Layers className="w-4 h-4" />
                <span>Lộ trình bài học ({lessons.length})</span>
              </button>

              <button
                type="button"
                onClick={() => setActiveTab('vocab')}
                className={`flex items-center gap-2 px-4 py-2 rounded-lg text-xs sm:text-sm font-serif font-medium transition-all ${
                  activeTab === 'vocab'
                    ? 'bg-title text-white shadow-2xs font-bold'
                    : 'text-muted hover:text-title hover:bg-black/5'
                }`}
              >
                <WholeWord className="w-4 h-4" />
                <span>Từ vựng cấp độ ({globalVocabs.length})</span>
              </button>
            </div>

            {/* Stats summary label */}
            <div className="text-xs text-muted font-serif hidden md:block">
              {activeTab === 'lessons' 
                ? `Đang hiển thị ${filteredLessons.length} bài học`
                : `Đang hiển thị ${filteredVocabs.length} từ vựng`
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
                      className={`px-2.5 py-1 rounded-lg text-xs font-serif transition-colors whitespace-nowrap border ${
                        statusFilter === 'all'
                          ? 'bg-title text-white border-title font-medium'
                          : 'bg-card text-muted hover:text-title border-border'
                      }`}
                    >
                      Tất cả ({lessons.length})
                    </button>
                    <button
                      type="button"
                      onClick={() => setStatusFilter('in_progress')}
                      className={`px-2.5 py-1 rounded-lg text-xs font-serif transition-colors whitespace-nowrap border ${
                        statusFilter === 'in_progress'
                          ? 'bg-amber-600 text-white border-amber-600 font-medium'
                          : 'bg-card text-muted hover:text-title border-border'
                      }`}
                    >
                      Đang học ({inProgressLessonsCount})
                    </button>
                    <button
                      type="button"
                      onClick={() => setStatusFilter('completed')}
                      className={`px-2.5 py-1 rounded-lg text-xs font-serif transition-colors whitespace-nowrap border ${
                        statusFilter === 'completed'
                          ? 'bg-jade text-white border-jade font-medium'
                          : 'bg-card text-muted hover:text-title border-border'
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
                  {filteredLessons.map((lesson, idx) => {
                    const lessonNum = lesson.lesson_number ?? (idx + 1)
                    const formattedNum = String(lessonNum).padStart(2, '0')
                    const isCompleted = lesson.is_completed
                    const learnedCount = lesson.learned_vocab_count || 0
                    const isInProgress = !isCompleted && learnedCount > 0

                    return (
                      <Link
                        key={lesson.id}
                        href={`/lessons/${lesson.id}`}
                        className="group block p-4 sm:p-5 rounded-2xl border border-border bg-card hover:border-app-accent/40 hover:shadow-xs hover:-translate-y-0.5 transition-all duration-200 relative overflow-hidden"
                      >
                        <div className="flex items-center gap-3.5 sm:gap-5 justify-between">
                          
                          {/* Index Number Badge */}
                          <div 
                            className={`w-10 h-10 sm:w-11 sm:h-11 rounded-xl flex items-center justify-center font-serif font-bold text-sm sm:text-base shrink-0 transition-colors border ${
                              isCompleted
                                ? 'bg-jade-soft text-jade border-jade/30'
                                : isInProgress
                                ? 'bg-amber-50 text-amber-700 border-amber-200/60'
                                : 'bg-page text-title border-border group-hover:border-app-accent/30 group-hover:text-app-accent'
                            }`}
                          >
                            {isCompleted ? <CheckCircle2 className="w-5 h-5 text-jade" /> : formattedNum}
                          </div>

                          {/* Lesson Info */}
                          <div className="flex-1 min-w-0">
                            <div className="flex flex-wrap items-center gap-2 mb-1">
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
                          <div className="shrink-0 w-8 h-8 rounded-full bg-page group-hover:bg-app-accent group-hover:text-white text-muted flex items-center justify-center transition-colors">
                            <ChevronRight className="w-4 h-4 group-hover:translate-x-0.5 transition-transform" />
                          </div>

                        </div>
                      </Link>
                    )
                  })}
                </div>
              )}
            </div>
          )}

          {/* TAB 2: VOCABULARY LIST */}
          {activeTab === 'vocab' && (
            <div className="space-y-4">
              {/* Vocab Search Toolbar */}
              <div className="relative max-w-md">
                <Search className="w-4 h-4 text-muted absolute left-3 top-1/2 -translate-y-1/2 pointer-events-none" />
                <input
                  type="text"
                  value={vocabSearchQuery}
                  onChange={(e) => setVocabSearchQuery(e.target.value)}
                  placeholder="Tìm từ vựng (chữ Hán, Pinyin hoặc nghĩa tiếng Việt)..."
                  className="w-full pl-9 pr-8 py-2 rounded-xl text-xs sm:text-sm font-serif bg-card border border-border text-title placeholder:text-muted focus:outline-none focus:border-app-accent/60 transition-colors shadow-2xs"
                />
                {vocabSearchQuery && (
                  <button
                    type="button"
                    onClick={() => setVocabSearchQuery('')}
                    className="absolute right-2.5 top-1/2 -translate-y-1/2 text-muted hover:text-title"
                    title="Xóa tìm kiếm"
                  >
                    <X className="w-3.5 h-3.5" />
                  </button>
                )}
              </div>

              {filteredVocabs.length === 0 ? (
                <div className="p-10 rounded-2xl border border-dashed border-border bg-card/60 text-center space-y-2">
                  <WholeWord className="w-10 h-10 text-muted mx-auto opacity-50" />
                  <p className="text-sm font-serif text-title">Không tìm thấy từ vựng phù hợp</p>
                  <p className="text-xs text-muted font-serif">Thử lại với từ khóa khác.</p>
                </div>
              ) : (
                <div className="space-y-3">
                  {filteredVocabs.map((v, i) => (
                    <div 
                      key={v.id} 
                      className="p-4 sm:p-5 rounded-2xl border border-border bg-card hover:border-app-accent/30 transition-all shadow-2xs group"
                    >
                      <div className="flex flex-col sm:flex-row sm:items-start gap-4">
                        
                        {/* Left: Index & Hanzi & Audio */}
                        <div className="flex items-center sm:items-start gap-3 sm:w-44 shrink-0">
                          <span className="text-xs font-serif text-muted/60 w-5 text-right shrink-0">
                            {i + 1}
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

                        {/* Right: Meaning & Example Sentence */}
                        <div className="flex-1 min-w-0 sm:border-l sm:border-border sm:pl-5 space-y-2 pt-2 sm:pt-0">
                          <p className="text-sm sm:text-base font-serif font-medium text-title">
                            {v.meaning_vi}
                          </p>

                          {/* Example Sentence Box */}
                          {v.example_hanzi && (
                            <div className="p-3 rounded-xl bg-page/70 border border-border/80 space-y-1 mt-2">
                              <div className="flex items-center justify-between gap-2">
                                <span className="text-sm sm:text-base font-serif text-title font-medium">
                                  {v.example_hanzi}
                                </span>
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
                          )}
                        </div>

                      </div>
                    </div>
                  ))}
                </div>
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
    </div>
  )
}
