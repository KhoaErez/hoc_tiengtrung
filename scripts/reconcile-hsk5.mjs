import { createClient } from '@supabase/supabase-js'
import fs from 'fs'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function reconcileHsk5Official() {
  console.log('=== ĐỐI SOÁT TOÀN DIỆN HSK 5 HIỆN TẠI VỚI ĐỀ CƯƠNG HSK 3.0 CHUẨN (1.600 TỪ MỚI, TỔNG TÍCH LŨY 3.600) ===\n')

  // 1. Đọc 1.600 từ chuẩn HSK 5 từ scratch/hsk5_hsk1_org_raw.json
  const official1600 = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
  console.log(`1. Đã nạp danh sách chuẩn Đề cương HSK 3.0: ${official1600.length} từ (ID 2001 -> 3600)`)

  // 2. Lấy toàn bộ từ vựng HSK 5 hiện có trên Supabase
  let dbWords = []
  let from = 0
  const pageSize = 1000
  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_version, example_hanzi')
      .eq('hsk_level', 'HSK 5')
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

  console.log(`2. Số mục từ HSK 5 hiện có trong DB Supabase: ${dbWords.length} từ`)

  // 3. Chuẩn hóa map chuẩn
  const officialMap = new Map()
  for (const item of official1600) {
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

  // 5. Đối chiếu từ hiện có vs danh sách chuẩn HSK 5
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

  // 6. Tìm từ còn thiếu trong 1.600 từ chuẩn HSK 5
  const dbHanziSet = new Set(dbWords.map(w => w.hanzi.trim()))
  const missingWords = []
  for (const off of official1600) {
    if (!dbHanziSet.has(off.hanzi.trim())) {
      missingWords.push(off)
    }
  }

  // 7. Lấy danh sách từ HSK 1, 2, 3, 4 để rà soát các từ trong notInOfficial
  let lowerVocabs = []
  from = 0
  while (true) {
    const { data } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, hsk_level')
      .in('hsk_level', ['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4'])
      .range(from, from + pageSize - 1)
    if (!data || data.length === 0) break
    lowerVocabs = lowerVocabs.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  const lowerMap = new Map()
  for (const lv of lowerVocabs || []) {
    lowerMap.set(lv.hanzi.trim(), lv.hsk_level)
  }

  // Lấy thêm HSK 6 để xem missingWords có nằm trong HSK 6 không
  let hsk6Vocabs = []
  from = 0
  while (true) {
    const { data } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level')
      .eq('hsk_level', 'HSK 6')
      .range(from, from + pageSize - 1)
    if (!data || data.length === 0) break
    hsk6Vocabs = hsk6Vocabs.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  const hsk6Map = new Map()
  for (const w of hsk6Vocabs) {
    hsk6Map.set(w.hanzi.trim(), w)
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

  // Trong missingWords, bao nhiêu từ đang nằm ở HSK 6?
  const missingInHsk6 = []
  const missingCompletely = []
  for (const m of missingWords) {
    if (hsk6Map.has(m.hanzi.trim())) {
      missingInHsk6.push({ official: m, hsk6: hsk6Map.get(m.hanzi.trim()) })
    } else {
      missingCompletely.push(m)
    }
  }

  console.log(`\n=== KẾT QUẢ ĐỐI SOÁT HỆ THỐNG HSK 5 ===`)
  console.log(`- Tổng số mục từ HSK 5 chuẩn HSK 3.0:           ${official1600.length} từ (#2001 -> #3600)`)
  console.log(`- Số mục từ HSK 5 hiện có trên CSDL:            ${dbWords.length} từ`)
  console.log(`- Số từ hiện có THUỘC danh sách chuẩn HSK 5:    ${matchedInOfficial.length} từ`)
  console.log(`- Số từ còn THIẾU trong danh sách chuẩn HSK 5:  ${missingWords.length} từ`)
  console.log(`  + Đang nằm ở HSK 6 (cần chuyển về HSK 5):      ${missingInHsk6.length} từ`)
  console.log(`  + Hoàn toàn chưa có trong DB (cần thêm mới):   ${missingCompletely.length} từ`)
  console.log(`- Số từ trùng lặp trong DB HSK 5:               ${dbDuplicates.length} từ`)
  console.log(`- Số từ hiện có KHÔNG THUỘC danh sách HSK 5:    ${notInOfficial.length} từ`)
  console.log(`  + Trong đó đã có ở HSK 1, 2, 3, 4 (thừa):      ${notInOfficialLower.length} từ`)
  console.log(`  + Thuộc HSK 6, 7-9 hoặc ngoài chuẩn 3.0:       ${notInOfficialOther.length} từ`)

  // Lưu báo cáo
  const reconciliationResult = {
    officialTotal: official1600.length,
    dbTotal: dbWords.length,
    matchedCount: matchedInOfficial.length,
    missingCount: missingWords.length,
    missingInHsk6Count: missingInHsk6.length,
    missingCompletelyCount: missingCompletely.length,
    duplicateCount: dbDuplicates.length,
    notInOfficialCount: notInOfficial.length,
    notInOfficialLowerCount: notInOfficialLower.length,
    notInOfficialOtherCount: notInOfficialOther.length,
    missingInHsk6Sample: missingInHsk6.slice(0, 20),
    missingCompletelySample: missingCompletely.slice(0, 20),
    notInOfficialLowerSample: notInOfficialLower.slice(0, 20),
    notInOfficialOtherSample: notInOfficialOther.slice(0, 20),
  }

  fs.writeFileSync('scratch/hsk5_reconciliation_result.json', JSON.stringify(reconciliationResult, null, 2), 'utf8')
  fs.writeFileSync('scratch/hsk5_missing_words.json', JSON.stringify(missingWords, null, 2), 'utf8')
  fs.writeFileSync('scratch/hsk5_missing_in_hsk6.json', JSON.stringify(missingInHsk6, null, 2), 'utf8')
  fs.writeFileSync('scratch/hsk5_missing_completely.json', JSON.stringify(missingCompletely, null, 2), 'utf8')
  fs.writeFileSync('scratch/hsk5_not_in_official.json', JSON.stringify(notInOfficial, null, 2), 'utf8')

  console.log(`\n-> Đã lưu kết quả đối soát vào:`)
  console.log(`   * scratch/hsk5_reconciliation_result.json`)
  console.log(`   * scratch/hsk5_missing_words.json (${missingWords.length} từ)`)
  console.log(`   * scratch/hsk5_missing_in_hsk6.json (${missingInHsk6.length} từ có thể chuyển từ HSK 6)`)
  console.log(`   * scratch/hsk5_missing_completely.json (${missingCompletely.length} từ cần insert mới)`)
  console.log(`   * scratch/hsk5_not_in_official.json (${notInOfficial.length} từ lệch cấp)`)
}

reconcileHsk5Official()
