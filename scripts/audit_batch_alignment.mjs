import fs from 'fs';

const trulyMissing = JSON.parse(fs.readFileSync('scratch/hsk6_truly_missing_833.json', 'utf8'));

// Check each batch
function getBatchWords(file) {
  const text = fs.readFileSync(file, 'utf8');
  const hanzis = [];
  for (const l of text.split('\n')) {
    const m = l.match(/^\s*["']?hanzi["']?:\s*["']([^"']+)["']/);
    if (m) hanzis.push(m[1]);
  }
  return hanzis;
}

let currentIndex = 0;
for (let b = 1; b <= 8; b++) {
  const f = `data/hsk6-batch${b}-data.ts`;
  if (!fs.existsSync(f)) continue;
  const batchHanzis = getBatchWords(f);
  const expectedSlice = trulyMissing.slice(currentIndex, currentIndex + batchHanzis.length);
  const expectedHanzis = expectedSlice.map(w => w.hanzi);

  // Compare
  let matches = 0;
  let mismatches = [];
  for (let i = 0; i < batchHanzis.length; i++) {
    if (batchHanzis[i] === expectedHanzis[i]) {
      matches++;
    } else {
      mismatches.push({ index: currentIndex + i, inBatch: batchHanzis[i], inOfficial: expectedHanzis[i] });
    }
  }

  console.log(`\n--- BATCH ${b} (${batchHanzis.length} words, indices ${currentIndex}..${currentIndex + batchHanzis.length - 1}) ---`);
  console.log(`Matched with trulyMissing slice: ${matches}/${batchHanzis.length} (${((matches/batchHanzis.length)*100).toFixed(1)}%)`);
  if (mismatches.length > 0) {
    console.log(`Mismatches count: ${mismatches.length}`);
    console.log('First 5 mismatches:', mismatches.slice(0, 5));
  } else {
    console.log(`✅ 100% PERFECT MATCH with trulyMissing slice!`);
  }

  currentIndex += batchHanzis.length;
}

console.log(`\nTotal processed indices: ${currentIndex} / ${trulyMissing.length}`);
