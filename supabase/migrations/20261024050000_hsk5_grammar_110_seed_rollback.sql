-- ==============================================================================
-- ROLLBACK: 20261024050000_hsk5_grammar_110_seed_rollback.sql
-- Hoàn tác nạp 110 điểm ngữ pháp HSK 5 chuẩn GF 0025-2021
-- ==============================================================================

BEGIN;

-- 1. Xóa các ví dụ ngữ pháp thuộc các điểm ngữ pháp HSK 5
DELETE FROM public.grammar_examples
WHERE grammar_point_id IN (
  SELECT id FROM public.grammar_points WHERE hsk_level = 'HSK 5'
);

-- 2. Xóa các điểm ngữ pháp HSK 5
DELETE FROM public.grammar_points
WHERE hsk_level = 'HSK 5';

COMMIT;
