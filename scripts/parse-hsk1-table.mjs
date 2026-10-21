import fs from 'fs'

const content = fs.readFileSync('C:\\Users\\Admin\\.gemini\\antigravity-ide\\brain\\db6312c2-0772-4fe7-a494-a0a22a3979ae\\.system_generated\\steps\\605\\content.md', 'utf8')

const trRegex = /<tr[^>]*>([\s\S]*?)<\/tr>/g
let match
const rows = []

while ((match = trRegex.exec(content)) !== null) {
  const rowHtml = match[1]
  const tdRegex = /<td[^>]*>([\s\S]*?)<\/td>/g
  let tdMatch
  const cells = []
  while ((tdMatch = tdRegex.exec(rowHtml)) !== null) {
    // Strip HTML tags
    const cleanText = tdMatch[1].replace(/<[^>]+>/g, '').trim()
    cells.push(cleanText)
  }
  if (cells.length >= 3) {
    rows.push(cells)
  }
}

console.log('Total valid table rows extracted:', rows.length)
console.log('First 5 rows:')
for (let i = 0; i < Math.min(5, rows.length); i++) {
  console.log(rows[i])
}
console.log('Last 5 rows:')
for (let i = Math.max(0, rows.length - 5); i < rows.length; i++) {
  console.log(rows[i])
}

// Lưu ra file JSON chuẩn
fs.writeFileSync('scratch/hsk1_official_300_raw.json', JSON.stringify(rows, null, 2))
console.log('Saved to scratch/hsk1_official_300_raw.json')
