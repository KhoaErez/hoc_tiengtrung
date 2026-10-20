// Module Phân Đoạn Từ Tiếng Trung và Căn Chỉnh Pinyin (Chinese Word Segmenter & Pinyin Alignment)
// Dành riêng cho chức năng Word-Level Highlighting đồng bộ với Web Speech API TTS

export interface ChineseWordToken {
  index: number;              // Chỉ số từ trong câu (0, 1, 2...)
  text: string;               // Chữ Hán hoặc từ Latin (ví dụ: '随着', '人工智能', 'AI')
  startIndex: number;         // Vị trí ký tự bắt đầu trong chuỗi chữ Hán gốc
  endIndex: number;           // Vị trí ký tự kết thúc trong chuỗi chữ Hán gốc
  isWord: boolean;            // true nếu là từ thực sự, false nếu là dấu câu/khoảng trắng
  pinyin?: string;            // Âm tiết/từ Pinyin tương ứng (ví dụ: 'réngōng zhìnéng')
  pinyinStartIndex?: number;  // Vị trí bắt đầu trong chuỗi Pinyin gốc (nếu có)
  pinyinEndIndex?: number;    // Vị trí kết thúc trong chuỗi Pinyin gốc (nếu có)
}

/**
 * Danh sách các từ ghép / cụm từ chuyên môn tiếng Trung thông dụng
 * để gộp các token ngắn của Intl.Segmenter thành 1 từ trọn vẹn đúng ngữ nghĩa
 */
const COMMON_COMPOUND_WORDS: string[] = [
  '人工智能',
  '机器学习',
  '深度学习',
  '云计算',
  '大数据',
  '互联网',
  '普通话',
  '会不会',
  '是不是',
  '能不能',
  '可不可以',
  '行不行',
  '好不好',
  '对不对',
  '为什么',
  '怎么样',
  '什么时候',
  '自行车',
  '公共汽车',
  '出租车',
  '火车站',
  '飞机场',
  '图书馆',
  '体育馆',
  '办公室',
  '洗手间',
  '电影院',
  '超市',
  '虽然',
  '但是',
  '因为',
  '所以',
  '不仅',
  '而且',
  '只要',
  '如果',
  '或者',
];

/**
 * Kiểm tra xem một chuỗi có phải là dấu câu hoặc khoảng trắng hay không
 */
