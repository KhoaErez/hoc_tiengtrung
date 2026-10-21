// data/hsk5-batch12-part1-data.ts
// 25 từ HSK 5: #3102 [台阶] -> #3126 [填]

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

export const HSK5_BATCH12_PART1: VocabItem[] = [
  {
    id: 3102,
    hanzi: '台阶',
    pinyin: 'táijiē',
    word_type: 'Danh từ',
    meaning_vi: 'bậc thềm, bậc thang; bậc thang danh dự/lối thoát thể diện',
    examples: [
      {
        chinese: '图书馆门前修建了宽阔平缓的石砌台阶，两旁摆放着郁郁葱葱的盆栽花卉。',
        pinyin: 'Túshūguǎn ménqián xiūjiàn le kuānkuò pínghuǎn de shíqì táijiē, liǎngpáng bǎifàng zhe yùyù-cōngcōng de pénzāi huāhuì.',
        meaning_vi: 'Trước cửa thư viện được xây dựng những bậc thềm lát đá thoai thoải rộng rãi, hai bên bày những chậu hoa cây cảnh xanh tươi mướt mắt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在激烈的商务谈判陷入僵局时，经验丰富的主持人巧妙提出折中方案，为双方体面退让铺平了台阶。',
        pinyin: 'Zài jīliè de shāngwù tánpàn xiànrù jiāngjú shí, jīngyàn fēngfù de zhǔchírén qiǎomiào tíchū zhézhōng fāng’àn, wèi shuāngfāng tǐmiàn tuìràng pūpíng le táijiē.',
        meaning_vi: 'Khi cuộc đàm phán thương mại căng thẳng rơi vào bế tắc, người chủ trì giàu kinh nghiệm đã khéo léo đưa ra phương án thỏa hiệp dung hòa, tạo lối thoát thể diện cho cả hai bên nhượng bộ trong danh dự.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3103,
    hanzi: '太太',
    pinyin: 'tàitai',
    word_type: 'Danh từ',
    meaning_vi: 'bà xã, phu nhân, bà',
    examples: [
      {
        chinese: '王教授和他的太太经常在傍晚时分手牵着手在校园林荫道上散步。',
        pinyin: 'Wáng jiàoshòu hé tā de tàitai jīngcháng zài bàngwǎn shífēn shǒu qiān zhe shǒu zài xiàoyuán línyīndào shang sànbù.',
        meaning_vi: 'Giáo sư Vương và bà xã của ông thường hay tay trong tay đi dạo trên con đường rợp bóng cây của khuôn viên trường vào lúc chập tối.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在大使馆举行的国庆招待晚宴上，外交公使携太太亲切接见了中外友好文化使者与商界杰出代表。',
        pinyin: 'Zài dàshǐguǎn jǔxíng de guóqìng zhāodài wǎnyàn shang, wàijiāo gōngshǐ xié tàitai qīnqiè jiējiàn le zhōng-wài yǒuhǎo wénhuà shǐzhě yǔ shāngjiè jiéchū dàibiǎo.',
        meaning_vi: 'Tại tiệc chiêu đãi Quốc khánh tổ chức ở đại sứ quán, ngài công sứ ngoại giao cùng phu nhân đã ân cần tiếp đón các sứ giả văn hóa hữu nghị Trung - ngoại và các đại diện xuất sắc của giới doanh nhân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3104,
    hanzi: '谈话',
    pinyin: 'tánhuà',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'nói chuyện, trò chuyện; cuộc nói chuyện, buổi hội đàm',
    examples: [
      {
        chinese: '班主任今天下午找小明谈话，耐心地鼓励他卸下包袱、积极面对近期的学业压力。',
        pinyin: 'Bānzhǔrèn jīntiān xiàwǔ zhǎo Xiǎomíng tánhuà, nàixīn de gǔlì tā xiè xià bāofu, jījí miànduì jìnqī de xuéyè yālì.',
        meaning_vi: 'Giáo viên chủ nhiệm chiều nay đã tìm gặp Tiểu Minh nói chuyện, kiên nhẫn khích lệ em trút bỏ gánh nặng tâm lý và tích cực đối mặt với áp lực học tập gần đây.',
        difficulty_level: 'basic'
      },
      {
        chinese: '纪检监察机关依规依纪对履职不力的企事业单位主要负责人开展诫勉谈话，严肃指出问题并督促限期整改落实。',
        pinyin: 'Jìjiǎn jiānchá jīgòu yīguī yījì duì lǚzhí bùlì de qǐ-shìyè dānwèi zhǔyào fùzérén kāizhǎn jièmiǎn tánhuà, yánsù zhǐchū wèntí bìng dūcù xiànqī zhěnggǎi luòshí.',
        meaning_vi: 'Cơ quan kiểm tra giám sát kỷ luật theo quy định đã triển khai cuộc nói chuyện nhắc nhở răn đe đối với người phụ trách chính của đơn vị sự nghiệp doanh nghiệp thực thi nhiệm vụ yếu kém, nghiêm túc chỉ rõ vấn đề và đốc thúc chấn chỉnh khắc phục trong thời hạn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3105,
    hanzi: '桃',
    pinyin: 'táo',
    word_type: 'Danh từ',
    meaning_vi: 'quả đào, cây đào',
    examples: [
      {
        chinese: '盛夏时节，果园里的水蜜桃挂满枝头，果肉饱满多汁，香气扑鼻。',
        pinyin: 'Shèngxià shíjié, guǒyuán lǐ de shuǐmìtáo guà mǎn zhītóu, guǒròu bǎomǎn duō zhī, xiāngqì pūbí.',
        meaning_vi: 'Vào độ giữa hè, những quả đào mật trong vườn sai trĩu cành, cùi quả căng mọng nhiều nước, tỏa hương thơm ngát.',
        difficulty_level: 'basic'
      },
      {
        chinese: '农业科研团队成功解析了地方优异蟠桃种质资源的抗逆基因序列，为培育早熟耐储运高产优质桃新品系奠定了分子育种基础。',
        pinyin: 'Nóngyè kēyán tuánduì chénggōng jiěxī le dìfāng yōuyì pántáo zhǒngzhì zīyuán de kàngnì jīyīn xùliè, wèi péiyù zǎoshú nàichǔyùn gāochǎn yōuzhì táo xīn pǐnxì diàndìng le fēnzǐ yùzhǒng jīchǔ.',
        meaning_vi: 'Nhóm nghiên cứu khoa học nông nghiệp đã giải mã thành công trình tự gen kháng nghịch của nguồn phôi đào dẹt địa phương xuất sắc, đặt nền tảng chọn giống phân tử cho việc ươm tạo dòng đào mới chất lượng cao năng suất cao chín sớm chịu được bảo quản vận chuyển.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3106,
    hanzi: '套',
    pinyin: 'tào',
    word_type: 'Lượng từ / Danh từ / Động từ',
    meaning_vi: 'bộ, sê-ri; vỏ bọc; lồng vào, chụp vào',
    examples: [
      {
        chinese: '他们在城市中心按揭购买了一套采光良好的三室两厅精装商品房。',
        pinyin: 'Tāmen zài chéngshì zhōngxīn ànjiē gòumǎi le yí tào cǎiguāng liánghǎo de sānshì-liǎngtīng jīngzhuāng shāngpǐnfáng.',
        meaning_vi: 'Họ đã vay trả góp mua một căn nhà ở thương mại ba phòng ngủ hai phòng khách đầy đủ nội thất có ánh sáng chan hòa ở trung tâm thành phố.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该科研机构成功研制出一整套具备完全自主知识产权的超导量子计算测控软硬件系统。',
        pinyin: 'Gāi kēyán jīgòu chénggōng yánzhì chū yì zhěngtào jùbèi wánquán zìzhǔ zhīshi chǎnquán de chāodǎo liàngzǐ jìsuàn cèkòng ruǎnhàrjiàn xìtǒng.',
        meaning_vi: 'Cơ quan nghiên cứu khoa học này đã nghiên cứu chế tạo thành công một bộ hoàn chỉnh hệ thống phần cứng và phần mềm đo lường điều khiển tính toán lượng tử siêu dẫn có toàn quyền sở hữu trí tuệ tự chủ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3107,
    hanzi: '特产',
    pinyin: 'tèchǎn',
    word_type: 'Danh từ',
    meaning_vi: 'đặc sản, sản vật đặc trưng vùng miền',
    examples: [
      {
        chinese: '出差旅行结束返程时，他特意在当地老字号商店买了几盒知名特产糕点带给亲友。',
        pinyin: 'Chūchāi lǚxíng jiéshù fǎnchéng shí, tā tèyì zài dāngdì lǎozìhào shāngdiàn mǎi le jǐ hé zhīmíng tèchǎn gāodiǎn dài gěi qīnyǒu.',
        meaning_vi: 'Khi kết thúc chuyến đi công tác trở về, anh ấy đã đặc biệt ghé qua cửa hàng lâu đời ở địa phương mua mấy hộp bánh đặc sản nổi tiếng mang về làm quà cho người thân và bạn bè.',
        difficulty_level: 'basic'
      },
      {
        chinese: '依托国家地理标志保护产品认证，地方政府积极引导特色农产品走产业化、品牌化的高附加值富民增收之路。',
        pinyin: 'Yītuō guójiā dìlǐ biāozhì bǎohù chǎnpǐn rènzhèng, dìfāng zhèngfǔ jījí yǐndǎo tèsè nóngchǎnpǐn zǒu chǎnyèhuà, pǐnpáihuà de gāo-fùjiāzhí fùmín-zēngshōu zhī lù.',
        meaning_vi: 'Dựa vào chứng nhận sản phẩm bảo hộ chỉ dẫn địa lý quốc gia, chính quyền địa phương tích cực định hướng nông sản đặc sản đi theo con đường nâng cao giá trị gia tăng làm giàu tăng thu nhập cho dân theo hướng sản xuất hàng hóa và thương hiệu hóa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3108,
    hanzi: '特色',
    pinyin: 'tèsè',
    word_type: 'Danh từ',
    meaning_vi: 'đặc sắc, nét đặc trưng tiêu biểu',
    examples: [
      {
        chinese: '这家坐落在老街巷深处的餐馆，以制作正宗地道的地方特色小吃而远近闻名。',
        pinyin: 'Zhè jiā zuòluò zài lǎojiē xiàng shēnchù de cānguǎn, yǐ zhìzuò zhèngzōng dìdao de dìfāng tèsè xiǎochī ér yuǎnjìn-wénmíng.',
        meaning_vi: 'Quán ăn nằm sâu trong con hẻm cổ này nổi tiếng gần xa nhờ chế biến các món ăn vặt đặc sắc chuẩn vị dân dã của địa phương.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全面推进乡村振兴必须因地制宜深挖乡土文化与生态禀赋，走出一条具有区域辨识度的特色产业高质量发展新路。',
        pinyin: 'Quánmiàn tuījìn xiāngcūn zhènxīng bìxū yīndì-zhìyí shēn wā xiāngtǔ wénhuà yǔ shēngtài bǐngfù, zǒu chū yì tiáo jùyǒu qūyù biànshídù de tèsè chǎnyè gāo-zhìliàng fāzhǎn xīn lù.',
        meaning_vi: 'Thúc đẩy toàn diện phục hưng nông thôn bắt buộc phải tùy theo điều kiện địa phương đào sâu văn hóa làng quê và nguồn tài nguyên sinh thái sẵn có, bước ra một con đường mới phát triển ngành đặc sắc chất lượng cao mang dấu ấn nhận diện vùng miền.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3109,
    hanzi: '特殊',
    pinyin: 'tèshū',
    word_type: 'Tính từ',
    meaning_vi: 'đặc thù, đặc biệt, cá biệt',
    examples: [
      {
        chinese: '如果因身体突发疾病等特殊情况无法参加期末考试，学生可以凭医院开具的诊断证明申请缓考。',
        pinyin: 'Rúguǒ yīn shēntǐ tūfā jíbìng děng tèshū qíngkuàng wúfǎ cānjiā qīmò kǎoshì, xuéshēng kěyǐ píng yīyuàn kāijù de zhěnduàn zhèngmíng shēnqǐng huǎnkǎo.',
        meaning_vi: 'Nếu vì tình huống đặc biệt như cơ thể bất ngờ ốm đau mà không thể tham gia thi học kỳ, học sinh có thể dựa vào giấy xác nhận chẩn đoán của bệnh viện để xin hoãn thi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在应对极其严峻复杂的特殊外部宏观经济周期波动中，必须出台兼顾逆周期调节与跨周期设计的系统性一揽子增量政策。',
        pinyin: 'Zài yìngduì jíqí yánjùn fùzá de tèshū wàibù hóngguān jīngjì zhōuqī bōdòng zhōng, bìxū chūtái jiāngù nì-zhōuqī tiáojié yǔ kuà-zhōuqī shèjì de xìtǒngxìng yìlǎnzǐ zēngliàng zhèngcè.',
        meaning_vi: 'Trong việc ứng phó với những biến động chu kỳ kinh tế vĩ mô bên ngoài đặc thù gay gắt và phức tạp, bắt buộc phải ban hành gói chính sách gia tăng mang tính hệ thống kết hợp hài hòa giữa điều tiết ngược chu kỳ và thiết kế liên chu kỳ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3110,
    hanzi: '特有',
    pinyin: 'tèyǒu',
    word_type: 'Tính từ',
    meaning_vi: 'đặc hữu, riêng có, vốn có',
    examples: [
      {
        chinese: '大熊猫是中国特有的珍稀野生哺乳动物，被誉为中国国宝。',
        pinyin: 'Dàxióngmāo shì Zhōngguó tèyǒu de zhēnxī yěshēng bǔrǔ dòngwù, bèi yù wèi Zhōngguó guóbǎo.',
        meaning_vi: 'Gấu trúc lớn là loài động vật có vú hoang dã quý hiếm đặc hữu của Trung Quốc, được mệnh danh là quốc bảo của Trung Hoa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '传统手工造纸技艺中所展现的独特帘纹与天然植物纤维肌理，展现出东方传统纸质文物特有的人文温度与审美意境。',
        pinyin: 'Chuántǒng shǒugōng zàozhǐ jìyì zhōng suǒ zhǎnxiàn de dútè liánwén yǔ tiānrán zhíwù xiānwéi jīlǐ, zhǎnxiàn chū dōngfāng chuántǒng zhǐzhì wénwù tèyǒu de rénwén wēndù yǔ shěnměi yìjìng.',
        meaning_vi: 'Đường vân mành độc đáo và thớ sợi thực vật tự nhiên thể hiện trong kỹ thuật làm giấy thủ công truyền thống toát lên hơi ấm nhân văn và cảnh giới thẩm mỹ đặc hữu của các cổ vật chất liệu giấy truyền thống phương Đông.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3111,
    hanzi: '特征',
    pinyin: 'tèzhēng',
    word_type: 'Danh từ',
    meaning_vi: 'đặc trưng, dấu hiệu đặc trưng',
    examples: [
      {
        chinese: '这两种植物虽然外形十分相似，但仔细观察叶片的边缘形状就能发现明显的区别特征。',
        pinyin: 'Zhè liǎng zhǒng zhíwù suīrán wàixíng shífēn xiāngsì, dàn zǐxì guānchá yèpiàn de biānyuán xíngzhuàng jiù néng fāxiàn míngxiǎn de qūbié tèzhēng.',
        meaning_vi: 'Hai loài thực vật này tuy hình dáng bên ngoài rất giống nhau nhưng quan sát kỹ hình dáng mép lá thì có thể phát hiện ra đặc trưng phân biệt rõ rệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '多维生物识别安全认证系统通过深度卷积神经网络精准提取人脸三维骨骼微结构与虹膜细微纹理特征。',
        pinyin: 'Duōwéi shēngwù shíbié ānquán rènzhèng xìtǒng tōngguò shēndù juǎnjī shénjīng wǎngluò jīngzhǔn tíqǔ rénliǎn sānwéi gǔgé wēijiégòu yǔ hóngmó xìwēi wénlǐ tèzhēng.',
        meaning_vi: 'Hệ thống chứng thực an toàn nhận dạng sinh trắc học đa chiều thông qua mạng nơ-ron tích chập sâu đã trích xuất chuẩn xác vi cấu trúc xương 3D khuôn mặt và các đặc trưng vân mắt mống mắt tinh vi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3112,
    hanzi: '疼痛',
    pinyin: 'téngtòng',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'đau đớn, nhức nhối; cơn đau',
    examples: [
      {
        chinese: '医生在给患者进行局部麻醉后，拔牙过程中几乎感觉不到任何剧烈的疼痛。',
        pinyin: 'Yīshēng zài gěi huànzhě jìnxíng júbù mázuì hòu, báyá guòchéng zhōng jīhū gǎnjué búdào rènhé jùliè de téngtòng.',
        meaning_vi: 'Sau khi bác sĩ gây tê cục bộ cho người bệnh, trong quá trình nhổ răng hầu như không cảm thấy bất kỳ cơn đau dữ dội nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代临床医学普遍推行无痛诊疗体系与术后多模式镇痛方案，有效降低创伤应激反应并显著提升患者围手术期康复质量。',
        pinyin: 'Xiàndài línchuáng yīxué pǔbiàn tuīxíng wútòng zhěnliáo tǐxì yǔ shùhòu duō-móshì zhèntòng fāng’àn, yǒuxiào jiàngdī chuāngshāng yìngjī fǎnyìng bìng xiǎnzhù tíshēng huànzhě wéishǒushùqī kāngfù zhìliàng.',
        meaning_vi: 'Y học lâm sàng hiện đại áp dụng rộng rãi hệ thống khám chữa bệnh không đau và phác đồ giảm đau đa phương thức sau mổ, hạ thấp hữu hiệu phản ứng stress do chấn thương và nâng cao rõ rệt chất lượng hồi phục chu phẫu cho người bệnh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3113,
    hanzi: '提倡',
    pinyin: 'tíchàng',
    word_type: 'Động từ',
    meaning_vi: 'đề xướng, khuyến khích, cổ vũ',
    examples: [
      {
        chinese: '学校一贯提倡厉行节约反对铺张浪费，要求同学们在食堂就餐时践行“光盘行动”。',
        pinyin: 'Xuéxiào yíguàn tíchàng lìxíng-jiéyuē fǎnduì pūzhāng-làngfèi, yāoqiú tóngxuémen zài shítáng jiùcān shí jiànxíng “guāngpán xíngdòng”.',
        meaning_vi: 'Nhà trường luôn đề xướng thực hành tiết kiệm phản đối xa hoa lãng phí, yêu cầu các bạn học sinh khi ăn cơm tại căng tin hãy thực hiện "hành động ăn sạch đĩa".',
        difficulty_level: 'basic'
      },
      {
        chinese: '全社会应当大力提倡绿色低碳循环的生活消费方式，形成崇尚节约、低碳环保的新型生态文明社会风尚。',
        pinyin: 'Quán shèhuì yīngdāng dàlì tíchàng lǜsè dītàn xúnhuán de shēnghuó xiāofèi fāngshì, xíngchéng chóngshàng jiéyuē, dītàn huánbǎo de xīnxíng shēngtài wénmíng shèhuì fēngshàng.',
        meaning_vi: 'Toàn xã hội cần ra sức đề xướng phương thức tiêu dùng sinh hoạt tuần hoàn ít carbon xanh, hình thành nếp sống xã hội văn minh sinh thái kiểu mới tôn sùng tiết kiệm và thân thiện môi trường ít carbon.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3114,
    hanzi: '提交',
    pinyin: 'tíjiāo',
    word_type: 'Động từ',
    meaning_vi: 'nộp, đệ trình, nộp lên',
    examples: [
      {
        chinese: '请各位项目负责人务必在下周五下班前，将本年度工作总结报告提交给行政部门。',
        pinyin: 'Qǐng gèwèi xiàngmù fùzérén wùbì zài xià zhōuwǔ xiàbān qián, jiāng běn niándù gōngzuò zǒngjié bàogào tíjiāo gěi xíngzhèng bùmén.',
        meaning_vi: 'Xin mời các vị phụ trách dự án nhất thiết nộp báo cáo tổng kết công tác năm nay lên bộ phận hành chính trước giờ tan làm thứ Sáu tuần sau.',
        difficulty_level: 'basic'
      },
      {
        chinese: '重大兼并重组方案经董事会审议通过后，必须依法正式提交反垄断执法主管机构进行经营者集中反垄断审查。',
        pinyin: 'Zhòngdà jiānbìng chóngzǔ fāng’àn jīng dǒngshìhuì shěnyì tōngguò hòu, bìxū yīfǎ zhèngshì tíjiāo fǎnlǒngduàn zhífǎ zhǔguǎn jīgòu jìnxíng jīngyíngzhě jízhōng fǎnlǒngduàn shěnchá.',
        meaning_vi: 'Phương án sáp nhập tái cấu trúc trọng đại sau khi được hội đồng quản trị xem xét thông qua bắt buộc phải chính thức đệ trình lên cơ quan chủ quản thực thi luật chống độc quyền theo luật định để thẩm tra chống độc quyền tập trung người kinh doanh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3115,
    hanzi: '题目',
    pinyin: 'tímù',
    word_type: 'Danh từ',
    meaning_vi: 'đề mục, chủ đề, câu hỏi đề thi',
    examples: [
      {
        chinese: '在答题卡上作答之前，请务必仔细阅读试卷上的每一道题目要求。',
        pinyin: 'Zài dātíkǎ shang zuòdá zhīqián, qǐng wùbì zǐxì yuèdú shìjuàn shang de měi yí dào tímù yāoqiú.',
        meaning_vi: 'Trước khi làm bài trên phiếu trả lời, xin nhất thiết phải đọc kỹ càng yêu cầu của từng câu hỏi trên đề thi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '研究生毕业论文选题应当紧扣学科前沿理论动态与国家重大工程实际急需，避免题目空泛脱离实践。',
        pinyin: 'Yánjiūshēng bìyè lùnwén xuǎntí yīngdāng jǐnkòu xuékē qiányán lǐlùn dòngtài yǔ guójiā zhòngdà gōngchéng shíjì jíxū, bìmiǎn tímù kōngfàn tuōlí shíjiàn.',
        meaning_vi: 'Việc lựa chọn đề tài luận văn tốt nghiệp của học viên cao học cần bám sát diễn biến lý luận mũi nhọn của ngành học và nhu cầu thực tế cấp bách của các công trình trọng điểm quốc gia, tránh để đề tài rỗng tuếch xa rời thực tiễn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3116,
    hanzi: '提起',
    pinyin: 'tíqǐ',
    word_type: 'Động từ',
    meaning_vi: 'nhắc tới, đề cập đến; nhấc lên, xách lên',
    examples: [
      {
        chinese: '每当提起那位当年在艰苦岁月里无私帮助过自己的老班长，他眼里总是闪烁着感激的泪花。',
        pinyin: 'Měidāng tíqǐ nà wèi dāngnián zài jiānkǔ suìyuè lǐ wúsī bāngzhù guò zìjǐ de lǎo bānzhǎng, tā yǎn lǐ zǒngshì shǎnshuò zhe gǎnjī de lèihuā.',
        meaning_vi: 'Mỗi khi nhắc tới người lớp trưởng năm xưa từng vô tư giúp đỡ mình trong những năm tháng gian khổ, trong mắt anh ấy luôn lấp lánh những giọt nước mắt biết ơn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '针对跨国企业严重侵害中小投资者合法权益的证券欺诈行为，投资者保护机构依法向管辖法院提起证券民事集体诉讼。',
        pinyin: 'Zhēnduì kuàguó qǐyè yánzhòng qīnhài zhōng-xiǎo tóuzīzhě héfǎ quányì de zhèngquàn qīzhà xíngwéi, tóuzīzhě bǎohù jīgòu yīfǎ xiàng guǎnxiá fǎyuàn tíqǐ zhèngquàn mínshì jítǐ sùsòng.',
        meaning_vi: 'Nhắm vào hành vi gian lận chứng khoán xâm hại nghiêm trọng quyền lợi hợp pháp của các nhà đầu tư vừa và nhỏ của doanh nghiệp đa quốc gia, cơ quan bảo vệ nhà đầu tư đã đệ đơn khởi kiện tập thể dân sự chứng khoán lên tòa án có thẩm quyền theo luật định.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3117,
    hanzi: '提升',
    pinyin: 'tíshēng',
    word_type: 'Động từ',
    meaning_vi: 'nâng cao, cải thiện, thăng tiến',
    examples: [
      {
        chinese: '为了提升团队整体的工作效率，公司定期为员工举办专业技能培训课程。',
        pinyin: 'Wèile tíshēng tuánduì zhěngtǐ de gōngzuò xiàolǜ, gōngsī dìngqī wèi yuángōng jǔbàn zhuānyè jìnéng péixùn kèchéng.',
        meaning_vi: 'Nhằm nâng cao hiệu suất làm việc chung của đội ngũ, công ty định kỳ tổ chức các khóa đào tạo kỹ năng chuyên môn cho nhân viên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '着力提升自主创新能力与产业链供应链韧性安全水平，是构建现代化产业体系并抵御外部极端风险冲击的核心支柱。',
        pinyin: 'Zhuólì tíshēng zìzhǔ chuàngxīn nénglì yǔ chǎnyèliàn gōngyìngliàn rènxìng ānquán shuǐpíng, shì gòujiàn xiàndàihuà chǎnyè tǐxì bìng dǐyù wàibù jíduān fēngxiǎn chōngjī de héxīn zhīzhù.',
        meaning_vi: 'Tập trung nâng cao năng lực đổi mới tự chủ và trình độ an toàn chống chịu của chuỗi sản xuất chuỗi cung ứng là trụ cột cốt lõi để xây dựng hệ thống ngành hiện đại và chống đỡ những cú sốc rủi ro cực đoan từ bên ngoài.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3118,
    hanzi: '提问',
    pinyin: 'tíwèn',
    word_type: 'Động từ',
    meaning_vi: 'đặt câu hỏi, nêu câu hỏi',
    examples: [
      {
        chinese: '讲座结束后留出了二十分钟的自由互动时间，现场听众纷纷举手向主讲嘉宾提问。',
        pinyin: 'Jiǎngzuò jiéshù hòu liú chū le èrshí fēnzhōng de zìyóu hùdòng shíjiān, xiànchǎng tīngzhòng fēnfēn jǔshǒu xiàng zhǔjiǎng jiābīn tíwèn.',
        meaning_vi: 'Sau khi buổi tọa đàm kết thúc đã dành ra 20 phút giao lưu tự do, thính giả tại hiện trường tới tấp giơ tay đặt câu hỏi cho vị khách mời diễn giả chính.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在国际学术前沿高峰论坛的答辩环节，与会顶尖同行专家围绕实验边界设定与多模态数据拟合精度展开了极具深度的连续提问。',
        pinyin: 'Zài guójì xuéshù qiányán gāofēng lùntán de dābiàn huánjié, yùhuì dǐngjiān tóngháng zhuānjiā wéirào shíyàn biānjiè shèdìng yǔ duō-mótài shùjù nǐhé jīngdù zhǎnkāi le jí jù shēndù de liánxù tíwèn.',
        meaning_vi: 'Trong phần bảo vệ của diễn đàn đỉnh cao học thuật mũi nhọn quốc tế, các chuyên gia đồng nghiệp hàng đầu tham dự đã liên tiếp đặt ra những câu hỏi vô cùng sâu sắc xoay quanh việc thiết lập ranh giới thí nghiệm và độ chính xác khớp dữ liệu đa phương thức.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3119,
    hanzi: '体会',
    pinyin: 'tǐhuì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'lĩnh hội, cảm nhận sâu sắc; bài học thấm thía',
    examples: [
      {
        chinese: '只有亲身经历过偏远山区的支教生活，才能深刻体会到乡村教师付出的艰辛与崇高。',
        pinyin: 'Zhǐyào qīnshēn jīnglì guò piānyuǎn shānqū de zhījiào shēnghuó, cái néng shēnkè tǐhuì dào xiāngcūn jiàoshī fùchū de jiānxīn yǔ chónggāo.',
        meaning_vi: 'Chỉ khi đích thân trải qua cuộc sống đi dạy tình nguyện ở vùng núi hẻo lánh thì mới có thể thấm thía sâu sắc những gian khổ nhọc nhằn và sự cao cả mà các giáo viên làng quê đã bỏ ra.',
        difficulty_level: 'basic'
      },
      {
        chinese: '从波澜壮阔的百年工业化奋斗征程中，我们深刻体会到坚持科技自主创新与弘扬工匠精神是实现制造强国的必由之路。',
        pinyin: 'Cóng bōlán-zhuàngkuò de bǎinián gōngyèhuà fèndòu zhēngchéng zhōng, wǒmen shēnkè tǐhuì dào jiānchí kējì zìzhǔ chuàngxīn yǔ hóngyáng gōngjiàng jīngshén shì shíxiàn zhìzào qiángguó de bìyóuzhīlù.',
        meaning_vi: 'Từ chặng đường phấn đấu công nghiệp hóa trăm năm hào hùng tráng lệ, chúng ta thấm thía sâu sắc rằng kiên trì đổi mới công nghệ tự chủ và phát huy tinh thần người thợ thủ công lành nghề là con đường tất yếu để hiện thực hóa một cường quốc chế tạo.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3120,
    hanzi: '体力',
    pinyin: 'tǐlì',
    word_type: 'Danh từ',
    meaning_vi: 'thể lực, sức lực cơ bắp',
    examples: [
      {
        chinese: '经过长达四十公里的马拉松长跑，参赛选手的体力几乎已经消耗到了极限。',
        pinyin: 'Jīngguò cháng dá sìshí gōnglǐ de mǎlāsōng chángpǎo, cānsài xuǎnshǒu de tǐlì jīhū yǐjīng xiāohào dào le jíxiàn.',
        meaning_vi: 'Sau cuộc chạy cự ly dài marathon hơn 40 km, thể lực của các vận động viên dự thi hầu như đã tiêu hao tới giới hạn cực đại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '工业外骨骼机器人的推广应用大幅减轻了重载搬运工人的体力负荷，有力保障了特种作业工人的职业健康与作业安全。',
        pinyin: 'Gōngyè wàigǔgé jīqìrén de tuīguǎng yìngyòng dàfú jiǎnqīng le zhòngzǎi bānyùn gōngrén de tǐlì fùhè, yǒulì bǎozhàng le tèzhǒng zuòyè gōngrén de zhíyè jiànkāng yǔ zuòyè ānquán.',
        meaning_vi: 'Việc nhân rộng ứng dụng robot khung xương ngoài công nghiệp đã giảm tải mạnh mẽ gánh nặng thể lực cho công nhân bốc vác tải trọng nặng, bảo đảm vững chắc sức khỏe nghề nghiệp và an toàn tác nghiệp cho công nhân làm việc đặc thù.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3121,
    hanzi: '体现',
    pinyin: 'tǐxiàn',
    word_type: 'Động từ',
    meaning_vi: 'thể hiện, biểu hiện ra, phản ánh',
    examples: [
      {
        chinese: '在公共汽车上主动给老弱病残孕乘客让座，体现了良好的社会文明公德。',
        pinyin: 'Zài gōnggòng qìchē shang zhǔdòng gěi lǎo-ruò-bìng-cán-yùn chéngkè ràngzuò, tǐxiàn le liánghǎo de shèhuì wénmíng gōngdé.',
        meaning_vi: 'Chủ động nhường ghế cho hành khách già yếu bệnh tật mang thai trên xe buýt thể hiện đạo đức văn minh công cộng tốt đẹp của xã hội.',
        difficulty_level: 'basic'
      },
      {
        chinese: '坚持在发展中保障和改善民生，切实解决人民群众急难愁盼问题，集中体现了我们党全心全意为人民服务的根本宗旨。',
        pinyin: 'Jiānchí zài fāzhǎn zhōng bǎozhàng hé gǎishàn mínshēng, qièshí jiějué rénmín qúnzhòng jínán-chóupàn wèntí, jízhōng tǐxiàn le wǒmen dǎng quánxīn-quányì wèi rénmín fúwù de gēnběn zōngzhǐ.',
        meaning_vi: 'Kiên trì bảo đảm và cải thiện dân sinh trong quá trình phát triển, thiết thực giải quyết các vấn đề cấp bách thiết thân của quần chúng nhân dân đã thể hiện tập trung tôn chỉ căn bản hết lòng hết sức phục vụ nhân dân của Đảng ta.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3122,
    hanzi: '体验',
    pinyin: 'tǐyàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'trải nghiệm; sự trải nghiệm thực tế',
    examples: [
      {
        chinese: '科技馆里的虚拟现实互动展区为前来参观的小朋友们提供了身临其境的太空漫游体验。',
        pinyin: 'Kējìguǎn lǐ de xūnǐ xiànshí hùdòng zhǎnqū wèi qiánlái cānguān de xiǎopéngyǒumen tígōng le shēnlínqíjìng de tàikōng mànyóu tǐyàn.',
        meaning_vi: 'Khu triển lãm tương tác thực tế ảo trong bảo tàng khoa học đã mang lại trải nghiệm du ngoạn vũ trụ như đang trực tiếp đắm mình trong không gian cho các em nhỏ tới tham quan.',
        difficulty_level: 'basic'
      },
      {
        chinese: '移动应用产品架构师必须将敏捷开发与深度用户体验反馈循环紧密结合，持续打磨微秒级界面响应与直觉化交互设计。',
        pinyin: 'Yídòng yìngyòng chǎnpǐn jiàgòushī bìxū jiāng mǐnjié kāifā yǔ shēndù yònghù tǐyàn fǎnkuì xúnhuán jǐnmì jiéhé, chíxù dǎmó wēimiǎojí jièmiàn xiǎngyìng yǔ zhíjuéhuà jiāohù shèjì.',
        meaning_vi: 'Kiến trúc sư sản phẩm ứng dụng di động bắt buộc phải kết hợp chặt chẽ việc phát triển linh hoạt với vòng lặp phản hồi trải nghiệm người dùng chuyên sâu, liên tục mài giũa tốc độ phản hồi giao diện tính bằng micro giây và thiết kế tương tác theo trực giác.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3123,
    hanzi: '替',
    pinyin: 'tì',
    word_type: 'Động từ / Giới từ',
    meaning_vi: 'thay thế; thay cho, giùm cho',
    examples: [
      {
        chinese: '同事今天突发生病请假，热心的张明主动替他承担了下午的客户接待工作。',
        pinyin: 'Tóngshì jīntiān tūfā shēngbìng qǐngjià, rèxīn de Zhāng Míng zhǔdòng tì tā chéngdān le xiàwǔ de kèhù jiēdài gōngzuò.',
        meaning_vi: 'Đồng nghiệp hôm nay đột nhiên bị ốm xin nghỉ, Trương Minh nhiệt tình đã chủ động làm thay anh ấy công việc tiếp đón khách hàng buổi chiều.',
        difficulty_level: 'basic'
      },
      {
        chinese: '工业智能化升级的核心逻辑是用高精度机械装备替代高危繁重的人力劳动，从而大幅提升生产本质安全水平。',
        pinyin: 'Gōngyè zhìnénghuà shēngjí de héxīn luóji shì yòng gāo-jīngdù jīxiè zhuāngbèi tìdài gāowēi fánzhòng de rénlì láodòng, cóng’ér dàfú tíshēng shēngchǎn běnzhì ānquán shuǐpíng.',
        meaning_vi: 'Logic cốt lõi của nâng cấp thông minh hóa công nghiệp là dùng trang thiết bị cơ giới hóa độ chính xác cao để thay thế lao động chân tay nặng nhọc nguy hiểm, từ đó nâng cao mạnh mẽ trình độ an toàn bản chất trong sản xuất.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3124,
    hanzi: '天空',
    pinyin: 'tiānkōng',
    word_type: 'Danh từ',
    meaning_vi: 'bầu trời, vòm trời',
    examples: [
      {
        chinese: '雨后初晴，蔚蓝的天空中架起了一道绚丽夺目的七色彩虹。',
        pinyin: 'Yǔ hòu chū qíng, wèilán de tiānkōng zhōng jià qǐ le yí dào xuànlì-duómù de qīsè cǎihóng.',
        meaning_vi: 'Mưa tạnh trời hửng nắng, trên bầu trời trong xanh bắc lên một dải cầu vồng bảy sắc lung linh rực rỡ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大力发展低空经济与无人驾驶载人eVTOL航空器，正在重构现代立体交通网络并向广阔的天空拓展城市发展新维度。',
        pinyin: 'Dàlì fāzhǎn dīkōng jīngjì yǔ wúrén jiàshǐ zàirén eVTOL hángkōngqì, zhèngzài chónggòu xiàndài lìtǐ jiāotōng wǎngluò bìng xiàng guǎngkuò de tiānkōng tuòzhǎn chéngshì fāzhǎn xīn wéidù.',
        meaning_vi: 'Ra sức phát triển kinh tế tầm thấp và phương tiện bay chở người không người lái eVTOL đang tái cấu trúc mạng lưới giao thông lập thể hiện đại và mở rộng chiều hướng phát triển đô thị mới vươn tới vòm trời bao la.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3125,
    hanzi: '天上',
    pinyin: 'tiānshàng',
    word_type: 'Danh từ',
    meaning_vi: 'trên trời, trên không trung',
    examples: [
      {
        chinese: '夏天的夜晚凉风习习，天上挂着一轮皎洁明亮的弯弯月亮。',
        pinyin: 'Xiàtiān de yèwǎn liángfēng-xíxí, tiānshang guà zhe yì lún jiǎojié míngliàng de wānwān yuèliang.',
        meaning_vi: 'Đêm mùa hè gió mát hiu hiu, trên trời treo một vầng trăng khuyết sáng trong vằng vặc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '我国高分辨率对地观测系统犹如日夜巡航在天上的“天眼”，为国家资源勘查、生态监测与防灾减灾提供高频遥感保障。',
        pinyin: 'Wǒguó gāo-fēnbianlǜ duìdì guāncè xìtǒng yóurú rìyè xúnháng zài tiānshang de “tiānyǎn”, wèi guójiā zīyuán kānchá, shēngtài jiānkòng yǔ fángzāi-jiǎnzāi tígōng gāopín yáogǎn bǎozhàng.',
        meaning_vi: 'Hệ thống quan sát Trái Đất độ phân giải cao của nước ta tựa như "mắt thần" ngày đêm tuần tra trên trời, bảo đảm viễn thám tần suất cao cho công tác thăm dò tài nguyên quốc gia, giám sát sinh thái và phòng chống giảm nhẹ thiên tai.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3126,
    hanzi: '填',
    pinyin: 'tián',
    word_type: 'Động từ',
    meaning_vi: 'điền vào, lấp đầy, viết vào',
    examples: [
      {
        chinese: '报考大学志愿时，考生需要认真核对代码并准确填报志愿表格。',
        pinyin: 'Bàokǎo dàxué zhìyuàn shí, kǎoshēng xūyào rènzhēn héduì dàimǎ bìng zhǔnquè tiánbào zhìyuàn biǎogé.',
        meaning_vi: 'Khi đăng ký nguyện vọng đại học, thí sinh cần đối chiếu kỹ mã ngành và điền chính xác vào biểu mẫu nguyện vọng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '自主研制第四代核电高温气冷堆燃料元件，成功填补了我国在先进商用核电固有安全堆型关键材料领域的空白。',
        pinyin: 'Zìzhǔ yánzhì dì-sì-dài hédiàn gāowēn qìlěngduī ránliào yuánjiàn, chénggōng tiánbǔ le wǒguó zài xiānjìn shāngyòng hédiàn gùyǒu ānquán duīxíng guānjiàn cáiliào lǐngyù de kòngbái.',
        meaning_vi: 'Việc tự chủ nghiên cứu chế tạo thành công nguyên tố nhiên liệu lò phản ứng hạt nhân khí làm mát nhiệt độ cao thế hệ thứ tư đã lấp đầy khoảng trống của nước ta trong lĩnh vực vật liệu then chốt cho các mẫu lò an toàn nội tại thương mại tiên tiến.',
        difficulty_level: 'applied'
      }
    ]
  }
]
