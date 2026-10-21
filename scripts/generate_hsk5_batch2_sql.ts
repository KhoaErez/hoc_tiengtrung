import fs from 'fs'
import { HSK5_BATCH2_EXAMPLES } from '../data/hsk5-batch2-examples-data'

function escapeSql(str: string | undefined): string {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

function generateBatch2Sql() {
  console.log('=== KHỞI TẠO FILE SQL BỔ SUNG CÂU VÍ DỤ HSK 5 - BATCH 2 (100 TỪ TIẾP THEO) ===')
  console.log('Số lượng từ vựng:', HSK5_BATCH2_EXAMPLES.length)

  if (HSK5_BATCH2_EXAMPLES.length !== 100) {
    console.warn(`CẢNH BÁO: Số lượng từ không phải 100 (hiện có ${HSK5_BATCH2_EXAMPLES.length})`)
  }

  let sql = `-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 2 (100 TỪ TIẾP THEO)
-- Phạm vi: #2101 [差距] (chājù) -> #2201 [从而] (cóng’ér)
-- Tổng số câu ví dụ: 200 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Chuẩn hóa cột word_type (Từ loại) và meaning_vi (Nghĩa TV)
--   - Bảo tồn 100% UUID hiện có của từ vựng nếu đã tồn tại
--   - Phân biệt rõ các từ đa âm như [处] (chǔ) và [处] (chù)
--   - Chuyển cấp độ hsk_level = 'HSK 5' nếu từ đang ở cấp khác (HSK 6)
--   - Tự động thêm mới từ vựng nếu chưa có trong DB
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ các cột tương thích ngược example_hanzi, example_pinyin, example_vi
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
`

  for (let i = 0; i < HSK5_BATCH2_EXAMPLES.length; i++) {
    const item = HSK5_BATCH2_EXAMPLES[i]
    const ex1 = item.examples[0]
    const ex2 = item.examples[1]
    const wordIndex = 2101 + i
    const hasMultipleInBatch = HSK5_BATCH2_EXAMPLES.filter(x => x.hanzi === item.hanzi).length > 1

    sql += `  -- [${wordIndex}] [${item.hanzi}] (${item.pinyin}) - ${item.meaning_vi} [${item.word_type}]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = ${escapeSql(item.hanzi)} AND pinyin = ${escapeSql(item.pinyin)}
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = ${escapeSql(item.hanzi)} AND pinyin = ${escapeSql(item.pinyin)}
    LIMIT 1;
  END IF;
`

    if (!hasMultipleInBatch) {
      sql += `
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = ${escapeSql(item.hanzi)}
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = ${escapeSql(item.hanzi)}
    LIMIT 1;
  END IF;
`
    }

    sql += `
  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = ${escapeSql(item.word_type)},
      pinyin = ${escapeSql(item.pinyin)},
      meaning_vi = ${escapeSql(item.meaning_vi)},
      example_hanzi = ${escapeSql(ex1.chinese)},
      example_pinyin = ${escapeSql(ex1.pinyin)},
      example_vi = ${escapeSql(ex1.meaning_vi)}
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      ${escapeSql(item.hanzi)},
      ${escapeSql(item.pinyin)},
      ${escapeSql(item.meaning_vi)},
      ${escapeSql(item.word_type)},
      'HSK 5',
      ${escapeSql(ex1.chinese)},
      ${escapeSql(ex1.pinyin)},
      ${escapeSql(ex1.meaning_vi)}
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        ${escapeSql(ex1.chinese)},
        ${escapeSql(ex1.pinyin)},
        ${escapeSql(ex1.meaning_vi)},
        ${escapeSql(ex1.difficulty_level)},
        1
      ),
      (
        v_id,
        ${escapeSql(ex2.chinese)},
        ${escapeSql(ex2.pinyin)},
        ${escapeSql(ex2.meaning_vi)},
        ${escapeSql(ex2.difficulty_level)},
        2
      );

    v_count := v_count + 1;
  END IF;

`
  }

  sql += `  RAISE NOTICE 'Hoàn thành nạp câu ví dụ HSK 5 - Batch 2: đã xử lý % từ vựng.', v_count;
END $$;
`

  const outputPath = 'supabase/migrations/20261021320000_hsk5_examples_batch2.sql'
  fs.writeFileSync(outputPath, sql, 'utf8')
  console.log(`Đã xuất thành công file migration: ${outputPath}`)
  console.log(`Dung lượng file: ${fs.statSync(outputPath).size} bytes`)
}

generateBatch2Sql()
