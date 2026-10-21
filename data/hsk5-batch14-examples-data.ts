// data/hsk5-batch14-examples-data.ts
// Tổng hợp 100 từ vựng HSK 5 Batch 14: #3302 [休闲] -> #3401 [优质]

import { HSK5_BATCH14_PART1, VocabItem } from './hsk5-batch14-part1-data'
import { HSK5_BATCH14_PART2 } from './hsk5-batch14-part2-data'
import { HSK5_BATCH14_PART3 } from './hsk5-batch14-part3-data'
import { HSK5_BATCH14_PART4 } from './hsk5-batch14-part4-data'

export type { ExampleItem, VocabItem } from './hsk5-batch14-part1-data'

export const HSK5_BATCH14_WORDS: VocabItem[] = [
  ...HSK5_BATCH14_PART1,
  ...HSK5_BATCH14_PART2,
  ...HSK5_BATCH14_PART3,
  ...HSK5_BATCH14_PART4
]
