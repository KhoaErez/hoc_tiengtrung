'use client'

import { useState, useMemo } from 'react'
import Link from 'next/link'
import { 
  BookOpen, 
  Search, 
  CheckCircle2, 
  ChevronRight, 
  Sparkles, 
  Keyboard, 
  BrainCircuit, 
  ArrowRight,
  Filter,
  GraduationCap,
  Clock,
  Layers
} from 'lucide-react'
import { HskLevelInfo, HSK_LEVELS } from '@/data/hsk-curriculum'
import { Button } from '@/components/ui/button'
import { useAuthModal } from '@/components/auth/auth-modal-context'

interface LessonItem {
  id: string
  title: string
  subtitle: string | null
  lesson_number: number
  vocab_count: number
  learned_vocab_count: number
  is_completed: boolean
}

interface HskLevelClientProps {
  levelInfo: HskLevelInfo
  lessons: LessonItem[]
  stats: {
    totalLessons: number
    completedLessons: number
    totalLearnedVocabs: number
    targetVocab: number
  }
  isLoggedIn: boolean
}

export default function HskLevelClient({
  levelInfo,
  lessons,
  stats,
  isLoggedIn,
}: HskLevelClientProps) {
  const { openLoginForm } = useAuthModal()
  const [searchQuery, setSearchQuery] = useState('')
  const [statusFilter, setStatusFilter] = useState<'all' | 'completed' | 'not_started'>('all')
  const [sortBy, setSortBy] = useState<'asc' | 'desc' | 'vocab'>('asc')

  // Filter & sort logic
  const filteredLessons = useMemo(() => {
    let result = [...lessons]

    // 1. Text search
    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase().trim()
      result = result.filter(l => 
        l.title.toLowerCase().includes(q) ||
        (l.subtitle && l.subtitle.toLowerCase().includes(q)) ||
        l.lesson_number.toString() === q ||
        `bài ${l.lesson_number}`.includes(q)
      )
    }

    // 2. Status filter
    if (isLoggedIn) {
      if (statusFilter === 'completed') {
        result = result.filter(l => l.is_completed)
      } else if (statusFilter === 'not_started') {
        result = result.filter(l => l.learned_vocab_count === 0)
      }
    }

    // 3. Sort
    if (sortBy === 'asc') {
      result.sort((a, b) => a.lesson_number - b.lesson_number)
    } else if (sortBy === 'desc') {
      result.sort((a, b) => b.lesson_number - a.lesson_number)
    } else if (sortBy === 'vocab') {
      result.sort((a, b) => b.vocab_count - a.vocab_count)
    }

    return result
  }, [lessons, searchQuery, statusFilter, sortBy, isLoggedIn])

  const vocabPercent = isLoggedIn
    ? Math.min(100, Math.round((stats.totalLearnedVocabs / stats.targetVocab) * 100))
    : 0

  const lessonPercent = isLoggedIn && stats.totalLessons > 0
    ? Math.min(100, Math.round((stats.completedLessons / stats.totalLessons) * 100))
    : 0

  return (
    <div className="space-y-8">
      
      {/* 1. Breadcrumbs */}
      <nav className="flex items-center gap-2 text-xs font-serif text-muted">
        <Link href="/" className="hover:text-app-accent transition-colors">Trang chủ</Link>
        <ChevronRight className="w-3.5 h-3.5 text-muted/60" />
        <span className="text-body">Lộ trình HSK</span>
        <ChevronRight className="w-3.5 h-3.5 text-muted/60" />
        <span className="font-bold text-title">{levelInfo.name}</span>
      </nav>

      {/* 2. Thanh chuyển đổi nhanh giữa các cấp độ HSK 3.0 */}
      <div className="flex items-center gap-2 overflow-x-auto pb-2 no-scrollbar border-b border-border">
        {([1, 2, 3, 4, 5, 6, 7] as const).map((num) => {
          const isActive = num === levelInfo.level
          const item = HSK_LEVELS[num]
          if (!item) return null
          return (
            <Link
              key={num}
              href={`/hsk/${num}`}
              className={`px-4 py-2 rounded-xl text-xs md:text-sm font-serif font-medium whitespace-nowrap transition-all flex items-center gap-2 border ${
                isActive
                  ? 'bg-title text-white border-title shadow-2xs font-bold'
                  : 'bg-card text-muted hover:text-title hover:bg-page border-border'
              }`}
            >
              <span>{item.name}</span>
              <span className={`text-[10px] px-1.5 py-0.5 rounded-md ${
                isActive ? 'bg-white/20 text-white' : 'bg-black/5 text-muted'
              }`}>
                {item.stage}
              </span>
            </Link>
          )
        })}
      </div>

      {/* 3. Hero Header giới thiệu cấp độ */}
      <div className="relative rounded-2xl border border-border bg-card p-6 md:p-8 overflow-hidden shadow-2xs">
        {/* Viền màu trên cùng */}
        <div className={`absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r ${levelInfo.color.progressFrom} ${levelInfo.color.progressTo}`} />

        <div className="flex flex-col lg:flex-row lg:items-start justify-between gap-6">
          <div className="space-y-3 max-w-2xl">
            <div className="flex items-center gap-3">
              <span className={`px-3 py-1 rounded-xl text-sm font-serif font-bold ${levelInfo.color.badgeBg}`}>
                {levelInfo.name}
              </span>
              <span className="text-xs font-serif text-muted px-2.5 py-0.5 rounded-md bg-page border border-border">
                {levelInfo.stage}
              </span>
            </div>

            <h1 className="text-2xl md:text-3xl font-serif font-bold text-title">
              {levelInfo.title}
            </h1>

            <p className="text-sm font-serif text-body leading-relaxed">
              {levelInfo.description}
            </p>
            <p className="text-xs font-serif text-muted italic">
              🎯 Mục tiêu: {levelInfo.detailGoal}
            </p>
          </div>

          {/* Hộp hành động nhanh (Luyện gõ / Ôn tập) */}
          <div className="flex sm:flex-col gap-2.5 flex-shrink-0">
            <Link href="/typing">
              <Button variant="outline" size="sm" className="w-full font-serif text-xs gap-2 rounded-xl border-border hover:border-jade/50 hover:bg-jade/5 text-title">
                <Keyboard className="w-4 h-4 text-jade" />
                <span>Luyện gõ Pinyin</span>
              </Button>
            </Link>
            <Link href="/review">
              <Button size="sm" className="w-full font-serif text-xs gap-2 rounded-xl bg-app-accent hover:bg-accent-hover text-white shadow-2xs">
                <BrainCircuit className="w-4 h-4" />
                <span>Ôn tập từ vựng</span>
              </Button>
            </Link>
          </div>
        </div>

        {/* Thống kê tiến độ */}
        <div className="mt-6 pt-6 border-t border-border/80 grid grid-cols-2 sm:grid-cols-4 gap-4">
          <div className="p-3 rounded-xl bg-page/70 border border-border/60">
            <p className="text-xs text-muted font-serif">Tổng bài học</p>
            <p className="text-xl font-serif font-bold text-title mt-0.5">{stats.totalLessons} bài</p>
          </div>
          <div className="p-3 rounded-xl bg-page/70 border border-border/60">
            <p className="text-xs text-muted font-serif">Mục tiêu từ vựng</p>
            <p className="text-xl font-serif font-bold text-app-accent mt-0.5">{stats.targetVocab} từ</p>
          </div>
          <div className="p-3 rounded-xl bg-page/70 border border-border/60">
            <p className="text-xs text-muted font-serif">Từ vựng đã học</p>
            <p className="text-xl font-serif font-bold text-jade mt-0.5">
              {isLoggedIn ? `${stats.totalLearnedVocabs} (${vocabPercent}%)` : '---'}
            </p>
          </div>
          <div className="p-3 rounded-xl bg-page/70 border border-border/60">
            <p className="text-xs text-muted font-serif">Bài hoàn thành</p>
            <p className="text-xl font-serif font-bold text-gold mt-0.5">
              {isLoggedIn ? `${stats.completedLessons}/${stats.totalLessons}` : '---'}
            </p>
          </div>
        </div>

        {/* Thanh tiến độ tổng quan */}
        <div className="mt-4 space-y-1.5">
          <div className="flex items-center justify-between text-xs font-serif text-muted">
            <span>Tiến độ hoàn thành từ vựng cấp độ</span>
            {isLoggedIn ? (
              <span className="font-bold text-title">{vocabPercent}%</span>
            ) : (
              <button
                type="button"
                onClick={() => openLoginForm()}
                className="font-bold text-app-accent hover:text-accent-hover underline underline-offset-2 cursor-pointer"
              >
                Đăng nhập để theo dõi
              </button>
            )}
          </div>
          <div className="w-full bg-track h-2 rounded-full overflow-hidden">
            <div 
              className={`h-full rounded-full bg-gradient-to-r ${levelInfo.color.progressFrom} ${levelInfo.color.progressTo} transition-all duration-500`}
              style={{ width: `${isLoggedIn ? vocabPercent : 0}%` }}
            />
          </div>
        </div>
      </div>

      {/* 4. Bộ lọc, tìm kiếm và điều khiển danh sách bài học */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pt-2">
        {/* Tìm kiếm */}
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-muted" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Tìm theo số bài, tên tiếng Trung, phiên âm..."
            className="w-full pl-10 pr-4 py-2 rounded-xl border border-border bg-card text-title font-serif text-sm focus:outline-none focus:border-app-accent placeholder:text-muted"
          />
          {searchQuery && (
            <button
              onClick={() => setSearchQuery('')}
              className="absolute right-3 top-1/2 -translate-y-1/2 text-xs text-muted hover:text-title"
            >
              Xóa
            </button>
          )}
        </div>

        {/* Lọc trạng thái & Sắp xếp */}
        <div className="flex flex-wrap items-center gap-2">
          {isLoggedIn && (
            <div className="flex items-center bg-card border border-border rounded-xl p-1 text-xs font-serif">
              <button
                onClick={() => setStatusFilter('all')}
                className={`px-3 py-1 rounded-lg transition-colors ${
                  statusFilter === 'all' ? 'bg-title text-white font-bold' : 'text-muted hover:text-title'
                }`}
              >
                Tất cả ({lessons.length})
              </button>
              <button
                onClick={() => setStatusFilter('completed')}
                className={`px-3 py-1 rounded-lg transition-colors ${
                  statusFilter === 'completed' ? 'bg-title text-white font-bold' : 'text-muted hover:text-title'
                }`}
              >
                Đã học ({stats.completedLessons})
              </button>
              <button
                onClick={() => setStatusFilter('not_started')}
                className={`px-3 py-1 rounded-lg transition-colors ${
                  statusFilter === 'not_started' ? 'bg-title text-white font-bold' : 'text-muted hover:text-title'
                }`}
              >
                Chưa học ({lessons.length - stats.completedLessons})
              </button>
            </div>
          )}

          {/* Sắp xếp */}
          <select
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value as 'asc' | 'desc' | 'vocab')}
            className="px-3 py-2 rounded-xl border border-border bg-card text-title font-serif text-xs focus:outline-none focus:border-app-accent"
          >
            <option value="asc">Bài: Số nhỏ &rarr; lớn</option>
            <option value="desc">Bài: Số lớn &rarr; nhỏ</option>
            <option value="vocab">Nhiều từ vựng nhất</option>
          </select>
        </div>
      </div>

      {/* 5. Danh sách thẻ bài học */}
      {filteredLessons.length === 0 ? (
        <div className="p-12 text-center rounded-2xl border border-dashed border-border bg-card space-y-3">
          <BookOpen className="w-10 h-10 text-muted mx-auto" />
          <p className="font-serif text-title font-bold text-lg">Không tìm thấy bài học phù hợp</p>
          <p className="text-xs text-muted font-serif">
            Thử thay đổi từ khóa tìm kiếm hoặc bỏ bộ lọc hiện tại.
          </p>
          <Button
            variant="outline"
            size="sm"
            onClick={() => { setSearchQuery(''); setStatusFilter('all'); }}
            className="font-serif text-xs rounded-xl"
          >
            Đặt lại bộ lọc
          </Button>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {filteredLessons.map((lesson) => {
            const isFinished = lesson.is_completed
            const inProgress = lesson.learned_vocab_count > 0 && !isFinished

            return (
              <Link
                key={lesson.id}
                href={`/lessons/${lesson.id}`}
                className="group flex flex-col justify-between p-5 rounded-2xl border border-border bg-card hover:border-app-accent/50 hover:shadow-md transition-all duration-200"
              >
                <div className="space-y-3">
                  {/* Badge số bài & Trạng thái */}
                  <div className="flex items-center justify-between">
                    <span className="px-2.5 py-1 rounded-lg bg-page border border-border text-xs font-serif font-bold text-title">
                      Bài {lesson.lesson_number < 10 ? `0${lesson.lesson_number}` : lesson.lesson_number}
                    </span>

                    {isLoggedIn && (
                      <div>
                        {isFinished ? (
                          <span className="inline-flex items-center gap-1 text-[11px] font-serif font-medium text-emerald-700 dark:text-emerald-400 bg-emerald-50 dark:bg-emerald-950/40 px-2 py-0.5 rounded-full border border-emerald-500/30">
                            <CheckCircle2 className="w-3 h-3" />
                            Đã thuộc
                          </span>
                        ) : inProgress ? (
                          <span className="inline-flex items-center gap-1 text-[11px] font-serif font-medium text-amber-700 dark:text-amber-400 bg-amber-50 dark:bg-amber-950/40 px-2 py-0.5 rounded-full border border-amber-500/30">
                            Đang học ({lesson.learned_vocab_count}/{lesson.vocab_count})
                          </span>
                        ) : (
                          <span className="text-[11px] font-serif text-muted">
                            Chưa học
                          </span>
                        )}
                      </div>
                    )}
                  </div>

                  {/* Tiêu đề bài học */}
                  <div>
                    <h3 className="font-serif font-bold text-lg text-title group-hover:text-app-accent transition-colors line-clamp-1">
                      {lesson.title}
                    </h3>
                    {lesson.subtitle && (
                      <p className="text-xs text-muted font-serif line-clamp-1 mt-0.5">
                        {lesson.subtitle}
                      </p>
                    )}
                  </div>
                </div>

                {/* Footer thẻ bài học */}
                <div className="pt-4 mt-4 border-t border-border/70 flex items-center justify-between">
                  <div className="flex items-center gap-1.5 text-xs text-muted font-serif">
                    <BookOpen className="w-3.5 h-3.5 text-app-accent" />
                    <span><strong>{lesson.vocab_count}</strong> từ vựng</span>
                  </div>

                  <span className="text-xs font-serif font-medium text-app-accent group-hover:text-accent-hover flex items-center gap-1">
                    <span>Học bài này</span>
                    <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
                  </span>
                </div>
              </Link>
            )
          })}
        </div>
      )}

    </div>
  )
}
