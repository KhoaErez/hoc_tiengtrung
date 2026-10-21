import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function verifyHsk5Batch11() {
  console.log('=== KIỂM TRA XÁC MINH HSK 5 - BATCH 11 (#3002 -> #3101) ===\n')

  const batch11Words = JSON.parse(fs.readFileSync('scratch/batch11_hsk5_words.json', 'utf8'))

  // 1. Lấy dữ liệu bảng vocabularies
  const hanziList = Array.from(new Set(batch11Words.map(w => w.hanzi)))

  const { data: vocabs, error: vErr } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi')
    .in('hanzi', hanziList)
    .eq('hsk_level', 'HSK 5')

  if (vErr) {
    console.error('Lỗi khi truy vấn vocabularies:', vErr)
    return
  }

  console.log(`1. Số mục từ Batch 11 đã có hsk_level = 'HSK 5': ${vocabs.length} / 100`)

  // Kiểm tra word_type
  const withWordType = vocabs.filter(v => v.word_type && v.word_type.trim() !== '')
  console.log(`2. Số từ vựng đã có word_type: ${withWordType.length} / ${vocabs.length}`)

  // 2. Lấy dữ liệu bảng vocabulary_examples
  const vocabIds = vocabs.map(v => v.id)
  let examples = []
  for (let i = 0; i < vocabIds.length; i += 100) {
    const chunk = vocabIds.slice(i, i + 100)
    const { data: exData } = await supabase
      .from('vocabulary_examples')
      .select('id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level')
      .in('vocabulary_id', chunk)
    if (exData) examples = examples.concat(exData)
  }

  const exMap = new Map()
  for (const ex of examples) {
    const list = exMap.get(ex.vocabulary_id) || []
    list.push(ex)
    exMap.set(ex.vocabulary_id, list)
  }

  let wordsWith2Ex = 0
  let wordsWith1Ex = 0
  let wordsWith0Ex = 0

  for (const v of vocabs) {
    const list = exMap.get(v.id) || []
    if (list.length >= 2) {
      wordsWith2Ex++
    } else if (list.length === 1) {
      wordsWith1Ex++
    } else {
      wordsWith0Ex++
    }
  }

  console.log(`\n3. Thống kê câu ví dụ bảng vocabulary_examples:`)
  console.log(`   - Tổng số câu ví dụ: ${examples.length} câu`)
  console.log(`   - Số từ có đủ 2 câu ví dụ: ${wordsWith2Ex} / ${vocabs.length} (${(wordsWith2Ex / vocabs.length * 100).toFixed(1)}%)`)
  console.log(`   - Số từ chỉ có 1 câu ví dụ: ${wordsWith1Ex}`)
  console.log(`   - Số từ chưa có ví dụ:      ${wordsWith0Ex}`)

  // In mẫu 5 từ đầu tiên
  console.log(`\n4. Mẫu 5 từ vựng đầu tiên của Batch 11 sau khi nạp:\n`)
  vocabs.slice(0, 5).forEach((v, i) => {
    const exList = exMap.get(v.id) || []
    console.log(`   ${i + 1}. [${v.hanzi}] (${v.pinyin}) [${v.word_type}] - ${v.meaning_vi}`)
    exList.forEach(e => {
      console.log(`      * [${e.difficulty_level}] ${e.chinese} (${e.pinyin}) -> ${e.meaning_vi}`)
    })
    console.log('')
  })
}

verifyHsk5Batch11()
