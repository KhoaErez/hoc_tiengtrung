'use client'

import React, { useState } from 'react'
import Link from 'next/link'
import {
  Trophy,
  Target,
  Clock,
  Volume2,
  BookmarkPlus,
  CheckCircle2,
  ArrowRight,
  Loader2,
  Map,
  Layers,
} from 'lucide-react'
import type { CourseLesson } from '@/data/course-roadmap-data'
import { saveLessonWordsToSm2Action } from '@/app/(main)/learn/actions'
import { saveLocalLessonSm2Bookmarks } from '@/lib/course-progress-storage'
import { ttsEngine } from '@/lib/tts/tts-engine'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import { toast } from 'sonner'

interface SummaryStepProps {
  lesson: CourseLesson
  nextLesson: CourseLesson | null
  correctQuizCount: number
  totalQuizCount: number
  elapsedSeconds: number
  isLoggedIn: boolean
  initialSavedSm2?: boolean
  onSavedSm2Success: () => void
  onRestartLesson: () => void
  onCustomSaveSm2?: () => Promise<boolean>
  customNextActionLabel?: string
  onCustomNextAction?: () => void
  onClosePlayer?: () => void
}

export function SummaryStep({
  lesson,
  nextLesson,
  correctQuizCount,
  totalQuizCount,
  elapsedSeconds,
  isLoggedIn,
  initialSavedSm2 = false,
  onSavedSm2Success,
  onRestartLesson,
  onCustomSaveSm2,
  customNextActionLabel,
  onCustomNextAction,
  onClosePlayer,
}: SummaryStepProps) {
  const { openLoginRequired } = useAuthModal()
  const [isSavingSm2, setIsSavingSm2] = useState(false)
  const [savedToSm2, setSavedToSm2] = useState(initialSavedSm2)
  const [savedLocalOnly, setSavedLocalOnly] = useState(false)

  const accuracy =
    totalQuizCount > 0 ? Math.round((correctQuizCount / totalQuizCount) * 100) : 100

  const mins = Math.floor(elapsedSeconds / 60)
  const secs = elapsedSeconds % 60
  const formattedTime = `${mins}:${String(secs).padStart(2, '0')}`

  const hskLevelLabel =
    lesson.track === 'hsk' && lesson.hskLevel ? `HSK ${lesson.hskLevel}` : 'Công xưởng'

  const handleSaveToSm2 = async () => {
    setIsSavingSm2(true)
    // Luôn lưu một bản local backup để khách trải nghiệm tức thì
    saveLocalLessonSm2Bookmarks(
      lesson.vocabs.map((v) => ({
        hanzi: v.hanzi,
        pinyin: v.pinyin,
        meaningVi: v.meaningVi,
      }))
    )

    try {
      if (onCustomSaveSm2) {
        const ok = await onCustomSaveSm2()
        if (ok) {
          setSavedToSm2(true)
          setSavedLocalOnly(false)
          onSavedSm2Success()
        } else {
          setSavedLocalOnly(true)
        }
        return
      }

      const res = await saveLessonWordsToSm2Action(
        lesson.vocabs.map((v) => ({
          hanzi: v.hanzi,
          pinyin: v.pinyin,
          meaningVi: v.meaningVi,
          partOfSpeech: v.partOfSpeech,
          hskLevelLabel,
          exampleHanzi: v.exampleHanzi,
          examplePinyin: v.examplePinyin,
          exampleVi: v.exampleVi,
        }))
      )

      if (res.requiresAuth) {
        setSavedLocalOnly(true)
        toast.info('Đã lưu từ mới trên máy! Đăng nhập để đồng bộ lịch ôn tập SM-2.')
        openLoginRequired({
          title: 'Đồng bộ từ vựng vào lịch ôn tập SM-2',
          description: `Đăng nhập để lưu ${lesson.vocabs.length} từ mới của bài "${lesson.title}" vào kho ôn tập thông minh dài hạn.`,
          onSuccess: () => {
            handleSaveToSm2()
          },
        })
        return
      }

      if (res.success) {
        setSavedToSm2(true)
        setSavedLocalOnly(false)
        onSavedSm2Success()
        toast.success(`Đã đưa ${res.savedCount} từ mới vào hàng đợi ôn tập SM-2!`)
      } else {
        toast.error(res.error || 'Chưa thể lưu vào kho SM-2 lúc này.')
      }
    } catch {
      toast.error('Có lỗi kết nối khi lưu từ vào SM-2.')
    } finally {
      setIsSavingSm2(false)
    }
  }

  const roadmapHref =
    lesson.track === 'factory'
      ? '/learn?track=factory'
      : `/learn?track=hsk&level=${lesson.hskLevel || 1}`

  return (
    <div className="bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl p-5 sm:p-8 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322] space-y-6 animate-in fade-in duration-200">
      {/* Banner chúc mừng hoàn thành */}
      <div className="text-center space-y-3">
        <div className="w-16 h-16 rounded-2xl bg-[#B91C1C]/10 border-2 border-stone-900 flex items-center justify-center mx-auto shadow-[0_3px_0_#1c1917]">
          <Trophy className="w-8 h-8 text-[#B91C1C]" />
        </div>
        <div className="space-y-1">
          <span className="inline-block px-3 py-0.5 rounded-full bg-emerald-100 border border-emerald-300 text-emerald-800 text-[11px] font-sans font-bold uppercase tracking-wider">
            Hoàn thành bài học
          </span>
          <h1 className="text-2xl sm:text-3xl font-serif font-bold text-stone-900 dark:text-white">
            Xuất sắc! Bạn đã xong bài này
          </h1>
          <p className="text-xs sm:text-sm font-serif text-stone-600 dark:text-slate-300">
            {lesson.title} ({lesson.titleZh})
          </p>
        </div>
      </div>

      {/* Lưới chỉ số Tổng kết */}
      <div className="grid grid-cols-3 gap-3">
        <div className="rounded-2xl bg-[#FAF7F2] dark:bg-[#202B45] border-2 border-stone-900/15 dark:border-white/15 p-3 sm:p-4 text-center">
          <div className="flex items-center justify-center gap-1 text-[11px] font-serif text-stone-500 dark:text-slate-400">
            <Target className="w-3.5 h-3.5 text-emerald-600" />
            <span>Độ chính xác</span>
          </div>
          <p className="text-xl sm:text-2xl font-sans font-bold text-emerald-700 dark:text-emerald-400 mt-1 tabular-nums">
            {accuracy}%
          </p>
        </div>

        <div className="rounded-2xl bg-[#FAF7F2] dark:bg-[#202B45] border-2 border-stone-900/15 dark:border-white/15 p-3 sm:p-4 text-center">
          <div className="flex items-center justify-center gap-1 text-[11px] font-serif text-stone-500 dark:text-slate-400">
            <Clock className="w-3.5 h-3.5 text-[#B91C1C]" />
            <span>Thời gian</span>
          </div>
          <p className="text-xl sm:text-2xl font-sans font-bold text-stone-900 dark:text-white mt-1 tabular-nums">
            {formattedTime}
          </p>
        </div>

        <div className="rounded-2xl bg-[#FAF7F2] dark:bg-[#202B45] border-2 border-stone-900/15 dark:border-white/15 p-3 sm:p-4 text-center">
          <div className="flex items-center justify-center gap-1 text-[11px] font-serif text-stone-500 dark:text-slate-400">
            <Layers className="w-3.5 h-3.5 text-stone-700 dark:text-slate-300" />
            <span>Từ mới</span>
          </div>
          <p className="text-xl sm:text-2xl font-sans font-bold text-stone-900 dark:text-white mt-1 tabular-nums">
            {lesson.vocabs.length} từ
          </p>
        </div>
      </div>

      {/* Danh sách từ mới vừa học */}
      <div className="space-y-3">
        <div className="flex items-center justify-between gap-2">
          <h2 className="text-sm font-serif font-bold text-stone-900 dark:text-white uppercase tracking-wider">
            Từ mới vừa học trong bài ({lesson.vocabs.length})
          </h2>
          {savedToSm2 && (
            <Link
              href="/review"
              className="text-xs font-serif font-bold text-emerald-700 hover:underline inline-flex items-center gap-1"
            >
              <span>Mở phòng ôn SM-2</span>
              <ArrowRight className="w-3 h-3" />
            </Link>
          )}
        </div>

        <div className="divide-y divide-stone-200 dark:divide-white/10 rounded-2xl border-2 border-stone-900/20 dark:border-white/15 bg-[#FAF9F6] dark:bg-[#202B45] overflow-hidden">
          {lesson.vocabs.map((vocab) => (
            <div
              key={vocab.id}
              className="flex items-center justify-between gap-3 px-4 py-3"
            >
              <div className="min-w-0">
                <div className="flex items-baseline gap-2.5 flex-wrap">
                  <span
                    className="text-lg sm:text-xl font-hanzi font-bold text-stone-900 dark:text-white"
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {vocab.hanzi}
                  </span>
                  <span className="text-xs font-sans font-semibold text-[#B91C1C]">
                    {vocab.pinyin}
                  </span>
                  <span className="text-[11px] font-sans text-stone-500">
                    ({vocab.partOfSpeech})
                  </span>
                </div>
                <p className="text-xs sm:text-sm font-serif text-stone-700 dark:text-slate-300 mt-0.5">
                  {vocab.meaningVi}
                </p>
              </div>

              <button
                type="button"
                onClick={() => ttsEngine.speak(vocab.hanzi, { id: `sum-${vocab.id}`, rate: 0.95 })}
                className="w-9 h-9 rounded-xl bg-white dark:bg-[#182238] border border-stone-300 dark:border-white/15 hover:border-stone-900 flex items-center justify-center text-[#B91C1C] cursor-pointer shrink-0"
                title={`Nghe phát âm ${vocab.hanzi}`}
              >
                <Volume2 className="w-4 h-4" />
              </button>
            </div>
          ))}
        </div>
      </div>

      {/* Hành động SM-2 & Học bài tiếp theo */}
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 pt-2">
        <button
          type="button"
          onClick={handleSaveToSm2}
          disabled={isSavingSm2 || savedToSm2}
          className={`flex-1 min-h-[48px] px-4 py-3 rounded-xl border-2 border-stone-900 font-serif font-bold text-sm flex items-center justify-center gap-2 transition-all cursor-pointer touch-manipulation ${
            savedToSm2
              ? 'bg-emerald-50 text-emerald-800 border-emerald-600 cursor-default'
              : savedLocalOnly
              ? 'bg-amber-50 text-amber-900 hover:bg-amber-100 shadow-[0_3px_0_#1c1917]'
              : 'bg-white dark:bg-[#202B45] text-stone-900 dark:text-white hover:bg-stone-50 shadow-[0_3px_0_#1c1917] active:translate-y-0.5'
          }`}
        >
          {isSavingSm2 ? (
            <>
              <Loader2 className="w-4 h-4 animate-spin" />
              <span>Đang lưu SM-2...</span>
            </>
          ) : savedToSm2 ? (
            <>
              <CheckCircle2 className="w-4 h-4 text-emerald-600" />
              <span>Đã lưu vào ôn tập SM-2</span>
            </>
          ) : (
            <>
              <BookmarkPlus className="w-4 h-4 text-[#B91C1C]" />
              <span>
                {isLoggedIn ? 'Lưu vào ôn tập SM-2' : 'Lưu vào ôn tập SM-2'}
              </span>
            </>
          )}
        </button>

        {onCustomNextAction ? (
          <button
            type="button"
            onClick={onCustomNextAction}
            className="flex-1 min-h-[48px] px-5 py-3 rounded-xl bg-[#B91C1C] hover:bg-[#991B1B] text-white border-2 border-stone-900 font-serif font-bold text-sm shadow-[0_3px_0_#1c1917] active:translate-y-0.5 flex items-center justify-center gap-2 cursor-pointer transition-all touch-manipulation"
          >
            <span>{customNextActionLabel || 'Tiếp tục chặng tiếp theo'}</span>
            <ArrowRight className="w-4 h-4 shrink-0" />
          </button>
        ) : nextLesson ? (
          <Link href={`/learn/${nextLesson.id}`} className="flex-1">
            <button
              type="button"
              className="w-full min-h-[48px] px-5 py-3 rounded-xl bg-[#B91C1C] hover:bg-[#991B1B] text-white border-2 border-stone-900 font-serif font-bold text-sm shadow-[0_3px_0_#1c1917] active:translate-y-0.5 flex items-center justify-center gap-2 cursor-pointer transition-all touch-manipulation"
            >
              <span>Học bài tiếp theo</span>
              <ArrowRight className="w-4 h-4 shrink-0" />
            </button>
          </Link>
        ) : onClosePlayer ? (
          <button
            type="button"
            onClick={onClosePlayer}
            className="flex-1 min-h-[48px] px-5 py-3 rounded-xl bg-[#B91C1C] hover:bg-[#991B1B] text-white border-2 border-stone-900 font-serif font-bold text-sm shadow-[0_3px_0_#1c1917] active:translate-y-0.5 flex items-center justify-center gap-2 cursor-pointer transition-all touch-manipulation"
          >
            <Map className="w-4 h-4 shrink-0" />
            <span>Quay lại bài học</span>
          </button>
        ) : (
          <Link href={roadmapHref} className="flex-1">
            <button
              type="button"
              className="w-full min-h-[48px] px-5 py-3 rounded-xl bg-[#B91C1C] hover:bg-[#991B1B] text-white border-2 border-stone-900 font-serif font-bold text-sm shadow-[0_3px_0_#1c1917] active:translate-y-0.5 flex items-center justify-center gap-2 cursor-pointer transition-all touch-manipulation"
            >
              <Map className="w-4 h-4 shrink-0" />
              <span>Quay lại Lộ trình</span>
            </button>
          </Link>
        )}
      </div>

      {/* Phụ trợ: Làm lại bài này */}
      <div className="text-center">
        <button
          type="button"
          onClick={onRestartLesson}
          className="text-xs font-serif font-semibold text-stone-500 hover:text-stone-900 underline cursor-pointer"
        >
          Học lại bài này từ bước 1
        </button>
      </div>
    </div>
  )
}
