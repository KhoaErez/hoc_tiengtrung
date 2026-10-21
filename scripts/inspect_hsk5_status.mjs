import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function check() {
  console.log('=== TOÀN CẢNH DỮ LIỆU HSK 5 TRÊN SUPABASE ===\n');

  // 1. Lessons
  const { data: lessons } = await supabase
    .from('lessons')
    .select('id, lesson_number, title, is_system')
    .eq('hsk_level', 'HSK 5')
    .order('lesson_number', { ascending: true });

  const sysLessons = lessons?.filter(l => l.is_system) || [];
  const customLessons = lessons?.filter(l => !l.is_system) || [];
  console.log(`Lessons HSK 5: Tổng = ${lessons?.length}, Hệ thống = ${sysLessons.length}, Tự tạo = ${customLessons.length}`);

  // 2. Vocabularies
  let allVocabs = [];
  let from = 0;
  const pageSize = 1000;
  while(true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, example_hanzi, example_pinyin, example_vi')
      .eq('hsk_level', 'HSK 5')
      .range(from, from + pageSize - 1)
      .order('id');
    if (error) {
      console.error('Lỗi lấy vocabularies HSK 5:', error);
      break;
    }
    allVocabs = allVocabs.concat(data);
    if (data.length < pageSize) break;
    from += pageSize;
  }
  console.log(`Tổng số từ vựng HSK 5 trong bảng vocabularies: ${allVocabs.length}`);

  // Check unique hanzi vs duplicates
  const hanziCounts = {};
  allVocabs.forEach(v => {
    hanziCounts[v.hanzi] = (hanziCounts[v.hanzi] || 0) + 1;
  });
  const dupes = Object.entries(hanziCounts).filter(([_, c]) => c > 1);
  console.log(`Số chữ Hán trùng/đa âm trong HSK 5: ${dupes.length}`);

  // Check inline examples
  const withInlineEx = allVocabs.filter(v => v.example_hanzi && v.example_hanzi.trim().length > 0);
  const withoutInlineEx = allVocabs.filter(v => !v.example_hanzi || v.example_hanzi.trim().length === 0);
  console.log(`Từ có example_hanzi trong vocabularies: ${withInlineEx.length}`);
  console.log(`Từ KHÔNG có example_hanzi: ${withoutInlineEx.length}`);

  // Check empty pinyin or meaning_vi
  const emptyPinyin = allVocabs.filter(v => !v.pinyin || v.pinyin.trim().length === 0);
  const emptyMeaning = allVocabs.filter(v => !v.meaning_vi || v.meaning_vi.trim().length === 0);
  console.log(`Từ thiếu Pinyin: ${emptyPinyin.length}`);
  console.log(`Từ thiếu Nghĩa tiếng Việt: ${emptyMeaning.length}`);

  // 3. Check vocabulary_examples table
  const vocabIds = allVocabs.map(v => v.id);
  // Batch check examples
  let totalLinkedExamples = 0;
  const chunkSize = 500;
  const vocabWithTableExamples = new Set();
  for (let i = 0; i < vocabIds.length; i += chunkSize) {
    const chunk = vocabIds.slice(i, i + chunkSize);
    const { data: exs } = await supabase
      .from('vocabulary_examples')
      .select('vocabulary_id')
      .in('vocabulary_id', chunk);
    if (exs) {
      totalLinkedExamples += exs.length;
      exs.forEach(e => vocabWithTableExamples.add(e.vocabulary_id));
    }
  }
  console.log(`Tổng số câu ví dụ trong bảng vocabulary_examples cho HSK 5: ${totalLinkedExamples}`);
  console.log(`Số từ có ít nhất 1 câu ví dụ trong vocabulary_examples: ${vocabWithTableExamples.size}`);

  const totalWithAnyExample = allVocabs.filter(v => (v.example_hanzi && v.example_hanzi.trim().length > 0) || vocabWithTableExamples.has(v.id));
  console.log(`Tổng số từ có ví dụ (bảng hoặc inline): ${totalWithAnyExample.length} / ${allVocabs.length}`);

  // 4. Check lesson_vocabularies for HSK 5
  const sysLessonIds = sysLessons.map(l => l.id);
  let totalLessonLinks = 0;
  const linkedVocabIds = new Set();
  for (let i = 0; i < sysLessonIds.length; i += chunkSize) {
    const chunk = sysLessonIds.slice(i, i + chunkSize);
    const { data: links } = await supabase
      .from('lesson_vocabularies')
      .select('lesson_id, vocabulary_id')
      .in('lesson_id', chunk);
    if (links) {
      totalLessonLinks += links.length;
      links.forEach(l => linkedVocabIds.add(l.vocabulary_id));
    }
  }
  console.log(`Tổng liên kết trong lesson_vocabularies cho bài học hệ thống HSK 5: ${totalLessonLinks}`);
  console.log(`Số từ vựng HSK 5 đã liên kết vào bài học: ${linkedVocabIds.size} / ${allVocabs.length}`);
  console.log(`Số từ vựng HSK 5 CHƯA liên kết vào bài học: ${allVocabs.length - linkedVocabIds.size}`);
}
check();
