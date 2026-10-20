import { createClient } from '@/lib/supabase/server'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { 
  BookOpen, 
  PenTool, 
  BrainCircuit, 
  PlusCircle, 
  Component, 
  Keyboard, 
  ArrowRight, 
  CheckCircle2, 
  Flame, 
  Sparkles,
  Award
} from 'lucide-react'
import { HSK_LEVELS } from '@/data/hsk-curriculum'

export const dynamic = 'force-dynamic'

export default async function HomePage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  let displayName = 'Học viên'
  let savedVocabCount = 0
  let memorizedVocabCount = 0
  let lessonCount = 0
  let reviewWords: { hanzi: string; pinyin: string; vi: string }[] = []
  const userVocabsPerLevel: Record<number, number> = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0 }

  // 1. Fetch system lessons count per HSK level from database
  const { data: systemLessons } = await supabase
    .from('lessons')
    .select('id, hsk_level')
    .eq('is_system', true)

  const levelLessonCounts: Record<number, number> = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0 }
  systemLessons?.forEach((l) => {
    const match = l.hsk_level?.match(/HSK (\d)/)
    if (match) {
      const lvl = parseInt(match[1])
      if (lvl >= 1 && lvl <= 6) {
        levelLessonCounts[lvl] = (levelLessonCounts[lvl] || 0) + 1
      }
    }
  })

  // 2. If logged in, fetch user data & vocabulary counts
  if (user) {
    const { data: profile } = await supabase
      .from('profiles')
      .select('display_name')
      .eq('id', user.id)
      .maybeSingle()

    displayName = profile?.display_name || user?.user_metadata?.full_name || user?.email?.split('@')[0] || 'Học viên'

    const [
      { count: savedCount },
      { count: memorizedCount },
      { count: lessonsCreated },
      { data: reviewWordsData },
      { data: userVocabsData }
    ] = await Promise.all([
      supabase.from('user_vocabularies').select('*', { count: 'exact', head: true }).eq('user_id', user.id),
      supabase.from('user_vocabularies').select('*', { count: 'exact', head: true }).eq('user_id', user.id).gte('review_interval_days', 21),
      supabase.from('lessons').select('*', { count: 'exact', head: true }).eq('user_id', user.id),
      supabase.from('user_vocabularies').select('id, vocabularies(hanzi, pinyin, meaning_vi)').eq('user_id', user.id).lte('next_review_at', new Date().toISOString()).limit(4),
      supabase.from('user_vocabularies').select('id, vocabularies!inner(hsk_level)').eq('user_id', user.id)
    ])

    savedVocabCount = savedCount || 0
    memorizedVocabCount = memorizedCount || 0
    lessonCount = lessonsCreated || 0

    reviewWords = reviewWordsData?.map((r: unknown) => {
      const item = r as { vocabularies: { hanzi: string; pinyin: string; meaning_vi: string } | { hanzi: string; pinyin: string; meaning_vi: string }[] }
      const vocab = Array.isArray(item.vocabularies) ? item.vocabularies[0] : item.vocabularies
      return {
        hanzi: vocab?.hanzi || '',
        pinyin: vocab?.pinyin || '',
        vi: vocab?.meaning_vi || ''
      }
    }) || []

    userVocabsData?.forEach((uv: unknown) => {
      const item = uv as { vocabularies: { hsk_level?: string } | { hsk_level?: string }[] }
      const v = Array.isArray(item.vocabularies) ? item.vocabularies[0] : item.vocabularies
      const match = v?.hsk_level?.match(/HSK (\d)/)
      if (match) {
        const lvl = parseInt(match[1])
        if (lvl >= 1 && lvl <= 6) {
          userVocabsPerLevel[lvl] = (userVocabsPerLevel[lvl] || 0) + 1
        }
      }
    })
  }

  return (
    <div className="max-w-6xl mx-auto space-y-10 pb-16">
      
      {/* Banner chào mừng nếu chưa đăng nhập */}
      {!user && (
        <div className="relative overflow-hidden rounded-2xl border border-app-accent/20 bg-gradient-to-br from-card via-page to-card p-6 md:p-10 shadow-sm">
          <div className="absolute -top-12 -right-12 w-48 h-48 bg-app-accent/10 rounded-full blur-3xl pointer-events-none" />
          <div className="max-w-3xl space-y-4 relative z-10">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-app-accent-soft text-app-accent text-xs font-serif font-medium border border-app-accent/30">
              <Sparkles className="w-3.5 h-3.5" />
              <span>Nền tảng học tiếng Trung toàn diện</span>
            </div>
            <h1 className="text-3xl md:text-4xl font-serif font-bold text-title tracking-tight leading-tight">
              Chinh phục HSK & Hán tự từ cơ bản đến chuyên sâu
            </h1>
            <p className="text-muted font-serif text-sm md:text-base leading-relaxed">
              Lộ trình 6 cấp độ HSK chuẩn hóa với hơn 350 bài học, tra cứu 214 bộ thủ Khang Hy, luyện gõ Pinyin thực tế và công nghệ lặp lại ngắt quãng Spaced Repetition.
            </p>
            <div className="pt-2 flex flex-wrap gap-3">
              <Link href="/login">
                <Button className="font-serif bg-title hover:bg-[#2A3250] text-white px-6 rounded-xl shadow-xs">
                  Đăng nhập để lưu tiến độ
                </Button>
              </Link>
              <Link href="/register">
                <Button variant="outline" className="font-serif px-6 rounded-xl border-border hover:bg-black/5 text-title">
                  Tạo tài khoản miễn phí
                </Button>
              </Link>
            </div>
          </div>
        </div>
      )}

      {/* Header trạng thái người dùng (khi đã đăng nhập) */}
      {user && (
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 border-b border-border/80 pb-6">
          <div className="space-y-1">
            <div className="flex items-center gap-2">
              <span className="text-sm font-serif text-muted">Xin chào,</span>
              <span className="text-xl md:text-2xl font-serif font-bold text-title">{displayName}</span>
              <span className="inline-block animate-pulse text-amber-500">✨</span>
            </div>
            <p className="text-xs md:text-sm text-muted font-serif">
              Hôm nay bạn muốn tiếp tục luyện tập cấp độ HSK nào?
            </p>
          </div>
          <div className="flex items-center gap-2">
            <Link href="/profile">
              <Button variant="outline" size="sm" className="font-serif rounded-xl border-border text-xs gap-1.5 hover:border-app-accent/40">
                <Award className="w-4 h-4 text-gold" />
                <span>Xem hồ sơ & tiến độ</span>
              </Button>
            </Link>
            <Link href="/review">
              <Button size="sm" className="font-serif bg-app-accent hover:bg-accent-hover text-white rounded-xl text-xs gap-1.5 shadow-2xs">
                <Flame className="w-4 h-4" />
                <span>Ôn tập ngay</span>
              </Button>
            </Link>
          </div>
        </div>
      )}



      {/* KHU VỰC TRỌNG TÂM: LỘ TRÌNH 6 CẤP ĐỘ HSK */}
      <section className="space-y-5">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-2 border-b-2 border-app-accent/30 pb-3">
          <div>
            <div className="flex items-center gap-2">
              <span className="w-2.5 h-2.5 rounded-full bg-app-accent"></span>
              <h2 className="text-xl md:text-2xl font-serif font-bold text-title">
                Lộ trình học theo cấp độ HSK
              </h2>
            </div>
            <p className="text-xs md:text-sm text-muted font-serif mt-1">
              Chương trình chuẩn hóa từ HSK 1 đến HSK 6 với giáo trình và hệ thống từ vựng đầy đủ
            </p>
          </div>
          <div className="text-xs text-muted font-serif hidden sm:block">
            Nhấp vào từng cấp độ để xem danh sách bài học
          </div>
        </div>

        {/* Grid 6 Thẻ HSK */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {([1, 2, 3, 4, 5, 6] as const).map((levelNum) => {
            const info = HSK_LEVELS[levelNum]
            const totalLessons = levelLessonCounts[levelNum] || 0
            const learnedVocabs = userVocabsPerLevel[levelNum] || 0
            const targetVocab = info.vocabTarget
            const percent = user ? Math.min(100, Math.round((learnedVocabs / targetVocab) * 100)) : 0

            return (
              <Link 
                key={levelNum} 
                href={`/hsk/${levelNum}`}
                className="group relative flex flex-col justify-between p-5 rounded-2xl border border-border bg-card hover:border-app-accent/50 hover:shadow-md transition-all duration-200 overflow-hidden"
              >
                {/* Viền màu nhỏ phía trên thẻ */}
                <div className={`absolute top-0 left-0 right-0 h-1 bg-gradient-to-r ${info.color.progressFrom} ${info.color.progressTo}`} />

                <div className="space-y-3">
                  {/* Cấp độ Badge & Tag giai đoạn */}
                  <div className="flex items-center justify-between">
                    <span className={`px-2.5 py-1 rounded-lg text-xs font-serif font-bold ${info.color.badgeBg}`}>
                      {info.name}
                    </span>
                    <span className="text-xs font-serif text-muted">
                      {info.stage}
                    </span>
                  </div>

                  {/* Tiêu đề & Thông số */}
                  <div>
                    <h3 className="font-serif font-bold text-lg text-title group-hover:text-app-accent transition-colors">
                      {info.title}
                    </h3>
                    <div className="flex items-center gap-3 text-xs text-muted font-serif mt-1">
                      <span className="flex items-center gap-1">
                        <BookOpen className="w-3.5 h-3.5 text-app-accent" />
                        <strong>{totalLessons}</strong> bài học
                      </span>
                      <span>•</span>
                      <span>Mục tiêu: <strong>{targetVocab}</strong> từ</span>
                    </div>
                  </div>

                  {/* Mô tả ngắn */}
                  <p className="text-xs text-body font-serif line-clamp-2 leading-relaxed">
                    {info.description}
                  </p>
                </div>

                {/* Phần tiến độ học tập */}
                <div className="pt-4 mt-4 border-t border-border/70 space-y-2">
                  <div className="flex items-center justify-between text-xs font-serif">
                    <span className="text-muted">Tiến độ từ vựng</span>
                    <span className="font-bold text-title">
                      {user ? `${learnedVocabs}/${targetVocab} (${percent}%)` : `Mục tiêu ${targetVocab} từ`}
                    </span>
                  </div>
                  
                  {/* Progress bar */}
                  <div className="w-full bg-track h-2 rounded-full overflow-hidden">
                    <div 
                      className={`h-full rounded-full bg-gradient-to-r ${info.color.progressFrom} ${info.color.progressTo} transition-all duration-500`}
                      style={{ width: `${user ? percent : 0}%` }}
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



      {/* CÁC CHỨC NĂNG HỌC TẬP KHÁC (BỘ THỦ, ĐÁNH MÁY, VIẾT AI, TẠO BÀI) */}
      <section className="space-y-4">
        <div className="border-b-2 border-border-strong pb-2">
          <h2 className="text-xl font-serif font-bold text-title">Công cụ học tập & Luyện kỹ năng</h2>
          <p className="text-xs text-muted font-serif mt-0.5">Các công cụ hỗ trợ nâng cao toàn diện kỹ năng tiếng Trung</p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          {/* 214 Bộ thủ */}
          <Link 
            href="/radicals" 
            className="group p-5 rounded-2xl border border-border bg-card hover:border-app-accent/50 hover:shadow-xs transition-all flex flex-col justify-between"
          >
            <div className="space-y-3">
              <div className="w-10 h-10 rounded-xl bg-app-accent-soft text-app-accent flex items-center justify-center">
                <Component className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-app-accent transition-colors">
                  214 Bộ thủ Khang Hy
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Phân loại 17 nhóm nét, tra cứu ý nghĩa, Flashcard và Trắc nghiệm phản xạ bộ thủ.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs font-serif font-medium text-app-accent flex items-center gap-1">
              <span>Học bộ thủ</span>
              <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Luyện đánh máy */}
          <Link 
            href="/typing" 
            className="group p-5 rounded-2xl border border-border bg-card hover:border-jade/50 hover:shadow-xs transition-all flex flex-col justify-between"
          >
            <div className="space-y-3">
              <div className="w-10 h-10 rounded-xl bg-jade/10 text-jade flex items-center justify-center">
                <Keyboard className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-jade transition-colors">
                  Luyện đánh máy Pinyin
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Luyện gõ chữ Hán theo từng cấp độ, đo tốc độ WPM và độ chính xác gõ thực tế.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs font-serif font-medium text-jade flex items-center gap-1">
              <span>Luyện gõ ngay</span>
              <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>

          {/* Luyện viết AI */}
          <Link 
            href="/write" 
            className="group p-5 rounded-2xl border border-border bg-card hover:border-title/50 hover:shadow-xs transition-all flex flex-col justify-between"
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

          {/* Tạo bài học tùy chỉnh */}
          <Link 
            href="/lessons/create" 
            className="group p-5 rounded-2xl border border-border bg-card hover:border-gold/50 hover:shadow-xs transition-all flex flex-col justify-between"
          >
            <div className="space-y-3">
              <div className="w-10 h-10 rounded-xl bg-gold/10 text-gold flex items-center justify-center">
                <PlusCircle className="w-5 h-5" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-base text-title group-hover:text-gold transition-colors">
                  Tạo bài học riêng
                </h3>
                <p className="text-xs text-muted font-serif mt-1 leading-relaxed">
                  Tạo bài học từ tài liệu, trích xuất từ vựng và tự động tạo thẻ nhớ học tập.
                </p>
              </div>
            </div>
            <div className="pt-4 text-xs font-serif font-medium text-gold flex items-center gap-1">
              <span>Tạo bài học</span>
              <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
            </div>
          </Link>
        </div>
      </section>

    </div>
  )
}
