import fs from 'fs'

const b1 = JSON.parse(fs.readFileSync('scratch/hsk3_missing_batch1.json', 'utf8'))
console.log('Batch 1 words count:', b1.length)
b1.forEach((w, i) => {
  console.log(`${i + 1}. [${w.hanzi}] (${w.pinyin}) - ${w.meaning_vi}`)
})
