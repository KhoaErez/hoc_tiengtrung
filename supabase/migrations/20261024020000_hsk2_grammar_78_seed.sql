-- ==============================================================================
-- MIGRATION: 20261024020000_hsk2_grammar_78_seed.sql
-- NẠP 78 ĐIỂM NGỮ PHÁP HSK 2 KÈM 156 CÂU VÍ DỤ CHUẨN GF 0025-2021 (APPENDIX A)
-- Có giải thích chi tiết tiếng Việt, công thức pattern, Pinyin có dấu thanh và phân loại chuẩn
-- ==============================================================================

BEGIN;

DO $$
DECLARE
  v_gp_id uuid;
BEGIN

  -- Điểm ngữ pháp #1: Đại từ phân phối "每" (Mỗi / Từng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ phân phối "每" (Mỗi / Từng)',
    '每 (+ Lượng từ) + Danh từ (+ 都 + Động từ/Tính từ)',
    'Đại từ',
    '"每" (měi) biểu thị từng cá thể đơn lẻ trong một tập thể (mỗi, từng). Khi làm định ngữ hoặc chủ ngữ, phía sau thường đi kèm lượng từ và trong vị ngữ thường có phó từ "都" (đều) để nhấn mạnh tính toàn thể không ngoại lệ.',
    'HSK 2',
    1,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他每天早晨六点都准时起床去公园跑步。',
      'Tā měi tiān zǎochén liù diǎn dōu zhǔnshí qǐchuáng qù gōngyuán pǎobù.',
      'Anh ấy mỗi ngày vào sáu giờ sáng đều thức dậy đúng giờ đến công viên chạy bộ.',
      '"每天" kết hợp với "都" biểu thị hành động diễn ra lặp lại đều đặn mỗi ngày.'
    ),
    (
      v_gp_id,
      '我们班每个学生都有属于自己的汉语词典。',
      'Wǒmen bān měi gè xuésheng dōu yǒu shǔyú zìjǐ de hànyǔ cídiǎn.',
      'Mỗi học sinh trong lớp chúng tôi đều có cuốn từ điển tiếng Hán của riêng mình.',
      '"每个" đứng trước danh từ "学生" và đi cùng phó từ "都".'
    );

  -- Điểm ngữ pháp #2: Đại từ nghi vấn phương thức "怎么" (Làm sao / Thế nào)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ nghi vấn phương thức "怎么" (Làm sao / Thế nào)',
    '怎么 + Động từ / Cụm động từ?',
    'Đại từ',
    '"怎么" (zěnme) đứng trước động từ để hỏi về cách thức tiến hành của động tác (làm thế nào, đi bằng cách nào, viết ra sao) hoặc nguyên nhân xảy ra sự việc (sao lại, tại sao).',
    'HSK 2',
    2,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请问去火车站坐几路公共汽车，应该怎么走？',
      'Qǐngwèn qù huǒchēzhàn zuò jǐ lù gōnggòng qìchē, yīnggāi zěnme zǒu?',
      'Xin hỏi đến ga tàu hỏa thì đi xe buýt tuyến số mấy, nên đi như thế nào?',
      '"怎么走" là cấu trúc cố định dùng để hỏi đường đi trong giao tiếp hàng ngày.'
    ),
    (
      v_gp_id,
      '这个生词的汉字笔画有点多，怎么写才规范？',
      'Zhè gè shēngcí de hànzì bǐhuà yǒudiǎn duō, zěnme xiě cái guīfàn?',
      'Chữ Hán của từ mới này nét hơi nhiều, viết thế nào mới đúng chuẩn?',
      '"怎么写" dùng để hỏi quy cách và thứ tự viết các nét chữ Hán.'
    );

  -- Điểm ngữ pháp #3: Đại từ nghi vấn tính chất / trạng thái "怎么样" (Như thế nào)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ nghi vấn tính chất / trạng thái "怎么样" (Như thế nào)',
    'Chủ ngữ + 怎么样? / 怎么样，...?',
    'Đại từ',
    '"怎么样" (zěnmeyàng) dùng làm vị ngữ để hỏi về tính chất, tình trạng, sức khỏe của người hoặc sự vật, hoặc dùng trong câu hỏi gợi ý để trưng cầu ý kiến người nghe (thấy thế nào, có được không).',
    'HSK 2',
    3,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今天外面的天气怎么样，需要带雨伞吗？',
      'Jīntiān wàimiàn de tiānqì zěnmeyàng, xūyào dài yǔsǎn ma?',
      'Thời tiết bên ngoài hôm nay thế nào, có cần mang theo ô không?',
      '"怎么样" làm vị ngữ hỏi về tình hình thời tiết.'
    ),
    (
      v_gp_id,
      '我们下课后一起去图书馆看书，怎么样？',
      'Wǒmen xiàkè hòu yìqǐ qù túshūguǎn kànshū, zěnmeyàng?',
      'Chúng ta tan học xong cùng nhau tới thư viện đọc sách, thấy thế nào?',
      '"怎么样" đặt ở cuối câu để thăm dò và trưng cầu ý kiến đề xuất.'
    );

  -- Điểm ngữ pháp #4: Đại từ nghi vấn nguyên nhân "为什么" (Tại sao / Vì sao)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ nghi vấn nguyên nhân "为什么" (Tại sao / Vì sao)',
    '为什么 + Chủ ngữ / Vị ngữ? Hoặc Chủ ngữ + 为什么 + Vị ngữ?',
    'Đại từ',
    '"为什么" (wèishénme) dùng để truy vấn nguyên nhân, mục đích hoặc lý do xảy ra của hành vi hoặc sự việc. Câu trả lời thường bắt đầu bằng liên từ chỉ nguyên nhân "因为..." (bởi vì...).',
    'HSK 2',
    4,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '你昨天下午为什么没有来参加中文歌唱比赛？',
      'Nǐ zuótiān xiàwǔ wèishénme méiyǒu lái cānjiā zhōngwén gēchàng bǐsài?',
      'Chiều hôm qua tại sao bạn không đến tham gia cuộc thi hát tiếng Trung?',
      '"为什么" đứng trước vị ngữ hỏi rõ lý do vắng mặt.'
    ),
    (
      v_gp_id,
      '他今天心情很好，你知道是因为什么事情吗？',
      'Tā jīntiān xīnqíng hěn hǎo, nǐ zhīdào shì yīnwèi shénme shìqing ma?',
      'Hôm nay tâm trạng anh ấy rất tốt, bạn có biết là vì chuyện gì không?',
      '"因为什么" phối hợp hỏi rõ nguyên nhân cụ thể dẫn đến tâm trạng vui vẻ.'
    );

  -- Điểm ngữ pháp #5: Đại từ nhân xưng ngôi thứ ba chỉ sự vật / động vật "它 / 它们" (Nó / Chúng nó)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ nhân xưng ngôi thứ ba chỉ sự vật / động vật "它 / 它们" (Nó / Chúng nó)',
    '它 / 它们 + Vị ngữ',
    'Đại từ',
    '"它" (tā) dùng để thay thế cho con vật, đồ vật hoặc sự việc ở ngôi thứ ba số ít (nó). Khi ở số nhiều, thêm hậu tố "们" thành "它们" (chúng, chúng nó).',
    'HSK 2',
    5,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这只小花猫非常可爱，它的眼睛又大又亮。',
      'Zhè zhī xiǎohuāmāo fēicháng kě''ài, tā de yǎnjīng yòu dà yòu liàng.',
      'Chú mèo hoa nhỏ này rất đáng yêu, mắt của nó vừa to vừa sáng.',
      '"它的" là đại từ sở hữu chỉ bộ phận mắt của con mèo.'
    ),
    (
      v_gp_id,
      '动物园里有许多大熊猫，它们正在竹林里吃竹子。',
      'Dòngwùyuán lǐ yǒu xǔduō dàxióngmāo, tāmen zhèngzài zhúlín lǐ chī zhúzi.',
      'Trong sở thú có nhiều gấu trúc lớn, chúng đang ăn trúc trong rừng trúc.',
      '"它们" thay thế số nhiều cho bầy gấu trúc lớn.'
    );

  -- Điểm ngữ pháp #6: Số từ hàng trăm "百" và hàng nghìn "千" (Trăm / Nghìn)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Số từ hàng trăm "百" và hàng nghìn "千" (Trăm / Nghìn)',
    'Số từ + 百 / 千 (+ Số từ lẻ)',
    'Số từ',
    '"百" (bǎi) chỉ hàng trăm (100–999) và "千" (qiān) chỉ hàng nghìn (1.000–9.999). Khi ở giữa có số 0 (như 105, 1008), dùng chữ "零" (líng) để đọc, nếu có nhiều số 0 liên tiếp chỉ đọc một chữ "零".',
    'HSK 2',
    6,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这本现代汉语词典一共有一千五百页。',
      'Zhè běn xiàndài hànyǔ cídiǎn yígòng yǒu yì qiān wǔ bǎi yè.',
      'Cuốn từ điển Hán ngữ hiện đại này tổng cộng có một nghìn năm trăm trang.',
      '"一千五百" biểu thị số lượng trang sách hàng nghìn và hàng trăm.'
    ),
    (
      v_gp_id,
      '这件羊毛大衣在商场专卖店售价八百零五块钱。',
      'Zhè jiàn yángmáo dàyī zài shāngchǎng zhuānmàidiàn shòujià bā bǎi líng wǔ kuài qián.',
      'Chiếc áo khoác dạ len này ở cửa hàng trung tâm thương mại có giá bán là tám trăm linh năm tệ.',
      '"八百零五" thể hiện cách dùng chữ "零" ở hàng chục.'
    );

  -- Điểm ngữ pháp #7: Số thứ tự với tiền tố "第" (Thứ / Hạng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Số thứ tự với tiền tố "第" (Thứ / Hạng)',
    '第 + Số từ (+ Lượng từ + Danh từ)',
    'Số từ',
    'Thêm tiền tố "第" (dì) trước số từ để biểu thị thứ tự lớp lang (thứ nhất: 第一, thứ hai: 第二). Khi kết hợp với danh từ, thường có lượng từ đi kèm (như: 第一次, 第二本书).',
    'HSK 2',
    7,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这是我第一次乘坐高铁去北京参加学术会议。',
      'Zhè shì wǒ dì-yī cì chéngzuò gāotiě qù Běijīng cānjiā xuéshù huìyì.',
      'Đây là lần đầu tiên tôi đi tàu cao tốc đến Bắc Kinh tham gia hội nghị học thuật.',
      '"第一次" là số thứ tự biểu thị lần thứ nhất.'
    ),
    (
      v_gp_id,
      '他在全国青少年游泳锦标赛决赛中获得了第一名。',
      'Tā zài quánguó qīng-shàonián yóuyǒng jǐnbiāosài juésài zhōng huòdé le dì-yī míng.',
      'Anh ấy đã đoạt được hạng nhất trong trận chung kết giải bơi lội thanh thiếu niên toàn quốc.',
      '"第一名" biểu thị thứ tự xếp hạng vị trí quán quân.'
    );

  -- Điểm ngữ pháp #8: Động lượng từ "次" (Lần / Lượt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động lượng từ "次" (Lần / Lượt)',
    'Động từ + (Số từ) + 次',
    'Lượng từ',
    '"次" (cì) là động lượng từ thông dụng nhất chỉ số lần diễn ra của động tác hoặc sự kiện. Nó thường đứng sau động từ làm bổ ngữ động lượng (như 去过一次: đã từng đi một lần).',
    'HSK 2',
    8,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这部感人的纪录片我已经在电影院看了三次。',
      'Zhè bù gǎnrén de jìlùpiàn wǒ yǐjīng zài diànyǐngyuàn kàn le sān cì.',
      'Bộ phim tài liệu cảm động này tôi đã xem ở rạp chiếu phim tới ba lần.',
      '"看了三次" biểu thị hành động xem đã lặp lại tổng cộng 3 lần.'
    ),
    (
      v_gp_id,
      '老师耐心地把这道复杂的数学题讲了两次。',
      'Lǎoshī nàixīn de bǎ zhè dào fùzá de shùxué tí jiǎng le liǎng cì.',
      'Thầy giáo đã kiên nhẫn giảng bài toán phức tạp này hai lần.',
      '"讲了两次" bổ nghĩa cho số lần tiến hành động tác giảng bài.'
    );

  -- Điểm ngữ pháp #9: Danh lượng từ phương tiện "辆" (Chiếc / Xe)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ phương tiện "辆" (Chiếc / Xe)',
    'Số từ + 辆 + Xe cộ (自行车 / 汽车 / 公共汽车)',
    'Lượng từ',
    '"辆" (liàng) là lượng từ chuyên dụng dùng cho các loại phương tiện giao thông trên cạn có bánh xe như xe đạp (自行车), xe con (汽车), xe buýt (公共汽车).',
    'HSK 2',
    9,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '爸爸上个月为我买了一辆崭新的山地自行车。',
      'Bàba shàng gè yuè wèi wǒ mǎi le yí liàng zhǎnxīn de shāndì zìxíngchē.',
      'Tháng trước bố đã mua cho tôi một chiếc xe đạp leo núi mới toanh.',
      '"一辆...自行车" là kết cấu lượng từ tiêu chuẩn dùng cho xe đạp.'
    ),
    (
      v_gp_id,
      '公司门口的停车场里整齐地停着十辆白色轿车。',
      'Gōngsī ménkǒu de tíngchēchǎng lǐ zhěngqí de tíng zhe shí liàng báisè jiàochē.',
      'Trong bãi đỗ xe trước cửa công ty đang đỗ ngay ngắn mười chiếc ô tô con màu trắng.',
      '"十辆" chỉ số lượng xe hơi đang dừng đỗ.'
    );

  -- Điểm ngữ pháp #10: Danh lượng từ y phục / sự việc "件" (Chiếc / Kiện / Việc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ y phục / sự việc "件" (Chiếc / Kiện / Việc)',
    'Số từ + 件 + Áo quần / Đồ vật / Sự việc',
    'Lượng từ',
    '"件" (jiàn) là lượng từ dùng cho áo quần phần thân trên (áo sơ mi, áo khoác, áo len: 一件衬衫), hành lý đồ đạc (一件行李) hoặc sự tình, công việc (一件事).',
    'HSK 2',
    10,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '商场正在打折促销，她挑中了一件红色的毛衣。',
      'Shāngchǎng zhèngzài dǎzhé cùxiāo, tā tiāo zhòng le yí jiàn hóngsè de máoyī.',
      'Trung tâm thương mại đang giảm giá khuyến mãi, cô ấy đã chọn trúng một chiếc áo len màu đỏ.',
      '"一件毛衣" là cách dùng lượng từ cho trang phục áo len.'
    ),
    (
      v_gp_id,
      '今天在办公室发生了一件非常有趣的开心事。',
      'Jīntiān zài bàngōngshì fāshēng le yí jiàn fēicháng yǒuqù de kāixīn shì.',
      'Hôm nay ở văn phòng đã xảy ra một chuyện vui vô cùng thú vị.',
      '"一件...事" biểu thị lượng từ cho sự việc phát sinh.'
    );

  -- Điểm ngữ pháp #11: Danh lượng từ vật dài / mềm "条" (Con / Sợi / Chiếc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ vật dài / mềm "条" (Con / Sợi / Chiếc)',
    'Số từ + 条 + Quần / Khăn / Sông / Cá',
    'Lượng từ',
    '"条" (tiáo) là lượng từ dùng cho các vật thể có hình dáng thon dài hoặc uốn lượn như sông ngòi (一条河), đường xá (一条路), quần (一条裤子), cá (一条鱼), khăn quàng (一条围巾).',
    'HSK 2',
    11,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这条清澈的小河绕着美丽的小山村缓缓流过。',
      'Zhè tiáo qīngchè de xiǎohé rào zhe měilì de xiǎoshāncūn huǎnhuǎn liúguò.',
      'Dòng sông nhỏ trong vắt này chảy êm đềm uốn quanh ngôi làng núi xinh đẹp.',
      '"这条小河" dùng cho con sông uốn lượn thon dài.'
    ),
    (
      v_gp_id,
      '妈妈在超市买了三条新鲜的鲤鱼准备做晚饭。',
      'Māma zài chāoshì mǎi le sān tiáo xīnxiān de lǐyú zhǔnbèi zuò wǎnfàn.',
      'Mẹ đã mua ba con cá chép tươi ở siêu thị chuẩn bị nấu bữa tối.',
      '"三条...鲤鱼" là cách dùng lượng từ cho loài cá.'
    );

  -- Điểm ngữ pháp #12: Danh lượng từ vật phẳng "张" (Tấm / Tờ / Chiếc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ vật phẳng "张" (Tấm / Tờ / Chiếc)',
    'Số từ + 张 + Giấy / Vé / Bàn / Giường',
    'Lượng từ',
    '"张" (zhāng) là lượng từ dùng cho các vật mỏng phẳng hoặc có bề mặt mở rộng như tờ giấy (一张纸), tấm vé (一张票), bức ảnh (一张照片), cái bàn (一张桌子), chiếc giường (一张床).',
    'HSK 2',
    12,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他从皮夹里拿出一张全家人的幸福合影照片。',
      'Tā cóng píjiá lǐ ná chū yì zhāng quánjiā rén de xìngfú héyǐng zhàopiàn.',
      'Anh ấy lấy từ trong ví ra một tấm ảnh chụp chung hạnh phúc của cả gia đình.',
      '"一张...照片" dùng cho bức ảnh phẳng mỏng.'
    ),
    (
      v_gp_id,
      '我已经提前在网上预订好了两张今晚的话剧票。',
      'Wǒ yǐjīng tíqián zài wǎngshang yùdìng hǎo le liǎng zhāng jīnwǎn de huàjù piào.',
      'Tôi đã đặt trước trên mạng xong xuôi hai tấm vé kịch nói tối nay.',
      '"两张...票" dùng cho vé vào cửa.'
    );

  -- Điểm ngữ pháp #13: Danh lượng từ đôi / cặp "双" (Đôi / Cặp)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ đôi / cặp "双" (Đôi / Cặp)',
    'Số từ + 双 + Giày / Tất / Đũa / Mắt',
    'Lượng từ',
    '"双" (shuāng) dùng cho những đồ vật đi liền thành một cặp gồm hai chiếc cùng loại như giày dép (一双鞋), tất vớ (一双袜子), đũa (一双筷子), hoặc bàn tay/đôi mắt (一双手 / 一双眼睛).',
    'HSK 2',
    13,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这双运动鞋穿起来特别轻便舒适，适合跑步。',
      'Zhè shuāng yùndòngxié chuān qǐlai tèbié qīngbiàn shūshì, shìhé pǎobù.',
      'Đôi giày thể thao này đi vào đặc biệt nhẹ nhàng êm ái, rất hợp để chạy bộ.',
      '"这双运动鞋" là lượng từ chỉ đôi giày đi liền nhau.'
    ),
    (
      v_gp_id,
      '服务员，请给我们多拿两双干净的木筷子。',
      'Fúwùyuán, qǐng gěi wǒmen duō ná liǎng shuāng gānjìng de mù kuàizi.',
      'Phục vụ ơi, xin lấy thêm cho chúng tôi hai đôi đũa gỗ sạch sẽ nhé.',
      '"两双...筷子" dùng cho đũa ăn cơm.'
    );

  -- Điểm ngữ pháp #14: Lượng từ cân lượng "斤" và tiền tệ "元 / 块 / 角 / 毛"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Lượng từ cân lượng "斤" và tiền tệ "元 / 块 / 角 / 毛"',
    'Số từ + 斤 / 块 / 毛 (+ Danh từ)',
    'Lượng từ',
    '"斤" (jīn) là cân Trung Quốc (= 500g). Về tiền tệ, văn viết dùng "元" (yuán) và "角" (jiǎo), trong khẩu ngữ đời thường dùng "块" (kuài) và "毛" (máo). 1 元/块 = 10 角/毛.',
    'HSK 2',
    14,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这种红富士苹果五块五毛钱一斤，很甜。',
      'Zhè zhǒng hóngfùshì píngguǒ wǔ kuài wǔ máo qián yì jīn, hěn tián.',
      'Loại táo Phú Sĩ đỏ này năm tệ rưỡi một cân (500g), rất ngọt.',
      '"五块五毛" chỉ giá tiền khẩu ngữ và "一斤" chỉ đơn vị trọng lượng.'
    ),
    (
      v_gp_id,
      '他在菜市场买了三斤新鲜的西红柿和两斤土豆。',
      'Tā zài càishìchǎng mǎi le sān jīn xīnxiān de xīhóngshì hé liǎng jīn tǔdòu.',
      'Anh ấy đã mua ba cân cà chua tươi và hai cân khoai tây ở chợ rau.',
      '"三斤" và "两斤" định lượng khối lượng rau củ quả.'
    );

  -- Điểm ngữ pháp #15: Phó từ mức độ cảm thán "真" (Thật / Thật là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ mức độ cảm thán "真" (Thật / Thật là)',
    '真 + Tính từ / Cụm động từ tâm lý (+ 啊)!',
    'Phó từ',
    '"真" (zhēn) đứng trước tính từ hoặc động từ tâm lý để bày tỏ thái độ tán thán, ngợi ca hoặc khẳng định mạnh mẽ từ đáy lòng (thật là, quả là). Cuối câu thường có trợ từ ngữ khí "啊".',
    'HSK 2',
    15,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '春天的桂林山水风景真美丽啊！',
      'Chūntiān de Guìlín shānshuǐ fēngjǐng zhēn měilì a!',
      'Phong cảnh non nước Quế Lâm vào mùa xuân thật là tươi đẹp biết bao!',
      '"真美丽" nhấn mạnh mức độ cảm thán trước vẻ đẹp non nước.'
    ),
    (
      v_gp_id,
      '你做的那道红烧牛肉真好吃，大家都很喜欢。',
      'Nǐ zuò de nà dào hóngshāo niúròu zhēn hǎochī, dàjiā dōu hěn xǐhuan.',
      'Món thịt bò kho mà bạn nấu thật là ngon miệng, mọi người đều rất thích.',
      '"真好吃" khen ngợi hương vị món ăn xuất sắc.'
    );

  -- Điểm ngữ pháp #16: Phó từ mức độ tuyệt đối "最" (Nhất / Bậc nhất)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ mức độ tuyệt đối "最" (Nhất / Bậc nhất)',
    '最 + Tính từ / Động từ tâm lý (+ Danh từ)',
    'Phó từ',
    '"最" (zuì) biểu thị mức độ cao nhất trong các đối tượng so sánh (nhất). Thường đứng trước tính từ (như: 最好: tốt nhất, 最小: nhỏ nhất) hoặc động từ tâm lý (như: 最喜欢: thích nhất, 最爱: yêu nhất).',
    'HSK 2',
    16,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '一年四季当中，我最喜欢的季节是凉爽的秋天。',
      'Yì nián sìjì dāngzhōng, wǒ zuì xǐhuan de jìjié shì liángshuǎng de qiūtiān.',
      'Trong bốn mùa một năm, mùa tôi yêu thích nhất là mùa thu mát mẻ.',
      '"最喜欢" chỉ sở thích cao nhất trong 4 mùa.'
    ),
    (
      v_gp_id,
      '他是我们长跑训练队里速度最快的优秀运动员。',
      'Tā shì wǒmen chángpǎo xùnliànduì lǐ sùdù zuì kuài de yōuxiù yùndòngyuán.',
      'Anh ấy là vận động viên xuất sắc có tốc độ nhanh nhất trong đội chạy dài của chúng tôi.',
      '"最快" so sánh tốc độ đứng đầu toàn đội.'
    );

  -- Điểm ngữ pháp #17: Phó từ thời gian hoàn thành "已经" (Đã / Đã từng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời gian hoàn thành "已经" (Đã / Đã từng)',
    'Chủ ngữ + 已经 + Động từ / Tính từ (+ 了)',
    'Phó từ',
    '"已经" (yǐjīng) biểu thị động tác đã hoàn thành hoặc trạng thái đã đạt đến một giai đoạn nhất định (đã). Cuối câu hoặc sau động từ thường đi kèm trợ từ ngữ khí "了".',
    'HSK 2',
    17,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '飞机已经准时降落在首都国际机场了。',
      'Fēijī yǐjīng zhǔnshí jiàngluò zài shǒudū guójì jīchǎng le.',
      'Máy bay đã hạ cánh đúng giờ xuống sân bay quốc tế thủ đô rồi.',
      '"已经...了" biểu thị sự việc hạ cánh đã hoàn tất.'
    ),
    (
      v_gp_id,
      '爷爷的身体已经完全康复了，请大家放心。',
      'Yéye de shēntǐ yǐjīng wánquán kāngfù le, qǐng dàjiā fàngxīn.',
      'Sức khỏe của ông nội đã hoàn toàn hồi phục rồi, xin mọi người hãy yên tâm.',
      '"已经...了" chỉ trạng thái phục hồi sức khỏe trọn vẹn.'
    );

  -- Điểm ngữ pháp #18: Phó từ tiếp diễn hành động "正 / 正在 / 在" (Đang)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tiếp diễn hành động "正 / 正在 / 在" (Đang)',
    'Chủ ngữ + 正 / 正在 / 在 + Động từ (+ Tân ngữ) (+ 呢)',
    'Phó từ',
    '"正" (zhèng), "在" (zài) hoặc "正在" (zhèngzài) đứng trước động từ để biểu thị hành động đang trong quá trình tiến hành tại một thời điểm nhất định (đang). Cuối câu thường kết hợp trợ từ "呢".',
    'HSK 2',
    18,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '同学们正在教室里认真地听老师讲课呢。',
      'Tóngxué men zhèngzài jiàoshì lǐ rènzhēn de tīng lǎoshī jiǎngkè ne.',
      'Các bạn học sinh đang chăm chú nghe thầy giáo giảng bài trong lớp học.',
      '"正在...呢" miêu tả hành động nghe giảng đang diễn ra tại thời điểm nói.'
    ),
    (
      v_gp_id,
      '爸爸在书房里看新闻，你不要大声说话。',
      'Bàba zài shūfáng lǐ kàn xīnwén, nǐ bú yào dàshēng shuōhuà.',
      'Bố đang xem tin tức trong phòng sách, bạn đừng nói to nhé.',
      '"在看" biểu thị trạng thái đang xem tin tức.'
    );

  -- Điểm ngữ pháp #19: Phó từ thời gian sớm / nhanh "就" (Đã / Liền / Ngay)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời gian sớm / nhanh "就" (Đã / Liền / Ngay)',
    'Thời gian + 就 + Động từ / Động từ 1 + 就 + Động từ 2',
    'Phó từ',
    '"就" (jiù) đứng trước động từ để nhấn mạnh hành động xảy ra sớm, nhanh chóng, thuận lợi ngoài dự liệu (đã, liền, ngay). Đối lập với "才" (mới - muộn).',
    'HSK 2',
    19,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他今天早晨五点半就起床去跑步了。',
      'Tā jīntiān zǎochén wǔ diǎn bàn jiù qǐchuáng qù pǎobù le.',
      'Anh ấy sáng nay năm rưỡi đã thức dậy đi chạy bộ rồi.',
      '"五点半就" nhấn mạnh thức dậy rất sớm.'
    ),
    (
      v_gp_id,
      '我一吃完早饭就立刻坐地铁去公司上班。',
      'Wǒ yì chī wán zǎofàn jiù lìkè zuò dìtiě qù gōngsī shàngbān.',
      'Tôi vừa ăn xong bữa sáng là lập tức đi tàu điện ngầm tới công ty đi làm ngay.',
      '"一...就..." thể hiện hành động thứ hai diễn ra liền ngay sau hành động một.'
    );

  -- Điểm ngữ pháp #20: Phó từ duy trì trạng thái "还" (Vẫn / Còn)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ duy trì trạng thái "还" (Vẫn / Còn)',
    'Chủ ngữ + 还 + Động từ / Tính từ',
    'Phó từ',
    '"还" (hái) biểu thị hành động hoặc trạng thái vốn có từ trước vẫn tiếp tục tiếp diễn chưa kết thúc (vẫn, còn). Phủ định thường dùng "还没" (vẫn chưa).',
    'HSK 2',
    20,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '现在已经晚上十点了，他还在实验室里做化学实验。',
      'Xiànzài yǐjīng wǎnshang shí diǎn le, tā hái zài shíyànshì lǐ zuò huàxué shíyàn.',
      'Bây giờ đã mười giờ đêm rồi, anh ấy vẫn đang làm thí nghiệm hóa học trong phòng thí nghiệm.',
      '"还在" biểu thị hành vi làm thí nghiệm vẫn tiếp tục kéo dài tới đêm.'
    ),
    (
      v_gp_id,
      '外面虽然雨停了，但是天气还是很冷。',
      'Wàimiàn suīrán yǔ tíng le, dànshì tiānqì hái shì hěn lěng.',
      'Bên ngoài tuy mưa đã tạnh, nhưng thời tiết vẫn còn rất lạnh.',
      '"还是" nhấn mạnh tình trạng rét lạnh vẫn duy trì.'
    );

  -- Điểm ngữ pháp #21: Phó từ lặp lại trong tương lai "再" (Lại / Nữa / Hãy)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ lặp lại trong tương lai "再" (Lại / Nữa / Hãy)',
    '再 + Động từ (+ Tân ngữ)',
    'Phó từ',
    '"再" (zài) biểu thị một hành động sẽ được lặp lại hoặc tiếp tục trong tương lai (lại, nữa), hoặc biểu thị hành động làm sau khi một điều kiện hoàn thành (rồi hãy...). Khác với "又" (đã lặp lại trong quá khứ).',
    'HSK 2',
    21,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这道中国名菜味道太好了，我下次还要再来吃一次。',
      'Zhè dào zhōngguó míngcài wèidào tài hǎo le, wǒ xià cì hái yào zài lái chī yí cì.',
      'Món ăn danh tiếng Trung Quốc này hương vị ngon quá, lần sau tôi nhất định sẽ lại đến ăn lần nữa.',
      '"再来吃" chỉ hành động ăn lặp lại ở lần sau (tương lai).'
    ),
    (
      v_gp_id,
      '请大家先把课文读熟，然后再回答思考题。',
      'Qǐng dàjiā xiān bǎ kèwén dú shú, ránhòu zài huídá sīkǎotí.',
      'Xin mời mọi người trước tiên đọc kỹ bài khóa, sau đó hãy trả lời các câu hỏi suy ngẫm.',
      '"然后再" biểu thị thứ tự hành động làm sau.'
    );

  -- Điểm ngữ pháp #22: Phó từ hợp tác "一起" (Cùng nhau / Cùng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ hợp tác "一起" (Cùng nhau / Cùng)',
    '一起 + Động từ (+ Tân ngữ) / 和 / 跟 + Ai + 一起 + Động từ',
    'Phó từ',
    '"一起" (yìqǐ) biểu thị nhiều người cùng tham gia vào một địa điểm hoặc cùng tiến hành một hoạt động (cùng nhau). Thường kết hợp với giới từ "和 / 跟" (và, cùng).',
    'HSK 2',
    22,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '周末我和大学同学一起去郊区爬山看红叶。',
      'Zhōumò wǒ hé dàxué tóngxué yìqǐ qù jiāoqū páshān kàn hóngyè.',
      'Cuối tuần tôi cùng các bạn đại học cùng nhau đi leo núi ngắm lá đỏ ở ngoại ô.',
      '"和...一起" chỉ sự phối hợp hoạt động leo núi của nhiều người.'
    ),
    (
      v_gp_id,
      '大家坐在一起热烈讨论关于汉语学习的有效方法。',
      'Dàjiā zuò zài yìqǐ rèliè tǎolùn guānyú hànyǔ xuéxí de yǒuxiào fāngfǎ.',
      'Mọi người ngồi lại cùng nhau thảo luận sôi nổi về phương pháp học tiếng Hán hiệu quả.',
      '"坐在一起" biểu thị vị trí tập hợp cùng một chỗ.'
    );

  -- Điểm ngữ pháp #23: Phó từ khuyên ngăn phủ định "别" (Đừng / Chớ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ khuyên ngăn phủ định "别" (Đừng / Chớ)',
    '别 + Động từ / Cụm động từ (+ 了)!',
    'Phó từ',
    '"别" (bié) dùng trong câu cầu khiến phủ định để khuyên bảo, ngăn cản ai đó không nên làm một việc gì (đừng, chớ). Cuối câu có thể thêm "了" để khuyên dừng hành động đang làm.',
    'HSK 2',
    23,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '医生叮嘱病人今天晚上千万别吃辛辣油腻的食物。',
      'Yīshēng dīngzhǔ bìngrén jīntiān wǎnshang qiānwàn bié chī xīnlà yóunì de shíwù.',
      'Bác sĩ dặn dò bệnh nhân tối hôm nay tuyệt đối đừng ăn đồ ăn cay nóng nhiều dầu mỡ.',
      '"别吃" là lời khuyên răn ngăn cản kiêng khem ăn uống.'
    ),
    (
      v_gp_id,
      '考试时间快到了，大家别说话了，专心答卷。',
      'Kǎoshì shíjiān kuài dào le, dàjiā bié shuōhuà le, zhuānxīn dájuàn.',
      'Giờ thi sắp tới rồi, mọi người đừng nói chuyện nữa, hãy tập trung làm bài.',
      '"别说话了" khuyên dừng hành động đang nói chuyện lại.'
    );

  -- Điểm ngữ pháp #24: Phó từ đồng nhất "也" (Cũng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ đồng nhất "也" (Cũng)',
    'Chủ ngữ 1 + Vị ngữ, Chủ ngữ 2 + 也 + Vị ngữ',
    'Phó từ',
    '"也" (yě) đứng trước động từ hoặc tính từ để biểu thị sự đồng nhất về tính chất, trạng thái hoặc hành vi với đối tượng được đề cập trước đó (cũng). Luôn đứng trước phó từ phủ định 不/没.',
    'HSK 2',
    24,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他很喜欢喝中国茶，他的妹妹也很喜欢喝绿茶。',
      'Tā hěn xǐhuan hē zhōngguó chá, tā de mèimei yě hěn xǐhuan hē lǜchá.',
      'Anh ấy rất thích uống trà Trung Quốc, em gái anh ấy cũng rất thích uống trà xanh.',
      '"也" biểu thị em gái có sở thích tương tự như người anh.'
    ),
    (
      v_gp_id,
      '我今天没去图书馆，小明今天也没有去。',
      'Wǒ jīntiān méi qù túshūguǎn, Xiǎomíng jīntiān yě méiyǒu qù.',
      'Hôm nay tôi không đến thư viện, Tiểu Minh hôm nay cũng không đi.',
      '"也没有" đứng trước cụm phủ định biểu thị sự đồng nhất về việc không đi.'
    );

  -- Điểm ngữ pháp #25: Phó từ tổng quát "都" (Đều / Tất cả)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tổng quát "都" (Đều / Tất cả)',
    'Chủ ngữ số nhiều + 都 + Vị ngữ',
    'Phó từ',
    '"都" (dōu) đứng trước động từ hoặc tính từ để bao hàm toàn bộ các chủ thể hoặc đối tượng phía trước không có ngoại lệ (đều, tất cả). Khi phủ định toàn bộ dùng "都不", phủ định một phần dùng "不都".',
    'HSK 2',
    25,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们班的外国留学生都顺利通过了汉语水平考试。',
      'Wǒmen bān de wàiguó liúxuéshēng dōu shùnlì tōngguò le hànyǔ shuǐpíng kǎoshì.',
      'Các lưu học sinh nước ngoài của lớp chúng tôi đều đã thuận lợi vượt qua kỳ thi năng lực Hán ngữ.',
      '"都通过" nhấn mạnh toàn thể mọi học sinh không ai trượt.'
    ),
    (
      v_gp_id,
      '这些新鲜的水果都是从海南岛空运过来的。',
      'Zhèxiē xīnxiān de shuǐguǒ dōu shì cóng Hǎinándǎo kōngyùn guòlái de.',
      'Những loại hoa quả tươi này đều là được vận chuyển bằng đường hàng không từ đảo Hải Nam tới.',
      '"都是" xác nhận toàn bộ số hoa quả có cùng nguồn gốc.'
    );

  -- Điểm ngữ pháp #26: Cấu trúc vừa... vừa... "又...又..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc vừa... vừa... "又...又..."',
    '又 + Tính từ 1 + 又 + Tính từ 2 / 又 + Động từ 1 + 又 + Động từ 2',
    'Liên từ',
    'Cấu trúc "又...又..." (yòu...yòu...) liên kết hai tính từ hoặc động từ có tính chất tương đương cùng tồn tại song song trong một chủ thể (vừa... lại vừa...). Hai thành phần liên kết phải cùng tích cực hoặc cùng tiêu cực.',
    'HSK 2',
    26,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这家新开的面馆做的面条又便宜又好吃。',
      'Zhè jiā xīn kāi de miànguǎn zuò de miàntiáo yòu piányi yòu hǎochī.',
      'Mì do quán mì mới mở này nấu vừa rẻ lại vừa ngon miệng.',
      '"又便宜又好吃" liên kết hai tính từ tích cực ca ngợi quán mì.'
    ),
    (
      v_gp_id,
      '超市里买来的西瓜个头又大又甜，水分很足。',
      'Chāoshì lǐ mǎi lái de xīguā gètóu yòu dà yòu tián, shuǐfèn hěn zú.',
      'Quả dưa hấu mua ở siêu thị về quả vừa to lại vừa ngọt, mọng nước vô cùng.',
      '"又大又甜" miêu tả hai đặc điểm nổi bật của quả dưa hấu.'
    );

  -- Điểm ngữ pháp #27: Liên từ nhân quả "因为...所以..." (Bởi vì... cho nên...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ nhân quả "因为...所以..." (Bởi vì... cho nên...)',
    '因为 + Nguyên nhân, 所以 + Kết quả',
    'Liên từ',
    'Cặp liên từ "因为...所以..." (yīnwèi... suǒyǐ...) dùng để biểu thị mối quan hệ nhân quả. Phân câu trước nêu lý do, phân câu sau nêu kết quả dẫn tới. Trong giao tiếp khẩu ngữ có thể lược bỏ "因为" hoặc "所以".',
    'HSK 2',
    27,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '因为今天早晨突降大雨，所以我们取消了去郊区的野餐计划。',
      'Yīnwèi jīntiān zǎochén tūjiàng dàyǔ, suǒyǐ wǒmen qǔxiāo le qù jiāoqū de yěcān jìhuà.',
      'Bởi vì sáng nay trời bất chợt đổ mưa to, cho nên chúng tôi đã hủy bỏ kế hoạch đi dã ngoại ngoại ô.',
      '"因为...所以..." liên kết nguyên nhân trời mưa với kết quả hủy kế hoạch.'
    ),
    (
      v_gp_id,
      '因为他平时勤奋刻苦，所以这次汉语考试取得了好成绩。',
      'Yīnwèi tā píngrì qínfèn kèkǔ, suǒyǐ zhè cì hànyǔ kǎoshì qǔdé le hǎo chéngjì.',
      'Bởi vì thường ngày anh ấy chăm chỉ khổ luyện, cho nên kỳ thi tiếng Hán lần này đã đạt được thành tích tốt.',
      'Biểu thị nguyên nhân học tập chăm chỉ dẫn đến kết quả thi tốt.'
    );

  -- Điểm ngữ pháp #28: Liên từ chuyển ngoặt "虽然...但是..." (Tuy rằng... nhưng mà...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ chuyển ngoặt "虽然...但是..." (Tuy rằng... nhưng mà...)',
    '虽然 + Phân câu nhượng bộ, 但是 / 可是 + Phân câu chuyển ngoặt',
    'Liên từ',
    'Cặp liên từ "虽然...但是..." (suīrán... dànshì...) biểu thị mối quan hệ nhượng bộ và chuyển ngoặt (tuy... nhưng...). Phân câu sau chuyển hướng ý nghĩa ngược lại hoặc bổ sung khía cạnh khác so với phân câu trước.',
    'HSK 2',
    28,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这道中国菜虽然看起来有点辣，但是吃起来非常香。',
      'Zhè dào zhōngguócài suīrán kàn qǐlai yǒudiǎn là, dànshì chī qǐlai fēicháng xiāng.',
      'Món ăn Trung Quốc này tuy nhìn có vẻ hơi cay, nhưng ăn vào lại vô cùng thơm ngon.',
      '"虽然...但是..." thể hiện sự chuyển biến từ vẻ bề ngoài tới hương vị thực tế.'
    ),
    (
      v_gp_id,
      '他虽然学习汉语的时间不长，但是发音非常准确流利。',
      'Tā suīrán xuéxí hànyǔ de shíjiān bù cháng, dànshì fāyīn fēicháng zhǔnquè liúlì.',
      'Anh ấy tuy thời gian học tiếng Hán chưa lâu, nhưng phát âm lại vô cùng chuẩn xác lưu loát.',
      'Chuyển ngoặt giữa thời gian học ngắn và phát âm tốt.'
    );

  -- Điểm ngữ pháp #29: Liên từ lựa chọn câu trần thuật "或者" (Hoặc / Hoặc là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ lựa chọn câu trần thuật "或者" (Hoặc / Hoặc là)',
    'Lựa chọn A + 或者 + Lựa chọn B',
    'Liên từ',
    '"或者" (huòzhě) dùng để liên kết các sự vật, hành động có tính chất lựa chọn trong câu trần thuật hoặc câu khẳng định (hoặc, hoặc là). Không dùng trong câu hỏi nghi vấn lựa chọn (câu hỏi dùng "还是").',
    'HSK 2',
    29,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '周末我通常在家里安静看书，或者去公园散步。',
      'Zhōumò wǒ tōngcháng zài jiā lǐ ānjìng kànshū, huòzhě qù gōngyuán sànbù.',
      'Cuối tuần tôi thường yên tĩnh đọc sách ở nhà, hoặc là đến công viên đi dạo.',
      '"或者" dùng trong câu trần thuật nối hai hoạt động lựa chọn cuối tuần.'
    ),
    (
      v_gp_id,
      '你可以选择喝热咖啡，或者喝新鲜的苹果汁。',
      'Nǐ kěyǐ xuǎnzé hē rè kāfēi, huòzhě hē xīnxiān de píngguǒzhī.',
      'Bạn có thể lựa chọn uống cà phê nóng, hoặc là uống nước ép táo tươi.',
      '"或者" đưa ra 2 phương án đồ uống cho người nghe.'
    );

  -- Điểm ngữ pháp #30: Liên từ lựa chọn câu nghi vấn "还是" (Hay là / Hay)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ lựa chọn câu nghi vấn "还是" (Hay là / Hay)',
    'Phương án A + 还是 + Phương án B?',
    'Liên từ',
    '"还是" (háishì) dùng trong câu hỏi lựa chọn để yêu cầu người nghe chọn một trong hai hoặc nhiều phương án được đưa ra (hay là, hoặc). Thường kết thúc bằng dấu chấm hỏi "?".',
    'HSK 2',
    30,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请问你想喝热茶还是想喝冰水？',
      'Qǐngwèn nǐ xiǎng hē rè chá háishì xiǎng hē bīngshuǐ?',
      'Xin hỏi bạn muốn uống trà nóng hay là muốn uống nước đá?',
      '"还是" dùng trong câu hỏi lựa chọn giữa trà nóng và nước đá.'
    ),
    (
      v_gp_id,
      '我们明天坐高铁去上海，还是坐飞机去？',
      'Wǒmen míngtiān zuò gāotiě qù Shànghǎi, háishì zuò fēijī qù?',
      'Ngày mai chúng ta đi tàu cao tốc đến Thượng Hải, hay là đi máy bay?',
      'Hỏi lựa chọn phương tiện di chuyển.'
    );

  -- Điểm ngữ pháp #31: Liên từ thứ tự thời gian "然后" (Sau đó / Rồi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ thứ tự thời gian "然后" (Sau đó / Rồi)',
    'Hành động 1, 然后 + Hành động 2',
    'Liên từ',
    '"然后" (ránhòu) là liên từ biểu thị sự tiếp nối tuần tự của hai hành động theo trình tự thời gian (sau đó, rồi thì). Thường đi liền trong chuỗi: "先...然后..." (trước tiên... sau đó...).',
    'HSK 2',
    31,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们先去超市买蔬菜，然后回家一起做晚饭。',
      'Wǒmen xiān qù chāoshì mǎi shūcài, ránhòu huíjiā yìqǐ zuò wǎnfàn.',
      'Chúng ta trước tiên đến siêu thị mua rau, sau đó về nhà cùng nhau nấu cơm tối.',
      '"先...然后..." chỉ rõ trình tự trước sau của việc đi chợ và nấu ăn.'
    ),
    (
      v_gp_id,
      '你先填写这张个人表格，然后去二楼会议室面试。',
      'Nǐ xiān tiánxiě zhè zhāng gèrén biǎogé, ránhòu qù èr lóu huìyìshì miànshì.',
      'Bạn trước tiên hãy điền vào phiếu cá nhân này, sau đó lên phòng họp tầng hai phỏng vấn.',
      'Chỉ dẫn quy trình làm việc theo thứ tự.'
    );

  -- Điểm ngữ pháp #32: Giới từ đối tượng tiếp nhận "给" (Cho / Cho ai)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ đối tượng tiếp nhận "给" (Cho / Cho ai)',
    'Chủ ngữ + 给 + Đối tượng + Động từ (+ Tân ngữ)',
    'Giới từ',
    '"给" (gěi) làm giới từ đứng trước danh từ chỉ người hoặc tổ chức để chỉ đối tượng phục vụ hoặc người tiếp nhận hành động (cho, cho ai đó, tặng cho).',
    'HSK 2',
    32,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '爸爸每天早晨都耐心地给我讲一个有趣的成语故事。',
      'Bàba měitiān zǎochén dōu nàixīn de gěi wǒ jiǎng yí gè yǒuqù de chéngyǔ gùshì.',
      'Mỗi sáng sớm bố đều kiên nhẫn kể cho tôi nghe một câu chuyện thành ngữ thú vị.',
      '"给我讲" biểu thị đối tượng lắng nghe câu chuyện là tôi.'
    ),
    (
      v_gp_id,
      '母亲正在厨房里给全家人准备丰盛可口的午饭。',
      'Mǔqīn zhèngzài chúfáng lǐ gěi quán jiārén zhǔnbèi fēngshèng kěkǒu de wǔfàn.',
      'Người mẹ đang ở trong bếp chuẩn bị bữa trưa thịnh soạn ngon miệng cho cả gia đình.',
      '"给全家人准备" chỉ đối tượng thụ hưởng bữa cơm trưa.'
    );

  -- Điểm ngữ pháp #33: Giới từ khởi điểm "从" (Từ / Bắt đầu từ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ khởi điểm "从" (Từ / Bắt đầu từ)',
    '从 + Nơi chốn / Thời gian + Động từ (+ 到...)',
    'Giới từ',
    '"从" (cóng) biểu thị mốc xuất phát về không gian, thời gian hoặc phạm vi (từ, bắt đầu từ). Thường phối hợp với "到" (đến) tạo thành kết cấu "从...到..." (từ... đến...).',
    'HSK 2',
    33,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这趟高铁从北京出发，只需要四个小时就到上海。',
      'Zhè tàng gāotiě cóng Běijīng chūfā, zhǐ xūyào sì gè xiǎoshí jiù dào Shànghǎi.',
      'Chuyến tàu cao tốc này xuất phát từ Bắc Kinh, chỉ cần bốn tiếng đồng hồ là đến Thượng Hải.',
      '"从北京出发" chỉ điểm khởi hành về mặt địa lý.'
    ),
    (
      v_gp_id,
      '他从星期一到星期五都在大学图书馆认真复习功课。',
      'Tā cóng xīngqīyī dào xīngqīwǔ dōu zài dàxué túshūguǎn rènzhēn fùxí gōngkè.',
      'Anh ấy từ thứ Hai đến thứ Sáu đều ở thư viện trường đại học chăm chỉ ôn bài.',
      '"从...到..." biểu thị khoảng thời gian từ đầu tuần tới cuối tuần.'
    );

  -- Điểm ngữ pháp #34: Giới từ phương hướng chuyển động "往" (Về phía / Hướng về)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ phương hướng chuyển động "往" (Về phía / Hướng về)',
    '往 + Phương hướng / Địa điểm + Động từ (走 / 开 / 看 / 飞)',
    'Giới từ',
    '"往" (wǎng) chỉ phương hướng mục tiêu của hành động di chuyển (hướng về phía, đi về phía). Thường đi với các động từ chỉ sự di chuyển như: 往东走 (đi về phía Đông), 往前看 (nhìn về phía trước).',
    'HSK 2',
    34,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '从这个十字路口一直往前走两百米就是市立医院。',
      'Cóng zhè gè shízì-lùkǒu yìzhí wǎng qián zǒu liǎng bǎi mǐ jiù shì shìlì yīyuàn.',
      'Từ ngã tư này đi thẳng về phía trước hai trăm mét là bệnh viện thành phố.',
      '"往前走" chỉ dẫn phương hướng tiến bước về phía trước.'
    ),
    (
      v_gp_id,
      '请大家下了公共汽车后往右边拐，就能看到地铁站入口。',
      'Qǐng dàjiā xià le gōnggòng qìchē hòu wǎng yòubiān guǎi, jiù néng kàn dào dìtiězhàn rùkǒu.',
      'Mời mọi người sau khi xuống xe buýt thì rẽ về phía bên phải là có thể nhìn thấy lối vào ga tàu điện ngầm.',
      '"往右边拐" chỉ hướng rẽ phải.'
    );

  -- Điểm ngữ pháp #35: Giới từ hướng mục tiêu đối tượng "向" (Hướng tới / Về phía)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ hướng mục tiêu đối tượng "向" (Hướng tới / Về phía)',
    '向 + Đối tượng / Phương vị + Động từ (学 / 借 / 走 / 报告)',
    'Giới từ',
    '"向" (xiàng) có thể chỉ phương hướng không gian (như 往) và đặc biệt dùng chỉ đối tượng mà hành động nhắm vào (như 向老师请教: thỉnh giáo thầy giáo, 向他学习: học tập anh ấy).',
    'HSK 2',
    35,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '全班同学都应当虚心向经验丰富的李老师学习。',
      'Quán bān tóngxué dōu yīngdāng xūxīn xiàng jīngyàn fēngfù de Lǐ lǎoshī xuéxí.',
      'Học sinh cả lớp đều nên khiêm tốn học tập thầy Lý giàu kinh nghiệm.',
      '"向...学习" chỉ đối tượng học tập là thầy Lý.'
    ),
    (
      v_gp_id,
      '轮船迎着朝阳缓缓向南方的大海深处航行。',
      'Lúnchuán yíng zhe zhāoyáng huǎnhuǎn xiàng nánfāng de dàhǎi shēncù hángxíng.',
      'Con tàu đón ánh bình minh từ từ hướng về biển sâu phương Nam căng buồm rẽ sóng.',
      '"向南方...航行" chỉ phương hướng di chuyển của con thuyền.'
    );

  -- Điểm ngữ pháp #36: Giới từ đối tượng tương tác "对" (Đối với / Về)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ đối tượng tương tác "对" (Đối với / Về)',
    '对 + Đối tượng + Vị ngữ / Đối tượng 1 + 对 + Đối tượng 2 + Tính từ',
    'Giới từ',
    '"对" (duì) dùng để đưa ra đối tượng mà hành vi tác động tới, hoặc đối tượng tiếp nhận tình cảm, thái độ, tính chất (đối với, đối cùng). Cấu trúc thường gặp: 对...感兴趣 (có hứng thú với...), 对...好 (tốt với...).',
    'HSK 2',
    36,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这位热心的老教授对每一个学生都非常和蔼客气。',
      'Zhè wèi rèxīn de lǎo jiàoshòu duì měi yí gè xuésheng dōu fēicháng hé''ǎi kèqì.',
      'Vị giáo sư già nhiệt tình này đối với mỗi một học sinh đều vô cùng hòa nhã nhã nhặn.',
      '"对...和蔼客气" biểu thị thái độ cư xử tốt đối với học trò.'
    ),
    (
      v_gp_id,
      '很多外国留学生都对博大精深的中国京剧艺术很感兴趣。',
      'Hěn duō wàiguó liúxuéshēng dōu duì bódà-jīngshēn de zhōngguó jīngjù yìshù hěn gǎn xìngqù.',
      'Rất nhiều lưu học sinh nước ngoài đều rất có hứng thú đối với nghệ thuật Kinh kịch Trung Quốc uyên thâm.',
      '"对...感兴趣" là cấu trúc cố định chỉ sự say mê hứng thú.'
    );

  -- Điểm ngữ pháp #37: Giới từ cự ly không gian / thời gian "离" (Cách / Cách xa)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ cự ly không gian / thời gian "离" (Cách / Cách xa)',
    'Địa điểm / Mốc thời gian A + 离 + B + (不) 远 / 近 / Cự ly cụ thể',
    'Giới từ',
    '"离" (lí) biểu thị cự ly khoảng cách về mặt không gian hoặc thời gian giữa hai điểm (cách). Không được dùng với phó từ chỉ vị trí "从".',
    'HSK 2',
    37,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我家离学校非常近，走路只需要五分钟就能到达。',
      'Wǒ jiā lí xuéxiào fēicháng jìn, zǒulù zhǐ xūyào wǔ fēnzhōng jiù néng dàodá.',
      'Nhà tôi cách trường học rất gần, đi bộ chỉ cần năm phút là có thể tới nơi.',
      '"离学校非常近" chỉ khoảng cách không gian địa lý ngắn.'
    ),
    (
      v_gp_id,
      '现在离春节放假还有一个星期，大家都在忙着准备年货。',
      'Xiànzài lí chūnjié fàngjià hái yǒu yí gè xīngqī, dàjiā dōu zài máng zhe zhǔnbèi niánhuò.',
      'Bây giờ cách kỳ nghỉ tết Nguyên đán còn một tuần nữa, mọi người đều đang bận sắm sửa đồ tết.',
      '"离春节放假" chỉ khoảng cách thời gian còn lại.'
    );

  -- Điểm ngữ pháp #38: Giới từ mục đích & vì đối tượng "为" (Vì / Cho)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ mục đích & vì đối tượng "为" (Vì / Cho)',
    '为 + Đối tượng / Mục đích + Động từ (+ Tân ngữ)',
    'Giới từ',
    '"为" (wèi) đứng trước danh từ để chỉ mục đích của hành động (vì cái gì) hoặc chỉ người/đối tượng được hành động phục vụ (cho ai). Thường gặp: 为...高兴 (mừng cho ai), 为...服务 (phục vụ ai).',
    'HSK 2',
    38,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听到你顺利通过高级汉语考试的消息，我们都为你感到高兴。',
      'Tīng dào nǐ shùnlì tōngguò gāojí hànyǔ kǎoshì de xiāoxi, wǒmen dōu wèi nǐ gǎndào gāoxìng.',
      'Nghe tin bạn thuận lợi thi đỗ kỳ thi Hán ngữ cao cấp, chúng tôi đều cảm thấy vui mừng thay cho bạn.',
      '"为你感到高兴" chỉ người được vui mừng cho là bạn.'
    ),
    (
      v_gp_id,
      '这家社区服务中心始终全心全意为广大居民排忧解难。',
      'Zhè jiā shèqū fúwù zhōngxīn shǐzhōng quánxīn-quányì wèi guǎngdà jūmín páiyōu-jiěnán.',
      'Trung tâm dịch vụ cộng đồng này luôn toàn tâm toàn ý giải quyết khó khăn lo toan cho đông đảo cư dân.',
      '"为广大居民" chỉ đối tượng được phục vụ.'
    );

  -- Điểm ngữ pháp #39: Giới từ so sánh "比" cơ bản (Hơn / So với)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ so sánh "比" cơ bản (Hơn / So với)',
    'Chủ ngữ A + 比 + Chủ ngữ B + Tính từ',
    'Giới từ',
    '"比" (bǐ) dùng trong câu so sánh bậc hơn giữa hai đối tượng A và B. Chú ý: Trước tính từ vị ngữ trong câu chữ 比 KHÔNG được dùng các phó từ mức độ như 很, 非常, 真.',
    'HSK 2',
    39,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '弟弟现在的身高已经比哥哥高了整整两厘米。',
      'Dìdi xiànzài de shēngāo yǐjīng bǐ gēge gāo le zhěngzhěng liǎng límǐ.',
      'Chiều cao hiện tại của em trai đã cao hơn anh trai trọn vẹn hai centimet.',
      '"比哥哥高" là cấu trúc so sánh hơn tiêu chuẩn về chiều cao.'
    ),
    (
      v_gp_id,
      '今天户外的气温比昨天低了三度，需要多穿一件外套。',
      'Jīntiān hùwài de qìwēn bǐ zuótiān dī le sān dù, xūyào duō chuān yí jiàn wàitào.',
      'Nhiệt độ ngoài trời hôm nay thấp hơn hôm qua ba độ, cần phải mặc thêm một chiếc áo khoác.',
      '"比昨天低" so sánh nhiệt độ giữa hai ngày.'
    );

  -- Điểm ngữ pháp #40: Trợ từ kết cấu bổ ngữ trạng thái "得"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Trợ từ kết cấu bổ ngữ trạng thái "得"',
    'Động từ (+ Tân ngữ + Động từ) + 得 + (很 / 非常) + Tính từ / Cụm vị ngữ',
    'Trợ từ',
    '"得" (de) là trợ từ kết cấu nối giữa động từ và bổ ngữ chỉ trạng thái để đánh giá, miêu tả mức độ, kết quả hoặc trạng thái thực hiện của hành động (làm ra sao, đến mức nào). Nếu động từ mang tân ngữ thì phải lặp lại động từ.',
    'HSK 2',
    40,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这位外国留学生的汉字写得非常工整漂亮。',
      'Zhè wèi wàiguó liúxuéshēng de hànzì xiě de fēicháng gōngzhěng piàoliang.',
      'Chữ Hán của bạn lưu học sinh nước ngoài này viết rất nắn nót đẹp đẽ.',
      '"写得非常工整" dùng "得" kết nối động từ "写" và bổ ngữ đánh giá.'
    ),
    (
      v_gp_id,
      '他昨天晚上睡得很香，今天早晨精神格外饱满。',
      'Tā zuótiān wǎnshang shuì de hěn xiāng, jīntiān zǎochén jīngshén géwài bǎomǎn.',
      'Tối hôm qua anh ấy ngủ rất ngon giấc, sáng nay tinh thần cực kỳ phấn chấn.',
      '"睡得很香" đánh giá trạng thái giấc ngủ.'
    );

  -- Điểm ngữ pháp #41: Trợ từ động thái trạng thái tiếp diễn "着"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Trợ từ động thái trạng thái tiếp diễn "着"',
    'Động từ + 着 (+ Tân ngữ)',
    'Trợ từ',
    '"着" (zhe) đứng sau động từ để biểu thị hành động đang diễn ra hoặc trạng thái do hành động tạo ra vẫn đang được duy trì (đang, vẫn giữ nguyên). Thường gặp trong câu miêu tả tư thế hoặc câu tồn hiện.',
    'HSK 2',
    41,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '会议室的大门紧紧关着，里面正在进行重要谈判。',
      'Huìyìshì de dàmén jǐnjǐn guān zhe, lǐmiàn zhèngzài jìnxíng zhòngyào tánpàn.',
      'Cánh cửa lớn của phòng họp đang đóng chặt, bên trong đang tiến hành đàm phán quan trọng.',
      '"关着" biểu thị trạng thái đóng cửa đang được duy trì.'
    ),
    (
      v_gp_id,
      '老奶奶手里拿着一本厚厚的相册，微笑着回忆过去。',
      'Lǎonǎinai shǒu lǐ ná zhe yì běn hòuhòu de xiàngcè, wēixiào zhe huíyì guòqù.',
      'Bà cụ trong tay đang cầm một cuốn album ảnh dày cộp, mỉm cười nhớ về quá khứ.',
      '"拿着" chỉ tư thế cầm sách và "微笑着" chỉ trạng thái mỉm cười.'
    );

  -- Điểm ngữ pháp #42: Trợ từ động thái kinh nghiệm quá khứ "过"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Trợ từ động thái kinh nghiệm quá khứ "过"',
    'Chủ ngữ + Động từ + 过 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 过',
    'Trợ từ',
    '"过" (guo) đứng ngay sau động từ để nhấn mạnh chủ thể đã từng có kinh nghiệm trải qua hành động đó trong quá khứ (đã từng, từng). Dạng phủ định là "没 / 没有 + Động từ + 过" (chưa từng).',
    'HSK 2',
    42,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我去年夏天曾经去过一次美丽的云南丽江古城。',
      'Wǒ qùnián xiàtiān céngjīng qù guo yí cì měilì de Yúnnán Lìjiāng gǔchéng.',
      'Mùa hè năm ngoái tôi đã từng một lần đến phố cổ Lệ Giang tươi đẹp ở Vân Nam.',
      '"去过" khẳng định đã từng có trải nghiệm du lịch Lệ Giang.'
    ),
    (
      v_gp_id,
      '他从来没有吃过这么地道正宗的四川麻婆豆腐。',
      'Tā cónglái méiyǒu chī guo zhème dìdào zhèngzōng de Sìchuān mápó dòufu.',
      'Anh ấy từ trước tới nay chưa từng ăn món đậu phụ Ma Bà Tứ Xuyên chuẩn vị chính tông thế này.',
      '"没有吃过" phủ định chưa từng nếm qua món ăn.'
    );

  -- Điểm ngữ pháp #43: Trợ từ ngữ khí biến đổi tình huống "了"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Trợ từ ngữ khí biến đổi tình huống "了"',
    'Vị ngữ + 了',
    'Trợ từ',
    '"了" (le) đặt ở cuối câu dùng làm trợ từ ngữ khí để biểu thị sự xuất hiện của một tình huống mới, sự thay đổi trạng thái hoặc nhận thức mới (rồi, đã chuyển biến). Khác với "了" trợ từ động thái đứng sau động từ.',
    'HSK 2',
    43,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '春风吹绿了大地，天气逐渐变得温暖了。',
      'Chūnfēng chuī lǜ le dàdì, tiānqì zhújiàn biàn de wēnnuǎn le.',
      'Gió xuân thổi xanh đất trời, thời tiết dần dần trở nên ấm áp rồi.',
      '"温暖了" biểu thị thời tiết đã có sự chuyển biến ấm lên.'
    ),
    (
      v_gp_id,
      '已经下课了，请大家收拾好书包离开教室。',
      'Yǐjīng xiàkè le, qǐng dàjiā shōushi hǎo shūbāo líkāi jiàoshì.',
      'Đã tan học rồi, mời mọi người dọn dẹp cặp sách rời khỏi lớp học.',
      '"下课了" thông báo tình huống mới là giờ học đã kết thúc.'
    );

  -- Điểm ngữ pháp #44: Trợ từ ngữ khí thương lượng / gợi ý "吧"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Trợ từ ngữ khí thương lượng / gợi ý "吧"',
    'Câu đề xuất / Cầu khiến + 吧!',
    'Trợ từ',
    '"吧" (ba) đặt ở cuối câu để biểu thị ngữ khí thương lượng, đề nghị, thỉnh cầu nhẹ nhàng hoặc đồng ý (nhé, đi, thôi). Giúp câu nói mềm mại và lịch sự hơn.',
    'HSK 2',
    44,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今天晚上的电影看起来很精彩，我们一起去看吧！',
      'Jīntiān wǎnshang de diànyǐng kàn qǐlai hěn jīngcǎi, wǒmen yìqǐ qù kàn ba!',
      'Bộ phim tối nay xem chừng rất đặc sắc, chúng ta cùng nhau đi xem nhé!',
      '"一起去看吧" rủ rê đề xuất bạn bè đi xem phim.'
    ),
    (
      v_gp_id,
      '时间不早了，大家快把桌子收拾干净准备休息吧。',
      'Shíjiān bù zǎo le, dàjiā kuài bǎ zhuōzi shōushi gānjìng zhǔnbèi xiūxi ba.',
      'Thời gian không còn sớm nữa, mọi người mau dọn dẹp bàn ghế sạch sẽ chuẩn bị nghỉ ngơi thôi.',
      '"准备休息吧" là lời khuyên thúc giục nhẹ nhàng.'
    );

  -- Điểm ngữ pháp #45: Trợ từ ngữ khí nhấn mạnh xác thực "呢"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Trợ từ ngữ khí nhấn mạnh xác thực "呢"',
    'Chủ ngữ + Vị ngữ + 呢 / Phó từ + 呢',
    'Trợ từ',
    '"呢" (ne) đặt ở cuối câu khẳng định để nhấn mạnh sự thật hiển nhiên hoặc cường điệu ngữ khí khẳng định (đấy, đấy chứ, cơ mà). Cũng kết hợp với 在/正 để chỉ hành động đang diễn ra.',
    'HSK 2',
    45,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '你别小看这道物理题，难着呢，需要仔细思考。',
      'Nǐ bié xiǎokàn zhè dào wùlǐ tí, nán zhe ne, xūyào zǐxì sīkǎo.',
      'Bạn chớ có xem thường bài toán vật lý này, khó lắm đấy chứ, cần phải suy nghĩ cẩn thận.',
      '"难着呢" nhấn mạnh mức độ khó của đề bài.'
    ),
    (
      v_gp_id,
      '妈妈还在厨房里给大家熬香喷喷的鸡汤呢。',
      'Māma hái zài chúfáng lǐ gěi dàjiā áo xiāngpēnpēn de jītāng ne.',
      'Mẹ vẫn đang ở trong bếp ninh nồi canh gà thơm nức mũi cho cả nhà cơ mà.',
      '"还在...呢" khẳng định hành động nấu nướng đang tiếp diễn.'
    );

  -- Điểm ngữ pháp #46: Động từ năng nguyện cho phép / năng lực "可以" (Có thể / Được phép)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ năng nguyện cho phép / năng lực "可以" (Có thể / Được phép)',
    'Chủ ngữ + 可以 + Động từ (+ Tân ngữ) / Phủ định: 不可以 / 不能',
    'Động từ năng nguyện',
    '"可以" (kěyǐ) biểu thị sự cho phép (được phép làm gì), tính khả thi hoặc năng lực có thể làm được điều gì. Dạng phủ định thường dùng "不可以" hoặc "不能".',
    'HSK 2',
    46,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请问大家在图书馆的阅览室里可以借用电脑吗？',
      'Qǐngwèn dàjiā zài túshūguǎn de yuèlǎnshì lǐ kěyǐ jièyòng diànnǎo ma?',
      'Xin hỏi mọi người ở phòng đọc của thư viện có thể mượn máy vi tính dùng được không?',
      '"可以借用" hỏi xin phép quy định trong phòng đọc.'
    ),
    (
      v_gp_id,
      '你做完课后作业以后就可以看半个小时动画片。',
      'Nǐ zuò wán kèhòu zuòyè yǐhòu jiù kěyǐ kàn bàn gè xiǎoshí dònghuàpiàn.',
      'Con làm xong bài tập về nhà xong là có thể xem phim hoạt hình nửa tiếng.',
      '"就可以看" biểu thị sự cho phép sau khi làm xong điều kiện.'
    );

  -- Điểm ngữ pháp #47: Động từ năng nguyện bổn phận / khuyên răn "应该" (Nên / Cần phải)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ năng nguyện bổn phận / khuyên răn "应该" (Nên / Cần phải)',
    'Chủ ngữ + 应该 + Động từ (+ Tân ngữ) / Phủ định: 不应该',
    'Động từ năng nguyện',
    '"应该" (yīnggāi) biểu thị về mặt đạo lý, nghĩa vụ, phép lịch sự hoặc logic thì cần thiết phải làm một việc gì đó (nên, cần phải). Phủ định là "不应该" (không nên).',
    'HSK 2',
    47,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '过马路的时候我们应该先看红绿灯，注意交通安全。',
      'Guò mǎlù de shíhou wǒmen yīnggāi xiān kàn hónglǜdēng, zhùyì jiāotōng ānquán.',
      'Khi qua đường chúng ta nên nhìn đèn tín hiệu giao thông trước, chú ý an toàn giao thông.',
      '"应该先看" khuyên bảo hành vi an toàn bắt buộc khi qua đường.'
    ),
    (
      v_gp_id,
      '朋友遇到困难时，我们应该主动伸出援助之手。',
      'Péngyou yù dào kùnnán shí, wǒmen yīnggāi zhǔdòng shēn chū yuánzhù zhī shǒu.',
      'Khi bạn bè gặp khó khăn, chúng ta nên chủ động chìa bàn tay giúp đỡ.',
      '"应该主动" nhấn mạnh bổn phận đạo đức đối với bạn bè.'
    );

  -- Điểm ngữ pháp #48: Động từ năng nguyện nguyện vọng "想" (Muốn / Nghĩ / Nhớ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ năng nguyện nguyện vọng "想" (Muốn / Nghĩ / Nhớ)',
    'Chủ ngữ + 想 + Động từ (+ Tân ngữ) / Phủ định: 不想',
    'Động từ năng nguyện',
    '"想" (xiǎng) đứng trước động từ biểu thị ý muốn, dự định chủ quan hoặc nguyện vọng trong lòng (muốn làm gì). Không mang tính quyết liệt và bắt buộc cao như "要".',
    'HSK 2',
    48,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今年寒假我想和家人一起去温暖的三亚海边度假。',
      'Jīnnián hánjià wǒ xiǎng hé jiārén yìqǐ qù wēnnuǎn de Sānyà hǎibiān dùjià.',
      'Kỳ nghỉ đông năm nay tôi muốn cùng người nhà đến bãi biển Tam Á ấm áp để nghỉ mát.',
      '"我想...去" biểu đạt mong muốn kế hoạch nghỉ đông.'
    ),
    (
      v_gp_id,
      '他今天身体有点不舒服，不想参加晚上的聚会。',
      'Tā jīntiān shēntǐ yǒudiǎn bù shūfu, bù xiǎng cānjiā wǎnshang de jùhuì.',
      'Hôm nay người anh ấy hơi không khỏe, không muốn tham gia buổi tụ tập tối nay.',
      '"不想参加" phủ định ý muốn tham gia.'
    );

  -- Điểm ngữ pháp #49: Động từ năng nguyện quyết tâm & tương lai gần "要" (Muốn / Sẽ / Phải)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ năng nguyện quyết tâm & tương lai gần "要" (Muốn / Sẽ / Phải)',
    'Chủ ngữ + 要 + Động từ (+ Tân ngữ) / Phủ định: 不想 / 不用',
    'Động từ năng nguyện',
    '"要" (yào) biểu thị quyết tâm mong muốn mạnh mẽ làm điều gì đó (muốn), hoặc biểu thị một hành động sắp xảy ra trong tương lai gần (sẽ). Phủ định ý muốn dùng "不想", phủ định nghĩa vụ dùng "不用".',
    'HSK 2',
    49,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '明天早晨八点我们要举行新学期的开学典礼。',
      'Míngtiān zǎochén bā diǎn wǒmen yào jǔxíng xīn xuéqī de kāixué diǎnlǐ.',
      'Tám giờ sáng mai chúng tôi sẽ tổ chức lễ khai giảng của học kỳ mới.',
      '"我们要举行" biểu thị sự việc sắp diễn ra vào sáng mai.'
    ),
    (
      v_gp_id,
      '为了学好汉语，他下定决心每天都要背三十个生词。',
      'Wèile xué hǎo hànyǔ, tā xiàdìng juéxīn měitiān dōu yào bèi sānshí gè shēngcí.',
      'Để học giỏi tiếng Hán, anh ấy hạ quyết tâm mỗi ngày đều phải học thuộc ba mươi từ mới.',
      '"都要背" biểu thị ý chí quyết tâm bắt buộc bản thân làm.'
    );

  -- Điểm ngữ pháp #50: Động từ năng nguyện kỹ năng học được "会" (Biết / Sẽ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ năng nguyện kỹ năng học được "会" (Biết / Sẽ)',
    'Chủ ngữ + 会 + Động từ (+ Tân ngữ) / Phủ định: 不会',
    'Động từ năng nguyện',
    '"会" (huì) biểu thị một kỹ năng hoặc năng lực nào đó đạt được thông qua quá trình học tập, rèn luyện (biết bơi, biết tiếng Trung), hoặc biểu thị khả năng sự việc sẽ xảy ra trong tương lai (sẽ).',
    'HSK 2',
    50,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他在中国生活了三年，现在不仅会说普通话，还会包饺子。',
      'Tā zài zhōngguó shēnghuó le sān nián, xiànzài bùjǐn huì shuō pǔtōnghuà, hái huì bāo jiǎozi.',
      'Anh ấy đã sống ở Trung Quốc ba năm, bây giờ không chỉ biết nói tiếng phổ thông mà còn biết gói sủi cảo.',
      '"会说" và "会包" chỉ các kỹ năng đạt được qua học tập thực tế.'
    ),
    (
      v_gp_id,
      '别担心，医生说你的病只要好好吃药就一定会好的。',
      'Bié dānxīn, yīshēng shuō nǐ de bìng zhǐyào hǎohǎo chīyào jiù yídìng huì hǎo de.',
      'Đừng lo lắng, bác sĩ nói bệnh của bạn chỉ cần uống thuốc đầy đủ thì nhất định sẽ khỏi thôi.',
      '"一定会好" biểu thị khả năng chắc chắn sẽ xảy ra trong tương lai.'
    );

  -- Điểm ngữ pháp #51: Bổ ngữ kết quả hoàn thiện đạt chuẩn "好"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả hoàn thiện đạt chuẩn "好"',
    'Động từ + 好 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 好',
    'Bổ ngữ',
    '"好" (hǎo) làm bổ ngữ kết quả đứng sau động từ để biểu thị hành động đã hoàn thành đạt tới mức độ hoàn thiện, hoàn hảo, khiến người ta hài lòng hoặc sẵn sàng cho bước tiếp theo (xong xuôi, tốt đẹp).',
    'HSK 2',
    51,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我已经准备好明天的求职面试发言稿了。',
      'Wǒ yǐjīng zhǔnbèi hǎo míngtiān de qiúzhí miànshì fāyángǎo le.',
      'Tôi đã chuẩn bị xong xuôi bài phát biểu phỏng vấn xin việc ngày mai rồi.',
      '"准备好" biểu thị sự việc chuẩn bị đã tươm tất hoàn tất.'
    ),
    (
      v_gp_id,
      '晚饭妈妈已经做好了，大家快洗手去餐厅吃饭吧。',
      'Wǎnfàn māma yǐjīng zuò hǎo le, dàjiā kuài xǐshǒu qù cāntīng chīfàn ba.',
      'Cơm tối mẹ đã nấu xong rồi, mọi người mau rửa tay vào phòng ăn ăn cơm thôi.',
      '"做好了" chỉ bữa cơm nấu xong thơm ngon sẵn sàng.'
    );

  -- Điểm ngữ pháp #52: Bổ ngữ kết quả kết thúc toàn bộ "完"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả kết thúc toàn bộ "完"',
    'Động từ + 完 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 完',
    'Bổ ngữ',
    '"完" (wán) làm bổ ngữ kết quả biểu thị hành động hoặc đối tượng của hành động đã kết thúc trọn vẹn, không còn gì sót lại (hết, xong). Dạng phủ định là "没 / 没有 + Động từ + 完" (chưa xong).',
    'HSK 2',
    52,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '同学们只用了一个小时就看完了整本故事书。',
      'Tóngxué men zhǐ yòng le yí gè xiǎoshí jiù kàn wán le zhěng běn gùshì shū.',
      'Các bạn học sinh chỉ dùng một giờ đồng hồ là đã đọc xong hết cả cuốn sách truyện.',
      '"看完了" biểu thị đọc hết toàn bộ cuốn sách không bỏ sót trang nào.'
    ),
    (
      v_gp_id,
      '这道难题我还没有做完，请老师再给我五分钟时间。',
      'Zhè dào nántí wǒ hái méiyǒu zuò wán, qǐng lǎoshī zài gěi wǒ wǔ fēnzhōng shíjiān.',
      'Bài toán khó này em vẫn chưa làm xong, xin thầy cho em thêm năm phút nữa ạ.',
      '"没有做完" phủ định hành động làm toán chưa kết thúc.'
    );

  -- Điểm ngữ pháp #53: Bổ ngữ kết quả tiếp cận / đạt mục tiêu "到" (Tới / Được)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả tiếp cận / đạt mục tiêu "到" (Tới / Được)',
    'Động từ + 到 + Tân ngữ nơi chốn / thời gian / mục tiêu',
    'Bổ ngữ',
    '"到" (dào) làm bổ ngữ kết quả đứng sau động từ biểu thị hành động đã đạt đến một địa điểm, một mốc thời gian nhất định (như 走到: đi đến, 学到: học đến), hoặc hành động đã thành công đạt được mục đích (như 买到: mua được, 找到: tìm thấy).',
    'HSK 2',
    53,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他昨天晚上在图书馆一直看书看到十一点半。',
      'Tā zuótiān wǎnshang zài túshūguǎn yìzhí kànshū kàn dào shíyī diǎn bàn.',
      'Tối hôm qua anh ấy ở thư viện đọc sách liên tục đến tận mười một giờ rưỡi.',
      '"看到" biểu thị mốc thời gian hành động đọc sách kéo dài tới.'
    ),
    (
      v_gp_id,
      '经过多方打听，我终于在旧书店买到了这本绝版名著。',
      'Jīngguò duōfāng dǎtīng, wǒ zhōngyú zài jiù shūdiàn mǎi dào le zhè běn juébǎn míngzhù.',
      'Qua nhiều mối dò hỏi, tôi cuối cùng đã mua được cuốn danh tác tuyệt bản này ở một hiệu sách cũ.',
      '"买到了" nhấn mạnh việc đạt được mục đích mua thành công.'
    );

  -- Điểm ngữ pháp #54: Bổ ngữ kết quả giác quan tri giác "见" (Thấy / Nghe thấy)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả giác quan tri giác "见" (Thấy / Nghe thấy)',
    'Động từ giác quan (看 / 听 / 闻) + 见 (+ Tân ngữ)',
    'Bổ ngữ',
    '"见" (jiàn) làm bổ ngữ kết quả kết hợp với các động từ tri giác như "看" (nhìn), "听" (nghe) để biểu thị giác quan đã tiếp nhận được hình ảnh, âm thanh từ thế giới bên ngoài (nhìn thấy, nghe thấy). Dạng phủ định là "没看(见)", "没听(见)".',
    'HSK 2',
    54,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '站在高山之巅，我们可以清楚地看见山谷里的小村庄。',
      'Zhàn zài gāoshān zhī diān, wǒmen kěyǐ qīngchu de kànjiàn shāngǔ lǐ de xiǎo cūnzhuāng.',
      'Đứng trên đỉnh núi cao, chúng tôi có thể nhìn thấy rõ ràng ngôi làng nhỏ trong thung lũng.',
      '"看见" biểu thị thị giác đã bắt được hình ảnh ngôi làng.'
    ),
    (
      v_gp_id,
      '教室外面太吵了，最后一排的学生听不见老师讲课。',
      'Jiàoshì wàimiàn tài chǎo le, zuìhòu yì pái de xuésheng tīng bu jiàn lǎoshī jiǎngkè.',
      'Bên ngoài lớp học ồn ào quá, học sinh hàng ghế cuối cùng không nghe thấy thầy giáo giảng bài.',
      '"听不见" biểu thị thính giác không thu nhận được âm thanh.'
    );

  -- Điểm ngữ pháp #55: Bổ ngữ kết quả hiểu thấu triệt "懂" (Hiểu / Hiểu ra)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả hiểu thấu triệt "懂" (Hiểu / Hiểu ra)',
    '听 / 看 + 懂 (+ Tân ngữ) / Phủ định: 没听懂 / 没看懂',
    'Bổ ngữ',
    '"懂" (dǒng) làm bổ ngữ kết quả đứng sau động từ tiếp nhận thông tin như "听" (nghe), "看" (đọc/xem) để biểu thị người tiếp nhận đã hiểu rõ, lĩnh hội được nội dung, ý nghĩa của lời nói hoặc bài viết (nghe hiểu, xem hiểu).',
    'HSK 2',
    55,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '虽然课文有些生词，但他依然认真听懂了整堂课的内容。',
      'Suīrán kèwén yǒuxiē shēngcí, dàn tā yīrán rènzhēn tīng dǒng le zhěng táng kè de nèiróng.',
      'Mặc dù bài khóa có một số từ mới, nhưng anh ấy vẫn chăm chú nghe hiểu được nội dung của cả tiết học.',
      '"听懂了" biểu thị đã lĩnh hội trọn vẹn lời giảng.'
    ),
    (
      v_gp_id,
      '这篇古汉语寓言文章深奥难懂，我读了两遍才看懂。',
      'Zhè piān gǔ hànyǔ yùyán wénzhāng shēn''ào nándǒng, wǒ dú le liǎng biàn cái kàn dǒng.',
      'Bài văn ngụ ngôn Hán ngữ cổ này sâu xa khó hiểu, tôi đọc tới hai lần mới xem hiểu được.',
      '"看懂" biểu thị việc đọc và hiểu thấu đáo ý nghĩa sau nhiều lần nghiền ngẫm.'
    );

  -- Điểm ngữ pháp #56: Bổ ngữ kết quả đúng / sai "对 / 错" (Đúng / Sai)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả đúng / sai "对 / 错" (Đúng / Sai)',
    'Động từ (做 / 说 / 写 / 算) + 对 / 错 (+ Tân ngữ)',
    'Bổ ngữ',
    '"对" (duì) và "错" (cuò) làm bổ ngữ kết quả đứng sau động từ để biểu thị hành động đã tiến hành chính xác hoặc sai lệch so với tiêu chuẩn, sự thật (làm đúng/sai, nói đúng/sai, tính đúng/sai).',
    'HSK 2',
    56,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经过反复验算，他在数学考试中把最后一道难题做对了。',
      'Jīngguò fǎnfù yànsuàn, tā zài shùxué kǎoshì zhōng bǎ zuìhòu yí dào nántí zuò duì le.',
      'Trải qua việc tính toán kiểm tra lại nhiều lần, anh ấy trong kỳ thi toán đã làm đúng bài toán khó cuối cùng.',
      '"做对了" biểu thị kết quả giải toán chính xác.'
    ),
    (
      v_gp_id,
      '对不起，我刚才太匆忙，把您的手机号码记错了。',
      'Duìbuqǐ, wǒ gāngcái tài cōngmáng, bǎ nín de shǒujī hàomǎ jì cuò le.',
      'Xin lỗi, ban nãy tôi vội vàng quá, đã ghi nhầm số điện thoại di động của ngài rồi.',
      '"记错了" biểu thị việc ghi chép bị sai sót thông tin.'
    );

  -- Điểm ngữ pháp #57: Bổ ngữ xu hướng đơn "来 / 去" (Lại / Đi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng đơn "来 / 去" (Lại / Đi)',
    'Động từ chuyển động (上 / 下 / 进 / 出 / 回 / 过) + 来 / 去',
    'Bổ ngữ',
    '"来" (lái) và "去" (qù) làm bổ ngữ xu hướng đứng sau động từ chỉ sự di chuyển. Dùng "来" khi hướng chuyển động tiến về phía vị trí của người nói (hoặc đối tượng được miêu tả); dùng "去" khi hướng chuyển động đi xa dần khỏi vị trí của người nói.',
    'HSK 2',
    57,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '外面风大天冷，你快进屋里来喝杯热姜茶吧。',
      'Wàimiàn fēng dà tiān lěng, nǐ kuài jìn wū lǐ lái hē bēi rè jiāngchá ba.',
      'Bên ngoài gió to trời lạnh, bạn mau bước vào trong nhà uống cốc trà gừng nóng đi.',
      '"进来" biểu thị người nói đang ở trong nhà, gọi người ngoài bước vào phía mình.'
    ),
    (
      v_gp_id,
      '爸爸让我去书房拿一本厚厚的汉语大字典回来。',
      'Bàba ràng wǒ qù shūfáng ná yì běn hòuhòu de hànyǔ dà zìdiǎn huílai.',
      'Bố bảo tôi đi vào phòng sách lấy một cuốn đại tự điển tiếng Hán dày cộp mang về đây.',
      '"拿回来" chỉ việc mang sách về lại chỗ người nói.'
    );

  -- Điểm ngữ pháp #58: Bổ ngữ xu hướng kép cơ bản "出来 / 上去 / 回来 / 走过去"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép cơ bản "出来 / 上去 / 回来 / 走过去"',
    'Động từ hành động + (上/下/进/出/回/过) + 来/去',
    'Bổ ngữ',
    'Bổ ngữ xu hướng kép gồm hai chữ (kết hợp 上/下/进/出/回/过/起 với 来/去) đứng sau động từ để miêu tả hướng di chuyển phức hợp vừa có tính phương vị vừa có tính cự ly đối với người nói.',
    'HSK 2',
    58,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '太阳慢慢从东方升起来，给大地披上了一层金色阳光。',
      'Tàiyáng mànmàn cóng dōngfāng shēng qǐlai, gěi dàdì pī shàng le yì céng jīnsè yángguāng.',
      'Mặt trời từ từ nhô lên từ phía Đông, khoác lên mặt đất một lớp ánh nắng vàng rực rỡ.',
      '"升起来" miêu tả mặt trời mọc hướng lên cao về phía tầm mắt.'
    ),
    (
      v_gp_id,
      '她从书包里拿出来一本刚买的新杂志借给同桌看。',
      'Tā cóng shūbāo lǐ ná chūlai yì běn gāng mǎi de xīn zázhì jiè gěi tóngzhuō kàn.',
      'Cô ấy từ trong cặp sách lấy ra một cuốn tạp chí mới vừa mua cho bạn cùng bàn mượn xem.',
      '"拿出来" miêu tả hành động lấy vật từ trong ra ngoài.'
    );

  -- Điểm ngữ pháp #59: Bổ ngữ thời lượng biểu thị độ dài hành động (时量补语)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ thời lượng biểu thị độ dài hành động (时量补语)',
    'Động từ + (了) + Khoảng thời gian (+ Tân ngữ) / Động từ + Tân ngữ + Động từ + Khoảng thời gian',
    'Bổ ngữ',
    'Bổ ngữ thời lượng đứng sau động từ để biểu thị hành động diễn ra kéo dài trong bao lâu (như: 一个小时: một tiếng, 三天: ba ngày). Nếu động từ mang tân ngữ thì cần lặp lại động từ hoặc đặt khoảng thời gian trước tân ngữ.',
    'HSK 2',
    59,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他在北京大学认真学习了四年现代汉语言文学专业。',
      'Tā zài Běijīng Dàxué rènzhēn xuéxí le sì nián xiàndài hànyǔ yánwénxué zhuānyè.',
      'Anh ấy đã chăm chỉ theo học chuyên ngành ngôn ngữ văn học Hán ngữ hiện đại tại Đại học Bắc Kinh suốt bốn năm.',
      '"学习了四年" bổ nghĩa cho độ dài thời gian học tập là 4 năm.'
    ),
    (
      v_gp_id,
      '我和朋友在人民公园的湖边散步散了半个小时。',
      'Wǒ hé péngyou zài Rénmín Gōngyuán de húbiān sànbù sàn le bàn gè xiǎoshí.',
      'Tôi và bạn bè đi dạo bên bờ hồ Công viên Nhân dân suốt nửa tiếng đồng hồ.',
      '"散了半个小时" lặp lại động từ để mang bổ ngữ thời lượng.'
    );

  -- Điểm ngữ pháp #60: Bổ ngữ động lượng chỉ tần suất số lượt "遍 / 趟 / 顿"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ động lượng chỉ tần suất số lượt "遍 / 趟 / 顿"',
    'Động từ + (了) + Số từ + 遍 / 趟 / 顿',
    'Bổ ngữ',
    'Bên cạnh "次", các động lượng từ như "遍" (biàn - lượt từ đầu đến cuối), "趟" (tàng - chuyến đi về), "顿" (dùn - bữa, trận) đứng sau động từ để miêu tả số lần thực hiện hành động với sắc thái cụ thể.',
    'HSK 2',
    60,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这首优美的唐诗大家已经声情并茂地背诵了三遍。',
      'Zhè shǒu yōuměi de tángshī dàjiā yǐjīng shēngqíng-bìngmào de bèisòng le sān biàn.',
      'Bài thơ Đường tươi đẹp này mọi người đã đọc thuộc lòng truyền cảm ba lượt từ đầu tới cuối.',
      '"背诵了三遍" nhấn mạnh đọc trọn vẹn toàn bộ bài thơ 3 lần.'
    ),
    (
      v_gp_id,
      '为了办理护照签证手续，他这个星期专门跑了两趟外事办。',
      'Wèile bànlǐ hùzhào qiānzhèng shǒuxù, tā zhè gè xīngqī zhuānmén pǎo le liǎng tàng wàishìbàn.',
      'Để làm thủ tục hộ chiếu visa, tuần này anh ấy đã chuyên công chạy đi chạy lại hai chuyến đến phòng ngoại vụ.',
      '"跑了两趟" chỉ số chuyến đi lại giao dịch công việc.'
    );

  -- Điểm ngữ pháp #61: Cấu trúc so sánh hơn có mức độ cụ thể "A 比 B + Tính từ + Mức độ"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc so sánh hơn có mức độ cụ thể "A 比 B + Tính từ + Mức độ"',
    'A 比 B + Tính từ + (一点儿 / 得多 / 多了 / Số lượng cụ thể)',
    'Cấu trúc so sánh',
    'Để biểu thị mức độ chênh lệch cụ thể trong câu so sánh chữ "比", người ta đặt các từ chỉ lượng như "一点儿" (một chút), "得多 / 多了" (nhiều) hoặc số lượng từ cụ thể ở ngay sau tính từ vị ngữ.',
    'HSK 2',
    61,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '坐高铁去上海比坐普通列车快得多，而且非常舒适。',
      'Zuò gāotiě qù Shànghǎi bǐ zuò pǔtōng lièchē kuài de duō, érqiě fēicháng shūshì.',
      'Đi tàu cao tốc tới Thượng Hải nhanh hơn nhiều so với đi tàu hỏa thông thường, hơn nữa còn rất tiện nghi thoải mái.',
      '"快得多" bổ ngữ mức độ chênh lệch tốc độ rất lớn.'
    ),
    (
      v_gp_id,
      '这件羊毛大衣比那件羽绒服贵了整整两百块钱。',
      'Zhè jiàn yángmáo dàyī bǐ nà jiàn yǔróngfú guì le zhěngzhěng liǎng bǎi kuài qián.',
      'Chiếc áo khoác dạ len này đắt hơn chiếc áo lông vũ kia trọn vẹn hai trăm tệ.',
      '"贵了整整两百块钱" nêu số lượng tiền chênh lệch cụ thể.'
    );

  -- Điểm ngữ pháp #62: Cấu trúc so sánh bằng phủ định "A 没有 B (+ 那么/这么) + Tính từ"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc so sánh bằng phủ định "A 没有 B (+ 那么/这么) + Tính từ"',
    'Chủ ngữ A + 没有 + Chủ ngữ B (+ 那么 / 这么) + Tính từ / Vị ngữ',
    'Cấu trúc so sánh',
    'Cấu trúc "A 没有 B (那么/这么) + Tính từ" dùng để biểu thị sự so sánh kém hơn hoặc không bằng (A không... bằng B). Đây là dạng so sánh phổ biến nhất khi phủ định mức độ của A so với chuẩn B.',
    'HSK 2',
    62,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今天户外的风没有昨天那么大，感觉暖和了不少。',
      'Jīntiān hùwài de fēng méiyǒu zuótiān nàme dà, gǎnjué nuǎnhuo le bù shǎo.',
      'Gió ngoài trời hôm nay không lớn bằng hôm qua, cảm thấy ấm áp hơn nhiều.',
      '"没有昨天那么大" so sánh độ lớn của gió không bằng ngày hôm trước.'
    ),
    (
      v_gp_id,
      '这本科普读物的生词没有我想象的那么难懂。',
      'Zhè běn kēpǔ dúwù de shēngcí méiyǒu wǒ xiǎngxiàng de nàme nándǒng.',
      'Từ mới trong cuốn sách phổ biến khoa học này không khó hiểu như tôi tưởng tượng.',
      'So sánh mức độ khó hiểu không bằng suy nghĩ ban đầu.'
    );

  -- Điểm ngữ pháp #63: Cấu trúc so sánh ngang bằng "A 跟 / 和 B 一样 (+ Tính từ)"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc so sánh ngang bằng "A 跟 / 和 B 一样 (+ Tính từ)"',
    'A 跟 / 和 B 一样 (+ Tính từ) / Phủ định: A 跟 / 和 B 不一样',
    'Cấu trúc so sánh',
    'Cấu trúc "A 跟/和 B 一样" biểu thị hai đối tượng A và B có điểm tương đồng, ngang bằng nhau về mặt tính chất, đặc điểm hoặc diện mạo (giống nhau, như nhau). Phía sau có thể thêm tính từ bổ sung khía cạnh so sánh.',
    'HSK 2',
    63,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '小红现在的汉语听说水平跟中国本土学生一样流利。',
      'Xiǎohóng xiànzài de hànyǔ tīng-shuō shuǐpíng gēn zhōngguó běntǔ xuésheng yíyàng liúlì.',
      'Trình độ nghe nói tiếng Hán hiện tại của Tiểu Hồng lưu loát hệt như học sinh bản xứ Trung Quốc.',
      '"跟...一样流利" so sánh mức độ lưu loát tương đương người bản xứ.'
    ),
    (
      v_gp_id,
      '这两款智能手机的外观颜色虽然一样，但内部配置不一样。',
      'Zhè liǎng kuǎn zhìnéng shǒujī de wàiguān yánsè suīrán yíyàng, dàn nèibù pèizhì bù yíyàng.',
      'Màu sắc bề ngoài của hai mẫu điện thoại thông minh này tuy giống nhau, nhưng cấu hình bên trong lại khác nhau.',
      '"一样" và "不一样" đối chiếu sự giống và khác nhau giữa hai vật.'
    );

  -- Điểm ngữ pháp #64: Câu chữ 把 sơ cấp: Xử lý và dịch chuyển vị trí (把字句基础)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 sơ cấp: Xử lý và dịch chuyển vị trí (把字句基础)',
    'Chủ ngữ + 把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成 (+ Thành phần khác)',
    'Cấu trúc câu',
    'Câu chữ "把" (bǎ) dùng để nhấn mạnh hành động tác động lên tân ngữ và làm thay đổi trạng thái, vị trí hoặc thuộc tính của tân ngữ đó. Động từ trong câu chữ 把 không được đứng đơn độc mà phải có thành phần khác đi kèm (như bổ ngữ kết quả, địa điểm, từ chỉ đích đến).',
    'HSK 2',
    64,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请大家离开教室之前把所有窗户都关好。',
      'Qǐng dàjiā líkāi jiàoshì zhīqián bǎ suǒyǒu chuānghu dōu guān hǎo.',
      'Xin mời mọi người trước khi rời lớp học hãy đóng kỹ tất cả các cửa sổ lại.',
      '"把所有窗户都关好" xử lý đối tượng cửa sổ bằng hành động đóng kín.'
    ),
    (
      v_gp_id,
      '哥哥下班回家后，把公文包放在了客厅的茶几上。',
      'Gēge xiàbān huíjiā hòu, bǎ gōngwénbāo fàng zài le kètīng de chájī shang.',
      'Sau khi anh trai tan sở về nhà đã đặt chiếc cặp tài liệu lên bàn trà phòng khách.',
      '"把公文包放在..." làm thay đổi vị trí của chiếc cặp tài liệu.'
    );

  -- Điểm ngữ pháp #65: Câu tồn hiện miêu tả sự vật tĩnh tại (存在句)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu tồn hiện miêu tả sự vật tĩnh tại (存在句)',
    'Nơi chốn + Động từ (放 / 挂 / 坐 / 站 / 停) + 着 + Danh từ',
    'Cấu trúc câu',
    'Câu tồn hiện dùng để miêu tả một địa điểm cụ thể nào đó đang tồn tại hoặc duy trì một trạng thái của người hoặc vật. Đầu câu là cụm từ chỉ nơi chốn, sau động từ có trợ từ "着", danh từ phía sau là đối tượng chưa xác định (thường có số lượng từ).',
    'HSK 2',
    65,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '会议室的正前方整齐地摆放着十张干净的长桌子。',
      'Huìyìshì de zhèng qiánfāng zhěngqí de bǎifàng zhe shí zhāng gānjìng de cháng zhuōzi.',
      'Chính phía trước phòng họp đang được bày biện ngay ngắn mười chiếc bàn dài sạch sẽ.',
      '"摆放着..." miêu tả sự vật bàn dài đang tồn tại cố định trong phòng họp.'
    ),
    (
      v_gp_id,
      '书房雪白的墙壁上挂着一幅名贵的水墨山水画。',
      'Shūfáng xuěbái de qiángbì shang guà zhe yì fú míngguì de shuǐmò shānshuǐhuà.',
      'Trên bức tường trắng tinh của phòng sách đang treo một bức tranh sơn thủy thủy mặc quý giá.',
      '"挂着" miêu tả trạng thái tranh treo trên tường.'
    );

  -- Điểm ngữ pháp #66: Câu liên động chỉ mục đích "去 / 来 + Nơi chốn + Làm gì"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu liên động chỉ mục đích "去 / 来 + Nơi chốn + Làm gì"',
    'Chủ ngữ + 去 / 来 / 到 + Địa điểm + Động từ hành động (+ Tân ngữ)',
    'Cấu trúc câu',
    'Câu liên động chỉ mục đích gồm hai cụm động từ đi liền nhau. Động từ thứ nhất là "来 / 去 / 到" chỉ sự di chuyển đến địa điểm, cụm động từ thứ hai nêu rõ mục đích của chuyến đi (đến đâu để làm việc gì).',
    'HSK 2',
    66,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '很多外国青年慕名来到中国学习传统中医药学文化。',
      'Hěn duō wàiguó qīngnián mùmíng lái dào Zhōngguó xuéxí chuántǒng zhōng-yīyàoxué wénhuà.',
      'Rất nhiều thanh niên nước ngoài ngưỡng mộ tìm đến Trung Quốc để học tập văn hóa y dược học cổ truyền.',
      '"来到中国学习" chỉ mục đích sang Trung Quốc là để học tập đông y.'
    ),
    (
      v_gp_id,
      '我们今天下午准备去新华书店购买几本汉语复习参考书。',
      'Wǒmen jīntiān xiàwǔ zhǔnbèi qù Xīnhuá Shūdiàn gòumǎi jǐ běn hànyǔ fùxí cānkǎoshū.',
      'Chiều hôm nay chúng tôi chuẩn bị đến Nhà sách Tân Hoa để mua vài cuốn sách tham khảo ôn thi tiếng Hán.',
      '"去新华书店购买..." nêu rõ mục đích đến hiệu sách mua sách tham khảo.'
    );

  -- Điểm ngữ pháp #67: Câu liên động chỉ phương thức "Động từ 1 + 着 + Động từ 2"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu liên động chỉ phương thức "Động từ 1 + 着 + Động từ 2"',
    'Chủ ngữ + Động từ 1 + 着 + (Tân ngữ 1) + Động từ 2 (+ Tân ngữ 2)',
    'Cấu trúc câu',
    'Cấu trúc "V1 + 着 + V2" dùng hành động thứ nhất (V1) để làm phương thức hoặc trạng thái đệm cho hành động chính thứ hai (V2) diễn ra (làm việc 2 trong trạng thái việc 1, như: 站着说: đứng nói, 笑着听: cười nghe).',
    'HSK 2',
    67,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '老校长微笑着走上讲台，热情地向全校新生致辞。',
      'Lǎo xiàozhǎng wēixiào zhe zǒu shàng jiǎngtái, rèqíng de xiàng quán xiào xīnshēng zhìcí.',
      'Vị hiệu trưởng già mỉm cười bước lên bục giảng, nhiệt tình phát biểu chúc mừng tân sinh viên toàn trường.',
      '"微笑着走上" miêu tả nụ cười là phương thức thái độ khi bước lên bục.'
    ),
    (
      v_gp_id,
      '下班回家的路上，几个年轻人听着音乐欢快地骑着自行车。',
      'Xiàbān huíjiā de lù shang, jǐ gè niánqīngrén tīng zhe yīnyuè huānkuài de qí zhe zìxíngchē.',
      'Trên đường tan làm về nhà, mấy người trẻ vừa nghe nhạc vừa vui vẻ đạp xe đạp.',
      '"听着音乐骑自行车" thể hiện trạng thái nghe nhạc đồng thời khi đi xe đạp.'
    );

  -- Điểm ngữ pháp #68: Câu hỏi phản vấn phủ định "不是...吗？" (Chẳng phải là... sao?)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu hỏi phản vấn phủ định "不是...吗？" (Chẳng phải là... sao?)',
    'Chủ ngữ + 不是 + Vị ngữ / Tình huống + 吗?',
    'Cấu trúc câu',
    'Cấu trúc "不是...吗？" (bú shì... ma?) dùng để hỏi ngược lại nhằm nhấn mạnh sự khẳng định chắc chắn về một sự việc hiển nhiên mà người nghe lẽ ra phải biết (chẳng phải là... sao, không phải là... ư). Mang ngữ khí nhắc nhở hoặc ngạc nhiên.',
    'HSK 2',
    68,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '你昨天不是答应过今天会准时来参加同学聚会吗？',
      'Nǐ zuótiān bú shì dāying guo jīntiān huì zhǔnshí lái cānjiā tóngxué jùhuì ma?',
      'Hôm qua chẳng phải bạn đã hứa hôm nay sẽ đến đúng giờ tham gia buổi họp lớp rồi sao?',
      '"不是答应过...吗" nhắc nhở lại lời hứa trong quá khứ.'
    ),
    (
      v_gp_id,
      '今天外面不是正在下大雨吗，你怎么不带雨伞出门？',
      'Jīntiān wàimiàn bú shì zhèngzài xià dàyǔ ma, nǐ zěnme bú dài yǔsǎn chūmén?',
      'Hôm nay bên ngoài chẳng phải đang đổ mưa to sao, sao bạn lại không mang ô ra ngoài?',
      'Nhấn mạnh thực tế trời mưa hiển nhiên.'
    );

  -- Điểm ngữ pháp #69: Cấu trúc tăng tiến "越...越..." (Càng... càng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tăng tiến "越...越..." (Càng... càng...)',
    '越 + Tính từ / Động từ 1 + 越 + Tính từ / Động từ 2 / Chủ ngữ + 越 + V1 + 越 + V2',
    'Cấu trúc câu',
    'Cấu trúc "越...越..." (yuè... yuè...) biểu thị mức độ phát triển của một trạng thái hoặc hành động tỉ lệ thuận tăng tiến theo sự gia tăng của một yếu tố khác hoặc theo thời gian (càng... thì càng...).',
    'HSK 2',
    69,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着科技水平的不断提高，新能源汽车的性能越做越优异。',
      'Suízhe kējì shuǐpíng de bùduàn tígāo, xīn néngyuán qìchē de xìngnéng yuè zuò yuè yōuyì.',
      'Cùng với trình độ công nghệ không ngừng nâng cao, tính năng của xe ô tô năng lượng mới càng làm càng trở nên vượt trội.',
      '"越做越优异" biểu thị chất lượng ngày càng xuất sắc hơn.'
    ),
    (
      v_gp_id,
      '在异国他乡生活得越久，他心中对故乡亲人的思念就越深。',
      'Zài yìguó-tāxiāng shēnghuó de yuè jiǔ, tā xīnzhōng duì gùxiāng qīnrén de sīniàn jiù yuè shēn.',
      'Sống ở nơi đất khách quê người càng lâu, nỗi nhớ nhung người thân nơi quê nhà trong lòng anh lại càng sâu nặng.',
      '"越久...越深" chỉ thời gian càng dài thì nỗi nhớ càng sâu sắc.'
    );

  -- Điểm ngữ pháp #70: Cấu trúc tương lai sắp sửa xảy ra "快(要)...了 / 就要...了"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tương lai sắp sửa xảy ra "快(要)...了 / 就要...了"',
    'Chủ ngữ + 快 / 快要 / 就要 + Động từ / Tính từ + 了',
    'Cấu trúc câu',
    'Cấu trúc "快要 / 就要...了" (kuài yào / jiù yào... le) biểu thị một hành động hoặc sự thay đổi trạng thái sẽ diễn ra trong thời gian rất ngắn sắp tới (sắp... rồi). Chú ý: Nếu câu có trạng ngữ thời gian cụ thể (như 明天, 下周) thì chỉ được dùng "就要...了", không dùng "快要...了".',
    'HSK 2',
    70,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '列车快要开动了，请送行的亲友尽快走下车厢。',
      'Lièchē kuàiyào kāidòng le, qǐng sòngxíng de qīnyǒu jǐnkuài zǒu xià chēxiāng.',
      'Đoàn tàu sắp chuyển bánh rồi, xin mời người thân tiễn đưa mau chóng bước xuống toa tàu.',
      '"快要开动了" biểu thị sự việc khởi hành sắp sửa diễn ra trong tích tắc.'
    ),
    (
      v_gp_id,
      '明天早晨八点我们就要举行新校区奠基仪式了。',
      'Míngtiān zǎochén bā diǎn wǒmen jiù yào jǔxíng xīn xiàoqū diànjī yíshì le.',
      'Tám giờ sáng mai chúng tôi sẽ tổ chức lễ đặt đá khởi công khu học xá mới rồi.',
      '"明天早晨八点...就要...了" có mốc giờ cụ thể kết hợp với "就要".'
    );

  -- Điểm ngữ pháp #71: Cấu trúc nhấn mạnh quá khứ "是...的" (Đặc tả thời gian, địa điểm, cách thức)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc nhấn mạnh quá khứ "是...的" (Đặc tả thời gian, địa điểm, cách thức)',
    'Chủ ngữ + 是 + [Thời gian / Địa điểm / Phương thức / Mục đích] + Động từ + 的',
    'Cấu trúc câu',
    'Cấu trúc "是...的" (shì... de) dùng cho một sự việc ĐÃ HOÀN THÀNH trong quá khứ nhằm nhấn mạnh vào chi tiết thời gian (khi nào), địa điểm (ở đâu), cách thức tiến hành (bằng cách nào) hoặc chủ thể thực hiện.',
    'HSK 2',
    71,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我是去年九月份乘坐长途客机来到北京留学的。',
      'Wǒ shì qùnián jiǔ yuèfèn chéngzuò chángtú kèjī lái dào Běijīng liúxué de.',
      'Tôi là vào tháng Chín năm ngoái đi máy bay đường dài đến Bắc Kinh du học.',
      '"是去年九月份...的" nhấn mạnh mốc thời gian du học đã diễn ra.'
    ),
    (
      v_gp_id,
      '这本珍贵的汉语字典是恩师在大学毕业时送给我的。',
      'Zhè běn zhēnguì de hànyǔ zìdiǎn shì ēnshī zài dàxué bìyè shí sòng gěi wǒ de.',
      'Cuốn tự điển tiếng Hán quý giá này là người thầy ơn đã tặng cho tôi khi tốt nghiệp đại học.',
      '"是恩师...送给我的" nhấn mạnh người tặng và thời điểm tặng.'
    );

  -- Điểm ngữ pháp #72: Cấu trúc điều kiện cần thiết "只要...就..." (Chỉ cần... thì...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc điều kiện cần thiết "只要...就..." (Chỉ cần... thì...)',
    '只要 + Điều kiện cần, 就 + Kết quả tương ứng',
    'Cấu trúc câu',
    'Cặp liên từ "只要...就..." (zhǐyào... jiù...) biểu thị mối quan hệ điều kiện cần thiết: chỉ cần có điều kiện này được đáp ứng thì nhất định sẽ sản sinh ra kết quả tương ứng kèm theo (chỉ cần... thì sẽ...).',
    'HSK 2',
    72,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只要大家齐心协力努力拼搏，就一定能够战胜困难。',
      'Zhǐyào dàjiā qíxīn-xiélì nǔlì pīnbó, jiù yídìng nénggòu zhànshèng kùnnán.',
      'Chỉ cần mọi người đồng tâm hiệp lực nỗ lực phấn đấu thì nhất định có thể chiến thắng khó khăn.',
      '"只要...就..." nhấn mạnh chỉ cần có sự chung sức sẽ dẫn tới thành công.'
    ),
    (
      v_gp_id,
      '只要明天天气晴朗不刮大风，我们全家人就去郊游。',
      'Zhǐyào míngtiān tiānqì qínglǎng bù guā dàfēng, wǒmen quán jiārén jiù qù jiāoyóu.',
      'Chỉ cần ngày mai thời tiết tạnh ráo không nổi gió lớn thì cả gia đình chúng tôi sẽ đi dã ngoại.',
      'Điều kiện thời tiết tốt để cả nhà đi chơi.'
    );

  -- Điểm ngữ pháp #73: Đại từ chỉ định không xác định "一些 / 有的" (Một số / Có những)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ chỉ định không xác định "一些 / 有的" (Một số / Có những)',
    '一些 + Danh từ / 有的 + Danh từ (+ ..., 有的...)',
    'Đại từ',
    '"一些" (yìxiē) biểu thị số lượng không xác định của sự vật (một vài, một số). "有的" (yǒude) dùng để chỉ một bộ phận trong một tổng thể (có người, có những cái). Cấu trúc sóng đôi "有的...有的..." chỉ sự đa dạng.',
    'HSK 2',
    73,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '下课后操场上很热闹，有的同学在打篮球，有的在跑步。',
      'Xiàkè hòu cāochǎng shang hěn rènao, yǒude tóngxué zài dǎ lánqiú, yǒude zài pǎobù.',
      'Sau khi tan học sân vận động rất náo nhiệt, có bạn đang chơi bóng rổ, có bạn lại đang chạy bộ.',
      '"有的...有的..." miêu tả các nhóm hoạt động phong phú của học sinh.'
    ),
    (
      v_gp_id,
      '他在书店精心挑选了一些适合初学者的汉语课外读物。',
      'Tā zài shūdiàn jīngxīn tiāoxuǎn le yìxiē shìhé chūxuézhě de hànyǔ kèwài dúwù.',
      'Anh ấy ở hiệu sách đã kỳ công chọn lựa một số cuốn sách đọc thêm tiếng Hán thích hợp cho người mới bắt đầu.',
      '"一些...读物" chỉ một số lượng sách nhất định.'
    );

  -- Điểm ngữ pháp #74: Trùng điệp động từ biểu thị thử nghiệm / thoải mái "AA / A一A"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Trùng điệp động từ biểu thị thử nghiệm / thoải mái "AA / A一A"',
    'Động từ đơn âm: AA / A一A / A了A (看看 / 看一看 / 看了看)',
    'Động từ',
    'Trùng điệp động từ (lặp lại động từ) dùng để biểu thị động tác diễn ra trong thời gian ngắn, mang tính chất thử nghiệm, nhẹ nhàng hoặc làm cho ngữ khí câu cầu khiến trở nên mềm mại, hòa nhã (thử xem chút, ngắm một tí).',
    'HSK 2',
    74,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这件羊毛外套款式很新颖，你快穿上试一试合不合身。',
      'Zhè jiàn yángmáo wàitào kuǎnshì hěn xīnyǐng, nǐ kuài chuān shang shì-yi-shì hé bù héshēn.',
      'Chiếc áo khoác dạ len này kiểu dáng rất mới lạ, bạn mau mặc thử một chút xem có vừa vặn không.',
      '"试一试" biểu thị hành động mặc thử mang tính trải nghiệm ngắn.'
    ),
    (
      v_gp_id,
      '周末我们在家里听听轻音乐、看看书，身心格外放松。',
      'Zhōumò wǒmen zài jiā lǐ tīng-ting qīngyīnyuè, kàn-kan shū, shēnxīn géwài fàngsōng.',
      'Cuối tuần chúng tôi ở nhà nghe chút nhạc nhẹ, đọc chút sách, thân tâm vô cùng thư thái.',
      '"听听" và "看看" tạo cảm giác thư giãn nhẹ nhàng của các hoạt động.'
    );

  -- Điểm ngữ pháp #75: Trùng điệp tính từ miêu tả mức độ "AA(的)" (Xanh mướt / Tròn xoe / Cao vút)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Trùng điệp tính từ miêu tả mức độ "AA(的)" (Xanh mướt / Tròn xoe / Cao vút)',
    'Tính từ đơn âm trùng điệp: AA (+ 的) + Danh từ (红红的 / 大大的 / 高高的)',
    'Tính từ',
    'Trùng điệp tính từ đơn âm tiết thành dạng "AA(的)" dùng để tăng cường mức độ miêu tả, mang sắc thái biểu cảm yêu mến, sinh động hoặc cụ thể hóa hình tượng (tròn xoe, đỏ ửng, cao vút). Thường làm định ngữ hoặc trạng ngữ.',
    'HSK 2',
    75,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '小妹妹长着一双大大的眼睛和一张红红的小脸蛋。',
      'Xiǎo mèimei zhǎng zhe yì shuāng dàdà de yǎnjīng hé yì zhāng hónghóng de xiǎo liǎndàn.',
      'Em gái nhỏ có một đôi mắt to tròn xoe và một khuôn mặt nhỏ ửng hồng xinh xắn.',
      '"大大的" và "红红的" miêu tả sinh động vẻ đáng yêu của em bé.'
    ),
    (
      v_gp_id,
      '公路两旁整齐地生长着一排排高高的白杨树。',
      'Gōnglù liǎngpáng zhěngqí de shēngzhǎng zhe yì páipái gāogāo de báiyángshù.',
      'Hai bên đường cái mọc ngay ngắn từng hàng cây bạch dương cao vút.',
      '"高高的" nhấn mạnh chiều cao nổi bật của rặng cây.'
    );

  -- Điểm ngữ pháp #76: Phó từ biểu thị tính chất vốn có "本来" (Vốn dĩ / Ban đầu)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ biểu thị tính chất vốn có "本来" (Vốn dĩ / Ban đầu)',
    'Chủ ngữ + 本来 + Vị ngữ (+ 后来 / 但是...)',
    'Phó từ',
    '"本来" (běnlái) biểu thị trạng thái hoặc tình huống vốn dĩ từ trước đến nay là như vậy, hoặc kế hoạch ban đầu như vậy nhưng về sau có sự thay đổi (vốn dĩ, lẽ ra, ban đầu).',
    'HSK 2',
    76,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们本来打算今天去郊游，可是突降大暴雨只好改期。',
      'Wǒmen běnlái dǎsuàn jīntiān qù jiāoyóu, kěshì tūjiàng dà bàoyǔ zhǐhǎo gǎiqī.',
      'Chúng tôi vốn dĩ dự tính hôm nay đi dã ngoại, nhưng bất chợt đổ mưa to đành phải dời ngày.',
      '"本来打算...可是..." biểu thị kế hoạch ban đầu bị thay đổi do mưa.'
    ),
    (
      v_gp_id,
      '这道数学题本来就很简单，只要细心就能做对。',
      'Zhè dào shùxué tí běnlái jiù hěn jiǎndān, zhǐyào xìxīn jiù néng zuò duì.',
      'Bài toán này vốn dĩ đã rất đơn giản, chỉ cần cẩn thận là có thể làm đúng.',
      '"本来就很简单" nhấn mạnh bản chất vốn có của bài toán.'
    );

  -- Điểm ngữ pháp #77: Từ chỉ thời gian cự ly ngắn "不久" (Chẳng bao lâu / Vừa mới)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Từ chỉ thời gian cự ly ngắn "不久" (Chẳng bao lâu / Vừa mới)',
    'Thời điểm / Hành động + 不久 (+ 就...) / 不久以前',
    'Phó từ',
    '"不久" (bùjiǔ) chỉ khoảng cách thời gian rất ngắn giữa hai thời điểm hoặc khoảng cách ngắn so với hiện tại (chẳng bao lâu sau, cách đây không lâu).',
    'HSK 2',
    77,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他们大学毕业后不久，就顺利进入了知名外企工作。',
      'Tāmen dàxué bìyè hòu bùjiǔ, jiù shùnlì jìnrù le zhīmíng wàiqǐ gōngzuò.',
      'Họ sau khi tốt nghiệp đại học chẳng bao lâu, thì đã thuận lợi bước chân vào làm việc tại công ty nước ngoài danh tiếng.',
      '"毕业后不久" chỉ khoảng thời gian ngắn sau khi tốt nghiệp.'
    ),
    (
      v_gp_id,
      '这栋现代化的综合教学大楼是不久前刚刚建成的。',
      'Zhè dòng xiàndàihuà de zōnghé jiàoxué dàlóu shì bùjiǔ qián gānggāng jiànchéng de.',
      'Tòa nhà giảng đường tổng hợp hiện đại này là cách đây không lâu vừa mới xây dựng xong.',
      '"不久前" chỉ thời điểm xảy ra gần đây.'
    );

  -- Điểm ngữ pháp #78: Cấu trúc cảm thán biểu thị mức độ cao "太...了" (Quá... rồi / Lắm)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cảm thán biểu thị mức độ cao "太...了" (Quá... rồi / Lắm)',
    '太 + Tính từ / Động từ tâm lý + 了!',
    'Phó từ',
    '"太...了" (tài... le) dùng để biểu thị mức độ cực kỳ cao, thường dùng trong câu cảm thán để bày tỏ sự khen ngợi, tán thưởng nồng nhiệt hoặc phàn nàn, không hài lòng (quá... rồi, ...lắm).',
    'HSK 2',
    78,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '你在全国青少年演讲比赛中的发挥真是太出色了！',
      'Nǐ zài quánguó qīng-shàonián yǎnjiǎng bǐsài zhōng de fāhuī zhēn shì tài chūsè le!',
      'Màn thể hiện của bạn trong cuộc thi diễn thuyết thanh thiếu niên toàn quốc thật là quá xuất sắc rồi!',
      '"太出色了" ca ngợi phong độ tuyệt vời của thí sinh.'
    ),
    (
      v_gp_id,
      '这盘北京烤鸭皮脆肉嫩，味道太香了！',
      'Zhè pán Běijīng kǎoyā pí cuì ròu nèn, wèidào tài xiāng le!',
      'Đĩa vịt quay Bắc Kinh này da giòn thịt mềm, mùi vị thơm ngon quá chừng!',
      '"太香了" tán thán hương vị tuyệt hảo của món ăn.'
    );

END $$;

COMMIT;
