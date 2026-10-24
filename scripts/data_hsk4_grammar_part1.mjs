// ==============================================================================
// DATA: data_hsk4_grammar_part1.mjs
// HSK 4 GRAMMAR - PART 1: ĐIỂM 1 ĐẾN 26 (CHUẨN GF 0025-2021 APPENDIX A)
// Đại từ chỉ định/phiếm chỉ nâng cao, Số từ, Phần trăm, Bội số & Hệ thống Lượng từ chuyên biệt
// ==============================================================================

export const HSK4_GRAMMAR_PART1 = [
  {
    order_index: 1,
    name: 'Đại từ phân phối "各" (Từng / Mỗi / Các)',
    pattern: '各 + Danh từ / Lượng từ + Danh từ',
    category: 'Đại từ',
    explanation_vi: '"各" (gè) biểu thị từng cá thể riêng biệt trong một tổng thể hoặc các phương diện, các bên khác nhau. "各" có thể trực tiếp kết hợp với danh từ song âm tiết (như 各国, 各地, 各界) hoặc đi kèm lượng từ trước danh từ đơn âm tiết (各个, 各门). Khác với "每" nhấn mạnh tính đồng nhất của mọi cá thể, "各" nhấn mạnh tính độc lập, riêng rẽ của từng đối tượng.',
    examples: [
      {
        chinese: '代表们来自世界各国，共同探讨环境保护问题。',
        pinyin: 'Dàibiǎomen láizì shìjiè gèguó, gòngtóng tàntǎo huánjìng bǎohù wèntí.',
        translation_vi: 'Các đại biểu đến từ các quốc gia trên thế giới, cùng nhau thảo luận về vấn đề bảo vệ môi trường.',
        explanation: '"各" trực tiếp đứng trước danh từ song âm tiết "国" (quốc gia) tạo thành "各国" chỉ từng quốc gia khác nhau trên thế giới.'
      },
      {
        chinese: '每个人都有自己的优点，各有各的长处。',
        pinyin: 'Měi gè rén dōu yǒu zìjǐ de yōudiǎn, gè yǒu gè de chángchù.',
        translation_vi: 'Mỗi người đều có ưu điểm riêng, ai cũng có sở trường của riêng mình.',
        explanation: 'Cấu trúc "各有各的 + Danh từ" là cách dùng khẩu ngữ cố định biểu thị mỗi người/mỗi bên đều có phần riêng của mình.'
      }
    ]
  },
  {
    order_index: 2,
    name: 'Đại từ phiếm chỉ không xác định "某" (Nào đó / Ai đó / Chỗ nào đó)',
    pattern: '某 + Lượng từ + Danh từ / 某人 / 某地 / 某事',
    category: 'Đại từ',
    explanation_vi: '"某" (mǒu) dùng để chỉ người, sự vật, thời gian hoặc nơi chốn chưa xác định rõ hoặc không tiện nêu đích danh cụ thể. Khi đi với danh từ đơn âm tiết hoặc song âm tiết, thường dùng "某 + Lượng từ + Danh từ" (như 某种原因, 某一天) hoặc ghép thẳng (某人, 某市, 某校).',
    examples: [
      {
        chinese: '由于某种特殊原因，明天的会议需要推迟举行。',
        pinyin: 'Yóuyú mǒu zhǒng tèshū yuányīn, míngtiān de huìyì xūyào tuīchí jǔxíng.',
        translation_vi: 'Do một nguyên nhân đặc biệt nào đó, cuộc họp ngày mai cần phải hoãn lại.',
        explanation: '"某" kết hợp với lượng từ "种" và danh từ "原因" để chỉ lý do không tiện nói rõ tên cụ thể.'
      },
      {
        chinese: '这篇小说的主要故事发生在北方的某座城市。',
        pinyin: 'Zhè piān xiǎoshuō de zhǔyào gùshì fāshēng zài běifāng de mǒu zuò chéngshì.',
        translation_vi: 'Câu chuyện chính của cuốn tiểu thuyết này xảy ra ở một thành phố nào đó ở miền Bắc.',
        explanation: '"某座城市" biểu thị một thành phố phiếm chỉ, tác giả không muốn chỉ đích danh địa danh.'
      }
    ]
  },
  {
    order_index: 3,
    name: 'Đại từ chỉ thị "本" chỉ bản thân hoặc hiện tại (Này / Bản...)',
    pattern: '本 + Danh từ (本人 / 本地 / 本市 / 本课 / 本报)',
    category: 'Đại từ',
    explanation_vi: '"本" (běn) trong văn viết hoặc phong cách trang trọng đóng vai trò như đại từ chỉ thị tương đương với "这" (này) hoặc "自己" (bản thân). Thường kết hợp trực tiếp với danh từ đơn âm tiết hoặc song âm tiết như 本人 (bản thân tôi/đương sự), 本地 (địa phương này), 本世纪 (thế kỷ này), 本文 (bài viết này).',
    examples: [
      {
        chinese: '这项优惠活动仅对本校学生和教职工有效。',
        pinyin: 'Zhè xiàng yōuhuì huódòng jǐn duì běnxiào xuésheng hé jiàozhígōng yǒuxiào.',
        translation_vi: 'Chương trình ưu đãi này chỉ có hiệu lực đối với học sinh và cán bộ giảng viên của trường này.',
        explanation: '"本校" có nghĩa là trường này (ngôi trường của người nói/người viết), mang sắc thái trang trọng.'
      },
      {
        chinese: '如果需要办理签证，必须由申请人本人亲自到场。',
        pinyin: 'Rúguǒ xūyào bànlǐ qiānzhèng, bìxū yóu shēnqǐngrén běnrén qīnzì dàochǎng.',
        translation_vi: 'Nếu cần làm thủ tục xin thị thực, bắt buộc đích thân đương sự phải có mặt.',
        explanation: '"本人" nhấn mạnh chính bản thân người nộp đơn, không thể ủy quyền cho người khác.'
      }
    ]
  },
  {
    order_index: 4,
    name: 'Đại từ hỗ tương "彼此" (Lẫn nhau / Đôi bên / Cả hai)',
    pattern: 'Chủ ngữ (số nhiều) + 彼此 + Động từ / 彼此的 + Danh từ / 彼此彼此',
    category: 'Đại từ',
    explanation_vi: '"彼此" (bǐcǐ) biểu thị quan hệ qua lại giữa hai hoặc nhiều bên đối tác (cả hai phía, lẫn nhau). Thường làm chủ ngữ, tân ngữ, định ngữ hoặc trạng ngữ. Trong giao tiếp lịch sự, nói "彼此彼此" mang hàm ý khiêm tốn đáp lại lời khen ngợi (hai bên đều như nhau cả thôi).',
    examples: [
      {
        chinese: '朋友之间应该互相尊重，理解彼此的想法。',
        pinyin: 'Péngyou zhījiān yīnggāi hùxiāng zūnzhòng, lǐjiě bǐcǐ de xiǎngfǎ.',
        translation_vi: 'Bạn bè với nhau nên tôn trọng lẫn nhau, thấu hiểu suy nghĩ của nhau.',
        explanation: '"彼此的想法" nghĩa là ý nghĩ của đôi bên, "彼此" đứng làm định ngữ hạn định cho "想法".'
      },
      {
        chinese: '他们多年不见，但彼此依然十分信任。',
        pinyin: 'Tāmen duō nián bú jiàn, dàn bǐcǐ yīrán shífēn xìnrèn.',
        translation_vi: 'Họ nhiều năm không gặp, nhưng đôi bên vẫn hết sức tin tưởng lẫn nhau.',
        explanation: '"彼此" làm trạng ngữ đứng trước động từ "信任" để biểu thị sự tin tưởng hai chiều.'
      }
    ]
  },
  {
    order_index: 5,
    name: 'Đại từ phiếm chỉ toàn thể vô điều kiện "任何" (Bất kỳ / Bất luận)',
    pattern: '任何 + (Lượng từ) + Danh từ + 都 / 也',
    category: 'Đại từ',
    explanation_vi: '"任何" (rènhé) là đại từ phiếm chỉ mang nghĩa không phân biệt đối tượng nào, bất kể sự vật hay con người nào trong phạm vi thảo luận. Thường kết hợp với "都" hoặc "也" ở vế sau để nhấn mạnh tính phổ quát tuyệt đối.',
    examples: [
      {
        chinese: '无论面对任何困难，我们都不应该轻易放弃。',
        pinyin: 'Wúlùn miànduì rènhé kùnnan, wǒmen dōu bù yīnggāi qīngyì fàngqì.',
        translation_vi: 'Bất luận đối mặt với bất kỳ khó khăn nào, chúng ta cũng không nên dễ dàng bỏ cuộc.',
        explanation: '"任何困难" (bất kỳ khó khăn nào) kết hợp với "无论...都..." khẳng định quyết tâm kiên trì không có ngoại lệ.'
      },
      {
        chinese: '在法律面前，没有任何人享有特权。',
        pinyin: 'Zài fǎlǜ miànqián, méiyǒu rènhé rén xiǎngyǒu tèquán.',
        translation_vi: 'Trước pháp luật, không có bất kỳ ai được hưởng đặc quyền.',
        explanation: '"没有任何人" phủ định hoàn toàn sự tồn tại của bất kỳ đối tượng ngoại lệ nào.'
      }
    ]
  },
  {
    order_index: 6,
    name: 'Đại từ bao quát toàn bộ "一切" (Tất cả / Toàn bộ mọi thứ)',
    pattern: '一切 + Danh từ / Danh từ + (的) 一切 / 一切 + 都...',
    category: 'Đại từ',
    explanation_vi: '"一切" (yíqiè) là đại từ chỉ toàn bộ sự vật, hiện tượng hoặc phương diện (mọi thứ, tất cả). "一切" có thể làm chủ ngữ đứng độc lập, làm định ngữ (一切困难, 一切费用) hoặc làm tân ngữ (安排好了一切). Khác với "所有", "一切" thiên về tính chất trừu tượng và toàn diện.',
    examples: [
      {
        chinese: '请大家放心，我们已经为这次活动准备好了一切。',
        pinyin: 'Qǐng dàjiā fàngxīn, wǒmen yǐjīng wèi zhè cì huódòng zhǔnbèi hǎo le yíqiè.',
        translation_vi: 'Xin mọi người hãy yên tâm, chúng tôi đã chuẩn bị xong xuôi mọi thứ cho sự kiện lần này.',
        explanation: '"一切" làm tân ngữ cho cụm động từ "准备好", bao gồm tất cả các khâu chuẩn bị cần thiết.'
      },
      {
        chinese: '为了孩子的健康成长，父母愿意付出自己的一切。',
        pinyin: 'Wèile háizi de jiànkāng chéngzhǎng, fùmǔ yuànyì fùchū zìjǐ de yíqiè.',
        translation_vi: 'Vì sự trưởng thành khỏe mạnh của con cái, cha mẹ sẵn lòng hy sinh tất cả của bản thân.',
        explanation: '"自己的一切" là cụm định tâm thể hiện toàn bộ công sức, thời gian và tình cảm của cha mẹ.'
      }
    ]
  },
  {
    order_index: 7,
    name: 'Đại từ phản thân tự thân "自身" (Bản thân / Chính mình)',
    pattern: '自身 + Danh từ / Động từ + 自身 / Chủ ngữ + 自身',
    category: 'Đại từ',
    explanation_vi: '"自身" (zìshēn) là đại từ chỉ bản thân chủ thể hoặc phẩm chất nội tại của một sự vật, cơ quan, tổ chức. So với "自己", "自身" mang sắc thái văn viết trang trọng hơn, thường dùng khi phân tích năng lực nội tại, sự phát triển hoặc nhược điểm của sự vật.',
    examples: [
      {
        chinese: '企业要想在竞争中立足，必须不断提高自身的产品质量。',
        pinyin: 'Qǐyè yào xiǎng zài jìngzhēng zhōng lìzú, bìxū búduàn tígāo zìshēn de chǎnpǐn zhìliàng.',
        translation_vi: 'Doanh nghiệp muốn đứng vững trong cạnh tranh, bắt buộc phải không ngừng nâng cao chất lượng sản phẩm của chính mình.',
        explanation: '"自身的产品质量" nhấn mạnh năng lực và chất lượng nội tại xuất phát từ chính doanh nghiệp.'
      },
      {
        chinese: '很多时候，我们最大的敌人其实正是我们自身。',
        pinyin: 'Hěn duō shíhou, wǒmen zuì dà de dírén qíshí zhèng shì wǒmen zìshēn.',
        translation_vi: 'Rất nhiều khi, kẻ thù lớn nhất của chúng ta trên thực tế chính là bản thân chúng ta.',
        explanation: '"自身" ở đây nhấn mạnh sự tự nhận thức và khắc phục nhược điểm của chính bản thân con người.'
      }
    ]
  },
  {
    order_index: 8,
    name: 'Biểu thị phân số và phần trăm với "百分之..." / "...分之..."',
    pattern: 'Mẫu số + 分之 + Tử số (百分之八十 / 三分之二)',
    category: 'Số từ',
    explanation_vi: 'Trong tiếng Trung, quy tắc biểu thị phân số và tỉ lệ phần trăm tuân thủ nguyên tắc: đọc mẫu số trước rồi đến "分之" (fēn zhī), sau đó mới đọc tử số. Ví dụ: 1/3 đọc là "三分之一", 85% đọc là "百分之八十五".',
    examples: [
      {
        chinese: '调查显示，有百分之七十的年轻人习惯在网上购物。',
        pinyin: 'Diàochá xiǎnshì, yǒu bǎi fēn zhī qīshí de niánqīngrén xíguàn zài wǎngshang gòuwù.',
        translation_vi: 'Khảo sát cho thấy có 70% người trẻ tuổi có thói quen mua sắm trực tuyến.',
        explanation: '"百分之七十" (70%) là cấu trúc chuẩn để biểu đạt tỷ lệ phần trăm trong tiếng Trung hiện đại.'
      },
      {
        chinese: '这本厚书我已经读了三分之二，内容非常精彩。',
        pinyin: 'Zhè běn hòu shū wǒ yǐjīng dú le sān fēn zhī èr, nèiróng fēicháng jīngcǎi.',
        translation_vi: 'Cuốn sách dày này tôi đã đọc được hai phần ba rồi, nội dung vô cùng hấp dẫn.',
        explanation: '"三分之二" (2/3) thể hiện tiến độ đọc sách, trong đó mẫu số là 3 (三) và tử số là 2 (二).'
      }
    ]
  },
  {
    order_index: 9,
    name: 'Biểu thị bội số với "倍" (Lần / Gấp... lần)',
    pattern: 'A 是 B 的 + Số từ + 倍 / A 比 B + Tăng/Giảm + Số từ + 倍',
    category: 'Số từ',
    explanation_vi: '"倍" (bèi) biểu thị số lần gấp lên của một đại lượng so với một đại lượng khác. Lưu ý: Tiếng Trung chỉ dùng "倍" cho sự tăng trưởng (tăng gấp bội), không dùng "倍" cho sự giảm bớt (khi giảm phải dùng phân số hoặc phần trăm). Khi nói "A 是 B 的两倍" nghĩa là A = 2B; còn "A 比 B 增加了一倍" cũng có nghĩa là A = 2B.',
    examples: [
      {
        chinese: '今年公司的营业额是去年的三倍，成绩十分显著。',
        pinyin: 'Jīnnián gōngsī de yíngyè\'é shì qùnián de sān bèi, chéngjì shífēn xiǎnzhù.',
        translation_vi: 'Doanh thu năm nay của công ty gấp 3 lần năm ngoái, thành tích rất nổi bật.',
        explanation: 'Cấu trúc so sánh bội số "A 是 B 的三倍" biểu thị doanh số năm nay bằng 3 lần doanh số năm ngoái.'
      },
      {
        chinese: '采用了新技术后，工厂的生产效率提高了一倍。',
        pinyin: 'Cǎiyòng le xīn jìshù hòu, gōngchǎng de shēngchǎn xiàolǜ tígāo le yí bèi.',
        translation_vi: 'Sau khi áp dụng kỹ thuật mới, hiệu suất sản xuất của nhà máy đã tăng lên gấp đôi.',
        explanation: '"提高了一倍" nghĩa là hiệu suất tăng thêm 100%, tức đạt mức gấp 2 lần ban đầu.'
      }
    ]
  },
  {
    order_index: 10,
    name: 'Động lượng từ chỉ chuyến đi khứ hồi "趟" (Chuyến / Lượt)',
    pattern: 'Động từ (去/来/跑/走) + (Số từ) + 趟',
    category: 'Lượng từ',
    explanation_vi: '"趟" (tàng) là động lượng từ chuyên dùng cho các hành động đi lại di chuyển khứ hồi (đi rồi về) hoặc chuyến xe/tàu. Khác với "次" (chỉ số lần phát sinh chung của mọi hành vi), "趟" bắt buộc gắn liền với hành động dịch chuyển vị trí thực tế của con người hoặc phương tiện giao thông.',
    examples: [
      {
        chinese: '为了办理护照，他昨天特意去了一趟出入境管理局。',
        pinyin: 'Wèile bànlǐ hùzhào, tā zuótiān tèyì qù le yí tàng chūrùjìng guǎnlǐjú.',
        translation_vi: 'Để làm hộ chiếu, hôm qua anh ấy đã đặc biệt đi đến Cục Quản lý Xuất Nhập cảnh một chuyến.',
        explanation: '"去了一趟" chỉ chuyến đi đến cơ quan nhà nước giải quyết thủ tục rồi quay về.'
      },
      {
        chinese: '我们明天清晨坐最早一趟高铁去上海出差。',
        pinyin: 'Wǒmen míngtiān qīngchén zuò zuì zǎo yí tàng gāotiě qù Shànghǎi chūchāi.',
        translation_vi: 'Sáng sớm mai chúng tôi sẽ đi chuyến tàu cao tốc sớm nhất để đến Thượng Hải công tác.',
        explanation: '"一趟高铁" dùng "趟" làm danh lượng từ để chỉ chuyến tàu vận tải hành khách.'
      }
    ]
  },
  {
    order_index: 11,
    name: 'Danh lượng từ chuyên dùng cho bài viết, văn kiện "篇" (Bài / Thiên)',
    pattern: 'Số từ + 篇 + Danh từ (文章 / 论文 / 报道 / 日记 / 课文)',
    category: 'Lượng từ',
    explanation_vi: '"篇" (piān) là lượng từ chuyên dụng dành cho các tác phẩm văn học, bài văn, bài báo, luận văn hoặc bài phát biểu hoàn chỉnh bằng chữ viết.',
    examples: [
      {
        chinese: '经过一个星期的努力，王教授终于完成了那篇学术论文。',
        pinyin: 'Jīngguò yí gè xīngqī de nǔlì, Wáng jiàoshòu zhōngyú wánchéng le nà piān xuéshù lùnwén.',
        translation_vi: 'Sau một tuần nỗ lực, giáo sư Vương cuối cùng đã hoàn thành bài luận văn học thuật đó.',
        explanation: '"篇" làm lượng từ chuẩn đi kèm với danh từ học thuật "论文" (luận văn).'
      },
      {
        chinese: '今天的报纸上刊登了一篇关于人工智能发展的特别报道。',
        pinyin: 'Jīntiān de bàozhǐ shang kāndēng le yì piān guānyú réngōng zhìnéng fāzhǎn de tèbié bàodào.',
        translation_vi: 'Trên tờ báo hôm nay có đăng một bài phóng sự đặc biệt về sự phát triển của trí tuệ nhân tạo.',
        explanation: '"一篇...报道" dùng "篇" định lượng cho bài tin tức/phóng sự hoàn chỉnh trên báo in.'
      }
    ]
  },
  {
    order_index: 12,
    name: 'Danh lượng từ chỉ phần, bản, suất "份" (Phần / Bản / Suất)',
    pattern: 'Số từ + 份 + Danh từ (报纸 / 礼物 / 工作 / 菜单 / 文件 / 早餐)',
    category: 'Lượng từ',
    explanation_vi: '"份" (fèn) biểu thị một phần được chia ra từ một tổng thể, một ấn phẩm định kỳ (như báo chí), một tài liệu hành chính, một suất ăn hoặc một công việc/tình cảm mang tính chất trao tặng.',
    examples: [
      {
        chinese: '毕业之后，他凭借优秀的专业能力顺利找到了一份满意的工作。',
        pinyin: 'Bìyè zhīhòu, tā píngjiè yōuxiù de zhuānyè nénglì shùnlì zhǎodào le yí fèn mǎnyì de gōngzuò.',
        translation_vi: 'Sau khi tốt nghiệp, nhờ năng lực chuyên môn xuất sắc anh ấy đã thuận lợi tìm được một công việc ưng ý.',
        explanation: '"一份工作" là cách dùng lượng từ "份" kết hợp chuẩn xác với "工作" (công việc).'
      },
      {
        chinese: '服务员，请给我们拿一份菜单和两份特色早餐。',
        pinyin: 'Fúwùyuán, qǐng gěi wǒmen ná yí fèn càidān hé liǎng fèn tèsè zǎocān.',
        translation_vi: 'Phục vụ ơi, xin hãy lấy cho chúng tôi một cuốn thực đơn và hai phần bữa sáng đặc sản.',
        explanation: '"一份菜单" (một cuốn thực đơn) và "两份早餐" (hai suất ăn sáng) dùng "份" chuẩn xác.'
      }
    ]
  },
  {
    order_index: 13,
    name: 'Danh lượng từ chỉ khóa, kỳ, nhiệm kỳ "届" (Khóa / Kỳ / Lần)',
    pattern: 'Số thứ tự / Số từ + 届 + Danh từ (奥运会 / 毕业生 / 会议 / 比赛)',
    category: 'Lượng từ',
    explanation_vi: '"届" (jiè) là lượng từ chuyên dùng cho các sự kiện định kỳ quy mô lớn diễn ra theo từng nhiệm kỳ, khóa học, đại hội thể thao, hoặc các hội nghị thường niên có đánh số thứ tự.',
    examples: [
      {
        chinese: '北京成功举办了第二十九届夏季奥林匹克运动会。',
        pinyin: 'Běijīng chénggōng jǔbàn le dì èrshíjiǔ jiè xiàjì àolínpǐkè yùndònghuì.',
        translation_vi: 'Bắc Kinh đã tổ chức thành công Thế vận hội Olympic Mùa hè lần thứ 29.',
        explanation: '"第二十九届" chỉ kỳ thế vận hội thứ 29, "届" là lượng từ chuẩn xác cho các sự kiện thể thao/đại hội quốc tế.'
      },
      {
        chinese: '作为本届毕业生代表，她在毕业典礼上发表了感人的演讲。',
        pinyin: 'Zuòwéi běnjiè bìyèshēng dàibiǎo, tā zài bìyè diǎnlǐ shang fābiǎo le gǎnrén de yǎnjiǎng.',
        translation_vi: 'Với tư cách là đại biểu của khóa tốt nghiệp năm nay, cô ấy đã phát biểu một bài diễn văn xúc động tại lễ tốt nghiệp.',
        explanation: '"本届毕业生" chỉ tập thể sinh viên của khóa ra trường hiện tại.'
      }
    ]
  },
  {
    order_index: 14,
    name: 'Danh lượng từ chỉ cọng, que, sợi "根" (Cọng / Que / Sợi / Cây)',
    pattern: 'Số từ + 根 + Danh từ (头发 / 香蕉 / 绳子 / 筷子 / 针 / 黄瓜)',
    category: 'Lượng từ',
    explanation_vi: '"根" (gēn) dùng để chỉ những đồ vật dài, mảnh, thon và tương đối dẻo hoặc có hình trụ nhỏ như sợi tóc, que diêm, quả chuối, cây kim, sợi dây thừng, chiếc đũa.',
    examples: [
      {
        chinese: '他在镜子前整理头发，发现自己长出了一根白发。',
        pinyin: 'Tā zài jìngzi qián zhěnglǐ tóufa, fāxiàn zìjǐ zhǎngchū le yì gēn báifà.',
        translation_vi: 'Anh ấy đứng trước gương chải tóc và phát hiện mình đã mọc một sợi tóc bạc.',
        explanation: '"一根白发" dùng "根" chỉ một sợi tóc dài mỏng.'
      },
      {
        chinese: '桌子上放着一根新鲜的香蕉和几根黄瓜。',
        pinyin: 'Zhuōzi shang fàngzhe yì gēn xīnxiān de xiāngjiāo hé jǐ gēn huángguā.',
        translation_vi: 'Trên bàn có đặt một quả chuối tươi và mấy quả dưa chuột.',
        explanation: 'Trong tiếng Trung, hoa quả hình trụ thon dài như chuối (香蕉) hoặc dưa leo (黄瓜) đều dùng lượng từ "根".'
      }
    ]
  },
  {
    order_index: 15,
    name: 'Danh lượng từ chỉ hạt, viên, đồ vật nhỏ tròn "颗" (Viên / Hạt / Ngôi)',
    pattern: 'Số từ + 颗 + Danh từ (星星 / 药 / 心 / 种子 / 葡萄 / 牙齿)',
    category: 'Lượng từ',
    explanation_vi: '"颗" (kē) dùng cho các vật thể có hình hạt, viên nhỏ, tròn hoặc tương đối tròn như hạt cây, viên thuốc, hạt ngọc, ngôi sao, viên kẹo, hoặc trái tim.',
    examples: [
      {
        chinese: '夜晚的天空十分晴朗，天空中闪烁着几颗明亮的星星。',
        pinyin: 'Yèwǎn de tiānkōng shífēn qínglǎng, tiānkōng zhōng shǎnshuòzhe jǐ kē míngliàng de xīngxing.',
        translation_vi: 'Bầu trời đêm rất quang đãng, trên không trung lấp lánh mấy ngôi sao sáng.',
        explanation: '"几颗...星星" dùng "颗" để chỉ các vì tinh tú trên bầu trời.'
      },
      {
        chinese: '医生叮嘱他饭后按时吃两颗感冒药。',
        pinyin: 'Yīshēng dīngzhǔ tā fànhòu ànshí chī liǎng kē gǎnmàoyào.',
        translation_vi: 'Bác sĩ dặn dò anh ấy sau bữa ăn hãy uống đúng giờ hai viên thuốc cảm.',
        explanation: '"两颗感冒药" dùng "颗" định lượng cho viên thuốc nén hoặc thuốc con nhộng hình hạt tròn.'
      }
    ]
  },
  {
    order_index: 16,
    name: 'Danh lượng từ chỉ cây cỏ thực vật "棵" (Cây / Gốc)',
    pattern: 'Số từ + 棵 + Danh từ (树 / 草 / 白菜 / 牡丹)',
    category: 'Lượng từ',
    explanation_vi: '"棵" (kē) là lượng từ chuyên dùng cho cây cối, thực vật mọc từ đất lên (khác với "颗" dùng cho vật nhỏ tròn dạng hạt/viên).',
    examples: [
      {
        chinese: '我们学校图书馆门前种着一棵百年的古老银杏树。',
        pinyin: 'Wǒmen xuéxiào túshūguǎn ménqián zhòngzhe yì kē bǎinián de gǔlǎo yínxìngshù.',
        translation_vi: 'Trước cửa thư viện trường chúng tôi có trồng một cây ngân hạnh cổ thụ trăm năm tuổi.',
        explanation: '"一棵...银杏树" dùng "棵" (bộ Mộc 木) làm lượng từ chỉ cây đại thụ.'
      },
      {
        chinese: '爷爷在院子里亲手种了几棵绿色的蔬菜。',
        pinyin: 'Yéye zài yuànzi lǐ qīnshǒu zhòng le jǐ kē lǜsè de shūcài.',
        translation_vi: 'Ông nội đã tự tay trồng mấy luống cây rau xanh trong sân nhà.',
        explanation: '"几棵...蔬菜" chỉ các cây rau xanh đơn lẻ mọc trong vườn.'
      }
    ]
  },
  {
    order_index: 17,
    name: 'Danh lượng từ chỉ giọt chất lỏng "滴" (Giọt)',
    pattern: 'Số từ + 滴 + Danh từ (水 / 眼泪 / 汗 / 汗水 / 油 / 血)',
    category: 'Lượng từ',
    explanation_vi: '"滴" (dī) biểu thị đơn vị giọt của chất lỏng. Ngoài ra "滴" cũng có thể đóng vai trò làm động từ mang nghĩa nhỏ giọt (滴水). Khi dùng làm lượng từ, "一滴" thường được dùng để nhấn mạnh số lượng nhỏ bé, quý giá.',
    examples: [
      {
        chinese: '在干旱的沙漠里，每一滴水都显得无比珍贵。',
        pinyin: 'Zài gānhàn de shāmò lǐ, měi yì dī shuǐ dōu xiǎnde wúbǐ zhēnguì.',
        translation_vi: 'Ở nơi sa mạc khô hạn, từng giọt nước đều trở nên vô cùng quý giá.',
        explanation: '"每一滴水" dùng "滴" làm lượng từ biểu thị từng giọt nước nhỏ nhoi.'
      },
      {
        chinese: '看到儿子顺利考上理想的大学，母亲流下了激动的眼泪。',
        pinyin: 'Kàndào érzi shùnlì kǎoshàng lǐxiǎng de dàxué, mǔqīn liúxià le jīdòng de yǎnlèi.',
        translation_vi: 'Nhìn thấy con trai thi đỗ vào trường đại học mơ ước, người mẹ đã rơi những giọt nước mắt xúc động.',
        explanation: '"滴" kết hợp cùng "眼泪" diễn tả giọt lệ xúc động trong tình huống gia đình sum vầy.'
      }
    ]
  },
  {
    order_index: 18,
    name: 'Danh lượng từ chỉ bầy, đàn, đám "群" (Bầy / Đàn / Đám / Nhóm)',
    pattern: 'Số từ / 一 + 群 + Danh từ (人 / 孩子 / 羊 / 鸟 / 鸭子)',
    category: 'Lượng từ',
    explanation_vi: '"群" (qún) là lượng từ tập hợp dùng cho một nhóm đông người tụ họp lại, hoặc một đàn động vật/chim chóc cùng di chuyển hoặc sinh sống cùng nhau.',
    examples: [
      {
        chinese: '放学后，一群活泼可爱的小学生唱着歌走出了校门。',
        pinyin: 'Fàngxué hòu, yì qún huópo kě\'ài de xiǎoxuéshēng chàngzhe gē zǒuchū le xiàomén.',
        translation_vi: 'Sau khi tan học, một nhóm học sinh tiểu học hồn nhiên đáng yêu vừa hát vừa bước ra cổng trường.',
        explanation: '"一群...小学生" chỉ một nhóm đông các em học sinh đi cùng nhau.'
      },
      {
        chinese: '在辽阔的草原上，有一大群羊正在安详地吃草。',
        pinyin: 'Zài liáokuò de cǎoyuán shang, yǒu yí dà qún yáng zhèngzài ānxiáng de chī cǎo.',
        translation_vi: 'Trên thảo nguyên bao la, có một đàn cừu lớn đang thong thả gặm cỏ.',
        explanation: '"一大群羊" diễn tả số lượng bầy cừu đông đảo trên đồng cỏ.'
      }
    ]
  },
  {
    order_index: 19,
    name: 'Danh lượng từ chỉ đống, chồng bừa bộn "堆" (Đống / Chồng)',
    pattern: 'Số từ / 一 + 堆 + Danh từ (书 / 垃圾 / 衣服 / 问题 / 事情)',
    category: 'Lượng từ',
    explanation_vi: '"堆" (duī) biểu thị số lượng nhiều sự vật chất chồng lên nhau thành đống. Ngoài việc chỉ các vật thể cụ thể (như sách vở, quần áo, rác), "堆" còn dùng cho các sự việc trừu tượng (như 一堆问题, 一堆麻烦) với sắc thái bận rộn hoặc bừa bộn.',
    examples: [
      {
        chinese: '桌子上堆满了各种文件，还有一大堆待处理的工作。',
        pinyin: 'Zhuōzi shang duīmǎn le gè zhǒng wénjiàn, hái yǒu yí dà duī dài chǔlǐ de gōngzuò.',
        translation_vi: 'Trên bàn chất đầy đủ loại tài liệu, và còn có một đống công việc đang chờ xử lý.',
        explanation: '"一大堆待处理的工作" dùng "堆" ẩn dụ cho khối lượng công việc bề bộn dồn lại.'
      },
      {
        chinese: '请大家把生活垃圾分类放好，不要在楼道里扔一堆垃圾。',
        pinyin: 'Qǐng dàjiā bǎ shēnghuó lājī fēnlèi fàng hǎo, bú yào zài lóudào lǐ rēng yì duī lājī.',
        translation_vi: 'Xin mọi người hãy phân loại rác sinh hoạt cẩn thận, không nên vứt một đống rác ở hành lang.',
        explanation: '"一堆垃圾" chỉ đống rác thực tế bừa bãi chưa qua xử lý.'
      }
    ]
  },
  {
    order_index: 20,
    name: 'Danh lượng từ chỉ hàng, dãy "排" (Hàng / Dãy)',
    pattern: 'Số từ + 排 + Danh từ (座位 / 树 / 房子 / 队伍)',
    category: 'Lượng từ',
    explanation_vi: '"排" (pái) dùng cho người hoặc đồ vật được sắp xếp ngay ngắn theo một đường thẳng ngang hoặc dọc (như hàng ghế, hàng cây, dãy nhà, hàng người).',
    examples: [
      {
        chinese: '电影马上就要开场了，请大家按照票号找到第三排的座位。',
        pinyin: 'Diànyǐng mǎshàng jiù yào kāichǎng le, qǐng dàjiā ànzhào piàohào zhǎodào dì sān pái de zuòwèi.',
        translation_vi: 'Bộ phim sắp sửa bắt đầu rồi, xin mọi người hãy đối chiếu số vé để tìm chỗ ngồi ở hàng thứ ba.',
        explanation: '"第三排的座位" dùng "排" xác định chính xác hàng ghế trong rạp chiếu phim.'
      },
      {
        chinese: '马路两旁种着两排整齐的白杨树，风景十分优美。',
        pinyin: 'Mǎlù liǎngpáng zhòngzhe liǎng pái zhěngqí de báiyángshù, fēngjǐng shífēn yōuměi.',
        translation_vi: 'Hai bên đường có trồng hai hàng cây bạch dương ngay ngắn, phong cảnh rất tươi đẹp.',
        explanation: '"两排整齐的白杨树" dùng "排" để miêu tả các hàng cây thẳng tắp ven đường.'
      }
    ]
  },
  {
    order_index: 21,
    name: 'Phó từ truy cứu đến cùng "究竟" (Rốt cuộc / Cuối cùng thì)',
    pattern: 'Chủ ngữ + 究竟 + Từ để hỏi / V_chính + 不 + V_chính / 究竟 + Sự thật/Nguyên nhân',
    category: 'Phó từ',
    explanation_vi: '"究竟" (jiūjìng) dùng trong câu hỏi (câu hỏi có đại từ nghi vấn, câu hỏi chính phản hoặc lựa chọn) để tăng cường ngữ khí truy cứu, muốn tìm hiểu rõ chân tướng sự việc (rốt cuộc là sao). Ngoài ra, "究竟" trong câu trần thuật còn có nghĩa là "cuối cùng/rốt cuộc thì" (tương đương với 到头来, 到底). So với "到底", "究竟" trang trọng hơn và thường gặp trong văn viết.',
    examples: [
      {
        chinese: '关于那个神秘的项目，你究竟打听到了什么消息？',
        pinyin: 'Guānyú nà ge shénmì de xiàngmù, nǐ jiūjìng dǎtīng dào le shénme xiāoxi?',
        translation_vi: 'Liên quan đến dự án bí ẩn đó, rốt cuộc anh đã dò hỏi được tin tức gì rồi?',
        explanation: '"究竟" đứng trước động từ trong câu hỏi có "什么" để nhấn mạnh sự truy hỏi đến cùng tin tức.'
      },
      {
        chinese: '面对这个问题，大家都很想知道究竟谁能够给出合理的答案。',
        pinyin: 'Miànduì zhè ge wèntí, dàjiā dōu hěn xiǎng zhīdào jiūjìng shéi nénggòu gěichū hélǐ de dá\'àn.',
        translation_vi: 'Đối mặt với vấn đề này, mọi người đều rất muốn biết rốt cuộc ai có thể đưa ra đáp án thỏa đáng.',
        explanation: '"究竟谁" làm rõ chủ thể giải quyết vấn đề, biểu thị tâm lý tò mò muốn biết rõ sự thật.'
      }
    ]
  },
  {
    order_index: 22,
    name: 'Phó từ kết quả và nhấn mạnh ngữ khí "到底" (Rốt cuộc / Suy cho cùng / Đến cùng)',
    pattern: 'Chủ ngữ + 到底 + Câu hỏi / 坚持 + 到底 / 到底 + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"到底" (dàodǐ) có ba cách dùng chính: 1) Trong câu hỏi biểu thị sự truy vấn rốt cuộc (khẩu ngữ dùng nhiều hơn 究竟); 2) Biểu thị làm một việc đến cùng không từ bỏ (như 坚持到底, 进行到底); 3) Trong câu trần thuật biểu thị nguyên nhân sâu xa hoặc bản chất thực sự (suy cho cùng thì: 他到底是孩子, 难免会犯错).',
    examples: [
      {
        chinese: '你不要再犹豫了，今天到底去还是不去？',
        pinyin: 'Nǐ bú yào zài yóuyù le, jīntiān dàodǐ qù háishì bú qù?',
        translation_vi: 'Cậu đừng do dự nữa, hôm nay rốt cuộc là đi hay không đi?',
        explanation: '"到底" đặt trong câu hỏi lựa chọn "去还是不去" để thúc giục đối phương đưa ra quyết định dứt khoát.'
      },
      {
        chinese: '遇到困难时只要坚持到底，最终就一定会取得胜利。',
        pinyin: 'Yùdào kùnnan shí zhǐyào jiānchí dàodǐ, zuìzhōng jiù yídìng huì qǔdé shènglì.',
        translation_vi: 'Khi gặp khó khăn chỉ cần kiên trì đến cùng, cuối cùng nhất định sẽ giành được thắng lợi.',
        explanation: '"坚持到底" là kết hợp quán dụng biểu thị hành động kiên trì tới bước cuối cùng.'
      }
    ]
  },
  {
    order_index: 23,
    name: 'Phó từ phóng đại và nhấn mạnh cảm xúc "简直" (Quả là / Thật là / Hầu như)',
    pattern: 'Chủ ngữ + 简直 + (像/是/无法/太) + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"简直" (jiǎnzhí) dùng để nhấn mạnh một trạng thái, mức độ đạt đến mức kinh ngạc, gần như hoàn toàn như vậy (thực sự là, quả thật là). Thường đi kèm với ngữ khí phóng đại để bày tỏ sự tán thưởng, ngạc nhiên hoặc bất bình.',
    examples: [
      {
        chinese: '仅仅用了半年时间他就掌握了汉语，这简直是一个奇迹。',
        pinyin: 'Jǐnjǐn yòng le bàn nián shíjiān tā jiù zhǎowò le hànyǔ, zhè jiǎnzhí shì yí gè qíjì.',
        translation_vi: 'Chỉ mất nửa năm anh ấy đã nắm vững tiếng Trung, điều này quả thực là một kỳ tích.',
        explanation: '"简直是一个奇迹" phóng đại và khen ngợi năng lực tiếp thu ngoại ngữ phi thường.'
      },
      {
        chinese: '外面的天气太冷了，刺骨的寒风吹在脸上简直像刀割一样。',
        pinyin: 'Wàimiàn de tiānqì tài lěng le, cìgǔ de hánfēng chuī zài liǎn shang jiǎnzhí xiàng dāo gē yíyàng.',
        translation_vi: 'Thời tiết bên ngoài quá lạnh, gió lạnh thấu xương thổi vào mặt quả thật như dao cắt.',
        explanation: '"简直像...一样" dùng "简直" kết hợp so sánh ví von để cực tả cảm giác buốt giá.'
      }
    ]
  },
  {
    order_index: 24,
    name: 'Phó từ tỉnh ngộ và lý giải nguyên do "难怪" (Hèn chi / Thảo nào)',
    pattern: '难怪 + Mệnh đề / Mệnh đề kết quả, 难怪 + Mệnh đề nguyên nhân',
    category: 'Phó từ',
    explanation_vi: '"难怪" (nánguài) dùng khi người nói đột nhiên hiểu ra nguyên nhân thực sự của một hiện tượng hoặc kết quả nào đó sau khi biết được tình huống mới (thảo nào, hèn gì, chẳng trách). Có thể dùng đứng đầu câu hoặc giữa hai vế câu.',
    examples: [
      {
        chinese: '原来他在北京留学生活了五年，难怪普通话说得这么地道。',
        pinyin: 'Yuánlái tā zài Běijīng liúxué shēnghuó le wǔ nián, nánguài pǔtōnghuà shuō de zhème dìdao.',
        translation_vi: 'Thì ra anh ấy đã du học và sống ở Bắc Kinh 5 năm, hèn chi tiếng Phổ thông nói chuẩn như người bản xứ.',
        explanation: '"难怪" đứng ở vế sau để bày tỏ sự vỡ lẽ khi biết lý do đối phương nói tiếng Trung xuất sắc.'
      },
      {
        chinese: '今天气温骤降了十度，难怪大家都穿上了厚羽绒服。',
        pinyin: 'Jīntiān qìwēn zhòujiàng le shí dù, nánguài dàjiā dōu chuānshàng le hòu yǔróngfú.',
        translation_vi: 'Hôm nay nhiệt độ đột ngột giảm 10 độ, thảo nào ai nấy đều mặc áo phao dày cộm.',
        explanation: '"难怪" giải thích lý do mọi người đột ngột thay đổi trang phục vì thời tiết chuyển rét đậm.'
      }
    ]
  },
  {
    order_index: 25,
    name: 'Phó từ đồng nghĩa khẩu ngữ "怪不得" (Hèn chi / Thảo nào / Chẳng trách)',
    pattern: '怪不得 + Mệnh đề / Mệnh đề 1, 怪不得 + Mệnh đề 2',
    category: 'Phó từ',
    explanation_vi: '"怪不得" (guàibude) là dạng khẩu ngữ phổ biến đồng nghĩa với "难怪", biểu thị sự ngộ ra nguyên nhân sau khi biết được sự thật (thảo nào, chả trách). Ngoài ra "怪不得" còn có cách dùng làm vị ngữ với nghĩa là không thể trách cứ được (như 这件事怪不得他 - Việc này không thể trách anh ấy được).',
    examples: [
      {
        chinese: '听说这家餐厅的主厨曾在国外拿过大奖，怪不得每天都有那么多人排队。',
        pinyin: 'Tīngshuō zhè jiā cāntīng de zhǔchú céng zài guówài náguo dàjiǎng, guàibude měitiān dōu yǒu nàme duō rén páiduì.',
        translation_vi: 'Nghe nói bếp trưởng của nhà hàng này từng đoạt giải lớn ở nước ngoài, thảo nào ngày nào cũng có bao nhiêu người xếp hàng.',
        explanation: '"怪不得" giải thích nguyên nhân nhà hàng luôn đông khách là do tay nghề nổi tiếng của bếp trưởng.'
      },
      {
        chinese: '你昨晚熬夜看了整通宵的球赛，怪不得今天上课一直打瞌睡。',
        pinyin: 'Nǐ zuówǎn áoyè kàn le zhěng tōngxiāo de qiúsài, guàibude jīntiān shàngkè yìzhí dǎ kēshuì.',
        translation_vi: 'Tối qua cậu thức trắng đêm xem bóng đá, hèn chi hôm nay trong giờ học cứ ngủ gật suốt.',
        explanation: '"怪不得" vạch rõ mối liên hệ giữa việc thức khuya và tình trạng mệt mỏi ban ngày.'
      }
    ]
  },
  {
    order_index: 26,
    name: 'Phó từ tiện thể làm thêm việc "顺便" (Nhân tiện / Tiện thể)',
    pattern: 'Chủ ngữ + 顺便 + Động từ + Tân ngữ',
    category: 'Phó từ',
    explanation_vi: '"顺便" (shùnbiàn) biểu thị trong quá trình thực hiện một hành động chính nào đó, người nói nhân tiện hoặc tiện đường làm thêm một việc phụ khác mà không tốn thêm nhiều thời gian hay công sức.',
    examples: [
      {
        chinese: '你下楼去超市买水果的时候，顺便帮我取一下快递吧。',
        pinyin: 'Nǐ xiàlóu qù chāoshì mǎi shuǐguǒ de shíhou, shùnbiàn bāng wǒ qǔ yíxià kuàidì ba.',
        translation_vi: 'Khi cậu xuống tầng đi siêu thị mua hoa quả, tiện thể lấy giúp mình gói bưu phẩm nhé.',
        explanation: '"顺便" kết hợp trước hành động phụ "帮我取快递" khi thực hiện việc chính đi mua hoa quả.'
      },
      {
        chinese: '李经理去广州出差，顺便拜访了几位多年合作的老客户。',
        pinyin: 'Lǐ jīnglǐ qù Guǎngzhōu chūchāi, shùnbiàn bàifǎng le jǐ wèi duō nián hézuò de lǎo kèhù.',
        translation_vi: 'Giám đốc Lý đi Quảng Châu công tác, nhân tiện đã ghé thăm mấy vị khách hàng cũ hợp tác lâu năm.',
        explanation: '"顺便拜访" diễn tả hành động ghé thăm được kết hợp khéo léo trong chuyến đi công tác.'
      }
    ]
  }
];
