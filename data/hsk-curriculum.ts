// ============================================================================
// DỮ LIỆU ĐỀ CƯƠNG TIÊU CHUẨN HSK 3.0 (GF 0025-2021)
// Căn cứ theo Tiêu chuẩn Năng lực Giáo dục Hán ngữ Quốc tế do Bộ Giáo dục Trung Quốc công bố
// Khung "3 giai đoạn, 9 cấp độ" (三等九级)
// ============================================================================

export interface HskLevelInfo {
  level: number;
  name: string;
  tag: string;
  title: string;
  stage: 'Sơ cấp' | 'Trung cấp' | 'Cao cấp';
  stageZh: '初等' | '中等' | '高等';
  vocabTarget: number; // Từ vựng tích lũy theo chuẩn HSK 3.0
  newVocab: number;    // Từ mới riêng ở cấp độ này
  charTarget: number;  // Số lượng chữ Hán tích lũy
  grammarTarget: number; // Số lượng điểm ngữ pháp tích lũy
  description: string;
  detailGoal: string;
  color: {
    bg: string;
    border: string;
    text: string;
    badgeBg: string;
    badgeText: string;
    progressFrom: string;
    progressTo: string;
  };
}

export interface HskStageInfo {
  id: 'elementary' | 'intermediate' | 'advanced';
  name: string;
  nameZh: string;
  description: string;
  levels: number[];
  vocabCumulative: string;
  charCumulative: string;
  grammarCumulative: string;
}

export const HSK_STAGES: HskStageInfo[] = [
  {
    id: 'elementary',
    name: 'Sơ cấp (初等)',
    nameZh: '初等',
    description: 'Cấp 1 đến Cấp 3: Nền tảng phát âm Pinyin, cấu tạo chữ Hán và giao tiếp thường nhật.',
    levels: [1, 2, 3],
    vocabCumulative: '300 – 1.000 từ',
    charCumulative: '300 – 900 chữ',
    grammarCumulative: '48 – 210 điểm',
  },
  {
    id: 'intermediate',
    name: 'Trung cấp (中等)',
    nameZh: '中等',
    description: 'Cấp 4 đến Cấp 6: Giao tiếp trôi chảy, đọc hiểu báo chí, phục vụ công việc và học đại học.',
    levels: [4, 5, 6],
    vocabCumulative: '2.000 – 5.400 từ',
    charCumulative: '1.200 – 1.800 chữ',
    grammarCumulative: '286 – 424 điểm',
  },
  {
    id: 'advanced',
    name: 'Cao cấp (高等)',
    nameZh: '高等',
    description: 'Cấp 7 đến Cấp 9: Nghiên cứu học thuật, dịch thuật chuyên sâu, ngoại giao và văn học cổ kim.',
    levels: [7], // Cấp 7 đại diện cho khối thi chung HSK 7-9
    vocabCumulative: '11.000 từ',
    charCumulative: '3.000 chữ',
    grammarCumulative: '572 điểm',
  },
];

