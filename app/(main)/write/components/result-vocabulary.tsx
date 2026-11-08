'use client'

import { BookOpen, Lightbulb, Volume2 } from 'lucide-react'
import { AudioButton } from '@/components/ui/audio-button'

export interface VocabularySuggestionItem {
  word: string
  pinyin: string
  meaning: string
  example: string
}

interface ResultVocabularyProps {
  vocabularySuggestions?: VocabularySuggestionItem[]
  learningSuggestions?: string[]
}

export function ResultVocabulary({
  vocabularySuggestions = [],
  learningSuggestions = [],
}: ResultVocabularyProps) {
  const hasVocab = vocabularySuggestions.length > 0
  const hasTips = learningSuggestions.length > 0

  if (!hasVocab && !hasTips) {
    return (
      <div className="bg-card border border-border rounded-2xl p-8 text-center text-muted text-xs font-serif">
        <BookOpen className="w-8 h-8 mx-auto mb-2 opacity-30" />
        <p>Không có gợi ý từ vựng mới cho bài viết này.</p>
      </div>
    )
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 font-serif">
      {/* 1. Recommended Vocabulary */}
      <div className="space-y-3.5">
        <div className="flex items-center justify-between border-b border-border pb-2">
          <h3 className="font-bold text-sm text-title flex items-center gap-2">
            <BookOpen className="w-4 h-4 text-app-accent" />
            <span>Từ vựng & Mẫu câu nâng cao ({vocabularySuggestions.length})</span>
          </h3>
          <span className="text-[11px] text-muted font-sans">Nên ghi chú vào sổ tay</span>
        </div>

        {vocabularySuggestions.length === 0 ? (
          <p className="text-xs text-muted italic">Không có từ vựng bổ sung.</p>
        ) : (
          <div className="space-y-3">
            {vocabularySuggestions.map((item, idx) => (
              <div
                key={idx}
                className="bg-white border-2 border-[#182238] rounded-2xl p-4 shadow-[0_3px_0_#182238] space-y-2 hover:shadow-[0_5px_0_#182238] transition-all"
              >
                {/* Word & Pinyin & Audio */}
                <div className="flex items-center justify-between gap-2">
                  <div className="flex items-baseline gap-2.5">
                    <span className="text-xl font-bold font-serif text-[#B8322D]">
                      {item.word}
                    </span>
                    <span className="text-xs text-muted font-sans font-bold">
                      [{item.pinyin}]
                    </span>
                  </div>
                  <AudioButton
                    text={item.word}
                    id={`vocab-suggest-${idx}`}
                    size="xs"
                    variant="ghost"
                    tooltip="Nghe phát âm từ"
                  />
                </div>

                {/* Meaning */}
                <div className="text-xs text-body leading-relaxed">
                  <strong className="text-[#182238] font-bold">Ý nghĩa:</strong> {item.meaning}
                </div>

                {/* Example sentence */}
                {item.example && (
                  <div className="p-2.5 bg-[#FAF7F2] rounded-xl border border-[#182238]/15 flex items-center justify-between gap-2 text-xs">
                    <div className="text-[#182238] italic min-w-0 font-serif">
                      <span className="text-muted not-italic font-sans text-[11px] mr-1 font-bold">Ví dụ:</span>
                      {item.example}
                    </div>
                    <AudioButton
                      text={item.example}
                      id={`vocab-ex-${idx}`}
                      size="xs"
                      variant="subtle"
                      tooltip="Nghe câu ví dụ"
                    />
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>

      {/* 2. Strategic Learning Tips */}
      <div className="space-y-3.5">
        <div className="flex items-center justify-between border-b border-border pb-2">
          <h3 className="font-bold text-sm text-title flex items-center gap-2">
            <Lightbulb className="w-4 h-4 text-gold" />
            <span>Gợi ý cải thiện kỹ năng viết</span>
          </h3>
          <span className="text-[11px] text-muted font-sans">Chiến lược HSK</span>
        </div>

        {learningSuggestions.length === 0 ? (
          <p className="text-xs text-muted italic">Hãy tiếp tục phát huy phong độ viết nhé!</p>
        ) : (
          <div className="space-y-2.5">
            {learningSuggestions.map((tip, idx) => (
              <div
                key={idx}
                className="bg-white border-2 border-[#182238] rounded-2xl p-4 shadow-[0_3px_0_#182238] flex items-start gap-3 hover:shadow-[0_5px_0_#182238] transition-all"
              >
                <span className="w-5 h-5 rounded-full bg-[#FFF9F3] text-[#B8322D] border border-[#B8322D]/30 font-bold text-xs flex items-center justify-center shrink-0 mt-0.5 font-sans">
                  {idx + 1}
                </span>
                <p className="text-xs text-[#182238] leading-relaxed font-serif">
                  {tip}
                </p>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
