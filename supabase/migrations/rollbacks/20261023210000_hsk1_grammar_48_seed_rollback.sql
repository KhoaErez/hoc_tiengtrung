-- ==============================================================================
-- ROLLBACK: 20261023210000_hsk1_grammar_48_seed_rollback.sql
-- Hoàn tác nạp 48 điểm ngữ pháp HSK 1
-- ==============================================================================

BEGIN;

-- Xóa dữ liệu các điểm ngữ pháp HSK 1 thuộc nguồn gf0025_2021 (các câu ví dụ tự động cascade theo foreign key)
DELETE FROM public.grammar_points
WHERE hsk_level = 'HSK 1'
  AND source = 'gf0025_2021';

COMMIT;
