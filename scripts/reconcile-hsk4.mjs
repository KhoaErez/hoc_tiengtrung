import { createClient } from '@supabase/supabase-js'
import fs from 'fs'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function reconcileHsk4Official() {
  console.log('=== ĐỐI SOÁT HSK 4 HIỆN TẠI VỚI ĐỀ CƯƠNG HSK 3.0 CHÍNH THỨC (1.000 TỪ MỚI, TỔNG TÍCH LŨY 2.000) ===\n')

  // 1. Đọc 1.000 từ chuẩn HSK 4 (3.0)
  const official1000 = JSON.parse(fs.readFileSync('scratch/hsk4_official_1000_raw.json', 'utf8'))
  console.log(`1. Đã nạp danh sách chuẩn Đề cương HSK 3.0: ${official1000.length} từ (ID 1001 -> 2000)`)

  // 2. Lấy toàn bộ từ vựng HSK 4 hiện có trên Supabase
  let dbWords = []
  let from = 0
  const pageSize = 1000
  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi')
      .eq('hsk_level', 'HSK 4')
      .range(from, from + pageSize - 1)
      .order('id')

    if (error) {
      console.error('Lỗi khi lấy dữ liệu Supabase:', error)
      return
    }
    dbWords = dbWords.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  console.log(`2. Số mục từ HSK 4 hiện có trong DB Supabase: ${dbWords.length} từ`)

  // 3. Chuẩn hóa map chuẩn
  const officialMap = new Map()
  for (const item of official1000) {
    officialMap.set(item.hanzi.trim(), item)
  }

  // 4. Kiểm tra trùng lặp trong DB hiện tại
  const seenDb = new Map()
  const dbDuplicates = []
  for (const w of dbWords) {
    const key = `${w.hanzi.trim()}__${w.pinyin?.trim().toLowerCase()}`
    if (seenDb.has(key)) {
      dbDuplicates.push({ key, id1: seenDb.get(key).id, id2: w.id })
    }
    seenDb.set(key, w)
  }

  // 5. Đối chiếu từ hiện có vs danh sách chuẩn HSK 4
  const matchedInOfficial = []
  const notInOfficial = []
  for (const w of dbWords) {
    const hanzi = w.hanzi.trim()
    if (officialMap.has(hanzi)) {
      matchedInOfficial.push({ db: w, official: officialMap.get(hanzi) })
    } else {
      notInOfficial.push(w)
    }
  }

  // 6. Tìm từ còn thiếu trong 1.000 từ chuẩn HSK 4
  const dbHanziSet = new Set(dbWords.map(w => w.hanzi.trim()))
  const missingWords = []
  for (const off of official1000) {
    if (!dbHanziSet.has(off.hanzi.trim())) {
      missingWords.push(off)
    }
  }

  // 7. Lấy danh sách từ HSK 1, 2, 3 để rà soát các từ trong missingWords và notInOfficial
  const { data: lowerVocabs } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, hsk_level')
    .in('hsk_level', ['HSK 1', 'HSK 2', 'HSK 3'])

  const lowerMap = new Map()
  for (const lv of lowerVocabs || []) {
    lowerMap.set(lv.hanzi.trim(), lv.hsk_level)
  }

  const notInOfficialLower = []
  const notInOfficialOther = []
  for (const w of notInOfficial) {
    if (lowerMap.has(w.hanzi.trim())) {
      notInOfficialLower.push({ word: w, currentLowerLevel: lowerMap.get(w.hanzi.trim()) })
    } else {
      notInOfficialOther.push(w)
    }
  }

  console.log(`\n=== KẾT QUẢ ĐỐI SOÁT HỆ THỐNG HSK 4 ===`)
  console.log(`- Tổng số mục từ HSK 4 chuẩn HSK 3.0:           ${official1000.length} từ`)
  console.log(`- Số mục từ HSK 4 hiện có trên CSDL:            ${dbWords.length} từ`)
  console.log(`- Số từ hiện có THUỘC danh sách chuẩn HSK 4:    ${matchedInOfficial.length} từ`)
  console.log(`- Số từ còn THIẾU trong danh sách chuẩn HSK 4:  ${missingWords.length} từ`)
  console.log(`- Số từ trùng lặp trong DB HSK 4:               ${dbDuplicates.length} từ`)
  console.log(`- Số từ hiện có KHÔNG THUỘC danh sách HSK 4:    ${notInOfficial.length} từ`)
  console.log(`  + Trong đó đã có ở HSK 1, 2, 3 (bản ghi thừa): ${notInOfficialLower.length} từ`)
  console.log(`  + Thuộc HSK 5, 6, 7-9 hoặc ngoài chuẩn:        ${notInOfficialOther.length} từ`)

  // Lưu báo cáo
  const reconciliationResult = {
    officialTotal: official1000.length,
    dbTotal: dbWords.length,
    matchedCount: matchedInOfficial.length,
    missingCount: missingWords.length,
    duplicateCount: dbDuplicates.length,
    notInOfficialCount: notInOfficial.length,
    notInOfficialLowerCount: notInOfficialLower.length,
    notInOfficialOtherCount: notInOfficialOther.length,
    missingWordsSample: missingWords.slice(0, 20),
    notInOfficialSample: notInOfficial.slice(0, 20),
  }
  fs.writeFileSync('scratch/hsk4_reconciliation_result.json', JSON.stringify(reconciliationResult, null, 2), 'utf8')
  fs.writeFileSync('scratch/hsk4_missing_words.json', JSON.stringify(missingWords, null, 2), 'utf8')
  fs.writeFileSync('scratch/hsk4_not_in_official.json', JSON.stringify(notInOfficial, null, 2), 'utf8')
  console.log(`\n-> Đã lưu kết quả vào:`)
  console.log(`   * scratch/hsk4_reconciliation_result.json`)
  console.log(`   * scratch/hsk4_missing_words.json (${missingWords.length} từ còn thiếu)`)
  console.log(`   * scratch/hsk4_not_in_official.json (${notInOfficial.length} từ lệch cấp/ngoài chuẩn)`)
}

reconcileHsk4Official()
