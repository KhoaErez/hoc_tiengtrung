import fs from 'fs'

const audit = JSON.parse(fs.readFileSync('scratch/hsk3_examples_audit_result.json', 'utf8'))
const missing = audit.wordsWith0ExList

console.log('Total words to process:', missing.length)

const batch1 = missing.slice(0, 80)
const batch2 = missing.slice(80, 160)
const batch3 = missing.slice(160)

console.log(`\nBatch 1 (80 từ): [${batch1[0].hanzi}] -> [${batch1[batch1.length - 1].hanzi}]`)
console.log(`Batch 2 (80 từ): [${batch2[0].hanzi}] -> [${batch2[batch2.length - 1].hanzi}]`)
console.log(`Batch 3 (80 từ): [${batch3[0].hanzi}] -> [${batch3[batch3.length - 1].hanzi}]`)

fs.writeFileSync('scratch/hsk3_missing_batch1.json', JSON.stringify(batch1, null, 2))
fs.writeFileSync('scratch/hsk3_missing_batch2.json', JSON.stringify(batch2, null, 2))
fs.writeFileSync('scratch/hsk3_missing_batch3.json', JSON.stringify(batch3, null, 2))
console.log('Saved 3 batches to scratch/')
