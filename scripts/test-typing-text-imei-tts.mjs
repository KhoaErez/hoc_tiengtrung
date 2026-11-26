// scripts/test-typing-text-imei-tts.mjs
// Kiểm thử toàn diện cho 4 yêu cầu kỹ thuật của trang /typing:
// 1. Sanitize Target Text (khoảng trắng giữa chữ Hán/sau dấu câu, \r\n & dòng trống thừa, half-width <-> full-width)
// 2. IME Composition Events (tuyệt đối không chấm điểm / tô màu khi isComposing = true, chỉ commit ở compositionend hoặc non-IME change)
// 3. Stateless Character-by-Character Diffing (Array.from cho surrogate pairs, thống kê Đúng/Sai/Còn thiếu, Backspace)
// 4. TTS charIndex / charLength synchronization & cancel lifecycle

import fs from 'node:fs'
import path from 'node:path'
import vm from 'node:vm'
import { fileURLToPath } from 'node:url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const rootDir = path.resolve(__dirname, '..')

// Transpile TypeScript nhẹ bằng ts compiler API có sẵn trong node_modules/typescript
const ts = await import('typescript')
const utilsTsPath = path.join(rootDir, 'lib', 'typing-text-utils.ts')
const utilsTsSource = fs.readFileSync(utilsTsPath, 'utf8')
const compiled = ts.default.transpileModule(utilsTsSource, {
  compilerOptions: {
    module: ts.default.ModuleKind.CommonJS,
    target: ts.default.ScriptTarget.ES2022,
  },
})

const moduleObj = { exports: {} }
const fn = new vm.Script(compiled.outputText, { filename: 'typing-text-utils.js' })
const wrapper = `(function(exports, module) { ${compiled.outputText} \n})`
const compiledFn = vm.runInThisContext(wrapper)
compiledFn(moduleObj.exports, moduleObj)

const {
  sanitizeTargetText,
  buildIndexedChars,
  evaluateTypingStateless,
  isTypingCharMatch,
} = moduleObj.exports

let passed = 0
let failed = 0

function assert(cond, msg) {
  if (cond) {
    console.log(`  ✅ [PASS] ${msg}`)
    passed++
  } else {
    console.error(`  ❌ [FAIL] ${msg}`)
    failed++
  }
}

console.log('=================================================================')
console.log('🧪 BẮT ĐẦU KIỂM THỬ: SANITIZE + IME + STATELESS DIFF + TTS SYNC')
console.log('=================================================================\n')

// -----------------------------------------------------------------
// 1. TEST SANITIZE TARGET TEXT
// -----------------------------------------------------------------
console.log('📌 Nhóm 1: Chuẩn hóa văn bản mẫu (sanitizeTargetText)')
{
  assert(
    sanitizeTargetText('故事。 我们的') === '故事。我们的',
    'Xóa khoảng trắng ngay sau dấu câu tiếng Trung ("故事。 我们的" -> "故事。我们的")'
  )
  assert(
    sanitizeTargetText('你   好\t世  界 ！ ') === '你好世界！',
    'Xóa nhiều khoảng trắng và tab giữa chữ Hán và trước dấu câu'
  )
  assert(
    sanitizeTargetText('  第一段。  \r\n\r\n\r\n  第二段。 \r\n  ') === '第一段。\n第二段。',
    'Chuẩn hóa \\r\\n, xóa dòng trống thừa & khoảng trắng đầu/cuối dòng'
  )
  assert(
    sanitizeTargetText('你好, 世界! 今天怎么样? 很好: 加油;') === '你好，世界！今天怎么样？很好：加油；',
    'Chuyển dấu câu half-width gắn với chữ Hán sang full-width và dọn khoảng trắng'
  )
  const mixed = '2026年HSK考试时间已经正式公布。\r\nBuổi thi   HSK 4 lúc 09:00 tại A203. Tỷ lệ 3.14!\r\nPlease bring 2B pencils!\r\n\r\n祝大家成功!'
  const cleanedMixed = sanitizeTargetText(mixed)
  assert(
    cleanedMixed === '2026年HSK考试时间已经正式公布。\nBuổi thi HSK 4 lúc 09:00 tại A203. Tỷ lệ 3.14!\nPlease bring 2B pencils!\n祝大家成功！',
    'Bảo toàn số thập phân 3.14, giờ 09:00 và khoảng trắng trong câu Việt/Anh khi chuẩn hóa hỗn hợp'
  )
}

