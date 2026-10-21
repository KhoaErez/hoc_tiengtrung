import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function check() {
  const { data: lessons } = await supabase
    .from('lessons')
    .select('id, lesson_number, title')
    .eq('hsk_level', 'HSK 5')
    .eq('is_system', true)
    .order('lesson_number', { ascending: true });

  const lessonIds = lessons.map(l => l.id);
  const chunkSize = 500;
  let allLinks = [];
  for (let i = 0; i < lessonIds.length; i += chunkSize) {
    const chunk = lessonIds.slice(i, i + chunkSize);
    const { data: links } = await supabase
      .from('lesson_vocabularies')
      .select('lesson_id, vocabulary_id')
      .in('lesson_id', chunk);
    if (links) allLinks = allLinks.concat(links);
  }

  const countByLesson = {};
  allLinks.forEach(l => {
    countByLesson[l.lesson_id] = (countByLesson[l.lesson_id] || 0) + 1;
  });

  console.log('Total links in HSK 5 system lessons:', allLinks.length);
  const counts = lessons.map(l => countByLesson[l.id] || 0);
  console.log('Min words in a lesson:', Math.min(...counts), 'Max words in a lesson:', Math.max(...counts));
  console.log('Sample lesson counts (first 10):', counts.slice(0, 10));
  console.log('Sample lesson counts (last 10):', counts.slice(-10));
}
check();
