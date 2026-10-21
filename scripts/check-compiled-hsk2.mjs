import fs from 'fs'
import { HSK2_MISSING_126_WORDS } from '../data/hsk2-missing-126-data.ts'

const missingJson = JSON.parse(fs.readFileSync('scratch/hsk2_missing_126_words.json', 'utf8'))

console.log('Current items in HSK2_MISSING_126_WORDS:', HSK2_MISSING_126_WORDS.length)
console.log('Total missing in JSON:', missingJson.length)

const currentHanziSet = new Set(HSK2_MISSING_126_WORDS.map(w => w.hanzi))
const remainingToCompile = missingJson.filter(m => !currentHanziSet.has(m.hanzi))

console.log('Remaining to compile:', remainingToCompile.length)
console.log('Remaining words:')
remainingToCompile.forEach((m, idx) => {
  console.log(`${idx + 1}. [${m.hanzi}] (${m.pinyin}) | ${m.pos} | ${m.meaning_en}`)
})
fs.writeFileSync('scratch/hsk2_remaining_to_compile.json', JSON.stringify(remainingToCompile, null, 2), 'utf8')
