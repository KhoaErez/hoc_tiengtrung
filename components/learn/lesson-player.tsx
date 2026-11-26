'use client'

import React, { useState, useEffect, useMemo, useCallback, useRef } from 'react'
import Link from 'next/link'
import {
  X,
  ArrowLeft,
  ArrowRight,
  CheckCircle2,
  XCircle,
  Eye,
  EyeOff,
} from 'lucide-react'
import type {
  CourseLesson,
  CourseUnit,
  CourseVocabItem,
  CourseDialogueData,
  CourseQuizQuestion,
} from '@/data/course-roadmap-data'
import {
  getLessonProgress,
  saveLessonProgress,
  calculateCourseStepPercent,
} from '@/lib/course-progress-storage'
import { evaluateLessonQuiz, type QuizEvalResult } from '@/lib/lesson-quiz-eval'
import { playTypingSfx } from '@/lib/typing-sound'
import { ttsEngine } from '@/lib/tts/tts-engine'
import { VocabStep } from './steps/vocab-step'
import { StrokeWritingStep } from './steps/stroke-writing-step'
import { DialogueStep } from './steps/dialogue-step'
import { QuizStep, type WordBankSelectionItem } from './steps/quiz-step'
import { SummaryStep } from './steps/summary-step'

type PlayerStep =
  | { kind: 'vocab'; vocab: CourseVocabItem; vocabIdx: number }
  | { kind: 'write'; vocab: CourseVocabItem; writeIdx: number }
  | { kind: 'dialogue'; dialogue: CourseDialogueData }
  | { kind: 'quiz'; question: CourseQuizQuestion; quizIdx: number }
  | { kind: 'summary' }

interface LessonPlayerProps {
  lesson: CourseLesson
  unit: CourseUnit
  nextLesson: CourseLesson | null
  isLoggedIn: boolean
  onClose?: () => void
  onCustomSaveSm2?: () => Promise<boolean>
  customNextActionLabel?: string
  onCustomNextAction?: () => void
}

