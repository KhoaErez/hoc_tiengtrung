// Dữ liệu mô tả chuẩn cho 6 cấp độ HSK (HSK 1 - HSK 6)

export interface HskLevelInfo {
  level: number;
  name: string;
  tag: string;
  title: string;
  stage: string;
  vocabTarget: number;
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

export const HSK_LEVELS: Record<number, HskLevelInfo> = {
  1: {
    level: 1,
    name: 'HSK 1',
    tag: 'HSK 1',
    title: 'HSK 1 – Sơ cấp',
    stage: 'Sơ cấp',
    vocabTarget: 150,
    description: 'Nắm vững 150 từ vựng cơ bản, làm quen chữ Hán, phát âm chuẩn Pinyin và giao tiếp các chủ đề thường nhật như chào hỏi, giới thiệu bản thân.',
    detailGoal: 'Hiểu và sử dụng các từ ngữ và mẫu câu giao tiếp đơn giản nhất, chuẩn bị nền tảng để tiếp tục học lên các cấp độ cao hơn.',
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
    vocabTarget: 300,
    description: 'Nắm vững 300 từ vựng (thêm 150 từ mới), có thể giao tiếp đơn giản và trực tiếp về các chủ đề quen thuộc hằng ngày.',
    detailGoal: 'Có thể sử dụng tiếng Trung giao tiếp cơ bản trong các tình huống sinh hoạt thường nhật, đạt chuẩn đầu ra sơ cấp.',
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
    title: 'HSK 3 – Sơ trung cấp',
    stage: 'Sơ trung cấp',
    vocabTarget: 600,
    description: 'Nắm vững 600 từ vựng, có thể hoàn thành các nhiệm vụ giao tiếp cơ bản trong cuộc sống, học tập và công việc hàng ngày.',
    detailGoal: 'Có thể dùng tiếng Trung giao tiếp ở mức cơ bản trong cuộc sống, học tập, công việc và hầu hết các tình huống khi đi du lịch tại Trung Quốc.',
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
  4: {
    level: 4,
    name: 'HSK 4',
    tag: 'HSK 4',
    title: 'HSK 4 – Trung cấp',
    stage: 'Trung cấp',
    vocabTarget: 1200,
    description: 'Nắm vững 1200 từ vựng, có thể đàm luận về các chủ đề thuộc phạm vi rộng hơn và giao lưu lưu loát với người bản xứ.',
    detailGoal: 'Có thể thảo luận về các chủ đề trong nhiều lĩnh vực bằng tiếng Trung và giao tiếp tương đối trôi chảy với người bản ngữ.',
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
    title: 'HSK 5 – Cao cấp',
    stage: 'Cao cấp',
    vocabTarget: 2500,
    description: 'Nắm vững 2500 từ vựng, có thể đọc báo chí tiếng Trung, thưởng thức phim ảnh và thuyết trình hoàn chỉnh bằng tiếng Trung.',
    detailGoal: 'Có thể đọc báo chí, tạp chí tiếng Trung, xem phim ảnh truyền hình tiếng Trung và có khả năng thuyết trình tương đối hoàn chỉnh bằng tiếng Trung.',
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
    title: 'HSK 6 – Cao cấp',
    stage: 'Cao cấp',
    vocabTarget: 5000,
    description: 'Nắm vững 5000 từ vựng trở lên, dễ dàng hiểu thông tin nghe - đọc và diễn đạt ý kiến một cách trôi chảy, tinh tế bằng văn viết hoặc văn nói.',
    detailGoal: 'Có thể dễ dàng hiểu thông tin nghe đọc bằng tiếng Trung, diễn đạt ý kiến của mình một cách lưu loát bằng cả văn nói lẫn văn viết.',
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
};
