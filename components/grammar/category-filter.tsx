'use client'

import React from 'react'

interface CategoryFilterProps {
  categories: { name: string; count: number }[]
  selectedCategory: string
  onSelectCategory: (category: string) => void
  totalCount: number
}

export function CategoryFilter({
  categories,
  selectedCategory,
  onSelectCategory,
  totalCount,
}: CategoryFilterProps) {
  return (
    <div className="flex items-center gap-2 overflow-x-auto pb-2 scrollbar-none py-1 select-none">
      {/* Nút Tất cả */}
      <button
        type="button"
        onClick={() => onSelectCategory('all')}
        className={`shrink-0 inline-flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-semibold transition-all cursor-pointer shadow-2xs ${
          selectedCategory === 'all'
            ? 'bg-[#B8322D] border-2 border-[#B8322D] text-white shadow-sm ring-2 ring-[#B8322D]/20'
            : 'bg-white dark:bg-[#1E2530] text-[#334155] dark:text-[#E2E8F0] border-2 border-[#DAC7B6] dark:border-slate-700 hover:border-[#B8322D] hover:text-[#B8322D] hover:bg-[#FFF9F3] dark:hover:bg-slate-800'
        }`}
      >
        <span>Tất cả</span>
        <span
          className={`px-1.5 py-0.5 rounded-full text-[11px] font-mono font-bold leading-none ${
            selectedCategory === 'all'
              ? 'bg-white/25 text-white'
              : 'bg-[#F1E5DA] dark:bg-slate-800 text-[#475569] dark:text-slate-300'
          }`}
        >
          {totalCount}
        </span>
      </button>

      {/* Từng phân nhóm ngữ pháp */}
      {categories.map((cat) => {
        const isSelected = selectedCategory === cat.name
        return (
          <button
            key={cat.name}
            type="button"
            onClick={() => onSelectCategory(cat.name)}
            className={`shrink-0 inline-flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-semibold transition-all cursor-pointer shadow-2xs ${
              isSelected
                ? 'bg-[#B8322D] border-2 border-[#B8322D] text-white shadow-sm ring-2 ring-[#B8322D]/20'
                : 'bg-white dark:bg-[#1E2530] text-[#334155] dark:text-[#E2E8F0] border-2 border-[#DAC7B6] dark:border-slate-700 hover:border-[#B8322D] hover:text-[#B8322D] hover:bg-[#FFF9F3] dark:hover:bg-slate-800'
            }`}
          >
            <span>{cat.name}</span>
            <span
              className={`px-1.5 py-0.5 rounded-full text-[11px] font-mono font-bold leading-none ${
                isSelected
                  ? 'bg-white/25 text-white'
                  : 'bg-[#F1E5DA] dark:bg-slate-800 text-[#475569] dark:text-slate-300'
              }`}
            >
              {cat.count}
            </span>
          </button>
        )
      })}
    </div>
  )
}
