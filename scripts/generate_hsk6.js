const fs = require('fs');

async function main() {
  const data = require('@leonsilicon/hsk2.0');
  const words = data.hsk20WordsLevel6; // 2500 words
  
  console.log(`Found ${words.length} words for HSK 6`);
  
  const translations = [];
  const chunkSize = 100; // Increased chunk size
  const chunks = [];
  for (let i = 0; i < words.length; i += chunkSize) {
    chunks.push(words.slice(i, i + chunkSize));
  }

  const limit = 5; // Concurrent requests limit
  let active = 0;
  let index = 0;

  await new Promise((resolve) => {
    const next = () => {
      if (index >= chunks.length && active === 0) {
        resolve();
        return;
      }
      while (active < limit && index < chunks.length) {
        const currentIndex = index++;
        const chunk = chunks[currentIndex];
        active++;
        
        console.log(`Translating chunk ${currentIndex + 1}/${chunks.length}...`);
        const prompt = `You are a dictionary tool. For the following Chinese HSK6 vocabulary words, provide their standard Pinyin and short Vietnamese meanings. 
Return ONLY a valid JSON array of objects. No markdown formatting, just the raw JSON text. 
Example: [{"hanzi":"爱", "pinyin":"ài", "vi":"yêu"}]
Words: ${chunk.join(', ')}`;

        const req = async () => {
          let retryCount = 0;
          while (retryCount < 3) {
            try {
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
              
              const resData = await res.json();
              let text = resData.choices[0].message.content;
              text = text.replace(/```json/g, '').replace(/```/g, '').trim();
              
              const parsed = JSON.parse(text);
              return parsed;
            } catch (e) {
              retryCount++;
              console.error(`Failed to parse JSON for chunk ${currentIndex+1}, retrying... (${retryCount}/3)`);
            }
          }
          return [];
        };

        req().then(parsed => {
          translations.push(...parsed);
          active--;
          next();
        });
      }
    };
    next();
  });

  let sql = `-- HSK 6 2012 Version (2500 words)
INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
VALUES
`;

  const values = [];
  for (const item of translations) {
    const hanzi = item.hanzi;
    let pinyin = (item.pinyin || '');
    let vi = (item.vi || '(Cần dịch)');
    
    // Escape single quotes for SQL
    vi = vi.replace(/'/g, "''");
    pinyin = pinyin.replace(/'/g, "''");
    
    values.push(`  ('${hanzi}', '${pinyin}', '${vi}', '', 'HSK 6')`);
  }
  
  sql += values.join(',\n') + '\nON CONFLICT (hanzi, pinyin) DO UPDATE SET hsk_level = EXCLUDED.hsk_level, meaning_vi = EXCLUDED.meaning_vi;\n';
  
  fs.writeFileSync('supabase/migrations/20261007000006_hsk6_2012_vocab_seed.sql', sql);
  console.log('SQL file written successfully to 20261007000006_hsk6_2012_vocab_seed.sql');
}

main().catch(console.error);
