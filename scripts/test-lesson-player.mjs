// scripts/test-lesson-player.mjs
// Kiểm thử toàn diện cho Course Roadmap & Lesson Player (HSK & Tiếng Trung Công Xưởng):
// 1. Tính toàn vẹn dữ liệu 2 nhánh HSK 1-6 & Tiếng Trung Công Xưởng (Unit 1, Unit 2: Báo lỗi máy & Bảo trì, Unit 3)
// 2. Xáo trộn Word Bank có tính tất định (deterministic shuffle giữa SSR & Client)
// 3. Chấm điểm chính xác cả 3 dạng bài tập (multiple_choice, word_bank, typing chuẩn IME / chuẩn hóa dấu câu)
// 4. Tính toán phần trăm tiến độ & điều hướng bài học tiếp theo

import fs from 'node:fs'
import path from 'node:path'
import vm from 'node:vm'
import { fileURLToPath } from 'node:url'
import { createRequire } from 'node:module'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const rootDir = path.resolve(__dirname, '..')
const nodeRequire = createRequire(import.meta.url)
const ts = await import('typescript')

const tsModuleCache = new Map()
function resolveTsPath(specifier, fromFile) {
  let basePath = null
  if (specifier.startsWith('./') || specifier.startsWith('../')) {
    basePath = path.resolve(path.dirname(fromFile), specifier)
  } else if (specifier.startsWith('@/')) {
    basePath = path.join(rootDir, specifier.slice(2))
  } else {
    return null
  }
  const candidates = [basePath, `${basePath}.ts`, `${basePath}.tsx`, path.join(basePath, 'index.ts')]
  for (const candidate of candidates) {
    if (fs.existsSync(candidate) && fs.statSync(candidate).isFile()) {
      return candidate
    }
  }
  return null
}

function loadTsModule(filePath) {
  const absPath = path.resolve(filePath)
  if (tsModuleCache.has(absPath)) {
    return tsModuleCache.get(absPath).exports
  }
  const source = fs.readFileSync(absPath, 'utf8')
  const compiled = ts.default.transpileModule(source, {
    compilerOptions: {
      module: ts.default.ModuleKind.CommonJS,
      target: ts.default.ScriptTarget.ES2022,
      jsx: ts.default.JsxEmit.ReactJSX,
      esModuleInterop: true,
    },
  })
  const mod = { exports: {} }
  tsModuleCache.set(absPath, mod)
  const customRequire = (spec) => {
    const resolvedTs = resolveTsPath(spec, absPath)
    if (resolvedTs) return loadTsModule(resolvedTs)
    return nodeRequire(spec)
  }
  const wrapper = `(function(exports, module, require, __filename, __dirname) { ${compiled.outputText} \n})`
  const compiledFn = vm.runInThisContext(wrapper, { filename: absPath })
  compiledFn(mod.exports, mod, customRequire, absPath, path.dirname(absPath))
  return mod.exports
}

const {
  COURSE_UNITS,
  getCourseUnitsByTrack,
  getAllCourseLessons,
  getCourseLessonById,
  getNextCourseLesson,
  buildShuffledWordBank,
} = loadTsModule(path.join(rootDir, 'data', 'course-roadmap-data.ts'))

const {
  evaluateLessonQuiz,
  isChineseSentenceEquivalent,
} = loadTsModule(path.join(rootDir, 'lib', 'lesson-quiz-eval.ts'))

const {
  calculateCourseStepPercent,
  getCourseCtaLabel,
} = loadTsModule(path.join(rootDir, 'lib', 'course-progress-storage.ts'))

const {
  segmentChineseSentenceForWordBank,
  buildDynamicCourseLessonChunk,
} = loadTsModule(path.join(rootDir, 'lib', 'dynamic-lesson-builder.ts'))

let passed = 0
let failed = 0

function assert(condition, label) {
  if (condition) {
    passed++
    console.log(`  ✅ [PASS] ${label}`)
  } else {
    failed++
    console.error(`  ❌ [FAIL] ${label}`)
  }
}

console.log('=================================================================')
console.log('🧪 BẮT ĐẦU KIỂM THỬ: COURSE ROADMAP & LESSON PLAYER (SUPERCHINESE)')
console.log('=================================================================\n')

console.log('📌 1. Kiểm tra dữ liệu Track HSK 1-6 & Tiếng Trung Công Xưởng:')
for (let lvl = 1; lvl <= 6; lvl++) {
  const units = getCourseUnitsByTrack('hsk', lvl)
  assert(units.length >= 1, `HSK ${lvl} có ít nhất 1 Unit (${units.length})`)
  assert(units[0].lessons.length >= 1, `HSK ${lvl} có ít nhất 1 Lesson (${units[0].lessons.length})`)
}

