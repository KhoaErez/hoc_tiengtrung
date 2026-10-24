import fs from 'fs';
import { BATCH4_PART1_DATA } from './data_batch4_part1.mjs';
import { BATCH4_PART2_DATA } from './data_batch4_part2.mjs';
import { BATCH4_PART3_DATA } from './data_batch4_part3.mjs';

function escapeSql(str) {
  if (!str) return "''";
  return `'${str.replace(/'/g, "''")}'`;
}

// 1. Tải danh sách 186 từ vựng Đợt 4 từ CSDL thực tế (có ID)
const batchWords = JSON.parse(fs.readFileSync('scripts/batch4_words.json', 'utf8'));
const allGenerated = [...BATCH4_PART1_DATA, ...BATCH4_PART2_DATA, ...BATCH4_PART3_DATA];

console.log(`Đang xác thực ${allGenerated.length} câu ví dụ HSK 6 Đợt 4 với ${batchWords.length} từ trong DB...`);

if (allGenerated.length !== batchWords.length) {
  console.error(`Số lượng không khớp! Sinh ra: ${allGenerated.length}, Cần: ${batchWords.length}`);
  process.exit(1);
}

// Map tra cứu theo Hanzi
const genMap = new Map();
for (const item of allGenerated) {
  genMap.set(item.hanzi, item);
}

// Kiểm tra chất lượng và ánh xạ với DB ID
const validatedItems = [];
const errors = [];

for (let i = 0; i < batchWords.length; i++) {
  const dbWord = batchWords[i];
  const gen = genMap.get(dbWord.hanzi);

  if (!gen) {
    errors.push(`Thiếu câu ví dụ cho từ #${i + 1}: ${dbWord.hanzi} (${dbWord.pinyin})`);
    continue;
  }

  // Kiểm tra câu chứa từ khóa
  if (!gen.example_hanzi.includes(dbWord.hanzi)) {
    errors.push(`Câu ví dụ cho "${dbWord.hanzi}" KHÔNG chứa chữ Hán mục tiêu: "${gen.example_hanzi}"`);
  }

  // Kiểm tra độ dài câu
  if (gen.example_hanzi.length < 10 || gen.example_hanzi.length > 70) {
    errors.push(`Độ dài câu "${dbWord.hanzi}" không hợp lệ (${gen.example_hanzi.length} ký tự): "${gen.example_hanzi}"`);
  }

  // Kiểm tra Pinyin và tiếng Việt
  if (!gen.example_pinyin || gen.example_pinyin.length < 5) {
    errors.push(`Pinyin cho "${dbWord.hanzi}" quá ngắn hoặc thiếu`);
  }
  if (!gen.example_vi || gen.example_vi.length < 5) {
    errors.push(`Bản dịch tiếng Việt cho "${dbWord.hanzi}" quá ngắn hoặc thiếu`);
  }

  validatedItems.push({
    id: dbWord.id,
    hanzi: dbWord.hanzi,
    pinyin: dbWord.pinyin,
    meaning_vi: dbWord.meaning_vi,
    example_hanzi: gen.example_hanzi,
    example_pinyin: gen.example_pinyin,
    example_vi: gen.example_vi
  });
}

if (errors.length > 0) {
  console.error('Phát hiện các lỗi sau:');
  errors.forEach(e => console.error(' -', e));
  process.exit(1);
}

console.log(`Xác thực 100% thành công ${validatedItems.length} từ vựng HSK 6 Đợt 4!`);

// 2. Tạo file migration SQL
const migrationLines = [
  '-- ==============================================================================;',
  '-- MIGRATION: 20261024010000_hsk6_batch4_186_examples.sql;',
  '-- Nạp 186 câu ví dụ HSK 6 Đợt 4 (Q - X: 确立 -> 协调) vào vocabularies và vocabulary_examples;',
  '-- Chuẩn đề cương HSK 3.0 (CTI 11/2025), câu ví dụ văn cảnh hiện đại, Pinyin có dấu, dịch chuẩn nghĩa;',
  '-- ==============================================================================;',
  '',
  'BEGIN;',
  ''
];

// Cập nhật vocabularies theo ID và chèn vào vocabulary_examples
for (const item of validatedItems) {
  migrationLines.push(`-- [${item.hanzi}] (${item.pinyin}): ${item.meaning_vi}`);
  migrationLines.push(`UPDATE public.vocabularies`);
  migrationLines.push(`SET example_hanzi = ${escapeSql(item.example_hanzi)},`);
  migrationLines.push(`    example_pinyin = ${escapeSql(item.example_pinyin)},`);
  migrationLines.push(`    example_vi = ${escapeSql(item.example_vi)}`);
  migrationLines.push(`WHERE id = '${item.id}' AND hsk_level = 'HSK 6';`);
  migrationLines.push(``);
  migrationLines.push(`INSERT INTO public.vocabulary_examples (`);
  migrationLines.push(`  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index`);
  migrationLines.push(`)`);
  migrationLines.push(`SELECT`);
  migrationLines.push(`  gen_random_uuid(), '${item.id}', ${escapeSql(item.example_hanzi)}, ${escapeSql(item.example_pinyin)}, ${escapeSql(item.example_vi)}, 'standard', 1`);
  migrationLines.push(`WHERE NOT EXISTS (`);
  migrationLines.push(`  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '${item.id}'`);
  migrationLines.push(`);`);
  migrationLines.push(``);
}

migrationLines.push('COMMIT;');
migrationLines.push('');

const migrationPath = 'supabase/migrations/20261024010000_hsk6_batch4_186_examples.sql';
fs.writeFileSync(migrationPath, migrationLines.join('\n'), 'utf8');
console.log(`Đã tạo file migration: ${migrationPath}`);

// 3. Tạo file rollback SQL
const idList = validatedItems.map(i => `'${i.id}'`).join(',\n    ');
const rollbackLines = [
  '-- ==============================================================================;',
  '-- ROLLBACK: 20261024010000_hsk6_batch4_186_examples_rollback.sql;',
  '-- Hoàn tác nạp 186 câu ví dụ HSK 6 Đợt 4 (Q - X: 确立 -> 协调);',
  '-- ==============================================================================;',
  '',
  'BEGIN;',
  '',
  '-- 1. Xóa các bản ghi đã chèn trong vocabulary_examples',
  'DELETE FROM public.vocabulary_examples',
  `WHERE vocabulary_id IN (`,
  `    ${idList}`,
  `);`,
  '',
  '-- 2. Đặt lại example_hanzi/pinyin/vi về NULL trong vocabularies',
  'UPDATE public.vocabularies',
  'SET example_hanzi = NULL,',
  '    example_pinyin = NULL,',
  '    example_vi = NULL',
  `WHERE id IN (`,
  `    ${idList}`,
  `);`,
  '',
  'COMMIT;',
  ''
];

const rollbackPath = 'supabase/migrations/20261024010000_hsk6_batch4_186_examples_rollback.sql';
fs.writeFileSync(rollbackPath, rollbackLines.join('\n'), 'utf8');
console.log(`Đã tạo file rollback: ${rollbackPath}`);
