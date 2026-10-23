'use client'

import Link from 'next/link'
import { PenTool, Sparkles, Clock, ArrowLeft, Keyboard, BookOpen, CheckCircle2 } from 'lucide-react'
import { Button } from '@/components/ui/button'

export function WritingComingSoon() {
  return (
    <div className="max-w-3xl mx-auto py-8 sm:py-14 px-4 font-serif space-y-6">
      {/* Thẻ chính Coming Soon */}
      <div className="relative overflow-hidden rounded-3xl border border-border bg-card p-8 sm:p-12 shadow-xs text-center space-y-7">
        {/* Viền màu nhỏ phía trên thẻ (Thanh gradient Đông Phương) */}
        <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-app-accent via-app-accent/80 to-gold" />

        {/* Họa tiết vân mây Á Đông trang nhã (Watermark) */}
        <div className="absolute top-0 right-0 w-72 h-72 opacity-5 pointer-events-none text-app-accent">
          <svg viewBox="0 0 200 200" fill="currentColor">
            <path d="M40,120 C20,120 10,105 20,90 C15,75 30,60 45,65 C55,45 80,45 90,60 C105,45 130,50 135,70 C150,70 160,85 155,100 C165,115 150,130 135,125 C125,140 100,140 90,125 C75,140 50,135 40,120 Z" />
          </svg>
        </div>

        {/* Cụm biểu tượng minh họa cao cấp */}
        <div className="relative inline-flex items-center justify-center">
          <div className="w-18 h-18 rounded-2xl bg-app-accent-soft text-app-accent border border-app-accent/25 flex items-center justify-center shadow-xs mx-auto">
            <PenTool className="w-8 h-8" />
          </div>
          <span className="absolute -top-1 -right-1 p-1 rounded-full bg-gold-soft text-gold border border-gold/30 shadow-2xs">
            <Sparkles className="w-3.5 h-3.5" />
          </span>
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
            <Sparkles className="w-4 h-4 text-app-accent" />
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
