import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function check() {
  const words = ['刷牙', '桔子', '粘贴', '难得'];
  const { data } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi')
    .in('hanzi', words);

  console.log('Words found:', JSON.stringify(data, null, 2));

  for (const w of data || []) {
    const { data: exs } = await supabase.from('vocabulary_examples').select('*').eq('vocabulary_id', w.id);
    console.log(`Examples in table for ${w.hanzi} (${w.hsk_level}):`, exs?.length);
  }
}
check();
