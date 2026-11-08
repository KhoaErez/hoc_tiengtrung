import sharp from 'sharp';
import fs from 'fs';
import path from 'path';

// Helper to render SVG to WebP
async function renderSvgToWebp(svgString, outputPath, width, height, quality = 90) {
  const dir = path.dirname(outputPath);
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  
  await sharp(Buffer.from(svgString))
    .resize(width, height)
    .webp({ quality })
    .toFile(outputPath);
  
  const stats = fs.statSync(outputPath);
  console.log(`Generated: ${outputPath} (${stats.size} bytes)`);
}

// -------------------------------------------------------------
// 1. GRAMMAR HERO (Grammar Studio /grammar)
// -------------------------------------------------------------
const grammarHeroSvg = `
<svg width="1200" height="500" viewBox="0 0 1200 500" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="gBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#182238"/>
      <stop offset="50%" stop-color="#24304D"/>
      <stop offset="100%" stop-color="#141B2D"/>
    </linearGradient>
    <linearGradient id="goldGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#FCD34D"/>
      <stop offset="100%" stop-color="#D97706"/>
    </linearGradient>
    <linearGradient id="redGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#EF4444"/>
      <stop offset="100%" stop-color="#B8322D"/>
    </linearGradient>
    <linearGradient id="cardGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" stop-color="#FFFFFF"/>
      <stop offset="100%" stop-color="#FAF7F2"/>
    </linearGradient>
    <filter id="shadow3d" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#000000" flood-opacity="0.45"/>
    </filter>
  </defs>

  <!-- Background -->
  <rect width="1200" height="500" rx="32" fill="url(#gBg)"/>
  
  <!-- Subtle Rice Paper &amp; Scholar Clouds -->
  <circle cx="150" cy="120" r="180" fill="#FFFFFF" fill-opacity="0.03"/>
  <circle cx="1050" cy="380" r="220" fill="#FCD34D" fill-opacity="0.03"/>
  <circle cx="900" cy="100" r="140" fill="#FFFFFF" fill-opacity="0.02"/>

  <!-- Left: Stylized Grammar Sentence Structure Blocks -->
  <g transform="translate(100, 110)" filter="url(#shadow3d)">
    <!-- Desk Base -->
    <rect x="0" y="240" width="460" height="18" rx="9" fill="#384869"/>
    
    <!-- Big Book of Grammar -->
    <rect x="40" y="60" width="380" height="190" rx="16" fill="url(#cardGrad)" stroke="#FAF7F2" stroke-width="3"/>
    <rect x="40" y="60" width="28" height="190" rx="6" fill="url(#redGrad)"/>
    <line x1="54" y1="70" x2="54" y2="240" stroke="#FAF7F2" stroke-width="2" stroke-dasharray="4,4"/>
    
    <!-- Title on Book -->
    <text x="85" y="110" font-family="'Lora', serif" font-weight="bold" font-size="28" fill="#182238">语法手册</text>
    <text x="85" y="138" font-family="'Be Vietnam Pro', sans-serif" font-size="14" fill="#64748B" font-weight="600">CHINESE GRAMMAR MANUAL</text>

    <!-- Visual Structure Blocks (S + V + O) -->
    <g transform="translate(85, 160)">
      <!-- Subject Block -->
      <rect x="0" y="0" width="90" height="54" rx="12" fill="#FEF3C7" stroke="#F59E0B" stroke-width="2"/>
      <text x="45" y="26" font-family="sans-serif" font-size="14" font-weight="bold" fill="#92400E" text-anchor="middle">主语 (S)</text>
      <text x="45" y="44" font-family="sans-serif" font-size="11" fill="#B45309" text-anchor="middle">我 / 他</text>

      <!-- Plus -->
      <text x="105" y="32" font-size="18" font-weight="bold" fill="#94A3B8" text-anchor="middle">+</text>

      <!-- Verb Block -->
      <rect x="120" y="0" width="90" height="54" rx="12" fill="#FEE2E2" stroke="#EF4444" stroke-width="2"/>
      <text x="165" y="26" font-family="sans-serif" font-size="14" font-weight="bold" fill="#B91C1C" text-anchor="middle">谓语 (V)</text>
      <text x="165" y="44" font-family="sans-serif" font-size="11" fill="#DC2626" text-anchor="middle">学习 / 看</text>

      <!-- Plus -->
      <text x="225" y="32" font-size="18" font-weight="bold" fill="#94A3B8" text-anchor="middle">+</text>

      <!-- Object Block -->
      <rect x="240" y="0" width="90" height="54" rx="12" fill="#D1FAE5" stroke="#10B981" stroke-width="2"/>
      <text x="285" y="26" font-family="sans-serif" font-size="14" font-weight="bold" fill="#065F46" text-anchor="middle">宾语 (O)</text>
      <text x="285" y="44" font-family="sans-serif" font-size="11" fill="#059669" text-anchor="middle">汉语 / 书</text>
    </g>
  </g>

  <!-- Right: 3D Floating Scholar Desk &amp; Stationery -->
  <g transform="translate(680, 80)" filter="url(#shadow3d)">
    <!-- Floating Bamboo Brush -->
    <g transform="rotate(-30 200 150)">
      <rect x="190" y="40" width="16" height="240" rx="8" fill="#B45309"/>
      <rect x="188" y="270" width="20" height="20" rx="4" fill="#D97706"/>
      <path d="M190 290 C190 320 198 340 198 340 C198 340 206 320 206 290 Z" fill="#182238"/>
    </g>

    <!-- Ink Stone (Nghiên mực) -->
    <ellipse cx="120" cy="300" rx="75" ry="32" fill="#1E293B" stroke="#475569" stroke-width="3"/>
    <ellipse cx="120" cy="298" rx="55" ry="20" fill="#0F172A"/>

    <!-- Red Seal Stamp (Con dấu) -->
    <g transform="translate(320, 220)">
      <rect x="0" y="0" width="60" height="70" rx="12" fill="url(#redGrad)"/>
      <rect x="10" y="10" width="40" height="50" rx="6" fill="#991B1B"/>
      <text x="30" y="42" font-family="serif" font-size="24" font-weight="bold" fill="#FDE047" text-anchor="middle">准</text>
    </g>

    <!-- Floating Formula Card: 把 / 被 Structure -->
    <g transform="translate(180, 40) rotate(6)">
      <rect x="0" y="0" width="260" height="90" rx="18" fill="url(#cardGrad)" stroke="#F59E0B" stroke-width="2.5"/>
      <text x="20" y="32" font-family="serif" font-weight="bold" font-size="18" fill="#182238">“把” 字句 Cấu trúc Ba</text>
      <text x="20" y="58" font-family="sans-serif" font-size="13" font-weight="bold" fill="#B8322D">S + 把 + O + V + Thành phần khác</text>
      <text x="20" y="78" font-family="sans-serif" font-size="11" fill="#64748B">Tôi đã làm xong bài tập: 我把作业做完了</text>
    </g>
  </g>
</svg>
`;

