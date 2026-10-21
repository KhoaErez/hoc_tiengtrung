import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import { HSK4_BATCH8_EXAMPLES } from '../data/hsk4-batch8-examples-data'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
)

async function findMissing() {
  const hanzis = HSK4_BATCH8_EXAMPLES.map(i => i.hanzi)
  const { data: vocabList, error } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, example_hanzi')
    .eq('hsk_level', 'HSK 4')
    .in('hanzi', hanzis)

  if (error) {
    console.error('Error fetching vocabularies:', error)
    return
  }

  console.log('Total items in HSK4_BATCH8_EXAMPLES:', HSK4_BATCH8_EXAMPLES.length)
  console.log('Total items found in vocabList:', vocabList?.length)

  const foundHanzi = new Set(vocabList?.map(v => v.hanzi) || [])
  for (const item of HSK4_BATCH8_EXAMPLES) {
    if (!foundHanzi.has(item.hanzi)) {
      console.log('Item NOT found in vocabularies by hanzi:', item.hanzi, item.pinyin)
    }
  }

  const vocabIds = vocabList.map(v => v.id)
  const { data: examples, error: exError } = await supabase
    .from('vocabulary_examples')
    .select('vocabulary_id')
    .in('vocabulary_id', vocabIds)

  if (exError) {
    console.error('Error fetching examples:', exError)
    return
  }

  const exCounts = new Map<string, number>()
  for (const ex of examples) {
    exCounts.set(ex.vocabulary_id, (exCounts.get(ex.vocabulary_id) || 0) + 1)
  }

  for (const v of vocabList) {
    const count = exCounts.get(v.id) || 0
    if (count < 2) {
      console.log('Missing/incomplete word:', v.hanzi, `(${v.pinyin})`, 'id:', v.id, 'count:', count, 'example_hanzi:', v.example_hanzi)
    }
  }
}

findMissing()
