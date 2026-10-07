const https = require('https');
const fs = require('fs');

https.get('https://raw.githubusercontent.com/ivankra/hsk30/master/hsk30.csv', (res) => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    
    // A simple CSV parser that respects double quotes
    function parseCSV(text) {
        let ret = [''], i = 0, p = '', s = true;
        for (let l in text) {
            l = text[l];
            if ('"' === l) {
                s = !s;
                if ('"' === p) {
                    ret[i] += '"';
                    l = '-';
                } else if (p === '') l = '-';
            } else if (s && ',' === l) l = ret[++i] = '';
            else ret[i] += l;
            p = l;
        }
        return ret;
    }

    const lines = data.split('\n');
    const hsk1 = [];
    
    for (let i = 1; i < lines.length; i++) {
      const line = lines[i].trim();
      if (!line) continue;
      
      const parts = parseCSV(line);
      const id = parts[0];
      const simplified = parts[1];
      const pinyin = parts[3];
      const pos = parts[4];
      const level = parts[5];
      const cedict = parts[10] || '';
      
      let english = '';
      if (cedict.includes('/')) {
          const c_parts = cedict.split('/').map(p => p.trim()).filter(p => p);
          if (c_parts.length > 1) {
              english = c_parts.slice(1).join(', ');
          }
      }
      
      if (level === '1') {
        let meaning = english ? english + " (Tạm dịch Tiếng Anh)" : "(Cần dịch)";
        hsk1.push({ hanzi: simplified, pinyin: pinyin, pos: pos ? pos.split('/')[0] : '', meaning: meaning });
      }
    }

    console.log(`Found ${hsk1.length} HSK 1 words.`);
    
    let sql = `INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type)\nVALUES\n`;
    
    for (let i = 0; i < hsk1.length; i++) {
      const w = hsk1[i];
      const cleanMeaning = w.meaning.replace(/'/g, "''");
      const cleanHanzi = w.hanzi.replace(/'/g, "''");
      const cleanPinyin = w.pinyin.replace(/'/g, "''");
      const cleanPos = w.pos.replace(/'/g, "''");
      
      sql += `  ('${cleanHanzi}', '${cleanPinyin}', '${cleanMeaning}', '${cleanPos}')${i === hsk1.length - 1 ? ';' : ','}\n`;
    }
    
    fs.writeFileSync('supabase/migrations/20261007000000_hsk1_vocab_seed.sql', sql);
    console.log('Successfully generated supabase/migrations/20261007000000_hsk1_vocab_seed.sql!');
  });
});