export default function LessonPlayer({
  lesson,
  unit,
  nextLesson,
  isLoggedIn,
  onClose,
  onCustomSaveSm2,
  customNextActionLabel,
  onCustomNextAction,
}: LessonPlayerProps) {
  const writeWords = useMemo(() => {
    if (Array.isArray(lesson.writeWords)) return lesson.writeWords
    return lesson.vocabs.filter((v) => /[\u4e00-\u9fff]/.test(v.hanzi)).slice(0, 2)
  }, [lesson])

  const steps: PlayerStep[] = useMemo(() => {
    const list: PlayerStep[] = []
    lesson.vocabs.forEach((vocab, vocabIdx) => {
      list.push({ kind: 'vocab', vocab, vocabIdx })
    })
    writeWords.forEach((vocab, writeIdx) => {
      list.push({ kind: 'write', vocab, writeIdx })
    })
    if (lesson.dialogue.lines.length > 0) {
      list.push({ kind: 'dialogue', dialogue: lesson.dialogue })
    }
    lesson.quizzes.forEach((question, quizIdx) => {
      list.push({ kind: 'quiz', question, quizIdx })
    })
    list.push({ kind: 'summary' })
    return list
  }, [lesson, writeWords])

  const totalSteps = steps.length

  const [stepIndex, setStepIndex] = useState<number>(0)
  const [showPinyin, setShowPinyin] = useState<boolean>(true)
  const [elapsedSeconds, setElapsedSeconds] = useState<number>(0)
  const [savedSm2Done, setSavedSm2Done] = useState<boolean>(false)

  // Trạng thái trả lời từng bước Quiz
  const [selectedOptionId, setSelectedOptionId] = useState<string | null>(null)
  const [selectedBankItems, setSelectedBankItems] = useState<WordBankSelectionItem[]>([])
  const [typingInput, setTypingInput] = useState<string>('')
  const [quizFeedback, setQuizFeedback] = useState<QuizEvalResult | null>(null)
  const [quizScores, setQuizScores] = useState<Record<string, boolean>>({})
  const hasHydratedProgressRef = useRef<boolean>(false)

  // Khôi phục bước đang học dở an toàn trước khi cho phép ghi tiến độ mới
  useEffect(() => {
    const existing = getLessonProgress(lesson.id)
    const timerId = window.setTimeout(() => {
      if (existing) {
        if (existing.savedToSm2) {
          setSavedSm2Done(true)
        }
        if (!existing.completed && existing.currentStepIndex > 0 && existing.currentStepIndex < totalSteps - 1) {
          setStepIndex(existing.currentStepIndex)
        }
      }
      hasHydratedProgressRef.current = true
    }, 0)

    return () => {
      window.clearTimeout(timerId)
      ttsEngine.stop()
    }
  }, [lesson.id, totalSteps])

  // Bộ đếm thời gian học
  const currentStep = steps[stepIndex] || steps[0]
  const isSummaryStep = currentStep?.kind === 'summary'

  useEffect(() => {
    if (isSummaryStep) return
    const timer = window.setInterval(() => {
      setElapsedSeconds((prev) => prev + 1)
    }, 1000)
    return () => window.clearInterval(timer)
  }, [isSummaryStep])

  // Lưu tiến độ tự động sau khi đã khôi phục xong tiến độ ban đầu
  useEffect(() => {
    if (!hasHydratedProgressRef.current) return
    const percent = calculateCourseStepPercent(stepIndex, totalSteps, isSummaryStep)
    const correctQuizCount = Object.values(quizScores).filter(Boolean).length
    const accuracy =
      lesson.quizzes.length > 0
        ? Math.round((correctQuizCount / lesson.quizzes.length) * 100)
        : 100

    saveLessonProgress({
      lessonId: lesson.id,
      currentStepIndex: stepIndex,
      totalSteps,
      percent,
      completed: isSummaryStep,
      accuracy: isSummaryStep ? accuracy : undefined,
      savedToSm2: savedSm2Done,
    })
  }, [stepIndex, totalSteps, isSummaryStep, lesson.id, lesson.quizzes.length, quizScores, savedSm2Done])

  const resetQuizDraftForStep = useCallback(() => {
    setSelectedOptionId(null)
    setSelectedBankItems([])
    setTypingInput('')
    setQuizFeedback(null)
  }, [])

  const goToStep = useCallback(
    (nextIdx: number) => {
      ttsEngine.stop()
      const bounded = Math.max(0, Math.min(totalSteps - 1, nextIdx))
      setStepIndex(bounded)
      resetQuizDraftForStep()
      if (bounded === totalSteps - 1) {
        playTypingSfx('complete')
      }
    },
    [totalSteps, resetQuizDraftForStep]
  )

  const handleRestartLesson = () => {
    setQuizScores({})
    setElapsedSeconds(0)
    goToStep(0)
  }

  // Kiểm tra câu hỏi Quiz hiện tại
  const handleCheckQuiz = useCallback(() => {
    if (currentStep.kind !== 'quiz' || quizFeedback) return
    const result = evaluateLessonQuiz(currentStep.question, {
      selectedOptionId,
      selectedWordBankTokens: selectedBankItems.map((i) => i.text),
      typingInput,
    })

    setQuizFeedback(result)
    setQuizScores((prev) => ({
      ...prev,
      [currentStep.question.id]: result.isCorrect,
    }))
    playTypingSfx(result.isCorrect ? 'correct' : 'error')
  }, [currentStep, quizFeedback, selectedOptionId, selectedBankItems, typingInput])

  const hasCurrentQuizAnswer = useMemo(() => {
    if (currentStep.kind !== 'quiz') return true
    if (currentStep.question.type === 'multiple_choice') {
      return Boolean(selectedOptionId)
    }
    if (currentStep.question.type === 'word_bank') {
      return selectedBankItems.length > 0
    }
    return typingInput.trim().length > 0
  }, [currentStep, selectedOptionId, selectedBankItems, typingInput])

  const progressPercent = Math.round(((stepIndex + 1) / Math.max(1, totalSteps)) * 100)
  const roadmapHref =
    lesson.track === 'factory'
      ? '/learn?track=factory'
      : `/learn?track=hsk&level=${lesson.hskLevel || 1}`

  const correctQuizCount = Object.values(quizScores).filter(Boolean).length

  return (
    <div className="min-h-screen flex flex-col">
      {/* 1. TOP BAR TỐI GIẢN (Focus Mode: ×, Progress Bar mượt, X / Y, Nút Pinyin) */}
      <header className="sticky top-0 z-30 bg-[#FAF9F6]/95 dark:bg-[#0D1322]/95 backdrop-blur-md border-b border-stone-200 dark:border-white/10">
        <div className="max-w-3xl mx-auto px-4 py-3 flex items-center gap-3 sm:gap-4">
          {/* Nút đóng (×) */}
          {onClose ? (
            <button
              type="button"
              onClick={() => {
                ttsEngine.stop()
                onClose()
              }}
              aria-label="Thoát chế độ học"
              className="w-10 h-10 rounded-xl bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] flex items-center justify-center text-stone-900 dark:text-white hover:bg-stone-100 shadow-[0_2px_0_#1c1917] active:translate-y-0.5 transition-all shrink-0 cursor-pointer"
              title="Thoát chế độ học"
            >
              <X className="w-5 h-5" />
            </button>
          ) : (
            <Link
              href={roadmapHref}
              onClick={() => ttsEngine.stop()}
              aria-label="Thoát về lộ trình bài học"
              className="w-10 h-10 rounded-xl bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] flex items-center justify-center text-stone-900 dark:text-white hover:bg-stone-100 shadow-[0_2px_0_#1c1917] active:translate-y-0.5 transition-all shrink-0"
              title="Quay lại Lộ trình bài học"
            >
              <X className="w-5 h-5" />
            </Link>
          )}

          {/* Thanh Progress Bar mượt ở giữa + Step Counter */}
          <div className="flex-1 min-w-0 flex items-center gap-3">
            <div
              className="flex-1 h-3.5 bg-white dark:bg-[#182238] border-2 border-stone-900 dark:border-[#384869] rounded-full overflow-hidden p-0.5"
              role="progressbar"
              aria-valuenow={stepIndex + 1}
              aria-valuemin={1}
              aria-valuemax={totalSteps}
            >
              <div
                className="h-full bg-[#B91C1C] rounded-full transition-all duration-300 ease-out"
                style={{ width: `${progressPercent}%` }}
              />
            </div>

            <span className="text-xs sm:text-sm font-sans font-bold text-stone-900 dark:text-white tabular-nums shrink-0">
              {stepIndex + 1} / {totalSteps}
            </span>
          </div>

          {/* Nút bật/tắt Pinyin */}
          <button
            type="button"
            onClick={() => setShowPinyin((prev) => !prev)}
            className={`inline-flex items-center gap-1.5 px-3 py-2 rounded-xl border-2 text-xs font-serif font-bold transition-all cursor-pointer min-h-[40px] shrink-0 touch-manipulation ${
              showPinyin
                ? 'bg-[#B91C1C] text-white border-stone-900 shadow-[0_2px_0_#1c1917]'
                : 'bg-white dark:bg-[#182238] text-stone-800 dark:text-slate-200 border-stone-900 dark:border-[#384869] hover:bg-stone-100'
            }`}
            title={showPinyin ? 'Ẩn phiên âm Pinyin' : 'Hiện phiên âm Pinyin'}
          >
            {showPinyin ? <Eye className="w-3.5 h-3.5" /> : <EyeOff className="w-3.5 h-3.5" />}
            <span>Pinyin</span>
          </button>
        </div>
      </header>

      {/* 2. VÙNG NỘI DUNG CHÍNH CĂN GIỮA (max-w-3xl mx-auto) */}
      <div className="flex-1 w-full max-w-3xl mx-auto px-4 py-6 sm:py-8 pb-36 space-y-4">
        {/* Thông tin bài học nhỏ gọn */}
        <div className="flex items-center justify-between gap-2 text-xs font-serif text-stone-500 dark:text-slate-400 px-1">
          <span className="truncate font-semibold text-stone-700 dark:text-slate-300">
            {unit.title} • Bài {lesson.lessonNumber}: {lesson.title}
          </span>
        </div>

        {/* Render theo loại bước hiện tại */}
        {currentStep.kind === 'vocab' && (
          <VocabStep
            vocab={currentStep.vocab}
            showPinyin={showPinyin}
            stepNumberInVocab={currentStep.vocabIdx + 1}
            totalVocabCount={lesson.vocabs.length}
          />
        )}

        {currentStep.kind === 'write' && (
          <StrokeWritingStep
            key={currentStep.vocab.id}
            vocab={currentStep.vocab}
            showPinyin={showPinyin}
            stepLabel={`Luyện vẽ chữ ${currentStep.writeIdx + 1}/${writeWords.length}`}
          />
        )}

        {currentStep.kind === 'dialogue' && (
          <DialogueStep
            dialogue={currentStep.dialogue}
            showPinyin={showPinyin}
            onTogglePinyin={() => setShowPinyin((prev) => !prev)}
          />
        )}

        {currentStep.kind === 'quiz' && (
          <QuizStep
            question={currentStep.question}
            quizNumber={currentStep.quizIdx + 1}
            totalQuizzes={lesson.quizzes.length}
            showPinyin={showPinyin}
            isChecked={Boolean(quizFeedback)}
            isCorrectResult={quizFeedback?.isCorrect}
            selectedOptionId={selectedOptionId}
            onSelectOption={setSelectedOptionId}
            selectedBankItems={selectedBankItems}
            onUpdateBankItems={setSelectedBankItems}
            typingInput={typingInput}
            onChangeTypingInput={setTypingInput}
            onTriggerCheckOrNext={() => {
              if (!quizFeedback) {
                if (hasCurrentQuizAnswer) handleCheckQuiz()
              } else {
                goToStep(stepIndex + 1)
              }
            }}
          />
        )}

        {currentStep.kind === 'summary' && (
          <SummaryStep
            lesson={lesson}
            nextLesson={nextLesson}
            correctQuizCount={correctQuizCount}
            totalQuizCount={lesson.quizzes.length}
            elapsedSeconds={elapsedSeconds}
            isLoggedIn={isLoggedIn}
            initialSavedSm2={savedSm2Done}
            onSavedSm2Success={() => setSavedSm2Done(true)}
            onRestartLesson={handleRestartLesson}
            onCustomSaveSm2={onCustomSaveSm2}
            customNextActionLabel={customNextActionLabel}
            onCustomNextAction={onCustomNextAction}
            onClosePlayer={onClose}
          />
        )}
      </div>

      {/* 3. BOTTOM ACTION BAR CỐ ĐỊNH Ở ĐÁY + FEEDBACK DRAWER */}
      {!isSummaryStep && (
        <div
          className={`fixed bottom-0 left-0 right-0 z-30 border-t-2 transition-colors duration-200 pb-[env(safe-area-inset-bottom,0px)] ${
            quizFeedback
              ? quizFeedback.isCorrect
                ? 'bg-emerald-50 dark:bg-emerald-950/95 border-emerald-600'
                : 'bg-red-50 dark:bg-red-950/95 border-[#B91C1C]'
              : 'bg-white/95 dark:bg-[#182238]/95 backdrop-blur-md border-stone-900 dark:border-[#384869]'
          }`}
        >
          <div className="max-w-3xl mx-auto px-4 py-3.5 sm:py-4 space-y-3">
            {/* Thanh phản hồi bật lên ngay sau khi bấm Kiểm tra */}
            {quizFeedback && (
              <div className="flex items-start gap-3 animate-in slide-in-from-bottom-2 duration-200">
                {quizFeedback.isCorrect ? (
                  <CheckCircle2 className="w-6 h-6 text-emerald-600 shrink-0 mt-0.5" />
                ) : (
                  <XCircle className="w-6 h-6 text-[#B91C1C] shrink-0 mt-0.5" />
                )}

                <div className="min-w-0 space-y-1 flex-1">
                  <div
                    className={`text-sm sm:text-base font-serif font-bold ${
                      quizFeedback.isCorrect ? 'text-emerald-900 dark:text-emerald-200' : 'text-[#991B1B] dark:text-red-200'
                    }`}
                  >
                    {quizFeedback.isCorrect ? 'Chính xác! Làm tốt lắm!' : 'Chưa chính xác'}
                  </div>

                  {!quizFeedback.isCorrect && quizFeedback.correctAnswerDisplay && (
                    <div className="text-xs sm:text-sm font-sans font-semibold text-stone-900 dark:text-white">
                      Đáp án đúng:{' '}
                      <span className="font-hanzi text-base text-[#B91C1C] dark:text-red-300">
                        {quizFeedback.correctAnswerDisplay}
                      </span>
                    </div>
                  )}

                  <p className="text-xs sm:text-sm font-serif text-stone-700 dark:text-slate-300 leading-snug">
                    {quizFeedback.explanationVi}
                  </p>
                </div>
              </div>
            )}

            {/* Hàng nút hành động */}
            <div className="flex items-center justify-between gap-3">
              {!quizFeedback && stepIndex > 0 ? (
                <button
                  type="button"
                  onClick={() => goToStep(stepIndex - 1)}
                  className="inline-flex items-center gap-1.5 px-4 py-2.5 rounded-xl bg-[#FAF7F2] dark:bg-[#202B45] border-2 border-stone-900 dark:border-[#384869] text-stone-900 dark:text-white text-xs sm:text-sm font-serif font-bold hover:bg-stone-100 cursor-pointer min-h-[48px] touch-manipulation"
                >
                  <ArrowLeft className="w-4 h-4" />
                  <span>Trước</span>
                </button>
              ) : (
                <div />
              )}

              {currentStep.kind === 'quiz' ? (
                !quizFeedback ? (
                  <button
                    type="button"
                    disabled={!hasCurrentQuizAnswer}
                    onClick={handleCheckQuiz}
                    className="flex-1 sm:flex-initial sm:min-w-[200px] min-h-[48px] px-6 py-2.5 rounded-xl bg-[#B91C1C] hover:bg-[#991B1B] disabled:opacity-40 disabled:cursor-not-allowed text-white border-2 border-stone-900 font-serif font-bold text-sm shadow-[0_3px_0_#1c1917] active:translate-y-0.5 transition-all cursor-pointer touch-manipulation"
                  >
                    Kiểm tra
                  </button>
                ) : (
                  <button
                    type="button"
                    onClick={() => goToStep(stepIndex + 1)}
                    className={`w-full sm:w-auto sm:min-w-[220px] min-h-[48px] px-6 py-2.5 rounded-xl text-white border-2 border-stone-900 font-serif font-bold text-sm shadow-[0_3px_0_#1c1917] active:translate-y-0.5 flex items-center justify-center gap-2 transition-all cursor-pointer touch-manipulation ${
                      quizFeedback.isCorrect
                        ? 'bg-emerald-600 hover:bg-emerald-700'
                        : 'bg-[#B91C1C] hover:bg-[#991B1B]'
                    }`}
                  >
                    <span>Tiếp tục</span>
                    <ArrowRight className="w-4 h-4" />
                  </button>
                )
              ) : (
                <button
                  type="button"
                  onClick={() => goToStep(stepIndex + 1)}
                  className="flex-1 sm:flex-initial sm:min-w-[200px] min-h-[48px] px-6 py-2.5 rounded-xl bg-[#B91C1C] hover:bg-[#991B1B] text-white border-2 border-stone-900 font-serif font-bold text-sm shadow-[0_3px_0_#1c1917] active:translate-y-0.5 flex items-center justify-center gap-2 transition-all cursor-pointer touch-manipulation"
                >
                  <span>Tiếp tục</span>
                  <ArrowRight className="w-4 h-4" />
                </button>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
