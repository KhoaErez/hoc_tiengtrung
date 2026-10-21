import fs from 'fs'

const rec = JSON.parse(fs.readFileSync('scratch/hsk2_reconciliation_result.json', 'utf8'))
console.log('30 words to shift to HSK 3:')
const notInOfficial = rec.notInOfficialWords
notInOfficial.forEach((w, i) => {
  console.log(`${i + 1}. [${w.hanzi}] (${w.pinyin}) - id: ${w.id}`)
})

fs.writeFileSync('scratch/hsk2_30_words_to_hsk3.json', JSON.stringify(notInOfficial, null, 2), 'utf8')
