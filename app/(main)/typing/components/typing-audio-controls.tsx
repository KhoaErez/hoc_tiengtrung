'use client'

import React, { useState, useRef, useEffect } from 'react'
import {
  Volume2,
  VolumeX,
  Play,
  Pause,
  Square,
  Headphones,
  Info,
  ChevronDown,
  ChevronLeft,
  ChevronRight,
  RotateCcw,
  Gauge,
  Check,
  X,
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { ChineseSentenceItem } from '@/lib/typing-sound'

export interface TypingAudioControlsProps {
  sentences: ChineseSentenceItem[];
  currentSentenceIndex: number; // Câu mà người dùng đang gõ hoặc chọn nghe
  speakingSentenceIndex: number | null; // Câu đang được đọc bởi TTS
  speechStatus: 'idle' | 'playing' | 'paused';
  readingMode: 'all' | 'sentence' | null;
  speechRate: number; // 0.5 - 2.0
  onRateChange: (rate: number) => void;
  onPlayAll: () => void;
  onPlayCurrentSentence: () => void;
  onPause: () => void;
  onResume: () => void;
  onStop: () => void;
  selectedVoiceURI: string;
  onVoiceChange: (voiceURI: string) => void;
  availableVoices: SpeechSynthesisVoice[];
  hasVoiceWarning: boolean;
  typingSoundEnabled: boolean;
  onToggleTypingSound: () => void;
  autoSpeakNext: boolean;
  onToggleAutoSpeakNext: () => void;
  onPrevSentence?: () => void;
  onNextSentence?: () => void;
  isAudioFinished?: boolean;
}

// Hàm chuẩn hóa tên và thông tin giọng đọc tiếng Trung
function formatVoiceInfo(voice: SpeechSynthesisVoice) {
  const cleanName =
    voice.name
      .replace(/Microsoft |Google |Apple |Chinese |\(China\)|\(PRC\)|\(Taiwan\)|\(Hong Kong\)/gi, '')
      .trim() || voice.name
  const isNatural =
    voice.name.toLowerCase().includes('natural') || voice.name.toLowerCase().includes('online')
  const region = voice.lang.includes('TW')
    ? 'Đài Loan'
    : voice.lang.includes('HK')
    ? 'Hồng Kông'
    : 'Phổ thông'
  return { cleanName, isNatural, region }
}

export default function TypingAudioControls({
  sentences,
  currentSentenceIndex,
  speakingSentenceIndex,
  speechStatus,
  readingMode,
  speechRate,
  onRateChange,
  onPlayAll,
  onPlayCurrentSentence,
  onPause,
  onResume,
  onStop,
  selectedVoiceURI,
  onVoiceChange,
  availableVoices,
  hasVoiceWarning,
  typingSoundEnabled,
  onToggleTypingSound,
  autoSpeakNext,
  onToggleAutoSpeakNext,
  onPrevSentence,
  onNextSentence,
  isAudioFinished = false,
}: TypingAudioControlsProps) {
  const [showVoiceDropdown, setShowVoiceDropdown] = useState(false)
  const [showHelpGuide, setShowHelpGuide] = useState(false)
  const voiceDropdownRef = useRef<HTMLDivElement>(null)

  const isPlayingAll = speechStatus === 'playing' && readingMode === 'all'
  const isPausedAll = speechStatus === 'paused' && readingMode === 'all'
  const isPlayingCurrent = speechStatus === 'playing' && readingMode === 'sentence'

  // Tìm giọng đọc đang được chọn
  const activeVoice =
    availableVoices.find((v) => v.voiceURI === selectedVoiceURI) ||
    availableVoices[0]

  const displayVoiceName = activeVoice
    ? activeVoice.name.replace(/Microsoft |Google |Apple |Chinese |\(China\)|\(PRC\)|\(Taiwan\)|\(Hong Kong\)/gi, '').trim() ||
      activeVoice.name
    : 'Mặc định (zh-CN)'

  // Khóa cuộn màn hình khi mở Bottom Sheet chọn giọng trên Mobile
  useEffect(() => {
    if (showVoiceDropdown && typeof window !== 'undefined' && window.innerWidth < 768) {
      const prevOverflow = document.body.style.overflow
      document.body.style.overflow = 'hidden'
      return () => {
        document.body.style.overflow = prevOverflow
      }
    }
  }, [showVoiceDropdown])

  // Lắng nghe click bên ngoài và phím Escape để đóng dropdown trên Desktop
  useEffect(() => {
    if (!showVoiceDropdown) return
    const handleClickOutside = (e: MouseEvent | TouchEvent) => {
      if (voiceDropdownRef.current && !voiceDropdownRef.current.contains(e.target as Node)) {
        setShowVoiceDropdown(false)
      }
    }
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') setShowVoiceDropdown(false)
    }
    document.addEventListener('mousedown', handleClickOutside)
    document.addEventListener('keydown', handleKeyDown)
    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [showVoiceDropdown])

  return (
    <div className="bg-card border border-[#E9DDD1] rounded-2xl p-3.5 md:p-4 shadow-2xs space-y-3 transition-all">
      {/* 1. HÀNG TIÊU ĐỀ & TÙY CHỈNH TỐC ĐỘ, GIỌNG ĐỌC */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2.5 pb-2.5 border-b border-[#E9DDD1]/80">
        <div className="flex items-center gap-2 flex-wrap">
          <div className="flex items-center gap-1.5">
            <Volume2 className="w-4 h-4 text-[#B8322D] flex-shrink-0" />
            <span className="font-serif font-bold text-xs md:text-sm text-[#243047]">
              Luyện nghe & Phát âm tiếng Trung
            </span>
          </div>

          {/* Huy hiệu trạng thái âm thanh */}
          {speechStatus === 'playing' ? (
            <span className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-[10px] font-sans font-bold bg-[#24856A]/15 text-[#24856A] border border-[#24856A]/30">
              <span className="w-2 h-2 rounded-full bg-[#24856A] animate-ping" />
              <span>
                Đang đọc{speakingSentenceIndex !== null ? ` câu ${speakingSentenceIndex + 1}/${sentences.length}` : '...'}
              </span>
            </span>
          ) : speechStatus === 'paused' ? (
            <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-sans font-bold bg-amber-500/15 text-amber-700 dark:text-amber-400 border border-amber-500/30">
              <Pause className="w-3 h-3" />
              <span>Tạm dừng</span>
            </span>
          ) : (
            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-serif text-[#243047]/60 bg-[#FFF9F3] border border-[#E9DDD1]">
              <span>Sẵn sàng ({sentences.length} câu)</span>
            </span>
          )}
        </div>

        {/* Bộ điều chỉnh Tốc độ & Giọng đọc */}
        <div className="flex items-center gap-2 flex-wrap">
          {/* Chọn tốc độ đọc (0.5x, 0.75x, 1.0x, 1.25x, 1.5x, 2.0x) */}
          <div className="flex items-center bg-[#FFF9F3] border border-[#E9DDD1] rounded-xl p-0.5 text-xs font-serif overflow-x-auto no-scrollbar scroll-smooth touch-pan-x max-w-full">
            <span className="px-2 py-1 text-[11px] text-[#243047]/70 flex items-center gap-1 shrink-0">
              <Gauge className="w-3 h-3 text-[#243047]/60" />
              <span className="hidden xs:inline">Tốc độ:</span>
            </span>
            {[
              { rate: 0.5, label: '0.5x', desc: 'Rất chậm' },
              { rate: 0.75, label: '0.75x', desc: 'Chậm' },
              { rate: 1.0, label: '1.0x', desc: 'Bình thường' },
              { rate: 1.25, label: '1.25x', desc: 'Nhanh' },
              { rate: 1.5, label: '1.5x', desc: 'Rất nhanh' },
              { rate: 2.0, label: '2.0x', desc: 'Tốc độ cao' },
            ].map(({ rate, label, desc }) => (
              <button
                key={rate}
                type="button"
                onClick={() => onRateChange(rate)}
                className={`px-2 py-1 rounded-lg text-xs font-sans transition-all shrink-0 active:scale-[0.98] touch-manipulation ${
                  speechRate === rate
                    ? 'bg-[#243047] text-white font-bold shadow-2xs'
                    : 'text-[#243047]/70 hover:text-[#243047] hover:bg-white'
                }`}
                title={`Tốc độ ${label} — ${desc}`}
              >
                {label}
              </button>
            ))}
          </div>

          {/* Chọn giọng đọc nếu thiết bị có nhiều giọng Trung */}
          {availableVoices.length > 1 && (
            <div ref={voiceDropdownRef} className="relative">
              <button
                type="button"
                onClick={() => setShowVoiceDropdown(!showVoiceDropdown)}
                className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-border bg-page text-xs font-serif text-title hover:border-app-accent/40 active:scale-[0.98] transition-all cursor-pointer min-h-[36px]"
                title="Chọn giọng đọc tiếng Trung"
                aria-expanded={showVoiceDropdown}
                aria-haspopup="dialog"
              >
                <span className="truncate max-w-[120px] font-medium">{displayVoiceName}</span>
                <ChevronDown className={`w-3.5 h-3.5 text-muted shrink-0 transition-transform duration-200 ${showVoiceDropdown ? 'rotate-180 text-app-accent' : ''}`} />
              </button>

              {/* A. DESKTOP DROPDOWN (Chỉ hiện từ md: trở lên, không tràn lề) */}
              {showVoiceDropdown && (
                <div className="hidden md:block absolute right-0 mt-1.5 w-80 bg-card border border-border/80 rounded-2xl shadow-xl z-50 p-2 space-y-1.5 animate-in fade-in zoom-in-95 duration-150">
                  <div className="flex items-center justify-between px-2.5 py-1.5 border-b border-border/70">
                    <div className="flex items-center gap-1.5">
                      <Volume2 className="w-3.5 h-3.5 text-app-accent" />
                      <span className="text-xs font-serif font-bold text-title">
                        Chọn giọng đọc tiếng Trung
                      </span>
                    </div>
                    <span className="px-2 py-0.5 rounded-full text-[10px] font-sans font-medium bg-app-accent-soft text-app-accent">
                      {availableVoices.length} giọng
                    </span>
                  </div>

                  <div className="max-h-60 overflow-y-auto no-scrollbar space-y-1 p-0.5">
                    {availableVoices.map((v) => {
                      const isSelected = v.voiceURI === activeVoice?.voiceURI
                      const { cleanName, isNatural, region } = formatVoiceInfo(v)
                      return (
                        <button
                          key={v.voiceURI}
                          type="button"
                          onClick={() => {
                            onVoiceChange(v.voiceURI)
                            setShowVoiceDropdown(false)
                          }}
                          className={`w-full flex items-center justify-between text-left px-3 py-2 rounded-xl text-xs font-serif transition-colors cursor-pointer ${
                            isSelected
                              ? 'bg-app-accent-soft/50 text-app-accent font-bold border border-app-accent/30'
                              : 'text-title hover:bg-page border border-transparent'
                          }`}
                        >
                          <div className="flex flex-col min-w-0 pr-2">
                            <div className="flex items-center gap-1.5">
                              <span className="truncate text-title font-medium">{cleanName}</span>
                              {isNatural && (
                                <span className="px-1.5 py-0.2 rounded text-[8px] font-sans bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 font-semibold shrink-0">
                                  Tự nhiên
                                </span>
                              )}
                            </div>
                            <span className="text-[10px] text-muted/70 truncate">{region} • {v.lang}</span>
                          </div>
                          {isSelected && <Check className="w-4 h-4 text-app-accent shrink-0 ml-1" />}
                        </button>
                      )
                    })}
                  </div>
                </div>
              )}

              {/* B. MOBILE BOTTOM SHEET (Chỉ mở trên màn hình < md, chạm vuốt mượt mà, không cắt chữ) */}
              {showVoiceDropdown && (
                <div className="md:hidden">
                  {/* Backdrop làm mờ */}
                  <div 
                    className="fixed inset-0 bg-black/60 backdrop-blur-xs z-50 animate-in fade-in duration-200"
                    onClick={() => setShowVoiceDropdown(false)}
                    aria-hidden="true"
                  />

                  {/* Bottom Sheet Modal */}
                  <div 
                    className="fixed bottom-0 left-0 right-0 max-h-[82vh] bg-card border-t border-border rounded-t-3xl shadow-2xl z-50 flex flex-col animate-in slide-in-from-bottom duration-200"
                    role="dialog"
                    aria-modal="true"
                    aria-labelledby="mobile-voice-sheet-title"
                  >
                    {/* Drag handle */}
                    <div className="w-10 h-1 bg-muted/40 rounded-full mx-auto my-2.5 shrink-0" />

                    {/* Sheet Header */}
                    <div className="flex items-center justify-between px-5 pb-3 border-b border-border/80 shrink-0">
                      <div className="flex items-center gap-2">
                        <Volume2 className="w-4 h-4 text-app-accent" />
                        <h3 id="mobile-voice-sheet-title" className="text-sm font-serif font-bold text-title">
                          Chọn giọng đọc tiếng Trung
                        </h3>
                        <span className="px-2 py-0.5 rounded-full text-[10px] font-sans font-bold bg-app-accent-soft text-app-accent">
                          {availableVoices.length} giọng
                        </span>
                      </div>
                      <button
                        type="button"
                        onClick={() => setShowVoiceDropdown(false)}
                        className="p-1.5 rounded-xl text-muted hover:text-title hover:bg-black/5 cursor-pointer touch-manipulation"
                        aria-label="Đóng bảng chọn giọng"
                      >
                        <X className="w-4 h-4" />
                      </button>
                    </div>

                    {/* Sheet Content List cuộn độc lập */}
                    <div className="flex-1 overflow-y-auto p-4 space-y-2.5 overscroll-contain pb-[max(1.5rem,env(safe-area-inset-bottom))] font-serif">
                      {availableVoices.map((v) => {
                        const isSelected = v.voiceURI === activeVoice?.voiceURI
                        const { cleanName, isNatural, region } = formatVoiceInfo(v)
                        return (
                          <button
                            key={v.voiceURI}
                            type="button"
                            onClick={() => {
                              onVoiceChange(v.voiceURI)
                              setShowVoiceDropdown(false)
                            }}
                            className={`w-full flex items-center justify-between p-3.5 rounded-2xl border text-left transition-all active:scale-[0.98] cursor-pointer touch-manipulation min-h-[52px] ${
                              isSelected
                                ? 'bg-app-accent-soft/40 border-app-accent text-title shadow-2xs font-semibold'
                                : 'bg-page border-border/70 text-title hover:border-app-accent/40'
                            }`}
                          >
                            <div className="flex flex-col min-w-0 pr-2">
                              <div className="flex items-center gap-2 flex-wrap">
                                <span className="text-xs font-serif font-bold text-title">
                                  {cleanName}
                                </span>
                                {isNatural && (
                                  <span className="px-1.5 py-0.2 rounded text-[9px] font-sans bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 border border-emerald-500/20 font-medium">
                                    Tự nhiên
                                  </span>
                                )}
                                <span className="px-1.5 py-0.2 rounded text-[9px] font-sans bg-card border border-border/60 text-muted">
                                  {region}
                                </span>
                              </div>
                              <span className="text-[10px] font-mono text-muted/70 truncate mt-0.5">
                                {v.name}
                              </span>
                            </div>
                            {isSelected && (
                              <div className="w-6 h-6 rounded-full bg-app-accent text-white flex items-center justify-center shrink-0 shadow-2xs">
                                <Check className="w-3.5 h-3.5 stroke-[2.5]" />
                              </div>
                            )}
                          </button>
                        )
                      })}
                    </div>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      </div>

      {/* 2. CÁC NÚT ĐIỀU KHIỂN PHÁT ÂM VÀ TÙY CHỌN */}
      <div className="flex flex-wrap items-center justify-between gap-2.5">
        {/* Nhóm nút chính: Nghe toàn bộ / Nghe câu hiện tại / Tạm dừng / Tiếp tục / Dừng */}
        <div className="flex items-center gap-2 flex-wrap">
          {/* Nút Nghe toàn bộ / Tạm dừng toàn bộ */}
          <Button
            type="button"
            size="sm"
            onClick={() => {
              if (isPlayingAll) {
                onPause()
              } else if (isPausedAll) {
                onResume()
              } else {
                onPlayAll()
              }
            }}
            className={`font-serif text-xs rounded-xl shadow-2xs gap-1.5 h-9 px-3.5 transition-all active:scale-[0.98] touch-manipulation ${
              isPlayingAll
                ? 'bg-amber-600 hover:bg-amber-700 text-white font-bold'
                : 'bg-[#B8322D] hover:bg-[#9E2824] text-white'
            }`}
            title="Đọc lần lượt tất cả các câu từ đầu đến cuối đoạn văn"
          >
            {isPlayingAll ? (
              <>
                <Pause className="w-3.5 h-3.5" />
                <span>Tạm dừng</span>
              </>
            ) : isPausedAll ? (
              <>
                <Play className="w-3.5 h-3.5" />
                <span>Tiếp tục đọc</span>
              </>
            ) : (
              <>
                <Play className="w-3.5 h-3.5" />
                <span>Nghe toàn bộ</span>
              </>
            )}
          </Button>

          {/* Nút Nghe câu hiện tại kèm điều hướng câu trước/sau nếu đoạn văn có nhiều câu */}
          <div className="inline-flex items-center rounded-xl border border-[#E9DDD1] bg-[#FFF9F3] p-0.5 shadow-2xs">
            {sentences.length > 1 && (
              <button
                type="button"
                onClick={onPrevSentence}
                disabled={currentSentenceIndex <= 0}
                className="h-8 w-8 flex items-center justify-center rounded-lg text-[#243047]/70 hover:text-[#B8322D] hover:bg-white disabled:opacity-30 disabled:cursor-not-allowed transition-colors cursor-pointer touch-manipulation active:scale-[0.96]"
                title="Quay lại câu trước"
                aria-label="Quay lại câu trước"
              >
                <ChevronLeft className="w-4 h-4" />
              </button>
            )}

            <button
              type="button"
              onClick={onPlayCurrentSentence}
              disabled={sentences.length === 0}
              className={`font-serif text-xs rounded-lg h-8 px-2.5 flex items-center gap-1.5 transition-all active:scale-[0.98] touch-manipulation cursor-pointer ${
                isPlayingCurrent
                  ? 'bg-white border border-[#B8322D]/40 text-[#B8322D] font-bold shadow-2xs ring-1 ring-[#B8322D]/30'
                  : 'text-[#243047] hover:text-[#B8322D] hover:bg-white'
              }`}
              title={
                sentences.length === 0
                  ? 'Chưa có câu để đọc'
                  : isAudioFinished
                  ? `Đoạn văn đã đọc xong câu cuối (${currentSentenceIndex + 1}/${sentences.length}). Bấm để nghe lại.`
                  : `Nghe câu hiện tại (Câu ${currentSentenceIndex + 1}/${sentences.length})`
              }
            >
              {isPlayingCurrent ? (
                <Volume2 className="w-3.5 h-3.5 text-[#B8322D] animate-pulse shrink-0" />
              ) : isAudioFinished ? (
                <RotateCcw className="w-3.5 h-3.5 text-amber-600 shrink-0" />
              ) : (
                <Headphones className="w-3.5 h-3.5 text-[#B8322D] shrink-0" />
              )}
              <span className="whitespace-nowrap">
                {isAudioFinished
                  ? `Đã xong đoạn • Nghe lại (${currentSentenceIndex + 1}/${sentences.length})`
                  : `Nghe câu hiện tại (Câu ${currentSentenceIndex + 1}/${sentences.length})`}
              </span>
            </button>

            {sentences.length > 1 && (
              <button
                type="button"
                onClick={onNextSentence}
                disabled={currentSentenceIndex >= sentences.length - 1}
                className="h-8 w-8 flex items-center justify-center rounded-lg text-[#243047]/70 hover:text-[#B8322D] hover:bg-white disabled:opacity-30 disabled:cursor-not-allowed transition-colors cursor-pointer touch-manipulation active:scale-[0.96]"
                title="Chuyển sang câu tiếp theo"
                aria-label="Chuyển sang câu tiếp theo"
              >
                <ChevronRight className="w-4 h-4" />
              </button>
            )}
          </div>

          {/* Nút Dừng phát */}
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={onStop}
            disabled={speechStatus === 'idle'}
            className="font-serif text-xs rounded-xl border border-[#E9DDD1] text-[#243047]/70 hover:text-[#B91C1C] hover:border-[#FCA5A5] h-9 px-2.5 gap-1 disabled:opacity-40 active:scale-[0.98] touch-manipulation bg-card"
            title="Dừng đọc âm thanh"
          >
            <Square className="w-3 h-3" />
            <span>Dừng</span>
          </Button>
        </div>

        {/* Nhóm nút tùy chọn: Âm gõ phím & Tự đọc câu tiếp theo */}
        <div className="flex items-center gap-2 flex-wrap">
          {/* Bật / Tắt âm báo gõ phím */}
          <button
            type="button"
            onClick={onToggleTypingSound}
            className={`flex items-center gap-1.5 px-3 py-1.5 rounded-xl border text-xs font-serif transition-colors active:scale-[0.98] touch-manipulation ${
              typingSoundEnabled
                ? 'bg-[#FFF9F3] border-[#B8322D]/40 text-[#B8322D] font-medium'
                : 'bg-card border-[#E9DDD1] text-[#243047]/70 hover:text-[#243047]'
            }`}
            title="Bật/Tắt âm báo nhẹ khi gõ đúng và sai ký tự"
          >
            {typingSoundEnabled ? (
              <Volume2 className="w-3.5 h-3.5 text-[#B8322D]" />
            ) : (
              <VolumeX className="w-3.5 h-3.5 text-[#243047]/50" />
            )}
            <span>{typingSoundEnabled ? 'Âm gõ: Bật' : 'Âm gõ: Tắt'}</span>
          </button>

          {/* Tùy chọn Tự đọc câu mới khi hiển thị */}
          <button
            type="button"
            onClick={onToggleAutoSpeakNext}
            className={`flex items-center gap-1.5 px-3 py-1.5 rounded-xl border text-xs font-serif transition-colors active:scale-[0.98] touch-manipulation ${
              autoSpeakNext
                ? 'bg-[#243047] text-white font-medium border-[#243047] shadow-2xs'
                : 'bg-card border-[#E9DDD1] text-[#243047]/70 hover:text-[#243047]'
            }`}
            title="Tự động phát âm thanh khi hiển thị câu mới hoặc chuyển câu"
          >
            <Headphones className="w-3.5 h-3.5 text-gold" />
            <span>Tự động đọc câu mới</span>
          </button>
        </div>
      </div>

      {/* 3. CẢNH BÁO THIẾT BỊ NẾU CHƯA CÓ GIỌNG TIẾNG TRUNG */}
      {hasVoiceWarning && (
        <div className="p-3 rounded-xl bg-amber-500/10 border border-amber-500/30 text-amber-800 dark:text-amber-400 text-xs font-serif flex items-start justify-between gap-2">
          <div className="flex items-start gap-2">
            <Info className="w-4 h-4 text-amber-600 flex-shrink-0 mt-0.5" />
            <div className="space-y-1">
              <p className="font-bold">
                Chưa tìm thấy giọng đọc tiếng Trung (zh-CN) được cài sẵn trên trình duyệt/hệ điều hành.
              </p>
              <p className="text-[11px] text-muted">
                Trình duyệt sẽ dùng giọng đọc khả dụng gần nhất. Để có trải nghiệm phát âm tiếng Trung chuẩn và mượt mà nhất, bạn có thể cài thêm giọng Trung Quốc (zh-CN) miễn phí trong cài đặt hệ điều hành.
              </p>
              {showHelpGuide && (
                <div className="text-[11px] bg-card/80 p-2.5 rounded-lg border border-border space-y-1 text-title mt-2">
                  <p className="font-bold text-app-accent">• Cách thêm giọng tiếng Trung trên Windows:</p>
                  <p>Mở <strong>Settings (Cài đặt)</strong> &gt; <strong>Time &amp; Language</strong> &gt; <strong>Speech (Giọng nói)</strong> &gt; Bấm <strong>Add voices</strong> &gt; Chọn <strong>Chinese (Simplified, China)</strong>.</p>
                  <p className="font-bold text-app-accent pt-1">• Trên iPhone/iPad/Mac:</p>
                  <p>Vào <strong>Cài đặt</strong> &gt; <strong>Trợ năng</strong> &gt; <strong>Nội dung được đọc</strong> &gt; <strong>Giọng nói</strong> &gt; Chọn tiếng Trung (Phổ thông).</p>
                </div>
              )}
            </div>
          </div>

          <button
            type="button"
            onClick={() => setShowHelpGuide(!showHelpGuide)}
            className="text-[11px] font-sans font-bold text-amber-700 dark:text-amber-300 underline hover:text-amber-900 shrink-0 whitespace-nowrap"
          >
            {showHelpGuide ? 'Ẩn hướng dẫn' : 'Xem hướng dẫn'}
          </button>
        </div>
      )}
    </div>
  )
}
