import { createClient, getCachedAuthUser } from '@/lib/supabase/server'
import FlashcardReviewer from './flashcard-reviewer'
import { BookOpen, CheckCircle2, BrainCircuit, ArrowRight, GraduationCap, Compass, Sparkles, Layers } from 'lucide-react'
import Link from 'next/link'
import Image from 'next/image'
import { Button } from '@/components/ui/button'

export const dynamic = 'force-dynamic'

export default async function ReviewPage() {
  const supabase = await createClient()
  const user = await getCachedAuthUser()

  if (!user) {
    // Chế độ xem thử mẫu từ vựng HSK 1 cho khách chưa đăng nhập
    const { data: sampleVocabs } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi')
      .eq('hsk_level', 'HSK 1')
      .limit(6)

    const formattedSample = (sampleVocabs || []).map((v) => ({
      id: v.id,
      hanzi: v.hanzi || '',
      pinyin: v.pinyin || '',
      meaning_vi: v.meaning_vi || '',
      hsk_level: v.hsk_level || 'HSK 1',
      example_hanzi: v.example_hanzi || '',
      example_pinyin: v.example_pinyin || '',
      example_vi: v.example_vi || '',
      review_interval_days: 1,
      ease_factor: 2.5,
    }))

    return (
      <div className="w-full max-w-[1500px] mx-auto pb-16 font-serif space-y-6">
        {/* Header Hero Box */}
        <div className="relative overflow-hidden rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] p-5 sm:p-7 md:p-8 shadow-xs hover:shadow-md">
          {/* Top accent bar */}
          <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-[#182238] via-[#B8322D] to-[#F59E0B]" />

          {/* Watermark thư pháp mờ */}
          <div className="absolute -right-4 -bottom-6 select-none pointer-events-none opacity-[0.05] dark:opacity-[0.08] font-hanzi text-8xl md:text-9xl font-bold text-[#182238] dark:text-white">
            复习
          </div>

          <div className="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-5">
            <div className="flex items-center gap-4 sm:gap-5 max-w-xl">
              <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs shrink-0 relative bg-[#FFF9F3]">
                <Image
                  src="/images/library/feature-sm2.webp"
                  alt="Ôn tập ngắt quãng SM-2 3D"
                  fill
                  className="object-cover"
                  sizes="96px"
                  priority
                />
              </div>
              <div className="space-y-1.5">
                <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold tracking-wide uppercase bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30">
                  <BrainCircuit className="w-3.5 h-3.5" />
                  <span>Khoa Học Trí Nhớ • Spaced Repetition (SM-2)</span>
                </div>

                <h1 className="text-2xl sm:text-3xl md:text-4xl font-serif text-[#182238] dark:text-white font-bold tracking-tight">
                  Phòng Ôn Tập Có Bạn Đồng Hành
                </h1>
                <p className="text-muted font-serif text-xs md:text-sm leading-relaxed">
                  Trải nghiệm học từ vựng cùng Tiểu Bút 🐼. Đăng nhập để thuật toán SM-2 tự động theo dõi lịch ôn tập ngắt quãng theo từng ngày cho bạn.
                </p>
              </div>
            </div>

            <div className="shrink-0 flex items-center gap-2">
              <Link href="/login">
                <Button className="font-serif text-xs sm:text-sm min-h-[44px] px-5 rounded-2xl bg-[#B8322D] hover:bg-[#9E2A25] text-white shadow-xs border border-[#B8322D]/30 cursor-pointer active:scale-[0.98]">
                  Đăng nhập để lưu tiến độ
                </Button>
              </Link>
            </div>
          </div>
        </div>

        {/* Guest Banner */}
        <div className="p-3.5 sm:p-4 rounded-[20px] bg-amber-500/10 border border-amber-500/25 flex items-center justify-between gap-3 text-xs font-serif text-amber-900 dark:text-amber-200">
          <div className="flex items-center gap-2.5">
            <Sparkles className="w-4 h-4 text-amber-600 shrink-0" />
            <span>
              Bạn đang ở chế độ xem thử mẫu Flashcard HSK 1 với <strong>Tiểu Bút 🐼</strong>. Đăng nhập để lưu kho từ vựng cá nhân.
            </span>
          </div>
          <Link href="/login" className="shrink-0 font-bold underline hover:text-amber-700">
            Đăng nhập ngay
          </Link>
        </div>

        {/* Flashcard Reviewer với danh sách mẫu */}
        {formattedSample.length > 0 ? (
          <FlashcardReviewer vocabs={formattedSample} totalLearnedCount={formattedSample.length} isGuestMode={true} />
        ) : (
          <div className="text-center py-12 px-4 rounded-3xl border border-border bg-card">
            <p className="text-sm text-muted font-serif">Đang tải thẻ mẫu...</p>
          </div>
        )}
      </div>
    )
  }

  // Tải danh sách từ vựng đến hạn ôn tập (next_review_at <= now) và tổng số từ đã lưu
  const now = new Date().toISOString()
  
  const [reviewsRes, totalLearnedRes] = await Promise.all([
    supabase
      .from('user_vocabularies')
      .select('id, review_interval_days, ease_factor, vocabularies(hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)')
      .eq('user_id', user.id)
      .lte('next_review_at', now)
      .order('next_review_at', { ascending: true })
      .limit(100),
    supabase
      .from('user_vocabularies')
      .select('id', { count: 'exact', head: true })
      .eq('user_id', user.id),
  ])

  // Chuẩn hóa định dạng dữ liệu
  const formattedVocabs = reviewsRes.data?.map((r: unknown) => {
    const item = r as { 
      id: string
      review_interval_days?: number
      ease_factor?: number
      vocabularies: { 
        hanzi: string
        pinyin: string
        meaning_vi: string
        hsk_level?: string
        example_hanzi?: string
        example_pinyin?: string
        example_vi?: string 
      } | { 
        hanzi: string
        pinyin: string
        meaning_vi: string
        hsk_level?: string
        example_hanzi?: string
        example_pinyin?: string
        example_vi?: string 
      }[] 
    }
    const vocab = Array.isArray(item.vocabularies) ? item.vocabularies[0] : item.vocabularies
    return {
      id: item.id,
      hanzi: vocab?.hanzi || '',
      pinyin: vocab?.pinyin || '',
      meaning_vi: vocab?.meaning_vi || '',
      hsk_level: vocab?.hsk_level || '',
      example_hanzi: vocab?.example_hanzi || '',
      example_pinyin: vocab?.example_pinyin || '',
      example_vi: vocab?.example_vi || '',
      review_interval_days: item.review_interval_days ?? 0,
      ease_factor: item.ease_factor ?? 2.5,
    }
  }) || []

  const totalLearnedCount = totalLearnedRes.count || 0

  return (
    <div className="w-full max-w-[1500px] mx-auto pb-16 font-serif space-y-6 sm:space-y-8">
      {/* 1. Header khu vực: Studio Ôn Tập SM-2 */}
      <div className="relative overflow-hidden rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] p-5 sm:p-7 md:p-8 shadow-xs hover:shadow-md">
        {/* Top accent bar */}
        <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-[#182238] via-[#B8322D] to-[#F59E0B]" />

        {/* Watermark */}
        <div className="absolute -right-4 -bottom-6 select-none pointer-events-none opacity-[0.05] dark:opacity-[0.08] font-hanzi text-8xl md:text-9xl font-bold text-[#182238] dark:text-white">
          复习
        </div>

        <div className="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-5">
          <div className="flex items-center gap-4 sm:gap-5 max-w-xl">
            <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs shrink-0 relative bg-[#FFF9F3]">
              <Image
                src="/images/library/feature-sm2.webp"
                alt="Ôn tập ngắt quãng SM-2 3D"
                fill
                className="object-cover"
                sizes="96px"
                priority
              />
            </div>
            <div className="space-y-1.5">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold tracking-wide uppercase bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30">
                <BrainCircuit className="w-3.5 h-3.5" />
                <span>Khoa Học Trí Nhớ • Spaced Repetition (SM-2)</span>
              </div>

              <h1 className="text-2xl sm:text-3xl md:text-4xl font-serif text-[#182238] dark:text-white font-bold tracking-tight">
                Phòng Ôn Tập Có Bạn Đồng Hành
              </h1>
              <p className="text-muted font-serif text-xs md:text-sm leading-relaxed">
                Hệ thống lặp lại ngắt quãng thông minh cùng <strong>Tiểu Bút 🐼</strong> tự động tính toán thời điểm vàng để ôn lại từ vựng trước khi bạn kịp quên.
              </p>
            </div>
          </div>

          {/* Thống kê nhanh thực tế */}
          <div className="flex items-center gap-2.5 text-xs font-serif shrink-0">
            <span className="inline-flex items-center gap-2 px-3.5 py-2 rounded-2xl bg-[#FFF9F3] dark:bg-[#141A23] border border-[#182238]/15 dark:border-slate-700 text-[#182238] dark:text-white font-bold shadow-xs">
              <span className="w-2.5 h-2.5 rounded-full bg-[#B8322D] animate-pulse" />
              <span>Đến hạn: <strong>{formattedVocabs.length}</strong> từ</span>
            </span>
            <span className="inline-flex items-center gap-2 px-3.5 py-2 rounded-2xl bg-[#FAF7F2] dark:bg-[#141A23] border border-[#182238]/15 dark:border-slate-700 text-[#182238] dark:text-white font-bold shadow-xs">
              <span>Kho từ: <strong>{totalLearnedCount}</strong></span>
            </span>
          </div>
        </div>
      </div>

      {/* 2. Nội dung chính: Flashcard Reviewer hoặc Màn hình trống */}
      {formattedVocabs.length > 0 ? (
        <FlashcardReviewer vocabs={formattedVocabs} totalLearnedCount={totalLearnedCount} />
      ) : totalLearnedCount > 0 ? (
        /* Trạng thái 1: Đã hoàn thành hết các từ đến hạn hôm nay */
        <div className="text-center py-12 px-6 rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] shadow-xs hover:shadow-md max-w-xl mx-auto space-y-5 animate-in fade-in duration-300">
          <div className="relative w-36 h-36 mx-auto rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs bg-[#FFF9F3] mascot-animated">
            <Image
              src="/images/empty-states/empty-review.webp"
              alt="Tách trà thiền thảnh thơi"
              fill
              sizes="144px"
              className="object-cover"
            />
          </div>
          <div className="space-y-2">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-800 dark:text-emerald-300 text-xs font-serif font-bold border border-emerald-500/20">
              <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600" />
              <span>Thảnh thơi thưởng trà • Hoàn thành xuất sắc mục tiêu hôm nay!</span>
            </div>
            <h3 className="text-xl md:text-2xl font-serif text-[#182238] dark:text-white font-bold">
              Chưa có từ nào đến hạn ôn tiếp
            </h3>
            <p className="text-xs md:text-sm text-muted font-serif max-w-md mx-auto leading-relaxed">
              Toàn bộ <strong>{totalLearnedCount}</strong> từ vựng trong kho nhớ của bạn đang ở trạng thái ghi nhớ tốt. Hãy quay lại vào ngày mai hoặc cùng Tiểu Bút khám phá thêm bài học mới!
            </p>
          </div>

          <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
            <Link href="/topics?q=HSK 1" className="w-full sm:w-auto">
              <Button className="w-full sm:w-auto font-serif bg-[#182238] hover:bg-[#2A3250] text-white rounded-2xl text-xs sm:text-sm h-12 px-6 gap-2 border border-[#182238]/20 shadow-xs cursor-pointer active:scale-[0.98]">
                <GraduationCap className="w-4 h-4" />
                <span>Học thêm bài HSK mới</span>
              </Button>
            </Link>
            <Link href="/typing" className="w-full sm:w-auto">
              <Button variant="outline" className="w-full sm:w-auto font-serif border border-[#182238]/20 rounded-2xl text-xs sm:text-sm h-12 px-6 gap-2 hover:bg-black/5 cursor-pointer shadow-xs active:scale-[0.98]">
                <span>Luyện gõ bàn phím IME</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </Button>
            </Link>
          </div>
        </div>
      ) : (
        /* Trạng thái 2: Tài khoản mới chưa lưu từ vựng nào */
        <div className="text-center py-12 px-6 rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] shadow-xs hover:shadow-md max-w-xl mx-auto space-y-5 animate-in fade-in duration-300">
          <div className="relative w-36 h-36 mx-auto rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs bg-[#FFF9F3] mascot-animated">
            <Image
              src="/images/panda/panda-studying.webp"
              alt="Tiểu Bút đang mài mực chuẩn bị học tập"
              fill
              sizes="144px"
              className="object-cover"
            />
          </div>
          <div className="space-y-2">
            <h3 className="text-xl md:text-2xl font-serif text-[#182238] dark:text-white font-bold">
              Kho thẻ ôn tập đang trống
            </h3>
            <p className="text-xs md:text-sm text-muted font-serif max-w-md mx-auto leading-relaxed">
              Khi bạn học từ vựng trong các bài học HSK hoặc chủ đề, các từ sẽ tự động được thêm vào phòng ôn tập theo thuật toán Spaced Repetition cùng Tiểu Bút.
            </p>
          </div>

          <div className="pt-2 flex justify-center">
            <Link href="/topics?q=HSK 1">
              <Button className="font-serif bg-[#B8322D] hover:bg-[#9E2A25] text-white rounded-2xl text-xs sm:text-sm h-12 px-6 gap-2 border border-[#B8322D]/30 shadow-xs cursor-pointer active:scale-[0.98]">
                <Compass className="w-4 h-4" />
                <span>Bắt đầu bài học đầu tiên (HSK 1)</span>
              </Button>
            </Link>
          </div>
        </div>
      )}
    </div>
  )
}
