import fs from 'fs'

const allWords = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
// Batch 11: index từ 1001 đến 1101 tương ứng ID 3002 đến 3101 (100 từ)
const batch11 = allWords.slice(1001, 1101)
fs.writeFileSync('scratch/batch11_hsk5_words.json', JSON.stringify(batch11, null, 2), 'utf8')
console.log(`Đã lưu ${batch11.length} từ Batch 11: ID ${batch11[0].id} [${batch11[0].hanzi}] -> ID ${batch11[batch11.length - 1].id} [${batch11[batch11.length - 1].hanzi}]`)
