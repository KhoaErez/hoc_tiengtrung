'use client'

import { useState, useMemo, useCallback } from 'react'
import Link from 'next/link'
import { radicals, type Radical } from '@/data/radicals'
import { saveQuizScore } from '@/lib/radicals-storage'
import {
  ChevronLeft,
  RotateCcw,
  Trophy,
  CheckCircle,
  XCircle,
  ArrowRight,
} from 'lucide-react'
import { stopAllAudio } from '@/lib/tts/tts-engine'

type QuizType = 'radical-to-meaning' | 'meaning-to-radical' | 'pinyin-to-radical'

interface Question {
  type: QuizType
  radical: Radical
  options: string[]
  correctIndex: number
}

function shuffleArray<T>(array: T[]): T[] {
  const shuffled = [...array]
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))
      ;[shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]]
  }
  return shuffled
}

function generateQuestions(count: number, types: QuizType[]): Question[] {
  const pool = shuffleArray(radicals)
  const questions: Question[] = []

  for (let i = 0; i < Math.min(count, pool.length); i++) {
    const radical = pool[i]
    const type = types[Math.floor(Math.random() * types.length)]

    // Get 3 wrong answers from other radicals
    const others = radicals.filter((r) => r.id !== radical.id)
    const wrongOnes = shuffleArray(others).slice(0, 3)

    let options: string[]
    let correctAnswer: string

    switch (type) {
      case 'radical-to-meaning':
        correctAnswer = radical.meaning
        options = shuffleArray([
          correctAnswer,
          ...wrongOnes.map((r) => r.meaning),
        ])
        break
      case 'meaning-to-radical':
        correctAnswer = radical.radical
        options = shuffleArray([
          correctAnswer,
          ...wrongOnes.map((r) => r.radical),
        ])
        break
      case 'pinyin-to-radical':
        correctAnswer = radical.radical
        options = shuffleArray([
          correctAnswer,
          ...wrongOnes.map((r) => r.radical),
        ])
        break
    }

    questions.push({
      type,
      radical,
      options,
      correctIndex: options.indexOf(correctAnswer),
    })
  }

  return questions
}

const QUIZ_SIZE = 20

