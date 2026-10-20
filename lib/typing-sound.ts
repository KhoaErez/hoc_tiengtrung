// Quản lý âm thanh đọc tiếng Trung (Web Speech API) và âm báo gõ phím (Web Audio API)
// Dành riêng cho chức năng Luyện đánh máy tiếng Trung

export interface ChineseSentenceItem {
  index: number;
  startIndex: number;
  endIndex: number;
  text: string;
}

/**
 * 1. PHÂN TÁCH CÂU TIẾNG TRUNG CHÍNH XÁC
 * Hỗ trợ cả trường hợp đã có phân đoạn Gemini hoặc văn bản thuần chữ Hán
 */
export function extractChineseSentences(
  text: string,
  existingBlocks?: { startIndex: number; endIndex: number; segment: { chinese: string } }[]
): ChineseSentenceItem[] {
  // Nếu đã có phân đoạn từ Gemini, sử dụng trực tiếp các phân đoạn này
  if (existingBlocks && existingBlocks.length > 0) {
    return existingBlocks.map((b, idx) => ({
      index: idx,
      startIndex: b.startIndex,
      endIndex: b.endIndex,
      text: b.segment.chinese.trim() || text.slice(b.startIndex, b.endIndex).trim(),
    }));
  }

  if (!text || !text.trim()) return [];

  const sentences: ChineseSentenceItem[] = [];
  // Tách theo các dấu ngắt câu tiếng Trung: 。！？!?；; hoặc xuống dòng \n
  const regex = /[^。！？!?；;\n\r]+[。！？!?；;\n\r]*/g;
  let match: RegExpExecArray | null;

  while ((match = regex.exec(text)) !== null) {
    const rawMatch = match[0];
    const trimmed = rawMatch.trim();
    if (trimmed) {
      const offset = rawMatch.indexOf(trimmed);
      const startIndex = match.index + offset;
      const endIndex = startIndex + trimmed.length;
      sentences.push({
        index: sentences.length,
        startIndex,
        endIndex,
        text: trimmed,
      });
    }
  }

  // Fallback nếu văn bản không chứa dấu câu ngắt
  if (sentences.length === 0 && text.trim()) {
    sentences.push({
      index: 0,
      startIndex: 0,
      endIndex: text.length,
      text: text.trim(),
    });
  }

  return sentences;
}

/**
 * Tìm câu mà người dùng đang gõ dựa theo độ dài chuỗi đã gõ
 */
export function findCurrentSentenceIndex(
  sentences: ChineseSentenceItem[],
  typedLength: number
): number {
  if (!sentences || sentences.length === 0) return 0;
  if (typedLength <= 0) return 0;
  if (typedLength >= sentences[sentences.length - 1].endIndex) {
    return sentences.length - 1;
  }
  const found = sentences.findIndex(
    (s) => typedLength >= s.startIndex && typedLength < s.endIndex
  );
  return found !== -1 ? found : 0;
}

/**
 * 2. WEB AUDIO API - ÂM BÁO GÕ PHÍM NHẸ NHÀNG
 * Tự sinh âm thanh bằng Oscillator, không cần tải file âm thanh ngoài, không có độ trễ
 */
let sharedAudioCtx: AudioContext | null = null;

export function getAudioContext(): AudioContext | null {
  if (typeof window === 'undefined') return null;
  const AudioCtx =
    window.AudioContext ||
    (window as unknown as { webkitAudioContext: typeof AudioContext }).webkitAudioContext;
  if (!AudioCtx) return null;
  if (!sharedAudioCtx || sharedAudioCtx.state === 'closed') {
    sharedAudioCtx = new AudioCtx();
  }
  if (sharedAudioCtx.state === 'suspended') {
    sharedAudioCtx.resume().catch(() => {});
  }
  return sharedAudioCtx;
}