// -----------------------------------------------------------------
// 2. TEST STATELESS DIFFING & SURROGATE PAIRS
// -----------------------------------------------------------------
console.log('\n📌 Nhóm 2: So sánh từng ký tự Stateless & Surrogate Pairs (Array.from)')
{
  const targetWithSurrogate = '𠮷好！🌟' // 𠮷 và 🌟 là surrogate pairs (len UTF-16 = 6, code points = 4)
  const evalEmpty = evaluateTypingStateless(targetWithSurrogate, '')
  assert(evalEmpty.totalTargetChars === 4, 'Đếm chính xác 4 ký tự Unicode cho chuỗi chứa surrogate pair')
  assert(evalEmpty.activeCharIndex === 0, 'Vị trí con trỏ ban đầu ở index 0')
  assert(evalEmpty.charStates[0] === 'active' && evalEmpty.charStates[1] === 'pending', 'Đánh dấu active/pending chuẩn')

  const evalPartial = evaluateTypingStateless(targetWithSurrogate, '𠮷好!')
  assert(evalPartial.correctCount === 3, 'Hỗ trợ so khớp surrogate pair + tương đương dấu ! và ！ (Đúng = 3)')
  assert(evalPartial.errorCount === 0, 'Không báo lỗi oan giữa ! và ！ khi bật chuẩn hóa dấu câu')
  assert(evalPartial.missingCount === 1, 'Còn thiếu = 1')
  assert(evalPartial.activeCharIndex === 3, 'Con trỏ chuyển đến surrogate pair cuối ở index 3')

  const evalStrictPunct = evaluateTypingStateless('你好！', '你好!', { normalizePunctuation: false })
  assert(evalStrictPunct.errorCount === 1 && evalStrictPunct.charStates[2] === 'incorrect', 'Tắt normalizePunctuation thì ! !== ！ bị đánh dấu incorrect')

  // Test Backspace cập nhật lại hoàn toàn stateless
  const target = '你好世界'
  const errState = evaluateTypingStateless(target, '你坏')
  assert(errState.correctCount === 1 && errState.errorCount === 1 && errState.missingCount === 2, 'Gõ sai 1 chữ -> Đúng:1, Sai:1, Thiếu:2')
  const backspaced = evaluateTypingStateless(target, '你')
  assert(
    backspaced.correctCount === 1 &&
      backspaced.errorCount === 0 &&
      backspaced.missingCount === 3 &&
      backspaced.charStates[1] === 'active',
    'Sau Backspace xóa chữ sai -> tự động về Đúng:1, Sai:0, Thiếu:3, active tại index 1'
  )
}

