// data/hsk5-batch8-part3-data.ts
// 25 từ HSK 5: #2752 [毛笔] -> #2776 [明确]

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

export const HSK5_BATCH8_PART3: VocabItem[] = [
  {
    id: 2752,
    hanzi: '毛笔',
    pinyin: 'máobǐ',
    word_type: 'Danh từ',
    meaning_vi: 'bút lông (viết thư pháp/vẽ tranh)',
    examples: [
      {
        chinese: '练习中国书法需要先学会正确的手握毛笔姿势。',
        pinyin: 'Liànxí Zhōngguó shūfǎ xūyào xiān xuéhuì zhèngquè de shǒu wò máobǐ zīshì.',
        meaning_vi: 'Luyện tập thư pháp Trung Quốc cần phải học được tư thế cầm bút lông đúng cách trước tiên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '宣笔作为文房四宝之首，其手工制作技艺讲究尖、齐、圆、健四大德性，在传统水墨写意丹青中具有不可替代的艺术表现力。',
        pinyin: 'Xuānbǐ zuòwéi wénfáng-sìbǎo zhī shǒu, qí shǒugōng zhìzuò jìyì jiǎngjiu jiān, qí, yuán, jiàn sì dà déxìng, zài chuántǒng shuǐmò xièyì dānqīng zhōng jùyǒu bùkě-tìdài de yìshù biǎoxiànlì.',
        meaning_vi: 'Bút lông Tuyên Châu với vị thế đứng đầu văn phòng tứ bảo, kỹ thuật chế tác thủ công rất chú trọng 4 đặc tính nhọn, đều, tròn, khỏe, có sức biểu đạt nghệ thuật không thể thay thế trong hội họa thủy mặc truyền thống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2753,
    hanzi: '毛病',
    pinyin: 'máobìng',
    word_type: 'Danh từ',
    meaning_vi: 'lỗi, tật, trục trặc, thói xấu',
    examples: [
      {
        chinese: '这台旧洗衣机最近总是出现排水不畅的毛病。',
        pinyin: 'Zhè tái jiù xǐyījī zuìjìn zǒngshì chūxiàn páishuǐ bú chàng de máobìng.',
        meaning_vi: 'Chiếc máy giặt cũ này gần đây hay gặp trục trặc thoát nước không trôi chảy.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在大型复杂软件系统上线前，测试工程师必须反复进行全方位压力测试，坚决查出并消除所有潜在的逻辑毛病与安全漏洞。',
        pinyin: 'Zài dàxíng fùzá ruǎnjiàn xìtǒng shàngxiàn qián, cèshì gōngchéngshī bìxū fǎnfù jìnxíng quán fāngwèi yālì cèshì, jiānjué cháchū bìng xiāochú suǒyǒu qiánzài de luójí máobìng yǔ ānquán lòudòng.',
        meaning_vi: 'Trước khi hệ thống phần mềm lớn và phức tạp đi vào vận hành thực tế, các kỹ sư kiểm thử phần mềm phải kiểm tra chịu tải toàn diện nhiều lần, kiên quyết tìm ra và triệt tiêu tất cả các lỗi logic tiềm ẩn cùng lỗ hổng an ninh mạng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2754,
    hanzi: '矛盾',
    pinyin: 'máodùn',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'mâu thuẫn; mâu thuẫn xung đột',
    examples: [
      {
        chinese: '同学之间难免会产生一些小摩擦，只要坦诚沟通就能化解矛盾。',
        pinyin: 'Tóngxué zhījiān nánmiǎn huì chǎnshēng yìxiē xiǎo mócā, zhǐyào tǎnchéng gōutōng jiù néng huàjiě máodùn.',
        meaning_vi: 'Giữa các bạn học sinh khó tránh khỏi nảy sinh chút va chạm nhỏ, chỉ cần giao tiếp chân thành là có thể hóa giải mâu thuẫn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '如何兼顾经济高速增长与生态环境保护之间的复杂关系，是现代国家治理中必须妥善协调处理的一对根本矛盾。',
        pinyin: 'Rúhé jiāngù jīngjì gāosù zēngzhǎng yǔ shēngtài huánjìng bǎohù zhījiān de fùzá guānxì, shì xiàndài guójiā zhìlǐ zhōng bìxū tuǒshàn xiétiáo chǔlǐ de yí duì gēnběn máodùn.',
        meaning_vi: 'Làm thế nào để dung hòa mối quan hệ phức tạp giữa tăng trưởng kinh tế tốc độ cao và bảo vệ môi trường sinh thái là một cặp mâu thuẫn căn bản đòi hỏi phải được điều phối xử lý thỏa đáng trong quản trị quốc gia hiện đại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2755,
    hanzi: '没法儿',
    pinyin: 'méifǎr',
    word_type: 'Động từ',
    meaning_vi: 'không có cách nào, bó tay, hết cách',
    examples: [
      {
        chinese: '外面的暴风雨实在太大了，我们今天没法儿按原计划出门去爬山了。',
        pinyin: 'Wàimiàn de bàofēngyǔ shízài tài dà le, wǒmen jīntiān méifǎr àn yuán jìhuà chūmén qù páshān le.',
        meaning_vi: 'Mưa bão bên ngoài thực sự quá lớn, hôm nay chúng tôi không có cách nào ra ngoài leo núi theo kế hoạch ban đầu được nữa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '如果没有底层芯片与基础软件工具链的自主可控，高端工业自动化设备在面临供应链断供时就根本没法儿正常维持生产。',
        pinyin: 'Rúguǒ méiyǒu dǐcéng xīnpiàn yǔ jīchǔ ruǎnjiàn gōngjùliàn de zìzhǔ kěkòng, gāoduān gōngyè zìdònghuà shèbèi zài miànlín gōngyìngliàn duàngōng shí jiù gēnběn méifǎr zhèngcháng wéichí shēngchǎn.',
        meaning_vi: 'Nếu không có sự tự chủ kiểm soát về chip nền tảng và chuỗi công cụ phần mềm cơ sở, các thiết bị tự động hóa công nghiệp cao cấp khi đối mặt với đứt gãy chuỗi cung ứng sẽ hoàn toàn không có cách nào duy trì sản xuất bình thường.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2756,
    hanzi: '玫瑰',
    pinyin: 'méigui',
    word_type: 'Danh từ',
    meaning_vi: 'hoa hồng',
    examples: [
      {
        chinese: '情人节那天，花店里的红玫瑰和粉玫瑰十分畅销。',
        pinyin: 'Qíngrénjié nà tiān, huādiàn lǐ de hóng méigui hé fěn méigui shífēn chàngxiāo.',
        meaning_vi: 'Vào ngày lễ Tình nhân, hoa hồng đỏ và hoa hồng phấn trong tiệm hoa bán rất chạy.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高原冷凉气候非常适宜高品质大马士革玫瑰的有机种植，深加工提取的高纯度玫瑰精油已成为带动当地村民致富的支柱产业。',
        pinyin: 'Gāoyuán lěngliáng qìhòu fēicháng shìyí gāo pǐnzhì Dàmǎshìgé méigui de yǒujī zhòngzhí, shēnjiāgōng tíqǔ de gāo chúndù méigui jīngyóu yǐ chéngwéi dàidòng dāngdì cūnmín zhìfù de zhīzhù chǎnyè.',
        meaning_vi: 'Khí hậu mát lạnh vùng cao nguyên vô cùng thích hợp cho việc canh tác hữu cơ giống hoa hồng Damascus chất lượng cao, tinh dầu hoa hồng độ tinh khiết cao chiết xuất sau chế biến sâu đã trở thành ngành kinh tế trụ cột giúp bà con nông dân địa phương làm giàu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2757,
    hanzi: '媒体',
    pinyin: 'méitǐ',
    word_type: 'Danh từ',
    meaning_vi: 'truyền thông, phương tiện thông tin đại chúng',
    examples: [
      {
        chinese: '这起突发公共事件在各大社交媒体平台上引发了广泛热议。',
        pinyin: 'Zhè qǐ tūfā gōnggòng shìjiàn zài gè dà shèjiāo méitǐ píngtái shang yǐnfā le guǎnfàn rèyì.',
        meaning_vi: 'Vụ việc công cộng đột xuất này đã dấy lên làn sóng bàn luận sôi nổi rộng rãi trên các nền tảng mạng xã hội lớn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在全媒体融合发展的大趋势下，主流权威媒体必须牢牢把握正确的舆论导向，创新叙事表达方式以讲好中国发展故事。',
        pinyin: 'Zài quán méitǐ rónghé fāzhǎn de dà qūshì xià, zhǔliú quánwēi méitǐ bìxū láoláo bǎwò zhèngquè de yúlùn dǎoxiàng, chuàngxīn xùshì biǎodá fāngshì yǐ jiǎng hǎo Zhōngguó fāzhǎn gùshì.',
        meaning_vi: 'Dưới xu thế lớn về phát triển hội tụ đa phương tiện truyền thông, các cơ quan báo chí truyền thông chính thống uy tín phải nắm vững định hướng dư luận đúng đắn, đổi mới phương thức biểu đạt trần thuật để kể thật hay những câu chuyện phát triển của đất nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2758,
    hanzi: '美术',
    pinyin: 'měishù',
    word_type: 'Danh từ',
    meaning_vi: 'mỹ thuật, hội họa',
    examples: [
      {
        chinese: '他从小就在少年宫学习美术，练就了一手扎实的素描基本功。',
        pinyin: 'Tā cóngxiǎo jiù zài shàoniángōng xuéxí měishù, liànjiù le yì shǒu zhāshi de sùmiáo jīběngōng.',
        meaning_vi: 'Từ nhỏ anh ấy đã học mỹ thuật tại cung thiếu nhi, rèn luyện được kỹ năng hình họa chì cơ bản rất vững vàng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国美术馆举办的百年中国现代美术名家典藏特展，多维度呈现了现当代艺术家扎根人民生活的崇高美学追求。',
        pinyin: 'Zhōngguó Měishùguǎn jǔbàn de bǎi nián Zhōngguó xiàndài měishù míngjiā diǎncáng tèzhǎn, duō wéidù chéngxiàn le xiàn-dāngdài yìshùjiā zhāgēn rénmín shēnghuó de chónggāo měixué zhuīqiú.',
        meaning_vi: 'Triển lãm đặc biệt các bộ sưu tập kinh điển của danh gia mỹ thuật hiện đại Trung Quốc 100 năm do Bảo tàng Mỹ thuật Trung Quốc tổ chức, đã tái hiện đa chiều sự theo đuổi mỹ học cao quý bám rễ vào đời sống nhân dân của các nghệ sĩ cận hiện đại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2759,
    hanzi: '美味',
    pinyin: 'měiwèi',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'món ngon, mỹ vị; thơm ngon',
    examples: [
      {
        chinese: '经过一个多小时的细火慢炖，一锅香气扑鼻的美味鸡汤做好了。',
        pinyin: 'Jīngguò yí gè duō xiǎoshí de xìhuǒ màndùn, yì guō xiāngqì-pūbí de měiwèi jītāng zuò hǎo le.',
        meaning_vi: 'Qua hơn một tiếng đồng hồ ninh nhỏ lửa, một nồi canh gà thơm ngon nức mũi đã hoàn thành.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中华传统饮食文化兼具药膳同源的深厚智慧，以精湛的烹饪技艺将天然食材升华为抚慰人心的舌尖美味。',
        pinyin: 'Zhōnghuá chuántǒng yǐnshí wénhuà jiānjù yàoshàn-tóngyuán de shēnhòu zhìhuì, yǐ jīngzhàn de pēngrèn jìyì jiāng tiānrán shícái shēnghuá wéi fǔwèi rénxīn de shéjiān měiwèi.',
        meaning_vi: 'Văn hóa ẩm thực truyền thống Trung Hoa hàm chứa trí tuệ sâu sắc về sự đồng nguyên giữa dược liệu và món ăn, bằng kỹ nghệ nấu nướng tinh xảo đã nâng tầm các nguyên liệu tự nhiên thành những phong vị đầu lưỡi thơm ngon vỗ về lòng người.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2760,
    hanzi: '魅力',
    pinyin: 'mèilì',
    word_type: 'Danh từ',
    meaning_vi: 'sức quyến rũ, sức hút, mị lực',
    examples: [
      {
        chinese: '这座历史文化名城凭借古色古香的建筑展现出独特的东方魅力。',
        pinyin: 'Zhè zuò lìshǐ wénhuà míngchéng píngjiè gǔsè-gǔxiāng de jiànzhù zhǎnxiàn chū dútè de dōngfāng mèilì.',
        meaning_vi: 'Thành phố lịch sử văn hóa nổi tiếng này nhờ các công trình kiến trúc cổ kính trang nhã đã thể hiện sức quyến rũ phương Đông độc đáo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '古老博大的中华文明历经数千年风雨沧桑依然生机勃勃，向世界各国全方位彰显出跨越时空的深厚文化吸引力与永恒魅力。',
        pinyin: 'Gǔlǎo bódà de Zhōnghuá wénmíng lìjīng shù qiān nián fēngyǔ-cāngsāng yīrán shēngjī-bóbó, xiàng shìjiè gè guó quán fāngwèi zhāngxiǎn chū kuàyuè shíkōng de shēnhòu wénhuà xīyǐnlì yǔ yǒnghéng mèilì.',
        meaning_vi: 'Nền văn minh Trung Hoa cổ xưa uyên bác trải qua hàng nghìn năm dãi dầu dâu bể vẫn căng tràn nhựa sống, phô diễn trọn vẹn trước các quốc gia trên thế giới sức hút văn hóa sâu sắc vượt thời gian cùng mị lực trường tồn bất diệt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2761,
    hanzi: '门诊',
    pinyin: 'ménzhěn',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'khám ngoại trú, khoa khám bệnh',
    examples: [
      {
        chinese: '患者可以通过医院官方手机小程序提前预约专家门诊号。',
        pinyin: 'Huànzhě kěyǐ tōngguò yīyuàn guānfāng shǒujī xiǎochéngxù tíqián yùyuē zhuānjiā ménzhěnhào.',
        meaning_vi: 'Người bệnh có thể thông qua ứng dụng nhỏ chính thức của bệnh viện trên điện thoại để đặt trước số khám chuyên gia.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为切实解决基层偏远山区看病难问题，三甲医院常态化开设远程专家门诊，使山区群众在家门口就能享受到国家级权威诊疗服务。',
        pinyin: 'Wèi qièshí jiějué jīcéng piānyuǎn shānqū kànbìng nán wèntí, sānjiǎ yīyuàn chángtàihuà kāishè yuǎnchéng zhuānjiā ménzhěn, shǐ shānqū qúnzhòng zài jiā ménkǒu jiù néng xiǎngshòu dào guójiājí quánwēi zhěnliáo fúwù.',
        meaning_vi: 'Nhằm giải quyết thiết thực bài toán khó khăn khi đi khám chữa bệnh ở vùng cao hẻo lánh, các bệnh viện tuyến đầu định kỳ mở phòng khám chuyên gia từ xa, giúp bà con vùng cao ngay trước cửa nhà đã có thể thụ hưởng dịch vụ chẩn trị uy tín cấp quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2762,
    hanzi: '迷',
    pinyin: 'mí',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'mê, say mê; người hâm mộ (fan); lạc hướng',
    examples: [
      {
        chinese: '他是一个狂热的足球迷，几乎每场重大的国际足球比赛都不会错过。',
        pinyin: 'Tā shì yí gè kuángrè de zúqiúmí, jīhū měi chǎng zhòngdà de guójì zúqiú bǐsài dōu bú huì cuòguò.',
        meaning_vi: 'Anh ấy là một người hâm mộ bóng đá cuồng nhiệt, hầu như mọi trận cầu quốc tế quan trọng đều không bao giờ bỏ lỡ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对资本市场形形色色的概念炒作与短期投机诱惑，理性投资者必须保持清醒头脑，决不被表面的泡沫假象所迷惑。',
        pinyin: 'Miànduì zīběn shìchǎng xíngxíng-sèsè de gàiniàn chǎozuò yǔ duǎnqī tóujī yòuhuò, lǐxìng tóuzīzhě bìxū bǎochí qīngxǐng tóunǎo, jué bú bèi biǎomiàn de pàomò jiǎxiàng suǒ míhuò.',
        meaning_vi: 'Đứng trước muôn hình vạn trạng các chiêu trò thổi phồng khái niệm và cám dỗ đầu cơ ngắn hạn của thị trường vốn, nhà đầu tư lý trí cần giữ cho mình một cái đầu tỉnh táo, quyết không để những ảo ảnh bong bóng bề ngoài làm mê muội.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2763,
    hanzi: '迷路',
    pinyin: 'mílù',
    word_type: 'Động từ',
    meaning_vi: 'lạc đường, mất phương hướng',
    examples: [
      {
        chinese: '在没有网络信号的原始森林里徒步，很容易迷路失联。',
        pinyin: 'Zài méiyǒu wǎngluò xìnhào de yuánshǐ sēnlín lǐ túbù, hěn róngyì mílù shīlián.',
        meaning_vi: 'Đi bộ đường dài trong khu rừng nguyên sinh không có sóng mạng rất dễ bị lạc đường và mất liên lạc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '探险队在暴风雪肆虐的极地荒原深处不慎迷路，凭借北斗卫星短报文终端成功发出带有高精经纬度坐标的紧急求救信号。',
        pinyin: 'Tànxiǎnduì zài bàofēngxuě sìnüè de jídì huāngyuán shēnchù búshèn mílù, píngjiè Běidǒu wèixīng duǎnbàowén zhōngduān chénggōng fāchū dài yǒu gāojīng jīng-wěidù zuòbiāo de jǐnjí qiújiù xìnhào.',
        meaning_vi: 'Đội thám hiểm nơi hoang mạc vùng cực giữa bão tuyết hoành hành dữ dội sơ ý bị lạc đường, nhờ vào thiết bị tin nhắn ngắn vệ tinh Bắc Đẩu đã phát đi thành công tín hiệu cầu cứu khẩn cấp mang tọa độ kinh vĩ độ độ chính xác cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2764,
    hanzi: '秘密',
    pinyin: 'mìmì',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'bí mật, điều bí mật; bí mật kín đáo',
    examples: [
      {
        chinese: '好朋友之间要坦诚相待，保守彼此心中的秘密。',
        pinyin: 'Hǎo péngyou zhījiān yào tǎnchéng xiāngdài, bǎoshǒu bǐcǐ xīnzhōng de mìmì.',
        meaning_vi: 'Bạn tốt với nhau cần đối đãi chân thành, biết giữ kín những bí mật trong lòng của nhau.',
        difficulty_level: 'basic'
      },
      {
        chinese: '涉密科研单位必须严格执行国家保密法律法规，严防核心国防科研成果与尖端前沿技术商业秘密发生外泄。',
        pinyin: 'Shèmì kēyán dānwèi bìxū yángé zhíxíng guójiā bǎomì fǎlǜ fǎguī, yánfáng héxīn guófáng kēyán chéngguǒ yǔ jiānduān qiányán jìshù shāngyè mìmì fāshēng wàixiè.',
        meaning_vi: 'Các đơn vị nghiên cứu khoa học liên quan đến bí mật bắt buộc phải chấp hành nghiêm túc pháp luật quy chế bảo mật quốc gia, phòng ngừa nghiêm ngặt việc rò rỉ các thành quả nghiên cứu quốc phòng cốt lõi và bí mật thương mại công nghệ tiên phong đỉnh cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2765,
    hanzi: '密切',
    pinyin: 'mìqiè',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'mật thiết, chặt chẽ, gắn bó',
    examples: [
      {
        chinese: '气象部门正在密切监视今年第十二号台风的移动路径。',
        pinyin: 'Qìxiàng bùmén zhèngzài mìqiè jiānshì jīnnián dì-shí’èr hào táifēng de yídòng lùjìng.',
        meaning_vi: 'Cơ quan khí tượng đang theo dõi sát sao đường đi di chuyển của cơn bão số 12 trong năm nay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在应对全球公共卫生危机与跨国洗钱犯罪等非传统安全威胁时，国际刑警组织与各国执法部门必须保持高度密切的情报共享与行动协调。',
        pinyin: 'Zài yìngduì quánqiú gōnggòng wèishēng wēijī yǔ kuàguó xǐqián fànzuì děng fēichuántǒng ānquán wēixié shí, Guójì Xíngjǐng Zǔzhī yǔ gè guó zhífǎ bùmén bìxū bǎochí gāodù mìqiè de qíngbào gòngxiǎng yǔ xíngdòng xiétiáo.',
        meaning_vi: 'Khi ứng phó với các mối đe dọa an ninh phi truyền thống như khủng hoảng y tế công cộng toàn cầu và tội phạm rửa tiền xuyên quốc gia, Tổ chức Cảnh sát Hình sự Quốc tế cùng cơ quan hành pháp các nước bắt buộc phải duy trì việc chia sẻ thông tin tình báo và phối hợp hành động hết sức mật thiết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2766,
    hanzi: '秘书',
    pinyin: 'mìshū',
    word_type: 'Danh từ',
    meaning_vi: 'thư ký',
    examples: [
      {
        chinese: '总经理的秘书工作细致负责，将每天的日程安排得井井有条。',
        pinyin: 'Zǒngjīnglǐ de mìshū gōngzuò xìzhì fùzé, jiāng měi tiān de rìchéng ānpái de jǐngjǐng-yǒutiáo.',
        meaning_vi: 'Thư ký của tổng giám đốc làm việc rất tỉ mỉ và có trách nhiệm, sắp xếp lịch trình mỗi ngày đâu ra đấy ngăn nắp trật tự.',
        difficulty_level: 'basic'
      },
      {
        chinese: '作为国际多边经贸组织常设秘书处的资深法律秘书，她承担着起草跨境争端解决规则与多边多语种公约文本的重要职责。',
        pinyin: 'Zuòwéi guójì duōbiān jīngmào zǔzhī chángshè mìshūchù de zīshēn fǎlǜ mìshū, tā chéngdān zhe qǐcǎo kuàjìng zhēngduān jiějué guīzé yǔ duōbiān duōyǔzhǒng gōngyuē wénběn de zhòngyào zhízé.',
        meaning_vi: 'Với tư cách là thư ký pháp lý kỳ cựu của Ban Thư ký thường trực một tổ chức kinh tế thương mại đa phương quốc tế, cô gánh vác trọng trách quan trọng là soạn thảo các quy tắc giải quyết tranh chấp xuyên biên giới và văn bản công ước đa phương đa ngôn ngữ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2767,
    hanzi: '面',
    pinyin: 'miàn',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'mặt, bề mặt, phương diện; lá (cờ)',
    examples: [
      {
        chinese: '清晨的校园广场上，伴随着国歌声升起了一面鲜艳的五星红旗。',
        pinyin: 'Qīngchén de xiàoyuán guǎngchǎng shang, bànsuí zhe guógē shēng shēngqǐ le yí miàn xiānyàn de wǔxīng hóngqí.',
        meaning_vi: 'Trên quảng trường sân trường vào buổi sáng sớm, hòa cùng tiếng quốc ca vang lên là một lá cờ đỏ sao vàng tươi thắm được kéo lên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全面推进乡村振兴必须坚持多措并举，不仅要抓好农业产业化发展这一面，更要兼顾乡村生态治理与精神文明建设的各个基本面。',
        pinyin: 'Quánmiàn tuījìn xiāngcūn zhènxīng bìxū jiānchí duōcuò-bìngjǔ, bùjǐn yào zhuā hǎo nóngyè chǎnyèhuà fāzhǎn zhè yí miàn, gèng yào jiāngù xiāngcūn shēngtài zhìlǐ yǔ jīngshén wénmíng jiànshè de gègè jīběnmiàn.',
        meaning_vi: 'Đẩy mạnh toàn diện công cuộc chấn hưng nông thôn đòi hỏi phải đồng bộ nhiều biện pháp, không chỉ nắm chắc mặt phát triển công nghiệp hóa nông nghiệp, mà càng phải chăm lo đến các phương diện cơ bản như quản trị sinh thái làng quê và xây dựng văn minh tinh thần.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2768,
    hanzi: '面积',
    pinyin: 'miànjī',
    word_type: 'Danh từ',
    meaning_vi: 'diện tích',
    examples: [
      {
        chinese: '这套三居室公寓的实用建筑面积大约有一百二十平方米。',
        pinyin: 'Zhè tào sān jūshì gōngyù de shíyòng jiànzhù miànjī dàyuē yǒu yībǎi èrshí píngfāngmǐ.',
        meaning_vi: 'Căn hộ chung cư 3 phòng ngủ này có diện tích xây dựng sử dụng thực tế khoảng 120 mét vuông.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家持续推进“三北”等重点生态工程建设，累计完成退耕还林还草与防沙治沙绿化面积达数千万公顷，创造了全球荒漠化治理的绿色奇迹。',
        pinyin: 'Guójiā chíxù tuījìn “Sānběi” děng zhòngdiǎn shēngtài gōngchéng jiànshè, lěijì wánchéng tuìgēng-huánlín-huáncǎo yǔ fángshā-zhìshā lǜhuà miànjī dá shù qiān wàn gōngqǐng, chuàngzào le quánqiú huāngmòhuà zhìlǐ de lǜsè qíjì.',
        meaning_vi: 'Nhà nước liên tục đẩy mạnh xây dựng các công trình sinh thái trọng điểm như "Tam Bắc", hoàn thành diện tích phủ xanh đất trồng rừng trồng cỏ và chắn cát cải tạo sa mạc lên tới hàng chục triệu hecta, tạo nên kỳ tích xanh trong công cuộc quản trị sa mạc hóa toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2769,
    hanzi: '面临',
    pinyin: 'miànlín',
    word_type: 'Động từ',
    meaning_vi: 'đối mặt với, đương đầu với',
    examples: [
      {
        chinese: '大学毕业生在步入社会时，往往面临着激烈的就业竞争压力。',
        pinyin: 'Dàxué bìyèshēng zài bùrù shèhuì shí, wǎngwǎng miànlín zhe jīliè de jiùyè jìngzhēng yālì.',
        meaning_vi: 'Sinh viên tốt nghiệp đại học khi bước vào xã hội thường phải đối mặt với áp lực cạnh tranh việc làm khốc liệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '当前世界经济增长动能不足，地缘政治冲突频发，人类社会面临着逆全球化浪潮与气候变暖等多重严峻风险挑战。',
        pinyin: 'Dāngqián shìjiè jīngjì zēngzhǎng dòngnéng bùzú, dìyuán zhèngzhì chōngtū pínfā, rénlèi shèhuì miànlín zhe nì-quánqiúhuà làngcháo yǔ qìhòu biànnuǎn děng duōchóng yánjùn fēngxiǎn tiǎozhàn.',
        meaning_vi: 'Hiện nay động năng tăng trưởng kinh tế thế giới thiếu hụt, xung đột địa chính trị diễn ra thường xuyên, xã hội loài người đang phải đối mặt với muôn vàn thách thức rủi ro cam go như làn sóng phi toàn cầu hóa và biến đổi khí hậu ấm lên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2770,
    hanzi: '面向',
    pinyin: 'miànxiàng',
    word_type: 'Động từ',
    meaning_vi: 'hướng tới, hướng về, dành cho',
    examples: [
      {
        chinese: '这所语言学院开设了专门面向外国留学生的基础中文听说速成班。',
        pinyin: 'Zhè suǒ yǔyán xuéyuàn kāishè le zhuānmén miànxiàng wàiguó liúxuéshēng de jīchǔ Zhōngwén tīngshuō sùchéngbān.',
        meaning_vi: 'Học viện ngôn ngữ này đã mở lớp cấp tốc nghe nói tiếng Trung cơ bản chuyên hướng tới các du học sinh nước ngoài.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家科技重大专项始终坚持面向世界科技前沿、面向经济主战场、面向国家重大需求、面向人民生命健康，加快实现高水平科技自立自强。',
        pinyin: 'Guójiā kējì zhòngdà zhuānxiàng shǐzhōng jiānchí miànxiàng shìjiè kējì qiányán, miànxiàng jīngjì zhǔ zhànchǎng, miànxiàng guójiā zhòngdà xūqiú, miànxiàng rénmín shēngmìng jiànkāng, jiākuài shíxiàn gāo shuǐpíng kējì zìlì-zìqiáng.',
        meaning_vi: 'Các chương trình khoa học công nghệ trọng đại quốc gia luôn kiên trì hướng tới tiền tuyến công nghệ thế giới, hướng về chiến trường chính kinh tế, hướng tới nhu cầu lớn của quốc gia, hướng tới tính mạng sức khỏe nhân dân, đẩy nhanh hiện thực hóa khoa học công nghệ tự lực tự cường cấp cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2771,
    hanzi: '描述',
    pinyin: 'miáoshù',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'miêu tả, mô tả; sự mô tả',
    examples: [
      {
        chinese: '请你根据目击情况，向民警详细描述一下嫌疑人的体貌特征。',
        pinyin: 'Qǐng nǐ gēnjù mùjī qíngkuàng, xiàng mínjǐng xiángxì miáoshù yíxià xiányírén de tǐmào tèzhēng.',
        meaning_vi: 'Xin bạn hãy căn cứ vào tình hình tận mắt chứng kiến, miêu tả chi tiết với cảnh sát về đặc điểm nhận dạng của nghi phạm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '爱因斯坦在广义相对论中，运用高深优美的黎曼几何曲率张量数学语言，极其精确地描述了宇宙大质量天体引力场对四维时空的弯曲效应。',
        pinyin: 'Àiyīnsītǎn zài guǎngyì xiāngduìlùn zhōng, yùnyòng gāoshēn yōuměi de Límàn jǐhé qūlǜ zhāngliàng shùxué yǔyán, jíqí jīngquè de miáoshù le yǔzhòu dà zhìliàng tiāntǐ yǐnlìchǎng duì sìwéi shíkōng de wānqū xiàoyìng.',
        meaning_vi: 'Einstein trong Thuyết tương đối rộng đã vận dụng ngôn ngữ toán học ten-xơ độ cong hình học Riemann cao siêu đẹp đẽ để mô tả cực kỳ chính xác hiệu ứng bẻ cong không - thời gian 4 chiều của trường hấp dẫn thiên thể khối lượng lớn trong vũ trụ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2772,
    hanzi: '敏感',
    pinyin: 'mǐngǎn',
    word_type: 'Tính từ',
    meaning_vi: 'nhạy cảm, mẫn cảm, dễ dị ứng',
    examples: [
      {
        chinese: '春天花粉较多，皮肤敏感的人外出最好戴上口罩做好防护。',
        pinyin: 'Chūntiān huāfěn jiào duō, pífū mǐngǎn de rén wàichū zuìhǎo dài shàng kǒuzhào zuò hǎo fánghù.',
        meaning_vi: 'Mùa xuân phấn hoa khá nhiều, những người có làn da nhạy cảm khi ra ngoài tốt nhất nên đeo khẩu trang phòng hộ cẩn thận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际资本流动对美联储利率政策走向极具高度敏感性，任何超预期的通胀数据波动都可能引发全球外汇与资产市场的连锁剧烈震荡。',
        pinyin: 'Guójì zīběn liúdòng duì Měiliánchǔ lìlǜ zhèngcè zǒuxiàng jí jù gāodù mǐngǎnxìng, rènhé chāo yùqī de tōngzhàng shùjù bōdòng dōu kěnéng yǐnfā quánqiú wàihuì yǔ zīchǎn shìchǎng de liánsuǒ jùliè zhèndàng.',
        meaning_vi: 'Dòng vốn quốc tế có độ nhạy cảm cao độ đối với hướng đi chính sách lãi suất của Cục Dự trữ Liên bang Mỹ, bất kỳ sự dao động số liệu lạm phát nào vượt dự kiến cũng có thể gây ra chuỗi chấn động dữ dội trên thị trường ngoại hối và tài sản toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2773,
    hanzi: '名称',
    pinyin: 'míngchēng',
    word_type: 'Danh từ',
    meaning_vi: 'tên gọi, danh xưng, tên thương mại',
    examples: [
      {
        chinese: '在填写注册登记表格时，请务必核对好公司的法定完整名称。',
        pinyin: 'Zài tiánxiě zhùcè dēngjì biǎogé shí, qǐng wùbì héduì hǎo gōngsī de fǎdìng wánzhěng míngchēng.',
        meaning_vi: 'Khi điền biểu mẫu đăng ký, xin nhất thiết phải kiểm tra đối chiếu thật kỹ tên gọi pháp định đầy đủ của công ty.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家地理标志保护产品严格限定产地范围与传统加工工艺，严厉打击任何擅自盗用地理标志名称的假冒侵权假劣行为。',
        pinyin: 'Guójiā dìlǐ biāozhì bǎohù chǎnpǐn yángé xiàndìng chǎndì fànwéi yǔ chuántǒng jiāgōng gōngyì, yánlì dǎjī rènhé shànzì dàoyòng dìlǐ biāozhì míngchēng de jiǎmào qīnquán jiǎliè xíngwéi.',
        meaning_vi: 'Sản phẩm được bảo hộ chỉ dẫn địa lý quốc gia quy định khắt khe phạm vi vùng xuất xứ và quy trình gia công truyền thống, xử lý nghiêm khắc mọi hành vi giả mạo xâm quyền tự tiện đánh cắp tên gọi chỉ dẫn địa lý.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2774,
    hanzi: '名牌',
    pinyin: 'míngpái',
    word_type: 'Danh từ',
    meaning_vi: 'hàng hiệu, thương hiệu nổi tiếng, danh bài',
    examples: [
      {
        chinese: '青年人消费应当量力而行，切忌为了虚荣盲目追求名牌奢侈品。',
        pinyin: 'Qīngniánrén xiāofèi yīngdāng liànglì-érxíng, qièjì wèile xūróng mángmù zhuīqiú míngpái shēchǐpǐn.',
        meaning_vi: 'Người trẻ tuổi tiêu dùng nên lượng sức mình, tuyệt đối tránh vì hư vinh mà mù quáng chạy theo các món hàng hiệu xa xỉ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '实施质量强国与中国制造走出去战略，重在打造一批具有核心自主知识产权与全球卓越影响力的中国名牌企业。',
        pinyin: 'Shíshī zhìliàng qiángguó yǔ Zhōngguó zhìzào zǒuchūqù zhànlüè, zhòng zài dǎzào yì pī jùyǒu héxīn zìzhǔ zhīshi chǎnquán yǔ quánqiú zhuóyuè yǐngxiǎnglì de Zhōngguó míngpái qǐyè.',
        meaning_vi: 'Thực thi chiến lược xây dựng quốc gia chất lượng mạnh và đưa hàng chế tạo Trung Quốc vươn ra thế giới, trọng tâm là gây dựng nên một loạt các doanh nghiệp mang thương hiệu nổi tiếng Trung Quốc sở hữu quyền sở hữu trí tuệ tự chủ cốt lõi và sức ảnh hưởng vượt trội toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2775,
    hanzi: '名片',
    pinyin: 'míngpiàn',
    word_type: 'Danh từ',
    meaning_vi: 'danh thiếp, card visit; tấm danh thiếp (biểu tượng)',
    examples: [
      {
        chinese: '在商务社交场合，双手递交和接取名片是一种基本的礼貌习惯。',
        pinyin: 'Zài shāngwù shèjiāo chǎnghé, shuāngshǒu dìjiāo hé jiēqǔ míngpiàn shì yì zhǒng jīběn de lǐmào xíguàn.',
        meaning_vi: 'Trong các dịp giao tế thương mại, đưa và nhận danh thiếp bằng hai tay là một thói quen lịch thiệp cơ bản.',
        difficulty_level: 'basic'
      },
      {
        chinese: '拥有自主知识产权的中国高铁、特高压输电工程与新能源汽车，已成为彰显国家高端工业制造强劲实力的闪亮“国家名片”。',
        pinyin: 'Yōngyǒu zìzhǔ zhīshi chǎnquán de Zhōngguó gāotiě, tè-gāoyā shūdiàn gōngchéng yǔ xīnnéngyuán qìchē, yǐ chéngwéi zhāngxiǎn guójiā gāoduān gōngyè zhìzào qiángjìn shílì de shǎnliàng “guójiā míngpiàn”.',
        meaning_vi: 'Đường sắt cao tốc Trung Quốc, công trình truyền tải điện siêu cao áp và xe năng lượng mới sở hữu quyền sở hữu trí tuệ tự chủ đã trở thành những "tấm danh thiếp quốc gia" rực rỡ thể hiện sức mạnh nội lực to lớn của ngành chế tạo công nghiệp cao cấp đất nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2776,
    hanzi: '明确',
    pinyin: 'míngquè',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'rõ ràng, dứt khoát, minh xác; làm rõ',
    examples: [
      {
        chinese: '开会前必须明确本次讨论的核心议题与具体解决目标。',
        pinyin: 'Kāihuì qián bìxū míngquè běn cì tǎolùn de héxīn yìtí yǔ jùtǐ jiějué mùbiāo.',
        meaning_vi: 'Trước khi họp bắt buộc phải làm rõ chủ đề cốt lõi của buổi thảo luận lần này cùng mục tiêu giải quyết cụ thể.',
        difficulty_level: 'basic'
      },
      {
        chinese: '最新出台的知识产权保护司法解释进一步明确了侵犯数字商业秘密惩罚性赔偿的适用条件，有力震慑了恶意侵权行为。',
        pinyin: 'Zuìxīn chūtái de zhīshi chǎnquán bǎohù sīfǎ jiěshì jìnyíbù míngquè le qīnfàn shùzì shāngyè mìmì chéngfáxìng péicháng de shìyòng tiáojiàn, yǒulì zhènshè le èyì qīnquán xíngwéi.',
        meaning_vi: 'Bản giải thích tư pháp về bảo vệ quyền sở hữu trí tuệ mới được ban hành đã làm rõ hơn nữa các điều kiện áp dụng mức bồi thường mang tính trừng phạt đối với hành vi xâm phạm bí mật thương mại số, răn đe mạnh mẽ các hành vi xâm phạm quyền sở hữu mang tính ác ý.',
        difficulty_level: 'applied'
      }
    ]
  }
]
