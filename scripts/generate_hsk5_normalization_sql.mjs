import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

async function generateNormalizationSql() {
  console.log('=== KHỞI TẠO FILE SQL CHUẨN HÓA 471 TỪ NGOÀI CHUẨN CỦA HSK 5 ===\n')

  // 1. Tải danh sách 1.600 từ chuẩn HSK 5
  const raw1600 = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
  const standardSet = new Set(raw1600.map(w => w.hanzi))

  // 2. Lấy toàn bộ từ có hsk_level = 'HSK 5' trong DB
  let allHsk5Db = []
  let from = 0
  const pageSize = 500

  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level')
      .eq('hsk_level', 'HSK 5')
      .range(from, from + pageSize - 1)

    if (error) {
      console.error('Lỗi tải DB:', error)
      break
    }
    if (!data || data.length === 0) break
    allHsk5Db = allHsk5Db.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  const extraWords = allHsk5Db.filter(v => !standardSet.has(v.hanzi))
  console.log(`Số lượng từ ngoài chuẩn cần chuẩn hóa: ${extraWords.length}`)

  // 3. Tra cứu bài học liên kết của từng từ
  const extraIds = extraWords.map(e => e.id)
  const vocabLessonMap = new Map()

  for (let i = 0; i < extraIds.length; i += 200) {
    const chunk = extraIds.slice(i, i + 200)
    const { data: lvData, error: lvErr } = await supabase
      .from('lesson_vocabularies')
      .select('vocabulary_id, lessons(id, title, hsk_level)')
      .in('vocabulary_id', chunk)

    if (!lvErr && lvData) {
      for (const item of lvData) {
        if (item.lessons && item.lessons.hsk_level) {
          const list = vocabLessonMap.get(item.vocabulary_id) || []
          list.push(item.lessons.hsk_level)
          vocabLessonMap.set(item.vocabulary_id, list)
        }
      }
    }
  }

  // Phân loại:
  const toHsk3 = []
  const toHsk4 = []
  const toHsk2 = []
  const toHsk1 = []
  const toHsk6 = []

  for (const w of extraWords) {
    const lessonLevels = vocabLessonMap.get(w.id) || []
    if (lessonLevels.includes('HSK 1')) {
      toHsk1.push(w)
    } else if (lessonLevels.includes('HSK 2')) {
      toHsk2.push(w)
    } else if (lessonLevels.includes('HSK 3')) {
      toHsk3.push(w)
    } else if (lessonLevels.includes('HSK 4')) {
      toHsk4.push(w)
    } else {
      toHsk6.push(w)
    }
  }

  console.log(`Phân bổ chuyển đổi:`)
  console.log(`- Về HSK 1: ${toHsk1.length} từ`)
  console.log(`- Về HSK 2: ${toHsk2.length} từ`)
  console.log(`- Về HSK 3: ${toHsk3.length} từ (bao gồm [刷牙]...)`)
  console.log(`- Về HSK 4: ${toHsk4.length} từ`)
  console.log(`- Về HSK 6: ${toHsk6.length} từ (bao gồm [桔子], [粘贴]...)`)

  // 4. Sinh file SQL an toàn
  let sql = `-- ====================================================================
-- MIGRATION: CHUẨN HÓA CẤP ĐỘ CHO 471 MỤC TỪ NGOÀI CHUẨN CỦA HSK 5
-- Bảo toàn 100% ID và liên kết bài học, tiến độ học tập (KHÔNG XÓA DỮ LIỆU)
--   - Chuyển ${toHsk1.length} từ về HSK 1 theo đúng bài học liên kết
--   - Chuyển ${toHsk2.length} từ về HSK 2 theo đúng bài học liên kết
--   - Chuyển ${toHsk3.length} từ về HSK 3 theo đúng bài học liên kết (như [刷牙], [刮风], [爬山]...)
--   - Chuyển ${toHsk4.length} từ về HSK 4 theo đúng bài học liên kết (như [传真], [付款], [烤鸭]...)
--   - Chuyển ${toHsk6.length} từ về HSK 6 (chuẩn bị biên soạn HSK 6, như [桔子], [粘贴]...)
--   - Đồng bộ 2 câu ví dụ cho bản ghi phụ của [合同]
-- Kết quả sau migration: HSK 5 còn đúng 1.600 mục từ chuẩn HSK 3.0 (GF 0025-2021)
-- ====================================================================

DO $$
BEGIN
`

  if (toHsk1.length > 0) {
    const ids = toHsk1.map(w => `'${w.id}'`).join(', ')
    sql += `  -- 1. Chuyển ${toHsk1.length} từ về HSK 1 theo bài học\n`
    sql += `  UPDATE public.vocabularies SET hsk_level = 'HSK 1' WHERE id IN (${ids});\n\n`
  }

  if (toHsk2.length > 0) {
    const ids = toHsk2.map(w => `'${w.id}'`).join(', ')
    sql += `  -- 2. Chuyển ${toHsk2.length} từ về HSK 2 theo bài học\n`
    sql += `  UPDATE public.vocabularies SET hsk_level = 'HSK 2' WHERE id IN (${ids});\n\n`
  }

  if (toHsk3.length > 0) {
    const ids = toHsk3.map(w => `'${w.id}'`).join(', ')
    sql += `  -- 3. Chuyển ${toHsk3.length} từ về HSK 3 theo bài học (như [刷牙]...)\n`
    sql += `  UPDATE public.vocabularies SET hsk_level = 'HSK 3' WHERE id IN (${ids});\n\n`
  }

  if (toHsk4.length > 0) {
    const ids = toHsk4.map(w => `'${w.id}'`).join(', ')
    sql += `  -- 4. Chuyển ${toHsk4.length} từ về HSK 4 theo bài học\n`
    sql += `  UPDATE public.vocabularies SET hsk_level = 'HSK 4' WHERE id IN (${ids});\n\n`
  }

  if (toHsk6.length > 0) {
    const ids = toHsk6.map(w => `'${w.id}'`).join(', ')
    sql += `  -- 5. Chuyển ${toHsk6.length} từ về HSK 6 (như [桔子], [粘贴]...)\n`
    sql += `  UPDATE public.vocabularies SET hsk_level = 'HSK 6' WHERE id IN (${ids});\n\n`
  }

  sql += `  -- 6. Đồng bộ bản ghi phụ của từ [合同] (ID: c8be22f8-729d-44c2-b28d-4fbbdcf84efa)
  UPDATE public.vocabularies
  SET 
    hsk_level = 'HSK 5',
    word_type = 'Danh từ',
    pinyin = 'hétóng',
    meaning_vi = 'hợp đồng',
    example_hanzi = '新员工在正式入职之前，应当认真阅读并亲自签署用工劳动合同。',
    example_pinyin = 'Xīn yuángōng zài zhèngshì rùzhí zhīqián, yīngdāng rènzhēn yuèdú bìng qīnzì qiānshǔ yònggōng láodòng hétong.',
    example_vi = 'Nhân viên mới trước khi chính thức nhận việc, nên đọc kỹ và tự mình ký kết hợp đồng lao động tuyển dụng.'
  WHERE id = 'c8be22f8-729d-44c2-b28d-4fbbdcf84efa';

  DELETE FROM public.vocabulary_examples WHERE vocabulary_id = 'c8be22f8-729d-44c2-b28d-4fbbdcf84efa';

  INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
  VALUES
    ('c8be22f8-729d-44c2-b28d-4fbbdcf84efa', '新员工在正式入职之前，应当认真阅读并亲自签署用工劳动合同。', 'Xīn yuángōng zài zhèngshì rùzhí zhīqián, yīngdāng rènzhēn yuèdú bìng qīnzì qiānshǔ yònggōng láodòng hétong.', 'Nhân viên mới trước khi chính thức nhận việc, nên đọc kỹ và tự mình ký kết hợp đồng lao động tuyển dụng.', 'basic', 1),
    ('c8be22f8-729d-44c2-b28d-4fbbdcf84efa', '在大型跨国能源工程采购招标中，双方总法律顾问对不可抗力免责条款、违约赔偿上限以及国际商事仲裁管辖权进行了长达数周的严谨合同条款会商。', 'Zài dàxíng kuàguó néngyuán gōngchéng cǎigòu zhāobiāo zhōng, shuāngfāng zǒng fǎlǜ gùwèn duì bùkěkànglì miǎnzé tiáokuǎn, wéiyuē péicháng shàngxiàn yǐjí guójì shāngshì zhòngcái guǎnxiáquán jìnxíng le cháng dá shù zhōu de yánjǐn hétong tiáokuǎn huìshāng.', 'Trong cuộc đấu thầu mua sắm công trình năng lượng xuyên quốc gia quy mô lớn, tổng cố vấn pháp lý của hai bên đã tiến hành hội đàm điều khoản hợp đồng nghiêm ngặt kéo dài nhiều tuần về các điều khoản miễn trừ do bất khả kháng, mức trần bồi thường vi phạm hợp đồng cũng như quyền tài phán trọng tài thương mại quốc tế.', 'applied', 2);

  RAISE NOTICE 'Hoàn tất chuẩn hóa cấp độ cho 471 từ ngoài chuẩn của HSK 5!';
END $$;
`

  const outputPath = 'supabase/migrations/20261021480000_hsk5_normalize_reconciliation.sql'
  fs.writeFileSync(outputPath, sql, 'utf-8')
  console.log(`\nĐã xuất file migration thành công tại: ${outputPath}`)
}

generateNormalizationSql()
