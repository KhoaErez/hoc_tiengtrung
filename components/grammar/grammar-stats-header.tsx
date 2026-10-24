'use client'

import React from 'react'
import { Search, BookOpen, BookCheck, Volume2, Layers, Filter, X } from 'lucide-react'

interface GrammarStatsHeaderProps {
  totalCount: number
  masteredCount: number
  searchQuery: string
  onSearchChange: (q: string) => void
  currentLevel: string
  onSelectLevel: (lvl: string) => void
  levelCounts?: Record<string, number>
}

const LEVEL_HANZI: Record<string, string> = {
  'HSK 1': '一级语法大纲',
  'HSK 2': '二级语法大纲',
  'HSK 3': '三级语法大纲',
  'HSK 4': '四级语法大纲',
  'HSK 5': '五级语法大纲',
  'HSK 6': '六级语法大纲',
}

const BASE_LEVELS = ['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6']

export function GrammarStatsHeader({
  totalCount,
  masteredCount,
  searchQuery,
  onSearchChange,
  currentLevel,
  onSelectLevel,
  levelCounts,
}: GrammarStatsHeaderProps) {
  const percentMastered = totalCount > 0 ? Math.round((masteredCount / totalCount) * 100) : 0

  const levels = BASE_LEVELS.map((lvl) => {
    const count = levelCounts?.[lvl] ?? (lvl === 'HSK 1' ? 48 : 0)
    return {
      level: lvl,
      label: count > 0 ? `${lvl} (${count} điểm)` : lvl,
      isReady: count > 0,
      count,
    }
  })

  return (
    <div className="space-y-5">
      {/* Top Banner / Hero Box */}
      <div className="relative overflow-hidden rounded-2xl bg-white dark:bg-[#1E2530] border-2 border-[#E9DDD1] dark:border-slate-700/80 p-5 sm:p-7 md:p-8 shadow-sm">
        {/* Subtle decorative watermark */}
        <div className="absolute -right-6 -bottom-8 select-none pointer-events-none opacity-[0.04] dark:opacity-[0.06] font-hanzi text-8xl md:text-9xl font-bold text-title">
          语法
        </div>

        <div className="relative z-10 space-y-4 max-w-3xl">
          {/* Badge GF 0025-2021 */}
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold tracking-wide uppercase bg-[#B8322D]/10 text-[#B8322D] dark:bg-[#B8322D]/20 dark:text-[#E27D60] border border-[#B8322D]/30">
            <BookOpen className="w-3.5 h-3.5" />
            <span>Tiêu chuẩn quốc tế GF 0025-2021 • CTI / 汉考国际</span>
          </div>

          {/* Heading */}
          <div className="space-y-2">
            <h1 className="text-2xl sm:text-3xl md:text-4xl font-serif font-bold text-[#1E293B] dark:text-[#F8FAFC] tracking-tight leading-tight">
              Sổ tay Ngữ pháp {currentLevel}{' '}
              <span className="text-[#B8322D] dark:text-[#E27D60] font-hanzi">
                ({LEVEL_HANZI[currentLevel] || '语法大纲'})
              </span>
            </h1>
            <p className="text-sm md:text-base text-[#334155] dark:text-[#CBD5E1] font-serif leading-relaxed">
              Tổng hợp và hệ thống hóa toàn diện <strong>{totalCount} điểm ngữ pháp cốt lõi</strong> trình độ {currentLevel}. Mỗi điểm ngữ pháp đều có công thức phân tích trực quan, giải thích ngữ nghĩa cặn kẽ tiếng Việt và câu ví dụ thực tế kèm giọng đọc bản ngữ.
            </p>
          </div>

          {/* Quick Stats Grid */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 pt-2">
            <div className="p-3.5 rounded-xl bg-[#FFF9F3] dark:bg-[#141A23] border border-[#E8DCD0] dark:border-slate-700/80 shadow-2xs">
              <div className="text-xs text-[#64748B] dark:text-slate-400 flex items-center gap-1.5 font-semibold">
                <BookCheck className="w-3.5 h-3.5 text-[#B8322D]" />
                Tổng điểm ngữ pháp
              </div>
              <div className="text-xl sm:text-2xl font-bold font-mono text-[#0F172A] dark:text-white mt-1">
                {totalCount} <span className="text-xs text-[#64748B] dark:text-slate-400 font-normal font-sans">điểm</span>
              </div>
            </div>

            <div className="p-3.5 rounded-xl bg-[#FFF9F3] dark:bg-[#141A23] border border-[#E8DCD0] dark:border-slate-700/80 shadow-2xs">
              <div className="text-xs text-[#64748B] dark:text-slate-400 flex items-center gap-1.5 font-semibold">
                <Layers className="w-3.5 h-3.5 text-emerald-600 dark:text-emerald-400" />
                Đã nắm vững
              </div>
              <div className="text-xl sm:text-2xl font-bold font-mono text-emerald-700 dark:text-emerald-400 mt-1">
                {masteredCount} <span className="text-xs text-emerald-600 dark:text-emerald-400 font-medium font-sans">({percentMastered}%)</span>
              </div>
            </div>

            <div className="p-3.5 rounded-xl bg-[#FFF9F3] dark:bg-[#141A23] border border-[#E8DCD0] dark:border-slate-700/80 shadow-2xs">
              <div className="text-xs text-[#64748B] dark:text-slate-400 flex items-center gap-1.5 font-semibold">
                <Volume2 className="w-3.5 h-3.5 text-[#B45309] dark:text-amber-400" />
                Câu ví dụ TTS
              </div>
              <div className="text-xl sm:text-2xl font-bold font-mono text-[#0F172A] dark:text-white mt-1">
                100+ <span className="text-xs text-[#64748B] dark:text-slate-400 font-normal font-sans">câu mẫu</span>
              </div>
            </div>

            <div className="p-3.5 rounded-xl bg-[#FFF9F3] dark:bg-[#141A23] border border-[#E8DCD0] dark:border-slate-700/80 shadow-2xs">
              <div className="text-xs text-[#64748B] dark:text-slate-400 flex items-center gap-1.5 font-semibold">
                <Filter className="w-3.5 h-3.5 text-purple-700 dark:text-purple-400" />
                Nhóm chủ điểm
              </div>
              <div className="text-xl sm:text-2xl font-bold font-mono text-[#0F172A] dark:text-white mt-1">
                12 <span className="text-xs text-[#64748B] dark:text-slate-400 font-normal font-sans">chủ đề</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Level Tabs + Search Input */}
      <div className="space-y-3">
        {/* HSK Level Tabs */}
        <div className="flex items-center gap-2 overflow-x-auto pb-1 scrollbar-none">
          {levels.map((lvl) => {
            const isSelected = currentLevel === lvl.level
            return (
              <button
                key={lvl.level}
                type="button"
                onClick={() => {
                  if (lvl.isReady) {
                    onSelectLevel(lvl.level)
                  }
                }}
                disabled={!lvl.isReady}
                className={`shrink-0 relative px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold transition-all cursor-pointer ${
                  isSelected
                    ? 'bg-[#B8322D] text-white shadow-sm ring-2 ring-[#B8322D]/20'
                    : lvl.isReady
                    ? 'bg-white dark:bg-[#1E2530] text-[#334155] dark:text-[#E2E8F0] hover:text-[#B8322D] hover:border-[#B8322D] border border-[#DAC7B6] dark:border-slate-700 shadow-2xs'
                    : 'bg-black/[0.03] dark:bg-white/[0.04] text-[#94A3B8] dark:text-slate-500 border border-[#E2D4C6]/60 dark:border-slate-800 cursor-not-allowed'
                }`}
              >
                <span>{lvl.label}</span>
                {!lvl.isReady && (
                  <span className="ml-1.5 text-[10px] text-[#64748B] dark:text-slate-400 bg-black/[0.04] dark:bg-white/[0.06] px-1.5 py-0.5 rounded-full font-normal font-sans">
                    Sắp ra mắt
                  </span>
                )}
              </button>
            )
          })}
        </div>

        {/* Ô Tìm kiếm tương tác với độ tương phản cao */}
        <div className="relative">
          <Search className="w-4 h-4 text-[#64748B] dark:text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2 pointer-events-none" />
          <input
            type="search"
            value={searchQuery}
            onChange={(e) => onSearchChange(e.target.value)}
            placeholder="Tìm kiếm điểm ngữ pháp theo tên tiếng Việt, Hán tự, Pinyin, công thức (ví dụ: 'Đại từ', '不', 'shì', 'biểu thị')..."
            className="w-full pl-10 pr-10 py-3 rounded-xl bg-white dark:bg-[#1E2530] border-2 border-[#DAC7B6] dark:border-slate-700 focus:border-[#B8322D] focus:ring-2 focus:ring-[#B8322D]/20 outline-none text-sm text-[#0F172A] dark:text-white placeholder:text-[#64748B] dark:placeholder:text-slate-400 font-medium transition-all shadow-2xs"
          />
          {searchQuery && (
            <button
              type="button"
              onClick={() => onSearchChange('')}
              className="absolute right-3 top-1/2 -translate-y-1/2 p-1 rounded-md text-[#64748B] hover:text-[#0F172A] dark:hover:text-white transition-colors"
              title="Xóa tìm kiếm"
            >
              <X className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    </div>
  )
}
