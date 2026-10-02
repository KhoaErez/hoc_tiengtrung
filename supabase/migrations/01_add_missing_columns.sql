-- 1. Thêm cột hsk_level vào bảng vocabularies
ALTER TABLE public.vocabularies 
ADD COLUMN IF NOT EXISTS hsk_level text DEFAULT 'Chưa phân loại';

-- 2. Thêm các cột cho thuật toán Spaced Repetition vào bảng user_vocabularies
ALTER TABLE public.user_vocabularies 
ADD COLUMN IF NOT EXISTS review_interval_days integer DEFAULT 0,
ADD COLUMN IF NOT EXISTS ease_factor real DEFAULT 2.5,
ADD COLUMN IF NOT EXISTS next_review_at timestamp with time zone DEFAULT timezone('utc'::text, now());

-- 3. Cho phép authenticated user thêm từ vựng mới vào từ điển chung (nếu chưa có)
CREATE POLICY "Users can insert vocabularies" ON public.vocabularies
FOR INSERT 
TO authenticated 
WITH CHECK (true);
