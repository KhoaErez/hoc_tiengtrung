// ====================================================================
// HSK 5 - BATCH 2: 100 TỪ VỰNG & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #2101 [差距] (chājù) -> #2201 [从而] (cóng’ér)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin + Dịch TV
// ====================================================================

import { Hsk5ExampleItem } from './hsk5-batch1-part1-data'
import { HSK5_BATCH2_PART1 } from './hsk5-batch2-part1-data'
import { HSK5_BATCH2_PART2 } from './hsk5-batch2-part2-data'
import { HSK5_BATCH2_PART3 } from './hsk5-batch2-part3-data'
import { HSK5_BATCH2_PART4 } from './hsk5-batch2-part4-data'

export type { Hsk5ExampleItem }

export const HSK5_BATCH2_EXAMPLES: Hsk5ExampleItem[] = [
  ...HSK5_BATCH2_PART1,
  ...HSK5_BATCH2_PART2,
  ...HSK5_BATCH2_PART3,
  ...HSK5_BATCH2_PART4
]