// -------------------------------------------------------------
// 2. VOCABULARY HERO (Vocabulary World /topics)
// -------------------------------------------------------------
const vocabHeroSvg = `
<svg width="1200" height="500" viewBox="0 0 1200 500" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="vBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#831843"/>
      <stop offset="45%" stop-color="#9F1239"/>
      <stop offset="100%" stop-color="#182238"/>
    </linearGradient>
    <linearGradient id="vCard" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" stop-color="#FFFDF9"/>
      <stop offset="100%" stop-color="#FCE7F3"/>
    </linearGradient>
    <filter id="vShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="10" stdDeviation="14" flood-color="#000000" flood-opacity="0.4"/>
    </filter>
  </defs>

  <rect width="1200" height="500" rx="32" fill="url(#vBg)"/>

  <!-- Subtle Chinese Clouds &amp; Lanterns -->
  <circle cx="200" cy="100" r="160" fill="#FFFFFF" fill-opacity="0.04"/>
  <circle cx="1000" cy="400" r="240" fill="#F43F5E" fill-opacity="0.05"/>

  <!-- Left: Floating Vocab Word Cards Island -->
  <g transform="translate(120, 80)" filter="url(#vShadow)">
    <!-- Main Open Dictionary Scroll -->
    <rect x="0" y="50" width="440" height="260" rx="24" fill="#FFFDF9" stroke="#E2E8F0" stroke-width="3"/>
    <rect x="0" y="50" width="440" height="12" rx="6" fill="#E11D48"/>

    <!-- Characters on Dictionary -->
    <text x="40" y="125" font-family="'Lora', serif" font-size="48" font-weight="bold" fill="#182238">词汇</text>
    <text x="145" y="115" font-family="sans-serif" font-size="18" font-weight="bold" fill="#E11D48">cíhuì • TỪ VỰNG</text>
    <text x="145" y="135" font-family="sans-serif" font-size="13" fill="#64748B">Kho báu 5000+ từ HSK 1–9 tiêu chuẩn GF 0025</text>

    <!-- 4 Word Feature Pills inside -->
    <g transform="translate(40, 160)">
      <rect x="0" y="0" width="80" height="70" rx="14" fill="#FEE2E2" stroke="#EF4444" stroke-width="1.5"/>
      <text x="40" y="34" font-family="serif" font-size="22" font-weight="bold" fill="#B91C1C" text-anchor="middle">家</text>
      <text x="40" y="54" font-family="sans-serif" font-size="10" font-weight="bold" fill="#991B1B" text-anchor="middle">jiā • Nhà</text>

      <rect x="95" y="0" width="80" height="70" rx="14" fill="#FEF3C7" stroke="#F59E0B" stroke-width="1.5"/>
      <text x="135" y="34" font-family="serif" font-size="22" font-weight="bold" fill="#B45309" text-anchor="middle">书</text>
      <text x="135" y="54" font-family="sans-serif" font-size="10" font-weight="bold" fill="#78350F" text-anchor="middle">shū • Sách</text>

      <rect x="190" y="0" width="80" height="70" rx="14" fill="#D1FAE5" stroke="#10B981" stroke-width="1.5"/>
      <text x="230" y="34" font-family="serif" font-size="22" font-weight="bold" fill="#065F46" text-anchor="middle">水</text>
      <text x="230" y="54" font-family="sans-serif" font-size="10" font-weight="bold" fill="#047857" text-anchor="middle">shuǐ • Nước</text>

      <rect x="285" y="0" width="80" height="70" rx="14" fill="#E0E7FF" stroke="#6366F1" stroke-width="1.5"/>
      <text x="325" y="34" font-family="serif" font-size="22" font-weight="bold" fill="#3730A3" text-anchor="middle">山</text>
      <text x="325" y="54" font-family="sans-serif" font-size="10" font-weight="bold" fill="#312E81" text-anchor="middle">shān • Núi</text>
    </g>
  </g>

  <!-- Right: 3D Pagoda &amp; Word Balloon Atmosphere -->
  <g transform="translate(680, 70)" filter="url(#vShadow)">
    <!-- Floating Word Card: 朋友 -->
    <g transform="translate(60, 40) rotate(-8)">
      <rect x="0" y="0" width="180" height="110" rx="20" fill="url(#vCard)" stroke="#F43F5E" stroke-width="2.5"/>
      <text x="90" y="48" font-family="serif" font-size="32" font-weight="bold" fill="#881337" text-anchor="middle">朋友</text>
      <text x="90" y="74" font-family="sans-serif" font-size="14" font-weight="bold" fill="#E11D48" text-anchor="middle">péngyou</text>
      <text x="90" y="94" font-family="sans-serif" font-size="12" fill="#4C0519" text-anchor="middle">Bạn bè • HSK 1</text>
    </g>

    <!-- Floating Word Card: 学习 -->
    <g transform="translate(260, 110) rotate(12)">
      <rect x="0" y="0" width="180" height="110" rx="20" fill="#FFFDF9" stroke="#10B981" stroke-width="2.5"/>
      <text x="90" y="48" font-family="serif" font-size="32" font-weight="bold" fill="#064E3B" text-anchor="middle">学习</text>
      <text x="90" y="74" font-family="sans-serif" font-size="14" font-weight="bold" fill="#059669" text-anchor="middle">xuéxí</text>
      <text x="90" y="94" font-family="sans-serif" font-size="12" fill="#047857" text-anchor="middle">Học tập • HSK 1</text>
    </g>

    <!-- Traditional Lantern -->
    <g transform="translate(20, 180)">
      <rect x="42" y="0" width="6" height="40" fill="#FBBF24"/>
      <ellipse cx="45" cy="70" rx="36" ry="46" fill="#E11D48" stroke="#9F1239" stroke-width="2"/>
      <ellipse cx="45" cy="70" rx="16" ry="46" fill="none" stroke="#FDE047" stroke-width="2"/>
      <rect x="25" y="116" width="40" height="8" rx="3" fill="#D97706"/>
      <line x1="45" y1="124" x2="45" y2="170" stroke="#FBBF24" stroke-width="4"/>
    </g>
  </g>
</svg>
`;

