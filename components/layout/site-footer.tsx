import React from 'react'
import Link from 'next/link'
import { SITE_CONFIG } from '@/lib/site-config'
import { BrandLogo, BrandSymbol } from '@/components/ui/brand-logo'
import { BookOpen, GraduationCap, Keyboard, BrainCircuit, Sparkles, Heart } from 'lucide-react'

export function SiteFooter() {
  return (
    <footer
      className="w-full border-t-2 border-[#E5D7CA] dark:border-[#2D3A56] bg-page/95 backdrop-blur-md select-none transition-colors mt-12"
      role="contentinfo"
      aria-label="Thông tin bản quyền và tác giả"
    >
      <div className="w-[90%] sm:w-[92%] max-w-[1536px] 2xl:max-w-[1640px] mx-auto px-2 sm:px-4 lg:px-6 2xl:px-8 pt-10 pb-24 md:pb-10 space-y-8">
        {/* Main Footer Grid - 4 Columns */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
          {/* Col 1: Brand & Story */}
          <div className="space-y-3">
            <BrandLogo variant="horizontal" size="md" />
            <p className="text-xs font-serif text-muted leading-relaxed">
              <strong>Hán Ngữ Tập Ghi</strong> — Không gian học tiếng Trung hiện đại, mài mực luyện nét, ghi nhớ sâu qua từng trang tập ghi và phản xạ gõ phím thông minh.
            </p>
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#FFF9F3] dark:bg-card border border-[#E5D7CA] text-[11px] font-serif text-[#182238] dark:text-slate-200 shadow-2xs">
              <span className="w-2 h-2 rounded-full bg-[#B8322D] animate-pulse" />
              <span>Tiêu chuẩn HSK 3.0 GF 0025-2021</span>
            </div>
          </div>

          {/* Col 2: Lộ trình HSK & Bộ thủ */}
          <div className="space-y-2.5">
            <h4 className="text-xs font-serif font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200 flex items-center gap-1.5">
              <GraduationCap className="w-3.5 h-3.5 text-[#B8322D]" />
              <span>Lộ trình HSK 3.0</span>
            </h4>
            <ul className="space-y-1.5 text-xs font-serif text-muted">
              <li>
                <Link href="/topics?q=HSK 1" className="hover:text-[#B8322D] transition-colors flex items-center justify-between">
                  <span>HSK 1 · Sơ cấp (Đồng Sinh)</span>
                  <span className="text-[10px] font-mono opacity-70">500 từ</span>
                </Link>
              </li>
              <li>
                <Link href="/topics?q=HSK 2" className="hover:text-[#B8322D] transition-colors flex items-center justify-between">
                  <span>HSK 2 · Sơ cấp (Tú Tài)</span>
                  <span className="text-[10px] font-mono opacity-70">772 từ</span>
                </Link>
              </li>
              <li>
                <Link href="/topics?q=HSK 3" className="hover:text-[#B8322D] transition-colors flex items-center justify-between">
                  <span>HSK 3 · Sơ cấp (Cử Nhân)</span>
                  <span className="text-[10px] font-mono opacity-70">973 từ</span>
                </Link>
              </li>
              <li>
                <Link href="/topics?q=HSK 4" className="hover:text-[#B8322D] transition-colors flex items-center justify-between">
                  <span>HSK 4 · Trung cấp (Cống Sĩ)</span>
                  <span className="text-[10px] font-mono opacity-70">1,000 từ</span>
                </Link>
              </li>
              <li>
                <Link href="/topics?q=HSK 5" className="hover:text-[#B8322D] transition-colors flex items-center justify-between">
                  <span>HSK 5 · Trung cấp (Tiến Sĩ)</span>
                  <span className="text-[10px] font-mono opacity-70">1,071 từ</span>
                </Link>
              </li>
              <li>
                <Link href="/topics?q=HSK 6" className="hover:text-[#B8322D] transition-colors flex items-center justify-between">
                  <span>HSK 6 · Trung cấp (Thám Hoa)</span>
                  <span className="text-[10px] font-mono opacity-70">1,140 từ</span>
                </Link>
              </li>
              <li>
                <Link href="/radicals" className="hover:text-[#B8322D] transition-colors flex items-center justify-between">
                  <span>214 Bộ thủ Khang Hy</span>
                  <span className="text-[10px] font-mono opacity-70">17 nét</span>
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 3: Kỹ năng & Luyện tập */}
          <div className="space-y-2.5">
            <h4 className="text-xs font-serif font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200 flex items-center gap-1.5">
              <Keyboard className="w-3.5 h-3.5 text-[#B8322D]" />
              <span>Kỹ năng & Luyện tập</span>
            </h4>
            <ul className="space-y-1.5 text-xs font-serif text-muted">
              <li>
                <Link href="/typing?practice=visual" className="hover:text-[#B8322D] transition-colors">
                  Nghe & Gõ (Phản xạ tai nghe)
                </Link>
              </li>
              <li>
                <Link href="/typing?practice=translate" className="hover:text-[#B8322D] transition-colors">
                  Dịch Việt → Gõ Hán (Chuyển ngữ IME)
                </Link>
              </li>
              <li>
                <Link href="/review" className="hover:text-[#B8322D] transition-colors">
                  Ôn tập thẻ nhớ Spaced Repetition (SM-2)
                </Link>
              </li>
              <li>
                <Link href="/grammar" className="hover:text-[#B8322D] transition-colors">
                  Ngữ pháp tiếng Trung hệ thống
                </Link>
              </li>
              <li>
                <Link href="/lessons" className="hover:text-[#B8322D] transition-colors">
                  Chủ đề bài học sưu tầm & Đời sống
                </Link>
              </li>
              <li>
                <Link href="/write" className="hover:text-[#B8322D] transition-colors">
                  Luyện viết văn cùng Trợ lý AI
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 4: Thông tin & Tác giả */}
          <div className="space-y-2.5">
            <h4 className="text-xs font-serif font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200 flex items-center gap-1.5">
              <Sparkles className="w-3.5 h-3.5 text-amber-500" />
              <span>Thông tin & Dự án</span>
            </h4>
            <div className="space-y-2 text-xs font-serif text-muted">
              <p>
                Phát triển với tâm huyết dành cho cộng đồng tự học Hán ngữ Việt Nam.
              </p>
              <p>
                Tác giả: <Link href="/about" className="font-semibold text-[#B8322D] hover:underline">{SITE_CONFIG.developer}</Link>
              </p>
              <div className="pt-2 border-t border-[#E5D7CA]/70 dark:border-slate-800 space-y-1">
                <Link
                  href="/about#intellectual-property"
                  className="hover:text-title hover:underline block text-[11px]"
                >
                  Lưu ý về nguồn tài liệu & biên dịch
                </Link>
                <Link
                  href="/profile"
                  className="hover:text-title hover:underline block text-[11px]"
                >
                  Hồ sơ học viên & Tiến độ cá nhân
                </Link>
              </div>
            </div>
          </div>
        </div>

        {/* Bottom Bar: Copyright & Attribution */}
        <div className="pt-6 border-t border-[#E5D7CA]/70 dark:border-slate-800 flex flex-col sm:flex-row items-center justify-between gap-3 text-xs font-serif text-muted">
          <div className="flex items-center gap-2">
            <BrandSymbol size={18} className="opacity-80" />
            <span>{SITE_CONFIG.copyrightNotice}</span>
          </div>
          <div className="flex items-center gap-1 text-[11px]">
            <span>Đồng hành cùng bạn trên từng trang Hán ngữ</span>
            <Heart className="w-3 h-3 text-red-500 fill-red-500 inline-block mx-0.5" />
          </div>
        </div>
      </div>
    </footer>
  )
}

