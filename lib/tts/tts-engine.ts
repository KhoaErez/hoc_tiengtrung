// Singleton Speech Engine cho Tiếng Trung Phổ Thông (Mandarin zh-CN)
// Hỗ trợ Web Speech API với cơ chế chống xung đột âm thanh, làm sạch văn bản,
// khắc phục lỗi ngắt 15 giây của Chromium (keepalive) và hỗ trợ điều chỉnh tốc độ 0.75x, 1x, 1.25x.

export type TTSStatus = 'idle' | 'loading' | 'playing' | 'paused'

export interface TTSState {
  status: TTSStatus
  currentId: string | null
  currentText: string | null
  rate: number
  selectedVoiceURI: string | null
  voices: SpeechSynthesisVoice[]
  hasChineseVoice: boolean
}

type StateListener = () => void

export interface SpeakOptions {
  id?: string
  rate?: number
  voiceURI?: string
  onStart?: () => void
  onEnd?: () => void
  onError?: (error: unknown) => void
  onBoundary?: (charIndex: number, charLength?: number, name?: string) => void
}

/**
 * 1. BỘ LỌC VĂN BẢN TIẾNG TRUNG THUẦN TÚY (CHINESE TEXT SANITIZER)
 * Loại bỏ Pinyin, nghĩa tiếng Việt, nhãn giao diện hoặc ký tự rác.
 * Chỉ giữ lại chữ Hán (CJK Unified Ideographs) và các dấu câu tiếng Trung tự nhiên.
 */
