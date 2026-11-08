'use client'

import { Award, CheckCircle2, AlertTriangle, Quote, Check } from 'lucide-react'

export interface ResultOverviewProps {
  score: number
  level: string
  summary: string
  scoreDetails?: {
    grammar: number
    vocabulary: number
    wordOrder: number
    naturalness: number
    coherence: number
    hskAppropriateness: number
  }
  strengths?: string[]
  weaknesses?: string[]
}

const CRITERIA_META = [
  { key: 'grammar', label: 'Ngữ pháp', max: 30, color: 'bg-emerald-500' },
  { key: 'vocabulary', label: 'Từ vựng', max: 20, color: 'bg-blue-500' },
  { key: 'wordOrder', label: 'Trật tự từ', max: 15, color: 'bg-indigo-500' },
  { key: 'naturalness', label: 'Độ tự nhiên', max: 15, color: 'bg-amber-500' },
  { key: 'coherence', label: 'Mạch lạc & Bố cục', max: 10, color: 'bg-purple-500' },
  { key: 'hskAppropriateness', label: 'Chuẩn HSK', max: 10, color: 'bg-app-accent' },
] as const

export function ResultOverview({
  score,
  level,
  summary,
  scoreDetails,
  strengths = [],
  weaknesses = [],
}: ResultOverviewProps) {
  // Score tier color
  const getScoreTier = (s: number) => {
    if (s >= 90) return { label: 'Xuất sắc', color: 'text-emerald-700 bg-emerald-50 border-emerald-300' }
    if (s >= 80) return { label: 'Rất tốt', color: 'text-blue-700 bg-blue-50 border-blue-300' }
    if (s >= 70) return { label: 'Khá', color: 'text-amber-700 bg-amber-50 border-amber-300' }
    if (s >= 60) return { label: 'Đạt yêu cầu', color: 'text-orange-700 bg-orange-50 border-orange-300' }
    return { label: 'Cần nỗ lực hơn', color: 'text-red-700 bg-red-50 border-red-300' }
  }

  const tier = getScoreTier(score)

  return (
    <div className="space-y-6 font-serif">
      {/* 1. Score & Criteria Grid */}
      <div className="grid grid-cols-1 md:grid-cols-[220px_1fr] gap-6 bg-white border-2 border-[#182238] rounded-3xl p-5 sm:p-6 shadow-[0_4px_0_#182238]">
        {/* Score Medal Badge */}
        <div className="flex flex-col items-center justify-center p-4 bg-[#FFF9F3] rounded-2xl border-2 border-[#182238] text-center space-y-2 shadow-[0_2px_0_#182238]">
          <div className="relative flex items-center justify-center">
            <div className="w-24 h-24 rounded-full bg-[#B8322D] text-white border-2 border-[#182238] flex flex-col items-center justify-center shadow-[0_2px_0_#7A1D1A]">
              <span className="text-4xl font-extrabold font-serif">{score}</span>
              <span className="text-[10px] text-white/80 uppercase font-sans font-bold">/ 100 điểm</span>
            </div>
          </div>

          <span className={`text-xs px-3 py-1 rounded-full border-2 border-[#182238] font-bold shadow-2xs ${tier.color}`}>
            {tier.label}
          </span>

          <div className="pt-1">
            <span className="text-[11px] text-muted block font-serif">Đánh giá chuẩn HSK 3.0</span>
            <span className="bg-[#182238] text-white text-xs font-bold font-sans px-3 py-1 rounded-full inline-block mt-1 shadow-2xs border border-[#182238]">
              {level}
            </span>
          </div>
        </div>

        {/* 6 Criteria Bars */}
        <div className="space-y-3.5 flex flex-col justify-center">
          <div className="flex items-center justify-between border-b-2 border-[#182238]/15 pb-2">
            <h3 className="font-bold text-sm text-[#182238] flex items-center gap-2">
              <Award className="w-4 h-4 text-[#B8322D]" />
              <span>Đánh giá chi tiết 6 tiêu chuẩn</span>
            </h3>
            <span className="text-[11px] text-muted">Thang điểm 100</span>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-x-6 gap-y-3">
            {CRITERIA_META.map(({ key, label, max, color }) => {
              const val = scoreDetails?.[key] ?? 0
              const percentage = Math.min(100, Math.round((val / max) * 100))
              return (
                <div key={key} className="space-y-1">
                  <div className="flex items-center justify-between text-xs">
                    <span className="text-body font-medium">{label}</span>
                    <span className="font-bold text-title font-sans">
                      {val} <span className="text-muted text-[10px] font-normal">/{max}</span>
                    </span>
                  </div>
                  <div className="h-2 w-full bg-page rounded-full overflow-hidden border border-border/60">
                    <div
                      className={`h-full rounded-full transition-all duration-500 ${color}`}
                      style={{ width: `${percentage}%` }}
                    />
                  </div>
                </div>
              )
            })}
          </div>

          {/* Teacher Summary Quote */}
          {summary && (
            <div className="mt-2 p-3 bg-app-accent-soft/30 rounded-xl border border-app-accent/20 flex items-start gap-2.5 text-xs text-title">
              <Quote className="w-4 h-4 text-app-accent shrink-0 mt-0.5 rotate-180" />
              <p className="italic leading-relaxed">
                &ldquo;{summary}&rdquo;
              </p>
            </div>
          )}
        </div>
      </div>

      {/* 2. Strengths & Weaknesses (2 Columns) */}
      {(strengths.length > 0 || weaknesses.length > 0) && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {/* Strengths */}
          <div className="bg-[#E8F5E9]/50 border-2 border-[#182238] rounded-3xl p-5 sm:p-6 space-y-2.5 shadow-[0_3px_0_#182238]">
            <div className="flex items-center gap-2 text-[#2E7D32] font-bold text-xs uppercase tracking-wider">
              <CheckCircle2 className="w-4 h-4 text-[#2E7D32]" />
              <span>Những điểm viết tốt ({strengths.length})</span>
            </div>
            {strengths.length === 0 ? (
              <p className="text-xs text-muted italic">Đang phân tích...</p>
            ) : (
              <ul className="space-y-2 text-xs text-[#1B5E20]">
                {strengths.map((str, i) => (
                  <li key={i} className="flex items-start gap-2 leading-relaxed">
                    <span className="w-4 h-4 rounded-full bg-[#C8E6C9] text-[#1B5E20] flex items-center justify-center text-[10px] shrink-0 mt-0.5 font-bold">
                      ✓
                    </span>
                    <span>{str}</span>
                  </li>
                ))}
              </ul>
            )}
          </div>

          {/* Weaknesses */}
          <div className="bg-[#FFF9F3] border-2 border-[#182238] rounded-3xl p-5 sm:p-6 space-y-2.5 shadow-[0_3px_0_#182238]">
            <div className="flex items-center gap-2 text-[#D97706] font-bold text-xs uppercase tracking-wider">
              <AlertTriangle className="w-4 h-4 text-[#D97706]" />
              <span>Điểm cần cải thiện ({weaknesses.length})</span>
            </div>
            {weaknesses.length === 0 ? (
              <p className="text-xs text-muted italic">Không có điểm yếu đáng kể!</p>
            ) : (
              <ul className="space-y-2 text-xs text-[#78350F]">
                {weaknesses.map((weak, i) => (
                  <li key={i} className="flex items-start gap-2 leading-relaxed">
                    <span className="w-4 h-4 rounded-full bg-[#FDE68A] text-[#78350F] flex items-center justify-center text-[10px] shrink-0 mt-0.5 font-bold">
                      !
                    </span>
                    <span>{weak}</span>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
