// Bộ chuyển đổi dữ liệu bài học Supabase (/lessons/[id]) sang cấu trúc bài học tương tác SuperChinese:
// Từ vựng -> Vẽ chữ (HanziWriter) -> Hội thoại ví dụ -> Bài tập 3 dạng (Trắc nghiệm, Sắp xếp từ thành câu, Gõ IME) -> Tổng kết & SM-2.

import type {
  CourseLesson,
  CourseUnit,
  CourseVocabItem,
  CourseDialogueLine,
  CourseQuizQuestion,
} from '@/data/course-roadmap-data'
import { sanitizeTargetText } from '@/lib/typing-text-utils'

export interface SystemLessonVocabInput {
  id: string
  hanzi: string
  pinyin: string
  meaning_vi: string
  example_hanzi?: string | null
  example_pinyin?: string | null
  example_vi?: string | null
}

export interface SystemLessonMetaInput {
  id: string
  title: string
  subtitle?: string | null
  hsk_level: string
  lesson_number: number
}

const DEFAULT_CHUNK_SIZE = 4

function deterministicHash(seedText: string): number {
  let h = 2166136261
  for (let i = 0; i < seedText.length; i++) {
    h ^= seedText.charCodeAt(i)
    h = Math.imul(h, 16777619)
  }
  return h >>> 0
}

/**
 * Tách câu tiếng Trung thành các mảnh thẻ từ tự nhiên cho bài tập "Sắp xếp từ thành câu" (Word Bank).
 * - Ưu tiên Intl.Segmenter('zh-CN', { granularity: 'word' })
 * - Gộp dấu câu liền sau vào mảnh từ ngay trước để không tạo thẻ chỉ có dấu câu rời rạc
 * - Giới hạn 3–6 mảnh từ dễ thao tác trên cả desktop & mobile
 */
export function segmentChineseSentenceForWordBank(
  rawSentence: string,
  knownVocabHanzi: string[] = []
): string[] {
  const cleaned = sanitizeTargetText(rawSentence).replace(/\s+/g, '')
  if (!cleaned) return []

  const rawTokens: string[] = []
  const IntlWithSeg = Intl as unknown as {
    Segmenter?: new (
      locale: string,
      opts: { granularity: 'word' | 'grapheme' | 'sentence' }
    ) => { segment: (text: string) => Iterable<{ segment: string }> }
  }

  if (typeof IntlWithSeg.Segmenter === 'function') {
    const segmenter = new IntlWithSeg.Segmenter('zh-CN', { granularity: 'word' })
    for (const part of segmenter.segment(cleaned)) {
      if (part.segment) rawTokens.push(part.segment)
    }
  } else {
    // Fallback nhẹ nếu runtime không có Intl.Segmenter: ưu tiên khớp từ vựng đã học dài nhất
    const sortedKnown = [...knownVocabHanzi]
      .filter((w) => w && w.length >= 2)
      .sort((a, b) => b.length - a.length)

    let i = 0
    while (i < cleaned.length) {
      const slice = cleaned.slice(i)
      const matched = sortedKnown.find((w) => slice.startsWith(w))
      if (matched) {
        rawTokens.push(matched)
        i += matched.length
      } else {
        rawTokens.push(cleaned[i])
        i += 1
      }
    }
  }

  // Gộp dấu câu (，。！？；：、) vào mảnh đứng ngay trước nó
  const mergedTokens: string[] = []
  const punctRegex = /^[，。！？；：、,.!?;:]+$/
  for (const tok of rawTokens) {
    if (punctRegex.test(tok) && mergedTokens.length > 0) {
      mergedTokens[mergedTokens.length - 1] += tok
    } else {
      mergedTokens.push(tok)
    }
  }

  // Nếu quá ít mảnh (< 2) trên câu dài >= 3 ký tự, tách thành từng chữ đơn để vẫn chơi ghép câu được
  if (mergedTokens.length < 2 && Array.from(cleaned).length >= 3) {
    const chars = Array.from(cleaned)
    const fallbackOut: string[] = []
    for (const ch of chars) {
      if (punctRegex.test(ch) && fallbackOut.length > 0) {
        fallbackOut[fallbackOut.length - 1] += ch
      } else {
        fallbackOut.push(ch)
      }
    }
    return fallbackOut
  }

  // Nếu quá nhiều mảnh (> 6), gộp bớt cặp ngắn liên tiếp để vừa màn hình
  const compactTokens = [...mergedTokens]
  while (compactTokens.length > 6) {
    let shortestPairIdx = 0
    let shortestLen = Infinity
    for (let i = 0; i < compactTokens.length - 1; i++) {
      const len = compactTokens[i].length + compactTokens[i + 1].length
      if (len < shortestLen) {
        shortestLen = len
        shortestPairIdx = i
      }
    }
    compactTokens.splice(
      shortestPairIdx,
      2,
      compactTokens[shortestPairIdx] + compactTokens[shortestPairIdx + 1]
    )
  }

  return compactTokens
}

