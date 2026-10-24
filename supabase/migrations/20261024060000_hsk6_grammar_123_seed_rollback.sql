-- ==============================================================================
-- ROLLBACK: 20261024060000_hsk6_grammar_123_seed_rollback.sql
-- Hoàn tác nạp 123 điểm ngữ pháp HSK 6 chuẩn GF 0025-2021
-- ==============================================================================

BEGIN;

-- 1. Xóa các ví dụ ngữ pháp thuộc các điểm ngữ pháp HSK 6
DELETE FROM public.grammar_examples
WHERE grammar_point_id IN (
  SELECT id FROM public.grammar_points WHERE hsk_level = 'HSK 6'
);

-- 2. Xóa các điểm ngữ pháp HSK 6
DELETE FROM public.grammar_points
WHERE hsk_level = 'HSK 6';

COMMIT;
