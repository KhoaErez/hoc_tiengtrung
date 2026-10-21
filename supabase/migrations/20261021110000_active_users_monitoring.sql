-- ====================================================================
-- MIGRATION: ACTIVE USERS MONITORING (REALTIME & 24H ACTIVITY)
-- Hệ thống: Chinese Notebook
-- ====================================================================

-- BƯỚC 1: BỔ SUNG CỘT LAST_SEEN_AT VÀO BẢNG PROFILES
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS last_seen_at timestamp with time zone DEFAULT timezone('utc'::text, now());

-- Khởi tạo giá trị mặc định cho các tài khoản hiện hữu nếu đang null
UPDATE public.profiles
SET last_seen_at = created_at
WHERE last_seen_at IS NULL;

-- BƯỚC 2: TẠO B-TREE INDEX PHỤC VỤ TRUY VẤN COUNT 24H VÀ SẮP XẾP SIÊU TỐC (< 1MS)
CREATE INDEX IF NOT EXISTS idx_profiles_last_seen_at ON public.profiles(last_seen_at DESC);


-- BƯỚC 3: RPC TOUCH_USER_ACTIVITY AN TOÀN, CHỐNG GIAN LẬN ID VÀ CHỐNG SPAM GHI DISK
CREATE OR REPLACE FUNCTION public.touch_user_activity()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  current_uid uuid := auth.uid();
BEGIN
  -- 1. Bảo mật: Chỉ người dùng đã đăng nhập mới được gọi
  IF current_uid IS NULL THEN
    RETURN;
  END IF;

  -- 2. Tối ưu hiệu suất & chống spam: Chỉ ghi vào disk nếu lần cập nhật trước cách đây > 2 phút
  UPDATE public.profiles
  SET last_seen_at = now()
  WHERE id = current_uid
    AND (last_seen_at IS NULL OR last_seen_at < now() - interval '2 minutes');
END;
$$;

-- Thu hồi quyền từ public, chỉ cho phép authenticated user gọi
REVOKE ALL ON FUNCTION public.touch_user_activity() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.touch_user_activity() TO authenticated;
