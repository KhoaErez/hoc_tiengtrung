'use client'

import { useState, useEffect, useRef, useMemo, useCallback } from 'react'
import {
  CustomTypingExercise,
  TypingSegment,
  getCustomExercises,
  saveCustomExercise,
  deleteCustomExercise,
  updateCustomExerciseTitle,
  updateCustomExerciseResult,
  updateCustomExerciseSegments,
  saveTypingSession,
  TypingSession,
  getTypingPreferences,
  saveTypingPreferences,
} from '@/lib/typing-storage'
import { mapSegmentsToIndices } from '@/lib/typing-gemini-validator'
import {
  ChineseSentenceItem,
  extractChineseSentences,
  findCurrentSentenceIndex,
  playTypingSfx,
  getChineseVoices,
  speakChineseCharacter,
} from '@/lib/typing-sound'
import {
  ChineseWordToken,
  segmentChineseText,
  segmentAndAlignChinese,
  findWordIndexByCharIndex,
} from '@/lib/tts/chinese-word-segmenter'
import { ttsEngine } from '@/lib/tts/tts-engine'
import TypingGeminiModal from './typing-gemini-modal'
import TypingAudioControls from './typing-audio-controls'
import { toast } from 'sonner'
import {
  FileText,
  Plus,
  Trash2,
  Play,
  RotateCcw,
  CheckCircle2,
  XCircle,
  Eye,
  EyeOff,
  Clock,
  Zap,
  Target,
  Award,
  Edit2,
  ArrowLeft,
  Check,
  AlertTriangle,
  Sparkles,
  HelpCircle,
  Sliders,
  Volume2,
  VolumeX,
  Languages,
  BookOpen,
  Layers,
} from 'lucide-react'
import { Button } from '@/components/ui/button'

// Hàm chuẩn hóa ký tự dấu câu
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

function isCharMatch(c1: string, c2: string, allowNormalize = true): boolean {
  if (!c1 || !c2) return false
  if (c1 === c2) return true
  if (allowNormalize) {
    return normalizeChar(c1) === normalizeChar(c2)
  }
  return false
}

// Mẫu văn bản gợi ý nhanh cho người dùng
const SAMPLE_TEMPLATES = [
  {
    name: 'Hội thoại ngắn',
    title: 'Hội thoại hỏi thăm giáo viên',
    content: `王明：你好，请问李老师在办公室吗？
张华：在的，他正在备课。你有什么事找他吗？
王明：我想请教几个关于语法的问题。
张华：那你快进去吧，他正好有空。`,
  },
  {
    name: 'Đoạn văn nhiều đoạn',
    title: 'Hành trình học tiếng Trung',
    content: `学习一门新的语言就像打开了一扇通往新世界的窗户。刚开始的时候，汉字对我来说就像一幅幅神秘的图画，既复杂又优美。

每天坚持晨读和听力练习，让我在不知不觉中积累了信心。如今，我已经能用普通话与朋友们无障碍地交流日常话题了。

千里之行，始于足下。只要保持热爱，每天都在进步！`,
  },
  {
    name: 'Hỗn hợp Hán - Việt - Anh',
    title: 'Thông báo thi HSK 2026',
    content: `2026年HSK考试时间已经正式公布。
Buổi thi HSK 4 sẽ bắt đầu lúc 09:00 sáng tại phòng thi A203.
Please make sure to bring your student card and 2B pencils!
祝大家考试顺利，取得优异成绩！`,
  },
]

