import fs from 'fs'

const partNum = process.argv[2] || '1'
const list = JSON.parse(fs.readFileSync(`scratch/hsk3_part${partNum}_raw.json`, 'utf8'))
console.log(`=== PART ${partNum} (${list.length} words) ===`)
list.forEach((w, i) => {
  console.log(`${i + 1}. #${w.id} ${w.hanzi} (${w.pinyin}) [${w.pos}] - ${w.meaning_en}`)
})
