// ====================================================================
// BATCH 1: 80 TỪ VỰNG HSK 3 CẦN HOÀN THIỆN CÂU VÍ DỤ (#1 -> #80)
// Từ [一共] (yígòng) đến [季节] (jìjié)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng) kèm Pinyin + Dịch TV
// ====================================================================

export interface Hsk3ExampleItem {
  hanzi: string
  pinyin: string
  word_type: string
  meaning_vi: string
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

export const HSK3_BATCH1_EXAMPLES: Hsk3ExampleItem[] = [
  {
    hanzi: '一共',
    pinyin: 'yígòng',
    word_type: 'Phó từ',
    meaning_vi: 'tổng cộng',
    examples: [
      { chinese: '这些苹果一共二十块钱。', pinyin: 'Zhèxiē píngguǒ yígòng èrshí kuài qián.', meaning_vi: 'Số táo này tổng cộng hai mươi tệ.', difficulty_level: 'basic' },
      { chinese: '我们班一共有三十五个来自不同国家的学生。', pinyin: 'Wǒmen bān yígòng yǒu sānshíwǔ gè láizì bù tóng guójiā de xuésheng.', meaning_vi: 'Lớp chúng tôi tổng cộng có ba mươi lăm học sinh đến từ các quốc gia khác nhau.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一定',
    pinyin: 'yídìng',
    word_type: 'Phó từ / Tính từ',
    meaning_vi: 'nhất định',
    examples: [
      { chinese: '明天你一定要按时来参加聚会。', pinyin: 'Míngtiān nǐ yídìng yào ànshí lái cānjiā jùhuì.', meaning_vi: 'Ngày mai bạn nhất định phải đến tham gia buổi tụ tập đúng giờ nhé.', difficulty_level: 'basic' },
      { chinese: '只要坚持努力，你就一定能实现自己的理想。', pinyin: 'Zhǐyào jiānchí nǔlì, nǐ jiù yídìng néng shíxiàn zìjǐ de lǐxiǎng.', meaning_vi: 'Chỉ cần kiên trì nỗ lực, bạn nhất định có thể thực hiện được lý tưởng của mình.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一样',
    pinyin: 'yíyàng',
    word_type: 'Tính từ',
    meaning_vi: 'giống nhau, như nhau',
    examples: [
      { chinese: '这两个书包的颜色完全一样。', pinyin: 'Zhè liǎng gè shūbāo de yánsè wánquán yíyàng.', meaning_vi: 'Màu sắc của hai chiếc cặp sách này hoàn toàn giống nhau.', difficulty_level: 'basic' },
      { chinese: '他和哥哥一样，也非常喜欢踢足球。', pinyin: 'Tā hé gēge yíyàng, yě fēicháng xǐhuan tī zúqiú.', meaning_vi: 'Cậu ấy cũng giống như anh trai, rất thích đá bóng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一直',
    pinyin: 'yìzhí',
    word_type: 'Phó từ',
    meaning_vi: 'luôn luôn, suốt, thẳng',
    examples: [
      { chinese: '沿着这条路一直往走就是地铁站。', pinyin: 'Yánzhe zhè tiáo lù yìzhí wǎng qián zǒu jiù shì dìtiězhàn.', meaning_vi: 'Cứ đi thẳng theo con đường này về phía trước là tới ga tàu điện ngầm.', difficulty_level: 'basic' },
      { chinese: '这几天天气一直很晴朗，气温也很舒服。', pinyin: 'Zhè jǐ tiān tiānqì yìzhí hěn qínglǎng, qìwēn yě hěn shūfu.', meaning_vi: 'Mấy ngày nay thời tiết luôn nắng ráo, nhiệt độ cũng rất dễ chịu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一般',
    pinyin: 'yìbān',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'bình thường, thông thường, phổ biến',
    examples: [
      { chinese: '我周末一般都在家里看书休息。', pinyin: 'Wǒ zhōumò yìbān dōu zài jiālǐ kàn shū xiūxi.', meaning_vi: 'Cuối tuần tôi thông thường đều ở nhà đọc sách nghỉ ngơi.', difficulty_level: 'basic' },
      { chinese: '这家餐馆的菜味道很一般，但是服务很热情。', pinyin: 'Zhè jiā cānguǎn de cài wèidao hěn yìbān, dànshì fúwù hěn rèqíng.', meaning_vi: 'Món ăn của nhà hàng này hương vị rất bình thường, nhưng phục vụ rất nhiệt tình.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一边',
    pinyin: 'yìbiān',
    word_type: 'Phó từ',
    meaning_vi: 'vừa... vừa... (vừa làm việc này vừa làm việc kia)',
    examples: [
      { chinese: '他喜欢一边喝茶一边看报纸。', pinyin: 'Tā xǐhuan yìbiān hē chá yìbiān kàn bàozhǐ.', meaning_vi: 'Anh ấy thích vừa uống trà vừa đọc báo.', difficulty_level: 'basic' },
      { chinese: '大家一边吃着美味的晚餐，一边愉快地聊天儿。', pinyin: 'Dàjiā yìbiān chī zhe měiwèi de wǎncān, yìbiān yúkuài de liáotiānr.', meaning_vi: 'Mọi người vừa ăn bữa tối ngon miệng vừa trò chuyện vui vẻ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '世界',
    pinyin: 'shìjiè',
    word_type: 'Danh từ',
    meaning_vi: 'thế giới',
    examples: [
      { chinese: '我想去世界各地旅行看风景。', pinyin: 'Wǒ xiǎng qù shìjiè gèdì lǚxíng kàn fēngjǐng.', meaning_vi: 'Tôi muốn đi du lịch ngắm cảnh khắp nơi trên thế giới.', difficulty_level: 'basic' },
      { chinese: '互联网让我们能够随时了解世界每天发生的重大新闻。', pinyin: 'Hùliánwǎng ràng wǒmen nénggòu suíshí liǎojiě shìjiè měitiān fāshēng de zhòngdà xīnwén.', meaning_vi: 'Internet giúp chúng ta có thể cập nhật những tin tức lớn xảy ra mỗi ngày trên thế giới mọi lúc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '东',
    pinyin: 'dōng',
    word_type: 'Danh từ',
    meaning_vi: 'phía đông, hướng đông',
    examples: [
      { chinese: '太阳从东方升起来。', pinyin: 'Tàiyáng cóng dōngfāng shēng qǐlái.', meaning_vi: 'Mặt trời mọc lên từ hướng đông.', difficulty_level: 'basic' },
      { chinese: '我家住在学校的东边，步行大概十分钟。', pinyin: 'Wǒ jiā zhù zài xuéxiào de dōngbian, bùxíng dàgài shí fēnzhōng.', meaning_vi: 'Nhà tôi ở phía đông của trường, đi bộ chừng mười phút.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '中间',
    pinyin: 'zhōngjiān',
    word_type: 'Danh từ',
    meaning_vi: 'ở giữa, trung gian',
    examples: [
      { chinese: '他坐在爸爸和妈妈中间。', pinyin: 'Tā zuò zài bàba hé māma zhōngjiān.', meaning_vi: 'Cậu bé ngồi ở giữa bố và mẹ.', difficulty_level: 'basic' },
      { chinese: '桌子正中间放着一个装满鲜花的花瓶。', pinyin: 'Zhuōzi zhèng zhōngjiān fàng zhe yí gè zhuāng mǎn xiānhuā de huāpíng.', meaning_vi: 'Ngay chính giữa bàn đặt một bình hoa cắm đầy hoa tươi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '为',
    pinyin: 'wèi',
    word_type: 'Giới từ',
    meaning_vi: 'vì, cho, đối với',
    examples: [
      { chinese: '我们要为自己的未来努力学习。', pinyin: 'Wǒmen yào wèi zìjǐ de wèilái nǔlì xuéxí.', meaning_vi: 'Chúng ta phải chăm chỉ học tập vì tương lai của chính mình.', difficulty_level: 'basic' },
      { chinese: '大家举杯，为新朋友的到来干杯！', pinyin: 'Dàjiā jǔ bēi, wèi xīn péngyou de dàolái gānbēi!', meaning_vi: 'Mọi người nâng ly, cạn ly vì sự có mặt của những người bạn mới!', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '为了',
    pinyin: 'wèile',
    word_type: 'Giới từ',
    meaning_vi: 'để, nhằm mục đích',
    examples: [
      { chinese: '为了身体健康，他每天坚持跑步。', pinyin: 'Wèile shēntǐ jiànkāng, tā měitiān jiānchí pǎobù.', meaning_vi: 'Để có sức khỏe tốt, anh ấy kiên trì chạy bộ mỗi ngày.', difficulty_level: 'basic' },
      { chinese: '为了学好汉语，她报名参加了暑期强化培训班。', pinyin: 'Wèile xué hǎo Hànyǔ, tā bàomíng cānjiā le shǔqī qiánghuà péixùnbān.', meaning_vi: 'Để học tốt tiếng Trung, cô ấy đã đăng ký tham gia lớp bồi dưỡng cấp tốc mùa hè.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '主要',
    pinyin: 'zhǔyào',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'chủ yếu, chính',
    examples: [
      { chinese: '这是我们今天会议的主要内容。', pinyin: 'Zhè shì wǒmen jīntiān huìyì de zhǔyào nèiróng.', meaning_vi: 'Đây là nội dung chủ yếu của cuộc họp chúng ta hôm nay.', difficulty_level: 'basic' },
      { chinese: '他学习进步的主要原因是他平时肯下功夫。', pinyin: 'Tā xuéxí jìnbù de zhǔyào yuányīn shì tā píngshí kěn xià gōngfu.', meaning_vi: 'Nguyên nhân chính giúp việc học của anh ấy tiến bộ là nhờ bình thường chịu khó bỏ công sức.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '久',
    pinyin: 'jiǔ',
    word_type: 'Tính từ',
    meaning_vi: 'lâu, thời gian dài',
    examples: [
      { chinese: '我们在这里等了很久。', pinyin: 'Wǒmen zài zhèlǐ děng le hěn jiǔ.', meaning_vi: 'Chúng tôi đã đợi ở đây rất lâu rồi.', difficulty_level: 'basic' },
      { chinese: '过了这么久，他依然清晰地记得童年发生的事情。', pinyin: 'Guò le zhème jiǔ, tā yīrán qīngxī de jìde tóngnián fāshēng de shìqing.', meaning_vi: 'Trải qua thời gian lâu như vậy, anh ấy vẫn nhớ rất rõ những chuyện xảy ra thời thơ ấu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '习惯',
    pinyin: 'xíguàn',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'thói quen; quen với',
    examples: [
      { chinese: '早睡早起是一个很好的生活习惯。', pinyin: 'Zǎoshuì zǎoqǐ shì yí gè hěn hǎo de shēnghuó xíguàn.', meaning_vi: 'Ngủ sớm dậy sớm là một thói quen sinh hoạt rất tốt.', difficulty_level: 'basic' },
      { chinese: '来中国两个月后，他已经习惯了这里的饮食和气候。', pinyin: 'Lái Zhōngguó liǎng gè yuè hòu, tā yǐjīng xíguàn le zhèlǐ de yǐnshí hé qìhòu.', meaning_vi: 'Đến Trung Quốc hai tháng sau, anh ấy đã quen với ăn uống và khí hậu nơi đây.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '了解',
    pinyin: 'liǎojiě',
    word_type: 'Động từ',
    meaning_vi: 'hiểu rõ, tìm hiểu',
    examples: [
      { chinese: '我很了解他的脾气和性格。', pinyin: 'Wǒ hěn liǎojiě tā de píqi hé xìnggé.', meaning_vi: 'Tôi rất hiểu rõ tính khí và tính cách của anh ấy.', difficulty_level: 'basic' },
      { chinese: '去一个国家旅游之前，最好先了解一下当地的风俗习惯。', pinyin: 'Qù yí gè guójiā lǚyóu zhīqián, zuìhǎo xiān liǎojiě yíxià dāngdì de fēngsú xíguàn.', meaning_vi: 'Trước khi đến một quốc gia du lịch, tốt nhất nên tìm hiểu trước phong tục tập quán địa phương.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '以前',
    pinyin: 'yǐqián',
    word_type: 'Danh từ / Phó từ',
    meaning_vi: 'trước đây, trước khi',
    examples: [
      { chinese: '吃饭以前要把手洗干净。', pinyin: 'Chīfàn yǐqián yào bǎ shǒu xǐ gānjìng.', meaning_vi: 'Trước khi ăn cơm phải rửa tay sạch sẽ.', difficulty_level: 'basic' },
      { chinese: '他以前在一所中学当老师，现在换了新的工作。', pinyin: 'Tā yǐqián zài yì suǒ zhōngxué dāng lǎoshī, xiànzài huàn le xīn de gōngzuò.', meaning_vi: 'Trước đây anh ấy làm giáo viên ở một trường cấp hai, hiện tại đã đổi công việc mới.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '会议',
    pinyin: 'huìyì',
    word_type: 'Danh từ',
    meaning_vi: 'cuộc họp, hội nghị',
    examples: [
      { chinese: '下午的会议两点整准时开始。', pinyin: 'Xiàwǔ de huìyì liǎng diǎn zhěng zhǔnshí kāishǐ.', meaning_vi: 'Cuộc họp chiều nay đúng hai giờ sẽ chuẩn giờ bắt đầu.', difficulty_level: 'basic' },
      { chinese: '经理在会议上详细介绍了下一阶段的工作计划。', pinyin: 'Jīnglǐ zài huìyì shang xiángxì jièshào le xià yí jiēduàn de gōngzuò jìhuà.', meaning_vi: 'Giám đốc đã giới thiệu chi tiết kế hoạch công việc giai đoạn tiếp theo trong cuộc họp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '伞',
    pinyin: 'sǎn',
    word_type: 'Danh từ',
    meaning_vi: 'chiếc ô, cái dù',
    examples: [
      { chinese: '外面下大雨了，出门记得带把伞。', pinyin: 'Wàimiàn xià dà yǔ le, chūmén jìde dài bǎ sǎn.', meaning_vi: 'Bên ngoài trời mưa to rồi, ra ngoài nhớ mang theo cây dù.', difficulty_level: 'basic' },
      { chinese: '夏天的太阳很晒，许多女生出门喜欢打遮阳伞。', pinyin: 'Xiàtiān de tàiyáng hěn shài, xǔduō nǚshēng chūmén xǐhuan dǎ zhēyángsǎn.', meaning_vi: 'Ánh nắng mùa hè rất gắt, nhiều bạn nữ ra ngoài thích che ô chống nắng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '体育',
    pinyin: 'tǐyù',
    word_type: 'Danh từ',
    meaning_vi: 'thể dục, thể thao',
    examples: [
      { chinese: '星期五下午我们有一节体育课。', pinyin: 'Xīngqīwǔ xiàwǔ wǒmen yǒu yì jié tǐyùkè.', meaning_vi: 'Chiều thứ sáu chúng tôi có một tiết thể dục.', difficulty_level: 'basic' },
      { chinese: '经常参加体育锻炼可以强健体魄，减轻生活压力。', pinyin: 'Jīngcháng cānjiā tǐyù duànliàn kěyǐ qiángjiàn tǐpò, jiǎnqīng shēnghuó yālì.', meaning_vi: 'Thường xuyên tham gia rèn luyện thể thao có thể tăng cường thể lực và giảm bớt áp lực cuộc sống.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '作业',
    pinyin: 'zuòyè',
    word_type: 'Danh từ',
    meaning_vi: 'bài tập về nhà',
    examples: [
      { chinese: '今天的汉语作业你做完了吗？', pinyin: 'Jīntiān de Hànyǔ zuòyè nǐ zuò wán le ma?', meaning_vi: 'Bài tập tiếng Trung hôm nay bạn đã làm xong chưa?', difficulty_level: 'basic' },
      { chinese: '做完作业之后，还要认真检查一遍有没有错别字。', pinyin: 'Zuò wán zuòyè zhīhòu, hái yào rènzhēn jiǎnchá yí biàn yǒu méiyǒu cuòbiézì.', meaning_vi: 'Sau khi làm xong bài tập, còn phải cẩn thận kiểm tra lại một lượt xem có lỗi chính tả không.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '信用卡',
    pinyin: 'xìnyòngkǎ',
    word_type: 'Danh từ',
    meaning_vi: 'thẻ tín dụng',
    examples: [
      { chinese: '在这家超市买东西可以用信用卡付款。', pinyin: 'Zài zhè jiā chāoshì mǎi dōngxi kěyǐ yòng xìnyòngkǎ fùkuǎn.', meaning_vi: 'Mua đồ ở siêu thị này có thể dùng thẻ tín dụng thanh toán.', difficulty_level: 'basic' },
      { chinese: '使用信用卡消费时，一定要按时还款以保持良好的信用记录。', pinyin: 'Shǐyòng xìnyòngkǎ xiāofèi shí, yídìng yào ànshí huánkuǎn yǐ bǎochí liánghǎo de xìnyòng jìlù.', meaning_vi: 'Khi chi tiêu bằng thẻ tín dụng, nhất định phải trả nợ đúng hạn để duy trì lịch sử tín dụng tốt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '借',
    pinyin: 'jiè',
    word_type: 'Động từ',
    meaning_vi: 'mượn, vay, cho mượn',
    examples: [
      { chinese: '我可以借用一下你的铅笔吗？', pinyin: 'Wǒ kěyǐ jièyòng yíxià nǐ de qiānbǐ ma?', meaning_vi: 'Tôi có thể mượn dùng bút chì của bạn một chút được không?', difficulty_level: 'basic' },
      { chinese: '我昨天在学校图书馆借了两本关于中国文化的书。', pinyin: 'Wǒ zuótiān zài xuéxiào túshūguǎn jiè le liǎng běn guānyú Zhōngguó wénhuà de shū.', meaning_vi: 'Hôm qua tôi đã mượn hai cuốn sách về văn hóa Trung Quốc ở thư viện trường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '健康',
    pinyin: 'jiànkāng',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'khỏe mạnh, sức khỏe',
    examples: [
      { chinese: '多吃新鲜蔬菜水果对身体健康有好处。', pinyin: 'Duō chī xīnxiān shūcài shuǐguǒ duì shēntǐ jiànkāng yǒu hǎochu.', meaning_vi: 'Ăn nhiều rau quả tươi có lợi cho sức khỏe.', difficulty_level: 'basic' },
      { chinese: '拥有健康的身体和乐观的心态是人生最大的财富。', pinyin: 'Yōngyǒu jiànkāng de shēntǐ hé lèguān de xīntài shì rénshēng zuì dà de cáifù.', meaning_vi: 'Sở hữu một cơ thể khỏe mạnh và tâm thái lạc quan là tài sản lớn nhất của đời người.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '像',
    pinyin: 'xiàng',
    word_type: 'Động từ / Giới từ',
    meaning_vi: 'giống, giống như, dường như',
    examples: [
      { chinese: '这孩子长得真像他的爸爸。', pinyin: 'Zhè háizi zhǎng de zhēn xiàng tā de bàba.', meaning_vi: 'Đứa bé này trông thật giống bố của nó.', difficulty_level: 'basic' },
      { chinese: '天空中飘着厚厚的白云，像一座座雪白的山峰。', pinyin: 'Tiānkōng zhōng piāo zhe hòuhòu de báiyún, xiàng yí zuòzuò xuěbái de shānfēng.', meaning_vi: 'Trên bầu trời trôi những đám mây trắng bồng bềnh, giống như từng đỉnh núi tuyết trắng xóa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '先',
    pinyin: 'xiān',
    word_type: 'Phó từ',
    meaning_vi: 'trước, trước tiên',
    examples: [
      { chinese: '你先坐一会儿，我马上就来。', pinyin: 'Nǐ xiān zuò yíhuìr, wǒ mǎshàng jiù lái.', meaning_vi: 'Bạn ngồi trước một lát nhé, tôi đến ngay đây.', difficulty_level: 'basic' },
      { chinese: '我们先去超市买菜，然后再回家做晚饭。', pinyin: 'Wǒmen xiān qù chāoshì mǎi cài, ránhòu zài huí jiā zuò wǎnfàn.', meaning_vi: 'Chúng ta đi siêu thị mua thức ăn trước, sau đó mới về nhà nấu bữa tối.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '公园',
    pinyin: 'gōngyuán',
    word_type: 'Danh từ',
    meaning_vi: 'công viên',
    examples: [
      { chinese: '周末很多老人喜欢去公园散步。', pinyin: 'Zhōumò hěn duō lǎorén xǐhuan qù gōngyuán sànbù.', meaning_vi: 'Cuối tuần nhiều người già thích đi dạo trong công viên.', difficulty_level: 'basic' },
      { chinese: '春天一到，公园里的樱花和桃花竞相盛开，吸引了大量游人。', pinyin: 'Chūntiān yí dào, gōngyuán lǐ de yīnghuā hé táohuā jìngxiāng shèngkāi, xīyǐn le dàliàng yóurén.', meaning_vi: 'Mùa xuân vừa tới, hoa anh đào và hoa đào trong công viên đua nhau nở rộ, thu hút lượng lớn du khách.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '公斤',
    pinyin: 'gōngjīn',
    word_type: 'Lượng từ',
    meaning_vi: 'ki-lô-gam (kg)',
    examples: [
      { chinese: '我买了三公斤新鲜的苹果。', pinyin: 'Wǒ mǎi le sān gōngjīn xīnxiān de píngguǒ.', meaning_vi: 'Tôi đã mua ba ki-lô-gam táo tươi.', difficulty_level: 'basic' },
      { chinese: '经过半年的科学锻炼，他的体重成功减轻了五公斤。', pinyin: 'Jīngguò bàn nián de kēxué duànliàn, tā de tǐzhòng chénggōng jiǎnqīng le wǔ gōngjīn.', meaning_vi: 'Qua nửa năm rèn luyện khoa học, cân nặng của anh ấy đã giảm thành công 5 kg.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '关',
    pinyin: 'guān',
    word_type: 'Động từ',
    meaning_vi: 'đóng (cửa), tắt (đèn/quạt/máy tính)',
    examples: [
      { chinese: '离开教室前请记得把灯关上。', pinyin: 'Líkāi jiàoshì qián qǐng jìde bǎ dēng guān shang.', meaning_vi: 'Trước khi rời khỏi lớp học xin nhớ tắt đèn.', difficulty_level: 'basic' },
      { chinese: '外面刮起了大风，快去把房间的窗户关紧。', pinyin: 'Wàimiàn guā qǐ le dà fēng, kuài qù bǎ fángjiān de chuānghu guān jǐn.', meaning_vi: 'Bên ngoài nổi gió to rồi, mau đi đóng chặt cửa sổ phòng lại.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '关于',
    pinyin: 'guānyú',
    word_type: 'Giới từ',
    meaning_vi: 'về, liên quan đến',
    examples: [
      { chinese: '这是一本关于中国历史的书。', pinyin: 'Zhè shì yì běn guānyú Zhōngguó lìshǐ de shū.', meaning_vi: 'Đây là một cuốn sách viết về lịch sử Trung Quốc.', difficulty_level: 'basic' },
      { chinese: '关于下周五文化节的具体活动安排，请参看公告栏。', pinyin: 'Guānyú xià zhōuwǔ wénhuàjié de jùtǐ huódòng ānpái, qǐng cānkàn gōnggàolán.', meaning_vi: 'Về lịch trình hoạt động cụ thể của ngày hội văn hóa thứ sáu tới, xin tham khảo bảng thông báo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '关心',
    pinyin: 'guānxīn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'quan tâm, chăm lo',
    examples: [
      { chinese: '老师非常关心每一位留学生的学习。', pinyin: 'Lǎoshī fēicháng guānxīn měi yí wèi liúxuéshēng de xuéxí.', meaning_vi: 'Thầy cô rất quan tâm đến việc học của từng bạn du học sinh.', difficulty_level: 'basic' },
      { chinese: '生病住院期间，朋友们的悉心关心让他感到分外温暖。', pinyin: 'Shēngbìng zhùyuàn qījiān, péngyoumen de xīxīn guānxīn ràng tā gǎndào fènwài wēnnuǎn.', meaning_vi: 'Trong thời gian nằm viện vì ốm, sự quan tâm chu đáo của bạn bè khiến anh ấy cảm thấy vô cùng ấm áp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '关系',
    pinyin: 'guānxi',
    word_type: 'Danh từ',
    meaning_vi: 'mối quan hệ, liên can',
    examples: [
      { chinese: '没关系，这只是一件小事。', pinyin: 'Méi guānxi, zhè zhǐ shì yí jiàn xiǎoshì.', meaning_vi: 'Không sao đâu, đây chỉ là một chuyện nhỏ thôi.', difficulty_level: 'basic' },
      { chinese: '他们俩不仅是工作上的同事，私下里关系也特别好。', pinyin: 'Tāmen liǎ bùjǐn shì gōngzuò shang de tóngshì, sīxià lǐ guānxi yě tèbié hǎo.', meaning_vi: 'Hai người họ không chỉ là đồng nghiệp trong công việc mà ngoài đời mối quan hệ cũng rất tốt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '其他',
    pinyin: 'qítā',
    word_type: 'Đại từ',
    meaning_vi: 'khác, người khác, cái khác',
    examples: [
      { chinese: '除了小明，其他同学都按时到齐了。', pinyin: 'Chúle Xiǎomíng, qítā tóngxué dōu ànshí dào qí le.', meaning_vi: 'Ngoài Tiểu Minh ra, các bạn học khác đều đã đến đông đủ đúng giờ.', difficulty_level: 'basic' },
      { chinese: '如果您对这个方案没有其他疑问，我们就可以正式签约了。', pinyin: 'Rúguǒ nín duì zhè ge fāng’àn méiyǒu qítā yíwèn, wǒmen jiù kěyǐ zhèngshì qiānyuē le.', meaning_vi: 'Nếu quý khách không còn thắc mắc gì khác về phương án này, chúng ta có thể chính thức ký hợp đồng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '其实',
    pinyin: 'qíshí',
    word_type: 'Phó từ',
    meaning_vi: 'thực ra, kỳ thực',
    examples: [
      { chinese: '这道题看着很难，其实一点儿也不难。', pinyin: 'Zhè dào tí kàn zhe hěn nán, qíshí yìdiǎnr yě bù nán.', meaning_vi: 'Câu này nhìn thì có vẻ khó, thực ra chẳng khó chút nào.', difficulty_level: 'basic' },
      { chinese: '他表面上看起来很严肃，其实私底下为人特别和气幽默。', pinyin: 'Tā biǎomiàn shang kàn qǐlái hěn yánsù, qíshí sīdǐxià wéirén tèbié héqì yōumò.', meaning_vi: 'Bề ngoài trông anh ấy rất nghiêm nghị, kỳ thực trong đời thường tính tình lại rất hòa nhã và hài hước.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '最后',
    pinyin: 'zuìhòu',
    word_type: 'Danh từ / Phó từ',
    meaning_vi: 'cuối cùng',
    examples: [
      { chinese: '经过多次努力，他最后通过了考试。', pinyin: 'Jīngguò duō cì nǔlì, tā zuìhòu tōngguò le kǎoshì.', meaning_vi: 'Trải qua nhiều lần nỗ lực, cuối cùng anh ấy đã thi đỗ.', difficulty_level: 'basic' },
      { chinese: '比赛进行到最后一分钟，我们队凭借默契配合逆转夺冠。', pinyin: 'Bǐsài jìnxíng dào zuìhòu yì fēnzhōng, wǒmen duì píngjiè mòqì pèihé nìzhuǎn duó guàn.', meaning_vi: 'Trận đấu bước vào phút thi đấu cuối cùng, đội chúng tôi nhờ sự phối hợp ăn ý đã lội ngược dòng đoạt chức vô địch.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '最近',
    pinyin: 'zuìjìn',
    word_type: 'Danh từ / Phó từ',
    meaning_vi: 'gần đây, dạo này',
    examples: [
      { chinese: '好久不见，你最近身体怎么样？', pinyin: 'Hǎojiǔ bú jiàn, nǐ zuìjìn shēntǐ zěnmeyàng?', meaning_vi: 'Lâu ngày không gặp, dạo này sức khỏe bạn thế nào?', difficulty_level: 'basic' },
      { chinese: '最近一段时间公司业务很繁忙，大家经常加班到很晚。', pinyin: 'Zuìjìn yí duàn shíjiān gōngsī yèwù hěn fánmáng, dàjiā jīngcháng jiābān dào hěn wǎn.', meaning_vi: 'Khoảng thời gian gần đây việc công ty rất bận rộn, mọi người thường tăng ca đến khuya.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '冰箱',
    pinyin: 'bīngxiāng',
    word_type: 'Danh từ',
    meaning_vi: 'tủ lạnh',
    examples: [
      { chinese: '请把吃剩的西瓜放进冰箱保鲜。', pinyin: 'Qǐng bǎ chī shèng de xīguā fàng jìn bīngxiāng bǎoxiān.', meaning_vi: 'Xin hãy cho chỗ dưa hấu ăn thừa vào tủ lạnh để bảo quản.', difficulty_level: 'basic' },
      { chinese: '夏天天气热，从冰箱里拿出一瓶冰镇酸奶喝真过瘾。', pinyin: 'Xiàtiān tiānqì rè, cóng bīngxiāng lǐ ná chū yì píng bīngzhèn suānnǎi hē zhēn guòyǐn.', meaning_vi: 'Mùa hè thời tiết nóng bức, lấy một chai sữa chua ướp lạnh từ tủ lạnh ra uống thật đã.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '决定',
    pinyin: 'juédìng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'quyết định',
    examples: [
      { chinese: '我决定毕业后去中国留学深造。', pinyin: 'Wǒ juédìng bìyè hòu qù Zhōngguó liúxué shēnzào.', meaning_vi: 'Tôi quyết định sau khi tốt nghiệp sẽ sang Trung Quốc du học nâng cao.', difficulty_level: 'basic' },
      { chinese: '经过全家人的认真商量，大家一致决定下个月搬进新家。', pinyin: 'Jīngguò quán jiā rén de rènzhēn shāngliang, dàjiā yízhì juédìng xià gè yuè bān jìn xīn jiā.', meaning_vi: 'Sau khi cả nhà cùng bàn bạc kỹ lưỡng, mọi người nhất trí quyết định tháng sau chuyển về nhà mới.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '几乎',
    pinyin: 'jīhū',
    word_type: 'Phó từ',
    meaning_vi: 'hầu như, gần như',
    examples: [
      { chinese: '今天全班同学几乎都按时到了。', pinyin: 'Jīntiān quán bān tóngxué jīhū dōu ànshí dào le.', meaning_vi: 'Hôm nay học sinh toàn lớp hầu như đều đã đến đúng giờ.', difficulty_level: 'basic' },
      { chinese: '离开家乡十几年，这座城市的变化大得让他几乎认不出来了。', pinyin: 'Líkāi jiāxiāng shí jǐ nián, zhè zuò chéngshì de biànhuà dà de ràng tā jīhū rèn bù chūlái le.', meaning_vi: 'Xa quê mười mấy năm, sự đổi thay của thành phố này lớn đến mức khiến anh ấy gần như không nhận ra.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '刚才',
    pinyin: 'gāngcái',
    word_type: 'Danh từ',
    meaning_vi: 'vừa mới, vừa nãy',
    examples: [
      { chinese: '刚才谁敲门了？', pinyin: 'Gāngcái shéi qiāo mén le?', meaning_vi: 'Vừa nãy ai gõ cửa thế?', difficulty_level: 'basic' },
      { chinese: '刚才在走廊里我好像看见王老师从办公室走出来了。', pinyin: 'Gāngcái zài zǒuláng lǐ wǒ hǎoxiàng kànjiàn Wáng lǎoshī cóng bàngōngshì zǒu chūlái le.', meaning_vi: 'Vừa nãy ngoài hành lang hình như tôi nhìn thấy thầy Vương từ văn phòng bước ra.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '刻',
    pinyin: 'kè',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'khắc (15 phút)',
    examples: [
      { chinese: '现在是上午十点一刻。', pinyin: 'Xiànzài shì shàngwǔ shí diǎn yí kè.', meaning_vi: 'Bây giờ là mười giờ mười lăm phút sáng.', difficulty_level: 'basic' },
      { chinese: '还有一刻钟火车就要开出了，大家抓紧时间上车。', pinyin: 'Hái yǒu yí kè zhōng huǒchē jiù yào kāi chū le, dàjiā zhuājǐn shíjiān shàng chē.', meaning_vi: 'Còn mười lăm phút nữa tàu hỏa sẽ chuyển bánh, mọi người hãy khẩn trương lên tàu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '办公室',
    pinyin: 'bàngōngshì',
    word_type: 'Danh từ',
    meaning_vi: 'văn phòng, phòng làm việc',
    examples: [
      { chinese: '老师正在二楼办公室备课。', pinyin: 'Lǎoshī zhèngzài èr lóu bàngōngshì bèikè.', meaning_vi: 'Thầy giáo đang chuẩn bị giáo án ở văn phòng tầng hai.', difficulty_level: 'basic' },
      { chinese: '进入办公室请轻声关门，保持良好的安静办公环境。', pinyin: 'Jìnrù bàngōngshì qǐng qīngshēng guān mén, bǎochí liánghǎo de ānjìng bàngōng huánjìng.', meaning_vi: 'Vào văn phòng xin nhẹ nhàng khép cửa, duy trì môi trường làm việc yên tĩnh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '办法',
    pinyin: 'bànfǎ',
    word_type: 'Danh từ',
    meaning_vi: 'biện pháp, phương pháp, cách giải quyết',
    examples: [
      { chinese: '你想出一个解决问题的好办法了吗？', pinyin: 'Nǐ xiǎng chū yí gè jiějué wèntí de hǎo bànfǎ le ma?', meaning_vi: 'Bạn đã nghĩ ra biện pháp hay để giải quyết vấn đề chưa?', difficulty_level: 'basic' },
      { chinese: '遇到困难时别轻易退缩，总能找到克服它的好办法。', pinyin: 'Yù dào kùnnan shí bié qīngyì tuìsuō, zǒng néng zhǎodào kèfú tā de hǎo bànfǎ.', meaning_vi: 'Khi gặp khó khăn đừng vội chùn bước, luôn có thể tìm ra cách hay để khắc phục nó.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '动物',
    pinyin: 'dòngwù',
    word_type: 'Danh từ',
    meaning_vi: 'động vật, muông thú',
    examples: [
      { chinese: '小孩子一般都很喜欢小动物。', pinyin: 'Xiǎoháizi yìbān dōu hěn xǐhuan xiǎo dòngwù.', meaning_vi: 'Trẻ con thông thường đều rất thích động vật nhỏ.', difficulty_level: 'basic' },
      { chinese: '关爱野生动物、保护生态平衡是全人类共同的责任。', pinyin: 'Guān’ài yěshēng dòngwù, bǎohù shēngtài pínghéng shì quán rénlèi gòngtóng de zérèn.', meaning_vi: 'Quan tâm động vật hoang dã và bảo vệ cân bằng sinh thái là trách nhiệm chung của toàn nhân loại.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '努力',
    pinyin: 'nǔlì',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'nỗ lực, cố gắng, chăm chỉ',
    examples: [
      { chinese: '他平时学习非常努力。', pinyin: 'Tā píngshí xuéxí fēicháng nǔlì.', meaning_vi: 'Bình thường anh ấy học tập rất chăm chỉ.', difficulty_level: 'basic' },
      { chinese: '只要从现在起脚踏实地努力，将来就一定能收获丰硕的成果。', pinyin: 'Zhǐyào cóng xiànzài qǐ jiǎotàshídì nǔlì, jiānglái jiù yídìng néng shōuhuò fēngshuò de chéngguǒ.', meaning_vi: 'Chỉ cần từ bây giờ nỗ lực thiết thực vững chắc, tương lai nhất định sẽ gặt hái thành quả rực rỡ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '北方',
    pinyin: 'běifāng',
    word_type: 'Danh từ',
    meaning_vi: 'miền bắc, phương bắc',
    examples: [
      { chinese: '中国北方冬天的天气非常寒冷。', pinyin: 'Zhōngguó běifāng dōngtiān de tiānqì fēicháng hánlěng.', meaning_vi: 'Mùa đông ở miền bắc Trung Quốc thời tiết vô cùng giá lạnh.', difficulty_level: 'basic' },
      { chinese: '北方人主食习惯吃面条和馒头，而南方人更偏爱米饭。', pinyin: 'Běifāng rén zhǔshí xíguàn chī miàntiáo hé mántou, ér nánfāng rén gèng piān’ài mǐfàn.', meaning_vi: 'Người miền bắc có thói quen ăn món chính là mì sợi và màn thầu, còn người miền nam lại chuộng cơm hơn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '南',
    pinyin: 'nán',
    word_type: 'Danh từ',
    meaning_vi: 'phía nam, hướng nam',
    examples: [
      { chinese: '教室的门朝南开着。', pinyin: 'Jiàoshì de mén cháo nán kāi zhe.', meaning_vi: 'Cửa phòng học mở về hướng nam.', difficulty_level: 'basic' },
      { chinese: '车站向南走五百米有一家大型综合医院。', pinyin: 'Chēzhàn xiàng nán zǒu wǔbǎi mǐ yǒu yì jiā dàxíng zōnghé yīyuàn.', meaning_vi: 'Từ bến xe đi về phía nam năm trăm mét có một bệnh viện đa khoa lớn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '历史',
    pinyin: 'lìshǐ',
    word_type: 'Danh từ',
    meaning_vi: 'lịch sử',
    examples: [
      { chinese: '北京是一座有着三千多年历史的古城。', pinyin: 'Běijīng shì yí zuò yǒu zhe sānqiān duō nián lìshǐ de gǔchéng.', meaning_vi: 'Bắc Kinh là một cổ thành có hơn ba ngàn năm lịch sử.', difficulty_level: 'basic' },
      { chinese: '学习悠久的历史可以让我们更好地认识过去并开创未来。', pinyin: 'Xuéxí yōujiǔ de lìshǐ kěyǐ ràng wǒmen gèng hǎo de rènshi guòqù bìng kāichuàng wèilái.', meaning_vi: 'Học tập lịch sử lâu đời có thể giúp chúng ta hiểu rõ hơn về quá khứ và mở ra tương lai.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '参加',
    pinyin: 'cānjiā',
    word_type: 'Động từ',
    meaning_vi: 'tham gia, tham dự',
    examples: [
      { chinese: '下个星期他要参加汉语水平考试。', pinyin: 'Xià gè xīngqī tā yào cānjiā Hànyǔ Shuǐpíng Kǎoshì.', meaning_vi: 'Tuần sau anh ấy phải tham gia kỳ thi kiểm tra trình độ tiếng Trung HSK.', difficulty_level: 'basic' },
      { chinese: '欢迎大家积极参加学校举办的中华传统文化体验活动。', pinyin: 'Huānyíng dàjiā jījí cānjiā xuéxiào jǔbàn de Zhōnghuá chuántǒng wénhuà tǐyàn huódòng.', meaning_vi: 'Hoan nghênh mọi người tích cực tham gia hoạt động trải nghiệm văn hóa truyền thống do trường tổ chức.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '又',
    pinyin: 'yòu',
    word_type: 'Phó từ',
    meaning_vi: 'lại, vừa... lại...',
    examples: [
      { chinese: '这家饭馆的菜又便宜又好吃。', pinyin: 'Zhè jiā fànguǎn de cài yòu piányi yòu hǎochī.', meaning_vi: 'Món ăn của quán cơm này vừa rẻ lại vừa ngon miệng.', difficulty_level: 'basic' },
      { chinese: '今天早上下雨了，下午怎么又下起雪来了。', pinyin: 'Jīntiān zǎoshang xiàyǔ le, xiàwǔ zěnme yòu xià qǐ xuě lái le.', meaning_vi: 'Sáng nay trời vừa mưa xong, buổi chiều sao lại đổ tuyết xuống nữa rồi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '双',
    pinyin: 'shuāng',
    word_type: 'Lượng từ',
    meaning_vi: 'đôi, cặp (giày, đũa, mắt)',
    examples: [
      { chinese: '他买了一双黑色的新皮鞋。', pinyin: 'Tā mǎi le yì shuāng hēisè de xīn píxié.', meaning_vi: 'Anh ấy đã mua một đôi giày da mới màu đen.', difficulty_level: 'basic' },
      { chinese: '服务员，请给我们拿一双干净的筷子。', pinyin: 'Fúwùyuán, qǐng gěi wǒmen ná yì shuāng gānjìng de kuàizi.', meaning_vi: 'Phục vụ ơi, làm ơn lấy cho chúng tôi một đôi đũa sạch.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '发',
    pinyin: 'fā',
    word_type: 'Động từ',
    meaning_vi: 'gửi (thư/tin nhắn), phát, phát ra',
    examples: [
      { chinese: '我已经把文件发到你的邮箱了。', pinyin: 'Wǒ yǐjīng bǎ wénjiàn fā dào nǐ de yóuxiāng le.', meaning_vi: 'Tôi đã gửi tài liệu vào hòm thư điện tử của bạn rồi.', difficulty_level: 'basic' },
      { chinese: '到家以后记得给我发一条短信报个平安。', pinyin: 'Dào jiā yǐhòu jìde gěi wǒ fā yì tiáo duǎnxìn bào gè píng’ān.', meaning_vi: 'Về đến nhà rồi nhớ gửi cho tôi một tin nhắn báo bình an nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '发烧',
    pinyin: 'fāshāo',
    word_type: 'Động từ',
    meaning_vi: 'phát sốt, bị sốt',
    examples: [
      { chinese: '他感冒了，身体一直在发烧。', pinyin: 'Tā gǎnmào le, shēntǐ yìzhí zài fāshāo.', meaning_vi: 'Cậu ấy bị cảm rồi, cơ thể cứ bị sốt suốt.', difficulty_level: 'basic' },
      { chinese: '如果体温超过三十八度五，发烧时要及时去医院看医生。', pinyin: 'Rúguǒ tǐwēn chāoguò sānshíbā dù wǔ, fāshāo shí yào jíshí qù yīyuàn kàn yīshēng.', meaning_vi: 'Nếu thân nhiệt vượt quá 38.5 độ, khi bị sốt cần kịp thời đến bệnh viện khám bác sĩ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '发现',
    pinyin: 'fāxiàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phát hiện, nhận ra',
    examples: [
      { chinese: '我刚才发现钥匙忘在桌子上了。', pinyin: 'Wǒ gāngcái fāxiàn yàoshi wàng zài zhuōzi shang le.', meaning_vi: 'Vừa nãy tôi phát hiện chìa khóa để quên trên bàn rồi.', difficulty_level: 'basic' },
      { chinese: '经过细心观察，科学家在这个古老山洞里有了重大发现。', pinyin: 'Jīngguò xìxīn guānchá, kēxuéjiā zài zhè ge gǔlǎo shāndòng lǐ yǒu le zhòngdà fāxiàn.', meaning_vi: 'Qua quan sát tỉ mỉ, các nhà khoa học đã có phát hiện quan trọng trong hang động cổ này.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '叔叔',
    pinyin: 'shūshu',
    word_type: 'Danh từ',
    meaning_vi: 'chú, người đàn ông trạc tuổi chú',
    examples: [
      { chinese: '叔叔送给我一本精美的画册。', pinyin: 'Shūshu sòng gěi wǒ yì běn jīngměi de huàcè.', meaning_vi: 'Chú tặng cho tôi một cuốn tập tranh tinh xảo.', difficulty_level: 'basic' },
      { chinese: '在路上遇到熟识的长辈，要有礼貌地叫一声“叔叔好”。', pinyin: 'Zài lù shang yù dào shúshí de zhǎngbèi, yào yǒu lǐmào de jiào yì shēng “shūshu hǎo”.', meaning_vi: 'Trên đường gặp người lớn tuổi quen biết, cần lễ phép cất lời chào "cháu chào chú ạ".', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '变化',
    pinyin: 'biànhuà',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'thay đổi, sự biến đổi',
    examples: [
      { chinese: '这几年家乡的发展变化真大。', pinyin: 'Zhè jǐ nián jiāxiāng de fāzhǎn biànhuà zhēn dà.', meaning_vi: 'Mấy năm nay sự phát triển đổi thay của quê hương thật to lớn.', difficulty_level: 'basic' },
      { chinese: '秋天到来时，随着气温逐渐下降，树叶的颜色也悄然发生着变化。', pinyin: 'Qiūtiān dàolái shí, suízhe qìwēn zhújiàn xiàjiàng, shùyè de yánsè yě qiǎorán fāshēng zhe biànhuà.', meaning_vi: 'Khi mùa thu tới, theo nhiệt độ dần hạ thấp, màu sắc của lá cây cũng lặng lẽ biến đổi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '句子',
    pinyin: 'jùzi',
    word_type: 'Danh từ',
    meaning_vi: 'câu, câu văn',
    examples: [
      { chinese: '请用这个新词造一个完整的句子。', pinyin: 'Qǐng yòng zhè ge xīn cí zào yí gè wánzhěng de jùzi.', meaning_vi: 'Xin hãy dùng từ mới này đặt một câu hoàn chỉnh.', difficulty_level: 'basic' },
      { chinese: '通过熟读课文中的重点句子，我们可以更好地掌握汉语句型结构。', pinyin: 'Tōngguò shú dú kèwén zhōng de zhòngdiǎn jùzi, wǒmen kěyǐ gèng hǎo de zhǎngwò Hànyǔ jùxíng jiégòu.', meaning_vi: 'Nhờ đọc nhuần nhuyễn các câu trọng điểm trong bài khóa, chúng ta có thể nắm bắt tốt hơn cấu trúc mẫu câu tiếng Trung.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '可爱',
    pinyin: "kě'ài",
    word_type: 'Tính từ',
    meaning_vi: 'đáng yêu, dễ thương',
    examples: [
      { chinese: '那只小猫长得真可爱。', pinyin: 'Nà zhī xiǎomāo zhǎng de zhēn kě’ài.', meaning_vi: 'Chú mèo con đó trông thật đáng yêu.', difficulty_level: 'basic' },
      { chinese: '动物园里的大熊猫慢悠悠吃竹子的样子非常憨厚可爱。', pinyin: 'Dòngwùyuán lǐ de dàxióngmāo mànyōuyōu chī zhúzi de yàngzi fēicháng hānhou kě’ài.', meaning_vi: 'Dáng vẻ chậm rãi ăn trúc của chú gấu trúc trong sở thú vô cùng ngây thơ dễ thương.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '司机',
    pinyin: 'sījī',
    word_type: 'Danh từ',
    meaning_vi: 'tài xế, lái xe',
    examples: [
      { chinese: '出租车司机的驾驶技术非常好。', pinyin: 'Chūzūchē sījī de jiàshǐ jìshù fēicháng hǎo.', meaning_vi: 'Kỹ thuật lái xe của tài xế taxi rất tốt.', difficulty_level: 'basic' },
      { chinese: '下公共汽车前，很多乘客都会礼貌地向司机师傅说一声谢谢。', pinyin: 'Xià gōnggòng qìchē qián, hěn duō chéngkè dōu huì lǐmào de xiàng sījī shīfu shuō yì shēng xièxie.', meaning_vi: 'Trước khi xuống xe buýt, nhiều hành khách đều lịch sự nói lời cảm ơn bác tài xế.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '同事',
    pinyin: 'tóngshì',
    word_type: 'Danh từ',
    meaning_vi: 'đồng nghiệp',
    examples: [
      { chinese: '我和办公室里的同事们相处得很融洽。', pinyin: 'Wǒ hé bàngōngshì lǐ de tóngshìmen xiāngchǔ de hěn róngqià.', meaning_vi: 'Tôi và các đồng nghiệp trong văn phòng chung sống rất hòa hợp.', difficulty_level: 'basic' },
      { chinese: '在工作中遇到困难时，热心的同事主动伸出援手给予帮助。', pinyin: 'Zài gōngzuò zhōng yù dào kùnnan shí, rèxīn de tóngshì zhǔdòng shēn chū yuánshǒu jǐyǔ bāngzhù.', meaning_vi: 'Khi gặp khó khăn trong công việc, người đồng nghiệp nhiệt tình đã chủ động chìa tay giúp đỡ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '同意',
    pinyin: 'tóngyì',
    word_type: 'Động từ',
    meaning_vi: 'đồng ý, tán thành',
    examples: [
      { chinese: '我完全同意你刚才提出的建议。', pinyin: 'Wǒ wánquán tóngyì nǐ gāngcái tíchū de jiànyì.', meaning_vi: 'Tôi hoàn toàn đồng ý với kiến nghị bạn vừa đưa ra.', difficulty_level: 'basic' },
      { chinese: '经过全组讨论，大家都一致同意按照新的计划方案开展下一步工作。', pinyin: 'Jīngguò quán zǔ tǎolùn, dàjiā dōu yízhì tóngyì ànzhào xīn de jìhuà fāng’àn kāizhǎn xià yí bù gōngzuò.', meaning_vi: 'Qua thảo luận của toàn nhóm, mọi người đều nhất trí đồng ý triển khai bước công việc tiếp theo theo phương án kế hoạch mới.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '后来',
    pinyin: 'hòulái',
    word_type: 'Danh từ',
    meaning_vi: 'sau này, về sau (chỉ sự việc trong quá khứ)',
    examples: [
      { chinese: '他起初学画画，后来喜欢上了书法。', pinyin: 'Tā qǐchū xué huàhuà, hòulái xǐhuan shang le shūfǎ.', meaning_vi: 'Ban đầu anh ấy học vẽ, về sau lại đem lòng yêu thích thư pháp.', difficulty_level: 'basic' },
      { chinese: '由于突然生病他没能参加考试，后来学校为他安排了补考。', pinyin: 'Yóuyú tūrán shēngbìng tā méi néng cānjiā kǎoshì, hòulái xuéxiào wèi tā ānpái le bǔkǎo.', meaning_vi: 'Do đột ngột bị ốm nên anh ấy không thể dự thi, sau này trường đã sắp xếp cho anh ấy thi bù.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '向',
    pinyin: 'xiàng',
    word_type: 'Giới từ',
    meaning_vi: 'hướng về, phía, tới',
    examples: [
      { chinese: '从这里一直向前走就是图书馆。', pinyin: 'Cóng zhèlǐ yìzhí xiàng qián zǒu jiù shì túshūguǎn.', meaning_vi: 'Từ đây cứ đi thẳng về phía trước là tới thư viện.', difficulty_level: 'basic' },
      { chinese: '遇到学习上的疑难问题时，要虚心向老师和优秀的同学请教。', pinyin: 'Yù dào xuéxí shang de yínán wèntí shí, yào xūxīn xiàng lǎoshī hé yōuxiù de tóngxué qǐngjiào.', meaning_vi: 'Khi gặp khúc mắc trong học tập, cần khiêm tốn thỉnh giáo thầy cô và bạn học xuất sắc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '周末',
    pinyin: 'zhōumò',
    word_type: 'Danh từ',
    meaning_vi: 'cuối tuần',
    examples: [
      { chinese: '这个周末你有什么游玩打算？', pinyin: 'Zhè ge zhōumò nǐ yǒu shénme yóuwán dǎsuàn?', meaning_vi: 'Cuối tuần này bạn có dự định đi chơi gì không?', difficulty_level: 'basic' },
      { chinese: '平时工作很紧张，到了周末大家都喜欢放下烦恼好好放松一下。', pinyin: 'Píngshí gōngzuò hěn jǐnzhāng, dào le zhōumò dàjiā dōu xǐhuan fàngxià fánnǎo hǎohāo fàngsōng yíxià.', meaning_vi: 'Ngày thường công việc rất căng thẳng, đến cuối tuần mọi người đều thích gác lại muộn phiền để thư giãn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '哭',
    pinyin: 'kū',
    word_type: 'Động từ',
    meaning_vi: 'khóc',
    examples: [
      { chinese: '小妹妹摔倒了，痛得大声哭了起来。', pinyin: 'Xiǎo mèimei shuāidǎo le, tòng de dàshēng kū le qǐlái.', meaning_vi: 'Em gái nhỏ bị ngã, đau quá òa khóc thật to.', difficulty_level: 'basic' },
      { chinese: '这部电影的结局太感人了，好多观众都忍不住流下了眼泪。', pinyin: 'Zhè bù diànyǐng de jiéjú tài gǎnrén le, hǎoduō guānzhòng dōu rěnbuzhù liú xià le yǎnlèi.', meaning_vi: 'Cái kết của bộ phim này quá cảm động, rất nhiều khán giả đều không kìm được rơi nước mắt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '啤酒',
    pinyin: 'píjiǔ',
    word_type: 'Danh từ',
    meaning_vi: 'bia',
    examples: [
      { chinese: '吃烧烤的时候喝一杯冰啤酒很过瘾。', pinyin: 'Chī shāokǎo de shíhou hē yì bēi bīng píjiǔ hěn guòyǐn.', meaning_vi: 'Khi ăn đồ nướng uống một cốc bia lạnh thật đã.', difficulty_level: 'basic' },
      { chinese: '请注意适量饮酒，开车的人千万不能喝啤酒。', pinyin: 'Qǐng zhùyì shìliàng yǐnjiǔ, kāi chē de rén qiānwàn bù néng hē píjiǔ.', meaning_vi: 'Xin hãy chú ý uống rượu bia điều độ, người lái xe tuyệt đối không được uống bia.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '嘴',
    pinyin: 'zuǐ',
    word_type: 'Danh từ',
    meaning_vi: 'miệng, mồm',
    examples: [
      { chinese: '吃完饭后记得用纸巾把嘴擦干净。', pinyin: 'Chī wán fàn hòu jìde yòng zhǐjīn bǎ zuǐ cā gānjìng.', meaning_vi: 'Ăn cơm xong nhớ dùng khăn giấy lau sạch miệng nhé.', difficulty_level: 'basic' },
      { chinese: '张开嘴，深吸一口气，让医生仔细检查一下喉咙。', pinyin: 'Zhāng kāi zuǐ, shēn xī yì kǒu qì, ràng yīshēng zǐxì jiǎnchá yíxià hóulóng.', meaning_vi: 'Há to miệng ra, hít một hơi sâu để bác sĩ kiểm tra kỹ vùng họng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '回答',
    pinyin: 'huídá',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'trả lời, câu trả lời',
    examples: [
      { chinese: '请你站起来回答老师的问题。', pinyin: 'Qǐng nǐ zhàn qǐlái huídá lǎoshī de wèntí.', meaning_vi: 'Xin mời bạn đứng dậy trả lời câu hỏi của thầy giáo.', difficulty_level: 'basic' },
      { chinese: '面对记者的提问，发言人做出了清晰而准确的正面回答。', pinyin: 'Miànduì jìzhě de tíwèn, fāyánrén zuò chū le qīngxī ér zhǔnquè de zhèngmiàn huídá.', meaning_vi: 'Đối diện với câu hỏi của phóng viên, người phát ngôn đã đưa ra câu trả lời trực diện rõ ràng và chuẩn xác.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '国家',
    pinyin: 'guójiā',
    word_type: 'Danh từ',
    meaning_vi: 'quốc gia, đất nước',
    examples: [
      { chinese: '中国是一个拥有悠久历史的国家。', pinyin: 'Zhōngguó shì yí gè yōngyǒu yōujiǔ lìshǐ de guójiā.', meaning_vi: 'Trung Quốc là một quốc gia có bề dày lịch sử lâu đời.', difficulty_level: 'basic' },
      { chinese: '不同国家的人们携手合作，共同建设和平美好的地球家园。', pinyin: 'Bù tóng guójiā de rénmen xiéshǒu hézuò, gòngtóng jiànshè hépíng měihǎo de dìqiú jiāyuán.', meaning_vi: 'Người dân các quốc gia khác nhau cùng chung tay hợp tác xây dựng ngôi nhà Trái Đất hòa bình tốt đẹp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '图书馆',
    pinyin: 'túshūguǎn',
    word_type: 'Danh từ',
    meaning_vi: 'thư viện',
    examples: [
      { chinese: '我经常在周末去图书馆自习。', pinyin: 'Wǒ jīngcháng zài zhōumò qù túshūguǎn zìxí.', meaning_vi: 'Cuối tuần tôi thường đến thư viện tự học.', difficulty_level: 'basic' },
      { chinese: '大学图书馆里藏书丰富，为广大学生提供了良好的研究环境。', pinyin: 'Dàxué túshūguǎn lǐ cángshū fēngfù, wèi guǎngdà xuésheng tígōng le liánghǎo de yánjiū huánjìng.', meaning_vi: 'Trong thư viện trường đại học tàng thư phong phú, mang đến môi trường nghiên cứu tuyệt vời cho đông đảo sinh viên.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '地',
    pinyin: 'de',
    word_type: 'Trợ từ',
    meaning_vi: 'trợ từ kết cấu (nối phó từ/trạng ngữ với động từ)',
    examples: [
      { chinese: '小鸟在树枝上快乐地歌唱。', pinyin: 'Xiǎoniǎo zài shùzhī shang kuàilè de gēchàng.', meaning_vi: 'Những chú chim nhỏ vui vẻ hót ca trên cành cây.', difficulty_level: 'basic' },
      { chinese: '听到顺利通过考试的消息，他兴奋地从椅子上跳了起来。', pinyin: 'Tīng dào shùnlì tōngguò kǎoshì de xiāoxi, tā xīngfèn de cóng yǐzi shang tiào le qǐlái.', meaning_vi: 'Nghe được tin thi đỗ thuận lợi, cậu ấy phấn khởi nhảy cẫng lên khỏi chiếc ghế.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '地图',
    pinyin: 'dìtú',
    word_type: 'Danh từ',
    meaning_vi: 'bản đồ',
    examples: [
      { chinese: '去陌生的城市旅游最好随身带一张地图。', pinyin: 'Qù mòshēng de chéngshì lǚyóu zuìhǎo suíshēn dài yì zhāng dìtú.', meaning_vi: 'Đi du lịch tới thành phố lạ tốt nhất nên mang theo một tấm bản đồ bên mình.', difficulty_level: 'basic' },
      { chinese: '手机上的电子地图能实时导航，极大地避免了在路上迷路。', pinyin: 'Shǒujī shang de diànzǐ dìtú néng shíshí dǎoháng, jídà de bìmǐan le zài lù shang mílù.', meaning_vi: 'Bản đồ điện tử trên điện thoại có thể định vị dẫn đường trực tiếp, tránh được việc lạc đường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '地方',
    pinyin: 'dìfang',
    word_type: 'Danh từ',
    meaning_vi: 'nơi chốn, chỗ, địa phương',
    examples: [
      { chinese: '这个地方的风景十分美丽。', pinyin: 'Zhè ge dìfang de fēngjǐng shífēn měilì.', meaning_vi: 'Phong cảnh của nơi này vô cùng tươi đẹp.', difficulty_level: 'basic' },
      { chinese: '我们找个安静舒适的地方坐下来喝杯茶慢慢聊吧。', pinyin: 'Wǒmen zhǎo gè ānjìng shūshì de dìfang zuò xiàlái hē bēi chá mànmàn liáo ba.', meaning_vi: 'Chúng mình tìm một chỗ yên tĩnh dễ chịu ngồi xuống uống ly trà rồi từ từ nói chuyện nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '城市',
    pinyin: 'chéngshì',
    word_type: 'Danh từ',
    meaning_vi: 'thành phố, đô thị',
    examples: [
      { chinese: '北京是一座现代化的国际大城市。', pinyin: 'Běijīng shì yí zuò xiàndàihuà de guójì dà chéngshì.', meaning_vi: 'Bắc Kinh là một thành phố lớn quốc tế hiện đại.', difficulty_level: 'basic' },
      { chinese: '随着城市绿化建设的不断推进，街道两旁的环境越来越宜人。', pinyin: 'Suízhe chéngshì lǜhuà jiànshè de búduàn tuījìn, jiēdào liǎngpáng de huánjìng yuèláiyuè yírén.', meaning_vi: 'Cùng với việc không ngừng đẩy mạnh xây dựng mảng xanh đô thị, môi trường hai bên đường phố ngày càng trong lành dễ chịu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '声音',
    pinyin: 'shēngyīn',
    word_type: 'Danh từ',
    meaning_vi: 'âm thanh, tiếng động, giọng nói',
    examples: [
      { chinese: '请把电视的声音调小一点儿。', pinyin: 'Qǐng bǎ diànshì de shēngyīn tiáo xiǎo yìdiǎnr.', meaning_vi: 'Làm ơn chỉnh âm thanh của tivi nhỏ lại một chút.', difficulty_level: 'basic' },
      { chinese: '夜深人静的时候，窗外偶尔传来清脆的风吹树叶的声音。', pinyin: 'Yèshēn rénjìng de shíhou, chuāngwài ǒu’ěr chuán lái qīngcuì de fēng chuī shùyè de shēngyīn.', meaning_vi: 'Lúc đêm khuya người vắng, ngoài cửa sổ thi thoảng truyền vào tiếng gió lay cành lá xào xạc thanh thoát.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '复习',
    pinyin: 'fùxí',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'ôn tập, ôn bài',
    examples: [
      { chinese: '明天有考试，今晚我们要认真复习。', pinyin: 'Míngtiān yǒu kǎoshì, jīnwǎn wǒmen yào rènzhēn fùxí.', meaning_vi: 'Ngày mai có thi, tối nay chúng ta phải chăm chỉ ôn tập.', difficulty_level: 'basic' },
      { chinese: '课后及时复习学过的生词和语法，能大大提高学习效率。', pinyin: 'Kèhòu jíshí fùxí xué guò de shēngcí hé yǔfǎ, néng dàdà tígāo xuéxí xiàolǜ.', meaning_vi: 'Sau giờ học kịp thời ôn lại từ mới và ngữ pháp đã học có thể nâng cao đáng kể hiệu suất học tập.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '太阳',
    pinyin: 'tàiyáng',
    word_type: 'Danh từ',
    meaning_vi: 'mặt trời, ánh nắng',
    examples: [
      { chinese: '早晨的太阳红彤彤的，非常好看。', pinyin: 'Zǎochén de tàiyáng hóngtōngtōng de, fēicháng hǎokàn.', meaning_vi: 'Mặt trời buổi sớm đỏ rực, rất đẹp mắt.', difficulty_level: 'basic' },
      { chinese: '冬天坐在阳台上晒晒温暖的太阳，让人感到身心舒畅。', pinyin: 'Dōngtiān zuò zài yángtái shang shàishai wēnnuǎn de tàiyáng, ràng rén gǎndào shēnxīn shūchàng.', meaning_vi: 'Mùa đông ngồi ngoài ban công sưởi ánh nắng ấm áp khiến con người cảm thấy thư thái cả thể xác lẫn tinh thần.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '头发',
    pinyin: 'tóufa',
    word_type: 'Danh từ',
    meaning_vi: 'tóc, mái tóc',
    examples: [
      { chinese: '她的头发又黑又长，非常漂亮。', pinyin: 'Tā de tóufa yòu hēi yòu cháng, fēicháng piàoliang.', meaning_vi: 'Mái tóc của cô ấy vừa đen vừa dài, rất đẹp.', difficulty_level: 'basic' },
      { chinese: '为了给炎热的夏天带来凉爽，他周末特意去理发店剪短了头发。', pinyin: 'Wèile gěi yánrè de xiàtiān dài lái liángshuǎng, tā zhōumò tèyì qù lǐfàdiàn jiǎn duǎn le tóufa.', meaning_vi: 'Để mang lại sự mát mẻ cho mùa hè oi bức, cuối tuần anh ấy đặc biệt đến tiệm cắt tóc cắt ngắn mái tóc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '奇怪',
    pinyin: 'qíguài',
    word_type: 'Tính từ',
    meaning_vi: 'kỳ lạ, quái lạ',
    examples: [
      { chinese: '真奇怪，我的手机怎么突然黑屏了？', pinyin: 'Zhēn qíguài, wǒ de shǒujī zěnme tūrán hēipíng le?', meaning_vi: 'Thật kỳ lạ, điện thoại của tôi sao đột nhiên tắt ngóm màn hình rồi?', difficulty_level: 'basic' },
      { chinese: '平时他每天都起得很早，今天到现在还没出门，真有点儿奇怪。', pinyin: 'Píngshí tā měitiān dōu qǐ de hěn zǎo, jīntiān dào xiànzài hái méi chūmén, zhēn yǒudiǎnr qíguài.', meaning_vi: 'Bình thường ngày nào anh ấy cũng dậy rất sớm, hôm nay đến giờ vẫn chưa ra khỏi cửa, thật có chút kỳ lạ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '如果',
    pinyin: 'rúguǒ',
    word_type: 'Liên từ',
    meaning_vi: 'nếu như, nếu',
    examples: [
      { chinese: '如果明天不下雨，我们就去郊外爬山。', pinyin: 'Rúguǒ míngtiān bú xiàyǔ, wǒmen jiù qù jiāowài pá shān.', meaning_vi: 'Nếu ngày mai trời không mưa thì chúng mình sẽ đi ngoại ô leo núi.', difficulty_level: 'basic' },
      { chinese: '如果你在学习汉语的过程中遇到任何困难，欢迎随时来找我探讨。', pinyin: 'Rúguǒ nǐ zài xuéxí Hànyǔ de guòchéng zhōng yù dào rènhé kùnnan, huānyíng suíshí lái zhǎo wǒ tàntǎo.', meaning_vi: 'Nếu bạn gặp bất kỳ khó khăn nào trong quá trình học tiếng Trung, hoan nghênh bạn bất cứ lúc nào đến tìm tôi trao đổi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '季节',
    pinyin: 'jìjié',
    word_type: 'Danh từ',
    meaning_vi: 'mùa, mùa màng',
    examples: [
      { chinese: '一年之中你最喜欢哪一个季节？', pinyin: 'Yì nián zhī zhōng nǐ zuì xǐhuan nǎ yí gè jìjié.', meaning_vi: 'Trong một năm bạn thích nhất mùa nào?', difficulty_level: 'basic' },
      { chinese: '秋天不仅是果实累累的收获季节，更是气候宜人的美好时节。', pinyin: 'Qiūtiān bùjǐn shì guǒshí lěilěi de shōuhuò jìjié, gèng shì qìhòu yírén de měihǎo shíjié.', meaning_vi: 'Mùa thu không chỉ là mùa gặt hái trĩu quả mà còn là thời khắc tuyệt đẹp với khí hậu dễ chịu.', difficulty_level: 'applied' }
    ]
  }
]
