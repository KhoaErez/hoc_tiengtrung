'use client'

import React, { useEffect, useMemo, useRef, useState } from 'react'
import HanziWriter from 'hanzi-writer'
import {
  Volume2,
  Play,
  RotateCcw,
  Eye,
  EyeOff,
  CheckCircle2,
  PenTool,
  AlertCircle,
} from 'lucide-react'
import type { CourseVocabItem } from '@/data/course-roadmap-data'
import { ttsEngine } from '@/lib/tts/tts-engine'
import { useIsItemSpeaking } from '@/hooks/use-chinese-tts'
import { playTypingSfx } from '@/lib/typing-sound'

interface SingleCharCanvasProps {
  character: string
  showOutline: boolean
  replayNonce: number
  onStrokeCorrect: (strokeNum: number, remaining: number) => void
  onStrokeMistake: (totalMistakes: number) => void
  onCharComplete: (totalMistakes: number) => void
}

/**
 * Bảng viết 1 chữ Hán dùng HanziWriter.quiz() gắn lưới Mễ tự cách (米字格).
 * Mount riêng theo key={character + resetNonce} để mỗi lần chuyển chữ hoặc viết lại luôn sạch state.
 */
function SingleCharStrokeCanvas({
  character,
  showOutline,
  replayNonce,
  onStrokeCorrect,
  onStrokeMistake,
  onCharComplete,
}: SingleCharCanvasProps) {
  const containerRef = useRef<HTMLDivElement>(null)
  const writerRef = useRef<HanziWriter | null>(null)
  const [loadError, setLoadError] = useState(false)
  const [fallbackCompleted, setFallbackCompleted] = useState(false)

  // Lưu callback & tùy chọn qua ref trong useEffect (chuẩn React 19 compiler)
  const callbacksRef = useRef({ onStrokeCorrect, onStrokeMistake, onCharComplete })
  useEffect(() => {
    callbacksRef.current = { onStrokeCorrect, onStrokeMistake, onCharComplete }
  }, [onStrokeCorrect, onStrokeMistake, onCharComplete])

  const showOutlineRef = useRef(showOutline)
  useEffect(() => {
    showOutlineRef.current = showOutline
    const writer = writerRef.current
    if (!writer) return
    try {
      if (showOutline) {
        writer.showOutline({ duration: 150 })
      } else {
        writer.hideOutline({ duration: 150 })
      }
    } catch {}
  }, [showOutline])

  // Fallback SVG/Canvas nếu CDN hanzi-writer-data không tải được
  const fallbackCanvasRef = useRef<HTMLCanvasElement>(null)
  const isDrawingFallbackRef = useRef(false)

  useEffect(() => {
    const el = containerRef.current
    if (!el) return
    el.innerHTML = ''

    let disposed = false
    const size = typeof window !== 'undefined' && window.innerWidth < 420 ? 220 : 248

    const startQuizOnWriter = (writer: HanziWriter) => {
      if (disposed) return
      writer.quiz({
        showHintAfterMisses: 2,
        highlightOnComplete: true,
        leniency: 1.15,
        onCorrectStroke: (data) => {
          if (disposed) return
          playTypingSfx('correct')
          callbacksRef.current.onStrokeCorrect(data.strokeNum + 1, data.strokesRemaining)
        },
        onMistake: (data) => {
          if (disposed) return
          playTypingSfx('error')
          callbacksRef.current.onStrokeMistake(data.totalMistakes)
        },
        onComplete: (summary) => {
          if (disposed) return
          playTypingSfx('complete')
          callbacksRef.current.onCharComplete(summary.totalMistakes)
        },
      })
    }

    const writer = HanziWriter.create(el, character, {
      width: size,
      height: size,
      padding: 16,
      showOutline: showOutlineRef.current,
      showCharacter: false,
      strokeColor: '#182238',
      radicalColor: '#B91C1C',
      outlineColor: '#D6D3D1',
      drawingColor: '#B91C1C',
      drawingWidth: 16,
      highlightColor: '#0D9488',
      highlightCompleteColor: '#059669',
      strokeAnimationSpeed: 1.25,
      delayBetweenStrokes: 160,
      onLoadCharDataError: () => {
        if (!disposed) setLoadError(true)
      },
    })

    writerRef.current = writer
    startQuizOnWriter(writer)

    return () => {
      disposed = true
      try {
        writer.cancelQuiz()
      } catch {}
      writerRef.current = null
      el.innerHTML = ''
    }
  }, [character, replayNonce])

  const handleAnimateSample = () => {
    const writer = writerRef.current
    if (!writer) return
    try {
      writer.cancelQuiz()
      writer.animateCharacter({
        onComplete: () => {
          writer.quiz({
            showHintAfterMisses: 2,
            highlightOnComplete: true,
            leniency: 1.15,
            onCorrectStroke: (data) => {
              playTypingSfx('correct')
              callbacksRef.current.onStrokeCorrect(data.strokeNum + 1, data.strokesRemaining)
            },
            onMistake: (data) => {
              playTypingSfx('error')
              callbacksRef.current.onStrokeMistake(data.totalMistakes)
            },
            onComplete: (summary) => {
              playTypingSfx('complete')
              callbacksRef.current.onCharComplete(summary.totalMistakes)
            },
          })
        },
      })
    } catch {}
  }

  // Fallback tự tô nét trên canvas nếu thiết bị ngoại tuyến không tải được SVG stroke data
  if (loadError) {
    return (
      <div className="flex flex-col items-center gap-3">
        <div className="relative w-[240px] h-[240px] rounded-2xl border-2 border-stone-900 bg-[#FAF7F2] shadow-[0_4px_0_#1c1917] overflow-hidden touch-none">
          <div className="absolute inset-0 flex items-center justify-center pointer-events-none select-none opacity-15 text-[148px] font-hanzi text-stone-900">
            {character}
          </div>
          <canvas
            ref={fallbackCanvasRef}
            width={240}
            height={240}
            className="relative z-10 w-full h-full cursor-crosshair"
            onPointerDown={(e) => {
              const ctx = fallbackCanvasRef.current?.getContext('2d')
              if (!ctx || !fallbackCanvasRef.current) return
              const rect = fallbackCanvasRef.current.getBoundingClientRect()
              isDrawingFallbackRef.current = true
              ctx.strokeStyle = '#B91C1C'
              ctx.lineWidth = 8
              ctx.lineCap = 'round'
              ctx.beginPath()
              ctx.moveTo(e.clientX - rect.left, e.clientY - rect.top)
            }}
            onPointerMove={(e) => {
              if (!isDrawingFallbackRef.current || !fallbackCanvasRef.current) return
              const ctx = fallbackCanvasRef.current.getContext('2d')
              if (!ctx) return
              const rect = fallbackCanvasRef.current.getBoundingClientRect()
              ctx.lineTo(e.clientX - rect.left, e.clientY - rect.top)
              ctx.stroke()
            }}
            onPointerUp={() => {
              isDrawingFallbackRef.current = false
            }}
          />
        </div>
        {!fallbackCompleted && (
          <button
            type="button"
            onClick={() => {
              setFallbackCompleted(true)
              callbacksRef.current.onCharComplete(0)
            }}
            className="px-3 py-1.5 rounded-xl bg-emerald-600 text-white text-xs font-serif font-bold cursor-pointer"
          >
            Xác nhận đã tập viết chữ {character}
          </button>
        )}
      </div>
    )
  }

  return (
    <div className="flex flex-col items-center gap-3">
      {/* Ô lưới Mễ tự cách (米字格) truyền thống */}
      <div className="relative rounded-2xl border-2 border-stone-900 dark:border-[#384869] bg-[#FAF7F2] shadow-[0_4px_0_#1c1917] p-1 overflow-hidden touch-none select-none">
        {/* Đường kẻ chữ Mễ hỗ trợ căn tỷ lệ chữ Hán */}
        <svg
          aria-hidden="true"
          viewBox="0 0 100 100"
          className="absolute inset-0 w-full h-full pointer-events-none opacity-45"
        >
          <line x1="0" y1="50" x2="100" y2="50" stroke="#D6D3D1" strokeWidth="0.8" strokeDasharray="3 3" />
          <line x1="50" y1="0" x2="50" y2="100" stroke="#D6D3D1" strokeWidth="0.8" strokeDasharray="3 3" />
          <line x1="0" y1="0" x2="100" y2="100" stroke="#E7E5E4" strokeWidth="0.7" strokeDasharray="3 3" />
          <line x1="100" y1="0" x2="0" y2="100" stroke="#E7E5E4" strokeWidth="0.7" strokeDasharray="3 3" />
        </svg>

        <div ref={containerRef} className="relative z-10 flex items-center justify-center cursor-crosshair" />
      </div>

      <button
        type="button"
        onClick={handleAnimateSample}
        className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-xl bg-white dark:bg-[#202B45] border-2 border-stone-900 dark:border-[#384869] hover:bg-stone-50 text-xs font-serif font-bold text-stone-900 dark:text-white shadow-[0_2px_0_#1c1917] active:translate-y-0.5 cursor-pointer"
      >
        <Play className="w-3.5 h-3.5 text-[#B91C1C] fill-current" />
        <span>Xem nét mẫu chữ &ldquo;{character}&rdquo;</span>
      </button>
    </div>
  )
}

interface StrokeWritingStepProps {
  vocab: CourseVocabItem
  showPinyin: boolean
  stepLabel?: string
}

export function StrokeWritingStep({ vocab, showPinyin, stepLabel }: StrokeWritingStepProps) {
  const chars = useMemo(
    () => Array.from(vocab.hanzi).filter((ch) => /[\u4e00-\u9fff\u3400-\u4dbf]/.test(ch)),
    [vocab.hanzi]
  )

  const [activeCharIdx, setActiveCharIdx] = useState(0)
  const [showOutline, setShowOutline] = useState(true)
  const [replayNonce, setReplayNonce] = useState(0)
  const [completedCharSet, setCompletedCharSet] = useState<Record<number, number>>({})
  const [statusText, setStatusText] = useState<string>('Dùng chuột hoặc ngón tay vẽ từng nét theo thứ tự chuẩn')
  const [mistakeCount, setMistakeCount] = useState<number>(0)

  const activeChar = chars[activeCharIdx] || chars[0] || '好'
  const audioId = `stroke-audio-${vocab.id}`
  const isPlaying = useIsItemSpeaking(audioId)

  const completedCount = Object.keys(completedCharSet).length
  const isAllCharsDone = chars.length > 0 && completedCount >= chars.length

  const handleSelectChar = (idx: number) => {
    setActiveCharIdx(idx)
    setMistakeCount(0)
    setStatusText(`Hãy viết từng nét của chữ "${chars[idx]}"`)
  }

  return (
    <div className="bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-2xl p-5 sm:p-7 shadow-[0_4px_0_#1c1917] dark:shadow-[0_4px_0_#0D1322] space-y-5 animate-in fade-in duration-200">
      {/* Header badge & nút nghe từ */}
      <div className="flex items-center justify-between gap-2 flex-wrap">
        <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#B91C1C]/10 border border-[#B91C1C]/25 text-[#B91C1C] text-xs font-sans font-bold uppercase tracking-wider">
          <PenTool className="w-3.5 h-3.5" />
          <span>{stepLabel || 'Luyện vẽ chữ Hán'}</span>
        </span>

        <button
          type="button"
          onClick={() => ttsEngine.speak(vocab.hanzi, { id: audioId, rate: 0.9 })}
          className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl border text-xs font-serif font-bold transition-colors cursor-pointer ${
            isPlaying
              ? 'bg-[#B91C1C] text-white border-[#B91C1C]'
              : 'bg-[#FAF7F2] dark:bg-[#202B45] border-stone-300 dark:border-white/15 text-stone-800 dark:text-white hover:border-stone-900'
          }`}
        >
          <Volume2 className={`w-3.5 h-3.5 ${isPlaying ? 'animate-pulse' : 'text-[#B91C1C]'}`} />
          <span>Nghe từ {vocab.hanzi}</span>
        </button>
      </div>

      {/* Thông tin từ vựng đang vẽ */}
      <div className="text-center space-y-1">
        <div className="flex items-baseline justify-center gap-2.5 flex-wrap">
          <span
            className="text-2xl sm:text-3xl font-hanzi font-bold text-stone-900 dark:text-white"
            style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
          >
            {vocab.hanzi}
          </span>
          {showPinyin && (
            <span className="text-sm sm:text-base font-sans font-semibold text-[#B91C1C]">
              [{vocab.pinyin}]
            </span>
          )}
        </div>
        <p className="text-sm font-serif text-stone-700 dark:text-slate-300 font-semibold">
          {vocab.meaningVi}
        </p>
      </div>

      {/* Bộ chọn chữ cái khi từ có >= 2 chữ (VD: 高兴 -> 高 | 兴) */}
      {chars.length > 1 && (
        <div className="flex items-center justify-center gap-2 flex-wrap">
          {chars.map((ch, idx) => {
            const isCurrent = idx === activeCharIdx
            const isCharDone = completedCharSet[idx] !== undefined
            return (
              <button
                key={`${ch}-${idx}`}
                type="button"
                onClick={() => handleSelectChar(idx)}
                className={`px-3.5 py-2 rounded-xl border-2 text-base font-hanzi font-bold flex items-center gap-1.5 transition-all cursor-pointer ${
                  isCurrent
                    ? 'bg-stone-900 text-white border-stone-900 dark:bg-[#B91C1C] dark:border-[#B91C1C]'
                    : isCharDone
                    ? 'bg-emerald-50 text-emerald-800 border-emerald-500'
                    : 'bg-[#FAF7F2] dark:bg-[#202B45] text-stone-800 dark:text-slate-200 border-stone-300 hover:border-stone-900'
                }`}
                style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
              >
                <span>{ch}</span>
                {isCharDone && <CheckCircle2 className="w-3.5 h-3.5 text-emerald-500" />}
              </button>
            )
          })}
        </div>
      )}

      {/* Bảng điều khiển nét mờ & viết lại */}
      <div className="flex items-center justify-center gap-2 flex-wrap">
        <button
          type="button"
          onClick={() => setShowOutline((prev) => !prev)}
          className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-stone-300 dark:border-white/15 bg-[#FAF7F2] dark:bg-[#202B45] hover:border-stone-900 text-xs font-serif font-semibold text-stone-800 dark:text-slate-200 cursor-pointer"
        >
          {showOutline ? <Eye className="w-3.5 h-3.5 text-[#B91C1C]" /> : <EyeOff className="w-3.5 h-3.5" />}
          <span>{showOutline ? 'Ẩn nét mờ' : 'Hiện nét mờ'}</span>
        </button>

        <button
          type="button"
          onClick={() => {
            setMistakeCount(0)
            setStatusText(`Viết lại chữ "${activeChar}" theo đúng thứ tự nét`)
            setReplayNonce((n) => n + 1)
          }}
          className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-stone-300 dark:border-white/15 bg-white dark:bg-[#202B45] hover:border-stone-900 text-xs font-serif font-semibold text-stone-800 dark:text-slate-200 cursor-pointer"
        >
          <RotateCcw className="w-3.5 h-3.5" />
          <span>Viết lại chữ này</span>
        </button>
      </div>

      {/* Vùng vẽ chữ HanziWriter */}
      <SingleCharStrokeCanvas
        key={`${vocab.id}-${activeCharIdx}-${replayNonce}`}
        character={activeChar}
        showOutline={showOutline}
        replayNonce={replayNonce}
        onStrokeCorrect={(strokeNum, remaining) => {
          if (remaining > 0) {
            setStatusText(`Chuẩn xác nét ${strokeNum}! Còn ${remaining} nét nữa.`)
          }
        }}
        onStrokeMistake={(totalMistakes) => {
          setMistakeCount(totalMistakes)
          setStatusText('Chú ý hướng bút và thứ tự nét nhé (vẽ sai 2 lần sẽ có gợi ý).')
        }}
        onCharComplete={(totalMistakes) => {
          setCompletedCharSet((prev) => ({ ...prev, [activeCharIdx]: totalMistakes }))
          setStatusText(
            totalMistakes === 0
              ? `Tuyệt vời! Bạn viết chữ "${activeChar}" chuẩn 100% không sai nét nào!`
              : `Hoàn thành chữ "${activeChar}" (lệch ${totalMistakes} nét).`
          )
          // Nếu từ có nhiều chữ và chữ tiếp theo chưa viết -> tự chuyển mượt sau 0.8s
          if (activeCharIdx + 1 < chars.length) {
            window.setTimeout(() => {
              setActiveCharIdx((prev) => (prev === activeCharIdx ? prev + 1 : prev))
              setMistakeCount(0)
            }, 850)
          }
        }}
      />

      {/* Thanh trạng thái chấm nét thực tế */}
      <div
        className={`rounded-xl px-4 py-2.5 text-xs sm:text-sm font-serif flex items-center justify-between gap-2 border ${
          isAllCharsDone
            ? 'bg-emerald-50 border-emerald-500 text-emerald-900 font-semibold'
            : mistakeCount > 0
            ? 'bg-amber-50 border-amber-300 text-amber-900'
            : 'bg-[#FAF7F2] dark:bg-[#202B45] border-stone-300 dark:border-white/15 text-stone-700 dark:text-slate-300'
        }`}
      >
        <div className="flex items-center gap-2 min-w-0">
          {isAllCharsDone ? (
            <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
          ) : mistakeCount > 0 ? (
            <AlertCircle className="w-4 h-4 text-amber-600 shrink-0" />
          ) : (
            <PenTool className="w-4 h-4 text-[#B91C1C] shrink-0" />
          )}
          <span className="truncate">{statusText}</span>
        </div>

        <span className="text-xs font-sans font-bold shrink-0 tabular-nums">
          {completedCount}/{chars.length} chữ
        </span>
      </div>
    </div>
  )
}
