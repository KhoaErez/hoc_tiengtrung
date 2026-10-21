// ====================================================================
// DANH MỤC 255 TỪ VỰNG CÒN THIẾU CỦA HSK 3 - PHẦN 1 (85 TỪ: #503 -> #664)
// Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / Chinese Test International 11/2025)
// ====================================================================

export interface Hsk3WordItem {
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

export const HSK3_MISSING_PART1: Hsk3WordItem[] = [
  {
    hanzi: '爱人',
    pinyin: 'àiren',
    word_type: 'Danh từ',
    meaning_vi: 'người bạn đời, chồng / vợ',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我和爱人一起去超市买菜。', pinyin: 'Wǒ hé àiren yìqǐ qù chāoshì mǎi cài.', meaning_vi: 'Tôi và người bạn đời cùng đi siêu thị mua thức ăn.', difficulty_level: 'basic' },
      { chinese: '他经常在周末陪爱人散步聊天。', pinyin: 'Tā jīngcháng zài zhōumò péi àiren sànbù liáotiān.', meaning_vi: 'Anh ấy thường vào cuối tuần đi dạo trò chuyện cùng vợ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '安全',
    pinyin: 'ānquán',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'an toàn',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '骑车的时候要注意安全。', pinyin: 'Qí chē de shíhou yào zhùyì ānquán.', meaning_vi: 'Khi đi xe đạp/xe máy cần chú ý an toàn.', difficulty_level: 'basic' },
      { chinese: '住在这个小区里既方便又安全。', pinyin: 'Zhù zài zhè ge xiǎoqū lǐ jì fāngbiàn yòu ānquán.', meaning_vi: 'Sống trong khu dân cư này vừa tiện lợi lại vừa an toàn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '班级',
    pinyin: 'bānjí',
    word_type: 'Danh từ',
    meaning_vi: 'lớp học, tập thể lớp',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我们班级有三十个学生。', pinyin: 'Wǒmen bānjí yǒu sānshí gè xuésheng.', meaning_vi: 'Lớp học của chúng tôi có ba mươi học sinh.', difficulty_level: 'basic' },
      { chinese: '大家都为班级的荣誉而努力。', pinyin: 'Dàjiā dōu wèi bānjí de róngyù ér nǔlì.', meaning_vi: 'Mọi người đều nỗ lực vì danh dự của tập thể lớp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '搬家',
    pinyin: 'bānjiā',
    word_type: 'Động từ',
    meaning_vi: 'chuyển nhà',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '下个星期我们就要搬家了。', pinyin: 'Xià gè xīngqī wǒmen jiù yào bānjiā le.', meaning_vi: 'Tuần sau chúng tôi phải chuyển nhà rồi.', difficulty_level: 'basic' },
      { chinese: '搬家虽然很累，但是住进新房很高兴。', pinyin: 'Bānjiā suīrán hěn lèi, dànshì zhù jìn xīnfáng hěn gāoxìng.', meaning_vi: 'Chuyển nhà tuy rất mệt nhưng dọn vào nhà mới rất vui.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '办',
    pinyin: 'bàn',
    word_type: 'Động từ',
    meaning_vi: 'làm, giải quyết, xử lý',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '这件事情不好办。', pinyin: 'Zhè jiàn shìqing bù hǎo bàn.', meaning_vi: 'Chuyện này không dễ xử lý.', difficulty_level: 'basic' },
      { chinese: '我想去银行办一张新的银行卡。', pinyin: 'Wǒ xiǎng qù yínháng bàn yì zhāng xīn de yínhángkǎ.', meaning_vi: 'Tôi muốn đến ngân hàng làm một chiếc thẻ ngân hàng mới.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '笔记',
    pinyin: 'bǐjì',
    word_type: 'Danh từ',
    meaning_vi: 'ghi chép, vở ghi',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '上课要认真记笔记。', pinyin: 'Shàngkè yào rènzhēn jì bǐjì.', meaning_vi: 'Trong giờ học phải ghi chép cẩn thận.', difficulty_level: 'basic' },
      { chinese: '借我看一下你的汉语课堂笔记好吗？', pinyin: 'Jiè wǒ kàn yíxià nǐ de Hànyǔ kètáng bǐjì hǎo ma?', meaning_vi: 'Cho tôi mượn xem vở ghi chép lớp tiếng Trung của bạn được không?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '比如',
    pinyin: 'bǐrú',
    word_type: 'Động từ / Liên từ',
    meaning_vi: 'ví dụ, chẳng hạn như',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '许多水果我都喜欢，比如苹果和香蕉。', pinyin: 'Xǔduō shuǐguǒ wǒ dōu xǐhuan, bǐrú píngguǒ hé xiāngjiāo.', meaning_vi: 'Nhiều loại trái cây tôi đều thích, ví dụ như táo và chuối.', difficulty_level: 'basic' },
      { chinese: '如果你遇到困难，比如迷路了，可以给我打电话。', pinyin: 'Rúguǒ nǐ yù dào kùnnan, bǐrú mílù le, kěyǐ gěi wǒ dǎ diànhuà.', meaning_vi: 'Nếu bạn gặp khó khăn, chẳng hạn như bị lạc đường, có thể gọi điện cho tôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '变',
    pinyin: 'biàn',
    word_type: 'Động từ',
    meaning_vi: 'thay đổi, biến đổi',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '天气变冷了，多穿点儿衣服吧。', pinyin: 'Tiānqì biàn lěng le, duō chuān diǎnr yīfu ba.', meaning_vi: 'Thời tiết đã trở lạnh rồi, mặc thêm chút áo ấm đi.', difficulty_level: 'basic' },
      { chinese: '几年没见，家乡的变化真大。', pinyin: 'Jǐ nián méi jiàn, jiāxiāng de biànhuà zhēn dà.', meaning_vi: 'Mấy năm không gặp, sự thay đổi của quê hương thật to lớn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '遍',
    pinyin: 'biàn',
    word_type: 'Lượng từ',
    meaning_vi: 'lần, lượt (từ đầu đến cuối)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '请你再说一遍。', pinyin: 'Qǐng nǐ zài shuō yí biàn.', meaning_vi: 'Xin bạn hãy nói lại một lần nữa.', difficulty_level: 'basic' },
      { chinese: '这本小说很有趣，我已经读了三遍了。', pinyin: 'Zhè běn xiǎoshuō hěn yǒuqù, wǒ yǐjīng dú le sān biàn le.', meaning_vi: 'Cuốn tiểu thuyết này rất thú vị, tôi đã đọc ba lần rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '变成',
    pinyin: 'biànchéng',
    word_type: 'Động từ',
    meaning_vi: 'trở thành, biến thành',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '水在零度以下会变成冰。', pinyin: 'Shuǐ zài líng dù yǐxià huì biànchéng bīng.', meaning_vi: 'Nước ở dưới 0 độ sẽ biến thành băng.', difficulty_level: 'basic' },
      { chinese: '经过不断努力，他变成了一名优秀的医生。', pinyin: 'Jīngguò búduàn nǔlì, tā biànchéng le yì míng yōuxiù de yīshēng.', meaning_vi: 'Trải qua không ngừng nỗ lực, anh ấy đã trở thành một bác sĩ xuất sắc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '表演',
    pinyin: 'biǎoyǎn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'biểu diễn, màn biểu diễn',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '今晚有精彩的音乐表演。', pinyin: 'Jīnwǎn yǒu jīngcǎi de yīnyuè biǎoyǎn.', meaning_vi: 'Tối nay có buổi biểu diễn âm nhạc đặc sắc.', difficulty_level: 'basic' },
      { chinese: '孩子们在舞台上表演得非常出色。', pinyin: 'Háizimen zài wǔtái shang biǎoyǎn de fēicháng chūsè.', meaning_vi: 'Các em nhỏ biểu diễn trên sân khấu vô cùng xuất sắc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '冰',
    pinyin: 'bīng',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'băng, đá, lạnh buốt',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我想喝一杯加冰的柠檬水。', pinyin: 'Wǒ xiǎng hē yì bēi jiā bīng de níngméngshuǐ.', meaning_vi: 'Tôi muốn uống một ly nước chanh thêm đá.', difficulty_level: 'basic' },
      { chinese: '冬天的河面上结了厚厚的一层冰。', pinyin: 'Dōngtiān de hémiàn shang jié le hòuhòu de yì céng bīng.', meaning_vi: 'Trên mặt sông vào mùa đông đóng một lớp băng dày.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '冰激凌',
    pinyin: 'bīngjīlíng',
    word_type: 'Danh từ',
    meaning_vi: 'kem, que kem',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '夏天吃冰激凌真舒服。', pinyin: 'Xiàtiān chī bīngjīlíng zhēn shūfu.', meaning_vi: 'Mùa hè ăn kem thật dễ chịu.', difficulty_level: 'basic' },
      { chinese: '小朋友最喜欢巧克力味的冰激凌。', pinyin: 'Xiǎopéngyou zuì xǐhuan qiǎokèlì wèi de bīngjīlíng.', meaning_vi: 'Trẻ con thích nhất là kem vị sô-cô-la.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不但',
    pinyin: 'búdàn',
    word_type: 'Liên từ',
    meaning_vi: 'không những, không chỉ',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '他不但聪明，而且很努力。', pinyin: 'Tā búdàn cōngmíng, érqiě hěn nǔlì.', meaning_vi: 'Anh ấy không những thông minh mà còn rất chăm chỉ.', difficulty_level: 'basic' },
      { chinese: '这家餐厅不但环境优雅，菜的味道也很地道。', pinyin: 'Zhè jiā cāntīng búdàn huánjìng yōuyǎ, cài de wèidao yě hěn dìdao.', meaning_vi: 'Nhà hàng này không những không gian tao nhã mà hương vị món ăn cũng rất chuẩn vị.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不见',
    pinyin: 'bújiàn',
    word_type: 'Động từ',
    meaning_vi: 'không thấy, biến mất, thất lạc',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我的钥匙不见了。', pinyin: 'Wǒ de yàoshi bújiàn le.', meaning_vi: 'Chìa khóa của tôi không thấy đâu rồi.', difficulty_level: 'basic' },
      { chinese: '刚才还在桌上的手机怎么一转眼就不见了？', pinyin: 'Gāngcái hái zài zhuō shang de shǒujī zěnme yì zhuǎnyǎn jiù bújiàn le?', meaning_vi: 'Điện thoại vừa nãy còn trên bàn sao chớp mắt một cái đã không thấy nữa rồi?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不用',
    pinyin: 'búyòng',
    word_type: 'Phó từ',
    meaning_vi: 'không cần',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '今天不用上班，我们去公园吧。', pinyin: 'Jīntiān búyòng shàngbān, wǒmen qù gōngyuán ba.', meaning_vi: 'Hôm nay không cần đi làm, chúng ta đi công viên nhé.', difficulty_level: 'basic' },
      { chinese: '离这里很近，不用坐车，走路五分钟就到了。', pinyin: 'Lí zhèlǐ hěn jìn, búyòng zuò chē, zǒulù wǔ fēnzhōng jiù dào le.', meaning_vi: 'Cách đây rất gần, không cần đi xe, đi bộ năm phút là tới.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不同',
    pinyin: 'bù tóng',
    word_type: 'Tính từ / Cụm từ',
    meaning_vi: 'khác biệt, không giống nhau',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我们俩的想法完全不同。', pinyin: 'Wǒmen liǎ de xiǎngfǎ wánquán bù tóng.', meaning_vi: 'Suy nghĩ của hai chúng tôi hoàn toàn khác nhau.', difficulty_level: 'basic' },
      { chinese: '每个人来自不同的国家，说着不同的语言。', pinyin: 'Měi gè rén láizì bù tóng de guójiā, shuō zhe bù tóng de yǔyán.', meaning_vi: 'Mỗi người đến từ những quốc gia khác nhau, nói những ngôn ngữ khác nhau.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不久',
    pinyin: 'bùjiǔ',
    word_type: 'Danh từ / Phó từ',
    meaning_vi: 'chẳng bao lâu, không lâu sau',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '他来中国不久，但汉语说得很好。', pinyin: 'Tā lái Zhōngguó bùjiǔ, dàn Hànyǔ shuō de hěn hǎo.', meaning_vi: 'Anh ấy đến Trung Quốc chưa lâu, nhưng nói tiếng Trung rất tốt.', difficulty_level: 'basic' },
      { chinese: '毕业不久，她就找到了心仪的工作。', pinyin: 'Bìyè bùjiǔ, tā jiù zhǎodào le xīnyí de gōngzuò.', meaning_vi: 'Tốt nghiệp không lâu, cô ấy đã tìm được công việc ưng ý.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不行',
    pinyin: 'bùxíng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'không được, không ổn, kém',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '今天晚上我有事，不行去打球。', pinyin: 'Jīntiān wǎnshang wǒ yǒushì, bùxíng qù dǎ qiú.', meaning_vi: 'Tối nay tôi có việc bận, không thể đi đánh bóng được.', difficulty_level: 'basic' },
      { chinese: '我的电脑坏了，完全开不了机，这台真不行了。', pinyin: 'Wǒ de diànnǎo huài le, wánquán kāi bù liǎo jī, zhè tái zhēn bùxíng le.', meaning_vi: 'Máy tính của tôi hỏng rồi, hoàn toàn không mở lên được, chiếc này thực sự hỏng hẳn rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '才',
    pinyin: 'cái',
    word_type: 'Phó từ',
    meaning_vi: 'mới (chỉ hành động muộn hoặc số lượng ít)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '你怎么现在才来？', pinyin: 'Nǐ zěnme xiànzài cái lái?', meaning_vi: 'Sao bây giờ bạn mới tới?', difficulty_level: 'basic' },
      { chinese: '这本书才二十块钱，非常便宜。', pinyin: 'Zhè běn shū cái èrshí kuài qián, fēicháng piányi.', meaning_vi: 'Cuốn sách này mới có hai mươi tệ, rất rẻ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '草地',
    pinyin: 'cǎodì',
    word_type: 'Danh từ',
    meaning_vi: 'bãi cỏ',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '小狗在草地上跑来跑去。', pinyin: 'Xiǎogǒu zài cǎodì shang pǎo lái pǎo qù.', meaning_vi: 'Chú chó nhỏ chạy đi chạy lại trên bãi cỏ.', difficulty_level: 'basic' },
      { chinese: '周末许多家庭都在公园的绿草地上野餐。', pinyin: 'Zhōumò xǔduō jiātíng dōu zài gōngyuán de lǜ cǎodì shang yěcān.', meaning_vi: 'Cuối tuần nhiều gia đình đều dã ngoại trên bãi cỏ xanh của công viên.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '查',
    pinyin: 'chá',
    word_type: 'Động từ',
    meaning_vi: 'tra cứu, kiểm tra',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '遇到不认识的生词可以查字典。', pinyin: 'Yù dào bú rènshi de shēngcí kěyǐ chá zìdiǎn.', meaning_vi: 'Gặp từ mới không biết có thể tra từ điển.', difficulty_level: 'basic' },
      { chinese: '出门前最好先上网查一下今天的天气和路线。', pinyin: 'Chūmén qián zuìhǎo xiān shàngwǎng chá yíxià jīntiān de tiānqì hé lùxiàn.', meaning_vi: 'Trước khi ra ngoài tốt nhất nên lên mạng tra cứu trước thời tiết và lộ trình hôm nay.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '差不多',
    pinyin: 'chàbuduō',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'xấp xỉ, gần như, tương đương',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '今天的作业我差不多做完了。', pinyin: 'Jīntiān de zuòyè wǒ chàbuduō zuò wán le.', meaning_vi: 'Bài tập hôm nay tôi gần như làm xong rồi.', difficulty_level: 'basic' },
      { chinese: '这两个包的颜色和款式都差不多。', pinyin: 'Zhè liǎng gè bāo de yánsè hé kuǎnshì dōu chàbuduō.', meaning_vi: 'Màu sắc và kiểu dáng của hai chiếc túi này xấp xỉ như nhau.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '尝',
    pinyin: 'cháng',
    word_type: 'Động từ',
    meaning_vi: 'nếm thử',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '你尝尝这个菜好吃不好吃。', pinyin: 'Nǐ chángchang zhè ge cài hǎochī bù hǎochī.', meaning_vi: 'Bạn nếm thử xem món ăn này có ngon không.', difficulty_level: 'basic' },
      { chinese: '这是妈妈特意为你做的点心，快尝一口吧。', pinyin: 'Zhè shì māma tèyì wèi nǐ zuò de diǎnxin, kuài cháng yì kǒu ba.', meaning_vi: 'Đây là điểm tâm mẹ đặc biệt làm cho con, mau nếm thử một miếng đi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '常',
    pinyin: 'cháng',
    word_type: 'Phó từ',
    meaning_vi: 'thường, hay',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我常去图书馆看书。', pinyin: 'Wǒ cháng qù túshūguǎn kàn shū.', meaning_vi: 'Tôi thường đến thư viện đọc sách.', difficulty_level: 'basic' },
      { chinese: '工作再忙也要常给家里打电话问候。', pinyin: 'Gōngzuò zài máng yě yào cháng gěi jiālǐ dǎ diànhuà wènhòu.', meaning_vi: 'Công việc dù bận rộn cũng nên thường xuyên gọi điện về nhà thăm hỏi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '常见',
    pinyin: 'cháng jiàn',
    word_type: 'Tính từ / Cụm từ',
    meaning_vi: 'thường thấy, phổ biến',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '感冒是冬天很常见的病。', pinyin: 'Gǎnmào shì dōngtiān hěn chángjiàn de bìng.', meaning_vi: 'Cảm cúm là căn bệnh rất thường thấy vào mùa đông.', difficulty_level: 'basic' },
      { chinese: '这种花在南方很常见，北方比较少见。', pinyin: 'Zhè zhǒng huā zài nánfāng hěn chángjiàn, běifāng bǐjiào shǎojiàn.', meaning_vi: 'Loại hoa này ở miền nam rất phổ biến, còn miền bắc thì tương đối hiếm thấy.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '常用',
    pinyin: 'cháng yòng',
    word_type: 'Tính từ / Cụm từ',
    meaning_vi: 'thường dùng, thông dụng',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '这是学汉语最常用的一千个词。', pinyin: 'Zhè shì xué Hànyǔ zuì chángyòng de yìqiān gè cí.', meaning_vi: 'Đây là một ngàn từ thông dụng nhất khi học tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '把常用的软件放在手机桌面上会方便很多。', pinyin: 'Bǎ chángyòng de ruǎnjiàn fàng zài shǒujī zhuōmiàn shang huì fāngbiàn hěn duō.', meaning_vi: 'Để các phần mềm thường dùng trên màn hình điện thoại sẽ tiện hơn rất nhiều.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '常常',
    pinyin: 'chángcháng',
    word_type: 'Phó từ',
    meaning_vi: 'thường xuyên, hay',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我们常常在一起学习汉语。', pinyin: 'Wǒmen chángcháng zài yìqǐ xuéxí Hànyǔ.', meaning_vi: 'Chúng tôi thường xuyên cùng nhau học tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '遇到难题的时候，他常常主动向老师请教。', pinyin: 'Yù dào nántí de shíhou, tā chángcháng zhǔdòng xiàng lǎoshī qǐngjiào.', meaning_vi: 'Khi gặp phải bài toán khó, cậu ấy thường chủ động xin thầy cô chỉ bảo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出发',
    pinyin: 'chūfā',
    word_type: 'Động từ',
    meaning_vi: 'xuất phát, khởi hành',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我们明天早上七点准时出发。', pinyin: 'Wǒmen míngtiān zǎoshang qī diǎn zhǔnshí chūfā.', meaning_vi: 'Chúng ta sáng mai bảy giờ đúng sẽ xuất phát.', difficulty_level: 'basic' },
      { chinese: '带好随身行李，大家准备出发去机场了。', pinyin: 'Dài hǎo suíshēn xíngli, dàjiā zhǔnbèi chūfā qù jīchǎng le.', meaning_vi: 'Mang theo đầy đủ hành lý cá nhân, mọi người chuẩn bị khởi hành ra sân bay rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出生',
    pinyin: 'chūshēng',
    word_type: 'Động từ',
    meaning_vi: 'sinh ra, chào đời',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '他在北京出生，在上海长大。', pinyin: 'Tā zài Běijīng chūshēng, zài Shànghǎi zhǎngdà.', meaning_vi: 'Anh ấy sinh ra ở Bắc Kinh, lớn lên ở Thượng Hải.', difficulty_level: 'basic' },
      { chinese: '请在表格上填写您的出生日期和地点。', pinyin: 'Qǐng zài biǎogé shang tiánxiě nín de chūshēng rìqī hé dìdiǎn.', meaning_vi: 'Xin hãy điền ngày tháng năm sinh và nơi sinh của bạn vào biểu mẫu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出院',
    pinyin: 'chūyuàn',
    word_type: 'Động từ',
    meaning_vi: 'xuất viện',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '医生说他明天就可以出院了。', pinyin: 'Yīshēng shuō tā míngtiān jiù kěyǐ chūyuàn le.', meaning_vi: 'Bác sĩ bảo ngày mai anh ấy có thể xuất viện rồi.', difficulty_level: 'basic' },
      { chinese: '身体完全康复之后，爷爷高高兴兴地出院回家了。', pinyin: 'Shēntǐ wánquán kāngfù zhīhòu, yéye gāogāoxìngxìng de chūyuàn huí jiā le.', meaning_vi: 'Sau khi cơ thể hoàn toàn bình phục, ông nội vui vẻ xuất viện về nhà.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '初中',
    pinyin: 'chūzhōng',
    word_type: 'Danh từ',
    meaning_vi: 'trung học cơ sở, cấp 2',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我弟弟正在读初中二年级。', pinyin: 'Wǒ dìdi zhèngzài dú chūzhōng èr niánjí.', meaning_vi: 'Em trai tôi đang học lớp 8 (năm hai THCS).', difficulty_level: 'basic' },
      { chinese: '初中时代的朋友往往感情最深厚。', pinyin: 'Chūzhōng shídài de péngyou wǎngwǎng gǎnqíng zuì shēnhòu.', meaning_vi: 'Những người bạn thời cấp hai thường có tình cảm sâu đậm nhất.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '春天',
    pinyin: 'chūntiān',
    word_type: 'Danh từ',
    meaning_vi: 'mùa xuân',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '春天来了，树木都变绿了。', pinyin: 'Chūntiān lái le, shùmù dōu biàn lǜ le.', meaning_vi: 'Mùa xuân đến rồi, cây cối đều xanh tươi trở lại.', difficulty_level: 'basic' },
      { chinese: '春天是最适合去户外踏青赏花的季节。', pinyin: 'Chūntiān shì zuì shìhé qù hùwài tàqīng shǎng huā de jìjié.', meaning_vi: 'Mùa xuân là mùa thích hợp nhất để ra ngoài dã ngoại ngắm hoa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大概',
    pinyin: 'dàgài',
    word_type: 'Phó từ / Tính từ',
    meaning_vi: 'khoảng chừng, có lẽ, đại khái',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '从这里到车站大概需要二十分钟。', pinyin: 'Cóng zhèlǐ dào chēzhàn dàgài xūyào èrshí fēnzhōng.', meaning_vi: 'Từ đây đến ga khoảng chừng mất hai mươi phút.', difficulty_level: 'basic' },
      { chinese: '他今天没来上班，大概是因为生病了吧。', pinyin: 'Tā jīntiān méi lái shàngbān, dàgài shì yīnwèi shēngbìng le ba.', meaning_vi: 'Hôm nay anh ấy không đi làm, có lẽ là do bị ốm rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大人',
    pinyin: 'dàren',
    word_type: 'Danh từ',
    meaning_vi: 'người lớn',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '小孩子要听大人的话。', pinyin: 'Xiǎoháizi yào tīng dàren de huà.', meaning_vi: 'Trẻ con cần nghe lời người lớn.', difficulty_level: 'basic' },
      { chinese: '游泳池深水区只允许大人进入。', pinyin: 'Yóuyǒngchí shēnshuǐ qū zhǐ yǔnxǔ dàren jìnrù.', meaning_vi: 'Khu vực nước sâu của bể bơi chỉ cho phép người lớn vào.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大小',
    pinyin: 'dàxiǎo',
    word_type: 'Danh từ',
    meaning_vi: 'kích cỡ, độ lớn nhỏ',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '这双鞋的大小正合适。', pinyin: 'Zhè shuāng xié de dàxiǎo zhèng héshì.', meaning_vi: 'Kích cỡ của đôi giày này vừa vặn.', difficulty_level: 'basic' },
      { chinese: '买衣服前请先确认好衣服的大小尺码。', pinyin: 'Mǎi yīfu qián qǐng xiān quèrèn hǎo yīfu de dàxiǎo chǐmǎ.', meaning_vi: 'Trước khi mua quần áo xin hãy xác nhận kích cỡ và số đo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大熊猫',
    pinyin: 'dàxióngmāo',
    word_type: 'Danh từ',
    meaning_vi: 'gấu trúc khổng lồ',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '大熊猫是中国的国宝。', pinyin: 'Dàxióngmāo shì Zhōngguó de guóbǎo.', meaning_vi: 'Gấu trúc là quốc bảo của Trung Quốc.', difficulty_level: 'basic' },
      { chinese: '动物园里的大熊猫正在安静地吃着竹子。', pinyin: 'Dòngwùyuán lǐ de dàxióngmāo zhèngzài ānjìng de chī zhe zhúzi.', meaning_vi: 'Chú gấu trúc trong sở thú đang yên lặng ăn lá trúc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大衣',
    pinyin: 'dàyī',
    word_type: 'Danh từ',
    meaning_vi: 'áo khoác dạ, áo choàng lớn',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '外面冷，穿上一件大衣吧。', pinyin: 'Wàimiàn lěng, chuān shang yí jiàn dàyī ba.', meaning_vi: 'Bên ngoài lạnh, mặc thêm một chiếc áo khoác lớn đi.', difficulty_level: 'basic' },
      { chinese: '这件黑色的大衣看起来既暖和又帅气。', pinyin: 'Zhè jiàn hēisè de dàyī kàn qǐlái jì nuǎnhuo yòu shuàiqì.', meaning_vi: 'Chiếc áo khoác dạ màu đen này trông vừa ấm áp lại vừa lịch lãm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '到处',
    pinyin: 'dàochù',
    word_type: 'Phó từ / Danh từ',
    meaning_vi: 'khắp nơi, mọi nơi',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '公园里到处都是漂亮的花。', pinyin: 'Gōngyuán lǐ dàochù dōu shì piàoliang de huā.', meaning_vi: 'Trong công viên khắp nơi đều là hoa đẹp.', difficulty_level: 'basic' },
      { chinese: '春天来了，山坡上到处充满生机。', pinyin: 'Chūntiān lái le, shānpō shang dàochù chōngmǎn shēngjī.', meaning_vi: 'Mùa xuân đến rồi, trên sườn núi khắp nơi ngập tràn sức sống.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '得',
    pinyin: 'dé',
    word_type: 'Động từ',
    meaning_vi: 'đạt được, nhận được, mắc (bệnh)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '他在比赛中得了第一名。', pinyin: 'Tā zài bǐsài zhōng dé le dì-yī míng.', meaning_vi: 'Anh ấy đã đạt giải nhất trong cuộc thi.', difficulty_level: 'basic' },
      { chinese: '由于天气突然变冷，他不小心得了重感冒。', pinyin: 'Yóuyú tiānqì tūrán biàn lěng, tā bù xiǎoxīn dé le zhòng gǎnmào.', meaning_vi: 'Do thời tiết đột ngột trở lạnh, anh ấy sơ ý bị cảm nặng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '得到',
    pinyin: 'dédào',
    word_type: 'Động từ',
    meaning_vi: 'nhận được, có được',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '他得到了老师和同学的赞扬。', pinyin: 'Tā dédào le lǎoshī hé tóngxué de zànyáng.', meaning_vi: 'Cậu ấy nhận được lời khen ngợi của thầy cô và bạn học.', difficulty_level: 'basic' },
      { chinese: '通过大家的共同努力，这个问题得到了很好的解决。', pinyin: 'Tōngguò dàjiā de gòngtóng nǔlì, zhè ge wèntí dédào le hěn hǎo de jiějué.', meaning_vi: 'Nhờ nỗ lực chung của mọi người, vấn đề này đã nhận được cách giải quyết rất tốt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '得分',
    pinyin: 'défēn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'ghi điểm, điểm số',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我们队在最后两分钟得了三分。', pinyin: 'Wǒmen duì zài zuìhòu liǎng fēnzhōng dé le sān fēn.', meaning_vi: 'Đội chúng tôi đã ghi được ba điểm trong hai phút cuối cùng.', difficulty_level: 'basic' },
      { chinese: '他的考试总得分在全班排名第一。', pinyin: 'Tā de kǎoshì zǒng défēn zài quán bān páimíng dì-yī.', meaning_vi: 'Tổng điểm thi của cậu ấy xếp thứ nhất toàn lớp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '的话',
    pinyin: 'dehuà',
    word_type: 'Trợ từ',
    meaning_vi: 'nếu... (đặt cuối vế câu điều kiện)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '有时间的话，我们一起去喝咖啡吧。', pinyin: 'Yǒu shíjiān dehuà, wǒmen yìqǐ qù hē kāfēi ba.', meaning_vi: 'Nếu có thời gian thì chúng mình cùng đi uống cà phê nhé.', difficulty_level: 'basic' },
      { chinese: '如果你遇到不懂的词语的话，随时可以问我。', pinyin: 'Rúguǒ nǐ yù dào bù dǒng de cíyǔ dehuà, suíshí kěyǐ wèn wǒ.', meaning_vi: 'Nếu như bạn gặp từ ngữ không hiểu, bất cứ lúc nào cũng có thể hỏi tôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '得',
    pinyin: 'děi',
    word_type: 'Động từ năng nguyện',
    meaning_vi: 'phải, cần phải',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '时间不早了，我得走了。', pinyin: 'Shíjiān bù zǎo le, wǒ děi zǒu le.', meaning_vi: 'Thời gian không còn sớm nữa, tôi phải đi rồi.', difficulty_level: 'basic' },
      { chinese: '明天有重要的考试，今晚得早点儿休息。', pinyin: 'Míngtiān yǒu zhòngyào de kǎoshì, jīnwǎn děi zǎo diǎnr xiūxi.', meaning_vi: 'Ngày mai có kỳ thi quan trọng, tối nay phải nghỉ ngơi sớm một chút.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '地点',
    pinyin: 'dìdiǎn',
    word_type: 'Danh từ',
    meaning_vi: 'địa điểm',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '请告诉我开会的地点在哪儿。', pinyin: 'Qǐng gàosù wǒ kāihuì de dìdiǎn zài nǎr.', meaning_vi: 'Xin hãy cho tôi biết địa điểm họp ở đâu.', difficulty_level: 'basic' },
      { chinese: '我们在通知上写明了集合的时间和地点。', pinyin: 'Wǒmen zài tōngzhī shang xiě míng le jíhé de shíjiān hé dìdiǎn.', meaning_vi: 'Chúng tôi đã ghi rõ thời gian và địa điểm tập trung trên thông báo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '电',
    pinyin: 'diàn',
    word_type: 'Danh từ',
    meaning_vi: 'điện, pin (điện)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '手机快没电了，帮我拿一下充电器。', pinyin: 'Shǒujī kuài méi diàn le, bāng wǒ ná yíxià chōngdiànqì.', meaning_vi: 'Điện thoại sắp hết pin rồi, lấy hộ tôi củ sạc với.', difficulty_level: 'basic' },
      { chinese: '突然停电了，大家请不要慌张。', pinyin: 'Tūrán tíng diàn le, dàjiā qǐng bú yào huāngzhāng.', meaning_vi: 'Đột ngột mất điện rồi, mọi người xin đừng hoảng loạn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '电子书',
    pinyin: 'diànzǐshū',
    word_type: 'Danh từ',
    meaning_vi: 'sách điện tử',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我喜欢在平板电脑上看电子书。', pinyin: 'Wǒ xǐhuan zài píngbǎn diànnǎo shang kàn diànzǐshū.', meaning_vi: 'Tôi thích đọc sách điện tử trên máy tính bảng.', difficulty_level: 'basic' },
      { chinese: '电子书携带方便，随时随地都能阅读。', pinyin: 'Diànzǐshū xiédài fāngbiàn, suíshí suídì dōu néng yuèdú.', meaning_vi: 'Sách điện tử mang theo rất tiện, mọi lúc mọi nơi đều có thể đọc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '丢',
    pinyin: 'diū',
    word_type: 'Động từ',
    meaning_vi: 'mất, làm mất, vứt bỏ',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我不小心把钱包丢了。', pinyin: 'Wǒ bù xiǎoxīn bǎ qiánbāo diū le.', meaning_vi: 'Tôi sơ ý làm mất ví tiền rồi.', difficulty_level: 'basic' },
      { chinese: '请把垃圾丢进外面的垃圾桶里。', pinyin: 'Qǐng bǎ lājī diū jìn wàimiàn de lājītǒng lǐ.', meaning_vi: 'Xin hãy vứt rác vào thùng rác bên ngoài.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '东北',
    pinyin: 'dōngběi',
    word_type: 'Danh từ',
    meaning_vi: 'đông bắc, miền đông bắc',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '中国东北冬天的景色非常美。', pinyin: 'Zhōngguó dōngběi dōngtiān de jǐngsè fēicháng měi.', meaning_vi: 'Phong cảnh mùa đông miền đông bắc Trung Quốc rất đẹp.', difficulty_level: 'basic' },
      { chinese: '我家在城市的东北角，离公园很近。', pinyin: 'Wǒ jiā zài chéngshì de dōngběi jiǎo, lí gōngyuán hěn jìn.', meaning_vi: 'Nhà tôi ở góc đông bắc của thành phố, rất gần công viên.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '东方',
    pinyin: 'dōngfāng',
    word_type: 'Danh từ',
    meaning_vi: 'hướng đông, phương đông',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '太阳从东方升起来了。', pinyin: 'Tàiyáng cóng dōngfāng shēng qǐlái le.', meaning_vi: 'Mặt trời mọc lên từ hướng đông.', difficulty_level: 'basic' },
      { chinese: '许多外国朋友对东方传统文化很感兴趣。', pinyin: 'Xǔduō wàiguó péngyou duì dōngfāng chuántǒng wénhuà hěn gǎn xìngqù.', meaning_vi: 'Nhiều người bạn nước ngoài rất quan tâm đến văn hóa truyền thống phương Đông.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '东南',
    pinyin: 'dōngnán',
    word_type: 'Danh từ',
    meaning_vi: 'đông nam, hướng đông nam',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '学校的东南方向有一家大超市。', pinyin: 'Xuéxiào de dōngnán fāngxiàng yǒu yì jiā dà chāoshì.', meaning_vi: 'Hướng đông nam của trường có một siêu thị lớn.', difficulty_level: 'basic' },
      { chinese: '中国东南部沿海地区气候湿润温暖。', pinyin: 'Zhōngguó dōngnán bù yánhǎi dìqū qìhòu shīrùn wēnnuǎn.', meaning_vi: 'Vùng ven biển đông nam Trung Quốc khí hậu ẩm ướt ấm áp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '冬天',
    pinyin: 'dōngtiān',
    word_type: 'Danh từ',
    meaning_vi: 'mùa đông',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '冬天北京经常下大雪。', pinyin: 'Dōngtiān Běijīng jīngcháng xià dà xuě.', meaning_vi: 'Mùa đông Bắc Kinh thường có tuyết rơi dày.', difficulty_level: 'basic' },
      { chinese: '冬天虽然寒冷，但是一家人吃火锅很温馨。', pinyin: 'Dōngtiān suīrán hánlěng, dànshì yì jiā rén chī huǒguō hěn wēnxīn.', meaning_vi: 'Mùa đông tuy lạnh giá, nhưng cả nhà cùng ăn lẩu rất ấm áp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '懂得',
    pinyin: 'dǒngde',
    word_type: 'Động từ',
    meaning_vi: 'hiểu biết, thấu hiểu',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我们要懂得尊重别人。', pinyin: 'Wǒmen yào dǒngde zūnzhòng biérén.', meaning_vi: 'Chúng ta phải biết tôn trọng người khác.', difficulty_level: 'basic' },
      { chinese: '经历过挫折之后，他更懂得珍惜眼前的幸福。', pinyin: 'Jīnglì guò cuòzhé zhīhòu, tā gèng dǒngde zhēnxī yǎnqián de xìngfú.', meaning_vi: 'Sau khi trải qua trắc trở, anh ấy càng thấu hiểu việc trân trọng hạnh phúc trước mắt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '动物园',
    pinyin: 'dòngwùyuán',
    word_type: 'Danh từ',
    meaning_vi: 'sở thú, vườn bách thú',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '周末爸爸带我们去动物园看猴子。', pinyin: 'Zhōumò bàba dài wǒmen qù dòngwùyuán kàn hóuzi.', meaning_vi: 'Cuối tuần bố dẫn chúng tôi đi sở thú xem khỉ.', difficulty_level: 'basic' },
      { chinese: '北京动物园里有许多珍稀动物，特别是大熊猫。', pinyin: 'Běijīng dòngwùyuán lǐ yǒu xǔduō zhēnxī dòngwù, tèbié shì dàxióngmāo.', meaning_vi: 'Trong sở thú Bắc Kinh có rất nhiều động vật quý hiếm, đặc biệt là gấu trúc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '短裤',
    pinyin: 'duǎnkù',
    word_type: 'Danh từ',
    meaning_vi: 'quần cộc, quần đùi',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '夏天穿短裤很凉快。', pinyin: 'Xiàtiān chuān duǎnkù hěn liángkuai.', meaning_vi: 'Mùa hè mặc quần soóc rất mát mẻ.', difficulty_level: 'basic' },
      { chinese: '他换上运动短裤，准备去球场踢足球。', pinyin: 'Tā huàn shang yùndòng duǎnkù, zhǔnbèi qù qiúchǎng tī zúqiú.', meaning_vi: 'Anh ấy thay quần cộc thể thao, chuẩn bị ra sân đá bóng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '对话',
    pinyin: 'duìhuà',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'đối thoại, trò chuyện',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '请两个人一组练习这段对话。', pinyin: 'Qǐng liǎng gè rén yì zǔ liànxí zhè duàn duìhuà.', meaning_vi: 'Xin mời hai người một nhóm luyện tập đoạn đối thoại này.', difficulty_level: 'basic' },
      { chinese: '多跟中国朋友用汉语对话，口语进步会很快。', pinyin: 'Duō gēn Zhōngguó péngyou yòng Hànyǔ duìhuà, kǒuyǔ jìnbù huì hěn kuài.', meaning_vi: 'Tích cực dùng tiếng Trung đối thoại cùng bạn bè người Trung Quốc, khẩu ngữ sẽ tiến bộ rất nhanh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '而且',
    pinyin: 'érqiě',
    word_type: 'Liên từ',
    meaning_vi: 'hơn nữa, mà còn',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '这件衣服既好看，而且价格也不贵。', pinyin: 'Zhè jiàn yīfu jì hǎokàn, érqiě jiàgé yě bú guì.', meaning_vi: 'Bộ quần áo này vừa đẹp mắt, hơn nữa giá cả cũng không đắt.', difficulty_level: 'basic' },
      { chinese: '他每天都坚持锻炼，而且饮食也非常健康。', pinyin: 'Tā měitiān dōu jiānchí duànliàn, érqiě yǐnshí yě fēicháng jiànkāng.', meaning_vi: 'Anh ấy ngày nào cũng kiên trì rèn luyện, hơn nữa ăn uống cũng vô cùng lành mạnh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '耳机',
    pinyin: 'ěrjī',
    word_type: 'Danh từ',
    meaning_vi: 'tai nghe',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我戴着耳机听听力练习。', pinyin: 'Wǒ dài zhe ěrjī tīng tīnglì liànxí.', meaning_vi: 'Tôi đeo tai nghe để làm bài luyện nghe.', difficulty_level: 'basic' },
      { chinese: '在图书馆里听音乐时，请一定要戴上耳机。', pinyin: 'Zài túshūguǎn lǐ tīng yīnyuè shí, qǐng yídìng yào dài shang ěrjī.', meaning_vi: 'Khi nghe nhạc trong thư viện, xin nhất định phải đeo tai nghe.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '发生',
    pinyin: 'fāshēng',
    word_type: 'Động từ',
    meaning_vi: 'xảy ra, phát sinh',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '这里刚才发生了一起交通事故。', pinyin: 'Zhèlǐ gāngcái fāshēng le yì qǐ jiāotōng shìgù.', meaning_vi: 'Ở đây vừa nãy đã xảy ra một vụ tai nạn giao thông.', difficulty_level: 'basic' },
      { chinese: '别着急，慢慢告诉我到底发生了什么事情。', pinyin: 'Bié zháojí, mànmàn gàosù wǒ dàodǐ fāshēng le shénme shìqing.', meaning_vi: 'Đừng sốt ruột, từ từ nói cho tôi biết rốt cuộc đã xảy ra chuyện gì.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '发展',
    pinyin: 'fāzhǎn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phát triển',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '近几年这个城市发展得很快。', pinyin: 'Jìn jǐ nián zhè ge chéngshì fāzhǎn de hěn kuài.', meaning_vi: 'Mấy năm gần đây thành phố này phát triển rất nhanh.', difficulty_level: 'basic' },
      { chinese: '科技的发展极大地改善了人们的日常生活。', pinyin: 'Kējì de fāzhǎn jídà de gǎishàn le rénmen de rìcháng shēnghuó.', meaning_vi: 'Sự phát triển của khoa học công nghệ đã cải thiện vượt bậc đời sống hàng ngày của người dân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '方便面',
    pinyin: 'fāngbiànmiàn',
    word_type: 'Danh từ',
    meaning_vi: 'mì ăn liền, mì tôm',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '他晚上常常煮一包方便面当宵夜。', pinyin: 'Tā wǎnshang chángcháng zhǔ yì bāo fāngbiànmiàn dāng xiāoyè.', meaning_vi: 'Buổi tối anh ấy thường nấu một gói mì tôm làm bữa khuya.', difficulty_level: 'basic' },
      { chinese: '坐长途火车的时候，许多旅客都会带几包方便面。', pinyin: 'Zuò chángtú huǒchē de shíhou, xǔduō lǚkè dōu huì dài jǐ bāo fāngbiànmiàn.', meaning_vi: 'Khi đi tàu hỏa đường dài, nhiều hành khách đều mang theo vài gói mì ăn liền.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '方法',
    pinyin: 'fāngfǎ',
    word_type: 'Danh từ',
    meaning_vi: 'phương pháp, cách thức',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '只要找对了方法，学习就会更轻松。', pinyin: 'Zhǐyào zhǎoduì le fāngfǎ, xuéxí jiù huì gèng qīngsōng.', meaning_vi: 'Chỉ cần tìm đúng phương pháp, việc học sẽ nhẹ nhàng hơn nhiều.', difficulty_level: 'basic' },
      { chinese: '老师向我们介绍了好几种记忆生词的有效方法。', pinyin: 'Lǎoshī xiàng wǒmen jièshào le hǎo jǐ zhǒng jìyì shēngcí de yǒuxiào fāngfǎ.', meaning_vi: 'Thầy giáo đã giới thiệu cho chúng tôi vài phương pháp hiệu quả để ghi nhớ từ mới.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '方向',
    pinyin: 'fāngxiàng',
    word_type: 'Danh từ',
    meaning_vi: 'phương hướng, chiều hướng',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '车正在朝车站的方向开去。', pinyin: 'Chē zhèngzài cháo chēzhàn de fāngxiàng kāi qù.', meaning_vi: 'Chiếc xe đang chạy về hướng bến xe.', difficulty_level: 'basic' },
      { chinese: '在森林里迷路时，可以用指南针辨别方向。', pinyin: 'Zài sēnlín lǐ mílù shí, kěyǐ yòng zhǐnánzhēn biànbié fāngxiàng.', meaning_vi: 'Khi bị lạc trong rừng, có thể dùng la bàn để nhận biết phương hướng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '房子',
    pinyin: 'fángzi',
    word_type: 'Danh từ',
    meaning_vi: 'ngôi nhà, căn nhà',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '他们在学校旁边租了一套房子。', pinyin: 'Tāmen zài xuéxiào pángbiān zū le yí tào fángzi.', meaning_vi: 'Họ đã thuê một căn nhà ở cạnh trường học.', difficulty_level: 'basic' },
      { chinese: '这套房子的采光非常好，窗外就是大花园。', pinyin: 'Zhè tào fángzi de cǎiguāng fēicháng hǎo, chuāng wài jiù shì dà huāyuán.', meaning_vi: 'Căn nhà này đón ánh sáng rất tốt, ngoài cửa sổ chính là một khu vườn lớn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '放假',
    pinyin: 'fàngjià',
    word_type: 'Động từ',
    meaning_vi: 'nghỉ lễ, nghỉ phép',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '下周放假三天，你想去哪儿玩？', pinyin: 'Xià zhōu fàngjià sān tiān, nǐ xiǎng qù nǎr wán?', meaning_vi: 'Tuần sau được nghỉ lễ ba ngày, bạn muốn đi đâu chơi?', difficulty_level: 'basic' },
      { chinese: '学校一放假，许多留学生就回国探亲了。', pinyin: 'Xuéxiào yí fàngjià, xǔduō liúxuéshēng jiù huí guó tànqīn le.', meaning_vi: 'Trường học vừa được nghỉ là nhiều du học sinh liền về nước thăm người thân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '放学',
    pinyin: 'fàngxué',
    word_type: 'Động từ',
    meaning_vi: 'tan học',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '下午四点半放学后我们去打球吧。', pinyin: 'Xiàwǔ sì diǎn bàn fàngxué hòu wǒmen qù dǎ qiú ba.', meaning_vi: 'Bốn giờ rưỡi chiều tan học xong chúng mình đi chơi bóng nhé.', difficulty_level: 'basic' },
      { chinese: '校门口每天放学的时候都有很多家长在接孩子。', pinyin: 'Xiàoménkǒu měitiān fàngxué de shíhou dōu yǒu hěn duō jiāzhǎng zài jiē háizi.', meaning_vi: 'Trước cổng trường mỗi lúc tan học đều có rất đông phụ huynh đang đón con.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '分开',
    pinyin: 'fēnkāi',
    word_type: 'Động từ',
    meaning_vi: 'chia tách, tách rời, phân ra',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '请把生词和语法笔记分开写。', pinyin: 'Qǐng bǎ shēngcí hé yǔfǎ bǐjì fēnkāi xiě.', meaning_vi: 'Xin hãy viết phần ghi chú từ mới và ngữ pháp tách riêng ra.', difficulty_level: 'basic' },
      { chinese: '大学毕业后，大家就分开去了不同的城市工作。', pinyin: 'Dàxué bìyè hòu, dàjiā jiù fēnkāi qù le bù tóng de chéngshì gōngzuò.', meaning_vi: 'Sau khi tốt nghiệp đại học, mọi người liền tách nhau đi đến các thành phố khác nhau để làm việc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '风',
    pinyin: 'fēng',
    word_type: 'Danh từ',
    meaning_vi: 'gió',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '今天的风很大，出门戴上帽子吧。', pinyin: 'Jīntiān de fēng hěn dà, chūmén dài shang màozi ba.', meaning_vi: 'Hôm nay gió to lắm, ra ngoài đội mũ vào nhé.', difficulty_level: 'basic' },
      { chinese: '春风吹拂着河岸边的杨柳，显得分外美丽。', pinyin: 'Chūnfēng chuīfú zhe hé’àn biān de yángliǔ, xiǎnde fènwài měilì.', meaning_vi: 'Gió xuân thổi nhẹ qua rặng liễu bên bờ sông, trông vô cùng xinh đẹp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '封',
    pinyin: 'fēng',
    word_type: 'Lượng từ / Động từ',
    meaning_vi: 'bức, lá (thư); niêm phong',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我收到了一封远方朋友寄来的信。', pinyin: 'Wǒ shōudào le yì fēng yuǎnfāng péngyou jì lái de xìn.', meaning_vi: 'Tôi đã nhận được một lá thư của người bạn phương xa gửi tới.', difficulty_level: 'basic' },
      { chinese: '他在电子邮件里给导师写了一封长信汇报研究进展。', pinyin: 'Tā zài diànzǐ yóujiàn lǐ gěi dǎoshī xiě le yì fēng cháng xìn huìbào yánjiū jìnzhǎn.', meaning_vi: 'Anh ấy viết một bức thư dài trong email gửi giáo viên hướng dẫn để báo cáo tiến độ nghiên cứu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '夫妻',
    pinyin: 'fūqī',
    word_type: 'Danh từ',
    meaning_vi: 'vợ chồng',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '他们夫妻俩的感情一直特别好。', pinyin: 'Tāmen fūqī liǎ de gǎnqíng yìzhí tèbié hǎo.', meaning_vi: 'Tình cảm của hai vợ chồng họ lúc nào cũng đặc biệt tốt.', difficulty_level: 'basic' },
      { chinese: '夫妻之间需要相互理解与包容才能长久。', pinyin: 'Fūqī zhījiān xūyào xiānghù lǐjiě yǔ bāoróng cái néng chángjiǔ.', meaning_vi: 'Giữa vợ chồng cần thấu hiểu và bao dung lẫn nhau thì mới bền lâu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '服务',
    pinyin: 'fúwù',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phục vụ, dịch vụ',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '这家宾馆的服务很周到。', pinyin: 'Zhè jiā bīnguǎn de fúwù hěn zhōudào.', meaning_vi: 'Dịch vụ của khách sạn này rất chu đáo.', difficulty_level: 'basic' },
      { chinese: '我们始终秉承为顾客全心全意服务的理念。', pinyin: 'Wǒmen shǐzhōng bǐngchéng wèi gùkè quánxīnquányì fúwù de lǐniàn.', meaning_vi: 'Chúng tôi luôn giữ vững triết lý phục vụ khách hàng hết lòng hết dạ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '该',
    pinyin: 'gāi',
    word_type: 'Động từ năng nguyện',
    meaning_vi: 'nên, phải, đến lượt',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '时间差不多了，我们该出发了。', pinyin: 'Shíjiān chàbuduō le, wǒmen gāi chūfā le.', meaning_vi: 'Thời gian hòm hòm rồi, chúng ta nên xuất phát thôi.', difficulty_level: 'basic' },
      { chinese: '该你回答老师提出的问题了。', pinyin: 'Gāi nǐ huídá lǎoshī tíchū de wèntí le.', meaning_vi: 'Đến lượt bạn trả lời câu hỏi do thầy giáo đưa ra rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '感到',
    pinyin: 'gǎndào',
    word_type: 'Động từ',
    meaning_vi: 'cảm thấy, nhận thấy',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '听到这个好消息，大家都感到很高兴。', pinyin: 'Tīng dào zhè ge hǎo xiāoxi, dàjiā dōu gǎndào hěn gāoxìng.', meaning_vi: 'Nghe được tin tốt lành này, ai cũng cảm thấy rất vui.', difficulty_level: 'basic' },
      { chinese: '经过一整天紧张的工作，他感到有些疲劳。', pinyin: 'Jīngguò yì zhěng tiān jǐnzhāng de gōngzuò, tā gǎndào yǒuxiē píláo.', meaning_vi: 'Trải qua cả ngày làm việc căng thẳng, anh ấy cảm thấy hơi mệt mỏi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '干',
    pinyin: 'gàn',
    word_type: 'Động từ',
    meaning_vi: 'làm, làm việc',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '你周末打算干什么？', pinyin: 'Nǐ zhōumò dǎsuàn gàn shénme?', meaning_vi: 'Cuối tuần bạn dự định làm gì?', difficulty_level: 'basic' },
      { chinese: '他干起活来手脚非常麻利。', pinyin: 'Tā gàn qǐ huó lái shǒujiǎo fēicháng máli.', meaning_vi: 'Anh ấy khi bắt tay vào làm việc thì tay chân rất nhanh nhẹn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '刚',
    pinyin: 'gāng',
    word_type: 'Phó từ',
    meaning_vi: 'vừa, vừa mới',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '我刚吃完早饭，现在去上班。', pinyin: 'Wǒ gāng chī wán zǎofàn, xiànzài qù shàngbān.', meaning_vi: 'Tôi vừa ăn sáng xong, bây giờ đi làm đây.', difficulty_level: 'basic' },
      { chinese: '他刚来到这所学校，对周围环境还不熟悉。', pinyin: 'Tā gāng lái dào zhè suǒ xuéxiào, duì zhōuwéi huánjìng hái bù shúxī.', meaning_vi: 'Cậu ấy vừa mới đến ngôi trường này, đối với môi trường xung quanh còn chưa quen thuộc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '刚刚',
    pinyin: 'gānggāng',
    word_type: 'Phó từ',
    meaning_vi: 'vừa mới, vừa vặn',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '汽车刚刚开走了，你得等下一班。', pinyin: 'Qìchē gānggāng kāi zǒu le, nǐ děi děng xià yì bān.', meaning_vi: 'Xe buýt vừa mới chạy đi rồi, bạn phải chờ chuyến sau.', difficulty_level: 'basic' },
      { chinese: '我刚刚把房间打扫干净，客人就敲门了。', pinyin: 'Wǒ gānggāng bǎ fángjiān dǎsǎo gānjìng, kèrén jiù qiāo mén le.', meaning_vi: 'Tôi vừa mới dọn dẹp phòng sạch sẽ thì khách đã gõ cửa rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '高铁',
    pinyin: 'gāotiě',
    word_type: 'Danh từ',
    meaning_vi: 'đường sắt cao tốc, tàu cao tốc',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '坐高铁从北京到上海只需要四个多小时。', pinyin: 'Zuò gāotiě cóng Běijīng dào Shànghǎi zhǐ xūyào sì gè duō xiǎoshí.', meaning_vi: 'Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải chỉ mất hơn bốn tiếng.', difficulty_level: 'basic' },
      { chinese: '高铁不仅速度快，而且非常平稳舒适。', pinyin: 'Gāotiě bùjǐn sùdù kuài, érqiě fēicháng píngwěn shūshì.', meaning_vi: 'Tàu cao tốc không chỉ tốc độ nhanh mà còn rất êm ái dễ chịu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '工作日',
    pinyin: 'gōngzuòrì',
    word_type: 'Danh từ',
    meaning_vi: 'ngày làm việc (từ thứ 2 đến thứ 6)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '银行只在工作日对外办理业务。', pinyin: 'Yínháng zhǐ zài gōngzuòrì duì wài bànlǐ yèwù.', meaning_vi: 'Ngân hàng chỉ xử lý nghiệp vụ cho khách vào các ngày làm việc.', difficulty_level: 'basic' },
      { chinese: '工作日早高峰的地铁通常非常拥挤。', pinyin: 'Gōngzuòrì zǎogāofēng de dìtiě tōngcháng fēicháng yōngjǐ.', meaning_vi: 'Tàu điện ngầm vào giờ cao điểm buổi sáng các ngày trong tuần thường rất đông đúc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '刮',
    pinyin: 'guā',
    word_type: 'Động từ',
    meaning_vi: 'thổi (gió), cạo (râu)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '外面刮起大风了，快关窗户。', pinyin: 'Wàimiàn guā qǐ dà fēng le, kuài guān chuānghu.', meaning_vi: 'Bên ngoài thổi gió to rồi, mau đóng cửa sổ lại.', difficulty_level: 'basic' },
      { chinese: '他每天早上洗脸后都会仔细刮胡子。', pinyin: 'Tā měitiān zǎoshang xǐliǎn hòu dōu huì zǐxì guā húzi.', meaning_vi: 'Mỗi sáng sau khi rửa mặt anh ấy đều cẩn thận cạo râu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '关机',
    pinyin: 'guānjī',
    word_type: 'Động từ',
    meaning_vi: 'tắt máy (điện thoại/máy tính)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '考试时手机必须关机。', pinyin: 'Kǎoshì shí shǒujī bìxū guānjī.', meaning_vi: 'Khi thi điện thoại bắt buộc phải tắt máy.', difficulty_level: 'basic' },
      { chinese: '上飞机后，乘务员提醒乘客关闭手机或开启飞行模式。', pinyin: 'Shàng fēijī hòu, chéngwùyuán tíxǐng chéngkè guānbì shǒujī huò kāiqǐ fēixíng móshì.', meaning_vi: 'Sau khi lên máy bay, tiếp viên nhắc nhở hành khách tắt máy hoặc bật chế độ máy bay.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '关注',
    pinyin: 'guānzhù',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'quan tâm, theo dõi (trang mạng/chủ đề)',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '请大家多关注我们频道的最新动态。', pinyin: 'Qǐng dàjiā duō guānzhù wǒmen píndào de zuìxīn dòngtài.', meaning_vi: 'Xin mọi người hãy quan tâm theo dõi nhiều hơn các cập nhật mới nhất của kênh chúng tôi.', difficulty_level: 'basic' },
      { chinese: '环境保护问题受到了全社会的高度关注。', pinyin: 'Huánjìng bǎohù wèntí shòudào le quán shèhuì de gāodù guānzhù.', meaning_vi: 'Vấn đề bảo vệ môi trường đã nhận được sự quan tâm sâu sắc của toàn xã hội.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '过节',
    pinyin: 'guòjié',
    word_type: 'Động từ',
    meaning_vi: 'đón tết, ăn tết, mừng lễ',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '春节的时候，大家都回家过节。', pinyin: 'Chūnjié de shíhou, dàjiā dōu huí jiā guòjié.', meaning_vi: 'Vào dịp Tết Nguyên Đán, mọi người đều về nhà ăn tết.', difficulty_level: 'basic' },
      { chinese: '过节期间街上的商铺挂满了红红的灯笼。', pinyin: 'Guòjié qījiān jiē shang de shāngpù guà mǎn le hónghóng de dēnglong.', meaning_vi: 'Trong thời gian ngày lễ, các cửa tiệm trên phố treo đầy những chiếc đèn lồng đỏ rực.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '海',
    pinyin: 'hǎi',
    word_type: 'Danh từ',
    meaning_vi: 'biển, đại dương',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '夏天我们去海边游泳吧。', pinyin: 'Xiàtiān wǒmen qù hǎibiān yóuyǒng ba.', meaning_vi: 'Mùa hè chúng mình đi biển bơi lội nhé.', difficulty_level: 'basic' },
      { chinese: '站在山顶向远处望去，是一片蔚蓝的大海。', pinyin: 'Zhàn zài shāndǐng xiàng yuǎnchù wàng qù, shì yí piàn wèilán de dàhǎi.', meaning_vi: 'Đứng trên đỉnh núi nhìn ra xa là một vùng biển cả xanh biếc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '好多',
    pinyin: 'hǎoduō',
    word_type: 'Số từ / Đại từ',
    meaning_vi: 'rất nhiều',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '书店里有好多新书。', pinyin: 'Shūdiàn lǐ yǒu hǎoduō xīn shū.', meaning_vi: 'Trong tiệm sách có rất nhiều sách mới.', difficulty_level: 'basic' },
      { chinese: '今天超市搞促销活动，来了好多买东西的顾客。', pinyin: 'Jīntiān chāoshì gǎo cùxiāo huódòng, lái le hǎoduō mǎi dōngxi de gùkè.', meaning_vi: 'Hôm nay siêu thị có chương trình khuyến mãi, đã có rất nhiều khách hàng tới mua sắm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '好久',
    pinyin: 'hǎojiǔ',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'rất lâu, hồi lâu',
    hsk_level: 'HSK 3',
    examples: [
      { chinese: '好久不见，你最近好吗？', pinyin: 'Hǎojiǔ bú jiàn, nǐ zuìjìn hǎo ma?', meaning_vi: 'Lâu lắm không gặp, dạo này bạn khỏe không?', difficulty_level: 'basic' },
      { chinese: '他在火车站等了好久，终于等到了朋友的列车。', pinyin: 'Tā zài huǒchēzhàn děng le hǎojiǔ, zhōngyú děngdào le péngyou de lièchē.', meaning_vi: 'Anh ấy đợi ở ga tàu hồi lâu, cuối cùng cũng đón được chuyến tàu của người bạn.', difficulty_level: 'applied' }
    ]
  }
]
