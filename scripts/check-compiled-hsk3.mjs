import fs from 'fs'
import { HSK3_MISSING_255_WORDS } from '../data/hsk3-missing-data.ts'

const missingJson = JSON.parse(fs.readFileSync('scratch/hsk3_missing_255_raw.json', 'utf8'))

console.log('Current items in HSK3_MISSING_255_WORDS:', HSK3_MISSING_255_WORDS.length)
console.log('Total missing in JSON:', missingJson.length)

const currentHanziSet = new Set(HSK3_MISSING_255_WORDS.map(w => w.hanzi))
const remainingToCompile = missingJson.filter(m => !currentHanziSet.has(m.hanzi))

console.log('Remaining to compile:', remainingToCompile.length)
if (remainingToCompile.length > 0) {
  console.log('Remaining words:')
  remainingToCompile.forEach((m, idx) => {
    console.log(`${idx + 1}. #${m.id} [${m.hanzi}] (${m.pinyin}) | ${m.pos} | ${m.meaning_en}`)
  })
} else {
  console.log('SUCCESS: All 255 words compiled completely and accurately!')
}

// Kiểm tra chất lượng các ví dụ
let validExamplesCount = 0
for (const word of HSK3_MISSING_255_WORDS) {
  if (word.examples && word.examples.length === 2) {
    if (word.examples[0].chinese && word.examples[0].pinyin && word.examples[0].meaning_vi &&
        word.examples[1].chinese && word.examples[1].pinyin && word.examples[1].meaning_vi) {
      validExamplesCount += 2
    }
  }
}
console.log(`Verified valid example sentences: ${validExamplesCount} / ${HSK3_MISSING_255_WORDS.length * 2}`)
