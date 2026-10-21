import fs from 'fs'

const raw = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
const startIndex = raw.findIndex(w => w.id === 3402)
console.log(`Tìm thấy ID 3402 tại raw index: ${startIndex}`)

const batch15 = raw.slice(startIndex, startIndex + 100)

console.log(`Đã trích xuất ${batch15.length} từ cho Batch 15:`)
console.log(`Từ đầu tiên: #${batch15[0].id} [${batch15[0].hanzi}] (${batch15[0].pinyin})`)
console.log(`Từ cuối cùng: #${batch15[batch15.length - 1].id} [${batch15[batch15.length - 1].hanzi}] (${batch15[batch15.length - 1].pinyin})`)

fs.writeFileSync('scratch/batch15_hsk5_words.json', JSON.stringify(batch15, null, 2), 'utf8')
console.log('Đã lưu vào scratch/batch15_hsk5_words.json')
