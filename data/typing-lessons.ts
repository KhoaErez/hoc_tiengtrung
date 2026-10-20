// Dữ liệu bài luyện đánh máy tiếng Trung (Chinese Typing Practice Data)
// Bao gồm 4 chế độ: Câu mẫu, Từ vựng, Đoạn văn, và Theo HSK (HSK 1 - 6)

export type TypingMode = 'sentence' | 'vocabulary' | 'paragraph' | 'hsk';
export type TypingDifficulty = 'easy' | 'medium' | 'hard';

export interface TypingExercise {
  id: string;
  titleZh?: string;       // Tiêu đề chữ Hán (cho đoạn văn hoặc bài đọc)
  titleVi?: string;       // Tiêu đề tiếng Việt
  hanzi: string;          // Chuỗi chữ Hán mục tiêu
  pinyin: string;         // Phiên âm Pinyin có dấu
  meaning: string;        // Nghĩa tiếng Việt
  mode: TypingMode;       // Chế độ luyện tập
  level?: string;         // 'Cơ bản' | 'Sơ cấp' | 'Trung cấp' | 'Nâng cao'
  hskLevel?: number;      // 1 đến 6 (khi ở chế độ HSK)
  category?: string;      // Chủ đề (Chào hỏi, Mua sắm, Du lịch...)
  difficulty?: TypingDifficulty;
  exampleHanzi?: string;  // Câu ví dụ chữ Hán (khi luyện HSK)
  examplePinyin?: string; // Pinyin câu ví dụ
  exampleVi?: string;     // Nghĩa câu ví dụ
}

// 1. Chế độ 1: Luyện gõ theo câu mẫu (Sentences)
export const sentenceExercises: TypingExercise[] = [
  // Cơ bản
  {
    id: 'sen-1',
    hanzi: '你好，很高兴认识你。',
    pinyin: 'Nǐ hǎo, hěn gāoxìng rènshi nǐ.',
    meaning: 'Xin chào, rất vui được làm quen với bạn.',
    mode: 'sentence',
    level: 'Cơ bản',
    category: 'Giao tiếp hàng ngày',
    difficulty: 'easy',
  },
  {
    id: 'sen-2',
    hanzi: '我喜欢学习中文。',
    pinyin: 'Wǒ xǐhuan xuéxí zhōngwén.',
    meaning: 'Tôi thích học tiếng Trung.',
    mode: 'sentence',
    level: 'Cơ bản',
    category: 'Học tập',
    difficulty: 'easy',
  },
  {
    id: 'sen-3',
    hanzi: '今天天气非常晴朗。',
    pinyin: 'Jīntiān tiānqì fēicháng qínglǎng.',
    meaning: 'Hôm nay thời tiết rất trong xanh.',
    mode: 'sentence',
    level: 'Cơ bản',
    category: 'Thời tiết',
    difficulty: 'easy',
  },
  {
    id: 'sen-4',
    hanzi: '请问，洗手间在哪里？',
    pinyin: 'Qǐngwèn, xǐshǒujiān zài nǎlǐ?',
    meaning: 'Xin hỏi, nhà vệ sinh ở đâu vậy?',
    mode: 'sentence',
    level: 'Cơ bản',
    category: 'Hỏi đường',
    difficulty: 'easy',
  },
  {
    id: 'sen-5',
    hanzi: '这个苹果真好吃。',
    pinyin: 'Zhège píngguǒ zhēn hǎochī.',
    meaning: 'Quả táo này thật là ngon.',
    mode: 'sentence',
    level: 'Cơ bản',
    category: 'Ăn uống',
    difficulty: 'easy',
  },
  // Trung cấp
  {
    id: 'sen-6',
    hanzi: '虽然工作很忙，但我每天都坚持跑步。',
    pinyin: 'Suīrán gōngzuò hěn máng, dàn wǒ měitiān dōu jiānchí pǎobù.',
    meaning: 'Tuy công việc rất bận, nhưng ngày nào tôi cũng kiên trì chạy bộ.',
    mode: 'sentence',
    level: 'Trung cấp',
    category: 'Đời sống',
    difficulty: 'medium',
  },
  {
    id: 'sen-7',
    hanzi: '书籍是人类进步的阶梯。',
    pinyin: 'Shūjí shì rénlèi jìnbù de jiētī.',
    meaning: 'Sách là bậc thang tiến bộ của loài người.',
    mode: 'sentence',
    level: 'Trung cấp',
    category: 'Châm ngôn',
    difficulty: 'medium',
  },
  {
    id: 'sen-8',
    hanzi: '多听、多说、多读、多写是学好外语的方法。',
    pinyin: 'Duō tīng, duō shuō, duō dú, duō xiě shì xué hǎo wàiyǔ de fāngfǎ.',
    meaning: 'Nghe nhiều, nói nhiều, đọc nhiều, viết nhiều là phương pháp học giỏi ngoại ngữ.',
    mode: 'sentence',
    level: 'Trung cấp',
    category: 'Học tập',
    difficulty: 'medium',
  },
  {
    id: 'sen-9',
    hanzi: '如果你明天有空，我们一起去看电影吧。',
    pinyin: 'Rúguǒ nǐ míngtiān yǒu kòng, wǒmen yìqǐ qù kàn diànyǐng ba.',
    meaning: 'Nếu ngày mai bạn rảnh, chúng mình cùng đi xem phim nhé.',
    mode: 'sentence',
    level: 'Trung cấp',
    category: 'Hẹn hò',
    difficulty: 'medium',
  },
  // Nâng cao
  {
    id: 'sen-10',
    hanzi: '千里之行，始于足下。',
    pinyin: 'Qiān lǐ zhī xíng, shǐ yú zú xià.',
    meaning: 'Hành trình ngàn dặm bắt đầu từ một bước chân.',
    mode: 'sentence',
    level: 'Nâng cao',
    category: 'Thành ngữ',
    difficulty: 'hard',
  },
  {
    id: 'sen-11',
    hanzi: '无论面对什么困难，我们都要保持积极乐观的心态。',
    pinyin: 'Wúlùn miànduì shénme kùnnan, wǒmen dōu yào bǎochí jījí lèguān de xīntài.',
    meaning: 'Bất luận đối mặt với khó khăn gì, chúng ta đều phải giữ tâm thế tích cực và lạc quan.',
    mode: 'sentence',
    level: 'Nâng cao',
    category: 'Tư duy',
    difficulty: 'hard',
  },
  {
    id: 'sen-12',
    hanzi: '科技的发展极大地改变了现代人们的生活方式。',
    pinyin: 'Kējì de fāzhǎn jídà de gǎibiàn le xiàndài rénmen de shēnghuó fāngshì.',
    meaning: 'Sự phát triển của công nghệ đã thay đổi to lớn lối sống của con người hiện đại.',
    mode: 'sentence',
    level: 'Nâng cao',
    category: 'Khoa học công nghệ',
    difficulty: 'hard',
  },
];

