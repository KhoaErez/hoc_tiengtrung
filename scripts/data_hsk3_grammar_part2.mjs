export const HSK3_GRAMMAR_PART2 = [
  // --- NHÓM 5: PHÓ TỪ NGỮ KHÍ & TÌNH THÁI (语气与情态副词) ---
  {
    order_index: 27,
    name: "Phó từ ngữ khí phản vấn gay gắt \"难道\" (Chẳng lẽ / Lẽ nào)",
    pattern: "难道 + Phân câu hỏi (+ 吗 / 不成)?",
    category: "Phó từ",
    explanation_vi: "\"难道\" (nándào) đặt trước câu hỏi phản vấn để tăng cường ngữ khí ngạc nhiên, trách móc hoặc khẳng định dứt khoát một sự việc hiển nhiên (chẳng lẽ, lẽ nào... lại như thế). Thường kết hợp với \"吗\" ở cuối câu.",
    examples: [
      {
        chinese: "明天的开学典礼这么重要，难道你真打算无故请假不去吗？",
        pinyin: "Míngtiān de kāixué diǎnlǐ zhème zhòngyào, nándào nǐ zhēn dǎsuàn wúgù qǐngjià bú qù ma?",
        translation_vi: "Lễ khai giảng ngày mai quan trọng như thế, chẳng lẽ bạn thực sự dự tính xin nghỉ không lý do để không đi sao?",
        explanation: "\"难道...吗\" tăng cường ngữ khí chất vấn sự vô lý của việc xin nghỉ."
      },
      {
        chinese: "这道题目老师上周刚讲过两次，难道你们大家都忘得一干二净了吗？",
        pinyin: "Zhè dào tímù lǎoshī shàng zhōu gāng jiǎng guo liǎng cì, nándào nǐmen dàjiā dōu wàng de yìgān-èrjìng le ma?",
        translation_vi: "Bài toán này tuần trước thầy vừa giảng hai lần rồi, lẽ nào các em đều quên sạch sành sanh hết rồi sao?",
        explanation: "\"难道...忘了吗\" thể hiện sự kinh ngạc trước việc học sinh quên bài."
      }
    ]
  },
  {
    order_index: 28,
    name: "Phó từ tình thái thuận tiện \"顺便\" (Nhân tiện / Tiện thể)",
    pattern: "顺便 + Động từ (+ Tân ngữ)",
    category: "Phó từ",
    explanation_vi: "\"顺便\" (shùnbiàn) làm trạng ngữ đứng trước động từ để biểu thị hành động được thực hiện nhân tiện, tiện thể trong lúc đang làm một việc chính khác mà không tốn thêm nhiều công sức (tiện thể, nhân tiện).",
    examples: [
      {
        chinese: "你下楼去超市买水果的时候，顺便帮我取一下放在门卫室的快递包裹吧。",
        pinyin: "Nǐ xià lóu qù chāoshì mǎi shuǐguǒ de shíhou, shùnbiàn bāng wǒ qǔ yíxià fàng zài ménwèishì de kuàidì bāoguǒ ba.",
        translation_vi: "Lúc bạn xuống tầng đi siêu thị mua hoa quả, tiện thể giúp tôi lấy gói bưu phẩm chuyển phát nhanh để ở phòng bảo vệ nhé.",
        explanation: "\"顺便帮我取\" thực hiện việc lấy bưu phẩm nhân tiện chuyến đi siêu thị."
      },
      {
        chinese: "今天下午去图书馆查阅文献资料，顺便借了两本古典文学名著回来。",
        pinyin: "Jīntiān xiàwǔ qù túshūguǎn cháyuè wénxiàn zīliào, shùnbiàn jiè le liǎng běn gǔdiǎn wénxué míngzhù huílai.",
        translation_vi: "Chiều nay đến thư viện tra cứu tài liệu văn kiện, tiện thể tôi đã mượn hai cuốn danh tác văn học cổ điển về.",
        explanation: "\"顺便借\" mượn sách tiện thể trong lúc đi tra cứu."
      }
    ]
  },
  {
    order_index: 29,
    name: "Phó từ may mắn thoát nạn \"幸亏 / 幸好\" (May mà / May thay)",
    pattern: "幸亏 / 幸好 + Tình huống may mắn, 不然 / 要不然 + Hậu quả xấu",
    category: "Phó từ",
    explanation_vi: "\"幸亏\" (xìngkuī) hoặc \"幸好\" (xìnghǎo) đứng đầu câu hoặc đầu phân câu để biểu thị nhờ có điều kiện thuận lợi ngẫu nhiên mà tránh được tai họa, rắc rối hoặc hậu quả tồi tệ (may mà, may thay). Thường phối hợp với \"不然 / 要不然\" (nếu không thì).",
    examples: [
      {
        chinese: "幸亏出门前母亲提醒我随身带了雨伞，不然刚才就被倾盆暴雨淋湿了。",
        pinyin: "Xìngkuī chūmén qián mǔqīn tíxǐng wǒ suíshēn dài le yǔsǎn, bùrán gāngcái jiù bèi qīngpén bàoyǔ línshī le.",
        translation_vi: "May mà trước khi ra khỏi cửa mẹ nhắc tôi mang theo ô bên mình, nếu không thì ban nãy đã bị cơn mưa rào như trút làm ướt sũng rồi.",
        explanation: "\"幸亏...不然...\" nhấn mạnh sự may mắn nhờ mang ô tránh bị ướt mưa."
      },
      {
        chinese: "幸好交警及时赶到事故现场疏导车流，拥堵的交通才没有彻底瘫痪。",
        pinyin: "Xìnghǎo jiāojǐng jíshí gǎndào shìgù xiànchǎng shūdǎo chēliú, yōngdǔ de jiāotōng cái méiyǒu chèdǐ tānhuān.",
        translation_vi: "May thay cảnh sát giao thông kịp thời tới hiện trường vụ tai nạn phân luồng xe, giao thông ùn tắc mới không bị tê liệt hoàn toàn.",
        explanation: "\"幸好...才没有\" nhờ cảnh sát tới kịp mà tránh được tê liệt giao thông."
      }
    ]
  },
  {
    order_index: 30,
    name: "Phó từ ngộ ra chân tướng sự thật \"原来\" (Hóa ra / Thì ra)",
    pattern: "原来 + Sự thật mới phát hiện / (Vốn dĩ ban đầu)",
    category: "Phó từ",
    explanation_vi: "\"原来\" (yuánlái) đứng đầu câu hoặc trước vị ngữ biểu thị sự ngộ ra, vỡ lẽ về một chân tướng sự thật sau khi tìm hiểu (hóa ra, thì ra là thế). Ngoài ra, \"原来\" còn làm danh từ/tính từ chỉ tình trạng vốn có ban đầu.",
    examples: [
      {
        chinese: "我说今天早晨外面怎么这么安静，原来昨夜下了一场厚厚的瑞雪。",
        pinyin: "Wǒ shuō jīntiān zǎochén wàimiàn zěnme zhème ānjìng, yuánlái zuóyè xià le yì chǎng hòuhòu de ruìxuě.",
        translation_vi: "Tôi cứ bảo sao sáng nay bên ngoài lại yên tĩnh thế này, hóa ra đêm qua trời đã đổ một trận tuyết lành dày xốp.",
        explanation: "\"原来昨夜下了一场...\" giải thích rõ nguyên nhân bất ngờ vỡ lẽ."
      },
      {
        chinese: "他原来是一名优秀的中学语文教师，后来通过努力考上了研究生。",
        pinyin: "Tā yuánlái shì yì míng yōuxiù de zhōngxué yǔwén jiàoshī, hòulái tōngguò nǔlì kǎo shàng le yánjiūshēng.",
        translation_vi: "Anh ấy ban đầu vốn là một giáo viên ngữ văn cấp hai ưu tú, sau này nhờ nỗ lực đã thi đỗ nghiên cứu sinh.",
        explanation: "\"原来是\" chỉ thân phận ban đầu trước đây."
      }
    ]
  },
  {
    order_index: 31,
    name: "Phó từ cường điệu mức độ như thật \"简直\" (Quả là / Thật là)",
    pattern: "简直 (+ 像 / 是 / 比) + Tính từ / Cụm vị ngữ",
    category: "Phó từ",
    explanation_vi: "\"简直\" (jiǎnzhí) dùng để cường điệu hóa mức độ của sự việc, biểu thị tình huống đạt tới trạng thái gần như không thể tin nổi hoặc hoàn toàn tương đương với một sự việc khác (quả là, thật là, hoàn toàn như).",
    examples: [
      {
        chinese: "他在全国青少年魔术大赛上的精彩绝伦表演，简直令人难以置信！",
        pinyin: "Tā zài quánguó qīng-shàonián móshù dàsài shang de jīngcǎi-juélún biǎoyǎn, jiǎnzhí lìngrén nányǐ-zhìxìn!",
        translation_vi: "Màn biểu diễn tuyệt luân đặc sắc của anh ấy trong cuộc thi ảo thuật thanh thiếu niên toàn quốc quả là khiến người ta khó lòng tin nổi!",
        explanation: "\"简直令人难以置信\" cường điệu hóa sự thán phục tột bực."
      },
      {
        chinese: "清晨漫步在桂林秀丽的漓江两岸，周围美丽的风景简直像一幅生动的山水画。",
        pinyin: "Qīngchén mànbù zài Guìlín xiùlì de Líjiāng liǎng'àn, zhōuwéi měilì de fēngjǐng jiǎnzhí xiàng yì fú shēngdòng de shānshuǐhuà.",
        translation_vi: "Sáng sớm tản bộ trên hai bờ sông Ly tươi đẹp ở Quế Lâm, phong cảnh mỹ lệ xung quanh quả thật như một bức tranh sơn thủy sống động.",
        explanation: "\"简直像\" so sánh cường điệu vẻ đẹp tự nhiên giống như tranh vẽ."
      }
    ]
  },
  {
    order_index: 32,
    name: "Phó từ duy trì liên tục không ngắt quãng \"一直\" (Suốt / Luôn / Liên tục)",
    pattern: "一直 + Động từ / Tính từ / Thời gian + 一直 (+ 都)...",
    category: "Phó từ",
    explanation_vi: "\"一直\" (yìzhí) biểu thị một hành động hoặc trạng thái duy trì liên tục không gián đoạn từ quá khứ đến hiện tại hoặc trong suốt một khoảng thời gian (suốt, luôn luôn, liên tục). Cũng dùng chỉ phương hướng đi thẳng một mạch (一直走).",
    examples: [
      {
        chinese: "从大学一年级开始，他就一直坚持每天清晨早起朗读中外名篇散文。",
        pinyin: "Cóng dàxué yī niánjí kāishǐ, tā jiù yìzhí jiānchí měitiān qīngchén zǎoqǐ lǎngdú zhōng-wài míngpiān sǎnwén.",
        translation_vi: "Bắt đầu từ năm thứ nhất đại học, anh ấy đã luôn kiên trì mỗi sáng sớm dậy sớm đọc vang các áng văn tản văn danh tiếng trong và ngoài nước.",
        explanation: "\"一直坚持\" biểu thị thói quen duy trì liên tục không bỏ ngày nào."
      },
      {
        chinese: "从这个十字路口一直往东走两百米，就能看到高耸的世纪电视塔。",
        pinyin: "Cóng zhè gè shízì-lùkǒu yìzhí wǎng dōng zǒu liǎng bǎi mǐ, jiù néng kàn dào gāosǒng de shìjì diànshìtǎ.",
        translation_vi: "Từ ngã tư này đi thẳng một mạch về phía Đông hai trăm mét là có thể nhìn thấy tháp truyền hình thế kỷ cao vút.",
        explanation: "\"一直往东走\" chỉ hướng đi thẳng một mạch không rẽ."
      }
    ]
  },

  // --- NHÓM 6: LIÊN TỪ PHỨC HỢP TRUNG CẤP (中级复句连词) ---
  {
    order_index: 33,
    name: "Liên từ tăng tiến đồng đẳng \"不仅...而且...\" (Không những... mà còn...)",
    pattern: "Chủ ngữ + 不仅 + Vị ngữ 1, 而且 + Vị ngữ 2 / 不仅 + Chủ ngữ 1..., 而且 + Chủ ngữ 2...",
    category: "Liên từ",
    explanation_vi: "Cặp liên từ \"不仅...而且...\" (bùjǐn... érqiě...) biểu thị mối quan hệ tăng tiến thêm một bậc về phạm vi hoặc mức độ (không những... mà còn...). Nếu cùng chung chủ ngữ thì chủ ngữ đứng trước 不仅; nếu khác chủ ngữ thì 不仅 đứng trước chủ ngữ 1.",
    examples: [
      {
        chinese: "这家社区老字号餐馆不仅饭菜可口美味，而且价格十分公道实惠。",
        pinyin: "Zhè jiā shèqū lǎozìhào cānguǎn bùjǐn fàncài kěkǒu měiwèi, érqiě jiàgé shífēn gōngdao shíhuì.",
        translation_vi: "Quán ăn lâu năm trong khu dân cư này không những cơm canh thơm ngon vừa miệng, mà giá cả còn rất hợp lý bình dân.",
        explanation: "\"不仅...而且...\" liên kết hai ưu điểm tăng tiến cùng chủ ngữ quán ăn."
      },
      {
        chinese: "学习汉语不仅能开阔我们的文化视野，而且能为未来的职业发展提供广阔舞台。",
        pinyin: "Xuéxí hànyǔ bùjǐn néng kāikuò wǒmen de wénhuà shìyě, érqiě néng wèi wèilái de zhíyè fāzhǎn tígōng guǎngkuò wǔtái.",
        translation_vi: "Học tiếng Hán không những có thể mở rộng tầm nhìn văn hóa của chúng ta, mà còn có thể mang lại vũ đài rộng lớn cho sự phát triển nghề nghiệp tương lai.",
        explanation: "Tăng tiến hai tầng lợi ích thiết thực của việc học Hán ngữ."
      }
    ]
  },
  {
    order_index: 34,
    name: "Liên từ tăng tiến khẩu ngữ \"不但...还 / 也...\" (Không chỉ... mà còn...)",
    pattern: "不但 + Phân câu 1, 还 / 也 / 并且 + Phân câu 2",
    category: "Liên từ",
    explanation_vi: "\"不但...还 / 也...\" (búdàn... hái/yě...) là biến thể khẩu ngữ quen thuộc của \"不仅...而且...\" dùng biểu thị mức độ tăng tiến bổ sung (không chỉ... mà còn...). Phân câu sau bổ sung thêm một hành động hoặc đặc điểm vượt trội hơn.",
    examples: [
      {
        chinese: "他不但能熟练使用普通话日常交流，还会唱很多首经典的民间民歌。",
        pinyin: "Tā búdàn néng shúliàn shǐyòng pǔtōnghuà rìcháng jiāoliú, hái huì chàng hěn duō shǒu jīngdiǎn de mínjiān míngē.",
        translation_vi: "Anh ấy không chỉ có thể giao tiếp hằng ngày thuần thục bằng tiếng phổ thông, mà còn biết hát rất nhiều bài dân ca dân gian kinh điển.",
        explanation: "\"不但...还会\" bổ sung khả năng hát dân ca bên cạnh kỹ năng nói tiếng Trung."
      },
      {
        chinese: "这次大扫除不仅把教室打扫得干干净净，还把走廊两侧的玻璃擦得透亮。",
        pinyin: "Zhè cì dàsǎochú bùjǐn bǎ jiàoshì dǎsǎo de gāngān-jìngjìng, hái bǎ zǒuláng liǎngcè de bōli cā de tòuliàng.",
        translation_vi: "Đợt tổng vệ sinh này không chỉ quét dọn lớp học sạch bóng tinh tươm, mà còn lau kính hai bên hành lang sáng loáng.",
        explanation: "\"不但...还...\" mở rộng phạm vi công việc đã hoàn thành."
      }
    ]
  },
  {
    order_index: 35,
    name: "Liên từ điều kiện duy nhất \"只有...才...\" (Chỉ có... mới...)",
    pattern: "只有 + Điều kiện duy nhất bắt buộc, 才 + Kết quả đạt được",
    category: "Liên từ",
    explanation_vi: "Cặp liên từ \"只有...才...\" (zhǐyǒu... cái...) biểu thị điều kiện duy nhất và bắt buộc: chỉ có đáp ứng duy nhất điều kiện này thì kết quả mong đợi mới có thể xuất hiện (chỉ có... mới có thể...). Khác với \"只要...就...\" (điều kiện cần - chỉ cần là được).",
    examples: [
      {
        chinese: "只有持之以恒地脚踏实地努力拼搏，才能在学术研究领域取得突破成就。",
        pinyin: "Zhǐyǒu chízhi-yǐhéng de jiǎotà-shídì nǔlì pīnbó, cáinéng zài xuéshù yánjiū lǐngyù qùdé tūpò chéngjiù.",
        translation_vi: "Chỉ có kiên trì không ngơi nghỉ vững vàng nỗ lực phấn đấu thì mới có thể gặt hái thành tựu đột phá trong lĩnh vực nghiên cứu học thuật.",
        explanation: "\"只有...才能...\" nhấn mạnh sự kiên trì là con đường duy nhất dẫn tới đột phá."
      },
      {
        chinese: "只有经过严格的专业体检与理论考核，合格者才能获得民航飞行员执照。",
        pinyin: "Zhǐyǒu jīngguò yángé de zhuānyè tǐjiǎn yǔ lǐlùn kǎohé, hégézhě cáinéng huòdé mínháng fēixíngyuán zhízhào.",
        translation_vi: "Chỉ có trải qua khám sức khỏe chuyên môn và khảo hạch lý thuyết nghiêm ngặt, người đạt chuẩn mới có thể nhận bằng phi công hàng không dân dụng.",
        explanation: "Nêu điều kiện tiên quyết duy nhất để được cấp bằng bay."
      }
    ]
  },
  {
    order_index: 36,
    name: "Liên từ giả thiết suy luận \"既然...就...\" (Đã... thì...)",
    pattern: "既然 + Tiền đề / Sự thật đã xảy ra, (那么) 就 + Kết luận / Lời khuyên",
    category: "Liên từ",
    explanation_vi: "Cặp liên từ \"既然...就...\" (jìrán... jiù...) dùng để đưa ra kết luận hoặc kiến nghị hợp logic dựa trên một sự thật hiển nhiên hoặc một tiền đề đã định đoạt từ trước (đã như vậy rồi... thì hãy...).",
    examples: [
      {
        chinese: "既然大家都已经一致同意了这个合作方案，那么我们就立刻着手组织实施吧。",
        pinyin: "Jìrán dàjiā dōu yǐjīng yízhì tóngyì le zhè gè hézuò fāng'àn, nàme wǒmen jiù lìkè zhuóshǒu zǔzhī shíshī ba.",
        translation_vi: "Đã mọi người đều đã nhất trí thông qua phương án hợp tác này rồi, thế thì chúng ta hãy lập tức bắt tay vào tổ chức triển khai thôi.",
        explanation: "\"既然...就...\" đưa ra hành động triển khai dựa trên sự đồng thuận đã có."
      },
      {
        chinese: "既然你今天身体有些发烧不适，就留在宿舍好好卧床休息，不要去自习了。",
        pinyin: "Jìrán nǐ jīntiān shēntǐ yǒuxiē fāshāo bùshì, jiù liú zài sùshè hǎohǎo wòchuáng xiūxi, bú yào qù zìxí le.",
        translation_vi: "Đã hôm nay người bạn hơi phát sốt khó chịu rồi thì hãy ở lại ký túc xá tĩnh dưỡng nghỉ ngơi trên giường, đừng đi tự học nữa.",
        explanation: "Đưa ra lời khuyên nghỉ ngơi dựa trên tình hình sức khỏe thực tế."
      }
    ]
  },
  {
    order_index: 37,
    name: "Liên từ nhượng bộ giả thiết \"即使...也...\" (Cho dù... cũng...)",
    pattern: "即使 + Giả thiết cực đoan / Khó khăn, 主语 + 也 + Kết quả không đổi",
    category: "Liên từ",
    explanation_vi: "Cặp liên từ \"即使...也...\" (jíshǐ... yě...) biểu thị mối quan hệ nhượng bộ giả thiết: thừa nhận một tình huống giả định khó khăn hoặc cực đoan nhất, nhưng kết quả hoặc thái độ ở phân câu sau vẫn kiên định không hề lay chuyển (cho dù... cũng vẫn...).",
    examples: [
      {
        chinese: "即使在前进的道路上遇到再大的风雨坎坷，我们也不会轻易放弃最初的理想。",
        pinyin: "Jíshǐ zài qiánjìn de dàolù shang yù dào zài dà de fēngyǔ kǎnkě, wǒmen yě bú huì qīngyì fàngqì zuìchū de lǐxiǎng.",
        translation_vi: "Cho dù trên con đường phía trước gặp phải mưa gió gập ghềnh to lớn đến mấy, chúng tôi cũng sẽ không dễ dàng từ bỏ lý tưởng ban đầu.",
        explanation: "\"即使...也...\" nhấn mạnh sự kiên định lý tưởng trước mọi thử thách khắc nghiệt."
      },
      {
        chinese: "明天即使户外下暴雪气温降到零下十度，长跑队员们也会按时参加常规体能集训。",
        pinyin: "Míngtiān jíshǐ hùwài xià bàoxuě qìwēn jiàng dào língxià shí dù, chángpǎo duìyuán men yě huì ànshí cānjiā chángguī tǐnéng jíxùn.",
        translation_vi: "Ngày mai cho dù ngoài trời đổ bão tuyết nhiệt độ hạ xuống âm mười độ, các vận động viên chạy dài cũng sẽ tham gia tập huấn thể lực định kỳ đúng giờ.",
        explanation: "Khẳng định ý chí tập luyện bất chấp thời tiết bão tuyết giả định."
      }
    ]
  },
  {
    order_index: 38,
    name: "Liên từ song song hai mặt \"一方面...另一方面...\" (Một mặt... mặt khác...)",
    pattern: "一方面 + Khía cạnh 1, 另一方面 + Khía cạnh 2",
    category: "Liên từ",
    explanation_vi: "Cấu trúc \"一方面...另一方面...\" (yì fāngmiàn... lìng yì fāngmiàn...) dùng để trình bày, phân tích hai mặt hoặc hai khía cạnh tương đương cùng tồn tại song song trong một vấn đề (một mặt... mặt khác...). Giúp lập luận cân đối và toàn diện.",
    examples: [
      {
        chinese: "发展数字经济一方面能大幅提高生产效率，另一方面也能催生出海量全新的高薪就业岗位。",
        pinyin: "Fāzhǎn shùzì jīngjì yì fāngmiàn néng dàfú tígāo shēngchǎn xiàolǜ, lìng yì fāngmiàn yě néng cuīshēng chū hǎiliàng quánxīn de gāoxīn jiùyè gǎngwèi.",
        translation_vi: "Phát triển kinh tế số một mặt có thể nâng cao vượt bậc hiệu suất sản xuất, mặt khác cũng có thể sản sinh ra khối lượng lớn các vị trí việc làm lương cao mới toanh.",
        explanation: "\"一方面...另一方面...\" phân tích hai lợi ích song hành của kinh tế số."
      },
      {
        chinese: "大学生活一方面要认真钻研专业理论知识，另一方面也要积极参与社会公益实践活动。",
        pinyin: "Dàxué shēnghuó yì fāngmiàn yào rènzhēn zuānyán zhuānyè lǐlùn zhīshi, lìng yì fāngmiàn yě yào jījí cānyù shèhuì gōngyì shíjiàn huódòng.",
        translation_vi: "Đời sống đại học một mặt phải chăm chỉ đào sâu tri thức lý luận chuyên ngành, mặt khác cũng cần tích cực tham gia các hoạt động thực hành công ích xã hội.",
        explanation: "Cân bằng giữa việc học lý thuyết và hoạt động thực tế."
      }
    ]
  },
  {
    order_index: 39,
    name: "Liên từ chuyển tiếp cực đoan \"甚至\" (Thậm chí / Ngay cả)",
    pattern: "A, B, 甚至 (连) + C + 都 / 也 + Vị ngữ",
    category: "Liên từ",
    explanation_vi: "\"甚至\" (shènzhì) dùng để đưa ra một ví dụ nổi bật, bất ngờ hoặc có tính chất cực đoan nhất nhằm nhấn mạnh mức độ sâu sắc vượt xa dự liệu thông thường (thậm chí, ngay cả... cũng).",
    examples: [
      {
        chinese: "这道物理科研难题极其复杂，很多资深教授甚至世界级科学家都感到十分棘手。",
        pinyin: "Zhè dào wùlǐ kēyán nántí jíqí fùzá, hěn duō zīshēn jiàoshòu shènzhì shìjièjí kēxuéjiā dōu gǎndào shífēn jíshǒu.",
        translation_vi: "Bài toán nghiên cứu vật lý này phức tạp tột cùng, rất nhiều giáo sư kỳ cựu thậm chí cả các nhà khoa học đẳng cấp thế giới cũng đều cảm thấy vô cùng hóc búa.",
        explanation: "\"甚至世界级科学家\" đưa ra đối tượng đỉnh cao để làm nổi bật độ khó."
      },
      {
        chinese: "他沉迷于实验室的核心技术攻坚，连续几个月甚至连周末都泡在仪器前。",
        pinyin: "Tā chénmí yú shíyànshì de héxīn jìshù gōngjiān, liánxù jǐ gè yuè shènzhì lián zhōumò dōu pào zài yíqì qián.",
        translation_vi: "Anh ấy say mê công phá công nghệ cốt lõi trong phòng thí nghiệm, liên tục mấy tháng trời thậm chí ngay cả cuối tuần cũng cắm mặt bên thiết bị.",
        explanation: "\"甚至连周末都\" nhấn mạnh tinh thần nghiên cứu quên cả ngày nghỉ."
      }
    ]
  },
  {
    order_index: 40,
    name: "Liên từ chuyển tiếp bổ sung \"另外\" (Ngoài ra / Hơn nữa)",
    pattern: "Phân câu 1. 另外, + Phân câu 2 / 另外 (+ 的) + Danh từ",
    category: "Liên từ",
    explanation_vi: "\"另外\" (lìngwài) dùng làm liên từ đứng đầu câu hoặc phân câu để bổ sung thêm một ý, một thông tin hoặc một công việc khác bên cạnh điều đã nêu (ngoài ra, hơn nữa). Cũng làm đại từ/định ngữ (cái khác, người khác: 另外两个人).",
    examples: [
      {
        chinese: "会议期间请大家务必保持手机静音，另外，会场内严禁随意吸烟与喧哗。",
        pinyin: "Huìyì qījiān qǐng dàjiā wùbì bǎochí shǒujī jìngyīn, lìngwài, huìchǎng nèi yánjìn suíyì xīyān yǔ xuānhuá.",
        translation_vi: "Trong thời gian hội nghị xin mọi người nhất định giữ điện thoại ở chế độ im lặng, ngoài ra, trong hội trường nghiêm cấm tùy tiện hút thuốc và làm ồn.",
        explanation: "\"另外\" bổ sung thêm quy định cấm hút thuốc."
      },
      {
        chinese: "今天上午我已经面试了五位求职者，另外三位候选人安排在今天下午两点。",
        pinyin: "Jīntiān shàngwǔ wǒ yǐjīng miànshì le wǔ wèi qiúzhízhě, lìngwài sān wèi hòuxuǎnrén ānpái zài jīntiān xiàwǔ liǎng diǎn.",
        translation_vi: "Sáng nay tôi đã phỏng vấn năm ứng viên xin việc, ba ứng viên còn lại được sắp xếp vào lúc hai giờ chiều nay.",
        explanation: "\"另外三位\" làm định ngữ chỉ 3 người ứng viên còn lại."
      }
    ]
  },
  {
    order_index: 41,
    name: "Liên từ điều kiện không giới hạn \"无论 / 不管...都 / 也...\"",
    pattern: "无论 / 不管 + Từ để hỏi / A hay B, Chủ ngữ + 都 / 也 + Vị ngữ",
    category: "Liên từ",
    explanation_vi: "\"无论\" (wúlùn) hoặc \"不管\" (bùguǎn) biểu thị trong bất kỳ điều kiện, hoàn cảnh hoặc trường hợp nào thì kết quả, hành động ở vế sau vẫn diễn ra như cũ không hề thay đổi (cho dù, bất kể... đều). Phân câu trước bắt buộc phải có từ nghi vấn hoặc phương án lựa chọn (A hay B, làm gì, ở đâu).",
    examples: [
      {
        chinese: "无论前方的道路有多么坎坷艰险，我们都会坚定不移地朝着心中的目标勇毅前行。",
        pinyin: "Wúlùn qiánfāng de dàolù yǒu duōme kǎnkě jiānxiǎn, wǒmen dōu huì jiāndìng-bùyí de cháozhe xīnzhōng de mùbiāo yǒngyì qiánxíng.",
        translation_vi: "Bất kể con đường phía trước có gập ghềnh hiểm trở đến nhường nào, chúng tôi đều sẽ kiên định không dời dũng cảm tiến về mục tiêu trong lòng.",
        explanation: "\"无论...有多么...都...\" khẳng định quyết tâm trước mọi gian nan."
      },
      {
        chinese: "不管明天天气晴天还是刮风下雨，全校的春季运动会都会如期隆重举行。",
        pinyin: "Bùguǎn míngtiān tiānqì qíngtiān háishì guāfēng xiàyǔ, quán xiào de chūnjì yùndònghuì dōu huì rúqī lóngzhòng jǔxíng.",
        translation_vi: "Cho dù ngày mai thời tiết trời nắng hay nổi gió đổ mưa, đại hội thể thao mùa xuân toàn trường đều sẽ diễn ra đúng hẹn và long trọng.",
        explanation: "\"不管...还是...都\" loại bỏ ảnh hưởng của thời tiết đối với kế hoạch."
      }
    ]
  },

  // --- NHÓM 7: GIỚI TỪ TRUNG CẤP (中级介词) ---
  {
    order_index: 42,
    name: "Giới từ giới thiệu chủ đề phạm vi \"关于\" (Về / Về vấn đề)",
    pattern: "关于 + Đối tượng / Vấn đề, Chủ ngữ + Vị ngữ / 关于...的 + Danh từ",
    category: "Giới từ",
    explanation_vi: "\"关于\" (guānyú) đứng trước danh từ để giới thiệu phạm vi, chủ đề hoặc nội dung liên quan của sự việc (về, về vấn đề). Thường đứng đầu câu làm trạng ngữ hoặc kết hợp \"的\" làm định ngữ (sách về...: 关于...的书).",
    examples: [
      {
        chinese: "关于如何有效提高留学生汉语口语交际能力的问题，两位专家展开了深入探讨。",
        pinyin: "Guānyú rúhé yǒuxiào tígāo liúxuéshēng hànyǔ kǒuyǔ jiāojì nénglì de wèntí, liǎng wèi zhuānjiā zhǎnkāi le shēnrù tàntǎo.",
        translation_vi: "Về vấn đề làm thế nào để nâng cao hữu hiệu năng lực giao tiếp khẩu ngữ tiếng Hán của lưu học sinh, hai vị chuyên gia đã mở ra cuộc thảo luận sâu sắc.",
        explanation: "\"关于...的问题\" giới thiệu chủ đề trung tâm của cuộc trao đổi."
      },
      {
        chinese: "他在省立图书馆查阅了海量关于中国古代青铜器铸造工艺的历史文献。",
        pinyin: "Tā zài shěnglì túshūguǎn cháyuè le hǎiliàng guānyú zhōngguó gǔdài qīngtóngqì zhùzào gōngyì de lìshǐ wénxiàn.",
        translation_vi: "Anh ấy ở thư viện cấp tỉnh đã tra cứu khối lượng lớn tài liệu lịch sử về kỹ nghệ đúc đồ đồng cổ đại Trung Quốc.",
        explanation: "\"关于...的历史文献\" làm cụm giới từ làm định ngữ bổ nghĩa cho tài liệu."
      }
    ]
  },
  {
    order_index: 43,
    name: "Giới từ chỉ đối tượng thụ cảm \"对于\" (Đối với / Về mặt)",
    pattern: "对于 + Đối tượng, Chủ ngữ + Vị ngữ / Chủ ngữ + 对于 + Đối tượng + Vị ngữ",
    category: "Giới từ",
    explanation_vi: "\"对于\" (duìyú) dùng để đưa ra đối tượng mà ý kiến, thái độ, sự phán đoán nhắm vào (đối với, đối cùng). Khác với \"对\", \"对于\" chỉ dùng cho quan điểm, thái độ, không dùng cho hành vi tác động cụ thể giữa người với người (không nói 对于他笑).",
    examples: [
      {
        chinese: "对于这个涉及旧城改造与古建筑保护的城市规划草案，市民们提出了很多宝贵建议。",
        pinyin: "Duìyú zhè gè shèjí jiùchéng gǎizào yǔ gǔ jiànzhù bǎohù de chéngshì guīhuà cǎo'àn, shìmín men tíchū le hěn duō bǎoguì jiànyì.",
        translation_vi: "Đối với dự thảo quy hoạch đô thị liên quan đến cải tạo phố cũ và bảo tồn kiến trúc cổ này, người dân đã đề xuất rất nhiều kiến nghị quý báu.",
        explanation: "\"对于...规划草案\" xác định đối tượng tiếp nhận ý kiến đóng góp."
      },
      {
        chinese: "养成良好的每日阅读习惯，对于青少年综合素质的全面提升具有长远意义。",
        pinyin: "Yǎngchéng liánghǎo de měirì yuèdú xíguàn, duìyú qīng-shàonián zōnghé sùzhì de quánmiàn tíshēng jùyǒu chángyuǎn yìyì.",
        translation_vi: "Hình thành thói quen đọc sách hằng ngày tốt đẹp, đối với việc nâng cao toàn diện tố chất tổng hợp của thanh thiếu niên có ý nghĩa lâu dài.",
        explanation: "\"对于...全面提升\" chỉ phương diện thụ hưởng lợi ích lâu dài."
      }
    ]
  },
  {
    order_index: 44,
    name: "Giới từ căn cứ quy chuẩn \"按照\" (Theo / Căn cứ vào)",
    pattern: "按照 + Tiêu chuẩn / Quy định / Yêu cầu + Động từ (+ Tân ngữ)",
    category: "Giới từ",
    explanation_vi: "\"按照\" (ànzhào) biểu thị hành động được thực hiện dựa theo một tiêu chuẩn, quy chuẩn, quy định, kế hoạch hoặc yêu cầu đã được đề ra từ trước (theo, căn cứ theo, chiểu theo).",
    examples: [
      {
        chinese: "工程质检人员严格按照国家建筑安全工程标准，对大楼主体结构进行了全面检测。",
        pinyin: "Gōngchéng zhìjiǎn rényuán yángé ànzhào guójiā jiànzhù ānquán gōngchéng biāozhǔn, duì dàlóu zhǔtǐ jiégòu jìnxíng le quánmiàn jiǎncè.",
        translation_vi: "Các nhân viên kiểm định chất lượng công trình nghiêm ngặt căn cứ theo tiêu chuẩn công trình an toàn xây dựng quốc gia để tiến hành kiểm định toàn diện kết cấu thân tòa nhà.",
        explanation: "\"按照...标准\" chỉ chuẩn mực căn cứ để kiểm tra chất lượng."
      },
      {
        chinese: "请所有参会代表按照会务组统一安排的日程表，准时入场参加学术讨论。",
        pinyin: "Qǐng suǒyǒu cānhuì dàibiǎo ànzhào huìwùzǔ tǒngyī ānpái de rìchéngbiǎo, zhǔnshí rùchǎng cānjiā xuéshù tǎolùn.",
        translation_vi: "Xin mời toàn thể đại biểu tham dự hội nghị theo đúng lịch trình do ban tổ chức sắp xếp thống nhất, vào hội trường đúng giờ tham gia thảo luận học thuật.",
        explanation: "\"按照...日程表\" hành động tuân thủ theo lịch trình có sẵn."
      }
    ]
  },
  {
    order_index: 45,
    name: "Giới từ căn cứ chứng cứ \"根据\" (Căn cứ theo / Dựa vào)",
    pattern: "根据 + Căn cứ / Bằng chứng / Thực tế + Phán đoán / Hành động",
    category: "Giới từ",
    explanation_vi: "\"根据\" (gēnjù) dùng để đưa ra cơ sở, bằng chứng, dữ liệu hoặc căn cứ thực tế làm điểm tựa để đưa ra kết luận, phán đoán hoặc quyết định (căn cứ vào, dựa trên cơ sở). Ngoài ra còn làm danh từ (chứng cứ, cơ sở).",
    examples: [
      {
        chinese: "气象部门根据最新卫星云图的监测数据，及时发布了沿海强台风黄色预警。",
        pinyin: "Qìxiàng bùmén gēnjù zuìxīn wèixīng yúntú de jiāncè shùjù, jíshí fābù le yánhǎi qiáng táifēng huángsè yùjǐng.",
        translation_vi: "Cơ quan khí tượng căn cứ vào số liệu giám sát của ảnh mây vệ tinh mới nhất đã kịp thời phát cảnh báo màu vàng về bão mạnh ven biển.",
        explanation: "\"根据...数据\" đưa ra căn cứ dữ liệu vệ tinh để phát cảnh báo."
      },
      {
        chinese: "这本轰动文坛的侦探悬疑长篇小说，是作家根据几起真实历史案件创作而成的。",
        pinyin: "Zhè běn hōngdòng wéntán de zhēntàn xuányí chángpiān xiǎoshuō, shì zuòjiā gēnjù jǐ qǐ zhēnshí lìshǐ ànjiàn chuàngzuò ér chéng de.",
        translation_vi: "Cuốn tiểu thuyết trường thiên trinh thám ly kỳ làm chấn động văn đàn này là do nhà văn dựa trên một vài vụ án lịch sử có thật sáng tác nên.",
        explanation: "\"根据...案件\" chỉ tư liệu thực tế làm điểm tựa sáng tác."
      }
    ]
  },
  {
    order_index: 46,
    name: "Giới từ biến đổi đồng thời \"随着\" (Cùng với / Theo đà)",
    pattern: "随着 + Danh từ / Sự phát triển / Biến đổi, Chủ ngữ + Vị ngữ biến đổi tương ứng",
    category: "Giới từ",
    explanation_vi: "\"随着\" (suízhe) dùng để chỉ một sự việc, hiện tượng phát sinh hoặc biến đổi đồng thời theo sau sự chuyển biến của một sự vật, điều kiện khác (cùng với sự phát triển của..., theo đà...). Thường đứng ở đầu câu.",
    examples: [
      {
        chinese: "随着现代数字科技的高速发展，移动支付与无接触购物已经深度融入了千家万户。",
        pinyin: "Suízhe xiàndài shùzì kējì de gāosù fāzhǎn, yídòng zhīfù yǔ wú jiēchù gòuwù yǐjīng shēndù róngrù le qiānjiā-wànhù.",
        translation_vi: "Cùng với sự phát triển thần tốc của công nghệ số hiện đại, thanh toán di động và mua sắm không tiếp xúc đã hòa nhập sâu sắc vào muôn nhà vạn hộ.",
        explanation: "\"随着...高速发展\" đưa ra tiền đề công nghệ làm thay đổi đời sống tiêu dùng."
      },
      {
        chinese: "随着深秋季节气温的持续下降，公园湖畔的大片水杉树叶变得一片金黄灿烂。",
        pinyin: "Suízhe shēnqiū jìjié qìwēn de chíxù xiàjiàng, gōngyuán húpàn de dàpiàn shuǐshān shùyè biàn de yí piàn jīnhuáng cànlàn.",
        translation_vi: "Cùng với sự giảm liên tục của nhiệt độ mùa thu muộn, rặng lá cây thủy sam bên bờ hồ công viên đã ngả sang một màu vàng óng rực rỡ.",
        explanation: "\"随着...持续下降\" sự biến đổi màu lá đồng hành với sự hạ nhiệt thời tiết."
      }
    ]
  },
  {
    order_index: 47,
    name: "Giới từ trải qua quá trình nỗ lực \"经过\" (Trải qua / Qua)",
    pattern: "经过 + Quá trình / Nỗ lực / Thời gian, Chủ ngữ + Đạt được kết quả",
    category: "Giới từ",
    explanation_vi: "\"经过\" (jīngguò) biểu thị một quá trình rèn luyện, tìm tòi, phấn đấu hoặc diễn biến thời gian đã trải qua để dẫn tới một kết quả cụ thể (trải qua, qua một quá trình...). Ngoài ra còn làm động từ chỉ việc đi ngang qua một địa điểm.",
    examples: [
      {
        chinese: "经过科研团队历时三年的联合技术攻坚，该新型环保节能材料终于研发成功了。",
        pinyin: "Jīngguò kēyán tuánduì lìshí sān nián de liánhé jìshù gōngjiān, gāi xīnxíng huánbǎo jiénéng cáiliào zhōngyú yánfā chénggōng le.",
        translation_vi: "Trải qua ba năm công phá kỹ thuật liên hợp của đội ngũ nghiên cứu, vật liệu tiết kiệm năng lượng bảo vệ môi trường kiểu mới này cuối cùng đã phát triển thành công.",
        explanation: "\"经过...技术攻坚\" nhấn mạnh quá trình gian khổ dẫn đến thành quả."
      },
      {
        chinese: "每天早晨乘坐这趟城际班车，都会经过那座横跨大江的宏伟跨海大桥。",
        pinyin: "Měitiān zǎochén chéngzuò zhè tàng chéngjì bānchē, dōu huì jīngguò nà zuò héngkuà dàjiāng de hóngwěi kuàhǎi dàqiáo.",
        translation_vi: "Mỗi sáng sớm đi chuyến xe buýt liên tỉnh này đều sẽ đi ngang qua cây cầu vượt biển hùng vĩ bắc ngang sông lớn kia.",
        explanation: "\"经过...跨海大桥\" làm động từ chỉ việc đi ngang qua địa danh."
      }
    ]
  },
  {
    order_index: 48,
    name: "Giới từ phương thức công cụ \"通过\" (Thông qua / Bằng cách)",
    pattern: "通过 + Phương thức / Kênh trung gian / Biện pháp, Chủ ngữ + Đạt mục đích",
    category: "Giới từ",
    explanation_vi: "\"通过\" (tōngguò) giới thiệu phương thức, thủ đoạn, phương tiện hoặc khâu trung gian để đạt được mục đích đề ra (thông qua, nhờ có, bằng cách). Ngoài ra còn làm động từ chỉ việc thi đỗ hoặc được thông qua dự thảo (như 通过考试).",
    examples: [
      {
        chinese: "通过阅读经典文学名著和观看中文纪录片，他的汉语听说水平有了显著飞跃。",
        pinyin: "Tōngguò yuèdú jīngdiǎn wénxué míngzhù hé guānkàn zhōngwén jìlùpiàn, tā de hànyǔ tīng-shuō shuǐpíng yǒu le xiǎnzhù fēiyuè.",
        translation_vi: "Thông qua việc đọc danh tác văn học kinh điển và xem phim tài liệu tiếng Trung, trình độ nghe nói tiếng Hán của anh ấy đã có bước nhảy vọt rõ rệt.",
        explanation: "\"通过阅读...和观看...\" nêu phương thức rèn luyện dẫn tới bước tiến bộ."
      },
      {
        chinese: "经过全校代表大会的热烈讨论，这项关于学生公寓管理的新规章获得了全票通过。",
        pinyin: "Jīngguò quán xiào dàibiǎo dàhuì de rèliè tǎolùn, zhè xiàng guānyú xuésheng gōngyù guǎnlǐ de xīn guīzhāng huòdé le quánpiào tōngguò.",
        translation_vi: "Trải qua cuộc thảo luận sôi nổi của đại hội đại biểu toàn trường, quy định mới về quản lý ký túc xá sinh viên này đã được toàn phiếu thông qua.",
        explanation: "\"全票通过\" làm động từ chỉ văn bản được phê chuẩn chính thức."
      }
    ]
  },

  // --- NHÓM 8: BỔ NGỮ KẾT QUẢ TRUNG CẤP (中级结果补语) ---
  {
    order_index: 49,
    name: "Bổ ngữ kết quả ly khai / dịch chuyển \"走\" (Đi / Rời đi)",
    pattern: "Động từ (拿 / 带 / 搬 / 借) + 走 (+ Tân ngữ)",
    category: "Bổ ngữ",
    explanation_vi: "\"走\" (zǒu) làm bổ ngữ kết quả đứng sau động từ chỉ sự rời khỏi vị trí ban đầu của đồ vật hoặc con người do hành động gây ra (mang đi, lấy đi, chuyển đi, bay đi: 拿走, 带走, 搬走, 飞走).",
    examples: [
      {
        chinese: "他离开办公室去外地出差之前，顺手把桌上所有的重要公文都带走了。",
        pinyin: "Tā líkāi bàngōngshì qù wàidì chūchāi zhīqián, shùnshǒu bǎ zhuō shang suǒyǒu de zhòngyào gōngwén dōu dài zǒu le.",
        translation_vi: "Trước khi rời văn phòng đi công tác ngoại tỉnh, anh ấy tiện tay đã mang đi tất cả công văn quan trọng trên bàn.",
        explanation: "\"带走了\" biểu thị tài liệu đã theo người di chuyển rời khỏi phòng."
      },
      {
        chinese: "一阵猛烈的秋风刮过树梢，瞬间把树枝上的枯黄落叶全都吹走了。",
        pinyin: "Yí zhèn měngliè de qiūfēng guā guò shùshāo, shùnjiān bǎ shùzhī shang de kūhuáng luòyè quándōu chuī zǒu le.",
        translation_vi: "Một cơn gió thu dữ dội thổi qua ngọn cây, trong nháy mắt đã thổi bay hết sạch lá vàng khô rụng trên cành cây.",
        explanation: "\"吹走了\" làm bổ ngữ miêu tả lá cây bị gió cuốn đi xa."
      }
    ]
  },
  {
    order_index: 50,
    name: "Bổ ngữ kết quả tiêu biến / loại trừ \"掉\" (Mất / Hết / Vứt bỏ)",
    pattern: "Động từ (丢 / 扔 / 忘 / 擦 / 卖) + 掉 (+ Tân ngữ)",
    category: "Bổ ngữ",
    explanation_vi: "\"掉\" (diào) làm bổ ngữ kết quả biểu thị sự biến mất, mất mát, tiêu biến hoặc loại bỏ hoàn toàn một đối tượng hay đặc tính nào đó (rơi mất: 丢掉, vứt đi: 扔掉, quên sạch: 忘掉, lau sạch: 擦掉).",
    examples: [
      {
        chinese: "清洁工阿姨用干净的毛巾，把黑板上的所有粉笔字迹彻底擦掉了。",
        pinyin: "Qīngjiégōng āyí yòng gānjìng de máojīn, bǎ hēibǎn shang de suǒyǒu fěnbǐ zìjì chèdǐ cā diào le.",
        translation_vi: "Bác lao công dùng chiếc khăn bông sạch sẽ lau sạch hoàn toàn mọi vết phấn trên bảng đen.",
        explanation: "\"擦掉了\" biểu thị vết phấn trên bảng bị xóa sạch không còn."
      },
      {
        chinese: "面对生活中的挫折与烦恼，我们要学会调整心态，尽快把不愉快的情绪忘掉。",
        pinyin: "Miànduì shēnghuó zhōng de cuòzhé yǔ fánnǎo, wǒmen yào xuéhuì tiáozhěng xīntài, jǐnkuài bǎ bù yúkuài de qíngxù wàng diào.",
        translation_vi: "Đối mặt với trắc trở và phiền muộn trong đời, chúng ta cần học cách điều chỉnh tâm thái, mau chóng quên hết những cảm xúc không vui đi.",
        explanation: "\"忘掉\" làm bổ ngữ kết quả cho việc loại bỏ nỗi buồn khỏi tâm trí."
      }
    ]
  },
  {
    order_index: 51,
    name: "Bổ ngữ kết quả cố định vững chắc \"住\" (Chặt / Chắc / Dừng lại)",
    pattern: "Động từ (站 / 记 / 拿 / 停 / 抓) + 住 (+ Tân ngữ)",
    category: "Bổ ngữ",
    explanation_vi: "\"住\" (zhù) làm bổ ngữ kết quả biểu thị hành động đã làm cho người hoặc vật trở nên cố định, dừng lại, bám chắc hoặc khắc sâu vào trí nhớ (đứng vững: 站住, nhớ kỹ: 记住, cầm chắc: 拿住, dừng lại: 停住).",
    examples: [
      {
        chinese: "老师反复认真强调的核心语法知识点，同学们必须牢牢记住并熟练运用。",
        pinyin: "Lǎoshī fǎnfù rènzhēn qiángdiào de héxīn yǔfǎ zhīshidiǎn, tóngxué men bìxū láoláo jì zhù bìng shúliàn yùnyòng.",
        translation_vi: "Các điểm kiến thức ngữ pháp cốt lõi mà thầy giáo nghiêm túc nhấn mạnh nhiều lần, các bạn học sinh bắt buộc phải ghi nhớ thật chắc và vận dụng thuần thục.",
        explanation: "\"记住\" biểu thị kiến thức được ghi khắc vững chắc trong đầu."
      },
      {
        chinese: "暴风雨中巡逻的边防战士们手挽着手，在泥泞陡峭的山坡上稳稳站住了脚跟。",
        pinyin: "Bàofēngyǔ zhōng xúnluó de biānfáng zhànshì men shǒu wǎn zhe shǒu, zài nínìng dǒuqiào de shānpō shang wěnwěn zhàn zhù le jiǎogēn.",
        translation_vi: "Các chiến sĩ biên phòng tuần tra trong giông bão khoác tay nhau, đứng vững chắc gót chân trên sườn dốc trơn trượt hiểm trở.",
        explanation: "\"站住了\" biểu thị việc giữ vững tư thế không để bị trượt ngã."
      }
    ]
  },
  {
    order_index: 52,
    name: "Bổ ngữ kết quả tách rời / khuếch tán \"开\" (Mở ra / Tách ra)",
    pattern: "Động từ (打 / 翻 / 分 / 走 / 离开) + 开 (+ Tân ngữ)",
    category: "Bổ ngữ",
    explanation_vi: "\"开\" (kāi) làm bổ ngữ kết quả biểu thị hành động làm cho hai hoặc nhiều sự vật tách rời nhau ra, mở rộng không gian hoặc tản rộng ra các phía (mở ra: 打开, giở sách: 翻开, tách ra: 分开, tránh ra: 避开).",
    examples: [
      {
        chinese: "上课铃声响起，同学们迅速翻开崭新的汉语课本开始大声朗读课文。",
        pinyin: "Shàngkè língshēng xiǎng qǐ, tóngxué men xùnsù fān kāi zhǎnxīn de hànyǔ kèběn kāishǐ dàshēng lǎngdú kèwén.",
        translation_vi: "Tiếng chuông vào lớp vang lên, các bạn học sinh nhanh chóng giở trang sách giáo khoa tiếng Hán mới tinh bắt đầu đọc to bài khóa.",
        explanation: "\"翻开\" biểu thị các trang sách mở tách rời ra."
      },
      {
        chinese: "为了避免引起不必要的误解与冲突，讨论时双方应当把不同意见摊开来说清楚。",
        pinyin: "Wèile bìmiǎn yǐnqǐ bú bìyào de wùjiě yǔ chōngtū, tǎolùn shí shuāngfāng yīngdāng bǎ bùtóng yìjiàn tān kāi lái shuō qīngchu.",
        translation_vi: "Để tránh gây ra hiểu lầm và xung đột không cần thiết, khi thảo luận hai bên nên trải rộng các ý kiến bất đồng ra để nói cho rõ ràng.",
        explanation: "\"摊开\" miêu tả việc mở rộng công khai các vấn đề."
      }
    ]
  }
];
