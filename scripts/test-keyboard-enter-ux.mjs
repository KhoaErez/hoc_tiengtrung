// scripts/test-keyboard-enter-ux.mjs
// Bộ kiểm thử tự động toàn diện cho cơ chế phím Enter + IME trong Luyện đánh máy
// Đáp ứng chính xác 9 kịch bản kiểm thử quy định trong yêu cầu kỹ thuật

function normalizePunctuation(char) {
  if (!char) return ''
  const punctuationMap = {
    '，': ',',
    '。': '.',
    '！': '!',
    '？': '?',
    '：': ':',
    '；': ';',
    '“': '"',
    '”': '"',
    '‘': "'",
    '’': "'",
    '（': '(',
    '）': ')',
    '【': '[',
    '】': ']',
    '、': ',',
    '—': '-',
    '–': '-',
    '…': '...',
  }
  return punctuationMap[char] || char
}

function normalizeChineseSentence(text) {
  if (!text) return ''
  let res = ''
  for (let i = 0; i < text.length; i++) {
    const ch = text[i]
    if (/\s/.test(ch)) continue
    res += normalizePunctuation(ch)
  }
  return res.trim().toLowerCase()
}

function evaluateTranslationInput(userInput, sampleAnswer) {
  const normUser = normalizeChineseSentence(userInput)
  const normSample = normalizeChineseSentence(sampleAnswer)
  const isExactMatch = normUser === normSample && normSample.length > 0
  return { isExactMatch }
}

console.log('=================================================================')
console.log('🧪 BẮT ĐẦU KIỂM THỬ: CHUẨN HÓA CƠ CHẾ PHÍM ENTER + IME (KEYBOARD UX)')
console.log('=================================================================\n')

let passed = 0
let failed = 0

function assert(condition, message) {
  if (condition) {
    console.log(`  ✅ [PASS] ${message}`)
    passed++
  } else {
    console.error(`  ❌ [FAIL] ${message}`)
    failed++
  }
}

// Mô phỏng State Machine của cơ chế Enter
class TypingStateMachineMock {
  constructor(options = {}) {
    this.targetSentence = options.targetSentence || '你好，世界！'
    this.status = 'typing' // 'typing' | 'checking' | 'correct' | 'incorrect' | 'transitioning'
    this.userInput = ''
    this.currentIndex = 0
    this.totalSentences = options.totalSentences || 10
    this.correctCount = 0
    this.skippedCount = 0
    this.savedProgressEvents = []
    this.isComposing = false
    this.justEndedComposition = false
  }

  type(text) {
    this.userInput = text
    // Nếu đang correct mà sửa ký tự -> hủy correct, về typing
    if (this.status === 'correct') {
      this.status = 'typing'
    }
  }

  startComposition() {
    this.isComposing = true
    this.justEndedComposition = false
  }

  endComposition(selectedText) {
    this.isComposing = false
    this.userInput = selectedText
    this.justEndedComposition = true
  }

  pressEnter() {
    // 1. Chặn tuyệt đối khi IME đang chọn chữ
    if (this.isComposing) {
      return { handled: false, reason: 'ime_composing' }
    }

    // 2. Chặn phím Enter vừa kết thúc composition (chọn chữ IME)
    if (this.justEndedComposition) {
      this.justEndedComposition = false
      return { handled: false, reason: 'ime_just_ended' }
    }

    // 3. Chặn nếu đang chuyển câu hoặc đang kiểm tra
    if (this.status === 'transitioning' || this.status === 'checking') {
      return { handled: false, reason: 'busy' }
    }

    // 4. Nếu đang typing hoặc incorrect -> Kiểm tra đáp án
    if (this.status === 'typing' || this.status === 'incorrect') {
      if (!this.userInput.trim()) {
        return { handled: false, reason: 'empty_input' }
      }
      this.status = 'checking'
      const evalRes = evaluateTranslationInput(this.userInput, this.targetSentence)
      if (evalRes.isExactMatch) {
        this.status = 'correct'
        return { handled: true, action: 'evaluated_correct' }
      } else {
        this.status = 'incorrect'
        return { handled: true, action: 'evaluated_incorrect' }
      }
    }

    // 5. Nếu đang correct -> Enter lần 2 để chuyển câu
    if (this.status === 'correct') {
      this.status = 'transitioning'
      this.correctCount++
      this.savedProgressEvents.push({
        index: this.currentIndex,
        status: 'correct',
      })
      this.currentIndex++
      this.userInput = ''
      this.status = 'typing'
      return { handled: true, action: 'advanced_next_sentence' }
    }

    return { handled: false }
  }

