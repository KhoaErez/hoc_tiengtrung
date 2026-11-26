'use client'

import React, { useState, useRef } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import {
  BookOpen,
  Layers,
  PlayCircle,
  ArrowRight,
  GraduationCap,
  CheckCircle2,
  Clock,
  Sparkles,
  FileText,
} from 'lucide-react'
import { formatNumber } from '@/lib/utils'

export interface HskRoadmapItem {
  id: string
  tag: string
  name: string
  title: string
  rankTitle: string
  rankShort: string
  stageName: string
  accentColor: string
  coverImage: string
  description: string
  vocabCount: number
  targetVocab: number
  charTarget?: number
  grammarTarget?: number
  totalLessons: number
  learnedVocabs: number
  percent: number
  isComingSoon: boolean
  isApplied?: boolean
}

interface HskRoadmapSelectorProps {
  items: HskRoadmapItem[]
  isLoggedIn: boolean
}

export function HskRoadmapSelector({ items, isLoggedIn }: HskRoadmapSelectorProps) {
  // Mặc định chọn cấp độ đang học dở đầu tiên (nếu đã đăng nhập) hoặc HSK 1
  const defaultActiveId =
    items.find((it) => isLoggedIn && it.percent > 0 && it.percent < 100)?.id || items[0]?.id || '1'
  const [activeId, setActiveId] = useState<string>(defaultActiveId)
  const tabsRef = useRef<HTMLDivElement>(null)

  const activeItem = items.find((item) => item.id === activeId) || items[0]

  if (!activeItem) return null

  return (
    <div className="space-y-5">
      {/* 1. HORIZONTAL INTERACTIVE LEVEL SELECTOR (Segmented Tabs / Snap Carousel) */}
      <div className="relative">
        <div
          ref={tabsRef}
          role="tablist"
          aria-label="Chọn cấp độ lộ trình HSK 3.0"
          className="flex items-center gap-2 overflow-x-auto no-scrollbar py-1.5 snap-x snap-proximity touch-pan-x"
        >
          {items.map((item) => {
            const isActive = item.id === activeItem.id
            const hasProgress = isLoggedIn && item.percent > 0
            return (
              <button
                key={item.id}
                type="button"
                role="tab"
                aria-selected={isActive}
                onClick={() => setActiveId(item.id)}
                className={`snap-start shrink-0 px-3.5 sm:px-4 py-2.5 rounded-xl border text-left transition-all duration-200 cursor-pointer select-none flex items-center gap-2.5 active:scale-[0.98] ${
                  isActive
                    ? 'bg-[#182238] dark:bg-white text-white dark:text-[#182238] border-[#182238] dark:border-white shadow-[0_4px_14px_rgba(24,34,56,0.16)]'
                    : 'bg-white dark:bg-[#182238] text-[#182238] dark:text-slate-200 border-[#E2E8F0] dark:border-white/10 hover:border-[#0D9488]/50 hover:bg-[#F0FDFA]/50 dark:hover:bg-[#202B45]'
                }`}
              >
                <span
                  className="w-2 h-2 rounded-full shrink-0"
                  style={{ backgroundColor: isActive ? '#2DD4BF' : item.accentColor }}
                />
                <div className="flex flex-col leading-tight">
                  <span className="text-xs sm:text-sm font-serif font-bold whitespace-nowrap">
                    {item.name}
                  </span>
                  <span
                    className={`text-[10px] font-sans whitespace-nowrap ${
                      isActive ? 'text-slate-300 dark:text-slate-600' : 'text-muted'
                    }`}
                  >
                    {item.isApplied ? item.stageName : item.rankShort}
                  </span>
                </div>
                {hasProgress && (
                  <span
                    className={`text-[10px] font-mono font-bold px-1.5 py-0.5 rounded-full ${
                      isActive
                        ? 'bg-[#0D9488] text-white'
                        : 'bg-emerald-50 text-emerald-700 border border-emerald-200'
                    }`}
                  >
                    {item.percent}%
                  </span>
                )}
              </button>
            )
          })}
        </div>
      </div>

      {/* 2. ACTIVE STAGE SPOTLIGHT CARD (Crisp Elevated Split Card, ZERO Card Overload) */}
      <div
        key={activeItem.id}
        className="w-full rounded-3xl bg-white dark:bg-[#182238] border border-[#E2E8F0] dark:border-white/10 shadow-[0_8px_30px_rgba(15,23,42,0.04)] overflow-hidden grid grid-cols-1 lg:grid-cols-12 animate-in fade-in duration-300"
      >
        {/* Left: 3D Landscape Cover (Proper Aspect Ratio + Smooth Image Fade) */}
        <div className="lg:col-span-5 relative aspect-[16/10] lg:aspect-auto lg:min-h-[340px] bg-[#FAF9F6] dark:bg-[#1F2C47] overflow-hidden">
          <Image
            src={activeItem.coverImage}
            alt={`Minh họa 3D ${activeItem.title}`}
            fill
            sizes="(max-width: 1024px) 100vw, 42vw"
            className="object-cover object-center transition-transform duration-700 hover:scale-[1.03]"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/20 to-transparent pointer-events-none" />

          {/* Bottom overlay badge: Học vị Khoa Bảng (1 badge cleanly placed) */}
          <div className="absolute bottom-3.5 left-4 right-4 flex items-center justify-between gap-2 pointer-events-none">
            <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-black/65 backdrop-blur-md border border-white/20 text-white text-xs font-serif font-bold shadow-xs">
              <span
                className="w-2 h-2 rounded-full shrink-0"
                style={{ backgroundColor: activeItem.accentColor }}
              />
              <span>
                {activeItem.name} • {activeItem.rankTitle}
              </span>
            </span>

            {activeItem.isComingSoon && (
              <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-amber-500/90 text-white text-[10px] font-sans font-bold">
                <Clock className="w-3 h-3" />
                <span>Đang hoàn thiện</span>
              </span>
            )}
          </div>
        </div>

        {/* Right: Structured Details (Max 1 badge, 1 bold title, concise 2-line copy, metric pills, 1 primary CTA) */}
        <div className="lg:col-span-7 p-6 sm:p-8 flex flex-col justify-between gap-6">
          <div className="space-y-4">
            {/* Single Stage Stamp Badge */}
            <div className="flex items-center justify-between gap-2 flex-wrap">
              <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-serif font-bold bg-[#FEF2F2] dark:bg-[#B8322D]/20 text-[#B8322D] dark:text-red-300 border border-[#B8322D]/20">
                <GraduationCap className="w-3.5 h-3.5" />
                <span>{activeItem.stageName}</span>
              </span>

              {isLoggedIn && !activeItem.isComingSoon && (
                <span className="text-xs font-sans font-semibold text-[#0D9488] dark:text-teal-400 flex items-center gap-1">
                  {activeItem.percent === 100 ? (
                    <>
                      <CheckCircle2 className="w-3.5 h-3.5" />
                      <span>Đã hoàn thành</span>
                    </>
                  ) : activeItem.percent > 0 ? (
                    <span>Đang học ({activeItem.percent}%)</span>
                  ) : (
                    <span className="text-muted font-normal">Sẵn sàng bắt đầu</span>
                  )}
                </span>
              )}
            </div>

            {/* Title & 2-Line Description */}
            <div className="space-y-2">
              <h3 className="text-xl sm:text-2xl md:text-[26px] font-serif font-bold text-[#182238] dark:text-white tracking-tight leading-snug">
                {activeItem.title}
              </h3>
              <p className="text-sm text-[#475569] dark:text-slate-300 font-serif leading-relaxed line-clamp-2">
                {activeItem.description}
              </p>
            </div>

            {/* Key Metric Pills (Số liệu nhất quán 100% với Footer & Database) */}
            <div className="flex flex-wrap items-center gap-2.5 pt-1">
              <div className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] border border-[#E2E8F0] dark:border-white/10 text-xs font-serif text-[#182238] dark:text-slate-200">
                <BookOpen className="w-3.5 h-3.5 text-[#0D9488]" />
                <span>
                  <strong>{activeItem.isComingSoon ? '0' : activeItem.totalLessons}</strong> bài học
                </span>
              </div>

              <div className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] border border-[#E2E8F0] dark:border-white/10 text-xs font-serif text-[#182238] dark:text-slate-200">
                <Layers className="w-3.5 h-3.5 text-[#B8322D]" />
                <span>
                  Kho từ: <strong>{formatNumber(activeItem.vocabCount)}</strong> từ
                </span>
              </div>

              {activeItem.grammarTarget ? (
                <div className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] border border-[#E2E8F0] dark:border-white/10 text-xs font-serif text-[#182238] dark:text-slate-200">
                  <FileText className="w-3.5 h-3.5 text-amber-600" />
                  <span>
                    <strong>{activeItem.grammarTarget}</strong> điểm ngữ pháp
                  </span>
                </div>
              ) : null}
            </div>
          </div>

          {/* Bottom Progress + 1 Clear Primary CTA */}
          <div className="pt-4 border-t border-[#E2E8F0] dark:border-white/10 space-y-4">
            <div className="space-y-1.5">
              <div className="flex items-center justify-between text-xs font-serif">
                <span className="text-muted">
                  {activeItem.isComingSoon ? 'Trạng thái đề cương HSK 3.0' : 'Tiến độ ghi nhớ từ vựng'}
                </span>
                <span className="font-bold text-[#182238] dark:text-white">
                  {activeItem.isComingSoon
                    ? `Mục tiêu ${formatNumber(activeItem.targetVocab)} từ`
                    : isLoggedIn
                      ? `${formatNumber(activeItem.learnedVocabs)} / ${formatNumber(activeItem.vocabCount)} từ (${activeItem.percent}%)`
                      : `${formatNumber(activeItem.vocabCount)} từ sẵn sàng học`}
                </span>
              </div>
              <div className="w-full bg-[#E2E8F0] dark:bg-white/10 h-2 rounded-full overflow-hidden">
                <div
                  className="h-full rounded-full bg-[#0D9488] transition-all duration-500 ease-out"
                  style={{ width: `${activeItem.isComingSoon ? 0 : isLoggedIn ? activeItem.percent : 0}%` }}
                />
              </div>
            </div>

            <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3">
              <Link
                href={`/topics?q=${encodeURIComponent(activeItem.tag)}`}
                className="flex-1"
              >
                <button
                  type="button"
                  className="w-full min-h-[48px] py-3 px-5 rounded-xl bg-[#0D9488] hover:bg-[#0F766E] active:translate-y-0.5 text-white text-sm font-serif font-bold shadow-[0_3px_0_#115E59] flex items-center justify-center gap-2 cursor-pointer transition-all"
                >
                  <PlayCircle className="w-4 h-4 shrink-0" />
                  <span>
                    {activeItem.isComingSoon
                      ? 'Xem đề cương chuẩn GF 0025-2021'
                      : isLoggedIn && activeItem.percent > 0
                        ? `Tiếp tục học ${activeItem.name}`
                        : `Bắt đầu học ${activeItem.name}`}
                  </span>
                  <ArrowRight className="w-4 h-4 shrink-0" />
                </button>
              </Link>

              <Link
                href={`/vocabulary?level=${encodeURIComponent(activeItem.tag)}`}
                className="sm:w-auto"
              >
                <button
                  type="button"
                  className="w-full sm:w-auto min-h-[48px] py-3 px-4 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] hover:bg-[#F1F5F9] border border-[#E2E8F0] dark:border-white/15 text-[#182238] dark:text-white text-xs sm:text-sm font-serif font-semibold flex items-center justify-center gap-1.5 cursor-pointer transition-colors"
                >
                  <Sparkles className="w-3.5 h-3.5 text-[#B8322D]" />
                  <span>Tra từ {activeItem.name}</span>
                </button>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
