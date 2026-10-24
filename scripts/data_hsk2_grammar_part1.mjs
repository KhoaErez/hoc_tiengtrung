export const HSK2_GRAMMAR_PART1 = [
  // --- NHÓM 1: ĐẠI TỪ (代词) ---
  {
    order_index: 1,
    name: "Đại từ phân phối \"每\" (Mỗi / Từng)",
    pattern: "每 (+ Lượng từ) + Danh từ (+ 都 + Động từ/Tính từ)",
    category: "Đại từ",
    explanation_vi: "\"每\" (měi) biểu thị từng cá thể đơn lẻ trong một tập thể (mỗi, từng). Khi làm định ngữ hoặc chủ ngữ, phía sau thường đi kèm lượng từ và trong vị ngữ thường có phó từ \"都\" (đều) để nhấn mạnh tính toàn thể không ngoại lệ.",
    examples: [
      {
        chinese: "他每天早晨六点都准时起床去公园跑步。",
        pinyin: "Tā měi tiān zǎochén liù diǎn dōu zhǔnshí qǐchuáng qù gōngyuán pǎobù.",
        translation_vi: "Anh ấy mỗi ngày vào sáu giờ sáng đều thức dậy đúng giờ đến công viên chạy bộ.",
        explanation: "\"每天\" kết hợp với \"都\" biểu thị hành động diễn ra lặp lại đều đặn mỗi ngày."
      },
      {
        chinese: "我们班每个学生都有属于自己的汉语词典。",
        pinyin: "Wǒmen bān měi gè xuésheng dōu yǒu shǔyú zìjǐ de hànyǔ cídiǎn.",
        translation_vi: "Mỗi học sinh trong lớp chúng tôi đều có cuốn từ điển tiếng Hán của riêng mình.",
        explanation: "\"每个\" đứng trước danh từ \"学生\" và đi cùng phó từ \"都\"."
      }
    ]
  },
  {
    order_index: 2,
    name: "Đại từ nghi vấn phương thức \"怎么\" (Làm sao / Thế nào)",
    pattern: "怎么 + Động từ / Cụm động từ?",
    category: "Đại từ",
    explanation_vi: "\"怎么\" (zěnme) đứng trước động từ để hỏi về cách thức tiến hành của động tác (làm thế nào, đi bằng cách nào, viết ra sao) hoặc nguyên nhân xảy ra sự việc (sao lại, tại sao).",
    examples: [
      {
        chinese: "请问去火车站坐几路公共汽车，应该怎么走？",
        pinyin: "Qǐngwèn qù huǒchēzhàn zuò jǐ lù gōnggòng qìchē, yīnggāi zěnme zǒu?",
        translation_vi: "Xin hỏi đến ga tàu hỏa thì đi xe buýt tuyến số mấy, nên đi như thế nào?",
        explanation: "\"怎么走\" là cấu trúc cố định dùng để hỏi đường đi trong giao tiếp hàng ngày."
      },
      {
        chinese: "这个生词的汉字笔画有点多，怎么写才规范？",
        pinyin: "Zhè gè shēngcí de hànzì bǐhuà yǒudiǎn duō, zěnme xiě cái guīfàn?",
        translation_vi: "Chữ Hán của từ mới này nét hơi nhiều, viết thế nào mới đúng chuẩn?",
        explanation: "\"怎么写\" dùng để hỏi quy cách và thứ tự viết các nét chữ Hán."
      }
    ]
  },
  {
    order_index: 3,
    name: "Đại từ nghi vấn tính chất / trạng thái \"怎么样\" (Như thế nào)",
    pattern: "Chủ ngữ + 怎么样? / 怎么样，...?",
    category: "Đại từ",
    explanation_vi: "\"怎么样\" (zěnmeyàng) dùng làm vị ngữ để hỏi về tính chất, tình trạng, sức khỏe của người hoặc sự vật, hoặc dùng trong câu hỏi gợi ý để trưng cầu ý kiến người nghe (thấy thế nào, có được không).",
    examples: [
      {
        chinese: "今天外面的天气怎么样，需要带雨伞吗？",
        pinyin: "Jīntiān wàimiàn de tiānqì zěnmeyàng, xūyào dài yǔsǎn ma?",
        translation_vi: "Thời tiết bên ngoài hôm nay thế nào, có cần mang theo ô không?",
        explanation: "\"怎么样\" làm vị ngữ hỏi về tình hình thời tiết."
      },
      {
        chinese: "我们下课后一起去图书馆看书，怎么样？",
        pinyin: "Wǒmen xiàkè hòu yìqǐ qù túshūguǎn kànshū, zěnmeyàng?",
        translation_vi: "Chúng ta tan học xong cùng nhau tới thư viện đọc sách, thấy thế nào?",
        explanation: "\"怎么样\" đặt ở cuối câu để thăm dò và trưng cầu ý kiến đề xuất."
      }
    ]
  },
  {
    order_index: 4,
    name: "Đại từ nghi vấn nguyên nhân \"为什么\" (Tại sao / Vì sao)",
    pattern: "为什么 + Chủ ngữ / Vị ngữ? Hoặc Chủ ngữ + 为什么 + Vị ngữ?",
    category: "Đại từ",
    explanation_vi: "\"为什么\" (wèishénme) dùng để truy vấn nguyên nhân, mục đích hoặc lý do xảy ra của hành vi hoặc sự việc. Câu trả lời thường bắt đầu bằng liên từ chỉ nguyên nhân \"因为...\" (bởi vì...).",
    examples: [
      {
        chinese: "你昨天下午为什么没有来参加中文歌唱比赛？",
        pinyin: "Nǐ zuótiān xiàwǔ wèishénme méiyǒu lái cānjiā zhōngwén gēchàng bǐsài?",
        translation_vi: "Chiều hôm qua tại sao bạn không đến tham gia cuộc thi hát tiếng Trung?",
        explanation: "\"为什么\" đứng trước vị ngữ hỏi rõ lý do vắng mặt."
      },
      {
        chinese: "他今天心情很好，你知道是因为什么事情吗？",
        pinyin: "Tā jīntiān xīnqíng hěn hǎo, nǐ zhīdào shì yīnwèi shénme shìqing ma?",
        translation_vi: "Hôm nay tâm trạng anh ấy rất tốt, bạn có biết là vì chuyện gì không?",
        explanation: "\"因为什么\" phối hợp hỏi rõ nguyên nhân cụ thể dẫn đến tâm trạng vui vẻ."
      }
    ]
  },
  {
    order_index: 5,
    name: "Đại từ nhân xưng ngôi thứ ba chỉ sự vật / động vật \"它 / 它们\" (Nó / Chúng nó)",
    pattern: "它 / 它们 + Vị ngữ",
    category: "Đại từ",
    explanation_vi: "\"它\" (tā) dùng để thay thế cho con vật, đồ vật hoặc sự việc ở ngôi thứ ba số ít (nó). Khi ở số nhiều, thêm hậu tố \"们\" thành \"它们\" (chúng, chúng nó).",
    examples: [
      {
        chinese: "这只小花猫非常可爱，它的眼睛又大又亮。",
        pinyin: "Zhè zhī xiǎohuāmāo fēicháng kě'ài, tā de yǎnjīng yòu dà yòu liàng.",
        translation_vi: "Chú mèo hoa nhỏ này rất đáng yêu, mắt của nó vừa to vừa sáng.",
        explanation: "\"它的\" là đại từ sở hữu chỉ bộ phận mắt của con mèo."
      },
      {
        chinese: "动物园里有许多大熊猫，它们正在竹林里吃竹子。",
        pinyin: "Dòngwùyuán lǐ yǒu xǔduō dàxióngmāo, tāmen zhèngzài zhúlín lǐ chī zhúzi.",
        translation_vi: "Trong sở thú có nhiều gấu trúc lớn, chúng đang ăn trúc trong rừng trúc.",
        explanation: "\"它们\" thay thế số nhiều cho bầy gấu trúc lớn."
      }
    ]
  },

  // --- NHÓM 2: SỐ TỪ & LƯỢNG TỪ (数词 & 量词) ---
  {
    order_index: 6,
    name: "Số từ hàng trăm \"百\" và hàng nghìn \"千\" (Trăm / Nghìn)",
    pattern: "Số từ + 百 / 千 (+ Số từ lẻ)",
    category: "Số từ",
    explanation_vi: "\"百\" (bǎi) chỉ hàng trăm (100–999) và \"千\" (qiān) chỉ hàng nghìn (1.000–9.999). Khi ở giữa có số 0 (như 105, 1008), dùng chữ \"零\" (líng) để đọc, nếu có nhiều số 0 liên tiếp chỉ đọc một chữ \"零\".",
    examples: [
      {
        chinese: "这本现代汉语词典一共有一千五百页。",
        pinyin: "Zhè běn xiàndài hànyǔ cídiǎn yígòng yǒu yì qiān wǔ bǎi yè.",
        translation_vi: "Cuốn từ điển Hán ngữ hiện đại này tổng cộng có một nghìn năm trăm trang.",
        explanation: "\"一千五百\" biểu thị số lượng trang sách hàng nghìn và hàng trăm."
      },
      {
        chinese: "这件羊毛大衣在商场专卖店售价八百零五块钱。",
        pinyin: "Zhè jiàn yángmáo dàyī zài shāngchǎng zhuānmàidiàn shòujià bā bǎi líng wǔ kuài qián.",
        translation_vi: "Chiếc áo khoác dạ len này ở cửa hàng trung tâm thương mại có giá bán là tám trăm linh năm tệ.",
        explanation: "\"八百零五\" thể hiện cách dùng chữ \"零\" ở hàng chục."
      }
    ]
  },
  {
    order_index: 7,
    name: "Số thứ tự với tiền tố \"第\" (Thứ / Hạng)",
    pattern: "第 + Số từ (+ Lượng từ + Danh từ)",
    category: "Số từ",
    explanation_vi: "Thêm tiền tố \"第\" (dì) trước số từ để biểu thị thứ tự lớp lang (thứ nhất: 第一, thứ hai: 第二). Khi kết hợp với danh từ, thường có lượng từ đi kèm (như: 第一次, 第二本书).",
    examples: [
      {
        chinese: "这是我第一次乘坐高铁去北京参加学术会议。",
        pinyin: "Zhè shì wǒ dì-yī cì chéngzuò gāotiě qù Běijīng cānjiā xuéshù huìyì.",
        translation_vi: "Đây là lần đầu tiên tôi đi tàu cao tốc đến Bắc Kinh tham gia hội nghị học thuật.",
        explanation: "\"第一次\" là số thứ tự biểu thị lần thứ nhất."
      },
      {
        chinese: "他在全国青少年游泳锦标赛决赛中获得了第一名。",
        pinyin: "Tā zài quánguó qīng-shàonián yóuyǒng jǐnbiāosài juésài zhōng huòdé le dì-yī míng.",
        translation_vi: "Anh ấy đã đoạt được hạng nhất trong trận chung kết giải bơi lội thanh thiếu niên toàn quốc.",
        explanation: "\"第一名\" biểu thị thứ tự xếp hạng vị trí quán quân."
      }
    ]
  },
  {
    order_index: 8,
    name: "Động lượng từ \"次\" (Lần / Lượt)",
    pattern: "Động từ + (Số từ) + 次",
    category: "Lượng từ",
    explanation_vi: "\"次\" (cì) là động lượng từ thông dụng nhất chỉ số lần diễn ra của động tác hoặc sự kiện. Nó thường đứng sau động từ làm bổ ngữ động lượng (như 去过一次: đã từng đi một lần).",
    examples: [
      {
        chinese: "这部感人的纪录片我已经在电影院看了三次。",
        pinyin: "Zhè bù gǎnrén de jìlùpiàn wǒ yǐjīng zài diànyǐngyuàn kàn le sān cì.",
        translation_vi: "Bộ phim tài liệu cảm động này tôi đã xem ở rạp chiếu phim tới ba lần.",
        explanation: "\"看了三次\" biểu thị hành động xem đã lặp lại tổng cộng 3 lần."
      },
      {
        chinese: "老师耐心地把这道复杂的数学题讲了两次。",
        pinyin: "Lǎoshī nàixīn de bǎ zhè dào fùzá de shùxué tí jiǎng le liǎng cì.",
        translation_vi: "Thầy giáo đã kiên nhẫn giảng bài toán phức tạp này hai lần.",
        explanation: "\"讲了两次\" bổ nghĩa cho số lần tiến hành động tác giảng bài."
      }
    ]
  },
  {
    order_index: 9,
    name: "Danh lượng từ phương tiện \"辆\" (Chiếc / Xe)",
    pattern: "Số từ + 辆 + Xe cộ (自行车 / 汽车 / 公共汽车)",
    category: "Lượng từ",
    explanation_vi: "\"辆\" (liàng) là lượng từ chuyên dụng dùng cho các loại phương tiện giao thông trên cạn có bánh xe như xe đạp (自行车), xe con (汽车), xe buýt (公共汽车).",
    examples: [
      {
        chinese: "爸爸上个月为我买了一辆崭新的山地自行车。",
        pinyin: "Bàba shàng gè yuè wèi wǒ mǎi le yí liàng zhǎnxīn de shāndì zìxíngchē.",
        translation_vi: "Tháng trước bố đã mua cho tôi một chiếc xe đạp leo núi mới toanh.",
        explanation: "\"一辆...自行车\" là kết cấu lượng từ tiêu chuẩn dùng cho xe đạp."
      },
      {
        chinese: "公司门口的停车场里整齐地停着十辆白色轿车。",
        pinyin: "Gōngsī ménkǒu de tíngchēchǎng lǐ zhěngqí de tíng zhe shí liàng báisè jiàochē.",
        translation_vi: "Trong bãi đỗ xe trước cửa công ty đang đỗ ngay ngắn mười chiếc ô tô con màu trắng.",
        explanation: "\"十辆\" chỉ số lượng xe hơi đang dừng đỗ."
      }
    ]
  },
  {
    order_index: 10,
    name: "Danh lượng từ y phục / sự việc \"件\" (Chiếc / Kiện / Việc)",
    pattern: "Số từ + 件 + Áo quần / Đồ vật / Sự việc",
    category: "Lượng từ",
    explanation_vi: "\"件\" (jiàn) là lượng từ dùng cho áo quần phần thân trên (áo sơ mi, áo khoác, áo len: 一件衬衫), hành lý đồ đạc (一件行李) hoặc sự tình, công việc (一件事).",
    examples: [
      {
        chinese: "商场正在打折促销，她挑中了一件红色的毛衣。",
        pinyin: "Shāngchǎng zhèngzài dǎzhé cùxiāo, tā tiāo zhòng le yí jiàn hóngsè de máoyī.",
        translation_vi: "Trung tâm thương mại đang giảm giá khuyến mãi, cô ấy đã chọn trúng một chiếc áo len màu đỏ.",
        explanation: "\"一件毛衣\" là cách dùng lượng từ cho trang phục áo len."
      },
      {
        chinese: "今天在办公室发生了一件非常有趣的开心事。",
        pinyin: "Jīntiān zài bàngōngshì fāshēng le yí jiàn fēicháng yǒuqù de kāixīn shì.",
        translation_vi: "Hôm nay ở văn phòng đã xảy ra một chuyện vui vô cùng thú vị.",
        explanation: "\"一件...事\" biểu thị lượng từ cho sự việc phát sinh."
      }
    ]
  },
  {
    order_index: 11,
    name: "Danh lượng từ vật dài / mềm \"条\" (Con / Sợi / Chiếc)",
    pattern: "Số từ + 条 + Quần / Khăn / Sông / Cá",
    category: "Lượng từ",
    explanation_vi: "\"条\" (tiáo) là lượng từ dùng cho các vật thể có hình dáng thon dài hoặc uốn lượn như sông ngòi (一条河), đường xá (一条路), quần (一条裤子), cá (一条鱼), khăn quàng (一条围巾).",
    examples: [
      {
        chinese: "这条清澈的小河绕着美丽的小山村缓缓流过。",
        pinyin: "Zhè tiáo qīngchè de xiǎohé rào zhe měilì de xiǎoshāncūn huǎnhuǎn liúguò.",
        translation_vi: "Dòng sông nhỏ trong vắt này chảy êm đềm uốn quanh ngôi làng núi xinh đẹp.",
        explanation: "\"这条小河\" dùng cho con sông uốn lượn thon dài."
      },
      {
        chinese: "妈妈在超市买了三条新鲜的鲤鱼准备做晚饭。",
        pinyin: "Māma zài chāoshì mǎi le sān tiáo xīnxiān de lǐyú zhǔnbèi zuò wǎnfàn.",
        translation_vi: "Mẹ đã mua ba con cá chép tươi ở siêu thị chuẩn bị nấu bữa tối.",
        explanation: "\"三条...鲤鱼\" là cách dùng lượng từ cho loài cá."
      }
    ]
  },
  {
    order_index: 12,
    name: "Danh lượng từ vật phẳng \"张\" (Tấm / Tờ / Chiếc)",
    pattern: "Số từ + 张 + Giấy / Vé / Bàn / Giường",
    category: "Lượng từ",
    explanation_vi: "\"张\" (zhāng) là lượng từ dùng cho các vật mỏng phẳng hoặc có bề mặt mở rộng như tờ giấy (一张纸), tấm vé (一张票), bức ảnh (一张照片), cái bàn (一张桌子), chiếc giường (一张床).",
    examples: [
      {
        chinese: "他从皮夹里拿出一张全家人的幸福合影照片。",
        pinyin: "Tā cóng píjiá lǐ ná chū yì zhāng quánjiā rén de xìngfú héyǐng zhàopiàn.",
        translation_vi: "Anh ấy lấy từ trong ví ra một tấm ảnh chụp chung hạnh phúc của cả gia đình.",
        explanation: "\"一张...照片\" dùng cho bức ảnh phẳng mỏng."
      },
      {
        chinese: "我已经提前在网上预订好了两张今晚的话剧票。",
        pinyin: "Wǒ yǐjīng tíqián zài wǎngshang yùdìng hǎo le liǎng zhāng jīnwǎn de huàjù piào.",
        translation_vi: "Tôi đã đặt trước trên mạng xong xuôi hai tấm vé kịch nói tối nay.",
        explanation: "\"两张...票\" dùng cho vé vào cửa."
      }
    ]
  },
  {
    order_index: 13,
    name: "Danh lượng từ đôi / cặp \"双\" (Đôi / Cặp)",
    pattern: "Số từ + 双 + Giày / Tất / Đũa / Mắt",
    category: "Lượng từ",
    explanation_vi: "\"双\" (shuāng) dùng cho những đồ vật đi liền thành một cặp gồm hai chiếc cùng loại như giày dép (一双鞋), tất vớ (一双袜子), đũa (一双筷子), hoặc bàn tay/đôi mắt (一双手 / 一双眼睛).",
    examples: [
      {
        chinese: "这双运动鞋穿起来特别轻便舒适，适合跑步。",
        pinyin: "Zhè shuāng yùndòngxié chuān qǐlai tèbié qīngbiàn shūshì, shìhé pǎobù.",
        translation_vi: "Đôi giày thể thao này đi vào đặc biệt nhẹ nhàng êm ái, rất hợp để chạy bộ.",
        explanation: "\"这双运动鞋\" là lượng từ chỉ đôi giày đi liền nhau."
      },
      {
        chinese: "服务员，请给我们多拿两双干净的木筷子。",
        pinyin: "Fúwùyuán, qǐng gěi wǒmen duō ná liǎng shuāng gānjìng de mù kuàizi.",
        translation_vi: "Phục vụ ơi, xin lấy thêm cho chúng tôi hai đôi đũa gỗ sạch sẽ nhé.",
        explanation: "\"两双...筷子\" dùng cho đũa ăn cơm."
      }
    ]
  },
  {
    order_index: 14,
    name: "Lượng từ cân lượng \"斤\" và tiền tệ \"元 / 块 / 角 / 毛\"",
    pattern: "Số từ + 斤 / 块 / 毛 (+ Danh từ)",
    category: "Lượng từ",
    explanation_vi: "\"斤\" (jīn) là cân Trung Quốc (= 500g). Về tiền tệ, văn viết dùng \"元\" (yuán) và \"角\" (jiǎo), trong khẩu ngữ đời thường dùng \"块\" (kuài) và \"毛\" (máo). 1 元/块 = 10 角/毛.",
    examples: [
      {
        chinese: "这种红富士苹果五块五毛钱一斤，很甜。",
        pinyin: "Zhè zhǒng hóngfùshì píngguǒ wǔ kuài wǔ máo qián yì jīn, hěn tián.",
        translation_vi: "Loại táo Phú Sĩ đỏ này năm tệ rưỡi một cân (500g), rất ngọt.",
        explanation: "\"五块五毛\" chỉ giá tiền khẩu ngữ và \"一斤\" chỉ đơn vị trọng lượng."
      },
      {
        chinese: "他在菜市场买了三斤新鲜的西红柿和两斤土豆。",
        pinyin: "Tā zài càishìchǎng mǎi le sān jīn xīnxiān de xīhóngshì hé liǎng jīn tǔdòu.",
        translation_vi: "Anh ấy đã mua ba cân cà chua tươi và hai cân khoai tây ở chợ rau.",
        explanation: "\"三斤\" và \"两斤\" định lượng khối lượng rau củ quả."
      }
    ]
  },

  // --- NHÓM 3: PHÓ TỪ CHỈ MỨC ĐỘ (程度副词) ---
  {
    order_index: 15,
    name: "Phó từ mức độ cảm thán \"真\" (Thật / Thật là)",
    pattern: "真 + Tính từ / Cụm động từ tâm lý (+ 啊)!",
    category: "Phó từ",
    explanation_vi: "\"真\" (zhēn) đứng trước tính từ hoặc động từ tâm lý để bày tỏ thái độ tán thán, ngợi ca hoặc khẳng định mạnh mẽ từ đáy lòng (thật là, quả là). Cuối câu thường có trợ từ ngữ khí \"啊\".",
    examples: [
      {
        chinese: "春天的桂林山水风景真美丽啊！",
        pinyin: "Chūntiān de Guìlín shānshuǐ fēngjǐng zhēn měilì a!",
        translation_vi: "Phong cảnh non nước Quế Lâm vào mùa xuân thật là tươi đẹp biết bao!",
        explanation: "\"真美丽\" nhấn mạnh mức độ cảm thán trước vẻ đẹp non nước."
      },
      {
        chinese: "你做的那道红烧牛肉真好吃，大家都很喜欢。",
        pinyin: "Nǐ zuò de nà dào hóngshāo niúròu zhēn hǎochī, dàjiā dōu hěn xǐhuan.",
        translation_vi: "Món thịt bò kho mà bạn nấu thật là ngon miệng, mọi người đều rất thích.",
        explanation: "\"真好吃\" khen ngợi hương vị món ăn xuất sắc."
      }
    ]
  },
  {
    order_index: 16,
    name: "Phó từ mức độ tuyệt đối \"最\" (Nhất / Bậc nhất)",
    pattern: "最 + Tính từ / Động từ tâm lý (+ Danh từ)",
    category: "Phó từ",
    explanation_vi: "\"最\" (zuì) biểu thị mức độ cao nhất trong các đối tượng so sánh (nhất). Thường đứng trước tính từ (như: 最好: tốt nhất, 最小: nhỏ nhất) hoặc động từ tâm lý (như: 最喜欢: thích nhất, 最爱: yêu nhất).",
    examples: [
      {
        chinese: "一年四季当中，我最喜欢的季节是凉爽的秋天。",
        pinyin: "Yì nián sìjì dāngzhōng, wǒ zuì xǐhuan de jìjié shì liángshuǎng de qiūtiān.",
        translation_vi: "Trong bốn mùa một năm, mùa tôi yêu thích nhất là mùa thu mát mẻ.",
        explanation: "\"最喜欢\" chỉ sở thích cao nhất trong 4 mùa."
      },
      {
        chinese: "他是我们长跑训练队里速度最快的优秀运动员。",
        pinyin: "Tā shì wǒmen chángpǎo xùnliànduì lǐ sùdù zuì kuài de yōuxiù yùndòngyuán.",
        translation_vi: "Anh ấy là vận động viên xuất sắc có tốc độ nhanh nhất trong đội chạy dài của chúng tôi.",
        explanation: "\"最快\" so sánh tốc độ đứng đầu toàn đội."
      }
    ]
  },

  // --- NHÓM 4: PHÓ TỪ CHỈ THỜI GIAN & TRẠNG THÁI (时间与状态副词) ---
  {
    order_index: 17,
    name: "Phó từ thời gian hoàn thành \"已经\" (Đã / Đã từng)",
    pattern: "Chủ ngữ + 已经 + Động từ / Tính từ (+ 了)",
    category: "Phó từ",
    explanation_vi: "\"已经\" (yǐjīng) biểu thị động tác đã hoàn thành hoặc trạng thái đã đạt đến một giai đoạn nhất định (đã). Cuối câu hoặc sau động từ thường đi kèm trợ từ ngữ khí \"了\".",
    examples: [
      {
        chinese: "飞机已经准时降落在首都国际机场了。",
        pinyin: "Fēijī yǐjīng zhǔnshí jiàngluò zài shǒudū guójì jīchǎng le.",
        translation_vi: "Máy bay đã hạ cánh đúng giờ xuống sân bay quốc tế thủ đô rồi.",
        explanation: "\"已经...了\" biểu thị sự việc hạ cánh đã hoàn tất."
      },
      {
        chinese: "爷爷的身体已经完全康复了，请大家放心。",
        pinyin: "Yéye de shēntǐ yǐjīng wánquán kāngfù le, qǐng dàjiā fàngxīn.",
        translation_vi: "Sức khỏe của ông nội đã hoàn toàn hồi phục rồi, xin mọi người hãy yên tâm.",
        explanation: "\"已经...了\" chỉ trạng thái phục hồi sức khỏe trọn vẹn."
      }
    ]
  },
  {
    order_index: 18,
    name: "Phó từ tiếp diễn hành động \"正 / 正在 / 在\" (Đang)",
    pattern: "Chủ ngữ + 正 / 正在 / 在 + Động từ (+ Tân ngữ) (+ 呢)",
    category: "Phó từ",
    explanation_vi: "\"正\" (zhèng), \"在\" (zài) hoặc \"正在\" (zhèngzài) đứng trước động từ để biểu thị hành động đang trong quá trình tiến hành tại một thời điểm nhất định (đang). Cuối câu thường kết hợp trợ từ \"呢\".",
    examples: [
      {
        chinese: "同学们正在教室里认真地听老师讲课呢。",
        pinyin: "Tóngxué men zhèngzài jiàoshì lǐ rènzhēn de tīng lǎoshī jiǎngkè ne.",
        translation_vi: "Các bạn học sinh đang chăm chú nghe thầy giáo giảng bài trong lớp học.",
        explanation: "\"正在...呢\" miêu tả hành động nghe giảng đang diễn ra tại thời điểm nói."
      },
      {
        chinese: "爸爸在书房里看新闻，你不要大声说话。",
        pinyin: "Bàba zài shūfáng lǐ kàn xīnwén, nǐ bú yào dàshēng shuōhuà.",
        translation_vi: "Bố đang xem tin tức trong phòng sách, bạn đừng nói to nhé.",
        explanation: "\"在看\" biểu thị trạng thái đang xem tin tức."
      }
    ]
  },
  {
    order_index: 19,
    name: "Phó từ thời gian sớm / nhanh \"就\" (Đã / Liền / Ngay)",
    pattern: "Thời gian + 就 + Động từ / Động từ 1 + 就 + Động từ 2",
    category: "Phó từ",
    explanation_vi: "\"就\" (jiù) đứng trước động từ để nhấn mạnh hành động xảy ra sớm, nhanh chóng, thuận lợi ngoài dự liệu (đã, liền, ngay). Đối lập với \"才\" (mới - muộn).",
    examples: [
      {
        chinese: "他今天早晨五点半就起床去跑步了。",
        pinyin: "Tā jīntiān zǎochén wǔ diǎn bàn jiù qǐchuáng qù pǎobù le.",
        translation_vi: "Anh ấy sáng nay năm rưỡi đã thức dậy đi chạy bộ rồi.",
        explanation: "\"五点半就\" nhấn mạnh thức dậy rất sớm."
      },
      {
        chinese: "我一吃完早饭就立刻坐地铁去公司上班。",
        pinyin: "Wǒ yì chī wán zǎofàn jiù lìkè zuò dìtiě qù gōngsī shàngbān.",
        translation_vi: "Tôi vừa ăn xong bữa sáng là lập tức đi tàu điện ngầm tới công ty đi làm ngay.",
        explanation: "\"一...就...\" thể hiện hành động thứ hai diễn ra liền ngay sau hành động một."
      }
    ]
  },
  {
    order_index: 20,
    name: "Phó từ duy trì trạng thái \"还\" (Vẫn / Còn)",
    pattern: "Chủ ngữ + 还 + Động từ / Tính từ",
    category: "Phó từ",
    explanation_vi: "\"还\" (hái) biểu thị hành động hoặc trạng thái vốn có từ trước vẫn tiếp tục tiếp diễn chưa kết thúc (vẫn, còn). Phủ định thường dùng \"还没\" (vẫn chưa).",
    examples: [
      {
        chinese: "现在已经晚上十点了，他还在实验室里做化学实验。",
        pinyin: "Xiànzài yǐjīng wǎnshang shí diǎn le, tā hái zài shíyànshì lǐ zuò huàxué shíyàn.",
        translation_vi: "Bây giờ đã mười giờ đêm rồi, anh ấy vẫn đang làm thí nghiệm hóa học trong phòng thí nghiệm.",
        explanation: "\"还在\" biểu thị hành vi làm thí nghiệm vẫn tiếp tục kéo dài tới đêm."
      },
      {
        chinese: "外面虽然雨停了，但是天气还是很冷。",
        pinyin: "Wàimiàn suīrán yǔ tíng le, dànshì tiānqì hái shì hěn lěng.",
        translation_vi: "Bên ngoài tuy mưa đã tạnh, nhưng thời tiết vẫn còn rất lạnh.",
        explanation: "\"还是\" nhấn mạnh tình trạng rét lạnh vẫn duy trì."
      }
    ]
  },
  {
    order_index: 21,
    name: "Phó từ lặp lại trong tương lai \"再\" (Lại / Nữa / Hãy)",
    pattern: "再 + Động từ (+ Tân ngữ)",
    category: "Phó từ",
    explanation_vi: "\"再\" (zài) biểu thị một hành động sẽ được lặp lại hoặc tiếp tục trong tương lai (lại, nữa), hoặc biểu thị hành động làm sau khi một điều kiện hoàn thành (rồi hãy...). Khác với \"又\" (đã lặp lại trong quá khứ).",
    examples: [
      {
        chinese: "这道中国名菜味道太好了，我下次还要再来吃一次。",
        pinyin: "Zhè dào zhōngguó míngcài wèidào tài hǎo le, wǒ xià cì hái yào zài lái chī yí cì.",
        translation_vi: "Món ăn danh tiếng Trung Quốc này hương vị ngon quá, lần sau tôi nhất định sẽ lại đến ăn lần nữa.",
        explanation: "\"再来吃\" chỉ hành động ăn lặp lại ở lần sau (tương lai)."
      },
      {
        chinese: "请大家先把课文读熟，然后再回答思考题。",
        pinyin: "Qǐng dàjiā xiān bǎ kèwén dú shú, ránhòu zài huídá sīkǎotí.",
        translation_vi: "Xin mời mọi người trước tiên đọc kỹ bài khóa, sau đó hãy trả lời các câu hỏi suy ngẫm.",
        explanation: "\"然后再\" biểu thị thứ tự hành động làm sau."
      }
    ]
  },
  {
    order_index: 22,
    name: "Phó từ hợp tác \"一起\" (Cùng nhau / Cùng)",
    pattern: "一起 + Động từ (+ Tân ngữ) / 和 / 跟 + Ai + 一起 + Động từ",
    category: "Phó từ",
    explanation_vi: "\"一起\" (yìqǐ) biểu thị nhiều người cùng tham gia vào một địa điểm hoặc cùng tiến hành một hoạt động (cùng nhau). Thường kết hợp với giới từ \"和 / 跟\" (và, cùng).",
    examples: [
      {
        chinese: "周末我和大学同学一起去郊区爬山看红叶。",
        pinyin: "Zhōumò wǒ hé dàxué tóngxué yìqǐ qù jiāoqū páshān kàn hóngyè.",
        translation_vi: "Cuối tuần tôi cùng các bạn đại học cùng nhau đi leo núi ngắm lá đỏ ở ngoại ô.",
        explanation: "\"和...一起\" chỉ sự phối hợp hoạt động leo núi của nhiều người."
      },
      {
        chinese: "大家坐在一起热烈讨论关于汉语学习的有效方法。",
        pinyin: "Dàjiā zuò zài yìqǐ rèliè tǎolùn guānyú hànyǔ xuéxí de yǒuxiào fāngfǎ.",
        translation_vi: "Mọi người ngồi lại cùng nhau thảo luận sôi nổi về phương pháp học tiếng Hán hiệu quả.",
        explanation: "\"坐在一起\" biểu thị vị trí tập hợp cùng một chỗ."
      }
    ]
  },

  // --- NHÓM 5: PHÓ TỪ PHỦ ĐỊNH & PHẠM VI (否定与范围副词) ---
  {
    order_index: 23,
    name: "Phó từ khuyên ngăn phủ định \"别\" (Đừng / Chớ)",
    pattern: "别 + Động từ / Cụm động từ (+ 了)!",
    category: "Phó từ",
    explanation_vi: "\"别\" (bié) dùng trong câu cầu khiến phủ định để khuyên bảo, ngăn cản ai đó không nên làm một việc gì (đừng, chớ). Cuối câu có thể thêm \"了\" để khuyên dừng hành động đang làm.",
    examples: [
      {
        chinese: "医生叮嘱病人今天晚上千万别吃辛辣油腻的食物。",
        pinyin: "Yīshēng dīngzhǔ bìngrén jīntiān wǎnshang qiānwàn bié chī xīnlà yóunì de shíwù.",
        translation_vi: "Bác sĩ dặn dò bệnh nhân tối hôm nay tuyệt đối đừng ăn đồ ăn cay nóng nhiều dầu mỡ.",
        explanation: "\"别吃\" là lời khuyên răn ngăn cản kiêng khem ăn uống."
      },
      {
        chinese: "考试时间快到了，大家别说话了，专心答卷。",
        pinyin: "Kǎoshì shíjiān kuài dào le, dàjiā bié shuōhuà le, zhuānxīn dájuàn.",
        translation_vi: "Giờ thi sắp tới rồi, mọi người đừng nói chuyện nữa, hãy tập trung làm bài.",
        explanation: "\"别说话了\" khuyên dừng hành động đang nói chuyện lại."
      }
    ]
  },
  {
    order_index: 24,
    name: "Phó từ đồng nhất \"也\" (Cũng)",
    pattern: "Chủ ngữ 1 + Vị ngữ, Chủ ngữ 2 + 也 + Vị ngữ",
    category: "Phó từ",
    explanation_vi: "\"也\" (yě) đứng trước động từ hoặc tính từ để biểu thị sự đồng nhất về tính chất, trạng thái hoặc hành vi với đối tượng được đề cập trước đó (cũng). Luôn đứng trước phó từ phủ định 不/没.",
    examples: [
      {
        chinese: "他很喜欢喝中国茶，他的妹妹也很喜欢喝绿茶。",
        pinyin: "Tā hěn xǐhuan hē zhōngguó chá, tā de mèimei yě hěn xǐhuan hē lǜchá.",
        translation_vi: "Anh ấy rất thích uống trà Trung Quốc, em gái anh ấy cũng rất thích uống trà xanh.",
        explanation: "\"也\" biểu thị em gái có sở thích tương tự như người anh."
      },
      {
        chinese: "我今天没去图书馆，小明今天也没有去。",
        pinyin: "Wǒ jīntiān méi qù túshūguǎn, Xiǎomíng jīntiān yě méiyǒu qù.",
        translation_vi: "Hôm nay tôi không đến thư viện, Tiểu Minh hôm nay cũng không đi.",
        explanation: "\"也没有\" đứng trước cụm phủ định biểu thị sự đồng nhất về việc không đi."
      }
    ]
  },
  {
    order_index: 25,
    name: "Phó từ tổng quát \"都\" (Đều / Tất cả)",
    pattern: "Chủ ngữ số nhiều + 都 + Vị ngữ",
    category: "Phó từ",
    explanation_vi: "\"都\" (dōu) đứng trước động từ hoặc tính từ để bao hàm toàn bộ các chủ thể hoặc đối tượng phía trước không có ngoại lệ (đều, tất cả). Khi phủ định toàn bộ dùng \"都不\", phủ định một phần dùng \"不都\".",
    examples: [
      {
        chinese: "我们班的外国留学生都顺利通过了汉语水平考试。",
        pinyin: "Wǒmen bān de wàiguó liúxuéshēng dōu shùnlì tōngguò le hànyǔ shuǐpíng kǎoshì.",
        translation_vi: "Các lưu học sinh nước ngoài của lớp chúng tôi đều đã thuận lợi vượt qua kỳ thi năng lực Hán ngữ.",
        explanation: "\"都通过\" nhấn mạnh toàn thể mọi học sinh không ai trượt."
      },
      {
        chinese: "这些新鲜的水果都是从海南岛空运过来的。",
        pinyin: "Zhèxiē xīnxiān de shuǐguǒ dōu shì cóng Hǎinándǎo kōngyùn guòlái de.",
        translation_vi: "Những loại hoa quả tươi này đều là được vận chuyển bằng đường hàng không từ đảo Hải Nam tới.",
        explanation: "\"都是\" xác nhận toàn bộ số hoa quả có cùng nguồn gốc."
      }
    ]
  },
  {
    order_index: 26,
    name: "Cấu trúc vừa... vừa... \"又...又...\"",
    pattern: "又 + Tính từ 1 + 又 + Tính từ 2 / 又 + Động từ 1 + 又 + Động từ 2",
    category: "Liên từ",
    explanation_vi: "Cấu trúc \"又...又...\" (yòu...yòu...) liên kết hai tính từ hoặc động từ có tính chất tương đương cùng tồn tại song song trong một chủ thể (vừa... lại vừa...). Hai thành phần liên kết phải cùng tích cực hoặc cùng tiêu cực.",
    examples: [
      {
        chinese: "这家新开的面馆做的面条又便宜又好吃。",
        pinyin: "Zhè jiā xīn kāi de miànguǎn zuò de miàntiáo yòu piányi yòu hǎochī.",
        translation_vi: "Mì do quán mì mới mở này nấu vừa rẻ lại vừa ngon miệng.",
        explanation: "\"又便宜又好吃\" liên kết hai tính từ tích cực ca ngợi quán mì."
      },
      {
        chinese: "超市里买来的西瓜个头又大又甜，水分很足。",
        pinyin: "Chāoshì lǐ mǎi lái de xīguā gètóu yòu dà yòu tián, shuǐfèn hěn zú.",
        translation_vi: "Quả dưa hấu mua ở siêu thị về quả vừa to lại vừa ngọt, mọng nước vô cùng.",
        explanation: "\"又大又甜\" miêu tả hai đặc điểm nổi bật của quả dưa hấu."
      }
    ]
  }
];
