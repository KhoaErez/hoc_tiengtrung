// ====================================================================
// DANH MỤC 126 TỪ VỰNG CÒN THIẾU CỦA HSK 2 (ĐỀ CƯƠNG HSK 3.0 CHÍNH THỨC - CTI 11/2025)
// Mục 301 – 500 (200 từ vựng mới cấp 2, tích lũy 500 từ vựng toàn diện)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao kèm Pinyin + Dịch tiếng Việt
// ====================================================================

export interface Hsk2WordItem {
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

export const HSK2_MISSING_126_WORDS: Hsk2WordItem[] = [
  // --- NHÓM A - B ---
  {
    hanzi: '啊',
    pinyin: 'a',
    word_type: 'Trợ từ',
    meaning_vi: 'à, nhé, ư, đấy (trợ từ ngữ khí cuối câu)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '今天天气真好啊！', pinyin: 'Jīntiān tiānqì zhēn hǎo a!', meaning_vi: 'Hôm nay thời tiết thật là đẹp quá đi!', difficulty_level: 'basic' },
      { chinese: '你走慢点儿啊，小心路滑。', pinyin: 'Nǐ zǒu màn diǎnr a, xiǎoxīn lù huá.', meaning_vi: 'Bạn đi chậm một chút nhé, cẩn thận đường trơn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '爱好',
    pinyin: 'àihào',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'sở thích; yêu thích',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我的爱好是听音乐。', pinyin: 'Wǒ de àihào shì tīng yīnyuè.', meaning_vi: 'Sở thích của tôi là nghe nhạc.', difficulty_level: 'basic' },
      { chinese: '他从小就爱好画画和下棋。', pinyin: 'Tā cóngxiǎo jiù àihào huàhuà hé xiàqí.', meaning_vi: 'Anh ấy từ nhỏ đã yêu thích vẽ tranh và đánh cờ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '白色',
    pinyin: 'báisè',
    word_type: 'Danh từ',
    meaning_vi: 'màu trắng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我喜欢白色的衬衫。', pinyin: 'Wǒ xǐhuan báisè de chènshān.', meaning_vi: 'Tôi thích chiếc áo sơ mi màu trắng.', difficulty_level: 'basic' },
      { chinese: '冬天的大山到处都是白色的雪。', pinyin: 'Dōngtiān de dàshān dàochù dōu shì báisè de xuě.', meaning_vi: 'Mùa đông khắp núi non đều bao phủ tuyết trắng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '笔',
    pinyin: 'bǐ',
    word_type: 'Danh từ',
    meaning_vi: 'bút, cây bút',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '借我一支笔好吗？', pinyin: 'Jiè wǒ yì zhī bǐ hǎo ma?', meaning_vi: 'Cho tôi mượn một cây bút được không?', difficulty_level: 'basic' },
      { chinese: '桌子上放着几支不同颜色的笔。', pinyin: 'Zhuōzi shang fàngzhe jǐ zhī bùtóng yánsè de bǐ.', meaning_vi: 'Trên bàn có để mấy cây bút màu khác nhau.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不错',
    pinyin: 'búcuò',
    word_type: 'Tính từ',
    meaning_vi: 'không tồi, rất tốt, đúng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这道菜的味道真不错。', pinyin: 'Zhè dào cài de wèidao zhēn búcuò.', meaning_vi: 'Mùi vị món ăn này thực sự rất ngon.', difficulty_level: 'basic' },
      { chinese: '他的中文水平很不错，交流完全没问题。', pinyin: 'Tā de Zhōngwén shuǐpíng hěn búcuò, jiāoliú wánquán méi wèntí.', meaning_vi: 'Trình độ tiếng Trung của anh ấy rất tốt, giao tiếp hoàn toàn không có trở ngại.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不好意思',
    pinyin: 'bùhǎoyìsi',
    word_type: 'Cụm từ / Thán từ',
    meaning_vi: 'ngại ngùng, áy náy, xin lỗi',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '不好意思，打扰您了。', pinyin: 'Bùhǎoyìsi, dǎrǎo nín le.', meaning_vi: 'Thật ngại quá, đã làm phiền ngài rồi.', difficulty_level: 'basic' },
      { chinese: '让你在外面等这么久，真不好意思。', pinyin: 'Ràng nǐ zài wàimiàn děng zhème jiǔ, zhēn bùhǎoyìsi.', meaning_vi: 'Để bạn phải đợi ở ngoài lâu như vậy, thật là áy náy quá.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM C ---
  {
    hanzi: '长',
    pinyin: 'cháng',
    word_type: 'Tính từ',
    meaning_vi: 'dài, lâu',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这条路很长。', pinyin: 'Zhè tiáo lù hěn cháng.', meaning_vi: 'Con đường này rất dài.', difficulty_level: 'basic' },
      { chinese: '姐姐有一头乌黑漂亮的短发和一双大眼睛。', pinyin: 'Jiějie yǒu yì tóu wūhēi piàoliang de chángfà hé yì shuāng dà yǎnjing.', meaning_vi: 'Chị gái có mái tóc dài đen nhánh xinh đẹp và một đôi mắt to.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '车站',
    pinyin: 'chēzhàn',
    word_type: 'Danh từ',
    meaning_vi: 'bến xe, nhà ga',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我在车站等你。', pinyin: 'Wǒ zài chēzhàn děng nǐ.', meaning_vi: 'Tôi đang đợi bạn ở bến xe.', difficulty_level: 'basic' },
      { chinese: '从这里往东走五百米就是公共汽车站。', pinyin: 'Cóng zhèlǐ wǎng dōng zǒu wǔbǎi mǐ jiù shì gōnggòngqìchē zhàn.', meaning_vi: 'Từ đây đi về phía đông năm trăm mét là tới trạm xe buýt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出国',
    pinyin: 'chūguó',
    word_type: 'Động từ',
    meaning_vi: 'xuất ngoại, đi nước ngoài',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他下个月要出国留学。', pinyin: 'Tā xià ge yuè yào chūguó liúxué.', meaning_vi: 'Tháng sau anh ấy sẽ ra nước ngoài du học.', difficulty_level: 'basic' },
      { chinese: '出国旅游之前需要准备好护照和签证。', pinyin: 'Chūguó lǚyóu zhīqián xūyào zhǔnbèi hǎo hùzhào hé qiānzhèng.', meaning_vi: 'Trước khi đi du lịch nước ngoài cần chuẩn bị sẵn hộ chiếu và visa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出来',
    pinyin: 'chūlai',
    word_type: 'Động từ',
    meaning_vi: 'ra đây, đi ra, xuất hiện',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '太阳出来了。', pinyin: 'Tàiyáng chūlai le.', meaning_vi: 'Mặt trời đã mọc lên rồi.', difficulty_level: 'basic' },
      { chinese: '你快出来看看，外面下大雪了！', pinyin: 'Nǐ kuài chūlai kànkan, wàimiàn xià dàxuě le!', meaning_vi: 'Bạn mau ra đây xem này, bên ngoài tuyết rơi dày quá!', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出门',
    pinyin: 'chūmén',
    word_type: 'Động từ',
    meaning_vi: 'ra khỏi nhà, đi xa',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '爸爸早上七点出门上班。', pinyin: 'Bàba zǎoshang qī diǎn chūmén shàngbān.', meaning_vi: 'Bố bảy giờ sáng ra khỏi nhà đi làm.', difficulty_level: 'basic' },
      { chinese: '今天天气很冷，出门记得带把伞。', pinyin: 'Jīntiān tiānqì hěn lěng, chūmén jìde dài bǎ sǎn.', meaning_vi: 'Hôm nay trời rất lạnh, ra ngoài nhớ mang theo một chiếc ô.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出去',
    pinyin: 'chūqù',
    word_type: 'Động từ',
    meaning_vi: 'đi ra ngoài',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我们出去散散步吧。', pinyin: 'Wǒmen chūqù sànsanbù ba.', meaning_vi: 'Chúng mình cùng đi ra ngoài tản bộ nhé.', difficulty_level: 'basic' },
      { chinese: '房间里太热了，我想出去透透气。', pinyin: 'Fángjiān lǐ tài rè le, wǒ xiǎng chūqù tòutòuqì.', meaning_vi: 'Trong phòng ngột ngạt quá, tôi muốn đi ra ngoài hít thở không khí.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '床',
    pinyin: 'chuáng',
    word_type: 'Danh từ',
    meaning_vi: 'giường',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这张床非常舒服。', pinyin: 'Zhè zhāng chuáng fēicháng shūfu.', meaning_vi: 'Chiếc giường này rất êm và thoải mái.', difficulty_level: 'basic' },
      { chinese: '他生病了，整天都躺在床上休息。', pinyin: 'Tā shēngbìng le, zhěngtiān dōu tǎng zài chuáng shang xiūxi.', meaning_vi: 'Anh ấy bị ốm, cả ngày đều nằm trên giường nghỉ ngơi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '词',
    pinyin: 'cí',
    word_type: 'Danh từ',
    meaning_vi: 'từ, từ ngữ',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这个新词是什么意思？', pinyin: 'Zhè ge xīn cí shì shénme yìsi?', meaning_vi: 'Từ mới này có nghĩa là gì vậy?', difficulty_level: 'basic' },
      { chinese: '学汉语要多积累日常词汇和短语。', pinyin: 'Xué Hànyǔ yào duō jīlěi rìcháng cíhuì hé duǎnyǔ.', meaning_vi: 'Học tiếng Hán cần tích lũy nhiều từ vựng và cụm từ thường nhật.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '从小',
    pinyin: 'cóngxiǎo',
    word_type: 'Phó từ',
    meaning_vi: 'từ nhỏ, từ bé',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我从小就喜欢小动物。', pinyin: 'Wǒ cóngxiǎo jiù xǐhuan xiǎo dòngwù.', meaning_vi: 'Tôi từ nhỏ đã thích động vật nhỏ.', difficulty_level: 'basic' },
      { chinese: '他们俩从小就是同一个院子长大的好朋友。', pinyin: 'Tāmen liǎ cóngxiǎo jiù shì tóng yí ge yuànzi zhǎngdà de hǎo péngyou.', meaning_vi: 'Hai người họ từ nhỏ đã là bạn thân lớn lên cùng một khu tập thể.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM D ---
  {
    hanzi: '打',
    pinyin: 'dǎ',
    word_type: 'Động từ',
    meaning_vi: 'đánh, đập, chơi (bóng), gọi (điện thoại)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我晚上给你打电话。', pinyin: 'Wǒ wǎnshang gěi nǐ dǎ diànhuà.', meaning_vi: 'Tối nay tôi gọi điện thoại cho bạn nhé.', difficulty_level: 'basic' },
      { chinese: '周末大家经常一起去操场打羽毛球。', pinyin: 'Zhōumò dàjiā jīngcháng yìqǐ qù cāochǎng dǎ yǔmáoqiú.', meaning_vi: 'Cuối tuần mọi người thường cùng nhau ra sân chơi cầu lông.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打车',
    pinyin: 'dǎchē',
    word_type: 'Động từ',
    meaning_vi: 'bắt taxi, gọi xe',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '时间来不及了，我们打车吧。', pinyin: 'Shíjiān láibùjí le, wǒmen dǎchē ba.', meaning_vi: 'Không kịp giờ nữa rồi, chúng mình bắt taxi đi.', difficulty_level: 'basic' },
      { chinese: '在下雨天用手机打车可能需要等一会儿。', pinyin: 'Zài xiàyǔ tiān yòng shǒujī dǎchē kěnéng xūyào děng yíhuìr.', meaning_vi: 'Vào ngày trời mưa gọi xe qua điện thoại có thể cần đợi một lát.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打开',
    pinyin: 'dǎkāi',
    word_type: 'Động từ',
    meaning_vi: 'mở ra, bật (thiết bị)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请大家打开书，翻到第十页。', pinyin: 'Qǐng dàjiā dǎkāi shū, fān dào dì shí yè.', meaning_vi: 'Mời mọi người mở sách, lật đến trang 10.', difficulty_level: 'basic' },
      { chinese: '屋里太闷了，把窗户打开透透气吧。', pinyin: 'Wū lǐ tài mèn le, bǎ chuānghu dǎkāi tòutòuqì ba.', meaning_vi: 'Trong nhà bí quá, mở cửa sổ ra cho thoáng khí đi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '但',
    pinyin: 'dàn',
    word_type: 'Liên từ',
    meaning_vi: 'nhưng, nhưng mà',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '工作虽然累，但我很开心。', pinyin: 'Gōngzuò suīrán lèi, dàn wǒ hěn kāixīn.', meaning_vi: 'Công việc tuy mệt, nhưng tôi rất vui vẻ.', difficulty_level: 'basic' },
      { chinese: '这件衣服很好看，但价格稍微有点贵。', pinyin: 'Zhè jiàn yīfu hěn hǎokàn, dàn jiàgé shāowēi yǒudiǎnr guì.', meaning_vi: 'Bộ quần áo này rất đẹp, nhưng giá hơi đắt một chút.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '但是',
    pinyin: 'dànshì',
    word_type: 'Liên từ',
    meaning_vi: 'nhưng mà, thế nhưng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他很想去，但是没有时间。', pinyin: 'Tā hěn xiǎng qù, dànshì méiyǒu shíjiān.', meaning_vi: 'Anh ấy rất muốn đi, nhưng mà không có thời gian.', difficulty_level: 'basic' },
      { chinese: '虽然汉语很难学，但是大家都很认真。', pinyin: 'Suīrán Hànyǔ hěn nán xué, dànshì dàjiā dōu hěn rènzhēn.', meaning_vi: 'Tuy rằng tiếng Hán khó học, nhưng mà mọi người đều rất chăm chỉ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '地',
    pinyin: 'de',
    word_type: 'Trợ từ',
    meaning_vi: 'một cách (trợ từ trạng ngữ)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '小鸟高兴地唱着歌。', pinyin: 'Xiǎoniǎo gāoxìng de chàngzhe gē.', meaning_vi: 'Chú chim non vui vẻ hót ca.', difficulty_level: 'basic' },
      { chinese: '听到好消息，大家都开心地笑了起来。', pinyin: 'Tīng dào hǎo xiāoxi, dàjiā dōu kāixīn de xiào le qǐlai.', meaning_vi: 'Nghe được tin tốt, mọi người đều cười rạng rỡ một cách vui vẻ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '等',
    pinyin: 'děng',
    word_type: 'Động từ',
    meaning_vi: 'chờ, đợi',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请在这里等我五分钟。', pinyin: 'Qǐng zài zhèlǐ děng wǒ wǔ fēnzhōng.', meaning_vi: 'Xin hãy ở đây đợi tôi năm phút nhé.', difficulty_level: 'basic' },
      { chinese: '等雨停了，我们再一起出门去公园吧。', pinyin: 'Děng yǔ tíng le, wǒmen zài yìqǐ chūmén qù gōngyuán ba.', meaning_vi: 'Đợi trời tạnh mưa rồi chúng mình cùng ra công viên nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '地铁',
    pinyin: 'dìtiě',
    word_type: 'Danh từ',
    meaning_vi: 'tàu điện ngầm',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我每天坐地铁去公司。', pinyin: 'Wǒ měitiān zuò dìtiě qù gōngsī.', meaning_vi: 'Tôi mỗi ngày đều đi tàu điện ngầm đến công ty.', difficulty_level: 'basic' },
      { chinese: '坐地铁既准时又不会遇到堵车。', pinyin: 'Zuò dìtiě jì zhǔnshí yòu bú huì yù dào dǔchē.', meaning_vi: 'Đi tàu điện ngầm vừa đúng giờ lại không bao giờ gặp tắc đường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '点',
    pinyin: 'diǎn',
    word_type: 'Động từ',
    meaning_vi: 'gọi món, điểm món, chọn',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '服务员，我们要点菜。', pinyin: 'Fúwùyuán, wǒmen yào diǎncài.', meaning_vi: 'Phục vụ ơi, chúng tôi muốn gọi món.', difficulty_level: 'basic' },
      { chinese: '你喜欢吃辣的吗？今天你来点菜吧。', pinyin: 'Nǐ xǐhuan chī là de ma? Jīntiān nǐ lái diǎncài ba.', meaning_vi: 'Bạn thích ăn cay không? Hôm nay bạn gọi món nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '动',
    pinyin: 'dòng',
    word_type: 'Động từ',
    meaning_vi: 'cử động, chuyển động, chạm vào',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '别动，让我看看你的眼睛。', pinyin: 'Bié dòng, ràng wǒ kànkan nǐ de yǎnjing.', meaning_vi: 'Đừng cử động, để tôi xem mắt của bạn nào.', difficulty_level: 'basic' },
      { chinese: '爬完山之后，我累得连腿都动不了了。', pinyin: 'Pá wán shān zhīhòu, wǒ lèi de lián tuǐ dōu dòng bù liǎo le.', meaning_vi: 'Sau khi leo núi xong, tôi mệt đến mức chân cũng không nhấc nổi.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM F - G ---
  {
    hanzi: '饭馆',
    pinyin: 'fànguǎn',
    word_type: 'Danh từ',
    meaning_vi: 'quán ăn, nhà hàng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '学校旁边有一家好吃的饭馆。', pinyin: 'Xuéxiào pángbiān yǒu yì jiā hǎochī de fànguǎn.', meaning_vi: 'Bên cạnh trường học có một quán ăn rất ngon.', difficulty_level: 'basic' },
      { chinese: '今天晚上我们去那家中餐馆聚餐吧。', pinyin: 'Jīntiān wǎnshang wǒmen qù nà jiā Zhōngcān guǎn jùcān ba.', meaning_vi: 'Tối nay chúng mình đến quán đồ Trung đó liên hoan nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '飞',
    pinyin: 'fēi',
    word_type: 'Động từ',
    meaning_vi: 'bay',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '天空中有很多小鸟在飞。', pinyin: 'Tiānkōng zhōng yǒu hěn duō xiǎoniǎo zài fēi.', meaning_vi: 'Trên bầu trời có rất nhiều chú chim đang bay lượn.', difficulty_level: 'basic' },
      { chinese: '明天上午十点我们将飞往上海参加会议。', pinyin: 'Míngtiān shàngwǔ shí diǎn wǒmen jiāng fēi wǎng Shànghǎi cānjiā huìyì.', meaning_vi: 'Mười giờ sáng mai chúng tôi sẽ bay tới Thượng Hải tham gia hội nghị.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '高中',
    pinyin: 'gāozhōng',
    word_type: 'Danh từ',
    meaning_vi: 'trường trung học phổ thông, cấp 3',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他是一名高中学生。', pinyin: 'Tā shì yì míng gāozhōng xuésheng.', meaning_vi: 'Em ấy là một học sinh cấp ba.', difficulty_level: 'basic' },
      { chinese: '高中毕业后，很多同学都考上了理想的大学。', pinyin: 'Gāozhōng bìyè hòu, hěn duō tóngxué dōu kǎoshàng le lǐxiǎng de dàxué.', meaning_vi: 'Sau khi tốt nghiệp cấp 3, nhiều bạn cùng lớp đã thi đỗ trường đại học mơ ước.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '个子',
    pinyin: 'gèzi',
    word_type: 'Danh từ',
    meaning_vi: 'dáng vóc, chiều cao',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他的个子比我高一点儿。', pinyin: 'Tā de gèzi bǐ wǒ gāo yìdiǎnr.', meaning_vi: 'Chiều cao của anh ấy cao hơn tôi một chút.', difficulty_level: 'basic' },
      { chinese: '弟弟虽然年纪还小，但是个子长得很快。', pinyin: 'Dìdi suīrán niánjì hái xiǎo, dànshì gèzi zhǎng de hěn kuài.', meaning_vi: 'Em trai tuy tuổi còn nhỏ nhưng vóc dáng lớn rất nhanh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '跟',
    pinyin: 'gēn',
    word_type: 'Giới từ / Liên từ',
    meaning_vi: 'cùng, với, theo',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我想跟你一起去图书馆。', pinyin: 'Wǒ xiǎng gēn nǐ yìqǐ qù túshūguǎn.', meaning_vi: 'Tôi muốn cùng với bạn đến thư viện.', difficulty_level: 'basic' },
      { chinese: '请大家跟着老师大声读课文。', pinyin: 'Qǐng dàjiā gēnzhe lǎoshī dàshēng dú kèwén.', meaning_vi: 'Xin mời mọi người đọc to bài học theo giáo viên.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '公交车',
    pinyin: 'gōngjiāochē',
    word_type: 'Danh từ',
    meaning_vi: 'xe buýt công cộng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '坐公交车很便宜。', pinyin: 'Zuò gōngjiāochē hěn piányi.', meaning_vi: 'Đi xe buýt rất rẻ.', difficulty_level: 'basic' },
      { chinese: '每天早高峰公交车上的人都非常多。', pinyin: 'Měitiān zǎogāofēng gōngjiāochē shang de rén dōu fēicháng duō.', meaning_vi: 'Mỗi buổi sáng giờ cao điểm người trên xe buýt đều rất đông.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '过',
    pinyin: 'guò',
    word_type: 'Động từ',
    meaning_vi: 'qua, đón (sinh nhật, tết), trải qua',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '今天我过生日，大家一起来庆祝吧。', pinyin: 'Jīntiān wǒ guò shēngrì, dàjiā yìqǐ lái qìngzhù ba.', meaning_vi: 'Hôm nay tôi đón sinh nhật, mọi người cùng đến chúc mừng nhé.', difficulty_level: 'basic' },
      { chinese: '过马路的时候一定要看红绿灯。', pinyin: 'Guò mǎlù de shíhou yídìng yào kàn hónglǜdēng.', meaning_vi: 'Lúc băng qua đường nhất định phải chú ý đèn giao thông.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '过来',
    pinyin: 'guòlai',
    word_type: 'Động từ',
    meaning_vi: 'qua đây, lại đây',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请你过来一下好吗？', pinyin: 'Qǐng nǐ guòlai yíxià hǎo ma?', meaning_vi: 'Xin mời bạn qua đây một lát được không?', difficulty_level: 'basic' },
      { chinese: '看到小狗跑过来，孩子们高兴地鼓掌。', pinyin: 'Kàndào xiǎogǒu pǎo guòlai, háizimen gāoxìng de gǔzhǎng.', meaning_vi: 'Trông thấy cún con chạy lại đây, các em nhỏ vui mừng vỗ tay.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '过年',
    pinyin: 'guònián',
    word_type: 'Động từ',
    meaning_vi: 'ăn tết, đón năm mới',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '过年好！祝大家身体健康！', pinyin: 'Guònián hǎo! Zhù dàjiā shēntǐ jiànkāng!', meaning_vi: 'Chúc mừng năm mới! Chúc mọi người dồi dào sức khỏe!', difficulty_level: 'basic' },
      { chinese: '快要过年了，漂泊在外的人都要回家团圆。', pinyin: 'Kuàiyào guònián le, piāobó zài wài de rén dōu yào huíjiā tuányuán.', meaning_vi: 'Sắp tết rồi, những người con xa xứ đều trở về nhà sum họp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '过去',
    pinyin: 'guòqù',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'đi qua đó; quá khứ, trước kia',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '绿灯亮了，我们可以走过去了。', pinyin: 'Lǜdēng liàng le, wǒmen kěyǐ zǒu guòqù le.', meaning_vi: 'Đèn xanh sáng rồi, chúng mình có thể đi qua đường rồi.', difficulty_level: 'basic' },
      { chinese: '忘掉过去的不愉快，开始美好的新生活吧。', pinyin: 'Wàngdiào guòqù de bù yúkuài, kāishǐ měihǎo de xīn shēnghuó ba.', meaning_vi: 'Hãy quên đi những muộn phiền trong quá khứ và bắt đầu cuộc sống mới tốt đẹp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '过',
    pinyin: 'guo',
    word_type: 'Trợ từ',
    meaning_vi: 'từng, đã từng (trợ từ động thái biểu thị kinh nghiệm)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '你去过中国吗？', pinyin: 'Nǐ qù guo Zhōngguó ma?', meaning_vi: 'Bạn đã từng đi Trung Quốc chưa?', difficulty_level: 'basic' },
      { chinese: '这本小说我以前读过，情节非常有意思。', pinyin: 'Zhè běn xiǎoshuō wǒ yǐqián dú guo, qíngjié fēicháng yǒu yìsi.', meaning_vi: 'Cuốn tiểu thuyết này trước đây tôi từng đọc rồi, tình tiết rất thú vị.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM H ---
  {
    hanzi: '还是',
    pinyin: 'háishì',
    word_type: 'Phó từ / Liên từ',
    meaning_vi: 'hay là, vẫn là, hoặc là',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '你想喝咖啡还是喝茶？', pinyin: 'Nǐ xiǎng hē kāfēi háishì hē chá?', meaning_vi: 'Bạn muốn uống cà phê hay là uống trà?', difficulty_level: 'basic' },
      { chinese: '虽然天气不太好，我们还是按时出发了。', pinyin: 'Suīrán tiānqì bú tài hǎo, wǒmen háishì ànshí chūfā le.', meaning_vi: 'Tuy rằng thời tiết không được tốt, chúng tôi vẫn xuất phát đúng giờ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '黑色',
    pinyin: 'hēisè',
    word_type: 'Danh từ',
    meaning_vi: 'màu đen',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他今天穿了一双黑色的鞋子。', pinyin: 'Tā jīntiān chuān le yì shuāng hēisè de xiézi.', meaning_vi: 'Hôm nay anh ấy đi một đôi giày màu đen.', difficulty_level: 'basic' },
      { chinese: '这辆黑色的轿车开得很平稳。', pinyin: 'Zhè liàng hēisè de jiàochē kāi de hěn píngwěn.', meaning_vi: 'Chiếc xe hơi màu đen này chạy rất êm ái.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '红茶',
    pinyin: 'hóngchá',
    word_type: 'Danh từ',
    meaning_vi: 'trà đen, hồng trà',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我想喝一杯热红茶。', pinyin: 'Wǒ xiǎng hē yì bēi rè hóngchá.', meaning_vi: 'Tôi muốn uống một tách hồng trà nóng.', difficulty_level: 'basic' },
      { chinese: '午后喝点红茶吃些点心非常惬意。', pinyin: 'Wǔhòu hē diǎnr hóngchá chī xiē diǎnxin fēicháng qièyì.', meaning_vi: 'Buổi chiều uống chút hồng trà ăn chút điểm tâm thật là dễ chịu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '红色',
    pinyin: 'hóngsè',
    word_type: 'Danh từ',
    meaning_vi: 'màu đỏ',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '妹妹选了一条红色的裙子。', pinyin: 'Mèimei xuǎn le yì tiáo hóngsè de qúnzi.', meaning_vi: 'Em gái đã chọn một chiếc váy màu đỏ.', difficulty_level: 'basic' },
      { chinese: '在中国文化中，红色代表着喜庆和吉祥。', pinyin: 'Zài Zhōngguó wénhuà zhōng, hóngsè dàibiǎo zhe xǐqìng hé jíxiáng.', meaning_vi: 'Trong văn hóa Trung Hoa, màu đỏ tượng trưng cho hỷ sự và cát tường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '花',
    pinyin: 'huā',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'hoa, bông hoa; tiêu (tiền), tốn (thời gian)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '公园里开满了五颜六色的花。', pinyin: 'Gōngyuán lǐ kāi mǎn le wǔyánliùsè de huā.', meaning_vi: 'Trong công viên nở đầy những bông hoa muôn màu muôn vẻ.', difficulty_level: 'basic' },
      { chinese: '买这台电脑花了我一个月的工资。', pinyin: 'Mǎi zhè tái diànnǎo huā le wǒ yí ge yuè de gōngzī.', meaning_vi: 'Mua chiếc máy tính này tốn mất một tháng tiền lương của tôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '画',
    pinyin: 'huà',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'vẽ; bức tranh, họa phẩm',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他在纸上画了一只可爱的小猫。', pinyin: 'Tā zài zhǐ shang huà le yì zhī kě&#x27;ài de xiǎomāo.', meaning_vi: 'Em ấy vẽ một chú mèo nhỏ đáng yêu trên trang giấy.', difficulty_level: 'basic' },
      { chinese: '墙上挂着一幅中国山水画。', pinyin: 'Qiáng shang guà zhe yì fú Zhōngguó shānshuǐhuà.', meaning_vi: 'Trên tường có treo một bức tranh sơn thủy Trung Quốc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '坏',
    pinyin: 'huài',
    word_type: 'Tính từ',
    meaning_vi: 'hỏng, xấu, tệ',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我的手机坏了，需要去修。', pinyin: 'Wǒ de shǒujī huài le, xūyào qù xiū.', meaning_vi: 'Điện thoại của tôi bị hỏng rồi, cần phải đi sửa.', difficulty_level: 'basic' },
      { chinese: '牛奶放太久变坏了，千万不能喝。', pinyin: 'Niúnǎi fàng tài jiǔ biàn huài le, qiānwàn bù néng hē.', meaning_vi: 'Sữa để quá lâu bị hỏng rồi, tuyệt đối không được uống.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '回来',
    pinyin: 'huílai',
    word_type: 'Động từ',
    meaning_vi: 'trở về, về đây',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '爸爸什么时候回来？', pinyin: 'Bàba shénme shíhou huílai?', meaning_vi: 'Khi nào thì bố trở về vậy?', difficulty_level: 'basic' },
      { chinese: '他出差一个月，今天下午终于回到家了。', pinyin: 'Tā chūchāi yí ge yuè, jīntiān xiàwǔ zhōngyú huí dào jiā le.', meaning_vi: 'Anh ấy đi công tác một tháng, chiều nay cuối cùng đã trở về đến nhà.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '回去',
    pinyin: 'huíqù',
    word_type: 'Động từ',
    meaning_vi: 'trở về, về đó',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '时间不早了，我们快回去吧。', pinyin: 'Shíjiān bù zǎo le, wǒmen kuài huíqù ba.', meaning_vi: 'Thời gian không còn sớm nữa rồi, chúng mình mau về thôi.', difficulty_level: 'basic' },
      { chinese: '天快黑了，你一个人回去路上要多加小心。', pinyin: 'Tiān kuài hēi le, nǐ yí ge rén huíqù lù shang yào duōjiā xiǎoxīn.', meaning_vi: 'Trời sắp tối rồi, bạn một mình về đường nhớ cẩn thận nhiều nhé.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM J - K - L ---
  {
    hanzi: '机票',
    pinyin: 'jīpiào',
    word_type: 'Danh từ',
    meaning_vi: 'vé máy bay',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我已经订好下周去北京的机票了。', pinyin: 'Wǒ yǐjīng dìng hǎo xià zhōu qù Běijīng de jīpiào le.', meaning_vi: 'Tôi đã đặt xong vé máy bay đi Bắc Kinh vào tuần tới rồi.', difficulty_level: 'basic' },
      { chinese: '提前一个月买机票通常会便宜很多。', pinyin: 'Tíqián yí ge yuè mǎi jīpiào tōngcháng huì piányi hěn duō.', meaning_vi: 'Mua vé máy bay trước một tháng thông thường sẽ rẻ hơn rất nhiều.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '记得',
    pinyin: 'jìde',
    word_type: 'Động từ',
    meaning_vi: 'nhớ, còn nhớ',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '你还记得他的电话号码吗？', pinyin: 'Nǐ hái jìde tā de diànhuà hàomǎ ma?', meaning_vi: 'Bạn còn nhớ số điện thoại của anh ấy không?', difficulty_level: 'basic' },
      { chinese: '虽然过去了很多年，我依然记得老师讲过的话。', pinyin: 'Suīrán guòqù le hěn duō nián, wǒ yīrán jìde lǎoshī jiǎng guo de huà.', meaning_vi: 'Tuy rằng nhiều năm đã trôi qua, tôi vẫn nhớ như in lời thầy cô đã dạy.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '间',
    pinyin: 'jiān',
    word_type: 'Lượng từ',
    meaning_vi: 'gian, căn (lượng từ cho phòng)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我家有三间卧室。', pinyin: 'Wǒ jiā yǒu sān jiān wòshì.', meaning_vi: 'Nhà tôi có ba căn phòng ngủ.', difficulty_level: 'basic' },
      { chinese: '学校新建了一间宽敞明亮的计算机教室。', pinyin: 'Xuéxiào xīn jiàn le yì jiān kuānchang míngliàng de jìsuànjī jiàoshì.', meaning_vi: 'Trường học vừa xây mới một phòng học tin học rộng rãi và sáng sủa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '教',
    pinyin: 'jiāo',
    word_type: 'Động từ',
    meaning_vi: 'dạy, giảng dạy',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '王老师教我们中文。', pinyin: 'Wáng lǎoshī jiāo wǒmen Zhōngwén.', meaning_vi: 'Thầy Vương dạy chúng tôi tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '你能教我怎么用这个电脑软件吗？', pinyin: 'Nǐ néng jiāo wǒ zěnme yòng zhè ge diànnǎo ruǎnjiàn ma?', meaning_vi: 'Bạn có thể chỉ cho tôi cách dùng phần mềm máy tính này không?', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '进来',
    pinyin: 'jìnlai',
    word_type: 'Động từ',
    meaning_vi: 'vào đây, bước vào',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请进，外面冷，快进来坐。', pinyin: 'Qǐng jìn, wàimiàn lěng, kuài jìnlai zuò.', meaning_vi: 'Mời vào, bên ngoài lạnh lắm, mau vào trong ngồi đi.', difficulty_level: 'basic' },
      { chinese: '他敲了敲门，然后推开门轻轻地走了进来。', pinyin: 'Tā qiāo le qiāo mén, ránhòu tuīkāi mén qīngqīng de zǒu le jìnlai.', meaning_vi: 'Anh ấy gõ gõ cửa, rồi đẩy cửa nhẹ nhàng bước vào.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '进去',
    pinyin: 'jìnqù',
    word_type: 'Động từ',
    meaning_vi: 'đi vào trong, bước vào đó',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '电影快开始了，我们快进去吧。', pinyin: 'Diànyǐng kuài kāishǐ le, wǒmen kuài jìnqù ba.', meaning_vi: 'Phim sắp chiếu rồi, chúng mình mau vào trong rạp thôi.', difficulty_level: 'basic' },
      { chinese: '图书馆里面很安静，请大家进去后不要大声说话。', pinyin: 'Túshūguǎn lǐmiàn hěn ānjìng, qǐng dàjiā jìnqù hòu búyào dàshēng shuōhuà.', meaning_vi: 'Bên trong thư viện rất yên tĩnh, xin mọi người sau khi vào chớ nói lớn tiếng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '经常',
    pinyin: 'jīngcháng',
    word_type: 'Phó từ',
    meaning_vi: 'thường xuyên, thường hay',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我周末经常去图书馆看书。', pinyin: 'Wǒ zhōumò jīngcháng qù túshūguǎn kànshū.', meaning_vi: 'Cuối tuần tôi thường hay đến thư viện đọc sách.', difficulty_level: 'basic' },
      { chinese: '经常锻炼身体有助于增强体质和预防疾病。', pinyin: 'Jīngcháng duànliàn shēntǐ yǒu zhù yú zēngqiáng tǐzhì hé yùfáng jíbìng.', meaning_vi: 'Thường xuyên rèn luyện thân thể giúp nâng cao thể chất và phòng ngừa bệnh tật.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '酒店',
    pinyin: 'jiǔdiàn',
    word_type: 'Danh từ',
    meaning_vi: 'khách sạn',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这家酒店的环境很好。', pinyin: 'Zhè jiā jiǔdiàn de huánjìng hěn hǎo.', meaning_vi: 'Môi trường cảnh quan của khách sạn này rất tốt.', difficulty_level: 'basic' },
      { chinese: '我们在网上预订了一家靠近海滩的度假酒店。', pinyin: 'Wǒmen zài wǎngshang yùdìng le yì jiā kàojìn hǎitān de dùjià jiǔdiàn.', meaning_vi: 'Chúng tôi đã đặt phòng trên mạng ở một khách sạn nghỉ dưỡng gần bãi biển.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '开学',
    pinyin: 'kāixué',
    word_type: 'Động từ',
    meaning_vi: 'khai giảng, tựu trường',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '下个星期一我们就要开学了。', pinyin: 'Xià ge xīngqīyī wǒmen jiù yào kāixué le.', meaning_vi: 'Thứ hai tuần tới chúng mình sẽ tựu trường rồi.', difficulty_level: 'basic' },
      { chinese: '开学第一天，同学们兴奋地聚在一起分享假期趣事。', pinyin: 'Kāixué dì-yī tiān, tóngxuémen xīngfèn de jù zài yìqǐ fēnxiǎng jiàqī qùshì.', meaning_vi: 'Ngày đầu khai giảng, các bạn học hào hứng tụ tập chia sẻ những chuyện vui trong kỳ nghỉ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '考',
    pinyin: 'kǎo',
    word_type: 'Động từ',
    meaning_vi: 'thi, kiểm tra',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '明天我们要考汉语听力。', pinyin: 'Míngtiān wǒmen yào kǎo Hànyǔ tīnglì.', meaning_vi: 'Ngày mai chúng mình sẽ thi nghe tiếng Hán.', difficulty_level: 'basic' },
      { chinese: '只要平时认真复习，考试就一定能考出好成绩。', pinyin: 'Zhǐyào píngshí rènzhēn fùxí, kǎoshì jiù yídìng néng kǎo chū hǎo chéngjì.', meaning_vi: 'Chỉ cần bình thường chăm chỉ ôn tập, khi đi thi nhất định sẽ đạt kết quả tốt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '裤子',
    pinyin: 'kùzi',
    word_type: 'Danh từ',
    meaning_vi: 'quần, chiếc quần',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这条裤子太长了。', pinyin: 'Zhè tiáo kùzi tài cháng le.', meaning_vi: 'Chiếc quần này dài quá rồi.', difficulty_level: 'basic' },
      { chinese: '他穿了一条深蓝色的牛仔裤，显得很精神。', pinyin: 'Tā chuān le yì tiáo shēnlánsè de niúzǎikù, xiǎnde hěn jīngshen.', meaning_vi: 'Anh ấy mặc một chiếc quần bò màu xanh đậm, trông rất khỏe khoắn và năng động.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '快要',
    pinyin: 'kuàiyào',
    word_type: 'Phó từ',
    meaning_vi: 'sắp, sắp sửa',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '天阴了，快要下雨了。', pinyin: 'Tiān yīn le, kuàiyào xiàyǔ le.', meaning_vi: 'Trời râm mát rồi, sắp sửa mưa to rồi đấy.', difficulty_level: 'basic' },
      { chinese: '火车快要进站了，请大家拿好行李准备下车。', pinyin: 'Huǒchē kuàiyào jìn zhàn le, qǐng dàjiā ná hǎo xíngli zhǔnbèi xiàchē.', meaning_vi: 'Tàu hỏa sắp vào ga rồi, xin quý khách mang theo hành lý chuẩn bị xuống xe.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '篮球',
    pinyin: 'lánqiú',
    word_type: 'Danh từ',
    meaning_vi: 'bóng rổ',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '下课后我们去打篮球吧。', pinyin: 'Xiàkè hòu wǒmen qù dǎ lánqiú ba.', meaning_vi: 'Sau khi tan học chúng mình đi chơi bóng rổ nhé.', difficulty_level: 'basic' },
      { chinese: '学校的篮球比赛吸引了许多师生前来观看。', pinyin: 'Xuéxiào de lánqiú bǐsài xīyǐn le xǔduō shīshēng qiánlái guānkàn.', meaning_vi: 'Trận thi đấu bóng rổ của trường thu hút đông đảo thầy cô và học sinh tới xem.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '里面',
    pinyin: 'lǐmiàn',
    word_type: 'Danh từ',
    meaning_vi: 'bên trong, phía trong',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '书包里面有很多书。', pinyin: 'Shūbāo lǐmiàn yǒu hěn duō shū.', meaning_vi: 'Bên trong cặp sách có rất nhiều cuốn sách.', difficulty_level: 'basic' },
      { chinese: '屋子里面开着暖气，一点儿也不觉得冷。', pinyin: 'Wūzi lǐmiàn kāi zhe nuǎnqì, yìdiǎnr yě bù juéde lěng.', meaning_vi: 'Bên trong căn phòng có bật máy sưởi, chẳng thấy lạnh chút nào.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '楼',
    pinyin: 'lóu',
    word_type: 'Danh từ',
    meaning_vi: 'tòa nhà, lầu, tầng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我们家住在五楼。', pinyin: 'Wǒmen jiā zhù zài wǔ lóu.', meaning_vi: 'Nhà của chúng tôi ở trên tầng năm.', difficulty_level: 'basic' },
      { chinese: '穿过教学楼就是宽阔的操场和体育馆。', pinyin: 'Chuānguò jiàoxuélóu jiù shì kuānkuò de cāochǎng hé tǐyùguǎn.', meaning_vi: 'Đi xuyên qua tòa nhà giảng đường là đến sân vận động và nhà thi đấu rộng lớn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '路上',
    pinyin: 'lùshang',
    word_type: 'Danh từ',
    meaning_vi: 'trên đường, dọc đường',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '上班路上车很多。', pinyin: 'Shàngbān lùshang chē hěn duō.', meaning_vi: 'Trên đường đi làm xe cộ rất đông đúc.', difficulty_level: 'basic' },
      { chinese: '下雨天路滑，开车在路上一定要注意安全。', pinyin: 'Xiàyǔ tiān lù huá, kāichē zài lù shang yídìng yào zhùyì ānquán.', meaning_vi: 'Ngày mưa đường trơn, lái xe lưu thông trên đường nhất định phải chú ý an toàn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '绿茶',
    pinyin: 'lǜchá',
    word_type: 'Danh từ',
    meaning_vi: 'trà xanh',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '爷爷每天早上都喜欢泡一杯绿茶。', pinyin: 'Yéye měitiān zǎoshang dōu xǐhuan pào yì bēi lǜchá.', meaning_vi: 'Ông nội mỗi buổi sáng đều thích pha một tách trà xanh.', difficulty_level: 'basic' },
      { chinese: '中国龙井绿茶闻起来有一股清新的香味。', pinyin: 'Zhōngguó Lóngjǐng lǜchá wén qǐlai yǒu yì gǔ qīngxīn de xiāngwèi.', meaning_vi: 'Trà xanh Long Tỉnh Trung Quốc ngửi thấy có một hương thơm dịu mát thanh khiết.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '绿色',
    pinyin: 'lǜsè',
    word_type: 'Danh từ',
    meaning_vi: 'màu xanh lá cây',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '春天的树叶都是嫩绿色的。', pinyin: 'Chūntiān de shùyè dōu shì nènlǜsè de.', meaning_vi: 'Lá cây mùa xuân đều mang sắc xanh non mơn mởn.', difficulty_level: 'basic' },
      { chinese: '多看绿色的植物对缓解眼睛疲劳很有帮助。', pinyin: 'Duō kàn lǜsè de zhíwù duì huǎnjiě yǎnjing píláo hěn yǒu bāngzhù.', meaning_vi: 'Nhìn nhiều cây xanh thực vật rất có ích cho việc giảm bớt mỏi mắt.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM M - N ---
  {
    hanzi: '没意思',
    pinyin: 'méiyìsi',
    word_type: 'Tính từ',
    meaning_vi: 'vô vị, tẻ nhạt, không có ý nghĩa',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这部电影太长了，真没意思。', pinyin: 'Zhè bù diànyǐng tài cháng le, zhēn méiyìsi.', meaning_vi: 'Bộ phim này dài quá, thực sự rất tẻ nhạt.', difficulty_level: 'basic' },
      { chinese: '周末整天呆在家里打游戏挺没意思的，出去走走吧。', pinyin: 'Zhōumò zhěngtiān dāi zài jiā lǐ dǎ yóuxì tǐng méiyìsi de, chūqù zǒuzou ba.', meaning_vi: 'Cuối tuần cả ngày ru rú ở nhà chơi game rất vô vị, hãy ra ngoài dạo chơi đi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '门口',
    pinyin: 'ménkǒu',
    word_type: 'Danh từ',
    meaning_vi: 'cổng, cửa ra vào',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我们在学校门口见面吧。', pinyin: 'Wǒmen zài xuéxiào ménkǒu jiànmiàn ba.', meaning_vi: 'Chúng mình gặp nhau ở ngay cổng trường học nhé.', difficulty_level: 'basic' },
      { chinese: '超市门口停放着很多共享单车和电动车。', pinyin: 'Chāoshì ménkǒu tíngfàng zhe hěn duō gòngxiǎng dānchē hé diàndòngchē.', meaning_vi: 'Trước cửa siêu thị có đỗ rất nhiều xe đạp công cộng và xe máy điện.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '门票',
    pinyin: 'ménpiào',
    word_type: 'Danh từ',
    meaning_vi: 'vé vào cửa, vé vào cổng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这个公园不需要买门票。', pinyin: 'Zhè ge gōngyuán bù xūyào mǎi ménpiào.', meaning_vi: 'Công viên này không cần mua vé vào cổng.', difficulty_level: 'basic' },
      { chinese: '故宫博物院的门票可以在手机上提前预约购买。', pinyin: 'Gùgōng Bówùyuàn de ménpiào kěyǐ zài shǒujī shang tíqián yùyuē gòumǎi.', meaning_vi: 'Vé tham quan Cố Cung có thể đặt trước trực tiếp trên điện thoại di động.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '面',
    pinyin: 'miàn',
    word_type: 'Hậu tố / Danh từ',
    meaning_vi: 'phía, bên, mặt (hậu tố phương vị)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '前面有很多人在排队。', pinyin: 'Qiánmiàn yǒu hěn duō rén zài páiduì.', meaning_vi: 'Phía trước có rất nhiều người đang đứng xếp hàng.', difficulty_level: 'basic' },
      { chinese: '大楼的东面是一个漂亮的人工湖。', pinyin: 'Dàlóu de dōngmiàn shì yí ge piàoliang de réngōnghú.', meaning_vi: 'Phía đông của tòa cao ốc là một hồ nước nhân tạo rất đẹp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '名',
    pinyin: 'míng',
    word_type: 'Lượng từ / Danh từ',
    meaning_vi: 'người, vị (lượng từ); tên, danh',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我们班有一名新同学。', pinyin: 'Wǒmen bān yǒu yì míng xīn tóngxué.', meaning_vi: 'Lớp chúng tôi có một bạn học sinh mới.', difficulty_level: 'basic' },
      { chinese: '他在这次中文演讲比赛中荣获了第一名。', pinyin: 'Tā zài zhè cì Zhōngwén yǎnjiǎng bǐsài zhōng rónghuò le dì-yī míng.', meaning_vi: 'Anh ấy đã vinh dự giành giải nhất trong cuộc thi hùng biện tiếng Trung lần này.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '拿',
    pinyin: 'ná',
    word_type: 'Động từ',
    meaning_vi: 'cầm, lấy, mang',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请帮我拿一下这本书。', pinyin: 'Qǐng bāng wǒ ná yíxià zhè běn shū.', meaning_vi: 'Xin hãy giúp tôi cầm hộ cuốn sách này một lát.', difficulty_level: 'basic' },
      { chinese: '出门的时候别忘了拿钥匙和钱包。', pinyin: 'Chūmén de shíhou bié wàng le ná yàoshi hé qiánbāo.', meaning_vi: 'Khi ra khỏi nhà đừng quên mang theo chìa khóa và ví tiền nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '那么',
    pinyin: 'nàme',
    word_type: 'Đại từ / Liên từ',
    meaning_vi: 'như thế, đến thế, vậy thì',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '今天的天气怎么那么冷？', pinyin: 'Jīntiān de tiānqì zěnme nàme lěng?', meaning_vi: 'Hôm nay thời tiết sao mà lạnh đến thế chứ?', difficulty_level: 'basic' },
      { chinese: '既然你决定去北京，那么就好好做准备吧。', pinyin: 'Jìrán nǐ juédìng qù Běijīng, nàme jiù hǎohāo zuò zhǔnbèi ba.', meaning_vi: 'Nếu bạn đã quyết định đi Bắc Kinh, vậy thì hãy chuẩn bị cho thật tốt nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '那样',
    pinyin: 'nàyàng',
    word_type: 'Đại từ',
    meaning_vi: 'như thế, như vậy, kiểu đó',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我也想像他那样说一口流利的汉语。', pinyin: 'Wǒ yě xiǎng xiàng tā nàyàng shuō yì kǒu liúlì de Hànyǔ.', meaning_vi: 'Tôi cũng muốn nói một giọng tiếng Hán lưu loát giống như anh ấy.', difficulty_level: 'basic' },
      { chinese: '做事不能那样马虎，必须认真负责。', pinyin: 'Zuòshì bù néng nàyàng mǎhu, bìxū rènzhēn fùzé.', meaning_vi: 'Làm việc không thể qua loa như thế được, cần phải nghiêm túc và có trách nhiệm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '奶茶',
    pinyin: 'nǎichá',
    word_type: 'Danh từ',
    meaning_vi: 'trà sữa',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '下午我想喝一杯珍珠奶茶。', pinyin: 'Xiàwǔ wǒ xiǎng hē yì bēi zhēnzhū nǎichá.', meaning_vi: 'Buổi chiều tôi muốn uống một ly trà sữa trân châu.', difficulty_level: 'basic' },
      { chinese: '现在的年轻人都很喜欢相约在奶茶店聊天。', pinyin: 'Xiànzài de niánqīngrén dōu hěn xǐhuan xiāngyuē zài nǎichádiàn liáotiān.', meaning_vi: 'Giới trẻ hiện nay rất thích hẹn hò nhau ở quán trà sữa để trò chuyện.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '奶奶',
    pinyin: 'nǎinai',
    word_type: 'Danh từ',
    meaning_vi: 'bà nội',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我奶奶今年七十五岁了。', pinyin: 'Wǒ nǎinai jīnnián qīshíwǔ suì le.', meaning_vi: 'Bà nội tôi năm nay bảy mươi lăm tuổi rồi.', difficulty_level: 'basic' },
      { chinese: '奶奶做的饭菜是全家最好吃的味道。', pinyin: 'Nǎinai zuò de fàncài shì quánjiā zuì hǎochī de wèidao.', meaning_vi: 'Món ăn bà nội nấu là hương vị thơm ngon nhất của cả gia đình.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '男孩儿',
    pinyin: 'nánháir',
    word_type: 'Danh từ',
    meaning_vi: 'bé trai, cậu bé',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '那个小男孩儿在公园里放风筝。', pinyin: 'Nà ge xiǎo nánháir zài gōngyuán lǐ fàng fēngzheng.', meaning_vi: 'Cậu bé kia đang thả diều trong công viên.', difficulty_level: 'basic' },
      { chinese: '他是一个性格阳光、乐于助人的懂事男孩儿。', pinyin: 'Tā shì yí ge xìnggé yángguāng, lèyú zhùrén de dǒngshì nánháir.', meaning_vi: 'Cậu ấy là một cậu bé hiểu chuyện, tính cách tươi sáng và rất hay giúp đỡ người khác.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '鸟',
    pinyin: 'niǎo',
    word_type: 'Danh từ',
    meaning_vi: 'con chim, loài chim',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '树上停着两只美丽的鸟。', pinyin: 'Shù shang tíng zhe liǎng zhī měilì de niǎo.', meaning_vi: 'Trên cành cây có hai chú chim xinh xắn đang đậu.', difficulty_level: 'basic' },
      { chinese: '清晨森林里传来了各种小鸟清脆悦耳的叫声。', pinyin: 'Qīngchén sēnlín lǐ chuánlái le gèzhǒng xiǎoniǎo qīngcuì yuè’ěr de jiàoshēng.', meaning_vi: 'Sáng sớm trong rừng truyền lại tiếng chim hót líu lo trong trẻo êm tai.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '女孩儿',
    pinyin: 'nǚháir',
    word_type: 'Danh từ',
    meaning_vi: 'bé gái, cô bé',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '那个小女孩儿笑得很甜。', pinyin: 'Nà ge xiǎo nǚháir xiào de hěn tián.', meaning_vi: 'Cô bé kia cười trông rất ngọt ngào.', difficulty_level: 'basic' },
      { chinese: '穿红色裙子的小女孩儿正在认真地画画。', pinyin: 'Chuān hóngsè qúnzi de xiǎo nǚháir zhèngzài rènzhēn de huàhuà.', meaning_vi: 'Cô bé mặc chiếc váy màu đỏ đang chăm chú ngồi vẽ tranh.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM P - Q - R ---
  {
    hanzi: '跑',
    pinyin: 'pǎo',
    word_type: 'Động từ',
    meaning_vi: 'chạy',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他每天早上都在操场跑步。', pinyin: 'Tā měitiān zǎoshang dōu zài cāochǎng pǎobù.', meaning_vi: 'Anh ấy mỗi sáng đều chạy bộ ở sân vận động.', difficulty_level: 'basic' },
      { chinese: '小狗看见主人回来，飞快地跑了过去。', pinyin: 'Xiǎogǒu kànjiàn zhǔrén huílai, fēikuài de pǎo le guòqù.', meaning_vi: 'Chú cún con thấy chủ về liền chạy vụt tới mừng rỡ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '起来',
    pinyin: 'qǐlai',
    word_type: 'Động từ / Hậu tố',
    meaning_vi: 'thức dậy; lên (bắt đầu hành động)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '今天星期天，他起得很晚。', pinyin: 'Jīntiān xīngqītiān, tā qǐ de hěn wǎn.', meaning_vi: 'Hôm nay là chủ nhật, anh ấy ngủ dậy rất muộn.', difficulty_level: 'basic' },
      { chinese: '听到音乐声，大家都跟着跳起舞来。', pinyin: 'Tīng dào yīnyuè shēng, dàjiā dōu gēnzhe tiào qǐ wǔ lai.', meaning_vi: 'Nghe thấy tiếng nhạc vang lên, mọi người đều nhảy múa theo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '球',
    pinyin: 'qiú',
    word_type: 'Danh từ',
    meaning_vi: 'quả bóng, trò chơi bóng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '弟弟正在草地上踢球。', pinyin: 'Dìdi zhèngzài cǎodì shang tī qiú.', meaning_vi: 'Em trai đang đá bóng trên bãi cỏ.', difficulty_level: 'basic' },
      { chinese: '下课后操场上有很多打球和运动的学生。', pinyin: 'Xiàkè hòu cāochǎng shang yǒu hěn duō dǎqiú hé yùndòng de xuésheng.', meaning_vi: 'Sau giờ tan học trên sân có rất nhiều học sinh chơi bóng và vận động.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '肉',
    pinyin: 'ròu',
    word_type: 'Danh từ',
    meaning_vi: 'thịt',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我今天买了一斤牛肉。', pinyin: 'Wǒ jīntiān mǎi le yì jīn niúròu.', meaning_vi: 'Hôm nay tôi đã mua nửa cân thịt bò.', difficulty_level: 'basic' },
      { chinese: '医生建议他平时多吃新鲜蔬菜，少吃油腻的肥肉。', pinyin: 'Yīshēng jiànyì tā píngshí duō chī xīnxiān shūcài, shǎo chī yóunì de féiròu.', meaning_vi: 'Bác sĩ khuyên anh ấy thường ngày nên ăn nhiều rau tươi, ít ăn thịt mỡ ngấy.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM S ---
  {
    hanzi: '商场',
    pinyin: 'shāngchǎng',
    word_type: 'Danh từ',
    meaning_vi: 'trung tâm thương mại, khu mua sắm',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '周末很多市民去商场购物。', pinyin: 'Zhōumò hěn duō shìmín qù shāngchǎng gòuwù.', meaning_vi: 'Cuối tuần rất nhiều người dân đi trung tâm thương mại mua sắm.', difficulty_level: 'basic' },
      { chinese: '这家新建的商场集餐饮、娱乐和购物于一体。', pinyin: 'Zhè jiā xīn jiàn de shāngchǎng jí cānyǐn, yúlè hé gòuwù yú yītǐ.', meaning_vi: 'Trung tâm mua sắm mới xây này tích hợp ăn uống, giải trí và mua sắm trong một.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '上来',
    pinyin: 'shànglai',
    word_type: 'Động từ',
    meaning_vi: 'lên đây, bước lên',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '车来了，请大家按顺序上来。', pinyin: 'Chē lái le, qǐng dàjiā àn shùnxù shànglai.', meaning_vi: 'Xe tới rồi, xin mọi người lần lượt theo thứ tự bước lên xe.', difficulty_level: 'basic' },
      { chinese: '我在楼上等你们，坐电梯直接上来吧。', pinyin: 'Wǒ zài lóushang děng nǐmen, zuò diàntī zhíjiē shànglai ba.', meaning_vi: 'Tôi đang ở trên lầu đợi các bạn, hãy đi thang máy thẳng lên đây nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '上面',
    pinyin: 'shàngmiàn',
    word_type: 'Danh từ',
    meaning_vi: 'bên trên, phía trên',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '桌子上面放着一本汉语书。', pinyin: 'Zhuōzi shàngmiàn fàng zhe yì běn Hànyǔ shū.', meaning_vi: 'Trên mặt bàn có để một cuốn sách tiếng Hán.', difficulty_level: 'basic' },
      { chinese: '货架上面摆放着最新生产的食品。', pinyin: 'Huòjià shàngmiàn bǎifàng zhe zuìxīn shēngchǎn de shípǐn.', meaning_vi: 'Phía trên kệ hàng bày bán những loại thực phẩm mới sản xuất nhất.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '上去',
    pinyin: 'shàngqù',
    word_type: 'Động từ',
    meaning_vi: 'đi lên đó, bước lên trên',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '山很高，我们爬得上去吗？', pinyin: 'Shān hěn gāo, wǒmen pá de shàngqù ma?', meaning_vi: 'Ngọn núi cao lắm, chúng mình có trèo lên tới đỉnh nổi không?', difficulty_level: 'basic' },
      { chinese: '他提着沉重的行李，慢慢地走上了楼。', pinyin: 'Tā tí zhe chénzhòng de xíngli, mànmàn de zǒu shàng le lóu.', meaning_vi: 'Anh ấy xách chiếc vali nặng trĩu, chậm rãi bước lên lầu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '上网',
    pinyin: 'shàngwǎng',
    word_type: 'Động từ',
    meaning_vi: 'lên mạng, lướt internet',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我每天上网查阅学习资料。', pinyin: 'Wǒ měitiān shàngwǎng cháyuè xuéxí zīliào.', meaning_vi: 'Tôi mỗi ngày đều lên mạng tra cứu tài liệu học tập.', difficulty_level: 'basic' },
      { chinese: '现代人的日常生活几乎离不开手机上网。', pinyin: 'Xiàndàirén de rìcháng shēnghuó jīhū lí bù kāi shǒujī shàngwǎng.', meaning_vi: 'Cuộc sống thường nhật của con người hiện đại hầu như không thể tách rời việc lướt mạng bằng điện thoại.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '时',
    pinyin: 'shí',
    word_type: 'Danh từ',
    meaning_vi: 'khi, lúc, thời gian',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '过马路时要看红绿灯。', pinyin: 'Guò mǎlù shí yào kàn hónglǜdēng.', meaning_vi: 'Lúc sang đường phải quan sát đèn giao thông.', difficulty_level: 'basic' },
      { chinese: '遇到困难时，不要轻易放弃努力。', pinyin: 'Yù dào kùnnan shí, búyào qīngyì fàngqì nǔlì.', meaning_vi: 'Khi đối mặt với khó khăn thử thách, chớ dễ dàng từ bỏ nỗ lực.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '手',
    pinyin: 'shǒu',
    word_type: 'Danh từ',
    meaning_vi: 'tay, bàn tay',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '吃饭前请记得先洗手。', pinyin: 'Chīfàn qián qǐng jìde xiān xǐshǒu.', meaning_vi: 'Trước khi ăn cơm xin nhớ rửa tay sạch sẽ trước.', difficulty_level: 'basic' },
      { chinese: '天气太冷了，他的双手都冻得通红。', pinyin: 'Tiānqì tài lěng le, tā de shuāngshǒu dōu dòng de tōnghóng.', meaning_vi: 'Thời tiết buốt giá quá, đôi bàn tay của anh ấy đỏ ửng cả lên.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '书包',
    pinyin: 'shūbāo',
    word_type: 'Danh từ',
    meaning_vi: 'cặp sách, balo học sinh',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我的书包是黑色的。', pinyin: 'Wǒ de shūbāo shì hēisè de.', meaning_vi: 'Cặp sách của tôi có màu đen.', difficulty_level: 'basic' },
      { chinese: '小学生每天背着沉重的大书包去上学。', pinyin: 'Xiǎoxuéshēng měitiān bēi zhe chénzhòng de dà shūbāo qù shàngxué.', meaning_vi: 'Các em học sinh tiểu học mỗi ngày đều đeo chiếc cặp sách to nặng đến trường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '舒服',
    pinyin: 'shūfu',
    word_type: 'Tính từ',
    meaning_vi: 'thoải mái, dễ chịu, khỏe khoắn',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '今天我身体不太舒服，想请假。', pinyin: 'Jīntiān wǒ shēntǐ bú tài shūfu, xiǎng qǐngjià.', meaning_vi: 'Hôm nay trong người tôi không được khỏe, muốn xin nghỉ phép.', difficulty_level: 'basic' },
      { chinese: '坐在软软的沙发上喝热茶特别舒服。', pinyin: 'Zuò zài ruǎnruǎn de shāfā shang hē rèchá tèbié shūfu.', meaning_vi: 'Ngồi trên chiếc ghế sofa êm ái thưởng thức tách trà nóng vô cùng dễ chịu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '虽然',
    pinyin: 'suīrán',
    word_type: 'Liên từ',
    meaning_vi: 'tuy rằng, mặc dù',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '虽然外面下着雨，但他还是出门了。', pinyin: 'Suīrán wàimiàn xià zhe yǔ, dàn tā háishì chūmén le.', meaning_vi: 'Tuy rằng ngoài trời đang mưa, anh ấy vẫn ra ngoài.', difficulty_level: 'basic' },
      { chinese: '虽然学汉语并不容易，但他从未想过要放弃。', pinyin: 'Suīrán xué Hànyǔ bìng bù róngyì, dàn tā cóngwèi xiǎng guo yào fàngqì.', meaning_vi: 'Mặc dù học tiếng Hán chẳng hề dễ dàng, nhưng anh ấy chưa từng nghĩ tới việc bỏ cuộc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '所以',
    pinyin: 'suǒyǐ',
    word_type: 'Liên từ',
    meaning_vi: 'cho nên, vì vậy',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '因为起晚了，所以我今天迟到了。', pinyin: 'Yīnwèi qǐ wǎn le, suǒyǐ wǒ jīntiān chídào le.', meaning_vi: 'Bởi vì dậy muộn, cho nên hôm nay tôi bị trễ giờ.', difficulty_level: 'basic' },
      { chinese: '他平时学习特别用功，所以这次考试拿到满分。', pinyin: 'Tā píngshí xuéxí tèbié yònggōng, suǒyǐ zhè cì kǎoshì ná dào mǎnfēn.', meaning_vi: 'Bình thường cậu ấy học tập đặc biệt chăm chỉ, vì vậy kỳ thi này đã đạt điểm tối đa.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM T ---
  {
    hanzi: '疼',
    pinyin: 'téng',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'đau, đau nhức; yêu thương',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我肚子疼，想去医院看医生。', pinyin: 'Wǒ dùzi téng, xiǎng qù yīyuàn kàn yīshēng.', meaning_vi: 'Tôi bị đau bụng, muốn đến bệnh viện khám bác sĩ.', difficulty_level: 'basic' },
      { chinese: '昨晚没睡好，今天一整天头都隐隐作疼。', pinyin: 'Zuówǎn méi shuì hǎo, jīntiān yì zhěngtiān tóu dōu yǐnyǐn zuòténg.', meaning_vi: 'Đêm qua ngủ không ngon, hôm nay cả ngày đầu cứ đau âm ỉ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '踢',
    pinyin: 'tī',
    word_type: 'Động từ',
    meaning_vi: 'đá',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '男孩子们都很喜欢踢足球。', pinyin: 'Nánháizimen dōu hěn xǐhuan tī zúqiú.', meaning_vi: 'Các cậu bé đều rất thích đá bóng.', difficulty_level: 'basic' },
      { chinese: '走路时不小心踢到了路边的石头，脚趾好疼。', pinyin: 'Zǒulù shí bù xiǎoxīn tī dào le lùbiān de shítou, jiǎozhǐ hǎo téng.', meaning_vi: 'Lúc đi bộ lỡ đá phải hòn đá bên đường, ngón chân đau điếng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '条',
    pinyin: 'tiáo',
    word_type: 'Lượng từ',
    meaning_vi: 'con, chiếc, sợi (lượng từ cho vật dài, hẹp)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '河里有很多条小鱼在游。', pinyin: 'Hé lǐ yǒu hěn duō tiáo xiǎoyú zài yóu.', meaning_vi: 'Dưới sông có rất nhiều chú cá nhỏ đang bơi lội.', difficulty_level: 'basic' },
      { chinese: '这条新修的高速公路非常平坦宽阔。', pinyin: 'Zhè tiáo xīn xiū de gāosù gōnglù fēicháng píngtǎn kuānkuò.', meaning_vi: 'Tuyến đường cao tốc mới xây này rất bằng phẳng và thênh thang.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '头',
    pinyin: 'tóu',
    word_type: 'Danh từ',
    meaning_vi: 'đầu, mái đầu; con (lượng từ cho gia súc)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他低下头认真地看书。', pinyin: 'Tā dī xià tóu rènzhēn de kànshū.', meaning_vi: 'Cậu ấy cúi đầu chăm chú đọc sách.', difficulty_level: 'basic' },
      { chinese: '农场里养着十几头健壮的奶牛。', pinyin: 'Nóngchǎng lǐ yǎng zhe shí jǐ tóu jiànzhuàng de nǎiniú.', meaning_vi: 'Trong nông trại có nuôi mười mấy con bò sữa khỏe mạnh.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM W ---
  {
    hanzi: '外国',
    pinyin: 'wàiguó',
    word_type: 'Danh từ',
    meaning_vi: 'nước ngoài, ngoại quốc',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '他在外国生活了三年。', pinyin: 'Tā zài wàiguó shēnghuó le sān nián.', meaning_vi: 'Anh ấy đã sống ở nước ngoài được ba năm.', difficulty_level: 'basic' },
      { chinese: '很多外国留学生都喜欢体验中国的传统文化。', pinyin: 'Hěn duō wàiguó liúxuéshēng dōu xǐhuan tǐyàn Zhōngguó de chuántǒng wénhuà.', meaning_vi: 'Rất nhiều lưu học sinh nước ngoài đều thích trải nghiệm văn hóa truyền thống Trung Quốc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '外面',
    pinyin: 'wàimiàn',
    word_type: 'Danh từ',
    meaning_vi: 'bên ngoài, phía ngoài',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '外面风很大，多穿点衣服。', pinyin: 'Wàimiàn fēng hěn dà, duō chuān diǎnr yīfu.', meaning_vi: 'Bên ngoài gió to lắm, hãy mặc thêm áo ấm vào nhé.', difficulty_level: 'basic' },
      { chinese: '窗户外面种着几棵郁郁葱葱的树。', pinyin: 'Chuānghu wàimiàn zhòng zhe jǐ kē yùyùcōngcōng de shù.', meaning_vi: 'Bên ngoài cửa sổ có trồng mấy cây xanh tươi tốt um tùm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '万',
    pinyin: 'wàn',
    word_type: 'Số từ',
    meaning_vi: 'vạn, mười nghìn (10.000)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这辆汽车花了十万元。', pinyin: 'Zhè liàng qìchē huā le shí wàn yuán.', meaning_vi: 'Chiếc xe hơi này mua hết mười vạn tệ (100.000 NDT).', difficulty_level: 'basic' },
      { chinese: '这座图书馆藏书超过两百万册。', pinyin: 'Zhè zuò túshūguǎn cángshū chāoguò liǎng bǎi wàn cè.', meaning_vi: 'Thư viện này lưu trữ lượng sách vượt hơn hai triệu cuốn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '网上',
    pinyin: 'wǎngshang',
    word_type: 'Danh từ',
    meaning_vi: 'trên mạng internet',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我在网上买了一双鞋。', pinyin: 'Wǒ zài wǎngshang mǎi le yì shuāng xié.', meaning_vi: 'Tôi đã mua một đôi giày ở trên mạng.', difficulty_level: 'basic' },
      { chinese: '现在人们可以通过网上银行方便地办理转账业务。', pinyin: 'Xiànzài rénmen kěyǐ tōngguò wǎngshang yínháng fāngbiàn de bànlǐ zhuǎnzhàng yèwù.', meaning_vi: 'Ngày nay mọi người có thể thông qua ngân hàng trực tuyến thuận tiện chuyển tiền.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '忘',
    pinyin: 'wàng',
    word_type: 'Động từ',
    meaning_vi: 'quên',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我忘了带雨伞。', pinyin: 'Wǒ wàng le dài yǔsǎn.', meaning_vi: 'Tôi quên mang theo ô rồi.', difficulty_level: 'basic' },
      { chinese: '请别忘了明天早上的班级会议。', pinyin: 'Qǐng bié wàng le míngtiān zǎoshang de bānjí huìyì.', meaning_vi: 'Xin chớ quên buổi họp lớp vào sáng ngày mai nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '位',
    pinyin: 'wèi',
    word_type: 'Lượng từ',
    meaning_vi: 'vị, ngài (lượng từ lịch sự cho người)',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请问有几位客人？', pinyin: 'Qǐngwèn yǒu jǐ wèi kèrén?', meaning_vi: 'Xin hỏi quý khách đi mấy vị ạ?', difficulty_level: 'basic' },
      { chinese: '这位老教授在医学领域享有极高的声誉。', pinyin: 'Zhè wèi lǎo jiàoshòu zài yīxué lǐngyù xiǎngyǒu jí gāo de shēngyù.', meaning_vi: 'Vị giáo sư già này có uy tín vô cùng cao trong lĩnh vực y học.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM X ---
  {
    hanzi: '洗手间',
    pinyin: 'xǐshǒujiān',
    word_type: 'Danh từ',
    meaning_vi: 'nhà vệ sinh, phòng vệ sinh',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请问洗手间在哪里？', pinyin: 'Qǐngwèn xǐshǒujiān zài nǎli?', meaning_vi: 'Xin hỏi nhà vệ sinh ở đâu vậy ạ?', difficulty_level: 'basic' },
      { chinese: '饭馆的洗手间保持得很干净整洁。', pinyin: 'Fànguǎn de xǐshǒujiān bǎochí de hěn gānjìng zhěngjié.', meaning_vi: 'Nhà vệ sinh của quán ăn được giữ gìn rất sạch sẽ gọn gàng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '下来',
    pinyin: 'xiàlai',
    word_type: 'Động từ',
    meaning_vi: 'xuống đây, đi xuống',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '车停了，大家快下来吧。', pinyin: 'Chē tíng le, dàjiā kuài xiàlai ba.', meaning_vi: 'Xe đỗ rồi, mọi người mau xuống đây thôi.', difficulty_level: 'basic' },
      { chinese: '他在树上摘苹果，我们在树下让他小心下来。', pinyin: 'Tā zài shù shang zhāi píngguǒ, wǒmen zài shù xià ràng tā xiǎoxīn xiàlai.', meaning_vi: 'Anh ấy trèo hái táo trên cây, chúng tôi ở dưới nhắc anh ấy cẩn thận bước xuống.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '下面',
    pinyin: 'xiàmiàn',
    word_type: 'Danh từ',
    meaning_vi: 'phía dưới, bên dưới',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '小猫趴在椅子下面睡觉。', pinyin: 'Xiǎomāo pā zài yǐzi xiàmiàn shuìjiào.', meaning_vi: 'Mèo con đang nằm ngủ dưới gầm ghế.', difficulty_level: 'basic' },
      { chinese: '大树下面非常凉快，很多老人在那儿下棋。', pinyin: 'Dàshù xiàmiàn fēicháng liángkuai, hěn duō lǎorén zài nàr xiàqí.', meaning_vi: 'Dưới gốc cây lớn rất mát mẻ, nhiều cụ già ngồi đó chơi cờ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '下去',
    pinyin: 'xiàqù',
    word_type: 'Động từ',
    meaning_vi: 'đi xuống đó, bước xuống',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '电梯坏了，我们走楼梯下去吧。', pinyin: 'Diàntī huài le, wǒmen zǒu lóutī xiàqù ba.', meaning_vi: 'Thang máy hỏng rồi, chúng mình đi cầu thang bộ xuống nhé.', difficulty_level: 'basic' },
      { chinese: '太阳慢慢落了下去，夜幕降临了。', pinyin: 'Tàiyáng mànmàn luò le xiàqù, yèmù jiànglín le.', meaning_vi: 'Mặt trời từ từ lặn xuống dưới rặng núi, màn đêm buông xuống.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '小孩儿',
    pinyin: 'xiǎoháir',
    word_type: 'Danh từ',
    meaning_vi: 'trẻ con, đứa trẻ, em bé',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '公园里有很多小孩儿在玩游戏。', pinyin: 'Gōngyuán lǐ yǒu hěn duō xiǎoháir zài wán yóuxì.', meaning_vi: 'Trong công viên có rất nhiều trẻ con đang chơi đùa.', difficulty_level: 'basic' },
      { chinese: '小孩子好奇心强，对新鲜事物总是问个不停。', pinyin: 'Xiǎoháir hàoqíxīn qiáng, duì xīnxiān shìwù zǒng shì wèn ge bù tíng.', meaning_vi: 'Trẻ nhỏ tính tò mò rất lớn, luôn miệng hỏi không ngừng về những điều mới lạ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '小时候',
    pinyin: 'xiǎoshíhou',
    word_type: 'Danh từ',
    meaning_vi: 'hồi nhỏ, khi còn bé',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '小时候我经常跟爷爷去钓鱼。', pinyin: 'Xiǎoshíhou wǒ jīngcháng gēn yéye qù diàoyú.', meaning_vi: 'Hồi bé tôi thường theo ông nội đi câu cá.', difficulty_level: 'basic' },
      { chinese: '小时候的快乐时光总是让人十分怀念。', pinyin: 'Xiǎoshíhou de kuàilè shíguāng zǒng shì ràng rén shífēn huáiniàn.', meaning_vi: 'Khoảng thời gian vui vẻ vô tư thời thơ ấu luôn khiến người ta bồi hồi thương nhớ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '姓名',
    pinyin: 'xìngmíng',
    word_type: 'Danh từ',
    meaning_vi: 'họ và tên',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请在这张表上写下您的姓名。', pinyin: 'Qǐng zài zhè zhāng biǎo shang xiě xià nín de xìngmíng.', meaning_vi: 'Xin hãy viết họ và tên của bạn vào tờ phiếu này.', difficulty_level: 'basic' },
      { chinese: '办理入住手续时需要核对身份证上的姓名和照片。', pinyin: 'Bànlǐ rùzhù shǒuxù shí xūyào h किसानोंduì shēnfènzhèng shang de xìngmíng hé zhàopiàn.', meaning_vi: 'Khi làm thủ tục nhận phòng cần đối chiếu họ tên và ảnh trên căn cước.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM Y ---
  {
    hanzi: '药店',
    pinyin: 'yàodiàn',
    word_type: 'Danh từ',
    meaning_vi: 'hiệu thuốc, tiệm thuốc tây',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我家附近有一家二十四小时药店。', pinyin: 'Wǒ jiā fùjìn yǒu yì jiā èrshísì xiǎoshí yàodiàn.', meaning_vi: 'Gần nhà tôi có một tiệm thuốc mở cửa hai mươi tư trên hai mươi tư giờ.', difficulty_level: 'basic' },
      { chinese: '他感冒了，下班顺路去药店买点感冒药。', pinyin: 'Tā gǎnmào le, xiàbān shùnlù qù yàodiàn mǎi diǎnr gǎnmàoyào.', meaning_vi: 'Anh ấy bị cảm rồi, sau giờ tan làm tiện đường tạt qua hiệu thuốc mua ít thuốc cảm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '爷爷',
    pinyin: 'yéye',
    word_type: 'Danh từ',
    meaning_vi: 'ông nội',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '爷爷每天早起散步打太极拳。', pinyin: 'Yéye měitiān zǎoqǐ sànbù dǎ tàijíquán.', meaning_vi: 'Ông nội mỗi ngày đều dậy sớm tản bộ và tập thái cực quyền.', difficulty_level: 'basic' },
      { chinese: '春节全家人聚在爷爷家吃了一顿丰盛的年夜饭。', pinyin: 'Chūnjié quánjiā rén jù zài yéye jiā chī le yí dùn fēngshèng de niányèfàn.', meaning_vi: 'Dịp tết nguyên đán cả nhà quây quần tại nhà ông nội ăn bữa cơm tất niên thịnh soạn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '一会儿',
    pinyin: 'yíhuìr',
    word_type: 'Cụm từ / Số từ',
    meaning_vi: 'một lát, một chốc, một lát nữa',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请你在这里等我一会儿。', pinyin: 'Qǐng nǐ zài zhèlǐ děng wǒ yíhuìr.', meaning_vi: 'Xin hãy ở đây đợi tôi một lát nhé.', difficulty_level: 'basic' },
      { chinese: '工作累了就站起来看远方休息一会儿。', pinyin: 'Gōngzuò lèi le jiù zhàn qǐlai kàn yuǎnfāng xiūxi yíhuìr.', meaning_vi: 'Làm việc mệt rồi thì đứng dậy phóng tầm mắt ra xa thư giãn một chốc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '因为',
    pinyin: 'yīnwèi',
    word_type: 'Liên từ / Giới từ',
    meaning_vi: 'bởi vì, do vì',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '因为今天下雨，我们不出去玩了。', pinyin: 'Yīnwèi jīntiān xiàyǔ, wǒmen bù chūqù wán le.', meaning_vi: 'Bởi vì hôm nay trời mưa, chúng mình không ra ngoài chơi nữa.', difficulty_level: 'basic' },
      { chinese: '他因为出色的工作表现受到了公司的表彰。', pinyin: 'Tā yīnwèi chūsè de gōngzuò biǎoxiàn shòudào le gōngsī de biǎozhāng.', meaning_vi: 'Anh ấy nhờ vào biểu hiện công tác xuất sắc mà được công ty tuyên dương khen thưởng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '游',
    pinyin: 'yóu',
    word_type: 'Động từ',
    meaning_vi: 'bơi lội, du ngoạn',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '夏天我和朋友们常去游泳馆游泳。', pinyin: 'Xiàtiān wǒ hé péngyoumen cháng qù yóuyǒngguǎn yóuyǒng.', meaning_vi: 'Mùa hè tôi cùng các bạn thường đến bể bơi để bơi.', difficulty_level: 'basic' },
      { chinese: '鱼儿在清澈的小河里欢快地游来游去。', pinyin: 'Yúr zài qīngchè de xiǎohé lǐ huānkuài de yóu lái yóu qù.', meaning_vi: 'Đàn cá bơi lội tung tăng trong dòng sông nhỏ trong vắt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '有意思',
    pinyin: 'yǒuyìsi',
    word_type: 'Tính từ',
    meaning_vi: 'thú vị, có ý nghĩa, hay',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这个汉语故事真有意思！', pinyin: 'Zhè ge Hànyǔ gùshi zhēn yǒuyìsi!', meaning_vi: 'Câu chuyện tiếng Hán này thực sự rất thú vị!', difficulty_level: 'basic' },
      { chinese: '老师上课讲得很生动，大家都觉得学汉语很有意思。', pinyin: 'Lǎoshī shàngkè jiǎng de hěn shēngdòng, dàjiā dōu juéde xué Hànyǔ hěn yǒuyìsi.', meaning_vi: 'Thầy cô giảng bài rất sinh động, ai nấy đều cảm thấy học tiếng Hán vô cùng bổ ích và hay.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '有时',
    pinyin: 'yǒushí',
    word_type: 'Phó từ',
    meaning_vi: 'có lúc, đôi khi, thỉnh thoảng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我有时走路去上班。', pinyin: 'Wǒ yǒushí zǒulù qù shàngbān.', meaning_vi: 'Tôi thỉnh thoảng đi bộ đi làm.', difficulty_level: 'basic' },
      { chinese: '山里的天气变化莫测，有时晴朗，有时突然下起小雨。', pinyin: 'Shān lǐ de tiānqì biànhuà mò cè, yǒushí qínglǎng, yǒushí tūrán xià qǐ xiǎoyǔ.', meaning_vi: 'Thời tiết trong núi khó lường, có khi thì nắng ráo, có lúc lại bất chợt đổ mưa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '右',
    pinyin: 'yòu',
    word_type: 'Danh từ',
    meaning_vi: 'bên phải, phía hữu',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '车站就在马路的右边。', pinyin: 'Chēzhàn jiù zài mǎlù de yòubian.', meaning_vi: 'Bến xe nằm ngay ở phía bên phải con đường.', difficulty_level: 'basic' },
      { chinese: '走到路口请向右拐，然后再往前走一百米。', pinyin: 'Zǒu dào lùkǒu qǐng xiàng yòu guǎi, ránhòu zài wǎng qián zǒu yìbǎi mǐ.', meaning_vi: 'Đi tới ngã tư xin hãy rẽ phải, sau đó đi tiếp về phía trước một trăm mét.', difficulty_level: 'applied' }
    ]
  },

  // --- NHÓM Z ---
  {
    hanzi: '站',
    pinyin: 'zhàn',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'trạm, bến, ga; đứng',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '下一站是天安门广场。', pinyin: 'Xià yí zhàn shì Tiān&#x27;ānmén Guǎngchǎng.', meaning_vi: 'Trạm tiếp theo là quảng trường Thiên An Môn.', difficulty_level: 'basic' },
      { chinese: '公交车上没有空座位，他站了半个多小时。', pinyin: 'Gōngjiāochē shang méiyǒu kōng zuòwèi, tā zhàn le bàn ge duō xiǎoshí.', meaning_vi: 'Trên xe buýt không còn ghế trống, anh ấy đã đứng hơn nửa tiếng đồng hồ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '这么',
    pinyin: 'zhème',
    word_type: 'Đại từ',
    meaning_vi: 'như thế này, đến thế này',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这个苹果怎么这么甜？', pinyin: 'Zhè ge píngguǒ zěnme zhème tián?', meaning_vi: 'Quả táo này sao mà ngọt đến thế này nhỉ?', difficulty_level: 'basic' },
      { chinese: '既然大家意见这么一致，那我们就这么决定了。', pinyin: 'Jìrán dàjiā yìjiàn zhème yízhì, nà wǒmen jiù zhème juédìng le.', meaning_vi: 'Nếu ý kiến mọi người đã nhất trí như thế này, vậy chúng ta quyết định như vậy nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '这样',
    pinyin: 'zhèyàng',
    word_type: 'Đại từ',
    meaning_vi: 'như thế này, kiểu này',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '这样做真的很有效。', pinyin: 'Zhèyàng zuò zhēn de hěn yǒuxiào.', meaning_vi: 'Làm theo cách này thực sự rất hiệu quả.', difficulty_level: 'basic' },
      { chinese: '坚持每天练习半小时，这样中文水平才能稳步提高。', pinyin: 'Jiānchí měitiān liànxí bàn xiǎoshí, zhèyàng Zhōngwén shuǐpíng cái néng wěnbù tígāo.', meaning_vi: 'Kiên trì mỗi ngày luyện tập nửa giờ, có như vậy trình độ tiếng Trung mới tiến bộ vững chắc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '正',
    pinyin: 'zhèng',
    word_type: 'Phó từ',
    meaning_vi: 'đang, vừa đúng, chính',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我正想给你打电话呢。', pinyin: 'Wǒ zhèng xiǎng gěi nǐ dǎ diànhuà ne.', meaning_vi: 'Tôi vừa đúng lúc đang định gọi điện thoại cho bạn này.', difficulty_level: 'basic' },
      { chinese: '现在正是春暖花开、外出踏青的好时节。', pinyin: 'Xiànzài zhèng shì chūnnuǎn huākāi, wàichū tàqīng de hǎo shíjié.', meaning_vi: 'Bây giờ chính là tiết trời xuân ấm hoa nở, thời điểm tuyệt vời để du xuân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '周',
    pinyin: 'zhōu',
    word_type: 'Danh từ',
    meaning_vi: 'tuần, tuần lễ, chu kỳ',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '下周我们要去上海参加展会。', pinyin: 'Xià zhōu wǒmen yào qù Shànghǎi cānjiā zhǎnhuì.', meaning_vi: 'Tuần tới chúng tôi sẽ tới Thượng Hải tham gia triển lãm.', difficulty_level: 'basic' },
      { chinese: '开学已经三周了，大家都完全适应了校园生活。', pinyin: 'Kāixué yǐjīng sān zhōu le, dàjiā dōu wánquán shìyìng le xiàoyuán shēnghuó.', meaning_vi: 'Tựu trường đã được ba tuần rồi, ai nấy đều đã thích nghi hoàn toàn với đời sống học đường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '自己',
    pinyin: 'zìjǐ',
    word_type: 'Đại từ',
    meaning_vi: 'tự mình, bản thân',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '自己的事情要自己做。', pinyin: 'Zìjǐ de shìqing yào zìjǐ zuò.', meaning_vi: 'Chuyện của bản thân phải tự mình làm.', difficulty_level: 'basic' },
      { chinese: '一个人在异国他乡生活，一定要好好照顾自己。', pinyin: 'Yí ge rén zài yìguó tāxiāng shēnghuó, yídìng yào hǎohāo zhàogù zìjǐ.', meaning_vi: 'Một mình sống nơi đất khách quê người, nhất định phải chăm sóc tốt cho bản thân nhé.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '走路',
    pinyin: 'zǒulù',
    word_type: 'Động từ',
    meaning_vi: 'đi bộ, tản bộ',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '我家离学校很近，每天走路十分钟就到了。', pinyin: 'Wǒ jiā lí xuéxiào hěn jìn, měitiān zǒulù shí fēnzhōng jiù dào le.', meaning_vi: 'Nhà tôi cách trường rất gần, mỗi ngày đi bộ mười phút là tới.', difficulty_level: 'basic' },
      { chinese: '晚饭后多走路散步对身体健康非常有好处。', pinyin: 'Wǎnfàn hòu duō zǒulù sànbù duì shēntǐ jiànkāng fēicháng yǒu hǎochù.', meaning_vi: 'Sau bữa tối đi bộ nhiều có lợi ích rất lớn đối với sức khỏe.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '足球',
    pinyin: 'zúqiú',
    word_type: 'Danh từ',
    meaning_vi: 'bóng đá, môn bóng đá',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '今天下午操场有一场精彩的足球赛。', pinyin: 'Jīntiān xiàwǔ cāochǎng yǒu yì chǎng jīngcǎi de zúqiúsài.', meaning_vi: 'Chiều nay ngoài sân vận động có một trận bóng đá rất gay cấn.', difficulty_level: 'basic' },
      { chinese: '他从小就是个超级足球迷，最喜欢看世界杯比赛。', pinyin: 'Tā cóngxiǎo jiù shì ge chāojí zúqiúmí, zuì xǐhuan kàn Shìjièbēi bǐsài.', meaning_vi: 'Từ nhỏ anh ấy đã là một fan bóng đá cuồng nhiệt, thích nhất là xem các trận World Cup.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '左',
    pinyin: 'zuǒ',
    word_type: 'Danh từ',
    meaning_vi: 'bên trái, phía tả',
    hsk_level: 'HSK 2',
    examples: [
      { chinese: '请向左看，图书馆就在那边。', pinyin: 'Qǐng xiàng zuǒ kàn, túshūguǎn jiù zài nàbiān.', meaning_vi: 'Xin hãy nhìn sang bên trái, thư viện ở ngay đằng đó.', difficulty_level: 'basic' },
      { chinese: '中国道路交通规则是车辆靠右行驶，行人靠左注意避让。', pinyin: 'Zhōngguó dàolù jiāotōng guīzé shì chēliàng kào yòu xíngshǐ, xíngrén kào zuǒ zhùyì bìràng.', meaning_vi: 'Quy tắc giao thông là xe đi làn bên phải, người đi bộ quan sát chú ý nhường đường.', difficulty_level: 'applied' }
    ]
  }
];
