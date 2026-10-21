import fs from 'fs'

const allWords = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
// Batch 12: index từ 1101 đến 1201 tương ứng ID 3102 đến 3201 (100 từ)
const batch12 = allWords.slice(1101, 1201)
fs.writeFileSync('scratch/batch12_hsk5_words.json', JSON.stringify(batch12, null, 2), 'utf8')
console.log(`Đã lưu ${batch12.length} từ Batch 12: ID ${batch12[0].id} [${batch12[0].hanzi}] -> ID ${batch12[batch12.length - 1].id} [${batch12[batch12.length - 1].hanzi}]`)
