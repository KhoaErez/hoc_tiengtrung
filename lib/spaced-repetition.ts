/**
 * Spaced Repetition System (SRS) - Thuật toán SuperMemo 2 (SM-2)
 * Thiết kế cho Chinese Notebook - Module Luyện gõ tiếng Trung & Ôn tập câu sai
 * 
 * Thuật toán SM-2 chuẩn:
 * - repetitions (n): Số lần trả lời đúng liên tiếp.
 * - interval (I): Khoảng cách ngày đến lần ôn tập tiếp theo.
 * - easeFactor (EF): Hệ số điều chỉnh độ khó (mặc định 2.5, min 1.3).
 * - lapses: Số lần quên/sai câu này trong lịch sử ôn tập.
 * - quality (q): Điểm đánh giá chất lượng phản xạ từ 0 đến 5:
 *    5: Hoàn hảo, gõ đúng ngay không cần gợi ý
 *    4: Đúng sau chút do dự / suy nghĩ
 *    3: Đúng nhưng phải mở gợi ý từ vựng hoặc pinyin
 *    2: Sai, nhưng sau khi nhìn đối chiếu đã nhớ và gõ lại đúng
 *    1: Sai hoàn toàn / không nhớ chữ Hán
 *    0: Quên hoàn toàn
 */

export interface SM2ItemState {
  repetitions: number
  interval: number // số ngày
  easeFactor: number
  lapses: number
  dueAt: string // ISO UTC timestamp
  lastReviewedAt?: string // ISO UTC timestamp
}

export interface SM2CalculationInput {
  quality: number // 0 - 5
  repetitions: number
  interval: number
  easeFactor: number
  lapses: number
}

export interface SM2CalculationResult {
  repetitions: number
  interval: number // số ngày
  easeFactor: number
  lapses: number
  dueAt: string // ISO UTC
  status: 'need_review' | 'reviewing' | 'mastered'
}

/** Giá trị mặc định khi một câu mới bị sai lần đầu */
export const DEFAULT_SM2_INITIAL: SM2ItemState = {
  repetitions: 0,
  interval: 0,
  easeFactor: 2.5,
  lapses: 0,
  dueAt: new Date().toISOString(),
}

/**
 * Tính toán trạng thái ôn tập mới theo thuật toán SM-2
 */
export function calculateSM2(input: SM2CalculationInput): SM2CalculationResult {
  const { quality, lapses } = input
  let repetitions = input.repetitions
  let interval = input.interval
  let easeFactor = input.easeFactor || 2.5
  let newLapses = lapses || 0

  // Đảm bảo Ease Factor nằm trong ngưỡng an toàn chuẩn [1.3, 3.0]
  easeFactor = Math.max(1.3, Math.min(3.0, easeFactor))

  if (quality < 3) {
    // Trả lời sai (q < 3): Reset chuỗi đúng liên tiếp và tính là 1 lần quên (lapse)
    repetitions = 0
    interval = 1 // Ôn lại sau 1 ngày (hoặc ngay trong phiên hôm sau)
    newLapses += 1
    // Giảm nhẹ Ease Factor khi sai
    easeFactor = Math.max(1.3, easeFactor - 0.2)
  } else {
    // Trả lời đúng (q >= 3): Tăng chuỗi liên tiếp và tính khoảng cách ôn dài dần
    if (repetitions === 0) {
      interval = 1
    } else if (repetitions === 1) {
      // Sau lần đúng thứ 2: giãn 3 ngày (bước đệm lý tưởng cho học chữ Hán)
      interval = 3
    } else if (repetitions === 2) {
      interval = 6
    } else {
      interval = Math.round(interval * easeFactor)
    }

    repetitions += 1

    // Công thức điều chỉnh Ease Factor theo SM-2 chuẩn:
    // EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    const qDiff = 5 - quality
    const efDelta = 0.1 - qDiff * (0.08 + qDiff * 0.02)
    easeFactor = Math.max(1.3, Math.min(3.0, Number((easeFactor + efDelta).toFixed(2))))
  }

  // Giới hạn khoảng cách tối đa 365 ngày để đảm bảo người học vẫn duy trì ôn tập định kỳ
  interval = Math.min(365, Math.max(1, interval))

  // Tính thời điểm đến hạn ôn tiếp theo (UTC ISO)
  const dueAtDate = new Date()
  dueAtDate.setDate(dueAtDate.getDate() + interval)
  const dueAt = dueAtDate.toISOString()

  // Phân loại trạng thái ghi nhớ
  let status: 'need_review' | 'reviewing' | 'mastered' = 'need_review'
  if (repetitions >= 3 || interval >= 14) {
    status = 'mastered' // Đã thành thạo / đã nhớ sâu
  } else if (repetitions >= 1) {
    status = 'reviewing' // Đang trong quá trình củng cố
  } else {
    status = 'need_review' // Cần ưu tiên ôn lại
  }

  return {
    repetitions,
    interval,
    easeFactor,
    lapses: newLapses,
    dueAt,
    status,
  }
}