export function playTypingSfx(
  type: 'correct' | 'error' | 'complete',
  volume: number = 0.05
) {
  try {
    const ctx = getAudioContext();
    if (!ctx) return;
    const now = ctx.currentTime;

    if (type === 'correct') {
      // Âm gõ đúng: tiếng gõ thanh thoát nhẹ nhàng, cực ngắn 35ms (880Hz -> 1100Hz)
      const osc = ctx.createOscillator();
      const gain = ctx.createGain();
      osc.type = 'sine';
      osc.frequency.setValueAtTime(880, now);
      osc.frequency.exponentialRampToValueAtTime(1100, now + 0.03);
      gain.gain.setValueAtTime(volume * 0.7, now);
      gain.gain.exponentialRampToValueAtTime(0.0001, now + 0.035);
      osc.connect(gain);
      gain.connect(ctx.destination);
      osc.start(now);
      osc.stop(now + 0.04);
    } else if (type === 'error') {
      // Âm gõ sai: âm trầm ngắn, 45ms (220Hz -> 160Hz), không gây giật mình
      const osc = ctx.createOscillator();
      const gain = ctx.createGain();
      osc.type = 'triangle';
      osc.frequency.setValueAtTime(220, now);
      osc.frequency.exponentialRampToValueAtTime(160, now + 0.04);
      gain.gain.setValueAtTime(volume * 0.8, now);
      gain.gain.exponentialRampToValueAtTime(0.0001, now + 0.045);
      osc.connect(gain);
      gain.connect(ctx.destination);
      osc.start(now);
      osc.stop(now + 0.05);
    } else if (type === 'complete') {
      // Âm hoàn thành: chuỗi nốt tươi sáng C5 - E5 - G5 - C6
      const notes = [523.25, 659.25, 783.99, 1046.5];
      notes.forEach((freq, idx) => {
        const osc = ctx.createOscillator();
        const gain = ctx.createGain();
        osc.type = 'sine';
        const start = now + idx * 0.08;
        osc.frequency.setValueAtTime(freq, start);
        gain.gain.setValueAtTime(0, start);
        gain.gain.linearRampToValueAtTime(volume * 1.0, start + 0.02);
        gain.gain.exponentialRampToValueAtTime(0.0001, start + 0.35);
        osc.connect(gain);
        gain.connect(ctx.destination);
        osc.start(start);
        osc.stop(start + 0.36);
      });
    }
  } catch {
    // Không chặn luồng nếu trình duyệt chặn tự phát âm thanh
  }
}

/**
 * 3. QUẢN LÝ GIỌNG ĐỌC TIẾNG TRUNG (WEB SPEECH API)
 */
export function getChineseVoices(): SpeechSynthesisVoice[] {
  if (typeof window === 'undefined' || !window.speechSynthesis) return [];
  const voices = window.speechSynthesis.getVoices();
  const chineseVoices = voices.filter((v) => {
    const lang = (v.lang || '').toLowerCase().replace(/_/g, '-');
    return lang.startsWith('zh') || lang.includes('chinese');
  });

  // Ưu tiên zh-CN, sau đó zh-TW, zh-HK, zh
  return chineseVoices.sort((a, b) => {
    const aLang = (a.lang || '').toLowerCase().replace(/_/g, '-');
    const bLang = (b.lang || '').toLowerCase().replace(/_/g, '-');
    const aScore = aLang === 'zh-cn' ? 3 : aLang.startsWith('zh-cn') ? 2 : aLang.startsWith('zh') ? 1 : 0;
    const bScore = bLang === 'zh-cn' ? 3 : bLang.startsWith('zh-cn') ? 2 : bLang.startsWith('zh') ? 1 : 0;
    return bScore - aScore;
  });
}

/**
 * Kiểm tra xem thiết bị có hỗ trợ giọng đọc tiếng Trung hay không
 */
export function hasChineseVoiceAvailable(): boolean {
  if (typeof window === 'undefined' || !window.speechSynthesis) return false;
  const chinese = getChineseVoices();
  return chinese.length > 0;
}

/**
 * 4. PHÁT ÂM KÝ TỰ / TỪ TIẾNG TRUNG KHI GÕ (REAL-TIME TTS TYPING FEEDBACK)
 * Tự động hủy âm thanh gõ trước đó để âm thanh phát ngay lập tức không bị trễ hay chồng chéo
 */
let typingUtteranceId = 0;

export function speakChineseCharacter(
  text: string,
  voiceURI?: string,
  rate: number = 1.0
): number {
  if (typeof window === 'undefined' || !window.speechSynthesis) return 0;
  if (!text || !text.trim()) return 0;

  try {
    const currentId = ++typingUtteranceId;
    window.speechSynthesis.cancel();

    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = 'zh-CN';
    utterance.rate = Math.max(0.75, Math.min(1.5, rate));

    const voices = getChineseVoices();
    const voice = voices.find((v) => v.voiceURI === voiceURI) || voices[0];
    if (voice) utterance.voice = voice;

    window.speechSynthesis.speak(utterance);
    return currentId;
  } catch {
    return 0;
  }
}
