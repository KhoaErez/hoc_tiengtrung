import fs from 'fs'

const posMap = {
  'n.': 'Danh từ',
  'v.': 'Động từ',
  'adj.': 'Tính từ',
  'adv.': 'Phó từ',
  'prep.': 'Giới từ',
  'conj.': 'Liên từ',
  'pron.': 'Đại từ',
  'num.': 'Số từ',
  'mw.': 'Lượng từ',
  'm.': 'Lượng từ',
  'interj.': 'Thán từ',
  'part.': 'Trợ từ',
  'aux.': 'Trợ từ',
  'phr.': 'Cụm từ',
  'suffix': 'Hậu tố',
  'prefix': 'Tiền tố',
  'num.-mw.': 'Số lượng từ'
}

function posToVietnamese(pos) {
  if (!pos) return 'Từ vựng'
  const parts = pos.split('/').map(p => p.trim())
  const viParts = parts.map(p => posMap[p] || p)
  return Array.from(new Set(viParts)).join(' / ')
}

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

function generateStep1Sql() {
  console.log('=== KHỞI TẠO FILE SQL CHUẨN HÓA 518 TỪ HIỆN CÓ & DỌN DẸP 121 TỪ LỆCH CẤP HSK 4 ===')

  const official1000 = JSON.parse(fs.readFileSync('scratch/hsk4_official_1000_raw.json', 'utf8'))
  const officialMap = new Map(official1000.map(o => [o.hanzi.trim(), o]))

  const misplacedPlan = JSON.parse(fs.readFileSync('scratch/hsk4_misplaced_plan.json', 'utf8'))
  const dupesWithLower = misplacedPlan.duplicateWithLower.map(w => w.hanzi.trim())
  const moveToHsk5 = [...misplacedPlan.moveToHsk5, ...misplacedPlan.moveToHsk6, ...misplacedPlan.otherLevels].map(w => w.hanzi.trim())

  console.log(`- Số từ trùng HSK 1-3 cần dọn dẹp: ${dupesWithLower.length}`)
  console.log(`- Số từ chuyển sang HSK 5: ${moveToHsk5.length}`)

  let sql = `-- ====================================================================
-- MIGRATION: HSK 4 - BƯỚC 1: DỌN DẸP 121 TỪ LỆCH CẤP & CHUẨN HÓA 518 TỪ HIỆN CÓ
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn 11/2025)
-- Đặc điểm:
--   1. Dọn dẹp ${dupesWithLower.length} bản ghi HSK 4 cũ bị trùng với từ chuẩn đã có ở HSK 1, 2, 3
--   2. Chuyển ${moveToHsk5.length} từ thuộc cấp độ cao (HSK 5, 6, 7-9) sang hsk_level = 'HSK 5'
--   3. Chuẩn hóa cột word_type (Từ loại tiếng Việt) cho 518 từ HSK 4 chuẩn hiện có
--   4. Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
-- ====================================================================

DO $$
DECLARE
  v_del_count integer := 0;
  v_move_count integer := 0;
  v_norm_count integer := 0;
BEGIN
  -- 1. XÓA BẢN GHI HSK 4 CŨ BỊ TRÙNG VỚI TỪ ĐÃ CÓ Ở HSK 1, 2, 3
`

  // Dọn dẹp các từ trùng
  const dupeChunks = []
  for (let i = 0; i < dupesWithLower.length; i += 20) {
    dupeChunks.push(dupesWithLower.slice(i, i + 20))
  }

  for (const chunk of dupeChunks) {
    const listStr = chunk.map(h => escapeSql(h)).join(', ')
    sql += `  DELETE FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi IN (${listStr});
`
  }

  sql += `
  -- 2. CHUYỂN CÁC TỪ CẤP CAO (HSK 5, 6, 7-9) TỪ HSK 4 SANG HSK 5
`

  const moveChunks = []
  for (let i = 0; i < moveToHsk5.length; i += 20) {
    moveChunks.push(moveToHsk5.slice(i, i + 20))
  }

  for (const chunk of moveChunks) {
    const listStr = chunk.map(h => escapeSql(h)).join(', ')
    sql += `  UPDATE public.vocabularies 
  SET hsk_level = 'HSK 5'
  WHERE hsk_level = 'HSK 4' AND hanzi IN (${listStr});
`
  }

  sql += `
  -- 3. CHUẨN HÓA CỘT word_type (TỪ LOẠI TIẾNG VIỆT) CHO 518 TỪ HSK 4 CHUẨN HIỆN CÓ
`

  for (const off of official1000) {
    const hanzi = off.hanzi.trim()
    const viWordType = posToVietnamese(off.pos)
    sql += `  UPDATE public.vocabularies
  SET 
    word_type = ${escapeSql(viWordType)},
    pinyin = ${escapeSql(off.pinyin)}
  WHERE hsk_level = 'HSK 4' AND hanzi = ${escapeSql(hanzi)};
`
  }

  sql += `
  GET DIAGNOSTICS v_norm_count = ROW_COUNT;
  RAISE NOTICE 'Hoàn tất Bước 1: Đã dọn dẹp và chuẩn hóa thành công toàn bộ từ vựng HSK 4 hiện có!';
END $$;
`

  const targetPath = 'supabase/migrations/20261021190000_hsk4_normalize_existing.sql'
  fs.writeFileSync(targetPath, sql, 'utf8')
  console.log(`Đã xuất thành công: ${targetPath}`)
  console.log(`Kích thước file: ${(fs.statSync(targetPath).size / 1024).toFixed(1)} KB`)
}

generateStep1Sql()
