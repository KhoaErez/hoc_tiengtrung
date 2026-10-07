-- 1. Nới lỏng bảng lessons để hỗ trợ System Curriculum
ALTER TABLE public.lessons ALTER COLUMN user_id DROP NOT NULL;
ALTER TABLE public.lessons ALTER COLUMN original_text DROP NOT NULL;
ALTER TABLE public.lessons ADD COLUMN lesson_number integer;
ALTER TABLE public.lessons ADD COLUMN is_system boolean default false;

-- 2. Thêm thứ tự sắp xếp cho bảng mapping
ALTER TABLE public.lesson_vocabularies ADD COLUMN sort_order integer;

-- 3. Cập nhật Row Level Security (RLS) để mọi user đều đọc được System Lessons
-- Xóa policy cũ nếu cần (tùy chọn, ở đây ta cứ tạo mới Policy đọc cho is_system)
CREATE POLICY "Anyone can read system lessons." 
ON public.lessons FOR SELECT USING (is_system = true);

-- Đối với lesson_vocabularies, policy hiện tại chỉ cho phép người tạo lesson được xem.
-- Ta thêm policy để ai cũng xem được từ vựng của bài học hệ thống.
CREATE POLICY "Anyone can read system lesson_vocabularies." 
ON public.lesson_vocabularies FOR SELECT 
USING (EXISTS (SELECT 1 FROM public.lessons WHERE id = lesson_vocabularies.lesson_id AND is_system = true));
