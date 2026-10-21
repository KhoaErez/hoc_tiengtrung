import { createClient } from '@supabase/supabase-js'
import fs from 'fs'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function reconcileHsk3() {
  console.log('=== ĐỐI SOÁT HSK 3 HIỆN CÓ VỚI ĐỀ CƯƠNG HSK 3.0 (500 TỪ MỚI, TỔNG TÍCH LŨY 1.000) ===\n')

  // 1. Lấy dữ liệu thực tế HSK 3 từ Supabase
  const { data: dbWords, error } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi')
    .eq('hsk_level', 'HSK 3')

  if (error || !dbWords) {
    console.error('Lỗi khi lấy dữ liệu Supabase:', error)
    return
  }

  // 2. Đọc 500 từ chuẩn HSK 3 (3.0)
  const official500 = JSON.parse(fs.readFileSync('scratch/hsk3_official_500_raw.json', 'utf8'))

  // 3. Chuẩn hóa map
  const officialMap = new Map()
  for (const item of official500) {
    officialMap.set(item.hanzi.trim(), item)
  }

  // 4. Kiểm tra trùng lặp trong DB
  const seenDb = new Map()
  const dbDuplicates = []
  for (const w of dbWords) {
    const key = `${w.hanzi.trim()}__${w.pinyin?.trim().toLowerCase()}`
    if (seenDb.has(key)) {
      dbDuplicates.push({ key, id1: seenDb.get(key).id, id2: w.id })
    }
    seenDb.set(key, w)
  }

  // 5. Đối chiếu từ hiện có vs danh sách chuẩn HSK 3
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

  // 6. Tìm từ còn thiếu trong 500 từ chuẩn HSK 3
  const dbHanziSet = new Set(dbWords.map(w => w.hanzi.trim()))
  const missingWords = []
  for (const off of official500) {
    if (!dbHanziSet.has(off.hanzi.trim())) {
      missingWords.push(off)
    }
  }

  console.log('1. Tổng số từ hiện có mang nhãn "HSK 3" trong DB:', dbWords.length)
  console.log('2. Số bản ghi bị trùng trong DB:', dbDuplicates.length)
  if (dbDuplicates.length > 0) {
    console.log('   Trùng lặp:', dbDuplicates)
  }
  console.log('3. Số từ hiện có THUỘC danh mục chuẩn HSK 3 (3.0):', matchedInOfficial.length)
  console.log('4. Số từ hiện có KHÔNG THUỘC danh mục 500 từ chuẩn HSK 3 (cũ HSK 2.0 chuyển sang HSK 4+):', notInOfficial.length)
  console.log('5. Số từ chuẩn CÒN THIẾU cần bổ sung:', missingWords.length)
  console.log(`   (Kiểm tra tổng: 500 từ chuẩn = ${matchedInOfficial.length} + ${missingWords.length})`)

  // Lưu báo cáo ra file scratch
  fs.writeFileSync('scratch/hsk3_reconciliation_result.json', JSON.stringify({
    totalDb: dbWords.length,
    duplicates: dbDuplicates,
    matchedCount: matchedInOfficial.length,
    notInOfficialCount: notInOfficial.length,
    notInOfficialWords: notInOfficial,
    missingCount: missingWords.length,
    missingWords: missingWords,
  }, null, 2), 'utf8')

  console.log('\nĐã lưu kết quả đối soát vào scratch/hsk3_reconciliation_result.json')
}

reconcileHsk3()
