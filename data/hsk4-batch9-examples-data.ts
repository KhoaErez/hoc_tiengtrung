// ====================================================================
// HSK 4 - BATCH 9: 100 TỪ VỰNG CTI & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #1801 [现有] (xiànyǒu) -> #1900 [原来] (yuánlái)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin có dấu + Dịch TV
// ====================================================================

import type { Hsk4ExampleItem } from './hsk4-batch1-examples-data'
import { HSK4_BATCH9_PART1 } from './hsk4-batch9-part1-data'
import { HSK4_BATCH9_PART2 } from './hsk4-batch9-part2-data'
import { HSK4_BATCH9_PART3 } from './hsk4-batch9-part3-data'
import { HSK4_BATCH9_PART4 } from './hsk4-batch9-part4-data'

export const HSK4_BATCH9_EXAMPLES: Hsk4ExampleItem[] = [
  ...HSK4_BATCH9_PART1,
  ...HSK4_BATCH9_PART2,
  ...HSK4_BATCH9_PART3,
  ...HSK4_BATCH9_PART4
]
