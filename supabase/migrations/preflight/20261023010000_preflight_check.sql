-- ==============================================================================
-- PREFLIGHT CHECK (CHỈ ĐỌC - READ ONLY)
-- File: supabase/migrations/preflight/20261023010000_preflight_check.sql
-- Thực thi trước migration để kiểm tra hiện trạng CSDL và số lượng bản ghi
-- ==============================================================================

-- 1. Kiểm tra tổng số từ vựng theo từng cấp độ
SELECT hsk_level, count(*) AS total_words
FROM public.vocabularies
GROUP BY hsk_level
ORDER BY hsk_level;

-- 2. Kiểm tra các cột đã tồn tại trên bảng vocabularies
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'vocabularies'
  AND column_name IN ('source', 'source_version', 'generation_method', 'validation_status', 'lifecycle_status', 'reviewed_at', 'reviewed_by', 'notes');

-- 3. Kiểm tra hiện trạng bản ghi [维持] (id: 41ee7084-fa73-49d4-aef9-05ef6d66eb31)
SELECT id, hanzi, pinyin, meaning_vi, word_type, hsk_level
FROM public.vocabularies
WHERE id = '41ee7084-fa73-49d4-aef9-05ef6d66eb31';

-- 4. Kiểm tra tổng số từ HSK 6 trong DB (Kỳ vọng: đúng 2.800 từ)
SELECT count(*) AS hsk6_count
FROM public.vocabularies
WHERE hsk_level = 'HSK 6';

-- 5. Kiểm tra bảng data_audit_logs đã tồn tại hay chưa
SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'data_audit_logs';

-- 6. Kiểm tra các liên kết bài học hệ thống của HSK 6
SELECT count(DISTINCT vocabulary_id) AS linked_hsk6_vocabularies, count(*) AS total_links
FROM public.lesson_vocabularies lv
JOIN public.vocabularies v ON lv.vocabulary_id = v.id
WHERE v.hsk_level = 'HSK 6';
