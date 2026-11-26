'use client'

import React from 'react'
import Image from 'next/image'
import Link from 'next/link'
import {
  PlayCircle,
  Sparkles,
  ChevronDown,
  Headphones,
  RotateCcw,
  BookOpenCheck,
  Search,
  GraduationCap,
} from 'lucide-react'

interface Hero3DSectionProps {
  displayName?: string
  isLoggedIn?: boolean
  recentExerciseTitle?: string | null
  recentExerciseUrl?: string | null
}

export function Hero3DSection({
  displayName,
  isLoggedIn,
  recentExerciseTitle,
  recentExerciseUrl,
}: Hero3DSectionProps) {

  return (
    <section
      id="hero"
      aria-label="Khu vực khởi đầu hành trình"
      className="relative w-full rounded-3xl overflow-hidden border-2 border-[#182238] dark:border-[#384869] shadow-[0_6px_0_#182238] dark:shadow-[0_6px_0_#0D1322] flex flex-col justify-between p-4 sm:p-8 lg:p-10"
    >
      {/* 1. 3D CHINESE LANDSCAPE BACKGROUND */}
      <div className="absolute inset-0 z-0">
        <Image
          src="/images/hero/hero-3d-landscape.webp"
          alt=""
          aria-hidden="true"
          fill
          priority
          sizes="(max-width: 1280px) 100vw, 1280px"
          className="object-cover object-center select-none"
        />
        <div className="absolute inset-0 bg-gradient-to-r from-[#FAF9F6]/94 via-[#FAF9F6]/70 to-[#FAF9F6]/35 dark:from-[#182238]/95 dark:via-[#182238]/75 dark:to-[#182238]/40" />
        <div className="absolute inset-0 bg-gradient-to-t from-[#FAF9F6]/90 via-transparent to-black/10 dark:from-[#182238] dark:via-transparent" />
      </div>

      {/* 2. COHESIVE 2-COLUMN HERO LAYOUT (Left: Value Prop + CTA | Right: Tiểu Bút Mascot Card) */}
      <div className="relative z-10 grid grid-cols-1 lg:grid-cols-12 gap-6 lg:gap-8 items-center py-2 sm:py-4">
        
        {/* Left: Floating Frosted Glass Panel — Headline, 1-sentence Value Prop, Primary CTA */}
        <div className="lg:col-span-7 rounded-3xl bg-[#FAF7F2]/95 dark:bg-[#182238]/95 backdrop-blur-xl border border-[#182238]/15 dark:border-[#384869] shadow-[0_12px_36px_rgba(24,34,56,0.1)] p-6 sm:p-8 space-y-5">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white dark:bg-[#202B45] border border-[#E2E8F0] dark:border-white/15 shadow-2xs">
            <GraduationCap className="w-3.5 h-3.5 text-[#0D9488]" />
            <span className="text-[11px] font-sans font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200">
              Chuẩn HSK 3.0 · GF 0025-2021
            </span>
          </div>

          <div className="space-y-3">
            <h1 className="text-2xl sm:text-4xl font-serif font-bold text-[#182238] dark:text-white leading-tight tracking-tight">
              Chinh phục tiếng Trung <br />
              <span className="text-[#DC2626] dark:text-red-400">từng bước vững chắc.</span>
            </h1>
            <p className="text-sm sm:text-base font-serif text-[#475569] dark:text-slate-300 leading-relaxed max-w-xl">
              Học từ vựng và ngữ pháp theo lộ trình HSK 3.0 kết hợp phản xạ gõ phím Pinyin IME và thuật toán ghi nhớ dài hạn SM-2.
            </p>
          </div>

          <div className="pt-1 flex flex-col sm:flex-row gap-3 items-stretch sm:items-center">
            {isLoggedIn && recentExerciseUrl ? (
              <Link href={recentExerciseUrl} className="sm:flex-1 max-w-xs">
                <button
                  type="button"
                  className="w-full min-h-[48px] py-3 px-5 rounded-xl bg-[#0D9488] hover:bg-[#0F766E] active:translate-y-0.5 text-white font-serif font-bold text-sm shadow-[0_3px_0_#115E59] flex items-center justify-center gap-2 cursor-pointer transition-all"
                >
                  <PlayCircle className="w-4 h-4 shrink-0" />
                  <span className="truncate">Tiếp tục: {recentExerciseTitle || 'Bài gần nhất'}</span>
                </button>
              </Link>
            ) : (
              <Link href="/topics?q=HSK 1" className="sm:flex-1 max-w-xs">
                <button
                  type="button"
                  className="w-full min-h-[48px] py-3 px-6 rounded-xl bg-[#0D9488] hover:bg-[#0F766E] active:translate-y-0.5 text-white font-serif font-bold text-sm shadow-[0_3px_0_#115E59] flex items-center justify-center gap-2 cursor-pointer transition-all"
                >
                  <PlayCircle className="w-4 h-4 shrink-0" />
                  <span>Bắt đầu học ngay (HSK 1)</span>
                </button>
              </Link>
            )}

            <Link href="#hanh-trinh-hsk">
              <button
                type="button"
                className="w-full sm:w-auto min-h-[48px] py-3 px-5 rounded-xl bg-white dark:bg-[#202B45] hover:bg-[#FAF9F6] dark:hover:bg-[#283657] border border-[#CBD5E1] dark:border-[#384869] text-[#182238] dark:text-white font-serif font-semibold text-sm flex items-center justify-center gap-1.5 cursor-pointer transition-all"
              >
                <span>Xem lộ trình</span>
                <ChevronDown className="w-4 h-4" />
              </button>
            </Link>
          </div>

          {isLoggedIn && displayName && (
            <div className="pt-2 flex items-center gap-2 text-xs font-serif text-[#475569] dark:text-slate-400 border-t border-[#E2E8F0] dark:border-white/10">
              <Sparkles className="w-3.5 h-3.5 text-[#0D9488] shrink-0" />
              <span>
                Chào mừng <strong>{displayName}</strong> quay trở lại hành trình Hán ngữ!
              </span>
            </div>
          )}
        </div>

        {/* Right: Single Cohesive Interactive Tiểu Bút Mascot Preview Card */}
        <div className="lg:col-span-5 rounded-3xl bg-white/95 dark:bg-[#182238]/95 backdrop-blur-xl border border-[#E2E8F0] dark:border-[#384869] shadow-[0_12px_36px_rgba(15,23,42,0.12)] p-5 sm:p-6 space-y-4">
          <div className="flex items-center gap-3.5">
            <div className="relative w-14 h-14 rounded-2xl overflow-hidden border border-[#E2E8F0] dark:border-white/15 bg-[#FAF9F6] shrink-0">
              <Image
                src="/images/panda/panda-welcome.webp"
                alt=""
                aria-hidden="true"
                fill
                sizes="56px"
                className="object-cover"
              />
            </div>
            <div className="min-w-0">
              <p className="text-xs font-sans font-bold uppercase tracking-wider text-[#DC2626] dark:text-red-400">
                Tiểu Bút 🐼 · Bạn đồng hành
              </p>
              <p className="text-sm font-serif font-bold text-[#182238] dark:text-white leading-snug mt-0.5">
                Hôm nay bạn muốn luyện kỹ năng nào?
              </p>
            </div>
          </div>

          {/* Interactive Daily Card Snippet */}
          <div className="p-4 rounded-2xl bg-[#FAF9F6] dark:bg-[#202B45] border border-[#E2E8F0] dark:border-white/10 flex items-center justify-between gap-3">
            <div className="flex items-center gap-3 min-w-0">
              <div className="w-11 h-11 rounded-xl bg-[#F0FDFA] dark:bg-teal-950/60 border border-[#0D9488]/25 flex items-center justify-center shrink-0">
                <span className="font-hanzi text-2xl font-bold text-[#0D9488]">学</span>
              </div>
              <div className="min-w-0">
                <p className="text-xs font-sans font-bold text-[#DC2626] dark:text-red-400">
                  xué <span className="text-muted font-normal">· HSK 1</span>
                </p>
                <p className="text-xs sm:text-sm font-serif font-bold text-[#182238] dark:text-white truncate">
                  Học tập, nghiên cứu tri thức
                </p>
              </div>
            </div>

            <Link
              href="/topics?q=HSK 1"
              className="shrink-0 inline-flex items-center gap-1 px-3 py-1.5 rounded-xl bg-white dark:bg-[#182238] hover:bg-[#F0FDFA] border border-[#E2E8F0] dark:border-white/15 text-xs font-serif font-bold text-[#0D9488] transition-colors shadow-2xs"
            >
              <BookOpenCheck className="w-3.5 h-3.5" />
              <span>Thử ngay</span>
            </Link>
          </div>

          {/* Clean Quick Shortcuts */}
          <div className="grid grid-cols-3 gap-2 pt-1">
            <Link
              href="/typing?practice=visual&mode=listen"
              className="flex flex-col items-center justify-center gap-1 p-2.5 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] hover:bg-[#F0FDFA] border border-[#E2E8F0] dark:border-white/10 text-[11px] font-serif font-semibold text-[#182238] dark:text-slate-200 hover:text-[#0D9488] transition-colors text-center"
            >
              <Headphones className="w-4 h-4 text-[#0D9488]" />
              <span>Nghe & Gõ</span>
            </Link>
            <Link
              href="/review"
              className="flex flex-col items-center justify-center gap-1 p-2.5 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] hover:bg-[#F0FDFA] border border-[#E2E8F0] dark:border-white/10 text-[11px] font-serif font-semibold text-[#182238] dark:text-slate-200 hover:text-[#0D9488] transition-colors text-center"
            >
              <RotateCcw className="w-4 h-4 text-amber-600" />
              <span>Ôn SM-2</span>
            </Link>
            <Link
              href="/vocabulary"
              className="flex flex-col items-center justify-center gap-1 p-2.5 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] hover:bg-[#F0FDFA] border border-[#E2E8F0] dark:border-white/10 text-[11px] font-serif font-semibold text-[#182238] dark:text-slate-200 hover:text-[#0D9488] transition-colors text-center"
            >
              <Search className="w-4 h-4 text-[#DC2626]" />
              <span>Tra từ điển</span>
            </Link>
          </div>
        </div>
      </div>

    </section>
  )
}
