// data/hsk5-batch12-examples-data.ts
// Tổng hợp 100 từ vựng HSK 5 Batch 12: #3102 [台阶] -> #3201 [稳定]

import { HSK5_BATCH12_PART1, VocabItem } from './hsk5-batch12-part1-data'
import { HSK5_BATCH12_PART2 } from './hsk5-batch12-part2-data'
import { HSK5_BATCH12_PART3 } from './hsk5-batch12-part3-data'
import { HSK5_BATCH12_PART4 } from './hsk5-batch12-part4-data'

export type { ExampleItem, VocabItem } from './hsk5-batch12-part1-data'

export const HSK5_BATCH12_WORDS: VocabItem[] = [
  ...HSK5_BATCH12_PART1,
  ...HSK5_BATCH12_PART2,
  ...HSK5_BATCH12_PART3,
  ...HSK5_BATCH12_PART4
]
