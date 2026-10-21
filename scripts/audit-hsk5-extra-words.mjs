import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function auditExtraWords() {
  console.log('=== PHÂN TÍCH TOÀN BỘ 2.068 MỤC TỪ ĐANG MANG NHÃN HSK 5 TRONG SUPABASE ===\n')

  // 1. Tải 1.600 từ chuẩn HSK 5
  const raw1600 = JSON.parse(fs.readFileSync('scratch/hsk5_hsk1_org_raw.json', 'utf8'))
  const standardSet = new Set(raw1600.map(w => w.hanzi))
  const standardPinyinMap = new Map()
  raw1600.forEach(w => standardPinyinMap.set(w.hanzi, w.pinyin))

  // 2. Tải toàn bộ từ có hsk_level = 'HSK 5' trong DB
  let allHsk5Db = []
  let from = 0
  const pageSize = 500

  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi')
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

  console.log(`1. Tổng số bản ghi mang hsk_level = 'HSK 5' trong CSDL: ${allHsk5Db.length}`)

  // Phân loại:
  const inStandard1600 = []
  const extraNotInStandard = []

  for (const v of allHsk5Db) {
    if (standardSet.has(v.hanzi)) {
      inStandard1600.push(v)
    } else {
      extraNotInStandard.push(v)
    }
  }

  console.log(`2. Số từ thuộc danh sách 1.600 từ chuẩn HSK 3.0: ${inStandard1600.length}`)
  console.log(`3. Số từ NGOÀI danh sách 1.600 từ chuẩn HSK 3.0: ${extraNotInStandard.length}`)

  // Phân tích các từ ngoài chuẩn:
  // Đếm xem bao nhiêu từ có ví dụ trong DB, bao nhiêu từ rỗng ví dụ
  const extraIds = extraNotInStandard.map(e => e.id)
  let extraWithExamples = 0
  let extraWithoutExamples = 0

  for (let i = 0; i < extraIds.length; i += 200) {
    const chunk = extraIds.slice(i, i + 200)
    const { data: exData } = await supabase
      .from('vocabulary_examples')
      .select('vocabulary_id')
      .in('vocabulary_id', chunk)

    const exSet = new Set((exData || []).map(x => x.vocabulary_id))
    for (const id of chunk) {
      if (exSet.has(id)) {
        extraWithExamples++
      } else {
        extraWithoutExamples++
      }
    }
  }

  console.log(`\n4. Tình trạng ví dụ của ${extraNotInStandard.length} từ ngoài chuẩn:`)
  console.log(`   - Có câu ví dụ: ${extraWithExamples} từ`)
  console.log(`   - HOÀN TOÀN KHÔNG CÓ VÍ DỤ: ${extraWithoutExamples} từ`)

  // Kiểm tra liên kết bài học (lesson_vocabularies) của các từ ngoài chuẩn
  let extraInLessons = 0
  let extraNotInLessons = 0

  for (let i = 0; i < extraIds.length; i += 200) {
    const chunk = extraIds.slice(i, i + 200)
    const { data: lvData } = await supabase
      .from('lesson_vocabularies')
      .select('vocabulary_id')
      .in('vocabulary_id', chunk)

    const lvSet = new Set((lvData || []).map(x => x.vocabulary_id))
    for (const id of chunk) {
      if (lvSet.has(id)) {
        extraInLessons++
      } else {
        extraNotInLessons++
      }
    }
  }

  console.log(`\n5. Tình trạng liên kết bài học của ${extraNotInStandard.length} từ ngoài chuẩn:`)
  console.log(`   - Đang gắn trong các bài học: ${extraInLessons} từ`)
  console.log(`   - Không gắn vào bất kỳ bài học nào: ${extraNotInLessons} từ`)

  // Kiểm tra xem các từ ngoài chuẩn này thuộc cấp độ nào (HSK 1, 2, 3, 4, 6 trong đề cương)
  console.log(`\n6. Mẫu 20 từ ngoài chuẩn HSK 5 đầu tiên:`)
  extraNotInStandard.slice(0, 20).forEach((w, i) => {
    console.log(`   ${i + 1}. [${w.hanzi}] (${w.pinyin}) - ${w.meaning_vi}`)
  })
}

auditExtraWords()
