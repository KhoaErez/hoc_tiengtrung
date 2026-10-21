import fs from 'fs'

const official1000 = JSON.parse(fs.readFileSync('scratch/hsk4_official_1000_raw.json', 'utf8'))
console.log('Tổng số từ HSK 4:', official1000.length)

const batchSize = 100
const batches = []
for (let i = 0; i < official1000.length; i += batchSize) {
  const chunk = official1000.slice(i, i + batchSize)
  batches.push({
    batchIndex: Math.floor(i / batchSize) + 1,
    startId: chunk[0].id,
    endId: chunk[chunk.length - 1].id,
    startHanzi: chunk[0].hanzi,
    endHanzi: chunk[chunk.length - 1].hanzi,
    count: chunk.length,
    words: chunk
  })
}

console.log(`Đã chia thành ${batches.length} Batch (mỗi Batch 100 từ x 2 ví dụ = 200 câu ví dụ):`)
batches.forEach(b => {
  console.log(`- Batch ${b.batchIndex}: #${b.startId} [${b.startHanzi}] -> #${b.endId} [${b.endHanzi}] (${b.count} từ)`)
})

fs.writeFileSync('scratch/hsk4_batches_plan.json', JSON.stringify(batches, null, 2), 'utf8')
