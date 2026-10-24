export const HSK2_GRAMMAR_PART2 = [
  // --- NHÓM 6: LIÊN TỪ (连词) ---
  {
    order_index: 27,
    name: "Liên từ nhân quả \"因为...所以...\" (Bởi vì... cho nên...)",
    pattern: "因为 + Nguyên nhân, 所以 + Kết quả",
    category: "Liên từ",
    explanation_vi: "Cặp liên từ \"因为...所以...\" (yīnwèi... suǒyǐ...) dùng để biểu thị mối quan hệ nhân quả. Phân câu trước nêu lý do, phân câu sau nêu kết quả dẫn tới. Trong giao tiếp khẩu ngữ có thể lược bỏ \"因为\" hoặc \"所以\".",
    examples: [
      {
        chinese: "因为今天早晨突降大雨，所以我们取消了去郊区的野餐计划。",
        pinyin: "Yīnwèi jīntiān zǎochén tūjiàng dàyǔ, suǒyǐ wǒmen qǔxiāo le qù jiāoqū de yěcān jìhuà.",
        translation_vi: "Bởi vì sáng nay trời bất chợt đổ mưa to, cho nên chúng tôi đã hủy bỏ kế hoạch đi dã ngoại ngoại ô.",
        explanation: "\"因为...所以...\" liên kết nguyên nhân trời mưa với kết quả hủy kế hoạch."
      },
      {
        chinese: "因为他平时勤奋刻苦，所以这次汉语考试取得了好成绩。",
        pinyin: "Yīnwèi tā píngrì qínfèn kèkǔ, suǒyǐ zhè cì hànyǔ kǎoshì qǔdé le hǎo chéngjì.",
        translation_vi: "Bởi vì thường ngày anh ấy chăm chỉ khổ luyện, cho nên kỳ thi tiếng Hán lần này đã đạt được thành tích tốt.",
        explanation: "Biểu thị nguyên nhân học tập chăm chỉ dẫn đến kết quả thi tốt."
      }
    ]
  },
  {
    order_index: 28,
    name: "Liên từ chuyển ngoặt \"虽然...但是...\" (Tuy rằng... nhưng mà...)",
    pattern: "虽然 + Phân câu nhượng bộ, 但是 / 可是 + Phân câu chuyển ngoặt",
    category: "Liên từ",
    explanation_vi: "Cặp liên từ \"虽然...但是...\" (suīrán... dànshì...) biểu thị mối quan hệ nhượng bộ và chuyển ngoặt (tuy... nhưng...). Phân câu sau chuyển hướng ý nghĩa ngược lại hoặc bổ sung khía cạnh khác so với phân câu trước.",
    examples: [
      {
        chinese: "这道中国菜虽然看起来有点辣，但是吃起来非常香。",
        pinyin: "Zhè dào zhōngguócài suīrán kàn qǐlai yǒudiǎn là, dànshì chī qǐlai fēicháng xiāng.",
        translation_vi: "Món ăn Trung Quốc này tuy nhìn có vẻ hơi cay, nhưng ăn vào lại vô cùng thơm ngon.",
        explanation: "\"虽然...但是...\" thể hiện sự chuyển biến từ vẻ bề ngoài tới hương vị thực tế."
      },
      {
        chinese: "他虽然学习汉语的时间不长，但是发音非常准确流利。",
        pinyin: "Tā suīrán xuéxí hànyǔ de shíjiān bù cháng, dànshì fāyīn fēicháng zhǔnquè liúlì.",
        translation_vi: "Anh ấy tuy thời gian học tiếng Hán chưa lâu, nhưng phát âm lại vô cùng chuẩn xác lưu loát.",
        explanation: "Chuyển ngoặt giữa thời gian học ngắn và phát âm tốt."
      }
    ]
  },
  {
    order_index: 29,
    name: "Liên từ lựa chọn câu trần thuật \"或者\" (Hoặc / Hoặc là)",
    pattern: "Lựa chọn A + 或者 + Lựa chọn B",
    category: "Liên từ",
    explanation_vi: "\"或者\" (huòzhě) dùng để liên kết các sự vật, hành động có tính chất lựa chọn trong câu trần thuật hoặc câu khẳng định (hoặc, hoặc là). Không dùng trong câu hỏi nghi vấn lựa chọn (câu hỏi dùng \"还是\").",
    examples: [
      {
        chinese: "周末我通常在家里安静看书，或者去公园散步。",
        pinyin: "Zhōumò wǒ tōngcháng zài jiā lǐ ānjìng kànshū, huòzhě qù gōngyuán sànbù.",
        translation_vi: "Cuối tuần tôi thường yên tĩnh đọc sách ở nhà, hoặc là đến công viên đi dạo.",
        explanation: "\"或者\" dùng trong câu trần thuật nối hai hoạt động lựa chọn cuối tuần."
      },
      {
        chinese: "你可以选择喝热咖啡，或者喝新鲜的苹果汁。",
        pinyin: "Nǐ kěyǐ xuǎnzé hē rè kāfēi, huòzhě hē xīnxiān de píngguǒzhī.",
        translation_vi: "Bạn có thể lựa chọn uống cà phê nóng, hoặc là uống nước ép táo tươi.",
        explanation: "\"或者\" đưa ra 2 phương án đồ uống cho người nghe."
      }
    ]
  },
  {
    order_index: 30,
    name: "Liên từ lựa chọn câu nghi vấn \"还是\" (Hay là / Hay)",
    pattern: "Phương án A + 还是 + Phương án B?",
    category: "Liên từ",
    explanation_vi: "\"还是\" (háishì) dùng trong câu hỏi lựa chọn để yêu cầu người nghe chọn một trong hai hoặc nhiều phương án được đưa ra (hay là, hoặc). Thường kết thúc bằng dấu chấm hỏi \"?\".",
    examples: [
      {
        chinese: "请问你想喝热茶还是想喝冰水？",
        pinyin: "Qǐngwèn nǐ xiǎng hē rè chá háishì xiǎng hē bīngshuǐ?",
        translation_vi: "Xin hỏi bạn muốn uống trà nóng hay là muốn uống nước đá?",
        explanation: "\"还是\" dùng trong câu hỏi lựa chọn giữa trà nóng và nước đá."
      },
      {
        chinese: "我们明天坐高铁去上海，还是坐飞机去？",
        pinyin: "Wǒmen míngtiān zuò gāotiě qù Shànghǎi, háishì zuò fēijī qù?",
        translation_vi: "Ngày mai chúng ta đi tàu cao tốc đến Thượng Hải, hay là đi máy bay?",
        explanation: "Hỏi lựa chọn phương tiện di chuyển."
      }
    ]
  },
  {
    order_index: 31,
    name: "Liên từ thứ tự thời gian \"然后\" (Sau đó / Rồi)",
    pattern: "Hành động 1, 然后 + Hành động 2",
    category: "Liên từ",
    explanation_vi: "\"然后\" (ránhòu) là liên từ biểu thị sự tiếp nối tuần tự của hai hành động theo trình tự thời gian (sau đó, rồi thì). Thường đi liền trong chuỗi: \"先...然后...\" (trước tiên... sau đó...).",
    examples: [
      {
        chinese: "我们先去超市买蔬菜，然后回家一起做晚饭。",
        pinyin: "Wǒmen xiān qù chāoshì mǎi shūcài, ránhòu huíjiā yìqǐ zuò wǎnfàn.",
        translation_vi: "Chúng ta trước tiên đến siêu thị mua rau, sau đó về nhà cùng nhau nấu cơm tối.",
        explanation: "\"先...然后...\" chỉ rõ trình tự trước sau của việc đi chợ và nấu ăn."
      },
      {
        chinese: "你先填写这张个人表格，然后去二楼会议室面试。",
        pinyin: "Nǐ xiān tiánxiě zhè zhāng gèrén biǎogé, ránhòu qù èr lóu huìyìshì miànshì.",
        translation_vi: "Bạn trước tiên hãy điền vào phiếu cá nhân này, sau đó lên phòng họp tầng hai phỏng vấn.",
        explanation: "Chỉ dẫn quy trình làm việc theo thứ tự."
      }
    ]
  },

  // --- NHÓM 7: GIỚI TỪ (介词) ---
  {
    order_index: 32,
    name: "Giới từ đối tượng tiếp nhận \"给\" (Cho / Cho ai)",
    pattern: "Chủ ngữ + 给 + Đối tượng + Động từ (+ Tân ngữ)",
    category: "Giới từ",
    explanation_vi: "\"给\" (gěi) làm giới từ đứng trước danh từ chỉ người hoặc tổ chức để chỉ đối tượng phục vụ hoặc người tiếp nhận hành động (cho, cho ai đó, tặng cho).",
    examples: [
      {
        chinese: "爸爸每天早晨都耐心地给我讲一个有趣的成语故事。",
        pinyin: "Bàba měitiān zǎochén dōu nàixīn de gěi wǒ jiǎng yí gè yǒuqù de chéngyǔ gùshì.",
        translation_vi: "Mỗi sáng sớm bố đều kiên nhẫn kể cho tôi nghe một câu chuyện thành ngữ thú vị.",
        explanation: "\"给我讲\" biểu thị đối tượng lắng nghe câu chuyện là tôi."
      },
      {
        chinese: "母亲正在厨房里给全家人准备丰盛可口的午饭。",
        pinyin: "Mǔqīn zhèngzài chúfáng lǐ gěi quán jiārén zhǔnbèi fēngshèng kěkǒu de wǔfàn.",
        translation_vi: "Người mẹ đang ở trong bếp chuẩn bị bữa trưa thịnh soạn ngon miệng cho cả gia đình.",
        explanation: "\"给全家人准备\" chỉ đối tượng thụ hưởng bữa cơm trưa."
      }
    ]
  },
  {
    order_index: 33,
    name: "Giới từ khởi điểm \"从\" (Từ / Bắt đầu từ)",
    pattern: "从 + Nơi chốn / Thời gian + Động từ (+ 到...)",
    category: "Giới từ",
    explanation_vi: "\"从\" (cóng) biểu thị mốc xuất phát về không gian, thời gian hoặc phạm vi (từ, bắt đầu từ). Thường phối hợp với \"到\" (đến) tạo thành kết cấu \"从...到...\" (từ... đến...).",
    examples: [
      {
        chinese: "这趟高铁从北京出发，只需要四个小时就到上海。",
        pinyin: "Zhè tàng gāotiě cóng Běijīng chūfā, zhǐ xūyào sì gè xiǎoshí jiù dào Shànghǎi.",
        translation_vi: "Chuyến tàu cao tốc này xuất phát từ Bắc Kinh, chỉ cần bốn tiếng đồng hồ là đến Thượng Hải.",
        explanation: "\"从北京出发\" chỉ điểm khởi hành về mặt địa lý."
      },
      {
        chinese: "他从星期一到星期五都在大学图书馆认真复习功课。",
        pinyin: "Tā cóng xīngqīyī dào xīngqīwǔ dōu zài dàxué túshūguǎn rènzhēn fùxí gōngkè.",
        translation_vi: "Anh ấy từ thứ Hai đến thứ Sáu đều ở thư viện trường đại học chăm chỉ ôn bài.",
        explanation: "\"从...到...\" biểu thị khoảng thời gian từ đầu tuần tới cuối tuần."
      }
    ]
  },
  {
    order_index: 34,
    name: "Giới từ phương hướng chuyển động \"往\" (Về phía / Hướng về)",
    pattern: "往 + Phương hướng / Địa điểm + Động từ (走 / 开 / 看 / 飞)",
    category: "Giới từ",
    explanation_vi: "\"往\" (wǎng) chỉ phương hướng mục tiêu của hành động di chuyển (hướng về phía, đi về phía). Thường đi với các động từ chỉ sự di chuyển như: 往东走 (đi về phía Đông), 往前看 (nhìn về phía trước).",
    examples: [
      {
        chinese: "从这个十字路口一直往前走两百米就是市立医院。",
        pinyin: "Cóng zhè gè shízì-lùkǒu yìzhí wǎng qián zǒu liǎng bǎi mǐ jiù shì shìlì yīyuàn.",
        translation_vi: "Từ ngã tư này đi thẳng về phía trước hai trăm mét là bệnh viện thành phố.",
        explanation: "\"往前走\" chỉ dẫn phương hướng tiến bước về phía trước."
      },
      {
        chinese: "请大家下了公共汽车后往右边拐，就能看到地铁站入口。",
        pinyin: "Qǐng dàjiā xià le gōnggòng qìchē hòu wǎng yòubiān guǎi, jiù néng kàn dào dìtiězhàn rùkǒu.",
        translation_vi: "Mời mọi người sau khi xuống xe buýt thì rẽ về phía bên phải là có thể nhìn thấy lối vào ga tàu điện ngầm.",
        explanation: "\"往右边拐\" chỉ hướng rẽ phải."
      }
    ]
  },
  {
    order_index: 35,
    name: "Giới từ hướng mục tiêu đối tượng \"向\" (Hướng tới / Về phía)",
    pattern: "向 + Đối tượng / Phương vị + Động từ (学 / 借 / 走 / 报告)",
    category: "Giới từ",
    explanation_vi: "\"向\" (xiàng) có thể chỉ phương hướng không gian (như 往) và đặc biệt dùng chỉ đối tượng mà hành động nhắm vào (như 向老师请教: thỉnh giáo thầy giáo, 向他学习: học tập anh ấy).",
    examples: [
      {
        chinese: "全班同学都应当虚心向经验丰富的李老师学习。",
        pinyin: "Quán bān tóngxué dōu yīngdāng xūxīn xiàng jīngyàn fēngfù de Lǐ lǎoshī xuéxí.",
        translation_vi: "Học sinh cả lớp đều nên khiêm tốn học tập thầy Lý giàu kinh nghiệm.",
        explanation: "\"向...学习\" chỉ đối tượng học tập là thầy Lý."
      },
      {
        chinese: "轮船迎着朝阳缓缓向南方的大海深处航行。",
        pinyin: "Lúnchuán yíng zhe zhāoyáng huǎnhuǎn xiàng nánfāng de dàhǎi shēncù hángxíng.",
        translation_vi: "Con tàu đón ánh bình minh từ từ hướng về biển sâu phương Nam căng buồm rẽ sóng.",
        explanation: "\"向南方...航行\" chỉ phương hướng di chuyển của con thuyền."
      }
    ]
  },
  {
    order_index: 36,
    name: "Giới từ đối tượng tương tác \"对\" (Đối với / Về)",
    pattern: "对 + Đối tượng + Vị ngữ / Đối tượng 1 + 对 + Đối tượng 2 + Tính từ",
    category: "Giới từ",
    explanation_vi: "\"对\" (duì) dùng để đưa ra đối tượng mà hành vi tác động tới, hoặc đối tượng tiếp nhận tình cảm, thái độ, tính chất (đối với, đối cùng). Cấu trúc thường gặp: 对...感兴趣 (có hứng thú với...), 对...好 (tốt với...).",
    examples: [
      {
        chinese: "这位热心的老教授对每一个学生都非常和蔼客气。",
        pinyin: "Zhè wèi rèxīn de lǎo jiàoshòu duì měi yí gè xuésheng dōu fēicháng hé'ǎi kèqì.",
        translation_vi: "Vị giáo sư già nhiệt tình này đối với mỗi một học sinh đều vô cùng hòa nhã nhã nhặn.",
        explanation: "\"对...和蔼客气\" biểu thị thái độ cư xử tốt đối với học trò."
      },
      {
        chinese: "很多外国留学生都对博大精深的中国京剧艺术很感兴趣。",
        pinyin: "Hěn duō wàiguó liúxuéshēng dōu duì bódà-jīngshēn de zhōngguó jīngjù yìshù hěn gǎn xìngqù.",
        translation_vi: "Rất nhiều lưu học sinh nước ngoài đều rất có hứng thú đối với nghệ thuật Kinh kịch Trung Quốc uyên thâm.",
        explanation: "\"对...感兴趣\" là cấu trúc cố định chỉ sự say mê hứng thú."
      }
    ]
  },
  {
    order_index: 37,
    name: "Giới từ cự ly không gian / thời gian \"离\" (Cách / Cách xa)",
    pattern: "Địa điểm / Mốc thời gian A + 离 + B + (不) 远 / 近 / Cự ly cụ thể",
    category: "Giới từ",
    explanation_vi: "\"离\" (lí) biểu thị cự ly khoảng cách về mặt không gian hoặc thời gian giữa hai điểm (cách). Không được dùng với phó từ chỉ vị trí \"从\".",
    examples: [
      {
        chinese: "我家离学校非常近，走路只需要五分钟就能到达。",
        pinyin: "Wǒ jiā lí xuéxiào fēicháng jìn, zǒulù zhǐ xūyào wǔ fēnzhōng jiù néng dàodá.",
        translation_vi: "Nhà tôi cách trường học rất gần, đi bộ chỉ cần năm phút là có thể tới nơi.",
        explanation: "\"离学校非常近\" chỉ khoảng cách không gian địa lý ngắn."
      },
      {
        chinese: "现在离春节放假还有一个星期，大家都在忙着准备年货。",
        pinyin: "Xiànzài lí chūnjié fàngjià hái yǒu yí gè xīngqī, dàjiā dōu zài máng zhe zhǔnbèi niánhuò.",
        translation_vi: "Bây giờ cách kỳ nghỉ tết Nguyên đán còn một tuần nữa, mọi người đều đang bận sắm sửa đồ tết.",
        explanation: "\"离春节放假\" chỉ khoảng cách thời gian còn lại."
      }
    ]
  },
  {
    order_index: 38,
    name: "Giới từ mục đích & vì đối tượng \"为\" (Vì / Cho)",
    pattern: "为 + Đối tượng / Mục đích + Động từ (+ Tân ngữ)",
    category: "Giới từ",
    explanation_vi: "\"为\" (wèi) đứng trước danh từ để chỉ mục đích của hành động (vì cái gì) hoặc chỉ người/đối tượng được hành động phục vụ (cho ai). Thường gặp: 为...高兴 (mừng cho ai), 为...服务 (phục vụ ai).",
    examples: [
      {
        chinese: "听到你顺利通过高级汉语考试的消息，我们都为你感到高兴。",
        pinyin: "Tīng dào nǐ shùnlì tōngguò gāojí hànyǔ kǎoshì de xiāoxi, wǒmen dōu wèi nǐ gǎndào gāoxìng.",
        translation_vi: "Nghe tin bạn thuận lợi thi đỗ kỳ thi Hán ngữ cao cấp, chúng tôi đều cảm thấy vui mừng thay cho bạn.",
        explanation: "\"为你感到高兴\" chỉ người được vui mừng cho là bạn."
      },
      {
        chinese: "这家社区服务中心始终全心全意为广大居民排忧解难。",
        pinyin: "Zhè jiā shèqū fúwù zhōngxīn shǐzhōng quánxīn-quányì wèi guǎngdà jūmín páiyōu-jiěnán.",
        translation_vi: "Trung tâm dịch vụ cộng đồng này luôn toàn tâm toàn ý giải quyết khó khăn lo toan cho đông đảo cư dân.",
        explanation: "\"为广大居民\" chỉ đối tượng được phục vụ."
      }
    ]
  },
  {
    order_index: 39,
    name: "Giới từ so sánh \"比\" cơ bản (Hơn / So với)",
    pattern: "Chủ ngữ A + 比 + Chủ ngữ B + Tính từ",
    category: "Giới từ",
    explanation_vi: "\"比\" (bǐ) dùng trong câu so sánh bậc hơn giữa hai đối tượng A và B. Chú ý: Trước tính từ vị ngữ trong câu chữ 比 KHÔNG được dùng các phó từ mức độ như 很, 非常, 真.",
    examples: [
      {
        chinese: "弟弟现在的身高已经比哥哥高了整整两厘米。",
        pinyin: "Dìdi xiànzài de shēngāo yǐjīng bǐ gēge gāo le zhěngzhěng liǎng límǐ.",
        translation_vi: "Chiều cao hiện tại của em trai đã cao hơn anh trai trọn vẹn hai centimet.",
        explanation: "\"比哥哥高\" là cấu trúc so sánh hơn tiêu chuẩn về chiều cao."
      },
      {
        chinese: "今天户外的气温比昨天低了三度，需要多穿一件外套。",
        pinyin: "Jīntiān hùwài de qìwēn bǐ zuótiān dī le sān dù, xūyào duō chuān yí jiàn wàitào.",
        translation_vi: "Nhiệt độ ngoài trời hôm nay thấp hơn hôm qua ba độ, cần phải mặc thêm một chiếc áo khoác.",
        explanation: "\"比昨天低\" so sánh nhiệt độ giữa hai ngày."
      }
    ]
  },

  // --- NHÓM 8: TRỢ TỪ (助词) ---
  {
    order_index: 40,
    name: "Trợ từ kết cấu bổ ngữ trạng thái \"得\"",
    pattern: "Động từ (+ Tân ngữ + Động từ) + 得 + (很 / 非常) + Tính từ / Cụm vị ngữ",
    category: "Trợ từ",
    explanation_vi: "\"得\" (de) là trợ từ kết cấu nối giữa động từ và bổ ngữ chỉ trạng thái để đánh giá, miêu tả mức độ, kết quả hoặc trạng thái thực hiện của hành động (làm ra sao, đến mức nào). Nếu động từ mang tân ngữ thì phải lặp lại động từ.",
    examples: [
      {
        chinese: "这位外国留学生的汉字写得非常工整漂亮。",
        pinyin: "Zhè wèi wàiguó liúxuéshēng de hànzì xiě de fēicháng gōngzhěng piàoliang.",
        translation_vi: "Chữ Hán của bạn lưu học sinh nước ngoài này viết rất nắn nót đẹp đẽ.",
        explanation: "\"写得非常工整\" dùng \"得\" kết nối động từ \"写\" và bổ ngữ đánh giá."
      },
      {
        chinese: "他昨天晚上睡得很香，今天早晨精神格外饱满。",
        pinyin: "Tā zuótiān wǎnshang shuì de hěn xiāng, jīntiān zǎochén jīngshén géwài bǎomǎn.",
        translation_vi: "Tối hôm qua anh ấy ngủ rất ngon giấc, sáng nay tinh thần cực kỳ phấn chấn.",
        explanation: "\"睡得很香\" đánh giá trạng thái giấc ngủ."
      }
    ]
  },
  {
    order_index: 41,
    name: "Trợ từ động thái trạng thái tiếp diễn \"着\"",
    pattern: "Động từ + 着 (+ Tân ngữ)",
    category: "Trợ từ",
    explanation_vi: "\"着\" (zhe) đứng sau động từ để biểu thị hành động đang diễn ra hoặc trạng thái do hành động tạo ra vẫn đang được duy trì (đang, vẫn giữ nguyên). Thường gặp trong câu miêu tả tư thế hoặc câu tồn hiện.",
    examples: [
      {
        chinese: "会议室的大门紧紧关着，里面正在进行重要谈判。",
        pinyin: "Huìyìshì de dàmén jǐnjǐn guān zhe, lǐmiàn zhèngzài jìnxíng zhòngyào tánpàn.",
        translation_vi: "Cánh cửa lớn của phòng họp đang đóng chặt, bên trong đang tiến hành đàm phán quan trọng.",
        explanation: "\"关着\" biểu thị trạng thái đóng cửa đang được duy trì."
      },
      {
        chinese: "老奶奶手里拿着一本厚厚的相册，微笑着回忆过去。",
        pinyin: "Lǎonǎinai shǒu lǐ ná zhe yì běn hòuhòu de xiàngcè, wēixiào zhe huíyì guòqù.",
        translation_vi: "Bà cụ trong tay đang cầm một cuốn album ảnh dày cộp, mỉm cười nhớ về quá khứ.",
        explanation: "\"拿着\" chỉ tư thế cầm sách và \"微笑着\" chỉ trạng thái mỉm cười."
      }
    ]
  },
  {
    order_index: 42,
    name: "Trợ từ động thái kinh nghiệm quá khứ \"过\"",
    pattern: "Chủ ngữ + Động từ + 过 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 过",
    category: "Trợ từ",
    explanation_vi: "\"过\" (guo) đứng ngay sau động từ để nhấn mạnh chủ thể đã từng có kinh nghiệm trải qua hành động đó trong quá khứ (đã từng, từng). Dạng phủ định là \"没 / 没有 + Động từ + 过\" (chưa từng).",
    examples: [
      {
        chinese: "我去年夏天曾经去过一次美丽的云南丽江古城。",
        pinyin: "Wǒ qùnián xiàtiān céngjīng qù guo yí cì měilì de Yúnnán Lìjiāng gǔchéng.",
        translation_vi: "Mùa hè năm ngoái tôi đã từng một lần đến phố cổ Lệ Giang tươi đẹp ở Vân Nam.",
        explanation: "\"去过\" khẳng định đã từng có trải nghiệm du lịch Lệ Giang."
      },
      {
        chinese: "他从来没有吃过这么地道正宗的四川麻婆豆腐。",
        pinyin: "Tā cónglái méiyǒu chī guo zhème dìdào zhèngzōng de Sìchuān mápó dòufu.",
        translation_vi: "Anh ấy từ trước tới nay chưa từng ăn món đậu phụ Ma Bà Tứ Xuyên chuẩn vị chính tông thế này.",
        explanation: "\"没有吃过\" phủ định chưa từng nếm qua món ăn."
      }
    ]
  },
  {
    order_index: 43,
    name: "Trợ từ ngữ khí biến đổi tình huống \"了\"",
    pattern: "Vị ngữ + 了",
    category: "Trợ từ",
    explanation_vi: "\"了\" (le) đặt ở cuối câu dùng làm trợ từ ngữ khí để biểu thị sự xuất hiện của một tình huống mới, sự thay đổi trạng thái hoặc nhận thức mới (rồi, đã chuyển biến). Khác với \"了\" trợ từ động thái đứng sau động từ.",
    examples: [
      {
        chinese: "春风吹绿了大地，天气逐渐变得温暖了。",
        pinyin: "Chūnfēng chuī lǜ le dàdì, tiānqì zhújiàn biàn de wēnnuǎn le.",
        translation_vi: "Gió xuân thổi xanh đất trời, thời tiết dần dần trở nên ấm áp rồi.",
        explanation: "\"温暖了\" biểu thị thời tiết đã có sự chuyển biến ấm lên."
      },
      {
        chinese: "已经下课了，请大家收拾好书包离开教室。",
        pinyin: "Yǐjīng xiàkè le, qǐng dàjiā shōushi hǎo shūbāo líkāi jiàoshì.",
        translation_vi: "Đã tan học rồi, mời mọi người dọn dẹp cặp sách rời khỏi lớp học.",
        explanation: "\"下课了\" thông báo tình huống mới là giờ học đã kết thúc."
      }
    ]
  },
  {
    order_index: 44,
    name: "Trợ từ ngữ khí thương lượng / gợi ý \"吧\"",
    pattern: "Câu đề xuất / Cầu khiến + 吧!",
    category: "Trợ từ",
    explanation_vi: "\"吧\" (ba) đặt ở cuối câu để biểu thị ngữ khí thương lượng, đề nghị, thỉnh cầu nhẹ nhàng hoặc đồng ý (nhé, đi, thôi). Giúp câu nói mềm mại và lịch sự hơn.",
    examples: [
      {
        chinese: "今天晚上的电影看起来很精彩，我们一起去看吧！",
        pinyin: "Jīntiān wǎnshang de diànyǐng kàn qǐlai hěn jīngcǎi, wǒmen yìqǐ qù kàn ba!",
        translation_vi: "Bộ phim tối nay xem chừng rất đặc sắc, chúng ta cùng nhau đi xem nhé!",
        explanation: "\"一起去看吧\" rủ rê đề xuất bạn bè đi xem phim."
      },
      {
        chinese: "时间不早了，大家快把桌子收拾干净准备休息吧。",
        pinyin: "Shíjiān bù zǎo le, dàjiā kuài bǎ zhuōzi shōushi gānjìng zhǔnbèi xiūxi ba.",
        translation_vi: "Thời gian không còn sớm nữa, mọi người mau dọn dẹp bàn ghế sạch sẽ chuẩn bị nghỉ ngơi thôi.",
        explanation: "\"准备休息吧\" là lời khuyên thúc giục nhẹ nhàng."
      }
    ]
  },
  {
    order_index: 45,
    name: "Trợ từ ngữ khí nhấn mạnh xác thực \"呢\"",
    pattern: "Chủ ngữ + Vị ngữ + 呢 / Phó từ + 呢",
    category: "Trợ từ",
    explanation_vi: "\"呢\" (ne) đặt ở cuối câu khẳng định để nhấn mạnh sự thật hiển nhiên hoặc cường điệu ngữ khí khẳng định (đấy, đấy chứ, cơ mà). Cũng kết hợp với 在/正 để chỉ hành động đang diễn ra.",
    examples: [
      {
        chinese: "你别小看这道物理题，难着呢，需要仔细思考。",
        pinyin: "Nǐ bié xiǎokàn zhè dào wùlǐ tí, nán zhe ne, xūyào zǐxì sīkǎo.",
        translation_vi: "Bạn chớ có xem thường bài toán vật lý này, khó lắm đấy chứ, cần phải suy nghĩ cẩn thận.",
        explanation: "\"难着呢\" nhấn mạnh mức độ khó của đề bài."
      },
      {
        chinese: "妈妈还在厨房里给大家熬香喷喷的鸡汤呢。",
        pinyin: "Māma hái zài chúfáng lǐ gěi dàjiā áo xiāngpēnpēn de jītāng ne.",
        translation_vi: "Mẹ vẫn đang ở trong bếp ninh nồi canh gà thơm nức mũi cho cả nhà cơ mà.",
        explanation: "\"还在...呢\" khẳng định hành động nấu nướng đang tiếp diễn."
      }
    ]
  },

  // --- NHÓM 9: ĐỘNG TỪ NĂNG NGUYỆN (能愿动词) ---
  {
    order_index: 46,
    name: "Động từ năng nguyện cho phép / năng lực \"可以\" (Có thể / Được phép)",
    pattern: "Chủ ngữ + 可以 + Động từ (+ Tân ngữ) / Phủ định: 不可以 / 不能",
    category: "Động từ năng nguyện",
    explanation_vi: "\"可以\" (kěyǐ) biểu thị sự cho phép (được phép làm gì), tính khả thi hoặc năng lực có thể làm được điều gì. Dạng phủ định thường dùng \"不可以\" hoặc \"不能\".",
    examples: [
      {
        chinese: "请问大家在图书馆的阅览室里可以借用电脑吗？",
        pinyin: "Qǐngwèn dàjiā zài túshūguǎn de yuèlǎnshì lǐ kěyǐ jièyòng diànnǎo ma?",
        translation_vi: "Xin hỏi mọi người ở phòng đọc của thư viện có thể mượn máy vi tính dùng được không?",
        explanation: "\"可以借用\" hỏi xin phép quy định trong phòng đọc."
      },
      {
        chinese: "你做完课后作业以后就可以看半个小时动画片。",
        pinyin: "Nǐ zuò wán kèhòu zuòyè yǐhòu jiù kěyǐ kàn bàn gè xiǎoshí dònghuàpiàn.",
        translation_vi: "Con làm xong bài tập về nhà xong là có thể xem phim hoạt hình nửa tiếng.",
        explanation: "\"就可以看\" biểu thị sự cho phép sau khi làm xong điều kiện."
      }
    ]
  },
  {
    order_index: 47,
    name: "Động từ năng nguyện bổn phận / khuyên răn \"应该\" (Nên / Cần phải)",
    pattern: "Chủ ngữ + 应该 + Động từ (+ Tân ngữ) / Phủ định: 不应该",
    category: "Động từ năng nguyện",
    explanation_vi: "\"应该\" (yīnggāi) biểu thị về mặt đạo lý, nghĩa vụ, phép lịch sự hoặc logic thì cần thiết phải làm một việc gì đó (nên, cần phải). Phủ định là \"不应该\" (không nên).",
    examples: [
      {
        chinese: "过马路的时候我们应该先看红绿灯，注意交通安全。",
        pinyin: "Guò mǎlù de shíhou wǒmen yīnggāi xiān kàn hónglǜdēng, zhùyì jiāotōng ānquán.",
        translation_vi: "Khi qua đường chúng ta nên nhìn đèn tín hiệu giao thông trước, chú ý an toàn giao thông.",
        explanation: "\"应该先看\" khuyên bảo hành vi an toàn bắt buộc khi qua đường."
      },
      {
        chinese: "朋友遇到困难时，我们应该主动伸出援助之手。",
        pinyin: "Péngyou yù dào kùnnán shí, wǒmen yīnggāi zhǔdòng shēn chū yuánzhù zhī shǒu.",
        translation_vi: "Khi bạn bè gặp khó khăn, chúng ta nên chủ động chìa bàn tay giúp đỡ.",
        explanation: "\"应该主动\" nhấn mạnh bổn phận đạo đức đối với bạn bè."
      }
    ]
  },
  {
    order_index: 48,
    name: "Động từ năng nguyện nguyện vọng \"想\" (Muốn / Nghĩ / Nhớ)",
    pattern: "Chủ ngữ + 想 + Động từ (+ Tân ngữ) / Phủ định: 不想",
    category: "Động từ năng nguyện",
    explanation_vi: "\"想\" (xiǎng) đứng trước động từ biểu thị ý muốn, dự định chủ quan hoặc nguyện vọng trong lòng (muốn làm gì). Không mang tính quyết liệt và bắt buộc cao như \"要\".",
    examples: [
      {
        chinese: "今年寒假我想和家人一起去温暖的三亚海边度假。",
        pinyin: "Jīnnián hánjià wǒ xiǎng hé jiārén yìqǐ qù wēnnuǎn de Sānyà hǎibiān dùjià.",
        translation_vi: "Kỳ nghỉ đông năm nay tôi muốn cùng người nhà đến bãi biển Tam Á ấm áp để nghỉ mát.",
        explanation: "\"我想...去\" biểu đạt mong muốn kế hoạch nghỉ đông."
      },
      {
        chinese: "他今天身体有点不舒服，不想参加晚上的聚会。",
        pinyin: "Tā jīntiān shēntǐ yǒudiǎn bù shūfu, bù xiǎng cānjiā wǎnshang de jùhuì.",
        translation_vi: "Hôm nay người anh ấy hơi không khỏe, không muốn tham gia buổi tụ tập tối nay.",
        explanation: "\"不想参加\" phủ định ý muốn tham gia."
      }
    ]
  },
  {
    order_index: 49,
    name: "Động từ năng nguyện quyết tâm & tương lai gần \"要\" (Muốn / Sẽ / Phải)",
    pattern: "Chủ ngữ + 要 + Động từ (+ Tân ngữ) / Phủ định: 不想 / 不用",
    category: "Động từ năng nguyện",
    explanation_vi: "\"要\" (yào) biểu thị quyết tâm mong muốn mạnh mẽ làm điều gì đó (muốn), hoặc biểu thị một hành động sắp xảy ra trong tương lai gần (sẽ). Phủ định ý muốn dùng \"不想\", phủ định nghĩa vụ dùng \"不用\".",
    examples: [
      {
        chinese: "明天早晨八点我们要举行新学期的开学典礼。",
        pinyin: "Míngtiān zǎochén bā diǎn wǒmen yào jǔxíng xīn xuéqī de kāixué diǎnlǐ.",
        translation_vi: "Tám giờ sáng mai chúng tôi sẽ tổ chức lễ khai giảng của học kỳ mới.",
        explanation: "\"我们要举行\" biểu thị sự việc sắp diễn ra vào sáng mai."
      },
      {
        chinese: "为了学好汉语，他下定决心每天都要背三十个生词。",
        pinyin: "Wèile xué hǎo hànyǔ, tā xiàdìng juéxīn měitiān dōu yào bèi sānshí gè shēngcí.",
        translation_vi: "Để học giỏi tiếng Hán, anh ấy hạ quyết tâm mỗi ngày đều phải học thuộc ba mươi từ mới.",
        explanation: "\"都要背\" biểu thị ý chí quyết tâm bắt buộc bản thân làm."
      }
    ]
  },
  {
    order_index: 50,
    name: "Động từ năng nguyện kỹ năng học được \"会\" (Biết / Sẽ)",
    pattern: "Chủ ngữ + 会 + Động từ (+ Tân ngữ) / Phủ định: 不会",
    category: "Động từ năng nguyện",
    explanation_vi: "\"会\" (huì) biểu thị một kỹ năng hoặc năng lực nào đó đạt được thông qua quá trình học tập, rèn luyện (biết bơi, biết tiếng Trung), hoặc biểu thị khả năng sự việc sẽ xảy ra trong tương lai (sẽ).",
    examples: [
      {
        chinese: "他在中国生活了三年，现在不仅会说普通话，还会包饺子。",
        pinyin: "Tā zài zhōngguó shēnghuó le sān nián, xiànzài bùjǐn huì shuō pǔtōnghuà, hái huì bāo jiǎozi.",
        translation_vi: "Anh ấy đã sống ở Trung Quốc ba năm, bây giờ không chỉ biết nói tiếng phổ thông mà còn biết gói sủi cảo.",
        explanation: "\"会说\" và \"会包\" chỉ các kỹ năng đạt được qua học tập thực tế."
      },
      {
        chinese: "别担心，医生说你的病只要好好吃药就一定会好的。",
        pinyin: "Bié dānxīn, yīshēng shuō nǐ de bìng zhǐyào hǎohǎo chīyào jiù yídìng huì hǎo de.",
        translation_vi: "Đừng lo lắng, bác sĩ nói bệnh của bạn chỉ cần uống thuốc đầy đủ thì nhất định sẽ khỏi thôi.",
        explanation: "\"一定会好\" biểu thị khả năng chắc chắn sẽ xảy ra trong tương lai."
      }
    ]
  },

  // --- NHÓM 10: BỔ NGỮ KẾT QUẢ SƠ CẤP (初级结果补语) ---
  {
    order_index: 51,
    name: "Bổ ngữ kết quả hoàn thiện đạt chuẩn \"好\"",
    pattern: "Động từ + 好 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 好",
    category: "Bổ ngữ",
    explanation_vi: "\"好\" (hǎo) làm bổ ngữ kết quả đứng sau động từ để biểu thị hành động đã hoàn thành đạt tới mức độ hoàn thiện, hoàn hảo, khiến người ta hài lòng hoặc sẵn sàng cho bước tiếp theo (xong xuôi, tốt đẹp).",
    examples: [
      {
        chinese: "我已经准备好明天的求职面试发言稿了。",
        pinyin: "Wǒ yǐjīng zhǔnbèi hǎo míngtiān de qiúzhí miànshì fāyángǎo le.",
        translation_vi: "Tôi đã chuẩn bị xong xuôi bài phát biểu phỏng vấn xin việc ngày mai rồi.",
        explanation: "\"准备好\" biểu thị sự việc chuẩn bị đã tươm tất hoàn tất."
      },
      {
        chinese: "晚饭妈妈已经做好了，大家快洗手去餐厅吃饭吧。",
        pinyin: "Wǎnfàn māma yǐjīng zuò hǎo le, dàjiā kuài xǐshǒu qù cāntīng chīfàn ba.",
        translation_vi: "Cơm tối mẹ đã nấu xong rồi, mọi người mau rửa tay vào phòng ăn ăn cơm thôi.",
        explanation: "\"做好了\" chỉ bữa cơm nấu xong thơm ngon sẵn sàng."
      }
    ]
  },
  {
    order_index: 52,
    name: "Bổ ngữ kết quả kết thúc toàn bộ \"完\"",
    pattern: "Động từ + 完 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 完",
    category: "Bổ ngữ",
    explanation_vi: "\"完\" (wán) làm bổ ngữ kết quả biểu thị hành động hoặc đối tượng của hành động đã kết thúc trọn vẹn, không còn gì sót lại (hết, xong). Dạng phủ định là \"没 / 没有 + Động từ + 完\" (chưa xong).",
    examples: [
      {
        chinese: "同学们只用了一个小时就看完了整本故事书。",
        pinyin: "Tóngxué men zhǐ yòng le yí gè xiǎoshí jiù kàn wán le zhěng běn gùshì shū.",
        translation_vi: "Các bạn học sinh chỉ dùng một giờ đồng hồ là đã đọc xong hết cả cuốn sách truyện.",
        explanation: "\"看完了\" biểu thị đọc hết toàn bộ cuốn sách không bỏ sót trang nào."
      },
      {
        chinese: "这道难题我还没有做完，请老师再给我五分钟时间。",
        pinyin: "Zhè dào nántí wǒ hái méiyǒu zuò wán, qǐng lǎoshī zài gěi wǒ wǔ fēnzhōng shíjiān.",
        translation_vi: "Bài toán khó này em vẫn chưa làm xong, xin thầy cho em thêm năm phút nữa ạ.",
        explanation: "\"没有做完\" phủ định hành động làm toán chưa kết thúc."
      }
    ]
  }
];
