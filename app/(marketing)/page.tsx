import { createClient, getCachedAuthUser, getCachedUserProfile } from '@/lib/supabase/server'
import Link from 'next/link'
import Image from 'next/image'
import { Button } from '@/components/ui/button'
import {
  BookOpen,
  PenTool,
  Component,
  Keyboard,
  ArrowRight,
  Sparkles,
  BrainCircuit,
  FileText,
  ChevronRight,
  Layers,
  Volume2,
  BookmarkCheck,
  Headphones,
  CheckCheck,
  RotateCcw,
  Compass,
  PlayCircle,
  GraduationCap,
  ShieldCheck,
  Library,
  Flame,
  Award
} from 'lucide-react'
import { HSK_LEVELS, getHskAuditData } from '@/data/hsk-curriculum'
import { getCachedSystemLessonCounts, getCachedAllVocabCounts } from '@/lib/curriculum-cache'
import { MascotAvatar } from '@/components/mascot/mascot-avatar'
import { Hero3DSection } from '@/components/home/hero-3d-section'
import { formatNumber } from '@/lib/utils'

export const dynamic = 'force-dynamic'

const HSK_3D_COVERS: Record<number, string> = {
  1: '/images/hsk/hsk-1-village.webp',
  2: '/images/hsk/hsk-2-garden.webp',
  3: '/images/hsk/hsk-3-city.webp',
  4: '/images/hsk/hsk-4-mountain.webp',
  5: '/images/hsk/hsk-5-academy.webp',
  6: '/images/hsk/hsk-6-peak.webp',
  7: '/images/hsk/hsk-7-celestial.webp',
}

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

  // Danh xưng khoa bảng & bảng màu chuẩn hóa từng cấp độ HSK (The Mandarin Lab inspired)
  const getLevelMeta = (levelNum: number) => {
    switch (levelNum) {
      case 1:
        return {
          rankTitle: 'Đồng Sinh (童生)',
          stageName: 'Sơ cấp (初等)',
          accentColor: '#D97706',
          softBg: 'bg-amber-500/10 text-amber-700 dark:text-amber-400 border-amber-500/25',
          barColor: 'bg-amber-500',
          borderColor: 'border-amber-500/40',
        }
      case 2:
        return {
          rankTitle: 'Tú Tài (秀才)',
          stageName: 'Sơ cấp (初等)',
          accentColor: '#0284C7',
          softBg: 'bg-sky-500/10 text-sky-700 dark:text-sky-400 border-sky-500/25',
          barColor: 'bg-sky-500',
          borderColor: 'border-sky-500/40',
        }
      case 3:
        return {
          rankTitle: 'Cử Nhân (举人)',
          stageName: 'Sơ cấp (初等)',
          accentColor: '#EA580C',
          softBg: 'bg-orange-500/10 text-orange-700 dark:text-orange-400 border-orange-500/25',
          barColor: 'bg-orange-500',
          borderColor: 'border-orange-500/40',
        }
      case 4:
        return {
          rankTitle: 'Cống Sĩ (贡士)',
          stageName: 'Trung cấp (中等)',
          accentColor: '#B8322D',
          softBg: 'bg-red-500/10 text-[#B8322D] dark:text-red-400 border-red-500/25',
          barColor: 'bg-[#B8322D]',
          borderColor: 'border-[#B8322D]/40',
        }
      case 5:
        return {
          rankTitle: 'Tiến Sĩ (进士)',
          stageName: 'Trung cấp (中等)',
          accentColor: '#4338CA',
          softBg: 'bg-indigo-500/10 text-indigo-700 dark:text-indigo-400 border-indigo-500/25',
          barColor: 'bg-indigo-600',
          borderColor: 'border-indigo-500/40',
        }
      case 6:
        return {
          rankTitle: 'Thám Hoa (探花)',
          stageName: 'Trung cấp (中等)',
          accentColor: '#7E22CE',
          softBg: 'bg-purple-500/10 text-purple-700 dark:text-purple-400 border-purple-500/25',
          barColor: 'bg-purple-600',
          borderColor: 'border-purple-500/40',
        }
      default:
        return {
          rankTitle: 'Trạng Nguyên (状元)',
          stageName: 'Cao cấp (高等)',
          accentColor: '#047857',
          softBg: 'bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 border-emerald-500/25',
          barColor: 'bg-emerald-600',
          borderColor: 'border-emerald-500/40',
        }
    }
  }

  // URL và tiêu đề bài tập tiếp tục
  const recentExerciseUrl = recentTyping
    ? `/typing?practice=${recentTyping.practice_mode || (recentTyping.mode === 'translate_hsk' ? 'translate' : 'visual')}${recentTyping.hsk_level ? `&hskLevel=${recentTyping.hsk_level}` : ''}${recentTyping.lesson_id ? `&lessonId=${recentTyping.lesson_id}` : ''}${recentTyping.current_question_id ? `&sentenceId=${recentTyping.current_question_id}` : ''}&resume=1`
    : null

  const recentExerciseTitle = recentTyping?.lesson_title || (recentTyping?.current_question_text ? `Câu: ${recentTyping.current_question_text.slice(0, 18)}...` : null)

  return (
    <div className="w-full space-y-12 sm:space-y-16 md:space-y-20 pb-4 sm:pb-8 md:pb-12">

      {/* ================================================================== */}
      {/* 1. HERO SECTION (IMMERSIVE 3D · THE MANDARIN LAB INSPIRED)         */}
      {/* ================================================================== */}
      <Hero3DSection
        displayName={displayName}
        isLoggedIn={!!user}
        recentExerciseTitle={recentExerciseTitle}
        recentExerciseUrl={recentExerciseUrl}
      />

      {/* ================================================================== */}
      {/* SECTION 1: HÀNH TRÌNH HSK 3.0 (7 NẤC THANG KHOA BẢNG)              */}
      {/* ================================================================== */}
      <section id="hanh-trinh-hsk" className="space-y-6 scroll-mt-24">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-3 border-b-2 border-[#182238]/15 dark:border-[#384869] pb-4">
          <div>
            <div className="flex items-center gap-2.5 flex-wrap">
              <span className="w-3 h-3 rounded-full bg-[#B8322D]" />
              <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#182238] dark:text-white">
                Hành trình Chinh phục HSK 3.0
              </h2>
              <span className="px-3 py-1 rounded-full text-xs font-serif font-semibold bg-[#FAF7F2] dark:bg-[#182238] border-2 border-[#182238] dark:border-[#384869] text-[#182238] dark:text-slate-200 shadow-2xs">
                Tiêu chuẩn GF 0025-2021
              </span>
            </div>
            <p className="text-xs sm:text-sm text-[#182238]/70 dark:text-slate-300 font-serif mt-1.5">
              Từ mài mực luyện nét ở Sơ cấp đến tinh thông thành thạo ở Cao cấp — 7 nấc thang khoa bảng rõ ràng, số liệu bài học thực tế.
            </p>
          </div>
        </div>

        {/* Danh sách 7 Nấc thang HSK 3.0 (Tactile Cards) */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-5">
          {([1, 2, 3, 4, 5, 6, 7] as const).map((levelNum) => {
            const info = HSK_LEVELS[levelNum]
            const audit = getHskAuditData(levelNum)
            const meta = getLevelMeta(levelNum)
            const totalLessons = levelLessonCounts[levelNum] || 0
            const learnedVocabs = userVocabsPerLevel[levelNum] || 0
            const targetVocab = info.vocabTarget
            const liveCount = liveVocabCountsRes?.counts?.[info.name]
            const systemVocab = typeof liveCount === 'number' ? liveCount : (audit?.systemVocabCount || 0)
            const isComingSoon = audit?.status === 'coming_soon' || (systemVocab === 0 && totalLessons === 0)

            const percent = user && systemVocab > 0
              ? Math.min(100, Math.round((learnedVocabs / systemVocab) * 100))
              : 0

            let statusLabel = 'Chưa học'
            let statusBadge = 'bg-[#182238]/5 text-muted'
            if (isComingSoon) {
              statusLabel = 'Đang hoàn thiện'
              statusBadge = 'bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/25'
            } else if (user && percent === 100) {
              statusLabel = 'Đã hoàn thành'
              statusBadge = 'bg-emerald-500/10 text-emerald-700 border border-emerald-500/25 font-bold'
            } else if (user && percent > 0) {
              statusLabel = `Đang học (${percent}%)`
              statusBadge = 'bg-amber-500/10 text-amber-700 border border-amber-500/25 font-bold'
            }

            return (
              <Link
                key={levelNum}
                href={`/topics?q=${encodeURIComponent(info.tag)}`}
                className="w-full rounded-[22px] bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group overflow-hidden relative cursor-pointer active:scale-[0.99]"
              >
                {/* Viền màu chặng trên cùng */}
                <div
                  className="h-1 w-full shrink-0"
                  style={{ backgroundColor: meta.accentColor }}
                />

                {/* Banner Image: Tỷ lệ chuẩn 16:9, chiếm trọn chiều ngang, bo góc trên */}
                <div className="relative w-full aspect-[16/9] overflow-hidden bg-[#FAF7F2] dark:bg-[#1F2C47]">
                  <Image
                    src={HSK_3D_COVERS[levelNum] || '/images/hero/hero-3d-landscape.webp'}
                    alt={`Minh họa 3D phong cảnh ${info.title}`}
                    fill
                    sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
                    className="object-cover object-center group-hover:scale-105 transition-transform duration-500 ease-out"
                  />
                  {/* Gradient overlay nhẹ phía dưới để nhãn dễ đọc */}
                  <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/25 to-transparent pointer-events-none" />

                  {/* Badges thông tin trên ảnh: Nhãn HSK bên trái, Trạng thái bên phải */}
                  <div className="absolute bottom-2.5 sm:bottom-3 left-2.5 sm:left-3 right-2.5 sm:right-3 flex items-center justify-between gap-1.5 pointer-events-none">
                    <span className="text-[11px] sm:text-xs font-serif font-bold text-white px-2.5 sm:px-3 py-1 rounded-full bg-black/60 backdrop-blur-md border border-white/20 shadow-xs flex items-center gap-1.5 truncate max-w-[68%]">
                      <span className="w-2 h-2 rounded-full shrink-0" style={{ backgroundColor: meta.accentColor }} />
                      <span className="truncate">{info.name} • {meta.rankTitle}</span>
                    </span>
                    <span className={`text-[10px] sm:text-[11px] font-sans px-2.5 py-0.5 sm:py-1 rounded-full font-bold backdrop-blur-md shadow-xs shrink-0 ${
                      isComingSoon
                        ? 'bg-amber-500/90 text-white'
                        : user && percent === 100
                          ? 'bg-emerald-600/90 text-white'
                          : user && percent > 0
                            ? 'bg-amber-600/90 text-white'
                            : 'bg-black/60 text-white border border-white/20'
                    }`}>
                      {statusLabel}
                    </span>
                  </div>
                </div>

                {/* Content Section: Padding 18-20px (p-4 sm:p-5) */}
                <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between gap-4">
                  <div className="space-y-2.5">
                    {/* Tiêu đề & Thông số thực tế */}
                    <div className="flex items-start justify-between gap-2">
                      <h3 className="font-serif font-bold text-lg sm:text-xl text-title group-hover:text-[#B8322D] transition-colors leading-snug">
                        {info.title}
                      </h3>
                      {levelNum === 7 && (
                        <span className="text-[10px] font-sans font-bold px-2 py-0.5 rounded-full bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20 shrink-0">
                          Cao cấp
                        </span>
                      )}
                    </div>

                    {/* Meta thông số: Số bài học & Kho từ */}
                    <div className="flex items-center gap-2 text-xs text-muted font-serif flex-wrap">
                      <span className="inline-flex items-center gap-1 font-medium text-body">
                        <BookOpen className="w-3.5 h-3.5 text-[#B8322D] shrink-0" />
                        <span><strong>{isComingSoon ? '0' : totalLessons}</strong> bài học</span>
                      </span>
                      <span className="text-muted/40">•</span>
                      <span className="inline-flex items-center gap-1 text-body">
                        <Layers className="w-3.5 h-3.5 text-amber-600 shrink-0" />
                        <span>Kho từ: <strong>{formatNumber(systemVocab || targetVocab)}</strong> từ</span>
                      </span>
                    </div>

                    {/* Mô tả ngắn: line-clamp-2 hoặc 3, không cắt bất thường */}
                    <p className="text-xs sm:text-sm text-muted font-serif leading-relaxed line-clamp-2 sm:line-clamp-3">
                      {info.description}
                    </p>
                  </div>

                  {/* Progress Section: Tách biệt nhẹ nhàng, progress bar 8px, bo tròn 2 đầu */}
                  <div className="pt-3 border-t border-[#182238]/8 dark:border-white/8 space-y-2">
                    <div className="flex items-center justify-between text-xs font-serif">
                      <span className="text-muted text-[11px] sm:text-xs">
                        {isComingSoon ? 'Trạng thái đề cương' : 'Tiến độ từ vựng'}
                      </span>
                      <span className="font-bold text-title text-[11px] sm:text-xs">
                        {isComingSoon
                          ? 'Đang chuẩn hóa GF 0025'
                          : user
                            ? `${formatNumber(learnedVocabs)}/${formatNumber(systemVocab)} (${percent}%)`
                            : `${formatNumber(systemVocab)} từ có sẵn`}
                      </span>
                    </div>

                    <div className="w-full bg-[#182238]/8 dark:bg-white/10 h-2 rounded-full overflow-hidden">
                      <div
                        className="h-full rounded-full transition-all duration-300 ease-out"
                        style={{
                          backgroundColor: meta.accentColor,
                          width: `${isComingSoon ? 0 : user ? percent : 0}%`,
                        }}
                      />
                    </div>

                    {/* CTA Button: Nút vào học ngay chuẩn chạm 44px trên mobile */}
                    <div className="pt-1.5">
                      <div className="w-full min-h-[44px] py-2.5 px-4 rounded-xl bg-[#FAF7F2] dark:bg-[#1F2C47] group-hover:bg-[#B8322D] border border-[#182238]/12 dark:border-white/10 group-hover:border-[#B8322D] text-[#182238] dark:text-white group-hover:text-white text-xs sm:text-sm font-serif font-bold flex items-center justify-between transition-all duration-200 shadow-2xs group-hover:shadow-xs active:translate-y-0.5">
                        <span className="flex items-center gap-1.5">
                          <PlayCircle className="w-4 h-4 text-[#B8322D] group-hover:text-white transition-colors" />
                          <span>{isComingSoon ? 'Xem chi tiết đề cương' : user && percent > 0 ? 'Tiếp tục học ngay' : 'Vào học ngay'}</span>
                        </span>
                        <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                      </div>
                    </div>
                  </div>
                </div>
              </Link>
            )
          })}
        </div>

        {/* Chuyên đề Ứng dụng Thực chiến: Giao tiếp & Công xưởng */}
        <div className="pt-2 space-y-3">
          <div className="flex items-center gap-2">
            <span className="w-2.5 h-2.5 rounded-full bg-amber-600" />
            <h3 className="font-serif font-bold text-lg sm:text-xl text-[#182238] dark:text-white">
              Chuyên đề Ứng dụng Thực tế & Hướng nghiệp
            </h3>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-5">
            {/* Card Giao tiếp */}
            <Link
              href="/topics?q=Giao tiếp"
              className="w-full rounded-[22px] bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group overflow-hidden relative cursor-pointer active:scale-[0.99]"
            >
              <div className="h-1 w-full shrink-0 bg-amber-600" />
              <div className="relative w-full aspect-[16/9] overflow-hidden bg-[#FAF7F2] dark:bg-[#1F2C47]">
                <Image
                  src="/images/hsk/hsk-giao-tiep.webp"
                  alt="Tiếng Trung Giao tiếp Đời sống"
                  fill
                  sizes="(max-width: 768px) 100vw, 50vw"
                  className="object-cover object-center group-hover:scale-105 transition-transform duration-500 ease-out"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/25 to-transparent pointer-events-none" />
                <div className="absolute bottom-2.5 sm:bottom-3 left-2.5 sm:left-3 right-2.5 sm:right-3 flex items-center justify-between gap-1.5 pointer-events-none">
                  <span className="text-[11px] sm:text-xs font-serif font-bold text-white px-2.5 sm:px-3 py-1 rounded-full bg-black/60 backdrop-blur-md border border-white/20 shadow-xs">
                    Đời sống thường nhật • Khẩu ngữ
                  </span>
                  <span className="text-[10px] sm:text-[11px] font-sans px-2.5 py-0.5 sm:py-1 rounded-full font-bold bg-amber-600/90 text-white backdrop-blur-md shadow-xs">
                    Thực chiến
                  </span>
                </div>
              </div>

              <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between gap-4">
                <div className="space-y-2">
                  <h4 className="font-serif font-bold text-lg sm:text-xl text-title group-hover:text-[#B8322D] transition-colors leading-snug">
                    Tiếng Trung Giao tiếp Thực chiến
                  </h4>
                  <p className="text-xs sm:text-sm text-muted font-serif leading-relaxed line-clamp-2 sm:line-clamp-3">
                    Hội thoại khẩu ngữ theo ngữ cảnh du lịch, mua sắm, nhà hàng, kết bạn và đời sống văn hóa hiện đại.
                  </p>
                </div>

                <div className="pt-2 border-t border-[#182238]/8 dark:border-white/8">
                  <div className="w-full min-h-[44px] py-2.5 px-4 rounded-xl bg-[#FAF7F2] dark:bg-[#1F2C47] group-hover:bg-[#B8322D] border border-[#182238]/12 dark:border-white/10 group-hover:border-[#B8322D] text-[#182238] dark:text-white group-hover:text-white text-xs sm:text-sm font-serif font-bold flex items-center justify-between transition-all duration-200 shadow-2xs group-hover:shadow-xs active:translate-y-0.5">
                    <span className="flex items-center gap-1.5">
                      <PlayCircle className="w-4 h-4 text-amber-600 group-hover:text-white transition-colors" />
                      <span>Khám phá chủ đề Giao tiếp</span>
                    </span>
                    <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                  </div>
                </div>
              </div>
            </Link>

            {/* Card Công xưởng */}
            <Link
              href="/topics?q=Công xưởng"
              className="w-full rounded-[22px] bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group overflow-hidden relative cursor-pointer active:scale-[0.99]"
            >
              <div className="h-1 w-full shrink-0 bg-slate-700" />
              <div className="relative w-full aspect-[16/9] overflow-hidden bg-[#FAF7F2] dark:bg-[#1F2C47]">
                <Image
                  src="/images/hsk/hsk-cong-xuong.webp"
                  alt="Tiếng Trung Công xưởng & Nhà máy"
                  fill
                  sizes="(max-width: 768px) 100vw, 50vw"
                  className="object-cover object-center group-hover:scale-105 transition-transform duration-500 ease-out"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/25 to-transparent pointer-events-none" />
                <div className="absolute bottom-2.5 sm:bottom-3 left-2.5 sm:left-3 right-2.5 sm:right-3 flex items-center justify-between gap-1.5 pointer-events-none">
                  <span className="text-[11px] sm:text-xs font-serif font-bold text-white px-2.5 sm:px-3 py-1 rounded-full bg-black/60 backdrop-blur-md border border-white/20 shadow-xs">
                    Chuyên ngành Sản xuất • Kỹ thuật
                  </span>
                  <span className="text-[10px] sm:text-[11px] font-sans px-2.5 py-0.5 sm:py-1 rounded-full font-bold bg-slate-700/90 text-white backdrop-blur-md shadow-xs">
                    Nhà xưởng
                  </span>
                </div>
              </div>

              <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between gap-4">
                <div className="space-y-2">
                  <h4 className="font-serif font-bold text-lg sm:text-xl text-title group-hover:text-[#B8322D] transition-colors leading-snug">
                    Tiếng Trung Công xưởng & Nhà máy
                  </h4>
                  <p className="text-xs sm:text-sm text-muted font-serif leading-relaxed line-clamp-2 sm:line-clamp-3">
                    Từ vựng kỹ nghệ, linh kiện, máy móc thiết bị, an toàn lao động, giao nhận hàng và chỉ huy xưởng.
                  </p>
                </div>

                <div className="pt-2 border-t border-[#182238]/8 dark:border-white/8">
                  <div className="w-full min-h-[44px] py-2.5 px-4 rounded-xl bg-[#FAF7F2] dark:bg-[#1F2C47] group-hover:bg-[#B8322D] border border-[#182238]/12 dark:border-white/10 group-hover:border-[#B8322D] text-[#182238] dark:text-white group-hover:text-white text-xs sm:text-sm font-serif font-bold flex items-center justify-between transition-all duration-200 shadow-2xs group-hover:shadow-xs active:translate-y-0.5">
                    <span className="flex items-center gap-1.5">
                      <PlayCircle className="w-4 h-4 text-slate-600 group-hover:text-white transition-colors" />
                      <span>Khám phá chủ đề Công xưởng</span>
                    </span>
                    <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                  </div>
                </div>
              </div>
            </Link>
          </div>
        </div>
      </section>

      {/* ================================================================== */}
      {/* SECTION 2: KHÁM PHÁ THƯ VIỆN HỌC TẬP                               */}
      {/* ================================================================== */}
      <section id="thu-vien" className="space-y-6 scroll-mt-24">
        <div className="border-b-2 border-[#182238]/15 dark:border-[#384869] pb-4">
          <div className="flex items-center gap-2">
            <span className="w-3 h-3 rounded-full bg-indigo-600" />
            <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#182238] dark:text-white">
              Khám phá Thư viện Tri thức Hán ngữ
            </h2>
          </div>
          <p className="text-xs sm:text-sm text-[#182238]/70 dark:text-slate-300 font-serif mt-1.5">
            Các công cụ tra cứu, ngữ pháp và phát âm nền tảng chuẩn hóa giúp bạn tự tin mở rộng vốn tiếng Trung.
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-5">
          {/* Card 1: Từ vựng HSK 3.0 */}
          <Link
            href="/vocabulary"
            className="w-full rounded-[20px] p-5 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group active:scale-[0.99]"
          >
            <div className="space-y-3">
              <div className="relative w-12 h-12 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-2xs bg-white shrink-0">
                <Image
                  src="/images/library/feature-radicals.webp"
                  alt="Tra từ HSK 3.0"
                  fill
                  sizes="48px"
                  className="object-cover group-hover:scale-110 transition-transform duration-300"
                />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-[#B8322D] transition-colors">
                  Tra từ HSK 3.0
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Hơn 11,000 từ vựng chuẩn hóa, tra cứu Pinyin, nghĩa Hán Việt, phát âm và câu ví dụ ngữ cảnh.
                </p>
              </div>
            </div>
            <div className="pt-3 mt-3 border-t border-[#182238]/8 dark:border-white/8 flex items-center justify-between text-xs font-serif font-bold text-[#B8322D] min-h-[36px]">
              <span>Tra từ vựng</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Card 2: Ngữ pháp hệ thống */}
          <Link
            href="/grammar"
            className="w-full rounded-[20px] p-5 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group active:scale-[0.99]"
          >
            <div className="space-y-3">
              <div className="relative w-12 h-12 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-2xs bg-white shrink-0">
                <Image
                  src="/images/library/feature-grammar.webp"
                  alt="Ngữ pháp Chuyên sâu"
                  fill
                  sizes="48px"
                  className="object-cover group-hover:scale-110 transition-transform duration-300"
                />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-indigo-700 transition-colors">
                  Ngữ pháp Chuyên sâu
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Công thức trực quan, điểm ngữ pháp trọng tâm theo từng cấp độ và ví dụ phân tích song ngữ.
                </p>
              </div>
            </div>
            <div className="pt-3 mt-3 border-t border-[#182238]/8 dark:border-white/8 flex items-center justify-between text-xs font-serif font-bold text-indigo-700 dark:text-indigo-400 min-h-[36px]">
              <span>Xem ngữ pháp</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Card 3: 214 Bộ thủ */}
          <Link
            href="/radicals"
            className="w-full rounded-[20px] p-5 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group active:scale-[0.99]"
          >
            <div className="space-y-3">
              <div className="relative w-12 h-12 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-2xs bg-white shrink-0">
                <Image
                  src="/images/library/feature-radicals.webp"
                  alt="214 Bộ thủ Khang Hy"
                  fill
                  sizes="48px"
                  className="object-cover group-hover:scale-110 transition-transform duration-300"
                />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-emerald-700 transition-colors">
                  214 Bộ thủ Khang Hy
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Gốc rễ chữ Hán qua 17 nhóm nét, tra cứu ý nghĩa bộ thủ và Flashcard nhận diện phản xạ.
                </p>
              </div>
            </div>
            <div className="pt-3 mt-3 border-t border-[#182238]/8 dark:border-white/8 flex items-center justify-between text-xs font-serif font-bold text-emerald-700 dark:text-emerald-400 min-h-[36px]">
              <span>Học 214 bộ thủ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Card 4: Bài học sưu tầm */}
          <Link
            href="/lessons"
            className="w-full rounded-[20px] p-5 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group active:scale-[0.99]"
          >
            <div className="space-y-3">
              <div className="relative w-12 h-12 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-2xs bg-white shrink-0">
                <Image
                  src="/images/panda/panda-studying.webp"
                  alt="Bài học Ngữ cảnh"
                  fill
                  sizes="48px"
                  className="object-cover group-hover:scale-110 transition-transform duration-300"
                />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-sky-700 transition-colors">
                  Bài học Ngữ cảnh
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Tuyển tập đoạn văn hội thoại, thành ngữ, ca dao tục ngữ và chủ đề đời sống văn hóa ứng dụng.
                </p>
              </div>
            </div>
            <div className="pt-3 mt-3 border-t border-[#182238]/8 dark:border-white/8 flex items-center justify-between text-xs font-serif font-bold text-sky-700 dark:text-sky-400 min-h-[36px]">
              <span>Đọc bài học</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>
        </div>
      </section>

      {/* ================================================================== */}
      {/* SECTION 3: KHU VỰC LUYỆN TẬP THỰC CHIẾN                             */}
      {/* ================================================================== */}
      <section id="luyen-tap" className="space-y-6 scroll-mt-24">
        <div className="border-b-2 border-[#182238]/15 dark:border-[#384869] pb-4">
          <div className="flex items-center gap-2">
            <span className="w-3 h-3 rounded-full bg-[#B8322D]" />
            <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#182238] dark:text-white">
              Khu vực Luyện tập Thực chiến
            </h2>
          </div>
          <p className="text-xs sm:text-sm text-[#182238]/70 dark:text-slate-300 font-serif mt-1.5">
            Rèn luyện phản xạ đôi tai, bộ não và đôi tay qua các chế độ luyện gõ phím và ôn tập thẻ nhớ chuyên sâu.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-5">
          {/* Practice 1: Nghe & Gõ */}
          <Link
            href="/typing?practice=visual&mode=listen"
            className="w-full rounded-[22px] p-5 sm:p-6 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group active:scale-[0.99]"
          >
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="relative w-13 h-13 sm:w-14 sm:h-14 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-2xs bg-white shrink-0">
                  <Image
                    src="/images/panda/panda-welcome.webp"
                    alt="Nghe & Gõ Chữ Hán"
                    fill
                    sizes="56px"
                    className="object-cover group-hover:scale-110 transition-transform duration-300"
                  />
                </div>
                <span className="px-2.5 py-1 rounded-full text-[11px] font-sans font-bold bg-indigo-500/10 text-indigo-700 dark:text-indigo-300">
                  Phản xạ Thính giác
                </span>
              </div>

              <div>
                <h3 className="font-serif font-bold text-lg sm:text-xl text-title group-hover:text-[#B8322D] transition-colors leading-snug">
                  Nghe & Gõ Chữ Hán
                </h3>
                <p className="text-xs sm:text-sm text-muted font-serif mt-2 leading-relaxed">
                  Nghe phát âm chuẩn giọng phổ thông và tự gõ câu chữ Hán hoàn chỉnh. Giúp nhận diện ngữ điệu, phân biệt thanh điệu và tăng tốc độ gõ.
                </p>
              </div>

              <div className="space-y-1.5 pt-1 text-xs text-[#182238]/70 dark:text-slate-300 font-serif">
                <div className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-indigo-500" />
                  <span>Âm thanh phát âm tốc độ 1x / 0.8x</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-indigo-500" />
                  <span>Quy trình Enter 2 bước xác nhận</span>
                </div>
              </div>
            </div>

            <div className="pt-4 mt-4 border-t border-[#182238]/8 dark:border-white/8 flex items-center justify-between text-xs sm:text-sm font-serif font-bold text-[#B8322D] min-h-[44px]">
              <span>Bắt đầu Nghe & Gõ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1.5 transition-transform" />
            </div>
          </Link>

          {/* Practice 2: Dịch Việt → Gõ Hán */}
          <Link
            href="/typing?practice=translate"
            className="w-full rounded-[22px] p-5 sm:p-6 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group active:scale-[0.99]"
          >
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="relative w-13 h-13 sm:w-14 sm:h-14 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-2xs bg-white shrink-0">
                  <Image
                    src="/images/library/feature-typing.webp"
                    alt="Dịch Việt sang Chữ Hán"
                    fill
                    sizes="56px"
                    className="object-cover group-hover:scale-110 transition-transform duration-300"
                  />
                </div>
                <span className="px-2.5 py-1 rounded-full text-[11px] font-sans font-bold bg-red-500/10 text-[#B8322D]">
                  Chuyển ngữ Chủ động
                </span>
              </div>

              <div>
                <h3 className="font-serif font-bold text-lg sm:text-xl text-title group-hover:text-[#B8322D] transition-colors leading-snug">
                  Dịch Việt → Gõ Hán
                </h3>
                <p className="text-xs sm:text-sm text-muted font-serif mt-2 leading-relaxed">
                  Đọc ý nghĩa tiếng Việt và tự dịch sang câu chữ Hán. Rèn luyện tư duy đặt câu độc lập, tránh phụ thuộc vào phiên âm có sẵn.
                </p>
              </div>

              <div className="space-y-1.5 pt-1 text-xs text-[#182238]/70 dark:text-slate-300 font-serif">
                <div className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-[#B8322D]" />
                  <span>Bảo vệ bộ gõ Pinyin IME (2-step Enter)</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-[#B8322D]" />
                  <span>Tự động lưu lỗi sai để ôn tập lại</span>
                </div>
              </div>
            </div>

            <div className="pt-4 mt-4 border-t border-[#182238]/8 dark:border-white/8 flex items-center justify-between text-xs sm:text-sm font-serif font-bold text-[#B8322D] min-h-[44px]">
              <span>Bắt đầu Dịch & Gõ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1.5 transition-transform" />
            </div>
          </Link>

          {/* Practice 3: Ôn tập SM-2 */}
          <Link
            href="/review"
            className="w-full rounded-[22px] p-5 sm:p-6 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group active:scale-[0.99]"
          >
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="relative w-13 h-13 sm:w-14 sm:h-14 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-2xs bg-white shrink-0">
                  <Image
                    src="/images/library/feature-sm2.webp"
                    alt="Ôn tập thẻ nhớ SM-2"
                    fill
                    sizes="56px"
                    className="object-cover group-hover:scale-110 transition-transform duration-300"
                  />
                </div>
                <span className="px-2.5 py-1 rounded-full text-[11px] font-sans font-bold bg-amber-500/10 text-amber-700 dark:text-amber-300">
                  Khoa học SM-2
                </span>
              </div>

              <div>
                <h3 className="font-serif font-bold text-lg sm:text-xl text-title group-hover:text-amber-700 transition-colors leading-snug">
                  Ôn tập Thẻ nhớ Flashcard
                </h3>
                <p className="text-xs sm:text-sm text-muted font-serif mt-2 leading-relaxed">
                  Ứng dụng thuật toán lặp lại ngắt quãng SM-2, thẻ lật 3D hai mặt và tự động phân bổ câu hỏi cần ôn theo thời điểm vàng trí nhớ.
                </p>
              </div>

              <div className="space-y-1.5 pt-1 text-xs text-[#182238]/70 dark:text-slate-300 font-serif">
                <div className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-amber-500" />
                  <span>Đường cong quên lãng Ebbinghaus</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-amber-500" />
                  <span>Thẻ lật 3D hai mặt kèm audio phát âm</span>
                </div>
              </div>
            </div>

            <div className="pt-4 mt-4 border-t border-[#182238]/8 dark:border-white/8 flex items-center justify-between text-xs sm:text-sm font-serif font-bold text-amber-700 dark:text-amber-400 min-h-[44px]">
              <span>Mở phòng ôn thẻ nhớ</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1.5 transition-transform" />
            </div>
          </Link>
        </div>
      </section>

      {/* ================================================================== */}
      {/* SECTION 4: HUB TIẾN TRÌNH HỌC TẬP CÁ NHÂN                          */}
      {/* ================================================================== */}
      <section className="space-y-6">
        <div className="border-b-2 border-[#182238]/15 dark:border-[#384869] pb-4">
          <div className="flex items-center gap-2">
            <span className="w-3 h-3 rounded-full bg-emerald-600" />
            <h2 className="text-xl sm:text-2xl md:text-3xl font-serif font-bold text-[#182238] dark:text-white">
              Tiến trình Học tập Cá nhân
            </h2>
          </div>
          <p className="text-xs sm:text-sm text-[#182238]/70 dark:text-slate-300 font-serif mt-1.5">
            Theo dõi sự tiến bộ từng ngày, lưu lại dấu chân học vấn và không bao giờ bỏ sót bài học.
          </p>
        </div>

        {user ? (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-5">
            {/* Card 1: Smart Resume */}
            <div className="w-full rounded-[22px] p-5 sm:p-6 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all flex flex-col justify-between space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="inline-flex items-center gap-1.5 text-xs font-serif font-bold text-[#B8322D] uppercase tracking-wider">
                    <PlayCircle className="w-4 h-4" />
                    Bài tập gần nhất
                  </span>
                  {recentTyping?.hsk_level && (
                    <span className="px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-[#B8322D]/10 text-[#B8322D]">
                      HSK {recentTyping.hsk_level}
                    </span>
                  )}
                </div>

                {recentTyping ? (
                  <div className="space-y-2">
                    <h3 className="font-serif font-bold text-base sm:text-lg text-title line-clamp-1">
                      {recentTyping.lesson_title || (recentTyping.current_question_text ? `Câu: "${recentTyping.current_question_text}"` : `Bài tập: ${recentTyping.exercise_id}`)}
                    </h3>

                    {/* Thanh tiến độ phần trăm câu */}
                    <div className="space-y-1.5 pt-1">
                      <div className="flex items-center justify-between text-xs text-muted font-serif">
                        <span>Đã hoàn thành {recentTyping.completed_sentences}/{recentTyping.total_sentences} câu</span>
                        <span className="font-bold text-[#B8322D]">
                          {Math.round(((recentTyping.completed_sentences || 0) / (recentTyping.total_sentences || 1)) * 100)}%
                        </span>
                      </div>
                      <div className="w-full bg-[#182238]/10 dark:bg-white/10 h-2.5 rounded-full overflow-hidden">
                        <div
                          className="h-full bg-[#B8322D] rounded-full transition-all duration-300"
                          style={{
                            width: `${Math.min(100, Math.round(((recentTyping.completed_sentences || 0) / (recentTyping.total_sentences || 1)) * 100))}%`,
                          }}
                        />
                      </div>
                    </div>
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

              <div className="pt-4 border-t border-[#182238]/8 dark:border-white/8">
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
                    className="w-full min-h-[44px] py-2.5 px-4 rounded-xl bg-[#B8322D] hover:bg-[#9E2A25] active:translate-y-0.5 text-white text-xs sm:text-sm font-serif font-bold shadow-xs flex items-center justify-center gap-2 cursor-pointer transition-all"
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

            {/* Card 2: Cần ôn tập câu sai (SM-2) */}
            <div className="w-full rounded-[22px] p-5 sm:p-6 bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all flex flex-col justify-between space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="inline-flex items-center gap-1.5 text-xs font-serif font-bold text-amber-700 dark:text-amber-400 uppercase tracking-wider">
                    <RotateCcw className="w-4 h-4" />
                    Cần ôn tập & củng cố
                  </span>
                  {needReviewMistakesCount > 0 && (
                    <span className="px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-amber-500/15 text-amber-700 dark:text-amber-400 border border-amber-500/25">
                      {needReviewMistakesCount} câu cần ôn
                    </span>
                  )}
                </div>

                <div>
                  <h3 className="font-serif font-bold text-base sm:text-lg text-title">
                    {needReviewMistakesCount > 0
                      ? `Bạn có ${needReviewMistakesCount} câu từng gõ sai đến hạn ôn lại`
                      : 'Hệ thống thẻ nhớ Spaced Repetition (SM-2)'}
                  </h3>
                  <p className="text-xs text-muted font-serif mt-1.5 leading-relaxed">
                    {needReviewMistakesCount > 0
                      ? 'Luyện lại các câu sai đúng thời điểm vàng giúp chuyển hóa trí nhớ ngắn hạn thành phản xạ dài hạn.'
                      : 'Ôn tập từ vựng ngắt quãng theo đường cong quên lãng Ebbinghaus giúp khắc sâu mặt chữ Hán.'}
                  </p>
                </div>
              </div>

              <div className="pt-4 border-t border-[#182238]/8 dark:border-white/8">
                <Link
                  href={needReviewMistakesCount > 0 ? '/typing?tab=mistakes' : '/review'}
                  className="w-full block"
                >
                  <button
                    type="button"
                    className="w-full min-h-[44px] py-2.5 px-4 rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] hover:bg-[#FAF0E6] dark:hover:bg-[#283657] border border-[#182238]/15 dark:border-white/10 text-[#182238] dark:text-white font-serif font-semibold text-xs sm:text-sm shadow-2xs active:translate-y-0.5 flex items-center justify-center gap-2 cursor-pointer transition-all"
                  >
                    <span>
                      {needReviewMistakesCount > 0 ? 'Mở phòng ôn câu sai ngay' : 'Mở kho thẻ nhớ ôn tập'}
                    </span>
                    <ArrowRight className="w-4 h-4 text-[#B8322D]" />
                  </button>
                </Link>
              </div>
            </div>
          </div>
        ) : (
          /* Khách chưa đăng nhập */
          <div className="w-full rounded-[22px] p-5 sm:p-7 bg-gradient-to-r from-[#FAF7F2] via-white to-[#FFF9F3] dark:from-[#182238] dark:to-[#202B45] border border-[#182238]/12 dark:border-white/10 shadow-xs flex flex-col sm:flex-row items-center justify-between gap-6">
            <div className="flex flex-col sm:flex-row items-center sm:items-start gap-4 sm:gap-5 text-center sm:text-left">
              <div className="relative w-16 h-16 sm:w-20 sm:h-20 rounded-2xl overflow-hidden border border-[#182238]/15 shadow-2xs bg-white shrink-0">
                <Image
                  src="/images/panda/panda-welcome.webp"
                  alt="Tiểu Bút chào đón học viên"
                  fill
                  sizes="80px"
                  className="object-cover"
                />
              </div>
              <div className="space-y-1.5">
                <div className="inline-flex items-center gap-2 px-3 py-0.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-800 dark:text-emerald-300 text-xs font-serif font-bold">
                  <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
                  <span>Hoàn toàn miễn phí • Học cùng Tiểu Bút 🐼</span>
                </div>
                <h3 className="font-serif font-bold text-lg sm:text-xl text-[#182238] dark:text-white">
                  Lưu lại tiến trình và xây dựng thói quen học mỗi ngày
                </h3>
                <p className="text-xs sm:text-sm text-muted font-serif max-w-xl leading-relaxed">
                  Đăng nhập để đồng bộ kết quả luyện gõ, lưu lại các câu từng sai vào kho thẻ nhớ SM-2 và theo dõi tỷ lệ từ vựng HSK 3.0 đã thuần thục.
                </p>
              </div>
            </div>

            <div className="shrink-0 flex flex-col sm:flex-row gap-3 w-full sm:w-auto">
              <Link href="/topics?q=HSK 1" className="w-full sm:w-auto">
                <button
                  type="button"
                  className="w-full sm:w-auto min-h-[44px] py-2.5 px-6 rounded-xl bg-[#B8322D] hover:bg-[#9E2A25] active:translate-y-0.5 text-white font-serif font-bold text-xs sm:text-sm shadow-xs flex items-center justify-center gap-2 cursor-pointer transition-all"
                >
                  <Sparkles className="w-4 h-4" />
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

