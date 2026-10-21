import fs from 'fs'

const sql = `-- ====================================================================
-- MIGRATION: HSK 4 - BỔ SUNG CÁC MỤC TỪ ĐA ÂM ĐA NGHĨA CHUẨN CTI HSK 3.0
--   1. [空] (kōng) - trống rỗng, không gian [Tính từ] (ID 1436)
--   2. [重] (chóng) - lại, một lần nữa, trùng điệp [Phó từ] (ID 1086)
--   3. Cập nhật [生] (shēng) gộp cả 2 mục từ: Động từ (sinh ra) & Tính từ (sống, chưa chín)
-- ====================================================================

DO $$
BEGIN
  -- 1. Bổ sung [空] (kōng)
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '空' AND pinyin = 'kōng'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('空', 'kōng', 'trống rỗng, rỗng không', 'Tính từ', 'HSK 4');
  END IF;

  -- 2. Cập nhật bản ghi [空] (kòng)
  UPDATE public.vocabularies
  SET 
    pinyin = 'kòng',
    meaning_vi = 'rảnh rỗi, thời gian rảnh; để trống',
    word_type = 'Động từ / Danh từ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '空' AND (pinyin = 'kòng' OR pinyin IS NULL OR pinyin = '');

  -- 3. Bổ sung [重] (chóng)
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '重' AND pinyin = 'chóng'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('重', 'chóng', 'lại, một lần nữa; trùng điệp', 'Phó từ', 'HSK 4');
  END IF;

  -- 4. Cập nhật bản ghi [重] (zhòng)
  UPDATE public.vocabularies
  SET 
    pinyin = 'zhòng',
    meaning_vi = 'nặng; quan trọng, trọng lượng',
    word_type = 'Tính từ / Danh từ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '重' AND pinyin = 'zhòng';

  -- 5. Cập nhật [生] (shēng) gộp 2 chức năng của ID 1646 & ID 1647
  UPDATE public.vocabularies
  SET 
    meaning_vi = 'sinh ra, lớn lên; còn sống, chưa chín, xa lạ',
    word_type = 'Động từ / Tính từ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '生';

  RAISE NOTICE 'Hoàn tất chuẩn hóa các mục từ đa âm đa nghĩa HSK 4!';
END $$;
`

const targetPath = 'supabase/migrations/20261021203000_hsk4_polyphonic_entries.sql'
fs.writeFileSync(targetPath, sql, 'utf8')
console.log(`Đã xuất thành công: ${targetPath}`)
