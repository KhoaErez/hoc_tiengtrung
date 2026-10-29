// Test verification script for Spaced Repetition System (SM-2)
import assert from 'node:assert'

// Inline replicate logic for standalone test execution
function calculateSM2(input) {
  const { quality, lapses } = input
  let repetitions = input.repetitions
  let interval = input.interval
  let easeFactor = input.easeFactor || 2.5
  let newLapses = lapses || 0

  easeFactor = Math.max(1.3, Math.min(3.0, easeFactor))

  if (quality < 3) {
    repetitions = 0
    interval = 1
    newLapses += 1
    easeFactor = Math.max(1.3, easeFactor - 0.2)
  } else {
    if (repetitions === 0) {
      interval = 1
    } else if (repetitions === 1) {
      interval = 3
    } else if (repetitions === 2) {
      interval = 6
    } else {
      interval = Math.round(interval * easeFactor)
    }

    repetitions += 1
    const qDiff = 5 - quality
    const efDelta = 0.1 - qDiff * (0.08 + qDiff * 0.02)
    easeFactor = Math.max(1.3, Math.min(3.0, Number((easeFactor + efDelta).toFixed(2))))
  }

  interval = Math.min(365, Math.max(1, interval))

  const dueAtDate = new Date()
  dueAtDate.setDate(dueAtDate.getDate() + interval)
  const dueAt = dueAtDate.toISOString()

  let status = 'need_review'
  if (repetitions >= 3 || interval >= 14) {
    status = 'mastered'
  } else if (repetitions >= 1) {
    status = 'reviewing'
  }

  return { repetitions, interval, easeFactor, lapses: newLapses, dueAt, status }
}

function mapTypingResultToQuality(isCorrect, hintsUsed = 0, hadRetryInCurrentSession = false) {
  if (!isCorrect) return hadRetryInCurrentSession ? 1 : 2
  if (hintsUsed === 0 && !hadRetryInCurrentSession) return 5
  if (hintsUsed === 0 && hadRetryInCurrentSession) return 4
  if (hintsUsed === 1) return 4
  if (hintsUsed === 2) return 3
  return 3
}

console.log('=== BẮT ĐẦU KIỂM THỬ THUẬT TOÁN SPACED REPETITION (SM-2) ===\n')

// Test Case 1: Lần đầu sai
{
  const res = calculateSM2({ quality: 2, repetitions: 0, interval: 0, easeFactor: 2.5, lapses: 0 })
  assert.strictEqual(res.repetitions, 0, 'Sai phải reset repetitions = 0')
  assert.strictEqual(res.interval, 1, 'Khoảng cách khi sai là 1 ngày')
  assert.strictEqual(res.lapses, 1, 'Lapses phải tăng lên 1')
  assert.strictEqual(res.status, 'need_review')
  console.log('✔ Test Case 1 PASS: Trả lời sai lần đầu -> Reset về 0, interval = 1, lapses = 1')
}

// Test Case 2: Ôn câu sai và đúng lần đầu không gợi ý (q = 5)
{
  const res = calculateSM2({ quality: 5, repetitions: 0, interval: 1, easeFactor: 2.3, lapses: 1 })
  assert.strictEqual(res.repetitions, 1, 'Đúng lần 1 -> repetitions = 1')
  assert.strictEqual(res.interval, 1, 'Đúng lần 1 -> interval = 1')
  assert.strictEqual(res.status, 'reviewing')
  console.log('✔ Test Case 2 PASS: Ôn đúng lần đầu (q = 5) -> repetitions = 1, interval = 1, status = reviewing')
}

// Test Case 3: Ôn đúng lần 2 liên tiếp (q = 5)
{
  const res = calculateSM2({ quality: 5, repetitions: 1, interval: 1, easeFactor: 2.4, lapses: 1 })
  assert.strictEqual(res.repetitions, 2, 'Đúng lần 2 -> repetitions = 2')
  assert.strictEqual(res.interval, 3, 'Đúng lần 2 -> interval = 3 ngày')
  assert.strictEqual(res.status, 'reviewing')
  console.log('✔ Test Case 3 PASS: Ôn đúng lần 2 liên tiếp -> repetitions = 2, interval = 3 ngày')
}