// -------------------------------------------------------------
// 3. LISTENING HERO (Listening Studio /typing?mode=listen)
// -------------------------------------------------------------
const listeningHeroSvg = `
<svg width="1200" height="500" viewBox="0 0 1200 500" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="lBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0F172A"/>
      <stop offset="50%" stop-color="#1E1B4B"/>
      <stop offset="100%" stop-color="#182238"/>
    </linearGradient>
    <linearGradient id="waveGrad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#38BDF8"/>
      <stop offset="50%" stop-color="#818CF8"/>
      <stop offset="100%" stop-color="#C084FC"/>
    </linearGradient>
    <filter id="lShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#000" flood-opacity="0.5"/>
    </filter>
  </defs>

  <rect width="1200" height="500" rx="32" fill="url(#lBg)"/>

  <!-- Left: Soundwave &amp; Conversation Dialogue Bubble -->
  <g transform="translate(120, 100)" filter="url(#lShadow)">
    <rect x="0" y="30" width="420" height="240" rx="24" fill="#1E293B" stroke="#334155" stroke-width="2.5"/>
    
    <text x="40" y="85" font-family="'Lora', serif" font-size="32" font-weight="bold" fill="#F8FAFC">听力馆</text>
    <text x="145" y="75" font-family="sans-serif" font-size="14" font-weight="bold" fill="#38BDF8">LISTENING STUDIO</text>
    <text x="145" y="95" font-family="sans-serif" font-size="12" fill="#94A3B8">Nghe phát âm chuẩn Bắc Kinh &amp; Luyện phản xạ gõ</text>

    <!-- Animated Waveform Bars -->
    <g transform="translate(40, 130)">
      <rect x="0" y="25" width="8" height="50" rx="4" fill="url(#waveGrad)"/>
      <rect x="18" y="10" width="8" height="80" rx="4" fill="url(#waveGrad)"/>
      <rect x="36" y="35" width="8" height="30" rx="4" fill="url(#waveGrad)"/>
      <rect x="54" y="0" width="8" height="100" rx="4" fill="url(#waveGrad)"/>
      <rect x="72" y="20" width="8" height="60" rx="4" fill="url(#waveGrad)"/>
      <rect x="90" y="40" width="8" height="20" rx="4" fill="url(#waveGrad)"/>
      <rect x="108" y="15" width="8" height="70" rx="4" fill="url(#waveGrad)"/>
      <rect x="126" y="5" width="8" height="90" rx="4" fill="url(#waveGrad)"/>
      <rect x="144" y="30" width="8" height="40" rx="4" fill="url(#waveGrad)"/>
      <rect x="162" y="10" width="8" height="80" rx="4" fill="url(#waveGrad)"/>
      <rect x="180" y="25" width="8" height="50" rx="4" fill="url(#waveGrad)"/>
      <rect x="198" y="40" width="8" height="20" rx="4" fill="url(#waveGrad)"/>
      <rect x="216" y="15" width="8" height="70" rx="4" fill="url(#waveGrad)"/>
      <rect x="234" y="0" width="8" height="100" rx="4" fill="url(#waveGrad)"/>
      <rect x="252" y="20" width="8" height="60" rx="4" fill="url(#waveGrad)"/>
      <rect x="270" y="35" width="8" height="30" rx="4" fill="url(#waveGrad)"/>
      <rect x="288" y="10" width="8" height="80" rx="4" fill="url(#waveGrad)"/>
      <rect x="306" y="25" width="8" height="50" rx="4" fill="url(#waveGrad)"/>
      <rect x="324" y="45" width="8" height="10" rx="4" fill="url(#waveGrad)"/>
    </g>
  </g>

  <!-- Right: 3D Headphones &amp; Chinese Speech Bubbles -->
  <g transform="translate(700, 70)" filter="url(#lShadow)">
    <!-- Big 3D Headphone Arc -->
    <path d="M 90 240 A 130 130 0 0 1 350 240" fill="none" stroke="#475569" stroke-width="26" stroke-linecap="round"/>
    <path d="M 90 240 A 130 130 0 0 1 350 240" fill="none" stroke="#38BDF8" stroke-width="12" stroke-linecap="round"/>

    <!-- Left Ear Cup -->
    <rect x="60" y="220" width="46" height="80" rx="23" fill="#0284C7" stroke="#38BDF8" stroke-width="3"/>
    <!-- Right Ear Cup -->
    <rect x="334" y="220" width="46" height="80" rx="23" fill="#0284C7" stroke="#38BDF8" stroke-width="3"/>

    <!-- Floating Speech Bubble: 你好吗? -->
    <g transform="translate(140, 140)">
      <rect x="0" y="0" width="160" height="60" rx="18" fill="#FFFDF9" stroke="#818CF8" stroke-width="2.5"/>
      <text x="80" y="38" font-family="serif" font-size="24" font-weight="bold" fill="#1E1B4B" text-anchor="middle">你好吗？</text>
      <polygon points="50,60 70,60 55,75" fill="#FFFDF9"/>
    </g>

    <!-- Floating Speech Bubble: 很好！ -->
    <g transform="translate(220, 240)">
      <rect x="0" y="0" width="140" height="54" rx="16" fill="#ECFDF5" stroke="#10B981" stroke-width="2"/>
      <text x="70" y="35" font-family="serif" font-size="22" font-weight="bold" fill="#065F46" text-anchor="middle">我很好！</text>
    </g>
  </g>
</svg>
`;

