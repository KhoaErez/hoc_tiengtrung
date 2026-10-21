import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function auditHsk2() {
  console.log('=== AUDIT THỰC TRẠNG HSK 2 TRONG SUPABASE ===\n')

  const { data: hsk2Vocabs, count, error } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, example_hanzi, example_pinyin, example_vi', { count: 'exact' })
    .eq('hsk_level', 'HSK 2')

  console.log('1. Tổng số từ có hsk_level = "HSK 2":', count, error || '')

  if (hsk2Vocabs) {
    const withExample = hsk2Vocabs.filter(v => v.example_hanzi)
    const withWordType = hsk2Vocabs.filter(v => v.word_type && v.word_type.trim())
    console.log('2. Số từ có example_hanzi:', withExample.length)
    console.log('3. Số từ có word_type:', withWordType.length)
    console.log('4. Lấy mẫu 5 từ HSK 2 hiện có:')
    console.log(hsk2Vocabs.slice(0, 5))

    // Kiểm tra trùng lặp
    const seen = new Set()
    const duplicates = []
    for (const v of hsk2Vocabs) {
      const key = `${v.hanzi}_${v.pinyin?.toLowerCase()}`
      if (seen.has(key)) duplicates.push(key)
      seen.add(key)
    }
    console.log('5. Số bản ghi trùng lặp trong HSK 2:', duplicates.length, duplicates)
  }
}

auditHsk2()
