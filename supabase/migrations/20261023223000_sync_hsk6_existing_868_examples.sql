-- Migration: 20261023223000_sync_hsk6_existing_868_examples.sql
-- Description: Đồng bộ 868 câu ví dụ HSK 6 hiện có từ vocabularies sang vocabulary_examples
-- Mục đích: Phục vụ mô-đun Luyện đánh máy (/typing) và hiển thị chi tiết câu ví dụ đồng nhất 100%

BEGIN;

INSERT INTO public.vocabulary_examples (
  id,
  vocabulary_id,
  chinese,
  pinyin,
  meaning_vi,
  difficulty_level,
  order_index
)
SELECT
  gen_random_uuid(),
  v.id,
  v.example_hanzi,
  COALESCE(v.example_pinyin, ''),
  COALESCE(v.example_vi, ''),
  'standard',
  1
FROM public.vocabularies v
WHERE v.hsk_level = 'HSK 6'
  AND v.validation_status IN ('matched_target_syllabus', 'verified_target_syllabus', 'needs_tone_sense_review')
  AND v.example_hanzi IS NOT NULL
  AND length(trim(v.example_hanzi)) > 0
  AND NOT EXISTS (
    SELECT 1 FROM public.vocabulary_examples ve
    WHERE ve.vocabulary_id = v.id
  );

COMMIT;