// -------------------------------------------------------------
// 4. TYPING HERO (Typing Studio /typing)
// -------------------------------------------------------------
const typingHeroSvg = `
<svg width="1200" height="500" viewBox="0 0 1200 500" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="tBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#182238"/>
      <stop offset="50%" stop-color="#0F172A"/>
      <stop offset="100%" stop-color="#1E293B"/>
    </linearGradient>
    <linearGradient id="keyGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" stop-color="#FFFFFF"/>
      <stop offset="100%" stop-color="#E2E8F0"/>
    </linearGradient>
    <filter id="tShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#000" flood-opacity="0.45"/>
    </filter>
  </defs>

  <rect width="1200" height="500" rx="32" fill="url(#tBg)"/>

  <!-- Left: Stylized Mechanical Keyboard &amp; Pinyin Input -->
  <g transform="translate(100, 100)" filter="url(#tShadow)">
    <rect x="0" y="30" width="460" height="240" rx="24" fill="#FAF7F2" stroke="#182238" stroke-width="3"/>
    
    <!-- Top Display Screen -->
    <rect x="25" y="55" width="410" height="60" rx="14" fill="#182238"/>
    <text x="45" y="93" font-family="sans-serif" font-size="18" font-weight="bold" fill="#FCD34D">pinyin: ni hao | 1.你好 2.拟好</text>

    <!-- Keycaps Matrix -->
    <g transform="translate(25, 135)">
      <!-- Row 1 -->
      <rect x="0" y="0" width="48" height="42" rx="8" fill="url(#keyGrad)" stroke="#CBD5E1" stroke-width="1.5"/>
      <text x="24" y="26" font-family="sans-serif" font-weight="bold" font-size="14" fill="#182238" text-anchor="middle">Q</text>

      <rect x="56" y="0" width="48" height="42" rx="8" fill="url(#keyGrad)" stroke="#CBD5E1" stroke-width="1.5"/>
      <text x="80" y="26" font-family="sans-serif" font-weight="bold" font-size="14" fill="#182238" text-anchor="middle">W</text>

      <rect x="112" y="0" width="48" height="42" rx="8" fill="url(#keyGrad)" stroke="#CBD5E1" stroke-width="1.5"/>
      <text x="136" y="26" font-family="sans-serif" font-weight="bold" font-size="14" fill="#182238" text-anchor="middle">E</text>

      <rect x="168" y="0" width="48" height="42" rx="8" fill="url(#keyGrad)" stroke="#CBD5E1" stroke-width="1.5"/>
      <text x="192" y="26" font-family="sans-serif" font-weight="bold" font-size="14" fill="#182238" text-anchor="middle">R</text>

      <rect x="224" y="0" width="48" height="42" rx="8" fill="url(#keyGrad)" stroke="#CBD5E1" stroke-width="1.5"/>
      <text x="248" y="26" font-family="sans-serif" font-weight="bold" font-size="14" fill="#182238" text-anchor="middle">T</text>

      <rect x="280" y="0" width="48" height="42" rx="8" fill="url(#keyGrad)" stroke="#CBD5E1" stroke-width="1.5"/>
      <text x="304" y="26" font-family="sans-serif" font-weight="bold" font-size="14" fill="#182238" text-anchor="middle">Y</text>

      <rect x="336" y="0" width="74" height="42" rx="8" fill="#B8322D" stroke="#991B1B" stroke-width="1.5"/>
      <text x="373" y="26" font-family="sans-serif" font-weight="bold" font-size="12" fill="#FFFFFF" text-anchor="middle">ENTER</text>

      <!-- Row 2 (Space bar) -->
      <rect x="80" y="52" width="240" height="40" rx="10" fill="url(#keyGrad)" stroke="#CBD5E1" stroke-width="1.5"/>
      <text x="200" y="76" font-family="sans-serif" font-weight="bold" font-size="12" fill="#64748B" text-anchor="middle">SPACE (Xác nhận chữ Hán)</text>
    </g>
  </g>

  <!-- Right: Speedometer &amp; Floating Hanzi Keys -->
  <g transform="translate(680, 80)" filter="url(#tShadow)">
    <!-- Speedometer CPM Ring -->
    <circle cx="160" cy="160" r="120" fill="#1E293B" stroke="#334155" stroke-width="8"/>
    <circle cx="160" cy="160" r="100" fill="#0F172A"/>
    
    <!-- Gauge Arc -->
    <path d="M 80 200 A 90 90 0 1 1 240 200" fill="none" stroke="#F59E0B" stroke-width="12" stroke-linecap="round"/>
    
    <text x="160" y="150" font-family="sans-serif" font-size="44" font-weight="bold" fill="#FCD34D" text-anchor="middle">120</text>
    <text x="160" y="180" font-family="sans-serif" font-size="14" font-weight="bold" fill="#94A3B8" text-anchor="middle">CPM (Ký tự / phút)</text>
    <text x="160" y="205" font-family="sans-serif" font-size="12" fill="#10B981" text-anchor="middle">Độ chính xác: 98%</text>

    <!-- Floating Key: 中 -->
    <g transform="translate(320, 60) rotate(14)">
      <rect x="0" y="0" width="90" height="90" rx="20" fill="#FFFDF9" stroke="#182238" stroke-width="3"/>
      <text x="45" y="58" font-family="serif" font-size="44" font-weight="bold" fill="#B8322D" text-anchor="middle">中</text>
    </g>

    <!-- Floating Key: 文 -->
    <g transform="translate(350, 180) rotate(-10)">
      <rect x="0" y="0" width="80" height="80" rx="18" fill="#FFFDF9" stroke="#182238" stroke-width="3"/>
      <text x="40" y="52" font-family="serif" font-size="38" font-weight="bold" fill="#182238" text-anchor="middle">文</text>
    </g>
  </g>
</svg>
`;

