import fs from 'fs'

const raw1 = JSON.parse(fs.readFileSync('scratch/hsk1_official_300_raw.json', 'utf8'))
const raw2 = JSON.parse(fs.readFileSync('scratch/hsk2_official_200_raw.json', 'utf8'))

const set1 = new Map()
raw1.forEach(r => set1.set(r[1].trim(), r))

const crossWords = []
raw2.forEach(r => {
  if (set1.has(r.hanzi.trim())) {
    crossWords.push({
      hanzi: r.hanzi.trim(),
      in1: set1.get(r.hanzi.trim()),
      in2: r,
    })
  }
})

console.log('Words that appear in BOTH HSK 1 (300 words) and HSK 2 (200 words):', crossWords.length)
crossWords.forEach(w => {
  console.log(`- [${w.hanzi}]`)
  console.log(`  HSK 1: ${w.in1[2]} | ${w.in1[3]} | ${w.in1[4]}`)
  console.log(`  HSK 2: ${w.in2.pinyin} | ${w.in2.pos} | ${w.in2.meaning_en}`)
})
