'use client'

import { useState, useEffect, useTransition } from 'react'
import Link from 'next/link'
import { 
  User, 
  Mail, 
  Calendar, 
  Edit3, 
  Check, 
  X, 
  BookOpen, 
  BrainCircuit, 
  Keyboard, 
  Component, 
  Flame, 
  LogOut, 
  ArrowRight, 
  Award,
  Timer,
  CheckCircle2,
  TrendingUp,
  ShieldCheck
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { HSK_LEVELS } from '@/data/hsk-curriculum'
import { updateDisplayName } from './actions'
import { logout } from '@/app/auth/actions'
import { getTypingStats, TypingStats } from '@/lib/typing-storage'
import { getProgressStats, getQuizScores, QuizScore } from '@/lib/radicals-storage'
import { formatNumber } from '@/lib/utils'

interface UserProfileData {
  id: string
  email: string
  displayName: string
  avatarUrl: string | null
  createdAt: string
}

interface UserLearningStats {
  savedVocabCount: number
  memorizedVocabCount: number
  customLessonsCount: number
  dueReviewCount: number
  hskCounts: Record<number, number>
}

interface ProfileClientProps {
  user: UserProfileData
  stats: UserLearningStats
}

export default function ProfileClient({ user, stats }: ProfileClientProps) {
  const [displayName, setDisplayName] = useState(user.displayName)
  const [isEditingName, setIsEditingName] = useState(false)
  const [newNameInput, setNewNameInput] = useState(user.displayName)
  const [statusMessage, setStatusMessage] = useState<{ type: 'success' | 'error'; text: string } | null>(null)
  const [isPending, startTransition] = useTransition()

  // Typing practice stats (localStorage)
  const [typingStats, setTypingStats] = useState<TypingStats | null>(null)

  // Radicals stats (localStorage)
  const [radicalsStats, setRadicalsStats] = useState<{
    learnedCount: number
    favoritesCount: number
    totalRadicals: number
    percentage: number
  } | null>(null)
  const [radicalQuizScores, setRadicalQuizScores] = useState<QuizScore[]>([])

  useEffect(() => {
    // Load client-side local stats
    setTypingStats(getTypingStats())
    setRadicalsStats(getProgressStats())
    setRadicalQuizScores(getQuizScores())
  }, [])

  // Format join date
  const formattedJoinDate = (() => {
    try {
      const date = new Date(user.createdAt)
      return `Tháng ${date.getMonth() + 1}, ${date.getFullYear()}`
    } catch {
      return 'Gần đây'
    }
  })()

  // Handle display name submit
  const handleSaveName = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!newNameInput.trim() || newNameInput.trim().length < 2) {
      setStatusMessage({ type: 'error', text: 'Tên hiển thị phải có ít nhất 2 ký tự' })
      return
    }

    startTransition(async () => {
      const formData = new FormData()
      formData.append('displayName', newNameInput.trim())
      const result = await updateDisplayName(formData)

      if (result.error) {
        setStatusMessage({ type: 'error', text: result.error })
      } else {
        setDisplayName(result.displayName || newNameInput.trim())
        setIsEditingName(false)
        setStatusMessage({ type: 'success', text: 'Đã cập nhật tên hiển thị thành công!' })
        setTimeout(() => setStatusMessage(null), 3500)
      }
    })
  }

  // Best quiz score
  const bestQuizScore = radicalQuizScores.length > 0
    ? Math.max(...radicalQuizScores.map(q => Math.round((q.correct / Math.max(q.total, 1)) * 100)))
    : null

  return (
    <div className="space-y-10">

      {/* 1. THẺ THÔNG TIN TÀI KHOẢN NGƯỜI DÙNG */}
      <div className="relative rounded-2xl border border-border bg-card p-6 md:p-8 shadow-2xs overflow-hidden">
        {/* Thanh màu trang trí trên đầu */}
        <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-title via-app-accent to-gold" />

        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-6">
          <div className="flex items-center gap-4 md:gap-5">
            {/* Avatar lớn */}
            {user.avatarUrl ? (
              <img
                src={user.avatarUrl}
                alt={displayName}
                className="w-16 h-16 md:w-20 md:h-20 rounded-2xl object-cover border-2 border-border flex-shrink-0 shadow-xs"
              />
            ) : (
              <div className="w-16 h-16 md:w-20 md:h-20 rounded-2xl bg-[#23272F] text-white flex items-center justify-center font-bold text-2xl md:text-3xl font-serif shadow-xs flex-shrink-0">
                {displayName[0]?.toUpperCase() || 'U'}
              </div>
            )}

            {/* Thông tin tên & email */}
            <div className="space-y-1">
              {isEditingName ? (
                <form onSubmit={handleSaveName} className="flex items-center gap-2 pt-1">
                  <input
                    type="text"
                    value={newNameInput}
                    onChange={(e) => setNewNameInput(e.target.value)}
                    className="px-3 py-1.5 rounded-lg border border-app-accent bg-page text-title font-serif text-sm font-bold focus:outline-none"
                    autoFocus
                    maxLength={50}
                  />
                  <Button
                    type="submit"
                    size="sm"
                    disabled={isPending}
                    className="bg-app-accent hover:bg-accent-hover text-white text-xs px-2.5 h-8 rounded-lg"
                  >
                    <Check className="w-4 h-4" />
                  </Button>
                  <Button
                    type="button"
                    size="sm"
                    variant="ghost"
                    onClick={() => { setIsEditingName(false); setNewNameInput(displayName); }}
                    className="text-muted hover:text-title text-xs px-2 h-8 rounded-lg"
                  >
                    <X className="w-4 h-4" />
                  </Button>
                </form>
              ) : (
                <div className="flex items-center gap-2">
                  <h1 className="text-xl md:text-2xl font-serif font-bold text-title">{displayName}</h1>
                  <button
                    onClick={() => { setIsEditingName(true); setNewNameInput(displayName); }}
                    className="p-1 rounded-md text-muted hover:text-app-accent hover:bg-page transition-colors"
                    title="Chỉnh sửa tên hiển thị"
                  >
                    <Edit3 className="w-4 h-4" />
                  </button>
                </div>
              )}

              <div className="flex flex-wrap items-center gap-3 text-xs text-muted font-serif">
                <span className="flex items-center gap-1.5 font-sans">
                  <Mail className="w-3.5 h-3.5 text-muted" />
                  {user.email}
                </span>
                <span>•</span>
                <span className="flex items-center gap-1.5">
                  <Calendar className="w-3.5 h-3.5 text-muted" />
                  Tham gia: {formattedJoinDate}
                </span>
              </div>

              {/* Status Message */}
              {statusMessage && (
                <p className={`text-xs font-serif pt-1 ${
                  statusMessage.type === 'success' ? 'text-jade font-medium' : 'text-red-500'
                }`}>
                  {statusMessage.text}
                </p>
              )}
            </div>
          </div>

          {/* Nút hành động */}
          <div className="flex items-center gap-3 self-start sm:self-center">
            <form action={logout}>
              <Button
                type="submit"
                variant="outline"
                size="sm"
                className="font-serif text-xs border-[#E9DDD1] hover:bg-[#FFF9F3] hover:text-red-600 hover:border-red-300 gap-1.5 min-h-[38px] cursor-pointer"
              >
                <LogOut className="w-4 h-4" />
                <span>Đăng xuất</span>
              </Button>
            </form>
          </div>
        </div>
      </div>

      {/* 2. 4 THẺ THỐNG KÊ TỔNG QUAN */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3 md:gap-4">
        <Card className="rounded-xl shadow-2xs border border-border bg-card">
          <CardContent className="p-4 md:p-5">
            <p className="text-xs font-serif font-medium text-muted uppercase tracking-wider">Từ vựng đã lưu</p>
            <div className="text-2xl md:text-3xl font-serif font-bold text-title mt-1.5">
              {stats.savedVocabCount}
            </div>
            <p className="text-[11px] text-muted font-serif mt-0.5">Trong sổ tay cá nhân</p>
          </CardContent>
        </Card>

        <Card className="rounded-xl shadow-2xs border border-border bg-card">
          <CardContent className="p-4 md:p-5">
            <p className="text-xs font-serif font-medium text-muted uppercase tracking-wider">Từ đã nhớ sâu</p>
            <div className="text-2xl md:text-3xl font-serif font-bold text-jade mt-1.5">
              {stats.memorizedVocabCount}
            </div>
            <p className="text-[11px] text-muted font-serif mt-0.5">Khoảng nhớ &ge; 21 ngày</p>
          </CardContent>
        </Card>

        <Card className="rounded-xl shadow-2xs border border-border bg-card">
          <CardContent className="p-4 md:p-5">
            <p className="text-xs font-serif font-medium text-muted uppercase tracking-wider">Bài học tự tạo</p>
            <div className="text-2xl md:text-3xl font-serif font-bold text-gold mt-1.5">
              {stats.customLessonsCount}
            </div>
            <p className="text-[11px] text-muted font-serif mt-0.5">Từ tài liệu & bài tập</p>
          </CardContent>
        </Card>

        <Card className="rounded-xl shadow-2xs border border-border bg-card">
          <CardContent className="p-4 md:p-5">
            <p className="text-xs font-serif font-medium text-muted uppercase tracking-wider">Cần ôn tập</p>
            <div className="text-2xl md:text-3xl font-serif font-bold text-app-accent mt-1.5">
              {stats.dueReviewCount}
            </div>
            <p className="text-[11px] text-muted font-serif mt-0.5">Theo thuật toán SRS</p>
          </CardContent>
        </Card>
      </div>

      {/* 3. TIẾN ĐỘ LỘ TRÌNH HSK 3.0 */}
      <section id="progress" className="space-y-4">
        <div className="flex items-center justify-between border-b-2 border-app-accent/30 pb-2">
          <div className="flex items-center gap-2">
            <Award className="w-5 h-5 text-gold" />
            <h2 className="text-xl font-serif font-bold text-title">Tiến độ lộ trình HSK 3.0</h2>
            <span className="text-[10px] font-mono font-medium px-2 py-0.5 rounded-md bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20">
              GF 0025-2021
            </span>
          </div>
          <Link href="/" className="text-xs text-app-accent font-serif hover:underline">
            Xem toàn bộ lộ trình &rarr;
          </Link>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {([1, 2, 3, 4, 5, 6, 7] as const).map((levelNum) => {
            const info = HSK_LEVELS[levelNum]
            const learned = stats.hskCounts[levelNum] || 0
            const target = info.vocabTarget
            const percent = Math.min(100, Math.round((learned / target) * 100))

            return (
              <div
                key={levelNum}
                className="p-5 rounded-2xl border border-border bg-card flex flex-col justify-between hover:border-app-accent/40 hover:shadow-2xs transition-all space-y-3"
              >
                <div>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-1.5">
                      <span className={`px-2.5 py-0.5 rounded-lg text-xs font-serif font-bold ${info.color.badgeBg}`}>
                        {info.name}
                      </span>
                      <span className="text-[10px] font-serif text-muted px-1.5 py-0.2 rounded bg-page border border-border">
                        {info.stage}
                      </span>
                    </div>
                    <span className="text-xs font-serif font-bold text-title" suppressHydrationWarning>
                      {formatNumber(learned)} / {formatNumber(target)} từ ({percent}%)
                    </span>
                  </div>

                  <h3 className="font-serif font-bold text-base text-title mt-2">
                    {info.title}
                  </h3>
                  <p className="text-xs text-muted font-serif line-clamp-1 mt-0.5">
                    {info.description}
                  </p>
                </div>

                <div className="space-y-2 pt-1">
                  <div className="w-full bg-track h-2 rounded-full overflow-hidden">
                    <div
                      className={`h-full rounded-full bg-gradient-to-r ${info.color.progressFrom} ${info.color.progressTo} transition-all duration-500`}
                      style={{ width: `${percent}%` }}
                    />
                  </div>

                  <div className="flex items-center justify-between pt-1">
                    <Link
                      href={`/topics?q=${encodeURIComponent(info.tag)}`}
                      className="text-xs font-serif font-medium text-app-accent hover:text-accent-hover flex items-center gap-1"
                    >
                      <span>Vào học danh sách bài</span>
                      <ArrowRight className="w-3.5 h-3.5" />
                    </Link>

                    {percent === 100 && (
                      <span className="inline-flex items-center gap-1 text-[11px] font-serif text-jade">
                        <CheckCircle2 className="w-3.5 h-3.5" /> Đạt chuẩn
                      </span>
                    )}
                  </div>
                </div>
              </div>
            )
          })}
        </div>
      </section>

      {/* 4. KẾT QUẢ LUYỆN ĐÁNH MÁY & 214 BỘ THỦ */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        
        {/* Thống kê luyện đánh máy */}
        <div className="p-6 rounded-2xl border border-border bg-card space-y-4">
          <div className="flex items-center justify-between border-b border-border/80 pb-3">
            <div className="flex items-center gap-2.5">
              <div className="w-9 h-9 rounded-xl bg-jade/10 text-jade flex items-center justify-center">
                <Keyboard className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title">Luyện đánh máy</h3>
                <p className="text-xs text-muted font-serif">Kỹ năng gõ chữ Hán thực tế</p>
              </div>
            </div>
            <Link href="/typing">
              <Button size="sm" variant="outline" className="text-xs font-serif border-[#E9DDD1] hover:bg-[#FFF9F3] min-h-[36px] cursor-pointer">
                Luyện ngay
              </Button>
            </Link>
          </div>

          <div className="grid grid-cols-2 gap-3 text-center">
            <div className="p-3 rounded-xl bg-page/70 border border-border/60">
              <p className="text-xs text-muted font-serif">Số lượt luyện tập</p>
              <p className="text-xl font-serif font-bold text-title mt-0.5">
                {typingStats ? typingStats.totalSessions : 0}
              </p>
            </div>
            <div className="p-3 rounded-xl bg-page/70 border border-border/60">
              <p className="text-xs text-muted font-serif">Tốc độ cao nhất</p>
              <p className="text-xl font-serif font-bold text-jade mt-0.5">
                {typingStats ? `${typingStats.bestCPM} CPM` : '0 CPM'}
              </p>
            </div>
            <div className="p-3 rounded-xl bg-page/70 border border-border/60">
              <p className="text-xs text-muted font-serif">Độ chính xác TB</p>
              <p className="text-xl font-serif font-bold text-app-accent mt-0.5">
                {typingStats && typingStats.totalSessions > 0 ? `${typingStats.averageAccuracy}%` : '100%'}
              </p>
            </div>
            <div className="p-3 rounded-xl bg-page/70 border border-border/60">
              <p className="text-xs text-muted font-serif">Ký tự đã gõ</p>
              <p className="text-xl font-serif font-bold text-gold mt-0.5">
                {typingStats ? typingStats.totalCharactersTyped : 0}
              </p>
            </div>
          </div>
        </div>

        {/* Thống kê 214 Bộ thủ */}
        <div className="p-6 rounded-2xl border border-border bg-card space-y-4">
          <div className="flex items-center justify-between border-b border-border/80 pb-3">
            <div className="flex items-center gap-2.5">
              <div className="w-9 h-9 rounded-xl bg-app-accent-soft text-app-accent flex items-center justify-center">
                <Component className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title">214 Bộ thủ Khang Hy</h3>
                <p className="text-xs text-muted font-serif">Nền tảng cấu tạo Hán tự</p>
              </div>
            </div>
            <Link href="/radicals">
              <Button size="sm" variant="outline" className="text-xs font-serif border-[#E9DDD1] hover:bg-[#FFF9F3] min-h-[36px] cursor-pointer">
                Tra cứu
              </Button>
            </Link>
          </div>

          <div className="grid grid-cols-2 gap-3 text-center">
            <div className="p-3 rounded-xl bg-page/70 border border-border/60">
              <p className="text-xs text-muted font-serif">Bộ thủ đã nhớ</p>
              <p className="text-xl font-serif font-bold text-title mt-0.5">
                {radicalsStats ? `${radicalsStats.learnedCount}/214` : '0/214'}
              </p>
              <p className="text-[10px] text-muted font-serif">
                {radicalsStats ? `${radicalsStats.percentage}%` : '0%'}
              </p>
            </div>
            <div className="p-3 rounded-xl bg-page/70 border border-border/60">
              <p className="text-xs text-muted font-serif">Bộ thủ đánh dấu</p>
              <p className="text-xl font-serif font-bold text-gold mt-0.5">
                {radicalsStats ? radicalsStats.favoritesCount : 0}
              </p>
              <p className="text-[10px] text-muted font-serif">Yêu thích</p>
            </div>
            <div className="p-3 rounded-xl bg-page/70 border border-border/60">
              <p className="text-xs text-muted font-serif">Điểm trắc nghiệm</p>
              <p className="text-xl font-serif font-bold text-jade mt-0.5">
                {bestQuizScore !== null ? `${bestQuizScore}%` : 'Chưa thi'}
              </p>
              <p className="text-[10px] text-muted font-serif">Cao nhất</p>
            </div>
            <div className="p-3 rounded-xl bg-page/70 border border-border/60">
              <p className="text-xs text-muted font-serif">Lượt trắc nghiệm</p>
              <p className="text-xl font-serif font-bold text-app-accent mt-0.5">
                {radicalQuizScores.length} lượt
              </p>
              <p className="text-[10px] text-muted font-serif">Phản xạ bộ thủ</p>
            </div>
          </div>
        </div>

      </div>

    </div>
  )
}
