// data/hsk5-batch8-examples-data.ts
// ====================================================================
// HSK 5 - BATCH 8: 100 TỪ VỰNG & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #2702 [里头] (lǐtou) -> #2801 [念] (niàn)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin + Dịch TV
// ====================================================================

import { VocabItem } from './hsk5-batch8-part1-data'
import { HSK5_BATCH8_PART1 } from './hsk5-batch8-part1-data'
import { HSK5_BATCH8_PART2 } from './hsk5-batch8-part2-data'
import { HSK5_BATCH8_PART3 } from './hsk5-batch8-part3-data'
import { HSK5_BATCH8_PART4 } from './hsk5-batch8-part4-data'

export type { VocabItem }

export const HSK5_BATCH8_EXAMPLES: VocabItem[] = [
  ...HSK5_BATCH8_PART1,
  ...HSK5_BATCH8_PART2,
  ...HSK5_BATCH8_PART3,
  ...HSK5_BATCH8_PART4
]
