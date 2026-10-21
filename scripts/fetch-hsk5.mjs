import fs from 'fs'

async function main() {
  console.log('Fetching https://hsk1.org/hsk/5/vocabulary ...')
  try {
    const res = await fetch('https://hsk1.org/hsk/5/vocabulary', {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.5'
      }
    })

    console.log('Response status:', res.status)
    if (!res.ok) {
      console.log('Không fetch được hsk1.org/hsk/5/vocabulary')
      return
    }

    const html = await res.text()
    console.log('HTML size:', html.length, 'bytes')

    const trRegex = /<tr[^>]*data-vocabulary-row="true"[^>]*>([\s\S]*?)<\/tr>/g
    let match
    const rows = []
    while ((match = trRegex.exec(html)) !== null) {
      const rowHtml = match[1]
      const tdRegex = /<td[^>]*>([\s\S]*?)<\/td>/g
      let tdMatch
      const cells = []
      while ((tdMatch = tdRegex.exec(rowHtml)) !== null) {
        const cleanText = tdMatch[1].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim()
        cells.push(cleanText)
      }
      if (cells.length >= 5) {
        rows.push({
          id: parseInt(cells[0]),
          hanzi: cells[1],
          pinyin: cells[2],
          pos: cells[3],
          meaning_en: cells[4],
        })
      }
    }

    console.log('Total extracted rows:', rows.length)
    if (rows.length > 0) {
      console.log('First 5:', rows.slice(0, 5))
      console.log('Last 5:', rows.slice(-5))
      fs.writeFileSync('scratch/hsk5_page_raw.html', html, 'utf8')
      fs.writeFileSync('scratch/hsk5_hsk1_org_raw.json', JSON.stringify(rows, null, 2))
    }
  } catch (err) {
    console.error('Fetch error:', err.message)
  }
}

main()
