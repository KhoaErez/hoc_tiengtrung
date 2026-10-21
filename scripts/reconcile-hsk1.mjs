import fs from 'fs'

const existing = JSON.parse(fs.readFileSync('scratch/current_hsk1_172.json', 'utf8'))
const officialRaw = JSON.parse(fs.readFileSync('scratch/hsk1_official_300_raw.json', 'utf8'))

// Chuẩn hóa official list: [id, hanzi, pinyin, pos, meaning_en]
const official300 = officialRaw.map(r => ({
  index: parseInt(r[0]),
  hanzi: r[1].trim(),
  pinyin: r[2].trim(),
  pos: r[3].trim(),
  meaning_en: r[4].trim(),
}))

console.log('=== KẾT QUẢ ĐỐI SOÁT HSK 1: HIỆN CÓ VS ĐỀ CƯƠNG HSK 3.0 (300 TỪ) ===\n')

// 1. Kiểm tra trùng lặp trong 172 từ hiện có
const existingHanziMap = new Map()
const duplicatesInDb = []
for (const item of existing) {
  const key = `${item.hanzi.trim()}__${item.pinyin.trim().toLowerCase()}`
  if (existingHanziMap.has(key)) {
    duplicatesInDb.push({ first: existingHanziMap.get(key), duplicate: item })
  } else {
    existingHanziMap.set(key, item)
  }
}

console.log(`1. Tổng số mục từ hiện có trong CSDL (hsk_level = 'HSK 1'): ${existing.length}`)
console.log(`2. Số bản ghi bị trùng (trùng cả chữ Hán và Pinyin): ${duplicatesInDb.length}`)

// 2. Đối soát với 300 từ chuẩn
const officialMap = new Map()
official300.forEach(w => {
  officialMap.set(w.hanzi, w)
})

const matchedInOfficial = [] // Từ hiện có nằm trong 300 từ chuẩn
const notInOfficial = []      // Từ hiện có NHƯNG không thuộc 300 từ chuẩn của HSK 1 (thuộc cấp HSK khác hoặc dư)
const missingFromOfficial = [] // Từ thuộc 300 từ chuẩn NHƯNG chưa có trong DB

for (const ex of existing) {
  const hanzi = ex.hanzi.trim()
  if (officialMap.has(hanzi)) {
    matchedInOfficial.push({ existing: ex, official: officialMap.get(hanzi) })
  } else {
    notInOfficial.push(ex)
  }
}

const existingHanziSet = new Set(existing.map(x => x.hanzi.trim()))
for (const off of official300) {
  if (!existingHanziSet.has(off.hanzi)) {
    missingFromOfficial.push(off)
  }
}

console.log(`3. Số mục từ hiện có THUỘC danh sách 300 từ chuẩn HSK 3.0: ${matchedInOfficial.length}`)
console.log(`4. Số mục từ hiện có KHÔNG THUỘC đề cương HSK 1 mới (thuộc HSK 2.0 cũ hoặc cấp khác): ${notInOfficial.length}`)
console.log(`5. Số mục từ chuẩn CÒN THIẾU cần bổ sung: ${missingFromOfficial.length}`)
console.log(`\nKiểm tra đối chiếu: ${matchedInOfficial.length} (trùng khớp) + ${missingFromOfficial.length} (còn thiếu) = ${matchedInOfficial.length + missingFromOfficial.length} / 300 chuẩn.`)

// In ra danh sách các từ hiện có không thuộc HSK 1 3.0
console.log('\n--- CÁC TỪ HIỆN CÓ TRONG DB NHƯNG THUỘC CẤP KHÁC HOẶC HSK 2.0 CŨ ---')
console.log(notInOfficial.map(w => `${w.hanzi} (${w.pinyin}): ${w.meaning_vi}`).join('; '))

// In mẫu 20 từ còn thiếu
console.log(`\n--- MẪU 20 TỪ CÒN THIẾU CẦN BỔ SUNG TRONG TỔNG SỐ ${missingFromOfficial.length} TỪ ---`)
console.log(missingFromOfficial.slice(0, 20).map(w => `#${w.index} ${w.hanzi} (${w.pinyin}) [${w.pos}]: ${w.meaning_en}`).join('\n'))

// Lưu kết quả đối soát ra scratch
fs.writeFileSync('scratch/reconciliation_result.json', JSON.stringify({
  totalExisting: existing.length,
  duplicatesInDb,
  matchedCount: matchedInOfficial.length,
  notInOfficialCount: notInOfficial.length,
  notInOfficialWords: notInOfficial,
  missingCount: missingFromOfficial.length,
  missingWords: missingFromOfficial
}, null, 2))
