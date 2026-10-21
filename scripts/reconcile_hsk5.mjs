import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

function parseCsvLine(line) {
  // Simple CSV parser for hsk30.csv
  const parts = []
  let current = ''
  let inQuotes = false
  for (let i = 0; i < line.length; i++) {
    const char = line[i]
    if (char === '"') {
      if (inQuotes && line[i + 1] === '"') {
        current += '"'
        i++
      } else {
        inQuotes = !inQuotes
      }
    } else if (char === ',' && !inQuotes) {
      parts.push(current)
      current = ''
    } else {
      current += char
    }
  }
  parts.push(current)
  return parts
}

async function main() {
  console.log('=== ĐỐI SOÁT HSK 5 CHUẨN CTI 3.0 (1.071 TỪ) VỚI CƠ SỞ DỮ LIỆU ===')

  // 1. Đọc official HSK 5 từ scratch/hsk30.csv
  const csvContent = fs.readFileSync('scratch/hsk30.csv', 'utf8')
  const lines = csvContent.split('\n')
  const officialL5 = []
  for (const line of lines) {
    if (line.startsWith('L5-')) {
      const parts = parseCsvLine(line)
      officialL5.push({
        id: parts[0],
        hanzi: parts[1],
        traditional: parts[2],
        pinyin: parts[3],
        pos: parts[4],
        level: parts[5],
        webNo: parts[6],
      })
    }
  }

  console.log(`Đã đọc ${officialL5.length} từ HSK 5 chính thức từ scratch/hsk30.csv.`)
  fs.writeFileSync('scratch/hsk5_official_1071_raw.json', JSON.stringify(officialL5, null, 2))

  // 2. Tải toàn bộ từ vựng hiện có trong DB (HSK 5 và tất cả các cấp)
  console.log('Đang tải toàn bộ từ vựng trong DB...')
  let allVocabs = []
  let from = 0
  const pageSize = 1000
  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_version')
      .range(from, from + pageSize - 1)

    if (error) {
      console.error('Lỗi truy vấn DB:', error)
      return
    }
    allVocabs = allVocabs.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  console.log(`Tổng số từ vựng trong toàn bộ DB: ${allVocabs.length}`)

  const hsk5InDb = allVocabs.filter(v => v.hsk_level === 'HSK 5')
  console.log(`Số từ vựng đang có hsk_level = 'HSK 5': ${hsk5InDb.length}`)

  // Map theo hanzi
  const dbByHanzi = new Map()
  for (const v of allVocabs) {
    const list = dbByHanzi.get(v.hanzi) || []
    list.push(v)
    dbByHanzi.set(v.hanzi, list)
  }

  // 3. Phân loại 1.071 từ chính thức
  const inDbAsHsk5 = []
  const inDbOtherLevel = []
  const missingFromDb = []

  for (const off of officialL5) {
    const matched = dbByHanzi.get(off.hanzi)
    if (!matched || matched.length === 0) {
      missingFromDb.push(off)
    } else {
      const matchHsk5 = matched.find(m => m.hsk_level === 'HSK 5')
      if (matchHsk5) {
        inDbAsHsk5.push({ official: off, db: matchHsk5 })
      } else {
        inDbOtherLevel.push({ official: off, db: matched })
      }
    }
  }

  console.log(`\n--- KẾT QUẢ ĐỐI SOÁT 1.071 TỪ CHÍNH THỨC ---`)
  console.log(`✅ 1. Đã có trong DB với nhãn 'HSK 5': ${inDbAsHsk5.length} từ`)
  console.log(`⚠️ 2. Đã có trong DB nhưng ở cấp độ khác: ${inDbOtherLevel.length} từ`)
  console.log(`❌ 3. Hoàn toàn chưa có trong DB: ${missingFromDb.length} từ`)

  if (inDbOtherLevel.length > 0) {
    console.log(`\nMẫu từ ở cấp độ khác:`)
    inDbOtherLevel.slice(0, 10).forEach(item => {
      console.log(`  - [${item.official.hanzi}] (${item.official.pinyin}): DB có ở [${item.db.map(d => `${d.hsk_level}: ${d.pinyin}`).join(', ')}]`)
    })
  }

  // 4. Kiểm tra những từ đang ở HSK 5 trong DB mà KHÔNG thuộc 1.071 từ chính thức
  const officialHanziSet = new Set(officialL5.map(o => o.hanzi))
  const extraInDbHsk5 = hsk5InDb.filter(v => !officialHanziSet.has(v.hanzi))
  console.log(`\n--- TỪ TRONG DB CÓ 'HSK 5' NHƯNG KHÔNG NẰM TRONG 1.071 TỪ CHUẨN CTI 3.0 ---`)
  console.log(`Số lượng: ${extraInDbHsk5.length} từ`)
  console.log(`Mẫu 20 từ:`)
  extraInDbHsk5.slice(0, 20).forEach((v, i) => {
    console.log(`  ${i + 1}. [${v.hanzi}] (${v.pinyin}) - ${v.meaning_vi} (version: ${v.hsk_version})`)
  })

  // Lưu báo cáo
  fs.writeFileSync('scratch/hsk5_reconciliation_report.json', JSON.stringify({
    officialCount: officialL5.length,
    inDbAsHsk5Count: inDbAsHsk5.length,
    inDbOtherLevelCount: inDbOtherLevel.length,
    missingFromDbCount: missingFromDb.length,
    extraInDbHsk5Count: extraInDbHsk5.length,
    inDbOtherLevel,
    missingFromDb,
    extraInDbHsk5: extraInDbHsk5.map(v => ({ id: v.id, hanzi: v.hanzi, pinyin: v.pinyin, meaning_vi: v.meaning_vi, hsk_version: v.hsk_version }))
  }, null, 2))

  console.log('\nĐã lưu báo cáo chi tiết vào scratch/hsk5_reconciliation_report.json')
}

main()
