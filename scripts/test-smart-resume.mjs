// Test suite for Smart Resume & Progress Management in Chinese Notebook
import assert from 'node:assert'

// Mô phỏng thuật toán tìm câu khôi phục thông minh
function resolveResumeSentenceIndex({
  exercises,
  savedProgress,
  initialSentenceId,
  initialSentenceIndex,
}) {
  if (!exercises || exercises.length === 0) return 0

  // 1. Ưu tiên 1: ID câu cụ thể truyền từ link/props
  if (initialSentenceId) {
    const foundIdx = exercises.findIndex(
      (item) => item.id === initialSentenceId || item.exampleId === initialSentenceId
    )
    if (foundIdx !== -1) return foundIdx
  }

  // 2. Ưu tiên 2: Chỉ số câu cụ thể truyền từ props nếu hợp lệ
  if (
    typeof initialSentenceIndex === 'number' &&
    initialSentenceIndex >= 0 &&
    initialSentenceIndex < exercises.length
  ) {
    return initialSentenceIndex
  }

  // 3. Ưu tiên 3: Tìm theo tiến độ đã lưu (Cloud / Local)
  if (savedProgress && savedProgress.status !== 'completed') {
    // 3a. Tìm theo ID ổn định của câu
    if (savedProgress.currentQuestionId) {
      const matchById = exercises.findIndex(
        (it) =>
          it.id === savedProgress.currentQuestionId ||
          it.exampleId === savedProgress.currentQuestionId
      )
      if (matchById !== -1) return matchById
    }

    // 3b. Fallback sang chỉ số câu nếu nằm trong khoảng hợp lệ
    if (
      typeof savedProgress.currentSentenceIndex === 'number' &&
      savedProgress.currentSentenceIndex >= 0 &&
      savedProgress.currentSentenceIndex < exercises.length
    ) {
      return savedProgress.currentSentenceIndex
    }
  }

  // 4. Mặc định về câu đầu tiên
  return 0
}

console.log('=== BẮT ĐẦU KIỂM THỬ TÍNH NĂNG TIẾP TỤC HỌC & KHÔI PHỤC TIẾN ĐỘ THÔNG MINH ===\n')

const mockExercises = [
  { id: 'trans-ex-1', vietnamesePrompt: 'Xin chào.', chineseAnswer: '你好。' },
  { id: 'trans-ex-2', vietnamesePrompt: 'Tôi là học sinh.', chineseAnswer: '我是学生。' },
  { id: 'trans-ex-3', vietnamesePrompt: 'Tôi muốn uống một tách hồng trà nóng.', chineseAnswer: '我想喝一杯热红茶。' },
  { id: 'trans-ex-4', vietnamesePrompt: 'Hôm nay trời rất đẹp.', chineseAnswer: '今天天气很好。' },
  { id: 'trans-ex-5', vietnamesePrompt: 'Tạm biệt!', chineseAnswer: '再见！' },
]

// Test 1: Khôi phục chính xác theo currentQuestionId (Trường hợp A trong đề bài)
{
  const saved = {
    mode: 'translate_hsk',
    exerciseId: 'hsk2-lesson-1',
    currentSentenceIndex: 2,
    currentQuestionId: 'trans-ex-3',
    currentQuestionText: 'Tôi muốn uống một tách hồng trà nóng.',
    status: 'in_progress',
  }

  const idx = resolveResumeSentenceIndex({
    exercises: mockExercises,
    savedProgress: saved,
  })

  assert.strictEqual(idx, 2, 'Phải tìm thấy đúng câu 3 (index 2)')
  assert.strictEqual(mockExercises[idx].vietnamesePrompt, 'Tôi muốn uống một tách hồng trà nóng.')
  console.log('✔ Test 1 PASS: Khôi phục chính xác câu đang học dở theo currentQuestionId')
}

// Test 2: Nếu câu hỏi bị đổi thứ tự trong bài, vẫn tìm đúng câu theo ID ổn định
{
  const reorderedExercises = [
    mockExercises[3], // trans-ex-4
    mockExercises[2], // trans-ex-3 (đã bị chuyển từ index 2 sang index 1)
    mockExercises[0], // trans-ex-1
    mockExercises[1], // trans-ex-2
  ]

  const saved = {
    currentSentenceIndex: 2, // Index cũ là 2
    currentQuestionId: 'trans-ex-3', // Nhưng ID câu là trans-ex-3
    status: 'in_progress',
  }

  const idx = resolveResumeSentenceIndex({
    exercises: reorderedExercises,
    savedProgress: saved,
  })

  assert.strictEqual(idx, 1, 'Phải tìm ra index mới là 1 dựa vào ID câu')
  console.log('✔ Test 2 PASS: Dữ liệu thay đổi vị trí -> Tự tìm vị trí mới qua ID câu ổn định')
}

// Test 3: Nếu câu hỏi bị xóa khỏi đề cương -> Fallback an toàn sang currentSentenceIndex
{
  const saved = {
    currentSentenceIndex: 3,
    currentQuestionId: 'trans-ex-deleted', // Câu đã bị xóa
    status: 'in_progress',
  }

  const idx = resolveResumeSentenceIndex({
    exercises: mockExercises,
    savedProgress: saved,
  })

  assert.strictEqual(idx, 3, 'Phải fallback an toàn về index 3')
  console.log('✔ Test 3 PASS: Câu bị xóa -> Fallback an toàn sang chỉ số câu hợp lệ gần nhất')
}

// Test 4: Nếu cả ID và index đều vượt biên -> Không crash, về câu 0 an toàn
{
  const saved = {
    currentSentenceIndex: 999,
    currentQuestionId: 'unknown-id',
    status: 'in_progress',
  }

  const idx = resolveResumeSentenceIndex({
    exercises: mockExercises,
    savedProgress: saved,
  })

  assert.strictEqual(idx, 0, 'Phải trả về 0 an toàn không crash')
  console.log('✔ Test 4 PASS: Dữ liệu vượt biên hoàn toàn -> Trả về câu 0 an toàn')
}

// Test 5: Nếu bài học đã hoàn thành (status === 'completed') -> Bắt đầu lại từ câu 0
{
  const saved = {
    currentSentenceIndex: 4,
    currentQuestionId: 'trans-ex-5',
    status: 'completed',
  }

  const idx = resolveResumeSentenceIndex({
    exercises: mockExercises,
    savedProgress: saved,
  })

  assert.strictEqual(idx, 0, 'Bài đã hoàn thành thì mặc định bắt đầu lại từ đầu')
  console.log('✔ Test 5 PASS: Bài đã hoàn thành -> Tự động cho phép học lại từ câu 0')
}

// Test 6: Nhấn link "Tiếp tục học" có initialSentenceId từ trang chủ
{
  const idx = resolveResumeSentenceIndex({
    exercises: mockExercises,
    initialSentenceId: 'trans-ex-3',
  })

  assert.strictEqual(idx, 2, 'Link từ trang chủ dẫn thẳng đến câu 3')
  console.log('✔ Test 6 PASS: Điều hướng 1 chạm từ trang chủ vào đúng câu đang học')
}

console.log('\n======================================================')
console.log('🎉 TOÀN BỘ 6 TEST CASE TIẾP TỤC HỌC ĐỀU ĐẠT CHUẨN 100%!')
console.log('======================================================\n')

