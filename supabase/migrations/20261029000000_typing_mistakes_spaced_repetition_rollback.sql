-- ==============================================================================
-- ROLLBACK MIGRATION: 20261029000000_typing_mistakes_spaced_repetition_rollback.sql
-- PURPOSE: Rollback an toàn cho migration Spaced Repetition nếu cần
-- ==============================================================================

-- 1. Xóa các Index đã tạo
DROP INDEX IF EXISTS idx_typing_mistakes_unique_item;
DROP INDEX IF EXISTS idx_typing_mistakes_user_status;
DROP INDEX IF EXISTS idx_typing_mistakes_user_due;

-- 2. Xóa các cột Spaced Repetition (nếu cần khôi phục schema cũ)
ALTER TABLE typing_mistakes DROP COLUMN IF EXISTS lapses;
ALTER TABLE typing_mistakes DROP COLUMN IF EXISTS due_at;
ALTER TABLE typing_mistakes DROP COLUMN IF EXISTS ease_factor;
ALTER TABLE typing_mistakes DROP COLUMN IF EXISTS interval_days;

