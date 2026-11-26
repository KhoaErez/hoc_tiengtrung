// Dữ liệu Lộ trình Học từng bài (Course Roadmap & SuperChinese-style Lesson Player)
// Hỗ trợ 2 nhánh: HSK (HSK 1 - HSK 6) và Tiếng Trung Công Xưởng (3 Modules thực tế)

export type CourseTrack = 'hsk' | 'factory'

export interface CourseVocabItem {
  id: string
  hanzi: string
  pinyin: string
  meaningVi: string
  partOfSpeech: string // Danh từ, Động từ, Tính từ, Cụm từ, Thán từ...
  exampleHanzi: string
  examplePinyin: string
  exampleVi: string
}

export interface CourseDialogueLine {
  id: string
  speaker: 'A' | 'B'
  roleName: string
  hanzi: string
  pinyin: string
  meaningVi: string
}

export interface CourseDialogueData {
  title: string
  context: string
  lines: CourseDialogueLine[]
}

export interface MultipleChoiceQuizQuestion {
  id: string
  type: 'multiple_choice'
  promptVi: string
  promptSub?: string
  audioText?: string
  options: {
    id: string
    hanzi: string
    pinyin?: string
    labelVi?: string
  }[]
  correctOptionId: string
  explanationVi: string
}

export interface WordBankQuizQuestion {
  id: string
  type: 'word_bank'
  promptVi: string
  audioText?: string
  /** Các mảnh từ đúng theo thứ tự chuẩn để tạo câu đáp án */
  targetTokens: string[]
  /** Các mảnh từ gây nhiễu (tùy chọn) */
  distractorTokens?: string[]
  pinyinAnswer: string
  explanationVi: string
}

export interface TypingQuizQuestion {
  id: string
  type: 'typing'
  promptVi: string
  hintKeyword?: string
  expectedHanzi: string
  expectedPinyin: string
  explanationVi: string
}

export type CourseQuizQuestion =
  | MultipleChoiceQuizQuestion
  | WordBankQuizQuestion
  | TypingQuizQuestion

export interface CourseLesson {
  id: string
  track: CourseTrack
  hskLevel?: number // 1..6 khi thuộc track 'hsk'
  unitId: string
  lessonNumber: number
  title: string
  titleZh: string
  subtitle: string
  estimatedMinutes: number
  vocabs: CourseVocabItem[]
  writeWords?: CourseVocabItem[]
  dialogue: CourseDialogueData
  quizzes: CourseQuizQuestion[]
}

export interface CourseUnit {
  id: string
  track: CourseTrack
  hskLevel?: number
  unitNumber: number
  title: string
  titleZh: string
  description: string
  lessons: CourseLesson[]
}

