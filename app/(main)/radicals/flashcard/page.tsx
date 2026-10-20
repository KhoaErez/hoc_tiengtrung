import { Metadata } from 'next'
import FlashcardClient from './flashcard-client'

export const metadata: Metadata = {
  title: 'Flashcard Bộ thủ - Chinese Notebook',
  description: 'Học 214 bộ thủ Khang Hy bằng flashcard — lật thẻ, xem nghĩa, pinyin và ví dụ minh họa.',
}

export default function FlashcardPage() {
  return (
    <div className="max-w-2xl mx-auto">
      <FlashcardClient />
    </div>
  )
}
