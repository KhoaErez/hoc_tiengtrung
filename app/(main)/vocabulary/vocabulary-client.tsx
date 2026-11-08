'use client'

import React, { useState, useTransition, useId } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import {
  Search,
  X,
  Volume2,
  Bookmark,
  BookmarkCheck,
  Keyboard,
  Sparkles,
  ChevronLeft,
  ChevronRight,
  BookOpen,
  Filter,
  Loader2,
  GraduationCap,
} from 'lucide-react'
import { AudioButton } from '@/components/ui/audio-button'
import { Button } from '@/components/ui/button'
import {
  VocabularyItem,
  searchVocabulariesAction,
  toggleSaveVocabularyAction,
} from './actions'

interface VocabularyClientProps {
  initialVocabs: VocabularyItem[]
  initialTotalCount: number
  initialPage: number
  initialTotalPages: number
  initialHskLevel: string
  initialSearch: string
  initialTopic: string
  countsByLevel: Record<string, number>
  isLoggedIn: boolean
}

// 9 Chủ đề 3D khám phá nhanh
const TOPIC_SHELVES = [
  { id: 'family', label: 'Gia đình', icon: '👨‍👩‍👧', cover: '/images/vocabulary/vocab-family.webp' },
  { id: 'daily', label: 'Sinh hoạt', icon: '☀️', cover: '/images/vocabulary/vocab-daily.webp' },
  { id: 'school', label: 'Trường học', icon: '📚', cover: '/images/vocabulary/vocab-school.webp' },
  { id: 'food', label: 'Ẩm thực', icon: '🍜', cover: '/images/vocabulary/vocab-food.webp' },
  { id: 'jobs', label: 'Công việc', icon: '💼', cover: '/images/vocabulary/vocab-jobs.webp' },
  { id: 'travel', label: 'Du lịch', icon: '✈️', cover: '/images/vocabulary/vocab-travel.webp' },
  { id: 'home', label: 'Nhà cửa', icon: '🏡', cover: '/images/vocabulary/vocab-home.webp' },
  { id: 'weather', label: 'Thời tiết', icon: '🌤️', cover: '/images/vocabulary/vocab-weather.webp' },
  { id: 'animals', label: 'Động vật', icon: '🐼', cover: '/images/vocabulary/vocab-animals.webp' },
]

const HSK_LEVELS = [
  { id: 'all', label: 'Tất cả' },
  { id: 'HSK 1', label: 'HSK 1' },
  { id: 'HSK 2', label: 'HSK 2' },
  { id: 'HSK 3', label: 'HSK 3' },
  { id: 'HSK 4', label: 'HSK 4' },
  { id: 'HSK 5', label: 'HSK 5' },
  { id: 'HSK 6', label: 'HSK 6' },
  { id: 'HSK 7-9', label: 'HSK 7-9' },
]

