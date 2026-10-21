import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function checkHsk4() {
  console.log('=== KIỂM TRA HIỆN TRẠNG TỪ VỰNG HSK 4 TRÊN SUPABASE ===\n')

  const { data: vocabs, count, error } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, example_hanzi', { count: 'exact' })
    .eq('hsk_level', 'HSK 4')
    .order('id')

  if (error) {
    console.error('Lỗi truy vấn:', error)
    return
  }

  console.log(`1. Tổng số mục từ HSK 4 hiện có trong bảng vocabularies: ${count} từ`)

  if (!vocabs || vocabs.length === 0) {
    console.log('Bảng vocabularies hiện CHƯA CÓ từ vựng HSK 4 nào.')
    return
  }

  const ids = vocabs.map(v => v.id)
  let examples = []
  for (let i = 0; i < ids.length; i += 200) {
    const chunk = ids.slice(i, i + 200)
    const { data: exData } = await supabase
      .from('vocabulary_examples')
      .select('id, vocabulary_id')
      .in('vocabulary_id', chunk)
    if (exData) examples = examples.concat(exData)
  }

  console.log(`2. Tổng số câu ví dụ HSK 4 trong vocabulary_examples: ${examples.length} câu`)

  console.log('\n3. Trích mẫu 10 từ đầu tiên:')
  vocabs.slice(0, 10).forEach((v, idx) => {
    console.log(`   ${idx + 1}. [${v.hanzi}] (${v.pinyin}) - ${v.meaning_vi} [${v.word_type || 'chưa có loại từ'}]`)
  })
}

checkHsk4()
