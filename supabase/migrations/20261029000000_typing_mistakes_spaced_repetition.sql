-- ==============================================================================
-- MIGRATION: 20261029000000_typing_mistakes_spaced_repetition.sql
-- PURPOSE: Nâng cấp bảng typing_mistakes hỗ trợ thuật toán Spaced Repetition (SM-2)
-- AUTHOR: Senior Full-stack Engineer
-- COMPATIBILITY: PostgreSQL 14+, Supabase Auth & RLS
-- ==============================================================================

-- 1. Bổ sung các cột Spaced Repetition (SM-2) vào bảng typing_mistakes nếu chưa tồn tại
DO $$
BEGIN
    -- interval_days: Khoảng cách ôn tập hiện tại tính bằng ngày (mặc định 0 cho câu mới sai)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_mistakes' AND column_name = 'interval_days'
    ) THEN
        ALTER TABLE typing_mistakes ADD COLUMN interval_days integer DEFAULT 0 NOT NULL;
    END IF;

    -- ease_factor: Hệ số điều chỉnh độ khó SM-2 (mặc định 2.5, tối thiểu 1.3, tối đa 3.0)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_mistakes' AND column_name = 'ease_factor'
    ) THEN
        ALTER TABLE typing_mistakes ADD COLUMN ease_factor numeric(4,2) DEFAULT 2.50 NOT NULL;
    END IF;

    -- due_at: Thời điểm đến hạn ôn tiếp theo (mặc định là now() để câu mới sai được ôn ngay)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_mistakes' AND column_name = 'due_at'
    ) THEN
        ALTER TABLE typing_mistakes ADD COLUMN due_at timestamptz DEFAULT now() NOT NULL;
    END IF;

    -- lapses: Số lần quên / trả lời sai trong toàn bộ quá trình ôn tập
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_mistakes' AND column_name = 'lapses'
    ) THEN
        ALTER TABLE typing_mistakes ADD COLUMN lapses integer DEFAULT 0 NOT NULL;
    END IF;
END $$;

-- 2. Tối ưu hóa hiệu năng truy vấn với Index
-- Index hỗ trợ lọc nhanh các câu đến hạn ôn hôm nay theo từng user (query: user_id = ? AND due_at <= now())
CREATE INDEX IF NOT EXISTS idx_typing_mistakes_user_due 
    ON typing_mistakes (user_id, due_at ASC);

-- Index hỗ trợ lọc theo trạng thái ôn tập (need_review, reviewing, mastered)
CREATE INDEX IF NOT EXISTS idx_typing_mistakes_user_status 
    ON typing_mistakes (user_id, review_status);

-- Unique index ngăn ngừa triệt để tình trạng trùng lặp dữ liệu câu sai cho cùng một người dùng
CREATE UNIQUE INDEX IF NOT EXISTS idx_typing_mistakes_unique_item 
    ON typing_mistakes (user_id, mode, exercise_id, sentence_index);

-- 3. Thiết lập Row Level Security (RLS) bảo vệ dữ liệu người dùng
ALTER TABLE typing_mistakes ENABLE ROW LEVEL SECURITY;

-- Xóa các policy cũ nếu trùng tên để đảm bảo tính idempotent
DROP POLICY IF EXISTS "Users can view their own typing mistakes" ON typing_mistakes;
DROP POLICY IF EXISTS "Users can insert their own typing mistakes" ON typing_mistakes;
DROP POLICY IF EXISTS "Users can update their own typing mistakes" ON typing_mistakes;
DROP POLICY IF EXISTS "Users can delete their own typing mistakes" ON typing_mistakes;

-- Policy: Mỗi người dùng CHỈ CÓ THỂ đọc câu sai của chính mình
CREATE POLICY "Users can view their own typing mistakes"
    ON typing_mistakes
    FOR SELECT
    USING (auth.uid() = user_id);

-- Policy: Mỗi người dùng CHỈ CÓ THỂ tạo bản ghi câu sai cho chính mình
CREATE POLICY "Users can insert their own typing mistakes"
    ON typing_mistakes
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Policy: Mỗi người dùng CHỈ CÓ THỂ cập nhật tiến độ ôn tập câu sai của chính mình
CREATE POLICY "Users can update their own typing mistakes"
    ON typing_mistakes
    FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- Policy: Mỗi người dùng CHỈ CÓ THỂ xóa câu sai của chính mình
CREATE POLICY "Users can delete their own typing mistakes"
    ON typing_mistakes
    FOR DELETE
    USING (auth.uid() = user_id);

-- ==============================================================================
-- HOÀN TẤT MIGRATION
-- ==============================================================================

