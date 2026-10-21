import fs from 'fs'

const missing = JSON.parse(fs.readFileSync('scratch/hsk3_missing_255_raw.json', 'utf8'))

console.log('Total missing words:', missing.length)

const p1 = missing.slice(0, 85)
const p2 = missing.slice(85, 170)
const p3 = missing.slice(170)

console.log(`Part 1 (85 words): #${p1[0].id} ${p1[0].hanzi} -> #${p1[p1.length - 1].id} ${p1[p1.length - 1].hanzi}`)
console.log(`Part 2 (85 words): #${p2[0].id} ${p2[0].hanzi} -> #${p2[p2.length - 1].id} ${p2[p2.length - 1].hanzi}`)
console.log(`Part 3 (85 words): #${p3[0].id} ${p3[0].hanzi} -> #${p3[p3.length - 1].id} ${p3[p3.length - 1].hanzi}`)

fs.writeFileSync('scratch/hsk3_part1_raw.json', JSON.stringify(p1, null, 2))
fs.writeFileSync('scratch/hsk3_part2_raw.json', JSON.stringify(p2, null, 2))
fs.writeFileSync('scratch/hsk3_part3_raw.json', JSON.stringify(p3, null, 2))