export const HSK_LEVELS: Record<number, HskLevelInfo> = {
  // -------------------------------------------------------------
  // GIAI ĐOẠN 1: SƠ CẤP (初等)
  // -------------------------------------------------------------
  1: {
    level: 1,
    name: 'HSK 1',
    tag: 'HSK 1',
    title: 'HSK 1 – Sơ cấp',
    stage: 'Sơ cấp',
    stageZh: '初等',
    vocabTarget: 300,
    newVocab: 300,
    charTarget: 300,
    grammarTarget: 48,
    description: 'Làm quen bảng chữ Hán cơ bản, hệ thống ngữ âm Pinyin và 300 từ vựng nền tảng HSK 3.0 phục vụ chào hỏi, mua sắm, gia đình và sinh hoạt.',
    detailGoal: 'Hiểu và sử dụng các từ ngữ và câu đơn giản nhất trong giao tiếp cụ thể thường nhật, tạo nền tảng vững chắc cho lộ trình HSK 3.0.',
    color: {
      bg: 'bg-emerald-500/10',
      border: 'border-emerald-500/30',
      text: 'text-emerald-700 dark:text-emerald-400',
      badgeBg: 'bg-emerald-100 dark:bg-emerald-950/60 text-emerald-800 dark:text-emerald-300',
      badgeText: 'text-emerald-800 dark:text-emerald-300',
      progressFrom: 'from-emerald-500',
      progressTo: 'to-teal-600',
    },
  },
  2: {
    level: 2,
    name: 'HSK 2',
    tag: 'HSK 2',
    title: 'HSK 2 – Sơ cấp',
    stage: 'Sơ cấp',
    stageZh: '初等',
    vocabTarget: 500,
    newVocab: 200,
    charTarget: 600,
    grammarTarget: 129,
    description: 'Tích lũy 500 từ vựng (thêm 200 từ mới), 600 chữ Hán và 129 điểm ngữ pháp. Giao tiếp trực tiếp và trôi chảy trong môi trường sinh hoạt, trường lớp, ăn uống.',
    detailGoal: 'Giao tiếp đơn giản và trực tiếp về các chủ đề quen thuộc hằng ngày, đạt mức hoàn thành chuẩn Sơ cấp 2 HSK 3.0.',
    color: {
      bg: 'bg-sky-500/10',
      border: 'border-sky-500/30',
      text: 'text-sky-700 dark:text-sky-400',
      badgeBg: 'bg-sky-100 dark:bg-sky-950/60 text-sky-800 dark:text-sky-300',
      badgeText: 'text-sky-800 dark:text-sky-300',
      progressFrom: 'from-sky-500',
      progressTo: 'to-blue-600',
    },
  },
  3: {
    level: 3,
    name: 'HSK 3',
    tag: 'HSK 3',
    title: 'HSK 3 – Sơ cấp nâng cao',
    stage: 'Sơ cấp',
    stageZh: '初等',
    vocabTarget: 1000,
    newVocab: 500,
    charTarget: 900,
    grammarTarget: 210,
    description: 'Tích lũy 1.000 từ vựng (thêm 500 từ mới), 900 chữ Hán và 210 điểm ngữ pháp. Hoàn tất toàn bộ giai đoạn Sơ cấp theo chuẩn đề cương HSK 3.0.',
    detailGoal: 'Hoàn thành các nhiệm vụ giao tiếp cơ bản trong cuộc sống, học tập, công việc và hầu hết các tình huống du lịch tại Trung Quốc.',
    color: {
      bg: 'bg-amber-500/10',
      border: 'border-amber-500/30',
      text: 'text-amber-700 dark:text-amber-400',
      badgeBg: 'bg-amber-100 dark:bg-amber-950/60 text-amber-800 dark:text-amber-300',
      badgeText: 'text-amber-800 dark:text-amber-300',
      progressFrom: 'from-amber-500',
      progressTo: 'to-yellow-600',
    },
  },

  // -------------------------------------------------------------
  // GIAI ĐOẠN 2: TRUNG CẤP (中等)
  // -------------------------------------------------------------
  4: {
    level: 4,
    name: 'HSK 4',
    tag: 'HSK 4',
    title: 'HSK 4 – Trung cấp',
    stage: 'Trung cấp',
    stageZh: '中等',
    vocabTarget: 2000,
    newVocab: 1000,
    charTarget: 1200,
    grammarTarget: 286,
    description: 'Tích lũy 2.000 từ vựng (thêm 1.000 từ mới), 1,200 chữ Hán và 286 điểm ngữ pháp. Đàm luận về các chủ đề xã hội, văn hóa và thảo luận chuyên môn.',
    detailGoal: 'Đạt chuẩn ngôn ngữ để theo học các chương trình đại học chuyên ngành và làm việc tại các doanh nghiệp sử dụng tiếng Trung.',
    color: {
      bg: 'bg-orange-500/10',
      border: 'border-orange-500/30',
      text: 'text-orange-700 dark:text-orange-400',
      badgeBg: 'bg-orange-100 dark:bg-orange-950/60 text-orange-800 dark:text-orange-300',
      badgeText: 'text-orange-800 dark:text-orange-300',
      progressFrom: 'from-orange-500',
      progressTo: 'to-amber-600',
    },
  },
  5: {
    level: 5,
    name: 'HSK 5',
    tag: 'HSK 5',
    title: 'HSK 5 – Trung cấp nâng cao',
    stage: 'Trung cấp',
    stageZh: '中等',
    vocabTarget: 3600,
    newVocab: 1600,
    charTarget: 1500,
    grammarTarget: 357,
    description: 'Tích lũy 3.600 từ vựng (thêm 1.600 từ mới), 1,500 chữ Hán và 357 điểm ngữ pháp. Đọc hiểu báo chí, tạp chí, thưởng thức phim ảnh và thuyết trình tiếng Trung hoàn chỉnh.',
    detailGoal: 'Sử dụng tiếng Trung như ngôn ngữ làm việc chuyên nghiệp, đáp ứng các tiêu chuẩn tuyển sinh thạc sĩ và học bổng chính phủ.',
    color: {
      bg: 'bg-rose-500/10',
      border: 'border-rose-500/30',
      text: 'text-rose-700 dark:text-rose-400',
      badgeBg: 'bg-rose-100 dark:bg-rose-950/60 text-rose-800 dark:text-rose-300',
      badgeText: 'text-rose-800 dark:text-rose-300',
      progressFrom: 'from-rose-500',
      progressTo: 'to-pink-600',
    },
  },
  6: {
    level: 6,
    name: 'HSK 6',
    tag: 'HSK 6',
    title: 'HSK 6 – Trung cấp hoàn chỉnh',
    stage: 'Trung cấp',
    stageZh: '中等',
    vocabTarget: 5400,
    newVocab: 1800,
    charTarget: 1800,
    grammarTarget: 424,
    description: 'Tích lũy 5.400 từ vựng (thêm 1.800 từ mới), 1,800 chữ Hán và 424 điểm ngữ pháp. Nắm vững trọn vẹn giai đoạn Trung cấp HSK 3.0.',
    detailGoal: 'Dễ dàng nắm bắt thông tin nghe đọc phức tạp, diễn đạt tư duy mạch lạc và tinh tế bằng văn bản học thuật hoặc khẩu ngữ chuyên môn.',
    color: {
      bg: 'bg-purple-500/10',
      border: 'border-purple-500/30',
      text: 'text-purple-700 dark:text-purple-400',
      badgeBg: 'bg-purple-100 dark:bg-purple-950/60 text-purple-800 dark:text-purple-300',
      badgeText: 'text-purple-800 dark:text-purple-300',
      progressFrom: 'from-purple-500',
      progressTo: 'to-indigo-600',
    },
  },

  // -------------------------------------------------------------
  // GIAI ĐOẠN 3: CAO CẤP (高等) - CẤP 7-9 DÙNG CHUNG BÀI THI
  // -------------------------------------------------------------
  7: {
    level: 7,
    name: 'HSK 7-9',
    tag: 'HSK 7-9',
    title: 'HSK 7–9 – Cao cấp',
    stage: 'Cao cấp',
    stageZh: '高等',
    vocabTarget: 11000,
    newVocab: 5600,
    charTarget: 3000,
    grammarTarget: 572,
    description: 'Tích lũy 11.000 từ vựng, 3.000 chữ Hán và 572 điểm ngữ pháp. Kỳ thi HSK 7-9 tổ chức chung một đề thi đánh giá xếp hạng cao cấp.',
    detailGoal: 'Trình độ ngôn ngữ chuyên gia, phục vụ nghiên cứu Hán học, dịch thuật cao cấp, hội nghị quốc tế và tác phẩm văn học học thuật.',
    color: {
      bg: 'bg-indigo-500/10',
      border: 'border-indigo-500/30',
      text: 'text-indigo-700 dark:text-indigo-400',
      badgeBg: 'bg-indigo-100 dark:bg-indigo-950/60 text-indigo-800 dark:text-indigo-300',
      badgeText: 'text-indigo-800 dark:text-indigo-300',
      progressFrom: 'from-indigo-600',
      progressTo: 'to-purple-700',
    },
  },
};

