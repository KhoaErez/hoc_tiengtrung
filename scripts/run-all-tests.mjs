// scripts/run-all-tests.mjs
// Runner chạy toàn bộ các bài kiểm thử tự động của Chinese Notebook trong CI/CD

import { spawnSync } from 'child_process'
import path from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

const testSuites = [
  {
    name: '1. Thuật toán Lặp lại Ngắt quãng SM-2 (Spaced Repetition)',
    file: 'test-spaced-repetition.mjs',
  },
  {
    name: '2. Khôi phục Tiến độ Thông minh (Smart Resume & Safe Fallback)',
    file: 'test-smart-resume.mjs',
  },
  {
    name: '3. Tách biệt Câu sai giữa 2 chế độ (Mistakes Isolation)',
    file: 'test-split-mistakes.mjs',
  },
  {
    name: '4. Phân tách Tiến độ Luyện tập 2 chế độ (Progress Separation)',
    file: 'test-progress-separation.mjs',
  },
]

console.log('=================================================================')
console.log('🚀 CHINESE NOTEBOOK - CI/CD AUTOMATED TEST RUNNER')
console.log('=================================================================\n')

let allPassed = true
let totalSuites = testSuites.length
let passedSuites = 0

for (const suite of testSuites) {
  const filePath = path.join(__dirname, suite.file)
  console.log(`▶️ Đang chạy: ${suite.name}...`)
  
  const result = spawnSync(process.execPath, [filePath], {
    stdio: 'inherit',
    cwd: path.resolve(__dirname, '..'),
  })

  if (result.status === 0) {
    passedSuites++
    console.log(`✅ ${suite.name}: THÀNH CÔNG\n`)
  } else {
    allPassed = false
    console.error(`❌ ${suite.name}: THẤT BÀI (Exit code: ${result.status})\n`)
  }
}

console.log('=================================================================')
if (allPassed) {
  console.log(`🎉 TẤT CẢ TEST SUITES ĐÃ VƯỢT QUA (${passedSuites}/${totalSuites})!`)
  console.log('=================================================================')
  process.exit(0)
} else {
  console.error(`💥 CÓ ${totalSuites - passedSuites} TEST SUITE THẤT BÀI!`)
  console.log('=================================================================')
  process.exit(1)
}

