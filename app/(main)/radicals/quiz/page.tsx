import { Metadata } from 'next'
import QuizClient from './quiz-client'

export const metadata: Metadata = {
  title: 'Quiz Bộ thủ - Chinese Notebook',
  description: 'Kiểm tra kiến thức 214 bộ thủ Khang Hy bằng trắc nghiệm — nhận diện chữ Hán, chọn nghĩa tiếng Việt.',
}

export default function QuizPage() {
  return (
    <div className="max-w-2xl mx-auto">
      <QuizClient />
    </div>
  )
}
