// data/hsk5-batch7-part1-data.ts
// 25 từ HSK 5: #2602 [结合] -> #2626 [静]

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

export const HSK5_BATCH7_PART1: VocabItem[] = [
  {
    id: 2602,
    hanzi: '结合',
    pinyin: 'jiéhé',
    word_type: 'Động từ',
    meaning_vi: 'kết hợp, liên kết, phối hợp',
    examples: [
      {
        chinese: '学习外语时，要把理论语法知识与口语实际训练紧密结合起来。',
        pinyin: 'Xuéxí wàiyǔ shí, yào bǎ lǐlùn yǔfǎ zhīshi yǔ kǒuyǔ shíjì xùnliàn jǐnmì jiéhé qǐlái.',
        meaning_vi: 'Khi học ngoại ngữ, cần phải kết hợp chặt chẽ giữa kiến thức ngữ pháp lý thuyết với rèn luyện giao tiếp thực tế.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该研发项目坚持产学研深度结合，推动前沿实验室基础科学成果迅速转化为具备市场竞争力的高端产品。',
        pinyin: 'Gāi yánfā xiàngmù jiānchí chǎn-xué-yán shēndù jiéhé, tuīdòng qiányán shíyànshì jīchǔ kēxué chéngguǒ xùnsù zhuǎnhuà wéi jùbèi shìchǎng jìngzhēnglì de gāoduān chǎnpǐn.',
        meaning_vi: 'Dự án nghiên cứu này kiên trì kết hợp sâu rộng giữa doanh nghiệp, viện nghiên cứu và trường đại học, thúc đẩy các thành quả khoa học cơ bản nơi phòng thí nghiệm tiên phong chuyển hóa nhanh chóng thành sản phẩm cao cấp có sức cạnh tranh thị trường.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2603,
    hanzi: '结论',
    pinyin: 'jiélùn',
    word_type: 'Danh từ',
    meaning_vi: 'kết luận',
    examples: [
      {
        chinese: '在没有掌握充分证据之前，千万不要轻易下结论。',
        pinyin: 'Zài méiyǒu zhǎngwò chōngfèn zhèngjù zhīqián, qiānwàn bú yào qīngyì xià jiélùn.',
        meaning_vi: 'Trước khi nắm vững đầy đủ bằng chứng, tuyệt đối không nên vội vã đưa ra kết luận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '经过严谨的双盲对照实验与详尽的数据统计分析，专家组最终得出了该新型疫苗安全有效的科学结论。',
        pinyin: 'Jīngguò yánjǐn de shuāngmáng duìzhào shíyàn yǔ xiángjìn de shùjù tǒngjì fēnxī, zhuānjiāzǔ zuìzhōng déchū le gāi xīnxíng yìmiáo ānquán yǒuxiào de kēxué jiélùn.',
        meaning_vi: 'Trải qua thử nghiệm đối chứng mù đôi nghiêm ngặt cùng sự phân tích thống kê dữ liệu chi tiết, nhóm chuyên gia cuối cùng đã rút ra kết luận khoa học rằng loại vắc xin kiểu mới này an toàn và hiệu quả.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2604,
    hanzi: '节省',
    pinyin: 'jiéshěng',
    word_type: 'Động từ',
    meaning_vi: 'tiết kiệm, giảm bớt',
    examples: [
      {
        chinese: '出门随手关灯能够有效节省家庭用电开支。',
        pinyin: 'Chūmén suíshǒu guāndēng nénggòu yǒuxiào jiéshěng jiātíng yòngdiàn kāizhī.',
        meaning_vi: 'Ra ngoài tiện tay tắt đèn có thể tiết kiệm chi tiêu tiền điện sinh hoạt cho gia đình một cách hiệu quả.',
        difficulty_level: 'basic'
      },
      {
        chinese: '通过引入全自动化智能仓储物流分拣系统，该电商物流中心成功节省了近百分之三十的仓储运转与人工综合成本。',
        pinyin: 'Tōngguò yǐnrù quán zìdònghuà zhìnéng cāngchǔ wùliú fēnjiǎn xìtǒng, gāi diànshāng wùliú zhōngxīn chénggōng jiéshěng le jìn bǎifēnzhī sānshí de cāngchǔ yùnzhuǎn yǔ réngōng zōnghé chéngběn.',
        meaning_vi: 'Bằng cách đưa vào vận hành hệ thống phân loại hậu cần kho bãi thông minh hoàn toàn tự động, trung tâm logistics thương mại điện tử này đã tiết kiệm thành công gần 30% chi phí vận hành kho bãi và nhân công tổng hợp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2605,
    hanzi: '届',
    pinyin: 'jiè',
    word_type: 'Lượng từ / Danh từ',
    meaning_vi: 'khóa, nhiệm kỳ, kỳ (hội nghị, triển lãm, tốt nghiệp)',
    examples: [
      {
        chinese: '这所大学迎来了建校以来的第七十届毕业生。',
        pinyin: 'Zhè suǒ dàxué yínglái le jiànxiào yǐlái de dì-qīshí jiè bìyèshēng.',
        meaning_vi: 'Trường đại học này đã chào đón khóa sinh viên tốt nghiệp thứ 70 kể từ ngày thành lập trường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '本届中国国际进口博览会吸引了来自一百五十多个国家和地区的数千家跨国企业参展，达成了丰硕的经贸合作成果。',
        pinyin: 'Běn jiè Zhōngguó Guójì Jìnkǒu Bólǎnhuì xīyǐn le láizì yībǎi wǔshí duō gè guójiā hé dìqū de shù qiān jiā kuàguó qǐyè cānzhǎn, dáchéng le fēngshuò de jīngmào hézuò chéngguǒ.',
        meaning_vi: 'Hội chợ Triển lãm Nhập khẩu Quốc tế Trung Quốc kỳ này đã thu hút hàng nghìn doanh nghiệp đa quốc gia đến từ hơn 150 quốc gia và vùng lãnh thổ tham gia trưng bày, đạt được những thành quả hợp tác kinh tế thương mại phong phú.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2606,
    hanzi: '今日',
    pinyin: 'jīnrì',
    word_type: 'Danh từ',
    meaning_vi: 'hôm nay, ngày nay',
    examples: [
      {
        chinese: '今日的晨会主要讨论下半年的市场推广计划。',
        pinyin: 'Jīnrì de chénhuì zhǔyào tǎolùn xiàbànnián de shìchǎng tuīguǎng jìhuà.',
        meaning_vi: 'Cuộc họp buổi sáng hôm nay chủ yếu thảo luận về kế hoạch quảng bá thị trường trong nửa cuối năm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '抚今追昔，正是几代人艰苦卓绝的接续奋斗，才铸就了今日国家繁荣昌盛与人民安居乐业的崭新风貌。',
        pinyin: 'Fǔjīn-zhuīxī, zhèngshì jǐ dài rén jiānkǔ-zhuójué de jiēxù fèndòu, cái zhùjiù le jīnrì guójiā fánróng-chāngshèng yǔ rénmín ānjū-lèyè de zhǎnxīn fēngmào.',
        meaning_vi: 'Nhìn lại quá khứ để ngẫm về hôm nay, chính sự phấn đấu bền bỉ kiên cường của bao thế hệ mới tôi luyện nên diện mạo hoàn toàn mới của một đất nước phồn vinh thịnh vượng và nhân dân an cư lạc nghiệp ngày nay.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2607,
    hanzi: '紧',
    pinyin: 'jǐn',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'chặt, sít sao, khẩn cấp; eo hẹp (thời gian, tiền nong)',
    examples: [
      {
        chinese: '这双新鞋穿起来感觉有点儿紧，走久了脚会不舒服。',
        pinyin: 'Zhè shuāng xīn xié chuān qǐlái gǎnjué yǒudiǎnr jǐn, zǒu jiǔ le jiǎo huì bù shūfu.',
        meaning_vi: 'Đôi giày mới này đi vào có cảm giác hơi chật, đi bộ lâu chân sẽ khó chịu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对交付工期极紧且工艺标准极其苛刻的跨国大型工程，项目指挥部实行倒排工期与挂图作战以确保如期履约。',
        pinyin: 'Miànduì jiāofù gōngqī jí jǐn qiě gōngyì biāozhǔn jíqí kēkè de kuàguó dàxíng gōngchéng, xiàngmù zhǐhuībù shíxíng dàopái gōngqī yǔ guàtú zuòzhàn yǐ quèbǎo rúqī lǚyuē.',
        meaning_vi: 'Đứng trước một dự án công trình lớn xuyên quốc gia có thời hạn bàn giao vô cùng gấp rút và tiêu chuẩn kỹ thuật cực kỳ khắt khe, ban chỉ huy dự án đã thực hiện lập lịch tiến độ ngược và bám sát sơ đồ tác chiến nhằm đảm bảo hoàn thành đúng hẹn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2608,
    hanzi: '紧急',
    pinyin: 'jǐnjí',
    word_type: 'Tính từ',
    meaning_vi: 'khẩn cấp, cấp bách',
    examples: [
      {
        chinese: '如果遇到火灾等紧急情况，请务必保持冷静并迅速从安全通道撤离。',
        pinyin: 'Rúguǒ yùdào huǒzāi děng jǐnjí qíngkuàng, qǐng wùbì bǎochí lěngjìng bìng xùnsù cóng ānquán tōngdào chèlí.',
        meaning_vi: 'Nếu gặp phải các tình huống khẩn cấp như hỏa hoạn, xin hãy giữ bình tĩnh và nhanh chóng sơ tán theo lối thoát hiểm an toàn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国务院应急管理部门在地震灾害发生后第一时刻启动国家一级紧急响应，全面统筹调配全国专业救援力量星夜驰援灾区。',
        pinyin: 'Guówùyuàn yìngjí guǎnlǐ bùmén zài dìzhèn zāihài fāshēng hòu dì-yī shíkè qǐdòng guójiā yī jí jǐnjí xiǎngyìng, quánmiàn tǒngchóu tiàopèi quánguó zhuānyè jiùyuán lìliàng xīngyè chíyuán zāiqū.',
        meaning_vi: 'Bộ Quản lý Khẩn cấp Quốc vụ viện ngay sau khi xảy ra thảm họa động đất đã kích hoạt phản ứng khẩn cấp cấp độ một quốc gia, điều phối tổng thể các lực lượng cứu hộ chuyên nghiệp trên toàn quốc gấp rút cứu trợ xuyên đêm tới vùng thảm họa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2609,
    hanzi: '尽快',
    pinyin: 'jǐnkuài',
    word_type: 'Phó từ',
    meaning_vi: 'càng sớm càng tốt, nhanh chóng',
    examples: [
      {
        chinese: '请大家在下班前尽快把本月的财务报销单据提交审核。',
        pinyin: 'Qǐng dàjiā zài xiàbān qián jǐnkuài bǎ běn yuè de cáiwù bàoxiāo dānjù tíjiāo shěnhé.',
        meaning_vi: 'Xin mọi người trước giờ tan làm hãy nhanh chóng nộp các chứng từ thanh toán tài chính của tháng này để xét duyệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为遏制疫情蔓延并恢复正常的社会经济秩序，当地政府协同公共卫生机构尽快建立起全域覆盖的快速筛查与流调网络。',
        pinyin: 'Wèi èzhì yìqíng mànyán bìng huīfù zhèngcháng de shèhuì jīngjì zhìxù, dāngdì zhèngfǔ xiétóng gōnggòng wèishēng jīgòu jǐnkuài jiànlì qǐ quányù fùgài de kuàisù shāichá yǔ liúdiào wǎngluò.',
        meaning_vi: 'Nhằm kiềm chế dịch bệnh lây lan và phục hồi trật tự kinh tế xã hội bình thường, chính quyền địa phương phối hợp cùng cơ quan y tế công cộng nhanh chóng thiết lập mạng lưới sàng lọc nhanh và điều tra dịch tễ bao phủ toàn địa bàn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2610,
    hanzi: '尽量',
    pinyin: 'jǐnliàng',
    word_type: 'Phó từ',
    meaning_vi: 'cố gắng hết sức, ráng hết mức, hết sức có thể',
    examples: [
      {
        chinese: '医生叮嘱他平时要尽量少吃辛辣油腻的食物。',
        pinyin: 'Yīshēng dīngzhǔ tā píngshí yào jǐnliàng shǎo chī xīnlà yóunì de shíwù.',
        meaning_vi: 'Bác sĩ dặn dò anh ấy thường ngày nên cố gắng hạn chế ăn các món cay nóng và nhiều dầu mỡ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在制定企业中长期发展规划时，管理层必须充分评估宏观政策不确定性，尽量规避跨国资本市场的潜在流动性风险。',
        pinyin: 'Zài zhìdìng qǐyè zhōng-chángqī fāzhǎn guīhuà shí, guǎnlǐcéng bìxū chōngfèn pínggū hóngguān zhèngcè bùquèdìngxìng, jǐnliàng guībì kuàguó zīběn shìchǎng de qiánzài liúdòngxìng fēngxiǎn.',
        meaning_vi: 'Khi xây dựng quy hoạch phát triển trung và dài hạn cho doanh nghiệp, ban điều hành phải đánh giá thấu đáo sự bất định của chính sách vĩ mô nhằm cố gắng tối đa né tránh các rủi ro thanh khoản tiềm ẩn trên thị trường vốn xuyên quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2611,
    hanzi: '紧密',
    pinyin: 'jǐnmì',
    word_type: 'Tính từ',
    meaning_vi: 'khăng khít, chặt chẽ, gắn kết',
    examples: [
      {
        chinese: '邻里之间保持着紧密的联系，谁家有困难大家都会热心帮忙。',
        pinyin: 'Línlǐ zhījiān bǎochí zhe jǐnmì de liánxì, shuí jiā yǒu kùnnan dàjiā dōu huì rèxīn bāngmáng.',
        meaning_vi: 'Giữa xóm giềng luôn duy trì mối liên hệ khăng khít, nhà ai gặp khó khăn mọi người đều nhiệt tình giúp đỡ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着区域全面经济伙伴关系协定的深入实施，成员国之间在关税减让、产业链分工以及技术标准互认方面建立了更加紧密的战略协作体系。',
        pinyin: 'Suízhe Qūyù Quánmiàn Jīngjì Huǒbàn Guānxì Xiédìng de shēnrù shíshī, chéngyuánguó zhījiān zài guānshuì jiǎnràng, chǎnyèliàn fēngōng yǐjí jìshù biāozhǔn hùrèn fāngmiàn jiànlì le gèngjiā jǐnmì de zhànlüè xiézuò tǐxì.',
        meaning_vi: 'Cùng với sự thực thi sâu rộng của Hiệp định Đối tác Kinh tế Toàn diện Khu vực, giữa các nước thành viên đã thiết lập một hệ thống hợp tác chiến lược ngày càng chặt chẽ về cắt giảm thuế quan, phân công chuỗi công nghiệp và công nhận lẫn nhau các tiêu chuẩn kỹ thuật.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2612,
    hanzi: '谨慎',
    pinyin: 'jǐnshèn',
    word_type: 'Tính từ',
    meaning_vi: 'cẩn trọng, thận trọng, dè dặt',
    examples: [
      {
        chinese: '在签署重要的商业合同前，务必谨慎阅读每一项条款细则。',
        pinyin: 'Zài qiānshǔ zhòngyào de shāngyè hétong qián, wùbì jǐnshèn yuèdú měi yí xiàng tiáokuǎn xìzé.',
        meaning_vi: 'Trước khi ký kết các hợp đồng thương mại quan trọng, nhất thiết phải đọc thật cẩn trọng từng điều khoản chi tiết.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对高度复杂的国际金融环境与外汇汇率剧烈波动，投资决策委员会采取了极为谨慎稳健的跨国资产配置策略。',
        pinyin: 'Miànduì gāodù fùzá de guójì jīnróng huánjìng yǔ wàihuì huìlǜ jùliè bōdòng, tóuzī juécè wěiyuánhuì cǎiqǔ le jíwéi jǐnshèn wěnjiàn de kuàguó zīchǎn pèizhì cèlüè.',
        meaning_vi: 'Đối mặt với môi trường tài chính quốc tế phức tạp cao độ và biến động dữ dội của tỷ giá ngoại hối, hội đồng ra quyết định đầu tư đã áp dụng chiến lược phân bổ tài sản xuyên quốc gia vô cùng thận trọng và vững chắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2613,
    hanzi: '进步',
    pinyin: 'jìnbù',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'tiến bộ, cải thiện; tiến bộ (tư tưởng)',
    examples: [
      {
        chinese: '经过一个学期的刻苦钻研，他的中文听说水平取得了显著的进步。',
        pinyin: 'Jīngguò yí gè xuéqī de kèkǔ zuānyán, tā de Zhōngwén tīngshuō shuǐpíng qǔdé le xiǎnzhù de jìnbù.',
        meaning_vi: 'Qua một học kỳ miệt mài rèn luyện, trình độ nghe nói tiếng Trung của anh ấy đã đạt được sự tiến bộ rõ rệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科技创新是引领人类文明社会进步的核心动力源泉，必须持续加大基础前沿科学的基础性与战略性研发投入。',
        pinyin: 'Kējì chuàngxīn shì yǐnlǐng rénlèi wénmíng shèhuì jìnbù de héxīn dònglì yuánquán, bìxū chíxù jiādà jīchǔ qiányán kēxué de jīchǔxìng yǔ zhànlüèxìng yánfā tóurù.',
        meaning_vi: 'Đổi mới sáng tạo khoa học công nghệ là nguồn động lực cốt lõi dẫn dắt sự tiến bộ của xã hội văn minh nhân loại, đòi hỏi phải liên tục gia tăng đầu tư nghiên cứu mang tính chiến lược và nền tảng cho khoa học cơ bản tiên phong.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2614,
    hanzi: '近代',
    pinyin: 'jìndài',
    word_type: 'Danh từ',
    meaning_vi: 'thời cận đại, cận đại',
    examples: [
      {
        chinese: '历史博物馆里陈列着许多反映中国近代社会变迁的历史珍贵文物。',
        pinyin: 'Lìshǐ bówùguǎn lǐ chénliè zhe xǔduō fǎnyìng Zhōngguó jìndài shèhuì biànqiān de lìshǐ zhēnguì wénwù.',
        meaning_vi: 'Trong bảo tàng lịch sử trưng bày rất nhiều hiện vật quý giá phản ánh những biến thiên của xã hội Trung Quốc thời cận đại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国近代史是一部中华民族百折不挠救亡图存的壮烈奋斗史，深刻昭示了落后就要挨打、唯有自强才能自立的历史铁律。',
        pinyin: 'Zhōngguó jìndàishǐ shì yí bù Zhōnghuá mínzú bǎizhé-bùnáo jiùwáng-túcún de zhuàngliè fèndòushǐ, shēnkè zhāoshì le luòhòu jiù yào áidǎ, wéiyǒu zìqiáng cáinéng zìlì de lìshǐ tiělǜ.',
        meaning_vi: 'Lịch sử cận đại Trung Quốc là một pho sử đấu tranh kiên cường bất khuất cứu nước cứu nòi đầy bi tráng của dân tộc Trung Hoa, minh chứng sâu sắc quy luật lịch sử rằng lạc hậu ắt bị bắt nạt, chỉ có tự cường mới có thể tự lập.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2615,
    hanzi: '进口',
    pinyin: 'jìnkǒu',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'nhập khẩu; lối vào, cửa vào',
    examples: [
      {
        chinese: '商场超市里设立了专门销售进口优质水果和奶制品的专柜。',
        pinyin: 'Shāngchǎng chāoshì lǐ shèlì le zhuānmén xiāoshòu jìnkǒu yōuzhì shuǐguǒ hé nǎizhìpǐn de zhuānguì.',
        meaning_vi: 'Trong siêu thị có đặt các quầy hàng chuyên bán hoa quả và sản phẩm từ sữa nhập khẩu chất lượng cao.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为满足国内产业转型与消费升级的多元化需求，国家主动降低部分先进技术装备、关键零部件及抗癌医药品的进口关税。',
        pinyin: 'Wèi mǎnzú guónèi chǎnyè zhuǎnxíng yǔ xiāofèi shēngjí de duōyuánhuà xūqiú, guójiā zhǔdòng jiàngdī bùfen xiānjìn jìshù zhuāngbèi, guānjiàn língbùjiàn jí kàng’ái yīyàopǐn de jìnkǒu guānshuì.',
        meaning_vi: 'Nhằm đáp ứng nhu cầu đa dạng hóa về chuyển đổi ngành nghề và nâng tầm tiêu dùng trong nước, nhà nước đã chủ động hạ thuế nhập khẩu đối với một số thiết bị công nghệ tiên tiến, linh kiện then chốt và thuốc kháng ung thư.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2616,
    hanzi: '尽力',
    pinyin: 'jìnlì',
    word_type: 'Động từ',
    meaning_vi: 'hết sức, tận lực, dốc toàn lực',
    examples: [
      {
        chinese: '无论最终结果如何，只要我们在整个备考过程中尽力了就不会留下遗憾。',
        pinyin: 'Wúlùn zuìzhōng jiéguǒ rúhé, zhǐyào wǒmen zài zhěnggè bèikǎo guòchéng zhōng jìnlì le jiù bú huì liúxià yíhàn.',
        meaning_vi: 'Bất luận kết quả cuối cùng ra sao, chỉ cần chúng ta đã dốc hết sức mình trong suốt quá trình ôn thi thì sẽ không còn gì phải nuối tiếc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全体医护人员通宵达旦与死神赛跑，尽最大努力拯救每一个危重患者的宝贵生命，完美诠释了救死扶伤的医者仁心。',
        pinyin: 'Quántǐ yīhù rényuán tōngxiāo-dádàn yǔ sǐshén sàipǎo, jìn zuìdà nǔlì zhěngjiù měi yí gè wēizhòng huànzhě de bǎoguì shēngmìng, wánměi quánshì le jiùsǐ-fúshāng de yīzhě rénxīn.',
        meaning_vi: 'Toàn thể đội ngũ y bác sĩ thức trắng đêm chạy đua với tử thần, dốc kiệt sức mình cứu lấy từng sinh mạng quý báu của người bệnh nguy kịch, khắc họa trọn vẹn lòng nhân ái của người thầy thuốc cứu người giúp đời.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2617,
    hanzi: '近年来',
    pinyin: 'jìnnián lái',
    word_type: 'Cụm từ / Danh từ',
    meaning_vi: 'những năm gần đây, mấy năm trở lại đây',
    examples: [
      {
        chinese: '近年来，越来越多的人选择骑共享单车作为城市短途出行的低碳方式。',
        pinyin: 'Jìnnián lái, yuèláiyuè duō de rén xuǎnzé qí gòngxiǎng dānchē zuòwéi chéngshì duǎntú chūxíng de dītàn fāngshì.',
        meaning_vi: 'Những năm gần đây, ngày càng nhiều người lựa chọn đi xe đạp công cộng như một cách thức đi lại cự ly ngắn ít phát thải carbon trong đô thị.',
        difficulty_level: 'basic'
      },
      {
        chinese: '近年来，依托大数据算力底座与生成式人工智能技术的爆发式迭代，数字经济已成为驱动全球高质量发展的新引擎。',
        pinyin: 'Jìnnián lái, yītuō dàshùjù suànlì dǐzuò yǔ shēngchéngxìng réngōng zhìnéng jìshù de bàofāshì diédài, shùzì jīngjì yǐ chéngwéi qūdòng quánqiú gāo zhìliàng fāzhǎn de xīn yǐnqíng.',
        meaning_vi: 'Mấy năm trở lại đây, dựa trên nền tảng năng lực tính toán dữ liệu lớn và sự bùng nổ cải tiến của trí tuệ nhân tạo tạo sinh, nền kinh tế số đã trở thành động cơ mới thúc đẩy sự phát triển chất lượng cao trên toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2618,
    hanzi: '近期',
    pinyin: 'jìnqī',
    word_type: 'Danh từ',
    meaning_vi: 'thời gian gần đây, dạo gần đây; thời kỳ sắp tới',
    examples: [
      {
        chinese: '学校近期将组织一次全校范围的春季消防疏散应急演练。',
        pinyin: 'Xuéxiào jìnqī jiāng zǔzhī yí cì quán xiào fànwéi de chūnjì xiāofáng shūsàn yìngjí yǎanliàn.',
        meaning_vi: 'Trường học trong thời gian tới đây sẽ tổ chức một buổi diễn tập khẩn cấp sơ tán phòng cháy chữa cháy mùa xuân trong phạm vi toàn trường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '鉴于近期国际大宗商品价格与航运运价指数的剧烈震荡，多部门联合发布风险提示并出台供应链保供稳价政策组合拳。',
        pinyin: 'Jiànyú jìnqī guójì dàzōng shāngpǐn jiàgé yǔ hángyùn yùnjià zhǐshù de jùliè zhèndàng, duō bùmén liánhé fābù fēngxiǎn tíshì bìng chūtái gōngyìngliàn bǎogōng-wěnjià zhèngcè zǔhéquán.',
        meaning_vi: 'Xét thấy thời gian gần đây giá hàng hóa cơ bản quốc tế và chỉ số cước vận tải biển biến động mạnh, nhiều cơ quan ban ngành đã phối hợp phát cảnh báo rủi ro và tung ra gói chính sách đồng bộ nhằm bảo đảm nguồn cung và bình ổn giá chuỗi cung ứng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2619,
    hanzi: '近日',
    pinyin: 'jìnrì',
    word_type: 'Danh từ',
    meaning_vi: 'mấy ngày gần đây, dạo này; vài ngày tới',
    examples: [
      {
        chinese: '近日天气多变早晚温差较大，出门时请注意及时添减衣物防寒。',
        pinyin: 'Jìnrì tiānqì duōbiàn zǎowǎn wēnchā jiào dà, chūmén shí qǐng zhùyì jíshí tiān-jiǎn yīwù fánghán.',
        meaning_vi: 'Mấy ngày gần đây thời tiết biến đổi thất thường, chênh lệch nhiệt độ ngày và đêm khá lớn, khi ra ngoài xin lưu ý mặc thêm hoặc bớt áo ấm để phòng cảm lạnh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '近日，由我国科研机构牵头联合研发的超导量子计算机原型机成功实现量子优越性验证，引发国际学术界的广泛关注。',
        pinyin: 'Jìnrì, yóu wǒ guó kēyán jīgòu qiāntóu liánhé yánfā de chāodǎo liàngzǐ jìsuànjī yuánxíngjī chénggōng shíxiàn liàngzǐ yōuyuèxìng yànzhèng, yǐnfā guójì xuéshùjiè de guǎnfàn guānzhù.',
        meaning_vi: 'Mới đây, nguyên mẫu máy tính lượng tử siêu dẫn do các viện nghiên cứu khoa học nước ta chủ trì phối hợp phát triển đã kiểm chứng thành công tính ưu việt lượng tử, thu hút sự quan tâm rộng rãi của giới học thuật quốc tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2620,
    hanzi: '进一步',
    pinyin: 'jìnyíbù',
    word_type: 'Phó từ',
    meaning_vi: 'hơn một bước, sâu hơn, thêm một bước',
    examples: [
      {
        chinese: '通过老师的细致讲解，我们对这首古诗的主题有了进一步的理解。',
        pinyin: 'Tōngguò lǎoshī de xìzhì jiǎngjiě, wǒmen duì zhè shǒu gǔshī de zhǔtí yǒu le jìnyíbù de lǐjiě.',
        meaning_vi: 'Qua lời giảng tỉ mỉ của thầy giáo, chúng tôi đã có sự hiểu biết sâu sắc hơn một bước về chủ đề của bài thơ cổ này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为进一步激发民营经济活力并优化营商法治环境，国家持续破除市场准入壁垒并强化知识产权全链条司法保护。',
        pinyin: 'Wèi jìnyíbù jīfā mínyíng jīngjì huólì bìng yōuhuà yíngshāng fǎzhì huánjìng, guójiā chíxù pòchú shìchǎng zhǔnrù bìlěi bìng qiánghuà zhīshi chǎnquán quán liàntiáo sīfǎ bǎohù.',
        meaning_vi: 'Nhằm kích thích thêm một bước sức sống của nền kinh tế tư nhân và tối ưu hóa môi trường pháp lý kinh doanh, nhà nước liên tục dỡ bỏ các rào cản gia nhập thị trường và tăng cường bảo hộ tư pháp toàn chuỗi đối với quyền sở hữu trí tuệ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2621,
    hanzi: '经典',
    pinyin: 'jīngdiǎn',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'kinh điển, tác phẩm kinh điển; mẫu mực, tiêu biểu',
    examples: [
      {
        chinese: '阅读世界文学经典名著能够丰富一个人的内心世界与精神境界。',
        pinyin: 'Yuèdú shìjiè wénxué jīngdiǎn míngzhù nénggòu fēngfù yí gè rén de nèixīn shìjiè yǔ jīngshén jìngjiè.',
        meaning_vi: 'Đọc các tác phẩm danh tác kinh điển của văn học thế giới có thể làm phong phú thế giới nội tâm và cảnh giới tinh thần của mỗi con người.',
        difficulty_level: 'basic'
      },
      {
        chinese: '这部由著名导演倾力执导的史诗巨作，以其深刻的哲思意蕴与开创性的镜头语言，成为了世界电影艺术史上无可争议的传世经典。',
        pinyin: 'Zhè bù yóu zhùmíng dǎoyǎn qīnglì zhídǎo de shǐshī jùzuò, yǐ qí shēnkè de zhésī yìyùn yǔ kāichuàngxìng de jìngtóu yǔyán, chéngwéi le shìjiè diànyǐng yìshùshǐ shang wúkě zhēngyì de chuánshì jīngdiǎn.',
        meaning_vi: 'Tác phẩm sử thi đồ sộ do đạo diễn lừng danh dồn trọn tâm huyết dàn dựng, với hàm ý triết học sâu xa và ngôn ngữ khung hình mang tính mở đường, đã trở thành tác phẩm kinh điển lưu danh thiên cổ không thể tranh cãi trong lịch sử nghệ thuật điện ảnh thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2622,
    hanzi: '精力',
    pinyin: 'jīnglì',
    word_type: 'Danh từ',
    meaning_vi: 'tinh lực, sức lực, năng lượng',
    examples: [
      {
        chinese: '考前复习阶段，要把有限的精力和时间集中在攻克自己的薄弱知识点上。',
        pinyin: 'Kǎoqián fùxí jiēduàn, yào bǎ yǒuxiàn de jīnglì hé shíjiān jízhōng zài gōngkè zìjǐ de bóruò zhīshidǐan shang.',
        meaning_vi: 'Trong giai đoạn ôn thi trước kỳ thi, cần phải tập trung thời gian và tinh lực có hạn vào việc khắc phục những điểm kiến thức còn yếu của bản thân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '优秀的科研工作者往往善于排除外界的一切纷扰诱惑，数十年如一日将全部精力倾注于人类未知的科学前沿探索之中。',
        pinyin: 'Yōuxiù de kēyán gōngzuòzhě wǎngwǎng shànyú páichú wàijiè de yíqiè fēnrǎo yòuhuò, shù shí nián rú yí rì jiāng quánbù jīnglì qīngzhù yú rénlèi wèizhī de kēxué qiányán tànsuǒ zhīzhōng.',
        meaning_vi: 'Những nhà nghiên cứu khoa học xuất sắc thường rất giỏi gạt bỏ mọi phiền toái cám dỗ từ thế giới bên ngoài, hàng chục năm như một dồn toàn bộ tâm lực cho việc khai phá những chân trời khoa học tiên phong còn chưa biết của nhân loại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2623,
    hanzi: '精神',
    pinyin: 'jīngshen',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'tinh thần, tâm hồn; lanh lợi, phấn chấn, rạng rỡ',
    examples: [
      {
        chinese: '睡了一个好觉之后，他今天看起来精神格外饱满。',
        pinyin: 'Shuì le yí gè hǎo jiào zhīhòu, tā jīntiān kàn qǐlái jīngshen géwài bǎomǎn.',
        meaning_vi: 'Sau khi có một giấc ngủ ngon, hôm nay trông anh ấy tinh thần đặc biệt phấn chấn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中华民族在漫长的历史长河中铸就了自强不息、厚德载物的伟大民族精神，这是支撑国家穿越风浪并屹立于世界东方的精神纽带。',
        pinyin: 'Zhōnghuá mínzú zài màncháng de lìshǐ chánghé zhōng zhùjiù le zìqiáng-bùxī, hòudé-zàiwù de wěidà mínzú jīngshén, zhè shì zhīchēng guójiā chuānyuè fēnglàng bìng yìlì yú shìjiè dōngfāng de jīngshén niǔdài.',
        meaning_vi: 'Dân tộc Trung Hoa trong dòng chảy lịch sử đằng đẵng đã đúc kết nên tinh thần dân tộc vĩ đại không ngừng tự cường, đức dày nâng đỡ vạn vật, đây là sợi dây tinh thần chống đỡ đất nước vượt qua mọi phong ba bão táp để đứng sừng sững tại phương Đông thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2624,
    hanzi: '惊喜',
    pinyin: 'jīngxǐ',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'bất ngờ thú vị, ngạc nhiên vui sướng; mừng rỡ bất ngờ',
    examples: [
      {
        chinese: '过生日那天，朋友们悄悄为我策划了一个充满惊喜的派对。',
        pinyin: 'Guò shēngrì nà tiān, péngyoumen qiāoqiāo wèi wǒ cèhuà le yí gè chōngmǎn jīngxǐ de pàiduì.',
        meaning_vi: 'Hôm sinh nhật, bạn bè đã bí mật lên kế hoạch chuẩn bị cho tôi một bữa tiệc đầy bất ngờ thú vị.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科研人员在分析深空望远镜传回的数据时惊喜地发现了一颗处于宜居带的新型系外类地行星，为地外生命探索提供了全新线索。',
        pinyin: 'Kēyán rényuán zài fēnxī shēnkōng wàngyuǎnjìng chuánhuí de shùjù shí jīngxǐ de fāxiàn le yì kē chǔyú yíjūdài de xīnxíng xìwài lèidì hángxīng, wèi dìwài shēngmìng tànsuǒ tígōng le quánxīn xiànsuǒ.',
        meaning_vi: 'Các nhà nghiên cứu khoa học khi phân tích dữ liệu kính viễn vọng không gian sâu truyền về đã mừng rỡ và bất ngờ phát hiện ra một hành tinh giống Trái Đất ngoài hệ Mặt Trời mới nằm trong vùng có thể sống được, mở ra manh mối hoàn toàn mới cho việc thám hiểm sự sống ngoài Trái Đất.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2625,
    hanzi: '经营',
    pinyin: 'jīngyíng',
    word_type: 'Động từ',
    meaning_vi: 'kinh doanh, quản lý điều hành, vận hành',
    examples: [
      {
        chinese: '李叔叔在古城老街上经营着一家具有百年历史的手工茶馆。',
        pinyin: 'Lǐ shūshu zài gǔchéng lǎojiē shang jīngyíng zhe yì jiā jùyǒu bǎi nián lìshǐ de shǒugōng cháguǎn.',
        meaning_vi: 'Chú Lý kinh doanh một quán trà thủ công có lịch sử trăm năm trên con phố cổ của thành cổ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '跨国零售集团通过全面推行线上线下一体化的全渠道精细化经营战略，成功实现了在存量市场中的利润逆势增长。',
        pinyin: 'Kuàguó língshòu jítuán tōngguò quánmiàn tuīxíng xiànshàng-xiànxià yītǐhuà de quán qúdào jīngxìhuà jīngyíng zhànlüè, chénggōng shíxiàn le zài cúnliàng shìchǎng zhōng de lìrùn nìshì zēngzhǎng.',
        meaning_vi: 'Tập đoàn bán lẻ xuyên quốc gia thông qua việc triển khai toàn diện chiến lược vận hành kinh doanh tinh tế đa kênh tích hợp online và offline, đã thực hiện thành công việc tăng trưởng lợi nhuận ngược dòng ngay trong một thị trường dung lượng bão hòa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2626,
    hanzi: '静',
    pinyin: 'jìng',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'yên tĩnh, tĩnh lặng, thanh tịnh; làm tĩnh lại',
    examples: [
      {
        chinese: '夜深人静的时候，窗外只有微风吹动树叶沙沙作响的声音。',
        pinyin: 'Yèshēn-rénjìng de shíhou, chuāngwài zhǐyǒu wēifēng chuīdòng shùyè shāshā zuòxiǎng de shēngyīn.',
        meaning_vi: 'Lúc đêm khuya thanh vắng, bên ngoài cửa sổ chỉ còn lại tiếng gió thoảng lay động cành lá xào xạc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在纷繁浮躁的现代都市生活中，唯有保持内心的宁静与笃定，才能在复杂变幻的环境中坚守初心、行稳致远。',
        pinyin: 'Zài fēnfán fúzào de xiàndài dūshì shēnghuó zhōng, wéiyǒu bǎochí nèixīn de níngjìng yǔ dǔdìng, cáinéng zài fùzá biànhuàn de huánjìng zhōng jiānshǒu chūxīn, xíngwěn-zhìyuǎn.',
        meaning_vi: 'Giữa đời sống đô thị hiện đại đầy xô bồ và phù hoa, chỉ có giữ cho nội tâm được tĩnh lặng và kiên định thì mới có thể kiên trì tâm niệm thuở ban đầu và vững vàng bước xa giữa muôn vàn đổi thay của hoàn cảnh.',
        difficulty_level: 'applied'
      }
    ]
  }
]
