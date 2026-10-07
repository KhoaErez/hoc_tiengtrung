const fs = require('fs');
const crypto = require('crypto');
require('dotenv').config({ path: '.env.local' });

async function generateChunk(part, totalParts, previousTitles) {
  console.log(`Generating part ${part}/${totalParts}...`);
  const prompt = `You are an expert Chinese curriculum designer.
We are building a comprehensive curriculum for "Tiếng Trung Giao tiếp" (Conversational Chinese / Daily Communication) with a total of 15 lessons.
This is PART ${part} out of ${totalParts}. Please generate exactly 3 lessons (or the remaining lessons) for this part.
The curriculum must cover topics such as: Greetings, Buying things, Ordering food, Asking for directions, Hobbies, Traveling, Weather, Daily Routine, Health, etc.
Previously generated lesson titles (DO NOT DUPLICATE THESE TOPICS): ${previousTitles.join(', ') || 'None'}

For each lesson, provide exactly 15 essential vocabulary words.

For each word/phrase, you MUST provide:
- hanzi: The Chinese characters.
- pinyin: Pinyin with tone marks.
- vi: The Vietnamese meaning.
- example_hanzi: A short, practical example sentence in Chinese using the word in a daily communication context.
- example_pinyin: Pinyin for the example sentence.
- example_vi: Vietnamese translation of the example sentence.

Return ONLY a valid JSON array of objects. Example format:
[
  {
    "title": "Mua sắm và Trả giá",
    "description": "Cách hỏi giá, mặc cả và mua đồ ngoài chợ hoặc siêu thị.",
    "words": [
      { 
        "hanzi": "多少钱", "pinyin": "duōshǎo qián", "vi": "bao nhiêu tiền",
        "example_hanzi": "这个多少钱？", "example_pinyin": "Zhège duōshǎo qián?", "example_vi": "Cái này bao nhiêu tiền?"
      }
    ]
  }
]`;

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
      
      if (!res.ok) {
        throw new Error(`API error: ${res.status} ${res.statusText}`);
      }
      
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

async function generateGiaoTiepCurriculum() {
  console.log("Generating Giao tiếp curriculum in batches...");
  let allLessons = [];
  let previousTitles = [];
  
  // 15 lessons total. We generate them in 5 batches (3, 3, 3, 3, 3).
  const batches = [3, 3, 3, 3, 3];
  
  for (let i = 0; i < batches.length; i++) {
    const chunk = await generateChunk(i + 1, batches.length, previousTitles);
    allLessons = allLessons.concat(chunk);
    previousTitles = previousTitles.concat(chunk.map(c => c.title));
  }

  let finalSql = `-- Migration for Giao tiếp Curriculum (With Examples)\n\n`;
  finalSql += `DELETE FROM public.lessons WHERE hsk_level = 'Giao tiếp' AND is_system = true;\n\n`;

  // First, insert all vocabularies
  for (const lesson of allLessons) {
    for (const word of lesson.words) {
      const hanzi = word.hanzi.replace(/'/g, "''");
      const pinyin = word.pinyin.replace(/'/g, "''");
      const vi = word.vi.replace(/'/g, "''");
      const exHanzi = (word.example_hanzi || '').replace(/'/g, "''");
      const exPinyin = (word.example_pinyin || '').replace(/'/g, "''");
      const exVi = (word.example_vi || '').replace(/'/g, "''");
      
      finalSql += `INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('${crypto.randomUUID()}', '${hanzi}', '${pinyin}', '${vi}', 'Giao tiếp', '${exHanzi}', '${exPinyin}', '${exVi}')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;\n`;
    }
  }

  finalSql += `\n-- Insert Lessons and Mappings\n`;

  let lessonCounter = 1;
  for (const lesson of allLessons) {
    const lessonId = crypto.randomUUID();
    const title = lesson.title.replace(/'/g, "''");
    const desc = lesson.description.replace(/'/g, "''");
    
    finalSql += `INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('${lessonId}', 'Bài ${lessonCounter} - ${title}', '${desc}', 'Giao tiếp', ${lessonCounter}, true);\n`;
    
    if (lesson.words && lesson.words.length > 0) {
      finalSql += `INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '${lessonId}', id, row_number() over() FROM public.vocabularies WHERE hanzi IN (${lesson.words.map(w => `'${w.hanzi.replace(/'/g, "''")}'`).join(', ')});\n\n`;
    }
    
    lessonCounter++;
  }

  fs.writeFileSync('supabase/migrations/20261007000010_giao_tiep_seed.sql', finalSql);
  console.log('Giao tiep SQL generated successfully to 20261007000010_giao_tiep_seed.sql');
}

generateGiaoTiepCurriculum().catch(console.error);
