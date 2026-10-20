'use client'

import Link from 'next/link'
import { Radical } from '@/data/radicals'
import { getHanViet } from '@/data/radical-hanviet'
import { useState, useEffect } from 'react'
import { isLearned, isFavorite } from '@/lib/radicals-storage'
import { CheckCircle, Heart } from 'lucide-react'

interface RadicalCardProps {
  radical: Radical
  variant?: 'horizontal' | 'compact'
}

export default function RadicalCard({ radical, variant = 'horizontal' }: RadicalCardProps) {
  const [learned, setLearned] = useState(false)
  const [favorite, setFavorite] = useState(false)

  useEffect(() => {
    setLearned(isLearned(radical.id))
    setFavorite(isFavorite(radical.id))
  }, [radical.id])

  const hanViet = getHanViet(radical.id, radical.meaning)

  // Giao diện thẻ ngang chi tiết (chuẩn như hình mẫu phân tách)
  if (variant === 'horizontal') {
    return (
      <Link
        href={`/radicals/${radical.id}`}
        className="group relative bg-card border border-border/80 hover:border-app-accent/60 rounded-xl p-3 md:p-3.5 hover:shadow-sm transition-all duration-200 flex items-start gap-3 md:gap-3.5 overflow-hidden"
      >
        {/* Khối chữ Hán vuông nền tối (Dark tile bên trái) */}
        <div
          className="w-14 h-14 md:w-16 md:h-16 flex-shrink-0 rounded-lg bg-[#252830] dark:bg-[#1A1C22] text-white flex items-center justify-center border border-black/20 shadow-inner group-hover:bg-[#1C1E25] transition-colors"
        >
          <span
            className="text-3xl md:text-4xl font-serif text-white leading-none select-none"
            style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
          >
            {radical.radical}
          </span>
        </div>

        {/* Cột thông tin chi tiết bên phải */}
        <div className="flex-1 min-w-0 pr-6">
          {/* Dòng tiêu đề: Tên Hán Việt, #Thứ tự, Biến thể */}
          <div className="flex items-center gap-1.5 flex-wrap leading-none">
            <span className="font-serif font-bold text-base md:text-lg text-title group-hover:text-app-accent transition-colors">
              {hanViet}
            </span>
            <span className="text-xs text-muted font-sans font-normal">
              #{radical.id}
            </span>
            {radical.variants && radical.variants.length > 0 && (
              <span className="text-[11px] font-serif px-1.5 py-0.5 rounded border border-border/80 bg-page/80 text-muted">
                {`{ ${radical.variants.join(' ')} }`}
              </span>
            )}
          </div>

          {/* Dòng mô tả ý nghĩa (như trong ảnh mẫu) */}
          <p className="text-xs md:text-[13px] text-body/85 font-serif leading-relaxed line-clamp-2 md:line-clamp-3 mt-1.5">
            {radical.explanation || radical.meaning}
          </p>
        </div>

        {/* Trạng thái đã học / yêu thích (góc trên bên phải) */}
        {(learned || favorite) && (
          <div className="absolute top-2 right-2 flex items-center gap-1">
            {learned && (
              <span className="text-jade" title="Đã học">
                <CheckCircle className="w-3.5 h-3.5" />
              </span>
            )}
            {favorite && (
              <span className="text-app-accent" title="Yêu thích">
                <Heart className="w-3.5 h-3.5 fill-current" />
              </span>
            )}
          </div>
        )}
      </Link>
    )
  }

  // Giao diện dạng thẻ vuông gọn
  return (
    <Link
      href={`/radicals/${radical.id}`}
      className="group relative bg-card border border-border rounded-lg p-3 md:p-4 hover:border-app-accent/50 hover:shadow-md transition-all duration-200 flex flex-col items-center text-center overflow-hidden"
    >
      {(learned || favorite) && (
        <div className="absolute top-1.5 right-1.5 flex gap-1">
          {learned && (
            <span className="w-4 h-4 text-jade" title="Đã học">
              <CheckCircle className="w-4 h-4" />
            </span>
          )}
          {favorite && (
            <span className="w-4 h-4 text-app-accent" title="Yêu thích">
              <Heart className="w-4 h-4 fill-current" />
            </span>
          )}
        </div>
      )}

      <span className="absolute top-1.5 left-2 text-[10px] text-muted font-sans">
        #{radical.id}
      </span>

      <span
        className="text-4xl md:text-5xl font-serif text-title group-hover:text-app-accent transition-colors leading-none mt-3 mb-2"
        style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
      >
        {radical.radical}
      </span>

      <span className="text-sm font-serif font-bold text-title mb-0.5">
        {hanViet}
      </span>

      <span className="text-xs text-muted font-sans tracking-wide mb-1">
        {radical.pinyin}
      </span>

      <span className="text-xs text-body font-serif line-clamp-1">
        {radical.meaning}
      </span>

      <span className="mt-1.5 text-[10px] px-2 py-0.5 rounded-full bg-accent-soft text-app-accent font-sans">
        {radical.strokes} nét
      </span>
    </Link>
  )
}
