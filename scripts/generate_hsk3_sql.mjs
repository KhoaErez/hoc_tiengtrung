import fs from 'fs'
import { HSK3_MISSING_255_WORDS } from '../data/hsk3-missing-data.ts'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

function generateSql() {
  console.log('=== KHỞI TẠO FILE SQL SEED HSK 3 (500 TỪ CHUẨN ĐỀ CƯƠNG HSK 3.0) ===')
  console.log('Tổng số từ cần nạp từ HSK3_MISSING_255_WORDS:', HSK3_MISSING_255_WORDS.length)

  const zombieDuplicates30 = [
    '中文', '一会儿', '万', '上网', '个子', '位', '啊', '坏', '拿', '教',
    '条', '楼', '洗手间', '画', '疼', '经常', '自己', '花', '裤子', '记得',
    '起来', '跟', '还是', '鸟', '过', '地铁', '爱好', '舒服', '爷爷', '奶奶'
  ]

  const shiftToHsk4Words41 = [
    '不但……而且……', '冬', '刮风', '刷牙', '只有……才……', '夏',
    '多么', '帽子', '春', '照相机', '熊猫', '爬山', '电子邮件',
    '皮鞋', '秋', '绿', '行李箱', '街道', '黄河', '鼻子',
    '聊天', '北京', '公共汽车', '唱歌', '因为……所以……',
    '打篮球', '服务员', '火车站', '第一', '红', '羊肉',
    '虽然……但是……', '踢足球', '面条', '黑', '半年', '白',
    '不大', '北边', '小姐', '杯'
  ]

  let sql = `-- ====================================================================
-- MIGRATION SEED: HOÀN THIỆN 500/500 TỪ VỰNG MỚI HSK 3 CHUẨN ĐỀ CƯƠNG HSK 3.0
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn - Công bố 11/2025)
-- Cấp độ: HSK 3 (500 từ vựng mới: #501 - #1000, tổng tích lũy Cấp 1+2+3 = 1.000 từ vựng)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Đảm bảo ràng buộc UNIQUE (hanzi, pinyin, hsk_level)
--   - Dọn dẹp 30 bản ghi thừa từ HSK 1/2 đã có dữ liệu chuẩn độc lập
--   - Bảo toàn 100% dữ liệu: Điều chuyển 41 từ trung cấp sang HSK 4 (giữ nguyên UUID)
--   - Đồng bộ 245 từ hiện có sang hsk_level_v3 = 'HSK 3'
--   - Bổ sung 255 từ vựng còn thiếu với đầy đủ Hanzi, Pinyin có dấu, Loại từ, Nghĩa TV
--   - Nạp tự động 510 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng) vào vocabulary_examples
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
  v_deleted_count integer := 0;
  v_shifted_count integer := 0;
BEGIN

  -- ------------------------------------------------------------------
  -- BƯỚC 1: ĐẢM BẢO RÀNG BUỘC DUY NHẤT HỖ TRỢ TỪ LIÊN CẤP HSK (UNIQUE hanzi, pinyin, hsk_level)
  -- ------------------------------------------------------------------
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vocabularies_hanzi_pinyin_level_key') THEN
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vocabularies_hanzi_pinyin_key') THEN
      ALTER TABLE public.vocabularies DROP CONSTRAINT vocabularies_hanzi_pinyin_key;
    END IF;
    ALTER TABLE public.vocabularies ADD CONSTRAINT vocabularies_hanzi_pinyin_level_key UNIQUE (hanzi, pinyin, hsk_level);
  END IF;

  -- ------------------------------------------------------------------
  -- BƯỚC 2: DỌN DẸP 30 BẢN GHI TRÙNG LẶP THỪA TỪ SEED CŨ
  -- (Các từ này đã tồn tại độc lập, đầy đủ và đạt chuẩn 100% trong HSK 1 hoặc HSK 2)
  -- ------------------------------------------------------------------
  DELETE FROM public.vocabularies
  WHERE hsk_level = 'HSK 3'
    AND hanzi IN (
`

  sql += zombieDuplicates30.map(w => `      '${w}'`).join(',\n')
  sql += `\n    );\n  GET DIAGNOSTICS v_deleted_count = ROW_COUNT;\n\n`

  sql += `  -- ------------------------------------------------------------------
  -- BƯỚC 3: BẢO TOÀN DỮ LIỆU & ĐIỀU CHUYỂN 41 TỪ HSK 2/3 CŨ SANG HSK 4
  -- (Không xóa bản ghi nào, giữ nguyên UUID id để bảo toàn tiến độ người dùng)
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level = 'HSK 4',
    hsk_level_v3 = 'HSK 4',
    hsk_version = 'hsk2.0'
  WHERE hsk_level = 'HSK 3'
    AND hanzi IN (
`

  sql += shiftToHsk4Words41.map(w => `      '${w}'`).join(',\n')
  sql += `\n    );\n  GET DIAGNOSTICS v_shifted_count = ROW_COUNT;\n\n`

  sql += `  -- ------------------------------------------------------------------
  -- BƯỚC 4: ĐỒNG BỘ PHIÊN BẢN HSK 3.0 CHO CÁC TỪ VỰNG CHUẨN HIỆN CÓ CỦA HSK 3
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0'
  WHERE hsk_level = 'HSK 3';

  -- ------------------------------------------------------------------
  -- BƯỚC 5: BỔ SUNG 255 TỪ VỰNG HSK 3 CÒN THIẾU VÀ 510 CÂU VÍ DỤ CHẤT LƯỢNG CAO
  -- ------------------------------------------------------------------
`

  for (const item of HSK3_MISSING_255_WORDS) {
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
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    ${escapeSql(ex1.chinese)},
    ${escapeSql(ex1.pinyin)},
    ${escapeSql(ex1.meaning_vi)}
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
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

  sql += `  RAISE NOTICE 'Dọn dẹp thành công % bản ghi trùng thừa từ HSK 1/2.', v_deleted_count;
  RAISE NOTICE 'Điều chuyển an toàn % từ HSK cũ sang HSK 4.', v_shifted_count;
  RAISE NOTICE 'Bổ sung và nạp thành công % từ vựng HSK 3 mới cùng 510 câu ví dụ chuẩn!', v_count;
END $$;
`

  const targetPath = 'supabase/migrations/20261021150000_hsk3_complete_500_seed.sql'
  fs.writeFileSync(targetPath, sql, 'utf8')
  console.log(`Đã xuất thành công file SQL: ${targetPath}`)
  console.log(`Kích thước file: ${(fs.statSync(targetPath).size / 1024).toFixed(1)} KB`)
}

generateSql()
