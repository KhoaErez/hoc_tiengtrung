import fs from 'fs'
import { HSK1_BATCH1_DATA } from '../data/hsk1-batch1-data.ts'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

function generateSql() {
  let sql = `-- ====================================================================
-- SEED DATA: HSK 1 BATCH 1 (30 TỪ VỰNG & 60 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0)
-- Căn cứ Đề cương thi chính thức HSK 3.0 (CTI / chinesetest.cn - 11/2025)
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
BEGIN

`

  for (const item of HSK1_BATCH1_DATA) {
    const ex1 = item.examples[0] || { chinese: '', pinyin: '', meaning_vi: '' }
    const ex2 = item.examples[1] || { chinese: '', pinyin: '', meaning_vi: '' }

    sql += `  -- [${item.hanzi}] (${item.pinyin}) - ${item.meaning_vi}
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    ${escapeSql(item.hanzi)},
    ${escapeSql(item.pinyin)},
    ${escapeSql(item.meaning_vi)},
    ${escapeSql(item.word_type)},
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    ${escapeSql(ex1.chinese)},
    ${escapeSql(ex1.pinyin)},
    ${escapeSql(ex1.meaning_vi)}
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, ${escapeSql(ex1.chinese)}, ${escapeSql(ex1.pinyin)}, ${escapeSql(ex1.meaning_vi)}, 'basic', 1),
      (v_id, ${escapeSql(ex2.chinese)}, ${escapeSql(ex2.pinyin)}, ${escapeSql(ex2.meaning_vi)}, 'applied', 2);
  END IF;

`
  }

  sql += `END $$;
`

  fs.writeFileSync('supabase/migrations/20261021120001_hsk1_batch1_seed.sql', sql, 'utf8')
  console.log('Đã tạo thành công file: supabase/migrations/20261021120001_hsk1_batch1_seed.sql')
}

generateSql()
