// Các tiện ích chuẩn hóa văn bản, so khớp từng ký tự (Stateless Diffing),
// ánh xạ Unicode surrogate pair và đồng bộ TTS charIndex/charLength cho trang /typing.

export interface TypingErrorDetail {
  index: number
  expected: string
  actual: string
}

export type TypingCharStatus = 'correct' | 'incorrect' | 'active' | 'pending' | 'ignored'

export interface IndexedCharItem {
  char: string
  cpIdx: number
  utf16Start: number
  utf16End: number
}

export interface IndexedCharMap {
  text: string
  chars: string[]
  items: IndexedCharItem[]
  /** Chuyển vị trí UTF-16 (từ String index / Web Speech charIndex) sang code-point index */
  utf16ToCp: (utf16Index: number) => number
  /** Chuyển dải UTF-16 [start, start + length) sang dải code-point [startCp, endCp) */
  utf16RangeToCpRange: (utf16Start: number, utf16Length: number) => { startCp: number; endCp: number }
}

const CJK_CHAR_CLASS = '\\u4e00-\\u9fff\\u3400-\\u4dbf\\uf900-\\ufaff'
const CJK_CHAR_REGEX = new RegExp(`[${CJK_CHAR_CLASS}]`)
const CJK_FULLWIDTH_PUNCT = '，。！？；：、“”‘’（）【】《》、…·'

/**
 * Chuẩn hóa dấu câu tương đương toàn giác <-> bán giác
 */
export function normalizePunctuationChar(char: string): string {
  if (!char) return ''
  const punctuationMap: Record<string, string> = {
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
  }
  return punctuationMap[char] || char
}

/**
 * So khớp 2 ký tự đơn lẻ (hỗ trợ đối chiếu tương đương dấu câu khi bật normalizePunctuation)
 */
export function isTypingCharMatch(c1: string, c2: string, allowNormalize = true): boolean {
  if (!c1 || !c2) return false
  if (c1 === c2) return true
  if (allowNormalize) {
    return normalizePunctuationChar(c1) === normalizePunctuationChar(c2)
  }
  return false
}

/**
 * Hiển thị ký tự đặc biệt dễ hiểu trong bảng chi tiết lỗi
 */
export function formatDisplayChar(char: string): string {
  if (char === '\n') return '↵ (Xuống dòng)'
  if (char === ' ') return '␣ (Khoảng trắng)'
  return char
}

const HALFWIDTH_TO_FULLWIDTH_MAP: Record<string, string> = {
  ',': '，',
  '.': '。',
  '?': '？',
  '!': '！',
  ':': '：',
  ';': '；',
}

/**
 * 1. CHUẨN HÓA VĂN BẢN MẪU ĐẦU VÀO (SANITIZE TARGET TEXT)
 * - Loại bỏ ký tự ẩn zero-width, chuẩn hóa \r\n / \r -> \n
 * - Đổi tab/khoảng trắng đặc biệt thành khoảng trắng chuẩn, cắt khoảng trắng đầu/cuối từng dòng
 * - Gộp nhiều dòng trống liên tiếp thành 1 dấu ngắt đoạn '\n' hợp lệ (tránh ô trống/vạch đỏ thừa gây lệch index)
 * - Chuẩn hóa dấu câu half-width (, . ? ! : ;) gắn với ngữ cảnh tiếng Trung sang full-width (giữ nguyên số thập phân, giờ 09:00, email/URL và câu thuần Anh/Việt)
 * - Loại bỏ khoảng trắng thừa giữa các ký tự tiếng Trung và xung quanh dấu câu tiếng Trung (VD: "故事。 我们的" -> "故事。我们的")
 */