// 2. Chế độ 2: Luyện gõ từ vựng (Vocabulary)
export const vocabularyExercises: TypingExercise[] = [
  // Chào hỏi & Xã giao
  { id: 'voc-1', hanzi: '你好', pinyin: 'nǐ hǎo', meaning: 'Xin chào', mode: 'vocabulary', category: 'Chào hỏi' },
  { id: 'voc-2', hanzi: '谢谢', pinyin: 'xièxie', meaning: 'Cảm ơn', mode: 'vocabulary', category: 'Chào hỏi' },
  { id: 'voc-3', hanzi: '不客气', pinyin: 'bú kèqi', meaning: 'Đừng khách sáo / Không có chi', mode: 'vocabulary', category: 'Chào hỏi' },
  { id: 'voc-4', hanzi: '对不起', pinyin: 'duìbuqǐ', meaning: 'Xin lỗi', mode: 'vocabulary', category: 'Chào hỏi' },
  { id: 'voc-5', hanzi: '再见', pinyin: 'zàijiàn', meaning: 'Tạm biệt', mode: 'vocabulary', category: 'Chào hỏi' },
  
  // Thời gian & Đời sống
  { id: 'voc-6', hanzi: '今天', pinyin: 'jīntiān', meaning: 'Hôm nay', mode: 'vocabulary', category: 'Thời gian' },
  { id: 'voc-7', hanzi: '明天', pinyin: 'míngtiān', meaning: 'Ngày mai', mode: 'vocabulary', category: 'Thời gian' },
  { id: 'voc-8', hanzi: '星期天', pinyin: 'xīngqītiān', meaning: 'Chủ nhật', mode: 'vocabulary', category: 'Thời gian' },
  { id: 'voc-9', hanzi: '现在', pinyin: 'xiànzài', meaning: 'Bây giờ', mode: 'vocabulary', category: 'Thời gian' },
  { id: 'voc-10', hanzi: '早安', pinyin: 'zǎo ān', meaning: 'Chào buổi sáng', mode: 'vocabulary', category: 'Thời gian' },

  // Gia đình & Con người
  { id: 'voc-11', hanzi: '爸爸', pinyin: 'bàba', meaning: 'Bố, cha', mode: 'vocabulary', category: 'Gia đình' },
  { id: 'voc-12', hanzi: '妈妈', pinyin: 'māma', meaning: 'Mẹ', mode: 'vocabulary', category: 'Gia đình' },
  { id: 'voc-13', hanzi: '朋友', pinyin: 'péngyou', meaning: 'Bạn bè', mode: 'vocabulary', category: 'Con người' },
  { id: 'voc-14', hanzi: '老师', pinyin: 'lǎoshī', meaning: 'Thầy cô giáo', mode: 'vocabulary', category: 'Con người' },
  { id: 'voc-15', hanzi: '学生', pinyin: 'xuésheng', meaning: 'Học sinh, sinh viên', mode: 'vocabulary', category: 'Con người' },

  // Mua sắm & Ăn uống
  { id: 'voc-16', hanzi: '米饭', pinyin: 'mǐfàn', meaning: 'Cơm', mode: 'vocabulary', category: 'Ăn uống' },
  { id: 'voc-17', hanzi: '面条', pinyin: 'miàntiáo', meaning: 'Mì sợi', mode: 'vocabulary', category: 'Ăn uống' },
  { id: 'voc-18', hanzi: '喝茶', pinyin: 'hē chá', meaning: 'Uống trà', mode: 'vocabulary', category: 'Ăn uống' },
  { id: 'voc-19', hanzi: '多少钱', pinyin: 'duōshao qián', meaning: 'Bao nhiêu tiền', mode: 'vocabulary', category: 'Mua sắm' },
  { id: 'voc-20', hanzi: '便宜一点', pinyin: 'piányi yìdiǎn', meaning: 'Rẻ hơn một chút', mode: 'vocabulary', category: 'Mua sắm' },

  // Cảm xúc & Tính chất
  { id: 'voc-21', hanzi: '高兴', pinyin: 'gāoxìng', meaning: 'Vui vẻ', mode: 'vocabulary', category: 'Cảm xúc' },
  { id: 'voc-22', hanzi: '美丽', pinyin: 'měilì', meaning: 'Xinh đẹp', mode: 'vocabulary', category: 'Tính chất' },
  { id: 'voc-23', hanzi: '认真', pinyin: 'rènzhēn', meaning: 'Chăm chỉ, nghiêm túc', mode: 'vocabulary', category: 'Tính chất' },
  { id: 'voc-24', hanzi: '健康', pinyin: 'jiànkāng', meaning: 'Khỏe mạnh, sức khỏe', mode: 'vocabulary', category: 'Sức khỏe' },
  { id: 'voc-25', hanzi: '幸福', pinyin: 'xìngfú', meaning: 'Hạnh phúc', mode: 'vocabulary', category: 'Cảm xúc' },
];

