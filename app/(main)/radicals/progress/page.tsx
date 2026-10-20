import { Metadata } from 'next'
import ProgressClient from './progress-client'

export const metadata: Metadata = {
  title: 'Tiến độ học Bộ thủ - Chinese Notebook',
  description: 'Theo dõi tiến độ học 214 bộ thủ Khang Hy — danh sách đã học, yêu thích và lịch sử quiz.',
}

export default function ProgressPage() {
  return (
    <div className="max-w-3xl mx-auto">
      <ProgressClient />
    </div>
  )
}
