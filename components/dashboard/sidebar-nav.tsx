'use client'

import React, { useState } from 'react'
import Link from 'next/link'
import { usePathname, useSearchParams } from 'next/navigation'
import { 
  Home, 
  BookOpen, 
  Component, 
  Keyboard, 
  BrainCircuit, 
  ShieldCheck, 
  MessageSquare,
  PenTool,
  GraduationCap,
  ChevronDown,
  Sparkles,
  Clock,
  X
} from 'lucide-react'
import { ProtectedLink } from '@/components/protected-link'
import { HSK_AUDIT_DATA } from '@/data/hsk-curriculum'
import { formatNumber } from '@/lib/utils'
import { getLiveVocabCountsAction } from '@/app/actions/vocab-counts'

interface SidebarNavProps {
  isLoggedIn: boolean
  isAdmin?: boolean
  initialVocabCounts?: Record<string, number | null>
}

export function SidebarNav({ isLoggedIn, isAdmin, initialVocabCounts }: SidebarNavProps) {
  const pathname = usePathname() || '/'
  const searchParams = useSearchParams()
  const qParam = searchParams?.get('q')

  // Trạng thái lưu trữ số lượng từ vựng thực tế theo thời gian thực từ Supabase
  const [vocabCounts, setVocabCounts] = useState<Record<string, number | null> | undefined>(initialVocabCounts)
  const [isLoadingCounts, setIsLoadingCounts] = useState<boolean>(!initialVocabCounts)

  // Tải dữ liệu số lượng thực tế nếu chưa có initialVocabCounts (hoặc khi component mount)
  React.useEffect(() => {
    if (!initialVocabCounts) {
      let isMounted = true
      setIsLoadingCounts(true)
      getLiveVocabCountsAction()
        .then((res) => {
          if (isMounted) {
            setVocabCounts(res.counts)
          }
        })
        .catch(() => {
          if (isMounted) {
            setVocabCounts(undefined)
          }
        })
        .finally(() => {
          if (isMounted) setIsLoadingCounts(false)
        })
      return () => { isMounted = false }
    } else {
      setVocabCounts(initialVocabCounts)
    }
  }, [initialVocabCounts])

  // Lắng nghe sự kiện cập nhật từ vựng (ví dụ khi admin mutation xảy ra)
  React.useEffect(() => {
    const handleUpdate = () => {
      getLiveVocabCountsAction().then((res) => {
        setVocabCounts(res.counts)
      }).catch(() => {})
    }
    window.addEventListener('vocab-counts-updated', handleUpdate)
    return () => window.removeEventListener('vocab-counts-updated', handleUpdate)
  }, [])

  // Xác định liệu người dùng có đang ở trong một mục HSK hay không
  const isCurrentlyInHsk = 
    pathname.startsWith('/hsk') || 
    pathname === '/topics' || 
    pathname.startsWith('/topics/')

  // Trạng thái thu gọn/mở rộng nhóm Lộ trình HSK (Khởi tạo mở nếu đang ở trang HSK)
  const [isHskExpanded, setIsHskExpanded] = useState<boolean>(() => isCurrentlyInHsk || true)

  // Trạng thái modal thông báo hoàn thiện nội dung (cho các cấp HSK coming_soon)
  const [comingSoonModal, setComingSoonModal] = useState<{
    title: string
    message: string
  } | null>(null)

  // Nhóm 1: Học tập (Core Learning)
  const coreLearningItems = [
    {
      label: 'Trang chủ',
      href: '/',
      icon: Home,
      isProtected: false,
      isActive: pathname === '/',
    },
    {
      label: 'Chủ đề sưu tầm',
      href: '/lessons',
      icon: BookOpen,
      isProtected: false,
      isActive: pathname === '/lessons' || pathname.startsWith('/lessons/'),
    },
    {
      label: 'Ôn tập thẻ nhớ',
      href: '/review',
      icon: BrainCircuit,
      isProtected: true,
      isActive: pathname === '/review' || pathname.startsWith('/review/'),
    },
  ]

  // Nhóm 2: Lộ trình HSK 3.0 (Số lượng từ thực tế đối soát từ CSDL & Tiêu chuẩn GF 0025-2021)
  const hskStages = [
    {
      stage: 'Sơ cấp (初等)',
      levels: [
        { label: 'HSK 1', level: '1', data: HSK_AUDIT_DATA['HSK 1'] },
        { label: 'HSK 2', level: '2', data: HSK_AUDIT_DATA['HSK 2'] },
        { label: 'HSK 3', level: '3', data: HSK_AUDIT_DATA['HSK 3'] },
      ],
    },
    {
      stage: 'Trung cấp (中等)',
      levels: [
        { label: 'HSK 4', level: '4', data: HSK_AUDIT_DATA['HSK 4'] },
        { label: 'HSK 5', level: '5', data: HSK_AUDIT_DATA['HSK 5'] },
        { label: 'HSK 6', level: '6', data: HSK_AUDIT_DATA['HSK 6'] },
      ],
    },
    {
      stage: 'Cao cấp (高等)',
      levels: [
        { label: 'HSK 7-9', level: '7', data: HSK_AUDIT_DATA['HSK 7-9'] },
      ],
    },
  ]

  const practicalTopics = [
    { label: 'Giao tiếp thực tế', topic: 'Giao tiếp', data: HSK_AUDIT_DATA['Giao tiếp'] },
    { label: 'Tiếng Trung công xưởng', topic: 'Công xưởng', data: HSK_AUDIT_DATA['Công xưởng'] },
  ]

  // Nhóm 3: Công cụ luyện tập (Practice & Tools)
  const practiceTools = [
    {
      label: 'Luyện đánh máy IME',
      href: '/typing',
      icon: Keyboard,
      isProtected: false,
      isActive: pathname === '/typing' || pathname.startsWith('/typing/'),
    },
    {
      label: '214 Bộ thủ Khang Hy',
      href: '/radicals',
      icon: Component,
      isProtected: false,
      isActive: pathname === '/radicals' || pathname.startsWith('/radicals/'),
    },
    {
      label: 'Luyện Viết AI',
      href: '/write',
      icon: PenTool,
      isProtected: false,
      isActive: pathname === '/write' || pathname.startsWith('/write/'),
      badge: 'Sắp ra mắt',
    },
  ]

  // Kiểm tra trạng thái Active của từng mục HSK
  const isHskItemActive = (topic: string) => {
    if (topic.startsWith('HSK ')) {
      const level = topic.replace('HSK ', '').trim()
      if (pathname === `/hsk/${level}` || pathname.startsWith(`/hsk/${level}/`)) {
        return true
      }
      if (pathname === '/topics') {
        if (qParam === topic) return true
        if (!qParam && topic === 'HSK 1') return true
      }
      return false
    }
    if (pathname === '/topics') {
      return qParam === topic
    }
    return false
  }

  // Render navigation item chuẩn hóa
  const renderNavItem = (item: {
    label: string
    href: string
    icon: React.ComponentType<{ className?: string }>
    isProtected: boolean
    isActive: boolean
    badge?: string
  }) => {
    const Icon = item.icon
    const active = item.isActive

    const linkClassName = `flex items-center justify-between gap-2.5 px-3 py-1.5 text-xs sm:text-sm rounded-lg border-l-[3px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none group ${
      active
        ? 'border-app-accent bg-app-accent-soft/80 text-app-accent font-medium shadow-2xs'
        : 'border-transparent text-muted hover:bg-black/[0.03] hover:text-title'
    }`

    const content = (
      <>
        <div className="flex items-center gap-2.5 min-w-0">
          <Icon className={`h-4 w-4 shrink-0 transition-colors ${active ? 'text-app-accent' : 'text-muted group-hover:text-title'}`} />
          <span className="truncate">{item.label}</span>
        </div>
        {item.badge && (
          <span className="text-[10px] font-sans px-1.5 py-0.2 rounded shrink-0 bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20">
            {item.badge}
          </span>
        )}
      </>
    )

    if (item.isProtected) {
      return (
        <ProtectedLink
          key={item.href}
          href={item.href}
          isLoggedIn={isLoggedIn}
          className={linkClassName}
        >
          {content}
        </ProtectedLink>
      )
    }

    return (
      <Link
        key={item.href}
        href={item.href}
        className={linkClassName}
      >
        {content}
      </Link>
    )
  }

  // Hàm hiển thị badge số lượng từ vựng thực tế theo CSDL Supabase
  const renderBadge = (tag: string, defaultStatus?: string) => {
    // 1. Khi đang tải và chưa có dữ liệu: hiển thị skeleton (không giật layout)
    if (isLoadingCounts && !vocabCounts) {
      return (
        <span className="inline-block w-10 h-3.5 bg-black/5 dark:bg-white/10 rounded animate-pulse" />
      )
    }

    const count = vocabCounts ? vocabCounts[tag] : undefined

    // 2. Truy vấn lỗi (null): hiển thị "Chưa tải được", không hiển thị số giả hay 0 từ
    if (count === null) {
      return (
        <span 
          className="text-[10px] font-sans px-1.5 py-0.2 rounded shrink-0 bg-red-500/10 text-red-600 dark:text-red-400 font-medium"
          title="Không thể tải số lượng từ vựng từ cơ sở dữ liệu lúc này"
        >
          Chưa tải được
        </span>
      )
    }

    // 3. Chưa có nội dung hoặc HSK 7-9 (0 từ trong DB): hiển thị "Sắp có"
    if (tag === 'HSK 7-9' || (count === 0 && defaultStatus === 'coming_soon')) {
      return (
        <span className="text-[10px] font-sans px-1.5 py-0.2 rounded shrink-0 bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20">
          Sắp có
        </span>
      )
    }

    // 4. Có số lượng thực tế: hiển thị chính xác số từ thực tế trong Supabase
    if (typeof count === 'number') {
      const active = isHskItemActive(tag)
      return (
        <span className={`text-[10px] font-sans px-1.5 py-0.2 rounded shrink-0 font-medium ${
          active
            ? 'bg-app-accent/15 text-app-accent'
            : 'bg-black/[0.03] text-muted'
        }`}>
          {formatNumber(count)} từ
        </span>
      )
    }

    // Fallback skeleton
    return (
      <span className="inline-block w-10 h-3.5 bg-black/5 dark:bg-white/10 rounded animate-pulse" />
    )
  }

  return (
    <div className="flex-1 overflow-y-auto py-3 px-3 space-y-4 no-scrollbar">
      
      {/* 1. KHU VỰC HỌC TẬP (Core Learning) */}
      <div className="space-y-0.5">
        <div className="px-3 pb-1 text-[10px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
          Học tập
        </div>
        <nav className="space-y-0.5" aria-label="Menu học tập chính">
          {coreLearningItems.map(renderNavItem)}
        </nav>
      </div>

      {/* 2. KHU VỰC LỘ TRÌNH HSK (HSK Curriculum Accordion) */}
      <div className="space-y-0.5 pt-1">
        <button
          type="button"
          onClick={() => setIsHskExpanded((prev) => !prev)}
          className="w-full flex items-center justify-between px-3 py-1 text-[10px] font-semibold uppercase tracking-wider text-muted/70 hover:text-title transition-colors rounded-md group cursor-pointer select-none"
          aria-expanded={isHskExpanded}
        >
          <span className="flex items-center gap-1.5 font-sans">
            <GraduationCap className="w-3.5 h-3.5 text-app-accent" />
            <span>Lộ trình HSK 3.0</span>
          </span>
          <ChevronDown
            className={`w-3.5 h-3.5 text-muted transition-transform duration-200 group-hover:text-title ${
              isHskExpanded ? 'rotate-180' : ''
            }`}
          />
        </button>

        {/* Danh sách HSK 3.0 khi mở Accordion */}
        {isHskExpanded && (
          <nav className="space-y-1.5 pl-1 pt-0.5" aria-label="Danh sách cấp độ HSK 3.0">
            {hskStages.map((stageGroup) => (
              <div key={stageGroup.stage} className="space-y-0.5">
                <div className="px-3 pt-1 pb-0.5 text-[9px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
                  {stageGroup.stage}
                </div>
                {stageGroup.levels.map((hsk) => {
                  const topicName = hsk.label
                  const active = isHskItemActive(topicName)
                  const count = vocabCounts ? vocabCounts[hsk.data.tag] : undefined
                  const isComingSoon = hsk.data.status === 'coming_soon' || (count === 0 && hsk.data.tag === 'HSK 7-9')

                  return (
                    <Link
                      key={topicName}
                      href={`/topics?q=${encodeURIComponent(topicName)}`}
                      onClick={(e) => {
                        if (isComingSoon) {
                          e.preventDefault()
                          setComingSoonModal({
                            title: hsk.label,
                            message: hsk.data.friendlyNotice,
                          })
                        }
                      }}
                      className={`flex items-center justify-between px-3 py-1.5 text-xs rounded-lg border-l-[3px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none ${
                        active
                          ? 'border-app-accent bg-app-accent-soft/80 text-app-accent font-medium shadow-2xs'
                          : 'border-transparent text-body hover:text-app-accent hover:bg-black/[0.03]'
                      }`}
                    >
                      <div className="flex items-center gap-2 min-w-0">
                        <span
                          className={`w-1.5 h-1.5 rounded-full shrink-0 transition-colors ${
                            active ? 'bg-app-accent' : isComingSoon ? 'bg-amber-400' : 'bg-border-strong'
                          }`}
                        />
                        <span className="font-serif font-semibold">{hsk.label}</span>
                      </div>
                      {renderBadge(hsk.data.tag, hsk.data.status)}
                    </Link>
                  )
                })}
              </div>
            ))}

            {/* Chủ đề mở rộng */}
            <div className="pt-1.5 space-y-0.5 border-t border-border/40">
              <div className="px-3 pb-0.5 text-[9px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
                Chuyên đề ứng dụng
              </div>
              {practicalTopics.map((item) => {
                const active = isHskItemActive(item.topic)
                return (
                  <Link
                    key={item.topic}
                    href={`/topics?q=${encodeURIComponent(item.topic)}`}
                    className={`flex items-center justify-between px-3 py-1.5 text-xs rounded-lg border-l-[3px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none ${
                      active
                        ? 'border-app-accent bg-app-accent-soft/80 text-app-accent font-medium shadow-2xs'
                        : 'border-transparent text-body hover:text-app-accent hover:bg-black/[0.03]'
                    }`}
                  >
                    <div className="flex items-center gap-2 min-w-0">
                      <Sparkles className={`w-3 h-3 shrink-0 ${active ? 'text-app-accent' : 'text-muted'}`} />
                      <span className="font-serif truncate">{item.label}</span>
                    </div>
                    {renderBadge(item.topic, item.data.status)}
                  </Link>
                )
              })}
            </div>
          </nav>
        )}
      </div>

      {/* 3. KHU VỰC CÔNG CỤ LUYỆN TẬP (Tools & Practice) */}
      <div className="space-y-0.5 pt-1">
        <div className="px-3 pb-1 text-[10px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
          Công cụ & Kỹ năng
        </div>
        <nav className="space-y-0.5" aria-label="Menu công cụ luyện tập">
          {practiceTools.map(renderNavItem)}
        </nav>
      </div>

      {/* 4. KHU VỰC QUẢN TRỊ VIÊN (Chỉ hiển thị khi có quyền Admin) */}
      {isAdmin && (
        <div className="space-y-0.5 pt-1">
          <div className="px-3 pb-1 text-[10px] font-semibold text-app-accent uppercase tracking-wider font-sans flex items-center gap-1.5">
            <ShieldCheck className="h-3.5 w-3.5 text-app-accent shrink-0" />
            <span>Quản trị hệ thống</span>
          </div>
          <nav className="space-y-0.5" aria-label="Menu quản trị viên">
            <Link
              href="/admin"
              className={`flex items-center gap-2.5 px-3 py-1.5 text-xs sm:text-sm rounded-lg border-l-[3px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none group ${
                pathname === '/admin'
                  ? 'border-app-accent bg-app-accent-soft/80 text-app-accent font-medium shadow-2xs'
                  : 'border-transparent text-body hover:text-app-accent hover:bg-black/[0.03]'
              }`}
            >
              <ShieldCheck className={`h-4 w-4 shrink-0 transition-colors ${pathname === '/admin' ? 'text-app-accent' : 'text-muted group-hover:text-title'}`} />
              <span className="truncate">Phân quyền tài khoản</span>
            </Link>

            <Link
              href="/admin/feedback"
              className={`flex items-center gap-2.5 px-3 py-1.5 text-xs sm:text-sm rounded-lg border-l-[3px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none group ${
                pathname.startsWith('/admin/feedback')
                  ? 'border-app-accent bg-app-accent-soft/80 text-app-accent font-medium shadow-2xs'
                  : 'border-transparent text-body hover:text-app-accent hover:bg-black/[0.03]'
              }`}
            >
              <MessageSquare className={`h-4 w-4 shrink-0 transition-colors ${pathname.startsWith('/admin/feedback') ? 'text-app-accent' : 'text-muted group-hover:text-title'}`} />
              <span className="truncate">Góp ý & Báo lỗi</span>
            </Link>
          </nav>
        </div>
      )}

      {/* 5. MODAL THÔNG BÁO HOÀN THIỆN NỘI DUNG (CHO CẤP HSK COMING_SOON) */}
      {comingSoonModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-xs animate-in fade-in-0 duration-150">
          <div className="bg-card border border-border rounded-2xl max-w-md w-full p-6 shadow-lg space-y-4">
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-amber-500/10 border border-amber-500/20 text-amber-600 flex items-center justify-center shrink-0">
                  <Clock className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="font-serif font-bold text-base text-title">
                    Lộ trình {comingSoonModal.title}
                  </h3>
                  <span className="text-[11px] font-serif text-amber-700 dark:text-amber-400 font-medium">
                    Đang hoàn thiện nội dung
                  </span>
                </div>
              </div>
              <button
                onClick={() => setComingSoonModal(null)}
                className="text-muted hover:text-title p-1 rounded-lg hover:bg-page transition-colors cursor-pointer"
                aria-label="Đóng"
              >
                <X className="w-4 h-4" />
              </button>
            </div>

            <div className="p-3.5 rounded-xl bg-page border border-border/70 text-xs font-serif text-body leading-relaxed space-y-2">
              <p className="font-medium text-title">
                {comingSoonModal.message}
              </p>
              <p className="text-[11px] text-muted">
                Theo tiêu chuẩn HSK 3.0 (GF 0025-2021), khối thi Cao cấp HSK 7–9 gồm 11,092 từ vựng, 3,000 chữ Hán và 572 điểm ngữ pháp. Dữ liệu đang được biên soạn và kiểm duyệt kỹ lưỡng.
              </p>
            </div>

            <div className="flex items-center justify-end gap-2 pt-1">
              <Link 
                href="/topics?q=HSK 1" 
                onClick={() => setComingSoonModal(null)}
                className="px-3.5 py-2 rounded-xl text-xs font-serif border border-border hover:border-title/30 text-title transition-colors"
              >
                Học các cấp HSK 1–6
              </Link>
              <button
                type="button"
                onClick={() => setComingSoonModal(null)}
                className="px-4 py-2 rounded-xl text-xs font-serif font-bold bg-app-accent text-white hover:bg-accent-hover transition-colors shadow-2xs cursor-pointer"
              >
                Đã hiểu
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  )
}

export default SidebarNav
