-- ==============================================================================
-- ROLLBACK: 20261024020000_hsk2_grammar_78_seed_rollback.sql
-- Hoàn tác nạp 78 điểm ngữ pháp HSK 2 chuẩn GF 0025-2021
-- ==============================================================================

BEGIN;

-- 1. Xóa các ví dụ ngữ pháp thuộc các điểm ngữ pháp HSK 2
DELETE FROM public.grammar_examples
WHERE grammar_point_id IN (
  SELECT id FROM public.grammar_points WHERE hsk_level = 'HSK 2'
);

-- 2. Xóa các điểm ngữ pháp HSK 2
DELETE FROM public.grammar_points
WHERE hsk_level = 'HSK 2';

COMMIT;
