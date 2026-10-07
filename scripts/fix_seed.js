const fs = require('fs');
let sql = fs.readFileSync('supabase/migrations/20261007000000_hsk1_vocab_seed.sql', 'utf8');
sql = sql.replace('INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type)', 'INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)');
sql = sql.replace(/, '([^']*)'\)/g, ", '$1', 'HSK 1')");
fs.writeFileSync('supabase/migrations/20261007000000_hsk1_vocab_seed.sql', sql);