export function sanitizeTargetText(rawText: string): string {
  if (!rawText || typeof rawText !== 'string') return ''

  // 1. Xóa zero-width chars, chuẩn hóa xuống dòng và khoảng trắng ngang đặc biệt (tab, nbsp, full-width space)
  const text = rawText
    .replace(/[\u200B-\u200D\uFEFF]/g, '')
    .replace(/\r\n?/g, '\n')
    .replace(/[\t\u00A0\u3000\u2000-\u200A\u202F\u205F]/g, ' ')

  // 2. Xử lý từng dòng: trim đầu/cuối dòng, gộp khoảng trắng thừa, bỏ dòng trống thừa
  const rawLines = text
    .split('\n')
    .map((line) => line.replace(/[ ]{2,}/g, ' ').trim())
    .filter((line) => line.length > 0)

  const cleanedLines = rawLines.map((line) => {
    let cur = line

    // 3. Chuyển dấu câu cơ bản half-width -> full-width khi đi liền hoặc đứng ngay sau tiếng Trung
    // Dùng lookahead/kiểm tra an toàn để không phá vỡ "3.14", "09:00", "A203.", "pencils!", "..."
    const cjkOrClosing = `[${CJK_CHAR_CLASS}」』）》”’】、，。！？；：]`
    const afterCjkPunctRegex = new RegExp(`(${cjkOrClosing})([ ]*)([,.?!:;])`, 'g')
    cur = cur.replace(afterCjkPunctRegex, (full, prevCh: string, spaces: string, punct: string, offset: number, str: string) => {
      const nextCh = str[offset + full.length] || ''
      // Bảo vệ dấu chấm nếu là ellipsis "..." hoặc đứng trước chữ số (VD trường hợp hiếm)
      if (punct === '.' && (nextCh === '.' || /\d/.test(nextCh))) {
        return full
      }
      return `${prevCh}${spaces}${HALFWIDTH_TO_FULLWIDTH_MAP[punct] || punct}`
    })

    // Trường hợp đầu dòng hoặc sau khoảng trắng ngay trước chữ Hán bị gõ nhầm dấu câu ASCII (không kẹp giữa chữ Latin/số):
    // VD: "你好 ,我们的" hoặc "?我们的" -> "，我们的" / "？我们的"
    const beforeCjkPunctRegex = new RegExp(`(^|[ ]+)([,.?!:;])([ ]*)(?=[${CJK_CHAR_CLASS}])`, 'g')
    cur = cur.replace(beforeCjkPunctRegex, (full, lead: string, punct: string, trail: string, offset: number, str: string) => {
      const prevChar = offset > 0 ? str[offset - 1] : ''
      // Nếu đứng ngay sau chữ Latin/số (VD "HSK 4. 我"), giữ nguyên dấu chấm tiếng Việt/Anh
      if (!lead && /[A-Za-z0-9]/.test(prevChar)) {
        return full
      }
      if (punct === '.' && str[offset + (lead?.length || 0) + 1] === '.') {
        return full
      }
      return `${lead}${HALFWIDTH_TO_FULLWIDTH_MAP[punct] || punct}${trail}`
    })

    // 4. Loại bỏ toàn bộ khoảng trắng giữa hai ký tự tiếng Trung (lặp để xử lý chuỗi "你 好 吗" -> "你好吗")
    const betweenCjkRegex = new RegExp(`([${CJK_CHAR_CLASS}])[ ]+(?=[${CJK_CHAR_CLASS}])`, 'g')
    let prev = ''
    while (cur !== prev) {
      prev = cur
      cur = cur.replace(betweenCjkRegex, '$1')
    }

    // 5. Loại bỏ khoảng trắng đứng trước hoặc đứng sau dấu câu tiếng Trung full-width
    const spaceBeforePunct = new RegExp(`[ ]+([${CJK_FULLWIDTH_PUNCT}])`, 'g')
    const spaceAfterPunct = new RegExp(`([${CJK_FULLWIDTH_PUNCT}])[ ]+`, 'g')
    cur = cur.replace(spaceBeforePunct, '$1').replace(spaceAfterPunct, '$1')

    return cur.replace(/[ ]{2,}/g, ' ').trim()
  })

  return cleanedLines.filter((l) => l.length > 0).join('\n')
}

/**
 * Xây dựng mảng ký tự Unicode chuẩn xác bằng Array.from (tránh cắt đôi surrogate pairs)
 * kèm ánh xạ 2 chiều với UTF-16 offset cho Web Speech API onboundary & segmenter.
 */
