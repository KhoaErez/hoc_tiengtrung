import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function run() {
  console.log('=== ĐỐI SOÁT VÀ PHÂN BỔ 1.597 TỪ VỰNG HSK 5 VÀO 91 BÀI HỌC HỆ THỐNG ===\n');

  // 1. Lấy 91 bài học hệ thống HSK 5
  const { data: lessons, error: lErr } = await supabase
    .from('lessons')
    .select('id, lesson_number, title, subtitle')
    .eq('hsk_level', 'HSK 5')
    .eq('is_system', true)
    .order('lesson_number', { ascending: true });

  if (lErr || !lessons) {
    console.error('Lỗi khi lấy lessons:', lErr);
    return;
  }
  console.log(`Tìm thấy ${lessons.length} bài học hệ thống HSK 5.`);

  // 2. Lấy 1.597 từ vựng HSK 5
  let vocabs = [];
  let from = 0;
  const pageSize = 1000;
  while(true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type')
      .eq('hsk_level', 'HSK 5')
      .range(from, from + pageSize - 1)
      .order('id');
    if (error) {
      console.error('Lỗi khi lấy vocabularies:', error);
      return;
    }
    vocabs = vocabs.concat(data);
    if (data.length < pageSize) break;
    from += pageSize;
  }
  console.log(`Tìm thấy ${vocabs.length} từ vựng HSK 5 trong DB.`);

  // 3. Lấy liên kết hiện có
  const lessonIds = lessons.map(l => l.id);
  const chunkSize = 500;
  let existingLinks = [];
  for (let i = 0; i < lessonIds.length; i += chunkSize) {
    const chunk = lessonIds.slice(i, i + chunkSize);
    const { data: links, error: linkErr } = await supabase
      .from('lesson_vocabularies')
      .select('lesson_id, vocabulary_id')
      .in('lesson_id', chunk);
    if (linkErr) {
      console.error('Lỗi khi lấy lesson_vocabularies:', linkErr);
      return;
    }
    existingLinks = existingLinks.concat(links);
  }
  console.log(`Tìm thấy ${existingLinks.length} liên kết hiện có.`);

  const vocabById = new Map();
  vocabs.forEach(v => vocabById.set(v.id, v));

  const assignedVocabIds = new Set();
  const lessonVocabMap = new Map();
  lessons.forEach(l => lessonVocabMap.set(l.id, []));

  // Phân bổ mục tiêu: 50 bài đầu có 18 từ, 41 bài sau có 17 từ (50 * 18 + 41 * 17 = 900 + 697 = 1.597)
  const targetSizes = lessons.map((_, idx) => (idx < 50 ? 18 : 17));

  // Giữ lại các liên kết hiện có hợp lệ (nếu chưa vượt quá targetSize của bài đó)
  existingLinks.forEach(link => {
    if (vocabById.has(link.vocabulary_id) && lessonVocabMap.has(link.lesson_id)) {
      if (!assignedVocabIds.has(link.vocabulary_id)) {
        const currentList = lessonVocabMap.get(link.lesson_id);
        const lIndex = lessons.findIndex(l => l.id === link.lesson_id);
        const maxSize = targetSizes[lIndex];
        if (currentList.length < maxSize) {
          assignedVocabIds.add(link.vocabulary_id);
          currentList.push(vocabById.get(link.vocabulary_id));
        }
      }
    }
  });

  const unassigned = vocabs.filter(v => !assignedVocabIds.has(v.id));
  console.log(`Đã giữ lại ${assignedVocabIds.size} từ liên kết sẵn hợp lệ. Còn ${unassigned.length} từ cần phân bổ.`);

  // Xử lý các từ đa âm đặc biệt
  // '679fef1f-ed63-4fc6-90e9-2ff587e50b98': 合同 (hétong)
  // 'c8be22f8-729d-44c2-b28d-4fbbdcf84efa': 合同 (hétóng)
  // '62973f2c-9747-491e-86e7-7465330ce096': 处 (chǔ) - động từ
  // '7e351ea5-ec7b-4c65-a627-cf9fa1cbe96c': 处 (chù) - danh từ
  const polyAssignments = [
    { id: '679fef1f-ed63-4fc6-90e9-2ff587e50b98', lessonNum: 15 }, // 合同 hétong -> Bài 15 (Công sở và Doanh nghiệp)
    { id: '62973f2c-9747-491e-86e7-7465330ce096', lessonNum: 16 }, // 处 chǔ -> Bài 16 (Giao tiếp và Xã giao)
    { id: '7e351ea5-ec7b-4c65-a627-cf9fa1cbe96c', lessonNum: 2 },  // 处 chù -> Bài 2 (Nông thôn và Không gian cư trú)
  ];

  for (const pa of polyAssignments) {
    const v = unassigned.find(w => w.id === pa.id);
    if (v) {
      const targetLesson = lessons[pa.lessonNum - 1];
      const list = lessonVocabMap.get(targetLesson.id);
      const maxSize = targetSizes[pa.lessonNum - 1];
      if (list.length < maxSize) {
        list.push(v);
        assignedVocabIds.add(v.id);
      }
    }
  }

  const remaining = unassigned.filter(w => !assignedVocabIds.has(w.id));
  console.log(`Còn lại ${remaining.length} từ cần phân loại theo ngữ nghĩa vào các bài chưa đủ số lượng.`);

  // Hàm tính điểm liên quan ngữ nghĩa giữa từ vựng và bài học
  function scoreWordForLesson(v, lesson) {
    const wordText = `${v.hanzi} ${v.pinyin} ${v.meaning_vi || ''} ${v.word_type || ''}`.toLowerCase();
    const lessonText = `${lesson.title} ${lesson.subtitle || ''}`.toLowerCase();

    let score = 0;
    // Tách từ khóa từ title và subtitle bài học
    const keywords = lessonText
      .replace(/[^\p{L}\p{N}\s]/gu, ' ')
      .split(/\s+/)
      .filter(w => w.length >= 2 && !['bài', 'và', 'các', 'của', 'trong', 'về', 'giúp', 'cho'].includes(w));

    for (const kw of keywords) {
      if (wordText.includes(kw)) {
        score += 3;
      }
    }

    return score;
  }

  // Thuật toán phân bổ:
  // Duyệt qua từng từ còn lại, tìm bài học phù hợp nhất mà chưa chạm ngưỡng targetSize
  for (const v of remaining) {
    let bestLessonId = null;
    let bestScore = -1;
    let minCapacityRatio = 999;

    for (let i = 0; i < lessons.length; i++) {
      const l = lessons[i];
      const currentList = lessonVocabMap.get(l.id);
      const maxSize = targetSizes[i];

      if (currentList.length >= maxSize) continue; // Bài đã đủ số lượng

      const s = scoreWordForLesson(v, l);
      const capacityRatio = currentList.length / maxSize;

      // Ưu tiên độ tương đồng cao nhất, nếu bằng nhau thì ưu tiên bài đang có ít từ nhất
      if (s > bestScore || (s === bestScore && capacityRatio < minCapacityRatio)) {
        bestScore = s;
        bestLessonId = l.id;
        minCapacityRatio = capacityRatio;
      }
    }

    // Nếu không tìm thấy (lý thuyết không xảy ra), tìm bài bất kỳ còn chỗ
    if (!bestLessonId) {
      for (let i = 0; i < lessons.length; i++) {
        const l = lessons[i];
        if (lessonVocabMap.get(l.id).length < targetSizes[i]) {
          bestLessonId = l.id;
          break;
        }
      }
    }

    lessonVocabMap.get(bestLessonId).push(v);
    assignedVocabIds.add(v.id);
  }

  // 4. Kiểm tra nghiệm thu
  console.log('\n=== KẾT QUẢ PHÂN BỔ 91 BÀI HỌC HSK 5 ===');
  let totalLinked = 0;
  let allTargetMet = true;

  lessons.forEach((l, idx) => {
    const list = lessonVocabMap.get(l.id);
    totalLinked += list.length;
    const target = targetSizes[idx];
    if (list.length !== target) {
      allTargetMet = false;
      console.warn(`Bài ${l.lesson_number} lệch mục tiêu: ${list.length} / ${target}`);
    }
  });

  console.log(`\nTổng số từ đã phân bổ: ${totalLinked} / ${vocabs.length}`);
  console.log(`Trạng thái đồng đều 100%: ${allTargetMet ? 'ĐẠT (Mỗi bài chính xác 17 hoặc 18 từ)' : 'CẦN ĐIỀU CHỈNH'}`);
  console.log('Sample bài 1-5:');
  for (let i = 0; i < 5; i++) {
    const l = lessons[i];
    console.log(`Bài ${l.lesson_number} (${lessonVocabMap.get(l.id).length} từ): ${lessonVocabMap.get(l.id).slice(0, 5).map(v => v.hanzi).join(', ')}...`);
  }
  console.log('Sample bài 4 (trước đây có 0 từ):');
  const b4 = lessons[3];
  console.log(`Bài 4 (${lessonVocabMap.get(b4.id).length} từ): ${lessonVocabMap.get(b4.id).map(v => v.hanzi).join(', ')}`);

  // 5. Sinh migration SQL
  console.log('\nĐang sinh file migration SQL cho HSK 5...');
  let sql = `-- Migration: 20261022050000_hsk5_curriculum_reconciliation.sql
-- Mục đích: Đồng bộ 100% từ vựng HSK 5 (1.597 từ vựng HSK 3.0) vào 91 bài học hệ thống
-- Đảm bảo mỗi bài có chuẩn 17-18 từ, không bài nào bị bỏ trống, chuẩn hóa ngữ nghĩa và xử lý từ đa âm
-- Bảo toàn 100% tiến độ học của người dùng và các bài học cá nhân

BEGIN;

-- 1. Xóa các liên kết bài học hệ thống cũ của HSK 5 (giữ nguyên bài học do user tạo)
DELETE FROM public.lesson_vocabularies
WHERE lesson_id IN (
    SELECT id FROM public.lessons
    WHERE hsk_level = 'HSK 5' AND is_system = true
);

-- 2. Chèn 1.597 liên kết từ vựng chuẩn hóa vào 91 bài học hệ thống
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected) VALUES
`;

  const allTuples = [];
  lessons.forEach(l => {
    const list = lessonVocabMap.get(l.id);
    list.forEach((v, idx) => {
      allTuples.push({
        lessonId: l.id,
        vocabId: v.id,
        sortOrder: idx + 1,
        comment: `Bài ${l.lesson_number}: ${v.hanzi} (${v.pinyin})`
      });
    });
  });

  const lines = allTuples.map((t, idx) => {
    const isLast = idx === allTuples.length - 1;
    const comma = isLast ? '' : ',';
    return `  ('${t.lessonId}', '${t.vocabId}', ${t.sortOrder}, true)${comma} /* ${t.comment} */`;
  });

  sql += lines.join('\n');
  sql += `
ON CONFLICT (lesson_id, vocabulary_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  is_selected = EXCLUDED.is_selected;

COMMIT;
`;

  const migrationPath = 'supabase/migrations/20261022050000_hsk5_curriculum_reconciliation.sql';
  fs.writeFileSync(migrationPath, sql, 'utf8');
  console.log(`Đã ghi thành công file migration tại: ${migrationPath} (${(fs.statSync(migrationPath).size / 1024).toFixed(1)} KB)`);
}

run();
