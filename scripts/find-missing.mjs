import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function findMissing() {
  const raw1600 = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
  const allHanzi = Array.from(new Set(raw1600.map(w => w.hanzi)))

  let foundHanzi = new Set()
  for (let i = 0; i < allHanzi.length; i += 100) {
    const chunk = allHanzi.slice(i, i + 100)
    const { data } = await supabase
      .from('vocabularies')
      .select('hanzi')
      .in('hanzi', chunk)
      .eq('hsk_level', 'HSK 5')
    if (data) {
      data.forEach(d => foundHanzi.add(d.hanzi))
    }
  }

  const missing = raw1600.filter(w => !foundHanzi.has(w.hanzi))
  console.log('Các mục chưa mang nhãn HSK 5:', missing)
}

findMissing()
