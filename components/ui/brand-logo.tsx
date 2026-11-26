import React from 'react'
import Link from 'next/link'

interface BrandLogoProps {
  variant?: 'horizontal' | 'symbol' | 'stacked'
  size?: 'xs' | 'sm' | 'md' | 'lg' | 'xl'
  showSubtitle?: boolean
  compactOnMobile?: boolean
  href?: string
  className?: string
  isDark?: boolean
}

/**
 * Biểu tượng "Khai Quyển Hán Tự" (The Hanzi Notebook Seal)
 */
export function BrandSymbol({
  size = 40,
  className = '',
  decorative = false,
}: {
  size?: number
  className?: string
  decorative?: boolean
}) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 120 120"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={`shrink-0 transition-transform duration-200 group-hover:scale-105 select-none ${className}`}
      aria-hidden={decorative || undefined}
      aria-label={decorative ? undefined : 'Biểu tượng Chinese Notebook'}
    >
      <rect x="6" y="6" width="108" height="108" rx="26" fill="#B8312B" />
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
      <path
        d="M26 36C26 33.7909 27.7909 32 30 32H54C56.2091 32 58 33.7909 58 36V84C58 86.2091 56.2091 88 54 88H30C27.7909 88 26 86.2091 26 84V36Z"
        fill="#FAF7F2"
      />
      <path
        d="M62 32C66.5 33 86 35.5 94 40C94 40 94 80 94 88C86 84.5 66.5 82 62 81V32Z"
        fill="#FAF7F2"
        fillOpacity="0.95"
      />
      <rect x="58" y="28" width="4" height="66" rx="2" fill="#E9C46A" />
      <g fill="#B8312B">
        <circle cx="34" cy="45" r="2.2" />
        <circle cx="33" cy="56" r="2.2" />
        <path d="M31.5 71C33 69 35.5 66 37 64.5L38.5 66C37 68 34.5 71.5 33 73L31.5 71Z" />
        <path d="M40 46H52C53 46 53.5 46.5 53 47.5L46.5 57H50C51.5 57 52.5 58 52.5 59.5C51 64 47.5 70 42 74L40.5 72.5C45.5 69 48.5 64 49.5 60H44L40 46Z" />
        <path d="M43 55C46 58 50 64 54 73.5L51.5 75C48 66 44.5 60.5 41.5 57.5L43 55Z" />
      </g>
      <g stroke="#B8312B" strokeOpacity="0.25" strokeWidth="1.5" strokeLinecap="round">
        <line x1="68" y1="46" x2="86" y2="49" />
        <line x1="68" y1="56" x2="88" y2="59" />
        <line x1="68" y1="66" x2="86" y2="69" />
      </g>
    </svg>
  )
}

/**
 * Logo chính thức của ChineseNotebook · Hán Ngữ Tập Ghi (1 instance duy nhất, zero DOM duplication).
 */
export function BrandLogo({
  variant = 'horizontal',
  size = 'md',
  showSubtitle = true,
  compactOnMobile = false,
  href = '/',
  className = '',
  isDark = false,
}: BrandLogoProps) {
  const sizeMap = {
    xs: { symbol: 24, textTitle: 'text-sm', textSub: 'text-[10px]', gap: 'gap-2' },
    sm: { symbol: 32, textTitle: compactOnMobile ? 'text-sm sm:text-base' : 'text-base', textSub: 'text-[10px]', gap: compactOnMobile ? 'gap-2 sm:gap-2.5' : 'gap-2.5' },
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
      <BrandSymbol
        size={currentSize.symbol}
        decorative={variant !== 'symbol'}
        className={compactOnMobile ? 'w-7 h-7 sm:w-8 sm:h-8' : ''}
      />

      {variant !== 'symbol' && (
        <div className={`flex flex-col ${variant === 'stacked' ? 'items-center mt-1' : 'justify-center'}`}>
          <div className="flex items-baseline leading-none">
            <span
              className={`font-serif font-bold tracking-tight transition-colors ${
                currentSize.textTitle
              } ${isDark ? 'text-white' : 'text-title group-hover:text-app-accent'}`}
            >
              Chinese<span className="font-sans font-semibold text-app-accent">Notebook</span>
            </span>
          </div>

          {showSubtitle && (
            <span
              className={`font-sans uppercase tracking-[0.16em] font-medium mt-1 leading-none ${
                compactOnMobile ? 'hidden sm:block' : ''
              } ${currentSize.textSub} ${isDark ? 'text-white/60' : 'text-muted'}`}
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
      <Link
        href={href}
        className="inline-flex cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#0D9488]/40 rounded-xl"
      >
        {content}
      </Link>
    )
  }

  return content
}

export default BrandLogo
