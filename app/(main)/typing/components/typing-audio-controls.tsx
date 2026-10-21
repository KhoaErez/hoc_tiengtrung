'use client'

import React, { useState } from 'react'
import {
  Volume2,
  VolumeX,
  Play,
  Pause,
  Square,
  Headphones,
  Sparkles,
  Info,
  ChevronDown,
  Gauge,
  Check,
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { ChineseSentenceItem } from '@/lib/typing-sound'

export interface TypingAudioControlsProps {
  sentences: ChineseSentenceItem[];
  currentSentenceIndex: number; // Câu mà người dùng đang gõ
  speakingSentenceIndex: number | null; // Câu đang được đọc bởi TTS
  speechStatus: 'idle' | 'playing' | 'paused';
  readingMode: 'all' | 'sentence' | null;
  speechRate: number; // 0.75 | 1 | 1.25
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
}: TypingAudioControlsProps) {
  const [showVoiceDropdown, setShowVoiceDropdown] = useState(false)
  const [showHelpGuide, setShowHelpGuide] = useState(false)

  const isPlayingAll = speechStatus === 'playing' && readingMode === 'all'
  const isPausedAll = speechStatus === 'paused' && readingMode === 'all'
  const isPlayingCurrent = speechStatus === 'playing' && readingMode === 'sentence'

  // Tìm giọng đọc đang được chọn
  const activeVoice =
    availableVoices.find((v) => v.voiceURI === selectedVoiceURI) ||
    availableVoices[0]

  const displayVoiceName = activeVoice
    ? activeVoice.name.replace(/Microsoft |Google |Chinese |\(China\)|\(PRC\)/gi, '').trim() ||
      activeVoice.name
    : 'Mặc định (zh-CN)'

  return (
    <div className="bg-card border border-border rounded-2xl p-3.5 md:p-4 shadow-2xs space-y-3 transition-all">
      {/* 1. HÀNG TIÊU ĐỀ & TÙY CHỈNH TỐC ĐỘ, GIỌNG ĐỌC */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2.5 pb-2.5 border-b border-border/80">
        <div className="flex items-center gap-2 flex-wrap">
          <div className="flex items-center gap-1.5">
            <Volume2 className="w-4 h-4 text-app-accent flex-shrink-0" />
            <span className="font-serif font-bold text-xs md:text-sm text-title">
              Luyện nghe & Phát âm tiếng Trung
            </span>
          </div>

          {/* Huy hiệu trạng thái âm thanh */}
          {speechStatus === 'playing' ? (
            <span className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-[10px] font-sans font-bold bg-emerald-500/15 text-jade border border-jade/30">
              <span className="w-2 h-2 rounded-full bg-emerald-500 animate-ping" />
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
            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-serif text-muted bg-page border border-border">
              <span>Sẵn sàng ({sentences.length} câu)</span>
            </span>
          )}
        </div>

        {/* Bộ điều chỉnh Tốc độ & Giọng đọc */}
        <div className="flex items-center gap-2 flex-wrap">
          {/* Chọn tốc độ đọc (0.5x, 0.75x, 1.0x, 1.25x, 1.5x, 2.0x) */}
          <div className="flex items-center bg-page border border-border rounded-xl p-0.5 text-xs font-serif flex-wrap">
            <span className="px-2 py-1 text-[11px] text-muted flex items-center gap-1">
              <Gauge className="w-3 h-3 text-muted" />
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
                className={`px-1.5 sm:px-2 py-0.5 rounded-lg text-xs font-sans transition-all ${
                  speechRate === rate
                    ? 'bg-title text-white font-bold shadow-2xs'
                    : 'text-muted hover:text-title hover:bg-card'
                }`}
                title={`Tốc độ ${label} — ${desc}`}
              >
                {label}
              </button>
            ))}
          </div>

          {/* Chọn giọng đọc nếu thiết bị có nhiều giọng Trung */}
          {availableVoices.length > 1 && (
            <div className="relative">
              <button
                type="button"
                onClick={() => setShowVoiceDropdown(!showVoiceDropdown)}
                className="flex items-center gap-1.5 px-2.5 py-1 rounded-xl border border-border bg-page text-xs font-serif text-title hover:border-app-accent/40 transition-colors"
                title="Chọn giọng đọc tiếng Trung"
              >
                <span className="truncate max-w-[110px]">{displayVoiceName}</span>
                <ChevronDown className="w-3 h-3 text-muted" />
              </button>

              {showVoiceDropdown && (
                <div className="absolute right-0 mt-1 w-52 bg-card border border-border rounded-xl shadow-lg z-50 p-1.5 space-y-1">
                  <p className="text-[10px] font-serif text-muted px-2 py-1 border-b border-border">
                    Chọn giọng đọc tiếng Trung ({availableVoices.length}):
                  </p>
                  <div className="max-h-48 overflow-y-auto no-scrollbar space-y-0.5">
                    {availableVoices.map((v) => {
                      const isSelected = v.voiceURI === activeVoice?.voiceURI
                      return (
                        <button
                          key={v.voiceURI}
                          type="button"
                          onClick={() => {
                            onVoiceChange(v.voiceURI)
                            setShowVoiceDropdown(false)
                          }}
                          className={`w-full flex items-center justify-between text-left px-2 py-1.5 rounded-lg text-xs font-serif transition-colors ${
                            isSelected
                              ? 'bg-app-accent-soft/40 text-app-accent font-bold'
                              : 'text-title hover:bg-page'
                          }`}
                        >
                          <span className="truncate">{v.name}</span>
                          {isSelected && <Check className="w-3.5 h-3.5 text-app-accent ml-1 flex-shrink-0" />}
                        </button>
                      )
                    })}
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
            className={`font-serif text-xs rounded-xl shadow-2xs gap-1.5 h-8 px-3.5 transition-all ${
              isPlayingAll
                ? 'bg-amber-600 hover:bg-amber-700 text-white font-bold'
                : 'bg-app-accent hover:bg-accent-hover text-white'
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
                <span>Nghe toàn bộ đoạn</span>
              </>
            )}
          </Button>

          {/* Nút Nghe câu hiện tại */}
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={onPlayCurrentSentence}
            disabled={sentences.length === 0}
            className={`font-serif text-xs rounded-xl border-border h-8 px-3 gap-1.5 transition-colors ${
              isPlayingCurrent
                ? 'bg-app-accent-soft/50 border-app-accent text-app-accent font-bold ring-1 ring-app-accent'
                : 'text-title hover:border-app-accent/40 bg-page'
            }`}
            title={`Nghe phát âm chuẩn của câu đang luyện (Câu ${currentSentenceIndex + 1})`}
          >
            <Headphones className="w-3.5 h-3.5 text-app-accent" />
            <span>Nghe câu hiện tại (Câu {currentSentenceIndex + 1})</span>
          </Button>

          {/* Nút Dừng phát */}
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={onStop}
            disabled={speechStatus === 'idle'}
            className="font-serif text-xs rounded-xl border-border text-muted hover:text-red-600 hover:border-red-500/40 h-8 px-2.5 gap-1 disabled:opacity-40"
            title="Dừng đọc âm thanh"
          >
            <Square className="w-3 h-3" />
            <span>Dừng phát</span>
          </Button>
        </div>

        {/* Nhóm nút tùy chọn: Âm gõ phím & Tự đọc câu tiếp theo */}
        <div className="flex items-center gap-2 flex-wrap">
          {/* Bật / Tắt âm báo gõ phím */}
          <button
            type="button"
            onClick={onToggleTypingSound}
            className={`flex items-center gap-1.5 px-2.5 py-1.5 rounded-xl border text-xs font-serif transition-colors ${
              typingSoundEnabled
                ? 'bg-app-accent-soft/40 border-app-accent/40 text-app-accent font-medium'
                : 'bg-page border-border text-muted hover:text-title'
            }`}
            title="Bật/Tắt âm báo nhẹ khi gõ đúng và sai ký tự"
          >
            {typingSoundEnabled ? (
              <Volume2 className="w-3.5 h-3.5 text-app-accent" />
            ) : (
              <VolumeX className="w-3.5 h-3.5 text-muted" />
            )}
            <span>{typingSoundEnabled ? 'Âm gõ: Bật' : 'Âm gõ: Tắt'}</span>
          </button>

          {/* Tùy chọn Tự đọc câu mới khi hiển thị */}
          <button
            type="button"
            onClick={onToggleAutoSpeakNext}
            className={`flex items-center gap-1.5 px-2.5 py-1.5 rounded-xl border text-xs font-serif transition-colors ${
              autoSpeakNext
                ? 'bg-title text-white font-medium border-title shadow-2xs'
                : 'bg-page border-border text-muted hover:text-title'
            }`}
            title="Tự động phát âm thanh khi hiển thị câu mới hoặc chuyển câu"
          >
            <Sparkles className="w-3.5 h-3.5 text-gold" />
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
