const fs = require('fs');

async function translate() {
  const sql = fs.readFileSync('supabase/migrations/20261007000000_hsk1_vocab_seed.sql', 'utf8');
  const matches = [...sql.matchAll(/\('(.*?)', '(.*?)', '\(Cần dịch\)'/g)];
  const words = matches.map(m => m[1]);
  
  console.log(`Found ${words.length} words to translate.`);

  // Split into chunks of 100
  const chunkSize = 100;
  const chunks = [];
  for (let i = 0; i < words.length; i += chunkSize) {
    chunks.push(words.slice(i, i + chunkSize));
  }

  const translations = {};
  
  for (let i = 0; i < chunks.length; i++) {
    console.log(`Translating chunk ${i + 1}/${chunks.length}...`);
    const chunk = chunks[i];
    const prompt = `Translate the following Chinese HSK1 vocabulary words into short Vietnamese meanings. Return ONLY a valid JSON object mapping the Chinese word to its Vietnamese translation. No markdown formatting, just the raw JSON text. Example: {"爱":"yêu", "八":"tám"}
Words: ${chunk.join(', ')}`;

    const res = await fetch(process.env.KIE_BASE_URL + '/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${process.env.KIE_API_KEY}`
      },
      body: JSON.stringify({
        model: process.env.KIE_MODEL,
        messages: [{ role: 'user', content: prompt }]
      })
    });
    
    const data = await res.json();
    let text = data.choices[0].message.content;
    text = text.replace(/```json/g, '').replace(/```/g, '').trim();
    
    try {
      const parsed = JSON.parse(text);
      Object.assign(translations, parsed);
    } catch (e) {
      console.error('Failed to parse JSON:', text);
    }
  }

  console.log(`Translated ${Object.keys(translations).length} words.`);
  
  let newSql = sql;
  for (const hanzi in translations) {
    const vi = translations[hanzi].replace(/'/g, "''");
    const regex = new RegExp(`\\('${hanzi.replace(/\|/g, '\\|')}', '(.*?)', '\\(Cần dịch\\)'`, 'g');
    newSql = newSql.replace(regex, `('${hanzi}', '$1', '${vi}'`);
  }
  
  fs.writeFileSync('supabase/migrations/20261007000000_hsk1_vocab_seed.sql', newSql);
  console.log('SQL file updated successfully!');
}

translate();
