-- ==============================================================================
-- ROLLBACK: 20261024030000_hsk3_grammar_79_seed_rollback.sql
-- Hoàn tác nạp 79 điểm ngữ pháp HSK 3 chuẩn GF 0025-2021
-- ==============================================================================

BEGIN;

-- 1. Xóa các ví dụ ngữ pháp thuộc các điểm ngữ pháp HSK 3
DELETE FROM public.grammar_examples
WHERE grammar_point_id IN (
  SELECT id FROM public.grammar_points WHERE hsk_level = 'HSK 3'
);

-- 2. Xóa các điểm ngữ pháp HSK 3
DELETE FROM public.grammar_points
WHERE hsk_level = 'HSK 3';

COMMIT;
