'use client'

import React, { useState, useEffect, useCallback, useId } from 'react'
import Link from 'next/link'
import { usePathname, useSearchParams } from 'next/navigation'
import {
  ChevronDown,
  Clock,
  X,
  ShieldCheck,
} from 'lucide-react'
import { ProtectedLink } from '@/components/protected-link'
import { formatNumber } from '@/lib/utils'
import { getLiveVocabCountsAction } from '@/app/actions/vocab-counts'
import {
  CORE_LEARNING_ITEMS,
  HSK_GROUP_CONFIG,
  HSK_STAGES_CONFIG,
  APPLIED_GROUP_CONFIG,
  APPLIED_ITEMS_CONFIG,
  FOUNDATION_GROUP_CONFIG,
  FOUNDATION_ITEMS_CONFIG,
  TOOLS_GROUP_CONFIG,
  TOOLS_ITEMS_CONFIG,
  ADMIN_ITEMS_CONFIG,
  isNavigationItemActive,
  getActiveGroupId,
  type NavItemConfig,
} from './navigation-config'

interface SidebarNavProps {
  isLoggedIn: boolean
  isAdmin?: boolean
  initialVocabCounts?: Record<string, number | null>
}

export function SidebarNav({ isLoggedIn, isAdmin, initialVocabCounts }: SidebarNavProps) {
  const pathname = usePathname() || '/'
  const searchParams = useSearchParams()
  const qParam = searchParams?.get('q')

  // Unique ID prefix for ARIA attributes
  const accordionId = useId()

  // 1. Trạng thái số lượng từ vựng thực tế theo thời gian thực từ Supabase
  const [vocabCounts, setVocabCounts] = useState<Record<string, number | null> | undefined>(initialVocabCounts)
  const [isLoadingCounts, setIsLoadingCounts] = useState<boolean>(!initialVocabCounts)

  useEffect(() => {
    if (!initialVocabCounts) {
      let isMounted = true
      setIsLoadingCounts(true)
      getLiveVocabCountsAction()
        .then((res) => {
          if (isMounted) setVocabCounts(res.counts)
        })
        .catch(() => {
          if (isMounted) setVocabCounts(undefined)
        })
        .finally(() => {
          if (isMounted) setIsLoadingCounts(false)
        })
      return () => { isMounted = false }
    } else {
      setVocabCounts(initialVocabCounts)
    }
  }, [initialVocabCounts])

  useEffect(() => {
    const handleUpdate = () => {
      getLiveVocabCountsAction().then((res) => {
        setVocabCounts(res.counts)
      }).catch(() => {})
    }
    window.addEventListener('vocab-counts-updated', handleUpdate)
    return () => window.removeEventListener('vocab-counts-updated', handleUpdate)
  }, [])

  // 2. Xác định nhóm active dựa trên URL hiện tại
  const activeGroupId = getActiveGroupId(pathname, qParam)

  // 3. Quản lý trạng thái đóng/mở của 4 nhóm Accordion
  // MẶC ĐỊNH THU GỌN: Chỉ mở nhóm có chứa mục đang được học viên truy cập
  const [expandedGroups, setExpandedGroups] = useState<Record<string, boolean>>(() => ({
    hsk: activeGroupId === 'hsk',
    applied: activeGroupId === 'applied',
    foundation: activeGroupId === 'foundation',
    tools: activeGroupId === 'tools',
  }))

  // Tự động mở nhóm khi học viên chuyển trang đến mục con thuộc nhóm đó
  useEffect(() => {
    if (activeGroupId) {
      setExpandedGroups((prev) => {
        if (!prev[activeGroupId]) {
          return { ...prev, [activeGroupId]: true }
        }
        return prev
      })
    }
  }, [activeGroupId])

  // Hàm toggle nhóm thủ công khi click tiêu đề
  const toggleGroup = useCallback((groupId: string) => {
    setExpandedGroups((prev) => ({
      ...prev,
      [groupId]: !prev[groupId],
    }))
  }, [])

  // 4. Modal thông báo lộ trình đang hoàn thiện (HSK 7–9)
  const [comingSoonModal, setComingSoonModal] = useState<{
    title: string
    message: string
  } | null>(null)

  // 5. Hàm hiển thị badge số lượng từ vựng hoặc nhãn đặc biệt
  const renderBadge = (tag: string, defaultStatus?: string) => {
    if (isLoadingCounts && !vocabCounts) {
      return (
        <span className="inline-block w-10 h-3.5 bg-black/5 dark:bg-white/10 rounded animate-pulse" />
      )
    }

    const count = vocabCounts ? vocabCounts[tag] : undefined

    if (count === null) {
      return (
        <span 
          className="text-[10px] font-sans px-1.5 py-0.5 rounded shrink-0 whitespace-nowrap bg-red-500/10 text-red-600 font-medium"
          title="Không thể tải số lượng từ vựng từ cơ sở dữ liệu lúc này"
        >
          Chưa tải được
        </span>
      )
    }

    if (tag === 'HSK 7-9' || (count === 0 && defaultStatus === 'coming_soon')) {
      return (
        <span className="text-[10px] font-sans px-1.5 py-0.5 rounded shrink-0 whitespace-nowrap bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20">
          Sắp có
        </span>
      )
    }

    if (typeof count === 'number') {
      const active = isNavigationItemActive(pathname, qParam, { topic: tag })
      return (
        <span className={`text-[10px] font-sans px-1.5 py-0.5 rounded shrink-0 whitespace-nowrap font-medium ${
          active
            ? 'bg-app-accent/15 text-app-accent'
            : 'bg-black/[0.03] text-muted'
        }`}>
          {formatNumber(count)} từ
        </span>
      )
    }

    return (
      <span className="inline-block w-10 h-3.5 bg-black/5 dark:bg-white/10 rounded animate-pulse shrink-0 whitespace-nowrap" />
    )
  }

  // 6. Render mục đơn thông thường
  const renderSingleItem = (item: NavItemConfig) => {
    const Icon = item.icon
    const active = isNavigationItemActive(pathname, qParam, item)

    const linkClassName = `flex items-center justify-between gap-2.5 px-3 py-2 text-[13.5px] sm:text-sm font-sans font-medium rounded-xl border-l-[3.5px] min-h-[40px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none group ${
      active
        ? 'border-app-accent bg-[#FFF9F3] dark:bg-[#B8322D]/15 text-app-accent font-semibold shadow-2xs'
        : 'border-transparent text-body hover:bg-black/[0.03] dark:hover:bg-white/[0.04] hover:text-title'
    }`

    const content = (
      <>
        <div className="flex items-center gap-2.5 min-w-0">
          {Icon && (
            <Icon className={`h-4 w-4 shrink-0 transition-colors ${active ? 'text-app-accent' : 'text-muted group-hover:text-title'}`} />
          )}
          <span className="truncate">{item.label}</span>
        </div>
        {item.badge && (
          <span className="text-[10px] font-sans px-1.5 py-0.5 rounded shrink-0 whitespace-nowrap bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20">
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

  return (
    <div className="flex-1 overflow-y-auto py-3 px-3 space-y-3.5 no-scrollbar">
      
      {/* ================================================================== */}
      {/* KHU VỰC TỔNG QUAN (CORE LEARNING) */}
      {/* ================================================================== */}
      <div className="space-y-0.5">
        <div className="px-3 pb-1 text-[10px] font-semibold text-muted/60 uppercase tracking-wider font-sans">
          Tổng quan
        </div>
        <nav className="space-y-0.5" aria-label="Menu tổng quan">
          {CORE_LEARNING_ITEMS.map(renderSingleItem)}
        </nav>
      </div>

      {/* ================================================================== */}
      {/* NHÓM 1: LỘ TRÌNH HSK 3.0 (ACCORDION) */}
      {/* ================================================================== */}
      <div className="space-y-0.5 pt-0.5">
        <button
          id={`${accordionId}-header-hsk`}
          type="button"
          onClick={() => toggleGroup('hsk')}
          className={`w-full flex items-center justify-between px-3 py-2 text-[13px] font-bold font-sans tracking-normal transition-all rounded-xl group cursor-pointer select-none min-h-[40px] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 ${
            expandedGroups.hsk || activeGroupId === 'hsk'
              ? 'text-title bg-black/[0.02] dark:bg-white/[0.03]'
              : 'text-muted/80 hover:text-title hover:bg-black/[0.03] dark:hover:bg-white/[0.04]'
          }`}
          aria-expanded={expandedGroups.hsk}
          aria-controls={`${accordionId}-content-hsk`}
        >
          <span className="flex items-center gap-2 font-sans min-w-0">
            <HSK_GROUP_CONFIG.icon className={`w-4 h-4 shrink-0 transition-colors ${expandedGroups.hsk || activeGroupId === 'hsk' ? 'text-app-accent' : 'text-muted'}`} />
            <span className="font-bold tracking-normal whitespace-nowrap truncate">{HSK_GROUP_CONFIG.title}</span>
          </span>
          <span className="flex items-center gap-1.5 shrink-0 ml-1.5">
            {!expandedGroups.hsk && (
              <span className="text-[10px] font-mono text-muted/70 font-medium px-1.5 py-0.5 rounded bg-black/[0.04] dark:bg-white/[0.06] shrink-0 whitespace-nowrap">
                HSK 1–9
              </span>
            )}
            <ChevronDown
              className={`w-3.5 h-3.5 shrink-0 text-muted transition-transform duration-250 ease-out group-hover:text-title ${
                expandedGroups.hsk ? 'rotate-180 text-app-accent' : ''
              }`}
            />
          </span>
        </button>

        {/* Danh sách cấp độ HSK 1–9 */}
        <div
          id={`${accordionId}-content-hsk`}
          role="region"
          aria-labelledby={`${accordionId}-header-hsk`}
          className={`grid transition-[grid-template-rows,opacity] duration-250 ease-in-out ${
            expandedGroups.hsk ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0 pointer-events-none'
          }`}
        >
          <div className="overflow-hidden">
            <nav className="space-y-1 pl-1 pt-1 pb-1" aria-label="Danh sách cấp độ HSK 3.0">
              {HSK_STAGES_CONFIG.map((stageGroup) => (
                <div key={stageGroup.stage} className="space-y-0.5">
                  <div className="px-3 pt-1 pb-0.5 text-[10px] font-semibold text-muted uppercase tracking-wider font-sans">
                    {stageGroup.stage} ({stageGroup.stageZh})
                  </div>
                  {stageGroup.levels.map((hsk) => {
                    const active = isNavigationItemActive(pathname, qParam, { topic: hsk.topic })
                    const count = vocabCounts ? vocabCounts[hsk.data.tag] : undefined
                    const isComingSoon = hsk.isComingSoon || hsk.data.status === 'coming_soon' || (count === 0 && hsk.data.tag === 'HSK 7-9')

                    return (
                      <Link
                        key={hsk.topic}
                        href={hsk.href}
                        onClick={(e) => {
                          if (isComingSoon) {
                            e.preventDefault()
                            setComingSoonModal({
                              title: hsk.label,
                              message: hsk.data.friendlyNotice,
                            })
                          }
                        }}
                        className={`flex items-center justify-between gap-2 px-3 py-2 text-[13px] sm:text-sm rounded-xl border-l-[3.5px] min-h-[38px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none ${
                          active
                            ? 'border-app-accent bg-[#FFF9F3] dark:bg-[#B8322D]/15 text-app-accent font-semibold shadow-2xs'
                            : 'border-transparent text-body hover:text-title hover:bg-black/[0.03] dark:hover:bg-white/[0.04]'
                        }`}
                      >
                        <div className="flex items-center gap-2 min-w-0">
                          <span
                            className={`w-1.5 h-1.5 rounded-full shrink-0 transition-colors ${
                              active ? 'bg-app-accent' : isComingSoon ? 'bg-amber-400' : 'bg-border-strong'
                            }`}
                          />
                          <span className="font-sans font-medium whitespace-nowrap truncate">{hsk.label}</span>
                        </div>
                        {renderBadge(hsk.data.tag, hsk.data.status)}
                      </Link>
                    )
                  })}
                </div>
              ))}
            </nav>
          </div>
        </div>
      </div>

      {/* ================================================================== */}
      {/* NHÓM 2: GIAO TIẾP & ỨNG DỤNG (ACCORDION) */}
      {/* ================================================================== */}
      <div className="space-y-0.5 pt-0.5">
        <button
          id={`${accordionId}-header-applied`}
          type="button"
          onClick={() => toggleGroup('applied')}
          className={`w-full flex items-center justify-between px-3 py-2 text-[13px] font-bold font-sans tracking-normal transition-all rounded-xl group cursor-pointer select-none min-h-[40px] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 ${
            expandedGroups.applied || activeGroupId === 'applied'
              ? 'text-title bg-black/[0.02] dark:bg-white/[0.03]'
              : 'text-muted/80 hover:text-title hover:bg-black/[0.03] dark:hover:bg-white/[0.04]'
          }`}
          aria-expanded={expandedGroups.applied}
          aria-controls={`${accordionId}-content-applied`}
        >
          <span className="flex items-center gap-2 font-sans min-w-0">
            <APPLIED_GROUP_CONFIG.icon className={`w-4 h-4 shrink-0 transition-colors ${expandedGroups.applied || activeGroupId === 'applied' ? 'text-app-accent' : 'text-muted'}`} />
            <span className="font-bold tracking-normal whitespace-nowrap truncate">{APPLIED_GROUP_CONFIG.title}</span>
          </span>
          <span className="flex items-center gap-1.5 shrink-0 ml-1.5">
            <ChevronDown
              className={`w-3.5 h-3.5 shrink-0 text-muted transition-transform duration-250 ease-out group-hover:text-title ${
                expandedGroups.applied ? 'rotate-180 text-app-accent' : ''
              }`}
            />
          </span>
        </button>

        {/* Danh sách mục con Giao tiếp & Công xưởng */}
        <div
          id={`${accordionId}-content-applied`}
          role="region"
          aria-labelledby={`${accordionId}-header-applied`}
          className={`grid transition-[grid-template-rows,opacity] duration-250 ease-in-out ${
            expandedGroups.applied ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0 pointer-events-none'
          }`}
        >
          <div className="overflow-hidden">
            <nav className="space-y-1 pl-1 pt-1 pb-1" aria-label="Menu giao tiếp & ứng dụng">
              {APPLIED_ITEMS_CONFIG.map((item) => {
                const Icon = item.icon
                const active = isNavigationItemActive(pathname, qParam, item)
                const countTag = item.topic || ''

                return (
                  <Link
                    key={item.href}
                    href={item.href}
                    className={`flex items-center justify-between gap-2 px-3 py-2 text-[13px] sm:text-sm rounded-xl border-l-[3.5px] min-h-[38px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none ${
                      active
                        ? 'border-app-accent bg-[#FFF9F3] dark:bg-[#B8322D]/15 text-app-accent font-semibold shadow-2xs'
                        : 'border-transparent text-body hover:text-title hover:bg-black/[0.03] dark:hover:bg-white/[0.04]'
                    }`}
                  >
                    <div className="flex items-center gap-2 min-w-0">
                      {Icon && (
                        <Icon className={`w-3.5 h-3.5 shrink-0 transition-colors ${active ? 'text-app-accent' : 'text-muted'}`} />
                      )}
                      <span className="font-sans font-medium whitespace-nowrap truncate">{item.label}</span>
                    </div>
                    {item.data && renderBadge(countTag, item.data.status)}
                  </Link>
                )
              })}
            </nav>
          </div>
        </div>
      </div>

      {/* ================================================================== */}
      {/* NHÓM 3: NỀN TẢNG TIẾNG TRUNG (ACCORDION) */}
      {/* ================================================================== */}
      <div className="space-y-0.5 pt-0.5">
        <button
          id={`${accordionId}-header-foundation`}
          type="button"
          onClick={() => toggleGroup('foundation')}
          className={`w-full flex items-center justify-between px-3 py-2 text-[13px] font-bold font-sans tracking-normal transition-all rounded-xl group cursor-pointer select-none min-h-[40px] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 ${
            expandedGroups.foundation || activeGroupId === 'foundation'
              ? 'text-title bg-black/[0.02] dark:bg-white/[0.03]'
              : 'text-muted/80 hover:text-title hover:bg-black/[0.03] dark:hover:bg-white/[0.04]'
          }`}
          aria-expanded={expandedGroups.foundation}
          aria-controls={`${accordionId}-content-foundation`}
        >
          <span className="flex items-center gap-2 font-sans min-w-0">
            <FOUNDATION_GROUP_CONFIG.icon className={`w-4 h-4 shrink-0 transition-colors ${expandedGroups.foundation || activeGroupId === 'foundation' ? 'text-app-accent' : 'text-muted'}`} />
            <span className="font-bold tracking-normal whitespace-nowrap truncate">{FOUNDATION_GROUP_CONFIG.title}</span>
          </span>
          <span className="flex items-center gap-1.5 shrink-0 ml-1.5">
            <ChevronDown
              className={`w-3.5 h-3.5 shrink-0 text-muted transition-transform duration-250 ease-out group-hover:text-title ${
                expandedGroups.foundation ? 'rotate-180 text-app-accent' : ''
              }`}
            />
          </span>
        </button>

        {/* Danh sách mục con Ngữ pháp HSK & 214 Bộ thủ */}
        <div
          id={`${accordionId}-content-foundation`}
          role="region"
          aria-labelledby={`${accordionId}-header-foundation`}
          className={`grid transition-[grid-template-rows,opacity] duration-250 ease-in-out ${
            expandedGroups.foundation ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0 pointer-events-none'
          }`}
        >
          <div className="overflow-hidden">
            <nav className="space-y-1 pl-1 pt-1 pb-1" aria-label="Menu nền tảng tiếng Trung">
              {FOUNDATION_ITEMS_CONFIG.map((item) => {
                const Icon = item.icon
                const active = isNavigationItemActive(pathname, qParam, item)

                return (
                  <Link
                    key={item.href}
                    href={item.href}
                    className={`flex items-center justify-between gap-2 px-3 py-2 text-[13px] sm:text-sm rounded-xl border-l-[3.5px] min-h-[38px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none ${
                      active
                        ? 'border-app-accent bg-[#FFF9F3] dark:bg-[#B8322D]/15 text-app-accent font-semibold shadow-2xs'
                        : 'border-transparent text-body hover:text-title hover:bg-black/[0.03] dark:hover:bg-white/[0.04]'
                    }`}
                  >
                    <div className="flex items-center gap-2 min-w-0">
                      {Icon && (
                        <Icon className={`w-3.5 h-3.5 shrink-0 transition-colors ${active ? 'text-app-accent' : 'text-muted'}`} />
                      )}
                      <span className="font-sans font-medium whitespace-nowrap truncate">{item.label}</span>
                    </div>
                    {item.badge && (
                      <span className={`text-[10px] font-sans px-1.5 py-0.5 rounded font-medium border shrink-0 whitespace-nowrap ${
                        active
                          ? 'bg-app-accent/15 text-app-accent border-app-accent/30'
                          : 'bg-black/[0.03] text-muted border-border/60'
                      }`}>
                        {item.badge}
                      </span>
                    )}
                  </Link>
                )
              })}
            </nav>
          </div>
        </div>
      </div>

      {/* ================================================================== */}
      {/* NHÓM 4: CÔNG CỤ & KỸ NĂNG (ACCORDION) */}
      {/* ================================================================== */}
      <div className="space-y-0.5 pt-0.5">
        <button
          id={`${accordionId}-header-tools`}
          type="button"
          onClick={() => toggleGroup('tools')}
          className={`w-full flex items-center justify-between px-3 py-2 text-[13px] font-bold font-sans tracking-normal transition-all rounded-xl group cursor-pointer select-none min-h-[40px] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 ${
            expandedGroups.tools || activeGroupId === 'tools'
              ? 'text-title bg-black/[0.02] dark:bg-white/[0.03]'
              : 'text-muted/80 hover:text-title hover:bg-black/[0.03] dark:hover:bg-white/[0.04]'
          }`}
          aria-expanded={expandedGroups.tools}
          aria-controls={`${accordionId}-content-tools`}
        >
          <span className="flex items-center gap-2 font-sans min-w-0">
            <TOOLS_GROUP_CONFIG.icon className={`w-4 h-4 shrink-0 transition-colors ${expandedGroups.tools || activeGroupId === 'tools' ? 'text-app-accent' : 'text-muted'}`} />
            <span className="font-bold tracking-normal whitespace-nowrap truncate">{TOOLS_GROUP_CONFIG.title}</span>
          </span>
          <span className="flex items-center gap-1.5 shrink-0 ml-1.5">
            <ChevronDown
              className={`w-3.5 h-3.5 shrink-0 text-muted transition-transform duration-250 ease-out group-hover:text-title ${
                expandedGroups.tools ? 'rotate-180 text-app-accent' : ''
              }`}
            />
          </span>
        </button>

        {/* Danh sách mục con Luyện đánh máy & Luyện Viết AI */}
        <div
          id={`${accordionId}-content-tools`}
          role="region"
          aria-labelledby={`${accordionId}-header-tools`}
          className={`grid transition-[grid-template-rows,opacity] duration-250 ease-in-out ${
            expandedGroups.tools ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0 pointer-events-none'
          }`}
        >
          <div className="overflow-hidden">
            <nav className="space-y-1 pl-1 pt-1 pb-1" aria-label="Menu công cụ & kỹ năng">
              {TOOLS_ITEMS_CONFIG.map((item) => {
                const Icon = item.icon
                const active = isNavigationItemActive(pathname, qParam, item)

                return (
                  <Link
                    key={item.href}
                    href={item.href}
                    className={`flex items-center justify-between gap-2 px-3 py-2 text-[13px] sm:text-sm rounded-xl border-l-[3.5px] min-h-[38px] transition-all duration-150 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-app-accent/40 select-none ${
                      active
                        ? 'border-app-accent bg-[#FFF9F3] dark:bg-[#B8322D]/15 text-app-accent font-semibold shadow-2xs'
                        : 'border-transparent text-body hover:text-title hover:bg-black/[0.03] dark:hover:bg-white/[0.04]'
                    }`}
                  >
                    <div className="flex items-center gap-2 min-w-0">
                      {Icon && (
                        <Icon className={`w-3.5 h-3.5 shrink-0 transition-colors ${active ? 'text-app-accent' : 'text-muted'}`} />
                      )}
                      <span className="font-sans font-medium whitespace-nowrap truncate">{item.label}</span>
                    </div>
                    {item.badge && (
                      <span className="text-[10px] font-sans px-1.5 py-0.5 rounded shrink-0 whitespace-nowrap bg-amber-500/10 text-amber-700 dark:text-amber-400 font-medium border border-amber-500/20">
                        {item.badge}
                      </span>
                    )}
                  </Link>
                )
              })}
            </nav>
          </div>
        </div>
      </div>

      {/* ================================================================== */}
      {/* KHU VỰC QUẢN TRỊ VIÊN (CHỈ HIỂN THỊ KHI CÓ QUYỀN ADMIN) */}
      {/* ================================================================== */}
      {isAdmin && (
        <div className="space-y-0.5 pt-1 border-t border-border/40">
          <div className="px-3 pb-1 text-[10px] font-semibold text-app-accent uppercase tracking-wider font-sans flex items-center gap-1.5">
            <ShieldCheck className="h-3.5 w-3.5 text-app-accent shrink-0" />
            <span>Quản trị hệ thống</span>
          </div>
          <nav className="space-y-0.5" aria-label="Menu quản trị viên">
            {ADMIN_ITEMS_CONFIG.map(renderSingleItem)}
          </nav>
        </div>
      )}

      {/* ================================================================== */}
      {/* MODAL THÔNG BÁO HOÀN THIỆN NỘI DUNG (CHO CẤP HSK COMING_SOON) */}
      {/* ================================================================== */}
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
                Theo tiêu chuẩn HSK 3.0 (GF 0025-2021), khối thi Cao cấp HSK 7–9 gồm 11.092 từ vựng, 3.000 chữ Hán và 572 điểm ngữ pháp. Dữ liệu đang được biên soạn và kiểm duyệt kỹ lưỡng.
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