export interface DynamicLessonChunkResult {
  lesson: CourseLesson
  unit: CourseUnit
  chunkIndex: number
  totalChunks: number
  chunkVocabIds: string[]
}

/**
 * Chia danh sách từ vựng của một bài học hệ thống (/lessons/[id]) thành các Chặng (mỗi chặng ~4 từ)
 * và sinh đầy đủ 5 bước chuẩn SuperChinese: Vocab -> Vẽ chữ -> Hội thoại -> Quiz 3 dạng -> Summary SM-2.
 */
export function buildDynamicCourseLessonChunk(
  meta: SystemLessonMetaInput,
  allVocabularies: SystemLessonVocabInput[],
  chunkIndex: number = 0,
  chunkSize: number = DEFAULT_CHUNK_SIZE
): DynamicLessonChunkResult {
  const safeChunkSize = Math.max(1, chunkSize)
  const totalChunks = Math.max(1, Math.ceil(allVocabularies.length / safeChunkSize))
  const safeChunkIndex = Math.max(0, Math.min(totalChunks - 1, chunkIndex))

  const start = safeChunkIndex * safeChunkSize
  const chunkRaw = allVocabularies.slice(start, start + safeChunkSize)
  const knownHanzi = allVocabularies.map((v) => v.hanzi)

  const courseVocabs: CourseVocabItem[] = chunkRaw.map((v) => ({
    id: v.id,
    hanzi: v.hanzi,
    pinyin: v.pinyin,
    meaningVi: v.meaning_vi,
    partOfSpeech: 'Từ vựng trọng tâm',
    exampleHanzi: (v.example_hanzi && v.example_hanzi.trim()) || v.hanzi,
    examplePinyin: (v.example_pinyin && v.example_pinyin.trim()) || v.pinyin,
    exampleVi: (v.example_vi && v.example_vi.trim()) || v.meaning_vi,
  }))

  // Chọn tối đa 2 từ tiêu biểu có chữ Hán trong chặng để luyện vẽ nét bằng HanziWriter
  const writeWords: CourseVocabItem[] = courseVocabs
    .filter((v) => /[\u4e00-\u9fff]/.test(v.hanzi))
    .slice(0, 2)

  // Dựng Hội thoại ngắn từ câu ví dụ thực tế của các từ trong chặng
  const exampleEntries = courseVocabs.filter((v) => v.exampleHanzi && v.exampleHanzi !== v.hanzi)
  const dialogueSource = exampleEntries.length >= 2 ? exampleEntries : courseVocabs
  const dialogueLines: CourseDialogueLine[] = dialogueSource.slice(0, 5).map((v, idx) => ({
    id: `${meta.id}-ch${safeChunkIndex}-dlg-${idx}`,
    speaker: idx % 2 === 0 ? 'A' : 'B',
    roleName: idx % 2 === 0 ? 'Tiểu Minh' : 'Tiểu Lan',
    hanzi: v.exampleHanzi,
    pinyin: v.examplePinyin,
    meaningVi: v.exampleVi,
  }))

  // Dựng tối thiểu 3 bài tập đủ 3 dạng (Trắc nghiệm, Sắp xếp từ thành câu, Gõ IME)
  const quizzes: CourseQuizQuestion[] = []

  // 1. Trắc nghiệm chọn từ đúng
  const mcTarget = courseVocabs[0]
  if (mcTarget) {
    const distractorsPool = allVocabularies.filter((v) => v.id !== mcTarget.id)
    const offset = deterministicHash(`${meta.id}-mc-${safeChunkIndex}`) % Math.max(1, distractorsPool.length)
    const pickedDistractors: SystemLessonVocabInput[] = []
    for (let i = 0; i < distractorsPool.length && pickedDistractors.length < 3; i++) {
      pickedDistractors.push(distractorsPool[(offset + i) % distractorsPool.length])
    }

    const rawOptions = [
      { id: 'opt-target', hanzi: mcTarget.hanzi, pinyin: mcTarget.pinyin, labelVi: mcTarget.meaningVi },
      ...pickedDistractors.map((d, i) => ({
        id: `opt-dist-${i}`,
        hanzi: d.hanzi,
        pinyin: d.pinyin,
        labelVi: d.meaning_vi,
      })),
    ]

    // Xáo trộn 4 đáp án có tính tất định
    const swapIdx = deterministicHash(`${meta.id}-order-${safeChunkIndex}`) % rawOptions.length
    const first = rawOptions[0]
    rawOptions[0] = rawOptions[swapIdx]
    rawOptions[swapIdx] = first

    quizzes.push({
      id: `${meta.id}-ch${safeChunkIndex}-q-mc`,
      type: 'multiple_choice',
      promptVi: `Nghe phát âm hoặc đọc nghĩa sau và chọn chữ Hán đúng: "${mcTarget.meaningVi}"`,
      promptSub: 'Hãy bấm loa để nghe phát âm chuẩn trước khi chọn',
      audioText: mcTarget.hanzi,
      options: rawOptions,
      correctOptionId: 'opt-target',
      explanationVi: `${mcTarget.hanzi} (${mcTarget.pinyin}) có nghĩa là "${mcTarget.meaningVi}".`,
    })
  }

  // 2. Sắp xếp từ thành câu (Word Bank) — ưu tiên từ có câu ví dụ dài >= 3 chữ
  const wordBankCandidate =
    courseVocabs.find((v) => Array.from(sanitizeTargetText(v.exampleHanzi)).length >= 4) ||
    courseVocabs[1] ||
    courseVocabs[0]

  if (wordBankCandidate) {
    const sentenceToSort = wordBankCandidate.exampleHanzi
    const tokens = segmentChineseSentenceForWordBank(sentenceToSort, knownHanzi)
    const extraDistractors = courseVocabs
      .filter((v) => v.hanzi !== wordBankCandidate.hanzi && !sentenceToSort.includes(v.hanzi))
      .slice(0, 2)
      .map((v) => v.hanzi)

    if (tokens.length >= 2) {
      quizzes.push({
        id: `${meta.id}-ch${safeChunkIndex}-q-wb`,
        type: 'word_bank',
        promptVi: `Sắp xếp các thẻ từ thành câu: "${wordBankCandidate.exampleVi}"`,
        audioText: sentenceToSort,
        targetTokens: tokens,
        distractorTokens: extraDistractors,
        pinyinAnswer: wordBankCandidate.examplePinyin,
        explanationVi: `Câu hoàn chỉnh: ${sentenceToSort} (${wordBankCandidate.examplePinyin}).`,
      })
    } else if (courseVocabs.length > 1) {
      // Nếu câu ví dụ quá ngắn 1-2 ký tự -> ghép 1 câu trắc nghiệm bổ sung cho đủ bài tập
      const secondMc = courseVocabs[1]
      const pool = allVocabularies.filter((v) => v.id !== secondMc.id).slice(0, 3)
      quizzes.push({
        id: `${meta.id}-ch${safeChunkIndex}-q-mc2`,
        type: 'multiple_choice',
        promptVi: `Từ nào dưới đây có nghĩa là "${secondMc.meaningVi}"?`,
        audioText: secondMc.hanzi,
        options: [
          ...pool.map((d, i) => ({ id: `d-${i}`, hanzi: d.hanzi, pinyin: d.pinyin, labelVi: d.meaning_vi })),
          { id: 'target', hanzi: secondMc.hanzi, pinyin: secondMc.pinyin, labelVi: secondMc.meaningVi },
        ],
        correctOptionId: 'target',
        explanationVi: `${secondMc.hanzi} (${secondMc.pinyin}) — ${secondMc.meaningVi}.`,
      })
    }
  }

  // 3. Gõ câu / từ bằng bộ gõ Pinyin IME
  const typingCandidate = courseVocabs[courseVocabs.length > 2 ? 2 : 0]
  if (typingCandidate) {
    const useExampleSentence =
      typingCandidate.exampleHanzi &&
      typingCandidate.exampleHanzi !== typingCandidate.hanzi &&
      Array.from(sanitizeTargetText(typingCandidate.exampleHanzi)).length <= 14
    const targetText = useExampleSentence ? typingCandidate.exampleHanzi : typingCandidate.hanzi
    const targetPinyin = useExampleSentence ? typingCandidate.examplePinyin : typingCandidate.pinyin
    const targetMeaning = useExampleSentence ? typingCandidate.exampleVi : typingCandidate.meaningVi

    quizzes.push({
      id: `${meta.id}-ch${safeChunkIndex}-q-type`,
      type: 'typing',
      promptVi: `Dùng bộ gõ tiếng Trung (Pinyin IME) gõ lại: "${targetMeaning}"`,
      hintKeyword: targetPinyin,
      expectedHanzi: targetText,
      expectedPinyin: targetPinyin,
      explanationVi: `Đáp án chuẩn: ${targetText} (${targetPinyin}).`,
    })
  }

  const isFactory = /công\s*xưởng/i.test(meta.hsk_level || '')
  const hskMatch = (meta.hsk_level || '').match(/\d+/)
  const hskLevelNum = hskMatch ? parseInt(hskMatch[0], 10) : 1

  const unit: CourseUnit = {
    id: `sys-unit-${meta.id}`,
    track: isFactory ? 'factory' : 'hsk',
    hskLevel: isFactory ? undefined : hskLevelNum,
    unitNumber: meta.lesson_number || 1,
    title: `${meta.hsk_level} • Bài ${meta.lesson_number || 1}`,
    titleZh: meta.title,
    description: meta.subtitle || 'Học tương tác theo từng chặng nhỏ theo chuẩn SuperChinese.',
    lessons: [],
  }

  const lesson: CourseLesson = {
    id: `sys-${meta.id}-chunk-${safeChunkIndex}`,
    track: isFactory ? 'factory' : 'hsk',
    hskLevel: isFactory ? undefined : hskLevelNum,
    unitId: unit.id,
    lessonNumber: meta.lesson_number || 1,
    title:
      totalChunks > 1
        ? `${meta.title} (Chặng ${safeChunkIndex + 1}/${totalChunks})`
        : meta.title,
    titleZh: courseVocabs.map((v) => v.hanzi).join(' · '),
    subtitle: `${courseVocabs.length} từ trọng tâm • Vẽ chữ • Sắp xếp câu • Gõ IME`,
    estimatedMinutes: Math.max(4, courseVocabs.length * 2),
    vocabs: courseVocabs,
    writeWords,
    dialogue: {
      title: `Luyện nghe mẫu câu — ${meta.title}`,
      context: 'Bấm vào từng câu để nghe giọng chuẩn và ghi nhớ cách dùng trong ngữ cảnh.',
      lines: dialogueLines,
    },
    quizzes,
  }

  return {
    lesson,
    unit,
    chunkIndex: safeChunkIndex,
    totalChunks,
    chunkVocabIds: chunkRaw.map((v) => v.id),
  }
}
