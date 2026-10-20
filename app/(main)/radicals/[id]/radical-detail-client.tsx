'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { Radical } from '@/data/radicals'
import { toggleLearned, toggleFavorite, isLearned, isFavorite } from '@/lib/radicals-storage'
import {
  ArrowLeft,
  ArrowRight,
  CheckCircle,
  Heart,
  Hash,
  Pen,
  BookOpen,
  Lightbulb,
  Layers,
} from 'lucide-react'
import { AudioButton } from '@/components/ui/audio-button'

export default function RadicalDetailClient({ radical }: { radical: Radical }) {
  const [learned, setLearned] = useState(false)
  const [favorite, setFavorite] = useState(false)

  useEffect(() => {
    setLearned(isLearned(radical.id))
    setFavorite(isFavorite(radical.id))
  }, [radical.id])

  const handleToggleLearned = () => {
    const newState = toggleLearned(radical.id)
    setLearned(newState)
  }

  const handleToggleFavorite = () => {
    const newState = toggleFavorite(radical.id)
    setFavorite(newState)
  }

  const prevId = radical.id > 1 ? radical.id - 1 : null
  const nextId = radical.id < 214 ? radical.id + 1 : null

  return (
    <div className="space-y-6">
      {/* Breadcrumb + Navigation */}
      <div className="flex items-center justify-between">
        <Link
          href="/radicals"
          className="flex items-center gap-2 text-muted hover:text-app-accent transition-colors font-serif text-sm"
        >
          <ArrowLeft className="w-4 h-4" />
          Danh sách bộ thủ
        </Link>
        <div className="flex items-center gap-2">
          {prevId && (
            <Link
              href={`/radicals/${prevId}`}
              className="p-2 border border-border rounded-lg text-muted hover:text-title hover:border-border-strong transition-all"
              title={`Bộ thủ #${prevId}`}
            >
              <ArrowLeft className="w-4 h-4" />
            </Link>
          )}
          <span className="text-xs text-muted font-sans">
            {radical.id} / 214
          </span>
          {nextId && (
            <Link
              href={`/radicals/${nextId}`}
              className="p-2 border border-border rounded-lg text-muted hover:text-title hover:border-border-strong transition-all"
              title={`Bộ thủ #${nextId}`}
            >
              <ArrowRight className="w-4 h-4" />
            </Link>
          )}
        </div>
      </div>

      {/* Main card */}
      <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
        {/* Header with large radical */}
        <div className="bg-gradient-to-br from-accent-soft/60 to-card p-6 md:p-10 text-center border-b border-border">
          <div className="inline-block relative">
            <span
              className="text-7xl md:text-9xl font-serif text-title leading-none"
              style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
            >
              {radical.radical}
            </span>
            <div className="absolute -bottom-2 -right-4">
              <AudioButton 
                text={radical.radical} 
                id={`radical-${radical.id}`} 
                size="md" 
                variant="subtle" 
                tooltip="Nghe phát âm bộ thủ" 
              />
            </div>
          </div>
          <div className="mt-4 space-y-1">
            <p className="text-lg md:text-xl text-muted font-sans tracking-wide">
              {radical.pinyin}
            </p>
            <p className="text-xl md:text-2xl font-serif text-title font-medium">
              {radical.meaning}
            </p>
          </div>

          {/* Action buttons */}
          <div className="flex justify-center gap-3 mt-6">
            <button
              onClick={handleToggleLearned}
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-serif transition-all border ${
                learned
                  ? 'bg-jade-soft border-jade/30 text-jade'
                  : 'bg-card border-border text-muted hover:border-jade/30 hover:text-jade'
              }`}
            >
              <CheckCircle className="w-4 h-4" />
              {learned ? 'Đã học' : 'Đánh dấu đã học'}
            </button>
            <button
              onClick={handleToggleFavorite}
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-serif transition-all border ${
                favorite
                  ? 'bg-accent-soft border-app-accent/30 text-app-accent'
                  : 'bg-card border-border text-muted hover:border-app-accent/30 hover:text-app-accent'
              }`}
            >
              <Heart className={`w-4 h-4 ${favorite ? 'fill-current' : ''}`} />
              {favorite ? 'Đã thích' : 'Yêu thích'}
            </button>
          </div>
        </div>

        {/* Info grid */}
        <div className="p-5 md:p-8 space-y-6">
          {/* Meta info */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            <div className="flex items-center gap-2.5 p-3 bg-page rounded-lg border border-border">
              <Hash className="w-4 h-4 text-muted flex-shrink-0" />
              <div>
                <p className="text-[10px] text-muted uppercase tracking-wider">Thứ tự</p>
                <p className="text-sm font-serif text-title font-medium">#{radical.id}</p>
              </div>
            </div>
            <Link
              href={`/radicals?strokes=${radical.strokes}`}
              className="flex items-center gap-2.5 p-3 bg-page rounded-lg border border-border hover:border-app-accent/50 hover:bg-card transition-all group"
              title={`Xem danh sách các bộ thủ ${radical.strokes} nét`}
            >
              <Pen className="w-4 h-4 text-muted group-hover:text-app-accent transition-colors flex-shrink-0" />
              <div>
                <p className="text-[10px] text-muted uppercase tracking-wider">Số nét</p>
                <p className="text-sm font-serif text-title font-medium group-hover:text-app-accent transition-colors">
                  {radical.strokes} nét
                </p>
              </div>
            </Link>
            {radical.variants.length > 0 && (
              <div className="flex items-center gap-2.5 p-3 bg-page rounded-lg border border-border">
                <Layers className="w-4 h-4 text-muted flex-shrink-0" />
                <div>
                  <p className="text-[10px] text-muted uppercase tracking-wider">Biến thể</p>
                  <p className="text-sm font-serif text-title font-medium" style={{ fontFamily: 'var(--font-chinese), sans-serif' }}>
                    {radical.variants.join(' ')}
                  </p>
                </div>
              </div>
            )}
            {radical.original && (
              <div className="flex items-center gap-2.5 p-3 bg-page rounded-lg border border-border">
                <BookOpen className="w-4 h-4 text-muted flex-shrink-0" />
                <div>
                  <p className="text-[10px] text-muted uppercase tracking-wider">Dạng gốc</p>
                  <p className="text-lg font-serif text-title" style={{ fontFamily: 'var(--font-chinese), sans-serif' }}>
                    {radical.original}
                  </p>
                </div>
              </div>
            )}
          </div>

          {/* Explanation */}
          <div className="p-4 bg-gold-soft/50 border border-gold/20 rounded-lg">
            <div className="flex gap-2.5">
              <Lightbulb className="w-4 h-4 text-gold flex-shrink-0 mt-0.5" />
              <div>
                <p className="text-xs text-gold font-medium uppercase tracking-wider mb-1">Giải thích</p>
                <p className="text-sm font-serif text-body leading-relaxed">{radical.explanation}</p>
              </div>
            </div>
          </div>

          {/* Examples */}
          {radical.examples.length > 0 && (
            <div className="space-y-3">
              <h3 className="text-sm font-medium text-muted uppercase tracking-wider flex items-center gap-2">
                <BookOpen className="w-4 h-4" />
                Chữ Hán liên quan
              </h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                {radical.examples.map((ex) => (
                  <div
                    key={ex.hanzi}
                    className="flex items-center justify-between p-3 bg-page border border-border rounded-lg hover:border-border-strong transition-colors"
                  >
                    <div className="flex items-center gap-3 min-w-0">
                      <span
                        className="text-3xl font-serif text-title flex-shrink-0 w-10 text-center"
                        style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                      >
                        {ex.hanzi}
                      </span>
                      <div className="min-w-0">
                        <p className="text-xs text-muted font-sans tracking-wide">{ex.pinyin}</p>
                        <p className="text-sm font-serif text-body truncate">{ex.meaning}</p>
                      </div>
                    </div>
                    <AudioButton 
                      text={ex.hanzi} 
                      id={`rad-ex-${ex.hanzi}`} 
                      size="xs" 
                      variant="ghost" 
                      tooltip="Nghe phát âm" 
                    />
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Bottom navigation */}
      <div className="flex justify-between items-center pt-2">
        {prevId ? (
          <Link
            href={`/radicals/${prevId}`}
            className="flex items-center gap-2 px-4 py-2.5 bg-card border border-border rounded-lg text-sm font-serif text-muted hover:text-title hover:border-border-strong transition-all"
          >
            <ArrowLeft className="w-4 h-4" />
            Bộ #{prevId}
          </Link>
        ) : (
          <div />
        )}
        {nextId ? (
          <Link
            href={`/radicals/${nextId}`}
            className="flex items-center gap-2 px-4 py-2.5 bg-card border border-border rounded-lg text-sm font-serif text-muted hover:text-title hover:border-border-strong transition-all"
          >
            Bộ #{nextId}
            <ArrowRight className="w-4 h-4" />
          </Link>
        ) : (
          <div />
        )}
      </div>
    </div>
  )
}
