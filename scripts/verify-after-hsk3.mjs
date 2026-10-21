import { createClient } from '@supabase/supabase-js'
import fs from 'fs'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function verifyHsk3() {
  console.log('=== KIỂM TRA XÁC THỰC CƠ SỞ DỮ LIỆU SAU MIGRATION HSK 3 ===\n')

  // 1. Kiểm tra số lượng từ từng cấp HSK
  const { data: hsk1, count: countHsk1 } = await supabase.from('vocabularies').select('id', { count: 'exact' }).eq('hsk_level', 'HSK 1')
  const { data: hsk2, count: countHsk2 } = await supabase.from('vocabularies').select('id', { count: 'exact' }).eq('hsk_level', 'HSK 2')
  const { data: hsk3, count: countHsk3 } = await supabase.from('vocabularies').select('id, hanzi, pinyin, word_type, meaning_vi', { count: 'exact' }).eq('hsk_level', 'HSK 3')
  const { data: hsk4, count: countHsk4 } = await supabase.from('vocabularies').select('id', { count: 'exact' }).eq('hsk_level', 'HSK 4')

  console.log(`1. Tổng số từ HSK 1: ${countHsk1} (Chuẩn: 300 từ)`)
  console.log(`2. Tổng số từ HSK 2: ${countHsk2} (Chuẩn: 200 từ)`)
  console.log(`3. Tổng số từ HSK 3: ${countHsk3} (Chuẩn: 500 từ)`)
  console.log(`4. Tổng số từ HSK 4: ${countHsk4}`)

  // 2. Kiểm tra tính duy nhất trong HSK 3
  const hanziMap = new Map()
  const duplicates = []
  for (const w of (hsk3 || [])) {
    if (hanziMap.has(w.hanzi)) {
      duplicates.push({ hanzi: w.hanzi, first: hanziMap.get(w.hanzi), second: w })
    }
    hanziMap.set(w.hanzi, w)
  }

  console.log(`5. Số lượng chữ Hán độc lập trong HSK 3: ${hanziMap.size}`)
  console.log(`6. Số bản ghi trùng lặp: ${duplicates.length}`)
  if (duplicates.length > 0) {
    console.log('   Trùng lặp:', duplicates)
  }

  // 3. Đối chiếu với 500 từ chuẩn đề cương HSK 3.0
  const official500 = JSON.parse(fs.readFileSync('scratch/hsk3_official_500_raw.json', 'utf8'))
  const officialSet = new Set(official500.map(w => w.hanzi.trim()))

  let matchedOfficial = 0
  const missingFromOfficial = []
  for (const off of official500) {
    if (hanziMap.has(off.hanzi.trim())) {
      matchedOfficial++
    } else {
      missingFromOfficial.push(off)
    }
  }

  console.log(`7. Khớp danh mục 500 từ chuẩn HSK 3.0: ${matchedOfficial} / 500`)
  if (missingFromOfficial.length > 0) {
    console.log(`   Còn thiếu ${missingFromOfficial.length} từ:`, missingFromOfficial.slice(0, 5))
  }

  // 4. Kiểm tra ví dụ trong bảng vocabulary_examples cho HSK 3
  const hsk3Ids = (hsk3 || []).map(w => w.id)
  const { data: examples, count: countExamples } = await supabase
    .from('vocabulary_examples')
    .select('id, vocabulary_id', { count: 'exact' })
    .in('vocabulary_id', hsk3Ids)

  console.log(`8. Tổng số câu ví dụ trong vocabulary_examples thuộc HSK 3: ${countExamples}`)

  // 5. Tổng số câu ví dụ trên toàn hệ thống
  const { count: totalExamples } = await supabase
    .from('vocabulary_examples')
    .select('id', { count: 'exact', head: true })

  console.log(`9. Tổng số câu ví dụ trên toàn hệ thống database: ${totalExamples}`)
}

verifyHsk3()
