const fs = require('fs');

async function main() {
  const data = require('@leonsilicon/hsk2.0');
  const words = data.hsk20WordsLevel1; // Array of 150 strings
  
  console.log(`Found ${words.length} words for HSK 1 (2012)`);
  
  const translations = [];
  const chunkSize = 50;
  const chunks = [];
  for (let i = 0; i < words.length; i += chunkSize) {
    chunks.push(words.slice(i, i + chunkSize));
  }

  for (let i = 0; i < chunks.length; i++) {
    console.log(`Translating chunk ${i + 1}/${chunks.length}...`);
    const chunk = chunks[i];
    const prompt = `You are a dictionary tool. For the following Chinese HSK1 vocabulary words, provide their standard Pinyin and short Vietnamese meanings. 
Return ONLY a valid JSON array of objects. No markdown formatting, just the raw JSON text. 
Example: [{"hanzi":"爱", "pinyin":"ài", "vi":"yêu"}, {"hanzi":"八", "pinyin":"bā", "vi":"tám"}]
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
    
    const resData = await res.json();
    let text = resData.choices[0].message.content;
    text = text.replace(/```json/g, '').replace(/```/g, '').trim();
    
    try {
      const parsed = JSON.parse(text);
      translations.push(...parsed);
    } catch (e) {
      console.error('Failed to parse JSON:', text);
    }
  }

  let sql = `-- HSK 1 2012 Version (150 words)
DELETE FROM public.vocabularies;

INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
VALUES
`;

  const values = [];
  for (const item of translations) {
    const hanzi = item.hanzi;
    const pinyin = item.pinyin;
    const vi = (item.vi || '(Cần dịch)').replace(/'/g, "''");
    
    values.push(`  ('${hanzi}', '${pinyin}', '${vi}', '', 'HSK 1')`);
  }
  
  sql += values.join(',\n') + ';\n';
  
  fs.writeFileSync('supabase/migrations/20261007000001_hsk1_2012_vocab_seed.sql', sql);
  console.log('SQL file written successfully to 20261007000001_hsk1_2012_vocab_seed.sql');
}

main().catch(console.error);
