import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function testPage1() {
  const { data: page1 } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, example_hanzi')
    .eq('hsk_level', 'HSK 3')
    .order('hanzi', { ascending: true })
    .range(0, 29)

  const ids = page1.map(w => w.id)
  const { data: examples } = await supabase
    .from('vocabulary_examples')
    .select('id, vocabulary_id')
    .in('vocabulary_id', ids)

  const exIds = new Set(examples?.map(e => e.vocabulary_id) || [])

  console.log('Page 1 (30 từ đầu tiên HSK 3 khi hiển thị theo mặc định):')
  let hasEx = 0, noEx = 0
  for (const w of page1) {
    const ok = exIds.has(w.id)
    if (ok) hasEx++
    else noEx++
    console.log(`- [${w.hanzi}] (${w.pinyin}): ${ok ? ' ĐỦ 2 VÍ DỤ' : '❌ CHƯA CÓ VÍ DỤ'}`)
  }
  console.log(`\nTổng kết Trang 1: ${hasEx} từ có ví dụ, ${noEx} từ CHƯA CÓ VÍ DỤ`)
}

testPage1()
