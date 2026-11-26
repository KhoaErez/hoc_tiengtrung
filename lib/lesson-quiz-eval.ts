// Hàm đánh giá đáp án thuần túy (stateless) cho 3 dạng câu hỏi trong Lesson Player
// Cho phép tái sử dụng đồng bộ giữa UI Lesson Player và Unit Tests.

import type {
  CourseQuizQuestion,
  MultipleChoiceQuizQuestion,
  WordBankQuizQuestion,
  TypingQuizQuestion,
} from '@/data/course-roadmap-data'
import { sanitizeTargetText, isTypingCharMatch } from '@/lib/typing-text-utils'

export interface QuizEvalResult {
  isCorrect: boolean
  correctAnswerDisplay: string
  explanationVi: string
}

/**
 * Chuẩn hóa chuỗi tiếng Trung trước khi so khớp ở bài tập Ghép từ & Gõ IME
 * (bỏ khoảng trắng giữa ký tự Hán và hỗ trợ đối chiếu tương đương dấu câu half/full-width)
 */
export function normalizeChineseQuizInput(raw: string): string {
  return sanitizeTargetText(raw).replace(/\s+/g, '')
}

export function isChineseSentenceEquivalent(actualRaw: string, expectedRaw: string): boolean {
  const actual = Array.from(normalizeChineseQuizInput(actualRaw))
  const expected = Array.from(normalizeChineseQuizInput(expectedRaw))

  if (expected.length === 0 || actual.length === 0) return false
  if (actual.length !== expected.length) return false

  return expected.every((expectedChar, idx) => isTypingCharMatch(actual[idx], expectedChar, true))
}

export function evaluateMultipleChoice(
  question: MultipleChoiceQuizQuestion,
  selectedOptionId: string | null
): QuizEvalResult {
  const correctOpt = question.options.find((opt) => opt.id === question.correctOptionId)
  const display = correctOpt
    ? `${correctOpt.hanzi}${correctOpt.labelVi ? ` (${correctOpt.labelVi})` : ''}`
    : ''

  return {
    isCorrect: Boolean(selectedOptionId && selectedOptionId === question.correctOptionId),
    correctAnswerDisplay: display,
    explanationVi: question.explanationVi,
  }
}

export function evaluateWordBank(
  question: WordBankQuizQuestion,
  selectedTokens: string[]
): QuizEvalResult {
  const joinedExpected = question.targetTokens.join('')
  const joinedActual = selectedTokens.join('')

  return {
    isCorrect: isChineseSentenceEquivalent(joinedActual, joinedExpected),
    correctAnswerDisplay: joinedExpected,
    explanationVi: question.explanationVi,
  }
}

export function evaluateTypingQuiz(
  question: TypingQuizQuestion,
  userInput: string
): QuizEvalResult {
  return {
    isCorrect: isChineseSentenceEquivalent(userInput, question.expectedHanzi),
    correctAnswerDisplay: question.expectedHanzi,
    explanationVi: question.explanationVi,
  }
}

export function evaluateLessonQuiz(
  question: CourseQuizQuestion,
  answer: {
    selectedOptionId?: string | null
    selectedWordBankTokens?: string[]
    typingInput?: string
  }
): QuizEvalResult {
  if (question.type === 'multiple_choice') {
    return evaluateMultipleChoice(question, answer.selectedOptionId ?? null)
  }
  if (question.type === 'word_bank') {
    return evaluateWordBank(question, answer.selectedWordBankTokens ?? [])
  }
  return evaluateTypingQuiz(question, answer.typingInput ?? '')
}
