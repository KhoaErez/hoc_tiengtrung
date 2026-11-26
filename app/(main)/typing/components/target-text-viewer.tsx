'use client'

import React, { Fragment, type MutableRefObject } from 'react'
import { AlignLeft, EyeOff, Layers, Volume2 } from 'lucide-react'
import type { IndexedCharMap, StatelessTypingEvaluation } from '@/lib/typing-text-utils'
import type { TypingDisplayMode, UnifiedTypingSentence } from '@/lib/typing-sentence-model'

export interface TypingTargetViewerProps {
  displayMode: TypingDisplayMode
  onSwitchDisplayMode: (mode: TypingDisplayMode) => void
  showModeSwitcher?: boolean
  hideSample?: boolean
  hideSampleFallback?: React.ReactNode
  showPinyin: boolean
  showMeaning: boolean
  evaluation: StatelessTypingEvaluation
  indexedTarget: IndexedCharMap
  sentences: UnifiedTypingSentence[]
  speakingSentenceIndex: number | null
  speechHighlightRange: { startCp: number; endCp: number } | null
  isCompleted: boolean
  activeCharRef: MutableRefObject<HTMLSpanElement | null>
  activeCardRef: MutableRefObject<HTMLDivElement | null>
  fontSizeClass?: string
  /** Dùng cho bài mẫu có sẵn khi nghĩa chỉ lưu ở cấp cả đoạn văn */
  fallbackOverallMeaning?: string
}