// 3. Chế độ 3: Luyện gõ đoạn văn (Paragraphs - 34 đoạn văn phân cấp độ rõ ràng)
export const paragraphExercises: TypingExercise[] = [
  // 4 đoạn văn mẫu gốc
  {
    id: 'par-1',
    titleZh: '我的汉语学习日常',
    titleVi: 'Nhật ký học tiếng Trung của tôi',
    hanzi: '我是个中文学习者。每天早上六点起床，一边喝咖啡一边练习发音。虽然汉字写起来不容易，但是只要每天坚持，我相信自己一定能说一口流利的普通话。',
    pinyin: 'Wǒ shì gè zhōngwén xuéxízhě. Měitiān zǎoshang liù diǎn qǐchuáng, yìbiān hē kāfēi yìbiān liànxí fāyīn. Suīrán hànzì xiě qǐlái bù róngyì, dànshì zhǐyào měitiān jiānchí, wǒ xiāngxìn zìjǐ yídìng néng shuō yì kǒu liúlì de pǔtōnghuà.',
    meaning: 'Tôi là một người học tiếng Trung. Mỗi ngày tôi dậy lúc sáu giờ sáng, vừa uống cà phê vừa luyện phát âm. Tuy chữ Hán rất khó viết, nhưng chỉ cần kiên trì mỗi ngày, tôi tin chắc mình có thể nói tiếng phổ thông trôi chảy.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Tự thuật',
    difficulty: 'medium',
  },
  {
    id: 'par-2',
    titleZh: '中国茶文化与生活',
    titleVi: 'Văn hóa trà và đời sống Trung Hoa',
    hanzi: '中国茶文化历史悠久。中国人不仅喜欢喝茶，还把品茶当作一种修身养性的生活方式。在安静的午后，沏上一壶清香的绿茶，能让人心情舒畅。',
    pinyin: 'Zhōngguó chá wénhuà lìshǐ yōujiǔ. Zhōngguórén bùjǐn xǐhuan hē chá, hái bǎ pǐnchá dàngzuò yì zhǒng xiūshēn yǎngxìng de shēnghuó fāngshì. Zài ānjìng de wǔhòu, qī shàng yì hú qīngxiāng de lǜchá, néng ràng rén xīnqíng shūchàng.',
    meaning: 'Văn hóa trà Trung Quốc có lịch sử lâu đời. Người Trung Quốc không những thích uống trà, mà còn xem việc thưởng trà như một lối sống tu tâm dưỡng tính. Vào buổi chiều thanh vắng, pha một ấm trà xanh thoang thoảng sẽ giúp lòng người khoan khoái.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Văn hóa',
    difficulty: 'hard',
  },
  {
    id: 'par-3',
    titleZh: '春天的公园美景',
    titleVi: 'Cảnh sắc công viên ngày xuân',
    hanzi: '春天来了，公园里百花齐放。绿油油的草地上，孩子们正在欢快地奔跑放风筝。微风拂面，空气中弥漫着泥土和花朵的清香，处处生机勃勃。',
    pinyin: 'Chūntiān lái le, gōngyuán lǐ bǎihuā qífàng. Lǜyōuyōu de cǎodì shàng, háizimen zhèngzài huānkuài de bēnpǎo fàng fēngzheng. Wēifēng fú miàn, kōngqì zhōng mímàn zhe nítǔ hé huāduǒ de qīngxiāng, chùchù shēngjī bóbó.',
    meaning: 'Mùa xuân đã đến, muôn hoa đua nở trong công viên. Trên thảm cỏ xanh mướt, những đứa trẻ đang vui vẻ chạy nhảy thả diều. Làn gió nhẹ thoảng qua mặt, không khí tràn ngập hương thơm của hoa lá và đất trời, nơi nơi tràn đầy sức sống.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Thiên nhiên',
    difficulty: 'hard',
  },
  {
    id: 'par-4',
    titleZh: '依山傍海的家乡',
    titleVi: 'Quê hương tựa núi nhìn biển',
    hanzi: '我的家乡在一个依山傍海的小城市。那里四季分明，风景秀丽。每当夕阳西下，金色的阳光洒在海面上，整个海湾宛如一幅绚丽的水彩画。',
    pinyin: 'Wǒ de jiāxiāng zài yí gè yīshān bànghǎi de xiǎo chéngshì. Nàlǐ sìjì fēnmíng, fēngjǐng xiùlì. Měi dāng xīyáng xī xià, jīnsè de yángguāng sǎ zài hǎimiàn shàng, zhěng gè hǎiwān wǎnrú yì fú xuànlì de shuǐcǎihuà.',
    meaning: 'Quê hương tôi ở một thành phố nhỏ tựa lưng vào núi hướng mặt ra biển. Nơi đó bốn mùa rõ rệt, phong cảnh tươi đẹp. Mỗi độ hoàng hôn buông xuống, ánh nắng vàng rực rải trên mặt biển, cả vịnh biển đẹp như một bức tranh màu nước lộng lẫy.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Quê hương',
    difficulty: 'medium',
  },

  // 10 ĐOẠN SƠ CẤP (par-5 đến par-14, HSK 1-2, 40-70 chữ)
  {
    id: 'par-5',
    titleZh: '我的幸福家庭',
    titleVi: 'Gia đình hạnh phúc của tôi',
    hanzi: '我家有四口人，爸爸、妈妈、姐姐和我。爸爸是医生，妈妈是老师。我们一家人住在一套明亮的大房子里。每到周末，我们都一起做饭，非常快乐。',
    pinyin: 'Wǒ jiā yǒu sì kǒu rén, bàba, māma, jiějie hé wǒ. Bàba shì yīshēng, māma shì lǎoshī. Wǒmen yì jiā rén zhù zài yí tào míngliàng de dà fángzi lǐ. Měi dào zhōumò, wǒmen dōu yìqǐ zuòfàn, fēicháng kuàilè.',
    meaning: 'Nhà tôi có bốn người: bố, mẹ, chị gái và tôi. Bố là bác sĩ, mẹ là giáo viên. Cả nhà chúng tôi sống trong một căn nhà lớn sáng sủa. Mỗi dịp cuối tuần, chúng tôi đều cùng nhau nấu cơm, rất vui vẻ.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Gia đình',
    difficulty: 'easy',
  },
  {
    id: 'par-6',
    titleZh: '我的一天生活',
    titleVi: 'Một ngày của tôi',
    hanzi: '我每天早上七点起床，吃过早饭后坐公交车去学校。中午我和同学在学校餐厅吃午饭。下午四点半放学回家。晚上我喜欢看书和听音乐。',
    pinyin: 'Wǒ měitiān zǎoshang qī diǎn qǐchuáng, chī guò zǎofàn hòu zuò gōngjiāochē qù xuéxiào. Zhōngwǔ wǒ hé tóngxué zài xuéxiào cāntīng chī wǔfàn. Xiàwǔ sì diǎn bàn fàngxué huí jiā. Wǎnshang wǒ xǐhuan kànshū hé tīng yīnyuè.',
    meaning: 'Mỗi ngày tôi dậy lúc bảy giờ sáng, ăn sáng xong thì đi xe buýt đến trường. Buổi trưa tôi cùng bạn học ăn cơm ở căng-tin trường. Bốn giờ rưỡi chiều tan học về nhà. Buổi tối tôi thích đọc sách và nghe nhạc.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Đời sống',
    difficulty: 'easy',
  },
  {
    id: 'par-7',
    titleZh: '我最好的中国朋友',
    titleVi: 'Người bạn Trung Quốc tốt nhất của tôi',
    hanzi: '李华是我的同班同学，也是我最好的朋友。他个子很高，性格开朗，而且非常热情。他常常帮我复习汉语生词，我也教他学习越南语。',
    pinyin: 'Lǐ Huá shì wǒ de tóngbān tóngxué, yě shì wǒ zuì hǎo de péngyou. Tā gèzi hěn gāo, xìnggé kāilǎng, érqiě fēicháng rèqíng. Tā chángcháng bāng wǒ fùxí hànyǔ shēngcí, wǒ yě jiāo tā xuéxí yuènányǔ.',
    meaning: 'Lý Hoa là bạn cùng lớp và cũng là người bạn tốt nhất của tôi. Cậu ấy dáng người rất cao, tính tình cởi mở và vô cùng nhiệt tình. Cậu ấy thường giúp tôi ôn tập từ mới tiếng Trung, tôi cũng dạy cậu ấy học tiếng Việt.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Bạn bè',
    difficulty: 'easy',
  },
  {
    id: 'par-8',
    titleZh: '去超市买水果',
    titleVi: 'Đi siêu thị mua hoa quả',
    hanzi: '今天下午我和朋友一起去超市。超市里的水果真多，有红红的苹果、黄黄的香蕉，还有甜甜的西瓜。我买了两斤苹果和一公斤香蕉。',
    pinyin: 'Jīntiān xiàwǔ wǒ hé péngyou yìqǐ qù chāoshì. Chāoshì lǐ de shuǐguǒ zhēn duō, yǒu hónghóng de píngguǒ, huánghuáng de xiāngjiāo, hái yǒu tiántián de xīguā. Wǒ mǎi le liǎng jīn píngguǒ hé yì gōngjīn xiāngjiāo.',
    meaning: 'Chiều nay tôi và bạn cùng nhau đi siêu thị. Trái cây trong siêu thị thật nhiều, có táo đỏ, chuối vàng và cả dưa hấu ngọt lịm. Tôi đã mua hai cân táo và một ki-lô-gam chuối.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Mua sắm',
    difficulty: 'easy',
  },
  {
    id: 'par-9',
    titleZh: '可爱的白色小猫',
    titleVi: 'Chú mèo trắng đáng yêu',
    hanzi: '我家有一只可爱的小猫，它叫小白。小白全身的毛都是白色的，眼睛又大又亮。每次我回家，它都会跑过来蹭我的腿，非常讨人喜欢。',
    pinyin: 'Wǒ jiā yǒu yì zhī kě\'ài de xiǎomāo, tā jiào Xiǎobái. Xiǎobái quánshēn de máo dōu shì báisè de, yǎnjing yòu dà yòu liàng. Měi cì wǒ huí jiā, tā dōu huì pǎo guòlái cèng wǒ de tuǐ, fēicháng tǎorén xǐhuan.',
    meaning: 'Nhà tôi có một chú mèo nhỏ đáng yêu tên là Tiểu Bạch. Toàn thân Tiểu Bạch lông đều màu trắng, đôi mắt to và sáng long lanh. Mỗi lần tôi về nhà, nó đều chạy đến cọ vào chân tôi, rất đáng yêu.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Thú cưng',
    difficulty: 'easy',
  },
  {
    id: 'par-10',
    titleZh: '今天的天气真舒服',
    titleVi: 'Thời tiết hôm nay thật dễ chịu',
    hanzi: '今天早上推开窗户，蓝天白云，微风吹在脸上很凉爽。今天既不冷也不热，阳光照在身上暖洋洋的，正适合和朋友一起去公园散步。',
    pinyin: 'Jīntiān zǎoshang tuīkāi chuānghu, lántiān báiyún, wēifēng chuī zài liǎn shàng hěn liángshuǎng. Jīntiān jì bù lěng yě bú rè, yángguāng zhào zài shēnshàng nuǎnyángyáng de, zhèng shìhé hé péngyou yìqǐ qù gōngyuán sànbù.',
    meaning: 'Sáng nay đẩy cửa sổ ra, trời xanh mây trắng, gió nhẹ thổi vào mặt rất mát mẻ. Hôm nay trời không lạnh cũng không nóng, ánh nắng chiếu lên người ấm áp, thật thích hợp để cùng bạn bè đi dạo công viên.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Thời tiết',
    difficulty: 'easy',
  },
  {
    id: 'par-11',
    titleZh: '我最喜欢中国菜',
    titleVi: 'Tôi thích nhất món ăn Trung Quốc',
    hanzi: '我很喜欢吃中国菜。北京烤鸭皮脆肉嫩，味道香极了。麻婆豆腐又麻又辣，特别下饭。如果有机会，我想学习亲手做几道正宗的中国菜。',
    pinyin: 'Wǒ hěn xǐhuan chī Zhōngguó cài. Běijīng kǎoyā pí cuì ròu nèn, wèidào xiāng jí le. Mápó dòufu yòu má yòu là, tèbié xiàfàn. Rúguǒ yǒu jīhuì, wǒ xiǎng xuéxí qīnshǒu zuò jǐ dào zhèngzōng de Zhōngguó cài.',
    meaning: 'Tôi rất thích ăn món Trung Quốc. Vịt quay Bắc Kinh da giòn thịt mềm, mùi vị thơm lừng. Đậu phụ Ma Bà vừa tê vừa cay, ăn với cơm rất hợp. Nếu có cơ hội, tôi muốn học tự tay nấu vài món ăn Trung Quốc chuẩn vị.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Ẩm thực',
    difficulty: 'easy',
  },
  {
    id: 'par-12',
    titleZh: '在图书馆安静看书',
    titleVi: 'Đọc sách yên tĩnh trong thư viện',
    hanzi: '学校的图书馆既大又安静。书架上摆满了各种各样的书。周末的时候，我常常在这里找一个靠窗的位置，安安静静地看一个下午的书。',
    pinyin: 'Xuéxiào de túshūguǎn jì dà yòu ānjìng. Shūjià shàng bǎimǎn le gèzhǒng gèyàng de shū. Zhōumò de shíhou, wǒ chángcháng zài zhèlǐ zhǎo yí gè kàochuāng de wèizhì, ān\'ānjìngjìng de kàn yí gè xiàwǔ de shū.',
    meaning: 'Thư viện trường học vừa rộng lớn vừa yên tĩnh. Trên giá sách xếp đầy đủ các loại sách. Vào dịp cuối tuần, tôi thường đến đây tìm một chỗ ngồi gần cửa sổ, yên lặng đọc sách suốt cả buổi chiều.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Học tập',
    difficulty: 'easy',
  },
  {
    id: 'par-13',
    titleZh: '周末打羽毛球',
    titleVi: 'Đánh cầu lông cuối tuần',
    hanzi: '运动让我感觉充满活力。每个星期六下午，我都和朋友去体育馆打羽毛球。虽然每次打完球都会流很多汗，但是身体感觉格外轻松。',
    pinyin: 'Yùndòng ràng wǒ gǎnjué chōngmǎn huólì. Měi gè xīngqīliù xiàwǔ, wǒ dōu hé péngyou qù tǐyùguǎn dǎ yǔmáoqiú. Suīrán měi cì dǎ wán qiú dōu huì liú hěn duō hàn, dànshì shēntǐ gǎnjué géwài qīngsōng.',
    meaning: 'Tập thể dục khiến tôi cảm thấy tràn đầy sức sống. Mỗi chiều thứ bảy, tôi đều cùng bạn đến nhà thi đấu đánh cầu lông. Tuy mỗi lần đánh xong đều toát rất nhiều mồ hôi, nhưng cơ thể cảm thấy vô cùng sảng khoái.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Thể thao',
    difficulty: 'easy',
  },
  {
    id: 'par-14',
    titleZh: '初次去中国旅行',
    titleVi: 'Lần đầu đi du lịch Trung Quốc',
    hanzi: '去年夏天我和家人坐飞机去北京旅游。我们爬上了雄伟的长城，还游览了故宫。中国古老的历史和美丽的风景给我留下了深刻的印象。',
    pinyin: 'Qùnián xiàtiān wǒ hé jiārén zuò fēijī qù Běijīng lǚyóu. Wǒmen pá shàng le xióngwěi de chángchéng, hái yóulǎn le gùgōng. Zhōngguó gǔlǎo de lìshǐ hé měilì de fēngjǐng gěi wǒ liúxià le shēnkè de yìnxiàng.',
    meaning: 'Mùa hè năm ngoái tôi cùng gia đình đi máy bay đến Bắc Kinh du lịch. Chúng tôi đã leo lên Vạn Lý Trường Thành hùng vĩ, và còn tham quan Cố Cung. Lịch sử cổ kính cùng phong cảnh tươi đẹp của Trung Quốc đã để lại ấn tượng sâu sắc trong tôi.',
    mode: 'paragraph',
    level: 'Sơ cấp',
    category: 'Du lịch',
    difficulty: 'easy',
  },

  // 10 ĐOẠN TRUNG CẤP (par-15 đến par-24, HSK 3-4, 75-120 chữ)
  {
    id: 'par-15',
    titleZh: '培养坚持阅读的好习惯',
    titleVi: 'Rèn luyện thói quen kiên trì đọc sách',
    hanzi: '阅读是开阔视野、丰富内心世界的最好途径。无论工作或学习有多么忙碌，我都坚持在睡前阅读半小时。书本不仅教会我思考问题的新角度，更让我在喧嚣的生活中找到内心的宁静与力量。',
    pinyin: 'Yuèdú shì kāikuò shìyě, fēngfù nèixīn shìjiè de zuì hǎo tújìng. Wúlùn gōngzuò huò xuéxí yǒu duōme mánglù, wǒ dōu jiānchí zài shuìqián yuèdú bàn xiǎoshí. Shūběn bùjǐn jiàohuì wǒ sīkǎo wèntí de xīn jiǎodù, gèng ràng wǒ zài xuānxiāo de shēnghuó zhōng zhǎodào nèixīn de níngjìng hé lìliang.',
    meaning: 'Đọc sách là con đường tốt nhất để mở rộng tầm nhìn và bồi đắp thế giới nội tâm. Dù công việc hay học tập có bận rộn đến đâu, tôi vẫn kiên trì đọc sách nửa tiếng trước khi đi ngủ. Sách không chỉ dạy tôi góc nhìn mới khi suy ngẫm, mà còn giúp tôi tìm thấy sự tĩnh lặng và sức mạnh nội tâm giữa cuộc sống ồn ào.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Phát triển bản thân',
    difficulty: 'medium',
  },
  {
    id: 'par-16',
    titleZh: '快节奏城市中的慢生活',
    titleVi: 'Lối sống chậm giữa lòng đô thị hối hả',
    hanzi: '现代城市的节奏越来越快，许多人每天都在为生活奔波。偶尔放慢脚步，坐在街角的咖啡馆里，看着窗外来来往往的行人，品尝一杯香浓的热咖啡，也是一种难得的享受。生活不仅有工作，还有诗和远方。',
    pinyin: 'Xiàndài chéngshì de jiézòu yuèláiyuè kuài, xǔduō rén měitiān dōu zài wèi shēnghuó bēnbō. Ǒu\'ěr fàngmàn jiǎobù, zuò zài jiējiǎo de kāfēiguǎn lǐ, kànzhe chuāngwài láilái-wǎngwǎng de xíngrén, pǐncháng yì bēi xiāngnóng de rè kāfēi, yě shì yì zhǒng nándé de xiǎngshòu. Shēnghuó bùjǐn yǒu gōngzuò, hái yǒu shī hé yuǎnfāng.',
    meaning: 'Nhịp sống của đô thị hiện đại ngày càng hối hả, biết bao người mỗi ngày đều tất bật mưu sinh. Thi thoảng sống chậm lại, ngồi tại một quán cà phê nơi góc phố, ngắm nhìn dòng người qua lại ngoài khung cửa, thưởng thức tách cà phê nóng thơm lừng, cũng là một niềm vui tao nhã hiếm có. Cuộc sống không chỉ có công việc, mà còn có thi ca và những chân trời xa xôi.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Đời sống',
    difficulty: 'medium',
  },
  {
    id: 'par-17',
    titleZh: '真挚友谊的珍贵价值',
    titleVi: 'Giá trị quý báu của tình bạn chân thành',
    hanzi: '真正的朋友就像黑夜里的明灯，在你迷茫无助时指引方向。他们不仅愿意与你分享成功的喜悦，更会在你遭遇挫折时伸出援手。友谊需要用真心去呵护，经历过岁月洗礼的情谊才会愈发醇厚。',
    pinyin: 'Zhēnzhèng de péngyou jiù xiàng hēiyè lǐ de míngdēng, zài nǐ mímáng wúzhù shí zhǐyǐn fāngxiàng. Tāmen bùjǐn yuànyì yǔ nǐ fēnxiǎng chénggōng de xǐyuè, gèng huì zài nǐ zāoyù cuòzhé shí shēnchū yuánshǒu. Yǒuyì xūyào yòng zhēnxīn qù hēhù, jīnglì guò suìyuè xǐlǐ de qíngyì cái huì yùfā chúnhòu.',
    meaning: 'Người bạn thực sự tựa như ngọn đèn soi sáng trong đêm tối, chỉ đường dẫn lối lúc bạn lạc lối và bơ vơ. Họ không chỉ sẵn lòng sẻ chia niềm vui thành công cùng bạn, mà còn đưa tay tương trợ khi bạn gặp trắc trở. Tình bạn cần được nâng niu bằng sự chân thành, tình cảm trải qua thử thách của thời gian mới càng thêm nồng đượm.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Tình cảm',
    difficulty: 'medium',
  },
  {
    id: 'par-18',
    titleZh: '绿色出行与环境保护',
    titleVi: 'Di chuyển xanh và bảo vệ môi trường',
    hanzi: '随着环保意识的提高，越来越多的人开始选择公共交通或者骑自行车出行。低碳生活不仅能减少空气污染，还能缓解城市交通拥堵。保护我们赖以生存的地球家园，需要每一个人从身边的每一件小事做起。',
    pinyin: 'Suízhe huánbǎo yìshí de tígāo, yuèláiyuè duō de rén kāishǐ xuǎnzé gōnggòng jiāotōng huòzhě qí zìxíngchē chūxíng. Dītàn shēnghuó bùjǐn néng jiǎnshǎo kōngqì wūrǎn, hái néng huǎnjiě chéngshì jiāotōng yōngdǔ. Bǎohù wǒmen làiyǐ shēngcún de dìqiú jiāyuán, xūyào měi yí gè rén cóng shēnbiān de měi yí jiàn xiǎoshì zuòqǐ.',
    meaning: 'Cùng với ý thức bảo vệ môi trường ngày càng nâng cao, ngày càng có nhiều người lựa chọn đi lại bằng phương tiện công cộng hoặc xe đạp. Lối sống giảm phát thải carbon không chỉ giảm ô nhiễm không khí, mà còn xoa dịu tình trạng ùn tắc giao thông đô thị. Bảo vệ mái nhà trái đất của chúng ta cần mỗi người bắt đầu từ những hành động nhỏ nhất bên mình.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Môi trường',
    difficulty: 'medium',
  },
  {
    id: 'par-19',
    titleZh: '旅行的真正意义',
    titleVi: 'Ý nghĩa thực sự của những chuyến đi',
    hanzi: '旅行不仅仅是从一个地方去到另一个地方，更是一场探索未知世界的心灵之旅。走过不同的山川河流，体验不同的民俗文化，品尝各地的风味美食，能让我们学会包容与理解，更加热爱生活的美好。',
    pinyin: 'Lǚxíng bù jǐnjǐn shì cóng yí gè dìfang qù dào lìng yí gè dìfang, gèng shì yì chǎng tànsuǒ wèizhī shìjiè de xīnlíng zhī lǚ. Zǒu guò bùtóng de shānchuān héliú, tǐyàn bùtóng de mínsú wénhuà, pǐncháng gèdì de fēngwèi měishí, néng ràng wǒmen xuéhuì bāoróng hé lǐjiě, gèngjiā rè\'ài shēnghuó de měihǎo.',
    meaning: 'Đi du lịch không đơn thuần chỉ là di chuyển từ nơi này đến nơi khác, mà còn là một hành trình tâm hồn khám phá thế giới rộng mở. Đi qua những non sông gấm vóc khác nhau, trải nghiệm những nền văn hóa phong tục tập quán phong phú, thưởng thức phong vị ẩm thực các vùng miền giúp chúng ta học được sự bao dung và thấu hiểu, thêm yêu nét đẹp của cuộc đời.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Du lịch',
    difficulty: 'medium',
  },
  {
    id: 'par-20',
    titleZh: '健康饮食的黄金法则',
    titleVi: 'Quy tắc vàng của chế độ ăn uống lành mạnh',
    hanzi: '保持身体健康的基础在于均衡的日常膳食。少吃高油高糖的垃圾食品，多吃新鲜的蔬菜、水果以及粗粮。此外，规律的三餐时间和充足的水分摄入，也是维持身体良好新陈代谢不可或缺的要素。',
    pinyin: 'Bǎochí shēntǐ jiànkāng de jīchǔ zàiyú jūnhéng de rìcháng shànshí. Shǎo chī gāo yóu gāo táng de lājī shípǐn, duō chī xīnxiān de shūcài, shuǐguǒ yǐjí cūliáng. Cǐwài, guīlǜ de sāncān shíjiān hé chōngzú de shuǐfèn shèrù, yě shì wéichí shēntǐ liánghǎo xīnméchéndàixiè bùkě huòquē de yàosù.',
    meaning: 'Nền tảng của một cơ thể khỏe mạnh nằm ở chế độ dinh dưỡng hàng ngày cân đối. Bớt ăn đồ ăn nhanh nhiều dầu mỡ và đường, tăng cường ăn nhiều rau xanh tươi, hoa quả cùng các loại ngũ cốc thô. Ngoài ra, việc ăn uống điều độ đúng giờ và uống đủ nước cũng là những yếu tố không thể thiếu để duy trì quá trình trao đổi chất của cơ thể.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Sức khỏe',
    difficulty: 'medium',
  },
  {
    id: 'par-21',
    titleZh: '音乐治愈心灵的力量',
    titleVi: 'Sức mạnh xoa dịu tâm hồn của âm nhạc',
    hanzi: '音乐是没有国界的语言，能够跨越时空直击人们的心灵。当我们感到身心疲惫时，一首轻柔舒缓的乐曲可以抚平内心的焦虑；而激情澎湃的旋律，则能重新点燃我们面对生活挑战的斗志与希望。',
    pinyin: 'Yīnyuè shì méiyǒu guójiè de yǔyán, nénggòu kuàyuè shíkōng zhíjī rénmen de xīnlíng. Dāng wǒmen gǎndào shēnxīn píbèi shí, yì shǒu qīngróu shūhuǎn de yuèqǔ kěyǐ fǔpíng nèixīn de jiāolǜ; ér jīqíng péngpài de xuánlǜ, zé néng chóngxīn diǎnrán wǒmen miànduì shēnghuó tiǎozhàn de dòuzhì hé xīwàng.',
    meaning: 'Âm nhạc là ngôn ngữ không biên giới, có thể vượt qua không gian và thời gian để chạm tới trái tim con người. Khi chúng ta cảm thấy mệt mỏi rã rời, một giai điệu êm dịu có thể xoa dịu sự âu lo; còn những khúc ca sôi động hào hùng lại thắp lên ngọn lửa ý chí và hy vọng để đối mặt với thử thách cuộc sống.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Nghệ thuật',
    difficulty: 'medium',
  },
  {
    id: 'par-22',
    titleZh: '中秋团圆的文化温情',
    titleVi: 'Nét ấm áp của ngày Tết Trung thu sum vầy',
    hanzi: '中秋节是中华民族最重要的传统节日之一。每逢八月十五，圆月高悬，远方的游子都会尽可能赶回家中与亲人团聚。大家围坐在一起吃月饼、赏明月，寄托着对美好生活和家庭和睦的深深期盼。',
    pinyin: 'Zhōngqiūjié shì zhōnghuá mínzú zuì zhòngyào de chuántǒng jiérì zhīyī. Měi féng bā yuè shíwǔ, yuányuè gāoxuán, yuǎnfāng de yóuzǐ dōu huì jǐnkěnéng gǎn huí jiā zhōng yǔ qīnrén tuánjù. Dàjiā wéizuò zài yìqǐ chī yuèbǐng, shǎng míngyuè, jìtuō zhe duì měihǎo shēnghuó hé jiātíng hémù de shēnshēn qīpàn.',
    meaning: 'Tết Trung thu là một trong những ngày lễ truyền thống quan trọng nhất của dân tộc Trung Hoa. Cứ mỗi rằm tháng tám, trăng tròn vằng vặc trên cao, những người con xa quê đều gắng về nhà đoàn tụ cùng gia đình. Mọi người quây quần bên nhau thưởng thức bánh trung thu, ngắm trăng sáng, gửi gắm ước nguyện sâu sắc về cuộc sống ấm no và gia đình hòa thuận.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Văn hóa',
    difficulty: 'medium',
  },
  {
    id: 'par-23',
    titleZh: '高效时间管理的秘诀',
    titleVi: 'Bí quyết quản lý thời gian hiệu quả',
    hanzi: '时间是世界上最公平的资源，每个人的一天都只有二十四小时。善于管理时间的人，总是能把重要的事情排在前面，分清轻重缓急，避免拖延。制定清晰的计划并严格执行，是走向成功的重要基石。',
    pinyin: 'Shíjiān shì shìjiè shàng zuì gōngpíng de zīyuán, měi gè rén de yì tiān dōu zhǐ yǒu èrshísì xiǎoshí. Shànyú guǎnlǐ shíjiān de rén, zǒngshì néng bǎ zhòngyào de shìqing pái zài qiánmiàn, fēnqīng qīngzhòng-huǎnjí, bìmǐan tuōyán. Zhìdìng qīngxī de jìhuà bìng yángé zhíxíng, shì zǒuxiàng chénggōng de zhòngyào jīshí.',
    meaning: 'Thời gian là tài nguyên công bằng nhất trên thế giới, mỗi người một ngày đều chỉ có 24 giờ. Người giỏi quản lý thời gian luôn biết xếp những việc trọng đại lên trước, phân biệt rõ điều gì khẩn cấp điều gì cốt lõi, tránh trì hoãn. Lên kế hoạch rõ ràng và nghiêm túc thực hiện là viên đá nền tảng đưa ta tới thành công.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Kỹ năng',
    difficulty: 'medium',
  },
  {
    id: 'par-24',
    titleZh: '数字科技如何改变生活',
    titleVi: 'Công nghệ số thay đổi đời sống thế nào',
    hanzi: '移动支付、智能手机和高速网络已经彻底改变了我们的日常生活。如今出门只要带上一部手机，就能轻松解决乘车、就餐、购物等各种需求。科技的发展不仅带来了巨大的便利，更推动着整个社会的进步。',
    pinyin: 'Yídòng zhīfù, zhìnéng shǒujī hé gāosù wǎngluò yǐjīng chèdǐ gǎibiàn le wǒmen de rìcháng shēnghuó. Rújīn chūmén zhǐyào dài shàng yí bù shǒujī, jiù néng qīngsōng jiějué chéngchē, jiùcān, gòuwù děng gèzhǒng xūqiú. Kējì de fāzhǎn bùjǐn dàilái le jùdà de biànlì, gèng tuīdòng zhe zhěng gè shèhuì de jìnbù.',
    meaning: 'Thanh toán di động, điện thoại thông minh và mạng tốc độ cao đã thay đổi hoàn toàn sinh hoạt hằng ngày của chúng ta. Ngày nay ra khỏi nhà chỉ cần cầm theo một chiếc điện thoại là có thể dễ dàng giải quyết việc đi xe, ăn uống, mua sắm. Sự phát triển của công nghệ không chỉ mang lại tiện ích to lớn mà còn thúc đẩy xã hội không ngừng tiến bước.',
    mode: 'paragraph',
    level: 'Trung cấp',
    category: 'Công nghệ',
    difficulty: 'medium',
  },

  // 10 ĐOẠN NÂNG CAO (par-25 đến par-34, HSK 5-6, 120-180 chữ)
  {
    id: 'par-25',
    titleZh: '中国书法中的生命气韵',
    titleVi: 'Khí vận sinh mệnh trong nghệ thuật Thư pháp Trung Hoa',
    hanzi: '中国书法绝不仅仅是一种汉字书写的技能，它更是中华哲学思想与审美情趣的深层载体。在一张素净的宣纸上，墨随笔动，浓淡干湿皆成意境。书法家通过线条的疾徐顿挫、提按转折，将自身的精神气质与天地万物的生生不息融为一体，达到了天人合一的高尚境界。',
    pinyin: 'Zhōngguó shūfǎ jué bù jǐnjǐn shì yì zhǒng hànzì shūxiě de jìnéng, tā gèng shì zhōnghuá zhéxué sīxiǎng yǔ shěnměi qíngqù de shēncéng zàitǐ. Zài yì zhāng sùjìng de xuānzhǐ shàng, mò suí bǐ dòng, nóng dàn gān shī jiē chéng yìjìng. Shūfǎjiā tōngguò xiàntiáo de jí xú dùn cuò, tí àn zhuǎn zhé, jiāng zìshēn de jīngshén qìzhì yǔ tiāndì wànwù de shēngshēng-bùxī róng wéi yītǐ, dádào le tiānrén-héyī de gāoshàng jìngjiè.',
    meaning: 'Thư pháp Trung Hoa tuyệt nhiên không chỉ là kỹ năng viết chữ Hán, mà còn là kết tinh sâu xa của tư tưởng triết học và thị hiếu thẩm mỹ phương Đông. Trên trang giấy tuyên thanh tao, mực chảy theo nét bút, nét đậm nhạt khô ướt đều hóa thành cảnh giới thi ca. Người nghệ sĩ thư pháp qua nhịp điệu nhanh chậm, nhấn nhả chuyển gập của đường nét, hòa quyện khí chất bản thân cùng nhịp sống bất tận của vạn vật, chạm đến cảnh giới Thiên Nhân Hợp Nhất cao thượng.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Nghệ thuật',
    difficulty: 'hard',
  },
  {
    id: 'par-26',
    titleZh: '人工智能时代的人文思考',
    titleVi: 'Suy ngẫm nhân văn trong thời đại Trí tuệ nhân tạo',
    hanzi: '随着生成式人工智能和深度学习技术的迅猛演进，机器不仅能够以极高的精度处理海量数据，更在绘画、写作和逻辑推理等领域展现出前所未有的惊人创造力。然而，技术终究是工具，唯有同理心、道德良知以及对生命的敬畏，才是人类独一无二的精神内核。在拥抱科技浪潮的同时，我们必须坚守人性的光辉。',
    pinyin: 'Suízhe shēngchéngshì réngōng zhìnéng hé shēndù xuéxí jìshù de xùnměng yǎnjìn, jīqì bùjǐn nénggòu yǐ jí gāo de jīngdù chǔlǐ hǎiliàng shùjù, gèng zài huìhuà, xiězuò hé luóji tuīlǐ děng lǐngyù zhǎnxiàn chū qiánsuǒwèiyǒu de jīngrén chuàngzàolì. Rán\'ér, jìshù zhōngjiù shì gōngjù, wéiyǒu tónglǐxīn, dàodé liángzhī yǐjí duì shēngmìng de jìngwèi, cái shì rénlèi dúyīwú\'èr de jīngshén nèihé. Zài yōngbào kējì làngcháo de tóngshí, wǒmen bìxū jiānshǒu rénxìng de guānghuī.',
    meaning: 'Cùng với sự phát triển thần tốc của trí tuệ nhân tạo tạo sinh và học sâu, máy móc không chỉ xử lý khối lượng dữ liệu khổng lồ với độ chuẩn xác tuyệt vời, mà còn biểu lộ sức sáng tạo đáng kinh ngạc trong hội họa, văn chương và lập luận logic. Thế nhưng công nghệ rốt cuộc vẫn là công cụ; chỉ có lòng thấu cảm, lương tri đạo đức và sự trân quý sinh mệnh mới là cốt lõi tinh thần độc nhất vô nhị của con người. Giữa làn sóng công nghệ dâng trào, chúng ta càng cần giữ gìn vầng sáng nhân tính.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Công nghệ',
    difficulty: 'hard',
  },
  {
    id: 'par-27',
    titleZh: '老子道法自然与现代生态',
    titleVi: 'Triết lý Đạo pháp tự nhiên của Lão Tử và sinh thái hiện đại',
    hanzi: '中国古代哲学家老子在《道德经》中提出了“道法自然”的深刻智慧，主张人类应当尊重自然规律，与天地万物和谐共生。面对当今全球气候变暖、资源短缺等一系列生态环境危机，这种主张顺应天时、节制欲望的古老东方哲学，正在为全人类探索可持续发展路径提供着宝贵的启示。',
    pinyin: 'Zhōngguó gǔdài zhéxuéjiā Lǎozǐ zài 《Dàodéjīng》 zhōng tíchū le "dào fǎ zìrán" de shēnkè zhìhuì, zhǔzhāng rénlèi yīngdāng zūnzhòng zìrán guīlǜ, yǔ tiāndì wànwù héxié gòngshēng. Miànduì dāngjīn quánqiú qìhòu biànnuǎn, zīyuán duǎnquē děng yí xìliè shēngtài huánjìng wēijī, zhè zhǒng zhǔzhāng shùnyìng tiānshí, jiézhì yùwàng de gǔlǎo dōngfāng zhéxué, zhèngzài wèi quán rénlèi tànsuǒ kěchíxù fāzhǎn lùjìng tígōng zhe bǎoguì de qǐshì.',
    meaning: 'Nhà triết học cổ đại Trung Hoa Lão Tử trong tác phẩm Đạo Đức Kinh đã đưa ra minh triết sâu sắc “Đạo pháp tự nhiên”, chủ trương con người cần tôn trọng quy luật tự nhiên, hòa hợp cùng vạn vật. Đối diện với cuộc khủng hoảng sinh thái toàn cầu như biến đổi khí hậu hay cạn kiệt tài nguyên hiện nay, triết lý phương Đông cổ xưa này đang cung cấp những gợi mở vô giá cho nhân loại trên con đường phát triển bền vững.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Triết học',
    difficulty: 'hard',
  },
  {
    id: 'par-28',
    titleZh: '沉淀心境与专注的力量',
    titleVi: 'Lắng đọng tâm trí và sức mạnh của sự chú tâm',
    hanzi: '在信息泛滥、诱惑无处不在的当今社会，专注力已经成为一种极为稀缺而宝贵的核心竞争力。只有当我们学会屏蔽外界纷繁复杂的噪音，戒除内心的浮躁与焦虑，全身心地投入到眼前所热爱的目标中去，我们才能在日复一日的沉淀中打磨出过硬的本领，成就卓越的人生。',
    pinyin: 'Zài xìnxī fànlàn, yòuhuò wú chù bù zài de dāngjīn shèhuì, zhuānzhùlì yǐjīng chéngwéi yì zhǒng jíwéi xīquē ér bǎoguì de héxīn jìngzhēnglì. Zhǐyǒu dāng wǒmen xuéhuì píngbì wàijiè fēnfán-fùzá de zàoyīn, jièchú nèixīn de fúzào yǔ jiāolǜ, quánshēn-xīndì tóurù dào yǎnqián suǒ rè\'ài de mùbiāo zhōng qù, wǒmen cái néng zài rì fù yí rì de chéndiàn zhōng dǎmó chū guòyìng de běnlǐng, chéngjiù zhuóyuè de rénshēng.',
    meaning: 'Trong một xã hội bùng nổ thông tin và đầy cám dỗ như hiện nay, sự tập trung đã trở thành một năng lực cạnh tranh cốt lõi vô cùng khan hiếm và quý giá. Chỉ khi chúng ta học được cách ngăn chặn tạp âm hỗn loạn bên ngoài, gột sạch nỗi âu lo nôn nóng, toàn tâm toàn ý dấn thân vào mục tiêu mình ấp ủ, ta mới có thể tôi luyện bản lĩnh vững vàng qua năm tháng và kiến tạo nên một cuộc đời kiệt xuất.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Tư duy',
    difficulty: 'hard',
  },
  {
    id: 'par-29',
    titleZh: '丝绸之路与跨文化交流互鉴',
    titleVi: 'Con đường Tơ lụa và sự giao lưu văn hóa Đông Tây',
    hanzi: '古老的丝绸之路横跨欧亚大陆，绵延数千里，见证了东西方文明两千多年的交往与融合。伴随着丝绸、瓷器、茶叶的贸易流通，哲学、科学、艺术等多元文化形态在漫长的岁月里彼此碰撞与滋养。历史生动地证明：唯有开放包容、互利互惠的文明交流，才能推动人类社会的繁荣发展。',
    pinyin: 'Gǔlǎo de sīchóuzhīlù héngkuà ōuyà dàlù, miányán shù qiān lǐ, jiànzhèng le dōng-xīfāng wénmíng liǎng qiān duō nián de jiāowǎng yǔ rónghé. Bànsuí zhe sīchóu, cíqì, cháyè de màoyì liútōng, zhéxué, kēxué, yìshù děng duōyuán wénhuà xíngtài zài màncháng de suìyuè lǐ bǐcǐ pèngzhuàng yǔ zīyǎng. Lìshǐ shēngdòng de zhèngmíng: wéiyǒu kāifàng bāoróng, hùlì-hùhuì de wénmíng jiāoliú, cái néng tuīdòng rénlèi shèhuì de fánróng fāzhǎn.',
    meaning: 'Con đường Tơ lụa cổ đại vắt ngang đại lục Á - Âu, trải dài hàng ngàn dặm, chứng kiến hơn hai nghìn năm giao lưu hòa quyện giữa các nền văn minh Đông - Tây. Cùng dòng chảy tơ lụa, đồ gốm sứ và lá trà, những tư tưởng triết học, khoa học và nghệ thuật đa dạng đã không ngừng bồi đắp cho nhau. Lịch sử chứng minh rằng: chỉ có sự giao lưu cởi mở, bao dung và cùng có lợi mới đưa xã hội loài người đến phồn vinh.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Lịch sử',
    difficulty: 'hard',
  },
  {
    id: 'par-30',
    titleZh: '水滴石穿与持之以恒的毅力',
    titleVi: 'Nước chảy đá mòn và nghị lực kiên trì bền bỉ',
    hanzi: '“滴水穿石，非一日之功。”世间任何伟大的成就，从来都不是一蹴而就的奇迹，而是日积月累、脚踏实地奋斗的结果。在漫长的人生旅途中，我们难免会遭遇狂风骤雨和重重险阻。但只要我们咬定青山不放松，凭借着坚韧不拔的毅力默默耕耘，终将迎来属于自己的春暖花开。',
    pinyin: '“Dī shuǐ chuān shí, fēi yí rì zhī gōng.” Shìjiān rènhé wěidà de chéngjiù, cónglái dōu bú shì yí cù ér jiù de qíjì, ér shì rì jī yuè lěi, jiǎotà-shídì fèndòu de jiéguǒ. Zài màncháng de rénshēng lǚtú zhōng, wǒmen nánmiǎn huì zāoyù kuángfēng-zhòuyǔ hé chóngchóng xiǎnzǔ. Dàn zhǐyào wǒmen yǎodìng qīngshān bù fàngsōng, píngjiè zhe jiānrèn-bùbá de yìlì mòmò gēngyún, zhōng jiāng yínglái shǔyú zìjǐ de chūnnuǎn-huākāi.',
    meaning: '“Nước chảy đá mòn, chẳng phải công một ngày.” Mọi thành tựu vĩ đại trên thế gian chưa bao giờ là phép màu một sớm một chiều, mà là trái ngọt của sự tích lũy bền bỉ và nỗ lực vững chãi từng bước. Trên đường đời muôn dặm, ta khó tránh khỏi phong ba bão táp cùng trùng trùng hiểm nguy. Nhưng chỉ cần lòng kiên định không dời, âm thầm gieo hạt với ý chí sắt đá, rồi cũng sẽ đón mùa xuân hoa nở rạng rỡ của riêng mình.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Triết lý sống',
    difficulty: 'hard',
  },
  {
    id: 'par-31',
    titleZh: '乡愁记忆与故土深情',
    titleVi: 'Ký ức hoài niệm và ân tình với cố hương',
    hanzi: '故乡是每个人灵魂深处永远的精神港湾。哪怕脚步走得再遥远，看过了世界各地的繁华盛景，童年门前的那条清澈小溪、老槐树下母亲温暖的呼唤，依然是梦中最鲜活的羁绊。乡愁不仅是一张小小的船票，更是流淌在血液里无论何时都无法割舍的血脉深情与文化根脉。',
    pinyin: 'Gùxiāng shì měi gè rén línghún shēnchù yǒngyuǎn de jīngshén gǎngwān. Nǎpà jiǎobù zǒu de zài yáoyuǎn, kàn guò le shìjiè gèdì de fánhuá shèngjǐng, tóngnián ménqián de nà tiáo qīngchè xiǎoxī, lǎo huáishù xià mǔqīn wēnnuǎn de hūhuàn, yīrán shì mèng zhōng zuì xiānhuó de jībàn. Xiāngchóu bùjǐn shì yì zhāng xiǎoxiǎo de chuánpiào, gèng shì liútǎng zài xuèyè lǐ wúlùn héshí dōu wúfǎ gēshě de xuèmài shēnqíng yǔ wénhuà gēnmài.',
    meaning: 'Cố hương luôn là bến đỗ tinh thần sâu thẳm vĩnh viễn trong tâm hồn mỗi người. Dù bước chân có đi xa đến muôn phương, ngắm nhìn bao chốn phồn hoa đô hội, thì dòng suối trong vắt trước ngõ tuổi thơ cùng tiếng gọi ấm áp của mẹ dưới gốc hòe già vẫn là vương vấn sống động nhất trong giấc mơ. Nỗi nhớ quê không chỉ là mảnh vé tàu bé nhỏ, mà là mạch nguồn văn hóa và ân tình cốt nhục chẳng thể cắt rời.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Quê hương',
    difficulty: 'hard',
  },
  {
    id: 'par-32',
    titleZh: '怀抱感恩的心态去拥抱生活',
    titleVi: 'Mang trái tim biết ơn để ôm trọn cuộc đời',
    hanzi: '懂得感恩是一种极其深沉的生命智慧。感恩清晨洒向窗台的第一缕阳光，感恩逆境中伸出援手的每一位同行者，甚至感恩生活给予我们的磨难与挫折，因为正是那些痛楚促使我们破茧成蝶。一个心怀感恩的人，无论身处怎样的处境，眼中总能发现世间最动人的美好与诗意。',
    pinyin: 'Dǒngdé gǎn\'ēn shì yì zhǒng jíqí shēncén de shēngmìng zhìhuì. Gǎn\'ēn qīngchén sǎ xiàng chuāngtái de dì-yī lǚ yángguāng, gǎn\'ēn nìjìng zhōng shēnchū yuánshǒu de měi yí wèi tóngxíngzhě, shènzhì gǎn\'ēn shēnghuó jǐyǔ wǒmen de mónàn yǔ cuòzhé, yīnwèi zhèng shì nàxiē tòngchǔ cùshǐ wǒmen pòjiǎn-chéngdié. Yí gè xīnhuái gǎn\'ēn de rén, wúlùn shēnchǔ zěnyàng de chǔjìng, yǎn zhōng zǒng néng fāxiàn shìjiān zuì dòngrén de měihǎo yǔ shīyì.',
    meaning: 'Biết ơn là một minh triết sống vô cùng sâu sắc. Biết ơn tia nắng đầu tiên rọi qua khung cửa sổ sớm mai, biết ơn từng người bạn đồng hành đã dang tay nâng đỡ giữa nghịch cảnh, và biết ơn cả những gian truân trắc trở mà cuộc đời thử thách, bởi chính nỗi đau đó thôi thúc ta hóa kén thành bướm. Người có tấm lòng biết ơn, dù ở hoàn cảnh nào, cũng luôn nhìn thấy vẻ đẹp và chất thơ lay động lòng người.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Tư duy',
    difficulty: 'hard',
  },
  {
    id: 'par-33',
    titleZh: '终身学习与认知升级',
    titleVi: 'Học tập suốt đời và nâng cấp nhận thức',
    hanzi: '当今世界正处于知识以前所未有速度裂变重塑的时代。传统的学校教育仅仅是人生的起点，而持续不懈的终身学习才是应对未来一切不确定性的制胜法宝。勇于跳出自我认知的舒适圈，不断重构自身的知识体系与思维模型，我们才能与时代同频共振，实现自我价值的持续跃迁。',
    pinyin: 'Dāngjīn shìjiè zhèng chǔyú zhīshi yǐ qiánsuǒwèiyǒu sùdù lièbiàn chóngsù de shídài. Chuántǒng de xuéxiào jiàoyù jǐnjǐn shì rénshēng de qǐdiǎn, ér chíxù búxiè de zhōngshēn xuéxí cái shì yìngduì wèilái yíqiè bùquèdìngxìng de zhìshèng fǎbǎo. Yǒngyú tiàochū zìwǒ rènzhī de shūshìquān, búduàn chónggòu zìshēn de zhīshi tǐxì yǔ sīwéi móxíng, wǒmen cái néng yǔ shídài tóngpín-gòngzhèn, shíxiàn zìwǒ jiàzhí de chíxù yuèqiān.',
    meaning: 'Thế giới hôm nay đang ở kỷ nguyên mà tri thức phân rã và tái cấu trúc với tốc độ chưa từng có. Giáo dục nhà trường truyền thống mới chỉ là điểm khởi đầu, còn việc học tập suốt đời không ngừng nghỉ mới là pháp bảo chiến thắng để đương đầu với mọi bất định tương lai. Dũng cảm bước ra khỏi vùng an toàn của nhận thức, liên tục tái thiết lập hệ thống tri thức và mô hình tư duy, ta mới có thể hòa cùng nhịp đập thời đại và hiện thực hóa những bước nhảy vọt của bản thân.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Phát triển bản thân',
    difficulty: 'hard',
  },
  {
    id: 'par-34',
    titleZh: '勇敢追逐心中的星辰大海',
    titleVi: 'Dũng cảm theo đuổi muôn trùng vì sao và biển lớn',
    hanzi: '每个人年轻的时候，心中都藏着对星辰大海的无尽向往。通往梦想的道路往往布满荆棘与坎坷，唯有真正勇敢的人敢于扬帆启航，直面未知的风浪。请相信，那些在黑暗中默默积蓄的力量，终将在破晓的时刻绽放出璀璨夺目的光芒，照亮我们无悔前行的辉煌征程。',
    pinyin: 'Měi gè rén niánqīng de shíhou, xīn zhōng dōu cáng zhe duì xīngchén-dàhǎi de wújìn xiàngwǎng. Tōngwǎng mèngxiǎng de dàolù wǎngwǎng bùmǎn jīngjí yǔ kǎnkě, wéiyǒu zhēnzhèng yǒnggǎn de rén gǎnyú yángfān qǐháng, zhímiàn wèizhī de fēnglàng. Qǐng xiāngxìn, nàxiē zài hēi\'àn zhōng mòmò jīxù de lìliang, zhōng jiāng zài pòxiǎo de shíkè zhànfàng chū cuǐcàn-duómù de guāngmáng, zhàoliàng wǒmen wúhuǐ qiánxíng de huīhuáng zhēngchéng.',
    meaning: 'Mỗi người lúc trẻ tuổi, trong tim đều ấp ủ niềm khát khao vô tận hướng về ngàn sao và biển lớn. Con đường đi tới ước mơ thường phủ đầy chông gai và trắc trở, chỉ những ai thực sự dũng cảm mới dám dong buồm ra khơi, đối diện với sóng to gió lớn khôn lường. Hãy tin rằng những sức mạnh âm thầm tích lũy trong đêm tối rồi sẽ bừng nở hào quang rực rỡ lúc bình minh, soi sáng hành trình quang vinh không hề hối tiếc.',
    mode: 'paragraph',
    level: 'Nâng cao',
    category: 'Truyền cảm hứng',
    difficulty: 'hard',
  },
];

