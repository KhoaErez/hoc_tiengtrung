import { Metadata } from 'next';
import { Suspense } from 'react';
import TypingClient from './typing-client';

export const metadata: Metadata = {
  title: 'Luyện đánh máy tiếng Trung (IME) - Chinese Notebook',
  description: 'Luyện kỹ năng gõ chữ Hán bằng Pinyin với bộ gõ IME trên máy tính và điện thoại. Theo dõi tốc độ gõ (CPM), độ chính xác qua các chế độ: Câu mẫu (ca dao tục ngữ), Đoạn văn và Theo HSK.',
};

export default function TypingPage() {
  return (
    <div className="max-w-5xl mx-auto space-y-6">
      <Suspense fallback={<div className="p-12 text-center text-muted font-serif text-sm">Đang tải phòng luyện đánh máy IME...</div>}>
        <TypingClient />
      </Suspense>
    </div>
  );
}
