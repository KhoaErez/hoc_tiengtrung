import { Metadata } from 'next'
import RadicalGrid from './components/radical-grid'

export const metadata: Metadata = {
  title: '214 Bộ thủ Khang Hy - Chinese Notebook',
  description: 'Học và tra cứu 214 bộ thủ Khang Hy (康熙部首) — thành phần cơ bản dùng để tra cứu và phân loại chữ Hán trong từ điển.',
}

export default function RadicalsPage() {
  return (
    <div className="max-w-7xl mx-auto">
      <RadicalGrid />
    </div>
  )
}
