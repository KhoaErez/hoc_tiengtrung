-- ====================================================================
-- MIGRATION: KHẮC PHỤC RLS VÀ PHÒNG THỦ CHỐNG LEO THANG ĐẶC QUYỀN
-- Hệ thống: Chinese Notebook
-- ====================================================================

-- BƯỚC 1: ĐẢM BẢO CỘT IS_ADMIN TỒN TẠI VÀ BOOTSTRAP ADMIN GỐC
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS is_admin boolean DEFAULT false;

-- Bootstrap tài khoản Admin gốc trong Database (không phụ thuộc hardcode mã nguồn)
UPDATE public.profiles 
SET is_admin = true 
WHERE lower(email) = 'khoadev27@gmail.com';


-- BƯỚC 2: HÀM KIỂM TRA QUYỀN ADMIN AN TOÀN (SECURITY DEFINER + ZERO RECURSION)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND is_admin = true
  );
$$;

-- Thu hồi quyền từ public, chỉ cho phép người dùng đã xác thực gọi
REVOKE ALL ON FUNCTION public.is_admin() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_admin() TO authenticated;


-- BƯỚC 3: CẬP NHẬT CHÍNH SÁCH SELECT CHO BẢNG PROFILES (SỬA LỖI THIẾU TÀI KHOẢN)
DROP POLICY IF EXISTS "Users can view own profile." ON public.profiles;
DROP POLICY IF EXISTS "Profiles select policy" ON public.profiles;

CREATE POLICY "Profiles select policy"
  ON public.profiles FOR SELECT
  TO authenticated
  USING (
    auth.uid() = id 
    OR public.is_admin()
  );


-- BƯỚC 4: BẢO VỆ CHÍNH SÁCH UPDATE CỦA USER THƯỜNG (LEAST PRIVILEGE)
DROP POLICY IF EXISTS "Users can update own profile." ON public.profiles;
DROP POLICY IF EXISTS "Users can update own profile non-sensitive" ON public.profiles;

-- Người dùng chỉ được sửa hồ sơ của chính mình VÀ không được phép thay đổi is_admin qua RLS
CREATE POLICY "Users can update own profile non-sensitive"
  ON public.profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (
    auth.uid() = id 
    AND (
      -- Giá trị is_admin mới bắt buộc phải bằng giá trị is_admin cũ trong DB
      is_admin = (SELECT p.is_admin FROM public.profiles p WHERE p.id = auth.uid())
    )
  );


-- BƯỚC 5: TRIGGER BẢO VỆ CỘT IS_ADMIN Ở TẦNG DATABASE ENGINE (VÁ TRIỆT ĐỂ PRIVILEGE ESCALATION)
CREATE OR REPLACE FUNCTION public.protect_profile_role_change()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  -- Phát hiện nếu có bất kỳ hành vi thay đổi giá trị cột is_admin
  IF (NEW.is_admin IS DISTINCT FROM OLD.is_admin) THEN
    -- Kiểm tra danh tính: Bắt buộc người gọi (auth.uid()) phải là Admin
    IF NOT public.is_admin() THEN
      RAISE EXCEPTION 'Access Denied: Bạn không có quyền thay đổi vai trò quản trị (is_admin).'
        USING errcode = '42501';
    END IF;
  END IF;
  RETURN NEW;
END;
$$;

REVOKE ALL ON FUNCTION public.protect_profile_role_change() FROM PUBLIC;

DROP TRIGGER IF EXISTS tr_protect_profile_role_change ON public.profiles;
CREATE TRIGGER tr_protect_profile_role_change
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.protect_profile_role_change();


-- BƯỚC 6: RPC CHUYÊN BIỆT CHO PHÉP ADMIN THAY ĐỔI ROLE (ĐẶC QUYỀN TỐI THIỂU - KHÔNG CẤP UPDATE TOÀN BỘ BẢNG)
CREATE OR REPLACE FUNCTION public.set_user_admin_role(
  target_user_id uuid,
  new_is_admin boolean
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  calling_user_id uuid;
  caller_is_admin boolean;
  target_email text;
BEGIN
  calling_user_id := auth.uid();
  
  IF calling_user_id IS NULL THEN
    RAISE EXCEPTION 'Unauthorized: Yêu cầu đăng nhập.' USING errcode = '28000';
  END IF;

  -- Kiểm tra quyền Admin của người gọi trực tiếp trong DB
  SELECT is_admin INTO caller_is_admin
  FROM public.profiles
  WHERE id = calling_user_id;

  IF caller_is_admin IS NOT TRUE THEN
    RAISE EXCEPTION 'Forbidden: Chỉ quản trị viên mới được thực hiện thao tác này.' USING errcode = '42501';
  END IF;

  -- Quy tắc an toàn: Không cho phép Admin tự hạ quyền của chính mình
  IF calling_user_id = target_user_id AND new_is_admin = FALSE THEN
    RAISE EXCEPTION 'Bad Request: Bạn không thể tự thu hồi quyền quản trị của chính mình.' USING errcode = '22000';
  END IF;

  -- Cập nhật DUY NHẤT cột is_admin của tài khoản đích
  UPDATE public.profiles
  SET is_admin = new_is_admin
  WHERE id = target_user_id
  RETURNING email INTO target_email;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Not Found: Không tìm thấy tài khoản người dùng.' USING errcode = 'P0002';
  END IF;

  RETURN jsonb_build_object(
    'success', true,
    'target_user_id', target_user_id,
    'email', target_email,
    'is_admin', new_is_admin
  );
END;
$$;

REVOKE ALL ON FUNCTION public.set_user_admin_role(uuid, boolean) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.set_user_admin_role(uuid, boolean) TO authenticated;
