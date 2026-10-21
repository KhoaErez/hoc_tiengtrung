async function verifySidebar() {
  const res = await fetch('http://localhost:3000')
  const html = await res.text()

  const items = [
    { name: 'HSK 1', tag: 'HSK 1' },
    { name: 'HSK 2', tag: 'HSK 2' },
    { name: 'HSK 3', tag: 'HSK 3' },
    { name: 'HSK 4', tag: 'HSK 4' },
    { name: 'HSK 5', tag: 'HSK 5' },
    { name: 'HSK 6', tag: 'HSK 6' },
    { name: 'HSK 7-9', tag: 'HSK 7-9' },
    { name: 'Giao tiếp thực tế', tag: 'Giao tiếp' },
    { name: 'Tiếng Trung công xưởng', tag: 'Công xưởng' },
  ]

  console.log('=== KẾT QUẢ RENDER SIDEBAR TRÊN TRÌNH DUYỆT (SSR CHÍNH THỨC) ===')
  for (const item of items) {
    const idx = html.indexOf(`>${item.name}<`)
    if (idx === -1) {
      console.log(`❌ ${item.name}: Không tìm thấy trên HTML`)
      continue
    }
    const chunk = html.substring(idx, idx + 400)
    const badgeMatch = chunk.match(/<span[^>]*class="[^"]*text-\[10px\][^"]*"[^>]*>(.*?)<\/span>/)
    if (badgeMatch) {
      const cleanBadge = badgeMatch[1].replace(/<!-- -->/g, '').trim()
      console.log(`✅ ${item.name} (${item.tag}): [ ${cleanBadge} ]`)
    } else {
      console.log(`⚠️ ${item.name}: Không tìm thấy badge trong snippet: ${chunk}`)
    }
  }
}

verifySidebar().catch(console.error)
