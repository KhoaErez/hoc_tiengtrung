import React from 'react'
import Link from 'next/link'

interface BrandLogoProps {
  variant?: 'horizontal' | 'symbol' | 'stacked'
  size?: 'xs' | 'sm' | 'md' | 'lg' | 'xl'
  showSubtitle?: boolean
  href?: string
  className?: string
  isDark?: boolean
}

/**
 * Biểu tượng Concept 1: "Khai Quyển Hán Tự" (The Hanzi Notebook Seal)
 * Kết hợp giữa: Con dấu triện đỏ Chu Sa + Cuốn sổ tay đang mở trang giấy + Chữ 汉 cách điệu
 */
export function BrandSymbol({
  size = 40,
  className = '',
}: {
  size?: number
  className?: string
}) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 120 120"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={`shrink-0 transition-transform duration-200 group-hover:scale-105 select-none ${className}`}
      aria-label="Biểu tượng Chinese Notebook"
    >
      {/* 1. Nền con dấu triện bo góc mềm mại (Vermilion Seal Background) */}
      <rect
        x="6"
        y="6"
        width="108"
        height="108"
        rx="26"
        fill="#B8312B"
      />
      {/* Viền đôi truyền thống của con dấu quan văn */}
      <rect
        x="11"
        y="11"
        width="98"
        height="98"
        rx="21"
        stroke="#FFFFFF"
        strokeOpacity="0.25"
        strokeWidth="2"
      />

      {/* 2. Cuốn sổ tay mở trang (Open Notebook Stylized Silhouette) */}
      {/* Trang bên trái (Left cover/page) */}
      <path
        d="M26 36C26 33.7909 27.7909 32 30 32H54C56.2091 32 58 33.7909 58 36V84C58 86.2091 56.2091 88 54 88H30C27.7909 88 26 86.2091 26 84V36Z"
        fill="#FAF7F2"
      />
      {/* Trang bên phải lật mở mềm mại (Right turning page) */}
      <path
        d="M62 32C66.5 33 86 35.5 94 40C94 40 94 80 94 88C86 84.5 66.5 82 62 81V32Z"
        fill="#FAF7F2"
        fillOpacity="0.95"
      />
      {/* Gáy sách & dải ruy-băng trang hoàng kim (Golden bookmark ribbon) */}
      <rect x="58" y="28" width="4" height="66" rx="2" fill="#E9C46A" />

      {/* 3. Chữ Hán "汉" (Han) cách điệu thư pháp ở trang chính bên trái */}
      <g fill="#B8312B">
        {/* Bộ chấm Thủy 氵 (Ba chấm nước biểu trưng cho dòng chảy tri thức) */}
        <circle cx="34" cy="45" r="2.2" />
        <circle cx="33" cy="56" r="2.2" />
        <path d="M31.5 71C33 69 35.5 66 37 64.5L38.5 66C37 68 34.5 71.5 33 73L31.5 71Z" />

        {/* Nét Hoành Phẩy và Mác của chữ Hựu 又 (Bộ thân của chữ Hán) */}
        {/* Nét ngang móc (横撇) */}
        <path
          d="M40 46H52C53 46 53.5 46.5 53 47.5L46.5 57H50C51.5 57 52.5 58 52.5 59.5C51 64 47.5 70 42 74L40.5 72.5C45.5 69 48.5 64 49.5 60H44L40 46Z"
        />
        {/* Nét mác (捺) vươn sang trang mở */}
        <path
          d="M43 55C46 58 50 64 54 73.5L51.5 75C48 66 44.5 60.5 41.5 57.5L43 55Z"
        />
      </g>

      {/* 4. Dòng kẻ vở mini tượng trưng cho Notebook ở trang phải */}
      <g stroke="#B8312B" strokeOpacity="0.25" strokeWidth="1.5" strokeLinecap="round">
        <line x1="68" y1="46" x2="86" y2="49" />
        <line x1="68" y1="56" x2="88" y2="59" />
        <line x1="68" y1="66" x2="86" y2="69" />
      </g>
    </svg>
  )
}

/**
 * Component Logo chính của Chinese Notebook
 * Hỗ trợ đa dạng biến thể:
 * - horizontal: Dùng cho Header Desktop Sidebar & Header Mobile.
 * - symbol: Chỉ biểu tượng (Dùng cho Favicon, Avatar, Mini header).
 * - stacked: Dùng cho Splash Screen, Auth Modal hoặc Footer.
 */
export function BrandLogo({
  variant = 'horizontal',
  size = 'md',
  showSubtitle = true,
  href = '/',
  className = '',
  isDark = false,
}: BrandLogoProps) {
  const sizeMap = {
    xs: { symbol: 24, textTitle: 'text-sm', textSub: 'text-[9px]', gap: 'gap-2' },
    sm: { symbol: 32, textTitle: 'text-base', textSub: 'text-[10px]', gap: 'gap-2.5' },
    md: { symbol: 40, textTitle: 'text-lg', textSub: 'text-[11px]', gap: 'gap-3' },
    lg: { symbol: 48, textTitle: 'text-xl', textSub: 'text-xs', gap: 'gap-3.5' },
    xl: { symbol: 64, textTitle: 'text-2xl', textSub: 'text-sm', gap: 'gap-4' },
  }

  const currentSize = sizeMap[size]

  const content = (
    <div
      className={`inline-flex items-center group select-none transition-opacity hover:opacity-95 ${
        variant === 'stacked' ? 'flex-col text-center' : 'flex-row'
      } ${currentSize.gap} ${className}`}
    >
      {/* 1. Biểu tượng Khai Quyển Hán Tự */}
      <BrandSymbol size={currentSize.symbol} />

      {/* 2. Cụm chữ Typography (nếu không phải chỉ hiện symbol) */}
      {variant !== 'symbol' && (
        <div className={`flex flex-col ${variant === 'stacked' ? 'items-center mt-1' : 'justify-center'}`}>
          <div className="flex items-baseline gap-1.5 leading-none">
            <span
              className={`font-serif font-bold tracking-tight transition-colors ${
                currentSize.textTitle
              } ${isDark ? 'text-white' : 'text-title group-hover:text-app-accent'}`}
            >
              Chinese
            </span>
            <span
              className={`font-sans font-semibold tracking-wide ${
                currentSize.textTitle
              } text-app-accent`}
            >
              Notebook
            </span>
          </div>

          {showSubtitle && (
            <span
              className={`font-sans uppercase tracking-[0.2em] font-medium mt-1 leading-none ${
                currentSize.textSub
              } ${isDark ? 'text-white/60' : 'text-muted'}`}
            >
              Hán Ngữ Tập Ghi
            </span>
          )}
        </div>
      )}
    </div>
  )

  if (href) {
    return (
      <Link href={href} className="inline-flex cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 rounded-xl">
        {content}
      </Link>
    )
  }

  return content
}

export default BrandLogo
