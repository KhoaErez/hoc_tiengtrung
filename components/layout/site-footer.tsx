import React from 'react'
import Link from 'next/link'
import { SITE_CONFIG } from '@/lib/site-config'
import { BrandSymbol } from '@/components/ui/brand-logo'

export function SiteFooter() {
  return (
    <footer
      className="w-full border-t border-border/50 bg-page/75 backdrop-blur-xs select-none transition-colors"
      role="contentinfo"
      aria-label="Thông tin bản quyền và tác giả"
    >
      {/* 
        Container căn giữa tinh tế.
        Padding:
        - Mobile: pt-6 pb-24 (bù đắp 56px của Bottom Navigation Bar + Safe Area)
        - Desktop (md:): pt-6 pb-6
      */}
      <div className="max-w-4xl mx-auto px-4 sm:px-6 pt-6 pb-24 md:pb-6 text-center space-y-2">
        {/* Brand symbol thu nhỏ trang nhã */}
        <div className="flex items-center justify-center gap-2">
          <BrandSymbol size={22} className="opacity-90" />
          <span className="font-serif font-bold text-xs tracking-wider text-title uppercase">
            {SITE_CONFIG.name}
          </span>
        </div>

        {/* Dòng bản quyền chính thức */}
        <p className="text-xs font-serif text-title/90 tracking-wide">
          <span>{SITE_CONFIG.copyrightNotice}</span>
        </p>

        {/* Dòng ghi nhận tác giả */}
        <p className="text-xs font-serif text-muted">
          <span>Thiết kế & Phát triển bởi </span>
          <Link
            href="/about"
            className="font-medium text-app-accent hover:text-accent-hover hover:underline transition-colors focus:outline-none focus:ring-1 focus:ring-app-accent rounded px-0.5"
            title="Xem thông tin chi tiết về tác giả và dự án"
          >
            {SITE_CONFIG.developer}
          </Link>
        </p>

        {/* Các liên kết phụ trợ */}
        <div className="pt-1 flex items-center justify-center gap-3 text-[11px] font-sans text-muted/80">
          {/* <Link
            href="/about"
            className="hover:text-title hover:underline transition-colors"
          >
            Về Chinese Notebook
          </Link> */}
          <span className="text-border-strong/70" aria-hidden="true">•</span>
          <Link
            href="/about#intellectual-property"
            className="hover:text-title hover:underline transition-colors"
          >
            Tài liệu này được tham khảo và biên dịch với sự hỗ trợ của công cụ trí tuệ nhân tạo nên khó tránh khỏi một số sai sót về ngữ nghĩa. Rất mong nhận được sự thông cảm và những ý kiến đóng góp từ mọi người để nội dung ngày càng hoàn thiện hơn.
          </Link>
        </div>
      </div>
    </footer>
  )
}
