import { createClient, getCachedAuthUser } from '@/lib/supabase/server'
import FlashcardReviewer from './flashcard-reviewer'
import { BookOpen, Sparkles, BrainCircuit, ArrowRight, GraduationCap, Compass } from 'lucide-react'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { MascotAvatar } from '@/components/mascot/mascot-avatar'

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
      <div className="max-w-4xl mx-auto pb-20 font-serif space-y-6">
        {/* Header */}
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 border-b border-border/80 pb-5">
          <div className="space-y-1.5">
            <div className="flex items-center gap-2.5">
              <span className="p-1.5 rounded-xl bg-app-accent-soft text-app-accent flex-shrink-0">
                <BrainCircuit className="w-5 h-5" />
              </span>
              <div className="flex items-center gap-2">
                <h1 className="text-2xl md:text-3xl font-serif text-title font-bold tracking-tight">
                  Phòng Ôn Tập
                </h1>
                <span className="hidden sm:inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-sans font-medium bg-app-accent-soft text-app-accent border border-app-accent/20">
                  Spaced Repetition
                </span>
              </div>
            </div>
            <p className="text-muted font-serif text-xs md:text-sm pl-0.5 max-w-xl leading-relaxed">
              Trải nghiệm cơ chế Flashcard thông minh. Đăng nhập để thuật toán tự động theo dõi lịch ôn tập ngắt quãng theo từng ngày cho bạn.
            </p>
          </div>

          <div className="shrink-0 flex items-center gap-2">
            <Link href="/login">
              <Button variant="primary" className="font-serif text-xs min-h-[40px] px-4 rounded-xl shadow-xs">
                Đăng nhập để lưu tiến độ
              </Button>
            </Link>
          </div>
        </div>

        {/* Guest Banner */}
        <div className="p-3.5 sm:p-4 rounded-2xl bg-amber-500/10 border border-amber-500/25 flex items-center justify-between gap-3 text-xs font-serif text-amber-900 dark:text-amber-200">
          <div className="flex items-center gap-2.5">
            <Sparkles className="w-4 h-4 text-amber-600 shrink-0" />
            <span>
              Bạn đang ở chế độ xem thử mẫu Flashcard HSK 1. <strong>Đăng nhập</strong> để lưu kho từ vựng cá nhân.
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
    <div className="max-w-4xl mx-auto pb-20 font-serif space-y-8">
      {/* 1. Header khu vực: Phòng Ôn Tập */}
      <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 border-b border-border/80 pb-5">
        <div className="space-y-1.5">
          <div className="flex items-center gap-2.5">
            <span className="p-1.5 rounded-xl bg-app-accent-soft text-app-accent flex-shrink-0">
              <BrainCircuit className="w-5 h-5" />
            </span>
            <div className="flex items-center gap-2">
              <h1 className="text-2xl md:text-3xl font-serif text-title font-bold tracking-tight">
                Phòng Ôn Tập
              </h1>
              <span className="hidden sm:inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-sans font-medium bg-app-accent-soft text-app-accent border border-app-accent/20">
                Spaced Repetition
              </span>
            </div>
          </div>
          <p className="text-muted font-serif text-xs md:text-sm pl-0.5 max-w-xl leading-relaxed">
            Hệ thống lặp lại ngắt quãng thông minh tự động tính toán thời điểm vàng để ôn lại từ vựng trước khi bạn kịp quên.
          </p>
        </div>

        {/* Thống kê nhanh thực tế */}
        <div className="flex items-center gap-2 text-xs font-serif shrink-0">
          <span className="inline-flex items-center gap-1 px-3 py-1.5 rounded-xl bg-card border border-border/80 text-title shadow-2xs">
            <span className="w-2 h-2 rounded-full bg-app-accent" />
            <span>Đến hạn: <strong>{formattedVocabs.length}</strong> từ</span>
          </span>
          <span className="inline-flex items-center gap-1 px-3 py-1.5 rounded-xl bg-card border border-border/80 text-muted shadow-2xs">
            <span>Kho từ: <strong>{totalLearnedCount}</strong></span>
          </span>
        </div>
      </div>

      {/* 2. Nội dung chính: Flashcard Reviewer hoặc Màn hình trống */}
      {formattedVocabs.length > 0 ? (
        <FlashcardReviewer vocabs={formattedVocabs} totalLearnedCount={totalLearnedCount} />
      ) : totalLearnedCount > 0 ? (
        /* Trạng thái 1: Đã hoàn thành hết các từ đến hạn hôm nay */
        <div className="text-center py-16 px-4 rounded-3xl border border-border bg-card shadow-xs max-w-xl mx-auto space-y-5 animate-in fade-in duration-200">
          <div className="flex justify-center">
            <MascotAvatar state="success" size="xl" />
          </div>
          <div className="space-y-2">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-jade-soft text-jade text-xs font-serif font-bold border border-jade/20">
              <Sparkles className="w-3.5 h-3.5" />
              <span>Đã hoàn thành xuất sắc mục tiêu hôm nay!</span>
            </div>
            <h3 className="text-xl md:text-2xl font-serif text-title font-bold">
              Chưa có từ nào đến hạn ôn tiếp
            </h3>
            <p className="text-xs md:text-sm text-muted font-serif max-w-md mx-auto leading-relaxed">
              Toàn bộ <strong>{totalLearnedCount}</strong> từ vựng trong kho nhớ của bạn đang ở trạng thái ghi nhớ tốt. Hãy quay lại vào ngày mai hoặc khám phá thêm bài học mới!
            </p>
          </div>

          <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
            <Link href="/topics?q=HSK 1" className="w-full sm:w-auto">
              <Button className="w-full sm:w-auto font-serif bg-title hover:bg-[#2A3250] text-white rounded-xl text-xs h-10 px-5 gap-2 shadow-xs cursor-pointer">
                <GraduationCap className="w-4 h-4" />
                <span>Học thêm bài HSK mới</span>
              </Button>
            </Link>
            <Link href="/typing" className="w-full sm:w-auto">
              <Button variant="outline" className="w-full sm:w-auto font-serif border-border rounded-xl text-xs h-10 px-5 gap-2 hover:bg-black/5 cursor-pointer">
                <span>Luyện gõ bàn phím IME</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </Button>
            </Link>
          </div>
        </div>
      ) : (
        /* Trạng thái 2: Tài khoản mới chưa lưu từ vựng nào */
        <div className="text-center py-16 px-4 rounded-3xl border border-dashed border-border bg-card/60 max-w-xl mx-auto space-y-5 animate-in fade-in duration-200">
          <div className="flex justify-center">
            <MascotAvatar state="open" size="xl" />
          </div>
          <div className="space-y-2">
            <h3 className="text-xl md:text-2xl font-serif text-title font-bold">
              Kho thẻ ôn tập đang trống
            </h3>
            <p className="text-xs md:text-sm text-muted font-serif max-w-md mx-auto leading-relaxed">
              Khi bạn học từ vựng trong các bài học HSK hoặc chủ đề sưu tầm, các từ sẽ tự động được thêm vào phòng ôn tập theo thuật toán Spaced Repetition.
            </p>
          </div>

          <div className="pt-2 flex justify-center">
            <Link href="/topics?q=HSK 1">
              <Button className="font-serif bg-app-accent hover:bg-accent-hover text-white rounded-xl text-xs h-10 px-6 gap-2 shadow-xs cursor-pointer">
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
