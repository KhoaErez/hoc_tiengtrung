import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function fullAudit() {
  const levels = ['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4']
  console.log('=== TỔNG KẾT TOÀN DIỆN HSK 1, 2, 3, 4 ===\n')
  
  let totalWords = 0
  let totalExamples = 0

  for (const lvl of levels) {
    let vocabs = []
    let from = 0
    while (true) {
      const { data } = await supabase.from('vocabularies').select('id').eq('hsk_level', lvl).range(from, from + 999)
      vocabs = vocabs.concat(data)
      if (data.length < 1000) break
      from += 1000
    }
    
    const ids = vocabs.map(v => v.id)
    let examples = []
    for (let i = 0; i < ids.length; i += 200) {
      const chunk = ids.slice(i, i + 200)
      const { data } = await supabase.from('vocabulary_examples').select('vocabulary_id').in('vocabulary_id', chunk)
      if (data) examples = examples.concat(data)
    }
    
    const exMap = new Map()
    for (const ex of examples) {
      exMap.set(ex.vocabulary_id, (exMap.get(ex.vocabulary_id) || 0) + 1)
    }
    
    let with2 = 0
    for (const v of vocabs) {
      if ((exMap.get(v.id) || 0) >= 2) with2++
    }
    
    totalWords += vocabs.length
    totalExamples += examples.length

    console.log(`✅ ${lvl}: ${vocabs.length} từ | ${examples.length} ví dụ | ${with2}/${vocabs.length} có đủ 2 ví dụ (${(with2/vocabs.length*100).toFixed(1)}%)`)
  }

  console.log(`\n🎉 TỔNG CỘNG HSK 1 - 4: ${totalWords} mục từ vựng | ${totalExamples} câu ví dụ đạt chuẩn!`)
}

fullAudit()
