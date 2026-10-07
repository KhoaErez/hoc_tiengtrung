import { createClient } from '@/lib/supabase/server'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { BookOpen, PenTool, BrainCircuit, PlusCircle } from 'lucide-react'
import Link from 'next/link'
import { Button } from '@/components/ui/button'

export default async function HomePage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  let displayName = 'Khách'
  let savedVocabCount = 0
  let memorizedVocabCount = 0
  let lessonCount = 0
  let reviewWords: { hanzi: string; pinyin: string; vi: string }[] = []

  if (user) {
    const { data: profile } = await supabase
      .from('profiles')
      .select('display_name')
      .eq('id', user.id)
      .single()

    displayName = profile?.display_name || user?.user_metadata?.full_name || user?.email?.split('@')[0] || 'Học viên'

    const [
      { count: savedCount },
      { count: memorizedCount },
      { count: lessons },
      { data: reviewWordsData }
    ] = await Promise.all([
      supabase.from('user_vocabularies').select('*', { count: 'exact', head: true }).eq('user_id', user.id),
      supabase.from('user_vocabularies').select('*', { count: 'exact', head: true }).eq('user_id', user.id).gte('review_interval_days', 21),
      supabase.from('lessons').select('*', { count: 'exact', head: true }).eq('user_id', user.id),
      supabase.from('user_vocabularies').select('id, vocabularies(hanzi, pinyin, meaning_vi)').eq('user_id', user.id).lte('next_review_at', new Date().toISOString()).limit(4)
    ]);

    savedVocabCount = savedCount || 0;
    memorizedVocabCount = memorizedCount || 0;
    lessonCount = lessons || 0;
    
    reviewWords = reviewWordsData?.map((r: unknown) => {
      const item = r as { vocabularies: { hanzi: string; pinyin: string; meaning_vi: string } | { hanzi: string; pinyin: string; meaning_vi: string }[] };
      const vocab = Array.isArray(item.vocabularies) ? item.vocabularies[0] : item.vocabularies;
      return {
        hanzi: vocab?.hanzi || '',
        pinyin: vocab?.pinyin || '',
        vi: vocab?.meaning_vi || ''
      };
    }) || [];
  }

  return (
    <div className="max-w-4xl mx-auto space-y-10">
      
      {!user && (
        <div className="bg-card border border-border shadow-sm rounded-lg p-4 md:p-8 text-center space-y-4">
          <h1 className="text-2xl md:text-3xl font-serif text-title break-words">Chào mừng đến với Chinese Notebook</h1>
          <p className="text-muted font-serif max-w-2xl mx-auto text-sm md:text-base">
            Nền tảng học tiếng Trung thông minh với các bài học đa dạng. Khám phá các nội dung công khai bên dưới hoặc đăng nhập để sử dụng tính năng ôn tập Flashcard và AI hỗ trợ viết.
          </p>
          <div className="pt-2 flex flex-col sm:flex-row justify-center gap-3 md:gap-4">
            <Link href="/login" className="w-full sm:w-auto">
              <Button className="w-full font-serif bg-title hover:bg-[#2A3250] text-white px-8 rounded-md">Đăng nhập</Button>
            </Link>
            <Link href="/register" className="w-full sm:w-auto">
              <Button variant="outline" className="w-full font-serif px-8 rounded-md border-border text-title">Đăng ký ngay</Button>
            </Link>
          </div>
        </div>
      )}

      <div className="space-y-2">
        <h1 className="text-2xl md:text-3xl font-serif text-title break-words">Xin chào, {displayName}</h1>
        <p className="text-muted font-serif">Hôm nay bạn muốn học gì?</p>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <Card className="rounded-lg shadow-sm border border-border bg-card relative overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-1 bg-title"></div>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-normal text-muted uppercase tracking-wider">Từ vựng</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-serif text-title">{savedVocabCount}</div>
            <p className="text-xs text-muted mt-1">Đã lưu</p>
          </CardContent>
        </Card>
        
        <Card className="rounded-lg shadow-sm border border-border bg-card relative overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-1 bg-jade"></div>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-normal text-muted uppercase tracking-wider">Từ đã nhớ</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-serif text-jade">{memorizedVocabCount}</div>
            <p className="text-xs text-muted mt-1">Trong bộ nhớ dài hạn</p>
          </CardContent>
        </Card>

        <Card className="rounded-lg shadow-sm border border-border bg-card relative overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-1 bg-gold"></div>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-normal text-muted uppercase tracking-wider">Bài học</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-serif text-gold">{lessonCount}</div>
            <p className="text-xs text-muted mt-1">Đã tạo</p>
          </CardContent>
        </Card>

        <Card className="rounded-lg shadow-sm border border-border bg-card relative overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-1 bg-border-strong"></div>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-normal text-muted uppercase tracking-wider">Ngữ pháp</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-serif text-muted">0</div>
            <p className="text-xs text-muted mt-1">Tính năng sắp ra mắt</p>
          </CardContent>
        </Card>
      </div>

      <div className="space-y-4">
        <div className="flex items-center justify-between border-b-2 border-app-accent/35 pb-2">
          <h2 className="text-xl font-serif text-title">Cần ôn tập hôm nay</h2>
          <Link href="/review" className="text-sm text-app-accent hover:text-accent-hover font-serif">Ôn tập ngay &rarr;</Link>
        </div>
        
        {!user ? (
          <div className="text-muted text-sm font-serif italic py-4">Vui lòng <Link href="/login" className="text-app-accent underline hover:text-accent-hover">đăng nhập</Link> để ôn tập từ vựng và lưu trữ bộ nhớ của bạn.</div>
        ) : reviewWords.length === 0 ? (
          <div className="text-muted text-sm font-serif italic py-4">Bạn không có từ vựng nào cần ôn tập hôm nay.</div>
        ) : (
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {reviewWords.map((word: { hanzi: string, pinyin: string, vi: string }) => (
              <div key={word.hanzi} className="border border-border p-3 flex flex-col items-center justify-center rounded-lg bg-card hover:border-app-accent/50 hover:shadow-sm transition-all cursor-pointer group relative overflow-hidden">
                <span className="text-xs text-muted mb-1 font-sans tracking-wide">{word.pinyin}</span>
                <span className="text-3xl font-serif text-title mb-2 group-hover:text-app-accent transition-colors">{word.hanzi}</span>
                <span className="text-sm text-muted font-serif text-center line-clamp-1">{word.vi}</span>
              </div>
            ))}
          </div>
        )}
      </div>

      <div className="space-y-4">
        <h2 className="text-xl font-serif text-title border-b-2 border-app-accent/35 pb-2 inline-block">Tiến độ HSK 1</h2>
        <div className="w-full bg-track h-4 rounded-full overflow-hidden">
          <div className="bg-gradient-to-r from-app-accent to-[#D4553F] h-full w-[60%] rounded-full"></div>
        </div>
        {!user ? (
          <p className="text-right text-sm text-muted font-serif">Vui lòng <Link href="/login" className="text-app-accent underline hover:text-accent-hover">đăng nhập</Link> để lưu tiến độ học của bạn.</p>
        ) : (
          <p className="text-right text-sm text-muted font-serif">60% hoàn thành</p>
        )}
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pt-4">
        <Link href="/lessons/create">
          <div className="group border-2 border-dashed border-border-strong bg-page p-8 flex flex-col items-center justify-center text-center hover:border-app-accent hover:bg-app-accent-soft/40 transition-colors cursor-pointer h-full rounded-lg">
            <PlusCircle className="h-8 w-8 text-app-accent mb-3" />
            <h3 className="font-serif text-lg text-title">Tạo bài học mới</h3>
            <p className="text-sm text-muted mt-1">Từ văn bản, hình ảnh hoặc file tài liệu</p>
          </div>
        </Link>
        
        <div className="space-y-3">
          <Link href="/lessons" className="flex items-center gap-4 p-4 border border-border bg-card rounded-lg shadow-sm hover:shadow-md hover:border-border-strong transition-all">
            <div className="bg-navy-soft p-3 rounded-lg"><BookOpen className="h-5 w-5 text-title" /></div>
            <div>
              <h3 className="font-serif text-title">Danh sách bài học</h3>
              <p className="text-xs text-muted mt-0.5">Xem lại các bài đã lưu</p>
            </div>
          </Link>
          
          <Link href="/write" className="flex items-center gap-4 p-4 border border-border bg-card rounded-lg shadow-sm hover:shadow-md hover:border-border-strong transition-all">
            <div className="bg-accent-soft p-3 rounded-lg"><PenTool className="h-5 w-5 text-app-accent" /></div>
            <div>
              <h3 className="font-serif text-title">Luyện viết (AI sửa)</h3>
              <p className="text-xs text-muted mt-0.5">Viết tự do và nhận nhận xét</p>
            </div>
          </Link>
          
          <Link href="/review" className="flex items-center gap-4 p-4 border border-border bg-card rounded-lg shadow-sm hover:shadow-md hover:border-border-strong transition-all">
            <div className="bg-jade-soft p-3 rounded-lg"><BrainCircuit className="h-5 w-5 text-jade" /></div>
            <div>
              <h3 className="font-serif text-title">Ôn tập Flashcard</h3>
              <p className="text-xs text-muted mt-0.5">Ghi nhớ từ vựng hiệu quả</p>
            </div>
          </Link>
        </div>
      </div>
    </div>
  )
}
