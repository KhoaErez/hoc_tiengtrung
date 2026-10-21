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
  Sparkles,
  Award,
  PlayCircle,
  RotateCcw,
  Clock
} from 'lucide-react'
import { HSK_LEVELS, getHskAuditData } from '@/data/hsk-curriculum'
import { getCachedSystemLessonCounts } from '@/lib/curriculum-cache'
import { MascotAvatar } from '@/components/mascot/mascot-avatar'
import { formatNumber } from '@/lib/utils'

export const dynamic = 'force-dynamic'

export default async function HomePage() {
  const supabase = await createClient()
  
  // 1. Tải song song dữ liệu bộ đếm bài học hệ thống (< 1ms từ cache) và auth session (đã cache)
  const [levelLessonCounts, user] = await Promise.all([
    getCachedSystemLessonCounts(),
    getCachedAuthUser(),
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
        .eq('user_id', user.id),
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
    <div className="max-w-6xl mx-auto space-y-10 pb-16">
      
      {/* ======================================================== */}
      {/* 1. HERO BANNER CHO KHÁCH (CHƯA ĐĂNG NHẬP)                */}
      {/* ======================================================== */}
      {!user && (
        <div className="relative overflow-hidden rounded-2xl border border-border bg-gradient-to-br from-card via-page to-card p-6 md:p-10 shadow-sm">
          {/* Watermark mây Á Đông trang nhã */}
          <div className="absolute top-0 right-0 w-80 h-80 opacity-5 pointer-events-none text-app-accent">
            <svg viewBox="0 0 200 200" fill="currentColor">
              <path d="M40,120 C20,120 10,105 20,90 C15,75 30,60 45,65 C55,45 80,45 90,60 C105,45 130,50 135,70 C150,70 160,85 155,100 C165,115 150,130 135,125 C125,140 100,140 90,125 C75,140 50,135 40,120 Z" />
            </svg>
          </div>

          <div className="flex flex-col md:flex-row items-center justify-between gap-8 relative z-10">
            <div className="max-w-2xl space-y-4 text-left">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-app-accent-soft text-app-accent text-xs font-serif font-medium border border-app-accent/30">
                <Sparkles className="w-3.5 h-3.5" />
                <span>Không gian học tiếng Trung hiện đại & bản sắc</span>
              </div>
              
              <h1 className="text-3xl md:text-4xl font-serif font-bold text-title tracking-tight leading-tight">
                Chinh phục HSK & Hán tự từ cơ bản đến chuyên sâu
              </h1>
              
              <p className="text-body font-serif text-sm md:text-base leading-relaxed">
                Lộ trình 6 cấp độ HSK chuẩn hóa với hơn 350 bài học, luyện gõ phím Pinyin thực tế, tra cứu 214 bộ thủ Khang Hy và ôn tập ngắt quãng thông minh.
              </p>
              
              <div className="pt-2 flex flex-wrap gap-3">
                <Link href="/login">
                  <Button className="font-serif bg-title hover:bg-[#2A3250] text-white px-6 rounded-xl shadow-xs cursor-pointer">
                    Đăng nhập để lưu tiến độ
                  </Button>
                </Link>
                <Link href="/register">
                  <Button variant="outline" className="font-serif px-6 rounded-xl border-border hover:bg-black/5 text-title cursor-pointer">
                    Tạo tài khoản miễn phí
                  </Button>
                </Link>
              </div>
            </div>

            {/* Mascot Tiểu Bút chào đón người học */}
            <div className="hidden md:flex flex-col items-center justify-center p-4">
              <MascotAvatar state="open" size="2xl" />
              <span className="text-xs font-serif text-muted mt-2">Tiểu Bút 🐼 đồng hành cùng bạn</span>
            </div>
          </div>
        </div>
      )}

      {/* ======================================================== */}
      {/* 2. KHU VỰC TIẾN ĐỘ & "TIẾP TỤC HỌC" (KHI ĐÃ ĐĂNG NHẬP)     */}
      {/* ======================================================== */}
      {user && (
        <div className="space-y-6">
          {/* Header Chào Mừng & Thống kê nhanh */}
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 border-b border-border/80 pb-5">
            <div className="flex items-center gap-4">
              <MascotAvatar state="idle" size="lg" />
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="text-sm font-serif text-muted">Xin chào,</span>
                  <span className="text-xl md:text-2xl font-serif font-bold text-title">{displayName}</span>
                  <span className="inline-block text-amber-500">✨</span>
                </div>
                <p className="text-xs md:text-sm text-muted font-serif">
                  Hôm nay bạn muốn tiếp tục lộ trình học tập nào?
                </p>
              </div>
            </div>

            <div className="flex items-center gap-2.5">
              <Link href="/profile">
                <Button variant="outline" size="sm" className="font-serif rounded-xl border-border text-xs gap-1.5 hover:border-app-accent/40 cursor-pointer">
                  <Award className="w-4 h-4 text-gold" />
                  <span>Hồ sơ học viên</span>
                </Button>
              </Link>
              <Link href="/review">
                <Button size="sm" className="font-serif bg-app-accent hover:bg-accent-hover text-white rounded-xl text-xs gap-1.5 shadow-2xs cursor-pointer">
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
                      Luyện đánh máy Pinyin: {recentTyping.exercise_id}
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
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {([1, 2, 3, 4, 5, 6, 7] as const).map((levelNum) => {
            const info = HSK_LEVELS[levelNum]
            const audit = getHskAuditData(levelNum)
            const totalLessons = levelLessonCounts[levelNum] || 0
            const learnedVocabs = userVocabsPerLevel[levelNum] || 0
            const targetVocab = info.vocabTarget
            const systemVocab = audit?.systemVocabCount || 0
            const isComingSoon = audit?.status === 'coming_soon'

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
                className={`group relative flex flex-col justify-between p-5 rounded-2xl border border-border bg-card ${theme.hoverBorder} hover:shadow-md transition-all duration-200 overflow-hidden h-full select-none`}
              >
                {/* Viền màu nhỏ phía trên thẻ */}
                <div className={`absolute top-0 left-0 right-0 h-1 ${theme.progressBar}`} />

                <div className="space-y-3">
                  {/* Cấp độ Badge & Giai đoạn */}
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-1.5">
                      <span className={`px-2.5 py-1 rounded-lg text-xs font-serif font-bold ${theme.badgeBg}`}>
                        {info.name}
                      </span>
                      <span className="text-[10px] font-serif text-muted px-2 py-0.5 rounded-md bg-page border border-border">
                        {theme.stageLabel}
                      </span>
                    </div>
                    <span className={`px-2 py-0.5 rounded-full text-[10px] font-sans font-medium ${statusBadgeClass}`}>
                      {statusText}
                    </span>
                  </div>

                  {/* Tiêu đề & Thông số bài học */}
                  <div>
                    <h3 className="font-serif font-bold text-lg text-title group-hover:text-app-accent transition-colors">
                      {info.title}
                    </h3>
                    <div className="flex items-center gap-2 text-xs text-muted font-serif mt-1 flex-wrap">
                      <span className="flex items-center gap-1">
                        <BookOpen className="w-3.5 h-3.5 text-app-accent" />
                        <strong>{isComingSoon ? '0' : totalLessons}</strong> bài học
                      </span>
                      <span>•</span>
                      {isComingSoon ? (
                        <span>Mục tiêu HSK 3.0: <strong suppressHydrationWarning>{formatNumber(targetVocab)}</strong> từ</span>
                      ) : (
                        <span>Hệ thống: <strong suppressHydrationWarning>{formatNumber(systemVocab)}</strong> từ</span>
                      )}
                      <span>•</span>
                      <span><strong suppressHydrationWarning>{formatNumber(info.charTarget)}</strong> chữ</span>
                    </div>
                  </div>

                  {/* Mô tả ngắn có xử lý clamp hợp lý */}
                  <p className="text-xs text-body font-serif line-clamp-2 leading-relaxed">
                    {info.description}
                  </p>
                </div>

                {/* Phần tiến độ học tập */}
                <div className="pt-4 mt-4 border-t border-border/70 space-y-2">
                  <div className="flex items-center justify-between text-xs font-serif">
                    <span className="text-muted">
                      {isComingSoon ? 'Trạng thái lộ trình' : 'Tiến độ từ thực tế'}
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
                    <span className="text-[11px] text-muted font-serif group-hover:text-app-accent transition-colors flex items-center gap-1 font-medium">
                      Bắt đầu học ngay
                      <ArrowRight className="w-3.5 h-3.5 transition-transform group-hover:translate-x-1" />
                    </span>
                    {user && percent === 100 && (
                      <span className="flex items-center gap-1 text-[11px] text-jade font-serif">
                        <CheckCircle2 className="w-3.5 h-3.5" /> Hoàn thành
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
          <h2 className="text-xl font-serif font-bold text-title">Công cụ học tập & Luyện kỹ năng</h2>
          <p className="text-xs text-muted font-serif mt-0.5">Các công cụ hỗ trợ nâng cao toàn diện kỹ năng tiếng Trung</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {/* Luyện đánh máy */}
          <Link 
            href="/typing" 
            className="group p-5 rounded-2xl border border-border bg-card hover:border-app-accent/60 hover:shadow-xs transition-all flex flex-col justify-between"
          >
            <div className="space-y-3">
              <div className="w-10 h-10 rounded-xl bg-app-accent-soft text-app-accent flex items-center justify-center">
                <Keyboard className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-app-accent transition-colors">
                  Luyện đánh máy Pinyin
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Luyện gõ chữ Hán theo từng cấp độ, đo tốc độ WPM và độ chính xác gõ thực tế.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs font-serif font-medium text-app-accent flex items-center gap-1">
              <span>Luyện gõ ngay</span>
              <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* 214 Bộ thủ */}
          <Link 
            href="/radicals" 
            className="group p-5 rounded-2xl border border-border bg-card hover:border-jade/60 hover:shadow-xs transition-all flex flex-col justify-between"
          >
            <div className="space-y-3">
              <div className="w-10 h-10 rounded-xl bg-jade-soft text-jade flex items-center justify-center">
                <Component className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-jade transition-colors">
                  214 Bộ thủ Khang Hy
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Phân loại 17 nhóm nét, tra cứu ý nghĩa, Flashcard và Trắc nghiệm phản xạ bộ thủ.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs font-serif font-medium text-jade flex items-center gap-1">
              <span>Học bộ thủ</span>
              <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Luyện viết AI */}
          <Link 
            href="/write" 
            className="group p-5 rounded-2xl border border-border bg-card hover:border-title/60 hover:shadow-xs transition-all flex flex-col justify-between"
          >
            <div className="space-y-3">
              <div className="w-10 h-10 rounded-xl bg-navy-soft text-title flex items-center justify-center">
                <PenTool className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-app-accent transition-colors">
                  Luyện viết câu AI
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Viết đoạn văn tự do và nhận phản hồi, sửa lỗi ngữ pháp tự động từ AI.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs font-serif font-medium text-title flex items-center gap-1">
              <span>Thực hành viết</span>
              <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>
        </div>
      </section>

    </div>
  )
}
