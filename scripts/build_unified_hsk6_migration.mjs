import fs from 'fs';
import path from 'path';

const migrationFiles = [
  'supabase/migrations/20261023020000_hsk6_batch1_words_seed.sql',
  'supabase/migrations/20261023030000_hsk6_batch2_words_seed.sql',
  'supabase/migrations/20261023040000_hsk6_batch3_words_seed.sql',
  'supabase/migrations/20261023050000_hsk6_batch4_words_seed.sql',
  'supabase/migrations/20261023060000_hsk6_batch5_words_seed.sql',
  'supabase/migrations/20261023070000_hsk6_batch6_words_seed.sql',
  'supabase/migrations/20261023080000_hsk6_batch7_words_seed.sql',
  'supabase/migrations/20261023090000_hsk6_batch8_words_seed.sql',
  'supabase/migrations/20261023100000_hsk6_reconciled_36_words_seed.sql',
];

const blocks = [];
const allHanzi = [];

for (const file of migrationFiles) {
  const content = fs.readFileSync(path.resolve(file), 'utf8');
  const valuesIndex = content.indexOf('VALUES');
  const commitIndex = content.lastIndexOf('COMMIT;');
  if (valuesIndex === -1 || commitIndex === -1) {
    throw new Error(`Invalid format in ${file}`);
  }
  let block = content.substring(valuesIndex + 6, commitIndex).trim();
  if (block.endsWith(';')) {
    block = block.slice(0, -1).trim();
  }
  blocks.push(block);

  // Extract hanzi safely: matches `(\n    'hanzi',`
  const lines = block.split('\n');
  for (let i = 0; i < lines.length - 1; i++) {
    if (lines[i].trim() === '(') {
      const hanziMatch = lines[i + 1].match(/^\s*'([^']+)',/);
      if (hanziMatch) {
        allHanzi.push(hanziMatch[1]);
      }
    }
  }
  console.log(`Extracted block from ${path.basename(file)} (hanzi extracted so far: ${allHanzi.length})`);
}

console.log(`\nTotal Hanzi extracted: ${allHanzi.length}`);
console.log(`Total unique Hanzi: ${new Set(allHanzi).size}`);

const unifiedTimestamp = '20261023200000';
const unifiedMigrationPath = `supabase/migrations/${unifiedTimestamp}_hsk6_full_869_words_seed.sql`;
const unifiedRollbackPath = `supabase/migrations/rollbacks/${unifiedTimestamp}_hsk6_full_869_words_seed_rollback.sql`;

const unifiedMigrationSql = `-- ==============================================================================
-- UNIFIED MIGRATION: ${unifiedTimestamp}_hsk6_full_869_words_seed.sql
-- MỤC TIÊU:
-- Nạp toàn bộ 869 mục từ mới chuẩn HSK 6 theo Đề cương thi HSK 3.0 (CTI 11/2025)
-- (Bao gồm 833 từ mới thuộc Batches 1..8 + 36 từ điều hòa bảo toàn liên kết dữ liệu)
-- Kết hợp cùng 931 từ đã chuẩn hóa ở Pha 1 để đạt đúng 1.800/1.800 từ (100.00% đề cương CTI)
-- Toàn bộ từ vựng có câu ví dụ chuẩn 12-25 chữ, Pinyin chuẩn thanh điệu và dịch nghĩa phục vụ /typing.
-- ==============================================================================

BEGIN;

INSERT INTO public.vocabularies (
  hanzi,
  pinyin,
  meaning_vi,
  word_type,
  hsk_level,
  hsk_version,
  example_hanzi,
  example_pinyin,
  example_vi,
  source,
  source_version,
  generation_method,
  validation_status,
  lifecycle_status,
  notes
)
VALUES
${blocks.join(',\n')};

COMMIT;
`;

fs.writeFileSync(unifiedMigrationPath, unifiedMigrationSql, 'utf8');
console.log(`Đã xuất Unified Migration: ${unifiedMigrationPath} (${(fs.statSync(unifiedMigrationPath).size / 1024).toFixed(1)} KB)`);

function escapeSql(s) {
  return `'${s.replace(/'/g, "''")}'`;
}

const uniqueHanziList = Array.from(new Set(allHanzi)).map(escapeSql);

const unifiedRollbackSql = `-- ==============================================================================
-- UNIFIED ROLLBACK: ${unifiedTimestamp}_hsk6_full_869_words_seed_rollback.sql
-- Hoàn tác nạp toàn bộ 869 từ mới HSK 6 theo Đề cương CTI 11/2025
-- ==============================================================================

BEGIN;

DELETE FROM public.vocabularies
WHERE hsk_level = 'HSK 6'
  AND source = 'cti_official_2025'
  AND (
    notes LIKE '%Batch 1/8%' OR
    notes LIKE '%Batch 2/8%' OR
    notes LIKE '%Batch 3/8%' OR
    notes LIKE '%Batch 4/8%' OR
    notes LIKE '%Batch 5/8%' OR
    notes LIKE '%Batch 6/8%' OR
    notes LIKE '%Batch 7/8%' OR
    notes LIKE '%Batch 8/8%' OR
    notes LIKE '%Reconciled batch%'
  )
  AND hanzi IN (
    ${uniqueHanziList.join(', ')}
  );

COMMIT;
`;

fs.writeFileSync(unifiedRollbackPath, unifiedRollbackSql, 'utf8');
console.log(`Đã xuất Unified Rollback: ${unifiedRollbackPath} (${(fs.statSync(unifiedRollbackPath).size / 1024).toFixed(1)} KB)`);
