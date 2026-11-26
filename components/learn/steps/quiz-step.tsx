'use client'

import React, { useMemo, useRef, useState } from 'react'
import { Volume2, RotateCcw, HelpCircle, Keyboard, Sparkles } from 'lucide-react'
import {
  buildShuffledWordBank,
  type CourseQuizQuestion,
} from '@/data/course-roadmap-data'
import { ttsEngine } from '@/lib/tts/tts-engine'
import { useIsItemSpeaking } from '@/hooks/use-chinese-tts'
import { toast } from 'sonner'

export interface WordBankSelectionItem {
  id: string
  text: string
}

interface QuizStepProps {
  question: CourseQuizQuestion
  quizNumber: number
  totalQuizzes: number
  showPinyin: boolean
  isChecked: boolean
  isCorrectResult?: boolean
  // State cho từng dạng bài tập
  selectedOptionId: string | null
  onSelectOption: (optionId: string) => void
  selectedBankItems: WordBankSelectionItem[]
  onUpdateBankItems: (items: WordBankSelectionItem[]) => void
  typingInput: string
  onChangeTypingInput: (val: string) => void
  onTriggerCheckOrNext: () => void
}

export function QuizStep({
  question,
  quizNumber,
  totalQuizzes,
  showPinyin,
  isChecked,
  selectedOptionId,
  onSelectOption,
  selectedBankItems,
  onUpdateBankItems,
  typingInput,
  onChangeTypingInput,
  onTriggerCheckOrNext,
}: QuizStepProps) {
  const audioId = `lesson-quiz-audio-${question.id}`
  const isPlayingAudio = useIsItemSpeaking(audioId)

  // Bảo vệ bộ gõ tiếng Trung (IME Composition Events) giống chuẩn /typing
  const [isComposing, setIsComposing] = useState(false)
  const isComposingRef = useRef(false)
  const [compositionText, setCompositionText] = useState('')
  const lastCompositionEndTimeRef = useRef<number>(0)
  const [showTypingHint, setShowTypingHint] = useState(false)

  const shuffledBank = useMemo(() => {
    if (question.type !== 'word_bank') return []
    return buildShuffledWordBank(question)
  }, [question])

  const selectedIdsSet = useMemo(
    () => new Set(selectedBankItems.map((item) => item.id)),
    [selectedBankItems]
  )

  const playQuizAudio = (text?: string) => {
    if (!text?.trim()) return
    if (ttsEngine.isSpeaking(audioId)) {
      ttsEngine.stop()
      return
    }
    ttsEngine.speak(text, {
      id: audioId,
      rate: 0.95,
      onError: () => {
        toast.error('Không thể phát âm thanh trên trình duyệt.')
      },
    })
  }

  const questionTypeLabel =
    question.type === 'multiple_choice'
      ? 'Trắc nghiệm nghe / đọc'
      : question.type === 'word_bank'
      ? 'Ghép từ thành câu'
      : 'Gõ câu tiếng Trung (IME)'

  return (
    <div className="bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl p-5 sm:p-8 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322] space-y-6 animate-in fade-in duration-200">
      {/* Header dạng câu hỏi */}
      <div className="flex items-center justify-between gap-2 flex-wrap">
        <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#B91C1C]/10 border border-[#B91C1C]/25 text-[#B91C1C] text-xs font-sans font-bold uppercase tracking-wider">
          <Sparkles className="w-3.5 h-3.5" />
          <span>
            Bài tập {quizNumber}/{totalQuizzes}
          </span>
        </span>

        <span className="px-2.5 py-1 rounded-lg bg-[#FAF7F2] dark:bg-[#202B45] border border-stone-300 dark:border-white/15 text-xs font-serif font-semibold text-stone-700 dark:text-slate-200">
          {questionTypeLabel}
        </span>
      </div>

      {/* Câu hỏi & Nút nghe nếu có */}
      <div className="space-y-3">
        <h2 className="text-lg sm:text-xl font-serif font-bold text-stone-900 dark:text-white leading-snug">
          {question.promptVi}
        </h2>

        {question.type === 'multiple_choice' && question.promptSub && (
          <p className="text-xs font-serif text-stone-500 dark:text-slate-400">
            {question.promptSub}
          </p>
        )}

        {(question.type === 'multiple_choice' || question.type === 'word_bank') &&
          question.audioText && (
            <button
              type="button"
              onClick={() => playQuizAudio(question.audioText)}
              className={`inline-flex items-center gap-2 px-4 py-2 rounded-xl border-2 text-xs sm:text-sm font-serif font-bold transition-all cursor-pointer min-h-[42px] ${
                isPlayingAudio
                  ? 'bg-[#B91C1C] text-white border-stone-900'
                  : 'bg-[#FAF7F2] dark:bg-[#202B45] text-stone-900 dark:text-white border-stone-900 dark:border-[#384869] hover:bg-stone-100 shadow-[0_2px_0_#1c1917] active:translate-y-0.5'
              }`}
            >
              <Volume2 className={`w-4 h-4 ${isPlayingAudio ? 'animate-pulse' : 'text-[#B91C1C]'}`} />
              <span>{isPlayingAudio ? 'Đang phát...' : 'Nghe phát âm mẫu'}</span>
            </button>
          )}
      </div>

      {/* DẠNG 1: TRẮC NGHIỆM 4 Ô LỚN */}
      {question.type === 'multiple_choice' && (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
          {question.options.map((opt, idx) => {
            const letter = ['A', 'B', 'C', 'D'][idx] || String(idx + 1)
            const isSelected = selectedOptionId === opt.id
            const isCorrectOption = opt.id === question.correctOptionId

            let cardStyle =
              'bg-[#FAF9F6] dark:bg-[#202B45] border-stone-300 dark:border-white/15 hover:border-stone-900 text-stone-900 dark:text-white'

            if (!isChecked && isSelected) {
              cardStyle =
                'bg-red-50 dark:bg-[#B91C1C]/20 border-[#B91C1C] ring-2 ring-[#B91C1C]/20 text-stone-900 dark:text-white shadow-[0_3px_0_#991B1B]'
            } else if (isChecked) {
              if (isCorrectOption) {
                cardStyle =
                  'bg-emerald-50 dark:bg-emerald-950/50 border-emerald-600 text-emerald-950 dark:text-emerald-100 ring-2 ring-emerald-500/20'
              } else if (isSelected && !isCorrectOption) {
                cardStyle =
                  'bg-red-50 dark:bg-red-950/50 border-[#B91C1C] text-red-950 dark:text-red-100'
              } else {
                cardStyle = 'bg-stone-50 dark:bg-[#202B45]/50 border-stone-200 dark:border-white/10 opacity-60'
              }
            }

            return (
              <button
                key={opt.id}
                type="button"
                disabled={isChecked}
                onClick={() => onSelectOption(opt.id)}
                className={`flex items-start gap-3 p-4 rounded-2xl border-2 text-left transition-all min-h-[76px] touch-manipulation ${
                  isChecked ? 'cursor-default' : 'cursor-pointer active:scale-[0.99]'
                } ${cardStyle}`}
              >
                <span
                  className={`w-7 h-7 rounded-lg flex items-center justify-center text-xs font-sans font-bold shrink-0 border ${
                    isSelected && !isChecked
                      ? 'bg-[#B91C1C] text-white border-[#B91C1C]'
                      : isChecked && isCorrectOption
                      ? 'bg-emerald-600 text-white border-emerald-600'
                      : 'bg-white dark:bg-[#182238] text-stone-700 dark:text-slate-200 border-stone-300 dark:border-white/15'
                  }`}
                >
                  {letter}
                </span>

                <div className="min-w-0 space-y-0.5">
                  <div
                    className="text-lg font-hanzi font-bold leading-snug"
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {opt.hanzi}
                  </div>
                  {showPinyin && opt.pinyin && (
                    <div className="text-xs font-sans text-[#B91C1C] font-medium">
                      {opt.pinyin}
                    </div>
                  )}
                  {opt.labelVi && (
                    <div className="text-xs sm:text-sm font-serif text-stone-600 dark:text-slate-300">
                      {opt.labelVi}
                    </div>
                  )}
                </div>
              </button>
            )
          })}
        </div>
      )}

      {/* DẠNG 2: GHÉP TỪ THÀNH CÂU (WORD BANK) */}
      {question.type === 'word_bank' && (
        <div className="space-y-5">
          {/* Khung đáp án phía trên */}
          <div className="space-y-2">
            <div className="flex items-center justify-between gap-2">
              <span className="text-xs font-serif font-semibold text-stone-600 dark:text-slate-300">
                Câu ghép của bạn (chạm vào thẻ để gỡ ra):
              </span>
              {!isChecked && selectedBankItems.length > 0 && (
                <button
                  type="button"
                  onClick={() => onUpdateBankItems([])}
                  className="inline-flex items-center gap-1 text-xs font-serif font-semibold text-stone-500 hover:text-[#B91C1C] cursor-pointer"
                >
                  <RotateCcw className="w-3 h-3" />
                  <span>Xóa hết</span>
                </button>
              )}
            </div>

            <div className="min-h-[82px] p-3.5 rounded-2xl bg-[#FAF7F2] dark:bg-[#202B45] border-2 border-stone-900/25 dark:border-[#384869] flex flex-wrap items-center gap-2">
              {selectedBankItems.length === 0 ? (
                <span className="text-xs sm:text-sm font-serif text-stone-400 italic">
                  Chọn lần lượt các thẻ từ bên dưới để ghép thành câu hoàn chỉnh...
                </span>
              ) : (
                selectedBankItems.map((item) => (
                  <button
                    key={item.id}
                    type="button"
                    disabled={isChecked}
                    onClick={() =>
                      onUpdateBankItems(selectedBankItems.filter((tok) => tok.id !== item.id))
                    }
                    className={`px-3.5 py-2 rounded-xl border-2 border-stone-900 bg-white dark:bg-[#182238] text-base font-hanzi font-bold text-stone-900 dark:text-white shadow-[0_2px_0_#1c1917] transition-transform ${
                      isChecked
                        ? 'cursor-default opacity-90'
                        : 'cursor-pointer hover:bg-red-50 hover:border-[#B91C1C] active:translate-y-0.5'
                    }`}
                    style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  >
                    {item.text}
                  </button>
                ))
              )}
            </div>
          </div>

          {/* Ngân hàng thẻ từ bên dưới (cố định slot để không giật layout) */}
          <div className="flex flex-wrap items-center justify-center gap-2.5 pt-2">
            {shuffledBank.map((item) => {
              const isPicked = selectedIdsSet.has(item.id)
              return (
                <button
                  key={item.id}
                  type="button"
                  disabled={isChecked || isPicked}
                  onClick={() => onUpdateBankItems([...selectedBankItems, item])}
                  className={`px-4 py-2.5 rounded-xl border-2 text-base font-hanzi font-bold transition-all min-h-[44px] touch-manipulation ${
                    isPicked
                      ? 'border-dashed border-stone-300 dark:border-white/10 bg-stone-100 dark:bg-white/5 text-transparent select-none cursor-default shadow-none'
                      : 'border-stone-900 dark:border-[#384869] bg-white dark:bg-[#202B45] text-stone-900 dark:text-white shadow-[0_3px_0_#1c1917] hover:-translate-y-0.5 active:translate-y-0.5 cursor-pointer'
                  }`}
                  style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                  aria-hidden={isPicked}
                >
                  {item.text}
                </button>
              )
            })}
          </div>
        </div>
      )}

      {/* DẠNG 3: GÕ CÂU (IME TYPING VỚI BẢO VỆ COMPOSITION EVENTS) */}
      {question.type === 'typing' && (
        <div className="space-y-4">
          <div className="flex items-center justify-between gap-2 flex-wrap">
            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={() => playQuizAudio(question.expectedHanzi)}
                className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-stone-300 bg-[#FAF7F2] hover:border-stone-900 text-xs font-serif font-semibold text-stone-800 cursor-pointer"
              >
                <Volume2 className={`w-3.5 h-3.5 text-[#B91C1C] ${isPlayingAudio ? 'animate-pulse' : ''}`} />
                <span>Nghe gợi ý</span>
              </button>

              {question.hintKeyword && (
                <button
                  type="button"
                  onClick={() => setShowTypingHint((prev) => !prev)}
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-stone-300 bg-white hover:border-stone-900 text-xs font-serif font-semibold text-stone-700 cursor-pointer"
                >
                  <HelpCircle className="w-3.5 h-3.5 text-amber-600" />
                  <span>{showTypingHint ? 'Ẩn Pinyin' : 'Gợi ý Pinyin'}</span>
                </button>
              )}
            </div>

            <span className="inline-flex items-center gap-1 text-[11px] font-sans text-stone-500">
              <Keyboard className="w-3.5 h-3.5" />
              <span>Hỗ trợ chuẩn bộ gõ Pinyin IME</span>
            </span>
          </div>

          {(showPinyin || showTypingHint) && question.hintKeyword && (
            <div className="px-3.5 py-2 rounded-xl bg-amber-50/80 border border-amber-300 text-xs sm:text-sm font-sans font-medium text-amber-900">
              Gợi ý Pinyin: <span className="font-bold">{question.hintKeyword}</span>
            </div>
          )}

          <div className="relative">
            <input
              type="text"
              value={typingInput}
              disabled={isChecked}
              onChange={(e) => onChangeTypingInput(e.target.value)}
              onCompositionStart={(e) => {
                isComposingRef.current = true
                setIsComposing(true)
                setCompositionText(e.data || '')
              }}
              onCompositionUpdate={(e) => {
                setCompositionText(e.data || '')
              }}
              onCompositionEnd={(e) => {
                isComposingRef.current = false
                setIsComposing(false)
                setCompositionText('')
                lastCompositionEndTimeRef.current = Date.now()
                // Cập nhật chắc chắn chuỗi Hán vừa chọn từ IME
                const finalVal = (e.target as HTMLInputElement).value
                onChangeTypingInput(finalVal)
              }}
              onKeyDown={(e) => {
                if (e.key !== 'Enter') return
                // Tuyệt đối không xử lý Enter khi đang chọn chữ trong bảng ứng viên IME
                if (
                  isComposing ||
                  isComposingRef.current ||
                  e.nativeEvent.isComposing ||
                  e.keyCode === 229 ||
                  Date.now() - lastCompositionEndTimeRef.current <= 60
                ) {
                  return
                }
                if (!e.shiftKey && !e.ctrlKey && !e.metaKey) {
                  e.preventDefault()
                  onTriggerCheckOrNext()
                }
              }}
              autoComplete="off"
              autoCorrect="off"
              autoCapitalize="off"
              spellCheck={false}
              placeholder="Bật bộ gõ tiếng Trung (Pinyin), gõ và chọn chữ Hán..."
              className="w-full px-4 py-3.5 min-h-[54px] bg-[#FAF9F6] dark:bg-[#202B45] border-2 border-stone-900 dark:border-[#384869] rounded-2xl text-lg sm:text-xl font-hanzi text-stone-900 dark:text-white placeholder:text-stone-400 placeholder:text-xs sm:placeholder:text-sm placeholder:font-sans focus:outline-none focus:ring-4 focus:ring-[#B91C1C]/15 transition-all disabled:opacity-80"
              style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
            />

            {isComposing && (
              <div className="absolute right-3 top-1/2 -translate-y-1/2 px-2.5 py-1 rounded-lg bg-amber-100 border border-amber-300 text-amber-800 text-[11px] font-sans font-semibold flex items-center gap-1.5 animate-pulse">
                <span className="w-1.5 h-1.5 rounded-full bg-amber-600" />
                <span>IME ({compositionText || 'pinyin'})</span>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
