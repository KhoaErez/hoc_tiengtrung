// data/hsk5-batch5-examples-data.ts
// ====================================================================
// HSK 5 - BATCH 5: 100 TỪ VỰNG & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #2402 [各自] (gèzì) -> #2501 [化学] (huàxué)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin + Dịch TV
// ====================================================================

import { VocabItem } from './hsk5-batch5-part1-data'
import { HSK5_BATCH5_PART1 } from './hsk5-batch5-part1-data'
import { HSK5_BATCH5_PART2 } from './hsk5-batch5-part2-data'
import { HSK5_BATCH5_PART3 } from './hsk5-batch5-part3-data'
import { HSK5_BATCH5_PART4 } from './hsk5-batch5-part4-data'

export type { VocabItem }

export const HSK5_BATCH5_EXAMPLES: VocabItem[] = [
  ...HSK5_BATCH5_PART1,
  ...HSK5_BATCH5_PART2,
  ...HSK5_BATCH5_PART3,
  ...HSK5_BATCH5_PART4
]
