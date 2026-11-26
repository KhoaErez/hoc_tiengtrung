'use client'

import React from 'react'
import Image from 'next/image'
import Link from 'next/link'
import {
  PlayCircle,
  Sparkles,
  ChevronDown,
  Volume2,
  BookOpenCheck,
  GraduationCap,
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
  const indicators = [
    { num: '01', label: 'Khởi đầu', href: '#hero' },
    { num: '02', label: 'Lộ trình HSK', href: '#hanh-trinh-hsk' },
    { num: '03', label: 'Thư viện', href: '#thu-vien' },
    { num: '04', label: 'Luyện tập', href: '#luyen-tap' },
  ]

  return (
    <section
      id="hero"
      aria-label="Khu vực khởi đầu hành trình"
      className="relative w-full min-h-[480px] sm:min-h-[540px] md:min-h-[76vh] rounded-3xl overflow-hidden border-2 border-[#182238] dark:border-[#384869] shadow-[0_6px_0_#182238] dark:shadow-[0_6px_0_#0D1322] flex flex-col justify-between p-4 sm:p-8 md:p-10 mb-4"
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

        {/* Lớp phủ điện ảnh cân bằng tương phản giữa panel trái và phong cảnh bên phải */}
        <div className="absolute inset-0 bg-gradient-to-r from-[#FAF9F6]/92 via-[#FAF9F6]/55 to-transparent dark:from-[#182238]/95 dark:via-[#182238]/65 dark:to-transparent" />
        <div className="absolute inset-0 bg-gradient-to-t from-[#FAF9F6]/90 via-transparent to-black/10 dark:from-[#182238] dark:via-transparent" />
      </div>

      {/* 2. FLOATING FROSTED GLASS PANEL BÊN TRÁI (TẬP TRUNG CAO, KHÔNG NHIỄU) */}
      <div className="relative z-10 max-w-lg w-full rounded-3xl bg-[#FAF7F2]/95 dark:bg-[#182238]/95 backdrop-blur-xl border border-[#182238]/20 dark:border-[#384869] shadow-[0_12px_36px_rgba(24,34,56,0.12)] p-5 sm:p-7 space-y-5 animate-in fade-in duration-300">
        
        {/* Step Badge */}
        <div className="flex items-center justify-between gap-2">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white dark:bg-[#202B45] border border-[#E2E8F0] dark:border-white/15 shadow-2xs">
            <span className="w-2 h-2 rounded-full bg-[#0D9488] animate-pulse" />
            <span className="text-[11px] font-sans font-bold uppercase tracking-wider text-[#182238] dark:text-slate-200">
              Chuẩn HSK 3.0 · GF 0025-2021
            </span>
          </div>

          <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-[#FEF2F2] dark:bg-[#B8322D]/20 text-[#B8322D] dark:text-red-300 border border-[#B8322D]/20 text-[11px] font-serif font-bold">
            <GraduationCap className="w-3.5 h-3.5" />
            <span>Sơ ➔ Cao cấp</span>
          </span>
        </div>

        {/* Tiêu đề & Giới thiệu ngắn gọn */}
        <div className="space-y-2.5">
          <h1 className="text-2xl sm:text-3xl md:text-[34px] font-serif font-bold text-[#182238] dark:text-white leading-tight tracking-tight">
            Chinh phục tiếng Trung <br />
            <span className="text-[#B8322D]">từng bước vững chắc.</span>
          </h1>
          <p className="text-xs sm:text-sm font-serif text-[#475569] dark:text-slate-300 leading-relaxed line-clamp-2">
            Kết hợp lộ trình HSK 3.0 hệ thống, luyện gõ phím Pinyin chuẩn IME và thuật toán ôn tập ghi nhớ dài hạn SM-2.
          </p>
        </div>

        {/* Clean Interactive Learning Preview Card (Thay cho lưới 6 nút nhỏ rối mắt) */}
        <div className="p-3.5 rounded-2xl bg-white dark:bg-[#1E293B] border border-[#E2E8F0] dark:border-white/10 shadow-2xs flex items-center justify-between gap-3">
          <div className="flex items-center gap-3 min-w-0">
            <div className="w-11 h-11 rounded-xl bg-[#F0FDFA] dark:bg-teal-950/60 border border-[#0D9488]/25 flex items-center justify-center shrink-0">
              <span className="font-hanzi text-2xl font-bold text-[#0D9488]">学</span>
            </div>
            <div className="min-w-0">
              <div className="flex items-center gap-1.5">
                <span className="text-xs font-sans font-bold text-[#B8322D]">xué</span>
                <span className="text-[10px] text-muted">•</span>
                <span className="text-[10px] font-sans font-medium text-muted">HSK 1</span>
              </div>
              <p className="text-xs sm:text-sm font-serif font-bold text-[#182238] dark:text-white truncate">
                Học tập, nghiên cứu tri thức
              </p>
            </div>
          </div>

          <Link
            href="/topics?q=HSK 1"
            className="shrink-0 inline-flex items-center gap-1 px-2.5 py-1.5 rounded-xl bg-[#FAF9F6] dark:bg-[#202B45] hover:bg-[#F0FDFA] border border-[#E2E8F0] text-[11px] font-serif font-bold text-[#0D9488] transition-colors"
            title="Khám phá thẻ học HSK 1"
          >
            <BookOpenCheck className="w-3.5 h-3.5" />
            <span className="hidden sm:inline">Thử ngay</span>
          </Link>
        </div>

        {/* Single Primary CTA */}
        <div className="pt-1 flex flex-col sm:flex-row gap-2.5 items-stretch">
          {isLoggedIn && recentExerciseUrl ? (
            <Link href={recentExerciseUrl} className="flex-1">
              <button
                type="button"
                className="w-full min-h-[48px] py-3 px-5 rounded-xl bg-[#0D9488] hover:bg-[#0F766E] active:translate-y-0.5 text-white font-serif font-bold text-sm shadow-[0_3px_0_#115E59] flex items-center justify-center gap-2 cursor-pointer transition-all"
              >
                <PlayCircle className="w-4 h-4 shrink-0" />
                <span className="truncate">Tiếp tục học: {recentExerciseTitle || 'Bài gần nhất'}</span>
              </button>
            </Link>
          ) : (
            <Link href="/topics?q=HSK 1" className="flex-1">
              <button
                type="button"
                className="w-full min-h-[48px] py-3 px-5 rounded-xl bg-[#0D9488] hover:bg-[#0F766E] active:translate-y-0.5 text-white font-serif font-bold text-sm shadow-[0_3px_0_#115E59] flex items-center justify-center gap-2 cursor-pointer transition-all"
              >
                <PlayCircle className="w-4 h-4 shrink-0" />
                <span>Bắt đầu học HSK 1</span>
              </button>
            </Link>
          )}

          <Link href="#hanh-trinh-hsk">
            <button
              type="button"
              className="w-full sm:w-auto min-h-[48px] py-3 px-4 rounded-xl bg-white dark:bg-[#202B45] hover:bg-[#FAF9F6] dark:hover:bg-[#283657] border border-[#182238]/25 dark:border-[#384869] text-[#182238] dark:text-white font-serif font-semibold text-xs sm:text-sm flex items-center justify-center gap-1.5 cursor-pointer transition-all"
            >
              <span>Xem lộ trình</span>
              <ChevronDown className="w-4 h-4" />
            </button>
          </Link>
        </div>

        {/* Cá nhân hóa gọn khi đã đăng nhập */}
        {isLoggedIn && displayName && (
          <div className="pt-2 flex items-center gap-2 text-xs font-serif text-[#475569] dark:text-slate-400 border-t border-[#E2E8F0] dark:border-white/10">
            <Sparkles className="w-3.5 h-3.5 text-[#0D9488] shrink-0" />
            <span>
              Chào mừng <strong>{displayName}</strong> quay trở lại hành trình Hán ngữ!
            </span>
          </div>
        )}
      </div>

      {/* 3. HERO NAVIGATION / SECTION INDICATORS */}
      <div className="relative z-10 hidden sm:flex items-center justify-between pt-5 border-t border-[#182238]/15 dark:border-white/15">
        <div className="flex items-center gap-2 text-xs font-serif text-[#182238] dark:text-slate-300">
          <span className="font-chinese text-base font-bold text-[#B8322D]">书山有路</span>
          <span className="text-[#182238]/65 dark:text-slate-400">· Núi sách có đường, siêng năng làm lối</span>
        </div>

        <div className="flex items-center gap-2.5">
          {indicators.map((ind) => (
            <Link
              key={ind.num}
              href={ind.href}
              className="flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/85 dark:bg-[#182238]/85 hover:bg-white dark:hover:bg-[#202B45] border border-[#E2E8F0] dark:border-white/15 text-xs font-serif text-[#182238] dark:text-slate-200 shadow-2xs transition-all hover:-translate-y-0.5"
            >
              <span className="text-[10px] font-sans font-bold text-[#0D9488]">{ind.num}</span>
              <span>{ind.label}</span>
            </Link>
          ))}
        </div>
      </div>

      {/* 4. MASCOT COMPANION FLOATING WIDGET (Tiểu Bút 🐼 góc dưới bên phải) */}
      <div className="absolute right-6 bottom-20 z-10 hidden lg:flex items-center gap-3 p-3.5 rounded-3xl bg-[#FAF7F2]/95 dark:bg-[#182238]/95 backdrop-blur-md border-2 border-[#182238] dark:border-[#384869] shadow-[0_4px_0_#182238] dark:shadow-[0_4px_0_#0D1322] animate-in fade-in slide-in-from-bottom-4 duration-500">
        <div className="relative w-14 h-14 rounded-2xl overflow-hidden border border-[#182238]/25 shadow-2xs shrink-0 bg-white">
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
            Tiểu Bút 🐼 Đồng hành
          </div>
          <p className="text-xs font-serif font-bold text-[#182238] dark:text-white">
            Hôm nay bạn muốn luyện gì?
          </p>
          <div className="flex items-center gap-2 pt-1 text-[11px] font-serif text-[#475569] dark:text-slate-300">
            <Link href="/typing?practice=visual&mode=listen" className="hover:text-[#0D9488] underline font-semibold flex items-center gap-1">
              <Volume2 className="w-3 h-3" />
              <span>Nghe & Gõ</span>
            </Link>
            <span>•</span>
            <Link href="/review" className="hover:text-[#0D9488] underline font-semibold">
              Ôn SM-2
            </Link>
          </div>
        </div>
      </div>
    </section>
  )
}