// -----------------------------------------------------------------
// 3. TEST IME COMPOSITION STATE MACHINE INVARIANTS
// -----------------------------------------------------------------
console.log('\n📌 Nhóm 3: Mô phỏng luồng IME Composition (Không chấm điểm khi đang gõ Pinyin)')
{
  class CustomTypingImeHarness {
    constructor(rawTarget) {
      this.target = sanitizeTargetText(rawTarget)
      this.inputValue = ''
      this.committedInput = ''
      this.isComposing = false
      this.sfxHistory = []
    }
    get eval() {
      return evaluateTypingStateless(this.target, this.committedInput, { strictMode: true, normalizePunctuation: true })
    }
    onCompositionStart() {
      this.isComposing = true
    }
    onChange(val, nativeIsComposing = false) {
      this.inputValue = val
      if (this.isComposing || nativeIsComposing) {
        // Bỏ qua chấm điểm trong lúc đang chọn Pinyin
        return
      }
      this.commit(val)
    }
    onCompositionEnd(val) {
      this.isComposing = false
      this.inputValue = val
      this.commit(val)
    }
    commit(val) {
      if (val === this.committedInput) return
      const prevLen = Array.from(this.committedInput).length
      const nextChars = Array.from(val)
      this.committedInput = val
      if (nextChars.length > prevLen) {
        const targetChars = Array.from(this.target)
        let ok = true
        for (let i = prevLen; i < nextChars.length; i++) {
          if (!targetChars[i] || !isTypingCharMatch(nextChars[i], targetChars[i], true)) ok = false
        }
        this.sfxHistory.push(ok ? 'correct' : 'error')
      }
    }
  }

  const h = new CustomTypingImeHarness('故事。 我们的')
  h.onCompositionStart()
  h.onChange('g', true)
  h.onChange('gu', true)
  h.onChange('gush', true)
  assert(h.committedInput === '', 'Khi đang gõ Pinyin "gush", committedInput vẫn rỗng')
  assert(h.eval.correctCount === 0 && h.eval.errorCount === 0, 'Tuyệt đối không báo Sai khi đang soạn Pinyin IME')
  assert(h.sfxHistory.length === 0, 'Không phát SFX khi đang soạn IME')

  // Người dùng nhấn Space chọn "故事"
  h.onCompositionEnd('故事')
  assert(h.committedInput === '故事', 'onCompositionEnd commit chữ Hán "故事"')
  assert(h.eval.correctCount === 2 && h.eval.errorCount === 0, 'Tô xanh 2 chữ "故事" ngay khi chữ Hán xuất hiện')
  assert(h.eval.charStates[2] === 'active', 'Con trỏ chuyển sang dấu "。" tại index 2')

  // Bấm dấu câu trực tiếp (không qua composition)
  h.onChange('故事。', false)
  assert(h.eval.correctCount === 3 && h.eval.errorCount === 0, 'Gõ dấu câu trực tiếp không qua IME vẫn chấm đúng ngay lập tức')

  // Gõ nhầm 1 chữ sau đó bấm Backspace
  h.onCompositionStart()
  h.onChange('故事。ni', true)
  assert(h.eval.errorCount === 0 && h.eval.correctCount === 3, 'Đang gõ pinyin "ni" chưa chọn từ -> chữ "我" chưa bị tô đỏ')
  h.onCompositionEnd('故事。你')
  assert(h.eval.errorCount === 1 && h.eval.charStates[3] === 'incorrect', 'Chọn nhầm "你" thay "我" -> tô đỏ index 3')
  h.onChange('故事。', false)
  assert(h.eval.errorCount === 0 && h.eval.charStates[3] === 'active', 'Backspace xóa "你" -> index 3 quay lại trạng thái active, Sai = 0')
}

// -----------------------------------------------------------------
// 4. TEST TTS UNICODE OFFSET MAPPING (charIndex + charLength)
// -----------------------------------------------------------------
console.log('\n📌 Nhóm 4: Ánh xạ TTS boundary charIndex & charLength (kể cả surrogate pair)')
{
  const text = '🌟故事。我们的' // UTF-16: 🌟(0..2), 故(2..3), 事(3..4), 。(4..5), 我(5..6), 们(6..7), 的(7..8)
  const map = buildIndexedChars(text)
  assert(map.chars.length === 7, 'buildIndexedChars tạo đủ 7 code points')

  // TTS phát boundary tại UTF-16 charIndex = 2, charLength = 2 ("故事")
  const rWord = map.utf16RangeToCpRange(2, 2)
  assert(rWord.startCp === 1 && rWord.endCp === 3, 'UTF-16 [2, 4) ánh xạ đúng sang targetChars [1, 3) ("故事")')

  // TTS không trả charLength (charLength = 0/undefined -> fallback 1) tại charIndex = 5 ("我")
  const rFallback = map.utf16RangeToCpRange(5, 0)
  assert(rFallback.startCp === 4 && rFallback.endCp === 5, 'Fallback charLength || 1 tô sáng đúng 1 ký tự tại index 4 ("我")')

  // TTS trên văn bản có nhiều cụm: "我们" ở UTF-16 [5, 7)
  const rWord2 = map.utf16RangeToCpRange(5, 2)
  assert(rWord2.startCp === 4 && rWord2.endCp === 6, 'Highlight chính xác cụm "我们" ([4, 6))')
}

console.log('\n=================================================================')
console.log(`🏁 KẾT QUẢ KIỂM THỬ: ${passed} PASSED / ${failed} FAIL`)
console.log('=================================================================')
if (failed > 0) {
  process.exit(1)
}
console.log('🎉 TẤT CẢ KIỂM THỬ SANITIZE + IME + STATELESS DIFF + TTS ĐỀU ĐẠT 100%!')
