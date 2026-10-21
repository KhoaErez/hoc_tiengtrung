import { createClient } from '@supabase/supabase-js'
import fs from 'fs'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function verifyHsk4Step1() {
  console.log('=== KIỂM TRA TOÀN BỘ CSDL HSK 4 SAU KHI CHẠY GIAI ĐOẠN 1 ===\n')

  // 1. Lấy toàn bộ từ HSK 4
  let allHsk4 = []
  let from = 0
  const pageSize = 1000
  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level')
      .eq('hsk_level', 'HSK 4')
      .range(from, from + pageSize - 1)
      .order('id')

    if (error) {
      console.error('Lỗi truy vấn:', error)
      return
    }
    allHsk4 = allHsk4.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  console.log(`1. Tổng số từ vựng HSK 4 trên Supabase: ${allHsk4.length} từ (Mục tiêu: 1.000 từ)`)

  // 2. Đối chiếu với 1.000 từ chuẩn đề cương HSK 3.0
  const official1000 = JSON.parse(fs.readFileSync('scratch/hsk4_official_1000_raw.json', 'utf8'))
  const officialMap = new Map(official1000.map(o => [o.hanzi.trim(), o]))

  let matchedOfficial = 0
  let missingWordType = 0
  let missingMeaningVi = 0

  for (const v of allHsk4) {
    if (officialMap.has(v.hanzi.trim())) matchedOfficial++
    if (!v.word_type || v.word_type.trim() === '') missingWordType++
    if (!v.meaning_vi || v.meaning_vi.trim() === '') missingMeaningVi++
  }

  console.log(`2. Độ khớp với 1.000 từ chuẩn Đề cương HSK 3.0: ${matchedOfficial} / ${official1000.length} (${((matchedOfficial / official1000.length) * 100).toFixed(1)}%)`)
  console.log(`3. Số từ thiếu Loại từ (word_type):              ${missingWordType}`)
  console.log(`4. Số từ thiếu Nghĩa tiếng Việt (meaning_vi):     ${missingMeaningVi}`)

  // 3. Trích mẫu 10 từ
  console.log('\n5. Trích mẫu 10 từ HSK 4 thực tế trong DB:')
  const sampleIndices = [0, 50, 100, 200, 300, 400, 500, 600, 800, 999]
  sampleIndices.forEach(idx => {
    if (idx < allHsk4.length) {
      const w = allHsk4[idx]
      console.log(`   [#${idx + 1}] ${w.hanzi} (${w.pinyin}) [${w.word_type}] - ${w.meaning_vi}`)
    }
  })

  if (allHsk4.length === 1000 && matchedOfficial === 1000) {
    console.log('\n🎉 XUẤT SẮC: Toàn bộ 1.000/1.000 từ vựng HSK 4 đã đạt chuẩn 100% Đề cương HSK 3.0!')
  }
}

verifyHsk4Step1()
