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
        <div className="bg-white/60 border-2 border-slate-200 p-4 md:p-8 text-center space-y-4">
          <h1 className="text-2xl md:text-3xl font-serif text-slate-800 break-words">Chào mừng đến với Chinese Notebook</h1>
          <p className="text-slate-500 font-serif max-w-2xl mx-auto text-sm md:text-base">
            Nền tảng học tiếng Trung thông minh với các bài học đa dạng. Khám phá các nội dung công khai bên dưới hoặc đăng nhập để sử dụng tính năng ôn tập Flashcard và AI hỗ trợ viết.
          </p>
          <div className="pt-2 flex flex-col sm:flex-row justify-center gap-3 md:gap-4">
            <Link href="/login" className="w-full sm:w-auto">
              <Button className="w-full font-serif bg-red-700 hover:bg-red-800 text-white px-8 rounded-sm">Đăng nhập</Button>
            </Link>
            <Link href="/register" className="w-full sm:w-auto">
              <Button variant="outline" className="w-full font-serif px-8 rounded-sm">Đăng ký ngay</Button>
            </Link>
          </div>
        </div>
      )}

      <div className="space-y-2">
        <h1 className="text-2xl md:text-3xl font-serif text-slate-800 break-words">Xin chào, {displayName}</h1>
        <p className="text-slate-500 font-serif">Hôm nay bạn muốn học gì?</p>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <Card className="rounded-sm shadow-none border-2 border-slate-200 bg-transparent hover:border-blue-200 transition-colors">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-normal text-slate-500 uppercase tracking-wider">Từ vựng</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-serif text-slate-800">{savedVocabCount}</div>
            <p className="text-xs text-slate-400 mt-1">Đã lưu</p>
          </CardContent>
        </Card>
        
        <Card className="rounded-sm shadow-none border-2 border-slate-200 bg-transparent hover:border-green-200 transition-colors">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-normal text-slate-500 uppercase tracking-wider">Từ đã nhớ</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-serif text-slate-800">{memorizedVocabCount}</div>
            <p className="text-xs text-slate-400 mt-1">Trong bộ nhớ dài hạn</p>
          </CardContent>
        </Card>

        <Card className="rounded-sm shadow-none border-2 border-slate-200 bg-transparent hover:border-amber-200 transition-colors">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-normal text-slate-500 uppercase tracking-wider">Bài học</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-serif text-slate-800">{lessonCount}</div>
            <p className="text-xs text-slate-400 mt-1">Đã tạo</p>
          </CardContent>
        </Card>

        <Card className="rounded-sm shadow-none border-2 border-slate-200 bg-transparent hover:border-red-200 transition-colors">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-normal text-slate-500 uppercase tracking-wider">Ngữ pháp</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-serif text-slate-800">0</div>
            <p className="text-xs text-slate-400 mt-1">Tính năng sắp ra mắt</p>
          </CardContent>
        </Card>
      </div>

      <div className="space-y-4">
        <div className="flex items-center justify-between border-b-2 border-red-700/30 pb-2">
          <h2 className="text-xl font-serif text-slate-800">Cần ôn tập hôm nay</h2>
          <Link href="/review" className="text-sm text-red-700 hover:underline font-serif">Ôn tập ngay &rarr;</Link>
        </div>
        
        {!user ? (
          <div className="text-slate-500 text-sm font-serif italic py-4">Vui lòng <Link href="/login" className="text-red-700 underline hover:text-red-800">đăng nhập</Link> để ôn tập từ vựng và lưu trữ bộ nhớ của bạn.</div>
        ) : reviewWords.length === 0 ? (
          <div className="text-slate-500 text-sm font-serif italic py-4">Bạn không có từ vựng nào cần ôn tập hôm nay.</div>
        ) : (
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {reviewWords.map((word: { hanzi: string, pinyin: string, vi: string }) => (
              <div key={word.hanzi} className="border-2 border-slate-200 p-3 flex flex-col items-center justify-center rounded-sm bg-white/40 hover:bg-white/80 hover:border-red-700/30 transition-colors cursor-pointer group relative overflow-hidden">
                <div className="absolute top-0 right-0 w-8 h-8 bg-red-700/5 rotate-45 translate-x-4 -translate-y-4 group-hover:bg-red-700/10 transition-colors"></div>
                <span className="text-xs text-slate-400 mb-1 font-sans tracking-wide">{word.pinyin}</span>
                <span className="text-3xl font-serif text-slate-800 mb-2 group-hover:text-red-700 transition-colors">{word.hanzi}</span>
                <span className="text-sm text-slate-600 font-serif text-center line-clamp-1">{word.vi}</span>
              </div>
            ))}
          </div>
        )}
      </div>

      <div className="space-y-4">
        <h2 className="text-xl font-serif text-slate-800 border-b-2 border-red-700/30 pb-2 inline-block">Tiến độ HSK 1</h2>
        <div className="w-full bg-slate-200 h-4 rounded-sm overflow-hidden">
          <div className="bg-red-700/80 h-full w-[60%]"></div>
        </div>
        {!user ? (
          <p className="text-right text-sm text-slate-500 font-serif">Vui lòng <Link href="/login" className="text-red-700 underline hover:text-red-800">đăng nhập</Link> để lưu tiến độ học của bạn.</p>
        ) : (
          <p className="text-right text-sm text-slate-500 font-serif">60% hoàn thành</p>
        )}
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pt-4">
        <Link href="/lessons/create">
          <div className="group border-2 border-dashed border-slate-300 p-8 flex flex-col items-center justify-center text-center hover:border-red-700/50 hover:bg-slate-50/50 transition-colors cursor-pointer h-full">
            <PlusCircle className="h-8 w-8 text-slate-400 group-hover:text-red-700 mb-3" />
            <h3 className="font-serif text-lg text-slate-700 group-hover:text-slate-900">Tạo bài học mới</h3>
            <p className="text-sm text-slate-500 mt-1">Từ văn bản, hình ảnh hoặc file tài liệu</p>
          </div>
        </Link>
        
        <div className="space-y-3">
          <Link href="/lessons" className="flex items-center gap-4 p-4 border-2 border-slate-200 hover:border-slate-300 bg-white/50 transition-colors">
            <div className="bg-blue-50 p-3 rounded-sm"><BookOpen className="h-5 w-5 text-blue-600" /></div>
            <div>
              <h3 className="font-serif text-slate-800">Danh sách bài học</h3>
              <p className="text-xs text-slate-500">Xem lại các bài đã lưu</p>
            </div>
          </Link>
          
          <Link href="/write" className="flex items-center gap-4 p-4 border-2 border-slate-200 hover:border-slate-300 bg-white/50 transition-colors">
            <div className="bg-amber-50 p-3 rounded-sm"><PenTool className="h-5 w-5 text-amber-600" /></div>
            <div>
              <h3 className="font-serif text-slate-800">Luyện viết (AI sửa)</h3>
              <p className="text-xs text-slate-500">Viết tự do và nhận nhận xét</p>
            </div>
          </Link>
          
          <Link href="/review" className="flex items-center gap-4 p-4 border-2 border-slate-200 hover:border-slate-300 bg-white/50 transition-colors">
            <div className="bg-green-50 p-3 rounded-sm"><BrainCircuit className="h-5 w-5 text-green-600" /></div>
            <div>
              <h3 className="font-serif text-slate-800">Ôn tập Flashcard</h3>
              <p className="text-xs text-slate-500">Ghi nhớ từ vựng hiệu quả</p>
            </div>
          </Link>
        </div>
      </div>
    </div>
  )
}
