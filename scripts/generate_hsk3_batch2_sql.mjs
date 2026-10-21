import fs from 'fs'
import { HSK3_BATCH2_EXAMPLES } from '../data/hsk3-batch2-examples-data.js'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

function generateBatch2Sql() {
  console.log('=== KHỞI TẠO FILE SQL BỔ SUNG CÂU VÍ DỤ HSK 3 - BATCH 2 (80 TỪ) ===')
  console.log('Số lượng từ vựng:', HSK3_BATCH2_EXAMPLES.length)

  if (HSK3_BATCH2_EXAMPLES.length !== 80) {
    console.warn(`CẢNH BÁO: Số lượng từ không phải 80 (hiện có ${HSK3_BATCH2_EXAMPLES.length})`)
  }

  let sql = `-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 3 - BATCH 2 (80 TỪ)
-- Phạm vi: Từ [安静] (ānjìng) đến [瘦] (shòu)
-- Tổng số câu ví dụ: 160 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Không tạo từ mới hay bản ghi trùng trong vocabularies
--   - Cập nhật chuẩn hóa cột word_type (Từ loại)
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ cột tương thích ngược example_hanzi trên bảng vocabularies
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
`

  for (const item of HSK3_BATCH2_EXAMPLES) {
    const ex1 = item.examples[0]
    const ex2 = item.examples[1]

    sql += `  -- [${item.hanzi}] (${item.pinyin}) - ${item.meaning_vi} [${item.word_type}]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = ${escapeSql(item.hanzi)}
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = ${escapeSql(item.word_type)},
      pinyin = ${escapeSql(item.pinyin)},
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

  sql += `  RAISE NOTICE 'Hoàn thành nạp 160 câu ví dụ cho % từ vựng HSK 3 (Batch 2)!', v_count;
END $$;
`

  const targetPath = 'supabase/migrations/20261021170000_hsk3_examples_batch2.sql'
  fs.writeFileSync(targetPath, sql, 'utf8')
  console.log(`Đã xuất thành công: ${targetPath}`)
  console.log(`Kích thước file: ${(fs.statSync(targetPath).size / 1024).toFixed(1)} KB`)
}

generateBatch2Sql()
