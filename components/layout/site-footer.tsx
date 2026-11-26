import React from 'react'
import Link from 'next/link'
import { SITE_CONFIG } from '@/lib/site-config'
import { BrandLogo, BrandSymbol } from '@/components/ui/brand-logo'
import { HSK_LEVELS, HSK_RANK_META, getHskDisplayVocabCount } from '@/data/hsk-curriculum'
import { formatNumber } from '@/lib/utils'
import { GraduationCap, Keyboard, Sparkles, Heart } from 'lucide-react'

interface SiteFooterProps {
  liveVocabCounts?: Record<string, number | null> | null
}

export function SiteFooter({ liveVocabCounts }: SiteFooterProps) {
  const hskLevelsList = ([1, 2, 3, 4, 5, 6] as const).map((levelNum) => {
    const info = HSK_LEVELS[levelNum]
    const rank = HSK_RANK_META[levelNum]
    const count = getHskDisplayVocabCount(levelNum, liveVocabCounts)
    return {
      levelNum,
      href: `/topics?q=${encodeURIComponent(info.tag)}`,
      label: `${info.name} · ${info.stage} (${rank.rankShort})`,
      countText: `${formatNumber(count)} từ`,
    }
  })

  return (
    <footer
      className="w-full border-t border-[#E2E8F0] dark:border-[#2D3A56] bg-white/80 dark:bg-[#182238]/90 backdrop-blur-md select-none transition-colors mt-8 md:mt-14"
      role="contentinfo"
      aria-label="Thông tin bản quyền và tác giả"
    >
      {/* Một Footer duy nhất (Single Unified Responsive Footer) tránh trùng lặp DOM giữa Mobile & Desktop */}
      <div className="w-[92%] max-w-[1536px] 2xl:max-w-[1640px] mx-auto px-2 sm:px-4 lg:px-6 2xl:px-8 pt-8 md:pt-12 pb-[max(5.5rem,calc(4.75rem+env(safe-area-inset-bottom,0px)))] md:pb-10 space-y-6 md:space-y-8">
        
        {/* Main Responsive Grid: 1 cột mobile -> 2 cột tablet -> 4 cột desktop */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 md:gap-8">
          
          {/* Col 1: Brand & Story (Hiển thị duy nhất 1 BrandLogo trên toàn trang Footer) */}
          <div className="space-y-3 flex flex-col items-center text-center md:items-start md:text-left">
            <BrandLogo variant="horizontal" size="md" compactOnMobile />
            <p className="text-xs font-serif text-muted leading-relaxed max-w-xs md:max-w-none">
              Không gian học Hán ngữ hiện đại, mài mực luyện nét, ghi nhớ sâu qua từng trang tập ghi và phản xạ gõ phím Pinyin thông minh.
            </p>
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#FAF9F6] dark:bg-[#202B45] border border-[#E2E8F0] dark:border-white/15 text-[11px] font-serif text-[#182238] dark:text-slate-200 shadow-2xs">
              <span className="w-2 h-2 rounded-full bg-[#0D9488] animate-pulse" />
              <span>Tiêu chuẩn HSK 3.0 GF 0025-2021</span>
            </div>
          </div>

          {/* Col 2: Lộ trình HSK & Bộ thủ (Số liệu đồng bộ 100% với Homepage Roadmap) */}
          <div className="space-y-2.5 hidden md:block">
            <h4 className="text-xs font-serif font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200 flex items-center gap-1.5">
              <GraduationCap className="w-3.5 h-3.5 text-[#0D9488]" />
              <span>Lộ trình HSK 3.0</span>
            </h4>
            <ul className="space-y-1.5 text-xs font-serif text-muted">
              {hskLevelsList.map((item) => (
                <li key={item.levelNum}>
                  <Link href={item.href} className="hover:text-[#0D9488] transition-colors flex items-center justify-between gap-2">
                    <span>{item.label}</span>
                    <span className="text-[10px] font-mono opacity-80 shrink-0">{item.countText}</span>
                  </Link>
                </li>
              ))}
              <li>
                <Link href="/radicals" className="hover:text-[#0D9488] transition-colors flex items-center justify-between gap-2">
                  <span>214 Bộ thủ Khang Hy</span>
                  <span className="text-[10px] font-mono opacity-80 shrink-0">17 nét</span>
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 3: Kỹ năng & Luyện tập */}
          <div className="space-y-2.5">
            <h4 className="hidden md:flex text-xs font-serif font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200 items-center gap-1.5">
              <Keyboard className="w-3.5 h-3.5 text-[#0D9488]" />
              <span>Kỹ năng & Luyện tập</span>
            </h4>
            {/* Trên mobile tự chuyển thành các pill liên kết gọn gàng cùng hàng; trên md+ xếp dọc thành cột chuẩn */}
            <ul className="flex flex-wrap items-center justify-center gap-x-3 gap-y-2 md:flex-col md:items-start md:gap-0 md:space-y-1.5 text-xs font-serif text-muted">
              <li className="md:hidden">
                <Link href="/topics" className="hover:text-[#0D9488] transition-colors">
                  Lộ trình HSK
                </Link>
              </li>
              <li>
                <Link href="/vocabulary" className="hover:text-[#0D9488] transition-colors">
                  Từ điển HSK 3.0
                </Link>
              </li>
              <li>
                <Link href="/typing?practice=visual" className="hover:text-[#0D9488] transition-colors">
                  Nghe & Gõ Chữ Hán
                </Link>
              </li>
              <li>
                <Link href="/typing?practice=translate" className="hover:text-[#0D9488] transition-colors">
                  Dịch Việt → Gõ Hán
                </Link>
              </li>
              <li>
                <Link href="/review" className="hover:text-[#0D9488] transition-colors">
                  Ôn tập Spaced Repetition (SM-2)
                </Link>
              </li>
              <li>
                <Link href="/grammar" className="hover:text-[#0D9488] transition-colors">
                  Ngữ pháp hệ thống
                </Link>
              </li>
              <li>
                <Link href="/lessons" className="hover:text-[#0D9488] transition-colors">
                  Bài học ngữ cảnh
                </Link>
              </li>
              <li className="md:hidden">
                <Link href="/radicals" className="hover:text-[#0D9488] transition-colors">
                  214 Bộ thủ
                </Link>
              </li>
              <li>
                <Link href="/write" className="hover:text-[#0D9488] transition-colors">
                  Luyện viết AI
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 4: Thông tin & Tác giả */}
          <div className="space-y-2.5 hidden md:block">
            <h4 className="text-xs font-serif font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200 flex items-center gap-1.5">
              <Sparkles className="w-3.5 h-3.5 text-[#B8322D]" />
              <span>Thông tin & Dự án</span>
            </h4>
            <div className="space-y-2 text-xs font-serif text-muted">
              <p>
                Phát triển với tâm huyết dành cho cộng đồng tự học Hán ngữ Việt Nam.
              </p>
              <p>
                Tác giả: <Link href="/about" className="font-semibold text-[#B8322D] hover:underline">{SITE_CONFIG.developer}</Link>
              </p>
              <div className="pt-2 border-t border-[#E2E8F0] dark:border-slate-800 space-y-1">
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

        {/* Bottom Bar duy nhất: Bản quyền & Tác giả */}
        <div className="pt-5 border-t border-[#E2E8F0] dark:border-slate-800 flex flex-col sm:flex-row items-center justify-between gap-2.5 text-xs font-serif text-muted text-center sm:text-left">
          <div className="flex items-center justify-center sm:justify-start gap-2 flex-wrap">
            <BrandSymbol size={16} className="opacity-85" />
            <span>{SITE_CONFIG.copyrightNotice}</span>
            <span className="md:hidden">•</span>
            <span className="md:hidden">
              Tác giả: <Link href="/about" className="font-semibold text-[#B8322D] hover:underline">{SITE_CONFIG.developer}</Link>
            </span>
          </div>
          <div className="flex items-center gap-1 text-[11px]">
            <span>Đồng hành cùng bạn trên từng trang Hán ngữ</span>
            <Heart className="w-3 h-3 text-[#B8322D] fill-[#B8322D] inline-block mx-0.5" />
          </div>
        </div>
      </div>
    </footer>
  )
}
