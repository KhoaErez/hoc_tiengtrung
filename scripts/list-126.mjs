import fs from 'fs'

const missing = JSON.parse(fs.readFileSync('scratch/hsk2_missing_126_words.json', 'utf8'))
console.log('List of 126 words:')
missing.forEach((m, i) => {
  console.log(`${i + 1}. [${m.hanzi}] (${m.pinyin}) | ${m.pos} | ${m.meaning_en}`)
})
