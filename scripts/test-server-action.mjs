import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function testServerActionLogic() {
  console.log('=== TEST LOGIC TƯƠNG ĐƯƠNG SERVER ACTION ===\n')

  // Test 1: Page 1 with pageSize = 30
  const { data: page1, count: totalCount } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi', { count: 'exact' })
    .eq('hsk_level', 'HSK 1')
    .order('id', { ascending: true })
    .range(0, 29)

  console.log('Test 1 - Phân trang:')
  console.log('- Số mục từ trả về trang 1:', page1.length)
  console.log('- Tổng số từ HSK 1:', totalCount)
  console.log('- Số trang dự kiến (30 từ/trang):', Math.ceil(totalCount / 30))

  // Test 2: Tải ví dụ cho các từ trong page 1
  const vocabIds = page1.map(v => v.id)
  const { data: examples } = await supabase
    .from('vocabulary_examples')
    .select('id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index')
    .in('vocabulary_id', vocabIds)
    .order('order_index', { ascending: true })

  console.log('\nTest 2 - Tải câu ví dụ:')
  console.log('- Số lượng câu ví dụ lấy được cho các từ trang 1:', examples?.length || 0)

  // Test 3: Tìm kiếm từ khóa 'siêu thị'
  const { data: searchResults, count: searchCount } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type', { count: 'exact' })
    .eq('hsk_level', 'HSK 1')
    .or('hanzi.ilike.%siêu thị%,pinyin.ilike.%siêu thị%,meaning_vi.ilike.%siêu thị%')

  console.log('\nTest 3 - Tìm kiếm tiếng Việt "siêu thị":')
  console.log('- Số kết quả tìm thấy:', searchCount)
  console.log('- Kết quả:', searchResults)

  // Test 4: Tìm kiếm chữ Hán '唱'
  const { data: searchHanzi, count: countHanzi } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type', { count: 'exact' })
    .eq('hsk_level', 'HSK 1')
    .or('hanzi.ilike.%唱%,pinyin.ilike.%唱%,meaning_vi.ilike.%唱%')

  console.log('\nTest 4 - Tìm kiếm chữ Hán "唱":')
  console.log('- Số kết quả tìm thấy:', countHanzi)
  console.log('- Kết quả:', searchHanzi)

  // Test 5: Lấy từ '超市' và các ví dụ của nó
  if (searchResults && searchResults.length > 0) {
    const csId = searchResults[0].id
    const { data: csExamples } = await supabase
      .from('vocabulary_examples')
      .select('chinese, pinyin, meaning_vi, difficulty_level, order_index')
      .eq('vocabulary_id', csId)
      .order('order_index', { ascending: true })

    console.log('\nTest 5 - Ví dụ chi tiết của từ "超市":', csExamples)
  }
}

testServerActionLogic()
