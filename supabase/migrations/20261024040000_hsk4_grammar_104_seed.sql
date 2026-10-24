-- ==============================================================================
-- MIGRATION: 20261024040000_hsk4_grammar_104_seed.sql
-- NẠP 104 ĐIỂM NGỮ PHÁP HSK 4 KÈM 208 CÂU VÍ DỤ CHUẨN GF 0025-2021 (APPENDIX A)
-- Có giải thích chi tiết tiếng Việt, công thức pattern, Pinyin có dấu thanh và phân loại chuẩn
-- ==============================================================================

BEGIN;

DO $$
DECLARE
  v_gp_id uuid;
BEGIN

  -- Điểm ngữ pháp #1: Đại từ phân phối "各" (Từng / Mỗi / Các)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ phân phối "各" (Từng / Mỗi / Các)',
    '各 + Danh từ / Lượng từ + Danh từ',
    'Đại từ',
    '"各" (gè) biểu thị từng cá thể riêng biệt trong một tổng thể hoặc các phương diện, các bên khác nhau. "各" có thể trực tiếp kết hợp với danh từ song âm tiết (như 各国, 各地, 各界) hoặc đi kèm lượng từ trước danh từ đơn âm tiết (各个, 各门). Khác với "每" nhấn mạnh tính đồng nhất của mọi cá thể, "各" nhấn mạnh tính độc lập, riêng rẽ của từng đối tượng.',
    'HSK 4',
    1,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '代表们来自世界各国，共同探讨环境保护问题。',
      'Dàibiǎomen láizì shìjiè gèguó, gòngtóng tàntǎo huánjìng bǎohù wèntí.',
      'Các đại biểu đến từ các quốc gia trên thế giới, cùng nhau thảo luận về vấn đề bảo vệ môi trường.',
      '"各" trực tiếp đứng trước danh từ song âm tiết "国" (quốc gia) tạo thành "各国" chỉ từng quốc gia khác nhau trên thế giới.'
    ),
    (
      v_gp_id,
      '每个人都有自己的优点，各有各的长处。',
      'Měi gè rén dōu yǒu zìjǐ de yōudiǎn, gè yǒu gè de chángchù.',
      'Mỗi người đều có ưu điểm riêng, ai cũng có sở trường của riêng mình.',
      'Cấu trúc "各有各的 + Danh từ" là cách dùng khẩu ngữ cố định biểu thị mỗi người/mỗi bên đều có phần riêng của mình.'
    );

  -- Điểm ngữ pháp #2: Đại từ phiếm chỉ không xác định "某" (Nào đó / Ai đó / Chỗ nào đó)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ phiếm chỉ không xác định "某" (Nào đó / Ai đó / Chỗ nào đó)',
    '某 + Lượng từ + Danh từ / 某人 / 某地 / 某事',
    'Đại từ',
    '"某" (mǒu) dùng để chỉ người, sự vật, thời gian hoặc nơi chốn chưa xác định rõ hoặc không tiện nêu đích danh cụ thể. Khi đi với danh từ đơn âm tiết hoặc song âm tiết, thường dùng "某 + Lượng từ + Danh từ" (như 某种原因, 某一天) hoặc ghép thẳng (某人, 某市, 某校).',
    'HSK 4',
    2,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '由于某种特殊原因，明天的会议需要推迟举行。',
      'Yóuyú mǒu zhǒng tèshū yuányīn, míngtiān de huìyì xūyào tuīchí jǔxíng.',
      'Do một nguyên nhân đặc biệt nào đó, cuộc họp ngày mai cần phải hoãn lại.',
      '"某" kết hợp với lượng từ "种" và danh từ "原因" để chỉ lý do không tiện nói rõ tên cụ thể.'
    ),
    (
      v_gp_id,
      '这篇小说的主要故事发生在北方的某座城市。',
      'Zhè piān xiǎoshuō de zhǔyào gùshì fāshēng zài běifāng de mǒu zuò chéngshì.',
      'Câu chuyện chính của cuốn tiểu thuyết này xảy ra ở một thành phố nào đó ở miền Bắc.',
      '"某座城市" biểu thị một thành phố phiếm chỉ, tác giả không muốn chỉ đích danh địa danh.'
    );

  -- Điểm ngữ pháp #3: Đại từ chỉ thị "本" chỉ bản thân hoặc hiện tại (Này / Bản...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ chỉ thị "本" chỉ bản thân hoặc hiện tại (Này / Bản...)',
    '本 + Danh từ (本人 / 本地 / 本市 / 本课 / 本报)',
    'Đại từ',
    '"本" (běn) trong văn viết hoặc phong cách trang trọng đóng vai trò như đại từ chỉ thị tương đương với "这" (này) hoặc "自己" (bản thân). Thường kết hợp trực tiếp với danh từ đơn âm tiết hoặc song âm tiết như 本人 (bản thân tôi/đương sự), 本地 (địa phương này), 本世纪 (thế kỷ này), 本文 (bài viết này).',
    'HSK 4',
    3,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这项优惠活动仅对本校学生和教职工有效。',
      'Zhè xiàng yōuhuì huódòng jǐn duì běnxiào xuésheng hé jiàozhígōng yǒuxiào.',
      'Chương trình ưu đãi này chỉ có hiệu lực đối với học sinh và cán bộ giảng viên của trường này.',
      '"本校" có nghĩa là trường này (ngôi trường của người nói/người viết), mang sắc thái trang trọng.'
    ),
    (
      v_gp_id,
      '如果需要办理签证，必须由申请人本人亲自到场。',
      'Rúguǒ xūyào bànlǐ qiānzhèng, bìxū yóu shēnqǐngrén běnrén qīnzì dàochǎng.',
      'Nếu cần làm thủ tục xin thị thực, bắt buộc đích thân đương sự phải có mặt.',
      '"本人" nhấn mạnh chính bản thân người nộp đơn, không thể ủy quyền cho người khác.'
    );

  -- Điểm ngữ pháp #4: Đại từ hỗ tương "彼此" (Lẫn nhau / Đôi bên / Cả hai)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ hỗ tương "彼此" (Lẫn nhau / Đôi bên / Cả hai)',
    'Chủ ngữ (số nhiều) + 彼此 + Động từ / 彼此的 + Danh từ / 彼此彼此',
    'Đại từ',
    '"彼此" (bǐcǐ) biểu thị quan hệ qua lại giữa hai hoặc nhiều bên đối tác (cả hai phía, lẫn nhau). Thường làm chủ ngữ, tân ngữ, định ngữ hoặc trạng ngữ. Trong giao tiếp lịch sự, nói "彼此彼此" mang hàm ý khiêm tốn đáp lại lời khen ngợi (hai bên đều như nhau cả thôi).',
    'HSK 4',
    4,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '朋友之间应该互相尊重，理解彼此的想法。',
      'Péngyou zhījiān yīnggāi hùxiāng zūnzhòng, lǐjiě bǐcǐ de xiǎngfǎ.',
      'Bạn bè với nhau nên tôn trọng lẫn nhau, thấu hiểu suy nghĩ của nhau.',
      '"彼此的想法" nghĩa là ý nghĩ của đôi bên, "彼此" đứng làm định ngữ hạn định cho "想法".'
    ),
    (
      v_gp_id,
      '他们多年不见，但彼此依然十分信任。',
      'Tāmen duō nián bú jiàn, dàn bǐcǐ yīrán shífēn xìnrèn.',
      'Họ nhiều năm không gặp, nhưng đôi bên vẫn hết sức tin tưởng lẫn nhau.',
      '"彼此" làm trạng ngữ đứng trước động từ "信任" để biểu thị sự tin tưởng hai chiều.'
    );

  -- Điểm ngữ pháp #5: Đại từ phiếm chỉ toàn thể vô điều kiện "任何" (Bất kỳ / Bất luận)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ phiếm chỉ toàn thể vô điều kiện "任何" (Bất kỳ / Bất luận)',
    '任何 + (Lượng từ) + Danh từ + 都 / 也',
    'Đại từ',
    '"任何" (rènhé) là đại từ phiếm chỉ mang nghĩa không phân biệt đối tượng nào, bất kể sự vật hay con người nào trong phạm vi thảo luận. Thường kết hợp với "都" hoặc "也" ở vế sau để nhấn mạnh tính phổ quát tuyệt đối.',
    'HSK 4',
    5,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '无论面对任何困难，我们都不应该轻易放弃。',
      'Wúlùn miànduì rènhé kùnnan, wǒmen dōu bù yīnggāi qīngyì fàngqì.',
      'Bất luận đối mặt với bất kỳ khó khăn nào, chúng ta cũng không nên dễ dàng bỏ cuộc.',
      '"任何困难" (bất kỳ khó khăn nào) kết hợp với "无论...都..." khẳng định quyết tâm kiên trì không có ngoại lệ.'
    ),
    (
      v_gp_id,
      '在法律面前，没有任何人享有特权。',
      'Zài fǎlǜ miànqián, méiyǒu rènhé rén xiǎngyǒu tèquán.',
      'Trước pháp luật, không có bất kỳ ai được hưởng đặc quyền.',
      '"没有任何人" phủ định hoàn toàn sự tồn tại của bất kỳ đối tượng ngoại lệ nào.'
    );

  -- Điểm ngữ pháp #6: Đại từ bao quát toàn bộ "一切" (Tất cả / Toàn bộ mọi thứ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ bao quát toàn bộ "一切" (Tất cả / Toàn bộ mọi thứ)',
    '一切 + Danh từ / Danh từ + (的) 一切 / 一切 + 都...',
    'Đại từ',
    '"一切" (yíqiè) là đại từ chỉ toàn bộ sự vật, hiện tượng hoặc phương diện (mọi thứ, tất cả). "一切" có thể làm chủ ngữ đứng độc lập, làm định ngữ (一切困难, 一切费用) hoặc làm tân ngữ (安排好了一切). Khác với "所有", "一切" thiên về tính chất trừu tượng và toàn diện.',
    'HSK 4',
    6,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请大家放心，我们已经为这次活动准备好了一切。',
      'Qǐng dàjiā fàngxīn, wǒmen yǐjīng wèi zhè cì huódòng zhǔnbèi hǎo le yíqiè.',
      'Xin mọi người hãy yên tâm, chúng tôi đã chuẩn bị xong xuôi mọi thứ cho sự kiện lần này.',
      '"一切" làm tân ngữ cho cụm động từ "准备好", bao gồm tất cả các khâu chuẩn bị cần thiết.'
    ),
    (
      v_gp_id,
      '为了孩子的健康成长，父母愿意付出自己的一切。',
      'Wèile háizi de jiànkāng chéngzhǎng, fùmǔ yuànyì fùchū zìjǐ de yíqiè.',
      'Vì sự trưởng thành khỏe mạnh của con cái, cha mẹ sẵn lòng hy sinh tất cả của bản thân.',
      '"自己的一切" là cụm định tâm thể hiện toàn bộ công sức, thời gian và tình cảm của cha mẹ.'
    );

  -- Điểm ngữ pháp #7: Đại từ phản thân tự thân "自身" (Bản thân / Chính mình)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ phản thân tự thân "自身" (Bản thân / Chính mình)',
    '自身 + Danh từ / Động từ + 自身 / Chủ ngữ + 自身',
    'Đại từ',
    '"自身" (zìshēn) là đại từ chỉ bản thân chủ thể hoặc phẩm chất nội tại của một sự vật, cơ quan, tổ chức. So với "自己", "自身" mang sắc thái văn viết trang trọng hơn, thường dùng khi phân tích năng lực nội tại, sự phát triển hoặc nhược điểm của sự vật.',
    'HSK 4',
    7,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '企业要想在竞争中立足，必须不断提高自身的产品质量。',
      'Qǐyè yào xiǎng zài jìngzhēng zhōng lìzú, bìxū búduàn tígāo zìshēn de chǎnpǐn zhìliàng.',
      'Doanh nghiệp muốn đứng vững trong cạnh tranh, bắt buộc phải không ngừng nâng cao chất lượng sản phẩm của chính mình.',
      '"自身的产品质量" nhấn mạnh năng lực và chất lượng nội tại xuất phát từ chính doanh nghiệp.'
    ),
    (
      v_gp_id,
      '很多时候，我们最大的敌人其实正是我们自身。',
      'Hěn duō shíhou, wǒmen zuì dà de dírén qíshí zhèng shì wǒmen zìshēn.',
      'Rất nhiều khi, kẻ thù lớn nhất của chúng ta trên thực tế chính là bản thân chúng ta.',
      '"自身" ở đây nhấn mạnh sự tự nhận thức và khắc phục nhược điểm của chính bản thân con người.'
    );

  -- Điểm ngữ pháp #8: Biểu thị phân số và phần trăm với "百分之..." / "...分之..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Biểu thị phân số và phần trăm với "百分之..." / "...分之..."',
    'Mẫu số + 分之 + Tử số (百分之八十 / 三分之二)',
    'Số từ',
    'Trong tiếng Trung, quy tắc biểu thị phân số và tỉ lệ phần trăm tuân thủ nguyên tắc: đọc mẫu số trước rồi đến "分之" (fēn zhī), sau đó mới đọc tử số. Ví dụ: 1/3 đọc là "三分之一", 85% đọc là "百分之八十五".',
    'HSK 4',
    8,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '调查显示，有百分之七十的年轻人习惯在网上购物。',
      'Diàochá xiǎnshì, yǒu bǎi fēn zhī qīshí de niánqīngrén xíguàn zài wǎngshang gòuwù.',
      'Khảo sát cho thấy có 70% người trẻ tuổi có thói quen mua sắm trực tuyến.',
      '"百分之七十" (70%) là cấu trúc chuẩn để biểu đạt tỷ lệ phần trăm trong tiếng Trung hiện đại.'
    ),
    (
      v_gp_id,
      '这本厚书我已经读了三分之二，内容非常精彩。',
      'Zhè běn hòu shū wǒ yǐjīng dú le sān fēn zhī èr, nèiróng fēicháng jīngcǎi.',
      'Cuốn sách dày này tôi đã đọc được hai phần ba rồi, nội dung vô cùng hấp dẫn.',
      '"三分之二" (2/3) thể hiện tiến độ đọc sách, trong đó mẫu số là 3 (三) và tử số là 2 (二).'
    );

  -- Điểm ngữ pháp #9: Biểu thị bội số với "倍" (Lần / Gấp... lần)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Biểu thị bội số với "倍" (Lần / Gấp... lần)',
    'A 是 B 的 + Số từ + 倍 / A 比 B + Tăng/Giảm + Số từ + 倍',
    'Số từ',
    '"倍" (bèi) biểu thị số lần gấp lên của một đại lượng so với một đại lượng khác. Lưu ý: Tiếng Trung chỉ dùng "倍" cho sự tăng trưởng (tăng gấp bội), không dùng "倍" cho sự giảm bớt (khi giảm phải dùng phân số hoặc phần trăm). Khi nói "A 是 B 的两倍" nghĩa là A = 2B; còn "A 比 B 增加了一倍" cũng có nghĩa là A = 2B.',
    'HSK 4',
    9,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今年公司的营业额是去年的三倍，成绩十分显著。',
      'Jīnnián gōngsī de yíngyè''é shì qùnián de sān bèi, chéngjì shífēn xiǎnzhù.',
      'Doanh thu năm nay của công ty gấp 3 lần năm ngoái, thành tích rất nổi bật.',
      'Cấu trúc so sánh bội số "A 是 B 的三倍" biểu thị doanh số năm nay bằng 3 lần doanh số năm ngoái.'
    ),
    (
      v_gp_id,
      '采用了新技术后，工厂的生产效率提高了一倍。',
      'Cǎiyòng le xīn jìshù hòu, gōngchǎng de shēngchǎn xiàolǜ tígāo le yí bèi.',
      'Sau khi áp dụng kỹ thuật mới, hiệu suất sản xuất của nhà máy đã tăng lên gấp đôi.',
      '"提高了一倍" nghĩa là hiệu suất tăng thêm 100%, tức đạt mức gấp 2 lần ban đầu.'
    );

  -- Điểm ngữ pháp #10: Động lượng từ chỉ chuyến đi khứ hồi "趟" (Chuyến / Lượt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động lượng từ chỉ chuyến đi khứ hồi "趟" (Chuyến / Lượt)',
    'Động từ (去/来/跑/走) + (Số từ) + 趟',
    'Lượng từ',
    '"趟" (tàng) là động lượng từ chuyên dùng cho các hành động đi lại di chuyển khứ hồi (đi rồi về) hoặc chuyến xe/tàu. Khác với "次" (chỉ số lần phát sinh chung của mọi hành vi), "趟" bắt buộc gắn liền với hành động dịch chuyển vị trí thực tế của con người hoặc phương tiện giao thông.',
    'HSK 4',
    10,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '为了办理护照，他昨天特意去了一趟出入境管理局。',
      'Wèile bànlǐ hùzhào, tā zuótiān tèyì qù le yí tàng chūrùjìng guǎnlǐjú.',
      'Để làm hộ chiếu, hôm qua anh ấy đã đặc biệt đi đến Cục Quản lý Xuất Nhập cảnh một chuyến.',
      '"去了一趟" chỉ chuyến đi đến cơ quan nhà nước giải quyết thủ tục rồi quay về.'
    ),
    (
      v_gp_id,
      '我们明天清晨坐最早一趟高铁去上海出差。',
      'Wǒmen míngtiān qīngchén zuò zuì zǎo yí tàng gāotiě qù Shànghǎi chūchāi.',
      'Sáng sớm mai chúng tôi sẽ đi chuyến tàu cao tốc sớm nhất để đến Thượng Hải công tác.',
      '"一趟高铁" dùng "趟" làm danh lượng từ để chỉ chuyến tàu vận tải hành khách.'
    );

  -- Điểm ngữ pháp #11: Danh lượng từ chuyên dùng cho bài viết, văn kiện "篇" (Bài / Thiên)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chuyên dùng cho bài viết, văn kiện "篇" (Bài / Thiên)',
    'Số từ + 篇 + Danh từ (文章 / 论文 / 报道 / 日记 / 课文)',
    'Lượng từ',
    '"篇" (piān) là lượng từ chuyên dụng dành cho các tác phẩm văn học, bài văn, bài báo, luận văn hoặc bài phát biểu hoàn chỉnh bằng chữ viết.',
    'HSK 4',
    11,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经过一个星期的努力，王教授终于完成了那篇学术论文。',
      'Jīngguò yí gè xīngqī de nǔlì, Wáng jiàoshòu zhōngyú wánchéng le nà piān xuéshù lùnwén.',
      'Sau một tuần nỗ lực, giáo sư Vương cuối cùng đã hoàn thành bài luận văn học thuật đó.',
      '"篇" làm lượng từ chuẩn đi kèm với danh từ học thuật "论文" (luận văn).'
    ),
    (
      v_gp_id,
      '今天的报纸上刊登了一篇关于人工智能发展的特别报道。',
      'Jīntiān de bàozhǐ shang kāndēng le yì piān guānyú réngōng zhìnéng fāzhǎn de tèbié bàodào.',
      'Trên tờ báo hôm nay có đăng một bài phóng sự đặc biệt về sự phát triển của trí tuệ nhân tạo.',
      '"一篇...报道" dùng "篇" định lượng cho bài tin tức/phóng sự hoàn chỉnh trên báo in.'
    );

  -- Điểm ngữ pháp #12: Danh lượng từ chỉ phần, bản, suất "份" (Phần / Bản / Suất)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ phần, bản, suất "份" (Phần / Bản / Suất)',
    'Số từ + 份 + Danh từ (报纸 / 礼物 / 工作 / 菜单 / 文件 / 早餐)',
    'Lượng từ',
    '"份" (fèn) biểu thị một phần được chia ra từ một tổng thể, một ấn phẩm định kỳ (như báo chí), một tài liệu hành chính, một suất ăn hoặc một công việc/tình cảm mang tính chất trao tặng.',
    'HSK 4',
    12,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '毕业之后，他凭借优秀的专业能力顺利找到了一份满意的工作。',
      'Bìyè zhīhòu, tā píngjiè yōuxiù de zhuānyè nénglì shùnlì zhǎodào le yí fèn mǎnyì de gōngzuò.',
      'Sau khi tốt nghiệp, nhờ năng lực chuyên môn xuất sắc anh ấy đã thuận lợi tìm được một công việc ưng ý.',
      '"一份工作" là cách dùng lượng từ "份" kết hợp chuẩn xác với "工作" (công việc).'
    ),
    (
      v_gp_id,
      '服务员，请给我们拿一份菜单和两份特色早餐。',
      'Fúwùyuán, qǐng gěi wǒmen ná yí fèn càidān hé liǎng fèn tèsè zǎocān.',
      'Phục vụ ơi, xin hãy lấy cho chúng tôi một cuốn thực đơn và hai phần bữa sáng đặc sản.',
      '"一份菜单" (một cuốn thực đơn) và "两份早餐" (hai suất ăn sáng) dùng "份" chuẩn xác.'
    );

  -- Điểm ngữ pháp #13: Danh lượng từ chỉ khóa, kỳ, nhiệm kỳ "届" (Khóa / Kỳ / Lần)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ khóa, kỳ, nhiệm kỳ "届" (Khóa / Kỳ / Lần)',
    'Số thứ tự / Số từ + 届 + Danh từ (奥运会 / 毕业生 / 会议 / 比赛)',
    'Lượng từ',
    '"届" (jiè) là lượng từ chuyên dùng cho các sự kiện định kỳ quy mô lớn diễn ra theo từng nhiệm kỳ, khóa học, đại hội thể thao, hoặc các hội nghị thường niên có đánh số thứ tự.',
    'HSK 4',
    13,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '北京成功举办了第二十九届夏季奥林匹克运动会。',
      'Běijīng chénggōng jǔbàn le dì èrshíjiǔ jiè xiàjì àolínpǐkè yùndònghuì.',
      'Bắc Kinh đã tổ chức thành công Thế vận hội Olympic Mùa hè lần thứ 29.',
      '"第二十九届" chỉ kỳ thế vận hội thứ 29, "届" là lượng từ chuẩn xác cho các sự kiện thể thao/đại hội quốc tế.'
    ),
    (
      v_gp_id,
      '作为本届毕业生代表，她在毕业典礼上发表了感人的演讲。',
      'Zuòwéi běnjiè bìyèshēng dàibiǎo, tā zài bìyè diǎnlǐ shang fābiǎo le gǎnrén de yǎnjiǎng.',
      'Với tư cách là đại biểu của khóa tốt nghiệp năm nay, cô ấy đã phát biểu một bài diễn văn xúc động tại lễ tốt nghiệp.',
      '"本届毕业生" chỉ tập thể sinh viên của khóa ra trường hiện tại.'
    );

  -- Điểm ngữ pháp #14: Danh lượng từ chỉ cọng, que, sợi "根" (Cọng / Que / Sợi / Cây)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ cọng, que, sợi "根" (Cọng / Que / Sợi / Cây)',
    'Số từ + 根 + Danh từ (头发 / 香蕉 / 绳子 / 筷子 / 针 / 黄瓜)',
    'Lượng từ',
    '"根" (gēn) dùng để chỉ những đồ vật dài, mảnh, thon và tương đối dẻo hoặc có hình trụ nhỏ như sợi tóc, que diêm, quả chuối, cây kim, sợi dây thừng, chiếc đũa.',
    'HSK 4',
    14,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他在镜子前整理头发，发现自己长出了一根白发。',
      'Tā zài jìngzi qián zhěnglǐ tóufa, fāxiàn zìjǐ zhǎngchū le yì gēn báifà.',
      'Anh ấy đứng trước gương chải tóc và phát hiện mình đã mọc một sợi tóc bạc.',
      '"一根白发" dùng "根" chỉ một sợi tóc dài mỏng.'
    ),
    (
      v_gp_id,
      '桌子上放着一根新鲜的香蕉和几根黄瓜。',
      'Zhuōzi shang fàngzhe yì gēn xīnxiān de xiāngjiāo hé jǐ gēn huángguā.',
      'Trên bàn có đặt một quả chuối tươi và mấy quả dưa chuột.',
      'Trong tiếng Trung, hoa quả hình trụ thon dài như chuối (香蕉) hoặc dưa leo (黄瓜) đều dùng lượng từ "根".'
    );

  -- Điểm ngữ pháp #15: Danh lượng từ chỉ hạt, viên, đồ vật nhỏ tròn "颗" (Viên / Hạt / Ngôi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ hạt, viên, đồ vật nhỏ tròn "颗" (Viên / Hạt / Ngôi)',
    'Số từ + 颗 + Danh từ (星星 / 药 / 心 / 种子 / 葡萄 / 牙齿)',
    'Lượng từ',
    '"颗" (kē) dùng cho các vật thể có hình hạt, viên nhỏ, tròn hoặc tương đối tròn như hạt cây, viên thuốc, hạt ngọc, ngôi sao, viên kẹo, hoặc trái tim.',
    'HSK 4',
    15,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '夜晚的天空十分晴朗，天空中闪烁着几颗明亮的星星。',
      'Yèwǎn de tiānkōng shífēn qínglǎng, tiānkōng zhōng shǎnshuòzhe jǐ kē míngliàng de xīngxing.',
      'Bầu trời đêm rất quang đãng, trên không trung lấp lánh mấy ngôi sao sáng.',
      '"几颗...星星" dùng "颗" để chỉ các vì tinh tú trên bầu trời.'
    ),
    (
      v_gp_id,
      '医生叮嘱他饭后按时吃两颗感冒药。',
      'Yīshēng dīngzhǔ tā fànhòu ànshí chī liǎng kē gǎnmàoyào.',
      'Bác sĩ dặn dò anh ấy sau bữa ăn hãy uống đúng giờ hai viên thuốc cảm.',
      '"两颗感冒药" dùng "颗" định lượng cho viên thuốc nén hoặc thuốc con nhộng hình hạt tròn.'
    );

  -- Điểm ngữ pháp #16: Danh lượng từ chỉ cây cỏ thực vật "棵" (Cây / Gốc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ cây cỏ thực vật "棵" (Cây / Gốc)',
    'Số từ + 棵 + Danh từ (树 / 草 / 白菜 / 牡丹)',
    'Lượng từ',
    '"棵" (kē) là lượng từ chuyên dùng cho cây cối, thực vật mọc từ đất lên (khác với "颗" dùng cho vật nhỏ tròn dạng hạt/viên).',
    'HSK 4',
    16,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们学校图书馆门前种着一棵百年的古老银杏树。',
      'Wǒmen xuéxiào túshūguǎn ménqián zhòngzhe yì kē bǎinián de gǔlǎo yínxìngshù.',
      'Trước cửa thư viện trường chúng tôi có trồng một cây ngân hạnh cổ thụ trăm năm tuổi.',
      '"一棵...银杏树" dùng "棵" (bộ Mộc 木) làm lượng từ chỉ cây đại thụ.'
    ),
    (
      v_gp_id,
      '爷爷在院子里亲手种了几棵绿色的蔬菜。',
      'Yéye zài yuànzi lǐ qīnshǒu zhòng le jǐ kē lǜsè de shūcài.',
      'Ông nội đã tự tay trồng mấy luống cây rau xanh trong sân nhà.',
      '"几棵...蔬菜" chỉ các cây rau xanh đơn lẻ mọc trong vườn.'
    );

  -- Điểm ngữ pháp #17: Danh lượng từ chỉ giọt chất lỏng "滴" (Giọt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ giọt chất lỏng "滴" (Giọt)',
    'Số từ + 滴 + Danh từ (水 / 眼泪 / 汗 / 汗水 / 油 / 血)',
    'Lượng từ',
    '"滴" (dī) biểu thị đơn vị giọt của chất lỏng. Ngoài ra "滴" cũng có thể đóng vai trò làm động từ mang nghĩa nhỏ giọt (滴水). Khi dùng làm lượng từ, "一滴" thường được dùng để nhấn mạnh số lượng nhỏ bé, quý giá.',
    'HSK 4',
    17,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在干旱的沙漠里，每一滴水都显得无比珍贵。',
      'Zài gānhàn de shāmò lǐ, měi yì dī shuǐ dōu xiǎnde wúbǐ zhēnguì.',
      'Ở nơi sa mạc khô hạn, từng giọt nước đều trở nên vô cùng quý giá.',
      '"每一滴水" dùng "滴" làm lượng từ biểu thị từng giọt nước nhỏ nhoi.'
    ),
    (
      v_gp_id,
      '看到儿子顺利考上理想的大学，母亲流下了激动的眼泪。',
      'Kàndào érzi shùnlì kǎoshàng lǐxiǎng de dàxué, mǔqīn liúxià le jīdòng de yǎnlèi.',
      'Nhìn thấy con trai thi đỗ vào trường đại học mơ ước, người mẹ đã rơi những giọt nước mắt xúc động.',
      '"滴" kết hợp cùng "眼泪" diễn tả giọt lệ xúc động trong tình huống gia đình sum vầy.'
    );

  -- Điểm ngữ pháp #18: Danh lượng từ chỉ bầy, đàn, đám "群" (Bầy / Đàn / Đám / Nhóm)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ bầy, đàn, đám "群" (Bầy / Đàn / Đám / Nhóm)',
    'Số từ / 一 + 群 + Danh từ (人 / 孩子 / 羊 / 鸟 / 鸭子)',
    'Lượng từ',
    '"群" (qún) là lượng từ tập hợp dùng cho một nhóm đông người tụ họp lại, hoặc một đàn động vật/chim chóc cùng di chuyển hoặc sinh sống cùng nhau.',
    'HSK 4',
    18,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '放学后，一群活泼可爱的小学生唱着歌走出了校门。',
      'Fàngxué hòu, yì qún huópo kě''ài de xiǎoxuéshēng chàngzhe gē zǒuchū le xiàomén.',
      'Sau khi tan học, một nhóm học sinh tiểu học hồn nhiên đáng yêu vừa hát vừa bước ra cổng trường.',
      '"一群...小学生" chỉ một nhóm đông các em học sinh đi cùng nhau.'
    ),
    (
      v_gp_id,
      '在辽阔的草原上，有一大群羊正在安详地吃草。',
      'Zài liáokuò de cǎoyuán shang, yǒu yí dà qún yáng zhèngzài ānxiáng de chī cǎo.',
      'Trên thảo nguyên bao la, có một đàn cừu lớn đang thong thả gặm cỏ.',
      '"一大群羊" diễn tả số lượng bầy cừu đông đảo trên đồng cỏ.'
    );

  -- Điểm ngữ pháp #19: Danh lượng từ chỉ đống, chồng bừa bộn "堆" (Đống / Chồng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ đống, chồng bừa bộn "堆" (Đống / Chồng)',
    'Số từ / 一 + 堆 + Danh từ (书 / 垃圾 / 衣服 / 问题 / 事情)',
    'Lượng từ',
    '"堆" (duī) biểu thị số lượng nhiều sự vật chất chồng lên nhau thành đống. Ngoài việc chỉ các vật thể cụ thể (như sách vở, quần áo, rác), "堆" còn dùng cho các sự việc trừu tượng (như 一堆问题, 一堆麻烦) với sắc thái bận rộn hoặc bừa bộn.',
    'HSK 4',
    19,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '桌子上堆满了各种文件，还有一大堆待处理的工作。',
      'Zhuōzi shang duīmǎn le gè zhǒng wénjiàn, hái yǒu yí dà duī dài chǔlǐ de gōngzuò.',
      'Trên bàn chất đầy đủ loại tài liệu, và còn có một đống công việc đang chờ xử lý.',
      '"一大堆待处理的工作" dùng "堆" ẩn dụ cho khối lượng công việc bề bộn dồn lại.'
    ),
    (
      v_gp_id,
      '请大家把生活垃圾分类放好，不要在楼道里扔一堆垃圾。',
      'Qǐng dàjiā bǎ shēnghuó lājī fēnlèi fàng hǎo, bú yào zài lóudào lǐ rēng yì duī lājī.',
      'Xin mọi người hãy phân loại rác sinh hoạt cẩn thận, không nên vứt một đống rác ở hành lang.',
      '"一堆垃圾" chỉ đống rác thực tế bừa bãi chưa qua xử lý.'
    );

  -- Điểm ngữ pháp #20: Danh lượng từ chỉ hàng, dãy "排" (Hàng / Dãy)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ hàng, dãy "排" (Hàng / Dãy)',
    'Số từ + 排 + Danh từ (座位 / 树 / 房子 / 队伍)',
    'Lượng từ',
    '"排" (pái) dùng cho người hoặc đồ vật được sắp xếp ngay ngắn theo một đường thẳng ngang hoặc dọc (như hàng ghế, hàng cây, dãy nhà, hàng người).',
    'HSK 4',
    20,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '电影马上就要开场了，请大家按照票号找到第三排的座位。',
      'Diànyǐng mǎshàng jiù yào kāichǎng le, qǐng dàjiā ànzhào piàohào zhǎodào dì sān pái de zuòwèi.',
      'Bộ phim sắp sửa bắt đầu rồi, xin mọi người hãy đối chiếu số vé để tìm chỗ ngồi ở hàng thứ ba.',
      '"第三排的座位" dùng "排" xác định chính xác hàng ghế trong rạp chiếu phim.'
    ),
    (
      v_gp_id,
      '马路两旁种着两排整齐的白杨树，风景十分优美。',
      'Mǎlù liǎngpáng zhòngzhe liǎng pái zhěngqí de báiyángshù, fēngjǐng shífēn yōuměi.',
      'Hai bên đường có trồng hai hàng cây bạch dương ngay ngắn, phong cảnh rất tươi đẹp.',
      '"两排整齐的白杨树" dùng "排" để miêu tả các hàng cây thẳng tắp ven đường.'
    );

  -- Điểm ngữ pháp #21: Phó từ truy cứu đến cùng "究竟" (Rốt cuộc / Cuối cùng thì)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ truy cứu đến cùng "究竟" (Rốt cuộc / Cuối cùng thì)',
    'Chủ ngữ + 究竟 + Từ để hỏi / V_chính + 不 + V_chính / 究竟 + Sự thật/Nguyên nhân',
    'Phó từ',
    '"究竟" (jiūjìng) dùng trong câu hỏi (câu hỏi có đại từ nghi vấn, câu hỏi chính phản hoặc lựa chọn) để tăng cường ngữ khí truy cứu, muốn tìm hiểu rõ chân tướng sự việc (rốt cuộc là sao). Ngoài ra, "究竟" trong câu trần thuật còn có nghĩa là "cuối cùng/rốt cuộc thì" (tương đương với 到头来, 到底). So với "到底", "究竟" trang trọng hơn và thường gặp trong văn viết.',
    'HSK 4',
    21,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '关于那个神秘的项目，你究竟打听到了什么消息？',
      'Guānyú nà ge shénmì de xiàngmù, nǐ jiūjìng dǎtīng dào le shénme xiāoxi?',
      'Liên quan đến dự án bí ẩn đó, rốt cuộc anh đã dò hỏi được tin tức gì rồi?',
      '"究竟" đứng trước động từ trong câu hỏi có "什么" để nhấn mạnh sự truy hỏi đến cùng tin tức.'
    ),
    (
      v_gp_id,
      '面对这个问题，大家都很想知道究竟谁能够给出合理的答案。',
      'Miànduì zhè ge wèntí, dàjiā dōu hěn xiǎng zhīdào jiūjìng shéi nénggòu gěichū hélǐ de dá''àn.',
      'Đối mặt với vấn đề này, mọi người đều rất muốn biết rốt cuộc ai có thể đưa ra đáp án thỏa đáng.',
      '"究竟谁" làm rõ chủ thể giải quyết vấn đề, biểu thị tâm lý tò mò muốn biết rõ sự thật.'
    );

  -- Điểm ngữ pháp #22: Phó từ kết quả và nhấn mạnh ngữ khí "到底" (Rốt cuộc / Suy cho cùng / Đến cùng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ kết quả và nhấn mạnh ngữ khí "到底" (Rốt cuộc / Suy cho cùng / Đến cùng)',
    'Chủ ngữ + 到底 + Câu hỏi / 坚持 + 到底 / 到底 + Vị ngữ',
    'Phó từ',
    '"到底" (dàodǐ) có ba cách dùng chính: 1) Trong câu hỏi biểu thị sự truy vấn rốt cuộc (khẩu ngữ dùng nhiều hơn 究竟); 2) Biểu thị làm một việc đến cùng không từ bỏ (như 坚持到底, 进行到底); 3) Trong câu trần thuật biểu thị nguyên nhân sâu xa hoặc bản chất thực sự (suy cho cùng thì: 他到底是孩子, 难免会犯错).',
    'HSK 4',
    22,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '你不要再犹豫了，今天到底去还是不去？',
      'Nǐ bú yào zài yóuyù le, jīntiān dàodǐ qù háishì bú qù?',
      'Cậu đừng do dự nữa, hôm nay rốt cuộc là đi hay không đi?',
      '"到底" đặt trong câu hỏi lựa chọn "去还是不去" để thúc giục đối phương đưa ra quyết định dứt khoát.'
    ),
    (
      v_gp_id,
      '遇到困难时只要坚持到底，最终就一定会取得胜利。',
      'Yùdào kùnnan shí zhǐyào jiānchí dàodǐ, zuìzhōng jiù yídìng huì qǔdé shènglì.',
      'Khi gặp khó khăn chỉ cần kiên trì đến cùng, cuối cùng nhất định sẽ giành được thắng lợi.',
      '"坚持到底" là kết hợp quán dụng biểu thị hành động kiên trì tới bước cuối cùng.'
    );

  -- Điểm ngữ pháp #23: Phó từ phóng đại và nhấn mạnh cảm xúc "简直" (Quả là / Thật là / Hầu như)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phóng đại và nhấn mạnh cảm xúc "简直" (Quả là / Thật là / Hầu như)',
    'Chủ ngữ + 简直 + (像/是/无法/太) + Vị ngữ',
    'Phó từ',
    '"简直" (jiǎnzhí) dùng để nhấn mạnh một trạng thái, mức độ đạt đến mức kinh ngạc, gần như hoàn toàn như vậy (thực sự là, quả thật là). Thường đi kèm với ngữ khí phóng đại để bày tỏ sự tán thưởng, ngạc nhiên hoặc bất bình.',
    'HSK 4',
    23,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '仅仅用了半年时间他就掌握了汉语，这简直是一个奇迹。',
      'Jǐnjǐn yòng le bàn nián shíjiān tā jiù zhǎowò le hànyǔ, zhè jiǎnzhí shì yí gè qíjì.',
      'Chỉ mất nửa năm anh ấy đã nắm vững tiếng Trung, điều này quả thực là một kỳ tích.',
      '"简直是一个奇迹" phóng đại và khen ngợi năng lực tiếp thu ngoại ngữ phi thường.'
    ),
    (
      v_gp_id,
      '外面的天气太冷了，刺骨的寒风吹在脸上简直像刀割一样。',
      'Wàimiàn de tiānqì tài lěng le, cìgǔ de hánfēng chuī zài liǎn shang jiǎnzhí xiàng dāo gē yíyàng.',
      'Thời tiết bên ngoài quá lạnh, gió lạnh thấu xương thổi vào mặt quả thật như dao cắt.',
      '"简直像...一样" dùng "简直" kết hợp so sánh ví von để cực tả cảm giác buốt giá.'
    );

  -- Điểm ngữ pháp #24: Phó từ tỉnh ngộ và lý giải nguyên do "难怪" (Hèn chi / Thảo nào)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tỉnh ngộ và lý giải nguyên do "难怪" (Hèn chi / Thảo nào)',
    '难怪 + Mệnh đề / Mệnh đề kết quả, 难怪 + Mệnh đề nguyên nhân',
    'Phó từ',
    '"难怪" (nánguài) dùng khi người nói đột nhiên hiểu ra nguyên nhân thực sự của một hiện tượng hoặc kết quả nào đó sau khi biết được tình huống mới (thảo nào, hèn gì, chẳng trách). Có thể dùng đứng đầu câu hoặc giữa hai vế câu.',
    'HSK 4',
    24,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '原来他在北京留学生活了五年，难怪普通话说得这么地道。',
      'Yuánlái tā zài Běijīng liúxué shēnghuó le wǔ nián, nánguài pǔtōnghuà shuō de zhème dìdao.',
      'Thì ra anh ấy đã du học và sống ở Bắc Kinh 5 năm, hèn chi tiếng Phổ thông nói chuẩn như người bản xứ.',
      '"难怪" đứng ở vế sau để bày tỏ sự vỡ lẽ khi biết lý do đối phương nói tiếng Trung xuất sắc.'
    ),
    (
      v_gp_id,
      '今天气温骤降了十度，难怪大家都穿上了厚羽绒服。',
      'Jīntiān qìwēn zhòujiàng le shí dù, nánguài dàjiā dōu chuānshàng le hòu yǔróngfú.',
      'Hôm nay nhiệt độ đột ngột giảm 10 độ, thảo nào ai nấy đều mặc áo phao dày cộm.',
      '"难怪" giải thích lý do mọi người đột ngột thay đổi trang phục vì thời tiết chuyển rét đậm.'
    );

  -- Điểm ngữ pháp #25: Phó từ đồng nghĩa khẩu ngữ "怪不得" (Hèn chi / Thảo nào / Chẳng trách)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ đồng nghĩa khẩu ngữ "怪不得" (Hèn chi / Thảo nào / Chẳng trách)',
    '怪不得 + Mệnh đề / Mệnh đề 1, 怪不得 + Mệnh đề 2',
    'Phó từ',
    '"怪不得" (guàibude) là dạng khẩu ngữ phổ biến đồng nghĩa với "难怪", biểu thị sự ngộ ra nguyên nhân sau khi biết được sự thật (thảo nào, chả trách). Ngoài ra "怪不得" còn có cách dùng làm vị ngữ với nghĩa là không thể trách cứ được (như 这件事怪不得他 - Việc này không thể trách anh ấy được).',
    'HSK 4',
    25,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听说这家餐厅的主厨曾在国外拿过大奖，怪不得每天都有那么多人排队。',
      'Tīngshuō zhè jiā cāntīng de zhǔchú céng zài guówài náguo dàjiǎng, guàibude měitiān dōu yǒu nàme duō rén páiduì.',
      'Nghe nói bếp trưởng của nhà hàng này từng đoạt giải lớn ở nước ngoài, thảo nào ngày nào cũng có bao nhiêu người xếp hàng.',
      '"怪不得" giải thích nguyên nhân nhà hàng luôn đông khách là do tay nghề nổi tiếng của bếp trưởng.'
    ),
    (
      v_gp_id,
      '你昨晚熬夜看了整通宵的球赛，怪不得今天上课一直打瞌睡。',
      'Nǐ zuówǎn áoyè kàn le zhěng tōngxiāo de qiúsài, guàibude jīntiān shàngkè yìzhí dǎ kēshuì.',
      'Tối qua cậu thức trắng đêm xem bóng đá, hèn chi hôm nay trong giờ học cứ ngủ gật suốt.',
      '"怪不得" vạch rõ mối liên hệ giữa việc thức khuya và tình trạng mệt mỏi ban ngày.'
    );

  -- Điểm ngữ pháp #26: Phó từ tiện thể làm thêm việc "顺便" (Nhân tiện / Tiện thể)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tiện thể làm thêm việc "顺便" (Nhân tiện / Tiện thể)',
    'Chủ ngữ + 顺便 + Động từ + Tân ngữ',
    'Phó từ',
    '"顺便" (shùnbiàn) biểu thị trong quá trình thực hiện một hành động chính nào đó, người nói nhân tiện hoặc tiện đường làm thêm một việc phụ khác mà không tốn thêm nhiều thời gian hay công sức.',
    'HSK 4',
    26,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '你下楼去超市买水果的时候，顺便帮我取一下快递吧。',
      'Nǐ xiàlóu qù chāoshì mǎi shuǐguǒ de shíhou, shùnbiàn bāng wǒ qǔ yíxià kuàidì ba.',
      'Khi cậu xuống tầng đi siêu thị mua hoa quả, tiện thể lấy giúp mình gói bưu phẩm nhé.',
      '"顺便" kết hợp trước hành động phụ "帮我取快递" khi thực hiện việc chính đi mua hoa quả.'
    ),
    (
      v_gp_id,
      '李经理去广州出差，顺便拜访了几位多年合作的老客户。',
      'Lǐ jīnglǐ qù Guǎngzhōu chūchāi, shùnbiàn bàifǎng le jǐ wèi duō nián hézuò de lǎo kèhù.',
      'Giám đốc Lý đi Quảng Châu công tác, nhân tiện đã ghé thăm mấy vị khách hàng cũ hợp tác lâu năm.',
      '"顺便拜访" diễn tả hành động ghé thăm được kết hợp khéo léo trong chuyến đi công tác.'
    );

  -- Điểm ngữ pháp #27: Phó từ đích thân chủ thể "亲自" (Đích thân / Tự mình)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ đích thân chủ thể "亲自" (Đích thân / Tự mình)',
    'Chủ ngữ + 亲自 + Động từ (+ Tân ngữ)',
    'Phó từ',
    '"亲自" (qīnzì) biểu thị chính bản thân người đó (thường là cấp trên, bậc trưởng bối, hoặc người có vị trí quan trọng) trực tiếp tham gia hoặc thực hiện hành động, chứ không thông qua người khác hay trung gian ủy quyền.',
    'HSK 4',
    27,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '为了表示对客人的尊敬，总经理亲自去机场迎接。',
      'Wèile biǎoshì duì kèrén de zūnjìng, zǒngjīnglǐ qīnzì qù jīchǎng yíngjiē.',
      'Để thể hiện sự tôn trọng đối với khách quý, tổng giám đốc đã đích thân ra sân bay đón tiếp.',
      '"亲自" đứng trước "去机场迎接" nhấn mạnh sự trịnh trọng và tôn kính khi người lãnh đạo tự mình đi đón khách.'
    ),
    (
      v_gp_id,
      '这道特色菜是妈妈亲自下厨为我做的，味道格外鲜美。',
      'Zhè dào tèsè cài shì māma qīnzì xiàchú wèi wǒ zuò de, wèidào géwài xiānměi.',
      'Món ăn đặc sản này là mẹ đích thân vào bếp nấu cho tôi, hương vị vô cùng thơm ngon.',
      '"亲自下厨" thể hiện tấm lòng yêu thương khi chính người mẹ tự tay nấu nướng.'
    );

  -- Điểm ngữ pháp #28: Phó từ có chủ ý đặc biệt "特意" (Đặc biệt / Cố ý dành riêng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ có chủ ý đặc biệt "特意" (Đặc biệt / Cố ý dành riêng)',
    'Chủ ngữ + 特意 + Động từ (+ Tân ngữ)',
    'Phó từ',
    '"特意" (tèyì) biểu thị chủ thể có một mục đích cụ thể rõ ràng và dành riêng thời gian, công sức hoặc tâm huyết để thực hiện một việc gì đó (thường mang ý nghĩa tích cực, thể hiện sự quan tâm chu đáo).',
    'HSK 4',
    28,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今天是你的生日，我特意为你定做了一个精美的蛋糕。',
      'Jīntiān shì nǐ de shēngrì, wǒ tèyì wèi nǐ dìngzuò le yí gè jīngměi de dàngāo.',
      'Hôm nay là sinh nhật cậu, mình đã đặc biệt đặt riêng cho cậu một chiếc bánh gato tinh xảo.',
      '"特意为你定做" biểu thị việc đặt bánh là hành động có chủ đích chu đáo dành riêng cho bạn nhân dịp sinh nhật.'
    ),
    (
      v_gp_id,
      '听说老朋友身体不适，他特意请假前去医院探望。',
      'Tīngshuō lǎopéngyou shēntǐ búlì, tā tèyì qǐngjià qiánqù yīyuàn tànwàng.',
      'Nghe tin bạn cũ sức khỏe không tốt, anh ấy đã đặc biệt xin nghỉ phép để đến bệnh viện thăm hỏi.',
      '"特意请假" nhấn mạnh hành động xin nghỉ việc xuất phát từ sự trân trọng tình bạn.'
    );

  -- Điểm ngữ pháp #29: Phó từ cố ý có chủ đích "故意" (Cố ý / Cố tình)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ cố ý có chủ đích "故意" (Cố ý / Cố tình)',
    'Chủ ngữ + 故意 + Động từ / 故意 + Làm ra hành động',
    'Phó từ',
    '"故意" (gùyì) biểu thị hành động được thực hiện có ý thức, có toan tính từ trước (thường dùng cho những hành vi tiêu cực, gây phiền hà, trêu chọc hoặc vi phạm quy định). Khác với "特意" (mang sắc thái chu đáo, tốt đẹp), "故意" thường dùng để phê phán hoặc thanh minh (như "我不是故意的" - tôi không cố tình).',
    'HSK 4',
    29,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '对不起，刚才我不小心碰翻了水杯，我真的不是故意的。',
      'Duìbuqǐ, gāngcái wǒ bù xiǎoxīn pèngfān le shuǐbēi, wǒ zhēnde bú shì gùyì de.',
      'Xin lỗi, vừa nãy tôi không cẩn thận va đổ cốc nước, tôi thực sự không phải cố ý đâu.',
      '"不是故意的" là câu xin lỗi kinh điển giải thích hành động xảy ra ngoài ý muốn sơ suất.'
    ),
    (
      v_gp_id,
      '他明明知道开会的时间，却故意迟到了半个小时。',
      'Tā míngmíng zhīdào kāihuì de shíjiān, què gùyì chídào le bàn gè xiǎoshí.',
      'Anh ta rõ ràng biết thời gian họp, nhưng lại cố tình đến muộn nửa tiếng đồng hồ.',
      '"故意迟到" phê phán thái độ thiếu nghiêm túc biết rõ giờ giấc nhưng vẫn cố ý vi phạm.'
    );

  -- Điểm ngữ pháp #30: Phó từ may mắn thoát nạn "幸亏" (May mà / May mắn thay)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ may mắn thoát nạn "幸亏" (May mà / May mắn thay)',
    '幸亏 + Mệnh đề may mắn, 要不然 / 否则 + Hậu quả xấu',
    'Phó từ',
    '"幸亏" (xìngkuī) dùng để biểu thị một tình huống thuận lợi hoặc sự trợ giúp kịp thời đã giúp tránh được một kết quả không mong muốn hoặc nguy hiểm nghiêm trọng (may mà, may mắn thay). Thường đi kèm với "要不然" hoặc "否则" ở vế sau để nêu ra hậu quả suýt xảy ra.',
    'HSK 4',
    30,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '幸亏医生抢救及时，病人才脱离了生命危险。',
      'Xìngkuī yīshēng qiǎngjiù jíshí, bìngrén cái tuōlí le shēngmìng wēixiǎn.',
      'May mà bác sĩ cấp cứu kịp thời, bệnh nhân mới qua khỏi cơn nguy kịch.',
      '"幸亏" chỉ điều kiện may mắn (bác sĩ cấp cứu kịp) đã ngăn chặn được hậu quả nguy hiểm đến tính mạng.'
    ),
    (
      v_gp_id,
      '今天出门幸亏带了雨伞，否则肯定会被淋成落汤鸡。',
      'Jīntiān chūmén xìngkuī dài le yǔsǎn, fǒuzé kěndìng huì bèi línchéng luòtāngjī.',
      'Hôm nay ra khỏi nhà may mà mang theo ô, nếu không chắc chắn đã bị ướt như chuột lột.',
      'Cấu trúc "幸亏...否则..." làm nổi bật sự may mắn nhờ mang ô tránh được cơn mưa rào.'
    );

  -- Điểm ngữ pháp #31: Phó từ biểu thị điểm may mắn "好在" (May mà / Cũng may là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ biểu thị điểm may mắn "好在" (May mà / Cũng may là)',
    '好在 + Tình hình tích cực / Mệnh đề 1, 好在 + Mệnh đề 2',
    'Phó từ',
    '"好在" (hǎozài) mang sắc thái khẩu ngữ tương tự "幸亏", biểu thị nhờ có một yếu tố thuận lợi mà giảm thiểu được rủi ro, tổn thất hoặc làm cho tình hình không đến mức quá tồi tệ (may ở chỗ, cũng may là).',
    'HSK 4',
    31,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '路上遇到大堵车，好在面试地点就在地铁站旁边，我才没迟到。',
      'Lùshang yùdào dà dǔchē, hǎozài miànshì dìdiǎn jiù zài dìtiězhàn pángbiān, wǒ cái méi chídào.',
      'Trên đường bị tắc xe nghiêm trọng, may mà địa điểm phỏng vấn nằm ngay cạnh ga tàu điện ngầm nên tôi mới không bị muộn.',
      '"好在" nêu ra yếu tố thuận lợi về vị trí địa lý cứu vãn tình thế tắc đường.'
    ),
    (
      v_gp_id,
      '昨晚风吹得很大，好在大家都把窗户关严了，没有造成什么损失。',
      'Zuówǎn fēng chuī de hěn dà, hǎozài dàjiā dōu bǎ chuānghu guānyán le, méiyǒu zàochéng shénme sǔnshī.',
      'Đêm qua gió thổi rất to, may mà mọi người đều đóng chặt cửa sổ nên không gây ra thiệt hại gì.',
      '"好在" khẳng định sự phòng ngừa đúng đắn giúp giữ an toàn cho ngôi nhà.'
    );

  -- Điểm ngữ pháp #32: Phó từ phỏng đoán kèm lo lắng "恐怕" (E rằng / Sợ rằng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phỏng đoán kèm lo lắng "恐怕" (E rằng / Sợ rằng)',
    'Chủ ngữ + 恐怕 + Vị ngữ / 恐怕 + Mệnh đề phỏng đoán',
    'Phó từ',
    '"恐怕" (kǒngpà) dùng để đưa ra ước đoán, nhận định về một khả năng có thể xảy ra trong tương lai, nhưng khả năng này thường không có lợi, gây thất vọng hoặc nằm ngoài ý muốn của người nói (e rằng, sợ rằng). Thường dùng để biểu đạt ý kiến một cách nhã nhặn, uyển chuyển.',
    'HSK 4',
    32,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '现在的机票十分紧张，下周出发恐怕已经买不到票了。',
      'Xiànzài de jīpiào shífēn jǐnzhāng, xià zhōu chūfā kǒngpà yǐjīng mǎi bú dào piào le.',
      'Hiện tại vé máy bay rất khan hiếm, tuần sau khởi hành e rằng đã không thể mua được vé nữa.',
      '"恐怕" giảm nhẹ giọng điệu từ chối hoặc đưa ra phỏng đoán bất lợi về việc hết vé.'
    ),
    (
      v_gp_id,
      '今天的工作量太大，仅靠他一个人恐怕很难按时完成。',
      'Jīntiān de gōngzuòliàng tài dà, jǐn kào tā yí gè rén kǒngpà hěn nán ànshí wánchéng.',
      'Khối lượng công việc hôm nay quá lớn, chỉ dựa vào một mình anh ấy e rằng rất khó hoàn thành đúng hạn.',
      '"恐怕很难按时完成" đưa ra dự đoán e dè về tiến độ công việc nhằm đề xuất hỗ trợ.'
    );

  -- Điểm ngữ pháp #33: Phó từ trớ trêu ngoài dự tính "偏偏" (Trớ trêu thay / Ngặt nỗi / Cứ khăng khăng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ trớ trêu ngoài dự tính "偏偏" (Trớ trêu thay / Ngặt nỗi / Cứ khăng khăng)',
    'Chủ ngữ + 偏偏 + Động từ / 偏偏 + Mệnh đề nghịch cảnh',
    'Phó từ',
    '"偏偏" (piānpiān) có hai cách dùng: 1) Diễn tả sự việc diễn ra hoàn toàn trái ngược với nguyện vọng, dự kiến trong hoàn cảnh trớ trêu (ngặt nỗi, oái oăm thay); 2) Biểu thị sự bướng bỉnh, khăng khăng làm một việc ngược lại với ý muốn của người khác.',
    'HSK 4',
    33,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今天我有非常重要的考试，偏偏早上闹钟坏了没有响。',
      'Jīntiān wǒ yǒu fēicháng zhòngyào de kǎoshì, piānpiān zǎoshang nàozhōng huài le méiyǒu xiǎng.',
      'Hôm nay tôi có kỳ thi vô cùng quan trọng, trớ trêu thay sáng nay đồng hồ báo thức lại hỏng không kêu.',
      '"偏偏" thể hiện sự không may xảy ra đúng vào thời điểm quan trọng nhất.'
    ),
    (
      v_gp_id,
      '大家都劝他要冷静考虑，他偏偏不听，执意要辞职。',
      'Dàjiā dōu quàn tā yào lěngjìng kǎolǜ, tā piānpiān bù tīng, zhíyì yào cízhí.',
      'Mọi người đều khuyên anh ấy nên suy nghĩ bình tĩnh, anh ấy cứ khăng khăng không nghe, nhất quyết đòi từ chức.',
      '"偏偏不听" diễn tả tính khí bướng bỉnh làm ngược lại lời khuyên bảo của mọi người.'
    );

  -- Điểm ngữ pháp #34: Phó từ phản đề tương phản "反而" (Trái lại / Ngược lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phản đề tương phản "反而" (Trái lại / Ngược lại)',
    'Vế 1 (dự kiến/lẽ thường), Vế 2 (反而 + Động từ/Tính từ)',
    'Phó từ',
    '"反而" (fǎn''ér) biểu thị kết quả của sự việc xảy ra hoàn toàn trái ngược với lẽ thường, quy luật tự nhiên hoặc dự đoán thông thường. Vế đầu nêu lý do hoặc tác động, vế sau dùng "反而" để nêu phản ứng trái ngược.',
    'HSK 4',
    34,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '吃了药之后，他的头痛不仅没有减轻，反而更加厉害了。',
      'Chī le yào zhīhòu, tā de tóutòng bùjǐn méiyǒu jiǎnqīng, fǎn''ér gèngjiā lìhai le.',
      'Sau khi uống thuốc, chứng đau đầu của anh ấy chẳng những không thuyên giảm mà ngược lại càng dữ dội hơn.',
      '"反而更加厉害" biểu thị kết quả trái ngược hẳn với tác dụng kỳ vọng của việc uống thuốc.'
    ),
    (
      v_gp_id,
      '受到批评之后，他没有灰心，反而激发了更大的学习斗志。',
      'Shòudào pīpíng zhīhòu, tā méiyǒu huīxīn, fǎn''ér jīfā le gèng dà de xuéxí dòuzhì.',
      'Sau khi bị phê bình, anh ấy không nản lòng mà trái lại còn khơi dậy ý chí học tập mãnh liệt hơn.',
      '"反而" nhấn mạnh phản ứng tích cực bất ngờ vượt ngoài tâm lý chán nản thông thường.'
    );

  -- Điểm ngữ pháp #35: Phó từ phản phục khẩu ngữ "反倒" (Trái lại / Ngược lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phản phục khẩu ngữ "反倒" (Trái lại / Ngược lại)',
    'Vế trước, Chủ ngữ + 反倒 + Vị ngữ',
    'Phó từ',
    '"反倒" (fǎndào) đồng nghĩa với "反而", biểu thị sự chuyển ngoặt trái ngược với lẽ thường, thường dùng nhiều trong văn nói khẩu ngữ hoặc phong cách kể chuyện sinh động.',
    'HSK 4',
    35,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我本来是一片好心想去帮他，没想到他反倒嫌我多管闲事。',
      'Wǒ běnlái shì yí piàn hǎoxīn xiǎng qù bāng tā, méi xiǎngdào tā fǎndào xián wǒ duō guǎn xiánshì.',
      'Tôi vốn mang tấm lòng tốt muốn đến giúp anh ta, không ngờ anh ta trái lại còn chê tôi lo chuyện bao đồng.',
      '"反倒嫌我多管闲事" thể hiện phản ứng bất ngờ, vô lý của đối phương đối với lòng tốt.'
    ),
    (
      v_gp_id,
      '年纪大的人每天睡得少，年轻人反倒经常觉得睡不够。',
      'Niánjì dà de rén měitiān shuì de shǎo, niánqīngrén fǎndào jīngcháng juéde shuì bú gòu.',
      'Người lớn tuổi mỗi ngày ngủ ít, người trẻ tuổi ngược lại thường cảm thấy ngủ không đủ giấc.',
      '"反倒" nêu bật sự tương phản thú vị giữa thói quen giấc ngủ của hai thế hệ.'
    );

  -- Điểm ngữ pháp #36: Phó từ phản vấn phủ định "何必" (Hà tất / Việc gì phải / Cần gì)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phản vấn phủ định "何必" (Hà tất / Việc gì phải / Cần gì)',
    '何必 + Động từ / 何必 + Cụm từ + 呢',
    'Phó từ',
    '"何必" (hébì) dùng trong câu hỏi tu từ để biểu thị ý nghĩa không cần thiết phải làm một việc gì đó (hà tất, cần gì, việc gì phải thế). Thường dùng để khuyên nhủ, an ủi hoặc khuyên can đối phương bớt nóng giận, lo âu. Cuối câu thường có trợ từ ngữ khí "呢".',
    'HSK 4',
    36,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这不过是一件微不足道的小事，你何必为它发那么大脾气呢？',
      'Zhè búguò shì yí jiàn wēibùzúdào de xiǎoshì, nǐ hébì wèi tā fā nàme dà píqi ne?',
      'Đây chẳng qua chỉ là một chuyện nhỏ không đáng kể, cậu hà tất phải nổi trận lôi đình vì nó làm gì chứ?',
      'Cấu trúc "何必...呢" mang ngữ khí khuyên can đối phương không nên lãng phí cảm xúc giận dữ vì chuyện vặt vãnh.'
    ),
    (
      v_gp_id,
      '既然双方都有诚意合作，又何必在细节问题上寸步不让呢？',
      'Jìrán shuāngfāng dōu yǒu chéngyì hézuò, yòu hébì zài xìjié wèntí shang cùnbù bú ràng ne?',
      'Đã đôi bên đều có thành ý hợp tác, vậy cần gì phải so đo từng bước ở những vấn đề tiểu tiết chứ?',
      '"何必" thúc đẩy sự nhượng bộ để đạt được đại cục hợp tác suôn sẻ.'
    );

  -- Điểm ngữ pháp #37: Phó từ câu hỏi tu từ chất vấn "难道" (Lẽ nào / Chẳng lẽ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ câu hỏi tu từ chất vấn "难道" (Lẽ nào / Chẳng lẽ)',
    '难道 + Chủ ngữ + Vị ngữ + 吗 / 难道 + Vị ngữ',
    'Phó từ',
    '"难道" (nándào) dùng trong câu hỏi tu từ để nhấn mạnh ngữ khí chất vấn hoặc phản bác mạnh mẽ (chẳng lẽ, lẽ nào). Nếu câu ở dạng khẳng định thì mang ý phủ định, và ngược lại nếu dùng phủ định (难道不...) thì biểu thị khẳng định mạnh mẽ.',
    'HSK 4',
    37,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这么简单的交通规则，难道你连这都不明白吗？',
      'Zhème jiǎndān de jiāotōng guīzé, nándào nǐ lián zhè dōu bù míngbai ma?',
      'Quy tắc giao thông đơn giản như thế này, chẳng lẽ cậu ngay cả điều đó cũng không hiểu sao?',
      '"难道...吗" tăng cường sự trách cứ, chất vấn sự thiếu hiểu biết đối với quy tắc cơ bản.'
    ),
    (
      v_gp_id,
      '大家为这个项目付出了那么多心血，难道我们能轻易放弃吗？',
      'Dàjiā wèi zhè ge xiàngmù fùchū le nàme duō xīnxuè, nándào wǒmen néng qīngyì fàngqì ma?',
      'Mọi người đã bỏ ra bao nhiêu tâm huyết vì dự án này, lẽ nào chúng ta lại có thể dễ dàng từ bỏ hay sao?',
      '"难道能轻易放弃吗" dùng câu hỏi tu từ để khẳng định tuyệt đối không thể bỏ cuộc.'
    );

  -- Điểm ngữ pháp #38: Phó từ dứt khoát đưa ra giải pháp "索性" (Dứt khoát / Thà rằng / Thẳng thừng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ dứt khoát đưa ra giải pháp "索性" (Dứt khoát / Thà rằng / Thẳng thừng)',
    'Chủ ngữ + 索性 + Động từ + Tân ngữ',
    'Phó từ',
    '"索性" (suǒxìng) biểu thị khi đối mặt với một tình huống khó xử, trì hoãn hoặc phiền phức, chủ thể dứt khoát đưa ra một quyết định triệt để, đơn giản hóa vấn đề mà không còn đắn đo suy nghĩ nữa.',
    'HSK 4',
    38,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '外面的雨越下越大，车也打不到，我们索性在朋友家住了一晚。',
      'Wàimiàn de yǔ yuè xià yuè dà, chē yě dǎ bú dào, wǒmen suǒxìng zài péngyou jiā zhù le yì wǎn.',
      'Mưa bên ngoài càng lúc càng to, xe cũng không gọi được, chúng tôi dứt khoát ở lại nhà bạn một đêm.',
      '"索性" thể hiện quyết định nhanh gọn ở lại qua đêm khi các phương án di chuyển đều bế tắc.'
    ),
    (
      v_gp_id,
      '既然这台电脑修起来费用那么高，他索性直接买了一台新的。',
      'Jìrán zhè tái diànnǎo xiū qǐlái fèiyong nàme gāo, tā suǒxìng zhíjiē mǎi le yì tái xīn de.',
      'Đã chi phí sửa chiếc máy tính này cao đến thế, anh ấy thà rằng mua thẳng luôn một chiếc máy mới.',
      '"索性直接买新的" diễn tả sự dứt khoát thay mới thay vì tốn tiền sửa chữa máy cũ.'
    );

  -- Điểm ngữ pháp #39: Phó từ kinh ngạc vượt ngoài mong đợi "居然" (Không ngờ / Lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ kinh ngạc vượt ngoài mong đợi "居然" (Không ngờ / Lại)',
    'Chủ ngữ + 居然 + Động từ / 居然 + Mệnh đề kinh ngạc',
    'Phó từ',
    '"居然" (jūrán) biểu thị sự việc xảy ra hoàn toàn bất ngờ, khác xa hoặc vượt quá hẳn dự tính thông thường (vậy mà, lại, không ngờ rằng). Thường mang sắc thái kinh ngạc, khâm phục hoặc bất ngờ trước một kết quả hiếm có.',
    'HSK 4',
    39,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他平时很少参加体育锻炼，这次居然跑了全班第一名。',
      'Tā píngshí hěn shǎo cānjiā tǐyù duànliàn, zhè cì jūrán pǎo le quán bān dì yī míng.',
      'Bình thường anh ấy rất ít khi tập luyện thể thao, lần này không ngờ lại chạy về đích thứ nhất toàn lớp.',
      '"居然跑了第一名" nhấn mạnh sự ngạc nhiên tột cùng trước thành tích chạy đáng kinh ngạc.'
    ),
    (
      v_gp_id,
      '那对双胞胎姐妹分开生活了二十年，性格居然一模一样。',
      'Nà duì shuāngbāotāi jiěmèi fēnkāi shēnghuó le èrshí nián, xìnggé jūrán yìmúyíyàng.',
      'Cặp chị em sinh đôi đó sống tách biệt suốt 20 năm, tính cách không ngờ lại giống hệt như đúc.',
      '"居然一模一样" thể hiện sự kỳ diệu và kinh ngạc trước sự tương đồng tính cách.'
    );

  -- Điểm ngữ pháp #40: Phó từ ngoài ý muốn mạnh mẽ "竟然" (Lại / Không ngờ rằng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ ngoài ý muốn mạnh mẽ "竟然" (Lại / Không ngờ rằng)',
    'Chủ ngữ + 竟然 + Động từ / Tính từ',
    'Phó từ',
    '"竟然" (jìngrán) mang ý nghĩa tương tự như "居然", chỉ sự việc xảy ra nằm ngoài dự kiến (không ngờ, lại). Tuy nhiên, "竟然" thường được dùng nhiều hơn trong các ngữ cảnh mang tính tiêu cực, phản cảm hoặc khó tin về mặt đạo đức/hành vi.',
    'HSK 4',
    40,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我一直把他当作最好的朋友，他竟然在背后说我的坏话。',
      'Wǒ yìzhí bǎ tā dàngzuò zuì hǎo de péngyou, tā jìngrán zài bèihòu shuō wǒ de huàihuà.',
      'Tôi luôn coi anh ta là người bạn tốt nhất, anh ta thế mà lại nói xấu sau lưng tôi.',
      '"竟然在背后说坏话" thể hiện nỗi thất vọng và kinh ngạc trước sự phản bội của bạn bè.'
    ),
    (
      v_gp_id,
      '这项看起来非常复杂的任务，他竟然只用半天就完成了。',
      'Zhè xiàng kàn qǐlái fēicháng fùzá de rènwu, tā jìngrán zhǐ yòng bàn tiān jiù wánchéng le.',
      'Nhiệm vụ trông có vẻ vô cùng phức tạp này, anh ấy thế mà chỉ dùng nửa ngày đã hoàn thành xong.',
      '"竟然只用半天" biểu thị sự thán phục trước tốc độ xử lý công việc thần tốc ngoài dự đoán.'
    );

  -- Điểm ngữ pháp #41: Phó từ phán đoán căn cứ rõ ràng "显然" (Rõ ràng / Hiển nhiên)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phán đoán căn cứ rõ ràng "显然" (Rõ ràng / Hiển nhiên)',
    '显然 + Mệnh đề / Chủ ngữ + 显然 + Vị ngữ',
    'Phó từ',
    '"显然" (xiǎnrán) dùng để khẳng định một sự việc, tình huống là hiển nhiên, dễ thấy, ai cũng có thể nhận ra mà không cần phải tranh cãi. Có thể đứng ở đầu câu làm trạng ngữ cho cả câu hoặc đứng trước vị ngữ.',
    'HSK 4',
    41,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '从目前的谈判进展来看，对方显然缺乏足够的合作诚意。',
      'Cóng mùqián de tánpàn jìnzhǎn lái kàn, duìfāng xiǎnrán quēfá zúgòu de hézuò chéngyì.',
      'Nhìn từ tiến trình đàm phán hiện tại, đối phương rõ ràng là thiếu thành ý hợp tác thỏa đáng.',
      '"显然缺乏" đưa ra nhận định dứt khoát dựa trên các dữ kiện thực tế của buổi đàm phán.'
    ),
    (
      v_gp_id,
      '这个问题显然没有大家想象的那么简单，需要深入研究。',
      'Zhè ge wèntí xiǎnrán méiyǒu dàjiā xiǎngxiàng de nàme jiǎndān, xūyào shēnrù yánjiū.',
      'Vấn đề này hiển nhiên không đơn giản như mọi người tưởng tượng, cần phải nghiên cứu sâu hơn.',
      '"显然没有...那么简单" làm sáng tỏ bản chất phức tạp của vấn đề.'
    );

  -- Điểm ngữ pháp #42: Phó từ đánh giá có phần quá đáng "未免" (Khó tránh / Hơi bị / Quá ư)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ đánh giá có phần quá đáng "未免" (Khó tránh / Hơi bị / Quá ư)',
    'Chủ ngữ + 未免 + (太/有点儿) + Tính từ / Vị ngữ',
    'Phó từ',
    '"未免" (wèimiǎn) dùng để đưa ra lời nhận xét, đánh giá phê bình một cách tế nhị, cho rằng hành vi hoặc tình huống nào đó có phần hơi quá đáng, không thỏa đáng hoặc khó tránh khỏi bị chê trách (thật là hơi bị, khó tránh khỏi). Thường kết hợp với "太", "过分", "有点儿".',
    'HSK 4',
    42,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只因为一点小小的失误就开除员工，这样做未免太严厉了。',
      'Zhǐ yīnwèi yì diǎn xiǎoxiǎo de shīwù jiù kāichú yuángōng, zhèyàng zuò wèimiǎn tài yánlì le.',
      'Chỉ vì một sơ suất nhỏ mà sa thải nhân viên, làm như vậy thật là có phần quá khắt khe.',
      '"未免太严厉了" phê bình mức độ xử phạt quá nặng nề so với tính chất của lỗi vi phạm.'
    ),
    (
      v_gp_id,
      '还没经过实地调查就下结论，这个决定未免有点儿草率。',
      'Hái méi jīngguò shídì diàochá jiù xià jiélùn, zhè ge juédìng wèimiǎn yǒudiǎnr cǎoshuài.',
      'Còn chưa qua điều tra thực tế mà đã vội kết luận, quyết định này e là có phần hơi vội vàng hấp tấp.',
      '"未免有点儿草率" nhận xét một cách uyển chuyển về sự thiếu cẩn trọng trong quyết định.'
    );

  -- Điểm ngữ pháp #43: Phó từ phủ định tuyệt đối không chút nào "毫无" (Mảy may không / Hoàn toàn không)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phủ định tuyệt đối không chút nào "毫无" (Mảy may không / Hoàn toàn không)',
    '毫无 + Danh từ song âm tiết (毫无疑问 / 毫无经验 / 毫无准备 / 毫无关系)',
    'Phó từ',
    '"毫无" (háowú) có nghĩa là mảy may không có, hoàn toàn không có một chút nào (毫 biểu thị đơn vị cực nhỏ; 无 là không có). "毫无" thường đi kèm trực tiếp với danh từ trừu tượng song âm tiết như 疑问, 意义, 价值, 准备, 关系, 经验.',
    'HSK 4',
    43,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '凭借他在行业内的杰出贡献，获得这项荣誉是毫无疑问的。',
      'Píngjiè tā zài hángyè nèi de jiéchū gòngxiàn, huòdé zhè xiàng róngyù shì háowú yíwèn de.',
      'Nhờ vào những cống hiến kiệt xuất của ông trong ngành, việc nhận được danh hiệu này là hoàn toàn không còn nghi ngờ gì nữa.',
      '"毫无疑问" là cụm từ cố định khẳng định tính xác thực 100% không thể bàn cãi.'
    ),
    (
      v_gp_id,
      '对于刚刚大学毕业的新人来说，他们对实际工作往往毫无经验。',
      'Duìyú gānggāng dàxué bìyè de xīnrén láishuō, tāmen duì shíjì gōngzuò wǎngwǎng háowú jīngyàn.',
      'Đối với những người mới vừa tốt nghiệp đại học, họ đối với công việc thực tế thường hoàn toàn không có kinh nghiệm gì.',
      '"毫无经验" chỉ tình trạng thiếu hụt 100% kinh nghiệm thực chiến.'
    );

  -- Điểm ngữ pháp #44: Phó từ lặp lại từ đầu "重新" (Lại từ đầu / Làm lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ lặp lại từ đầu "重新" (Lại từ đầu / Làm lại)',
    'Chủ ngữ + 重新 + Động từ + Tân ngữ',
    'Phó từ',
    '"重新" (chóngxīn) biểu thị một hành động được thực hiện lại từ đầu, thường là sau khi gặp thất bại, sai sót, hoặc muốn có một khởi đầu mới với chất lượng tốt hơn. Khác với "又" (lặp lại tự nhiên) và "再" (lặp lại tiếp diễn), "重新" nhấn mạnh tính chất bắt đầu lại toàn bộ quy trình từ điểm xuất phát.',
    'HSK 4',
    44,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '方案虽然被客户否定了，但我们大家有信心重新设计出一套新方案。',
      'Fāng''àn suīrán bèi kèhù fǒudìng le, dàn wǒmen dàjiā yǒu xìnxīn chóngxīn shèjì chū yí tào xīn fāng''àn.',
      'Phương án tuy bị khách hàng từ chối, nhưng mọi người chúng tôi đều có niềm tin thiết kế lại từ đầu một bộ phương án mới.',
      '"重新设计" nhấn mạnh quá trình bắt tay làm lại từ vạch xuất phát.'
    ),
    (
      v_gp_id,
      '计算机死机之后，他只能按下电源键重新启动系统。',
      'Jìsuànjī sǐjī zhīhòu, tā zhǐ néng ànxià diànyuán jiàn chóngxīn qǐdòng xìtǒng.',
      'Sau khi máy tính bị treo, anh ấy chỉ còn cách bấm nút nguồn để khởi động lại hệ thống.',
      '"重新启动" chỉ thao tác khởi động lại thiết bị từ trạng thái tắt.'
    );

  -- Điểm ngữ pháp #45: Phó từ hành động lặng lẽ kín đáo "悄悄" (Lén lút / Lặng lẽ / Nhè nhẹ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ hành động lặng lẽ kín đáo "悄悄" (Lén lút / Lặng lẽ / Nhè nhẹ)',
    'Chủ ngữ + 悄悄(地) + Động từ + Tân ngữ',
    'Phó từ',
    '"悄悄" (qiāoqiāo) diễn tả hành động được thực hiện một cách cực kỳ êm ái, yên ắng, không phát ra tiếng động, hoặc diễn ra kín đáo, lén lút để không làm kinh động đến người khác.',
    'HSK 4',
    45,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '夜深了，孩子已经熟睡，妈妈悄悄地关上门走出了卧室。',
      'Yè shēn le, háizi yǐjīng shúshuì, māma qiāoqiāo de guānshàng mén zǒuchū le wòshì.',
      'Đêm đã khuya, con đã ngủ say, người mẹ nhẹ nhàng đóng cửa bước ra khỏi phòng ngủ.',
      '"悄悄地关上门" diễn tả động tác khép cửa nhẹ nhàng để không làm thức giấc em bé.'
    ),
    (
      v_gp_id,
      '趁大家都在专注看比赛，他悄悄地溜出了会议室。',
      'Chèn dàjiā dōu zài zhuānzhù kàn bǐsài, tā qiāoqiāo de liūchū le huìyìshì.',
      'Nhân lúc mọi người đang mải mê xem trận đấu, anh ta đã lén lút chuồn ra khỏi phòng họp.',
      '"悄悄地溜出" miêu tả hành vi rời đi bí mật không để người khác phát hiện.'
    );

  -- Điểm ngữ pháp #46: Phó từ tiến hành theo trình tự bài bản "逐步" (Từng bước / Từng chặng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tiến hành theo trình tự bài bản "逐步" (Từng bước / Từng chặng)',
    'Chủ ngữ + 逐步 + Động từ song âm tiết / 逐步 + Đạt được trạng thái',
    'Phó từ',
    '"逐步" (zhúbù) biểu thị sự việc tiến triển theo từng bước, từng giai đoạn có kế hoạch rõ ràng và có sự can thiệp của ý chí con người. Thường kết hợp với các động từ biến đổi như 提高, 完善, 落实, 改善.',
    'HSK 4',
    46,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着经济的发展，人民的生活水平正在逐步提高。',
      'Suízhe jīngjì de fāzhǎn, rénmín de shēnghuó shuǐpíng zhèngzài zhúbù tígāo.',
      'Cùng với sự phát triển của kinh tế, mức sống của nhân dân đang từng bước được nâng cao.',
      '"逐步提高" thể hiện sự cải thiện từng giai đoạn có định hướng trong đời sống người dân.'
    ),
    (
      v_gp_id,
      '学校将逐步完善各项规章制度，为师生创造更好的环境。',
      'Xuéxiào jiāng zhúbù wánshàn gè xiàng guīzhāng zhìdù, wèi shīshēng chuàngzào gèng hǎo de huánjìng.',
      'Nhà trường sẽ từng bước hoàn thiện các nội quy quy chế, tạo môi trường tốt hơn cho thầy và trò.',
      '"逐步完善" chỉ tiến trình hoàn thiện thể chế theo từng bước kế hoạch.'
    );

  -- Điểm ngữ pháp #47: Phó từ biến đổi tiệm tiến tự nhiên "逐渐" (Dần dần / Từ từ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ biến đổi tiệm tiến tự nhiên "逐渐" (Dần dần / Từ từ)',
    'Chủ ngữ + 逐渐 + Động từ / Tính từ',
    'Phó từ',
    '"逐渐" (zhújiàn) biểu thị mức độ hoặc số lượng biến đổi dần dần theo thời gian, thường là diễn biến tự nhiên không phụ thuộc vào các bước kế hoạch cứng nhắc. So với "逐步", "逐渐" áp dụng rộng rãi hơn cho cả các hiện tượng tự nhiên và tâm lý con người.',
    'HSK 4',
    47,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '春天来了，天气逐渐变暖，小草也渐渐露出了嫩绿的芽。',
      'Chūntiān lái le, tiānqì zhújiàn biàn nuǎn, xiǎocǎo yě jiànjiàn lùchū le nènlǜ de yá.',
      'Mùa xuân đến rồi, thời tiết dần dần ấm lên, ngọn cỏ non cũng từ từ nhú mầm xanh biếc.',
      '"逐渐变暖" miêu tả sự ấm dần lên của khí hậu theo quy luật chuyển mùa tự nhiên.'
    ),
    (
      v_gp_id,
      '来到新城市生活几个月后，他逐渐适应了这里的生活节奏。',
      'Láidào xīn chéngshì shēnghuó jǐ gè yuè hòu, tā zhújiàn shìyìng le zhèlǐ de shēnghuó jiézòu.',
      'Sau mấy tháng chuyển đến thành phố mới sinh sống, anh ấy đã dần dần thích nghi với nhịp sống nơi đây.',
      '"逐渐适应" chỉ quá trình hòa nhập tự nhiên qua thời gian.'
    );

  -- Điểm ngữ pháp #48: Phó từ tổng quát hóa điều kiện "凡是" (Phàm là / Hễ là / Mọi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tổng quát hóa điều kiện "凡是" (Phàm là / Hễ là / Mọi)',
    '凡是 + Đối tượng/Điều kiện + 都 / 也 + Vị ngữ',
    'Phó từ',
    '"凡是" (fánshì) dùng ở đầu câu hoặc đầu vế câu để bao quát toàn bộ mọi thành viên hoặc sự vật nằm trong một phạm vi xác định (phàm là, hễ là, tất cả những ai/cái gì). Vế sau luôn đi kèm với phó từ "都" hoặc "也" để khẳng định tính phổ quát tuyệt đối.',
    'HSK 4',
    48,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '凡是参加本次汉语比赛的选手，都可以获得一份精美的纪念品。',
      'Fánshì cānjiā běn cì hànyǔ bǐsài de xuǎnshǒu, dōu kěyǐ huòdé yí fèn jīngměi de jìnìanpǐn.',
      'Phàm là thí sinh tham gia cuộc thi tiếng Hán lần này đều có thể nhận được một phần quà lưu niệm tinh xảo.',
      '"凡是...都..." xác định toàn bộ người tham gia cuộc thi đều có quyền lợi nhận quà.'
    ),
    (
      v_gp_id,
      '凡是符合国家规定的企业，都可以申请这项科技创新补贴。',
      'Fánshì fúhé guójiā guīdìng de qǐyè, dōu kěyǐ shēnqǐng zhè xiàng kējì chuàngxīn bǔtiē.',
      'Hễ là doanh nghiệp phù hợp với quy định của nhà nước, đều có thể nộp hồ sơ xin khoản trợ cấp đổi mới khoa học kỹ thuật này.',
      '"凡是...都..." bao quát đối tượng đủ tiêu chuẩn theo quy định pháp lý.'
    );

  -- Điểm ngữ pháp #49: Phó từ tác động qua lại "互相" (Lẫn nhau / Cùng nhau)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tác động qua lại "互相" (Lẫn nhau / Cùng nhau)',
    'Chủ ngữ (số nhiều) + 互相 + Động từ song âm tiết',
    'Phó từ',
    '"互相" (hùxiāng) là phó từ biểu thị hành động qua lại hai chiều giữa các cá nhân hoặc các bên đối tác (lẫn nhau). Lưu ý: "互相" là phó từ nên chỉ làm trạng ngữ đứng trước động từ (thường là động từ song âm tiết như 帮助, 学习, 理解, 尊重), không thể trực tiếp làm chủ ngữ hay tân ngữ.',
    'HSK 4',
    49,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '同学之间应该互相帮助，共同克服学习中遇到的困难。',
      'Tóngxué zhījiān yīnggāi hùxiāng bāngzhù, gòngtóng kèfú xuéxí zhōng yùdào de kùnnan.',
      'Giữa các bạn học nên giúp đỡ lẫn nhau, cùng nhau khắc phục những khó khăn gặp phải trong học tập.',
      '"互相帮助" là trạng ngữ + động từ biểu thị mối quan hệ tương trợ hai chiều giữa học sinh.'
    ),
    (
      v_gp_id,
      '两国领导人就双边合作深入交换了意见，达成了互相理解。',
      'Liǎng guó lǐngdǎorén jiù shuāngbiān hézuò shēnrù jiāohuàn le yìjiàn, dáchéng le hùxiāng lǐjiě.',
      'Lãnh đạo hai nước đã trao đổi ý kiến sâu rộng về hợp tác song phương, đạt được sự thấu hiểu lẫn nhau.',
      '"互相理解" chỉ sự hiểu biết và đồng thuận từ cả hai phía đối tác ngoại giao.'
    );

  -- Điểm ngữ pháp #50: Phó từ kín đáo trong tâm lý "暗暗" (Thầm / Ngầm / Trong lòng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ kín đáo trong tâm lý "暗暗" (Thầm / Ngầm / Trong lòng)',
    'Chủ ngữ + 暗暗 + (下决心 / 高兴 / 佩服 / 担心 / 努力)',
    'Phó từ',
    '"暗暗" (àn''àn) biểu thị hoạt động tâm lý, cảm xúc hoặc nỗ lực diễn ra thầm kín bên trong lòng, không bộc lộ ra ngoài cho người khác thấy (ngầm, thầm, trong bụng). Thường kết hợp với các từ ngữ biểu thị tâm tư như 下决心, 庆祝, 佩服, 赞叹, 担忧.',
    'HSK 4',
    50,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听到自己被心仪的公司录取的喜讯，他心里暗暗高兴。',
      'Tīngdào zìjǐ bèi xīnyí de gōngsī lùqǔ de xǐxùn, tā xīnli àn''àn gāoxìng.',
      'Nghe được tin mừng mình đã được công ty mơ ước trúng tuyển, trong lòng anh ấy thầm mừng rỡ.',
      '"暗暗高兴" diễn tả niềm vui sướng âm thầm dâng trào trong nội tâm.'
    ),
    (
      v_gp_id,
      '面对强大的竞争对手，他在心底暗暗下定决心一定要全力以赴。',
      'Miànduì qiángdà de jìngzhēng duìshǒu, tā zài xīndǐ àn''àn xiàdìng juéxīn yídìng yào quánlì yǐ fù.',
      'Đối mặt với đối thủ cạnh tranh mạnh mẽ, anh ấy đã thầm hạ quyết tâm trong lòng nhất định phải dốc hết toàn lực.',
      '"暗暗下定决心" chỉ ý chí quyết tâm được nung nấu trong thâm tâm.'
    );

  -- Điểm ngữ pháp #51: Phó từ kiên định xuyên suốt "始终" (Từ đầu đến cuối / Luôn luôn)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ kiên định xuyên suốt "始终" (Từ đầu đến cuối / Luôn luôn)',
    'Chủ ngữ + 始终 + Phủ định/Khẳng định + Vị ngữ',
    'Phó từ',
    '"始终" (shǐzhōng) kết hợp chữ "始" (bắt đầu) và "终" (kết thúc), biểu thị một trạng thái, nguyên tắc hoặc hành vi duy trì liên tục từ đầu đến cuối không hề suy suyển hay thay đổi. Thường mang sắc thái tán thưởng ý chí kiên định hoặc miêu tả sự bế tắc kéo dài.',
    'HSK 4',
    51,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '无论经历多少风雨，他始终保持着对科学探索的热情。',
      'Wúlùn jīnglì duōshao fēngyǔ, tā shǐzhōng bǎochízhe duì kēxué tànsuǒ de rèqíng.',
      'Bất luận trải qua bao nhiêu phong ba, ông ấy luôn luôn giữ vững niềm nhiệt huyết đối với nghiên cứu khoa học.',
      '"始终保持着" nhấn mạnh tinh thần đam mê bất di bất dịch xuyên suốt nhiều năm tháng.'
    ),
    (
      v_gp_id,
      '对于这次事故的原因，相关责任部门始终没有给出合理的解释。',
      'Duìyú zhè cì shìgù de yuányīn, xiāngguān zérèn bùmén shǐzhōng méiyǒu gěichū hélǐ de jiěshì.',
      'Đối với nguyên nhân của vụ tai nạn lần này, bộ phận chịu trách nhiệm liên quan từ đầu đến cuối vẫn chưa đưa ra lời giải thích thỏa đáng.',
      '"始终没有给出" phê phán sự né tránh trách nhiệm kéo dài liên tục.'
    );

  -- Điểm ngữ pháp #52: Phó từ thời điểm linh hoạt bất định "随时" (Bất cứ lúc nào / Sẵn sàng mọi lúc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời điểm linh hoạt bất định "随时" (Bất cứ lúc nào / Sẵn sàng mọi lúc)',
    'Chủ ngữ + 随时 + Động từ + Tân ngữ',
    'Phó từ',
    '"随时" (suíshí) biểu thị một hành động hoặc trạng thái có thể xảy ra hoặc sẵn sàng thực hiện ở bất kỳ thời điểm nào, không bị gò bó bởi thời gian cụ thể (bất cứ khi nào, mọi lúc).',
    'HSK 4',
    52,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '如果有任何问题，您可以随时通过微信或电话与我联系。',
      'Rúguǒ yǒu rènhé wèntí, nín kěyǐ suíshí tōngguò wēixìn huò diànhuà yǔ wǒ liánxì.',
      'Nếu có bất kỳ câu hỏi nào, quý khách có thể liên hệ với tôi bất cứ lúc nào qua WeChat hoặc điện thoại.',
      '"随时...联系" là lời hẹn lịch thiệp thể hiện sự sẵn sàng hỗ trợ khách hàng 24/7.'
    ),
    (
      v_gp_id,
      '山区的气候多变，随时都可能下起倾盆大雨，出行需带好雨具。',
      'Shānqū de qìhòu duōbiàn, suíshí dōu kěnéng xiàqǐ qīngpén dàyǔ, chūxíng xū dài hǎo yǔjù.',
      'Khí hậu vùng núi thay đổi thất thường, bất cứ lúc nào cũng có thể đổ mưa rào xối xả, đi lại cần mang sẵn đồ che mưa.',
      '"随时都可能" diễn tả khả năng thời tiết biến đổi đột ngột bất chợt.'
    );

  -- Điểm ngữ pháp #53: Giới từ chỉ phạm vi đối tượng đề cập "关于" (Về / Liên quan đến)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ chỉ phạm vi đối tượng đề cập "关于" (Về / Liên quan đến)',
    '关于 + Danh từ / Đoản ngữ, Chủ ngữ + Vị ngữ / Về... (Định ngữ + 的 + Danh từ)',
    'Giới từ',
    '"关于" (guānyú) dùng để dẫn ra phạm vi sự vật, vấn đề cần nói tới hoặc tìm hiểu (liên quan đến, về vấn đề). Thường đứng ở đầu câu ngăn cách bằng dấu phẩy, hoặc làm định ngữ bổ nghĩa cho danh từ có chữ "的" (ví dụ: 关于这个问题的看法).',
    'HSK 4',
    53,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '关于这次留学申请的具体流程，你可以参考招生简章。',
      'Guānyú zhè cì liúxué shēnqǐng de jùtǐ liúchéng, nǐ kěyǐ cānkǎo zhāoshēng jiǎnzhāng.',
      'Về quy trình cụ thể của đợt nộp hồ sơ du học lần này, bạn có thể tham khảo đề án tuyển sinh.',
      '"关于这次留学申请..." đứng đầu câu xác lập chủ đề thảo luận về các bước nộp hồ sơ du học.'
    ),
    (
      v_gp_id,
      '王教授刚刚发表了一本关于中国传统文化的新书。',
      'Wáng jiàoshòu gānggāng fābiǎo le yì běn guānyú Zhōngguó chuántǒng wénhuà de xīn shū.',
      'Giáo sư Vương vừa mới xuất bản một cuốn sách mới về văn hóa truyền thống Trung Quốc.',
      'Cụm giới tân "关于中国传统文化" làm định ngữ có "的" hạn định nội dung chủ đề của cuốn sách.'
    );

  -- Điểm ngữ pháp #54: Giới từ chỉ đối tượng tiếp nhận hành vi "对于" (Đối với / Về mặt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ chỉ đối tượng tiếp nhận hành vi "对于" (Đối với / Về mặt)',
    '对于 + Đối tượng, Chủ ngữ + Vị ngữ / Chủ ngữ + 对于 + Đối tượng + Vị ngữ',
    'Giới từ',
    '"对于" (duìyú) chỉ đối tượng được nhắm tới, tiếp nhận sự đối đãi, thái độ, hoặc hành vi nhận thức (đối với). Khác với "关于" (chỉ phạm vi đề tài, sách báo, hội nghị), "对于" nhấn mạnh quan hệ tác động trực tiếp hoặc thái độ tâm lý (như 对于这件事我很重视).',
    'HSK 4',
    54,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '对于大家提出的宝贵建议，公司领导层表示高度重视。',
      'Duìyú dàjiā tíchū de bǎoguì jiànyì, gōngsī lǐngdǎocéng biǎoshì gāodù zhòngshì.',
      'Đối với những kiến nghị quý báu mà mọi người nêu ra, ban lãnh đạo công ty bày tỏ sự coi trọng cao độ.',
      '"对于大家提出的宝贵建议" là đối tượng được ban lãnh đạo tiếp nhận và xem xét nghiêm túc.'
    ),
    (
      v_gp_id,
      '多做模拟题对于提高汉语考试成绩有极大的帮助。',
      'Duō zuò mónǐ tí duìyú tígāo hànyǔ kǎoshì chéngjì yǒu jídà de bāngzhù.',
      'Làm nhiều đề thi thử đối với việc nâng cao thành tích thi tiếng Trung có sự trợ giúp rất lớn.',
      '"对于提高...成绩" là đối tượng hưởng lợi ích từ việc luyện đề thi thử.'
    );

  -- Điểm ngữ pháp #55: Giới từ/Liên từ chuyển mạch chủ đề "至于" (Còn về / Đến mức)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ/Liên từ chuyển mạch chủ đề "至于" (Còn về / Đến mức)',
    'Chủ đề 1..., 至于 + Chủ đề 2 + Mệnh đề / 不至于 + Kết quả xấu',
    'Giới từ',
    '"至于" (zhìyú) có hai cách dùng quan trọng: 1) Đứng đầu vế câu sau để chuyển hướng câu chuyện sang một đối tượng hoặc chủ đề khác (còn về, còn đối với); 2) Biểu thị đạt đến mức độ nghiêm trọng (thường dùng ở dạng phủ định "不至于" - không đến nỗi, không đến mức).',
    'HSK 4',
    55,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这几个大问题我们已经解决了，至于具体的细节，明天再讨论。',
      'Zhè jǐ gè dà wèntí wǒmen yǐjīng jiějué le, zhìyú jùtǐ de xìjié, míngtiān zài tǎolùn.',
      'Mấy vấn đề lớn này chúng ta đã giải quyết xong rồi, còn về chi tiết cụ thể, ngày mai sẽ thảo luận tiếp.',
      '"至于具体的细节" chuyển mạch bàn luận từ vấn đề tổng thể sang các tiểu tiết kỹ thuật.'
    ),
    (
      v_gp_id,
      '虽然这次比赛没有拿到冠军，但我们也不至于感到绝望。',
      'Suīrán zhè cì bǐsài méiyǒu nádào guànjūn, dàn wǒmen yě bú zhìyú gǎndào juéwàng.',
      'Tuy rằng cuộc thi lần này không đoạt cúp vô địch, nhưng chúng tôi cũng không đến mức cảm thấy tuyệt vọng.',
      '"不至于" biểu thị mức độ thất vọng vẫn nằm trong tầm kiểm soát, chưa đến bờ vực bi quan cực đoan.'
    );

  -- Điểm ngữ pháp #56: Giới từ chỉ căn cứ chuẩn mực "按照" (Căn cứ vào / Theo / Chiểu theo)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ chỉ căn cứ chuẩn mực "按照" (Căn cứ vào / Theo / Chiểu theo)',
    '按照 + Tiêu chuẩn/Quy định/Kế hoạch + Động từ + Tân ngữ',
    'Giới từ',
    '"按照" (ànzhào) biểu thị việc tiến hành một hành động tuân thủ nghiêm ngặt theo một tiêu chuẩn, quy tắc, chỉ thị, hoặc thỏa thuận có sẵn (căn cứ theo, làm theo). Thường đi với các từ như 规定, 计划, 要求, 标准, 顺序.',
    'HSK 4',
    56,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '所有参赛选手都必须按照比赛规则按时提交作品。',
      'Suǒyǒu cànsài xuǎnshǒu dōu bìxū ànzhào bǐsài guīzé ànshí tíjiāo zuòpǐn.',
      'Tất cả các thí sinh dự thi đều phải nộp tác phẩm đúng hạn căn cứ theo quy chế cuộc thi.',
      '"按照比赛规则" xác lập chuẩn mực pháp lý buộc thí sinh phải chấp hành giờ giấc.'
    ),
    (
      v_gp_id,
      '工程队正在按照原定计划抓紧施工，确保按期完工。',
      'Gōngchéngduì zhèngzài ànzhào yuándìng jìhuà zhuājǐn shīgōng, quèbǎo ànqī wángōng.',
      'Đội thi công đang khẩn trương xây dựng theo kế hoạch định sẵn, bảo đảm hoàn thành đúng tiến độ.',
      '"按照原定计划" làm rõ việc thi công tuân thủ đúng lộ trình tiến độ ban đầu.'
    );

  -- Điểm ngữ pháp #57: Giới từ chỉ cơ sở lập luận thực tế "根据" (Căn cứ vào / Dựa trên)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ chỉ cơ sở lập luận thực tế "根据" (Căn cứ vào / Dựa trên)',
    '根据 + Dữ liệu/Khảo sát/Tình hình thực tế, Mệnh đề phán đoán',
    'Giới từ',
    '"根据" (gēnjù) vừa là giới từ vừa là danh từ. Khi làm giới từ, nó dẫn ra căn cứ khách quan, sự thật, số liệu điều tra hoặc dữ kiện thực tế để làm cơ sở cho một phán đoán, kết luận hoặc hành động. So với "按照" (thiên về quy định chuẩn mực con người đặt ra), "根据" thiên về sự kiện thực tế và nghiên cứu khoa học.',
    'HSK 4',
    57,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '根据气象部门发布的最新预报，今天傍晚将有雷阵雨。',
      'Gēnjù qìxiàng bùmén fābù de zuìxīn yùbào, jīntiān bàngwǎn jiāng yǒu léizhènyǔ.',
      'Dựa trên dự báo mới nhất do cơ quan khí tượng công bố, chiều tối nay sẽ có mưa dông.',
      '"根据...最新预报" dẫn ra nguồn tin tức khoa học xác thực làm căn cứ nhận định thời tiết.'
    ),
    (
      v_gp_id,
      '医生会根据每位病人的身体状况制定最合适的治疗方案。',
      'Yīshēng huì gēnjù měi wèi bìngrén de shēntǐ zhuàngkuàng zhìdìng zuì héshì de zhìliáo fāng''àn.',
      'Bác sĩ sẽ căn cứ vào tình trạng sức khỏe của từng bệnh nhân để lập ra phác đồ điều trị phù hợp nhất.',
      '"根据每位病人的身体状况" cho thấy việc trị liệu dựa sát vào tình trạng thực tế cá thể hóa.'
    );

  -- Điểm ngữ pháp #58: Giới từ chỉ tinh thần và phương châm chỉ đạo "本着" (Trên tinh thần / Dựa trên nguyên tắc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ chỉ tinh thần và phương châm chỉ đạo "本着" (Trên tinh thần / Dựa trên nguyên tắc)',
    '本着 + Nguyên tắc/Phương châm/Tinh thần + 的原则/态度, Mệnh đề',
    'Giới từ',
    '"本着" (běnzhe) là giới từ trang trọng trong văn viết chính luận, thương mại và pháp lý, mang nghĩa là xuất phát từ hoặc lấy một phương châm, tôn chỉ, nguyên tắc chỉ đạo tốt đẹp nào đó làm kim chỉ nam cho hành động.',
    'HSK 4',
    58,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '双方本着平等互利的原则，签署了长期战略合作协议。',
      'Shuāngfāng běnzhe píngděng hùlì de yuánzé, qiānshǔ le chángqī zhànlüè hézuò xiéyì.',
      'Đôi bên trên tinh thần nguyên tắc bình đẳng cùng có lợi, đã ký kết thỏa thuận hợp tác chiến lược dài hạn.',
      '"本着平等互利的原则" là phương châm chỉ đạo chuẩn mực trong đàm phán hợp đồng kinh tế quốc tế.'
    ),
    (
      v_gp_id,
      '我们本着对消费者负责的态度，对这批产品进行了全面复检。',
      'Wǒmen běnzhe duì xiāofèizhě fùzé de tàidu, duì zhè pī chǎnpǐn jìnxíng le quánmiàn fùjiǎn.',
      'Chúng tôi với thái độ chịu trách nhiệm đối với người tiêu dùng, đã tiến hành kiểm tra lại toàn diện lô hàng này.',
      '"本着...的态度" thể hiện tinh thần trách nhiệm cao của nhà sản xuất.'
    );

  -- Điểm ngữ pháp #59: Giới từ dựa vào năng lực hoặc bằng chứng "凭" (Dựa vào / Dựa trên / Bằng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ dựa vào năng lực hoặc bằng chứng "凭" (Dựa vào / Dựa trên / Bằng)',
    '凭 + Năng lực/Kinh nghiệm/Giấy tờ + Động từ + Tân ngữ',
    'Giới từ',
    '"凭" (píng) biểu thị hành động được thực hiện dựa vào một kỹ năng chủ quan (kinh nghiệm, cảm giác, năng lực), hoặc dựa vào một điều kiện giấy tờ/bằng chứng khách quan (vé vào cửa, chứng minh nhân dân, giấy thông hành).',
    'HSK 4',
    59,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他凭着丰富的实践经验，很快就排除了这台机器的故障。',
      'Tā píngzhe fēngfù de shíjiàn jīngyàn, hěn kuài jiù páichú le zhè tái jīqì de gùzhàng.',
      'Nhờ dựa vào kinh nghiệm thực tiễn phong phú, anh ấy đã rất nhanh chóng loại trừ được sự cố của cỗ máy này.',
      '"凭着丰富的实践经验" làm rõ yếu tố giúp người thợ kỹ thuật giải quyết hỏng hóc máy móc.'
    ),
    (
      v_gp_id,
      '进入音乐厅前，请各位观众凭门票到入口处检票入场。',
      'Jìnrù yīnyuètīng qián, qǐng gèwèi guānzhòng píng ménpiào dào rùkǒuchù jiǎnpiào rùchǎng.',
      'Trước khi vào phòng hòa nhạc, xin quý vị khán giả xuất trình vé để soát vé vào cửa.',
      '"凭门票" (dựa vào vé) là điều kiện thủ tục bắt buộc để được phép vào khán phòng.'
    );

  -- Điểm ngữ pháp #60: Giới từ chỉ chủ thể phụ trách hoặc nguồn gốc "由" (Do / Bởi / Từ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ chỉ chủ thể phụ trách hoặc nguồn gốc "由" (Do / Bởi / Từ)',
    '由 + Chủ thể phụ trách + Động từ + Tân ngữ / 由...组成',
    'Giới từ',
    '"由" (yóu) có hai cách dùng chính: 1) Dẫn ra người hoặc cơ quan chịu trách nhiệm thực hiện, chi trả, hoặc phụ trách một việc (như 由他负责, 由学校出资); 2) Biểu thị thành phần cấu tạo nên một chỉnh thể (như 由三部分组成 - do ba phần cấu thành).',
    'HSK 4',
    60,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这次国际学术研讨会的所有接待工作由外事办公室全权负责。',
      'Zhè cì guójì xuéshù yántǎohuì de suǒyǒu jiēdài gōngzuò yóu wàishì bàngōngshì quánquán fùzé.',
      'Toàn bộ công tác đón tiếp của hội thảo học thuật quốc tế lần này do văn phòng đối ngoại toàn quyền phụ trách.',
      '"由外事办公室...负责" chỉ rõ cơ quan có thẩm quyền và trách nhiệm tổ chức sự kiện.'
    ),
    (
      v_gp_id,
      '这个科研小组是由十位来自不同学科的年轻博士组成的。',
      'Zhè ge kēyán xiǎozǔ shì yóu shí wèi láizì bùtóng xuékē de niánqīng bóshì zǔchéng de.',
      'Tổ nghiên cứu khoa học này do mười vị tiến sĩ trẻ đến từ các ngành học khác nhau tạo thành.',
      '"由...组成" là cấu trúc biểu thị các thành viên cấu tạo nên một tổ chức nghiên cứu.'
    );

  -- Điểm ngữ pháp #61: Giới từ mốc thời gian khởi điểm "自从" (Kể từ khi / Từ lúc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ mốc thời gian khởi điểm "自从" (Kể từ khi / Từ lúc)',
    '自从 + Mốc thời gian/Sự kiện, Chủ ngữ + Đã/Luôn + Vị ngữ',
    'Giới từ',
    '"自从" (zìcóng) chỉ mốc thời gian bắt đầu xảy ra một trạng thái hay quá trình liên tục kéo dài cho đến tận thời điểm hiện tại hoặc thời điểm đang nói tới (từ khi, kể từ sau khi). So với "从", "自从" chỉ dùng cho thời gian trong quá khứ, không dùng cho địa điểm không gian.',
    'HSK 4',
    61,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '自从上了大学以后，他学会了独立安排自己的日常生活。',
      'Zìcóng shàng le dàxué yǐhòu, tā xuéhuì le dúlì ānpái zìjǐ de rìcháng shēnghuó.',
      'Kể từ sau khi bước chân vào đại học, cậu ấy đã học được cách tự lập sắp xếp đời sống hằng ngày của mình.',
      '"自从上了大学以后" xác định mốc biến cố quan trọng mở đầu cho quá trình trưởng thành tự lập.'
    ),
    (
      v_gp_id,
      '自从搬进这套新公寓，他的睡眠质量有了明显的改善。',
      'Zìcóng bānjìn zhè tào xīn gōngyù, tā de shuìmián zhìliàng yǒu le míngxiǎn de gǎishàn.',
      'Kể từ khi dọn vào căn hộ mới này, chất lượng giấc ngủ của anh ấy đã có sự cải thiện rõ rệt.',
      '"自从..." liên kết thời điểm chuyển nhà với chuỗi biến đổi tích cực về sức khỏe.'
    );

  -- Điểm ngữ pháp #62: Giới từ nắm bắt thời cơ thuận lợi "趁" (Nhân dịp / Thừa cơ / Tiện lúc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ nắm bắt thời cơ thuận lợi "趁" (Nhân dịp / Thừa cơ / Tiện lúc)',
    '趁 + Cơ hội/Thời gian thuận lợi, Chủ ngữ + Động từ + Tân ngữ',
    'Giới từ',
    '"趁" (chèn) biểu thị việc tranh thủ hoặc nắm bắt một điều kiện thời gian, hoàn cảnh hoặc trạng thái thuận lợi đang diễn ra để thực hiện một hành động trước khi điều kiện đó qua đi (thừa dịp, nhân lúc). Thường gặp: 趁热 (nhân lúc còn nóng), 趁机 (thừa cơ), 趁年轻 (nhân lúc còn trẻ).',
    'HSK 4',
    62,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '饺子刚刚煮好，你快趁热吃吧，凉了就不好吃了。',
      'Jiǎozi gānggāng zhǔhǎo, nǐ kuài chèn rè chī ba, liáng le jiù bù hǎochī le.',
      'Bánh sủi cảo vừa mới luộc chín xong, cậu hãy mau ăn lúc còn nóng đi, nguội rồi sẽ không ngon nữa.',
      '"趁热吃" là cách nói văn hóa quen thuộc nhắc nhở thưởng thức món ăn khi nhiệt độ thơm ngon nhất.'
    ),
    (
      v_gp_id,
      '我们应该趁着年轻多学一些实用的知识和专业技能。',
      'Wǒmen yīnggāi chènzhe niánqīng duō xué yìxiē shíyòng de zhīshi hé zhuānyè jìnéng.',
      'Chúng ta nên nhân lúc còn trẻ học thêm nhiều kiến thức thực tế và kỹ năng chuyên môn.',
      '"趁着年轻" khuyên nhủ nắm bắt thời thanh xuân tràn đầy năng lượng để tích lũy học vấn.'
    );

  -- Điểm ngữ pháp #63: Giới từ định hướng mục tiêu "朝" (Hướng về / Về phía)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ định hướng mục tiêu "朝" (Hướng về / Về phía)',
    'Chủ ngữ + 朝 + Phương hướng/Đối tượng + Động từ (走/看/跑/挥手)',
    'Giới từ',
    '"朝" (cháo) là giới từ biểu thị hướng quay mặt hoặc phương hướng chuyển động của hành động nhắm tới (về phía, hướng tới). Thường đi với các động từ chỉ động thái như 走, 看, 望, 挥手, 拜, 笑. Khác với "往", "朝" nhấn mạnh góc quay hoặc đối tượng đối diện.',
    'HSK 4',
    63,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '列车缓缓启动了，站台上的亲友们纷纷朝车窗挥手告别。',
      'Lièchē huǎnhuǎn qǐdòng le, zhàntái shang de qīnyǒumen fēnfēn cháo chēchuāng huīshǒu gàobié.',
      'Đoàn tàu từ từ lăn bánh, người thân và bạn bè trên sân ga đồng loạt vẫy tay về phía cửa sổ toa tàu để từ biệt.',
      '"朝车窗挥手" chỉ động tác vẫy tay hướng về phía khung cửa sổ tàu hỏa.'
    ),
    (
      v_gp_id,
      '出了地铁站之后，一直朝前走两百米就能看到那家书店。',
      'Chū le dìtiězhàn zhīhòu, yìzhí cháo qián zǒu liǎng bǎi mǐ jiù néng kàndào nà jiā shūdiàn.',
      'Sau khi ra khỏi ga tàu điện ngầm, cứ đi thẳng về phía trước 200 mét là có thể nhìn thấy hiệu sách đó.',
      '"朝前走" chỉ dẫn phương hướng tiến lên phía trước.'
    );

  -- Điểm ngữ pháp #64: Giới từ thay mặt hoặc vì lợi ích của người khác "替" (Thay cho / Giúp)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ thay mặt hoặc vì lợi ích của người khác "替" (Thay cho / Giúp)',
    'Chủ ngữ + 替 + Người khác + Động từ + Tân ngữ',
    'Giới từ',
    '"替" (tì) có hai nghĩa chính: 1) Đại diện hoặc thay thế vị trí cho ai đó làm một việc gì (như 替他请假 - xin nghỉ hộ anh ấy); 2) Đứng về phía tình cảm hoặc lợi ích của người khác để đồng cảm (như 替你高兴 - mừng thay cho cậu, 替他担心 - lo lắng cho anh ấy).',
    'HSK 4',
    64,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听到你顺利通过高级汉语考试的消息，大家都很替你高兴。',
      'Tīngdào nǐ shùnlì tōngguò gāojí hànyǔ kǎoshì de xiāoxi, dàjiā dōu hěn tì nǐ gāoxìng.',
      'Nghe tin cậu đã thuận lợi vượt qua kỳ thi tiếng Hán cao cấp, mọi người đều rất mừng cho cậu.',
      '"替你高兴" thể hiện sự chia sẻ niềm vui chân thành đứng trên cương vị người bạn.'
    ),
    (
      v_gp_id,
      '如果明天下午你有急事去不了，我可以替你去参加开幕式。',
      'Rúguǒ míngtiān xiàwǔ nǐ yǒu jíshì qù bù liǎo, wǒ kěyǐ tì nǐ qù cānjiā kāimùshì.',
      'Nếu chiều mai cậu có việc bận gấp không đi được, mình có thể thay cậu đi tham dự lễ khai mạc.',
      '"替你去参加" là hành động đi thay mặt, đại diện dự sự kiện.'
    );

  -- Điểm ngữ pháp #65: Cặp liên từ tăng tiến đa tầng "不仅...而且..." (Không những... mà còn...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cặp liên từ tăng tiến đa tầng "不仅...而且..." (Không những... mà còn...)',
    'Chủ ngữ + 不仅...而且... / 不但...而且... / 不仅 A, 而且 B',
    'Liên từ',
    'Cặp liên từ "不仅...而且..." (bùjǐn... érqiě...) biểu thị quan hệ tăng tiến từ tầng nghĩa cơ sở lên tầng nghĩa sâu hơn hoặc rộng lớn hơn. Nếu hai vế cùng một chủ ngữ thì chủ ngữ đứng trước "不仅"; nếu hai vế khác chủ ngữ thì mỗi chủ ngữ đứng sau "不仅" và "而且".',
    'HSK 4',
    65,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '多吃新鲜蔬菜水果不仅有益健康，而且能有效保持皮肤光泽。',
      'Duō chī xīnxiān shūcài shuǐguǒ bùjǐn yǒuyì jiànkāng, érqiě néng yǒuxiào bǎochí pífū guāngzé.',
      'Ăn nhiều rau quả tươi chẳng những có lợi cho sức khỏe mà còn duy trì hiệu quả độ sáng bóng của làn da.',
      '"不仅...而且..." cùng chung chủ ngữ, nâng cao tác dụng từ sức khỏe tổng quát lên tới sắc đẹp làn da.'
    ),
    (
      v_gp_id,
      '不仅老师赞扬了他的勇敢举动，而且同学们也纷纷向他学习。',
      'Bùjǐn lǎoshī zànyáng le tā de yǒnggǎn jǔdòng, érqiě tóngxuémen yě fēnfēn xiàng tā xuéxí.',
      'Không chỉ thầy cô ngợi khen hành động dũng cảm của cậu ấy, mà các bạn học sinh cũng đồng loạt noi gương học tập.',
      'Khác chủ ngữ ("老师" và "同学们"), "不仅" đứng đầu vế một và "而且" đứng đầu vế hai.'
    );

  -- Điểm ngữ pháp #66: Liên từ tăng tiến cực hạn "甚至" (Thậm chí / Ngay cả)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ tăng tiến cực hạn "甚至" (Thậm chí / Ngay cả)',
    'Vế 1, 甚至 + (连...) + Vế 2 / A, B, 甚至 C',
    'Liên từ',
    '"甚至" (shènzhì) nêu ra một trường hợp hoặc ví dụ cực đoan, nổi bật nhất để nhấn mạnh mức độ tăng tiến phi thường của sự việc. Có thể dùng để liên kết các từ, ngữ hoặc các phân câu độc lập.',
    'HSK 4',
    66,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这道数学题太难了，很多大学生都做不出来，甚至连老师都答不上来。',
      'Zhè dào shùxué tí tài nán le, hěn duō dàxuéshēng dōu zuò bù chūlái, shènzhì lián lǎoshī dōu dá bú shànglái.',
      'Bài toán này quá khó, rất nhiều sinh viên đại học đều không giải được, thậm chí ngay cả giáo viên cũng không trả lời nổi.',
      '"甚至连老师..." đẩy độ khó lên mức cực hạn, vượt quá tầm kiến thức thông thường.'
    ),
    (
      v_gp_id,
      '为了赶工期，工人们经常加班到深夜，有时候甚至彻夜不眠。',
      'Wèile gǎn gōngqī, gōngrénmen jīngcháng jiābān dào shēnyè, yǒu shíhou shènzhì chèyè bù mián.',
      'Để kịp tiến độ thi công, các công nhân thường tăng ca đến tận đêm khuya, có lúc thậm chí thức trắng suốt đêm.',
      '"甚至彻夜不眠" tăng tiến cường độ lao động vất vả từ đêm muộn đến trắng đêm.'
    );

  -- Điểm ngữ pháp #67: Liên từ bổ sung lý do xác đáng "况且" (Hơn nữa / Vả lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ bổ sung lý do xác đáng "况且" (Hơn nữa / Vả lại)',
    'Lý do 1, 况且 + Lý do 2 (thuyết phục hơn) + Kết luận',
    'Liên từ',
    '"况且" (kuàngqiě) dùng ở vế sau để bổ sung thêm một lý do hoặc điều kiện hiển nhiên khác, làm cho luận điểm hoặc quyết định được đưa ra càng thêm vững chắc, có sức thuyết phục cao hơn (vả lại, hơn nữa).',
    'HSK 4',
    67,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '现在下着大暴雨，况且路灯也坏了，你一个人走夜路太危险了。',
      'Xiànzài xiàzhe dà bàoyǔ, kuàngqiě lùdēng yě huài le, nǐ yí gè rén zǒu yèlù tài wēixiǎn le.',
      'Bây giờ trời đang mưa to tầm tã, hơn nữa đèn đường cũng hỏng rồi, bạn đi đường đêm một mình quá nguy hiểm.',
      '"况且路灯也坏了" bổ sung thêm lý do thứ hai thuyết phục đối phương không nên ra đường ban đêm.'
    ),
    (
      v_gp_id,
      '我们已经准备了整整三个月，况且大家经验丰富，一定能圆满完成任务。',
      'Wǒmen yǐjīng zhǔnbèi le zhěngzhěng sān gè yuè, kuàngqiě dàjiā jīngyàn fēngfù, yídìng néng yuánmǎn wánchéng rènwu.',
      'Chúng ta đã chuẩn bị tròn ba tháng ròng, hơn nữa mọi người lại giàu kinh nghiệm, nhất định sẽ hoàn thành mỹ mãn nhiệm vụ.',
      '"况且" củng cố niềm tin thành công bằng việc viện dẫn kinh nghiệm dày dạn của đội ngũ.'
    );

  -- Điểm ngữ pháp #68: Liên từ tăng tiến tương phản ngụ ý "何况" (Huống hồ / Huống chi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ tăng tiến tương phản ngụ ý "何况" (Huống hồ / Huống chi)',
    'Tình huống A (dễ/gần) + Còn như vậy, 何况 + Tình huống B (khó/xa)',
    'Liên từ',
    '"何况" (hékuàng) biểu thị ý nghĩa: ngay cả trường hợp thông thường, đối tượng mạnh mẽ/dễ hơn còn như vậy thì huống chi trường hợp đặc biệt, đối tượng yếu hơn (huống hồ, huống chi). Thường dùng trong so sánh ngầm mang tính tu từ mạnh mẽ.',
    'HSK 4',
    68,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '成年人走这么陡峭的山路都很吃力，何况是几岁的小孩子呢？',
      'Chéngniánrén zǒu zhème dǒuqìao de shānlù dōu hěn chīlì, hékuàng shì jǐ suì de xiǎoháizi ne?',
      'Người lớn đi con đường núi dốc đứng thế này còn rất tốn sức, huống chi là đứa trẻ con mấy tuổi đầu chứ?',
      'Cấu trúc so sánh tương phản ngụ ý: người lớn còn chịu không nổi thì trẻ nhỏ càng không thể.'
    ),
    (
      v_gp_id,
      '本地人都经常在这座立交桥上迷路，何况你是第一次来这里的游客。',
      'Běndìrén dōu jīngcháng zài zhè zuò lìjiāoqiáo shang mílù, hékuàng nǐ shì dì yī cì lái zhèlǐ de yóukè.',
      'Người bản xứ còn thường xuyên bị lạc đường trên cây cầu vượt này, huống hồ cậu lại là du khách lần đầu tiên đến đây.',
      '"何况" cảm thông cho việc lạc đường của du khách bằng cách đối chiếu với người bản địa.'
    );

  -- Điểm ngữ pháp #69: Liên từ chỉ hệ quả và bước tiến tiếp theo "从而" (Do đó mà / Nhờ đó mà)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ chỉ hệ quả và bước tiến tiếp theo "从而" (Do đó mà / Nhờ đó mà)',
    'Biện pháp/Hành động, 从而 + Kết quả/Ý nghĩa tiến bộ',
    'Liên từ',
    '"从而" (cóng''ér) là liên từ trang trọng nối liền nguyên nhân/biện pháp ở vế trước với kết quả, mục đích hoặc bước phát triển tất yếu ở vế sau (do đó mà, nhờ vậy mà). Vế sau thường là một kết quả tích cực, nâng cao chất lượng hoặc đạt được mục tiêu lớn.',
    'HSK 4',
    69,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '公司引进了最先进的自动化设备，从而大幅降低了生产成本。',
      'Gōngsī yǐnjìn le zuì xiānjìn de zìdònghuà shèbèi, cóng''ér dàfú jiàngdī le shēngchǎn chéngběn.',
      'Công ty đã du nhập thiết bị tự động hóa tiên tiến nhất, nhờ đó mà giảm mạnh chi phí sản xuất.',
      '"从而大幅降低..." nối liền biện pháp cải tiến công nghệ với thành quả kinh tế to lớn đạt được.'
    ),
    (
      v_gp_id,
      '坚持每天阅读可以开阔视野，从而提高个人的综合文化修养。',
      'Jiānchí měitiān yuèdú kěyǐ kāikuò shìyě, cóng''ér tígāo gèrén de zōnghé wénhuà xiūyǎng.',
      'Kiên trì đọc sách mỗi ngày có thể mở rộng tầm mắt, nhờ đó nâng cao tu dưỡng văn hóa tổng hợp của cá nhân.',
      '"从而" diễn tả bước tiến nâng cao phẩm chất tinh thần xuất phát từ thói quen đọc sách.'
    );

  -- Điểm ngữ pháp #70: Liên từ suy luận kết quả tự nhiên "因而" (Vì vậy / Cho nên)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ suy luận kết quả tự nhiên "因而" (Vì vậy / Cho nên)',
    'Nguyên nhân thực tế, 因而 + Kết quả tất yếu',
    'Liên từ',
    '"因而" (yīn''ér) là liên từ kết hợp "因" (vì) và "而" (thì/cho nên), tương đương với "因此" hoặc "所以", dùng trong văn viết và phong cách nghị luận trang trọng để kết nối mối quan hệ nhân quả logic.',
    'HSK 4',
    70,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他在科学实验中付出了极大的心血，因而取得了举世瞩目的成就。',
      'Tā zài kēxué shíyàn zhōng fùchū le jídà de xīnxuè, yīn''ér qǔdé le jǔshì zhǔmù de chéngjiù.',
      'Ông đã bỏ ra tâm huyết to lớn trong các thí nghiệm khoa học, vì vậy đã gặt hái được những thành tựu khiến cả thế giới dõi theo.',
      '"因而取得了..." là kết quả xứng đáng đền đáp cho công lao nghiên cứu kiên trì.'
    ),
    (
      v_gp_id,
      '由于双方观点存在根本分歧，因而这次商务洽谈未能达成最终共识。',
      'Yóuyú shuāngfāng guāndiǎn cúnzài gēnběn fēnqí, yīn''ér zhè cì shāngwù qiàtán wèinéng dáchéng zuìzhōng gòngshí.',
      'Do quan điểm của đôi bên tồn tại bất đồng căn bản, vì vậy cuộc đàm phán thương mại lần này đã không thể đạt được đồng thuận cuối cùng.',
      '"因而" liên kết sự bất đồng quan điểm với kết quả đàm phán bất thành.'
    );

  -- Điểm ngữ pháp #71: Cặp liên từ tiền đề hiển nhiên "既然...就..." (Đã... thì...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cặp liên từ tiền đề hiển nhiên "既然...就..." (Đã... thì...)',
    '既然 + Sự thật đã rồi / Tiền đề được thừa nhận, (Chủ ngữ) + 就 + Kết luận/Hành động',
    'Liên từ',
    '"既然...就..." (jìrán... jiù...) dùng khi sự việc ở vế trước đã là một thực tế hiển nhiên, được cả người nói và người nghe thừa nhận, từ đó vế sau đưa ra quyết định, giải pháp hoặc lời khuyên hợp tình hợp lý (đã thế thì hãy làm thế).',
    'HSK 4',
    71,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '既然大家对此都没有异议，我们就按照这个方案开始执行吧。',
      'Jìrán dàjiā duì cǐ dōu méiyǒu yìyì, wǒmen jiù ànzhào zhè ge fāng''àn kāishǐ zhíxíng ba.',
      'Đã mọi người đều không có dị nghị gì về điều này, thì chúng ta hãy bắt đầu triển khai theo phương án này đi.',
      '"既然...就..." dựa trên tiền đề mọi người đồng thuận để đưa ra quyết định khởi động dự án.'
    ),
    (
      v_gp_id,
      '既然你身体不舒服，就留在宿舍里好好休息，别去跑步了。',
      'Jìrán nǐ shēntǐ bù shūfu, jiù liú zài sùshè lǐ hǎohǎo xiūxi, bié qù pǎobù le.',
      'Đã cậu cảm thấy trong người không khỏe, thì hãy ở lại ký túc xá nghỉ ngơi thật tốt, đừng đi chạy bộ nữa.',
      '"既然" thừa nhận trạng thái mệt mỏi của người bạn để đưa ra lời khuyên nghỉ ngơi hợp lý.'
    );

  -- Điểm ngữ pháp #72: Cặp liên từ giả thiết nhượng bộ tột bực "哪怕...也..." (Dù cho... cũng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cặp liên từ giả thiết nhượng bộ tột bực "哪怕...也..." (Dù cho... cũng...)',
    '哪怕 + Điều kiện cực đoan/Khó khăn nhất, 主语 + 也 + Quyết tâm/Hành vi',
    'Liên từ',
    '"哪怕...也..." (nǎpà... yě...) biểu thị sự nhượng bộ giả định đối với một điều kiện cực đoan, khó khăn nhất có thể tưởng tượng ra, nhưng kết quả hoặc quyết tâm ở vế sau vẫn kiên định không hề lay chuyển (cho dù... cũng vẫn cứ).',
    'HSK 4',
    72,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '哪怕前方的道路再艰难，我们也绝不会放弃自己的梦想。',
      'Nǎpà qiánfāng de dàolù zài jiānnán, wǒmen yě jué bú huì fàngqì zìjǐ de mèngxiǎng.',
      'Dù cho con đường phía trước có gian nan đến mấy, chúng tôi cũng tuyệt đối không từ bỏ ước mơ của mình.',
      '"哪怕...也绝不会放弃" khẳng định quyết tâm theo đuổi lý tưởng bất chấp muôn trùng chông gai.'
    ),
    (
      v_gp_id,
      '哪怕只剩下一线希望，医生们也会竭尽全力抢救这名伤员。',
      'Nǎpà zhǐ shèngxià yí xiàn xīwàng, yīshēngmen yě huì jiéjìn quánlì qiǎngjiù zhè míng shāngyuán.',
      'Dù cho chỉ còn lại một tia hy vọng mong manh, các bác sĩ cũng sẽ dốc hết toàn lực cứu chữa người bị thương này.',
      '"哪怕只剩下一线希望" thể hiện y đức cao cả không bỏ cuộc trước sự sống.'
    );

  -- Điểm ngữ pháp #73: Cặp liên từ nhượng bộ trang trọng "即便...也..." (Cho dù... cũng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cặp liên từ nhượng bộ trang trọng "即便...也..." (Cho dù... cũng...)',
    '即便 + Tình huống giả thiết bất lợi, 主语 + 也 + Vị ngữ',
    'Liên từ',
    '"即便...也..." (jíbiàn... yě...) tương đương với "即使...也...", nhưng mang sắc thái trang nhã, văn phong uyển chuyển và học thuật hơn (cho dù... thì vẫn cứ). Thường dùng để biện luận trong văn viết chính luận.',
    'HSK 4',
    73,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '即便在最困难的岁月里，他也始终没有丧失对未来的信心。',
      'Jíbiàn zài zuì kùnnan de suìyuè lǐ, tā yě shǐzhōng méiyǒu sàngshī duì wèilái de xìnxīn.',
      'Cho dù ở vào những năm tháng khó khăn nhất, ông ấy cũng luôn luôn không đánh mất niềm tin vào tương lai.',
      '"即便...也..." diễn tả nghị lực phi thường giữ trọn niềm tin qua thử thách khắc nghiệt.'
    ),
    (
      v_gp_id,
      '即便这项技术目前还不成熟，我们也有必要进行深入的预先研究。',
      'Jíbiàn zhè xiàng jìshù mùqián hái bù chéngshú, wǒmen yě yǒu bìyào jìnxíng shēnrù de yùxiān yánjiū.',
      'Cho dù công nghệ này hiện tại vẫn chưa hoàn thiện, chúng ta cũng cần thiết phải tiến hành nghiên cứu đón đầu chuyên sâu.',
      '"即便...也有必要" bảo vệ tính cần thiết của việc đón đầu công nghệ tương lai.'
    );

  -- Điểm ngữ pháp #74: Cặp liên từ chuyển ngoặt hiện thực "尽管...但是/却..." (Mặc dù... nhưng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cặp liên từ chuyển ngoặt hiện thực "尽管...但是/却..." (Mặc dù... nhưng...)',
    '尽管 + Sự thật khách quan, 但是 / 可是 / 却 + Kết quả tương phản',
    'Liên từ',
    '"尽管...但是..." (jǐnguǎn... dànshì...) biểu thị quan hệ chuyển ngoặt trên cơ sở sự thật đã xảy ra hoặc đang tồn tại (khác với "即使" dùng cho giả thiết chưa xảy ra). Vế đầu thừa nhận một thực tế cản trở, vế sau dùng "但是" hoặc "却" nêu ra kết quả bất ngờ trái ngược.',
    'HSK 4',
    74,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '尽管外面的天气非常严寒，但是大厅里的气氛却格外热烈。',
      'Jǐnguǎn wàimiàn de tiānqì fēicháng yánhán, dànshì dàtīng lǐ de qìfēn què géwài rèliè.',
      'Mặc dù thời tiết bên ngoài vô cùng giá rét, nhưng bầu không khí bên trong đại sảnh lại hết sức ấm cúng náo nhiệt.',
      '"尽管...但是...却" làm nổi bật sự đối lập sinh động giữa nhiệt độ ngoài trời và không khí trong hội trường.'
    ),
    (
      v_gp_id,
      '尽管遇到了许多意料之外的挑战，团队最终还是按时交付了产品。',
      'Jǐnguǎn yùdào le xǔduō yìliào zhīwài de tiǎozhàn, tuánduì zuìzhōng háishì ànshí jiāofù le chǎnpǐn.',
      'Mặc dù đã gặp phải rất nhiều thách thức ngoài dự liệu, đội ngũ cuối cùng vẫn bàn giao sản phẩm đúng hạn.',
      '"尽管..." ghi nhận sự gian khổ của tập thể để tôn vinh kết quả bàn giao dự án xuất sắc.'
    );

  -- Điểm ngữ pháp #75: Cấu trúc lựa chọn xả thân nhượng bộ "宁可...也不..." (Thà rằng... chứ không...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc lựa chọn xả thân nhượng bộ "宁可...也不..." (Thà rằng... chứ không...)',
    'Chủ ngữ + 宁可 + Phương án hy sinh/chấp nhận thiệt thòi, 也不 + Phương án vi phạm nguyên tắc',
    'Liên từ',
    '"宁可...也不..." (nìngkě... yě bù...) biểu thị sự so sánh giữa hai khả năng bất lợi, trong đó chủ thể tình nguyện chấp nhận phương án thứ nhất (dù gian khổ, tốn kém hoặc chịu thiệt thòi) chứ quyết không bao giờ chấp nhận phương án thứ hai (vì vi phạm đạo đức, nguyên tắc hoặc phẩm giá cá nhân).',
    'HSK 4',
    75,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他宁可自己多吃点儿苦，也绝不给别人添麻烦。',
      'Tā nìngkě zìjǐ duō chī diǎnr kǔ, yě jué bù gěi biérén tiān máfan.',
      'Anh ấy thà rằng bản thân chịu khổ thêm một chút, chứ quyết không gây phiền hà cho người khác.',
      '"宁可...也绝不..." thể hiện phẩm chất tự trọng cao, sẵn sàng chịu vất vả vì tập thể.'
    ),
    (
      v_gp_id,
      '我们宁可在前期调研中多花时间，也不能盲目上马未经论证的项目。',
      'Wǒmen nìngkě zài qiánqī diàoyán zhōng duō huā shíjiān, yě bù néng mángmù shàngmǎ wèijīng lùnzhèng de xiàngmù.',
      'Chúng ta thà rằng dành nhiều thời gian hơn trong khâu khảo sát ban đầu, chứ không thể mù quáng triển khai dự án chưa qua kiểm định.',
      '"宁可...也不能..." nhấn mạnh nguyên tắc thận trọng khoa học trong quản lý dự án.'
    );

  -- Điểm ngữ pháp #76: Cấu trúc lựa chọn thông minh ưu việt "与其...不如..." (Thà rằng... còn hơn / Thay vì... thì nên...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc lựa chọn thông minh ưu việt "与其...不如..." (Thà rằng... còn hơn / Thay vì... thì nên...)',
    '与其 + Phương án kém hiệu quả/thụ động, 不如 + Phương án sáng suốt/chủ động',
    'Liên từ',
    '"与其...不如..." (yǔqí... bùrú...) dùng để so sánh hai phương án giải quyết vấn đề, nhằm khuyên bảo hoặc quyết định từ bỏ phương án ở vế trước (thụ động, tốn công vô ích) để lựa chọn phương án ở vế sau (thông minh, tích cực và có lợi hơn nhiều).',
    'HSK 4',
    76,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '与其坐在家里无谓地抱怨生活，不如站起来用行动改变现状。',
      'Yǔqí zuò zài jiālǐ wúwèi de bàoyuàn shēnghuó, bùrú zhàn qǐlái yòng xíngdòng gǎibiàn xiànzhuàng.',
      'Thay vì ngồi ở nhà than vãn về cuộc sống một cách vô ích, thà rằng đứng dậy dùng hành động để thay đổi hiện trạng.',
      '"与其...不如..." khuyên đối phương chuyển hóa năng lượng tiêu cực thành hành động thiết thực.'
    ),
    (
      v_gp_id,
      '与其花大价钱买昂贵的补品，真不如平时养成规律作息的健康习惯。',
      'Yǔqí huā dà jiàqian mǎi ángguì de bǔpǐn, zhēn bùrú píngshí yǎngchéng guīlǜ zuòxī de jiànkāng xíguàn.',
      'Thay vì bỏ số tiền lớn mua đồ bổ đắt đỏ, thật chẳng thà rèn luyện thói quen sinh hoạt điều độ hằng ngày.',
      '"与其...真不如..." so sánh sự vượt trội về giá trị của lối sống lành mạnh so với việc lạm dụng thực phẩm chức năng.'
    );

  -- Điểm ngữ pháp #77: Cấu trúc điều kiện bắt buộc duy nhất "除非...否则..." (Trừ phi... nếu không...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc điều kiện bắt buộc duy nhất "除非...否则..." (Trừ phi... nếu không...)',
    '除非 + Điều kiện tiên quyết duy nhất, 否则 / 不然 + Hậu quả tiêu cực tất yếu',
    'Liên từ',
    '"除非...否则..." (chúfēi... fǒuzé...) chỉ ra điều kiện duy nhất bắt buộc phải thực hiện để ngăn chặn một hậu quả xấu (trừ phi... nếu không thì). Vế "除非" đưa ra lối thoát duy nhất, vế "否则" nêu rõ kết cục không mong muốn nếu điều kiện đó không được đáp ứng.',
    'HSK 4',
    77,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '除非双方都作出实质性的让步，否则这次和谈很难取得成功。',
      'Chúfēi shuāngfāng dōu zuòchū shízhìxìng de ràngbù, fǒuzé zhè cì hétán hěn nán qǔdé chénggōng.',
      'Trừ phi cả hai bên đều đưa ra sự nhượng bộ thực chất, nếu không thì cuộc hòa đàm này rất khó giành được thành công.',
      '"除非...否则..." khẳng định sự nhượng bộ lẫn nhau là chìa khóa duy nhất cứu vãn cuộc đàm phán.'
    ),
    (
      v_gp_id,
      '除非你有医院开具的假条，否则这次缺席将被记作旷课。',
      'Chúfēi nǐ yǒu yīyuàn kāijù de jiàtiáo, fǒuzé zhè cì quēxí jiāng bèi jìzuò kuàngkè.',
      'Trừ phi em có giấy xin phép nghỉ của bệnh viện cấp, nếu không buổi vắng mặt này sẽ bị tính là trốn học.',
      '"除非...否则..." nêu rõ quy chế quản lý điểm danh học đường nghiêm khắc.'
    );

  -- Điểm ngữ pháp #78: Cấu trúc lựa chọn loại trừ nhị phân "要么...要么..." (Hoặc là... hoặc là...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc lựa chọn loại trừ nhị phân "要么...要么..." (Hoặc là... hoặc là...)',
    '要么 + Phương án A, 要么 + Phương án B (buộc chọn 1 trong 2)',
    'Liên từ',
    '"要么...要么..." (yàome... yàome...) đưa ra hai phương án loại trừ lẫn nhau, bắt buộc chủ thể chỉ được chọn một trong hai chứ không thể cùng lúc thực hiện cả hai hoặc không chọn phương án nào (hoặc là... hoặc là).',
    'HSK 4',
    78,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '面对严峻的考验，我们要么勇敢向前冲，要么被竞争彻底淘汰。',
      'Miànduì yánjùn de kǎoyàn, wǒmen yàome yǒnggǎn xiàng qián chōng, yàome bèi jìngzhēng chèdǐ táotài.',
      'Đối mặt với thử thách gay gắt, chúng ta hoặc là dũng cảm xông về phía trước, hoặc là bị quy luật cạnh tranh đào thải hoàn toàn.',
      '"要么...要么..." đặt ra thế trận bắt buộc phải chiến đấu sinh tồn trong môi trường cạnh tranh.'
    ),
    (
      v_gp_id,
      '放假期间，他要么在图书馆静心读书，要么去健身房锻炼身体。',
      'Fàngjià qījiān, tā yàome zài túshūguǎn jìngxīn dúshū, yàome qù jiànshēnfáng duànliàn shēntǐ.',
      'Trong suốt kỳ nghỉ, cậu ấy hoặc là ở trong thư viện tĩnh tâm đọc sách, hoặc là đến phòng gym rèn luyện thân thể.',
      '"要么...要么..." liệt kê hai hoạt động giải trí lành mạnh duy nhất được luân phiên chọn lựa.'
    );

  -- Điểm ngữ pháp #79: Cấu trúc liệt kê song song hai phương diện "一方面...另一方面..." (Một mặt... mặt khác...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc liệt kê song song hai phương diện "一方面...另一方面..." (Một mặt... mặt khác...)',
    'Chủ ngữ + 一方面..., 另一方面... / 一方面 + Mệnh đề 1, 另一方面 + Mệnh đề 2',
    'Liên từ',
    '"一方面...另一方面..." (yī fāngmiàn... lìng yī fāngmiàn...) dùng để phân tích hai khía cạnh, hai nguyên nhân hoặc hai mục đích song hành của một vấn đề. Hai phương diện này có thể bổ sung cho nhau hoặc tương phản nhau nhằm tạo ra cái nhìn toàn diện.',
    'HSK 4',
    79,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '利用假期去企业实习，一方面可以积累工作经验，另一方面也能赚取零花钱。',
      'Lìyòng jiàqī qù qǐyè shíxí, yì fāngmiàn kěyǐ jīlěi gōngzuò jīngyàn, lìng yì fāngmiàn yě néng zhuànqǔ línghuāqián.',
      'Tận dụng kỳ nghỉ đi thực tập tại doanh nghiệp, một mặt có thể tích lũy kinh nghiệm làm việc, mặt khác cũng kiếm thêm được tiền tiêu vặt.',
      '"一方面...另一方面..." phân tích hai lợi ích song hành thiết thực của việc đi thực tập hè.'
    ),
    (
      v_gp_id,
      '这项新政策一方面鼓励科技创新，另一方面加大了对知识产权的保护力度。',
      'Zhè xiàng xīn zhèngcè yì fāngmiàn gǔlì kējì chuàngxīn, lìng yì fāngmiàn jiādà le duì zhīshi chǎnquán de bǎohù lìdù.',
      'Chính sách mới này một mặt khuyến khích đổi mới công nghệ, mặt khác tăng cường cường độ bảo hộ quyền sở hữu trí tuệ.',
      'Cấu trúc nêu rõ hai mũi nhọn chiến lược bổ trợ lẫn nhau của chính sách nhà nước.'
    );

  -- Điểm ngữ pháp #80: Cấu trúc nhấn mạnh cực hạn "连...也/都..." (Ngay cả... cũng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc nhấn mạnh cực hạn "连...也/都..." (Ngay cả... cũng...)',
    '连 + Thành phần cực đoan (Chủ ngữ/Tân ngữ) + 也 / 都 + Vị ngữ',
    'Cấu trúc cố định',
    '"连...也/都..." (lián... yě/dōu...) đưa ra một đối tượng hoặc tình huống cực đoan, dễ thấy hoặc tối thiểu nhất để làm đòn bẩy nhấn mạnh ý nghĩa: đối tượng tối thiểu này còn như vậy thì những đối tượng khác hiển nhiên càng như thế.',
    'HSK 4',
    80,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这道菜的味道实在太辣了，连平时最喜欢吃辣椒的四川朋友都受不了。',
      'Zhè dào cài de wèidào shízài tài là le, lián píngshí zuì xǐhuan chī làjiāo de Sìchuān péngyou dōu shòubùliǎo.',
      'Món ăn này vị cay quá chừng, ngay cả người bạn Tứ Xuyên bình thường thích ăn ớt nhất cũng không chịu nổi.',
      '"连...四川朋友都..." dùng thói quen ăn cay nổi tiếng của người Tứ Xuyên làm thước đo nhấn mạnh độ cay tột bực.'
    ),
    (
      v_gp_id,
      '他今天工作忙得不可开交，连中午饭都顾不上吃。',
      'Tā jīntiān gōngzuò máng de bùkěkāijiāo, lián zhōngwǔfàn dōu gùbushàng chī.',
      'Hôm nay anh ấy bận đến mức tối mắt tối mũi, ngay cả cơm trưa cũng chẳng đoái hoài ăn được.',
      '"连中午饭都..." đưa bữa trưa (nhu cầu sinh học cơ bản) ra làm ví dụ cực tả mức độ bận rộn.'
    );

  -- Điểm ngữ pháp #81: Phân biệt câu điều kiện đủ "只要...就..." và điều kiện cần "只有...才..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phân biệt câu điều kiện đủ "只要...就..." và điều kiện cần "只有...才..."',
    '只要 + Điều kiện đủ + 就 + Kết quả / 只有 + Điều kiện duy nhất + 才 + Kết quả',
    'Liên từ',
    '"只要...就..." (zhǐyào... jiù...) biểu thị điều kiện thỏa mãn là đủ để tạo ra kết quả (chỉ cần có điều kiện này là có kết quả ngay); trong khi "只有...才..." (zhǐyǒu... cái...) biểu thị điều kiện bắt buộc, tiên quyết và duy nhất (chỉ khi nào có điều kiện này thì mới đạt được kết quả, không có nó thì không thể).',
    'HSK 4',
    81,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只要我们齐心协力互相配合，就一定能够战胜眼前的困难。',
      'Zhǐyào wǒmen qíxīnxiélì hùxiāng pèihé, jiù yídìng nénggòu zhànshèng yǎnqián de kùnnan.',
      'Chỉ cần chúng ta đồng tâm hiệp lực phối hợp với nhau thì nhất định sẽ có thể chiến thắng khó khăn trước mắt.',
      '"只要...就..." khẳng định sự đoàn kết là điều kiện đầy đủ để đạt được thắng lợi vẻ vang.'
    ),
    (
      v_gp_id,
      '只有不断学习新知识，才能在日新月异的信息时代保持竞争力。',
      'Zhǐyǒu búduàn xuéxí xīn zhīshi, cái néng zài rìxīnyuèyì de xìnxī shídài bǎochí jìngzhēnglì.',
      'Chỉ khi không ngừng học hỏi kiến thức mới thì mới có thể duy trì sức cạnh tranh trong thời đại thông tin đổi mới từng ngày.',
      '"只有...才能..." xác định việc học tập liên tục là con đường duy nhất để giữ vững ưu thế.'
    );

  -- Điểm ngữ pháp #82: Cấu trúc điều kiện phiếm chỉ toàn diện "无论/不管...都/也..." (Bất luận / Bất kể... đều...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc điều kiện phiếm chỉ toàn diện "无论/不管...都/也..." (Bất luận / Bất kể... đều...)',
    '无论 / 不管 + Từ để hỏi / A 还是 B / Chính phản + 都 / 也 + Vị ngữ',
    'Liên từ',
    '"无论/不管...都/也..." (wúlùn/bùguǎn... dōu/yě...) biểu thị trong bất kỳ tình huống, điều kiện hoặc sự lựa chọn nào thì kết quả hay hành vi ở vế sau vẫn bất biến, không hề chịu ảnh hưởng (dù thế nào chăng nữa thì vẫn cứ). Vế trước bắt buộc phải chứa hình thức lựa chọn, từ để hỏi nghi vấn hoặc cặp đối lập.',
    'HSK 4',
    82,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '不管外界环境发生什么变化，我们都必须坚持诚信经营的理念。',
      'Bùguǎn wàijiè huánjìng fāshēng shénme biànhuà, wǒmen dōu bìxū jiānchí chéngxìn jīngyíng de lǐniàn.',
      'Bất kể môi trường bên ngoài phát sinh biến đổi gì, chúng ta đều phải kiên trì quan niệm kinh doanh chữ tín hàng đầu.',
      '"不管...什么变化...都..." nhấn mạnh nguyên tắc đạo đức kinh doanh không đổi trước mọi biến động thương trường.'
    ),
    (
      v_gp_id,
      '无论是刮风还是下雨，交警同志都会坚守在交通指挥岗位上。',
      'Wúlùn shì guāfēng háishì xiàyǔ, jiāojǐng tóngzhì dōu huì jiānshǒu zài jiāotōng zhǐhuī gǎngwèi shang.',
      'Bất luận là giông gió hay mưa tuôn, các chiến sĩ cảnh sát giao thông đều bám trụ trên vị trí điều tiết giao thông.',
      '"无论是...还是...都..." bao quát cả hai điều kiện thời tiết xấu để ca ngợi tinh thần trách nhiệm của cảnh sát.'
    );

  -- Điểm ngữ pháp #83: Bổ ngữ xu hướng kép phái sinh "起来" (Bắt đầu và tiếp diễn / Đánh giá nhận định)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép phái sinh "起来" (Bắt đầu và tiếp diễn / Đánh giá nhận định)',
    'Động từ + 起来 (Bắt đầu và tiếp diễn) / Động từ (看/听/想/尝) + 起来 (Đánh giá)',
    'Bổ ngữ',
    '"起来" (qilai) mang hai nghĩa phái sinh đặc thù quan trọng ở HSK 4: 1) Biểu thị hành động hoặc trạng thái bắt đầu phát sinh và tiếp tục phát triển (như 唱起来, 哭起来, 热闹起来); 2) Đứng sau các động từ tri giác (看, 听, 尝, 闻, 想) để đưa ra nhận xét, đánh giá từ góc độ của giác quan đó (như 看起来 - trông có vẻ, 听起来 - nghe chừng).',
    'HSK 4',
    83,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听到这个令人振奋的好消息，整个办公室顿时欢呼起来。',
      'Tīngdào zhè ge lìng rén zhènfèn de hǎo xiāoxi, zhěng gè bàngōngshì dùnshí huānhū qǐlai.',
      'Nghe được tin mừng đầy phấn khởi này, toàn bộ văn phòng lập tức reo hò rộn ràng lên.',
      '"欢呼起来" biểu thị động tác reo hò bắt đầu bùng nổ và tiếp diễn náo nhiệt.'
    ),
    (
      v_gp_id,
      '这首古典音乐旋律优美，听起来让人感觉非常放松舒适。',
      'Zhè shǒu gǔdiǎn yīnyuè xuánlǜ yōuměi, tīng qǐlai ràng rén gǎnjué fēicháng fàngsōng shūshì.',
      'Khúc nhạc cổ điển này giai điệu êm ái, nghe chừng khiến cho con người cảm thấy rất thư thái dễ chịu.',
      '"听起来" dùng giác quan thính giác làm cơ sở đánh giá chất lượng và cảm xúc âm nhạc mang lại.'
    );

  -- Điểm ngữ pháp #84: Bổ ngữ xu hướng kép phái sinh "下去" (Tiếp tục duy trì sang tương lai)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép phái sinh "下去" (Tiếp tục duy trì sang tương lai)',
    'Động từ + 下去 (坚持 / 学 / 活 / 走 / 讲 / 读 + 下去)',
    'Bổ ngữ',
    '"下去" (xiàqu) khi làm bổ ngữ phái sinh biểu thị một hành động hoặc trạng thái vốn đang được tiến hành sẽ tiếp tục duy trì, kéo dài từ thời điểm hiện tại hướng về tương lai (làm tiếp đi, duy trì tiếp). Thường dùng ở dạng khẳng định động viên hoặc phủ định "V + 不下去" (không thể tiếp tục nổi).',
    'HSK 4',
    84,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '既然你选择了学习中文，就要克服一切困难坚持学下去。',
      'Jìrán nǐ xuǎnzé le xuéxí zhōngwén, jiù yào kèfú yíqiè kùnnan jiānchí xué xiàqu.',
      'Đã cậu chọn học tiếng Trung thì phải khắc phục mọi khó khăn để kiên trì học tiếp.',
      '"坚持学下去" cổ vũ đối phương giữ vững ý chí kiên định duy trì việc học tập trong tương lai dài lâu.'
    ),
    (
      v_gp_id,
      '会议时间太长，如果再这样争论下去，恐怕今天很难得出结论。',
      'Huìyì shíjiān tài cháng, rúguǒ zài zhèyàng zhēnglùn xiàqu, kǒngpà jīntiān hěn nán déchū jiélùn.',
      'Thời gian cuộc họp quá dài rồi, nếu còn tiếp tục tranh cãi mãi như thế này, e rằng hôm nay khó đưa ra được kết luận.',
      '"再这样争论下去" cảnh báo việc kéo dài tranh cãi vô ích sẽ làm đình trệ công việc.'
    );

  -- Điểm ngữ pháp #85: Bổ ngữ xu hướng kép phái sinh "下来" (Cố định, lưu giữ / Kéo dài từ quá khứ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép phái sinh "下来" (Cố định, lưu giữ / Kéo dài từ quá khứ)',
    'Động từ + 下来 (记 / 写 / 停 / 留 / 传承 + 下来)',
    'Bổ ngữ',
    '"下来" (xialai) mang hai nghĩa phái sinh chính: 1) Biểu thị hành động làm cho sự vật chuyển từ động sang tĩnh, cố định lại hoặc lưu giữ lại một thông tin, hình ảnh (như 记下来 - ghi chép lại, 拍下来 - chụp lại, 留下来 - ở lại); 2) Biểu thị hành động hoặc truyền thống được tiếp nối từ quá khứ đến hiện tại (như 传下来 - lưu truyền lại).',
    'HSK 4',
    85,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '老师讲的重要考点，请大家一定要在笔记本上完整地记下来。',
      'Lǎoshī jiǎng de zhòngyào kǎodiǎn, qǐng dàjiā yídìng yào zài bǐjìběn shang wánzhěng de jì xialai.',
      'Những trọng điểm thi quan trọng thầy giáo giảng, xin mọi người nhất định phải ghi chép lại đầy đủ vào vở.',
      '"完整地记下来" dùng "下来" thể hiện hành động ghi chép lưu giữ kiến thức trên giấy tờ.'
    ),
    (
      v_gp_id,
      '这项古老的民间手工艺是由老一辈手艺人一代代流传下来的。',
      'Zhè xiàng gǔlǎo de mínjiān shǒugōngyì shì yóu lǎoyíbèi shǒuyìrén yídàidài liúchuán xialai de.',
      'Kỹ nghệ thủ công dân gian cổ xưa này là do những người thợ thế hệ đi trước truyền lại từ đời này sang đời khác.',
      '"流传下来" thể hiện dòng chảy văn hóa tiếp nối từ lịch sử xa xưa tới hiện đại.'
    );

  -- Điểm ngữ pháp #86: Bổ ngữ xu hướng kép phái sinh "出来" (Từ ẩn sang hiện / Nhận diện / Sáng tạo)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép phái sinh "出来" (Từ ẩn sang hiện / Nhận diện / Sáng tạo)',
    'Động từ + 出来 (看 / 认 / 想 / 听 / 制作 + 出来)',
    'Bổ ngữ',
    '"出来" (chulai) làm bổ ngữ phái sinh có ba trường hợp tiêu biểu: 1) Sự vật từ trạng thái ẩn giấu, vô hình chuyển thành hiển lộ, nhìn thấy rõ ràng (như 太阳钻出来了); 2) Năng lực phân biệt, nhận diện rõ người hoặc vật qua tri giác (như 认出来 - nhận ra, 看出来 - nhìn ra được sự việc); 3) Hoàn thành một sản phẩm sáng tạo từ chỗ chưa có (như 想出办法来, 制作出来).',
    'HSK 4',
    86,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '虽然他戴着帽子和口罩，但我还是一眼就认出了他。',
      'Suīrán tā dàizhe màozi hé kǒuzhào, dàn wǒ háishì yìyǎn jiù rènchū le tā.',
      'Tuy rằng anh ấy đội mũ và đeo khẩu trang, nhưng tôi vẫn nhận ngay ra anh ấy chỉ bằng một ánh nhìn.',
      '"认出来" biểu thị năng lực nhận biết chính xác người quen bất chấp việc cải trang.'
    ),
    (
      v_gp_id,
      '经过三天三夜的反复讨论，工程师们终于想出了解决故障的好方案。',
      'Jīngguò sān tiān sān yè de fǎnfù tǎolùn, gōngchéngshīmen zhōngyú xiǎngchū le jiějué gùzhàng de hǎo fāng''àn.',
      'Sau ba ngày ba đêm thảo luận liên tục, các kỹ sư cuối cùng đã nghĩ ra được phương án tuyệt vời giải quyết sự cố.',
      '"想出来" diễn tả thành quả tư duy sáng tạo từ chỗ bế tắc đến khi nảy ra giải pháp mới.'
    );

  -- Điểm ngữ pháp #87: Bổ ngữ xu hướng kép phái sinh "过来" (Hồi phục trạng thái bình thường)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép phái sinh "过来" (Hồi phục trạng thái bình thường)',
    'Động từ + 过来 (醒 / 明白 / 反应 / 改 / 缓 + 过来)',
    'Bổ ngữ',
    '"过来" (guolai) khi mang nghĩa phái sinh biểu thị sự hồi phục hoặc chuyển biến từ một trạng thái tiêu cực, sai lệch hoặc bất thường trở về trạng thái tỉnh táo, chuẩn mực và tích cực ban đầu (như 醒过来 - tỉnh lại, 明白过来 - hiểu ra, 改过来 - sửa đúng lại, 缓过劲来 - hồi sức lại).',
    'HSK 4',
    87,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '医生全力抢救了几个小时，昏迷的伤员终于慢慢醒过来了。',
      'Yīshēng quánlì qiǎngjiù le jǐ gè xiǎoshí, hūnmí de shāngyuán zhōngyú mànmàn xǐng guolai le.',
      'Bác sĩ dốc sức cấp cứu mấy tiếng đồng hồ, người bị thương hôn mê cuối cùng đã từ từ tỉnh lại.',
      '"醒过来" chỉ sự hồi phục ý thức từ trạng thái hôn mê sâu nguy kịch trở về trạng thái tỉnh táo.'
    ),
    (
      v_gp_id,
      '听了老师耐心的启发，他才猛然明白过来自己错在哪里。',
      'Tīng le lǎoshī nàixīn de qǐfā, tā cái měngrán míngbai guolai zìjǐ cuò zài nǎlǐ.',
      'Nghe lời khuyên bảo kiên trì của thầy giáo, cậu ấy mới bừng tỉnh hiểu ra mình sai ở chỗ nào.',
      '"明白过来" diễn tả sự chuyển biến nhận thức từ u mê, mơ hồ sang thấu tỏ bản chất.'
    );

  -- Điểm ngữ pháp #88: Bổ ngữ xu hướng kép phái sinh "过去" (Rơi vào trạng thái bất tỉnh hoặc bất lợi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép phái sinh "过去" (Rơi vào trạng thái bất tỉnh hoặc bất lợi)',
    'Động từ + 过去 (晕 / 昏 / 昏厥 + 过去)',
    'Bổ ngữ',
    '"过去" (guoqu) là phản nghĩa của "过来", khi làm bổ ngữ phái sinh diễn tả trạng thái con người bị mất ý thức, ngất lịm, rời xa trạng thái bình thường (rơi vào hôn mê, ngất đi) hoặc chỉ sự vật bị suy vong, chết đi.',
    'HSK 4',
    88,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听到这个突如其来的噩耗，老奶奶经受不住打击，直接晕了过去。',
      'Tīngdào zhè ge tūrúqílái de èhào, lǎonǎinai jīngshòu bú zhù dǎjī, zhíjiē yūn le guoqu.',
      'Nghe tin dữ đột ngột ập đến này, người bà không chịu nổi cú sốc, đã ngất lịm đi ngay tại chỗ.',
      '"晕了过去" miêu tả tình trạng ngất xỉu, mất hoàn toàn tri giác trước cú sốc tinh thần quá lớn.'
    ),
    (
      v_gp_id,
      '运动员由于严重脱水和体力透支，冲过终点线后瞬间昏了过去。',
      'Yùndòngyuán yóuyú yánzhòng tuōshuǐ hé tǐlì tòuzhī, chōngguò zhōngdiǎnxiàn hòu shùnjiān hūn le guoqu.',
      'Vận động viên do mất nước nghiêm trọng và kiệt sức, sau khi lao qua vạch đích đã lập tức ngất đi.',
      '"昏了过去" ghi nhận trạng thái hôn mê do suy kiệt thể lực tột cùng trên đường đua.'
    );

  -- Điểm ngữ pháp #89: Bổ ngữ kết quả phái sinh "上" (Gắn kết, tiếp xúc, đạt mục tiêu)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả phái sinh "上" (Gắn kết, tiếp xúc, đạt mục tiêu)',
    'Động từ + 上 (关 / 穿 / 锁 / 考 / 爱 / 谈 / 遇 + 上)',
    'Bổ ngữ',
    '"上" (shang) làm bổ ngữ kết quả mang các nghĩa phái sinh đặc thù: 1) Hai vật thể tiếp xúc dính liền, khép kín lại với nhau (như 关上门, 穿上衣服, 锁上柜子); 2) Đạt được một mục đích hoặc kết quả mong muốn (như 考上大学 - thi đỗ đại học); 3) Bắt đầu nảy sinh một mối quan hệ tình cảm hoặc sự kiện (như 爱上 - yêu, 遇上 - gặp gỡ).',
    'HSK 4',
    89,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '功夫不负有心人，经过刻苦努力他终于考上了心仪的名牌大学。',
      'Gōngfu bú fù yǒuxīnrén, jīngguò kèkǔ nǔlì tā zhōngyú kǎoshàng le xīnyí de míngpái dàxué.',
      'Công phu không phụ lòng người, sau bao nỗ lực gian khổ cuối cùng anh ấy đã thi đỗ vào trường đại học danh tiếng ước mơ.',
      '"考上大学" dùng "上" làm bổ ngữ kết quả biểu thị việc đạt được mục tiêu thi cử thành công rực rỡ.'
    ),
    (
      v_gp_id,
      '出门前请检查水龙头和电源，并记得随手把大门锁上。',
      'Chūmén qián qǐng jiǎnchá shuǐlóngtóu hé diànyuán, bìng jìde suíshǒu bǎ dàmén suǒshang.',
      'Trước khi ra khỏi nhà xin hãy kiểm tra vòi nước và nguồn điện, đồng thời nhớ tiện tay khóa chặt cửa chính lại.',
      '"锁上" biểu thị hành động tra chìa khóa làm cho hai cánh cửa gắn chặt đóng kín an toàn.'
    );

  -- Điểm ngữ pháp #90: Bổ ngữ kết quả phái sinh "开" (Tách rời, mở rộng, dàn trải)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả phái sinh "开" (Tách rời, mở rộng, dàn trải)',
    'Động từ + 开 (打 / 分 / 走 / 离 / 散 / 展 + 开)',
    'Bổ ngữ',
    '"开" (kāi) làm bổ ngữ kết quả mang nghĩa phân tách, làm cho các bộ phận đang gắn kết tách rời xa nhau ra (như 分开, 离开), hoặc làm cho không gian được mở rộng, bung tỏa ra các hướng (như 打开窗户, 散开, 展开调查).',
    'HSK 4',
    90,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请大家在考场内保持安静，并把书本和文具整齐地分开摆放。',
      'Qǐng dàjiā zài kǎochǎng nèi bǎochí ānjìng, bìng bǎ shūběn hé wénjù zhěngqí de fēnkāi bǎifàng.',
      'Xin mọi người hãy giữ trật tự trong phòng thi, và để tách riêng sách vở với đồ dùng học tập một cách ngay ngắn.',
      '"分开摆放" dùng "开" thể hiện trạng thái phân cách không để đồ dùng chồng chéo lên nhau.'
    ),
    (
      v_gp_id,
      '下课铃响了，操场上的学生们欢笑着迅速向四周散开。',
      'Xiàkè líng xiǎng le, cāochǎng shang de xuéshengmen huānxiàozhe xùnsù xiàng sìzhōu sànkāi.',
      'Chuông tan học reo rồi, học sinh trên sân trường vừa cười nói vừa nhanh chóng tản ra bốn phía.',
      '"散开" miêu tả đám đông di chuyển tản mát về các phương hướng khác nhau.'
    );

  -- Điểm ngữ pháp #91: Bổ ngữ trạng thái phức tạp dẫn mệnh đề "得" (Mức độ cực tả)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ trạng thái phức tạp dẫn mệnh đề "得" (Mức độ cực tả)',
    'Chủ ngữ + Động từ/Tính từ + 得 + Cụm chủ vị / Mệnh đề miêu tả',
    'Bổ ngữ',
    'Ở trình độ HSK 4, thành phần đứng sau trợ từ "得" (de) không chỉ là tính từ đơn lẻ mà phát triển thành một cụm chủ vị hoặc mệnh đề hoàn chỉnh để miêu tả sinh động, cụ thể hóa trạng thái hoặc hệ quả của hành vi đạt tới mức độ kinh ngạc (đến mức mà, đến nỗi mà).',
    'HSK 4',
    91,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '小丑滑稽幽默的表演逗得全场观众哈哈大笑。',
      'Xiǎochǒu huájī yōumò de biǎoyǎn dòu de quánchǎng guānzhòng hāhā dàxiào.',
      'Màn biểu diễn hài hước dí dỏm của chú hề chọc cho toàn thể khán giả cười nghiêng ngả.',
      '"逗得全场观众哈哈大笑" dùng cả cụm chủ vị "全场观众哈哈大笑" làm bổ ngữ trạng thái miêu tả sức hút của tiết mục xiếc.'
    ),
    (
      v_gp_id,
      '听完老爷爷感人的战斗经历，大家感动得眼泪夺眶而出。',
      'Tīngwán lǎoyéye gǎnrén de zhàndòu jīnglì, dàjiā gǎndòng de yǎnlèi duókuàng ér chū.',
      'Nghe xong trải nghiệm chiến đấu xúc động của cụ già, mọi người cảm động đến mức nước mắt trào ra khóe mi.',
      '"感动得眼泪夺眶而出" cực tả mức độ xúc động sâu sắc đến rơi lệ của người nghe.'
    );

  -- Điểm ngữ pháp #92: Câu chữ 把 nâng cao kết hợp vị trí chuyển dịch: "把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 nâng cao kết hợp vị trí chuyển dịch: "把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成"',
    'Chủ ngữ + 把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成 + Nơi chốn / Người nhận / Kết quả',
    'Câu chữ 把',
    'Đây là dạng nâng cao cực kỳ quan trọng của câu chữ 把 trong HSK 4, biểu thị hành vi xử lý làm cho tân ngữ chuyển dịch vị trí (放到... / 留在...), chuyển giao quyền sở hữu (借给... / 送给...), hoặc biến đổi bản chất thành dạng thức mới (翻译成... / 改变成...).',
    'HSK 4',
    92,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请大家把填好的调查问卷交到前面的工作人员手里。',
      'Qǐng dàjiā bǎ tiánhǎo de diàochá wènjuàn jiāodào qiánmiàn de gōngzuò rényuán shǒulǐ.',
      'Xin mọi người hãy nộp phiếu khảo sát đã điền xong vào tay các nhân viên công tác phía trước.',
      'Cấu trúc "把问卷交到...手里" thể hiện sự chuyển dời địa điểm vật lý của tờ phiếu khảo sát.'
    ),
    (
      v_gp_id,
      '翻译官十分熟练地把这篇中文发言稿翻译成了流利的英文。',
      'Fānyìguān shífēn shúliàn de bǎ zhè piān zhōngwén fāyángǎo fānyì chéng le liúlì de yīngwén.',
      'Viên phiên dịch viên hết sức thành thạo dịch bài phát biểu tiếng Trung này thành tiếng Anh lưu loát.',
      'Cấu trúc "把发言稿翻译成英文" thể hiện sự chuyển hóa hình thức ngôn ngữ của văn bản.'
    );

  -- Điểm ngữ pháp #93: Vị trí từ phủ định và động từ năng nguyện trong câu chữ 把
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Vị trí từ phủ định và động từ năng nguyện trong câu chữ 把',
    'Chủ ngữ + 不/没/别/应该/想/愿意 + 把 + Tân ngữ + Động từ + Thành phần khác',
    'Câu chữ 把',
    'Quy tắc vàng ngữ pháp tiếng Trung: Từ phủ định (不, 没, 别) và động từ năng nguyện (想, 愿意, 应该, 能够) bắt buộc phải đứng TRƯỚC giới từ "把", tuyệt đối không được chen vào giữa "把" và tân ngữ hoặc sau động từ chính.',
    'HSK 4',
    93,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '你千万不要把这么机密的文件随手放在公共桌子上。',
      'Nǐ qiānwàn bú yào bǎ zhème jīmì de wénjiàn suíshǒu fàng zài gōnggòng zhuōzi shang.',
      'Cậu tuyệt đối đừng tiện tay đặt tài liệu cơ mật như thế này trên bàn làm việc chung.',
      'Phó từ khuyên răn phủ định "千万不要" đứng trước "把" tuân thủ chuẩn xác quy tắc ngữ pháp.'
    ),
    (
      v_gp_id,
      '他平时非常细心，从来没有把客户的联系电话记错。',
      'Tā píngshí fēicháng xìxīn, cónglái méiyǒu bǎ kèhù de liánxì diànhuà jìcuò.',
      'Anh ấy bình thường rất cẩn thận, chưa bao giờ ghi nhầm số điện thoại liên lạc của khách hàng.',
      '"从来没有" là trạng ngữ phủ định đứng trước "把", bảo đảm vị trí chuẩn xác trong câu.'
    );

  -- Điểm ngữ pháp #94: Câu chữ 把 kết hợp bổ ngữ kết quả và bổ ngữ xu hướng phức hợp
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 kết hợp bổ ngữ kết quả và bổ ngữ xu hướng phức hợp',
    'Chủ ngữ + 把 + Tân ngữ + Động từ + Bổ ngữ kết quả / Bổ ngữ xu hướng kép',
    'Câu chữ 把',
    'Trong câu chữ 把, động từ không bao giờ đứng trơ trọi một mình mà bắt buộc phải có thành phần bổ trợ phía sau, phổ biến nhất ở HSK 4 là bổ ngữ kết quả (như 弄坏, 擦干净, 准备好) hoặc bổ ngữ xu hướng kép (như 拿出来, 搬进去, 送回去).',
    'HSK 4',
    94,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '清洁工人用高压水枪把整条街道冲洗得干干净净。',
      'Qīngjié gōngrén yòng gāoyā shuǐqiāng bǎ zhěng tiáo jiēdào chōngxǐ de gāngānjìngjìng.',
      'Công nhân vệ sinh dùng vòi xịt nước áp lực cao xối rửa cả con đường sạch bóng không một vết bẩn.',
      '"把街道冲洗得干干净净" kết hợp câu chữ 把 với bổ ngữ trạng thái miêu tả kết quả sạch sẽ tinh tươm.'
    ),
    (
      v_gp_id,
      '请同学们把书包里的课本和练习册迅速拿出来。',
      'Qǐng tóngxuémen bǎ shūbāo lǐ de kèběn hé liànxícè xùnsù ná chūlái.',
      'Xin các em học sinh hãy nhanh chóng lấy sách giáo khoa và vở bài tập trong cặp ra.',
      '"把课本...拿出来" kết hợp câu chữ 把 với bổ ngữ xu hướng kép "出来" biểu thị hướng chuyển động của sách vở.'
    );

  -- Điểm ngữ pháp #95: Câu bị động nâng cao có tác nhân và ẩn tác nhân với "被"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu bị động nâng cao có tác nhân và ẩn tác nhân với "被"',
    'Chủ ngữ + 被 + (Tác nhân thực hiện) + Động từ + Thành phần khác',
    'Câu bị động',
    'Trong câu bị động chữ "被" ở trình độ HSK 4: 1) Có thể nêu rõ tác nhân gây ra hành động (như 行李被雨淋湿了); 2) Tác nhân có thể được tỉnh lược (ẩn tác nhân) khi không rõ ai làm hoặc muốn nhấn mạnh bản thân đối tượng bị tác động (như 自行车被偷了 - Xe đạp bị trộm mất). Động từ sau "被" cũng bắt buộc phải có thành phần khác kèm theo.',
    'HSK 4',
    95,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '那篇优秀的调查报道被几家主流新闻媒体在头版转载。',
      'Nà piān yōuxiù de diàochá bàodào bèi jǐ jiā zhǔliú xīnwén méitǐ zài tóubǎn zhuǎnzǎi.',
      'Bài phóng sự điều tra xuất sắc đó đã được mấy cơ quan truyền thông báo chí chính thống đăng lại trên trang nhất.',
      'Câu bị động nêu rõ tác nhân "几家主流新闻媒体" làm rõ cơ quan báo chí đứng ra tái bản bài báo.'
    ),
    (
      v_gp_id,
      '放在阳台上的几盆鲜花被昨晚的大暴雨砸坏了。',
      'Fàng zài yángtái shang de jǐ pén xiānhuā bèi zuówǎn de dà bàoyǔ záhuài le.',
      'Mấy chậu hoa tươi đặt ở ban công đã bị cơn mưa rào lớn đêm qua dập nát hỏng hết.',
      '"被大暴雨砸坏了" kết hợp câu bị động với bổ ngữ kết quả "坏", tác nhân gây hại là thời tiết mưa to.'
    );

  -- Điểm ngữ pháp #96: Câu biểu thị bị động cảm thụ và đón nhận với "受" (Được / Bị)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu biểu thị bị động cảm thụ và đón nhận với "受" (Được / Bị)',
    'Chủ ngữ + 受到 / 受 + Danh từ/Động từ (欢迎 / 尊重 / 感动 / 骗 / 惩罚)',
    'Câu bị động',
    'Ngoài chữ "被", tiếng Trung HSK 4 thường dùng "受" (shòu) hoặc "受到" để tạo thành câu bị động mang tính cảm thụ. Khi kết hợp với từ ngữ tích cực (欢迎, 尊重, 表扬), nó mang nghĩa là "được"; khi kết hợp với từ ngữ tiêu cực (骗, 处分, 惩罚), nó mang nghĩa là "bị".',
    'HSK 4',
    96,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '王老师讲课幽默生动，在学校里受到了全体学生的热烈欢迎。',
      'Wáng lǎoshī jiǎngkè yōumò shēngdòng, zài xuéxiào lǐ shòudào le quántǐ xuésheng de rèliè huānyíng.',
      'Thầy Vương giảng bài hài hước sinh động, ở trường được toàn thể học sinh nhiệt liệt hoan nghênh.',
      '"受到了...热烈欢迎" biểu thị câu bị động thụ hưởng sự mến mộ tích cực từ học trò.'
    ),
    (
      v_gp_id,
      '由于轻信了网络上的虚假投资广告，他上当受骗损失了一大笔钱。',
      'Yóuyú qīngxìn le wǎngluò shang de xūjiǎ tóuzī guǎnggào, tā shàngdàng shòupiàn sǔnshī le yí dà bǐ qián.',
      'Do nhẹ dạ tin vào quảng cáo đầu tư giả mạo trên mạng, anh ta đã sập bẫy bị lừa mất một khoản tiền lớn.',
      '"上当受骗" là cách dùng bị động mang ý nghĩa tiêu cực khi bị kẻ gian lừa gạt tài sản.'
    );

  -- Điểm ngữ pháp #97: Câu so sánh hơn nâng cao kèm lượng từ sai biệt cụ thể
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu so sánh hơn nâng cao kèm lượng từ sai biệt cụ thể',
    'A 比 B + Tính từ + 得多 / 多了 / 一些 / 一点儿 / Số từ + Lượng từ',
    'Câu so sánh',
    'Trong câu so sánh chữ "比" ở trình độ HSK 4, để diễn đạt mức độ sai biệt giữa hai đối tượng, ta đặt thành phần đo lường ở SAU tính từ: 1) Sai biệt lớn: Tính từ + 得多 / 多了; 2) Sai biệt nhỏ: Tính từ + 一些 / 一点儿; 3) Sai biệt chuẩn xác: Tính từ + Số từ + Lượng từ (như 大五岁, 贵二十块).',
    'HSK 4',
    97,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '坐高铁从北京到上海比坐普通火车快得多，节省了整整八个小时。',
      'Zuò gāotiě cóng Běijīng dào Shànghǎi bǐ zuò pǔtōng huǒchē kuài de duō, jiéshěng le zhěngzhěng bā gè xiǎoshí.',
      'Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải nhanh hơn nhiều so với tàu hỏa thường, tiết kiệm trọn vẹn 8 tiếng.',
      '"快得多" đặt sau tính từ "快" biểu thị khoảng cách chênh lệch tốc độ vượt trội của đường sắt cao tốc.'
    ),
    (
      v_gp_id,
      '弟弟今年刚满十八岁，足足比他的表哥高了五厘米。',
      'Dìdi jīnnián gāng mǎn shíbā suì, zúzú bǐ tā de biǎogē gāo le wǔ límǐ.',
      'Em trai năm nay vừa tròn 18 tuổi, đã cao hơn người anh họ của mình tròn 5 centimet.',
      '"高了五厘米" dùng lượng từ số lượng cụ thể "五厘米" để đo lường độ chênh lệch chiều cao.'
    );

  -- Điểm ngữ pháp #98: Câu so sánh hơn tăng tiến có phó từ "更" / "还"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu so sánh hơn tăng tiến có phó từ "更" / "还"',
    'A 比 B + 更 / 还 + Tính từ (B vốn đã có tính chất đó, A lại vượt trội hơn)',
    'Câu so sánh',
    'Khi muốn diễn đạt đối tượng B vốn dĩ đã mang một đặc tính ở mức độ cao, nhưng đối tượng A thậm chí còn vượt trội hơn B nữa, ta thêm phó từ "更" hoặc "还" vào trước tính từ vị ngữ trong câu so sánh chữ 比. Lưu ý tuyệt đối không dùng "很", "真", "非常" trong câu chữ 比.',
    'HSK 4',
    98,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这篇课文生词很多，但下一篇课文的语法比这篇还要复杂。',
      'Zhè piān kèwén shēngcí hěn duō, dàn xià yì piān kèwén de yǔfǎ bǐ zhè piān hái yào fùzá.',
      'Bài khóa này từ mới rất nhiều, nhưng ngữ pháp của bài khóa tiếp theo còn phức tạp hơn cả bài này nữa.',
      '"还要复杂" tiền giả định bài khóa 1 đã khó, bài khóa 2 mức độ phức tạp càng được đẩy lên tầng cao hơn.'
    ),
    (
      v_gp_id,
      '在激烈的市场竞争中，企业的创新能力比资金实力更为重要。',
      'Zài jīliè de shìchǎng jìngzhēng zhōng, qǐyè de chuàngxīn nénglì bǐ zījīn shílì gèng wéi zhòngyào.',
      'Trong cạnh tranh thị trường khốc liệt, năng lực đổi mới sáng tạo của doanh nghiệp còn quan trọng hơn cả tiềm lực tài chính.',
      '"更为重要" so sánh hai nhân tố quan trọng để khẳng định yếu tố sáng tạo mang tính sống còn.'
    );

  -- Điểm ngữ pháp #99: Phân biệt thể phủ định của câu so sánh: "A 不比 B" vs "A 没有/不如 B"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phân biệt thể phủ định của câu so sánh: "A 不比 B" vs "A 没有/不如 B"',
    'A 不比 B + Tính từ (A không kém gì B / ngang ngửa B) vs A 没有/不如 B + Tính từ (A thua kém B)',
    'Câu so sánh',
    '"A 不比 B + Tính từ" mang hàm ý bác bỏ quan điểm cho rằng A thua kém B, ngụ ý A ngang ngửa hoặc thậm chí hơn B (không kém gì). Trong khi đó, "A 没有 / 不如 B + Tính từ" là so sánh thua kém đơn thuần, thừa nhận mức độ của A thấp hơn B.',
    'HSK 4',
    99,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们虽然是刚创办的小公司，但在产品质量上绝不比大品牌差。',
      'Wǒmen suīrán shì gāng chuàngbàn de xiǎo gōngsī, dàn zài chǎnpǐn zhìliàng shang jué bù bǐ dà pǐnpái chà.',
      'Chúng tôi tuy là công ty nhỏ mới thành lập, nhưng về chất lượng sản phẩm quyết không thua kém gì các thương hiệu lớn.',
      '"不比大品牌差" tự tin khẳng định chất lượng đạt chuẩn ngang hàng với các ông lớn đầu ngành.'
    ),
    (
      v_gp_id,
      '在实际工作经验方面，刚刚入职的新人确实不如老员工丰富。',
      'Zài shíjì gōngzuò jīngyàn fāngmiàn, gānggāng rùzhí de xīnrén quèshí bùrú lǎoyuángōng fēngfù.',
      'Về mặt kinh nghiệm làm việc thực tế, người mới vừa vào công ty quả thực không dồi dào bằng nhân viên kỳ cựu.',
      '"不如老员工丰富" thừa nhận khoảng cách kinh nghiệm khách quan giữa lính mới và nhân viên lâu năm.'
    );

  -- Điểm ngữ pháp #100: Cấu trúc so sánh phát triển theo biến số: "越来越..." vs "越...越..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc so sánh phát triển theo biến số: "越来越..." vs "越...越..."',
    'Chủ ngữ + 越来越 + Tính từ / 越 + Điều kiện A + 越 + Kết quả B',
    'Cấu trúc cố định',
    '"越来越..." (yuè lái yuè...) chỉ sự biến đổi của mức độ theo thời gian tự nhiên (càng ngày càng...); trong khi "越...越..." (yuè... yuè...) là cấu trúc có điều kiện: mức độ của vế sau biến thiên tỷ lệ thuận hoặc phụ thuộc trực tiếp vào mức độ phát triển của hành động/điều kiện ở vế trước (càng... thì càng...).',
    'HSK 4',
    100,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着城市绿化工程的推进，这里的空气质量变得越来越好。',
      'Suízhe chéngshì lǜhuà gōngchéng de tuījìn, zhèlǐ de kōngqì zhìliàng biànde yuè lái yuè hǎo.',
      'Cùng với sự thúc đẩy của công trình phủ xanh đô thị, chất lượng không khí nơi đây trở nên ngày một tốt hơn.',
      '"越来越好" miêu tả sự tiến bộ dần đều của môi trường sống theo dòng thời gian.'
    ),
    (
      v_gp_id,
      '这本书的内容非常引人入胜，让人越读越觉得有意思。',
      'Zhè běn shū de nèiróng fēicháng yǐnrénrùshèng, ràng rén yuè dú yuè juéde yǒu yìsi.',
      'Nội dung cuốn sách này vô cùng lôi cuốn, khiến người ta càng đọc càng cảm thấy thú vị.',
      '"越读越觉得有意思" thể hiện mức độ say mê tăng dần theo từng trang sách được mở ra.'
    );

  -- Điểm ngữ pháp #101: Cấu trúc cố định dẫn nguồn thông tin khách quan: "据..." (Theo như / Căn cứ vào)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định dẫn nguồn thông tin khách quan: "据..." (Theo như / Căn cứ vào)',
    '据 + Nguồn tin (说 / 统计 / 报道 / 专家介绍 / 我所知), Mệnh đề tin tức',
    'Cấu trúc cố định',
    '"据" (jù) là giới từ trang trọng dẫn xuất nguồn gốc của thông tin, số liệu hoặc báo cáo báo chí (theo như, căn cứ theo). Các cụm từ cố định thường gặp trong HSK 4 gồm: 据说 (nghe nói), 据统计 (theo thống kê), 据报道 (theo đưa tin), 据了解 (theo tìm hiểu), 据我所知 (theo như tôi được biết).',
    'HSK 4',
    101,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '据官方权威数据统计，今年该地区的游客接待量突破了五千万人次。',
      'Jù guānfāng quánwēi shùjù tǒngjì, jīnnián gāi dìqū de yóukè jiēdàiliàng tūpò le wǔqiān wàn réncì.',
      'Theo thống kê số liệu có thẩm quyền chính thức, lượng đón khách du lịch của khu vực này năm nay đã vượt mốc 50 triệu lượt người.',
      '"据官方权威数据统计" nâng cao độ tin cậy và chuẩn xác khoa học cho con số du lịch.'
    ),
    (
      v_gp_id,
      '据当地气象台报道，未来三天将有一股强冷空气席卷华北地区。',
      'Jù dāngdì qìxiàngtái bàodào, wèilái sān tiān jiāng yǒu yì gǔ qiáng lěngkōngqì xíjuǎn Huáběi dìqū.',
      'Theo đài khí tượng địa phương đưa tin, trong ba ngày tới sẽ có một đợt không khí lạnh mạnh tràn qua khu vực Hoa Bắc.',
      '"据...报道" trích dẫn nguồn tin báo chí khí tượng chính thống để cảnh báo rét đậm.'
    );

  -- Điểm ngữ pháp #102: Cấu trúc cố định nêu quan điểm nhận định: "在我看来" / "从...来看" / "总的来说"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định nêu quan điểm nhận định: "在我看来" / "从...来看" / "总的来说"',
    '在我看来, Mệnh đề / 从 + Góc độ + 来看, Mệnh đề / 总的来说, Mệnh đề',
    'Cấu trúc cố định',
    'Đây là các mẫu câu định vị góc nhìn và quy nạp luận điểm chuẩn mực trong văn phong nghị luận tiếng Trung: 1) "在我看来" (theo quan điểm cá nhân tôi); 2) "从...来看" (xét từ góc độ khách quan nào đó); 3) "总的来说" (tổng kết lại, nói một cách tổng quát).',
    'HSK 4',
    102,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在我看来，健康和快乐是人生中最值得珍惜的宝贵财富。',
      'Zài wǒ kànlái, jiànkāng hé kuàilè shì rénshēng zhōng zuì zhíde zhēnxī de bǎoguì cáifù.',
      'Theo quan điểm của tôi, sức khỏe và niềm vui là tài sản quý báu đáng trân trọng nhất trong cuộc đời.',
      '"在我看来" mở đầu một cách nhã nhặn để trình bày nhân sinh quan cá nhân về hạnh phúc.'
    ),
    (
      v_gp_id,
      '总的来说，这次文化交流活动不仅增进了友谊，也取得了丰硕的成果。',
      'Zǒng de lái shuō, zhè cì wénhuà jiāoliú huódòng bùjǐn zēngjìn le yǒuyì, yě qǔdé le fēngshuò de chéngguǒ.',
      'Nhìn chung mà nói, hoạt động giao lưu văn hóa lần này chẳng những thắt chặt tình hữu nghị mà còn đạt được những thành quả phong phú.',
      '"总的来说" đứng đầu câu để đúc kết toàn diện thành công của chuyến giao lưu.'
    );

  -- Điểm ngữ pháp #103: Cấu trúc cố định phân tích dẫn chứng điển hình: "拿...来说" (Lấy... làm ví dụ / Xét về)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định phân tích dẫn chứng điển hình: "拿...来说" (Lấy... làm ví dụ / Xét về)',
    '拿 + Ví dụ điển hình + 来说, Mệnh đề phân tích chi tiết',
    'Cấu trúc cố định',
    '"拿...来说" (ná... lái shuō) dùng để dẫn ra một cá nhân, sự việc hoặc ví dụ điển hình tiêu biểu nhất để minh họa sinh động cho một luận điểm, quy luật chung vừa được nêu ra trước đó (lấy... làm ví dụ mà nói, xét riêng trường hợp...).',
    'HSK 4',
    103,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '中国这几年的移动支付发展极为迅速，拿老年人来说，他们出门买菜也用手机扫码。',
      'Zhōngguó zhè jǐ nián de yídòng zhīfù fāzhǎn jíwéi xùnsù, ná lǎoniánrén láishuō, tāmen chūmén mǎicài yě yòng shǒujī sǎomǎ.',
      'Thanh toán di động những năm gần đây của Trung Quốc phát triển cực kỳ nhanh chóng, lấy người cao tuổi làm ví dụ, họ ra ngoài mua rau cũng dùng điện thoại quét mã.',
      '"拿老年人来说" chọn nhóm người cao tuổi làm minh chứng thuyết phục cho sự phổ cập của công nghệ.'
    ),
    (
      v_gp_id,
      '学习外语需要持之以恒，拿背单词来说，三天打鱼两天晒网是很难记牢的。',
      'Xuéxí wàiyǔ xūyào chízhīyǐhéng, ná bèi dāncí láishuō, sān tiān dǎ yú liǎng tiān shài wǎng shì hěn nán jì láo de.',
      'Học ngoại ngữ cần sự kiên trì bền bỉ, xét về khâu học thuộc từ vựng, nếu bữa đực bữa cái thì rất khó ghi nhớ lâu bền.',
      '"拿背单词来说" lấy công đoạn học từ vựng cụ thể làm ví dụ chứng minh sự cần thiết của tính kiên trì.'
    );

  -- Điểm ngữ pháp #104: Cấu trúc cố định định danh và giải thích bản chất: "所谓的..." & "也就是说..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định định danh và giải thích bản chất: "所谓的..." & "也就是说..."',
    '所谓的 + Danh từ/Khái niệm + 就是... / Mệnh đề 1, 也就是说, Mệnh đề 2 (giải thích tương đương)',
    'Cấu trúc cố định',
    '"所谓的..." (suǒwèi de...) dùng để đưa ra hoặc định nghĩa một thuật ngữ, khái niệm chuyên môn (cái gọi là...); trong khi "也就是说..." (yějiùshìshuō) đóng vai trò diễn giải lại câu nói hoặc mệnh đề phía trước bằng từ ngữ đơn giản, dễ hiểu hơn hoặc rút ra kết luận trực tiếp (tức là, nói cách khác).',
    'HSK 4',
    104,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '所谓的团队合作，就是每个成员都发挥自己的特长并密切配合。',
      'Suǒwèi de tuánduì hézuò, jiù shì měi gè chéngyuán dōu fāhuī zìjǐ de tècháng bìng mìqiè pèihé.',
      'Cái gọi là tinh thần làm việc nhóm, chính là mỗi thành viên đều phát huy sở trường của mình và phối hợp chặt chẽ.',
      '"所谓的团队合作..." định nghĩa và làm sáng tỏ bản chất cốt lõi của khái niệm hợp tác tập thể.'
    ),
    (
      v_gp_id,
      '考试成绩达到六十分才算及格，也就是说，五十九分也必须重新补考。',
      'Kǎoshì chéngjì dádào liùshí fēn cái suàn jígé, yějiùshìshuō, wǔshíjiǔ fēn yě bìxū chóngxīn bǔkǎo.',
      'Điểm thi đạt 60 điểm mới tính là qua môn, tức là nói, 59 điểm cũng bắt buộc phải thi lại.',
      '"也就是说..." giải thích hệ quả trực tiếp cụ thể hóa của quy định điểm sàn.'
    );

END $$;

COMMIT;
