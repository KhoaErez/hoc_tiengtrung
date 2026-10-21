// data/hsk5-batch16-part1-data.ts
// 25 từ HSK 5: #3502 [直播] -> #3526 [中心]

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

export const HSK5_BATCH16_PART1: VocabItem[] = [
  {
    id: 3502,
    hanzi: '直播',
    pinyin: 'zhíbō',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phát sóng trực tiếp, livestream',
    examples: [
      {
        chinese: '今晚八点电视台将对全国青年歌手大奖赛总决赛进行现场高清直播。',
        pinyin: 'Jīnwǎn bā diǎn diànshìtái jiāng duì quánguó qīngnián gēshǒu dàjiǎngsài zǒngjuésài jìnxíng xiànchǎng gāoqīng zhíbō.',
        meaning_vi: 'Tám giờ tối nay đài truyền hình sẽ phát sóng trực tiếp độ nét cao hiện trường trận chung kết cuộc thi giải ca sĩ trẻ toàn quốc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '乡村振兴电商直播基地通过5G超低延迟直播技术将优质高山有机农产品直接销往全国各大一线城市。',
        pinyin: 'Xiāngcūn zhènxīng diànshāng zhíbō jīdì tōngguò 5G chāo-dī yánchí zhíbō jìshù jiāng yōuzhì gāoshān yǒujī nóngchǎnpǐn zhíjiē xiāo wǎng quánguó gè dà yīxiàn chéngshì.',
        meaning_vi: 'Căn cứ livestream thương mại điện tử chấn hưng nông thôn thông qua công nghệ phát trực tiếp độ trễ siêu thấp 5G đã bán trực tiếp nông sản hữu cơ vùng núi cao chất lượng ưu việt tới các thành phố tuyến một trên toàn quốc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3503,
    hanzi: '职场',
    pinyin: 'zhíchǎng',
    word_type: 'Danh từ',
    meaning_vi: 'chốn công sở, môi trường làm việc',
    examples: [
      {
        chinese: '刚刚大学毕业踏入职场的新人，应当虚心向经验丰富的老同事请教业务知识。',
        pinyin: 'Gānggāng dàxué bìyè tà rù zhíchǎng de xīnrén, yīngdāng xūxīn xiàng jīngyàn fēngfù de lǎo tóngshì qǐngjiào yèwù zhīshi.',
        meaning_vi: 'Những người mới vừa tốt nghiệp đại học bước chân vào chốn công sở nên khiêm tốn thỉnh giáo kiến thức nghiệp vụ từ các đồng nghiệp lâu năm giàu kinh nghiệm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代职场不仅高度看重专业技术硬实力，更加强调跨部门敏捷沟通协作、情绪韧性与持续学习能力等综合软实力。',
        pinyin: 'Xiàndài zhíchǎng bù jǐn gāodù kànzhòng zhuānyè jìshù yìng-shílì, gèngjiā qiángdiào kuà-bùmén mǐnjié gōutōng xiézuò, qíngxù rènxìng yǔ chíxù xuéxí nénglì děng zōnghé ruǎn-shílì.',
        meaning_vi: 'Môi trường làm việc hiện đại không chỉ đánh giá rất cao năng lực cứng về kỹ thuật chuyên môn, mà còn nhấn mạnh hơn nữa các năng lực mềm tổng hợp như giao tiếp cộng tác liên phòng ban linh hoạt, độ bền bỉ cảm xúc và khả năng không ngừng học hỏi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3504,
    hanzi: '职工',
    pinyin: 'zhígōng',
    word_type: 'Danh từ',
    meaning_vi: 'cán bộ công nhân viên, người lao động',
    examples: [
      {
        chinese: '为了丰富广大职工的业余文体生活，工会组织在周末举办了职工羽毛球友谊赛。',
        pinyin: 'Wèile fēngfù guǎngdà zhígōng de yèyú wéntǐ shēnghuó, gōnghuì zǔzhī zài zhōumò jǔbàn le zhígōng yǔmáoqiú yǒuyìsài.',
        meaning_vi: 'Để làm phong phú đời sống văn thể mỹ ngoài giờ của đông đảo cán bộ công nhân viên, tổ chức công đoàn đã tổ chức giải cầu lông hữu nghị cán bộ công nhân viên vào dịp cuối tuần.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大型国有制造集团严格健全职工代表大会民主决策程序，依法切实保障一线产业工人在劳动报酬与安全防护上的法定权益。',
        pinyin: 'Dàxíng guóyǒu zhìzào jítuán yángé jiànquán zhígōng dàibiǎo dàhuì mínzhǔ juécè chéngxù, yīfǎ qièshí bǎozhàng yīxiàn chǎnyè gōngrén zài láodòng bàochóu yǔ ānquán fánghù shang de fǎdìng quányì.',
        meaning_vi: 'Tập đoàn chế tạo quốc doanh quy mô lớn hoàn thiện nghiêm ngặt quy trình ra quyết định dân chủ của đại hội đại biểu cán bộ công nhân viên, bảo đảm thực chất theo luật định quyền lợi hợp pháp về thù lao lao động và bảo hộ an toàn của công nhân công nghiệp tuyến đầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3505,
    hanzi: '执行',
    pinyin: 'zhíxíng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'chấp hành, thực thi, thi hành',
    examples: [
      {
        chinese: '所有员工在进入工业生产车间前，都必须严格执行佩戴防尘口罩与安全帽的安全规程。',
        pinyin: 'Suǒyǒu yuángōng zài jìnrù gōngyè shēngchǎn chējiān qián, dōu bìxū yángé zhíxíng pèidài fángchén kǒuzhào yǔ ānquánmào de ānquán guīchéng.',
        meaning_vi: 'Tất cả nhân viên trước khi bước vào phân xưởng sản xuất công nghiệp đều phải chấp hành nghiêm ngặt quy trình an toàn là đeo khẩu trang chống bụi và mũ bảo hộ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '商业银行风险合规管理委员会要求各分支机构穿透式严格执行反洗钱监管指令与宏观审慎资本约束指标。',
        pinyin: 'Shāngwè yínháng fēngxiǎn hégūi guǎnlǐ wěiyuánhuì yāoqiú gè fēnzhī jīgòu chuāntòushì yángé zhíxíng fǎn-xǐqián jiānguǎn zhǐlìng yǔ hóngguān shěnshèn zīběn yuēshù zhǐbiāo.',
        meaning_vi: 'Hội đồng quản lý tuân thủ rủi ro ngân hàng thương mại yêu cầu các chi nhánh thực thi nghiêm ngặt mang tính xuyên thấu các chỉ thị giám sát chống rửa tiền và chỉ tiêu kiềm chế vốn thận trọng vĩ mô.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3506,
    hanzi: '止',
    pinyin: 'zhǐ',
    word_type: 'Động từ',
    meaning_vi: 'ngừng, thôi, chấm dứt, đình chỉ; ngăn chặn',
    examples: [
      {
        chinese: '医护人员用无菌纱布轻轻按压在伤口上，很快就帮助患者把血止住了。',
        pinyin: 'Yīhù rényuán yòng wújūn shābù qīngqīng ànyā zài shāngkǒu shang, hěn kuài jiù bāngzhù huànzhě bǎ xiě zhǐ zhù le.',
        meaning_vi: 'Nhân viên y tế dùng gạc vô trùng ấn nhẹ lên vết thương, rất nhanh chóng đã giúp bệnh nhân cầm được máu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科技企业必须牢固树立知止有定的合规伦理防线，决不能为追逐商业暴利而突破法律法规与人工智能数据向善的道德底线。',
        pinyin: 'Kējì qǐyè bìxū láogù shùlì zhīzhǐ-yǒudìng de hégūi lúnlǐ fángxiàn, jué bù néng wèi zhuīzhú shāngyè bàolì ér tūpò fǎlǜ fǎguī yǔ réngōng zhìnéng shùjù xiàngshàn de dàodé dǐxiàn.',
        meaning_vi: 'Doanh nghiệp công nghệ bắt buộc phải xác lập vững chắc phòng tuyến đạo đức tuân thủ biết điểm dừng có định hướng, tuyệt đối không vì săn đón lợi nhuận kinh doanh khổng lồ mà phá vỡ ranh giới đỏ đạo đức về hướng thiện dữ liệu AI và luật pháp quy định.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3507,
    hanzi: '指导',
    pinyin: 'zhǐdǎo',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'chỉ đạo, hướng dẫn',
    examples: [
      {
        chinese: '在经验丰富的指导老师耐心点拨下，他只用了两天时间就顺利完成了毕业论文的开题报告。',
        pinyin: 'Zài jīngyàn fēngfù de zhǐdǎo lǎoshī nàixīn diǎnbō xià, tā zhǐ yòng le liǎng tiān shíjiān jiù shùnlì wánchéng le bìyè lùnwén de kāití bàogào.',
        meaning_vi: 'Dưới sự hướng dẫn gợi mở kiên nhẫn của người giáo viên hướng dẫn giàu kinh nghiệm, anh ấy chỉ mất hai ngày là đã hoàn thành thuận lợi đề cương nghiên cứu khóa luận tốt nghiệp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国务院国资委出台专项合规指导意见，指导中央企业在全球跨国投资与境外并购交易中健全全流程海外法律合规风控体系。',
        pinyin: 'Guówùyuàn Guózīwěi chūtái zhuānxiàng hégūi zhǐdǎo yìjiàn, zhǐdǎo zhōngyāng qǐyè zài quánqiú kuàguó tóuzī yǔ jìngwài bìnggòu jiāoyì zhōng jiànquán quán-liúchéng hǎiwài fǎlǜ hégūi fēngkòng tǐxì.',
        meaning_vi: 'Ủy ban Quản lý Vốn Nhà nước thuộc Quốc vụ viện đã ban hành ý kiến chỉ đạo tuân thủ chuyên đề, hướng dẫn các doanh nghiệp trung ương hoàn thiện hệ thống kiểm soát rủi ro tuân thủ pháp lý hải ngoại toàn quy trình trong các giao dịch sáp nhập mua lại ở nước ngoài và đầu tư xuyên quốc gia toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3508,
    hanzi: '至',
    pinyin: 'zhì',
    word_type: 'Động từ / Giới từ',
    meaning_vi: 'đến, tới; cho đến',
    examples: [
      {
        chinese: '本次高校春季图书展销会将于五月一日至五月五日在综合体育馆主馆隆重举行。',
        pinyin: 'Běncì gāoxiào chūnjì túshū zhǎnxiāohuì jiāng yú wǔ yuè yī rì zhì wǔ yuè wǔ rì zài zōnghé tǐyùguǎn zhǔguǎn lóngzhòng jǔxíng.',
        meaning_vi: 'Hội chợ triển lãm sách mùa xuân các trường đại học lần này sẽ được tổ chức long trọng từ ngày 1 tháng 5 đến ngày 5 tháng 5 tại nhà thi đấu tổng hợp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '跨大西洋海底超高速光缆将洲际互联网金融交易信息传输延迟大幅压缩至微秒级别，构筑了全球高频量化交易的数字基石。',
        pinyin: 'Kuà-Dàxīyáng hǎidǐ chāo-gāosù guānglǎn jiāng zhōujì hùliánwǎng jīnróng jiāoyì xìnxī chuánshū yánchí dàfú yāsuō zhì wēimiǎojí jíbié, gòuzhù le quánqiú gāopín liànghuà jiāoyì de shùzì jīshí.',
        meaning_vi: 'Tuyến cáp quang siêu tốc dưới đáy biển xuyên Đại Tây Dương đã nén mạnh độ trễ truyền dẫn thông tin giao dịch tài chính internet liên lục địa xuống tới cấp vi giây (microsecond), xây dựng nền móng số cho giao dịch định lượng cao tần toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3509,
    hanzi: '治',
    pinyin: 'zhì',
    word_type: 'Động từ',
    meaning_vi: 'chữa trị; cai trị, quản trị, xử lý',
    examples: [
      {
        chinese: '中医主张通过辨证施治和调整饮食作息来从根本上调理身体、治愈慢性疾病。',
        pinyin: 'Zhōngyī zhǔzhāng tōngguò biànzhèng-shīzhì hé tiáozhěng yǐnshí zuòxī lái cóng gēnběn shang tiáolǐ shēntǐ, zhìyù mànxìng jíbìng.',
        meaning_vi: 'Đông y chủ trương thông qua việc biện chứng thi trị và điều chỉnh ăn uống nghỉ ngơi để điều dưỡng cơ thể từ gốc rễ và chữa khỏi các bệnh mãn tính.',
        difficulty_level: 'basic'
      },
      {
        chinese: '流域生态环境保护必须坚持山水林田湖草沙一体化保护和系统治理，全方位遏制农业面源污染与工业水土流失。',
        pinyin: 'Liúyù shēngtài huánjìng bǎohù bìxū jiānchí shān shuǐ lín tián hú cǎo shā yītǐhuà bǎohù hé xìtǒng zhìlǐ, quán-fāngwèi èzhì nóngyè miànyuán wūrǎn yǔ gōngyè shuǐtǔ liúshī.',
        meaning_vi: 'Bảo vệ môi trường sinh thái lưu vực bắt buộc phải kiên trì bảo vệ nhất thể hóa và quản trị có hệ thống núi, nước, rừng, ruộng, hồ, cỏ, cát, ngăn chặn toàn diện ô nhiễm nguồn nông nghiệp và xói mòn đất nước công nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3510,
    hanzi: '制订',
    pinyin: 'zhìdìng',
    word_type: 'Động từ',
    meaning_vi: 'soạn thảo, lập ra, xây dựng (kế hoạch, dự thảo)',
    examples: [
      {
        chinese: '为了迎接即将到来的期末考试，班长组织大家共同制订了一份切实可行的集体复习计划。',
        pinyin: 'Wèile yíngjiē jíjiāng dàolái de qīmò kǎoshì, bānzhǎng zǔzhī dàjiā gòngtóng zhìdìng le yí fèn qièshí-kěxíng de jítǐ fùxí jìhuà.',
        meaning_vi: 'Để đón kỳ thi cuối kỳ sắp tới, lớp trưởng đã tổ chức cho mọi người cùng nhau lập ra một bản kế hoạch ôn tập tập thể khả thi và thiết thực.',
        difficulty_level: 'basic'
      },
      {
        chinese: '跨部门联合工作组正在抓紧制订支持战略性新兴产业高质量发展的专项财税激励政策实施细则草案。',
        pinyin: 'Kuà-bùmén liánhé gōngzuòzǔ zhèngzài zhuājǐn zhìdìng zhīchí zhànlüèxìng xīnxīng chǎnyè gāozhìliàng fāzhǎn de zhuānxiàng cái-shuì jīlì zhèngcè shíshī xìzé cǎo\'àn.',
        meaning_vi: 'Tổ công tác liên bộ ngành đang khẩn trương soạn thảo dự thảo thông tư hướng dẫn chi tiết thực hiện chính sách khuyến khích tài chính thuế chuyên đề hỗ trợ các ngành công nghiệp mới nổi mang tính chiến lược phát triển chất lượng cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3511,
    hanzi: '制定',
    pinyin: 'zhìdìng',
    word_type: 'Động từ',
    meaning_vi: 'ban hành, định ra, chế định (luật pháp, quy chế chính thức)',
    examples: [
      {
        chinese: '学校管理层根据广大家长的反馈意见，重新制定了更为合理的学生食堂营养配餐标准。',
        pinyin: 'Xuéxiào guǎnlǐcéng gēnjù guǎngdà jiāzhǎng de fǎnkuì yìjiàn, chóngxīn zhìdìng le gèngwéi hélǐ de xuésheng shítáng yíngyǎng pèicān biāozhǔn.',
        meaning_vi: 'Ban giám hiệu nhà trường dựa theo ý kiến phản hồi của đông đảo phụ huynh đã định ra lại tiêu chuẩn chia suất ăn dinh dưỡng bếp ăn học sinh hợp lý hơn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全国人民代表大会常务委员会审议并正式表决通过制定《中华人民共和国数据安全法》，构建了国家数字主权防护的根本法律基石。',
        pinyin: 'Quánguó Rénmín Dàibiǎo Dàhuì Chángwù Wěiyuánhuì shěnyì bìng zhèngshì biǎojué tōngguò zhìdìng "Zhōnghuá Rénmín Gònghéguó Shùjù Ānquán Fǎ", gòujiàn le guójiā shùzì zhǔquán fánghù de gēnběn fǎlǜ jīshí.',
        meaning_vi: 'Ủy ban Thường vụ Đại hội Đại biểu Nhân dân Toàn quốc đã thẩm nghị và biểu quyết chính thức thông qua việc ban hành "Luật An toàn Dữ liệu Nước Cộng hòa Xã hội Chủ nghĩa Trung Hoa", thiết lập nền móng pháp lý căn bản bảo vệ chủ quyền số quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3512,
    hanzi: '制度',
    pinyin: 'zhìdù',
    word_type: 'Danh từ',
    meaning_vi: 'chế độ, thể chế, quy chế',
    examples: [
      {
        chinese: '新员工入职培训的第一课，就是认真学习并严格遵守公司的各项规章制度与考勤纪律。',
        pinyin: 'Xīn yuángōng rùzhí péixùn de dì-yī kè, jiù shì rènzhēn xuéxí bìng yángé zūnshǒu gōngsī de gè xiàng guīzhāng zhìdù yǔ kǎoqín jìlǜ.',
        meaning_vi: 'Bài học đầu tiên của khóa đào tạo hội nhập nhân viên mới chính là nghiêm túc học tập và tuân thủ nghiêm ngặt các nội quy quy chế cùng kỷ luật chấm công của công ty.',
        difficulty_level: 'basic'
      },
      {
        chinese: '健全现代预算管理制度与地方政府债务长效防范化解机制，是保障国家财政平稳可持续运行的根本制度保障。',
        pinyin: 'Jiànquán xiàndài yùsuàn guǎnlǐ zhìdù yǔ dìfāng zhèngfǔ zhàiwù chángxiào fángfàn huàjiě jīzhì, shì bǎozhàng guójiā cáizhèng píngwěn kěchíxù yùnxíng de gēnběn zhìdù bǎozhàng.',
        meaning_vi: 'Hoàn thiện chế độ quản lý ngân sách hiện đại và cơ chế hữu hiệu lâu dài phòng ngừa giải tỏa nợ chính quyền địa phương là sự bảo đảm thể chế căn bản giúp tài chính quốc gia vận hành bình ổn và bền vững.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3513,
    hanzi: '智慧',
    pinyin: 'zhìhuì',
    word_type: 'Danh từ',
    meaning_vi: 'trí tuệ',
    examples: [
      {
        chinese: '这位老学者凭借一生的丰富阅历和人生智慧，为前来请教的年轻创业者指明了方向。',
        pinyin: 'Zhè wèi lǎo xuézhě píngjiè yìshēng de fēngfù yuèlì hé rénshēng zhìhuì, wèi qiánlái qǐngjiào de niánqīng chuàngyèzhě zhǐmíng le fāngxiàng.',
        meaning_vi: 'Vị học giả cao tuổi này dựa vào vốn trải nghiệm phong phú cả một đời và trí tuệ nhân sinh đã chỉ rõ phương hướng cho người khởi nghiệp trẻ tuổi đến thỉnh giáo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '智慧城市数字化中枢运用数字孪生建模技术全面聚合交通、气象与应急管网大数据，实现超大城市精细化敏捷治理。',
        pinyin: 'Zhìhuì chéngshì shùzìhuà zhōngshū yùnyòng shùzì luánshēng jiànmó jìshù quánmiàn jùhé jiāotōng, qìxiàng yǔ yīngjí guǎnwǎng dà-shùjù, shíxiàn chāo-dà chéngshì jīngxìhuà mǐnjié zhìlǐ.',
        meaning_vi: 'Bộ não kỹ thuật số đô thị thông minh vận dụng công nghệ mô hình hóa bản sao kỹ thuật số để tổng hợp toàn diện dữ liệu lớn về giao thông, khí tượng và mạng lưới đường ống khẩn cấp, hiện thực hóa việc quản trị đô thị siêu lớn một cách tinh vi và linh hoạt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3514,
    hanzi: '至今',
    pinyin: 'zhìjīn',
    word_type: 'Phó từ',
    meaning_vi: 'cho đến nay, đến tận bây giờ',
    examples: [
      {
        chinese: '那本小学毕业时同班好友赠送给我的精美集邮册，至今我依然完好地珍藏在书房的抽屉里。',
        pinyin: 'Nà běn xiǎoxué bìyè shí tóngbān hǎoyǒu zèngsòng gěi wǒ de jīngměi jíyóucè, zhìjīn wǒ yīrán wánhǎo de zhēncáng zài shūfáng de chōuti lǐ.',
        meaning_vi: 'Cuốn sổ sưu tập tem tinh xảo mà người bạn thân cùng lớp tặng tôi hồi tốt nghiệp tiểu học, cho đến nay tôi vẫn trân trọng cất giữ nguyên vẹn trong ngăn kéo phòng đọc sách.',
        difficulty_level: 'basic'
      },
      {
        chinese: '尽管量子物理学在微观粒子实验观测上取得了巨大成功，但将引力理论与量子场论完美统一的万物理论构想至今仍是未解之谜。',
        pinyin: 'Jǐnguǎn liàngzǐ wùlǐxué zài wēiguān lìzǐ shíyàn guāncè shang qǔdé le jùdà chénggōng, dàn jiāng yǐnlì lǐlùn yǔ liàngzǐ chǎnglùn wánměi tǒngyī de wànwù lǐlùn gòuxiǎng zhìjīn réng shì wèijiě zhī mǐ.',
        meaning_vi: 'Mặc dù vật lý lượng tử đã đạt được thành công to lớn trong quan sát thực nghiệm hạt vi mô, nhưng ý niệm lý thuyết vạn vật thống nhất hoàn hảo thuyết hấp dẫn với lý thuyết trường lượng tử cho đến tận ngày nay vẫn là câu đố chưa có lời giải.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3515,
    hanzi: '治疗',
    pinyin: 'zhìliáo',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'điều trị, chữa trị',
    examples: [
      {
        chinese: '患者只要遵照医嘱按时服药并积极配合康复治疗，骨折部位在两三个月内便能痊愈。',
        pinyin: 'Huànzhě zhǐyào zūnlzhào yīzhǔ ànshí fúyào bìng jījí pèihé kāngfù zhìliáo, gǔzhé bùwèi zài liǎng-sān ge yuè nèi biàn néng quányù.',
        meaning_vi: 'Người bệnh chỉ cần tuân theo lời dặn của bác sĩ uống thuốc đúng giờ và tích cực phối hợp điều trị phục hồi chức năng thì vị trí gãy xương trong vòng hai ba tháng là có thể khỏi hẳn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '基于嵌合抗原受体T细胞免疫疗法的精准靶向治疗方案，在难治性恶性血液系统肿瘤临床试验中展现出令人振奋的长期完全缓解率。',
        pinyin: 'Jīyú qiānhé kàngyuán shòutǐ T xìbāo miǎnyì liáofǎ de jīngzhǔn bǎxiàng zhìliáo fāng\'àn, zài nánzhìxìng èxìng xuèyè xìtǒng zhǒngliú línchuáng shìyàn zhōng zhǎnxiàn chū lìngrén-zhènfèn de chángqī wánquán huǎnjiělǜ.',
        meaning_vi: 'Phương án điều trị nhắm trúng đích chuẩn xác dựa trên liệu pháp miễn dịch tế bào CAR-T trong các thử nghiệm lâm sàng đối với các khối u ác tính khó chữa của hệ tạo máu đã thể hiện tỷ lệ thuyên giảm hoàn toàn dài hạn đáng phấn khởi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3516,
    hanzi: '智能',
    pinyin: 'zhìnéng',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'thông minh, trí tuệ nhân tạo, smart',
    examples: [
      {
        chinese: '现在的智能扫地机器人不仅能够自主规划清扫路径，还能在电量不足时自动返回基站充电。',
        pinyin: 'Xiànzài de zhìnéng sǎodì jīqìrén bù jǐn nénggòu zìzhǔ guīhuà qīngsǎo lùjìng, hái néng zài diànliàng bùzú shí zìdòng fǎnhuí jīzhàn chōngdiàn.',
        meaning_vi: 'Robot hút bụi thông minh ngày nay không những có thể tự chủ quy hoạch đường đi quét dọn, mà còn có thể tự động quay về trạm sạc khi pin yếu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '新一代通用具身人工智能技术正深度重塑工业自动化装备，赋予人形机器人全自主环境感知与复杂工件精密装配能力。',
        pinyin: 'Xīn-yídài tōngyòng jùshēn réngōng zhìnéng jìshù zhèng shēndù chóngsù gōngyè zìdònghuà zhuāngbèi, fùyǔ rénxíng jīqìrén quán-zìzhǔ huánjìng gǎnzhī yǔ fùzá gōngjiàn jīngmì zhuāngpèi nénglì.',
        meaning_vi: 'Công nghệ trí tuệ nhân tạo hiện thân đa năng thế hệ mới đang tái định hình sâu sắc các thiết bị tự động hóa công nghiệp, trao cho robot hình người năng lực cảm nhận môi trường hoàn toàn tự chủ và lắp ráp cơ khí chính xác các linh kiện phức tạp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3517,
    hanzi: '志愿者',
    pinyin: 'zhìyuànzhě',
    word_type: 'Danh từ',
    meaning_vi: 'tình nguyện viên',
    examples: [
      {
        chinese: '上百名大学生志愿者利用周末时间来到社区养老院，陪伴孤寡老人聊天并打扫院落卫生。',
        pinyin: 'Shàngbǎi míng dàxuéshēng zhìyuànzhě lìyòng zhōumò shíjiān lái dào shèqū yǎnglǎoyuàn, péibàn gūguǎ lǎorén liáotiān bìng dǎsǎo yuànluò wèishēng.',
        meaning_vi: 'Hàng trăm sinh viên tình nguyện viên đã tận dụng thời gian cuối tuần đến viện dưỡng lão cộng đồng, đồng hành trò chuyện với các cụ già neo đơn và quét dọn vệ sinh sân vườn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在大型国际体育盛会与多边外交峰会中，精通多国语言的青年志愿者团队构筑了展现东道国开放文明形象的靓丽风景线。',
        pinyin: 'Zài dàxíng guójì tǐyù shènghuì yǔ duōbiān wàijiāo fēnghuì zhōng, jīngtōng duōguó yǔyán de qīngnián zhìyuànzhě tuánduì gòuzhù le zhǎnxiàn dōngdàoguó kāifàng wénmíng xíngxiàng de liànglì fēngjǐngxiàn.',
        meaning_vi: 'Tại các đại hội thể thao quốc tế lớn và hội nghị thượng đỉnh ngoại giao đa phương, đội ngũ tình nguyện viên thanh niên tinh thông nhiều thứ tiếng đã tạo nên một bức tranh phong cảnh rực rỡ thể hiện hình ảnh văn minh cởi mở của đất nước chủ nhà.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3518,
    hanzi: '制造',
    pinyin: 'zhìzào',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'chế tạo, sản xuất; tạo ra',
    examples: [
      {
        chinese: '这家老牌钟表工厂始终坚持手工装配每一枚齿轮零件，制造出品质卓越的经典机械腕表。',
        pinyin: 'Zhè jiā lǎopái zhōngbiǎo gōngchǎng shǐzhōng jiānchí shǒugōng zhuāngpèi měi yì méi chǐlún língjiàn, zhìzào chū pǐnzhì zhuóyuè de jīngdiǎn jīxiè wànbiǎo.',
        meaning_vi: 'Nhà máy sản xuất đồng hồ lâu năm này luôn kiên trì lắp ráp thủ công từng chiếc linh kiện bánh răng, chế tạo ra những chiếc đồng hồ cơ cổ điển có chất lượng vượt trội.',
        difficulty_level: 'basic'
      },
      {
        chinese: '推动制造业向高端化、智能化、绿色化迈进，是加快建设现代化产业体系并牢牢掌握全球高端装备制造话语权的核心支撑。',
        pinyin: 'Tuīdòng zhìzàoyè xiàng gāoduānhuà, zhìnénghuà, lǜsèhuà màijìn, shì jiākuài jiànshè xiàndàihuà chǎnyè tǐxì bìng láoláo zhǎngwò quánqiú gāoduān zhuāngbèi zhìzào huàyǔquán de héxīn zhīchēng.',
        meaning_vi: 'Thúc đẩy ngành chế tạo tiến bước theo hướng cao cấp hóa, thông minh hóa và xanh hóa là trụ cột cốt lõi để đẩy nhanh xây dựng hệ thống công nghiệp hiện đại và nắm chắc tiếng nói quyết định trong sản xuất chế tạo thiết bị cao cấp toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3519,
    hanzi: '制作',
    pinyin: 'zhìzuò',
    word_type: 'Động từ',
    meaning_vi: 'chế tác, làm ra, sáng tạo (video, đồ thủ công, tác phẩm)',
    examples: [
      {
        chinese: '美术课上，老师耐心地教小朋友们如何用彩纸和剪刀制作生动有趣的动物剪纸模型。',
        pinyin: 'Měishùkè shang, lǎoshī nàixīn de jiāo xiǎopéngyoumen rúhé yòng cǎizhǐ hé jiǎndāo zhìzuò shēngdòng-yǒuqù de dòngwù jiǎnzhǐ móxíng.',
        meaning_vi: 'Trong giờ học mỹ thuật, cô giáo kiên nhẫn dạy các em nhỏ cách dùng giấy màu và kéo để chế tác các mô hình cắt giấy động vật sinh động thú vị.',
        difficulty_level: 'basic'
      },
      {
        chinese: '影视后期数字特效团队运用虚幻引擎虚拟制片技术制作出逼真的科幻宇宙史诗大片，将传统实景搭建周期缩短了近百分之七十。',
        pinyin: 'Yǐngshì hòuqī shùzì tèxiào tuánduì yùnyòng Xūhuàn Yǐnqíng xūnǐ zhìpiàn jìshù zhìzuò chū bīzhēn de kēhuàn yǔzhòu shǐshī dàpiān, jiāng chuántǒng shíjǐng dājiàn zhōuqī suōduǎn le jìn bǎifēnzhī-qīshí.',
        meaning_vi: 'Đội ngũ kỹ xảo số hậu kỳ điện ảnh truyền hình vận dụng công nghệ sản xuất phim ảo Unreal Engine để chế tác nên bộ phim sử thi khoa học viễn tưởng vũ trụ chân thực, rút ngắn gần 70% chu kỳ dựng cảnh thực tế truyền thống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3520,
    hanzi: '中华',
    pinyin: 'Zhōnghuá',
    word_type: 'Danh từ',
    meaning_vi: 'Trung Hoa',
    examples: [
      {
        chinese: '中华传统文化博大精深，无论是书法、京剧还是古典诗词都散发着独特的东方艺术魅力。',
        pinyin: 'Zhōnghuá chuántǒng wénhuà bódà-jīngshēn, wúlùn shì shūfǎ, Jīngjù háishì gǔdiǎn shīcí dōu sànfā zhe dútè de dōngfāng yìshù mèilì.',
        meaning_vi: 'Văn hóa truyền thống Trung Hoa uyên bác sâu rộng, bất luận là thư pháp, kinh kịch hay thơ từ cổ điển đều tỏa ra sức quyến rũ nghệ thuật phương Đông độc đáo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '传承弘扬中华优秀传统文化中的天人合一与和合共生哲学理念，为解决当今全球生态危机提供了极具启迪意义的东方智慧方案。',
        pinyin: 'Chuánchéng hóngyáng Zhōnghuá yōuxiù chuántǒng wénhuà zhōng de tiānrén-héyī yǔ héhé-gòngshēng zhéxué lǐniàn, wèi jiějué dāngjīn quánqiú shēngtài wēijī tígōng le jí jù qǐdí yìyì de dōngfāng zhìhuì fāng\'àn.',
        meaning_vi: 'Kế thừa và phát huy triết lý thiên nhân hợp nhất và hòa hợp cùng sinh tồn trong nền văn hóa truyền thống ưu tú Trung Hoa cung cấp phương án trí tuệ phương Đông mang tính khai sáng sâu sắc để giải quyết khủng hoảng sinh thái toàn cầu ngày nay.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3521,
    hanzi: '中华民族',
    pinyin: 'Zhōnghuá Mínzú',
    word_type: 'Cụm từ / Danh từ',
    meaning_vi: 'dân tộc Trung Hoa',
    examples: [
      {
        chinese: '吃苦耐劳、自强不息是中华民族自古以来流淌在血液里的优良传统美德。',
        pinyin: 'Chīkǔ-nàiláo, zìqiáng-bùxī shì Zhōnghuá Mínzú zìgǔ yǐlái liútǎng zài xuèyè lǐ de yōuliáng chuántǒng měidé.',
        meaning_vi: 'Chịu thương chịu khó, tự cường không ngừng nghỉ là đức tính truyền thống tốt đẹp chảy trong huyết quản của dân tộc Trung Hoa từ ngàn xưa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '铸牢中华民族共同体意识是新时代党的民族工作的主线，推动各民族像石榴籽一样紧紧抱在一起共同繁荣发展。',
        pinyin: 'Zhùláo Zhōnghuá Mínzú gòngtóngtǐ yìshí shì xīn-shídài dǎng de mínzú gōngzuò de zhǔxiàn, tuīdòng gè mínzú xiàng shíliuzǐ yíyàng jǐnjǐn bào zài yìqǐ gòngtóng fánróng fāzhǎn.',
        meaning_vi: 'Đúc vững ý thức cộng đồng chung dân tộc Trung Hoa là tuyến chủ đạo trong công tác dân tộc thời đại mới, thúc đẩy các dân tộc gắn kết bền chặt như những hạt lựu để cùng nhau phồn vinh phát triển.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3522,
    hanzi: '中级',
    pinyin: 'zhōngjí',
    word_type: 'Tính từ',
    meaning_vi: 'trung cấp, bậc trung',
    examples: [
      {
        chinese: '经过半年的刻苦自学，他顺利通过了汉语水平考试四级，成功达到了中级汉语沟通交流水平。',
        pinyin: 'Jīngguò bàn nián de kèkǔ zìxué, tā shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì sì jí, chénggōng dádào le zhōngjí Hànyǔ gōutōng jiāoliú shuǐpíng.',
        meaning_vi: 'Trải qua nửa năm tự học khổ công, anh ấy đã vượt qua kỳ thi năng lực Hán ngữ cấp 4 một cách thuận lợi, thành công đạt đến trình độ giao tiếp tiếng Trung trung cấp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '人力资源与社会保障部门发布了最新的中级专业技术人员职称评审标准，重点破除唯学历、唯论文的单一评价倾向。',
        pinyin: 'Rénlì zīyuán yǔ shèhuì bǎozhàng bùmén fābù le zuìxīn de zhōngjí zhuānyè jìshù rényuán zhíchēng píngshěn biāozhǔn, zhòngdiǎn pòchú wéi xuélì, wéi lùnwén de dānyī píngjià qīngxiàng.',
        meaning_vi: 'Cơ quan nhân lực và bảo đảm xã hội đã công bố tiêu chuẩn xét duyệt chức danh nghề nghiệp cán bộ kỹ thuật chuyên môn bậc trung cấp mới nhất, tập trung xóa bỏ khuynh hướng đánh giá phiến diện chỉ dựa vào bằng cấp hay bài báo.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3523,
    hanzi: '中介',
    pinyin: 'zhōngjiè',
    word_type: 'Danh từ',
    meaning_vi: 'môi giới, trung gian',
    examples: [
      {
        chinese: '刚到一个陌生的城市工作，他通过一家正规的大型房屋中介公司租下了一套舒适的公寓。',
        pinyin: 'Gāng dào yí ge mòshēng de chéngshì gōngzuò, tā tōngguò yì jiā zhèngguī de dàxíng fángwū zhōngjiè gōngsī zū xià le yí tào shūshì de gōngyù.',
        meaning_vi: 'Vừa tới một thành phố xa lạ làm việc, anh ấy đã thông qua một công ty môi giới nhà đất quy mô lớn chính quy để thuê một căn hộ tiện nghi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '知识产权交易平台充当科技成果转化的高效技术中介枢纽，有效打通了高校科研成果向中小制造企业转移转化的堵点。',
        pinyin: 'Zhīshi chǎnquán jiāoyì píngtái chōngdāng kējì chéngguǒ zhuǎnhuà de gāoxiào jìshù zhōngjiè shūniǔ, yǒuxiào dǎtōng le gāoxiào kēyán chéngguǒ xiàng zhōng-xiǎo zhìzào qǐyè zhuǎnyí zhuǎnhuà de dǔdiǎn.',
        meaning_vi: 'Sàn giao dịch quyền sở hữu trí tuệ đóng vai trò là đầu mối trung gian công nghệ hiệu quả cao cho chuyển giao thành quả khoa học công nghệ, khơi thông hiệu quả các điểm nghẽn chuyển giao thành quả nghiên cứu đại học sang các doanh nghiệp chế tạo vừa và nhỏ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3524,
    hanzi: '中期',
    pinyin: 'zhōngqī',
    word_type: 'Danh từ',
    meaning_vi: 'trung kỳ, giai đoạn giữa',
    examples: [
      {
        chinese: '国家重点实验室定于下周三举行重大科研专项的中期检查评估汇报会。',
        pinyin: 'Guójiā zhòngdiǎn shíyànshì dìng yú xià zhōusān jǔxíng zhòngdà kēyán zhuānxiàng de zhōngqī jiǎnchá pínggū huìbàohuì.',
        meaning_vi: 'Phòng thí nghiệm trọng điểm quốc gia ấn định vào thứ Tư tuần sau sẽ tổ chức hội nghị báo cáo kiểm tra đánh giá giai đoạn giữa của chuyên án nghiên cứu khoa học trọng đại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '宏观经济五年规划实施中期评估报告客观指出了战略新兴产业产能结构性过剩与民间投资动能趋缓的潜在挑战。',
        pinyin: 'Hóngguān jīngjì wǔ nián guīhuà shíshī zhōngqī pínggū bàogào kèguān zhǐchū le zhànlüè xīnxīng chǎnyè chǎnnéng jiégòuxìng guòshèng yǔ mínjiān tóuzī dòngnéng qūhuǎn de qiánzài tiǎozhàn.',
        meaning_vi: 'Báo cáo đánh giá giữa kỳ việc thực hiện quy hoạch 5 năm kinh tế vĩ mô đã chỉ ra một cách khách quan những thách thức tiềm ẩn về tình trạng dư thừa công suất mang tính cơ cấu của các ngành mới nổi chiến lược và đà đầu tư tư nhân chậm lại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3525,
    hanzi: '中外',
    pinyin: 'zhōngwài',
    word_type: 'Danh từ',
    meaning_vi: 'trong và ngoài nước, Trung Quốc và nước ngoài',
    examples: [
      {
        chinese: '在市中心举办的国际传统民俗美食节上，汇聚了成百上千种中外知名特色风味小吃。',
        pinyin: 'Zài shìzhōngxīn jǔbàn de guójì chuántǒng mínsú měishíjié shang, huìjù le chéngbǎi-shàngqiān zhǒng zhōngwài zhīmíng tèsè fēngwèi xiǎochī.',
        meaning_vi: 'Tại lễ hội ẩm thực phong tục dân gian truyền thống quốc tế tổ chức ở trung tâm thành phố đã hội tụ hàng trăm hàng nghìn món ăn vặt hương vị đặc sắc nổi tiếng trong và ngoài nước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中外合资高精尖科研机构在深空探测与受控核聚变前沿物理领域开展了深度互补的多边跨国科学攻关。',
        pinyin: 'Zhōngwài hézī gāojīngjiān kēyán jīgòu zài shēnkōng tàncè yǔ shòukòng hé-jùbiàn qiányán wùlǐ lǐngyù kāizhǎn le shēndù hùbǔ de duōbiān kuàguó kēxué gōngguān.',
        meaning_vi: 'Cơ quan nghiên cứu khoa học công nghệ đỉnh cao liên doanh Trung - ngoại đã triển khai các cuộc đột phá khoa học xuyên quốc gia đa bên mang tính bổ sung sâu sắc trong các lĩnh vực vật lý mũi nhọn như thăm dò không gian sâu và nhiệt hạch có thể kiểm soát.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3526,
    hanzi: '中心',
    pinyin: 'zhōngxīn',
    word_type: 'Danh từ',
    meaning_vi: 'trung tâm, trọng tâm',
    examples: [
      {
        chinese: '我们学校刚刚在校园中心花园旁边新建了一座藏书极为丰富的现代化综合图书馆。',
        pinyin: 'Wǒmen xuéxiào gānggāng zài xiàoyuán zhōngxīn huāyuán pángbiān xīnjiàn le yí zuò cángshū jíqí fēngfù de xiàndàihuà zōnghé túshūguǎn.',
        meaning_vi: 'Trường học của chúng tôi vừa mới xây dựng một thư viện tổng hợp hiện đại có lượng sách lưu trữ vô cùng phong phú bên cạnh hoa viên trung tâm trường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际金融中心与跨国航运枢纽建设必须坚持以高水平制度型对外开放为核心，深化跨境资本双向流动便利化改革。',
        pinyin: 'Guójì jīnróng zhōngxīn yǔ kuàguó hángyùn shūniǔ jiànshè bìxū jiānchí yǐ gāoshuǐpíng zhìdùxíng duìwài kāifàng wéi héxīn, shēnhuà kuàjìng zīběn shuāngxiàng liúdòng biànlìhuà gǎigé.',
        meaning_vi: 'Việc xây dựng trung tâm tài chính quốc tế và đầu mối vận tải biển xuyên quốc gia bắt buộc phải kiên trì lấy mở cửa đối ngoại dạng thể chế trình độ cao làm cốt lõi, làm sâu sắc thêm cải cách tạo thuận lợi cho dòng vốn xuyên biên giới luân chuyển hai chiều.',
        difficulty_level: 'applied'
      }
    ]
  }
]
