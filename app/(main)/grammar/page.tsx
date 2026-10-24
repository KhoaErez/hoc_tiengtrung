import { Metadata } from 'next'
import { getGrammarPointsPaginatedAction, getGrammarLevelsOverviewAction } from './actions'
import { GrammarClient } from './grammar-client'

export const metadata: Metadata = {
  title: 'Ngữ pháp HSK 3.0 Chuẩn GF 0025-2021 (HSK 1–6) - Chinese Notebook',
  description:
    'Học ngữ pháp HSK 1–6 theo tiêu chuẩn quốc tế GF 0025-2021 của Bộ Giáo dục Trung Quốc. Giải thích chi tiết tiếng Việt, kèm câu ví dụ thực tế và phát âm âm thanh bản ngữ.',
  keywords: [
    'ngữ pháp hsk 1',
    'ngữ pháp hsk 2',
    'ngữ pháp hsk 3',
    'ngữ pháp hsk 4',
    'ngữ pháp hsk 5',
    'ngữ pháp hsk 6',
    'hsk 3.0 grammar',
    'gf 0025-2021',
    'học tiếng trung',
    'chinese notebook',
  ],
}

export const dynamic = 'force-dynamic'

export default async function GrammarPage({
  searchParams,
}: {
  searchParams: Promise<{ level?: string; page?: string; category?: string; q?: string; status?: string }>
}) {
  const params = await searchParams
  const initialLevel = params?.level || 'HSK 1'
  const initialPage = parseInt(params?.page || '1', 10) || 1
  const initialCategory = params?.category || 'all'
  const initialQuery = params?.q || ''
  const initialStatus = (params?.status as 'all' | 'unmastered' | 'mastered') || 'all'

  const [paginatedResult, levelCounts] = await Promise.all([
    getGrammarPointsPaginatedAction({
      level: initialLevel,
      page: initialPage,
      pageSize: 10,
      category: initialCategory,
      search: initialQuery,
      masteredFilter: initialStatus,
    }),
    getGrammarLevelsOverviewAction(),
  ])

  return (
    <main className="max-w-6xl mx-auto px-4 sm:px-6 py-6 md:py-8 pb-28 sm:pb-36">
      <GrammarClient
        initialItems={paginatedResult.data}
        initialTotalCount={paginatedResult.totalCount}
        initialTotalPages={paginatedResult.totalPages}
        initialCategories={paginatedResult.categories}
        initialLevel={initialLevel}
        initialPage={paginatedResult.page}
        initialCategory={initialCategory}
        initialQuery={initialQuery}
        initialStatus={initialStatus}
        levelCounts={levelCounts}
      />
    </main>
  )
}
