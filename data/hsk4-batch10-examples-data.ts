// ====================================================================
// HSK 4 - BATCH 10: 100 TỪ VỰNG CTI & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #1901 [原谅] (yuánliàng) -> #2000 [作者] (zuòzhě) - CÁN ĐÍCH 100%
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin có dấu + Dịch TV
// ====================================================================

import type { Hsk4ExampleItem } from './hsk4-batch1-examples-data'
import { HSK4_BATCH10_PART1 } from './hsk4-batch10-part1-data'
import { HSK4_BATCH10_PART2 } from './hsk4-batch10-part2-data'
import { HSK4_BATCH10_PART3 } from './hsk4-batch10-part3-data'
import { HSK4_BATCH10_PART4 } from './hsk4-batch10-part4-data'

export const HSK4_BATCH10_EXAMPLES: Hsk4ExampleItem[] = [
  ...HSK4_BATCH10_PART1,
  ...HSK4_BATCH10_PART2,
  ...HSK4_BATCH10_PART3,
  ...HSK4_BATCH10_PART4
]