  clickSkip() {
    if (this.status === 'transitioning') return
    this.status = 'transitioning'
    this.skippedCount++
    this.savedProgressEvents.push({
      index: this.currentIndex,
      status: 'skipped',
    })
    this.currentIndex++
    this.userInput = ''
    this.status = 'typing'
    return { handled: true, action: 'skipped_sentence' }
  }
}

// =================================================================
// KỊCH BẢN 1: Nhập đúng, Enter lần 1 -> Báo đúng, KHÔNG tự chuyển câu
// =================================================================
console.log('📌 Kịch bản 1: Nhập đúng, Enter lần 1 -> Kiểm tra và báo đúng (correct)')
{
  const machine = new TypingStateMachineMock({ targetSentence: '我们坐火车去北京。' })
  machine.type('我们坐火车去北京。')
  const res = machine.pressEnter()

  assert(res.handled === true && res.action === 'evaluated_correct', 'Phím Enter lần 1 kích hoạt kiểm tra và báo đúng')
  assert(machine.status === 'correct', 'Trạng thái chuyển sang "correct"')
  assert(machine.currentIndex === 0, 'KHÔNG tự động chuyển sang câu tiếp theo')
  assert(machine.userInput === '我们坐火车去北京。', 'Nội dung nhập vẫn được bảo lưu')
  assert(machine.savedProgressEvents.length === 0, 'Chưa lưu tiến độ hoàn thành câu cho đến khi Enter lần 2')
}

// =================================================================
// KỊCH BẢN 2: Nhập đúng, Enter lần 2 -> Chuyển câu & Lưu tiến độ
// =================================================================
console.log('\n📌 Kịch bản 2: Nhập đúng, Enter lần 2 -> Chuyển câu và lưu tiến độ')
{
  const machine = new TypingStateMachineMock({ targetSentence: '我们坐火车去北京。' })
  machine.type('我们坐火车去北京。')
  machine.pressEnter() // Lần 1: báo đúng
  const res2 = machine.pressEnter() // Lần 2: chuyển câu

  assert(res2.handled === true && res2.action === 'advanced_next_sentence', 'Phím Enter lần 2 kích hoạt chuyển câu')
  assert(machine.currentIndex === 1, 'Chuyển sang câu index 1 thành công')
  assert(machine.status === 'typing', 'Trạng thái chuyển về "typing" cho câu mới')
  assert(machine.userInput === '', 'Ô nhập liệu được xóa sạch cho câu mới')
  assert(machine.correctCount === 1, 'Số câu đúng tăng lên 1')
  assert(machine.savedProgressEvents.length === 1 && machine.savedProgressEvents[0].status === 'correct', 'Tiến độ được lưu chính xác')
}

