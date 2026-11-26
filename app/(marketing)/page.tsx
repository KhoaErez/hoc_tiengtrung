import { createClient, getCachedAuthUser, getCachedUserProfile } from '@/lib/supabase/server'
import Link from 'next/link'
import Image from 'next/image'
import {
  BookOpen,
  Keyboard,
  ArrowRight,
  Sparkles,
  RotateCcw,
  PlayCircle,
  Library,
  Headphones,
  Layers,
  Languages,
  BrainCircuit,
  Briefcase,
  MessageCircle,
} from 'lucide-react'
import {
  HSK_CANONICAL_DATA,
  HSK_LEVEL_ORDER,
  resolveHskVocabCount,
  type HskCanonicalLevelKey,
} from '@/constants/hskData'
import { getCachedSystemLessonCounts, getCachedAllVocabCounts } from '@/lib/curriculum-cache'
import { Hero3DSection } from '@/components/home/hero-3d-section'
import { HskRoadmapSelector, type HskRoadmapItem } from '@/components/home/hsk-roadmap-selector'
import { formatNumber } from '@/lib/utils'

export const dynamic = 'force-dynamic'

export default async function HomePage() {
  const supabase = await createClient()

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
    current_sentence_index?: number
    updated_at: string
    hsk_level?: number
    lesson_id?: string
    lesson_title?: string
    current_question_id?: string
    current_question_text?: string
    practice_mode?: string
  } | null = null
  let needReviewMistakesCount = 0

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
        .select('*')
        .eq('user_id', user.id)
        .order('updated_at', { ascending: false })
        .limit(1)
        .maybeSingle(),
      supabase
        .from('typing_mistakes')
        .select('id', { count: 'exact', head: true })
        .eq('user_id', user.id)
        .eq('review_status', 'need_review'),
    ])

    displayName = profile?.display_name || user?.user_metadata?.full_name || user?.email?.split('@')[0] || 'Học viên'
    recentTyping = recentTypingRes.data
    needReviewMistakesCount = mistakesCountRes.count || 0

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

  const recentExerciseUrl = recentTyping
    ? `/typing?practice=${recentTyping.practice_mode || (recentTyping.mode === 'translate_hsk' ? 'translate' : 'visual')}${recentTyping.hsk_level ? `&hskLevel=${recentTyping.hsk_level}` : ''}${recentTyping.lesson_id ? `&lessonId=${recentTyping.lesson_id}` : ''}${recentTyping.current_question_id ? `&sentenceId=${recentTyping.current_question_id}` : ''}&resume=1`
    : null

  const recentExerciseTitle = recentTyping?.lesson_title || (recentTyping?.current_question_text ? `Câu: ${recentTyping.current_question_text.slice(0, 18)}...` : null)

  // Xây dựng dữ liệu từ Single Source of Truth (constants/hskData.ts)
  const roadmapItems: HskRoadmapItem[] = HSK_LEVEL_ORDER.map((levelNum: HskCanonicalLevelKey) => {
    const canonical = HSK_CANONICAL_DATA[levelNum]
    const vocabCount = resolveHskVocabCount(levelNum, liveVocabCountsRes?.counts)
    const totalLessons = levelLessonCounts[levelNum] ?? canonical.defaultLessons
    const learnedVocabs = userVocabsPerLevel[levelNum] || 0
    const percent = user && vocabCount > 0 && !canonical.isComingSoon
      ? Math.min(100, Math.round((learnedVocabs / vocabCount) * 100))
      : 0

    return {
      id: String(levelNum),
      tag: canonical.tag,
      name: canonical.name,
      title: canonical.title,
      rankTitle: canonical.rankTitle,
      rankShort: canonical.rankShort,
      stageName: canonical.stageName,
      accentColor: canonical.accentColor,
      coverImage: canonical.coverImage,
      description: canonical.summary,
      vocabCount,
      targetVocab: canonical.targetVocab,
      charTarget: canonical.charTarget,
      grammarTarget: canonical.grammarTarget,
      totalLessons,
      learnedVocabs,
      percent,
      isComingSoon: canonical.isComingSoon,
    }
  })

  return (
    <div className="w-full space-y-14 sm:space-y-16 md:space-y-20 pb-4 sm:pb-8 md:pb-12">

      {/* 1. HERO SECTION */}
      <Hero3DSection
        displayName={displayName}
        isLoggedIn={!!user}
        recentExerciseTitle={recentExerciseTitle}
        recentExerciseUrl={recentExerciseUrl}
      />

      {/* 2. LỘ TRÌNH CHINH PHỤC HSK 3.0 (INTERACTIVE TABS + 1 FEATURED STAGE CARD) */}
      <section id="hanh-trinh-hsk" className="space-y-6 scroll-mt-24">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-3 border-b border-[#E2E8F0] dark:border-[#384869] pb-4">
          <div className="space-y-1.5">
            <div className="flex items-center gap-2.5 flex-wrap">
              <span className="w-2.5 h-2.5 rounded-full bg-[#0D9488]" />
              <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#182238] dark:text-white">
                Lộ trình Chinh phục HSK 3.0
              </h2>
              <span className="px-3 py-0.5 rounded-full text-xs font-serif font-semibold bg-white dark:bg-[#182238] border border-[#E2E8F0] dark:border-[#384869] text-[#182238] dark:text-slate-200 shadow-2xs">
                Tiêu chuẩn GF 0025-2021
              </span>
            </div>
            <p className="text-xs sm:text-sm text-[#475569] dark:text-slate-300 font-serif">
              Chọn cấp độ HSK bên dưới để xem thông tin chi tiết, số lượng bài học và tiến độ của bạn.
            </p>
          </div>
        </div>

        <HskRoadmapSelector items={roadmapItems} isLoggedIn={!!user} />

        {/* Chuyên đề Thực chiến (1 Title per card, concise copy, zero duplication) */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-5 pt-2">
          <Link
            href="/topics?q=Giao tiếp"
            className="edtech-card-interactive p-6 flex items-center justify-between gap-4 group"
          >
            <div className="flex items-start gap-4 min-w-0">
              <div className="w-12 h-12 rounded-2xl bg-amber-50 dark:bg-amber-950/50 border border-amber-200/80 dark:border-amber-800 flex items-center justify-center shrink-0">
                <MessageCircle className="w-6 h-6 text-amber-600 dark:text-amber-400 stroke-[1.75]" />
              </div>
              <div className="space-y-1 min-w-0">
                <h3 className="font-serif font-bold text-base sm:text-lg text-[#182238] dark:text-white group-hover:text-[#0D9488] transition-colors truncate">
                  Tiếng Trung Giao tiếp Thực chiến
                </h3>
                <p className="text-xs text-[#475569] dark:text-slate-300 font-serif line-clamp-2">
                  Hội thoại ngữ cảnh du lịch, mua sắm, nhà hàng với {formatNumber(liveVocabCountsRes?.counts?.['Giao tiếp'] || 163)} từ thông dụng.
                </p>
              </div>
            </div>
            <ArrowRight className="w-5 h-5 text-muted group-hover:text-[#0D9488] group-hover:translate-x-1 transition-all shrink-0" />
          </Link>

          <Link
            href="/topics?q=Công xưởng"
            className="edtech-card-interactive p-6 flex items-center justify-between gap-4 group"
          >
            <div className="flex items-start gap-4 min-w-0">
              <div className="w-12 h-12 rounded-2xl bg-slate-100 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 flex items-center justify-center shrink-0">
                <Briefcase className="w-6 h-6 text-[#182238] dark:text-slate-200 stroke-[1.75]" />
              </div>
              <div className="space-y-1 min-w-0">
                <h3 className="font-serif font-bold text-base sm:text-lg text-[#182238] dark:text-white group-hover:text-[#0D9488] transition-colors truncate">
                  Tiếng Trung Công xưởng & Nhà máy
                </h3>
                <p className="text-xs text-[#475569] dark:text-slate-300 font-serif line-clamp-2">
                  Thuật ngữ sản xuất, linh kiện và an toàn lao động với {formatNumber(liveVocabCountsRes?.counts?.['Công xưởng'] || 380)} thuật ngữ.
                </p>
              </div>
            </div>
            <ArrowRight className="w-5 h-5 text-muted group-hover:text-[#0D9488] group-hover:translate-x-1 transition-all shrink-0" />
          </Link>
        </div>
      </section>

      {/* 3. THƯ VIỆN TRI THỨC HÁN NGỮ (MINIMAL 4-COLUMN BENTO GRID: ICON + 1 H3 + SHORT DESC + 1 LINK) */}
      <section id="thu-vien" className="space-y-6 scroll-mt-24">
        <div className="border-b border-[#E2E8F0] dark:border-[#384869] pb-4 space-y-1.5">
          <div className="flex items-center gap-2">
            <span className="w-2.5 h-2.5 rounded-full bg-[#DC2626]" />
            <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#182238] dark:text-white">
              Thư viện Tri thức Hán ngữ
            </h2>
          </div>
          <p className="text-xs sm:text-sm text-[#475569] dark:text-slate-300 font-serif">
            Công cụ tra cứu, ngữ pháp, 214 bộ thủ và bài đọc chuẩn hóa giúp bạn tự học hiệu quả.
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-5">
          {/* Card 1: Tra từ HSK 3.0 */}
          <Link href="/vocabulary" className="edtech-card-interactive p-6 flex flex-col justify-between gap-5 group">
            <div className="space-y-4">
              <div className="w-12 h-12 rounded-2xl bg-[#F0FDFA] dark:bg-teal-950/50 border border-[#0D9488]/20 flex items-center justify-center">
                <Layers className="w-6 h-6 text-[#0D9488] stroke-[1.75]" />
              </div>
              <div className="space-y-1.5">
                <h3 className="font-serif font-bold text-lg text-[#182238] dark:text-white group-hover:text-[#0D9488] transition-colors">
                  Tra từ HSK 3.0
                </h3>
                <p className="text-xs text-[#475569] dark:text-slate-300 font-serif leading-relaxed line-clamp-2">
                  Tra cứu chữ Hán, Pinyin, nghĩa tiếng Việt và audio phát âm chuẩn Bắc Kinh.
                </p>
              </div>
            </div>
            <span className="inline-flex items-center justify-between text-xs font-serif font-bold text-[#0D9488] pt-3 border-t border-[#E2E8F0] dark:border-white/10">
              <span>Tra từ điển ngay</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </span>
          </Link>

          {/* Card 2: Ngữ pháp Chuyên sâu */}
          <Link href="/grammar" className="edtech-card-interactive p-6 flex flex-col justify-between gap-5 group">
            <div className="space-y-4">
              <div className="w-12 h-12 rounded-2xl bg-indigo-50 dark:bg-indigo-950/50 border border-indigo-200/70 dark:border-indigo-800 flex items-center justify-center">
                <Library className="w-6 h-6 text-indigo-600 dark:text-indigo-400 stroke-[1.75]" />
              </div>
              <div className="space-y-1.5">
                <h3 className="font-serif font-bold text-lg text-[#182238] dark:text-white group-hover:text-indigo-600 transition-colors">
                  Ngữ pháp Chuyên sâu
                </h3>
                <p className="text-xs text-[#475569] dark:text-slate-300 font-serif leading-relaxed line-clamp-2">
                  Công thức trực quan theo từng cấp độ HSK kèm ví dụ phân tích song ngữ.
                </p>
              </div>
            </div>
            <span className="inline-flex items-center justify-between text-xs font-serif font-bold text-indigo-600 dark:text-indigo-400 pt-3 border-t border-[#E2E8F0] dark:border-white/10">
              <span>Xem cẩm nang</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </span>
          </Link>

          {/* Card 3: 214 Bộ thủ Khang Hy */}
          <Link href="/radicals" className="edtech-card-interactive p-6 flex flex-col justify-between gap-5 group">
            <div className="space-y-4">
              <div className="w-12 h-12 rounded-2xl bg-[#FEF2F2] dark:bg-[#DC2626]/20 border border-[#DC2626]/20 flex items-center justify-center">
                <Sparkles className="w-6 h-6 text-[#DC2626] stroke-[1.75]" />
              </div>
              <div className="space-y-1.5">
                <h3 className="font-serif font-bold text-lg text-[#182238] dark:text-white group-hover:text-[#DC2626] transition-colors">
                  214 Bộ thủ Khang Hy
                </h3>
                <p className="text-xs text-[#475569] dark:text-slate-300 font-serif leading-relaxed line-clamp-2">
                  Gốc rễ cấu tạo chữ Hán qua 17 nhóm nét cùng Flashcard và Quiz ghi nhớ.
                </p>
              </div>
            </div>
            <span className="inline-flex items-center justify-between text-xs font-serif font-bold text-[#DC2626] pt-3 border-t border-[#E2E8F0] dark:border-white/10">
              <span>Học bộ thủ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </span>
          </Link>

          {/* Card 4: Bài học Ngữ cảnh */}
          <Link href="/lessons" className="edtech-card-interactive p-6 flex flex-col justify-between gap-5 group">
            <div className="space-y-4">
              <div className="w-12 h-12 rounded-2xl bg-amber-50 dark:bg-amber-950/50 border border-amber-200/70 dark:border-amber-800 flex items-center justify-center">
                <BookOpen className="w-6 h-6 text-amber-600 dark:text-amber-400 stroke-[1.75]" />
              </div>
              <div className="space-y-1.5">
                <h3 className="font-serif font-bold text-lg text-[#182238] dark:text-white group-hover:text-amber-600 transition-colors">
                  Bài học Ngữ cảnh
                </h3>
                <p className="text-xs text-[#475569] dark:text-slate-300 font-serif leading-relaxed line-clamp-2">
                  Tuyển tập đoạn văn hội thoại, thành ngữ, ca dao và chủ đề văn hóa ứng dụng.
                </p>
              </div>
            </div>
            <span className="inline-flex items-center justify-between text-xs font-serif font-bold text-amber-700 dark:text-amber-400 pt-3 border-t border-[#E2E8F0] dark:border-white/10">
              <span>Đọc bài học</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </span>
          </Link>
        </div>
      </section>

      {/* 4. KHU VỰC LUYỆN TẬP THỰC CHIẾN (CLEAN 3-COLUMN BENTO GRID) */}
      <section id="luyen-tap" className="space-y-6 scroll-mt-24">
        <div className="border-b border-[#E2E8F0] dark:border-[#384869] pb-4 space-y-1.5">
          <div className="flex items-center gap-2">
            <span className="w-2.5 h-2.5 rounded-full bg-[#0D9488]" />
            <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#182238] dark:text-white">
              Khu vực Luyện tập Thực chiến
            </h2>
          </div>
          <p className="text-xs sm:text-sm text-[#475569] dark:text-slate-300 font-serif">
            Rèn luyện phản xạ thính giác, tư duy chuyển ngữ và ghi nhớ dài hạn qua các không gian luyện tập chuyên biệt.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-5">
          {/* Practice 1: Nghe & Gõ Chữ Hán */}
          <Link href="/typing?practice=visual&mode=listen" className="edtech-card-interactive p-6 flex flex-col justify-between gap-5 group">
            <div className="space-y-4">
              <div className="w-12 h-12 rounded-2xl bg-[#F0FDFA] dark:bg-teal-950/50 border border-[#0D9488]/20 flex items-center justify-center">
                <Headphones className="w-6 h-6 text-[#0D9488] stroke-[1.75]" />
              </div>
              <div className="space-y-1.5">
                <h3 className="font-serif font-bold text-lg sm:text-xl text-[#182238] dark:text-white group-hover:text-[#0D9488] transition-colors">
                  Nghe & Gõ Chữ Hán
                </h3>
                <p className="text-xs sm:text-sm text-[#475569] dark:text-slate-300 font-serif leading-relaxed line-clamp-2">
                  Nghe phát âm chuẩn giọng Bắc Kinh và tự gõ câu chữ Hán với quy trình bảo vệ IME 2 bước.
                </p>
              </div>
            </div>
            <div className="pt-3.5 border-t border-[#E2E8F0] dark:border-white/10 flex items-center justify-between text-xs sm:text-sm font-serif font-bold text-[#0D9488]">
              <span>Bắt đầu Nghe & Gõ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Practice 2: Dịch Việt -> Gõ Hán */}
          <Link href="/typing?practice=translate" className="edtech-card-interactive p-6 flex flex-col justify-between gap-5 group">
            <div className="space-y-4">
              <div className="w-12 h-12 rounded-2xl bg-[#FEF2F2] dark:bg-[#DC2626]/20 border border-[#DC2626]/20 flex items-center justify-center">
                <Languages className="w-6 h-6 text-[#DC2626] stroke-[1.75]" />
              </div>
              <div className="space-y-1.5">
                <h3 className="font-serif font-bold text-lg sm:text-xl text-[#182238] dark:text-white group-hover:text-[#DC2626] transition-colors">
                  Dịch Việt → Gõ Hán
                </h3>
                <p className="text-xs sm:text-sm text-[#475569] dark:text-slate-300 font-serif leading-relaxed line-clamp-2">
                  Đọc nghĩa tiếng Việt và phản xạ gõ sang chữ Hán hoàn chỉnh, tự động lưu lỗi sai để ôn lại.
                </p>
              </div>
            </div>
            <div className="pt-3.5 border-t border-[#E2E8F0] dark:border-white/10 flex items-center justify-between text-xs sm:text-sm font-serif font-bold text-[#DC2626]">
              <span>Bắt đầu Dịch & Gõ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Practice 3: Ôn tập Thẻ nhớ SM-2 */}
          <Link href="/review" className="edtech-card-interactive p-6 flex flex-col justify-between gap-5 group">
            <div className="space-y-4">
              <div className="w-12 h-12 rounded-2xl bg-amber-50 dark:bg-amber-950/50 border border-amber-200/70 dark:border-amber-800 flex items-center justify-center">
                <BrainCircuit className="w-6 h-6 text-amber-600 dark:text-amber-400 stroke-[1.75]" />
              </div>
              <div className="space-y-1.5">
                <h3 className="font-serif font-bold text-lg sm:text-xl text-[#182238] dark:text-white group-hover:text-amber-600 transition-colors">
                  Ôn tập Thẻ nhớ 3D
                </h3>
                <p className="text-xs sm:text-sm text-[#475569] dark:text-slate-300 font-serif leading-relaxed line-clamp-2">
                  Ứng dụng đường cong quên lãng Ebbinghaus với thẻ lật 3D hai mặt và giọng đọc chuẩn.
                </p>
              </div>
            </div>
            <div className="pt-3.5 border-t border-[#E2E8F0] dark:border-white/10 flex items-center justify-between text-xs sm:text-sm font-serif font-bold text-amber-700 dark:text-amber-400">
              <span>Mở phòng ôn thẻ nhớ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>
        </div>
      </section>

      {/* 5. TIẾN TRÌNH HỌC TẬP CÁ NHÂN */}
      <section className="space-y-6">
        <div className="border-b border-[#E2E8F0] dark:border-[#384869] pb-4 space-y-1.5">
          <div className="flex items-center gap-2">
            <span className="w-2.5 h-2.5 rounded-full bg-emerald-600" />
            <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#182238] dark:text-white">
              Tiến trình Học tập Cá nhân
            </h2>
          </div>
          <p className="text-xs sm:text-sm text-[#475569] dark:text-slate-300 font-serif">
            Theo dõi sự tiến bộ từng ngày và tiếp tục ngay tại vị trí bài tập bạn vừa dừng lại.
          </p>
        </div>

        {user ? (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-5">
            <div className="edtech-card p-6 sm:p-7 flex flex-col justify-between space-y-5">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="inline-flex items-center gap-1.5 text-xs font-serif font-bold text-[#0D9488] uppercase tracking-wider">
                    <PlayCircle className="w-4 h-4" />
                    Bài tập gần nhất
                  </span>
                  {recentTyping?.hsk_level && (
                    <span className="px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-[#F0FDFA] text-[#0D9488] border border-[#0D9488]/20">
                      HSK {recentTyping.hsk_level}
                    </span>
                  )}
                </div>

                {recentTyping ? (
                  <div className="space-y-2.5">
                    <h3 className="font-serif font-bold text-base sm:text-lg text-[#182238] dark:text-white line-clamp-1">
                      {recentTyping.lesson_title || (recentTyping.current_question_text ? `Câu: "${recentTyping.current_question_text}"` : `Bài tập: ${recentTyping.exercise_id}`)}
                    </h3>

                    <div className="space-y-1.5 pt-1">
                      <div className="flex items-center justify-between text-xs text-muted font-serif">
                        <span>Đã hoàn thành {recentTyping.completed_sentences}/{recentTyping.total_sentences} câu</span>
                        <span className="font-bold text-[#0D9488]">
                          {Math.round(((recentTyping.completed_sentences || 0) / (recentTyping.total_sentences || 1)) * 100)}%
                        </span>
                      </div>
                      <div className="w-full bg-[#E2E8F0] dark:bg-white/10 h-2 rounded-full overflow-hidden">
                        <div
                          className="h-full bg-[#0D9488] rounded-full transition-all duration-300"
                          style={{
                            width: `${Math.min(100, Math.round(((recentTyping.completed_sentences || 0) / (recentTyping.total_sentences || 1)) * 100))}%`,
                          }}
                        />
                      </div>
                    </div>
                  </div>
                ) : (
                  <div>
                    <h3 className="font-serif font-bold text-base sm:text-lg text-[#182238] dark:text-white">
                      Bắt đầu bài học đầu tiên (HSK 1)
                    </h3>
                    <p className="text-xs text-muted font-serif mt-1 line-clamp-2">
                      Làm quen với các câu chào hỏi và phát âm chuẩn Pinyin cơ bản.
                    </p>
                  </div>
                )}
              </div>

              <div className="pt-4 border-t border-[#E2E8F0] dark:border-white/10">
                <Link
                  href={
                    recentTyping
                      ? `/typing?practice=${recentTyping.practice_mode || (recentTyping.mode === 'translate_hsk' ? 'translate' : 'visual')}${recentTyping.hsk_level ? `&hskLevel=${recentTyping.hsk_level}` : ''}${recentTyping.lesson_id ? `&lessonId=${recentTyping.lesson_id}` : ''}${recentTyping.current_question_id ? `&sentenceId=${recentTyping.current_question_id}` : ''}&resume=1`
                      : '/topics?q=HSK 1'
                  }
                  className="w-full block"
                >
                  <button
                    type="button"
                    className="w-full min-h-[44px] py-2.5 px-4 rounded-xl bg-[#0D9488] hover:bg-[#0F766E] active:translate-y-0.5 text-white text-xs sm:text-sm font-serif font-bold shadow-[0_3px_0_#115E59] flex items-center justify-center gap-2 cursor-pointer transition-all"
                  >
                    <span>
                      {recentTyping
                        ? `Tiếp tục câu ${(recentTyping.current_sentence_index || 0) + 1} ngay`
                        : 'Khám phá bài học HSK 1'}
                    </span>
                    <ArrowRight className="w-4 h-4" />
                  </button>
                </Link>
              </div>
            </div>

            <div className="edtech-card p-6 sm:p-7 flex flex-col justify-between space-y-5">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="inline-flex items-center gap-1.5 text-xs font-serif font-bold text-[#DC2626] uppercase tracking-wider">
                    <RotateCcw className="w-4 h-4" />
                    Cần ôn tập & củng cố
                  </span>
                  {needReviewMistakesCount > 0 && (
                    <span className="px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-[#FEF2F2] text-[#DC2626] border border-[#DC2626]/20">
                      {needReviewMistakesCount} câu cần ôn
                    </span>
                  )}
                </div>

                <div>
                  <h3 className="font-serif font-bold text-base sm:text-lg text-[#182238] dark:text-white">
                    {needReviewMistakesCount > 0
                      ? `Bạn có ${needReviewMistakesCount} câu từng gõ sai đến hạn ôn lại`
                      : 'Hệ thống thẻ nhớ Spaced Repetition (SM-2)'}
                  </h3>
                  <p className="text-xs text-[#475569] dark:text-slate-300 font-serif mt-1.5 leading-relaxed line-clamp-2">
                    {needReviewMistakesCount > 0
                      ? 'Luyện lại các câu sai đúng thời điểm vàng giúp chuyển hóa trí nhớ ngắn hạn thành phản xạ dài hạn.'
                      : 'Ôn tập từ vựng ngắt quãng theo đường cong quên lãng Ebbinghaus giúp khắc sâu mặt chữ Hán.'}
                  </p>
                </div>
              </div>

              <div className="pt-4 border-t border-[#E2E8F0] dark:border-white/10">
                <Link
                  href={needReviewMistakesCount > 0 ? '/typing?tab=mistakes' : '/review'}
                  className="w-full block"
                >
                  <button
                    type="button"
                    className="w-full min-h-[44px] py-2.5 px-4 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] hover:bg-[#F1F5F9] dark:hover:bg-[#283657] border border-[#E2E8F0] dark:border-white/10 text-[#182238] dark:text-white font-serif font-semibold text-xs sm:text-sm flex items-center justify-center gap-2 cursor-pointer transition-all"
                  >
                    <span>
                      {needReviewMistakesCount > 0 ? 'Mở phòng ôn câu sai ngay' : 'Mở kho thẻ nhớ ôn tập'}
                    </span>
                    <ArrowRight className="w-4 h-4 text-[#DC2626]" />
                  </button>
                </Link>
              </div>
            </div>
          </div>
        ) : (
          <div className="edtech-card p-6 sm:p-8 flex flex-col sm:flex-row items-center justify-between gap-6">
            <div className="flex flex-col sm:flex-row items-center sm:items-start gap-4 sm:gap-5 text-center sm:text-left">
              <div className="relative w-16 h-16 sm:w-20 sm:h-20 rounded-2xl overflow-hidden border border-[#E2E8F0] shadow-2xs bg-[#FAF9F6] shrink-0">
                <Image
                  src="/images/panda/panda-welcome.webp"
                  alt=""
                  aria-hidden="true"
                  fill
                  sizes="80px"
                  className="object-cover"
                />
              </div>
              <div className="space-y-1.5">
                <div className="inline-flex items-center gap-2 px-3 py-0.5 rounded-full bg-[#F0FDFA] border border-[#0D9488]/25 text-[#0D9488] text-xs font-serif font-bold">
                  <span className="w-2 h-2 rounded-full bg-[#0D9488] animate-pulse" />
                  <span>Hoàn toàn miễn phí</span>
                </div>
                <h3 className="font-serif font-bold text-lg sm:text-xl text-[#182238] dark:text-white">
                  Lưu lại tiến trình và xây dựng thói quen học mỗi ngày
                </h3>
                <p className="text-xs sm:text-sm text-[#475569] dark:text-slate-300 font-serif max-w-xl leading-relaxed line-clamp-2">
                  Đăng nhập để đồng bộ kết quả luyện gõ, lưu lại câu từng sai vào kho thẻ nhớ SM-2 và theo dõi tỷ lệ từ vựng HSK 3.0 đã thuần thục.
                </p>
              </div>
            </div>

            <div className="shrink-0 w-full sm:w-auto">
              <Link href="/topics?q=HSK 1" className="w-full sm:w-auto block">
                <button
                  type="button"
                  className="w-full sm:w-auto min-h-[48px] py-3 px-6 rounded-xl bg-[#0D9488] hover:bg-[#0F766E] active:translate-y-0.5 text-white font-serif font-bold text-sm shadow-[0_3px_0_#115E59] flex items-center justify-center gap-2 cursor-pointer transition-all"
                >
                  <Keyboard className="w-4 h-4" />
                  <span>Bắt đầu học ngay</span>
                </button>
              </Link>
            </div>
          </div>
        )}
      </section>
    </div>
  )
}