// Test Case 4: Ôn đúng lần 3 liên tiếp (q = 5)
{
  const res = calculateSM2({ quality: 5, repetitions: 2, interval: 3, easeFactor: 2.5, lapses: 1 })
  assert.strictEqual(res.repetitions, 3, 'Đúng lần 3 -> repetitions = 3')
  assert.strictEqual(res.interval, 6, 'Đúng lần 3 -> interval = 6 ngày')
  assert.strictEqual(res.status, 'mastered', 'Đúng liên tiếp 3 lần chuyển sang mastered')
  console.log('✔ Test Case 4 PASS: Ôn đúng lần 3 liên tiếp -> repetitions = 3, interval = 6 ngày, status = mastered')
}

// Test Case 5: Ôn đúng lần 4 liên tiếp (q = 5, EF = 2.6) -> Khoảng cách tăng nhân theo Ease Factor
{
  const res = calculateSM2({ quality: 5, repetitions: 3, interval: 6, easeFactor: 2.6, lapses: 1 })
  assert.strictEqual(res.repetitions, 4)
  assert.strictEqual(res.interval, Math.round(6 * 2.6), 'Khoảng cách = 6 * 2.6 = 16 ngày')
  assert.strictEqual(res.status, 'mastered')
  console.log(`✔ Test Case 5 PASS: Ôn đúng lần 4 liên tiếp -> interval = ${res.interval} ngày (giãn cách theo SM-2)`)
}

// Test Case 6: Đang mastered mà quên (q = 1) -> Reset về nhóm cần ưu tiên ôn
{
  const res = calculateSM2({ quality: 1, repetitions: 4, interval: 16, easeFactor: 2.7, lapses: 1 })
  assert.strictEqual(res.repetitions, 0)
  assert.strictEqual(res.interval, 1)
  assert.strictEqual(res.lapses, 2)
  assert.strictEqual(res.status, 'need_review')
  console.log('✔ Test Case 6 PASS: Đang mastered mà quên -> Reset repetitions = 0, interval = 1, status = need_review')
}

// Test Case 7: Ngưỡng Ease Factor không bao giờ dưới 1.3
{
  let ef = 1.35
  for (let i = 0; i < 5; i++) {
    const res = calculateSM2({ quality: 0, repetitions: 0, interval: 1, easeFactor: ef, lapses: i })
    ef = res.easeFactor
  }
  assert.strictEqual(ef, 1.3, 'Ease Factor không được nhỏ hơn 1.3')
  console.log('✔ Test Case 7 PASS: Ease Factor được bảo vệ ở ngưỡng sàn min = 1.3')
}

// Test Case 8: Ánh xạ kết quả gõ chữ Hán sang điểm q
{
  assert.strictEqual(mapTypingResultToQuality(true, 0, false), 5, 'Đúng tự nhớ 100% -> q = 5')
  assert.strictEqual(mapTypingResultToQuality(true, 0, true), 4, 'Đúng sau khi sửa -> q = 4')
  assert.strictEqual(mapTypingResultToQuality(true, 1, false), 4, 'Đúng sau xem gợi ý từ vựng -> q = 4')
  assert.strictEqual(mapTypingResultToQuality(true, 2, false), 3, 'Đúng sau xem pinyin -> q = 3')
  assert.strictEqual(mapTypingResultToQuality(false, 0, false), 2, 'Gõ sai lần đầu -> q = 2')
  assert.strictEqual(mapTypingResultToQuality(false, 0, true), 1, 'Gõ sai nhiều lần -> q = 1')
  console.log('✔ Test Case 8 PASS: Ánh xạ kết quả gõ chữ Hán sang chất lượng SM-2 q (1-5) chuẩn xác')
}

console.log('\n======================================================')
console.log('🎉 TOÀN BỘ 8 BỘ KIỂM THỬ THUẬT TOÁN SM-2 ĐỀU ĐẠT CHUẨN!')
console.log('======================================================\n')

