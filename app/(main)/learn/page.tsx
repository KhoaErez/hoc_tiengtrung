import { Metadata } from 'next'
import CourseRoadmapClient from './course-roadmap-client'
import type { CourseTrack } from '@/data/course-roadmap-data'

export const metadata: Metadata = {
  title: 'Học Từng Bài Theo Lộ Trình | Chinese Notebook',
  description:
    'Trải nghiệm học tiếng Trung theo từng bài chuẩn lộ trình HSK 1–6 và Tiếng Trung Công Xưởng: Từ vựng, Hội thoại, Bài tập tương tác & Ôn tập SM-2.',
}

export default async function LearnRoadmapPage(props: {
  searchParams: Promise<{ track?: string; level?: string; unit?: string }>
}) {
  const searchParams = await props.searchParams
  const initialTrack: CourseTrack = searchParams.track === 'factory' ? 'factory' : 'hsk'
  const rawLevel = parseInt(searchParams.level || '1', 10)
  const initialHskLevel = rawLevel >= 1 && rawLevel <= 6 ? rawLevel : 1
  const initialFactoryUnit = searchParams.unit || 'all'

  return (
    <div className="w-full">
      <CourseRoadmapClient
        initialTrack={initialTrack}
        initialHskLevel={initialHskLevel}
        initialFactoryUnit={initialFactoryUnit}
      />
    </div>
  )
}
