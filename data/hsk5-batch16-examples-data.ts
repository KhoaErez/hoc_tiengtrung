// data/hsk5-batch16-examples-data.ts
// Tổng hợp 99 từ vựng HSK 5 Batch 16 (Final Batch): #3502 [直播] -> #3600 [作出]
// Đạt mốc tròn 1.600 / 1.600 từ HSK 5 theo chuẩn Đề cương HSK 3.0!

import { HSK5_BATCH16_PART1, VocabItem } from './hsk5-batch16-part1-data'
import { HSK5_BATCH16_PART2 } from './hsk5-batch16-part2-data'
import { HSK5_BATCH16_PART3 } from './hsk5-batch16-part3-data'
import { HSK5_BATCH16_PART4 } from './hsk5-batch16-part4-data'

export type { ExampleItem, VocabItem } from './hsk5-batch16-part1-data'

export const HSK5_BATCH16_WORDS: VocabItem[] = [
  ...HSK5_BATCH16_PART1,
  ...HSK5_BATCH16_PART2,
  ...HSK5_BATCH16_PART3,
  ...HSK5_BATCH16_PART4
]
