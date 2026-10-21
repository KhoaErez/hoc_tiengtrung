// data/hsk5-batch11-examples-data.ts
// Tổng hợp 100 từ vựng HSK 5 Batch 11: #3002 [胜利] -> #3101 [台灯]

import { HSK5_BATCH11_PART1, VocabItem } from './hsk5-batch11-part1-data'
import { HSK5_BATCH11_PART2 } from './hsk5-batch11-part2-data'
import { HSK5_BATCH11_PART3 } from './hsk5-batch11-part3-data'
import { HSK5_BATCH11_PART4 } from './hsk5-batch11-part4-data'

export type { ExampleItem, VocabItem } from './hsk5-batch11-part1-data'

export const HSK5_BATCH11_WORDS: VocabItem[] = [
  ...HSK5_BATCH11_PART1,
  ...HSK5_BATCH11_PART2,
  ...HSK5_BATCH11_PART3,
  ...HSK5_BATCH11_PART4
]