export function VocabularyClient({
  initialVocabs,
  initialTotalCount,
  initialPage,
  initialTotalPages,
  initialHskLevel,
  initialSearch,
  initialTopic,
  countsByLevel,
  isLoggedIn,
}: VocabularyClientProps) {
  const [vocabs, setVocabs] = useState<VocabularyItem[]>(initialVocabs)
  const [totalCount, setTotalCount] = useState<number>(initialTotalCount)
  const [page, setPage] = useState<number>(initialPage)
  const [totalPages, setTotalPages] = useState<number>(initialTotalPages)
  const [hskLevel, setHskLevel] = useState<string>(initialHskLevel)
  const [search, setSearch] = useState<string>(initialSearch)
  const [selectedTopic, setSelectedTopic] = useState<string>(initialTopic)
  const [savingId, setSavingId] = useState<string | null>(null)
  const [isPending, startTransition] = useTransition()
  const searchInputId = useId()

  // Kích hoạt tìm kiếm
  const handlePerformSearch = (newLevel = hskLevel, newSearch = search, newTopic = selectedTopic, newPage = 1) => {
    startTransition(async () => {
      const result = await searchVocabulariesAction({
        hskLevel: newLevel,
        search: newSearch,
        topic: newTopic,
        page: newPage,
        pageSize: 24,
      })

      if (result.success) {
        setVocabs(result.vocabs)
        setTotalCount(result.totalCount)
        setPage(result.page)
        setTotalPages(result.totalPages)
      }
    })
  }

  // Chuyển tab cấp độ HSK
  const handleLevelChange = (lvl: string) => {
    setHskLevel(lvl)
    setPage(1)
    handlePerformSearch(lvl, search, selectedTopic, 1)
  }

  // Chọn chủ đề 3D
  const handleTopicClick = (topicId: string) => {
    const nextTopic = selectedTopic === topicId ? 'all' : topicId
    setSelectedTopic(nextTopic)
    setPage(1)
    handlePerformSearch(hskLevel, search, nextTopic, 1)
  }

  // Nhấn Enter hoặc nút tìm kiếm
  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    setPage(1)
    handlePerformSearch(hskLevel, search, selectedTopic, 1)
  }

  // Xóa trắng ô tìm kiếm
  const handleClearSearch = () => {
    setSearch('')
    setPage(1)
    handlePerformSearch(hskLevel, '', selectedTopic, 1)
  }

  // Chuyển trang
  const handlePageChange = (newPage: number) => {
    if (newPage < 1 || newPage > totalPages) return
    setPage(newPage)
    handlePerformSearch(hskLevel, search, selectedTopic, newPage)
    window.scrollTo({ top: 380, behavior: 'smooth' })
  }

  // Lưu hoặc Hủy lưu từ vựng vào sổ tay ôn tập SM-2
  const handleToggleSave = async (vocabId: string) => {
    if (!isLoggedIn) {
      alert('Vui lòng đăng nhập để lưu từ vựng vào sổ ôn tập cá nhân Spaced Repetition (SM-2)!')
      return
    }

    setSavingId(vocabId)
    try {
      const res = await toggleSaveVocabularyAction(vocabId)
      if (res.success) {
        setVocabs((prev) =>
          prev.map((item) =>
            item.id === vocabId ? { ...item, isSaved: res.isSaved } : item
          )
        )
      } else if (res.error) {
        alert(res.error)
      }
    } finally {
      setSavingId(null)
    }
  }

  return (
    <div className="w-full space-y-6 sm:space-y-8 font-serif">
      
      {/* ================================================================== */}
      {/* 1. HERO SEARCH SECTION (THIẾT KẾ CẢNH QUAN 3D & THANH TRA CỨU)      */}
      {/* ================================================================== */}
      <div className="relative overflow-hidden rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] p-5 sm:p-7 md:p-8 shadow-xs hover:shadow-md transition-all">
        {/* Top accent bar */}
        <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-[#182238] via-[#B8322D] to-[#F59E0B]" />

        {/* Chữ Hán chìm trang trí */}
        <div className="absolute -right-4 -bottom-6 select-none pointer-events-none opacity-[0.04] dark:opacity-[0.06] font-hanzi text-8xl md:text-9xl font-bold text-[#182238] dark:text-white">
          字典
        </div>

        <div className="relative z-10 space-y-6">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-5">
            <div className="flex items-center gap-4 sm:gap-5 max-w-xl">
              <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs shrink-0 relative bg-[#FFF9F3] dark:bg-[#202B45]">
                <Image
                  src="/images/vocabulary/vocab-hero.webp"
                  alt="Tra từ điển tiếng Trung 3D"
                  fill
                  className="object-cover"
                  sizes="96px"
                  priority
                />
              </div>
              <div className="space-y-1.5">
                <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold tracking-wide uppercase bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30">
                  <BookOpen className="w-3.5 h-3.5" />
                  <span>Kho Từ Điển HSK 3.0 • Chuẩn GF 0025-2021</span>
                </div>

                <h1 className="text-2xl sm:text-3xl md:text-4xl font-serif text-[#182238] dark:text-white font-bold tracking-tight">
                  Tra Cứu Từ Vựng Tiếng Trung
                </h1>
                <p className="text-muted font-serif text-xs md:text-sm leading-relaxed">
                  Tra cứu nghĩa, phiên âm Pinyin, nghe audio phát âm Bắc Kinh chuẩn giọng đọc và lưu ngay vào phòng ôn tập lặp lại ngắt quãng (SM-2).
                </p>
              </div>
            </div>

            {/* Thống kê nhanh kho từ */}
            <div className="shrink-0 flex items-center gap-2.5">
              <div className="px-4 py-2.5 rounded-2xl bg-[#FFF9F3] dark:bg-[#202B45] border border-[#182238]/15 dark:border-white/10 shadow-xs text-center">
                <span className="text-[10px] font-sans font-bold uppercase tracking-wider text-muted block">
                  Tổng kho từ
                </span>
                <span className="text-xl sm:text-2xl font-serif font-bold text-[#B8322D]">
                  {totalCount.toLocaleString('vi-VN')}
                </span>
              </div>
            </div>
          </div>

          {/* THANH TÌM KIẾM ĐA NĂNG */}
          <form onSubmit={handleSearchSubmit} className="relative w-full max-w-3xl">
            <label htmlFor={searchInputId} className="sr-only">
              Tìm kiếm từ vựng
            </label>
            <div className="relative flex items-center">
              <Search className="w-5 h-5 absolute left-4 text-muted pointer-events-none" />
              <input
                id={searchInputId}
                type="text"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                placeholder="Tra bằng Chữ Hán, Pinyin hoặc Tiếng Việt (VD: 朋友, ni hao, học bài)..."
                className="w-full pl-12 pr-24 py-3.5 sm:py-4 rounded-2xl border border-[#182238]/20 dark:border-white/15 bg-[#FAF7F2] dark:bg-[#141A23] text-sm sm:text-base font-serif text-[#182238] dark:text-white placeholder:text-muted/70 focus:outline-none focus:border-[#B8322D] focus:ring-4 focus:ring-[#B8322D]/10 transition-all shadow-inner"
              />

              {search && (
                <button
                  type="button"
                  onClick={handleClearSearch}
                  className="absolute right-14 p-1.5 rounded-full hover:bg-black/5 dark:hover:bg-white/10 text-muted transition-colors cursor-pointer"
                  title="Xóa tìm kiếm"
                  aria-label="Xóa từ khóa tìm kiếm"
                >
                  <X className="w-4 h-4" />
                </button>
              )}

              <button
                type="submit"
                disabled={isPending}
                className="absolute right-2 px-4 py-2 rounded-xl bg-[#B8322D] hover:bg-[#9E2A25] text-white text-xs sm:text-sm font-serif font-bold shadow-xs transition-all active:scale-95 cursor-pointer disabled:opacity-50"
                aria-label="Thực hiện tìm kiếm"
              >
                {isPending ? <Loader2 className="w-4 h-4 animate-spin" /> : 'Tra từ'}
              </button>
            </div>

            {/* Gợi ý từ khóa mẫu */}
            <div className="flex items-center gap-2 mt-2.5 text-xs text-muted font-serif flex-wrap">
              <span>Gợi ý:</span>
              {['你好', '谢谢', '学习', '朋友', '中国', ' ăn cơm', 'du lịch'].map((sample) => (
                <button
                  key={sample}
                  type="button"
                  onClick={() => {
                    const cleanSample = sample.trim()
                    setSearch(cleanSample)
                    handlePerformSearch(hskLevel, cleanSample, selectedTopic, 1)
                  }}
                  className="px-2 py-0.5 rounded-md bg-[#FAF7F2] dark:bg-[#202B45] hover:bg-[#B8322D]/10 hover:text-[#B8322D] border border-[#182238]/10 text-[11px] transition-colors cursor-pointer"
                >
                  {sample.trim()}
                </button>
              ))}
            </div>
          </form>
        </div>
      </div>

      {/* ================================================================== */}
      {/* 2. CHỦ ĐỀ 3D KHÁM PHÁ NHANH (9 KỆ CHỦ ĐỀ)                         */}
      {/* ================================================================== */}
      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <span className="w-2.5 h-2.5 rounded-full bg-[#B8322D]" />
            <h2 className="text-base sm:text-lg font-serif font-bold text-[#182238] dark:text-white">
              Khám Phá Theo Chủ Đề 3D
            </h2>
          </div>
          {selectedTopic !== 'all' && (
            <button
              onClick={() => handleTopicClick('all')}
              className="text-xs text-[#B8322D] hover:underline font-bold cursor-pointer"
            >
              Bỏ lọc chủ đề
            </button>
          )}
        </div>

        <div className="grid grid-cols-3 sm:grid-cols-5 md:grid-cols-9 gap-2 sm:gap-2.5">
          {TOPIC_SHELVES.map((t) => {
            const isSelected = selectedTopic === t.id
            return (
              <button
                key={t.id}
                type="button"
                onClick={() => handleTopicClick(t.id)}
                className={`p-2 rounded-2xl border transition-all flex flex-col items-center gap-1.5 text-center cursor-pointer active:scale-95 touch-manipulation ${
                  isSelected
                    ? 'border-[#B8322D] bg-[#FFF9F3] dark:bg-[#B8322D]/15 shadow-xs font-bold'
                    : 'border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] hover:border-[#182238]/30 shadow-xs'
                }`}
              >
                <div className="w-11 h-11 sm:w-12 sm:h-12 rounded-xl overflow-hidden relative shrink-0">
                  <Image
                    src={t.cover}
                    alt={t.label}
                    fill
                    sizes="48px"
                    className="object-cover"
                  />
                </div>
                <span className={`text-[11px] font-serif truncate w-full ${isSelected ? 'text-[#B8322D]' : 'text-title'}`}>
                  {t.label}
                </span>
              </button>
            )
          })}
        </div>
      </div>

      {/* ================================================================== */}
      {/* 3. THANH TAB LỌC CẤP ĐỘ HSK (LEVEL SELECTOR)                       */}
      {/* ================================================================== */}
      <div className="flex items-center justify-between gap-3 flex-wrap border-b border-[#182238]/10 dark:border-white/10 pb-3">
        <div className="flex items-center gap-1.5 sm:gap-2 overflow-x-auto no-scrollbar py-1">
          {HSK_LEVELS.map((lvl) => {
            const isActive = hskLevel === lvl.id
            const count = lvl.id === 'all' ? totalCount : countsByLevel[lvl.id] || 0
            return (
              <button
                key={lvl.id}
                type="button"
                onClick={() => handleLevelChange(lvl.id)}
                className={`px-3.5 py-1.5 rounded-xl text-xs sm:text-sm font-serif font-medium whitespace-nowrap transition-all cursor-pointer active:scale-95 touch-manipulation flex items-center gap-1.5 ${
                  isActive
                    ? 'bg-[#182238] dark:bg-white text-white dark:text-[#182238] font-bold shadow-xs'
                    : 'bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 text-title hover:border-[#182238]/30'
                }`}
              >
                <span>{lvl.label}</span>
                {count > 0 && lvl.id !== 'all' && (
                  <span className={`text-[10px] px-1.5 py-0.2 rounded-full font-sans ${
                    isActive ? 'bg-white/20 text-white dark:bg-black/20 dark:text-black' : 'bg-black/5 dark:bg-white/10 text-muted'
                  }`}>
                    {count}
                  </span>
                )}
              </button>
            )
          })}
        </div>

        {/* Tổng số kết quả tìm thấy */}
        <div className="text-xs text-muted font-serif">
          Tìm thấy <strong>{totalCount}</strong> từ vựng {isPending && '...'}
        </div>
      </div>

      {/* ================================================================== */}
      {/* 4. DANH SÁCH THẺ TỪ VỰNG (CARD GRID)                              */}
      {/* ================================================================== */}
      {isPending ? (
        <div className="py-20 text-center space-y-3">
          <Loader2 className="w-8 h-8 text-[#B8322D] animate-spin mx-auto" />
          <p className="text-sm font-serif text-muted">Đang tìm kiếm từ vựng...</p>
        </div>
      ) : vocabs.length > 0 ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-5">
          {vocabs.map((vocab) => {
            const isSaving = savingId === vocab.id

            return (
              <div
                key={vocab.id}
                className="w-full rounded-[22px] bg-white dark:bg-[#182238] border border-[#182238]/12 dark:border-white/10 shadow-xs hover:shadow-md transition-all p-5 flex flex-col justify-between space-y-4 group relative overflow-hidden"
              >
                {/* Dải màu accent đầu card */}
                <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-transparent via-[#B8322D]/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />

                <div className="space-y-3.5">
                  {/* Header thẻ: Badge HSK, Word Type & Nút Bookmark SM-2 */}
                  <div className="flex items-center justify-between gap-2">
                    <div className="flex items-center gap-1.5 flex-wrap">
                      {vocab.hsk_level && (
                        <span className="px-2.5 py-0.5 rounded-lg bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/20 text-[11px] font-sans font-bold">
                          {vocab.hsk_level}
                        </span>
                      )}
                      {vocab.word_type && (
                        <span className="px-2 py-0.5 rounded-lg bg-[#FAF7F2] dark:bg-[#202B45] text-muted text-[10px] font-serif border border-[#182238]/10">
                          {vocab.word_type}
                        </span>
                      )}
                    </div>

                    {/* Nút lưu từ vào sổ ôn tập SM-2 */}
                    <button
                      type="button"
                      onClick={() => handleToggleSave(vocab.id)}
                      disabled={isSaving}
                      className={`p-2 rounded-xl transition-all cursor-pointer active:scale-90 ${
                        vocab.isSaved
                          ? 'bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/30'
                          : 'hover:bg-black/5 dark:hover:bg-white/10 text-muted border border-transparent'
                      }`}
                      title={vocab.isSaved ? 'Đã lưu trong sổ ôn tập SM-2' : 'Lưu vào sổ ôn tập SM-2'}
                    >
                      {vocab.isSaved ? (
                        <BookmarkCheck className="w-4 h-4 text-[#B8322D] fill-[#B8322D]" />
                      ) : (
                        <Bookmark className="w-4 h-4" />
                      )}
                    </button>
                  </div>

                  {/* Phần trọng tâm: Chữ Hán, Audio & Pinyin */}
                  <div className="flex items-start justify-between gap-3 pt-1">
                    <div className="space-y-1">
                      <div className="flex items-center gap-2.5">
                        <span className="font-hanzi font-serif font-bold text-3xl sm:text-4xl text-[#182238] dark:text-white tracking-wide">
                          {vocab.hanzi}
                        </span>
                        <AudioButton
                          text={vocab.hanzi}
                          id={`audio-${vocab.id}`}
                          size="md"
                          variant="subtle"
                          tooltip="Nghe phát âm chuẩn Bắc Kinh"
                        />
                      </div>
                      <p className="text-base font-sans font-semibold text-[#B8322D] tracking-wide">
                        {vocab.pinyin}
                      </p>
                    </div>
                  </div>

                  {/* Nghĩa tiếng Việt */}
                  <div className="p-3 rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] border border-[#182238]/8 dark:border-white/8">
                    <p className="text-sm font-serif font-bold text-[#182238] dark:text-white leading-relaxed">
                      {vocab.meaning_vi}
                    </p>
                  </div>

                  {/* Mẫu câu ví dụ nếu có */}
                  {vocab.example_hanzi && (
                    <div className="space-y-1 text-xs font-serif pt-1 border-t border-[#182238]/8 dark:border-white/8">
                      <div className="flex items-center justify-between gap-2">
                        <span className="text-muted text-[10px] uppercase font-sans font-bold">Ví dụ minh họa:</span>
                        <AudioButton
                          text={vocab.example_hanzi}
                          id={`ex-audio-${vocab.id}`}
                          size="xs"
                          variant="ghost"
                          tooltip="Nghe câu ví dụ"
                        />
                      </div>
                      <p className="font-hanzi font-medium text-title text-sm">{vocab.example_hanzi}</p>
                      {vocab.example_pinyin && (
                        <p className="text-muted font-sans text-[11px]">{vocab.example_pinyin}</p>
                      )}
                      {vocab.example_vi && (
                        <p className="text-muted/90 italic text-[11px]">{vocab.example_vi}</p>
                      )}
                    </div>
                  )}
                </div>

                {/* Footer thẻ: Nút liên kết Luyện gõ phím IME */}
                <div className="pt-3 border-t border-[#182238]/8 dark:border-white/8 flex items-center justify-between text-xs">
                  <Link
                    href={`/typing?practice=visual&mode=vocabulary&vocabId=${encodeURIComponent(vocab.id)}&word=${encodeURIComponent(vocab.hanzi)}&pinyin=${encodeURIComponent(vocab.pinyin)}&meaning=${encodeURIComponent(vocab.meaning_vi)}${vocab.example_hanzi ? `&exHanzi=${encodeURIComponent(vocab.example_hanzi)}&exPinyin=${encodeURIComponent(vocab.example_pinyin || '')}&exVi=${encodeURIComponent(vocab.example_vi || '')}` : ''}`}
                    className="inline-flex items-center gap-1.5 text-muted hover:text-[#B8322D] font-serif font-bold transition-colors cursor-pointer"
                  >
                    <Keyboard className="w-3.5 h-3.5" />
                    <span>Luyện gõ từ này</span>
                  </Link>

                  <Link
                    href={`/review`}
                    className="text-muted hover:text-[#B8322D] text-[11px] font-serif transition-colors"
                  >
                    {vocab.isSaved ? 'Xem trong sổ ôn →' : 'Ôn tập SM-2'}
                  </Link>
                </div>
              </div>
            )
          })}
        </div>
      ) : (
        /* Trạng thái rỗng không tìm thấy từ */
        <div className="text-center py-16 px-6 rounded-[22px] border border-[#182238]/12 dark:border-white/10 bg-white dark:bg-[#182238] shadow-xs max-w-md mx-auto space-y-4">
          <div className="relative w-32 h-32 mx-auto rounded-2xl overflow-hidden border border-[#182238]/15 dark:border-white/10 shadow-xs bg-[#FFF9F3] dark:bg-[#202B45] mascot-animated">
            <Image
              src="/images/panda/panda-thinking.webp"
              alt="Tiểu Bút đang suy nghĩ"
              fill
              sizes="128px"
              className="object-cover"
            />
          </div>
          <div className="space-y-1.5">
            <h3 className="text-lg font-serif font-bold text-[#182238] dark:text-white">
              Chưa tìm thấy từ vựng phù hợp
            </h3>
            <p className="text-xs text-muted font-serif max-w-xs mx-auto leading-relaxed">
              Không có từ vựng nào khớp với từ khóa <strong>&ldquo;{search}&rdquo;</strong> trong cấp độ {hskLevel}. Hãy thử tra từ khác hoặc chọn cấp độ HSK rộng hơn nhé!
            </p>
          </div>
          <div className="pt-2">
            <Button
              onClick={handleClearSearch}
              className="font-serif text-xs rounded-xl bg-[#B8322D] hover:bg-[#9E2A25] text-white px-5 py-2 cursor-pointer shadow-xs"
            >
              Xem lại tất cả từ vựng
            </Button>
          </div>
        </div>
      )}

      {/* ================================================================== */}
      {/* 5. PHÂN TRANG (PAGINATION)                                         */}
      {/* ================================================================== */}
      {totalPages > 1 && (
        <div className="flex items-center justify-center gap-2 pt-4 pb-12">
          <Button
            variant="outline"
            size="sm"
            disabled={page <= 1 || isPending}
            onClick={() => handlePageChange(page - 1)}
            className="font-serif text-xs min-h-[44px] px-3.5 rounded-xl border-[#182238]/15 dark:border-white/15 cursor-pointer shadow-xs"
          >
            <ChevronLeft className="w-4 h-4 mr-1" />
            <span>Trang trước</span>
          </Button>

          <span className="text-xs font-serif text-muted px-3">
            Trang <strong>{page}</strong> / {totalPages}
          </span>

          <Button
            variant="outline"
            size="sm"
            disabled={page >= totalPages || isPending}
            onClick={() => handlePageChange(page + 1)}
            className="font-serif text-xs min-h-[44px] px-3.5 rounded-xl border-[#182238]/15 dark:border-white/15 cursor-pointer shadow-xs"
          >
            <span>Trang sau</span>
            <ChevronRight className="w-4 h-4 ml-1" />
          </Button>
        </div>
      )}
    </div>
  )
}

