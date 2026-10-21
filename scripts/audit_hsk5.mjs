import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

async function auditHsk5() {
  console.log('=== KHẢO SÁT TOÀN DIỆN CƠ SỞ DỮ LIỆU HSK 5 ===\n')

  // 1. Đếm tổng số từ vựng HSK 5
  let allHsk5 = []
  let from = 0
  const pageSize = 1000
  while (true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type, example_hanzi, example_pinyin, example_vi, created_at')
      .eq('hsk_level', 'HSK 5')
      .range(from, from + pageSize - 1)
      .order('id')

    if (error) {
      console.error('Lỗi truy vấn:', error)
      return
    }
    allHsk5 = allHsk5.concat(data)
    if (data.length < pageSize) break
    from += pageSize
  }

  console.log(`1. Tổng số từ vựng HSK 5 trong bảng vocabularies: ${allHsk5.length} từ`)

  // 2. Thống kê cột word_type và meaning_vi
  const withWordType = allHsk5.filter(v => v.word_type && v.word_type.trim() !== '')
  const withMeaningVi = allHsk5.filter(v => v.meaning_vi && v.meaning_vi.trim() !== '')
  const withLegacyEx = allHsk5.filter(v => v.example_hanzi && v.example_hanzi.trim() !== '')

  console.log(`2. Tình trạng chuẩn hóa bảng vocabularies:`)
  console.log(`   - Có từ loại (word_type):    ${withWordType.length} / ${allHsk5.length} (${(withWordType.length / allHsk5.length * 100).toFixed(1)}%)`)
  console.log(`   - Có nghĩa TV (meaning_vi):   ${withMeaningVi.length} / ${allHsk5.length} (${(withMeaningVi.length / allHsk5.length * 100).toFixed(1)}%)`)
  console.log(`   - Có ví dụ cũ (example_hanzi): ${withLegacyEx.length} / ${allHsk5.length} (${(withLegacyEx.length / allHsk5.length * 100).toFixed(1)}%)`)

  // 3. Thống kê bảng vocabulary_examples cho HSK 5
  const ids = allHsk5.map(v => v.id)
  let examples = []
  for (let i = 0; i < ids.length; i += 200) {
    const chunk = ids.slice(i, i + 200)
    const { data } = await supabase
      .from('vocabulary_examples')
      .select('id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level')
      .in('vocabulary_id', chunk)
    if (data) examples = examples.concat(data)
  }

  console.log(`\n3. Bảng vocabulary_examples:`)
  console.log(`   - Tổng số câu ví dụ hiện có: ${examples.length} câu`)

  const exMap = new Map()
  for (const ex of examples) {
    const list = exMap.get(ex.vocabulary_id) || []
    list.push(ex)
    exMap.set(ex.vocabulary_id, list)
  }

  let wordsWith2Ex = 0
  let wordsWith1Ex = 0
  let wordsWith0Ex = 0

  for (const v of allHsk5) {
    const list = exMap.get(v.id) || []
    if (list.length >= 2) {
      wordsWith2Ex++
    } else if (list.length === 1) {
      wordsWith1Ex++
    } else {
      wordsWith0Ex++
    }
  }

  console.log(`   - Số từ có đủ 2 câu ví dụ: ${wordsWith2Ex} / ${allHsk5.length} (${(wordsWith2Ex / allHsk5.length * 100).toFixed(1)}%)`)
  console.log(`   - Số từ có 1 câu ví dụ:    ${wordsWith1Ex} từ`)
  console.log(`   - Số từ chưa có ví dụ:     ${wordsWith0Ex} từ`)

  // 4. In ra mẫu 10 từ đầu tiên và 10 từ cuối cùng
  console.log(`\n4. Mẫu 10 từ đầu tiên:`)
  allHsk5.slice(0, 10).forEach((v, i) => {
    console.log(`   ${i + 1}. [${v.hanzi}] (${v.pinyin}) - ${v.meaning_vi || '(chưa có nghĩa)'} | từ loại: ${v.word_type || 'chưa có'}`)
  })

  console.log(`\n5. Mẫu 10 từ cuối cùng:`)
  allHsk5.slice(-10).forEach((v, i) => {
    console.log(`   ${allHsk5.length - 10 + i + 1}. [${v.hanzi}] (${v.pinyin}) - ${v.meaning_vi || '(chưa có nghĩa)'} | từ loại: ${v.word_type || 'chưa có'}`)
  })
}

auditHsk5()
