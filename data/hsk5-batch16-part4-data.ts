// data/hsk5-batch16-part4-data.ts
// 24 từ HSK 5: #3577 [字母] -> #3600 [作出] (VỀ ĐÍCH HOÀN TẤT HSK 5!)

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

export const HSK5_BATCH16_PART4: VocabItem[] = [
  {
    id: 3577,
    hanzi: '字母',
    pinyin: 'zìmǔ',
    word_type: 'Danh từ',
    meaning_vi: 'chữ cái, mẫu tự',
    examples: [
      {
        chinese: '初学汉语拼音的孩子们，首先需要熟练掌握声母和韵母的每一个汉语拼音字母发音。',
        pinyin: 'Chūxué Hànyǔ pīnyīn de háizimen, shǒuxiān xūyào shúliàn zhǎngwò shēngmǔ hé yùnmǔ de měi yí ge Hànyǔ pīnyīn zìmǔ fāyīn.',
        meaning_vi: 'Những đứa trẻ mới bắt đầu học phiên âm chữ Hán trước tiên cần nắm vững thành thạo cách phát âm của từng chữ cái thanh mẫu và vận mẫu trong phiên âm tiếng Hán.',
        difficulty_level: 'basic'
      },
      {
        chinese: '银行核心数据库安全审计规范强制要求用户账户密码必须包含大写字母、小写字母、数字及特殊符号的复杂组合。',
        pinyin: 'Yínháng héxīn shùjùkù ānquán shěnjì guīfàn qiángzhì yāoqiú yònghù zhànghù mìmǎ bìxū bāohán dàxiě zìmǔ, xiǎoxiě zìmǔ, shùzì jí tèshū fúhào de fùzá zǔhé.',
        meaning_vi: 'Quy chuẩn kiểm toán an toàn cơ sở dữ liệu cốt lõi ngân hàng bắt buộc yêu cầu mật khẩu tài khoản người dùng phải bao gồm tổ hợp phức tạp của chữ cái in hoa, chữ cái in thường, chữ số và các ký tự đặc biệt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3578,
    hanzi: '自身',
    pinyin: 'zìshēn',
    word_type: 'Danh từ',
    meaning_vi: 'bản thân, chính mình, nội tại',
    examples: [
      {
        chinese: '在激烈的职场竞争中，一个人只有不断提升自身的核心业务能力，才能赢得长远的发展空间。',
        pinyin: 'Zài jīliè de zhíchǎng jìngzhēng zhōng, yí ge rén zhǐyǒu búduàn tíshēng zìshēn de héxīn yèwù nénglì, cáinéng yíngdé chángyuǎn de fāzhǎn kōngjiān.',
        meaning_vi: 'Trong cuộc cạnh tranh công sở khốc liệt, một con người chỉ khi không ngừng nâng cao năng lực nghiệp vụ cốt lõi của bản thân thì mới có thể giành được không gian phát triển lâu dài.',
        difficulty_level: 'basic'
      },
      {
        chinese: '跨国金融机构必须依托自身健全的合规管理体系与充足的资本缓冲，从容抵御来自全球地缘冲突与汇率剧烈波动的系统性外部冲击。',
        pinyin: 'Kuàguó jīnróng jīgòu bìxū yītuō zìshēn jiànquán de hégūi guǎnlǐ tǐxì yǔ chōngzú de zīběn huǎnchōng, cóngróng dǐyù láizì quánqiú dìyuán chōngtū yǔ huìlǜ jùliè bōdòng de xìtǒngxìng wàibù chōngjī.',
        meaning_vi: 'Các tổ chức tài chính xuyên quốc gia bắt buộc phải dựa vào hệ thống quản lý tuân thủ hoàn thiện và lớp đệm vốn dồi dào của bản thân để bình tĩnh chống đỡ các cú sốc hệ thống bên ngoài đến từ xung đột địa chính trị toàn cầu và sự biến động tỷ giá hối đoái dữ dội.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3579,
    hanzi: '自由',
    pinyin: 'zìyóu',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'tự do',
    examples: [
      {
        chinese: '周末做完功课之后，孩子们在开阔的绿草地上自由自在地奔跑玩耍、放风筝。',
        pinyin: 'Zhōumò zuò wán gōngkè zhīhòu, háizimen zài kāikuò de lǜ cǎodì shang zìyóu-zìzài de bēnpǎo wánshuǎ, fàng fēngzheng.',
        meaning_vi: 'Cuối tuần sau khi làm xong bài tập, các em nhỏ tự do tự tại chạy nhảy vui đùa thả diều trên thảm cỏ xanh rộng mở.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高标准国际自由贸易试验区持续对标国际高水平经贸规则，稳步推进投资贸易自由化便利化与跨国数据安全有序跨境流动。',
        pinyin: 'Gāobiāozhǔn guójì zìyóu màoyì shìyànqū chíxù duìbiāo guójì gāoshuǐpíng jīng-mào guīzé, wěnbù tuījìn tóuzī màoyì zìyóuhuà biànlìhuà yǔ kuàguó shùjù ānquán yǒuxù kuàjìng liúdòng.',
        meaning_vi: 'Khu thí điểm thương mại tự do quốc tế tiêu chuẩn cao liên tục đối chuẩn với các quy tắc kinh tế thương mại trình độ cao quốc tế, đẩy mạnh vững chắc việc tự do hóa và thuận lợi hóa đầu tư thương mại cùng dòng dữ liệu xuyên quốc gia luân chuyển qua biên giới an toàn có trật tự.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3580,
    hanzi: '综合',
    pinyin: 'zōnghé',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'tổng hợp',
    examples: [
      {
        chinese: '这所综合性大学不仅拥有雄厚的文理工商学科实力，还设立了高水平的附属教学医院。',
        pinyin: 'Zhè suǒ zōnghéxìng dàxué bù jǐn yōngyǒu xiónghòu de wén-lǐ-gōng-shāng xuékē shílì, hái shèlì le gāoshuǐpíng de fùshǔ jiàoxué yīyuàn.',
        meaning_vi: 'Trường đại học tổng hợp này không chỉ sở hữu tiềm lực học thuật hùng hậu về các ngành văn khoa, tự nhiên, kỹ thuật và thương mại, mà còn thành lập bệnh viện thực hành giảng dạy trực thuộc trình độ cao.',
        difficulty_level: 'basic'
      },
      {
        chinese: '宏观经济运行综合监测预警系统基于海量产业运行指标与高频物流用电数据，为国家精准制定逆周期宏观调控政策提供科学依据。',
        pinyin: 'Hóngguān jīngjì yùnxíng zōnghé jiāncè yùjǐng xìtǒng jīyú hǎiliàng chǎnyè yùnxíng zhǐbiāo yǔ gāopín wùliú yòngdiàn shùjù, wèi guójiā jīngzhǔn zhìdìng nì-zhōuqī hóngguān tiáokòng zhèngcè tígōng kēxué yījù.',
        meaning_vi: 'Hệ thống cảnh báo sớm và giám sát tổng hợp vận hành kinh tế vĩ mô dựa trên khối lượng lớn các chỉ số vận hành công nghiệp và dữ liệu điện năng logistics tần suất cao, cung cấp căn cứ khoa học cho nhà nước định ra chuẩn xác chính sách điều tiết vĩ mô ngược chu kỳ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3581,
    hanzi: '总部',
    pinyin: 'zǒngbù',
    word_type: 'Danh từ',
    meaning_vi: 'trụ sở chính, tổng bộ',
    examples: [
      {
        chinese: '这家跨国互联网科技公司的全球总部坐落在市中心繁华的高新技术软件产业园区内。',
        pinyin: 'Zhè jiā kuàguó hùliánwǎng kējì gōngsī de quánqiú zǒngbù zuòluò zài shìzhōngxīn fánhuá de gāoxīn-jìshù ruǎnjiàn chǎnyè yuánqū nèi.',
        meaning_vi: 'Trụ sở chính toàn cầu của công ty công nghệ internet xuyên quốc gia này tọa lạc bên trong khu công nghiệp phần mềm công nghệ cao sầm uất ở trung tâm thành phố.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际大都市出台专项财税与人才配套扶持政策，积极吸引跨国财富五百强企业亚太地区综合运营总部与研发创新中心入驻。',
        pinyin: 'Guójì dà-dūshì chūtái zhuānxiàng cái-shuì yǔ réncái pèitào fǔchí zhèngcè, jījí xīyǐn kuàguó Cáifù Wǔbǎi Qiáng qǐyè Yà-Tài dìqū zōnghé yùnyíng zǒngbù yǔ yánfā chuàngxīn zhōngxīn rùzhù.',
        meaning_vi: 'Đại đô thị quốc tế đã ban hành chính sách hỗ trợ ưu đãi tài chính thuế và đồng bộ nhân tài chuyên đề, tích cực thu hút trụ sở vận hành tổng hợp khu vực Châu Á - Thái Bình Dương và trung tâm đổi mới R&D của các doanh nghiệp Fortune 500 đa quốc gia đến định vị.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3582,
    hanzi: '总共',
    pinyin: 'zǒnggòng',
    word_type: 'Phó từ',
    meaning_vi: 'tổng cộng, cả thảy',
    examples: [
      {
        chinese: '收银员核对完购物车里的所有日用品后微笑着说，您买的这些东西总共是一百八十元。',
        pinyin: 'Shōuyínyuán héduì wán gòuwùchē lǐ de suǒyǒu rìyòngpǐn hòu wēixiào zhe shuō, nín mǎi de zhèxiē dōngxi zǒnggòng shì yībǎi bāshí yuán.',
        meaning_vi: 'Nhân viên thu ngân sau khi đối chiếu toàn bộ đồ dùng sinh hoạt trong xe mua sắm đã mỉm cười nói: "Những thứ quý khách mua đây tổng cộng là 180 tệ ạ".',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家重大水利枢纽主体工程耗时八年顺利竣工，项目总共消耗高标号特种抗裂大坝混凝土超过一千二百万立方米。',
        pinyin: 'Guójiā zhòngdà shuǐlì shūniǔ zhǔtǐ gōngchéng hàoshí bā nián shùnlì jùngōng, xiàngmù zǒnggòng xiāohào gāobiāohào tèzhǒng kàngliè dàbà hùnníngtǔ chāoguò yìqiān èrbǎi wàn lìfāngmǐ.',
        meaning_vi: 'Công trình chính của đầu mối thủy lợi trọng đại quốc gia mất 8 năm đã khánh thành thuận lợi, dự án tổng cộng tiêu hao hơn 12 triệu mét khối bê tông mác cao chống nứt đặc chủng cho đập lớn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3583,
    hanzi: '总数',
    pinyin: 'zǒngshù',
    word_type: 'Danh từ',
    meaning_vi: 'tổng số',
    examples: [
      {
        chinese: '教务处统计数据显示，今年报考该大学硕士研究生招生考试的考生总数突破了一万五千人。',
        pinyin: 'Jiàowùchù tǒngjì shùjù xiǎnshì, jīnnián bàokǎo gāi dàxué shuòshì yánjiūshēng zhāoshēng kǎoshì de kǎoshēng zǒngshù tūpò le yíwàn wǔqiān rén.',
        meaning_vi: 'Số liệu thống kê của phòng giáo vụ cho thấy tổng số thí sinh đăng ký dự thi tuyển sinh thạc sĩ của trường đại học đó năm nay đã vượt mốc 15.000 người.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全球有效发明专利授权总数的持续攀升，客观反映了战略科技力量在新一代信息通信与生物制造底层核心专利上的主导地位。',
        pinyin: 'Quánqiú yǒuxiào fāmíng zhuānlì shòuquán zǒngshù de chíxù pānshēng, kèguān fǎnyìng le zhànlüè kējì lìliang zài xīn-yídài xìnxī tōngxìn yǔ shēngwù zhìzào dǐcéng héxīn zhuānlì shang de zhǔdǎo dìwèi.',
        meaning_vi: 'Tổng số bằng độc quyền sáng chế phát minh còn hiệu lực toàn cầu liên tục tăng vọt đã phản ánh khách quan vị thế chủ đạo của lực lượng khoa học công nghệ chiến lược trong các bằng sáng chế cốt lõi tầng dưới về thông tin truyền thông thế hệ mới và sản xuất sinh học.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3584,
    hanzi: '总体',
    pinyin: 'zǒngtǐ',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'tổng thể, toàn cục',
    examples: [
      {
        chinese: '虽然个别章节的语法知识掌握得还不够熟练，但班级同学在期末模拟考试中的总体成绩相当不错。',
        pinyin: 'Suīrán gèbié zhāngjié de yǔfǎ zhīshi zhǎngwò de hái bú gòu shúliàn, dàn bānjí tóngxué zài qīmò mónǐ kǎoshì zhōng de zǒngtǐ chéngjì xiāngdāng búcuò.',
        meaning_vi: 'Tuy rằng kiến thức ngữ pháp của một vài chương nắm bắt còn chưa thật thành thạo, nhưng thành tích tổng thể của học sinh cả lớp trong kỳ thi thử cuối kỳ là khá tốt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中央经济工作会议明确指出当前宏观经济运行总体平稳、稳中有进，必须统筹扩大内需和深化供给侧结构性改革。',
        pinyin: 'Zhōngyāng Jīngjì Gōngzuò Huìyì míngquè zhǐchū dāngqián hóngguān jīngjì yùnxíng zǒngtǐ píngwěn, wěnzhōng-yǒujìn, bìxū tǒngchóu kuòdà nèixū hé shēnhuà gōngjǐcè jiégòuxìng gǎigé.',
        meaning_vi: 'Hội nghị Công tác Kinh tế Trung ương chỉ rõ rằng vận hành kinh tế vĩ mô hiện nay về mặt tổng thể ổn định, trong ổn định có tiến bộ, bắt buộc phải quy hoạch thống nhất mở rộng nội cầu và làm sâu sắc thêm cải cách cơ cấu bên phía cung.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3585,
    hanzi: '总统',
    pinyin: 'zǒngtǒng',
    word_type: 'Danh từ',
    meaning_vi: 'tổng thống',
    examples: [
      {
        chinese: '在友好访问期间，外国总统在总统府大礼堂热情接见了我国文化青年交流代表团全体成员。',
        pinyin: 'Zài yǒuhǎo fǎngwèn qījiān, wàiguó zǒngtǒng zài zǒngtǒngfǔ dà-lǐtáng rèqíng jiējiàn le wǒguó wénhuà qīngnián jiāoliú dàibiǎotuán quántǐ chéngyuán.',
        meaning_vi: 'Trong thời gian chuyến thăm hữu nghị, vị tổng thống nước ngoài đã nhiệt tình tiếp kiến toàn thể thành viên đoàn đại biểu giao lưu thanh niên văn hóa nước ta tại lễ đường lớn của phủ tổng thống.',
        difficulty_level: 'basic'
      },
      {
        chinese: '两国总统举行正式双边战略会谈并共同签署了关于应对气候变化、深化清洁能源与和平利用外层空间合作的联合声明。',
        pinyin: 'Liǎng guó zǒngtǒng jǔxíng zhèngshì shuāngbiān zhànlüè huìtán bìng gòngtóng qiānshǔ le guānyú yìngduì qìhòu biànhuà, shēnhuà qīngjié néngyuán yǔ hépíng lìyòng wàicéng kōngjiān hézuò de liánhé shēngmíng.',
        meaning_vi: 'Tổng thống hai nước đã tổ chức hội đàm chiến lược song phương chính thức và cùng ký tuyên bố chung về việc ứng phó với biến đổi khí hậu, làm sâu sắc thêm hợp tác năng lượng sạch và sử dụng hòa bình không gian vũ trụ ngoài tầng khí quyển.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3586,
    hanzi: '总之',
    pinyin: 'zǒngzhī',
    word_type: 'Liên từ',
    meaning_vi: 'tóm lại, nói tóm lại',
    examples: [
      {
        chinese: '无论是背诵词汇、练习听力还是开口朗读，总之，学好一门外语离不开日积月累的持之以恒。',
        pinyin: 'Wúlùn shì bèisòng cíhuì, liànxí tīnglì háishì kāikǒu lǎngdú, zǒngzhī, xué hǎo yì mén wàiyǔ lí bù kāi rì-jī-yuè-lěi de chízhī-yǐhéng.',
        meaning_vi: 'Bất luận là học thuộc lòng từ vựng, luyện nghe hay mở miệng đọc to, tóm lại, học tốt một ngoại ngữ không thể tách rời sự kiên trì tích lũy ngày qua tháng lại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '总之，唯有坚持以科技自主创新为核心驱动力，加快培育新质生产力，才能在波谲云诡的全球新一轮产业变革中赢得战略主动权。',
        pinyin: 'Zǒngzhī, wéiyǒu jiānchí yǐ kējì zìzhǔ chuàngxīn wéi héxīn qūdònglì, jiākuài péiyù xīnzhì shēngchǎnlì, cáinéng zài bōjué-yúnguǐ de quánqiú xīn-yì-lún chǎnyè biàngé zhōng yíngdé zhànlüè zhǔdòngquán.',
        meaning_vi: 'Nói tóm lại, duy chỉ có kiên trì lấy đổi mới sáng tạo công nghệ tự chủ làm động lực cốt lõi, đẩy nhanh ươm mầm lực lượng sản xuất chất lượng mới thì mới có thể giành quyền chủ động chiến lược trong cuộc biến cách công nghiệp vòng mới biến đổi khôn lường trên toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3587,
    hanzi: '租金',
    pinyin: 'zūjīn',
    word_type: 'Danh từ',
    meaning_vi: 'tiền thuê, tiền thuê nhà',
    examples: [
      {
        chinese: '按照房屋租赁合同的约定，租客应当在每个月五号之前通过手机银行足额支付当月的房屋租金。',
        pinyin: 'Ànzhào fángwū zūlìn hétong de yuēdìng, zūkè yīngdāng zài měi ge yuè wǔ hào zhīqián tōngguò shǒujī yínháng zú\'é zhīfù dāngyuè de fángwū zūjīn.',
        meaning_vi: 'Theo đúng thỏa thuận trong hợp đồng thuê nhà, người thuê trọ nên chuyển khoản trả đủ số tiền thuê nhà tháng đó qua ứng dụng ngân hàng di động trước ngày mùng 5 hàng tháng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高科技产业园区通过财政专项贴息与减免前两年标准厂房租金等一揽子综合扶持举措，大幅降低了硬科技初创企业的早期运营成本。',
        pinyin: 'Gāokējì chǎnyè yuánqū tōngguò cáizhèng zhuānxiàng tiēxī yǔ jiǎnmiǎn qián liǎng nián biāozhǔn chǎngfáng zūjīn děng yìlǎnzǐ zōnghé fǔchí jǔcuò, dàfú jiàngdī le yìng-kējì chūchuàng qǐyè de zǎoqī yùnyíng chéngběn.',
        meaning_vi: 'Khu công nghiệp công nghệ cao thông qua gói biện pháp hỗ trợ tổng hợp như trợ cấp lãi suất tài chính chuyên đề và miễn giảm tiền thuê nhà xưởng tiêu chuẩn trong hai năm đầu, đã hạ giảm rất lớn chi phí vận hành giai đoạn đầu cho các doanh nghiệp khởi nghiệp công nghệ lõi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3588,
    hanzi: '族',
    pinyin: 'zú',
    word_type: 'Danh từ / Hậu tố',
    meaning_vi: 'tộc, giới, nhóm người (ví dụ: 上班族, 民族, 贵族)',
    examples: [
      {
        chinese: '每天清晨在地铁车站里行色匆匆的年轻上班族，都在为了美好的生活而努力拼搏。',
        pinyin: 'Měitiān qīngchén zài dìtiě chēzhàn lǐ xíngsè-cōngcōng de niánqīng shàngbānzú, dōu zài wèile měihǎo de shēnghuó ér nǔlì pīnbó.',
        meaning_vi: 'Mỗi buổi sáng sớm, giới nhân viên đi làm trẻ tuổi bước đi vội vã trong ga tàu điện ngầm đều đang nỗ lực phấn đấu vì một cuộc sống tươi đẹp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在新一轮消费浪潮中，被称为银发族的老年群体与追求个性化体验的年轻一代成为引领品质康养与文化消费升级的生力军。',
        pinyin: 'Zài xīn-yì-lún xiāofèi làngcháo zhōng, bèi chēngwéi yínfàzú de lǎonián qúntǐ yǔ zhuīqiú gèxìnghuà tǐyàn de niánqīng yídài chéngwéi yǐnlǐng pǐnzhì kāngyǎng yǔ wénhuà xiāofèi shēngjí de shēnglìjūn.',
        meaning_vi: 'Trong làn sóng tiêu dùng mới, nhóm người cao tuổi được gọi là "giới tóc bạc" cùng thế hệ trẻ theo đuổi trải nghiệm cá nhân hóa đã trở thành lực lượng nòng cốt dẫn dắt việc nâng cấp tiêu dùng văn hóa và an dưỡng chăm sóc sức khỏe chất lượng cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3589,
    hanzi: '足够',
    pinyin: 'zúgòu',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'đầy đủ, đủ',
    examples: [
      {
        chinese: '出门长途旅行前，请务必在背包里准备好足够的新鲜饮用水、高能量零食和常备急救药品。',
        pinyin: 'Chūmén chángtú lǚxíng qián, qǐng wùbì zài bèibāo lǐ zhǔnbèi hǎo zúgòu de xīnxiān yǐnyòngshuǐ, gāo-néngliàng língshí hé chángbèi jíjiù yàopǐn.',
        meaning_vi: 'Trước khi lên đường đi du lịch đường dài, xin hãy chuẩn bị đầy đủ nước uống sạch tươi mát, đồ ăn vặt giàu năng lượng và các loại thuốc cấp cứu thông dụng trong ba lô.',
        difficulty_level: 'basic'
      },
      {
        chinese: '央行通过公开市场操作向银行间金融体系投放充裕流动性，确保满足商业银行季度末监管考核与实体经济信贷投放的足够流动性需求。',
        pinyin: 'Yāngháng tōngguò gōngkāi shìchǎng cāozuò xiàng yínhángjiān jīnróng tǐxì tóufàng chōngyù liúdòngxìng, quèbǎo mǎnzú shāngyè yínháng jìdùmò jiānguǎn kǎohé yǔ shítǐ jīngjì xìndài tóufàng de zúgòu liúdòngxìng xūqiú.',
        meaning_vi: 'Ngân hàng Trung ương thông qua nghiệp vụ thị trường mở bơm thanh khoản dồi dào vào hệ thống tài chính liên ngân hàng, bảo đảm đáp ứng đầy đủ nhu cầu thanh khoản cho các ngân hàng thương mại kỳ sát hạch giám sát cuối quý và cấp tín dụng cho nền kinh tế thực.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3590,
    hanzi: '组成',
    pinyin: 'zǔchéng',
    word_type: 'Động từ',
    meaning_vi: 'tạo thành, cấu thành, hợp thành',
    examples: [
      {
        chinese: '我们班级一共由来自全国十二个不同省份的四十位优秀青年学生共同组成。',
        pinyin: 'Wǒmen bānjí yígòng yóu láizì quánguó shí\'èr ge bùtóng shěngfèn de sìshí wèi yōuxiù qīngnián xuésheng gòngtóng zǔchéng.',
        meaning_vi: 'Lớp học của chúng tôi gồm tổng cộng 40 bạn sinh viên thanh niên ưu tú đến từ 12 tỉnh thành khác nhau trên toàn quốc cùng hợp thành.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家空间站核心实验舱由推进舱、气闸舱与节点舱等多个高精尖密封增压功能舱段精密对接组成。',
        pinyin: 'Guójiā kōngjiānzhàn héxīn shíyàncāng yóu tuījìncāng, qìzhácāng yǔ jiédiǎncāng děng duō ge gāojīngjiān mìfēng zēngyā gōngnéng cāngduàn jīngmì duìjiē zǔchéng.',
        meaning_vi: 'Khoang thí nghiệm cốt lõi của trạm vũ trụ không gian quốc gia do nhiều khoang chức năng tăng áp kín khí tinh vi như khoang đẩy, khoang khóa khí và khoang nút kết nối cơ học chính xác hợp thành.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3591,
    hanzi: '组合',
    pinyin: 'zǔhé',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'kết hợp, phối hợp; tổ hợp',
    examples: [
      {
        chinese: '在校园合唱艺术节上，四位不同声部的同学自发组合成了一个完美的无伴奏混声合唱小组。',
        pinyin: 'Zài xiàoyuán héchàng yìshùjié shang, sì wèi bùtóng shēngbù de tóngxué zìfā zǔhé chéng le yí ge wánměi de wúbànzòu hùnshēng héchàng xiǎozǔ.',
        meaning_vi: 'Tại liên hoan nghệ thuật hợp xướng trường học, bốn bạn học sinh thuộc các bè giọng khác nhau đã tự giác phối hợp thành một nhóm hợp xướng hòa thanh không nhạc đệm (acappella) hoàn hảo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代投资组合理论指导基金经理在宏观利率波动周期中通过动态优化权益类与固定收益类资产组合，有效对冲非系统性市场风险。',
        pinyin: 'Xiàndài tóuzī zǔhé lǐlùn zhǐdǎo jījīn jīnglǐ zài hóngguān lìlǜ bōdòng zhōuqī zhōng tōngguò dòngtài yōuhuà quányìlèi yǔ gùdìng-shōuyìlèi zīchǎn zǔhé, yǒuxiào duìchōng fēi-xìtǒngxìng shìchǎng fēngxiǎn.',
        meaning_vi: 'Lý thuyết danh mục đầu tư hiện đại chỉ dẫn cho nhà quản lý quỹ trong chu kỳ biến động lãi suất vĩ mô thông qua việc tối ưu hóa linh hoạt danh mục tài sản cổ phiếu và tài sản thu nhập cố định để phòng vệ hiệu quả các rủi ro thị trường phi hệ thống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3592,
    hanzi: '阻止',
    pinyin: 'zǔzhǐ',
    word_type: 'Động từ',
    meaning_vi: 'ngăn cản, ngăn chặn, cản trở',
    examples: [
      {
        chinese: '当发现有调皮的小朋友打算攀爬湖边危险的护栏时，热心的巡逻保安立即上前严厉阻止。',
        pinyin: 'Dāng fāxiàn yǒu tiáopí de xiǎopéngyou dǎsuàn pānpá húbiān wēixiǎn de hùlán shí, rèxīn de xúnluó bǎo\'ān lìjí shàngqián yánlì zǔzhǐ.',
        meaning_vi: 'Khi phát hiện có em nhỏ nghịch ngợm định trèo lên lan can nguy hiểm ven hồ, nhân viên bảo vệ tuần tra nhiệt tình đã lập tức bước lên phía trước nghiêm khắc ngăn cản.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际公海核安全监督公约赋予国际原子能机构合法权限，采取一切必要法律与外交手段坚决阻止放射性污染核废水擅自向公海排海。',
        pinyin: 'Guójì gōnghǎi hé-ānquán jiāndū gōngyuē fùyǔ Guójì Yuánzǐnéng Jīgòu héfǎ quánxiàn, cǎiqǔ yíqiè bìyào fǎlǜ yǔ wàijiāo shǒuduàn jiānjué zǔzhǐ fàngshèxìng wūrǎn hé-fèishuǐ shànzì xiàng gōnghǎi páihǎi.',
        meaning_vi: 'Công ước giám sát an toàn hạt nhân vùng biển quốc tế trao quyền hạn pháp lý hợp pháp cho Cơ quan Năng lượng Nguyên tử Quốc tế áp dụng mọi biện pháp pháp luật và ngoại giao cần thiết để kiên quyết ngăn chặn việc tự ý xả nước thải hạt nhân ô nhiễm phóng xạ ra vùng biển quốc tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3593,
    hanzi: '组织',
    pinyin: 'zǔzhī',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'tổ chức, cơ quan tổ chức; cấu trúc mô học',
    examples: [
      {
        chinese: '学校学生会下周六将组织全体大一新生参观市历史博物馆与现代科技馆。',
        pinyin: 'Xuéxiào xuéshenghuì xià zhōuliù jiāng zǔzhī quántǐ dàyī xīnshēng cānguān shì lìshǐ bówùguǎn yǔ xiàndài kējìguǎn.',
        meaning_vi: 'Hội sinh viên nhà trường thứ Bảy tuần tới sẽ tổ chức cho toàn thể tân sinh viên năm nhất đi tham quan bảo tàng lịch sử và bảo tàng công nghệ hiện đại của thành phố.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代再生医学通过三维生物打印技术精确重构具有活体血管网络的人体复杂器官软组织，为终末期器官衰竭移植带来了革命性曙光。',
        pinyin: 'Xiàndài zàishēng yīxué tōngguò sānwéi shēngwù dǎyìn jìshù jīngquè chónggòu jùyǒu huótǐ xiěguǎn wǎngluò de réntǐ fùzá qìguān ruǎnzǔzhī, wèi zhōngmòqī qìguān shuāijié yízhí dài lái le gémìngxìng shǔguāng.',
        meaning_vi: 'Y học tái tạo hiện đại thông qua công nghệ in sinh học 3D tái tạo chuẩn xác các mô mềm nội tạng phức tạp của cơ thể người có mạng lưới mạch máu sống, đem lại ánh sáng bình minh mang tính cách mạng cho việc cấy ghép suy nội tạng giai đoạn cuối.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3594,
    hanzi: '嘴巴',
    pinyin: 'zuǐba',
    word_type: 'Danh từ',
    meaning_vi: 'mồm, miệng',
    examples: [
      {
        chinese: '小婴儿喝完温热的母乳之后，用肥嘟嘟的小手揉了揉嘴巴，甜甜地进入了梦乡。',
        pinyin: 'Xiǎo yīng\'ér hē wán wēnrè de mǔrǔ zhīhòu, yòng féidūdū de xiǎoshǒu róu le róu zuǐba, tiántián de jìnrù le mèngxiāng.',
        meaning_vi: 'Em bé sơ sinh sau khi uống xong dòng sữa mẹ ấm áp, dùng bàn tay nhỏ mập mạp dụi dụi cái miệng xinh rồi ngọt ngào đi vào giấc ngủ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '语言病理学与神经生物学研究证实，中枢脑卒中后患者嘴巴面部神经肌肉功能障碍可通过精准经颅磁刺激得到有效神经重塑恢复。',
        pinyin: 'Yǔyán bìnglǐxué yǔ shénjīng-shēngwùxué yánjiū zhèngshí, zhōngshū nǎozùzhòng hòu huànzhě zuǐba miànbù shénjīng-jīròu gōngnéng zhàng\'ài kě tōngguò jīngzhǔn jīnglú cícìjī dédào yǒuxiào shénjīng chóngsù huīfù.',
        meaning_vi: 'Nghiên cứu sinh học thần kinh và bệnh lý học ngôn ngữ chứng minh rằng rối loạn chức năng thần kinh cơ mặt miệng của bệnh nhân sau đột quỵ não trung khu có thể phục hồi tái tạo thần kinh hiệu quả thông qua kích thích từ xuyên sọ chuẩn xác.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3595,
    hanzi: '醉',
    pinyin: 'zuì',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'say, say rượu; say mê, đắm chìm',
    examples: [
      {
        chinese: '老朋友多年未见格外亲切，虽然桌上只备了一瓶陈年美酒，大家却都沉醉在温馨的回忆之中。',
        pinyin: 'Lǎo péngyou duō nián wèi jiàn géwài qīnqiè, suīrán zhuō shang zhǐ bèi le yì píng chénnián měijiǔ, dàjiā què dōu chénzuì zài wēnxīn de huíyì zhīzhōng.',
        meaning_vi: 'Những người bạn cũ nhiều năm không gặp vô cùng thân thiết, dẫu trên bàn chỉ chuẩn bị một chai rượu ngon lâu năm, mọi người lại đều say đắm trong những kỷ niệm ấm áp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家刑法修正案以严格的零容忍法定态度严厉打击酒驾与醉驾危险驾驶犯罪行为，坚决守护亿万公众的道路出行生命安全。',
        pinyin: 'Guójiā xíngfǎ xiūzhèng\'àn yǐ yángé de líng-róngrěn fǎdìng tàidù yánlì dǎjī jiǔjià yǔ zuìjià wēixiǎn jiàshǐ fànzuì xíngwéi, jiānjué shǒuhù yìwàn gōngzhòng de dàolù chūxíng shēngmìng ānquán.',
        meaning_vi: 'Luật hình sự sửa đổi quốc gia với thái độ pháp định không khoan nhượng nghiêm ngặt trừng trị thẳng tay các hành vi tội phạm lái xe nguy hiểm khi lái xe sau khi uống rượu và lái xe trong tình trạng say xỉn, kiên quyết bảo vệ an toàn tính mạng khi tham gia giao thông đường bộ của hàng ức người dân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3596,
    hanzi: '最初',
    pinyin: 'zuìchū',
    word_type: 'Danh từ',
    meaning_vi: 'lúc đầu, ban đầu',
    examples: [
      {
        chinese: '他在刚刚开始学中文最初的那几个星期里，连最简单的声调平仄都常常分不清楚。',
        pinyin: 'Tā zài gānggāng kāishǐ xué Zhōngwén zuìchū de nà jǐ ge xīngqī lǐ, lián zuì jiǎndān de shēngdiào píngzè dōu chángcháng fēn bu qīngchu.',
        meaning_vi: 'Trong mấy tuần đầu tiên lúc anh ấy mới bắt đầu học tiếng Trung, ngay cả những thanh điệu bằng trắc đơn giản nhất cũng thường xuyên không phân biệt rõ được.',
        difficulty_level: 'basic'
      },
      {
        chinese: '从最初几名青年科学家的车库简陋算法模型到成长为估值数千亿的全球人工智能领军独角兽，企业始终秉持着最初以技术造福人类的创新初心。',
        pinyin: 'Cóng zuìchū jǐ míng qīngnián kēxuéjiā de chēkù jiǎnlòu suànfǎ móxíng dào chéngzhǎng wéi gūzhí shùqiānyì de quánqiú réngōng zhìnéng lǐngjūn dújiǎoshòu, qǐyè shǐzhōng bǐngchí zhe zuìchū yǐ jìshù zàofú rénlèi de chuàngxīn chūxīn.',
        meaning_vi: 'Từ mô hình thuật toán sơ sài trong nhà để xe của vài nhà khoa học trẻ tuổi ban đầu cho đến khi phát triển thành kỳ lân dẫn dắt trí tuệ nhân tạo toàn cầu được định giá hàng trăm tỷ, doanh nghiệp vẫn luôn giữ vững tâm nguyện ban đầu về việc dùng công nghệ tạo phúc cho nhân loại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3597,
    hanzi: '最佳',
    pinyin: 'zuìjiā',
    word_type: 'Tính từ',
    meaning_vi: 'tốt nhất, tối ưu',
    examples: [
      {
        chinese: '他在本次全国高校计算机编程大赛决赛中凭借巧妙的代码设计与极低的运行延迟荣获最佳算法奖。',
        pinyin: 'Tā zài běncì quánguó gāoxiào jìsuànjī biānchéng dàsài juésài zhōng píngjiè qiàomiǎo de dàimǎ shèjì yǔ jí dī de yùnxíng yánchí rónghuò zuìjiā suànfǎ jiǎng.',
        meaning_vi: 'Trong trận chung kết cuộc thi lập trình máy tính các trường đại học toàn quốc lần này, anh ấy dựa vào thiết kế mã nguồn khéo léo và độ trễ vận hành cực thấp đã vinh dự đoạt giải thuật toán xuất sắc nhất.',
        difficulty_level: 'basic'
      },
      {
        chinese: '新能源微电网能量管理系统利用强化学习算法实时计算风光储联合出力的最佳调度策略，实现电网综合运行成本与碳排放的全局最优。',
        pinyin: 'Xīn-néngyuán wēidiànwǎng néngliàng guǎnlǐ xìtǒng lìyòng qiánghuà xuéxí suànfǎ shíshí jìsuàn fēng guāng chǔ liánhé chūlì de zuìjiā diàodù cèlüè, shíxiàn diànwǎng zōnghé yùnxíng chéngběn yǔ tàn-páifàng de quánjú zuìyōu.',
        meaning_vi: 'Hệ thống quản lý năng lượng lưới điện vi mô năng lượng mới vận dụng thuật toán học tăng cường tính toán theo thời gian thực chiến lược điều độ tối ưu công suất kết hợp điện gió - mặt trời - lưu trữ, hiện thực hóa mức tối ưu toàn cục về chi phí vận hành tổng hợp và phát thải carbon của lưới điện.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3598,
    hanzi: '尊敬',
    pinyin: 'zūnjìng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'tôn kính, kính trọng',
    examples: [
      {
        chinese: '张老师从教四十年桃李满天下，深受全校每一位师生发自肺腑的衷心尊敬与爱戴。',
        pinyin: 'Zhāng lǎoshī cóngjiào sìshí nián táolǐ-mǎn-tiānxià, shēnshòu quán xiào měi yí wèi shīshēng fāzì-fèifǔ de zhōngxīn zūnjìng yǔ àidài.',
        meaning_vi: 'Thầy giáo Trương dạy học bốn mươi năm học trò đầy thiên hạ, nhận được sự kính trọng và yêu mến xuất phát từ tận đáy lòng của mỗi thầy trò trong toàn trường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际社会普遍公认并坚定维护《联合国宪章》宗旨和原则，主张相互尊重国家主权与领土完整，切实尊重各国自主选择的发展道路与社会制度。',
        pinyin: 'Guójì shèhuì pǔbiàn gōngrèn bìng jiāndìng wéihù "Liánhéguó Xiànzhāng" zōngzhǐ hé yuánzé, zhǔzhāng xiānghù zūnzhòng guójiā zhǔquán yǔ lǐngtǔ wánzhěng, qièshí zūnjìng gèguó zìzhǔ xuǎnzé de fāzhǎn dàolù yǔ shèhuì zhìdù.',
        meaning_vi: 'Cộng đồng quốc tế thừa nhận rộng rãi và kiên định gìn giữ tôn chỉ và nguyên tắc của Hiến chương Liên Hợp Quốc, chủ trương tôn trọng lẫn nhau về chủ quyền quốc gia và toàn vẹn lãnh thổ, tôn trọng thực chất con đường phát triển và chế độ xã hội mà mỗi quốc gia tự chủ lựa chọn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3599,
    hanzi: '遵守',
    pinyin: 'zūnshǒu',
    word_type: 'Động từ',
    meaning_vi: 'tuân thủ, tuân theo',
    examples: [
      {
        chinese: '无论行人还是机动车驾驶员，在城市道路上通行时都必须严格遵守交通信号灯与交通规则。',
        pinyin: 'Wúlùn xíngrén háishì jīdòngchē jiàshǐyuán, zài chéngshì dàolù shang tōngxíng shí dōu bìxū yángé zūnshǒu jiāotōng xìnhàodēng yǔ jiāotōng guīzé.',
        meaning_vi: 'Bất luận người đi bộ hay người điều khiển xe cơ giới, khi lưu thông trên đường bộ thành phố đều phải tuân thủ nghiêm ngặt đèn tín hiệu giao thông và luật lệ giao thông.',
        difficulty_level: 'basic'
      },
      {
        chinese: '涉外民商事仲裁严格要求跨境跨国商事主体必须恪守诚实信用原则并全面遵守国际商业惯例与双边投资协定法定条款。',
        pinyin: 'Shèwài mín-shāngshì zhòngcái yángé yāoqiú kuàjìng kuàguó shāngshì zhǔtǐ bìxū kèshǒu chéngshí xìnyòng yuánzé bìng quánmiàn zūnshǒu guójì shāngyè guànlì yǔ shuāngbiān tóuzī xiédìng fǎdìng tiáokuǎn.',
        meaning_vi: 'Trọng tài dân sự thương mại đối ngoại yêu cầu nghiêm ngặt các chủ thể thương mại xuyên biên giới xuyên quốc gia phải nghiêm cẩn tuân thủ nguyên tắc trung thực chữ tín và chấp hành toàn diện các tập quán thương mại quốc tế cùng các điều khoản pháp định của hiệp định đầu tư song phương.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3600,
    hanzi: '作出',
    pinyin: 'zuòchū',
    word_type: 'Động từ',
    meaning_vi: 'đưa ra, làm ra (đóng góp, phán quyết, nỗ lực, quyết định)',
    examples: [
      {
        chinese: '经过连续几个通宵的论证与权衡，项目委员会终于对新厂区的选址方案作出了最终的审慎决定。',
        pinyin: 'Jīngguò liánxù jǐ ge tōngxiāo de lùnzhèng yǔ quánhéng, xiàngmù wěiyuánhuì zhōngyú duì xīn chǎngqū de xuǎnzhǐ fāng\'àn zuòchū le zuìzhōng de shěnshèn juédìng.',
        meaning_vi: 'Trải qua mấy đêm thức trắng liên tục để chứng minh và cân nhắc, ban quản lý dự án rốt cuộc đã đưa ra quyết định thận trọng cuối cùng đối với phương án lựa chọn địa điểm xây dựng khu nhà xưởng mới.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该科研先锋团队凭借在高温超导量子通信与前沿芯片底层架构上的原始理论突破，为人类前沿基础科学的发展作出了不可磨灭的历史性重大贡献。',
        pinyin: 'Gāi kēyán xiānfēng tuánduì píngjiè zài gāowēn chāodǎo liàngzǐ tōngxìn yǔ qiányán xīnpiàn dǐcéng jiàgòu shang de yuánshǐ lǐlùn tūpò, wèi rénlèi qiányán jīchǔ kēxué de fāzhǎn zuòchū le bùkě-mómì de lìshǐxìng zhòngdà gòngxiàn.',
        meaning_vi: 'Đội ngũ tiên phong nghiên cứu khoa học đó dựa vào những đột phá lý thuyết nguyên bản về thông tin lượng tử siêu dẫn nhiệt độ cao và kiến trúc tầng đáy chip mũi nhọn, đã đưa ra những cống hiến trọng đại mang tính lịch sử không thể phai mờ cho sự phát triển khoa học cơ bản tiên phong của nhân loại.',
        difficulty_level: 'applied'
      }
    ]
  }
]