// 4. Chế độ 4: Luyện gõ theo HSK (HSK 1 - 6)
export const hskExercises: TypingExercise[] = [
  // HSK 1
  {
    id: 'hsk1-1',
    hanzi: '我是越南人，我学汉语。',
    pinyin: 'Wǒ shì yuènán rén, wǒ xué hànyǔ.',
    meaning: 'Tôi là người Việt Nam, tôi học tiếng Hán.',
    mode: 'hsk',
    hskLevel: 1,
    level: 'HSK 1',
    difficulty: 'easy',
  },
  {
    id: 'hsk1-2',
    hanzi: '他是我的好朋友。',
    pinyin: 'Tā shì wǒ de hǎo péngyou.',
    meaning: 'Cậu ấy là người bạn tốt của tôi.',
    mode: 'hsk',
    hskLevel: 1,
    level: 'HSK 1',
    difficulty: 'easy',
  },
  {
    id: 'hsk1-3',
    hanzi: '桌子上有一本书和一个杯子。',
    pinyin: 'Zhuōzi shàng yǒu yì běn shū hé yí gè bēizi.',
    meaning: 'Trên bàn có một quyển sách và một chiếc cốc.',
    mode: 'hsk',
    hskLevel: 1,
    level: 'HSK 1',
    difficulty: 'easy',
  },

  // HSK 2
  {
    id: 'hsk2-1',
    hanzi: '请进，外面太冷了。',
    pinyin: 'Qǐng jìn, wàimiàn tài lěng le.',
    meaning: 'Mời vào, bên ngoài lạnh quá.',
    mode: 'hsk',
    hskLevel: 2,
    level: 'HSK 2',
    difficulty: 'easy',
  },
  {
    id: 'hsk2-2',
    hanzi: '从我家到学校需要坐十分钟公交车。',
    pinyin: 'Cóng wǒ jiā dào xuéxiào xūyào zuò shí fēnzhōng gōngjiāochē.',
    meaning: 'Từ nhà tôi đến trường cần đi xe buýt mười phút.',
    mode: 'hsk',
    hskLevel: 2,
    level: 'HSK 2',
    difficulty: 'easy',
  },
  {
    id: 'hsk2-3',
    hanzi: '这件衣服颜色很漂亮，但是有点贵。',
    pinyin: 'Zhè jiàn yīfu yánsè hěn piàoliang, dànshì yǒudiǎn guì.',
    meaning: 'Bộ quần áo này màu sắc rất đẹp, nhưng hơi đắt.',
    mode: 'hsk',
    hskLevel: 2,
    level: 'HSK 2',
    difficulty: 'easy',
  },

  // HSK 3
  {
    id: 'hsk3-1',
    hanzi: '遇到困难时，不要轻易放弃努力。',
    pinyin: 'Yù dào kùnnan shí, bú yào qīngyì fàngqì nǔlì.',
    meaning: 'Khi gặp khó khăn, đừng dễ dàng từ bỏ nỗ lực.',
    mode: 'hsk',
    hskLevel: 3,
    level: 'HSK 3',
    difficulty: 'medium',
  },
  {
    id: 'hsk3-2',
    hanzi: '为了提高口语水平，他经常和中国朋友聊天。',
    pinyin: 'Wèile tígāo kǒuyǔ shuǐpíng, tā jīngcháng hé zhōngguó péngyou liáotiān.',
    meaning: 'Để nâng cao trình độ khẩu ngữ, cậu ấy thường xuyên trò chuyện với bạn người Trung Quốc.',
    mode: 'hsk',
    hskLevel: 3,
    level: 'HSK 3',
    difficulty: 'medium',
  },

  // HSK 4
  {
    id: 'hsk4-1',
    hanzi: '成功往往属于那些坚持到底的人。',
    pinyin: 'Chénggōng wǎngwǎng shǔyú nàxiē jiānchí dàodǐ de rén.',
    meaning: 'Thành công thường thuộc về những người kiên trì đến cùng.',
    mode: 'hsk',
    hskLevel: 4,
    level: 'HSK 4',
    difficulty: 'medium',
  },
  {
    id: 'hsk4-2',
    hanzi: '保护环境不仅关乎现在，更关系到未来的世代。',
    pinyin: 'Bǎohù huánjìng bùjǐn guānhū xiànzài, gèng guānxì dào wèilái de shìdài.',
    meaning: 'Bảo vệ môi trường không chỉ liên quan đến hiện tại, mà còn gắn liền với các thế hệ tương lai.',
    mode: 'hsk',
    hskLevel: 4,
    level: 'HSK 4',
    difficulty: 'medium',
  },

  // HSK 5
  {
    id: 'hsk5-1',
    hanzi: '在这个充满竞争的时代，持续学习是保持个人核心优势的关键。',
    pinyin: 'Zài zhège chōngmǎn jìngzhēng de shídài, chíxù xuéxí shì bǎochí gèrén héxīn yōushì de guānjiàn.',
    meaning: 'Trong thời đại đầy cạnh tranh này, không ngừng học hỏi là chìa khóa duy trì thế mạnh cốt lõi của mỗi cá nhân.',
    mode: 'hsk',
    hskLevel: 5,
    level: 'HSK 5',
    difficulty: 'hard',
  },
  {
    id: 'hsk5-2',
    hanzi: '有效的沟通不仅在于清晰表达自己的观点，更在于倾听对方的真诚想法。',
    pinyin: 'Yǒuxiào de gōutōng bùjǐn zàiyú qīngxī biǎodá zìjǐ de guāndiǎn, gèng zàiyú qīngtīng duìfāng de zhēnchéng xiǎngfǎ.',
    meaning: 'Giao tiếp hiệu quả không chỉ ở việc bày tỏ rõ ràng quan điểm của mình, mà còn ở việc lắng nghe suy nghĩ chân thành của đối phương.',
    mode: 'hsk',
    hskLevel: 5,
    level: 'HSK 5',
    difficulty: 'hard',
  },

  // HSK 6
  {
    id: 'hsk6-1',
    hanzi: '博大精深的传统文化不仅蕴含着先贤的深刻哲思，更指引着现代文明的前进方向。',
    pinyin: 'Bódà jīngshēn de chuántǒng wénhuà bùjǐn yùnhán zhe xiānxián de shēnkè zhésī, gèng zhǐyǐn zhe xiàndài wénmíng de qiánjìn fāngxiàng.',
    meaning: 'Nền văn hóa truyền thống uyên thâm không chỉ ẩn chứa triết lý sâu sắc của tiền nhân, mà còn soi đường chỉ lối cho văn minh hiện đại tiến bước.',
    mode: 'hsk',
    hskLevel: 6,
    level: 'HSK 6',
    difficulty: 'hard',
  },
  {
    id: 'hsk6-2',
    hanzi: '面对瞬息万变的全球化格局，惟有秉持包容互鉴的精神，方能实现互利共赢。',
    pinyin: 'Miànduì shùnxī wànbiàn de quánqiúhuà géjú, wéiyǒu bǐngchí bāoróng hùjiàn de jīngshén, fāng néng shíxiàn hùlì gòngyíng.',
    meaning: 'Đối mặt với cục diện toàn cầu hóa biến chuyển khôn lường, chỉ khi giữ vững tinh thần bao dung học hỏi lẫn nhau, mới có thể cùng thắng cùng hưởng lợi.',
    mode: 'hsk',
    hskLevel: 6,
    level: 'HSK 6',
    difficulty: 'hard',
  },
];

