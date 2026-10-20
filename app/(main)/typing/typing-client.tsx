'use client'

import { useState, useEffect, useRef, useMemo, useCallback } from 'react'
import {
  TypingMode,
  TypingExercise,
  getExercisesByMode,
  vocabularyCategories,
  paragraphExercises,
  getHskLessonNumbers,
} from '@/data/typing-lessons'
import CustomParagraphMode from './components/custom-paragraph-mode'
import TypingAudioControls from './components/typing-audio-controls'
import { AudioButton } from '@/components/ui/audio-button'
import { PassageAudioPlayer } from '@/components/ui/passage-audio-player'
import { ttsEngine } from '@/lib/tts/tts-engine'
import {
  ChineseSentenceItem,
  extractChineseSentences,
  findCurrentSentenceIndex,
  playTypingSfx,
  getChineseVoices,
  speakChineseCharacter,
  getAudioContext,
} from '@/lib/typing-sound'
import {
  ChineseWordToken,
  segmentAndAlignChinese,
  findWordIndexByCharIndex,
} from '@/lib/tts/chinese-word-segmenter'
import {
  TypingSession,
  TypingStats,
  TypingPreferences,
  getTypingHistory,
  saveTypingSession,
  getTypingStats,
  getTypingPreferences,
  saveTypingPreferences,
  clearTypingHistory,
} from '@/lib/typing-storage'
import { toast } from 'sonner'
import {
  Keyboard,
  RotateCcw,
  CheckCircle2,
  XCircle,
  ArrowRight,
  ArrowLeft,
  Clock,
  Zap,
  Target,
  Award,
  Eye,
  EyeOff,
  History,
  BookOpen,
  Sparkles,
  X,
  Volume2,
  VolumeX,
  GraduationCap,
  Layers,
  FileText,
  AlignLeft,
} from 'lucide-react'

// Hàm chuẩn hóa ký tự dấu câu tiếng Trung & tiếng Anh tương đương
function normalizeChar(char: string): string {
  if (!char) return ''
  const punctuationMap: Record<string, string> = {
    '，': ',',
    '。': '.',
    '！': '!',
    '？': '?',
    '：': ':',
    '；': ';',
    '“': '"',
    '”': '"',
    '‘': "'",
    '’': "'",
    '（': '(',
    '）': ')',
    '【': '[',
    '】': ']',
    '、': ',',
  }
  return punctuationMap[char] || char
}

// Hàm so khớp 2 ký tự (chấp nhận cả dấu câu toàn giác & bán giác)
function isCharMatch(c1: string, c2: string, allowNormalize = true): boolean {
  if (!c1 || !c2) return false
  if (c1 === c2) return true
  if (allowNormalize) {
    return normalizeChar(c1) === normalizeChar(c2)
  }
  return false
}

