'use client'

import React, { useState, useMemo, useSyncExternalStore } from 'react'
import Link from 'next/link'
import {
  GraduationCap,
  Factory,
  Clock,
  BookOpen,
  Play,
  RotateCcw,
  CheckCircle2,
  ArrowRight,
  Layers,
  Sparkles,
  MessagesSquare,
  ListChecks,
} from 'lucide-react'
import {
  COURSE_UNITS,
  type CourseTrack,
  type CourseUnit,
  type CourseLesson,
} from '@/data/course-roadmap-data'
import {
  getAllCourseProgress,
  getCourseProgressServerSnapshot,
  subscribeCourseProgress,
  getCourseCtaLabel,
  type LessonPlayerProgressRecord,
} from '@/lib/course-progress-storage'

interface CourseRoadmapClientProps {
  initialTrack?: CourseTrack
  initialHskLevel?: number
  initialFactoryUnit?: string
}

export default function CourseRoadmapClient({
  initialTrack = 'hsk',
  initialHskLevel = 1,
  initialFactoryUnit = 'all',
}: CourseRoadmapClientProps) {
  const [track, setTrack] = useState<CourseTrack>(initialTrack)
  const [hskLevel, setHskLevel] = useState<number>(initialHskLevel)
  const [factoryUnitFilter, setFactoryUnitFilter] = useState<string>(initialFactoryUnit)
  const progressMap = useSyncExternalStore<Record<string, LessonPlayerProgressRecord>>(
    subscribeCourseProgress,
    getAllCourseProgress,
    getCourseProgressServerSnapshot
  )

  const syncUrl = (nextTrack: CourseTrack, nextLevel: number, nextUnit: string) => {
    if (typeof window === 'undefined') return
    const url = new URL(window.location.href)
    url.searchParams.set('track', nextTrack)
    if (nextTrack === 'hsk') {
      url.searchParams.set('level', String(nextLevel))
      url.searchParams.delete('unit')
    } else {
      url.searchParams.delete('level')
      if (nextUnit && nextUnit !== 'all') url.searchParams.set('unit', nextUnit)
      else url.searchParams.delete('unit')
    }
    window.history.replaceState({}, '', url.toString())
  }

  const handleTrackChange = (nextTrack: CourseTrack) => {
    setTrack(nextTrack)
    syncUrl(nextTrack, hskLevel, factoryUnitFilter)
  }

  const handleHskLevelChange = (lvl: number) => {
    setHskLevel(lvl)
    syncUrl('hsk', lvl, 'all')
  }

  const handleFactoryUnitChange = (unitId: string) => {
    setFactoryUnitFilter(unitId)
    syncUrl('factory', hskLevel, unitId)
  }

  const factoryUnits = useMemo(
    () => COURSE_UNITS.filter((u) => u.track === 'factory'),
    []
  )

  const visibleUnits: CourseUnit[] = useMemo(() => {
    if (track === 'hsk') {
      return COURSE_UNITS.filter((u) => u.track === 'hsk' && u.hskLevel === hskLevel)
    }
    if (factoryUnitFilter && factoryUnitFilter !== 'all') {
      return factoryUnits.filter((u) => u.id === factoryUnitFilter)
    }
    return factoryUnits
  }, [track, hskLevel, factoryUnits, factoryUnitFilter])

  // Tính thống kê nhanh toàn track đang xem
  const trackSummary = useMemo(() => {
    const allTrackLessons = COURSE_UNITS.filter((u) => u.track === track).flatMap((u) => u.lessons)
    const completedCount = allTrackLessons.filter((l) => progressMap[l.id]?.completed).length
    return {
      total: allTrackLessons.length,
      completed: completedCount,
    }
  }, [track, progressMap])

  const getTotalStepsForLesson = (lesson: CourseLesson) => {
    const writeCount = Array.isArray(lesson.writeWords)
      ? lesson.writeWords.length
      : lesson.vocabs.filter((v) => /[\u4e00-\u9fff]/.test(v.hanzi)).slice(0, 2).length
    return lesson.vocabs.length + writeCount + 1 + lesson.quizzes.length + 1
  }

  return (
    <div className="w-full space-y-6 pb-8">
      {/* 1. HEADER & BỘ CHUYỂN ĐỔI TRACK (HSK vs CÔNG XƯỞNG) */}
      <section className="bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl p-5 sm:p-7 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322] space-y-5">
        <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-4">
          <div className="space-y-1.5 max-w-2xl">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-300 dark:border-white/15 text-[11px] font-sans font-bold uppercase tracking-wider text-[#B91C1C]">
              <Sparkles className="w-3.5 h-3.5" />
              <span>Lộ trình bài học tương tác • 5–10 phút/bài</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-serif font-bold text-stone-900 dark:text-white tracking-tight">
              Học Từng Bài Theo Lộ Trình
            </h1>
            <p className="text-xs sm:text-sm font-serif text-stone-600 dark:text-slate-300 leading-relaxed">
              Mỗi bài học thiết kế gọn trong 4 bước liên hoàn: Từ vựng phát âm chậm, Hội thoại thực tế, Bài tập đa dạng (Nghe chọn, Ghép thẻ từ, Gõ IME) và Lưu thẳng vào lịch ôn tập SM-2.
            </p>
          </div>

          <div className="flex items-center gap-3 self-start lg:self-center shrink-0">
            <div className="px-4 py-2.5 rounded-2xl bg-[#FAF7F2] dark:bg-[#202B45] border-2 border-stone-900 dark:border-[#384869] text-left">
              <div className="text-[10px] font-sans font-bold uppercase tracking-wider text-stone-500 dark:text-slate-400">
                Tiến độ nhánh hiện tại
              </div>
              <div className="text-base sm:text-lg font-sans font-bold text-stone-900 dark:text-white tabular-nums">
                {trackSummary.completed} / {trackSummary.total}{' '}
                <span className="text-xs font-serif font-normal text-stone-600 dark:text-slate-300">
                  bài hoàn thành
                </span>
              </div>
            </div>
          </div>
        </div>

        {/* Track Switcher: Lộ trình HSK | Tiếng Trung Công Xưởng */}
        <div className="pt-2 border-t border-stone-200 dark:border-white/10 flex flex-col md:flex-row md:items-center justify-between gap-3">
          <div
            role="tablist"
            aria-label="Chọn nhánh lộ trình học"
            className="grid grid-cols-2 sm:inline-flex items-center gap-1.5 p-1.5 bg-[#FAF9F6] dark:bg-[#202B45] border-2 border-stone-900 dark:border-[#384869] rounded-2xl w-full sm:w-auto"
          >
            <button
              type="button"
              role="tab"
              aria-selected={track === 'hsk'}
              onClick={() => handleTrackChange('hsk')}
              className={`flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl text-xs sm:text-sm font-serif font-bold transition-all cursor-pointer touch-manipulation min-h-[42px] ${
                track === 'hsk'
                  ? 'bg-[#B91C1C] text-white shadow-xs'
                  : 'text-stone-700 dark:text-slate-200 hover:bg-white dark:hover:bg-white/10'
              }`}
            >
              <GraduationCap className="w-4 h-4 shrink-0" />
              <span>Lộ trình HSK</span>
            </button>

            <button
              type="button"
              role="tab"
              aria-selected={track === 'factory'}
              onClick={() => handleTrackChange('factory')}
              className={`flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl text-xs sm:text-sm font-serif font-bold transition-all cursor-pointer touch-manipulation min-h-[42px] ${
                track === 'factory'
                  ? 'bg-[#B91C1C] text-white shadow-xs'
                  : 'text-stone-700 dark:text-slate-200 hover:bg-white dark:hover:bg-white/10'
              }`}
            >
              <Factory className="w-4 h-4 shrink-0" />
              <span>Tiếng Trung Công Xưởng</span>
            </button>
          </div>

          {/* Sub-filter theo từng nhánh */}
          {track === 'hsk' ? (
            <div className="flex items-center gap-1.5 flex-wrap" aria-label="Chọn cấp độ HSK">
              {[1, 2, 3, 4, 5, 6].map((lvl) => {
                const lvlLessons = COURSE_UNITS.filter((u) => u.track === 'hsk' && u.hskLevel === lvl).flatMap(
                  (u) => u.lessons
                )
                const lvlDone = lvlLessons.filter((l) => progressMap[l.id]?.completed).length
                const isActive = hskLevel === lvl
                return (
                  <button
                    key={lvl}
                    type="button"
                    onClick={() => handleHskLevelChange(lvl)}
                    className={`px-3.5 py-2 rounded-xl text-xs font-serif font-bold border-2 transition-all cursor-pointer min-h-[40px] flex items-center gap-1.5 touch-manipulation ${
                      isActive
                        ? 'bg-stone-900 text-white border-stone-900 dark:bg-[#B91C1C] dark:border-[#B91C1C]'
                        : 'bg-white dark:bg-[#202B45] text-stone-800 dark:text-slate-200 border-stone-300 dark:border-white/15 hover:border-stone-900'
                    }`}
                  >
                    <span>HSK {lvl}</span>
                    {lvlLessons.length > 0 && (
                      <span
                        className={`text-[10px] font-sans px-1.5 py-0.2 rounded-full tabular-nums ${
                          isActive
                            ? 'bg-white/20 text-white'
                            : 'bg-stone-100 dark:bg-white/10 text-stone-600 dark:text-slate-300'
                        }`}
                      >
                        {lvlDone}/{lvlLessons.length}
                      </span>
                    )}
                  </button>
                )
              })}
            </div>
          ) : (
            <div className="flex items-center gap-1.5 flex-wrap" aria-label="Chọn chuyên đề Công Xưởng">
              <button
                type="button"
                onClick={() => handleFactoryUnitChange('all')}
                className={`px-3.5 py-2 rounded-xl text-xs font-serif font-bold border-2 transition-all cursor-pointer min-h-[40px] ${
                  factoryUnitFilter === 'all'
                    ? 'bg-stone-900 text-white border-stone-900 dark:bg-[#B91C1C] dark:border-[#B91C1C]'
                    : 'bg-white dark:bg-[#202B45] text-stone-800 dark:text-slate-200 border-stone-300 dark:border-white/15 hover:border-stone-900'
                }`}
              >
                Tất cả (3 Unit)
              </button>
              {factoryUnits.map((u) => {
                const isActive = factoryUnitFilter === u.id
                return (
                  <button
                    key={u.id}
                    type="button"
                    onClick={() => handleFactoryUnitChange(u.id)}
                    className={`px-3 py-2 rounded-xl text-xs font-serif font-bold border-2 transition-all cursor-pointer min-h-[40px] ${
                      isActive
                        ? 'bg-stone-900 text-white border-stone-900 dark:bg-[#B91C1C] dark:border-[#B91C1C]'
                        : 'bg-white dark:bg-[#202B45] text-stone-800 dark:text-slate-200 border-stone-300 dark:border-white/15 hover:border-stone-900'
                    }`}
                  >
                    Unit {u.unitNumber}
                  </button>
                )
              })}
            </div>
          )}
        </div>
      </section>

      {/* 2. DANH SÁCH CÁC UNIT (CHƯƠNG) VÀ LESSON CARDS */}
      <div className="space-y-8">
        {visibleUnits.map((unit) => {
          const completedInUnit = unit.lessons.filter((l) => progressMap[l.id]?.completed).length
          return (
            <section key={unit.id} className="space-y-4">
              {/* Unit Header */}
              <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-2 px-1">
                <div className="space-y-1">
                  <div className="flex items-center gap-2 flex-wrap">
                    <span className="px-2.5 py-0.5 rounded-lg bg-stone-900 text-white dark:bg-[#B91C1C] text-[11px] font-sans font-bold uppercase tracking-wider">
                      {unit.track === 'hsk' ? `HSK ${unit.hskLevel}` : 'Công Xưởng'}
                    </span>
                    <span className="text-xs font-hanzi text-[#B91C1C] font-semibold">
                      {unit.titleZh}
                    </span>
                  </div>
                  <h2 className="text-xl sm:text-2xl font-serif font-bold text-stone-900 dark:text-white">
                    {unit.title}
                  </h2>
                  <p className="text-xs sm:text-sm font-serif text-stone-600 dark:text-slate-300">
                    {unit.description}
                  </p>
                </div>

                <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-white dark:bg-[#182238] border border-stone-300 dark:border-white/15 text-xs font-sans font-semibold text-stone-700 dark:text-slate-200 self-start sm:self-auto shrink-0">
                  <Layers className="w-3.5 h-3.5 text-[#B91C1C]" />
                  <span>
                    {completedInUnit} / {unit.lessons.length} bài đã xong
                  </span>
                </div>
              </div>

              {/* Lesson Cards Grid */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                {unit.lessons.map((lesson) => {
                  const prog = progressMap[lesson.id] || null
                  const percent = prog?.percent || 0
                  const ctaLabel = getCourseCtaLabel(prog)
                  const totalSteps = getTotalStepsForLesson(lesson)
                  const isDone = Boolean(prog?.completed || percent >= 100)
                  const isResume = !isDone && percent > 0

                  return (
                    <article
                      key={lesson.id}
                      className="bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl p-5 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322] flex flex-col justify-between gap-4 transition-transform hover:-translate-y-0.5"
                    >
                      <div className="space-y-3">
                        {/* Hàng nhãn đầu card */}
                        <div className="flex items-center justify-between gap-2">
                          <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-300 dark:border-white/15 text-xs font-sans font-bold text-stone-900 dark:text-white">
                            <span>Bài {lesson.lessonNumber}</span>
                          </span>

                          <div className="flex items-center gap-2">
                            <span className="inline-flex items-center gap-1 text-xs font-sans font-medium text-stone-600 dark:text-slate-300">
                              <Clock className="w-3.5 h-3.5 text-[#B91C1C]" />
                              <span>{lesson.estimatedMinutes} phút</span>
                            </span>
                            {isDone && (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-emerald-100 text-emerald-800 border border-emerald-300 text-[10px] font-sans font-bold">
                                <CheckCircle2 className="w-3 h-3" />
                                <span>Xong</span>
                              </span>
                            )}
                          </div>
                        </div>

                        {/* Tên bài học */}
                        <div className="space-y-1">
                          <h3 className="text-lg font-serif font-bold text-stone-900 dark:text-white leading-snug">
                            {lesson.title}
                          </h3>
                          <p className="text-sm font-hanzi font-semibold text-[#B91C1C]">
                            {lesson.titleZh}
                          </p>
                          <p className="text-xs font-serif text-stone-600 dark:text-slate-300 leading-relaxed">
                            {lesson.subtitle}
                          </p>
                        </div>

                        {/* Chip nội dung bài học */}
                        <div className="flex flex-wrap items-center gap-1.5 pt-1 text-[11px] font-sans text-stone-700 dark:text-slate-300">
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md bg-stone-100 dark:bg-white/10">
                            <BookOpen className="w-3 h-3 text-[#B91C1C]" />
                            <span>{lesson.vocabs.length} từ vựng</span>
                          </span>
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md bg-stone-100 dark:bg-white/10">
                            <MessagesSquare className="w-3 h-3 text-stone-700 dark:text-slate-300" />
                            <span>{lesson.dialogue.lines.length} câu thoại</span>
                          </span>
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md bg-stone-100 dark:bg-white/10">
                            <ListChecks className="w-3 h-3 text-emerald-700 dark:text-emerald-400" />
                            <span>{lesson.quizzes.length} bài tập</span>
                          </span>
                        </div>
                      </div>

                      {/* Thanh tiến độ + Nút CTA */}
                      <div className="space-y-3 pt-2 border-t border-stone-200 dark:border-white/10">
                        <div className="space-y-1.5">
                          <div className="flex items-center justify-between text-xs font-sans">
                            <span className="text-stone-600 dark:text-slate-300 font-medium">
                              {isResume && prog
                                ? `Đang ở bước ${Math.min(prog.currentStepIndex + 1, totalSteps)} / ${totalSteps}`
                                : `${totalSteps} bước tương tác`}
                            </span>
                            <span
                              className={`font-bold tabular-nums ${
                                isDone ? 'text-emerald-700 dark:text-emerald-400' : 'text-[#B91C1C]'
                              }`}
                            >
                              {percent}%
                            </span>
                          </div>
                          <div className="w-full h-2.5 bg-stone-100 dark:bg-[#202B45] border border-stone-300 dark:border-white/10 rounded-full overflow-hidden">
                            <div
                              className={`h-full rounded-full transition-all duration-300 ${
                                isDone ? 'bg-emerald-600' : 'bg-[#B91C1C]'
                              }`}
                              style={{ width: `${percent}%` }}
                            />
                          </div>
                        </div>

                        <Link href={`/learn/${lesson.id}`} className="block">
                          <button
                            type="button"
                            className={`w-full min-h-[44px] px-4 py-2.5 rounded-xl font-serif font-bold text-sm transition-all flex items-center justify-center gap-2 cursor-pointer touch-manipulation ${
                              isDone
                                ? 'bg-white dark:bg-[#202B45] text-stone-900 dark:text-white border-2 border-stone-900 dark:border-[#384869] hover:bg-stone-50 shadow-[0_2px_0_#1c1917] active:translate-y-0.5'
                                : 'bg-[#B91C1C] hover:bg-[#991B1B] text-white border-2 border-stone-900 shadow-[0_3px_0_#1c1917] active:translate-y-0.5'
                            }`}
                          >
                            {isDone ? (
                              <RotateCcw className="w-4 h-4 shrink-0" />
                            ) : (
                              <Play className="w-4 h-4 shrink-0 fill-current" />
                            )}
                            <span>{ctaLabel}</span>
                            <ArrowRight className="w-4 h-4 shrink-0" />
                          </button>
                        </Link>
                      </div>
                    </article>
                  )
                })}
              </div>
            </section>
          )
        })}
      </div>
    </div>
  )
}
