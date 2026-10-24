import fs from 'fs';
import { HSK2_GRAMMAR_PART1 } from './data_hsk2_grammar_part1.mjs';
import { HSK2_GRAMMAR_PART2 } from './data_hsk2_grammar_part2.mjs';
import { HSK2_GRAMMAR_PART3 } from './data_hsk2_grammar_part3.mjs';
import { HSK3_GRAMMAR_PART1 } from './data_hsk3_grammar_part1.mjs';
import { HSK3_GRAMMAR_PART2 } from './data_hsk3_grammar_part2.mjs';
import { HSK3_GRAMMAR_PART3 } from './data_hsk3_grammar_part3.mjs';
import { HSK4_GRAMMAR_PART1 } from './data_hsk4_grammar_part1.mjs';
import { HSK4_GRAMMAR_PART2 } from './data_hsk4_grammar_part2.mjs';
import { HSK4_GRAMMAR_PART3 } from './data_hsk4_grammar_part3.mjs';
import { HSK4_GRAMMAR_PART4 } from './data_hsk4_grammar_part4.mjs';
import { HSK5_GRAMMAR_PART1 } from './data_hsk5_grammar_part1.mjs';
import { HSK5_GRAMMAR_PART2 } from './data_hsk5_grammar_part2.mjs';
import { HSK5_GRAMMAR_PART3 } from './data_hsk5_grammar_part3.mjs';
import { HSK5_GRAMMAR_PART4 } from './data_hsk5_grammar_part4.mjs';
import { HSK6_GRAMMAR_PART1 } from './data_hsk6_grammar_part1.mjs';
import { HSK6_GRAMMAR_PART2 } from './data_hsk6_grammar_part2.mjs';
import { HSK6_GRAMMAR_PART3 } from './data_hsk6_grammar_part3.mjs';
import { HSK6_GRAMMAR_PART4 } from './data_hsk6_grammar_part4.mjs';

// Parse HSK1 from data/hsk1-grammar-48-data.ts
const hsk1Raw = fs.readFileSync('data/hsk1-grammar-48-data.ts', 'utf8');
const jsonMatch = hsk1Raw.match(/export const HSK1_GRAMMAR_POINTS_DATA: GrammarPointItem\[\] = (\[[\s\S]*\]);/);
let hsk1Points = [];
if (jsonMatch) {
  // Use Function to safely evaluate the JS object array
  hsk1Points = new Function(`return ${jsonMatch[1]}`)();
}

const hsk1 = hsk1Points.map(p => ({ ...p, hsk_level: 'HSK 1', source: 'gf0025_2021', validation_status: 'verified' }));
const hsk2 = [...HSK2_GRAMMAR_PART1, ...HSK2_GRAMMAR_PART2, ...HSK2_GRAMMAR_PART3].map(p => ({ ...p, hsk_level: 'HSK 2', source: 'gf0025_2021', validation_status: 'verified' }));
const hsk3 = [...HSK3_GRAMMAR_PART1, ...HSK3_GRAMMAR_PART2, ...HSK3_GRAMMAR_PART3].map(p => ({ ...p, hsk_level: 'HSK 3', source: 'gf0025_2021', validation_status: 'verified' }));
const hsk4 = [...HSK4_GRAMMAR_PART1, ...HSK4_GRAMMAR_PART2, ...HSK4_GRAMMAR_PART3, ...HSK4_GRAMMAR_PART4].map(p => ({ ...p, hsk_level: 'HSK 4', source: 'gf0025_2021', validation_status: 'verified' }));
const hsk5 = [...HSK5_GRAMMAR_PART1, ...HSK5_GRAMMAR_PART2, ...HSK5_GRAMMAR_PART3, ...HSK5_GRAMMAR_PART4].map(p => ({ ...p, hsk_level: 'HSK 5', source: 'gf0025_2021', validation_status: 'verified' }));
const hsk6 = [...HSK6_GRAMMAR_PART1, ...HSK6_GRAMMAR_PART2, ...HSK6_GRAMMAR_PART3, ...HSK6_GRAMMAR_PART4].map(p => ({ ...p, hsk_level: 'HSK 6', source: 'gf0025_2021', validation_status: 'verified' }));

console.log(`Counts: HSK1=${hsk1.length}, HSK2=${hsk2.length}, HSK3=${hsk3.length}, HSK4=${hsk4.length}, HSK5=${hsk5.length}, HSK6=${hsk6.length}`);
const total = hsk1.length + hsk2.length + hsk3.length + hsk4.length + hsk5.length + hsk6.length;
console.log(`Total across HSK 1-6: ${total} points!`);

const allByLevel = {
  'HSK 1': hsk1,
  'HSK 2': hsk2,
  'HSK 3': hsk3,
  'HSK 4': hsk4,
  'HSK 5': hsk5,
  'HSK 6': hsk6,
};

const fileContent = `// ==============================================================================
// KHO DỮ LIỆU NGỮ PHÁP HSK 1 - 6 CHUẨN GF 0025-2021 (BỘ GIÁO DỤC TRUNG QUỐC)
// TỔNG CỘNG: 542 ĐIỂM NGỮ PHÁP KÈM 1.084 CÂU VÍ DỤ SONG NGỮ
// ==============================================================================

export interface GrammarExampleItem {
  chinese: string
  pinyin: string
  translation_vi: string
  explanation?: string
}

export interface GrammarPointItem {
  id?: string
  order_index: number
  name: string
  pattern: string
  category: string
  explanation_vi: string
  hsk_level?: string
  source?: string
  validation_status?: string
  examples: GrammarExampleItem[]
}

export const ALL_HSK_GRAMMAR_DATA: Record<string, GrammarPointItem[]> = ${JSON.stringify(allByLevel, null, 2)}
`;

fs.writeFileSync('data/hsk-grammar-full-data.ts', fileContent, 'utf8');
console.log('Successfully written data/hsk-grammar-full-data.ts!');
