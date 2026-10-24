import fs from 'fs';

const trulyMissing = JSON.parse(fs.readFileSync('scratch/hsk6_truly_missing_833.json', 'utf8'));
console.log('Total truly missing:', trulyMissing.length);

for (let b = 1; b <= 8; b++) {
  const f = `data/hsk6-batch${b}-data.ts`;
  if (fs.existsSync(f)) {
    const text = fs.readFileSync(f, 'utf8');
    // Regex matching only the word item's hanzi: "...
    const hanzis = [];
    const lines = text.split('\n');
    for (const l of lines) {
      const m = l.match(/^\s*["']?hanzi["']?:\s*["']([^"']+)["']/);
      if (m) hanzis.push(m[1]);
    }
    console.log(`Batch ${b}: ${hanzis.length} words.`);
    if (hanzis.length > 0) {
      console.log(`   First 3: ${hanzis.slice(0, 3).join(', ')}`);
      console.log(`   Last 3:  ${hanzis.slice(-3).join(', ')}`);
    }
  }
}