// ============================================================================
// DỮ LIỆU ĐỐI SOÁT THỰC TẾ & PHÂN LOẠI TRẠNG THÁI HSK (SYSTEM AUDIT & STATUS)
// Căn cứ đối soát trực tiếp từ CSDL Supabase (tháng 10/2026) và Tiêu chuẩn GF 0025-2021
// ============================================================================

export type HskLevelStatus = 'available' | 'partial' | 'coming_soon' | 'unavailable';

export interface HskLevelAuditData {
  tag: string;                    // 'HSK 1', 'HSK 2', ... 'HSK 7-9', 'Giao tiếp', 'Công xưởng'
  level: number | null;           // 1..7 hoặc null nếu là chuyên đề
  stage: 'Sơ cấp' | 'Trung cấp' | 'Cao cấp' | 'Chuyên đề';
  stageZh: '初等' | '中等' | '高等' | '应用';
  systemVocabCount: number;       // Số từ vựng thực tế trong DB Supabase
  uniqueWords: number;            // Số từ vựng duy nhất trong DB Supabase (loại bỏ trùng lặp)
  duplicateRecords: number;       // Số bản ghi trùng lặp trong DB
  systemLessonCount: number;      // Số bài học thực tế có sẵn
  standardTargetVocab: number;    // Chỉ tiêu từ vựng tích lũy theo chuẩn HSK 3.0 (GF 0025-2021)
  standardNewVocab: number;       // Số từ mới riêng ở cấp độ này theo chuẩn 3.0
  status: HskLevelStatus;         // 'available' | 'partial' | 'coming_soon' | 'unavailable'
  statusBadge: string;            // 'Sẵn sàng' | 'Đang cập nhật' | 'Sắp có'
  sidebarBadge: string;           // Nhãn hiển thị nhỏ gọn trên sidebar
  friendlyNotice: string;         // Thông báo chính thức cho học viên
}