/**
 * Ánh xạ kết quả đánh giá gõ chữ Hán thành mức điểm chất lượng phản hồi q (0 - 5)
 * @param isCorrect Câu gõ có trùng khớp với câu mẫu hay không
 * @param hintsUsed Số mức gợi ý người dùng đã mở (0: tự nhớ, 1: từ vựng, 2: pinyin, 3: chữ Hán)
 * @param hadRetryInCurrentSession Đã từng gõ sai trong câu này trước khi sửa đúng
 */
export function mapTypingResultToQuality(
  isCorrect: boolean,
  hintsUsed: number = 0,
  hadRetryInCurrentSession: boolean = false
): number {
  if (!isCorrect) {
    // Không gõ đúng
    return hadRetryInCurrentSession ? 1 : 2
  }

  // Nếu gõ đúng:
  if (hintsUsed === 0 && !hadRetryInCurrentSession) {
    // Tự nhớ 100%, gõ đúng ngay lần đầu: Hoàn hảo
    return 5
  }

  if (hintsUsed === 0 && hadRetryInCurrentSession) {
    // Không cần gợi ý nhưng đã sửa lại 1 lần mới đúng
    return 4
  }

  if (hintsUsed === 1) {
    // Chỉ xem từ vựng trọng tâm rồi tự gõ được cả câu
    return 4
  }

  if (hintsUsed === 2) {
    // Cần xem phiên âm Pinyin mới gõ được
    return 3
  }

  // hintsUsed >= 3: Đã xem toàn bộ chữ Hán tham khảo (tương đương chép lại)
  return 3
}

/**
 * Kiểm tra xem một câu đã đến hạn ôn tập hay chưa dựa trên dueAt
 */
export function isItemDue(dueAt?: string | null): boolean {
  if (!dueAt) return true // Chưa có lịch hẹn -> coi như cần ôn ngay
  const dueDate = new Date(dueAt).getTime()
  const now = Date.now()
  return dueDate <= now
}

/**
 * Định dạng khoảng cách ngày đến hạn thân thiện bằng tiếng Việt
 */
export function formatDueText(dueAt?: string | null): {
  text: string
  isOverdue: boolean
  isToday: boolean
} {
  if (!dueAt) {
    return { text: 'Cần ôn ngay', isOverdue: true, isToday: true }
  }

  const now = new Date()
  const due = new Date(dueAt)

  // Tính số ngày chênh lệch giữa ngày đến hạn và hôm nay (theo ngày lịch)
  const msPerDay = 24 * 60 * 60 * 1000
  const diffDays = Math.round((due.setHours(0, 0, 0, 0) - now.setHours(0, 0, 0, 0)) / msPerDay)

  if (diffDays < 0) {
    const overdueDays = Math.abs(diffDays)
    return {
      text: overdueDays === 1 ? 'Quá hạn 1 ngày' : `Quá hạn ${overdueDays} ngày`,
      isOverdue: true,
      isToday: false,
    }
  }

  if (diffDays === 0) {
    return { text: 'Đến hạn hôm nay', isOverdue: false, isToday: true }
  }

  if (diffDays === 1) {
    return { text: 'Đến hạn ngày mai', isOverdue: false, isToday: false }
  }

  return { text: `Sau ${diffDays} ngày`, isOverdue: false, isToday: false }
}

