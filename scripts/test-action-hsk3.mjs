import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function testFetchHsk3() {
  console.log('=== TEST MÔ PHỎNG getTopicVocabulariesAction CHO HSK 3 ===\n')

  // Giả lập lấy trang 1 (30 từ đầu), trang 5 (từ 121-150), trang cuối (từ 471-500)
  const testPages = [1, 5, 17]

  for (const page of testPages) {
    const pageSize = 30
    const from = (page - 1) * pageSize
    const to = from + pageSize - 1

    const { data: vocabs, count } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level', { count: 'exact' })
      .eq('hsk_level', 'HSK 3')
      .order('id', { ascending: true })
      .range(from, to)

    const vocabIds = vocabs.map(v => v.id)
    const { data: examples } = await supabase
      .from('vocabulary_examples')
      .select('vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level')
      .in('vocabulary_id', vocabIds)

    const exMap = new Map()
    for (const ex of examples) {
      const list = exMap.get(ex.vocabulary_id) || []
      list.push(ex)
      exMap.set(ex.vocabulary_id, list)
    }

    console.log(`--- TRANG ${page} (${vocabs.length} từ, tổng số từ HSK 3: ${count}) ---`)
    let allHave2 = true
    for (const v of vocabs) {
      const exs = exMap.get(v.id) || []
      if (exs.length < 2) {
        allHave2 = false
        console.log(`❌ Từ [${v.hanzi}] chỉ có ${exs.length} ví dụ`)
      }
    }
    if (allHave2) {
      console.log(`✅ 100% (${vocabs.length}/${vocabs.length}) từ vựng ở Trang ${page} đều có ĐỦ 2 câu ví dụ chất lượng!`)
      // In thử từ đầu tiên của trang
      const sample = vocabs[0]
      const sampleExs = exMap.get(sample.id)
      console.log(`   Ví dụ tiêu biểu: [${sample.hanzi}] (${sample.pinyin}) [${sample.word_type}] - ${sample.meaning_vi}`)
      sampleExs.forEach((e, i) => console.log(`     #${i+1} [${e.difficulty_level}]: ${e.chinese} (${e.pinyin}) -> ${e.meaning_vi}`))
    }
    console.log('')
  }
}

testFetchHsk3()
