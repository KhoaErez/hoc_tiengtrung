import { createClient } from '@supabase/supabase-js'
import fs from 'fs'

const SUPABASE_URL = 'https://jjzosgzwhhqpfldwztwu.supabase.co'
const SUPABASE_ANON_KEY = 'sb_publishable_bd8v48OpcpEFGvDT5UI5CA_k31XUeOq'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function auditHsk3Examples() {
  console.log('====================================================================')
  console.log('AUDIT TOÀN DIỆN CÂU VÍ DỤ CỦA 500 MỤC TỪ VỰNG HSK 3 TRÊN SUPABASE')
  console.log('====================================================================\n')

  // 1. Lấy toàn bộ 500 từ HSK 3 từ bảng vocabularies
  const { data: hsk3Words, error: vocabErr } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type, example_hanzi, example_pinyin, example_vi')
    .eq('hsk_level', 'HSK 3')
    .order('hanzi', { ascending: true })

  if (vocabErr || !hsk3Words) {
    console.error('Lỗi truy vấn bảng vocabularies:', vocabErr)
    return
  }

  console.log(`1. Tổng số mục từ HSK 3 thực tế trong DB: ${hsk3Words.length}`)

  const vocabIds = hsk3Words.map(w => w.id)

  // 2. Lấy toàn bộ câu ví dụ từ bảng vocabulary_examples cho các từ HSK 3
  // Chú ý: Vì 500 ID vượt giới hạn URL query, ta chia làm các batch 100 ID để query
  const allExamples = []
  const BATCH_SIZE = 100
  for (let i = 0; i < vocabIds.length; i += BATCH_SIZE) {
    const chunkIds = vocabIds.slice(i, i + BATCH_SIZE)
    const { data: exChunk, error: exErr } = await supabase
      .from('vocabulary_examples')
      .select('id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index')
      .in('vocabulary_id', chunkIds)
      .order('order_index', { ascending: true })

    if (exErr) {
      console.error(`Lỗi truy vấn chunk ví dụ ${i}:`, exErr)
    } else if (exChunk) {
      allExamples.push(...exChunk)
    }
  }

  console.log(`2. Tổng số câu ví dụ trong bảng vocabulary_examples liên kết với HSK 3: ${allExamples.length}`)

  // 3. Phân loại theo vocabulary_id
  const exByVocab = new Map()
  for (const ex of allExamples) {
    const list = exByVocab.get(ex.vocabulary_id) || []
    list.push(ex)
    exByVocab.set(ex.vocabulary_id, list)
  }

  // 4. Thống kê chi tiết
  const wordsWith2PlusEx = []
  const wordsWith1Ex = []
  const wordsWith0Ex = []

  let totalExamplesWithMissingPinyin = 0
  let totalExamplesWithMissingVi = 0
  const duplicateSentenceCheck = new Map()
  let duplicateSentenceCount = 0

  for (const ex of allExamples) {
    if (!ex.pinyin || ex.pinyin.trim() === '') totalExamplesWithMissingPinyin++
    if (!ex.meaning_vi || ex.meaning_vi.trim() === '') totalExamplesWithMissingVi++

    const key = ex.chinese?.trim()
    if (duplicateSentenceCheck.has(key)) {
      duplicateSentenceCount++
    }
    duplicateSentenceCheck.set(key, (duplicateSentenceCheck.get(key) || 0) + 1)
  }

  for (const w of hsk3Words) {
    const tableEx = exByVocab.get(w.id) || []
    const count = tableEx.length

    if (count >= 2) {
      wordsWith2PlusEx.push({ vocab: w, examples: tableEx })
    } else if (count === 1) {
      wordsWith1Ex.push({ vocab: w, examples: tableEx })
    } else {
      // count === 0: kiểm tra xem có fallback ở example_hanzi trong vocabularies không
      const hasFallback = !!(w.example_hanzi && w.example_hanzi.trim() !== '')
      wordsWith0Ex.push({ vocab: w, hasFallback, fallbackHanzi: w.example_hanzi })
    }
  }

  console.log('\n--- KẾT QUẢ PHÂN BỔ CÂU VÍ DỤ ---')
  console.log(`- Số mục từ đã có ĐỦ 2 câu ví dụ trở lên: ${wordsWith2PlusEx.length} (${(wordsWith2PlusEx.length / 500 * 100).toFixed(1)}%)`)
  console.log(`- Số mục từ chỉ có 1 câu ví dụ: ${wordsWith1Ex.length}`)
  console.log(`- Số mục từ CHƯA CÓ câu ví dụ nào trong vocabulary_examples: ${wordsWith0Ex.length} (${(wordsWith0Ex.length / 500 * 100).toFixed(1)}%)`)

  const wordsWith0ExHavingFallback = wordsWith0Ex.filter(w => w.hasFallback)
  const wordsWith0ExNoFallback = wordsWith0Ex.filter(w => !w.hasFallback)
  console.log(`  + Trong ${wordsWith0Ex.length} từ chưa có ví dụ:`)
  console.log(`    * Có ví dụ cũ ở cột vocabularies.example_hanzi: ${wordsWith0ExHavingFallback.length}`)
  console.log(`    * Hoàn toàn KHÔNG CÓ câu ví dụ nào (kể cả cột cũ): ${wordsWith0ExNoFallback.length}`)

  console.log('\n--- CHẤT LƯỢNG NỘI DUNG CÂU VÍ DỤ HIỆN CÓ ---')
  console.log(`- Số câu ví dụ bị thiếu Pinyin: ${totalExamplesWithMissingPinyin}`)
  console.log(`- Số câu ví dụ bị thiếu bản dịch tiếng Việt: ${totalExamplesWithMissingVi}`)
  console.log(`- Số câu ví dụ trùng lặp nội dung chữ Hán: ${duplicateSentenceCount}`)

  // 5. Lưu danh sách chi tiết các từ thiếu ra file JSON để phục vụ bước lập kế hoạch bổ sung
  const missingAnalysis = {
    totalHsk3: hsk3Words.length,
    wordsWith2PlusExCount: wordsWith2PlusEx.length,
    wordsWith1ExCount: wordsWith1Ex.length,
    wordsWith0ExCount: wordsWith0Ex.length,
    wordsWith0ExList: wordsWith0Ex.map(w => ({
      id: w.vocab.id,
      hanzi: w.vocab.hanzi,
      pinyin: w.vocab.pinyin,
      word_type: w.vocab.word_type,
      meaning_vi: w.vocab.meaning_vi,
      hasFallback: w.hasFallback,
      fallbackHanzi: w.fallbackHanzi
    })),
    wordsWith1ExList: wordsWith1Ex.map(w => ({
      id: w.vocab.id,
      hanzi: w.vocab.hanzi,
      pinyin: w.vocab.pinyin,
      word_type: w.vocab.word_type,
      meaning_vi: w.vocab.meaning_vi,
      existingExample: w.examples[0]
    }))
  }

  fs.writeFileSync('scratch/hsk3_examples_audit_result.json', JSON.stringify(missingAnalysis, null, 2), 'utf8')
  console.log('\nĐã lưu toàn bộ kết quả audit chi tiết vào: scratch/hsk3_examples_audit_result.json')
}

auditHsk3Examples()
