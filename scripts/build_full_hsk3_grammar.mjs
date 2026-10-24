import fs from 'fs';
import { HSK3_GRAMMAR_PART1 } from './data_hsk3_grammar_part1.mjs';
import { HSK3_GRAMMAR_PART2 } from './data_hsk3_grammar_part2.mjs';
import { HSK3_GRAMMAR_PART3 } from './data_hsk3_grammar_part3.mjs';

function escapeSql(str) {
  if (!str) return "''";
  return `'${str.replace(/'/g, "''")}'`;
}

const allPoints = [...HSK3_GRAMMAR_PART1, ...HSK3_GRAMMAR_PART2, ...HSK3_GRAMMAR_PART3];

console.log(`Đang kiểm tra và xác thực ${allPoints.length} điểm ngữ pháp HSK 3...`);

if (allPoints.length !== 79) {
  console.error(`Số lượng không đạt 79 điểm! Hiện có: ${allPoints.length}`);
  process.exit(1);
}

// 1. Kiểm tra tính liên tục và tính toàn vẹn của dữ liệu
const errors = [];
for (let i = 0; i < allPoints.length; i++) {
  const p = allPoints[i];
  const expectedIndex = i + 1;
  if (p.order_index !== expectedIndex) {
    errors.push(`Điểm thứ ${i}: order_index là ${p.order_index}, kỳ vọng ${expectedIndex}`);
  }
  if (!p.name || p.name.length < 3) errors.push(`Điểm #${p.order_index}: Tên không hợp lệ`);
  if (!p.pattern || p.pattern.length < 3) errors.push(`Điểm #${p.order_index}: Pattern không hợp lệ`);
  if (!p.category || p.category.length < 2) errors.push(`Điểm #${p.order_index}: Category không hợp lệ`);
  if (!p.explanation_vi || p.explanation_vi.length < 20) errors.push(`Điểm #${p.order_index}: Giải thích quá ngắn`);

  if (!Array.isArray(p.examples) || p.examples.length !== 2) {
    errors.push(`Điểm #${p.order_index}: Phải có đúng 2 câu ví dụ, hiện có ${p.examples?.length}`);
  } else {
    p.examples.forEach((ex, exIdx) => {
      if (!ex.chinese || ex.chinese.length < 5) errors.push(`Điểm #${p.order_index} ví dụ ${exIdx + 1}: Thiếu câu Hán tự`);
      if (!ex.pinyin || ex.pinyin.length < 5) errors.push(`Điểm #${p.order_index} ví dụ ${exIdx + 1}: Thiếu Pinyin`);
      if (!ex.translation_vi || ex.translation_vi.length < 5) errors.push(`Điểm #${p.order_index} ví dụ ${exIdx + 1}: Thiếu bản dịch TV`);
      if (!ex.explanation || ex.explanation.length < 5) errors.push(`Điểm #${p.order_index} ví dụ ${exIdx + 1}: Thiếu phân tích ngữ pháp`);
    });
  }
}

if (errors.length > 0) {
  console.error('Phát hiện các lỗi sau:');
  errors.forEach(e => console.error(' -', e));
  process.exit(1);
}

console.log(`Xác thực 100% thành công toàn bộ 79 điểm ngữ pháp HSK 3 kèm 158 câu ví dụ!`);

// 2. Tạo file migration SQL
const migrationLines = [
  '-- ==============================================================================',
  '-- MIGRATION: 20261024030000_hsk3_grammar_79_seed.sql',
  '-- NẠP 79 ĐIỂM NGỮ PHÁP HSK 3 KÈM 158 CÂU VÍ DỤ CHUẨN GF 0025-2021 (APPENDIX A)',
  '-- Có giải thích chi tiết tiếng Việt, công thức pattern, Pinyin có dấu thanh và phân loại chuẩn',
  '-- ==============================================================================',
  '',
  'BEGIN;',
  '',
  'DO $$',
  'DECLARE',
  '  v_gp_id uuid;'
];

