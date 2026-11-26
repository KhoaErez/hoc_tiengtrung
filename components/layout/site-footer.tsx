import React from 'react'
import Link from 'next/link'
import { SITE_CONFIG } from '@/lib/site-config'
import { BrandLogo, BrandSymbol } from '@/components/ui/brand-logo'
import {
  HSK_CANONICAL_DATA,
  resolveHskVocabCount,
  type HskCanonicalLevelKey,
} from '@/constants/hskData'
import { formatNumber } from '@/lib/utils'
import { GraduationCap, Keyboard, Sparkles, Heart } from 'lucide-react'

interface SiteFooterProps {
  liveVocabCounts?: Record<string, number | null> | null
}

export function SiteFooter({ liveVocabCounts }: SiteFooterProps) {
  const hskLevelsList = ([1, 2, 3, 4, 5, 6, 7] as HskCanonicalLevelKey[]).map((levelNum) => {
    const info = HSK_CANONICAL_DATA[levelNum]
    const count = resolveHskVocabCount(levelNum, liveVocabCounts)
    return {
      levelNum,
      href: `/topics?q=${encodeURIComponent(info.tag)}`,
      label: `${info.name} · ${info.stage} (${info.rankShort})`,
      countText: `${formatNumber(count)} từ`,
    }
  })

  return (
    <footer
      className="w-full border-t border-stone-200 dark:border-[#2D3A56] bg-white/85 dark:bg-[#182238]/90 backdrop-blur-md select-none transition-colors mt-8 md:mt-12"
      role="contentinfo"
      aria-label="Thông tin bản quyền và tác giả"
    >
      {/* Container thẳng trục 100% với PillNavbar & Main Workspace (max-w-[1280px]) */}
      <div className="w-full sm:w-[94%] max-w-[1280px] mx-auto px-3 sm:px-6 pt-6 md:pt-9 pb-[max(5.5rem,calc(4.75rem+env(safe-area-inset-bottom,0px)))] lg:pb-8 space-y-5 md:space-y-7">
        {/* PHIÊN BẢN MOBILE (< 768px): Rút gọn gọn gàng vì điều hướng chính đã nằm ở MobileBottomNav */}
        <div className="md:hidden space-y-3">
          <div className="flex items-center justify-between gap-2">
            <Link href="/" className="inline-flex items-center gap-2 group">
              <BrandSymbol size={24} decorative />
              <div className="leading-tight">
                <span className="font-serif font-bold text-sm text-title group-hover:text-app-accent transition-colors">
                  Chinese<span className="font-sans font-semibold text-app-accent">Notebook</span>
                </span>
                <span className="block text-[10px] font-serif text-muted">Hán Ngữ Tập Ghi</span>
              </div>
            </Link>
            <span className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-200 dark:border-white/15 text-[10px] font-serif text-[#182238] dark:text-slate-200 shrink-0">
              <span className="w-1.5 h-1.5 rounded-full bg-[#0D9488]" />
              <span>HSK 3.0</span>
            </span>
          </div>

          <nav
            aria-label="Liên kết nhanh chân trang di động"
            className="flex flex-wrap items-center gap-x-2.5 gap-y-1.5 text-xs font-serif text-muted"
          >
            <Link href="/about" className="hover:text-[#0D9488] transition-colors">
              Giới thiệu
            </Link>
            <span className="text-stone-300 dark:text-slate-700" aria-hidden="true">•</span>
            <Link href="/vocabulary" className="hover:text-[#0D9488] transition-colors">
              Từ điển HSK 3.0
            </Link>
            <span className="text-stone-300 dark:text-slate-700" aria-hidden="true">•</span>
            <Link href="/about#intellectual-property" className="hover:text-[#0D9488] transition-colors">
              Nguồn tài liệu
            </Link>
            <span className="text-stone-300 dark:text-slate-700" aria-hidden="true">•</span>
            <Link href="/profile" className="hover:text-[#0D9488] transition-colors">
              Hồ sơ
            </Link>
          </nav>

          <p className="text-[11px] font-serif text-muted">
            Phát triển bởi{' '}
            <Link href="/about" className="font-semibold text-[#B8322D] hover:underline">
              {SITE_CONFIG.developer}
            </Link>
          </p>
        </div>

        {/* PHIÊN BẢN WEB DESKTOP/TABLET (>= 768px): Đầy đủ 4 cột trên mọi trang */}
        <div className="hidden md:grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          
          {/* Col 1: Brand & Story */}
          <div className="space-y-3">
            <BrandLogo variant="horizontal" size="md" compactOnMobile />
            <p className="text-xs font-serif text-muted leading-relaxed">
              Không gian học Hán ngữ hiện đại, mài mực luyện nét, ghi nhớ sâu qua từng trang tập ghi và phản xạ gõ phím Pinyin thông minh.
            </p>
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#FAF9F6] dark:bg-[#202B45] border border-[#E2E8F0] dark:border-white/15 text-[11px] font-serif text-[#182238] dark:text-slate-200 shadow-2xs">
              <span className="w-2 h-2 rounded-full bg-[#0D9488] animate-pulse" />
              <span>Tiêu chuẩn HSK 3.0 GF 0025-2021</span>
            </div>
          </div>

          {/* Col 2: Lộ trình HSK & Bộ thủ (Đồng bộ 100% từ constants/hskData.ts) */}
          <div className="space-y-2.5">
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
            <h4 className="text-xs font-serif font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200 flex items-center gap-1.5">
              <Keyboard className="w-3.5 h-3.5 text-[#0D9488]" />
              <span>Kỹ năng & Luyện tập</span>
            </h4>
            <ul className="space-y-1.5 text-xs font-serif text-muted">
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
              <li>
                <Link href="/write" className="hover:text-[#0D9488] transition-colors">
                  Luyện viết AI
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 4: Thông tin & Tác giả */}
          <div className="space-y-2.5">
            <h4 className="text-xs font-serif font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200 flex items-center gap-1.5">
              <Sparkles className="w-3.5 h-3.5 text-[#DC2626]" />
              <span>Thông tin & Dự án</span>
            </h4>
            <div className="space-y-2 text-xs font-serif text-muted">
              <p>
                Phát triển với tâm huyết dành cho cộng đồng tự học Hán ngữ Việt Nam.
              </p>
              <p>
                Tác giả: <Link href="/about" className="font-semibold text-[#DC2626] hover:underline">{SITE_CONFIG.developer}</Link>
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

        {/* Bottom Bar duy nhất */}
        <div className="pt-4 md:pt-5 border-t border-stone-200 dark:border-slate-800 flex flex-col sm:flex-row items-center justify-between gap-2 text-xs font-serif text-muted text-center sm:text-left">
          <div className="flex items-center justify-center sm:justify-start gap-2 flex-wrap">
            <BrandSymbol size={16} decorative className="opacity-85" />
            <span>{SITE_CONFIG.copyrightNotice}</span>
          </div>
          <div className="hidden sm:flex items-center gap-1 text-[11px]">
            <span>Đồng hành cùng bạn trên từng trang Hán ngữ</span>
            <Heart className="w-3 h-3 text-[#DC2626] fill-[#DC2626] inline-block mx-0.5" />
          </div>
        </div>
      </div>
    </footer>
  )
}