const factoryUnits = getCourseUnitsByTrack('factory')
assert(factoryUnits.length === 3, `Nhánh Công Xưởng có đúng 3 Unit thực tế (thực tế: ${factoryUnits.length})`)
assert(
  factoryUnits[1]?.lessons.some((l) => l.id === 'factory-u2-l1' && l.title.includes('Báo lỗi máy')),
  'Unit 2 Công Xưởng có bài học "Báo lỗi máy & Bảo trì" (factory-u2-l1)'
)

const allLessons = getAllCourseLessons()
for (const lesson of allLessons) {
  const types = new Set(lesson.quizzes.map((q) => q.type))
  assert(
    lesson.vocabs.length >= 3 &&
      lesson.dialogue.lines.length >= 4 &&
      lesson.quizzes.length >= 3 &&
      types.has('multiple_choice') &&
      types.has('word_bank') &&
      types.has('typing'),
    `Bài "${lesson.id}" có đủ >=3 từ vựng, >=4 câu hội thoại, và đủ 3 dạng bài tập`
  )
}

console.log('\n📌 2. Kiểm tra điều hướng bài học kế tiếp & Word Bank shuffle tất định:')
const foundHsk1 = getCourseLessonById('hsk1-u1-l1')
assert(Boolean(foundHsk1), 'Tìm thấy bài hsk1-u1-l1')
const nextFromHsk1 = getNextCourseLesson('hsk1-u1-l1')
assert(nextFromHsk1?.id === 'hsk1-u1-l2', `Bài tiếp theo sau hsk1-u1-l1 là hsk1-u1-l2 (thực tế: ${nextFromHsk1?.id})`)

const foundFactory = getCourseLessonById('factory-u2-l1')
assert(Boolean(foundFactory), 'Tìm thấy bài Công Xưởng factory-u2-l1')
const nextFromFactory = getNextCourseLesson('factory-u2-l1')
assert(nextFromFactory?.id === 'factory-u2-l2', `Bài tiếp theo sau factory-u2-l1 là factory-u2-l2 (thực tế: ${nextFromFactory?.id})`)

const wordBankQuiz = foundFactory.lesson.quizzes.find((q) => q.type === 'word_bank')
const shuffle1 = buildShuffledWordBank(wordBankQuiz).map((t) => t.text)
const shuffle2 = buildShuffledWordBank(wordBankQuiz).map((t) => t.text)
assert(
  JSON.stringify(shuffle1) === JSON.stringify(shuffle2),
  'buildShuffledWordBank trả về thứ tự cố định giữa các lần gọi (an toàn SSR Hydration)'
)
assert(
  shuffle1.length === wordBankQuiz.targetTokens.length + (wordBankQuiz.distractorTokens?.length || 0),
  'Word Bank chứa đầy đủ mảnh đúng + mảnh nhiễu'
)

console.log('\n📌 3. Kiểm tra chấm điểm 3 dạng bài tập (Multiple Choice, Word Bank, IME Typing):')
const mcQuiz = foundFactory.lesson.quizzes.find((q) => q.type === 'multiple_choice')
assert(
  evaluateLessonQuiz(mcQuiz, { selectedOptionId: mcQuiz.correctOptionId }).isCorrect === true,
  'Trắc nghiệm chọn đúng đáp án -> isCorrect = true'
)
assert(
  evaluateLessonQuiz(mcQuiz, { selectedOptionId: 'd' }).isCorrect === false &&
    evaluateLessonQuiz(mcQuiz, { selectedOptionId: 'd' }).correctAnswerDisplay.length > 0,
  'Trắc nghiệm chọn sai -> isCorrect = false và trả về đáp án đúng'
)

assert(
  evaluateLessonQuiz(wordBankQuiz, { selectedWordBankTokens: wordBankQuiz.targetTokens }).isCorrect === true,
  'Word Bank ghép đúng thứ tự -> isCorrect = true'
)
assert(
  evaluateLessonQuiz(wordBankQuiz, {
    selectedWordBankTokens: [...wordBankQuiz.targetTokens].reverse(),
  }).isCorrect === false,
  'Word Bank ghép sai thứ tự -> isCorrect = false'
)

