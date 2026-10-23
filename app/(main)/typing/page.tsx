import { Metadata } from 'next';
import { Suspense } from 'react';
import TypingClient from './typing-client';

export const metadata: Metadata = {
  title: 'Luyện đánh máy - Chinese Notebook',
  description: 'Luyện kỹ năng gõ chữ Hán bằng Pinyin trên máy tính và điện thoại. Theo dõi tốc độ gõ (CPM), độ chính xác qua các chế độ: Nghe & Gõ, Dịch Việt → Gõ Hán, Đoạn văn và Theo HSK.',
};

export default function TypingPage() {
  return (
    <div className="max-w-5xl mx-auto space-y-6">
      <Suspense fallback={<div className="p-12 text-center text-muted font-serif text-sm">Đang tải phòng luyện đánh máy...</div>}>
        <TypingClient />
      </Suspense>
    </div>
  );
}
