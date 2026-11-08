'use client'

import React from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { 
  PlayCircle, 
  ArrowRight, 
  Compass, 
  BookOpen, 
  Layers, 
  Library, 
  Keyboard, 
  Headphones, 
  RotateCcw,
  Sparkles,
  ChevronDown
} from 'lucide-react'

interface Hero3DSectionProps {
  displayName?: string
  isLoggedIn?: boolean
  recentExerciseTitle?: string | null
  recentExerciseUrl?: string | null
}

export function Hero3DSection({
  displayName,
  isLoggedIn,
  recentExerciseTitle,
  recentExerciseUrl,
}: Hero3DSectionProps) {
  const quickLinks = [
    { label: 'Học HSK', href: '#hanh-trinh-hsk', icon: Compass, color: 'text-amber-600' },
    { label: 'Từ vựng', href: '/vocabulary', icon: Layers, color: 'text-sky-600' },
    { label: 'Ngữ pháp', href: '/grammar', icon: Library, color: 'text-purple-600' },
    { label: 'Luyện đánh máy', href: '/typing', icon: Keyboard, color: 'text-[#B8322D]' },
    { label: 'Luyện nghe & gõ', href: '/typing?mode=listen', icon: Headphones, color: 'text-indigo-600' },
    { label: 'Ôn tập thẻ nhớ', href: '/review', icon: RotateCcw, color: 'text-emerald-600' },
  ]

  const indicators = [
    { num: '01', label: 'Bắt đầu', href: '#hero' },
    { num: '02', label: 'Hành trình HSK', href: '#hanh-trinh-hsk' },
    { num: '03', label: 'Thư viện', href: '#thu-vien' },
    { num: '04', label: 'Luyện tập', href: '#luyen-tap' },
  ]

  return (
    <section 
      id="hero"
      aria-label="Khu vực khởi đầu hành trình"
      className="relative w-full min-h-[520px] sm:min-h-[600px] md:min-h-[82vh] rounded-3xl overflow-hidden border-2 border-[#182238] dark:border-[#384869] shadow-[0_6px_0_#182238] dark:shadow-[0_6px_0_#0D1322] flex flex-col justify-between p-3.5 sm:p-7 md:p-10 mb-6"
    >
      {/* 1. HÌNH ẢNH MINH HỌA 3D CHINESE FANTASY LANDSCAPE */}
      <div className="absolute inset-0 z-0">
        <Image
          src="/images/hero/hero-3d-landscape.webp"
          alt="Phong cảnh 3D núi non Trung Hoa, biển mây và cầu đá dẫn lối học vấn"
          fill
          priority
          sizes="(max-width: 1280px) 100vw, 1280px"
          className="object-cover object-center select-none"
        />

        {/* Lớp phủ điện ảnh: Tăng độ tương phản cho khung nổi bên trái & giữ sáng ánh bình minh bên phải */}
        <div className="absolute inset-0 bg-gradient-to-r from-[#FAF7F2]/90 via-[#FAF7F2]/50 to-transparent dark:from-[#182238]/95 dark:via-[#182238]/60 dark:to-transparent" />
        <div className="absolute inset-0 bg-gradient-to-t from-[#FAF7F2]/95 via-transparent to-black/10 dark:from-[#182238] dark:via-transparent" />
      </div>

      {/* 2. KHUNG THÔNG TIN NỔI BÊN TRÁI (FLOATING INFORMATION PANEL) */}
      <div className="relative z-10 max-w-lg w-full rounded-2xl sm:rounded-3xl bg-[#FAF7F2]/95 dark:bg-[#182238]/95 backdrop-blur-xl border-2 border-[#182238] dark:border-[#384869] shadow-[0_6px_0_rgba(24,34,56,0.15)] dark:shadow-[0_6px_0_rgba(0,0,0,0.5)] p-4 sm:p-7 space-y-3.5 sm:space-y-4 animate-in fade-in duration-300">
        
        {/* Step Badge & Mascot Pill */}
        <div className="flex items-center justify-between gap-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/80 dark:bg-[#202B45] border border-[#182238]/20 dark:border-white/20 shadow-2xs">
            <span className="w-2 h-2 rounded-full bg-[#B8322D] animate-ping" />
            <span className="text-[11px] font-sans font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200">
              01 · BẮT ĐẦU HÀNH TRÌNH
            </span>
          </div>

          <div className="flex items-center gap-2 px-2.5 py-1 rounded-full bg-white/90 dark:bg-[#202B45] border border-[#182238]/20 dark:border-white/20 shadow-2xs">
            <div className="relative w-6 h-6 rounded-full overflow-hidden border border-[#182238]/30">
              <Image
                src="/images/panda/panda-welcome.webp"
                alt="Tiểu Bút 🐼"
                fill
                sizes="24px"
                className="object-cover"
              />
            </div>
            <span className="text-[11px] font-serif font-bold text-[#182238] dark:text-slate-200">
              Tiểu Bút 🐼
            </span>
          </div>
        </div>

        {/* Tiêu đề & Giới thiệu */}
        <div className="space-y-2">
          <h1 className="text-2xl sm:text-3xl md:text-[34px] font-serif font-bold text-[#182238] dark:text-white leading-tight tracking-tight">
            Chinh phục tiếng Trung <br />
            <span className="text-[#B8322D]">từng bước vững chắc.</span>
          </h1>
          <p className="text-xs sm:text-sm font-serif text-[#182238]/80 dark:text-slate-300 leading-relaxed">
            Học từ vựng, ngữ pháp và luyện tập theo lộ trình HSK có hệ thống. Kết hợp phản xạ gõ phím Pinyin thực tế và thuật toán ghi nhớ dài hạn SM-2.
          </p>
        </div>

        {/* Các nút truy cập nhanh (Quick Access Pills) */}
        <div className="space-y-1.5 pt-1">
          <span className="text-[10px] font-sans font-bold uppercase text-[#182238]/60 dark:text-slate-400 tracking-wider">
            Các chuyên mục học tập:
          </span>
          <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
            {quickLinks.map((item) => {
              const Icon = item.icon
              return (
                <Link
                  key={item.label}
                  href={item.href}
                  className="flex items-center gap-1.5 p-2 rounded-xl bg-white/70 dark:bg-[#24314E]/70 hover:bg-white dark:hover:bg-[#2D3D60] border border-[#182238]/15 dark:border-white/10 shadow-2xs hover:shadow-xs transition-all text-[11px] font-serif font-medium text-[#182238] dark:text-slate-200 group"
                >
                  <Icon className={`w-3.5 h-3.5 ${item.color} shrink-0 group-hover:scale-110 transition-transform`} />
                  <span className="truncate">{item.label}</span>
                </Link>
              )
            })}
          </div>
        </div>

        {/* CTA chính */}
        <div className="pt-2 flex flex-col sm:flex-row gap-2.5 items-stretch">
          {isLoggedIn && recentExerciseUrl ? (
            <Link href={recentExerciseUrl} className="flex-1">
              <button
                type="button"
                className="w-full py-3 px-5 rounded-2xl bg-[#B8322D] hover:bg-[#9E2A25] active:translate-y-0.5 text-white font-serif font-bold text-xs sm:text-sm shadow-[0_3px_0_#7A1D1A] flex items-center justify-center gap-2 cursor-pointer transition-all"
              >
                <PlayCircle className="w-4 h-4 shrink-0" />
                <span className="truncate">Học tiếp: {recentExerciseTitle || 'Bài gần nhất'}</span>
              </button>
            </Link>
          ) : (
            <Link href="/topics?q=HSK 1" className="flex-1">
              <button
                type="button"
                className="w-full py-3 px-5 rounded-2xl bg-[#B8322D] hover:bg-[#9E2A25] active:translate-y-0.5 text-white font-serif font-bold text-xs sm:text-sm shadow-[0_3px_0_#7A1D1A] flex items-center justify-center gap-2 cursor-pointer transition-all"
              >
                <PlayCircle className="w-4 h-4 shrink-0" />
                <span>Bắt đầu học ngay (HSK 1)</span>
              </button>
            </Link>
          )}

          <Link href="#hanh-trinh-hsk">
            <button
              type="button"
              className="w-full sm:w-auto py-3 px-4 rounded-2xl bg-white dark:bg-[#202B45] hover:bg-[#FAF7F2] dark:hover:bg-[#283657] border-2 border-[#182238] dark:border-[#384869] text-[#182238] dark:text-white font-serif font-semibold text-xs sm:text-sm shadow-[0_3px_0_#182238] dark:shadow-[0_3px_0_#0D1322] active:translate-y-0.5 flex items-center justify-center gap-1.5 cursor-pointer transition-all"
            >
              <span>Xem lộ trình</span>
              <ChevronDown className="w-4 h-4" />
            </button>
          </Link>
        </div>

        {/* Thông tin chào đón cá nhân hóa nếu đã đăng nhập */}
        {isLoggedIn && displayName && (
          <div className="pt-1 flex items-center gap-2 text-[11px] font-serif text-[#182238]/70 dark:text-slate-400 border-t border-[#182238]/10 dark:border-white/10">
            <Sparkles className="w-3.5 h-3.5 text-amber-600" />
            <span>Chào mừng <strong>{displayName}</strong> quay trở lại khám phá bài học!</span>
          </div>
        )}
      </div>

      {/* 3. HERO NAVIGATION / SECTION INDICATORS (Thước đo chuyển động các phân khu) */}
      <div className="relative z-10 hidden sm:flex items-center justify-between pt-6 border-t border-[#182238]/15 dark:border-white/15">
        <div className="flex items-center gap-2 text-xs font-serif text-[#182238] dark:text-slate-300">
          <span className="font-chinese text-base font-bold text-[#B8322D]">书山有路</span>
          <span className="text-[#182238]/50 dark:text-slate-400">· Núi sách có đường, siêng năng làm lối</span>
        </div>

        <div className="flex items-center gap-3">
          {indicators.map((ind, idx) => (
            <Link
              key={ind.num}
              href={ind.href}
              className="flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/80 dark:bg-[#182238]/80 hover:bg-white dark:hover:bg-[#202B45] border border-[#182238]/20 dark:border-white/20 text-xs font-serif text-[#182238] dark:text-slate-200 shadow-2xs transition-all hover:scale-105"
            >
              <span className="text-[10px] font-sans font-bold text-[#B8322D]">{ind.num}</span>
              <span>{ind.label}</span>
            </Link>
          ))}
        </div>
      </div>

      {/* 4. MASCOT COMPANION FLOATING WIDGET (Tiểu Bút 🐼 góc dưới bên phải) */}
      <div className="absolute right-6 bottom-20 z-10 hidden lg:flex items-center gap-3 p-3.5 rounded-3xl bg-[#FAF7F2]/90 dark:bg-[#182238]/90 backdrop-blur-md border-2 border-[#182238] dark:border-[#384869] shadow-[0_4px_0_#182238] dark:shadow-[0_4px_0_#0D1322] animate-in fade-in slide-in-from-bottom-4 duration-500">
        <div className="relative w-14 h-14 rounded-2xl overflow-hidden border-2 border-[#182238]/30 shadow-2xs shrink-0 bg-white">
          <Image
            src="/images/panda/panda-welcome.webp"
            alt="Tiểu Bút sứ giả học tập"
            fill
            sizes="56px"
            className="object-cover"
          />
        </div>
        <div className="space-y-0.5 pr-2">
          <div className="text-[10px] font-sans font-bold uppercase tracking-wider text-[#B8322D]">
            Sứ giả đồng hành 🐼
          </div>
          <p className="text-xs font-serif font-bold text-[#182238] dark:text-white">
            Hôm nay bạn muốn học gì nào?
          </p>
          <div className="flex items-center gap-2 pt-1 text-[11px] font-serif text-[#182238]/70 dark:text-slate-300">
            <Link href="/typing?mode=listen" className="hover:text-[#B8322D] underline font-medium">
              Luyện nghe
            </Link>
            <span>•</span>
            <Link href="/review" className="hover:text-[#B8322D] underline font-medium">
              Ôn thẻ nhớ
            </Link>
          </div>
        </div>
      </div>
    </section>
  )
}

