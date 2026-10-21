// data/hsk5-batch13-part1-data.ts
// 25 từ HSK 5: #3202 [问卷] -> #3226 [系]

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

export const HSK5_BATCH13_PART1: VocabItem[] = [
  {
    id: 3202,
    hanzi: '问卷',
    pinyin: 'wènjuàn',
    word_type: 'Danh từ',
    meaning_vi: 'phiếu điều tra, bảng khảo sát',
    examples: [
      {
        chinese: '请您抽出两分钟时间，协助我们填写一份关于售后满意度的问卷。',
        pinyin: 'Qǐng nín chōuchū liǎng fēnzhōng shíjiān, xiézhù wǒmen tiánxiě yī fèn guānyú shòuhòu mǎnyìdù de wènjuàn.',
        meaning_vi: 'Xin quý khách bớt chút hai phút thời gian giúp chúng tôi điền một bản khảo sát về mức độ hài lòng sau bán hàng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '市场研究团队采用双盲随机抽样方法发放并回收了逾万份问卷，为新产品研发与精准定位提供了翔实客观的量化数据支撑。',
        pinyin: 'Shìchǎng yánjiū tuánduì cǎiyòng shuāngmáng suíjī chōuyàng fāngfǎ fāfàng bìng huíshōu le yú wàn fèn wènjuàn, wèi xīn chǎnpǐn yánfā yǔ jīngzhǔn dìngwèi tígōng le xiángshí kèguān de liànghuà shùjù zhīchēng.',
        meaning_vi: 'Đội ngũ nghiên cứu thị trường áp dụng phương pháp lấy mẫu ngẫu nhiên mù đôi để phát ra và thu hồi hơn mười nghìn bảng khảo sát, cung cấp điểm tựa dữ liệu định lượng chuẩn xác và khách quan cho hoạt động R&D và định vị chuẩn xác sản phẩm mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3203,
    hanzi: '握',
    pinyin: 'wò',
    word_type: 'Động từ',
    meaning_vi: 'nắm, giữ, cầm chắc',
    examples: [
      {
        chinese: '母亲紧紧握着孩子娇嫩的小手，一步步走过车流如织的十字路口。',
        pinyin: 'Mǔqīn jǐnjǐn wò zhe háizi jiāonèn de xiǎoshǒu, yībùbù zǒu guò chēliú rù zhī de shízì lùkǒu.',
        meaning_vi: 'Người mẹ nắm chặt bàn tay nhỏ nhắn mềm mại của đứa con, từng bước dắt con băng qua ngã tư xe cộ qua lại như mắc cửi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '机长全神贯注地握紧主操纵杆，在突发强侧风气流扰动下沉着稳健地引导飞机平稳降落于跑道。',
        pinyin: 'Jīzhǎng quánshén-guànzhù de wò jǐn zhǔ cāozònggān, zài tūfā qiáng cèfēng qìliú rǎodòng xià chénzhuó wěnjiàn de yǐndǎo fēijī píngwěn jiàngluò yú pǎodào.',
        meaning_vi: 'Cơ trưởng tập trung cao độ nắm chặt cần điều khiển chính, bình tĩnh và vững vàng điều khiển máy bay hạ cánh êm thuận xuống đường băng trong điều kiện luồng gió giật ngang đột ngột.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3204,
    hanzi: '卧室',
    pinyin: 'wòshì',
    word_type: 'Danh từ',
    meaning_vi: 'phòng ngủ',
    examples: [
      {
        chinese: '这套两居室公寓的主卧室朝南，采光极佳且配有独立的卫生间。',
        pinyin: 'Zhè tào liǎng jū shì gōngyù de zhǔ wòshì cháo nán, cǎiguāng jí jiā qiě pèi yǒu dúlì de wèishēngjiān.',
        meaning_vi: 'Phòng ngủ chính của căn hộ hai phòng ngủ này quay về hướng nam, đón ánh sáng rất tốt và có nhà vệ sinh khép kín.',
        difficulty_level: 'basic'
      },
      {
        chinese: '室内健康环境设计规范明确要求，主卧室必须保持良好的新风自然置换与隔音阻尼降噪性能，以切实保障深度睡眠品质。',
        pinyin: 'Shìnèi jiànkāng huánjìng shèjì guīfàn míngquè yāoqiú, zhǔ wòshì bìxū bǎochí liánghǎo de xīnfēng zìrán zhìhuàn yǔ géyīn zǔní jiàngzào xìngnéng, yǐ qièshí bǎozhàng shēndù shuìmián pǐnzhì.',
        meaning_vi: 'Quy chuẩn thiết kế môi trường lành mạnh trong nhà yêu cầu rõ ràng, phòng ngủ chính bắt buộc phải duy trì sự lưu thông khí tươi tự nhiên tốt cùng hiệu năng cách âm giảm chấn tiêu âm để bảo đảm thiết thực chất lượng giấc ngủ sâu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3205,
    hanzi: '握手',
    pinyin: 'wòshǒu',
    word_type: 'Động từ',
    meaning_vi: 'bắt tay',
    examples: [
      {
        chinese: '会议圆满结束后，双方代表热情握手并互致最诚挚的问候。',
        pinyin: 'Huìyì yuánmǎn jiéshù hòu, shuāngfāng dàibiǎo rèqíng wòshǒu bìng hù zhì zuì chéngzhì de wènhòu.',
        meaning_vi: 'Sau khi hội nghị kết thúc tốt đẹp, đại diện hai bên đã nhiệt tình bắt tay và gửi tới nhau những lời thăm hỏi chân thành nhất.',
        difficulty_level: 'basic'
      },
      {
        chinese: '两国元首在红地毯迎宾厅亲切握手合影，这一历史性瞬间标志着双边全面战略合作伙伴关系翻开了崭新篇章。',
        pinyin: 'Liǎng guó yuánshǒu zài hóng dǐtǎn yíngbīntīng qīnqiè wòshǒu héyǐng, zhè yī lìshǐxìng shùnjiān biāozhì zhe shuāngbiān quánmiàn zhànlüè hézuò huǒbàn guānxì fānkāi le zhǎnxīn piānzhāng.',
        meaning_vi: 'Nguyên thủ hai nước thân mật bắt tay chụp ảnh lưu niệm tại sảnh đón trải thảm đỏ, khoảnh khắc lịch sử này đánh dấu quan hệ đối tác hợp tác chiến lược toàn diện song phương bước sang trang mới rạng rỡ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3206,
    hanzi: '无关',
    pinyin: 'wúguān',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'không liên quan, vô can',
    examples: [
      {
        chinese: '请大家在学术研讨中紧扣核心议题发言，不要提及与会议主题无关的内容。',
        pinyin: 'Qǐng dàjiā zài xuéshù yántǎo zhōng jǐnkòu héxīn yìtí fāyán, bùyào tíjí yǔ huìyì zhǔtí wúguān de nèiróng.',
        meaning_vi: 'Xin mời mọi người trong buổi tọa đàm học thuật hãy bám sát chủ đề cốt lõi để phát biểu, không đề cập đến những nội dung không liên quan đến chủ đề cuộc họp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '司法审判机关严格遵循排除合理怀疑的法定证明标准，任何与案件关键事实认定无关的推测性证言均不具有法律效力。',
        pinyin: 'Sīfǎ shěnpàn jīgòu yángé zūnxún páichú hélǐ huáiyí de fǎdìng zhèngmíng biāozhǔn, rènhé yǔ ànjiàn guānjiàn shìshí rèndìng wúguān de tuīcèxìng zhèngyán jūn bù jùyǒu fǎlǜ xiàolì.',
        meaning_vi: 'Cơ quan xét xử tư pháp tuân thủ nghiêm ngặt chuẩn mực chứng minh theo luật định loại trừ mọi nghi ngờ hợp lý, bất kỳ lời khai mang tính suy đoán nào không liên quan đến việc xác định sự thật trọng yếu của vụ án đều không có giá trị pháp lý.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3207,
    hanzi: '无奈',
    pinyin: 'wúnài',
    word_type: 'Tính từ / Liên từ',
    meaning_vi: 'bất lực, đành chịu, không còn cách nào; ngặt nỗi',
    examples: [
      {
        chinese: '面对突如其来的倾盆大雨，没有带伞的游客们只能无奈地站在屋檐下避雨。',
        pinyin: 'Miànduì tūrúqílái de qīngpén dàyǔ, méiyǒu dài sǎn de yóukèmen zhǐ néng wúnài de zhàn zài wūyán xià bìyǔ.',
        meaning_vi: 'Đối mặt với cơn mưa như trút nước bất ngờ ập đến, các du khách không mang theo ô chỉ đành bất lực đứng dưới mái hiên trú mưa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对严峻的外部供应链断供风险与不可抗力关税壁垒，跨国实体企业不得不做出无奈的产能区域重组抉择。',
        pinyin: 'Miànduì yánjùn de wàibù gōngyìngliàn duàngōng fēngxiǎn yǔ bùkěkànglì guānshuì bìlěi, kuàguó shítǐ qǐyè bùdébù zuòchū wúnài de chǎnnéng qūyù chóngzǔ juézé.',
        meaning_vi: 'Đối mặt với rủi ro đứt gãy chuỗi cung ứng bên ngoài gay gắt và các rào cản thuế quan bất khả kháng, các doanh nghiệp thực thể đa quốc gia buộc phải đưa ra lựa chọn tái cơ cấu năng lực sản xuất khu vực đầy bất đắc dĩ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3208,
    hanzi: '无数',
    pinyin: 'wúshù',
    word_type: 'Tính từ',
    meaning_vi: 'vô số, vô vàn, không đếm xuể',
    examples: [
      {
        chinese: '仰望晴朗的夏夜星空，无数颗璀璨的繁星在深蓝色的天幕中闪烁。',
        pinyin: 'Yǎngwàng qínglǎng de xiàyè xīngkōng, wúshù kē cuǐcàn de fánxīng zài shēnlánsè de tiānmù zhōng shǎnshuò.',
        meaning_vi: 'Ngước nhìn bầu trời sao mùa hè trong trẻo, vô số vì sao lấp lánh tỏa sáng trên nền trời xanh thẫm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '每一项国之重器与重大基础工程的成功问世，背后都凝聚着无数一线科研攻关人员夜以继日的奋斗心血。',
        pinyin: 'Měi yī xiàng guózhīzhòngqì yǔ zhòngdà jīchǔ gōngchéng de chénggōng wènshì, bèihòu dōu níngjù zhe wúshù yīxiàn kēyán gōngguān rényuán yèyǐjìrì de fèndòu xīnxuè.',
        meaning_vi: 'Mỗi một vũ khí trọng khí quốc gia và công trình hạ tầng trọng đại ra đời thành công, phía sau đều kết tinh tâm huyết phấn đấu ngày đêm không ngừng nghỉ của vô số cán bộ nghiên cứu khoa học trực tiếp nơi tiền tuyến.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3209,
    hanzi: '无限',
    pinyin: 'wúxiàn',
    word_type: 'Tính từ',
    meaning_vi: 'vô hạn, vô cùng, không giới hạn',
    examples: [
      {
        chinese: '科学探索的过程充满了未知的奥秘，也给青年学生带来了无限的想象空间。',
        pinyin: 'Kēxué tànsuǒ de guòchéng chōngmǎn le wèizhī de àomì, yě gěi qīngnián xuéshēng dài lái le wúxiàn de xiǎngxiàng kōngjiān.',
        meaning_vi: 'Quá trình thám hiểm khoa học tràn ngập những bí ẩn chưa biết, đồng thời cũng mang lại cho các bạn học sinh trẻ không gian tưởng tượng vô tận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着生成式人工智能与空间计算技术的加速深度融合，未来数字文化创意产业展现出无限广阔的商业应用潜能。',
        pinyin: 'Suízhe shēngchéngshì réngōng zhìnéng yǔ kōngjiān jìsuàn jìshù de jiāsù shēndù rónghé, wèilái shùzì wénhuà chuàngyì chǎnyè zhǎnxiàn chū wúxiàn guǎngkuò de shāngyè yìngyòng qiánnéng.',
        meaning_vi: 'Cùng với sự tích hợp sâu rộng và tăng tốc của AI tạo sinh và công nghệ tính toán không gian, ngành công nghiệp sáng tạo văn hóa số trong tương lai phô diễn tiềm năng ứng dụng thương mại vô cùng rộng mở.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3210,
    hanzi: '无效',
    pinyin: 'wúxiào',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'vô hiệu, không có tác dụng, mất hiệu lực',
    examples: [
      {
        chinese: '如果没有加盖公章或缺少法定代表人签字，这份商业协议将被视作无效。',
        pinyin: 'Rúguǒ méiyǒu jiāgài gōngzhāng huò quēshǎo fǎdìng dàibiǎorén qiānzì, zhè fèn shāngyè xiéyì jiāng bèi shìzuò wúxiào.',
        meaning_vi: 'Nếu không đóng dấu mộc công ty hoặc thiếu chữ ký của người đại diện theo pháp luật, thỏa thuận thương mại này sẽ bị coi là vô hiệu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '劳动人事争议仲裁委员会依法作出裁决，用人单位单方面制定的排除劳动者法定社保待遇的免责格式条款自始无效。',
        pinyin: 'Láodòng rénshì zhēngyì zhòngcái wěiyuánhuì yīfǎ zuòchū cáijué, yòngrén dānwèi dān fāngmiàn zhìdìng de páichú láodòngzhě fǎdìng shèbǎo dàiyù de miǎnzé géshì tiáokuǎn zìshǐ wúxiào.',
        meaning_vi: 'Hội đồng trọng tài tranh chấp lao động ra phán quyết theo luật định, điều khoản biểu mẫu miễn trừ do người sử dụng lao động đơn phương lập ra nhằm loại trừ chế độ bảo hiểm xã hội hợp pháp của người lao động là hoàn toàn vô hiệu ngay từ đầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3211,
    hanzi: '舞蹈',
    pinyin: 'wǔdǎo',
    word_type: 'Danh từ',
    meaning_vi: 'vũ đạo, điệu múa, khiêu vũ',
    examples: [
      {
        chinese: '她从小练习中国古典舞蹈，优美轻盈的舞姿总能赢得观众阵阵热烈的掌声。',
        pinyin: 'Tā cóngxiǎo liànxí Zhōngguó gǔdiǎn wǔdǎo, yōuměi qīngyíng de wǔzī zǒng néng yíngdé guānzhòng zhènzhèn rèliè de zhǎngshēng.',
        meaning_vi: 'Cô ấy từ nhỏ đã rèn luyện vũ đạo cổ điển Trung Quốc, dáng múa thanh thoát uyển chuyển luôn nhận được từng tràng pháo tay nồng nhiệt từ khán giả.',
        difficulty_level: 'basic'
      },
      {
        chinese: '这部大型原创民族舞剧融汇了当代先锋舞台美学与非遗传统舞蹈语汇，在国际艺术节巡演中获得了极高的声誉。',
        pinyin: 'Zhè bù dàxíng yuánchuàng mínzú wǔjù rónghuì le dāngdài xiānfēng wǔtái měixué yǔ fēiyí chuántǒng wǔdǎo yǔhuì, zài guójì yìshùjié xúnyǎn zhōng huòdé le jí gāo de shēngyù.',
        meaning_vi: 'Vở kịch múa dân tộc nguyên tác quy mô lớn này kết hợp mỹ học sân khấu tiên phong đương đại với ngôn ngữ vũ đạo truyền thống di sản phi vật thể, đã giành được uy tín rất cao trong các chuyến lưu diễn tại các liên hoan nghệ thuật quốc tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3212,
    hanzi: '武术',
    pinyin: 'wǔshù',
    word_type: 'Danh từ',
    meaning_vi: 'võ thuật',
    examples: [
      {
        chinese: '练习中国传统武术不仅能强身健体，还能锤炼坚韧不拔的意志品质。',
        pinyin: 'Liànxí Zhōngguó chuántǒng wǔshù bùjǐn néng qiángshēn jiàntǐ, hái néng chuíliàn jiānrèn bùbá de yìzhì pǐnzhì.',
        meaning_vi: 'Luyện tập võ thuật truyền thống Trung Hoa không chỉ giúp cường thân kiện thể, mà còn tôi luyện phẩm chất ý chí kiên định kiên cường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际武术联合会正全力推进武术套路与散打竞技规则的标准化与国际化表达，助力武术运动早日列入夏季奥运会正式比赛项目。',
        pinyin: 'Guójì wǔshù liánhéhuì zhèng quánlì tuījìn wǔshù tàolù yǔ sǎndǎ jìngjì guīzé de biāozhǔnhuà yǔ guójìhuà biǎodá, zhùlì wǔshù yùndòng zǎorì liè rù xiàjì Àoyùnhuì zhèngshì bǐsài xiàngmù.',
        meaning_vi: 'Liên đoàn Võ thuật Quốc tế đang nỗ lực thúc đẩy tiêu chuẩn hóa và diễn đạt quốc tế hóa các quy tắc thi đấu quyền thuật và đối kháng tán thủ, trợ lực để môn võ thuật sớm được đưa vào danh mục thi đấu chính thức của Thế vận hội Mùa hè.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3213,
    hanzi: '舞台',
    pinyin: 'wǔtái',
    word_type: 'Danh từ',
    meaning_vi: 'sân khấu, vũ đài',
    examples: [
      {
        chinese: '聚光灯照亮了舞台中央，年轻的钢琴家从容自信地走上台向观众鞠躬致意。',
        pinyin: 'Jùguāngdēng zhàoliàng le wǔtái zhōngyāng, niánqīng de gāngqínjiā cóngróng zìxìn de zǒu shàng tái xiàng guānzhòng jūgōng zhìyì.',
        meaning_vi: 'Ánh đèn rọi sáng bừng chính giữa sân khấu, nghệ sĩ dương cầm trẻ tuổi ung dung tự tin bước lên sân khấu cúi chào cảm ơn khán giả.',
        difficulty_level: 'basic'
      },
      {
        chinese: '更加开放包容的发展格局正推动本土高新科技企业昂首阔步走向世界经济大舞台，深度参与全球产业技术标准的制定。',
        pinyin: 'Gèngjiā kāifàng bāoróng de fāzhǎn géjú zhèng tuīdòng běntǔ gāoxīn kējì qǐyè ángshǒu-kuòbù zǒuxiàng shìjiè jīngjì dà wǔtái, shēndù cānyù quánqiú chǎnyè jìshù biāozhǔn de zhìdìng.',
        meaning_vi: 'Cục diện phát triển ngày càng cởi mở và bao dung đang thúc đẩy các doanh nghiệp công nghệ cao bản địa hiên ngang sải bước vươn ra vũ đài kinh tế thế giới rộng lớn, tham gia sâu sắc vào việc thiết lập các tiêu chuẩn kỹ thuật công nghiệp toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3214,
    hanzi: '五颜六色',
    pinyin: 'wǔyán-liùsè',
    word_type: 'Thành ngữ / Tính từ',
    meaning_vi: 'ngũ nhan lục sắc, đủ màu sắc sặc sỡ, rực rỡ sắc màu',
    examples: [
      {
        chinese: '春天到了，公园的花坛里盛开着五颜六色的鲜花，吸引了成群的蜜蜂和蝴蝶。',
        pinyin: 'Chūntiān dào le, gōngyuán de huātán lǐ shèngkāi zhe wǔyán-liùsè de xiānhuā, xīyǐn le chéngqún de mìfēng hé húdié.',
        meaning_vi: 'Mùa xuân đã đến, trong các bồn hoa của công viên nở rộ những bông hoa tươi đủ màu sắc sặc sỡ, thu hút từng đàn ong bướm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '漫步于民族传统手工艺博览会，展厅内陈列的五颜六色的非遗扎染刺绣艺术品，展现出多民族文化的绚丽魅力。',
        pinyin: 'Mànbù yú mínzú chuántǒng shǒugōngyì bólǎnhuì, zhǎntīng nèi chénliè de wǔyán-liùsè de fēiyí zhārǎn cìxiù yìshùpǐn, zhǎnxiàn chū duō mínzú wénhuà de xuànlì mèilì.',
        meaning_vi: 'Dạo bước tại Hội chợ triển lãm thủ công mỹ nghệ truyền thống dân tộc, các tác phẩm nghệ thuật thêu thùa nhuộm buộc di sản phi vật thể đa sắc màu rực rỡ trưng bày trong gian phòng phô diễn sức quyến rũ hoa lệ của nền văn hóa đa dân tộc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3215,
    hanzi: '雾',
    pinyin: 'wù',
    word_type: 'Danh từ',
    meaning_vi: 'sương mù, khói mù',
    examples: [
      {
        chinese: '冬天的清晨常常会起大雾，高速公路能见度较低，驾驶机动车时必须减速慢行。',
        pinyin: 'Dōngtiān de qīngchén chángcháng huì qǐ dà wù, gāosù gōnglù néngjiàndù jiào dī, jiàshǐ jīdòngchē shí bìxū jiǎnsù mànxíng.',
        meaning_vi: 'Sáng sớm mùa đông thường hay xuất hiện sương mù dày đặc, tầm nhìn trên đường cao tốc khá thấp, khi lái xe cơ giới nhất định phải giảm tốc độ đi chậm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '气象水文科研监测团队利用微波辐射计与激光雷达探空技术，对近海海雾的生消演化规律开展高时空分辨率数值模拟与预警。',
        pinyin: 'Qìxiàng shuǐwén kēyán jiāncè tuánduì lìyòng wēibō fúshèjì yǔ jīguāng léidá tànkōng jìshù, duì jìnhǎi hǎiwù de shēng-xiāo yǎnhuà guīlǜ kāizhǎn gāo shíkōng fēnbànlǜ shùzhí mónǐ yǔ yùjǐng.',
        meaning_vi: 'Đội ngũ nghiên cứu giám sát khí tượng thủy văn tận dụng máy đo bức xạ vi sóng và kỹ thuật lidar thám trắc không gian để thực hiện mô phỏng số và cảnh báo độ phân giải cao theo không gian - thời gian về quy luật hình thành, tiêu tan của sương mù trên vùng biển ven bờ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3216,
    hanzi: '物价',
    pinyin: 'wùjià',
    word_type: 'Danh từ',
    meaning_vi: 'vật giá, giá cả hàng hóa tiêu dùng',
    examples: [
      {
        chinese: '近年来粮油、蔬菜和肉类等民生物价保持平稳，极大便利了居民的日常生活。',
        pinyin: 'Jìnniánlái liángyóu, shūcài hé ròulèi děng mínshēng wùjià bǎochí píngwěn, jídà biànlì le jūmín de rìcháng shēnghuó.',
        meaning_vi: 'Những năm gần đây giá cả các mặt hàng dân sinh như lương thực thực phẩm, rau củ và thịt luôn giữ mức bình ổn, tạo thuận lợi lớn cho đời sống thường ngày của người dân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对严峻复杂的外部输入性通胀压力，宏观调控部门多措并举畅通大宗商品供给链，全力维持总体物价水平基本平稳。',
        pinyin: 'Miànduì yánjùn fùzá de wàibù shūrùxìng tōngzhàng yālì, hóngguān tiáokòng bùmén duō cuò bìng jǔ chàngtōng dàzōng shāngpǐn gōngjǐliàn, quánlì wéichí zǒngtǐ wùjià shuǐpíng jīběn píngwěn.',
        meaning_vi: 'Đối mặt với áp lực lạm phát nhập khẩu từ bên ngoài gay gắt phức tạp, các cơ quan điều tiết vĩ mô triển khai đồng bộ nhiều giải pháp khơi thông chuỗi cung ứng hàng hóa cơ bản, dốc toàn lực duy trì mặt bằng vật giá tổng thể cơ bản bình ổn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3217,
    hanzi: '物理',
    pinyin: 'wùlǐ',
    word_type: 'Danh từ',
    meaning_vi: 'vật lý, môn vật lý; nguyên lý cơ học vật chất',
    examples: [
      {
        chinese: '他在中学阶段就对物理实验产生了浓厚兴趣，课余时间经常动手制作简易电路模型。',
        pinyin: 'Tā zài zhōngxué jiēduàn jiù duì wùlǐ shíyàn chǎnshēng le nónghòu xìngqù, kèyú shíjiān chángcháng dòngshǒu zhìzuò jiǎnyì diànlù móxíng.',
        meaning_vi: 'Cậu ấy ngay từ thời trung học đã nảy sinh niềm say mê sâu sắc với các thí nghiệm vật lý, thời gian ngoài giờ học thường tự tay chế tạo các mô hình mạch điện đơn giản.',
        difficulty_level: 'basic'
      },
      {
        chinese: '凝聚态物理与拓扑量子物态的前沿理论突破，为下一代低能耗室温超导芯片与量子计算机硬件的研制开辟了全新路径。',
        pinyin: 'Níngjùtài wùlǐ yǔ tuòpū liàngzǐ wùtài de qiányán lǐlùn tūpò, wèi xiàyīdài dīnénghào shìwēn chāodǎo xīnpiàn yǔ liàngzǐ jìsuànjī yìngjiàn de yánzhì kāipì le quánxīn lùjìng.',
        meaning_vi: 'Những đột phá lý thuyết tiền duyên trong vật lý chất ngưng tụ và trạng thái lượng tử tô-pô đã mở ra con đường hoàn toàn mới cho việc nghiên cứu chế tạo chip siêu dẫn nhiệt độ phòng tiêu hao năng lượng thấp và phần cứng máy tính lượng tử thế hệ tiếp theo.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3218,
    hanzi: '物品',
    pinyin: 'wùpǐn',
    word_type: 'Danh từ',
    meaning_vi: 'vật phẩm, đồ đạc, hàng hóa',
    examples: [
      {
        chinese: '乘客乘坐公共交通工具出行时，必须将随身携带的行李物品放置在安检机上接受检查。',
        pinyin: 'Chéngkè chéngzuò gōnggòng jiāotōng gōngjù chūxíng shí, bìxū jiāng suíshēn xiédài de xínglǐ wùpǐn fàngzhì zài ānjiǎnjī shàng jiēshòu jiǎnchá.',
        meaning_vi: 'Hành khách khi đi lại bằng phương tiện giao thông công cộng bắt buộc phải đặt đồ đạc hành lý mang theo bên mình lên máy soi an ninh để tiếp nhận kiểm tra.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代智慧物流园区依托物联网射频识别与区块链溯源技术，实现高附加值医药物资和冷链食品物品的全流程闭环监管。',
        pinyin: 'Xiàndài zhìhuì wùliú yuánqū yītuō wùliánwǎng shèpín shíbié yǔ qūkuàiliàn sùyuán jìshù, shíxiàn gāofùjiāzhí yīyào wùzī hé lěngliàn shípǐn wùpǐn de quán-liúchéng bìhuán jiānguǎn.',
        meaning_vi: 'Khu công viên logistics thông minh hiện đại dựa trên công nghệ nhận dạng qua tần số vô tuyến RFID và truy xuất nguồn gốc blockchain để thực hiện việc giám sát khép kín toàn bộ quy trình các vật phẩm thực phẩm chuỗi lạnh và vật tư y tế giá trị gia tăng cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3219,
    hanzi: '物业',
    pinyin: 'wùyè',
    word_type: 'Danh từ',
    meaning_vi: 'quản lý tòa nhà, ban quản lý bất động sản/nhà đất',
    examples: [
      {
        chinese: '小区的物业管理非常规范，不仅保安人员全天巡逻，公共区域的绿化与卫生保洁也十分到位。',
        pinyin: 'Xiǎoqū de wùyè guǎnlǐ fēicháng guīfàn, bùjǐn bǎo’ān rényuán quántiān xúnluó, gōnggòng qūyù de lǜhuà yǔ wèishēng bǎojié yě shífēn dàowèi.',
        meaning_vi: 'Ban quản lý tòa nhà khu dân cư rất quy củ, không chỉ nhân viên bảo vệ tuần tra suốt ngày đêm, mà mảng cây xanh và vệ sinh làm sạch khu vực công cộng cũng rất chu đáo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '住房和城乡建设部门积极推动智慧物业融入基层社区精细化治理，依托移动端数字工单闭环提升物业应急维修响应效能。',
        pinyin: 'Zhùfáng hé chéng-xiāng jiànshè bùmén jījí tuīdòng zhìhuì wùyè róngrù jīcéng shèqū jīngxìhuà zhìlǐ, yītuō yídòngduān shùzì gōngdān bìhuán tíshēng wùyè yìngjí wéixiū xiǎngyìng xiàonéng.',
        meaning_vi: 'Bộ Xây dựng nhà ở và đô thị - nông thôn tích cực thúc đẩy ban quản lý tòa nhà thông minh hòa nhập vào quản trị tinh gọn cộng đồng cơ sở, dựa vào chu trình phiếu công tác số hóa trên thiết bị di động để nâng cao hiệu năng phản ứng sửa chữa khẩn cấp của bộ phận quản lý bất động sản.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3220,
    hanzi: '物质',
    pinyin: 'wùzhì',
    word_type: 'Danh từ',
    meaning_vi: 'vật chất, chất thể; điều kiện vật chất',
    examples: [
      {
        chinese: '随着国民经济的稳步持续增长，人民群众的物质生活水平得到了显著提高。',
        pinyin: 'Suízhe guómín jīngjì de wěnbù chíxù zēngzhǎng, rénmín qúnzhòng de wùzhì shēnghuó shuǐpíng dédào le xiǎnzhù tígāo.',
        meaning_vi: 'Cùng với sự tăng trưởng ổn định bền vững của nền kinh tế quốc dân, mức sống vật chất của quần chúng nhân dân đã được nâng cao rõ rệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高能物理大科学装置通过粒子高速对撞实验，致力于深入探索微观物质的基本结构与宇宙暗物质的神秘本质。',
        pinyin: 'Gāonéng wùlǐ dà kēxué zhuāngzhì tōngguò lìzǐ gāosù duìzhuàng shíyàn, zhìlì yú shēnrù tànsuǒ wēiguān wùzhì de jīběn jiégòu yǔ yǔzhòu ànwùzhì de shénmì běnzhì.',
        meaning_vi: 'Thiết bị khoa học lớn vật lý năng lượng cao thông qua các thí nghiệm va chạm hạt tốc độ cao dốc sức đi sâu khám phá cấu trúc cơ bản của vật chất vi mô và bản chất thần bí của vật chất tối trong vũ trụ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3221,
    hanzi: '西餐',
    pinyin: 'xīcān',
    word_type: 'Danh từ',
    meaning_vi: 'món ăn phương Tây, đồ ăn Tây',
    examples: [
      {
        chinese: '周末晚上，一家人来到市中心的一家法式餐厅享用精致美味的西餐。',
        pinyin: 'Zhōumò wǎnshang, yījiārén lái dào shìzhōngxīn de yī jiā Fǎshì cāntīng xiǎngyòng jīngzhì měiwèi de xīcān.',
        meaning_vi: 'Tối cuối tuần, cả gia đình đến một nhà hàng Pháp ở trung tâm thành phố để thưởng thức bữa đồ ăn Tây tinh tế và thơm ngon.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际星级酒店餐饮行政总厨将东方传统草本香料与现代西餐低温慢煮分子料理技法相融合，打造出独具匠心的跨界美馔。',
        pinyin: 'Guójì xīngjí jiǔdiàn cānyǐn xíngzhèng zǒngchú jiāng Dōngfāng chuántǒng cǎoběn xiāngliào yǔ xiàndài xīcān dīwēn mànzhǔ fēnzǐ liàolǐ jìfǎ xiāng rónghé, dǎzào chū dújù-jiàngxīn de kuàjiè měizhuàn.',
        meaning_vi: 'Bếp trưởng điều hành ẩm thực của khách sạn đẳng cấp quốc tế kết hợp các loại hương liệu thảo mộc truyền thống phương Đông với kỹ thuật ẩm thực phân tử nấu chậm nhiệt độ thấp của món Tây hiện đại, tạo nên những món mỹ vị giao thoa độc đáo đầy sáng tạo.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3222,
    hanzi: '吸管',
    pinyin: 'xīguǎn',
    word_type: 'Danh từ',
    meaning_vi: 'ống hút',
    examples: [
      {
        chinese: '为了减少白色塑料污染，越来越多的奶茶店和咖啡馆开始主动向顾客提供纸质吸管。',
        pinyin: 'Wèile jiǎnshǎo báisè sùliào wūrǎn, yuèláiyuè duō de nǎichádiàn hé kāfēiguǎn kāishǐ zhǔdòng xiàng gùkè tígōng zhǐzhì xīguǎn.',
        meaning_vi: 'Để giảm bớt ô nhiễm rác thải nhựa trắng, ngày càng nhiều quán trà sữa và quán cà phê bắt đầu chủ động cung cấp ống hút giấy cho khách hàng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为积极贯彻国家“限塑禁塑”环保政策，食品包装制造企业加速规模化生产以聚乳酸为基材的全生物降解环保吸管。',
        pinyin: 'Wèi jījí guànchè guójiā “xiànsù jīnsù” huánbǎo zhèngcè, shípǐn bāozhuāng zhìzào qǐyè jiāsù guīmóhuà shēngchǎn yǐ jùrǔsuān wéi jīcái de quán-shēngwù jiàngjiě huánbǎo xīguǎn.',
        meaning_vi: 'Nhằm quán triệt tích cực chính sách bảo vệ môi trường "hạn chế và cấm đồ nhựa" của quốc gia, các doanh nghiệp sản xuất bao bì thực phẩm đẩy nhanh sản xuất quy mô lớn ống hút thân thiện với môi trường tự phân hủy sinh học hoàn toàn trên nền chất liệu axit polylactic (PLA).',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3223,
    hanzi: '吸收',
    pinyin: 'xīshōu',
    word_type: 'Động từ',
    meaning_vi: 'hấp thu, tiếp thu, hút, thu nạp',
    examples: [
      {
        chinese: '绿色植物通过光合作用吸收空气中的二氧化碳，并释放出维持生命所必需的氧气。',
        pinyin: 'Lǜsè zhíwù tōngguò guānghé zuòyòng xīshōu kōngqì zhōng de èryǎnghuàtàn, bìng shìfàng chū wéichí shēngmìng suǒ bìxū de yǎngqì.',
        meaning_vi: 'Cây xanh thông qua quá trình quang hợp hấp thu khí CO2 trong không khí và giải phóng ra lượng khí oxy cần thiết duy trì sự sống.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高新区科技孵化平台积极支持本土高新技术企业在消化吸收引进的先进技术基础上，实施全链条自主知识产权再创新。',
        pinyin: 'Gāoxīnqū kējì fūhuà píngtái jījí zhīchí běntǔ gāoxīnjìshù qǐyè zài xiāohuà xīshōu yǐnjìn de xiānjìn jìshù jīchǔ shàng, shíshī quán-liàntiáo zìzhǔ zhīshi chǎnquán zàichuàngxīn.',
        meaning_vi: 'Nền tảng ươm tạo công nghệ khu công nghệ cao tích cực ủng hộ các doanh nghiệp công nghệ cao bản địa trên cơ sở tiêu hóa hấp thụ công nghệ tiên tiến nhập khẩu thực hiện tái đổi mới sáng tạo sở hữu trí tuệ tự chủ toàn diện theo chuỗi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3224,
    hanzi: '西装',
    pinyin: 'xīzhuāng',
    word_type: 'Danh từ',
    meaning_vi: 'âu phục, bộ com-lê, áo vest',
    examples: [
      {
        chinese: '参加正式的国际学术交流会议时，男士通常需要穿着整洁得体的西装。',
        pinyin: 'Cānjiā zhèngshì de guójì xuéshù jiāoliú huìyì shí, nánshì tōngcháng xūyào chuānzhuó zhěngjié détǐ de xīzhuāng.',
        meaning_vi: 'Khi tham gia hội nghị giao lưu học thuật quốc tế trang trọng, nam giới thông thường cần mặc bộ âu phục gọn gàng và chỉnh tề.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高级定制服饰工坊甄选进口顶级纯天然羊绒面料，结合传统手工全麻衬工艺，为商界领袖量身剪裁挺括舒适的高端商务西装。',
        pinyin: 'Gāojí dìngzhì fúshì gōngfāng zhēnxuǎn jìnkǒu dǐngjí chún-tiānrán yángróng miànliào, jiéhé chuántǒng shǒugōng quán-máchèn gōngyì, wèi shāngjiè lǐngxiù liángshēn jiǎncái tǐngguò shūshì de gāoduān shāngwù xīzhuāng.',
        meaning_vi: 'Xưởng may phục trang cao cấp tuyển chọn vải cashmere thuần tự nhiên thượng hạng nhập khẩu, kết hợp kỹ thuật may lót canvas hoàn toàn thủ công truyền thống để cắt may đo ni đóng giày những bộ vest doanh nhân cao cấp đứng dáng và êm ái cho các nhà lãnh đạo thương giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3225,
    hanzi: '戏',
    pinyin: 'xì',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'vở kịch, tuồng, sân khấu kịch; trêu đùa, diễn trò',
    examples: [
      {
        chinese: '周末爷爷总喜欢坐在老藤椅上，一边喝着热茶一边听收音机里播放的传统京剧戏曲。',
        pinyin: 'Zhōumò yéye zǒng xǐhuan zuò zài lǎo téngyǐ shàng, yībiān hē zhe rèchá yībiān tīng shōuyīnjī lǐ bōfàng de chuántǒng Jīngjù xìqǔ.',
        meaning_vi: 'Cuối tuần ông nội luôn thích ngồi trên chiếc ghế mây cũ, vừa nhâm nhi chén trà nóng vừa nghe những vở tuồng kinh kịch truyền thống phát trên radio.',
        difficulty_level: 'basic'
      },
      {
        chinese: '传统戏剧院团通过数字化全息舞台投影与现代跨界剧场叙事，让古老的地方戏重新焕发出时代活力并成功吸引广大年轻观众。',
        pinyin: 'Chuántǒng xìjù yuàntuán tōngguò shùzìhuà quánxī wǔtái tóuyǐng yǔ xiàndài kuàjiè jùchǎng xùshì, ràng gǔlǎo de dìfāngxì chóngxīn huànfā chū shídài huólì bìng chénggōng xīyǐn guǎngdà niánqīng guānzhòng.',
        meaning_vi: 'Đoàn kịch nghệ truyền thống thông qua công nghệ trình chiếu sân khấu hologram kỹ thuật số và lối tự sự nhà hát giao thoa hiện đại, đã giúp cho những vở tuồng địa phương cổ xưa hồi sinh mạnh mẽ sức sống thời đại và thu hút thành công đông đảo khán giả trẻ tuổi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3226,
    hanzi: '系',
    pinyin: 'xì',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'khoa (đại học), hệ thống; thắt, buộc',
    examples: [
      {
        chinese: '他大学毕业于计算机软件工程系，随后进入了一家知名科技企业从事系统架构研发。',
        pinyin: 'Tā dàxué bìyè yú jìsuànjī ruǎnjiàn gōngchéng xì, suíhòu jìnrù le yī jiā zhīmíng kējì qǐyè cóngshì xìtǒng jiàgòu yánfā.',
        meaning_vi: 'Anh ấy tốt nghiệp đại học khoa kỹ thuật phần mềm máy tính, sau đó vào làm việc tại một doanh nghiệp công nghệ nổi tiếng phụ trách nghiên cứu phát triển kiến trúc hệ thống.',
        difficulty_level: 'basic'
      },
      {
        chinese: '无论乘坐私家车还是长途客车出行，乘车人员全员全程规范系好安全带是防范交通意外伤亡最直接有效的生命防线。',
        pinyin: 'Wúlùn chéngzuò sījiāchē háishi chángtú kèchē chūxíng, chéngchē rényuán quányuán quánchéng guīfàn xì hǎo ānquándài shì fángfàn jiāotōng yìwài shāngwáng zuì zhíjiē yǒuxiào de shēngmìng fángxiàn.',
        meaning_vi: 'Dù đi lại bằng xe con riêng hay xe khách đường dài, toàn bộ người ngồi trên xe thắt dây an toàn đúng quy cách trong suốt hành trình chính là tuyến phòng thủ sự sống hữu hiệu và trực tiếp nhất để ngăn ngừa thương vong tai nạn giao thông.',
        difficulty_level: 'applied'
      }
    ]
  }
]