migrationLines.push('BEGIN');
migrationLines.push('');

for (const p of allPoints) {
  migrationLines.push(`  -- Điểm ngữ pháp #${p.order_index}: ${p.name}`);
  migrationLines.push(`  INSERT INTO public.grammar_points (`);
  migrationLines.push(`    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status`);
  migrationLines.push(`  ) VALUES (`);
  migrationLines.push(`    ${escapeSql(p.name)},`);
  migrationLines.push(`    ${escapeSql(p.pattern)},`);
  migrationLines.push(`    ${escapeSql(p.category)},`);
  migrationLines.push(`    ${escapeSql(p.explanation_vi)},`);
  migrationLines.push(`    'HSK 3',`);
  migrationLines.push(`    ${p.order_index},`);
  migrationLines.push(`    'gf0025_2021',`);
  migrationLines.push(`    'verified'`);
  migrationLines.push(`  ) RETURNING id INTO v_gp_id;`);
  migrationLines.push('');
  migrationLines.push(`  INSERT INTO public.grammar_examples (`);
  migrationLines.push(`    grammar_point_id, chinese, pinyin, translation_vi, explanation`);
  migrationLines.push(`  ) VALUES`);
  migrationLines.push(`    (`);
  migrationLines.push(`      v_gp_id,`);
  migrationLines.push(`      ${escapeSql(p.examples[0].chinese)},`);
  migrationLines.push(`      ${escapeSql(p.examples[0].pinyin)},`);
  migrationLines.push(`      ${escapeSql(p.examples[0].translation_vi)},`);
  migrationLines.push(`      ${escapeSql(p.examples[0].explanation)}`);
  migrationLines.push(`    ),`);
  migrationLines.push(`    (`);
  migrationLines.push(`      v_gp_id,`);
  migrationLines.push(`      ${escapeSql(p.examples[1].chinese)},`);
  migrationLines.push(`      ${escapeSql(p.examples[1].pinyin)},`);
  migrationLines.push(`      ${escapeSql(p.examples[1].translation_vi)},`);
  migrationLines.push(`      ${escapeSql(p.examples[1].explanation)}`);
  migrationLines.push(`    );`);
  migrationLines.push('');
}

migrationLines.push('END $$;');
migrationLines.push('');
migrationLines.push('COMMIT;');
migrationLines.push('');

const migrationPath = 'supabase/migrations/20261024030000_hsk3_grammar_79_seed.sql';
fs.writeFileSync(migrationPath, migrationLines.join('\n'), 'utf8');
console.log(`Đã tạo file migration HSK 3: ${migrationPath}`);

// 3. Tạo file rollback SQL
const rollbackLines = [
  '-- ==============================================================================',
  '-- ROLLBACK: 20261024030000_hsk3_grammar_79_seed_rollback.sql',
  '-- Hoàn tác nạp 79 điểm ngữ pháp HSK 3 chuẩn GF 0025-2021',
  '-- ==============================================================================',
  '',
  'BEGIN;',
  '',
  '-- 1. Xóa các ví dụ ngữ pháp thuộc các điểm ngữ pháp HSK 3',
  'DELETE FROM public.grammar_examples',
  'WHERE grammar_point_id IN (',
  '  SELECT id FROM public.grammar_points WHERE hsk_level = \'HSK 3\'',
  ');',
  '',
  '-- 2. Xóa các điểm ngữ pháp HSK 3',
  'DELETE FROM public.grammar_points',
  'WHERE hsk_level = \'HSK 3\';',
  '',
  'COMMIT;',
  ''
];

const rollbackPath = 'supabase/migrations/20261024030000_hsk3_grammar_79_seed_rollback.sql';
fs.writeFileSync(rollbackPath, rollbackLines.join('\n'), 'utf8');
console.log(`Đã tạo file rollback HSK 3: ${rollbackPath}`);
