import fs from 'fs'
import { HSK2_MISSING_126_WORDS } from '../data/hsk2-missing-126-data.ts'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

function generateSql() {
  console.log('=== KHỞI TẠO FILE SQL SEED HSK 2 (200 TỪ CHUẨN ĐỀ CƯƠNG HSK 3.0) ===')
  console.log('Tổng số từ cần nạp từ HSK2_MISSING_126_WORDS:', HSK2_MISSING_126_WORDS.length)

  const notInOfficial = JSON.parse(fs.readFileSync('scratch/hsk2_30_words_to_hsk3.json', 'utf8'))

  let sql = `-- ====================================================================
-- MIGRATION SEED: HOÀN THIỆN 200/200 TỪ VỰNG MỚI HSK 2 CHUẨN ĐỀ CƯƠNG HSK 3.0
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn - Công bố 11/2025)
-- Cấp độ: HSK 2 (200 từ vựng mới, tổng tích lũy Cấp 1 + 2 = 500 từ vựng)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Điều chỉnh ràng buộc duy nhất để hỗ trợ từ đồng âm/đa nghĩa giữa các cấp (như '点')
--   - ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE: Idempotent, không sinh trùng
--   - Bảo toàn 100% dữ liệu học tập, tiến độ và Flashcards cũ của người dùng
--   - Nạp tự động 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng) vào vocabulary_examples
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN

  -- ------------------------------------------------------------------
  -- BƯỚC 1: ĐIỀU CHỈNH RÀNG BUỘC DUY NHẤT ĐỂ HỖ TRỢ TỪ ĐA NGHĨA GIỮA CÁC CẤP HSK
  -- (Giúp từ '点' có thể tồn tại ở HSK 1 là lượng từ và HSK 2 là động từ)
  -- ------------------------------------------------------------------
  IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vocabularies_hanzi_pinyin_key') THEN
    ALTER TABLE public.vocabularies DROP CONSTRAINT vocabularies_hanzi_pinyin_key;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vocabularies_hanzi_pinyin_level_key') THEN
    ALTER TABLE public.vocabularies ADD CONSTRAINT vocabularies_hanzi_pinyin_level_key UNIQUE (hanzi, pinyin, hsk_level);
  END IF;

  -- ------------------------------------------------------------------
  -- BƯỚC 2: BẢO TOÀN DỮ LIỆU & ĐIỀU CHUYỂN 30 TỪ HSK 2 CŨ SANG HSK 3
  -- (Không xóa bản ghi nào, giữ nguyên UUID id để bảo toàn user_vocabularies)
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level = 'HSK 3',
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk2.0'
  WHERE id IN (
`

  const idsFormatted = notInOfficial.map(w => `    '${w.id}'`).join(',\n')
  sql += idsFormatted + `\n  );\n\n`

  sql += `  -- ------------------------------------------------------------------
  -- BƯỚC 3: ĐỒNG BỘ PHIÊN BẢN HSK 3.0 CHO CÁC TỪ VỰNG CHUẨN HIỆN CÓ CỦA HSK 2
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level_v3 = 'HSK 2',
    hsk_version = 'hsk3.0'
  WHERE hsk_level = 'HSK 2';

  -- ------------------------------------------------------------------
  -- BƯỚC 4: BỔ SUNG CÁC TỪ VỰNG HSK 2 VÀ CÂU VÍ DỤ CHẤT LƯỢNG CAO
  -- ------------------------------------------------------------------
`

  for (const item of HSK2_MISSING_126_WORDS) {
    const ex1 = item.examples[0]
    const ex2 = item.examples[1]

    sql += `  -- [${item.hanzi}] (${item.pinyin}) - ${item.meaning_vi} [${item.word_type}]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    ${escapeSql(item.hanzi)},
    ${escapeSql(item.pinyin)},
    ${escapeSql(item.meaning_vi)},
    ${escapeSql(item.word_type)},
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    ${escapeSql(ex1.chinese)},
    ${escapeSql(ex1.pinyin)},
    ${escapeSql(ex1.meaning_vi)}
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, ${escapeSql(ex1.chinese)}, ${escapeSql(ex1.pinyin)}, ${escapeSql(ex1.meaning_vi)}, 'basic', 1),
      (v_id, ${escapeSql(ex2.chinese)}, ${escapeSql(ex2.pinyin)}, ${escapeSql(ex2.meaning_vi)}, 'applied', 2);
  END IF;

  v_count := v_count + 1;

`
  }

  sql += `  RAISE NOTICE 'Đã bổ sung và đồng bộ thành công % từ vựng HSK 2 mới!', v_count;
END $$;
`

  const targetPath = 'supabase/migrations/20261021140000_hsk2_complete_200_seed.sql'
  fs.writeFileSync(targetPath, sql, 'utf8')
  console.log(`Đã xuất thành công file SQL: ${targetPath}`)
  console.log(`Kích thước file: ${(fs.statSync(targetPath).size / 1024).toFixed(1)} KB`)
}

generateSql()
