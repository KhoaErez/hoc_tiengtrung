import { createClient } from '@supabase/supabase-js'
import { HSK3_BATCH1_EXAMPLES } from '../data/hsk3-batch1-examples-data'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function testBatch1Matches() {
  console.log('Testing 80 words against Database...')
  let matched = 0
  const unmatched = []

  for (const item of HSK3_BATCH1_EXAMPLES) {
    const { data } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin')
      .eq('hsk_level', 'HSK 3')
      .eq('hanzi', item.hanzi)
      .eq('pinyin', item.pinyin)
      .limit(1)

    if (data && data.length > 0) {
      matched++
    } else {
      // Check if matching by hanzi only
      const { data: byHanzi } = await supabase
        .from('vocabularies')
        .select('id, hanzi, pinyin')
        .eq('hsk_level', 'HSK 3')
        .eq('hanzi', item.hanzi)

      unmatched.push({ item, dbRows: byHanzi })
    }
  }

  console.log(`Matched: ${matched} / ${HSK3_BATCH1_EXAMPLES.length}`)
  if (unmatched.length > 0) {
    console.log('Unmatched items:')
    console.log(JSON.stringify(unmatched, null, 2))
  }
}

testBatch1Matches()