// -------------------------------------------------------------
// 5. RADICALS HERO (214 Radicals /radicals)
// -------------------------------------------------------------
const radicalsHeroSvg = `
<svg width="1200" height="500" viewBox="0 0 1200 500" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="rBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#141E30"/>
      <stop offset="50%" stop-color="#243B55"/>
      <stop offset="100%" stop-color="#182238"/>
    </linearGradient>
    <filter id="rShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#000" flood-opacity="0.4"/>
    </filter>
  </defs>

  <rect width="1200" height="500" rx="32" fill="url(#rBg)"/>

  <!-- Left: Radical Elemental Tiles -->
  <g transform="translate(100, 90)" filter="url(#rShadow)">
    <rect x="0" y="30" width="460" height="260" rx="24" fill="#FFFDF9" stroke="#CBD5E1" stroke-width="2.5"/>
    
    <text x="40" y="85" font-family="'Lora', serif" font-size="32" font-weight="bold" fill="#182238">214 部首</text>
    <text x="175" y="75" font-family="sans-serif" font-size="14" font-weight="bold" fill="#B8322D">BỘ THỦ KHANG HY</text>
    <text x="175" y="95" font-family="sans-serif" font-size="12" fill="#64748B">Gốc rễ cấu tạo nên mọi chữ Hán</text>

    <!-- 5 Elemental Radicals -->
    <g transform="translate(35, 130)">
      <!-- Water -->
      <rect x="0" y="0" width="70" height="85" rx="14" fill="#EFF6FF" stroke="#3B82F6" stroke-width="2"/>
      <text x="35" y="44" font-family="serif" font-size="32" font-weight="bold" fill="#1D4ED8" text-anchor="middle">氵</text>
      <text x="35" y="68" font-family="sans-serif" font-size="11" font-weight="bold" fill="#2563EB" text-anchor="middle">Thủy (Nước)</text>

      <!-- Fire -->
      <rect x="78" y="0" width="70" height="85" rx="14" fill="#FEF2F2" stroke="#EF4444" stroke-width="2"/>
      <text x="113" y="44" font-family="serif" font-size="32" font-weight="bold" fill="#B91C1C" text-anchor="middle">灬</text>
      <text x="113" y="68" font-family="sans-serif" font-size="11" font-weight="bold" fill="#DC2626" text-anchor="middle">Hỏa (Lửa)</text>

      <!-- Wood -->
      <rect x="156" y="0" width="70" height="85" rx="14" fill="#ECFDF5" stroke="#10B981" stroke-width="2"/>
      <text x="191" y="44" font-family="serif" font-size="32" font-weight="bold" fill="#065F46" text-anchor="middle">木</text>
      <text x="191" y="68" font-family="sans-serif" font-size="11" font-weight="bold" fill="#059669" text-anchor="middle">Mộc (Cây)</text>

      <!-- Person -->
      <rect x="234" y="0" width="70" height="85" rx="14" fill="#FEF3C7" stroke="#F59E0B" stroke-width="2"/>
      <text x="269" y="44" font-family="serif" font-size="32" font-weight="bold" fill="#92400E" text-anchor="middle">亻</text>
      <text x="269" y="68" font-family="sans-serif" font-size="11" font-weight="bold" fill="#B45309" text-anchor="middle">Nhân (Người)</text>

      <!-- Heart -->
      <rect x="312" y="0" width="70" height="85" rx="14" fill="#FDF2F8" stroke="#EC4899" stroke-width="2"/>
      <text x="347" y="44" font-family="serif" font-size="32" font-weight="bold" fill="#9D174D" text-anchor="middle">忄</text>
      <text x="347" y="68" font-family="sans-serif" font-size="11" font-weight="bold" fill="#BE185D" text-anchor="middle">Tâm (Lòng)</text>
    </g>

    <text x="40" y="255" font-family="sans-serif" font-size="12" fill="#64748B">
      Học bộ thủ giúp nhận diện mặt chữ nhanh gấp 3 lần và tra cứu từ điển chuẩn xác.
    </text>
  </g>

  <!-- Right: Chinese Calligraphy Brush &amp; Ink Splash -->
  <g transform="translate(680, 80)" filter="url(#rShadow)">
    <g transform="rotate(-25 180 160)">
      <!-- Brush handle -->
      <rect x="175" y="20" width="18" height="260" rx="9" fill="#78350F"/>
      <!-- Ferrule -->
      <rect x="172" y="260" width="24" height="25" rx="4" fill="#D97706"/>
      <!-- Bristles -->
      <path d="M 174 285 C 174 330 184 360 184 360 C 184 360 194 330 194 285 Z" fill="#182238"/>
    </g>

    <!-- Ink Splash Shapes -->
    <circle cx="280" cy="280" r="32" fill="#0F172A"/>
    <circle cx="330" cy="260" r="14" fill="#0F172A"/>
    <circle cx="250" cy="320" r="12" fill="#0F172A"/>
    <circle cx="350" cy="300" r="8" fill="#0F172A"/>
  </g>
</svg>
`;