export default function TypingTargetViewer({
  displayMode,
  onSwitchDisplayMode,
  showModeSwitcher = true,
  hideSample = false,
  hideSampleFallback,
  showPinyin,
  showMeaning,
  evaluation,
  indexedTarget,
  sentences,
  speakingSentenceIndex,
  speechHighlightRange,
  isCompleted,
  activeCharRef,
  activeCardRef,
  fontSizeClass = 'text-lg md:text-xl',
  fallbackOverallMeaning,
}: TypingTargetViewerProps) {
  // Render duy nhất một ký tự Unicode theo global code-point index (`cpIdx`)
  const renderCharSpan = (cpIdx: number) => {
    const char = evaluation.targetChars[cpIdx]
    if (char === undefined) return null

    const status = evaluation.charStates[cpIdx] ?? 'pending'
    const isAudioHighlighted =
      speechHighlightRange !== null &&
      cpIdx >= speechHighlightRange.startCp &&
      cpIdx < speechHighlightRange.endCp

    let charStyle = 'text-title/85'
    if (status === 'correct') {
      charStyle = isAudioHighlighted
        ? 'bg-emerald-500/25 text-emerald-800 dark:text-emerald-300 font-bold rounded px-0.5 ring-1 ring-amber-400'
        : 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 rounded px-0.5'
    } else if (status === 'incorrect') {
      charStyle =
        'bg-red-500/20 text-red-600 dark:text-red-400 rounded px-0.5 underline decoration-red-500 font-bold'
    } else if (status === 'active') {
      charStyle =
        'border-b-2 border-app-accent bg-accent-soft/45 text-title font-bold animate-pulse rounded-t px-0.5'
    } else if (status === 'ignored') {
      charStyle = 'text-muted/35'
    } else if (isAudioHighlighted) {
      charStyle =
        'bg-amber-200/85 dark:bg-amber-900/65 text-amber-950 dark:text-amber-100 font-bold ring-1 ring-amber-400/80 rounded px-0.5'
    }

    if (char === '\n') {
      return (
        <Fragment key={cpIdx}>
          <span
            ref={status === 'active' ? activeCharRef : undefined}
            className={`inline-flex items-center justify-center px-1 mx-0.5 rounded text-xs font-mono align-baseline select-none transition-colors ${charStyle}`}
            title="Xuống dòng (Enter)"
          >
            ↵
          </span>
          <span className="basis-full h-0" aria-hidden="true" />
        </Fragment>
      )
    }

    return (
      <span
        key={cpIdx}
        ref={status === 'active' ? activeCharRef : undefined}
        className={`inline-block transition-colors ${charStyle}`}
      >
        {char}
      </span>
    )
  }

  const effectiveMode: TypingDisplayMode =
    showModeSwitcher && sentences.length > 0 ? displayMode : 'continuous_paragraph'

  return (
    <div className="bg-card border border-border rounded-2xl p-4 sm:p-5 md:p-6 shadow-sm space-y-3.5">
      {/* Thanh tiêu đề: Văn bản mẫu mục tiêu + Segmented Control (trái) & Thống kê Đúng | Sai | Còn thiếu (phải) */}
      <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-2.5 text-xs font-serif text-muted pb-2 border-b border-border/60">
        <div className="flex items-center gap-2.5 flex-wrap">
          <span className="font-bold text-title shrink-0">Văn bản mẫu mục tiêu:</span>

          {showModeSwitcher && sentences.length > 0 && (
            <div
              role="tablist"
              aria-label="Chế độ hiển thị văn bản mẫu"
              className="inline-flex items-center p-0.5 rounded-xl bg-page border border-[#E9DDD1] dark:border-[#384869] shadow-2xs"
            >
              <button
                type="button"
                role="tab"
                aria-selected={effectiveMode === 'sentence_cards'}
                onClick={() => onSwitchDisplayMode('sentence_cards')}
                className={`inline-flex items-center gap-1.5 px-2.5 sm:px-3 py-1.5 rounded-lg text-[11px] sm:text-xs font-serif transition-all cursor-pointer touch-manipulation ${
                  effectiveMode === 'sentence_cards'
                    ? 'bg-[#B8322D] text-white font-bold shadow-2xs'
                    : 'text-[#243047]/75 dark:text-slate-300 hover:text-[#243047] hover:bg-white/70 dark:hover:bg-white/5'
                }`}
              >
                <Layers className="w-3.5 h-3.5 shrink-0" />
                <span>Từng câu (Pinyin &amp; Dịch)</span>
              </button>

              <button
                type="button"
                role="tab"
                aria-selected={effectiveMode === 'continuous_paragraph'}
                onClick={() => onSwitchDisplayMode('continuous_paragraph')}
                className={`inline-flex items-center gap-1.5 px-2.5 sm:px-3 py-1.5 rounded-lg text-[11px] sm:text-xs font-serif transition-all cursor-pointer touch-manipulation ${
                  effectiveMode === 'continuous_paragraph'
                    ? 'bg-[#243047] dark:bg-[#0D9488] text-white font-bold shadow-2xs'
                    : 'text-[#243047]/75 dark:text-slate-300 hover:text-[#243047] hover:bg-white/70 dark:hover:bg-white/5'
                }`}
              >
                <AlignLeft className="w-3.5 h-3.5 shrink-0" />
                <span>Cả đoạn dài (Tập trung gõ)</span>
              </button>
            </div>
          )}
        </div>

        {/* Cụm thống kê thời gian thực (Stateless): Đúng | Sai | Còn thiếu */}
        <div className="flex items-center gap-3 shrink-0">
          <span className="flex items-center gap-1">
            <span className="w-2.5 h-2.5 rounded bg-emerald-500/20 border border-emerald-500 inline-block" />
            <span>
              Đúng: <strong className="text-emerald-700 dark:text-emerald-400">{evaluation.correctCount}</strong>
            </span>
          </span>
          <span className="text-border">|</span>
          <span className="flex items-center gap-1">
            <span className="w-2.5 h-2.5 rounded bg-red-500/20 border border-red-500 inline-block" />
            <span>
              Sai: <strong className="text-red-600 dark:text-red-400">{evaluation.errorCount}</strong>
            </span>
          </span>
          <span className="text-border">|</span>
          <span>
            Còn thiếu: <strong className="text-title">{evaluation.missingCount}</strong>
          </span>
        </div>
      </div>

      {/* Nội dung hiển thị theo 2 chế độ hoặc trạng thái Ẩn mẫu */}
      {hideSample && !isCompleted ? (
        hideSampleFallback || (
          <div className="p-8 text-center rounded-xl bg-page border border-border text-muted italic font-serif text-sm flex items-center justify-center gap-2">
            <EyeOff className="w-4 h-4 text-muted" />
            <span>Văn bản mẫu đang ẩn để thử thách trí nhớ. Hãy gõ từ ký ức hoặc mở lại!</span>
          </div>
        )
      ) : effectiveMode === 'sentence_cards' ? (
        /* CHẾ ĐỘ 1: TỪNG CÂU (PINYIN & DỊCH) */
        <div className="space-y-3 max-h-[26rem] overflow-y-auto no-scrollbar pr-1">
          {sentences.map((sentence, sIdx) => {
            const isSpeaking = speakingSentenceIndex === sIdx
            const prevEndCp = sIdx === 0 ? 0 : sentences[sIdx - 1].endCp
            const gapStartCp = prevEndCp
            const gapEndCp = sentence.startCp

            const nextSentenceStartCp =
              sIdx + 1 < sentences.length ? sentences[sIdx + 1].startCp : evaluation.targetChars.length + 1

            const isSentenceActive =
              !isCompleted &&
              ((evaluation.activeCharIndex >= sentence.startCp &&
                evaluation.activeCharIndex < nextSentenceStartCp) ||
                (sIdx === 0 && evaluation.activeCharIndex < sentence.startCp))

            const isSentenceCompleted =
              evaluation.inputChars.length >= sentence.endCp && !isSentenceActive

            const spokenPhrase =
              isSpeaking && speechHighlightRange
                ? evaluation.targetChars
                    .slice(
                      Math.max(sentence.startCp, speechHighlightRange.startCp),
                      Math.min(sentence.endCp, speechHighlightRange.endCp)
                    )
                    .join('')
                : ''

            return (
              <div
                key={`${sentence.index}-${sentence.startCp}`}
                className="space-y-1.5"
              >
                {/* Ký tự ngắt đoạn / khoảng trắng giữa các câu (nếu có) */}
                {gapEndCp > gapStartCp && (
                  <div className="text-muted/50 font-mono text-xs whitespace-pre-wrap select-none px-1 flex flex-wrap items-baseline">
                    {indexedTarget.items.slice(gapStartCp, gapEndCp).map((it) => renderCharSpan(it.cpIdx))}
                  </div>
                )}

                <div
                  ref={isSentenceActive ? activeCardRef : undefined}
                  className={`p-3.5 md:p-4 rounded-xl border-2 transition-all text-left space-y-2 ${
                    isSentenceActive
                      ? 'bg-page border-[#B8322D] dark:border-red-500 shadow-sm ring-2 ring-[#B8322D]/15'
                      : isSpeaking
                      ? 'bg-page border-amber-500/80 shadow-xs ring-2 ring-amber-400/25'
                      : isSentenceCompleted
                      ? 'bg-page/55 border-border/70 opacity-90'
                      : 'bg-page/75 border-border/80'
                  }`}
                >
                  {/* Huy hiệu trạng thái câu (Đang gõ / Đang đọc) */}
                  {(isSentenceActive || isSpeaking) && (
                    <div className="flex items-center justify-between gap-2 pb-0.5 flex-wrap">
                      {isSentenceActive && (
                        <span className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md text-[10px] font-sans font-bold bg-[#B8322D]/10 text-[#B8322D] border border-[#B8322D]/25">
                          <span className="w-1.5 h-1.5 rounded-full bg-[#B8322D] animate-pulse" />
                          <span>Câu {sIdx + 1}/{sentences.length} • Đang gõ</span>
                        </span>
                      )}

                      {isSpeaking && (
                        <span className="inline-flex items-center gap-1.5 text-amber-700 dark:text-amber-300 font-sans text-xs font-bold animate-pulse ml-auto">
                          <Volume2 className="w-3.5 h-3.5 animate-bounce shrink-0" />
                          <span>
                            Đang đọc câu {sIdx + 1}
                            {spokenPhrase ? `: "${spokenPhrase}"` : '...'}
                          </span>
                        </span>
                      )}
                    </div>
                  )}

                  {/* Tầng 1 (Trên): Pinyin màu đỏ cam đồng bộ theo từ & phát âm */}
                  {showPinyin && sentence.words.some((w) => Boolean(w.pinyin)) && (
                    <div className="flex flex-wrap items-baseline gap-x-1.5 gap-y-0.5 select-none leading-relaxed">
                      {sentence.words.map((w) => {
                        const isWordActive =
                          isSpeaking &&
                          speechHighlightRange !== null &&
                          w.isWord &&
                          w.startCp < speechHighlightRange.endCp &&
                          w.endCp > speechHighlightRange.startCp
                        const isWordPast =
                          isSpeaking &&
                          speechHighlightRange !== null &&
                          w.isWord &&
                          w.endCp <= speechHighlightRange.startCp
                        const isSentenceFallback =
                          isSpeaking && speechHighlightRange === null && w.isWord

                        if (!w.pinyin) return null

                        return (
                          <span
                            key={w.index}
                            className={`transition-colors duration-150 rounded px-1 text-xs md:text-sm font-sans ${
                              isWordActive
                                ? 'text-amber-950 dark:text-amber-100 font-bold bg-amber-200/85 dark:bg-amber-900/65 ring-1 ring-amber-400/80 shadow-2xs'
                                : isSentenceFallback
                                ? 'text-amber-900 dark:text-amber-200 font-semibold bg-amber-100/70 dark:bg-amber-950/40 ring-1 ring-amber-300/50'
                                : isWordPast
                                ? 'text-[#C84B31]/60 dark:text-orange-400/60'
                                : 'text-[#C84B31] dark:text-orange-400 font-medium'
                            }`}
                          >
                            {w.pinyin}
                          </span>
                        )
                      })}
                    </div>
                  )}

                  {/* Tầng 2 (Giữa): Hàng chữ Hán dùng globalCharIndex đồng nhất với bộ so sánh & TTS */}
                  <div
                    className={`font-serif ${fontSizeClass} text-title leading-relaxed tracking-wide select-none flex flex-wrap items-baseline gap-y-1`}
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {sentence.words.map((w) => {
                      const isWordActive =
                        isSpeaking &&
                        speechHighlightRange !== null &&
                        w.isWord &&
                        w.startCp < speechHighlightRange.endCp &&
                        w.endCp > speechHighlightRange.startCp
                      const isSentenceFallback =
                        isSpeaking && speechHighlightRange === null && w.isWord

                      return (
                        <span
                          key={w.index}
                          className={`inline-flex flex-wrap items-baseline transition-all duration-150 rounded px-0.5 ${
                            isWordActive
                              ? 'bg-amber-100/75 dark:bg-amber-950/55 ring-1 ring-amber-400/80 font-bold'
                              : isSentenceFallback
                              ? 'bg-amber-50 dark:bg-amber-950/30 ring-1 ring-amber-300/40 font-medium'
                              : ''
                          }`}
                        >
                          {indexedTarget.items.slice(w.startCp, w.endCp).map((it) => renderCharSpan(it.cpIdx))}
                        </span>
                      )
                    })}
                  </div>

                  {/* Tầng 3 (Dưới): Nghĩa tiếng Việt in nghiêng (tự ẩn nếu câu chưa có dịch) */}
                  {showMeaning && sentence.meaning_vi && (
                    <p className="text-xs md:text-sm font-serif text-muted italic pt-1.5 border-t border-border/40 select-none">
                      {sentence.meaning_vi}
                    </p>
                  )}
                </div>
              </div>
            )
          })}

          {/* Ký tự còn lại ở cuối văn bản nếu có */}
          {sentences.length > 0 && sentences[sentences.length - 1].endCp < evaluation.targetChars.length && (
            <div className="text-muted/50 font-mono text-xs whitespace-pre-wrap select-none px-1 flex flex-wrap items-baseline">
              {indexedTarget.items
                .slice(sentences[sentences.length - 1].endCp)
                .map((it) => renderCharSpan(it.cpIdx))}
            </div>
          )}

          {/* Nghĩa tổng hợp của cả bài mẫu nếu nghĩa chưa tách được theo từng câu */}
          {showMeaning &&
            fallbackOverallMeaning &&
            !sentences.some((s) => Boolean(s.meaning_vi)) && (
              <p className="text-xs md:text-sm font-serif text-muted italic pt-2 border-t border-border/50 px-1 select-none">
                Ý nghĩa toàn đoạn: {fallbackOverallMeaning}
              </p>
            )}
        </div>
      ) : (
        /* CHẾ ĐỘ 2: CẢ ĐOẠN DÀI (TẬP TRUNG GÕ - Ẩn Pinyin & Dịch, đồng bộ hoàn toàn với TTS highlight & Auto-scroll) */
        <div className="space-y-2">
          {speakingSentenceIndex !== null && sentences[speakingSentenceIndex] && (
            <div className="p-2.5 rounded-xl bg-app-accent-soft/30 border border-app-accent/30 text-app-accent text-xs font-serif font-bold flex items-center gap-2">
              <Volume2 className="w-4 h-4 animate-bounce flex-shrink-0" />
              <span>
                Đang phát âm câu {speakingSentenceIndex + 1}
                {speechHighlightRange
                  ? `: "${evaluation.targetChars
                      .slice(speechHighlightRange.startCp, speechHighlightRange.endCp)
                      .join('')}"`
                  : `: "${sentences[speakingSentenceIndex].chinese}"`}
              </span>
            </div>
          )}
          <div
            className={`p-4 md:p-5 rounded-xl bg-page/80 border border-border/80 max-h-72 overflow-y-auto leading-relaxed font-serif ${fontSizeClass} text-title whitespace-pre-wrap select-none no-scrollbar tracking-wide flex flex-wrap items-baseline gap-y-1.5`}
            style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
          >
            {evaluation.targetChars.map((_, cpIdx) => renderCharSpan(cpIdx))}
          </div>
        </div>
      )}
    </div>
  )
}
