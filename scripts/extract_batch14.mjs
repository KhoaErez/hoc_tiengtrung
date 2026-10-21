import fs from 'fs'

const raw = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
const startIndex = raw.findIndex(w => w.id === 3302)
console.log(`Tìm thấy ID 3302 tại raw index: ${startIndex}`)

const batch14 = raw.slice(startIndex, startIndex + 100)

console.log(`Đã trích xuất ${batch14.length} từ cho Batch 14:`)
console.log(`Từ đầu tiên: #${batch14[0].id} [${batch14[0].hanzi}] (${batch14[0].pinyin})`)
console.log(`Từ cuối cùng: #${batch14[batch14.length - 1].id} [${batch14[batch14.length - 1].hanzi}] (${batch14[batch14.length - 1].pinyin})`)

fs.writeFileSync('scratch/batch14_hsk5_words.json', JSON.stringify(batch14, null, 2), 'utf8')
console.log('Đã lưu vào scratch/batch14_hsk5_words.json')
