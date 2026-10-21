// data/hsk5-batch13-examples-data.ts
// Tổng hợp 100 từ vựng HSK 5 Batch 13: #3202 [问卷] -> #3301 [修建]

import { HSK5_BATCH13_PART1, VocabItem } from './hsk5-batch13-part1-data'
import { HSK5_BATCH13_PART2 } from './hsk5-batch13-part2-data'
import { HSK5_BATCH13_PART3 } from './hsk5-batch13-part3-data'
import { HSK5_BATCH13_PART4 } from './hsk5-batch13-part4-data'

export type { ExampleItem, VocabItem } from './hsk5-batch13-part1-data'

export const HSK5_BATCH13_WORDS: VocabItem[] = [
  ...HSK5_BATCH13_PART1,
  ...HSK5_BATCH13_PART2,
  ...HSK5_BATCH13_PART3,
  ...HSK5_BATCH13_PART4
]
