-- Rollback: 20261023223000_sync_hsk6_existing_868_examples_rollback.sql
-- Description: Xóa các ví dụ đã đồng bộ cho từ vựng HSK 6 từ bảng vocabulary_examples

BEGIN;

DELETE FROM public.vocabulary_examples ve
USING public.vocabularies v
WHERE ve.vocabulary_id = v.id
  AND v.hsk_level = 'HSK 6'
  AND v.validation_status IN ('matched_target_syllabus', 'verified_target_syllabus', 'needs_tone_sense_review');

COMMIT;
