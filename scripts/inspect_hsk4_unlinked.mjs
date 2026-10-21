import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function check() {
  const { data: lessons } = await supabase
    .from('lessons')
    .select('id, lesson_number, title, subtitle')
    .eq('hsk_level', 'HSK 4')
    .eq('is_system', true)
    .order('lesson_number', { ascending: true });

  let allVocabs = [];
  let from = 0;
  const pageSize = 1000;
  while(true) {
    const { data } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type')
      .eq('hsk_level', 'HSK 4')
      .range(from, from + pageSize - 1)
      .order('id');
    allVocabs = allVocabs.concat(data);
    if (data.length < pageSize) break;
    from += pageSize;
  }

  const sysLessonIds = lessons.map(l => l.id);
  const { data: links } = await supabase
    .from('lesson_vocabularies')
    .select('lesson_id, vocabulary_id')
    .in('lesson_id', sysLessonIds);

  const linkedMap = new Map();
  links.forEach(l => {
    if (!linkedMap.has(l.lesson_id)) linkedMap.set(l.lesson_id, []);
    linkedMap.get(l.lesson_id).push(l.vocabulary_id);
  });

  const linkedVocabIds = new Set(links.map(l => l.vocabulary_id));
  const unlinked = allVocabs.filter(v => !linkedVocabIds.has(v.id));

  console.log(`HSK 4 Vocabs: ${allVocabs.length}`);
  console.log(`Unlinked: ${unlinked.length}`);
  console.log('Sample unlinked words (first 20):');
  unlinked.slice(0, 20).forEach(v => console.log(`${v.hanzi} (${v.pinyin}): ${v.meaning_vi}`));
}
check();
