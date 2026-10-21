import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function runAudit() {
  console.log('=== BẮT ĐẦU AUDIT DỮ LIỆU TỪ VỰNG TRONG SUPABASE ===\n')

  // 1. Đếm tổng số từ vựng
  const { count: totalVocab, error: errTotal } = await supabase
    .from('vocabularies')
    .select('*', { count: 'exact', head: true })

  console.log('1. Tổng số từ vựng trong bảng vocabularies:', totalVocab, errTotal || '')

  // 2. Thống kê theo hsk_level
  const levels = ['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6', 'HSK 7-9', 'Giao tiếp', 'Công xưởng', 'Chưa phân loại']
  console.log('\n2. Thống kê từ vựng theo từng cấp độ (hsk_level):')
  
  for (const lvl of levels) {
    const { count: lvlCount } = await supabase
      .from('vocabularies')
      .select('*', { count: 'exact', head: true })
      .eq('hsk_level', lvl)

    const { count: withExampleCount } = await supabase
      .from('vocabularies')
      .select('*', { count: 'exact', head: true })
      .eq('hsk_level', lvl)
      .not('example_hanzi', 'is', null)
      .neq('example_hanzi', '')

    console.log(`- ${lvl}: ${lvlCount || 0} từ | Có câu ví dụ: ${withExampleCount || 0}/${lvlCount || 0} (${lvlCount ? Math.round(((withExampleCount || 0) / lvlCount) * 100) : 0}%)`)
  }

  // 3. Đếm số từ có example_hanzi trên toàn hệ thống
  const { count: totalWithExample } = await supabase
    .from('vocabularies')
    .select('*', { count: 'exact', head: true })
    .not('example_hanzi', 'is', null)
    .neq('example_hanzi', '')

  console.log(`\n3. Toàn bộ từ vựng có ví dụ: ${totalWithExample}/${totalVocab} (${Math.round((totalWithExample / totalVocab) * 100)}%)`)

  // 4. Thống kê bài học hệ thống (System Lessons)
  const { count: totalLessons } = await supabase
    .from('lessons')
    .select('*', { count: 'exact', head: true })

  const { count: systemLessons } = await supabase
    .from('lessons')
    .select('*', { count: 'exact', head: true })
    .eq('is_system', true)

  console.log(`\n4. Thống kê bài học: Tổng cộng ${totalLessons} bài | Bài học hệ thống (is_system=true): ${systemLessons}`)

  for (const lvl of levels) {
    const { count: lessonCount } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true })
      .eq('is_system', true)
      .eq('hsk_level', lvl)

    if (lessonCount && lessonCount > 0) {
      console.log(`  - Bài học ${lvl}: ${lessonCount} bài`)
    }
  }

  // 5. Thống kê lesson_vocabularies mapping
  const { count: totalLessonVocabs } = await supabase
    .from('lesson_vocabularies')
    .select('*', { count: 'exact', head: true })
  console.log(`\n5. Tổng số liên kết lesson_vocabularies: ${totalLessonVocabs}`)

  // 6. Thống kê user_vocabularies (tiến độ học tập của người dùng)
  const { count: totalUserVocabs } = await supabase
    .from('user_vocabularies')
    .select('*', { count: 'exact', head: true })
  console.log(`\n6. Tổng số bản ghi user_vocabularies (tiến độ người dùng): ${totalUserVocabs}`)

  // 7. Lấy mẫu từ vựng HSK 1
  console.log('\n7. Lấy mẫu 5 từ vựng HSK 1:')
  const { data: sampleHsk1 } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi')
    .eq('hsk_level', 'HSK 1')
    .limit(5)

  console.log(JSON.stringify(sampleHsk1, null, 2))

  // 8. Lấy mẫu từ vựng HSK 6
  console.log('\n8. Lấy mẫu 3 từ vựng HSK 6:')
  const { data: sampleHsk6 } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi')
    .eq('hsk_level', 'HSK 6')
    .limit(3)

  console.log(JSON.stringify(sampleHsk6, null, 2))

  console.log('\n=== KẾT THÚC AUDIT ===')
}

runAudit().catch(err => {
  console.error('Lỗi khi audit:', err)
})
