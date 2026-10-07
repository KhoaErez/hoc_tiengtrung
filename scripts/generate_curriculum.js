const fs = require('fs');
const crypto = require('crypto');
require('dotenv').config({ path: '.env.local' });

const HSK_DATA = [
  { level: 1, words: require('@leonsilicon/hsk2.0').hsk20WordsLevel1 },
  { level: 2, words: require('@leonsilicon/hsk2.0').hsk20WordsLevel2 },
  { level: 3, words: require('@leonsilicon/hsk2.0').hsk20WordsLevel3 },
  { level: 4, words: require('@leonsilicon/hsk2.0').hsk20WordsLevel4 },
  { level: 5, words: require('@leonsilicon/hsk2.0').hsk20WordsLevel5 },
  { level: 6, words: require('@leonsilicon/hsk2.0').hsk20WordsLevel6 },
];

async function generateCurriculum() {
  let finalSql = `-- 1. Schema Migration cho Curriculum
ALTER TABLE public.lessons ALTER COLUMN user_id DROP NOT NULL;
ALTER TABLE public.lessons ALTER COLUMN original_text DROP NOT NULL;
ALTER TABLE public.lessons ADD COLUMN IF NOT EXISTS lesson_number integer;
ALTER TABLE public.lessons ADD COLUMN IF NOT EXISTS is_system boolean default false;
ALTER TABLE public.lesson_vocabularies ADD COLUMN IF NOT EXISTS sort_order integer;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Anyone can read system lessons.') THEN
    CREATE POLICY "Anyone can read system lessons." ON public.lessons FOR SELECT USING (is_system = true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Anyone can read system lesson_vocabularies.') THEN
    CREATE POLICY "Anyone can read system lesson_vocabularies." ON public.lesson_vocabularies FOR SELECT USING (EXISTS (SELECT 1 FROM public.lessons WHERE id = lesson_vocabularies.lesson_id AND is_system = true));
  END IF;
END $$;

-- 2. Xóa Curriculum cũ (nếu có) để seed lại
DELETE FROM public.lessons WHERE is_system = true;

-- 3. Data Insertion
`;

  const tasks = [];
  const wordsPerPrompt = 150;

  for (const hsk of HSK_DATA) {
    const promptsCount = Math.ceil(hsk.words.length / wordsPerPrompt);
    for (let p = 0; p < promptsCount; p++) {
      const chunk = hsk.words.slice(p * wordsPerPrompt, (p + 1) * wordsPerPrompt);
      tasks.push({ level: hsk.level, chunk, index: p + 1, total: promptsCount });
    }
  }

  console.log(`Total ${tasks.length} chunks to process.`);

  const limit = 5;
  let active = 0;
  let index = 0;
  const results = []; // stores { level, lessons: [] }

  await new Promise((resolve) => {
    const next = () => {
      if (index >= tasks.length && active === 0) {
        resolve();
        return;
      }
      while (active < limit && index < tasks.length) {
        const currentIndex = index++;
        const task = tasks[currentIndex];
        active++;
        
        console.log(`Processing HSK ${task.level} chunk ${task.index}/${task.total}...`);
        const prompt = `You are a Chinese curriculum designer. I have a list of ${task.chunk.length} words from HSK ${task.level}.
Group ALL of these words logically into lessons (topics). Each lesson should have 10 to 20 words.
For each lesson, provide:
- title: A short engaging title in Vietnamese (e.g. "Xin chào!", "Gia đình tôi").
- description: A short description of what the lesson is about.
- words: An array of the exact Chinese characters (Hanzi) from my list. You MUST include ALL the words from my list exactly once across the lessons.

Return ONLY a valid JSON array of objects. Example:
[
  { "title": "Xin chào", "description": "Làm quen và chào hỏi cơ bản", "words": ["你", "好", "我"] },
  { "title": "Gia đình", "description": "Nói về người thân", "words": ["爸爸", "妈妈"] }
]

Words to categorize: ${task.chunk.join(', ')}`;

        const req = async () => {
          let retryCount = 0;
          while (retryCount < 3) {
            try {
              const res = await fetch(process.env.KIE_BASE_URL + '/chat/completions', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${process.env.KIE_API_KEY}` },
                body: JSON.stringify({
                  model: process.env.KIE_MODEL,
                  messages: [{ role: 'user', content: prompt }]
                })
              });
              const resData = await res.json();
              let text = resData.choices[0].message.content;
              text = text.replace(/```json/g, '').replace(/```/g, '').trim();
              return JSON.parse(text);
            } catch (e) {
              retryCount++;
              console.log(`Retry ${retryCount}/3 for HSK ${task.level} chunk ${task.index}...`);
            }
          }
          return [];
        };

        req().then(parsed => {
          results.push({ level: task.level, lessons: parsed });
          active--;
          next();
        });
      }
    };
    next();
  });

  // Re-organize lessons by level
  for (let level = 1; level <= 6; level++) {
    const levelResults = results.filter(r => r.level === level);
    let lessonCounter = 1;
    
    for (const res of levelResults) {
      for (const lesson of res.lessons) {
        const lessonId = crypto.randomUUID();
        const title = (lesson.title || 'Lesson').replace(/'/g, "''");
        const desc = (lesson.description || '').replace(/'/g, "''");
        
        finalSql += `INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('${lessonId}', 'Bài ${lessonCounter} - ${title}', '${desc}', 'HSK ${level}', ${lessonCounter}, true);\n`;
        
        if (lesson.words && lesson.words.length > 0) {
          finalSql += `INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '${lessonId}', id, row_number() over() FROM public.vocabularies WHERE hanzi IN (${lesson.words.map(w => `'${w.replace(/'/g, "''")}'`).join(', ')});\n\n`;
        }
        
        lessonCounter++;
      }
    }
  }

  fs.writeFileSync('supabase/migrations/20261007000008_curriculum_seed.sql', finalSql);
  console.log('Curriculum SQL generated successfully to 20261007000008_curriculum_seed.sql');
}

generateCurriculum().catch(console.error);
