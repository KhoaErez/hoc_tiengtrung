import fs from 'fs'

const raw2 = JSON.parse(fs.readFileSync('scratch/hsk2_official_200_raw.json', 'utf8'))
const map = new Map()
const dupes = []
raw2.forEach(r => {
  const key = `${r.hanzi}_${r.pinyin.replace(/\s+/g, '').toLowerCase()}`
  if (map.has(key)) {
    dupes.push({ first: map.get(key), second: r })
  } else {
    map.set(key, r)
  }
})

console.log('Total entries in raw2:', raw2.length)
console.log('Unique (hanzi + pinyin) keys:', map.size)
console.log('Duplicates in raw2:')
dupes.forEach(d => console.log(d))