// -------------------------------------------------------------
// 6. WRITING HERO (Writing Studio /write)
// -------------------------------------------------------------
const writingHeroSvg = `
<svg width="1200" height="500" viewBox="0 0 1200 500" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="wBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#31101E"/>
      <stop offset="50%" stop-color="#581C87"/>
      <stop offset="100%" stop-color="#182238"/>
    </linearGradient>
    <filter id="wShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#000" flood-opacity="0.45"/>
    </filter>
  </defs>

  <rect width="1200" height="500" rx="32" fill="url(#wBg)"/>

  <!-- Left: Rice Paper Scroll with Stroke Orders -->
  <g transform="translate(100, 90)" filter="url(#wShadow)">
    <rect x="0" y="30" width="460" height="250" rx="24" fill="#FFFDF9" stroke="#CBD5E1" stroke-width="2.5"/>
    <text x="40" y="85" font-family="'Lora', serif" font-size="32" font-weight="bold" fill="#182238">练字馆</text>
    <text x="155" y="75" font-family="sans-serif" font-size="14" font-weight="bold" fill="#A855F7">WRITING STUDIO</text>
    <text x="155" y="95" font-family="sans-serif" font-size="12" fill="#64748B">Luyện viết chữ Hán đúng quy tắc bút thuận</text>

    <!-- Stroke Order Demonstration: 永 (8 nét cơ bản) -->
    <g transform="translate(40, 125)">
      <rect x="0" y="0" width="90" height="90" rx="16" fill="#FAF5FF" stroke="#A855F7" stroke-width="2"/>
      <text x="45" y="60" font-family="serif" font-size="52" font-weight="bold" fill="#581C87" text-anchor="middle">永</text>
      <text x="45" y="82" font-family="sans-serif" font-size="10" font-weight="bold" fill="#7E22CE" text-anchor="middle">Vĩnh Tự Bát Pháp</text>

      <!-- 8 Principle Strokes labels -->
      <g transform="translate(110, 15)">
        <text x="0" y="15" font-family="sans-serif" font-size="12" font-weight="bold" fill="#182238">1. 点 (Điểm) • 2. 横 (Hoành) • 3. 竖 (Thụ)</text>
        <text x="0" y="38" font-family="sans-serif" font-size="12" font-weight="bold" fill="#182238">4. 钩 (Câu) • 5. 提 (Đề) • 6. 撇 (Phẩy)</text>
        <text x="0" y="61" font-family="sans-serif" font-size="12" font-weight="bold" fill="#182238">7. 短撇 (Đoản phẩy) • 8. 捺 (Mác)</text>
      </g>
    </g>
  </g>

  <!-- Right: Calligraphy Desk with Ink &amp; Brush -->
  <g transform="translate(680, 80)" filter="url(#wShadow)">
    <!-- Red Seal Stamp -->
    <g transform="translate(180, 60)">
      <rect x="0" y="0" width="70" height="70" rx="14" fill="#B8322D"/>
      <rect x="8" y="8" width="54" height="54" rx="8" fill="#991B1B"/>
      <text x="35" y="45" font-family="serif" font-size="28" font-weight="bold" fill="#FDE047" text-anchor="middle">書</text>
    </g>

    <!-- Brush Rest (Giá gác bút) -->
    <path d="M 60 260 C 100 220 120 220 160 260 C 200 220 220 220 260 260 Z" fill="#4B5563"/>

    <!-- Calligraphy Brush resting -->
    <g transform="rotate(-15 160 200)">
      <rect x="40" y="195" width="240" height="14" rx="7" fill="#92400E"/>
      <path d="M 280 192 C 310 192 330 202 330 202 C 330 202 310 212 280 212 Z" fill="#182238"/>
    </g>
  </g>
</svg>
`;

