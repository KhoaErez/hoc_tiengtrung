// Mô hình câu & từ thống nhất (Unified Typing Sentence Model) trên fullCleanedText
// Đảm bảo chỉ mục globalCharIndex (UTF-16 & Code-point Array.from) khớp 1-1 giữa:
// - Chế độ hiển thị 1: Từng câu (Pinyin & Dịch)
// - Chế độ hiển thị 2: Cả đoạn dài (Tập trung gõ)
// - So sánh ký tự IME, Thống kê Đúng/Sai/Còn thiếu, Auto-speak Next & Web Speech TTS onboundary

import { pinyin } from 'pinyin-pro'
import { extractChineseSentences } from './typing-sound'
import { mapSegmentsToIndices } from './typing-gemini-validator'
import { segmentChineseText, segmentAndAlignChinese } from './tts/chinese-word-segmenter'
import type { TypingSegment } from './typing-storage'
import { buildIndexedChars, hasCjkCharacter, type IndexedCharMap } from './typing-text-utils'

export type TypingDisplayMode = 'sentence_cards' | 'continuous_paragraph'

export interface TypingWordUnit {
  index: number
  text: string
  /** Vị trí bắt đầu/kết thúc tương đối trong sentence.chinese (UTF-16) */
  startUtf16: number
  endUtf16: number
  /** Chỉ mục code-point toàn cục trên fullCleanedText (khớp 1-1 với Array.from) */
  startCp: number
  endCp: number
  isWord: boolean
  pinyin?: string
}

export interface UnifiedTypingSentence {
  index: number
  chinese: string
  pinyin: string
  meaning_vi?: string
  /** Vị trí UTF-16 toàn cục trên fullCleanedText */
  startIndex: number
  endIndex: number
  /** Vị trí code-point toàn cục trên fullCleanedText */
  startCp: number
  endCp: number
  words: TypingWordUnit[]
}

export interface BuildUnifiedSentencesOptions {
  segments?: TypingSegment[]
  presetPinyin?: string
  overallMeaning?: string
}

interface PinyinProSpan {
  startUtf16: number
  endUtf16: number
  pinyin: string
  isZh: boolean
}

/**
 * Sinh Pinyin có dấu thanh điệu chuẩn ngữ cảnh (đa âm tiết, biến điệu 一/不) bằng pinyin-pro
 * và căn chỉnh chính xác vào từng token từ tiếng Trung.
 */
function alignSentenceWordsWithPinyinPro(
  sentenceText: string,
  sentenceStartUtf16: number,
  indexedTarget: IndexedCharMap
): { words: TypingWordUnit[]; sentencePinyin: string } {
  const segWords = segmentChineseText(sentenceText)
  if (!sentenceText || !hasCjkCharacter(sentenceText)) {
    return {
      words: segWords.map((w) => ({
        index: w.index,
        text: w.text,
        startUtf16: w.startIndex,
        endUtf16: w.endIndex,
        startCp: indexedTarget.utf16ToCp(sentenceStartUtf16 + w.startIndex),
        endCp: indexedTarget.utf16ToCp(sentenceStartUtf16 + w.endIndex),
        isWord: w.isWord,
        pinyin: undefined,
      })),
      sentencePinyin: '',
    }
  }

  let charSpans: PinyinProSpan[] = []
  try {
    const rawData = pinyin(sentenceText, {
      type: 'all',
      toneType: 'symbol',
      toneSandhi: true,
    })
    let cursor = 0
    charSpans = rawData.map((entry) => {
      const len = entry.origin ? entry.origin.length : 1
      const span: PinyinProSpan = {
        startUtf16: cursor,
        endUtf16: cursor + len,
        pinyin: entry.isZh ? entry.pinyin : '',
        isZh: Boolean(entry.isZh),
      }
      cursor += len
      return span
    })
  } catch {
    charSpans = []
  }

  const pinyinPieces: string[] = []
  const words: TypingWordUnit[] = segWords.map((w) => {
    const startCp = indexedTarget.utf16ToCp(sentenceStartUtf16 + w.startIndex)
    const endCp = indexedTarget.utf16ToCp(sentenceStartUtf16 + w.endIndex)

    if (!w.isWord || !hasCjkCharacter(w.text) || charSpans.length === 0) {
      return {
        index: w.index,
        text: w.text,
        startUtf16: w.startIndex,
        endUtf16: w.endIndex,
        startCp,
        endCp,
        isWord: w.isWord,
        pinyin: undefined,
      }
    }

    const syllables = charSpans
      .filter((sp) => sp.isZh && sp.pinyin && sp.startUtf16 >= w.startIndex && sp.startUtf16 < w.endIndex)
      .map((sp) => sp.pinyin)

    const wordPinyin = syllables.length > 0 ? syllables.join(' ') : undefined
    if (wordPinyin) {
      pinyinPieces.push(wordPinyin)
    }

    return {
      index: w.index,
      text: w.text,
      startUtf16: w.startIndex,
      endUtf16: w.endIndex,
      startCp,
      endCp,
      isWord: w.isWord,
      pinyin: wordPinyin,
    }
  })

  return {
    words,
    sentencePinyin: pinyinPieces.join(' '),
  }
}

/**
 * Tách chuỗi Pinyin hoặc nghĩa tổng thành các câu nếu số câu trùng khớp 1-1
 */
function splitAlignedSentences(text?: string): string[] {
  if (!text || !text.trim()) return []
  return text
    .trim()
    .split(/(?<=[.!?。！？])\s+/)
    .map((s) => s.trim())
    .filter(Boolean)
}

