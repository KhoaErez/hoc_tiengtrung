import fs from 'fs';

function escapeSql(str) {
  if (!str) return "''";
  return `'${str.replace(/'/g, "''")}'`;
}

// 78 Điểm ngữ pháp HSK 2 Chuẩn GF 0025-2021 Appendix A
// Kèm giải thích chi tiết tiếng Việt và 2 câu ví dụ thực tế mỗi điểm (156 câu)
export const HSK2_GRAMMAR_78 = [
  // --- Nhóm 1: Đại từ (代词) ---
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

  // --- Nhóm 2: Lượng từ (量词) ---
  {
    order_index: 5,
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
    order_index: 6,
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
    order_index: 7,
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
    order_index: 8,
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
    order_index: 9,
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
    order_index: 10,
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
  }
];

console.log('HSK 2 grammar prototype with', HSK2_GRAMMAR_78.length, 'sample points ready.');
