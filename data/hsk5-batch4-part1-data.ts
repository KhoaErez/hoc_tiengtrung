// data/hsk5-batch4-part1-data.ts
// 25 từ HSK 5: #2302 [短期] -> #2326 [法院]

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

export const HSK5_BATCH4_PART1: VocabItem[] = [
  {
    id: 2302,
    hanzi: '短期',
    pinyin: 'duǎnqī',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'ngắn hạn, thời gian ngắn',
    examples: [
      {
        chinese: '他在大学期间报名参加了为期一个月的短期法语培训班。',
        pinyin: 'Tā zài dàxué qījiān bàomíng cānjiā le wéiqī yí gè yuè de duǎnqī Fǎyǔ péixùnbān.',
        meaning_vi: 'Trong thời gian học đại học, anh ấy đã đăng ký tham gia một lớp đào tạo tiếng Pháp ngắn hạn kéo dài một tháng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业在制定战略时不能只顾追求短期利润，更应注重长期品牌价值的积累与科研创新投入。',
        pinyin: 'Qǐyè zài zhìdìng zhànlüè shí bù néng zhǐ gù zhuīqiú duǎnqī lìrùn, gèng yīng zhùzhòng chángqī pǐnpái jiàzhí de jīlěi yǔ kēyán chuàngxīn tóurù.',
        meaning_vi: 'Doanh nghiệp khi hoạch định chiến lược không thể chỉ mải mê theo đuổi lợi nhuận ngắn hạn, mà càng cần phải coi trọng việc tích lũy giá trị thương hiệu lâu dài và đầu tư cho đổi mới nghiên cứu khoa học.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2303,
    hanzi: '断',
    pinyin: 'duàn',
    word_type: 'Động từ',
    meaning_vi: 'đứt, ngắt, cắt đứt, gián đoạn',
    examples: [
      {
        chinese: '由于暴风雨的袭击，这根高压电线被大树砸断了。',
        pinyin: 'Yóuyú bàofēngyǔ de xíjī, zhè gēn gāoyā diànxiàn bèi dàshù zá duàn le.',
        meaning_vi: 'Do bị cơn bão tấn công, đường dây điện cao thế này đã bị cây to đè đứt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '突如其来的地震导致当地交通与通信网络彻底中断，救援队正克服重重困难全力抢通生命通道。',
        pinyin: 'Tūrúqílái de dìzhèn dǎozhì dāngdì jiāotōng yǔ tōngxìn wǎngluò chèdǐ zhōngduàn, jiùyuánduì zhèng kèfú chóngchóng kùnnan quánlì qiǎngtōng shēngmìng tōngdào.',
        meaning_vi: 'Trận động đất bất ngờ ập đến khiến mạng lưới giao thông và viễn thông địa phương bị gián đoạn hoàn toàn, đội cứu hộ đang vượt qua muôn vàn khó khăn dốc toàn lực khai thông huyết mạch sự sống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2304,
    hanzi: '堆',
    pinyin: 'duī',
    word_type: 'Động từ / Danh từ / Lượng từ',
    meaning_vi: 'đống, chất đống, đắp (tuyết)',
    examples: [
      {
        chinese: '冬天下大雪的时候，孩子们最喜欢在院子里堆雪人。',
        pinyin: 'Dōngtiān xià dàxuě de shíhou, háizimen zuì xǐhuan zài yuànzi lǐ duī xuěrén.',
        meaning_vi: 'Vào mùa đông khi tuyết rơi dày, lũ trẻ thích nhất là đắp người tuyết trong sân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '办公桌上堆满了各部门刚刚递交上来的年度总结报告，等待总经理逐一审核批复。',
        pinyin: 'Bàngōngzhuō shàng duī mǎn le gè bùmén gānggāng dìjiāo shànglái de niándù zǒngjié bàogào, děngdài zǒngjīnglǐ zhúyī shěnhè pīfù.',
        meaning_vi: 'Trên bàn làm việc chất đầy các báo cáo tổng kết thường niên do các phòng ban vừa nộp lên, đang chờ tổng giám đốc xem xét duyệt từng bản một.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2305,
    hanzi: '对比',
    pinyin: 'duìbǐ',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'so sánh, đối chiếu, sự tương phản',
    examples: [
      {
        chinese: '把这两份方案放在一起对比，优缺点就一目了然了。',
        pinyin: 'Bǎ zhè liǎng fèn fāng’àn fàng zài yìqǐ duìbǐ, yōukuēdiǎn jiù yí mù liǎorán le.',
        meaning_vi: 'Đặt hai phương án này cùng nhau so sánh đối chiếu thì ưu khuyết điểm sẽ rõ ràng ngay tức khắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '经过严谨的数据横向对比与回归分析，研究团队终于找到了导致设备运行故障的核心原因。',
        pinyin: 'Jīngguò yǎnjǐn de shùjù héngxiàng duìbǐ yǔ huíguī fēnxī, yánjiū tuánduì zhōngyú zhǎodào le dǎozhì shèbèi yùnxíng gùzhàng de héxīn yuányīn.',
        meaning_vi: 'Qua quá trình đối chiếu ngang dữ liệu và phân tích hồi quy chặt chẽ, nhóm nghiên cứu cuối cùng đã tìm ra nguyên nhân cốt lõi dẫn đến sự cố vận hành của thiết bị.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2306,
    hanzi: '对待',
    pinyin: 'duìdài',
    word_type: 'Động từ',
    meaning_vi: 'đối xử, đối đãi, nhìn nhận thái độ đối với',
    examples: [
      {
        chinese: '无论面对什么职业的人，我们都应该平等、礼貌地对待。',
        pinyin: 'Wúlùn miànduì shénme zhíyè de rén, wǒmen dōu yīnggāi píngděng, lǐmào de duìdài.',
        meaning_vi: 'Bất luận đối mặt với người làm nghề nghiệp gì, chúng ta đều nên đối xử một cách bình đẳng và lịch sự.',
        difficulty_level: 'basic'
      },
      {
        chinese: '优秀的科研人员应当以极其严谨务实的科学态度对待每一次实验数据中的微小偏差。',
        pinyin: 'Yōuxiù de kēyán rényuán yīngdāng yǐ jíqí yǎnjǐn wùshí de kēxué tàidù duìdài měi yí cì shíyàn shùjù zhōng de wēixiǎo piānchā.',
        meaning_vi: 'Những nhân sự nghiên cứu khoa học xuất sắc cần phải nhìn nhận đối đãi với từng sai số nhỏ nhặt trong số liệu thí nghiệm bằng thái độ khoa học cực kỳ cẩn trọng và thực tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2307,
    hanzi: '对手',
    pinyin: 'duìshǒu',
    word_type: 'Danh từ',
    meaning_vi: 'đối thủ, địch thủ',
    examples: [
      {
        chinese: '在明天的羽毛球决赛中，他将遭遇实力强劲的老对手。',
        pinyin: 'Zài míngtiān de yǔmáoqiú juésài zhōng, tā jiāng zāoyù shílì qiángjìng de lǎo duìshǒu.',
        meaning_vi: 'Trong trận chung kết cầu lông ngày mai, anh ấy sẽ đụng độ người đối thủ kỳ cựu có thực lực rất đáng gờm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在竞争日益白热化的全球新能源汽车市场上，尊重对手并持续自我革新是立于不败之地的根本之道。',
        pinyin: 'Zài jìngzhēng rìyì báirèhuà de quánqiú xīn néngyuán qìchē shìchǎng shàng, zūnzhòng duìshǒu bìng chíxù zìwǒ géxīn shì lì yú búbàizhīdì de gēnběn zhī dào.',
        meaning_vi: 'Trên thị trường xe năng lượng mới toàn cầu cạnh tranh ngày càng gay gắt, tôn trọng đối thủ và không ngừng tự đổi mới chính là con đường căn bản để đứng vững ở thế bất bại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2308,
    hanzi: '队伍',
    pinyin: 'duìwu',
    word_type: 'Danh từ',
    meaning_vi: 'đội ngũ, hàng ngũ, đoàn người',
    examples: [
      {
        chinese: '运动会开幕式上，各班级的方阵队伍迈着整齐的步伐走过主席台。',
        pinyin: 'Yùndònghuì kāimùshì shàng, gè bānjí de fāngzhèn duìwu màizhe zhěngqí de bùfá zǒuguò zhǔxítái.',
        meaning_vi: 'Tại lễ khai mạc đại hội thể thao, các đội hình khối của từng lớp bước đi đều tăm tắp qua lễ đài.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为了迎接数字化转型带来的机遇与挑战，集团决定花大力气建设一支高水平的跨国技术人才队伍。',
        pinyin: 'Wèile yíngjiē shùzìhuà zhuǎnxíng dài lái de jīyù yǔ tiǎozhàn, jítuán juédìng huā dà lìqi jiànshè yì zhī gāoshuǐpíng de kuàguó jìshù réncái duìwu.',
        meaning_vi: 'Nhằm đón đầu cơ hội và thách thức do chuyển đổi số mang lại, tập đoàn quyết định bỏ ra nhiều tâm sức để xây dựng một đội ngũ nhân tài công nghệ xuyên quốc gia trình độ cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2309,
    hanzi: '对象',
    pinyin: 'duìxiàng',
    word_type: 'Danh từ',
    meaning_vi: 'đối tượng, người yêu',
    examples: [
      {
        chinese: '他工作一直很忙，至今还没有找对象。',
        pinyin: 'Tā gōngzuò yìzhí hěn máng, zhìjīn hái méiyǒu zhǎo duìxiàng.',
        meaning_vi: 'Công việc của anh ấy lúc nào cũng bận rộn, đến nay vẫn chưa tìm đối tượng người yêu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '本次问卷调查的主要研究对象是在一线城市自主创业的青年群体。',
        pinyin: 'Běn cì wènjuàn diàochá de zhǔyào yánjiū duìxiàng shì zài yīxiàn chéngshì zìzhǔ chuàngyè de qīngnián qúntǐ.',
        meaning_vi: 'Đối tượng nghiên cứu chính của cuộc khảo sát bảng hỏi lần này là nhóm thanh niên tự thân khởi nghiệp tại các thành phố hạng nhất.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2310,
    hanzi: '吨',
    pinyin: 'dūn',
    word_type: 'Lượng từ',
    meaning_vi: 'tấn (đơn vị đo khối lượng)',
    examples: [
      {
        chinese: '这辆重型卡车的最大荷载量是三十吨。',
        pinyin: 'Zhè liàng zhòngxíng kǎchē de zuìdà hèzǎiliàng shì sānshí dūn.',
        meaning_vi: 'Tải trọng tối đa của chiếc xe tải hạng nặng này là ba mươi tấn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该钢铁集团今年通过节能减排技术改造，年节约标煤达数十万吨，大幅降低了碳排放总量。',
        pinyin: 'Gāi gāngtiě jítuán jīnnián tōngguò jiénéng jiǎnpái jìshù gǎizào, nián jiéyuē biāoméi dá shù shí wàn dūn, dàfú jiàngdī le tàn páifàng zǒngliàng.',
        meaning_vi: 'Tập đoàn gang thép này năm nay thông qua cải tạo kỹ thuật tiết kiệm năng lượng giảm phát thải, đã tiết kiệm được hàng trăm nghìn tấn than tiêu chuẩn mỗi năm, giảm mạnh tổng lượng phát thải carbon.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2311,
    hanzi: '朵',
    pinyin: 'duǒ',
    word_type: 'Lượng từ',
    meaning_vi: 'đóa, bông, đám (mây)',
    examples: [
      {
        chinese: '蓝蓝的天空上飘着几朵洁白的白云，景色美极了。',
        pinyin: 'Lánlán de tiānkōng shàng piāo zhe jǐ duǒ jiébái de báiyún, jǐngsè měi jí le.',
        meaning_vi: 'Trên bầu trời trong xanh lơ lửng vài đám mây trắng tinh khôi, phong cảnh đẹp tuyệt trần.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在毕业典礼上，学生代表手捧一朵朵盛开的鲜花，恭敬地献给辛勤耕耘的恩师们。',
        pinyin: 'Zài bìyè diǎnlǐ shàng, xuésheng dàibiǎo shǒu pěng yì duǒ duǒ shèngkāi de xiānhuā, gōngjìng de xiàn gěi xīnqín gēngyún de ēnshī men.',
        meaning_vi: 'Tại lễ tốt nghiệp, các đại diện học sinh hai tay nâng từng đóa hoa tươi nở rộ, cung kính dâng tặng những người thầy cô ơn sâu đã miệt mài gieo mầm tri thức.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2312,
    hanzi: '躲',
    pinyin: 'duǒ',
    word_type: 'Động từ',
    meaning_vi: 'trốn, né tránh, ẩn náu',
    examples: [
      {
        chinese: '突然下起了倾盆大雨，路上的行人们纷纷跑进商店屋檐下躲雨。',
        pinyin: 'Tūrán xià qǐ le qīngpén dàyǔ, lù shàng de xíngrénmen fēnfēn pǎo jìn shāngdiàn wūyán xià duǒ yǔ.',
        meaning_vi: 'Bất chợt đổ mưa rào như trút nước, người đi bộ trên đường tới tấp chạy vào dưới mái hiên cửa hàng để trú mưa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对工作中的失误与责任，成熟的职场人应该勇于承担并提出解决方案，而不是一味地逃避和躲藏。',
        pinyin: 'Miànduì gōngzuò zhōng de shīwù yǔ zérèn, chéngshú de zhíchǎngrén yīnggāi yǒngyú chéngdān bìng tíchū jiějué fāng’àn, ér búshì yíwèi de táobì hé duǒcáng.',
        meaning_vi: 'Khi đối mặt với sai sót và trách nhiệm trong công việc, người đi làm chín chắn nên dũng cảm gánh vác và đưa ra phương án giải quyết, chứ không phải một mực trốn tránh và lẩn trốn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2313,
    hanzi: '儿女',
    pinyin: 'érnǚ',
    word_type: 'Danh từ',
    meaning_vi: 'con cái, con trai con gái',
    examples: [
      {
        chinese: '父母含辛茹苦一辈子，最大的心愿就是看着儿女健康平安。',
        pinyin: 'Fùmǔ hánxīnrǔkǔ yíbèizi, zuì dà de xīnyuàn jiù shì kàn zhe érnǚ jiànkāng píng’ān.',
        meaning_vi: 'Cha mẹ ngậm đắng nuốt cay cả một đời, tâm nguyện lớn nhất chính là nhìn con cái khỏe mạnh bình an.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中华儿女在面对外来挑战与自然灾害时，总能万众一心、众志成城，展现出无比坚韧的民族凝聚力。',
        pinyin: 'Zhōnghuá érnǚ zài miànduì wàilái tiǎozhàn yǔ zìrán zāihài shí, zǒng néng wànzhòngyīxīn, zhòngzhìchéngchéng, zhǎnxiàn chū wúbǐ jiānrèn de mínzú níngjùlì.',
        meaning_vi: 'Những người con đất nước khi đối mặt với thách thức từ bên ngoài và thiên tai địch họa, luôn có thể muôn người như một, triệu người đồng lòng, thể hiện sức mạnh gắn kết dân tộc kiên cường khôn xiết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2314,
    hanzi: '二手',
    pinyin: 'èrshǒu',
    word_type: 'Tính từ',
    meaning_vi: 'cũ, qua tay, đồ đã qua sử dụng',
    examples: [
      {
        chinese: '为了省钱，他在二手交易平台上买了一辆成色不错的山地自行车。',
        pinyin: 'Wèile shěngqián, tā zài èrshǒu jiāoyì píngtái shàng mǎi le yí liàng chéngsè búcuò de shāndì zìxíngchē.',
        meaning_vi: 'Để tiết kiệm tiền, anh ấy đã mua một chiếc xe đạp leo núi còn khá mới trên nền tảng giao dịch đồ cũ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '二手车电商平台通过引入第三方专业机构的严格检测机制，有效解决了买卖双方之间的信息不对称难题。',
        pinyin: 'Èrshǒuchē diànshāng píngtái tōngguò yǐnrù dì-sān fāng zhuānyè jīgòu de yángé jiǎncè jīzhì, yǒuxiào jiějué le mǎimài shuāngfāng zhījiān de xìnxī bú duìchèn nántí.',
        meaning_vi: 'Sàn thương mại điện tử xe ô tô cũ thông qua việc đưa vào cơ chế kiểm định nghiêm ngặt từ cơ quan chuyên môn bên thứ ba, đã giải quyết hiệu quả bài toán bất cân xứng thông tin giữa hai bên mua bán.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2315,
    hanzi: '二维码',
    pinyin: 'èrwéimǎ',
    word_type: 'Danh từ',
    meaning_vi: 'mã QR, mã hai chiều',
    examples: [
      {
        chinese: '请您打开手机微信扫描收银台上的二维码完成付款。',
        pinyin: 'Qǐng nín dǎkāi shǒujī Wēixìn sǎomiáo shōuyíntái shàng de èrwéimǎ wánchéng fùkuǎn.',
        meaning_vi: 'Xin mời quý khách mở WeChat trên điện thoại quét mã QR trên quầy thu ngân để hoàn tất thanh toán.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着移动互联技术的普及，动态加密二维码在身份认证、电子门禁以及跨境移动支付等场景中得到了广泛应用。',
        pinyin: 'Suízhe yídòng hùlián jìshù de pǔjí, dòngtài jiāmì èrwéimǎ zài shēnfèn rènzhèng, diànzǐ ménjìn yǐjí kuàjìng yídòng zhìfù děng chǎngjǐng zhōng dédào le guǎngfàn yìngyòng.',
        meaning_vi: 'Cùng với sự phổ cập của công nghệ Internet di động, mã QR mã hóa động đã được ứng dụng rộng rãi trong các bối cảnh xác thực danh tính, kiểm soát cửa điện tử cũng như thanh toán di động xuyên biên giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2316,
    hanzi: '发表',
    pinyin: 'fābiǎo',
    word_type: 'Động từ',
    meaning_vi: 'phát biểu, công bố, đăng bài',
    examples: [
      {
        chinese: '校长在毕业典礼上发表了热情洋溢的讲话，激励毕业生勇往直前。',
        pinyin: 'Xiàozhǎng zài bìyè diǎnlǐ shàng fābiǎo le rèqíng yángyì de jiǎnghuà, jīlì bìyèshēng yǒngwǎngzhíqián.',
        meaning_vi: 'Hiệu trưởng đã có bài phát biểu tràn đầy nhiệt huyết tại lễ tốt nghiệp, khích lệ các sinh viên tốt nghiệp dũng cảm tiến về phía trước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该科研团队关于新型高效太阳能电池的研究成果已在国际顶级学术期刊上正式发表。',
        pinyin: 'Gāi kēyán tuánduì guānyú xīnxíng gāoxiào tàiyángnéng diànchí de yánjiū chéngguǒ yǐ zài guójì dǐngjí xuéshù qīkān shàng zhèngshì fābiǎo.',
        meaning_vi: 'Thành quả nghiên cứu về pin năng lượng mặt trời hiệu suất cao kiểu mới của nhóm nghiên cứu khoa học này đã chính thức được đăng tải trên tạp chí học thuật hàng đầu thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2317,
    hanzi: '发布',
    pinyin: 'fābù',
    word_type: 'Động từ',
    meaning_vi: 'phát hành, công bố (tin tức, sản phẩm, thông báo)',
    examples: [
      {
        chinese: '气象台刚刚发布了暴雨黄色预警信号，提醒市民出行注意安全。',
        pinyin: 'Qìxiàngtái gānggāng fābù le bàoyǔ huángsè yùjǐng xìnhào, tíxǐng shìmín chūxíng zhùyì ānquán.',
        meaning_vi: 'Đài khí tượng vừa mới phát đi tín hiệu cảnh báo mưa bão màu vàng, nhắc nhở người dân ra đường chú ý an toàn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在今晚举行的新品全球发布会上，该科技巨头正式对外发布了搭载最新自主研发人工智能芯片的旗舰手机。',
        pinyin: 'Zài jīnwǎn jǔxíng de xīnpǐn quánqiú fābùhuì shàng, gāi kējì jùtóu zhèngshì duìwài fābù le dāzǎi zuìxīn zìzhǔ yánfā réngōng zhìnéng xīanpiàn de qíjiàn shǒujī.',
        meaning_vi: 'Tại buổi lễ ra mắt sản phẩm mới toàn cầu tổ chức tối nay, gã khổng lồ công nghệ này đã chính thức công bố chiếc điện thoại flagship trang bị chip trí tuệ nhân tạo mới nhất do chính họ tự nghiên cứu phát triển.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2318,
    hanzi: '发达',
    pinyin: 'fādá',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'phát triển, phát đạt, hưng thịnh',
    examples: [
      {
        chinese: '沿海城市由于地理位置优越，交通网络和对外贸易都非常发达。',
        pinyin: 'Yánhǎi chéngshì yóuyú dìlǐ wèizhì yōuyuè, jiāotōng wǎngluò hé duìwài màoyì dōu fēicháng fādá.',
        meaning_vi: 'Các thành phố ven biển nhờ vị trí địa lý đắc địa nên mạng lưới giao thông và ngoại thương đều hết sức phát triển.',
        difficulty_level: 'basic'
      },
      {
        chinese: '凭借高度发达的高端制造业产业链与雄厚的科研实力，该工业园区已成为全国重要的现代创新高地。',
        pinyin: 'Píngjiè gāodù fādá de gāoduān zhìzàoyè chǎnyèliàn yǔ xiónghòu de kēyán shílì, gāi gōngyè yuánqū yǐ chéngwéi quánguó zhòngyào de xiàndài chuàngxīn gāodì.',
        meaning_vi: 'Nhờ chuỗi công nghiệp chế tạo cao cấp phát triển tột bậc cùng tiềm lực nghiên cứu khoa học hùng hậu, khu công nghiệp này đã trở thành vùng đất trọng điểm đổi mới sáng tạo hiện đại quan trọng của cả nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2319,
    hanzi: '发挥',
    pinyin: 'fāhuī',
    word_type: 'Động từ',
    meaning_vi: 'phát huy, vận dụng tối đa',
    examples: [
      {
        chinese: '在明天的比赛中，只要大家发挥出平时的正常训练水平就能取得好成绩。',
        pinyin: 'Zài míngtiān de bǐsài zhōng, zhǐyào dàjiā fāhuī chū píngshí de zhèngcháng xùnliàn shuǐpíng jiù néng qǔdé hǎo chéngjì.',
        meaning_vi: 'Trong trận đấu ngày mai, chỉ cần mọi người phát huy được đúng trình độ rèn luyện bình thường là có thể đạt thành tích tốt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '团队管理者要善于发现每位员工的独特优势，创造良好环境以充分发挥团队成员的创新潜能。',
        pinyin: 'Tuánduì guǎnlǐzhě yào shànyú fāxiàn měi wèi yuángōng de dútè yōushì, chuàngzào liánghǎo huánjìng yǐ chōngfèn fāhuī tuánduì chéngyuán de chuàngxīn qiánnéng.',
        meaning_vi: 'Người quản lý đội ngũ cần phải biết cách nhìn ra ưu thế độc đáo của từng nhân viên, tạo dựng môi trường thuận lợi nhằm phát huy trọn vẹn tiềm năng đổi mới sáng tạo của các thành viên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2320,
    hanzi: '发明',
    pinyin: 'fāmíng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phát minh, sáng chế',
    examples: [
      {
        chinese: '造纸术是中国古代四大发明之一，对人类文明产生了深远影响。',
        pinyin: 'Zàozhǐshù shì Zhōngguó gǔdài sì dà fāmíng zhī yī, duì rénlèi wénmíng chǎnshēng le shēnyuǎn yǐngxiǎng.',
        meaning_vi: 'Nghệ thuật làm giấy là một trong bốn phát minh lớn thời cổ đại của Trung Quốc, đã tạo ra ảnh hưởng sâu xa đối với nền văn minh nhân loại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该科研团队历时五年发明的新型环保降解材料，已成功申请国家发明专利并投入规模化产业量产。',
        pinyin: 'Gāi kēyán tuánduì lìshí wǔ nián fāmíng de xīnxíng huánbǎo jiàngjiě cáiliào, yǐ chénggōng shēnqǐng guójiā fāmíng zhuānlì bìng tóurù guīmóhuà chǎnyè liàngchǎn.',
        meaning_vi: 'Vật liệu tự phân hủy thân thiện môi trường kiểu mới do nhóm nghiên cứu phát minh sau 5 năm đã được cấp bằng sáng chế phát minh cấp quốc gia và đưa vào sản xuất hàng loạt quy mô công nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2321,
    hanzi: '发起',
    pinyin: 'fāqǐ',
    word_type: 'Động từ',
    meaning_vi: 'phát động, khởi xướng, đứng ra tổ chức',
    examples: [
      {
        chinese: '学生会向全校师生发起了一次为贫困山区小学捐赠图书的爱心倡议。',
        pinyin: 'Xuéshēnghuì xiàng quán xiào shīshēng fāqǐ le yí cì wèi pínkùn shānqū xiǎoxué juānzèng túshū de àixīn chàngyì.',
        meaning_vi: 'Hội sinh viên đã phát động tới toàn thể giáo viên và học sinh toàn trường một sáng kiến nhân ái quyên góp sách cho trường tiểu học vùng núi nghèo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '由多家行业领军企业联合发起成立的绿色低碳产业联盟，旨在共同制定国际领先的可持续发展行业标准。',
        pinyin: 'Yóu duō jiā hángyè lǐngjūn qǐyè liánhé fāqǐ chénglì de lǜsè dītàn chǎnyè liánméng, zhǐ zài gòngtóng zhìdìng guójì lǐngxiān de kěchíxù fāzhǎn hángyè biāozhǔn.',
        meaning_vi: 'Liên minh ngành công nghiệp carbon thấp xanh do nhiều doanh nghiệp dẫn đầu trong ngành phối hợp khởi xướng thành lập, hướng tới mục tiêu cùng nhau xây dựng các tiêu chuẩn ngành phát triển bền vững đi đầu quốc tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2322,
    hanzi: '发言',
    pinyin: 'fāyán',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phát biểu ý kiến, lời phát biểu',
    examples: [
      {
        chinese: '如果在课堂讨论中有不同意见，欢迎大家积极举手发言。',
        pinyin: 'Rúguǒ zài kètáng tǎolùn zhōng yǒu bùtóng yìjiàn, huānyíng dàjiā jījí jǔshǒu fāyán.',
        meaning_vi: 'Nếu trong buổi thảo luận trên lớp có ý kiến bất đồng, hoan nghênh mọi người tích cực giơ tay phát biểu ý kiến.',
        difficulty_level: 'basic'
      },
      {
        chinese: '外交部新闻发言人在例行记者会上严正阐明了中方的基本立场，并就热点国际事务回答了各国记者的提问。',
        pinyin: 'Wàijiāobù xīnwén fāyánrén zài lìxíng jìzhěhuì shàng yánzhèng chǎnmíng le Zhōngfāng de jīběn lìchǎng, bìng jiù rèdiǎn guójì shìwù huídá le gè guó jìzhě de tíwèn.',
        meaning_vi: 'Người phát ngôn bộ ngoại giao tại buổi họp báo thường kỳ đã nêu rõ lập trường cơ bản nghiêm minh của phía Trung Quốc và trả lời câu hỏi của các phóng viên quốc tế về các vấn đề thời sự thế giới nóng bỏng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2323,
    hanzi: '发音',
    pinyin: 'fāyīn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phát âm, cách đọc âm',
    examples: [
      {
        chinese: '每天坚持跟着录音大声朗读，能够有效纠正外语的发音。',
        pinyin: 'Měitiān jiānchí gēn zhe lùyīn dàshēng lǎngdú, nénggòu yǒuxiào jiūzhèng wàiyǔ de fāyīn.',
        meaning_vi: 'Mỗi ngày kiên trì đọc to theo băng ghi âm có thể sửa phát âm ngoại ngữ một cách hiệu quả.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该语音评测系统利用深度神经网络算法，能够精准识别学习者在声调与元音发音细节上的细微偏差并给予专业指导。',
        pinyin: 'Gāi yǔyīn píngcè xìtǒng lìyòng shēndù shénjīng wǎngluò suànfǎ, nénggòu jīngzhǔn shíbié xuéxízhě zài shēngdiào yǔ yuányīn fāyīn xìjié shàng de xìwēi piānchā bìng jǐyǔ zhuānyè zhǐdǎo.',
        meaning_vi: 'Hệ thống đánh giá giọng nói này áp dụng thuật toán mạng nơ-ron sâu, có khả năng nhận diện chuẩn xác những độ lệch tinh vi trong chi tiết phát âm thanh điệu và nguyên âm của người học và đưa ra hướng dẫn chuyên nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2324,
    hanzi: '罚',
    pinyin: 'fá',
    word_type: 'Động từ',
    meaning_vi: 'phạt, trừng phạt, xử phạt',
    examples: [
      {
        chinese: '司机如果酒后驾驶机动车，必将受到交通法规的严厉处罚。',
        pinyin: 'Sījī rúguǒ jiǔhòu jiàshǐ jīdòngchē, bì jiāng shòudào jiāotōng fǎguī de yánlì chǔfá.',
        meaning_vi: 'Tài xế nếu lái xe cơ giới sau khi uống rượu bia thì chắc chắn sẽ bị pháp luật an toàn giao thông xử phạt nghiêm khắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '监管机构对于任何从事内幕交易、操纵证券市场的违法犯罪行为，都将依法从严查处、顶格重罚。',
        pinyin: 'Jiānguǎn jīgòu duìyú rènhé cóngshì nèimù jiāoyì, cāozòng zhèngquàn shìchǎng de wéifǎ fànzuì xíngwéi, dōu jiāng yīfǎ cóngyán cháchǔ, dǐnggé zhòngfá.',
        meaning_vi: 'Cơ quan giám sát đối với bất kỳ hành vi phạm pháp nào liên quan đến giao dịch nội gián hay thao túng thị trường chứng khoán, đều sẽ xử lý nghiêm theo pháp luật và phạt nặng ở khung kịch trần.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2325,
    hanzi: '罚款',
    pinyin: 'fákuǎn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phạt tiền, tiền phạt',
    examples: [
      {
        chinese: '他在禁止停车的路段违规停车，被交警依法处以两百元罚款。',
        pinyin: 'Tā zài jìnzhǐ tíngchē de lùduàn wéiguī tíngchē, bèi jiāojǐng yīfǎ chǔ yǐ liǎng bǎi yuán fákuǎn.',
        meaning_vi: 'Anh ấy đỗ xe trái quy định ở đoạn đường cấm đỗ, đã bị cảnh sát giao thông phạt tiền 200 tệ theo luật.',
        difficulty_level: 'basic'
      },
      {
        chinese: '对屡次违反环保排污标准且拒不整改的工业企业，环保行政执法部门开出了高达数百万元的天价罚款单。',
        pinyin: 'Duì lǚcì wéifǎn huánbǎo páiwū biāozhǔn qiě jùbù zhěnggǎi de gōngyè qǐyè, huánbǎo xíngzhèng zhífǎ bùmén kāi chū le gāodá shù bǎi wàn yuán de tiānjià fákuǎndān.',
        meaning_vi: 'Đối với những doanh nghiệp công nghiệp nhiều lần vi phạm tiêu chuẩn xả thải môi trường và kiên quyết không khắc phục, cơ quan thực thi pháp luật hành chính môi trường đã đưa ra mức án phạt tiền cao chót vót lên tới hàng triệu tệ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2326,
    hanzi: '法院',
    pinyin: 'fǎyuàn',
    word_type: 'Danh từ',
    meaning_vi: 'tòa án',
    examples: [
      {
        chinese: '双方就房屋买卖合同产生了严重分歧，最终决定向人民法院提起诉讼。',
        pinyin: 'Shuāngfāng jiù fángwū mǎimài hétong chǎnshēng le yánzhòng fēnqí, zuìzhōng juédìng xiàng rénmín fǎyuàn tíqǐ sùsòng.',
        meaning_vi: 'Hai bên đã nảy sinh bất đồng nghiêm trọng về hợp đồng mua bán nhà đất, cuối cùng quyết định khởi kiện lên tòa án nhân dân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '知识产权法院经过公开透明的法庭审理，依法作出了责令侵权方立即停止侵权行为并全额赔偿经济损失的终审判决。',
        pinyin: 'Zhīshi chǎnquán fǎyuàn jīngguò gōngkāi tòumíng de fǎtíng shěnlǐ, yīfǎ zuòchū le zélìng qīnquán fāng lìjí tíngzhǐ qīnquán xíngwéi bìng quán’é péicháng jīngjì sǔnshī de zhōngshěn pànjué.',
        meaning_vi: 'Tòa án sở hữu trí tuệ qua phiên xét xử công khai minh bạch đã đưa ra phán quyết chung thẩm theo luật yêu cầu bên xâm phạm quyền ngay lập tức dừng hành vi vi phạm và bồi thường toàn bộ tổn thất kinh tế.',
        difficulty_level: 'applied'
      }
    ]
  }
]
