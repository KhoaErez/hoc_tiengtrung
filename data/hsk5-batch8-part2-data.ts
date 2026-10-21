// data/hsk5-batch8-part2-data.ts
// 25 từ HSK 5: #2727 [领导] -> #2751 [忙碌]

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

export const HSK5_BATCH8_PART2: VocabItem[] = [
  {
    id: 2727,
    hanzi: '领导',
    pinyin: 'lǐngdǎo',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'lãnh đạo; người lãnh đạo, cấp trên',
    examples: [
      {
        chinese: '在部门领导的关心和指导下，新入职员工迅速适应了日常业务工作。',
        pinyin: 'Zài bùmén lǐngdǎo de guānxīn hé zhǐdǎo xià, xīn rùzhí yuángōng xùnsù shìyìng le rìcháng yèwù gōngzuò.',
        meaning_vi: 'Dưới sự quan tâm và chỉ bảo của lãnh đạo phòng ban, nhân viên mới vào nghề đã nhanh chóng thích nghi với công việc nghiệp vụ thường nhật.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高瞻远瞩的战略领导力在于敏锐把握新一轮科技革命的发展大势，带领企业在百年未有之变局中抢占未来竞争制高点。',
        pinyin: 'Gāozhān-yuǎnzhǔ de zhànlüè lǐngdǎolì zàiyú mǐnruì bǎwò xīn yì lún kējì gémìng de fāzhǎn dàshì, dàilǐng qǐyè zài bǎi nián wèiyǒu zhī biànjú zhōng qiǎngzhàn wèilái jìngzhēng zhìgāodiǎn.',
        meaning_vi: 'Năng lực lãnh đạo chiến lược nhìn xa trông rộng thể hiện ở chỗ nắm bắt nhạy bén xu thế phát triển của cuộc cách mạng khoa học công nghệ mới, dẫn dắt doanh nghiệp chiếm lĩnh điểm cao cạnh tranh tương lai giữa cục diện đổi thay trăm năm chưa từng có.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2728,
    hanzi: '领取',
    pinyin: 'lǐngqǔ',
    word_type: 'Động từ',
    meaning_vi: 'nhận, lĩnh (tiền trợ cấp, giải thưởng, giấy tờ)',
    examples: [
      {
        chinese: '请获奖同学持有效学生证到教务办公室领取荣誉证书和奖学金。',
        pinyin: 'Qǐng huòjiǎng tóngxué chí yǒuxiào xuéshengzhèng dào jiàowù bàngōngshì lǐngqǔ róngyù zhèngshū hé jiǎngxuéjīn.',
        meaning_vi: 'Xin mời các bạn học sinh đoạt giải mang thẻ học sinh còn hiệu lực đến văn phòng đào tạo để nhận giấy khen vinh dự và học bổng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '政务服务中心全面推行智能化自助服务终端，群众只需刷脸识别身份，即可在数秒内轻松领取不动产权电子证书。',
        pinyin: 'Zhèngwù fúwù zhōngxīn quánmiàn tuīxíng zhìnénghuà zìzhù fúwù zhōngduān, qúnzhòng zhǐxū shuāliǎn shíbié shēnfèn, jíkě zài shù miǎo nèi qīngsōng lǐngqǔ búdòngchǎnquán diànzǐ zhèngshū.',
        meaning_vi: 'Trung tâm dịch vụ hành chính công triển khai toàn diện trạm dịch vụ tự phục vụ thông minh, người dân chỉ cần quét khuôn mặt nhận diện danh tính là có thể dễ dàng nhận giấy chứng nhận quyền sở hữu bất động sản điện tử chỉ trong vài giây.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2729,
    hanzi: '领先',
    pinyin: 'lǐngxiān',
    word_type: 'Động từ',
    meaning_vi: 'dẫn đầu, đi đầu, vượt lên trước',
    examples: [
      {
        chinese: '在男子四百米接力赛中，我们班的运动员凭借默契的交接棒始终保持领先。',
        pinyin: 'Zài nánzǐ sìbǎimǐ jièlìsài zhōng, wǒmen bān de yùndòngyuán píngjiè mòqì de jiāojiēbàng shǐzhōng bǎochí lǐngxiān.',
        meaning_vi: 'Trong cuộc thi chạy tiếp sức 400m nam, các vận động viên lớp chúng tôi nhờ sự phối hợp trao gậy ăn ý đã luôn giữ vững vị trí dẫn đầu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '得益于持续高强度的研发投入与全产业链布局，我国在超高压特高压输电工程与动力电池制造技术上已处于世界绝对领先水平。',
        pinyin: 'Déyì yú chíxù gāo qiángdù de yánfā tóurù yǔ quán chǎnyèliàn bùjú, wǒ guó zài chāogāoyā tè-gāoyā shūdiàn gōngchéng yǔ dònglì diànchí zhìzào jìshù shang yǐ chǔyú shìjiè juéduì lǐngxiān shuǐpíng.',
        meaning_vi: 'Nhờ vào việc liên tục đầu tư cho nghiên cứu phát triển với cường độ cao và bố trí hoàn chỉnh toàn chuỗi công nghiệp, nước ta trong công trình truyền tải điện siêu cao áp và công nghệ chế tạo pin năng lượng đã đứng ở trình độ dẫn đầu tuyệt đối trên thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2730,
    hanzi: '领域',
    pinyin: 'lǐngyù',
    word_type: 'Danh từ',
    meaning_vi: 'lĩnh vực, phạm vi',
    examples: [
      {
        chinese: '王教授在古代汉语语音史研究领域发表了许多具有开创性的学术专著。',
        pinyin: 'Wáng jiàoshòu zài gǔdài Hànyǔ yǔyīnshǐ yánjiū lǐngyù fābiǎo le xǔduō jùyǒu kāichuàngxìng de xuéshù zhuānzhù.',
        meaning_vi: 'Giáo sư Vương trong lĩnh vực nghiên cứu lịch sử ngữ âm Hán ngữ cổ đại đã công bố rất nhiều chuyên khảo học thuật mang tính mở đường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '生成式人工智能与量子计算的深度交融，正在生物靶向制药、航空动力学仿真以及深海探测等尖端科学领域掀起前所未有的范式变革。',
        pinyin: 'Shēngchéngxìng réngōng zhìnéng yǔ liàngzǐ jìsuàn de shēndù jiāoróng, zhèngzài shēngwù bǎxiàng zhìyào, hángkōng dònglìxué fǎngzhēn yǐjí shēnhǎi tàncè děng jiānduān kēxué lǐngyù xiānqǐ qiánsuǒwèiyǒu de fànshì biàngé.',
        meaning_vi: 'Sự dung hợp sâu sắc giữa trí tuệ nhân tạo tạo sinh và tính toán lượng tử đang dấy lên một cuộc cải cách mô thức chưa từng có trong các lĩnh vực khoa học mũi nhọn như bào chế thuốc nhắm trúng đích sinh học, mô phỏng khí động lực học hàng không và thám hiểm biển sâu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2731,
    hanzi: '令',
    pinyin: 'lìng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'khiến cho, làm cho; mệnh lệnh, chỉ thị',
    examples: [
      {
        chinese: '他在关键时刻挺身而出解救落水儿童的英勇行为，令人肃然起敬。',
        pinyin: 'Tā zài guānjiàn shíkè tǐngshēn-érchū jiějiù luòshuǐ értóng de yīngyǒng xíngwéi, lìngrén sùrán-qǐjìng.',
        meaning_vi: 'Hành động dũng cảm dám xông pha trong thời khắc nguy nan cứu giúp em bé ngã nước của anh ấy khiến người ta phải kính cẩn thán phục.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对局部突发极端暴雨洪涝险情，防汛抗旱应急指挥部以令行禁止的严明纪律迅速调集抢险舟桥部队连夜封堵堤防缺口。',
        pinyin: 'Miànduì júbù tūfā jíduān bàoyǔ hónglào xiǎnqíng, fángxùn-kànghàn yìngjí zhǐhuībù yǐ lìngxíng-jìnzhǐ de yánmíng jìlǜ xùnsù diàojí qiǎngxiǎn zhōuqiáo bùduì liányè fēngdǔ dīfáng quēkǒu.',
        meaning_vi: 'Đối mặt với tình thế hiểm nghèo do mưa to lũ lụt cực đoan đột xuất cục bộ gây ra, ban chỉ huy ứng phó lũ lụt hạn hán với kỷ luật nghiêm minh lệnh ban là thi hành đã nhanh chóng điều động bộ đội công binh thuyền cầu xuyên đêm hàn gắn các đoạn đê xung yếu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2732,
    hanzi: '流传',
    pinyin: 'liúchuán',
    word_type: 'Động từ',
    meaning_vi: 'lưu truyền, truyền lại, lan truyền',
    examples: [
      {
        chinese: '这首优美动听的江南民歌已经在民间流传了数百年。',
        pinyin: 'Zhè shǒu yōuměi dòngtīng de Jiāngnán míngē yǐjīng zài mínjiān liúchuán le shù bǎi nián.',
        meaning_vi: 'Bài dân ca Giang Nam du dương êm tai này đã được lưu truyền trong dân gian suốt mấy trăm năm nay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '非物质文化遗产专家通过现代数字化音视频采集与口述史整理技术，让许多濒临失传的古老民族史诗与传统手工技艺得以长久流传存续。',
        pinyin: 'Fēiwùzhì wénhuà yíchǎn zhuānjiā tōngguò xiàndài shùzìhuà yīn-shìpín cǎijí yǔ kǒushùshǐ zhěnglǐ jìshù, ràng xǔduō bīnlín shīchuán de gǔlǎo mínzú shǐshī yǔ chuántǒng shǒugōng jìyì déyǐ chángjiǔ liúchuán cúnxù.',
        meaning_vi: 'Các chuyên gia di sản văn hóa phi vật thể thông qua công nghệ thu thập âm thanh hình ảnh số hóa hiện đại và chỉnh lý lịch sử truyền khẩu, đã giúp nhiều pho sử thi dân tộc cổ xưa cùng kỹ nghệ thủ công truyền thống đang bên bờ vực mai một có thể được lưu truyền và tiếp nối dài lâu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2733,
    hanzi: '流感',
    pinyin: 'liúgǎn',
    word_type: 'Danh từ',
    meaning_vi: 'cúm, bệnh cúm (cảm cúm mùa)',
    examples: [
      {
        chinese: '秋冬季节气温骤降，应当注意开窗通风以预防季节性流感的传播。',
        pinyin: 'Qiū-dōng jìjié qìwēn zhòujiàng, yīngdāng zhùyì kāichuāng tōngfēng yǐ yùfáng jìjiéxìng liúgǎn de chuánbō.',
        meaning_vi: 'Mùa thu đông nhiệt độ giảm đột ngột, nên chú ý mở cửa sổ thông gió để phòng ngừa sự lây lan của cảm cúm theo mùa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '疾病预防控制中心通过构建覆盖全国的三维呼吸道传染病监测网络，能够对高变异性流感病毒株实施毫秒级分子基因溯源与靶向疫苗早期研发储备。',
        pinyin: 'Jíbìng Yùfáng Kòngzhì Zhōngxīn tōngguò gòujiàn fùgài quánguó de sānwéi hūxīdào chuánrǎnbìng jiāncè wǎngluò, nénggòu duì gāo biànyìxìng liúgǎn bìngdúzhū shíshī háomiǎojí fēnzǐ jīyīn sùyuán yǔ bǎxiàng yìmiáo zǎoqī yánfā chǔbèi.',
        meaning_vi: 'Trung tâm Kiểm soát và Phòng ngừa Dịch bệnh thông qua việc xây dựng mạng lưới giám sát bệnh truyền nhiễm đường hô hấp 3 chiều bao phủ toàn quốc, có thể thực hiện truy vết gen phân tử cấp độ mili giây đối với các chủng virus cúm biến dị cao và nghiên cứu dự trữ sớm vắc xin định hướng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2734,
    hanzi: '浏览',
    pinyin: 'liúlǎn',
    word_type: 'Động từ',
    meaning_vi: 'lướt xem, duyệt, xem qua',
    examples: [
      {
        chinese: '每天早晨上班前，他习惯先快速浏览一下当天的核心新闻要点。',
        pinyin: 'Měi tiān zǎochen shàngbān qián, tā xíguàn xiān kuàisù liúlǎn yíxià dāngtiān de héxīn xīnwén yàodiǎn.',
        meaning_vi: 'Mỗi buổi sáng trước khi đi làm, anh ấy quen lướt nhanh qua các điểm tin tức thời sự cốt lõi trong ngày.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在知识爆炸的大数据时代，学者不仅需要广泛浏览学科交叉前沿文献，更要善于在海量信息中抽丝剥茧提炼出原创性科学问题。',
        pinyin: 'Zài zhīshi bàozhà de dàshùjù shídài, xuézhě bùjǐn xūyào guǎngfàn liúlǎn xuékē jiāochā qiányán wénxiàn, gèng yào shànyú zài hǎiliàng xìnxī zhōng chōusī-bōjiǎn tíliàn chū yuánchuàngxìng kēxué wèntí.',
        meaning_vi: 'Trong kỷ nguyên dữ liệu lớn bùng nổ tri thức, học giả không chỉ cần lướt xem rộng rãi các tài liệu tiên phong giao thoa liên ngành, mà càng phải giỏi bóc tách từng lớp thông tin trong khối lượng đồ sộ để chắt lọc ra các vấn đề khoa học có tính sáng tạo nguyên bản.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2735,
    hanzi: '留言',
    pinyin: 'liúyán',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'để lại lời nhắn, bình luận; lời nhắn',
    examples: [
      {
        chinese: '外出如果碰上朋友不在家，可以在门口便签条上留下一段温馨的留言。',
        pinyin: 'Wàichū rúguǒ pèngshang péngyou bú zài jiā, kěyǐ zài ménkǒu biànqiāntiáo shang liúxià yí duàn wēnxīn de liúyán.',
        meaning_vi: 'Ra ngoài nếu gặp lúc bạn không có nhà, có thể để lại một lời nhắn ấm áp trên mảnh giấy ghi chú trước cửa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '电子政务“领导留言板”已成为践行网上群众路线的重要桥梁，各级职能部门实行全流程闭环办理，切实做到件件有回音、事事有落实。',
        pinyin: 'Diànzǐ zhèngwù “Lǐngdǎo Liúyánbǎn” yǐ chéngwéi jiànxíng wǎngshang qúnzhòng lùxiàn de zhòngyào qiáoliáng, gè jí zhíngnéng bùmén shíxíng quán liúchéng bìhuán bànlǐ, qièshí zuòdào jiànjiàn yǒu huíyīn, shìshì yǒu luòshí.',
        meaning_vi: '"Hòm thư điện tử góp ý cho lãnh đạo" trên cổng chính quyền điện tử đã trở thành cây cầu nối quan trọng hiện thực hóa đường lối quần chúng qua mạng, các cơ quan ban ngành thực hiện quy trình xử lý khép kín toàn diện, đảm bảo từng ý kiến đều được hồi âm và từng việc đều được triển khai thực chất.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2736,
    hanzi: '龙',
    pinyin: 'lóng',
    word_type: 'Danh từ',
    meaning_vi: 'rồng, loài rồng',
    examples: [
      {
        chinese: '端午节赛龙舟是中华民族传承了两千多年的传统民俗体育活动。',
        pinyin: 'Duānwǔjié sài lóngzhōu shì Zhōnghuá mínzú chuánchéng le liǎng qiān duō nián de chuántǒng mínsú tǐyù huódòng.',
        meaning_vi: 'Đua thuyền rồng dịp Tết Đoan ngọ là hoạt động thể thao dân gian truyền thống được dân tộc Trung Hoa lưu truyền hơn 2000 năm nay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在中国传统文化中，龙象征着威武自强、吉祥腾飞与海纳百川的崇高精神，是凝聚海内外中华儿女文化认同的核心精神图腾。',
        pinyin: 'Zài Zhōngguó chuántǒng wénhuà zhōng, lóng xiàngzhēng zhe wēiwǔ zìqiáng, jíxiáng téngfēi yǔ hǎinà-bǎichuān de chónggāo jīngshén, shì níngjù hǎinèiwài Zhōnghuá érnǚ wénhuà rèntóng de héxīn jīngshén túténg.',
        meaning_vi: 'Trong văn hóa truyền thống Trung Hoa, rồng tượng trưng cho tinh thần cao quý uy dũng tự cường, cát tường vươn cao và dung nạp trăm sông, là biểu tượng vật tổ tinh thần cốt lõi gắn kết bản sắc văn hóa của những người con đất Việt - Hoa trong và ngoài nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2737,
    hanzi: '漏',
    pinyin: 'lòu',
    word_type: 'Động từ',
    meaning_vi: 'rò rỉ, chảy dột; sót, bỏ sót',
    examples: [
      {
        chinese: '连日的大雨导致这间老房子的屋顶开始滴滴答答地往下漏水。',
        pinyin: 'Liánrì de dàyǔ dǎozhì zhè jiān lǎo fángzi de wūdǐng kāishǐ dīdī-dādā de wǎng xià lòushuǐ.',
        meaning_vi: 'Cơn mưa lớn kéo dài nhiều ngày khiến mái của ngôi nhà cũ này bắt đầu dột nước tí tách xuống sàn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在严格的信息安全审计体系下，任何核心业务数据库必须部署全天候防泄密探针，决不允许关键用户数据发生哪怕一次泄漏风险。',
        pinyin: 'Zài yángé de xìnxī ānquán shěnjì tǐxì xià, rènhé héxīn yèwù shùjùkù bìxū bùshǔ quántiānhòu fáng xièmì tànzhēn, jué bù yǔnxǔ guānjiàn yònghù shùjù fāshēng nǎpà yí cì xièlòu fēngxiǎn.',
        meaning_vi: 'Dưới hệ thống kiểm toán an ninh thông tin nghiêm ngặt, bất kỳ cơ sở dữ liệu nghiệp vụ cốt lõi nào cũng bắt buộc phải triển khai đầu dò chống rò rỉ 24/7, tuyệt đối không cho phép dữ liệu người dùng then chốt xảy ra nguy cơ rò rỉ dù chỉ một lần.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2738,
    hanzi: '录',
    pinyin: 'lù',
    word_type: 'Động từ',
    meaning_vi: 'ghi âm, ghi hình, chép lại; tuyển dụng',
    examples: [
      {
        chinese: '歌手正在专业的隔音录音棚里录制自己的最新个人专辑。',
        pinyin: 'Gēshǒu zhèngzài zhuānyè de géyīn lùyīnpéng lǐ lùzhì zìjǐ de zuìxīn gèrén zhuānjí.',
        meaning_vi: 'Ca sĩ đang thu âm album cá nhân mới nhất của mình trong phòng thu cách âm chuyên nghiệp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '最高人民法院要求各级审判法庭全面实现“每庭必录”，依托智能语音转写与高清视音频同步录存技术，确保每一次司法庭审全过程规范留痕。',
        pinyin: 'Zuìgāo Rénmín Fǎyuàn yāoqiú gè jí shěnpàn fǎtíng quánmiàn shíxiàn “měi tíng bì lù”, yītuō zhìnéng yǔyīn zhuǎnxiě yǔ gāoqīng shì-yīnpín tóngbù lùcún jìshù, quèbǎo měi yí cì sīfǎ tíngshěn quán guòchéng guīfàn liúhén.',
        meaning_vi: 'Tòa án Nhân dân Tối cao yêu cầu các phòng xét xử các cấp thực hiện đầy đủ "phiên tòa nào cũng phải ghi âm ghi hình", dựa vào công nghệ chuyển đổi giọng nói thông minh thành văn bản và lưu trữ đồng bộ video âm thanh độ nét cao, đảm bảo từng phiên tòa tư pháp đều lưu lại dấu vết quy chuẩn trong toàn bộ tiến trình.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2739,
    hanzi: '陆地',
    pinyin: 'lùdì',
    word_type: 'Danh từ',
    meaning_vi: 'lục địa, đất liền',
    examples: [
      {
        chinese: '地球表面的面积由广阔的海洋和大约百分之二十九的陆地共同组成。',
        pinyin: 'Dìqiú biǎomiàn de miànjī yóu guǎngkuò de hǎiyáng hé dàyuē bǎifēnzhī èrshíjiǔ de lùdì gòngtóng zǔchéng.',
        meaning_vi: 'Diện tích bề mặt Trái Đất do đại dương bao la và khoảng 29% đất liền cùng hợp thành.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全球陆地生态系统在涵养水源、防风固沙以及吸收大气温室气体方面承担着至关重要的自然生态屏障功能。',
        pinyin: 'Quánqiú lùdì shēngtài xìtǒng zài hányǎng shuǐyuán, fángfēng-gùshā yǐjí xīshōu dàqì wēnshì qìtǐ fāngmiàn chéngdān zhe zhìguān-zhòngyào de zìrán shēngtài píngzhàng gōngnéng.',
        meaning_vi: 'Hệ sinh thái đất liền toàn cầu gánh vác chức năng bình phong sinh thái tự nhiên đặc biệt quan trọng trong việc bảo tồn nguồn nước, chắn gió giữ cát và hấp thụ khí nhà kính trong bầu khí quyển.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2740,
    hanzi: '录取',
    pinyin: 'lùqǔ',
    word_type: 'Động từ',
    meaning_vi: 'trúng tuyển, tuyển chọn, nhận vào học',
    examples: [
      {
        chinese: '收到心仪大学的正式录取通知书时，全家人都激动地欢呼雀跃。',
        pinyin: 'Shōudào xīnyí dàxué de zhèngshì lùqǔ tōngzhīshū shí, quán jiārén dōu jīdòng de huānhū-quèyuè.',
        meaning_vi: 'Khi nhận được giấy báo trúng tuyển chính thức của trường đại học hằng mơ ước, cả nhà đều vui sướng reo hò nhảy múa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家普通高校招生录取工作严格执行阳光招生政策，坚持分数面前人人平等与全程公开透明，坚决维护教育公平与广大考生切身权益。',
        pinyin: 'Guójiā pǔtōng gāoxiào zhāoshēng lùqǔ gōngzuò yángé zhíxíng yángguāng zhāoshēng zhèngcè, jiānchí fēnshù miànqián rénrén píngděng yǔ quánchéng gōngkāi tòumíng, jiānjué wéihù jiàoyù gōngpíng yǔ guǎngdà kǎoshēng qièshēn quányì.',
        meaning_vi: 'Công tác tuyển sinh đại học công lập quốc gia thực hiện nghiêm túc chính sách tuyển sinh minh bạch, kiên trì trước điểm số mọi người đều bình đẳng và công khai toàn bộ tiến trình, kiên quyết bảo vệ sự công bằng giáo dục cùng quyền lợi thiết thực của đông đảo thí sinh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2741,
    hanzi: '路人',
    pinyin: 'lùrén',
    word_type: 'Danh từ',
    meaning_vi: 'người qua đường, người đi đường',
    examples: [
      {
        chinese: '在陌生城市迷路时，不妨礼貌地向路人询问正确的行走方向。',
        pinyin: 'Zài mòshēng chéngshì mílù shí, bùfáng lǐmào de xiàng lùrén xúnwèn zhèngquè de xíngzǒu fāngxiàng.',
        meaning_vi: 'Khi bị lạc đường ở một thành phố xa lạ, bạn có thể lịch sự hỏi thăm người qua đường về phương hướng đi lại chính xác.',
        difficulty_level: 'basic'
      },
      {
        chinese: '见义勇为基金会对三位在冰冷湍急河流中合力救起落水儿童的普通路人给予了公开表彰与重奖，弘扬了社会崇德向善的正能量。',
        pinyin: 'Jiànyì-yǒngwéi jījīnhuì duì sān wèi zài bīnglěng tuānjí héliú zhōng hélì jiùqǐ luòshuǐ értóng de pǔtōng lùrén jǐyǔ le gōngkāi biǎozhāng yǔ zhòngjiǎng, hóngyáng le shèhuì chóngdé-xiàngshàn de zhèngnéngliàng.',
        meaning_vi: 'Quỹ người tốt việc tốt dũng cảm đã tuyên dương công khai và trọng thưởng cho ba người đi đường bình dị đã chung sức cứu sống em bé ngã xuống dòng sông lạnh buốt chảy xiết, lan tỏa nguồn năng lượng tích cực hướng thiện đề cao đạo đức xã hội.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2742,
    hanzi: '路线',
    pinyin: 'lùxiàn',
    word_type: 'Danh từ',
    meaning_vi: 'tuyến đường, lộ trình; đường lối',
    examples: [
      {
        chinese: '出发去郊游前，大家用手机地图提前规划好了最优的行驶路线。',
        pinyin: 'Chūfā qù jiāoyóu qián, dàjiā yòng shǒujī dìtú tíqián guīhuà hǎo le zuìyōu de xíngshǐ lùxiàn.',
        meaning_vi: 'Trước khi xuất phát đi dã ngoại, mọi người đã dùng bản đồ trên điện thoại để lên kế hoạch trước cho lộ trình di chuyển tối ưu nhất.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在关键核心技术攻坚中，必须紧密跟踪全球前沿科技演进趋势，科学论证技术路线，避免因路线误判而错失战略机遇。',
        pinyin: 'Zài guānjiàn héxīn jìshù gōngjiān zhōng, bìxū jǐnmì gēnzōng quánqiú qiányán kējì yǎnjìn qūshì, kēxué lùnzhèng jìshù lùxiàn, bìmǐan yīn lùxiàn wùpàn ér cuòshī zhànlüè jīyù.',
        meaning_vi: 'Trong cuộc đột phá công nghệ cốt lõi then chốt, đòi hỏi phải theo sát xu thế phát triển công nghệ tiên phong toàn cầu, luận chứng khoa học lộ trình kỹ thuật, tránh vì đánh giá sai lầm về lộ trình mà bỏ lỡ cơ hội chiến lược.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2743,
    hanzi: '陆续',
    pinyin: 'lùxù',
    word_type: 'Phó từ',
    meaning_vi: 'lần lượt, nối tiếp nhau, dần dà',
    examples: [
      {
        chinese: '早晨七点半左右，学生们背着书包陆续走进学校大门。',
        pinyin: 'Zǎochen qī diǎn bàn zuǒyòu, xuéshengmen bēi zhe shūbāo lùxù zǒujìn xuéxiào dàmén.',
        meaning_vi: 'Khoảng 7 giờ 30 sáng, các bạn học sinh đeo cặp sách lần lượt bước vào cổng trường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着多项支持民营经济高质量发展的精准金融扶持政策陆续落地见效，实体企业的投资信心正在稳步回升。',
        pinyin: 'Suízhe duō xiàng zhīchí mínyíng jīngjì gāo zhìliàng fāzhǎn de jīngzhǔn jīnróng fúchí zhèngcè lùxù luòdì jiànxiào, shítǐ qǐyè de tóuzī xìnxīn zhèngzài wěnbù huíshēng.',
        meaning_vi: 'Cùng với việc nhiều chính sách tài chính trúng đích hỗ trợ kinh tế tư nhân phát triển chất lượng cao lần lượt đi vào thực tiễn phát huy hiệu quả, niềm tin đầu tư của các doanh nghiệp sản xuất kinh doanh đang phục hồi vững chắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2744,
    hanzi: '录音',
    pinyin: 'lùyīn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'ghi âm; bản ghi âm',
    examples: [
      {
        chinese: '上英语听力课时，老师播放了一段发音地道的对话录音。',
        pinyin: 'Shàng Yīngyǔ tīnglìkè shí, lǎoshī bōfàng le yí duàn fāyīn dìdao de duìhuà lùyīn.',
        meaning_vi: 'Trong giờ học nghe tiếng Anh, cô giáo đã bật một đoạn băng ghi âm đối thoại có phát âm chuẩn bản địa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在民商事诉讼案件举证质证中，未经对方当事人明确知晓的私下录音资料若要作为合法证据采纳，必须严格接受真实性、关联性与合法性的司法审查。',
        pinyin: 'Zài mín-shāngshì sùsòng ànjiàn jǔzhèng zhìzhèng zhōng, wèijīng duìfāng dāngshìrén míngquè zhīxiǎo de sīxià lùyīn zīliào ruò yào zuòwéi héfǎ zhèngjù cǎinà, bìxū yángé jiēshòu zhēnshíxìng, guānliánxìng yǔ héfǎxìng de sīfǎ shěnchá.',
        meaning_vi: 'Trong hoạt động đối chất và đưa ra chứng cứ của các vụ kiện dân sự thương mại, tài liệu ghi âm lén không qua sự đồng ý rõ ràng của đương sự bên kia nếu muốn được chấp nhận làm bằng chứng hợp pháp thì bắt buộc phải trải qua sự thẩm tra tư pháp nghiêm ngặt về tính chân thực, tính liên quan và tính hợp pháp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2745,
    hanzi: '旅行社',
    pinyin: 'lǚxíngshè',
    word_type: 'Danh từ',
    meaning_vi: 'công ty du lịch, công ty lữ hành',
    examples: [
      {
        chinese: '为了省心，我们全家选择报名参加了一家正规旅行社的北京五日游。',
        pinyin: 'Wèile shěngxīn, wǒmen quánjiā xuǎnzé bàomíng cānjiā le yì jiā zhèngguī lǚxíngshè de Běijīng wǔ rì yóu.',
        meaning_vi: 'Để đỡ mất công lo toan, cả nhà chúng tôi lựa chọn đăng ký tham gia tour du lịch Bắc Kinh 5 ngày của một công ty lữ hành chính quy.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为规范文化旅游市场秩序，文化和旅游部对个别旅行社诱导游客强制购物与恶性低价竞争等违法违规行为进行了依法严厉整顿取缔。',
        pinyin: 'Wèi guīfàn wénhuà lǚyóu shìchǎng zhìxù, Wénhuà hé Lǚyóubù duì gèbié lǚxíngshè yòudǎo yóukè qiángzhì gòuwù yǔ èxìng dījià jìngzhēng děng wéifǎ wéiguī xíngwéi jìnxíng le yīfǎ yánlì zhěngdùn qǔdì.',
        meaning_vi: 'Nhằm chấn chỉnh trật tự thị trường du lịch văn hóa, Bộ Văn hóa và Du lịch đã xử lý nghiêm minh theo pháp luật các hành vi vi phạm như dụ dỗ ép buộc du khách mua sắm và cạnh tranh giá rẻ độc hại của một số công ty du lịch.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2746,
    hanzi: '论文',
    pinyin: 'lùnwén',
    word_type: 'Danh từ',
    meaning_vi: 'luận văn, bài báo khoa học, chuyên khảo',
    examples: [
      {
        chinese: '经过半年的调研与修改，他终于顺利完成了硕士毕业论文的撰写。',
        pinyin: 'Jīngguò bàn nián de diàoyán yǔ xiūgǎi, tā zhōngyú shùnlì wánchéng le shuòshì bìyè lùnwén de zhuànxiě.',
        meaning_vi: 'Qua nửa năm khảo sát thực tế và chỉnh sửa, anh ấy cuối cùng đã hoàn tất thuận lợi việc viết luận văn tốt nghiệp thạc sĩ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该科研团队在国际顶尖学术期刊上发表了题为拓扑量子超导新态的高水平研究论文，引发了全球凝聚态物理学界的强烈反响。',
        pinyin: 'Gāi kēyán tuánduì zài guójì dǐngjiān xuéshù qīkān shang fābiǎo le tíwéi tuòpū liàngzǐ chāodǎo xīntài de gāo shuǐpíng yánjiū lùnwén, yǐnfā le quánqiú níngjùtài wùlǐxué jiè de qiángliè fǎnxiǎng.',
        meaning_vi: 'Nhóm nghiên cứu khoa học này đã công bố một bài báo học thuật trình độ cao mang tựa đề về trạng thái mới siêu dẫn lượng tử tô pô trên tạp chí học thuật hàng đầu thế giới, dấy lên tiếng vang mạnh mẽ trong giới vật lý chất ngưng tụ toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2747,
    hanzi: '逻辑',
    pinyin: 'luójí',
    word_type: 'Danh từ',
    meaning_vi: 'logic, quy luật logic, tư duy logic',
    examples: [
      {
        chinese: '写议论文时必须注意论点明确、论据充分且前后逻辑严密。',
        pinyin: 'Xiě yìlùnwén shí bìxū zhùyì lùndiǎn míngquè, lùnjù chōngfèn qiě qiánhòu luójí yánmì.',
        meaning_vi: 'Khi viết văn nghị luận bắt buộc phải chú ý luận điểm rõ ràng, luận cứ xác đáng và logic trước sau chặt chẽ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代法律制度的建构深刻遵循权利义务相一致的底层逻辑，确保每一个司法条文都在严谨的形式逻辑与公平正义的价值追求中实现高度自洽。',
        pinyin: 'Xiàndài fǎlǜ zhìdù de jiàngòu shēnkè zūnxún quánlì yìwù xiāng yīzhì de dǐcéng luójí, quèbǎo měi yí gè sīfǎ tiáowén dōu zài yánjǐn de xíngshì luójí yǔ gōngpíng-zhèngyì de jiàzhí zhuīqiú zhōng shíxiàn gāodù zìqià.',
        meaning_vi: 'Việc xây dựng hệ thống pháp luật hiện đại tuân thủ sâu sắc logic nền tảng về sự thống nhất giữa quyền lợi và nghĩa vụ, bảo đảm từng điều khoản tư pháp đều đạt được sự tự nhất quán cao độ giữa logic hình thức chặt chẽ cùng giá trị theo đuổi công bằng chính nghĩa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2748,
    hanzi: '骂',
    pinyin: 'mà',
    word_type: 'Động từ',
    meaning_vi: 'mắng, chửi, quở trách',
    examples: [
      {
        chinese: '教育犯了错误的孩子时要耐心讲清道理，千万不要随意大声责骂。',
        pinyin: 'Jiàoyù fàn le cuòwù de háizi shí yào nàixīn jiǎng qīng dàolǐ, qiānwàn bú yào suíyì dàshēng zémà.',
        meaning_vi: 'Khi giáo dục đứa trẻ mắc lỗi cần phải kiên nhẫn giảng giải rõ đạo lý, tuyệt đối không nên tùy tiện lớn tiếng mắng mỏ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '网络文明建设坚决抵制任何形式的匿名网络暴力与人身攻击辱骂，依法维护清朗健康的网络生态空间。',
        pinyin: 'Wǎngluò wénmíng jiànshè jiānjué dǐzhì rènhé xíngshì de nìmíng wǎngluò bàolì yǔ rénshēn gōngjī rǔmà, yīfǎ wéihù qīnglǎng jiànkāng de wǎngluò shēngtài kōngjiān.',
        meaning_vi: 'Công cuộc xây dựng văn minh mạng kiên quyết bài trừ mọi hình thức bạo lực mạng ẩn danh và lăng mạ tấn công nhân phẩm, bảo vệ không gian sinh thái mạng trong lành lành mạnh theo đúng quy định của pháp luật.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2749,
    hanzi: '买卖',
    pinyin: 'mǎimai',
    word_type: 'Danh từ',
    meaning_vi: 'buôn bán, kinh doanh; vụ giao dịch',
    examples: [
      {
        chinese: '集市上的小商贩们正在热情招揽顾客，街头买卖十分红火。',
        pinyin: 'Jíshì shang de xiǎo shāngfànmen zhèngzài rèqíng zhāolǎn gùkè, jiētóu mǎimai shífēn hónghuǒ.',
        meaning_vi: 'Các tiểu thương trên khu chợ phiên đang nhiệt tình mời chào khách hàng, chuyện buôn bán nơi góc phố vô cùng tấp nập phát đạt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代合同法明确规定买卖合同双方当事人应当遵循自愿、公平、诚实信用的民商事交易基本原则。',
        pinyin: 'Xiàndài hétongfǎ míngquè guīdìng mǎimai hétong shuāngfāng dāngshìrén yīngdāng zūnxún zìyuàn, gōngpíng, chéngshí xìnyòng de mín-shāngshì jiāoyì jīběn yuánzé.',
        meaning_vi: 'Luật Hợp đồng hiện đại quy định rõ ràng rằng các bên tham gia ký kết hợp đồng mua bán phải tuân thủ các nguyên tắc cơ bản trong giao dịch dân sự thương mại như tự nguyện, công bằng và trung thực giữ chữ tín.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2750,
    hanzi: '满足',
    pinyin: 'mǎnzú',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'làm thỏa mãn, đáp ứng; hài lòng, mãn nguyện',
    examples: [
      {
        chinese: '无论取得多么优秀的成绩，在求知治学的道路上都决不能轻易自满自足。',
        pinyin: 'Wúlùn qǔdé duōme yōuxiù de chéngjì, zài qiúzhī-zhìxué de dàolù shang dōu jué bùnéng qīngyì zìmǎn-zìzú.',
        meaning_vi: 'Bất luận giành được thành tích xuất sắc đến đâu, trên con đường tìm kiếm tri thức và nghiên cứu học thuật đều tuyệt đối không thể dễ dàng tự thỏa mãn với bản thân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '供给侧结构性改革的核心在于不断提升供给体系的质量与韧性，以高质量供给更好地满足人民群众对美好生活的新期待。',
        pinyin: 'Gōngjǐcè jiégòuxìng gǎigé de héxīn zàiyú búduàn tíshēng gōngjǐ tǐxì de zhìliàng yǔ rènxìng, yǐ gāo zhìliàng gōngjǐ gèng hǎo de mǎnzú rénmín qúnzhòng duì měihǎo shēnghuó de xīn qīdài.',
        meaning_vi: 'Hạt nhân của cải cách cơ cấu phía cung nằm ở việc không ngừng nâng cao chất lượng và sức bền của hệ thống cung ứng, dùng nguồn cung chất lượng cao để đáp ứng tốt hơn những mong ước mới của quần chúng nhân dân về một cuộc sống tốt đẹp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2751,
    hanzi: '忙碌',
    pinyin: 'mánglù',
    word_type: 'Tính từ',
    meaning_vi: 'bận rộn, tất bật',
    examples: [
      {
        chinese: '期末考试周期间，图书馆里到处都是忙碌复习功课的莘莘学子。',
        pinyin: 'Qīmò kǎoshì zhōuqī jiān, túshūguǎn lǐ dàochù dōu shì mánglù fùxí gōngkè de shēnshēn xuézǐ.',
        meaning_vi: 'Trong tuần lễ thi cuối kỳ, trong thư viện đâu đâu cũng là hình bóng của các bạn học sinh đang tất bật ôn tập bài vở.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在现代国际枢纽港口，全自动化无人集装箱码头日夜不停地忙碌运转，数万个标箱的高效装卸映射出全球外贸的强劲复苏脉搏。',
        pinyin: 'Zài xiàndài guójì shūniǔ gǎngkǒu, quán zìdònghuà wúrén jízhuāngxiāng mǎtóu rì-yè bù tíng de mánglù yùnzhuǎn, shù wàn gè biāoxiāng de gāoxiào zhuāngxiè yìngshè chū quánqiú wàimào de qiángjìn fùsū màibó.',
        meaning_vi: 'Tại cảng đầu mối quốc tế hiện đại, bến cảng container không người tự động hóa hoàn toàn ngày đêm không ngừng tất bật vận hành, việc bốc dỡ hiệu quả cao hàng vạn container tiêu chuẩn phản chiếu từng nhịp đập phục hồi mạnh mẽ của thương mại quốc tế.',
        difficulty_level: 'applied'
      }
    ]
  }
]
