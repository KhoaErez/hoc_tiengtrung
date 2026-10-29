/**
 * TEST SUITE: KIỂM THỬ PHÂN TÁCH ĐỘC LẬP 2 CHẾ ĐỘ ÔN TẬP CÂU SAI
 * 1. Chế độ Dịch Việt -> Gõ Hán ('translate')
 * 2. Chế độ Nghe & Gõ ('listen')
 *
 * Chạy bằng: node scripts/test-split-mistakes.mjs
 */

// Inlined SM-2 functions for pure standalone Node test
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
  } else {
    status = 'need_review'
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

function mapTypingResultToQuality(isCorrect, hintsUsed = 0, hadRetryInCurrentSession = false) {
  if (!isCorrect) {
    return hadRetryInCurrentSession ? 1 : 2
  }
  if (hintsUsed === 0 && !hadRetryInCurrentSession) {
    return 5
  }
  if (hintsUsed === 0 && hadRetryInCurrentSession) {
    return 4
  }
  if (hintsUsed === 1) {
    return 3
  }
  return 3
}

function isItemDue(dueAt) {
  if (!dueAt) return true
  const due = new Date(dueAt).getTime()
  const now = Date.now()
  return due <= now
}

// Mock localStorage in-memory
const localStorageMap = new Map();
global.localStorage = {
  getItem: (key) => localStorageMap.get(key) || null,
  setItem: (key, value) => localStorageMap.set(key, String(value)),
  removeItem: (key) => localStorageMap.delete(key),
  clear: () => localStorageMap.clear(),
};
global.window = {};

// Import các hàm storage sau khi mock localStorage
const STORAGE_KEY_MISTAKES_LOCAL = 'typing_practice_mistakes_local';

function getLocalTypingMistakes(filter) {
  const raw = localStorage.getItem(STORAGE_KEY_MISTAKES_LOCAL);
  if (!raw) return [];
  let list = JSON.parse(raw);

  if (filter?.practiceType && filter.practiceType !== 'all') {
    list = list.filter((m) => {
      const itemType = m.practiceType || (m.mode?.includes('translate') ? 'translate' : 'listen');
      return itemType === filter.practiceType;
    });
  }

  if (filter?.mode && filter.mode !== 'all') {
    list = list.filter((m) => m.mode === filter.mode);
  }
  if (filter?.reviewStatus && filter.reviewStatus !== 'all') {
    list = list.filter((m) => m.reviewStatus === filter.reviewStatus);
  }
  return list;
}

function recordLocalTypingMistake(data) {
  const list = getLocalTypingMistakes();
  const now = new Date().toISOString();
  const effectivePracticeType = data.practiceType || (data.mode?.includes('translate') ? 'translate' : 'listen');

  const existingIdx = list.findIndex((m) => {
    const itemType = m.practiceType || (m.mode?.includes('translate') ? 'translate' : 'listen');
    return (
      itemType === effectivePracticeType &&
      m.exerciseId === data.exerciseId &&
      m.sentenceIndex === data.sentenceIndex
    );
  });

  if (existingIdx !== -1) {
    const existing = list[existingIdx];
    const updated = {
      ...existing,
      practiceType: effectivePracticeType,
      sentenceZh: data.sentenceZh,
      pinyin: data.pinyin || existing.pinyin,
      meaningVi: data.meaningVi || existing.meaningVi,
      lastInputZh: data.lastInputZh,
      mistakeDetails: data.mistakeDetails,
      mistakeCount: existing.mistakeCount + 1,
      reviewStatus: 'need_review',
      consecutiveCorrect: 0,
      intervalDays: 0,
      easeFactor: existing.easeFactor || 2.5,
      dueAt: now,
      lapses: (existing.lapses || 0) + 1,
      lastErrorAt: now,
    };
    list[existingIdx] = updated;
    localStorage.setItem(STORAGE_KEY_MISTAKES_LOCAL, JSON.stringify(list));
    return updated;
  }

  const newMistake = {
    id: `local-mistake-${Date.now()}-${Math.random().toString(36).substring(2, 6)}`,
    mode: data.mode,
    practiceType: effectivePracticeType,
    exerciseId: data.exerciseId,
    sentenceIndex: data.sentenceIndex,
    sentenceZh: data.sentenceZh,
    pinyin: data.pinyin,
    meaningVi: data.meaningVi,
    lastInputZh: data.lastInputZh,
    mistakeDetails: data.mistakeDetails,
    mistakeCount: 1,
    reviewStatus: 'need_review',
    reviewCount: 0,
    reviewCorrectCount: 0,
    consecutiveCorrect: 0,
    intervalDays: 0,
    easeFactor: 2.5,
    dueAt: now,
    lapses: 0,
    lastErrorAt: now,
  };

  list.unshift(newMistake);
  localStorage.setItem(STORAGE_KEY_MISTAKES_LOCAL, JSON.stringify(list));
  return newMistake;
}

function updateLocalMistakeReview(mistakeId, isCorrect, options) {
  const list = getLocalTypingMistakes();
  const idx = list.findIndex((m) => m.id === mistakeId);
  if (idx === -1) return null;

  const current = list[idx];
  const now = new Date().toISOString();
  const newReviewCount = current.reviewCount + 1;
  const newReviewCorrectCount = isCorrect ? current.reviewCorrectCount + 1 : current.reviewCorrectCount;

  const quality = mapTypingResultToQuality(
    isCorrect,
    options?.hintsUsed ?? 0,
    options?.hadRetry ?? false
  );

  const sm2Result = calculateSM2({
    quality,
    repetitions: current.consecutiveCorrect || 0,
    interval: current.intervalDays || 0,
    easeFactor: current.easeFactor || 2.5,
    lapses: current.lapses || 0,
  });

  const updated = {
    ...current,
    reviewCount: newReviewCount,
    reviewCorrectCount: newReviewCorrectCount,
    consecutiveCorrect: sm2Result.repetitions,
    intervalDays: sm2Result.interval,
    easeFactor: sm2Result.easeFactor,
    dueAt: sm2Result.dueAt,
    lapses: sm2Result.lapses,
    reviewStatus: sm2Result.status,
    lastReviewedAt: now,
  };

  list[idx] = updated;
  localStorage.setItem(STORAGE_KEY_MISTAKES_LOCAL, JSON.stringify(list));
  return updated;
}

function getLocalDueMistakesCount(practiceType) {
  const list = getLocalTypingMistakes(practiceType ? { practiceType } : undefined);
  return list.filter((m) => isItemDue(m.dueAt)).length;
}

// Bắt đầu chạy các bài kiểm thử
console.log('===============================================================');
console.log('🧪 BẮT ĐẦU KIỂM THỬ: TÁCH BIỆT 2 CHẾ ĐỘ ÔN TẬP CÂU SAI');
console.log('===============================================================\n');

let totalPassed = 0;
let totalFailed = 0;

function assert(condition, message) {
  if (condition) {
    console.log(`  ✅ [PASS] ${message}`);
    totalPassed++;
  } else {
    console.error(`  ❌ [FAIL] ${message}`);
    totalFailed++;
  }
}

// -------------------------------------------------------------
// TEST CASE 1: Ghi nhận câu sai ở chế độ Dịch ('translate')
// -------------------------------------------------------------
console.log('📌 Test 1: Ghi nhận câu sai ở chế độ Dịch Việt -> Gõ Hán');
localStorage.clear();

const mistakeTranslate = recordLocalTypingMistake({
  mode: 'translate_vi_to_han',
  practiceType: 'translate',
  exerciseId: 'hsk1-lesson-1',
  sentenceIndex: 0,
  sentenceZh: '你好！',
  pinyin: 'nǐ hǎo!',
  meaningVi: 'Xin chào!',
  lastInputZh: '你号',
  mistakeDetails: [{ index: 2, expected: '好', actual: '号' }],
});

assert(mistakeTranslate.practiceType === 'translate', 'Bản ghi có practiceType là "translate"');
assert(mistakeTranslate.mistakeCount === 1, 'Số lần sai ban đầu là 1');
assert(mistakeTranslate.reviewStatus === 'need_review', 'Trạng thái ôn tập ban đầu là need_review');
assert(mistakeTranslate.intervalDays === 0, 'Khoảng cách ngày SM-2 ban đầu là 0');

// -------------------------------------------------------------
// TEST CASE 2: Cùng một câu nhưng sai ở chế độ Nghe & Gõ ('listen')
// Hệ thống PHẢI tạo ra 2 bản ghi độc lập, KHÔNG được ghi đè!
// -------------------------------------------------------------
console.log('\n📌 Test 2: Cùng một câu nhưng sai ở chế độ Nghe & Gõ');

const mistakeListen = recordLocalTypingMistake({
  mode: 'sentence',
  practiceType: 'listen',
  exerciseId: 'hsk1-lesson-1',
  sentenceIndex: 0,
  sentenceZh: '你好！',
  pinyin: 'nǐ hǎo!',
  meaningVi: 'Xin chào!',
  lastInputZh: '泥好',
  mistakeDetails: [{ index: 1, expected: '你', actual: '泥' }],
});

assert(mistakeListen.practiceType === 'listen', 'Bản ghi có practiceType là "listen"');
assert(mistakeListen.id !== mistakeTranslate.id, 'ID của 2 bản ghi hoàn toàn khác nhau');

const allMistakes = getLocalTypingMistakes();
assert(allMistakes.length === 2, `Tổng số bản ghi là 2 (thực tế: ${allMistakes.length})`);

// -------------------------------------------------------------
// TEST CASE 3: Lọc danh sách câu sai theo từng chế độ
// -------------------------------------------------------------
console.log('\n📌 Test 3: Lọc danh sách câu sai riêng biệt cho từng chế độ');

const transOnly = getLocalTypingMistakes({ practiceType: 'translate' });
assert(transOnly.length === 1, `Chế độ Dịch có đúng 1 câu (thực tế: ${transOnly.length})`);
assert(transOnly[0].practiceType === 'translate', 'Câu trong danh mục Dịch có practiceType = translate');

const listenOnly = getLocalTypingMistakes({ practiceType: 'listen' });
assert(listenOnly.length === 1, `Chế độ Nghe & Gõ có đúng 1 câu (thực tế: ${listenOnly.length})`);
assert(listenOnly[0].practiceType === 'listen', 'Câu trong danh mục Nghe có practiceType = listen');

// -------------------------------------------------------------
// TEST CASE 4: Ôn tập câu Dịch KHÔNG làm ảnh hưởng đến câu Nghe
// -------------------------------------------------------------
console.log('\n📌 Test 4: Độc lập thuật toán Spaced Repetition (SM-2)');

// Người dùng ôn tập câu Dịch và trả lời đúng 100% không cần gợi ý
const updatedTrans = updateLocalMistakeReview(mistakeTranslate.id, true, { hintsUsed: 0, hadRetry: false });

assert(updatedTrans.reviewStatus === 'reviewing', 'Câu Dịch sau khi ôn đúng chuyển sang reviewing');
assert(updatedTrans.intervalDays === 1, 'Câu Dịch được tăng khoảng cách ôn lên 1 ngày');
assert(updatedTrans.consecutiveCorrect === 1, 'Chuỗi đúng của câu Dịch là 1');

// Kiểm tra lại câu Nghe & Gõ: PHẢI GIỮ NGUYÊN trạng thái need_review và interval = 0!
const listenReloaded = getLocalTypingMistakes({ practiceType: 'listen' })[0];
assert(listenReloaded.reviewStatus === 'need_review', 'Câu Nghe & Gõ vẫn giữ nguyên trạng thái need_review');
assert(listenReloaded.intervalDays === 0, 'Câu Nghe & Gõ vẫn có khoảng cách ngày = 0');
assert(listenReloaded.consecutiveCorrect === 0, 'Chuỗi đúng của câu Nghe & Gõ vẫn là 0');

// -------------------------------------------------------------
// TEST CASE 5: Đếm số câu đến hạn riêng biệt cho từng Tab
// -------------------------------------------------------------
console.log('\n📌 Test 5: Bộ đếm số câu đến hạn độc lập');

const dueTranslate = getLocalDueMistakesCount('translate');
const dueListen = getLocalDueMistakesCount('listen');

console.log(`  ℹ️ Số câu Dịch đến hạn: ${dueTranslate}, Số câu Nghe đến hạn: ${dueListen}`);
assert(dueListen === 1, 'Chế độ Nghe & Gõ có đúng 1 câu đến hạn hôm nay');

// -------------------------------------------------------------
// TEST CASE 6: Tự động suy luận practiceType nếu dữ liệu cũ chưa có trường này
// -------------------------------------------------------------
console.log('\n📌 Test 6: Tương thích ngược với dữ liệu cũ (Backward Compatibility)');

// Giả lập 1 bản ghi cũ chỉ có mode = 'translate_hsk' mà chưa có practiceType
const legacyData = [
  {
    id: 'legacy-1',
    mode: 'translate_hsk',
    exerciseId: 'hsk2-1',
    sentenceIndex: 1,
    sentenceZh: '这是我的书。',
    lastInputZh: '这是我的',
    mistakeCount: 1,
    reviewStatus: 'need_review',
    lastErrorAt: new Date().toISOString(),
  },
  {
    id: 'legacy-2',
    mode: 'hsk',
    exerciseId: 'hsk2-1',
    sentenceIndex: 1,
    sentenceZh: '这是我的书。',
    lastInputZh: '这是我的叔',
    mistakeCount: 1,
    reviewStatus: 'need_review',
    lastErrorAt: new Date().toISOString(),
  },
];
localStorage.setItem(STORAGE_KEY_MISTAKES_LOCAL, JSON.stringify(legacyData));

const legacyTrans = getLocalTypingMistakes({ practiceType: 'translate' });
assert(legacyTrans.length === 1 && legacyTrans[0].id === 'legacy-1', 'Bản ghi cũ mode="translate_hsk" được tự động phân loại vào "translate"');

const legacyListen = getLocalTypingMistakes({ practiceType: 'listen' });
assert(legacyListen.length === 1 && legacyListen[0].id === 'legacy-2', 'Bản ghi cũ mode="hsk" được tự động phân loại vào "listen"');

// -------------------------------------------------------------
// TỔNG KẾT
// -------------------------------------------------------------
console.log('\n===============================================================');
console.log(`🏁 KẾT QUẢ KIỂM THỬ: ${totalPassed} PASSED / ${totalFailed} FAILED`);
console.log('===============================================================');

if (totalFailed > 0) {
  process.exit(1);
} else {
  console.log('🎉 TẤT CẢ TEST CASES ĐÃ VƯỢT QUA XUẤT SẮC!');
}

