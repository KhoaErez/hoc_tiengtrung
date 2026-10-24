import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

function normalizePinyin(py) {
  if (!py) return ''
  return py.toLowerCase().trim().replace(/\s+/g, '')
}

async function main() {
  console.log('=== KHỞI TẠO MIGRATION PHA 1 & ROLLBACK CHUẨN AN TOÀN CAO ===\n')

  const official1800 = JSON.parse(fs.readFileSync('scratch/hsk6_official_1800.json', 'utf8'))
  const officialMap = new Map()
  for (const w of official1800) {
    officialMap.set(w.hanzi, w)
  }

  // Tải 2.800 từ HSK 6 từ Supabase
  let allHsk6 = []
  let from = 0
  const step = 1000
  while (true) {
    const { data } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level')
      .eq('hsk_level', 'HSK 6')
      .range(from, from + step - 1)
    if (!data || data.length === 0) break
    allHsk6.push(...data)
    from += step
  }

  const pinyinExactIds = []
  const pinyinDiffIds = []
  const legacyIds = []

  for (const v of allHsk6) {
    if (officialMap.has(v.hanzi)) {
      const off = officialMap.get(v.hanzi)
      const normOff = normalizePinyin(off.pinyin)
      const normDb = normalizePinyin(v.pinyin)
      if (normOff === normDb) {
        pinyinExactIds.push(v.id)
      } else {
        pinyinDiffIds.push({ id: v.id, hanzi: v.hanzi, off_py: off.pinyin, db_py: v.pinyin })
      }
    } else {
      legacyIds.push(v.id)
    }
  }

  console.log(`- Khớp hoàn toàn cả Hanzi và Pinyin: ${pinyinExactIds.length}`)
  console.log(`- Trùng Hanzi nhưng lệch Pinyin/ngữ cảnh: ${pinyinDiffIds.length}`)
  console.log(`- Thuộc HSK 2.0 cũ / chưa ánh xạ: ${legacyIds.length}`)

  const migrationTimestamp = '20261023010000'
  const migrationPath = `supabase/migrations/${migrationTimestamp}_provenance_schema_and_hsk6_phase1.sql`
  const rollbackPath = `supabase/migrations/rollbacks/${migrationTimestamp}_provenance_schema_and_hsk6_phase1_rollback.sql`
  const preflightPath = `supabase/migrations/preflight/${migrationTimestamp}_preflight_check.sql`

  if (!fs.existsSync('supabase/migrations/preflight')) {
    fs.mkdirSync('supabase/migrations/preflight', { recursive: true })
  }
  if (!fs.existsSync('supabase/migrations/rollbacks')) {
    fs.mkdirSync('supabase/migrations/rollbacks', { recursive: true })
  }

  function chunkArray(arr, size) {
    const res = []
    for (let i = 0; i < arr.length; i += size) res.push(arr.slice(i, i + size))
    return res
  }

  // 1. TẠO PREFLIGHT CHECK SQL (READ ONLY)
  let preflightSql = `-- ==============================================================================
-- PREFLIGHT CHECK (CHỈ ĐỌC - READ ONLY)
-- File: ${preflightPath}
-- Thực thi trước migration để kiểm tra hiện trạng CSDL và số lượng bản ghi
-- ==============================================================================

-- 1. Kiểm tra tổng số từ vựng theo từng cấp độ
SELECT hsk_level, count(*) AS total_words
FROM public.vocabularies
GROUP BY hsk_level
ORDER BY hsk_level;

-- 2. Kiểm tra các cột đã tồn tại trên bảng vocabularies
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'vocabularies'
  AND column_name IN ('source', 'source_version', 'generation_method', 'validation_status', 'lifecycle_status', 'reviewed_at', 'reviewed_by', 'notes');

-- 3. Kiểm tra hiện trạng bản ghi [维持] (id: 41ee7084-fa73-49d4-aef9-05ef6d66eb31)
SELECT id, hanzi, pinyin, meaning_vi, word_type, hsk_level
FROM public.vocabularies
WHERE id = '41ee7084-fa73-49d4-aef9-05ef6d66eb31';

-- 4. Kiểm tra tổng số từ HSK 6 trong DB (Kỳ vọng: đúng 2.800 từ)
SELECT count(*) AS hsk6_count
FROM public.vocabularies
WHERE hsk_level = 'HSK 6';

-- 5. Kiểm tra bảng data_audit_logs đã tồn tại hay chưa
SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'data_audit_logs';

-- 6. Kiểm tra các liên kết bài học hệ thống của HSK 6
SELECT count(DISTINCT vocabulary_id) AS linked_hsk6_vocabularies, count(*) AS total_links
FROM public.lesson_vocabularies lv
JOIN public.vocabularies v ON lv.vocabulary_id = v.id
WHERE v.hsk_level = 'HSK 6';
`
  fs.writeFileSync(preflightPath, preflightSql, 'utf8')
  console.log(`Đã xuất Preflight SQL: ${preflightPath}`)

  // 2. TẠO MIGRATION SQL CHUẨN AN TOÀN (TRANSACTION + SNAPSHOT + RLS)
  let migSql = `-- ==============================================================================
-- MIGRATION: ${migrationTimestamp}_provenance_schema_and_hsk6_phase1.sql
-- MỤC TIÊU:
-- 1. Bổ sung các cột Data Provenance & Governance vào bảng vocabularies
-- 2. Tạo bảng nhật ký kiểm định data_audit_logs (KÈM BẬT RLS)
-- 3. Tạo SNAPSHOT sao lưu trước khi cập nhật dữ liệu để rollback an toàn 100%
-- 4. Sửa lỗi AI format của từ [维持] (id: 41ee7084-fa73-49d4-aef9-05ef6d66eb31)
-- 5. Gắn nhãn Provenance cho HSK 1 - HSK 5 (source: hsk1_org_scrape, unverified)
-- 6. Phân loại 2.800 từ HSK 6:
--    - 911 từ khớp chuẩn cả Hanzi và Pinyin: active (matched_target_syllabus)
--    - 20 từ lệch Pinyin / đa âm: needs_review (needs_tone_sense_review)
--    - 1.869 từ cũ: legacy_unmapped (bảo toàn 100% dữ liệu, KHÔNG tự gán HSK 7-9)
-- ==============================================================================

BEGIN;

-- 1. TẠO SNAPSHOT SAO LƯU DỮ LIỆU HIỆN TẠI (IDEMPOTENT)
CREATE TABLE IF NOT EXISTS public._snapshot_vocabularies_20261023010000 AS
SELECT id, hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_version, hsk_level_v3
FROM public.vocabularies;

-- 2. BỔ SUNG CỘT METADATA VÀO BẢNG VOCABULARIES
ALTER TABLE public.vocabularies
  ADD COLUMN IF NOT EXISTS source text DEFAULT 'unverified',
  ADD COLUMN IF NOT EXISTS source_version text DEFAULT 'unknown',
  ADD COLUMN IF NOT EXISTS generation_method text DEFAULT 'unverified',
  ADD COLUMN IF NOT EXISTS validation_status text DEFAULT 'unverified',
  ADD COLUMN IF NOT EXISTS lifecycle_status text DEFAULT 'active',
  ADD COLUMN IF NOT EXISTS reviewed_at timestamptz,
  ADD COLUMN IF NOT EXISTS reviewed_by text,
  ADD COLUMN IF NOT EXISTS notes text;

COMMENT ON COLUMN public.vocabularies.source IS 'Nguồn gốc dữ liệu: cti_official_2025, hsk1_org_scrape, leonsilicon_hsk2_0';
COMMENT ON COLUMN public.vocabularies.generation_method IS 'Cách thức sinh: official_syllabus, ai_translated, ai_generated, manual_curated';
COMMENT ON COLUMN public.vocabularies.validation_status IS 'Trạng thái kiểm định: unverified, format_verified, expert_reviewed, matched_target_syllabus, needs_tone_sense_review, legacy_unmapped';
COMMENT ON COLUMN public.vocabularies.lifecycle_status IS 'Vòng đời bản ghi: active, needs_review, legacy_unmapped, deprecated';

-- 3. TẠO BẢNG NHẬT KÝ KIỂM ĐỊNH (KÈM BẬT RLS BẢO VỆ)
CREATE TABLE IF NOT EXISTS public.data_audit_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  table_name text NOT NULL DEFAULT 'vocabularies',
  record_id uuid NOT NULL,
  field_name text NOT NULL,
  old_value text,
  new_value text,
  reason text,
  auditor text NOT NULL DEFAULT 'system_audit',
  migration_tag text DEFAULT '20261023010000_phase1',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE public.data_audit_logs ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'data_audit_logs' AND policyname = 'Anyone can read data_audit_logs.') THEN
    CREATE POLICY "Anyone can read data_audit_logs." ON public.data_audit_logs FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'data_audit_logs' AND policyname = 'Service role can manage data_audit_logs.') THEN
    CREATE POLICY "Service role can manage data_audit_logs." ON public.data_audit_logs FOR ALL USING (auth.jwt()->>'role' = 'service_role');
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_data_audit_logs_record_id ON public.data_audit_logs(record_id);
CREATE INDEX IF NOT EXISTS idx_data_audit_logs_tag ON public.data_audit_logs(migration_tag);

-- 4. SỬA LỖI AI PARSER CỦA TỪ [维持]
DO $$
DECLARE
  v_err_id uuid := '41ee7084-fa73-49d4-aef9-05ef6d66eb31';
BEGIN
  INSERT INTO public.data_audit_logs (table_name, record_id, field_name, old_value, new_value, reason, auditor, migration_tag)
  VALUES 
    ('vocabularies', v_err_id, 'pinyin', 'wéi chí: duy trì', 'wéichí', 'Fix AI format error: remove vietnamese from pinyin', 'phase1_migration', '20261023010000_phase1'),
    ('vocabularies', v_err_id, 'meaning_vi', '(Cần dịch)', 'duy trì, gìn giữ, bảo hộ', 'Fix AI format error: populate missing vietnamese meaning', 'phase1_migration', '20261023010000_phase1');

  UPDATE public.vocabularies
  SET 
    pinyin = 'wéichí',
    meaning_vi = 'duy trì, gìn giữ, bảo hộ',
    word_type = 'Động từ',
    notes = 'Đã sửa lỗi AI format (tách nghĩa tiếng Việt ra khỏi Pinyin)'
  WHERE id = v_err_id AND pinyin = 'wéi chí: duy trì';
END $$;

-- 5. GẮN NHÃN PROVENANCE CHO HSK 1 - HSK 5
UPDATE public.vocabularies
SET 
  source = 'hsk1_org_scrape',
  source_version = '2021_standard_gf0025',
  generation_method = 'ai_translated',
  validation_status = 'unverified',
  lifecycle_status = 'active'
WHERE hsk_level IN ('HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5')
  AND (source IS NULL OR source = 'unverified');

-- 6. PHÂN LOẠI 911 MỤC TỪ HSK 6 KHỚP CHUẨN CẢ CHỮ HÁN VÀ PINYIN
`

  for (const chunk of chunkArray(pinyinExactIds, 200)) {
    const idList = chunk.map(id => `'${id}'`).join(', ')
    migSql += `UPDATE public.vocabularies
SET 
  hsk_version = 'hsk3_2025',
  source = 'hsk1_org_scrape',
  source_version = '2025_syllabus_11_2025',
  generation_method = 'ai_translated',
  validation_status = 'matched_target_syllabus',
  lifecycle_status = 'active',
  notes = 'Khớp chuẩn cả Chữ Hán và Pinyin theo Đề cương thi HSK 6 (11/2025)'
WHERE id IN (${idList}) AND (validation_status IS DISTINCT FROM 'matched_target_syllabus');\n\n`
  }

  migSql += `-- 7. PHÂN LOẠI 20 MỤC TỪ TRÙNG CHỮ HÁN NHƯNG LỆCH PINYIN / ĐA ÂM (CẦN RÀ SOÁT)\n`
  const pinyinDiffIdList = pinyinDiffIds.map(d => `'${d.id}'`).join(', ')
  migSql += `UPDATE public.vocabularies
SET 
  hsk_version = 'hsk3_2025',
  source = 'hsk1_org_scrape',
  source_version = '2025_syllabus_11_2025',
  generation_method = 'ai_translated',
  validation_status = 'needs_tone_sense_review',
  lifecycle_status = 'needs_review',
  notes = 'Trùng chữ Hán nhưng lệch Pinyin / biến điệu / đa âm với Đề cương thi 2025 (ví dụ: 盛 chéng vs shèng, 卷 juàn vs juǎn). Cần chuyên gia duyệt ngữ cảnh.'
WHERE id IN (${pinyinDiffIdList}) AND (validation_status IS DISTINCT FROM 'needs_tone_sense_review');\n\n`

  migSql += `-- 8. PHÂN LOẠI 1.869 MỤC TỪ HSK 6 THUỘC HSK 2.0 CŨ (LEGACY_UNMAPPED - BẢO TOÀN, KHÔNG XÓA)\n`
  for (const chunk of chunkArray(legacyIds, 200)) {
    const idList = chunk.map(id => `'${id}'`).join(', ')
    migSql += `UPDATE public.vocabularies
SET 
  hsk_version = 'hsk2_legacy',
  source = 'leonsilicon_hsk2_0',
  source_version = '2012_syllabus',
  generation_method = 'ai_translated',
  validation_status = 'legacy_unmapped',
  lifecycle_status = 'legacy_unmapped',
  notes = 'Mục từ thuộc HSK 2.0 cũ chưa được đối chiếu HSK 3.0 / HSK 7-9. Giữ nguyên 100% để bảo toàn bài học cũ.'
WHERE id IN (${idList}) AND (lifecycle_status IS DISTINCT FROM 'legacy_unmapped');\n\n`
  }

  migSql += `COMMIT;\n`
  fs.writeFileSync(migrationPath, migSql, 'utf8')
  console.log(`Đã xuất Migration SQL an toàn: ${migrationPath}`)

  // 3. TẠO ROLLBACK SQL HOÀN NGUYÊN CHÍNH XÁC DỰA TRÊN SNAPSHOT
  let rollbackSql = `-- ==============================================================================
-- ROLLBACK SCRIPT (HOÀN NGUYÊN CHÍNH XÁC THEO SNAPSHOT)
-- File: ${rollbackPath}
-- Khôi phục 100% dữ liệu về trạng thái trước migration từ bảng snapshot
-- ==============================================================================

BEGIN;

-- 1. Khôi phục lại chính xác các giá trị cũ của vocabularies từ Snapshot
UPDATE public.vocabularies v
SET 
  pinyin = s.pinyin,
  meaning_vi = s.meaning_vi,
  word_type = s.word_type,
  hsk_level = s.hsk_level,
  hsk_version = s.hsk_version,
  hsk_level_v3 = s.hsk_level_v3,
  source = NULL,
  source_version = NULL,
  generation_method = NULL,
  validation_status = NULL,
  lifecycle_status = NULL,
  reviewed_at = NULL,
  reviewed_by = NULL,
  notes = NULL
FROM public._snapshot_vocabularies_20261023010000 s
WHERE v.id = s.id;

-- 2. Xóa các bản ghi audit log được tạo bởi migration này (dựa vào migration_tag)
DELETE FROM public.data_audit_logs WHERE migration_tag = '20261023010000_phase1';

-- 3. Xóa bảng Snapshot sau khi đã hoàn nguyên xong
DROP TABLE IF EXISTS public._snapshot_vocabularies_20261023010000;

COMMIT;
`
  fs.writeFileSync(rollbackPath, rollbackSql, 'utf8')
  console.log(`Đã xuất Rollback SQL an toàn: ${rollbackPath}`)
}

main().catch(console.error)