export function sanitizeChineseText(rawText: string): string {
  if (!rawText || typeof rawText !== 'string') return ''

  let text = rawText

  // 1. Loại bỏ các thẻ HTML / Markdown nếu có
  text = text.replace(/<[^>]*>/g, '').replace(/[*_#`~]/g, '')

  // 2. Loại bỏ các phần chú thích trong ngoặc đơn/ngoặc vuông/ngoặc tròn nếu KHÔNG chứa chữ Hán
  // (ví dụ: chứa Pinyin "zhōngwén", phiên âm quốc tế, hoặc nghĩa tiếng Việt)
  text = text.replace(/\([^()\u4e00-\u9fa5]*\)/g, '')
  text = text.replace(/\[[^\[\]\u4e00-\u9fa5]*\]/g, '')
  text = text.replace(/（[^（）\u4e00-\u9fa5]*）/g, '')

  // 3. Loại bỏ phần dịch nghĩa sau dấu gạch ngang hoặc dấu hai chấm nếu chứa chữ Latinh
  // Ví dụ: "你好 - Xin chào" -> "你好"
  const dashSplit = text.split(/\s*[-–—]\s*/)
  if (dashSplit.length > 1 && hasChinese(dashSplit[0]) && !hasChinese(dashSplit[1])) {
    text = dashSplit[0]
  }

  // 4. Chỉ giữ lại ký tự CJK, dấu câu tiếng Trung và dấu câu thông dụng
  const cleaned = text.trim()

  // Kiểm tra xem có chứa chữ Hán nào không
  if (!hasChinese(cleaned)) {
    // Nếu hoàn toàn không có chữ Hán, trả về chuỗi rỗng để không đọc nhầm tiếng Việt/Anh bằng giọng Trung
    return ''
  }

  return cleaned
}

/**
 * Kiểm tra chuỗi có chứa ít nhất một chữ Hán hay không
 */
export function hasChinese(text: string): boolean {
  return /[\u4e00-\u9fa5\u3400-\u4dbf]/.test(text)
}

/**
 * 2. SINGLETON TTS ENGINE
 */
class ChineseTTSEngine {
  private static instance: ChineseTTSEngine | null = null

  private status: TTSStatus = 'idle'
  private currentId: string | null = null
  private currentText: string | null = null
  private rate: number = 1.0
  private selectedVoiceURI: string | null = null
  private voices: SpeechSynthesisVoice[] = []
  private listeners: Set<StateListener> = new Set()
  private isVoicesInitialized = false

  // Cached snapshot bất biến để useSyncExternalStore so khớp Object.is an toàn,
  // tuyệt đối không sinh object mới nếu state không đổi, tránh Maximum update depth exceeded.
  private snapshot: TTSState = {
    status: 'idle',
    currentId: null,
    currentText: null,
    rate: 1.0,
    selectedVoiceURI: null,
    voices: [],
    hasChineseVoice: false,
  }

  private currentUtterance: SpeechSynthesisUtterance | null = null
  private keepAliveInterval: NodeJS.Timeout | null = null
  private activeOnEndCallback: (() => void) | null = null
  private activeOnErrorCallback: ((err: unknown) => void) | null = null
  private sessionEpoch: number = 0

  private constructor() {
    if (typeof window !== 'undefined') {
      this.initVoices()
    }
  }

  public static getInstance(): ChineseTTSEngine {
    if (!ChineseTTSEngine.instance) {
      ChineseTTSEngine.instance = new ChineseTTSEngine()
    }
    return ChineseTTSEngine.instance
  }

  /**
   * Dừng toàn bộ âm thanh trên toàn hệ thống (Web Speech API, TTS Engine, và gửi tín hiệu cho các component)
   */
  public static stopAllAudio(): void {
    if (ChineseTTSEngine.instance) {
      ChineseTTSEngine.instance.stop()
    }
    if (typeof window !== 'undefined') {
      try {
        if (window.speechSynthesis) {
          window.speechSynthesis.cancel()
        }
      } catch {}
      // Phát tín hiệu dừng âm thanh đến tất cả các component
      try {
        window.dispatchEvent(new CustomEvent('app:stop-all-audio'))
      } catch {}
    }
  }

  /**
   * Khởi tạo danh sách giọng đọc tiếng Trung
   */
  public initVoices(): void {
    if (typeof window === 'undefined' || !window.speechSynthesis) return

    const update = () => {
      const allVoices = window.speechSynthesis.getVoices()
      if (!allVoices || allVoices.length === 0) return

      const chineseVoices = allVoices.filter((v) => {
        const lang = (v.lang || '').toLowerCase().replace(/_/g, '-')
        return lang.startsWith('zh') || lang.includes('chinese') || v.name.toLowerCase().includes('chinese')
      })

      // Sắp xếp ưu tiên: zh-CN (Phổ thông đại lục) > zh-SG > zh-TW > zh
      chineseVoices.sort((a, b) => {
        const aLang = (a.lang || '').toLowerCase().replace(/_/g, '-')
        const bLang = (b.lang || '').toLowerCase().replace(/_/g, '-')
        const getScore = (lang: string, name: string) => {
          let score = 0
          if (lang === 'zh-cn' || lang === 'zh-cmn-hans-cn') score += 10
          else if (lang.startsWith('zh-cn')) score += 8
          else if (lang.startsWith('zh-sg')) score += 6
          else if (lang.startsWith('zh')) score += 4

          const lowerName = name.toLowerCase()
          if (lowerName.includes('xiaoxiao') || lowerName.includes('yunxi') || lowerName.includes('huihui')) score += 5
          if (lowerName.includes('ting-ting') || lowerName.includes('sin-ji') || lowerName.includes('meijia')) score += 4
          if (lowerName.includes('google') || lowerName.includes('natural')) score += 3
          return score
        }
        return getScore(bLang, b.name) - getScore(aLang, a.name)
      })

      // Chỉ cập nhật và thông báo nếu có sự thay đổi thực sự
      const voicesChanged =
        this.voices.length !== chineseVoices.length ||
        this.voices[0]?.voiceURI !== chineseVoices[0]?.voiceURI

      if (voicesChanged || !this.isVoicesInitialized) {
        this.isVoicesInitialized = true
        this.voices = chineseVoices
        if (!this.selectedVoiceURI && chineseVoices.length > 0) {
          this.selectedVoiceURI = chineseVoices[0].voiceURI
        }
        this.notify()
      }
    }

    update()
    if (window.speechSynthesis.onvoiceschanged !== undefined) {
      window.speechSynthesis.onvoiceschanged = update
    }
  }

  /**
   * Đăng ký lắng nghe thay đổi trạng thái cho useSyncExternalStore
   * TUYỆT ĐỐI KHÔNG gọi listener() đồng bộ bên trong subscribe,
   * để tuân thủ quy tắc React và tránh lặp vô hạn (Maximum update depth exceeded).
   */
  public subscribe(listener: StateListener): () => void {
    this.listeners.add(listener)
    return () => {
      this.listeners.delete(listener)
    }
  }

  public getState(): TTSState {
    return this.snapshot
  }

  private updateSnapshot(): void {
    this.snapshot = {
      status: this.status,
      currentId: this.currentId,
      currentText: this.currentText,
      rate: this.rate,
      selectedVoiceURI: this.selectedVoiceURI,
      voices: this.voices,
      hasChineseVoice: this.voices.length > 0,
    }
  }

  private notify(): void {
    this.updateSnapshot()
    this.listeners.forEach((listener) => {
      try {
        listener()
      } catch (err) {
        console.error('Lỗi listener TTS:', err)
      }
    })
  }

  /**
   * Dừng phát âm thanh ngay lập tức
   */
  public stop(): void {
    this.sessionEpoch++
    this.clearKeepAlive()

    if (typeof window !== 'undefined' && window.speechSynthesis) {
      try {
        window.speechSynthesis.cancel()
      } catch {
        // Bỏ qua lỗi ngắt
      }
    }

    this.status = 'idle'
    this.currentId = null
    this.currentText = null
    this.currentUtterance = null
    this.activeOnEndCallback = null
    this.activeOnErrorCallback = null

    this.notify()
    // Lưu ý quan trọng: KHÔNG gọi activeOnEndCallback() khi chủ động dừng/hủy phiên phát,
    // tránh gây lỗi lặp tự động đọc câu kế tiếp khi người dùng chuyển trang hoặc bấm dừng.
  }

  /**
   * Tạm dừng phát
   */
  public pause(): void {
    if (typeof window === 'undefined' || !window.speechSynthesis) return
    if (this.status === 'playing') {
      try {
        window.speechSynthesis.pause()
        this.status = 'paused'
        this.notify()
      } catch (err) {
        console.error('Không thể tạm dừng phát âm:', err)
      }
    }
  }

  /**
   * Tiếp tục phát
   */
  public resume(): void {
    if (typeof window === 'undefined' || !window.speechSynthesis) return
    if (this.status === 'paused') {
      try {
        window.speechSynthesis.resume()
        this.status = 'playing'
        this.notify()
      } catch (err) {
        console.error('Không thể tiếp tục phát âm:', err)
      }
    }
  }

  /**
   * Đặt tốc độ đọc (0.75x, 1x, 1.25x...)
   */
  public setRate(newRate: number): void {
    const validRate = Math.max(0.5, Math.min(2.0, newRate))
    if (this.rate !== validRate) {
      this.rate = validRate
      this.notify()
    }
  }

  /**
   * Chọn giọng đọc mong muốn
   */
  public setVoiceURI(uri: string): void {
    if (this.selectedVoiceURI !== uri) {
      this.selectedVoiceURI = uri
      this.notify()
    }
  }

  /**
   * PHÁT ÂM TIẾNG TRUNG
   * Tự động làm sạch văn bản, hủy âm thanh trước đó (tránh chồng chéo),
   * chọn voice zh-CN tốt nhất và bắt đầu phát âm.
   */
  public speak(rawText: string, options?: SpeakOptions): Promise<boolean> {
    return new Promise((resolve) => {
      if (typeof window === 'undefined' || !window.speechSynthesis) {
        resolve(false)
        return
      }

      const text = sanitizeChineseText(rawText)
      if (!text) {
        // Văn bản không chứa chữ Hán hợp lệ
        resolve(false)
        return
      }

      // 1. Luôn dừng âm thanh trước đó để không bị lồng tiếng
      this.stop()

      const currentEpoch = this.sessionEpoch
      const rate = options?.rate ?? this.rate
      const id = options?.id ?? text
      this.currentId = id
      this.currentText = text
      this.status = 'playing'
      this.activeOnEndCallback = options?.onEnd || null
      this.activeOnErrorCallback = options?.onError || null
      this.notify()

      try {
        const utterance = new SpeechSynthesisUtterance(text)
        utterance.lang = 'zh-CN'
        utterance.rate = rate

        // Tìm giọng đọc phù hợp
        if (this.voices.length === 0) {
          this.initVoices()
        }

        const voice =
          this.voices.find((v) => v.voiceURI === (options?.voiceURI || this.selectedVoiceURI)) ||
          this.voices[0]

        if (voice) {
          utterance.voice = voice
        }

        utterance.onstart = () => {
          if (currentEpoch !== this.sessionEpoch) return
          this.status = 'playing'
          this.notify()
          options?.onStart?.()
          this.startKeepAlive()
        }

        utterance.onboundary = (event) => {
          if (currentEpoch !== this.sessionEpoch) return
          options?.onBoundary?.(event.charIndex, event.charLength, event.name)
        }

        utterance.onend = () => {
          if (currentEpoch !== this.sessionEpoch) return
          this.clearKeepAlive()
          this.status = 'idle'
          this.currentId = null
          this.currentText = null
          this.currentUtterance = null
          this.notify()
          options?.onEnd?.()
          resolve(true)
        }

        utterance.onerror = (event) => {
          if (currentEpoch !== this.sessionEpoch) return
          this.clearKeepAlive()
          // Nếu bị ngắt do người dùng bấm nút mới (canceled/interrupted), không coi là lỗi nghiêm trọng
          if (event.error !== 'canceled' && event.error !== 'interrupted') {
            console.warn('Lỗi phát âm SpeechSynthesis:', event.error)
            options?.onError?.(event)
          }
          this.status = 'idle'
          this.currentId = null
          this.currentText = null
          this.currentUtterance = null
          this.notify()
          resolve(false)
        }

        this.currentUtterance = utterance
        window.speechSynthesis.speak(utterance)
      } catch (error) {
        if (currentEpoch !== this.sessionEpoch) return
        console.error('Lỗi khi kích hoạt SpeechSynthesis:', error)
        this.clearKeepAlive()
        this.status = 'idle'
        this.currentId = null
        this.currentText = null
        this.notify()
        options?.onError?.(error)
        resolve(false)
      }
    })
  }

  /**
   * KEEPALIVE CHO CHROMIUM
   * Trình duyệt Chromium có lỗi ngầm tự ngắt speech sau 15 giây nếu không có tương tác.
   * Kích hoạt pause/resume nhẹ định kỳ 10 giây để giữ audio engine hoạt động với đoạn văn dài.
   */
  private startKeepAlive(): void {
    this.clearKeepAlive()
    if (typeof window === 'undefined' || !window.speechSynthesis) return

    this.keepAliveInterval = setInterval(() => {
      if (this.status === 'playing' && window.speechSynthesis.speaking) {
        window.speechSynthesis.pause()
        window.speechSynthesis.resume()
      } else {
        this.clearKeepAlive()
      }
    }, 10000)
  }

  private clearKeepAlive(): void {
    if (this.keepAliveInterval) {
      clearInterval(this.keepAliveInterval)
      this.keepAliveInterval = null
    }
  }
}

export const ttsEngine = ChineseTTSEngine.getInstance()
export const stopAllAudio = () => ChineseTTSEngine.stopAllAudio()
