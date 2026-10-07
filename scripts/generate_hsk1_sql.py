import urllib.request
import csv
import json

url = 'https://raw.githubusercontent.com/ivankra/hsk30/master/hsk30.csv'
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
response = urllib.request.urlopen(req)
lines = [l.decode('utf-8') for l in response.readlines()]

reader = csv.DictReader(lines)
hsk1_words = []

for row in reader:
    if row.get('Level') == '1':
        cedict = row.get('CEDICT', '')
        meaning = ''
        if '/' in cedict:
            parts = cedict.split('/')
            parts = [p.strip() for p in parts if p.strip()]
            if len(parts) > 1:
                # The first part is usually Hanzi [pinyin]
                meaning = ', '.join(parts[1:])
        
        hanzi = row.get('Simplified', '')
        pinyin = row.get('Pinyin', '')
        pos = row.get('POS', '').split('/')[0] if row.get('POS') else ''
        
        if meaning:
            meaning = meaning + " (Tạm dịch Tiếng Anh)"
        else:
            meaning = "(Cần dịch)"
            
        hsk1_words.append({
            'hanzi': hanzi,
            'pinyin': pinyin,
            'meaning': meaning,
            'pos': pos
        })

print(f"Parsed {len(hsk1_words)} words.")

sql = "INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type)\nVALUES\n"
for i, w in enumerate(hsk1_words):
    clean_meaning = w['meaning'].replace("'", "''")
    clean_hanzi = w['hanzi'].replace("'", "''")
    clean_pinyin = w['pinyin'].replace("'", "''")
    clean_pos = w['pos'].replace("'", "''")
    
    end_char = ";" if i == len(hsk1_words) - 1 else ","
    sql += f"  ('{clean_hanzi}', '{clean_pinyin}', '{clean_meaning}', '{clean_pos}'){end_char}\n"

with open('supabase/migrations/20261007000000_hsk1_vocab_seed.sql', 'w', encoding='utf-8') as f:
    f.write(sql)
    
print("Successfully generated supabase/migrations/20261007000000_hsk1_vocab_seed.sql")
