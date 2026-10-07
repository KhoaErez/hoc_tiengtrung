const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

async function processBatch(words) {
  const prompt = `You are a Chinese language expert. I have a list of HSK vocabulary words.
For EACH word in the list, provide a short, practical example sentence in Chinese.

You must return ONLY a JSON array of objects, with EXACTLY the same number of items as the input.
For each item, return:
- id: the exact ID provided in the input
- example_hanzi: A short example sentence in Chinese using the word.
- example_pinyin: Pinyin for the example sentence.
- example_vi: Vietnamese translation of the example sentence.

Input words:
${JSON.stringify(words.map(w => ({ id: w.id, hanzi: w.hanzi, meaning_vi: w.meaning_vi })))}
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
  console.log("Fetching words without examples...");
  
  // We process HSK 1 and HSK 2 first to be fast, but we can just query all where example_hanzi is null
  const { data: words, error } = await supabase
    .from('vocabularies')
    .select('id, hanzi, meaning_vi, hsk_level')
    .is('example_hanzi', null)
    .order('hsk_level', { ascending: true }) // Do HSK 1 first
    .limit(300); // Process 300 words per script run so it doesn't take forever

  if (error) {
    console.error("DB Error:", error);
    return;
  }

  console.log(`Found ${words.length} words to process.`);
  
  const BATCH_SIZE = 25;
  for (let i = 0; i < words.length; i += BATCH_SIZE) {
    const batch = words.slice(i, i + BATCH_SIZE);
    console.log(`Processing batch ${i/BATCH_SIZE + 1}/${Math.ceil(words.length/BATCH_SIZE)} (words ${i} to ${i + batch.length - 1})...`);
    
    try {
      const results = await processBatch(batch);
      
      // Update DB
      for (const res of results) {
        if (!res.id || !res.example_hanzi) continue;
        
        await supabase
          .from('vocabularies')
          .update({
            example_hanzi: res.example_hanzi,
            example_pinyin: res.example_pinyin,
            example_vi: res.example_vi
          })
          .eq('id', res.id);
      }
      console.log(`Updated ${results.length} words in DB.`);
    } catch (e) {
      console.error("Failed batch:", e);
    }
  }
  
  console.log("Done generating examples!");
}

run();
