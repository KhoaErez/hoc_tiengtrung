// data/hsk5-batch7-part4-data.ts
// 25 từ HSK 5: #2677 [宽] -> #2701 [理论]

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

export const HSK5_BATCH7_PART4: VocabItem[] = [
  {
    id: 2677,
    hanzi: '宽',
    pinyin: 'kuān',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'rộng, rộng rãi; chiều rộng; khoan dung, thoáng',
    examples: [
      {
        chinese: '这条新修建的滨海林荫大道非常宽，双向一共有八条车道。',
        pinyin: 'Zhè tiáo xīn xiūjiàn de bīnhǎi línyīn dàdào fēicháng kuān, shuāngxiàng yígòng yǒu bā tiáo chēdào.',
        meaning_vi: 'Đại lộ rợp bóng cây ven biển mới được xây dựng này rất rộng, hai chiều có tổng cộng tám làn xe.',
        difficulty_level: 'basic'
      },
      {
        chinese: '胸怀宽广的领导者往往善于海纳百川并容人之短，从而紧紧凝聚起各方优秀专业人才共同成就一番伟大事业。',
        pinyin: 'Xiōnghuái kuānguǎng de lǐngdǎozhě wǎngwǎng shànyú hǎinà-bǎichuān bìng róngrén-zhīduǎn, cóng’ér jǐnjǐn níngjù qǐ gèfāng yōuxiù zhuānyè réncái gòngtóng chéngjiù yì fān wěidà shìyè.',
        meaning_vi: 'Người lãnh đạo có tấm lòng rộng mở thường biết dung nạp muôn dòng và bao dung khuyết điểm của người khác, nhờ đó gắn kết bền chặt nhân tài chuyên môn ưu tú khắp nơi cùng gây dựng nên một sự nghiệp vĩ đại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2678,
    hanzi: '宽度',
    pinyin: 'kuāndù',
    word_type: 'Danh từ',
    meaning_vi: 'chiều rộng, bề rộng, độ rộng',
    examples: [
      {
        chinese: '在购买新衣柜前，务必先用卷尺准确测量好卧室预留空间的宽度。',
        pinyin: 'Zài gòumǎi xīn yīguì qián, wùbì xiān yòng juǎnchǐ zhǔnquè cèliáng hǎo wòshì yùliú kōngjiān de kuāndù.',
        meaning_vi: 'Trước khi mua tủ quần áo mới, nhất thiết phải dùng thước cuộn đo đạc chính xác chiều rộng không gian dành sẵn trong phòng ngủ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '超高压电网跨江输电铁塔基础施工中，工程师对塔身钢构件的装配宽度误差有着毫米级的极高精度标准。',
        pinyin: 'Chāogāoyā diànwǎng kuàjiāng shūdiàn tiětǎ jīchǔ shīgōng zhōng, gōngchéngshī duì tǎshēn gāng gòujiàn de zhuāngpèi kuāndù wùchā yǒu zhe háomǐ jí de jí gāo jīngdù biāozhǔn.',
        meaning_vi: 'Trong thi công móng tháp truyền tải điện vượt sông thuộc lưới điện siêu cao áp, các kỹ sư đặt ra tiêu chuẩn độ chính xác cực cao đến từng milimet đối với sai số bề rộng lắp ráp các cấu kiện thép thân tháp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2679,
    hanzi: '亏',
    pinyin: 'kuī',
    word_type: 'Động từ / Phó từ',
    meaning_vi: 'lỗ vốn, thua thiệt, hao hụt; may nhờ có',
    examples: [
      {
        chinese: '今天出门幸亏带了雨伞，不然路上肯定会被大雨淋成落汤鸡。',
        pinyin: 'Jīntiān chūmén xìngkuī dài le yǔsǎn, bùrán lùshang kěndìng huì bèi dàyǔ lín chéng luòtāngjī.',
        meaning_vi: 'Hôm nay ra khỏi nhà may nhờ có mang theo ô, nếu không ở trên đường chắc chắn đã bị mưa ướt như chuột lột.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该跨国制造业巨头受困于传统燃油汽车销量持续下滑，上一财年净利润大幅转亏，迫使董事会加速向纯电动智能化战略转型。',
        pinyin: 'Gāi kuàguó zhìzàoyè jùtóu shòukùn yú chuántǒng rányóu qìchē xiàoliàng chíxù xiàhuá, shàng yí cáinián jìnglìrùn dàfú zhuǎn kuī, pòshǐ dǒngshìhuì jiāsù xiàng chún diàndòng zhìnénghuà zhànlüè zhuǎnxíng.',
        meaning_vi: 'Gã khổng lồ chế tạo xuyên quốc gia này do sa lầy vào đà sụt giảm doanh số xe chạy xăng truyền thống, lợi nhuận ròng niên độ tài chính trước đã chuyển thành thua lỗ nặng nề, buộc hội đồng quản trị phải đẩy nhanh chuyển dịch chiến lược sang xe điện thông minh thuần túy.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2680,
    hanzi: '昆虫',
    pinyin: 'kūnchóng',
    word_type: 'Danh từ',
    meaning_vi: 'côn trùng, sâu bọ',
    examples: [
      {
        chinese: '科学课上，老师带领同学们去植物园观察各种昆虫的生活习性。',
        pinyin: 'Kēxuékè shang, lǎoshī dàilǐng tóngxuémen qù zhíwùyuán guānchá gèzhǒng kūnchóng de shēnghuó xíxìng.',
        meaning_vi: 'Trong tiết khoa học, thầy giáo dẫn các bạn học sinh tới vườn bách thảo để quan sát tập tính sinh hoạt của các loài côn trùng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '蜜蜂与蝴蝶等传粉昆虫在全球农业生态系统与农作物增产中扮演着至关重要的角色，过度使用化学农药正对昆虫种群生存构成严峻威胁。',
        pinyin: 'Mìfēng yǔ húdié děng chuánfěn kūnchóng zài quánqiú nóngyè shēngtài xìtǒng yǔ nóngzuòwù zēngchǎn zhōng bànyǎn zhe zhìguān-zhòngyào de juésè, guòdù shǐyòng huàxué nóngyào zhèng duì kūnchóng zhǒngqún shēngcún gòuchéng yánjùn wēixié.',
        meaning_vi: 'Các loài côn trùng thụ phấn như ong mật và bướm đóng vai trò đặc biệt quan trọng trong hệ sinh thái nông nghiệp toàn cầu và việc tăng sản lượng hoa màu, việc lạm dụng thuốc trừ sâu hóa học đang đặt ra mối đe dọa nghiêm trọng đối với sự sinh tồn của các quần thể côn trùng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2681,
    hanzi: '扩大',
    pinyin: 'kuòdà',
    word_type: 'Động từ',
    meaning_vi: 'mở rộng, khuếch đại, nới rộng',
    examples: [
      {
        chinese: '这家糕点店因为口碑极好，老板打算在城市东区再扩大一家分店。',
        pinyin: 'Zhè jiā gāodiǎndiàn yīnwèi kǒubēi jí hǎo, lǎobǎn dǎsuàn zài chéngshì dōngqū zài kuòdà yì jiā fēndiàn.',
        meaning_vi: 'Cửa tiệm bánh ngọt này nhờ danh tiếng truyền miệng rất tốt nên ông chủ dự định sẽ mở rộng thêm một chi nhánh ở khu vực phía đông thành phố.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家坚持扩大高水平制度型对外开放，持续稳步扩大金融服务、电信增值以及生物医药领域的市场准入范围。',
        pinyin: 'Guójiā jiānchí kuòdà gāo shuǐpíng zhìdùxíng duìwài kāifàng, chíxù wěnbù kuòdà jīnróng fúwù, diànxìn zēngzhí yǐjí shēngwù yīyào lǐngyù de shìchǎng zhǔnrù fànwéi.',
        meaning_vi: 'Nhà nước kiên trì mở rộng hội nhập mở cửa đối ngoại ở cấp độ thể chế tiêu chuẩn cao, liên tục mở rộng vững chắc phạm vi tiếp cận thị trường trong các lĩnh vực dịch vụ tài chính, viễn thông giá trị gia tăng và dược sinh học.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2682,
    hanzi: '来源',
    pinyin: 'láiyuán',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'nguồn, nguồn gốc; bắt nguồn từ',
    examples: [
      {
        chinese: '写学术论文时，引用的所有数据都必须注明权威真实的信息来源。',
        pinyin: 'Xiě xuéshù lùnwén shí, yǐnyòng de suǒyǒu shùjù dōu bìxū zhùmíng quánwēi zhēnshí de xìnxī láiyuán.',
        meaning_vi: 'Khi viết luận văn học thuật, tất cả các số liệu trích dẫn đều bắt buộc phải ghi rõ nguồn thông tin xác thực uy tín.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科学研究表明，一切真知都是从直接经验发源的，实践不仅是认识的唯一来源，更是检验真理的唯一标准。',
        pinyin: 'Kēxué yánjiū biǎomíng, yíqiè zhēnzhī dōu shì cóng zhíjiē jīngyàn fāyuán de, shíjiàn bùjǐn shì rènshi de wéiyī láiyuán, gèng shì jiǎnyàn zhēnlǐ de wéiyī biāozhǔn.',
        meaning_vi: 'Nghiên cứu khoa học chỉ ra rằng, mọi hiểu biết chân thực đều bắt nguồn từ kinh nghiệm trực tiếp, thực tiễn không chỉ là nguồn gốc duy nhất của nhận thức mà còn là tiêu chuẩn duy nhất để kiểm nghiệm chân lý.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2683,
    hanzi: '劳动',
    pinyin: 'láodòng',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'lao động; làm việc, làm lụng',
    examples: [
      {
        chinese: '我们从小就应当树立崇尚劳动、尊重每一个劳动者的良好品德。',
        pinyin: 'Wǒmen cóngxiǎo jiù yīngdāng shùlì chóngshàng láodòng, zūnzhòng měi yí gè láodòngzhě de liánghǎo pǐndé.',
        meaning_vi: 'Từ nhỏ chúng ta đã nên tạo dựng phẩm chất tốt đẹp biết tôn vinh lao động và tôn trọng từng người lao động.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大力弘扬劳模精神、劳动精神与工匠精神，对于激励当代广大青年走技能成才、技能报国之路具有重大的现实意义。',
        pinyin: 'Dàlì hóngyáng láomó jīngshén, láodòng jīngshén yǔ gōngjiàng jīngshén, duìyú jīlì dāngdài guǎngdà qīngnián zǒu jìnéng chéngcái, jìnéng bàoguó zhī lù jùyǒu zhòngdà de xiànshí yìyì.',
        meaning_vi: 'Đẩy mạnh phát huy tinh thần người lao động kiểu mẫu, tinh thần lao động và tinh thần nghệ nhân có ý nghĩa thực tiễn to lớn trong việc khích lệ đông đảo thanh niên thời đại đi theo con đường dùng tay nghề thành tài và dùng kỹ năng cống hiến cho đất nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2684,
    hanzi: '老百姓',
    pinyin: 'lǎobǎixìng',
    word_type: 'Danh từ',
    meaning_vi: 'người dân, người dân thường, bách tính',
    examples: [
      {
        chinese: '政府出台的各项便民惠民政策切实减轻了普通老百姓的生活负担。',
        pinyin: 'Zhèngfǔ chūtái de gè xiàng biànmín-huìmín zhèngcè qièshí jiǎnqīng le pǔtōng lǎobǎixìng de shēnghuó fùdān.',
        meaning_vi: 'Các chính sách thuận lòng dân và mang lại lợi ích cho dân do chính quyền ban hành đã giảm nhẹ thiết thực gánh nặng sinh hoạt cho người dân thường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '江山就是人民，人民就是江山，党和政府始终把老百姓的安危冷暖放在心中最高位置，着力解决人民群众急难愁盼的民生痛点。',
        pinyin: 'Jiāngshān jiùshì rénmín, rénmín jiùshì jiāngshān, dǎng hé zhèngfǔ shǐzhōng bǎ lǎobǎixìng de ān-wēi lěng-nuǎn fàng zài xīnlǐ zuì gāo wèizhì, zhuólì jiějué rénmín qúnzhòng jí-nán-chóu-pàn de mínshēng tòngdiǎn.',
        meaning_vi: 'Giang sơn chính là nhân dân, nhân dân chính là giang sơn, Đảng và Chính phủ luôn đặt sự an nguy và đời sống no ấm của người dân lên vị trí cao nhất trong lòng, dốc sức giải quyết những điểm nghẽn bức xúc cấp bách mà quần chúng nhân dân đang mong mỏi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2685,
    hanzi: '老板',
    pinyin: 'lǎobǎn',
    word_type: 'Danh từ',
    meaning_vi: 'ông chủ, chủ tiệm, sếp',
    examples: [
      {
        chinese: '书店老板是一位和蔼可亲的老学者，经常热心给读者推荐好书。',
        pinyin: 'Shūdiàn lǎobǎn shì yí wèi hé’ǎi-kěqīn de lǎo xuézhě, chāngcháng rèxīn gěi dúzhě tuījiàn hǎo shū.',
        meaning_vi: 'Ông chủ tiệm sách là một học giả cao tuổi hiền từ dễ mến, thường xuyên nhiệt tình giới thiệu sách hay cho bạn đọc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '作为拥有敏锐战略眼光的科技初创企业老板，他果断决策将全部天使轮融资投入到了生成式AI底座模型的自主研发当中。',
        pinyin: 'Zuòwéi yōngyǒu mǐnruì zhànlüè yǎnguāng de kējì chūchuàng qǐyè lǎobǎn, tā guǒduàn juécè jiāng quánbù tiānshǐ lún róngzī tóurù dào le shēngchéngxìng AI dǐzuò móxíng de zìzhǔ yánfā dāngzhōng.',
        meaning_vi: 'Là một ông chủ doanh nghiệp công nghệ khởi nghiệp sở hữu tầm nhìn chiến lược nhạy bén, anh ấy đã quyết đoán đưa ra quyết định dồn toàn bộ nguồn vốn gọi được ở vòng thiên thần vào việc tự chủ nghiên cứu mô hình nền tảng AI tạo sinh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2686,
    hanzi: '老公',
    pinyin: 'lǎogōng',
    word_type: 'Danh từ',
    meaning_vi: 'chồng, ông xã',
    examples: [
      {
        chinese: '每天下班回到家，老公总是主动走进厨房准备丰盛的晚餐。',
        pinyin: 'Měi tiān xiàbān huídào jiā, lǎogōng zǒngshì zhǔdòng zǒujìn chúfáng zhǔnbèi fēngshèng de wǎncān.',
        meaning_vi: 'Mỗi ngày tan sở về nhà, người chồng luôn chủ động bước vào bếp nấu một bữa tối thịnh soạn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '结婚十余年来，夫妻俩在职业发展与家庭教育中始终相互扶持、同甘共苦，树立了文明相爱、和睦融洽的良好家风。',
        pinyin: 'Jiéhūn shí yú nián lái, fūqī liǎ zài zhíyè fāzhǎn yǔ jiātíng jiàoyù zhōng shǐzhōng xiānghù fúchí, tónggān-gòngkǔ, shùlì le wénmíng xiāng’ài, hémù róngqià de liánghǎo jiāfēng.',
        meaning_vi: 'Hơn 10 năm kết hôn, hai vợ chồng trong phát triển sự nghiệp và giáo dục gia đình luôn nâng đỡ lẫn nhau, đồng cam cộng khổ, xây dựng nếp nhà văn minh yêu thương và hòa thuận ấm cúng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2687,
    hanzi: '姥姥',
    pinyin: 'lǎolao',
    word_type: 'Danh từ',
    meaning_vi: 'bà ngoại',
    examples: [
      {
        chinese: '放暑假的时候，我最喜欢去乡下姥姥家吃她亲手包的玉米饺子。',
        pinyin: 'Fàng shǔjià de shíhou, wǒ zuì xǐhuan qù xiāngxia lǎolao jiā chī tā qīnshǒu bāo de yùmǐ jiǎozi.',
        meaning_vi: 'Khi được nghỉ hè, tôi thích nhất là về quê nhà bà ngoại để ăn món sủi cảo nhân ngô do chính tay bà gói.',
        difficulty_level: 'basic'
      },
      {
        chinese: '姥姥慈祥温暖的叮咛与勤俭持家的崇高美德，犹如一盏明灯，深深烙印在每一个儿孙辈的心中代代相传。',
        pinyin: 'Lǎolao cíxiáng wēnnuǎn de dīngníng yǔ qínjiǎn-chíjiā de chónggāo měidé, yóurú yì zhǎn míngdēng, shēnshēn làoyìn zài měi yí gè érsūnbèi de xīnzhōng dài dài xiāngchuán.',
        meaning_vi: 'Lời dặn dò ấm áp đôn hậu của bà ngoại cùng đức tính cần kiệm vun vén gia đình cao đẹp, tựa như một ngọn đèn sáng ngời khắc sâu trong tâm khảm của từng thế hệ con cháu và truyền thừa qua các đời.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2688,
    hanzi: '老婆',
    pinyin: 'lǎopo',
    word_type: 'Danh từ',
    meaning_vi: 'vợ, bà xã',
    examples: [
      {
        chinese: '今天是老婆的生日，丈夫特意买了一束鲜艳的红玫瑰作为惊喜礼物。',
        pinyin: 'Jīntiān shì lǎopo de shēngrì, zhàngfu tèyì mǎi le yí shù xiānyàn de hóng méiguī zuòwéi jīngxǐ lǐwù.',
        meaning_vi: 'Hôm nay là sinh nhật của vợ, người chồng đặc biệt mua một bó hoa hồng đỏ tươi thắm làm món quà bất ngờ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在艰苦的边疆支教岁月里，他和妻子互为最坚强的精神支柱，共同为偏远山区的孩子们点亮了求知的希望之光。',
        pinyin: 'Zài jiānkǔ de biānjiāng zhījiào suìyuè lǐ, tā hé qīzi hù wéi zuì jiānqiáng de jīngshén zhīzhù, gòngtóng wèi piānyuǎn shānqū de háizimen diǎnliàng le qiúzhī de xīwàng zhī guāng.',
        meaning_vi: 'Trong những năm tháng tình nguyện dạy học đầy gian khó nơi biên cương, anh và người vợ đã là điểm tựa tinh thần vững chắc nhất cho nhau, cùng nhau thắp sáng ngọn lửa hy vọng tìm kiếm tri thức cho trẻ em vùng cao hẻo lánh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2689,
    hanzi: '姥爷',
    pinyin: 'lǎoye',
    word_type: 'Danh từ',
    meaning_vi: 'ông ngoại',
    examples: [
      {
        chinese: '姥爷年轻时曾是一名优秀的铁路机车司机，经常给我讲火车的故事。',
        pinyin: 'Lǎoye niánqīng shí céng shì yì míng yōuxiù de tiělù jīchē sījī, chángcháng gěi wǒ jiǎng huǒchē de gùshì.',
        meaning_vi: 'Ông ngoại thời trẻ từng là một người lái đầu máy xe lửa xuất sắc, thường hay kể cho tôi nghe những câu chuyện về đoàn tàu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '身为参加过抗美援朝的老战士，姥爷珍藏在旧铁盒里的勋章见证了那个战火纷飞年代保家卫国的赤胆忠心。',
        pinyin: 'Shēnwéi cānjiā guò Kàng Měi Yuán Cháo de lǎo zhànshì, lǎoye zhēncáng zài jiù tiěhé lǐ de xūnzhāng jiànzhèng le nà gè zhànhuǒ-fēnfēi niándài bǎojiā-wèiguó de chìdǎn-zhōngxīn.',
        meaning_vi: 'Với tư cách là người cựu chiến binh từng tham gia kháng chiến chống Mỹ viện Triều, những tấm huân chương được ông ngoại nâng niu gìn giữ trong chiếc hộp sắt cũ là minh chứng cho tấm lòng trung trinh son sắt bảo vệ gia đình và tổ quốc trong những năm tháng đạn bom khói lửa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2690,
    hanzi: '乐观',
    pinyin: 'lèguān',
    word_type: 'Tính từ',
    meaning_vi: 'lạc quan, yêu đời, tin tưởng',
    examples: [
      {
        chinese: '无论面对多么棘手的困难，他脸上总是挂着乐观灿烂的微笑。',
        pinyin: 'Wúlùn miànduì duōme jíshǒu de kùnnan, tā liǎn shang zǒngshì guà zhe lèguān cànlàn de wēixiào.',
        meaning_vi: 'Bất luận đối mặt với khó khăn hóc búa đến nhường nào, trên gương mặt anh ấy lúc nào cũng nở nụ cười lạc quan rạng rỡ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际货币基金组织首席经济学家在发布会上表示，基于中国内需潜力的持续释放与高科技制造业的强劲韧性，对未来全球经济走势抱持审慎乐观预期。',
        pinyin: 'Guójì Huòbì Jījīnzǔzhī shǒuxí jīngjìxuéjiā zài fābùhuì shang biǎoshì, jīyú Zhōngguó nèixū qiánlì de chíxù shìfàng yǔ gāo kējì zhìzàoyè de qiángjìn rènxìng, duì wèilái quánqiú jīngjì zǒushì bàochí shěnshèn lèguān yùqī.',
        meaning_vi: 'Chuyên gia kinh tế trưởng của Quỹ Tiền tệ Quốc tế tại buổi họp báo cho biết, dựa trên sự giải phóng liên tục tiềm năng nhu cầu nội địa của Trung Quốc và sức bền mạnh mẽ của ngành chế tạo công nghệ cao, họ giữ vững kỳ vọng lạc quan thận trọng về xu thế kinh tế toàn cầu tương lai.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2691,
    hanzi: '乐趣',
    pinyin: 'lèqù',
    word_type: 'Danh từ',
    meaning_vi: 'niềm vui, sự thú vị, lạc thú',
    examples: [
      {
        chinese: '在阳光明媚的午后静下心来读一本好书，能让人体验到无穷的乐趣。',
        pinyin: 'Zài yángguāng míngmèi de wǔhòu jìng xià xīn lai dú yì běn hǎo shū, néng ràng rén tǐyàn dào wúqióng de lèqù.',
        meaning_vi: 'Lắng lòng đọc một cuốn sách hay vào buổi chiều ngập tràn ánh nắng ấm áp có thể giúp con người trải nghiệm niềm vui thú vô tận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大科学家往往能从枯燥繁琐的代码调试与海量抽象的公式推导中，敏锐捕捉到洞悉宇宙自然运行奥秘的崇高智力乐趣。',
        pinyin: 'Dà kēxuéjiā wǎngwǎng néng cóng kūzào fánsuǒ de dàimǎ tiáoshì yǔ hǎiliàng chōuxiàng de gōngshì tuīdǎo zhōng, mǐnruì bǔzhuō dào dòngxī yǔzhòu zìrán yùnxíng àomì de chónggāo zhìlì lèqù.',
        meaning_vi: 'Các nhà khoa học vĩ đại thường có thể từ những dòng gỡ lỗi lập trình khô khan tẻ nhạt và phép suy diễn công thức trừu tượng khổng lồ, nhạy bén bắt trọn niềm vui trí tuệ cao quý khi thấu suốt bí ẩn vận hành của tự nhiên vũ trụ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2692,
    hanzi: '泪',
    pinyin: 'lèi',
    word_type: 'Danh từ',
    meaning_vi: 'nước mắt, giọt lệ',
    examples: [
      {
        chinese: '听到远方亲人平安归来的喜讯，母亲忍不住流下了激动的热泪。',
        pinyin: 'Tīngdào yuǎnfāng qīnrén píng’ān guīlái de xǐxùn, mǔqīn rěnbuzhù liúxià le jīdòng de rèlèi.',
        meaning_vi: 'Nghe được tin vui người thân nơi phương xa bình an trở về, người mẹ không kìm được đã rơi những giọt nước mắt nghẹn ngào xúc động.',
        difficulty_level: 'basic'
      },
      {
        chinese: '这部展现志愿军战士在冰天雪地中浴血保家卫国的战争电影催人泪下，每一个观众的眼眶里都饱含着对英烈的崇高敬意之泪。',
        pinyin: 'Zhè bù zhǎnxiàn zhìyuànjūn zhànshì zài bīngtiān-xuědì zhōng yùxiě bǎojiā-wèiguó de zhànzhēng diànyǐng cuīrén-lèixià, měi yí gè guānzhòng de yǎnkuàng lǐ dōu bǎohán zhe duì yīngliè de chónggāo jìngyì zhī lèi.',
        meaning_vi: 'Bộ phim chiến tranh tái hiện những người lính quân tình nguyện đổ máu bảo vệ quê hương giữa trời băng tuyết rơi đã lấy đi bao giọt nước mắt, khóe mắt của từng khán giả đều đong đầy những giọt lệ thành kính tri ân các bậc anh hùng liệt sĩ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2693,
    hanzi: '类',
    pinyin: 'lèi',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'loài, loại, thể loại, dạng',
    examples: [
      {
        chinese: '超市的货架上将食品、日用品和文具等不同类别的商品划分得非常清晰。',
        pinyin: 'Chāoshì de huòjià shang jiāng shípǐn, rìyòngpǐn hé wénjù děng bùtóng lèibié de shāngpǐn huàfēn de fēicháng qīngxī.',
        meaning_vi: 'Trên các kệ hàng siêu thị phân chia rành mạch các chủng loại sản phẩm khác nhau như thực phẩm, đồ dùng sinh hoạt và văn phòng phẩm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在大数据时代，机器学习聚类算法能够根据用户的消费行为特征，将海量客户精准划分至不同的细分消费群体类别中。',
        pinyin: 'Zài dàshùjù shídài, jīqì xuéxí jùlèi suànfǎ nénggòu gēnjù yònghù de xiāofèi xíngwéi tèzhēng, jiāng hǎiliàng kèhù jīngzhǔn huàfēn zhì bùtóng de xìfēn xiāofèi qúntǐ lèibié zhōng.',
        meaning_vi: 'Trong kỷ nguyên dữ liệu lớn, các thuật toán phân cụm học máy có thể căn cứ vào đặc trưng hành vi tiêu dùng của người dùng để phân loại chuẩn xác lượng lớn khách hàng vào từng nhóm đối tượng người tiêu dùng ngách khác nhau.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2694,
    hanzi: '泪水',
    pinyin: 'lèishuǐ',
    word_type: 'Danh từ',
    meaning_vi: 'nước mắt, giọt nước mắt',
    examples: [
      {
        chinese: '在毕业典礼上，大家互相拥抱道别，眼中闪烁着依依不舍的泪水。',
        pinyin: 'Zài bìyè diǎnlǐ shang, dàjiā hùxiāng yōngbào dàobié, yǎnzhōng shǎnshuò zhe yīyī-bùshě de lèishuǐ.',
        meaning_vi: 'Trong buổi lễ tốt nghiệp, mọi người ôm nhau tạm biệt, trong ánh mắt ai nấy đều lấp lánh những giọt nước mắt lưu luyến bịn rịn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '夺冠那一刻，老将回想起多年来经受严重伤病困扰所付出的无数汗水与辛酸泪水，终于在领奖台上绽放出了欣慰的笑容。',
        pinyin: 'Duóguàn nà yí kè, lǎojiàng huíxiǎng qǐ duō nián lái jīngshòu yánzhòng shāngbìng kùnrǎo suǒ fùchū de wúshù hànshuǐ yǔ xīnsuān lèishuǐ, zhōngyú zài lǐngjiǎngtái shang zhànfàng chū le xīnwèi de xiàoróng.',
        meaning_vi: 'Khoảnh khắc đăng quang, người vận động viên kỳ cựu nhớ lại biết bao mồ hôi và những giọt nước mắt cay đắng đã bỏ ra suốt bao năm dài chịu đựng chấn thương hành hạ, cuối cùng đã nở nụ cười mãn nguyện trên bục nhận huy chương.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2695,
    hanzi: '类似',
    pinyin: 'lèisì',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'tương tự, giống như, na ná',
    examples: [
      {
        chinese: '这两款手机在外观设计上非常类似，但在内部硬件配置上差别很大。',
        pinyin: 'Zhè liǎng kuǎn shǒujī zài wàiguān shèjì shang fēicháng lèisì, dàn zài nèibù yìngjiàn pèizhì shang chābié hěn dà.',
        meaning_vi: 'Hai mẫu điện thoại này về thiết kế kiểu dáng bề ngoài rất tương tự nhau, nhưng về cấu hình phần cứng bên trong lại khác biệt rất lớn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为防范类似硅谷银行倒闭所引发的流动性挤兑风险再次发生，全球主要央行纷纷强化了对商业银行资产负债表久期错配的压力测试监管。',
        pinyin: 'Wèi fángfàn lèisì Guīgǔ Yínháng dǎobì suǒ yǐnfā de liúdòngxìng jǐduì fēngxiǎn zàicì fāshēng, quánqiú zhǔyào yāngháng fēnfēn qiánghuà le duì shāngyè yínháng zīchǎn-fùzhàibiǎo jiǔqī cuòpèi de yālì cèshì jiānguǎn.',
        meaning_vi: 'Nhằm phòng ngừa những rủi ro tháo chạy thanh khoản tương tự như vụ sụp đổ của Ngân hàng Thung lũng Silicon tái diễn, các ngân hàng trung ương lớn trên toàn cầu đã đồng loạt siết chặt giám sát kiểm tra sức chịu tải đối với sự lệch pha kỳ hạn trên bảng cân đối kế toán của các ngân hàng thương mại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2696,
    hanzi: '类型',
    pinyin: 'lèixíng',
    word_type: 'Danh từ',
    meaning_vi: 'kiểu loại, mô hình, hình mẫu, thể loại',
    examples: [
      {
        chinese: '在图书馆借书时，他偏爱科幻与悬疑推理这两种类型的长篇小说。',
        pinyin: 'Zài túshūguǎn jiè shū shí, tā piān’ài kēhuàn yǔ xuányí tuīlǐ zhè liǎng zhǒng lèixíng de chángpiān xiǎoshuō.',
        meaning_vi: 'Khi mượn sách ở thư viện, cậu ấy đặc biệt thích hai thể loại tiểu thuyết dài kỳ là khoa học viễn tưởng và trinh thám ly kỳ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代企业治理体系需要根据资本结构与行业周期的不同类型，因企制宜构建权责法定、运转高效且制衡有效的现代化董事会运作机制。',
        pinyin: 'Xiàndài qǐyè zhìlǐ tǐxì xūyào gēnjù zīběn jiégòu yǔ hángyè zhōuqī de bùtóng lèixíng, yīnqǐ-zhìyí gòujiàn quánzé fǎdìng, yùnzhuǎn gāoxiào qiě zhìhéng yǒuxiào de xiàndàihuà dǒngshìhuì yùnzuò jīzhì.',
        meaning_vi: 'Hệ thống quản trị doanh nghiệp hiện đại đòi hỏi phải căn cứ vào các loại hình cơ cấu vốn và chu kỳ ngành nghề khác nhau, linh hoạt áp dụng theo từng doanh nghiệp để xây dựng cơ chế vận hành hội đồng quản trị hiện đại có thẩm quyền và trách nhiệm pháp định, vận hành hiệu quả cao và kiểm soát kiềm chế lẫn nhau hiệu lực.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2697,
    hanzi: '梨',
    pinyin: 'lí',
    word_type: 'Danh từ',
    meaning_vi: 'quả lê, cây lê',
    examples: [
      {
        chinese: '秋燥季节里，炖一碗冰糖雪梨汤具有很好的润肺止咳功效。',
        pinyin: 'Qiūzào jìjié lǐ, dùn yì wǎn bīngtáng xuělítāng jùyǒu hěn hǎo de rùnfèi zhǐké gōngxiào.',
        meaning_vi: 'Trong mùa hanh khô mùa thu, chưng một bát canh lê đường phèn có công hiệu bổ phổi giảm ho rất tốt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家级特色果树良种繁育基地通过精准杂交与分子标记辅助育种，培育出了皮薄汁丰、耐储运的特级优质玉露香梨新品种。',
        pinyin: 'Guójiājí tèsè guǒshù liángzhǒng fányù jīdì tōngguò jīngzhǔn zájiāo yǔ fēnzǐ biāojì fǔzhù yùzhǒng, péiyù chū le pí báo zhī fēng, nài chǔyùn de tèjí yōuzhì Yùlù Xiānglí xīn pǐnzhǒng.',
        meaning_vi: 'Cơ sở chọn tạo giống cây ăn quả đặc sản cấp quốc gia thông qua phương pháp lai chính xác và nhân giống hỗ trợ chỉ thị phân tử, đã lai tạo ra giống lê thơm Ngọc Lộ thượng hạng mới mỏng vỏ mọng nước và chịu được bảo quản vận chuyển.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2698,
    hanzi: '离婚',
    pinyin: 'líhūn',
    word_type: 'Động từ',
    meaning_vi: 'ly hôn, ly dị',
    examples: [
      {
        chinese: '夫妻双方如果感情确已破裂，可以通过法律程序协商申请协议离婚。',
        pinyin: 'Fūqī shuāngfāng rúguǒ gǎnqíng què yǐ pòliè, kěyǐ tōngguò fǎlǜ chéngxù xiéshāng shēnqǐng xiéyì líhūn.',
        meaning_vi: 'Hai bên vợ chồng nếu tình cảm thực sự đã rạn nứt, có thể thông qua trình tự pháp lý để thương lượng nộp đơn thuận tình ly hôn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '我国《民法典》婚姻家庭编确立了三十天“离婚冷静期”制度，旨在引导夫妻双方理性对待婚姻家庭矛盾，切实减少冲动型离婚现象。',
        pinyin: 'Wǒ guó 《Mínfǎdiǎn》 hūnyīn jiātíng biān quèlì le sānshí tiān “líhūn lěngjìngqī” zhìdù, zhǐzài yǐndǎo fūqī shuāngfāng lǐxìng duìdài hūnyīn jiātíng máodùn, qièshí jiǎnshǎo chōngdòngxíng líhūn xiànxiàng.',
        meaning_vi: 'Phần Hôn nhân và Gia đình trong "Bộ luật Dân sự" nước ta đã xác lập chế định "thời hạn cân nhắc ly hôn" kéo dài 30 ngày, nhằm dẫn dắt hai vợ chồng nhìn nhận lý trí các mâu thuẫn gia đình hôn nhân, giảm bớt thiết thực hiện tượng ly hôn do bốc đồng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2699,
    hanzi: '厘米',
    pinyin: 'límǐ',
    word_type: 'Lượng từ',
    meaning_vi: 'xăng-ti-mét (cm)',
    examples: [
      {
        chinese: '这本精装字典的长约二十厘米，宽约十五厘米，便于随身携带查阅。',
        pinyin: 'Zhè běn jīngzhuāng zìdiǎn de cháng yuē èrshí límǐ, kuān yuē shíwǔ límǐ, biànyú suíshēn xiédài cháyuè.',
        meaning_vi: 'Cuốn từ điển bìa cứng này dài khoảng 20 cm, rộng khoảng 15 cm, tiện mang theo bên mình để tra cứu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在现代高精密度北斗地基增强系统定位服务中，其动态差分定位精度已可达到厘米级甚至毫米级，为高级自动驾驶提供了高可靠时空基准。',
        pinyin: 'Zài xiàndài gāo jīngmìdù Běidǒu dìjī zēngqiáng xìtǒng dìngwèi fúwù zhōng, qí dòngtài chāfēn dìngwèi jīngdù yǐ kě dádào límǐ jí shènzhì háomǐ jí, wèi gāojí zìdòng jiàshǐ tígōng le gāo kěkào shíkōng jīzhǔn.',
        meaning_vi: 'Trong dịch vụ định vị hệ thống tăng cường trên mặt đất Bắc Đẩu độ chính xác cao hiện đại, độ chuẩn xác định vị vi sai động học của nó đã có thể đạt tới cấp xăng-ti-mét thậm chí là milimet, mang lại mốc chuẩn không gian - thời gian có độ tin cậy cao cho việc tự lái xe cấp cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2700,
    hanzi: '离职',
    pinyin: 'lízhí',
    word_type: 'Động từ',
    meaning_vi: 'thôi việc, nghỉ việc, rời vị trí công tác',
    examples: [
      {
        chinese: '员工在正式离职前，应当依照劳动合同约定提前一个月提交书面辞职信。',
        pinyin: 'Yuángōng zài zhèngshì lízhí qián, yīngdāng yīzhào láodòng hétong yuēdìng tíqián yí gè yuè tíjiāo shūmiàn cízhíxìn.',
        meaning_vi: 'Nhân viên trước khi chính thức thôi việc nên nộp đơn xin từ chức bằng văn bản trước một tháng theo đúng thỏa thuận hợp đồng lao động.',
        difficulty_level: 'basic'
      },
      {
        chinese: '根据国家反不正当竞争法与劳动合同法规定，掌握企业商业机密的高管在离职后必须严格履行约定的竞业限制义务。',
        pinyin: 'Gēnjù guójiā fǎn bùzhèngdàng jìngzhēng fǎ yǔ láodòng hétong fǎ guīdìng, zhǎngwò qǐyè shāngyè jīmì de gāoguǎn zài lízhí hòu bìxū yángé lǚxíng yuēdìng de jìngyè xiànzhì yìwù.',
        meaning_vi: 'Theo quy định của Luật Chống cạnh tranh không lành mạnh và Luật Hợp đồng lao động quốc gia, các cán bộ quản lý cấp cao nắm giữ bí mật thương mại của doanh nghiệp sau khi nghỉ việc bắt buộc phải thực hiện nghiêm túc nghĩa vụ hạn chế cạnh tranh đã thỏa thuận.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2701,
    hanzi: '理论',
    pinyin: 'lǐlùn',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'lý luận, lý thuyết; phân bua, tranh cãi lý lẽ',
    examples: [
      {
        chinese: '我们不仅要学好书本上的专业理论，更要注重在实践中灵活运用。',
        pinyin: 'Wǒmen bùjǐn yào xuéhǎo shūběn shang de zhuānyè lǐlùn, gèng yào zhùzhòng zài shíjiàn zhōng línghuó yùnyòng.',
        meaning_vi: 'Chúng ta không chỉ phải học giỏi lý thuyết chuyên môn trên sách vở, mà càng phải coi trọng việc vận dụng linh hoạt trong thực tiễn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '当代马克思主义中国化时代化的重大理论创新成果，深刻回答了新时代坚持和发展中国特色社会主义的一系列重大时代课题。',
        pinyin: 'Dāngdài Mǎkèsī-zhǔyì Zhōngguóhuà shídàihuà de zhòngdà lǐlùn chuàngxīn chéngguǒ, shēnkè huídá le xīn shídài jiānchí hé fāzhǎn Zhōngguó tèsè shèhuì zhǔyì de yí xìliè zhòngdà shídài kètí.',
        meaning_vi: 'Thành quả đổi mới sáng tạo lý luận trọng đại về Trung Quốc hóa và hiện đại hóa chủ nghĩa Mác đương đại đã giải đáp sâu sắc một loạt các vấn đề thời đại lớn về việc kiên trì và phát triển chủ nghĩa xã hội mang đặc sắc Trung Quốc trong thời đại mới.',
        difficulty_level: 'applied'
      }
    ]
  }
]
