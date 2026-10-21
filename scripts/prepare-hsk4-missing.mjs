import fs from 'fs'

const posMap = {
  'n.': 'Danh từ',
  'v.': 'Động từ',
  'adj.': 'Tính từ',
  'adv.': 'Phó từ',
  'prep.': 'Giới từ',
  'conj.': 'Liên từ',
  'pron.': 'Đại từ',
  'num.': 'Số từ',
  'mw.': 'Lượng từ',
  'm.': 'Lượng từ',
  'interj.': 'Thán từ',
  'part.': 'Trợ từ',
  'aux.': 'Trợ từ',
  'phr.': 'Cụm từ',
  'suffix': 'Hậu tố',
  'prefix': 'Tiền tố',
  'num.-mw.': 'Số lượng từ'
}

function posToVietnamese(pos) {
  if (!pos) return 'Từ vựng'
  const parts = pos.split('/').map(p => p.trim())
  const viParts = parts.map(p => posMap[p] || p)
  return Array.from(new Set(viParts)).join(' / ')
}

const missing = JSON.parse(fs.readFileSync('scratch/hsk4_missing_words.json', 'utf8'))
console.log('Tổng số từ cần bổ sung nghĩa tiếng Việt và loại từ:', missing.length)

// Mẫu 10 từ đầu tiên
missing.slice(0, 10).forEach((w, idx) => {
  console.log(`${idx + 1}. [${w.hanzi}] (${w.pinyin}) [${posToVietnamese(w.pos)}] EN: ${w.meaning_en}`)
})
