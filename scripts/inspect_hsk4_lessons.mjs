import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function check() {
  const { data: lessons } = await supabase
    .from('lessons')
    .select('id, lesson_number, title, subtitle, is_system')
    .eq('hsk_level', 'HSK 4')
    .eq('is_system', true)
    .order('lesson_number', { ascending: true });

  const { data: links } = await supabase
    .from('lesson_vocabularies')
    .select('lesson_id, vocabulary_id');

  const countByLesson = {};
  links.forEach(l => {
    countByLesson[l.lesson_id] = (countByLesson[l.lesson_id] || 0) + 1;
  });

  lessons.forEach(l => {
    console.log(`Bài ${l.lesson_number}: ${l.title} - ${l.subtitle || ''} (hiện có: ${countByLesson[l.id] || 0} từ) [id: ${l.id}]`);
  });
}
check();
