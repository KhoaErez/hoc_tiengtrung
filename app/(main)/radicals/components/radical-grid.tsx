'use client'

import { useState, useMemo, useEffect, useRef } from 'react'
import { radicals, searchRadicals, type Radical } from '@/data/radicals'
import RadicalCard from './radical-card'
import {
  Search,
  ArrowUpDown,
  X,
  BookOpen,
  Sparkles,
  Brain,
  Layers,
  LayoutGrid,
  ChevronDown,
  ChevronUp,
  RotateCcw,
  Rows3,
  Grid3X3,
} from 'lucide-react'
import Link from 'next/link'

type SortMode = 'order' | 'strokes'
type FilterMode = 'all' | number
type ViewMode = 'detailed' | 'compact'

export default function RadicalGrid() {
  const [query, setQuery] = useState('')
  const [strokeFilter, setStrokeFilter] = useState<FilterMode>('all')
  const [sortMode, setSortMode] = useState<SortMode>('order')
  const [viewMode, setViewMode] = useState<ViewMode>('detailed')
  const [isMobileGridExpanded, setIsMobileGridExpanded] = useState(false)
  const activeChipRef = useRef<HTMLButtonElement | null>(null)
  const scrollContainerRef = useRef<HTMLDivElement | null>(null)

  // Kiểm tra tham số ?strokes= từ URL nếu có
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const params = new URLSearchParams(window.location.search)
      const strokesParam = params.get('strokes')
      if (strokesParam) {
        const num = parseInt(strokesParam, 10)
        if (num >= 1 && num <= 17) {
          setStrokeFilter(num)
        }
      }
    }
  }, [])

  // Tự động cuộn nút nét đang chọn vào tầm nhìn (trên thiết bị di động cuộn ngang)
  useEffect(() => {
    if (activeChipRef.current && scrollContainerRef.current && !isMobileGridExpanded) {
      activeChipRef.current.scrollIntoView({
        behavior: 'smooth',
        block: 'nearest',
        inline: 'center',
      })
    }
  }, [strokeFilter, isMobileGridExpanded])

  // Tính toán 17 nhóm số nét và số lượng thực tế trực tiếp từ dữ liệu 214 bộ thủ Khang Hy
  const strokeGroupsData = useMemo(() => {
    const counts: Record<number, number> = {}
    for (let i = 1; i <= 17; i++) {
      counts[i] = 0
    }
    radicals.forEach((r) => {
      if (r.strokes >= 1 && r.strokes <= 17) {
        counts[r.strokes] = (counts[r.strokes] || 0) + 1
      }
    })

    return Array.from({ length: 17 }, (_, index) => {
      const strokes = index + 1
      return {
        strokes,
        label: `${strokes} nét`,
        fullTitle: `Bộ thủ ${strokes} nét`,
        count: counts[strokes] || 0,
      }
    })
  }, [])

  // Lọc danh sách bộ thủ theo từ khóa tìm kiếm và số nét
  const filteredRadicals = useMemo(() => {
    let result: Radical[] = query ? searchRadicals(query) : [...radicals]

    if (strokeFilter !== 'all') {
      result = result.filter((r) => r.strokes === strokeFilter)
    }

    if (sortMode === 'strokes') {
      result.sort((a, b) => a.strokes - b.strokes || a.id - b.id)
    } else {
      result.sort((a, b) => a.id - b.id)
    }

    return result
  }, [query, strokeFilter, sortMode])

  // Phân tách các bộ thủ theo từng nhóm số nét
  const [showAllGroups, setShowAllGroups] = useState(false)

  const strokeSections = useMemo(() => {
    const sections: {
      strokes: number
      label: string
      count: number
      radicals: Radical[]
    }[] = []

    // When showing all without search query, limit initial render to top 3 groups (60 cards) to optimize initial DOM
    const maxStrokes = strokeFilter === 'all' && !query && !showAllGroups ? 3 : 17

    const targetStrokes =
      strokeFilter === 'all'
        ? Array.from({ length: maxStrokes }, (_, i) => i + 1)
        : [strokeFilter]

    targetStrokes.forEach((st) => {
      const inGroup = filteredRadicals.filter((r) => r.strokes === st)
      if (inGroup.length > 0 || (query === '' && strokeFilter === st)) {
        sections.push({
          strokes: st,
          label: `${st} nét`,
          count: inGroup.length,
          radicals: inGroup,
        })
      }
    })

    return sections
  }, [filteredRadicals, strokeFilter, query, showAllGroups])

  // Lấy thông tin nhóm nét đang chọn (nếu có)
  const activeGroup = useMemo(() => {
    if (strokeFilter === 'all') return null
    return strokeGroupsData.find((g) => g.strokes === strokeFilter) || null
  }, [strokeFilter, strokeGroupsData])

  const handleSelectGroup = (strokes: FilterMode) => {
    setStrokeFilter(strokes)
  }

  const handleResetFilters = () => {
    setQuery('')
    setStrokeFilter('all')
  }

  return (
    <div className="space-y-6">
      {/* Tiêu đề & Giới thiệu */}
      <div className="space-y-2">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <h1 className="text-2xl md:text-3xl font-serif text-title tracking-tight">
              214 Bộ thủ Khang Hy
            </h1>
            <p className="text-muted font-serif text-sm md:text-base mt-1">
              Phân loại theo 17 nhóm số nét chuẩn, tra cứu chữ Hán theo bộ thủ truyền thống.
            </p>
          </div>

          {/* Các nút học tập nhanh */}
          <div className="flex flex-wrap items-center gap-2">
            <Link
              href="/radicals/flashcard"
              className="flex items-center gap-1.5 px-3.5 py-2 bg-card border border-border rounded-lg text-sm font-serif text-body hover:border-app-accent/50 hover:text-app-accent transition-all shadow-xs"
            >
              <Sparkles className="w-4 h-4 text-app-accent" />
              Flashcard
            </Link>
            <Link
              href="/radicals/quiz"
              className="flex items-center gap-1.5 px-3.5 py-2 bg-card border border-border rounded-lg text-sm font-serif text-body hover:border-app-accent/50 hover:text-app-accent transition-all shadow-xs"
            >
              <Brain className="w-4 h-4 text-gold" />
              Quiz
            </Link>
            <Link
              href="/radicals/progress"
              className="flex items-center gap-1.5 px-3.5 py-2 bg-card border border-border rounded-lg text-sm font-serif text-body hover:border-app-accent/50 hover:text-app-accent transition-all shadow-xs"
            >
              <BookOpen className="w-4 h-4 text-jade" />
              Tiến độ
            </Link>
          </div>
        </div>
      </div>

      {/* Thanh tìm kiếm, tùy chọn sắp xếp & Chế độ xem */}
      <div className="flex flex-col sm:flex-row gap-2">
        {/* Ô tìm kiếm */}
        <div className="flex-1 relative">
          <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-muted" />
          <input
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Tìm theo tên Hán Việt (Nhất, Khẩu, Mộc...), chữ Hán, pinyin hoặc nghĩa..."
            className="w-full pl-10 pr-10 py-2.5 bg-card border border-border rounded-xl text-body placeholder:text-muted text-sm font-serif focus:outline-none focus:border-app-accent shadow-xs transition-colors"
          />
          {query && (
            <button
              onClick={() => setQuery('')}
              className="absolute right-3 top-1/2 -translate-y-1/2 p-1 text-muted hover:text-title transition-colors"
              title="Xóa tìm kiếm"
            >
              <X className="w-4 h-4" />
            </button>
          )}
        </div>

        {/* Nút đổi kiểu sắp xếp */}
        <button
          onClick={() => setSortMode(sortMode === 'order' ? 'strokes' : 'order')}
          className="flex items-center justify-center gap-2 px-3.5 py-2.5 border border-border bg-card rounded-xl text-sm font-serif text-body hover:text-title hover:border-border-strong transition-all shadow-xs flex-shrink-0"
          title="Thay đổi thứ tự hiển thị"
        >
          <ArrowUpDown className="w-4 h-4 text-muted" />
          <span className="hidden md:inline">{sortMode === 'order' ? 'Thứ tự #1 - #214' : 'Theo số nét'}</span>
          <span className="md:hidden">Thứ tự</span>
        </button>

        {/* Tùy chọn chuyển đổi chế độ xem (Chi tiết như ảnh / Lưới gọn) */}
        <div className="flex items-center gap-1 border border-border bg-card rounded-xl p-1 shadow-xs flex-shrink-0">
          <button
            onClick={() => setViewMode('detailed')}
            className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-serif transition-colors ${
              viewMode === 'detailed'
                ? 'bg-page border border-border text-title font-semibold shadow-2xs'
                : 'text-muted hover:text-title'
            }`}
            title="Dạng thẻ chi tiết (phân tách theo số nét như ảnh mẫu)"
          >
            <Rows3 className="w-3.5 h-3.5" />
            <span>Chi tiết</span>
          </button>
          <button
            onClick={() => setViewMode('compact')}
            className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-serif transition-colors ${
              viewMode === 'compact'
                ? 'bg-page border border-border text-title font-semibold shadow-2xs'
                : 'text-muted hover:text-title'
            }`}
            title="Dạng lưới ô vuông gọn"
          >
            <Grid3X3 className="w-3.5 h-3.5" />
            <span>Lưới gọn</span>
          </button>
        </div>
      </div>

      {/* KHUNG PHÂN LOẠI BỘ THỦ THEO SỐ NÉT (17 NHÓM NÚT LỌC) */}
      <div className="bg-card border border-border rounded-xl p-3.5 md:p-4 shadow-xs space-y-3">
        {/* Header khung phân loại */}
        <div className="flex items-center justify-between gap-2">
          <div className="flex items-center gap-2">
            <span className="p-1.5 rounded-md bg-accent-soft text-app-accent flex-shrink-0">
              <Layers className="w-4 h-4" />
            </span>
            <div>
              <h2 className="text-sm md:text-base font-serif font-semibold text-title leading-tight">
                Phân loại theo số nét
              </h2>
              <p className="text-[11px] md:text-xs text-muted font-sans">
                17 nhóm chuẩn Khang Hy • Tổng số {radicals.length} bộ thủ
              </p>
            </div>
          </div>

          <div className="flex items-center gap-1.5">
            {strokeFilter !== 'all' && (
              <button
                onClick={() => setStrokeFilter('all')}
                className="flex items-center gap-1 px-2.5 py-1 text-xs font-serif text-app-accent bg-accent-soft/70 hover:bg-accent-soft rounded-md transition-colors"
                title="Quay lại tất cả bộ thủ"
              >
                <RotateCcw className="w-3 h-3" />
                <span>Xem tất cả</span>
              </button>
            )}

            <button
              onClick={() => setIsMobileGridExpanded(!isMobileGridExpanded)}
              className="sm:hidden flex items-center gap-1 px-2.5 py-1 border border-border text-muted hover:text-title rounded-md text-xs font-serif transition-colors"
              title={isMobileGridExpanded ? 'Thu gọn thành thanh cuộn ngang' : 'Mở rộng 17 nhóm dạng lưới'}
            >
              <LayoutGrid className="w-3 h-3" />
              <span>{isMobileGridExpanded ? 'Cuộn ngang' : 'Xem lưới'}</span>
              {isMobileGridExpanded ? <ChevronUp className="w-3 h-3" /> : <ChevronDown className="w-3 h-3" />}
            </button>
          </div>
        </div>

        {/* Danh sách 18 nút lựa chọn (Tất cả + 17 nhóm nét) */}
        <div
          ref={scrollContainerRef}
          className={`${
            isMobileGridExpanded
              ? 'grid grid-cols-3 sm:grid-cols-6 md:flex md:flex-wrap gap-1.5 md:gap-2'
              : 'flex overflow-x-auto sm:flex-wrap gap-1.5 md:gap-2 pb-1 sm:pb-0 scroll-smooth no-scrollbar'
          }`}
        >
          {/* Nút "Tất cả bộ thủ" */}
          <button
            ref={strokeFilter === 'all' ? activeChipRef : null}
            onClick={() => handleSelectGroup('all')}
            className={`flex-shrink-0 flex items-center justify-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-serif transition-all ${
              strokeFilter === 'all'
                ? 'bg-title text-white font-medium shadow-xs ring-2 ring-title/15'
                : 'bg-page border border-border text-body hover:border-app-accent/50 hover:text-title hover:bg-card'
            }`}
          >
            <span>Tất cả</span>
            <span
              className={`text-[11px] px-1.5 py-0.2 rounded-full font-sans ${
                strokeFilter === 'all' ? 'bg-white/20 text-white' : 'bg-card border border-border/80 text-muted'
              }`}
            >
              {radicals.length}
            </span>
          </button>

          {/* 17 nhóm số nét từ 1 đến 17 */}
          {strokeGroupsData.map((group) => {
            const isSelected = strokeFilter === group.strokes
            return (
              <button
                key={group.strokes}
                ref={isSelected ? activeChipRef : null}
                onClick={() => handleSelectGroup(group.strokes)}
                className={`flex-shrink-0 flex items-center justify-center gap-1.5 px-2.5 py-1.5 rounded-lg text-xs font-serif transition-all ${
                  isSelected
                    ? 'bg-app-accent text-white font-semibold shadow-xs ring-2 ring-app-accent/25 border-transparent'
                    : 'bg-page border border-border text-body hover:border-app-accent/40 hover:text-title hover:bg-card'
                }`}
                title={`Bộ thủ ${group.strokes} nét (${group.count} bộ thủ)`}
              >
                <span>{group.label}</span>
                <span
                  className={`text-[10px] px-1.5 py-0.2 rounded-full font-sans ${
                    isSelected ? 'bg-white/25 text-white font-medium' : 'bg-card border border-border/70 text-muted'
                  }`}
                >
                  {group.count}
                </span>
              </button>
            )
          })}
        </div>
      </div>

      {/* Thanh thông tin trạng thái & kết quả */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pt-1 border-b border-border/60 pb-3">
        <div className="flex flex-wrap items-center gap-2">
          <span className="text-base font-serif font-semibold text-title">
            {activeGroup ? activeGroup.fullTitle : 'Toàn bộ 214 bộ thủ Khang Hy'}
          </span>

          {query && (
            <span className="text-xs font-serif text-muted">
              • Kết quả tìm kiếm cho <strong className="text-title">&quot;{query}&quot;</strong>
            </span>
          )}
        </div>

        <div className="flex items-center gap-3 text-xs md:text-sm text-muted font-serif">
          <span>
            Hiển thị <strong className="text-title">{filteredRadicals.length}</strong> / {radicals.length} bộ thủ
          </span>

          {(strokeFilter !== 'all' || query) && (
            <button
              onClick={handleResetFilters}
              className="text-app-accent hover:text-accent-hover text-xs font-serif underline underline-offset-2 transition-colors"
            >
              Xóa bộ lọc
            </button>
          )}
        </div>
      </div>

      {/* DANH SÁCH BỘ THỦ PHÂN TÁCH THEO TỪNG NHÓM SỐ NÉT (CHUẨN NHƯ ẢNH MẪU) */}
      {strokeSections.length > 0 ? (
        <div className="space-y-8">
          {strokeSections.map((section) => (
            <div key={section.strokes} className="space-y-3.5">
              {/* Tiêu đề nhóm số nét chuẩn như hình mẫu */}
              <div className="flex items-center gap-2 pt-2">
                {/* Tag số nét phong cách mộc/con dấu vàng cam */}
                <div className="inline-flex items-center px-2.5 py-1 rounded-md text-xs md:text-sm font-bold bg-[#F4C963] text-[#4A3206] border border-[#DC9F2E] shadow-2xs">
                  {section.label}
                </div>
                {/* Số lượng bộ thủ trong nhóm */}
                <span className="text-sm md:text-base text-muted font-sans font-medium">
                  {section.count} bộ
                </span>
              </div>

              {/* Lưới hiển thị các thẻ bộ thủ thuộc nhóm số nét này */}
              {viewMode === 'detailed' ? (
                /* Dạng thẻ ngang chi tiết (chuẩn 3 cột như ảnh mẫu) */
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3 md:gap-3.5">
                  {section.radicals.map((radical) => (
                    <RadicalCard
                      key={radical.id}
                      radical={radical}
                      variant="horizontal"
                    />
                  ))}
                </div>
              ) : (
                /* Dạng lưới ô vuông gọn */
                <div className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 lg:grid-cols-6 xl:grid-cols-7 gap-2 md:gap-3">
                  {section.radicals.map((radical) => (
                    <RadicalCard
                      key={radical.id}
                      radical={radical}
                      variant="compact"
                    />
                  ))}
                </div>
              )}
            </div>
          ))}

          {/* Nút mở rộng xem tiếp toàn bộ 17 nhóm nét khi đang ở chế độ xem mặc định */}
          {strokeFilter === 'all' && !query && (
            <div className="flex justify-center pt-4 pb-2">
              <button
                onClick={() => setShowAllGroups(!showAllGroups)}
                className="flex items-center gap-2 px-6 py-3 bg-card border border-border hover:border-app-accent text-body hover:text-title rounded-xl font-serif text-sm transition-all shadow-xs hover:shadow-sm"
              >
                <span>{showAllGroups ? 'Thu gọn về 3 nhóm nét đầu' : 'Xem tiếp các nhóm nét còn lại (4 - 17 nét)'}</span>
                {showAllGroups ? <ChevronUp className="w-4 h-4 text-app-accent" /> : <ChevronDown className="w-4 h-4 text-app-accent" />}
              </button>
            </div>
          )}
        </div>
      ) : (
        /* Trạng thái không có kết quả phù hợp */
        <div className="text-center py-16 px-4 bg-card border border-border rounded-xl space-y-4">
          <div className="text-5xl">🔍</div>
          <div className="space-y-1">
            <h3 className="font-serif text-title text-base md:text-lg font-medium">
              Không tìm thấy bộ thủ nào phù hợp
            </h3>
            <p className="text-muted font-serif text-sm max-w-md mx-auto">
              {query && strokeFilter !== 'all'
                ? `Không có bộ thủ nào khớp với "${query}" trong nhóm ${strokeFilter} nét.`
                : query
                ? `Không tìm thấy bộ thủ nào chứa từ khóa "${query}".`
                : `Không có dữ liệu cho nhóm này.`}
            </p>
          </div>

          <div className="flex flex-wrap justify-center gap-2 pt-2">
            {query && strokeFilter !== 'all' && (
              <button
                onClick={() => setStrokeFilter('all')}
                className="px-4 py-2 bg-card border border-border hover:border-app-accent text-body hover:text-app-accent rounded-lg font-serif text-sm transition-all"
              >
                Tìm trong tất cả 214 bộ thủ
              </button>
            )}
            <button
              onClick={handleResetFilters}
              className="px-4 py-2 bg-title text-white rounded-lg font-serif text-sm hover:opacity-90 transition-all"
            >
              Hiển thị lại tất cả 214 bộ thủ
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
