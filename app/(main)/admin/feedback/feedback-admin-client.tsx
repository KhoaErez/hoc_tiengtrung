'use client'

import { useState, useTransition, useEffect, useRef } from 'react'
import Link from 'next/link'
import { useSearchParams } from 'next/navigation'
import { 
  Bug, 
  Lightbulb, 
  Palette, 
  BookOpen, 
  HelpCircle, 
  Search, 
  Filter, 
  Clock, 
  ExternalLink, 
  CheckCircle2, 
  AlertCircle, 
  RefreshCw,
  MessageSquare,
  ShieldCheck,
  ChevronDown
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { 
  getAdminFeedbacksAction, 
  updateFeedbackStatusAction, 
  FeedbackCategory, 
  FeedbackStatus 
} from '@/app/actions/feedback'

interface FeedbackItem {
  id: string
  user_id: string | null
  category: FeedbackCategory
  title: string
  message: string
  steps_to_reproduce: string | null
  page_url: string | null
  device_info: string | null
  status: FeedbackStatus
  admin_note: string | null
  created_at: string
  updated_at: string
  profiles?: {
    id: string
    email: string
    display_name: string | null
    avatar_url: string | null
  } | null
}

interface StatsData {
  total: number
  new: number
  under_review: number
  in_progress: number
  resolved: number
  wont_fix: number
  bug: number
  feature: number
  ui_ux: number
  content: number
  other: number
}

interface FeedbackAdminClientProps {
  initialFeedbacks: FeedbackItem[]
  initialStats: StatsData
}

const CATEGORY_MAP: Record<FeedbackCategory, { label: string; icon: typeof Bug; color: string }> = {
  bug: { label: 'Báo lỗi', icon: Bug, color: 'bg-red-50 text-red-700 border-red-200' },
  feature: { label: 'Tính năng', icon: Lightbulb, color: 'bg-amber-50 text-amber-700 border-amber-200' },
  ui_ux: { label: 'Giao diện', icon: Palette, color: 'bg-purple-50 text-purple-700 border-purple-200' },
  content: { label: 'Nội dung', icon: BookOpen, color: 'bg-emerald-50 text-emerald-700 border-emerald-200' },
  other: { label: 'Ý kiến khác', icon: HelpCircle, color: 'bg-blue-50 text-blue-700 border-blue-200' },
}

const STATUS_MAP: Record<FeedbackStatus, { label: string; color: string; badge: string }> = {
  new: { label: 'Mới', color: 'text-blue-700', badge: 'bg-blue-50 text-blue-700 border-blue-200' },
  under_review: { label: 'Đang xem xét', color: 'text-amber-700', badge: 'bg-amber-50 text-amber-700 border-amber-200' },
  in_progress: { label: 'Đang xử lý', color: 'text-purple-700', badge: 'bg-purple-50 text-purple-700 border-purple-200' },
  resolved: { label: 'Đã hoàn thành', color: 'text-emerald-700', badge: 'bg-emerald-50 text-emerald-700 border-emerald-200' },
  wont_fix: { label: 'Không triển khai', color: 'text-slate-600', badge: 'bg-slate-100 text-slate-700 border-slate-200' },
}

export function FeedbackAdminClient({
  initialFeedbacks,
  initialStats,
}: FeedbackAdminClientProps) {
  const searchParams = useSearchParams()
  const highlightId = searchParams?.get('highlight') || null

  const [feedbacks, setFeedbacks] = useState<FeedbackItem[]>(initialFeedbacks)
  const [stats, setStats] = useState<StatsData>(initialStats)
  const [statusFilter, setStatusFilter] = useState<string>('all')
  const [categoryFilter, setCategoryFilter] = useState<string>('all')
  const [searchQuery, setSearchQuery] = useState('')
  const [isPending, startTransition] = useTransition()
  const [highlightedId, setHighlightedId] = useState<string | null>(null)

  // Track editable notes per feedback ID
  const [editingNotes, setEditingNotes] = useState<Record<string, string>>({})
  const [savingNoteId, setSavingNoteId] = useState<string | null>(null)

  // Ref map for scrolling to highlighted feedback
  const feedbackRefs = useRef<Record<string, HTMLDivElement | null>>({})

  // Auto-highlight and scroll when ?highlight= param is present
  useEffect(() => {
    if (!highlightId) return

    // Nếu feedback đang bị ẩn bởi bộ lọc, reset filter về 'all'
    const targetExists = feedbacks.some((f) => f.id === highlightId)
    if (!targetExists && (statusFilter !== 'all' || categoryFilter !== 'all')) {
      setStatusFilter('all')
      setCategoryFilter('all')
      setSearchQuery('')
      // Fetch lại với filter all
      startTransition(async () => {
        const { getAdminFeedbacksAction } = await import('@/app/actions/feedback')
        const res = await getAdminFeedbacksAction({})
        if (res.success && res.data) {
          setFeedbacks(res.data as unknown as FeedbackItem[])
          if (res.stats) setStats(res.stats)
        }
      })
    }

    setHighlightedId(highlightId)

    // Scroll to the highlighted element after a short delay for rendering
    const timer = setTimeout(() => {
      const el = feedbackRefs.current[highlightId]
      if (el) {
        el.scrollIntoView({ behavior: 'smooth', block: 'center' })
      }
    }, 300)

    // Remove highlight animation after 4 seconds
    const clearTimer = setTimeout(() => {
      setHighlightedId(null)
    }, 4000)

    return () => {
      clearTimeout(timer)
      clearTimeout(clearTimer)
    }
  }, [highlightId]) // eslint-disable-line react-hooks/exhaustive-deps

  // Fetch / refresh data
  const handleFilter = (newStatus?: string, newCategory?: string, newSearch?: string) => {
    const s = newStatus !== undefined ? newStatus : statusFilter
    const c = newCategory !== undefined ? newCategory : categoryFilter
    const q = newSearch !== undefined ? newSearch : searchQuery

    startTransition(async () => {
      const res = await getAdminFeedbacksAction({
        status: s,
        category: c,
        search: q,
      })
      if (res.success && res.data) {
        setFeedbacks(res.data as unknown as FeedbackItem[])
        if (res.stats) setStats(res.stats)
      }
    })
  }

  // Update status
  const handleStatusChange = async (id: string, newStatus: FeedbackStatus) => {
    startTransition(async () => {
      const res = await updateFeedbackStatusAction({ id, status: newStatus })
      if (res.success) {
        setFeedbacks((prev) =>
          prev.map((f) => (f.id === id ? { ...f, status: newStatus } : f))
        )
        // Refresh counts
        handleFilter()
      }
    })
  }

  // Save admin note
  const handleSaveNote = async (id: string) => {
    const note = editingNotes[id] ?? ''
    setSavingNoteId(id)
    const res = await updateFeedbackStatusAction({
      id,
      status: feedbacks.find((f) => f.id === id)?.status || 'new',
      adminNote: note,
    })
    setSavingNoteId(null)
    if (res.success) {
      setFeedbacks((prev) =>
        prev.map((f) => (f.id === id ? { ...f, admin_note: note } : f))
      )
    }
  }

  return (
    <div className="space-y-8 font-serif pb-16">
      
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-border pb-5">
        <div>
          <div className="flex items-center gap-2 mb-1">
            <span className="px-2.5 py-0.5 rounded-lg text-xs font-serif font-bold bg-app-accent-soft text-app-accent border border-app-accent/20 flex items-center gap-1">
              <ShieldCheck className="w-3.5 h-3.5" />
              Quản trị viên
            </span>
            <span className="text-xs text-muted">Chinese Notebook</span>
          </div>
          <h1 className="text-2xl sm:text-3xl font-serif font-bold text-title">
            Quản lý Góp ý & Báo lỗi
          </h1>
        </div>

        <div className="flex items-center gap-2 self-start sm:self-auto">
          <Link href="/admin">
            <Button
              variant="outline"
              size="sm"
              className="font-serif border-border text-xs gap-1.5"
            >
              <ShieldCheck className="w-3.5 h-3.5 text-app-accent" />
              <span>Phân quyền tài khoản</span>
            </Button>
          </Link>
          <Button
            variant="outline"
            size="sm"
            onClick={() => handleFilter()}
            disabled={isPending}
            className="font-serif border-border text-xs gap-1.5"
          >
            <RefreshCw className={`w-3.5 h-3.5 ${isPending ? 'animate-spin' : ''}`} />
            <span>Làm mới dữ liệu</span>
          </Button>
        </div>
      </div>

      {/* Overview Stat Cards */}
      <div className="grid grid-cols-2 md:grid-cols-5 gap-3 sm:gap-4">
        <div className="p-4 rounded-xl border border-border bg-card shadow-2xs">
          <p className="text-xs text-muted uppercase font-sans tracking-wider font-semibold">Tất cả</p>
          <p className="text-2xl sm:text-3xl font-bold text-title mt-1">{stats.total}</p>
        </div>

        <div className="p-4 rounded-xl border border-blue-200 bg-blue-50/50 shadow-2xs">
          <p className="text-xs text-blue-700 uppercase font-sans tracking-wider font-semibold">Mới</p>
          <p className="text-2xl sm:text-3xl font-bold text-blue-700 mt-1">{stats.new}</p>
        </div>

        <div className="p-4 rounded-xl border border-amber-200 bg-amber-50/50 shadow-2xs">
          <p className="text-xs text-amber-700 uppercase font-sans tracking-wider font-semibold">Đang xem xét</p>
          <p className="text-2xl sm:text-3xl font-bold text-amber-700 mt-1">{stats.under_review}</p>
        </div>

        <div className="p-4 rounded-xl border border-purple-200 bg-purple-50/50 shadow-2xs">
          <p className="text-xs text-purple-700 uppercase font-sans tracking-wider font-semibold">Đang xử lý</p>
          <p className="text-2xl sm:text-3xl font-bold text-purple-700 mt-1">{stats.in_progress}</p>
        </div>

        <div className="p-4 rounded-xl border border-emerald-200 bg-emerald-50/50 shadow-2xs col-span-2 md:col-span-1">
          <p className="text-xs text-emerald-700 uppercase font-sans tracking-wider font-semibold">Đã xong</p>
          <p className="text-2xl sm:text-3xl font-bold text-emerald-700 mt-1">{stats.resolved}</p>
        </div>
      </div>

      {/* Filter and Search Toolbar */}
      <div className="flex flex-col md:flex-row gap-3 items-stretch md:items-center justify-between p-4 rounded-2xl bg-card border border-border shadow-2xs">
        
        {/* Search */}
        <div className="relative flex-1 max-w-md">
          <Search className="w-4 h-4 text-muted absolute left-3 top-1/2 -translate-y-1/2 pointer-events-none" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => {
              setSearchQuery(e.target.value)
              handleFilter(undefined, undefined, e.target.value)
            }}
            placeholder="Tìm theo tiêu đề hoặc nội dung..."
            className="w-full pl-9 pr-3 py-2 text-xs sm:text-sm rounded-xl border border-border bg-page text-title placeholder:text-muted focus:outline-none focus:border-app-accent"
          />
        </div>

        {/* Filter dropdowns */}
        <div className="flex flex-wrap items-center gap-2">
          {/* Status select */}
          <select
            value={statusFilter}
            onChange={(e) => {
              setStatusFilter(e.target.value)
              handleFilter(e.target.value, undefined, undefined)
            }}
            className="px-3 py-2 text-xs rounded-xl border border-border bg-page text-title focus:outline-none focus:border-app-accent font-serif"
          >
            <option value="all">Mọi trạng thái</option>
            <option value="new">Mới ({stats.new})</option>
            <option value="under_review">Đang xem xét ({stats.under_review})</option>
            <option value="in_progress">Đang xử lý ({stats.in_progress})</option>
            <option value="resolved">Đã hoàn thành ({stats.resolved})</option>
            <option value="wont_fix">Không triển khai ({stats.wont_fix})</option>
          </select>

          {/* Category select */}
          <select
            value={categoryFilter}
            onChange={(e) => {
              setCategoryFilter(e.target.value)
              handleFilter(undefined, e.target.value, undefined)
            }}
            className="px-3 py-2 text-xs rounded-xl border border-border bg-page text-title focus:outline-none focus:border-app-accent font-serif"
          >
            <option value="all">Mọi danh mục</option>
            <option value="bug">Báo lỗi ({stats.bug})</option>
            <option value="feature">Tính năng ({stats.feature})</option>
            <option value="ui_ux">Giao diện ({stats.ui_ux})</option>
            <option value="content">Nội dung ({stats.content})</option>
            <option value="other">Khác ({stats.other})</option>
          </select>
        </div>
      </div>

      {/* Feedbacks List */}
      <div className="space-y-4">
        {feedbacks.length === 0 ? (
          <div className="p-12 text-center rounded-2xl border border-dashed border-border bg-card/60 space-y-2">
            <MessageSquare className="w-10 h-10 text-muted mx-auto opacity-50" />
            <p className="text-base font-bold text-title">Không tìm thấy phản hồi nào</p>
            <p className="text-xs text-muted">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm.</p>
          </div>
        ) : (
          feedbacks.map((item) => {
            const catObj = CATEGORY_MAP[item.category] || CATEGORY_MAP.other
            const statusObj = STATUS_MAP[item.status] || STATUS_MAP.new
            const Icon = catObj.icon
            const sender = item.profiles?.display_name || item.profiles?.email || 'Khách vãng lai (Ẩn danh)'

            return (
              <div
                key={item.id}
                ref={(el) => { feedbackRefs.current[item.id] = el }}
                data-feedback-id={item.id}
                className={`p-5 sm:p-6 rounded-2xl border bg-card shadow-2xs space-y-4 transition-all hover:border-title/30 ${
                  highlightedId === item.id
                    ? 'border-app-accent ring-2 ring-app-accent/30 animate-pulse'
                    : 'border-border'
                }`}
              >
                {/* Item Header */}
                <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2.5 border-b border-border/70 pb-3">
                  <div className="flex flex-wrap items-center gap-2">
                    {/* Category tag */}
                    <span className={`inline-flex items-center gap-1 px-2.5 py-0.5 rounded-lg text-xs font-serif font-medium border ${catObj.color}`}>
                      <Icon className="w-3 h-3" />
                      {catObj.label}
                    </span>

                    {/* Status badge */}
                    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-lg text-xs font-serif font-medium border ${statusObj.badge}`}>
                      {statusObj.label}
                    </span>

                    {/* Time */}
                    <span className="text-xs text-muted flex items-center gap-1 font-sans">
                      <Clock className="w-3 h-3" />
                      {new Date(item.created_at).toLocaleString('vi-VN')}
                    </span>
                  </div>

                  {/* Status Dropdown */}
                  <div className="flex items-center gap-2">
                    <span className="text-xs text-muted">Đổi trạng thái:</span>
                    <select
                      value={item.status}
                      disabled={isPending}
                      onChange={(e) => handleStatusChange(item.id, e.target.value as FeedbackStatus)}
                      className="text-xs px-2.5 py-1 rounded-lg border border-border bg-page text-title font-serif focus:outline-none focus:border-app-accent"
                    >
                      <option value="new">Mới</option>
                      <option value="under_review">Đang xem xét</option>
                      <option value="in_progress">Đang xử lý</option>
                      <option value="resolved">Đã hoàn thành</option>
                      <option value="wont_fix">Không triển khai</option>
                    </select>
                  </div>
                </div>

                {/* Title & Message */}
                <div className="space-y-1.5">
                  <h3 className="text-base sm:text-lg font-serif font-bold text-title">
                    {item.title}
                  </h3>
                  <p className="text-xs sm:text-sm text-body font-serif whitespace-pre-wrap leading-relaxed">
                    {item.message}
                  </p>
                </div>

                {/* Bug Steps if any */}
                {item.steps_to_reproduce && (
                  <div className="p-3 rounded-xl bg-red-50/50 border border-red-200/60 text-xs space-y-1">
                    <p className="font-bold text-red-800">Các bước tái hiện lỗi:</p>
                    <p className="text-red-700 whitespace-pre-wrap">{item.steps_to_reproduce}</p>
                  </div>
                )}

                {/* Meta details */}
                <div className="flex flex-wrap items-center gap-y-2 gap-x-6 text-xs text-muted pt-2 border-t border-border/70">
                  <div>
                    Người gửi: <strong className="text-title font-medium">{sender}</strong>
                  </div>

                  {item.page_url && (
                    <div className="flex items-center gap-1">
                      <span>Trang:</span>
                      <Link
                        href={item.page_url}
                        target="_blank"
                        className="text-app-accent hover:underline flex items-center gap-0.5 font-mono text-[11px]"
                      >
                        {item.page_url}
                        <ExternalLink className="w-3 h-3" />
                      </Link>
                    </div>
                  )}

                  {item.device_info && (
                    <div className="text-[11px] truncate max-w-xs" title={item.device_info}>
                      Thiết bị: {item.device_info}
                    </div>
                  )}
                </div>

                {/* Admin Note Section */}
                <div className="pt-3 border-t border-dashed border-border flex flex-col sm:flex-row gap-2 items-start sm:items-center">
                  <span className="text-xs font-semibold text-title shrink-0">Ghi chú nội bộ:</span>
                  <input
                    type="text"
                    defaultValue={item.admin_note || ''}
                    placeholder="Thêm ghi chú xử lý nội bộ..."
                    onChange={(e) =>
                      setEditingNotes((prev) => ({ ...prev, [item.id]: e.target.value }))
                    }
                    className="flex-1 px-3 py-1.5 text-xs rounded-lg border border-border bg-page text-title focus:outline-none focus:border-app-accent"
                  />
                  <Button
                    type="button"
                    size="sm"
                    variant="outline"
                    disabled={savingNoteId === item.id}
                    onClick={() => handleSaveNote(item.id)}
                    className="font-serif text-xs border-border shrink-0"
                  >
                    {savingNoteId === item.id ? 'Đang lưu...' : 'Lưu ghi chú'}
                  </Button>
                </div>

              </div>
            )
          })
        )}
      </div>

    </div>
  )
}