// -------------------------------------------------------------
// 7. PRONUNCIATION / 4 TONES HERO
// -------------------------------------------------------------
const tonesHeroSvg = `
<svg width="1200" height="500" viewBox="0 0 1200 500" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="pBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#064E3B"/>
      <stop offset="50%" stop-color="#065F46"/>
      <stop offset="100%" stop-color="#182238"/>
    </linearGradient>
    <filter id="pShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#000" flood-opacity="0.4"/>
    </filter>
  </defs>

  <rect width="1200" height="500" rx="32" fill="url(#pBg)"/>

  <!-- Left: 4 Tones Chart -->
  <g transform="translate(100, 90)" filter="url(#pShadow)">
    <rect x="0" y="30" width="480" height="250" rx="24" fill="#FFFDF9" stroke="#CBD5E1" stroke-width="2.5"/>
    <text x="40" y="85" font-family="'Lora', serif" font-size="32" font-weight="bold" fill="#182238">汉语拼音</text>
    <text x="185" y="75" font-family="sans-serif" font-size="14" font-weight="bold" fill="#059669">PINYIN &amp; 4 THANH ĐIỆU</text>
    <text x="185" y="95" font-family="sans-serif" font-size="12" fill="#64748B">Quy luật độ cao giọng nói (Pitch Scale 1–5)</text>

    <!-- 4 Tones Boxes -->
    <g transform="translate(35, 130)">
      <!-- Tone 1 -->
      <rect x="0" y="0" width="95" height="85" rx="14" fill="#ECFDF5" stroke="#10B981" stroke-width="2"/>
      <text x="47" y="38" font-family="sans-serif" font-size="28" font-weight="bold" fill="#065F46" text-anchor="middle">mā</text>
      <line x1="25" y1="52" x2="70" y2="52" stroke="#10B981" stroke-width="3" stroke-linecap="round"/>
      <text x="47" y="72" font-family="sans-serif" font-size="11" font-weight="bold" fill="#047857" text-anchor="middle">Thanh 1 (Cao phẳng)</text>

      <!-- Tone 2 -->
      <rect x="105" y="0" width="95" height="85" rx="14" fill="#EFF6FF" stroke="#3B82F6" stroke-width="2"/>
      <text x="152" y="38" font-family="sans-serif" font-size="28" font-weight="bold" fill="#1D4ED8" text-anchor="middle">má</text>
      <line x1="130" y1="56" x2="175" y2="44" stroke="#3B82F6" stroke-width="3" stroke-linecap="round"/>
      <text x="152" y="72" font-family="sans-serif" font-size="11" font-weight="bold" fill="#2563EB" text-anchor="middle">Thanh 2 (Đi lên)</text>

      <!-- Tone 3 -->
      <rect x="210" y="0" width="95" height="85" rx="14" fill="#FEF3C7" stroke="#F59E0B" stroke-width="2"/>
      <text x="257" y="38" font-family="sans-serif" font-size="28" font-weight="bold" fill="#92400E" text-anchor="middle">mǎ</text>
      <polyline points="235,48 257,56 280,46" fill="none" stroke="#F59E0B" stroke-width="3" stroke-linecap="round"/>
      <text x="257" y="72" font-family="sans-serif" font-size="11" font-weight="bold" fill="#B45309" text-anchor="middle">Thanh 3 (Uốn lượn)</text>

      <!-- Tone 4 -->
      <rect x="315" y="0" width="95" height="85" rx="14" fill="#FEF2F2" stroke="#EF4444" stroke-width="2"/>
      <text x="362" y="38" font-family="sans-serif" font-size="28" font-weight="bold" fill="#B91C1C" text-anchor="middle">mà</text>
      <line x1="340" y1="44" x2="385" y2="56" stroke="#EF4444" stroke-width="3" stroke-linecap="round"/>
      <text x="362" y="72" font-family="sans-serif" font-size="11" font-weight="bold" fill="#DC2626" text-anchor="middle">Thanh 4 (Rơi mạnh)</text>
    </g>
  </g>

  <!-- Right: 3D Tone Pitch Contour Curve -->
  <g transform="translate(680, 100)" filter="url(#pShadow)">
    <rect x="0" y="20" width="420" height="240" rx="24" fill="#064E3B" stroke="#047857" stroke-width="2.5"/>
    <text x="30" y="60" font-family="sans-serif" font-size="14" font-weight="bold" fill="#6EE7B7">BIỂU ĐỒ 5 MỨC CAO ĐỘ (PITCH 5-5, 3-5, 2-1-4, 5-1)</text>

    <!-- Pitch Grid Lines 5, 4, 3, 2, 1 -->
    <g transform="translate(60, 80)">
      <line x1="0" y1="0" x2="320" y2="0" stroke="#065F46" stroke-width="1.5" stroke-dasharray="4,4"/>
      <text x="-25" y="5" font-family="sans-serif" font-size="12" fill="#A7F3D0">5 Cao</text>

      <line x1="0" y1="35" x2="320" y2="35" stroke="#065F46" stroke-width="1.5" stroke-dasharray="4,4"/>
      <text x="-25" y="40" font-family="sans-serif" font-size="12" fill="#A7F3D0">4</text>

      <line x1="0" y1="70" x2="320" y2="70" stroke="#065F46" stroke-width="1.5" stroke-dasharray="4,4"/>
      <text x="-25" y="75" font-family="sans-serif" font-size="12" fill="#A7F3D0">3 Vừa</text>

      <line x1="0" y1="105" x2="320" y2="105" stroke="#065F46" stroke-width="1.5" stroke-dasharray="4,4"/>
      <text x="-25" y="110" font-family="sans-serif" font-size="12" fill="#A7F3D0">2</text>

      <line x1="0" y1="140" x2="320" y2="140" stroke="#065F46" stroke-width="1.5" stroke-dasharray="4,4"/>
      <text x="-25" y="145" font-family="sans-serif" font-size="12" fill="#A7F3D0">1 Thấp</text>

      <!-- Colored curves -->
      <!-- T1 -->
      <line x1="20" y1="0" x2="80" y2="0" stroke="#34D399" stroke-width="4" stroke-linecap="round"/>
      <!-- T2 -->
      <line x1="100" y1="70" x2="160" y2="0" stroke="#60A5FA" stroke-width="4" stroke-linecap="round"/>
      <!-- T3 -->
      <polyline points="180,105 210,140 240,35" fill="none" stroke="#FBBF24" stroke-width="4" stroke-linecap="round"/>
      <!-- T4 -->
      <line x1="260" y1="0" x2="310" y2="140" stroke="#F87171" stroke-width="4" stroke-linecap="round"/>
    </g>
  </g>
</svg>
`;

// -------------------------------------------------------------
// 8. DASHBOARD HERO (Dashboard & User Profile /profile)
// -------------------------------------------------------------
const dashboardHeroSvg = `
<svg width="1200" height="500" viewBox="0 0 1200 500" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="dBg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#182238"/>
      <stop offset="40%" stop-color="#2B395B"/>
      <stop offset="100%" stop-color="#B8322D"/>
    </linearGradient>
    <filter id="dSh" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#000" flood-opacity="0.4"/>
    </filter>
  </defs>
  <rect width="1200" height="500" rx="32" fill="url(#dBg)"/>
  <circle cx="600" cy="450" r="320" fill="#FBBF24" fill-opacity="0.15"/>
  <g transform="translate(100, 100)" filter="url(#dSh)">
    <rect x="0" y="30" width="480" height="240" rx="24" fill="#FFFDF9" stroke="#E2E8F0" stroke-width="2.5"/>
    <text x="40" y="85" font-family="'Lora', serif" font-size="32" font-weight="bold" fill="#182238">个人中心</text>
    <text x="180" y="75" font-family="sans-serif" font-size="14" font-weight="bold" fill="#B8322D">DASHBOARD &amp; TIẾN ĐỘ</text>
    <text x="180" y="95" font-family="sans-serif" font-size="12" fill="#64748B">Theo dõi hành trình chinh phục tiếng Trung mỗi ngày</text>
    <g transform="translate(40, 130)">
      <rect x="0" y="0" width="120" height="75" rx="14" fill="#FEF2F2" stroke="#EF4444" stroke-width="1.5"/>
      <text x="60" y="32" font-family="sans-serif" font-size="11" font-weight="bold" fill="#B91C1C" text-anchor="middle">TỪ ĐÃ THUỘC</text>
      <text x="60" y="60" font-family="sans-serif" font-size="24" font-weight="bold" fill="#991B1B" text-anchor="middle">HSK 1-6</text>
      
      <rect x="140" y="0" width="120" height="75" rx="14" fill="#ECFDF5" stroke="#10B981" stroke-width="1.5"/>
      <text x="200" y="32" font-family="sans-serif" font-size="11" font-weight="bold" fill="#065F46" text-anchor="middle">CHU KỲ SM-2</text>
      <text x="200" y="60" font-family="sans-serif" font-size="24" font-weight="bold" fill="#047857" text-anchor="middle">TỐI ƯU</text>

      <rect x="280" y="0" width="120" height="75" rx="14" fill="#EFF6FF" stroke="#3B82F6" stroke-width="1.5"/>
      <text x="340" y="32" font-family="sans-serif" font-size="11" font-weight="bold" fill="#1D4ED8" text-anchor="middle">PHẢN XẠ GÕ</text>
      <text x="340" y="60" font-family="sans-serif" font-size="24" font-weight="bold" fill="#1E40AF" text-anchor="middle">IME PRO</text>
    </g>
  </g>
  <g transform="translate(750, 110)" filter="url(#dSh)">
    <circle cx="180" cy="120" r="90" fill="#F59E0B" fill-opacity="0.9"/>
    <path d="M 120 200 L 180 140 L 240 200 Z" fill="#182238"/>
    <rect x="130" y="200" width="100" height="60" fill="#182238"/>
  </g>
</svg>
`;

