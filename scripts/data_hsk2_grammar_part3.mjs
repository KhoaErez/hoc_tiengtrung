export const HSK2_GRAMMAR_PART3 = [
  // --- NHÓM 11: BỔ NGỮ KẾT QUẢ MỞ RỘNG (结果补语进阶) ---
  {
    order_index: 53,
    name: "Bổ ngữ kết quả tiếp cận / đạt mục tiêu \"到\" (Tới / Được)",
    pattern: "Động từ + 到 + Tân ngữ nơi chốn / thời gian / mục tiêu",
    category: "Bổ ngữ",
    explanation_vi: "\"到\" (dào) làm bổ ngữ kết quả đứng sau động từ biểu thị hành động đã đạt đến một địa điểm, một mốc thời gian nhất định (như 走到: đi đến, 学到: học đến), hoặc hành động đã thành công đạt được mục đích (như 买到: mua được, 找到: tìm thấy).",
    examples: [
      {
        chinese: "他昨天晚上在图书馆一直看书看到十一点半。",
        pinyin: "Tā zuótiān wǎnshang zài túshūguǎn yìzhí kànshū kàn dào shíyī diǎn bàn.",
        translation_vi: "Tối hôm qua anh ấy ở thư viện đọc sách liên tục đến tận mười một giờ rưỡi.",
        explanation: "\"看到\" biểu thị mốc thời gian hành động đọc sách kéo dài tới."
      },
      {
        chinese: "经过多方打听，我终于在旧书店买到了这本绝版名著。",
        pinyin: "Jīngguò duōfāng dǎtīng, wǒ zhōngyú zài jiù shūdiàn mǎi dào le zhè běn juébǎn míngzhù.",
        translation_vi: "Qua nhiều mối dò hỏi, tôi cuối cùng đã mua được cuốn danh tác tuyệt bản này ở một hiệu sách cũ.",
        explanation: "\"买到了\" nhấn mạnh việc đạt được mục đích mua thành công."
      }
    ]
  },
  {
    order_index: 54,
    name: "Bổ ngữ kết quả giác quan tri giác \"见\" (Thấy / Nghe thấy)",
    pattern: "Động từ giác quan (看 / 听 / 闻) + 见 (+ Tân ngữ)",
    category: "Bổ ngữ",
    explanation_vi: "\"见\" (jiàn) làm bổ ngữ kết quả kết hợp với các động từ tri giác như \"看\" (nhìn), \"听\" (nghe) để biểu thị giác quan đã tiếp nhận được hình ảnh, âm thanh từ thế giới bên ngoài (nhìn thấy, nghe thấy). Dạng phủ định là \"没看(见)\", \"没听(见)\".",
    examples: [
      {
        chinese: "站在高山之巅，我们可以清楚地看见山谷里的小村庄。",
        pinyin: "Zhàn zài gāoshān zhī diān, wǒmen kěyǐ qīngchu de kànjiàn shāngǔ lǐ de xiǎo cūnzhuāng.",
        translation_vi: "Đứng trên đỉnh núi cao, chúng tôi có thể nhìn thấy rõ ràng ngôi làng nhỏ trong thung lũng.",
        explanation: "\"看见\" biểu thị thị giác đã bắt được hình ảnh ngôi làng."
      },
      {
        chinese: "教室外面太吵了，最后一排的学生听不见老师讲课。",
        pinyin: "Jiàoshì wàimiàn tài chǎo le, zuìhòu yì pái de xuésheng tīng bu jiàn lǎoshī jiǎngkè.",
        translation_vi: "Bên ngoài lớp học ồn ào quá, học sinh hàng ghế cuối cùng không nghe thấy thầy giáo giảng bài.",
        explanation: "\"听不见\" biểu thị thính giác không thu nhận được âm thanh."
      }
    ]
  },
  {
    order_index: 55,
    name: "Bổ ngữ kết quả hiểu thấu triệt \"懂\" (Hiểu / Hiểu ra)",
    pattern: "听 / 看 + 懂 (+ Tân ngữ) / Phủ định: 没听懂 / 没看懂",
    category: "Bổ ngữ",
    explanation_vi: "\"懂\" (dǒng) làm bổ ngữ kết quả đứng sau động từ tiếp nhận thông tin như \"听\" (nghe), \"看\" (đọc/xem) để biểu thị người tiếp nhận đã hiểu rõ, lĩnh hội được nội dung, ý nghĩa của lời nói hoặc bài viết (nghe hiểu, xem hiểu).",
    examples: [
      {
        chinese: "虽然课文有些生词，但他依然认真听懂了整堂课的内容。",
        pinyin: "Suīrán kèwén yǒuxiē shēngcí, dàn tā yīrán rènzhēn tīng dǒng le zhěng táng kè de nèiróng.",
        translation_vi: "Mặc dù bài khóa có một số từ mới, nhưng anh ấy vẫn chăm chú nghe hiểu được nội dung của cả tiết học.",
        explanation: "\"听懂了\" biểu thị đã lĩnh hội trọn vẹn lời giảng."
      },
      {
        chinese: "这篇古汉语寓言文章深奥难懂，我读了两遍才看懂。",
        pinyin: "Zhè piān gǔ hànyǔ yùyán wénzhāng shēn'ào nándǒng, wǒ dú le liǎng biàn cái kàn dǒng.",
        translation_vi: "Bài văn ngụ ngôn Hán ngữ cổ này sâu xa khó hiểu, tôi đọc tới hai lần mới xem hiểu được.",
        explanation: "\"看懂\" biểu thị việc đọc và hiểu thấu đáo ý nghĩa sau nhiều lần nghiền ngẫm."
      }
    ]
  },
  {
    order_index: 56,
    name: "Bổ ngữ kết quả đúng / sai \"对 / 错\" (Đúng / Sai)",
    pattern: "Động từ (做 / 说 / 写 / 算) + 对 / 错 (+ Tân ngữ)",
    category: "Bổ ngữ",
    explanation_vi: "\"对\" (duì) và \"错\" (cuò) làm bổ ngữ kết quả đứng sau động từ để biểu thị hành động đã tiến hành chính xác hoặc sai lệch so với tiêu chuẩn, sự thật (làm đúng/sai, nói đúng/sai, tính đúng/sai).",
    examples: [
      {
        chinese: "经过反复验算，他在数学考试中把最后一道难题做对了。",
        pinyin: "Jīngguò fǎnfù yànsuàn, tā zài shùxué kǎoshì zhōng bǎ zuìhòu yí dào nántí zuò duì le.",
        translation_vi: "Trải qua việc tính toán kiểm tra lại nhiều lần, anh ấy trong kỳ thi toán đã làm đúng bài toán khó cuối cùng.",
        explanation: "\"做对了\" biểu thị kết quả giải toán chính xác."
      },
      {
        chinese: "对不起，我刚才太匆忙，把您的手机号码记错了。",
        pinyin: "Duìbuqǐ, wǒ gāngcái tài cōngmáng, bǎ nín de shǒujī hàomǎ jì cuò le.",
        translation_vi: "Xin lỗi, ban nãy tôi vội vàng quá, đã ghi nhầm số điện thoại di động của ngài rồi.",
        explanation: "\"记错了\" biểu thị việc ghi chép bị sai sót thông tin."
      }
    ]
  },

  // --- NHÓM 12: BỔ NGỮ XU HƯỚNG SƠ CẤP (初级趋向补语) ---
  {
    order_index: 57,
    name: "Bổ ngữ xu hướng đơn \"来 / 去\" (Lại / Đi)",
    pattern: "Động từ chuyển động (上 / 下 / 进 / 出 / 回 / 过) + 来 / 去",
    category: "Bổ ngữ",
    explanation_vi: "\"来\" (lái) và \"去\" (qù) làm bổ ngữ xu hướng đứng sau động từ chỉ sự di chuyển. Dùng \"来\" khi hướng chuyển động tiến về phía vị trí của người nói (hoặc đối tượng được miêu tả); dùng \"去\" khi hướng chuyển động đi xa dần khỏi vị trí của người nói.",
    examples: [
      {
        chinese: "外面风大天冷，你快进屋里来喝杯热姜茶吧。",
        pinyin: "Wàimiàn fēng dà tiān lěng, nǐ kuài jìn wū lǐ lái hē bēi rè jiāngchá ba.",
        translation_vi: "Bên ngoài gió to trời lạnh, bạn mau bước vào trong nhà uống cốc trà gừng nóng đi.",
        explanation: "\"进来\" biểu thị người nói đang ở trong nhà, gọi người ngoài bước vào phía mình."
      },
      {
        chinese: "爸爸让我去书房拿一本厚厚的汉语大字典回来。",
        pinyin: "Bàba ràng wǒ qù shūfáng ná yì běn hòuhòu de hànyǔ dà zìdiǎn huílai.",
        translation_vi: "Bố bảo tôi đi vào phòng sách lấy một cuốn đại tự điển tiếng Hán dày cộp mang về đây.",
        explanation: "\"拿回来\" chỉ việc mang sách về lại chỗ người nói."
      }
    ]
  },
  {
    order_index: 58,
    name: "Bổ ngữ xu hướng kép cơ bản \"出来 / 上去 / 回来 / 走过去\"",
    pattern: "Động từ hành động + (上/下/进/出/回/过) + 来/去",
    category: "Bổ ngữ",
    explanation_vi: "Bổ ngữ xu hướng kép gồm hai chữ (kết hợp 上/下/进/出/回/过/起 với 来/去) đứng sau động từ để miêu tả hướng di chuyển phức hợp vừa có tính phương vị vừa có tính cự ly đối với người nói.",
    examples: [
      {
        chinese: "太阳慢慢从东方升起来，给大地披上了一层金色阳光。",
        pinyin: "Tàiyáng mànmàn cóng dōngfāng shēng qǐlai, gěi dàdì pī shàng le yì céng jīnsè yángguāng.",
        translation_vi: "Mặt trời từ từ nhô lên từ phía Đông, khoác lên mặt đất một lớp ánh nắng vàng rực rỡ.",
        explanation: "\"升起来\" miêu tả mặt trời mọc hướng lên cao về phía tầm mắt."
      },
      {
        chinese: "她从书包里拿出来一本刚买的新杂志借给同桌看。",
        pinyin: "Tā cóng shūbāo lǐ ná chūlai yì běn gāng mǎi de xīn zázhì jiè gěi tóngzhuō kàn.",
        translation_vi: "Cô ấy từ trong cặp sách lấy ra một cuốn tạp chí mới vừa mua cho bạn cùng bàn mượn xem.",
        explanation: "\"拿出来\" miêu tả hành động lấy vật từ trong ra ngoài."
      }
    ]
  },

  // --- NHÓM 13: BỔ NGỮ THỜI LƯỢNG & ĐỘNG LƯỢNG (时量与动量补语) ---
  {
    order_index: 59,
    name: "Bổ ngữ thời lượng biểu thị độ dài hành động (时量补语)",
    pattern: "Động từ + (了) + Khoảng thời gian (+ Tân ngữ) / Động từ + Tân ngữ + Động từ + Khoảng thời gian",
    category: "Bổ ngữ",
    explanation_vi: "Bổ ngữ thời lượng đứng sau động từ để biểu thị hành động diễn ra kéo dài trong bao lâu (như: 一个小时: một tiếng, 三天: ba ngày). Nếu động từ mang tân ngữ thì cần lặp lại động từ hoặc đặt khoảng thời gian trước tân ngữ.",
    examples: [
      {
        chinese: "他在北京大学认真学习了四年现代汉语言文学专业。",
        pinyin: "Tā zài Běijīng Dàxué rènzhēn xuéxí le sì nián xiàndài hànyǔ yánwénxué zhuānyè.",
        translation_vi: "Anh ấy đã chăm chỉ theo học chuyên ngành ngôn ngữ văn học Hán ngữ hiện đại tại Đại học Bắc Kinh suốt bốn năm.",
        explanation: "\"学习了四年\" bổ nghĩa cho độ dài thời gian học tập là 4 năm."
      },
      {
        chinese: "我和朋友在人民公园的湖边散步散了半个小时。",
        pinyin: "Wǒ hé péngyou zài Rénmín Gōngyuán de húbiān sànbù sàn le bàn gè xiǎoshí.",
        translation_vi: "Tôi và bạn bè đi dạo bên bờ hồ Công viên Nhân dân suốt nửa tiếng đồng hồ.",
        explanation: "\"散了半个小时\" lặp lại động từ để mang bổ ngữ thời lượng."
      }
    ]
  },
  {
    order_index: 60,
    name: "Bổ ngữ động lượng chỉ tần suất số lượt \"遍 / 趟 / 顿\"",
    pattern: "Động từ + (了) + Số từ + 遍 / 趟 / 顿",
    category: "Bổ ngữ",
    explanation_vi: "Bên cạnh \"次\", các động lượng từ như \"遍\" (biàn - lượt từ đầu đến cuối), \"趟\" (tàng - chuyến đi về), \"顿\" (dùn - bữa, trận) đứng sau động từ để miêu tả số lần thực hiện hành động với sắc thái cụ thể.",
    examples: [
      {
        chinese: "这首优美的唐诗大家已经声情并茂地背诵了三遍。",
        pinyin: "Zhè shǒu yōuměi de tángshī dàjiā yǐjīng shēngqíng-bìngmào de bèisòng le sān biàn.",
        translation_vi: "Bài thơ Đường tươi đẹp này mọi người đã đọc thuộc lòng truyền cảm ba lượt từ đầu tới cuối.",
        explanation: "\"背诵了三遍\" nhấn mạnh đọc trọn vẹn toàn bộ bài thơ 3 lần."
      },
      {
        chinese: "为了办理护照签证手续，他这个星期专门跑了两趟外事办。",
        pinyin: "Wèile bànlǐ hùzhào qiānzhèng shǒuxù, tā zhè gè xīngqī zhuānmén pǎo le liǎng tàng wàishìbàn.",
        translation_vi: "Để làm thủ tục hộ chiếu visa, tuần này anh ấy đã chuyên công chạy đi chạy lại hai chuyến đến phòng ngoại vụ.",
        explanation: "\"跑了两趟\" chỉ số chuyến đi lại giao dịch công việc."
      }
    ]
  },

  // --- NHÓM 14: CẤU TRÚC SO SÁNH (比较句) ---
  {
    order_index: 61,
    name: "Cấu trúc so sánh hơn có mức độ cụ thể \"A 比 B + Tính từ + Mức độ\"",
    pattern: "A 比 B + Tính từ + (一点儿 / 得多 / 多了 / Số lượng cụ thể)",
    category: "Cấu trúc so sánh",
    explanation_vi: "Để biểu thị mức độ chênh lệch cụ thể trong câu so sánh chữ \"比\", người ta đặt các từ chỉ lượng như \"一点儿\" (một chút), \"得多 / 多了\" (nhiều) hoặc số lượng từ cụ thể ở ngay sau tính từ vị ngữ.",
    examples: [
      {
        chinese: "坐高铁去上海比坐普通列车快得多，而且非常舒适。",
        pinyin: "Zuò gāotiě qù Shànghǎi bǐ zuò pǔtōng lièchē kuài de duō, érqiě fēicháng shūshì.",
        translation_vi: "Đi tàu cao tốc tới Thượng Hải nhanh hơn nhiều so với đi tàu hỏa thông thường, hơn nữa còn rất tiện nghi thoải mái.",
        explanation: "\"快得多\" bổ ngữ mức độ chênh lệch tốc độ rất lớn."
      },
      {
        chinese: "这件羊毛大衣比那件羽绒服贵了整整两百块钱。",
        pinyin: "Zhè jiàn yángmáo dàyī bǐ nà jiàn yǔróngfú guì le zhěngzhěng liǎng bǎi kuài qián.",
        translation_vi: "Chiếc áo khoác dạ len này đắt hơn chiếc áo lông vũ kia trọn vẹn hai trăm tệ.",
        explanation: "\"贵了整整两百块钱\" nêu số lượng tiền chênh lệch cụ thể."
      }
    ]
  },
  {
    order_index: 62,
    name: "Cấu trúc so sánh bằng phủ định \"A 没有 B (+ 那么/这么) + Tính từ\"",
    pattern: "Chủ ngữ A + 没有 + Chủ ngữ B (+ 那么 / 这么) + Tính từ / Vị ngữ",
    category: "Cấu trúc so sánh",
    explanation_vi: "Cấu trúc \"A 没有 B (那么/这么) + Tính từ\" dùng để biểu thị sự so sánh kém hơn hoặc không bằng (A không... bằng B). Đây là dạng so sánh phổ biến nhất khi phủ định mức độ của A so với chuẩn B.",
    examples: [
      {
        chinese: "今天户外的风没有昨天那么大，感觉暖和了不少。",
        pinyin: "Jīntiān hùwài de fēng méiyǒu zuótiān nàme dà, gǎnjué nuǎnhuo le bù shǎo.",
        translation_vi: "Gió ngoài trời hôm nay không lớn bằng hôm qua, cảm thấy ấm áp hơn nhiều.",
        explanation: "\"没有昨天那么大\" so sánh độ lớn của gió không bằng ngày hôm trước."
      },
      {
        chinese: "这本科普读物的生词没有我想象的那么难懂。",
        pinyin: "Zhè běn kēpǔ dúwù de shēngcí méiyǒu wǒ xiǎngxiàng de nàme nándǒng.",
        translation_vi: "Từ mới trong cuốn sách phổ biến khoa học này không khó hiểu như tôi tưởng tượng.",
        explanation: "So sánh mức độ khó hiểu không bằng suy nghĩ ban đầu."
      }
    ]
  },
  {
    order_index: 63,
    name: "Cấu trúc so sánh ngang bằng \"A 跟 / 和 B 一样 (+ Tính từ)\"",
    pattern: "A 跟 / 和 B 一样 (+ Tính từ) / Phủ định: A 跟 / 和 B 不一样",
    category: "Cấu trúc so sánh",
    explanation_vi: "Cấu trúc \"A 跟/和 B 一样\" biểu thị hai đối tượng A và B có điểm tương đồng, ngang bằng nhau về mặt tính chất, đặc điểm hoặc diện mạo (giống nhau, như nhau). Phía sau có thể thêm tính từ bổ sung khía cạnh so sánh.",
    examples: [
      {
        chinese: "小红现在的汉语听说水平跟中国本土学生一样流利。",
        pinyin: "Xiǎohóng xiànzài de hànyǔ tīng-shuō shuǐpíng gēn zhōngguó běntǔ xuésheng yíyàng liúlì.",
        translation_vi: "Trình độ nghe nói tiếng Hán hiện tại của Tiểu Hồng lưu loát hệt như học sinh bản xứ Trung Quốc.",
        explanation: "\"跟...一样流利\" so sánh mức độ lưu loát tương đương người bản xứ."
      },
      {
        chinese: "这两款智能手机的外观颜色虽然一样，但内部配置不一样。",
        pinyin: "Zhè liǎng kuǎn zhìnéng shǒujī de wàiguān yánsè suīrán yíyàng, dàn nèibù pèizhì bù yíyàng.",
        translation_vi: "Màu sắc bề ngoài của hai mẫu điện thoại thông minh này tuy giống nhau, nhưng cấu hình bên trong lại khác nhau.",
        explanation: "\"一样\" và \"不一样\" đối chiếu sự giống và khác nhau giữa hai vật."
      }
    ]
  },

  // --- NHÓM 15: CÁC CÂU TRÚC CÂU ĐẶC BIỆT (特殊句型) ---
  {
    order_index: 64,
    name: "Câu chữ 把 sơ cấp: Xử lý và dịch chuyển vị trí (把字句基础)",
    pattern: "Chủ ngữ + 把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成 (+ Thành phần khác)",
    category: "Cấu trúc câu",
    explanation_vi: "Câu chữ \"把\" (bǎ) dùng để nhấn mạnh hành động tác động lên tân ngữ và làm thay đổi trạng thái, vị trí hoặc thuộc tính của tân ngữ đó. Động từ trong câu chữ 把 không được đứng đơn độc mà phải có thành phần khác đi kèm (như bổ ngữ kết quả, địa điểm, từ chỉ đích đến).",
    examples: [
      {
        chinese: "请大家离开教室之前把所有窗户都关好。",
        pinyin: "Qǐng dàjiā líkāi jiàoshì zhīqián bǎ suǒyǒu chuānghu dōu guān hǎo.",
        translation_vi: "Xin mời mọi người trước khi rời lớp học hãy đóng kỹ tất cả các cửa sổ lại.",
        explanation: "\"把所有窗户都关好\" xử lý đối tượng cửa sổ bằng hành động đóng kín."
      },
      {
        chinese: "哥哥下班回家后，把公文包放在了客厅的茶几上。",
        pinyin: "Gēge xiàbān huíjiā hòu, bǎ gōngwénbāo fàng zài le kètīng de chájī shang.",
        translation_vi: "Sau khi anh trai tan sở về nhà đã đặt chiếc cặp tài liệu lên bàn trà phòng khách.",
        explanation: "\"把公文包放在...\" làm thay đổi vị trí của chiếc cặp tài liệu."
      }
    ]
  },
  {
    order_index: 65,
    name: "Câu tồn hiện miêu tả sự vật tĩnh tại (存在句)",
    pattern: "Nơi chốn + Động từ (放 / 挂 / 坐 / 站 / 停) + 着 + Danh từ",
    category: "Cấu trúc câu",
    explanation_vi: "Câu tồn hiện dùng để miêu tả một địa điểm cụ thể nào đó đang tồn tại hoặc duy trì một trạng thái của người hoặc vật. Đầu câu là cụm từ chỉ nơi chốn, sau động từ có trợ từ \"着\", danh từ phía sau là đối tượng chưa xác định (thường có số lượng từ).",
    examples: [
      {
        chinese: "会议室的正前方整齐地摆放着十张干净的长桌子。",
        pinyin: "Huìyìshì de zhèng qiánfāng zhěngqí de bǎifàng zhe shí zhāng gānjìng de cháng zhuōzi.",
        translation_vi: "Chính phía trước phòng họp đang được bày biện ngay ngắn mười chiếc bàn dài sạch sẽ.",
        explanation: "\"摆放着...\" miêu tả sự vật bàn dài đang tồn tại cố định trong phòng họp."
      },
      {
        chinese: "书房雪白的墙壁上挂着一幅名贵的水墨山水画。",
        pinyin: "Shūfáng xuěbái de qiángbì shang guà zhe yì fú míngguì de shuǐmò shānshuǐhuà.",
        translation_vi: "Trên bức tường trắng tinh của phòng sách đang treo một bức tranh sơn thủy thủy mặc quý giá.",
        explanation: "\"挂着\" miêu tả trạng thái tranh treo trên tường."
      }
    ]
  },
  {
    order_index: 66,
    name: "Câu liên động chỉ mục đích \"去 / 来 + Nơi chốn + Làm gì\"",
    pattern: "Chủ ngữ + 去 / 来 / 到 + Địa điểm + Động từ hành động (+ Tân ngữ)",
    category: "Cấu trúc câu",
    explanation_vi: "Câu liên động chỉ mục đích gồm hai cụm động từ đi liền nhau. Động từ thứ nhất là \"来 / 去 / 到\" chỉ sự di chuyển đến địa điểm, cụm động từ thứ hai nêu rõ mục đích của chuyến đi (đến đâu để làm việc gì).",
    examples: [
      {
        chinese: "很多外国青年慕名来到中国学习传统中医药学文化。",
        pinyin: "Hěn duō wàiguó qīngnián mùmíng lái dào Zhōngguó xuéxí chuántǒng zhōng-yīyàoxué wénhuà.",
        translation_vi: "Rất nhiều thanh niên nước ngoài ngưỡng mộ tìm đến Trung Quốc để học tập văn hóa y dược học cổ truyền.",
        explanation: "\"来到中国学习\" chỉ mục đích sang Trung Quốc là để học tập đông y."
      },
      {
        chinese: "我们今天下午准备去新华书店购买几本汉语复习参考书。",
        pinyin: "Wǒmen jīntiān xiàwǔ zhǔnbèi qù Xīnhuá Shūdiàn gòumǎi jǐ běn hànyǔ fùxí cānkǎoshū.",
        translation_vi: "Chiều hôm nay chúng tôi chuẩn bị đến Nhà sách Tân Hoa để mua vài cuốn sách tham khảo ôn thi tiếng Hán.",
        explanation: "\"去新华书店购买...\" nêu rõ mục đích đến hiệu sách mua sách tham khảo."
      }
    ]
  },
  {
    order_index: 67,
    name: "Câu liên động chỉ phương thức \"Động từ 1 + 着 + Động từ 2\"",
    pattern: "Chủ ngữ + Động từ 1 + 着 + (Tân ngữ 1) + Động từ 2 (+ Tân ngữ 2)",
    category: "Cấu trúc câu",
    explanation_vi: "Cấu trúc \"V1 + 着 + V2\" dùng hành động thứ nhất (V1) để làm phương thức hoặc trạng thái đệm cho hành động chính thứ hai (V2) diễn ra (làm việc 2 trong trạng thái việc 1, như: 站着说: đứng nói, 笑着听: cười nghe).",
    examples: [
      {
        chinese: "老校长微笑着走上讲台，热情地向全校新生致辞。",
        pinyin: "Lǎo xiàozhǎng wēixiào zhe zǒu shàng jiǎngtái, rèqíng de xiàng quán xiào xīnshēng zhìcí.",
        translation_vi: "Vị hiệu trưởng già mỉm cười bước lên bục giảng, nhiệt tình phát biểu chúc mừng tân sinh viên toàn trường.",
        explanation: "\"微笑着走上\" miêu tả nụ cười là phương thức thái độ khi bước lên bục."
      },
      {
        chinese: "下班回家的路上，几个年轻人听着音乐欢快地骑着自行车。",
        pinyin: "Xiàbān huíjiā de lù shang, jǐ gè niánqīngrén tīng zhe yīnyuè huānkuài de qí zhe zìxíngchē.",
        translation_vi: "Trên đường tan làm về nhà, mấy người trẻ vừa nghe nhạc vừa vui vẻ đạp xe đạp.",
        explanation: "\"听着音乐骑自行车\" thể hiện trạng thái nghe nhạc đồng thời khi đi xe đạp."
      }
    ]
  },
  {
    order_index: 68,
    name: "Câu hỏi phản vấn phủ định \"不是...吗？\" (Chẳng phải là... sao?)",
    pattern: "Chủ ngữ + 不是 + Vị ngữ / Tình huống + 吗?",
    category: "Cấu trúc câu",
    explanation_vi: "Cấu trúc \"不是...吗？\" (bú shì... ma?) dùng để hỏi ngược lại nhằm nhấn mạnh sự khẳng định chắc chắn về một sự việc hiển nhiên mà người nghe lẽ ra phải biết (chẳng phải là... sao, không phải là... ư). Mang ngữ khí nhắc nhở hoặc ngạc nhiên.",
    examples: [
      {
        chinese: "你昨天不是答应过今天会准时来参加同学聚会吗？",
        pinyin: "Nǐ zuótiān bú shì dāying guo jīntiān huì zhǔnshí lái cānjiā tóngxué jùhuì ma?",
        translation_vi: "Hôm qua chẳng phải bạn đã hứa hôm nay sẽ đến đúng giờ tham gia buổi họp lớp rồi sao?",
        explanation: "\"不是答应过...吗\" nhắc nhở lại lời hứa trong quá khứ."
      },
      {
        chinese: "今天外面不是正在下大雨吗，你怎么不带雨伞出门？",
        pinyin: "Jīntiān wàimiàn bú shì zhèngzài xià dàyǔ ma, nǐ zěnme bú dài yǔsǎn chūmén?",
        translation_vi: "Hôm nay bên ngoài chẳng phải đang đổ mưa to sao, sao bạn lại không mang ô ra ngoài?",
        explanation: "Nhấn mạnh thực tế trời mưa hiển nhiên."
      }
    ]
  },
  {
    order_index: 69,
    name: "Cấu trúc tăng tiến \"越...越...\" (Càng... càng...)",
    pattern: "越 + Tính từ / Động từ 1 + 越 + Tính từ / Động từ 2 / Chủ ngữ + 越 + V1 + 越 + V2",
    category: "Cấu trúc câu",
    explanation_vi: "Cấu trúc \"越...越...\" (yuè... yuè...) biểu thị mức độ phát triển của một trạng thái hoặc hành động tỉ lệ thuận tăng tiến theo sự gia tăng của một yếu tố khác hoặc theo thời gian (càng... thì càng...).",
    examples: [
      {
        chinese: "随着科技水平的不断提高，新能源汽车的性能越做越优异。",
        pinyin: "Suízhe kējì shuǐpíng de bùduàn tígāo, xīn néngyuán qìchē de xìngnéng yuè zuò yuè yōuyì.",
        translation_vi: "Cùng với trình độ công nghệ không ngừng nâng cao, tính năng của xe ô tô năng lượng mới càng làm càng trở nên vượt trội.",
        explanation: "\"越做越优异\" biểu thị chất lượng ngày càng xuất sắc hơn."
      },
      {
        chinese: "在异国他乡生活得越久，他心中对故乡亲人的思念就越深。",
        pinyin: "Zài yìguó-tāxiāng shēnghuó de yuè jiǔ, tā xīnzhōng duì gùxiāng qīnrén de sīniàn jiù yuè shēn.",
        translation_vi: "Sống ở nơi đất khách quê người càng lâu, nỗi nhớ nhung người thân nơi quê nhà trong lòng anh lại càng sâu nặng.",
        explanation: "\"越久...越深\" chỉ thời gian càng dài thì nỗi nhớ càng sâu sắc."
      }
    ]
  },
  {
    order_index: 70,
    name: "Cấu trúc tương lai sắp sửa xảy ra \"快(要)...了 / 就要...了\"",
    pattern: "Chủ ngữ + 快 / 快要 / 就要 + Động từ / Tính từ + 了",
    category: "Cấu trúc câu",
    explanation_vi: "Cấu trúc \"快要 / 就要...了\" (kuài yào / jiù yào... le) biểu thị một hành động hoặc sự thay đổi trạng thái sẽ diễn ra trong thời gian rất ngắn sắp tới (sắp... rồi). Chú ý: Nếu câu có trạng ngữ thời gian cụ thể (như 明天, 下周) thì chỉ được dùng \"就要...了\", không dùng \"快要...了\".",
    examples: [
      {
        chinese: "列车快要开动了，请送行的亲友尽快走下车厢。",
        pinyin: "Lièchē kuàiyào kāidòng le, qǐng sòngxíng de qīnyǒu jǐnkuài zǒu xià chēxiāng.",
        translation_vi: "Đoàn tàu sắp chuyển bánh rồi, xin mời người thân tiễn đưa mau chóng bước xuống toa tàu.",
        explanation: "\"快要开动了\" biểu thị sự việc khởi hành sắp sửa diễn ra trong tích tắc."
      },
      {
        chinese: "明天早晨八点我们就要举行新校区奠基仪式了。",
        pinyin: "Míngtiān zǎochén bā diǎn wǒmen jiù yào jǔxíng xīn xiàoqū diànjī yíshì le.",
        translation_vi: "Tám giờ sáng mai chúng tôi sẽ tổ chức lễ đặt đá khởi công khu học xá mới rồi.",
        explanation: "\"明天早晨八点...就要...了\" có mốc giờ cụ thể kết hợp với \"就要\".",
      }
    ]
  },
  {
    order_index: 71,
    name: "Cấu trúc nhấn mạnh quá khứ \"是...的\" (Đặc tả thời gian, địa điểm, cách thức)",
    pattern: "Chủ ngữ + 是 + [Thời gian / Địa điểm / Phương thức / Mục đích] + Động từ + 的",
    category: "Cấu trúc câu",
    explanation_vi: "Cấu trúc \"是...的\" (shì... de) dùng cho một sự việc ĐÃ HOÀN THÀNH trong quá khứ nhằm nhấn mạnh vào chi tiết thời gian (khi nào), địa điểm (ở đâu), cách thức tiến hành (bằng cách nào) hoặc chủ thể thực hiện.",
    examples: [
      {
        chinese: "我是去年九月份乘坐长途客机来到北京留学的。",
        pinyin: "Wǒ shì qùnián jiǔ yuèfèn chéngzuò chángtú kèjī lái dào Běijīng liúxué de.",
        translation_vi: "Tôi là vào tháng Chín năm ngoái đi máy bay đường dài đến Bắc Kinh du học.",
        explanation: "\"是去年九月份...的\" nhấn mạnh mốc thời gian du học đã diễn ra."
      },
      {
        chinese: "这本珍贵的汉语字典是恩师在大学毕业时送给我的。",
        pinyin: "Zhè běn zhēnguì de hànyǔ zìdiǎn shì ēnshī zài dàxué bìyè shí sòng gěi wǒ de.",
        translation_vi: "Cuốn tự điển tiếng Hán quý giá này là người thầy ơn đã tặng cho tôi khi tốt nghiệp đại học.",
        explanation: "\"是恩师...送给我的\" nhấn mạnh người tặng và thời điểm tặng."
      }
    ]
  },
  {
    order_index: 72,
    name: "Cấu trúc điều kiện cần thiết \"只要...就...\" (Chỉ cần... thì...)",
    pattern: "只要 + Điều kiện cần, 就 + Kết quả tương ứng",
    category: "Cấu trúc câu",
    explanation_vi: "Cặp liên từ \"只要...就...\" (zhǐyào... jiù...) biểu thị mối quan hệ điều kiện cần thiết: chỉ cần có điều kiện này được đáp ứng thì nhất định sẽ sản sinh ra kết quả tương ứng kèm theo (chỉ cần... thì sẽ...).",
    examples: [
      {
        chinese: "只要大家齐心协力努力拼搏，就一定能够战胜困难。",
        pinyin: "Zhǐyào dàjiā qíxīn-xiélì nǔlì pīnbó, jiù yídìng nénggòu zhànshèng kùnnán.",
        translation_vi: "Chỉ cần mọi người đồng tâm hiệp lực nỗ lực phấn đấu thì nhất định có thể chiến thắng khó khăn.",
        explanation: "\"只要...就...\" nhấn mạnh chỉ cần có sự chung sức sẽ dẫn tới thành công."
      },
      {
        chinese: "只要明天天气晴朗不刮大风，我们全家人就去郊游。",
        pinyin: "Zhǐyào míngtiān tiānqì qínglǎng bù guā dàfēng, wǒmen quán jiārén jiù qù jiāoyóu.",
        translation_vi: "Chỉ cần ngày mai thời tiết tạnh ráo không nổi gió lớn thì cả gia đình chúng tôi sẽ đi dã ngoại.",
        explanation: "Điều kiện thời tiết tốt để cả nhà đi chơi."
      }
    ]
  },
  {
    order_index: 73,
    name: "Đại từ chỉ định không xác định \"一些 / 有的\" (Một số / Có những)",
    pattern: "一些 + Danh từ / 有的 + Danh từ (+ ..., 有的...)",
    category: "Đại từ",
    explanation_vi: "\"一些\" (yìxiē) biểu thị số lượng không xác định của sự vật (một vài, một số). \"有的\" (yǒude) dùng để chỉ một bộ phận trong một tổng thể (có người, có những cái). Cấu trúc sóng đôi \"有的...有的...\" chỉ sự đa dạng.",
    examples: [
      {
        chinese: "下课后操场上很热闹，有的同学在打篮球，有的在跑步。",
        pinyin: "Xiàkè hòu cāochǎng shang hěn rènao, yǒude tóngxué zài dǎ lánqiú, yǒude zài pǎobù.",
        translation_vi: "Sau khi tan học sân vận động rất náo nhiệt, có bạn đang chơi bóng rổ, có bạn lại đang chạy bộ.",
        explanation: "\"有的...有的...\" miêu tả các nhóm hoạt động phong phú của học sinh."
      },
      {
        chinese: "他在书店精心挑选了一些适合初学者的汉语课外读物。",
        pinyin: "Tā zài shūdiàn jīngxīn tiāoxuǎn le yìxiē shìhé chūxuézhě de hànyǔ kèwài dúwù.",
        translation_vi: "Anh ấy ở hiệu sách đã kỳ công chọn lựa một số cuốn sách đọc thêm tiếng Hán thích hợp cho người mới bắt đầu.",
        explanation: "\"一些...读物\" chỉ một số lượng sách nhất định."
      }
    ]
  },
  {
    order_index: 74,
    name: "Trùng điệp động từ biểu thị thử nghiệm / thoải mái \"AA / A一A\"",
    pattern: "Động từ đơn âm: AA / A一A / A了A (看看 / 看一看 / 看了看)",
    category: "Động từ",
    explanation_vi: "Trùng điệp động từ (lặp lại động từ) dùng để biểu thị động tác diễn ra trong thời gian ngắn, mang tính chất thử nghiệm, nhẹ nhàng hoặc làm cho ngữ khí câu cầu khiến trở nên mềm mại, hòa nhã (thử xem chút, ngắm một tí).",
    examples: [
      {
        chinese: "这件羊毛外套款式很新颖，你快穿上试一试合不合身。",
        pinyin: "Zhè jiàn yángmáo wàitào kuǎnshì hěn xīnyǐng, nǐ kuài chuān shang shì-yi-shì hé bù héshēn.",
        translation_vi: "Chiếc áo khoác dạ len này kiểu dáng rất mới lạ, bạn mau mặc thử một chút xem có vừa vặn không.",
        explanation: "\"试一试\" biểu thị hành động mặc thử mang tính trải nghiệm ngắn."
      },
      {
        chinese: "周末我们在家里听听轻音乐、看看书，身心格外放松。",
        pinyin: "Zhōumò wǒmen zài jiā lǐ tīng-ting qīngyīnyuè, kàn-kan shū, shēnxīn géwài fàngsōng.",
        translation_vi: "Cuối tuần chúng tôi ở nhà nghe chút nhạc nhẹ, đọc chút sách, thân tâm vô cùng thư thái.",
        explanation: "\"听听\" và \"看看\" tạo cảm giác thư giãn nhẹ nhàng của các hoạt động."
      }
    ]
  },
  {
    order_index: 75,
    name: "Trùng điệp tính từ miêu tả mức độ \"AA(的)\" (Xanh mướt / Tròn xoe / Cao vút)",
    pattern: "Tính từ đơn âm trùng điệp: AA (+ 的) + Danh từ (红红的 / 大大的 / 高高的)",
    category: "Tính từ",
    explanation_vi: "Trùng điệp tính từ đơn âm tiết thành dạng \"AA(的)\" dùng để tăng cường mức độ miêu tả, mang sắc thái biểu cảm yêu mến, sinh động hoặc cụ thể hóa hình tượng (tròn xoe, đỏ ửng, cao vút). Thường làm định ngữ hoặc trạng ngữ.",
    examples: [
      {
        chinese: "小妹妹长着一双大大的眼睛和一张红红的小脸蛋。",
        pinyin: "Xiǎo mèimei zhǎng zhe yì shuāng dàdà de yǎnjīng hé yì zhāng hónghóng de xiǎo liǎndàn.",
        translation_vi: "Em gái nhỏ có một đôi mắt to tròn xoe và một khuôn mặt nhỏ ửng hồng xinh xắn.",
        explanation: "\"大大的\" và \"红红的\" miêu tả sinh động vẻ đáng yêu của em bé."
      },
      {
        chinese: "公路两旁整齐地生长着一排排高高的白杨树。",
        pinyin: "Gōnglù liǎngpáng zhěngqí de shēngzhǎng zhe yì páipái gāogāo de báiyángshù.",
        translation_vi: "Hai bên đường cái mọc ngay ngắn từng hàng cây bạch dương cao vút.",
        explanation: "\"高高的\" nhấn mạnh chiều cao nổi bật của rặng cây."
      }
    ]
  },
  {
    order_index: 76,
    name: "Phó từ biểu thị tính chất vốn có \"本来\" (Vốn dĩ / Ban đầu)",
    pattern: "Chủ ngữ + 本来 + Vị ngữ (+ 后来 / 但是...)",
    category: "Phó từ",
    explanation_vi: "\"本来\" (běnlái) biểu thị trạng thái hoặc tình huống vốn dĩ từ trước đến nay là như vậy, hoặc kế hoạch ban đầu như vậy nhưng về sau có sự thay đổi (vốn dĩ, lẽ ra, ban đầu).",
    examples: [
      {
        chinese: "我们本来打算今天去郊游，可是突降大暴雨只好改期。",
        pinyin: "Wǒmen běnlái dǎsuàn jīntiān qù jiāoyóu, kěshì tūjiàng dà bàoyǔ zhǐhǎo gǎiqī.",
        translation_vi: "Chúng tôi vốn dĩ dự tính hôm nay đi dã ngoại, nhưng bất chợt đổ mưa to đành phải dời ngày.",
        explanation: "\"本来打算...可是...\" biểu thị kế hoạch ban đầu bị thay đổi do mưa."
      },
      {
        chinese: "这道数学题本来就很简单，只要细心就能做对。",
        pinyin: "Zhè dào shùxué tí běnlái jiù hěn jiǎndān, zhǐyào xìxīn jiù néng zuò duì.",
        translation_vi: "Bài toán này vốn dĩ đã rất đơn giản, chỉ cần cẩn thận là có thể làm đúng.",
        explanation: "\"本来就很简单\" nhấn mạnh bản chất vốn có của bài toán."
      }
    ]
  },
  {
    order_index: 77,
    name: "Từ chỉ thời gian cự ly ngắn \"不久\" (Chẳng bao lâu / Vừa mới)",
    pattern: "Thời điểm / Hành động + 不久 (+ 就...) / 不久以前",
    category: "Phó từ",
    explanation_vi: "\"不久\" (bùjiǔ) chỉ khoảng cách thời gian rất ngắn giữa hai thời điểm hoặc khoảng cách ngắn so với hiện tại (chẳng bao lâu sau, cách đây không lâu).",
    examples: [
      {
        chinese: "他们大学毕业后不久，就顺利进入了知名外企工作。",
        pinyin: "Tāmen dàxué bìyè hòu bùjiǔ, jiù shùnlì jìnrù le zhīmíng wàiqǐ gōngzuò.",
        translation_vi: "Họ sau khi tốt nghiệp đại học chẳng bao lâu, thì đã thuận lợi bước chân vào làm việc tại công ty nước ngoài danh tiếng.",
        explanation: "\"毕业后不久\" chỉ khoảng thời gian ngắn sau khi tốt nghiệp."
      },
      {
        chinese: "这栋现代化的综合教学大楼是不久前刚刚建成的。",
        pinyin: "Zhè dòng xiàndàihuà de zōnghé jiàoxué dàlóu shì bùjiǔ qián gānggāng jiànchéng de.",
        translation_vi: "Tòa nhà giảng đường tổng hợp hiện đại này là cách đây không lâu vừa mới xây dựng xong.",
        explanation: "\"不久前\" chỉ thời điểm xảy ra gần đây."
      }
    ]
  },
  {
    order_index: 78,
    name: "Cấu trúc cảm thán biểu thị mức độ cao \"太...了\" (Quá... rồi / Lắm)",
    pattern: "太 + Tính từ / Động từ tâm lý + 了!",
    category: "Phó từ",
    explanation_vi: "\"太...了\" (tài... le) dùng để biểu thị mức độ cực kỳ cao, thường dùng trong câu cảm thán để bày tỏ sự khen ngợi, tán thưởng nồng nhiệt hoặc phàn nàn, không hài lòng (quá... rồi, ...lắm).",
    examples: [
      {
        chinese: "你在全国青少年演讲比赛中的发挥真是太出色了！",
        pinyin: "Nǐ zài quánguó qīng-shàonián yǎnjiǎng bǐsài zhōng de fāhuī zhēn shì tài chūsè le!",
        translation_vi: "Màn thể hiện của bạn trong cuộc thi diễn thuyết thanh thiếu niên toàn quốc thật là quá xuất sắc rồi!",
        explanation: "\"太出色了\" ca ngợi phong độ tuyệt vời của thí sinh."
      },
      {
        chinese: "这盘北京烤鸭皮脆肉嫩，味道太香了！",
        pinyin: "Zhè pán Běijīng kǎoyā pí cuì ròu nèn, wèidào tài xiāng le!",
        translation_vi: "Đĩa vịt quay Bắc Kinh này da giòn thịt mềm, mùi vị thơm ngon quá chừng!",
        explanation: "\"太香了\" tán thán hương vị tuyệt hảo của món ăn."
      }
    ]
  }
];