export const COURSE_UNITS: CourseUnit[] = [
  // =========================================================================
  // TRACK 1: LỘ TRÌNH HSK (HSK 1 - HSK 6)
  // =========================================================================
  {
    id: 'hsk1-u1',
    track: 'hsk',
    hskLevel: 1,
    unitNumber: 1,
    title: 'Unit 1: Chào hỏi & Làm quen cơ bản',
    titleZh: '第一单元：打招呼与认识',
    description: 'Nắm vững cách chào hỏi tự nhiên, cảm ơn lịch sự và giới thiệu tên của bạn.',
    lessons: [
      {
        id: 'hsk1-u1-l1',
        track: 'hsk',
        hskLevel: 1,
        unitId: 'hsk1-u1',
        lessonNumber: 1,
        title: 'Chào hỏi & Giới thiệu tên',
        titleZh: '你好，我叫…',
        subtitle: '3 từ cốt lõi • Hội thoại làm quen • 3 bài tập tương tác',
        estimatedMinutes: 6,
        vocabs: [
          {
            id: 'hsk1-v-nihao',
            hanzi: '你好',
            pinyin: 'nǐ hǎo',
            meaningVi: 'Xin chào',
            partOfSpeech: 'Cụm chào hỏi',
            exampleHanzi: '你好，很高兴认识你！',
            examplePinyin: 'Nǐ hǎo, hěn gāoxìng rènshi nǐ!',
            exampleVi: 'Xin chào, rất vui được làm quen với bạn!',
          },
          {
            id: 'hsk1-v-jiao',
            hanzi: '叫',
            pinyin: 'jiào',
            meaningVi: 'Tên là / Gọi là',
            partOfSpeech: 'Động từ',
            exampleHanzi: '请问，你叫什么名字？',
            examplePinyin: 'Qǐngwèn, nǐ jiào shénme míngzi?',
            exampleVi: 'Xin hỏi, bạn tên là gì?',
          },
          {
            id: 'hsk1-v-xiexie',
            hanzi: '谢谢',
            pinyin: 'xièxie',
            meaningVi: 'Cảm ơn',
            partOfSpeech: 'Động từ',
            exampleHanzi: '谢谢你的帮助！',
            examplePinyin: 'Xièxie nǐ de bāngzhù!',
            exampleVi: 'Cảm ơn sự giúp đỡ của bạn!',
          },
        ],
        dialogue: {
          title: 'Buổi gặp đầu tiên ở lớp Hán ngữ',
          context: 'Tiểu Minh và Lan gặp nhau trước giờ học buổi sáng.',
          lines: [
            {
              id: 'hsk1-l1-d1',
              speaker: 'A',
              roleName: 'Tiểu Minh',
              hanzi: '你好！请问，你叫什么名字？',
              pinyin: 'Nǐ hǎo! Qǐngwèn, nǐ jiào shénme míngzi?',
              meaningVi: 'Xin chào! Xin hỏi bạn tên là gì vậy?',
            },
            {
              id: 'hsk1-l1-d2',
              speaker: 'B',
              roleName: 'Lan',
              hanzi: '你好！我叫小兰。你呢？',
              pinyin: 'Nǐ hǎo! Wǒ jiào Xiǎo Lán. Nǐ ne?',
              meaningVi: 'Chào bạn! Mình tên là Tiểu Lan. Còn bạn?',
            },
            {
              id: 'hsk1-l1-d3',
              speaker: 'A',
              roleName: 'Tiểu Minh',
              hanzi: '我叫小明，很高兴认识你。',
              pinyin: 'Wǒ jiào Xiǎo Míng, hěn gāoxìng rènshi nǐ.',
              meaningVi: 'Mình là Tiểu Minh, rất vui được làm quen với bạn.',
            },
            {
              id: 'hsk1-l1-d4',
              speaker: 'B',
              roleName: 'Lan',
              hanzi: '你的中文说得很好！',
              pinyin: 'Nǐ de Zhōngwén shuō de hěn hǎo!',
              meaningVi: 'Tiếng Trung của bạn nói tốt quá!',
            },
            {
              id: 'hsk1-l1-d5',
              speaker: 'A',
              roleName: 'Tiểu Minh',
              hanzi: '谢谢，我还在学习呢。',
              pinyin: 'Xièxie, wǒ hái zài xuéxí ne.',
              meaningVi: 'Cảm ơn nhé, mình vẫn đang học thêm thôi.',
            },
          ],
        },
        quizzes: [
          {
            id: 'hsk1-l1-q1',
            type: 'multiple_choice',
            promptVi: 'Nghe đoạn phát âm sau và chọn nghĩa tiếng Việt đúng nhất:',
            promptSub: 'Hãy bấm loa để nghe mẫu trước khi chọn',
            audioText: '我叫小明，很高兴认识你。',
            options: [
              { id: 'a', hanzi: '我叫小明', pinyin: 'Wǒ jiào Xiǎo Míng', labelVi: 'Mình tên là Tiểu Minh, rất vui được quen bạn' },
              { id: 'b', hanzi: '谢谢你', pinyin: 'Xièxie nǐ', labelVi: 'Cảm ơn bạn rất nhiều' },
              { id: 'c', hanzi: '再见', pinyin: 'Zàijiàn', labelVi: 'Tạm biệt, hẹn gặp lại' },
              { id: 'd', hanzi: '对不起', pinyin: 'Duìbuqǐ', labelVi: 'Xin lỗi bạn nhé' },
            ],
            correctOptionId: 'a',
            explanationVi: '"我叫小明，很高兴认识你" có nghĩa là "Mình tên là Tiểu Minh, rất vui được làm quen với bạn".',
          },
          {
            id: 'hsk1-l1-q2',
            type: 'word_bank',
            promptVi: 'Ghép các thẻ từ thành câu: "Xin hỏi, bạn tên là gì?"',
            audioText: '请问，你叫什么名字？',
            targetTokens: ['请问，', '你', '叫', '什么', '名字？'],
            distractorTokens: ['谢谢', '我'],
            pinyinAnswer: 'Qǐngwèn, nǐ jiào shénme míngzi?',
            explanationVi: 'Cấu trúc hỏi tên chuẩn: 请问 (Xin hỏi) + 你 (bạn) + 叫什么名字 (tên là gì)?',
          },
          {
            id: 'hsk1-l1-q3',
            type: 'typing',
            promptVi: 'Dùng bộ gõ tiếng Trung (Pinyin) gõ lại câu: "Xin chào, mình tên là Tiểu Minh."',
            hintKeyword: 'Nǐ hǎo, wǒ jiào Xiǎo Míng.',
            expectedHanzi: '你好，我叫小明。',
            expectedPinyin: 'Nǐ hǎo, wǒ jiào Xiǎo Míng.',
            explanationVi: 'Gõ pinyin "nihao" chọn 你好, sau đó gõ "wojiao" + "xiaoming" để hoàn thành câu.',
          },
        ],
      },
      {
        id: 'hsk1-u1-l2',
        track: 'hsk',
        hskLevel: 1,
        unitId: 'hsk1-u1',
        lessonNumber: 2,
        title: 'Quốc tịch & Công việc',
        titleZh: '你是哪国人？',
        subtitle: '3 từ vựng • Hội thoại thực tế • 3 bài tập tương tác',
        estimatedMinutes: 7,
        vocabs: [
          {
            id: 'hsk1-v-yuenan',
            hanzi: '越南',
            pinyin: 'Yuènán',
            meaningVi: 'Việt Nam',
            partOfSpeech: 'Danh từ riêng',
            exampleHanzi: '我是越南人。',
            examplePinyin: 'Wǒ shì Yuènán rén.',
            exampleVi: 'Tôi là người Việt Nam.',
          },
          {
            id: 'hsk1-v-zhongguo',
            hanzi: '中国',
            pinyin: 'Zhōngguó',
            meaningVi: 'Trung Quốc',
            partOfSpeech: 'Danh từ riêng',
            exampleHanzi: '他现在在中国工作。',
            examplePinyin: 'Tā xiànzài zài Zhōngguó gōngzuò.',
            exampleVi: 'Anh ấy hiện đang làm việc tại Trung Quốc.',
          },
          {
            id: 'hsk1-v-gongzuo',
            hanzi: '工作',
            pinyin: 'gōngzuò',
            meaningVi: 'Làm việc / Công việc',
            partOfSpeech: 'Động từ / Danh từ',
            exampleHanzi: '你的工作忙不忙？',
            examplePinyin: 'Nǐ de gōngzuò máng bu máng?',
            exampleVi: 'Công việc của bạn có bận không?',
          },
        ],
        dialogue: {
          title: 'Trao đổi về quê quán và công việc',
          context: 'Hai đồng nghiệp mới trò chuyện trong giờ nghỉ trưa.',
          lines: [
            {
              id: 'hsk1-l2-d1',
              speaker: 'A',
              roleName: 'A Lý',
              hanzi: '你是哪国人？',
              pinyin: 'Nǐ shì nǎ guó rén?',
              meaningVi: 'Bạn là người nước nào vậy?',
            },
            {
              id: 'hsk1-l2-d2',
              speaker: 'B',
              roleName: 'Minh Anh',
              hanzi: '我是越南人。我在河内工作。',
              pinyin: 'Wǒ shì Yuènán rén. Wǒ zài Hénèi gōngzuò.',
              meaningVi: 'Tôi là người Việt Nam. Tôi làm việc ở Hà Nội.',
            },
            {
              id: 'hsk1-l2-d3',
              speaker: 'A',
              roleName: 'A Lý',
              hanzi: '真的吗？我有很多越南朋友。',
              pinyin: 'Zhēn de ma? Wǒ yǒu hěn duō Yuènán péngyou.',
              meaningVi: 'Thật sao? Tôi có rất nhiều bạn Việt Nam đấy.',
            },
            {
              id: 'hsk1-l2-d4',
              speaker: 'B',
              roleName: 'Minh Anh',
              hanzi: '太好了！以后请多多关照。',
              pinyin: 'Tài hǎo le! Yǐhòu qǐng duōduō guānzhào.',
              meaningVi: 'Tuyệt quá! Sau này mong được bạn giúp đỡ nhiều nhé.',
            },
          ],
        },
        quizzes: [
          {
            id: 'hsk1-l2-q1',
            type: 'multiple_choice',
            promptVi: 'Từ nào sau đây có nghĩa là "Làm việc / Công việc"?',
            audioText: '工作',
            options: [
              { id: 'a', hanzi: '越南', pinyin: 'Yuènán', labelVi: 'Việt Nam' },
              { id: 'b', hanzi: '工作', pinyin: 'gōngzuò', labelVi: 'Làm việc / Công việc' },
              { id: 'c', hanzi: '中国', pinyin: 'Zhōngguó', labelVi: 'Trung Quốc' },
              { id: 'd', hanzi: '名字', pinyin: 'míngzi', labelVi: 'Tên' },
            ],
            correctOptionId: 'b',
            explanationVi: '工作 (gōngzuò) vừa là động từ "làm việc", vừa là danh từ "công việc".',
          },
          {
            id: 'hsk1-l2-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Tôi là người Việt Nam."',
            audioText: '我是越南人。',
            targetTokens: ['我', '是', '越南', '人。'],
            distractorTokens: ['工作', '中国'],
            pinyinAnswer: 'Wǒ shì Yuènán rén.',
            explanationVi: 'Mẫu câu giới thiệu quốc tịch: Chủ ngữ + 是 + Tên nước + 人.',
          },
          {
            id: 'hsk1-l2-q3',
            type: 'typing',
            promptVi: 'Gõ câu tiếng Trung: "Bạn là người nước nào?"',
            hintKeyword: 'Nǐ shì nǎ guó rén?',
            expectedHanzi: '你是哪国人？',
            expectedPinyin: 'Nǐ shì nǎ guó rén?',
            explanationVi: '哪 (nǎ) dùng để hỏi "nào": 你是哪国人？',
          },
        ],
      },
    ],
  },
  {
    id: 'hsk1-u2',
    track: 'hsk',
    hskLevel: 1,
    unitNumber: 2,
    title: 'Unit 2: Gia đình & Sinh hoạt hằng ngày',
    titleZh: '第二单元：家庭与日常',
    description: 'Cách nói về thành viên gia đình, thời gian và lịch sinh hoạt.',
    lessons: [
      {
        id: 'hsk1-u2-l1',
        track: 'hsk',
        hskLevel: 1,
        unitId: 'hsk1-u2',
        lessonNumber: 3,
        title: 'Gia đình nhỏ của tôi',
        titleZh: '我家有三口人',
        subtitle: '3 từ vựng • Hội thoại gia đình • 3 bài tập tương tác',
        estimatedMinutes: 6,
        vocabs: [
          {
            id: 'hsk1-v-jia',
            hanzi: '家',
            pinyin: 'jiā',
            meaningVi: 'Nhà / Gia đình',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '我家有四口人。',
            examplePinyin: 'Wǒ jiā yǒu sì kǒu rén.',
            exampleVi: 'Nhà tôi có bốn người.',
          },
          {
            id: 'hsk1-v-baba',
            hanzi: '爸爸',
            pinyin: 'bàba',
            meaningVi: 'Bố / Ba',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '我爸爸是工程师。',
            examplePinyin: 'Wǒ bàba shì gōngchéngshī.',
            exampleVi: 'Bố tôi là kỹ sư.',
          },
          {
            id: 'hsk1-v-mama',
            hanzi: '妈妈',
            pinyin: 'māma',
            meaningVi: 'Mẹ / Má',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '妈妈每天做晚饭。',
            examplePinyin: 'Māma měitiān zuò wǎnfàn.',
            exampleVi: 'Mẹ nấu bữa tối mỗi ngày.',
          },
        ],
        dialogue: {
          title: 'Kể về gia đình',
          context: 'Hai người bạn xem ảnh gia đình cùng nhau.',
          lines: [
            {
              id: 'hsk1-u2-d1',
              speaker: 'A',
              roleName: 'Tiểu Hoa',
              hanzi: '你家有几口人？',
              pinyin: 'Nǐ jiā yǒu jǐ kǒu rén?',
              meaningVi: 'Nhà bạn có mấy người vậy?',
            },
            {
              id: 'hsk1-u2-d2',
              speaker: 'B',
              roleName: 'Quốc Anh',
              hanzi: '我家有三口人：爸爸、妈妈和我。',
              pinyin: 'Wǒ jiā yǒu sān kǒu rén: bàba, māma hé wǒ.',
              meaningVi: 'Nhà mình có 3 người: bố, mẹ và mình.',
            },
            {
              id: 'hsk1-u2-d3',
              speaker: 'A',
              roleName: 'Tiểu Hoa',
              hanzi: '你爸爸妈妈都在工作吗？',
              pinyin: 'Nǐ bàba māma dōu zài gōngzuò ma?',
              meaningVi: 'Bố mẹ bạn đều đang đi làm chứ?',
            },
            {
              id: 'hsk1-u2-d4',
              speaker: 'B',
              roleName: 'Quốc Anh',
              hanzi: '是的，他们每天都很忙。',
              pinyin: 'Shì de, tāmen měitiān dōu hěn máng.',
              meaningVi: 'Đúng vậy, ngày nào bố mẹ cũng rất bận.',
            },
          ],
        },
        quizzes: [
          {
            id: 'hsk1-u2-q1',
            type: 'multiple_choice',
            promptVi: 'Lượng từ nào thường dùng để đếm số người trong gia đình?',
            audioText: '口',
            options: [
              { id: 'a', hanzi: '本', pinyin: 'běn', labelVi: 'Quyển (sách)' },
              { id: 'b', hanzi: '口', pinyin: 'kǒu', labelVi: 'Nhân khẩu / người trong nhà' },
              { id: 'c', hanzi: '杯', pinyin: 'bēi', labelVi: 'Cốc, ly' },
              { id: 'd', hanzi: '张', pinyin: 'zhāng', labelVi: 'Tờ, tấm' },
            ],
            correctOptionId: 'b',
            explanationVi: 'Khi đếm số thành viên trong gia đình, người Trung dùng lượng từ 口 (kǒu): 三口人.',
          },
          {
            id: 'hsk1-u2-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Nhà tôi có bốn người."',
            audioText: '我家有四口人。',
            targetTokens: ['我家', '有', '四', '口', '人。'],
            distractorTokens: ['几', '个'],
            pinyinAnswer: 'Wǒ jiā yǒu sì kǒu rén.',
            explanationVi: '我家 (nhà tôi) + 有 (có) + 四口人 (4 người).',
          },
          {
            id: 'hsk1-u2-q3',
            type: 'typing',
            promptVi: 'Gõ câu hỏi: "Nhà bạn có mấy người?"',
            hintKeyword: 'Nǐ jiā yǒu jǐ kǒu rén?',
            expectedHanzi: '你家有几口人？',
            expectedPinyin: 'Nǐ jiā yǒu jǐ kǒu rén?',
            explanationVi: 'Dùng 几 (jǐ) để hỏi số lượng nhỏ dưới 10: 你家有几口人？',
          },
        ],
      },
    ],
  },
  // HSK 2 - HSK 6 Starter Units
  {
    id: 'hsk2-u1',
    track: 'hsk',
    hskLevel: 2,
    unitNumber: 1,
    title: 'Unit 1: Giao tiếp mua sắm & Đặt lịch',
    titleZh: '第一单元：购物与安排',
    description: 'Mặc cả lịch sự, hỏi giờ giấc và sắp xếp lịch hẹn cùng bạn bè.',
    lessons: [
      {
        id: 'hsk2-u1-l1',
        track: 'hsk',
        hskLevel: 2,
        unitId: 'hsk2-u1',
        lessonNumber: 1,
        title: 'Hỏi giá & Giảm giá',
        titleZh: '能不能便宜一点？',
        subtitle: '3 từ vựng HSK 2 • Hội thoại mua sắm • 3 bài tập tương tác',
        estimatedMinutes: 7,
        vocabs: [
          {
            id: 'hsk2-v-pianyi',
            hanzi: '便宜',
            pinyin: 'piányi',
            meaningVi: 'Rẻ',
            partOfSpeech: 'Tính từ',
            exampleHanzi: '这件衣服很便宜。',
            examplePinyin: 'Zhè jiàn yīfu hěn piányi.',
            exampleVi: 'Bộ quần áo này rất rẻ.',
          },
          {
            id: 'hsk2-v-yidianr',
            hanzi: '一点儿',
            pinyin: 'yìdiǎnr',
            meaningVi: 'Một chút',
            partOfSpeech: 'Số lượng từ',
            exampleHanzi: '可以便宜一点儿吗？',
            examplePinyin: 'Kěyǐ piányi yìdiǎnr ma?',
            exampleVi: 'Có thể rẻ hơn một chút được không?',
          },
          {
            id: 'hsk2-v-zhunbei',
            hanzi: '准备',
            pinyin: 'zhǔnbèi',
            meaningVi: 'Chuẩn bị / Dự định',
            partOfSpeech: 'Động từ',
            exampleHanzi: '我准备买这双鞋。',
            examplePinyin: 'Wǒ zhǔnbèi mǎi zhè shuāng xié.',
            exampleVi: 'Tôi định mua đôi giày này.',
          },
        ],
        dialogue: {
          title: 'Mua đồ ở cửa hàng',
          context: 'Khách hỏi giá và xin giảm giá nhẹ với nhân viên.',
          lines: [
            {
              id: 'hsk2-l1-d1',
              speaker: 'A',
              roleName: 'Khách hàng',
              hanzi: '请问，这件衣服多少钱？',
              pinyin: 'Qǐngwèn, zhè jiàn yīfu duōshao qián?',
              meaningVi: 'Xin hỏi chiếc áo này bao nhiêu tiền?',
            },
            {
              id: 'hsk2-l1-d2',
              speaker: 'B',
              roleName: 'Nhân viên',
              hanzi: '两百块，这是新款。',
              pinyin: 'Liǎng bǎi kuài, zhè shì xīn kuǎn.',
              meaningVi: '200 tệ ạ, đây là mẫu mới nhất đấy.',
            },
            {
              id: 'hsk2-l1-d3',
              speaker: 'A',
              roleName: 'Khách hàng',
              hanzi: '有点儿贵，能便宜一点儿吗？',
              pinyin: 'Yǒudiǎnr guì, néng piányi yìdiǎnr ma?',
              meaningVi: 'Hơi đắt một chút, bớt chút được không ạ?',
            },
            {
              id: 'hsk2-l1-d4',
              speaker: 'B',
              roleName: 'Nhân viên',
              hanzi: '好吧，算您一百八十块。',
              pinyin: 'Hǎo ba, suàn nín yìbǎi bāshí kuài.',
              meaningVi: 'Được rồi, tính anh chị 180 tệ nhé.',
            },
          ],
        },
        quizzes: [
          {
            id: 'hsk2-l1-q1',
            type: 'multiple_choice',
            promptVi: 'Chọn từ trái nghĩa với "贵 (guì - đắt)":',
            audioText: '便宜',
            options: [
              { id: 'a', hanzi: '便宜', pinyin: 'piányi', labelVi: 'Rẻ' },
              { id: 'b', hanzi: '准备', pinyin: 'zhǔnbèi', labelVi: 'Chuẩn bị' },
              { id: 'c', hanzi: '高兴', pinyin: 'gāoxìng', labelVi: 'Vui vẻ' },
              { id: 'd', hanzi: '忙', pinyin: 'máng', labelVi: 'Bận rộn' },
            ],
            correctOptionId: 'a',
            explanationVi: '便宜 (piányi - rẻ) là từ trái nghĩa trực tiếp của 贵 (guì - đắt).',
          },
          {
            id: 'hsk2-l1-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Có thể rẻ hơn một chút được không?"',
            targetTokens: ['可以', '便宜', '一点儿', '吗？'],
            distractorTokens: ['太贵', '非常'],
            pinyinAnswer: 'Kěyǐ piányi yìdiǎnr ma?',
            explanationVi: 'Tính từ + 一点儿 diễn tả mức độ nhẹ: 便宜一点儿 (rẻ hơn một chút).',
          },
          {
            id: 'hsk2-l1-q3',
            type: 'typing',
            promptVi: 'Gõ câu tiếng Trung: "Bộ quần áo này rất rẻ."',
            hintKeyword: 'Zhè jiàn yīfu hěn piányi.',
            expectedHanzi: '这件衣服很便宜。',
            expectedPinyin: 'Zhè jiàn yīfu hěn piányi.',
            explanationVi: 'Lượng từ của áo (衣服) là 件 (jiàn): 这件衣服很便宜。',
          },
        ],
      },
    ],
  },
  {
    id: 'hsk3-u1',
    track: 'hsk',
    hskLevel: 3,
    unitNumber: 1,
    title: 'Unit 1: Kế hoạch cuối tuần & Thói quen',
    titleZh: '第一单元：周末计划',
    description: 'Diễn đạt dự định, so sánh lựa chọn và giải thích nguyên nhân rõ ràng.',
    lessons: [
      {
        id: 'hsk3-u1-l1',
        track: 'hsk',
        hskLevel: 3,
        unitId: 'hsk3-u1',
        lessonNumber: 1,
        title: 'Lên kế hoạch du lịch',
        titleZh: '我们打算去旅游',
        subtitle: '3 từ vựng HSK 3 • Hội thoại bạn bè • 3 bài tập',
        estimatedMinutes: 8,
        vocabs: [
          {
            id: 'hsk3-v-dasuan',
            hanzi: '打算',
            pinyin: 'dǎsuàn',
            meaningVi: 'Dự định / Kế hoạch',
            partOfSpeech: 'Động từ / Danh từ',
            exampleHanzi: '这个周末你打算做什么？',
            examplePinyin: 'Zhège zhōumò nǐ dǎsuàn zuò shénme?',
            exampleVi: 'Cuối tuần này bạn dự định làm gì?',
          },
          {
            id: 'hsk3-v-jueding',
            hanzi: '决定',
            pinyin: 'juédìng',
            meaningVi: 'Quyết định',
            partOfSpeech: 'Động từ',
            exampleHanzi: '我们决定坐高铁去上海。',
            examplePinyin: 'Wǒmen juédìng zuò gāotiě qù Shànghǎi.',
            exampleVi: 'Chúng tôi quyết định đi tàu cao tốc tới Thượng Hải.',
          },
          {
            id: 'hsk3-v-huanjing',
            hanzi: '环境',
            pinyin: 'huánjìng',
            meaningVi: 'Môi trường / Cảnh quan',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '那里的环境非常安静。',
            examplePinyin: 'Nàlǐ de huánjìng fēicháng ānjìng.',
            exampleVi: 'Không gian/môi trường ở đó vô cùng yên tĩnh.',
          },
        ],
        dialogue: {
          title: 'Bàn kế hoạch cuối tuần',
          context: 'Hai bạn cùng phòng bàn nhau đi chơi cuối tuần.',
          lines: [
            {
              id: 'hsk3-l1-d1',
              speaker: 'A',
              roleName: 'A Nam',
              hanzi: '这个周末你有什么打算？',
              pinyin: 'Zhège zhōumò nǐ yǒu shénme dǎsuàn?',
              meaningVi: 'Cuối tuần này bạn có dự định gì chưa?',
            },
            {
              id: 'hsk3-l1-d2',
              speaker: 'B',
              roleName: 'Tiểu Vy',
              hanzi: '我还没决定呢，你想去哪儿？',
              pinyin: 'Wǒ hái méi juédìng ne, nǐ xiǎng qù nǎr?',
              meaningVi: 'Mình vẫn chưa quyết định nữa, bạn muốn đi đâu?',
            },
            {
              id: 'hsk3-l1-d3',
              speaker: 'A',
              roleName: 'A Nam',
              hanzi: '听说西湖那边环境特别好。',
              pinyin: 'Tīngshuō Xīhú nàbiān huánjìng tèbié hǎo.',
              meaningVi: 'Nghe nói cảnh quan bên Tây Hồ đẹp lắm.',
            },
            {
              id: 'hsk3-l1-d4',
              speaker: 'B',
              roleName: 'Tiểu Vy',
              hanzi: '那我们就决定星期六去吧！',
              pinyin: 'Nà wǒmen jiù juédìng xīngqīliù qù ba!',
              meaningVi: 'Vậy tụi mình chốt thứ Bảy đi luôn nhé!',
            },
          ],
        },
        quizzes: [
          {
            id: 'hsk3-l1-q1',
            type: 'multiple_choice',
            promptVi: 'Câu "我还没决定呢" có nghĩa là gì?',
            audioText: '我还没决定呢。',
            options: [
              { id: 'a', hanzi: '我还没决定呢', labelVi: 'Tôi vẫn chưa quyết định nữa' },
              { id: 'b', hanzi: '我已经准备好了', labelVi: 'Tôi đã chuẩn bị xong rồi' },
              { id: 'c', hanzi: '我不想去那里', labelVi: 'Tôi không muốn đến đó' },
              { id: 'd', hanzi: '这里环境不错', labelVi: 'Môi trường ở đây khá tốt' },
            ],
            correctOptionId: 'a',
            explanationVi: '还没…呢 (hái méi…ne) nghĩa là "vẫn chưa…", kết hợp 决定 (quyết định).',
          },
          {
            id: 'hsk3-l1-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Cuối tuần này bạn dự định làm gì?"',
            targetTokens: ['这个', '周末', '你', '打算', '做什么？'],
            distractorTokens: ['决定', '因为'],
            pinyinAnswer: 'Zhège zhōumò nǐ dǎsuàn zuò shénme?',
            explanationVi: 'Trạng ngữ thời gian 这个周末 đứng đầu hoặc ngay sau chủ ngữ.',
          },
          {
            id: 'hsk3-l1-q3',
            type: 'typing',
            promptVi: 'Gõ câu: "Môi trường ở đó rất yên tĩnh."',
            hintKeyword: 'Nàlǐ de huánjìng hěn ānjìng.',
            expectedHanzi: '那里的环境很安静。',
            expectedPinyin: 'Nàlǐ de huánjìng hěn ānjìng.',
            explanationVi: '环境 (huánjìng - môi trường) + 很安静 (rất yên tĩnh).',
          },
        ],
      },
    ],
  },
  {
    id: 'hsk4-u1',
    track: 'hsk',
    hskLevel: 4,
    unitNumber: 1,
    title: 'Unit 1: Giao tiếp công sở & Phỏng vấn',
    titleZh: '第一单元：职场交流',
    description: 'Diễn đạt kinh nghiệm làm việc, trách nhiệm và giao tiếp chuyên nghiệp.',
    lessons: [
      {
        id: 'hsk4-u1-l1',
        track: 'hsk',
        hskLevel: 4,
        unitId: 'hsk4-u1',
        lessonNumber: 1,
        title: 'Kinh nghiệm & Trách nhiệm',
        titleZh: '工作经验与责任',
        subtitle: '3 từ vựng HSK 4 • Hội thoại tuyển dụng • 3 bài tập',
        estimatedMinutes: 8,
        vocabs: [
          {
            id: 'hsk4-v-jingyan',
            hanzi: '经验',
            pinyin: 'jīngyàn',
            meaningVi: 'Kinh nghiệm',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '他有五年的项目管理经验。',
            examplePinyin: 'Tā yǒu wǔ nián de xiàngmù guǎnlǐ jīngyàn.',
            exampleVi: 'Anh ấy có 5 năm kinh nghiệm quản lý dự án.',
          },
          {
            id: 'hsk4-v-fuze',
            hanzi: '负责',
            pinyin: 'fùzé',
            meaningVi: 'Phụ trách / Chịu trách nhiệm',
            partOfSpeech: 'Động từ',
            exampleHanzi: '我主要负责客户沟通工作。',
            examplePinyin: 'Wǒ zhǔyào fùzé kèhù gōutōng gōngzuò.',
            exampleVi: 'Tôi chủ yếu phụ trách việc trao đổi với khách hàng.',
          },
          {
            id: 'hsk4-v-jiejue',
            hanzi: '解决',
            pinyin: 'jiějué',
            meaningVi: 'Giải quyết / Xử lý',
            partOfSpeech: 'Động từ',
            exampleHanzi: '我们必须尽快解决这个问题。',
            examplePinyin: 'Wǒmen bìxū jǐnkuài jiějué zhège wèntí.',
            exampleVi: 'Chúng ta phải nhanh chóng giải quyết vấn đề này.',
          },
        ],
        dialogue: {
          title: 'Trao đổi trong buổi phỏng vấn',
          context: 'Ứng viên trình bày vai trò ở công ty cũ với nhà tuyển dụng.',
          lines: [
            {
              id: 'hsk4-l1-d1',
              speaker: 'A',
              roleName: 'Nhà tuyển dụng',
              hanzi: '你在上一家公司主要负责什么？',
              pinyin: 'Nǐ zài shàng yì jiā gōngsī zhǔyào fùzé shénme?',
              meaningVi: 'Ở công ty trước bạn chủ yếu phụ trách công việc gì?',
            },
            {
              id: 'hsk4-l1-d2',
              speaker: 'B',
              roleName: 'Ứng viên',
              hanzi: '我负责跟进订单，并解决客户问题。',
              pinyin: 'Wǒ fùzé gēnjìn dìngdān, bìng jiějué kèhù wèntí.',
              meaningVi: 'Tôi phụ trách theo dõi đơn hàng và xử lý các vấn đề của khách.',
            },
            {
              id: 'hsk4-l1-d3',
              speaker: 'A',
              roleName: 'Nhà tuyển dụng',
              hanzi: '你的经验很符合我们的要求。',
              pinyin: 'Nǐ de jīngyàn hěn fúhé wǒmen de yāoqiú.',
              meaningVi: 'Kinh nghiệm của bạn rất phù hợp với yêu cầu của chúng tôi.',
            },
            {
              id: 'hsk4-l1-d4',
              speaker: 'B',
              roleName: 'Ứng viên',
              hanzi: '谢谢，我希望能为团队贡献力量。',
              pinyin: 'Xièxie, wǒ xīwàng néng wèi tuánduì gòngxiàn lìliàng.',
              meaningVi: 'Cảm ơn anh, tôi hy vọng có thể đóng góp sức mình cho đội ngũ.',
            },
          ],
        },
        quizzes: [
          {
            id: 'hsk4-l1-q1',
            type: 'multiple_choice',
            promptVi: 'Động từ nào đi với "问题 (vấn đề)" để mang nghĩa "giải quyết vấn đề"?',
            options: [
              { id: 'a', hanzi: '解决', pinyin: 'jiějué', labelVi: 'Giải quyết' },
              { id: 'b', hanzi: '经验', pinyin: 'jīngyàn', labelVi: 'Kinh nghiệm' },
              { id: 'c', hanzi: '环境', pinyin: 'huánjìng', labelVi: 'Môi trường' },
              { id: 'd', hanzi: '打算', pinyin: 'dǎsuàn', labelVi: 'Dự định' },
            ],
            correctOptionId: 'a',
            explanationVi: 'Cụm cố định trong tiếng Trung: 解决问题 (jiějué wèntí - giải quyết vấn đề).',
          },
          {
            id: 'hsk4-l1-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Tôi phụ trách theo dõi đơn hàng."',
            targetTokens: ['我', '主要', '负责', '跟进', '订单。'],
            distractorTokens: ['经验', '便宜'],
            pinyinAnswer: 'Wǒ zhǔyào fùzé gēnjìn dìngdān.',
            explanationVi: '负责 (fùzé) đi trực tiếp với cụm động từ phía sau để chỉ nhiệm vụ đảm nhận.',
          },
          {
            id: 'hsk4-l1-q3',
            type: 'typing',
            promptVi: 'Gõ câu: "Chúng ta phải nhanh chóng giải quyết vấn đề này."',
            hintKeyword: 'Wǒmen bìxū jǐnkuài jiějué zhège wèntí.',
            expectedHanzi: '我们必须尽快解决这个问题。',
            expectedPinyin: 'Wǒmen bìxū jǐnkuài jiějué zhège wèntí.',
            explanationVi: '必须 (bìxū - phải) + 尽快 (jǐnkuài - sớm nhất có thể) + 解决这个问题.',
          },
        ],
      },
    ],
  },
  {
    id: 'hsk5-u1',
    track: 'hsk',
    hskLevel: 5,
    unitNumber: 1,
    title: 'Unit 1: Phân tích & Đề xuất giải pháp',
    titleZh: '第一单元：分析与建议',
    description: 'Diễn đạt lập luận sắc bén, nâng cao hiệu suất và báo cáo tổng hợp.',
    lessons: [
      {
        id: 'hsk5-u1-l1',
        track: 'hsk',
        hskLevel: 5,
        unitId: 'hsk5-u1',
        lessonNumber: 1,
        title: 'Nâng cao hiệu suất làm việc',
        titleZh: '提高工作效率',
        subtitle: '3 từ vựng HSK 5 • Thảo luận nhóm • 3 bài tập',
        estimatedMinutes: 9,
        vocabs: [
          {
            id: 'hsk5-v-xiaolv',
            hanzi: '效率',
            pinyin: 'xiàolǜ',
            meaningVi: 'Hiệu suất / Hiệu quả',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '我们需要提高整体工作效率。',
            examplePinyin: 'Wǒmen xūyào tígāo zhěngtǐ gōngzuò xiàolǜ.',
            exampleVi: 'Chúng ta cần nâng cao hiệu suất công việc tổng thể.',
          },
          {
            id: 'hsk5-v-fangan',
            hanzi: '方案',
            pinyin: 'fāng’àn',
            meaningVi: 'Phương án / Giải pháp',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '请把修改后的方案发给我。',
            examplePinyin: 'Qǐng bǎ xiūgǎi hòu de fāng’àn fā gěi wǒ.',
            exampleVi: 'Vui lòng gửi cho tôi phương án sau khi đã chỉnh sửa.',
          },
          {
            id: 'hsk5-v-luoshi',
            hanzi: '落实',
            pinyin: 'luòshí',
            meaningVi: 'Triển khai thực tế / Thực thi',
            partOfSpeech: 'Động từ',
            exampleHanzi: '这项措施必须严格落实到位。',
            examplePinyin: 'Zhè xiàng cuòshī bìxū yángé luòshí dàowèi.',
            exampleVi: 'Biện pháp này phải được triển khai nghiêm túc đến nơi đến chốn.',
          },
        ],
        dialogue: {
          title: 'Họp cải tiến quy trình',
          context: 'Trưởng nhóm thảo luận phương án tối ưu quy trình mới.',
          lines: [
            {
              id: 'hsk5-l1-d1',
              speaker: 'A',
              roleName: 'Trưởng phòng',
              hanzi: '关于提升效率的方案，大家怎么看？',
              pinyin: 'Guānyú tíshēng xiàolǜ de fāng’àn, dàjiā zěnme kàn?',
              meaningVi: 'Về phương án nâng cao hiệu suất, mọi người thấy thế nào?',
            },
            {
              id: 'hsk5-l1-d2',
              speaker: 'B',
              roleName: 'Chuyên viên',
              hanzi: '我认为关键在于把每个步骤落实好。',
              pinyin: 'Wǒ rènwéi guānjiàn zàiyú bǎ měi gè bùzhòu luòshí hǎo.',
              meaningVi: 'Tôi cho rằng mấu chốt nằm ở việc thực thi tốt từng bước.',
            },
            {
              id: 'hsk5-l1-d3',
              speaker: 'A',
              roleName: 'Trưởng phòng',
              hanzi: '说得对，我们下周就开始试行。',
              pinyin: 'Shuō de duì, wǒmen xià zhōu jiù kāishǐ shìxíng.',
              meaningVi: 'Nói đúng lắm, tuần sau chúng ta bắt đầu chạy thử nhé.',
            },
            {
              id: 'hsk5-l1-d4',
              speaker: 'B',
              roleName: 'Chuyên viên',
              hanzi: '好的，我会整理好详细日程。',
              pinyin: 'Hǎo de, wǒ huì zhěnglǐ hǎo xiángxì rìchéng.',
              meaningVi: 'Vâng, tôi sẽ tổng hợp lịch trình chi tiết ngay.',
            },
          ],
        },
        quizzes: [
          {
            id: 'hsk5-l1-q1',
            type: 'multiple_choice',
            promptVi: 'Từ nào biểu thị hành động "đưa kế hoạch vào thực thi thực tế"?',
            options: [
              { id: 'a', hanzi: '落实', pinyin: 'luòshí', labelVi: 'Thực thi / Triển khai' },
              { id: 'b', hanzi: '方案', pinyin: 'fāng’àn', labelVi: 'Phương án' },
              { id: 'c', hanzi: '效率', pinyin: 'xiàolǜ', labelVi: 'Hiệu suất' },
              { id: 'd', hanzi: '负责', pinyin: 'fùzé', labelVi: 'Phụ trách' },
            ],
            correctOptionId: 'a',
            explanationVi: '落实 (luòshí) nhấn mạnh việc hiện thực hóa kế hoạch/biện pháp thành kết quả cụ thể.',
          },
          {
            id: 'hsk5-l1-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Chúng ta cần nâng cao hiệu suất công việc."',
            targetTokens: ['我们', '需要', '提高', '工作', '效率。'],
            distractorTokens: ['便宜', '落实'],
            pinyinAnswer: 'Wǒmen xūyào tígāo gōngzuò xiàolǜ.',
            explanationVi: '提高效率 là cặp từ kết hợp chuẩn mực trong văn phong công sở HSK 5.',
          },
          {
            id: 'hsk5-l1-q3',
            type: 'typing',
            promptVi: 'Gõ câu: "Phương án này rất khả thi."',
            hintKeyword: 'Zhège fāng’àn hěn kěxíng.',
            expectedHanzi: '这个方案很可行。',
            expectedPinyin: 'Zhège fāng’àn hěn kěxíng.',
            explanationVi: '方案 (fāng’àn - phương án), 可行 (kěxíng - khả thi).',
          },
        ],
      },
    ],
  },
  {
    id: 'hsk6-u1',
    track: 'hsk',
    hskLevel: 6,
    unitNumber: 1,
    title: 'Unit 1: Văn phong học thuật & Kinh tế',
    titleZh: '第一单元：社会与经济洞察',
    description: 'Làm chủ từ vựng HSK 6 để đọc hiểu tin tức, báo cáo chiến lược và thuyết trình.',
    lessons: [
      {
        id: 'hsk6-u1-l1',
        track: 'hsk',
        hskLevel: 6,
        unitId: 'hsk6-u1',
        lessonNumber: 1,
        title: 'Chuyển đổi số & Sáng tạo',
        titleZh: '数字化转型与创新',
        subtitle: '3 từ vựng HSK 6 • Trao đổi chuyên sâu • 3 bài tập',
        estimatedMinutes: 10,
        vocabs: [
          {
            id: 'hsk6-v-zhuanxing',
            hanzi: '转型',
            pinyin: 'zhuǎnxíng',
            meaningVi: 'Chuyển đổi mô hình',
            partOfSpeech: 'Động từ',
            exampleHanzi: '传统制造业正在加速转型。',
            examplePinyin: 'Chuántǒng zhìzàoyè zhèngzài jiāsù zhuǎnxíng.',
            exampleVi: 'Ngành sản xuất truyền thống đang đẩy nhanh quá trình chuyển đổi.',
          },
          {
            id: 'hsk6-v-youhua',
            hanzi: '优化',
            pinyin: 'yōuhuà',
            meaningVi: 'Tối ưu hóa',
            partOfSpeech: 'Động từ',
            exampleHanzi: '通过优化流程，成本降低了不少。',
            examplePinyin: 'Tōngguò yōuhuà liúchéng, chéngběn jiàngdī le bùshǎo.',
            exampleVi: 'Nhờ tối ưu hóa quy trình, chi phí đã giảm đi đáng kể.',
          },
          {
            id: 'hsk6-v-qianli',
            hanzi: '潜力',
            pinyin: 'qiánlì',
            meaningVi: 'Tiềm năng',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '这个新兴市场具有巨大的发展潜力。',
            examplePinyin: 'Zhège xīnxīng shìchǎng jùyǒu jùdà de fāzhǎn qiánlì.',
            exampleVi: 'Thị trường mới nổi này sở hữu tiềm năng phát triển to lớn.',
          },
        ],
        dialogue: {
          title: 'Bàn chiến lược phát triển',
          context: 'Hai chuyên gia trao đổi về tối ưu chuỗi cung ứng.',
          lines: [
            {
              id: 'hsk6-l1-d1',
              speaker: 'A',
              roleName: 'Giám đốc chiến lược',
              hanzi: '面对市场变化，企业该如何转型？',
              pinyin: 'Miànduì shìchǎng biànhuà, qǐyè gāi rúhé zhuǎnxíng?',
              meaningVi: 'Trước biến động thị trường, doanh nghiệp nên chuyển đổi thế nào?',
            },
            {
              id: 'hsk6-l1-d2',
              speaker: 'B',
              roleName: 'Cố vấn',
              hanzi: '首先要优化内部管理与供应链结构。',
              pinyin: 'Shǒuxiān yào yōuhuà nèibù guǎnlǐ yǔ gōngyìngliàn jiégòu.',
              meaningVi: 'Trước tiên cần tối ưu quản trị nội bộ và cấu trúc chuỗi cung ứng.',
            },
            {
              id: 'hsk6-l1-d3',
              speaker: 'A',
              roleName: 'Giám đốc chiến lược',
              hanzi: '确实，东南亚市场的潜力也不容忽视。',
              pinyin: 'Quèshí, Dōngnányà shìchǎng de qiánlì yě bù róng hūshì.',
              meaningVi: 'Đúng vậy, tiềm năng của thị trường Đông Nam Á cũng không thể xem nhẹ.',
            },
            {
              id: 'hsk6-l1-d4',
              speaker: 'B',
              roleName: 'Cố vấn',
              hanzi: '抓住机遇就能实现可持续增长。',
              pinyin: 'Zhuāzhù jīyù jiù néng shíxiàn kěchíxù zēngzhǎng.',
              meaningVi: 'Nắm bắt thời cơ là có thể đạt mức tăng trưởng bền vững.',
            },
          ],
        },
        quizzes: [
          {
            id: 'hsk6-l1-q1',
            type: 'multiple_choice',
            promptVi: 'Động từ "优化 (yōuhuà)" phù hợp nhất với tân ngữ nào sau đây?',
            options: [
              { id: 'a', hanzi: '流程', pinyin: 'liúchéng', labelVi: 'Quy trình (tối ưu hóa quy trình)' },
              { id: 'b', hanzi: '问题', pinyin: 'wèntí', labelVi: 'Vấn đề (thường đi với 解决)' },
              { id: 'c', hanzi: '经验', pinyin: 'jīngyàn', labelVi: 'Kinh nghiệm (thường đi với 积累)' },
              { id: 'd', hanzi: '名字', pinyin: 'míngzi', labelVi: 'Tên' },
            ],
            correctOptionId: 'a',
            explanationVi: '优化流程 (tối ưu hóa quy trình) là cụm từ rất phổ biến trong quản trị.',
          },
          {
            id: 'hsk6-l1-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Thị trường này có tiềm năng phát triển to lớn."',
            targetTokens: ['这个', '市场', '具有', '巨大的', '潜力。'],
            distractorTokens: ['便宜', '停机'],
            pinyinAnswer: 'Zhège shìchǎng jùyǒu jùdà de qiánlì.',
            explanationVi: '具有 + 巨大的潜力 mang sắc thái trang trọng: "sở hữu tiềm năng to lớn".',
          },
          {
            id: 'hsk6-l1-q3',
            type: 'typing',
            promptVi: 'Gõ câu: "Tối ưu hóa quy trình rất quan trọng."',
            hintKeyword: 'Yōuhuà liúchéng hěn zhòngyào.',
            expectedHanzi: '优化流程很重要。',
            expectedPinyin: 'Yōuhuà liúchéng hěn zhòngyào.',
            explanationVi: '优化 (yōuhuà) + 流程 (liúchéng) + 很重要.',
          },
        ],
      },
    ],
  },

  // =========================================================================
  // TRACK 2: TIẾNG TRUNG CÔNG XƯỞNG (3 MODULES THỰC TẾ)
  // =========================================================================
  {
    id: 'factory-u1',
    track: 'factory',
    unitNumber: 1,
    title: 'Unit 1: An toàn & Nội quy xưởng',
    titleZh: '第一单元：车间安全与规章',
    description: 'Trang bị bảo hộ lao động, biển báo nguy hiểm và quy định an toàn trong nhà máy.',
    lessons: [
      {
        id: 'factory-u1-l1',
        track: 'factory',
        unitId: 'factory-u1',
        lessonNumber: 1,
        title: 'Trang bị bảo hộ lao động (PPE)',
        titleZh: '劳保用品佩戴',
        subtitle: '3 từ công xưởng • Hội thoại đầu ca • 3 bài tập thực hành',
        estimatedMinutes: 6,
        vocabs: [
          {
            id: 'fac-v-anquanmao',
            hanzi: '安全帽',
            pinyin: 'ānquánmào',
            meaningVi: 'Mũ bảo hộ an toàn',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '进入车间必须戴好安全帽。',
            examplePinyin: 'Jìnrù chējiān bìxū dài hǎo ānquánmào.',
            exampleVi: 'Khi vào phân xưởng bắt buộc phải đội mũ bảo hộ cẩn thận.',
          },
          {
            id: 'fac-v-shoutao',
            hanzi: '手套',
            pinyin: 'shǒutào',
            meaningVi: 'Găng tay bảo hộ',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '操作机器前请戴上防护手套。',
            examplePinyin: 'Cāozuò jīqì qián qǐng dài shàng fánghù shǒutào.',
            exampleVi: 'Trước khi vận hành máy xin hãy đeo găng tay bảo hộ.',
          },
          {
            id: 'fac-v-weixian',
            hanzi: '危险',
            pinyin: 'wēixiǎn',
            meaningVi: 'Nguy hiểm',
            partOfSpeech: 'Tính từ / Danh từ',
            exampleHanzi: '高压区很危险，请勿靠近！',
            examplePinyin: 'Gāoyāqū hěn wēixiǎn, qǐng wù kàojìn!',
            exampleVi: 'Khu vực điện cao áp rất nguy hiểm, xin đừng lại gần!',
          },
        ],
        dialogue: {
          title: 'Kiểm tra an toàn trước khi vào ca',
          context: 'Tổ trưởng nhắc nhở công nhân mới mang đủ đồ bảo hộ.',
          lines: [
            {
              id: 'fac-u1-d1',
              speaker: 'A',
              roleName: 'Tổ trưởng',
              hanzi: '小陈，你的安全帽怎么没戴好？',
              pinyin: 'Xiǎo Chén, nǐ de ānquánmào zěnme méi dài hǎo?',
              meaningVi: 'Tiểu Trần, sao cậu chưa đội mũ bảo hộ ngay ngắn vào?',
            },
            {
              id: 'fac-u1-d2',
              speaker: 'B',
              roleName: 'Công nhân',
              hanzi: '抱歉组长，我马上把帽带扣紧。',
              pinyin: 'Bàoqiàn zǔzhǎng, wǒ mǎshàng bǎ màodài kòujǐn.',
              meaningVi: 'Xin lỗi tổ trưởng, tôi cài chặt quai mũ ngay đây ạ.',
            },
            {
              id: 'fac-u1-d3',
              speaker: 'A',
              roleName: 'Tổ trưởng',
              hanzi: '记得也要戴好手套，这边操作很危险。',
              pinyin: 'Jìde yě yào dài hǎo shǒutào, zhèbiān cāozuò hěn wēixiǎn.',
              meaningVi: 'Nhớ đeo cả găng tay cẩn thận nhé, thao tác bên này rất nguy hiểm.',
            },
            {
              id: 'fac-u1-d4',
              speaker: 'B',
              roleName: 'Công nhân',
              hanzi: '明白！我这就去领一双新手套。',
              pinyin: 'Míngbai! Wǒ zhè jiù qù lǐng yì shuāng xīn shǒutào.',
              meaningVi: 'Tôi rõ rồi! Tôi đi nhận một đôi găng tay mới ngay.',
            },
          ],
        },
        quizzes: [
          {
            id: 'fac-u1-q1',
            type: 'multiple_choice',
            promptVi: 'Nghe khẩu lệnh và chọn đồ bảo hộ được nhắc tới:',
            audioText: '进入车间必须戴好安全帽。',
            options: [
              { id: 'a', hanzi: '安全帽', pinyin: 'ānquánmào', labelVi: 'Mũ bảo hộ an toàn' },
              { id: 'b', hanzi: '手套', pinyin: 'shǒutào', labelVi: 'Găng tay bảo hộ' },
              { id: 'c', hanzi: '工作服', pinyin: 'gōngzuòfú', labelVi: 'Quần áo bảo hộ' },
              { id: 'd', hanzi: '耳塞', pinyin: 'ěrsāi', labelVi: 'Nút bịt tai' },
            ],
            correctOptionId: 'a',
            explanationVi: 'Câu mẫu nói: "进入车间必须戴好安全帽" — Vào phân xưởng phải đội mũ bảo hộ.',
          },
          {
            id: 'fac-u1-q2',
            type: 'word_bank',
            promptVi: 'Ghép câu nhắc nhở: "Khu vực này rất nguy hiểm!"',
            targetTokens: ['这个', '区域', '非常', '危险！'],
            distractorTokens: ['便宜', '手套'],
            pinyinAnswer: 'Zhège qūyù fēicháng wēixiǎn!',
            explanationVi: '区域 (qūyù) nghĩa là khu vực; 非常危险 (cực kỳ nguy hiểm).',
          },
          {
            id: 'fac-u1-q3',
            type: 'typing',
            promptVi: 'Gõ câu: "Xin hãy đeo găng tay cẩn thận."',
            hintKeyword: 'Qǐng dài hǎo shǒutào.',
            expectedHanzi: '请戴好手套。',
            expectedPinyin: 'Qǐng dài hǎo shǒutào.',
            explanationVi: 'Động từ 戴 (dài - đội/đeo) + bổ ngữ kết quả 好 (cẩn thận, ngay ngắn).',
          },
        ],
      },
    ],
  },
  {
    id: 'factory-u2',
    track: 'factory',
    unitNumber: 2,
    title: 'Unit 2: Vận hành & Báo lỗi thiết bị',
    titleZh: '第二单元：设备操作与报修',
    description: 'Nhận biết sự cố máy móc, thao tác dừng khẩn cấp và gọi kỹ thuật bảo trì kịp thời.',
    lessons: [
      {
        id: 'factory-u2-l1',
        track: 'factory',
        unitId: 'factory-u2',
        lessonNumber: 1,
        title: 'Báo lỗi máy & Bảo trì',
        titleZh: '机器故障与维修',
        subtitle: 'Bài trọng tâm xưởng • 3 từ khóa cốt lõi • Hội thoại báo hỏng • 3 dạng bài tập',
        estimatedMinutes: 8,
        vocabs: [
          {
            id: 'fac-v-guzhang',
            hanzi: '故障',
            pinyin: 'gùzhàng',
            meaningVi: 'Sự cố / Hỏng hóc kỹ thuật',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '三号冲压机突然出现故障了。',
            examplePinyin: 'Sān hào chōngyājī tūrán chūxiàn gùzhàng le.',
            exampleVi: 'Máy dập số 3 đột nhiên bị hỏng hóc / báo lỗi rồi.',
          },
          {
            id: 'fac-v-tingji',
            hanzi: '停机',
            pinyin: 'tíngjī',
            meaningVi: 'Dừng máy / Tắt máy',
            partOfSpeech: 'Động từ ly hợp',
            exampleHanzi: '发现异常响声请立即停机！',
            examplePinyin: 'Fāxiàn yìcháng xiǎngshēng qǐng lìjí tíngjī!',
            exampleVi: 'Phát hiện tiếng động bất thường xin hãy dừng máy ngay lập tức!',
          },
          {
            id: 'fac-v-weixiu',
            hanzi: '维修',
            pinyin: 'wéixiū',
            meaningVi: 'Sửa chữa / Bảo trì thiết bị',
            partOfSpeech: 'Động từ',
            exampleHanzi: '维修师傅正在检修电路板。',
            examplePinyin: 'Wéixiū shīfu zhèngzài jiǎnxiū diànlùbǎn.',
            exampleVi: 'Thợ bảo trì đang kiểm tra và sửa bảng mạch điện.',
          },
        ],
        dialogue: {
          title: 'Báo lỗi máy khẩn cấp trên dây chuyền B',
          context: 'Công nhân phát hiện máy kêu lạ và báo ngay cho kỹ thuật viên bảo trì.',
          lines: [
            {
              id: 'fac-u2-d1',
              speaker: 'A',
              roleName: 'Công nhân đứng máy',
              hanzi: '王工，这台机器突然发出奇怪的声音！',
              pinyin: 'Wáng gōng, zhè tái jīqì tūrán fāchū qíguài de shēngyīn!',
              meaningVi: 'Kỹ sư Vương ơi, chiếc máy này bỗng nhiên phát ra tiếng kêu lạ!',
            },
            {
              id: 'fac-u2-d2',
              speaker: 'B',
              roleName: 'Kỹ thuật bảo trì',
              hanzi: '快按下急停按钮，先停机！',
              pinyin: 'Kuài àn xià jítíng ànniǔ, xiān tíngjī!',
              meaningVi: 'Mau ấn nút dừng khẩn cấp đi, tắt máy trước đã!',
            },
            {
              id: 'fac-u2-d3',
              speaker: 'A',
              roleName: 'Công nhân đứng máy',
              hanzi: '我已经停机了，屏幕上显示电机故障。',
              pinyin: 'Wǒ yǐjīng tíngjī le, píngmù shàng xiǎnshì diànjī gùzhàng.',
              meaningVi: 'Tôi đã dừng máy rồi, màn hình báo lỗi mô-tơ điện.',
            },
            {
              id: 'fac-u2-d4',
              speaker: 'B',
              roleName: 'Kỹ thuật bảo trì',
              hanzi: '收到，我带工具过来马上维修。',
              pinyin: 'Shōudào, wǒ dài gōngjù guòlái mǎshàng wéixiū.',
              meaningVi: 'Rõ rồi, tôi mang dụng cụ qua sửa chữa bảo trì ngay đây.',
            },
            {
              id: 'fac-u2-d5',
              speaker: 'A',
              roleName: 'Công nhân đứng máy',
              hanzi: '好的，大概需要修多久？',
              pinyin: 'Hǎo de, dàgài xūyào xiū duōjiǔ?',
              meaningVi: 'Vâng, khoảng chừng cần sửa trong bao lâu ạ?',
            },
            {
              id: 'fac-u2-d6',
              speaker: 'B',
              roleName: 'Kỹ thuật bảo trì',
              hanzi: '二十分钟左右，修好后我通知你。',
              pinyin: 'Èrshí fēnzhōng zuǒyòu, xiūhǎo hòu wǒ tōngzhī nǐ.',
              meaningVi: 'Tầm 20 phút thôi, sửa xong tôi sẽ báo cho bạn.',
            },
          ],
        },
        quizzes: [
          {
            id: 'fac-u2-q1',
            type: 'multiple_choice',
            promptVi: 'Khi máy phát ra tiếng động lạ hoặc báo lỗi, bước đầu tiên cần làm theo hội thoại là gì?',
            audioText: '发现异常声音时，请先停机再通知维修部门。',
            options: [
              { id: 'a', hanzi: '先停机', pinyin: 'xiān tíngjī', labelVi: 'Dừng máy ngay lập tức trước đã' },
              { id: 'b', hanzi: '继续生产', pinyin: 'jìxù shēngchǎn', labelVi: 'Tiếp tục cho máy chạy sản xuất' },
              { id: 'c', hanzi: '离开岗位', pinyin: 'líkāi gǎngwèi', labelVi: 'Tự ý rời khỏi vị trí' },
              { id: 'd', hanzi: '关闭灯光', pinyin: 'guānbì dēngguāng', labelVi: 'Tắt đèn khu vực' },
            ],
            correctOptionId: 'a',
            explanationVi: 'Quy tắc an toàn vàng trong xưởng: 发现异常先停机 (Phát hiện bất thường phải dừng máy trước), rồi mới gọi 维修 (bảo trì).',
          },
          {
            id: 'fac-u2-q2',
            type: 'word_bank',
            promptVi: 'Ghép câu báo hỏng: "Xin hãy gọi thợ bảo trì tới kiểm tra máy này."',
            audioText: '请叫维修师傅来检查这台机器。',
            targetTokens: ['请', '叫', '维修师傅', '来', '检查', '这台机器。'],
            distractorTokens: ['安全帽', '再见'],
            pinyinAnswer: 'Qǐng jiào wéixiū shīfu lái jiǎnchá zhè tái jīqì.',
            explanationVi: '维修师傅 (wéixiū shīfu) là cách gọi lịch sự, thông dụng chỉ bác/anh thợ sửa chữa bảo trì.',
          },
          {
            id: 'fac-u2-q3',
            type: 'typing',
            promptVi: 'Gõ câu báo lỗi bằng bộ gõ Pinyin IME: "Chiếc máy này bị lỗi rồi."',
            hintKeyword: 'Zhè tái jīqì chū gùzhàng le.',
            expectedHanzi: '这台机器出故障了。',
            expectedPinyin: 'Zhè tái jīqì chū gùzhàng le.',
            explanationVi: 'Lượng từ cho máy móc là 台 (tái): 这台机器 + 出故障了 (xảy ra sự cố).',
          },
        ],
      },
      {
        id: 'factory-u2-l2',
        track: 'factory',
        unitId: 'factory-u2',
        lessonNumber: 2,
        title: 'Kiểm tra & Bảo dưỡng định kỳ',
        titleZh: '设备点检与保养',
        subtitle: '3 từ công xưởng • Hội thoại kiểm tra đầu ca • 3 bài tập',
        estimatedMinutes: 7,
        vocabs: [
          {
            id: 'fac-v-baoyang',
            hanzi: '保养',
            pinyin: 'bǎoyǎng',
            meaningVi: 'Bảo dưỡng',
            partOfSpeech: 'Động từ / Danh từ',
            exampleHanzi: '每周五都要做一次设备保养。',
            examplePinyin: 'Měi zhōu wǔ dōu yào zuò yí cì shèbèi bǎoyǎng.',
            exampleVi: 'Thứ Sáu hằng tuần đều phải bảo dưỡng thiết bị một lần.',
          },
          {
            id: 'fac-v-shebei',
            hanzi: '设备',
            pinyin: 'shèbèi',
            meaningVi: 'Thiết bị / Máy móc',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '所有生产设备已经调试好了。',
            examplePinyin: 'Suǒyǒu shēngchǎn shèbèi yǐjīng tiáoshì hǎo le.',
            exampleVi: 'Toàn bộ thiết bị sản xuất đã được hiệu chỉnh xong.',
          },
          {
            id: 'fac-v-zhengchang',
            hanzi: '正常',
            pinyin: 'zhèngcháng',
            meaningVi: 'Bình thường / Ổn định',
            partOfSpeech: 'Tính từ',
            exampleHanzi: '现在机器运行完全正常。',
            examplePinyin: 'Xiànzài jīqì yùnxíng wánquán zhèngcháng.',
            exampleVi: 'Hiện tại máy vận hành hoàn toàn bình thường.',
          },
        ],
        dialogue: {
          title: 'Nghiệm thu máy sau bảo dưỡng',
          context: 'Kỹ thuật viên bàn giao lại máy sau khi tra dầu và cân chỉnh.',
          lines: [
            {
              id: 'fac-u2b-d1',
              speaker: 'A',
              roleName: 'Kỹ thuật viên',
              hanzi: '这台设备我已经做完保养了。',
              pinyin: 'Zhè tái shèbèi wǒ yǐjīng zuòwán bǎoyǎng le.',
              meaningVi: 'Thiết bị này tôi đã làm xong phần bảo dưỡng rồi nhé.',
            },
            {
              id: 'fac-u2b-d2',
              speaker: 'B',
              roleName: 'Công nhân đứng máy',
              hanzi: '辛苦了！现在参数都正常吗？',
              pinyin: 'Xīnkǔ le! Xiànzài cānshù dōu zhèngcháng ma?',
              meaningVi: 'Vất vả cho anh rồi! Giờ các thông số đều bình thường cả chứ?',
            },
            {
              id: 'fac-u2b-d3',
              speaker: 'A',
              roleName: 'Kỹ thuật viên',
              hanzi: '一切正常，你可以开机试跑十件看看。',
              pinyin: 'Yíqiè zhèngcháng, nǐ kěyǐ kāijī shìpǎo shí jiàn kànkan.',
              meaningVi: 'Mọi thứ bình thường, bạn có thể mở máy chạy thử 10 sản phẩm xem sao.',
            },
            {
              id: 'fac-u2b-d4',
              speaker: 'B',
              roleName: 'Công nhân đứng máy',
              hanzi: '好的，我马上测试并记录在表上。',
              pinyin: 'Hǎo de, wǒ mǎshàng cèshì bìng jìlù zài biǎo shàng.',
              meaningVi: 'Vâng, tôi kiểm tra thử và ghi vào phiếu ngay.',
            },
          ],
        },
        quizzes: [
          {
            id: 'fac-u2b-q1',
            type: 'multiple_choice',
            promptVi: 'Phân biệt nhanh: "维修" khác "保养" ở điểm nào?',
            options: [
              { id: 'a', hanzi: '保养 = bảo dưỡng định kỳ; 维修 = sửa khi đã hỏng', labelVi: 'Định kỳ phòng ngừa vs Sửa chữa sự cố' },
              { id: 'b', hanzi: '保养 là dừng máy; 维修 là bật máy', labelVi: 'Bật và tắt máy' },
              { id: 'c', hanzi: 'Hai từ cùng nghĩa là thay linh kiện', labelVi: 'Thay thế linh kiện' },
              { id: 'd', hanzi: '保养 chỉ dùng cho con người', labelVi: 'Chỉ dùng cho người' },
            ],
            correctOptionId: 'a',
            explanationVi: 'Trong nhà máy: 保养 (bǎoyǎng) là bảo dưỡng định kỳ (tra dầu, vệ sinh); 维修 (wéixiū) là sửa chữa khi thiết bị gặp 故障.',
          },
          {
            id: 'fac-u2b-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Hiện tại máy chạy rất bình thường."',
            targetTokens: ['现在', '机器', '运行', '很', '正常。'],
            distractorTokens: ['故障', '停机'],
            pinyinAnswer: 'Xiànzài jīqì yùnxíng hěn zhèngcháng.',
            explanationVi: '运行 (yùnxíng - vận hành/chạy) + 很正常 (rất ổn định bình thường).',
          },
          {
            id: 'fac-u2b-q3',
            type: 'typing',
            promptVi: 'Gõ câu: "Thiết bị này cần phải bảo dưỡng."',
            hintKeyword: 'Zhè tái shèbèi xūyào bǎoyǎng.',
            expectedHanzi: '这台设备需要保养。',
            expectedPinyin: 'Zhè tái shèbèi xūyào bǎoyǎng.',
            explanationVi: '设备 (shèbèi) là thiết bị, 需要 (xūyào) là cần.',
          },
        ],
      },
    ],
  },
  {
    id: 'factory-u3',
    track: 'factory',
    unitNumber: 3,
    title: 'Unit 3: Giao tiếp kỹ thuật & Quản lý',
    titleZh: '第三单元：技术沟通与管理',
    description: 'Báo cáo sản lượng, kiểm soát tỷ lệ đạt chuẩn QC và bàn giao giữa hai ca làm việc.',
    lessons: [
      {
        id: 'factory-u3-l1',
        track: 'factory',
        unitId: 'factory-u3',
        lessonNumber: 1,
        title: 'Bàn giao ca & Báo cáo sản lượng',
        titleZh: '交接班与产量汇报',
        subtitle: '3 từ quản lý xưởng • Hội thoại bàn giao ca • 3 bài tập',
        estimatedMinutes: 8,
        vocabs: [
          {
            id: 'fac-v-chanliang',
            hanzi: '产量',
            pinyin: 'chǎnliàng',
            meaningVi: 'Sản lượng',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '今天白班的产量达到两千件。',
            examplePinyin: 'Jīntiān báibān de chǎnliàng dádào liǎngqiān jiàn.',
            exampleVi: 'Sản lượng ca ngày hôm nay đạt 2.000 sản phẩm.',
          },
          {
            id: 'fac-v-hegelv',
            hanzi: '合格率',
            pinyin: 'hégélǜ',
            meaningVi: 'Tỷ lệ đạt chuẩn (QC Pass)',
            partOfSpeech: 'Danh từ',
            exampleHanzi: '本批产品的合格率高达百分之九十九。',
            examplePinyin: 'Běn pī chǎnpǐn de hégélǜ gāodá bǎi fēn zhī jiǔshíjiǔ.',
            exampleVi: 'Tỷ lệ đạt chuẩn của lô hàng này đạt tới 99%.',
          },
          {
            id: 'fac-v-jiaojieban',
            hanzi: '交接班',
            pinyin: 'jiāojiēbān',
            meaningVi: 'Bàn giao ca làm việc',
            partOfSpeech: 'Động từ / Danh từ',
            exampleHanzi: '下班前请认真做好交接班记录。',
            examplePinyin: 'Xiàbān qián qǐng rènzhēn zuòhǎo jiāojiēbān jìlù.',
            exampleVi: 'Trước khi tan ca xin hãy ghi chép bàn giao ca thật cẩn thận.',
          },
        ],
        dialogue: {
          title: 'Bàn giao ca tối giữa hai tổ trưởng',
          context: 'Cuối ca ngày báo cáo tiến độ và sản lượng cho ca đêm.',
          lines: [
            {
              id: 'fac-u3-d1',
              speaker: 'A',
              roleName: 'Tổ trưởng ca ngày',
              hanzi: '我们准备交接班了，今天产量一共两千套。',
              pinyin: 'Wǒmen zhǔnbèi jiāojiēbān le, jīntiān chǎnliàng yígòng liǎngqiān tào.',
              meaningVi: 'Chúng tôi chuẩn bị bàn giao ca nhé, tổng sản lượng hôm nay là 2.000 bộ.',
            },
            {
              id: 'fac-u3-d2',
              speaker: 'B',
              roleName: 'Tổ trưởng ca đêm',
              hanzi: '不错啊！这一批的合格率怎么样？',
              pinyin: 'Búcuò a! Zhè yì pī de hégélǜ zěnmeyàng?',
              meaningVi: 'Tốt quá nhỉ! Tỷ lệ đạt chuẩn của lô này thế nào?',
            },
            {
              id: 'fac-u3-d3',
              speaker: 'A',
              roleName: 'Tổ trưởng ca ngày',
              hanzi: '合格率百分之九十八点五，仅有三十件不良品。',
              pinyin: 'Hégélǜ bǎi fēn zhī jiǔshíbā diǎn wǔ, jǐnyǒu sānshí jiàn bùliángpǐn.',
              meaningVi: 'Tỷ lệ đạt chuẩn là 98.5%, chỉ có 30 sản phẩm lỗi thôi.',
            },
            {
              id: 'fac-u3-d4',
              speaker: 'B',
              roleName: 'Tổ trưởng ca đêm',
              hanzi: '清楚了，我会在晚班重点抽检。',
              pinyin: 'Qīngchu le, wǒ huì zài wǎnbān zhòngdiǎn chōujiǎn.',
              meaningVi: 'Rõ rồi, tôi sẽ cho kiểm tra chọn mẫu kỹ ở ca đêm.',
            },
          ],
        },
        quizzes: [
          {
            id: 'fac-u3-q1',
            type: 'multiple_choice',
            promptVi: 'Thuật ngữ "合格率 (hégélǜ)" trong QC nhà máy dùng để chỉ số liệu nào?',
            options: [
              { id: 'a', hanzi: '合格率', pinyin: 'hégélǜ', labelVi: 'Tỷ lệ sản phẩm đạt chất lượng' },
              { id: 'b', hanzi: '不良率', pinyin: 'bùliánglǜ', labelVi: 'Tỷ lệ hàng lỗi (NG)' },
              { id: 'c', hanzi: '产量', pinyin: 'chǎnliàng', labelVi: 'Tổng số lượng sản xuất' },
              { id: 'd', hanzi: '交接班', pinyin: 'jiāojiēbān', labelVi: 'Thời gian chuyển ca' },
            ],
            correctOptionId: 'a',
            explanationVi: '合格 (đạt tiêu chuẩn) + 率 (tỷ lệ) = Tỷ lệ hàng đạt chuẩn (Yield / Pass Rate).',
          },
          {
            id: 'fac-u3-q2',
            type: 'word_bank',
            promptVi: 'Ghép thành câu: "Sản lượng hôm nay rất cao."',
            targetTokens: ['今天的', '产量', '非常', '高。'],
            distractorTokens: ['维修', '便宜'],
            pinyinAnswer: 'Jīntiān de chǎnliàng fēicháng gāo.',
            explanationVi: '产量 (sản lượng) dùng với 高/低 (cao/thấp).',
          },
          {
            id: 'fac-u3-q3',
            type: 'typing',
            promptVi: 'Gõ câu: "Chúng ta chuẩn bị bàn giao ca."',
            hintKeyword: 'Wǒmen zhǔnbèi jiāojiēbān le.',
            expectedHanzi: '我们准备交接班了。',
            expectedPinyin: 'Wǒmen zhǔnbèi jiāojiēbān le.',
            explanationVi: '交接班 (jiāojiēbān) là bàn giao ca làm việc.',
          },
        ],
      },
    ],
  },
]

