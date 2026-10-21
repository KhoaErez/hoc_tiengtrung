import { Metadata } from 'next'
import { isFeatureEnabled } from '@/lib/feature-flags'
import { WritingComingSoon } from './components/writing-coming-soon'
import { WritingView } from './components/writing-view'

export const metadata: Metadata = {
  title: 'Luyện Viết AI — Sắp ra mắt | Chinese Notebook',
  description:
    'Tính năng luyện viết tiếng Trung cùng AI đang được phát triển. Trong tương lai, bạn sẽ có thể luyện viết, nhận góp ý ngữ pháp và cải thiện khả năng diễn đạt.',
}

export default function WritingPage() {
  const isEnabled = isFeatureEnabled('AI_WRITING')

  if (!isEnabled) {
    return <WritingComingSoon />
  }

  return <WritingView />
}