export default function TypingClient() {
  // Chế độ & Bộ lọc
  const [mode, setMode] = useState<TypingMode>('sentence')
  const [paragraphType, setParagraphType] = useState<'preset' | 'custom'>('preset')
  const [levelFilter, setLevelFilter] = useState<string>('all')
  const [categoryFilter, setCategoryFilter] = useState<string>('all')
  const [hskLevel, setHskLevel] = useState<number>(1)
  const [hskLesson, setHskLesson] = useState<number>(0)
  const [hskTarget, setHskTarget] = useState<'word' | 'example'>('example')

  // Danh sách các bài học có trong cấp HSK hiện tại
  const availableLessons = useMemo(() => {
    return getHskLessonNumbers(hskLevel)
  }, [hskLevel])

  // Dữ liệu bài tập HSK tải động theo nhu cầu để không làm phình to client bundle
  const [hskDynamicExercises, setHskDynamicExercises] = useState<TypingExercise[]>([])

  useEffect(() => {
    if (mode !== 'hsk') return
    let isCancelled = false

    import('@/data/hsk-typing-vocabularies').then((mod) => {
      if (isCancelled) return
      const words = mod.getHskWordsByLevel(hskLevel, {
        lesson: hskLesson > 0 ? hskLesson : undefined,
      })
      const isExampleMode = hskTarget === 'example'
      const mapped: TypingExercise[] = words.map((w) => ({
        id: isExampleMode ? `hsk-${w.id}-ex` : `hsk-${w.id}`,
        titleZh: isExampleMode ? `${w.hanzi} [${w.pinyin}]` : `Từ vựng HSK ${w.hskLevel}`,
        titleVi: w.meaning,
        hanzi: isExampleMode ? (w.exampleHanzi || w.hanzi) : w.hanzi,
        pinyin: isExampleMode ? (w.examplePinyin || w.pinyin) : w.pinyin,
        meaning: isExampleMode ? (w.exampleVi || w.meaning) : w.meaning,
        mode: 'hsk' as TypingMode,
        hskLevel: w.hskLevel,
        level: `HSK ${w.hskLevel} - Bài ${w.lessonNumber}`,
        category: w.category,
        difficulty: w.hskLevel <= 2 ? 'easy' : w.hskLevel <= 4 ? 'medium' : 'hard',
        exampleHanzi: w.exampleHanzi,
        examplePinyin: w.examplePinyin,
        exampleVi: w.exampleVi,
      }))
      setHskDynamicExercises(mapped)
    }).catch((err) => {
      console.error('Failed to load HSK vocabulary chunk:', err)
    })

    return () => {
      isCancelled = true
    }
  }, [mode, hskLevel, hskLesson, hskTarget])

  // Danh sách bài tập hiện tại & Chỉ số bài đang làm
  const exercises = useMemo(() => {
    if (mode === 'hsk') {
      if (hskDynamicExercises.length > 0) return hskDynamicExercises
      return getExercisesByMode('hsk', { hskLevel })
    }
    return getExercisesByMode(mode, {
      level: levelFilter,
      category: categoryFilter,
    })
  }, [mode, levelFilter, categoryFilter, hskDynamicExercises, hskLevel])

  const [currentIndex, setCurrentIndex] = useState(0)
  const [exerciseEpoch, setExerciseEpoch] = useState(0)
  const currentExercise = exercises[currentIndex] || exercises[0]

  // Trạng thái nhập liệu & IME
  const [userInput, setUserInput] = useState('')
  const [isComposing, setIsComposing] = useState(false)
  const [compositionText, setCompositionText] = useState('')
  const inputRef = useRef<HTMLInputElement | HTMLTextAreaElement | null>(null)

  // Thời gian & Trạng thái luyện tập
  const [isStarted, setIsStarted] = useState(false)
  const [isCompleted, setIsCompleted] = useState(false)
  const [elapsedSeconds, setElapsedSeconds] = useState(0)
  const timerRef = useRef<NodeJS.Timeout | null>(null)

  // Tùy chọn hiển thị
  const [preferences, setPreferences] = useState<TypingPreferences>({
    showPinyin: true,
    showMeaning: true,
    hideHanzi: false,
    normalizePunctuation: true,
    soundEffects: true,
    autoSpeakNext: true,
    speakOnType: true,
  })

  // Thống kê & Lịch sử
  const [stats, setStats] = useState<TypingStats | null>(null)
  const [showHistoryModal, setShowHistoryModal] = useState(false)
  const [historyList, setHistoryList] = useState<TypingSession[]>([])

  // TTS State cho chức năng Luyện đánh máy
  const [speechStatus, setSpeechStatus] = useState<'idle' | 'playing' | 'paused'>('idle')
  const [speakingSentenceIndex, setSpeakingSentenceIndex] = useState<number | null>(null)
  const [speakingWordIndex, setSpeakingWordIndex] = useState<number | null>(null)
  const utteranceIdRef = useRef<number>(0)
  const wordElementsRef = useRef<Map<string, HTMLElement>>(new Map())
  const committedLengthRef = useRef<number>(0)
  const isComposingRef = useRef<boolean>(false)
  const [readingMode, setReadingMode] = useState<'all' | 'sentence' | null>(null)
  const readingModeRef = useRef<'all' | 'sentence' | null>(null)
  const [speechRate, setSpeechRate] = useState<number>(1.0)
  const speechRateRef = useRef<number>(1.0)
  const [selectedVoiceURI, setSelectedVoiceURI] = useState<string>('')
  const selectedVoiceURIRef = useRef<string>('')
  const [availableVoices, setAvailableVoices] = useState<SpeechSynthesisVoice[]>([])
  const [hasVoiceWarning, setHasVoiceWarning] = useState<boolean>(false)
  const autoSpeakNextRef = useRef<boolean>(true)
  const lastAutoSpokenExerciseIdRef = useRef<string | null>(null)

  // Tải cài đặt & thống kê từ localStorage
  useEffect(() => {
    const p = getTypingPreferences()
    setPreferences(p)
    if (p.speechRate) {
      setSpeechRate(p.speechRate)
      speechRateRef.current = p.speechRate
    }
    if (p.preferredVoiceURI) {
      setSelectedVoiceURI(p.preferredVoiceURI)
      selectedVoiceURIRef.current = p.preferredVoiceURI
    }
    if (p.autoSpeakNext !== undefined) {
      autoSpeakNextRef.current = p.autoSpeakNext
    }
    setStats(getTypingStats())
    setHistoryList(getTypingHistory())
  }, [])

  // Khởi tạo giọng đọc tiếng Trung
  useEffect(() => {
    if (typeof window === 'undefined' || !window.speechSynthesis) return
    const updateVoices = () => {
      const v = getChineseVoices()
      setAvailableVoices(v)
      setHasVoiceWarning(v.length === 0)
      if (v.length > 0 && !selectedVoiceURIRef.current) {
        setSelectedVoiceURI(v[0].voiceURI)
        selectedVoiceURIRef.current = v[0].voiceURI
      }
    }
    updateVoices()
    window.speechSynthesis.onvoiceschanged = updateVoices
    return () => {
      if (typeof window !== 'undefined' && window.speechSynthesis) {
        window.speechSynthesis.onvoiceschanged = null
      }
    }
  }, [])

  // Phân tách câu tiếng Trung cho bài tập hiện tại
  const chineseSentences = useMemo(() => {
    return extractChineseSentences(currentExercise?.hanzi || '')
  }, [currentExercise?.hanzi])

  // Phân đoạn từ tiếng Trung & đồng bộ Pinyin cho câu hiện tại
  const exerciseWordTokens = useMemo(() => {
    if (!currentExercise?.hanzi) return []
    return segmentAndAlignChinese(currentExercise.hanzi, currentExercise.pinyin || '')
  }, [currentExercise?.hanzi, currentExercise?.pinyin])

  // Refs đồng bộ thời gian thực để triệt tiêu 100% lỗi stale closure
  const chineseSentencesRef = useRef<ChineseSentenceItem[]>([])
  useEffect(() => {
    chineseSentencesRef.current = chineseSentences
  }, [chineseSentences])

  const exerciseWordTokensRef = useRef<ChineseWordToken[]>([])
  useEffect(() => {
    exerciseWordTokensRef.current = exerciseWordTokens
  }, [exerciseWordTokens])

  const currentCardEpochRef = useRef<number>(0)
  const autoSpeakTimerRef = useRef<NodeJS.Timeout | null>(null)

  const clearAutoSpeakTimer = useCallback(() => {
    if (autoSpeakTimerRef.current) {
      clearTimeout(autoSpeakTimerRef.current)
      autoSpeakTimerRef.current = null
    }
  }, [])

  // Chỉ số câu đang gõ dựa theo độ dài chuỗi đã gõ
  const currentTypingSentenceIndex = useMemo(() => {
    return findCurrentSentenceIndex(chineseSentences, userInput.length)
  }, [chineseSentences, userInput.length])

  // Dừng phát âm thanh ngay lập tức
  const stopSpeech = useCallback(() => {
    currentCardEpochRef.current++
    clearAutoSpeakTimer()
    utteranceIdRef.current++
    if (typeof window !== 'undefined' && window.speechSynthesis) {
      try {
        window.speechSynthesis.cancel()
      } catch {}
    }
    ttsEngine.stop()
    setSpeechStatus('idle')
    setSpeakingSentenceIndex(null)
    setSpeakingWordIndex(null)
    setReadingMode(null)
    readingModeRef.current = null
  }, [clearAutoSpeakTimer])

  // Dọn dẹp âm thanh khi component unmount hoặc nhận tín hiệu dừng âm thanh toàn cục (chuyển trang)
  useEffect(() => {
    const handleStopAll = () => {
      stopSpeech()
    }
    if (typeof window !== 'undefined') {
      window.addEventListener('app:stop-all-audio', handleStopAll)
    }
    return () => {
      if (typeof window !== 'undefined') {
        window.removeEventListener('app:stop-all-audio', handleStopAll)
      }
      stopSpeech()
    }
  }, [stopSpeech])

  // Phát âm câu tiếng Trung kèm Word-Level Highlighting
  // Hỗ trợ truyền trực tiếp customSentences và customWordTokens của thẻ đích để triệt tiêu 100% lỗi đọc nhầm thẻ cũ do stale closure
  const speakSentence = useCallback(
    (
      index: number,
      isSequential = false,
      customSentences?: ChineseSentenceItem[],
      customWordTokens?: ChineseWordToken[],
      expectedEpoch?: number
    ) => {
      if (typeof window === 'undefined' || !window.speechSynthesis) return

      // Nếu có truyền epoch và epoch không khớp với thẻ hiện tại -> hủy bỏ ngay
      if (expectedEpoch !== undefined && expectedEpoch !== currentCardEpochRef.current) {
        return
      }

      // Luôn ưu tiên danh sách câu được truyền trực tiếp từ thẻ đích, nếu không lấy từ ref mới nhất
      const list = customSentences || chineseSentencesRef.current
      if (!list || index < 0 || index >= list.length) {
        stopSpeech()
        return
      }

      const tokens = customWordTokens || exerciseWordTokensRef.current

      // Hủy mọi âm thanh cũ trong hàng đợi trước khi phát câu mới
      try {
        window.speechSynthesis.cancel()
      } catch {}

      const currentUtteranceId = ++utteranceIdRef.current
      const thisEpoch = expectedEpoch ?? currentCardEpochRef.current
      const item = list[index]
      setSpeakingSentenceIndex(index)

      // Tìm từ đầu tiên của câu trong tokens
      const firstWordIdx = findWordIndexByCharIndex(tokens, item.startIndex)
      setSpeakingWordIndex(firstWordIdx !== -1 ? firstWordIdx : 0)
      setSpeechStatus('playing')

      const utterance = new SpeechSynthesisUtterance(item.text)
      utterance.lang = 'zh-CN'
      utterance.rate = speechRateRef.current

      const voices = getChineseVoices()
      const voice =
        voices.find((v) => v.voiceURI === selectedVoiceURIRef.current) || voices[0]
      if (voice) utterance.voice = voice

      // Lắng nghe sự kiện boundary để tô sáng từng từ theo thời gian thực
      utterance.onboundary = (event) => {
        if (currentUtteranceId !== utteranceIdRef.current) return
        if (thisEpoch !== currentCardEpochRef.current) return
        const globalCharIndex = item.startIndex + event.charIndex
        const wordIdx = findWordIndexByCharIndex(tokens, globalCharIndex)
        if (wordIdx !== -1) {
          setSpeakingWordIndex(wordIdx)

          // Tự động cuộn mượt mà đến từ đang đọc nếu cần
          const el = wordElementsRef.current.get(`word-${wordIdx}`)
          if (el) {
            el.scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'nearest' })
          }
        }
      }

      utterance.onend = () => {
        if (currentUtteranceId !== utteranceIdRef.current) return
        if (thisEpoch !== currentCardEpochRef.current) return
        if (readingModeRef.current === 'all' && isSequential) {
          if (index + 1 < list.length) {
            speakSentence(index + 1, true, list, tokens, thisEpoch)
          } else {
            stopSpeech()
          }
        } else {
          setSpeechStatus('idle')
          setSpeakingSentenceIndex(null)
          setSpeakingWordIndex(null)
          setReadingMode(null)
          readingModeRef.current = null
        }
      }

      utterance.onerror = (e) => {
        if (currentUtteranceId !== utteranceIdRef.current) return
        if (e.error !== 'interrupted' && e.error !== 'canceled') {
          stopSpeech()
        }
      }

      window.speechSynthesis.speak(utterance)
    },
    [stopSpeech]
  )

  // Mở khóa âm thanh nếu trình duyệt yêu cầu tương tác đầu tiên của người dùng (Autoplay Policy)
  useEffect(() => {
    if (typeof window === 'undefined') return
    const unlockSpeech = () => {
      if (window.speechSynthesis && window.speechSynthesis.paused) {
        window.speechSynthesis.resume()
      }
      getAudioContext()
    }

    window.addEventListener('pointerdown', unlockSpeech, { once: true })
    window.addEventListener('keydown', unlockSpeech, { once: true })
    return () => {
      window.removeEventListener('pointerdown', unlockSpeech)
      window.removeEventListener('keydown', unlockSpeech)
    }
  }, [])

  // Tự động phát âm thanh khi hiển thị câu/đoạn tiếng Trung mới (Lần đầu vào trang, Đổi bộ lọc, Chuyển câu)
  // Cơ chế chống phát lặp: Dùng lastAutoSpokenExerciseIdRef để đảm bảo mỗi câu chỉ phát đúng 1 lượt duy nhất,
  // tuyệt đối không phát lặp do re-render khi người dùng gõ phím, soạn pinyin IME hoặc đồng hồ nhảy giây.
  useEffect(() => {
    if (!preferences.autoSpeakNext || !currentExercise?.id || !currentExercise?.hanzi) {
      return
    }

    // Nếu ID câu này đã được phát tự động rồi thì bỏ qua
    if (lastAutoSpokenExerciseIdRef.current === currentExercise.id) {
      return
    }

    lastAutoSpokenExerciseIdRef.current = currentExercise.id

    stopSpeech()
    const thisEpoch = ++currentCardEpochRef.current
    clearAutoSpeakTimer()

    // Phân tách câu & tokens trực tiếp cho câu mục tiêu mới để đảm bảo 100% dữ liệu đồng bộ
    const targetSentences = extractChineseSentences(currentExercise.hanzi)
    const targetTokens = segmentAndAlignChinese(
      currentExercise.hanzi,
      currentExercise.pinyin || ''
    )

    chineseSentencesRef.current = targetSentences
    exerciseWordTokensRef.current = targetTokens

    autoSpeakTimerRef.current = setTimeout(() => {
      if (thisEpoch !== currentCardEpochRef.current) return
      readingModeRef.current = 'all'
      setReadingMode('all')
      speakSentence(0, true, targetSentences, targetTokens, thisEpoch)
    }, 120)

    return () => {
      clearAutoSpeakTimer()
    }
  }, [
    currentExercise?.id,
    currentExercise?.hanzi,
    currentExercise?.pinyin,
    exerciseEpoch,
    preferences.autoSpeakNext,
    clearAutoSpeakTimer,
    stopSpeech,
    speakSentence,
  ])

  const handlePlayAll = useCallback(() => {
    clearAutoSpeakTimer()
    const list = chineseSentencesRef.current
    if (list.length === 0) return
    if (availableVoices.length === 0 && typeof window !== 'undefined' && window.speechSynthesis) {
      const v = getChineseVoices()
      if (v.length === 0) {
        toast.warning(
          'Thiết bị chưa tìm thấy giọng đọc tiếng Trung (zh-CN). Vui lòng thêm giọng tiếng Trung trong cài đặt thiết bị.'
        )
      }
    }
    readingModeRef.current = 'all'
    setReadingMode('all')
    speakSentence(0, true, list, exerciseWordTokensRef.current, currentCardEpochRef.current)
  }, [availableVoices, speakSentence, clearAutoSpeakTimer])

  const handlePlayCurrentSentence = useCallback(() => {
    clearAutoSpeakTimer()
    const list = chineseSentencesRef.current
    if (list.length === 0) return
    readingModeRef.current = 'sentence'
    setReadingMode('sentence')
    speakSentence(
      currentTypingSentenceIndex,
      false,
      list,
      exerciseWordTokensRef.current,
      currentCardEpochRef.current
    )
  }, [currentTypingSentenceIndex, speakSentence, clearAutoSpeakTimer])

  const handlePauseSpeech = useCallback(() => {
    if (typeof window !== 'undefined' && window.speechSynthesis) {
      window.speechSynthesis.pause()
      setSpeechStatus('paused')
    }
  }, [])

  const handleResumeSpeech = useCallback(() => {
    if (typeof window !== 'undefined' && window.speechSynthesis) {
      window.speechSynthesis.resume()
      setSpeechStatus('playing')
      setTimeout(() => {
        if (window.speechSynthesis.paused && speakingSentenceIndex !== null) {
          speakSentence(speakingSentenceIndex, readingModeRef.current === 'all')
        }
      }, 150)
    }
  }, [speakingSentenceIndex, speakSentence])

  const handleRateChange = (rate: number) => {
    setSpeechRate(rate)
    speechRateRef.current = rate
    const updated = { ...preferences, speechRate: rate }
    setPreferences(updated)
    saveTypingPreferences(updated)
  }

  const handleVoiceChange = (uri: string) => {
    setSelectedVoiceURI(uri)
    selectedVoiceURIRef.current = uri
    const updated = { ...preferences, preferredVoiceURI: uri }
    setPreferences(updated)
    saveTypingPreferences(updated)
  }

  const handleToggleTypingSound = () => {
    const nextVal = !preferences.soundEffects
    updatePref('soundEffects', nextVal)
  }

  const handleToggleAutoSpeakNext = () => {
    const nextVal = !preferences.autoSpeakNext
    autoSpeakNextRef.current = nextVal
    const updated = { ...preferences, autoSpeakNext: nextVal }
    setPreferences(updated)
    saveTypingPreferences(updated)
    if (nextVal) {
      // Khi bật lại, cho phép đọc câu hiện tại nếu cần
      lastAutoSpokenExerciseIdRef.current = null
    } else {
      stopSpeech()
    }
  }

  // Reset khi đổi chế độ hoặc đổi bài
  const resetExercise = useCallback(() => {
    stopSpeech()
    committedLengthRef.current = 0
    isComposingRef.current = false
    setUserInput('')
    setIsComposing(false)
    setCompositionText('')
    setIsStarted(false)
    setIsCompleted(false)
    setElapsedSeconds(0)
    if (timerRef.current) clearInterval(timerRef.current)
    setTimeout(() => inputRef.current?.focus(), 50)
  }, [stopSpeech])

  // Chuyển bài khi đổi bộ lọc
  useEffect(() => {
    lastAutoSpokenExerciseIdRef.current = null
    setExerciseEpoch((prev) => prev + 1)
    setCurrentIndex(0)
    resetExercise()
  }, [mode, levelFilter, categoryFilter, hskLevel, resetExercise])

  // Quản lý đồng hồ tính giờ
  useEffect(() => {
    if (isStarted && !isCompleted) {
      timerRef.current = setInterval(() => {
        setElapsedSeconds((prev) => prev + 1)
      }, 1000)
    } else {
      if (timerRef.current) clearInterval(timerRef.current)
    }
    return () => {
      if (timerRef.current) clearInterval(timerRef.current)
    }
  }, [isStarted, isCompleted])

  // Tính toán kết quả so khớp
  const evaluation = useMemo(() => {
    if (!currentExercise) {
      return {
        correctCount: 0,
        errorCount: 0,
        accuracy: 100,
        cpm: 0,
        errors: [] as { index: number; expected: string; actual: string }[],
      }
    }

    const target = currentExercise.hanzi
    const input = userInput
    let correct = 0
    let errors: { index: number; expected: string; actual: string }[] = []

    for (let i = 0; i < input.length; i++) {
      if (i < target.length) {
        if (isCharMatch(input[i], target[i], preferences.normalizePunctuation)) {
          correct++
        } else {
          errors.push({
            index: i + 1,
            expected: target[i],
            actual: input[i],
          })
        }
      } else {
        // Ký tự gõ thừa
        errors.push({
          index: i + 1,
          expected: '(thừa)',
          actual: input[i],
        })
      }
    }

    const accuracy =
      input.length > 0 ? Math.max(0, Math.round((correct / Math.max(target.length, input.length)) * 100)) : 100

    const minutes = Math.max(elapsedSeconds, 1) / 60
    const cpm = Math.round(correct / minutes)

    return {
      correctCount: correct,
      errorCount: errors.length,
      accuracy,
      cpm,
      errors,
    }
  }, [currentExercise, userInput, elapsedSeconds, preferences.normalizePunctuation])

  // Hoàn thành bài tập
  const handleFinish = useCallback(() => {
    if (isCompleted || !currentExercise) return
    setIsCompleted(true)
    if (timerRef.current) clearInterval(timerRef.current)
    stopSpeech()

    if (preferences.soundEffects) {
      playTypingSfx('complete')
    }

    // Lưu vào lịch sử luyện tập
    const session: TypingSession = {
      id: Date.now().toString(),
      exerciseId: currentExercise.id,
      date: new Date().toISOString(),
      mode,
      level: currentExercise.level || `HSK ${currentExercise.hskLevel || 1}`,
      timeSeconds: Math.max(elapsedSeconds, 1),
      targetChars: currentExercise.hanzi.length,
      correctChars: evaluation.correctCount,
      errorChars: evaluation.errorCount,
      accuracy: evaluation.accuracy,
      cpm: evaluation.cpm,
    }

    saveTypingSession(session)
    setStats(getTypingStats())
    setHistoryList(getTypingHistory())
  }, [isCompleted, currentExercise, stopSpeech, preferences.soundEffects, mode, elapsedSeconds, evaluation])

  // Xử lý chuỗi ký tự đã được xác nhận (committed)
  // Xử lý ngay lập tức cho cả IME compositionend và input trực tiếp, loại bỏ 100% độ trễ 1 ký tự
  const handleCommittedText = useCallback(
    (newVal: string) => {
      const prevLength = committedLengthRef.current
      const newLength = newVal.length

      if (!isStarted && newLength > 0) {
        setIsStarted(true)
      }

      setUserInput(newVal)

      // 1. Trường hợp người dùng xóa ký tự (Backspace)
      if (newLength <= prevLength) {
        committedLengthRef.current = newLength
        return
      }

      // 2. Trường hợp có ký tự mới được xác nhận (startIdx -> endIdx)
      const startIdx = prevLength
      const endIdx = newLength
      committedLengthRef.current = newLength

      if (!currentExercise) return

      // Kiểm tra tính chính xác của các ký tự vừa gõ
      let allCorrect = true
      let lastMatchIdx = -1
      for (let i = startIdx; i < endIdx; i++) {
        const targetChar = currentExercise.hanzi[i]
        if (targetChar && isCharMatch(newVal[i], targetChar, preferences.normalizePunctuation)) {
          lastMatchIdx = i
        } else {
          allCorrect = false
        }
      }

      // Phát âm báo gõ phím nhẹ nhàng
      if (preferences.soundEffects) {
        playTypingSfx(allCorrect ? 'correct' : 'error')
      }

      // Phát âm (TTS) chữ Hán vừa được gõ/chọn ngay lập tức
      const newlyTypedText = newVal.slice(startIdx, endIdx)
      if (preferences.speakOnType !== false && newlyTypedText.trim()) {
        // Tìm word token tương ứng nếu có để đồng bộ highlight
        if (lastMatchIdx !== -1 && exerciseWordTokens.length > 0) {
          const wIdx = findWordIndexByCharIndex(exerciseWordTokens, lastMatchIdx)
          if (wIdx !== -1) {
            setSpeakingWordIndex(wIdx)
            setTimeout(() => {
              setSpeakingWordIndex((prev) => (prev === wIdx ? null : prev))
            }, 800)
          }
        }
        speakChineseCharacter(newlyTypedText, selectedVoiceURIRef.current, speechRateRef.current)
      }

      // Tự đọc câu tiếp theo khi gõ xong câu hiện tại nếu bật autoSpeakNext
      if (autoSpeakNextRef.current && chineseSentences.length > 1) {
        const curSentence = chineseSentences.find(
          (s) => prevLength < s.endIndex && newLength >= s.endIndex
        )
        if (curSentence && curSentence.index + 1 < chineseSentences.length) {
          speakSentence(curSentence.index + 1, false)
        }
      }

      // Kiểm tra hoàn thành bài tập
      if (newLength >= currentExercise.hanzi.length) {
        handleFinish()
      }
    },
    [
      isStarted,
      currentExercise,
      preferences.normalizePunctuation,
      preferences.soundEffects,
      preferences.speakOnType,
      exerciseWordTokens,
      chineseSentences,
      speakSentence,
      handleFinish,
    ]
  )

  // Xử lý khi người dùng nhập liệu vào ô (Direct input hoặc sau khi IME gõ)
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const val = e.target.value
    // Nếu đang trong quá trình soạn thảo IME (Pinyin composition), chỉ cập nhật text hiển thị tạm
    if (isComposingRef.current) {
      setUserInput(val)
      return
    }
    handleCommittedText(val)
  }

  // Sự kiện IME Composition
  const handleCompositionStart = () => {
    isComposingRef.current = true
    setIsComposing(true)
    if (!isStarted) setIsStarted(true)
  }

  const handleCompositionUpdate = (e: React.CompositionEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setCompositionText(e.data)
  }

  const handleCompositionEnd = (e: React.CompositionEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    isComposingRef.current = false
    setIsComposing(false)
    setCompositionText('')

    // Lấy giá trị chính xác đã được xác nhận từ DOM element
    const val = (e.target as HTMLInputElement | HTMLTextAreaElement).value
    handleCommittedText(val)
  }

  // Khi người dùng click/focus vào ô gõ lần đầu, nếu câu chưa kịp đọc do trình duyệt chặn autoplay
  const handleInputFocus = useCallback(() => {
    if (typeof window === 'undefined') return
    if (window.speechSynthesis && window.speechSynthesis.paused) {
      window.speechSynthesis.resume()
    }
    if (
      preferences.autoSpeakNext &&
      currentExercise?.hanzi &&
      speechStatus === 'idle' &&
      userInput.length === 0 &&
      !isStarted &&
      lastAutoSpokenExerciseIdRef.current !== currentExercise.id
    ) {
      lastAutoSpokenExerciseIdRef.current = currentExercise.id
      readingModeRef.current = 'all'
      setReadingMode('all')
      speakSentence(
        0,
        true,
        chineseSentencesRef.current,
        exerciseWordTokensRef.current,
        currentCardEpochRef.current
      )
    }
  }, [preferences.autoSpeakNext, currentExercise, speechStatus, userInput.length, isStarted, speakSentence])

  // Chuyển thẻ/bài tập và đồng bộ phát âm chuẩn xác nội dung thẻ đích mới nhất (không đọc thẻ cũ)
  const navigateToExercise = useCallback(
    (targetIdx: number) => {
      // 1. Tăng epoch định danh phiên thẻ để hủy lập tức các tác vụ hoặc utterance cũ
      currentCardEpochRef.current++
      clearAutoSpeakTimer()
      stopSpeech()

      // 2. Reset ID đã đọc và tăng epoch để kích hoạt phát âm tự động câu mới
      lastAutoSpokenExerciseIdRef.current = null
      setExerciseEpoch((prev) => prev + 1)

      // 3. Chuyển chỉ số bài tập & reset bài
      setCurrentIndex(targetIdx)
      resetExercise()
    },
    [clearAutoSpeakTimer, stopSpeech, resetExercise]
  )

  // Chuyển sang câu kế tiếp
  const handleNext = useCallback(() => {
    if (exercises.length === 0) return
    const nextIdx = currentIndex < exercises.length - 1 ? currentIndex + 1 : 0
    navigateToExercise(nextIdx)
  }, [currentIndex, exercises.length, navigateToExercise])

  // Quay lại câu trước
  const handlePrev = useCallback(() => {
    if (exercises.length === 0) return
    const prevIdx = currentIndex > 0 ? currentIndex - 1 : exercises.length - 1
    navigateToExercise(prevIdx)
  }, [currentIndex, exercises.length, navigateToExercise])

  // Phím tắt bàn phím tiện lợi
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Khi modal đang mở thì không bắt phím tắt bài tập
      if (showHistoryModal) return

      // Enter khi đã hoàn thành -> sang câu kế tiếp
      if (e.key === 'Enter' && isCompleted && !isComposing) {
        e.preventDefault()
        handleNext()
      }
      // Alt + R -> Làm lại bài
      if (e.altKey && (e.key === 'r' || e.key === 'R')) {
        e.preventDefault()
        lastAutoSpokenExerciseIdRef.current = null
        setExerciseEpoch((prev) => prev + 1)
        resetExercise()
      }
    }

    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [isCompleted, isComposing, showHistoryModal, handleNext, resetExercise])

  // Cập nhật cài đặt
  const updatePref = (key: keyof TypingPreferences, val: boolean) => {
    const updated = { ...preferences, [key]: val }
    setPreferences(updated)
    saveTypingPreferences(updated)
  }

  // Định dạng thời gian mm:ss
  const formatTime = (secs: number) => {
    const m = Math.floor(secs / 60)
    const s = secs % 60
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
  }

  return (
    <div className="space-y-6">
      {/* 1. Header & Hướng dẫn sử dụng */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-border/80 pb-5">
        <div>
          <div className="flex items-center gap-2.5">
            <span className="p-2 rounded-xl bg-accent-soft text-app-accent flex-shrink-0">
              <Keyboard className="w-5 h-5" />
            </span>
            <h1 className="text-2xl md:text-3xl font-serif font-bold text-title tracking-tight">
              Luyện đánh máy tiếng Trung
            </h1>
          </div>
          <p className="text-muted font-serif text-sm mt-1.5 max-w-2xl">
            Rèn luyện kỹ năng gõ chữ Hán bằng Pinyin qua bộ gõ tiếng Trung (IME). Quan sát nội dung mục tiêu và tự gõ lại để cải thiện tốc độ và phản xạ.
          </p>
        </div>

        {/* Nút Lịch sử & Thống kê */}
        <div className="flex items-center gap-2">
          <button
            onClick={() => setShowHistoryModal(true)}
            className="flex items-center gap-1.5 px-3.5 py-2 bg-card border border-border rounded-xl text-xs md:text-sm font-serif text-body hover:border-app-accent/50 hover:text-app-accent transition-all shadow-xs"
          >
            <History className="w-4 h-4 text-app-accent" />
            <span>Lịch sử & Thống kê</span>
          </button>
        </div>
      </div>

      {/* 2. Thanh chọn chế độ luyện tập (4 chế độ) */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-2 bg-card border border-border rounded-xl p-1.5 shadow-xs">
        <button
          onClick={() => setMode('sentence')}
          className={`flex items-center justify-center gap-2 py-2.5 px-3 rounded-lg text-xs md:text-sm font-serif transition-all ${
            mode === 'sentence'
              ? 'bg-app-accent text-white font-semibold shadow-xs'
              : 'text-muted hover:text-title hover:bg-page'
          }`}
        >
          <FileText className="w-4 h-4" />
          <span>Câu mẫu</span>
        </button>

        <button
          onClick={() => setMode('vocabulary')}
          className={`flex items-center justify-center gap-2 py-2.5 px-3 rounded-lg text-xs md:text-sm font-serif transition-all ${
            mode === 'vocabulary'
              ? 'bg-app-accent text-white font-semibold shadow-xs'
              : 'text-muted hover:text-title hover:bg-page'
          }`}
        >
          <Sparkles className="w-4 h-4" />
          <span>Từ vựng</span>
        </button>

        <button
          onClick={() => setMode('paragraph')}
          className={`flex items-center justify-center gap-2 py-2.5 px-3 rounded-lg text-xs md:text-sm font-serif transition-all ${
            mode === 'paragraph'
              ? 'bg-app-accent text-white font-semibold shadow-xs'
              : 'text-muted hover:text-title hover:bg-page'
          }`}
        >
          <AlignLeft className="w-4 h-4" />
          <span>Đoạn văn</span>
        </button>

        <button
          onClick={() => setMode('hsk')}
          className={`flex items-center justify-center gap-2 py-2.5 px-3 rounded-lg text-xs md:text-sm font-serif transition-all ${
            mode === 'hsk'
              ? 'bg-app-accent text-white font-semibold shadow-xs'
              : 'text-muted hover:text-title hover:bg-page'
          }`}
        >
          <GraduationCap className="w-4 h-4" />
          <span>Theo HSK</span>
        </button>
      </div>

      {/* Khi ở chế độ Đoạn văn: Lựa chọn "Luyện với văn bản có sẵn" hoặc "Tự tạo bài luyện" */}
      {mode === 'paragraph' && (
        <div className="flex items-center gap-2 p-1.5 bg-card border border-border rounded-xl shadow-2xs">
          <button
            onClick={() => {
              setParagraphType('preset')
              resetExercise()
            }}
            className={`flex-1 py-2 px-3 rounded-lg text-xs md:text-sm font-serif transition-all flex items-center justify-center gap-2 ${
              paragraphType === 'preset'
                ? 'bg-title text-white font-bold shadow-2xs'
                : 'text-muted hover:text-title hover:bg-page'
            }`}
          >
            <BookOpen className="w-4 h-4" />
            <span>Luyện với văn bản có sẵn ({paragraphExercises.length} bài)</span>
          </button>
          <button
            onClick={() => {
              setParagraphType('custom')
              resetExercise()
            }}
            className={`flex-1 py-2 px-3 rounded-lg text-xs md:text-sm font-serif transition-all flex items-center justify-center gap-2 ${
              paragraphType === 'custom'
                ? 'bg-app-accent text-white font-bold shadow-2xs'
                : 'text-muted hover:text-title hover:bg-page'
            }`}
          >
            <Sparkles className="w-4 h-4" />
            <span>Tự tạo bài luyện từ văn bản cá nhân</span>
          </button>
        </div>
      )}

      {mode === 'paragraph' && paragraphType === 'custom' ? (
        <CustomParagraphMode
          onSessionComplete={() => {
            setStats(getTypingStats())
            setHistoryList(getTypingHistory())
          }}
        />
      ) : (
        <>
          {/* 3. Bộ lọc cấp độ / chủ đề & Tùy chọn hiển thị */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-card border border-border rounded-xl p-3 shadow-xs">
        {/* Bộ lọc theo chế độ */}
        <div className="flex items-center gap-2 flex-wrap">
          <span className="text-xs text-muted font-serif">Phân loại:</span>

          {mode === 'sentence' && (
            <div className="flex items-center gap-1">
              {['all', 'Cơ bản', 'Trung cấp', 'Nâng cao'].map((lvl) => (
                <button
                  key={lvl}
                  onClick={() => setLevelFilter(lvl)}
                  className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors ${
                    levelFilter === lvl
                      ? 'bg-title text-white font-medium'
                      : 'bg-page border border-border text-muted hover:text-title'
                  }`}
                >
                  {lvl === 'all' ? 'Tất cả' : lvl}
                </button>
              ))}
            </div>
          )}

          {mode === 'vocabulary' && (
            <select
              value={categoryFilter}
              onChange={(e) => setCategoryFilter(e.target.value)}
              className="bg-page border border-border rounded-lg text-xs font-serif text-title px-2.5 py-1 focus:outline-none focus:border-app-accent"
            >
              {vocabularyCategories.map((cat) => (
                <option key={cat} value={cat === 'Tất cả' ? 'all' : cat}>
                  {cat}
                </option>
              ))}
            </select>
          )}

          {mode === 'paragraph' && (
            <div className="flex items-center gap-1 flex-wrap">
              {['all', 'Sơ cấp', 'Trung cấp', 'Nâng cao'].map((lvl) => (
                <button
                  key={lvl}
                  onClick={() => {
                    setLevelFilter(lvl)
                    resetExercise()
                  }}
                  className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors ${
                    levelFilter === lvl
                      ? 'bg-title text-white font-medium'
                      : 'bg-page border border-border text-muted hover:text-title'
                  }`}
                >
                  {lvl === 'all' ? 'Tất cả (34 bài)' : lvl}
                </button>
              ))}
            </div>
          )}

          {mode === 'hsk' && (
            <div className="flex items-center gap-2 flex-wrap">
              {/* Chọn cấp HSK 1 - 6 */}
              <div className="flex items-center gap-1">
                {[1, 2, 3, 4, 5, 6].map((num) => (
                  <button
                    key={num}
                    onClick={() => {
                      setHskLevel(num)
                      setHskLesson(0)
                      resetExercise()
                    }}
                    className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors ${
                      hskLevel === num
                        ? 'bg-app-accent text-white font-semibold'
                        : 'bg-page border border-border text-muted hover:text-title'
                    }`}
                  >
                    HSK {num}
                  </button>
                ))}
              </div>

              {/* Nút toggle: Luyện từ vựng vs Luyện câu ví dụ */}
              <div className="flex items-center bg-page border border-border rounded-lg p-0.5">
                <button
                  onClick={() => {
                    setHskTarget('word')
                    resetExercise()
                  }}
                  className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors ${
                    hskTarget === 'word'
                      ? 'bg-title text-white font-medium shadow-2xs'
                      : 'text-muted hover:text-title'
                  }`}
                >
                  Luyện từ vựng
                </button>
                <button
                  onClick={() => {
                    setHskTarget('example')
                    resetExercise()
                  }}
                  className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors ${
                    hskTarget === 'example'
                      ? 'bg-app-accent text-white font-medium shadow-2xs'
                      : 'text-muted hover:text-title'
                  }`}
                >
                  Luyện câu ví dụ
                </button>
              </div>

              {/* Chọn bài học trong cấp HSK */}
              {availableLessons.length > 0 && (
                <select
                  value={hskLesson}
                  onChange={(e) => {
                    setHskLesson(Number(e.target.value))
                    resetExercise()
                  }}
                  className="bg-page border border-border rounded-lg text-xs font-serif text-title px-2.5 py-1 focus:outline-none focus:border-app-accent"
                >
                  <option value={0}>Tất cả bài học</option>
                  {availableLessons.map((lNum) => (
                    <option key={lNum} value={lNum}>
                      Bài {lNum}
                    </option>
                  ))}
                </select>
              )}
            </div>
          )}
        </div>

        {/* Các nút bật/tắt gợi ý (Pinyin, Nghĩa, Ẩn chữ Hán) */}
        <div className="flex items-center gap-1.5 flex-wrap">
          <button
            onClick={() => updatePref('showPinyin', !preferences.showPinyin)}
            className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors border ${
              preferences.showPinyin
                ? 'bg-accent-soft/70 border-app-accent/40 text-app-accent font-medium'
                : 'bg-page border-border text-muted'
            }`}
            title="Bật / Tắt hiển thị Pinyin"
          >
            Pinyin
          </button>

          <button
            onClick={() => updatePref('showMeaning', !preferences.showMeaning)}
            className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors border ${
              preferences.showMeaning
                ? 'bg-accent-soft/70 border-app-accent/40 text-app-accent font-medium'
                : 'bg-page border-border text-muted'
            }`}
            title="Bật / Tắt hiển thị Nghĩa tiếng Việt"
          >
            Nghĩa
          </button>

          <button
            onClick={() => updatePref('hideHanzi', !preferences.hideHanzi)}
            className={`flex items-center gap-1 px-2.5 py-1 rounded-md text-xs font-serif transition-colors border ${
              preferences.hideHanzi
                ? 'bg-title text-white border-title font-medium'
                : 'bg-page border-border text-muted'
            }`}
            title="Ẩn chữ Hán mẫu để thử thách trí nhớ (gõ theo Pinyin/Nghĩa)"
          >
            {preferences.hideHanzi ? <EyeOff className="w-3 h-3" /> : <Eye className="w-3 h-3" />}
            <span>Ẩn chữ Hán</span>
          </button>

          <button
            onClick={() => updatePref('soundEffects', !preferences.soundEffects)}
            className={`p-1.5 rounded-md text-xs transition-colors border ${
              preferences.soundEffects
                ? 'bg-page border-border text-muted hover:text-title'
                : 'bg-page border-border text-muted/50'
            }`}
            title={preferences.soundEffects ? 'Tắt âm thanh' : 'Bật âm thanh'}
          >
            {preferences.soundEffects ? <Volume2 className="w-3.5 h-3.5" /> : <VolumeX className="w-3.5 h-3.5" />}
          </button>
        </div>
      </div>

      {/* 4. Khung chỉ số thời gian thực (Live Dashboard) */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <div className="bg-card border border-border rounded-xl p-3 shadow-xs flex items-center gap-3">
          <span className="p-2 rounded-lg bg-page border border-border text-muted">
            <Clock className="w-4 h-4" />
          </span>
          <div>
            <p className="text-[11px] text-muted font-sans">Thời gian</p>
            <p className="text-lg font-serif font-bold text-title">{formatTime(elapsedSeconds)}</p>
          </div>
        </div>

        <div className="bg-card border border-border rounded-xl p-3 shadow-xs flex items-center gap-3">
          <span className="p-2 rounded-lg bg-accent-soft text-app-accent">
            <Zap className="w-4 h-4" />
          </span>
          <div>
            <p className="text-[11px] text-muted font-sans">Tốc độ (CPM)</p>
            <p className="text-lg font-serif font-bold text-title">{evaluation.cpm}</p>
          </div>
        </div>

        <div className="bg-card border border-border rounded-xl p-3 shadow-xs flex items-center gap-3">
          <span className="p-2 rounded-lg bg-jade-soft text-jade">
            <Target className="w-4 h-4" />
          </span>
          <div>
            <p className="text-[11px] text-muted font-sans">Độ chính xác</p>
            <p className="text-lg font-serif font-bold text-title">{evaluation.accuracy}%</p>
          </div>
        </div>

        <div className="bg-card border border-border rounded-xl p-3 shadow-xs flex items-center gap-3">
          <span className="p-2 rounded-lg bg-gold-soft text-gold">
            <Layers className="w-4 h-4" />
          </span>
          <div>
            <p className="text-[11px] text-muted font-sans">Tiến độ bài</p>
            <p className="text-lg font-serif font-bold text-title">
              {exercises.length > 0 ? currentIndex + 1 : 0} / {exercises.length}
            </p>
          </div>
        </div>
      </div>

      {/* 5. VÙNG HIỂN THỊ CÂU MỤC TIÊU VÀ TÔ MÀU KÝ TỰ REAL-TIME */}
      {currentExercise ? (
        <div className="space-y-4">
          {/* Thanh điều khiển âm thanh toàn diện (Nghe toàn bài, Nghe câu, Tốc độ, Giọng đọc, Âm gõ, Tự động đọc) */}
          <TypingAudioControls
            sentences={chineseSentences}
            currentSentenceIndex={currentTypingSentenceIndex}
            speakingSentenceIndex={speakingSentenceIndex}
            speechStatus={speechStatus}
            readingMode={readingMode}
            speechRate={speechRate}
            onRateChange={handleRateChange}
            onPlayAll={handlePlayAll}
            onPlayCurrentSentence={handlePlayCurrentSentence}
            onPause={handlePauseSpeech}
            onResume={handleResumeSpeech}
            onStop={stopSpeech}
            selectedVoiceURI={selectedVoiceURI}
            onVoiceChange={handleVoiceChange}
            availableVoices={availableVoices}
            hasVoiceWarning={hasVoiceWarning}
            typingSoundEnabled={preferences.soundEffects}
            onToggleTypingSound={handleToggleTypingSound}
            autoSpeakNext={preferences.autoSpeakNext || false}
            onToggleAutoSpeakNext={handleToggleAutoSpeakNext}
          />

          <div className="bg-card border border-border rounded-2xl p-5 md:p-8 shadow-sm space-y-6">
            {/* Huy hiệu thông tin câu & Nút nghe phát âm tiếng Trung */}
            <div className="flex items-center justify-between gap-3 text-xs text-muted font-serif flex-wrap">
              <div className="flex items-center gap-2">
                <span className="px-2 py-0.5 rounded bg-page border border-border font-medium text-title">
                  {currentExercise.level || `HSK ${currentExercise.hskLevel || 1}`}
                </span>
                {currentExercise.category && (
                  <span className="text-muted">• {currentExercise.category}</span>
                )}
              </div>

              <div className="flex items-center gap-3 flex-wrap">
                <AudioButton 
                  text={currentExercise.hanzi} 
                  id={`typing-ex-${currentExercise.id || currentIndex}`} 
                  size="sm" 
                  variant="subtle" 
                  showLabel 
                  label="Nghe đọc mẫu" 
                  tooltip="Nghe phát âm chuẩn Mandarin" 
                />

                <span>{currentExercise.hanzi.length} ký tự</span>
                {isStarted && !isCompleted && (
                  <span className="inline-flex items-center gap-1 text-app-accent font-medium animate-pulse">
                    <span className="w-1.5 h-1.5 rounded-full bg-app-accent" />
                    Đang tính giờ
                  </span>
                )}
              </div>
            </div>

            {/* Tiêu đề bài tập song ngữ nếu có (cho đoạn văn hoặc câu HSK) */}
            {(currentExercise.titleZh || currentExercise.titleVi) && (
              <div className="border-b border-border/70 pb-3.5 -mt-1">
                {currentExercise.titleZh && (
                  <h2 className="text-base md:text-lg font-serif font-bold text-title flex items-center gap-2">
                    <BookOpen className="w-4 h-4 text-app-accent flex-shrink-0" />
                    <span>{currentExercise.titleZh}</span>
                  </h2>
                )}
                {currentExercise.titleVi && (
                  <p className="text-xs md:text-sm text-muted font-serif mt-1">
                    {currentExercise.titleVi}
                  </p>
                )}
              </div>
            )}

            {/* Câu mục tiêu với từng ký tự hiển thị trực quan */}
            <div className="space-y-3 bg-page/70 border border-border/70 rounded-xl p-4 md:p-6">
              {/* Pinyin hỗ trợ kèm đồng bộ highlight từng từ khi phát âm */}
              {preferences.showPinyin && (
                <div className="flex items-center justify-between gap-2">
                  {exerciseWordTokens.length > 0 && exerciseWordTokens.some((w) => w.pinyin) ? (
                    <div className="flex flex-wrap items-baseline gap-x-1.5 gap-y-0.5 select-none leading-relaxed text-sm md:text-base font-sans">
                      {exerciseWordTokens.map((w, wIdx) => {
                        const isWordActive = speakingWordIndex === wIdx && w.isWord
                        const isWordPast = speakingWordIndex !== null && wIdx < speakingWordIndex && w.isWord

                        if (!w.pinyin) return null

                        return (
                          <span
                            key={wIdx}
                            className={`transition-colors duration-150 rounded px-1 ${
                              isWordActive
                                ? 'text-amber-950 dark:text-amber-100 font-bold bg-amber-200/80 dark:bg-amber-900/60 ring-1 ring-amber-400/80 shadow-2xs'
                                : isWordPast
                                ? 'text-muted/60'
                                : 'text-muted font-medium'
                            }`}
                          >
                            {w.pinyin}
                          </span>
                        )
                      })}
                    </div>
                  ) : (
                    <p className="text-sm md:text-base text-muted font-sans tracking-wide select-none">
                      {currentExercise.pinyin}
                    </p>
                  )}
                  <AudioButton 
                    text={currentExercise.hanzi} 
                    id={`typing-inline-${currentExercise.id || currentIndex}`} 
                    size="xs" 
                    variant="ghost" 
                    tooltip="Nghe phát âm tiếng Trung" 
                  />
                </div>
              )}

              {/* Dòng chữ Hán mục tiêu với tô màu realtime & highlight âm thanh theo từ */}
              <div
                className={`font-serif tracking-normal leading-relaxed select-none ${
                  mode === 'paragraph' ? 'text-xl md:text-2xl' : 'text-2xl md:text-4xl'
                }`}
                style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
              >
                {preferences.hideHanzi && !isCompleted ? (
                  <div className="text-muted/60 italic text-base md:text-lg flex items-center gap-2 py-2">
                    <EyeOff className="w-5 h-5 text-muted" />
                    <span>Chữ Hán đang bị ẩn để thử thách. Hãy dựa vào Pinyin và Nghĩa để gõ!</span>
                  </div>
                ) : exerciseWordTokens.length > 0 ? (
                  <div className="flex flex-wrap items-baseline gap-y-1">
                    {exerciseWordTokens.map((w, wIdx) => {
                      const isWordActive = speakingWordIndex === wIdx && w.isWord
                      const isWordPast = speakingWordIndex !== null && wIdx < speakingWordIndex && w.isWord

                      return (
                        <span
                          key={wIdx}
                          ref={(el) => {
                            if (el) wordElementsRef.current.set(`word-${wIdx}`, el)
                            else wordElementsRef.current.delete(`word-${wIdx}`)
                          }}
                          className={`inline-block transition-all duration-150 rounded px-0.5 py-0.25 ${
                            isWordActive
                              ? 'bg-amber-100 dark:bg-amber-950/70 ring-2 ring-amber-400/80 text-amber-950 dark:text-amber-100 font-bold shadow-xs'
                              : isWordPast
                              ? 'opacity-85'
                              : ''
                          }`}
                        >
                          {w.text.split('').map((char, cOffset) => {
                            const idx = w.startIndex + cOffset
                            const typedChar = userInput[idx]
                            const isCurrent = idx === userInput.length && !isCompleted

                            // Kiểm tra xem ký tự này có thuộc câu đang phát âm TTS hay không
                            const activeSentence =
                              speakingSentenceIndex !== null && chineseSentences[speakingSentenceIndex]
                                ? chineseSentences[speakingSentenceIndex]
                                : null
                            const isCharBeingSpoken = activeSentence
                              ? idx >= activeSentence.startIndex && idx < activeSentence.endIndex
                              : false

                            let statusClasses = 'text-title/80'

                            if (idx < userInput.length) {
                              if (isCharMatch(typedChar, char, preferences.normalizePunctuation)) {
                                // Ký tự đúng: Xanh lá cây
                                statusClasses = 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 rounded px-0.5'
                              } else {
                                // Ký tự sai: Đỏ gạch chân
                                statusClasses = 'bg-red-500/20 text-red-600 dark:text-red-400 rounded px-0.5 underline decoration-red-500 font-bold'
                              }
                            } else if (isCurrent) {
                              // Ký tự con trỏ đang chờ gõ
                              statusClasses = 'border-b-2 border-app-accent bg-accent-soft/40 text-title font-bold animate-pulse'
                            } else if (isWordActive) {
                              // Từ đang được đọc TTS: Highlight từ nổi bật ấm áp
                              statusClasses = 'text-amber-950 dark:text-amber-100 font-bold'
                            } else if (isCharBeingSpoken) {
                              // Ký tự thuộc câu đang đọc
                              statusClasses = 'text-title/85'
                            }

                            return (
                              <span key={idx} className={`inline-block transition-colors ${statusClasses}`}>
                                {char}
                              </span>
                            )
                          })}
                        </span>
                      )
                    })}
                  </div>
                ) : (
                  currentExercise.hanzi.split('').map((char, idx) => {
                    const typedChar = userInput[idx]
                    const isCurrent = idx === userInput.length && !isCompleted

                    // Kiểm tra xem ký tự này có thuộc câu đang phát âm TTS hay không
                    const activeSentence =
                      speakingSentenceIndex !== null && chineseSentences[speakingSentenceIndex]
                        ? chineseSentences[speakingSentenceIndex]
                        : null
                    const isCharBeingSpoken = activeSentence
                      ? idx >= activeSentence.startIndex && idx < activeSentence.endIndex
                      : false

                    let statusClasses = 'text-title/80'

                    if (idx < userInput.length) {
                      if (isCharMatch(typedChar, char, preferences.normalizePunctuation)) {
                        // Ký tự đúng: Xanh lá cây
                        statusClasses = 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 rounded px-0.5'
                      } else {
                        // Ký tự sai: Đỏ gạch chân
                        statusClasses = 'bg-red-500/20 text-red-600 dark:text-red-400 rounded px-0.5 underline decoration-red-500 font-bold'
                      }
                    } else if (isCurrent) {
                      // Ký tự con trỏ đang chờ gõ
                      statusClasses = 'border-b-2 border-app-accent bg-accent-soft/40 text-title font-bold animate-pulse'
                    } else if (isCharBeingSpoken) {
                      // Ký tự đang được đọc TTS: Highlight nổi bật đồng bộ
                      statusClasses = 'bg-app-accent-soft/70 text-app-accent font-bold rounded px-0.5 ring-1 ring-app-accent/40'
                    }

                    return (
                      <span key={idx} className={`inline-block transition-colors ${statusClasses}`}>
                        {char}
                      </span>
                    )
                  })
                )}
              </div>

            {/* Nghĩa tiếng Việt hỗ trợ */}
            {preferences.showMeaning && (
              <p className="text-xs md:text-sm text-body/90 font-serif italic pt-1 border-t border-border/50">
                Ý nghĩa: {currentExercise.meaning}
              </p>
            )}
          </div>

          {/* Ô nhập liệu IME tiếng Trung */}
          <div className="space-y-2">
            <div className="relative">
              {mode === 'paragraph' ? (
                <textarea
                  ref={inputRef as React.RefObject<HTMLTextAreaElement>}
                  value={userInput}
                  onChange={handleInputChange}
                  onFocus={handleInputFocus}
                  onCompositionStart={handleCompositionStart}
                  onCompositionUpdate={handleCompositionUpdate}
                  onCompositionEnd={handleCompositionEnd}
                  disabled={isCompleted}
                  rows={3}
                  placeholder={
                    isCompleted
                      ? 'Đã hoàn thành câu này. Bấm "Câu tiếp theo" hoặc phím Enter để tiếp tục.'
                      : 'Bật bộ gõ tiếng Trung (Pinyin), gõ pinyin rồi chọn chữ Hán tương ứng...'
                  }
                  className="w-full p-4 bg-card border-2 border-border focus:border-app-accent rounded-xl text-lg md:text-xl font-serif text-title placeholder:text-muted placeholder:text-sm focus:outline-none transition-colors shadow-inner resize-none"
                  style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                />
              ) : (
                <input
                  ref={inputRef as React.RefObject<HTMLInputElement>}
                  type="text"
                  value={userInput}
                  onChange={handleInputChange}
                  onFocus={handleInputFocus}
                  onCompositionStart={handleCompositionStart}
                  onCompositionUpdate={handleCompositionUpdate}
                  onCompositionEnd={handleCompositionEnd}
                  disabled={isCompleted}
                  autoComplete="off"
                  autoCorrect="off"
                  autoCapitalize="off"
                  spellCheck="false"
                  placeholder={
                    isCompleted
                      ? 'Đã hoàn thành! Bấm Enter hoặc nút "Câu tiếp theo" để tiếp tục.'
                      : 'Bật bộ gõ tiếng Trung (Pinyin), gõ pinyin rồi chọn chữ Hán tương ứng...'
                  }
                  className="w-full px-4 py-3.5 bg-card border-2 border-border focus:border-app-accent rounded-xl text-lg md:text-2xl font-serif text-title placeholder:text-muted placeholder:text-sm focus:outline-none transition-colors shadow-inner"
                  style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                />
              )}

              {/* Chỉ báo trạng thái IME Composition đang xử lý */}
              {isComposing && (
                <div className="absolute right-3 top-3 px-2 py-1 bg-amber-500/15 border border-amber-400/30 text-amber-700 dark:text-amber-400 rounded-md text-xs font-sans flex items-center gap-1.5 animate-pulse">
                  <span className="w-1.5 h-1.5 rounded-full bg-amber-500" />
                  <span>Đang chọn chữ IME ({compositionText || 'pinyin'})...</span>
                </div>
              )}
            </div>

            <div className="flex items-center justify-between text-xs text-muted font-serif px-1">
              <span>
                Đã gõ: <strong className="text-title">{userInput.length}</strong> / {currentExercise.hanzi.length} ký tự
              </span>
              <span className="hidden sm:inline text-muted/80">
                Phím tắt: <kbd className="px-1.5 py-0.5 rounded bg-page border border-border">Enter</kbd> để tiếp tục • <kbd className="px-1.5 py-0.5 rounded bg-page border border-border">Alt + R</kbd> làm lại
              </span>
            </div>
          </div>

          {/* 6. BẢNG TỔNG KẾT SAU KHI HOÀN THÀNH BÀI */}
          {isCompleted && (
            <div className="p-5 md:p-6 bg-page border-2 border-app-accent/30 rounded-2xl space-y-4 animate-in fade-in duration-300">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-border pb-4">
                <div className="flex items-center gap-3">
                  <div className="p-2.5 rounded-xl bg-app-accent text-white">
                    <Award className="w-6 h-6" />
                  </div>
                  <div>
                    <h3 className="text-lg font-serif font-bold text-title">
                      {evaluation.accuracy === 100
                        ? 'Xuất sắc! Gõ chính xác tuyệt đối!'
                        : evaluation.accuracy >= 90
                        ? 'Rất tốt! Tốc độ và phản xạ ổn định!'
                        : evaluation.accuracy >= 70
                        ? 'Khá tốt! Hãy tiếp tục luyện tập!'
                        : 'Hoàn thành bài! Hãy chú ý các lỗi sai bên dưới.'}
                    </h3>
                    <p className="text-xs text-muted font-sans">
                      Thời gian: {elapsedSeconds}s • Tốc độ: {evaluation.cpm} CPM • Độ chính xác: {evaluation.accuracy}%
                    </p>
                  </div>
                </div>

                <div className="flex items-center gap-2">
                  <button
                    onClick={resetExercise}
                    className="flex items-center gap-1.5 px-3.5 py-2 bg-card border border-border hover:border-app-accent rounded-xl text-xs md:text-sm font-serif text-body transition-all"
                  >
                    <RotateCcw className="w-4 h-4" />
                    <span>Làm lại</span>
                  </button>
                  <button
                    onClick={handleNext}
                    className="flex items-center gap-1.5 px-4 py-2 bg-app-accent hover:bg-accent-hover text-white rounded-xl text-xs md:text-sm font-serif font-medium transition-all shadow-xs"
                  >
                    <span>Câu tiếp theo</span>
                    <ArrowRight className="w-4 h-4" />
                  </button>
                </div>
              </div>

              {/* Chi tiết vị trí sai nếu có */}
              {evaluation.errors.length > 0 ? (
                <div className="space-y-2">
                  <p className="text-xs font-serif font-semibold text-red-600 dark:text-red-400 flex items-center gap-1.5">
                    <XCircle className="w-4 h-4" />
                    <span>Các vị trí cần rút kinh nghiệm ({evaluation.errors.length} lỗi):</span>
                  </p>
                  <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2 text-xs font-serif">
                    {evaluation.errors.slice(0, 6).map((err, i) => (
                      <div key={i} className="p-2 rounded-lg bg-card border border-border/80 flex items-center justify-between">
                        <span className="text-muted">Ký tự {err.index}:</span>
                        <div className="flex items-center gap-1.5">
                          <span className="text-red-500 font-bold line-through">{err.actual}</span>
                          <span className="text-muted">→</span>
                          <span className="text-emerald-600 font-bold">{err.expected}</span>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              ) : (
                <div className="flex items-center gap-2 text-emerald-600 dark:text-emerald-400 text-xs font-serif">
                  <CheckCircle2 className="w-4 h-4" />
                  <span>Bạn đã chọn chính xác toàn bộ chữ Hán từ bộ gõ Pinyin!</span>
                </div>
              )}
            </div>
          )}

          {/* Các nút hành động điều hướng */}
          <div className="flex items-center justify-between pt-2">
            <button
              onClick={handlePrev}
              className="flex items-center gap-1.5 px-3 py-2 text-xs md:text-sm text-muted hover:text-title font-serif transition-colors"
            >
              <ArrowLeft className="w-4 h-4" />
              <span>Câu trước</span>
            </button>

            <div className="flex items-center gap-2">
              <button
                onClick={resetExercise}
                className="flex items-center gap-1.5 px-3.5 py-2 bg-page border border-border hover:border-app-accent/50 rounded-xl text-xs md:text-sm font-serif text-muted hover:text-title transition-all"
                title="Làm lại từ đầu"
              >
                <RotateCcw className="w-4 h-4" />
                <span className="hidden sm:inline">Làm lại</span>
              </button>

              {!isCompleted && (
                <button
                  onClick={handleFinish}
                  disabled={userInput.length === 0}
                  className="flex items-center gap-1.5 px-4 py-2 bg-title text-white hover:opacity-90 disabled:opacity-50 rounded-xl text-xs md:text-sm font-serif transition-all"
                >
                  <CheckCircle2 className="w-4 h-4" />
                  <span>Kiểm tra</span>
                </button>
              )}

              <button
                onClick={handleNext}
                className="flex items-center gap-1.5 px-4 py-2 bg-app-accent hover:bg-accent-hover text-white rounded-xl text-xs md:text-sm font-serif transition-all shadow-xs"
              >
                <span>Chuyển câu</span>
                <ArrowRight className="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>
      </div>
      ) : (
        <div className="p-12 text-center bg-card border border-border rounded-xl space-y-3">
          <BookOpen className="w-10 h-10 text-muted mx-auto" />
          <h3 className="text-base font-serif font-medium text-title">Chưa có bài tập cho mục này</h3>
          <p className="text-xs text-muted font-serif">Vui lòng chọn phân loại hoặc chế độ khác.</p>
        </div>
      )}
      </>
      )}

      {/* 7. MODAL LỊCH SỬ LUYỆN TẬP & THỐNG KÊ */}
      {showHistoryModal && (
        <div className="fixed inset-0 z-50 bg-black/50 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-card border border-border rounded-2xl w-full max-w-2xl max-h-[85vh] flex flex-col shadow-xl overflow-hidden animate-in fade-in zoom-in-95 duration-200">
            {/* Modal Header */}
            <div className="p-5 border-b border-border flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <span className="p-2 rounded-xl bg-accent-soft text-app-accent">
                  <History className="w-5 h-5" />
                </span>
                <div>
                  <h3 className="font-serif font-bold text-lg text-title">Lịch sử & Thống kê luyện gõ</h3>
                  <p className="text-xs text-muted font-sans">Tiến độ và tốc độ đánh máy lưu cục bộ trên thiết bị</p>
                </div>
              </div>
              <button
                onClick={() => setShowHistoryModal(false)}
                className="p-1.5 rounded-lg text-muted hover:text-title hover:bg-page transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* Modal Body: Thống kê tổng quan & Danh sách */}
            <div className="p-5 overflow-y-auto space-y-6">
              {/* Thống kê 4 ô */}
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
                <div className="p-3 bg-page rounded-xl border border-border text-center">
                  <p className="text-[11px] text-muted font-sans">Tổng bài đã gõ</p>
                  <p className="text-xl font-serif font-bold text-title mt-0.5">{stats?.totalSessions || 0}</p>
                </div>
                <div className="p-3 bg-page rounded-xl border border-border text-center">
                  <p className="text-[11px] text-muted font-sans">Kỷ lục CPM</p>
                  <p className="text-xl font-serif font-bold text-app-accent mt-0.5">{stats?.bestCPM || 0}</p>
                </div>
                <div className="p-3 bg-page rounded-xl border border-border text-center">
                  <p className="text-[11px] text-muted font-sans">Độ chính xác TB</p>
                  <p className="text-xl font-serif font-bold text-jade mt-0.5">{stats?.averageAccuracy || 100}%</p>
                </div>
                <div className="p-3 bg-page rounded-xl border border-border text-center">
                  <p className="text-[11px] text-muted font-sans">Tổng ký tự</p>
                  <p className="text-xl font-serif font-bold text-title mt-0.5">{stats?.totalCharactersTyped || 0}</p>
                </div>
              </div>

              {/* Danh sách các lần luyện tập gần nhất */}
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <h4 className="font-serif font-semibold text-sm text-title">Các lần luyện tập gần đây</h4>
                  {historyList.length > 0 && (
                    <button
                      onClick={() => {
                        if (confirm('Bạn có chắc chắn muốn xóa toàn bộ lịch sử luyện gõ?')) {
                          clearTypingHistory()
                          setHistoryList([])
                          setStats(getTypingStats())
                        }
                      }}
                      className="text-xs text-muted hover:text-red-500 font-serif underline transition-colors"
                    >
                      Xóa lịch sử
                    </button>
                  )}
                </div>

                {historyList.length > 0 ? (
                  <div className="space-y-2 max-h-64 overflow-y-auto pr-1">
                    {historyList.map((item) => (
                      <div
                        key={item.id}
                        className="p-3 bg-page rounded-xl border border-border flex items-center justify-between text-xs font-serif"
                      >
                        <div className="space-y-0.5">
                          <div className="flex items-center gap-2">
                            <span className="font-medium text-title capitalize">
                              {item.mode === 'sentence'
                                ? 'Câu mẫu'
                                : item.mode === 'vocabulary'
                                ? 'Từ vựng'
                                : item.mode === 'paragraph'
                                ? 'Đoạn văn'
                                : 'HSK'}
                            </span>
                            <span className="text-[10px] px-1.5 py-0.2 rounded bg-card border border-border text-muted">
                              {item.level}
                            </span>
                          </div>
                          <p className="text-[11px] text-muted">
                            {new Date(item.date).toLocaleDateString('vi-VN')} {new Date(item.date).toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' })} • {item.timeSeconds}s
                          </p>
                        </div>

                        <div className="text-right">
                          <p className="font-bold text-title">{item.cpm} CPM</p>
                          <p className="text-[11px] text-jade font-medium">{item.accuracy}% chính xác</p>
                        </div>
                      </div>
                    ))}
                  </div>
                ) : (
                  <p className="text-center py-8 text-xs text-muted font-serif bg-page rounded-xl border border-border">
                    Chưa có lượt luyện tập nào. Hãy bắt đầu gõ câu đầu tiên của bạn!
                  </p>
                )}
              </div>
            </div>

            {/* Modal Footer */}
            <div className="p-4 border-t border-border bg-page/50 flex justify-end">
              <button
                onClick={() => setShowHistoryModal(false)}
                className="px-4 py-2 bg-title text-white rounded-xl text-xs md:text-sm font-serif hover:opacity-90 transition-all"
              >
                Đóng
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
