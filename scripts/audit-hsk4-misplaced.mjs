import { createClient } from '@supabase/supabase-js'
import fs from 'fs'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function auditMisplaced() {
  console.log('=== KIỂM TRA RÀNG BUỘC CỦA 121 TỪ LỆCH CẤP HSK 4 ===\n')

  const notInOfficial = JSON.parse(fs.readFileSync('scratch/hsk4_not_in_official.json', 'utf8'))
  console.log(`Số lượng từ lệch cấp: ${notInOfficial.length}`)

  const ids = notInOfficial.map(w => w.id)

  // 1. Kiểm tra bảng user_vocabularies
  const { count: uvCount } = await supabase
    .from('user_vocabularies')
    .select('id', { count: 'exact', head: true })
    .in('vocabulary_id', ids)

  // 2. Kiểm tra bảng vocabulary_examples
  const { count: exCount } = await supabase
    .from('vocabulary_examples')
    .select('id', { count: 'exact', head: true })
    .in('vocabulary_id', ids)

  console.log(`1. Số bản ghi liên kết trong user_vocabularies: ${uvCount || 0}`)
  console.log(`2. Số bản ghi liên kết trong vocabulary_examples: ${exCount || 0}`)

  // 3. Phân loại 121 từ
  // Đọc danh mục toàn bộ HSK 3.0 từ hsk30.csv để biết chính xác cấp độ mới của 121 từ này
  const csvLines = fs.readFileSync('scratch/hsk30.csv', 'utf8').split('\n')
  const mapLevel = new Map()
  for (let i = 1; i < csvLines.length; i++) {
    const parts = csvLines[i].split(',')
    const hanzi = parts[1]
    const level = parts[5]
    if (hanzi) {
      mapLevel.set(hanzi.trim(), level)
    }
  }

  const { data: lowerVocabs } = await supabase
    .from('vocabularies')
    .select('id, hanzi, hsk_level')
    .in('hsk_level', ['HSK 1', 'HSK 2', 'HSK 3'])

  const lowerSet = new Set((lowerVocabs || []).map(v => v.hanzi.trim()))

  let duplicateWithLower = []
  let moveToHsk5 = []
  let moveToHsk6 = []
  let otherLevels = []

  for (const w of notInOfficial) {
    const h = w.hanzi.trim()
    const lvl = mapLevel.get(h)
    if (lowerSet.has(h)) {
      duplicateWithLower.push(w)
    } else if (lvl === '5') {
      moveToHsk5.push(w)
    } else if (lvl === '6') {
      moveToHsk6.push(w)
    } else {
      otherLevels.push({ ...w, targetLevel: lvl || 'HSK 5' })
    }
  }

  console.log(`\nPhân loại phương án xử lý:`)
  console.log(`- Nhóm 1: Trùng với từ đã có ở HSK 1, 2, 3 (cần xóa bản ghi thừa HSK 4): ${duplicateWithLower.length} từ`)
  console.log(`- Nhóm 2: Thuộc HSK 5 trong HSK 3.0 (cần cập nhật hsk_level = 'HSK 5'): ${moveToHsk5.length} từ`)
  console.log(`- Nhóm 3: Thuộc HSK 6 trong HSK 3.0 (cần cập nhật hsk_level = 'HSK 6'): ${moveToHsk6.length} từ`)
  console.log(`- Nhóm 4: Các từ khác (thuộc HSK 7-9 hoặc ngoài chuẩn, cập nhật sang HSK 5): ${otherLevels.length} từ`)

  fs.writeFileSync('scratch/hsk4_misplaced_plan.json', JSON.stringify({
    duplicateWithLower,
    moveToHsk5,
    moveToHsk6,
    otherLevels
  }, null, 2), 'utf8')
  console.log('\n-> Đã lưu chi tiết kế hoạch vào scratch/hsk4_misplaced_plan.json')
}

auditMisplaced()
