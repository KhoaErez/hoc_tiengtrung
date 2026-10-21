import fs from 'fs'

const raw = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
const startIndex = raw.findIndex(w => w.id === 3202)
console.log(`Tìm thấy ID 3202 tại raw index: ${startIndex}`)

const batch13 = raw.slice(startIndex, startIndex + 100)

console.log(`Đã trích xuất ${batch13.length} từ cho Batch 13:`)
console.log(`Từ đầu tiên: #${batch13[0].id} [${batch13[0].hanzi}] (${batch13[0].pinyin})`)
console.log(`Từ cuối cùng: #${batch13[batch13.length - 1].id} [${batch13[batch13.length - 1].hanzi}] (${batch13[batch13.length - 1].pinyin})`)

fs.writeFileSync('scratch/batch13_hsk5_words.json', JSON.stringify(batch13, null, 2), 'utf8')
console.log('Đã lưu vào scratch/batch13_hsk5_words.json')
