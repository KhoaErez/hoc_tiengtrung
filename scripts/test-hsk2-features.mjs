import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function testHsk2Features() {
  console.log('=== KIỂM THỬ TÍNH NĂNG HSK 2 ===\n')

  // 1. Phân trang
  const { data: page1, count: totalCount } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level', { count: 'exact' })
    .eq('hsk_level', 'HSK 2')
    .order('id', { ascending: true })
    .range(0, 29)

  console.log('1. Phân trang trang 1:')
  console.log('- Số lượng mục từ trang 1:', page1.length)
  console.log('- Tổng số mục từ HSK 2:', totalCount)
  console.log('- Số trang (30 từ/trang):', Math.ceil(totalCount / 30))

  // 2. Tìm kiếm 'trà sữa'
  const { data: resTea } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type')
    .eq('hsk_level', 'HSK 2')
    .or('hanzi.ilike.%trà sữa%,meaning_vi.ilike.%trà sữa%')

  console.log('\n2. Tìm kiếm "trà sữa":', resTea)

  // 3. Tìm kiếm 'gọi món' (từ '点' HSK 2)
  const { data: resDian } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level')
    .eq('hsk_level', 'HSK 2')
    .or('hanzi.ilike.%gọi món%,meaning_vi.ilike.%gọi món%')

  console.log('\n3. Tìm kiếm động từ "gọi món" (点):', resDian)

  // 4. Lấy ví dụ của '点' HSK 2
  if (resDian && resDian.length > 0) {
    const { data: exDian } = await supabase
      .from('vocabulary_examples')
      .select('chinese, pinyin, meaning_vi, difficulty_level, order_index')
      .eq('vocabulary_id', resDian[0].id)
      .order('order_index', { ascending: true })

    console.log('\n4. Câu ví dụ của động từ "点":', exDian)
  }
}

testHsk2Features()
