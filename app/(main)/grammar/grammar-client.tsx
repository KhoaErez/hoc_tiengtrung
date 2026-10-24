'use client'

import React, { useState, useEffect, useMemo, useCallback, useRef } from 'react'
import { GrammarCard } from '@/components/grammar/grammar-card'
import { CategoryFilter } from '@/components/grammar/category-filter'
import { GrammarStatsHeader } from '@/components/grammar/grammar-stats-header'
import { 
  getGrammarPointsPaginatedAction, 
  type GrammarItemWithExamples, 
  type GrammarCategoryCount 
} from './actions'
import { 
  BookOpen, 
  CheckCircle2, 
  RotateCcw, 
  ChevronLeft, 
  ChevronRight, 
  Loader2 
} from 'lucide-react'
import { toast } from 'sonner'

interface GrammarClientProps {
  initialItems: GrammarItemWithExamples[]
  initialTotalCount?: number
  initialTotalPages?: number
  initialCategories?: GrammarCategoryCount[]
  initialLevel?: string
  initialPage?: number
  initialCategory?: string
  initialQuery?: string
  initialStatus?: 'all' | 'unmastered' | 'mastered'
  levelCounts?: Record<string, number>
}

const STORAGE_KEY_PREFIX = 'chinese_notebook_mastered_grammar_'
const GRAMMAR_PAGE_SIZE = 10

