'use client'

import Image from 'next/image'
import Link from 'next/link'
import { PenTool, BrainCircuit, NotebookPen, Clock, ArrowLeft, Keyboard, BookOpen, CheckCircle2 } from 'lucide-react'
import { Button } from '@/components/ui/button'

export function WritingComingSoon() {
  return (
    <div className="max-w-3xl mx-auto py-8 sm:py-14 px-4 font-serif space-y-6">
      {/* Thẻ chính Coming Soon */}
      <div className="relative overflow-hidden rounded-3xl border-2 border-[#182238] dark:border-[#384869] bg-white dark:bg-[#182238] p-6 sm:p-10 shadow-[0_6px_0_#182238] dark:shadow-[0_4px_0_#0D1322] text-center space-y-6">
        {/* Viền màu nhỏ phía trên thẻ (Thanh gradient Đông Phương) */}
        <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-app-accent via-app-accent/80 to-gold" />

        {/* 3D Illustration Banner */}
        <div className="relative w-36 h-36 sm:w-44 sm:h-44 mx-auto rounded-3xl overflow-hidden border-2 border-[#182238] dark:border-[#384869] shadow-[0_4px_0_#182238] bg-[#FAF7F2]">
          <Image
            src="/images/writing/writing-hero.webp"
            alt="Luyện viết AI 3D"
            fill
            className="object-cover"
            priority
            sizes="176px"
          />
        </div>

        {/* Tiêu đề & Thông báo trạng thái */}
        <div className="space-y-3 max-w-xl mx-auto">
          <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-serif font-medium bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/25">
            <Clock className="w-3.5 h-3.5 animate-pulse" />
            <span>Tính năng đang phát triển • Sắp ra mắt</span>
          </div>

          <h1 className="text-2xl sm:text-3xl font-bold text-title tracking-tight leading-snug">
            Luyện Viết AI — Sắp ra mắt
          </h1>

          <p className="text-sm sm:text-base text-body font-serif leading-relaxed">
            Tính năng luyện viết tiếng Trung cùng AI đang được phát triển. Trong tương lai, bạn sẽ có thể luyện viết, nhận góp ý ngữ pháp và cải thiện khả năng diễn đạt.
          </p>
        </div>

        {/* Khung giới thiệu những trải nghiệm sắp tới (Teaser thuần thông tin, không nút giả) */}
        <div className="bg-page/70 border border-border/80 rounded-2xl p-5 sm:p-6 text-left max-w-xl mx-auto space-y-3.5 shadow-2xs">
          <div className="flex items-center gap-2 text-xs font-bold text-title">
            <NotebookPen className="w-4 h-4 text-app-accent" />
            <span>Những khả năng sẽ có trong phiên bản hoàn thiện:</span>
          </div>

          <ul className="space-y-2.5 text-xs text-muted leading-relaxed">
            <li className="flex items-start gap-2.5">
              <CheckCircle2 className="w-4 h-4 text-jade shrink-0 mt-0.5" />
              <span>
                <strong className="text-title">Chấm điểm & xếp hạng chuẩn HSK 3.0:</strong> Đánh giá chi tiết 6 tiêu chí (ngữ pháp, từ vựng, trật tự câu, độ tự nhiên, mạch lạc và độ phù hợp HSK).
              </span>
            </li>
            <li className="flex items-start gap-2.5">
              <CheckCircle2 className="w-4 h-4 text-jade shrink-0 mt-0.5" />
              <span>
                <strong className="text-title">Chỉ rõ lỗi sai & giải thích tiếng Việt:</strong> Phân biệt rành mạch giữa lỗi sai thực tế và gợi ý hành văn mượt mà hơn.
              </span>
            </li>
            <li className="flex items-start gap-2.5">
              <CheckCircle2 className="w-4 h-4 text-jade shrink-0 mt-0.5" />
              <span>
                <strong className="text-title">Bản viết trau chuốt & từ vựng nâng cao:</strong> Đề xuất từ đồng nghĩa ngữ cảnh cao cấp và phát âm chuẩn Mandarin.
              </span>
            </li>
          </ul>
        </div>

        {/* Cụm nút hành động điều hướng */}
        <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3 max-w-md mx-auto">
          <Link href="/" className="w-full sm:w-auto">
            <Button variant="tertiary" className="w-full sm:w-auto font-serif min-h-[44px] px-6 text-xs sm:text-sm flex items-center justify-center gap-2 cursor-pointer transition-all">
              <ArrowLeft className="w-4 h-4" />
              <span>Quay về trang chủ</span>
            </Button>
          </Link>
          <Link href="/typing" className="w-full sm:w-auto">
            <Button variant="outline" className="w-full sm:w-auto font-serif border-[#E9DDD1] hover:bg-[#FFF9F3] text-title min-h-[44px] px-5 text-xs sm:text-sm flex items-center justify-center gap-2 cursor-pointer transition-all">
              <Keyboard className="w-4 h-4 text-app-accent" />
              <span>Luyện đánh máy</span>
            </Button>
          </Link>
        </div>
      </div>
    </div>
  )
}
