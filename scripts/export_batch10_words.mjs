import fs from 'fs'

const allWords = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
// Batch 10: index từ 901 đến 1000 tương ứng ID 2902 đến 3001 (100 từ)
const batch10 = allWords.slice(901, 1001)
fs.writeFileSync('scratch/batch10_hsk5_words.json', JSON.stringify(batch10, null, 2), 'utf8')
console.log(`Đã lưu ${batch10.length} từ Batch 10: ID ${batch10[0].id} [${batch10[0].hanzi}] -> ID ${batch10[batch10.length - 1].id} [${batch10[batch10.length - 1].hanzi}]`)
