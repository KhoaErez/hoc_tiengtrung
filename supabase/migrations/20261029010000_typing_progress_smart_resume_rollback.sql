-- ==============================================================================
-- ROLLBACK MIGRATION: 20261029010000_typing_progress_smart_resume_rollback.sql
-- PURPOSE: Rollback an toàn cho migration Smart Resume nếu cần
-- ==============================================================================

DROP INDEX IF EXISTS idx_typing_progress_user_latest;
DROP INDEX IF EXISTS idx_typing_progress_user_mode_exercise;

ALTER TABLE typing_progress DROP COLUMN IF EXISTS settings;
ALTER TABLE typing_progress DROP COLUMN IF EXISTS practice_mode;
ALTER TABLE typing_progress DROP COLUMN IF EXISTS current_question_text;
ALTER TABLE typing_progress DROP COLUMN IF EXISTS current_question_id;
ALTER TABLE typing_progress DROP COLUMN IF EXISTS lesson_title;
ALTER TABLE typing_progress DROP COLUMN IF EXISTS lesson_id;
ALTER TABLE typing_progress DROP COLUMN IF EXISTS hsk_level;

