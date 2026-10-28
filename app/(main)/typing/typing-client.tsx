'use client'

import { useState, useEffect, useRef, useMemo, useCallback } from 'react'
import {
  TypingMode,
  TypingExercise,
  getExercisesByMode,
  paragraphExercises,
  getHskLessonNumbers,
  VIETNAMESE_PROVERB_CATEGORIES,
} from '@/data/typing-lessons'
import CustomParagraphMode from './components/custom-paragraph-mode'
import TranslateTypingMode from './components/translate-typing-mode'
import TypingAudioControls from './components/typing-audio-controls'
import { AudioButton } from '@/components/ui/audio-button'
import { PassageAudioPlayer } from '@/components/ui/passage-audio-player'
import {
  ttsEngine,
  retainUtterance,
  releaseUtterance,
  setSentenceTTSActive,
} from '@/lib/tts/tts-engine'
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
  getLocalTypingProgress,
  saveLocalTypingProgress,
  resetLocalTypingProgress,
  recordLocalTypingMistake,
  getLocalTypingMistakes,
  getAllLocalTypingDataForSync,
  clearSyncedLocalData,
  saveLocalTypingDraft,
  getLocalTypingDraft,
  clearLocalTypingDraft,
} from '@/lib/typing-storage'
import {
  getTypingProgressAction,
  saveTypingProgressAction,
  recordTypingMistakeAction,
  resetTypingProgressAction,
  syncLocalTypingDataAction,
  getTypingMistakesAction,
  getHskTypingExercisesAction,
  getSystemLessonsForTypingAction,
  getTypingExercisesFromDBAction,
  TypingProgressDTO,
} from './actions'
import { useSearchParams } from 'next/navigation'
import { useAuthModal } from '@/components/auth/auth-modal-context'
import TypingResumeBanner from './components/typing-resume-banner'
import TypingMistakesReview from './components/typing-mistakes-review'
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
  X,
  Volume2,
  VolumeX,
  GraduationCap,
  Layers,
  FileText,
  AlignLeft,
  Flame,
  Headphones,
  PenTool,
  Loader2,
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
  const { user, isLoggedIn } = useAuthModal()

  // Chế độ & Tab điều hướng
  const [activeTab, setActiveTab] = useState<'practice' | 'mistakes'>('practice')
  const [mistakeCount, setMistakeCount] = useState<number>(0)
  const [savedProgress, setSavedProgress] = useState<TypingProgressDTO | null>(null)
  const [showResumeBanner, setShowResumeBanner] = useState<boolean>(false)
  const [showImeGuide, setShowImeGuide] = useState<boolean>(true)

  const searchParams = useSearchParams()
  const urlMode = searchParams.get('mode') as TypingMode | null
  const urlPractice = searchParams.get('practice')
  const urlHskLevel = searchParams.get('hskLevel')
  const urlLessonId = searchParams.get('lessonId')
  const urlPracticeType = searchParams.get('practiceType')

  const [practiceMode, setPracticeMode] = useState<'visual' | 'translate'>(() => {
    if (urlPractice === 'translate' || urlMode === ('translate' as any)) return 'translate'
    return 'visual'
  })

  const [mode, setMode] = useState<TypingMode>(() => {
    if (urlMode && ['sentence', 'paragraph', 'hsk', 'vocabulary'].includes(urlMode)) {
      return urlMode
    }
    if (urlLessonId) return 'hsk'
    return 'sentence'
  })
  const [paragraphType, setParagraphType] = useState<'preset' | 'custom'>('preset')
  const [levelFilter, setLevelFilter] = useState<string>('all')
  const [categoryFilter, setCategoryFilter] = useState<string>('all')
  const [hskLevel, setHskLevel] = useState<number>(() => {
    if (urlHskLevel) {
      const parsed = parseInt(urlHskLevel, 10)
      if (parsed >= 1 && parsed <= 6) return parsed
    }
    return 1
  })
  const [selectedLessonId, setSelectedLessonId] = useState<string>(() => urlLessonId || '')
  const [hskLesson, setHskLesson] = useState<number>(0)
  const [hskTarget, setHskTarget] = useState<'word' | 'example'>('example')
  const [onlyUnlearnedFilter, setOnlyUnlearnedFilter] = useState<boolean>(false)
  const [systemLessons, setSystemLessons] = useState<
    { id: string; lessonNumber: number; title: string; subtitle: string; hskLevel: number }[]
  >([])
  const [loadingLessons, setLoadingLessons] = useState<boolean>(false)
  const [loadingExercises, setLoadingExercises] = useState<boolean>(false)

  // Đồng bộ searchParams từ URL nếu có thay đổi điều hướng
  useEffect(() => {
    if (urlPractice === 'translate' || urlMode === ('translate' as any)) {
      setPracticeMode('translate')
    } else if (urlPractice === 'visual') {
      setPracticeMode('visual')
    }
    if (urlMode && ['sentence', 'paragraph', 'hsk', 'vocabulary'].includes(urlMode)) {
      setMode(urlMode)
    }
    if (urlHskLevel) {
      const parsed = parseInt(urlHskLevel, 10)
      if (parsed >= 1 && parsed <= 6) setHskLevel(parsed)
    }
    if (urlLessonId !== null && urlLessonId !== undefined) {
      setSelectedLessonId(urlLessonId)
    }
    // Tương thích ngược: Nếu URL cũ có ?practiceType=dictation, tự động kích hoạt ẩn chữ Hán
    if (urlPracticeType === 'dictation') {
      setPreferences((prev) => ({ ...prev, hideHanzi: true }))
    }
  }, [urlPractice, urlMode, urlHskLevel, urlLessonId, urlPracticeType])

  // Danh sách các bài học có trong cấp HSK hiện tại (fallback tĩnh)
  const availableLessons = useMemo(() => {
    return getHskLessonNumbers(hskLevel)
  }, [hskLevel])

  // Tải danh sách bài học thực tế từ database cho cấp độ HSK đang chọn
  useEffect(() => {
    if (mode !== 'hsk') return
    let isCancelled = false
    setLoadingLessons(true)

    getSystemLessonsForTypingAction(hskLevel)
      .then((res) => {
        if (isCancelled) return
        setLoadingLessons(false)
        if (res.success && res.data) {
          setSystemLessons(res.data)
        }
      })
      .catch((err) => {
        if (!isCancelled) setLoadingLessons(false)
        console.error('Failed to load system lessons for typing:', err)
      })

    return () => {
      isCancelled = true
    }
  }, [mode, hskLevel])

  // Dữ liệu bài tập HSK tải trực tiếp từ database (vocabulary_examples + vocabularies)
  const [hskDynamicExercises, setHskDynamicExercises] = useState<TypingExercise[]>([])

  useEffect(() => {
    if (mode !== 'hsk') return
    let isCancelled = false
    setLoadingExercises(true)

    getTypingExercisesFromDBAction({
      hskLevel,
      lessonId: selectedLessonId || undefined,
      onlyUnlearned: onlyUnlearnedFilter,
      limit: 100,
    })
      .then((res) => {
        if (isCancelled) return
        setLoadingExercises(false)
        if (res.success && res.data && res.data.length > 0) {
          setHskDynamicExercises(res.data as unknown as TypingExercise[])
        } else {
          // Fallback legacy action nếu DB chưa có câu ví dụ
          getHskTypingExercisesAction(hskLevel, hskLesson, hskTarget).then((legacyRes) => {
            if (isCancelled) return
            if (legacyRes.success && legacyRes.data) {
              setHskDynamicExercises(legacyRes.data as TypingExercise[])
            }
          })
        }
      })
      .catch((err) => {
        if (!isCancelled) setLoadingExercises(false)
        console.error('Failed to load HSK exercises from DB:', err)
      })

    return () => {
      isCancelled = true
    }
  }, [mode, hskLevel, selectedLessonId, onlyUnlearnedFilter, hskLesson, hskTarget])

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
  const [audioSentenceIndex, setAudioSentenceIndex] = useState<number>(0)
  const [isAudioFinished, setIsAudioFinished] = useState<boolean>(false)
  const audioSentenceIndexRef = useRef<number>(0)
  useEffect(() => {
    audioSentenceIndexRef.current = audioSentenceIndex
  }, [audioSentenceIndex])
  const utteranceIdRef = useRef<number>(0)
  const activeUtteranceRef = useRef<SpeechSynthesisUtterance | null>(null)
  const keepAliveIntervalRef = useRef<NodeJS.Timeout | null>(null)
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

  // Cơ chế KeepAlive cho trình duyệt Chromium (ngăn ngắt âm thanh sau 15 giây)
  const clearKeepAlive = useCallback(() => {
    if (keepAliveIntervalRef.current) {
      clearInterval(keepAliveIntervalRef.current)
      keepAliveIntervalRef.current = null
    }
  }, [])

  const startKeepAlive = useCallback(() => {
    clearKeepAlive()
    if (typeof window === 'undefined' || !window.speechSynthesis) return
    keepAliveIntervalRef.current = setInterval(() => {
      if (window.speechSynthesis.speaking) {
        window.speechSynthesis.pause()
        window.speechSynthesis.resume()
      } else {
        clearKeepAlive()
      }
    }, 10000)
  }, [clearKeepAlive])

  // Tải cài đặt & thống kê từ localStorage
  useEffect(() => {
    const p = getTypingPreferences()
    setPreferences(p)
    const activeRate = p.speechRate || ttsEngine.getRate()
    setSpeechRate(activeRate)
    speechRateRef.current = activeRate
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

  // Khởi tạo danh sách giọng đọc tiếng Trung an toàn
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
    try {
      window.speechSynthesis.addEventListener('voiceschanged', updateVoices)
    } catch {
      if (window.speechSynthesis.onvoiceschanged !== undefined) {
        window.speechSynthesis.onvoiceschanged = updateVoices
      }
    }
    return () => {
      if (typeof window !== 'undefined' && window.speechSynthesis) {
        try {
          window.speechSynthesis.removeEventListener('voiceschanged', updateVoices)
        } catch {}
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

  // Reset câu audio khi đổi bài hoặc đổi câu tập
  useEffect(() => {
    setAudioSentenceIndex(0)
    setIsAudioFinished(false)
  }, [currentExercise?.id, currentIndex])

  // Đồng bộ audioSentenceIndex theo tiến trình gõ phím khi âm thanh đang nghỉ
  useEffect(() => {
    if (speechStatus === 'idle') {
      setAudioSentenceIndex(currentTypingSentenceIndex)
      setIsAudioFinished(false)
    }
  }, [currentTypingSentenceIndex, speechStatus])

  // Dừng phát âm thanh ngay lập tức và giải phóng toàn bộ tài nguyên
  const stopSpeech = useCallback(() => {
    currentCardEpochRef.current++
    clearAutoSpeakTimer()
    clearKeepAlive()
    setSentenceTTSActive(false)
    utteranceIdRef.current++

    if (activeUtteranceRef.current) {
      releaseUtterance(activeUtteranceRef.current)
      activeUtteranceRef.current = null
    }

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
  }, [clearAutoSpeakTimer, clearKeepAlive])

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

  // Phát âm câu tiếng Trung kèm cơ chế đồng bộ thích ứng 2 tầng (Two-Tier Adaptive Synchronization):
  // Tầng 1: Nếu browser/voice hỗ trợ word boundary -> Đồng bộ từng từ thời gian thực
  // Tầng 2: Nếu browser/voice không hỗ trợ word boundary -> Fallback tô sáng cả câu, đọc đầy đủ trọn vẹn, không đứng ở chữ đầu
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

      // Bật cờ phiên đọc câu để bảo vệ luồng âm thanh không bị âm gõ phím hủy ngang
      setSentenceTTSActive(true)
      clearKeepAlive()

      // Giải phóng tham chiếu cũ
      if (activeUtteranceRef.current) {
        releaseUtterance(activeUtteranceRef.current)
        activeUtteranceRef.current = null
      }

      // Hủy mọi âm thanh cũ trong hàng đợi trước khi phát câu mới
      try {
        window.speechSynthesis.cancel()
      } catch {}

      const currentUtteranceId = ++utteranceIdRef.current
      const thisEpoch = expectedEpoch ?? currentCardEpochRef.current
      const item = list[index]

      // Đặt trạng thái câu đang phát.
      // QUAN TRỌNG: KHÔNG gán cứng speakingWordIndex = 0! Giữ null ban đầu để hiển thị
      // Sentence-Level Highlight Fallback thanh lịch, chỉ nâng cấp lên Word-Level khi
      // sự kiện boundary thực sự phát sinh từ engine.
      setAudioSentenceIndex(index)
      setSpeakingSentenceIndex(index)
      setSpeakingWordIndex(null)
      setSpeechStatus('playing')

      // Áp dụng độ trễ vi mô (25ms) sau cancel() để triệt tiêu Race Condition trong audio driver
      setTimeout(() => {
        if (currentUtteranceId !== utteranceIdRef.current) return
        if (thisEpoch !== currentCardEpochRef.current) return

        try {
          const utterance = new SpeechSynthesisUtterance(item.text)
          utterance.lang = 'zh-CN'
          utterance.rate = Math.max(0.5, Math.min(2.0, speechRateRef.current || 1.0))

          const voices = getChineseVoices()
          const voice =
            voices.find((v) => v.voiceURI === selectedVoiceURIRef.current) || voices[0]
          if (voice) utterance.voice = voice

          // Lưu giữ tham chiếu mạnh chống V8/WebKit Garbage Collector thu hồi giữa chừng
          activeUtteranceRef.current = utterance
          retainUtterance(utterance)

          let boundaryCount = 0
          let boundaryFallbackTimer: ReturnType<typeof setTimeout> | null = null

          utterance.onstart = () => {
            if (currentUtteranceId !== utteranceIdRef.current) return
            if (thisEpoch !== currentCardEpochRef.current) return
            setSpeechStatus('playing')
            startKeepAlive()

            // Cơ chế phòng vệ Mobile WebKit: Nếu sau 600ms không nhận thêm boundary (hoặc chỉ nhận boundary 0 duy nhất),
            // tự động chuyển về sentence fallback để không kẹt chữ đầu tiên
            boundaryFallbackTimer = setTimeout(() => {
              if (currentUtteranceId !== utteranceIdRef.current) return
              if (thisEpoch !== currentCardEpochRef.current) return
              if (boundaryCount <= 1 && item.text.length > 2) {
                setSpeakingWordIndex(null)
              }
            }, 600)
          }

          // Lắng nghe sự kiện boundary để tô sáng từng từ nếu trình duyệt/giọng đọc hỗ trợ
          utterance.onboundary = (event) => {
            if (currentUtteranceId !== utteranceIdRef.current) return
            if (thisEpoch !== currentCardEpochRef.current) return

            // Bỏ qua boundary cấp độ sentence (chỉ nhận diện word boundary thực tế)
            if (event.name === 'sentence') return

            boundaryCount++
            const charIndex = typeof event.charIndex === 'number' ? event.charIndex : 0
            const globalCharIndex = item.startIndex + charIndex

            // Khoanh vùng tìm từ nghiêm ngặt trong phạm vi câu hiện tại
            const wordIdx = findWordIndexByCharIndex(tokens, globalCharIndex, {
              startIndex: item.startIndex,
              endIndex: item.endIndex,
            })
            if (wordIdx !== -1) {
              setSpeakingWordIndex((prev) => (prev === wordIdx ? prev : wordIdx))
            }
          }

          utterance.onend = () => {
            if (boundaryFallbackTimer) clearTimeout(boundaryFallbackTimer)
            releaseUtterance(utterance)
            if (activeUtteranceRef.current === utterance) {
              activeUtteranceRef.current = null
            }
            clearKeepAlive()

            if (currentUtteranceId !== utteranceIdRef.current) return
            if (thisEpoch !== currentCardEpochRef.current) return

            setSpeakingWordIndex(null)

            if (readingModeRef.current === 'all' && isSequential) {
              if (index + 1 < list.length) {
                setAudioSentenceIndex(index + 1)
                speakSentence(index + 1, true, list, tokens, thisEpoch)
              } else {
                setAudioSentenceIndex(list.length - 1)
                setIsAudioFinished(true)
                stopSpeech()
              }
            } else if (readingModeRef.current === 'sentence') {
              if (index + 1 < list.length) {
                // Đã đọc xong câu index, chuẩn bị sang câu tiếp theo
                setAudioSentenceIndex(index + 1)
                if (autoSpeakNextRef.current) {
                  // Khi bật "Tự động đọc câu mới": tự động đọc tiếp câu tiếp theo
                  speakSentence(index + 1, false, list, tokens, thisEpoch)
                } else {
                  // Khi tắt: chỉ phát 1 câu rồi dừng, câu tiếp theo đã sẵn sàng cho lần bấm tới
                  setSpeechStatus('idle')
                  setSpeakingSentenceIndex(null)
                  setSpeakingWordIndex(null)
                  setReadingMode(null)
                  readingModeRef.current = null
                  setSentenceTTSActive(false)
                }
              } else {
                // Đã đọc đến câu cuối cùng của đoạn
                setAudioSentenceIndex(index)
                setIsAudioFinished(true)
                setSpeechStatus('idle')
                setSpeakingSentenceIndex(null)
                setSpeakingWordIndex(null)
                setReadingMode(null)
                readingModeRef.current = null
                setSentenceTTSActive(false)
              }
            } else {
              setSpeechStatus('idle')
              setSpeakingSentenceIndex(null)
              setSpeakingWordIndex(null)
              setReadingMode(null)
              readingModeRef.current = null
              setSentenceTTSActive(false)
            }
          }

          utterance.onerror = (e) => {
            if (boundaryFallbackTimer) clearTimeout(boundaryFallbackTimer)
            releaseUtterance(utterance)
            if (activeUtteranceRef.current === utterance) {
              activeUtteranceRef.current = null
            }
            clearKeepAlive()

            if (currentUtteranceId !== utteranceIdRef.current) return
            if (thisEpoch !== currentCardEpochRef.current) return

            if (e.error !== 'interrupted' && e.error !== 'canceled') {
              console.warn('SpeechSynthesis error:', e.error)
              stopSpeech()
            }
          }

          if (window.speechSynthesis.paused) {
            try {
              window.speechSynthesis.resume()
            } catch {}
          }

          window.speechSynthesis.speak(utterance)
        } catch (err) {
          console.error('Lỗi khi kích hoạt speakSentence:', err)
          stopSpeech()
        }
      }, 25)
    },
    [stopSpeech, clearKeepAlive, startKeepAlive]
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
    stopSpeech()
    const thisEpoch = ++currentCardEpochRef.current
    setIsAudioFinished(false)
    setAudioSentenceIndex(0)
    readingModeRef.current = 'all'
    setReadingMode('all')
    speakSentence(0, true, list, exerciseWordTokensRef.current, thisEpoch)
  }, [availableVoices, speakSentence, clearAutoSpeakTimer, stopSpeech])

  const handlePlayCurrentSentence = useCallback(() => {
    clearAutoSpeakTimer()
    const list = chineseSentencesRef.current
    if (list.length === 0) return

    stopSpeech()
    const thisEpoch = ++currentCardEpochRef.current
    setIsAudioFinished(false)

    const targetIdx = Math.min(Math.max(0, audioSentenceIndexRef.current), list.length - 1)
    readingModeRef.current = 'sentence'
    setReadingMode('sentence')
    speakSentence(
      targetIdx,
      false,
      list,
      exerciseWordTokensRef.current,
      thisEpoch
    )
  }, [speakSentence, clearAutoSpeakTimer, stopSpeech])

  const handlePrevSentenceAudio = useCallback(() => {
    const list = chineseSentencesRef.current
    if (list.length <= 1) return
    const prevIdx = Math.max(0, audioSentenceIndex - 1)
    setAudioSentenceIndex(prevIdx)
    setIsAudioFinished(false)

    if (speechStatus === 'playing' && readingMode === 'sentence') {
      stopSpeech()
      const thisEpoch = ++currentCardEpochRef.current
      readingModeRef.current = 'sentence'
      setReadingMode('sentence')
      speakSentence(prevIdx, false, list, exerciseWordTokensRef.current, thisEpoch)
    }
  }, [audioSentenceIndex, speechStatus, readingMode, speakSentence, stopSpeech])

  const handleNextSentenceAudio = useCallback(() => {
    const list = chineseSentencesRef.current
    if (list.length <= 1) return
    const nextIdx = Math.min(list.length - 1, audioSentenceIndex + 1)
    setAudioSentenceIndex(nextIdx)
    setIsAudioFinished(false)

    if (speechStatus === 'playing' && readingMode === 'sentence') {
      stopSpeech()
      const thisEpoch = ++currentCardEpochRef.current
      readingModeRef.current = 'sentence'
      setReadingMode('sentence')
      speakSentence(nextIdx, false, list, exerciseWordTokensRef.current, thisEpoch)
    }
  }, [audioSentenceIndex, speechStatus, readingMode, speakSentence, stopSpeech])

  const handlePauseSpeech = useCallback(() => {
    clearKeepAlive()
    if (typeof window !== 'undefined' && window.speechSynthesis) {
      window.speechSynthesis.pause()
      setSpeechStatus('paused')
    }
  }, [clearKeepAlive])

  const handleResumeSpeech = useCallback(() => {
    if (typeof window !== 'undefined' && window.speechSynthesis) {
      window.speechSynthesis.resume()
      setSpeechStatus('playing')
      startKeepAlive()
      setTimeout(() => {
        if (window.speechSynthesis.paused && speakingSentenceIndex !== null) {
          speakSentence(speakingSentenceIndex, readingModeRef.current === 'all')
        }
      }, 150)
    }
  }, [speakingSentenceIndex, speakSentence, startKeepAlive])

  const handleRateChange = (rate: number) => {
    setSpeechRate(rate)
    speechRateRef.current = rate
    ttsEngine.setRate(rate as any)
    const updated = { ...preferences, speechRate: rate }
    setPreferences(updated)
    saveTypingPreferences(updated)

    // Nếu đang phát âm thanh, phát lại ngay câu hiện tại với tốc độ mới
    if (speechStatus === 'playing' && speakingSentenceIndex !== null) {
      speakSentence(
        speakingSentenceIndex,
        readingModeRef.current === 'all',
        chineseSentencesRef.current,
        exerciseWordTokensRef.current,
        currentCardEpochRef.current
      )
    }
  }

  const handleVoiceChange = (uri: string) => {
    setSelectedVoiceURI(uri)
    selectedVoiceURIRef.current = uri
    const updated = { ...preferences, preferredVoiceURI: uri }
    setPreferences(updated)
    saveTypingPreferences(updated)

    // Nếu đang phát âm thanh, phát lại ngay câu hiện tại với giọng mới
    if (speechStatus === 'playing' && speakingSentenceIndex !== null) {
      speakSentence(
        speakingSentenceIndex,
        readingModeRef.current === 'all',
        chineseSentencesRef.current,
        exerciseWordTokensRef.current,
        currentCardEpochRef.current
      )
    }
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
    setAudioSentenceIndex(0)
    setIsAudioFinished(false)
    if (timerRef.current) clearInterval(timerRef.current)
    // Chỉ tự động focus bàn phím trên desktop/tablet để tránh giật bàn phím ảo trên mobile
    if (typeof window !== 'undefined' && window.innerWidth >= 768) {
      setTimeout(() => inputRef.current?.focus(), 50)
    }
  }, [stopSpeech])

  // Chuyển bài khi đổi bộ lọc
  useEffect(() => {
    lastAutoSpokenExerciseIdRef.current = null
    setExerciseEpoch((prev) => prev + 1)
    setCurrentIndex(0)
    resetExercise()
  }, [mode, levelFilter, categoryFilter, hskLevel, selectedLessonId, onlyUnlearnedFilter, resetExercise])

  // Làm mới số lượng câu sai cần ôn
  const refreshMistakeCount = useCallback(async () => {
    if (isLoggedIn) {
      try {
        const res = await getTypingMistakesAction()
        if (res.success && res.mistakes) {
          setMistakeCount(res.mistakes.filter((m) => m.reviewStatus !== 'mastered').length)
          return
        }
      } catch {}
    }
    if (typeof getLocalTypingMistakes === 'function') {
      try {
        const localList = getLocalTypingMistakes()
        setMistakeCount(localList.filter((m) => m.reviewStatus !== 'mastered').length)
      } catch {}
    }
  }, [isLoggedIn])

  useEffect(() => {
    refreshMistakeCount()
  }, [refreshMistakeCount])

  // Tự động đồng bộ an toàn dữ liệu từ localStorage lên cloud khi đăng nhập
  useEffect(() => {
    if (isLoggedIn && typeof getAllLocalTypingDataForSync === 'function') {
      try {
        const localData = getAllLocalTypingDataForSync()
        if (localData?.progressList?.length > 0 || localData?.mistakeList?.length > 0) {
          syncLocalTypingDataAction(localData).then((res) => {
            if (res.success && typeof clearSyncedLocalData === 'function') {
              clearSyncedLocalData()
              refreshMistakeCount()
            }
          })
        }
      } catch {}
    }
  }, [isLoggedIn, refreshMistakeCount])

  // Tải tiến độ đã lưu khi mở bài học
  useEffect(() => {
    if (!currentExercise?.id) return
    let isCancelled = false
    setShowResumeBanner(false)
    setSavedProgress(null)

    const fetchProgress = async () => {
      if (isLoggedIn) {
        try {
          const res = await getTypingProgressAction(mode, currentExercise.id)
          if (!isCancelled && res.success && res.progress) {
            if (
              res.progress.status === 'in_progress' &&
              (res.progress.completedSentences > 0 || res.progress.currentSentenceIndex > 0)
            ) {
              setSavedProgress(res.progress)
              setShowResumeBanner(true)
              return
            }
          }
        } catch {}
      }

      // Fallback local
      if (typeof getLocalTypingProgress === 'function') {
        try {
          const localP = getLocalTypingProgress(mode, currentExercise.id)
          if (
            !isCancelled &&
            localP &&
            localP.status === 'in_progress' &&
            (localP.completedSentences > 0 || localP.currentSentenceIndex > 0)
          ) {
            setSavedProgress(localP as any)
            setShowResumeBanner(true)
          }
        } catch {}
      }
    }

    fetchProgress()
    return () => {
      isCancelled = true
    }
  }, [currentExercise?.id, mode, isLoggedIn])

  // Xử lý tiếp tục bài học dở dang
  const handleResumeProgress = useCallback(() => {
    if (!savedProgress || !currentExercise) return
    setShowResumeBanner(false)

    const targetSentenceIndex = Math.min(
      savedProgress.currentSentenceIndex,
      Math.max(0, chineseSentences.length - 1)
    )
    const targetSentence = chineseSentences[targetSentenceIndex]

    // Khôi phục bản nháp ký tự nếu có
    const draft = getLocalTypingDraft(mode, currentExercise.id)
    if (
      draft &&
      draft.draftText &&
      draft.draftText.length > (targetSentence ? targetSentence.startIndex : 0)
    ) {
      setUserInput(draft.draftText)
      committedLengthRef.current = draft.draftText.length
    } else if (targetSentence && targetSentence.startIndex > 0) {
      const restoredText = currentExercise.hanzi.slice(0, targetSentence.startIndex)
      setUserInput(restoredText)
      committedLengthRef.current = restoredText.length
    }

    setIsStarted(true)
    setIsCompleted(false)
    toast.success(`Tiếp tục bài học từ câu ${targetSentenceIndex + 1}`)
    setTimeout(() => inputRef.current?.focus(), 100)
  }, [savedProgress, currentExercise, chineseSentences, mode])

  // Xử lý bắt đầu lại bài học từ đầu (không xóa câu sai)
  const handleRestartProgress = useCallback(async () => {
    if (!currentExercise) return
    setShowResumeBanner(false)
    setSavedProgress(null)
    clearLocalTypingDraft(mode, currentExercise.id)
    if (typeof resetLocalTypingProgress === 'function') {
      resetLocalTypingProgress(mode, currentExercise.id)
    }
    if (isLoggedIn) {
      await resetTypingProgressAction(mode, currentExercise.id)
    }
    resetExercise()
    toast.info('Đã bắt đầu lại từ câu 1. Lịch sử câu sai vẫn được bảo lưu an toàn.')
  }, [currentExercise, mode, isLoggedIn, resetExercise])

  // Tự động lưu bản nháp chuỗi ký tự đang gõ dở với debounce 300ms
  const draftDebounceTimerRef = useRef<NodeJS.Timeout | null>(null)
  useEffect(() => {
    if (!currentExercise?.id || isCompleted) return
    if (!userInput || userInput.length === 0) return

    if (draftDebounceTimerRef.current) {
      clearTimeout(draftDebounceTimerRef.current)
    }

    draftDebounceTimerRef.current = setTimeout(() => {
      saveLocalTypingDraft(mode, currentExercise.id, currentTypingSentenceIndex, userInput)
    }, 300)

    return () => {
      if (draftDebounceTimerRef.current) {
        clearTimeout(draftDebounceTimerRef.current)
      }
    }
  }, [userInput, currentExercise?.id, mode, currentTypingSentenceIndex, isCompleted])

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
    const errors: { index: number; expected: string; actual: string }[] = []

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

    // Ghi nhận câu sai nếu bài có lỗi hoặc chưa gõ đủ ký tự
    if (evaluation.errorCount > 0 || userInput.length < currentExercise.hanzi.length) {
      const mistakeDetails = evaluation.errors.map((e) => ({
        index: e.index,
        expected: e.expected,
        actual: e.actual,
      }))
      const mistakePayload = {
        mode,
        exerciseId: currentExercise.id,
        sentenceIndex: currentTypingSentenceIndex,
        sentenceZh: currentExercise.hanzi,
        pinyin: currentExercise.pinyin,
        meaningVi: currentExercise.meaning,
        lastInputZh: userInput,
        mistakeDetails,
      }
      if (typeof recordLocalTypingMistake === 'function') {
        recordLocalTypingMistake(mistakePayload)
      }
      if (isLoggedIn) {
        recordTypingMistakeAction(mistakePayload)
      }
      setMistakeCount((prev) => prev + 1)
    }

    // Cập nhật tiến độ hoàn thành bài học
    const finishProgress: TypingProgressDTO = {
      mode,
      exerciseId: currentExercise.id,
      currentSentenceIndex: Math.max(0, chineseSentences.length - 1),
      completedSentences: Math.max(1, chineseSentences.length),
      totalSentences: Math.max(1, chineseSentences.length),
      correctSentences: evaluation.errorCount === 0 ? Math.max(1, chineseSentences.length) : 0,
      errorSentences: evaluation.errorCount > 0 ? 1 : 0,
      lastTypedLength: userInput.length,
      timeSpentSeconds: Math.max(elapsedSeconds, 1),
      status: 'completed',
    }
    if (typeof saveLocalTypingProgress === 'function') {
      saveLocalTypingProgress(finishProgress as any)
    }
    if (isLoggedIn) {
      saveTypingProgressAction(finishProgress)
    }
    if (currentExercise?.id) {
      clearLocalTypingDraft(mode, currentExercise.id)
    }
  }, [
    isCompleted,
    currentExercise,
    stopSpeech,
    preferences.soundEffects,
    mode,
    elapsedSeconds,
    evaluation,
    userInput,
    currentTypingSentenceIndex,
    chineseSentences,
    isLoggedIn,
  ])

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
      const isSentenceTTSCurrentlySpeaking = speechStatus === 'playing'

      // Chỉ cập nhật highlight gõ và phát âm chữ lẻ nếu KHÔNG ĐANG trong phiên đọc câu/đoạn văn
      if (!isSentenceTTSCurrentlySpeaking && preferences.speakOnType !== false && newlyTypedText.trim()) {
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

      // Đánh giá và lưu vết câu vừa hoàn thành trong bài nhiều câu (Đoạn văn)
      if (chineseSentences.length > 1) {
        const curSentence = chineseSentences.find(
          (s) => prevLength < s.endIndex && newLength >= s.endIndex
        )
        if (curSentence) {
          const targetSentenceText = curSentence.text
          const userSentenceText = newVal.slice(curSentence.startIndex, Math.min(newLength, curSentence.endIndex))

          const sentenceErrors: { index: number; expected: string; actual: string }[] = []
          for (let i = 0; i < targetSentenceText.length; i++) {
            const tChar = targetSentenceText[i]
            const uChar = userSentenceText[i]
            if (!uChar || !isCharMatch(uChar, tChar, preferences.normalizePunctuation)) {
              sentenceErrors.push({
                index: i + 1,
                expected: tChar,
                actual: uChar || '(thiếu)',
              })
            }
          }

          const isSentenceValid = sentenceErrors.length === 0 && userSentenceText.length >= targetSentenceText.length

          if (!isSentenceValid) {
            const mistakePayload = {
              mode,
              exerciseId: currentExercise.id,
              sentenceIndex: curSentence.index,
              sentenceZh: curSentence.text,
              pinyin: currentExercise.pinyin,
              meaningVi: currentExercise.meaning,
              lastInputZh: userSentenceText,
              mistakeDetails: sentenceErrors,
            }
            if (typeof recordLocalTypingMistake === 'function') {
              recordLocalTypingMistake(mistakePayload)
            }
            if (isLoggedIn) {
              recordTypingMistakeAction(mistakePayload)
            }
            setMistakeCount((prev) => prev + 1)
          }

          // Lưu tiến độ câu đang học
          const isLastSentence = curSentence.index + 1 >= chineseSentences.length
          const progressPayload: TypingProgressDTO = {
            mode,
            exerciseId: currentExercise.id,
            currentSentenceIndex: isLastSentence ? curSentence.index : curSentence.index + 1,
            completedSentences: curSentence.index + 1,
            totalSentences: chineseSentences.length,
            correctSentences: 0,
            errorSentences: 0,
            lastTypedLength: newLength,
            timeSpentSeconds: elapsedSeconds,
            status: isLastSentence ? 'completed' : 'in_progress',
          }
          if (typeof saveLocalTypingProgress === 'function') {
            saveLocalTypingProgress(progressPayload as any)
          }
          if (isLoggedIn) {
            saveTypingProgressAction(progressPayload)
          }
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
      mode,
      isLoggedIn,
      elapsedSeconds,
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
    if (currentIndex >= exercises.length - 1) {
      toast.success('Bạn đã hoàn thành câu cuối cùng của bài học!', {
        description: 'Bạn có thể làm lại hoặc chuyển sang bài học tiếp theo.',
        duration: 3500,
      })
      return
    }
    navigateToExercise(currentIndex + 1)
  }, [currentIndex, exercises.length, navigateToExercise])

  // Quay lại câu trước
  const handlePrev = useCallback(() => {
    if (exercises.length === 0) return
    if (currentIndex <= 0) return
    navigateToExercise(currentIndex - 1)
  }, [currentIndex, exercises.length, navigateToExercise])

  // Phím tắt bàn phím tiện lợi (Sử dụng ref để listener chỉ gắn 1 lần duy nhất, loại bỏ hoàn toàn listener churn)
  const keyActionsRef = useRef({
    practiceMode,
    showHistoryModal,
    isCompleted,
    isComposing,
    handleNext,
    resetExercise,
    handlePlayCurrentSentence,
  })
  useEffect(() => {
    keyActionsRef.current = {
      practiceMode,
      showHistoryModal,
      isCompleted,
      isComposing,
      handleNext,
      resetExercise,
      handlePlayCurrentSentence,
    }
  })

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      const actions = keyActionsRef.current
      // Chỉ hoạt động trong chế độ Nghe & Gõ (visual), không can thiệp vào chế độ Dịch (translate)
      if (actions.practiceMode !== 'visual') return
      if (actions.showHistoryModal) return

      // Bỏ qua hoàn toàn nếu người dùng đang nhập IME tiếng Trung hoặc giữ phím lặp lại
      if (e.isComposing || e.keyCode === 229 || actions.isComposing) return
      if (e.repeat) return

      // Enter khi đã hoàn thành -> sang câu kế tiếp
      if (e.key === 'Enter' && actions.isCompleted) {
        e.preventDefault()
        actions.handleNext()
      }
      // Alt + R -> Làm lại bài
      if (e.altKey && (e.key === 'r' || e.key === 'R')) {
        e.preventDefault()
        lastAutoSpokenExerciseIdRef.current = null
        setExerciseEpoch((prev) => prev + 1)
        actions.resetExercise()
      }
      // Alt + S -> Phát lại âm thanh câu hiện tại (tránh dùng Ctrl + Space vì trùng phím tắt chuyển IME trên Windows)
      if (e.altKey && (e.key === 's' || e.key === 'S')) {
        e.preventDefault()
        actions.handlePlayCurrentSentence()
      }
    }

    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [])

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
              {practiceMode === 'translate'
                ? 'Dịch Việt → Gõ Hán'
                : mode === 'sentence'
                ? '100 câu ca dao, tục ngữ Việt Nam'
                : 'Luyện đánh máy'}
            </h1>
          </div>
          <p className="text-muted font-serif text-sm mt-1.5 max-w-2xl">
            {practiceMode === 'translate'
              ? 'Tự dịch câu tiếng Việt sang chữ Hán bằng bộ gõ Pinyin IME. Nghe phát âm tiếng Trung không lộ đáp án và sử dụng hệ thống gợi ý 3 mức khi cần.'
              : mode === 'sentence'
              ? 'Luyện gõ chữ Hán qua 100 câu ca dao, tục ngữ Việt Nam được chuyển ngữ sang tiếng Trung giản thể. Bật bộ gõ Pinyin IME, gõ pinyin rồi chọn đúng chữ Hán.'
              : 'Rèn luyện kỹ năng gõ chữ Hán bằng Pinyin qua bộ gõ tiếng Trung (IME). Quan sát nội dung mục tiêu và tự gõ lại để cải thiện tốc độ và phản xạ.'}
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

      {/* 2. Hướng dẫn gõ Pinyin IME cho người học mới */}
      {showImeGuide && (
        <div className="p-4 sm:p-5 rounded-2xl bg-amber-500/10 border border-amber-500/25 relative flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 text-sm">
          <div className="flex items-start gap-3">
            <span className="p-2 rounded-xl bg-amber-500/15 text-amber-700 dark:text-amber-400 shrink-0 mt-0.5">
              <Keyboard className="w-5 h-5" />
            </span>
            <div className="space-y-1">
              <p className="font-semibold text-title text-sm sm:text-base">
                Hướng dẫn gõ chữ Hán bằng bộ gõ Pinyin IME
              </p>
              <p className="text-body text-xs sm:text-sm leading-relaxed">
                1. Chuyển bàn phím sang tiếng Trung (<strong>Windows + Space</strong> trên Windows hoặc <strong>Ctrl + Space</strong> trên Mac).<br />
                2. Gõ Pinyin không dấu (ví dụ: <code className="px-1.5 py-0.5 rounded bg-black/5 font-mono font-bold">nihao</code>).<br />
                3. Nhấn <strong>phím Cách (Space)</strong> hoặc số để chọn chữ Hán <strong className="font-hanzi">你好</strong> tương ứng.
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={() => setShowImeGuide(false)}
            className="self-end sm:self-center shrink-0 px-3 py-1.5 rounded-lg text-xs font-medium text-muted hover:text-title hover:bg-black/5 transition-colors cursor-pointer"
            title="Đóng hướng dẫn"
          >
            Đã hiểu, đóng lại
          </button>
        </div>
      )}

      {/* 3. Thanh chọn chế độ luyện tập chính: Nghe & Gõ vs Dịch Việt → Gõ Hán */}
      <div className="space-y-2">
        <div className="grid grid-cols-2 gap-2 p-1.5 bg-card border border-[#E9DDD1] rounded-2xl shadow-2xs">
          <button
            onClick={() => {
              stopSpeech()
              setPracticeMode('visual')
            }}
            className={`flex items-center justify-center gap-2 py-3 px-3 rounded-xl text-xs sm:text-sm font-sans font-semibold transition-all active:scale-[0.98] touch-manipulation min-h-[48px] cursor-pointer ${
              practiceMode === 'visual'
                ? 'bg-[#B8322D] text-white shadow-2xs'
                : 'text-[#243047]/75 hover:text-[#243047] hover:bg-[#FFF9F3]'
            }`}
          >
            <Headphones className="w-4 h-4 shrink-0" />
            <span className="truncate">Nghe & Gõ</span>
          </button>

          <button
            onClick={() => {
              stopSpeech()
              setPracticeMode('translate')
            }}
            className={`flex items-center justify-center gap-2 py-3 px-3 rounded-xl text-xs sm:text-sm font-sans font-semibold transition-all active:scale-[0.98] touch-manipulation min-h-[48px] cursor-pointer ${
              practiceMode === 'translate'
                ? 'bg-[#B8322D] text-white shadow-2xs'
                : 'text-[#243047]/75 hover:text-[#243047] hover:bg-[#FFF9F3]'
            }`}
          >
            <PenTool className="w-4 h-4 shrink-0" />
            <span className="truncate">Dịch Việt → Gõ Hán</span>
          </button>
        </div>

        <p className="text-xs sm:text-sm text-muted font-sans px-1">
          {practiceMode === 'visual'
            ? '🎧 Nghe & Gõ: Luyện phản xạ tai nghe âm thanh tiếng Trung và ghi nhớ mặt chữ Hán tương ứng.'
            : '✍️ Dịch Việt → Gõ Hán: Đọc ý nghĩa tiếng Việt và tự chuyển ngữ rồi gõ câu chữ Hán hoàn chỉnh.'}
        </p>
      </div>

      {practiceMode === 'translate' ? (
        <TranslateTypingMode
          initialHskLevel={hskLevel}
          initialLessonId={selectedLessonId}
          onBackToNormalMode={() => setPracticeMode('visual')}
        />
      ) : (
        <>
          {/* 3. Thanh chọn phân loại nội dung cho Nhìn & Gõ (4 chế độ bao gồm Ôn câu sai) */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-1.5 sm:gap-2 bg-card border border-[#E9DDD1] rounded-2xl p-1.5 shadow-2xs">
        <button
          onClick={() => {
            setActiveTab('practice')
            setMode('sentence')
          }}
          className={`flex items-center justify-center gap-1.5 sm:gap-2 py-2.5 px-3 rounded-xl text-xs md:text-sm font-serif transition-all active:scale-[0.98] touch-manipulation min-h-[44px] ${
            activeTab === 'practice' && mode === 'sentence'
              ? 'bg-[#B8322D] text-white font-semibold shadow-2xs'
              : 'text-[#243047]/75 hover:text-[#243047] hover:bg-[#FFF9F3]'
          }`}
        >
          <FileText className="w-4 h-4 shrink-0" />
          <span className="truncate">Câu mẫu</span>
        </button>

        <button
          onClick={() => {
            setActiveTab('practice')
            setMode('paragraph')
          }}
          className={`flex items-center justify-center gap-1.5 sm:gap-2 py-2.5 px-3 rounded-xl text-xs md:text-sm font-serif transition-all active:scale-[0.98] touch-manipulation min-h-[44px] ${
            activeTab === 'practice' && mode === 'paragraph'
              ? 'bg-[#B8322D] text-white font-semibold shadow-2xs'
              : 'text-[#243047]/75 hover:text-[#243047] hover:bg-[#FFF9F3]'
          }`}
        >
          <AlignLeft className="w-4 h-4 shrink-0" />
          <span className="truncate">Đoạn văn</span>
        </button>

        <button
          onClick={() => {
            setActiveTab('practice')
            setMode('hsk')
          }}
          className={`flex items-center justify-center gap-1.5 sm:gap-2 py-2.5 px-3 rounded-xl text-xs md:text-sm font-serif transition-all active:scale-[0.98] touch-manipulation min-h-[44px] ${
            activeTab === 'practice' && mode === 'hsk'
              ? 'bg-[#B8322D] text-white font-semibold shadow-2xs'
              : 'text-[#243047]/75 hover:text-[#243047] hover:bg-[#FFF9F3]'
          }`}
        >
          <GraduationCap className="w-4 h-4 shrink-0" />
          <span className="truncate">Theo HSK</span>
        </button>

        <button
          onClick={() => {
            stopSpeech()
            setActiveTab('mistakes')
          }}
          className={`flex items-center justify-center gap-1.5 py-2.5 px-3 rounded-xl text-xs md:text-sm font-serif transition-all active:scale-[0.98] touch-manipulation min-h-[44px] ${
            activeTab === 'mistakes'
              ? 'bg-[#B8322D] text-white font-semibold shadow-2xs'
              : 'text-[#243047]/75 hover:text-[#243047] hover:bg-[#FFF9F3]'
          }`}
        >
          <Flame className="w-4 h-4 text-amber-500 shrink-0" />
          <span className="truncate">Ôn câu sai</span>
          {mistakeCount > 0 && (
            <span
              className={`px-1.5 py-0.2 rounded-full text-[10px] font-sans font-bold shrink-0 ${
                activeTab === 'mistakes'
                  ? 'bg-white/25 text-white'
                  : 'bg-red-500/15 text-red-600 dark:text-red-400'
              }`}
            >
              {mistakeCount}
            </span>
          )}
        </button>
      </div>

      {activeTab === 'mistakes' ? (
        <TypingMistakesReview
          isLoggedIn={isLoggedIn}
          onBackToPractice={() => setActiveTab('practice')}
        />
      ) : (
        <>
          {/* Banner khôi phục tiến độ nếu có bài dở dang */}
          {showResumeBanner && savedProgress && (
            <TypingResumeBanner
              currentSentenceIndex={savedProgress.currentSentenceIndex}
              totalSentences={savedProgress.totalSentences}
              completedSentences={savedProgress.completedSentences}
              correctSentences={savedProgress.correctSentences}
              onResume={handleResumeProgress}
              onRestart={handleRestartProgress}
              onDismiss={() => setShowResumeBanner(false)}
            />
          )}

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
            <FileText className="w-4 h-4" />
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
            <div className="flex items-center gap-2 flex-wrap">
              {/* Lọc theo chủ đề ca dao tục ngữ */}
              <div className="flex items-center gap-1.5">
                <span className="text-xs text-muted font-serif">Chủ đề:</span>
                <select
                  value={categoryFilter}
                  onChange={(e) => {
                    setCategoryFilter(e.target.value)
                    setCurrentIndex(0)
                    resetExercise()
                  }}
                  className="bg-page border border-border rounded-lg text-xs font-serif text-title px-2.5 py-1 focus:outline-none focus:border-app-accent max-w-[200px]"
                >
                  {VIETNAMESE_PROVERB_CATEGORIES.map((cat) => (
                    <option key={cat} value={cat === 'Tất cả' ? 'all' : cat}>
                      {cat}
                    </option>
                  ))}
                </select>
              </div>

              {/* Lọc theo độ khó */}
              <div className="flex items-center gap-1">
                {[
                  { key: 'all', label: 'Tất cả' },
                  { key: 'Cơ bản', label: 'Cơ bản' },
                  { key: 'Trung cấp', label: 'Trung cấp' },
                  { key: 'Nâng cao', label: 'Nâng cao' },
                ].map((lvl) => (
                  <button
                    key={lvl.key}
                    onClick={() => {
                      setLevelFilter(lvl.key)
                      setCurrentIndex(0)
                      resetExercise()
                    }}
                    className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors ${
                      levelFilter === lvl.key
                        ? 'bg-app-accent text-white font-medium shadow-2xs'
                        : 'bg-page border border-border text-muted hover:text-title'
                    }`}
                  >
                    {lvl.label}
                  </button>
                ))}
              </div>

              {/* Danh sách chọn câu để chuyển nhanh đến câu bất kỳ */}
              {exercises.length > 0 && (
                <div className="flex items-center gap-1.5 ml-auto">
                  <span className="text-xs text-muted font-serif hidden md:inline">Chọn câu:</span>
                  <select
                    value={currentIndex}
                    onChange={(e) => {
                      const idx = parseInt(e.target.value, 10)
                      if (!isNaN(idx) && idx >= 0 && idx < exercises.length) {
                        setCurrentIndex(idx)
                        resetExercise()
                      }
                    }}
                    className="bg-page border border-border rounded-lg text-xs font-serif text-title px-2 py-1 focus:outline-none focus:border-app-accent max-w-[170px] sm:max-w-[240px] truncate"
                    title="Chuyển nhanh đến câu bất kỳ"
                  >
                    {exercises.map((ex, idx) => (
                      <option key={ex.id || idx} value={idx}>
                        {`#${idx + 1}: ${ex.vietnamese || ex.meaning}`}
                      </option>
                    ))}
                  </select>
                </div>
              )}
            </div>
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
            <div className="flex items-center gap-2.5 flex-wrap">
              {/* Chọn cấp HSK 3.0 */}
              <div className="flex items-center gap-1.5 flex-wrap">
                <span className="text-[10px] uppercase font-mono tracking-wider px-1.5 py-0.5 rounded bg-page border border-border text-muted">
                  HSK 3.0
                </span>
                <div className="flex items-center gap-1">
                  {[1, 2, 3, 4, 5, 6].map((num) => (
                    <button
                      key={num}
                      onClick={() => {
                        setHskLevel(num)
                        setSelectedLessonId('')
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
                  <span
                    title="HSK 7-9 (Cao cấp) đang cập nhật đề cương theo chuẩn GF 0025-2021"
                    className="px-2 py-1 rounded-md text-[11px] font-serif bg-page/60 border border-border/60 text-muted/60 select-none cursor-default"
                  >
                    HSK 7-9
                  </span>
                </div>
              </div>

              {/* Chọn bài học cụ thể trong cấp HSK */}
              <div className="flex items-center gap-1.5">
                <span className="text-xs text-muted font-serif hidden sm:inline">Bài học:</span>
                {loadingLessons ? (
                  <div className="flex items-center gap-1 text-xs text-muted font-serif px-2 py-1 bg-page border border-border rounded-lg">
                    <Loader2 className="w-3 h-3 animate-spin text-app-accent" />
                    <span>Đang tải...</span>
                  </div>
                ) : (
                  <select
                    value={selectedLessonId}
                    onChange={(e) => {
                      setSelectedLessonId(e.target.value)
                      setCurrentIndex(0)
                      resetExercise()
                    }}
                    className="bg-page border border-border rounded-lg text-xs font-serif text-title px-2.5 py-1 focus:outline-none focus:border-app-accent max-w-[210px] truncate"
                  >
                    <option value="">Tất cả bài học (HSK {hskLevel})</option>
                    {systemLessons.map((l) => (
                      <option key={l.id} value={l.id}>
                        {l.title}
                      </option>
                    ))}
                  </select>
                )}
              </div>

              {/* Lọc theo từ chưa thuộc */}
              <button
                onClick={() => {
                  setOnlyUnlearnedFilter(!onlyUnlearnedFilter)
                  setCurrentIndex(0)
                  resetExercise()
                }}
                className={`px-2.5 py-1 rounded-md text-xs font-serif transition-colors border ${
                  onlyUnlearnedFilter
                    ? 'bg-amber-500/15 border-amber-500/40 text-amber-600 dark:text-amber-400 font-semibold shadow-2xs'
                    : 'bg-page border-border text-muted hover:text-title'
                }`}
                title="Chỉ hiển thị các từ vựng đang học hoặc câu ví dụ chưa thuộc"
              >
                Từ chưa thuộc
              </button>

              {/* Danh sách chọn nhanh câu trong danh sách */}
              {exercises.length > 0 && (
                <div className="flex items-center gap-1.5 ml-auto">
                  <span className="text-xs text-muted font-serif hidden md:inline">Chọn câu:</span>
                  <select
                    value={currentIndex}
                    onChange={(e) => {
                      const idx = parseInt(e.target.value, 10)
                      if (!isNaN(idx) && idx >= 0 && idx < exercises.length) {
                        setCurrentIndex(idx)
                        resetExercise()
                      }
                    }}
                    className="bg-page border border-border rounded-lg text-xs font-serif text-title px-2 py-1 focus:outline-none focus:border-app-accent max-w-[170px] sm:max-w-[240px] truncate"
                    title="Chuyển nhanh đến câu bất kỳ"
                  >
                    {exercises.map((ex, idx) => (
                      <option key={ex.id || idx} value={idx}>
                        {`#${idx + 1}: ${ex.titleZh || ex.hanzi} - ${ex.meaning || ex.vietnamese}`}
                      </option>
                    ))}
                  </select>
                </div>
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
            className={`flex items-center gap-1.5 px-2.5 py-1 rounded-md text-xs font-serif transition-all border cursor-pointer select-none ${
              preferences.hideHanzi
                ? 'bg-title text-white border-title font-medium shadow-2xs'
                : 'bg-page border-border text-muted hover:text-title hover:border-title/30'
            }`}
            title={preferences.hideHanzi ? 'Nhấp để hiện lại chữ Hán mẫu' : 'Ẩn chữ Hán mẫu để luyện nghe và gõ (Dictation)'}
          >
            {preferences.hideHanzi ? <EyeOff className="w-3.5 h-3.5" /> : <Eye className="w-3.5 h-3.5" />}
            <span>{preferences.hideHanzi ? 'Đang ẩn chữ Hán' : 'Ẩn chữ Hán'}</span>
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
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-2 sm:gap-3">
        <div className="bg-card border border-[#E9DDD1] rounded-2xl p-3 sm:p-3.5 shadow-2xs flex items-center gap-3">
          <span className="p-2 rounded-xl bg-page border border-[#E9DDD1] text-muted shrink-0">
            <Clock className="w-4 h-4 text-app-accent" />
          </span>
          <div className="min-w-0">
            <p className="text-xs text-muted font-sans truncate">Thời gian</p>
            <p className="text-lg sm:text-xl font-bold font-sans text-title tracking-tight">{formatTime(elapsedSeconds)}</p>
          </div>
        </div>

        <div className="bg-card border border-[#E9DDD1] rounded-2xl p-3 sm:p-3.5 shadow-2xs flex items-center gap-3">
          <span className="p-2 rounded-xl bg-accent-soft text-app-accent shrink-0">
            <Zap className="w-4 h-4" />
          </span>
          <div className="min-w-0">
            <p className="text-xs text-muted font-sans truncate">Tốc độ (CPM)</p>
            <p className="text-lg sm:text-xl font-bold font-sans text-title tracking-tight">{evaluation.cpm}</p>
          </div>
        </div>

        <div className="bg-card border border-[#E9DDD1] rounded-2xl p-3 sm:p-3.5 shadow-2xs flex items-center gap-3">
          <span className="p-2 rounded-xl bg-jade-soft text-jade shrink-0">
            <Target className="w-4 h-4" />
          </span>
          <div className="min-w-0">
            <p className="text-xs text-muted font-sans truncate">Độ chính xác</p>
            <p className="text-lg sm:text-xl font-bold font-sans text-title tracking-tight">{evaluation.accuracy}%</p>
          </div>
        </div>

        <div className="bg-card border border-[#E9DDD1] rounded-2xl p-3 sm:p-3.5 shadow-2xs flex items-center gap-3">
          <span className="p-2 rounded-xl bg-gold-soft text-gold shrink-0">
            <Layers className="w-4 h-4" />
          </span>
          <div className="min-w-0">
            <p className="text-xs text-muted font-sans truncate">
              {mode === 'sentence' ? 'Tiến độ câu' : 'Tiến độ bài'}
            </p>
            <p className="text-lg sm:text-xl font-bold font-sans text-title tracking-tight truncate">
              {mode === 'sentence'
                ? `Câu ${exercises.length > 0 ? currentIndex + 1 : 0}/${exercises.length}`
                : `${exercises.length > 0 ? currentIndex + 1 : 0} / ${exercises.length}`}
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
            currentSentenceIndex={audioSentenceIndex}
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
            onPrevSentence={handlePrevSentenceAudio}
            onNextSentence={handleNextSentenceAudio}
            isAudioFinished={isAudioFinished}
          />

          <div className="bg-card border border-border rounded-xl sm:rounded-2xl p-4 sm:p-5 md:p-8 shadow-sm space-y-4 sm:space-y-6">
            {/* Huy hiệu thông tin câu & Nút nghe phát âm tiếng Trung */}
            <div className="flex items-center justify-between gap-3 text-xs text-muted font-serif flex-wrap">
              <div className="flex items-center gap-2 flex-wrap">
                <span className="px-2 py-0.5 rounded bg-page border border-border font-medium text-title">
                  {currentExercise.level || `HSK ${currentExercise.hskLevel || 1}`}
                </span>
                {currentExercise.category && (
                  <span className="text-muted">• {currentExercise.category}</span>
                )}
                {/* Trạng thái tự động lưu trực quan */}
                <span className="inline-flex items-center gap-1 text-[11px] px-2.5 py-0.5 rounded-full bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 border border-emerald-500/25">
                  <CheckCircle2 className="w-3 h-3 text-emerald-600 dark:text-emerald-400" />
                  <span>{isLoggedIn ? 'Tự động lưu đám mây' : 'Tự động lưu trên máy'}</span>
                </span>
              </div>

              <div className="flex items-center gap-2 sm:gap-3 flex-wrap">
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

            {/* Tiêu đề bài tập: Ca dao tục ngữ Việt Nam trong chế độ câu mẫu */}
            {mode === 'sentence' ? (
              <div className="bg-amber-500/5 dark:bg-amber-500/10 border border-amber-500/25 rounded-xl p-3.5 sm:p-4 md:p-5 space-y-2.5 -mt-1 shadow-2xs">
                <div className="flex items-center justify-between gap-2 flex-wrap text-xs">
                  <div className="flex items-center gap-2 flex-wrap">
                    <span className="px-2.5 py-0.5 rounded-full text-[11px] font-sans font-bold bg-app-accent text-white shadow-2xs">
                      {currentExercise.sourceType || 'Tục ngữ'}
                    </span>
                    <span className="px-2.5 py-0.5 rounded-md text-[11px] font-serif bg-card border border-border text-title font-semibold">
                      {currentExercise.category || 'Ca dao, tục ngữ'}
                    </span>
                    {currentExercise.translationType && (
                      <span className="text-[10px] font-mono px-2 py-0.5 rounded bg-page border border-border text-muted">
                        {currentExercise.translationType === 'Tương đương'
                          ? 'Thành ngữ tương đương'
                          : 'Bản chuyển ngữ'}
                      </span>
                    )}
                  </div>
                  <span className="text-xs font-serif font-semibold text-app-accent">
                    Câu {currentIndex + 1} / {exercises.length}
                  </span>
                </div>

                {/* Câu ca dao, tục ngữ nguyên bản tiếng Việt */}
                <div className="pt-1">
                  <p className="text-xs text-muted font-sans mb-1">Câu ca dao / tục ngữ gốc:</p>
                  <p className="text-lg sm:text-xl font-serif font-bold text-title leading-relaxed">
                    &ldquo;{currentExercise.vietnamese || currentExercise.meaning}&rdquo;
                  </p>
                </div>

                {/* Ý nghĩa và chú thích văn hóa nếu có */}
                {currentExercise.meaning && (
                  <p className="text-sm font-sans text-body leading-relaxed pt-2 border-t border-border/60">
                    <span className="font-semibold text-title">Ý nghĩa:</span> {currentExercise.meaning}
                    {currentExercise.culturalNote && (
                      <span className="text-muted block sm:inline sm:ml-1.5 mt-0.5 sm:mt-0">
                        • <em>{currentExercise.culturalNote}</em>
                      </span>
                    )}
                  </p>
                )}
              </div>
            ) : (currentExercise.titleZh || currentExercise.titleVi) ? (
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
            ) : null}

            {/* Câu mục tiêu với từng ký tự hiển thị trực quan */}
            <div className="space-y-3 bg-page/70 border border-border/70 rounded-xl p-3.5 sm:p-4 md:p-6">
              {/* Pinyin hỗ trợ kèm đồng bộ highlight từng từ khi phát âm */}
              {preferences.showPinyin && (
                <div className="flex items-center justify-between gap-2">
                  {exerciseWordTokens.length > 0 && exerciseWordTokens.some((w) => w.pinyin) ? (
                    <div className="flex flex-wrap items-baseline gap-x-1.5 gap-y-0.5 select-none leading-relaxed text-sm md:text-base font-sans">
                      {exerciseWordTokens.map((w, wIdx) => {
                        const activeSentence =
                          speakingSentenceIndex !== null && chineseSentences[speakingSentenceIndex]
                            ? chineseSentences[speakingSentenceIndex]
                            : null

                        const isTokenInSpeakingSentence = activeSentence
                          ? w.startIndex < activeSentence.endIndex && w.endIndex > activeSentence.startIndex
                          : false

                        const isWordActive = speakingWordIndex === wIdx && w.isWord
                        const isWordPast = speakingWordIndex !== null && wIdx < speakingWordIndex && isTokenInSpeakingSentence && w.isWord
                        const isSentenceFallback = isTokenInSpeakingSentence && speakingWordIndex === null && w.isWord

                        if (!w.pinyin) return null

                        return (
                          <span
                            key={wIdx}
                            className={`transition-colors duration-150 rounded px-1 ${
                              isWordActive
                                ? 'text-amber-950 dark:text-amber-100 font-bold bg-amber-200/80 dark:bg-amber-900/60 ring-1 ring-amber-400/80 shadow-2xs'
                                : isSentenceFallback
                                ? 'text-amber-900 dark:text-amber-200 font-semibold bg-amber-100/70 dark:bg-amber-950/40 ring-1 ring-amber-300/50 dark:ring-amber-800/40'
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
                /* Khi bật Ẩn chữ Hán: Người học nghe phát âm và gõ chữ Hán (ẩn chữ mẫu, hiện ký tự đã gõ và con trỏ) */
                <div className="space-y-2">
                  <div className="flex flex-wrap items-baseline gap-1 py-1">
                    {currentExercise.hanzi.split('').map((char, idx) => {
                      const typedChar = userInput[idx]
                      const isTyped = idx < userInput.length
                      const isCurrent = idx === userInput.length
                      const isCorrect = isTyped && isCharMatch(typedChar, char, preferences.normalizePunctuation)

                      if (isTyped) {
                        return (
                          <span
                            key={idx}
                            className={`inline-block px-1 rounded transition-colors ${
                              isCorrect
                                ? 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 font-bold'
                                : 'bg-red-500/20 text-red-600 dark:text-red-400 underline font-bold'
                            }`}
                          >
                            {isCorrect ? char : typedChar}
                          </span>
                        )
                      } else if (isCurrent) {
                        return (
                          <span
                            key={idx}
                            className="inline-block px-1 border-b-2 border-app-accent bg-accent-soft/40 text-app-accent font-bold animate-pulse"
                          >
                            _
                          </span>
                        )
                      } else {
                        return (
                          <span
                            key={idx}
                            className="inline-block px-1 text-muted/30 select-none"
                          >
                            ●
                          </span>
                        )
                      }
                    })}
                  </div>
                  <div className="flex items-center gap-2 text-xs text-muted font-serif pt-1 select-none flex-wrap">
                    <span className="inline-flex items-center gap-1 text-amber-700 dark:text-amber-400 font-medium">
                      <Headphones className="w-3.5 h-3.5" />
                      Chữ Hán đang ẩn — Lắng nghe phát âm và gõ
                    </span>
                    <span>•</span>
                    <span>Phím tắt nghe lại: <kbd className="px-1.5 py-0.5 rounded bg-card border border-border text-[11px] font-mono">Ctrl + Space</kbd></span>
                  </div>
                </div>
              ) : exerciseWordTokens.length > 0 ? (
                  <div className="flex flex-wrap items-baseline gap-y-1">
                    {exerciseWordTokens.map((w, wIdx) => {
                      const activeSentence =
                        speakingSentenceIndex !== null && chineseSentences[speakingSentenceIndex]
                          ? chineseSentences[speakingSentenceIndex]
                          : null

                      const isTokenInSpeakingSentence = activeSentence
                        ? w.startIndex < activeSentence.endIndex && w.endIndex > activeSentence.startIndex
                        : false

                      const isWordActive = speakingWordIndex === wIdx && w.isWord
                      const isWordPast = speakingWordIndex !== null && wIdx < speakingWordIndex && isTokenInSpeakingSentence && w.isWord
                      const isSentenceFallback = isTokenInSpeakingSentence && speakingWordIndex === null && w.isWord

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
                              : isSentenceFallback
                              ? 'bg-amber-50 dark:bg-amber-950/30 ring-1 ring-amber-300/40 text-title font-medium'
                              : isWordPast
                              ? 'opacity-85'
                              : ''
                          }`}
                        >
                          {w.text.split('').map((char, cOffset) => {
                            const idx = w.startIndex + cOffset
                            const typedChar = userInput[idx]
                            const isCurrent = idx === userInput.length && !isCompleted

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
                            } else if (isSentenceFallback) {
                              // Chế độ fallback cấp câu: Tô sáng toàn bộ câu đang phát âm
                              statusClasses = 'text-title font-semibold'
                            } else if (isTokenInSpeakingSentence) {
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
                      statusClasses = 'bg-amber-100/80 text-amber-900 dark:bg-amber-950/50 dark:text-amber-200 font-semibold rounded px-0.5 ring-1 ring-amber-400/50'
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
                  className="w-full p-4 bg-card border-2 border-[#E9DDD1] focus:border-app-accent focus:ring-4 focus:ring-app-accent/10 rounded-2xl text-xl md:text-2xl font-hanzi text-title placeholder:text-muted placeholder:text-sm placeholder:font-sans focus:outline-none transition-all shadow-inner resize-none"
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
                      : mode === 'sentence'
                      ? 'Bật bộ gõ Pinyin IME, gõ pinyin rồi chọn đúng chữ Hán...'
                      : 'Bật bộ gõ tiếng Trung (Pinyin), gõ pinyin rồi chọn chữ Hán tương ứng...'
                  }
                  className="w-full px-4 py-3.5 min-h-[52px] bg-card border-2 border-[#E9DDD1] focus:border-app-accent focus:ring-4 focus:ring-app-accent/10 rounded-2xl text-xl md:text-2xl font-hanzi text-title placeholder:text-muted placeholder:text-sm placeholder:font-sans focus:outline-none transition-all shadow-inner"
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

                <div className="hidden sm:flex items-center gap-2">
                  <button
                    onClick={resetExercise}
                    className="flex items-center gap-1.5 px-3.5 sm:px-4 py-2 bg-[#FFF9F3] border border-[#E9DDD1] hover:border-[#DDD0C2] hover:bg-[#F6EDE3] rounded-xl text-xs md:text-sm font-serif text-[#243047] transition-all active:scale-[0.98] touch-manipulation min-h-[44px] shadow-2xs cursor-pointer"
                  >
                    <RotateCcw className="w-4 h-4" />
                    <span>Làm lại</span>
                  </button>
                  <button
                    onClick={handleNext}
                    disabled={currentIndex >= exercises.length - 1}
                    className="flex items-center gap-1.5 px-4 py-2 bg-[#B8322D] hover:bg-[#982923] disabled:opacity-45 disabled:cursor-not-allowed text-white rounded-xl text-xs md:text-sm font-serif font-medium transition-all shadow-2xs active:scale-[0.98] touch-manipulation min-h-[44px] cursor-pointer"
                  >
                    <span>{currentIndex >= exercises.length - 1 ? 'Đã hết câu' : 'Câu tiếp theo'}</span>
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
          <div className="flex items-center justify-between gap-2 pt-2 pb-6 md:pb-2">
            <button
              onClick={handlePrev}
              disabled={currentIndex === 0}
              className="flex items-center gap-1.5 px-3 py-2 text-xs md:text-sm text-[#243047] hover:text-[#B8322D] disabled:opacity-35 disabled:cursor-not-allowed disabled:hover:text-[#243047] font-serif transition-colors active:scale-[0.98] touch-manipulation min-h-[44px] rounded-xl cursor-pointer"
            >
              <ArrowLeft className="w-4 h-4 shrink-0" />
              <span>Câu trước</span>
            </button>

            <div className="flex items-center gap-2">
              <button
                onClick={resetExercise}
                className="flex items-center gap-1.5 px-3 sm:px-3.5 py-2 bg-[#FFF9F3] border border-[#E9DDD1] hover:border-[#DDD0C2] hover:bg-[#F6EDE3] rounded-xl text-xs md:text-sm font-serif text-[#243047] transition-all active:scale-[0.98] touch-manipulation min-h-[44px] shadow-2xs cursor-pointer"
                title="Làm lại từ đầu"
              >
                <RotateCcw className="w-4 h-4 shrink-0" />
                <span className="hidden sm:inline">Làm lại</span>
              </button>

              {!isCompleted && (
                <button
                  onClick={handleFinish}
                  disabled={userInput.length === 0}
                  className="flex items-center gap-1.5 px-3.5 sm:px-4 py-2 bg-[#243047] text-white hover:bg-[#1A2436] disabled:opacity-40 disabled:cursor-not-allowed rounded-xl text-xs md:text-sm font-serif transition-all active:scale-[0.98] touch-manipulation min-h-[44px] shadow-2xs cursor-pointer"
                >
                  <CheckCircle2 className="w-4 h-4 shrink-0" />
                  <span>Kiểm tra</span>
                </button>
              )}

              <button
                onClick={handleNext}
                disabled={currentIndex >= exercises.length - 1 && isCompleted}
                className="flex items-center gap-1.5 px-3.5 sm:px-4 py-2 bg-[#B8322D] hover:bg-[#982923] disabled:opacity-45 disabled:cursor-not-allowed text-white rounded-xl text-xs md:text-sm font-serif font-medium transition-all shadow-2xs active:scale-[0.98] touch-manipulation min-h-[44px] cursor-pointer"
              >
                <span className="truncate">
                  {currentIndex >= exercises.length - 1
                    ? 'Hoàn thành'
                    : mode === 'sentence' ? 'Câu tiếp' : 'Tiếp theo'}
                </span>
                <ArrowRight className="w-4 h-4 shrink-0" />
              </button>
            </div>
          </div>
        </div>
      </div>
      ) : (
        <div className="p-12 text-center bg-card border border-border rounded-xl space-y-3">
          {loadingExercises ? (
            <>
              <Loader2 className="w-8 h-8 text-app-accent animate-spin mx-auto" />
              <h3 className="text-base font-serif font-medium text-title">Đang tải bài tập từ cơ sở dữ liệu...</h3>
              <p className="text-xs text-muted font-serif">Vui lòng chờ giây lát</p>
            </>
          ) : (
            <>
              <BookOpen className="w-10 h-10 text-muted mx-auto" />
              <h3 className="text-base font-serif font-medium text-title">Chưa có bài tập cho mục này</h3>
              <p className="text-xs text-muted font-serif">
                {onlyUnlearnedFilter
                  ? 'Tuyệt vời! Bạn không có từ vựng nào chưa thuộc trong danh mục này.'
                  : 'Vui lòng chọn phân loại hoặc bài học khác.'}
              </p>
              {onlyUnlearnedFilter && (
                <button
                  onClick={() => {
                    setOnlyUnlearnedFilter(false)
                    resetExercise()
                  }}
                  className="px-3.5 py-1.5 rounded-lg bg-app-accent text-white text-xs font-serif shadow-xs hover:bg-accent-hover transition-colors"
                >
                  Xem tất cả từ vựng
                </button>
              )}
            </>
          )}
        </div>
      )}
      </>
      )}
      </>
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
