-- ==============================================================================
-- ROLLBACK SCRIPT (HOÀN NGUYÊN CHÍNH XÁC THEO SNAPSHOT)
-- File: supabase/migrations/rollbacks/20261023010000_provenance_schema_and_hsk6_phase1_rollback.sql
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
