import dotenv from 'dotenv'
dotenv.config({ path: '.env.local' })

async function testGemini() {
  const apiKey = process.env.GEMINI_API_KEY
  if (!apiKey) {
    console.log('No GEMINI_API_KEY found')
    return
  }
  const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-3.8-flash:generateContent?key=${apiKey}`
  try {
    const res = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [{ parts: [{ text: 'Dịch nghĩa từ vựng: 爱心 -> tiếng Việt ngắn gọn' }] }]
      })
    })
    const data = await res.json()
    console.log('Gemini status:', res.status)
    if (data.candidates) {
      console.log('Gemini reply:', data.candidates[0].content.parts[0].text)
    } else {
      console.log('Gemini error response:', data)
    }
  } catch (e) {
    console.error('Fetch error:', e.message)
  }
}

testGemini()
