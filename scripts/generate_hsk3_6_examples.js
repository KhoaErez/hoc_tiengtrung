const fs = require('fs');
require('dotenv').config({ path: '.env.local' });
const data = require('@leonsilicon/hsk2.0');

async function processBatch(words) {
  const prompt = `You are a Chinese language expert. I have a list of Chinese vocabulary words.
For EACH word in the list, provide a short, practical example sentence in Chinese.

You must return ONLY a JSON array of objects, with EXACTLY the same number of items as the input.
For each item, return:
- hanzi: the exact Chinese word provided in the input.
- example_hanzi: A short example sentence in Chinese using the word.
- example_pinyin: Pinyin for the example sentence.
- example_vi: Vietnamese translation of the example sentence.

Input words to generate examples for:
${words.join(', ')}
`;

  let retries = 3;
  while (retries > 0) {
    try {
      const res = await fetch(process.env.KIE_BASE_URL + '/chat/completions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${process.env.KIE_API_KEY}` },
        body: JSON.stringify({
          model: process.env.KIE_MODEL,
          messages: [{ role: 'user', content: prompt }]
        })
      });
      
      if (!res.ok) throw new Error(`API error: ${res.status}`);
      
      const resData = await res.json();
      let text = resData.choices[0].message.content;
      text = text.replace(/```json/g, '').replace(/```/g, '').trim();
      return JSON.parse(text);
    } catch (e) {
      console.error(`Attempt failed: ${e.message}`);
      retries--;
      if (retries === 0) throw e;
      await new Promise(r => setTimeout(r, 2000));
    }
  }
}

async function run() {
  console.log("Generating examples for HSK 3, 4, 5, 6...");
  const hsk3Words = data.hsk20WordsLevel3 || [];
  const hsk4Words = data.hsk20WordsLevel4 || [];
  const hsk5Words = data.hsk20WordsLevel5 || [];
  const hsk6Words = data.hsk20WordsLevel6 || [];
  
  const allWords = [...hsk3Words, ...hsk4Words, ...hsk5Words, ...hsk6Words];
  console.log(`Total words to process: ${allWords.length}`);
  
  let finalSql = `-- Update HSK 3, 4, 5, 6 with Example Sentences\n\n`;
  
  const BATCH_SIZE = 50; // Increased batch size to speed up
  for (let i = 0; i < allWords.length; i += BATCH_SIZE) {
    const batch = allWords.slice(i, i + BATCH_SIZE);
    console.log(`Processing batch ${Math.floor(i/BATCH_SIZE) + 1}/${Math.ceil(allWords.length/BATCH_SIZE)}...`);
    
    try {
      const results = await processBatch(batch);
      
      for (const res of results) {
        if (!res.hanzi || !res.example_hanzi) continue;
        
        const exHanzi = res.example_hanzi.replace(/'/g, "''");
        const exPinyin = res.example_pinyin.replace(/'/g, "''");
        const exVi = res.example_vi.replace(/'/g, "''");
        
        finalSql += `UPDATE public.vocabularies SET example_hanzi = '${exHanzi}', example_pinyin = '${exPinyin}', example_vi = '${exVi}' WHERE hanzi = '${res.hanzi}';\n`;
      }
      
      // Save periodically to avoid losing progress
      if ((Math.floor(i/BATCH_SIZE) + 1) % 10 === 0) {
        fs.writeFileSync('supabase/migrations/20261007000013_hsk3_6_examples.sql', finalSql);
        console.log("Progress saved.");
      }
      
    } catch (e) {
      console.error("Failed batch:", e);
    }
  }
  
  fs.writeFileSync('supabase/migrations/20261007000013_hsk3_6_examples.sql', finalSql);
  console.log("Done! Written to supabase/migrations/20261007000013_hsk3_6_examples.sql");
}

run().catch(console.error);
