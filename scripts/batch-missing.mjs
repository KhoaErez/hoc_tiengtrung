import fs from 'fs'

const missing = JSON.parse(fs.readFileSync('scratch/hsk3_missing_255_raw.json', 'utf8'))
console.log('Total:', missing.length)
for (let i = 0; i < missing.length; i += 50) {
  const slice = missing.slice(i, i + 50)
  console.log(`Batch ${Math.floor(i / 50) + 1}: ${slice.length} words (#${slice[0].id} ${slice[0].hanzi} -> #${slice[slice.length - 1].id} ${slice[slice.length - 1].hanzi})`)
}
