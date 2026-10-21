import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function main() {
  console.log('=== PHÂN TÍCH TOÀN BỘ TỪ VỰNG HSK 5 TRONG SUPABASE ===')

  let allHsk5 = []
  let from = 0
  const pageSize = 1000
  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_version, created_at')
      .eq('hsk_level', 'HSK 5')
      .range(from, from + pageSize - 1)
      .order('id')

    if (error) {
      console.error('Lỗi truy vấn:', error)
      return
    }
    allHsk5 = allHsk5.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  console.log(`Tổng số bản ghi HSK 5: ${allHsk5.length}`)

  const hsk2_0 = allHsk5.filter(v => v.hsk_version === 'hsk2.0')
  const hsk3_0 = allHsk5.filter(v => v.hsk_version !== 'hsk2.0')

  console.log(`- hsk2.0 count: ${hsk2_0.length}`)
  console.log(`- hsk3.0 (hoặc khác) count: ${hsk3_0.length}`)

  // Lưu toàn bộ ra file scratch
  fs.mkdirSync('scratch', { recursive: true })
  fs.writeFileSync('scratch/hsk5_all_raw.json', JSON.stringify(allHsk5, null, 2))
  fs.writeFileSync('scratch/hsk5_hsk2_0.json', JSON.stringify(hsk2_0, null, 2))
  fs.writeFileSync('scratch/hsk5_hsk3_0.json', JSON.stringify(hsk3_0, null, 2))

  // In ra 20 từ đầu tiên của hsk3_0
  console.log('\n20 từ đầu tiên hsk3.0:')
  hsk3_0.slice(0, 20).forEach((w, i) => {
    console.log(`${i + 1}. ${w.hanzi} (${w.pinyin}): ${w.meaning_vi}`)
  })

  // In ra các từ hsk2.0
  console.log('\nCác từ hsk2.0:')
  hsk2_0.forEach((w, i) => {
    console.log(`${i + 1}. ${w.hanzi} (${w.pinyin}): ${w.meaning_vi}`)
  })
}

main()
