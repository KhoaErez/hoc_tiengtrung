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
      <div className="grid grid-cols-1 md:grid-cols-[200px_1fr] gap-6 bg-card border border-border rounded-2xl p-5 sm:p-6 shadow-2xs">
        {/* Score Medal Badge */}
        <div className="flex flex-col items-center justify-center p-4 bg-page/60 rounded-xl border border-border/80 text-center space-y-2">
          <div className="relative flex items-center justify-center">
            <div className="w-24 h-24 rounded-full bg-app-accent-soft text-app-accent border-4 border-app-accent/25 flex flex-col items-center justify-center shadow-inner">
              <span className="text-4xl font-extrabold font-serif">{score}</span>
              <span className="text-[10px] text-muted uppercase font-sans font-medium">/ 100 điểm</span>
            </div>
          </div>

          <span className={`text-xs px-2.5 py-0.5 rounded-full border font-bold ${tier.color}`}>
            {tier.label}
          </span>

          <div className="pt-1">
            <span className="text-[11px] text-muted block">Đánh giá chuẩn HSK 3.0</span>
            <span className="bg-title text-white text-xs font-bold font-sans px-3 py-1 rounded-full inline-block mt-1 shadow-2xs">
              {level}
            </span>
          </div>
        </div>

        {/* 6 Criteria Bars */}
        <div className="space-y-3.5 flex flex-col justify-center">
          <div className="flex items-center justify-between border-b border-border pb-2">
            <h3 className="font-bold text-sm text-title flex items-center gap-2">
              <Award className="w-4 h-4 text-app-accent" />
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
          <div className="bg-emerald-50/50 border border-emerald-200/80 rounded-2xl p-4 sm:p-5 space-y-2.5">
            <div className="flex items-center gap-2 text-emerald-800 font-bold text-xs uppercase tracking-wider">
              <CheckCircle2 className="w-4 h-4 text-emerald-600" />
              <span>Những điểm viết tốt ({strengths.length})</span>
            </div>
            {strengths.length === 0 ? (
              <p className="text-xs text-muted italic">Đang phân tích...</p>
            ) : (
              <ul className="space-y-2 text-xs text-emerald-950">
                {strengths.map((str, i) => (
                  <li key={i} className="flex items-start gap-2 leading-relaxed">
                    <span className="w-4 h-4 rounded-full bg-emerald-200/70 text-emerald-800 flex items-center justify-center text-[10px] shrink-0 mt-0.5">
                      ✓
                    </span>
                    <span>{str}</span>
                  </li>
                ))}
              </ul>
            )}
          </div>

          {/* Weaknesses */}
          <div className="bg-amber-50/50 border border-amber-200/80 rounded-2xl p-4 sm:p-5 space-y-2.5">
            <div className="flex items-center gap-2 text-amber-800 font-bold text-xs uppercase tracking-wider">
              <AlertTriangle className="w-4 h-4 text-amber-600" />
              <span>Điểm cần cải thiện ({weaknesses.length})</span>
            </div>
            {weaknesses.length === 0 ? (
              <p className="text-xs text-muted italic">Không có điểm yếu đáng kể!</p>
            ) : (
              <ul className="space-y-2 text-xs text-amber-950">
                {weaknesses.map((weak, i) => (
                  <li key={i} className="flex items-start gap-2 leading-relaxed">
                    <span className="w-4 h-4 rounded-full bg-amber-200/70 text-amber-800 flex items-center justify-center text-[10px] shrink-0 mt-0.5">
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
