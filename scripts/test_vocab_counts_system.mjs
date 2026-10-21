import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase env vars')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseKey)

const levels = [
  'HSK 1',
  'HSK 2',
  'HSK 3',
  'HSK 4',
  'HSK 5',
  'HSK 6',
  'HSK 7-9',
  'Giao tiếp',
  'Công xưởng',
]

async function run() {
  console.log('--- ĐỐI SOÁT TRỰC TIẾP TỪ SUPABASE (HEAD COUNT EXACT) ---')
  const results = {}
  for (const lvl of levels) {
    const { count, error } = await supabase
      .from('vocabularies')
      .select('*', { count: 'exact', head: true })
      .eq('hsk_level', lvl)

    if (error) {
      console.error(`Lỗi đếm ${lvl}:`, error)
      results[lvl] = null
    } else {
      results[lvl] = count
    }
  }

  console.table(results)

  // Kiểm tra bài học hệ thống tương ứng
  console.log('\n--- ĐỐI SOÁT BÀI HỌC HỆ THỐNG ---')
  for (const lvl of levels) {
    const { count, error } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true })
      .eq('is_system', true)
      .eq('hsk_level', lvl)

    console.log(`${lvl}: ${count ?? 0} bài học hệ thống (Lỗi: ${error ? error.message : 'None'})`)
  }
}

run()