export function buildIndexedChars(text: string): IndexedCharMap {
  const safeText = text || ''
  const chars = Array.from(safeText)
  const items: IndexedCharItem[] = new Array(chars.length)
  let utf16Cursor = 0

  for (let i = 0; i < chars.length; i++) {
    const ch = chars[i]
    const len = ch.length // 1 với BMP, 2 với surrogate pair
    items[i] = {
      char: ch,
      cpIdx: i,
      utf16Start: utf16Cursor,
      utf16End: utf16Cursor + len,
    }
    utf16Cursor += len
  }

  const utf16ToCp = (utf16Index: number): number => {
    if (items.length === 0 || utf16Index <= 0) return 0
    if (utf16Index >= safeText.length) return items.length
    // Binary search theo utf16Start / utf16End
    let lo = 0
    let hi = items.length - 1
    while (lo <= hi) {
      const mid = (lo + hi) >> 1
      const item = items[mid]
      if (utf16Index < item.utf16Start) {
        hi = mid - 1
      } else if (utf16Index >= item.utf16End) {
        lo = mid + 1
      } else {
        return mid
      }
    }
    return Math.min(lo, items.length)
  }

  const utf16RangeToCpRange = (utf16Start: number, utf16Length: number) => {
    const safeStart = Math.max(0, utf16Start)
    const safeLen = Math.max(1, utf16Length || 1)
    const startCp = Math.min(utf16ToCp(safeStart), Math.max(0, items.length - 1))
    const endCpRaw = utf16ToCp(safeStart + safeLen)
    const endCp = Math.max(startCp + 1, Math.min(items.length, endCpRaw))
    return { startCp, endCp }
  }

  return {
    text: safeText,
    chars,
    items,
    utf16ToCp,
    utf16RangeToCpRange,
  }
}

export interface StatelessTypingEvaluation {
  targetChars: string[]
  inputChars: string[]
  charStates: TypingCharStatus[]
  activeCharIndex: number
  correctCount: number
  errorCount: number
  extraCount: number
  missingCount: number
  totalTargetChars: number
  committedCharCount: number
  accuracy: number
  cpm: number
  errors: TypingErrorDetail[]
}

/**
 * 2. THUẬT TOÁN SO SÁNH TỪNG KÝ TỰ PHI TRẠNG THÁI (STATELESS CHARACTER-BY-CHARACTER DIFFING)
 * Luôn tính toán lại trực tiếp từ targetChars (Array.from) và inputChars (Array.from(committedInput)),
 * bảo đảm đồng nhất 100% giữa màu sắc UI và bộ đếm Đúng / Sai / Còn thiếu (kể cả khi Backspace).
 */
