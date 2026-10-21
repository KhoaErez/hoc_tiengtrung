import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function getSummary() {
  console.log('=== BÁO CÁO TỔNG KẾT TOÀN DIỆN HSK 1 - HSK 5 (CHUẨN HSK 3.0) ===\n')

  const levels = ['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5']
  const targets = {
    'HSK 1': 300,
    'HSK 2': 200,
    'HSK 3': 500,
    'HSK 4': 1000,
    'HSK 5': 1600
  }

  let totalVocabs = 0
  let totalExamples = 0

  for (const lvl of levels) {
    const { count, error } = await supabase
      .from('vocabularies')
      .select('id', { count: 'exact', head: true })
      .eq('hsk_level', lvl)

    if (error) {
      console.error(`Lỗi đếm ${lvl}:`, error)
      continue
    }

    // Đếm câu ví dụ
    const { data: vIds } = await supabase
      .from('vocabularies')
      .select('id')
      .eq('hsk_level', lvl)

    let exCount = 0
    if (vIds && vIds.length > 0) {
      const ids = vIds.map(v => v.id)
      for (let i = 0; i < ids.length; i += 500) {
        const chunk = ids.slice(i, i + 500)
        const { count: c } = await supabase
          .from('vocabulary_examples')
          .select('id', { count: 'exact', head: true })
          .in('vocabulary_id', chunk)
        if (c) exCount += c
      }
    }

    console.log(`📌 ${lvl}:`)
    console.log(`   - Mục tiêu HSK 3.0:    ${targets[lvl]} từ`)
    console.log(`   - Số lượng trong DB:    ${count} từ`)
    console.log(`   - Số câu ví dụ:         ${exCount} câu`)
    console.log(`   - Tỷ lệ hoàn thành:     ${(count >= targets[lvl] ? 100 : (count / targets[lvl] * 100)).toFixed(1)}%\n`)

    totalVocabs += count
    totalExamples += exCount
  }

  console.log('====================================================================')
  console.log(`🏆 TỔNG TÍCH LŨY HSK 1 ➔ HSK 5:`)
  console.log(`   - Tổng mục từ vựng trong CSDL: ${totalVocabs} từ (Mục tiêu chuẩn: 3.600 từ)`)
  console.log(`   - Tổng số câu ví dụ chất lượng cao: ${totalExamples} câu ví dụ song ngữ`)
  console.log('====================================================================')
}

getSummary()