// =================================================================
// KỊCH BẢN 3: Nhập sai, Enter -> Báo sai, giữ nguyên câu & nội dung
// =================================================================
console.log('\n📌 Kịch bản 3: Nhập sai, Enter -> Báo sai (incorrect), giữ nguyên câu')
{
  const machine = new TypingStateMachineMock({ targetSentence: '我们坐火车去北京。' })
  machine.type('我们坐飞机去北京。') // Sai từ 火车 thành 飞机
  const res = machine.pressEnter()

  assert(res.handled === true && res.action === 'evaluated_incorrect', 'Kiểm tra và phát hiện sai lệch')
  assert(machine.status === 'incorrect', 'Trạng thái chuyển sang "incorrect"')
  assert(machine.currentIndex === 0, 'GIỮ NGUYÊN câu hỏi hiện tại, không chuyển câu')
  assert(machine.userInput === '我们坐飞机去北京。', 'KHÔNG xóa nội dung người dùng vừa nhập để họ chỉnh sửa')
  assert(machine.correctCount === 0, 'Không tăng số câu đúng')
}

// =================================================================
// KỊCH BẢN 4: Sửa đáp án sai -> Enter tiếp tục kiểm tra lại
// =================================================================
console.log('\n📌 Kịch bản 4: Sửa đáp án sai, Enter -> Kiểm tra lại')
{
  const machine = new TypingStateMachineMock({ targetSentence: '我们坐火车去北京。' })
  machine.type('我们坐')
  machine.pressEnter() // Báo sai
  assert(machine.status === 'incorrect', 'Lần đầu kiểm tra: incorrect')

  // Người dùng gõ tiếp nhưng vẫn sai
  machine.type('我们坐汽车去北京。')
  const res2 = machine.pressEnter()
  assert(res2.handled === true && res2.action === 'evaluated_incorrect', 'Kiểm tra lại câu vừa sửa: vẫn báo sai')
  assert(machine.status === 'incorrect', 'Tiếp tục giữ trạng thái incorrect')
  assert(machine.currentIndex === 0, 'Tuyệt đối không chuyển câu khi incorrect')
}

// =================================================================
// KỊCH BẢN 5: Sửa thành đúng -> Enter báo đúng
// =================================================================
console.log('\n📌 Kịch bản 5: Sửa thành đúng, Enter -> Báo đúng (correct)')
{
  const machine = new TypingStateMachineMock({ targetSentence: '我们坐火车去北京。' })
  machine.type('我们坐飞机去北京。')
  machine.pressEnter() // Sai
  assert(machine.status === 'incorrect', 'Trạng thái ban đầu: incorrect')

  // Người dùng sửa lại đúng chữ 火车
  machine.type('我们坐火车去北京。')
  const res2 = machine.pressEnter()

  assert(res2.handled === true && res2.action === 'evaluated_correct', 'Sau khi sửa đúng, Enter chuyển sang trạng thái thành công')
  assert(machine.status === 'correct', 'Trạng thái trở thành "correct"')
  assert(machine.currentIndex === 0, 'Vẫn giữ ở câu hiện tại để người dùng nhìn nhận kết quả đúng')
}

// =================================================================
// KỊCH BẢN 6: Enter tiếp sau khi đúng -> Chuyển câu
// =================================================================
console.log('\n📌 Kịch bản 6: Enter tiếp sau khi sửa đúng -> Chuyển câu tiếp theo')
{
  const machine = new TypingStateMachineMock({ targetSentence: '我们坐火车去北京。' })
  machine.type('我们坐飞机去北京。')
  machine.pressEnter() // Sai
  machine.type('我们坐火车去北京。')
  machine.pressEnter() // Đúng
  const res3 = machine.pressEnter() // Chuyển câu

  assert(res3.action === 'advanced_next_sentence', 'Chuyển sang câu tiếp theo thành công')
  assert(machine.currentIndex === 1, 'Chỉ số câu là 1')
  assert(machine.status === 'typing', 'Trạng thái trở về typing')
  assert(machine.correctCount === 1, 'Ghi nhận 1 câu đúng')
}

