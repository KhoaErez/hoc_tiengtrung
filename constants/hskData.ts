// ============================================================================
// SINGLE SOURCE OF TRUTH: HSK 3.0 VOCABULARY COUNTS, RANKS & ROADMAP METADATA
// Synchronized across Homepage HSK Selector, Topics Dashboard, and Global Footer.
// ============================================================================

export type HskCanonicalLevelKey = 1 | 2 | 3 | 4 | 5 | 6 | 7

export interface HskCanonicalEntry {
  level: HskCanonicalLevelKey
  tag: string
  name: string
  title: string
  rankTitle: string
  rankShort: string
  stage: 'Sơ cấp' | 'Trung cấp' | 'Cao cấp'
  stageZh: '初等' | '中等' | '高等'
  stageName: string
  vocabCount: number // Actual curated/validated vocabulary count (300 / 207 / 514 / 1,013 / 1,597 / 1,798 / 11,000 target)
  targetVocab: number // Official GF 0025-2021 cumulative target
  defaultLessons: number
  grammarTarget: number
  charTarget: number
  accentColor: string
  coverImage: string
  summary: string
  isComingSoon: boolean
}

export const HSK_CANONICAL_DATA: Record<HskCanonicalLevelKey, HskCanonicalEntry> = {
  1: {
    level: 1,
    tag: 'HSK 1',
    name: 'HSK 1',
    title: 'HSK 1 – Sơ cấp',
    rankTitle: 'Đồng Sinh (童生)',
    rankShort: 'Đồng Sinh',
    stage: 'Sơ cấp',
    stageZh: '初等',
    stageName: 'Sơ cấp (初等)',
    vocabCount: 300,
    targetVocab: 300,
    defaultLessons: 18,
    grammarTarget: 48,
    charTarget: 300,
    accentColor: '#0D9488',
    coverImage: '/images/hsk/hsk-1-village.webp',
    summary: 'Làm quen bảng chữ Hán cơ bản, hệ thống ngữ âm Pinyin và 300 từ vựng nền tảng giao tiếp hằng ngày.',
    isComingSoon: false,
  },
  2: {
    level: 2,
    tag: 'HSK 2',
    name: 'HSK 2',
    title: 'HSK 2 – Sơ cấp',
    rankTitle: 'Tú Tài (秀才)',
    rankShort: 'Tú Tài',
    stage: 'Sơ cấp',
    stageZh: '初等',
    stageName: 'Sơ cấp (初等)',
    vocabCount: 207,
    targetVocab: 500,
    defaultLessons: 12,
    grammarTarget: 129,
    charTarget: 600,
    accentColor: '#0284C7',
    coverImage: '/images/hsk/hsk-2-garden.webp',
    summary: 'Mở rộng 207 từ mới (tích lũy 500 từ) và 129 điểm ngữ pháp phục vụ sinh hoạt, học tập và ăn uống.',
    isComingSoon: false,
  },
  3: {
    level: 3,
    tag: 'HSK 3',
    name: 'HSK 3',
    title: 'HSK 3 – Sơ cấp nâng cao',
    rankTitle: 'Cử Nhân (举人)',
    rankShort: 'Cử Nhân',
    stage: 'Sơ cấp',
    stageZh: '初等',
    stageName: 'Sơ cấp (初等)',
    vocabCount: 514,
    targetVocab: 1000,
    defaultLessons: 24,
    grammarTarget: 210,
    charTarget: 900,
    accentColor: '#D97706',
    coverImage: '/images/hsk/hsk-3-city.webp',
    summary: 'Làm chủ 514 từ mới (tích lũy 1.000 từ) hoàn tất giai đoạn Sơ cấp để tự tin giao tiếp độc lập và du lịch.',
    isComingSoon: false,
  },
  4: {
    level: 4,
    tag: 'HSK 4',
    name: 'HSK 4',
    title: 'HSK 4 – Trung cấp',
    rankTitle: 'Cống Sĩ (贡士)',
    rankShort: 'Cống Sĩ',
    stage: 'Trung cấp',
    stageZh: '中等',
    stageName: 'Trung cấp (中等)',
    vocabCount: 1013,
    targetVocab: 2000,
    defaultLessons: 43,
    grammarTarget: 286,
    charTarget: 1200,
    accentColor: '#DC2626',
    coverImage: '/images/hsk/hsk-4-mountain.webp',
    summary: 'Thành thạo 1.013 từ mới (tích lũy 2.000 từ) giúp đàm luận tự nhiên về xã hội, văn hóa và công việc.',
    isComingSoon: false,
  },
  5: {
    level: 5,
    tag: 'HSK 5',
    name: 'HSK 5',
    title: 'HSK 5 – Trung cấp nâng cao',
    rankTitle: 'Tiến Sĩ (进士)',
    rankShort: 'Tiến Sĩ',
    stage: 'Trung cấp',
    stageZh: '中等',
    stageName: 'Trung cấp (中等)',
    vocabCount: 1597,
    targetVocab: 3600,
    defaultLessons: 91,
    grammarTarget: 357,
    charTarget: 1500,
    accentColor: '#4338CA',
    coverImage: '/images/hsk/hsk-5-academy.webp',
    summary: 'Chinh phục 1.597 từ mới (tích lũy 3.600 từ) để đọc hiểu báo chí, phim ảnh và thuyết trình chuyên nghiệp.',
    isComingSoon: false,
  },
  6: {
    level: 6,
    tag: 'HSK 6',
    name: 'HSK 6',
    title: 'HSK 6 – Trung cấp hoàn chỉnh',
    rankTitle: 'Thám Hoa (探花)',
    rankShort: 'Thám Hoa',
    stage: 'Trung cấp',
    stageZh: '中等',
    stageName: 'Trung cấp (中等)',
    vocabCount: 1798,
    targetVocab: 5400,
    defaultLessons: 173,
    grammarTarget: 424,
    charTarget: 1800,
    accentColor: '#7E22CE',
    coverImage: '/images/hsk/hsk-6-peak.webp',
    summary: 'Nắm vững 1.798 từ trọng tâm chuẩn hóa (mục tiêu 5.400 từ) cùng tư duy diễn đạt mạch lạc bằng văn bản học thuật.',
    isComingSoon: false,
  },
  7: {
    level: 7,
    tag: 'HSK 7-9',
    name: 'HSK 7–9',
    title: 'HSK 7–9 – Cao cấp',
    rankTitle: 'Trạng Nguyên (状元)',
    rankShort: 'Trạng Nguyên',
    stage: 'Cao cấp',
    stageZh: '高等',
    stageName: 'Cao cấp (高等)',
    vocabCount: 11000,
    targetVocab: 11000,
    defaultLessons: 0,
    grammarTarget: 572,
    charTarget: 3000,
    accentColor: '#0F766E',
    coverImage: '/images/hsk/hsk-7-celestial.webp',
    summary: 'Đề cương tích lũy 11.000 từ, 3.000 chữ Hán và 572 điểm ngữ pháp phục vụ nghiên cứu và dịch thuật cao cấp.',
    isComingSoon: true,
  },
}

export const HSK_LEVEL_ORDER: HskCanonicalLevelKey[] = [1, 2, 3, 4, 5, 6, 7]

/**
 * Resolve exact vocabulary count consistently across Footer and Homepage HSK Roadmap.
 * Uses live DB count when available, falling back to canonical constants in HSK_CANONICAL_DATA.
 */
export function resolveHskVocabCount(
  level: HskCanonicalLevelKey | number,
  liveCounts?: Record<string, number | null> | null
): number {
  const key = (level >= 7 ? 7 : Math.max(1, Math.min(6, level))) as HskCanonicalLevelKey
  const canonical = HSK_CANONICAL_DATA[key]
  const dbKey = key === 7 ? 'HSK 7-9' : `HSK ${key}`
  const live = liveCounts?.[dbKey]
  if (typeof live === 'number' && live > 0) return live
  return canonical.vocabCount
}

export const TOTAL_CURATED_HSK_VOCAB_COUNT = (
  [1, 2, 3, 4, 5, 6] as HskCanonicalLevelKey[]
).reduce((acc, lvl) => acc + HSK_CANONICAL_DATA[lvl].vocabCount, 0)
