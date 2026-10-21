// data/hsk5-batch7-part2-data.ts
// 25 từ HSK 5: #2627 [酒吧] -> #2651 [开幕]

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

export const HSK5_BATCH7_PART2: VocabItem[] = [
  {
    id: 2627,
    hanzi: '酒吧',
    pinyin: 'jiǔbā',
    word_type: 'Danh từ',
    meaning_vi: 'quán rượu, quán bar',
    examples: [
      {
        chinese: '周末晚上，几个老朋友喜欢相约在静谧的酒吧里聊天听民谣。',
        pinyin: 'Zhōumò wǎnshang, jǐ gè lǎo péngyou xǐhuan xiāngyuē zài jìngmì de jiǔbā lǐ liáotiān tīng mínyáo.',
        meaning_vi: 'Tối cuối tuần, mấy người bạn cũ thích hẹn nhau ở một quán bar yên tĩnh để trò chuyện và nghe nhạc dân ca.',
        difficulty_level: 'basic'
      },
      {
        chinese: '城市文化旅游街区通过规范发展特色主题音乐酒吧与文创演艺空间，极大地激活了夜间经济的消费新活力。',
        pinyin: 'Chéngshì wénhuà lǚyóu jiēqū tōngguò guīfàn fāzhǎn tèsè zhǔtí yīnyuè jiǔbā yǔ wénchuàng yǎnyì kōngjiān, jídà de jīhuó le yèjiān jīngjì de xiāofèi xīn huólì.',
        meaning_vi: 'Tuyến phố du lịch văn hóa đô thị thông qua việc định hướng phát triển các quán bar âm nhạc chủ đề độc đáo và không gian biểu diễn sáng tạo văn hóa đã khơi dậy mạnh mẽ sức sống tiêu dùng mới cho nền kinh tế đêm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2628,
    hanzi: '久远',
    pinyin: 'jiǔyuǎn',
    word_type: 'Tính từ',
    meaning_vi: 'lâu đời, xa xưa, thăm thẳm',
    examples: [
      {
        chinese: '由于年代久远，这本古籍书页上的字迹已经有些泛黄模糊了。',
        pinyin: 'Yóuyú niándài jiǔyuǎn, zhè běn gǔjí shūyè shang de zìjì yǐjīng yǒuxiē fànhuáng móhu le.',
        meaning_vi: 'Do thời gian đã quá lâu đời, nét chữ trên những trang sách cổ này đã có phần ố vàng và mờ nhạt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '考古队在地下遗址中发掘出大量青铜礼器，将该流域先民文明起源的历史向前推进到了更为久远的石器时代末期。',
        pinyin: 'Kǎogǔduì zài dìxià yízhǐ zhōng fājué chū dàliàng qīngtóng lǐqì, jiāng gāi liùyù xiānmín wénmíng qǐyuán de lìshǐ xiàng qián tuījìn dào le gèng wéi jiǔyuǎn de shíqì shídài mòqī.',
        meaning_vi: 'Đội khảo cổ đã khai quật được số lượng lớn đồ lễ bằng đồng thau trong khu di chỉ dưới lòng đất, đẩy lùi lịch sử khởi nguồn văn minh của cư dân cổ vùng lưu vực này về thời kỳ cuối thời đồ đá xa xưa hơn nữa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2629,
    hanzi: '救',
    pinyin: 'jiù',
    word_type: 'Động từ',
    meaning_vi: 'cứu, cứu giúp, cứu chữa, giải cứu',
    examples: [
      {
        chinese: '见有儿童不慎落水，路过的一位热心青年毫不犹豫地跳入水中将他救起。',
        pinyin: 'Jiàn yǒu értóng búshèn luòshuǐ, lùguò de yí wèi rèxīn qīngnián háobù-yóuyù de tiàorù shuǐzhōng jiāng tā jiùqǐ.',
        meaning_vi: 'Trông thấy có đứa trẻ sơ ý ngã xuống nước, một thanh niên nhiệt tình đi ngang qua đã không chút do dự nhảy xuống nước cứu em lên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对重度烧伤合并多器官衰竭的危重病患，多学科医疗专家团队通力协作连续抢救数十个小时，终于将患者从死神手中抢救回来。',
        pinyin: 'Miànduì zhòngdù shāoshāng hébìng duō qìguān shuāijié de wēizhòng bìnghuàn, duō xuékē yīliáo zhuānjiā tuánduì tōnglì xiézuò liánxù qiǎngjiù shù shí gè xiǎoshí, zhōngyú jiāng huànzhě cóng sǐshén shǒuzhōng qiǎngjiù huílái.',
        meaning_vi: 'Đối mặt với bệnh nhân nguy kịch bị bỏng nặng kèm theo suy đa cơ quan, đội ngũ chuyên gia y tế đa chuyên khoa đã hợp lực liên tục cấp cứu hàng chục tiếng đồng hồ, cuối cùng đã cứu sống được người bệnh từ tay thần chết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2630,
    hanzi: '救护车',
    pinyin: 'jiùhùchē',
    word_type: 'Danh từ',
    meaning_vi: 'xe cứu thương, xe cấp cứu',
    examples: [
      {
        chinese: '听见救护车的警笛声，公路上行驶的所有车辆都主动向两侧让行。',
        pinyin: 'Tīngjiàn jiùhùchē de jǐngdí shēng, gōnglù shang xíngshǐ de suǒyǒu chēliàng dōu zhǔdòng xiàng liǎngcè ràngxíng.',
        meaning_vi: 'Nghe thấy tiếng còi xe cứu thương, tất cả các phương tiện đang lưu thông trên đường đều chủ động nép sang hai bên để nhường đường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该现代化急救指挥中心配备了具备5G远程多参数诊疗功能的移动智能救护车，实现了患者“上车即入院”的生命急救全新模式。',
        pinyin: 'Gāi xiàndàihuà jíjiù zhǐhuī zhōngxīn pèibèi le jùbèi 5G yuǎnchéng duō cānshù zhěnliáo gōngnéng de yídòng zhìnéng jiùhùchē, shíxiàn le huànzhě “shàngchē jí rùyuàn” de shēngmìng jíjiù quánxīn móshì.',
        meaning_vi: 'Trung tâm chỉ huy cấp cứu hiện đại này được trang bị xe cứu thương thông minh di động tích hợp tính năng chẩn đoán đa thông số từ xa qua 5G, hiện thực hóa mô hình cấp cứu sinh mạng hoàn toàn mới: "bước lên xe là vào viện".',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2631,
    hanzi: '就业',
    pinyin: 'jiùyè',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'việc làm, tìm việc, giải quyết việc làm',
    examples: [
      {
        chinese: '大学毕业后，他通过校园招聘顺利在一家知名软件公司实现了就业。',
        pinyin: 'Dàxué bìyè hòu, tā tōngguò xiàoyuán zhāopìn shùnlì zài yì jiā zhīmíng ruǎnjiàn gōngsī shíxiàn le jiùyè.',
        meaning_vi: 'Sau khi tốt nghiệp đại học, anh ấy thông qua hội chợ tuyển dụng trong trường đã thuận lợi tìm được việc làm tại một công ty phần mềm nổi tiếng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家坚持实施就业优先战略，通过减税降费与普惠金融贷款扶持中小微企业稳岗扩岗，千方百计确保高校毕业生等重点群体高质量充分就业。',
        pinyin: 'Guójiā jiānchí shíshī jiùyè yōuxiān zhànlüè, tōngguò jiǎnshuì-jiàngfèi yǔ pǔhuì jīnróng dàikuǎn fúchí zhōng-xiǎo-wēi qǐyè wěngǎng-kuògǎng, qiānfāng-bǎijì quèbǎo gāoxiào bìyèshēng děng zhòngdiǎn qúntǐ gāo zhìliàng chōngfèn jiùyè.',
        meaning_vi: 'Nhà nước kiên trì thực hiện chiến lược ưu tiên việc làm, thông qua miễn giảm thuế phí và tín dụng tài chính toàn diện để hỗ trợ doanh nghiệp vừa và nhỏ giữ vững và mở rộng vị trí việc làm, bằng mọi cách bảo đảm các nhóm đối tượng trọng điểm như sinh viên tốt nghiệp có được việc làm đầy đủ và chất lượng cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2632,
    hanzi: '居民',
    pinyin: 'jūmín',
    word_type: 'Danh từ',
    meaning_vi: 'cư dân, người dân, người cư trú',
    examples: [
      {
        chinese: '社区居委会定期组织志愿者为辖区内的高龄独居居民上门提供生活照料。',
        pinyin: 'Shèqū jūwěihuì dìngqī zǔzhī yuànzhě wèi xiáqū nèi de gāolíng dújū jūmín shàngmén tígōng shēnghuó zhàoliào.',
        meaning_vi: 'Ban quản lý khu dân cư định kỳ tổ chức tình nguyện viên đến tận nhà chăm sóc đời sống cho các cư dân cao tuổi sống một mình trong địa bàn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '城市老旧小区微改造工程广泛听取常住居民的合理诉求，增设加装电梯与无障碍设施，显著提升了社区居民的获得感与幸福感。',
        pinyin: 'Chéngshì lǎojiù xiǎoqū wēi-gǎizào gōngchéng guǎngfàn tīngqǔ chángzhù jūmín de hélǐ sùqiú, zēngshè jiāzhuāng diàntī yǔ wúzhàng’ài shèshī, xiǎnzhù tíshēng le shèqū jūmín de huòdégǎn yǔ xìngfúgǎn.',
        meaning_vi: 'Công trình vi cải tạo các khu chung cư cũ trong đô thị đã lắng nghe sâu rộng những nguyện vọng chính đáng của cư dân thường trú, lắp đặt thêm thang máy và trang thiết bị không rào cản, nâng cao rõ rệt cảm giác thụ hưởng và hạnh phúc của cư dân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2633,
    hanzi: '居然',
    pinyin: 'jūrán',
    word_type: 'Phó từ',
    meaning_vi: 'lại, mà lại, không ngờ lại',
    examples: [
      {
        chinese: '这道如此复杂的数学竞赛难题，他居然只用了十分钟就解出了正确答案。',
        pinyin: 'Zhè dào rúcǐ fùzá de shùxué jìngsài nántí, tā jūrán zhǐ yòng le shí fēnzhōng jiù jiěchū le zhèngquè dá’àn.',
        meaning_vi: 'Bài toán thi học sinh giỏi phức tạp như thế này, cậu ấy lại chỉ mất đúng 10 phút là đã giải ra đáp án chính xác.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在极端干旱贫瘠的戈壁荒滩上，这批采用生物工程培育的新型防风固沙灌木居然顽强地扎根存活并长出了一片生机勃勃的绿洲。',
        pinyin: 'Zài jíduān gānhàn pínjí de gēbì huāngtān shang, zhè pī cǎiyòng shēngwù gōngchéng péiyù de xīnxíng fángfēng-gùshā guānmù jūrán wánqiáng de zhāgēn cúnhuó bìng zhǎngchū le yí piàn shēngjī-bóbó de lǜzhōu.',
        meaning_vi: 'Giữa bãi sỏi sa mạc Gobi khô cằn cùng cực, lứa cây bụi chắn gió giữ cát kiểu mới được lai tạo bằng công nghệ sinh học này không ngờ lại bén rễ sinh tồn kiên cường và vươn mình thành một ốc đảo tràn trề nhựa sống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2634,
    hanzi: '居住',
    pinyin: 'jūzhù',
    word_type: 'Động từ',
    meaning_vi: 'cư trú, sinh sống, ở',
    examples: [
      {
        chinese: '他们一家人在这座风景如画的海滨小城已经居住了十几年。',
        pinyin: 'Tāmen yì jiā rén zài zhè zuò fēngjǐng-rúhuà de hǎibīn xiǎochéng yǐjīng jūzhù le shí jǐ nián.',
        meaning_vi: 'Cả gia đình họ đã sinh sống hơn mười năm tại thành phố ven biển đẹp như tranh vẽ này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '生态宜居城市建设强调合理规划人居空间密度，营造人与自然和谐共生的高品质居住生态环境。',
        pinyin: 'Shēngtài yíjū chéngshì jiànshè qiángdiào hélǐ guīhuà rénjū kōngjiān mìdù, yíngzào rén yǔ zìrán héxié gòngshēng de gāo pǐnzhì jūzhù shēngtài huánjìng.',
        meaning_vi: 'Việc xây dựng đô thị sinh thái đáng sống nhấn mạnh việc quy hoạch hợp lý mật độ không gian định cư, kiến tạo môi trường sinh thái cư trú chất lượng cao nơi con người và tự nhiên chung sống hài hòa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2635,
    hanzi: '橘子',
    pinyin: 'júzi',
    word_type: 'Danh từ',
    meaning_vi: 'quả quýt',
    examples: [
      {
        chinese: '秋天果园里的橘子成熟了，金黄色的果实挂满了枝头。',
        pinyin: 'Qiūtiān guǒyuán lǐ de júzi chéngshú le, jīnhuángsè de guǒshí guàmǎn le zhītóu.',
        meaning_vi: 'Mùa thu quýt trong vườn đã chín, những quả quýt vàng óng trĩu nặng trên cành cây.',
        difficulty_level: 'basic'
      },
      {
        chinese: '农业科研团队利用航天诱变育种技术培育出无核多汁、富含花青素的特种优质沙糖橘新品种，有效助力了山区果农增产增收。',
        pinyin: 'Nóngyè kēyán tuánduì lìyòng hángtiān yòubiàn yùzhǒng jìshù péiyù chū wúhé duōzhī, fùhán huāqīngsù de tèzhǒng yōuzhì shātángjú xīn pǐnzhǒng, yǒuxiào zhùlì le shānqū guǒnóng zēngchǎn-zēngshōu.',
        meaning_vi: 'Đội ngũ nghiên cứu khoa học nông nghiệp đã ứng dụng kỹ thuật gây đột biến nhân giống trong không gian vũ trụ để lai tạo giống quýt đường không hạt mọng nước, giàu anthocyanin mới, hỗ trợ hiệu quả nông dân trồng cây ăn quả miền núi tăng sản lượng và thu nhập.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2636,
    hanzi: '据',
    pinyin: 'jù',
    word_type: 'Giới từ',
    meaning_vi: 'theo, căn cứ vào, theo như',
    examples: [
      {
        chinese: '据气象部门预报，明天傍晚本市将迎来一场雷阵雨。',
        pinyin: 'Jù qìxiàng bùmén yùbào, míngtiān bàngwǎn běn shì jiāng yínglái yì chǎng léizhènyǔ.',
        meaning_vi: 'Theo dự báo của cơ quan khí tượng, chiều tối mai thành phố sẽ đón một cơn mưa rào kèm sấm sét.',
        difficulty_level: 'basic'
      },
      {
        chinese: '据世界知识产权组织最新发布的全球创新指数报告显示，我国在专利申请总量与高科技集群规模方面连续多年位居全球领先地位。',
        pinyin: 'Jù Shìjiè Zhīshi Chǎnquán Zǔzhī zuìxīn fābù de quánqiú chuàngxīn zhǐshù bàogào xiǎnshì, wǒ guó zài zhuānlì shēnqǐng zǒngliàng yǔ gāo kējì jíqún guīmó fāngmiàn liánxù duō nián wèijū quánqiú lǐngxiān dìwèi.',
        meaning_vi: 'Căn cứ theo Báo cáo Chỉ số Đổi mới Sáng tạo Toàn cầu mới nhất do Tổ chức Sở hữu Trí tuệ Thế giới công bố, nước ta nhiều năm liên tiếp giữ vị trí hàng đầu thế giới về tổng số đơn đăng ký sáng chế và quy mô cụm công nghệ cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2637,
    hanzi: '距',
    pinyin: 'jù',
    word_type: 'Động từ',
    meaning_vi: 'cách, cự ly, khoảng cách so với',
    examples: [
      {
        chinese: '我们新搬的家距地铁站只有五分钟的步行路程，出行非常便利。',
        pinyin: 'Wǒmen xīn bān de jiā jù dìtiězhàn zhǐyǒu wǔ fēnzhōng de bùxíng lùchéng, chūxíng fēicháng biànlì.',
        meaning_vi: 'Ngôi nhà mới chuyển của chúng tôi chỉ cách ga tàu điện ngầm 5 phút đi bộ, đi lại vô cùng thuận tiện.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该深水钻井平台距海岸线数百海里，依靠先进的动力定位系统在十级狂风巨浪中依然能保持稳定作业。',
        pinyin: 'Gāi shēnshuǐ zuànjǐng píngtái jù hǎi’ànxiàn shù bǎi hǎilǐ, yīkào xiānjìn de dònglì dìngwèi xìtǒng zài shí jí kuángfēng-jùlàng zhōng yīrán néng bǎochí wěndìng zuòyè.',
        meaning_vi: 'Giàn khoan nước sâu này cách bờ biển hàng trăm hải lý, nhờ vào hệ thống định vị động học tiên tiến vẫn có thể duy trì hoạt động tác nghiệp ổn định giữa sóng to gió lớn cấp 10.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2638,
    hanzi: '具备',
    pinyin: 'jùbèi',
    word_type: 'Động từ',
    meaning_vi: 'có đủ, hội tụ đủ, trang bị đủ',
    examples: [
      {
        chinese: '应聘该岗位的人员需要具备扎实的专业理论基础和良好的团队沟通能力。',
        pinyin: 'Yìngpìn gāi gǎngwèi de rényuán xūyào jùbèi zhāshi de zhuānyè lǐlùn jīchǔ hé liánghǎo de tuánduì gōutōng nénglì.',
        meaning_vi: 'Ứng viên ứng tuyển vị trí này cần phải có nền tảng lý thuyết chuyên môn vững vàng và khả năng giao tiếp đội nhóm tốt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该超大型深远海海上风力发电机组具备抵御超强台风与深海强腐蚀环境的卓越性能，标志着我国海上风电整机装备制造迈入世界先进行列。',
        pinyin: 'Gāi chāodàxíng shēnyuǎnhǎi hǎishàng fēnglì fādiǎnjǐ zǔ jùbèi dǐyù chāoqiáng táifēng yǔ shēnhǎi qiáng fǔshí huánjìng de zhuóyuè xìngnéng, biāozhì zhe wǒ guó hǎishàng fēngdiàn zhěngjī zhuāngbèi zhìzào màirù shìjiè xiānjìn hángliè.',
        meaning_vi: 'Tổ máy phát điện gió ngoài khơi vùng biển xa siêu lớn này hội tụ đủ hiệu năng vượt trội để chống chịu các siêu bão và môi trường biển sâu ăn mòn cực mạnh, đánh dấu việc chế tạo thiết bị máy phát điện gió ngoài khơi trọn bộ của nước ta đã bước vào hàng ngũ tiên tiến thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2639,
    hanzi: '剧场',
    pinyin: 'jùchǎng',
    word_type: 'Danh từ',
    meaning_vi: 'nhà hát, rạp hát',
    examples: [
      {
        chinese: '今晚市中心大剧场将上演一场精彩纷呈的芭蕾舞剧。',
        pinyin: 'Jīnwǎn shì zhōngxīn dà jùchǎng jiāng shàngyǎn yì chǎng jīngcǎi-fēncéng de bālěiwǔ jù.',
        meaning_vi: 'Tối nay tại đại nhà hát trung tâm thành phố sẽ công diễn một vở kịch múa ballet vô cùng đặc sắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '新建成的国家级歌剧院剧场不仅采用了全球顶尖的声学反射空间设计，更配备了全景三维沉浸式声场渲染系统。',
        pinyin: 'Xīnjiàn chéng de guójiājí gējùyuàn jùchǎng bùjǐn cǎiyòng le quánqiú dǐngjiān de shēngxué fǎnshè kōngjiān shèjì, gèng pèibèi le quánjǐng sānwéi chénjìnshì shēngchǎng xuànrǎn xìtǒng.',
        meaning_vi: 'Nhà hát kịch tầm cỡ quốc gia mới khánh thành không chỉ ứng dụng thiết kế không gian phản xạ âm học đỉnh cao thế giới, mà còn được trang bị hệ thống dựng trường âm chìm đắm không gian 3 chiều toàn cảnh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2640,
    hanzi: '巨大',
    pinyin: 'jùdà',
    word_type: 'Tính từ',
    meaning_vi: 'to lớn, khổng lồ, vĩ đại',
    examples: [
      {
        chinese: '这项科研成果的成功转化给企业带来了巨大的经济效益。',
        pinyin: 'Zhè xiàng kēyán chéngguǒ de chénggōng zhuǎnhuà gěi qǐyè dàilái le jùdà de jīngjì xiàoyì.',
        meaning_vi: 'Việc chuyển giao thành công thành quả nghiên cứu khoa học này đã mang lại lợi ích kinh tế to lớn cho doanh nghiệp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对全球气候治理的巨大挑战与国际减排博弈，各国必须共同坚守公平合理、合作共赢的原则，携手构建人类命运共同体。',
        pinyin: 'Miànduì quánqiú qìhòu zhìlǐ de jùdà tiǎozhàn yǔ guójì jiǎnpái bóyì, gè guó bìxū gòngtóng jiānshǒu gōngpíng-hélǐ, hézuò-gòngyíng de yuánzé, xiéshǒu gòujiàn rénlèi mìngyùn gòngtóngtǐ.',
        meaning_vi: 'Đứng trước những thách thức to lớn của nền quản trị khí hậu toàn cầu và sự cạnh tranh giảm phát thải quốc tế, các quốc gia phải cùng giữ vững nguyên tắc công bằng hợp lý và hợp tác cùng thắng, chung tay xây dựng cộng đồng chung vận mệnh nhân loại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2641,
    hanzi: '据说',
    pinyin: 'jùshuō',
    word_type: 'Động từ',
    meaning_vi: 'nghe nói, nghe đồn, tương truyền',
    examples: [
      {
        chinese: '据说这家隐藏在老巷子深处的餐馆已经传承了祖孙四代人。',
        pinyin: 'Jùshuō zhè jiā yǐncáng zài lǎoxiàngzi shēnchù de cānguǎn yǐjīng chuánchéng le zǔ-sūn sì dài rén.',
        meaning_vi: 'Nghe nói quán ăn ẩn sâu trong con ngõ cổ này đã được truyền thừa qua 4 thế hệ ông cháu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '据说当地民间流传千年的古法酿酒工艺暗合天人合一之理，其发酵窖池中独特的微生物菌群至今仍吸引着众多中外生物学家前来考证探秘。',
        pinyin: 'Jùshuō dāngdì mínjiān liúchuán qiān nián de gǔfǎ niàngjiǔ gōngyì ànhé tiānrén-héyī zhī lǐ, qí fājiào jiàochí zhōng dútè de wēishēngwù jùnqún zhìjīn réng xīyǐn zhe zhòngduō zhōngwài shēngwùxuéjiā qiánlái kǎozhèng tànmì.',
        meaning_vi: 'Tương truyền kỹ thuật ủ rượu thủ công cổ truyền lưu truyền nghìn năm trong dân gian nơi đây ngầm khớp với đạo lý thiên nhân hợp nhất, quần thể vi sinh vật độc đáo trong các hầm lên men của nó cho đến nay vẫn thu hút đông đảo các nhà sinh vật học trong và ngoài nước tìm đến khảo chứng khám phá.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2642,
    hanzi: '具体',
    pinyin: 'jùtǐ',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'cụ thể, chi tiết, rõ ràng; cụ thể hóa',
    examples: [
      {
        chinese: '请你结合具体的案例详细说明这个理论概念。',
        pinyin: 'Qǐng nǐ jiéhé jùtǐ de ànlì xiángxì shuōmíng zhè gè lǐlùn gàiniàn.',
        meaning_vi: 'Xin bạn hãy kết hợp với các trường hợp ca bệnh cụ thể để thuyết minh chi tiết cho khái niệm lý luận này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '有关部门针对优化营商环境出台了一系列操作性极强的具体实施细则，明确了各项便民惠企审批事项的办理时限与标准流程。',
        pinyin: 'Yǒuguān bùmén zhēnduì yōuhuà yíngshāng huánjìng chūtái le yí xìliè cāozuòxìng jí qiáng de jùtǐ shíshī xìzé, míngquè le gè xiàng biànmín-huìqǐ shěnpī shìxiàng de bànlǐ shíxiàn yǔ biāozhǔn liúchéng.',
        meaning_vi: 'Các ban ngành hữu quan nhằm vào việc tối ưu hóa môi trường kinh doanh đã ban hành một chuỗi các điều khoản thực thi cụ thể có tính thực tế thao tác rất cao, nêu rõ thời hạn giải quyết và quy trình tiêu chuẩn cho từng thủ tục phê duyệt hỗ trợ doanh nghiệp và người dân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2643,
    hanzi: '具有',
    pinyin: 'jùyǒu',
    word_type: 'Động từ',
    meaning_vi: 'có, sở hữu, mang tính',
    examples: [
      {
        chinese: '这种新型环保材料具有重量轻、强度高和防火防水的特点。',
        pinyin: 'Zhè zhǒng xīnxíng huánbǎo cáiliào jùyǒu zhòngliàng qīng, qiángdù gāo hé fánghuǒ fángshuǐ de tèdiǎn.',
        meaning_vi: 'Loại vật liệu bảo vệ môi trường kiểu mới này mang các đặc điểm nhẹ, cường độ cao và chống cháy chống thấm nước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '共建“一带一路”倡议是一项具有全球深远历史影响的世纪工程，为推动沿线国家基础设施联通与包容性经济增长注入了澎湃动能。',
        pinyin: 'Gòngjiàn “Yídài-Yílù” chàngyì shì yí xiàng jùyǒu quánqiú shēnyuǎn lìshǐ yǐngxiǎng de shìjì gōngchéng, wèi tuīdòng yánxiàn guójiā jīchǔ shèshī liántōng yǔ bāoróngxìng jīngjì zēngzhǎng zhùrù le péngpài dòngnéng.',
        meaning_vi: 'Sáng kiến cùng xây dựng "Vành đai và Con đường" là một công trình thế kỷ có sức ảnh hưởng lịch sử sâu rộng toàn cầu, tiếp thêm động năng mạnh mẽ thúc đẩy kết nối cơ sở hạ tầng và tăng trưởng kinh tế bao trùm cho các quốc gia dọc tuyến.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2644,
    hanzi: '捐',
    pinyin: 'juān',
    word_type: 'Động từ',
    meaning_vi: 'quyên góp, hiến tặng, ủng hộ',
    examples: [
      {
        chinese: '得知山区学校缺乏图书，同学们纷纷捐出了自己喜爱的课外书。',
        pinyin: 'Dézhī shānqū xuéxiào quēfá túshū, tóngxuémen fēnfēn juān chū le zìjǐ xǐ’ài de kèwàishū.',
        meaning_vi: 'Biết tin trường học vùng cao còn thiếu sách vở, các bạn học sinh đua nhau quyên góp những cuốn sách ngoại khóa mà mình yêu thích.',
        difficulty_level: 'basic'
      },
      {
        chinese: '爱心企业家在成立慈善教育基金会后，向多所国家重点高校累计捐赠数亿元人民币，专门用于奖励基础前沿学科的优秀青年学者。',
        pinyin: 'Àixīn qǐyèjiā zài chénglì císhàn jiàoyù jījīnhuì hòu, xiàng duō suǒ guójiā zhòngdiǎn gāoxiào lěijì juānzèng shù yì yuán Rénmínbì, zhuānmén yòngyú jiǎnglì jīchǔ qiányán xuékē de yōuxiù niánqīng xuézhě.',
        meaning_vi: 'Nhà doanh nghiệp giàu lòng hảo tâm sau khi thành lập quỹ giáo dục từ thiện đã quyên tặng lũy kế hàng trăm triệu nhân dân tệ cho nhiều trường đại học trọng điểm quốc gia, chuyên dùng để khen thưởng các học giả trẻ xuất sắc trong các ngành học khoa học cơ bản tiên phong.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2645,
    hanzi: '绝对',
    pinyin: 'juéduì',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'tuyệt đối, hoàn toàn',
    examples: [
      {
        chinese: '在任何体育竞技比赛中，运动员都必须绝对服从裁判员的判罚。',
        pinyin: 'Zài rènhé tǐyù jìngjì bǐsài zhōng, yùndòngyuán dōu bìxū juéduì fúcóng cáipànyuán de pànfá.',
        meaning_vi: 'Trong bất kỳ cuộc thi đấu thể thao nào, vận động viên đều phải tuyệt đối phục tùng phán quyết của trọng tài.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在航天载人飞船与空间站核心舱的交会对接任务中，姿态校准与相对测速必须做到绝对精确无误，容不得半点疏漏。',
        pinyin: 'Zài hángtiān zàirén fēichuán yǔ kōngjiānzhàn héxīncāng de jiāohuì-duìjiē rènwu zhōng, zītài xiàozhǔn yǔ xiāngduì cèsù bìxū zuòdào juéduì jīngquè-wúwù, róngbùdé bàndiǎnr shūlòu.',
        meaning_vi: 'Trong nhiệm vụ kết nối và tiếp cận giữa tàu vũ trụ có người lái và khoang lõi trạm không gian, việc hiệu chỉnh tư thế và đo tốc độ tương đối phải đạt tới độ chuẩn xác tuyệt đối không một sai sót, không cho phép có bất kỳ sơ suất nhỏ nào.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2646,
    hanzi: '决赛',
    pinyin: 'juésài',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'trận chung kết; thi chung kết',
    examples: [
      {
        chinese: '经过多轮顽强拼搏，我们学校的足球队终于挺进了全市总决赛。',
        pinyin: 'Jīngguò duō lún wánqiáng pīnbó, wǒmen xuéxiào de zúqiúduì zhōngyú tǐngjìn le quán shì zǒngjuésài.',
        meaning_vi: 'Qua nhiều vòng thi đấu kiên cường, đội bóng đá trường chúng tôi cuối cùng đã xuất sắc lọt vào trận chung kết toàn thành phố.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在奥运会乒乓球男子单打金牌决赛中，两位顶尖选手展现出了惊人的技战术水平和高超的抗压心理素养。',
        pinyin: 'Zài Àoyùnhuì pīngpāngqiú nánzǐ dāndǎ jīnpái juésài zhōng, liǎng wèi dǐngjiān xuǎnshǒu zhǎnxiàn chū le jīngrén de jì-zhànshù shuǐpíng hé gāochāo de kàngyā xīnlǐ sùyǎng.',
        meaning_vi: 'Tại trận chung kết tranh huy chương vàng đơn nam môn bóng bàn Thế vận hội Olympic, hai tay vợt đỉnh cao đã thể hiện trình độ kỹ chiến thuật đáng kinh ngạc và bản lĩnh tâm lý chịu áp lực siêu phàm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2647,
    hanzi: '角色',
    pinyin: 'juésè',
    word_type: 'Danh từ',
    meaning_vi: 'vai diễn, nhân vật; vai trò',
    examples: [
      {
        chinese: '那位老戏骨通过精湛的演技，把反面角色塑造得栩栩如生。',
        pinyin: 'Nà wèi lǎoxìgǔ tōngguò jīngzhàn de yǎnjì, bǎ fǎnmiàn juésè sùzào de xǔxǔ-rúshēng.',
        meaning_vi: 'Người diễn viên gạo cội ấy qua diễn xuất điêu luyện đã khắc họa nhân vật phản diện sống động như thật.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在推动多边全球气候治理与发展中国家绿色低碳转型的进程中，中国正扮演着越来越重要的建设性引领角色。',
        pinyin: 'Zài tuīdòng duōbiān quánqiú qìhòu zhìlǐ yǔ fāzhǎnzhōng guójiā lǜsè dītàn zhuǎnxíng de jìnchéng zhōng, Zhōngguó zhèng bànyǎn zhe yuèláiyuè zhòngyào de jiànshèxìng yǐnlǐng juésè.',
        meaning_vi: 'Trong tiến trình thúc đẩy quản trị khí hậu toàn cầu đa phương và chuyển đổi xanh ít phát thải của các quốc gia đang phát triển, Trung Quốc đang đảm nhận vai trò dẫn dắt mang tính xây dựng ngày càng quan trọng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2648,
    hanzi: '决心',
    pinyin: 'juéxīn',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'quyết tâm; hạ quyết tâm',
    examples: [
      {
        chinese: '新学期伊始，他下定决心要在期末考试中进入年级前十名。',
        pinyin: 'Xīn xuéqī yīshǐ, tā xiàdìng juéxīn yào zài qīmò kǎoshì zhōng jìnrù niánjí qián shí míng.',
        meaning_vi: 'Bắt đầu học kỳ mới, cậu ấy hạ quyết tâm sẽ lọt vào top 10 của khối trong kỳ thi cuối kỳ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '党和国家以壮士断腕的坚定政治决心推进党风廉政建设与反腐败斗争，赢得了全体人民群众的衷心拥护。',
        pinyin: 'Dǎng hé guójiā yǐ zhuàngshì-duànwàn de jiāndìng zhèngzhì juéxīn tuījìn dǎngfēng liánzhèng jiànshè yǔ fǎnfǔbài dòuzhēng, yíngdé le quántǐ rénmín qúnzhòng de zhōngxīn yōnghù.',
        meaning_vi: 'Đảng và Nhà nước với quyết tâm chính trị kiên định sẵn sàng hy sinh để làm trong sạch bộ máy đã đẩy mạnh việc xây dựng liêm chính và đấu tranh phòng chống tham nhũng, giành được sự ủng hộ chân thành của toàn thể quần chúng nhân dân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2649,
    hanzi: '开发',
    pinyin: 'kāifā',
    word_type: 'Động từ',
    meaning_vi: 'phát triển, khai thác, lập trình phát triển (phần mềm, tài nguyên)',
    examples: [
      {
        chinese: '技术研发小组历经数月成功开发出了一款操作简便的手机办公软件。',
        pinyin: 'Jìshù yánfā xiǎozǔ lìjīng shù yuè chénggōng kāifā chū le yì kuǎn cāozuò jiǎnbiàn de shǒujī bàngōng ruǎnjiàn.',
        meaning_vi: 'Nhóm nghiên cứu kỹ thuật trải qua mấy tháng đã phát triển thành công một phần mềm văn phòng trên điện thoại với thao tác đơn giản.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该国家级新区坚持统筹集约原则，大力开发利用深层地热能、风能与陆上光伏等清洁绿色可再生能源。',
        pinyin: 'Gāi guójiājí xīnqū jiānchí tǒngchóu jíyuē yuánzé, dàlì kāifā lìyòng shēncéng dìrènéng, fēngnéng yǔ lùshang guāngfú děng qīngjié lǜsè kězàishēng néngyuán.',
        meaning_vi: 'Khu đô thị mới cấp quốc gia này kiên trì nguyên tắc quy hoạch tập trung tiết kiệm, đẩy mạnh khai thác và sử dụng các nguồn năng lượng tái tạo xanh sạch như năng lượng địa nhiệt tầng sâu, năng lượng gió và điện mặt trời trên mặt đất.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2650,
    hanzi: '开放',
    pinyin: 'kāifàng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'mở cửa, cởi mở; nở hoa; tự do',
    examples: [
      {
        chinese: '市立图书馆的自习室每周末对全市市民免费开放。',
        pinyin: 'Shìlì túshūguǎn de zìxíshì měi zhōumò duì quán shì shìmín miǎnfèi kāifàng.',
        meaning_vi: 'Phòng tự học của thư viện thành phố mở cửa miễn phí cho toàn thể cư dân thành phố vào mỗi cuối tuần.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国坚定不移奉行互利共赢的对外开放战略，持续放宽外资市场准入并积极对标高标准国际经贸规则。',
        pinyin: 'Zhōngguó jiāndìng-bùyí fèngxíng hùlì-gòngyíng de duìwài kāifàng zhànlüè, chíxù fàngkuān wàizī shìchǎng zhǔnrù bìng jījí duìbiāo gāo biāozhǔn guójì jīngmào guīzé.',
        meaning_vi: 'Trung Quốc kiên định thực thi chiến lược mở cửa đối ngoại cùng có lợi cùng thắng, liên tục nới lỏng điều kiện tiếp cận thị trường đối với vốn đầu tư nước ngoài và chủ động tiệm cận các quy tắc kinh tế thương mại quốc tế tiêu chuẩn cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2651,
    hanzi: '开幕',
    pinyin: 'kāimù',
    word_type: 'Động từ',
    meaning_vi: 'khai mạc, mở màn',
    examples: [
      {
        chinese: '一年一度的国际青年文化交流艺术节在掌声中正式拉开帷幕。',
        pinyin: 'Yì nián yí dù de guójì qīngnián wénhuà jiāoliú yìshùjié zài zhǎngshēng zhōng zhèngshì lākāi wéimù.',
        meaning_vi: 'Liên hoan nghệ thuật giao lưu văn hóa thanh niên quốc tế thường niên đã chính thức mở màn trong tràng pháo tay rộn rã.',
        difficulty_level: 'basic'
      },
      {
        chinese: '世界互联网大会乌镇峰会隆重开幕，与会全球政要与科技领军企业家围绕数字经济合作与人工智能治理达成了广泛倡议。',
        pinyin: 'Shìjiè Hùliánwǎng Dàhuì Wūzhèn Fēnghuì lóngzhòng kāimù, yùhuì quánqiú zhèngyào yǔ kējì lǐngjūn qǐyèjiā wéirào shùzì jīngjì hézuò yǔ réngōng zhìnéng zhìlǐ dáchéng le guǎnfàn chàngyì.',
        meaning_vi: 'Hội nghị Thượng đỉnh Ô Trấn thuộc Hội nghị Internet Thế giới đã long trọng khai mạc, các chính khách toàn cầu cùng các doanh nhân công nghệ đầu ngành tham dự đã đạt được những sáng kiến rộng rãi xoay quanh hợp tác kinh tế số và quản trị trí tuệ nhân tạo.',
        difficulty_level: 'applied'
      }
    ]
  }
]
