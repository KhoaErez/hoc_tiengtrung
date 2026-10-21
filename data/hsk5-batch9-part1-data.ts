// data/hsk5-batch9-part1-data.ts
// 25 từ HSK 5: #2802 [牛仔裤] -> #2826 [批]

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

export const HSK5_BATCH9_PART1: VocabItem[] = [
  {
    id: 2802,
    hanzi: '牛仔裤',
    pinyin: 'niúzǎikù',
    word_type: 'Danh từ',
    meaning_vi: 'quần bò, quần jean',
    examples: [
      {
        chinese: '这件简单的白T恤搭配经典蓝色牛仔裤，看起来既阳光又干练。',
        pinyin: 'Zhè jiàn jiǎndān de bái T-xù dāpèi jīngdiǎn lánsè niúzǎikù, kàn qǐlái jì yángguāng yòu gànliàn.',
        meaning_vi: 'Chiếc áo phông trắng đơn giản này phối cùng quần jean xanh kinh điển, trông vừa tươi sáng lại vừa năng động.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代环保纺织工业采用无水激光做旧与天然植物靛蓝染色技术，显著降低了传统牛仔裤加工过程中的水资源消耗与重金属污染。',
        pinyin: 'Xiàndài huánbǎo fǎngzhī gōngyè cǎiyòng wúshuǐ jīguāng zuòjiù yǔ tiānrán zhíwù diànlán rǎnsè jìshù, xiǎnzhù jiàngdī le chuántǒng niúzǎikù jiāgōng guòchéng zhōng de shuǐzīyuán xiāohào yǔ zhòngjīnshǔ wūrǎn.',
        meaning_vi: 'Ngành dệt may sinh thái hiện đại ứng dụng kỹ thuật làm cũ bằng laser không dùng nước và nhuộm chàm thực vật tự nhiên, giảm thiểu rõ rệt lượng tiêu hao tài nguyên nước và ô nhiễm kim loại nặng trong quy trình gia công quần jean truyền thống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2803,
    hanzi: '浓',
    pinyin: 'nóng',
    word_type: 'Tính từ',
    meaning_vi: 'đậm, đặc, nồng (trà, cà phê, sương mù, tình cảm)',
    examples: [
      {
        chinese: '早晨起床后，爸爸喜欢泡上一杯香气浓郁的热咖啡。',
        pinyin: 'Zǎochen qǐchuáng hòu, bàba xǐhuan pào shàng yì bēi xiāngqì nóngyù de rè kāfēi.',
        meaning_vi: 'Sau khi thức dậy vào buổi sáng, bố thích pha một tách cà phê nóng thơm nồng đậm đà.',
        difficulty_level: 'basic'
      },
      {
        chinese: '浓厚的传统中医药文化底蕴与严谨的现代分子生物学研究深度融合，正在为攻克世界性难治性慢病提供独具东方智慧的创新方案。',
        pinyin: 'Nónghòu de chuántǒng zhōng-yīyào wénhuà dǐyùn yǔ yánjǐn de xiàndài fēnzǐ shēngwùxué yánjiū shēndù rónghé, zhèngzài wèi gōngkè shìjièxìng nánzhìxìng mànbìng tígōng dú jù dōngfāng zhìhuì de chuàngxīn fāng’àn.',
        meaning_vi: 'Chiều sâu văn hóa y dược cổ truyền đậm đà dung hợp sâu sắc với nghiên cứu sinh học phân tử hiện đại nghiêm ngặt, đang cung cấp những giải pháp đổi mới mang đậm trí tuệ phương Đông nhằm khắc phục các căn bệnh mãn tính nan y tầm thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2804,
    hanzi: '农民',
    pinyin: 'nóngmín',
    word_type: 'Danh từ',
    meaning_vi: 'nông dân, người làm nông',
    examples: [
      {
        chinese: '金秋十月，辛勤耕耘的农民们迎来了稻谷大丰收的喜悦。',
        pinyin: 'Jīnqiū shí yuè, xīnqín gēngyún de nóngmínmen yínglái le dàogǔ dà fēngshōu de xǐyuè.',
        meaning_vi: 'Tháng 10 mùa thu vàng, những người nông dân một nắng hai sương đã đón nhận niềm vui được mùa lúa bội thu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家大力培育有文化、懂技术、善经营的新型职业农民，有力推动了现代农业规模化、智慧化与绿色高质高效发展。',
        pinyin: 'Guójiā dàlì péiyù yǒu wénhuà, dǒng jìshù, shàn jīngyíng de xīnxíng zhíyè nóngmín, yǒulì tuīdòng le xiàndài nóngyè guīmóhuà, zhìhuìhuà yǔ lǜsè gāozhì gāoxiào fāzhǎn.',
        meaning_vi: 'Nhà nước đẩy mạnh đào tạo thế hệ nông dân nghề nghiệp kiểu mới có văn hóa, hiểu kỹ thuật và giỏi kinh doanh, thúc đẩy mạnh mẽ nền nông nghiệp hiện đại phát triển theo hướng quy mô, thông minh và xanh chất lượng cao hiệu quả cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2805,
    hanzi: '农业',
    pinyin: 'nóngyè',
    word_type: 'Danh từ',
    meaning_vi: 'nông nghiệp',
    examples: [
      {
        chinese: '农业是国民经济的基础，关系到千家万户的粮食安全。',
        pinyin: 'Nóngyè shì guómín jīngjì de jīchǔ, guānxì dào qiānjiā-wànhù de liángshi ānquán.',
        meaning_vi: 'Nông nghiệp là nền tảng của nền kinh tế quốc dân, liên quan mật thiết tới an ninh lương thực của muôn nhà.',
        difficulty_level: 'basic'
      },
      {
        chinese: '以卫星遥感、农机自动驾驶以及物联网精准水肥为特征的智慧农业，已成为推动农业农村现代化与乡村全面振兴的核心驱动力。',
        pinyin: 'Yǐ wèixīng yáogǎn, nóngjī zìdòng jiàshǐ yǐjí wùliánwǎng jīngzhǔn shuǐféi wéi tèzhēng de zhìhuì nóngyè, yǐ chéngwéi tuīdòng nóngyè nóngcūn xiàndàihuà yǔ xiāngcūn quánmiàn zhènxīng de héxīn qūdònglì.',
        meaning_vi: 'Nông nghiệp thông minh với các đặc trưng như viễn thám vệ tinh, máy nông nghiệp tự lái và tưới tiêu phân bón chính xác qua IoT đã trở thành động lực then chốt thúc đẩy hiện đại hóa nông nghiệp nông thôn và chấn hưng toàn diện làng quê.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2806,
    hanzi: '女子',
    pinyin: 'nǚzǐ',
    word_type: 'Danh từ',
    meaning_vi: 'nữ giới, phụ nữ, nữ tử',
    examples: [
      {
        chinese: '我国女子排球队在国际赛场上展现出了顽强拼搏的女排精神。',
        pinyin: 'Wǒ guó nǚzǐ páiqiúduì zài guójì sàichǎng shang zhǎnxiàn chū le wánqiáng pīnbó de nǚpái jīngshén.',
        meaning_vi: 'Đội tuyển bóng chuyền nữ nước ta trên đấu trường quốc tế đã thể hiện tinh thần bóng chuyền nữ kiên cường chiến đấu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代社会高度尊重并全面保障广大女子在政治参与、科技创新、企业经营以及社会公益等各个领域的合法平等权益。',
        pinyin: 'Xiàndài shèhuì gāodù zūnzhòng bìng quánmiàn bǎozhàng guǎngdà nǚzǐ zài zhèngzhì cānyù, kējì chuàngxīn, qǐyè jīngyíng yǐjí shèhuì gōngyì děng gègè lǐngyù de héfǎ píngděng quányì.',
        meaning_vi: 'Xã hội hiện đại tôn trọng sâu sắc và bảo đảm toàn diện các quyền lợi bình đẳng hợp pháp của đông đảo nữ giới trong mọi lĩnh vực như tham chính, đổi mới công nghệ, quản trị doanh nghiệp và hoạt động công ích xã hội.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2807,
    hanzi: '哦',
    pinyin: 'ò',
    word_type: 'Thán từ',
    meaning_vi: 'ồ, à (nhận ra, hiểu ra)',
    examples: [
      {
        chinese: '哦，听你这么一说，我终于弄明白这道题的解题思路了。',
        pinyin: 'Ò, tīng nǐ zhème yì shuō, wǒ zhōngyú nòng míngbai zhè dào tí de jiětí sīlù le.',
        meaning_vi: 'Ồ, nghe bạn giải thích như vậy, tôi cuối cùng đã hiểu ra hướng tư duy giải quyết bài toán này rồi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '哦，原来这台进口高精密机床的核心控制器内置了多重防过载算法保护，难怪在超高负荷工况下依然能保持零故障稳定运行。',
        pinyin: 'Ò, yuánlái zhè tái jìnkǒu gāo jīngmì jīchuáng de héxīn kòngzhìqì nèizhì le duōchóng fáng guòzài suànfǎ bǎohù, nánguài zài chāo gāo fùhè gōngkuàng xià yīrán néng bǎochí líng gùzhàng wěndìng yùnxíng.',
        meaning_vi: 'Ồ, hóa ra bộ điều khiển cốt lõi của máy công cụ chính xác cao nhập khẩu này đã tích hợp thuật toán bảo vệ chống quá tải đa tầng, thảo nào trong điều kiện làm việc siêu tải trọng vẫn duy trì vận hành ổn định không lỗi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2808,
    hanzi: '欧洲',
    pinyin: 'Ōuzhōu',
    word_type: 'Danh từ',
    meaning_vi: 'châu Âu',
    examples: [
      {
        chinese: '他利用毕业旅行的机会游历了欧洲的多个历史文化名城。',
        pinyin: 'Tā lìyòng bìyè lǚxíng de jīhuì yóulì le Ōuzhōu de duō gè lìshǐ wénhuà míngchéng.',
        meaning_vi: 'Anh ấy tận dụng cơ hội chuyến du lịch tốt nghiệp để đi du ngoạn nhiều thành phố lịch sử văn hóa nổi tiếng của châu Âu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中欧班列作为亚欧大陆互联互通的重要陆路运输骨干通道，将共建一带一路国家紧密串联，有力促进了中国与欧洲多国双向经贸繁荣。',
        pinyin: 'Zhōng-Ōu bānliè zuòwéi Yà-Ōu dàlù hùlián-hùtōng de zhòngyào lùlù yùnshū gǔgàn tōngdào, jiāng gòngjiàn Yídài-Yílù guójiā jǐnmì chuànlián, yǒulì cùjìn le Zhōngguó yǔ Ōuzhōu duō guó shuāngxiàng jīngmào fánróng.',
        meaning_vi: 'Tuyến tàu hàng Trung Quốc - châu Âu với tư cách là hành lang vận tải đường bộ xương sống kết nối lục địa Á - Âu, đã kết nối chặt chẽ các quốc gia cùng xây dựng Vành đai và Con đường, thúc đẩy mạnh mẽ sự phồn vinh kinh tế thương mại hai chiều giữa Trung Quốc và nhiều nước châu Âu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2809,
    hanzi: '偶然',
    pinyin: 'ǒurán',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'ngẫu nhiên, tình cờ, bất ngờ',
    examples: [
      {
        chinese: '今天在图书馆查资料时，我偶然翻到了一本寻找已久的绝版古籍。',
        pinyin: 'Jīntiān zài túshūguǎn chá zīliào shí, wǒ ǒurán fāndào le yì běn xúnzhǎo yǐ jiǔ de juébǎn gǔjí.',
        meaning_vi: 'Hôm nay khi tra cứu tài liệu ở thư viện, tôi tình cờ lật trúng cuốn sách cổ đã ngừng xuất bản mà mình tìm kiếm bấy lâu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科学史上的许多重大突破看似源于偶然的灵感火花，但其背后无不凝聚着科研人员数十年如一日坚持不懈的深厚理论积淀与必然努力。',
        pinyin: 'Kēxuéshǐ shang de xǔduō zhòngdà tūpò kànsì yuányú ǒurán de línggǎn huǒhuā, dàn qí bèihòu wúbù níngjù zhe kēyán rényuán shù shí nián rú yí rì jiānchí-búxiè de shēnhòu lǐlùn jīdiàn yǔ bìrán nǔlì.',
        meaning_vi: 'Nhiều đột phá trọng đại trong lịch sử khoa học thoạt nhìn dường như bắt nguồn từ tia lửa cảm hứng ngẫu nhiên, nhưng ẩn sau đó đều kết tinh nền tảng lý luận sâu sắc cùng nỗ lực kiên trì bền bỉ hàng chục năm như một của giới nghiên cứu khoa học.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2810,
    hanzi: '拍摄',
    pinyin: 'pāishè',
    word_type: 'Động từ',
    meaning_vi: 'chụp ảnh, quay phim, ghi hình',
    examples: [
      {
        chinese: '摄影师在风景优美的湖边为新婚夫妇拍摄了一组温馨浪漫的婚纱照。',
        pinyin: 'Shèyǐngshī zài fēngjǐng yōuměi de húbiān wèi xīnhūn fūfù pāishè le yì zǔ wēnxīn làngmàn de hūnshāzhào.',
        meaning_vi: 'Nhiếp ảnh gia bên bờ hồ phong cảnh hữu tình đã chụp cho đôi vợ chồng mới cưới một bộ ảnh cưới ấm áp và lãng mạn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该自然纪录片制作团队采用高空超高清红外遥感无人机系统，在人迹罕至的高原雪峰历时三年成功拍摄到了珍稀野生雪豹的完整繁育影像。',
        pinyin: 'Gāi zìrán jìlùpiàn zhìzuò tuánduì cǎiyòng gāokōng chāogāoqīng hóngwài yáogǎn wúrénjī xìtǒng, zài rénjì-hǎnjià de gāoyuán xuěfēng lìshí sān nián chénggōng pāishè dào le zhēnxī yěshēng xuěbào de wánzhěng fányù yǐngxiàng.',
        meaning_vi: 'Đoàn làm phim tài liệu tự nhiên này ứng dụng hệ thống flycam viễn thám hồng ngoại siêu nét trên tầm cao, trải qua 3 năm tại vùng núi tuyết cao nguyên hẻo lánh không bóng người đã ghi hình thành công thước phim sinh sản hoàn chỉnh của loài báo tuyết hoang dã quý hiếm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2811,
    hanzi: '排列',
    pinyin: 'páiliè',
    word_type: 'Động từ',
    meaning_vi: 'xếp hàng, sắp xếp, bài trí theo thứ tự',
    examples: [
      {
        chinese: '书架上的各类专业参考书都被图书管理员整齐有序地排列好了。',
        pinyin: 'Shūjià shang de gèlèi zhuānyè cānkǎoshū dōu bèi túshū guǎnlǐyuán zhěngqí yǒuxù de páiliè hǎo le.',
        meaning_vi: 'Các loại sách tham khảo chuyên ngành trên kệ sách đều đã được thủ thư sắp xếp ngay ngắn và có trật tự.',
        difficulty_level: 'basic'
      },
      {
        chinese: '材料科学家通过精确调控二维纳米晶格中原子阵列的特定排列组合，成功研发出具有室温超导潜力与极高载流子迁移率的新型量子材料。',
        pinyin: 'Cáiliào kēxuéjiā tōngguò jīngquè tiáokòng èrwéi nàmǐ jīnggé zhōng yuánzǐ zhènliè de tèdìng páiliè zǔhé, chénggōng yánfā chū jùyǒu shìwēn chāodǎo qiánlì yǔ jí gāo zàiliúzǐ qiānyílǜ de xīnxíng liàngzǐ cáiliào.',
        meaning_vi: 'Các nhà khoa học vật liệu thông qua việc điều khiển chuẩn xác trật tự sắp xếp đặc định của chuỗi nguyên tử trong mạng tinh thể nano hai chiều đã chế tạo thành công loại vật liệu lượng tử mới mang tiềm năng siêu dẫn ở nhiệt độ phòng và độ linh động hạt tải điện cực cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2812,
    hanzi: '派',
    pinyin: 'pài',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phái, cử, điều động; phe phái, trường phái',
    examples: [
      {
        chinese: '公司决定派三名经验丰富的资深工程师前往海外分公司指导项目施工。',
        pinyin: 'Gōngsī juédìng pài sān míng jīngyàn fēngfù de zīshēn gōngchéngshī qiánwǎng hǎiwài fēngōngsī zhǐdǎo xiàngmù shīgōng.',
        meaning_vi: 'Công ty quyết định cử ba kỹ sư kỳ cựu giàu kinh nghiệm sang chi nhánh hải ngoại để hướng dẫn thi công dự án.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在深化学术百花齐放的学术生态中，不同学派之间围绕重大理论问题展开平等的学术争鸣，有力促进了科学理论体系的繁荣演进。',
        pinyin: 'Zài shēnhuà xuéshù bǎihuā-qífàng de xuéshù shēngtài zhōng, bùtóng xuépài zhījiān wéirào zhòngdà lǐlùn wèntí zhǎnkāi píngděng de xuéshù zhēngmíng, yǒulì cùjìn le kēxué lǐlùn tǐxì de fánróng yǎnjìn.',
        meaning_vi: 'Trong hệ sinh thái học thuật trăm hoa đua nở ngày càng sâu rộng, giữa các trường phái học thuật khác nhau cùng triển khai tranh luận học thuật bình đẳng xoay quanh các vấn đề lý luận lớn đã thúc đẩy mạnh mẽ sự tiến hóa phồn vinh của hệ thống lý luận khoa học.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2813,
    hanzi: '派出所',
    pinyin: 'pàichūsuǒ',
    word_type: 'Danh từ',
    meaning_vi: 'đồn công an, trạm cảnh sát',
    examples: [
      {
        chinese: '如果不慎丢失了身份证，需要尽快前往户籍所在地派出所申请补办。',
        pinyin: 'Rúguǒ búshèn diūshī le shēnfènzhèng, xūyào jǐnkuài qiánwǎng hùjí suǒzàidì pàichūsuǒ shēnqǐng bǔbàn.',
        meaning_vi: 'Nếu không may làm mất thẻ căn cước, cần nhanh chóng đến đồn công an nơi đăng ký hộ khẩu để xin cấp lại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '基层公安派出所践行新时代“枫桥经验”，依靠群防群治网格化治理力量将矛盾纠纷化解在基层萌芽状态，切实守护一方百姓的平安。',
        pinyin: 'Jīcéng gōng’ān pàichūsuǒ jiànxíng xīn shídài “Fēngqiáo jīngyàn”, yīkào qúnfáng-qúnzhì wǎnggéhuà zhìlǐ lìliàng jiāng máodùn jiūfēn huàjiě zài jīcéng méngyá zhuàngtài, qièshí shǒuhù yì fāng bǎixìng de píng’ān.',
        meaning_vi: 'Đồn công an cơ sở thực hành "Kinh nghiệm Phong Kiều" thời đại mới, dựa vào sức mạnh quản trị mạng lưới quần chúng tự phòng tự quản để hóa giải mâu thuẫn tranh chấp ngay từ mầm mống cơ sở, bảo vệ thiết thực sự bình yên cho nhân dân một vùng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2814,
    hanzi: '跑道',
    pinyin: 'pǎodào',
    word_type: 'Danh từ',
    meaning_vi: 'đường chạy (thể thao); đường băng (sân bay); đường đua (ngành nghề)',
    examples: [
      {
        chinese: '运动员们站在起跑线上，专注地注视着前方平整红艳的塑胶跑道。',
        pinyin: 'Yùndòngyuánmen zhàn zài qǐpǎoxiàn shang, zhuānzhù de zhùshì zhe qiánfāng píngzhěng hóngyàn de sùjiāo pǎodào.',
        meaning_vi: 'Các vận động viên đứng tại vạch xuất phát, chăm chú nhìn đường chạy nhựa tổng hợp phẳng phiu đỏ thắm phía trước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着新质生产力的加速培育，商业航天、低空经济以及类脑人形机器人等战略新兴赛道，正在成为各大科技领军企业竞逐的新跑道。',
        pinyin: 'Suízhe xīnzhì shēngchǎnlì de jiāsù péiyù, shāngyè hángtiān, dīkōng jīngjì yǐjí lèinǎo rénxíng jīqìrén děng zhànlüè xīnxīng sàidào, zhèngzài chéngwéi gè dà kējì lǐngjūn qǐyè jìngzhú de xīn pǎodào.',
        meaning_vi: 'Cùng với sự tăng tốc vun đắp lực lượng sản xuất chất lượng mới, các đường đua mới nổi chiến lược như hàng không vũ trụ thương mại, kinh tế tầm thấp và robot hình người giống não bộ đang trở thành những đường đua mới mà các doanh nghiệp công nghệ đầu ngành ráo riết cạnh tranh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2815,
    hanzi: '赔',
    pinyin: 'péi',
    word_type: 'Động từ',
    meaning_vi: 'bồi thường, đền bù; thua lỗ',
    examples: [
      {
        chinese: '在超市购物时不慎打碎了玻璃杯，应当主动按价赔偿给商家。',
        pinyin: 'Zài chāoshì gòuwù shí búshèn dǎsuì le bōlibēi, yīngdāng zhǔdòng ànjià péicháng gěi shāngjiā.',
        meaning_vi: 'Khi mua sắm trong siêu thị sơ ý làm vỡ cốc thủy tinh, nên chủ động bồi thường theo đúng giá cho cửa hàng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '依据我国合同法与民法典侵权责任编规定，故意违反商业保密协议窃取核心专有技术者，不仅须依法全额赔偿实际经济损失，还须承担惩罚性民事赔偿。',
        pinyin: 'Yījù wǒ guó hétongfǎ yǔ mínfǎdiǎn qīnquán zérèn biān guīdìng, gùyì wéifǎn shāngyè bǎomì xiéyì qièqǔ héxīn zhuānyǒu jìshù zhě, bùjǐn xū yīfǎ quán’é péicháng shíjì jīngjì sǔnshī, hái xū chéngdān chéngfáxìng mínshì péicháng.',
        meaning_vi: 'Căn cứ quy định Luật Hợp đồng và phần Trách nhiệm bồi thường thiệt hại ngoài hợp đồng trong Bộ luật Dân sự nước ta, người cố ý vi phạm thỏa thuận bảo mật thương mại đánh cắp bí quyết công nghệ cốt lõi không chỉ phải bồi thường toàn bộ thiệt hại kinh tế thực tế mà còn phải chịu mức bồi thường dân sự mang tính trừng phạt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2816,
    hanzi: '陪伴',
    pinyin: 'péibàn',
    word_type: 'Động từ',
    meaning_vi: 'bầu bạn, ở bên cạnh, đồng hành',
    examples: [
      {
        chinese: '父母给孩子最好的关爱，莫过于在成长过程中耐心的关怀与温暖的陪伴。',
        pinyin: 'Fùmǔ gěi háizi zuì hǎo de guān’ài, mò guòyú zài chéngzhǎng guòchéng zhōng nàixīn de guānhuái yǔ wēnnuǎn de péibàn.',
        meaning_vi: 'Tình yêu thương tuyệt vời nhất mà cha mẹ dành cho con cái không gì hơn sự chăm sóc kiên nhẫn và sự đồng hành ấm áp trong suốt quá trình trưởng thành.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在推动乡村教育优质均衡发展进程中，成千上万名支教青年教师扎根偏远山区，以无私奉献陪伴留守儿童点亮走出大山的梦想。',
        pinyin: 'Zài tuīdòng xiāngcūn jiàoyù yōuzhì jūnhéng fāzhǎn jìnchéng zhōng, chéngqiān-shàngwàn míng zhījiào qīngnián jiàoshī zhāgēn piānyuǎn shānqū, yǐ wúsī fèngxiàn péibàn liúshǒu értóng diǎnliàng zǒuchū dàshān de mèngxiǎng.',
        meaning_vi: 'Trong tiến trình thúc đẩy giáo dục nông thôn phát triển chất lượng cao và cân bằng, hàng vạn giáo viên trẻ tình nguyện dạy học đã cắm rễ nơi núi non hẻo lánh, bằng sự cống hiến quên mình đồng hành cùng các em nhỏ ở lại thắp sáng ước mơ bước ra khỏi đại ngàn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2817,
    hanzi: '培训',
    pinyin: 'péixùn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'đào tạo, tập huấn',
    examples: [
      {
        chinese: '新员工入职后的第一个月，人事部会组织系统的专业技能与企业文化培训。',
        pinyin: 'Xīn yuángōng rùzhí hòu de dì-yī gè yuè, rénshìbù huì zǔzhī xìtǒng de zhuānyè jìnéng yǔ qǐyè wénhuà péixùn.',
        meaning_vi: 'Trong tháng đầu tiên sau khi nhân viên mới vào công ty, phòng nhân sự sẽ tổ chức các khóa tập huấn kỹ năng chuyên môn và văn hóa doanh nghiệp một cách bài bản.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为加速产业工人队伍知识型、技能型、创新型转型升级，各级工会联合职业院校大力开展工业互联网与工业机器人实操专项技能培训。',
        pinyin: 'Wèi jiāsù chǎnyè gōngrén duìwu zhīshìxíng, jìnéngxíng, chuàngxīnxíng zhuǎnxíng shēngjí, gè jí gōnghuì liánhé zhíyè yuànxiào dàlì kāizhǎn gōngyè hùliánwǎng yǔ gōngyè jīqìrén shícāo zhuānxiàng jìnéng péixùn.',
        meaning_vi: 'Nhằm đẩy nhanh chuyển đổi nâng cấp đội ngũ công nhân công nghiệp theo hướng tri thức, kỹ năng và đổi mới sáng tạo, công đoàn các cấp phối hợp cùng các trường nghề đẩy mạnh tổ chức các đợt tập huấn kỹ năng thực hành chuyên đề về Internet công nghiệp và robot công nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2818,
    hanzi: '培养',
    pinyin: 'péiyǎng',
    word_type: 'Động từ',
    meaning_vi: 'bồi dưỡng, đào tạo, nuôi dưỡng',
    examples: [
      {
        chinese: '学校不仅要传授文化知识，更要注重培养学生独立思考与创新的能力。',
        pinyin: 'Xuéxiào bùjǐn yào chuánshòu wénhuà zhīshi, gèng yào zhùzhòng péiyǎng xuésheng dúlì sīkǎo yǔ chuàngxīn de nénglì.',
        meaning_vi: 'Trường học không chỉ truyền thụ kiến thức văn hóa, mà càng phải coi trọng việc bồi dưỡng năng lực tư duy độc lập và đổi mới sáng tạo cho học sinh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '建设教育强国、科技强国与人才强国，核心在于自主培养一大批具备家国情怀、深厚科学底蕴与全球竞争力的战略科学家及卓越工程师。',
        pinyin: 'Jiànshè jiàoyù qiángguó, kējì qiángguó yǔ réncái qiángguó, héxīn zàiyú zìzhǔ péiyǎng yí dà pī jùbèi jiāguó qínghuái, shēnhòu kēxué dǐyùn yǔ quánqiú jìngzhēnglì de zhànlüè kēxuéjiā jí zhuóyuè gōngchéngshī.',
        meaning_vi: 'Xây dựng cường quốc giáo dục, cường quốc khoa học công nghệ và cường quốc nhân tài, mấu chốt nằm ở chỗ tự chủ đào tạo bồi dưỡng một đội ngũ lớn các nhà khoa học chiến lược và kỹ sư xuất sắc mang nặng tấm lòng vì nước vì dân, nền tảng khoa học sâu sắc và sức cạnh tranh toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2819,
    hanzi: '配',
    pinyin: 'pèi',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'phối hợp, kết hợp, ghép đôi, tương xứng; xứng đôi',
    examples: [
      {
        chinese: '这副新配的近视眼镜度数非常合适，看黑板上的字清晰多了。',
        pinyin: 'Zhè fù xīn pèi de jìnshì yǎnjìng dùshù fēicháng héshì, kàn hēibǎn shang de zì qīngxī duō le.',
        meaning_vi: 'Chiếc kính cận thị mới cắt này độ kính rất vừa vặn, nhìn chữ trên bảng đen rõ ràng hơn hẳn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在特种高强度复合合金铸造生产线上，各种微量稀土元素的配比精度必须达到微克级严苛标准，才能确保航天结构件优异的耐高温抗疲劳品质。',
        pinyin: 'Zài tèzhǒng gāo qiángdù fùhé héjīn zhùzào shēngchǎnxiàn shang, gèzhǒng wēiliàng xītǔ yuánsù de pèibǐ jīngdù bìxū dádào wēikè jí yánkē biāozhǔn, cáinéng quèbǎo hángtiān jiégòujiàn yōuyì de nài gāowēn kàng píláo pǐnzhì.',
        meaning_vi: 'Trên dây chuyền đúc hợp kim composite đặc chủng cường độ cao, độ chính xác trong tỷ lệ phối trộn các nguyên tố đất hiếm vi lượng bắt buộc phải đạt tiêu chuẩn khắt khe ở mức microgram thì mới có thể bảo đảm phẩm chất chịu nhiệt độ cao và kháng mỏi xuất sắc của cấu kiện hàng không.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2820,
    hanzi: '配合',
    pinyin: 'pèihé',
    word_type: 'Động từ',
    meaning_vi: 'phối hợp, ăn ý, cộng tác',
    examples: [
      {
        chinese: '在足球赛中，全队队员密切配合，通过精妙的传球打破了对方的球门。',
        pinyin: 'Zài zúqiúsài zhōng, quán duì duìyuán mìqiè pèihé, tōngguò jīngmiào de chuánqiú dǎpò le duìfāng de qiúmén.',
        meaning_vi: 'Trong trận bóng đá, các cầu thủ toàn đội phối hợp chặt chẽ, thông qua những đường chuyền bóng tinh tế đã xuyên thủng khung thành đối phương.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在应对全球跨境金融洗钱犯罪中，央行与司法监管机关密切配合，构建起跨机构穿透式资金流向实时监测网络。',
        pinyin: 'Zài yìngduì quánqiú kuàjìng jīnróng xǐqián fànzuì zhōng, yāngháng yǔ sīfǎ jiānguǎn jīguān mìqiè pèihé, gòujiàn qǐ kuà jīgòu chuāntòushì zījīn liúxiàng shíshí jiāncè wǎngluò.',
        meaning_vi: 'Trong việc ứng phó với tội phạm rửa tiền tài chính xuyên biên giới toàn cầu, Ngân hàng Trung ương cùng cơ quan giám sát tư pháp phối hợp chặt chẽ, xây dựng mạng lưới giám sát thời gian thực dòng tiền có tính xuyên thấu liên cơ quan.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2821,
    hanzi: '配送',
    pinyin: 'pèisòng',
    word_type: 'Động từ',
    meaning_vi: 'giao hàng, phân phối hàng hóa, điều chuyển hàng',
    examples: [
      {
        chinese: '现代快递物流十分高效，同城网购生鲜商品当天就可以完成配送。',
        pinyin: 'Xiàndài kuàidì wùliú shífēn gāoxiào, tóngchéng wǎnggòu shēngxiān shāngpǐn dàngtiān jiù kěyǐ wánchéng pèisòng.',
        meaning_vi: 'Hậu cần chuyển phát nhanh hiện đại rất hiệu quả, mua sắm thực phẩm tươi sống qua mạng cùng thành phố có thể hoàn thành giao hàng ngay trong ngày.',
        difficulty_level: 'basic'
      },
      {
        chinese: '依托无人机集群与无人驾驶物流车协同作业，偏远海岛与高山村落实现了冷链医药与生活急需物资的常态化精准高效配送。',
        pinyin: 'Yītuō wúrénjī jíqún yǔ wúrén jiàshǐ wùliúchē xiétóng zuòyè, piānyuǎn hǎidǎo yǔ gāoshān cūnluò shíxiàn le lěngliàn yīyào yǔ shēnghuó jíxū wùzī de chángtàihuà jīngzhǔn gāoxiào pèisòng.',
        meaning_vi: 'Dựa vào sự phối hợp tác nghiệp giữa đàn flycam và xe hậu cần tự hành, các hải đảo xa xôi cùng thôn bản vùng núi cao đã hiện thực hóa việc phân phối định kỳ chuẩn xác và hiệu quả cao đối với dược phẩm chuỗi lạnh và vật tư thiết yếu đời sống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2822,
    hanzi: '盆',
    pinyin: 'pén',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'cái chậu, cái bồn; chậu (lượng từ)',
    examples: [
      {
        chinese: '书房窗台上摆放着一盆生机盎然的君子兰，给房间增添了不少清雅之气。',
        pinyin: 'Shūfáng chuāngtái shang bǎifàng zhe yì pén shēngjī-àngrán de jūnzǐlán, gěi fángjiān zēngtiān le bù shǎo qīngyǎ zhī qì.',
        meaning_vi: 'Trên bậu cửa sổ phòng đọc sách bày một chậu lan quân tử xanh tươi tràn trề sức sống, mang lại cho căn phòng không ít vẻ thanh nhã.',
        difficulty_level: 'basic'
      },
      {
        chinese: '地质科考队员在塔里木大型含油气构造盆地深层勘探中，成功钻探出埋深超过九千米的特深超深油气高产富集层。',
        pinyin: 'Dìzhì kěkǎo duìyuán zài Tǎlǐmù dàxíng hán yóuqì gòuzào péndì shēncéng kāntàn zhōng, chénggōng zuàntàn chū máishēn chāoguò jiǔqiān mǐ de tèshēn chāoshēn yóuqì gāochǎn fùjí céng.',
        meaning_vi: 'Đội khảo sát địa chất trong đợt thăm dò tầng sâu tại bồn địa kiến tạo chứa dầu khí lớn Tarim đã khoan thành công tới tầng trầm tích dầu khí năng suất cao siêu sâu có độ chôn vùi sâu hơn 9.000 mét.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2823,
    hanzi: '碰',
    pinyin: 'pèng',
    word_type: 'Động từ',
    meaning_vi: 'va chạm, chạm vào, đụng phải',
    examples: [
      {
        chinese: '走路看手机很容易不小心碰到路边的路灯柱子。',
        pinyin: 'Zǒulù kàn shǒujī hěn róngyì bù xiǎoxīn pèng dào lùbiān de lùdēng zhùzi.',
        meaning_vi: 'Vừa đi bộ vừa nhìn điện thoại rất dễ không cẩn thận va phải cột đèn đường bên lề.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在推进全面深化改革的攻坚期，必须敢于啃硬骨头、敢于涉险滩，决不能在触及深层次利益格局调整的核心问题面前不敢碰硬。',
        pinyin: 'Zài tuījìn quánmiàn shēnhuà gǎigé de gōngjiānqī, bìxū gǎnyú kěn yìnggǔtou, gǎnyú shè xiǎntān, jué bùnéng zài chùjí shēncéngcì lìyì géjú tiáozhěng de héxīn wèntí miànqián bù gǎn pèngyìng.',
        meaning_vi: 'Trong giai đoạn then chốt đẩy mạnh cải cách sâu rộng toàn diện, đòi hỏi phải dám gặm xương khó, dám lội bãi cạn nguy hiểm, tuyệt đối không được chùn bước không dám va chạm trước các vấn đề cốt lõi đụng chạm tới việc điều chỉnh cục diện lợi ích tầng sâu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2824,
    hanzi: '碰见',
    pinyin: 'pèngjiàn',
    word_type: 'Động từ',
    meaning_vi: 'tình cờ gặp, đụng mặt, bắt gặp',
    examples: [
      {
        chinese: '昨天在市中心商业街散步时，我偶然碰见了好多年没联系的高中同桌。',
        pinyin: 'Zuótiān zài shì zhōngxīn shāngyèjiē sànbù shí, wǒ ǒurán pèngjiàn le hǎo duō nián méi liánxì de gāozhōng tóngzhuō.',
        meaning_vi: 'Hôm qua khi đi dạo trên phố thương mại trung tâm thành phố, tôi tình cờ đụng mặt người bạn cùng bàn cấp ba đã bao năm mất liên lạc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在重大工程技术攻关进程中，研发团队时常会碰见前所未有的极限物理参数瓶颈，这正是倒逼原始理论创新的关键契机。',
        pinyin: 'Zài zhòngdà gōngchéng jìshù gōngjiān jìnchéng zhōng, yánfā tuánduì shícháng huì pèngjiàn qiánsuǒwèiyǒu de jíxiàn wùlǐ cānshù píngjǐng, zhè zhèngshì dàobī yuánshǐ lǐlùn chuàngxīn de guānjiàn qìjī.',
        meaning_vi: 'Trong tiến trình đột phá công nghệ kỹ thuật công trình trọng đại, đội ngũ nghiên cứu phát triển thường xuyên bắt gặp những điểm nghẽn thông số vật lý cực hạn chưa từng có, đây chính là cơ duyên then chốt thúc ép đổi mới lý luận nguyên bản.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2825,
    hanzi: '批',
    pinyin: 'pī',
    word_type: 'Lượng từ',
    meaning_vi: 'mẻ, đợt, lô, chuyến (lượng từ cho hàng hóa, số lượng người)',
    examples: [
      {
        chinese: '第一批经过严格检验的优质有机苹果即将打包发往全国各地超市。',
        pinyin: 'Dì-yī pī jīngguò yángé jiǎnyàn de yōuzhì yǒujī píngguǒ jíjiāng dǎbāo fāwǎng quánguó gèdì chāoshì.',
        meaning_vi: 'Lô táo hữu cơ hảo hạng đầu tiên trải qua kiểm định nghiêm ngặt sắp được đóng gói chuyển tới các siêu thị khắp các vùng miền toàn quốc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家统筹选派的一大批具备丰富实战经验的高校科研专家与青年技术骨干，陆续深入中西部欠发达地区开展长期定点科技对口支援。',
        pinyin: 'Guójiā tǒngchóu xuǎnpài de yí dà pī jùbèi fēngfù shízhàn jīngyàn de gāoxiào kēyán zhuānjiā yǔ qīngnián jìshù gǔgàn, lùxù shēnrù zhōng-xībù qiànfādá dìqū kāizhǎn chángqī dìngdiǎn kējì duìkǒu zhīyuán.',
        meaning_vi: 'Một lực lượng đông đảo các chuyên gia nghiên cứu khoa học trường đại học và cán bộ kỹ thuật trẻ giàu kinh nghiệm thực chiến do nhà nước quy hoạch tuyển chọn đã lần lượt sâu sát về các vùng kém phát triển miền Trung và miền Tây để thực hiện chi viện đối ứng khoa học công nghệ dài hạn theo địa chỉ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2826,
    hanzi: '批',
    pinyin: 'pī',
    word_type: 'Động từ',
    meaning_vi: 'phê chuẩn, phê duyệt; phê bình, chỉ trích, phê phán',
    examples: [
      {
        chinese: '教务处领导在认真审查后，正式在小李的出国留学申请书上批复同意。',
        pinyin: 'Jiàowùchù lǐngdǎo zài rènzhēn shěnchá hòu, zhèngshì zài Xiǎo Lǐ de chūguó liúxué shēnqǐngshū shang pīfù tóngyì.',
        meaning_vi: 'Lãnh đạo phòng đào tạo sau khi thẩm tra kỹ lưỡng đã chính thức phê chuẩn đồng ý trên lá đơn xin đi du học nước ngoài của Tiểu Lý.',
        difficulty_level: 'basic'
      },
      {
        chinese: '有关职能监管部门对个别上市公司虚构财务数据并恶意操纵股票交易价格的行为给予公开通报严厉批评，并依法实施巨额惩罚。',
        pinyin: 'Yǒuguān zhíngnéng jiānguǎn bùmén duì gèbié shàngshì gōngsī xūgòu cáiwù shùjù bìng èyì cāozòng gǔpiào jiāoyì jiàgé de xíngwéi jǐyǔ gōngkāi tōngbào yánlì pīpíng, bìng yīfǎ shíshī jù’é chéngfá.',
        meaning_vi: 'Cơ quan giám sát chức năng hữu quan đã thông báo công khai phê bình nghiêm khắc đối với hành vi ngụy tạo số liệu tài chính và thao túng giá giao dịch cổ phiếu một cách ác ý của một số công ty niêm yết, đồng thời xử phạt số tiền khổng lồ theo pháp luật.',
        difficulty_level: 'applied'
      }
    ]
  }
]
