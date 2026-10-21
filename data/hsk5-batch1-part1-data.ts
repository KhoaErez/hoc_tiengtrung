// ====================================================================
// HSK 5 - BATCH 1 - PART 1: 25 TỪ VỰNG (#2001 -> #2025)
// Chuẩn Đề cương HSK 3.0 CTI chính thức
// ====================================================================

export interface Hsk5ExampleItem {
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

export const HSK5_BATCH1_PART1: Hsk5ExampleItem[] = [
  {
    hanzi: '哎',
    pinyin: 'āi',
    word_type: 'Thán từ',
    meaning_vi: 'này, này bạn (thán từ dùng để gọi hoặc nhắc nhở)',
    examples: [
      {
        chinese: '哎，你把钱包掉在地上了！',
        pinyin: 'Āi, nǐ bǎ qiánbāo diào zài dì shang le!',
        meaning_vi: 'Này, bạn làm rơi ví tiền xuống đất rồi kìa!',
        difficulty_level: 'basic'
      },
      {
        chinese: '哎，李经理，刚才王总打电话找你商量合同的事。',
        pinyin: 'Āi, Lǐ jīnglǐ, gāngcái Wáng zǒng dǎ diànhuà zhǎo nǐ shāngliang hétong de shì.',
        meaning_vi: 'Này, quản lý Lý ơi, vừa nãy tổng giám đốc Vương gọi điện tìm anh để bàn chuyện hợp đồng đấy.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '哎呀',
    pinyin: 'āiyā',
    word_type: 'Thán từ',
    meaning_vi: 'ối chao, trời ơi (thán từ biểu thị ngạc nhiên, hối tiếc hoặc kêu đau)',
    examples: [
      {
        chinese: '哎呀，我出门忘记带钥匙了。',
        pinyin: 'Āiyā, wǒ chūmén wàngjì dài yàoshi le.',
        meaning_vi: 'Ối chao, tôi ra khỏi nhà quên mang theo chìa khóa rồi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '哎呀，这趟高铁马上要开了，我们得赶紧检票上车。',
        pinyin: 'Āiyā, zhè tàng gāotiě mǎshàng yào kāi le, wǒmen děi gǎnjǐn jiǎnpiào shàngchē.',
        meaning_vi: 'Trời ơi, chuyến tàu cao tốc này sắp chạy rồi, chúng ta phải mau chóng soát vé lên tàu thôi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '唉',
    pinyin: 'ài',
    word_type: 'Thán từ',
    meaning_vi: 'chao ôi, than ôi (thở dài biểu thị buồn bã, bất lực hoặc đồng ý)',
    examples: [
      {
        chinese: '唉，这次考试我又粗心做错了一道题。',
        pinyin: 'Ài, zhè cì kǎoshì wǒ yòu cūxīn zuò cuò le yí dào tí.',
        meaning_vi: 'Than ôi, lần thi này tôi lại bất cẩn làm sai mất một câu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '“你能帮我把这份材料打印一下吗？”“唉，好的，我马上办。”',
        pinyin: '“Nǐ néng bāng wǒ bǎ zhè fèn cáiliào dǎyìn yíxià ma?” “Ài, hǎode, wǒ mǎshàng bàn.”',
        meaning_vi: '“Bạn có thể in giúp tôi tập tài liệu này không?” “Dạ vâng, được chứ, tôi làm ngay đây.”',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '爱护',
    pinyin: 'àihù',
    word_type: 'Động từ',
    meaning_vi: 'yêu quý và bảo vệ, giữ gìn (đồ vật, của công, môi trường)',
    examples: [
      {
        chinese: '我们每个人都应该爱护校园里的花草树木。',
        pinyin: 'Wǒmen měi gè rén dōu yīnggāi àihù xiàoyuán lǐ de huācǎo shùmù.',
        meaning_vi: 'Mỗi người chúng ta đều nên bảo vệ cỏ cây hoa lá trong khuôn viên trường học.',
        difficulty_level: 'basic'
      },
      {
        chinese: '公司提倡员工爱护办公设备，养成节约用电的良好习惯。',
        pinyin: 'Gōngsī tíchàng yuángōng àihù bàngōng shèbèi, yǎngchéng jiéyuē yòngdiàn de liánghǎo xíguàn.',
        meaning_vi: 'Công ty kêu gọi nhân viên giữ gìn thiết bị văn phòng, hình thành thói quen tốt tiết kiệm điện.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '安',
    pinyin: 'ān',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'lắp đặt; an lòng, bình an',
    examples: [
      {
        chinese: '工人们正在为新教室安窗帘和电风扇。',
        pinyin: 'Gōngrénmen zhèngzài wèi xīn jiàoshì ān chuānglián hé diànfēngshàn.',
        meaning_vi: 'Các công nhân đang lắp rèm cửa và quạt điện cho lớp học mới.',
        difficulty_level: 'basic'
      },
      {
        chinese: '得知手术非常成功，大家都放下心来，心里十分安稳。',
        pinyin: 'Dézhī shǒushù fēicháng chénggōng, dàjiā dōu fàngxià xīn lái, xīnlǐ shífēn ānwěn.',
        meaning_vi: 'Biết tin ca phẫu thuật vô cùng thành công, mọi người đều thở phào nhẹ nhõm, lòng dạ vô cùng bình an.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '安全带',
    pinyin: 'ānquándài',
    word_type: 'Danh từ',
    meaning_vi: 'dây an toàn (trên ô tô, máy bay)',
    examples: [
      {
        chinese: '上车后请第一时间系好安全带。',
        pinyin: 'Shàngchē hòu qǐng dì-yī shíjiān jì hǎo ānquándài.',
        meaning_vi: 'Sau khi lên xe xin vui lòng thắt dây an toàn trước tiên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '飞机遇到强气流发生颠簸时，乘客必须坐在座位上并系紧安全带。',
        pinyin: 'Fēijī yùdào qiáng qìliú fāshēng diānbǒ shí, chéngkè bìxū zuò zài zuòwèi shàng bìng jì jǐn ānquándài.',
        meaning_vi: 'Khi máy bay gặp luồng không khí mạnh bị rung lắc, hành khách bắt buộc phải ngồi tại chỗ và thắt chặt dây an toàn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '安慰',
    pinyin: 'ānwèi',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'an ủi, vỗ về; cảm thấy ấm lòng, thanh thản',
    examples: [
      {
        chinese: '看到朋友伤心落泪，他轻声安慰了她很久。',
        pinyin: 'Kàndào péngyou shāngxīn luòlèi, tā qīngshēng ānwèi le tā hěn jiǔ.',
        meaning_vi: 'Thấy bạn đau lòng rơi lệ, anh ấy đã nhẹ nhàng an ủi cô ấy một hồi lâu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '看到孩子们都健康成长而且事业有成，父母感到莫大的安慰。',
        pinyin: 'Kàndào háizimen dōu jiànkāng chéngzhǎng érqiě shìyè yǒuchéng, fùmǔ gǎndào mòdà de ānwèi.',
        meaning_vi: 'Nhìn thấy các con đều khôn lớn khỏe mạnh lại thành đạt trong sự nghiệp, cha mẹ cảm thấy vô cùng an lòng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '安装',
    pinyin: 'ānzhuāng',
    word_type: 'Động từ',
    meaning_vi: 'lắp đặt (thiết bị), cài đặt (phần mềm máy tính/điện thoại)',
    examples: [
      {
        chinese: '技术员正在我的电脑上安装最新的杀毒软件。',
        pinyin: 'Jìshùyuán zhèngzài wǒ de diànnǎo shàng ānzhuāng zuìxīn de shādú ruǎnjiàn.',
        meaning_vi: 'Kỹ thuật viên đang cài đặt phần mềm diệt virus mới nhất trên máy tính của tôi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为了提高生产效率，工厂下个月将安装两套自动化流水线。',
        pinyin: 'Wèile tígāo shēngchǎn xiàolǜ, gōngchǎng xià gè yuè jiāng ānzhuāng liǎng tào zìdònghuà liúshuǐxiàn.',
        meaning_vi: 'Để nâng cao năng suất sản xuất, tháng tới nhà máy sẽ lắp đặt hai dây chuyền tự động hóa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '暗',
    pinyin: 'àn',
    word_type: 'Tính từ',
    meaning_vi: 'tối, mờ, u ám (ánh sáng); ngầm, bí mật',
    examples: [
      {
        chinese: '屋里光线太暗了，把灯打开吧。',
        pinyin: 'Wū lǐ guāngxiàn tài àn le, bǎ dēng dǎkāi ba.',
        meaning_vi: 'Ánh sáng trong phòng tối quá, bật đèn lên đi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '他在心里暗暗下定决心，一定要在年底前完成这个具有挑战性的项目。',
        pinyin: 'Tā zài xīnlǐ àn’àn xiàdìng juéxīn, yídìng yào zài niándǐ qián wánchéng zhè gè jùyǒu tiǎozhànxìng de xiàngmù.',
        meaning_vi: 'Anh ấy thầm hạ quyết tâm trong lòng, nhất định phải hoàn thành dự án đầy thách thức này trước cuối năm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '熬夜',
    pinyin: 'áoyè',
    word_type: 'Động từ',
    meaning_vi: 'thức khuya, thức đêm',
    examples: [
      {
        chinese: '经常熬夜对身体健康有很大的害处。',
        pinyin: 'Jīngcháng áoyè duì shēntǐ jiànkāng yǒu hěn dà de hàichù.',
        meaning_vi: 'Thường xuyên thức khuya có tác hại rất lớn đối với sức khỏe.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为了赶在截止日期前提交设计方案，整个团队连续熬夜加班了好几天。',
        pinyin: 'Wèile gǎn zài jiézhǐ rìqī qián tíjiāo shèjì fāng’àn, zhěnggè tuánduì liánxù áoyè jiābān le hǎo jǐ tiān.',
        meaning_vi: 'Để kịp nộp phương án thiết kế trước thời hạn chót, cả đội ngũ đã thức đêm tăng ca liên tục mấy ngày liền.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '把握',
    pinyin: 'bǎwò',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'nắm chắc, nắm bắt (cơ hội); sự chắc chắn, tự tin thành công',
    examples: [
      {
        chinese: '年轻人要学会主动把握每一个锻炼自己的机会。',
        pinyin: 'Niánqīngrén yào xuéhuì zhǔdòng bǎwò měi yí gè duànliàn zìjǐ de jīhuì.',
        meaning_vi: 'Người trẻ tuổi cần học cách chủ động nắm bắt từng cơ hội rèn luyện bản thân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '对于这次投标能否成功，项目经理表示团队做了充足准备，很有把握。',
        pinyin: 'Duìyú zhè cì tóubiāo néng fǒu chénggōng, xiàngmù jīnglǐ biǎoshì tuánduì zuò le chōngzú zhǔnbèi, hěn yǒu bǎwò.',
        meaning_vi: 'Về việc cuộc đấu thầu lần này có thành công hay không, giám đốc dự án cho biết cả đội đã chuẩn bị đầy đủ và rất có nắm chắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '白',
    pinyin: 'bái',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'trắng; uổng công, công cốc; miễn phí',
    examples: [
      {
        chinese: '冬天的大雪过后，整座城市变成了一片白茫茫的世界。',
        pinyin: 'Dōngtiān de dàxuě guòhòu, zhěng zuò chéngshì biànchéng le yí piàn bái mángmáng de shìjiè.',
        meaning_vi: 'Sau trận tuyết lớn mùa đông, toàn thành phố biến thành một thế giới trắng xóa bạt ngàn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '今天去图书馆才发现闭馆装修，害得我顶着大雨白跑了一趟。',
        pinyin: 'Jīntiān qù túshūguǎn cái fāxiàn bìguǎn zhuāngxiū, hài de wǒ dǐng zhe dàyǔ bái pǎo le yí tàng.',
        meaning_vi: 'Hôm nay đến thư viện mới phát hiện đóng cửa sửa chữa, làm tôi đội mưa to đi một chuyến công cốc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '半夜',
    pinyin: 'bànyè',
    word_type: 'Danh từ',
    meaning_vi: 'nửa đêm, đêm khuya',
    examples: [
      {
        chinese: '半夜突然下起大雨，雷声把熟睡的孩子惊醒了。',
        pinyin: 'Bànyè tūrán xià qǐ dàyǔ, léishēng bǎ shúshuì de háizi jīngxǐng le.',
        meaning_vi: 'Nửa đêm trời bỗng đổ mưa lớn, tiếng sấm làm đứa trẻ đang ngủ say giật mình tỉnh giấc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '急诊科医生经常半夜接到紧急通知赶回医院参与抢救手术。',
        pinyin: 'Jízhěnkē yīshēng jīngcháng bànyè jiēdào jǐnjí tōngzhī gǎnhuí yīyuàn cānyù qiǎngjiù shǒushù.',
        meaning_vi: 'Bác sĩ khoa cấp cứu thường nhận được thông báo khẩn lúc nửa đêm để lập tức chạy về bệnh viện tham gia ca mổ cấp cứu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '傍晚',
    pinyin: 'bàngwǎn',
    word_type: 'Danh từ',
    meaning_vi: 'hoàng hôn, chập tối, lúc sẩm tối',
    examples: [
      {
        chinese: '傍晚时分，公园里有很多散步和跳广场舞的人。',
        pinyin: 'Bàngwǎn shífēn, gōngyuán lǐ yǒu hěn duō sànbù hé tiào guǎngchǎngwǔ de rén.',
        meaning_vi: 'Lúc chập tối, trong công viên có rất nhiều người đi dạo và nhảy múa quảng trường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '我们坐在海滩边的咖啡馆里，静静欣赏傍晚落日映红天边的壮丽美景。',
        pinyin: 'Wǒmen zuò zài hǎitān biān de kāfēiguǎn lǐ, jìngjìng xīnshǎng bàngwǎn luòrì yìng hóng tiānbiān de zhuànglì měijǐng.',
        meaning_vi: 'Chúng tôi ngồi trong quán cà phê ven bãi biển, tĩnh lặng ngắm nhìn cảnh tượng hoàng hôn tuyệt đẹp rực đỏ cả góc trời.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '包裹',
    pinyin: 'bāoguǒ',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'bưu kiện, gói hàng; bao bọc, bọc kín',
    examples: [
      {
        chinese: '快递员刚把老家寄来的包裹送到门口。',
        pinyin: 'Kuàidìyuán gāng bǎ lǎojiā jì lái de bāoguǒ sòng dào ménkǒu.',
        meaning_vi: 'Nhân viên chuyển phát nhanh vừa đưa bưu kiện gửi từ quê nhà đến trước cửa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '易碎物品在邮寄前必须用泡沫塑料仔细包裹好，以免途中受损。',
        pinyin: 'Yìsuǐ wùpǐn zài yóujì qián bìxū yòng pàomò sùliào zǐxì bāoguǒ hǎo, yǐmiǎn túzhōng shòusǔn.',
        meaning_vi: 'Đồ dễ vỡ trước khi gửi bưu điện bắt buộc phải dùng màng xốp bọc thật kỹ càng, tránh bị hư hỏng trên đường đi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '包含',
    pinyin: 'bāohán',
    word_type: 'Động từ',
    meaning_vi: 'chứa đựng, bao hàm (nội dung, ý nghĩa sâu xa, đạo lý)',
    examples: [
      {
        chinese: '这句简短的格言包含了深刻的人生道理。',
        pinyin: 'Zhè jù jiǎnduǎn de géyán bāohán le shēnkè de rénshēng dàolǐ.',
        meaning_vi: 'Câu châm ngôn ngắn gọn này bao hàm đạo lý nhân sinh sâu sắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '本次旅游套餐的报价中已经包含了全程机票、四星级酒店住宿以及早餐费用。',
        pinyin: 'Běn cì lǚyóu tàocān de bàojià zhōng yǐjīng bāohán le quánchéng jīpiào, sì xīngjí jiǔdiàn zhùsù yǐjí zǎocān fèiyòng.',
        meaning_vi: 'Báo giá của gói du lịch lần này đã bao hàm toàn bộ vé máy bay, khách sạn bốn sao và chi phí bữa sáng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '包括',
    pinyin: 'bāokuò',
    word_type: 'Động từ',
    meaning_vi: 'bao gồm (liệt kê danh mục, thành phần người hoặc vật)',
    examples: [
      {
        chinese: '参加这次聚会的一共有十二个人，包括老师和学生。',
        pinyin: 'Cānjiā zhè cì jùhuì de yí gòng yǒu shí’èr gè rén, bāokuò lǎoshī hé xuésheng.',
        meaning_vi: 'Tham gia buổi tụ họp lần này tổng cộng có mười hai người, bao gồm cả thầy giáo và học sinh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '公司福利待遇优厚，包括五险一金、带薪年假以及定期的全员健康体检。',
        pinyin: 'Gōngsī fúlì dàiyù yōuhòu, bāokuò wǔ xiǎn yì jīn, dàixīn niánjià yǐjí dìngqī de quányuán jiànkāng tǐjiǎn.',
        meaning_vi: 'Chế độ đãi ngộ phúc lợi của công ty rất tốt, bao gồm bảo hiểm đầy đủ, nghỉ phép năm hưởng lương và khám sức khỏe định kỳ cho toàn thể nhân viên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '包装',
    pinyin: 'bāozhuāng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'đóng gói; bao bì, bao gói hàng hóa',
    examples: [
      {
        chinese: '这个礼品盒的外包装设计得非常精美。',
        pinyin: 'Zhè gè lǐpǐnhé de wài bāozhuāng shèjì de fēicháng jīngměi.',
        meaning_vi: 'Bao bì bên ngoài của hộp quà tặng này được thiết kế rất tinh xảo đẹp mắt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代企业不仅注重产品内在质量，还十分重视采用环保材料进行产品包装。',
        pinyin: 'Xiàndài qǐyè bùjǐn zhùzhòng chǎnpǐn nèizài zhìliàng, hái shífēn zhòngshì cǎiyòng huánbǎo cáiliào jìnxíng chǎnpǐn bāozhuāng.',
        meaning_vi: 'Doanh nghiệp hiện đại không chỉ chú trọng chất lượng bên trong của sản phẩm mà còn rất coi trọng việc sử dụng vật liệu thân thiện môi trường để đóng gói sản phẩm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '薄',
    pinyin: 'báo',
    word_type: 'Tính từ',
    meaning_vi: 'mỏng (độ dày), mảnh mai; nhạt nhẽo (tình cảm)',
    examples: [
      {
        chinese: '春天天气转暖了，大家换上了薄薄的外套。',
        pinyin: 'Chūntiān tiānqì zhuǎn nuǎn le, dàjiā huàn shàng le báo báo de wàitào.',
        meaning_vi: 'Mùa xuân thời tiết ấm lên rồi, mọi người đều đổi sang mặc áo khoác mỏng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '湖面上的冰层还很薄，严禁行人在上面滑冰走动，以防发生溺水危险。',
        pinyin: 'Húmiàn shàng de bīngcéng hái hěn báo, yánjìn xíngrén zài shàngmiàn huábīng zǒudòng, yǐ fáng fāshēng nìshuǐ wēixiǎn.',
        meaning_vi: 'Lớp băng trên mặt hồ còn rất mỏng, nghiêm cấm người đi bộ trượt băng hay đi lại bên trên nhằm phòng ngừa nguy hiểm đuối nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '宝',
    pinyin: 'bǎo',
    word_type: 'Danh từ',
    meaning_vi: 'bảo vật, báu vật, điều trân quý',
    examples: [
      {
        chinese: '在老人心里，活泼可爱的孙子就是全家的宝。',
        pinyin: 'Zài lǎorén xīnlǐ, huópō kě’ài de sūnzi jiù shì quánjiā de bǎo.',
        meaning_vi: 'Trong lòng người già, đứa cháu nội hoạt bát đáng yêu chính là báu vật của cả gia đình.',
        difficulty_level: 'basic'
      },
      {
        chinese: '经过多年的刻苦钻研，这位老中医积累了一套被称为“镇院之宝”的独特针灸疗法。',
        pinyin: 'Jīngguò duō nián de kèkǔ zuānyán, zhè wèi lǎo zhōngyī jīlěi le yí tào bèi chēng wèi “zhèn yuàn zhī bǎo” de dútè zhēnjiǔ liáofǎ.',
        meaning_vi: 'Qua nhiều năm miệt mài nghiên cứu, vị bác sĩ đông y lão thành này đã tích lũy được liệu pháp châm cứu độc đáo được mệnh danh là “báu vật trấn viện”.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '保',
    pinyin: 'bǎo',
    word_type: 'Động từ',
    meaning_vi: 'bảo đảm, giữ gìn, bảo vệ',
    examples: [
      {
        chinese: '工厂既要抓紧时间赶进度，又要严格保质量。',
        pinyin: 'Gōngchǎng jì yào zhuājǐn shíjiān gǎn jìndù, yòu yào yángé bǎo zhìliàng.',
        meaning_vi: 'Nhà máy vừa phải tranh thủ thời gian đẩy nhanh tiến độ, lại vừa phải giữ nghiêm chất lượng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面临复杂多变的市场环境，企业首要的任务是保稳定、促发展。',
        pinyin: 'Miànlín fùzá duōbiàn de shìchǎng huánjìng, qǐyè shǒuyào de rènwu shì bǎo wěndìng, cù fāzhǎn.',
        meaning_vi: 'Đối mặt với môi trường thị trường biến động phức tạp, nhiệm vụ hàng đầu của doanh nghiệp là giữ vững ổn định và thúc đẩy phát triển.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '保安',
    pinyin: 'bǎo’ān',
    word_type: 'Danh từ',
    meaning_vi: 'bảo vệ, nhân viên an ninh',
    examples: [
      {
        chinese: '小区的保安师傅工作非常认真负责。',
        pinyin: 'Xiǎoqū de bǎo’ān shīfu gōngzuò fēicháng rènzhēn fùzé.',
        meaning_vi: 'Bác bảo vệ khu chung cư làm việc rất tận tâm và có trách nhiệm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '进入写字楼前，所有访客都必须在保安处出示有效证件并办理登记手续。',
        pinyin: 'Jìnrù xiězìlóu qián, suǒyǒu fǎngkè dōu bìxū zài bǎo’ān chù chūshì yǒuxiào zhèngjiàn bìng bànlǐ dēngjì shǒuxù.',
        meaning_vi: 'Trước khi vào tòa nhà văn phòng, mọi khách đến thăm đều bắt buộc phải xuất trình giấy tờ tùy thân hợp lệ tại quầy an ninh và làm thủ tục đăng ký.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '宝贝',
    pinyin: 'bǎobèi',
    word_type: 'Danh từ',
    meaning_vi: 'bảo bối, bảo vật; cục cưng (gọi con nhỏ hoặc người thân yêu)',
    examples: [
      {
        chinese: '妈妈轻轻吻了吻熟睡中的小宝贝。',
        pinyin: 'Māma qīngqīng wěn le wěn shúshuì zhōng de xiǎo bǎobèi.',
        meaning_vi: 'Người mẹ nhẹ nhàng hôn lên trán đứa con bé bỏng đáng yêu đang ngủ say.',
        difficulty_level: 'basic'
      },
      {
        chinese: '这块祖传的美玉是爷爷珍藏了一辈子的宝贝，从不轻易拿出来示人。',
        pinyin: 'Zhè kuài zǔchuán de měiyù shì yéye zhēncáng le yí bèizi de bǎobèi, cóngbù qīngyì ná chūlái shì rén.',
        meaning_vi: 'Miếng ngọc quý gia truyền này là báu vật mà ông nội đã trân quý giữ gìn suốt cả cuộc đời, không bao giờ tùy tiện mang ra khoe ai.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '保持',
    pinyin: 'bǎochí',
    word_type: 'Động từ',
    meaning_vi: 'duy trì, giữ vững (trạng thái, thói quen, cự ly, mối liên hệ)',
    examples: [
      {
        chinese: '阅览室内请保持安静，不要大声喧哗。',
        pinyin: 'Yuèlǎnshì nèi qǐng bǎochí ānjìng, bú yào dàshēng xuānhuá.',
        meaning_vi: 'Trong phòng đọc sách xin vui lòng giữ im lặng, không làm ồn lớn tiếng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在高速公路上驾驶车辆时，驾驶员必须时刻与前车保持足够的安全车距。',
        pinyin: 'Zài gāosù gōnglù shàng jiàshǐ chēliàng shí, jiàshǐyuán bìxū shíkè yǔ qiánchē bǎochí zúgòu de ānquán chējù.',
        meaning_vi: 'Khi lái xe trên đường cao tốc, tài xế phải luôn duy trì cự ly an toàn vừa đủ với xe phía trước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    hanzi: '保存',
    pinyin: 'bǎocún',
    word_type: 'Động từ',
    meaning_vi: 'lưu lại, bảo quản, lưu trữ (tập tin máy tính, hiện vật, đồ dùng)',
    examples: [
      {
        chinese: '写完文章后，千万别忘了点击保存按钮。',
        pinyin: 'Xiě wán wénzhāng hòu, qiānwàn bié wàng le diǎnjī bǎocún ànniǔ.',
        meaning_vi: 'Sau khi viết xong bài văn, nhất định đừng quên bấm nút lưu lại nhé.',
        difficulty_level: 'basic'
      },
      {
        chinese: '珍贵的历史文物需要在恒温恒湿的专业库房中妥善保存，防止氧化损坏。',
        pinyin: 'Zhēnguì de lìshǐ wénwù xūyào zài héngwēn héngshī de zhuānyè kùfáng zhōng tuǒshàn bǎocún, fángzhǐ yǎnghuà sǔnhuài.',
        meaning_vi: 'Di vật lịch sử quý giá cần được bảo quản chu đáo trong kho chuyên dụng có nhiệt độ và độ ẩm không đổi để ngăn chặn hư hỏng do oxy hóa.',
        difficulty_level: 'applied'
      }
    ]
  }
]
