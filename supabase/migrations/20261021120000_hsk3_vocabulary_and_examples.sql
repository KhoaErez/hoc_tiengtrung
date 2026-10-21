-- ====================================================================
-- MIGRATION: HSK 3.0 OFFICIAL SYLLABUS SUPPORT & MULTI-EXAMPLE SCHEMA
-- Căn cứ Đề cương thi HSK 3.0 (CTI / chinesetest.cn - Công bố 11/2025, áp dụng 7/2026)
-- Hệ thống: Chinese Notebook
-- ====================================================================

-- 1. MỞ RỘNG BẢNG VOCABULARIES ĐỂ HỖ TRỢ HSK 3.0 VÀ METADATA TỪ VỰNG
ALTER TABLE public.vocabularies 
ADD COLUMN IF NOT EXISTS hsk_version text DEFAULT 'hsk3.0',
ADD COLUMN IF NOT EXISTS hsk_level_v3 text,
ADD COLUMN IF NOT EXISTS radical text,
ADD COLUMN IF NOT EXISTS stroke_count integer;

-- 2. TẠO BẢNG CHUYÊN BIỆT LƯU TRỮ CÂU VÍ DỤ ĐA DẠNG (Ít nhất 2 câu ví dụ / từ)
CREATE TABLE IF NOT EXISTS public.vocabulary_examples (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  vocabulary_id uuid REFERENCES public.vocabularies(id) ON DELETE CASCADE NOT NULL,
  chinese text NOT NULL,
  pinyin text NOT NULL,
  meaning_vi text NOT NULL,
  difficulty_level text DEFAULT 'standard', -- 'basic': câu 1 dễ nhớ | 'applied': câu 2 thực tế ứng dụng
  order_index integer DEFAULT 1,
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. TẠO INDEX TỐI ƯU TRUY VẤN
CREATE INDEX IF NOT EXISTS idx_vocab_examples_vocab_id ON public.vocabulary_examples(vocabulary_id);
CREATE INDEX IF NOT EXISTS idx_vocab_examples_order ON public.vocabulary_examples(vocabulary_id, order_index);
CREATE INDEX IF NOT EXISTS idx_vocab_hsk_v3 ON public.vocabularies(hsk_level_v3);
CREATE INDEX IF NOT EXISTS idx_vocab_version ON public.vocabularies(hsk_version);

-- 4. KÍCH HOẠT ROW LEVEL SECURITY (RLS) VÀ PHÂN QUYỀN AN TOÀN
ALTER TABLE public.vocabulary_examples ENABLE ROW LEVEL SECURITY;

-- Mọi người (cả khách và học viên) đều có quyền đọc ví dụ để học tập
CREATE POLICY "Public read vocabulary_examples" 
ON public.vocabulary_examples FOR SELECT 
USING (true);

-- Chỉ Admin hoặc Service Role mới được chỉnh sửa dữ liệu ví dụ hệ thống
CREATE POLICY "Admin manage vocabulary_examples" 
ON public.vocabulary_examples FOR ALL 
TO authenticated 
USING (
  EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE id = auth.uid() AND is_admin = true
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE id = auth.uid() AND is_admin = true
  )
);

-- 5. FUNCTION & TRIGGER TỰ ĐỘNG ĐỒNG BỘ VÍ DỤ SỐ 1 VÀO VOCABULARIES (Đảm bảo tương thích ngược 100%)
CREATE OR REPLACE FUNCTION public.sync_first_example_to_vocab()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NEW.order_index = 1 THEN
    UPDATE public.vocabularies
    SET 
      example_hanzi = NEW.chinese,
      example_pinyin = NEW.pinyin,
      example_vi = NEW.meaning_vi
    WHERE id = NEW.vocabulary_id;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_sync_first_example ON public.vocabulary_examples;
CREATE TRIGGER trg_sync_first_example
AFTER INSERT OR UPDATE ON public.vocabulary_examples
FOR EACH ROW
EXECUTE FUNCTION public.sync_first_example_to_vocab();
