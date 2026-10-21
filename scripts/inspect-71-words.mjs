import fs from 'fs'

const rec = JSON.parse(fs.readFileSync('scratch/hsk3_reconciliation_result.json', 'utf8'))
console.log('Total not in official HSK 3:', rec.notInOfficialWords.length)

// Đọc HSK 1 và HSK 2 official để xem có từ nào thuộc HSK 1 hoặc HSK 2 không
const off1 = JSON.parse(fs.readFileSync('scratch/hsk1_official_300_raw.json', 'utf8'))
const off1Set = new Set(off1.map(item => (Array.isArray(item) ? item[1] : item.hanzi).trim()))

const off2 = JSON.parse(fs.readFileSync('scratch/hsk2_official_200_raw.json', 'utf8'))
const off2Set = new Set(off2.map(item => (Array.isArray(item) ? item[1] : item.hanzi).trim()))

// Đọc hsk30.csv để tra cứu level tổng thể
const lines = fs.readFileSync('scratch/hsk30.csv', 'utf8').split('\n')
const csvMap = new Map()
for (const line of lines.slice(1)) {
  const parts = line.split(',')
  if (parts[1]) {
    csvMap.set(parts[1].trim(), parts[5] || 'Unknown')
  }
}

const report = rec.notInOfficialWords.map((w, i) => {
  const hanzi = w.hanzi.trim()
  let where = 'HSK 4+'
  if (off1Set.has(hanzi)) {
    where = 'HSK 1 (3.0)'
  } else if (off2Set.has(hanzi)) {
    where = 'HSK 2 (3.0)'
  } else if (csvMap.has(hanzi)) {
    where = `HSK ${csvMap.get(hanzi)}`
  }
  return {
    index: i + 1,
    id: w.id,
    hanzi: w.hanzi,
    pinyin: w.pinyin,
    meaning_vi: w.meaning_vi,
    destination: where
  }
})

console.log(JSON.stringify(report, null, 2))
fs.writeFileSync('scratch/hsk3_71_misplaced_report.json', JSON.stringify(report, null, 2), 'utf8')