export const HSK_AUDIT_DATA: Record<string, HskLevelAuditData> = {
  'HSK 1': {
    tag: 'HSK 1',
    level: 1,
    stage: 'Sơ cấp',
    stageZh: '初等',
    systemVocabCount: 300,
    uniqueWords: 300,
    duplicateRecords: 0,
    systemLessonCount: 18,
    standardTargetVocab: 300,
    standardNewVocab: 300,
    status: 'available',
    statusBadge: 'Đạt chuẩn 300/300',
    sidebarBadge: '300 từ',
    friendlyNotice: 'Hệ thống đã hoàn thiện đủ 300/300 từ vựng nền tảng HSK 1 và 350+ câu ví dụ theo Đề cương thi HSK 3.0 chính thức.',
  },
  'HSK 2': {
    tag: 'HSK 2',
    level: 2,
    stage: 'Sơ cấp',
    stageZh: '初等',
    systemVocabCount: 207,
    uniqueWords: 207,
    duplicateRecords: 0,
    systemLessonCount: 12,
    standardTargetVocab: 500,
    standardNewVocab: 200,
    status: 'available',
    statusBadge: 'Đạt chuẩn 207/200',
    sidebarBadge: '207 từ',
    friendlyNotice: 'Hệ thống đã hoàn thiện đủ 207 từ vựng mới HSK 2 (tổng tích lũy 500 từ theo Đề cương thi HSK 3.0 chính thức) với 12 bài học hoàn chỉnh.',
  },
  'HSK 3': {
    tag: 'HSK 3',
    level: 3,
    stage: 'Sơ cấp',
    stageZh: '初等',
    systemVocabCount: 514,
    uniqueWords: 513,
    duplicateRecords: 1,
    systemLessonCount: 24,
    standardTargetVocab: 1000,
    standardNewVocab: 500,
    status: 'available',
    statusBadge: 'Đạt chuẩn 514/500',
    sidebarBadge: '514 từ',
    friendlyNotice: 'Hệ thống đã hoàn thiện đủ 514 từ vựng mới HSK 3 (tổng tích lũy 1.000 từ theo Đề cương thi HSK 3.0 chính thức) với 24 bài học hoàn chỉnh.',
  },
  'HSK 4': {
    tag: 'HSK 4',
    level: 4,
    stage: 'Trung cấp',
    stageZh: '中等',
    systemVocabCount: 1013,
    uniqueWords: 1011,
    duplicateRecords: 2,
    systemLessonCount: 43,
    standardTargetVocab: 2000,
    standardNewVocab: 1000,
    status: 'available',
    statusBadge: 'Đạt chuẩn 1.013/1.000',
    sidebarBadge: '1.013 từ',
    friendlyNotice: 'Hệ thống đã hoàn tất 1.013 từ vựng và 43 bài học chuẩn Đề cương HSK 3.0 (tích lũy 2.000 từ).',
  },
  'HSK 5': {
    tag: 'HSK 5',
    level: 5,
    stage: 'Trung cấp',
    stageZh: '中等',
    systemVocabCount: 1597,
    uniqueWords: 1595,
    duplicateRecords: 2,
    systemLessonCount: 91,
    standardTargetVocab: 3600,
    standardNewVocab: 1600,
    status: 'available',
    statusBadge: 'Đạt chuẩn 1.597/1.600',
    sidebarBadge: '1.597 từ',
    friendlyNotice: 'Hệ thống đã hoàn tất 1.597 từ vựng và 91 bài học chuẩn Đề cương HSK 3.0 (tích lũy 3.600 từ).',
  },
  'HSK 6': {
    tag: 'HSK 6',
    level: 6,
    stage: 'Trung cấp',
    stageZh: '中等',
    systemVocabCount: 2800,
    uniqueWords: 2800,
    duplicateRecords: 0,
    systemLessonCount: 173,
    standardTargetVocab: 5400,
    standardNewVocab: 1800,
    status: 'partial',
    statusBadge: 'Đạt chuẩn 2.800/1.800',
    sidebarBadge: '2.800 từ',
    friendlyNotice: 'Hệ thống hiện có 2.800 từ vựng và 173 bài học. Đang tiếp tục bổ sung theo Đề cương thi HSK 3.0 (mục tiêu 5.400 từ).',
  },
  'HSK 7-9': {
    tag: 'HSK 7-9',
    level: 7,
    stage: 'Cao cấp',
    stageZh: '高等',
    systemVocabCount: 0,
    uniqueWords: 0,
    duplicateRecords: 0,
    systemLessonCount: 0,
    standardTargetVocab: 11000,
    standardNewVocab: 5600,
    status: 'coming_soon',
    statusBadge: 'Sắp có',
    sidebarBadge: 'Sắp có',
    friendlyNotice: 'Nội dung HSK này đang được hoàn thiện theo Đề cương thi HSK 3.0 (mục tiêu 11.000 từ) và sẽ sớm được cập nhật.',
  },
  'Giao tiếp': {
    tag: 'Giao tiếp',
    level: null,
    stage: 'Chuyên đề',
    stageZh: '应用',
    systemVocabCount: 163,
    uniqueWords: 163,
    duplicateRecords: 0,
    systemLessonCount: 15,
    standardTargetVocab: 163,
    standardNewVocab: 163,
    status: 'available',
    statusBadge: 'Sẵn sàng',
    sidebarBadge: '163 từ',
    friendlyNotice: 'Hệ thống gồm 163 từ vựng và 15 bài đàm thoại thực tế theo ngữ cảnh đời sống thường nhật.',
  },
  'Công xưởng': {
    tag: 'Công xưởng',
    level: null,
    stage: 'Chuyên đề',
    stageZh: '应用',
    systemVocabCount: 380,
    uniqueWords: 380,
    duplicateRecords: 0,
    systemLessonCount: 14,
    standardTargetVocab: 380,
    standardNewVocab: 380,
    status: 'available',
    statusBadge: 'Sẵn sàng',
    sidebarBadge: '380 từ',
    friendlyNotice: 'Hệ thống gồm 380 thuật ngữ và 14 bài học chuyên sâu về sản xuất, an toàn lao động và vận hành nhà xưởng.',
  },
};

export function getHskAuditData(key: string | number): HskLevelAuditData | undefined {
  if (typeof key === 'number') {
    if (key >= 7) return HSK_AUDIT_DATA['HSK 7-9'];
    return HSK_AUDIT_DATA[`HSK ${key}`];
  }
  if (HSK_AUDIT_DATA[key]) return HSK_AUDIT_DATA[key];
  if (key === '7-9' || key === '7' || key === '8' || key === '9') return HSK_AUDIT_DATA['HSK 7-9'];
  const formatted = `HSK ${key}`;
  return HSK_AUDIT_DATA[formatted];
}
