import { Metadata } from 'next'
import { getCachedAuthUser } from '@/lib/supabase/server'
import { searchVocabulariesAction, getVocabularyOverviewAction } from './actions'
import { VocabularyClient } from './vocabulary-client'

export const metadata: Metadata = {
  title: 'Tra Từ Điển & Từ Vựng Tiếng Trung HSK 3.0 - Chinese Notebook',
  description:
    'Tra cứu từ điển tiếng Trung HSK 1–9 chuẩn GF 0025-2021. Hỗ trợ tra bằng Chữ Hán, Pinyin và Tiếng Việt, nghe audio phát âm giọng đọc Bắc Kinh và lưu vào sổ tay ôn tập SM-2.',
  keywords: [
    'tra từ tiếng trung',
    'từ điển hsk',
    'từ vựng hsk 1',
    'từ vựng hsk 2',
    'từ vựng hsk 3',
    'từ vựng hsk 4',
    'từ vựng hsk 5',
    'từ vựng hsk 6',
    'hsk 3.0 vocabulary',
    'chinese dictionary',
  ],
}

export const dynamic = 'force-dynamic'

export default async function VocabularyPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; level?: string; topic?: string; page?: string }>
}) {
  const params = await searchParams
  const initialSearch = params?.q || ''
  const initialHskLevel = params?.level || 'all'
  const initialTopic = params?.topic || 'all'
  const initialPage = parseInt(params?.page || '1', 10) || 1

  const user = await getCachedAuthUser()

  const [searchResult, overview] = await Promise.all([
    searchVocabulariesAction({
      search: initialSearch,
      hskLevel: initialHskLevel,
      topic: initialTopic,
      page: initialPage,
      pageSize: 24,
    }),
    getVocabularyOverviewAction(),
  ])

  return (
    <div className="w-full max-w-[1500px] mx-auto py-2 pb-24 sm:pb-32">
      <VocabularyClient
        initialVocabs={searchResult.vocabs}
        initialTotalCount={searchResult.totalCount}
        initialPage={searchResult.page}
        initialTotalPages={searchResult.totalPages}
        initialHskLevel={initialHskLevel}
        initialSearch={initialSearch}
        initialTopic={initialTopic}
        countsByLevel={overview.countsByLevel}
        isLoggedIn={!!user}
      />
    </div>
  )
}

