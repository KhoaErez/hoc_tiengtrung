import { createClient } from '@supabase/supabase-js'
import fs from 'fs'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function reconcileHsk2() {
  console.log('=== ĐỐI SOÁT HSK 2 HIỆN CÓ VỚI ĐỀ CƯƠNG HSK 3.0 (200 TỪ MỚI, TỔNG TÍCH LŨY 500) ===\n')

  // 1. Lấy dữ liệu thực tế HSK 2 từ Supabase
  const { data: dbWords, error } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi')
    .eq('hsk_level', 'HSK 2')

  if (error || !dbWords) {
    console.error('Lỗi khi lấy dữ liệu Supabase:', error)
    return
  }

  // 2. Đọc 200 từ chuẩn HSK 2 3.0
  const official200 = JSON.parse(fs.readFileSync('scratch/hsk2_official_200_raw.json', 'utf8'))

  // 3. Chuẩn hóa map
  const officialMap = new Map()
  for (const item of official200) {
    officialMap.set(item.hanzi.trim(), item)
  }

  // 4. Kiểm tra trùng lặp trong DB
  const seenDb = new Map()
  const dbDuplicates = []
  for (const w of dbWords) {
    const key = `${w.hanzi.trim()}__${w.pinyin?.trim().toLowerCase()}`
    if (seenDb.has(key)) {
      dbDuplicates.push(key)
    }
    seenDb.set(key, w)
  }

  // 5. Đối chiếu từ hiện có vs danh sách chuẩn
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

  // 6. Tìm từ còn thiếu trong 200 từ chuẩn
  const dbHanziSet = new Set(dbWords.map(w => w.hanzi.trim()))
  const missingWords = []
  for (const off of official200) {
    if (!dbHanziSet.has(off.hanzi.trim())) {
      missingWords.push(off)
    }
  }

  console.log('1. Tổng số từ hiện có mang nhãn "HSK 2" trong DB:', dbWords.length)
  console.log('2. Số bản ghi bị trùng trong DB:', dbDuplicates.length)
  console.log('3. Số từ hiện có THUỘC danh mục chuẩn HSK 2 (3.0):', matchedInOfficial.length)
  console.log('4. Số từ hiện có KHÔNG THUỘC danh mục 200 từ chuẩn HSK 2 (thuộc HSK 3+):', notInOfficial.length)
  console.log('5. Số từ chuẩn CÒN THIẾU cần bổ sung:', missingWords.length)
  console.log('   (Kiểm tra tổng: 200 từ chuẩn =', matchedInOfficial.length, '+', missingWords.length, ')')

  // Lưu báo cáo ra file scratch
  fs.writeFileSync('scratch/hsk2_reconciliation_result.json', JSON.stringify({
    totalDb: dbWords.length,
    duplicates: dbDuplicates,
    matchedCount: matchedInOfficial.length,
    notInOfficialCount: notInOfficial.length,
    notInOfficialWords: notInOfficial,
    missingCount: missingWords.length,
    missingWords: missingWords,
  }, null, 2), 'utf8')

  console.log('\nĐã lưu kết quả đối soát vào scratch/hsk2_reconciliation_result.json')
}

reconcileHsk2()
