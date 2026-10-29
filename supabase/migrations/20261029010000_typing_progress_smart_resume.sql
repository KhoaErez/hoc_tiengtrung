-- ==============================================================================
-- MIGRATION: 20261029010000_typing_progress_smart_resume.sql
-- PURPOSE: Nâng cấp bảng typing_progress hỗ trợ tính năng Khôi phục vị trí học tiếp
-- AUTHOR: Senior Full-stack Engineer
-- COMPATIBILITY: PostgreSQL 14+, Supabase Auth & RLS
-- ==============================================================================

-- 1. Bổ sung các cột lưu trữ ngữ cảnh học tập chi tiết vào bảng typing_progress
DO $$
BEGIN
    -- hsk_level: Cấp độ HSK (1 - 6) của bài học đang luyện
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_progress' AND column_name = 'hsk_level'
    ) THEN
        ALTER TABLE typing_progress ADD COLUMN hsk_level integer;
    END IF;

    -- lesson_id: ID bài học hệ thống (UUID)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_progress' AND column_name = 'lesson_id'
    ) THEN
        ALTER TABLE typing_progress ADD COLUMN lesson_id text;
    END IF;

    -- lesson_title: Tên bài học hiển thị (ví dụ: "Bài 1: Chào hỏi")
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_progress' AND column_name = 'lesson_title'
    ) THEN
        ALTER TABLE typing_progress ADD COLUMN lesson_title text;
    END IF;

    -- current_question_id: ID ổn định của câu đang học (tránh phụ thuộc chỉ mục mảng)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_progress' AND column_name = 'current_question_id'
    ) THEN
        ALTER TABLE typing_progress ADD COLUMN current_question_id text;
    END IF;

    -- current_question_text: Nội dung câu tiếng Việt hoặc tiếng Trung của câu đang học
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_progress' AND column_name = 'current_question_text'
    ) THEN
        ALTER TABLE typing_progress ADD COLUMN current_question_text text;
    END IF;

    -- practice_mode: Phân biệt rõ chế độ luyện ("visual" = Nghe & Gõ | "translate" = Dịch Việt -> Gõ Hán)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_progress' AND column_name = 'practice_mode'
    ) THEN
        ALTER TABLE typing_progress ADD COLUMN practice_mode text DEFAULT 'visual';
    END IF;

    -- settings: Tùy chọn học tập (tốc độ đọc, ẩn hiện chữ Hán...)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'typing_progress' AND column_name = 'settings'
    ) THEN
        ALTER TABLE typing_progress ADD COLUMN settings jsonb DEFAULT '{}'::jsonb;
    END IF;
END $$;

-- 2. Tối ưu hóa hiệu năng truy vấn tiến độ gần nhất
-- Index này giúp truy vấn bài học gần nhất của user chạy trong < 2ms
CREATE INDEX IF NOT EXISTS idx_typing_progress_user_latest 
    ON typing_progress (user_id, updated_at DESC);

-- Unique index ngăn ngừa ghi đè nhầm tiến độ giữa các chế độ và bài học khác nhau
CREATE UNIQUE INDEX IF NOT EXISTS idx_typing_progress_user_mode_exercise 
    ON typing_progress (user_id, mode, exercise_id);

-- 3. Đảm bảo Row Level Security (RLS) được bật và bảo vệ tuyệt đối
ALTER TABLE typing_progress ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view their own typing progress" ON typing_progress;
DROP POLICY IF EXISTS "Users can insert their own typing progress" ON typing_progress;
DROP POLICY IF EXISTS "Users can update their own typing progress" ON typing_progress;
DROP POLICY IF EXISTS "Users can delete their own typing progress" ON typing_progress;

CREATE POLICY "Users can view their own typing progress"
    ON typing_progress
    FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own typing progress"
    ON typing_progress
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own typing progress"
    ON typing_progress
    FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own typing progress"
    ON typing_progress
    FOR DELETE
    USING (auth.uid() = user_id);

