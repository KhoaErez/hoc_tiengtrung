import { createClient, getCachedAuthUser, getCachedUserProfile } from '@/lib/supabase/server'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { 
  BookOpen, 
  PenTool, 
  Component, 
  Keyboard, 
  ArrowRight, 
  CheckCircle2, 
  Flame, 
  GraduationCap,
  Award,
  PlayCircle,
  RotateCcw,
  Clock
} from 'lucide-react'
import { HSK_LEVELS, getHskAuditData } from '@/data/hsk-curriculum'
import { getCachedSystemLessonCounts, getCachedAllVocabCounts } from '@/lib/curriculum-cache'
import { MascotAvatar } from '@/components/mascot/mascot-avatar'
import { formatNumber } from '@/lib/utils'

export const dynamic = 'force-dynamic'

export default async function HomePage() {
  const supabase = await createClient()
  
  // 1. Tải song song dữ liệu bộ đếm bài học hệ thống (< 1ms từ cache), auth session và số từ thực tế Supabase
  const [levelLessonCounts, user, liveVocabCountsRes] = await Promise.all([
    getCachedSystemLessonCounts(),
    getCachedAuthUser(),
    getCachedAllVocabCounts(),
  ])
  
  let displayName = 'Học viên'
  const userVocabsPerLevel: Record<number, number> = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0 }
  let recentTyping: {
    exercise_id: string
    mode: string
    completed_sentences: number
    total_sentences: number
    updated_at: string
  } | null = null
  let needReviewMistakesCount = 0

  // 2. Nếu đã đăng nhập, tải dữ liệu tiến độ thật từ Supabase
  if (user) {
    const [profile, userVocabsRes, recentTypingRes, mistakesCountRes] = await Promise.all([
      getCachedUserProfile(user.id),
      supabase
        .from('user_vocabularies')
        .select('vocabularies!inner(hsk_level)')
        .eq('user_id', user.id)
        .limit(5000),
      supabase
        .from('typing_progress')
        .select('exercise_id, mode, completed_sentences, total_sentences, updated_at')
        .eq('user_id', user.id)
        .order('updated_at', { ascending: false })
        .limit(1)
        .maybeSingle(),
      supabase
        .from('typing_mistakes')
        .select('id', { count: 'exact', head: true })
        .eq('user_id', user.id)
        .eq('review_status', 'need_review')
    ])

    displayName = profile?.display_name || user?.user_metadata?.full_name || user?.email?.split('@')[0] || 'Học viên'
    recentTyping = recentTypingRes.data
    needReviewMistakesCount = mistakesCountRes.count || 0

    // Phân loại số từ vựng người dùng đã học theo từng cấp độ HSK 3.0
    userVocabsRes.data?.forEach((uv: unknown) => {
      const item = uv as { vocabularies: { hsk_level?: string } | { hsk_level?: string }[] }
      const v = Array.isArray(item.vocabularies) ? item.vocabularies[0] : item.vocabularies
      if (!v?.hsk_level) return
      if (v.hsk_level === 'HSK 7-9' || v.hsk_level === 'HSK 7') {
        userVocabsPerLevel[7] = (userVocabsPerLevel[7] || 0) + 1
        return
      }
      const match = v.hsk_level.match(/HSK (\d)/)
      if (match) {
        const lvl = parseInt(match[1], 10)
        if (lvl >= 1 && lvl <= 6) {
          userVocabsPerLevel[lvl] = (userVocabsPerLevel[lvl] || 0) + 1
        } else if (lvl >= 7 && lvl <= 9) {
          userVocabsPerLevel[7] = (userVocabsPerLevel[7] || 0) + 1
        }
      }
    })
  }

  // Bảng phối màu Đông Phương chuẩn hóa theo 3 giai đoạn HSK 3.0 (GF 0025-2021)
  const getStageTheme = (levelNum: number) => {
    if (levelNum <= 3) {
      // Sơ cấp (HSK 1 - 3): Sắc Ngọc Bích (Imperial Jade)
      return {
        badgeBg: 'bg-jade-soft text-jade border border-jade/30',
        progressBar: 'bg-jade',
        hoverBorder: 'hover:border-jade/60',
        stageLabel: 'Sơ cấp (初等)',
      }
    }
    if (levelNum <= 6) {
      // Trung cấp (HSK 4 - 6): Sắc Hoàng Kim & Cam Đất (Muted Gold)
      return {
        badgeBg: 'bg-gold-soft text-gold border border-gold/30',
        progressBar: 'bg-gold',
        hoverBorder: 'hover:border-gold/60',
        stageLabel: 'Trung cấp (中等)',
      }
    }
    // Cao cấp (HSK 7 - 9): Sắc Tử Sa Quý Tộc (Imperial Indigo / Purple)
    return {
      badgeBg: 'bg-indigo-500/10 text-indigo-700 dark:text-indigo-400 border border-indigo-500/30',
      progressBar: 'bg-indigo-600',
      hoverBorder: 'hover:border-indigo-500/60',
      stageLabel: 'Cao cấp (高等)',
    }
  }

  return (
    <div className="max-w-6xl mx-auto space-y-6 sm:space-y-8 md:space-y-10 pb-16">
      
      {/* ======================================================== */}
      {/* 1. HERO BANNER CHO KHÁCH (CHƯA ĐĂNG NHẬP)                */}
      {/* ======================================================== */}
      {!user && (
        <div className="relative overflow-hidden rounded-2xl border border-border bg-gradient-to-br from-card via-page to-card p-5 sm:p-6 md:p-7 shadow-sm">
          {/* Watermark mây Á Đông trang nhã */}
          <div className="absolute top-0 right-0 w-80 h-80 opacity-5 pointer-events-none text-app-accent">
            <svg viewBox="0 0 200 200" fill="currentColor">
              <path d="M40,120 C20,120 10,105 20,90 C15,75 30,60 45,65 C55,45 80,45 90,60 C105,45 130,50 135,70 C150,70 160,85 155,100 C165,115 150,130 135,125 C125,140 100,140 90,125 C75,140 50,135 40,120 Z" />
            </svg>
          </div>

          <div className="flex flex-col md:flex-row items-center justify-between gap-5 md:gap-8 relative z-10">
            <div className="max-w-2xl space-y-3 sm:space-y-3.5 text-left">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-app-accent-soft text-app-accent text-xs sm:text-[13px] font-medium border border-app-accent/25">
                <GraduationCap className="w-4 h-4 shrink-0" />
                <span>Không gian học tiếng Trung hiện đại & bản sắc</span>
              </div>
              
              <h1 className="text-2xl sm:text-3xl md:text-[32px] lg:text-4xl font-serif font-bold text-title tracking-tight leading-snug">
                Chinh phục HSK & Hán tự từ cơ bản đến chuyên sâu
              </h1>
              
              <p className="text-body text-sm sm:text-base leading-relaxed">
                Lộ trình 6 cấp độ HSK chuẩn hóa với hơn 350 bài học, luyện gõ phím Pinyin thực tế, tra cứu 214 bộ thủ Khang Hy và ôn tập ngắt quãng thông minh.
              </p>
              
              <div className="pt-1.5 flex flex-col sm:flex-row gap-3 w-full sm:w-auto items-stretch sm:items-center">
                <Link href="/topics?q=HSK 1" className="w-full sm:w-auto">
                  <Button variant="primary" className="w-full sm:w-auto px-6 cursor-pointer min-h-[46px] text-sm sm:text-base font-semibold gap-2 shadow-xs">
                    <PlayCircle className="w-5 h-5 shrink-0" />
                    <span>Bắt đầu học ngay (HSK 1)</span>
                  </Button>
                </Link>
                <Link href="/register" className="w-full sm:w-auto">
                  <Button variant="secondary" className="w-full sm:w-auto px-5 cursor-pointer min-h-[46px] text-sm font-medium">
                    Tạo tài khoản lưu tiến độ
                  </Button>
                </Link>
              </div>

              {/* Hướng dẫn 3 bước cho người mới truy cập lần đầu */}
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-2.5 sm:gap-3 pt-3.5 border-t border-border/50 text-xs sm:text-[13px]">
                <div className="flex items-center gap-2.5 text-muted">
                  <span className="w-5 h-5 rounded-full bg-app-accent/10 text-app-accent font-bold flex items-center justify-center text-[11px] shrink-0">1</span>
                  <span>Chọn cấp độ cơ bản <strong>HSK 1</strong></span>
                </div>
                <div className="flex items-center gap-2.5 text-muted">
                  <span className="w-5 h-5 rounded-full bg-jade/10 text-jade font-bold flex items-center justify-center text-[11px] shrink-0">2</span>
                  <span>Học 10 từ & nghe phát âm</span>
                </div>
                <div className="flex items-center gap-2.5 text-muted">
                  <span className="w-5 h-5 rounded-full bg-gold/10 text-gold font-bold flex items-center justify-center text-[11px] shrink-0">3</span>
                  <span>Luyện gõ phím & ôn thẻ nhớ</span>
                </div>
              </div>
            </div>

            {/* Mascot Tiểu Bút chào đón người học (kích cỡ cân đối, không lấn át giao diện) */}
            <div className="hidden md:flex flex-col items-center justify-center p-2 shrink-0">
              <MascotAvatar state="open" size="xl" />
              <span className="text-xs font-medium text-muted mt-2 text-center">Tiểu Bút 🐼 đồng hành cùng bạn</span>
            </div>
          </div>
        </div>
      )}

      {/* ======================================================== */}
      {/* 2. KHU VỰC TIẾN ĐỘ & "TIẾP TỤC HỌC" (KHI ĐÃ ĐĂNG NHẬP)     */}
      {/* ======================================================== */}
      {user && (
        <div className="space-y-5 sm:space-y-6">
          {/* Header Chào Mừng & Thống kê nhanh */}
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 border-b border-border/80 pb-5">
            <div className="flex items-center gap-3.5 sm:gap-4">
              <div className="shrink-0 sm:hidden">
                <MascotAvatar state="idle" size="md" />
              </div>
              <div className="shrink-0 hidden sm:block">
                <MascotAvatar state="idle" size="lg" />
              </div>
              <div className="space-y-0.5 sm:space-y-1 min-w-0">
                <div className="flex items-center gap-2 flex-wrap">
                  <span className="text-xs sm:text-sm font-serif text-muted">Xin chào,</span>
                  <span className="text-lg sm:text-xl md:text-2xl font-serif font-bold text-title truncate">{displayName}</span>
                </div>
                <p className="text-xs sm:text-sm text-muted font-serif">
                  Hôm nay bạn muốn tiếp tục lộ trình học tập nào?
                </p>
              </div>
            </div>

            <div className="flex items-center gap-2 sm:gap-2.5 w-full sm:w-auto">
              <Link href="/profile" className="flex-1 sm:flex-initial">
                <Button variant="outline" size="sm" className="w-full sm:w-auto font-serif text-xs gap-1.5 border-[#E9DDD1] hover:bg-[#FFF9F3] cursor-pointer min-h-[40px] sm:min-h-[36px]">
                  <Award className="w-4 h-4 text-gold" />
                  <span>Hồ sơ học viên</span>
                </Button>
              </Link>
              <Link href="/review" className="flex-1 sm:flex-initial">
                <Button variant="primary" size="sm" className="w-full sm:w-auto font-serif text-xs gap-1.5 cursor-pointer min-h-[40px] sm:min-h-[36px]">
                  <Flame className="w-4 h-4" />
                  <span>Ôn tập ngay</span>
                </Button>
              </Link>
            </div>
          </div>

          {/* Cards "Tiếp tục học" & "Cần ôn tập" */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {/* Card 1: Tiếp tục bài luyện gần nhất */}
            <div className="p-5 rounded-2xl border border-border bg-card shadow-xs flex flex-col justify-between space-y-4">
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-app-accent font-sans uppercase tracking-wider">
                    <PlayCircle className="w-4 h-4" />
                    Tiếp tục học gần đây
                  </span>
                  {recentTyping && (
                    <span className="text-[11px] text-muted font-sans flex items-center gap-1">
                      <Clock className="w-3 h-3" />
                      Vừa học
                    </span>
                  )}
                </div>

                {recentTyping ? (
                  <div>
                    <h3 className="font-serif font-bold text-base text-title">
                      Luyện đánh máy: {recentTyping.exercise_id}
                    </h3>
                    <p className="text-xs text-muted font-serif mt-1">
                      Đã hoàn thành {recentTyping.completed_sentences}/{recentTyping.total_sentences} câu ({Math.round((recentTyping.completed_sentences / (recentTyping.total_sentences || 1)) * 100)}%)
                    </p>
                  </div>
                ) : (
                  <div>
                    <h3 className="font-serif font-bold text-base text-title">
                      Bắt đầu bài học đầu tiên (HSK 1)
                    </h3>
                    <p className="text-xs text-muted font-serif mt-1">
                      Làm quen với các câu chào hỏi và phát âm chuẩn Pinyin cơ bản.
                    </p>
                  </div>
                )}
              </div>

              <div className="pt-2 border-t border-border/60 flex items-center justify-between">
                <Link 
                  href={recentTyping ? '/typing' : '/topics?q=HSK 1'}
                  className="inline-flex items-center gap-1.5 text-xs font-serif font-semibold text-app-accent hover:text-accent-hover group"
                >
                  <span>{recentTyping ? 'Gõ tiếp ngay' : 'Khám phá HSK 1'}</span>
                  <ArrowRight className="w-3.5 h-3.5 transition-transform group-hover:translate-x-1" />
                </Link>
              </div>
            </div>

            {/* Card 2: Ôn tập câu sai / Từ vựng cần nhớ */}
            <div className="p-5 rounded-2xl border border-border bg-card shadow-xs flex flex-col justify-between space-y-4">
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-gold font-sans uppercase tracking-wider">
                    <RotateCcw className="w-4 h-4" />
                    Cần ôn tập & củng cố
                  </span>
                  {needReviewMistakesCount > 0 && (
                    <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-gold-soft text-gold">
                      {needReviewMistakesCount} câu sai
                    </span>
                  )}
                </div>

                <div>
                  <h3 className="font-serif font-bold text-base text-title">
                    {needReviewMistakesCount > 0 
                      ? `Bạn có ${needReviewMistakesCount} câu gõ sai cần luyện lại`
                      : 'Hệ thống thẻ nhớ Spaced Repetition'}
                  </h3>
                  <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                    {needReviewMistakesCount > 0
                      ? 'Luyện lại các câu từng gõ sai để chuyển hóa thành trí nhớ dài hạn.'
                      : 'Ôn tập từ vựng ngắt quãng giúp ghi nhớ sâu mặt chữ Hán và ý nghĩa.'}
                  </p>
                </div>
              </div>

              <div className="pt-2 border-t border-border/60 flex items-center justify-between">
                <Link 
                  href={needReviewMistakesCount > 0 ? '/typing' : '/review'}
                  className="inline-flex items-center gap-1.5 text-xs font-serif font-semibold text-gold hover:text-amber-700 group"
                >
                  <span>{needReviewMistakesCount > 0 ? 'Xem và gõ lại câu sai' : 'Mở kho ôn tập'}</span>
                  <ArrowRight className="w-3.5 h-3.5 transition-transform group-hover:translate-x-1" />
                </Link>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ======================================================== */}
      {/* 3. KHU VỰC TRỌNG TÂM: LỘ TRÌNH HSK 3.0 (3 GIAI ĐOẠN - 9 CẤP) */}
      {/* ======================================================== */}
      <section className="space-y-5">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-2 border-b border-border/80 pb-3">
          <div>
            <div className="flex items-center gap-2 flex-wrap">
              <span className="w-2.5 h-2.5 rounded-full bg-app-accent" />
              <h2 className="text-xl md:text-2xl font-serif font-bold text-title">
                Lộ trình học theo cấp độ HSK 3.0
              </h2>
              <span className="px-2 py-0.5 rounded-md text-[10px] font-mono font-medium bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20">
                Tiêu chuẩn GF 0025-2021
              </span>
            </div>
            <p className="text-xs md:text-sm text-muted font-serif mt-1">
              Khung chương trình 3 giai đoạn (Sơ cấp, Trung cấp, Cao cấp) với hệ thống từ vựng, chữ Hán và ngữ pháp mới nhất
            </p>
          </div>
          <div className="text-xs text-muted font-serif hidden sm:block">
            Nhấp vào từng cấp độ để xem danh sách bài học
          </div>
        </div>

        {/* Grid Thẻ HSK 3.0 Chuẩn Hóa Chiều Cao & Mỹ Thuật Đông Phương */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3.5 sm:gap-5">
          {([1, 2, 3, 4, 5, 6, 7] as const).map((levelNum) => {
            const info = HSK_LEVELS[levelNum]
            const audit = getHskAuditData(levelNum)
            const totalLessons = levelLessonCounts[levelNum] || 0
            const learnedVocabs = userVocabsPerLevel[levelNum] || 0
            const targetVocab = info.vocabTarget
            const liveCount = liveVocabCountsRes?.counts?.[info.name]
            const systemVocab = typeof liveCount === 'number' ? liveCount : (audit?.systemVocabCount || 0)
            const isComingSoon = audit?.status === 'coming_soon' || (systemVocab === 0 && totalLessons === 0)

            const percent = user && systemVocab > 0 
              ? Math.min(100, Math.round((learnedVocabs / systemVocab) * 100)) 
              : 0
            const theme = getStageTheme(levelNum)

            // Trạng thái học tập
            let statusText = 'Chưa bắt đầu'
            let statusBadgeClass = 'bg-black/5 text-muted'
            if (isComingSoon) {
              statusText = 'Đang hoàn thiện'
              statusBadgeClass = 'bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20'
            } else if (user && percent === 100) {
              statusText = 'Đã hoàn thành'
              statusBadgeClass = 'bg-jade-soft text-jade'
            } else if (user && percent > 0) {
              statusText = 'Đang học'
              statusBadgeClass = 'bg-gold-soft text-gold'
            }

            return (
              <Link 
                key={levelNum} 
                href={`/topics?q=${encodeURIComponent(info.tag)}`}
                className={`group relative flex flex-col justify-between p-5 sm:p-6 rounded-2xl border border-border bg-card ${theme.hoverBorder} hover:shadow-md transition-all duration-200 overflow-hidden h-full select-none`}
              >
                {/* Viền màu nhỏ phía trên thẻ */}
                <div className={`absolute top-0 left-0 right-0 h-1.5 ${theme.progressBar}`} />

                <div className="space-y-3.5">
                  {/* Cấp độ Badge & Giai đoạn */}
                  <div className="flex items-center justify-between gap-2">
                    <div className="flex items-center gap-2">
                      <span className={`px-3 py-1 rounded-xl text-xs sm:text-sm font-sans font-bold ${theme.badgeBg}`}>
                        {info.name}
                      </span>
                      <span className="text-xs font-sans text-muted px-2.5 py-0.5 rounded-lg bg-page border border-border">
                        {theme.stageLabel}
                      </span>
                    </div>
                    <span className={`px-2.5 py-1 rounded-full text-xs font-sans font-medium ${statusBadgeClass}`}>
                      {statusText}
                    </span>
                  </div>

                  {/* Tiêu đề & Thông số bài học */}
                  <div>
                    <h3 className="font-serif font-bold text-xl text-title group-hover:text-app-accent transition-colors">
                      {info.title}
                    </h3>
                    <div className="flex items-center gap-2.5 text-xs sm:text-sm text-muted font-sans mt-1.5 flex-wrap">
                      <span className="flex items-center gap-1.5 font-medium">
                        <BookOpen className="w-4 h-4 text-app-accent shrink-0" />
                        <strong>{isComingSoon ? '0' : totalLessons}</strong> bài học
                      </span>
                      <span>•</span>
                      {isComingSoon ? (
                        <span>Mục tiêu: <strong suppressHydrationWarning>{formatNumber(targetVocab)}</strong> từ</span>
                      ) : (
                        <span>Kho từ: <strong suppressHydrationWarning>{formatNumber(systemVocab)}</strong> từ</span>
                      )}
                    </div>
                  </div>

                  {/* Mô tả ngắn */}
                  <p className="text-sm text-body leading-relaxed line-clamp-2">
                    {info.description}
                  </p>
                </div>

                {/* Phần tiến độ học tập */}
                <div className="pt-4 mt-4 border-t border-border/70 space-y-2.5">
                  <div className="flex items-center justify-between text-xs sm:text-sm font-sans">
                    <span className="text-muted">
                      {isComingSoon ? 'Trạng thái lộ trình' : 'Tiến độ từ vựng'}
                    </span>
                    <span className="font-bold text-title" suppressHydrationWarning>
                      {isComingSoon 
                        ? 'Đang biên soạn dữ liệu' 
                        : user 
                        ? `${formatNumber(learnedVocabs)}/${formatNumber(systemVocab)} (${percent}%)` 
                        : `${formatNumber(systemVocab)} từ có sẵn`}
                    </span>
                  </div>
                  
                  {/* Progress bar */}
                  <div className="w-full bg-track h-2 rounded-full overflow-hidden">
                    <div 
                      className={`h-full rounded-full ${theme.progressBar} transition-all duration-500`}
                      style={{ width: `${isComingSoon ? 0 : user ? percent : 0}%` }}
                    />
                  </div>

                  <div className="flex items-center justify-between pt-1">
                    <span className="text-xs sm:text-sm font-semibold text-app-accent group-hover:text-accent-hover transition-colors flex items-center gap-1.5">
                      Bắt đầu học ngay
                      <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1" />
                    </span>
                    {user && percent === 100 && (
                      <span className="flex items-center gap-1 text-xs text-jade font-medium font-sans">
                        <CheckCircle2 className="w-4 h-4" /> Hoàn thành
                      </span>
                    )}
                  </div>
                </div>
              </Link>
            )
          })}
        </div>
      </section>

      {/* ======================================================== */}
      {/* 4. CÔNG CỤ HỌC TẬP & LUYỆN KỸ NĂNG                       */}
      {/* ======================================================== */}
      <section className="space-y-4">
        <div className="border-b border-border/80 pb-3">
          <h2 className="text-xl sm:text-2xl font-serif font-bold text-title">Công cụ học tập & Luyện kỹ năng</h2>
          <p className="text-xs sm:text-sm text-muted mt-0.5">Các công cụ hỗ trợ nâng cao toàn diện kỹ năng tiếng Trung</p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 sm:gap-5">
          {/* Luyện đánh máy */}
          <Link 
            href="/typing" 
            className="group p-5 sm:p-6 rounded-2xl border border-border bg-card hover:border-app-accent/60 hover:shadow-xs active:scale-[0.99] transition-all flex flex-col justify-between touch-manipulation"
          >
            <div className="space-y-3.5">
              <div className="w-11 h-11 rounded-xl bg-app-accent-soft text-app-accent flex items-center justify-center">
                <Keyboard className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-lg text-title group-hover:text-app-accent transition-colors">
                  Luyện đánh máy
                </h3>
                <p className="text-sm text-muted mt-1 leading-relaxed">
                  Luyện gõ chữ Hán theo từng cấp độ, đo tốc độ WPM và độ chính xác gõ thực tế.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs sm:text-sm font-semibold text-app-accent flex items-center gap-1.5">
              <span>Luyện gõ ngay</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* 214 Bộ thủ */}
          <Link 
            href="/radicals" 
            className="group p-5 sm:p-6 rounded-2xl border border-border bg-card hover:border-jade/60 hover:shadow-xs active:scale-[0.99] transition-all flex flex-col justify-between touch-manipulation"
          >
            <div className="space-y-3.5">
              <div className="w-11 h-11 rounded-xl bg-jade-soft text-jade flex items-center justify-center">
                <Component className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-lg text-title group-hover:text-jade transition-colors">
                  214 Bộ thủ Khang Hy
                </h3>
                <p className="text-sm text-muted mt-1 leading-relaxed">
                  Phân loại 17 nhóm nét, tra cứu ý nghĩa, Flashcard và Trắc nghiệm phản xạ bộ thủ.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs sm:text-sm font-semibold text-jade flex items-center gap-1.5">
              <span>Học bộ thủ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Luyện viết AI */}
          <Link 
            href="/write" 
            className="group p-5 sm:p-6 rounded-2xl border border-border bg-card hover:border-title/60 hover:shadow-xs active:scale-[0.99] transition-all flex flex-col justify-between touch-manipulation sm:col-span-2 md:col-span-1"
          >
            <div className="space-y-3.5">
              <div className="flex items-center justify-between">
                <div className="w-11 h-11 rounded-xl bg-navy-soft text-title flex items-center justify-center">
                  <PenTool className="w-5 h-5" />
                </div>
                <span className="text-xs font-sans px-2.5 py-0.5 rounded-full bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20">
                  Sắp ra mắt
                </span>
              </div>
              <div>
                <h3 className="font-serif font-bold text-lg text-title group-hover:text-app-accent transition-colors">
                  Luyện Viết AI
                </h3>
                <p className="text-sm text-muted mt-1 leading-relaxed">
                  Luyện viết tiếng Trung cùng trợ lý AI: phát hiện lỗi ngữ pháp, tinh chỉnh văn phong và cải thiện diễn đạt.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs sm:text-sm font-semibold text-amber-700 dark:text-amber-400 flex items-center gap-1.5">
              <span>Xem tính năng sắp tới</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>
        </div>
      </section>

    </div>
  )
}
