// data/hsk5-batch7-part3-data.ts
// 25 từ HSK 5: #2652 [开幕式] -> #2676 [库]

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

export const HSK5_BATCH7_PART3: VocabItem[] = [
  {
    id: 2652,
    hanzi: '开幕式',
    pinyin: 'kāimùshì',
    word_type: 'Danh từ',
    meaning_vi: 'lễ khai mạc',
    examples: [
      {
        chinese: '学校运动会的开幕式上，各班代表队迈着整齐的步伐走过主席台。',
        pinyin: 'Xuéxiào yùndònghuì de kāimùshì shang, gè bān dàibiǎoduì mài zhe zhěngqí de bùfá zǒuguò zhǔxítái.',
        meaning_vi: 'Tại lễ khai mạc đại hội thể thao của trường, các đoàn đại diện của từng lớp đã rảo bước chân đều tăm tắp đi qua khán đài chủ tịch.',
        difficulty_level: 'basic'
      },
      {
        chinese: '夏季奥林匹克运动会开幕式将千年古老文明与现代裸眼3D全息光影技术完美交融，为全球数十亿观众奉献了一场震撼心灵的文化视觉盛宴。',
        pinyin: 'Xiàjì Àolínpǐkè Yùndònghuì kāimùshì jiāng qiān nián gǔlǎo wénmíng yǔ xiàndài luǒyǎn 3D quánxī guāngyǐng jìshù wánměi jiāoróng, wèi quánqiú shù shí yì guānzhòng fèngxiàn le yì chǎng zhènhàn xīnlíng de wénhuà shìjué shèngyàn.',
        meaning_vi: 'Lễ khai mạc Thế vận hội Olympic mùa hè đã giao thoa hoàn mỹ nền văn minh cổ xưa nghìn năm cùng công nghệ ánh sáng 3D toàn cảnh không cần kính hiện đại, cống hiến cho hàng tỷ khán giả toàn cầu một bữa tiệc thị giác văn hóa chấn động tâm hồn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2653,
    hanzi: '开水',
    pinyin: 'kāishuǐ',
    word_type: 'Danh từ',
    meaning_vi: 'nước sôi, nước đun sôi',
    examples: [
      {
        chinese: '感冒发烧时，医生建议多喝温开水并注意卧床休息。',
        pinyin: 'Gǎnmào fāshāo shí, yīshēng jiànyì duō hē wēn kāishuǐ bìng zhùyì wòchuáng xiūxi.',
        meaning_vi: 'Khi bị cảm sốt, bác sĩ khuyên nên uống nhiều nước đun sôi để ấm và chú ý nghỉ ngơi trên giường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在野外地质勘探与野外生存作业中，将天然水源完全煮沸沉淀形成卫生安全的开水，是预防肠道传染病传播的最基本要求。',
        pinyin: 'Zài yěwài dìzhì kāntàn yǔ yěwài shēngcún zuòyè zhōng, jiāng tiānrán shuǐyuán wánquán zhǔfèi chéndiàn xíngchéng wèishēng ānquán de kāishuǐ, shì yùfáng chángdào chuánrǎnbìng chuánbō de zuì jīběn yāoqiú.',
        meaning_vi: 'Trong công tác khảo sát địa chất thực địa và sinh tồn dã ngoại, việc đun sôi sùng sục và lắng lọc nguồn nước tự nhiên thành nước sôi hợp vệ sinh an toàn là yêu cầu cơ bản nhất nhằm phòng ngừa sự lây lan của các bệnh truyền nhiễm đường ruột.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2654,
    hanzi: '开通',
    pinyin: 'kāitōng',
    word_type: 'Động từ',
    meaning_vi: 'thông tuyến, mở tuyến, kích hoạt; tư tưởng cởi mở',
    examples: [
      {
        chinese: '城市新地铁线路正式开通运营，极大缩短了市民上下班的通勤时间。',
        pinyin: 'Chéngshì xīn dìtiě xiànlù zhèngshì kāitōng yùnyíng, jídà suōduǎn le shìmín shàng-xiàbān de tōngqín shíjiān.',
        meaning_vi: 'Tuyến tàu điện ngầm mới của thành phố chính thức thông tuyến vận hành, rút ngắn rất nhiều thời gian đi lại làm việc của người dân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着连接内陆腹地与沿海自贸试验区的高速跨海大桥全线开通，沿线区域间的人流、物流与资金流互通效率得到了爆发式释放。',
        pinyin: 'Suízhe liánjiē nèilù fùdì yǔ yánhǎi zìmào shìyànqū de gāosù kuàhǎi dàqiáo quánxiàn kāitōng, yánxiàn qūyù jiān de rénliú, wùliú yǔ zījīnliú hùtōng xiàolǜ dédào le bàofāshì shìfàng.',
        meaning_vi: 'Cùng với việc thông tuyến toàn diện cây cầu vượt biển cao tốc nối liền vùng nội địa trù phú và khu thí điểm thương mại tự do ven biển, hiệu suất lưu chuyển dòng người, dòng hàng và dòng vốn giữa các khu vực dọc tuyến đã được giải phóng bùng nổ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2655,
    hanzi: '开业',
    pinyin: 'kāiyè',
    word_type: 'Động từ',
    meaning_vi: 'khai trương, mở cửa kinh doanh',
    examples: [
      {
        chinese: '社区门口新开业的面馆正在搞买一送一的优惠酬宾活动。',
        pinyin: 'Shèqū ménkǒu xīn kāiyè de miànguǎn zhèngzài gǎo mǎi yī sòng yī de yōuhuì chóubīn huódòng.',
        meaning_vi: 'Quán mì mới khai trương trước cổng khu dân cư đang triển khai chương trình ưu đãi tri ân mua một tặng một.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该跨国高端智能制造产业研发基地在自由贸易试验区隆重开业投产，预计年产值将突破百亿元大关。',
        pinyin: 'Gāi kuàguó gāoduān zhìnéng zhìzào chǎnyè yánfā jīdì zài zìyóu màoyì shìyànqū lóngzhòng kāiyè tóuchǎn, yùjì nián chǎnzhí jiāng tūpò bǎi yì yuán dàguān.',
        meaning_vi: 'Cơ sở nghiên cứu phát triển ngành chế tạo thông minh cao cấp xuyên quốc gia này đã long trọng khai trương đi vào sản xuất tại khu thí nghiệm thương mại tự do, dự kiến giá trị sản lượng hằng năm sẽ vượt mốc 10 tỷ nhân dân tệ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2656,
    hanzi: '开展',
    pinyin: 'kāizhǎn',
    word_type: 'Động từ',
    meaning_vi: 'triển khai, phát động, mở rộng',
    examples: [
      {
        chinese: '学校每逢植树节都会积极组织师生开展绿化植树志愿活动。',
        pinyin: 'Xuéxiào měiféng zhíshùjié dōu huì jījí zǔzhī shīshēng kāizhǎn lǜhuà zhíshù zhìyuàn huódòng.',
        meaning_vi: 'Cứ mỗi dịp Tết trồng cây, nhà trường đều tích cực tổ chức cho thầy cô và học sinh triển khai các hoạt động tình nguyện phủ xanh trồng cây.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家多部门联合部署开展打击网络跨境电信诈骗专项治理行动，坚决斩断黑灰产业链并切实守护人民群众的财产安全。',
        pinyin: 'Guójiā duō bùmén liánhé bùshǔ kāizhǎn dǎjī wǎngluò kuàjìng diànxìn zhàpiàn zhuānxiàng zhìlǐ xíngdòng, jiānjué zhǎnduàn hēihuī chǎnyèliàn bìng qièshí shǒuhù rénmín qúnzhòng de cáichǎn ānquán.',
        meaning_vi: 'Nhiều cơ quan ban ngành quốc gia đã phối hợp bố trí triển khai đợt chuyên đề hành động truy quét lừa đảo viễn thông mạng xuyên biên giới, kiên quyết chặt đứt chuỗi cung ứng đen xám và bảo vệ thiết thực an toàn tài sản của quần chúng nhân dân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2657,
    hanzi: '看',
    pinyin: 'kān',
    word_type: 'Động từ',
    meaning_vi: 'trông coi, canh giữ, coi sóc, chăm sóc',
    examples: [
      {
        chinese: '姐姐在家里细心看护生病发烧的小妹妹。',
        pinyin: 'Jiějie zài jiālǐ xìxīn kānhù shēngbìng fāshāo de xiǎo mèimei.',
        meaning_vi: 'Người chị ở nhà chăm chú trông nom, săn sóc cô em gái nhỏ đang bị ốm sốt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '护林员老张在大山深处的国家级自然保护区看林护草数十年，默默守护着祖国的绿色生态屏障。',
        pinyin: 'Hùlínyuán Lǎo Zhāng zài dàshān shēnchù de guójiājí zìrán bǎohùqū kān lín hù cǎo shù shí nián, mòmò shǒuhù zhe zǔguó de lǜsè shēngtài píngzhàng.',
        meaning_vi: 'Bác kiểm lâm Trương ở nơi rừng sâu của khu bảo tồn thiên nhiên cấp quốc gia trông coi rừng và giữ gìn cây cỏ suốt hàng chục năm ròng, thầm lặng canh giữ bức bình phong sinh thái xanh của tổ quốc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2658,
    hanzi: '看望',
    pinyin: 'kànwàng',
    word_type: 'Động từ',
    meaning_vi: 'thăm hỏi, đến thăm',
    examples: [
      {
        chinese: '周末我和父母一起去医院看望生病住院的语文老师。',
        pinyin: 'Zhōumò wǒ hé fùmǔ yìqǐ qù yīyuàn kànwàng shēngbìng zhùyuàn de yǔwén lǎoshī.',
        meaning_vi: 'Cuối tuần tôi cùng bố mẹ đến bệnh viện để thăm hỏi người thầy giáo dạy ngữ văn đang ốm nằm viện.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在新春佳节来临之际，各级政府领导深入基层边远乡村看望慰问老党员与困难群众，向他们致以诚挚的节日祝福并送去慰问品。',
        pinyin: 'Zài xīnchūn jiājié láilín zhījì, gè jí zhèngfǔ lǐngdǎo shēnrù jīcéng biānyuǎn xiāngcūn kànwàng wèiwèn lǎo dǎngyuán yǔ kùnnan qúnzhòng, xiàng tāmen zhìyǐ chéngzhì de jiérì zhùfú bìng sòng qù wèiwènpǐn.',
        meaning_vi: 'Nhân dịp Tết cổ truyền sắp đến, lãnh đạo chính quyền các cấp đã sâu sát về các làng quê vùng sâu vùng xa để thăm hỏi động viên các đảng viên lão thành cùng bà con có hoàn cảnh khó khăn, gửi tới họ lời chúc Tết chân thành và những phần quà ấm áp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2659,
    hanzi: '看作',
    pinyin: 'kànzuò',
    word_type: 'Động từ',
    meaning_vi: 'coi như, xem như',
    examples: [
      {
        chinese: '他把每一次失败都看作是人生中宝贵的学习经验。',
        pinyin: 'Tā bǎ měi yí cì shībài dōu kànzuò shì rénshēng zhōng bǎoguì de xuéxí jīngyàn.',
        meaning_vi: 'Anh ấy xem mỗi lần thất bại đều là một bài học kinh nghiệm vô cùng quý giá trong cuộc đời.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代经济学将数据要素看作与土地、劳动力、资本及技术并列的第五大关键生产要素，其在资源重组与财富创造中的作用日益凸显。',
        pinyin: 'Xiàndài jīngjìxué jiāng shùjù yàosù kànzuò yǔ tǔdì, láodònglì, zīběn jí jìshù bìngliè de dì-wǔ dà guānjiàn shēngchǎn yàosù, qí zài zīyuán chóngzǔ yǔ cáifù chuàngzào zhōng de zuòyòng rìyì tūxiǎn.',
        meaning_vi: 'Kinh tế học hiện đại xem yếu tố dữ liệu như yếu tố sản xuất then chốt thứ năm song hành cùng đất đai, sức lao động, vốn và công nghệ, với vai trò ngày càng nổi bật trong tái cấu trúc nguồn lực và kiến tạo của cải.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2660,
    hanzi: '靠',
    pinyin: 'kào',
    word_type: 'Động từ',
    meaning_vi: 'dựa vào, tựa vào, nhờ vào; cập (bến)',
    examples: [
      {
        chinese: '他工作累了，就靠在沙发上闭目养神休息一会儿。',
        pinyin: 'Tā gōngzuò lèi le, jiù kào zài shāfā shang bìmù-yǎngshén xiūxi yíhuìr.',
        meaning_vi: 'Làm việc mệt rồi, anh ấy tựa vào ghế sofa nhắm mắt dưỡng thần nghỉ ngơi một lát.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在激烈的全球高科技产业竞争中，核心技术的突破不能靠单打独斗，必须依靠完善的产学研协同创新生态体系。',
        pinyin: 'Zài jīliè de quánqiú gāo kējì chǎnyè jìngzhēng zhōng, héxīn jìshù de tūpò bùnéng kào dāndǎ-dúdòu, bìxū yīkào wánshàn de chǎn-xué-yán xiétóng chuàngxīn shēngtài tǐxì.',
        meaning_vi: 'Trong cuộc cạnh tranh ngành công nghiệp công nghệ cao toàn cầu khốc liệt, đột phá công nghệ cốt lõi không thể dựa vào đơn thương độc mã, mà phải dựa vào hệ sinh thái đổi mới hiệp đồng hoàn chỉnh giữa doanh nghiệp, viện nghiên cứu và trường đại học.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2661,
    hanzi: '靠近',
    pinyin: 'kàojìn',
    word_type: 'Động từ',
    meaning_vi: 'lại gần, áp sát, sát gần',
    examples: [
      {
        chinese: '为了自身安全，参观动物园时严禁翻越护栏并靠近凶猛动物。',
        pinyin: 'Wèile zìshēn ānquán, cānguān dòngwùyuán shí yánjìn fānyuè hùlán bìng kàojìn xiōngměng dòngwù.',
        meaning_vi: 'Vì sự an toàn của bản thân, khi tham quan vườn thú nghiêm cấm trèo qua lan can và tiến lại gần các loài động vật hung dữ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着深空探测器逐渐靠近火星轨道，地面测控中心通过微调姿态推进器，精准实施火星捕获制动减速轨道修正。',
        pinyin: 'Suízhe shēnkōng tàncèqì zhújiàn kàojìn Huǒxīng guǐdào, dìmiàn cèkòng zhōngxīn tōngguò wēitiáo zītài tuījìnqì, jīngzhǔn shíshī Huǒxīng bǔhuò zhìdòng jiǎnsù guǐdào xiūzhèng.',
        meaning_vi: 'Cùng với việc tàu thăm dò không gian sâu dần dần tiến sát quỹ đạo Sao Hỏa, trung tâm điều khiển mặt đất thông qua tinh chỉnh động cơ đẩy tư thế đã thực hiện chính xác việc hiệu chỉnh quỹ đạo phanh giảm tốc để Sao Hỏa bắt giữ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2662,
    hanzi: '颗',
    pinyin: 'kē',
    word_type: 'Lượng từ',
    meaning_vi: 'viên, hạt, quả, ngôi (lượng từ cho hạt, sao, tim, ngọc, vệ tinh)',
    examples: [
      {
        chinese: '晴朗的夏夜里，天空中闪烁着一颗颗耀眼的星星。',
        pinyin: 'Qínglǎng de xiàyè lǐ, tiānkōng zhōng shǎnshuò zhe yì kēkē yàoyǎn de xīngxing.',
        meaning_vi: 'Trong đêm hè quang đãng, trên bầu trời lấp lánh từng ngôi sao sáng ngời rực rỡ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '运载火箭成功将最新一代地球环境监测卫星送入预定轨道，这颗高轨道光学卫星将为全球气象灾害早期预警提供精准遥感数据支撑。',
        pinyin: 'Yùnzài huǒjiàn chénggōng jiāng zuìxīn yídài dìqiú huánjìng jiāncè wèixīng sòngrù yùdìng guǐdào, zhè kē gāo guǐdào guāngxué wèixīng jiāng wèi quánqiú qìxiàng zāihài zǎoqī yùjǐng tígōng jīngzhǔn yáogǎn shùjù zhīchēng.',
        meaning_vi: 'Tên lửa đẩy đã phóng thành công vệ tinh giám sát môi trường Trái Đất thế hệ mới nhất vào quỹ đạo dự định, quả vệ tinh quang học quỹ đạo cao này sẽ cung cấp nguồn dữ liệu viễn thám chuẩn xác cho việc cảnh báo sớm thiên tai khí tượng toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2663,
    hanzi: '科研',
    pinyin: 'kēyán',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'nghiên cứu khoa học; làm nghiên cứu',
    examples: [
      {
        chinese: '李教授带领学生们在实验室里全身心投入到国家科研课题中。',
        pinyin: 'Lǐ jiàoshòu dàilǐng xuéshengmen zài shíyànshì lǐ quánshēnxīn tóurù dào guójiā kēyán kètí zhōng.',
        meaning_vi: 'Giáo sư Lý dẫn dắt các học trò toàn tâm toàn ý cống hiến cho đề tài nghiên cứu khoa học cấp quốc gia nơi phòng thí nghiệm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家持续深化科研体制机制改革，赋予科研人员更大的科研经费支配权与技术路线自主权，全方位激发创新创造活力。',
        pinyin: 'Guójiā chíxù shēnhuà kēyán tǐzhì jīzhì gǎigé, fùyǔ kēyán rényuán gèng dà de kēyán jīngfèi zhīpèiquán yǔ jìshù lùxiàn zìzhǔquán, quán fāngwèi jīfā chuàngxīn chuàngzào huólì.',
        meaning_vi: 'Nhà nước liên tục làm sâu sắc thêm công cuộc cải cách thể chế cơ chế nghiên cứu khoa học, trao cho giới nghiên cứu quyền chi phối kinh phí đề tài và quyền tự chủ về lộ trình kỹ thuật lớn hơn, khơi dậy toàn diện sức sống đổi mới sáng tạo.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2664,
    hanzi: '可见',
    pinyin: 'kějiàn',
    word_type: 'Liên từ / Động từ',
    meaning_vi: 'có thể thấy, thấy rõ là, hiển nhiên',
    examples: [
      {
        chinese: '他在这份报告上做了密密麻麻的批注，可见他对这项工作有多么重视。',
        pinyin: 'Tā zài zhè fèn bàogào shang zuò le mìmìmámá de pīzhù, kějiàn tā duì zhè xiàng gōngzuò yǒu duōme zhòngshì.',
        meaning_vi: 'Anh ấy ghi chú chi chít dày đặc trên bản báo cáo này, có thể thấy anh ấy coi trọng công việc này đến mức nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高技术制造业投资增速持续显著高于全部投资平均水平，由此可见，产业高端化、智能化转型正在加速重塑国民经济结构。',
        pinyin: 'Gāo jìshù zhìzàoyè tóuzī zēngsù chíxù xiǎnzhù gāoyú quánbù tóuzī píngjūn shuǐpíng, yóucǐ kějiàn, chǎnyè gāoduānhuà, zhìnénghuà zhuǎnxíng zhèngzài jiāsù chóngsù guómín jīngjì jiégòu.',
        meaning_vi: 'Tốc độ tăng trưởng đầu tư vào ngành chế tạo công nghệ cao liên tục vượt trội so với mức bình quân toàn xã hội, qua đó có thể thấy rõ sự chuyển đổi cao cấp hóa và thông minh hóa ngành công nghiệp đang đẩy nhanh tái tạo cấu trúc nền kinh tế quốc dân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2665,
    hanzi: '可靠',
    pinyin: 'kěkào',
    word_type: 'Tính từ',
    meaning_vi: 'đáng tin cậy, chắc chắn, an toàn',
    examples: [
      {
        chinese: '他为人诚恳踏实且办事稳重，是一个非常值得信赖的可靠伙伴。',
        pinyin: 'Tā wéirén chéngkěn tàshi qiě bànshì wěnzhòng, shì yí gè fēicháng zhíde xìnlài de kěkào huǒbàn.',
        meaning_vi: 'Anh ấy ăn ở chân thành chất phác lại làm việc chín chắn, là một người cộng sự đáng tin cậy rất đáng để gửi gắm niềm tin.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大型水电站枢纽工程必须在极端洪水与强烈地震等罕见自然灾害工况下，依然保持大坝水工结构的绝对安全可靠。',
        pinyin: 'Dàxíng shuǐdiànzhàn shūniǔ gōngchéng bìxū zài jíduān hóngshuǐ yǔ qiángliè dìzhèn děng hǎnjiàn zìrán zāihài gōngkuàng xià, yīrán bǎochí dàbà shuǐgōng jiégòu de juéduì ānquán kěkào.',
        meaning_vi: 'Công trình đầu mối nhà máy thủy điện lớn bắt buộc phải duy trì độ an toàn chắc chắn tuyệt đối của kết cấu công trình thủy lợi thân đập ngay cả trong những điều kiện thiên tai hiếm gặp như lũ lụt cực đoan và động đất dữ dội.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2666,
    hanzi: '可怕',
    pinyin: 'kěpà',
    word_type: 'Tính từ',
    meaning_vi: 'đáng sợ, khủng khiếp',
    examples: [
      {
        chinese: '遭遇失败并不可怕，可怕的是丧失了重新站起来的勇气与信心。',
        pinyin: 'Zāoyù shībài bìng bù kěpà, kěpà de shì sàngshī le chóngxīn zhàn qǐlái de yǒngqì yǔ xìnxīn.',
        meaning_vi: 'Gặp phải thất bại không hề đáng sợ, điều đáng sợ là đánh mất dũng khí và niềm tin để đứng dậy bước tiếp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '核污染水若未经充分科学处理而长期排入公海，对全球海洋生态食物链及人类遗传基因造成的潜在危害将是极其可怕且不可逆转的。',
        pinyin: 'Hé wūrǎnshuǐ ruò wèijīng chōngfèn kēxué chǔlǐ ér chángqī páirù gōnghǎi, duì quánqiú hǎiyáng shēngtài shíwùliàn jí rénlèi yíchuán jīyīn zàochéng de qiánzài wēihài jiāng shì jíqí kěpà qiě bùkě nìzhuǎn de.',
        meaning_vi: 'Nước thải nhiễm hạt nhân nếu không qua xử lý khoa học thấu đáo mà xả thải lâu dài ra hải phận quốc tế, thì những hiểm họa tiềm ẩn gây ra cho chuỗi thức ăn sinh thái biển toàn cầu cùng nguồn gen di truyền của nhân loại sẽ là vô cùng khủng khiếp và không thể đảo ngược.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2667,
    hanzi: '克服',
    pinyin: 'kèfú',
    word_type: 'Động từ',
    meaning_vi: 'khắc phục, vượt qua (khó khăn, trở ngại)',
    examples: [
      {
        chinese: '在大家的齐心协力下，我们终于克服了筹备过程中的重重困难。',
        pinyin: 'Zài dàjiā de qíxīn-xiélì xià, wǒmen zhōngyú kèfú le chóubèi guòchéng zhōng de chóngchóng kùnnan.',
        meaning_vi: 'Dưới sự chung lưng đấu cật của mọi người, chúng tôi cuối cùng đã vượt qua muôn vàn khó khăn trong quá trình chuẩn bị.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国极地科考队员们发扬顽强拼搏精神，成功克服了南极高原零下数十度的极寒酷冷与狂风暴雪，圆满完成了全新考察站的建站任务。',
        pinyin: 'Zhōngguó jídì kěkǎoduìyuánmen fāyáng wánqiáng pīnbó jīngshén, chénggōng kèfú le Nánjí gāoyuán língxià shù shí dù de jíhán kùlěng yǔ kuángfēng-bàoxuě, yuánmǎn wánchéng le quánxīn kǎocházhàn de jiànzhàn rènwu.',
        meaning_vi: 'Các thành viên đội thám hiểm vùng cực Trung Quốc đã phát huy tinh thần chiến đấu kiên cường, khắc phục thành công cái giá rét cực đoan âm hàng chục độ cùng bão tuyết cuồng nộ trên cao nguyên Nam Cực, hoàn thành trọn vẹn nhiệm vụ xây dựng trạm khảo sát mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2668,
    hanzi: '客服',
    pinyin: 'kèfú',
    word_type: 'Danh từ',
    meaning_vi: 'chăm sóc khách hàng, nhân viên CSKH, dịch vụ khách hàng',
    examples: [
      {
        chinese: '如果在网购过程中遇到商品破损问题，可以随时在线联系平台官方客服。',
        pinyin: 'Rúguǒ zài wǎnggòu guòchéng zhōng yùdào shāngpǐn pòsǔn wèntí, kěyǐ suíshí xiànshàng liánxì píngtái guānfāng kèfú.',
        meaning_vi: 'Nếu trong quá trình mua sắm trực tuyến gặp sự cố hàng hóa bị hư hỏng, bạn có thể liên hệ với bộ phận chăm sóc khách hàng chính thức của sàn bất cứ lúc nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '商业银行依托大语言模型开发智能AI语音客服助理，能够全天候秒级解答客户关于信用卡账单、跨境汇款等各类复杂业务咨询。',
        pinyin: 'Shāngyè yínháng yītuō dà yǔyán móxíng kāifā zhìnéng AI yǔyīn kèfú zhùlǐ, nénggòu quántiānhòu miǎojí jiědá kèhù guānyú xìnyòngkǎ zhàngdān, kuàjìng huìkuǎn děng gèlèi fùzá yèwù zīxún.',
        meaning_vi: 'Ngân hàng thương mại dựa vào mô hình ngôn ngữ lớn để phát triển trợ lý ảo chăm sóc khách hàng bằng giọng nói AI thông minh, có thể giải đáp chỉ trong tích tắc suốt 24/7 mọi thắc mắc nghiệp vụ phức tạp của khách hàng về hóa đơn thẻ tín dụng và chuyển tiền xuyên biên giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2669,
    hanzi: '客观',
    pinyin: 'kèguān',
    word_type: 'Tính từ',
    meaning_vi: 'khách quan, trung thực, không thiên vị',
    examples: [
      {
        chinese: '评价一个人或一件事时，应当秉持公正而客观的态度。',
        pinyin: 'Píngjià yí gè rén huò yí jiàn shì shí, yīngdāng bǐngchí gōngzhèng ér kèguān de tàidu.',
        meaning_vi: 'Khi đánh giá một con người hay một sự việc, nên giữ vững thái độ công bằng và khách quan.',
        difficulty_level: 'basic'
      },
      {
        chinese: '宏观经济政策评估必须建立在对海量客观统计指标与微观市场主体调研的深度交叉验证之上，坚决杜绝主观臆断。',
        pinyin: 'Hóngguān jīngjì zhèngcè pínggū bìxū jiànlì zài duì hǎiliàng kèguān tǒngjì zhǐbiāo yǔ wēiguān shìchǎng zhǔtǐ diàoyán de shēndù jiāochā yànzhèng zhīshàng, jiānjué dùjué zhǔguān yìduàn.',
        meaning_vi: 'Đánh giá chính sách kinh tế vĩ mô phải được xây dựng dựa trên việc đối chiếu kiểm chứng chéo sâu sắc giữa khối lượng đồ sộ các chỉ tiêu thống kê khách quan và khảo sát thực tế các chủ thể thị trường vi mô, kiên quyết chấm dứt suy đoán chủ quan.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2670,
    hanzi: '客户',
    pinyin: 'kèhù',
    word_type: 'Danh từ',
    meaning_vi: 'khách hàng, đối tác',
    examples: [
      {
        chinese: '我们公司始终把满足客户的合理需求放在首要位置。',
        pinyin: 'Wǒmen gōngsī shǐzhōng bǎ mǎnzú kèhù de hélǐ xūqiú fàng zài shǒuyào wèizhì.',
        meaning_vi: 'Công ty chúng tôi luôn đặt việc đáp ứng các nhu cầu chính đáng của khách hàng lên vị trí hàng đầu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在数字化客户关系管理体系中，企业通过用户画像算法精准挖掘核心高端客户的个性化需求，实现客户终身价值的最大化。',
        pinyin: 'Zài shùzìhuà kèhù guānxì guǎnlǐ tǐxì zhōng, qǐyè tōngguò yònghù huàxiàng suànfǎ jīngzhǔn wājué héxīn gāoduān kèhù de gèxìnghuà xūqiú, shíxiàn kèhù zhōngshēn jiàzhí de zuìdàhuà.',
        meaning_vi: 'Trong hệ thống quản trị quan hệ khách hàng số hóa, doanh nghiệp thông qua thuật toán phác họa chân dung người dùng để khai phá chính xác nhu cầu cá nhân hóa của các khách hàng cao cấp cốt lõi, tối đa hóa giá trị trọn đời của khách hàng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2671,
    hanzi: '空间',
    pinyin: 'kōngjiān',
    word_type: 'Danh từ',
    meaning_vi: 'không gian, khoảng trống, dư địa',
    examples: [
      {
        chinese: '这个房间布局合理，即使摆放了大家具依然留有宽敞的活动空间。',
        pinyin: 'Zhè gè fángjiān bùjú hélǐ, jíshǐ bǎifàng le dà jiājù yīrán liúyǒu kuānchǎng de huódòng kōngjiān.',
        meaning_vi: 'Căn phòng này bài trí rất hợp lý, dẫu có kê đồ nội thất cỡ lớn vẫn để lại không gian sinh hoạt rộng rãi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着高水平双向对外开放战略的深入推进，我国在绿色低碳能源、高端智能装备制造等领域的国际经贸合作空间十分广阔。',
        pinyin: 'Suízhe gāo shuǐpíng shuāngxiàng duìwài kāifàng zhànlüè de shēnrù tuījìn, wǒ guó zài lǜsè dītàn néngyuán, gāoduān zhìnéng zhuāngbèi zhìzào děng lǐngyù de guójì jīngmào hézuò kōngjiān shífēn guǎngkuò.',
        meaning_vi: 'Cùng với sự đẩy mạnh sâu rộng của chiến lược mở cửa đối ngoại hai chiều trình độ cao, dư địa hợp tác kinh tế thương mại quốc tế của nước ta trong các lĩnh vực năng lượng xanh ít carbon và chế tạo thiết bị thông minh cao cấp là vô cùng rộng mở.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2672,
    hanzi: '空中',
    pinyin: 'kōngzhōng',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'trên không trung, giữa không gian; đường hàng không',
    examples: [
      {
        chinese: '几只白鹭在蓝天白云映衬下的空中自由自在地翱翔。',
        pinyin: 'Jǐ zhī báilù zài lántiān-báiyún yìngchèn xià de kōngzhōng zìyóu-zìzài de áoxiáng.',
        meaning_vi: 'Vài chú cò trắng bay lượn tự do tự tại trên không trung dưới nền trời xanh mây trắng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '低空经济作为新质生产力的典型代表，正在城市空中交通立体物流配送、应急消防救援以及农林植保作业中加速落地应用。',
        pinyin: 'Dīkōng jīngjì zuòwéi xīnzhì shēngchǎnlì de diǎnxíng dàibiǎo, zhèngzài chéngshì kōngzhōng jiāotōng lìtǐ wùliú pèisòng, yìngjí xiāofáng jiùyuán yǐjí nóng-lín zhíbǎo zuòyè zhōng jiāsù luòdì yìngyòng.',
        meaning_vi: 'Kinh tế tầm thấp với tư cách là đại diện tiêu biểu của lực lượng sản xuất chất lượng mới, đang đẩy nhanh ứng dụng vào đời sống trong giao thông không trung đô thị, phân phối hậu cần lập thể, cứu nạn cứu hỏa khẩn cấp và bảo vệ mùa màng nông lâm nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2673,
    hanzi: '控制',
    pinyin: 'kòngzhì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'khống chế, kiểm soát, điều khiển',
    examples: [
      {
        chinese: '在公共场合发生争执时，双方都应当克制情绪，努力控制好自己的言行。',
        pinyin: 'Zài gōnggòng chǎnghé fāshēng zhēngzhí shí, shuāngfāng dōu yīngdāng kèzhì qíngxù, nǔlì kòngzhì hǎo zìjǐ de yánxíng.',
        meaning_vi: 'Khi xảy ra tranh cãi nơi công cộng, hai bên đều nên kiềm chế cảm xúc, nỗ lực kiểm soát tốt lời nói và hành vi của mình.',
        difficulty_level: 'basic'
      },
      {
        chinese: '智能电网调度中心采用毫秒级自适应控制算法，有效解决了海量分布式风电光伏高比例并网引发的电压频率波动控制难题。',
        pinyin: 'Zhìnéng diànwǎng diàodù zhōngxīn cǎiyòng háomiǎojí zìshìyìng kòngzhì suànfǎ, yǒuxiào jiějué le hǎiliàng fēnbùshì fēngdiàn-guāngfú gāo bǐlì bìngwǎng yǐnfā de diànyā pínlǜ bōdòng kòngzhì nántí.',
        meaning_vi: 'Trung tâm điều độ lưới điện thông minh áp dụng thuật toán điều khiển tự thích ứng cấp độ mili giây, giải quyết hiệu quả bài toán hóc búa về kiểm soát biến động điện áp và tần số khi hòa mạng tỷ lệ cao nguồn điện gió và điện mặt trời phân tán khổng lồ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2674,
    hanzi: '口袋',
    pinyin: 'kǒudai',
    word_type: 'Danh từ',
    meaning_vi: 'túi quần, túi áo, túi đựng',
    examples: [
      {
        chinese: '出门前他习惯性地把钥匙和手机装在外套口袋里。',
        pinyin: 'Chūmén qián tā xíguànxìng de bǎ yàoshi hé shǒujī zhuāng zài wàitào kǒudai lǐ.',
        meaning_vi: 'Trước khi ra khỏi nhà, anh ấy theo thói quen bỏ chìa khóa và điện thoại vào túi áo khoác.',
        difficulty_level: 'basic'
      },
      {
        chinese: '脱贫攻坚战取得全面胜利后，乡村振兴政策持续发力，切实鼓起了广大偏远山区乡亲们的钱袋子，让老百姓的口袋真正鼓了起来。',
        pinyin: 'Tuōpín gōngjiānzhàn qǔdé quánmiàn shènglì hòu, xiāngcūn zhènxīng zhèngcè chíxù fālì, qièshí gǔqǐ le guǎngdà piānyuǎn shānqū xiāngqīnmen de qiándàizi, ràng lǎobǎixìng de kǒudai zhēnzhèng gǔ le qǐlái.',
        meaning_vi: 'Sau khi chiến dịch xóa đói giảm nghèo giành thắng lợi toàn diện, các chính sách chấn hưng nông thôn tiếp tục phát huy sức mạnh, làm đầy đặn thiết thực túi tiền của bà con nông dân vùng cao hẻo lánh, khiến túi áo của người dân thực sự ấm no.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2675,
    hanzi: '口味',
    pinyin: 'kǒuwèi',
    word_type: 'Danh từ',
    meaning_vi: 'khẩu vị, sở thích hương vị ăn uống',
    examples: [
      {
        chinese: '南方菜偏甜清淡，而北方菜口味通常偏咸偏浓郁。',
        pinyin: 'Nánfāng cài piān tián qīngdàn, ér běifāng cài kǒuwèi tōngcháng piān xián piān nóngyù.',
        meaning_vi: 'Món ăn phương Nam thiên về thanh đạm ngọt dịu, còn khẩu vị món ăn phương Bắc thông thường thiên về mặn và đậm đà.',
        difficulty_level: 'basic'
      },
      {
        chinese: '跨国餐饮品牌进入本土市场时，必须深入调研当地消费群体的传统饮食偏好，研发出契合区域本土口味的特色创新菜单。',
        pinyin: 'Kuàguó cānyǐn pǐnpái jìnrù běntǔ shìchǎng shí, bìxū shēnrù diàoyán dāngdì xiāofèi qúntǐ de chuántǒng yǐnshí piānhào, yánfā chū qìhé qūyù běntǔ kǒuwèi de tèsè chuàngxīn càidān.',
        meaning_vi: 'Các thương hiệu ẩm thực xuyên quốc gia khi thâm nhập thị trường bản địa phải khảo sát sâu sắc thói quen ăn uống truyền thống của nhóm người tiêu dùng sở tại, sáng tạo nên thực đơn đổi mới đặc sắc ăn khớp với khẩu vị địa phương.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2676,
    hanzi: '库',
    pinyin: 'kù',
    word_type: 'Danh từ',
    meaning_vi: 'kho, nhà kho, kho chứa, kho tàng, cơ sở dữ liệu (database)',
    examples: [
      {
        chinese: '大型水库不仅具备防洪调蓄功能，还承担着周边城市的灌溉供水重任。',
        pinyin: 'Dàxíng shuǐkù bùjǐn jùbèi fánghóng tiáoxù gōngnéng, hái chéngdān zhe zhōubiān chéngshì de guàngài gōngshuǐ zhòngrèn.',
        meaning_vi: 'Hồ chứa nước lớn không chỉ có chức năng chống lũ điều tiết nước, mà còn gánh vác trọng trách cấp nước tưới tiêu cho các đô thị lân cận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家基因库保存了数以万计濒危动植物的活性种质资源样本，为守护全球生物多样性构筑起了坚不可摧的生命种质战略储备库。',
        pinyin: 'Guójiā jīyīnkù bǎocún le shù yǐ wàn jì bīnwēi dòngzhíwù de huóxìng zhǒngzhì zīyuán yàngběn, wèi shǒuhù quánqiú shēngwù duōyàngxìng gòuzhù qǐ le jiānbùkěcuī de shēngmìng zhǒngzhì zhànlüè chǔbèikù.',
        meaning_vi: 'Ngân hàng gen quốc gia lưu giữ hàng vạn mẫu tiêu bản tài nguyên mầm gen sống của các loài động thực vật nguy cấp, dựng xây nên kho dự trữ chiến lược giống nòi sự sống kiên cố không thể phá vỡ nhằm bảo tồn tính đa dạng sinh học toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  }
]
