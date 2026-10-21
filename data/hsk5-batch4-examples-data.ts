// data/hsk5-batch4-examples-data.ts
// ====================================================================
// HSK 5 - BATCH 4: 100 TỪ VỰNG & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #2302 [短期] (duǎnqī) -> #2401 [个性] (gèxìng)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin + Dịch TV
// ====================================================================

import { VocabItem } from './hsk5-batch4-part1-data'
import { HSK5_BATCH4_PART1 } from './hsk5-batch4-part1-data'
import { HSK5_BATCH4_PART2 } from './hsk5-batch4-part2-data'
import { HSK5_BATCH4_PART3 } from './hsk5-batch4-part3-data'
import { HSK5_BATCH4_PART4 } from './hsk5-batch4-part4-data'

export type { VocabItem }

export const HSK5_BATCH4_EXAMPLES: VocabItem[] = [
  ...HSK5_BATCH4_PART1,
  ...HSK5_BATCH4_PART2,
  ...HSK5_BATCH4_PART3,
  ...HSK5_BATCH4_PART4
]
