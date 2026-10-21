'use client'

import React from 'react'

export type MascotState = 'idle' | 'hover' | 'open' | 'thinking' | 'success' | 'error'

interface MascotAvatarProps {
  state?: MascotState
  size?: 'sm' | 'md' | 'lg' | 'xl' | '2xl'
  className?: string
  animated?: boolean
}

/**
 * Mascot Hoạt hình: Gấu Trúc "Tiểu Bút" (Panda Scholar)
 * Thiết kế chuẩn Vector SVG, hỗ trợ 6 trạng thái cảm xúc:
 * - idle: Đứng ôm sổ hiền hòa, chớp mắt nhẹ nhàng.
 * - hover: Ngước nhìn vui mừng, tai giật nhẹ.
 * - open: Vẫy tay chào đón học viên vào phiên hỗ trợ.
 * - thinking: Trầm ngâm suy nghĩ khi đang xử lý dữ liệu.
 * - success: Nụ cười rạng rỡ, hai mắt tít lại ăn mừng.
 * - error: Biểu cảm bối rối nhẹ, an ủi người học.
 */
export function MascotAvatar({
  state = 'idle',
  size = 'md',
  className = '',
  animated = true,
}: MascotAvatarProps) {
  const pixelSizes = {
    sm: 36,
    md: 48,
    lg: 64,
    xl: 96,
    '2xl': 128,
  }

  const px = pixelSizes[size]

  return (
    <div
      style={{ width: px, height: px }}
      className={`relative inline-flex items-center justify-center shrink-0 select-none ${className}`}
      aria-label={`Mascot Tiểu Bút trạng thái ${state}`}
    >
      <svg
        width={px}
        height={px}
        viewBox="0 0 160 160"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        className={`w-full h-full ${animated ? 'mascot-animated' : ''}`}
      >
        {/* Shadow chân mềm mại */}
        <ellipse cx="80" cy="148" rx="42" ry="7" fill="#1C2233" fillOpacity="0.12" />

        {/* 1. HAI TAI GẤU TRÚC (Panda Ears) */}
        {/* Tai trái */}
        <circle
          cx="44"
          cy="42"
          r="20"
          fill="#1C2233"
          className={animated && state === 'hover' ? 'animate-wiggle-left' : ''}
        />
        <circle cx="45" cy="43" r="10" fill="#2A3245" />

        {/* Tai phải */}
        <circle
          cx="116"
          cy="42"
          r="20"
          fill="#1C2233"
          className={animated && state === 'hover' ? 'animate-wiggle-right' : ''}
        />
        <circle cx="115" cy="43" r="10" fill="#2A3245" />

        {/* 2. CHÂN SAU / THÂN DƯỚI (Panda Feet & Body Base) */}
        {/* Chân trái */}
        <circle cx="48" cy="136" r="15" fill="#1C2233" />
        <ellipse cx="48" cy="138" rx="8" ry="6" fill="#4B5569" fillOpacity="0.4" />
        <circle cx="44" cy="130" r="2.5" fill="#4B5569" fillOpacity="0.5" />
        <circle cx="48" cy="128" r="2.5" fill="#4B5569" fillOpacity="0.5" />
        <circle cx="52" cy="130" r="2.5" fill="#4B5569" fillOpacity="0.5" />

        {/* Chân phải */}
        <circle cx="112" cy="136" r="15" fill="#1C2233" />
        <ellipse cx="112" cy="138" rx="8" ry="6" fill="#4B5569" fillOpacity="0.4" />
        <circle cx="108" cy="130" r="2.5" fill="#4B5569" fillOpacity="0.5" />
        <circle cx="112" cy="128" r="2.5" fill="#4B5569" fillOpacity="0.5" />
        <circle cx="116" cy="130" r="2.5" fill="#4B5569" fillOpacity="0.5" />

        {/* Thân gấu trúc (Panda Chubby Belly) */}
        <ellipse cx="80" cy="116" rx="46" ry="34" fill="#FAF7F2" stroke="#1C2233" strokeWidth="3" />

        {/* 3. ĐẦU GẤU TRÚC (Panda Head) */}
        <circle
          cx="80"
          cy="74"
          r="48"
          fill="#FAF7F2"
          stroke="#1C2233"
          strokeWidth="3.5"
          className="transition-transform duration-300"
        />

        {/* Chỏm tóc tơ dễ thương trên đỉnh đầu */}
        <path
          d="M78 26C78 23 80 20 83 23C85 25 83 28 80 27"
          stroke="#1C2233"
          strokeWidth="3"
          strokeLinecap="round"
        />

        {/* 4. VÒNG MẮT ĐEN TRẶC TRƯNG CỦA GẤU TRÚC (Eye Patches) */}
        {/* Đốm đen mắt trái hơi nghiêng */}
        <ellipse
          cx="58"
          cy="73"
          rx="14"
          ry="17"
          transform="rotate(-14 58 73)"
          fill="#1C2233"
        />
        {/* Đốm đen mắt phải hơi nghiêng */}
        <ellipse
          cx="102"
          cy="73"
          rx="14"
          ry="17"
          transform="rotate(14 102 73)"
          fill="#1C2233"
        />

        {/* Má hồng hào tươi tắn (Blush Cheeks) */}
        <circle cx="43" cy="85" r="7" fill="#FFAAA6" fillOpacity="0.75" />
        <circle cx="117" cy="85" r="7" fill="#FFAAA6" fillOpacity="0.75" />

        {/* 5. BIỂU CẢM ĐÔI MẮT THEO TRẠNG THÁI (State-driven Eyes) */}
        {state === 'idle' && (
          <>
            {/* Mắt to tròn long lanh */}
            <circle cx="59" cy="74" r="7" fill="#FFFFFF" />
            <circle cx="60" cy="74" r="5" fill="#1C2233" />
            <circle cx="61.5" cy="72" r="2.2" fill="#FFFFFF" />
            <circle cx="58" cy="76" r="1.2" fill="#FFFFFF" />

            <circle cx="101" cy="74" r="7" fill="#FFFFFF" />
            <circle cx="100" cy="74" r="5" fill="#1C2233" />
            <circle cx="98.5" cy="72" r="2.2" fill="#FFFFFF" />
            <circle cx="102" cy="76" r="1.2" fill="#FFFFFF" />
          </>
        )}

        {state === 'hover' && (
          <>
            {/* Mắt lấp lánh hình ngôi sao vui vẻ */}
            <circle cx="59" cy="72" r="7.5" fill="#FFFFFF" />
            <circle cx="59" cy="72" r="5.5" fill="#1C2233" />
            <circle cx="61" cy="70" r="3" fill="#FFFFFF" />

            <circle cx="101" cy="72" r="7.5" fill="#FFFFFF" />
            <circle cx="101" cy="72" r="5.5" fill="#1C2233" />
            <circle cx="99" cy="70" r="3" fill="#FFFFFF" />
          </>
        )}

        {state === 'open' && (
          <>
            {/* Mắt cười cung tròn tít lại híp mí chào đón (^ _ ^) */}
            <path
              d="M51 76C55 69 64 69 68 76"
              stroke="#FFFFFF"
              strokeWidth="3.5"
              strokeLinecap="round"
            />
            <path
              d="M92 76C96 69 105 69 109 76"
              stroke="#FFFFFF"
              strokeWidth="3.5"
              strokeLinecap="round"
            />
          </>
        )}

        {state === 'thinking' && (
          <>
            {/* Mắt nhìn ngước lên suy nghĩ */}
            <circle cx="59" cy="72" r="7" fill="#FFFFFF" />
            <circle cx="59" cy="69" r="4.5" fill="#1C2233" />
            <circle cx="61" cy="67.5" r="2" fill="#FFFFFF" />

            <circle cx="101" cy="72" r="7" fill="#FFFFFF" />
            <circle cx="101" cy="69" r="4.5" fill="#1C2233" />
            <circle cx="103" cy="67.5" r="2" fill="#FFFFFF" />
          </>
        )}

        {state === 'success' && (
          <>
            {/* Mắt cười rạng rỡ hình chữ V ngược tinh nghịch */}
            <path
              d="M52 74L60 67L67 74"
              stroke="#FFFFFF"
              strokeWidth="3.5"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
            <path
              d="M93 74L101 67L108 74"
              stroke="#FFFFFF"
              strokeWidth="3.5"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
          </>
        )}

        {state === 'error' && (
          <>
            {/* Mắt bối rối ngơ ngác đáng yêu */}
            <ellipse cx="59" cy="73" rx="6" ry="4" fill="#FFFFFF" />
            <circle cx="59" cy="73" r="3" fill="#1C2233" />

            <ellipse cx="101" cy="73" rx="6" ry="4" fill="#FFFFFF" />
            <circle cx="101" cy="73" r="3" fill="#1C2233" />

            {/* Giọt mồ hôi nhỏ ngượng ngùng màu xanh lam nhạt */}
            <path
              d="M120 54C120 58 116 63 116 63C116 63 112 58 112 54C112 51.5 113.8 49.5 116 49.5C118.2 49.5 120 51.5 120 54Z"
              fill="#38BDF8"
            />
          </>
        )}

        {/* 6. MŨI VÀ MIỆNG (Nose & Mouth) */}
        {/* Mũi hình tam giác ngược bo tròn */}
        <path
          d="M76 80C76 78.5 77.5 77 80 77C82.5 77 84 78.5 84 80C84 83 81.5 84.5 80 84.5C78.5 84.5 76 83 76 80Z"
          fill="#1C2233"
        />

        {/* Nụ cười mỉm đáng yêu */}
        {state === 'open' || state === 'success' ? (
          /* Miệng cười mở rộng hào hứng */
          <path
            d="M74 85C74 91 86 91 86 85"
            stroke="#1C2233"
            strokeWidth="2.5"
            strokeLinecap="round"
            fill="#E11D48"
          />
        ) : state === 'thinking' ? (
          /* Miệng chúm chím suy nghĩ */
          <circle cx="80" cy="88" r="2.5" fill="#1C2233" />
        ) : (
          /* Miệng mèo mỉm cười nhẹ nhàng */
          <path
            d="M74 85C77 87 79 87 80 85C81 87 83 87 86 85"
            stroke="#1C2233"
            strokeWidth="2.5"
            strokeLinecap="round"
          />
        )}

        {/* 7. CHIẾC KHĂN QUÀNG ĐỎ ĐẶC TRƯNG (Red Scarf of Scholar) */}
        {/* Vòng khăn ôm cổ */}
        <path
          d="M48 94C56 99 104 99 112 94C116 98 114 105 106 107C88 111 72 111 54 107C46 105 44 98 48 94Z"
          fill="#B8312B"
          stroke="#8F2420"
          strokeWidth="1.5"
        />
        {/* Đuôi khăn quàng bay nhẹ sang bên phải */}
        <path
          d="M102 101C108 102 126 103 134 108C136 112 133 118 126 116C118 114 106 111 98 106Z"
          fill="#B8312B"
          className={animated ? 'animate-scarf-wave' : ''}
        />

        {/* 8. TAY VÀ CUỐN SỔ TAY "CHINESE NOTEBOOK" (Hands & Notebook) */}
        {state === 'open' ? (
          <>
            {/* Tay phải vẫy chào mừng */}
            <path
              d="M124 108C132 100 144 88 142 80C140 76 132 78 128 86L120 102"
              stroke="#1C2233"
              strokeWidth="14"
              strokeLinecap="round"
              className={animated ? 'animate-hand-wave' : ''}
            />
            {/* Tay trái ôm sổ */}
            <rect
              x="52"
              y="106"
              width="42"
              height="36"
              rx="6"
              fill="#78350F"
              stroke="#451A03"
              strokeWidth="2"
            />
            <rect x="52" y="106" width="7" height="36" rx="2" fill="#E9C46A" />
            <text x="73" y="129" fill="#E9C46A" fontSize="17" fontWeight="bold" fontFamily="serif" textAnchor="middle">汉</text>
            <circle cx="56" cy="120" r="8" fill="#1C2233" />
          </>
        ) : (
          <>
            {/* Hai tay ôm cuốn sổ tay trước ngực */}
            {/* Cuốn sổ tay Chinese Notebook */}
            <rect
              x="58"
              y="105"
              width="44"
              height="38"
              rx="6"
              fill="#78350F"
              stroke="#451A03"
              strokeWidth="2"
            />
            {/* Gáy sách & trang sổ */}
            <rect x="58" y="105" width="8" height="38" rx="2" fill="#E9C46A" />
            <line x1="68" y1="108" x2="68" y2="140" stroke="#FAF7F2" strokeWidth="2" strokeDasharray="3 2" />

            {/* Chữ 汉 vàng kim nổi bật trên bìa sổ */}
            <text
              x="82"
              y="130"
              fill="#E9C46A"
              fontSize="18"
              fontWeight="bold"
              fontFamily="serif"
              textAnchor="middle"
            >
              汉
            </text>

            {/* Tay trái gấu trúc ôm sổ */}
            <circle cx="56" cy="122" r="8.5" fill="#1C2233" />
            {/* Tay phải gấu trúc ôm sổ */}
            <circle cx="104" cy="122" r="8.5" fill="#1C2233" />
          </>
        )}

        {/* 9. HIỆU ỨNG PHỤ THEO TRẠNG THÁI (Floating FX) */}
        {state === 'thinking' && (
          /* 3 chấm tròn suy nghĩ nhấp nháy */
          <g className="animate-pulse">
            <circle cx="128" cy="40" r="3.5" fill="#B8312B" />
            <circle cx="138" cy="32" r="4.5" fill="#B8312B" />
            <circle cx="150" cy="24" r="6" fill="#B8312B" />
          </g>
        )}

        {state === 'success' && (
          /* Ngôi sao lấp lánh ăn mừng */
          <g fill="#E9C46A">
            <path d="M26 32L28 38L34 40L28 42L26 48L24 42L18 40L24 38Z" />
            <path d="M136 28L137.5 32.5L142 34L137.5 35.5L136 40L134.5 35.5L130 34L134.5 32.5Z" />
          </g>
        )}
      </svg>
    </div>
  )
}

export default MascotAvatar