export function getCourseUnitsByTrack(track: CourseTrack, hskLevel?: number): CourseUnit[] {
  return COURSE_UNITS.filter((unit) => {
    if (unit.track !== track) return false
    if (track === 'hsk' && typeof hskLevel === 'number') {
      return unit.hskLevel === hskLevel
    }
    return true
  })
}

export function getAllCourseLessons(): CourseLesson[] {
  return COURSE_UNITS.flatMap((unit) => unit.lessons)
}

export function getCourseLessonById(lessonId: string): { lesson: CourseLesson; unit: CourseUnit } | null {
  for (const unit of COURSE_UNITS) {
    const found = unit.lessons.find((lesson) => lesson.id === lessonId)
    if (found) {
      return { lesson: found, unit }
    }
  }
  return null
}

export function getNextCourseLesson(lessonId: string): CourseLesson | null {
  const current = getCourseLessonById(lessonId)
  if (!current) return null

  // Ưu tiên tìm bài tiếp theo trong cùng track (và cùng cấp độ HSK nếu có, hoặc sang Unit kế tiếp trong cùng track)
  const sameTrackUnits = COURSE_UNITS.filter((unit) => {
    if (unit.track !== current.lesson.track) return false
    if (unit.track === 'hsk' && current.lesson.hskLevel) {
      return unit.hskLevel === current.lesson.hskLevel
    }
    return true
  })
  const flatTrackLessons = sameTrackUnits.flatMap((u) => u.lessons)
  const idx = flatTrackLessons.findIndex((l) => l.id === lessonId)
  if (idx !== -1 && idx + 1 < flatTrackLessons.length) {
    return flatTrackLessons[idx + 1]
  }
  return null
}

/**
 * Xáo trộn mảng từ gợi ý theo hạt giống cố định (deterministic theo questionId)
 * Đảm bảo SSR & Client hydrate khớp nhau 100%, không gây Hydration Mismatch!
 */
export function buildShuffledWordBank(question: WordBankQuizQuestion): { id: string; text: string }[] {
  const combined = [...question.targetTokens, ...(question.distractorTokens || [])]
  const items = combined.map((text, index) => ({
    id: `${question.id}-tok-${index}`,
    text,
  }))

  // Seeded PRNG từ question.id
  let seed = 0
  for (let i = 0; i < question.id.length; i++) {
    seed = (seed * 31 + question.id.charCodeAt(i)) >>> 0
  }

  for (let i = items.length - 1; i > 0; i--) {
    seed = (seed * 1664525 + 1013904223) >>> 0
    const j = seed % (i + 1)
    const temp = items[i]
    items[i] = items[j]
    items[j] = temp
  }

  return items
}
