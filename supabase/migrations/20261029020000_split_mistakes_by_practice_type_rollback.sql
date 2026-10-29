-- ==============================================================================
-- ROLLBACK: 20261029020000_split_mistakes_by_practice_type_rollback.sql
-- PURPOSE: Khôi phục lại trạng thái trước khi tách practice_type trong bảng typing_mistakes
-- AUTHOR: Senior Full-stack Engineer
-- ==============================================================================

-- 1. Xóa các Index mới tạo
DROP INDEX IF EXISTS idx_typing_mistakes_user_practice_status;
DROP INDEX IF EXISTS idx_typing_mistakes_user_practice_due;
DROP INDEX IF EXISTS idx_typing_mistakes_user_practice_item;

-- 2. Khôi phục lại Unique Index ban đầu theo (user_id, mode, exercise_id, sentence_index)
CREATE UNIQUE INDEX IF NOT EXISTS idx_typing_mistakes_unique_item 
    ON typing_mistakes (user_id, mode, exercise_id, sentence_index);

-- 3. Xóa cột practice_type nếu tồn tại
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_mistakes' AND column_name = 'practice_type'
    ) THEN
        ALTER TABLE typing_mistakes DROP COLUMN practice_type;
    END IF;
END $$;

