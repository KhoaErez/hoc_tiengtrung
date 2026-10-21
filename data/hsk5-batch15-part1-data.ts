// data/hsk5-batch15-part1-data.ts
// 25 từ HSK 5: #3402 [由此] -> #3426 [玉米]

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

export const HSK5_BATCH15_PART1: VocabItem[] = [
  {
    id: 3402,
    hanzi: '由此',
    pinyin: 'yóu cǐ',
    word_type: 'Cụm từ / Phó từ',
    meaning_vi: 'do đó, từ đó, từ điều này',
    examples: [
      {
        chinese: '他在大学期间刻苦钻研算法并多次在国际竞赛中获奖，由此积累了扎实的专业技术功底。',
        pinyin: 'Tā zài dàxué qījiān kèkǔ zuānyán suànfǎ bìng duō cì zài guójì jìngsài zhōng huòjiǎng, yóucǐ jīlěi le zhāshi de zhuānyè jìshù gōngdǐ.',
        meaning_vi: 'Trong thời gian học đại học anh ấy đã khổ công nghiên cứu thuật toán và nhiều lần đoạt giải trong các cuộc thi quốc tế, từ đó tích lũy được nền tảng kỹ thuật chuyên môn vững chắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高精度数控机床关键核心主轴与轴承制造工艺取得了根本性突破，由此带动了高端装备制造全产业链的提质升级。',
        pinyin: 'Gāojīngdù shùkòng jīchuáng guānjiàn héxīn zhǔzhóu yǔ zhóuchéng zhìzào gōngyì qǔdé le gēnběnxìng tūpò, yóucǐ dàidòng le gāoduān zhuāngbèi zhìzào quán-chǎnyèliàn de tízhì shēngjí.',
        meaning_vi: 'Quy trình chế tạo trục chính và vòng bi then chốt cốt lõi của máy công cụ CNC độ chính xác cao đã đạt được bước đột phá mang tính căn bản, do đó thúc đẩy sự nâng cấp nâng cao chất lượng toàn bộ chuỗi công nghiệp chế tạo thiết bị cao cấp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3403,
    hanzi: '邮寄',
    pinyin: 'yóujì',
    word_type: 'Động từ',
    meaning_vi: 'gửi qua bưu điện, gửi bưu phẩm',
    examples: [
      {
        chinese: '请您将签署好的纸质商业合同原件妥善装入特快专递信封，并在今天下午下班前通过邮局邮寄出去。',
        pinyin: 'Qǐng nín jiāng qiānshǔ hǎo de zhǐzhì shāngyè hétong yuánjiàn tuǒshàn zhuāng rù tèkuài-zhuāndì xìnfēng, bìng zài jīntiān xiàwǔ xiàbān qián tōngguò yóujú yóujì chūqù.',
        meaning_vi: 'Xin quý vị hãy bỏ bản gốc hợp đồng thương mại dạng giấy đã ký vào phong bì chuyển phát nhanh cẩn thận và gửi qua đường bưu điện trước giờ tan làm chiều nay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '涉外知识产权司法仲裁法庭严格规范法律文书与关键原始物证的跨国公证邮寄送达流程，确保送达行为具有无可辩驳的法定公信力。',
        pinyin: 'Shèwài zhīshi chǎnquán sīfǎ zhòngcái fǎtíng yángé guīfàn fǎlǜ wénshū yǔ guānjiàn yuánshǐ wùzhèng de kuàguó gōngzhèng yóujì sòngdá liúchéng, quèbǎo sòngdá xíngwéi jùyǒu wúkě-biànbó de fǎdìng gōngxìnlì.',
        meaning_vi: 'Tòa án trọng tài tư pháp sở hữu trí tuệ đối ngoại quy chuẩn nghiêm ngặt quy trình gửi chuyển bưu điện có công chứng xuyên quốc gia đối với các văn bản pháp lý và vật chứng gốc then chốt, bảo đảm hành vi tống đạt có độ tin cậy pháp định không thể tranh cãi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3404,
    hanzi: '邮局',
    pinyin: 'yóujú',
    word_type: 'Danh từ',
    meaning_vi: 'bưu điện, bưu cục',
    examples: [
      {
        chinese: '街道拐角处有一家历史悠久的老邮局，门口摆放的墨绿色老式邮筒承载了这座小镇几代人的美好回忆。',
        pinyin: 'Jiēdào guǎijiǎochù yǒu yī jiā lìshǐ yōujiǔ de lǎo yóujú, ménkǒu bǎifàng de mòlǜsè lǎoshì yóutǒng chéngzài le zhè zuò xiǎozhèn jǐ dài rén de měihǎo huíyì.',
        meaning_vi: 'Nơi góc phố có một bưu điện cũ lâu đời, thùng thư kiểu cũ màu xanh lục sẫm đặt trước cửa mang theo những ký ức tươi đẹp của bao thế hệ cư dân thị trấn nhỏ này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家在边远高原边境村寨统筹推进智慧绿色邮政便民示范工程，将传统乡村邮局全面升级为融汇政务便民、农产品寄递与农村电商的综合服务枢纽。',
        pinyin: 'Guójiā zài biānyuǎn gāoyuán biānjìng cūnzhài tǒngchóu tuījìn zhìhuì lǜsè yóuzhèng biànmín shìfàn gōngchéng, jiāng chuántǒng xiāngcūn yóujú quánmiàn shēngjí wéi rónghuì zhèngwù biànmín, nóngchǎnpǐn jìdì yǔ nóngcūn diànshāng de zōnghé fúwù shūniǔ.',
        meaning_vi: 'Nhà nước điều phối thúc đẩy công trình kiểu mẫu tiện dân bưu chính xanh thông minh tại các bản làng biên giới vùng cao hẻo lánh, nâng cấp toàn diện các bưu điện thôn quê truyền thống thành đầu mối dịch vụ tổng hợp kết hợp các thủ tục hành chính công tiện ích, chuyển phát nông sản và thương mại điện tử nông thôn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3405,
    hanzi: '游览',
    pinyin: 'yóulǎn',
    word_type: 'Động từ',
    meaning_vi: 'du lãm, tham quan, ngắm cảnh',
    examples: [
      {
        chinese: '每年金秋十月，来自世界各地的数十万名游客都会来到北京，登临长城饱览壮丽的崇山峻岭与秋色美景。',
        pinyin: 'Měinián jīnqiū shíyuè, láizì shìjiè gèdì de shù shí wàn míng yóukè dōu huì lái dào Běijīng, dēnglín chángchéng bǎolǎn zhuànglì de chóngshān-jùnlǐng yǔ qiūsè měijǐng.',
        meaning_vi: 'Hàng năm vào tháng mười mùa thu vàng, hàng trăm nghìn du khách từ khắp nơi trên thế giới đều đến Bắc Kinh, trèo lên vạn lý trường thành thưởng lãm cảnh sắc mùa thu tuyệt đẹp cùng núi non trùng điệp hùng vĩ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家文旅数字化工程运用高精度空间数字孪生与全景视网膜漫游技术，为全球广大文博爱好者打造沉浸式在线深度游览世界文化遗产的新模式。',
        pinyin: 'Guójiā wén-lǚ shùzìhuà gōngchéng yùnyòng gāojīngdù kōngjiān shùzì luànshēng yǔ quánjǐng shìwǎngmó mànyóu jìshù, wèi quánqiú guǎngdà wénbó àihàozhě dǎzào chénjìnshì zàixiàn shēndù yóulǎn shìjiè wénhuà yíchǎn de xīn móshì.',
        meaning_vi: 'Công trình số hóa văn hóa du lịch quốc gia ứng dụng công nghệ bản sao số không gian độ chính xác cao và dạo chơi võng mạc toàn cảnh, tạo dựng mô hình mới tham quan chiều sâu trực tuyến đắm chìm các di sản văn hóa thế giới cho đông đảo người yêu thích bảo tàng trên toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3406,
    hanzi: '邮票',
    pinyin: 'yóupiào',
    word_type: 'Danh từ',
    meaning_vi: 'tem bưu chính, con tem',
    examples: [
      {
        chinese: '集邮爱好者的精美硬质集邮册里整齐地收藏着多枚纪念中国航天载人飞行圆满成功的珍贵邮票。',
        pinyin: 'Jíyóu àihàozhě de jīngměi yìngzhì jíyóucè lǐ zhěngqí de shōucáng zhe duō méi jìniàn Zhōngguó hángtiān zàirén fēixíng yuánmǎn chénggōng de zhēnguì yóupiào.',
        meaning_vi: 'Trong cuốn album sưu tầm tem bìa cứng tinh xảo của người đam mê sưu tầm tem lưu trữ ngay ngắn nhiều con tem quý giá kỷ niệm chuyến bay có người lái thành công tốt đẹp của ngành hàng không vũ trụ Trung Quốc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家邮政行政部门正式发行一套融汇光学防伪微缩凹印工艺与嵌入式芯片防伪技术的重大历史工程纪念邮票，具有极高的艺术与历史收藏价值。',
        pinyin: 'Guójiā yóuzhèng xíngzhèng bùmén zhèngshì fāxíng yī tào rónghuì guāngxué fángwěi wēisuō āoyìn gōngyì yǔ qiànrùshì xīnpiàn fángwěi jìshù de zhòngdà lìshǐ gōngchéng jìniàn yóupiào, jùyǒu jí gāo de yìshù yǔ lìshǐ shōucáng jiàzhí.',
        meaning_vi: 'Cơ quan hành chính bưu chính quốc gia chính thức phát hành một bộ tem kỷ niệm công trình lịch sử trọng đại kết hợp công nghệ in lõm vi mô chống giả quang học và kỹ thuật chống giả bằng chip nhúng, có giá trị sưu tầm lịch sử và nghệ thuật rất cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3407,
    hanzi: '油条',
    pinyin: 'yóutiáo',
    word_type: 'Danh từ',
    meaning_vi: 'quẩy, quẩy rán, giò cháo quẩy',
    examples: [
      {
        chinese: '冬日清晨，一碗热气腾腾的原汁磨制豆浆搭配两根刚刚出锅、色泽金黄香脆的油条，是极具烟火气的经典中式传统早餐。',
        pinyin: 'Dōngrì qīngchén, yī wǎn rèqì-téngténg de yuánzhī mózhì dòujiāng dāpèi liǎng gēn gānggāng chūguō, sèzé jīnhuáng xiāngcuì de yóutiáo, shì jí jù yānhuǒqì de jīngdiǎn Zhōngshì chuántǒng zǎocān.',
        meaning_vi: 'Sáng sớm ngày đông, một bát sữa đậu nành xay nguyên chất bốc khói nghi ngút kết hợp với hai chiếc quẩy vàng ươm giòn rụm vừa vớt ra khỏi chảo là bữa sáng truyền thống kiểu Trung kinh điển đậm đà hơi thở nhân sinh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '传统特色面点工业化龙头企业通过自主研发低温急冻锁鲜与无铝环保膨松工艺配方，成功实现了非遗传统经典油条的全自动无菌洁净流水线生产。',
        pinyin: 'Chuántǒng tèsè miàndiǎn gōngyèhuà lóngtóu qǐyè tōngguò zìzhǔ yánfā dīwēn jídòng suǒxiān yǔ wú-lǚ huánbǎo péngsōng gōngyì pèifāng, chénggōng shíxiàn le fēiyí chuántǒng jīngdiǎn yóutiáo de quán-zìdòng wújūn jiéjìng liúshuǐxiàn shēngchǎn.',
        meaning_vi: 'Doanh nghiệp đầu ngành công nghiệp hóa bánh ngọt đặc sản truyền thống thông qua việc tự nghiên cứu phát triển công thức công nghệ làm nở thân thiện với môi trường không chứa nhôm và cấp đông nhiệt độ thấp giữ trọn độ tươi, đã thực hiện thành công việc sản xuất trên dây chuyền tự động hóa hoàn toàn vô trùng sạch sẽ cho món quẩy kinh điển truyền thống di sản phi vật thể.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3408,
    hanzi: '犹豫',
    pinyin: 'yóuyù',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'do dự, ngập ngừng, lưỡng lự',
    examples: [
      {
        chinese: '面对眼前这个极为珍贵难得的国家公派海外顶尖学府进修深造名额，他没有丝毫犹豫，当即填写并递交了报名申请表。',
        pinyin: 'Miànduì yǎnqián zhè gè jíwéi zhēnguì nándé de guójiā gōngpài hǎiwài dǐngjiān xuéfǔ jìnxiū shēnzào míng’é, tā méiyǒu sīháo yóuyù, dāngjí tiánxiě bìng dìjiāo le bàomíng shēnqǐngbiǎo.',
        meaning_vi: 'Đối diện với suất cử đi tu nghiệp nâng cao tại trường đại học đỉnh cao hải ngoại theo diện công phái của nhà nước vô cùng quý giá hiếm có này, anh ấy không chút do dự, lập tức điền và nộp đơn đăng ký dự tuyển.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在百年变局加速演进与前沿颠覆性技术竞争的关键战略抉择关口，科技领军实体企业绝不可犹豫不决、错失自主研发的黄金窗口期。',
        pinyin: 'Zài bǎinián biànjú jiāsù yǎnjìn yǔ qiányán diānfùxìng jìshù jìngzhēng de guānjiàn zhànlüè juézé guānkǒu, kējì lǐngjūn shítǐ qǐyè jué bù kě yóuyù-bùjué, cuòshī zìzhǔ yánfā de huángjīn chuāngkǒuqī.',
        meaning_vi: 'Tại ngã rẽ lựa chọn chiến lược then chốt của sự tiến biến tăng tốc trong biến cuộc trăm năm và cạnh tranh công nghệ đột phá tiền duyên, các doanh nghiệp thực thể công nghệ dẫn đầu tuyệt đối không thể do dự thiếu quyết đoán để tuột mất thời kỳ cửa sổ vàng của nghiên cứu phát triển tự chủ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3409,
    hanzi: '有害',
    pinyin: 'yǒu hài',
    word_type: 'Tính từ',
    meaning_vi: 'có hại, độc hại, gây hại',
    examples: [
      {
        chinese: '长期吸烟、过度酗酒以及经常熬夜，对人体的心血管循环系统与大脑神经健康都是极其有害的不良生活习惯。',
        pinyin: 'Chángqī xīyān, guòdù xùjiǔ yǐjí chángcháng áoyè, duì réntǐ de xīnxuèguǎn xúnhuán xìtǒng yǔ dànǎo shénjīng jiànkāng dōu shì jíqí yǒuhài de bùliáng shēnghuó xíguàn.',
        meaning_vi: 'Hút thuốc lâu năm, lạm dụng rượu bia quá đà cũng như thường xuyên thức khuya đều là những thói quen sinh hoạt xấu cực kỳ có hại đối với hệ tuần hoàn tim mạch và sức khỏe thần kinh não bộ của con người.',
        difficulty_level: 'basic'
      },
      {
        chinese: '生态环境生态执法监察总队依法重拳惩处工业企业在未获许可情况下非法倾倒工业危废与持久性有机有害化学品的重大环境违法犯罪行为。',
        pinyin: 'Shēngtài huánjìng shēngtài zhífǎ jiānchá zǒngduì yīfǎ zhòngquán chéngchǔ gōngyè qǐyè zài wèihuò xǔkě qíngkuàng xià fēifǎ qīngdào gōngyè wēifèi yǔ chíjiǔxìng yǒujī yǒuhài huàxuépǐn de zhòngdà huánjìng wéifǎ fànzuì xíngwéi.',
        meaning_vi: 'Tổng đội thanh tra thực thi pháp luật môi trường sinh thái căn cứ theo luật định giáng đòn mạnh mẽ trừng trị hành vi phạm tội vi phạm môi trường nghiêm trọng của các doanh nghiệp công nghiệp khi đổ trộm chất thải nguy hại công nghiệp và hóa chất độc hại hữu cơ khó phân hủy mà không có giấy phép.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3410,
    hanzi: '有力',
    pinyin: 'yǒulì',
    word_type: 'Tính từ',
    meaning_vi: 'có lực, mạnh mẽ, đắc lực',
    examples: [
      {
        chinese: '他在青年辩论赛决赛中的发言立论严密、论据充分详实，对反驳对手的片面观点起到了极其有力的说服作用。',
        pinyin: 'Tā zài qīngnián biànlùnsài juésài zhōng de fāyán lìlùn yánmì, lùnjù chōngfèn xiángshí, duì fǎnbó duìshǒu de piànmiàn guāndiǎn qǐdào le jíqí yǒulì de shuōfú zuòyòng.',
        meaning_vi: 'Phát biểu của anh ấy trong trận chung kết cuộc thi tranh biện thanh niên lập luận chặt chẽ, luận cứ đầy đủ xác thực, đã phát huy tác dụng thuyết phục vô cùng mạnh mẽ trong việc phản bác các quan điểm phiến diện của đối phương.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家适时出台一揽子有力度的宏观逆周期调节与扩大有效投资政策组合拳，为推动实体经济平稳健康向好发展提供了坚实有力的战略支撑。',
        pinyin: 'Guójiā shìshí chūtái yī lǎn zi yǒu lìdù de hóngguān nì-zhōuqī tiáojié yǔ kuòdà yǒuxiào tóuzī zhèngcè zǔhéquán, wèi tuīdòng shítǐ jīngjì píngwěn jiànkāng xiànghǎo fāzhǎn tígōng le jiānshí yǒulì de zhànlüè zhīchēng.',
        meaning_vi: 'Nhà nước kịp thời đưa ra gói giải pháp chính sách có độ lực mạnh mẽ kết hợp điều tiết nghịch chu kỳ vĩ mô và mở rộng đầu tư hiệu quả, cung cấp bệ đỡ chiến lược vững chắc và đầy uy lực để thúc đẩy nền kinh tế thực thể phát triển ổn định, lành mạnh và theo chiều hướng tích cực.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3411,
    hanzi: '有利',
    pinyin: 'yǒulì',
    word_type: 'Tính từ',
    meaning_vi: 'có lợi, thuận lợi, có ích',
    examples: [
      {
        chinese: '每天坚持在新鲜空气中进行半小时以上的轻度有氧运动，对于促进机体新陈代谢与保持心理健康极其有利。',
        pinyin: 'Měitiān jiānchí zài xīnxiān kōngqì zhōng jìnxíng bàn xiǎoshí yǐshàng de qīngdù yǒuyǎng yùndòng, duìyú cùjìn jītǐ xīnhéndàixiè yǔ bǎochí xīnlǐ jiànkāng jíqí yǒulì.',
        meaning_vi: 'Mỗi ngày kiên trì vận động hiếu khí nhẹ nhàng từ nửa giờ trở lên trong không khí trong lành là cực kỳ có lợi cho việc thúc đẩy trao đổi chất của cơ thể và duy trì sức khỏe tâm lý.',
        difficulty_level: 'basic'
      },
      {
        chinese: '加快建设全国统一大市场并全面清理废除地方保护隐性壁垒，极其有利于各类先进生产要素在全国大市场空间内自由畅通流动与高效集聚。',
        pinyin: 'Jiākuài jiànshè quánguó tǒngyī dà shìchǎng bìng quánmiàn qīnglǐ fèichú dìfāng bǎohù yǐnxìng bìlěi, jíqí yǒulì yú gè lèi xiānjìn shēngchǎn yàosù zài quánguó dà shìchǎng kōngjiān nèi zìyóu chàngtōng liúdòng yǔ gāoxiào jíjù.',
        meaning_vi: 'Đẩy nhanh xây dựng thị trường lớn thống nhất trên toàn quốc và thanh lọc xóa bỏ triệt để các rào cản vô hình mang tính bảo hộ cục bộ địa phương là vô cùng thuận lợi để các loại yếu tố sản xuất tiên tiến lưu thông tự do thông suốt và quy tụ hiệu quả cao trong không gian thị trường lớn cả nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3412,
    hanzi: '有限',
    pinyin: 'yǒuxiàn',
    word_type: 'Tính từ',
    meaning_vi: 'có hạn, hữu hạn',
    examples: [
      {
        chinese: '个人的时间与精力虽然是有限的，但一个人全心全意为社会奉献爱心、服务大众的精神与追求却是无限的。',
        pinyin: 'Gèrén de shíjiān yǔ jīnglì suīrán shì yǒuxiàn de, dàn yī gè rén quánxīn-quányì wèi shèhuì fèngxiàn àixīn, fúwù dàzhòng de jīngshén yǔ zhuīqiú què shì wúxiàn de.',
        meaning_vi: 'Thời gian và sức lực của mỗi cá nhân dẫu là có hạn, nhưng tinh thần và sự theo đuổi hết lòng hết dạ cống hiến tình thương cho xã hội, phụng sự quảng đại quần chúng của một con người lại là vô hạn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在极端水资源极为紧缺有限的干旱与半干旱内陆农耕区，农业水利科研团队全力攻克水肥一体化地下微孔渗灌技术以大幅提升水分利用率。',
        pinyin: 'Zài jíduān shuǐzīyuán jíwéi jǐnquē yǒuxiàn de gānhàn yǔ bàn-gānhàn nèilù nónggēngqū, nóngyè shuǐlì kēyán tuánduì quánlì gōngkè shuǐ-féi yītǐhuà dìxià wēikǒng shènguàn jìshù yǐ dàfú tíshēng shuǐfèn lìyònglǜ.',
        meaning_vi: 'Tại các vùng canh tác nông nghiệp nội địa khô hạn và bán khô hạn với nguồn tài nguyên nước cực kỳ khan hiếm có hạn, đội ngũ nghiên cứu thủy lợi nông nghiệp đã dốc toàn lực chinh phục kỹ thuật tưới thấm lỗ vi mô dưới lòng đất tích hợp nước và phân bón nhằm nâng cao mạnh mẽ tỷ lệ sử dụng nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3413,
    hanzi: '有益',
    pinyin: 'yǒuyì',
    word_type: 'Tính từ',
    meaning_vi: 'có ích, có lợi ích, bổ ích',
    examples: [
      {
        chinese: '青少年多阅读中外古典文学经典与现代科学普及著作，对于涵养心智、开阔眼界与树立崇高人生理想大有益处。',
        pinyin: 'Qīngshàonián duō yuèdú zhōngwài gǔdiǎn wénxué jīngdiǎn yǔ xiàndài kēxué pǔjí zhùzuò, duìyú hányǎng xīnlì, kāikuò yǎnjiè yǔ shùlì chónggāo rénshēng lǐxiǎng dàyǒu-yìchù.',
        meaning_vi: 'Thanh thiếu niên đọc nhiều danh tác văn học cổ điển trong ngoài nước và các công trình phổ biến khoa học hiện đại đem lại lợi ích to lớn đối với việc bồi dưỡng tâm trí, mở rộng tầm mắt và thiết lập lý tưởng sống cao đẹp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '积极搭建多边产学研用跨界协同创新联合体，对推动国家战略实验室的前沿基础科学理论成果高效率向现实生产力转化极为有益。',
        pinyin: 'Jījí dājiàn duōbiān chǎn-xué-yán-yòng kuàjiè xiétóng chuàngxīn liánhétǐ, duì tuīdòng guójiā zhànlüè shíyànshì de qiányán jīchǔ kēxué lǐlùn chéngguǒ gāo-xiàolǜ xiàng xiànshí shēngchǎnlì zhuǎnhuà jíqí yǒuyì.',
        meaning_vi: 'Chủ động xây dựng liên minh đổi mới hiệp đồng liên ngành đa phương giữa doanh nghiệp - viện trường - nghiên cứu - ứng dụng là cực kỳ có ích cho việc thúc đẩy các thành quả lý thuyết khoa học cơ bản tiền duyên của phòng thí nghiệm chiến lược quốc gia chuyển hóa với hiệu suất cao thành lực lượng sản xuất hiện thực.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3414,
    hanzi: '有助于',
    pinyin: 'yǒuzhùyú',
    word_type: 'Động từ',
    meaning_vi: 'có lợi cho, góp phần giúp, hỗ trợ cho',
    examples: [
      {
        chinese: '在面临学业压力或考试焦虑时多与师长、朋友倾心交谈，显著有助于及时疏导心理负面情绪并重塑昂扬自信。',
        pinyin: 'Zài miànlín xuéyè yālì huò kǎoshì jiāolǜ shí duō yǔ shīzhǎng, péngyou qīngxīn jiāotán, xiǎnzhù yǒuzhùyú jíshí shūdǎo xīnlǐ fùmiàn qíngxù bìng chóngsù ángyáng zìxìn.',
        meaning_vi: 'Khi đối mặt với áp lực học tập hoặc sự lo lắng trước thi cử nói chuyện cởi mở với thầy cô, bạn bè có tác dụng rõ rệt giúp giải tỏa kịp thời những cảm xúc tiêu cực tâm lý và tái tạo sự tự tin phấn chấn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全面深化区域全面经济伙伴关系协定框架下的海关通关一体化协同改革，深度有助于大幅压缩区域内跨境物流通关时间与综合贸易成本。',
        pinyin: 'Quánmiàn shēnhuà Qūyù Quánmiàn Jīngjì Huǒbàn Guānxì Xiédìng kuàngjià xià de hǎiguān tōngguān yītǐhuà xiétóng gǎigé, shēndù yǒuzhùyú dàfú yāsuō qūyù nèi kuàjìng wùliú tōngguān shíjiān yǔ zōnghé màoyì chéngběn.',
        meaning_vi: 'Đi sâu cải cách phối hợp tích hợp thông quan hải quan toàn diện dưới khuôn khổ Hiệp định Đối tác Kinh tế Toàn diện Khu vực (RCEP) có ý nghĩa sâu sắc giúp rút ngắn đáng kể thời gian thông quan logistics xuyên biên giới và chi phí thương mại tổng hợp trong khu vực.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3415,
    hanzi: '幼儿园',
    pinyin: 'yòu’éryuán',
    word_type: 'Danh từ',
    meaning_vi: 'trường mầm non, nhà trẻ, mẫu giáo',
    examples: [
      {
        chinese: '每天清晨，年轻的父母们面带微笑牵着孩子稚嫩的小手，将他们安全送到充满欢声笑语的现代化社区幼儿园。',
        pinyin: 'Měitiān qīngchén, niánqīng de fùmǔmen miàndài wēixiào qiān zhe háizi zhìnèn de xiǎoshǒu, jiāng tāmen ānquán sòng dào chōngmǎn huānshēng-xiàoyǔ de xiàndàihuà shèqū yòu’éryuán.',
        meaning_vi: 'Mỗi buổi sáng sớm, các bậc cha mẹ trẻ mỉm cười dắt đôi tay non nớt của con trẻ, đưa các con an toàn đến trường mầm non cộng đồng hiện đại ngập tràn tiếng cười vui.',
        difficulty_level: 'basic'
      },
      {
        chinese: '教育主管部门全面实施学前教育普惠优质安全发展规划，持续提升各级公办与普惠性民办幼儿园的科学保教保育专业化水平。',
        pinyin: 'Jiàoyù zhǔguǎn bùmén quánmiàn shíshī xuéqián jiàoyù pǔhuì yōuzhì ānquán fāzhǎn guīhuà, chíxù tíshēng gè jí gōngbàn yǔ pǔhuìxìng mínbàn yòu’éryuán de kēxué bǎojiào bǎoyù zhuānyèhuà shuǐpíng.',
        meaning_vi: 'Cơ quan chủ quản giáo dục thực thi toàn diện quy hoạch phát triển an toàn chất lượng phổ cập giáo dục mầm non, liên tục nâng cao trình độ chuyên môn hóa về nuôi dạy chăm sóc khoa học của các trường mẫu giáo công lập và tư thục phổ cập các cấp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3416,
    hanzi: '娱乐',
    pinyin: 'yúlè',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'giải trí, tiêu khiển; trò tiêu khiển',
    examples: [
      {
        chinese: '在结束了一周繁重紧凑的工作之后，周五晚上和好友相约看一场精彩的话剧演出是一种极好的身心休闲娱乐方式。',
        pinyin: 'Zài jiéshù le yī zhōu fánzhòng jǐncòu de gōngzuò zhīhòu, zhōuwǔ wǎnshang hé hǎoyǒu xiāngyuē kàn yī chǎng jīngcǎi de huàjù yǎnchū shì yī zhǒng jí hǎo de shēnxīn xiūxián yúlè fāngshì.',
        meaning_vi: 'Sau khi kết thúc một tuần làm việc nặng nề căng thẳng, tối thứ sáu hẹn bạn thân cùng xem một vở kịch nói đặc sắc là một cách nghỉ ngơi giải trí thể chất tinh thần vô cùng tuyệt vời.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着高分辨率空间计算与神经渲染生成技术的深度突破，现代数字文创娱乐产业正在向全沉浸式、超高清与人机自然互动的全新维度跃升。',
        pinyin: 'Suízhe gāofēnbànlǜ kōngjiān jìsuàn yǔ shénjīng xuànrǎn shēngchéng jìshù de shēndù tūpò, xiàndài shùzì wénchuàng yúlè chǎnyè zhèngzài xiàng quán-chénjìnshì, chāogāoqīng yǔ rén-jī zìrán hùdòng de quánxīn wéidù yuèshēng.',
        meaning_vi: 'Cùng với những đột phá sâu sắc của công nghệ tính toán không gian độ phân giải cao và kết xuất sinh nơ-ron, ngành công nghiệp sáng tạo văn hóa giải trí số hiện đại đang có bước nhảy vọt sang một chiều không gian hoàn toàn mới mang tính đắm chìm toàn cảnh, siêu nét và tương tác người - máy tự nhiên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3417,
    hanzi: '语气',
    pinyin: 'yǔqì',
    word_type: 'Danh từ',
    meaning_vi: 'ngữ khí, giọng điệu, cách nói',
    examples: [
      {
        chinese: '在与他人就不同学术观点展开深入讨论时，我们应当始终保持客观理性、谦虚诚恳并充满尊重的交流语气。',
        pinyin: 'Zài yǔ tārén jiù bùtóng xuéshù guāndiǎn zhǎnkāi shēnrù tǎolùn shí, wǒmen yīngdāng shǐzhōng bǎochí kèguān lǐxìng, qiānxū chéngkěn bìng chōngmǎn zūnzhòng de jiāoliú yǔqì.',
        meaning_vi: 'Khi trao đổi thảo luận sâu sắc với người khác về những quan điểm học thuật khác biệt, chúng ta cần luôn giữ ngữ khí giao lưu khách quan lý tính, khiêm tốn chân thành và tràn đầy sự tôn trọng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在应对复杂国际涉外争端多边磋商中，首席谈判代表以沉稳坚定、有理有利有节的政策表述语气，清晰传递了维护国家核心利益的坚决立场。',
        pinyin: 'Zài yìngduì fùzá guójì shèwài zhēngduān duōbiān cuōshāng zhōng, shǒuxí tánpàn dàibiǎo yǐ chénwěn jiāndìng, yǒulǐ-yǒulì-yǒujié de zhèngcè biǎoshù yǔqì, qīngxī chuándì le wéihù guójiā héxīn lìyì de jiānjué lìchǎng.',
        meaning_vi: 'Trong đàm phán hiệp thương đa phương ứng phó với các tranh chấp quốc tế phức tạp, trưởng đoàn đàm phán bằng ngữ khí phát biểu chính sách điềm tĩnh kiên định, có lý có lợi có chừng mực đã truyền đạt rõ ràng lập trường kiên quyết bảo vệ lợi ích cốt lõi quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3418,
    hanzi: '雨水',
    pinyin: 'yǔshuǐ',
    word_type: 'Danh từ',
    meaning_vi: 'nước mưa; tiết Vũ Thủy',
    examples: [
      {
        chinese: '春天初降的绵绵雨水格外滋润，无声地润泽着田野里沉睡了一冬的小麦麦苗与漫山遍野的绿树嫩草。',
        pinyin: 'Chūntiān chū jiàng de miánmián yǔshuǐ géwài zīrùn, wúshēng de rùnzé zhe tiányě lǐ chénshuì le yī dōng de xiǎomài màimiáo yǔ mànshān-biànyě de lǜshù nèncǎo.',
        meaning_vi: 'Làn nước mưa xuân lất phất mới rơi đặc biệt ngọt lành tươi tốt, lặng lẽ tưới tắm những mầm mạ lúa mì đã ngủ say suốt mùa đông cùng bạt ngàn cây xanh cỏ non trên khắp núi đồi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '新型海绵城市地下基础设施规划全面构建集渗、滞、蓄、净、用、排于一体的现代化大型雨水循环利用综合调蓄系统。',
        pinyin: 'Xīnxíng hǎimián chéngshì dìxià jīchǔ shèshī guīhuà quánmiàn gòujiàn jí shèn, zhì, xù, jìng, yòng, pái yú yītǐ de xiàndàihuà dàxíng yǔshuǐ xúnhuán lìyòng zōnghé tiáoxù xìtǒng.',
        meaning_vi: 'Quy hoạch hạ tầng ngầm đô thị bọt biển kiểu mới xây dựng toàn diện hệ thống điều tiết tổng hợp tái sử dụng nước mưa tuần hoàn quy mô lớn hiện đại tích hợp các khâu thấm, giữ, trữ, lọc sạch, sử dụng và tiêu thoát nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3419,
    hanzi: '语文',
    pinyin: 'yǔwén',
    word_type: 'Danh từ',
    meaning_vi: 'ngữ văn, môn văn học và tiếng mẹ đẻ',
    examples: [
      {
        chinese: '中小学语文课程教学不仅系统帮助学生掌握母语规范字词与阅读技巧，更能引导学生深刻领略中华传统文学的博大精深。',
        pinyin: 'Zhōng-xiǎoxué yǔwén kèchéng jiàoxué bùjǐn xìtǒng bāngzhù xuéshēng zhǎngwò mǔyǔ guīfàn zìcí yǔ yuèdú jìqiǎo, gèng néng yǐndǎo xuéshēng shēnkè lǐnglüè Zhōnghuá chuántǒng wénxué de bódà-jīngshēn.',
        meaning_vi: 'Giảng dạy môn ngữ văn trường tiểu học và trung học không chỉ giúp học sinh nắm vững chữ nghĩa ngữ pháp tiếng mẹ đẻ chuẩn mực và kỹ năng đọc hiểu một cách có hệ thống, mà còn có thể dẫn dắt học sinh cảm nhận sâu sắc sự uyên thâm bác đại của nền văn học truyền thống Trung Hoa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '基础教育新课程标准紧扣语文核心素养培育体系，全面强化青少年在真实多样生活情境中的思辨性阅读、跨媒介表达与文学鉴赏素养。',
        pinyin: 'Jīchǔ jiàoyù xīn kèchéng biāozhǔn jǐnkòu yǔwén héxīn sùyǎng péiyù tǐxì, quánmiàn qiánghuà qīngshàonián zài zhēnshí duōyàng shēnghuó qíngjìng zhōng de sībiànxìng yuèdú, kuà-méijiè biǎodá yǔ wénxué jiànshǎng sùyǎng.',
        meaning_vi: 'Chuẩn chương trình giáo dục phổ thông mới bám sát hệ thống bồi dưỡng phẩm chất cốt lõi môn ngữ văn, tăng cường toàn diện năng lực đọc hiểu tư duy phản biện, diễn đạt đa phương tiện và phẩm chất thưởng thức văn học của thanh thiếu niên trong các bối cảnh đời sống thực tế đa dạng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3420,
    hanzi: '语音',
    pinyin: 'yǔyīn',
    word_type: 'Danh từ',
    meaning_vi: 'ngữ âm, âm thanh tiếng nói, giọng nói',
    examples: [
      {
        chinese: '这款最新研发的多语言在线翻译软件内置高精度声学模型，能够毫秒级准确识别用户的语音输入并输出流畅的翻译结果。',
        pinyin: 'Zhè kuǎn zuìxīn yánfā de duō yǔyán zàixiàn fānyì ruǎnjiàn nèizhì gāojīngdù shēngxué móxíng, nénggòu háomiǎojí zhǔnquè shíbié yònghù de yǔyīn shūrù bìng shūchū liúchàng de fānyì jiéguǒ.',
        meaning_vi: 'Phần mềm dịch thuật trực tuyến đa ngôn ngữ mới nghiên cứu phát triển này tích hợp mô hình âm học độ chính xác cao, có thể nhận dạng chuẩn xác đầu vào giọng nói của người dùng ở cấp độ mili giây và cho ra kết quả dịch thuật trôi chảy.',
        difficulty_level: 'basic'
      },
      {
        chinese: '端到端多模态大模型深度融合全双工实时语音交互与情感副语言感知算法，赋能新一代具身智能机器人实现高度拟人化的自然语音对话。',
        pinyin: 'Duāndàoduān duōmótài dà móxíng shēndù rónghé quán-shuānggōng shíshí yǔyīn jiāohù yǔ qínggǎn fù-yǔyán gǎnzhī suànfǎ, fùnéng xīnyīdài jùshēn zhìnéng jīqìrén shíxiàn gāodù nǐrénhuà de zìrán yǔyīn duìhuà.',
        meaning_vi: 'Mô hình lớn đa phương thức từ đầu đến cuối tích hợp sâu rộng thuật toán tương tác giọng nói thời gian thực song công toàn phần và cảm nhận cận ngôn ngữ cảm xúc, tiếp sức cho thế hệ robot thông minh hiện thân mới thực hiện các cuộc đối thoại giọng nói tự nhiên có tính mô phỏng con người cao độ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3421,
    hanzi: '预报',
    pinyin: 'yùbào',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'dự báo; bản tin dự báo',
    examples: [
      {
        chinese: '出门前打开手机查看权威天气预报，根据气象台发布的降雨概率与气温提示及时携带雨具增减衣服，是良好的生活习惯。',
        pinyin: 'Chūmén qián dǎkāi shǒujī chákàn quánwēi tiānqì yùbào, gēnjù qìxiàngtái fābù de jiàngyǔ gàilǜ yǔ qìwēn tíshì jíshí xiédài yǔjù zēng-jiǎn yīfu, shì liánghǎo de shēnghuó xíguàn.',
        meaning_vi: 'Trước khi ra ngoài mở điện thoại xem bản tin dự báo thời tiết chuẩn xác, căn cứ vào xác suất mưa và nhiệt độ do đài khí tượng công bố để kịp thời mang theo áo mưa và mặc thêm bớt áo là một thói quen tốt trong cuộc sống.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家气象中心依托全球数值天气预报超级算力集群与风云气象卫星云图同化算法，实现了对强对流突发灾害天气的公里级精细化网格预报。',
        pinyin: 'Guójiā qìxiàng zhōngxīn yītuō quánqiú shùzhí tiānqì yùbào chāojí suànlì jíqún yǔ Fēngyún qìxiàng wèixīng yúntú tónghuà suànfǎ, shíxiàn le duì qiáng-duìliú tūfā zāihài tiānqì de gōnglǐjí jīngxìhuà wǎnggé yùbào.',
        meaning_vi: 'Trung tâm khí tượng quốc gia dựa vào cụm siêu tính toán dự báo thời tiết dạng số toàn cầu và thuật toán đồng hóa ảnh mây vệ tinh khí tượng Phong Vân, đã thực hiện việc dự báo lưới tinh gọn cấp km đối với thời tiết thiên tai đột ngột đối lưu mạnh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3422,
    hanzi: '预测',
    pinyin: 'yùcè',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'dự trắc, dự đoán, tiên lượng',
    examples: [
      {
        chinese: '根据历年模拟测试的整体大数据表现，指导教师客观预测该班绝大部分同学在高考中都能达到理想的高校录取分数线。',
        pinyin: 'Gēnjù lìnián mónǐ cèshì de zhěngtǐ dàshùjù biǎoxiàn, zhǐdǎo jiàoshī kèguān yùcè gāi bān juédà-bùfen tóngxué zài gāokǎo zhōng dōu néng dádào lǐxiǎng de gāoxiào lùqǔ fēnshùxiàn.',
        meaning_vi: 'Căn cứ vào biểu hiện dữ liệu lớn tổng thể của các kỳ thi thử qua các năm, giáo viên hướng dẫn dự đoán khách quan rằng phần lớn các bạn học sinh trong lớp đều có thể đạt tới điểm chuẩn xét tuyển của trường đại học lý tưởng trong kỳ thi đại học.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际宏观经济计量监测模型通过系统拟合跨国进出口关税弹性与工业投资景气指数，高度精准预测全球半导体产业链周期的下行拐点。',
        pinyin: 'Guójì hóngguān jīngjì jìliàng jiāncè móxíng tōngguò xìtǒng nǐhé kuàguó jìnchūkǒu guānshuì tánxìng yǔ gōngyè tóuzī jǐngqì zhǐshù, gāodù jīngzhǔn yùcè quánqiú bàndǎotǐ chǎnyèliàn zhōuqī de xiàxíng guǎidiǎn.',
        meaning_vi: 'Mô hình giám sát kinh tế lượng vĩ mô quốc tế thông qua việc khớp nối có hệ thống độ co giãn thuế quan xuất nhập khẩu xuyên quốc gia và chỉ số triển vọng đầu tư công nghiệp, đã dự đoán chính xác cao điểm uốn đi xuống của chu kỳ chuỗi công nghiệp bán dẫn toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3423,
    hanzi: '预订',
    pinyin: 'yùdìng',
    word_type: 'Động từ',
    meaning_vi: 'đặt trước (phòng, vé, tour du lịch)',
    examples: [
      {
        chinese: '节假日期间各大热门风景名胜区周边的优质酒店客房十分紧俏，建议有出行计划的游客至少提前两周通过官方平台在线预订房间。',
        pinyin: 'Jiérì qījiān gè dà rèmén fēngjǐng míngshèngqū zhōubiān de yōuzhì jiǔdiàn kèfáng shífēn jǐnqiào, jiànyì yǒu chūxíng jìhuà de yóukè zhìshǎo tíqián liǎng zhōu tōngguò guānfāng píngtái zàixiàn yùdìng fángjiān.',
        meaning_vi: 'Trong các dịp lễ tết, phòng khách sạn chất lượng cao xung quanh các khu danh lam thắng cảnh du lịch nổi tiếng vô cùng khan hiếm, kiến nghị du khách có kế hoạch đi lại nên đặt phòng trực tuyến qua nền tảng chính thức trước ít nhất hai tuần.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际民航联运数字化平台依托全球民航分销系统实现动态多航段无缝联运，为跨大洲旅客提供航班座位精准锁定与行李直挂联运全流程预订服务。',
        pinyin: 'Guójì mínháng liányùn shùzìhuà píngtái yītuō quánqiú mínháng fēnxīao xìtǒng shíxiàn dòngtài duō-hángduàn wúfèng liányùn, wèi kuà-dàzhōu lǚkè tígōng hángbān zuòwèi jīngzhǔn suǒdìng yǔ xínglǐ zhíguà liányùn quán-liúchéng yùdìng fúwù.',
        meaning_vi: 'Nền tảng số hóa vận tải liên vận hàng không dân dụng quốc tế dựa trên hệ thống phân phối hàng không toàn cầu thực hiện việc liên vận liền mạch nhiều chặng bay linh hoạt, cung cấp dịch vụ đặt trước toàn quy trình giữ chỗ chuyến bay chuẩn xác và gửi thẳng hành lý liên chặng cho hành khách bay xuyên lục địa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3424,
    hanzi: '预防',
    pinyin: 'yùfáng',
    word_type: 'Động từ',
    meaning_vi: 'dự phòng, phòng ngừa, phòng tránh',
    examples: [
      {
        chinese: '保持科学合理的膳食结构、适度规律的体育锻炼并按时规范接种疫苗，是有效预防各类季节性呼吸道传染病的最基础有效手段。',
        pinyin: 'Bǎochí kēxué hélǐ de shànshí jiégòu, shìdù guīlǜ de tǐyù duànliàn bìng ànshí guīfàn jiēzhòng yìmáo, shì yǒuxiào yùfáng gè lèi jìjiéxìng hūxīdào chuánrǎnbìng de zuì jīchǔ yǒuxiào shǒuduàn.',
        meaning_vi: 'Duy trì chế độ ăn uống khoa học hợp lý, tập luyện thể thao điều độ có quy luật và tiêm phòng vắc xin đúng hạn chuẩn mực là biện pháp cơ bản và hữu hiệu nhất để phòng ngừa hiệu quả các bệnh truyền nhiễm đường hô hấp theo mùa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家公共卫生发展战略始终坚持“预防为主、防治结合”根本方针，全面建立健全覆盖城乡基层的重大突发传染病常态化智慧预警与预防控制体系。',
        pinyin: 'Guójiā gōnggòng wèishēng fāzhǎn zhànlüè shǐzhōng jiānchí “yùfáng wéizhǔ, fáng-zhì jiéhé” gēnběn fāngzhēn, quánmiàn jiànlì jiànquán fùgài chéng-xiāng jīcéng de zhòngdà tūfā chuánrǎnbìng chángtàihuà zhìhuì yùjǐng yǔ yùfáng kòngzhì tǐxì.',
        meaning_vi: 'Chiến lược phát triển y tế công cộng quốc gia luôn kiên trì phương châm căn bản "lấy phòng ngừa làm trọng, kết hợp phòng và chữa", xây dựng hoàn thiện toàn diện hệ thống cảnh báo thông minh thường thái hóa và kiểm soát phòng ngừa các bệnh truyền nhiễm bùng phát trọng đại bao phủ cơ sở thành thị và nông thôn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3425,
    hanzi: '预计',
    pinyin: 'yùjì',
    word_type: 'Động từ',
    meaning_vi: 'dự tính, ước tính, dự kiến',
    examples: [
      {
        chinese: '经过全体工程施工建设人员两年来夜以继日的紧张攻坚，全长二十多公里的跨江高速公路特长隧道预计将于今年年底前全线贯通。',
        pinyin: 'Jīngguò quántǐ gōngchéng shīgōng jiànshè rényuán liǎng nián lái yèyǐjìrì de jǐnzhāng gōngjiān, quán cháng èrshí duō gōnglǐ de kuàjiāng gāosù gōnglù tècháng suìdào yùjì jiāng yú jīnnián niándǐ qián quánxiàn guàntōng.',
        meaning_vi: 'Trải qua hai năm nỗ lực thi công căng thẳng ngày đêm của toàn thể cán bộ công nhân công trình, đường hầm vượt sông siêu dài của tuyến đường cao tốc có tổng chiều dài hơn 20 km dự kiến sẽ thông tuyến toàn bộ trước cuối năm nay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '权威国际行业智库最新发布的全球可再生能源发展展望报告预计，未来五年内全球太阳能光伏与海上风电新增装机总量将超过以往十年的累计总和。',
        pinyin: 'Quánwēi guójì hángyè zhìkù zuìxīn fābù de quánqiú kězàishēng néngyuán fāzhǎn zhǎnwàng bàogào yùjì, wèilái wǔ nián nèi quánqiú tàiyángnéng guāngfú yǔ hǎishàng fēngdiàn xīn-zēng zhuāngjī zǒngliàng jiāng chāoguò yǐwǎng shí nián de lěijì zǒnghé.',
        meaning_vi: 'Báo cáo triển vọng phát triển năng lượng tái tạo toàn cầu mới nhất do viện nghiên cứu chính sách ngành uy tín quốc tế công bố dự tính, trong vòng 5 năm tới tổng công suất lắp đặt mới của điện mặt trời và điện gió ngoài khơi trên toàn cầu sẽ vượt quá tổng tích lũy của 10 năm trước đó.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3426,
    hanzi: '玉米',
    pinyin: 'yùmǐ',
    word_type: 'Danh từ',
    meaning_vi: 'ngô, bắp',
    examples: [
      {
        chinese: '秋收时节走进广袤的大粮仓，一眼望不到边的金黄色玉米沉甸甸地挂在秸秆上，田野里洋溢着丰收的喜悦。',
        pinyin: 'Qiūshōu shíjié zǒu jìn guǎngmào de dà liángcāng, yī yǎn wàng bù dào biān de jīnhuángsè yùmǐ chéndiàndiàn de guà zài jiēgǎn shàng, tiányě lǐ yángyì zhe fēngshōu de xǐyuè.',
        meaning_vi: 'Bước vào vựa lúa bạt ngàn trong mùa thu hoạch thu, những bắp ngô màu vàng óng ả trĩu nặng treo trên thân cây nhìn hút tầm mắt, trên đồng ruộng ngập tràn niềm vui được mùa bội thu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代农业生物育种国家重大专项成功攻克耐密植、抗干旱抗倒伏转基因杂交玉米分子设计育种技术，为筑牢国家粮食主粮产能安全屏障提供了核心种源支撑。',
        pinyin: 'Xiàndài nóngyè shēngwù yùzhǒng guójiā zhòngdà zhuānxiàng chénggōng gōngkè nài mìzhí, kàng gānhàn kàng dǎofú zhuǎnjīyīn zájiāo yùmǐ fēnzǐ shèjì yùzhǒng jìshù, wèi zhù láo guójiā liángshi zhǔliáng chǎnnéng ānquán píngzhàng tígōng le héxīn zhǒngyuán zhīchēng.',
        meaning_vi: 'Đề án trọng đại quốc gia về chọn tạo giống sinh học nông nghiệp hiện đại đã chinh phục thành công công nghệ chọn giống thiết kế phân tử ngô lai chuyển gen chịu trồng dày, chịu hạn và chống gãy đổ, cung cấp nguồn giống cốt lõi làm điểm tựa đắp vững hàng rào an toàn năng lực sản xuất lương thực chủ lực quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  }
]
