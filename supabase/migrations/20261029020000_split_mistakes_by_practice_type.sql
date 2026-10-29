-- ==============================================================================
-- MIGRATION: 20261029020000_split_mistakes_by_practice_type.sql
-- PURPOSE: Tách riêng 2 chế độ ôn tập câu sai: 'translate' (Dịch Việt -> Gõ Hán) 
--          và 'listen' (Nghe & Gõ) cho bảng typing_mistakes.
-- AUTHOR: Senior Full-stack Engineer
-- COMPATIBILITY: PostgreSQL 14+, Supabase Auth & RLS (Idempotent & An toàn)
-- ==============================================================================

-- 1. Bổ sung cột practice_type với CHECK CONSTRAINT nếu chưa tồn tại
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_mistakes' AND column_name = 'practice_type'
    ) THEN
        ALTER TABLE typing_mistakes 
            ADD COLUMN practice_type text DEFAULT 'listen' NOT NULL;
        
        -- Thêm ràng buộc chỉ chấp nhận 'translate' hoặc 'listen'
        ALTER TABLE typing_mistakes 
            ADD CONSTRAINT chk_typing_mistakes_practice_type 
            CHECK (practice_type IN ('translate', 'listen'));
    END IF;
END $$;

-- 2. Backfill dữ liệu cũ thông minh:
-- Phân loại: Các bài tập từ chế độ dịch (mode có chữ 'translate') gán về 'translate',
-- toàn bộ các bài tập nhìn/nghe gõ còn lại (sentence, hsk, paragraph, vocabulary, custom) gán về 'listen'.
UPDATE typing_mistakes
SET practice_type = CASE 
    WHEN mode ILIKE '%translate%' THEN 'translate'
    ELSE 'listen'
END
WHERE practice_type IS NULL OR practice_type = 'listen';

-- 3. Cập nhật Unique Index để đảm bảo tính độc lập tuyệt đối giữa 2 chế độ:
-- Cùng một câu nếu người dùng sai ở cả 2 chế độ sẽ được lưu thành 2 bản ghi độc lập với lịch SM-2 riêng biệt.
DROP INDEX IF EXISTS idx_typing_mistakes_unique_item;

CREATE UNIQUE INDEX IF NOT EXISTS idx_typing_mistakes_user_practice_item 
    ON typing_mistakes (user_id, practice_type, exercise_id, sentence_index);

-- 4. Tạo Index tối ưu hóa truy vấn lọc theo từng chế độ ôn tập
-- Hỗ trợ truy vấn nhanh: user_id + practice_type + due_at (đến hạn ôn tập của chế độ)
CREATE INDEX IF NOT EXISTS idx_typing_mistakes_user_practice_due 
    ON typing_mistakes (user_id, practice_type, due_at ASC);

-- Hỗ trợ truy vấn nhanh: user_id + practice_type + review_status (trạng thái của chế độ)
CREATE INDEX IF NOT EXISTS idx_typing_mistakes_user_practice_status 
    ON typing_mistakes (user_id, practice_type, review_status);

-- ==============================================================================
-- HOÀN TẤT MIGRATION
-- ==============================================================================

