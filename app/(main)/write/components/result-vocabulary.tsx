'use client'

import { BookOpen, Lightbulb, Sparkles, Volume2 } from 'lucide-react'
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
                className="bg-card border border-border rounded-xl p-4 shadow-2xs space-y-2 hover:border-app-accent/50 transition-colors"
              >
                {/* Word & Pinyin & Audio */}
                <div className="flex items-center justify-between gap-2">
                  <div className="flex items-baseline gap-2.5">
                    <span className="text-xl font-bold font-serif text-app-accent">
                      {item.word}
                    </span>
                    <span className="text-xs text-muted font-sans font-medium">
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
                  <strong className="text-title font-medium">Ý nghĩa:</strong> {item.meaning}
                </div>

                {/* Example sentence */}
                {item.example && (
                  <div className="p-2.5 bg-page rounded-lg border border-border/70 flex items-center justify-between gap-2 text-xs">
                    <div className="text-slate-700 italic min-w-0">
                      <span className="text-muted not-italic font-sans text-[11px] mr-1">Ví dụ:</span>
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
                className="bg-card border border-border rounded-xl p-3.5 shadow-2xs flex items-start gap-3 hover:border-border-strong transition-colors"
              >
                <span className="w-5 h-5 rounded-full bg-gold-soft text-gold font-bold text-xs flex items-center justify-center shrink-0 mt-0.5">
                  {idx + 1}
                </span>
                <p className="text-xs text-body leading-relaxed">
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
