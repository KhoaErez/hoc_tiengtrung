// data/hsk5-batch15-examples-data.ts
// Tổng hợp 100 từ vựng HSK 5 Batch 15: #3402 [由此] -> #3501 [直]

import { HSK5_BATCH15_PART1, VocabItem } from './hsk5-batch15-part1-data'
import { HSK5_BATCH15_PART2 } from './hsk5-batch15-part2-data'
import { HSK5_BATCH15_PART3 } from './hsk5-batch15-part3-data'
import { HSK5_BATCH15_PART4 } from './hsk5-batch15-part4-data'

export type { ExampleItem, VocabItem } from './hsk5-batch15-part1-data'

export const HSK5_BATCH15_WORDS: VocabItem[] = [
  ...HSK5_BATCH15_PART1,
  ...HSK5_BATCH15_PART2,
  ...HSK5_BATCH15_PART3,
  ...HSK5_BATCH15_PART4
]