// -------------------------------------------------------------
// 9. NINE VOCABULARY TOPIC COVERS (600x400)
// -------------------------------------------------------------
const topics = [
  { id: 'vocab-family', title: '家庭 • Gia đình', color: '#B8322D', sub: 'Bố mẹ, anh chị em, người thân' },
  { id: 'vocab-school', title: '学校 • Trường học', color: '#1E40AF', sub: 'Thầy cô, bạn bè, lớp học, thi cử' },
  { id: 'vocab-food', title: '饮食 • Ẩm thực', color: '#D97706', sub: 'Món ăn Trung Hoa, trà, hoa quả' },
  { id: 'vocab-animals', title: '动物 • Động vật', color: '#047857', sub: 'Gấu trúc, chim, cá, thú cưng' },
  { id: 'vocab-jobs', title: '职业 • Nghề nghiệp', color: '#4F46E5', sub: 'Bác sĩ, giáo viên, kỹ sư, kinh doanh' },
  { id: 'vocab-travel', title: '旅游 • Du lịch', color: '#0891B2', sub: 'Sân bay, khách sạn, Vạn Lý Trường Thành' },
  { id: 'vocab-home', title: '住宅 • Nhà cửa', color: '#C026D3', sub: 'Phòng khách, bếp, đồ dùng sinh hoạt' },
  { id: 'vocab-weather', title: '天气 • Thời tiết', color: '#EA580C', sub: 'Nắng, mưa, bốn mùa xuân hạ thu đông' },
  { id: 'vocab-daily', title: '日常 • Hoạt động ngày', color: '#475569', sub: 'Thức dậy, đi làm, mua sắm, giải trí' },
];

function generateTopicSvg(item) {
  return `
<svg width="600" height="400" viewBox="0 0 600 400" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="tGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="${item.color}"/>
      <stop offset="60%" stop-color="#182238"/>
      <stop offset="100%" stop-color="#0F172A"/>
    </linearGradient>
  </defs>

  <rect width="600" height="400" rx="28" fill="url(#tGrad)"/>

  <!-- Subtle circles -->
  <circle cx="100" cy="80" r="120" fill="#FFFFFF" fill-opacity="0.04"/>
  <circle cx="500" cy="320" r="140" fill="#FFFFFF" fill-opacity="0.03"/>

  <!-- Content Card -->
  <g transform="translate(60, 90)">
    <rect x="0" y="0" width="480" height="220" rx="20" fill="#FFFDF9" stroke="#E2E8F0" stroke-width="2.5"/>
    <rect x="0" y="0" width="480" height="10" rx="5" fill="${item.color}"/>

    <text x="40" y="70" font-family="'Lora', serif" font-size="34" font-weight="bold" fill="#182238">${item.title}</text>
    <text x="40" y="105" font-family="'Be Vietnam Pro', sans-serif" font-size="15" fill="#64748B" font-weight="500">${item.sub}</text>

    <!-- Interactive Pill -->
    <rect x="40" y="140" width="160" height="42" rx="12" fill="${item.color}"/>
    <text x="120" y="166" font-family="sans-serif" font-size="13" font-weight="bold" fill="#FFFFFF" text-anchor="middle">Khám phá chủ đề →</text>
  </g>
</svg>
`;
}

// -------------------------------------------------------------
// MAIN GENERATOR PIPELINE
// -------------------------------------------------------------
async function run() {
  console.log('--- STARTING ASSET GENERATION PIPELINE ---');

  // 1. Module Heroes
  await renderSvgToWebp(grammarHeroSvg, 'public/images/grammar/grammar-hero.webp', 1200, 500);
  await renderSvgToWebp(vocabHeroSvg, 'public/images/vocabulary/vocab-hero.webp', 1200, 500);
  await renderSvgToWebp(listeningHeroSvg, 'public/images/listening/listening-hero.webp', 1200, 500);
  await renderSvgToWebp(typingHeroSvg, 'public/images/typing/typing-hero.webp', 1200, 500);
  await renderSvgToWebp(radicalsHeroSvg, 'public/images/radicals/radicals-hero.webp', 1200, 500);
  await renderSvgToWebp(writingHeroSvg, 'public/images/writing/writing-hero.webp', 1200, 500);
  await renderSvgToWebp(tonesHeroSvg, 'public/images/pronunciation/tones-hero.webp', 1200, 500);
  await renderSvgToWebp(dashboardHeroSvg, 'public/images/dashboard/dashboard-hero.webp', 1200, 500);

  // 2. 9 Vocabulary Topic Covers
  for (const t of topics) {
    const svg = generateTopicSvg(t);
    await renderSvgToWebp(svg, `public/images/vocabulary/${t.id}.webp`, 600, 400);
  }

  console.log('--- ASSET GENERATION COMPLETED SUCCESSFULLY ---');
}

run().catch(console.error);
