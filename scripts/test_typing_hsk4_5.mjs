import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function testLevel(hskLevel) {
  const hskTag = `HSK ${hskLevel}`;
  let query = supabase
    .from('vocabulary_examples')
    .select(`
      id,
      chinese,
      pinyin,
      meaning_vi,
      difficulty_level,
      order_index,
      vocabularies!inner(
        id,
        hanzi,
        pinyin,
        meaning_vi,
        hsk_level
      )
    `)
    .eq('vocabularies.hsk_level', hskTag)
    .order('order_index', { ascending: true })
    .limit(20);

  const { data: exData } = await query;
  let exercises = [];
  if (exData && exData.length > 0) {
    exercises = exData.map(r => ({
      hanzi: r.chinese,
      pinyin: r.pinyin,
      meaning: r.meaning_vi,
      vocabHanzi: r.vocabularies.hanzi
    }));
  }

  if (exercises.length < 20) {
    const existingIds = new Set(exercises.map(e => e.vocabHanzi));
    const { data: fallback } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, example_hanzi, example_pinyin, example_vi')
      .eq('hsk_level', hskTag)
      .not('example_hanzi', 'is', null)
      .limit(40);

    if (fallback) {
      for (const f of fallback) {
        if (!f.example_hanzi || existingIds.has(f.hanzi)) continue;
        exercises.push({
          hanzi: f.example_hanzi,
          pinyin: f.example_pinyin,
          meaning: f.example_vi,
          vocabHanzi: f.hanzi
        });
        existingIds.add(f.hanzi);
        if (exercises.length >= 20) break;
      }
    }
  }

  console.log(`[${hskTag}] Lấy được ${exercises.length} bài luyện gõ mẫu.`);
  if (exercises.length > 0) {
    console.log(`  Câu 1: ${exercises[0].hanzi} (${exercises[0].vocabHanzi}) - ${exercises[0].meaning}`);
    console.log(`  Câu 2: ${exercises[1]?.hanzi} (${exercises[1]?.vocabHanzi}) - ${exercises[1]?.meaning}`);
  }
}

async function run() {
  console.log('=== TEST TRUY VẤN LUYỆN GÕ CHO HSK 4 VÀ HSK 5 ===\n');
  await testLevel(4);
  await testLevel(5);
}
run();
