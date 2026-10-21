// ====================================================================
// HSK 5 - BATCH 3: 100 TỪ VỰNG & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #2202 [从前] (cóngqián) -> #2301 [短处] (duǎnchu)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin + Dịch TV
// ====================================================================

import { Hsk5ExampleItem } from './hsk5-batch1-part1-data'
import { HSK5_BATCH3_PART1 } from './hsk5-batch3-part1-data'
import { HSK5_BATCH3_PART2 } from './hsk5-batch3-part2-data'
import { HSK5_BATCH3_PART3 } from './hsk5-batch3-part3-data'
import { HSK5_BATCH3_PART4 } from './hsk5-batch3-part4-data'

export type { Hsk5ExampleItem }

export const HSK5_BATCH3_EXAMPLES: Hsk5ExampleItem[] = [
  ...HSK5_BATCH3_PART1,
  ...HSK5_BATCH3_PART2,
  ...HSK5_BATCH3_PART3,
  ...HSK5_BATCH3_PART4
]
