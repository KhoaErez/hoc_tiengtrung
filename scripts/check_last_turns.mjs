import fs from 'fs';
const file = 'C:/Users/Admin/.gemini/antigravity-ide/brain/28d43a00-8e1f-4ba5-a1da-86d3a90cd97e/.system_generated/logs/transcript.jsonl';
const lines = fs.readFileSync(file, 'utf8').trim().split('\n');
console.log('Total transcript lines:', lines.length);

for (let i = Math.max(0, lines.length - 30); i < lines.length; i++) {
  try {
    const item = JSON.parse(lines[i]);
    if (item.type === 'USER_INPUT') {
      console.log(`\n=== [USER_INPUT step ${item.step_index}] ===\n`, item.content);
    } else if (item.type === 'PLANNER_RESPONSE' && item.content) {
      console.log(`\n=== [PLANNER_RESPONSE step ${item.step_index}] ===\n`, item.content.slice(0, 400));
    }
  } catch (e) {}
}
