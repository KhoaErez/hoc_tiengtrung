import fs from 'fs'

const content = fs.readFileSync('C:\\Users\\Admin\\.gemini\\antigravity-ide\\brain\\db6312c2-0772-4fe7-a494-a0a22a3979ae\\.system_generated\\steps\\814\\content.md', 'utf8')

const trRegex = /<tr[^>]*data-vocabulary-row="true"[^>]*>([\s\S]*?)<\/tr>/g
let match
const rows = []

while ((match = trRegex.exec(content)) !== null) {
  const rowHtml = match[1]
  const tdRegex = /<td[^>]*>([\s\S]*?)<\/td>/g
  let tdMatch
  const cells = []
  while ((tdMatch = tdRegex.exec(rowHtml)) !== null) {
    // Strip HTML tags and clean whitespace
    const cleanText = tdMatch[1].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim()
    cells.push(cleanText)
  }
  if (cells.length >= 5) {
    rows.push({
      id: parseInt(cells[0]),
      hanzi: cells[1],
      pinyin: cells[2],
      pos: cells[3],
      meaning_en: cells[4],
    })
  }
}

console.log('Total valid HSK 2 table rows extracted:', rows.length)
if (rows.length > 0) {
  console.log('First 5 rows:')
  console.log(rows.slice(0, 5))
  console.log('Last 5 rows:')
  console.log(rows.slice(-5))
}

// Lưu ra file JSON chuẩn
fs.writeFileSync('scratch/hsk2_official_200_raw.json', JSON.stringify(rows, null, 2))
console.log('Saved to scratch/hsk2_official_200_raw.json')
