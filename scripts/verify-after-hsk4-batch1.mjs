import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function verifyHsk4Batch1() {
  console.log('=== KIỂM TRA DATABASE SAU KHI CHẠY HSK 4 - BATCH 1 (100 TỪ / 200 CÂU VÍ DỤ) ===\n')

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

  console.log(`1. Tổng số từ vựng HSK 4 trong DB: ${allHsk4.length} từ`)

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
  for (const v of allHsk4) {
    const list = exMap.get(v.id) || []
    if (list.length >= 2) wordsWith2Ex++
  }

  console.log(`3. Số từ vựng HSK 4 đã có ĐỦ 2 câu ví dụ: ${wordsWith2Ex} / ${allHsk4.length} (${((wordsWith2Ex / allHsk4.length) * 100).toFixed(1)}%)`)

  // 4. Kiểm tra mẫu từ Batch 1
  const testWords = ['啊', '爱情', '安检', '保护', '此次']
  console.log('\n4. Kiểm tra chi tiết một số từ tiêu biểu của Batch 1:')
  for (const tw of testWords) {
    const v = allHsk4.find(item => item.hanzi === tw)
    if (v) {
      const exs = exMap.get(v.id) || []
      console.log(`\n[${v.hanzi}] (${v.pinyin}) [${v.word_type}] - ${v.meaning_vi}`)
      exs.forEach((e, idx) => {
        console.log(`  * #${idx+1} [${e.difficulty_level}]: ${e.chinese}`)
        console.log(`    Pinyin: ${e.pinyin}`)
        console.log(`    Dịch:   ${e.meaning_vi}`)
      })
    }
  }
}

verifyHsk4Batch1()
