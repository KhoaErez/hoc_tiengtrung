-- ==============================================================================
-- ROLLBACK: 20261024040000_hsk4_grammar_104_seed_rollback.sql
-- Hoàn tác nạp 104 điểm ngữ pháp HSK 4 chuẩn GF 0025-2021
-- ==============================================================================

BEGIN;

-- 1. Xóa các ví dụ ngữ pháp thuộc các điểm ngữ pháp HSK 4
DELETE FROM public.grammar_examples
WHERE grammar_point_id IN (
  SELECT id FROM public.grammar_points WHERE hsk_level = 'HSK 4'
);

-- 2. Xóa các điểm ngữ pháp HSK 4
DELETE FROM public.grammar_points
WHERE hsk_level = 'HSK 4';

COMMIT;
