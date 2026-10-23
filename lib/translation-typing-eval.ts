// Module thuật toán chuẩn hóa và so khớp bản dịch cho chế độ "Dịch Việt → Gõ Hán"
// Thiết kế không dùng AI trả phí, tuân thủ nguyên tắc nhân văn:
// Không dán nhãn "Sai", mà phân biệt "Trùng khớp câu mẫu" vs "Khác câu mẫu — cần xem lại".

/**
 * Chuẩn hóa dấu câu tiếng Trung & tiếng Anh tương đương
 */
export function normalizePunctuation(char: string): string {
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
    '…': '...',
  }
  return punctuationMap[char] || char
}

/**
 * Chuẩn hóa câu để so khớp:
 * 1. Đổi dấu câu toàn giác sang bán giác
 * 2. Loại bỏ khoảng trắng giữa các chữ Hán
 * 3. Chuyển chữ thường (nếu có ký tự Latinh hoặc dấu câu)
 */
export function normalizeChineseSentence(text: string): string {
  if (!text) return ''
  let res = ''
  for (let i = 0; i < text.length; i++) {
    const ch = text[i]
    // Bỏ khoảng trắng
    if (/\s/.test(ch)) continue
    res += normalizePunctuation(ch)
  }
  return res.trim().toLowerCase()
}

export type DiffTokenType = 'match' | 'diff' | 'missing' | 'extra'

export interface DiffToken {
  type: DiffTokenType
  userInputChar?: string
  expectedChar?: string
  index: number
}

export interface TranslationEvaluationResult {
  isExactMatch: boolean
  matchPercentage: number
  diffTokens: DiffToken[]
  differingCharsCount: number
  matchingCharsCount: number
  status: 'exact_match' | 'needs_review'
}

/**
 * Đánh giá bản dịch:
 * - So sánh chuỗi đã chuẩn hóa
 * - Tính toán Diff chi tiết theo từng vị trí ký tự
 */
export function evaluateTranslationInput(
  userInput: string,
  sampleAnswer: string
): TranslationEvaluationResult {
  const normUser = normalizeChineseSentence(userInput)
  const normSample = normalizeChineseSentence(sampleAnswer)

  const isExactMatch = normUser === normSample && normSample.length > 0

  const userChars = Array.from(userInput.trim())
  const sampleChars = Array.from(sampleAnswer.trim())

  const maxLen = Math.max(userChars.length, sampleChars.length)
  const diffTokens: DiffToken[] = []
  let matchCount = 0
  let diffCount = 0

  for (let i = 0; i < maxLen; i++) {
    const u = userChars[i]
    const s = sampleChars[i]

    if (u && s) {
      const isCharEqual =
        u === s || normalizePunctuation(u) === normalizePunctuation(s)
      if (isCharEqual) {
        matchCount++
        diffTokens.push({
          type: 'match',
          userInputChar: u,
          expectedChar: s,
          index: i,
        })
      } else {
        diffCount++
        diffTokens.push({
          type: 'diff',
          userInputChar: u,
          expectedChar: s,
          index: i,
        })
      }
    } else if (u && !s) {
      diffCount++
      diffTokens.push({
        type: 'extra',
        userInputChar: u,
        index: i,
      })
    } else if (!u && s) {
      diffCount++
      diffTokens.push({
        type: 'missing',
        expectedChar: s,
        index: i,
      })
    }
  }

  const totalChars = Math.max(sampleChars.length, userChars.length, 1)
  const matchPercentage = Math.round((matchCount / totalChars) * 100)

  return {
    isExactMatch,
    matchPercentage,
    diffTokens,
    differingCharsCount: diffCount,
    matchingCharsCount: matchCount,
    status: isExactMatch ? 'exact_match' : 'needs_review',
  }
}
