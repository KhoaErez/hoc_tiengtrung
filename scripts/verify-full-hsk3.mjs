import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('Thiếu biến môi trường NEXT_PUBLIC_SUPABASE_URL hoặc NEXT_PUBLIC_SUPABASE_ANON_KEY')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseAnonKey)

async function verifyHsk3() {
  console.log('=== KIỂM TRA TRẠNG THÁI CÂU VÍ DỤ TOÀN BỘ HSK 3 TRÊN SUPABASE ===\n')

  // Lấy toàn bộ từ vựng HSK 3
  let allHsk3 = []
  let from = 0
  const pageSize = 1000
  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, example_hanzi')
      .eq('hsk_level', 'HSK 3')
      .range(from, from + pageSize - 1)
      .order('id')

    if (error) {
      console.error('Lỗi truy vấn vocabularies:', error)
      return
    }
    allHsk3 = allHsk3.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  console.log(`1. Tổng số từ vựng HSK 3: ${allHsk3.length} từ`)

  // Lấy toàn bộ câu ví dụ của các từ HSK 3
  const vocabIds = allHsk3.map(v => v.id)
  let allExamples = []
  for (let i = 0; i < vocabIds.length; i += 200) {
    const chunk = vocabIds.slice(i, i + 200)
    const { data, error } = await supabase
      .from('vocabulary_examples')
      .select('id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index')
      .in('vocabulary_id', chunk)

    if (error) {
      console.error('Lỗi truy vấn vocabulary_examples:', error)
      return
    }
    allExamples = allExamples.concat(data)
  }

  console.log(`2. Tổng số câu ví dụ HSK 3 hiện có trong bảng vocabulary_examples: ${allExamples.length} câu`)

  // Thống kê theo từ
  const exampleCountMap = new Map()
  for (const ex of allExamples) {
    const count = exampleCountMap.get(ex.vocabulary_id) || 0
    exampleCountMap.set(ex.vocabulary_id, count + 1)
  }

  let full2Count = 0
  let oneCount = 0
  let zeroCount = 0
  const missingWords = []

  for (const vocab of allHsk3) {
    const count = exampleCountMap.get(vocab.id) || 0
    if (count >= 2) {
      full2Count++
    } else if (count === 1) {
      oneCount++
      missingWords.push({ ...vocab, count })
    } else {
      zeroCount++
      missingWords.push({ ...vocab, count })
    }
  }

  console.log(`\n3. Thống kê chi tiết chất lượng ví dụ HSK 3:`)
  console.log(`   - Từ có ĐỦ 2 ví dụ trở lên: ${full2Count} / ${allHsk3.length} (${((full2Count / allHsk3.length) * 100).toFixed(1)}%)`)
  console.log(`   - Từ chỉ có 1 ví dụ:        ${oneCount}`)
  console.log(`   - Từ có 0 ví dụ:            ${zeroCount}`)

  if (missingWords.length > 0) {
    console.log(`\n4. Các từ còn thiếu ví dụ (${missingWords.length} từ đầu tiên trong danh sách thiếu):`)
    missingWords.slice(0, 15).forEach((w, idx) => {
      console.log(`   ${idx + 1}. [${w.hanzi}] (${w.pinyin}) - ${w.meaning_vi} | Số ví dụ: ${w.count}`)
    })
    if (missingWords.length > 15) {
      console.log(`   ... và còn ${missingWords.length - 15} từ khác.`)
    }
  } else {
    console.log(`\n🎉 XUẤT SẮC: 100% từ vựng HSK 3 đã có ĐỦ 2 câu ví dụ chất lượng cao!`)
  }
}

verifyHsk3()
