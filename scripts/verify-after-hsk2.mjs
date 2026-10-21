import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function checkAfterHsk2Migration() {
  console.log('=== KIỂM TRA DỮ LIỆU SAU MIGRATION HSK 2 ===\n')

  // 1. Kiểm tra HSK 1 vẫn đủ 300 từ không
  const { count: hsk1Count } = await supabase
    .from('vocabularies')
    .select('id', { count: 'exact', head: true })
    .eq('hsk_level', 'HSK 1')
  console.log('1. Số từ vựng HSK 1:', hsk1Count)

  // 2. Kiểm tra HSK 2 đạt bao nhiêu từ
  const { count: hsk2Count } = await supabase
    .from('vocabularies')
    .select('id', { count: 'exact', head: true })
    .eq('hsk_level', 'HSK 2')
  console.log('2. Số từ vựng HSK 2:', hsk2Count)

  // 3. Kiểm tra HSK 3
  const { count: hsk3Count } = await supabase
    .from('vocabularies')
    .select('id', { count: 'exact', head: true })
    .eq('hsk_level', 'HSK 3')
  console.log('3. Số từ vựng HSK 3:', hsk3Count)

  // 4. Tổng số câu ví dụ trong vocabulary_examples
  const { count: exCount } = await supabase
    .from('vocabulary_examples')
    .select('id', { count: 'exact', head: true })
  console.log('4. Tổng số câu ví dụ trong vocabulary_examples:', exCount)

  // 5. Kiểm tra từ '点' trong cả HSK 1 và HSK 2
  const { data: dianWords } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level')
    .eq('hanzi', '点')
  console.log('\n5. Kiểm tra từ "点":')
  console.log(dianWords)

  // 6. Mẫu các từ HSK 2 mới
  const { data: sampleHsk2 } = await supabase
    .from('vocabularies')
    .select('hanzi, pinyin, meaning_vi, word_type, hsk_level')
    .eq('hsk_level', 'HSK 2')
    .in('hanzi', ['爱好', '白色', '地铁', '奶奶', '足球'])
  console.log('\n6. Mẫu từ HSK 2:')
  console.log(sampleHsk2)

  // 7. Lấy câu ví dụ của '爱好'
  const { data: aihao } = await supabase
    .from('vocabularies')
    .select('id')
    .eq('hsk_level', 'HSK 2')
    .eq('hanzi', '爱好')

  if (aihao && aihao.length > 0) {
    const { data: aihaoEx } = await supabase
      .from('vocabulary_examples')
      .select('chinese, pinyin, meaning_vi, difficulty_level, order_index')
      .eq('vocabulary_id', aihao[0].id)
      .order('order_index', { ascending: true })

    console.log('\n7. Câu ví dụ của "爱好":', aihaoEx)
  }
}

checkAfterHsk2Migration()