export function evaluateTypingStateless(
  cleanedTargetText: string,
  committedInput: string,
  options?: {
    elapsedSeconds?: number
    strictMode?: boolean
    normalizePunctuation?: boolean
    isCompleted?: boolean
  }
): StatelessTypingEvaluation {
  const targetChars = Array.from(cleanedTargetText || '')
  const inputChars = Array.from(committedInput || '')
  const strictMode = options?.strictMode ?? true
  const normalizePunctuation = options?.normalizePunctuation ?? true
  const elapsedSeconds = options?.elapsedSeconds ?? 0
  const isCompleted = options?.isCompleted ?? false

  if (targetChars.length === 0) {
    return {
      targetChars: [],
      inputChars,
      charStates: [],
      activeCharIndex: 0,
      correctCount: 0,
      errorCount: 0,
      extraCount: 0,
      missingCount: 0,
      totalTargetChars: 0,
      committedCharCount: inputChars.length,
      accuracy: 100,
      cpm: 0,
      errors: [],
    }
  }

  const charStates: TypingCharStatus[] = new Array(targetChars.length).fill('pending')
  const errors: TypingErrorDetail[] = []
  let correctCount = 0

  if (strictMode) {
    for (let i = 0; i < targetChars.length; i++) {
      if (i < inputChars.length) {
        if (isTypingCharMatch(inputChars[i], targetChars[i], normalizePunctuation)) {
          charStates[i] = 'correct'
          correctCount++
        } else {
          charStates[i] = 'incorrect'
          errors.push({
            index: i + 1,
            expected: formatDisplayChar(targetChars[i]),
            actual: formatDisplayChar(inputChars[i]),
          })
        }
      } else if (i === inputChars.length && !isCompleted) {
        charStates[i] = 'active'
      } else {
        charStates[i] = 'pending'
      }
    }

    let extraCount = 0
    if (inputChars.length > targetChars.length) {
      extraCount = inputChars.length - targetChars.length
      for (let i = targetChars.length; i < inputChars.length; i++) {
        errors.push({
          index: i + 1,
          expected: '(thừa)',
          actual: formatDisplayChar(inputChars[i]),
        })
      }
    }

    const errorCount = errors.length
    const missingCount = Math.max(0, targetChars.length - inputChars.length)
    const accuracy =
      inputChars.length > 0
        ? Math.max(0, Math.round((correctCount / Math.max(targetChars.length, inputChars.length)) * 100))
        : 100
    const minutes = Math.max(elapsedSeconds, 1) / 60
    const cpm = Math.round(correctCount / minutes)

    return {
      targetChars,
      inputChars,
      charStates,
      activeCharIndex: isCompleted ? -1 : inputChars.length,
      correctCount,
      errorCount,
      extraCount,
      missingCount,
      totalTargetChars: targetChars.length,
      committedCharCount: inputChars.length,
      accuracy,
      cpm,
      errors,
    }
  }

  // Chế độ "Nội dung" (strictMode = false): bỏ qua khoảng trắng / xuống dòng thừa nhưng vẫn đồng bộ 100% giữa stats & UI
  const isWhitespace = (ch: string) => /\s/.test(ch)
  const targetNonSpace: { char: string; cpIdx: number }[] = []
  for (let i = 0; i < targetChars.length; i++) {
    if (isWhitespace(targetChars[i])) {
      charStates[i] = 'ignored'
    } else {
      targetNonSpace.push({ char: targetChars[i], cpIdx: i })
    }
  }

  const inputNonSpace: { char: string; cpIdx: number }[] = []
  for (let i = 0; i < inputChars.length; i++) {
    if (!isWhitespace(inputChars[i])) {
      inputNonSpace.push({ char: inputChars[i], cpIdx: i })
    }
  }

  let activeCharIndex = -1
  for (let i = 0; i < targetNonSpace.length; i++) {
    const t = targetNonSpace[i]
    if (i < inputNonSpace.length) {
      const inp = inputNonSpace[i]
      if (isTypingCharMatch(inp.char, t.char, normalizePunctuation)) {
        charStates[t.cpIdx] = 'correct'
        correctCount++
      } else {
        charStates[t.cpIdx] = 'incorrect'
        errors.push({
          index: inp.cpIdx + 1,
          expected: formatDisplayChar(t.char),
          actual: formatDisplayChar(inp.char),
        })
      }
    } else if (i === inputNonSpace.length && !isCompleted) {
      charStates[t.cpIdx] = 'active'
      activeCharIndex = t.cpIdx
    } else {
      charStates[t.cpIdx] = 'pending'
    }
  }

  let extraCount = 0
  if (inputNonSpace.length > targetNonSpace.length) {
    extraCount = inputNonSpace.length - targetNonSpace.length
    for (let i = targetNonSpace.length; i < inputNonSpace.length; i++) {
      errors.push({
        index: inputNonSpace[i].cpIdx + 1,
        expected: '(thừa)',
        actual: formatDisplayChar(inputNonSpace[i].char),
      })
    }
  }

  const errorCount = errors.length
  const missingCount = Math.max(0, targetNonSpace.length - inputNonSpace.length)
  const accuracy =
    inputNonSpace.length > 0
      ? Math.max(0, Math.round((correctCount / Math.max(targetNonSpace.length, inputNonSpace.length)) * 100))
      : 100
  const minutes = Math.max(elapsedSeconds, 1) / 60
  const cpm = Math.round(correctCount / minutes)

  return {
    targetChars,
    inputChars,
    charStates,
    activeCharIndex,
    correctCount,
    errorCount,
    extraCount,
    missingCount,
    totalTargetChars: targetNonSpace.length,
    committedCharCount: inputNonSpace.length,
    accuracy,
    cpm,
    errors,
  }
}

export function hasCjkCharacter(text: string): boolean {
  return CJK_CHAR_REGEX.test(text || '')
}
