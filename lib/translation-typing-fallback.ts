import type { TranslationExerciseItem } from '@/app/(main)/typing/actions'
import { getHskWordsByLevel } from '@/data/hsk-typing-vocabularies'

/**
 * Tạo danh sách bài luyện Dịch Việt → Gõ Hán từ kho dữ liệu tĩnh HSK 2012 (fallback khi DB rỗng hoặc lỗi mạng)
 */
export function buildStaticTranslationFallback(
  hskLevel: number,
  limit = 60
): TranslationExerciseItem[] {
  const safeLevel = hskLevel >= 1 && hskLevel <= 5 ? hskLevel : 1
  const words = getHskWordsByLevel(safeLevel)
  const items: TranslationExerciseItem[] = []
  const seenKeys = new Set<string>()

  for (const w of words) {
    const chinese = w.exampleHanzi?.trim()
    const vietnamese = w.exampleVi?.trim()
    if (!chinese || !vietnamese) continue

    const dedupKey = `${chinese}::${vietnamese}`
    if (seenKeys.has(dedupKey)) continue
    seenKeys.add(dedupKey)

    items.push({
      id: `trans-static-${w.id}`,
      vocabId: w.id,
      vietnamesePrompt: vietnamese,
      chineseAnswer: chinese,
      pinyinAnswer: w.examplePinyin?.trim() || w.pinyin || '',
      wordHanzi: w.hanzi,
      wordPinyin: w.pinyin,
      wordMeaning: w.meaning,
      hskLevel: safeLevel,
      lessonTitle: `HSK ${safeLevel} • Bài ${w.lessonNumber}`,
      difficulty: safeLevel <= 2 ? 'easy' : 'medium',
    })

    if (items.length >= limit) break
  }

  return items
}

/**
 * Tìm cấp độ HSK gần nhất có sẵn dữ liệu tĩnh (đảm bảo không bao giờ render trạng thái rỗng lúc khởi tạo)
 */
export function resolveAvailableFallbackLevel(preferredLevel: number): number {
  const safePreferred = preferredLevel >= 1 && preferredLevel <= 5 ? preferredLevel : 1
  const candidateOrder = [
    safePreferred,
    ...[1, 2, 3, 4, 5].filter((lvl) => lvl !== safePreferred),
  ]
  for (const lvl of candidateOrder) {
    if (buildStaticTranslationFallback(lvl, 1).length > 0) {
      return lvl
    }
  }
  return 1
}
