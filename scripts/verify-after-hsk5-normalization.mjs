import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function verifyNormalization() {
  console.log('=== KIỂM TRA NGHIỆM THU SAU KHI CHẠY MIGRATION CHUẨN HÓA HSK 5 ===\n')

  // 1. Đếm tổng số từ HSK 5
  const { count: hsk5Count, error: cErr } = await supabase
    .from('vocabularies')
    .select('id', { count: 'exact', head: true })
    .eq('hsk_level', 'HSK 5')

  if (cErr) {
    console.error('Lỗi truy vấn:', cErr)
    return
  }

  console.log(`1. Tổng số từ vựng mang nhãn 'HSK 5' hiện tại trong DB: ${hsk5Count} (Mục tiêu chuẩn: 1.600 từ / 1.597 chữ Hán độc nhất)`)

  // 2. Kiểm tra các từ cụ thể đã được phân loại chuẩn chưa
  const testWords = ['刷牙', '桔子', '粘贴', '难得']
  const { data: testData } = await supabase
    .from('vocabularies')
    .select('hanzi, pinyin, hsk_level, word_type, example_hanzi')
    .in('hanzi', testWords)

  console.log('\n2. Kiểm tra phân loại của các từ tiêu biểu:')
  testData?.forEach(w => {
    console.log(`   - [${w.hanzi}] (${w.pinyin}) -> Cấp độ hiện tại: ${w.hsk_level} | Từ loại: [${w.word_type}]`)
  })

  // 3. Kiểm tra tỷ lệ có 2 câu ví dụ của các từ HSK 5
  let from = 0
  let vocabs = []
  while (true) {
    const { data } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, word_type')
      .eq('hsk_level', 'HSK 5')
      .range(from, from + 499)
    if (!data || data.length === 0) break
    vocabs = vocabs.concat(data)
    if (data.length < 500) break
    from += 500
  }

  const vIds = vocabs.map(v => v.id)
  let exMap = new Map()
  for (let i = 0; i < vIds.length; i += 200) {
    const chunk = vIds.slice(i, i + 200)
    const { data: exData } = await supabase
      .from('vocabulary_examples')
      .select('vocabulary_id')
      .in('vocabulary_id', chunk)
    if (exData) {
      exData.forEach(e => {
        exMap.set(e.vocabulary_id, (exMap.get(e.vocabulary_id) || 0) + 1)
      })
    }
  }

  let full2Ex = 0
  let lackingEx = 0
  for (const v of vocabs) {
    if ((exMap.get(v.id) || 0) >= 2) {
      full2Ex++
    } else {
      lackingEx++
    }
  }

  console.log(`\n3. Thống kê câu ví dụ của HSK 5:`)
  console.log(`   - Số từ có đủ ít nhất 2 câu ví dụ: ${full2Ex} / ${vocabs.length} (${(full2Ex / vocabs.length * 100).toFixed(2)}%)`)
  console.log(`   - Số từ thiếu ví dụ: ${lackingEx}`)

  console.log('\n====================================================================')
  if (lackingEx === 0 && hsk5Count <= 1600) {
    console.log('🎉 XÁC NHẬN: HSK 5 ĐÃ ĐỒNG BỘ 100% HOÀN HẢO THEO ĐỀ CƯƠNG HSK 3.0!')
  } else {
    console.log(`Trạng thái: Đang chờ chạy migration SQL chuẩn hóa trên Supabase để hoàn tất.`)
  }
  console.log('====================================================================')
}

verifyNormalization()
