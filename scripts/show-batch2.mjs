import fs from 'fs'

const b2 = JSON.parse(fs.readFileSync('scratch/hsk3_missing_batch2.json', 'utf8'))
console.log('Batch 2 words count:', b2.length)
b2.forEach((w, i) => {
  console.log(`${i + 1}. [${w.hanzi}] (${w.pinyin}) - ${w.meaning_vi}`)
})
