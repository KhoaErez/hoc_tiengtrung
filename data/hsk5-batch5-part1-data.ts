// data/hsk5-batch5-part1-data.ts
// 25 từ HSK 5: #2402 [各自] -> #2426 [鼓掌]

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

export const HSK5_BATCH5_PART1: VocabItem[] = [
  {
    id: 2402,
    hanzi: '各自',
    pinyin: 'gèzì',
    word_type: 'Đại từ',
    meaning_vi: 'mỗi người, mỗi bên, ai nấy, riêng phần mình',
    examples: [
      {
        chinese: '散会之后，大家各自回到工作岗位上继续处理手头紧急的业务。',
        pinyin: 'Sànhuì zhīhòu, dàjiā gèzì huídào gōngzuò gǎngwèi shang jìxù chǔlǐ shǒutóu jǐnjí de yèwù.',
        meaning_vi: 'Sau khi tan họp, mọi người ai nấy đều trở về vị trí làm việc của mình để tiếp tục xử lý các nghiệp vụ khẩn cấp trong tay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在跨国技术联合研发项目中，双方科学家团队充分发挥各自在软件算法与硬件架构领域的独特优势，实现了深度协同创新。',
        pinyin: 'Zài kuàguó jìshù liánhé yánfā xiàngmù zhōng, shuāngfāng kēxuéjiā tuánduì chōngfèn fāhuī gèzì zài ruǎnjiàn suànfǎ yǔ yìngjiàn jiàgòu lǐngyù de dútè yōushì, shíxiàn le shēndù xiétóng chuàngxīn.',
        meaning_vi: 'Trong dự án hợp tác nghiên cứu phát triển công nghệ xuyên quốc gia, đội ngũ các nhà khoa học của hai bên đã phát huy trọn vẹn thế mạnh độc đáo của mỗi bên trong lĩnh vực thuật toán phần mềm và kiến trúc phần cứng, hiện thực hóa sự đổi mới hiệp đồng sâu sắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2403,
    hanzi: '根',
    pinyin: 'gēn',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'rễ cây, cội nguồn; chiếc, sợi, cây (lượng từ)',
    examples: [
      {
        chinese: '老树的根深深扎进泥土里，任凭狂风暴雨也依然屹立不倒。',
        pinyin: 'Lǎoshù de gēn shēnshēn zhājìn nítǔ lǐ, rènpíng kuángfēng-bàoyǔ yě yīrán yìlì-bùdǎo.',
        meaning_vi: 'Rễ của cây cổ thụ cắm sâu vào lòng đất, mặc cho mưa to gió lớn vẫn đứng sừng sững không hề ngã đổ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中华传统文化是海内外华夏儿女共同的精神之根，无论身在何方，深厚的家国情怀始终将大家紧紧凝聚在一起。',
        pinyin: 'Zhōnghuá chuántǒng wénhuà shì hǎinèiwài Huáxià érnǚ gòngtóng de jīngshén zhī gēn, wúlùn shēn zài héfāng, shēnhòu de jiāguó qínghuái shǐzhōng jiāng dàjiā jǐnjǐn níngjù zài yìqǐ.',
        meaning_vi: 'Văn hóa truyền thống Trung Hoa là cội rễ tinh thần chung của những người con đất Việt - Hoa trong và ngoài nước, dẫu ở bất cứ phương trời nào, tình cảm gia đình tổ quốc sâu đậm vẫn luôn gắn kết mọi người bền chặt bên nhau.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2404,
    hanzi: '根本',
    pinyin: 'gēnběn',
    word_type: 'Danh từ / Tính từ / Phó từ',
    meaning_vi: 'căn bản, gốc rễ; hoàn toàn (không)',
    examples: [
      {
        chinese: '他平时工作非常马虎，根本没有把领导提出的整改意见放在心上。',
        pinyin: 'Tā píngshí gōngzuò fēicháng mǎhu, gēnběn méiyǒu bǎ lǐngdǎo tíchū de zhěnggǎi yìjiàn fàng zài xīn shang.',
        meaning_vi: 'Ngày thường anh ấy làm việc rất cẩu thả, hoàn toàn không để tâm đến những ý kiến chấn chỉnh mà cấp trên đã đưa ra.',
        difficulty_level: 'basic'
      },
      {
        chinese: '要从根本上化解水资源匮乏与生态环境脆弱的长期矛盾，必须坚持节水优先战略并大力发展循环经济模式。',
        pinyin: 'Yào cóng gēnběn shang huàjiě shuǐzīyuán kuìfá yǔ shēngtài huánjìng cuìruò de chángqī máodùn, bìxū jiānchí jiéshuǐ yōuxiān zhànlüè bìng dàlì fāzhǎn xúnhuán jīngjì móshì.',
        meaning_vi: 'Muốn hóa giải từ gốc rễ mâu thuẫn lâu dài giữa việc khan hiếm tài nguyên nước và môi trường sinh thái mỏng manh, bắt buộc phải kiên trì chiến lược ưu tiên tiết kiệm nước và phát triển mạnh mẽ mô hình kinh tế tuần hoàn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2405,
    hanzi: '更换',
    pinyin: 'gēnghuàn',
    word_type: 'Động từ',
    meaning_vi: 'thay đổi, thay thế, đổi mới',
    examples: [
      {
        chinese: '为了保证行车安全，车主应该按照保养手册定期更换机油和磨损严重的轮胎。',
        pinyin: 'Wèile bǎozhèng xíngchē ānquán, chēzhǔ yīnggāi ànzhào bǎoyǎng shǒucè dìngqī gēnghuàn jīyóu hé mósǔn yánzhòng de lúntāi.',
        meaning_vi: 'Để đảm bảo an toàn khi lái xe, chủ xe nên định kỳ thay dầu máy và lốp xe bị mòn nghiêm trọng theo đúng sổ tay bảo dưỡng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '供电局在深夜负荷低谷期间组织施工人员对该老旧小区的地下老旧高压电缆与智能化变压器进行了全套更换。',
        pinyin: 'Gōngdiànjú zài shēnyè fùhè dīgǔ qījiān zǔzhī shīgōng rényuán duì gāi lǎojiù xiǎoqū de dìxià lǎojiù gāoyā diànlǎn yǔ zhìnénghuà biànyāqì jìnxíng le quántào gēnghuàn.',
        meaning_vi: 'Cục cấp điện đã tổ chức công nhân thi công vào thời điểm phụ tải thấp nhất lúc nửa đêm để tiến hành thay thế toàn bộ tuyến cáp điện ngầm cao áp cũ kỹ và máy biến áp thông minh hóa cho khu tập thể cũ này.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2406,
    hanzi: '更新',
    pinyin: 'gēngxīn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'cập nhật, làm mới, đổi mới',
    examples: [
      {
        chinese: '手机系统提示有新版本发布，建议连接无线网络后立即下载更新。',
        pinyin: 'Shǒujī xìtǒng tíshì yǒu xīn bǎnběn fābù, jiànyì liánjiē wúxiàn wǎngluò hòu lìjí xiàzǎi gēngxīn.',
        meaning_vi: 'Hệ điều hành điện thoại nhắc nhở có phiên bản mới phát hành, kiến nghị kết nối mạng không dây rồi tải về cập nhật ngay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '制造企业通过加快生产设备数字化转型与工艺技术迭代更新，显著提高了核心产品的技术壁垒与国际市场综合竞争力。',
        pinyin: 'Zhìzào qǐyè tōngguò jiākuài shēngchǎn shèbèi shùzìhuà zhuǎnxíng yǔ gōngyì jìshù diédài gēngxīn, xiǎnzhù tígāo le héxīn chǎnpǐn de jìshù bìlěi yǔ guójì shìchǎng zōnghé jìngzhēnglì.',
        meaning_vi: 'Doanh nghiệp sản xuất thông qua việc đẩy nhanh chuyển đổi số thiết bị sản xuất và đổi mới nâng cấp lặp lại công nghệ kỹ thuật, đã nâng cao rõ rệt rào cản kỹ thuật của các sản phẩm cốt lõi cùng sức cạnh tranh tổng hợp trên thị trường quốc tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2407,
    hanzi: '公布',
    pinyin: 'gōngbù',
    word_type: 'Động từ',
    meaning_vi: 'công bố, ban bố',
    examples: [
      {
        chinese: '考试成绩预计将于明天上午十点准时在教育局官方网站上正式公布。',
        pinyin: 'Kǎoshì chéngjì yùjì jiāng yú míngtiān shàngwǔ shí diǎn zhǔnshí zài jiàoyùjú guānfāng wǎngzhàn shang zhèngshì gōngbù.',
        meaning_vi: 'Điểm thi dự kiến sẽ được công bố chính thức vào lúc mười giờ sáng mai trên trang web chính thức của sở giáo dục.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家统计局依法公布了最新季度宏观经济核心运行指标，多项稳健回升的积极数据提振了海内外投资者对高质量发展的信心。',
        pinyin: 'Guójiā tǒngjìjú yīfǎ gōngbù le zuìxīn jīdù hóngguān jīngjì héxīn yùnxíng zhǐbiāo, duō xiàng wěnjiàn huíshēng de jījí shùjù tízhèn le hǎinèiwài tóuzīzhě duì gāo zhìliàng fāzhǎn de xìnxīn.',
        meaning_vi: 'Tổng cục Thống kê quốc gia đã công bố theo luật định các chỉ tiêu vận hành cốt lõi của nền kinh tế vĩ mô quý gần nhất, nhiều số liệu tích cực phục hồi vững chắc đã củng cố niềm tin của các nhà đầu tư trong và ngoài nước vào sự phát triển chất lượng cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2408,
    hanzi: '工程',
    pinyin: 'gōngchéng',
    word_type: 'Danh từ',
    meaning_vi: 'công trình, dự án kỹ thuật',
    examples: [
      {
        chinese: '这项大型跨海大桥建造工程历经五年艰苦施工，终于顺利实现全线合龙。',
        pinyin: 'Zhè xiàng dàxíng kuàhǎi dàqiáo jiànzào gōngchéng lìjīng wǔ nián jiānkǔ shīgōng, zhōngyú shùnlì shíxiàn quánxiàn hélóng.',
        meaning_vi: 'Công trình xây dựng cây cầu vượt biển quy mô lớn này đã trải qua năm năm thi công gian khổ, cuối cùng đã hợp long toàn tuyến thuận lợi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '南水北调中线工程作为国家水网骨干工程，有效缓解了沿线数十座特大城市的生产生活用水紧缺局面，产生了巨大的社会经济效益。',
        pinyin: 'Nánshuǐ Běidiào zhōngxiàn gōngchéng zuòwéi guójiā shuǐwǎng gǔgàn gōngchéng, yǒuxiào huǎnjiě le yánxiàn shù shí zuò tèdà chéngshì de shēngchǎn shēnghuó yòngshuǐ jǐnquē júmiàn, chǎnshēng le jùdà de shèhuì jīngjì xiàoyì.',
        meaning_vi: 'Dự án chuyển nước từ Nam lên Bắc tuyến miền Trung với vai trò là công trình rường cột của mạng lưới cấp nước quốc gia, đã giảm bớt hiệu quả tình trạng khan hiếm nước sinh hoạt và sản xuất của hàng chục siêu đô thị dọc tuyến, tạo ra hiệu quả kinh tế xã hội to lớn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2409,
    hanzi: '工程师',
    pinyin: 'gōngchéngshī',
    word_type: 'Danh từ',
    meaning_vi: 'kỹ sư',
    examples: [
      {
        chinese: '他在一家知名的自动化机械制造公司担任高级软件工程师。',
        pinyin: 'Tā zài yì jiā zhīmíng de zìdònghuà jīxiè zhìzào gōngsī dānrèn gāojí ruǎnjiàn gōngchéngshī.',
        meaning_vi: 'Anh ấy đảm nhiệm vị trí kỹ sư phần mềm cao cấp tại một công ty chế tạo cơ khí tự động hóa nổi tiếng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '航天系统总工程师带领由数百名青年骨干组成的研发攻关团队，攻克了深空探测器在极端宇宙环境下长周期自主导航定位的技术难关。',
        pinyin: 'Hángtiān xìtǒng zǒng gōngchéngshī dàilǐng yóu shù bǎi míng qīngnián gǔgàn zǔchéng de yánfā gōngguān tuánduì, gōngkè le shēnkōng tàncèqì zài jíduān yǔzhòu huánjìng xià cháng zhōuqī zìzhǔ dǎoháng dìngwèi de jìshù nánguān.',
        meaning_vi: 'Tổng công trình sư hệ thống hàng không vũ trụ đã dẫn dắt đội ngũ nghiên cứu đột phá gồm hàng trăm cán bộ nòng cốt trẻ tuổi, chinh phục cửa ải kỹ thuật khó khăn về định vị dẫn đường tự chủ chu kỳ dài của tàu thăm dò không gian sâu dưới môi trường vũ trụ khắc nghiệt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2410,
    hanzi: '工具',
    pinyin: 'gōngjù',
    word_type: 'Danh từ',
    meaning_vi: 'công cụ, phương tiện',
    examples: [
      {
        chinese: '修理自行车时必须准备好扳手、螺丝刀和打气筒等常用维修工具。',
        pinyin: 'Xiūlǐ zìxíngchē shí bìxū zhǔnbèi hǎo bānshǒu, luósīdāo hé dǎqìtǒng děng chángyòng wéixiū gōngjù.',
        meaning_vi: 'Khi sửa chữa xe đạp nhất định phải chuẩn bị sẵn các công cụ sửa chữa thông dụng như cờ lê, tua vít và ống bơm hơi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在以大语言模型为驱动的数字时代，人工智能编程助手已经成为现代软件开发人员提高代码编写与单元测试效率不可或缺的高效生产力工具。',
        pinyin: 'Zài yǐ dà yǔyán móxíng wéi qūdòng de shùzì shídài, réngōng zhìnéng biānchéng zhùshǒu yǐjīng chéngwéi xiàndài ruǎnjiàn kāifā rényuán tígāo dàimǎ biānxiě yǔ dānyuán cèshì xiàolǜ bùkě huòquē de gāoxiào shēngchǎnlì gōngjù.',
        meaning_vi: 'Trong kỷ nguyên số được thúc đẩy bởi mô hình ngôn ngữ lớn, trợ lý lập trình trí tuệ nhân tạo đã trở thành công cụ năng suất hiệu quả cao không thể thiếu giúp các lập trình viên phần mềm hiện đại nâng cao hiệu suất viết code và kiểm thử đơn vị.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2411,
    hanzi: '功能',
    pinyin: 'gōngnéng',
    word_type: 'Danh từ',
    meaning_vi: 'chức năng, tính năng',
    examples: [
      {
        chinese: '这款新款智能手环不仅具备心率监测功能，还能实时记录用户的日常运动轨迹。',
        pinyin: 'Zhè kuǎn xīnkuǎn zhìnéng shǒuhuán bùjǐn jùbèi xīnlǜ jiāncè gōngnéng, hái néng shíshí jìlù yònghù de rìcháng yùndòng guǐjì.',
        meaning_vi: 'Chiếc vòng tay thông minh mẫu mới này không chỉ có chức năng theo dõi nhịp tim, mà còn có thể ghi lại quỹ đạo vận động thường ngày của người dùng theo thời gian thực.',
        difficulty_level: 'basic'
      },
      {
        chinese: '城市湿地生态保护公园兼具蓄洪防旱、水质自然净化、调节局部微气候以及保护濒危水鸟栖息地等多重生态综合服务功能。',
        pinyin: 'Chéngshì shīdì shēngtài bǎohù gōngyuán jiānjù xùhóng fánghàn, shuǐzhì zìrán jìnghuà, tiáojié júbù wēiqìhòu yǐjí bǎohù bīnwēi shuǐniǎo qīxīdì děng duōchóng shēngtài zōnghé fúwù gōngnéng.',
        meaning_vi: 'Công viên bảo tồn sinh thái đất ngập nước đô thị tích hợp đa chức năng dịch vụ sinh thái tổng hợp như trữ lũ chống hạn, lọc sạch tự nhiên chất lượng nước, điều hòa vi khí hậu cục bộ cũng như bảo vệ nơi cư trú của các loài chim nước có nguy cơ tuyệt chủng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2412,
    hanzi: '公平',
    pinyin: 'gōngpíng',
    word_type: 'Tính từ',
    meaning_vi: 'công bằng, bình đẳng',
    examples: [
      {
        chinese: '体育比赛最宝贵的核心精神就在于遵守规则和维护公平公正的竞技环境。',
        pinyin: 'Tǐyù bǐsài zuì bǎoguì de héxīn jīngshén jiù zàiyú zūnshǒu guīzé hé wéihù gōngpíng gōngzhèng de jìngjì huánjìng.',
        meaning_vi: 'Tinh thần cốt lõi quý giá nhất của các trận thi đấu thể thao chính là tuân thủ luật lệ và bảo vệ môi trường tranh tài công bằng minh bạch.',
        difficulty_level: 'basic'
      },
      {
        chinese: '司法审判机关始终坚持以事实为依据、以法律为准绳，严格杜绝权力寻租与人情干扰，切实让人民群众在每一个司法案件中都感受到公平正义。',
        pinyin: 'Sīfǎ shěnpàn jīgòu shǐzhōng jiānchí yǐ shìshí wéi yījù, yǐ fǎlǜ wéi zhǔnshéng, yángé dùjué quánlì xúnzū yǔ rénqíng gānrǎo, qièshí ràng rénmín qúnzhòng zài měi yí gè sīfǎ ànjiàn zhōng dōu gǎnshòudào gōngpíng zhèngyì.',
        meaning_vi: 'Các cơ quan xét xử tư pháp luôn kiên trì lấy sự thật làm căn cứ, lấy pháp luật làm thước đo chuẩn mực, ngăn chặn nghiêm ngặt việc lạm quyền mưu lợi và can thiệp nể nang, làm cho quần chúng nhân dân cảm nhận được công lý công bằng trong từng vụ án tư pháp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2413,
    hanzi: '公务员',
    pinyin: 'gōngwùyuán',
    word_type: 'Danh từ',
    meaning_vi: 'công chức, viên chức nhà nước',
    examples: [
      {
        chinese: '许多大学毕业生为了追求稳定的职业发展平台，积极报名参加国家公务员录用考试。',
        pinyin: 'Xǔduō dàxué bìyèshēng wèile zhuīqiú wěndìng de zhíyè fāzhǎn píngtái, jījí bàomíng cānjiā guójiā gōngwùyuán lùyòng kǎoshì.',
        meaning_vi: 'Nhiều sinh viên tốt nghiệp đại học vì theo đuổi một bệ phóng nghề nghiệp ổn định nên đã tích cực đăng ký tham gia kỳ thi tuyển dụng công chức nhà nước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '作为一名扎根基层为人民服务的人民公务员，应当秉持勤政廉洁、务实担当的职业道德操守，全心全意为老百姓排忧解难办实事。',
        pinyin: 'Zuòwéi yì míng zhāgēn jīcéng wèi rénmín fúwù de rénmín gōngwùyuán, yīngdāng bǐngchí qínzhèng liánjié, wùshí dāndāng de zhíyè dàodé cāoshǒu, quánxīn-quányì wèi lǎobǎixìng páiyōu-jiěnán bàn shíshì.',
        meaning_vi: 'Là một công chức nhân dân cắm rễ ở cơ sở phục vụ nhân dân, cần giữ vững phẩm chất đạo đức nghề nghiệp siêng năng liêm khiết, thiết thực gánh vác trách nhiệm, hết lòng hết sức tháo gỡ khó khăn làm việc thực tế cho người dân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2414,
    hanzi: '恭喜',
    pinyin: 'gōngxǐ',
    word_type: 'Động từ',
    meaning_vi: 'chúc mừng',
    examples: [
      {
        chinese: '听闻你顺利通过了这次高难度的外语专业八级考试，我由衷地向你表示恭喜！',
        pinyin: 'Tīngwén nǐ shùnlì tōngguò le zhè cì gāo nándù de wàiyǔ zhuānyè bājí kǎoshì, wǒ yóuzhōng de xiàng nǐ biǎoshì gōngxǐ!',
        meaning_vi: 'Nghe tin bạn đã thuận lợi vượt qua kỳ thi chuyên ngành ngoại ngữ cấp tám có độ khó cao này, tôi xin gửi lời chúc mừng chân thành nhất tới bạn!',
        difficulty_level: 'basic'
      },
      {
        chinese: '在新品全球发布会的庆功晚宴上，来自各大跨国合作伙伴的高管们纷纷举杯，恭喜研发团队在芯片关键核心技术上取得了划时代的巨大成功。',
        pinyin: 'Zài xīnpǐn quánqiú fābùhuì de qìnggōng wǎnyàn shang, láizì gè dà kuàguó hézuò huǒbàn de gāoguǎn men fēnfēn jǔbēi, gōngxǐ yánfā tuánduì zài xīnpiàn guānjiàn héxīn jìshù shang qǔdé le huàshídài de jùdà chénggōng.',
        meaning_vi: 'Tại buổi dạ tiệc mừng công của hội nghị ra mắt sản phẩm mới toàn cầu, các lãnh đạo cấp cao đến từ các đối tác đa quốc gia lớn đã đồng loạt nâng ly, chúc mừng đội ngũ nghiên cứu phát triển đã giành được thành công vang dội mang tính thời đại về công nghệ lõi the chốt của chip vi xử lý.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2415,
    hanzi: '工业',
    pinyin: 'gōngyè',
    word_type: 'Danh từ',
    meaning_vi: 'công nghiệp',
    examples: [
      {
        chinese: '该地区依托丰富的煤炭资源，逐渐发展成为了一个以钢铁重工业为主的传统工业城市。',
        pinyin: 'Gāi dìqū yītuō fēngfù de méitàn zīyuán, zhújiàn fāzhǎn chéngwéi le yí gè yǐ gāngtiě zhòng gōngyè wéizhǔ de chuántǒng gōngyè chéngshì.',
        meaning_vi: 'Khu vực này dựa vào nguồn tài nguyên than đá phong phú đã dần phát triển thành một thành phố công nghiệp truyền thống lấy công nghiệp nặng luyện cán thép làm chủ đạo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国拥有世界上规模最庞大、门类最齐全的现代化工业制造体系，为保障全球产业链与供应链的安全韧性发挥着压舱石的关键作用。',
        pinyin: 'Zhōngguó yōngyǒu shìjiè shang guīmó zuì pángdà, ménlèi zuì qíquán de xiàndàihuà gōngyè zhìzào tǐxì, wèi bǎozhàng quánqiú chǎnyèliàn yǔ gōngyìngliàn de ānquán rènxìng fāhuī zhe yācāngshí de guānjiàn zuòyòng.',
        meaning_vi: 'Trung Quốc sở hữu hệ thống sản xuất công nghiệp hiện đại có quy mô lớn nhất và đầy đủ ngành nghề nhất trên thế giới, đóng vai trò then chốt như hòn đá tảng giữ thăng bằng để bảo đảm tính an toàn và dẻo dai của chuỗi ngành nghề và chuỗi cung ứng toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2416,
    hanzi: '工艺',
    pinyin: 'gōngyì',
    word_type: 'Danh từ',
    meaning_vi: 'công nghệ, quy trình chế tác, tay nghề thủ công',
    examples: [
      {
        chinese: '景德镇出产的传统青花瓷器造型优美、烧制工艺精湛，闻名遐迩。',
        pinyin: 'Jǐngdézhèn chūchǎn de chuántǒng qīnghuā cíqì zàoxíng yōuměi, shāozhì gōngyì jīngzhàn, wénmíng-xiá’ěr.',
        meaning_vi: 'Đồ gốm sứ hoa lam truyền thống xuất xứ từ Cảnh Đức Trấn có tạo hình đẹp mắt, quy trình nung chế tinh xảo tuyệt luân, nức tiếng gần xa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '先进半导体晶圆代工制造对光刻与薄膜沉积的纳米级加工工艺有着极其严苛的公差控制要求，容不得丝毫哪怕几纳米的微尘偏差。',
        pinyin: 'Xiānjìn bàndǎotǐ jīngyuán dàigōng zhìzào duì guāngkè yǔ bómó chénjī de nàmǐjí jiāgōng gōngyì yǒuzhe jíqí yánkē de gōngchà kòngzhì yāoqiú, róng bùdé sīháo nǎpà jǐ nàmǐ de wēichén piānchā.',
        meaning_vi: 'Chế tạo gia công tấm bán dẫn wafer tiên tiến có yêu cầu kiểm soát dung sai cực kỳ khắt khe đối với quy trình công nghệ gia công cấp độ nanomet của quang khắc và lắng đọng màng mỏng, không chấp nhận bất kỳ sai lệch nào dù chỉ vài nanomet bụi mịn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2417,
    hanzi: '公寓',
    pinyin: 'gōngyù',
    word_type: 'Danh từ',
    meaning_vi: 'căn hộ chung cư, khu nhà tập thể',
    examples: [
      {
        chinese: '他在公司附近租了一间精装修的单身公寓，每天步行十分钟即可上下班。',
        pinyin: 'Tā zài gōngsī fùjìn zū le yì jiān jīngzhuāngxiū de dānshēn gōngyù, měitiān bùxíng shí fēnzhōng jíkě shàng-xiàbān.',
        meaning_vi: 'Anh ấy đã thuê một căn hộ chung cư đơn thân đầy đủ nội thất cao cấp ở gần công ty, mỗi ngày chỉ cần đi bộ mười phút là có thể đi làm và tan sở.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大城市为吸引高层次海归科研人才与青年创业者，在核心商务科技园周边统一规划建设了配套齐全、租金补贴优惠的人才智慧青年公寓。',
        pinyin: 'Dà chéngshì wèi xīyǐn gāo céngcì hǎiguī kēyán réncái yǔ qīngnián chuàngyèzhě, zài héxīn shāngwù kējìyuán zhōubiān tǒngyī guīhuà jiànshè le pèitào qíquán, zūjīn bǔtiē yōuhuì de réncái zhìhuì qīngnián gōngyù.',
        meaning_vi: 'Các đô thị lớn nhằm thu hút nhân tài nghiên cứu khoa học du học về nước trình độ cao cùng các nhà khởi nghiệp trẻ, đã quy hoạch xây dựng đồng bộ các khu căn hộ chung cư thông minh dành cho nhân tài trẻ tuổi với tiện ích đầy đủ và chính sách trợ cấp tiền thuê nhà ưu đãi quanh các công viên khoa học thương mại cốt lõi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2418,
    hanzi: '贡献',
    pinyin: 'gòngxiàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'cống hiến, đóng góp',
    examples: [
      {
        chinese: '老科学家把自己一生的青春与心血都无私奉献给了祖国的农业育种科研事业。',
        pinyin: 'Lǎo kēxuéjiā bǎ zìjǐ yìshēng de qīngchūn yǔ xīnxuè dōu wúsī fèngxiàn gěi le zǔguó de nóngyè yùzhǒng kēyán shìyè.',
        meaning_vi: 'Nhà khoa học lão thành đã cống hiến vô tư cả tuổi xuân và tâm huyết cả đời mình cho sự nghiệp nghiên cứu khoa học lai tạo giống cây nông nghiệp của tổ quốc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '袁隆平院士一生潜心钻研杂交水稻杂交育种技术，不仅解决了数亿中国人的吃饭问题，更对保障全人类的全球粮食安全作出了不可磨灭的历史性重大贡献。',
        pinyin: 'Yuán Lóngpíng yuànshì yìshēng qiánxīn zuānyán zájiāo shuǐdào zájiāo yùzhǒng jìshù, bùjǐn jiějué le shù yì Zhōngguórén de chīfàn wèntí, gèng duì bǎozhàng quán rénlèi de quánqiú liángshi ānquán zuòchū le bùkě mómìe de lìshǐxìng zhòngdà gòngxiàn.',
        meaning_vi: 'Viện sĩ Viên Long Bình cả đời dốc lòng nghiên cứu công nghệ lai tạo giống lúa lai, không chỉ giải quyết bài toán lương thực cho hàng trăm triệu người dân Trung Quốc, mà còn tạo nên cống hiến lịch sử trọng đại không thể phai mờ đối với việc bảo đảm an ninh lương thực toàn cầu cho toàn nhân loại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2419,
    hanzi: '共享',
    pinyin: 'gòngxiǎng',
    word_type: 'Động từ',
    meaning_vi: 'cùng hưởng, chia sẻ dùng chung',
    examples: [
      {
        chinese: '在繁华的地铁站出入口，摆放着许多整齐排列的共享单车供市民随时扫码骑行。',
        pinyin: 'Zài fánhuá de dìtiězhàn chūrùkǒu, bǎifàng zhe xǔduō zhěngqí páiliè de gòngxiǎng dānchē gōng shìmín suíshí sǎomǎ qíxíng.',
        meaning_vi: 'Tại các lối ra vào ga tàu điện ngầm sầm uất, có đặt rất nhiều xe đạp dùng chung xếp thành hàng ngay ngắn để người dân có thể quét mã đạp xe bất cứ lúc nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '推进区域经济一体化发展的核心举措之一，就是破除行政壁垒，实现跨区域公共医疗科研大数据、教育名师资源以及大型科研仪器设备的互联互通与开放共享。',
        pinyin: 'Tuījìn qūyù jīngjì yītǐhuà fāzhǎn de héxīn jǔcuò zhīyī, jiùshì pòchú xíngzhèng bìlěi, shíxiàn kuà qūyù gōnggòng yīliáo kēyán dàshùjù, jiàoyù míngshī zīyuán yǐjí dàxíng kēyán yíqì shèbèi de hùlián-hùtōng yǔ kāifàng gòngxiǎng.',
        meaning_vi: 'Một trong những biện pháp cốt lõi để thúc đẩy phát triển liên kết kinh tế vùng nhất thể hóa chính là phá bỏ rào cản hành chính, thực hiện kết nối liên thông và chia sẻ mở rộng các nguồn dữ liệu lớn nghiên cứu y tế công cộng, tài nguyên giáo viên giỏi cùng các thiết bị máy móc nghiên cứu khoa học cỡ lớn liên vùng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2420,
    hanzi: '沟通',
    pinyin: 'gōutōng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'giao tiếp, trao đổi, thông hiểu, gắn kết',
    examples: [
      {
        chinese: '当朋友之间产生误会时，坦诚面对并及时沟通是化解矛盾最好的办法。',
        pinyin: 'Dāng péngyou zhījiān chǎnshēng wùhuì shí, tǎnchéng miànduì bìng jíshí gōutōng shì huàjiě máodùn zuì hǎo de bànfǎ.',
        meaning_vi: 'Khi giữa bạn bè nảy sinh hiểu lầm, đối mặt chân thành và kịp thời giao tiếp trao đổi là cách tốt nhất để hóa giải mâu thuẫn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在跨文化跨学科的全球化大项目中，项目负责人必须具备高超的双语谈判技巧与同理心沟通协调能力，才能妥善平衡各方利益诉求并推动合作顺利落地。',
        pinyin: 'Zài kuà wénhuà kuà xuékē de quánqiúhuà dà xiàngmù zhōng, xiàngmù fùzérén bìxū jùbèi gāochāo de shuāngyǔ tánpàn jìqiǎo yǔ tónglǐxīn gōutōng xiétiáo nénglì, cáinéng tuǒshàn pínghéng gèfāng lìyì sùqiú bìng tuīdòng hézuò shùnlì luòdì.',
        meaning_vi: 'Trong các dự án toàn cầu hóa quy mô lớn liên văn hóa và liên ngành, người phụ trách dự án nhất định phải sở hữu kỹ năng đàm phán song ngữ điêu luyện cùng năng lực giao tiếp điều phối thấu cảm cao độ, mới có thể cân bằng thỏa đáng các yêu cầu lợi ích của các bên và thúc đẩy hợp tác đi vào thực tiễn thuận lợi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2421,
    hanzi: '构成',
    pinyin: 'gòuchéng',
    word_type: 'Động từ',
    meaning_vi: 'cấu thành, tạo thành',
    examples: [
      {
        chinese: '红花、绿草和清澈见底的溪流共同构成了春天山谷里一幅宁静优美的自然画卷。',
        pinyin: 'Hóng huā, lǜ cǎo hé qīngchè-jiàndǐ de xīliú gòngtóng gòuchéng le chūntiān shāngǔ lǐ yì fú níngjìng yōuměi de zìrán huàjuàn.',
        meaning_vi: 'Hoa đỏ, cỏ xanh và dòng suối trong vắt nhìn thấy tận đáy đã cùng nhau cấu thành nên một bức tranh thiên nhiên tĩnh lặng tươi đẹp nơi thung lũng mùa xuân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '法院在审理后依法认定，该企业在互联网平台公开发布虚假产品质量评测并诋毁同行商誉的行为，已经构成了不正当竞争与民事侵权。',
        pinyin: 'Fǎyuàn zài shěnlǐ hòu yīfǎ rèndìng, gāi qǐyè zài hùliánwǎng píngtái gōngkāi fābù xūjiǎ chǎnpǐn zhìliàng píngcè bìng dǐhuǐ tóngháng shāngyù de xíngwéi, yǐjīng gòuchéng le bù zhèngdàng jìngzhēng yǔ mínshì qīnquán.',
        meaning_vi: 'Tòa án sau khi xét xử đã nhận định theo luật rằng, hành vi doanh nghiệp này công khai đăng tải các bài đánh giá kiểm thử chất lượng sản phẩm giả mạo trên nền tảng mạng internet và bôi nhọ uy tín thương mại của đồng nghiệp trong ngành, đã cấu thành hành vi cạnh tranh không lành mạnh và xâm phạm dân sự.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2422,
    hanzi: '古',
    pinyin: 'gǔ',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'cổ, xưa, cổ kính, thời xưa',
    examples: [
      {
        chinese: '中国古诗讲究押韵与对仗，字里行间往往流露出深沉隽永的情感。',
        pinyin: 'Zhōngguó gǔshī jiǎngjiu yāyùn yǔ duìzhàng, zìlǐ-hángjiān wǎngwǎng liúlù chū shēnchén juànyǒng de qínggǎn.',
        meaning_vi: 'Thơ cổ Trung Quốc rất chú trọng gieo vần và phép đối ngẫu, giữa các hàng chữ thường bộc lộ cảm xúc sâu lắng ý vị dài lâu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '学者通过对比研究古今汉语在语音演化、词义转移及句法结构方面的流变特征，清晰揭示了华夏语言文字数千年绵延不绝的生命力。',
        pinyin: 'Xuézhě tōngguò duìbǐ yánjiū gǔ-jīn Hànyǔ zài yǔyīn yǎnhuà, cíyì zhuǎnyí jí jùfǎ jiégòu fāngmiàn de liúbiàn tèzhēng, qīngxī jiēshì le Huáxià yǔyán wénzì shù qiān nián miányán-bùjué de shēngmìnglì.',
        meaning_vi: 'Các học giả thông qua việc nghiên cứu so sánh các đặc trưng biến đổi của tiếng Hán xưa và nay trên các phương diện diễn hóa ngữ âm, dịch chuyển nghĩa từ và cấu trúc cú pháp, đã làm sáng tỏ sức sống bền bỉ không dứt qua hàng nghìn năm của ngôn ngữ văn tự dân tộc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2423,
    hanzi: '鼓',
    pinyin: 'gǔ',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'cái trống; đánh trống, gõ, cổ vũ',
    examples: [
      {
        chinese: '在传统龙舟比赛中，船头的鼓手奋力击鼓，为全船奋勇划桨的队员们鼓舞士气。',
        pinyin: 'Zài chuántǒng lóngzhōu bǐsài zhōng, chuántóu de gǔshǒu fènlì jīgǔ, wèi quán chuán fènyǒng huájiǎng de duìyuán men gǔwǔ shìqì.',
        meaning_vi: 'Trong cuộc đua thuyền rồng truyền thống, người đánh trống ở đầu thuyền dốc sức gõ trống để cổ vũ sĩ khí cho các thành viên đang ra sức chèo mái chèo trên toàn thuyền.',
        difficulty_level: 'basic'
      },
      {
        chinese: '每逢重大节日庆典，陕北威风锣鼓队气势磅礴的阵型与震天动地的鼓点声浪，生动展现出黄土高原人民豪迈热烈、昂扬向上的精神风貌。',
        pinyin: 'Měiféng zhòngdà jiérì qìngdiǎn, Shǎnběi wēifēng luógǔduì qìshì pángbó de zhènxíng yǔ zhèntiān-dòngdì de gǔdiǎn shēnglàng, shēngdòng zhǎnxiàn chū huángtǔ gāoyuán rénmín háomài rèliè, ángyáng xiàngshàng de jīngshén fēngmào.',
        meaning_vi: 'Mỗi dịp đại lễ kỷ niệm, đội chiêng trống uy phong đất Thiểm Bắc với đội hình khí thế bàng bạc và làn sóng tiếng trống rền vang rung chuyển trời đất, đã thể hiện sinh động diện mạo tinh thần hào sảng nhiệt huyết và luôn vươn lên của người dân vùng cao nguyên đất vàng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2424,
    hanzi: '古代',
    pinyin: 'gǔdài',
    word_type: 'Danh từ',
    meaning_vi: 'thời cổ đại, thời xưa',
    examples: [
      {
        chinese: '指南针、火药、造纸术和活字印刷术并称为中国古代享誉世界的“四大发明”。',
        pinyin: 'Zhǐnánzhēn, huǒyào, zàozhǐshù hé huózì yìnshuāshù bìngchēng wéi Zhōngguó gǔdài xiǎngyù shìjiè de “sì dà fāmíng”.',
        meaning_vi: 'La bàn, thuốc súng, kỹ thuật làm giấy và in ấn chữ rời được mệnh danh là "Tứ đại phát minh" vang danh thế giới của thời cổ đại Trung Quốc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '考古工作者在古代丝绸之路沿线的沙漠古城遗址中发掘出大量罗马金币、波斯织锦和汉代竹简，生动印证了古代东西方文明跨越千里的经贸文化繁荣交流。',
        pinyin: 'Kǎogǔ gōngzuòzhě zài gǔdài Sīchóu zhī Lù yánxiàn de shāmò gǔchéng yízhǐ zhōng fājué chū dàliàng Luómǎ jīnbì, Bōsī zhījǐn hé Hàndài zhújiǎn, shēngdòng yìnzhèng le gǔdài dōng-xīfāng wénmíng kuàyuè qiān lǐ de jīngmào wénhuà fánróng jiāoliú.',
        meaning_vi: 'Các nhà khảo cổ học tại di chỉ thành cổ giữa sa mạc dọc theo Con đường Tơ lụa thời cổ đại đã khai quật được lượng lớn tiền vàng La Mã, gấm dệt Ba Tư và thẻ tre thời Hán, chứng minh sinh động cho sự giao lưu thịnh vượng về văn hóa kinh tế thương mại vượt hàng nghìn dặm giữa các nền văn minh phương Đông và phương Tây thời cổ xưa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2425,
    hanzi: '古老',
    pinyin: 'gǔlǎo',
    word_type: 'Tính từ',
    meaning_vi: 'cổ kính, lâu đời',
    examples: [
      {
        chinese: '漫步在长城蜿蜒起伏的石阶上，人们无不为这处古老而伟大的世界文化遗产所震撼。',
        pinyin: 'Mànbù zài Chángchéng wānyán qǐfú de shíjiē shang, rénmín wúbù wèi zhè chù gǔlǎo ér wěidà de shìjiè wénhuà yíchǎn suǒ zhènhàn.',
        meaning_vi: 'Tản bộ trên những bậc đá uốn lượn nhấp nhô của Vạn Lý Trường Thành, không ai là không bị chấn động bởi di sản văn hóa thế giới cổ kính và vĩ đại này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '非物质文化遗产传承人凭借数十年如一日的匠心坚守，让古老的皮影戏和手工扎染技艺在现代年轻一代观众中重新焕发出生机与活力。',
        pinyin: 'Fēi wùzhì wénhuà yíchǎn chuánchéngrén píngjiè shù shí nián rú yírì de jiàngxīn jiānshǒu, ràng gǔlǎo de píyǐngxì hé shǒugōng zānrǎn jìyì zài xiàndài niánqīng yídài guānzhòng zhōng chóngxīn huànfā chū shēngjī yǔ huólì.',
        meaning_vi: 'Người truyền thừa di sản văn hóa phi vật thể nhờ sự kiên trì với tâm huyết người thợ mộc mạc suốt mấy chục năm như một, đã giúp cho nghệ thuật múa rối bóng và kỹ nghệ nhuộm buộc thủ công cổ xưa bừng sáng lại sức sống và sự tươi mới trong lòng thế hệ khán giả trẻ hiện đại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2426,
    hanzi: '鼓掌',
    pinyin: 'gǔzhǎng',
    word_type: 'Động từ',
    meaning_vi: 'vỗ tay, hoan hô tán thưởng',
    examples: [
      {
        chinese: '当精彩的钢琴演奏落下最后一个优美的音符时，全场观众情不自禁地起立热烈鼓掌。',
        pinyin: 'Dāng jīngcǎi de gāngqín yǎnzòu luòxià zuìhòu yí gè yōuměi de yīnfú shí, quánchǎng guānzhòng qíngbùzìjìn de qǐlì rèliè gǔzhǎng.',
        meaning_vi: 'Khi nốt nhạc tuyệt đẹp cuối cùng của buổi diễn tấu dương cầm xuất sắc vừa dứt điểm, toàn thể khán giả trong khán phòng đã không kìm được đồng loạt đứng dậy vỗ tay nồng nhiệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '经过长达三轮艰苦激烈的商务谈判，当双方首席代表在多边经贸战略合作框架协议上正式落笔签字时，会议室里爆发出了经久不息的热烈鼓掌与欢呼声。',
        pinyin: 'Jīngguò cháng dá sān lún jiānkǔ jīliè de shāngwù tánpàn, dāng shuāngfāng shǒuxí dàibiǎo zài duōbiān jīngmào zhànlüè hézuò kuàngjià xiéyì shang zhèngshì luòbǐ qiānzì shí, huìyìshì lǐ bàofā chū le jīngjiǔ-bùxī de rèliè gǔzhǎng yǔ huānhū shēng.',
        meaning_vi: 'Trải qua ba vòng đàm phán thương mại gian khổ và quyết liệt kéo dài, khi đại diện trưởng của hai bên chính thức đặt bút ký kết hiệp định khung hợp tác chiến lược kinh tế thương mại đa phương, trong phòng hội nghị đã bùng nổ những tràng pháo tay giòn giã và tiếng reo hò kéo dài không dứt.',
        difficulty_level: 'applied'
      }
    ]
  }
]
