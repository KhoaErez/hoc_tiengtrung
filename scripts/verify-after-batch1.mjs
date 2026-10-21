import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function verifyBatch1() {
  console.log('=== KIỂM TRA DATABASE SAU KHI CHẠY BATCH 1 ===\n')

  // 1. Kiểm tra Page 1
  const { data: page1 } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, word_type, meaning_vi')
    .eq('hsk_level', 'HSK 3')
    .order('hanzi', { ascending: true })
    .range(0, 29)

  const page1Ids = (page1 || []).map(w => w.id)
  const { data: page1Examples } = await supabase
    .from('vocabulary_examples')
    .select('vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level')
    .in('vocabulary_id', page1Ids)

  const exMap = new Map()
  for (const ex of (page1Examples || [])) {
    const list = exMap.get(ex.vocabulary_id) || []
    list.push(ex)
    exMap.set(ex.vocabulary_id, list)
  }

  let page1Complete = 0
  for (const w of page1) {
    const count = (exMap.get(w.id) || []).length
    if (count >= 2) page1Complete++
  }

  console.log(`1. Kết quả Trang 1 (30 từ đầu): ${page1Complete} / 30 từ đã có ĐỦ 2 câu ví dụ!`)

  // 2. Kiểm tra mẫu từ '一共'
  const yigong = page1.find(w => w.hanzi === '一共')
  if (yigong) {
    const yigongEx = exMap.get(yigong.id) || []
    console.log(`\n2. Chi tiết từ [${yigong.hanzi}] (${yigong.pinyin}) | Từ loại: ${yigong.word_type}:`)
    yigongEx.forEach((ex, idx) => {
      console.log(`   Ví dụ ${idx + 1} (${ex.difficulty_level}): ${ex.chinese}`)
      console.log(`   Pinyin: ${ex.pinyin}`)
      console.log(`   Dịch:   ${ex.meaning_vi}`)
    })
  }

  // 3. Kiểm tra toàn bộ HSK 3
  const { data: allHsk3 } = await supabase.from('vocabularies').select('id').eq('hsk_level', 'HSK 3')
  const allIds = (allHsk3 || []).map(w => w.id)

  const allEx = []
  for (let i = 0; i < allIds.length; i += 100) {
    const chunk = allIds.slice(i, i + 100)
    const { data: exChunk } = await supabase.from('vocabulary_examples').select('vocabulary_id').in('vocabulary_id', chunk)
    if (exChunk) allEx.push(...exChunk)
  }

  const exCountMap = new Map()
  for (const e of allEx) {
    exCountMap.set(e.vocabulary_id, (exCountMap.get(e.vocabulary_id) || 0) + 1)
  }

  let wordsWith2Plus = 0, wordsWith0 = 0
  for (const id of allIds) {
    const c = exCountMap.get(id) || 0
    if (c >= 2) wordsWith2Plus++
    else if (c === 0) wordsWith0++
  }

  console.log(`\n3. Thống kê toàn cấp HSK 3 sau Batch 1:`)
  console.log(`   - Số từ đã có ĐỦ 2 ví dụ: ${wordsWith2Plus} / 500 (${(wordsWith2Plus / 500 * 100).toFixed(1)}%)`)
  console.log(`   - Số từ còn thiếu ví dụ: ${wordsWith0} / 500`)
  console.log(`   - Tổng số câu ví dụ HSK 3: ${allEx.length} câu`)
}

verifyBatch1()
