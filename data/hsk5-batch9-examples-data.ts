// data/hsk5-batch9-examples-data.ts
// Tổng hợp 100 từ vựng HSK 5 Batch 9: #2802 [牛仔裤] -> #2901 [全面]

import { HSK5_BATCH9_PART1, VocabItem } from './hsk5-batch9-part1-data'
import { HSK5_BATCH9_PART2 } from './hsk5-batch9-part2-data'
import { HSK5_BATCH9_PART3 } from './hsk5-batch9-part3-data'
import { HSK5_BATCH9_PART4 } from './hsk5-batch9-part4-data'

export type { ExampleItem, VocabItem } from './hsk5-batch9-part1-data'

export const HSK5_BATCH9_WORDS: VocabItem[] = [
  ...HSK5_BATCH9_PART1,
  ...HSK5_BATCH9_PART2,
  ...HSK5_BATCH9_PART3,
  ...HSK5_BATCH9_PART4
]