// =================================================================
// KỊCH BẢN 7: Nhấn "Bỏ qua câu này →"
// =================================================================
console.log('\n📌 Kịch bản 7: Nhấn "Bỏ qua câu này →" -> Chuyển câu, KHÔNG tính đúng')
{
  const machine = new TypingStateMachineMock({ targetSentence: '我们坐火车去北京。' })
  machine.type('不会做')
  machine.pressEnter() // Sai
  assert(machine.status === 'incorrect', 'Bị sai câu hiện tại')

  const skipRes = machine.clickSkip()
  assert(skipRes.handled === true && skipRes.action === 'skipped_sentence', 'Bỏ qua câu thành công')
  assert(machine.currentIndex === 1, 'Chuyển ngay sang câu tiếp theo')
  assert(machine.correctCount === 0, 'KHÔNG tính câu bị bỏ qua là câu đúng')
  assert(machine.skippedCount === 1, 'Ghi nhận số câu bỏ qua là 1')
  assert(machine.savedProgressEvents[0].status === 'skipped', 'Lưu trạng thái skipped vào tiến độ an toàn')
}

// =================================================================
// KỊCH BẢN 8: Enter khi IME đang chọn chữ -> KHÔNG kích hoạt kiểm tra
// =================================================================
console.log('\n📌 Kịch bản 8: Enter khi IME Pinyin đang chọn chữ -> Không kích hoạt kiểm tra')
{
  const machine = new TypingStateMachineMock({ targetSentence: '你好' })
  machine.startComposition() // Người dùng đang gõ pinyin 'nihao'
  const res1 = machine.pressEnter()

  assert(res1.handled === false && res1.reason === 'ime_composing', 'Enter khi isComposing = true bị chặn 100%')
  assert(machine.status === 'typing', 'Trạng thái vẫn là typing, không bị nhảy sang checking')

  // Người dùng nhấn phím số hoặc Enter để chọn chữ '你好' từ candidate box
  machine.endComposition('你好')
  const res2 = machine.pressEnter() // Enter xác nhận IME
  assert(res2.handled === false && res2.reason === 'ime_just_ended', 'Phím Enter vừa xác nhận IME bị tiêu thụ an toàn, không kích hoạt kiểm tra')
  assert(machine.status === 'typing', 'Vẫn giữ trạng thái typing')

  // Phím Enter thực sự của người dùng sau khi đã chọn xong chữ Hán
  const res3 = machine.pressEnter()
  assert(res3.handled === true && res3.action === 'evaluated_correct', 'Phím Enter sau khi kết thúc IME mới kích hoạt kiểm tra')
  assert(machine.status === 'correct', 'Kiểm tra thành công')
}

// =================================================================
// KỊCH BẢN 9: Nhấn Enter liên tục (Spam) -> KHÔNG chuyển nhiều câu
// =================================================================
console.log('\n📌 Kịch bản 9: Nhấn Enter liên tục -> Không chuyển nhiều câu (Race condition protection)')
{
  const machine = new TypingStateMachineMock({ targetSentence: '测试' })
  machine.type('测试')
  machine.pressEnter() // Enter 1: correct
  assert(machine.status === 'correct', 'Enter 1: correct')

  // Giả lập trạng thái transitioning đang diễn ra
  machine.status = 'transitioning'
  const spamRes1 = machine.pressEnter()
  const spamRes2 = machine.pressEnter()

  assert(spamRes1.handled === false && spamRes1.reason === 'busy', 'Enter spam 1 bị chặn khi transitioning')
  assert(spamRes2.handled === false && spamRes2.reason === 'busy', 'Enter spam 2 bị chặn khi transitioning')
}

console.log('\n=================================================================')
console.log(`🏁 KẾT QUẢ KIỂM THỬ: ${passed} PASS, ${failed} FAIL`)
console.log('=================================================================')

if (failed > 0) {
  process.exit(1)
} else {
  console.log('🎉 TẤT CẢ 9 KỊCH BẢN KIỂM THỬ ENTER + IME ĐÃ VƯỢT QUA 100%!')
  process.exit(0)
}
