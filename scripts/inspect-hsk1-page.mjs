import fs from 'fs'

const content = fs.readFileSync('C:\\Users\\Admin\\.gemini\\antigravity-ide\\brain\\db6312c2-0772-4fe7-a494-a0a22a3979ae\\.system_generated\\steps\\605\\content.md', 'utf8')
console.log('File length:', content.length)

// Tìm các đoạn JSON hoặc text chứa từ vựng
const regex = /\{[^{}]*"word"[^{}]*\}/g
const found = content.match(regex)
console.log('Found word objects:', found ? found.length : 0)

// Tìm bảng hoặc cấu trúc dữ liệu
const trMatches = content.match(/<tr[^>]*>[\s\S]*?<\/tr>/g)
console.log('Table rows found:', trMatches ? trMatches.length : 0)

// Tìm các đoạn tựa như pinyin / hanzi
if (content.includes('self.__next_f')) {
  console.log('Found Next.js stream payload, looking for vocabularies...')
}
