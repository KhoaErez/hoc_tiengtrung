// data/hsk5-batch10-examples-data.ts
// Tổng hợp 100 từ vựng HSK 5 Batch 10: #2902 [全体] -> #3001 [胜]

import { HSK5_BATCH10_PART1, VocabItem } from './hsk5-batch10-part1-data'
import { HSK5_BATCH10_PART2 } from './hsk5-batch10-part2-data'
import { HSK5_BATCH10_PART3 } from './hsk5-batch10-part3-data'
import { HSK5_BATCH10_PART4 } from './hsk5-batch10-part4-data'

export type { ExampleItem, VocabItem } from './hsk5-batch10-part1-data'

export const HSK5_BATCH10_WORDS: VocabItem[] = [
  ...HSK5_BATCH10_PART1,
  ...HSK5_BATCH10_PART2,
  ...HSK5_BATCH10_PART3,
  ...HSK5_BATCH10_PART4
]
