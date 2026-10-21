import fs from 'fs'

const rec = JSON.parse(fs.readFileSync('scratch/reconciliation_result.json', 'utf8'))
const csv = fs.readFileSync('scratch/hsk30.csv', 'utf8').split('\n')

const wordsIn30 = new Map()
for (const line of csv) {
  const parts = line.split(',')
  if (parts.length >= 5) {
    const level = parts[0].trim()
    const hanzi = parts[2].trim()
    const pinyin = parts[3].trim()
    if (!wordsIn30.has(hanzi)) {
      wordsIn30.set(hanzi, { level, hanzi, pinyin })
    }
  }
}

console.log('=== VỊ TRÍ THỰC TẾ TRONG HSK 3.0 CỦA 21 TỪ LỆCH CẤP ĐỘ ===\n')
rec.notInOfficialWords.forEach((w, idx) => {
  const found = wordsIn30.get(w.hanzi)
  const realLevel = found ? `HSK ${found.level}` : 'Không thuộc 300 từ HSK 1-6 chuẩn'
  console.log(`${idx + 1}. ${w.hanzi} (${w.pinyin}) - ${w.meaning_vi}: Hiện tại trong DB = '${w.hsk_level}' -> Chuẩn HSK 3.0 = '${realLevel}'`)
})