export default function QuizClient() {
  const [quizTypes, setQuizTypes] = useState<QuizType[]>([
    'radical-to-meaning',
    'meaning-to-radical',
    'pinyin-to-radical',
  ])
  const [questions, setQuestions] = useState<Question[]>([])
  const [currentQ, setCurrentQ] = useState(0)
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null)
  const [score, setScore] = useState(0)
  const [isFinished, setIsFinished] = useState(false)
  const [started, setStarted] = useState(false)
  const [showExplanation, setShowExplanation] = useState(false)

  const startQuiz = useCallback(() => {
    stopAllAudio()
    const qs = generateQuestions(QUIZ_SIZE, quizTypes)
    setQuestions(qs)
    setCurrentQ(0)
    setSelectedAnswer(null)
    setScore(0)
    setIsFinished(false)
    setStarted(true)
    setShowExplanation(false)
  }, [quizTypes])

  const handleAnswer = (index: number) => {
    if (selectedAnswer !== null) return // Already answered
    setSelectedAnswer(index)
    setShowExplanation(true)
    if (index === questions[currentQ].correctIndex) {
      setScore((s) => s + 1)
    }
  }

  const goNext = () => {
    stopAllAudio()
    if (currentQ < questions.length - 1) {
      setCurrentQ((q) => q + 1)
      setSelectedAnswer(null)
      setShowExplanation(false)
    } else {
      // Finished
      setIsFinished(true)
      saveQuizScore({
        date: new Date().toISOString(),
        total: questions.length,
        correct: score + (selectedAnswer === questions[currentQ].correctIndex ? 0 : 0), // score already updated
        type: quizTypes.join(','),
      })
    }
  }

  const toggleQuizType = (type: QuizType) => {
    setQuizTypes((prev) => {
      if (prev.includes(type)) {
        if (prev.length === 1) return prev // Must have at least one
        return prev.filter((t) => t !== type)
      }
      return [...prev, type]
    })
  }

  const quizTypeLabels: Record<QuizType, string> = {
    'radical-to-meaning': 'Bộ thủ → Nghĩa',
    'meaning-to-radical': 'Nghĩa → Bộ thủ',
    'pinyin-to-radical': 'Pinyin → Bộ thủ',
  }

  // Setup screen
  if (!started) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <Link
            href="/radicals"
            className="flex items-center gap-2 text-muted hover:text-app-accent transition-colors font-serif text-sm"
          >
            <ChevronLeft className="w-4 h-4" />
            Danh sách bộ thủ
          </Link>
        </div>

        <div className="bg-card border border-border rounded-xl p-6 md:p-8 space-y-6">
          <div className="text-center space-y-2">
            <div className="text-5xl mb-4">🧠</div>
            <h1 className="text-2xl font-serif text-title">Quiz Bộ thủ</h1>
            <p className="text-muted font-serif text-sm">
              Trả lời {QUIZ_SIZE} câu hỏi trắc nghiệm để kiểm tra kiến thức về bộ thủ
            </p>
          </div>

          <div className="space-y-3">
            <p className="text-xs text-muted font-serif uppercase tracking-wider">
              Chọn dạng câu hỏi
            </p>
            <div className="space-y-2">
              {(Object.keys(quizTypeLabels) as QuizType[]).map((type) => (
                <button
                  key={type}
                  onClick={() => toggleQuizType(type)}
                  className={`w-full text-left px-4 py-3 border rounded-lg text-sm font-serif transition-all ${quizTypes.includes(type)
                      ? 'border-app-accent bg-accent-soft text-app-accent'
                      : 'border-border bg-card text-muted hover:text-title hover:border-border-strong'
                    }`}
                >
                  <span className="flex items-center gap-2">
                    <span className={`w-4 h-4 rounded border-2 flex items-center justify-center text-xs ${quizTypes.includes(type) ? 'border-app-accent bg-app-accent text-white' : 'border-border-strong'
                      }`}>
                      {quizTypes.includes(type) && '✓'}
                    </span>
                    {quizTypeLabels[type]}
                  </span>
                </button>
              ))}
            </div>
          </div>

          <button
            onClick={startQuiz}
            className="w-full py-3 bg-title hover:bg-[#2A3250] text-white rounded-lg font-serif text-sm transition-colors"
          >
            Bắt đầu Quiz
          </button>
        </div>
      </div>
    )
  }

  // Results screen
  if (isFinished) {
    const percentage = Math.round((score / questions.length) * 100)
    let emoji = '🎉'
    let message = 'Xuất sắc!'
    if (percentage < 50) { emoji = '💪'; message = 'Cần luyện tập thêm!' }
    else if (percentage < 80) { emoji = '👍'; message = 'Khá tốt!' }
    else if (percentage < 100) { emoji = '🔥'; message = 'Rất giỏi!' }

    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <Link
            href="/radicals"
            className="flex items-center gap-2 text-muted hover:text-app-accent transition-colors font-serif text-sm"
          >
            <ChevronLeft className="w-4 h-4" />
            Danh sách bộ thủ
          </Link>
        </div>

        <div className="bg-card border border-border rounded-xl p-6 md:p-10 text-center space-y-6">
          <div className="text-6xl">{emoji}</div>
          <div className="space-y-2">
            <h2 className="text-2xl font-serif text-title">{message}</h2>
            <p className="text-muted font-serif">
              Bạn trả lời đúng <span className="text-title font-medium">{score}</span> / <span className="text-title font-medium">{questions.length}</span> câu ({percentage}%)
            </p>
          </div>

          {/* Score visual */}
          <div className="max-w-xs mx-auto">
            <div className="w-full bg-track h-4 rounded-full overflow-hidden">
              <div
                className={`h-full rounded-full transition-all duration-500 ${percentage >= 80 ? 'bg-jade' : percentage >= 50 ? 'bg-gold' : 'bg-app-accent'
                  }`}
                style={{ width: `${percentage}%` }}
              />
            </div>
          </div>

          <div className="flex flex-col sm:flex-row gap-3 justify-center pt-2">
            <button
              onClick={startQuiz}
              className="flex items-center justify-center gap-2 px-6 py-2.5 bg-title hover:bg-[#2A3250] text-white rounded-lg font-serif text-sm transition-colors"
            >
              <RotateCcw className="w-4 h-4" />
              Làm lại
            </button>
            <Link
              href="/radicals"
              className="flex items-center justify-center gap-2 px-6 py-2.5 border border-border bg-card rounded-lg font-serif text-sm text-muted hover:text-title transition-all"
            >
              Về danh sách
            </Link>
          </div>
        </div>
      </div>
    )
  }

  // Quiz question screen
  const question = questions[currentQ]
  const isCorrect = selectedAnswer === question.correctIndex

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <Link
          href="/radicals"
          className="flex items-center gap-2 text-muted hover:text-app-accent transition-colors font-serif text-sm"
        >
          <ChevronLeft className="w-4 h-4" />
          Danh sách bộ thủ
        </Link>
        <div className="flex items-center gap-2 text-sm font-sans">
          <Trophy className="w-4 h-4 text-gold" />
          <span className="text-title font-medium">{score}</span>
          <span className="text-muted">/ {currentQ + (selectedAnswer !== null ? 1 : 0)}</span>
        </div>
      </div>

      {/* Progress */}
      <div className="space-y-1.5">
        <div className="flex justify-between text-xs text-muted font-sans">
          <span>Câu {currentQ + 1} / {questions.length}</span>
          <span>{Math.round(((currentQ + 1) / questions.length) * 100)}%</span>
        </div>
        <div className="w-full bg-track h-2 rounded-full overflow-hidden">
          <div
            className="bg-gradient-to-r from-app-accent to-[#D4553F] h-full rounded-full transition-all duration-300"
            style={{ width: `${((currentQ + 1) / questions.length) * 100}%` }}
          />
        </div>
      </div>

      {/* Question */}
      <div className="bg-card border border-border rounded-xl p-6 md:p-8 space-y-6">
        {/* Question prompt */}
        <div className="text-center space-y-3">
          <span className="inline-block px-3 py-1 rounded-full bg-accent-soft text-app-accent text-xs font-serif">
            {quizTypeLabels[question.type]}
          </span>

          {question.type === 'radical-to-meaning' && (
            <>
              <p className="text-muted font-serif text-sm">Bộ thủ này có nghĩa gì?</p>
              <span
                className="block text-7xl md:text-8xl font-serif text-title leading-none py-4"
                style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
              >
                {question.radical.radical}
              </span>
            </>
          )}

          {question.type === 'meaning-to-radical' && (
            <>
              <p className="text-muted font-serif text-sm">
                Chữ nào là bộ thủ có nghĩa <span className="text-title font-medium">&ldquo;{question.radical.meaning}&rdquo;</span>?
              </p>
            </>
          )}

          {question.type === 'pinyin-to-radical' && (
            <>
              <p className="text-muted font-serif text-sm">
                Chữ nào là bộ thủ đọc là <span className="text-title font-medium font-sans">{question.radical.pinyin}</span>?
              </p>
            </>
          )}
        </div>

        {/* Options */}
        <div className="grid grid-cols-2 gap-3">
          {question.options.map((option, index) => {
            let optionClass = 'border-border bg-card text-body hover:border-border-strong hover:bg-page'

            if (selectedAnswer !== null) {
              if (index === question.correctIndex) {
                optionClass = 'border-jade bg-jade-soft text-jade'
              } else if (index === selectedAnswer && !isCorrect) {
                optionClass = 'border-app-accent bg-accent-soft text-app-accent'
              } else {
                optionClass = 'border-border bg-card text-muted opacity-50'
              }
            }

            const isHanzi = question.type === 'meaning-to-radical' || question.type === 'pinyin-to-radical'

            return (
              <button
                key={index}
                onClick={() => handleAnswer(index)}
                disabled={selectedAnswer !== null}
                className={`relative p-4 border-2 rounded-xl text-center font-serif transition-all ${optionClass} ${selectedAnswer === null ? 'cursor-pointer' : 'cursor-default'
                  }`}
              >
                {selectedAnswer !== null && index === question.correctIndex && (
                  <CheckCircle className="absolute top-2 right-2 w-4 h-4 text-jade" />
                )}
                {selectedAnswer !== null && index === selectedAnswer && !isCorrect && (
                  <XCircle className="absolute top-2 right-2 w-4 h-4 text-app-accent" />
                )}
                <span
                  className={isHanzi ? 'text-3xl md:text-4xl' : 'text-sm md:text-base'}
                  style={isHanzi ? { fontFamily: 'var(--font-chinese), sans-serif' } : undefined}
                >
                  {option}
                </span>
              </button>
            )
          })}
        </div>

        {/* Explanation after answering */}
        {showExplanation && (
          <div className={`p-4 rounded-lg border ${isCorrect
              ? 'bg-jade-soft/50 border-jade/20'
              : 'bg-accent-soft/50 border-app-accent/20'
            }`}>
            <div className="flex items-start gap-2">
              {isCorrect ? (
                <CheckCircle className="w-5 h-5 text-jade flex-shrink-0 mt-0.5" />
              ) : (
                <XCircle className="w-5 h-5 text-app-accent flex-shrink-0 mt-0.5" />
              )}
              <div className="space-y-1">
                <p className={`text-sm font-medium ${isCorrect ? 'text-jade' : 'text-app-accent'}`}>
                  {isCorrect ? 'Chính xác!' : 'Sai rồi!'}
                </p>
                <p className="text-sm font-serif text-body">
                  <span style={{ fontFamily: 'var(--font-chinese), sans-serif' }} className="text-lg">
                    {question.radical.radical}
                  </span>{' '}
                  ({question.radical.pinyin}) — {question.radical.meaning}
                </p>
                <p className="text-xs font-serif text-muted">{question.radical.explanation}</p>
              </div>
            </div>
          </div>
        )}

        {/* Next button */}
        {selectedAnswer !== null && (
          <button
            onClick={goNext}
            className="w-full flex items-center justify-center gap-2 py-3 bg-title hover:bg-[#2A3250] text-white rounded-lg font-serif text-sm transition-colors"
          >
            {currentQ < questions.length - 1 ? (
              <>
                Câu tiếp theo
                <ArrowRight className="w-4 h-4" />
              </>
            ) : (
              'Xem kết quả'
            )}
          </button>
        )}
      </div>
    </div>
  )
}
