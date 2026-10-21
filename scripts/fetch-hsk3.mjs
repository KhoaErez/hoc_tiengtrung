import fs from 'fs'

async function main() {
  console.log('Fetching https://hsk1.org/hsk/3/vocabulary ...')
  const res = await fetch('https://hsk1.org/hsk/3/vocabulary', {
    headers: {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.5'
    }
  })

  console.log('Response status:', res.status)
  if (!res.ok) {
    throw new Error(`Failed to fetch: ${res.status} ${res.statusText}`)
  }

  const html = await res.text()
  console.log('HTML size:', html.length, 'bytes')

  const rowCount = (html.match(/data-vocabulary-row="true"/g) || []).length
  console.log('Rows count found in HTML:', rowCount)

  fs.writeFileSync('scratch/hsk3_page_raw.html', html, 'utf8')
  console.log('Saved to scratch/hsk3_page_raw.html')
}

main().catch(err => {
  console.error('Fetch error:', err)
  process.exit(1)
})