export default function CustomParagraphMode({
  onSessionComplete,
}: {
  onSessionComplete?: () => void
}) {
  // Trạng thái màn hình: 'editor' (tạo bài/danh sách) | 'practice' (đang luyện)
  const [viewState, setViewState] = useState<'editor' | 'practice'>('editor')

  // Tab con trong Editor: 'create' | 'saved'
  const [editorSubTab, setEditorSubTab] = useState<'create' | 'saved'>('create')

  // Danh sách bài đã lưu từ localStorage
  const [savedExercises, setSavedExercises] = useState<CustomTypingExercise[]>([])

  // Form tạo bài
  const [inputTitle, setInputTitle] = useState('')
  const [inputText, setInputText] = useState('')
  const [formError, setFormError] = useState('')
  const [activeExerciseId, setActiveExerciseId] = useState<string | null>(null)

  // Dữ liệu Pinyin & Nghĩa trong form Editor
  const [editorSegments, setEditorSegments] = useState<TypingSegment[]>([])
  const [editorHasPinyinAndMeaning, setEditorHasPinyinAndMeaning] = useState(false)
  const [editorIsOutdated, setEditorIsOutdated] = useState(false)
  const [editorAnalyzedText, setEditorAnalyzedText] = useState('')

  // Đổi tên bài tập
  const [editingId, setEditingId] = useState<string | null>(null)
  const [editingTitleText, setEditingTitleText] = useState('')

  // Trạng thái bài đang luyện
  const [currentText, setCurrentText] = useState('')
  const [currentTitle, setCurrentTitle] = useState('')
  const [currentExerciseId, setCurrentExerciseId] = useState<string | null>(null)
  const [currentSegments, setCurrentSegments] = useState<TypingSegment[]>([])
  const [currentHasPinyinAndMeaning, setCurrentHasPinyinAndMeaning] = useState(false)
  const [currentIsOutdated, setCurrentIsOutdated] = useState(false)

  // Tùy chọn hiển thị 3 lớp (Pinyin, Nghĩa)
  const [showPinyin, setShowPinyin] = useState(true)
  const [showMeaning, setShowMeaning] = useState(true)

  // Trạng thái mở Modal Gemini cá nhân
  const [isGeminiModalOpen, setIsGeminiModalOpen] = useState(false)
  const [geminiModalTarget, setGeminiModalTarget] = useState<{
    text: string;
    title?: string;
    isForEditor: boolean;
    savedExerciseId?: string;
  }>({ text: '', isForEditor: true })

  // Trạng thái nhập liệu & IME
  const [userInput, setUserInput] = useState('')
  const [isComposing, setIsComposing] = useState(false)
  const [compositionText, setCompositionText] = useState('')
  const inputRef = useRef<HTMLTextAreaElement | null>(null)
  const editorTextareaRef = useRef<HTMLTextAreaElement | null>(null)

  // Thời gian & Trạng thái luyện tập
  const [isStarted, setIsStarted] = useState(false)
  const [isCompleted, setIsCompleted] = useState(false)
  const [elapsedSeconds, setElapsedSeconds] = useState(0)
  const timerRef = useRef<NodeJS.Timeout | null>(null)

  // Tùy chọn luyện tập
  const [strictMode, setStrictMode] = useState(true) // Mặc định: kiểm tra nghiêm ngặt
  const [hideSample, setHideSample] = useState(false)
  const [normalizePunctuation, setNormalizePunctuation] = useState(true)
  const [soundEnabled, setSoundEnabled] = useState(true)
  const [showErrorDetails, setShowErrorDetails] = useState(false)

  // Trạng thái âm thanh phát âm tiếng Trung (Web Speech API)
  const [speechStatus, setSpeechStatus] = useState<'idle' | 'playing' | 'paused'>('idle')
  const [speakingSentenceIndex, setSpeakingSentenceIndex] = useState<number | null>(null)
  const [speakingWordIndex, setSpeakingWordIndex] = useState<number | null>(null)
  const [readingMode, setReadingMode] = useState<'all' | 'sentence' | null>(null)
  const [speechRate, setSpeechRate] = useState<number>(1)
  const [selectedVoiceURI, setSelectedVoiceURI] = useState<string>('')
  const [availableVoices, setAvailableVoices] = useState<SpeechSynthesisVoice[]>([])
  const [hasVoiceWarning, setHasVoiceWarning] = useState<boolean>(false)
  const [autoSpeakNext, setAutoSpeakNext] = useState<boolean>(false)

  const readingModeRef = useRef<'all' | 'sentence' | null>(null)
  const speechRateRef = useRef<number>(1)
  const selectedVoiceURIRef = useRef<string>('')
  const sentencesRef = useRef<ChineseSentenceItem[]>([])
  const autoSpeakNextRef = useRef<boolean>(false)
  const utteranceIdRef = useRef<number>(0)
  const wordElementsRef = useRef<Map<string, HTMLElement>>(new Map())
  const committedLengthRef = useRef<number>(0)
  const isComposingRef = useRef<boolean>(false)

  // Load danh sách bài tập đã lưu và tùy chọn âm thanh
  useEffect(() => {
    setSavedExercises(getCustomExercises())

    const prefs = getTypingPreferences()
    if (prefs.typingSoundEnabled !== undefined) setSoundEnabled(prefs.typingSoundEnabled)
    const initialRate = prefs.speechRate || ttsEngine.getRate()
    setSpeechRate(initialRate)
    speechRateRef.current = initialRate
    if (prefs.autoSpeakNext !== undefined) {
      setAutoSpeakNext(prefs.autoSpeakNext)
      autoSpeakNextRef.current = prefs.autoSpeakNext
    }
    if (prefs.preferredVoiceURI) {
      setSelectedVoiceURI(prefs.preferredVoiceURI)
      selectedVoiceURIRef.current = prefs.preferredVoiceURI
    }

    if (typeof window !== 'undefined' && window.speechSynthesis) {
      const updateVoices = () => {
        const voices = getChineseVoices()
        setAvailableVoices(voices)
        if (voices.length > 0) {
          setHasVoiceWarning(false)
          if (!selectedVoiceURIRef.current) {
            setSelectedVoiceURI(voices[0].voiceURI)
            selectedVoiceURIRef.current = voices[0].voiceURI
          }
        } else {
          const allVoices = window.speechSynthesis.getVoices()
          if (allVoices.length > 0) {
            setHasVoiceWarning(true)
          }
        }
      }

      updateVoices()
      if (window.speechSynthesis.onvoiceschanged !== undefined) {
        window.speechSynthesis.onvoiceschanged = updateVoices
      }
    }

    return () => {
      if (typeof window !== 'undefined' && window.speechSynthesis) {
        window.speechSynthesis.cancel()
        window.speechSynthesis.onvoiceschanged = null
      }
    }
  }, [])

  // Timer đếm giây
  useEffect(() => {
    if (isStarted && !isCompleted) {
      timerRef.current = setInterval(() => {
        setElapsedSeconds((prev) => prev + 1)
      }, 1000)
    } else if (timerRef.current) {
      clearInterval(timerRef.current)
    }

    return () => {
      if (timerRef.current) clearInterval(timerRef.current)
    }
  }, [isStarted, isCompleted])

  // Thống kê ký tự và dòng của input trong form
  const inputStats = useMemo(() => {
    const chars = inputText.length
    const lines = inputText ? inputText.split(/\r\n|\r|\n/).length : 0
    return { chars, lines }
  }, [inputText])

  // So sánh đánh giá văn bản người dùng với văn bản gốc
  const evaluation = useMemo(() => {
    const target = currentText
    const input = userInput

    if (!target) {
      return {
        correctCount: 0,
        errorCount: 0,
        missingCount: 0,
        totalTargetChars: 0,
        accuracy: 100,
        cpm: 0,
        errors: [] as { index: number; expected: string; actual: string }[],
      }
    }

    if (strictMode) {
      // 1. CHẾ ĐỘ NGHIÊM NGẶT: So khớp từng ký tự, tính cả khoảng trắng, xuống dòng, dấu câu
      let correct = 0
      const errors: { index: number; expected: string; actual: string }[] = []
      const minLen = Math.min(input.length, target.length)

      for (let i = 0; i < minLen; i++) {
        const tChar = target[i]
        const iChar = input[i]

        if (isCharMatch(iChar, tChar, normalizePunctuation)) {
          correct++
        } else {
          errors.push({
            index: i + 1,
            expected: tChar === '\n' ? '↵ (Xuống dòng)' : tChar === ' ' ? '␣ (Khoảng trắng)' : tChar,
            actual: iChar === '\n' ? '↵ (Xuống dòng)' : iChar === ' ' ? '␣ (Khoảng trắng)' : iChar,
          })
        }
      }

      // Ký tự gõ thừa
      if (input.length > target.length) {
        for (let i = target.length; i < input.length; i++) {
          errors.push({
            index: i + 1,
            expected: '(thừa)',
            actual: input[i] === '\n' ? '↵ (Xuống dòng)' : input[i] === ' ' ? '␣ (Khoảng trắng)' : input[i],
          })
        }
      }

      const missingCount = Math.max(0, target.length - input.length)
      const accuracy =
        input.length > 0 ? Math.max(0, Math.round((correct / Math.max(target.length, input.length)) * 100)) : 100

      const minutes = Math.max(elapsedSeconds, 1) / 60
      const cpm = Math.round(correct / minutes)

      return {
        correctCount: correct,
        errorCount: errors.length,
        missingCount,
        totalTargetChars: target.length,
        accuracy,
        cpm,
        errors,
      }
    } else {
      // 2. CHẾ ĐỘ NỘI DUNG: Bỏ qua khác biệt về khoảng trắng hoặc xuống dòng thừa
      const isWhitespace = (ch: string) => /\s/.test(ch)

      const targetNonSpace: { char: string; origIndex: number }[] = []
      for (let i = 0; i < target.length; i++) {
        if (!isWhitespace(target[i])) {
          targetNonSpace.push({ char: target[i], origIndex: i })
        }
      }

      const inputNonSpace: { char: string; origIndex: number }[] = []
      for (let i = 0; i < input.length; i++) {
        if (!isWhitespace(input[i])) {
          inputNonSpace.push({ char: input[i], origIndex: i })
        }
      }

      let correct = 0
      const errors: { index: number; expected: string; actual: string }[] = []
      const minLen = Math.min(inputNonSpace.length, targetNonSpace.length)

      for (let i = 0; i < minLen; i++) {
        const t = targetNonSpace[i]
        const inp = inputNonSpace[i]

        if (isCharMatch(inp.char, t.char, normalizePunctuation)) {
          correct++
        } else {
          errors.push({
            index: inp.origIndex + 1,
            expected: t.char,
            actual: inp.char,
          })
        }
      }

      if (inputNonSpace.length > targetNonSpace.length) {
        for (let i = targetNonSpace.length; i < inputNonSpace.length; i++) {
          errors.push({
            index: inputNonSpace[i].origIndex + 1,
            expected: '(thừa)',
            actual: inputNonSpace[i].char,
          })
        }
      }

      const missingCount = Math.max(0, targetNonSpace.length - inputNonSpace.length)
      const accuracy =
        inputNonSpace.length > 0
          ? Math.max(0, Math.round((correct / Math.max(targetNonSpace.length, inputNonSpace.length)) * 100))
          : 100

      const minutes = Math.max(elapsedSeconds, 1) / 60
      const cpm = Math.round(correct / minutes)

      return {
        correctCount: correct,
        errorCount: errors.length,
        missingCount,
        totalTargetChars: targetNonSpace.length,
        accuracy,
        cpm,
        errors,
      }
    }
  }, [currentText, userInput, elapsedSeconds, strictMode, normalizePunctuation])

  // Tính toán mapping các khối 3 lớp (Chữ Hán - Pinyin - Nghĩa)
  const mappedBlocks = useMemo(() => {
    if (!currentHasPinyinAndMeaning || !currentSegments || currentSegments.length === 0) {
      return []
    }
    return mapSegmentsToIndices(currentText, currentSegments)
  }, [currentText, currentSegments, currentHasPinyinAndMeaning])

  // Phân đoạn từ tiếng Trung và căn chỉnh Pinyin 1-1 cho từng khối câu
  const tokenizedBlocks = useMemo(() => {
    return mappedBlocks.map((b) => {
      const sentenceText = b.segment.chinese || currentText.slice(b.startIndex, b.endIndex)
      const words = segmentAndAlignChinese(sentenceText, b.segment.pinyin)
      return {
        ...b,
        words,
      }
    })
  }, [mappedBlocks, currentText])

  // Phân đoạn từ cho văn bản thuần nếu chưa có mappedBlocks
  const rawWords = useMemo(() => {
    if (mappedBlocks.length > 0) return []
    return segmentChineseText(currentText)
  }, [mappedBlocks.length, currentText])

  // Phân tách câu tiếng Trung cho mục đích phát âm & theo dõi vị trí câu
  const chineseSentences = useMemo(() => {
    return extractChineseSentences(currentText, mappedBlocks)
  }, [currentText, mappedBlocks])

  useEffect(() => {
    sentencesRef.current = chineseSentences
  }, [chineseSentences])

  // Câu người dùng đang gõ hiện tại
  const currentTypingSentenceIndex = useMemo(() => {
    return findCurrentSentenceIndex(chineseSentences, userInput.length)
  }, [chineseSentences, userInput.length])

  // Dừng phát âm thanh ngay lập tức
  const stopSpeech = useCallback(() => {
    utteranceIdRef.current++
    if (typeof window !== 'undefined' && window.speechSynthesis) {
      window.speechSynthesis.cancel()
    }
    readingModeRef.current = null
    setReadingMode(null)
    setSpeechStatus('idle')
    setSpeakingSentenceIndex(null)
    setSpeakingWordIndex(null)
  }, [])

  // Dọn dẹp âm thanh khi component unmount hoặc khi nhận tín hiệu dừng âm thanh toàn cục (chuyển trang)
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

  // Phát âm một câu cụ thể kèm Word-Level Highlighting
  const speakSentence = useCallback(
    (index: number, isSequential: boolean = false) => {
      if (typeof window === 'undefined' || !window.speechSynthesis) return
      const list = sentencesRef.current
      if (!list || index < 0 || index >= list.length) {
        stopSpeech()
        return
      }

      window.speechSynthesis.cancel()

      const currentUtteranceId = ++utteranceIdRef.current
      const item = list[index]
      setSpeakingSentenceIndex(index)
      setSpeakingWordIndex(0)
      setSpeechStatus('playing')

      const utterance = new SpeechSynthesisUtterance(item.text)
      utterance.lang = 'zh-CN'
      utterance.rate = speechRateRef.current

      const voices = getChineseVoices()
      const voice =
        voices.find((v) => v.voiceURI === selectedVoiceURIRef.current) ||
        voices[0]
      if (voice) utterance.voice = voice

      // Lấy danh sách từ của câu này để ánh xạ charIndex
      const sentenceWords = tokenizedBlocks[index]?.words || segmentChineseText(item.text)

      // Đồng bộ từ ngữ theo thời gian thực qua sự kiện onboundary (Zero scroll-fighting)
      utterance.onboundary = (event) => {
        if (currentUtteranceId !== utteranceIdRef.current) return
        const charIndex = event.charIndex
        const wordIdx = findWordIndexByCharIndex(sentenceWords, charIndex)
        if (wordIdx !== -1) {
          setSpeakingWordIndex((prev) => (prev === wordIdx ? prev : wordIdx))
        }
      }

      utterance.onend = () => {
        if (currentUtteranceId !== utteranceIdRef.current) return
        setSpeakingWordIndex(null)
        if (readingModeRef.current === 'all' && isSequential) {
          if (index + 1 < list.length) {
            speakSentence(index + 1, true)
          } else {
            stopSpeech()
          }
        } else {
          setSpeechStatus('idle')
          setSpeakingSentenceIndex(null)
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
    [tokenizedBlocks, stopSpeech]
  )

  const handlePlayAll = useCallback(() => {
    if (chineseSentences.length === 0) return
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
    speakSentence(0, true)
  }, [chineseSentences, availableVoices, speakSentence])

  const handlePlayCurrentSentence = useCallback(() => {
    if (chineseSentences.length === 0) return
    readingModeRef.current = 'sentence'
    setReadingMode('sentence')
    speakSentence(currentTypingSentenceIndex, false)
  }, [chineseSentences, currentTypingSentenceIndex, speakSentence])

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
    ttsEngine.setRate(rate as any)
    saveTypingPreferences({ speechRate: rate })

    // Nếu đang phát âm, phát lại ngay với tốc độ mới
    if (speechStatus === 'playing' && speakingSentenceIndex !== null) {
      speakSentence(speakingSentenceIndex, readingModeRef.current === 'all')
    }
  }

  const handleVoiceChange = (uri: string) => {
    setSelectedVoiceURI(uri)
    selectedVoiceURIRef.current = uri
    saveTypingPreferences({ preferredVoiceURI: uri })
  }

  const handleToggleTypingSound = () => {
    const nextVal = !soundEnabled
    setSoundEnabled(nextVal)
    saveTypingPreferences({ typingSoundEnabled: nextVal, soundEffects: nextVal })
  }

  const handleToggleAutoSpeakNext = () => {
    const nextVal = !autoSpeakNext
    setAutoSpeakNext(nextVal)
    autoSpeakNextRef.current = nextVal
    saveTypingPreferences({ autoSpeakNext: nextVal })
  }

  // Hàm render từng ký tự kèm trạng thái tô màu realtime & highlight âm thanh
  const renderCharSpan = (char: string, idx: number, isWordHighlight = false) => {
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

    let charStyle = 'text-title/80'

    if (idx < userInput.length) {
      if (isCharMatch(typedChar, char, normalizePunctuation)) {
        charStyle = 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 rounded px-0.5'
      } else {
        charStyle = 'bg-red-500/20 text-red-600 dark:text-red-400 rounded px-0.5 underline decoration-red-500 font-bold'
      }
    } else if (isCurrent) {
      charStyle = 'border-b-2 border-app-accent bg-accent-soft/40 text-title font-bold animate-pulse'
    } else if (isWordHighlight) {
      charStyle = 'text-amber-950 dark:text-amber-100 font-bold'
    } else if (isCharBeingSpoken) {
      charStyle = 'text-title/85'
    }

    if (char === '\n') {
      return (
        <span key={idx} className={charStyle}>
          {'\n'}
        </span>
      )
    }

    return (
      <span key={idx} className={`inline-block transition-colors ${charStyle}`}>
        {char}
      </span>
    )
  }

  // Bắt đầu vào bài luyện
  const startPractice = (
    text: string,
    title?: string,
    exerciseId?: string | null,
    segments?: TypingSegment[],
    hasPinyin?: boolean,
    isOutdated?: boolean
  ) => {
    if (!text.trim()) {
      setFormError('Nội dung văn bản không được để trống.')
      return
    }

    stopSpeech()
    setFormError('')
    setCurrentText(text)
    setCurrentTitle(title || text.split(/\r\n|\r|\n/)[0]?.slice(0, 30) || 'Bài luyện tự tạo')
    setCurrentExerciseId(exerciseId || null)
    setCurrentSegments(segments || [])
    setCurrentHasPinyinAndMeaning(hasPinyin ?? (segments ? segments.length > 0 : false))
    setCurrentIsOutdated(isOutdated ?? false)

    // Reset trạng thái
    committedLengthRef.current = 0
    isComposingRef.current = false
    setUserInput('')
    setIsStarted(false)
    setIsCompleted(false)
    setElapsedSeconds(0)
    setIsComposing(false)
    setCompositionText('')
    setViewState('practice')

    setTimeout(() => {
      inputRef.current?.focus()
    }, 100)
  }

  // Xử lý tạo bài từ form
  const handleCreateAndStart = () => {
    if (!inputText.trim()) {
      setFormError('Vui lòng nhập hoặc dán nội dung văn bản muốn luyện đánh máy.')
      return
    }
    startPractice(
      inputText,
      inputTitle,
      activeExerciseId,
      editorSegments,
      editorHasPinyinAndMeaning,
      editorIsOutdated
    )
  }

  // Lưu bài luyện vào danh sách cá nhân
  const handleSaveExercise = () => {
    if (!inputText.trim()) {
      setFormError('Vui lòng nhập nội dung văn bản trước khi lưu.')
      return
    }

    const saved = saveCustomExercise({
      id: activeExerciseId || undefined,
      title: inputTitle,
      content: inputText,
      segments: editorSegments,
      hasPinyinAndMeaning: editorHasPinyinAndMeaning,
      isOutdated: editorIsOutdated,
    })

    setActiveExerciseId(saved.id)
    setSavedExercises(getCustomExercises())
    setFormError('')
    toast.success('Đã lưu bài luyện vào danh sách thành công!')
  }

  // Xóa nội dung trên form
  const handleClearForm = () => {
    setInputText('')
    setInputTitle('')
    setActiveExerciseId(null)
    setEditorSegments([])
    setEditorHasPinyinAndMeaning(false)
    setEditorIsOutdated(false)
    setEditorAnalyzedText('')
    setFormError('')
  }

  // Áp dụng mẫu văn bản gợi ý
  const handleApplyTemplate = (tpl: (typeof SAMPLE_TEMPLATES)[0]) => {
    setInputTitle(tpl.title)
    setInputText(tpl.content)
    setActiveExerciseId(null)
    setEditorSegments([])
    setEditorHasPinyinAndMeaning(false)
    setEditorIsOutdated(false)
    setEditorAnalyzedText('')
    setFormError('')
  }

  // Xóa bài đã lưu
  const handleDeleteSaved = (id: string, title: string) => {
    if (confirm(`Bạn có chắc chắn muốn xóa bài luyện "${title}"?`)) {
      deleteCustomExercise(id)
      setSavedExercises(getCustomExercises())
    }
  }

  // Sửa tên bài đã lưu
  const handleStartRename = (ex: CustomTypingExercise) => {
    setEditingId(ex.id)
    setEditingTitleText(ex.title)
  }

  const handleSaveRename = (id: string) => {
    if (editingTitleText.trim()) {
      updateCustomExerciseTitle(id, editingTitleText.trim())
      setSavedExercises(getCustomExercises())
    }
    setEditingId(null)
  }

  // Quay lại sửa văn bản mục tiêu
  const handleEditTargetText = () => {
    stopSpeech()
    setInputText(currentText)
    setInputTitle(currentTitle)
    setActiveExerciseId(currentExerciseId)
    setEditorSegments(currentSegments)
    setEditorHasPinyinAndMeaning(currentHasPinyinAndMeaning)
    setEditorIsOutdated(currentIsOutdated)
    setEditorAnalyzedText(currentText)
    setViewState('editor')
    setEditorSubTab('create')
  }

  // Mở Gemini Modal cho form tạo bài
  const handleOpenGeminiModalForInput = () => {
    if (!inputText.trim()) {
      setFormError('Vui lòng nhập hoặc dán nội dung văn bản tiếng Trung vào ô bên dưới trước khi bổ sung Pinyin & Nghĩa.')
      toast.warning('Vui lòng dán hoặc nhập nội dung tiếng Trung vào ô văn bản trước khi bổ sung Pinyin & Nghĩa.')
      editorTextareaRef.current?.focus()
      return
    }
    setFormError('')
    setGeminiModalTarget({
      text: inputText,
      title: inputTitle || 'Văn bản tùy chỉnh',
      isForEditor: true,
      savedExerciseId: activeExerciseId || undefined,
    })
    setIsGeminiModalOpen(true)
  }

  // Mở Gemini Modal khi đang ở màn hình luyện bài
  const handleOpenGeminiForPractice = () => {
    setGeminiModalTarget({
      text: currentText,
      title: currentTitle,
      isForEditor: false,
      savedExerciseId: currentExerciseId || undefined,
    })
    setIsGeminiModalOpen(true)
  }

  // Mở Gemini Modal cho bài đã lưu trong danh sách
  const handleOpenGeminiForSavedItem = (ex: CustomTypingExercise) => {
    setGeminiModalTarget({
      text: ex.content,
      title: ex.title,
      isForEditor: false,
      savedExerciseId: ex.id,
    })
    setIsGeminiModalOpen(true)
  }

  // Khi modal trả về segments hợp lệ
  const handleApplySegmentsFromModal = (segments: TypingSegment[]) => {
    if (geminiModalTarget.isForEditor) {
      setEditorSegments(segments)
      setEditorHasPinyinAndMeaning(true)
      setEditorIsOutdated(false)
      setEditorAnalyzedText(geminiModalTarget.text)

      if (geminiModalTarget.savedExerciseId) {
        updateCustomExerciseSegments(geminiModalTarget.savedExerciseId, segments)
        setSavedExercises(getCustomExercises())
      }
    } else {
      setCurrentSegments(segments)
      setCurrentHasPinyinAndMeaning(true)
      setCurrentIsOutdated(false)
      setShowPinyin(true)
      setShowMeaning(true)

      if (geminiModalTarget.savedExerciseId) {
        updateCustomExerciseSegments(geminiModalTarget.savedExerciseId, segments)
        setSavedExercises(getCustomExercises())
      }
    }
  }

  // Hoàn thành bài luyện
  const handleCompletePractice = useCallback(() => {
    if (isCompleted) return
    setIsCompleted(true)
    if (timerRef.current) clearInterval(timerRef.current)
    stopSpeech()
    if (soundEnabled) {
      playTypingSfx('complete')
    }

    // Cập nhật kết quả vào bài tập nếu có
    if (currentExerciseId) {
      updateCustomExerciseResult(currentExerciseId, {
        accuracy: evaluation.accuracy,
        cpm: evaluation.cpm,
        date: new Date().toISOString(),
        timeSeconds: Math.max(elapsedSeconds, 1),
        correctChars: evaluation.correctCount,
        errorChars: evaluation.errorCount,
        missingChars: evaluation.missingCount,
      })
      setSavedExercises(getCustomExercises())
    }

    // Lưu vào lịch sử luyện tập chung
    const session: TypingSession = {
      id: Date.now().toString(),
      exerciseId: currentExerciseId || 'custom-unnamed',
      date: new Date().toISOString(),
      mode: 'paragraph',
      level: 'Tự tạo',
      timeSeconds: Math.max(elapsedSeconds, 1),
      targetChars: evaluation.totalTargetChars,
      correctChars: evaluation.correctCount,
      errorChars: evaluation.errorCount,
      accuracy: evaluation.accuracy,
      cpm: evaluation.cpm,
    }
    saveTypingSession(session)
    onSessionComplete?.()
  }, [isCompleted, currentExerciseId, evaluation, elapsedSeconds, onSessionComplete])

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

      // Kiểm tra tính chính xác của các ký tự vừa gõ
      let allCorrect = true
      for (let i = startIdx; i < endIdx; i++) {
        const targetChar = currentText[i]
        if (!targetChar || !isCharMatch(newVal[i], targetChar, normalizePunctuation)) {
          allCorrect = false
          break
        }
      }

      // Phát âm báo gõ phím nhẹ nhàng
      if (soundEnabled) {
        playTypingSfx(allCorrect ? 'correct' : 'error')
      }

      // Phát âm (TTS) chữ Hán vừa được gõ/chọn ngay lập tức
      const newlyTypedText = newVal.slice(startIdx, endIdx)
      if (soundEnabled && newlyTypedText.trim()) {
        speakChineseCharacter(newlyTypedText, selectedVoiceURIRef.current, speechRateRef.current)
      }

      // Tự đọc câu tiếp theo khi gõ xong câu hiện tại
      if (autoSpeakNextRef.current && chineseSentences.length > 1) {
        const curSentence = chineseSentences.find(
          (s) => prevLength < s.endIndex && newLength >= s.endIndex
        )
        if (curSentence && curSentence.index + 1 < chineseSentences.length) {
          speakSentence(curSentence.index + 1, false)
        }
      }
    },
    [
      isStarted,
      currentText,
      normalizePunctuation,
      soundEnabled,
      chineseSentences,
      speakSentence,
    ]
  )

  // Xử lý thay đổi ô nhập liệu (Direct input hoặc sau khi IME gõ)
  const handleInputChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    const val = e.target.value
    // Nếu đang trong quá trình soạn thảo IME (Pinyin composition), chỉ cập nhật text hiển thị tạm
    if (isComposingRef.current) {
      setUserInput(val)
      return
    }
    handleCommittedText(val)
  }

  // IME Events
  const handleCompositionStart = () => {
    isComposingRef.current = true
    setIsComposing(true)
    if (!isStarted) setIsStarted(true)
  }

  const handleCompositionUpdate = (e: React.CompositionEvent<HTMLTextAreaElement>) => {
    setCompositionText(e.data)
  }

  const handleCompositionEnd = (e: React.CompositionEvent<HTMLTextAreaElement>) => {
    isComposingRef.current = false
    setIsComposing(false)
    setCompositionText('')

    // Lấy giá trị chính xác đã được xác nhận từ DOM element
    const val = (e.target as HTMLTextAreaElement).value
    handleCommittedText(val)
  }

  // Làm lại bài
  const handleResetPractice = () => {
    stopSpeech()
    committedLengthRef.current = 0
    isComposingRef.current = false
    setUserInput('')
    setIsStarted(false)
    setIsCompleted(false)
    setElapsedSeconds(0)
    setIsComposing(false)
    setCompositionText('')
    setTimeout(() => {
      inputRef.current?.focus()
    }, 50)
  }

  // Định dạng thời gian
  const formatTime = (secs: number) => {
    const m = Math.floor(secs / 60)
    const s = secs % 60
    return `${m < 10 ? '0' : ''}${m}:${s < 10 ? '0' : ''}${s}`
  }

  // -------------------------------------------------------------
  // GIAO DIỆN CHÍNH (EDITOR HOẶC PRACTICE)
  // -------------------------------------------------------------
  return (
    <>
      {viewState === 'editor' ? (
        <div className="space-y-6">
        {/* Thanh chọn sub-tab: Tạo bài mới / Danh sách đã lưu */}
        <div className="flex items-center justify-between border-b border-border pb-3 flex-wrap gap-2">
          <div className="flex items-center gap-2">
            <button
              onClick={() => {
                stopSpeech()
                setEditorSubTab('create')
              }}
              className={`px-4 py-2 rounded-xl text-xs md:text-sm font-serif font-medium transition-all flex items-center gap-2 ${
                editorSubTab === 'create'
                  ? 'bg-title text-white shadow-xs font-bold'
                  : 'bg-card text-muted hover:text-title hover:bg-page border border-border'
              }`}
            >
              <Plus className="w-4 h-4" />
              <span>Tạo bài luyện mới</span>
            </button>

            <button
              onClick={() => {
                stopSpeech()
                setEditorSubTab('saved')
              }}
              className={`px-4 py-2 rounded-xl text-xs md:text-sm font-serif font-medium transition-all flex items-center gap-2 ${
                editorSubTab === 'saved'
                  ? 'bg-title text-white shadow-xs font-bold'
                  : 'bg-card text-muted hover:text-title hover:bg-page border border-border'
              }`}
            >
              <FileText className="w-4 h-4" />
              <span>Bài đã lưu ({savedExercises.length})</span>
            </button>
          </div>

          <p className="text-xs text-muted font-serif hidden sm:block">
            Hỗ trợ văn bản tiếng Trung, dấu câu, khoảng trắng và phân đoạn
          </p>
        </div>

        {/* Tab 1: Tạo bài luyện mới */}
        {editorSubTab === 'create' && (
          <div className="bg-card border border-border rounded-2xl p-5 md:p-8 space-y-6 shadow-2xs">
            <div className="space-y-1">
              <h3 className="font-serif font-bold text-lg text-title flex items-center gap-2">
                <Sparkles className="w-5 h-5 text-app-accent" />
                <span>Nhập văn bản mục tiêu cần luyện đánh máy</span>
              </h3>
              <p className="text-xs text-muted font-serif">
                Bạn có thể nhập hoặc dán bất kỳ bài báo, trích đoạn sách, lời bài hát hoặc đoạn văn tiếng Trung nào. Toàn bộ cấu trúc dấu câu, dòng và phân đoạn sẽ được giữ nguyên 100%.
              </p>
            </div>

            {/* Ô nhập tên bài luyện (tùy chọn) */}
            <div className="space-y-1.5">
              <label className="text-xs font-serif font-medium text-title">
                Tên bài luyện (tùy chọn):
              </label>
              <input
                type="text"
                value={inputTitle}
                onChange={(e) => setInputTitle(e.target.value)}
                placeholder="VD: Nhật ký buổi sáng, Đoạn văn HSK 4, v.v..."
                className="w-full px-4 py-2.5 rounded-xl border border-border bg-page text-title font-serif text-sm focus:outline-none focus:border-app-accent"
              />
            </div>

            {/* Ô nhập văn bản lớn */}
            <div className="space-y-1.5">
              <div className="flex items-center justify-between text-xs font-serif text-muted">
                <label className="font-medium text-title">Nội dung đoạn văn:</label>
                <div className="flex items-center gap-3">
                  <span>Số dòng: <strong className="text-title">{inputStats.lines}</strong></span>
                  <span>•</span>
                  <span>Số ký tự: <strong className="text-title">{inputStats.chars}</strong></span>
                  {inputStats.chars > 10000 && (
                    <span className="text-amber-600 dark:text-amber-400 flex items-center gap-1 font-semibold">
                      <AlertTriangle className="w-3.5 h-3.5" /> Quá 10.000 ký tự
                    </span>
                  )}
                </div>
              </div>

              <textarea
                ref={editorTextareaRef}
                value={inputText}
                onChange={(e) => {
                  const val = e.target.value
                  setInputText(val)
                  if (formError) setFormError('')
                  if (editorHasPinyinAndMeaning && editorAnalyzedText) {
                    if (val.trim() !== editorAnalyzedText.trim()) {
                      setEditorIsOutdated(true)
                    } else {
                      setEditorIsOutdated(false)
                    }
                  }
                }}
                rows={9}
                placeholder="Dán đoạn văn tiếng Trung bạn muốn luyện đánh máy vào đây... (Hỗ trợ nhiều đoạn, xuống dòng, dấu câu ，。！？ và ký tự Pinyin/Việt/Anh)"
                className="w-full p-4 rounded-xl border-2 border-border focus:border-app-accent bg-page text-title font-serif text-base md:text-lg placeholder:text-muted placeholder:text-sm focus:outline-none transition-colors shadow-inner leading-relaxed whitespace-pre-wrap"
                style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
              />

              {/* Thông báo trạng thái Pinyin & Nghĩa trong form nếu đã có */}
              {editorHasPinyinAndMeaning && (
                <div className="p-3.5 rounded-xl bg-app-accent-soft/30 border border-app-accent/30 flex flex-col sm:flex-row sm:items-center justify-between gap-2.5 text-xs font-serif">
                  <div className="flex items-center gap-2 text-title">
                    <CheckCircle2 className="w-4 h-4 text-jade flex-shrink-0" />
                    <span>
                      Đã có Pinyin & Nghĩa tiếng Việt cho <strong>{editorSegments.length} câu/đoạn</strong>.
                    </span>
                    {editorIsOutdated && (
                      <span className="text-amber-600 dark:text-amber-400 font-bold flex items-center gap-1">
                        <AlertTriangle className="w-3.5 h-3.5" /> (Văn bản đã sửa, cần phân tích lại)
                      </span>
                    )}
                  </div>
                  <Button
                    type="button"
                    variant="outline"
                    size="sm"
                    onClick={handleOpenGeminiModalForInput}
                    className="font-serif text-xs h-7 rounded-lg border-app-accent/60 text-app-accent hover:bg-app-accent hover:text-white"
                  >
                    <span>{editorIsOutdated ? 'Phân tích lại bằng Gemini' : 'Xem / Cập nhật lại'}</span>
                  </Button>
                </div>
              )}
            </div>

            {/* Báo lỗi nếu có */}
            {formError && (
              <div className="p-3 rounded-xl bg-red-500/10 border border-red-500/20 text-red-600 dark:text-red-400 text-xs font-serif flex items-center gap-2">
                <AlertTriangle className="w-4 h-4 flex-shrink-0" />
                <span>{formError}</span>
              </div>
            )}

            {/* Mẫu văn bản gợi ý nhanh */}
            <div className="space-y-2 pt-1 border-t border-border/70">
              <p className="text-xs font-serif text-muted">Thử nhanh bằng văn bản mẫu có sẵn:</p>
              <div className="flex flex-wrap gap-2">
                {SAMPLE_TEMPLATES.map((tpl, i) => (
                  <button
                    key={i}
                    onClick={() => handleApplyTemplate(tpl)}
                    className="px-3 py-1.5 rounded-lg border border-border bg-page hover:border-app-accent/40 text-xs font-serif text-body hover:text-title transition-colors"
                  >
                    + {tpl.name}
                  </button>
                ))}
              </div>
            </div>

            {/* Hàng nút bấm hành động */}
            <div className="flex flex-wrap items-center justify-between gap-3 pt-4 border-t border-border/80">
              <Button
                variant="outline"
                size="sm"
                onClick={handleClearForm}
                className="font-serif text-xs rounded-xl border-border text-muted hover:text-title gap-1.5"
              >
                <Trash2 className="w-4 h-4" />
                <span>Xóa nội dung</span>
              </Button>

              <div className="flex items-center gap-2 flex-wrap">
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={handleOpenGeminiModalForInput}
                  className="font-serif text-xs rounded-xl border-app-accent/40 text-app-accent hover:bg-app-accent-soft/30 hover:border-app-accent gap-1.5"
                  title="Dùng Gemini cá nhân tạo Pinyin và nghĩa tiếng Việt không tốn API quota"
                >
                  <Sparkles className="w-4 h-4 text-app-accent" />
                  <span>{editorHasPinyinAndMeaning ? 'Cập nhật Pinyin & Nghĩa' : 'Bổ sung Pinyin & nghĩa bằng Gemini'}</span>
                </Button>

                <Button
                  variant="outline"
                  size="sm"
                  onClick={handleSaveExercise}
                  className="font-serif text-xs rounded-xl border-border hover:border-title/40 gap-1.5"
                >
                  <FileText className="w-4 h-4 text-gold" />
                  <span>Lưu bài luyện</span>
                </Button>

                <Button
                  size="sm"
                  onClick={handleCreateAndStart}
                  className="font-serif text-xs rounded-xl bg-app-accent hover:bg-accent-hover text-white shadow-2xs gap-1.5 px-5"
                >
                  <Play className="w-4 h-4" />
                  <span>Tạo bài luyện & Bắt đầu gõ</span>
                </Button>
              </div>
            </div>
          </div>
        )}

        {/* Tab 2: Danh sách bài đã lưu */}
        {editorSubTab === 'saved' && (
          <div className="space-y-4">
            {savedExercises.length === 0 ? (
              <div className="p-12 text-center rounded-2xl border border-dashed border-border bg-card space-y-3">
                <FileText className="w-10 h-10 text-muted mx-auto" />
                <p className="font-serif text-title font-bold text-base">Chưa có bài luyện tự tạo nào được lưu</p>
                <p className="text-xs text-muted font-serif max-w-md mx-auto">
                  Bạn có thể nhập hoặc dán văn bản ở tab &quot;Tạo bài luyện mới&quot; rồi bấm &quot;Lưu bài luyện&quot; để lưu lại và luyện tập nhiều lần.
                </p>
                <Button
                  size="sm"
                  onClick={() => setEditorSubTab('create')}
                  className="font-serif text-xs rounded-xl bg-app-accent text-white"
                >
                  Tạo bài luyện ngay
                </Button>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {savedExercises.map((ex) => (
                  <div
                    key={ex.id}
                    className="p-5 rounded-2xl border border-border bg-card hover:border-app-accent/40 hover:shadow-2xs transition-all space-y-3 flex flex-col justify-between"
                  >
                    <div className="space-y-2">
                      {/* Tiêu đề & Sửa tên */}
                      {editingId === ex.id ? (
                        <div className="flex items-center gap-1.5">
                          <input
                            type="text"
                            value={editingTitleText}
                            onChange={(e) => setEditingTitleText(e.target.value)}
                            className="flex-1 px-2.5 py-1 rounded-lg border border-app-accent bg-page text-xs font-serif font-bold text-title focus:outline-none"
                            autoFocus
                          />
                          <button
                            onClick={() => handleSaveRename(ex.id)}
                            className="p-1 rounded-md bg-app-accent text-white"
                          >
                            <Check className="w-3.5 h-3.5" />
                          </button>
                        </div>
                      ) : (
                        <div className="flex items-center justify-between gap-2">
                          <h4 className="font-serif font-bold text-base text-title truncate">{ex.title}</h4>
                          <button
                            onClick={() => handleStartRename(ex)}
                            className="p-1 rounded text-muted hover:text-title hover:bg-page transition-colors"
                            title="Đổi tên bài"
                          >
                            <Edit2 className="w-3.5 h-3.5" />
                          </button>
                        </div>
                      )}

                      {/* Trích đoạn nội dung */}
                      <p className="text-xs text-muted font-serif line-clamp-2 leading-relaxed">
                        {ex.content}
                      </p>

                      <div className="flex items-center gap-3 text-[11px] text-muted font-serif pt-1">
                        <span>{ex.charCount} ký tự</span>
                        <span>•</span>
                        <span>{ex.lineCount} dòng</span>
                        <span>•</span>
                        <span>{new Date(ex.createdAt).toLocaleDateString('vi-VN')}</span>
                      </div>

                      {/* Trạng thái Pinyin & Nghĩa */}
                      {ex.hasPinyinAndMeaning ? (
                        <div className="flex items-center gap-1.5 flex-wrap pt-0.5">
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md text-[11px] font-serif bg-jade-soft text-jade border border-jade/30">
                            <CheckCircle2 className="w-3 h-3" />
                            <span>Có Pinyin & Nghĩa ({ex.segments?.length || 0} câu)</span>
                          </span>
                          {ex.isOutdated && (
                            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md text-[10px] font-serif bg-amber-500/15 text-amber-700 dark:text-amber-400 border border-amber-500/30">
                              <AlertTriangle className="w-3 h-3" />
                              <span>Văn bản đã sửa</span>
                            </span>
                          )}
                        </div>
                      ) : (
                        <div className="pt-0.5">
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md text-[11px] font-serif bg-page text-muted border border-border">
                            <span>Chỉ có chữ Hán</span>
                          </span>
                        </div>
                      )}

                      {/* Kết quả lần luyện tập gần nhất nếu có */}
                      {ex.lastResult && (
                        <div className="p-2 rounded-lg bg-page border border-border/70 flex items-center justify-between text-xs font-serif">
                          <span className="text-muted">Kết quả gần nhất:</span>
                          <span className="font-bold text-jade">
                            {ex.lastResult.cpm} CPM • {ex.lastResult.accuracy}% chính xác
                          </span>
                        </div>
                      )}
                    </div>

                    {/* Hàng nút hành động */}
                    <div className="flex items-center justify-between pt-3 border-t border-border/70 flex-wrap gap-2">
                      <button
                        onClick={() => handleDeleteSaved(ex.id, ex.title)}
                        className="text-xs text-muted hover:text-red-600 transition-colors flex items-center gap-1"
                      >
                        <Trash2 className="w-3.5 h-3.5" />
                        <span>Xóa</span>
                      </button>

                      <div className="flex items-center gap-2">
                        <Button
                          size="sm"
                          variant="outline"
                          onClick={() => handleOpenGeminiForSavedItem(ex)}
                          className="font-serif text-xs rounded-xl border-border text-muted hover:text-title hover:border-app-accent/40 gap-1 h-8"
                          title="Bổ sung hoặc cập nhật Pinyin & Nghĩa"
                        >
                          <Sparkles className="w-3.5 h-3.5 text-app-accent" />
                          <span>{ex.hasPinyinAndMeaning ? 'Pinyin & Nghĩa' : 'Bổ sung Pinyin'}</span>
                        </Button>

                        <Button
                          size="sm"
                          onClick={() =>
                            startPractice(
                              ex.content,
                              ex.title,
                              ex.id,
                              ex.segments,
                              ex.hasPinyinAndMeaning,
                              ex.isOutdated
                            )
                          }
                          className="font-serif text-xs rounded-xl bg-title hover:bg-[#2A3250] text-white gap-1.5 shadow-2xs h-8"
                        >
                          <Play className="w-3.5 h-3.5" />
                          <span>Luyện bài này</span>
                        </Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    ) : (
      <div className="space-y-6">
      
      {/* 1. Thanh tiêu đề & Nút quay lại */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-card border border-border rounded-xl p-3.5 shadow-2xs">
        <div className="flex items-center gap-3">
          <Button
            variant="ghost"
            size="sm"
            onClick={() => {
              stopSpeech()
              setViewState('editor')
            }}
            className="font-serif text-xs rounded-xl text-muted hover:text-title gap-1 px-2.5 h-8"
          >
            <ArrowLeft className="w-4 h-4" />
            <span>Danh sách bài</span>
          </Button>

          <div className="border-l border-border pl-3">
            <h3 className="font-serif font-bold text-sm md:text-base text-title truncate max-w-xs md:max-w-md">
              {currentTitle}
            </h3>
            <p className="text-[11px] text-muted font-serif">
              {currentText.length} ký tự mục tiêu • {currentText.split(/\r\n|\r|\n/).length} dòng
            </p>
          </div>
        </div>

        {/* Tùy chọn kiểm tra & hiển thị */}
        <div className="flex items-center gap-2 flex-wrap">
          {/* Chế độ kiểm tra nghiêm ngặt vs nội dung */}
          <div className="flex items-center bg-page border border-border rounded-xl p-1 text-xs font-serif">
            <button
              onClick={() => setStrictMode(true)}
              className={`px-2.5 py-1 rounded-lg transition-colors ${
                strictMode ? 'bg-title text-white font-bold' : 'text-muted hover:text-title'
              }`}
              title="Kiểm tra chính xác từng ký tự, dấu câu, khoảng trắng và dòng"
            >
              Nghiêm ngặt
            </button>
            <button
              onClick={() => setStrictMode(false)}
              className={`px-2.5 py-1 rounded-lg transition-colors ${
                !strictMode ? 'bg-title text-white font-bold' : 'text-muted hover:text-title'
              }`}
              title="Bỏ qua khác biệt về khoảng trắng / xuống dòng thừa, kiểm tra chữ và dấu câu"
            >
              Nội dung
            </button>
          </div>

          {/* Tùy chọn Pinyin & Nghĩa */}
          <div className="flex items-center gap-1.5 flex-wrap">
            <button
              onClick={() => setShowPinyin(!showPinyin)}
              disabled={!currentHasPinyinAndMeaning}
              className={`px-2.5 py-1.5 rounded-xl border text-xs font-serif transition-colors ${
                !currentHasPinyinAndMeaning
                  ? 'opacity-40 cursor-not-allowed bg-page border-border text-muted'
                  : showPinyin
                  ? 'bg-accent-soft/80 border-app-accent/50 text-app-accent font-medium'
                  : 'bg-page border-border text-muted hover:text-title'
              }`}
              title={currentHasPinyinAndMeaning ? 'Bật / Tắt hiển thị Pinyin' : 'Chưa có Pinyin. Bấm nút Bổ sung Pinyin & Nghĩa'}
            >
              Pinyin
            </button>

            <button
              onClick={() => setShowMeaning(!showMeaning)}
              disabled={!currentHasPinyinAndMeaning}
              className={`px-2.5 py-1.5 rounded-xl border text-xs font-serif transition-colors ${
                !currentHasPinyinAndMeaning
                  ? 'opacity-40 cursor-not-allowed bg-page border-border text-muted'
                  : showMeaning
                  ? 'bg-accent-soft/80 border-app-accent/50 text-app-accent font-medium'
                  : 'bg-page border-border text-muted hover:text-title'
              }`}
              title={currentHasPinyinAndMeaning ? 'Bật / Tắt hiển thị Nghĩa tiếng Việt' : 'Chưa có Nghĩa. Bấm nút Bổ sung Pinyin & Nghĩa'}
            >
              Nghĩa
            </button>

            <button
              onClick={() => {
                if (!currentHasPinyinAndMeaning) return
                if (showPinyin && showMeaning) {
                  setShowPinyin(false)
                  setShowMeaning(false)
                } else {
                  setShowPinyin(true)
                  setShowMeaning(true)
                }
              }}
              disabled={!currentHasPinyinAndMeaning}
              className={`px-2.5 py-1.5 rounded-xl border text-xs font-serif transition-colors ${
                !currentHasPinyinAndMeaning
                  ? 'opacity-40 cursor-not-allowed bg-page border-border text-muted'
                  : showPinyin && showMeaning
                  ? 'bg-title text-white font-medium border-title'
                  : 'bg-page border-border text-muted hover:text-title'
              }`}
              title="Hiện cả Pinyin và Nghĩa hoặc chỉ Chữ Hán"
            >
              {showPinyin && showMeaning ? 'Chỉ hiện chữ Hán' : 'Hiện cả hai'}
            </button>

            {/* Nút mở Gemini Modal trong khi luyện bài */}
            <Button
              variant="outline"
              size="sm"
              onClick={handleOpenGeminiForPractice}
              className={`font-serif text-xs rounded-xl h-8 px-2.5 gap-1 ${
                currentHasPinyinAndMeaning
                  ? 'border-border text-muted hover:text-title'
                  : 'border-app-accent/40 text-app-accent hover:bg-app-accent-soft/30 font-medium'
              }`}
              title="Sử dụng Gemini cá nhân tạo Pinyin & Nghĩa"
            >
              <Sparkles className="w-3.5 h-3.5 text-app-accent" />
              <span>{currentHasPinyinAndMeaning ? 'Cập nhật Pinyin/Nghĩa' : 'Bổ sung Pinyin & Nghĩa'}</span>
            </Button>
          </div>

          {/* Ẩn văn bản mẫu */}
          <button
            onClick={() => setHideSample(!hideSample)}
            className={`flex items-center gap-1 px-2.5 py-1.5 rounded-xl border text-xs font-serif transition-colors ${
              hideSample ? 'bg-title text-white border-title' : 'bg-page border-border text-muted hover:text-title'
            }`}
            title="Ẩn văn bản mẫu để tăng độ khó"
          >
            {hideSample ? <EyeOff className="w-3.5 h-3.5" /> : <Eye className="w-3.5 h-3.5" />}
            <span>{hideSample ? 'Hiện mẫu' : 'Ẩn mẫu'}</span>
          </button>

          {/* Chuẩn hóa dấu câu */}
          <button
            onClick={() => setNormalizePunctuation(!normalizePunctuation)}
            className={`px-2.5 py-1.5 rounded-xl border text-xs font-serif transition-colors ${
              normalizePunctuation ? 'bg-accent-soft/70 border-app-accent/40 text-app-accent font-medium' : 'bg-page border-border text-muted'
            }`}
            title="Cho phép dấu câu toàn giác tiếng Trung và bán giác tiếng Anh tương đương"
          >
            Dấu câu
          </button>

          {/* Âm thanh */}
          <button
            onClick={handleToggleTypingSound}
            className={`p-2 rounded-xl border text-xs transition-colors ${
              soundEnabled
                ? 'bg-app-accent-soft/40 border-app-accent/40 text-app-accent'
                : 'border-border bg-page text-muted hover:text-title'
            }`}
            title={soundEnabled ? 'Tắt âm báo gõ phím' : 'Bật âm báo gõ phím'}
          >
            {soundEnabled ? <Volume2 className="w-3.5 h-3.5 text-app-accent" /> : <VolumeX className="w-3.5 h-3.5" />}
          </button>
        </div>
      </div>

      {/* 2. Live Dashboard (Thời gian, Tốc độ, Độ chính xác, Tiến độ) */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <div className="bg-card border border-border rounded-xl p-3 shadow-2xs flex items-center gap-3">
          <span className="p-2 rounded-lg bg-page border border-border text-muted">
            <Clock className="w-4 h-4" />
          </span>
          <div>
            <p className="text-[11px] text-muted font-sans">Thời gian</p>
            <p className="text-lg font-serif font-bold text-title">{formatTime(elapsedSeconds)}</p>
          </div>
        </div>

        <div className="bg-card border border-border rounded-xl p-3 shadow-2xs flex items-center gap-3">
          <span className="p-2 rounded-lg bg-accent-soft text-app-accent">
            <Zap className="w-4 h-4" />
          </span>
          <div>
            <p className="text-[11px] text-muted font-sans">Tốc độ (CPM)</p>
            <p className="text-lg font-serif font-bold text-title">{evaluation.cpm}</p>
          </div>
        </div>

        <div className="bg-card border border-border rounded-xl p-3 shadow-2xs flex items-center gap-3">
          <span className="p-2 rounded-lg bg-jade-soft text-jade">
            <Target className="w-4 h-4" />
          </span>
          <div>
            <p className="text-[11px] text-muted font-sans">Độ chính xác</p>
            <p className="text-lg font-serif font-bold text-title">{evaluation.accuracy}%</p>
          </div>
        </div>

        <div className="bg-card border border-border rounded-xl p-3 shadow-2xs flex items-center gap-3">
          <span className="p-2 rounded-lg bg-gold-soft text-gold">
            <CheckCircle2 className="w-4 h-4" />
          </span>
          <div>
            <p className="text-[11px] text-muted font-sans">Tiến độ gõ</p>
            <p className="text-lg font-serif font-bold text-title">
              {userInput.length} / {currentText.length}
            </p>
          </div>
        </div>
      </div>

      {/* 2.5 THANH ĐIỀU KHIỂN ÂM THANH (NGHE ĐOẠN, NGHE CÂU, TỐC ĐỘ, GIỌNG ĐỌC) */}
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
        typingSoundEnabled={soundEnabled}
        onToggleTypingSound={handleToggleTypingSound}
        autoSpeakNext={autoSpeakNext}
        onToggleAutoSpeakNext={handleToggleAutoSpeakNext}
      />

      {/* 3. KHU VỰC VĂN BẢN MẪU (SAMPLE TEXT) */}
      <div className="bg-card border border-border rounded-2xl p-5 md:p-6 shadow-sm space-y-3">
        <div className="flex items-center justify-between text-xs font-serif text-muted">
          <span className="font-medium text-title">Văn bản mẫu mục tiêu:</span>
          <div className="flex items-center gap-3">
            <span className="flex items-center gap-1">
              <span className="w-2.5 h-2.5 rounded bg-emerald-500/20 border border-emerald-500 inline-block" />
              <span>Đúng: <strong>{evaluation.correctCount}</strong></span>
            </span>
            <span className="flex items-center gap-1">
              <span className="w-2.5 h-2.5 rounded bg-red-500/20 border border-red-500 inline-block" />
              <span>Sai: <strong>{evaluation.errorCount}</strong></span>
            </span>
            <span>Còn thiếu: <strong>{evaluation.missingCount}</strong></span>
          </div>
        </div>

        {hideSample && !isCompleted ? (
          <div className="p-8 text-center rounded-xl bg-page border border-border text-muted italic font-serif text-sm flex items-center justify-center gap-2">
            <EyeOff className="w-4 h-4 text-muted" />
            <span>Văn bản mẫu đang ẩn để thử thách trí nhớ. Hãy gõ từ ký ức hoặc mở lại!</span>
          </div>
        ) : tokenizedBlocks.length > 0 ? (
          /* HIỂN THỊ 3 LỚP THÔNG TIN (CHỮ HÁN - PINYIN - NGHĨA) THEO TỪNG TỪ ĐỒNG BỘ */
          <div className="space-y-3.5 max-h-80 overflow-y-auto no-scrollbar pr-1">
            {tokenizedBlocks.map((block, bIdx) => {
              const isBlockActive =
                userInput.length >= block.startIndex && userInput.length <= block.endIndex && !isCompleted
              const isBlockCompleted = userInput.length >= block.endIndex
              const isSpeaking = speakingSentenceIndex === bIdx

              const prevEnd = bIdx === 0 ? 0 : tokenizedBlocks[bIdx - 1].endIndex
              const gapChars = currentText.slice(prevEnd, block.startIndex)

              return (
                <div key={bIdx} className="space-y-1">
                  {/* Ký tự khoảng trắng / ngắt dòng giữa các đoạn */}
                  {gapChars && (
                    <div className="text-muted/40 font-mono text-xs whitespace-pre-wrap select-none px-1">
                      {gapChars.split('').map((c, i) => renderCharSpan(c, prevEnd + i))}
                    </div>
                  )}

                  <div
                    className={`p-3.5 md:p-4 rounded-xl border transition-all text-left space-y-2.5 ${
                      isSpeaking
                        ? 'bg-page border-app-accent/80 shadow-xs ring-1 ring-app-accent/40'
                        : isBlockActive
                        ? 'bg-page border-app-accent shadow-2xs ring-1 ring-app-accent/30'
                        : isBlockCompleted
                        ? 'bg-page/50 border-border/70 opacity-90'
                        : 'bg-page/70 border-border/80'
                    }`}
                  >
                    {/* Acoustic Indicator nếu đang đọc câu này */}
                    {isSpeaking && (
                      <div className="flex items-center gap-1.5 text-app-accent font-sans text-xs font-bold animate-pulse pb-0.5">
                        <Volume2 className="w-3.5 h-3.5 animate-bounce" />
                        <span>
                          Đang đọc câu {bIdx + 1}
                          {speakingWordIndex !== null && block.words[speakingWordIndex]?.isWord
                            ? `: "${block.words[speakingWordIndex].text}"`
                            : '...'}
                        </span>
                      </div>
                    )}

                    {/* Lớp 2: Pinyin phân đoạn theo từ đồng bộ */}
                    {showPinyin && block.segment.pinyin && (
                      <div className="flex flex-wrap items-baseline gap-x-1.5 gap-y-0.5 select-none leading-relaxed">
                        {block.words.map((w, wIdx) => {
                          const isWordActive = isSpeaking && speakingWordIndex === wIdx && w.isWord
                          const isWordPast = isSpeaking && speakingWordIndex !== null && wIdx < speakingWordIndex && w.isWord

                          if (!w.pinyin) return null

                          return (
                            <span
                              key={wIdx}
                              className={`transition-colors duration-150 rounded px-1 text-xs md:text-sm font-sans ${
                                isWordActive
                                  ? 'text-amber-950 dark:text-amber-100 font-bold bg-amber-200/80 dark:bg-amber-900/60 ring-1 ring-amber-400/80 shadow-2xs'
                                  : isWordPast
                                  ? 'text-app-accent/60'
                                  : 'text-app-accent font-medium'
                              }`}
                            >
                              {w.pinyin}
                            </span>
                          )
                        })}
                      </div>
                    )}

                    {/* Lớp 1: Chữ Hán gốc phân đoạn theo từ với Word-Level Highlight */}
                    <div
                      className="font-serif text-lg md:text-xl text-title leading-relaxed tracking-wide select-none flex flex-wrap items-baseline gap-y-1"
                      style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                    >
                      {block.words.map((w, wIdx) => {
                        const isWordActive = isSpeaking && speakingWordIndex === wIdx && w.isWord
                        const isWordPast = isSpeaking && speakingWordIndex !== null && wIdx < speakingWordIndex && w.isWord
                        const wordKey = `word-${bIdx}-${wIdx}`

                        return (
                          <span
                            key={wIdx}
                            ref={(el) => {
                              if (el) wordElementsRef.current.set(wordKey, el)
                              else wordElementsRef.current.delete(wordKey)
                            }}
                            className={`inline-block transition-all duration-150 rounded px-0.5 py-0.25 ${
                              isWordActive
                                ? 'bg-amber-100 dark:bg-amber-950/70 ring-2 ring-amber-400/80 text-amber-950 dark:text-amber-100 font-bold shadow-xs'
                                : isWordPast
                                ? 'opacity-85'
                                : ''
                            }`}
                          >
                            {w.text.split('').map((c, cOffset) => {
                              const globalCharIdx = block.startIndex + w.startIndex + cOffset
                              return renderCharSpan(c, globalCharIdx, isWordActive)
                            })}
                          </span>
                        )
                      })}
                    </div>

                    {/* Lớp 3: Nghĩa tiếng Việt */}
                    {showMeaning && block.segment.meaning_vi && (
                      <p className="text-xs md:text-sm font-serif text-muted italic pt-1 border-t border-border/40 select-none">
                        {block.segment.meaning_vi}
                      </p>
                    )}
                  </div>
                </div>
              )
            })}

            {/* Các ký tự còn lại ở cuối văn bản (nếu có) */}
            {tokenizedBlocks[tokenizedBlocks.length - 1].endIndex < currentText.length && (
              <div className="text-muted/40 font-mono text-xs whitespace-pre-wrap select-none px-1">
                {currentText
                  .slice(tokenizedBlocks[tokenizedBlocks.length - 1].endIndex)
                  .split('')
                  .map((c, i) => renderCharSpan(c, tokenizedBlocks[tokenizedBlocks.length - 1].endIndex + i))}
              </div>
            )}
          </div>
        ) : (
          /* VĂN BẢN GỐC THUẦN CHỮ HÁN PHÂN ĐOẠN THEO TỪ */
          <div className="space-y-2">
            {speakingSentenceIndex !== null && chineseSentences[speakingSentenceIndex] && (
              <div className="p-2.5 rounded-xl bg-app-accent-soft/30 border border-app-accent/30 text-app-accent text-xs font-serif font-bold flex items-center gap-2">
                <Volume2 className="w-4 h-4 animate-bounce flex-shrink-0" />
                <span>
                  Đang phát âm câu {speakingSentenceIndex + 1}: &quot;{chineseSentences[speakingSentenceIndex].text}&quot;
                </span>
              </div>
            )}
            <div
              className="p-4 md:p-5 rounded-xl bg-page/80 border border-border/80 max-h-72 overflow-y-auto leading-relaxed font-serif text-lg md:text-xl text-title whitespace-pre-wrap select-none no-scrollbar tracking-wide flex flex-wrap items-baseline gap-y-1"
              style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
            >
              {rawWords.map((w, wIdx) => {
                const isWordActive =
                  speakingSentenceIndex !== null && speakingWordIndex === wIdx && w.isWord
                const isWordPast =
                  speakingSentenceIndex !== null && speakingWordIndex !== null && wIdx < speakingWordIndex && w.isWord

                return (
                  <span
                    key={wIdx}
                    className={`inline-block transition-all duration-150 rounded px-0.5 py-0.25 ${
                      isWordActive
                        ? 'bg-amber-100 dark:bg-amber-950/70 ring-2 ring-amber-400/80 text-amber-950 dark:text-amber-100 font-bold shadow-xs'
                        : isWordPast
                        ? 'opacity-85'
                        : ''
                    }`}
                  >
                    {w.text.split('').map((char, cOffset) => {
                      const globalCharIdx = w.startIndex + cOffset
                      return renderCharSpan(char, globalCharIdx, isWordActive)
                    })}
                  </span>
                )
              })}
            </div>
          </div>
        )}
      </div>

      {/* 4. KHU VỰC NHẬP LIỆU ĐÁNH MÁY (TYPING AREA) */}
      <div className="space-y-3 bg-card border border-border rounded-2xl p-5 md:p-6 shadow-sm">
        <div className="flex items-center justify-between text-xs font-serif text-muted">
          <label className="font-medium text-title">Khu vực gõ lại văn bản:</label>
          {isComposing && (
            <span className="text-amber-600 dark:text-amber-400 flex items-center gap-1 font-semibold animate-pulse">
              <span className="w-2 h-2 rounded-full bg-amber-500" />
              Đang chọn chữ IME ({compositionText || 'pinyin'})...
            </span>
          )}
        </div>

        <div className="relative">
          <textarea
            ref={inputRef}
            value={userInput}
            onChange={handleInputChange}
            onCompositionStart={handleCompositionStart}
            onCompositionUpdate={handleCompositionUpdate}
            onCompositionEnd={handleCompositionEnd}
            disabled={isCompleted}
            rows={8}
            placeholder={
              isCompleted
                ? 'Đã hoàn thành bài luyện! Hãy xem kết quả tổng kết bên dưới.'
                : 'Bật bộ gõ tiếng Trung (Pinyin), gõ pinyin rồi chọn chữ Hán tương ứng theo bài mẫu...'
            }
            className="w-full p-4 bg-page border-2 border-border focus:border-app-accent rounded-xl text-base md:text-lg font-serif text-title placeholder:text-muted placeholder:text-sm focus:outline-none transition-colors shadow-inner leading-relaxed whitespace-pre-wrap"
            style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
          />
        </div>

        {/* Hàng nút điều khiển bài tập */}
        <div className="flex flex-wrap items-center justify-between gap-3 pt-2">
          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="sm"
              onClick={handleResetPractice}
              className="font-serif text-xs rounded-xl border-border text-muted hover:text-title gap-1.5"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              <span>Làm lại bài</span>
            </Button>

            <Button
              variant="outline"
              size="sm"
              onClick={handleEditTargetText}
              className="font-serif text-xs rounded-xl border-border hover:border-title/40 gap-1.5"
            >
              <Edit2 className="w-3.5 h-3.5 text-app-accent" />
              <span>Sửa văn bản mục tiêu</span>
            </Button>
          </div>

          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="sm"
              onClick={() => setShowErrorDetails(!showErrorDetails)}
              className="font-serif text-xs rounded-xl border-border gap-1.5"
            >
              <span>{showErrorDetails ? 'Ẩn chi tiết lỗi' : `Xem lỗi (${evaluation.errorCount})`}</span>
            </Button>

            <Button
              size="sm"
              onClick={handleCompletePractice}
              disabled={isCompleted || userInput.length === 0}
              className="font-serif text-xs rounded-xl bg-app-accent hover:bg-accent-hover text-white shadow-2xs gap-1.5 px-4"
            >
              <CheckCircle2 className="w-4 h-4" />
              <span>Hoàn thành bài</span>
            </Button>
          </div>
        </div>
      </div>

      {/* 5. DANH SÁCH CHI TIẾT CÁC LỖI GÕ (NẾU MỞ) */}
      {showErrorDetails && evaluation.errors.length > 0 && (
        <div className="p-4 rounded-xl bg-card border border-border space-y-3 animate-in fade-in duration-200">
          <h4 className="font-serif font-bold text-xs text-title uppercase tracking-wider flex items-center gap-1.5">
            <XCircle className="w-4 h-4 text-red-500" />
            <span>Danh sách vị trí lỗi gõ ({evaluation.errors.length} lỗi):</span>
          </h4>
          <div className="max-h-48 overflow-y-auto space-y-1.5 text-xs font-serif no-scrollbar">
            {evaluation.errors.slice(0, 25).map((err, i) => (
              <div key={i} className="p-2 rounded-lg bg-page border border-border/70 flex items-center justify-between">
                <span>Vị trí #{err.index}</span>
                <span className="text-muted">
                  Kỳ vọng: <strong className="text-jade">{err.expected}</strong>
                </span>
                <span className="text-muted">
                  Bạn gõ: <strong className="text-red-500">{err.actual}</strong>
                </span>
              </div>
            ))}
            {evaluation.errors.length > 25 && (
              <p className="text-[11px] text-muted text-center pt-1 italic">
                (Và còn {evaluation.errors.length - 25} lỗi khác...)
              </p>
            )}
          </div>
        </div>
      )}

      {/* 6. BẢNG TỔNG KẾT KHI HOÀN THÀNH BÀI */}
      {isCompleted && (
        <div className="p-6 md:p-8 bg-page border-2 border-app-accent/40 rounded-2xl space-y-6 animate-in fade-in duration-300 shadow-sm">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-border pb-4">
            <div className="flex items-center gap-3">
              <div className="p-3 rounded-2xl bg-app-accent text-white shadow-xs">
                <Award className="w-7 h-7" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-xl text-title">
                  Hoàn thành bài luyện đánh máy!
                </h3>
                <p className="text-xs text-muted font-serif mt-0.5">
                  Đã ghi nhận kết quả vào lịch sử luyện tập cá nhân
                </p>
              </div>
            </div>

            <div className="text-right">
              <span className={`text-2xl font-serif font-bold ${
                evaluation.accuracy >= 90 ? 'text-jade' : 'text-title'
              }`}>
                {evaluation.accuracy}%
              </span>
              <p className="text-[11px] text-muted font-serif">Độ chính xác</p>
            </div>
          </div>

          {/* 4 Chỉ số chi tiết */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 text-center">
            <div className="p-3.5 rounded-xl bg-card border border-border">
              <p className="text-xs text-muted font-serif">Tốc độ gõ</p>
              <p className="text-2xl font-serif font-bold text-title mt-1">{evaluation.cpm} CPM</p>
            </div>
            <div className="p-3.5 rounded-xl bg-card border border-border">
              <p className="text-xs text-muted font-serif">Thời gian</p>
              <p className="text-2xl font-serif font-bold text-app-accent mt-1">{formatTime(elapsedSeconds)}</p>
            </div>
            <div className="p-3.5 rounded-xl bg-card border border-border">
              <p className="text-xs text-muted font-serif">Ký tự đúng</p>
              <p className="text-2xl font-serif font-bold text-jade mt-1">{evaluation.correctCount}</p>
            </div>
            <div className="p-3.5 rounded-xl bg-card border border-border">
              <p className="text-xs text-muted font-serif">Ký tự sai / thiếu</p>
              <p className="text-2xl font-serif font-bold text-red-500 mt-1">
                {evaluation.errorCount} / {evaluation.missingCount}
              </p>
            </div>
          </div>

          {/* Nút hành động sau hoàn thành */}
          <div className="flex flex-wrap items-center justify-between gap-3 pt-2">
            <Button
              variant="outline"
              size="sm"
              onClick={() => setViewState('editor')}
              className="font-serif text-xs rounded-xl border-border"
            >
              Danh sách bài
            </Button>

            <div className="flex items-center gap-2">
              <Button
                variant="outline"
                size="sm"
                onClick={handleEditTargetText}
                className="font-serif text-xs rounded-xl border-border"
              >
                Sửa văn bản
              </Button>

              <Button
                size="sm"
                onClick={handleResetPractice}
                className="font-serif text-xs rounded-xl bg-app-accent text-white"
              >
                Luyện lại bài này
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  )}

  {/* Modal Bổ sung Pinyin & Nghĩa bằng Gemini cá nhân */}
  <TypingGeminiModal
    isOpen={isGeminiModalOpen}
    onClose={() => setIsGeminiModalOpen(false)}
    rawText={geminiModalTarget.text}
    exerciseTitle={geminiModalTarget.title}
    onApplySegments={handleApplySegmentsFromModal}
  />
</>
  )
}
