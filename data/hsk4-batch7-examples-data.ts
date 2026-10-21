// ====================================================================
// HSK 4 - BATCH 7: 100 TỪ VỰNG CTI / 99 BẢN GHI DB & 198 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #1601 [全球] (quánqiú) -> #1700 [说明] (shuōmíng)
// Ghi chú đặc biệt:
//   - CTI #1646 (生 v.) & CTI #1647 (生 adj.) được tích hợp trọn vẹn trong 1 bản ghi duy nhất '生',
//     với ví dụ 1 cho động từ và ví dụ 2 cho tính từ.
//   - Mỗi từ vựng có 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin có dấu + Dịch TV
// ====================================================================

import type { Hsk4ExampleItem } from './hsk4-batch1-examples-data'
import { HSK4_BATCH7_PART1 } from './hsk4-batch7-part1-data'
import { HSK4_BATCH7_PART2 } from './hsk4-batch7-part2-data'
import { HSK4_BATCH7_PART3 } from './hsk4-batch7-part3-data'
import { HSK4_BATCH7_PART4 } from './hsk4-batch7-part4-data'

export const HSK4_BATCH7_EXAMPLES: Hsk4ExampleItem[] = [
  ...HSK4_BATCH7_PART1,
  ...HSK4_BATCH7_PART2,
  ...HSK4_BATCH7_PART3,
  ...HSK4_BATCH7_PART4
]
