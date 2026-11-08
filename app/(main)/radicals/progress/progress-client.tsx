'use client'

import { useState, useEffect, useMemo } from 'react'
import Link from 'next/link'
import { radicals } from '@/data/radicals'
import {
  getLearnedIds,
  getFavoriteIds,
  getQuizScores,
  getProgressStats,
  type QuizScore,
} from '@/lib/radicals-storage'
import {
  ChevronLeft,
  CheckCircle,
  Heart,
  Trophy,
  BookOpen,
  Star,
  TrendingUp,
} from 'lucide-react'

type Tab = 'overview' | 'learned' | 'favorites' | 'quiz-history'

export default function ProgressClient() {
  const [activeTab, setActiveTab] = useState<Tab>('overview')
  const [learnedIds, setLearnedIds] = useState<Set<number>>(new Set())
  const [favoriteIds, setFavoriteIds] = useState<Set<number>>(new Set())
  const [quizScores, setQuizScores] = useState<QuizScore[]>([])
  const [stats, setStats] = useState({ learnedCount: 0, favoritesCount: 0, totalRadicals: 214, percentage: 0 })

  useEffect(() => {
    setLearnedIds(getLearnedIds())
    setFavoriteIds(getFavoriteIds())
    setQuizScores(getQuizScores())
    setStats(getProgressStats())
  }, [])

  const learnedRadicals = useMemo(
    () => radicals.filter((r) => learnedIds.has(r.id)),
    [learnedIds]
  )

  const favoriteRadicals = useMemo(
    () => radicals.filter((r) => favoriteIds.has(r.id)),
    [favoriteIds]
  )

  const tabs: { key: Tab; label: string; icon: React.ReactNode; count?: number }[] = [
    { key: 'overview', label: 'Tổng quan', icon: <TrendingUp className="w-4 h-4" /> },
    { key: 'learned', label: 'Đã học', icon: <CheckCircle className="w-4 h-4" />, count: stats.learnedCount },
    { key: 'favorites', label: 'Yêu thích', icon: <Heart className="w-4 h-4" />, count: stats.favoritesCount },
    { key: 'quiz-history', label: 'Lịch sử Quiz', icon: <Trophy className="w-4 h-4" />, count: quizScores.length },
  ]

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <Link
          href="/radicals"
          className="flex items-center gap-2 text-muted hover:text-app-accent transition-colors font-serif text-sm"
        >
          <ChevronLeft className="w-4 h-4" />
          Danh sách bộ thủ
        </Link>
        <h1 className="text-lg md:text-xl font-serif text-title">Tiến độ</h1>
      </div>

      {/* Tabs */}
      <div className="flex gap-1.5 overflow-x-auto pb-1 scrollbar-none">
        {tabs.map((tab) => (
          <button
            key={tab.key}
            onClick={() => setActiveTab(tab.key)}
            className={`flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs md:text-sm font-serif font-bold whitespace-nowrap transition-all ${
              activeTab === tab.key
                ? 'bg-[#B8322D] text-white border-2 border-[#182238] shadow-[0_2px_0_#182238]'
                : 'bg-white border-2 border-[#182238]/20 text-[#182238]/80 hover:border-[#182238] hover:text-[#182238]'
            }`}
          >
            {tab.icon}
            {tab.label}
            {tab.count !== undefined && (
              <span className={`ml-1 px-1.5 py-0.5 rounded-full text-[10px] font-sans ${
                activeTab === tab.key ? 'bg-white/20' : 'bg-[#FAF7F2] border border-[#182238]/15'
              }`}>
                {tab.count}
              </span>
            )}
          </button>
        ))}
      </div>

      {/* Tab content */}
      {activeTab === 'overview' && (
        <div className="space-y-6">
          {/* Progress overview */}
          <div className="bg-white border-2 border-[#182238] rounded-3xl p-6 space-y-4 shadow-[0_4px_0_#182238]">
            <div className="text-center space-y-2">
              <div className="text-5xl">
                {stats.percentage >= 100 ? '🏆' : stats.percentage >= 50 ? '📖' : '🌱'}
              </div>
              <h2 className="text-2xl font-serif text-[#182238] font-bold">
                {stats.learnedCount} / {stats.totalRadicals}
              </h2>
              <p className="text-muted font-serif text-sm">bộ thủ đã học</p>
            </div>
            <div className="w-full bg-[#E5E0D8] h-4 rounded-full overflow-hidden border border-[#182238]/20">
              <div
                className="bg-gradient-to-r from-[#2E7D32] to-[#4CAF50] h-full rounded-full transition-all duration-500"
                style={{ width: `${stats.percentage}%` }}
              />
            </div>
            <p className="text-right text-sm text-[#182238] font-serif font-bold">{stats.percentage}% hoàn thành</p>
          </div>

          {/* Quick stats */}
          <div className="grid grid-cols-3 gap-3">
            <div className="bg-white border-2 border-[#182238] rounded-2xl p-4 text-center shadow-[0_3px_0_#182238]">
              <CheckCircle className="w-5 h-5 text-[#2E7D32] mx-auto mb-2" />
              <p className="text-2xl font-serif text-[#182238] font-bold">{stats.learnedCount}</p>
              <p className="text-xs text-muted font-serif">Đã học</p>
            </div>
            <div className="bg-white border-2 border-[#182238] rounded-2xl p-4 text-center shadow-[0_3px_0_#182238]">
              <Heart className="w-5 h-5 text-[#B8322D] mx-auto mb-2" />
              <p className="text-2xl font-serif text-[#182238] font-bold">{stats.favoritesCount}</p>
              <p className="text-xs text-muted font-serif">Yêu thích</p>
            </div>
            <div className="bg-white border-2 border-[#182238] rounded-2xl p-4 text-center shadow-[0_3px_0_#182238]">
              <Trophy className="w-5 h-5 text-[#D97706] mx-auto mb-2" />
              <p className="text-2xl font-serif text-[#182238] font-bold">{quizScores.length}</p>
              <p className="text-xs text-muted font-serif">Lần quiz</p>
            </div>
          </div>

          {/* Quick links */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <Link
              href="/radicals/flashcard"
              className="flex items-center gap-3 p-4 bg-white border-2 border-[#182238] rounded-2xl shadow-[0_3px_0_#182238] hover:shadow-[0_5px_0_#182238] transition-all"
            >
              <div className="bg-[#FFF9F3] p-2.5 rounded-xl border border-[#B8322D]/20">
                <Star className="w-5 h-5 text-[#B8322D]" />
              </div>
              <div>
                <p className="text-sm font-serif text-[#182238] font-bold">Học Flashcard</p>
                <p className="text-xs text-muted font-serif">Lật thẻ ôn bộ thủ</p>
              </div>
            </Link>
            <Link
              href="/radicals/quiz"
              className="flex items-center gap-3 p-4 bg-white border-2 border-[#182238] rounded-2xl shadow-[0_3px_0_#182238] hover:shadow-[0_5px_0_#182238] transition-all"
            >
              <div className="bg-[#E8F5E9] p-2.5 rounded-xl border border-[#2E7D32]/20">
                <BookOpen className="w-5 h-5 text-[#2E7D32]" />
              </div>
              <div>
                <p className="text-sm font-serif text-[#182238] font-bold">Làm Quiz</p>
                <p className="text-xs text-muted font-serif">Trắc nghiệm bộ thủ</p>
              </div>
            </Link>
          </div>
        </div>
      )}

      {activeTab === 'learned' && (
        <div className="space-y-4">
          {learnedRadicals.length === 0 ? (
            <div className="text-center py-12 space-y-3">
              <div className="text-5xl">📝</div>
              <p className="text-muted font-serif">Bạn chưa đánh dấu bộ thủ nào là đã học.</p>
              <Link href="/radicals" className="text-app-accent hover:text-accent-hover font-serif text-sm underline">
                Bắt đầu học ngay
              </Link>
            </div>
          ) : (
            <div className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 gap-2">
              {learnedRadicals.map((r) => (
                <Link
                  key={r.id}
                  href={`/radicals/${r.id}`}
                  className="group flex flex-col items-center p-3 bg-card border border-border rounded-lg hover:border-jade/30 hover:shadow-sm transition-all text-center"
                >
                  <span className="text-xs text-muted font-sans">#{r.id}</span>
                  <span
                    className="text-3xl font-serif text-title group-hover:text-jade transition-colors"
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {r.radical}
                  </span>
                  <span className="text-[10px] text-muted font-sans">{r.pinyin}</span>
                  <span className="text-xs text-body font-serif line-clamp-1">{r.meaning}</span>
                </Link>
              ))}
            </div>
          )}
        </div>
      )}

      {activeTab === 'favorites' && (
        <div className="space-y-4">
          {favoriteRadicals.length === 0 ? (
            <div className="text-center py-12 space-y-3">
              <div className="text-5xl">💝</div>
              <p className="text-muted font-serif">Bạn chưa thêm bộ thủ nào vào danh sách yêu thích.</p>
              <Link href="/radicals" className="text-app-accent hover:text-accent-hover font-serif text-sm underline">
                Khám phá bộ thủ
              </Link>
            </div>
          ) : (
            <div className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 gap-2">
              {favoriteRadicals.map((r) => (
                <Link
                  key={r.id}
                  href={`/radicals/${r.id}`}
                  className="group flex flex-col items-center p-3 bg-card border border-border rounded-lg hover:border-app-accent/30 hover:shadow-sm transition-all text-center"
                >
                  <span className="text-xs text-muted font-sans">#{r.id}</span>
                  <span
                    className="text-3xl font-serif text-title group-hover:text-app-accent transition-colors"
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {r.radical}
                  </span>
                  <span className="text-[10px] text-muted font-sans">{r.pinyin}</span>
                  <span className="text-xs text-body font-serif line-clamp-1">{r.meaning}</span>
                </Link>
              ))}
            </div>
          )}
        </div>
      )}

      {activeTab === 'quiz-history' && (
        <div className="space-y-4">
          {quizScores.length === 0 ? (
            <div className="text-center py-12 space-y-3">
              <div className="text-5xl">🧠</div>
              <p className="text-muted font-serif">Bạn chưa làm quiz nào.</p>
              <Link href="/radicals/quiz" className="text-app-accent hover:text-accent-hover font-serif text-sm underline">
                Làm quiz ngay
              </Link>
            </div>
          ) : (
            <div className="space-y-2">
              {quizScores.slice().reverse().map((score, i) => {
                const percentage = Math.round((score.correct / score.total) * 100)
                return (
                  <div
                    key={i}
                    className="flex items-center justify-between p-4 bg-card border border-border rounded-lg"
                  >
                    <div className="flex items-center gap-3">
                      <div className={`w-10 h-10 rounded-full flex items-center justify-center text-sm font-medium ${
                        percentage >= 80 ? 'bg-jade-soft text-jade' :
                        percentage >= 50 ? 'bg-gold-soft text-gold' :
                        'bg-accent-soft text-app-accent'
                      }`}>
                        {percentage}%
                      </div>
                      <div>
                        <p className="text-sm font-serif text-title">
                          {score.correct} / {score.total} câu đúng
                        </p>
                        <p className="text-xs text-muted font-sans">
                          {new Date(score.date).toLocaleDateString('vi-VN', {
                            day: '2-digit',
                            month: '2-digit',
                            year: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit',
                          })}
                        </p>
                      </div>
                    </div>
                    <div className={`w-3 h-3 rounded-full ${
                      percentage >= 80 ? 'bg-jade' :
                      percentage >= 50 ? 'bg-gold' :
                      'bg-app-accent'
                    }`} />
                  </div>
                )
              })}
            </div>
          )}
        </div>
      )}
    </div>
  )
}
