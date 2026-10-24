import fs from 'fs';

console.log('=== KIỂM TRA 8 BATCH FILE TRONG DATA/ ===');
for (let b = 1; b <= 8; b++) {
  const file = `data/hsk6-batch${b}-data.ts`;
  if (fs.existsSync(file)) {
    const text = fs.readFileSync(file, 'utf8');
    const hanzis = [...text.matchAll(/hanzi:\s*['"]([^'"]+)['"]/g)].map(m => m[1]);
    console.log(`Batch ${b}: ${hanzis.length} từ. [Đầu: ${hanzis[0]} -> Cuối: ${hanzis[hanzis.length - 1]}]`);
  } else {
    console.log(`Batch ${b}: KHÔNG TỒN TẠI!`);
  }
}

const recFile = 'data/hsk6-reconciled-36-data.ts';
if (fs.existsSync(recFile)) {
  const text = fs.readFileSync(recFile, 'utf8');
  const hanzis = [...text.matchAll(/hanzi:\s*['"]([^'"]+)['"]/g)].map(m => m[1]);
  console.log(`Reconciled: ${hanzis.length} từ. [Đầu: ${hanzis[0]} -> Cuối: ${hanzis[hanzis.length - 1]}]`);
}