export function GrammarClient({
  initialItems,
  initialTotalCount = 0,
  initialTotalPages = 1,
  initialCategories = [],
  initialLevel = 'HSK 1',
  initialPage = 1,
  initialCategory = 'all',
  initialQuery = '',
  initialStatus = 'all',
  levelCounts,
}: GrammarClientProps) {
  const [currentLevel, setCurrentLevel] = useState<string>(initialLevel)
  const [items, setItems] = useState<GrammarItemWithExamples[]>(initialItems)
  const [totalCount, setTotalCount] = useState<number>(initialTotalCount || initialItems.length)
  const [totalPages, setTotalPages] = useState<number>(initialTotalPages || 1)
  const [categories, setCategories] = useState<GrammarCategoryCount[]>(initialCategories)
  const [isLoading, setIsLoading] = useState<boolean>(false)
  const [selectedCategory, setSelectedCategory] = useState<string>(initialCategory)
  const [searchQuery, setSearchQuery] = useState<string>(initialQuery)
  const [debouncedQuery, setDebouncedQuery] = useState<string>(initialQuery)
  const [currentPage, setCurrentPage] = useState<number>(initialPage)
  const [masteredFilter, setMasteredFilter] = useState<'all' | 'unmastered' | 'mastered'>(initialStatus)
  const [masteredIndices, setMasteredIndices] = useState<Set<number>>(new Set())

  const isInitialMount = useRef(true)
  const storageKey = `${STORAGE_KEY_PREFIX}${currentLevel.toLowerCase().replace(/\s+/g, '')}`

  // 1. Tải trạng thái các điểm đã thuộc từ localStorage theo từng level
  useEffect(() => {
    try {
      const saved = localStorage.getItem(storageKey)
      if (saved) {
        const arr = JSON.parse(saved)
        if (Array.isArray(arr)) {
          setMasteredIndices(new Set(arr))
          return
        }
      }
      setMasteredIndices(new Set())
    } catch {
      setMasteredIndices(new Set())
    }
  }, [storageKey])

  // 2. Debounce tìm kiếm (300ms)
  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedQuery(searchQuery)
    }, 300)
    return () => clearTimeout(timer)
  }, [searchQuery])

  // 3. Tải dữ liệu phân trang từ Supabase qua Server Action
  const loadData = useCallback(async (opts?: {
    level?: string
    page?: number
    category?: string
    search?: string
    status?: 'all' | 'unmastered' | 'mastered'
  }) => {
    const targetLevel = opts?.level ?? currentLevel
    const targetPage = opts?.page ?? currentPage
    const targetCategory = opts?.category ?? selectedCategory
    const targetSearch = opts?.search ?? debouncedQuery
    const targetStatus = opts?.status ?? masteredFilter

    setIsLoading(true)
    try {
      const res = await getGrammarPointsPaginatedAction({
        level: targetLevel,
        page: targetPage,
        pageSize: GRAMMAR_PAGE_SIZE,
        category: targetCategory,
        search: targetSearch,
        masteredFilter: targetStatus,
        masteredIndices: Array.from(masteredIndices),
      })

      if (res.success) {
        setItems(res.data)
        setTotalCount(res.totalCount)
        setTotalPages(res.totalPages)
        if (res.categories && res.categories.length > 0) {
          setCategories(res.categories)
        }
      } else {
        toast.error(res.error || 'Không thể tải danh sách ngữ pháp')
      }
    } catch (err: any) {
      console.error('Lỗi khi tải điểm ngữ pháp:', err)
      toast.error('Lỗi kết nối khi tải điểm ngữ pháp')
    } finally {
      setIsLoading(false)
    }
  }, [currentLevel, currentPage, selectedCategory, debouncedQuery, masteredFilter, masteredIndices])

  // 4. Kích hoạt fetch khi state thay đổi (bỏ qua lượt mount đầu tiên nếu dùng dữ liệu SSR ban đầu)
  useEffect(() => {
    if (isInitialMount.current) {
      isInitialMount.current = false
      return
    }
    loadData()
  }, [currentLevel, currentPage, selectedCategory, debouncedQuery, masteredFilter, loadData])

  // 5. Đồng bộ query params lên URL mà không reload trang
  useEffect(() => {
    const params = new URLSearchParams()
    if (currentLevel !== 'HSK 1') params.set('level', currentLevel)
    if (currentPage > 1) params.set('page', String(currentPage))
    if (selectedCategory !== 'all') params.set('category', selectedCategory)
    if (debouncedQuery.trim()) params.set('q', debouncedQuery.trim())
    if (masteredFilter !== 'all') params.set('status', masteredFilter)

    const qs = params.toString()
    const newUrl = qs ? `/grammar?${qs}` : '/grammar'
    if (typeof window !== 'undefined') {
      window.history.replaceState(null, '', newUrl)
    }
  }, [currentLevel, currentPage, selectedCategory, debouncedQuery, masteredFilter])

  // 6. Xử lý đổi cấp độ HSK
  const handleSelectLevel = (lvl: string) => {
    if (lvl === currentLevel || isLoading) return
    setCurrentLevel(lvl)
    setSelectedCategory('all')
    setSearchQuery('')
    setDebouncedQuery('')
    setCurrentPage(1)
    setMasteredFilter('all')
  }

  // 7. Lưu trạng thái đã thuộc vào localStorage khi có thay đổi
  const toggleMastered = (orderIndex: number) => {
    setMasteredIndices((prev) => {
      const next = new Set(prev)
      if (next.has(orderIndex)) {
        next.delete(orderIndex)
        toast.info(`Đã bỏ đánh dấu điểm #${orderIndex}`)
      } else {
        next.add(orderIndex)
        toast.success(`Đã đánh dấu thuộc điểm #${orderIndex}!`)
      }
      try {
        localStorage.setItem(storageKey, JSON.stringify(Array.from(next)))
      } catch {
        // Ignored
      }
      return next
    })
  }

  const resetAllProgress = () => {
    if (confirm(`Bạn có chắc chắn muốn đặt lại toàn bộ tiến độ học ngữ pháp ${currentLevel} không?`)) {
      setMasteredIndices(new Set())
      try {
        localStorage.removeItem(storageKey)
        toast.success(`Đã đặt lại tiến độ học ngữ pháp ${currentLevel}!`)
      } catch {
        // Ignored
      }
    }
  }

  const scrollToTopList = useCallback(() => {
    const anchor = document.getElementById('grammar-content-anchor')
    if (anchor) {
      anchor.scrollIntoView({ behavior: 'smooth', block: 'start' })
    }
  }, [])

  const goToPage = (page: number) => {
    if (page < 1 || page > totalPages || page === currentPage || isLoading) return
    setCurrentPage(page)
    scrollToTopList()
  }

  // Tạo danh sách các số trang hiển thị thông minh với dấu ... cho Desktop
  const pageNumbers = useMemo(() => {
    const pages: (number | string)[] = []
    if (totalPages <= 7) {
      for (let i = 1; i <= totalPages; i++) pages.push(i)
    } else {
      pages.push(1)
      if (currentPage > 3) pages.push('...')
      const start = Math.max(2, currentPage - 1)
      const end = Math.min(totalPages - 1, currentPage + 1)
      for (let i = start; i <= end; i++) pages.push(i)
      if (currentPage < totalPages - 2) pages.push('...')
      pages.push(totalPages)
    }
    return pages
  }, [currentPage, totalPages])

  const startIndex = totalCount === 0 ? 0 : (currentPage - 1) * GRAMMAR_PAGE_SIZE + 1
  const endIndex = Math.min(currentPage * GRAMMAR_PAGE_SIZE, totalCount)

  return (
    <div className="space-y-6">
      {/* Header thống kê, cấp độ và tìm kiếm */}
      <GrammarStatsHeader
        totalCount={totalCount}
        masteredCount={masteredIndices.size}
        searchQuery={searchQuery}
        onSearchChange={(q) => {
          setSearchQuery(q)
          setCurrentPage(1)
        }}
        currentLevel={currentLevel}
        onSelectLevel={handleSelectLevel}
        levelCounts={levelCounts}
      />

      {/* Anchor cuộn trang mượt */}
      <div id="grammar-content-anchor" className="scroll-mt-20" />

      {/* Bộ lọc phân loại & Công cụ tiện ích */}
      <div className="space-y-3">
        <div className="flex items-center justify-between flex-wrap gap-2">
          {/* Thanh phân loại cuộn ngang */}
          <div className="w-full sm:w-auto">
            <CategoryFilter
              categories={categories}
              selectedCategory={selectedCategory}
              onSelectCategory={(cat) => {
                setSelectedCategory(cat)
                setCurrentPage(1)
              }}
              totalCount={totalCount}
            />
          </div>

          {/* Quick Toggles: Bộ lọc Đã học / Chưa học & Reset */}
          <div className="flex items-center gap-2 text-xs">
            <button
              type="button"
              onClick={() => {
                setMasteredFilter((prev) => (prev === 'unmastered' ? 'all' : 'unmastered'))
                setCurrentPage(1)
              }}
              className={`px-3.5 py-2 min-h-[44px] rounded-xl border-2 transition-all flex items-center gap-1.5 font-semibold cursor-pointer shadow-2xs ${
                masteredFilter === 'unmastered'
                  ? 'bg-amber-600 border-amber-600 text-white shadow-sm ring-2 ring-amber-500/20'
                  : 'bg-white dark:bg-[#1E2530] border-[#DAC7B6] dark:border-slate-700 text-[#334155] dark:text-[#E2E8F0] hover:border-amber-600 hover:text-amber-700'
              }`}
            >
              <CheckCircle2 className="w-4 h-4" />
              <span>Chưa thuộc</span>
            </button>

            {masteredIndices.size > 0 && (
              <button
                type="button"
                onClick={resetAllProgress}
                title="Đặt lại tiến độ"
                className="p-2.5 min-h-[44px] min-w-[44px] rounded-xl bg-white dark:bg-[#1E2530] border-2 border-[#DAC7B6] dark:border-slate-700 text-[#64748B] hover:text-rose-600 hover:border-rose-400 transition-colors shadow-2xs flex items-center justify-center cursor-pointer"
              >
                <RotateCcw className="w-4 h-4" />
              </button>
            )}
          </div>
        </div>
      </div>

      {/* Hiển thị số lượng kết quả rõ nét & thông tin phân trang */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs sm:text-sm text-[#475569] dark:text-slate-400 px-1 font-medium">
        <div>
          <span>
            Đang hiển thị{' '}
            <strong className="text-[#0F172A] dark:text-white font-bold">
              {startIndex}–{endIndex}
            </strong>{' '}
            trong tổng số <strong className="text-[#0F172A] dark:text-white font-bold">{totalCount}</strong> điểm ngữ pháp
            {selectedCategory !== 'all' && (
              <span> thuộc nhóm <strong className="text-[#B8322D] dark:text-[#E27D60]">{selectedCategory}</strong></span>
            )}
            {debouncedQuery && (
              <span> khớp với &quot;<strong className="text-[#0F172A] dark:text-white">{debouncedQuery}</strong>&quot;</span>
            )}
          </span>
        </div>

        {totalPages > 1 && (
          <div className="text-xs text-muted font-sans shrink-0">
            Trang <strong className="text-title">{currentPage}</strong> / {totalPages} (10 điểm / trang)
          </div>
        )}
      </div>

      {/* Loading Skeleton khi đang fetch dữ liệu phân trang */}
      {isLoading ? (
        <div className="space-y-5">
          {Array.from({ length: 4 }).map((_, idx) => (
            <div
              key={`grammar-skel-${idx}`}
              className="p-5 sm:p-7 rounded-2xl bg-white dark:bg-[#1E2530] border-2 border-[#E9DDD1]/80 dark:border-slate-700/80 animate-pulse space-y-4 min-h-[170px]"
            >
              <div className="flex items-center justify-between gap-3">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-lg bg-muted/20" />
                  <div className="w-48 h-6 bg-muted/20 rounded-md" />
                </div>
                <div className="w-24 h-6 bg-muted/15 rounded-full" />
              </div>
              <div className="w-full h-12 bg-muted/10 rounded-xl" />
              <div className="space-y-2">
                <div className="w-full max-w-xl h-4 bg-muted/20 rounded" />
                <div className="w-3/4 h-3.5 bg-muted/15 rounded" />
              </div>
            </div>
          ))}
        </div>
      ) : items.length > 0 ? (
        <>
          {/* Danh sách thẻ ngữ pháp 10 thẻ / trang */}
          <div className="grid grid-cols-1 gap-5">
            {items.map((item) => (
              <GrammarCard
                key={`${currentLevel}-${item.order_index}`}
                item={item}
                isMastered={masteredIndices.has(item.order_index)}
                onToggleMastered={toggleMastered}
              />
            ))}
          </div>

          {/* Thanh phân trang Pagination Bar (Mobile tối thiểu 44px) */}
          {totalPages > 1 && (
            <div className="mt-8 pt-4 pb-2 border-t border-border/80 flex flex-col sm:flex-row items-center justify-between gap-4">
              <div className="text-xs text-muted font-serif">
                Hiển thị {startIndex}–{endIndex} trong số {totalCount} điểm ({currentLevel})
              </div>

              <div className="flex items-center gap-2 flex-wrap justify-center sm:justify-end">
                {/* Nút Trước (Mobile >= 44px) */}
                <button
                  type="button"
                  onClick={() => goToPage(currentPage - 1)}
                  disabled={currentPage <= 1 || isLoading}
                  className="px-4 py-2.5 min-h-[44px] rounded-xl border border-border bg-card text-title text-xs font-serif font-medium disabled:opacity-30 disabled:cursor-not-allowed hover:border-app-accent hover:text-app-accent active:scale-[0.98] transition-all flex items-center gap-1.5 cursor-pointer touch-manipulation shadow-2xs"
                >
                  <ChevronLeft className="w-4 h-4" />
                  <span>Trước</span>
                </button>

                {/* Nhãn trang trên Mobile */}
                <div className="md:hidden flex items-center px-3 min-h-[44px] text-xs font-mono font-bold text-title">
                  {currentPage} / {totalPages}
                </div>

                {/* Dải số trang đầy đủ trên Desktop */}
                <div className="hidden md:flex items-center gap-1.5">
                  {pageNumbers.map((p, idx) => {
                    if (p === '...') {
                      return (
                        <span key={`dots-${idx}`} className="px-2 py-1 text-xs text-muted select-none">
                          ...
                        </span>
                      )
                    }
                    const num = p as number
                    const isActive = num === currentPage
                    return (
                      <button
                        key={`page-${num}`}
                        type="button"
                        onClick={() => goToPage(num)}
                        disabled={isLoading}
                        className={`min-w-[40px] h-[40px] px-2 rounded-xl text-xs font-mono font-bold transition-all cursor-pointer ${
                          isActive
                            ? 'bg-app-accent text-white shadow-2xs'
                            : 'border border-border/80 bg-page/60 text-muted hover:border-app-accent hover:text-title hover:bg-page'
                        }`}
                      >
                        {num}
                      </button>
                    )
                  })}
                </div>

                {/* Nút Tiếp (Mobile >= 44px) */}
                <button
                  type="button"
                  onClick={() => goToPage(currentPage + 1)}
                  disabled={currentPage >= totalPages || isLoading}
                  className="px-4 py-2.5 min-h-[44px] rounded-xl border border-border bg-card text-title text-xs font-serif font-medium disabled:opacity-30 disabled:cursor-not-allowed hover:border-app-accent hover:text-app-accent active:scale-[0.98] transition-all flex items-center gap-1.5 cursor-pointer touch-manipulation shadow-2xs"
                >
                  <span>Tiếp</span>
                  <ChevronRight className="w-4 h-4" />
                </button>
              </div>
            </div>
          )}
        </>
      ) : (
        /* Empty State */
        <div className="text-center py-16 px-4 rounded-3xl bg-card border border-border/70 space-y-4">
          <div className="w-14 h-14 rounded-2xl bg-muted/20 mx-auto flex items-center justify-center text-muted">
            <BookOpen className="w-7 h-7" />
          </div>
          <div className="space-y-1">
            <h3 className="font-serif font-bold text-title text-base">Không tìm thấy điểm ngữ pháp phù hợp</h3>
            <p className="text-sm text-muted max-w-md mx-auto">
              Không có điểm ngữ pháp nào khớp với điều kiện tìm kiếm hoặc bộ lọc hiện tại. Hãy thử tìm từ khóa khác hoặc xóa bộ lọc.
            </p>
          </div>
          <button
            type="button"
            onClick={() => {
              setSearchQuery('')
              setDebouncedQuery('')
              setSelectedCategory('all')
              setMasteredFilter('all')
              setCurrentPage(1)
            }}
            className="inline-flex items-center gap-2 px-5 py-2.5 min-h-[44px] rounded-xl bg-app-accent text-white text-xs font-semibold shadow-sm hover:bg-app-accent-hover active:scale-[0.98] transition-all cursor-pointer"
          >
            <RotateCcw className="w-4 h-4" />
            <span>Xóa tất cả bộ lọc</span>
          </button>
        </div>
      )}
    </div>
  )
}
