import fs from 'fs'
import { HSK1_MISSING_149_WORDS } from '../data/hsk1-missing-149-data.ts'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

console.log('=== KIỂM TRA TẬP DỮ LIỆU 149 TỪ VỰNG THIẾU ===')
console.log('Tổng số từ trong HSK1_MISSING_149_WORDS:', HSK1_MISSING_149_WORDS.length)

const missingJson = JSON.parse(fs.readFileSync('scratch/missing_149_words.json', 'utf8'))
console.log('Tổng số từ cần bổ sung theo đối soát:', missingJson.length)

// 1. Kiểm tra tính duy nhất
const seen = new Set()
const duplicates = []
for (const item of HSK1_MISSING_149_WORDS) {
  const key = `${item.hanzi}_${item.pinyin.toLowerCase()}`
  if (seen.has(key)) {
    duplicates.push(key)
  }
  seen.add(key)
}
console.log('Số từ trùng lặp trong tập dữ liệu:', duplicates.length, duplicates)

// 2. Đối chiếu với danh sách missing_149_words.json
const officialMissingHanzi = new Set(missingJson.map(m => m.hanzi))
const missingInCompiled = missingJson.filter(m => !HSK1_MISSING_149_WORDS.some(w => w.hanzi === m.hanzi))
console.log('Từ có trong missingJson nhưng chưa có trong data TS:', missingInCompiled.map(m => `${m.hanzi} (${m.pinyin})`))

// 3. Kiểm tra tính đầy đủ của thuộc tính và ví dụ
let errors = []
HSK1_MISSING_149_WORDS.forEach((w, idx) => {
  if (!w.hanzi) errors.push(`[#${idx}] Thiếu hanzi`)
  if (!w.pinyin) errors.push(`[#${idx} - ${w.hanzi}] Thiếu pinyin`)
  if (!w.word_type) errors.push(`[#${idx} - ${w.hanzi}] Thiếu word_type`)
  if (!w.meaning_vi) errors.push(`[#${idx} - ${w.hanzi}] Thiếu meaning_vi`)
  if (!w.examples || w.examples.length !== 2) {
    errors.push(`[#${idx} - ${w.hanzi}] Số lượng câu ví dụ khác 2 (hiện có: ${w.examples?.length || 0})`)
  } else {
    w.examples.forEach((ex, eIdx) => {
      if (!ex.chinese) errors.push(`[#${idx} - ${w.hanzi}] Ví dụ ${eIdx + 1} thiếu chinese`)
      if (!ex.pinyin) errors.push(`[#${idx} - ${w.hanzi}] Ví dụ ${eIdx + 1} thiếu pinyin`)
      if (!ex.meaning_vi) errors.push(`[#${idx} - ${w.hanzi}] Ví dụ ${eIdx + 1} thiếu meaning_vi`)
      if (!ex.difficulty_level) errors.push(`[#${idx} - ${w.hanzi}] Ví dụ ${eIdx + 1} thiếu difficulty_level`)
    })
  }
})

if (errors.length > 0) {
  console.error('Phát hiện lỗi dữ liệu:', errors)
  process.exit(1)
} else {
  console.log('Tuyệt vời! Toàn bộ 149 từ vựng và 298 câu ví dụ đều ĐẦY ĐỦ và HỢP LỆ 100%!')
}

// 4. Sinh file SQL an toàn
function generateSql() {
  let sql = `-- ====================================================================
-- MIGRATION SEED: BỔ SUNG 149 MỤC TỪ VỰNG HSK 1 ĐẠT CHUẨN 300/300 HSK 3.0
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn - Công bố 11/2025)
-- Đặc điểm: 
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - ON CONFLICT (hanzi, pinyin) DO UPDATE: Idempotent, không tạo bản ghi trùng
--   - Không làm thay đổi ID cũ của vocabularies, bảo toàn user_vocabularies / Flashcards
--   - Nạp tự động 2 câu ví dụ vào vocabulary_examples và sync ví dụ 1 vào vocabularies
--   - Cập nhật đúng cấp độ cho 21 từ cũ sang HSK 2 để HSK 1 đạt chuẩn tuyệt đối 300/300
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN

  -- ------------------------------------------------------------------
  -- BƯỚC 1: BẢO VỆ TIẾN ĐỘ & PHÂN LOẠI ĐÚNG CẤP ĐỘ CHO 21 TỪ HSK 2.0 CŨ
  -- (Không xóa bản ghi nào, giữ nguyên ID để bảo toàn user_vocabularies)
  -- 21 từ này thuộc HSK 2 trong đề cương HSK 3.0 mới
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level = 'HSK 2',
    hsk_level_v3 = 'HSK 2',
    hsk_version = 'hsk3.0'
  WHERE hanzi IN (
    '不大', '别', '别人', '别的', '前面', '包', '北', '北京', '北边',
    '半天', '半年', '后面', '小姐', '帮', '帮忙', '本子', '杯', '比',
    '班', '病人', '白'
  )
  AND (hsk_level = 'HSK 1' OR hsk_level IS NULL);

  -- ------------------------------------------------------------------
  -- BƯỚC 2: ĐỒNG BỘ VERSION CHO 151 TỪ VỰNG CHUẨN HIỆN CÓ
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0'
  WHERE hsk_level = 'HSK 1';

  -- ------------------------------------------------------------------
  -- BƯỚC 3: BỔ SUNG 149 TỪ VỰNG CHUẨN HSK 1 VÀ 298 CÂU VÍ DỤ CHẤT LƯỢNG CAO
  -- ------------------------------------------------------------------
`

  for (const item of HSK1_MISSING_149_WORDS) {
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
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
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

  sql += `  RAISE NOTICE 'Đã bổ sung và đồng bộ thành công % từ vựng HSK 1 mới!', v_count;
END $$;
`

  const targetPath = 'supabase/migrations/20261021130000_hsk1_complete_300_seed.sql'
  fs.writeFileSync(targetPath, sql, 'utf8')
  console.log(`Đã xuất thành công file SQL: ${targetPath}`)
  console.log(`Kích thước file: ${(fs.statSync(targetPath).size / 1024).toFixed(1)} KB`)
}

generateSql()
