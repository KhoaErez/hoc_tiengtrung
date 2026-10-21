import dotenv from 'dotenv'
dotenv.config({ path: '.env.local' })

async function test() {
  console.log('Testing KIE API...')
  console.log('URL:', process.env.KIE_BASE_URL)
  console.log('Model:', process.env.KIE_MODEL)
  try {
    const res = await fetch(process.env.KIE_BASE_URL + '/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${process.env.KIE_API_KEY}`
      },
      body: JSON.stringify({
        model: process.env.KIE_MODEL,
        messages: [{ role: 'user', content: 'Trả về JSON: {"status": "ok"}' }]
      })
    })
    console.log('Status:', res.status)
    const data = await res.json()
    console.log('Response content:', data.choices?.[0]?.message?.content)
  } catch (e) {
    console.error('Error:', e.message)
  }
}
test()
