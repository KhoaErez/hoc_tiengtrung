// data/hsk5-batch6-part1-data.ts
// 25 từ HSK 5: #2502 [环节] -> #2526 [级]

export interface ExampleItem {
  chinese: string
  pinyin: string
  meaning_vi: string
  difficulty_level: 'basic' | 'applied'
}

export interface VocabItem {
  id: number
  hanzi: string
  pinyin: string
  word_type: string
  meaning_vi: string
  examples: ExampleItem[]
}

export const HSK5_BATCH6_PART1: VocabItem[] = [
  {
    id: 2502,
    hanzi: '环节',
    pinyin: 'huánjié',
    word_type: 'Danh từ',
    meaning_vi: 'khâu, mắt xích, phân đoạn (trong quy trình)',
    examples: [
      {
        chinese: '质量检验是整个生产流程中最关键的一个环节。',
        pinyin: 'Zhìliàng jiǎnyàn shì zhěnggè shēngchǎn liúchéng zhōng zuì guānjiàn de yí gè huánjié.',
        meaning_vi: 'Kiểm tra chất lượng là một trong những mắt xích then chốt nhất trong toàn bộ quy trình sản xuất.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业必须全面优化供应链上的每一个物流环节，才能有效压缩运营成本并提升客户履约满意度。',
        pinyin: 'Qǐyè bìxū quánmiàn yōuhuà gōngyìngliàn shang de měi yí gè wùliú huánjié, cáinéng yǒuxiào yāsuō yùnyíng chéngběn bìng tíshēng kèhù lǚyuē mǎnyìdù.',
        meaning_vi: 'Doanh nghiệp cần phải tối ưu hóa toàn diện từng khâu hậu cần trong chuỗi cung ứng thì mới có thể cắt giảm chi phí vận hành hiệu quả và nâng cao mức độ hài lòng về thực hiện đơn hàng cho khách.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2503,
    hanzi: '缓解',
    pinyin: 'huǎnjiě',
    word_type: 'Động từ',
    meaning_vi: 'xoa dịu, giảm nhẹ, giải tỏa (căng thẳng, cơn đau, khủng hoảng)',
    examples: [
      {
        chinese: '散步和听轻音乐有助于缓解工作一天带来的疲劳。',
        pinyin: 'Sànbù hé tīng qīngyīnyuè yǒuzhùyú huǎnjiě gōngzuò yì tiān dàilái de píláo.',
        meaning_vi: 'Đi dạo và nghe nhạc nhẹ giúp xoa dịu cảm giác mệt mỏi sau một ngày làm việc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '央行通过降准降息等货币政策工具向市场注入流动性，以此缓解实体企业面临的融资困难。',
        pinyin: 'Yāngháng tōngguò jiàngzhǔn jiàngxī děng huòbì zhèngcè gōngjù xiàng shìchǎng zhùrù liúdòngxìng, yǐcǐ huǎnjiě shítǐ qǐyè miànlín de róngzī kùnnán.',
        meaning_vi: 'Ngân hàng Trung ương thông qua các công cụ chính sách tiền tệ như giảm tỷ lệ dự trữ bắt buộc và giảm lãi suất để bơm thanh khoản vào thị trường, qua đó xoa dịu những khó khăn tài chính mà các doanh nghiệp sản xuất kinh doanh gặp phải.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2504,
    hanzi: '缓慢',
    pinyin: 'huǎnmàn',
    word_type: 'Tính từ',
    meaning_vi: 'chậm chạp, từ từ, chậm rãi',
    examples: [
      {
        chinese: '爷爷由于上了年纪，走起路来脚步有些缓慢。',
        pinyin: 'Yéye yóuyú shàng le niánjì, zǒu qǐ lù lai jiǎobù yǒuxiē huǎnmàn.',
        meaning_vi: 'Do tuổi cao nên bước chân đi lại của ông có phần chậm rãi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '受国际外需疲软及大宗商品价格波动影响，该国经济复苏进程比预想中更为缓慢。',
        pinyin: 'Shòu guójì wàixū píruǎn jí dàzōng shāngpǐn jiàgé bōdòng yǐngxiǎng, gāi guó jīngjì fùsū jìnchéng bǐ yùxiǎng zhōng gèng wéi huǎnmàn.',
        meaning_vi: 'Chịu ảnh hưởng bởi nhu cầu quốc tế suy yếu và giá hàng hóa cơ bản biến động, tiến trình phục hồi kinh tế của quốc gia này diễn ra chậm chạp hơn nhiều so với dự tính.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2505,
    hanzi: '黄瓜',
    pinyin: 'huángguā',
    word_type: 'Danh từ',
    meaning_vi: 'dưa chuột, dưa leo',
    examples: [
      {
        chinese: '炎热的夏日里，一盘清脆可口的凉拌黄瓜深受大家的喜爱。',
        pinyin: 'Yánrè de xiàrì lǐ, yì pán qīngcuì kěkǒu de liángbàn huángguā shēnshòu dàjiā de xǐ’ài.',
        meaning_vi: 'Trong những ngày hè oi bức, một đĩa dưa chuột muối thanh mát giòn ngon rất được mọi người yêu thích.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代智能温室大棚采用无土栽培与水肥一体化技术，大幅提升了有机黄瓜的产量与营养品质。',
        pinyin: 'Xiàndài zhìnéng wēnshì dàpéng cǎiyòng wútǔ zāipéi yǔ shuǐféi yītǐhuà jìshù, dàfú tíshēng le yǒujī huángguā de chǎnliàng yǔ yíngyǎng pǐnzhì.',
        meaning_vi: 'Nhà kính thông minh hiện đại áp dụng kỹ thuật canh tác không dùng đất và tích hợp nước tưới - phân bón, nâng cao đáng kể sản lượng và phẩm chất dinh dưỡng của dưa leo hữu cơ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2506,
    hanzi: '黄金',
    pinyin: 'huángjīn',
    word_type: 'Danh từ',
    meaning_vi: 'vàng; thời kỳ hoàng kim, cơ hội vàng',
    examples: [
      {
        chinese: '不少人喜欢购买黄金饰品作为保值投资的一种途径。',
        pinyin: 'Bù shǎo rén xǐhuan gòumǎi huángjīn shìpǐn zuòwéi bǎozhí tóuzī de yì zhǒng tújìng.',
        meaning_vi: 'Khá nhiều người thích mua trang sức bằng vàng như một kênh đầu tư giữ giá trị.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在国际金融市场波动加剧的背景下，黄金作为传统避险资产再次受到了全球机构投资者的青睐。',
        pinyin: 'Zài guójì jīnróng shìchǎng bōdòng jiājù de bèijǐng xià, huángjīn zuòwéi chuántǒng bìxiǎn zīchǎn zàicì shòudào le quánqiú jīgòu tóuzīzhě de qīnglài.',
        meaning_vi: 'Trong bối cảnh thị trường tài chính quốc tế biến động gia tăng, vàng với tư cách là tài sản trú ẩn an toàn truyền thống một lần nữa nhận được sự ưa chuộng của các nhà đầu tư tổ chức toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2507,
    hanzi: '灰',
    pinyin: 'huī',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'tro, tro tàn; bụi; màu xám; thất vọng, nản lòng',
    examples: [
      {
        chinese: '桌子几天没擦，上面落满了薄薄的一层灰。',
        pinyin: 'Zhuōzi jǐ tiān méi cā, shàngmiàn luòmǎn le báobáo de yì céng huī.',
        meaning_vi: 'Cái bàn mấy ngày không lau, trên mặt phủ đầy một lớp bụi mỏng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '虽然接连遭遇了几次创业挫折，但他依然没有灰心丧气，而是重整旗鼓再次出发。',
        pinyin: 'Suīrán jiēlián zāoyù le jǐ cì chuàngyè cuòzhé, dàn tā yīrán méiyǒu huīxīn-sàngqì, érshì chóngzhěng-qígǔ zàicì chūfā.',
        meaning_vi: 'Tuy liên tiếp gặp phải vài lần vấp ngã khi khởi nghiệp, anh ấy vẫn không hề nản lòng thoái chí, mà chỉnh đốn lại đội ngũ để bắt đầu một chặng đường mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2508,
    hanzi: '挥',
    pinyin: 'huī',
    word_type: 'Động từ',
    meaning_vi: 'vẫy (tay), vung (kiếm/bút), xua đi; phát huy',
    examples: [
      {
        chinese: '列车缓缓开动时，站台上的朋友们都在热情地挥手告别。',
        pinyin: 'Lièchē huǎnhuǎn kāidòng shí, zhàntái shang de péngyoumen dōu zài rèqíng de huīshǒu gàobié.',
        meaning_vi: 'Khi đoàn tàu từ từ lăn bánh, bạn bè trên sân ga đều nhiệt tình vẫy tay từ biệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '指挥家在交响乐团面前充满激情地挥动指挥棒，引导全场音乐达到震撼人心的最高潮。',
        pinyin: 'Zhǐhuījiā zài jiāoxiǎng yuètuán miànqián chōngmǎn jīqíng de huīdòng zhǐhuībàng, yǐndǎo quánchǎng yīnyuè dádào zhènhàn-rénxīn de zuì gāocháo.',
        meaning_vi: 'Nhạc trưởng đầy nhiệt huyết vung cây gậy chỉ huy trước dàn nhạc giao hưởng, dẫn dắt giai điệu toàn khán phòng đạt đến cao trào lay động lòng người.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2509,
    hanzi: '恢复',
    pinyin: 'huīfù',
    word_type: 'Động từ',
    meaning_vi: 'khôi phục, phục hồi, lấy lại',
    examples: [
      {
        chinese: '经过医生的悉心调理，病人的健康状况已经完全恢复了。',
        pinyin: 'Jīngguò yīshēng de xīxīn tiáolǐ, bìngrén de jiànkāng zhuàngkuàng yǐjīng wánquán huīfù le.',
        meaning_vi: 'Qua sự chăm sóc tận tình của bác sĩ, tình trạng sức khỏe của bệnh nhân đã hoàn toàn hồi phục.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着多项提振内需的宏观政策相继落地，国内消费市场与文化旅游产业迅速恢复了往日的活力。',
        pinyin: 'Suízhe duō xiàng tízhèn nèixū de hóngguān zhèngcè xiāngjì luòdì, guónèi xiāofèi shìchǎng yǔ wénhuà lǚyóu chǎnyè xùnsù huīfù le wǎngrì de huólì.',
        meaning_vi: 'Cùng với sự đi vào đời sống của nhiều chính sách vĩ mô kích cầu tiêu dùng nội địa, thị trường tiêu dùng trong nước và ngành du lịch văn hóa đã nhanh chóng khôi phục lại sức sống như trước đây.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2510,
    hanzi: '灰色',
    pinyin: 'huīsè',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'màu xám; vùng xám (mơ hồ pháp lý, mờ ám)',
    examples: [
      {
        chinese: '他今天穿了一件浅灰色的羊毛开衫，看起来既儒雅又温暖。',
        pinyin: 'Tā jīntiān chuān le yí jiàn qiǎnhuīsè de yángmáo kāishān, kàn qǐlái jì rúyǎ yòu wēnnuǎn.',
        meaning_vi: 'Hôm nay anh ấy mặc một chiếc áo len cardigan màu xám nhạt, trông vừa nho nhã lại vừa ấm áp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '监管部门正在全面清理互联网金融领域的灰色地带，坚决维护资本市场的健康秩序与投资者合法权益。',
        pinyin: 'Jiānguǎn bùmén zhèngzài quánmiàn qīnglǐ hùliánwǎng jīnróng lǐngyù de huīsè dìdài, jiānjué wéihù zīběn shìchǎng de jiànkāng zhìxù yǔ tóuzīzhě héfǎ quányì.',
        meaning_vi: 'Cơ quan quản lý đang tích cực rà soát và chấn chỉnh các vùng xám trong lĩnh vực tài chính Internet, kiên quyết bảo vệ trật tự lành mạnh của thị trường vốn và quyền lợi hợp pháp của các nhà đầu tư.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2511,
    hanzi: '回收',
    pinyin: 'huíshōu',
    word_type: 'Động từ',
    meaning_vi: 'thu hồi, tái chế',
    examples: [
      {
        chinese: '社区里设置了专门的废旧纸箱与塑料瓶回收箱。',
        pinyin: 'Shèqū lǐ shèzhì le zhuānmén de fèijiù zhǐxiāng yǔ sùliàopíng huíshōu xiāng.',
        meaning_vi: 'Khu dân cư đã lắp đặt các thùng thu gom tái chế riêng biệt dành cho thùng carton cũ và chai nhựa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '新能源汽车产业的高速发展，使得退役动力电池的梯次利用与贵金属绿色回收成为了关键的环保议题。',
        pinyin: 'Xīnnéngyuán qìchē chǎnyè de gāosù fāzhǎn, shǐde tuìyì dònglì diànchí de tīcì lìyòng yǔ guìjīnshǔ lǜsè huíshōu chéngwéi le guānjiàn de huánbǎo yìtí.',
        meaning_vi: 'Sự phát triển vượt bậc của ngành xe điện mới khiến cho việc sử dụng tuần hoàn và tái chế xanh kim loại quý từ pin năng lượng hết niên hạn trở thành một chủ đề môi trường then chốt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2512,
    hanzi: '汇率',
    pinyin: 'huìlǜ',
    word_type: 'Danh từ',
    meaning_vi: 'tỷ giá hối đoái, tỷ giá',
    examples: [
      {
        chinese: '出国旅游前，最好提前了解一下当地货币与本币的兑换汇率。',
        pinyin: 'Chūguó lǚyóu qián, zuìhǎo tíqián liǎojiě yíxià dāngdì huòbì yǔ běnbì de duìhuàn huìlǜ.',
        meaning_vi: 'Trước khi đi du lịch nước ngoài, tốt nhất nên tìm hiểu trước tỷ giá chuyển đổi giữa đồng tiền bản địa và nội tệ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '进出口外贸企业通常利用远期外汇合约等金融衍生品，来对冲国际汇率剧烈波动所带来的财务风险。',
        pinyin: 'Jìn-chūkǒu wàimào qǐyè tōngcháng lìyòng yuǎnqī wàihuì héyuē děng jīnróng yǎnshēngpǐn, lái duìchōng guójì huìlǜ jùliè bōdòng suǒ dàilái de cáiwù fēngxiǎn.',
        meaning_vi: 'Các doanh nghiệp ngoại thương xuất nhập khẩu thường vận dụng các công cụ phái sinh tài chính như hợp đồng ngoại hối kỳ hạn để phòng ngừa rủi ro tài chính do biến động tỷ giá quốc tế mạnh gây ra.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2513,
    hanzi: '婚礼',
    pinyin: 'hūnlǐ',
    word_type: 'Danh từ',
    meaning_vi: 'hôn lễ, đám cưới',
    examples: [
      {
        chinese: '亲朋好友齐聚一堂，共同见证并祝福这对新人的浪漫婚礼。',
        pinyin: 'Qīnpéng-hǎoyǒu qíjù-yìtáng, gòngtóng jiànzhèng bìng zhùfú zhè duì xīnrén de làngmàn hūnlǐ.',
        meaning_vi: 'Bạn bè và người thân tề tựu đông đủ để cùng nhau chứng kiến và chúc phúc cho hôn lễ lãng mạn của cặp đôi mới cưới.',
        difficulty_level: 'basic'
      },
      {
        chinese: '如今越来越多的年轻一代偏爱简约而富有文化内涵的中式传统婚礼，彰显出强烈的文化自信。',
        pinyin: 'Rújīn yuèláiyuè duō de niánqīng yídài piān’ài jiǎnyuē ér fùyǒu wénhuà nèihán de zhōngshì chuántǒng hūnlǐ, zhāngxiǎn chū qiángliè de wénhuà zìxìn.',
        meaning_vi: 'Ngày nay ngày càng nhiều bạn trẻ ưa chuộng những đám cưới truyền thống kiểu Trung Hoa tối giản mà đậm đà chiều sâu văn hóa, thể hiện niềm tự tin văn hóa sâu sắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2514,
    hanzi: '伙',
    pinyin: 'huǒ',
    word_type: 'Lượng từ / Danh từ',
    meaning_vi: 'tốp, nhóm, bọn (lượng từ); nhóm người, phường',
    examples: [
      {
        chinese: '公园的草坪上坐着一伙年轻人，正弹着吉他唱歌。',
        pinyin: 'Gōngyuán de cǎopíng shang zuò zhe yì huǒ niánqīngrén, zhèng tán zhe jítā chànggē.',
        meaning_vi: 'Trên bãi cỏ của công viên có một nhóm bạn trẻ đang ngồi vừa gảy đàn guitar vừa hát.',
        difficulty_level: 'basic'
      },
      {
        chinese: '公安机关经过数月缜密侦查，成功打掉了一个跨区域伪造销售假冒注册商标的犯罪团伙。',
        pinyin: 'Gōng’ān jīguān jīngguò shù yuè zhěnmì zhēnchá, chénggōng dǎdiào le yí gè kuà qūyù wěizào xiāoshòu jiǎmào zhùcè shāngbiāo de fànzuì tuánhuǒ.',
        meaning_vi: 'Cơ quan công an qua nhiều tháng điều tra tỉ mỉ đã triệt phá thành công một băng nhóm tội phạm xuyên khu vực chuyên làm giả và tiêu thụ nhãn hiệu đăng ký thương mại giả mạo.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2515,
    hanzi: '伙伴',
    pinyin: 'huǒbàn',
    word_type: 'Danh từ',
    meaning_vi: 'đối tác, bạn đồng hành, cộng sự',
    examples: [
      {
        chinese: '在求学道路上，能遇到志同道合的学习伙伴是一件很幸运的事。',
        pinyin: 'Zài qiúxué dàolù shang, néng yùdào zhìtóng-dàohé de xuéxí huǒbàn shì yí jiàn hěn xìngyùn de shì.',
        meaning_vi: 'Trên con đường học vấn, gặp được người bạn học cùng chung chí hướng là một điều vô cùng may mắn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '两国元首一致同意深化全面战略伙伴关系，推动经贸投资与人文交流合作迈上全新台阶。',
        pinyin: 'Liǎng guó yuánshǒu yízhì tóngyì shēnhuà quánmiàn zhànlüè huǒbàn guānxì, tuīdòng jīngmào tóuzī yǔ rénwén jiāoliú hézuò mài shàng quánxīn táijiē.',
        meaning_vi: 'Nguyên thủ hai nước nhất trí làm sâu sắc thêm quan hệ đối tác chiến lược toàn diện, thúc đẩy hợp tác đầu tư thương mại và giao lưu nhân văn bước lên tầm cao mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2516,
    hanzi: '火锅',
    pinyin: 'huǒguō',
    word_type: 'Danh từ',
    meaning_vi: 'lẩu, món lẩu',
    examples: [
      {
        chinese: '冬天天气寒冷的时候，全家人围坐在一起吃热气腾腾的火锅最惬意不过了。',
        pinyin: 'Dōngtiān tiānqì hánlěng de shíhou, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de huǒguō zuì qièyì búguò le.',
        meaning_vi: 'Khi tiết trời mùa đông se lạnh, cả nhà quây quần bên nhau ăn nồi lẩu bốc khói nghi ngút là điều sảng khoái nhất.',
        difficulty_level: 'basic'
      },
      {
        chinese: '川渝火锅凭借独特的麻辣风味和丰富的食材搭配，已成为中国餐饮文化走向全球的一张亮丽名片。',
        pinyin: 'Chuān-Yú huǒguō píngjiè dútè de málà fēngwèi hé fēngfù de shícái dāpèi, yǐ chéngwéi Zhōngguó cānyǐn wénhuà zǒuxiàng quánqiú de yì zhāng liànglì míngpiàn.',
        meaning_vi: 'Lẩu Tứ Xuyên - Trùng Khánh nhờ hương vị cay tê độc đáo và các nguyên liệu phối hợp phong phú đã trở thành tấm danh thiếp rạng rỡ đưa văn hóa ẩm thực Trung Hoa vươn ra thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2517,
    hanzi: '或是',
    pinyin: 'huòshì',
    word_type: 'Liên từ / Phó từ',
    meaning_vi: 'hoặc là, hay là',
    examples: [
      {
        chinese: '周末我通常在家里静心看书，或是约上三两好友去郊外散步。',
        pinyin: 'Zhōumò wǒ tōngcháng zài jiālǐ jìngxīn kànshū, huòshì yuē shàng sān-liǎng hǎoyǒu qù jiāowài sànbù.',
        meaning_vi: 'Cuối tuần tôi thường ở nhà yên tĩnh đọc sách, hoặc là rủ dăm ba người bạn thân đi tản bộ ngoại ô.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对日益剧烈的市场竞争，传统企业或是加速数字化转型升级，或是将被行业变革浪潮无情淘汰。',
        pinyin: 'Miànduì rìyì jùliè de shìchǎng jìngzhēng, chuántǒng qǐyè huòshì jiāsù shùzìhuà zhuǎnxíng shēngjí, huòshì jiāng bèi hángyè biàngé làngcháo wúqíng táotài.',
        meaning_vi: 'Đối mặt với sự cạnh tranh thị trường ngày càng khốc liệt, các doanh nghiệp truyền thống hoặc là đẩy nhanh chuyển đổi nâng cấp số, hoặc là sẽ bị làn sóng cải cách ngành nghề đào thải không thương tiếc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2518,
    hanzi: '货物',
    pinyin: 'huòwù',
    word_type: 'Danh từ',
    meaning_vi: 'hàng hóa',
    examples: [
      {
        chinese: '装卸工人们正动作熟练地将整箱货物搬运进大型卡车里。',
        pinyin: 'Zhuāngxiè gōngrénmen zhèng dòngzuò shúliàn de jiāng zhěng xiāng huòwù bānyùn jìn dàxíng kǎchē lǐ.',
        meaning_vi: 'Những công nhân bốc vác đang nhanh nhẹn bốc dỡ các thùng hàng nguyên đai nguyên kiện lên chiếc xe tải lớn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中欧班列的高效常态化开行，为亚欧大陆之间高附加值货物的跨国联运提供了安全可靠的绿色通道。',
        pinyin: 'Zhōng-Ōu bānliè de gāoxiào chángtàihuà kāixíng, wèi Yà-Ōu dàlù zhījiān gāo fùjiāzhí huòwù de kuàguó liányùn tígōng le ānquán kěkào de lǜsè tōngdào.',
        meaning_vi: 'Tuyến tàu hàng liên vận Trung Quốc - châu Âu vận hành định kỳ hiệu quả cao đã cung cấp một hành lang xanh an toàn đáng tin cậy cho việc vận tải hàng hóa giá trị gia tăng cao giữa hai lục địa Á - Âu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2519,
    hanzi: '或许',
    pinyin: 'huòxǔ',
    word_type: 'Phó từ',
    meaning_vi: 'có lẽ, có thể, biết đâu',
    examples: [
      {
        chinese: '他今天迟到了，或许是因为路上遇到了突发的交通堵塞。',
        pinyin: 'Tā jīntiān chídào le, huòxǔ shì yīnwèi lùshang yùdào le tūfā de jiāotōng dǔsè.',
        meaning_vi: 'Hôm nay anh ấy đến muộn, có lẽ là do trên đường gặp sự cố tắc đường đột xuất.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对眼前的复杂困局，暂时放慢脚步从全局视角重新审视策略，或许能找到柳暗花明的突破口。',
        pinyin: 'Miànduì yǎnqián de fùzá kùnjú, zànshí fàngmàn jiǎobù cóng quánjú shìjiǎo chóngxīn shěnshì cèlüè, huòxǔ néng zhǎodào liǔ’àn-huāmíng de tūpòkǒu.',
        meaning_vi: 'Đứng trước tình thế khó khăn phức tạp trước mắt, tạm thời chậm lại một nhịp để nhìn nhận lại chiến lược từ góc nhìn toàn cục, biết đâu lại có thể tìm ra bước đột phá mở ra lối thoát mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2520,
    hanzi: '机构',
    pinyin: 'jīgòu',
    word_type: 'Danh từ',
    meaning_vi: 'cơ cấu, cơ quan, tổ chức, thiết chế',
    examples: [
      {
        chinese: '这所语言培训机构在外语教学方面拥有多年丰富的教学经验。',
        pinyin: 'Zhè suǒ yǔyán péixùn jīgòu zài wàiyǔ jiàoxué fāngmiàn yōngyǒu duō nián fēngfù de jiàoxué jīngyàn.',
        meaning_vi: 'Cơ sở đào tạo ngôn ngữ này có nhiều năm kinh nghiệm phong phú trong giảng dạy ngoại ngữ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '市政府联合多家权威科研机构与高校，共同组建了专注于前沿人工智能科技攻关的联合实验室。',
        pinyin: 'Shì zhèngfǔ liánhé duō jiā quánwēi kēyán jīgòu yǔ gāoxiào, gòngtóng zǔjiàn le zhuānzhù yú qiányán réngōng zhìnéng kējì gōngguān de liánhé shíyànshì.',
        meaning_vi: 'Chính quyền thành phố đã liên kết với nhiều viện nghiên cứu khoa học uy tín và các trường đại học để thành lập phòng thí nghiệm liên kết chuyên nghiên cứu đột phá công nghệ trí tuệ nhân tạo tiên phong.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2521,
    hanzi: '激烈',
    pinyin: 'jīliè',
    word_type: 'Tính từ',
    meaning_vi: 'kịch liệt, quyết liệt, gay gắt',
    examples: [
      {
        chinese: '两支强队在决赛中展开了一场十分激烈的争夺。',
        pinyin: 'Liǎng zhī qiángduì zài juésài zhōng zhǎnkāi le yì chǎng shífēn jīliè de zhēngduó.',
        meaning_vi: 'Hai đội mạnh đã có một màn tranh tài vô cùng quyết liệt trong trận chung kết.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对全球新能源汽车市场白热化的激烈竞争，技术自主创新与卓越的用户体验是企业立于不败之地的根本基石。',
        pinyin: 'Miànduì quánqiú xīnnéngyuán qìchē shìchǎng báirèhuà de jīliè jìngzhēng, jìshù zìzhǔ chuàngxīn yǔ zhuóyuè de yònghù tǐyàn shì qǐyè lìyú búbàizhīdì de gēnběn jīshí.',
        meaning_vi: 'Đối mặt với sự cạnh tranh gay gắt đến mức đỉnh điểm trên thị trường xe điện toàn cầu, việc tự chủ đổi mới công nghệ và trải nghiệm khách hàng xuất sắc là nền tảng cốt lõi giúp doanh nghiệp đứng vững.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2522,
    hanzi: '机器',
    pinyin: 'jīqì',
    word_type: 'Danh từ',
    meaning_vi: 'máy móc, cỗ máy',
    examples: [
      {
        chinese: '工人们正在严格按照操作规程维护保养这台进口机器。',
        pinyin: 'Gōngrénmen zhèngzài yángé ànzhào cāozuò guīchéng wéihù bǎoyǎng zhè tái jìnkǒu jīqì.',
        meaning_vi: 'Các công nhân đang nghiêm túc tuân thủ quy trình thao tác để bảo trì cỗ máy nhập khẩu này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高精密度工业制造依赖于自动化数控机器的毫厘不差，任何微小误差都可能影响尖端元件的良品率。',
        pinyin: 'Gāo jīngmìdù gōngyè zhìzào yīlài yú zìdònghuà shùkòng jīqì de háolí-bùchà, rènhé wéixiǎo wùchā dōu kěnéng yǐngxiǎng jiānduān yuánjiàn de liángpǐnlǜ.',
        meaning_vi: 'Sản xuất công nghiệp độ chính xác cao phụ thuộc vào sự chuẩn xác từng li từng tí của máy CNC tự động, bất kỳ sai số nhỏ nào cũng có thể ảnh hưởng đến tỷ lệ đạt chuẩn của linh kiện cao cấp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2523,
    hanzi: '机器人',
    pinyin: 'jīqìrén',
    word_type: 'Danh từ',
    meaning_vi: 'người máy, robot',
    examples: [
      {
        chinese: '家里的扫地机器人每天定时清扫地面，帮我省去了很多做家务的时间。',
        pinyin: 'Jiā lǐ de sǎodì jīqìrén měi tiān dìngshí qīngsǎo dìmbiàn, bāng wǒ shěngqù le hěn duō zuò jiāwù de shíjiān.',
        meaning_vi: 'Robot hút bụi trong nhà mỗi ngày đều lau dọn sàn nhà theo giờ đã hẹn, giúp tôi tiết kiệm được rất nhiều thời gian làm việc nhà.',
        difficulty_level: 'basic'
      },
      {
        chinese: '医疗领域的手术辅助机器人凭借精准的操作控制，能够协助外科医生在微创条件下完成极为复杂的心脑血管手术。',
        pinyin: 'Yīliáo lǐngyù de shǒushù fǔzhù jīqìrén píngjiè jīngzhǔn de cāozuò kòngzhì, nénggòu xiézhù wàikē yīshēng zài wēichuàng tiáojiàn xià wánchéng jíwéi fùzá de xīn-nǎoxiěguǎn shǒushù.',
        meaning_vi: 'Robot hỗ trợ phẫu thuật trong lĩnh vực y tế nhờ khả năng thao tác điều khiển chính xác có thể trợ giúp các bác sĩ ngoại khoa thực hiện các ca phẫu thuật tim mạch và mạch máu não vô cùng phức tạp theo phương pháp xâm lấn tối thiểu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2524,
    hanzi: '肌肉',
    pinyin: 'jīròu',
    word_type: 'Danh từ',
    meaning_vi: 'cơ bắp, cơ thịt',
    examples: [
      {
        chinese: '剧烈运动之后如果不做拉伸，很容易引起第二天肌肉酸痛。',
        pinyin: 'Jùliè yùndòng zhīhòu rúguǒ bú zuò lāshēn, hěn róngyì yǐnqǐ dì-èr tiān jīròu suāntòng.',
        meaning_vi: 'Sau khi vận động mạnh nếu không giãn cơ thì rất dễ dẫn đến việc đau nhức cơ bắp vào ngày hôm sau.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科学的力量训练搭配高蛋白均衡营养膳食，能够有效促进骨骼肌纤维的修复与核心肌肉力量的增长。',
        pinyin: 'Kēxué de lìliàng xùnliàn dāpèi gāo dànbái jūnhéng yíngyǎng shànshí, nénggòu yǒuxiào cùjìn gǔgéjī xiānwéi de xiūfù yǔ héxīn jīròu lìliàng de zēngzhǎng.',
        meaning_vi: 'Rèn luyện sức mạnh khoa học kết hợp với chế độ ăn uống giàu protein cân bằng dinh dưỡng có thể thúc đẩy hiệu quả việc phục hồi các sợi cơ xương và gia tăng sức mạnh của nhóm cơ cốt lõi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2525,
    hanzi: '及',
    pinyin: 'jí',
    word_type: 'Liên từ',
    meaning_vi: 'và, cùng, cũng như',
    examples: [
      {
        chinese: '请大家提前准备好身份证、护照及相关的证明材料。',
        pinyin: 'Qǐng dàjiā tíqián zhǔnbèi hǎo shēnfènzhèng, hùzhào jí xiāngguān de zhèngmíng cáiliào.',
        meaning_vi: 'Xin mọi người hãy chuẩn bị sẵn chứng minh thư, hộ chiếu cũng như các giấy tờ chứng minh có liên quan.',
        difficulty_level: 'basic'
      },
      {
        chinese: '本公约旨在加强签约国在环境保护、生物多样性保护及绿色低碳技术转移领域的全面务实合作。',
        pinyin: 'Běn gōngyuē zhǐzài jiāqiáng qiānyuēguó zài huánjìng bǎohù, shēngwù duōyàngxìng bǎohù jí lǜsè dītàn jìshù zhuǎnyí lǐngyù de quánmiàn wùshí hézuò.',
        meaning_vi: 'Công ước này nhằm tăng cường sự hợp tác thiết thực toàn diện giữa các quốc gia ký kết trong các lĩnh vực bảo vệ môi trường, bảo tồn đa dạng sinh học và chuyển giao công nghệ xanh ít carbon.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2526,
    hanzi: '级',
    pinyin: 'jí',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'cấp bậc, hạng, lớp, mức độ; bậc (thang)',
    examples: [
      {
        chinese: '他经过半年的努力备考，终于顺利通过了汉语水平考试五级。',
        pinyin: 'Tā jīngguò bàn nián de nǔlì bèikǎo, zhōngyú shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì Wǔ Jí.',
        meaning_vi: 'Qua nửa năm nỗ lực ôn thi, anh ấy cuối cùng đã thuận lợi thi đỗ kỳ thi Năng lực Hán ngữ cấp 5.',
        difficulty_level: 'basic'
      },
      {
        chinese: '气象台发布了台风最高级别的红色预警信号，沿海各地已紧急启动防汛抗台一级应急响应机制。',
        pinyin: 'Qìxiàngtái fābù le táifēng zuì gāo jíbié de hóngsè yùjǐng xìnhào, yánhǎi gèdì yǐ jǐnjí qǐdòng fángxùn-kàngtái yī jí yīngjí xiǎngyìng jīzhì.',
        meaning_vi: 'Đài khí tượng đã phát tín hiệu cảnh báo bão cấp đỏ cao nhất, các địa phương ven biển đã khẩn trương kích hoạt cơ chế ứng phó khẩn cấp cấp độ một về phòng chống lụt bão.',
        difficulty_level: 'applied'
      }
    ]
  }
]