/**
 * Xây dựng mảng câu thống nhất `UnifiedTypingSentence[]` bám sát `fullCleanedText`
 * để cả 2 chế độ ("Từng câu" và "Cả đoạn dài"), IME chấm điểm và TTS onboundary dùng chung 1 chỉ mục.
 */
export function buildUnifiedTypingSentences(
  fullCleanedText: string,
  options?: BuildUnifiedSentencesOptions
): {
  sentences: UnifiedTypingSentence[]
  hasAnyMeaning: boolean
} {
  if (!fullCleanedText || !fullCleanedText.trim()) {
    return { sentences: [], hasAnyMeaning: false }
  }

  const indexedTarget = buildIndexedChars(fullCleanedText)

  // 1. Ưu tiên khớp Gemini segments nếu có và ánh xạ hợp lệ trên fullCleanedText
  const mappedBlocks =
    options?.segments && options.segments.length > 0
      ? mapSegmentsToIndices(fullCleanedText, options.segments)
      : []

  if (mappedBlocks.length > 0) {
    let hasAnyMeaning = false
    const sentences: UnifiedTypingSentence[] = mappedBlocks.map((block, idx) => {
      const sliceText = fullCleanedText.slice(block.startIndex, block.endIndex)
      const startCp = indexedTarget.utf16ToCp(block.startIndex)
      const endCp = indexedTarget.utf16ToCp(block.endIndex)
      const meaning = block.segment.meaning_vi?.trim() || undefined
      if (meaning) hasAnyMeaning = true

      if (block.segment.pinyin?.trim()) {
        const aligned = segmentAndAlignChinese(sliceText, block.segment.pinyin)
        return {
          index: idx,
          chinese: sliceText,
          pinyin: block.segment.pinyin.trim(),
          meaning_vi: meaning,
          startIndex: block.startIndex,
          endIndex: block.endIndex,
          startCp,
          endCp,
          words: aligned.map((w) => ({
            index: w.index,
            text: w.text,
            startUtf16: w.startIndex,
            endUtf16: w.endIndex,
            startCp: indexedTarget.utf16ToCp(block.startIndex + w.startIndex),
            endCp: indexedTarget.utf16ToCp(block.startIndex + w.endIndex),
            isWord: w.isWord,
            pinyin: w.pinyin,
          })),
        }
      }

      const generated = alignSentenceWordsWithPinyinPro(sliceText, block.startIndex, indexedTarget)
      return {
        index: idx,
        chinese: sliceText,
        pinyin: generated.sentencePinyin,
        meaning_vi: meaning,
        startIndex: block.startIndex,
        endIndex: block.endIndex,
        startCp,
        endCp,
        words: generated.words,
      }
    })

    return { sentences, hasAnyMeaning }
  }

  // 2. Không có Gemini segments: tách câu trực tiếp trên fullCleanedText và tự sinh Pinyin bằng pinyin-pro
  const rawSentences = extractChineseSentences(fullCleanedText)
  const presetPinyinParts = splitAlignedSentences(options?.presetPinyin)
  const canUsePresetPinyinPerSentence =
    presetPinyinParts.length > 0 && presetPinyinParts.length === rawSentences.length

  const meaningParts = splitAlignedSentences(options?.overallMeaning)
  const canUseMeaningPerSentence =
    meaningParts.length > 0 && meaningParts.length === rawSentences.length

  let hasAnyMeaning = false
  const sentences: UnifiedTypingSentence[] = rawSentences.map((item, idx) => {
    const sliceText = fullCleanedText.slice(item.startIndex, item.endIndex)
    const startCp = indexedTarget.utf16ToCp(item.startIndex)
    const endCp = indexedTarget.utf16ToCp(item.endIndex)
    const meaning = canUseMeaningPerSentence ? meaningParts[idx] : undefined
    if (meaning) hasAnyMeaning = true

    if (canUsePresetPinyinPerSentence) {
      const aligned = segmentAndAlignChinese(sliceText, presetPinyinParts[idx])
      return {
        index: idx,
        chinese: sliceText,
        pinyin: presetPinyinParts[idx],
        meaning_vi: meaning,
        startIndex: item.startIndex,
        endIndex: item.endIndex,
        startCp,
        endCp,
        words: aligned.map((w) => ({
          index: w.index,
          text: w.text,
          startUtf16: w.startIndex,
          endUtf16: w.endIndex,
          startCp: indexedTarget.utf16ToCp(item.startIndex + w.startIndex),
          endCp: indexedTarget.utf16ToCp(item.startIndex + w.endIndex),
          isWord: w.isWord,
          pinyin: w.pinyin,
        })),
      }
    }

    const generated = alignSentenceWordsWithPinyinPro(sliceText, item.startIndex, indexedTarget)
    return {
      index: idx,
      chinese: sliceText,
      pinyin: generated.sentencePinyin,
      meaning_vi: meaning,
      startIndex: item.startIndex,
      endIndex: item.endIndex,
      startCp,
      endCp,
      words: generated.words,
    }
  })

  return { sentences, hasAnyMeaning }
}

/**
 * Tìm chỉ số câu chứa vị trí code-point hiện tại của người dùng trên fullCleanedText
 */
export function findSentenceIndexByCp(
  sentences: UnifiedTypingSentence[],
  typedCpLength: number
): number {
  if (!sentences || sentences.length === 0) return 0
  if (typedCpLength <= 0) return 0
  const foundIdx = sentences.findIndex((s) => typedCpLength < s.endCp)
  return foundIdx === -1 ? sentences.length - 1 : foundIdx
}