// Tổng hợp toàn bộ bài tập
export const allTypingExercises: TypingExercise[] = [
  ...sentenceExercises,
  ...vocabularyExercises,
  ...paragraphExercises,
  ...hskExercises,
];

export type { HskTypingWord } from './hsk-typing-vocabularies';

// Danh sách các bài học hiện có của cấp HSK (mỗi cấp 10 bài chuẩn)
export function getHskLessonNumbers(_level: number): number[] {
  return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
}

// Bộ lọc bài tập
export interface ExerciseFilter {
  level?: string;
  hskLevel?: number;
  hskLesson?: number;
  hskTarget?: 'word' | 'example';
  category?: string;
}

// Hàm lấy danh sách bài tập theo chế độ
export function getExercisesByMode(mode: TypingMode, filter?: ExerciseFilter): TypingExercise[] {
  let list: TypingExercise[] = [];
  if (mode === 'sentence') list = sentenceExercises;
  else if (mode === 'vocabulary') list = vocabularyExercises;
  else if (mode === 'paragraph') list = paragraphExercises;
  else if (mode === 'hsk') {
    list = hskExercises;
  }

  if (filter?.hskLevel) {
    list = list.filter((item) => item.hskLevel === filter.hskLevel);
  } else if (filter?.level && filter.level !== 'all') {
    list = list.filter((item) => item.level === filter.level);
  }

  if (filter?.category && filter.category !== 'all') {
    list = list.filter((item) => item.category === filter.category);
  }

  return list;
}

// Hàm lấy chi tiết bài tập theo ID
export function getExerciseById(id: string): TypingExercise | undefined {
  return allTypingExercises.find((item) => item.id === id);
}

// Danh mục chủ đề từ vựng
export const vocabularyCategories = [
  'Tất cả',
  'Chào hỏi',
  'Thời gian',
  'Gia đình',
  'Con người',
  'Ăn uống',
  'Mua sắm',
  'Cảm xúc',
  'Tính chất',
  'Sức khỏe',
];
