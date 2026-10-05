import { createClient } from '@/lib/supabase/server'
import FlashcardReviewer from './flashcard-reviewer'
import { BookOpen } from 'lucide-react'
import Link from 'next/link'
import { Button } from '@/components/ui/button'

export default async function ReviewPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) return null

  // Fetch words that need reviewing (next_review_at <= now)
  const now = new Date().toISOString()
  
  const { data: reviews } = await supabase
    .from('user_vocabularies')
    .select('id, vocabularies(hanzi, pinyin, meaning_vi)')
    .eq('user_id', user.id)
    .lte('next_review_at', now)
    .order('next_review_at', { ascending: true })

  // Transform data format
  const formattedVocabs = reviews?.map((r: unknown) => {
    const item = r as { id: string, vocabularies: { hanzi: string; pinyin: string; meaning_vi: string } | { hanzi: string; pinyin: string; meaning_vi: string }[] };
    const vocab = Array.isArray(item.vocabularies) ? item.vocabularies[0] : item.vocabularies;
    return {
      id: item.id,
      hanzi: vocab?.hanzi || '',
      pinyin: vocab?.pinyin || '',
      meaning_vi: vocab?.meaning_vi || ''
    };
  }) || [];

  return (
    <div className="max-w-4xl mx-auto pb-20">
      <div className="border-b-2 border-red-700/30 pb-6 mb-10">
        <h1 className="text-3xl font-serif text-slate-800 mb-2">Phòng Ôn Tập</h1>
        <p className="text-slate-500 font-serif">Sử dụng thuật toán lặp lại ngắt quãng (Spaced Repetition) để ghi nhớ.</p>
      </div>

      {formattedVocabs.length > 0 ? (
        <FlashcardReviewer vocabs={formattedVocabs} />
      ) : (
        <div className="text-center py-20 border-2 border-dashed border-slate-300 bg-white/30 rounded-sm">
          <BookOpen className="h-12 w-12 text-slate-300 mx-auto mb-4" />
          <h3 className="text-xl font-serif text-slate-700 mb-2">Chưa có từ nào cần ôn tập</h3>
          <p className="text-slate-500 mb-6 font-serif">Tuyệt vời! Bạn đã hoàn thành nhiệm vụ của ngày hôm nay.</p>
          <Link href="/lessons">
            <Button className="font-serif px-8">
              Đọc thêm bài học mới
            </Button>
          </Link>
        </div>
      )}
    </div>
  )
}
