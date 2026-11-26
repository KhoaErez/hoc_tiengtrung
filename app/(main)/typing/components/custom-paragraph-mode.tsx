'use client'

import React, { Fragment, useState, useEffect, useRef, useMemo, useCallback } from 'react'
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
import { segmentAndAlignChinese } from '@/lib/tts/chinese-word-segmenter'
import {
  sanitizeTargetText,
  buildIndexedChars,
  evaluateTypingStateless,
  isTypingCharMatch,
} from '@/lib/typing-text-utils'
import {
  ttsEngine,
  retainUtterance,
  releaseUtterance,
  setSentenceTTSActive,
} from '@/lib/tts/tts-engine'
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
  NotebookPen,
  Languages,
  Volume2,
  VolumeX,
} from 'lucide-react'
import { Button } from '@/components/ui/button'

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

  // Trạng thái nhập liệu & IME (Tách biệt inputValue thô trên textarea và committedInput đã xác nhận)
  const [inputValue, setInputValue] = useState('')
  const [committedInput, setCommittedInput] = useState('')
  const [isComposing, setIsComposing] = useState(false)
  const [compositionText, setCompositionText] = useState('')
  const inputRef = useRef<HTMLTextAreaElement | null>(null)
  const editorTextareaRef = useRef<HTMLTextAreaElement | null>(null)
  const activeCharRef = useRef<HTMLSpanElement | null>(null)

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
  const speechStatusRef = useRef<'idle' | 'playing' | 'paused'>('idle')
  const [speakingSentenceIndex, setSpeakingSentenceIndex] = useState<number | null>(null)
  const [speechHighlightRange, setSpeechHighlightRange] = useState<{ startCp: number; endCp: number } | null>(null)
  const [audioSentenceIndex, setAudioSentenceIndex] = useState<number>(0)
  const [isAudioFinished, setIsAudioFinished] = useState<boolean>(false)
  const audioSentenceIndexRef = useRef<number>(0)
  useEffect(() => {
    audioSentenceIndexRef.current = audioSentenceIndex
  }, [audioSentenceIndex])
  const [readingMode, setReadingMode] = useState<'all' | 'sentence' | null>(null)
  const [speechRate, setSpeechRate] = useState<number>(1)
  const [selectedVoiceURI, setSelectedVoiceURI] = useState<string>('')
  const [availableVoices, setAvailableVoices] = useState<SpeechSynthesisVoice[]>([])
  const [hasVoiceWarning, setHasVoiceWarning] = useState<boolean>(false)
  const [autoSpeakNext, setAutoSpeakNext] = useState<boolean>(false)

  const readingModeRef = useRef<'all' | 'sentence' | null>(null)
  const resumeModeRef = useRef<'all' | 'sentence'>('all')
  const speechRateRef = useRef<number>(1)
  const selectedVoiceURIRef = useRef<string>('')
  const sentencesRef = useRef<ChineseSentenceItem[]>([])
  const autoSpeakNextRef = useRef<boolean>(false)
  const utteranceIdRef = useRef<number>(0)
  const activeUtteranceRef = useRef<SpeechSynthesisUtterance | null>(null)
  const keepAliveIntervalRef = useRef<NodeJS.Timeout | null>(null)
  const boundaryFallbackTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null)
  const pausedUtf16OffsetRef = useRef<number>(0)
  const lastCommittedTextRef = useRef<string>('')
  const lastCommittedCpLenRef = useRef<number>(0)
  const isComposingRef = useRef<boolean>(false)

  // Cơ chế KeepAlive cho trình duyệt Chromium trong Custom Paragraph Mode
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

  // Thống kê ký tự (Unicode code points) và dòng của input trong form
  const inputStats = useMemo(() => {
    const chars = Array.from(inputText).length
    const lines = inputText ? inputText.split(/\r\n|\r|\n/).length : 0
    return { chars, lines }
  }, [inputText])

  // Bản đồ ký tự Unicode (Array.from) & UTF-16 offset cho mục tiêu đã làm sạch
  const indexedTarget = useMemo(() => buildIndexedChars(currentText), [currentText])
  const currentTextRef = useRef<string>(currentText)
  const indexedTargetRef = useRef(indexedTarget)
  useEffect(() => {
    currentTextRef.current = currentText
    indexedTargetRef.current = indexedTarget
  }, [currentText, indexedTarget])

  // Thuật toán so sánh từng ký tự phi trạng thái (Stateless Character-by-Character Diffing)
  // Chỉ dùng committedInput (chữ đã xác nhận qua IME hoặc Direct input) -> không bao giờ nhảy màu khi đang gõ Pinyin
  const evaluation = useMemo(
    () =>
      evaluateTypingStateless(currentText, committedInput, {
        elapsedSeconds,
        strictMode,
        normalizePunctuation,
        isCompleted,
      }),
    [currentText, committedInput, elapsedSeconds, strictMode, normalizePunctuation, isCompleted]
  )

  // Auto-scroll mượt mà vào ký tự active khi người dùng đang luyện gõ bài dài
  useEffect(() => {
    if (viewState !== 'practice' || hideSample || isCompleted || !isStarted) return
    activeCharRef.current?.scrollIntoView({ behavior: 'smooth', block: 'center' })
  }, [viewState, hideSample, isCompleted, isStarted, evaluation.activeCharIndex, strictMode])

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

  // Phân tách câu tiếng Trung trên chuỗi currentText đã chuẩn hóa
  const chineseSentences = useMemo(() => {
    return extractChineseSentences(currentText, mappedBlocks)
  }, [currentText, mappedBlocks])

  useEffect(() => {
    sentencesRef.current = chineseSentences
  }, [chineseSentences])

  // Câu người dùng đang gõ hiện tại
  const currentTypingSentenceIndex = useMemo(() => {
    return findCurrentSentenceIndex(chineseSentences, committedInput.length)
  }, [chineseSentences, committedInput.length])

  // Reset câu audio khi đổi văn bản luyện
  useEffect(() => {
    setAudioSentenceIndex(0)
    setIsAudioFinished(false)
    pausedUtf16OffsetRef.current = 0
  }, [currentText])

  // Đồng bộ audioSentenceIndex theo tiến trình gõ phím khi âm thanh đang nghỉ
  useEffect(() => {
    if (speechStatus === 'idle') {
      setAudioSentenceIndex(currentTypingSentenceIndex)
      setIsAudioFinished(false)
    }
  }, [currentTypingSentenceIndex, speechStatus])

  // Hủy sạch hàng đợi Web Speech API và timer
  const cancelSpeechHardware = useCallback(() => {
    utteranceIdRef.current++
    clearKeepAlive()
    if (boundaryFallbackTimerRef.current) {
      clearTimeout(boundaryFallbackTimerRef.current)
      boundaryFallbackTimerRef.current = null
    }
    setSentenceTTSActive(false)

    if (activeUtteranceRef.current) {
      releaseUtterance(activeUtteranceRef.current)
      activeUtteranceRef.current = null
    }

    if (typeof window !== 'undefined' && window.speechSynthesis) {
      try {
        window.speechSynthesis.cancel()
      } catch {}
    }
  }, [clearKeepAlive])

  // Dừng hoàn toàn phát âm thanh và xóa highlight
  const stopSpeech = useCallback(() => {
    cancelSpeechHardware()
    pausedUtf16OffsetRef.current = 0
    readingModeRef.current = null
    speechStatusRef.current = 'idle'
    setReadingMode(null)
    setSpeechStatus('idle')
    setSpeakingSentenceIndex(null)
    setSpeechHighlightRange(null)
  }, [cancelSpeechHardware])

  // Dọn dẹp âm thanh khi unmount, chuyển trang hoặc đóng tab (window.speechSynthesis.cancel)
  useEffect(() => {
    const handleStopAll = () => {
      stopSpeech()
    }
    if (typeof window !== 'undefined') {
      window.addEventListener('app:stop-all-audio', handleStopAll)
      window.addEventListener('beforeunload', handleStopAll)
      window.addEventListener('pagehide', handleStopAll)
    }
    return () => {
      if (typeof window !== 'undefined') {
        window.removeEventListener('app:stop-all-audio', handleStopAll)
        window.removeEventListener('beforeunload', handleStopAll)
        window.removeEventListener('pagehide', handleStopAll)
      }
      stopSpeech()
    }
  }, [stopSpeech])

  // Phát âm sử dụng chuỗi cleanedTargetText với đồng bộ 1-1 charIndex/charLength
  const startSpeechUtterance = useCallback(
    (options: { mode: 'all' | 'sentence'; startUtf16Offset?: number; targetSentenceIdx?: number }) => {
      if (typeof window === 'undefined' || !window.speechSynthesis) return
      const fullText = currentTextRef.current
      if (!fullText) {
        stopSpeech()
        return
      }

      const list = sentencesRef.current
      const mode = options.mode
      let startUtf16Offset = Math.max(0, options.startUtf16Offset ?? 0)
      let textToSpeak = fullText
      let activeSentenceIdx = 0

      if (mode === 'sentence') {
        const idx = options.targetSentenceIdx ?? 0
        const item = list[idx]
        if (!item) {
          stopSpeech()
          return
        }
        activeSentenceIdx = idx
        startUtf16Offset = item.startIndex
        textToSpeak = fullText.slice(item.startIndex, item.endIndex)
      } else {
        // Phát toàn bộ: truyền chính xác cleanedTargetText từ đầu (hoặc phần còn lại khi Tiếp tục từ Tạm dừng)
        if (startUtf16Offset >= fullText.length) startUtf16Offset = 0
        textToSpeak = startUtf16Offset === 0 ? fullText : fullText.slice(startUtf16Offset)
        const foundIdx = list.findIndex((s) => startUtf16Offset >= s.startIndex && startUtf16Offset < s.endIndex)
        activeSentenceIdx = foundIdx !== -1 ? foundIdx : 0
      }

      if (!textToSpeak.trim()) {
        stopSpeech()
        return
      }

      // Gọi cancel() trước mỗi lần phát mới để triệt tiêu chồng chéo âm thanh
      cancelSpeechHardware()
      setSentenceTTSActive(true)

      const currentUtteranceId = utteranceIdRef.current
      pausedUtf16OffsetRef.current = startUtf16Offset
      readingModeRef.current = mode
      resumeModeRef.current = mode
      speechStatusRef.current = 'playing'
      setReadingMode(mode)
      setAudioSentenceIndex(activeSentenceIdx)
      setSpeakingSentenceIndex(activeSentenceIdx)
      setSpeechStatus('playing')

      // Fallback highlight cấp câu ban đầu trước khi nhận boundary
      const initSentence = list[activeSentenceIdx]
      if (initSentence) {
        setSpeechHighlightRange(
          indexedTargetRef.current.utf16RangeToCpRange(
            initSentence.startIndex,
            Math.max(1, initSentence.endIndex - initSentence.startIndex)
          )
        )
      } else {
        setSpeechHighlightRange(null)
      }

      // Độ trễ vi mô (20ms) sau cancel() cho IPC audio driver của Chromium
      setTimeout(() => {
        if (currentUtteranceId !== utteranceIdRef.current) return

        try {
          const utterance = new SpeechSynthesisUtterance(textToSpeak)
          utterance.lang = 'zh-CN'
          utterance.rate = Math.max(0.5, Math.min(2.0, speechRateRef.current || 1.0))

          const voices = getChineseVoices()
          const voice =
            voices.find((v) => v.voiceURI === selectedVoiceURIRef.current) ||
            voices[0]
          if (voice) utterance.voice = voice

          activeUtteranceRef.current = utterance
          retainUtterance(utterance)

          let boundaryCount = 0

          utterance.onstart = () => {
            if (currentUtteranceId !== utteranceIdRef.current) return
            speechStatusRef.current = 'playing'
            setSpeechStatus('playing')
            startKeepAlive()

            // Phòng vệ WebKit/Mobile nếu không phát sinh thêm boundary (chỉ nhận 0 hoặc không có) -> highlight cả câu
            boundaryFallbackTimerRef.current = setTimeout(() => {
              if (currentUtteranceId !== utteranceIdRef.current) return
              if (boundaryCount <= 1 && textToSpeak.length > 2) {
                const s = sentencesRef.current[activeSentenceIdx]
                if (s) {
                  setSpeechHighlightRange(
                    indexedTargetRef.current.utf16RangeToCpRange(
                      s.startIndex,
                      Math.max(1, s.endIndex - s.startIndex)
                    )
                  )
                }
              }
            }, 650)
          }

          utterance.onboundary = (event) => {
            if (currentUtteranceId !== utteranceIdRef.current) return

            boundaryCount++
            const localCharIndex = typeof event.charIndex === 'number' && event.charIndex >= 0 ? event.charIndex : 0
            const charLength =
              typeof event.charLength === 'number' && event.charLength > 0 ? event.charLength : 1
            const globalUtf16Start = startUtf16Offset + localCharIndex
            pausedUtf16OffsetRef.current = globalUtf16Start

            // Đồng bộ câu đang đọc
            const curList = sentencesRef.current
            const matchedSent =
              curList.find((s) => globalUtf16Start >= s.startIndex && globalUtf16Start < s.endIndex) ||
              curList.find((s) => globalUtf16Start < s.endIndex) ||
              curList[activeSentenceIdx]

            if (matchedSent) {
              setSpeakingSentenceIndex((prev) => (prev === matchedSent.index ? prev : matchedSent.index))
              setAudioSentenceIndex((prev) => (prev === matchedSent.index ? prev : matchedSent.index))
            }

            // Nếu browser chỉ trả boundary 'sentence', highlight trọn vẹn câu chứa charIndex đó
            if (event.name === 'sentence' && matchedSent) {
              setSpeechHighlightRange(
                indexedTargetRef.current.utf16RangeToCpRange(
                  matchedSent.startIndex,
                  Math.max(1, matchedSent.endIndex - matchedSent.startIndex)
                )
              )
              return
            }

            // Highlight chính xác dải [charIndex, charIndex + charLength) trên targetChars
            setSpeechHighlightRange(
              indexedTargetRef.current.utf16RangeToCpRange(globalUtf16Start, charLength)
            )
          }

          utterance.onend = () => {
            if (boundaryFallbackTimerRef.current) {
              clearTimeout(boundaryFallbackTimerRef.current)
              boundaryFallbackTimerRef.current = null
            }
            releaseUtterance(utterance)
            if (activeUtteranceRef.current === utterance) {
              activeUtteranceRef.current = null
            }
            clearKeepAlive()

            if (currentUtteranceId !== utteranceIdRef.current) return

            const curList = sentencesRef.current
            // Tự động xóa trạng thái highlight âm thanh khi kết thúc
            setSpeechHighlightRange(null)

            if (readingModeRef.current === 'sentence' && curList.length > 0) {
              if (activeSentenceIdx + 1 < curList.length) {
                setAudioSentenceIndex(activeSentenceIdx + 1)
                if (autoSpeakNextRef.current) {
                  pausedUtf16OffsetRef.current = curList[activeSentenceIdx + 1].startIndex
                  startSpeechUtterance({ mode: 'sentence', targetSentenceIdx: activeSentenceIdx + 1 })
                  return
                }
              } else {
                setAudioSentenceIndex(activeSentenceIdx)
                setIsAudioFinished(true)
              }
            } else if (readingModeRef.current === 'all') {
              if (curList.length > 0) {
                setAudioSentenceIndex(curList.length - 1)
              }
              setIsAudioFinished(true)
            }

            // Reset nút Play/Pause & highlight về trạng thái ban đầu
            pausedUtf16OffsetRef.current = 0
            setSpeakingSentenceIndex(null)
            setReadingMode(null)
            readingModeRef.current = null
            speechStatusRef.current = 'idle'
            setSpeechStatus('idle')
            setSentenceTTSActive(false)
          }

          utterance.onerror = (e) => {
            if (boundaryFallbackTimerRef.current) {
              clearTimeout(boundaryFallbackTimerRef.current)
              boundaryFallbackTimerRef.current = null
            }
            releaseUtterance(utterance)
            if (activeUtteranceRef.current === utterance) {
              activeUtteranceRef.current = null
            }
            clearKeepAlive()

            if (currentUtteranceId !== utteranceIdRef.current) return
            if (e.error !== 'interrupted' && e.error !== 'canceled') {
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
          console.error('Lỗi khi kích hoạt phát âm custom mode:', err)
          stopSpeech()
        }
      }, 20)
    },
    [cancelSpeechHardware, stopSpeech, clearKeepAlive, startKeepAlive]
  )

  const handlePlayAll = useCallback(() => {
    if (!currentText.trim()) return
    if (availableVoices.length === 0 && typeof window !== 'undefined' && window.speechSynthesis) {
      const v = getChineseVoices()
      if (v.length === 0) {
        toast.warning(
          'Thiết bị chưa tìm thấy giọng đọc tiếng Trung (zh-CN). Vui lòng thêm giọng tiếng Trung trong cài đặt thiết bị.'
        )
      }
    }
    setIsAudioFinished(false)
    setAudioSentenceIndex(0)
    pausedUtf16OffsetRef.current = 0
    startSpeechUtterance({ mode: 'all', startUtf16Offset: 0 })
  }, [currentText, availableVoices, startSpeechUtterance])

  const handlePlayCurrentSentence = useCallback(() => {
    if (chineseSentences.length === 0) return
    setIsAudioFinished(false)
    const targetIdx = Math.min(Math.max(0, audioSentenceIndexRef.current), chineseSentences.length - 1)
    startSpeechUtterance({ mode: 'sentence', targetSentenceIdx: targetIdx })
  }, [chineseSentences, startSpeechUtterance])

  const handlePrevSentenceAudio = useCallback(() => {
    if (chineseSentences.length <= 1) return
    const prevIdx = Math.max(0, audioSentenceIndex - 1)
    setAudioSentenceIndex(prevIdx)
    setIsAudioFinished(false)

    if (speechStatus === 'playing' && readingMode === 'sentence') {
      startSpeechUtterance({ mode: 'sentence', targetSentenceIdx: prevIdx })
    }
  }, [chineseSentences, audioSentenceIndex, speechStatus, readingMode, startSpeechUtterance])

  const handleNextSentenceAudio = useCallback(() => {
    if (chineseSentences.length <= 1) return
    const nextIdx = Math.min(chineseSentences.length - 1, audioSentenceIndex + 1)
    setAudioSentenceIndex(nextIdx)
    setIsAudioFinished(false)

    if (speechStatus === 'playing' && readingMode === 'sentence') {
      startSpeechUtterance({ mode: 'sentence', targetSentenceIdx: nextIdx })
    }
  }, [chineseSentences, audioSentenceIndex, speechStatus, readingMode, startSpeechUtterance])

  // Tạm dừng: Gọi cancel() để tránh treo queue hoặc chồng chéo âm thanh, giữ lại offset để Tiếp tục
  const handlePauseSpeech = useCallback(() => {
    resumeModeRef.current = readingModeRef.current || 'all'
    cancelSpeechHardware()
    speechStatusRef.current = 'paused'
    setSpeechStatus('paused')
    setSpeechHighlightRange(null)
  }, [cancelSpeechHardware])

  const handleResumeSpeech = useCallback(() => {
    const modeToResume = resumeModeRef.current || 'all'
    if (modeToResume === 'all') {
      startSpeechUtterance({ mode: 'all', startUtf16Offset: pausedUtf16OffsetRef.current })
    } else {
      startSpeechUtterance({
        mode: 'sentence',
        targetSentenceIdx: speakingSentenceIndex ?? audioSentenceIndexRef.current,
      })
    }
  }, [speakingSentenceIndex, startSpeechUtterance])

  const handleRateChange = (rate: number) => {
    setSpeechRate(rate)
    speechRateRef.current = rate
    ttsEngine.setRate(rate as any)
    saveTypingPreferences({ speechRate: rate })

    if (speechStatus === 'playing') {
      const modeToRestart = readingModeRef.current || 'all'
      startSpeechUtterance({
        mode: modeToRestart,
        startUtf16Offset: pausedUtf16OffsetRef.current,
        targetSentenceIdx: speakingSentenceIndex ?? audioSentenceIndexRef.current,
      })
    }
  }

  const handleVoiceChange = (uri: string) => {
    setSelectedVoiceURI(uri)
    selectedVoiceURIRef.current = uri
    saveTypingPreferences({ preferredVoiceURI: uri })

    if (speechStatus === 'playing') {
      const modeToRestart = readingModeRef.current || 'all'
      startSpeechUtterance({
        mode: modeToRestart,
        startUtf16Offset: pausedUtf16OffsetRef.current,
        targetSentenceIdx: speakingSentenceIndex ?? audioSentenceIndexRef.current,
      })
    }
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

  // Hàm render từng ký tự dựa trên Stateless Evaluation & SpeechHighlightRange
  const renderCharSpan = (cpIdx: number) => {
    const char = evaluation.targetChars[cpIdx]
    if (char === undefined) return null

    const status = evaluation.charStates[cpIdx] ?? 'pending'
    const isAudioHighlighted =
      speechHighlightRange !== null &&
      cpIdx >= speechHighlightRange.startCp &&
      cpIdx < speechHighlightRange.endCp

    let charStyle = 'text-title/80'
    if (status === 'correct') {
      charStyle = isAudioHighlighted
        ? 'bg-emerald-500/25 text-emerald-800 dark:text-emerald-300 font-bold rounded px-0.5 ring-1 ring-amber-400'
        : 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 rounded px-0.5'
    } else if (status === 'incorrect') {
      charStyle =
        'bg-red-500/20 text-red-600 dark:text-red-400 rounded px-0.5 underline decoration-red-500 font-bold'
    } else if (status === 'active') {
      charStyle = 'border-b-2 border-app-accent bg-accent-soft/45 text-title font-bold animate-pulse rounded-t px-0.5'
    } else if (status === 'ignored') {
      charStyle = 'text-muted/35'
    } else if (isAudioHighlighted) {
      charStyle =
        'bg-amber-200/80 dark:bg-amber-900/60 text-amber-950 dark:text-amber-100 font-bold ring-1 ring-amber-400/80 rounded px-0.5'
    }

    if (char === '\n') {
      return (
        <Fragment key={cpIdx}>
          <span
            ref={status === 'active' ? activeCharRef : undefined}
            className={`inline-flex items-center justify-center px-1 mx-0.5 rounded text-xs font-mono align-baseline select-none transition-colors ${charStyle}`}
            title="Xuống dòng (Enter)"
          >
            ↵
          </span>
          <span className="basis-full h-0" aria-hidden="true" />
        </Fragment>
      )
    }

    return (
      <span
        key={cpIdx}
        ref={status === 'active' ? activeCharRef : undefined}
        className={`inline-block transition-colors ${charStyle}`}
      >
        {char}
      </span>
    )
  }

  // Bắt đầu vào bài luyện (tự động chuẩn hóa targetText trước khi lưu state và render)
  const startPractice = (
    text: string,
    title?: string,
    exerciseId?: string | null,
    segments?: TypingSegment[],
    hasPinyin?: boolean,
    isOutdated?: boolean
  ) => {
    const cleanedTarget = sanitizeTargetText(text)
    if (!cleanedTarget) {
      setFormError('Nội dung văn bản không được để trống.')
      return
    }

    stopSpeech()
    setFormError('')
    setCurrentText(cleanedTarget)
    setCurrentTitle(title?.trim() || cleanedTarget.split('\n')[0]?.slice(0, 30) || 'Bài luyện tự tạo')
    setCurrentExerciseId(exerciseId || null)
    setCurrentSegments(segments || [])
    setCurrentHasPinyinAndMeaning(hasPinyin ?? (segments ? segments.length > 0 : false))
    setCurrentIsOutdated(isOutdated ?? false)

    // Reset trạng thái nhập liệu & IME
    lastCommittedTextRef.current = ''
    lastCommittedCpLenRef.current = 0
    isComposingRef.current = false
    setInputValue('')
    setCommittedInput('')
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

  // Xử lý tạo bài từ form (chuẩn hóa văn bản trước khi lưu & luyện)
  const handleCreateAndStart = () => {
    const cleanedContent = sanitizeTargetText(inputText)
    if (!cleanedContent) {
      setFormError('Vui lòng nhập hoặc dán nội dung văn bản muốn luyện đánh máy.')
      return
    }
    if (cleanedContent !== inputText) {
      setInputText(cleanedContent)
    }
    startPractice(
      cleanedContent,
      inputTitle,
      activeExerciseId,
      editorSegments,
      editorHasPinyinAndMeaning,
      editorIsOutdated
    )
  }

  // Lưu bài luyện vào danh sách cá nhân
  const handleSaveExercise = () => {
    const cleanedContent = sanitizeTargetText(inputText)
    if (!cleanedContent) {
      setFormError('Vui lòng nhập nội dung văn bản trước khi lưu.')
      return
    }
    if (cleanedContent !== inputText) {
      setInputText(cleanedContent)
    }

    const saved = saveCustomExercise({
      id: activeExerciseId || undefined,
      title: inputTitle,
      content: cleanedContent,
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

  // Áp dụng mẫu văn bản gợi ý (được sanitize ngay khi nạp)
  const handleApplyTemplate = (tpl: (typeof SAMPLE_TEMPLATES)[0]) => {
    const cleanedTemplate = sanitizeTargetText(tpl.content)
    setInputTitle(tpl.title)
    setInputText(cleanedTemplate)
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
    const cleanedText = sanitizeTargetText(inputText)
    if (!cleanedText) {
      setFormError('Vui lòng nhập hoặc dán nội dung văn bản tiếng Trung vào ô bên dưới trước khi bổ sung Pinyin & Nghĩa.')
      toast.warning('Vui lòng dán hoặc nhập nội dung tiếng Trung vào ô văn bản trước khi bổ sung Pinyin & Nghĩa.')
      editorTextareaRef.current?.focus()
      return
    }
    if (cleanedText !== inputText) {
      setInputText(cleanedText)
    }
    setFormError('')
    setGeminiModalTarget({
      text: cleanedText,
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
      text: sanitizeTargetText(ex.content),
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
  }, [isCompleted, currentExerciseId, evaluation, elapsedSeconds, soundEnabled, stopSpeech, onSessionComplete])

  // Xử lý chuỗi ký tự đã được xác nhận chính thức (chỉ gọi tại onCompositionEnd hoặc non-IME onChange)
  const handleCommittedText = useCallback(
    (newVal: string) => {
      if (newVal === lastCommittedTextRef.current) return

      const prevText = lastCommittedTextRef.current
      const prevCpLen = lastCommittedCpLenRef.current
      const nextCpChars = Array.from(newVal)
      const nextCpLen = nextCpChars.length

      if (!isStarted && nextCpLen > 0) {
        setIsStarted(true)
      }

      lastCommittedTextRef.current = newVal
      lastCommittedCpLenRef.current = nextCpLen
      setCommittedInput(newVal)

      // 1. Trường hợp người dùng xóa ký tự (Backspace): evaluation stateless tự cập nhật lại màu sắc & bộ đếm
      if (nextCpLen <= prevCpLen) {
        return
      }

      // 2. Trường hợp có ký tự mới được xác nhận [prevCpLen .. nextCpLen)
      const targetCpChars = indexedTargetRef.current.chars
      let allCorrect = true
      for (let i = prevCpLen; i < nextCpLen; i++) {
        const targetChar = targetCpChars[i]
        if (!targetChar || !isTypingCharMatch(nextCpChars[i], targetChar, normalizePunctuation)) {
          allCorrect = false
          break
        }
      }

      // Phát âm báo gõ phím nhẹ nhàng
      if (soundEnabled) {
        playTypingSfx(allCorrect ? 'correct' : 'error')
      }

      // Phát âm (TTS) chữ Hán vừa được chọn ngay lập tức (chỉ khi không đang đọc toàn bài/câu)
      const newlyTypedText = nextCpChars.slice(prevCpLen).join('')
      if (soundEnabled && newlyTypedText.trim() && speechStatusRef.current !== 'playing') {
        speakChineseCharacter(newlyTypedText, selectedVoiceURIRef.current, speechRateRef.current)
      }

      // Tự đọc câu tiếp theo khi gõ xong câu hiện tại
      if (autoSpeakNextRef.current && sentencesRef.current.length > 1) {
        const curSentence = sentencesRef.current.find(
          (s) => prevText.length < s.endIndex && newVal.length >= s.endIndex
        )
        if (curSentence && curSentence.index + 1 < sentencesRef.current.length) {
          startSpeechUtterance({ mode: 'sentence', targetSentenceIdx: curSentence.index + 1 })
        }
      }
    },
    [isStarted, normalizePunctuation, soundEnabled, startSpeechUtterance]
  )

  // Xử lý thay đổi ô nhập liệu: Luôn cập nhật inputValue để không vỡ IME, nhưng TUYỆT ĐỐI không chấm điểm khi đang compose
  const handleInputChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    const val = e.target.value
    const nativeIsComposing = Boolean((e.nativeEvent as InputEvent | undefined)?.isComposing)
    setInputValue(val)

    if (isComposingRef.current || nativeIsComposing) {
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
    setCompositionText(e.data || '')
  }

  const handleCompositionEnd = (e: React.CompositionEvent<HTMLTextAreaElement>) => {
    isComposingRef.current = false
    setIsComposing(false)
    setCompositionText('')

    // Lấy giá trị chữ Hán chính thức đã xuất hiện trên DOM và kích hoạt diffing
    const val = (e.currentTarget || (e.target as HTMLTextAreaElement)).value
    setInputValue(val)
    handleCommittedText(val)
  }

  // Làm lại bài
  const handleResetPractice = () => {
    stopSpeech()
    lastCommittedTextRef.current = ''
    lastCommittedCpLenRef.current = 0
    isComposingRef.current = false
    setInputValue('')
    setCommittedInput('')
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
          <div className="bg-white dark:bg-[#182238] border-2 border-[#182238] dark:border-[#384869] rounded-3xl p-5 sm:p-7 md:p-8 space-y-6 shadow-[0_6px_0_#182238] dark:shadow-[0_4px_0_#0D1322]">
            <div className="space-y-1">
              <h3 className="font-serif font-bold text-lg text-title flex items-center gap-2">
                <NotebookPen className="w-5 h-5 text-app-accent" />
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
                onPaste={(e) => {
                  const pasted = e.clipboardData?.getData('text')
                  if (!pasted) return
                  e.preventDefault()
                  const el = e.currentTarget
                  const start = el.selectionStart ?? inputText.length
                  const end = el.selectionEnd ?? inputText.length
                  const combined = inputText.slice(0, start) + pasted + inputText.slice(end)
                  const cleaned = sanitizeTargetText(combined)
                  setInputText(cleaned)
                  if (formError) setFormError('')
                  if (editorHasPinyinAndMeaning && editorAnalyzedText) {
                    setEditorIsOutdated(cleaned.trim() !== editorAnalyzedText.trim())
                  }
                }}
                rows={9}
                placeholder="Dán đoạn văn tiếng Trung bạn muốn luyện đánh máy vào đây... (Hệ thống tự động loại bỏ khoảng trắng thừa, chuẩn hóa ngắt đoạn & dấu câu tiếng Trung)"
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
                  <Languages className="w-4 h-4 text-app-accent" />
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
                    className="p-5 rounded-3xl border-2 border-[#182238]/15 dark:border-[#384869] bg-white dark:bg-[#182238] shadow-[0_3px_0_#182238]/10 hover:shadow-[0_5px_0_#182238] hover:border-[#182238] transition-all space-y-3 flex flex-col justify-between"
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
                          <Languages className="w-3.5 h-3.5 text-app-accent" />
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
              {evaluation.targetChars.length} ký tự mục tiêu • {currentText ? currentText.split('\n').length : 0} dòng
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
              <Languages className="w-3.5 h-3.5 text-app-accent" />
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
              {evaluation.committedCharCount} / {evaluation.totalTargetChars}
            </p>
          </div>
        </div>
      </div>

      {/* 2.5 THANH ĐIỀU KHIỂN ÂM THANH (NGHE ĐOẠN, NGHE CÂU, TỐC ĐỘ, GIỌNG ĐỌC) */}
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
        typingSoundEnabled={soundEnabled}
        onToggleTypingSound={handleToggleTypingSound}
        autoSpeakNext={autoSpeakNext}
        onToggleAutoSpeakNext={handleToggleAutoSpeakNext}
        onPrevSentence={handlePrevSentenceAudio}
        onNextSentence={handleNextSentenceAudio}
        isAudioFinished={isAudioFinished}
      />

      {/* 3. KHU VỰC VĂN BẢN MẪU (SAMPLE TEXT) */}
      <div className="bg-card border border-border rounded-2xl p-5 md:p-6 shadow-sm space-y-3">
        <div className="flex items-center justify-between text-xs font-serif text-muted flex-wrap gap-2">
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
              const blockStartCp = indexedTarget.utf16ToCp(block.startIndex)
              const blockEndCp = indexedTarget.utf16ToCp(block.endIndex)
              const isBlockActive =
                evaluation.inputChars.length >= blockStartCp && evaluation.inputChars.length <= blockEndCp && !isCompleted
              const isBlockCompleted = evaluation.inputChars.length >= blockEndCp
              const isSpeaking = speakingSentenceIndex === bIdx

              const prevEndUtf16 = bIdx === 0 ? 0 : tokenizedBlocks[bIdx - 1].endIndex
              const gapStartCp = indexedTarget.utf16ToCp(prevEndUtf16)
              const gapEndCp = blockStartCp
              const spokenPhrase =
                isSpeaking && speechHighlightRange
                  ? evaluation.targetChars
                      .slice(
                        Math.max(blockStartCp, speechHighlightRange.startCp),
                        Math.min(blockEndCp, speechHighlightRange.endCp)
                      )
                      .join('')
                  : ''

              return (
                <div
                  key={bIdx}
                  className="space-y-1"
                  style={{ contentVisibility: 'auto', containIntrinsicSize: '120px' }}
                >
                  {/* Ký tự khoảng trắng / ngắt dòng giữa các đoạn */}
                  {gapEndCp > gapStartCp && (
                    <div className="text-muted/40 font-mono text-xs whitespace-pre-wrap select-none px-1 flex flex-wrap items-baseline">
                      {indexedTarget.items.slice(gapStartCp, gapEndCp).map((it) => renderCharSpan(it.cpIdx))}
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
                          {spokenPhrase ? `: "${spokenPhrase}"` : '...'}
                        </span>
                      </div>
                    )}

                    {/* Lớp 2: Pinyin phân đoạn theo từ đồng bộ với speechHighlightRange */}
                    {showPinyin && block.segment.pinyin && (
                      <div className="flex flex-wrap items-baseline gap-x-1.5 gap-y-0.5 select-none leading-relaxed">
                        {block.words.map((w, wIdx) => {
                          const wStartCp = indexedTarget.utf16ToCp(block.startIndex + w.startIndex)
                          const wEndCp = indexedTarget.utf16ToCp(block.startIndex + w.endIndex)
                          const isWordActive =
                            isSpeaking &&
                            speechHighlightRange !== null &&
                            w.isWord &&
                            wStartCp < speechHighlightRange.endCp &&
                            wEndCp > speechHighlightRange.startCp
                          const isWordPast =
                            isSpeaking &&
                            speechHighlightRange !== null &&
                            w.isWord &&
                            wEndCp <= speechHighlightRange.startCp
                          const isSentenceFallback = isSpeaking && speechHighlightRange === null && w.isWord

                          if (!w.pinyin) return null

                          return (
                            <span
                              key={wIdx}
                              className={`transition-colors duration-150 rounded px-1 text-xs md:text-sm font-sans ${
                                isWordActive
                                  ? 'text-amber-950 dark:text-amber-100 font-bold bg-amber-200/80 dark:bg-amber-900/60 ring-1 ring-amber-400/80 shadow-2xs'
                                  : isSentenceFallback
                                  ? 'text-amber-900 dark:text-amber-200 font-semibold bg-amber-100/70 dark:bg-amber-950/40 ring-1 ring-amber-300/50 dark:ring-amber-800/40'
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

                    {/* Lớp 1: Chữ Hán gốc dùng từng ký tự Unicode chuẩn xác */}
                    <div
                      className="font-serif text-lg md:text-xl text-title leading-relaxed tracking-wide select-none flex flex-wrap items-baseline gap-y-1"
                      style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                    >
                      {block.words.map((w, wIdx) => {
                        const wStartCp = indexedTarget.utf16ToCp(block.startIndex + w.startIndex)
                        const wEndCp = indexedTarget.utf16ToCp(block.startIndex + w.endIndex)
                        const isWordActive =
                          isSpeaking &&
                          speechHighlightRange !== null &&
                          w.isWord &&
                          wStartCp < speechHighlightRange.endCp &&
                          wEndCp > speechHighlightRange.startCp
                        const isSentenceFallback = isSpeaking && speechHighlightRange === null && w.isWord

                        return (
                          <span
                            key={wIdx}
                            className={`inline-flex flex-wrap items-baseline transition-all duration-150 rounded px-0.5 ${
                              isWordActive
                                ? 'bg-amber-100/70 dark:bg-amber-950/50 ring-1 ring-amber-400/70 font-bold'
                                : isSentenceFallback
                                ? 'bg-amber-50 dark:bg-amber-950/30 ring-1 ring-amber-300/40 font-medium'
                                : ''
                            }`}
                          >
                            {indexedTarget.items.slice(wStartCp, wEndCp).map((it) => renderCharSpan(it.cpIdx))}
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
            {indexedTarget.utf16ToCp(tokenizedBlocks[tokenizedBlocks.length - 1].endIndex) < evaluation.targetChars.length && (
              <div className="text-muted/40 font-mono text-xs whitespace-pre-wrap select-none px-1 flex flex-wrap items-baseline">
                {indexedTarget.items
                  .slice(indexedTarget.utf16ToCp(tokenizedBlocks[tokenizedBlocks.length - 1].endIndex))
                  .map((it) => renderCharSpan(it.cpIdx))}
              </div>
            )}
          </div>
        ) : (
          /* VĂN BẢN MẪU THUẦN: Render trực tiếp từng ký tự Array.from(cleanedTargetText) để khớp 1-1 tuyệt đối với diff & TTS */
          <div className="space-y-2">
            {speakingSentenceIndex !== null && chineseSentences[speakingSentenceIndex] && (
              <div className="p-2.5 rounded-xl bg-app-accent-soft/30 border border-app-accent/30 text-app-accent text-xs font-serif font-bold flex items-center gap-2">
                <Volume2 className="w-4 h-4 animate-bounce flex-shrink-0" />
                <span>
                  Đang phát âm câu {speakingSentenceIndex + 1}
                  {speechHighlightRange
                    ? `: "${evaluation.targetChars.slice(speechHighlightRange.startCp, speechHighlightRange.endCp).join('')}"`
                    : `: "${chineseSentences[speakingSentenceIndex].text}"`}
                </span>
              </div>
            )}
            <div
              className="p-4 md:p-5 rounded-xl bg-page/80 border border-border/80 max-h-72 overflow-y-auto leading-relaxed font-serif text-lg md:text-xl text-title whitespace-pre-wrap select-none no-scrollbar tracking-wide flex flex-wrap items-baseline gap-y-1.5"
              style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
            >
              {evaluation.targetChars.map((_, cpIdx) => renderCharSpan(cpIdx))}
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
            value={inputValue}
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
              disabled={isCompleted || evaluation.inputChars.length === 0}
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
