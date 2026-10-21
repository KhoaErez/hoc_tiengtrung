import fs from 'fs'
import { HSK4_BATCH6_EXAMPLES } from '../data/hsk4-batch6-examples-data.ts'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

function generateBatch6Sql() {
  console.log('=== KHỞI TẠO FILE SQL BỔ SUNG CÂU VÍ DỤ HSK 4 - BATCH 6 (100 TỪ) ===')
  console.log('Số lượng từ vựng:', HSK4_BATCH6_EXAMPLES.length)

  if (HSK4_BATCH6_EXAMPLES.length !== 100) {
    console.warn(`CẢNH BÁO: Số lượng từ không phải 100 (hiện có ${HSK4_BATCH6_EXAMPLES.length})`)
  }

  let sql = `-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 6 (100 TỪ)
-- Phạm vi: #1501 [美好] (měihǎo) -> #1600 [全都] (quándōu)
-- Tổng số câu ví dụ: 200 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Không tạo từ mới hay bản ghi trùng trong vocabularies
--   - Cập nhật chuẩn hóa cột word_type (Từ loại) và meaning_vi (Nghĩa TV)
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ các cột tương thích ngược example_hanzi, example_pinyin, example_vi
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
`

  for (const item of HSK4_BATCH6_EXAMPLES) {
    const ex1 = item.examples[0]
    const ex2 = item.examples[1]

    sql += `  -- [${item.hanzi}] (${item.pinyin}) - ${item.meaning_vi} [${item.word_type}]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = ${escapeSql(item.hanzi)} AND pinyin = ${escapeSql(item.pinyin)}
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = ${escapeSql(item.hanzi)}
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = ${escapeSql(item.word_type)},
      pinyin = ${escapeSql(item.pinyin)},
      meaning_vi = ${escapeSql(item.meaning_vi)},
      example_hanzi = ${escapeSql(ex1.chinese)},
      example_pinyin = ${escapeSql(ex1.pinyin)},
      example_vi = ${escapeSql(ex1.meaning_vi)}
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, ${escapeSql(ex1.chinese)}, ${escapeSql(ex1.pinyin)}, ${escapeSql(ex1.meaning_vi)}, 'basic', 1),
        (v_id, ${escapeSql(ex2.chinese)}, ${escapeSql(ex2.pinyin)}, ${escapeSql(ex2.meaning_vi)}, 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

`
  }

  sql += `  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 6: #1501 -> #1600)!', v_count;
END $$;
`

  const targetPath = 'supabase/migrations/20261021260000_hsk4_examples_batch6.sql'
  fs.writeFileSync(targetPath, sql, 'utf8')
  console.log(`Đã xuất thành công: ${targetPath}`)
  console.log(`Kích thước file: ${(fs.statSync(targetPath).size / 1024).toFixed(1)} KB`)
}

generateBatch6Sql()
