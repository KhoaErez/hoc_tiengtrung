import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function checkMissing() {
  const batch9Words = JSON.parse(fs.readFileSync('scratch/batch9_words.json', 'utf8'))
  
  const { data: hsk4Vocabs } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin')
    .eq('hsk_level', 'HSK 4')

  const { data: examples } = await supabase
    .from('vocabulary_examples')
    .select('vocabulary_id')

  const exSet = new Set(examples.map(e => e.vocabulary_id))

  const missing = []
  for (const w of batch9Words) {
    // Find matching vocab in DB
    const match = hsk4Vocabs.find(v => v.hanzi === w.hanzi)
    if (!match) {
      missing.push({ ...w, reason: 'Không tìm thấy hanzi trong DB' })
    } else if (!exSet.has(match.id)) {
      missing.push({ ...w, db_id: match.id, db_pinyin: match.pinyin, reason: 'Chưa có ví dụ trong DB' })
    }
  }

  console.log('Các từ trong Batch 9 chưa có ví dụ:', missing)
}

checkMissing()
