import { Metadata } from 'next';
import TypingClient from './typing-client';

export const metadata: Metadata = {
  title: 'Luyện đánh máy tiếng Trung (IME) - Chinese Notebook',
  description: 'Luyện kỹ năng gõ chữ Hán bằng Pinyin với bộ gõ IME trên máy tính và điện thoại. Theo dõi tốc độ gõ (CPM), độ chính xác qua 4 chế độ: Câu mẫu, Từ vựng, Đoạn văn và Theo HSK.',
};

export default function TypingPage() {
  return (
    <div className="max-w-5xl mx-auto space-y-6">
      <TypingClient />
    </div>
  );
}
