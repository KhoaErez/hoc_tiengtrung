'use client'

import React from 'react'
import { Volume2, Snail, Sparkles, BookOpen } from 'lucide-react'
import type { CourseVocabItem } from '@/data/course-roadmap-data'
import { ttsEngine } from '@/lib/tts/tts-engine'
import { useIsItemSpeaking } from '@/hooks/use-chinese-tts'
import { toast } from 'sonner'

interface VocabStepProps {
  vocab: CourseVocabItem
  showPinyin: boolean
  stepNumberInVocab: number
  totalVocabCount: number
}

export function VocabStep({
  vocab,
  showPinyin,
  stepNumberInVocab,
  totalVocabCount,
}: VocabStepProps) {
  const normalAudioId = `lesson-vocab-normal-${vocab.id}`
  const slowAudioId = `lesson-vocab-slow-${vocab.id}`
  const exampleAudioId = `lesson-vocab-ex-${vocab.id}`

  const isPlayingNormal = useIsItemSpeaking(normalAudioId)
  const isPlayingSlow = useIsItemSpeaking(slowAudioId)
  const isPlayingExample = useIsItemSpeaking(exampleAudioId)

  const playSpeech = (text: string, id: string, rate: number) => {
    if (!text.trim()) return
    if (ttsEngine.isSpeaking(id)) {
      ttsEngine.stop()
      return
    }
    if (!ttsEngine.hasChineseVoices() && ttsEngine.getVoices().length > 0) {
      toast.info('Trình duyệt chưa sẵn sàng giọng tiếng Trung (zh-CN).')
    }
    ttsEngine.speak(text, {
      id,
      rate,
      onError: () => {
        toast.error('Không thể phát âm thanh trên trình duyệt này.')
      },
    })
  }

  return (
    <div className="bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl p-5 sm:p-8 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322] space-y-6 animate-in fade-in duration-200">
      {/* Header badge */}
      <div className="flex items-center justify-between gap-2 flex-wrap">
        <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#B91C1C]/10 border border-[#B91C1C]/25 text-[#B91C1C] text-xs font-sans font-bold uppercase tracking-wider">
          <Sparkles className="w-3.5 h-3.5" />
          <span>
            Từ vựng mới {stepNumberInVocab}/{totalVocabCount}
          </span>
        </span>

        <span className="px-3 py-1 rounded-lg bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-300 dark:border-white/15 text-xs font-serif font-semibold text-stone-700 dark:text-slate-200">
          {vocab.partOfSpeech}
        </span>
      </div>

      {/* Trung tâm: Chữ Hán cỡ lớn, Pinyin, Nghĩa tiếng Việt */}
      <div className="text-center space-y-3 py-2">
        <div
          className="text-5xl sm:text-6xl md:text-7xl font-hanzi font-bold text-stone-900 dark:text-white tracking-wider leading-tight select-all"
          style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
        >
          {vocab.hanzi}
        </div>

        <div className="min-h-[28px] flex items-center justify-center">
          {showPinyin ? (
            <span className="text-lg sm:text-xl font-sans font-semibold text-[#B91C1C] tracking-wide">
              {vocab.pinyin}
            </span>
          ) : (
            <span className="text-xs font-serif text-stone-400 italic px-3 py-0.5 rounded-full bg-stone-100 dark:bg-white/5">
              Pinyin đang ẩn (bật ở thanh trên nếu cần)
            </span>
          )}
        </div>

        <p className="text-xl sm:text-2xl font-serif font-bold text-stone-800 dark:text-slate-100">
          {vocab.meaningVi}
        </p>

        {/* Nút nghe phát âm (Bình thường 1.0x & Chậm 0.75x) */}
        <div className="flex items-center justify-center gap-3 pt-2 flex-wrap">
          <button
            type="button"
            onClick={() => playSpeech(vocab.hanzi, normalAudioId, 1.0)}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl border-2 text-xs sm:text-sm font-serif font-bold transition-all cursor-pointer min-h-[44px] touch-manipulation ${
              isPlayingNormal
                ? 'bg-[#B91C1C] text-white border-stone-900 shadow-[0_2px_0_#1c1917]'
                : 'bg-[#FAF7F2] dark:bg-[#202B45] text-stone-900 dark:text-white border-stone-900 dark:border-[#384869] hover:bg-stone-100 shadow-[0_3px_0_#1c1917] active:translate-y-0.5'
            }`}
          >
            <Volume2 className={`w-4 h-4 shrink-0 ${isPlayingNormal ? 'animate-pulse' : 'text-[#B91C1C]'}`} />
            <span>Nghe chuẩn (1.0x)</span>
          </button>

          <button
            type="button"
            onClick={() => playSpeech(vocab.hanzi, slowAudioId, 0.75)}
            className={`inline-flex items-center gap-2 px-4 py-2.5 rounded-xl border-2 text-xs sm:text-sm font-serif font-bold transition-all cursor-pointer min-h-[44px] touch-manipulation ${
              isPlayingSlow
                ? 'bg-stone-900 text-white border-stone-900 shadow-[0_2px_0_#1c1917]'
                : 'bg-white dark:bg-[#202B45] text-stone-800 dark:text-slate-200 border-stone-900 dark:border-[#384869] hover:bg-stone-50 shadow-[0_3px_0_#1c1917] active:translate-y-0.5'
            }`}
            title="Phát âm chậm 0.75x để nghe rõ thanh điệu"
          >
            <Snail className={`w-4 h-4 shrink-0 ${isPlayingSlow ? 'animate-pulse text-amber-300' : 'text-stone-700 dark:text-slate-300'}`} />
            <span>Đọc chậm (0.75x)</span>
          </button>
        </div>
      </div>

      {/* Câu ví dụ thực tế đi kèm (bấm để nghe câu) */}
      <button
        type="button"
        onClick={() => playSpeech(vocab.exampleHanzi, exampleAudioId, 1.0)}
        className={`w-full text-left rounded-2xl border-2 p-4 sm:p-5 transition-all cursor-pointer group ${
          isPlayingExample
            ? 'bg-red-50/70 dark:bg-[#202B45] border-[#B91C1C] ring-2 ring-[#B91C1C]/20'
            : 'bg-[#FAF7F2] dark:bg-[#202B45] border-stone-300 dark:border-white/15 hover:border-stone-900'
        }`}
        title="Bấm để nghe cả câu ví dụ"
      >
        <div className="flex items-center justify-between gap-2 mb-2">
          <span className="inline-flex items-center gap-1.5 text-[11px] font-sans font-bold uppercase tracking-wider text-stone-500 dark:text-slate-400">
            <BookOpen className="w-3.5 h-3.5 text-[#B91C1C]" />
            <span>Câu ví dụ thực tế (Bấm để nghe)</span>
          </span>

          <span
            className={`w-8 h-8 rounded-full flex items-center justify-center border transition-colors shrink-0 ${
              isPlayingExample
                ? 'bg-[#B91C1C] text-white border-[#B91C1C]'
                : 'bg-white dark:bg-[#182238] text-[#B91C1C] border-stone-300 group-hover:border-stone-900'
            }`}
          >
            <Volume2 className={`w-4 h-4 ${isPlayingExample ? 'animate-pulse' : ''}`} />
          </span>
        </div>

        <p
          className="text-lg sm:text-xl font-hanzi font-semibold text-stone-900 dark:text-white leading-snug"
          style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
        >
          {vocab.exampleHanzi}
        </p>

        {showPinyin && (
          <p className="text-xs sm:text-sm font-sans text-[#B91C1C] font-medium mt-1">
            {vocab.examplePinyin}
          </p>
        )}

        <p className="text-xs sm:text-sm font-serif text-stone-600 dark:text-slate-300 italic mt-1.5">
          “{vocab.exampleVi}”
        </p>
      </button>
    </div>
  )
}
