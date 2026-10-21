import fs from 'fs'
import { HSK4_PART1_WORDS } from '../data/hsk4-missing-part1-data.js'
import { HSK4_PART2_WORDS } from '../data/hsk4-missing-part2-data.js'
import { HSK4_PART3_WORDS } from '../data/hsk4-missing-part3-data.js'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

function generateStep2Sql() {
  console.log('=== KHỞI TẠO FILE SQL SEED 480 TỪ VỰNG CÒN THIẾU HSK 4 (GIAI ĐOẠN 1 - BƯỚC 2) ===')

  const allMissing = [...HSK4_PART1_WORDS, ...HSK4_PART2_WORDS, ...HSK4_PART3_WORDS]
  console.log(`Tổng số từ vựng cần nạp: ${allMissing.length} từ`)

  let sql = `-- ====================================================================
-- MIGRATION: HSK 4 - BƯỚC 2: BỔ SUNG 480 MỤC TỪ VỰNG CHUẨN ĐỀ CƯƠNG HSK 3.0
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn 11/2025)
-- Mục tiêu: Đưa HSK 4 đạt chính xác 1.000 / 1.000 từ vựng chuẩn (ID 1001 -> 2000)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Sử dụng INSERT ... ON CONFLICT hoặc IF NOT EXISTS tránh lỗi trùng lặp
--   - Cung cấp đầy đủ Chữ Hán, Pinyin có dấu, Từ loại tiếng Việt chuẩn, và Nghĩa TV
-- ====================================================================

DO $$
DECLARE
  v_count integer := 0;
BEGIN
`

  for (const item of allMissing) {
    sql += `  -- [${item.hanzi}] (${item.pinyin}) - ${item.meaning_vi} [${item.word_type}]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = ${escapeSql(item.hanzi)}
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES (${escapeSql(item.hanzi)}, ${escapeSql(item.pinyin)}, ${escapeSql(item.meaning_vi)}, ${escapeSql(item.word_type)}, 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = ${escapeSql(item.pinyin)},
      meaning_vi = ${escapeSql(item.meaning_vi)},
      word_type = ${escapeSql(item.word_type)}
    WHERE hsk_level = 'HSK 4' AND hanzi = ${escapeSql(item.hanzi)};
  END IF;

`
  }

  sql += `  RAISE NOTICE 'Hoàn thành nạp bổ sung % từ vựng mới HSK 4 (Đạt chuẩn 1.000 từ HSK 3.0)!', v_count;
END $$;
`

  const targetPath = 'supabase/migrations/20261021200000_hsk4_seed_missing_words.sql'
  fs.writeFileSync(targetPath, sql, 'utf8')
  console.log(`Đã xuất thành công: ${targetPath}`)
  console.log(`Kích thước file: ${(fs.statSync(targetPath).size / 1024).toFixed(1)} KB`)
}

generateStep2Sql()
