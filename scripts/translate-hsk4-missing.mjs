import fs from 'fs'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const posMap = {
  'n.': 'Danh từ',
  'v.': 'Động từ',
  'adj.': 'Tính từ',
  'adv.': 'Phó từ',
  'prep.': 'Giới từ',
  'conj.': 'Liên từ',
  'pron.': 'Đại từ',
  'num.': 'Số từ',
  'mw.': 'Lượng từ',
  'm.': 'Lượng từ',
  'interj.': 'Thán từ',
  'part.': 'Trợ từ',
  'aux.': 'Trợ từ',
  'phr.': 'Cụm từ',
  'suffix': 'Hậu tố',
  'prefix': 'Tiền tố',
  'num.-mw.': 'Số lượng từ'
}

function posToVietnamese(pos) {
  if (!pos) return 'Từ vựng'
  const parts = pos.split('/').map(p => p.trim())
  const viParts = parts.map(p => posMap[p] || p)
  return Array.from(new Set(viParts)).join(' / ')
}

async function main() {
  console.log('=== DỊCH VÀ CHUẨN HÓA NGHĨA TIẾNG VIỆT CHO 480 TỪ HSK 4 CÒN THIẾU ===\n')

  const missingWords = JSON.parse(fs.readFileSync('scratch/hsk4_missing_words.json', 'utf8'))
  console.log(`Tổng số từ cần dịch: ${missingWords.length}`)

  const chunkSize = 40
  const chunks = []
  for (let i = 0; i < missingWords.length; i += chunkSize) {
    chunks.push(missingWords.slice(i, i + chunkSize))
  }

  const translatedWords = []

  for (let cIdx = 0; cIdx < chunks.length; cIdx++) {
    const chunk = chunks[cIdx]
    console.log(`Đang dịch Chunk ${cIdx + 1}/${chunks.length} (${chunk.length} từ: [${chunk[0].hanzi}] -> [${chunk[chunk.length - 1].hanzi}])...`)

    const prompt = `Bạn là chuyên gia từ điển Hán - Việt giảng dạy HSK 3.0. Dưới đây là danh sách từ vựng HSK 4 (kèm Pinyin, Loại từ tiếng Anh, Nghĩa tiếng Anh).
Hãy cung cấp nghĩa tiếng Việt chính xác, súc tích, tự nhiên nhất cho người Việt học tiếng Trung.
Trả về DUY NHẤT một mảng JSON các object, không có markdown formatting hay giải thích gì thêm:
[
  {"id": 1001, "hanzi": "啊", "pinyin": "ā", "word_type": "Thán từ", "meaning_vi": "a, chao ôi (thán từ cảm thán)"}
]

Danh sách từ:
${JSON.stringify(chunk.map(w => ({
  id: w.id,
  hanzi: w.hanzi,
  pinyin: w.pinyin,
  pos: w.pos,
  word_type: posToVietnamese(w.pos),
  meaning_en: w.meaning_en
})), null, 2)}`

    let success = false
    let retries = 3

    while (!success && retries > 0) {
      try {
        const res = await fetch(`${process.env.KIE_BASE_URL}/chat/completions`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${process.env.KIE_API_KEY}`
          },
          body: JSON.stringify({
            model: process.env.KIE_MODEL || 'gemini-3-8-flash-openai',
            messages: [{ role: 'user', content: prompt }],
            temperature: 0.1
          })
        })

        if (!res.ok) {
          throw new Error(`HTTP error! status: ${res.status}`)
        }

        const data = await res.json()
        let content = data.choices[0].message.content.trim()
        content = content.replace(/```json/g, '').replace(/```/g, '').trim()

        const parsed = JSON.parse(content)
        translatedWords.push(...parsed)
        success = true
        console.log(`   -> Thành công: đã dịch được ${parsed.length} từ.`)
      } catch (err) {
        console.error(`   Lỗi khi dịch chunk ${cIdx + 1}: ${err.message}. Thử lại...`)
        retries--
        if (retries === 0) {
          console.error(`   Bỏ cuộc chunk ${cIdx + 1}, dùng fallback meaning_en`)
          chunk.forEach(w => {
            translatedWords.push({
              id: w.id,
              hanzi: w.hanzi,
              pinyin: w.pinyin,
              word_type: posToVietnamese(w.pos),
              meaning_vi: w.meaning_en
            })
          })
        }
      }
    }
  }

  console.log(`\nTổng số từ đã dịch xong: ${translatedWords.length} / ${missingWords.length}`)
  fs.writeFileSync('scratch/hsk4_missing_with_vi.json', JSON.stringify(translatedWords, null, 2), 'utf8')
  console.log('-> Đã lưu kết quả vào scratch/hsk4_missing_with_vi.json')
}

main()
