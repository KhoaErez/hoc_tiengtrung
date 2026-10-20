'use client'

import { useState, useMemo, useCallback } from 'react'
import Link from 'next/link'
import { radicals, strokeGroups, type Radical } from '@/data/radicals'
import { toggleLearned, isLearned } from '@/lib/radicals-storage'
import {
  ArrowLeft,
  ArrowRight,
  RotateCcw,
  Shuffle,
  CheckCircle,
  ChevronLeft,
  Layers,
} from 'lucide-react'
import { AudioButton } from '@/components/ui/audio-button'
import { stopAllAudio } from '@/lib/tts/tts-engine'

function shuffleArray<T>(array: T[]): T[] {
  const shuffled = [...array]
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))
    ;[shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]]
  }
  return shuffled
}

type FilterMode = 'all' | number

export default function FlashcardClient() {
  const [strokeFilter, setStrokeFilter] = useState<FilterMode>('all')
  const [isShuffled, setIsShuffled] = useState(false)
  const [currentIndex, setCurrentIndex] = useState(0)
  const [isFlipped, setIsFlipped] = useState(false)
  const [learnedMap, setLearnedMap] = useState<Record<number, boolean>>({})

  const deck = useMemo(() => {
    let filtered: Radical[] = strokeFilter === 'all'
      ? [...radicals]
      : radicals.filter((r) => r.strokes === strokeFilter)
    if (isShuffled) filtered = shuffleArray(filtered)
    return filtered
  }, [strokeFilter, isShuffled])

  const currentRadical = deck[currentIndex]

  const goNext = useCallback(() => {
    stopAllAudio()
    if (currentIndex < deck.length - 1) {
      setCurrentIndex((i) => i + 1)
      setIsFlipped(false)
    }
  }, [currentIndex, deck.length])

  const goPrev = useCallback(() => {
    stopAllAudio()
    if (currentIndex > 0) {
      setCurrentIndex((i) => i - 1)
      setIsFlipped(false)
    }
  }, [currentIndex])

  const handleShuffle = () => {
    stopAllAudio()
    setIsShuffled(!isShuffled)
    setCurrentIndex(0)
    setIsFlipped(false)
  }

  const handleReset = () => {
    stopAllAudio()
    setCurrentIndex(0)
    setIsFlipped(false)
  }

  const handleToggleLearned = () => {
    if (!currentRadical) return
    const newState = toggleLearned(currentRadical.id)
    setLearnedMap((prev) => ({ ...prev, [currentRadical.id]: newState }))
  }

  const getLearnedState = (id: number): boolean => {
    if (id in learnedMap) return learnedMap[id]
    return isLearned(id)
  }

  if (!currentRadical) {
    return (
      <div className="text-center py-16 space-y-3">
        <div className="text-5xl">📭</div>
        <p className="text-muted font-serif">Không có bộ thủ nào phù hợp.</p>
        <Link href="/radicals" className="text-app-accent hover:text-accent-hover font-serif text-sm underline">
          Quay lại danh sách
        </Link>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <Link
          href="/radicals"
          className="flex items-center gap-2 text-muted hover:text-app-accent transition-colors font-serif text-sm"
        >
          <ChevronLeft className="w-4 h-4" />
          Danh sách bộ thủ
        </Link>
        <h1 className="text-lg md:text-xl font-serif text-title">Flashcard</h1>
      </div>

      {/* Filter chips */}
      <div className="space-y-2">
        <p className="text-xs text-muted font-serif uppercase tracking-wider flex items-center gap-1.5">
          <Layers className="w-3.5 h-3.5" />
          Lọc theo số nét
        </p>
        <div className="flex flex-wrap gap-1.5">
          <button
            onClick={() => { setStrokeFilter('all'); setCurrentIndex(0); setIsFlipped(false) }}
            className={`px-3 py-1.5 rounded-full text-xs font-serif transition-all ${
              strokeFilter === 'all'
                ? 'bg-title text-white'
                : 'bg-card border border-border text-muted hover:text-title'
            }`}
          >
            Tất cả ({radicals.length})
          </button>
          {strokeGroups.map((sg) => (
            <button
              key={sg.strokes}
              onClick={() => { setStrokeFilter(sg.strokes); setCurrentIndex(0); setIsFlipped(false) }}
              className={`px-3 py-1.5 rounded-full text-xs font-serif transition-all ${
                strokeFilter === sg.strokes
                  ? 'bg-title text-white'
                  : 'bg-card border border-border text-muted hover:text-title'
              }`}
            >
              {sg.label} ({sg.count})
            </button>
          ))}
        </div>
      </div>

      {/* Progress bar */}
      <div className="space-y-1.5">
        <div className="flex justify-between text-xs text-muted font-sans">
          <span>{currentIndex + 1} / {deck.length}</span>
          <span>{Math.round(((currentIndex + 1) / deck.length) * 100)}%</span>
        </div>
        <div className="w-full bg-track h-2 rounded-full overflow-hidden">
          <div
            className="bg-gradient-to-r from-app-accent to-[#D4553F] h-full rounded-full transition-all duration-300"
            style={{ width: `${((currentIndex + 1) / deck.length) * 100}%` }}
          />
        </div>
      </div>

      {/* Flashcard */}
      <div className="perspective-1000">
        <button
          onClick={() => setIsFlipped(!isFlipped)}
          className="w-full cursor-pointer focus:outline-none"
          aria-label={isFlipped ? 'Lật về mặt trước' : 'Lật xem đáp án'}
        >
          <div
            className={`relative w-full transition-transform duration-500 preserve-3d ${
              isFlipped ? 'rotate-y-180' : ''
            }`}
            style={{
              transformStyle: 'preserve-3d',
              transform: isFlipped ? 'rotateY(180deg)' : 'rotateY(0deg)',
            }}
          >
            {/* Front */}
            <div
              className="w-full bg-card border border-border rounded-xl p-8 md:p-12 flex flex-col items-center justify-center min-h-[300px] md:min-h-[380px] shadow-sm"
              style={{ backfaceVisibility: 'hidden' }}
            >
              <span className="text-xs text-muted font-sans mb-4 uppercase tracking-wider">
                Nhấn để lật thẻ
              </span>
              <div className="flex items-center gap-3">
                <span
                  className="text-8xl md:text-[10rem] font-serif text-title leading-none"
                  style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                >
                  {currentRadical.radical}
                </span>
                <AudioButton
                  text={currentRadical.radical}
                  id={`rad-fc-front-${currentRadical.id}`}
                  size="md"
                  variant="subtle"
                  tooltip="Nghe phát âm bộ thủ"
                />
              </div>
              <div className="mt-4 flex items-center gap-2">
                <span className="text-xs px-2 py-0.5 rounded-full bg-accent-soft text-app-accent font-sans">
                  #{currentRadical.id}
                </span>
                <span className="text-xs px-2 py-0.5 rounded-full bg-page border border-border text-muted font-sans">
                  {currentRadical.strokes} nét
                </span>
              </div>
            </div>

            {/* Back */}
            <div
              className="w-full absolute inset-0 bg-card border border-border rounded-xl p-6 md:p-10 flex flex-col items-center justify-center min-h-[300px] md:min-h-[380px] shadow-sm"
              style={{ backfaceVisibility: 'hidden', transform: 'rotateY(180deg)' }}
            >
              <div className="flex items-center gap-3 mb-3">
                <span
                  className="text-5xl md:text-6xl font-serif text-title leading-none"
                  style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                >
                  {currentRadical.radical}
                </span>
                <AudioButton
                  text={currentRadical.radical}
                  id={`rad-fc-back-${currentRadical.id}`}
                  size="sm"
                  variant="ghost"
                  tooltip="Nghe phát âm bộ thủ"
                />
              </div>
              <p className="text-lg text-muted font-sans tracking-wide mb-1">
                {currentRadical.pinyin}
              </p>
              <p className="text-xl font-serif text-title font-medium mb-4">
                {currentRadical.meaning}
              </p>
              {currentRadical.variants.length > 0 && (
                <p className="text-sm text-muted font-serif mb-2">
                  Biến thể: <span className="text-title" style={{ fontFamily: 'var(--font-chinese), sans-serif' }}>{currentRadical.variants.join(' ')}</span>
                </p>
              )}
              <p className="text-sm font-serif text-body text-center leading-relaxed max-w-md mb-4">
                {currentRadical.explanation}
              </p>
              {currentRadical.examples.length > 0 && (
                <div className="flex flex-wrap gap-2 justify-center">
                  {currentRadical.examples.slice(0, 3).map((ex) => (
                    <div
                      key={ex.hanzi}
                      className="px-3 py-1.5 bg-page border border-border rounded-lg text-center flex items-center gap-1.5"
                    >
                      <span className="text-lg font-serif text-title" style={{ fontFamily: 'var(--font-chinese), sans-serif' }}>
                        {ex.hanzi}
                      </span>
                      <AudioButton
                        text={ex.hanzi}
                        id={`rad-fc-ex-${currentRadical.id}-${ex.hanzi}`}
                        size="xs"
                        variant="ghost"
                        tooltip={`Nghe ${ex.hanzi}`}
                      />
                      <span className="text-xs text-muted font-sans">{ex.pinyin}</span>
                      <span className="text-xs text-body font-serif">{ex.meaning}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>
        </button>
      </div>

      {/* Controls */}
      <div className="flex items-center justify-between">
        <div className="flex gap-2">
          <button
            onClick={handleShuffle}
            className={`flex items-center gap-1.5 px-3 py-2 border rounded-lg text-sm font-serif transition-all ${
              isShuffled
                ? 'border-app-accent bg-accent-soft text-app-accent'
                : 'border-border bg-card text-muted hover:text-title'
            }`}
            title="Xáo trộn"
          >
            <Shuffle className="w-4 h-4" />
            <span className="hidden sm:inline">Xáo trộn</span>
          </button>
          <button
            onClick={handleReset}
            className="flex items-center gap-1.5 px-3 py-2 border border-border bg-card rounded-lg text-sm font-serif text-muted hover:text-title transition-all"
            title="Về đầu"
          >
            <RotateCcw className="w-4 h-4" />
            <span className="hidden sm:inline">Về đầu</span>
          </button>
        </div>

        <div className="flex items-center gap-2">
          <button
            onClick={handleToggleLearned}
            className={`flex items-center gap-1.5 px-3 py-2 border rounded-lg text-sm font-serif transition-all ${
              getLearnedState(currentRadical.id)
                ? 'border-jade/30 bg-jade-soft text-jade'
                : 'border-border bg-card text-muted hover:text-jade'
            }`}
          >
            <CheckCircle className="w-4 h-4" />
            <span className="hidden sm:inline">{getLearnedState(currentRadical.id) ? 'Đã học' : 'Đã học?'}</span>
          </button>
        </div>
      </div>

      {/* Prev / Next */}
      <div className="flex justify-between items-center gap-4">
        <button
          onClick={goPrev}
          disabled={currentIndex === 0}
          className="flex items-center gap-2 px-4 py-2.5 bg-card border border-border rounded-lg text-sm font-serif transition-all disabled:opacity-40 disabled:cursor-not-allowed hover:border-border-strong text-muted hover:text-title"
        >
          <ArrowLeft className="w-4 h-4" />
          Trước
        </button>
        <button
          onClick={goNext}
          disabled={currentIndex === deck.length - 1}
          className="flex items-center gap-2 px-4 py-2.5 bg-card border border-border rounded-lg text-sm font-serif transition-all disabled:opacity-40 disabled:cursor-not-allowed hover:border-border-strong text-muted hover:text-title"
        >
          Tiếp
          <ArrowRight className="w-4 h-4" />
        </button>
      </div>
    </div>
  )
}