const typingQuiz = foundFactory.lesson.quizzes.find((q) => q.type === 'typing')
assert(
  evaluateLessonQuiz(typingQuiz, { typingInput: typingQuiz.expectedHanzi }).isCorrect === true,
  'IME Typing gõ chuẩn dấu câu full-width -> isCorrect = true'
)
assert(
  evaluateLessonQuiz(typingQuiz, { typingInput: ' 这台 机器出故障了. ' }).isCorrect === true,
  'IME Typing hỗ trợ dấu chấm half-width & loại bỏ khoảng trắng thừa giữa chữ Hán'
)
assert(
  isChineseSentenceEquivalent('你好,我叫小明.', '你好，我叫小明。') === true,
  'isChineseSentenceEquivalent tương đương dấu phẩy/chấm half-width và full-width'
)
assert(
  evaluateLessonQuiz(typingQuiz, { typingInput: '你好' }).isCorrect === false,
  'IME Typing gõ sai nội dung -> isCorrect = false'
)

console.log('\n📌 4. Kiểm tra tính phần trăm tiến độ & nhãn nút CTA:')
assert(calculateCourseStepPercent(0, 8, false) >= 0 && calculateCourseStepPercent(0, 8, false) < 50, 'Tiến độ bước đầu < 50%')
assert(calculateCourseStepPercent(7, 8, true) === 100, 'Bước Tổng kết trả về đúng 100%')
assert(getCourseCtaLabel(null) === 'Bắt đầu học', 'Chưa học -> Bắt đầu học')
assert(
  getCourseCtaLabel({ lessonId: 'x', currentStepIndex: 3, totalSteps: 8, percent: 45, completed: false, updatedAt: '' }) === 'Học tiếp',
  'Đang học dở (45%) -> Học tiếp'
)
assert(
  getCourseCtaLabel({ lessonId: 'x', currentStepIndex: 7, totalSteps: 8, percent: 100, completed: true, updatedAt: '' }) === 'Ôn lại',
  'Đã xong (100%) -> Ôn lại'
)

console.log('\n📌 5. Kiểm tra Dynamic SuperChinese Builder cho bài học Supabase (/lessons/[id]):')
const sortedTokens = segmentChineseSentenceForWordBank('认识你我很高兴。', ['认识', '高兴'])
assert(
  sortedTokens.length >= 2 && sortedTokens.length <= 6 && sortedTokens.join('') === '认识你我很高兴。',
  `Tách câu "认识你我很高兴。" thành ${sortedTokens.length} thẻ ghép nguyên vẹn (${JSON.stringify(sortedTokens)})`
)

const sampleDbVocabs = Array.from({ length: 16 }, (_, idx) => ({
  id: `db-v-${idx + 1}`,
  hanzi: idx === 0 ? '高兴' : `词${idx + 1}`,
  pinyin: idx === 0 ? 'gāoxìng' : `cí${idx + 1}`,
  meaning_vi: idx === 0 ? 'Vui vẻ' : `Từ thứ ${idx + 1}`,
  example_hanzi: idx === 0 ? '认识你我很高兴。' : `这是第${idx + 1}个例句。`,
  example_pinyin: idx === 0 ? 'Rènshi nǐ wǒ hěn gāoxìng.' : `Zhè shì dì ${idx + 1} gè lìjù.`,
  example_vi: idx === 0 ? 'Rất vui được làm quen với bạn.' : `Đây là câu ví dụ số ${idx + 1}.`,
}))

const chunk0 = buildDynamicCourseLessonChunk(
  { id: 'lesson-hsk1-1', title: 'Chào hỏi cơ bản', hsk_level: 'HSK 1', lesson_number: 1 },
  sampleDbVocabs,
  0,
  4
)
assert(chunk0.totalChunks === 4, `16 từ vựng được chia thành đúng 4 chặng học (thực tế: ${chunk0.totalChunks})`)
assert(chunk0.lesson.vocabs.length === 4, 'Chặng 1 có đúng 4 từ vựng trọng tâm')
assert(
  Array.isArray(chunk0.lesson.writeWords) && chunk0.lesson.writeWords.length >= 1,
  `Chặng 1 tự động trích xuất từ luyện vẽ chữ HanziWriter (${chunk0.lesson.writeWords?.length})`
)
const dynamicQuizTypes = new Set(chunk0.lesson.quizzes.map((q) => q.type))
assert(
  dynamicQuizTypes.has('multiple_choice') &&
    dynamicQuizTypes.has('word_bank') &&
    dynamicQuizTypes.has('typing'),
  'Chặng động /lessons/[id] sinh đủ cả 3 dạng: Trắc nghiệm, Sắp xếp từ thành câu, Gõ IME'
)

console.log('\n=================================================================')
console.log(`🏁 KẾT QUẢ KIỂM THỬ: ${passed} PASSED / ${failed} FAILED`)
console.log('=================================================================')
if (failed > 0) {
  process.exit(1)
}
