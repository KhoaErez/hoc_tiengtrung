// Test script: test-progress-separation.mjs
// Kiểm thử tính độc lập hoàn toàn của tiến độ giữa 2 chế độ 'visual' (Nghe & Gõ) và 'translate' (Dịch Việt -> Gõ Hán)

console.log('=== TEST BẮT ĐẦU: PHÂN TÁCH TIẾN ĐỘ 2 CHẾ ĐỘ LUYỆN GÕ ===\n')

// Giả lập map storage trong localStorage
let mockStorage = {}

function getAllLocalProgressMap() {
  return mockStorage
}

function getLatestLocalTypingProgress(practiceMode) {
  const map = getAllLocalProgressMap()
  let list = Object.values(map)

  if (practiceMode === 'translate') {
    list = list.filter((item) => item.practiceMode === 'translate' || item.mode === 'translate_hsk')
  } else if (practiceMode === 'visual') {
    list = list.filter((item) => item.practiceMode === 'visual' || (item.practiceMode !== 'translate' && item.mode !== 'translate_hsk'))
  }

  if (list.length === 0) return null
  return list.sort((a, b) => new Date(b.updatedAt).getTime() - new Date(a.updatedAt).getTime())[0] || null
}

function saveLocalTypingProgress(item) {
  const key = `${item.mode}_${item.exerciseId}`
  mockStorage[key] = {
    ...item,
    practiceMode: item.practiceMode || (item.mode === 'translate_hsk' ? 'translate' : 'visual'),
    updatedAt: item.updatedAt || new Date().toISOString(),
  }
}

function resetLocalTypingProgress(mode, exerciseId) {
  const key = `${mode}_${exerciseId}`
  if (mockStorage[key]) {
    mockStorage[key] = {
      ...mockStorage[key],
      currentSentenceIndex: 0,
      completedSentences: 0,
      correctSentences: 0,
      errorSentences: 0,
      lastTypedLength: 0,
      status: 'not_started',
      updatedAt: new Date().toISOString(),
    }
  }
}

let passed = 0
let failed = 0

function assert(condition, testName) {
  if (condition) {
    console.log(`[PASS] ${testName}`)
    passed++
  } else {
    console.error(`[FAIL] ${testName}`)
    failed++
  }
}

// TEST 1: Khi storage rỗng -> Cả 2 chế độ đều trả về null
assert(getLatestLocalTypingProgress('visual') === null, 'Storage rỗng -> Nghe & Gõ nhận null')
assert(getLatestLocalTypingProgress('translate') === null, 'Storage rỗng -> Dịch nhận null')

// TEST 2: Người dùng học Dịch Việt -> Gõ Hán
saveLocalTypingProgress({
  mode: 'translate_hsk',
  exerciseId: 'hsk1-all',
  currentSentenceIndex: 10,
  completedSentences: 10,
  totalSentences: 60,
  correctSentences: 8,
  errorSentences: 2,
  status: 'in_progress',
  practiceMode: 'translate',
  hskLevel: 1,
  currentQuestionText: 'Chúng tôi ngồi tàu hỏa đi Bắc Kinh.',
  updatedAt: '2026-10-29T10:00:00.000Z',
})

// Kiểm tra: Dịch phải có tiến độ, Nghe & Gõ KHÔNG ĐƯỢC CÓ tiến độ
const translateP1 = getLatestLocalTypingProgress('translate')
const visualP1 = getLatestLocalTypingProgress('visual')

assert(translateP1 !== null, 'Dịch Việt -> Gõ Hán lấy được tiến độ vừa lưu')
assert(translateP1?.currentSentenceIndex === 10, 'Dịch Việt -> Gõ Hán đúng câu 11 (index 10)')
assert(translateP1?.practiceMode === 'translate', 'Dịch có practiceMode là translate')
assert(visualP1 === null, 'Nghe & Gõ KHÔNG BỊ NHIỄM tiến độ của Dịch (trả về null)')

// TEST 3: Người dùng sau đó học Nghe & Gõ (chế độ Câu mẫu)
saveLocalTypingProgress({
  mode: 'sentence',
  exerciseId: 'sentence-1',
  currentSentenceIndex: 3,
  completedSentences: 3,
  totalSentences: 100,
  correctSentences: 3,
  errorSentences: 0,
  status: 'in_progress',
  practiceMode: 'visual',
  lessonTitle: 'Câu mẫu',
  currentQuestionText: '千里之行，始于足下。',
  updatedAt: '2026-10-29T11:00:00.000Z', // Mới hơn tiến độ Dịch
})

// Kiểm tra: Dù Nghe & Gõ mới hơn về thời gian, Dịch vẫn lấy ĐÚNG tiến độ của Dịch
const translateP2 = getLatestLocalTypingProgress('translate')
const visualP2 = getLatestLocalTypingProgress('visual')

assert(translateP2 !== null && translateP2.exerciseId === 'hsk1-all', 'Dịch vẫn giữ nguyên tiến độ của Dịch (không bị đè bởi Nghe & Gõ)')
assert(translateP2?.currentSentenceIndex === 10, 'Dịch vẫn đúng câu 11')
assert(visualP2 !== null && visualP2.exerciseId === 'sentence-1', 'Nghe & Gõ lấy đúng tiến độ của Nghe & Gõ')
assert(visualP2?.currentSentenceIndex === 3, 'Nghe & Gõ đúng câu 4 (index 3)')
assert(visualP2?.mode === 'sentence', 'Nghe & Gõ lưu đúng sub-mode sentence')

// TEST 4: "Học lại từ đầu" trong Nghe & Gõ -> Chỉ reset Nghe & Gõ, KHÔNG ảnh hưởng Dịch
resetLocalTypingProgress('sentence', 'sentence-1')
const visualP3 = getLatestLocalTypingProgress('visual')
const translateP3 = getLatestLocalTypingProgress('translate')

assert(visualP3?.status === 'not_started' && visualP3?.currentSentenceIndex === 0, 'Nghe & Gõ đã được reset về câu 0')
assert(translateP3?.status === 'in_progress' && translateP3?.currentSentenceIndex === 10, 'Tiến độ Dịch HOÀN TOÀN KHÔNG BỊ ẢNH HƯỞNG khi reset Nghe & Gõ')

// TEST 5: Fallback cho bản ghi legacy chưa có trường practiceMode rõ ràng
saveLocalTypingProgress({
  mode: 'hsk',
  exerciseId: 'hsk-2-lesson-3',
  currentSentenceIndex: 5,
  completedSentences: 5,
  totalSentences: 20,
  correctSentences: 5,
  errorSentences: 0,
  status: 'in_progress',
  hskLevel: 2,
  updatedAt: new Date(Date.now() + 1000).toISOString(),
})

const visualP4 = getLatestLocalTypingProgress('visual')
assert(visualP4?.mode === 'hsk' && visualP4?.currentSentenceIndex === 5, 'Bản ghi mode hsk tự động nhận diện visual mode')
assert(visualP4?.practiceMode === 'visual', 'practiceMode được gán visual tự động')

console.log(`\n=== KẾT QUẢ: ${passed} PASS, ${failed} FAIL ===`)
if (failed > 0) process.exit(1)

