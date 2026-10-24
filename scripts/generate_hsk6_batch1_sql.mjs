import fs from 'fs'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

async function main() {
  console.log('=== TẠO MIGRATION SQL CHO HSK 6 BATCH 1 (100 TỪ) ===\n')

  const batch1 = JSON.parse(fs.readFileSync('scratch/hsk6_batch1_full.json', 'utf8'))
  console.log(`Đã nạp ${batch1.length} từ từ scratch/hsk6_batch1_full.json`)

  const migrationTimestamp = '20261023020000'
  const migrationPath = `supabase/migrations/${migrationTimestamp}_hsk6_batch1_words_seed.sql`
  const rollbackPath = `supabase/migrations/rollbacks/${migrationTimestamp}_hsk6_batch1_words_seed_rollback.sql`

  let sql = `-- ==============================================================================
-- MIGRATION: ${migrationTimestamp}_hsk6_batch1_words_seed.sql
-- MỤC TIÊU:
-- Nạp 100 mục từ mới đầu tiên (Batch 1/8) của cấp độ HSK 6 theo Đề cương thi 11/2025
-- Kèm đầy đủ: Pinyin chuẩn, Loại từ, Nghĩa tiếng Việt, và Câu ví dụ chuẩn Luyện đánh máy
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
`

  const values = []
  const hanziList = []

  for (const item of batch1) {
    hanziList.push(escapeSql(item.hanzi))
    values.push(`  (
    ${escapeSql(item.hanzi)},
    ${escapeSql(item.pinyin)},
    ${escapeSql(item.meaning_vi)},
    ${escapeSql(item.word_type)},
    'HSK 6',
    'hsk3_2025',
    ${escapeSql(item.example_hanzi)},
    ${escapeSql(item.example_pinyin)},
    ${escapeSql(item.example_vi)},
    'cti_official_2025',
    '2025_syllabus_11_2025',
    'curated_standard',
    'verified_target_syllabus',
    'active',
    'Mục từ mới HSK 6 theo Đề cương thi 11/2025 (Batch 1/8)'
  )`)
  }

  sql += values.join(',\n') + `;\n\nCOMMIT;\n`
  fs.writeFileSync(migrationPath, sql, 'utf8')
  console.log(`Đã xuất Migration SQL: ${migrationPath}`)

  let rollbackSql = `-- ==============================================================================
-- ROLLBACK SCRIPT: ${migrationTimestamp}_hsk6_batch1_words_seed_rollback.sql
-- Hoàn tác nạp 100 từ mới HSK 6 của Batch 1
-- ==============================================================================

BEGIN;

DELETE FROM public.vocabularies
WHERE hsk_level = 'HSK 6'
  AND source = 'cti_official_2025'
  AND notes LIKE '%Batch 1/8%'
  AND hanzi IN (${hanziList.join(', ')});

COMMIT;
`
  fs.writeFileSync(rollbackPath, rollbackSql, 'utf8')
  console.log(`Đã xuất Rollback SQL: ${rollbackPath}`)
}

main().catch(console.error)
