'use client'

import React, { useState, useEffect, useRef } from 'react'
import { Volume2, Play, Square, MessagesSquare, Eye, EyeOff } from 'lucide-react'
import type { CourseDialogueData } from '@/data/course-roadmap-data'
import { ttsEngine } from '@/lib/tts/tts-engine'
import { toast } from 'sonner'

interface DialogueStepProps {
  dialogue: CourseDialogueData
  showPinyin: boolean
  onTogglePinyin: () => void
}

export function DialogueStep({ dialogue, showPinyin, onTogglePinyin }: DialogueStepProps) {
  const [showVietnamese, setShowVietnamese] = useState<boolean>(true)
  const [activeLineId, setActiveLineId] = useState<string | null>(null)
  const [isPlayingAll, setIsPlayingAll] = useState<boolean>(false)
  const sequenceRunIdRef = useRef<number>(0)

  useEffect(() => {
    return () => {
      sequenceRunIdRef.current += 1
      ttsEngine.stop()
    }
  }, [])

  const stopDialogueAudio = () => {
    sequenceRunIdRef.current += 1
    setIsPlayingAll(false)
    setActiveLineId(null)
    ttsEngine.stop()
  }

  const handlePlaySingleLine = (lineId: string, text: string) => {
    sequenceRunIdRef.current += 1
    setIsPlayingAll(false)

    if (activeLineId === lineId && ttsEngine.isSpeaking(`dlg-${lineId}`)) {
      setActiveLineId(null)
      ttsEngine.stop()
      return
    }

    setActiveLineId(lineId)
    ttsEngine.speak(text, {
      id: `dlg-${lineId}`,
      rate: 0.95,
      onEnd: () => {
        setActiveLineId((prev) => (prev === lineId ? null : prev))
      },
      onError: () => {
        setActiveLineId(null)
        toast.error('Không thể phát âm câu thoại này.')
      },
    })
  }

  const handlePlayAll = () => {
    if (isPlayingAll) {
      stopDialogueAudio()
      return
    }
    if (dialogue.lines.length === 0) return

    const currentRunId = ++sequenceRunIdRef.current
    setIsPlayingAll(true)

    const speakAt = (idx: number) => {
      if (sequenceRunIdRef.current !== currentRunId) return
      if (idx >= dialogue.lines.length) {
        setIsPlayingAll(false)
        setActiveLineId(null)
        return
      }
      const line = dialogue.lines[idx]
      setActiveLineId(line.id)
      ttsEngine.speak(line.hanzi, {
        id: `dlg-seq-${currentRunId}-${line.id}`,
        rate: 0.95,
        onEnd: () => {
          if (sequenceRunIdRef.current !== currentRunId) return
          window.setTimeout(() => {
            speakAt(idx + 1)
          }, 260)
        },
        onError: () => {
          if (sequenceRunIdRef.current === currentRunId) {
            setIsPlayingAll(false)
            setActiveLineId(null)
          }
        },
      })
    }

    speakAt(0)
  }

  return (
    <div className="bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl p-5 sm:p-7 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322] space-y-5 animate-in fade-in duration-200">
      {/* Header & Ngữ cảnh hội thoại */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-4 border-b border-stone-200 dark:border-white/10">
        <div className="space-y-1">
          <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-[#B91C1C]/10 border border-[#B91C1C]/25 text-[#B91C1C] text-[11px] font-sans font-bold uppercase tracking-wider">
            <MessagesSquare className="w-3.5 h-3.5" />
            <span>Hội thoại thực tế</span>
          </div>
          <h2 className="text-lg sm:text-xl font-serif font-bold text-stone-900 dark:text-white">
            {dialogue.title}
          </h2>
          <p className="text-xs font-serif text-stone-600 dark:text-slate-300">
            {dialogue.context}
          </p>
        </div>

        {/* Nút Nghe cả đoạn */}
        <button
          type="button"
          onClick={handlePlayAll}
          className={`inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl border-2 border-stone-900 text-xs sm:text-sm font-serif font-bold transition-all cursor-pointer min-h-[44px] shrink-0 touch-manipulation ${
            isPlayingAll
              ? 'bg-stone-900 text-white shadow-[0_2px_0_#1c1917]'
              : 'bg-[#B91C1C] hover:bg-[#991B1B] text-white shadow-[0_3px_0_#1c1917] active:translate-y-0.5'
          }`}
        >
          {isPlayingAll ? (
            <>
              <Square className="w-3.5 h-3.5 fill-current" />
              <span>Dừng đọc đoạn</span>
            </>
          ) : (
            <>
              <Play className="w-4 h-4 fill-current" />
              <span>Nghe cả đoạn</span>
            </>
          )}
        </button>
      </div>

      {/* Thanh Toggle nhanh Pinyin & Dịch Việt */}
      <div className="flex items-center justify-between gap-2 flex-wrap">
        <span className="text-xs font-serif text-stone-500 dark:text-slate-400">
          Chạm vào từng câu để nghe lại giọng đọc chuẩn:
        </span>

        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={onTogglePinyin}
            className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg border text-xs font-serif font-semibold transition-colors cursor-pointer ${
              showPinyin
                ? 'bg-[#B91C1C]/10 border-[#B91C1C]/40 text-[#B91C1C]'
                : 'bg-[#FAF7F2] dark:bg-[#202B45] border-stone-300 dark:border-white/15 text-stone-700 dark:text-slate-300'
            }`}
          >
            {showPinyin ? <Eye className="w-3.5 h-3.5" /> : <EyeOff className="w-3.5 h-3.5" />}
            <span>Pinyin</span>
          </button>

          <button
            type="button"
            onClick={() => setShowVietnamese((p) => !p)}
            className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg border text-xs font-serif font-semibold transition-colors cursor-pointer ${
              showVietnamese
                ? 'bg-[#B91C1C]/10 border-[#B91C1C]/40 text-[#B91C1C]'
                : 'bg-[#FAF7F2] dark:bg-[#202B45] border-stone-300 dark:border-white/15 text-stone-700 dark:text-slate-300'
            }`}
          >
            {showVietnamese ? <Eye className="w-3.5 h-3.5" /> : <EyeOff className="w-3.5 h-3.5" />}
            <span>Dịch Việt</span>
          </button>
        </div>
      </div>

      {/* Khung tin nhắn 2 nhân vật A / B */}
      <div className="space-y-3.5">
        {dialogue.lines.map((line) => {
          const isSpeakerA = line.speaker === 'A'
          const isActive = activeLineId === line.id

          return (
            <div
              key={line.id}
              className={`flex items-start gap-2.5 ${isSpeakerA ? 'justify-start' : 'flex-row-reverse justify-start'}`}
            >
              {/* Avatar tròn đơn giản A / B */}
              <div
                className={`w-9 h-9 rounded-full border-2 border-stone-900 flex items-center justify-center text-xs font-sans font-bold shrink-0 mt-1 ${
                  isSpeakerA
                    ? 'bg-white text-stone-900'
                    : 'bg-[#B91C1C] text-white'
                }`}
                title={line.roleName}
              >
                {line.speaker}
              </div>

              {/* Bong bóng chat bấm để nghe */}
              <button
                type="button"
                onClick={() => handlePlaySingleLine(line.id, line.hanzi)}
                className={`max-w-[85%] sm:max-w-[78%] text-left rounded-2xl border-2 p-3.5 sm:p-4 transition-all cursor-pointer group ${
                  isActive
                    ? 'border-[#B91C1C] bg-red-50/80 dark:bg-[#202B45] ring-2 ring-[#B91C1C]/20 shadow-sm'
                    : isSpeakerA
                    ? 'border-stone-300 dark:border-white/15 bg-[#FAF9F6] dark:bg-[#202B45] hover:border-stone-900'
                    : 'border-stone-900/20 dark:border-[#384869] bg-[#FAF7F2] dark:bg-[#1F2C47] hover:border-stone-900'
                }`}
              >
                <div className="flex items-center justify-between gap-3 mb-1">
                  <span className="text-[11px] font-sans font-bold text-stone-500 dark:text-slate-400">
                    {line.roleName}
                  </span>
                  <Volume2
                    className={`w-3.5 h-3.5 shrink-0 transition-colors ${
                      isActive
                        ? 'text-[#B91C1C] animate-pulse'
                        : 'text-stone-400 group-hover:text-[#B91C1C]'
                    }`}
                  />
                </div>

                <p
                  className="text-base sm:text-lg font-hanzi font-semibold text-stone-900 dark:text-white leading-snug"
                  style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                >
                  {line.hanzi}
                </p>

                {showPinyin && (
                  <p className="text-xs font-sans text-[#B91C1C] font-medium mt-1">
                    {line.pinyin}
                  </p>
                )}

                {showVietnamese && (
                  <p className="text-xs sm:text-sm font-serif text-stone-600 dark:text-slate-300 mt-1">
                    {line.meaningVi}
                  </p>
                )}
              </button>
            </div>
          )
        })}
      </div>
    </div>
  )
}
