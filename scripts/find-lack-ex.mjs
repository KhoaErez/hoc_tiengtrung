import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function findVocabWithout2Ex() {
  const raw1600 = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
  const allHanzi = Array.from(new Set(raw1600.map(w => w.hanzi)))

  let dbVocabs = []
  for (let i = 0; i < allHanzi.length; i += 100) {
    const chunk = allHanzi.slice(i, i + 100)
    const { data } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type')
      .in('hanzi', chunk)
      .eq('hsk_level', 'HSK 5')
    if (data) dbVocabs = dbVocabs.concat(data)
  }

  const vocabIds = dbVocabs.map(v => v.id)
  let vocabExampleMap = new Map()

  for (let i = 0; i < vocabIds.length; i += 200) {
    const chunk = vocabIds.slice(i, i + 200)
    const { data: exData } = await supabase
      .from('vocabulary_examples')
      .select('vocabulary_id')
      .in('vocabulary_id', chunk)

    if (exData) {
      for (const ex of exData) {
        vocabExampleMap.set(ex.vocabulary_id, (vocabExampleMap.get(ex.vocabulary_id) || 0) + 1)
      }
    }
  }

  const lacking = dbVocabs.filter(v => (vocabExampleMap.get(v.id) || 0) < 2)
  console.log('Các từ có ít hơn 2 câu ví dụ:', lacking.map(l => ({
    hanzi: l.hanzi,
    pinyin: l.pinyin,
    count: vocabExampleMap.get(l.id) || 0
  })))
}

findVocabWithout2Ex()
