// Danh mục 149 từ vựng còn thiếu để hoàn thiện 300/300 từ vựng HSK 1 Đề cương thi HSK 3.0 (CTI 11/2025)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt, và 2 câu ví dụ chất lượng cao kèm Pinyin + Dịch tiếng Việt

export interface Hsk1WordItem {
  hanzi: string
  pinyin: string
  word_type: string
  meaning_vi: string
  hsk_level: string
  examples: [
    {
      chinese: string
      pinyin: string
      meaning_vi: string
      difficulty_level: 'basic' | 'applied'
    },
    {
      chinese: string
      pinyin: string
      meaning_vi: string
      difficulty_level: 'basic' | 'applied'
    }
  ]
}

export const HSK1_MISSING_149_WORDS: Hsk1WordItem[] = [
  // --- NHÓM B ---
  {
    hanzi: '边',
    pinyin: 'biān',
    word_type: 'Danh từ / Hậu tố',
    meaning_vi: 'bên, phía',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '河边有很多树。', pinyin: 'Hé biān yǒu hěn duō shù.', meaning_vi: 'Bên bờ sông có rất nhiều cây.', difficulty_level: 'basic' },
      { chinese: '请大家往左边走。', pinyin: 'Qǐng dàjiā wǎng zuǒbian zǒu.', meaning_vi: 'Xin mời mọi người đi về phía bên trái.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不要',
    pinyin: 'búyào',
    word_type: 'Phó từ',
    meaning_vi: 'đừng, không muốn',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你不要大声说话。', pinyin: 'Nǐ búyào dàshēng shuōhuà.', meaning_vi: 'Bạn đừng nói chuyện lớn tiếng.', difficulty_level: 'basic' },
      { chinese: '今天太累了，我不要去超市。', pinyin: 'Jīntiān tài lèi le, wǒ búyào qù chāoshì.', meaning_vi: 'Hôm nay mệt quá rồi, tôi không muốn đi siêu thị nữa.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM C ---
  {
    hanzi: '唱',
    pinyin: 'chàng',
    word_type: 'Động từ',
    meaning_vi: 'hát',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '她很会唱中文歌。', pinyin: 'Tā hěn huì chàng Zhōngwén gē.', meaning_vi: 'Cô ấy rất biết hát bài hát tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '我们一起唱这首歌吧。', pinyin: 'Wǒmen yìqǐ chàng zhè shǒu gē ba.', meaning_vi: 'Chúng mình cùng nhau hát bài hát này nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '超市',
    pinyin: 'chāoshì',
    word_type: 'Danh từ',
    meaning_vi: 'siêu thị',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '学校旁边有一家超市。', pinyin: 'Xuéxiào pángbiān yǒu yì jiā chāoshì.', meaning_vi: 'Bên cạnh trường học có một siêu thị.', difficulty_level: 'basic' },
      { chinese: '我们去超市买水果吧。', pinyin: 'Wǒmen qù chāoshì mǎi shuǐguǒ ba.', meaning_vi: 'Chúng ta đi siêu thị mua hoa quả đi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '车',
    pinyin: 'chē',
    word_type: 'Danh từ',
    meaning_vi: 'xe, xe cộ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这是我爸爸的车。', pinyin: 'Zhè shì wǒ bàba de chē.', meaning_vi: 'Đây là xe của bố tôi.', difficulty_level: 'basic' },
      { chinese: '路上的车真多。', pinyin: 'Lù shang de chē zhēn duō.', meaning_vi: 'Xe cộ trên đường thật là đông.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '穿',
    pinyin: 'chuān',
    word_type: 'Động từ',
    meaning_vi: 'mặc (quần áo), đi (giày dép)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他穿了一件新衣服。', pinyin: 'Tā chuān le yí jiàn xīn yīfu.', meaning_vi: 'Anh ấy mặc một chiếc áo mới.', difficulty_level: 'basic' },
      { chinese: '今天天气冷，多穿点儿衣服吧。', pinyin: 'Jīntiān tiānqì lěng, duō chuān diǎnr yīfu ba.', meaning_vi: 'Hôm nay trời lạnh, mặc nhiều quần áo vào một chút nhé.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM D ---
  {
    hanzi: '大家',
    pinyin: 'dàjiā',
    word_type: 'Đại từ',
    meaning_vi: 'mọi người, cả nhà',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '大家好！', pinyin: 'Dàjiā hǎo!', meaning_vi: 'Chào mọi người!', difficulty_level: 'basic' },
      { chinese: '大家都喜欢吃中国菜。', pinyin: 'Dàjiā dōu xǐhuan chī Zhōngguó cài.', meaning_vi: 'Mọi người đều thích ăn món ăn Trung Quốc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大学',
    pinyin: 'dàxué',
    word_type: 'Danh từ',
    meaning_vi: 'trường đại học',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '北京大学很有名。', pinyin: 'Běijīng Dàxué hěn yǒumíng.', meaning_vi: 'Đại học Bắc Kinh rất nổi tiếng.', difficulty_level: 'basic' },
      { chinese: '哥哥在大学里学中文。', pinyin: 'Gēge zài dàxué lǐ xué Zhōngwén.', meaning_vi: 'Anh trai học tiếng Trung ở trường đại học.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大学生',
    pinyin: 'dàxuéshēng',
    word_type: 'Danh từ',
    meaning_vi: 'sinh viên đại học',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我姐姐是大学生。', pinyin: 'Wǒ jiějie shì dàxuéshēng.', meaning_vi: 'Chị gái tôi là sinh viên đại học.', difficulty_level: 'basic' },
      { chinese: '这里的大学生都很努力。', pinyin: 'Zhèlǐ de dàxuéshēng dōu hěn nǔlì.', meaning_vi: 'Sinh viên đại học ở đây đều rất chăm chỉ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '到',
    pinyin: 'dào',
    word_type: 'Động từ',
    meaning_vi: 'đến, tới nơi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们到家了。', pinyin: 'Wǒmen dào jiā le.', meaning_vi: 'Chúng ta về đến nhà rồi.', difficulty_level: 'basic' },
      { chinese: '火车下午两点到北京。', pinyin: 'Huǒchē xiàwǔ liǎng diǎn dào Běijīng.', meaning_vi: 'Tàu hỏa đến Bắc Kinh lúc hai giờ chiều.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '第',
    pinyin: 'dì',
    word_type: 'Tiền tố',
    meaning_vi: 'thứ (chỉ số thứ tự: thứ nhất, thứ hai...)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这是第一课。', pinyin: 'Zhè shì dì-yī kè.', meaning_vi: 'Đây là bài học thứ nhất.', difficulty_level: 'basic' },
      { chinese: '他是第一个来的学生。', pinyin: 'Tā shì dì-yī gè lái de xuésheng.', meaning_vi: 'Cậu ấy là học sinh đầu tiên đến lớp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '弟弟',
    pinyin: 'dìdi',
    word_type: 'Danh từ',
    meaning_vi: 'em trai',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我有一个弟弟。', pinyin: 'Wǒ yǒu yí gè dìdi.', meaning_vi: 'Tôi có một người em trai.', difficulty_level: 'basic' },
      { chinese: '我弟弟今年八岁，上小学。', pinyin: 'Wǒ dìdi jīnnián bā suì, shàng xiǎoxué.', meaning_vi: 'Em trai tôi năm nay tám tuổi, đang học tiểu học.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '店',
    pinyin: 'diàn',
    word_type: 'Danh từ',
    meaning_vi: 'cửa hàng, quán',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这家店卖衣服。', pinyin: 'Zhè jiā diàn mài yīfu.', meaning_vi: 'Cửa hàng này bán quần áo.', difficulty_level: 'basic' },
      { chinese: '学校门前有一家茶店。', pinyin: 'Xuéxiào ménqián yǒu yì jiā chádiàn.', meaning_vi: 'Trước cổng trường có một quán trà.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '电话',
    pinyin: 'diànhuà',
    word_type: 'Danh từ',
    meaning_vi: 'điện thoại, cuộc gọi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你的电话是多少？', pinyin: 'Nǐ de diànhuà shì duōshao?', meaning_vi: 'Số điện thoại của bạn là bao nhiêu?', difficulty_level: 'basic' },
      { chinese: '他正在给妈妈打电话。', pinyin: 'Tā zhèngzài gěi māma dǎ diànhuà.', meaning_vi: 'Anh ấy đang gọi điện thoại cho mẹ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '电影院',
    pinyin: 'diànyǐngyuàn',
    word_type: 'Danh từ',
    meaning_vi: 'rạp chiếu phim',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们去电影院看电影吧。', pinyin: 'Wǒmen qù diànyǐngyuàn kàn diànyǐng ba.', meaning_vi: 'Chúng mình đến rạp chiếu phim xem phim đi.', difficulty_level: 'basic' },
      { chinese: '这个电影院离我家不远。', pinyin: 'Zhè ge diànyǐngyuàn lí wǒ jiā bù yuǎn.', meaning_vi: 'Rạp chiếu phim này cách nhà tôi không xa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '读书',
    pinyin: 'dúshū',
    word_type: 'Động từ',
    meaning_vi: 'đọc sách, đi học',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我喜欢每天晚上读书。', pinyin: 'Wǒ xǐhuan měitiān wǎnshang dúshū.', meaning_vi: 'Tôi thích đọc sách vào mỗi buổi tối.', difficulty_level: 'basic' },
      { chinese: '弟弟正在北京的一所大学读书。', pinyin: 'Dìdi zhèngzài Běijīng de yì suǒ dàxué dúshū.', meaning_vi: 'Em trai đang học tại một trường đại học ở Bắc Kinh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '对',
    pinyin: 'duì',
    word_type: 'Tính từ / Giới từ',
    meaning_vi: 'đúng, chính xác; đối với',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你说得很对。', pinyin: 'Nǐ shuō de hěn duì.', meaning_vi: 'Bạn nói rất đúng.', difficulty_level: 'basic' },
      { chinese: '常喝茶对身体很好。', pinyin: 'Cháng hē chá duì shēntǐ hěn hǎo.', meaning_vi: 'Thường xuyên uống trà rất tốt cho sức khỏe.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM F ---
  {
    hanzi: '饭',
    pinyin: 'fàn',
    word_type: 'Danh từ',
    meaning_vi: 'cơm, bữa ăn',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你吃饭了吗？', pinyin: 'Nǐ chī fàn le ma?', meaning_vi: 'Bạn đã ăn cơm chưa?', difficulty_level: 'basic' },
      { chinese: '今天的晚饭非常丰盛。', pinyin: 'Jīntiān de wǎnfàn fēicháng fēngshèng.', meaning_vi: 'Bữa cơm tối hôm nay rất phong phú.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '房间',
    pinyin: 'fángjiān',
    word_type: 'Danh từ',
    meaning_vi: 'căn phòng',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这是我的房间。', pinyin: 'Zhè shì wǒ de fángjiān.', meaning_vi: 'Đây là căn phòng của tôi.', difficulty_level: 'basic' },
      { chinese: '这个房间很大很干净。', pinyin: 'Zhè ge fángjiān hěn dà hěn gānjìng.', meaning_vi: 'Căn phòng này rất to và sạch sẽ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '非常',
    pinyin: 'fēicháng',
    word_type: 'Phó từ',
    meaning_vi: 'vô cùng, rất, hết sức',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这本书非常好看。', pinyin: 'Zhè běn shū fēicháng hǎokàn.', meaning_vi: 'Quyển sách này vô cùng hay.', difficulty_level: 'basic' },
      { chinese: '今天天气非常好，我们出去玩吧。', pinyin: 'Jīntiān tiānqì fēicháng hǎo, wǒmen chūqu wán ba.', meaning_vi: 'Hôm nay thời tiết rất đẹp, chúng ta ra ngoài chơi đi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '分',
    pinyin: 'fēn',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'phút; điểm số; xu',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '现在是八点十分。', pinyin: 'Xiànzài shì bā diǎn shí fēn.', meaning_vi: 'Bây giờ là tám giờ mười phút.', difficulty_level: 'basic' },
      { chinese: '请等我五分钟。', pinyin: 'Qǐng děng wǒ wǔ fēnzhōng.', meaning_vi: 'Làm ơn đợi tôi năm phút nhé.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM G ---
  {
    hanzi: '歌',
    pinyin: 'gē',
    word_type: 'Danh từ',
    meaning_vi: 'bài hát, ca khúc',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这首歌真好听。', pinyin: 'Zhè shǒu gē zhēn hǎotīng.', meaning_vi: 'Bài hát này thật hay.', difficulty_level: 'basic' },
      { chinese: '你喜欢听什么歌？', pinyin: 'Nǐ xǐhuan tīng shénme gē?', meaning_vi: 'Bạn thích nghe bài hát gì?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '哥哥',
    pinyin: 'gēge',
    word_type: 'Danh từ',
    meaning_vi: 'anh trai',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我哥哥是医生。', pinyin: 'Wǒ gēge shì yīshēng.', meaning_vi: 'Anh trai tôi là bác sĩ.', difficulty_level: 'basic' },
      { chinese: '哥哥每天开车去上班。', pinyin: 'Gēge měitiān kāichē qù shàngbān.', meaning_vi: 'Anh trai mỗi ngày đều lái xe đi làm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '给',
    pinyin: 'gěi',
    word_type: 'Động từ / Giới từ',
    meaning_vi: 'cho, đưa cho; cho ai',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '请给我一杯水。', pinyin: 'Qǐng gěi wǒ yì bēi shuǐ.', meaning_vi: 'Làm ơn cho tôi một cốc nước.', difficulty_level: 'basic' },
      { chinese: '爸爸给我买了一本中文书。', pinyin: 'Bàba gěi wǒ mǎi le yì běn Zhōngwén shū.', meaning_vi: 'Bố mua cho tôi một quyển sách tiếng Trung.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '公司',
    pinyin: 'gōngsī',
    word_type: 'Danh từ',
    meaning_vi: 'công ty',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他在一家中国公司工作。', pinyin: 'Tā zài yì jiā Zhōngguó gōngsī gōngzuò.', meaning_vi: 'Anh ấy làm việc ở một công ty Trung Quốc.', difficulty_level: 'basic' },
      { chinese: '这家公司离我家很近。', pinyin: 'Zhè jiā gōngsī lí wǒ jiā hěn jìn.', meaning_vi: 'Công ty này cách nhà tôi rất gần.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '贵',
    pinyin: 'guì',
    word_type: 'Tính từ',
    meaning_vi: 'đắt, quý',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这个苹果不贵。', pinyin: 'Zhè ge píngguǒ bú guì.', meaning_vi: 'Quả táo này không đắt.', difficulty_level: 'basic' },
      { chinese: '那件衣服太贵了，我不买。', pinyin: 'Nà jiàn yīfu tài guì le, wǒ bù mǎi.', meaning_vi: 'Chiếc áo kia đắt quá rồi, tôi không mua đâu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '国',
    pinyin: 'guó',
    word_type: 'Danh từ',
    meaning_vi: 'nước, quốc gia',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你是哪国人？', pinyin: 'Nǐ shì nǎ guó rén?', meaning_vi: 'Bạn là người nước nào?', difficulty_level: 'basic' },
      { chinese: '中国是一个美丽的国家。', pinyin: 'Zhōngguó shì yí gè měilì de guójiā.', meaning_vi: 'Trung Quốc là một quốc gia tươi đẹp.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM H ---
  {
    hanzi: '还',
    pinyin: 'hái',
    word_type: 'Phó từ',
    meaning_vi: 'vẫn, còn',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他还在睡觉。', pinyin: 'Tā hái zài shuìjiào.', meaning_vi: 'Anh ấy vẫn đang ngủ.', difficulty_level: 'basic' },
      { chinese: '你还要买别的吗？', pinyin: 'Nǐ hái yào mǎi biéde ma?', meaning_vi: 'Bạn còn muốn mua thứ gì khác không?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '孩子',
    pinyin: 'háizi',
    word_type: 'Danh từ',
    meaning_vi: 'con cái, đứa trẻ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这个孩子很聪明。', pinyin: 'Zhè ge háizi hěn cōngmíng.', meaning_vi: 'Đứa trẻ này rất thông minh.', difficulty_level: 'basic' },
      { chinese: '孩子们在公园里高兴地玩。', pinyin: 'Háizimen zài gōngyuán lǐ gāoxìng de wán.', meaning_vi: 'Lũ trẻ vui vẻ chơi đùa trong công viên.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '汉字',
    pinyin: 'hànzì',
    word_type: 'Danh từ',
    meaning_vi: 'chữ Hán',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '学汉字很有意思。', pinyin: 'Xué hànzì hěn yǒu yìsi.', meaning_vi: 'Học chữ Hán rất thú vị.', difficulty_level: 'basic' },
      { chinese: '我会写三百个汉字。', pinyin: 'Wǒ huì xiě sān bǎi gè hànzì.', meaning_vi: 'Tôi biết viết ba trăm chữ Hán.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '好吃',
    pinyin: 'hǎochī',
    word_type: 'Tính từ',
    meaning_vi: 'ngon, ngon miệng',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '妈妈做的菜很好吃。', pinyin: 'Māma zuò de cài hěn hǎochī.', meaning_vi: 'Món mẹ nấu rất ngon.', difficulty_level: 'basic' },
      { chinese: '这个包子真好吃，你想尝尝吗？', pinyin: 'Zhè ge bāozi zhēn hǎochī, nǐ xiǎng chángchang ma?', meaning_vi: 'Cái bánh bao này ngon thật, bạn muốn nếm thử không?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '好看',
    pinyin: 'hǎokàn',
    word_type: 'Tính từ',
    meaning_vi: 'đẹp, hay (sách, phim)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这件衣服真好看。', pinyin: 'Zhè jiàn yīfu zhēn hǎokàn.', meaning_vi: 'Chiếc áo này thật là đẹp.', difficulty_level: 'basic' },
      { chinese: '那部电影非常好看。', pinyin: 'Nà bù diànyǐng fēicháng hǎokàn.', meaning_vi: 'Bộ phim kia vô cùng hay.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '好听',
    pinyin: 'hǎotīng',
    word_type: 'Tính từ',
    meaning_vi: 'hay, êm tai (nhạc, giọng nói)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这首歌很好听。', pinyin: 'Zhè shǒu gē hěn hǎotīng.', meaning_vi: 'Bài hát này rất hay.', difficulty_level: 'basic' },
      { chinese: '老师的声音真好听。', pinyin: 'Lǎoshī de shēngyīn zhēn hǎotīng.', meaning_vi: 'Giọng nói của cô giáo thật là êm tai.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '好玩儿',
    pinyin: 'hǎowánr',
    word_type: 'Tính từ',
    meaning_vi: 'vui, vui nhộn, thú vị',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这个游戏很好玩儿。', pinyin: 'Zhè ge yóuxì hěn hǎowánr.', meaning_vi: 'Trò chơi này rất vui.', difficulty_level: 'basic' },
      { chinese: '北京有很多好玩儿的地方。', pinyin: 'Běijīng yǒu hěn duō hǎowánr de dìfang.', meaning_vi: 'Bắc Kinh có rất nhiều địa điểm thú vị để vui chơi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '后',
    pinyin: 'hòu',
    word_type: 'Danh từ',
    meaning_vi: 'sau, phía sau, sau khi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '两天后见。', pinyin: 'Liǎng tiān hòu jiàn.', meaning_vi: 'Hẹn gặp lại sau hai ngày nữa.', difficulty_level: 'basic' },
      { chinese: '下课后我想去书店。', pinyin: 'Xiàkè hòu wǒ xiǎng qù shūdiàn.', meaning_vi: 'Sau khi tan học tôi muốn đến hiệu sách.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '火车',
    pinyin: 'huǒchē',
    word_type: 'Danh từ',
    meaning_vi: 'tàu hỏa, xe lửa',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们坐火车去北京。', pinyin: 'Wǒmen zuò huǒchē qù Běijīng.', meaning_vi: 'Chúng tôi ngồi tàu hỏa đi Bắc Kinh.', difficulty_level: 'basic' },
      { chinese: '火车站离这里有多远？', pinyin: 'Huǒchēzhàn lí zhèlǐ yǒu duō yuǎn?', meaning_vi: 'Ga tàu hỏa cách đây bao xa?', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM J ---
  {
    hanzi: '鸡蛋',
    pinyin: 'jīdàn',
    word_type: 'Danh từ',
    meaning_vi: 'trứng gà',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '早上我吃了一个鸡蛋。', pinyin: 'Zǎoshang wǒ chī le yí gè jīdàn.', meaning_vi: 'Buổi sáng tôi đã ăn một quả trứng gà.', difficulty_level: 'basic' },
      { chinese: '妈妈买了很多新鲜的鸡蛋。', pinyin: 'Māma mǎi le hěn duō xīnxiān de jīdàn.', meaning_vi: 'Mẹ đã mua rất nhiều trứng gà tươi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '家人',
    pinyin: 'jiārén',
    word_type: 'Danh từ',
    meaning_vi: 'người nhà, người thân trong gia đình',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我爱我的家人。', pinyin: 'Wǒ ài wǒ de jiārén.', meaning_vi: 'Tôi yêu người thân trong gia đình tôi.', difficulty_level: 'basic' },
      { chinese: '周末我和家人一起吃饭。', pinyin: 'Zhōumò wǒ hé jiārén yìqǐ chīfàn.', meaning_vi: 'Cuối tuần tôi ăn cơm cùng với người nhà.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '见',
    pinyin: 'jiàn',
    word_type: 'Động từ',
    meaning_vi: 'gặp, thấy',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '明天见！', pinyin: 'Míngtiān jiàn!', meaning_vi: 'Ngày mai gặp nhé!', difficulty_level: 'basic' },
      { chinese: '很高兴见到你。', pinyin: 'Hěn gāoxìng jiàndào nǐ.', meaning_vi: 'Rất vui được gặp bạn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '件',
    pinyin: 'jiàn',
    word_type: 'Lượng từ',
    meaning_vi: 'chiếc, cái (áo, sự việc)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我想买一件衣服。', pinyin: 'Wǒ xiǎng mǎi yí jiàn yīfu.', meaning_vi: 'Tôi muốn mua một chiếc áo.', difficulty_level: 'basic' },
      { chinese: '这件事情很重要。', pinyin: 'Zhè jiàn shìqing hěn zhòngyào.', meaning_vi: 'Sự việc này rất quan trọng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '饺子',
    pinyin: 'jiǎozi',
    word_type: 'Danh từ',
    meaning_vi: 'sủi cảo, bánh chẻo',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '中国人喜欢吃饺子。', pinyin: 'Zhōngguórén xǐhuan chī jiǎozi.', meaning_vi: 'Người Trung Quốc thích ăn sủi cảo.', difficulty_level: 'basic' },
      { chinese: '妈妈今天包了牛肉饺子。', pinyin: 'Māma jīntiān bāo le niúròu jiǎozi.', meaning_vi: 'Hôm nay mẹ gói sủi cảo thịt bò.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '姐姐',
    pinyin: 'jiějie',
    word_type: 'Danh từ',
    meaning_vi: 'chị gái',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我姐姐二十岁。', pinyin: 'Wǒ jiějie èrshí suì.', meaning_vi: 'Chị gái tôi hai mươi tuổi.', difficulty_level: 'basic' },
      { chinese: '姐姐在北京的一家医院当护士。', pinyin: 'Jiějie zài Běijīng de yì jiā yīyuàn dāng hùshi.', meaning_vi: 'Chị gái làm y tá ở một bệnh viện tại Bắc Kinh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '今年',
    pinyin: 'jīnnián',
    word_type: 'Danh từ',
    meaning_vi: 'năm nay',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我今年学中文。', pinyin: 'Wǒ jīnnián xué Zhōngwén.', meaning_vi: 'Năm nay tôi học tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '今年夏天北京天气比较热。', pinyin: 'Jīnnián xiàtiān Běijīng tiānqì bǐjiào rè.', meaning_vi: 'Mùa hè năm nay thời tiết Bắc Kinh khá nóng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '觉得',
    pinyin: 'juéde',
    word_type: 'Động từ',
    meaning_vi: 'cảm thấy, thấy rằng',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我觉得今天很冷。', pinyin: 'Wǒ juéde jīntiān hěn lěng.', meaning_vi: 'Tôi thấy hôm nay rất lạnh.', difficulty_level: 'basic' },
      { chinese: '你觉得这个菜怎么样？', pinyin: 'Nǐ juéde zhè ge cài zěnmeyàng?', meaning_vi: 'Bạn thấy món ăn này thế nào?', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM K ---
  {
    hanzi: '开车',
    pinyin: 'kāichē',
    word_type: 'Động từ',
    meaning_vi: 'lái xe',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '爸爸每天开车去上班。', pinyin: 'Bàba měitiān kāichē qù shàngbān.', meaning_vi: 'Bố mỗi ngày đều lái xe đi làm.', difficulty_level: 'basic' },
      { chinese: '你会开车吗？', pinyin: 'Nǐ huì kāichē ma?', meaning_vi: 'Bạn biết lái xe không?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '看病',
    pinyin: 'kànbìng',
    word_type: 'Động từ',
    meaning_vi: 'khám bệnh, đi khám',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他生病了，要去医院看病。', pinyin: 'Tā shēngbìng le, yào qù yīyuàn kànbìng.', meaning_vi: 'Anh ấy bị ốm rồi, phải đến bệnh viện khám bệnh.', difficulty_level: 'basic' },
      { chinese: '医生正在给病人看病。', pinyin: 'Yīshēng zhèngzài gěi bìngrén kànbìng.', meaning_vi: 'Bác sĩ đang khám bệnh cho bệnh nhân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '可以',
    pinyin: 'kěyǐ',
    word_type: 'Động từ năng nguyện',
    meaning_vi: 'có thể, được',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我可以坐在这里吗？', pinyin: 'Wǒ kěyǐ zuò zài zhèlǐ ma?', meaning_vi: 'Tôi có thể ngồi ở đây không?', difficulty_level: 'basic' },
      { chinese: '你现在可以走了。', pinyin: 'Nǐ xiànzài kěyǐ zǒu le.', meaning_vi: 'Bây giờ bạn có thể đi rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '课',
    pinyin: 'kè',
    word_type: 'Danh từ',
    meaning_vi: 'tiết học, bài học, môn học',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '今天我们有三节课。', pinyin: 'Jīntiān wǒmen yǒu sān jié kè.', meaning_vi: 'Hôm nay chúng tôi có ba tiết học.', difficulty_level: 'basic' },
      { chinese: '中文课很有意思。', pinyin: 'Zhōngwén kè hěn yǒu yìsi.', meaning_vi: 'Giờ học tiếng Trung rất thú vị.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '口',
    pinyin: 'kǒu',
    word_type: 'Lượng từ / Danh từ',
    meaning_vi: 'người (lượng từ gia đình); miệng',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我家有四口人。', pinyin: 'Wǒ jiā yǒu sì kǒu rén.', meaning_vi: 'Gia đình tôi có bốn người.', difficulty_level: 'basic' },
      { chinese: '他喝了一口水。', pinyin: 'Tā hē le yì kǒu shuǐ.', meaning_vi: 'Anh ấy uống một ngụm nước.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM L ---
  {
    hanzi: '两',
    pinyin: 'liǎng',
    word_type: 'Số từ',
    meaning_vi: 'hai, đôi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我有两个朋友。', pinyin: 'Wǒ yǒu liǎng gè péngyou.', meaning_vi: 'Tôi có hai người bạn.', difficulty_level: 'basic' },
      { chinese: '我想买两本书。', pinyin: 'Wǒ xiǎng mǎi liǎng běn shū.', meaning_vi: 'Tôi muốn mua hai quyển sách.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '零',
    pinyin: 'líng',
    word_type: 'Số từ',
    meaning_vi: 'số không (0)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '现在温度是零度。', pinyin: 'Xiànzài wēndù shì líng dù.', meaning_vi: 'Bây giờ nhiệt độ là không độ.', difficulty_level: 'basic' },
      { chinese: '我的房间号是一零八。', pinyin: 'Wǒ de fángjiān hào shì yī líng bā.', meaning_vi: 'Số phòng của tôi là 108.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM M ---
  {
    hanzi: '卖',
    pinyin: 'mài',
    word_type: 'Động từ',
    meaning_vi: 'bán',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '超市卖很多水果。', pinyin: 'Chāoshì mài hěn duō shuǐguǒ.', meaning_vi: 'Siêu thị bán rất nhiều hoa quả.', difficulty_level: 'basic' },
      { chinese: '这个苹果怎么卖？', pinyin: 'Zhè ge píngguǒ zěnme mài?', meaning_vi: 'Táo này bán thế nào vậy?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '忙',
    pinyin: 'máng',
    word_type: 'Tính từ',
    meaning_vi: 'bận, bận rộn',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我今天很忙。', pinyin: 'Wǒ jīntiān hěn máng.', meaning_vi: 'Hôm nay tôi rất bận.', difficulty_level: 'basic' },
      { chinese: '你在忙什么呢？', pinyin: 'Nǐ zài máng shénme ne?', meaning_vi: 'Bạn đang bận việc gì thế?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '没事',
    pinyin: 'méi shì',
    word_type: 'Cụm từ',
    meaning_vi: 'không có gì, không sao',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '对不起！——没事。', pinyin: 'Duìbuqǐ! —— Méi shì.', meaning_vi: 'Xin lỗi! —— Không sao đâu.', difficulty_level: 'basic' },
      { chinese: '你生病了吗？——没事，我已经好了。', pinyin: 'Nǐ shēngbìng le ma? —— Méi shì, wǒ yǐjīng hǎo le.', meaning_vi: 'Bạn ốm à? —— Không sao, tôi đã khỏi rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '妹妹',
    pinyin: 'mèimei',
    word_type: 'Danh từ',
    meaning_vi: 'em gái',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我妹妹很可爱。', pinyin: 'Wǒ mèimei hěn kě’ài.', meaning_vi: 'Em gái tôi rất đáng yêu.', difficulty_level: 'basic' },
      { chinese: '妹妹今年上小学一年级。', pinyin: 'Mèimei jīnnián shàng xiǎoxué yī niánjí.', meaning_vi: 'Năm nay em gái vào học lớp một tiểu học.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '们',
    pinyin: 'men',
    word_type: 'Hậu tố',
    meaning_vi: 'các, chúng (hậu tố số nhiều: 我们, 你们, 学生们)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们都是学生。', pinyin: 'Wǒmen dōu shì xuésheng.', meaning_vi: 'Chúng tôi đều là học sinh.', difficulty_level: 'basic' },
      { chinese: '朋友们今天都来了。', pinyin: 'Péngyoumen jīntiān dōu lái le.', meaning_vi: 'Các bạn bè hôm nay đều đã đến.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '面包',
    pinyin: 'miànbāo',
    word_type: 'Danh từ',
    meaning_vi: 'bánh mì',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '早饭我吃面包。', pinyin: 'Zǎofàn wǒ chī miànbāo.', meaning_vi: 'Bữa sáng tôi ăn bánh mì.', difficulty_level: 'basic' },
      { chinese: '这家店的面包又香又好吃。', pinyin: 'Zhè jiā diàn de miànbāo yòu xiāng yòu hǎochī.', meaning_vi: 'Bánh mì của quán này vừa thơm vừa ngon.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '面条儿',
    pinyin: 'miàntiáor',
    word_type: 'Danh từ',
    meaning_vi: 'mì, mì sợi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '中午我想吃面条儿。', pinyin: 'Zhōngwǔ wǒ xiǎng chī miàntiáor.', meaning_vi: 'Buổi trưa tôi muốn ăn mì sợi.', difficulty_level: 'basic' },
      { chinese: '妈妈做的牛肉面条儿最好吃。', pinyin: 'Māma zuò de niúròu miàntiáor zuì hǎochī.', meaning_vi: 'Món mì bò do mẹ nấu là ngon nhất.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '明年',
    pinyin: 'míngnián',
    word_type: 'Danh từ',
    meaning_vi: 'năm sau, năm tới',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我明年去中国。', pinyin: 'Wǒ míngnián qù Zhōngguó.', meaning_vi: 'Năm sau tôi đi Trung Quốc.', difficulty_level: 'basic' },
      { chinese: '哥哥明年大学毕业。', pinyin: 'Gēge míngnián dàxué bìyè.', meaning_vi: 'Năm sau anh trai tốt nghiệp đại học.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM N ---
  {
    hanzi: '哪个',
    pinyin: 'nǎ ge',
    word_type: 'Đại từ',
    meaning_vi: 'cái nào, người nào',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '哪个杯子是你的？', pinyin: 'Nǎ ge bēizi shì nǐ de?', meaning_vi: 'Chiếc cốc nào là của bạn?', difficulty_level: 'basic' },
      { chinese: '你想买哪本书？', pinyin: 'Nǐ xiǎng mǎi nǎ běn shū?', meaning_vi: 'Bạn muốn mua quyển sách nào?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '哪里',
    pinyin: 'nǎlǐ',
    word_type: 'Đại từ',
    meaning_vi: 'ở đâu, đâu',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你去哪里？', pinyin: 'Nǐ qù nǎlǐ?', meaning_vi: 'Bạn đi đâu thế?', difficulty_level: 'basic' },
      { chinese: '你的家在哪里？', pinyin: 'Nǐ de jiā zài nǎlǐ?', meaning_vi: 'Nhà của bạn ở đâu?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '哪些',
    pinyin: 'nǎxiē',
    word_type: 'Đại từ',
    meaning_vi: 'những cái nào, những ai',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你想买哪些书？', pinyin: 'Nǐ xiǎng mǎi nǎxiē shū?', meaning_vi: 'Bạn muốn mua những quyển sách nào?', difficulty_level: 'basic' },
      { chinese: '哪些人明天去北京？', pinyin: 'Nǎxiē rén míngtiān qù Běijīng?', meaning_vi: 'Những ai ngày mai sẽ đi Bắc Kinh?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '那边',
    pinyin: 'nàbian',
    word_type: 'Danh từ',
    meaning_vi: 'bên kia, phía bên đó',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '超市在那边。', pinyin: 'Chāoshì zài nàbian.', meaning_vi: 'Siêu thị ở phía bên kia.', difficulty_level: 'basic' },
      { chinese: '我们去那边坐坐吧。', pinyin: 'Wǒmen qù nàbian zuòzuo ba.', meaning_vi: 'Chúng ta sang bên kia ngồi một lát đi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '那个',
    pinyin: 'nà ge',
    word_type: 'Đại từ',
    meaning_vi: 'cái đó, người đó',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '那个包很漂亮。', pinyin: 'Nà ge bāo hěn piàoliang.', meaning_vi: 'Chiếc túi đó rất đẹp.', difficulty_level: 'basic' },
      { chinese: '那个人是我的老师。', pinyin: 'Nà ge rén shì wǒ de lǎoshī.', meaning_vi: 'Người đó là giáo viên của tôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '那里',
    pinyin: 'nàlǐ',
    word_type: 'Đại từ',
    meaning_vi: 'ở đó, đằng kia',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我的书在那里。', pinyin: 'Wǒ de shū zài nàlǐ.', meaning_vi: 'Sách của tôi ở đằng kia.', difficulty_level: 'basic' },
      { chinese: '那里有很多中国学生。', pinyin: 'Nàlǐ yǒu hěn duō Zhōngguó xuésheng.', meaning_vi: 'Ở đó có rất nhiều du học sinh Trung Quốc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '那儿',
    pinyin: 'nàr',
    word_type: 'Đại từ',
    meaning_vi: 'chỗ đó, nơi đó',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他在那儿等你。', pinyin: 'Tā zài nàr děng nǐ.', meaning_vi: 'Anh ấy đang đợi bạn ở chỗ đó.', difficulty_level: 'basic' },
      { chinese: '那儿的天气很舒服。', pinyin: 'Nàr de tiānqì hěn shūfu.', meaning_vi: 'Thời tiết ở nơi đó rất dễ chịu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '那些',
    pinyin: 'nàxiē',
    word_type: 'Đại từ',
    meaning_vi: 'những cái đó, những người đó',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '那些苹果很甜。', pinyin: 'Nàxiē píngguǒ hěn tián.', meaning_vi: 'Những quả táo đó rất ngọt.', difficulty_level: 'basic' },
      { chinese: '那些书都是我的。', pinyin: 'Nàxiē shū dōu shì wǒ de.', meaning_vi: 'Những cuốn sách đó đều là của tôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '男',
    pinyin: 'nán',
    word_type: 'Danh từ',
    meaning_vi: 'nam, phái nam',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们班有八个男同学。', pinyin: 'Wǒmen bān yǒu bā gè nán tóngxué.', meaning_vi: 'Lớp chúng tôi có tám bạn học nam.', difficulty_level: 'basic' },
      { chinese: '那个穿白衣服的男人是谁？', pinyin: 'Nà ge chuān bái yīfu de nánrén shì shéi?', meaning_vi: 'Người đàn ông mặc áo trắng đó là ai vậy?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '男朋友',
    pinyin: 'nánpéngyou',
    word_type: 'Danh từ',
    meaning_vi: 'bạn trai',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这是我的男朋友。', pinyin: 'Zhè shì wǒ de nánpéngyou.', meaning_vi: 'Đây là bạn trai của tôi.', difficulty_level: 'basic' },
      { chinese: '她男朋友在中国工作。', pinyin: 'Tā nánpéngyou zài Zhōngguó gōngzuò.', meaning_vi: 'Bạn trai cô ấy làm việc ở Trung Quốc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '你好',
    pinyin: 'nǐ hǎo',
    word_type: 'Cụm từ',
    meaning_vi: 'xin chào',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你好！很高兴认识你。', pinyin: 'Nǐ hǎo! Hěn gāoxìng rènshi nǐ.', meaning_vi: 'Xin chào! Rất vui được quen biết bạn.', difficulty_level: 'basic' },
      { chinese: '老师，您好！', pinyin: 'Lǎoshī, nín hǎo!', meaning_vi: 'Em chào thầy/cô ạ!', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '你们',
    pinyin: 'nǐmen',
    word_type: 'Đại từ',
    meaning_vi: 'các bạn, các anh/chị',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你们想喝什么？', pinyin: 'Nǐmen xiǎng hē shénme?', meaning_vi: 'Các bạn muốn uống gì?', difficulty_level: 'basic' },
      { chinese: '明天你们几点去学校？', pinyin: 'Míngtiān nǐmen jǐ diǎn qù xuéxiào?', meaning_vi: 'Ngày mai mấy giờ các bạn đến trường?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '您',
    pinyin: 'nín',
    word_type: 'Đại từ',
    meaning_vi: 'ngài, ông, bà (đại từ tôn kính)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '老师，您好！', pinyin: 'Lǎoshī, nín hǎo!', meaning_vi: 'Kính chào thầy cô ạ!', difficulty_level: 'basic' },
      { chinese: '请问您需要什么？', pinyin: 'Qǐngwèn nín xūyào shénme?', meaning_vi: 'Xin hỏi ngài cần gì ạ?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '牛奶',
    pinyin: 'niúnǎi',
    word_type: 'Danh từ',
    meaning_vi: 'sữa bò, sữa tươi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '早上我喝了一杯牛奶。', pinyin: 'Zǎoshang wǒ hē le yì bēi niúnǎi.', meaning_vi: 'Buổi sáng tôi đã uống một cốc sữa tươi.', difficulty_level: 'basic' },
      { chinese: '这个牛奶很新鲜。', pinyin: 'Zhè ge niúnǎi hěn xīnxiān.', meaning_vi: 'Hộp sữa này rất tươi ngon.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '女',
    pinyin: 'nǚ',
    word_type: 'Danh từ',
    meaning_vi: 'nữ, phái nữ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们班有很多女同学。', pinyin: 'Wǒmen bān yǒu hěn duō nǚ tóngxué.', meaning_vi: 'Lớp chúng tôi có rất nhiều bạn học nữ.', difficulty_level: 'basic' },
      { chinese: '那个女孩长得很漂亮。', pinyin: 'Nà ge nǚhái zhǎng de hěn piàoliang.', meaning_vi: 'Cô bé đó trông rất xinh xắn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '女朋友',
    pinyin: 'nǚpéngyou',
    word_type: 'Danh từ',
    meaning_vi: 'bạn gái',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这是我的女朋友。', pinyin: 'Zhè shì wǒ de nǚpéngyou.', meaning_vi: 'Đây là bạn gái của tôi.', difficulty_level: 'basic' },
      { chinese: '哥哥和他的女朋友一起去旅游。', pinyin: 'Gēge hé tā de nǚpéngyou yìqǐ qù lǚyóu.', meaning_vi: 'Anh trai cùng bạn gái đi du lịch.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '女士',
    pinyin: 'nǚshì',
    word_type: 'Danh từ',
    meaning_vi: 'quý bà, quý cô, phụ nữ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '王女士是一位老师。', pinyin: 'Wáng nǚshì shì yí wèi lǎoshī.', meaning_vi: 'Cô Vương là một giáo viên.', difficulty_level: 'basic' },
      { chinese: '女士们、先生们，大家晚上好！', pinyin: 'Nǚshìmen, xiānshengmen, dàjiā wǎnshang hǎo!', meaning_vi: 'Kính thưa quý bà, quý ông, chúc mọi người một buổi tối tốt lành!', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM P ---
  {
    hanzi: '便宜',
    pinyin: 'piányi',
    word_type: 'Tính từ',
    meaning_vi: 'rẻ, giá rẻ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这件衣服很便宜。', pinyin: 'Zhè jiàn yīfu hěn piányi.', meaning_vi: 'Chiếc áo này rất rẻ.', difficulty_level: 'basic' },
      { chinese: '超市里的水果比外面便宜。', pinyin: 'Chāoshì lǐ de shuǐguǒ bǐ wàimiàn piányi.', meaning_vi: 'Hoa quả trong siêu thị rẻ hơn bên ngoài.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM Q ---
  {
    hanzi: '起床',
    pinyin: 'qǐchuáng',
    word_type: 'Động từ',
    meaning_vi: 'thức dậy, ngủ dậy',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我早上六点起床。', pinyin: 'Wǒ zǎoshang liù diǎn qǐchuáng.', meaning_vi: 'Buổi sáng tôi thức dậy lúc sáu giờ.', difficulty_level: 'basic' },
      { chinese: '明天我们要早起，别睡太晚。', pinyin: 'Míngtiān wǒmen yào zǎoqǐ, bié shuì tài wǎn.', meaning_vi: 'Ngày mai chúng ta phải dậy sớm, đừng ngủ muộn quá.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '千',
    pinyin: 'qiān',
    word_type: 'Số từ',
    meaning_vi: 'nghìn, ngàn (1000)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这台电脑三千块。', pinyin: 'Zhè tái diànnǎo sān qiān kuài.', meaning_vi: 'Chiếc máy tính này ba nghìn tệ.', difficulty_level: 'basic' },
      { chinese: '学校里有一千多个学生。', pinyin: 'Xuéxiào lǐ yǒu yì qiān duō gè xuésheng.', meaning_vi: 'Trong trường có hơn một nghìn học sinh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '前',
    pinyin: 'qián',
    word_type: 'Danh từ',
    meaning_vi: 'trước, phía trước, trước khi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '学校在前面。', pinyin: 'Xuéxiào zài qiánmian.', meaning_vi: 'Trường học ở phía trước.', difficulty_level: 'basic' },
      { chinese: '三天前我买了一本书。', pinyin: 'Sān tiān qián wǒ mǎi le yì běn shū.', meaning_vi: 'Ba ngày trước tôi đã mua một quyển sách.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '请问',
    pinyin: 'qǐngwèn',
    word_type: 'Cụm từ',
    meaning_vi: 'xin hỏi, làm ơn cho hỏi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '请问，图书馆在哪里？', pinyin: 'Qǐngwèn, túshūguǎn zài nǎlǐ?', meaning_vi: 'Xin hỏi, thư viện ở đâu ạ?', difficulty_level: 'basic' },
      { chinese: '请问，现在几点了？', pinyin: 'Qǐngwèn, xiànzài jǐ diǎn le?', meaning_vi: 'Xin hỏi, bây giờ là mấy giờ rồi ạ?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '去年',
    pinyin: 'qùnián',
    word_type: 'Danh từ',
    meaning_vi: 'năm ngoái',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我去年去了北京。', pinyin: 'Wǒ qùnián qù le Běijīng.', meaning_vi: 'Năm ngoái tôi đã đi Bắc Kinh.', difficulty_level: 'basic' },
      { chinese: '去年我开始学中文。', pinyin: 'Qùnián wǒ kāishǐ xué Zhōngwén.', meaning_vi: 'Năm ngoái tôi bắt đầu học tiếng Trung.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM R ---
  {
    hanzi: '日',
    pinyin: 'rì',
    word_type: 'Danh từ',
    meaning_vi: 'ngày, mặt trời',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '今天是十月一日。', pinyin: 'Jīntiān shì shí yuè yī rì.', meaning_vi: 'Hôm nay là ngày 1 tháng 10.', difficulty_level: 'basic' },
      { chinese: '我的生日是五月五日。', pinyin: 'Wǒ de shēngrì shì wǔ yuè wǔ rì.', meaning_vi: 'Sinh nhật của tôi là ngày 5 tháng 5.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM S ---
  {
    hanzi: '上班',
    pinyin: 'shàngbān',
    word_type: 'Động từ',
    meaning_vi: 'đi làm',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '爸爸早上八点去上班。', pinyin: 'Bàba zǎoshang bā diǎn qù shàngbān.', meaning_vi: 'Bố tám giờ sáng đi làm.', difficulty_level: 'basic' },
      { chinese: '今天星期天，我不上班。', pinyin: 'Jīntiān xīngqītiān, wǒ bú shàngbān.', meaning_vi: 'Hôm nay chủ nhật, tôi không phải đi làm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '上课',
    pinyin: 'shàngkè',
    word_type: 'Động từ',
    meaning_vi: 'vào học, lên lớp',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们八点开始上课。', pinyin: 'Wǒmen bā diǎn kāishǐ shàngkè.', meaning_vi: 'Chúng tôi tám giờ bắt đầu vào học.', difficulty_level: 'basic' },
      { chinese: '老师正在给学生们上课。', pinyin: 'Lǎoshī zhèngzài gěi xuéshengmen shàngkè.', meaning_vi: 'Thầy giáo đang giảng bài lên lớp cho học sinh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '上学',
    pinyin: 'shàngxué',
    word_type: 'Động từ',
    meaning_vi: 'đi học',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '妹妹每天早上走路上学。', pinyin: 'Mèimei měitiān zǎoshang zǒulù shàngxué.', meaning_vi: 'Mỗi buổi sáng em gái đều đi bộ đi học.', difficulty_level: 'basic' },
      { chinese: '他八岁开始上学。', pinyin: 'Tā bā suì kāishǐ shàngxué.', meaning_vi: 'Cậu ấy tám tuổi bắt đầu đi học.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '生病',
    pinyin: 'shēngbìng',
    word_type: 'Động từ',
    meaning_vi: 'bị ốm, đổ bệnh',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他生病了，不能来学校。', pinyin: 'Tā shēngbìng le, bù néng lái xuéxiào.', meaning_vi: 'Cậu ấy bị ốm rồi, không thể đến trường.', difficulty_level: 'basic' },
      { chinese: '天冷了，你要注意身体，别生病。', pinyin: 'Tiān lěng le, nǐ yào zhùyì shēntǐ, bié shēngbìng.', meaning_vi: 'Trời lạnh rồi, bạn nhớ chú ý sức khỏe, đừng để bị ốm nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '时间',
    pinyin: 'shíjiān',
    word_type: 'Danh từ',
    meaning_vi: 'thời gian',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你今天有时间吗？', pinyin: 'Nǐ jīntiān yǒu shíjiān ma?', meaning_vi: 'Hôm nay bạn có thời gian không?', difficulty_level: 'basic' },
      { chinese: '时间过得真快！', pinyin: 'Shíjiān guò de zhēn kuài!', meaning_vi: 'Thời gian trôi qua thật nhanh!', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '事',
    pinyin: 'shì',
    word_type: 'Danh từ',
    meaning_vi: 'việc, chuyện, sự việc',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你找我有什么事？', pinyin: 'Nǐ zhǎo wǒ yǒu shénme shì?', meaning_vi: 'Bạn tìm tôi có việc gì thế?', difficulty_level: 'basic' },
      { chinese: '这件事情明天再说吧。', pinyin: 'Zhè jiàn shìqing míngtiān zài shuō ba.', meaning_vi: 'Chuyện này ngày mai hãy nói tiếp nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '手机',
    pinyin: 'shǒujī',
    word_type: 'Danh từ',
    meaning_vi: 'điện thoại di động',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这是我的新手机。', pinyin: 'Zhè shì wǒ de xīn shǒujī.', meaning_vi: 'Đây là chiếc điện thoại di động mới của tôi.', difficulty_level: 'basic' },
      { chinese: '他在用手机看中文新闻。', pinyin: 'Tā zài yòng shǒujī kàn Zhōngwén xīnwén.', meaning_vi: 'Anh ấy đang dùng điện thoại xem tin tức tiếng Trung.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '书店',
    pinyin: 'shūdiàn',
    word_type: 'Danh từ',
    meaning_vi: 'hiệu sách, nhà sách',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我想去书店买书。', pinyin: 'Wǒ xiǎng qù shūdiàn mǎi shū.', meaning_vi: 'Tôi muốn đến hiệu sách mua sách.', difficulty_level: 'basic' },
      { chinese: '学校旁边有一家很大的书店。', pinyin: 'Xuéxiào pángbiān yǒu yì jiā hěn dà de shūdiàn.', meaning_vi: 'Bên cạnh trường học có một hiệu sách rất to.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '睡',
    pinyin: 'shuì',
    word_type: 'Động từ',
    meaning_vi: 'ngủ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '快去睡吧，很晚了。', pinyin: 'Kuài qù shuì ba, hěn wǎn le.', meaning_vi: 'Mau đi ngủ đi, muộn lắm rồi.', difficulty_level: 'basic' },
      { chinese: '他每天晚上十点睡。', pinyin: 'Tā měitiān wǎnshang shí diǎn shuì.', meaning_vi: 'Mỗi tối mười giờ anh ấy đi ngủ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '说话',
    pinyin: 'shuōhuà',
    word_type: 'Động từ',
    meaning_vi: 'nói chuyện, trò chuyện',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他们正在说话。', pinyin: 'Tāmen zhèngzài shuōhuà.', meaning_vi: 'Họ đang nói chuyện với nhau.', difficulty_level: 'basic' },
      { chinese: '上课的时候不要大声说话。', pinyin: 'Shàngkè de shíhou búyào dàshēng shuōhuà.', meaning_vi: 'Lúc học bài đừng nói chuyện to tiếng.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM T ---
  {
    hanzi: '它',
    pinyin: 'tā',
    word_type: 'Đại từ',
    meaning_vi: 'nó (chỉ đồ vật, con vật)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '那是一只猫，它很可爱。', pinyin: 'Nà shì yì zhī māo, tā hěn kě’ài.', meaning_vi: 'Đó là một con mèo, nó rất đáng yêu.', difficulty_level: 'basic' },
      { chinese: '小狗在哪里？它在桌子下。', pinyin: 'Xiǎogǒu zài nǎlǐ? Tā zài zhuōzi xià.', meaning_vi: 'Chú cún ở đâu? Nó ở dưới gầm bàn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '他们',
    pinyin: 'tāmen',
    word_type: 'Đại từ',
    meaning_vi: 'họ, bọn họ (nam/chung)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他们是我的同学。', pinyin: 'Tāmen shì wǒ de tóngxué.', meaning_vi: 'Họ là bạn học của tôi.', difficulty_level: 'basic' },
      { chinese: '他们明天要去北京旅游。', pinyin: 'Tāmen míngtiān yào qù Běijīng lǚyóu.', meaning_vi: 'Ngày mai họ sẽ đi du lịch Bắc Kinh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '它们',
    pinyin: 'tāmen',
    word_type: 'Đại từ',
    meaning_vi: 'chúng, chúng nó (đồ vật/động vật)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '院子里有两只狗，它们都很小。', pinyin: 'Yuànzi lǐ yǒu liǎng zhī gǒu, tāmen dōu hěn xiǎo.', meaning_vi: 'Trong sân có hai chú chó, chúng đều rất nhỏ.', difficulty_level: 'basic' },
      { chinese: '这些鸟真漂亮，它们在唱歌。', pinyin: 'Zhèxiē niǎo zhēn piàoliang, tāmen zài chànggē.', meaning_vi: 'Những chú chim này thật đẹp, chúng đang ca hát.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '她们',
    pinyin: 'tāmen',
    word_type: 'Đại từ',
    meaning_vi: 'họ, các cô ấy (toàn nữ)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '她们都在学中文。', pinyin: 'Tāmen dōu zài xué Zhōngwén.', meaning_vi: 'Các cô ấy đều đang học tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '姐姐和她的朋友们，她们去超市了。', pinyin: 'Jiějie hé tā de péngyoumen, tāmen qù chāoshì le.', meaning_vi: 'Chị gái và các bạn của chị, họ đã đi siêu thị rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '天',
    pinyin: 'tiān',
    word_type: 'Danh từ',
    meaning_vi: 'trời, ngày',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '今天天气很好。', pinyin: 'Jīntiān tiānqì hěn hǎo.', meaning_vi: 'Hôm nay thời tiết rất đẹp.', difficulty_level: 'basic' },
      { chinese: '我们在北京玩了三天。', pinyin: 'Wǒmen zài Běijīng wán le sān tiān.', meaning_vi: 'Chúng tôi đã chơi ở Bắc Kinh ba ngày.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '听见',
    pinyin: 'tīngjiàn',
    word_type: 'Động từ',
    meaning_vi: 'nghe thấy, nghe được',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你听见了吗？', pinyin: 'Nǐ tīngjiàn le ma?', meaning_vi: 'Bạn có nghe thấy không?', difficulty_level: 'basic' },
      { chinese: '我听见有人在唱歌。', pinyin: 'Wǒ tīngjiàn yǒu rén zài chànggē.', meaning_vi: 'Tôi nghe thấy có người đang hát.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM W ---
  {
    hanzi: '外',
    pinyin: 'wài',
    word_type: 'Danh từ',
    meaning_vi: 'ngoài, bên ngoài',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他在门外等你。', pinyin: 'Tā zài mén wài děng nǐ.', meaning_vi: 'Anh ấy đang đợi bạn ở ngoài cửa.', difficulty_level: 'basic' },
      { chinese: '外面在下雨，不要出去。', pinyin: 'Wàimiàn zài xiàyǔ, búyào chūqu.', meaning_vi: 'Bên ngoài đang mưa, đừng đi ra ngoài.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '外边',
    pinyin: 'wàibian',
    word_type: 'Danh từ',
    meaning_vi: 'bên ngoài, phía ngoài',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '外边很冷，多穿点儿衣服。', pinyin: 'Wàibian hěn lěng, duō chuān diǎnr yīfu.', meaning_vi: 'Bên ngoài rất lạnh, mặc nhiều áo vào một chút.', difficulty_level: 'basic' },
      { chinese: '孩子们在外边高兴地玩。', pinyin: 'Háizimen zài wàibian gāoxìng de wán.', meaning_vi: 'Lũ trẻ vui vẻ chơi đùa ở phía ngoài.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '玩',
    pinyin: 'wán',
    word_type: 'Động từ',
    meaning_vi: 'chơi, vui chơi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我想去公园玩。', pinyin: 'Wǒ xiǎng qù gōngyuán wán.', meaning_vi: 'Tôi muốn đến công viên chơi.', difficulty_level: 'basic' },
      { chinese: '周末你来我家玩吧。', pinyin: 'Zhōumò nǐ lái wǒ jiā wán ba.', meaning_vi: 'Cuối tuần bạn đến nhà tôi chơi nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '晚',
    pinyin: 'wǎn',
    word_type: 'Tính từ',
    meaning_vi: 'muộn, trễ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '现在太晚了，我们走吧。', pinyin: 'Xiànzài tài wǎn le, wǒmen zǒu ba.', meaning_vi: 'Bây giờ muộn quá rồi, chúng mình đi thôi.', difficulty_level: 'basic' },
      { chinese: '他今天来晚了十分钟。', pinyin: 'Tā jīntiān lái wǎn le shí fēnzhōng.', meaning_vi: 'Hôm nay anh ấy đến muộn mười phút.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '晚饭',
    pinyin: 'wǎnfàn',
    word_type: 'Danh từ',
    meaning_vi: 'bữa cơm tối',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们晚上七点吃晚饭。', pinyin: 'Wǒmen wǎnshang qī diǎn chī wǎnfàn.', meaning_vi: 'Chúng tôi bảy giờ tối ăn cơm tối.', difficulty_level: 'basic' },
      { chinese: '今天的晚饭很好吃。', pinyin: 'Jīntiān de wǎnfàn hěn hǎochī.', meaning_vi: 'Cơm tối hôm nay rất ngon.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '晚上',
    pinyin: 'wǎnshang',
    word_type: 'Danh từ',
    meaning_vi: 'buổi tối',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '晚上我经常看书。', pinyin: 'Wǎnshang wǒ jīngcháng kànshū.', meaning_vi: 'Buổi tối tôi thường hay đọc sách.', difficulty_level: 'basic' },
      { chinese: '晚上你想去哪里吃饭？', pinyin: 'Wǎnshang nǐ xiǎng qù nǎlǐ chīfàn?', meaning_vi: 'Buổi tối bạn muốn đi đâu ăn cơm?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '喂',
    pinyin: 'wèi',
    word_type: 'Thán từ',
    meaning_vi: 'alo (khi nghe điện thoại)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '喂，请问王老师在吗？', pinyin: 'Wèi, qǐngwèn Wáng lǎoshī zài ma?', meaning_vi: 'Alo, xin hỏi thầy Vương có ở đó không ạ?', difficulty_level: 'basic' },
      { chinese: '喂，我是大卫，你在哪里？', pinyin: 'Wèi, wǒ shì Dàwèi, nǐ zài nǎlǐ?', meaning_vi: 'Alo, tôi là David đây, bạn đang ở đâu thế?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '问',
    pinyin: 'wèn',
    word_type: 'Động từ',
    meaning_vi: 'hỏi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我可以问你一个问题吗？', pinyin: 'Wǒ kěyǐ wèn nǐ yí gè wèntí ma?', meaning_vi: 'Tôi có thể hỏi bạn một câu hỏi không?', difficulty_level: 'basic' },
      { chinese: '他去问老师这道题怎么做。', pinyin: 'Tā qù wèn lǎoshī zhè dào tí zěnme zuò.', meaning_vi: 'Cậu ấy đến hỏi thầy giáo bài này làm như thế nào.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '问题',
    pinyin: 'wèntí',
    word_type: 'Danh từ',
    meaning_vi: 'câu hỏi, vấn đề',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '没问题，我帮你！', pinyin: 'Méi wèntí, wǒ bāng nǐ!', meaning_vi: 'Không thành vấn đề, tôi giúp bạn!', difficulty_level: 'basic' },
      { chinese: '这个汉语问题有点儿难。', pinyin: 'Zhè ge Hànyǔ wèntí yǒudiǎnr nán.', meaning_vi: 'Câu hỏi tiếng Hán này hơi khó một chút.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '午饭',
    pinyin: 'wǔfàn',
    word_type: 'Danh từ',
    meaning_vi: 'bữa trưa, cơm trưa',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我们中午十二点吃午饭。', pinyin: 'Wǒmen zhōngwǔ shí’èr diǎn chī wǔfàn.', meaning_vi: 'Chúng tôi mười hai giờ trưa ăn cơm trưa.', difficulty_level: 'basic' },
      { chinese: '今天午饭我想吃米饭和鸡蛋。', pinyin: 'Jīntiān wǔfàn wǒ xiǎng chī mǐfàn hé jīdàn.', meaning_vi: 'Cơm trưa hôm nay tôi muốn ăn cơm và trứng gà.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM X ---
  {
    hanzi: '下班',
    pinyin: 'xiàbān',
    word_type: 'Động từ',
    meaning_vi: 'tan làm, tan sở',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我下午五点下班。', pinyin: 'Wǒ xiàwǔ wǔ diǎn xiàbān.', meaning_vi: 'Tôi năm giờ chiều tan làm.', difficulty_level: 'basic' },
      { chinese: '下班后我们去喝茶吧。', pinyin: 'Xiàbān hòu wǒmen qù hē chá ba.', meaning_vi: 'Tan làm rồi chúng mình đi uống trà nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '下课',
    pinyin: 'xiàkè',
    word_type: 'Động từ',
    meaning_vi: 'tan học, tan tiết',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '现在下课了，大家休息吧。', pinyin: 'Xiànzài xiàkè le, dàjiā xiūxi ba.', meaning_vi: 'Bây giờ tan học rồi, mọi người nghỉ giải lao đi.', difficulty_level: 'basic' },
      { chinese: '下课后我想去图书馆借书。', pinyin: 'Xiàkè hòu wǒ xiǎng qù túshūguǎn jiè shū.', meaning_vi: 'Tan học xong tôi muốn đến thư viện mượn sách.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '小朋友',
    pinyin: 'xiǎopéngyou',
    word_type: 'Danh từ',
    meaning_vi: 'em nhỏ, cháu bé, bạn nhỏ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '那个小朋友真可爱。', pinyin: 'Nà ge xiǎopéngyou zhēn kě’ài.', meaning_vi: 'Em nhỏ đó thật đáng yêu.', difficulty_level: 'basic' },
      { chinese: '公园里有很多小朋友在玩。', pinyin: 'Gōngyuán lǐ yǒu hěn duō xiǎopéngyou zài wán.', meaning_vi: 'Trong công viên có rất nhiều em nhỏ đang chơi đùa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '小时',
    pinyin: 'xiǎoshí',
    word_type: 'Danh từ',
    meaning_vi: 'tiếng, giờ đồng hồ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我学了一个小时中文。', pinyin: 'Wǒ xué le yí gè xiǎoshí Zhōngwén.', meaning_vi: 'Tôi đã học tiếng Trung suốt một tiếng đồng hồ.', difficulty_level: 'basic' },
      { chinese: '坐火车去北京需要两个小时。', pinyin: 'Zuò huǒchē qù Běijīng xūyào liǎng gè xiǎoshí.', meaning_vi: 'Ngồi tàu hỏa đi Bắc Kinh cần hai tiếng đồng hồ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '小学',
    pinyin: 'xiǎoxué',
    word_type: 'Danh từ',
    meaning_vi: 'trường tiểu học',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这所小学离我家很近。', pinyin: 'Zhè suǒ xiǎoxué lí wǒ jiā hěn jìn.', meaning_vi: 'Ngôi trường tiểu học này cách nhà tôi rất gần.', difficulty_level: 'basic' },
      { chinese: '弟弟在这个小学读书。', pinyin: 'Dìdi zài zhè ge xiǎoxué dúshū.', meaning_vi: 'Em trai học ở trường tiểu học này.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '小学生',
    pinyin: 'xiǎoxuéshēng',
    word_type: 'Danh từ',
    meaning_vi: 'học sinh tiểu học',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我妹妹是小学生。', pinyin: 'Wǒ mèimei shì xiǎoxuéshēng.', meaning_vi: 'Em gái tôi là học sinh tiểu học.', difficulty_level: 'basic' },
      { chinese: '小学生们排队走进学校。', pinyin: 'Xiǎoxuéshēngmen páiduì zǒujìn xuéxiào.', meaning_vi: 'Các bạn học sinh tiểu học xếp hàng bước vào trường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '新',
    pinyin: 'xīn',
    word_type: 'Tính từ',
    meaning_vi: 'mới',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我买了一本新书。', pinyin: 'Wǒ mǎi le yì běn xīn shū.', meaning_vi: 'Tôi đã mua một cuốn sách mới.', difficulty_level: 'basic' },
      { chinese: '这是我们班的新同学。', pinyin: 'Zhè shì wǒmen bān de xīn tóngxué.', meaning_vi: 'Đây là người bạn học mới của lớp chúng mình.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '星期日',
    pinyin: 'xīngqīrì',
    word_type: 'Danh từ',
    meaning_vi: 'chủ nhật',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '今天是星期日。', pinyin: 'Jīntiān shì xīngqīrì.', meaning_vi: 'Hôm nay là ngày chủ nhật.', difficulty_level: 'basic' },
      { chinese: '星期日我和朋友去公园。', pinyin: 'Xīngqīrì wǒ hé péngyou qù gōngyuán.', meaning_vi: 'Chủ nhật tôi cùng bạn bè đến công viên.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '星期天',
    pinyin: 'xīngqītiān',
    word_type: 'Danh từ',
    meaning_vi: 'chủ nhật',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '星期天你打算做什么？', pinyin: 'Xīngqītiān nǐ dǎsuan zuò shénme?', meaning_vi: 'Chủ nhật bạn dự định làm gì?', difficulty_level: 'basic' },
      { chinese: '星期天我不上班，在家休息。', pinyin: 'Xīngqītiān wǒ bú shàngbān, zài jiā xiūxi.', meaning_vi: 'Chủ nhật tôi không đi làm, ở nhà nghỉ ngơi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '休息',
    pinyin: 'xiūxi',
    word_type: 'Động từ',
    meaning_vi: 'nghỉ ngơi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '累了就休息一会儿吧。', pinyin: 'Lèi le jiù xiūxi yíhuìr ba.', meaning_vi: 'Mệt rồi thì nghỉ ngơi một chút đi.', difficulty_level: 'basic' },
      { chinese: '周末我喜欢在家里休息。', pinyin: 'Zhōumò wǒ xǐhuan zài jiā lǐ xiūxi.', meaning_vi: 'Cuối tuần tôi thích ở trong nhà nghỉ ngơi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '学',
    pinyin: 'xué',
    word_type: 'Động từ',
    meaning_vi: 'học, học tập',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我想学中文。', pinyin: 'Wǒ xiǎng xué Zhōngwén.', meaning_vi: 'Tôi muốn học tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '他在大学学中国历史。', pinyin: 'Tā zài dàxué xué Zhōngguó lìshǐ.', meaning_vi: 'Cậu ấy học lịch sử Trung Quốc ở trường đại học.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '雪',
    pinyin: 'xuě',
    word_type: 'Danh từ',
    meaning_vi: 'tuyết',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '今天下雪了。', pinyin: 'Jīntiān xiàxuě le.', meaning_vi: 'Hôm nay trời đổ tuyết rồi.', difficulty_level: 'basic' },
      { chinese: '北京冬天的雪非常漂亮。', pinyin: 'Běijīng dōngtiān de xuě fēicháng piàoliang.', meaning_vi: 'Tuyết mùa đông ở Bắc Kinh vô cùng đẹp.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM Y ---
  {
    hanzi: '要',
    pinyin: 'yào',
    word_type: 'Động từ / Động từ năng nguyện',
    meaning_vi: 'muốn, cần, phải',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我要买一瓶水。', pinyin: 'Wǒ yào mǎi yì píng shuǐ.', meaning_vi: 'Tôi muốn mua một chai nước.', difficulty_level: 'basic' },
      { chinese: '明天我要去北京出差。', pinyin: 'Míngtiān wǒ yào qù Běijīng chūchāi.', meaning_vi: 'Ngày mai tôi phải đi công tác Bắc Kinh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '也',
    pinyin: 'yě',
    word_type: 'Phó từ',
    meaning_vi: 'cũng',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我也是学生。', pinyin: 'Wǒ yě shì xuésheng.', meaning_vi: 'Tôi cũng là học sinh.', difficulty_level: 'basic' },
      { chinese: '他也喜欢吃北京烤鸭。', pinyin: 'Tā yě xǐhuan chī Běijīng kǎoyā.', meaning_vi: 'Anh ấy cũng thích ăn vịt quay Bắc Kinh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一半',
    pinyin: 'yíbàn',
    word_type: 'Danh từ / Số từ',
    meaning_vi: 'một nửa',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这块西瓜分你一半。', pinyin: 'Zhè kuài xīguā fēn nǐ yíbàn.', meaning_vi: 'Miếng dưa hấu này chia cho bạn một nửa nhé.', difficulty_level: 'basic' },
      { chinese: '这本书我已经看了一半。', pinyin: 'Zhè běn shū wǒ yǐjīng kàn le yíbàn.', meaning_vi: 'Quyển sách này tôi đã đọc được một nửa rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一下',
    pinyin: 'yíxià',
    word_type: 'Lượng từ động từ',
    meaning_vi: 'một chút, một lát',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '请等一下。', pinyin: 'Qǐng děng yíxià.', meaning_vi: 'Làm ơn đợi một lát.', difficulty_level: 'basic' },
      { chinese: '你能帮我看一眼这个句子吗？', pinyin: 'Nǐ néng bāng wǒ kàn yì yǎn zhè ge jùzi ma?', meaning_vi: 'Bạn có thể giúp tôi xem qua câu này một chút không?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一些',
    pinyin: 'yìxiē',
    word_type: 'Lượng từ / Số từ',
    meaning_vi: 'một số, một vài, một ít',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我想买一些苹果。', pinyin: 'Wǒ xiǎng mǎi yìxiē píngguǒ.', meaning_vi: 'Tôi muốn mua một ít táo.', difficulty_level: 'basic' },
      { chinese: '桌子上有一些中文书。', pinyin: 'Zhuōzi shang yǒu yìxiē Zhōngwén shū.', meaning_vi: 'Trên bàn có một vài quyển sách tiếng Trung.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '有的',
    pinyin: 'yǒude',
    word_type: 'Đại từ',
    meaning_vi: 'có cái, có người, có những',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '有的学生喜欢学汉语。', pinyin: 'Yǒude xuésheng xǐhuan xué Hànyǔ.', meaning_vi: 'Có những học sinh thích học tiếng Hán.', difficulty_level: 'basic' },
      { chinese: '这些苹果，有的是红的，有的是绿的。', pinyin: 'Zhèxiē píngguǒ, yǒude shì hóng de, yǒude shì lǜ de.', meaning_vi: 'Những quả táo này, có quả màu đỏ, có quả màu xanh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '有点儿',
    pinyin: 'yǒudiǎnr',
    word_type: 'Phó từ',
    meaning_vi: 'hơi, một chút (thường mang sắc thái tiêu cực nhẹ)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '今天有点儿冷。', pinyin: 'Jīntiān yǒudiǎnr lěng.', meaning_vi: 'Hôm nay hơi lạnh một chút.', difficulty_level: 'basic' },
      { chinese: '这个菜有点儿辣。', pinyin: 'Zhè ge cài yǒudiǎnr là.', meaning_vi: 'Món ăn này hơi cay một chút.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '有些',
    pinyin: 'yǒuxiē',
    word_type: 'Đại từ / Phó từ',
    meaning_vi: 'có một số, có phần, hơi',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '有些汉字很难写。', pinyin: 'Yǒuxiē hànzì hěn nán xiě.', meaning_vi: 'Có một số chữ Hán rất khó viết.', difficulty_level: 'basic' },
      { chinese: '听到这个消息，他有些高兴。', pinyin: 'Tīngdào zhè ge xiāoxi, tā yǒuxiē gāoxìng.', meaning_vi: 'Nghe được tin này, anh ấy có phần vui mừng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '雨',
    pinyin: 'yǔ',
    word_type: 'Danh từ',
    meaning_vi: 'mưa, cơn mưa',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '今天外面在下雨。', pinyin: 'Jīntiān wàimiàn zài xiàyǔ.', meaning_vi: 'Hôm nay bên ngoài đang mưa.', difficulty_level: 'basic' },
      { chinese: '雨停了，我们走吧。', pinyin: 'Yǔ tíng le, wǒmen zǒu ba.', meaning_vi: 'Mưa tạnh rồi, chúng mình đi thôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '元',
    pinyin: 'yuán',
    word_type: 'Lượng từ',
    meaning_vi: 'đồng (nhân dân tệ - văn viết)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这本书五十元。', pinyin: 'Zhè běn shū wǔshí yuán.', meaning_vi: 'Quyển sách này năm mươi nhân dân tệ.', difficulty_level: 'basic' },
      { chinese: '这瓶水两元钱。', pinyin: 'Zhè píng shuǐ liǎng yuán qián.', meaning_vi: 'Chai nước này hai tệ.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM Z ---
  {
    hanzi: '再',
    pinyin: 'zài',
    word_type: 'Phó từ',
    meaning_vi: 'lại, nữa (hành động lặp lại trong tương lai)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '欢迎下次再来！', pinyin: 'Huānyíng xià cì zài lái!', meaning_vi: 'Hoan nghênh lần sau lại ghé thăm!', difficulty_level: 'basic' },
      { chinese: '请你说得慢一点儿，再说一遍。', pinyin: 'Qǐng nǐ shuō de màn yìdiǎnr, zài shuō yí biàn.', meaning_vi: 'Làm ơn nói chậm một chút và nói lại một lần nữa nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '早',
    pinyin: 'zǎo',
    word_type: 'Tính từ',
    meaning_vi: 'sớm; chào buổi sáng',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '老师，早上好！——你早！', pinyin: 'Lǎoshī, zǎoshang hǎo! —— Nǐ zǎo!', meaning_vi: 'Chào buổi sáng cô giáo! —— Chào em!', difficulty_level: 'basic' },
      { chinese: '今天早上他来得非常早。', pinyin: 'Jīntiān zǎoshang tā lái de fēicháng zǎo.', meaning_vi: 'Sáng nay anh ấy đến rất sớm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '早饭',
    pinyin: 'zǎofàn',
    word_type: 'Danh từ',
    meaning_vi: 'bữa sáng, cơm sáng',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '早饭我吃包子和牛奶。', pinyin: 'Zǎofàn wǒ chī bāozi hé niúnǎi.', meaning_vi: 'Bữa sáng tôi ăn bánh bao và sữa tươi.', difficulty_level: 'basic' },
      { chinese: '你今天吃早饭了吗？', pinyin: 'Nǐ jīntiān chī zǎofàn le ma?', meaning_vi: 'Hôm nay bạn đã ăn bữa sáng chưa?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '早上',
    pinyin: 'zǎoshang',
    word_type: 'Danh từ',
    meaning_vi: 'buổi sáng',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '早上好！', pinyin: 'Zǎoshang hǎo!', meaning_vi: 'Chào buổi sáng!', difficulty_level: 'basic' },
      { chinese: '我每天早上七点起床跑步。', pinyin: 'Wǒ měitiān zǎoshang qī diǎn qǐchuáng pǎobù.', meaning_vi: 'Mỗi sáng bảy giờ tôi thức dậy chạy bộ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '找',
    pinyin: 'zhǎo',
    word_type: 'Động từ',
    meaning_vi: 'tìm, kiếm; thối tiền thừa',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '你在找什么？', pinyin: 'Nǐ zài zhǎo shénme?', meaning_vi: 'Bạn đang tìm kiếm cái gì thế?', difficulty_level: 'basic' },
      { chinese: '我找不到我的手机了。', pinyin: 'Wǒ zhǎobudào wǒ de shǒujī le.', meaning_vi: 'Tôi không tìm thấy chiếc điện thoại của mình rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '这边',
    pinyin: 'zhèbian',
    word_type: 'Danh từ',
    meaning_vi: 'bên này, phía này',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '请往这边走。', pinyin: 'Qǐng wǎng zhèbian zǒu.', meaning_vi: 'Làm ơn đi về phía bên này.', difficulty_level: 'basic' },
      { chinese: '这边坐着很多人。', pinyin: 'Zhèbian zuò zhe hěn duō rén.', meaning_vi: 'Phía bên này đang có rất nhiều người ngồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '这个',
    pinyin: 'zhè ge',
    word_type: 'Đại từ',
    meaning_vi: 'cái này, việc này',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这个苹果很甜。', pinyin: 'Zhè ge píngguǒ hěn tián.', meaning_vi: 'Quả táo này rất ngọt.', difficulty_level: 'basic' },
      { chinese: '这个字怎么读？', pinyin: 'Zhè ge zì zěnme dú?', meaning_vi: 'Chữ này đọc như thế nào vậy?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '这里',
    pinyin: 'zhèlǐ',
    word_type: 'Đại từ',
    meaning_vi: 'ở đây, chỗ này',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这里是北京大学。', pinyin: 'Zhèlǐ shì Běijīng Dàxué.', meaning_vi: 'Đây là Đại học Bắc Kinh.', difficulty_level: 'basic' },
      { chinese: '这里的天气比我家乡冷。', pinyin: 'Zhèlǐ de tiānqì bǐ wǒ jiāxiāng lěng.', meaning_vi: 'Thời tiết ở đây lạnh hơn quê tôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '这儿',
    pinyin: 'zhèr',
    word_type: 'Đại từ',
    meaning_vi: 'chỗ này, đây',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '请坐在聘儿。', pinyin: 'Qǐng zuò zài zhèr.', meaning_vi: 'Xin mời ngồi ở chỗ này.', difficulty_level: 'basic' },
      { chinese: '这儿有一家很好的中国餐厅。', pinyin: 'Zhèr yǒu yì jiā hěn hǎo de Zhōngguó cāntīng.', meaning_vi: 'Ở đây có một nhà hàng Trung Quốc rất ngon.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '这些',
    pinyin: 'zhèxiē',
    word_type: 'Đại từ',
    meaning_vi: 'những cái này, những thứ này',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这些书是我的。', pinyin: 'Zhèxiē shū shì wǒ de.', meaning_vi: 'Những cuốn sách này là của tôi.', difficulty_level: 'basic' },
      { chinese: '这些水果非常新鲜。', pinyin: 'Zhèxiē shuǐguǒ fēicháng xīnxiān.', meaning_vi: 'Những hoa quả này rất tươi ngon.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '真',
    pinyin: 'zhēn',
    word_type: 'Phó từ',
    meaning_vi: 'thật, thật là',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '今天天气真好！', pinyin: 'Jīntiān tiānqì zhēn hǎo!', meaning_vi: 'Hôm nay thời tiết thật là đẹp!', difficulty_level: 'basic' },
      { chinese: '这道菜真好吃。', pinyin: 'Zhè dào cài zhēn hǎochī.', meaning_vi: 'Món ăn này thật là ngon.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '正在',
    pinyin: 'zhèngzài',
    word_type: 'Phó từ',
    meaning_vi: 'đang (chỉ hành động đang diễn ra)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '他正在睡觉。', pinyin: 'Tā zhèngzài shuìjiào.', meaning_vi: 'Anh ấy đang ngủ.', difficulty_level: 'basic' },
      { chinese: '老师正在给我们讲课。', pinyin: 'Lǎoshī zhèngzài gěi wǒmen jiǎngkè.', meaning_vi: 'Cô giáo đang giảng bài cho chúng tôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '只',
    pinyin: 'zhǐ',
    word_type: 'Phó từ',
    meaning_vi: 'chỉ, chỉ có',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我只有一个苹果。', pinyin: 'Wǒ zhǐ yǒu yí gè píngguǒ.', meaning_vi: 'Tôi chỉ có một quả táo.', difficulty_level: 'basic' },
      { chinese: '他只会说一点儿中文。', pinyin: 'Tā zhǐ huì shuō yìdiǎnr Zhōngwén.', meaning_vi: 'Anh ấy chỉ biết nói một chút tiếng Trung thôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '知道',
    pinyin: 'zhīdào',
    word_type: 'Động từ',
    meaning_vi: 'biết, hiểu rõ',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我知道他的名字。', pinyin: 'Wǒ zhīdào tā de míngzi.', meaning_vi: 'Tôi biết tên của anh ấy.', difficulty_level: 'basic' },
      { chinese: '你知道去火车站怎么走吗？', pinyin: 'Nǐ zhīdào qù huǒchēzhàn zěnme zǒu ma?', meaning_vi: 'Bạn có biết đường đi đến ga tàu hỏa đi như thế nào không?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '中文',
    pinyin: 'Zhōngwén',
    word_type: 'Danh từ',
    meaning_vi: 'tiếng Trung, Trung văn',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我喜欢学中文。', pinyin: 'Wǒ xǐhuan xué Zhōngwén.', meaning_vi: 'Tôi thích học tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '他会说流利的中文。', pinyin: 'Tā huì shuō liúlì de Zhōngwén.', meaning_vi: 'Anh ấy có thể nói tiếng Trung rất lưu loát.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '中学',
    pinyin: 'zhōngxué',
    word_type: 'Danh từ',
    meaning_vi: 'trường trung học (cấp 2, cấp 3)',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '这是一所中学。', pinyin: 'Zhè shì yì suǒ zhōngxué.', meaning_vi: 'Đây là một ngôi trường trung học.', difficulty_level: 'basic' },
      { chinese: '哥哥在这所中学当数学老师。', pinyin: 'Gēge zài zhè suǒ zhōngxué dāng shùxué lǎoshī.', meaning_vi: 'Anh trai làm giáo viên toán ở trường trung học này.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '中学生',
    pinyin: 'zhōngxuéshēng',
    word_type: 'Danh từ',
    meaning_vi: 'học sinh trung học',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '我哥哥是中学生。', pinyin: 'Wǒ gēge shì zhōngxuéshēng.', meaning_vi: 'Anh trai tôi là học sinh trung học.', difficulty_level: 'basic' },
      { chinese: '这些中学生每天都起得很早。', pinyin: 'Zhèxiē zhōngxuéshēng měitiān dōu qǐ de hěn zǎo.', meaning_vi: 'Các bạn học sinh trung học này mỗi ngày đều dậy rất sớm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '做饭',
    pinyin: 'zuòfàn',
    word_type: 'Động từ',
    meaning_vi: 'nấu cơm, nấu ăn',
    hsk_level: 'HSK 1',
    examples: [
      { chinese: '妈妈正在厨房做饭。', pinyin: 'Māma zhèngzài chúfáng zuòfàn.', meaning_vi: 'Mẹ đang nấu cơm trong bếp.', difficulty_level: 'basic' },
      { chinese: '周末我经常自己在家做饭吃。', pinyin: 'Zhōumò wǒ jīngcháng zìjǐ zài jiā zuòfàn chī.', meaning_vi: 'Cuối tuần tôi thường tự nấu cơm ăn ở nhà.', difficulty_level: 'applied' }
    ]
  }
];
