import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function verifyHsk4Batch10() {
  console.log('=== KIỂM TRA DATABASE SAU KHI CHẠY HSK 4 - BATCH 10 (CÁN ĐÍCH 100% TOÀN DIỆN HSK 4) ===\n')

  // 1. Lấy toàn bộ từ vựng HSK 4
  let allHsk4 = []
  let from = 0
  const pageSize = 1000
  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, example_hanzi')
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

  console.log(`1. Tổng số từ vựng HSK 4 trong DB: ${allHsk4.length} từ (đại diện 1.000 mục từ vựng CTI)`)

  // 2. Lấy toàn bộ ví dụ của HSK 4
  const ids = allHsk4.map(v => v.id)
  let examples = []
  for (let i = 0; i < ids.length; i += 200) {
    const chunk = ids.slice(i, i + 200)
    const { data } = await supabase
      .from('vocabulary_examples')
      .select('id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level')
      .in('vocabulary_id', chunk)
    if (data) examples = examples.concat(data)
  }

  console.log(`2. Tổng số câu ví dụ HSK 4 trong bảng vocabulary_examples: ${examples.length} câu`)

  const exMap = new Map()
  for (const ex of examples) {
    const list = exMap.get(ex.vocabulary_id) || []
    list.push(ex)
    exMap.set(ex.vocabulary_id, list)
  }

  let wordsWith2Ex = 0
  let wordsWith1Ex = 0
  let wordsWith0Ex = 0

  for (const v of allHsk4) {
    const list = exMap.get(v.id) || []
    if (list.length >= 2) {
      wordsWith2Ex++
    } else if (list.length === 1) {
      wordsWith1Ex++
    } else {
      wordsWith0Ex++
    }
  }

  console.log(`3. Thống kê tiến độ ví dụ HSK 4:`)
  console.log(`   - Số từ có đủ 2 câu ví dụ: ${wordsWith2Ex} / ${allHsk4.length} (${(wordsWith2Ex / allHsk4.length * 100).toFixed(1)}%)`)
  console.log(`   - Số từ có 1 câu ví dụ:    ${wordsWith1Ex} từ`)
  console.log(`   - Số từ chưa có ví dụ:     ${wordsWith0Ex} từ\n`)

  if (wordsWith2Ex === allHsk4.length && wordsWith0Ex === 0) {
    console.log('🎉 XIN CHÚC MỪNG! HSK 4 ĐÃ HOÀN TẤT CHUẨN HÓA 100% CẢ 1.000 TỪ VỰNG VÀ 2.000 CÂU VÍ DỤ CHẤT LƯỢNG CAO!')
  } else {
    console.log(`Còn lại ${wordsWith0Ex} từ cần bổ sung.`)
  }

  console.log('=== KẾT THÚC KIỂM TRA ===')
}

verifyHsk4Batch10()
