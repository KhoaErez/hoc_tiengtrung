import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function findHsk3Dupe() {
  const { data: vocabs } = await supabase.from('vocabularies').select('id, hanzi, pinyin').eq('hsk_level', 'HSK 3')
  const mapVocab = new Map(vocabs.map(v => [v.id, v]))
  const vocabIds = vocabs.map(v => v.id)
  
  let examples = []
  for (let i = 0; i < vocabIds.length; i += 200) {
    const chunk = vocabIds.slice(i, i + 200)
    const { data } = await supabase.from('vocabulary_examples').select('id, vocabulary_id, chinese, pinyin, meaning_vi').in('vocabulary_id', chunk)
    examples = examples.concat(data)
  }

  const seen = new Map()
  for (const ex of examples) {
    if (seen.has(ex.chinese)) {
      const prev = seen.get(ex.chinese)
      const vPrev = mapVocab.get(prev.vocabulary_id)
      const vCurr = mapVocab.get(ex.vocabulary_id)
      console.log(`Tìm thấy câu trùng trong HSK 3:`)
      console.log(`- Câu: "${ex.chinese}"`)
      console.log(`  + Từ 1: [${vPrev.hanzi}] (${vPrev.pinyin})`)
      console.log(`  + Từ 2: [${vCurr.hanzi}] (${vCurr.pinyin})`)
    } else {
      seen.set(ex.chinese, ex)
    }
  }
}

findHsk3Dupe()