export function isPunctuationOrSpace(char: string): boolean {
  if (!char || !char.trim()) return true;
  // Dấu câu tiếng Trung & tiếng Anh thông dụng (bao gồm cả dấu phẩy ASCII ',')
  const punctuationRegex = /^[，。！？!?；;:：、“”‘’'\"（）()[\]【】—–\-\s/\\、….,~《》<>·]+$/;
  return punctuationRegex.test(char);
}

/**
 * Đếm số âm tiết trong một từ Pinyin
 * Dựa vào nguyên âm có dấu hoặc nguyên âm thông thường (a, e, i, o, u, ü)
 */
export function countPinyinSyllables(token: string): number {
  if (!token) return 0;
  if (/^AI$/i.test(token.trim())) return 1;
  // Nhóm nguyên âm đại diện cho hạt nhân âm tiết Pinyin
  const vowels = token.match(/[aāáǎàeēéěèiīíǐìoōóǒòuūúǔùüǖǘǚǜ]+/gi);
  return vowels ? vowels.length : 1;
}

/**
 * Đếm số lượng chữ Hán thực tế trong một từ (bỏ qua dấu câu)
 */
export function countHanziChars(text: string): number {
  let count = 0;
  for (const ch of text) {
    if (/[\u4e00-\u9fa5\u3400-\u4dbf]/.test(ch)) {
      count++;
    } else if (/[a-zA-Z0-9]/.test(ch)) {
      // Ký tự Latinh hoặc số (như AI, HSK)
      count += 0.5;
    }
  }
  return Math.max(1, Math.round(count));
}

/**
 * 1. PHÂN ĐOẠN TỪ TIẾNG TRUNG BẰNG INTL.SEGMENTER & COMPOUND MERGE
 */
export function segmentChineseText(text: string): ChineseWordToken[] {
  if (!text) return [];

  interface RawSegment {
    segment: string;
    index: number;
    isWordLike?: boolean;
  }

  let rawSegments: RawSegment[] = [];

  // 1.1. Sử dụng Intl.Segmenter chuẩn ECMAScript nếu có hỗ trợ
  if (typeof Intl !== 'undefined' && typeof Intl.Segmenter === 'function') {
    try {
      const segmenter = new Intl.Segmenter('zh-CN', { granularity: 'word' });
      rawSegments = Array.from(segmenter.segment(text)).map((s) => ({
        segment: s.segment,
        index: s.index,
        isWordLike: s.isWordLike,
      }));
    } catch {
      rawSegments = [];
    }
  }

  // 1.2. Fallback nếu Intl.Segmenter không khả dụng
  if (rawSegments.length === 0) {
    // Regex tách từ: chữ Hán 1-2 ký tự, chữ Latinh/số, hoặc dấu câu
    const regex = /([\u4e00-\u9fa5\u3400-\u4dbf]{1,2}|[a-zA-Z0-9]+|[^\s\w\u4e00-\u9fa5]+|\s+)/g;
    let m: RegExpExecArray | null;
    while ((m = regex.exec(text)) !== null) {
      rawSegments.push({
        segment: m[0],
        index: m.index,
        isWordLike: !isPunctuationOrSpace(m[0]),
      });
    }
  }

  // 1.3. Gộp các từ ghép / thuật ngữ theo từ điển
  const mergedTokens: ChineseWordToken[] = [];
  let i = 0;

  while (i < rawSegments.length) {
    let matchedCompound: string | null = null;

    // Quét xem các token tiếp theo có tạo thành từ ghép trong danh sách không (chỉ gộp khi các segments ghép lại khớp chính xác)
    for (const compound of COMMON_COMPOUND_WORDS) {
      if (compound.length <= rawSegments[i].segment.length) continue;

      let combined = '';
      let k = i;
      while (k < rawSegments.length && combined.length < compound.length) {
        combined += rawSegments[k].segment;
        k++;
      }

      if (combined === compound) {
        matchedCompound = compound;
        break;
      }
    }

    if (matchedCompound) {
      const startIndex = rawSegments[i].index;
      const endIndex = startIndex + matchedCompound.length;

      let consumedLength = 0;
      let nextI = i;
      while (nextI < rawSegments.length && consumedLength < matchedCompound.length) {
        consumedLength += rawSegments[nextI].segment.length;
        nextI++;
      }

      mergedTokens.push({
        index: mergedTokens.length,
        text: matchedCompound,
        startIndex,
        endIndex,
        isWord: true,
      });

      i = nextI;
    } else {
      const current = rawSegments[i];
      const isWord = !isPunctuationOrSpace(current.segment);

      mergedTokens.push({
        index: mergedTokens.length,
        text: current.segment,
        startIndex: current.index,
        endIndex: current.index + current.segment.length,
        isWord,
      });

      i++;
    }
  }

  return mergedTokens;
}

/**
 * 2. CĂN CHỈNH PINYIN 1-1 VỚI TỪ CHỮ HÁN (PINYIN-HANZI ALIGNMENT)
 * Ánh xạ chính xác cụm Pinyin tương ứng cho từng từ tiếng Trung
 */
export function alignPinyinWithChineseWords(
  tokens: ChineseWordToken[],
  rawPinyinText?: string
): ChineseWordToken[] {
  if (!rawPinyinText || !rawPinyinText.trim() || tokens.length === 0) {
    return tokens;
  }

  // 1. Tách các token từ thô và dấu câu trong Pinyin
  const pinyinTokenRegex = /[a-zA-Z\u00C0-\u024F\u1E00-\u1EFF]+|[，。！？!?；;:：、“”‘’'\"（）()[\]【】—–\-\s/\\、….,~《》<>·]+/g;
  
  interface RawPinyinItem {
    text: string;
    isPunct: boolean;
    startIndex: number;
    endIndex: number;
  }

  const rawItems: RawPinyinItem[] = [];
  let m: RegExpExecArray | null;
  while ((m = pinyinTokenRegex.exec(rawPinyinText)) !== null) {
    const txt = m[0];
    rawItems.push({
      text: txt,
      isPunct: isPunctuationOrSpace(txt),
      startIndex: m.index,
      endIndex: m.index + txt.length,
    });
  }

  // 2. Tách thành danh sách các âm tiết Pinyin kèm dấu câu bám liền sau (trailing punctuation)
  interface PinyinSyllable {
    text: string;
    trailingPunct: string;
    startIndex: number;
    endIndex: number;
  }

  const pinyinSyllables: PinyinSyllable[] = [];

  for (let i = 0; i < rawItems.length; i++) {
    const item = rawItems[i];
    if (item.isPunct) continue;

    // Tìm dấu câu bám liền ngay sau (nếu có)
    let trailingPunct = '';
    let endIdx = item.endIndex;
    if (i + 1 < rawItems.length && rawItems[i + 1].isPunct) {
      trailingPunct = rawItems[i + 1].text.trim();
      endIdx = rawItems[i + 1].endIndex;
    }

    // Tách từ đa âm tiết thành các âm tiết đơn (ví dụ: gōngjiāochē -> gōng, jiāo, chē)
    const sylRegex = /([bcdfghjklmnpqrstwxyzBCDFGHJKLMNPQRSTWXYZ]*[aāáǎàeēéěèiīíǐìoōóǒòuūúǔùüǖǘǚǜ]+(?:ng|n|r)?)/gi;
    const sylMatches: string[] = [];
    let sm: RegExpExecArray | null;
    while ((sm = sylRegex.exec(item.text)) !== null) {
      if (sm[0]) sylMatches.push(sm[0]);
    }

    if (sylMatches.length === 0) {
      sylMatches.push(item.text);
    }

    sylMatches.forEach((syl, sIdx) => {
      const isLast = sIdx === sylMatches.length - 1;
      pinyinSyllables.push({
        text: syl,
        trailingPunct: isLast ? trailingPunct : '',
        startIndex: item.startIndex,
        endIndex: isLast ? endIdx : item.endIndex,
      });
    });
  }

  // 3. Căn chỉnh 1-1 giữa chữ Hán và các âm tiết Pinyin
  let sylIdx = 0;

  return tokens.map((token) => {
    if (!token.isWord) {
      // Dấu câu trong chữ Hán không cần render Pinyin riêng (vì đã bám liền vào từ đứng trước)
      return {
        ...token,
        pinyin: undefined,
      };
    }

    const targetCount = countHanziChars(token.text);
    const assignedSyllables: string[] = [];
    let firstStart: number | undefined = undefined;
    let lastEnd: number | undefined = undefined;

    for (let c = 0; c < targetCount && sylIdx < pinyinSyllables.length; c++) {
      const syl = pinyinSyllables[sylIdx];
      if (firstStart === undefined) firstStart = syl.startIndex;
      lastEnd = syl.endIndex;

      assignedSyllables.push(syl.text + (syl.trailingPunct || ''));
      sylIdx++;
    }

    return {
      ...token,
      pinyin: assignedSyllables.join(' ') || undefined,
      pinyinStartIndex: firstStart,
      pinyinEndIndex: lastEnd,
    };
  });
}

/**
 * 3. HÀM TỔNG HỢP: PHÂN ĐOẠN TỪ VÀ CĂN CHỈNH PINYIN HOÀN CHỈNH
 */
export function segmentAndAlignChinese(
  hanziText: string,
  pinyinText?: string
): ChineseWordToken[] {
  const words = segmentChineseText(hanziText);
  if (!pinyinText) return words;
  return alignPinyinWithChineseWords(words, pinyinText);
}

/**
 * 4. TÌM CHỈ SỐ TỪ TƯƠNG ỨNG TỪ EVENT.CHARINDEX CỦA WEB SPEECH API
 * Dựa vào charIndex do sự kiện onboundary trả về, tìm xem từ nào đang được phát âm
 */
export function findWordIndexByCharIndex(
  words: ChineseWordToken[],
  charIndex: number
): number {
  if (!words || words.length === 0 || charIndex < 0) return -1;

  // 1. Tìm từ chữ Hán chứa charIndex
  for (let i = 0; i < words.length; i++) {
    const w = words[i];
    if (w.isWord && charIndex >= w.startIndex && charIndex < w.endIndex) {
      return i;
    }
  }

  // 2. Nếu charIndex rơi vào dấu câu, tìm từ liền trước hoặc liền sau gần nhất
  for (let i = 0; i < words.length; i++) {
    const w = words[i];
    if (charIndex >= w.startIndex && charIndex < w.endIndex) {
      if (w.isWord) return i;
      if (i + 1 < words.length && words[i + 1].isWord) return i + 1;
      if (i > 0 && words[i - 1].isWord) return i - 1;
    }
  }

  // 3. Fallback: Nếu charIndex vượt quá hoặc ở cuối, trả về từ isWord cuối cùng
  for (let i = words.length - 1; i >= 0; i--) {
    if (words[i].isWord && charIndex >= words[i].startIndex) {
      return i;
    }
  }

  return -1;
}
