import fs from 'fs'

const audit = JSON.parse(fs.readFileSync('scratch/hsk3_examples_audit_result.json', 'utf8'))
const missing = audit.wordsWith0ExList

console.log('Total words with 0 examples in vocabulary_examples:', missing.length)
console.log('First 20 words:')
missing.slice(0, 20).forEach((w, i) => {
  console.log(`${i + 1}. [${w.hanzi}] (${w.pinyin}) - ${w.meaning_vi} [${w.word_type || 'N/A'}]`)
})

console.log('\nLast 20 words:')
missing.slice(-20).forEach((w, i) => {
  console.log(`${i + 1}. [${w.hanzi}] (${w.pinyin}) - ${w.meaning_vi} [${w.word_type || 'N/A'}]`)
})

// Kiểm tra có từ nào thiếu pinyin hoặc meaning_vi không
const noPinyin = missing.filter(w => !w.pinyin)
const noVi = missing.filter(w => !w.meaning_vi)
console.log(`\nTừ thiếu Pinyin: ${noPinyin.length}`)
console.log(`Từ thiếu Meaning_vi: ${noVi.length}`)
