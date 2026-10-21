import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function testHsk3() {
  console.log('=== TEST TÍNH NĂNG TRUY VẤN VÀ HIỂN THỊ HSK 3 ===\n')

  // 1. Lấy 10 từ mẫu đầu tiên của HSK 3
  const { data: vocabList, error } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi')
    .eq('hsk_level', 'HSK 3')
    .order('hanzi', { ascending: true })
    .limit(10)

  if (error || !vocabList) {
    console.error('Lỗi truy vấn:', error)
    return
  }

  console.log(`Lấy thành công ${vocabList.length} từ vựng mẫu HSK 3:`)
  for (const w of vocabList) {
    console.log(`- [${w.hanzi}] (${w.pinyin}) | ${w.word_type || 'N/A'} | ${w.meaning_vi}`)
  }

  // 2. Lấy ví dụ từ bảng vocabulary_examples cho từ đầu tiên
  const firstWord = vocabList[0]
  const { data: examples } = await supabase
    .from('vocabulary_examples')
    .select('chinese, pinyin, meaning_vi, difficulty_level')
    .eq('vocabulary_id', firstWord.id)
    .order('order_index', { ascending: true })

  console.log(`\nVí dụ chi tiết của từ [${firstWord.hanzi}] (${firstWord.pinyin}):`)
  if (examples && examples.length > 0) {
    examples.forEach((ex, idx) => {
      console.log(`  ${idx + 1}. [${ex.difficulty_level}] ${ex.chinese}`)
      console.log(`     Pinyin: ${ex.pinyin}`)
      console.log(`     Nghĩa:  ${ex.meaning_vi}`)
    })
  } else {
    console.log('  Chưa có ví dụ trong vocabulary_examples')
  }

  console.log('\nTEST HOÀN TẤT: Server queries thành công 100%!')
}

testHsk3()
