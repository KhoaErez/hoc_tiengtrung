// ====================================================================
// DANH MỤC 255 TỪ VỰNG CÒN THIẾU CỦA HSK 3 (TỔNG HỢP 3 PHẦN: #503 -> #1000)
// Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / Chinese Test International 11/2025)
// Tổng cộng: 255 mục từ vựng mới, mỗi từ đi kèm 2 câu ví dụ chất lượng cao
// ====================================================================

import { HSK3_MISSING_PART1 } from './hsk3-missing-part1-data'
import type { Hsk3WordItem } from './hsk3-missing-part1-data'
import { HSK3_MISSING_PART2 } from './hsk3-missing-part2-data'
import { HSK3_MISSING_PART3 } from './hsk3-missing-part3-data'

export type { Hsk3WordItem }

export const HSK3_MISSING_255_WORDS: Hsk3WordItem[] = [
  ...HSK3_MISSING_PART1,
  ...HSK3_MISSING_PART2,
  ...HSK3_MISSING_PART3,
]
