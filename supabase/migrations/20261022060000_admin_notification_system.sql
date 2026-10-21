-- ====================================================================
-- MIGRATION: HỆ THỐNG THÔNG BÁO REALTIME VÀ TRẠNG THÁI ĐÃ ĐỌC CHO ADMIN
-- Hệ thống: Chinese Notebook
-- Ngày tạo: 2026-10-22
-- Mô tả: Tạo bảng admin_feedback_reads để lưu trạng thái đã đọc
--         độc lập theo từng Admin, kích hoạt Supabase Realtime trên
--         bảng feedback để Admin nhận thông báo gần thời gian thực.
-- ====================================================================

-- 1. TẠO BẢNG LƯU TRẠNG THÁI ĐÃ ĐỌC THEO TỪNG ADMIN
CREATE TABLE IF NOT EXISTS public.admin_feedback_reads (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  admin_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  feedback_id UUID NOT NULL REFERENCES public.feedback(id) ON DELETE CASCADE,
  read_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  CONSTRAINT unique_admin_feedback_read UNIQUE (admin_id, feedback_id)
);

-- Index tối ưu tốc độ tra cứu và đếm số lượng chưa đọc
CREATE INDEX IF NOT EXISTS idx_admin_feedback_reads_admin ON public.admin_feedback_reads(admin_id);
CREATE INDEX IF NOT EXISTS idx_admin_feedback_reads_feedback ON public.admin_feedback_reads(feedback_id);

-- 2. KÍCH HOẠT ROW LEVEL SECURITY (RLS)
ALTER TABLE public.admin_feedback_reads ENABLE ROW LEVEL SECURITY;

-- Policy A: Admin chỉ được xem các bản ghi đã đọc của chính mình
CREATE POLICY "Admins can view own feedback reads"
  ON public.admin_feedback_reads FOR SELECT
  TO authenticated
  USING (
    auth.uid() = admin_id
    AND public.is_admin()
  );

-- Policy B: Admin chỉ được đánh dấu đã đọc cho chính tài khoản của mình
CREATE POLICY "Admins can insert own feedback reads"
  ON public.admin_feedback_reads FOR INSERT
  TO authenticated
  WITH CHECK (
    auth.uid() = admin_id
    AND public.is_admin()
  );

-- Policy C: Cho phép xóa nếu muốn hoàn tác (hoặc bảo trì)
CREATE POLICY "Admins can delete own feedback reads"
  ON public.admin_feedback_reads FOR DELETE
  TO authenticated
  USING (
    auth.uid() = admin_id
    AND public.is_admin()
  );

-- 3. KÍCH HOẠT SUPABASE REALTIME REPLICATION CHO BẢNG FEEDBACK
-- Đảm bảo Admin nhận được sự kiện INSERT ngay khi có học viên gửi phản hồi
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime'
      AND schemaname = 'public'
      AND tablename = 'feedback'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.feedback;
  END IF;
END $$;
