-- ==============================================================================
-- MIGRATION: 20261024060000_hsk6_grammar_123_seed.sql
-- NẠP 123 ĐIỂM NGỮ PHÁP HSK 6 KÈM 246 CÂU VÍ DỤ CHUẨN GF 0025-2021 (APPENDIX A)
-- Có giải thích chi tiết tiếng Việt, công thức pattern, Pinyin có dấu thanh và phân loại chuẩn
-- BỔ SUNG CHỈ MỤC TỐI ƯU TRUY VẤN idx_grammar_examples_point_id
-- ==============================================================================

BEGIN;

-- 1. Đảm bảo Index tối ưu hóa truy vấn JOIN giữa grammar_points và grammar_examples
CREATE INDEX IF NOT EXISTS idx_grammar_examples_point_id ON public.grammar_examples(grammar_point_id);

-- 2. Thêm dữ liệu 123 điểm ngữ pháp HSK 6 và 246 câu ví dụ
DO $$
DECLARE
  v_gp_id uuid;
BEGIN
  -- Điểm ngữ pháp #1: Đại từ văn ngôn tân ngữ & sở thuộc "之" (Nó / Của nó / Họ / Điều đó)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ văn ngôn tân ngữ & sở thuộc "之" (Nó / Của nó / Họ / Điều đó)',
    'Động từ + 之 / Danh từ + 之 + Danh từ / 之所以...是因为... / ...之一 / 忘之 / 避之不及',
    'Đại từ',
    '"之" (zhī) là một trong những hư từ văn ngôn quan trọng nhất trong tiếng Trung cổ và hiện đại. Trong HSK 6, "之" đóng vai trò đại từ làm tân ngữ trực tiếp thay thế cho người, vật hoặc sự việc vừa được nhắc tới (tương đương với "他/她/它" hoặc "他们"). Ngoài ra "之" làm trợ từ sở thuộc tương đương "的", xuất hiện trong các cấu trúc kinh điển như "之所以...是因为...", "取之于民，用之于民".',
    'HSK 6',
    1,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '优秀的文化传统是民族的血脉，我们应当倍加珍惜之、弘扬之。',
      'Yōuxiù de wénhuà chuántǒng shì mínzú de xuèmài, wǒmen yīngdāng bèijiā zhēnxī zhī, hóngyáng zhī.',
      'Truyền thống văn hóa xuất sắc là huyết mạch của dân tộc, chúng ta cần phải hết sức trân trọng nó, phát huy nó.',
      '"珍惜之、弘扬之" dùng "之" làm tân ngữ thay thế trực tiếp cho "优秀的文化传统", mang lại nhịp điệu biền ngẫu trang nghiêm.'
    ),
    (
      v_gp_id,
      '政府设立这项专项基金的根本初衷，就在于取之于民并全额用之于民。',
      'Zhèngfǔ shèlì zhè xiàng zhuānxiàng jījīn de gēnběn chūzhōng, jiù zàiyú qǔ zhī yú mín bìng quán''é yòng zhī yú mín.',
      'Ý định ban đầu căn bản của chính phủ khi thành lập quỹ chuyên dùng này chính là lấy của dân và dùng toàn bộ phục vụ nhân dân.',
      '"取之于民，用之于民" là châm ngôn quản trị quốc gia kinh điển thể hiện trách nhiệm tài chính công đối với nhân dân.'
    );

  -- Điểm ngữ pháp #2: Đại từ nhân xưng & chỉ thị văn ngôn "尔" (Ngươi / Mày / Như thế / Thế thôi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ nhân xưng & chỉ thị văn ngôn "尔" (Ngươi / Mày / Như thế / Thế thôi)',
    '尔等 (các ngươi) / 尔后 (sau đó) / 不过尔尔 (chẳng qua chỉ có vậy)',
    'Đại từ',
    '"尔" (ěr) là đại từ nhân xưng ngôi thứ hai văn ngôn (ngươi, các ngươi) hoặc mang nghĩa chỉ thị "như thế, ngần ấy" (tương đương "如此, 罢了"). Thành ngữ HSK 6 "不过尔尔" miêu tả sự vật tầm thường, bình thường chẳng qua chỉ đến thế mà thôi.',
    'HSK 6',
    2,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '原以为这家号称百年老字号的餐馆菜肴非同凡响，实地品尝后才发现水平不过尔尔。',
      'Yuán yǐwéi zhè jiā hàochēng bǎinián lǎozìhào de cānguǎn càiyáo fēitóngfánxiǎng, shídì pǐncháng hòu cái fāxiàn shuǐpíng búguò''ěr''ěr.',
      'Cứ ngỡ món ăn của nhà hàng tự xưng trăm năm danh tiếng này xuất chúng phi phàm, sau khi thưởng thức thực tế mới phát hiện trình độ cũng chỉ bình thường đến thế mà thôi.',
      '"不过尔尔" thể hiện sự thất vọng tinh tế đối với chất lượng không tương xứng với danh tiếng đồn thổi.'
    ),
    (
      v_gp_id,
      '双方就停火协议达成初步共识，尔后将展开关于战后重建细节的深入磋商。',
      'Shuāngfāng jiù tínghuǒ xiéyì dáchéng chūbù gòngshí, ěrhòu jiāng zhǎnkāi guānyú zhànhòu chóngjiàn xìjié de shēnrù cuōshāng.',
      'Đôi bên đã đạt được đồng thuận sơ bộ về thỏa thuận ngừng bắn, sau đó sẽ triển khai tham vấn sâu rộng về các chi tiết tái thiết hậu chiến.',
      '"尔后" là từ nối văn ngôn trang trọng biểu thị mốc thời gian nối tiếp tương đương với "此后, 以后".'
    );

  -- Điểm ngữ pháp #3: Đại từ văn ngôn chỉ định tập hợp số nhiều "诸" (Chư / Các / Mọi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ văn ngôn chỉ định tập hợp số nhiều "诸" (Chư / Các / Mọi)',
    '诸 + Danh từ / 诸位 / 诸如此类 / 付诸实施 / 付诸东流',
    'Đại từ',
    '"诸" (zhū) có hai công năng cốt lõi trong HSK 6: 1) Đại từ văn ngôn chỉ số nhiều (các, chư, nhiều), như 诸位 (chư vị), 诸子百家 (chư tử bách gia), 诸事 (mọi việc); 2) Kiêm từ văn ngôn gộp của "之于" (đối với nó, vào đó) trong các kết cấu: 付诸实施 (đưa vào thực thi), 付诸东流 (đổ sông đổ biển).',
    'HSK 6',
    3,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '宏伟的规划如果仅仅停留在纸面上而不付诸实施，终究不过是一纸空谈。',
      'Hóngwěi de guīhuà rúguǒ jǐnjǐn tíngliú zài zhǐmiàn shang ér bú fù zhū shíshī, zhōngjiū búguò shì yì zhǐ kōngtán.',
      'Quy hoạch hùng vĩ nếu như chỉ dừng lại trên mặt giấy tờ mà không đưa vào thực thi, rốt cuộc cũng chẳng qua chỉ là một tờ giấy sáo rỗng.',
      '"付诸实施" mang cấu trúc "付之于实施" (đem nó áp dụng vào thực tiễn), là quán dụng ngữ chính trị cao cấp.'
    ),
    (
      v_gp_id,
      '商场里摆满了智能手表、无线耳机、扫地机器人诸如此类的高科技消费品。',
      'Shāngchǎng lǐ bǎimǎn le zhìnéng shǒubiǎo, wúxiàn ěrjī, sǎodì jīqìrén zhū rúcǐ lèi de gāo kējì xiāofèipǐn.',
      'Trong trung tâm thương mại bày đầy đồng hồ thông minh, tai nghe không dây, robot hút bụi cùng các loại sản phẩm tiêu dùng công nghệ cao đại loại như thế.',
      '"诸如此类" là thành ngữ ngữ pháp hóa liệt kê đại từ tương đương với "等等此类" (các loại như vậy).'
    );

  -- Điểm ngữ pháp #4: Đại từ xưng hô tôn kính ngoại giao đỉnh cao "阁下" (Các hạ / Ngài)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ xưng hô tôn kính ngoại giao đỉnh cao "阁下" (Các hạ / Ngài)',
    '阁下 + Lời chào nghi lễ / Tổng thống / Thủ tướng + 阁下',
    'Đại từ',
    '"阁下" (géxià) là đại từ xưng hô nghi lễ ngoại giao cấp cao nhất dành cho nguyên thủ quốc gia, thủ tướng, đại sứ đặc mệnh toàn quyền hoặc các yếu nhân quốc tế (Các hạ, Kính thưa Ngài).',
    'HSK 6',
    4,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '尊敬的总统阁下，我谨代表全体中国人民向您及贵国人民致以最诚挚的祝贺。',
      'Zūnjìng de zǒngtǒng géxià, wǒ jǐn dàibiǎo quántǐ Zhōngguó rénmín xiàng nín jí guìguó rénmín zhìyǐ zuì chéngzhì de zhùhè.',
      'Kính thưa Tổng thống Các hạ, tôi xin trân trọng đại diện cho toàn thể nhân dân Trung Quốc gửi tới Ngài cùng nhân dân quý quốc lời chúc mừng chân thành nhất.',
      '"总统阁下" là nghi thức xưng hô ngoại giao nguyên thủ quốc gia tối cao theo công pháp quốc tế.'
    ),
    (
      v_gp_id,
      '大使阁下在任期内为增进两国人民之间的传统友谊作出了不可磨灭的历史贡献。',
      'Dàshǐ géxià zài rènqī nèi wèi zēngjìn liǎng guó rénmín zhījiān de chuántǒng yǒuyì zuòchū le bùkě mómì de lìshǐ gòngxiàn.',
      'Đại sứ Các hạ trong nhiệm kỳ của mình đã đóng góp những cống hiến lịch sử không thể phai mờ vào việc thắt chặt tình hữu nghị truyền thống giữa nhân dân hai nước.',
      '"大使阁下" thể hiện sự tôn vinh cao quý dành cho vị trưởng đoàn ngoại giao nước bạn.'
    );

  -- Điểm ngữ pháp #5: Cụm đại từ văn ngôn bao quát tổng kết "凡此种种" (Phàm tất thảy những điều đó)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm đại từ văn ngôn bao quát tổng kết "凡此种种" (Phàm tất thảy những điều đó)',
    'Liệt kê các hiện tượng phức tạp... 凡此种种, 皆 / 都 + Kết luận quy nạp',
    'Đại từ',
    '"凡此种种" (fán cǐ zhǒngzhǒng) là cụm từ văn ngôn quy nạp độc lập đứng ở đầu phân câu kết luận, có nghĩa là "phàm tất thảy những hiện tượng, nguyên nhân đa dạng vừa được liệt kê ở trên". Dùng để thâu tóm toàn bộ dữ kiện thành một nhận định bản chất.',
    'HSK 6',
    5,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '缺乏科学规划、盲目投资扩张、内部管理松懈，凡此种种，最终导致了企业的破产重组。',
      'Quēfá kēxué guīhuà, mángmù tóuzī kuòzhāng, nèibù guǎnlǐ sōngxiè, fán cǐ zhǒngzhǒng, zuìzhōng dǎozhì le qǐyè de pòchǎn chóngzǔ.',
      'Thiếu quy hoạch khoa học, mù quáng đầu tư bành trướng, quản lý nội bộ lỏng lẻo, phàm tất thảy những điều đó, cuối cùng đã dẫn tới việc doanh nghiệp phá sản tái cơ cấu.',
      '"凡此种种" thâu tóm toàn bộ 3 căn nguyên sai lầm quản trị dẫn tới kết cục sụp đổ của công ty.'
    ),
    (
      v_gp_id,
      '民俗文化的传承、民间工艺的保护、非遗技艺的弘扬，凡此种种，皆需要全社会共同关注。',
      'Mínsú wénhuà de chuánchéng, mínjiān gōngyì de bǎohù, fēiyí jìyì de hóngyáng, fán cǐ zhǒngzhǒng, jiē xūyào quán shèhuì gòngtóng guānzhù.',
      'Sự kế thừa văn hóa dân gian, sự bảo tồn nghề thủ công làng quê, sự phát huy kỹ nghệ phi vật thể, phàm tất cả những điều đó, đều cần sự chung tay quan tâm của toàn xã hội.',
      '"凡此种种，皆需要..." quy nạp các nhánh di sản văn hóa vào mối quan tâm chung của toàn dân.'
    );

  -- Điểm ngữ pháp #6: Danh lượng từ thi ca chỉ làn, luồng tơ mỏng manh "缕" (Làn / Luồng / Sợi / Tia)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ thi ca chỉ làn, luồng tơ mỏng manh "缕" (Làn / Luồng / Sợi / Tia)',
    'Số từ + 缕 + Danh từ (清风 / 阳光 / 炊烟 / 哀思 / 思绪 / 幽香)',
    'Lượng từ',
    '"缕" (lǚ) là lượng từ thi ca cực kỳ tinh tế, dùng cho: 1) Các hiện tượng tự nhiên thanh thoát, nhẹ nhàng như sợi tơ (một làn gió mát, một luồng khói bếp, một tia nắng sớm); 2) Cảm xúc, tâm tư hoặc nỗi niềm vương vấn trong lòng (một niềm tiếc thương, một mối tơ lòng).',
    'HSK 6',
    6,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '清晨，一缕金色的阳光穿过茂密的松林，在青翠的草地上洒下了斑驳的林荫。',
      'Qīngchén, yì lǚ jīnsè de yángguāng chuānguò màomì de sōnglín, zài qīngcuì de cǎodì shang sǎxià le bānbó de línyīn.',
      'Sáng sớm, một tia nắng vàng rực rỡ xuyên qua rừng thông rậm rạp, rọi bóng cây lốm đốm xuống thảm cỏ xanh mướt.',
      '"一缕金色的阳光" dùng "缕" đặc tả tia nắng mai mềm mại xuyên qua kẽ lá.'
    ),
    (
      v_gp_id,
      '微风徐徐吹过湖面，送来了一缕沁人心脾的荷花幽香。',
      'Wēifēng xúxú chuīguò húmiàn, sònglái le yì lǚ qìnrénxīnpí de héhuā yōuxiāng.',
      'Làn gió nhẹ từ từ lướt qua mặt hồ, mang theo một làn hương hoa sen thanh tao làm mát tận lòng người.',
      '"一缕...荷花幽香" định lượng cho làn hương sen thoang thoảng dịu êm.'
    );

  -- Điểm ngữ pháp #7: Danh lượng từ hội họa chỉ vệt màu, nét cười "抹" (Vệt / Vạt / Nét)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ hội họa chỉ vệt màu, nét cười "抹" (Vệt / Vạt / Nét)',
    'Số từ + 抹 + Danh từ (晚霞 / 微笑 / 斜阳 / 亮色 / 忧伤)',
    'Lượng từ',
    '"抹" (mǒ) có nguồn gốc từ động từ quệt màu, quét sơn trong hội họa. Khi làm lượng từ, "抹" chuyên dùng cho những mảng màu sắc trên nền trời tự nhiên (như 一抹晚霞 - một vạt ráng chiều) hoặc biểu cảm thoảng qua trên khuôn mặt con người (như 一抹微笑 - một nét cười thoáng qua).',
    'HSK 6',
    7,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '夕阳西下，天边残留着一抹绚烂如锦的火红晚霞。',
      'Xīyáng xīxià, tiānbiān cánliúzhe yì mǒ xuànlàn rújǐn de huǒhóng wǎnxiá.',
      'Mặt trời lặn về tây, nơi chân trời còn sót lại một vạt ráng chiều đỏ rực rỡ đẹp tựa gấm thêu.',
      '"一抹...晚霞" dùng "抹" định lượng cho dải mây chiều lộng lẫy nơi góc trời hoàng hôn.'
    ),
    (
      v_gp_id,
      '得知考试合格的好消息，她紧绷的嘴角边终于浮现出了一抹舒心的微笑。',
      'Dézhī kǎoshì hégé de hǎo xiāoxi, tā jǐnbēng de zuǐjiǎobiān zhōngyú fúxiàn chū le yì mǒ shūxīn de wēixiào.',
      'Được tin kỳ thi đã qua môn, khóe miệng đang căng thẳng của cô cuối cùng đã hé nở một nét cười thanh thản.',
      '"一抹舒心的微笑" miêu tả nét cười nhẹ nhõm thoáng hiện trên nét mặt xua tan lo lắng.'
    );

  -- Điểm ngữ pháp #8: Danh lượng từ nghệ thuật cổ chỉ bức tranh cuộn trục "轴" (Trục / Cuộn / Bức tranh cuộn)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ nghệ thuật cổ chỉ bức tranh cuộn trục "轴" (Trục / Cuộn / Bức tranh cuộn)',
    'Số từ + 轴 + Danh từ (画卷 / 山水画 / 长卷 / 史诗)',
    'Lượng từ',
    '"轴" (zhóu) là lượng từ chuyên dùng cho tranh thủy mạc, tranh thư pháp cổ truyền Trung Hoa được gắn trục cuốn lại thành cuộn dài (như 一轴山水画 - một bức tranh cuộn sơn thủy, 一轴长卷). Thường dùng ẩn dụ cho bức tranh lịch sử hào hùng (như 一轴波澜壮阔的历史画卷).',
    'HSK 6',
    8,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '展厅正中央徐徐展开了一轴传世千年的北宋青绿山水古画长卷。',
      'Zhǎntīng zhèng zhōngyāng xúxú zhǎnkāi le yì zhóu chuánshì qiānnián de Běisòng qīnglǜ shānshuǐ gǔhuà chángjuàn.',
      'Chính giữa phòng triển lãm từ từ mở ra một cuộn tranh dài sơn thủy thanh lục thời Bắc Tống truyền đời ngàn năm.',
      '"一轴...古画长卷" dùng "轴" định lượng cho bức thư họa cổ trang quý báu cuộn trên trục gỗ.'
    ),
    (
      v_gp_id,
      '新时代的发展进程宛如一轴波澜壮阔的历史宏伟长卷，记录着人民奋斗的足迹。',
      'Xīn shídài de fāzhǎn jìnchéng wǎnrú yì zhóu bōlánzhuàngkuò de lìshǐ hóngwěi chángjuàn, jìlùzhe rénmín fèndòu de zújì.',
      'Tiến trình phát triển của thời đại mới ví tựa một bức tranh cuộn lịch sử tráng lệ sóng gió muôn trùng, ghi lại những dấu chân phấn đấu của nhân dân.',
      '"一轴...历史画卷" dùng "轴" theo nghĩa ẩn dụ thi ca tôn vinh sự nghiệp đổi mới của đất nước.'
    );

  -- Điểm ngữ pháp #9: Danh lượng từ điện ảnh & nhiếp ảnh chỉ khung hình "帧" (Khung hình / Tấm)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ điện ảnh & nhiếp ảnh chỉ khung hình "帧" (Khung hình / Tấm)',
    'Số từ + 帧 + Danh từ (画面 / 胶片 / 照片 / 影像)',
    'Lượng từ',
    '"帧" (zhēn) là lượng từ chuyên môn trong nghệ thuật điện ảnh, truyền hình số và nhiếp ảnh, biểu thị một khung hình ảnh đơn lẻ (frame) trong một chuỗi phim chuyển động hoặc một bức ảnh nghệ thuật tĩnh vật cao cấp (như 一帧画面, 每一帧 đều là kiệt tác).',
    'HSK 6',
    9,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这部纪录片的拍摄构图极其考究，可以说电影里的每一帧画面都美得令人窒息。',
      'Zhè bù jìlùpiàn de pāishè gòutú jíqí kǎojiu, kěyǐ shuō diànyǐng lǐ de měi yì zhēn huàmiàn dōu měi de lìngrénzhìxī.',
      'Bố cục quay phim của bộ phim tài liệu này cực kỳ tinh tế, có thể nói từng khung hình trong phim đều đẹp đến ngạt thở.',
      '"每一帧画面" ca ngợi nghệ thuật thị giác đỉnh cao của tác phẩm điện ảnh.'
    ),
    (
      v_gp_id,
      '高速摄像机以每秒一千帧的惊人速度，清晰捕捉到了雨滴落入水面的微观瞬间。',
      'Gāosù shèxiàngjī yǐ měi miǎo yìqiān zhēn de jīngrén sùdù, qīngxī bǔzhuō dào le yǔdī luòrù shuǐmiàn de wēiguān shùnjiān.',
      'Chiếc máy quay tốc độ cao với tốc độ đáng kinh ngạc 1000 khung hình/giây đã bắt trọn rõ nét khoảnh khắc vi mô hạt mưa rơi chạm mặt nước.',
      '"每秒一千帧" dùng "帧" làm đơn vị đo lường tần số quét khung hình công nghệ cao.'
    );

  -- Điểm ngữ pháp #10: Danh lượng từ y học cổ truyền chỉ liều, thang thuốc "剂" (Liều / Thang / Liều thuốc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ y học cổ truyền chỉ liều, thang thuốc "剂" (Liều / Thang / Liều thuốc)',
    'Số từ + 剂 + Danh từ (良药 / 补药 / 强心针 / 疫苗 / 镇静剂)',
    'Lượng từ',
    '"剂" (jì) là lượng từ y dược chuyên dùng cho một thang thuốc thang hoàn chỉnh, một liều vắc-xin tiêm chủng (như 一剂疫苗), hoặc dùng theo nghĩa ẩn dụ triết học cho một lời khuyên chân thành thức tỉnh con người (như 一剂良药 - một liều thuốc tốt đắng miệng, 一剂强心针 - một liều thuốc trợ tim cổ vũ tinh thần).',
    'HSK 6',
    10,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这篇针砭时弊的犀利评论宛如一剂苦口良药，振聋发聩地警醒了迷茫中的年轻人。',
      'Zhè piān zhēnbiānshíbì de xīlì pínglùn wǎnrú yí jì kǔkǒu liángyào, zhènlóngfākuì de jǐngxǐng le mímáng zhōng de niánqīngrén.',
      'Bài bình luận sắc sảo châm thẳng vào tệ nạn thời thế này ví tựa một thang thuốc đắng dã tật, đã gióng lên hồi chuông cảnh tỉnh người trẻ đang hoang mang lạc lối.',
      '"一剂苦口良药" dùng "剂" ẩn dụ cho bài học đạo đức nghiêm khắc nhưng cứu rỗi nhận thức.'
    ),
    (
      v_gp_id,
      '政府及时出台的减税降费纾困政策，为陷入低谷的实体经济注入了一剂强心针。',
      'Zhèngfǔ jíshí chūtái de jiǎnshuì jiàngfèi shūkùn zhèngcè, wèi xiànrù dīgǔ de shítǐ jīngjì zhùrù le yí jì qiángxīnzhēn.',
      'Chính sách giảm thuế hạ phí tháo gỡ khó khăn kịp thời của chính phủ đã tiêm một liều thuốc trợ tim cho nền kinh tế thực thể đang chìm trong đáy vực.',
      '"注入了一剂强心针" là lối nói kinh tế quen thuộc chỉ gói kích thích tài khóa cứu nguy doanh nghiệp.'
    );

  -- Điểm ngữ pháp #11: Danh lượng từ thi ca cổ điển chỉ bài từ, khúc hát "阕" (Khúc / Bài từ / Bài ca)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ thi ca cổ điển chỉ bài từ, khúc hát "阕" (Khúc / Bài từ / Bài ca)',
    'Số từ + 阕 + Danh từ (宋词 / 词 / 乐曲 / 绝唱)',
    'Lượng từ',
    '"阕" (què) là lượng từ văn học cổ điển chuyên biệt dành riêng cho các bài Tống từ (宋词) hoặc các khúc nhạc điệu nhã nhạc cung đình (như 一阕宋词, 上阕, 下阕). Thể hiện phong thái uyên bác, phong lưu của học giả văn phong cổ điển.',
    'HSK 6',
    11,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在中秋皓月当空之夜，文人墨客常常轻吟苏东坡那阕千古流传的水调歌头。',
      'Zài zhōngqiū hàoyuè dāngkōng zhī yè, wénrénmòkè chángcháng qīngyín Sū Dōngpō nà què qiāngǔ liúchuán de Shuǐdiàogētóu.',
      'Vào đêm trung thu trăng sáng vằng vặc trên không trung, các bậc văn nhân thi sĩ thường ngâm nga bài từ "Thủy Điệu Ca Đầu" truyền tụng ngàn thu của Tô Đông Pha.',
      '"那一阕...水调歌头" dùng "阕" làm lượng từ chuẩn mực cao quý cho kiệt tác Tống từ.'
    ),
    (
      v_gp_id,
      '古琴名家抚琴弹奏了一阕清幽旷远的古曲，令在场听众如痴如醉。',
      'Gǔqín míngjiā fǔqín tánzòu le yí què qīngyōu kuàngyuǎn de gǔqǔ, lìng zàichǎng tīngzhòng rúchīrúzuì.',
      'Nghệ nhân đàn cổ cầm gảy tấu lên một khúc cổ nhạc thanh u khoáng đạt khiến khán giả có mặt đều mê mẩn ngất ngây.',
      '"一阕...古曲" định lượng cho khúc nhạc thính phòng tao nhã xưa.'
    );

  -- Điểm ngữ pháp #12: Danh lượng từ chỉ vụ việc, cọc tâm sự phức tạp "桩" (Vụ / Mối / Chuyện)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ vụ việc, cọc tâm sự phức tạp "桩" (Vụ / Mối / Chuyện)',
    'Số từ + 桩 + Danh từ (心事 / 婚事 / 惨案 / 交易 / 疑案)',
    'Lượng từ',
    '"桩" (zhuāng) có nguồn gốc từ cọc gỗ đóng đất. Khi dùng làm lượng từ, "桩" chuyên dùng cho các sự kiện, vụ án ly kỳ, hoặc các mối tâm tư, hôn sự lớn trong đời người (như 一桩心事 - một mối tâm sự nặng trĩu, 一桩婚姻 - một mối hôn sự, 一桩悬案 - một vụ kỳ án chưa có lời giải).',
    'HSK 6',
    12,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '看到唯一的女儿顺利成家立业，老两口心头的一桩大心事终于落地了。',
      'Kàndào wéiyī de nǚ''ér shùnlì chéngjiālìyè, lǎo liǎngkǒu xīntóu de yì zhuāng dà xīnshì zhōngyú luòdì le.',
      'Nhìn thấy cô con gái độc nhất yên bề gia thất lập nghiệp vững vàng, một mối tâm sự lớn trong lòng hai ông bà già cuối cùng cũng đã được trút bỏ.',
      '"一桩大心事" dùng "桩" định lượng cho mối âu lo đăm đăm nuôi dạy con cái của cha mẹ.'
    ),
    (
      v_gp_id,
      '这桩轰动全国的长达三十年的历史悬案，经过现代DNA技术的比对终于水落石出。',
      'Zhè zhuāng hōngdòng quánguó de chángdá sānshí nián de lìshǐ xuán''àn, jīngguò xiàndài DNA jìshù de bǐduì zhōngyú shuǐluòshíchū.',
      'Vụ án tồn đọng lịch sử kéo dài suốt 30 năm gây chấn động cả nước này, qua đối chiếu kỹ thuật DNA hiện đại cuối cùng đã sáng tỏ chân tướng.',
      '"这桩...历史悬案" dùng "桩" làm lượng từ tư pháp chuẩn mực cho vụ án hình sự phức tạp.'
    );

  -- Điểm ngữ pháp #13: Danh lượng từ thi vị chỉ vầng trăng khuyết hình cánh cung "弯" (Mảnh / Vầng trăng cong)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ thi vị chỉ vầng trăng khuyết hình cánh cung "弯" (Mảnh / Vầng trăng cong)',
    '一 + 弯 + Danh từ (新月 / 残月 / 月亮 / 清泉)',
    'Lượng từ',
    '"弯" (wān) vốn là tính từ/động từ cong, uốn cong. Khi làm lượng từ nghệ thuật, "弯" chuyên dùng cho mảnh trăng non đầu tháng hoặc trăng tàn cuối tháng hình lưỡi liềm uốn cong thanh tú (như 一弯新月 - một mảnh trăng non).',
    'HSK 6',
    13,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '夜幕初垂，深蓝色的天幕上静静地挂着一弯皎洁明亮的新月。',
      'Yèmù chūchuí, shēnlánsè de tiānmù shang jìngjìng de guàzhe yì wān jiǎojié míngliàng de xīnyuè.',
      'Màn đêm vừa buông xuống, trên bức màn trời xanh thẳm lặng lẽ treo một mảnh trăng non trong sáng vằng vặc.',
      '"一弯...新月" miêu tả hình ảnh trăng khuyết lưỡi liềm thanh tao trên bầu trời đêm yên tĩnh.'
    ),
    (
      v_gp_id,
      '山谷深处环绕着一弯碧绿澄澈的天然清泉，倒映着四周秀丽的奇峰。',
      'Shāngǔ shēnchù huánràozhe yì wān bìlǜ chéngchè de tiānrán qīngquán, dàoyìngzhe sìzhōu xiùlì de qífēng.',
      'Nơi sâu trong thung lũng uốn quanh một dòng suối trong tự nhiên xanh biếc trong vắt, in bóng non ngút ngàn kỳ vĩ bốn bề.',
      '"一弯...清泉" dùng "弯" định lượng cho dòng suối uốn lượn hình cánh cung mềm mại.'
    );

  -- Điểm ngữ pháp #14: Danh lượng từ chỉ cảnh tượng, khí thế bao trùm "派" (Cảnh / Vẻ / Khí thế)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ cảnh tượng, khí thế bao trùm "派" (Cảnh / Vẻ / Khí thế)',
    '一 + 派 + Danh từ cảnh tượng/không khí (生机 / 祥和 / 欣欣向荣 / 繁荣景象)',
    'Lượng từ',
    '"派" (pài) khi làm lượng từ biểu thị một bầu không khí, cảnh tượng toàn cảnh hoặc một phong cách khí thế bao trùm khắp không gian (như 一派生机 - một vùng tràn đầy sức sống, 一派祥和 - một cảnh tượng an lành thái bình, 一派胡言 - toàn lời nói nhảm).',
    'HSK 6',
    14,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '春回大地，万物复苏，田野山川到处呈现出一派生机勃勃的欣欣向荣景象。',
      'Chūnhuídàdì, wànwù fùsū, tiányě shānchuān dàochù chéngxiàn chū yí pài shēngjībóbó de xīnxīnxiàngróng jǐngxiàng.',
      'Xuân về trên đất mẹ, muôn vật hồi sinh, đồng ruộng núi sông khắp nơi hiện ra một cảnh tượng dạt dào sức sống phồn vinh mơn mởn.',
      '"一派生机勃勃的景象" miêu tả toàn cảnh không gian thiên nhiên trỗi dậy mãnh liệt vào mùa xuân.'
    ),
    (
      v_gp_id,
      '逢年过节，大街小巷张灯结彩，呈现出一派欢天喜地、安定祥和的节日氛围。',
      'Féngniánguòjié, dàjiēxiǎoxiàng zhāngdēngjiécǎi, chéngxiàn chū yí pài huāntiānxǐdì, āndìng xiánghé de jiérì fènwéi.',
      'Mỗi độ tết đến xuân về, phố lớn ngõ nhỏ giăng đèn kết hoa, hiện ra một bầu không khí lễ hội vui vẻ rộn ràng, thanh bình an lạc.',
      '"一派...节日氛围" đặc tả bầu không khí tưng bừng phấn khởi bao trùm khắp phố phường.'
    );

  -- Điểm ngữ pháp #15: Danh lượng từ thi vị chỉ cánh hoa, múi và tấm lòng "瓣" (Cánh / Múi / Mảnh)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ thi vị chỉ cánh hoa, múi và tấm lòng "瓣" (Cánh / Múi / Mảnh)',
    'Số từ + 瓣 + Danh từ (花瓣 / 蒜 / 橘子 / 心香 / 心意)',
    'Lượng từ',
    '"瓣" (bàn) dùng cho cánh hoa, múi quả (như 一瓣橘子 - một múi quýt, 一瓣大蒜 - một nhánh tỏi). Trong văn học tao nhã HSK 6, "一瓣心香" là thành ngữ ngữ pháp hóa ẩn dụ cho tấm lòng thành kính, trong sạch và tôn kính dâng lên bề trên.',
    'HSK 6',
    15,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '春风拂过，枝头的粉红桃花纷纷飘落，将几瓣残红轻轻落在了旅人的肩头。',
      'Chūnfēng fúguò, zhītóu de fěnhóng táohuā fēnfēn piāoluò, jiāng jǐ bàn cánhóng qīngqīng luò zài le lǚrén de jiāntóu.',
      'Gió xuân thổi qua, hoa đào phớt hồng trên đầu cành đua nhau rụng xuống, thả nhẹ mấy cánh hoa phai lên bờ vai người lữ thứ.',
      '"几瓣残红" dùng "瓣" định lượng cho những cánh hoa đào rơi rụng theo gió xuân.'
    ),
    (
      v_gp_id,
      '临别之际无以为赠，谨奉上一瓣心香，遥祝恩师健康长寿、福泽绵长。',
      'Línbié zhījì wúyǐwéizèng, jǐn fèngshàng yí bàn xīnxiāng, yáozhù ēnshī jiànkāng chángshòu, fúzé miáncháng.',
      'Giờ phút chia tay chẳng có gì để tặng, kính dâng một tấm lòng thành kính tựa nén tâm hương, từ phương xa kính chúc ân sư sức khỏe trường thọ, phúc trạch dài lâu.',
      '"一瓣心香" là cách nói văn hóa nho nhã bày tỏ sự tri ân kính trọng sâu nặng với người thầy.'
    );

  -- Điểm ngữ pháp #16: Danh lượng từ thực vật & địa lý chỉ khóm, bụi, cụm "丛" (Bụi / Khóm / Cụm)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ thực vật & địa lý chỉ khóm, bụi, cụm "丛" (Bụi / Khóm / Cụm)',
    'Số từ + 丛 + Danh từ (灌木 / 鲜花 / 杂草 / 绿竹)',
    'Lượng từ',
    '"丛" (cóng) là lượng từ tập hợp dành cho các loài cây cỏ, hoa lá mọc tụ họp dày đặc sát cạnh nhau từ một gốc hoặc một cụm đất (như 一丛灌木 - một bụi cây bụi, 一丛野花 - một khóm hoa dại).',
    'HSK 6',
    16,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在悬崖峭壁的岩石缝隙里，顽强地生长着一丛傲雪凌霜的野菊花。',
      'Zài xuányáqiàobì de yánshí fèngxì lǐ, wánqiáng de shēngzhǎngzhe yì cóng àoxuělíngshuāng de yějúhuā.',
      'Nơi khe nứt của vách đá cheo leo, kiên cường sinh trưởng một khóm cúc dại ngạo nghễ đạp tuyết khinh sương.',
      '"一丛...野菊花" dùng "丛" định lượng cho cụm hoa cúc dại vươn mình giữa đá núi hiểm trở.'
    ),
    (
      v_gp_id,
      '院子角落里种着一丛翠绿挺拔的修竹，为整个庭院平添了几分幽雅静谧。',
      'Yuànzi jiǎoluò lǐ zhòngzhe yì cóng cuìlǜ tǐngbá de xiūzhú, wèi zhěng gè tíngyuàn píngtiān le jǐ fēn yōuyǎ jìngmì.',
      'Ở góc sân có trồng một bụi trúc xanh biếc thẳng tắp, điểm xuyết thêm cho cả khu vườn vài phần thanh nhã tĩnh mịch.',
      '"一丛翠绿挺拔的修竹" miêu tả bụi tre trúc cảnh trang trí sân vườn phương Đông.'
    );

  -- Điểm ngữ pháp #17: Danh lượng từ chỉ nhúm nhỏ, nắm tay hoặc nhóm cực nhỏ "撮" (Nhúm / Dúm / Nhóm nhỏ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ nhúm nhỏ, nắm tay hoặc nhóm cực nhỏ "撮" (Nhúm / Dúm / Nhóm nhỏ)',
    '一 + 撮 + Danh từ (土 / 盐 / 头发) / 一小撮 + Đối tượng tiêu cực (阴谋分子 / 暴徒)',
    'Lượng từ',
    '"撮" (cuō) có hai cách dùng: 1) Lượng từ chỉ lượng rất ít có thể dùng các đầu ngón tay nhón lấy (như 一撮盐 - một nhúm muối, 一撮土 - một nắm đất); 2) Dùng trong chính trị chỉ một nhóm cực nhỏ những phần tử xấu, manh động bị xã hội cô lập (như 一小撮坏人, 一小撮分裂分子).',
    'HSK 6',
    17,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '考古队员小心翼翼地用刷子扫起一撮古墓地层深处的灰烬样本进行年代测定。',
      'Kǎogǔ duìyuán xiǎoxīnyìyì de yòng shuāzi sǎoqǐ yì cuō gǔmù dìcéng shēnchù de huījìn yàngběn jìnxíng niándài cèdìng.',
      'Cán bộ khảo cổ cẩn thận dùng cọ quét lấy một nhúm mẫu tro tàn nơi tầng sâu ngôi mộ cổ để tiến hành đo niên đại.',
      '"一撮...灰烬样本" dùng "撮" định lượng cho lượng mẫu tro cực nhỏ phục vụ xét nghiệm khoa học.'
    ),
    (
      v_gp_id,
      '那一小撮企图破坏边疆民族团结与社会繁荣的极端分子，终将受到法律的威严制裁。',
      'Nà yì xiǎocuō qǐtú pòhuài biānjiāng mínzú tuánjié yǔ shèhuì fánróng de jíduān fènzǐ, zhōng jiāng shòudào fǎlǜ de wēiyán zhìcái.',
      'Một nhóm nhỏ những phần tử cực đoan mưu toan phá hoại đoàn kết dân tộc và sự phồn vinh xã hội nơi biên ải, cuối cùng sẽ phải chịu sự trừng phạt uy nghiêm của pháp luật.',
      '"一小撮...极端分子" là thuật ngữ chính luận lột tả sự cô lập thiểu số của phần tử phá hoại.'
    );

  -- Điểm ngữ pháp #18: Phó từ văn ngôn chỉ sự tiếp diễn chưa dứt "尚" (Còn / Hãy còn / Vẫn / Chưa)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ văn ngôn chỉ sự tiếp diễn chưa dứt "尚" (Còn / Hãy còn / Vẫn / Chưa)',
    '尚 + Động từ/Tính từ (尚可 / 尚无定论 / 尚未可知 / 尚待研究 / 尚有)',
    'Phó từ',
    '"尚" (shàng) là phó từ văn ngôn tương đương với "还" (vẫn còn), nhưng mang phong cách trang trọng hàn lâm. Thường kết hợp trong các thành ngữ bốn chữ biểu thị sự việc đang trong quá trình tiếp diễn chưa ngã ngũ: 尚未 (chưa từng), 尚待 (còn chờ xem xét), 尚未可知 (vẫn chưa thể biết trước), 尚有欠缺 (vẫn còn khiếm khuyết).',
    'HSK 6',
    18,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '该项假说在国际学术界尚存激烈争议，其客观真实性目前尚未得到最终确证。',
      'Gāi xiàng jiǎshuō zài guójì xuéshùjiè shàng cún jīliè zhēngyì, qí kèguān zhēnshíxìng mùqián shàngwèi dédào zuìzhōng quèzhèng.',
      'Giả thuyết này trong giới học thuật quốc tế vẫn còn tồn tại tranh cãi gay gắt, tính chân thực khách quan của nó hiện tại vẫn chưa nhận được sự xác chứng cuối cùng.',
      '"尚存争议" và "尚未得到确证" thể hiện thái độ thận trọng khoa học đối với vấn đề chưa được chứng minh.'
    ),
    (
      v_gp_id,
      '经过紧急抢修，目前通信主干线尚可维持基本通话，全面修复尚需两到三天。',
      'Jīngguò jǐnjí qiǎngxiū, mùqián tōngxìn zhǔgànxiàn shàngkě wéichí jīběn tōnghuà, quánmiàn xiūfù shàng xū liǎng dào sān tiān.',
      'Sau khi cấp tốc sửa chữa khẩn cấp, hiện tại tuyến trục thông tin hãy còn có thể duy trì đàm thoại cơ bản, việc khôi phục toàn diện vẫn cần từ hai tới ba ngày.',
      '"尚可维持" và "尚需..." thông báo tiến độ khắc phục sự cố thông tin liên lạc.'
    );

  -- Điểm ngữ pháp #19: Cấu trúc liên từ tăng tiến nhượng bộ cực hạn "尚且...何况/况且..." (Ngay cả... huống chi...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc liên từ tăng tiến nhượng bộ cực hạn "尚且...何况/况且..." (Ngay cả... huống chi...)',
    'Trường hợp thông thường/mạnh 尚且 + Như thế nào, 何况 / 况且 + Trường hợp yếu/đặc biệt',
    'Liên từ',
    '"尚且...何况..." (shàngqiě... hékuàng...) là mẫu câu tăng tiến lập luận tu từ đỉnh cao: vế trước đưa ra đối tượng mạnh mẽ, điều kiện thuận lợi hoặc mức chuẩn tối thiểu mà "ngay cả đối tượng đó còn không làm nổi / còn gặp khó khăn", vế sau dùng "何况" để khẳng định đối tượng yếu kém hơn chắc chắn càng không thể.',
    'HSK 6',
    19,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经验老到的资深探险家在此恶劣环境下尚且步步惊心，何况毫无野外生存经验的普通游客呢？',
      'Jīngyàn lǎodào de zīshēn tànxiǎnjiā zài cǐ èliè huánjìng xià shàngqiě bùbùjīngxīn, hékuàng háowú yěwài shēngcún jīngyàn de pǔtōng yóukè ne?',
      'Những nhà thám hiểm kỳ cựu dày dạn kinh nghiệm dưới môi trường khắc nghiệt này ngay cả họ còn từng bước thót tim, huống chi là du khách thông thường hoàn toàn không có kinh nghiệm sinh tồn nơi hoang dã chứ?',
      '"尚且...何况...呢" dùng thử thách của chuyên gia để cảnh báo nguy cơ tử thần đối với người nghiệp dư.'
    ),
    (
      v_gp_id,
      '身居高位的古代君王尚且虚心求教于田野贤士，我们作为普通人又怎能骄傲自满呢？',
      'Shēnjū gāowèi de gǔdài jūnwáng shàngqiě xūxīn qiújiào yú tiányě xiánshì, wǒmen zuòwéi pǔtōngrén yòu zěn néng jiāo''àozìmǎn ne?',
      'Những vị quân vương cổ đại ở ngôi vị tối cao ngay cả họ còn khiêm tốn thỉnh giáo các bậc hiền tài nơi đồng nội, chúng ta với tư cách là người bình thường sao có thể kiêu ngạo tự mãn chứ?',
      '"君王尚且...怎能..." lấy tấm gương của bậc đế vương răn dạy đức tính khiêm tốn cầu thị.'
    );

  -- Điểm ngữ pháp #20: Phó từ thời gian văn ngôn khởi đầu "甫" (Vừa mới / Thoạt vừa mới)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời gian văn ngôn khởi đầu "甫" (Vừa mới / Thoạt vừa mới)',
    '甫 + Động từ (甫一上市 / 甫一亮相 / 甫一出场 / 惊魂甫定)',
    'Phó từ',
    '"甫" (fǔ) là phó từ thời gian văn ngôn cổ xưa tương đương với "刚刚" (vừa mới), chuyên dùng miêu tả thời điểm một sự vật hoặc nhân vật vừa mới xuất hiện thì lập tức gây chấn động hoặc tạo nên phản ứng tức thì (như 甫一上市 - vừa mới tung ra thị trường, 惊魂甫定 - hồn phách vừa mới định thần lại).',
    'HSK 6',
    20,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '该款自主研发的折叠屏旗舰手机甫一亮相，便在全球科技展会上引起了极大的轰动。',
      'Gāi kuǎn zìzhǔ yánfā de zhédiépíng qíjiàn shǒujī fǔyí liàngxiàng, biàn zài quánqiú kējì zhǎnhuì shang yǐnqǐ le jídà de hōngdòng.',
      'Chiếc điện thoại đầu bảng màn hình gập tự chủ nghiên cứu phát triển này thoạt vừa mới ra mắt đã lập tức gây chấn động cực lớn tại triển lãm công nghệ toàn cầu.',
      '"甫一亮相，便引起轰动" là cách viết thời sự kinh điển miêu tả sức hút mãnh liệt tức thì của sản phẩm mới.'
    ),
    (
      v_gp_id,
      '大巴车司机在惊魂甫定之后，迅速组织全体乘客有序撤离到高速公路护栏外。',
      'Dàbāchē sījī zài jīnghúnfǔdìng zhīhòu, xùnsù zǔzhī quántǐ chéngkè yǒuxù chèlí dào gāosù gōnglù hùlán wài.',
      'Tài xế xe buýt sau khi vừa mới hoàn hồn định thần lại sau cơn hoảng loạn, đã nhanh chóng tổ chức toàn thể hành khách sơ tán có trật tự ra ngoài dải phân cách đường cao tốc.',
      '"惊魂甫定" là thành ngữ miêu tả tâm trạng vừa kịp trấn tĩnh lại sau cú sốc tai nạn giao thông.'
    );

  -- Điểm ngữ pháp #21: Phó từ hoàn thành pháp lý lịch sử "业已" (Đã / Đã từng hoàn tất)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ hoàn thành pháp lý lịch sử "业已" (Đã / Đã từng hoàn tất)',
    'Chủ ngữ + 业已 + Động từ song âm tiết (完成 / 生效 / 查明 / 达成 / 告竣)',
    'Phó từ',
    '"业已" (yèyǐ) là phó từ ngoại giao và pháp lý cao cấp tương đương với "已经", biểu thị một hiệp ước, công trình hoặc quy trình điều tra đã được hoàn thành triệt để trong quá khứ và hiện đang phát sinh hiệu lực đầy đủ (như 业已生效 - đã chính thức có hiệu lực, 业已查明 - đã điều tra làm rõ).',
    'HSK 6',
    21,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '两国议会正式批准的双边投资保护协定业已于今日凌晨起全面生效。',
      'Liǎng guó yìhuì zhèngshì pīzhǔn de shuāngbiān tóuzī bǎohù xiéyì yèyǐ yú jīnrì língchén qǐ quánmiàn shēngxiào.',
      'Hiệp định bảo hộ đầu tư song phương do nghị viện hai nước chính thức phê chuẩn đã chính thức phát sinh hiệu lực toàn diện kể từ rạng sáng hôm nay.',
      '"业已...全面生效" là thuật ngữ công pháp ngoại giao tuyên bố mốc hiệu lực của điều ước quốc tế.'
    ),
    (
      v_gp_id,
      '经过跨部门专案组的不懈努力，事故发生的直接诱因及责任链条业已彻底查明。',
      'Jīngguò kuà bùmén zhuān''ànzǔ de búxiè nǔlì, shìgù fāshēng de zhíjiē yòuyīn jí zérèn liàntiáo yèyǐ chèdǐ chámíng.',
      'Qua sự nỗ lực không ngừng nghỉ của ban chuyên án liên ngành, nguyên nhân trực tiếp châm ngòi và chuỗi trách nhiệm của vụ tai nạn đã được điều tra làm rõ triệt để.',
      '"业已彻底查明" khẳng định kết quả điều tra đã ngã ngũ rõ ràng không còn uẩn khúc.'
    );

  -- Điểm ngữ pháp #22: Phó từ cấp bách không thể trì hoãn "亟待" (Cực kỳ cấp thiết cần phải / Cần kíp)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ cấp bách không thể trì hoãn "亟待" (Cực kỳ cấp thiết cần phải / Cần kíp)',
    'Vấn đề nhức nhối / Tồn đọng + 亟待 + Động từ song âm tiết (解决 / 完善 / 澄清 / 规范 / 拯救)',
    'Phó từ',
    '"亟待" (jídài) kết hợp chữ "亟" (jí - khẩn cấp, gấp gáp) và "待" (dài - chờ đợi, cần phải), mang nghĩa "vô cùng khẩn thiết, cấp bách đòi hỏi phải hành động ngay lập tức không thể chậm trễ thêm một giây phút nào" (cực kỳ cấp bách cần giải quyết). Thường dùng trong các thông điệp cảnh báo xã hội.',
    'HSK 6',
    22,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '传统手工造纸技艺面临着后继无人的濒危严峻困境，这一非遗项目亟待抢救性保护。',
      'Chuántǒng shǒugōng zàozhǐ jìyì miànlínzhe hòujìwúrén de bīnwēi yánjùn kùnjìng, zhè yì fēiyí xiàngmù jídài qiǎngjiùxìng bǎohù.',
      'Nghề làm giấy thủ công truyền thống đang đối mặt với nghịch cảnh ngặt nghèo không người kế nghiệp, dự án di sản phi vật thể này đang hết sức cấp bách cần được bảo vệ khẩn cấp mang tính giải cứu.',
      '"亟待抢救性保护" phát đi thông điệp cấp bách bảo tồn nghề cổ truyền trước nguy cơ thất truyền.'
    ),
    (
      v_gp_id,
      '网络未成年人打赏巨额资金的社会乱象屡禁不绝，相关监管法律漏洞亟待立法完善。',
      'Wǎngluò wèichéngniánrén dǎshǎng jù''é zījīn de shèhuì luànxiàng lǚjìnbùjué, xiāngguān jiānguǎn fǎlǜ lòudòng jídài lìfǎ wánshàn.',
      'Vấn nạn xã hội trẻ vị thành niên nạp thưởng số tiền khổng lồ trên mạng cấm mãi không dứt, các lỗ hổng luật pháp giám sát liên quan hết sức cấp bách cần được hoàn thiện bằng công tác lập pháp.',
      '"亟待立法完善" chỉ ra yêu cầu khẩn cấp của việc hoàn thiện thể chế pháp lý.'
    );

  -- Điểm ngữ pháp #23: Phó từ biến đổi dốc đứng đột ngột "陡然" (Đột ngột / Đùng một cái / Dốc đứng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ biến đổi dốc đứng đột ngột "陡然" (Đột ngột / Đùng một cái / Dốc đứng)',
    'Chủ ngữ + 陡然 + Động từ/Tính từ biến đổi (增加 / 下降 / 紧张 / 升温 / 变色)',
    'Phó từ',
    '"陡然" (dǒurán) có gốc từ chữ "陡" (dốc đứng, hiểm trở). Biểu thị số liệu, nhiệt độ, áp lực hoặc bầu không khí biến đổi đột ngột như một vách đá dựng đứng, khiến mọi người không kịp trở tay (đột ngột thay đổi chóng mặt).',
    'HSK 6',
    23,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '突如其来的国际金融动荡，让这家外贸企业的资金链压力陡然剧增。',
      'Tūrúqílái de guójì jīnróng dòngdàng, ràng zhè jiā wàimào qǐyè de zījīnliàn yālì dǒurán jùzēng.',
      'Biến động tài chính quốc tế bất ngờ ập đến đã khiến áp lực dòng tiền của doanh nghiệp ngoại thương này đột ngột tăng vọt lên chóng mặt.',
      '"压力陡然剧增" miêu tả mức độ căng thẳng tài chính tăng vọt dữ dội ngoài tầm kiểm soát.'
    ),
    (
      v_gp_id,
      '原本平静和谐的谈判会场，因对方突然提出苛刻要求而使气氛陡然紧张了起来。',
      'Yuánběn píngjìng héxié de tánpàn huìchǎng, yīn duìfāng tūrán tíchū kēkè yāoqiú ér shǐ qìfēn dǒurán jǐnzhāng le qǐlái.',
      'Hội trường đàm phán vốn dĩ đang yên ắng hòa hợp bỗng vì đối phương đột ngột đưa ra yêu sách hà khắc mà khiến bầu không khí bỗng chốc căng thẳng tột độ.',
      '"气氛陡然紧张" diễn tả sự chuyển biến tâm lý đối đầu kịch tính trong đàm phán ngoại giao.'
    );

  -- Điểm ngữ pháp #24: Phó từ thời tiết và âm thanh bùng phát đột ngột "骤然" (Đột nhiên bùng phát / Bất thình lình)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời tiết và âm thanh bùng phát đột ngột "骤然" (Đột nhiên bùng phát / Bất thình lình)',
    'Chủ ngữ + 骤然 + Động từ/Tính từ (降温 / 响起了 / 停止 / 狂风大作 / 亮起)',
    'Phó từ',
    '"骤然" (zhòurán) kết hợp chữ "骤" (chạy nước đại, đột ngột), biểu thị một hiện tượng thiên nhiên (gió bão, nhiệt độ) hoặc âm thanh, ánh sáng bộc phát nhanh và mạnh mẽ như một cơn lốc bất ngờ (đột ngột, bất thình lình bùng lên).',
    'HSK 6',
    24,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '受北方强冷空气南下袭击影响，该地区的气温在短短半天内骤然下降了十五摄氏度。',
      'Shòu běifāng qiáng lěngkōngqì nánxià xíjī yǐngxiǎng, gāi dìqū de qìwēn zài duǎnduǎn bàn tiān nèi zhòurán xiàjiàng le shíwǔ shèshìdù.',
      'Chịu ảnh hưởng bởi đợt không khí lạnh mạnh từ phương Bắc tràn xuống tấn công, nhiệt độ của khu vực này chỉ trong vòng nửa ngày ngắn ngủi đã đột ngột giảm mạnh 15 độ C.',
      '"气温...骤然下降" miêu tả hiện tượng rét đậm ập đến cực nhanh theo quy luật thời tiết cực đoan.'
    ),
    (
      v_gp_id,
      '寂静无声的深夜里，走廊深处骤然响起了一阵急促而惊慌的敲门声。',
      'Jìjìngwúshēng de shēnyè lǐ, zǒuláng shēnchù zhòurán xiǎngqǐ le yí zhèn jícù ér jīnghuāng de qiāomén shēng.',
      'Nơi đêm khuya thanh vắng tĩnh mịch không một tiếng động, sâu trong hành lang bỗng nhiên bất thình lình vang lên một hồi tiếng gõ cửa dồn dập đầy hoảng sợ.',
      '"骤然响起敲门声" tạo bầu không khí kịch tính, hồi hộp trong văn phong tiểu thuyết trinh thám.'
    );

  -- Điểm ngữ pháp #25: Thành ngữ ngữ pháp hóa chỉ sự bí mật êm ả "悄无声息" (Lặng lẽ không một tiếng động)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Thành ngữ ngữ pháp hóa chỉ sự bí mật êm ả "悄无声息" (Lặng lẽ không một tiếng động)',
    'Chủ ngữ + 悄无声息地 + Động từ (蔓延 / 潜入 / 发生 / 改变 / 离去)',
    'Phó từ',
    '"悄无声息" (qiǎowúshēngxī) mang ý nghĩa tuyệt đối yên ắng, không phát ra một chút âm thanh hay tiếng động nhỏ nào, làm cho người khác hoàn toàn không hay biết (lặng lẽ không một tiếng động, âm thầm không ai hay). Thường dùng làm trạng ngữ miêu tả sự xâm nhập bí mật hoặc dòng chảy thời gian trôi đi.',
    'HSK 6',
    25,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '一场以人工智能大模型为标志的全新工业革命，正在各行各业悄无声息地全面蔓延。',
      'Yì chǎng yǐ réngōng zhìnéng dà móxíng wéi biāozhì de quánxīn gōngyè gémìng, zhèngzài gèhánggèyè qiǎowúshēngxī de quánmiàn mànyán.',
      'Một cuộc cách mạng công nghiệp hoàn toàn mới lấy mô hình trí tuệ nhân tạo lớn làm dấu mốc đang âm thầm lan tỏa không một tiếng động trong mọi ngành nghề.',
      '"悄无声息地蔓延" ẩn dụ cho sự thâm nhập tất yếu, sâu sắc của công nghệ vào nền kinh tế số.'
    ),
    (
      v_gp_id,
      '特警队员在夜幕的掩护下，悄无声息地包围了犯罪团伙藏匿的废弃仓库。',
      'Tèjǐng duìyuán zài yèmù de yǎnhù xià, qiǎowúshēngxī de bāowéi le fànzuì tuánhuǒ cángnì de fèiqì cāngkù.',
      'Dưới sự che chở của màn đêm, các chiến sĩ cảnh sát đặc nhiệm đã bí mật lặng lẽ khép chặt vòng vây kho hàng bỏ hoang nơi băng nhóm tội phạm ẩn náu.',
      '"悄无声息地包围" miêu tả chiến thuật đột kích tuyệt mật chuyên nghiệp của lực lượng đặc nhiệm.'
    );

  -- Điểm ngữ pháp #26: Động từ/Phó từ duyên kỳ ngộ đúng dịp may mắn "适逢" (Đúng dịp / Vừa khéo gặp / Trùng phùng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ/Phó từ duyên kỳ ngộ đúng dịp may mắn "适逢" (Đúng dịp / Vừa khéo gặp / Trùng phùng)',
    '适逢 + Dịp đại lễ/Sự kiện trọng đại / 适逢其会',
    'Phó từ',
    '"适逢" (shìféng) kết hợp chữ "适" (vừa vặn, đúng lúc) và "逢" (gặp gỡ), mang nghĩa "vừa vặn trùng hợp đúng vào thời điểm hoặc dịp lễ hội, sự kiện tốt đẹp" (đúng vào dịp, may mắn trùng phùng). Thành ngữ "适逢其会" chỉ việc vừa khéo có mặt đúng vào thời điểm thuận lợi nhất.',
    'HSK 6',
    26,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '代表团这次访问适逢该国建国七十周年盛大庆典，因此受到了东道国最高规格的礼遇。',
      'Dàibiǎotuán zhè cì fǎngwèn shìféng gāi guó jiànguó qīshí zhōunián shèngdà qìngdiǎn, yīncǐ shòudào le dōngdàoguó zuì gāo guīgé de lǐyù.',
      'Chuyến thăm lần này của đoàn đại biểu đúng vào dịp đại lễ kỷ niệm 70 năm lập quốc của đất nước này, do đó đã nhận được sự đón tiếp theo quy chuẩn lễ nghi cao nhất của nước chủ nhà.',
      '"适逢...盛大庆典" liên kết sự trùng hợp tốt đẹp về thời điểm lịch sử với quy cách đón tiếp trang trọng.'
    ),
    (
      v_gp_id,
      '青年一代生逢其时、适逢其会，必将在这个伟大的时代大有作为。',
      'Qīngnián yídài shēngféngqíshí, shìféngqíhuì, bìjiāng zài zhè ge wěidà de shídài dàyǒuzuòwéi.',
      'Thế hệ trẻ sinh ra đúng thời, gặp đúng thời cơ lịch sử, nhất định sẽ làm nên những sự nghiệp vĩ đại trong thời đại huy hoàng này.',
      '"生逢其时、适逢其会" là cặp thành ngữ truyền cảm hứng cổ vũ thanh niên nắm bắt vận hội non sông.'
    );

  -- Điểm ngữ pháp #27: Phó từ thời gian nối tiếp thần tốc "旋即" (Liền ngay sau đó / Nhanh chóng tiếp nối)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời gian nối tiếp thần tốc "旋即" (Liền ngay sau đó / Nhanh chóng tiếp nối)',
    'Hành động 1 bộc phát, 旋即 + Hành động 2 / Kết quả phản hồi tức thì',
    'Phó từ',
    '"旋即" (xuánjí) là phó từ văn ngôn cổ nhã tương đương với "随即" hoặc "转身立刻", biểu thị một sự biến đổi hoặc phản ứng diễn ra cực nhanh, chớp nhoáng nối liền ngay sau sự việc thứ nhất (ngay sau đó, thoắt cái liền). Mang sắc thái văn phong bác học.',
    'HSK 6',
    27,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '爆炸发生后，附近驻军部队闻令而动，旋即奔赴现场展开了紧急的抢险救援。',
      'Bàozhà fāshēng hòu, fùjìn zhùjūn bùduì wénlìng''érdòng, xuánjí bēnfù xiànchǎng zhǎnkāi le jǐnjí de qiǎngxiǎn jiùyuán.',
      'Sau khi vụ nổ xảy ra, lực lượng quân đội đóng quân gần đó nghe lệnh lập tức hành động, ngay tắp lự đã lao tới hiện trường triển khai công tác cứu hộ khẩn cấp.',
      '"旋即奔赴现场" đặc tả tốc độ phản ứng điều binh thần tốc của quân đội trước thảm họa.'
    ),
    (
      v_gp_id,
      '公司发布的辟谣声明言之凿凿，旋即平息了网络上持续数日的恶意造谣风波。',
      'Gōngsī fābù de pìyáo shēngmíng yánzhīzàozào, xuánjí píngxī le wǎngluò shang chíxù shù rì de èyì zàoyáo fēngbō.',
      'Thông cáo đính chính bác bỏ tin đồn của công ty đưa ra đầy đủ bằng chứng xác thực, ngay lập tức đã dập tắt cơn sóng gió bịa đặt ác ý kéo dài suốt nhiều ngày trên mạng.',
      '"旋即平息了...风波" nhấn mạnh hiệu quả trấn an dư luận tức thời của thông điệp minh bạch.'
    );

  -- Điểm ngữ pháp #28: Liên từ lựa chọn văn ngôn cổ kính "抑或" (Hoặc là / Hay là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ lựa chọn văn ngôn cổ kính "抑或" (Hoặc là / Hay là)',
    'Lựa chọn A, 抑或 + Lựa chọn B (mang tính triết lý, suy tư sâu xa)',
    'Liên từ',
    '"抑或" (yìhuò) là liên từ lựa chọn bắt nguồn từ Hán ngữ cổ đại tương đương với "还是" hoặc "或者是", nhưng mang đậm phong vị suy tư triết học, chất vấn lịch sử hoặc phong cách tùy bút văn học thâm trầm (hay là, hoặc giả là).',
    'HSK 6',
    28,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '人类探索浩瀚太空的终极驱动力，究竟是源于对未知世界的好奇，抑或是为了寻求文明未来的生存空间？',
      'Rénlèi tànsuǒ hàohàn tàikōng de zhōngjí qūdònglì, jiūjìng shì yuányú duì wèizhī shìjiè de hàoqí, yìhuò shì wèile xúnqiú wénmíng wèilái de shēngcún kōngjiān?',
      'Động lực tối thượng thúc đẩy nhân loại khám phá vũ trụ bao la, rốt cuộc là bắt nguồn từ trí tò mò đối với thế giới chưa biết, hay là nhằm tìm kiếm không gian sinh tồn tương lai cho nền văn minh?',
      '"究竟是...抑或是..." đặt ra câu hỏi triết học sâu xa về sứ mệnh chinh phục vũ trụ của nhân loại.'
    ),
    (
      v_gp_id,
      '这场长达百年的历史论战，究竟是一场学术立场的交锋，抑或是一场意识形态的较量？',
      'Zhè chǎng chángdá bǎinián de lìshǐ lùnzhàn, jiūjìng shì yì chǎng xuéshù lìchǎng de jiāofēng, yìhuò shì yì chǎng yìshíxíngtài de jiàoliàng?',
      'Cuộc luận chiến lịch sử kéo dài suốt trăm năm này, rốt cuộc là một cuộc so găng về lập trường học thuật, hay là một cuộc đọ sức về hình thái ý thức?',
      '"抑或" đưa ra hai giả thuyết sâu sắc để mổ xẻ bản chất của cuộc tranh biện lịch sử.'
    );

  -- Điểm ngữ pháp #29: Phó từ phỏng đoán tu từ hoài nghi "莫非" (Lẽ nào / Chẳng lẽ / Hay là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phỏng đoán tu từ hoài nghi "莫非" (Lẽ nào / Chẳng lẽ / Hay là)',
    '莫非 + Phỏng đoán nghi hoặc + (不成 / 吗 / 呢)？',
    'Phó từ',
    '"莫非" (mòfēi) dùng trong câu hỏi phỏng đoán để biểu thị sự nghi hoặc, ngạc nhiên trước một tình huống bất thường (lẽ nào, chẳng lẽ). Cuối câu thường kết hợp với quán dụng ngữ "不成" tạo thành cấu trúc tu từ "莫非...不成？" (chẳng lẽ... hay sao?).',
    'HSK 6',
    29,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '大门紧锁且屋内一片漆黑，莫非他们全家都去外地度假了不成？',
      'Dàmén jǐnsuǒ qiě wūnèi yí piàn qīhēi, mòfēi tāmen quán jiā dōu qù wàidì dùjià le bùchéng?',
      'Cửa chính khóa chặt và trong nhà tối om không một bóng đèn, chẳng lẽ cả nhà họ đều đã đi nơi khác nghỉ dưỡng rồi hay sao?',
      '"莫非...不成？" đưa ra phán đoán phỏng đoán trước hiện trường ngôi nhà vắng vẻ.'
    ),
    (
      v_gp_id,
      '平时最守时的人今天居然迟到了一个小时，莫非路上遇到了什么突发险情？',
      'Píngshí zuì shǒushí de rén jīntiān jūrán chídào le yí gè xiǎoshí, mòfēi lùshang yùdào le shénme tūfā xiǎnqíng?',
      'Người bình thường đúng giờ nhất hôm nay không ngờ lại đến muộn một tiếng đồng hồ, lẽ nào trên đường đã gặp phải tình huống nguy hiểm bất trắc gì rồi sao?',
      '"莫非..." biểu thị sự lo lắng cho an nguy của người bạn khi xuất hiện sự bất thường.'
    );

  -- Điểm ngữ pháp #30: Phó từ phủ định kép khẳng định tính phổ quát "莫不" (Không ai là không / Không gì là không)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phủ định kép khẳng định tính phổ quát "莫不" (Không ai là không / Không gì là không)',
    'Mọi người / Mọi sự vật + 莫不 + Động từ/Tính từ (称赞 / 感慨 / 欣喜 / 为之动容)',
    'Phó từ',
    '"莫不" (mòbù) là phó từ văn ngôn kết hợp chữ 莫 (không ai, không có gì) và 不 (không), tạo thành phủ định kép khẳng định 100% tính phổ quát tuyệt đối của hiện tượng (không ai là không như vậy, ai nấy đều, không gì là không). Mang sắc thái ngợi ca hoặc thán phục trang nghiêm.',
    'HSK 6',
    30,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '凡是亲眼目睹过这位老红军英雄事迹报告的听众，无不热泪盈眶，莫不为之深深动容。',
      'Fánshì qīnyǎn mùdǔguo zhè wèi lǎohóngjūn yīngxióng shìjì bàogào de tīngzhòng, wúbù rèlèiyíngkuàng, mòbù wéizhī shēnshēn dòngróng.',
      'Phàm là người nghe từng tận mắt chứng kiến báo cáo thành tích anh hùng của người chiến sĩ Hồng quân già này, không ai là không ngấn lệ, không một ai là không vì thế mà xúc động sâu sắc.',
      '"莫不为之动容" cực tả sức lay động lòng người mãnh liệt của câu chuyện anh hùng cách mạng.'
    ),
    (
      v_gp_id,
      '历代登临泰山玉皇顶极目远眺的文人骚客，莫不被其雄浑壮阔的巍峨气象所震撼。',
      'Lìdài dēnglín Tàishān Yùhuángdǐng jímù yuǎntiào de wénrénsāokè, mòbù bèi qí xiónghún zhuàngkuò de wēi''é qìxiàng suǒ zhènhàn.',
      'Các bậc văn nhân thi khách qua các thời đại khi bước lên đỉnh Ngọc Hoàng của núi Thái Sơn phóng tầm mắt nhìn xa, không một ai là không bị khí tượng nguy nga hùng vĩ tráng lệ của nó làm cho chấn động.',
      '"莫不被...所震撼" dùng phủ định kép văn ngôn khẳng định sự sùng kính của tiền nhân trước ngọn núi thiêng.'
    );

  -- Điểm ngữ pháp #31: Phó từ văn ngôn phủ định không cần thiết "毋庸" (Không cần / Khỏi phải / Không cần bàn cãi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ văn ngôn phủ định không cần thiết "毋庸" (Không cần / Khỏi phải / Không cần bàn cãi)',
    '毋庸 + Động từ song âm tiết (置疑 / 讳言 / 多言 / 细述 / 赘述)',
    'Phó từ',
    '"毋庸" (wúyōng) kết hợp chữ "毋" (không) và "庸" (cần), mang nghĩa "hoàn toàn không cần thiết phải làm, không cần phải nói thêm" (khỏi phải, không cần). Tạo thành các thành ngữ học thuật bất hủ trong HSK 6: "毋庸置疑" (không còn nghi ngờ gì nữa), "毋庸讳言" (thẳng thắn không cần giấu giếm, nói thẳng thắn), "毋庸赘述" (không cần nói rườm rà thêm).',
    'HSK 6',
    31,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '创新对于现代高科技产业生存发展的决定性引领作用，是毋庸置疑的。',
      'Chuàngxīn duìyú xiàndài gāo kējì chǎnyè shēngcún fāzhǎn de juédìngxìng yǐnlǐng zuòyòng, shì wúyōngzhìyí de.',
      'Tác dụng dẫn dắt mang tính quyết định của đổi mới sáng tạo đối với sự sinh tồn phát triển của ngành công nghệ cao hiện đại là điều khỏi cần nghi ngờ.',
      '"是毋庸置疑的" khẳng định tính chân lý không thể lay chuyển của yếu tố đổi mới công nghệ.'
    ),
    (
      v_gp_id,
      '毋庸讳言，我们在前期的市场调研中确实存在着一定的盲目乐观与经验主义倾向。',
      'Wúyōnghuìyán, wǒmen zài qiánqī de shìchǎng diàoyán zhōng quèshí cúnzài zhe yídìng de mángmù lèguān yǔ jīngyànzhǔyì qīngxiàng.',
      'Thẳng thắn không cần giấu giếm, chúng tôi trong khâu khảo sát thị trường giai đoạn ban đầu quả thực có tồn tại khuynh hướng lạc quan mù quáng và chủ nghĩa kinh nghiệm nhất định.',
      '"毋庸讳言" thể hiện tinh thần dũng cảm nhìn thẳng vào khuyết điểm và tự phê bình nghiêm túc.'
    );

  -- Điểm ngữ pháp #32: Phó từ văn ngôn phủ định nhu cầu "毋须 / 无须" (Không cần thiết / Chẳng cần phải)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ văn ngôn phủ định nhu cầu "毋须 / 无须" (Không cần thiết / Chẳng cần phải)',
    'Chủ ngữ + 毋须 / 无须 + Động từ (多言 / 担忧 / 介意 / 恐慌)',
    'Phó từ',
    '"毋须" và "无须" (wúxū) là các phó từ văn ngôn tương đương với "不需要" hoặc "不必", mang sắc thái trang nhã, điềm đạm và dứt khoát (không cần thiết phải làm, chẳng cần bận tâm). Thường dùng trong các thông cáo ngoại giao hoặc lời khuyên nhủ học thuật.',
    'HSK 6',
    32,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '事实真相早已大白于天下，公道自在人心，我们毋须再作多余的无谓辩解。',
      'Shìshí zhēnxiàng zǎoyǐ dàbái yú tiānxià, gōngdào zì zài rénxīn, wǒmen wúxū zài zuò duōyú de wúwèi biànjiě.',
      'Sự thật chân tướng từ lâu đã sáng tỏ dưới thanh thiên bạch nhật, lẽ công bằng tự ở trong lòng người, chúng ta không cần thiết phải giải thích vô ích thêm thừa thãi nữa.',
      '"毋须再作多余的辩解" thể hiện phong thái tự tin vững vàng khi sự thật đã rõ ràng mười mươi.'
    ),
    (
      v_gp_id,
      '两国在此领域的合作完全符合国际法规范，外界对此无须产生任何不必要的过度猜忌。',
      'Liǎng guó zài cǐ lǐngyù de hézuò wánquán fúhé guójìfǎ guīfàn, wàijiè duì cǐ wúxū chǎnshēng rènhé bú bìyào de guòdù cāijì.',
      'Sự hợp tác giữa hai nước trong lĩnh vực này hoàn toàn phù hợp với quy phạm luật pháp quốc tế, bên ngoài đối với điều này chẳng cần nảy sinh bất kỳ sự nghi kỵ thái quá không cần thiết nào.',
      '"无须产生...猜忌" là phát ngôn ngoại giao chính thức trấn an các đồn đoán thất thiệt.'
    );

  -- Điểm ngữ pháp #33: Phó từ văn ngôn chỉ mức độ ngạc nhiên và thảng thốt "殊" (Rất / Thật là / Đâu ngờ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ văn ngôn chỉ mức độ ngạc nhiên và thảng thốt "殊" (Rất / Thật là / Đâu ngờ)',
    '殊 + Tính từ (殊为不易 / 殊不知 / 殊途同归)',
    'Phó từ',
    '"殊" (shū) là phó từ văn ngôn mang hai nghĩa chính trong HSK 6: 1) Tương đương với "很, 极" (rất, thật là), như 殊为不易 (thực sự hết sức khó khăn không dễ chút nào); 2) Biểu thị sự bất ngờ hoàn toàn nằm ngoài dự liệu, tương đương với "哪里知道" (nào ngờ đâu, đâu biết rằng), như thành ngữ ngữ pháp hóa "殊不知".',
    'HSK 6',
    33,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在完全缺乏现成技术资料的前提下攻克这项世界级难关，其探索过程殊为不易。',
      'Zài wánquán quēfá xiànchéng jìshù zīliào de qiántí xià gōngkè zhè xiàng shìjièjí nánguān, qí tànsuǒ guòchéng shū wéi bùyì.',
      'Dưới tiền đề hoàn toàn thiếu thốn tài liệu kỹ thuật có sẵn mà chinh phục được ải khó cấp thế giới này, quá trình tìm tòi của nó thực sự vô cùng không dễ dàng chút nào.',
      '"殊为不易" dùng "殊" làm phó từ mức độ văn ngôn trang trọng cực tả sự gian truân của nhóm nghiên cứu.'
    ),
    (
      v_gp_id,
      '许多人以为熬夜后补觉就能抵消身体损伤，殊不知长期昼夜颠倒会对生物钟造成不可逆的破坏。',
      'Xǔduō rén yǐwéi áoyè hòu bǔjiào jiù néng dǐxiāo shēntǐ sǔnshāng, shūbùzhī chángqī zhòuyèdiāndǎo huì duì shēngwùzhōng zàochéng bùkěnì de pòhuài.',
      'Nhiều người ngỡ rằng sau khi thức đêm ngủ bù là có thể triệt tiêu tổn thương thể xác, đâu biết rằng việc ngày đêm đảo lộn lâu dài sẽ gây ra sự hủy hoại không thể đảo ngược đối với đồng hồ sinh học.',
      '"殊不知..." lật mở một chân lý y học đối nghịch với nhận thức sai lầm thông thường của đại chúng.'
    );

  -- Điểm ngữ pháp #34: Phó từ mức độ văn ngôn cực hạn "甚" (Rất / Quá đỗi / Thậm chí)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ mức độ văn ngôn cực hạn "甚" (Rất / Quá đỗi / Thậm chí)',
    '甚 + Tính từ song âm tiết / 甚为 / 甚或 / 欺人太甚 / 甚嚣尘上',
    'Phó từ',
    '"甚" (shèn) là phó từ văn ngôn tương đương với "很, 非常" (rất, hết sức) hoặc "甚至" (thậm chí). Thường gặp: "甚为" (rất đỗi: 甚为满意, 甚为欣慰), "甚或" (thậm chí hoặc là), "过甚" (quá đáng).',
    'HSK 6',
    34,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听到青年科研团队在量子计算领域取得突破性进展的喜报，老院士甚为欣慰。',
      'Tīngdào qīngnián kēyán tuánduì zài liàngzǐ jìsuàn lǐngyù qǔdé tūpòxìng jìnzhǎn de xǐbào, lǎo yuànshì shènwéi xīnwèi.',
      'Nghe tin vui nhóm nghiên cứu khoa học trẻ đạt được bước tiến đột phá trong lĩnh vực tính toán lượng tử, vị viện sĩ già cảm thấy hết sức ấm lòng mừng rỡ.',
      '"甚为欣慰" thể hiện sự hài lòng sâu sắc của thế hệ đi trước trước sự trưởng thành của lớp trẻ.'
    ),
    (
      v_gp_id,
      '这种极端自私的行径不仅会伤害身边的朋友，甚或可能触犯国家的刑事法律。',
      'Zhè zhǒng jíduān zìsī de xíngjìng bùjǐn huì shānghài shēnbiān de péngyou, shènhuò kěnéng chùfàn guójiā de xíngshì fǎlǜ.',
      'Hành vi ích kỷ cực đoan này không chỉ làm tổn thương bạn bè xung quanh, thậm chí hoặc là có thể xúc phạm tới luật pháp hình sự của quốc gia.',
      '"甚或可能..." tăng tiến mức độ nguy hại từ phạm trù đạo đức cá nhân lên tới lằn ranh vi phạm pháp luật.'
    );

  -- Điểm ngữ pháp #35: Cụm phó từ mức độ tăng tiến tương phản "尤甚" (Càng dữ dội hơn / Lại càng thậm tệ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm phó từ mức độ tăng tiến tương phản "尤甚" (Càng dữ dội hơn / Lại càng thậm tệ)',
    'Hiện tượng A nghiêm trọng, mà Hiện tượng B + 尤甚',
    'Phó từ',
    '"尤甚" (yóushèn) kết hợp chữ "尤" (đặc biệt, càng) và "甚" (dữ dội, nghiêm trọng), mang nghĩa "so với các trường hợp khác thì đối tượng này lại càng thêm gay gắt, dữ dội hơn một bậc" (càng thêm thậm tệ, lại càng dữ dội hơn). Thường đứng cuối phân câu thứ hai.',
    'HSK 6',
    35,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '全球气候异常给发展中国家带来了巨大挑战，而极度干旱贫瘠的非洲内陆地区受灾尤甚。',
      'Quánqiú qìhòu yìcháng gěi fāzhǎnzhōng guójiā dàilái le jùdà tiǎozhàn, ér jídù gānhàn pínjí de Fēizhōu nèilù dìqū shòuzāi yóushèn.',
      'Khí hậu toàn cầu dị thường đã đem lại thách thức khổng lồ cho các nước đang phát triển, mà vùng nội lục châu Phi khô hạn cằn cỗi cùng cực chịu ảnh hưởng thiên tai lại càng thậm tệ hơn.',
      '"受灾尤甚" làm nổi bật mức độ tổn thương nặng nề nhất của khu vực dễ bị tổn thương.'
    ),
    (
      v_gp_id,
      '现代都市人普遍面临着失眠焦虑的困扰，而处于高强度竞争中的IT从业人员尤甚。',
      'Xiàndài dūshìrén pǔbiàn miànlínzhe shīmián jiāolǜ de kùnrǎo, ér chǔyú gāoqiángdù jìngzhēng zhōng de IT cóngyè rényuán yóushèn.',
      'Người dân đô thị hiện đại phổ biến đang đối mặt với nỗi phiền muộn lo âu mất ngủ, mà nhân sự làm nghề công nghệ thông tin trong môi trường cạnh tranh cường độ cao lại càng nặng nề hơn nữa.',
      '"尤甚" so sánh giữa diện rộng cư dân thành phố với nhóm ngành nghề chịu áp lực đặc thù.'
    );

  -- Điểm ngữ pháp #36: Phó từ cấm đoán và nguyên tắc thép "断不可" (Quyết không thể / Dứt khoát không được)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ cấm đoán và nguyên tắc thép "断不可" (Quyết không thể / Dứt khoát không được)',
    '面对... / 在...面前, 断不可 + Động từ (大意 / 妥协 / 姑息 / 违背)',
    'Phó từ',
    '"断不可" (duànbùkě) là phó từ cấm chỉ văn ngôn đanh thép tương đương với "绝对不能" hoặc "万万不可" (dứt khoát không được, quyết không thể). Dùng trong các huấn thị quân sự, quy chế an toàn hoặc di huấn răn dạy con cháu.',
    'HSK 6',
    36,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '安全生产重于泰山，在任何细小环节上都断不可抱有丝毫侥幸麻痹心理。',
      'Ānquán shēngchǎn zhòngyú Tàishān, zài rènhé xìxiǎo huánjié shang dōu duànbùkě bàoyǒu sīháo jiǎoxìng mábì xīnlǐ.',
      'An toàn sản xuất nặng hơn núi Thái Sơn, ở bất kỳ khâu tiểu tiết nào cũng dứt khoát không được ôm giữ mảy may tâm lý cầu may mất cảnh giác.',
      '"断不可抱有丝毫侥幸心理" là mệnh lệnh kỷ luật an toàn lao động bất di bất dịch.'
    ),
    (
      v_gp_id,
      '做学问当持严谨求实之态度，抄袭剽窃他人成果的学术不端行径断不可为。',
      'Zuò xuéwèn dāng chí yánjǐn qiúshí zhī tàidu, chāoxí piāoqiè tārén chéngguǒ de xuéshù bùduān xíngjìng duànbùkě wéi.',
      'Làm học vấn phải giữ thái độ cẩn trọng cầu thị, hành vi bất chính học thuật sao chép đạo văn thành quả của người khác dứt khoát không thể làm.',
      '"断不可为" nghiêm cấm tuyệt đối các hành vi vi phạm đạo đức học thuật.'
    );

  -- Điểm ngữ pháp #37: Phó từ đặc tả hiển lộ sừng sững đập vào mắt "赫然" (Sừng sững / Đập vào mắt / Nổi bật)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ đặc tả hiển lộ sừng sững đập vào mắt "赫然" (Sừng sững / Đập vào mắt / Nổi bật)',
    '赫然 + Động từ (矗立 / 出现 / 显露 / 印着 / 映入眼帘)',
    'Phó từ',
    '"赫然" (hèrán) là phó từ miêu tả thị giác mạnh mẽ, biểu thị một vật thể to lớn, một dòng chữ lớn gây sốc, hoặc một nhân vật uy nghi đột nhiên đập ngay vào mắt người nhìn với khí thế nổi bật, khiến người ta kinh ngạc hoặc giật mình (sừng sững, đập ngay vào mắt).',
    'HSK 6',
    37,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '转过幽暗的山崖转角，眼前赫然矗立着一座高达数十米的千年古佛石雕。',
      'Zhuǎnguò yōu''àn de shānyá zhuǎnjiǎo, yǎnqián hèrán chùlìzhe yí zuò gāodá shùshí mǐ de qiānnián gǔfó shídiāo.',
      'Vòng qua khúc quanh vách núi u ám, trước mắt sừng sững một pho tượng đá cổ nghìn năm cao tới mấy chục mét đập ngay vào tầm mắt.',
      '"眼前赫然矗立着..." khắc họa cảm giác ngỡ ngàng thán phục khi bất ngờ diện kiến kỳ quan điêu khắc khổng lồ.'
    ),
    (
      v_gp_id,
      '在解密档案的死难者名单头版上，赫然印着他苦苦寻找了半个世纪的父亲的名字。',
      'Zài jiěmì dàng''àn de sǐnànzhě míngdān tóubǎn shang, hèrán yìnzhe tā kǔkǔ xúnzhǎo le bàn gè shìjì de fùqīn de míngzi.',
      'Trên trang đầu danh sách người tử nạn trong hồ sơ giải mật, đập ngay vào mắt là dòng chữ in tên người cha mà ông đã khổ công tìm kiếm suốt nửa thế kỷ.',
      '"赫然印着..." đặc tả cảm xúc bàng hoàng nghẹn ngào khi tìm thấy tên người thân trong tài liệu lịch sử.'
    );

  -- Điểm ngữ pháp #38: Phó từ mô phỏng phong thái giống hệt "俨然" (Hệt như / Đường hoàng như là / Ra vẻ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ mô phỏng phong thái giống hệt "俨然" (Hệt như / Đường hoàng như là / Ra vẻ)',
    'Chủ ngữ + 俨然 + (是 / 成了 / 一位) + Danh từ (专家 / 统帅 / 小主人 / 世外桃源)',
    'Phó từ',
    '"俨然" (yǎnrán) có hai nghĩa chính: 1) Miêu tả phong thái, khí chất hoặc hành vi của một người trông đường hoàng, chững chạc giống hệt như một chức danh hay vai vế nào đó (như 俨然成了一位专家 - ra dáng hệt như một chuyên gia); 2) Miêu tả cảnh sắc đẹp đẽ, trật tự ngay ngắn như bồng lai (như 俨然一座世外桃源).',
    'HSK 6',
    38,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '年仅十二岁的小选手在棋盘前沉着落子、神态自若，俨然是一位久经沙场的国际特级大师。',
      'Nián jǐn shí''èr suì de xiǎo xuǎnshǒu zài qípán qián chénzhuó luòzǐ, shéntài zìruò, yǎnrán shì yí wèi jiǔjīngshāchǎng de guójì tèjí dàshī.',
      'Kỳ thủ nhí mới 12 tuổi ngồi trước bàn cờ điềm tĩnh hạ cờ, thần thái tự tin đĩnh đạc, trông đường hoàng hệt như một đại kiện tướng quốc tế đã trải trăm trận trường kỳ.',
      '"俨然是一位...大师" ca ngợi bản lĩnh chững chạc vượt tuổi tác của thần đồng cờ vua.'
    ),
    (
      v_gp_id,
      '春雪过后，粉妆玉砌的古城屋檐错落有致，俨然一幅意境悠远的淡雅水墨画。',
      'Chūnxuě zhīhòu, fěnzhuāngyùqì de gǔchéng wūyán cuòluòyǒuzhì, yǎnrán yì fú yìjìng yōuyuǎn de dànyǎ shuǐmòhuà.',
      'Sau cơn tuyết xuân, những mái ngói thành cổ tráng tuyết ngọc đan xen ngăn nắp, trông hệt như một bức tranh thủy mạc thanh nhã có ý cảnh xa xăm.',
      '"俨然一幅...水墨画" dùng "俨然" so sánh ví von cảnh sắc thành cổ đẹp như tranh vẽ.'
    );

  -- Điểm ngữ pháp #39: Phó từ phân định ranh giới rành rọt "截然" (Rành rọt / Hoàn toàn khác biệt / Dứt khoát)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phân định ranh giới rành rọt "截然" (Rành rọt / Hoàn toàn khác biệt / Dứt khoát)',
    '截然 + Tính từ song âm tiết (截然不同 / 截然相反 / 截然两样 / 截然划分)',
    'Phó từ',
    '"截然" (jiérán) có gốc từ động từ "截" (cắt đứt, phân chia rõ rệt). Dùng để chỉ hai sự vật, quan điểm hoặc tính cách đối lập nhau một cách tuyệt đối, có ranh giới rành rọt như dùng dao cắt đôi (hoàn toàn khác biệt, rành rọt tách bạch). Hai thành ngữ chuẩn thi cử HSK 6: "截然不同" (hoàn toàn khác nhau) và "截然相反" (hoàn toàn trái ngược nhau).',
    'HSK 6',
    39,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '对于同一历史人物的历史功过，两位资深历史学家给出了截然相反的学术评价。',
      'Duìyú tóng yí lìshǐ rénwù de lìshǐ gōngguò, liǎng wèi zīshēn lìshǐxuéjiā gěichū le jiérán xiāngfǎn de xuéshù píngjià.',
      'Đối với công và tội của cùng một nhân vật lịch sử, hai nhà sử học kỳ cựu đã đưa ra những đánh giá học thuật hoàn toàn trái ngược nhau.',
      '"截然相反的评价" miêu tả sự đối lập 180 độ trong quan điểm phân tích lịch sử.'
    ),
    (
      v_gp_id,
      '这对双胞胎兄弟在成长轨迹上展现出了截然不同的性格特征与职业追求。',
      'Zhè duì shuāngbāotāi xiōngdì zài chéngzhǎng guǐjì shang zhǎnxiàn chū le jiérán bùtóng de xìnggé tèzhēng yǔ zhíyè zhuīqiú.',
      'Cặp anh em sinh đôi này trên quỹ đạo trưởng thành đã bộc lộ những nét tính cách và định hướng nghề nghiệp hoàn toàn khác biệt nhau.',
      '"截然不同" phân định ranh giới rành rẽ giữa hai lối đi cuộc đời của cặp song sinh.'
    );

  -- Điểm ngữ pháp #40: Phó từ kết cục uổng phí cay đắng "枉然" (Uổng công / Hoài công / Vô ích)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ kết cục uổng phí cay đắng "枉然" (Uổng công / Hoài công / Vô ích)',
    'Nỗ lực không đúng phương pháp, 终归是 / 一切都是 + 枉然 / 徒劳枉然',
    'Phó từ',
    '"枉然" (wǎngrán) kết hợp chữ "枉" (uổng, oan uổng) và "然", mang nghĩa "mọi công sức, tâm huyết, hy sinh đã bỏ ra cuối cùng hoàn toàn tan biến thành con số không, không thu lại được một kết quả nào (uổng công hoài phí). Mang sắc thái cay đắng, xót xa sâu sắc hơn "徒劳".',
    'HSK 6',
    40,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '做任何工作如果脱离了实事求是的根本原则，付出再多心血终究也不过是枉然。',
      'Zuò rènhé gōngzuò rúguǒ tuōlí le shíshìqiúshì de gēnběn yuánzé, fùchū zài duō xīnxuè zhōngjiū bùguò shì wǎngrán.',
      'Làm bất kỳ công việc nào nếu tách rời nguyên tắc căn bản thực sự cầu thị, có bỏ ra bao nhiêu tâm huyết đi chăng nữa rốt cuộc cũng chẳng qua chỉ là hoài công vô ích.',
      '"终究不过是枉然" cảnh báo cái giá của việc làm trái quy luật khách quan.'
    ),
    (
      v_gp_id,
      '既然对方缺乏最基本的签约诚意，我们此前所作的一切磋商努力均告枉然。',
      'Jìrán duìfāng quēfá zuì jīběn de qiānyuē chéngyì, wǒmen cǐqián suǒ zuò de yíqiè cuōshāng nǔlì jūn gào wǎngrán.',
      'Đã đối phương thiếu thành ý ký kết cơ bản nhất thì mọi nỗ lực đàm phán mà chúng ta đã bỏ ra trước đó đều xem như uổng công phí sức.',
      '"均告枉然" là cách nói thương mại ngoại giao đúc kết sự thất bại đáng tiếc của vòng đàm phán.'
    );

  -- Điểm ngữ pháp #41: Phó từ thời gian vụt tắt cực nhanh "倏忽" (Thoắt cái / Vút qua trong chớp mắt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời gian vụt tắt cực nhanh "倏忽" (Thoắt cái / Vút qua trong chớp mắt)',
    '倏忽间, Mệnh đề / 时间 + 倏忽而逝 / 倏忽万里',
    'Phó từ',
    '"倏忽" (shūhū) là phó từ văn học cổ xưa miêu tả tốc độ trôi đi của thời gian hoặc chuyển động của một vật thể diễn ra nhanh đến mức chỉ như một cái chớp mắt (thoắt cái, vụt qua trong chốc lát). Thường dùng than thở về sự ngắn ngủi của đời người hoặc tuổi xuân.',
    'HSK 6',
    41,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '回首往昔峥嵘岁月，青春年华倏忽而逝，唯有那份坚守初心的信念历久弥新。',
      'Huíshǒu wǎngxī zhēngróng suìyuè, qīngchūn niánhuá shūhū ér shì, wéiyǒu nà fèn jiānshǒu chūxīn de xìnniàn lìjiǔmíxīn.',
      'Ngoảnh đầu nhìn lại năm tháng oanh liệt xưa kia, tuổi thanh xuân thoắt cái đã vụt trôi qua, duy chỉ có niềm tin kiên định thuở ban đầu là càng trải qua thời gian lại càng thêm tươi mới.',
      '"青春年华倏忽而逝" than thở về bước chân thời gian trôi nhanh như tên bắn.'
    ),
    (
      v_gp_id,
      '倏忽间，疾驰的高铁列车已经穿过了连绵起伏的秦岭崇山峻岭。',
      'Shūhū jiān, jíchí de gāotiě lièchē yǐjīng chuānguò le liánmián qǐfú de Qínlǐng chóngshānjùnlǐng.',
      'Thoắt cái trong chớp mắt, đoàn tàu cao tốc lao vun vút đã vượt qua dãy núi Tần Lĩnh trùng điệp nhấp nhô hiểm trở.',
      '"倏忽间" đặc tả tốc độ di chuyển thần tốc của phương tiện giao thông hiện đại.'
    );

  -- Điểm ngữ pháp #42: Phó từ bừng tỉnh bất chợt "蓦然" (Chợt / Bất chợt / Sực nhận ra)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ bừng tỉnh bất chợt "蓦然" (Chợt / Bất chợt / Sực nhận ra)',
    '蓦然 + Động từ (回首 / 发现 / 醒悟 / 惊觉)',
    'Phó từ',
    '"蓦然" (mòrán) có nguồn gốc từ câu từ cổ điển "蓦然回首，那人却在灯火阑珊处", mang nghĩa bất chợt, đột nhiên trong một khoảnh khắc ngộ ra chân lý hoặc sực nhận thấy một điều kỳ diệu mà bấy lâu nay mình vô tình bỏ quên (bất giác, sực nhớ, chợt nhận ra).',
    'HSK 6',
    42,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在异国他乡漫步街头，蓦然听到熟悉的小提琴乡音，他不禁热泪潸然。',
      'Zài yìguó tāxiāng mànbù jiētóu, mòrán tīngdào shúxī de xiǎotíqín xiāngyīn, tā bùjīn rèlèishānrán.',
      'Dạo bước trên đường phố nơi đất khách quê người, bất chợt nghe thấy âm vang giai điệu quê hương quen thuộc của cây vĩ cầm, anh ấy bất giác rơi nước mắt.',
      '"蓦然听到..." miêu tả khoảnh khắc xúc động bất ngờ chạm vào nỗi nhớ nhà da diết.'
    ),
    (
      v_gp_id,
      '直到白发悄悄爬上鬓角，他才蓦然醒悟陪伴家人才是生命中最珍贵的幸福。',
      'Zhídào báifà qiāoqiāo páshàng bìnjiǎo, tā cái mòrán xǐngwù péibàn jiārén cái shì shēngmìng zhōng zuì zhēnguì de xìngfú.',
      'Mãi tới khi tóc bạc lặng lẽ len lỏi lên khóe mai, ông mới bừng tỉnh sực ngộ ra rằng ở bên gia đình mới là niềm hạnh phúc quý báu nhất trong cuộc đời.',
      '"蓦然醒悟" diễn tả sự giác ngộ triết lý nhân sinh muộn màng nhưng sâu sắc.'
    );

  -- Điểm ngữ pháp #43: Phó từ biến cố đột ngột ập tới "猝然" (Đột ngột / Bất thình lình ập tới)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ biến cố đột ngột ập tới "猝然" (Đột ngột / Bất thình lình ập tới)',
    '猝然 + Động từ biến cố (发生 / 降临 / 长逝 / 离世 / 发难)',
    'Phó từ',
    '"猝然" (cùrán) kết hợp chữ "猝" (cù - bất ngờ, không kịp trở tay), chuyên dùng cho các tai họa, cái chết hoặc biến cố bất ngờ ập đến khiến con người hoàn toàn không có sự phòng bị tâm lý (đột ngột qua đời, bất ngờ ập xuống). Thành ngữ cao cấp: "猝然长逝" (đột ngột tạ thế).',
    'HSK 6',
    43,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这位德高望重的功勋老科学家在实验岗位上猝然长逝，令全国科技界悲痛万分。',
      'Zhè wèi dégāowàngzhòng de gōngxūn lǎo kēxuéjiā zài shíyàn gǎngwèi shang cùrán chángshì, lìng quánguó kējìjiè bēitòng wànfēn.',
      'Vị nhà khoa học già có công huân đức cao vọng trọng này đã đột ngột tạ thế ngay trên cương vị nghiên cứu, khiến toàn thể giới khoa học công nghệ cả nước đau buồn khôn xiết.',
      '"猝然长逝" là thành ngữ trang trọng nhất biểu thị sự ra đi đột ngột cống hiến tới hơi thở cuối cùng.'
    ),
    (
      v_gp_id,
      '面对猝然降临的特大暴雨山洪灾害，当地党委政府紧急启动了一级应急响应机制。',
      'Miànduì cùrán jiànglín de tèdà bàoyǔ shānhóng zāihài, dāngdì dǎngwěi zhèngfǔ jǐnjí qǐdòng le yījí yìngjí xiǎngyìng jīzhì.',
      'Đối mặt với thảm họa lũ quét mưa bão cực lớn bất thình lình ập xuống, cấp ủy chính quyền địa phương đã khẩn cấp kích hoạt cơ chế ứng phó khẩn cấp cấp độ 1.',
      '"面对猝然降临的...灾害" phản ánh tính bất ngờ hung hãn của thảm họa thiên nhiên.'
    );

  -- Điểm ngữ pháp #44: Phó từ quy nạp kết quả tối hậu "终归" (Rốt cuộc thì / Chung quy lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ quy nạp kết quả tối hậu "终归" (Rốt cuộc thì / Chung quy lại)',
    'Chủ ngữ + 终归 + (会 / 是 / 要) + Kết quả quy nạp tất yếu',
    'Phó từ',
    '"终归" (zhōngguī) là phó từ cao cấp tương đương với "到底" hoặc "终究", mang ý nghĩa sau khi trải qua muôn vàn biến thiên, quanh co khúc khuỷu, sự việc nhất định sẽ quay trở về với bản chất hoặc kết quả tất yếu của nó theo quy luật (chung quy lại, rốt cuộc thì vẫn cứ).',
    'HSK 6',
    44,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '任何谎言无论编造得多么巧妙，在铁一般的历史事实面前终归是要破产的。',
      'Rènhé huǎngyán wúlùn biānzào de duōme qiǎomiào, zài tiě yībān de lìshǐ shìshí miànqián zhōngguī shì yào pòchǎn de.',
      'Bất kỳ lời nói dối nào cho dù thêu dệt khéo léo đến đâu, trước sự thật lịch sử vững như sắt thép rốt cuộc thì cũng phải phá sản.',
      '"终归是要破产的" khẳng định chân lý tất thắng của sự thật trước mọi thủ đoạn lừa dối.'
    ),
    (
      v_gp_id,
      '漂泊在外的游子无论走过多远的风雨路程，其心灵深处的精神根脉终归在故乡。',
      'Piāobó zài wài de yóuzǐ wúlùn zǒuguo duō yuǎn de fēngyǔ lùchéng, qí xīnlíng shēnchù de jīngshén gēnmài zhōngguī zài gùxiāng.',
      'Người con phiêu bạt bên ngoài bất kể đã đi qua chặng đường mưa gió bao xa, cội rễ tinh thần nơi sâu thẳm tâm hồn rốt cuộc vẫn thuộc về cố hương.',
      '"终归在故乡" lột tả tình cảm gắn bó thiêng liêng vĩnh cửu của con người với mảnh đất chôn rau cắt rốn.'
    );

  -- Điểm ngữ pháp #45: Phó từ cảm thán mức độ tột cùng "何其" (Biết bao / Dường nào / Xiết bao)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ cảm thán mức độ tột cùng "何其" (Biết bao / Dường nào / Xiết bao)',
    '何其 + Tính từ song âm tiết (相似 / 艰难 / 幸运 / 壮烈 / 荒谬) !',
    'Phó từ',
    '"何其" (héqí) là phó từ tu từ cảm thán văn ngôn kết hợp chữ "何" (sao, thế nào) và "其", mang nghĩa "mức độ cao đến nhường nào, biết bao, xiết bao". Thường dùng trong câu cảm thán hoặc nghị luận đanh thép để bộc lộ cảm xúc thán phục, kinh ngạc hoặc phẫn nộ tột độ.',
    'HSK 6',
    45,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '历史的进程在某些关键转折点上，其内在逻辑表现得何其相似啊！',
      'Lìshǐ de jìnchéng zài mǒuxiē guānjiàn zhuǎnzhédiǎn shang, qí nèizài luójí biǎoxiàn de héqí xiāngsì a!',
      'Tiến trình lịch sử tại một số bước ngoặt the chốt, logic nội tại của nó thể hiện ra giống nhau đến dường nào!',
      '"表现得何其相似" cảm thán về quy luật lặp lại kỳ diệu của các bài học lịch sử.'
    ),
    (
      v_gp_id,
      '老一辈革命先烈在风雨如晦的年代开辟救国救民之路，其探索历程何其艰难卓绝！',
      'Lǎoyíbèi gémìng xiānliè zài fēngyǔrúhuì de niándài kāipì jiùguójiùmín zhī lù, qí tànsuǒ lìchéng héqí jiānnánzhuójué!',
      'Các bậc tiền liệt cách mạng tiền bối vào thời đại gió mưa mịt mù đã mở ra con đường cứu nước cứu dân, chặng đường tìm tòi ấy gian nan khôn xiết biết bao!',
      '"何其艰难卓绝" ca ngợi tinh thần kiên cường bất khuất vượt qua muôn trùng thử thách của cha ông.'
    );

  -- Điểm ngữ pháp #46: Cụm liên từ dẫn xuất sự thật xác thực "诚如" (Đúng như / Thật đúng như)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm liên từ dẫn xuất sự thật xác thực "诚如" (Đúng như / Thật đúng như)',
    '诚如 + Nhân vật uy tín / Danh ngôn / Lời khẳng định (所言 / 所料 / 大家所见), Mệnh đề',
    'Liên từ',
    '"诚如" (chéngrú) kết hợp chữ "诚" (chân thực, quả thật) và "如" (như), mang nghĩa "thực tế diễn ra hoàn toàn đúng y như lời nhận định, dự báo hoặc danh ngôn của ai đó" (đúng như đã nói, quả đúng như dự liệu). Dùng để trích dẫn lập luận củng cố uy tín học thuật.',
    'HSK 6',
    46,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '诚如爱因斯坦所言，想象力远比单纯的知识记忆更加重要，因为它是科学探索的源泉。',
      'Chéngrú Àiyīnsītǎn suǒ yán, xiǎngxiànglì yuǎn bǐ dānchún de zhīshi jìyì gèngjiā zhòngyào, yīnwèi tā shì kēxué tànsuǒ de yuánquán.',
      'Đúng như Einstein từng nói, trí tưởng tượng còn quan trọng hơn nhiều so với việc ghi nhớ kiến thức đơn thuần, bởi vì nó là suối nguồn của sự tìm tòi khoa học.',
      '"诚如...所言" trích dẫn lời vĩ nhân để nâng cao sức nặng luận điểm cho bài viết.'
    ),
    (
      v_gp_id,
      '诚如专家们此前所料，这项重大金融改革举措的出台极大稳定了市场信心。',
      'Chéngrú zhuānjiāmen cǐqián suǒ liào, zhè xiàng zhòngdà jīnróng gǎigé jǔcuò de chūtái jídà wěndìng le shìchǎng xìnxīn.',
      'Đúng như các chuyên gia đã dự liệu trước đó, việc ban hành biện pháp cải cách tài chính trọng đại này đã làm ổn định mạnh mẽ niềm tin thị trường.',
      '"诚如...所料" khẳng định sự chuẩn xác trong công tác dự báo kinh tế của giới học giả.'
    );

  -- Điểm ngữ pháp #47: Động từ/Phó từ tỉ dụ thi ca tráng lệ "宛如" (Ví tựa như / Giống hệt như)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ/Phó từ tỉ dụ thi ca tráng lệ "宛如" (Ví tựa như / Giống hệt như)',
    'Chủ ngữ + 宛如 + Cảnh tượng/Hình ảnh thi ca hoa lệ',
    'Phó từ',
    '"宛如" (wǎnrú) là từ tỉ dụ so sánh mang phẩm cách thi ca trang nhã bậc nhất trong HSK 6, tương đương với "好似" hoặc "仿佛", nhưng thường đi liền với những bức tranh phong cảnh thiên nhiên tráng lệ hoặc hình tượng nghệ thuật lung linh kỳ vĩ (ví tựa như, dường như).',
    'HSK 6',
    47,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '夜晚从空中俯瞰维多利亚港，两岸璀璨绚丽的万家灯火宛如银河跌落人间。',
      'Yèwǎn cóng kōngzhōng fǔkàn Wéiduōlìyǎ Gǎng, liǎng''àn cuǐcàn xuànlì de wànjiādēnghuǒ wǎnrú yínhé diēluò rénjiān.',
      'Ban đêm từ trên không trung nhìn xuống cảng Victoria, muôn ánh đèn lung linh rực rỡ hai bên bờ ví tựa dải Ngân Hà rơi xuống cõi nhân gian.',
      '"宛如银河跌落人间" là câu văn so sánh tuyệt mỹ miêu tả cảnh đêm bến cảng phồn hoa.'
    ),
    (
      v_gp_id,
      '大漠深处的月牙泉宛如一颗镶嵌在金黄色沙海中的璀璨绿宝石，神奇而静谧。',
      'Dàmò shēnchù de Yuèyáquán wǎnrú yì kē xiāngqiàn zài jīnhuángsè shāhǎi zhōng de cuǐcàn lǜbǎoshí, shénqí ér jìngmì.',
      'Suối Nguyệt Nha nơi sâu thẳm chốn sa mạc ví tựa như một viên ngọc bích rực rỡ khảm vào giữa biển cát vàng óng ả, kỳ diệu và tĩnh mịch.',
      '"宛如一颗...绿宝石" khắc họa vẻ đẹp độc nhất vô nhị của ốc đảo sa mạc.'
    );

  -- Điểm ngữ pháp #48: Động từ/Phó từ so sánh tương đồng khách quan "犹如" (Tựa như / Dường như)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ/Phó từ so sánh tương đồng khách quan "犹如" (Tựa như / Dường như)',
    'Chủ ngữ + 犹如 + Biểu tượng so sánh sâu sắc',
    'Phó từ',
    '"犹如" (yóurú) có nguồn gốc văn ngôn tương tự "宛如", nhưng thiên về việc so sánh giữa các hiện tượng triết học, ý niệm trừu tượng với các quy luật tự nhiên (tựa như, giống như). Thường dùng trong văn phong nghị luận sâu lắng.',
    'HSK 6',
    48,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '一位杰出的思想导师犹如黑夜航行中的明亮灯塔，指引着学子们迷茫的心灵。',
      'Yí wèi jiéchū de sīxiǎng dǎoshī yóurú hēiyè hángxíng zhōng de míngliàng dēngtǎ, zhǐyǐnzhe xuézǐmen mímáng de xīnlíng.',
      'Một người thầy tư tưởng kiệt xuất tựa như ngọn hải đăng sáng rực trong đêm đen hải trình, dẫn lối cho tâm hồn đang hoang mang của các học trò.',
      '"犹如...明亮灯塔" ví người thầy với ngọn hải đăng soi sáng con đường tri thức.'
    ),
    (
      v_gp_id,
      '逆水行舟用力撑，一篙松劲退千寻，学业的追求犹如逆水行舟，不进则退。',
      'Nìshuǐ xíng zhōu yònglì chēng, yì gāo sōngjìn tuì qiānxún, xuéyè de zhuīqiú yóurú nìshuǐxíngzhōu, bújìnzétuì.',
      'Chèo thuyền ngược dòng phải dốc sức chống, lơi tay một sào ắt lùi ngàn tầm, sự theo đuổi học nghiệp tựa như chèo thuyền ngược nước, không tiến ắt lùi.',
      '"犹如逆水行舟" trích dẫn thành ngữ kinh điển răn dạy sự khổ học không được buông lỏng.'
    );

  -- Điểm ngữ pháp #49: Liên từ lựa chọn văn ngôn thà rằng "毋宁" (Thà rằng / Chi bằng / Đúng hơn là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ lựa chọn văn ngôn thà rằng "毋宁" (Thà rằng / Chi bằng / Đúng hơn là)',
    '与其 A, 毋宁 B (B mới là sự lựa chọn hoặc định nghĩa chuẩn xác)',
    'Liên từ',
    '"毋宁" (wúnìng) là liên từ văn ngôn cổ kính tương đương với "不如" hoặc "宁肯", biểu thị thái độ thà rằng chọn phương án B còn hơn phương án A, hoặc khẳng định cách gọi B mới phản ánh đúng chân lý hơn (chi bằng, thà rằng, đúng hơn là). Thường kết hợp với "与其".',
    'HSK 6',
    49,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '与其苟且偷生而出卖自己的人格尊严，毋宁为了捍卫正义而英勇就义。',
      'Yǔqí gǒuqiětōushēng ér chūmài zìjǐ de réngé zūnyán, wúnìng wèile hànwèi zhèngyì ér yīngyǒngjiùyì.',
      'Thay vì sống tạm bợ hèn nhát mà bán rẻ phẩm giá nhân cách của bản thân, thà rằng anh dũng hy sinh vì sự nghiệp bảo vệ chính nghĩa.',
      '"与其...毋宁..." thể hiện khí tiết trung liệt cao cả thà chết vinh còn hơn sống nhục.'
    ),
    (
      v_gp_id,
      '这项重大的科学发现与其说是个人智慧的灵光一现，毋宁说是无数前人垫脚石堆叠的必然产物。',
      'Zhè xiàng zhòngdà de kēxué fāxiàn yǔqí shuō shì gèrén zhìhuì de língguāngyíxiàn, wúnìng shuō shì wúshù qiánrén diànjiǎoshí duīdié de bìrán chǎnwù.',
      'Phát hiện khoa học trọng đại này thay vì nói là sự lóe sáng của trí tuệ cá nhân, đúng hơn nên nói là sản vật tất yếu được đắp bồi từ những hòn đá lót đường của vô số tiền nhân đi trước.',
      '"毋宁说是..." khiêm tốn ghi nhận công lao tích lũy của nhiều thế hệ khoa học tiền bối.'
    );

  -- Điểm ngữ pháp #50: Cụm phó từ khẳng định không thể tranh cãi "不容置疑" (Không được phép hoài nghi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm phó từ khẳng định không thể tranh cãi "不容置疑" (Không được phép hoài nghi)',
    'Chủ quyền / Sự thật / Nguyên tắc + 是不容置疑的',
    'Cấu trúc cố định',
    '"不容置疑" (bùróng zhìyí) kết hợp chữ 不容 (không cho phép) và 置疑 (đặt câu hỏi hoài nghi), biểu thị một sự thật, một nguyên tắc hoặc chủ quyền thiêng liêng tuyệt đối không cho phép bất kỳ ai được nghi ngờ, xuyên tạc hay bàn cãi (hoàn toàn không được phép nghi ngờ). Thường dùng trong tuyên ngôn ngoại giao quốc gia.',
    'HSK 6',
    50,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '中国对包括钓鱼岛及其附属岛屿在内的领土拥有无可争辩的主权，这是不容置疑的历史事实。',
      'Zhōngguó duì bāokuò Diàoyúdǎo jí qí fùshǔ dǎoyǔ zài nèi de lǐngtǔ yōngyǒu wúkězhēngbiàn de zhǔquán, zhè shì bùróngzhìyí de lìshǐ shìshí.',
      'Trung Quốc có chủ quyền không thể tranh cãi đối với lãnh thổ bao gồm đảo Điếu Ngư cùng các đảo phụ cận, đây là sự thật lịch sử không cho phép hoài nghi.',
      '"是不容置疑的历史事实" khẳng định lập trường chủ quyền quốc gia vững như bàn thạch.'
    ),
    (
      v_gp_id,
      '法律面前人人平等是现代法治文明的基本准则，任何特权阶层的存在都是不容置疑的违法行为。',
      'Fǎlǜ miànqián rénrén píngděng shì xiàndài fǎzhì wénmíng de jīběn zhǔnzé, rènhé tèquán jiēcéng de cúnzài dōu shì bùróngzhìyí de wéifǎ xíngwéi.',
      'Mọi người đều bình đẳng trước pháp luật là chuẩn tắc cơ bản của văn minh pháp quyền hiện đại, sự tồn tại của bất kỳ tầng lớp đặc quyền nào đều là hành vi vi phạm pháp luật không thể bàn cãi.',
      '"是不容置疑的..." bảo vệ nguyên tắc công bằng tư pháp tối thượng.'
    );

  -- Điểm ngữ pháp #51: Cụm phó từ cảnh báo không thể xem nhẹ "不容忽视" (Không được phép xem nhẹ / Bỏ qua)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm phó từ cảnh báo không thể xem nhẹ "不容忽视" (Không được phép xem nhẹ / Bỏ qua)',
    'Vấn đề / Nguy cơ tiềm ẩn / Tác dụng + 是不容忽视的',
    'Cấu trúc cố định',
    '"不容忽视" (bùróng hūshì) biểu thị một hiện tượng, một nguy cơ tiềm ẩn hoặc tác động tiêu cực có tầm vóc vô cùng nghiêm trọng, bắt buộc toàn xã hội phải cảnh giác cao độ và nghiêm túc xử lý, tuyệt đối không được lơ là xem nhẹ (không thể xem thường).',
    'HSK 6',
    51,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '电子产品的过度使用对少年儿童视力健康造成的长期负面影响，是绝对不容忽视的。',
      'Diànzǐ chǎnpǐn de guòdù shǐyòng duì shàonián értóng shìlì jiànkāng zàochéng de chángqī fùmiàn yǐngxiǎng, shì juéduì bùróng hūshì de.',
      'Tác động tiêu cực dài hạn của việc lạm dụng thiết bị điện tử đối với sức khỏe thị lực của trẻ em và thanh thiếu niên là điều tuyệt đối không được phép xem nhẹ.',
      '"是不容忽视的" gióng lên hồi chuông cảnh báo tới các bậc phụ huynh và nhà trường.'
    ),
    (
      v_gp_id,
      '中小企业在吸纳社会劳动力就业和激发市场创新活力方面所起的独特作用，不容忽视。',
      'Zhōngxiǎo qǐyè zài xīnà shèhuì láodònglì jiùyè hé jīfā shìchǎng chuàngxīn huólì fāngmiàn suǒ qǐ de dútè zuòyòng, bùróng hūshì.',
      'Tác dụng độc đáo của các doanh nghiệp vừa và nhỏ trong việc thu hút việc làm cho lực lượng lao động xã hội và khơi dậy sức sống sáng tạo thị trường là điều không thể xem thường.',
      '"不容忽视" khẳng định vị thế xương sống của khối doanh nghiệp vừa và nhỏ trong nền kinh tế.'
    );

  -- Điểm ngữ pháp #52: Cấu trúc quy luật hành động bắt buộc "势在必行" (Thế tất phải làm / Bắt buộc phải tiến hành)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc quy luật hành động bắt buộc "势在必行" (Thế tất phải làm / Bắt buộc phải tiến hành)',
    'Việc cải cách/xử lý vấn đề + 势在必行',
    'Cấu trúc cố định',
    '"势在必行" (shì zài bì xíng) kết hợp chữ 势 (xu thế), 必 (tất yếu) và 行 (hành động), biểu thị một cuộc cải cách, chuyển đổi thể chế hoặc giải pháp cấp bách đã chín muồi về mặt xu thế khách quan, bắt buộc phải tiến hành thực hiện ngay lập tức chứ không thể trì hoãn thêm (thế tất phải làm, việc không thể không làm).',
    'HSK 6',
    52,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '面对严峻的能源危机与环境保护重任，加快推进传统工业的绿色低碳改造势在必行。',
      'Miànduì yánjùn de néngyuán wēijī yǔ huánjìng bǎohù zhòngrèn, jiākuài tuījìn chuántǒng gōngyè de lǜsè dītàn gǎizào shìzàibìxíng.',
      'Đối mặt với cuộc khủng hoảng năng lượng ngặt nghèo và trọng trách bảo vệ môi trường, việc đẩy nhanh thúc đẩy cải tạo xanh giảm thiểu carbon đối với công nghiệp truyền thống là điều thế tất phải làm.',
      '"势在必行" khẳng định tính cấp bách không thể đảo ngược của chiến lược chuyển đổi năng lượng xanh.'
    ),
    (
      v_gp_id,
      '为了破除阻碍科技成果转化的体制机制障碍，新一轮深化科研评价制度改革势在必行。',
      'Wèile pòchú zǔ''ài kējì chéngguǒ zhuǎnhuà de tǐzhì jīzhì zhàng''ài, xīn yì lún shēnhuà kēyán píngjià zhìdù gǎigé shìzàibìxíng.',
      'Để xóa bỏ các rào cản thể chế cơ chế cản trở việc chuyển hóa thành quả khoa học công nghệ, đợt cải cách sâu rộng chế độ đánh giá nghiên cứu khoa học mới là điều bắt buộc phải tiến hành.',
      '"改革势在必行" thể hiện quyết tâm chính trị mạnh mẽ tháo gỡ điểm nghẽn cho giới nghiên cứu.'
    );

  -- Điểm ngữ pháp #53: Cấu trúc tình thế nguy cấp sát sườn "迫在眉睫" (Cấp bách trước mắt / Nước sôi lửa bỏng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tình thế nguy cấp sát sườn "迫在眉睫" (Cấp bách trước mắt / Nước sôi lửa bỏng)',
    'Nhiệm vụ / Hiểm họa / Vấn đề + 迫在眉睫',
    'Cấu trúc cố định',
    '"迫在眉睫" (pò zài méijié) là thành ngữ ngữ pháp hóa miêu tả tình huống khẩn cấp đến mức lửa cháy sát tới tận lông mày và lông mi (gần ngay trước mắt, ngàn cân treo sợi tóc, vô cùng cấp bách).',
    'HSK 6',
    53,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '洪水即将漫过堤坝，紧急转移低洼地带数万被困群众的任务迫在眉睫。',
      'Hóngshuǐ jíjiāng mànguò dībà, jǐnjí zhuǎnyí dīwā dìdài shù wàn bèikùn qúnzhòng de rènwu pòzàiméijié.',
      'Nước lũ sắp sửa tràn qua mặt đê, nhiệm vụ khẩn cấp sơ tán hàng vạn quần chúng đang mắc kẹt ở vùng trũng thấp đang cấp bách trước mắt.',
      '"任务迫在眉睫" đặc tả tính chất sinh tử của nhiệm vụ sơ tán lũ lụt từng giây từng phút.'
    ),
    (
      v_gp_id,
      '全球生物多样性急剧衰退的危机迫在眉睫，国际社会必须立即采取联合拯救行动。',
      'Quánqiú shēngwù duōyàngxìng jíjù shuāituì de wēijī pòzàiméijié, guójì shèhuì bìxū lìjí cǎiqǔ liánhé zhěngjiù xíngdòng.',
      'Cuộc khủng hoảng suy thoái nghiêm trọng của đa dạng sinh học toàn cầu đang cấp bách ngay trước mắt, cộng đồng quốc tế bắt buộc phải hành động giải cứu phối hợp ngay tức thì.',
      '"危机迫在眉睫" thôi thúc toàn cầu chung tay ngăn chặn thảm họa tuyệt chủng sinh vật.'
    );

  -- Điểm ngữ pháp #54: Cấu trúc trọng lượng chi phối cán cân cục diện "举足轻重" (Có sức nặng quyết định / Cân bằng cục diện)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc trọng lượng chi phối cán cân cục diện "举足轻重" (Có sức nặng quyết định / Cân bằng cục diện)',
    'Chủ ngữ + 在...中起着 / 占据着 + 举足轻重的地位 / 作用',
    'Cấu trúc cố định',
    '"举足轻重" (jǔzúqīngzhòng) có nguồn gốc từ binh thư cổ đại: mỗi bước chân di chuyển của một thế lực đều làm lệch cán cân sức mạnh của toàn cuộc diện. Dùng để chỉ một nhân vật, quốc gia hoặc ngành công nghiệp có vai trò rường cột, mang tính quyết định chi phối đại cục (giữ vị trí then chốt, nhất cử nhất động làm rung chuyển cục diện).',
    'HSK 6',
    54,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '芯片制造业作为现代数字经济的心脏，在全球高科技产业链中具有举足轻重的战略地位。',
      'Xīnpiàn zhìzàoyè zuòwéi xiàndài shùzì jīngjì de xīnzàng, zài quánqiú gāo kējì chǎnyèliàn zhōng jùyǒu jǔzúqīngzhòng de zhànlüè dìwèi.',
      'Ngành sản xuất chip bán dẫn với tư cách là trái tim của nền kinh tế số hiện đại có vị thế chiến lược mang tính quyết định chi phối trong chuỗi ngành công nghệ cao toàn cầu.',
      '"具有举足轻重的战略地位" làm rõ vai trò yết hầu của vi mạch điện tử trong thế giới hiện đại.'
    ),
    (
      v_gp_id,
      '他在该跨国并购案中凭借深厚的法律造诣和谈判技巧，起到了举足轻重的关键推动作用。',
      'Tā zài gāi kuàguó bìnggòu''àn zhōng píngjiè shēnhòu de fǎlǜ zàoyì hé tánpàn jìqiǎo, qǐdào le jǔzúqīngzhòng de guānjiàn tuīdòng zuòyòng.',
      'Anh ấy trong thương vụ sáp nhập xuyên quốc gia này nhờ vào học vấn pháp lý thâm sâu và kỹ năng đàm phán đã đóng vai trò then chốt có sức nặng quyết định thúc đẩy thành công.',
      '"起到了举足轻重的作用" ca ngợi tài năng đàm phán xoay chuyển cục diện của luật sư trưởng.'
    );

  -- Điểm ngữ pháp #55: Cấu trúc liên hệ hữu cơ sống còn "息息相关" (Liên quan mật thiết / Hơi thở liền kề)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc liên hệ hữu cơ sống còn "息息相关" (Liên quan mật thiết / Hơi thở liền kề)',
    'A 与 / 和 B + 息息相关 (như hơi thở gắn liền sự sống)',
    'Cấu trúc cố định',
    '"息息相关" (xīxī xiāngguān) kết hợp chữ "息" (hơi thở), biểu thị hai sự vật gắn bó chặt chẽ với nhau tới mức từng nhịp thở đều hòa làm một, lợi hại tương quan mật thiết không thể tách rời (liên quan mật thiết, gắn bó máu thịt).',
    'HSK 6',
    55,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '物价稳定和食品安全直接关系到千家万户的切身福祉，与人民群众的幸福感息息相关。',
      'Wùjià wěndìng hé shípǐn ānquán zhíjiē guānxì dào qiānjiāwànhù de qiēshēn fúzhǐ, yǔ rénmín qúnzhòng de xìngfúgǎn xīxīxiāngguān.',
      'Giá cả ổn định và an toàn thực phẩm liên quan trực tiếp tới phúc lợi thiết thân của hàng vạn gia đình, gắn bó mật thiết tới cảm giác hạnh phúc của quần chúng nhân dân.',
      '"与...幸福感息息相关" nêu rõ mối quan hệ khăng khít giữa kinh tế đời sống và chỉ số hạnh phúc xã hội.'
    ),
    (
      v_gp_id,
      '生态环境质量的好坏，与整个人类社会未来的可持续繁衍息息相关。',
      'Shēngtài huánjìng zhìliàng de hǎohuài, yǔ zhěng gè rénlèi shèhuì wèilái de kěchíxù fányǎn xīxīxiāngguān.',
      'Chất lượng môi trường sinh thái tốt hay xấu gắn bó mật thiết với sự sinh sôi phát triển bền vững tương lai của toàn bộ xã hội loài người.',
      '"与...繁衍息息相关" liên kết sự bảo vệ tự nhiên với tương lai tồn vong của giống nòi nhân loại.'
    );

  -- Điểm ngữ pháp #56: Cấu trúc chia ngọt sẻ bùi đồng cam cộng khổ "休戚与共" (Cùng chung chia sẻ buồn vui / Hoạn nạn có nhau)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc chia ngọt sẻ bùi đồng cam cộng khổ "休戚与共" (Cùng chung chia sẻ buồn vui / Hoạn nạn có nhau)',
    'A 与 B + 形成 / 建设 + 休戚与共的命运共同体',
    'Cấu trúc cố định',
    '"休戚与共" (xiūqī yǔgòng) kết hợp chữ "休" (điều mừng, hoan lạc) và "戚" (nỗi buồn, hoạn nạn), mang ý nghĩa cùng nhau chia sẻ mọi niềm vui lẫn nỗi buồn, kề vai sát cánh sống chết có nhau trong cùng một vận mệnh (đồng cam cộng khổ, hoạn nạn chia bùi). Mẫu câu chuẩn mực xây dựng "Cộng đồng chung vận mệnh nhân loại".',
    'HSK 6',
    56,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在这个全球深度互联的信息时代，世界各国同乘一条大船，早已结成了休戚与共的命运共同体。',
      'Zài zhè ge quánqiú shēndù hùlián de xìnxī shídài, shìjiè gèguó tóng chéng yì tiáo dàchuán, zǎoyǐ jiéchéng le xiūqīyǔgòng de mìngyùn gòngtóngtǐ.',
      'Trong thời đại thông tin kết nối sâu sắc toàn cầu này, các quốc gia trên thế giới cùng ngồi chung một con thuyền lớn, từ lâu đã kết thành một cộng đồng chung vận mệnh đồng cam cộng khổ.',
      '"休戚与共的命运共同体" là khẩu hiệu ngoại giao toàn cầu thể hiện tính tương trợ quốc tế.'
    ),
    (
      v_gp_id,
      '军民休戚与共、生死相依的光荣传统，是我们战胜一切艰难险阻的最坚固长城。',
      'Jūnmín xiūqīyǔgòng, shēngsǐxiāngyī de guāngróng chuántǒng, shì wǒmen zhànshèng yíqiè jiānnánxiǎnzǔ de zuì jiāngù chángchéng.',
      'Truyền thống vẻ vang quân dân đồng cam cộng khổ, sống chết có nhau chính là bức Vạn Lý Trường Thành vững chắc nhất giúp chúng ta chiến thắng mọi gian nan hiểm trở.',
      '"军民休戚与共" ca ngợi tình cảm gắn bó keo sơn như cá với nước giữa quân đội và nhân dân.'
    );

  -- Điểm ngữ pháp #57: Cấu trúc cố định tổng kết văn kiện chính thức: "综上所述"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định tổng kết văn kiện chính thức: "综上所述"',
    'Phân tích các luận điểm chi tiết. 综上所述, Kết luận quy nạp toàn diện',
    'Cấu trúc cố định',
    '"综上所述" (zōng shàng suǒ shù) kết hợp chữ 综 (tổng hợp), 上 (ở trên), 所述 (những điều đã trình bày), mang nghĩa "tổng hợp lại toàn bộ những sự thật, số liệu và lập luận đã được nêu ra ở các đoạn trên". Là từ mở màn đoạn kết chuẩn mực tuyệt đối trong luận án tiến sĩ, báo cáo kiểm toán và bản cáo trạng tòa án.',
    'HSK 6',
    57,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '综上所述，该研发项目不仅技术路径完全可行，而且预期经济效益显著，建议董事会立即批准立项。',
      'Zōngshàngsuǒshù, gāi yánfā xiàngmù bùjǐn jìshù lùjìng wánquán kěxíng, érqiě yùqī jīngjì xiàoyì xiǎnzhù, jiànyì dǒngshìhuì lìjí pīzhǔn lìxiàng.',
      'Tổng hợp những điều đã trình bày ở trên, dự án nghiên cứu phát triển này không chỉ có lộ trình công nghệ hoàn toàn khả thi, mà hiệu quả kinh tế kỳ vọng lại hết sức rõ rệt, kiến nghị hội đồng quản trị lập tức phê chuẩn khởi động dự án.',
      '"综上所述..." đúc kết thẩm định dự án thuyết phục đưa ra kiến nghị quyết sách đầu tư.'
    ),
    (
      v_gp_id,
      '综上所述，原告提交的各项证据确凿充分，被告侵犯商业机密的事实清楚，应当承担全部民事赔偿责任。',
      'Zōngshàngsuǒshù, yuángào tíjiāo de gè xiàng zhèngjù quèzáo chōngfèn, bèigào qīnfàn shāngyè jīmì de shìshí qīngchu, yīngdāng chéngdān quánbù mínshì péicháng zérèn.',
      'Tổng hợp lại những điều đã trình bày ở trên, các bằng chứng mà nguyên đơn nộp lên là xác thực đầy đủ, sự thật bị đơn xâm phạm bí mật thương mại là rõ ràng, phải chịu toàn bộ trách nhiệm bồi thường dân sự.',
      '"综上所述..." là lời luận tội và lập luận kết án mẫu mực của luật sư trong phiên tòa dân sự.'
    );

  -- Điểm ngữ pháp #58: Cấu trúc cố định dẫn chiếu tài liệu đính kèm: "详见附录 / 详见下文"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định dẫn chiếu tài liệu đính kèm: "详见附录 / 详见下文"',
    'Khái quát ngắn gọn (详见附录 A / 具体技术参数详见下文表格)',
    'Cấu trúc cố định',
    '"详见" (xiángjiàn) kết hợp chữ "详" (chi tiết, tường tận) và "见" (xem, tra cứu), dùng trong các văn bản học thuật khoa học, tài liệu kỹ thuật hoặc phụ lục hợp đồng để hướng dẫn người đọc tra cứu bảng biểu dữ liệu chi tiết (xem chi tiết tại phụ lục / xem cụ thể ở phần văn bản bên dưới).',
    'HSK 6',
    58,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '关于本次实验的具体化学试剂配比及安全操作细则，详见本报告附录三。',
      'Guānyú běn cì shíyàn de jùtǐ huàxué shìjì pèibǐ jí ānquán cāozuò xìzé, xiángjiàn běn bàogào fùlù sān.',
      'Về tỷ lệ pha chế hóa chất cụ thể và quy tắc thao tác an toàn của thí nghiệm lần này, xem chi tiết tại Phụ lục 3 của báo cáo này.',
      '"详见本报告附录三" chỉ dẫn nguồn dữ liệu kỹ thuật chuẩn xác trong văn bản khoa học.'
    ),
    (
      v_gp_id,
      '各类参赛作品的投稿规格要求及评奖评分细则，详见大赛官方网站下文通告。',
      'Gèlèi cànsài zuòpǐn de tóugǎo guīgé yāoqiú jí píngjiǎng píngfēn xìzé, xiángjiàn dàsài guānfāng wǎngzhàn xiàwén tōnggào.',
      'Yêu cầu quy chuẩn gửi bài dự thi của các thể loại tác phẩm cùng chi tiết chấm điểm trao giải, xin xem chi tiết thông báo bên dưới trên trang web chính thức của cuộc thi.',
      '"详见...下文通告" hướng dẫn thí sinh theo dõi chi tiết thể lệ cuộc thi.'
    );

  -- Điểm ngữ pháp #59: Cấu trúc văn ngôn đúc kết bài học lịch sử "鉴往知来" (Soi xét quá khứ thấu hiểu tương lai)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc văn ngôn đúc kết bài học lịch sử "鉴往知来" (Soi xét quá khứ thấu hiểu tương lai)',
    '鉴往知来, Chủ ngữ + Cần phải tổng kết kinh nghiệm lịch sử',
    'Cấu trúc cố định',
    '"鉴往知来" (jiàn wǎng zhī lái) kết hợp chữ 鉴 (soi gương, xem xét), 往 (quá khứ), 知 (biết), 来 (tương lai), mang ý nghĩa lấy lịch sử quá khứ làm tấm gương soi chiếu để rút ra bài học kinh nghiệm dẫn đường cho tương lai (ôn nghèo nhớ khổ, soi xưa đoán nay). Thường dùng trong các thông điệp giáo dục truyền thống.',
    'HSK 6',
    59,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '历史是最好的教科书，我们只有鉴往知来，才能在复兴的新征程上行稳致远。',
      'Lìshǐ shì zuì hǎo de jiàokēshū, wǒmen zhǐyǒu jiànwǎngzhīlái, cái néng zài fùxīng de xīn zhēngchéng shang xíngwěnzhìyuǎn.',
      'Lịch sử là cuốn sách giáo khoa tốt nhất, chúng ta chỉ khi biết soi xét quá khứ để định hướng tương lai thì mới có thể vững bước tiến xa trên chặng đường phục hưng mới.',
      '"鉴往知来，行稳致远" là cặp đối ngữ chính luận lịch sử kinh điển định hướng cho tương lai.'
    ),
    (
      v_gp_id,
      '回顾人类历次公共卫生危机的演变规律，鉴往知来，对于完善当代全球疾病防控体系具有重大启示。',
      'Huígù rénlèi lìcì gōnggòng wèishēng wēijī de yǎnbiàn guīlǜ, jiànwǎngzhīlái, duìyú wánshàn dāngdài quánqiú jíbìng fángkòng tǐxì jùyǒu zhòngdà qǐshì.',
      'Nhìn lại quy luật diễn biến của các cuộc khủng hoảng y tế công cộng qua các thời kỳ của nhân loại, soi xét quá khứ để hiểu tương lai có gợi mở to lớn đối với việc hoàn thiện hệ thống phòng chống dịch bệnh toàn cầu đương đại.',
      '"鉴往知来" đúc kết bài học dịch tễ học lịch sử để ứng phó với đại dịch tương lai.'
    );

  -- Điểm ngữ pháp #60: Cấu trúc cố định trạng thái chờ hoàn thiện: "有待于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định trạng thái chờ hoàn thiện: "有待于"',
    'Vấn đề phức tạp + 尚 / 仍 + 有待于 + Động từ song âm tiết (解决 / 验证 / 考证 / 澄清 / 完善)',
    'Cấu trúc cố định',
    '"有待于" (yǒudàiyú) kết hợp chữ 有待 (còn chờ đợi, còn cần phải) và 于 (đối với), mang nghĩa một vấn đề học thuật hoặc vướng mắc xã hội hiện tại vẫn chưa hoàn tất, còn cần phải tiếp tục nghiên cứu, thẩm định hoặc nỗ lực giải quyết thêm trong tương lai (còn cần phải, vẫn còn đợi). Thường đi kèm với phó từ "尚" hoặc "仍".',
    'HSK 6',
    60,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '尽管初步临床试验展现出了良好效果，但该药品的长期安全性仍有待于更大样本的跟踪验证。',
      'Jǐnguǎn chūbù línchuáng shìyàn zhǎnxiàn chū le liánghǎo xiàoguǒ, dàn gāi yàopǐn de chángqī ānquánxìng réng yǒudàiyú gèng dà yàngběn de gēnzōng yànzhèng.',
      'Tuy rằng thử nghiệm lâm sàng bước đầu đã bộc lộ hiệu quả khả quan, nhưng độ an toàn lâu dài của dược phẩm này vẫn còn cần phải theo dõi xác chứng với quy mô mẫu lớn hơn.',
      '"仍有待于...跟踪验证" thể hiện đạo đức khoa học thận trọng nghiêm ngặt của ngành y dược.'
    ),
    (
      v_gp_id,
      '出土竹简中记录的这几条古老律法条文的确切含义，学术界尚有待于进一步深入考证。',
      'Chūtǔ zhújiǎn zhōng jìlù de zhè jǐ tiáo gǔlǎo lǜfǎ tiáowén de quèqiè hányì, xuéshùjiè shàng yǒudàiyú jìnyíbù shēnrù kǎozhèng.',
      'Ý nghĩa chuẩn xác của mấy điều khoản luật pháp cổ xưa ghi trên thẻ tre khai quật được, giới học thuật vẫn còn phải chờ đợi sự khảo cứu sâu hơn nữa.',
      '"尚有待于进一步考证" xác lập tính mở trong công tác nghiên cứu khảo cổ học.'
    );

  -- Điểm ngữ pháp #61: Cấu trúc cố định cống hiến tâm sức trọn vẹn: "致力于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định cống hiến tâm sức trọn vẹn: "致力于"',
    'Chủ ngữ + 长期 / 始终 + 致力于 + Sự nghiệp vĩ đại / Mục tiêu cao cả',
    'Cấu trúc cố định',
    '"致力于" (zhìlìyú) kết hợp chữ "致" (dốc hết, tận lực), "力" (sức lực) và "于", mang nghĩa cống hiến toàn bộ tâm trí, sức lực và thời gian vào việc theo đuổi một sự nghiệp cao cả, hòa bình, khoa học hoặc giáo dục (hết lòng dốc sức vào, tận tâm cống hiến cho).',
    'HSK 6',
    61,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这位诺贝尔和平奖得主毕生致力于消除全球贫困与促进跨文明平等对话。',
      'Zhè wèi Nuòbèi''ěr hépíngjiǎng dézhǔ bìshēng zhìlìyú xiāochú quánqiú pínkùn yǔ cùjìn kuà wénmíng píngděng duìhuà.',
      'Chủ nhân giải Nobel Hòa bình này suốt cả đời đã hết lòng dốc sức vào sự nghiệp xóa đói giảm nghèo toàn cầu và thúc đẩy đối thoại bình đẳng xuyên các nền văn minh.',
      '"毕生致力于..." ca ngợi lý tưởng nhân đạo cao cả dâng hiến trọn đời vì hòa bình nhân loại.'
    ),
    (
      v_gp_id,
      '中国政府始终坚定不移地致力于维护多边主义国际秩序与促进共同繁荣。',
      'Zhōngguó zhèngfǔ shǐzhōng jiāndìngbùyí de zhìlìyú wéihù duōbiānzhǔyì guójì zhìxù yǔ cùjìn gòngtóng fánróng.',
      'Chính phủ Trung Quốc luôn kiên định không dời dốc sức vào việc bảo vệ trật tự quốc tế chủ nghĩa đa phương và thúc đẩy sự phồn vinh chung.',
      '"致力于维护...秩序" là lời cam kết ngoại giao cấp cao nhất về trách nhiệm nước lớn.'
    );

  -- Điểm ngữ pháp #62: Động từ/Cấu trúc cố định chứng nhân lịch sử: "见证了"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Động từ/Cấu trúc cố định chứng nhân lịch sử: "见证了"',
    'Di tích / Thế hệ tiền bối / Công trình + 见证了 + Biến thiên lịch sử / Kỳ tích',
    'Cấu trúc cố định',
    '"见证" (jiànzhèng) là động từ cao cấp chỉ việc một nhân vật, một tòa nhà di tích lịch sử hoặc một dòng sông đã tận mắt chứng kiến, ghi dấu lại toàn bộ sự biến đổi thăng trầm hoặc sự ra đời của những kỳ tích vĩ đại qua năm tháng (làm nhân chứng, chứng kiến sự ra đời).',
    'HSK 6',
    62,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这座横跨长江的现代化大桥不仅连通了两岸交通，更见证了中国基建工业腾飞的奇迹历程。',
      'Zhè zuò héngkuà Chángjiāng de xiàndàihuà dàqiáo bùjǐn liántōng le liǎng''àn jiāotōng, gèng jiànzhèng le Zhōngguó jījiàn gōngyè téngfēi de qíjì lìchéng.',
      'Cây cầu lớn hiện đại bắc qua sông Trường Giang này không chỉ kết nối giao thông hai bên bờ, mà càng chứng kiến chặng đường kỳ tích cất cánh của ngành công nghiệp xây dựng hạ tầng Trung Quốc.',
      '"见证了...奇迹历程" nhân hóa cây cầu thành chứng nhân sống động cho sự trỗi dậy của đất nước.'
    ),
    (
      v_gp_id,
      '几代地质勘探队员扎根荒原六十年，亲眼见证了这片不毛之地崛起为现代化石油新城的沧桑巨变。',
      'Jǐ dài dìzhì kāntàn duìyuán zhāgēn huāngyuán liùshí nián, qīnyǎn jiànzhèng le zhè piàn bùmáozhīdì juéqǐ wéi xiàndàihuà shíyóu xīnchéng de cāngsāngjùbiàn.',
      'Mấy thế hệ cán bộ thăm dò địa chất cắm rễ nơi hoang mạc suốt 60 năm, tận mắt chứng kiến sự đổi thay dâu bể của vùng đất không ngọn cỏ này vươn mình thành một đô thị dầu khí hiện đại.',
      '"见证了...沧桑巨变" ca ngợi công lao của những người mở đường khai phá mỏ dầu.'
    );

  -- Điểm ngữ pháp #63: Giới từ văn ngôn chỉ địa điểm nơi chốn "于" (Ở / Tại / Nơi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ văn ngôn chỉ địa điểm nơi chốn "于" (Ở / Tại / Nơi)',
    'Động từ + 于 + Địa điểm không gian (生于 / 处于 / 止于 / 见于 / 位于)',
    'Giới từ',
    '"于" (yú) là giới từ văn ngôn đa năng quan trọng nhất trong tiếng Hán. Khi chỉ không gian, "于" đứng sau động từ tương đương với "在" (ở, tại, nơi). Thường gặp: 生于 (sinh tại), 位于 (tọa lạc tại), 处于 (đang ở vào thế), 见于 (thấy xuất hiện tại sách báo/di tích).',
    'HSK 6',
    63,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这位享誉海内外的著名物理学家出生于江苏无锡的一个书香门第。',
      'Zhè wèi xiǎngyù hǎinèiwài de zhùmíng wùlǐxuéjiā chūshēng yú Jiāngsū Wúxī de yí gè shūxiāngméndì.',
      'Vị nhà vật lý học nổi tiếng danh thơm trong ngoài nước này sinh ra tại một gia đình dòng dõi thư hương ở Vô Tích, Giang Tô.',
      '"出生于..." dùng "于" làm giới từ chỉ nơi chốn nơi vị khoa học gia cất tiếng khóc chào đời.'
    ),
    (
      v_gp_id,
      '当前世界经济正处于深刻转型的关键十字路口，面临诸多不确定因素。',
      'Dāngqián shìjiè jīngjì zhèng chǔyú shēnkè zhuǎnxíng de guānjiàn shízìlùkǒu, miànlín zhūduō bùquèdìngxìng yīnsù.',
      'Kinh tế thế giới hiện nay đang ở vào ngã tư đường then chốt của sự chuyển dịch sâu sắc, đối mặt với muôn vàn nhân tố bất định.',
      '"处于...十字路口" là hình ảnh ẩn dụ không gian vị thế của cục diện kinh tế toàn cầu.'
    );

  -- Điểm ngữ pháp #64: Giới từ văn ngôn chỉ thời gian & khởi điểm "于" (Vào lúc / Bắt đầu từ / Đến lúc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ văn ngôn chỉ thời gian & khởi điểm "于" (Vào lúc / Bắt đầu từ / Đến lúc)',
    '于 + Thời gian / Động từ + 于 + Thời điểm lịch sử (始于 / 终于 / 成立于)',
    'Giới từ',
    '"于" (yú) đứng trước hoặc sau các mốc thời gian lịch sử tương đương với "在...的时候" (vào năm, vào ngày). Thường dùng: 始于 (bắt đầu từ), 终于 (kết thúc vào), 成立于 (được thành lập vào năm).',
    'HSK 6',
    64,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '中华文明源远流长，其农耕文明的发轫最早可追溯于数千年前的仰韶文化时期。',
      'Zhōnghuá wénmíng yuányuǎnliúcháng, qí nónggēng wénmíng de fārèn zuì zǎo kě zhuīsù yú shù qiān nián qián de Yǎngsháo wénhuà shíqī.',
      'Văn minh Trung Hoa nguồn xa dòng dài, sự khởi đầu của nền văn minh nông nghiệp của nó sớm nhất có thể ngược dòng về thời kỳ văn hóa Ngưỡng Thiều cách đây mấy nghìn năm.',
      '"追溯于...时期" dùng "于" dẫn ra mốc khởi điểm xa xưa của nền văn minh lúa nước.'
    ),
    (
      v_gp_id,
      '中国自主设计建造的第一座核电站于一九九一年底顺利并网发电。',
      'Zhōngguó zìzhǔ shèjì jiànzào de dì yī zuò hédiànzhàn yú yījiǔjiǔyī niándǐ shùnlì bìngwǎng fādiàn.',
      'Nhà máy điện hạt nhân đầu tiên do Trung Quốc tự chủ thiết kế xây dựng đã thuận lợi hòa lưới phát điện vào cuối năm 1991.',
      '"于一九九一年底" làm trạng ngữ chỉ mốc thời gian lịch sử trọng đại trong công nghiệp năng lượng.'
    );

  -- Điểm ngữ pháp #65: Giới từ văn ngôn chỉ đối tượng tiếp nhận & hướng tới "于" (Đối với / Hướng về / Cho)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ văn ngôn chỉ đối tượng tiếp nhận & hướng tới "于" (Đối với / Hướng về / Cho)',
    'Động từ + 于 + Đối tượng (忠于 / 善于 / 勇于 / 归咎于 / 寄希望于)',
    'Giới từ',
    '"于" (yú) đứng sau các tính từ hoặc động từ tâm lý để dẫn ra đối tượng được hướng tới hoặc tiếp nhận hành vi, tương đương với "对" hoặc "向" (đối với ai, hướng tới ai). Thường gặp: 忠于祖国 (trung với tổ quốc), 善于思考 (giỏi suy nghĩ), 寄希望于青年 (đặt kỳ vọng vào giới trẻ).',
    'HSK 6',
    65,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '全体国家工作人员必须时刻牢记宪法誓言，始终忠于祖国、忠于人民、恪尽职守。',
      'Quántǐ guójiā gōngzuò rényuán bìxū shíkè láojì xiànfǎ shìyán, shǐzhōng zhōngyú zǔguó, zhōngyú rénmín, kèjìnzhíshǒu.',
      'Toàn thể cán bộ công chức nhà nước phải luôn ghi nhớ lời tuyên thệ hiến pháp, luôn luôn trung thành với tổ quốc, trung thành với nhân dân, tận tụy mẫn cán với chức trách.',
      '"忠于祖国、忠于人民" dùng "于" dẫn ra hai đối tượng phụng sự tối cao của người làm công bộc.'
    ),
    (
      v_gp_id,
      '中华民族的伟大复兴与科技自立自强，寄希望于朝气蓬勃的新一代青年学子。',
      'Zhōnghuá mínzú de wěidà fùxīng yǔ kējì zìlìzìqiáng, jì xīwàng yú zhāoqìpéngbó de xīn yídài qīngnián xuézǐ.',
      'Sự phục hưng vĩ đại và tinh thần tự lực tự cường khoa học công nghệ của dân tộc Trung Hoa gửi gắm hy vọng vào thế hệ học sinh sinh viên trẻ tuổi tràn đầy sức sống.',
      '"寄希望于..." thể hiện sự trao gửi niềm tin và trọng trách lịch sử lên vai thế hệ măng non.'
    );

  -- Điểm ngữ pháp #66: Giới từ văn ngôn trong so sánh hơn "于" (Hơn / Vượt trội hơn)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ văn ngôn trong so sánh hơn "于" (Hơn / Vượt trội hơn)',
    'Tính từ / Động từ + 于 + Tiêu chuẩn so sánh (高于 / 大于 / 重于 / 优于 / 胜于)',
    'Giới từ',
    '"于" (yú) đứng sau tính từ tương đương với chữ "比" (hơn, vượt trội hơn so với). Đây là cấu trúc so sánh cổ xưa kinh điển: "青出于蓝而胜于蓝" (xanh từ chàm mà đậm hơn chàm), "人固有一死，或重于泰山，或轻于鸿毛" (người ta ai cũng một lần chết, có cái chết nặng hơn núi Thái Sơn, có cái chết nhẹ tựa lông hồng).',
    'HSK 6',
    66,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '人固有一死，或重于泰山，或轻于鸿毛，为人民利益而死，就比泰山还重。',
      'Rén gù yǒu yì sǐ, huò zhòng yú Tàishān, huò qīng yú hóngmáo, wèi rénmín lìyì ér sǐ, jiù bǐ Tàishān hái zhòng.',
      'Đời người ai chẳng có một lần chết, hoặc là chết nặng hơn núi Thái Sơn, hoặc là chết nhẹ hơn chiếc lông hồng, vì lợi ích của nhân dân mà hy sinh thì nặng hơn cả núi Thái Sơn.',
      '"重于泰山，轻于鸿毛" là danh ngôn tư tưởng Tư Mã Thiên dùng "于" so sánh nhân phẩm đỉnh cao.'
    ),
    (
      v_gp_id,
      '这家年轻企业生产的高精度光学传感器，在核心抗震性能指标上明显优于国外同类竞品。',
      'Zhè jiā niánqīng qǐyè shēngchǎn de gāojīngdù guāngxué chuángǎnqì, zài héxīn kàngzhèn xìngnéng zhǐbiāo shang míngxiǎn yōuyú guówài tónglèi jìngpǐn.',
      'Cảm biến quang học độ chính xác cao do doanh nghiệp trẻ này sản xuất trên các chỉ số tính năng chống rung cốt lõi vượt trội hơn hẳn các sản phẩm cạnh tranh cùng loại của nước ngoài.',
      '"优于国外竞品" dùng "优于" so sánh hơn làm nổi bật năng lực cạnh tranh công nghệ nội địa.'
    );

  -- Điểm ngữ pháp #67: Giới từ văn ngôn trong câu bị động "于" (Bị / Chịu sự tác động bởi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ văn ngôn trong câu bị động "于" (Bị / Chịu sự tác động bởi)',
    'Động từ + 于 + Tác nhân gây hại (见笑于 / 受制于 / 困于 / 败于)',
    'Giới từ',
    '"于" (yú) đứng sau động từ dẫn ra tác nhân gây ra hành động tương đương với chữ "被" (bị ai làm cho, chịu sự trói buộc của). Thường gặp: 见笑于大方之家 (bị các bậc uyên bác chê cười), 受制于人 (bị người khác kìm kẹp, chế ngự).',
    'HSK 6',
    67,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '核心技术如果不牢牢掌握在自己手里，国家的产业安全就随时可能受制于人。',
      'Héxīn jìshù rúguǒ bù láoláo zhǎowò zài zìjǐ shǒulǐ, guójiā de chǎnyè ānquán jiù suíshí kěnéng shòuzhìyúrén.',
      'Công nghệ cốt lõi nếu không nắm chắc trong tay mình thì an ninh ngành công nghiệp quốc gia bất cứ lúc nào cũng có thể bị kẻ khác khống chế kìm kẹp.',
      '"受制于人" là cấu trúc bị động văn ngôn cảnh báo hiểm họa của sự lệ thuộc công nghệ nước ngoài.'
    ),
    (
      v_gp_id,
      '在学术研究中如果不讲究严谨实证而信口开河，势必会见笑于真正的大方之家。',
      'Zài xuéshù yánjiū zhōng rúguǒ bù jiǎngjiu yánjǐn shízhèng ér xìnkǒukāihé, shìbì huì jiànxiào yú zhēnzhèng de dàfāngzhījiā.',
      'Trong nghiên cứu học thuật nếu không coi trọng thực chứng cẩn trọng mà nói năng tùy tiện, thế tất sẽ bị các bậc học giả uyên bác thực sự chê cười.',
      '"见笑于大方之家" kết hợp chữ "见" và "于" tạo thành mẫu câu bị động văn ngôn kinh điển.'
    );

  -- Điểm ngữ pháp #68: Giới từ văn ngôn phương thức & công cụ "以" (Dùng / Lấy / Bằng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ văn ngôn phương thức & công cụ "以" (Dùng / Lấy / Bằng)',
    '以 + Công cụ/Phương thức/Nguyên tắc + 为 + Trọng tâm/Mục tiêu (以科技为引擎 / 以人为本 / 以事实为依据)',
    'Giới từ',
    '"以" (yǐ) là giới từ văn ngôn nguồn cội chỉ phương tiện, căn cứ hoặc công cụ hành động, tương đương với "用" hoặc "拿" (lấy... làm..., dùng... để...). Thường xuất hiện trong cấu trúc triết luận chính trị tối cao: "以...为..." (lấy A làm B, coi A là B).',
    'HSK 6',
    68,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们的城市建设必须坚持以人为本，切实把居民的宜居度作为最重要的考核指标。',
      'Wǒmen de chéngshì jiànshè bìxū jiānchí yǐrénwéiběn, qièshí bǎ jūmín de yíjūdù zuòwéi zuì zhòngyào de kǎohé zhǐbiāo.',
      'Công cuộc xây dựng đô thị của chúng ta bắt buộc phải kiên trì lấy con người làm gốc, thiết thực coi mức độ đáng sống của cư dân là chỉ số đánh giá quan trọng nhất.',
      '"以人为本" là tôn chỉ nhân văn tối cao lấy hạnh phúc nhân dân làm gốc rễ phát triển.'
    ),
    (
      v_gp_id,
      '人民法院审理各类民刑案件，必须坚持以事实为依据、以法律为准绳的客观公正原则。',
      'Rénmín fǎyuàn shěnlǐ gèlèi mínxíng ànjiàn, bìxū jiānchí yǐ shìshí wéi yījù, yǐ fǎlǜ wéi zhǔnshéng de kèguān gōngzhèng yuánzé.',
      'Tòa án Nhân dân khi xét xử các loại án dân sự và hình sự bắt buộc phải kiên trì nguyên tắc khách quan công bằng lấy sự thật làm căn cứ, lấy pháp luật làm thước đo.',
      '"以事实为依据、以法律为准绳" là kim chỉ nam xét xử tư pháp chuẩn mực quốc gia.'
    );

  -- Điểm ngữ pháp #69: Giới từ/Liên từ mục đích văn ngôn "以" (Để / Nhằm / Nhằm mục đích)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ/Liên từ mục đích văn ngôn "以" (Để / Nhằm / Nhằm mục đích)',
    'Hành động tích cực, 以 + Đạt được mục tiêu (以期 / 以防 / 以飨 / 予以 / 以求)',
    'Giới từ',
    '"以" (yǐ) đứng giữa hai vế câu làm liên từ chỉ mục đích tương đương với "用来, 为了" (để, nhằm). Thường kết hợp trong các từ ghép chỉ mục đích: "以期" (nhằm hy vọng), "以防" (nhằm phòng ngừa), "以求" (nhằm mưu cầu).',
    'HSK 6',
    69,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '博物馆在暑假期间免费延长开放两小时，以期满足广大中小学生假期的文化需求。',
      'Bówùguǎn zài shǔjià qījiān miǎnfèi yáncháng kāifàng liǎng xiǎoshí, yǐqī mǎnzú guǎngdà zhōngxiǎoxuéshēng jiàqī de wénhuà xūqiú.',
      'Bảo tàng trong dịp nghỉ hè miễn phí kéo dài thời gian mở cửa thêm 2 tiếng, nhằm hy vọng đáp ứng nhu cầu văn hóa trong kỳ nghỉ của đông đảo học sinh.',
      '"以期满足..." nêu rõ mục đích xã hội cao đẹp của việc nới rộng giờ phục vụ công cộng.'
    ),
    (
      v_gp_id,
      '登山队员们在冰川营地储备了充足的氧气和高能食品，以防恶劣风雪天气封锁下山路线。',
      'Dēngshānduìyuánmen zài bīngchuān yíngdì chǔbèi le chōngzú de yǎngqì hé gāonéng shípǐn, yǐfáng èliè fēngxuě tiānqì fēngsuǒ xiàshān lùxiàn.',
      'Các thành viên đội leo núi đã dự trữ đầy đủ oxy và thực phẩm giàu năng lượng tại doanh trại sông băng, nhằm phòng ngừa thời tiết mưa tuyết khắc nghiệt phong tỏa tuyến đường xuống núi.',
      '"以防..." nêu rõ rủi ro cần phòng bị trước điều kiện thiên nhiên vùng núi tuyết.'
    );

  -- Điểm ngữ pháp #70: Cấu trúc giới từ xác lập tư cách đại diện: "以...身份 / 以...名义"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc giới từ xác lập tư cách đại diện: "以...身份 / 以...名义"',
    'Chủ ngữ + 以 + Tư cách/Danh nghĩa/Chức vụ + Động từ (出席 / 签署 / 呼吁 / 发表声明)',
    'Giới từ',
    '"以...身份" và "以...名义" dùng để xác lập tư cách pháp lý, địa vị xã hội hoặc danh nghĩa đại diện khi một cá nhân hoặc tổ chức tham gia hoạt động ngoại giao, ký kết hợp đồng hoặc công bố tuyên ngôn chính thức (với tư cách là, nhân danh).',
    'HSK 6',
    70,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这位资深外交官以联合国特别顾问的身份，出席了本次关于中东和平进程的国际会议。',
      'Zhè wèi zīshēn wàijiāoguān yǐ Liánhéguó tèbié gùwèn de shēnfèn, chūxí le běn cì guānyú Zhōngdōng hépíng jìnchéng de guójì huìyì.',
      'Vị nhà ngoại giao kỳ cựu này với tư cách là cố vấn đặc biệt của Liên Hợp Quốc đã tham dự hội nghị quốc tế lần này về tiến trình hòa bình Trung Đông.',
      '"以...身份出席" xác định tư cách đại diện phái đoàn quốc tế hợp pháp của nhà ngoại giao.'
    ),
    (
      v_gp_id,
      '他以全资控股企业法人的名义，与当地政府正式签署了总投资五十亿元的新能源汽车产业园合作协议。',
      'Tā yǐ quánzī kònggǔ qǐyè fǎrén de míngyì, yǔ dāngdì zhèngfǔ zhèngshì qiānshǔ le zǒng tóuzī wǔshí yì yuán de xīn néngyuán qìchē chǎnyèyuán hézuò xiéyì.',
      'Ông ấy nhân danh pháp nhân doanh nghiệp nắm giữ 100% vốn đã chính thức ký kết với chính quyền địa phương thỏa thuận hợp tác khu công nghiệp xe ô tô năng lượng mới với tổng vốn đầu tư 5 tỷ nhân dân tệ.',
      '"以...法人的名义" xác lập năng lực chủ thể ký kết hợp đồng kinh tế theo luật doanh nghiệp.'
    );

  -- Điểm ngữ pháp #71: Giới từ căn cứ chuẩn tắc trang trọng "依" (Căn cứ vào / Chiểu theo / Nương theo)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ căn cứ chuẩn tắc trang trọng "依" (Căn cứ vào / Chiểu theo / Nương theo)',
    '依 + Căn cứ/Ý kiến (依我之见 / 依法 / 依规 / 依此类推 / 依我看)',
    'Giới từ',
    '"依" (yī) là giới từ văn ngôn trang trọng mang nghĩa "căn cứ vào, chiểu theo, dựa trên cơ sở" (tương đương với 按照 hoặc 根据). Thường gặp trong các cấu trúc kinh điển: "依我之见" (theo thiển kiến của tôi), "依法治国" (quản lý đất nước theo pháp luật), "依此类推" (cứ theo loại này mà suy luận tiếp).',
    'HSK 6',
    71,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '依我之见，解决这一国际争端的唯一正途，依然在于通过平等坦诚的政治外交谈判。',
      'Yī wǒ zhī jiàn, jiějué zhè yì guójì zhēngduān de wéiyī zhèngtú, yīrán zàiyú tōngguò píngděng tǎnchéng de zhèngzhì wàijiāo tánpàn.',
      'Theo thiển kiến của tôi, con đường đúng đắn duy nhất để giải quyết tranh chấp quốc tế này vẫn nằm ở việc thông qua đàm phán chính trị ngoại giao bình đẳng và thẳng thắn.',
      '"依我之见" là cách mở đầu học thuật uyên bác đưa ra quan điểm phân tích thời sự sắc sảo.'
    ),
    (
      v_gp_id,
      '执法机关必须严格做到依法行政，绝不允许任何人在法定权限之外滥用权力。',
      'Zhífǎ jīguān bìxū yángé zuòdào yīfǎ xíngzhèng, jué bù yǔnxǔ rènhé rén zài fǎdìng quánxiàn zhīwài lànyòng quánlì.',
      'Cơ quan hành pháp bắt buộc phải thực hiện nghiêm ngặt hành chính theo đúng pháp luật, tuyệt đối không cho phép bất kỳ ai lạm dụng quyền lực ngoài quyền hạn luật định.',
      '"依法行政" dùng "依" xác lập nguyên tắc thượng tôn pháp luật trong quản lý nhà nước.'
    );

  -- Điểm ngữ pháp #72: Giới từ nhân duyên cơ hội & tùy biến "因" (Vì / Nhân cơ hội / Dựa theo sự khác biệt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ nhân duyên cơ hội & tùy biến "因" (Vì / Nhân cơ hội / Dựa theo sự khác biệt)',
    '因 + Điều kiện địa phương/con người/thời thế (因地制宜 / 因人而异 / 因势利导)',
    'Giới từ',
    '"因" (yīn) trong HSK 6 ngoài nghĩa nguyên nhân "vì" còn là giới từ chỉ phương thức tùy biến nương theo hoàn cảnh khách quan để hành động linh hoạt (dựa theo, tùy thuộc vào). Tạo thành các thành ngữ triết lý quản trị tuyệt đỉnh: "因地制宜" (tùy theo điều kiện địa phương mà đề ra giải pháp), "因人而异" (tùy từng người mà khác nhau), "因势利导" (nương theo thế mà dẫn dắt khéo léo).',
    'HSK 6',
    72,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '乡村振兴战略必须坚持因地制宜，绝不能脱离当地自然资源禀赋而盲目机械照搬别处模式。',
      'Xiāngcūn zhènxīng zhànlüè bìxū jiānchí yīndìzhìyí, jué bù néng tuōlí dāngdì zìrán zīyuán bǐngfù ér mángmù jīxiè zhàobān biéchù móshì.',
      'Chiến lược phục hưng nông thôn bắt buộc phải kiên trì căn cứ theo đặc thù từng địa phương, tuyệt đối không thể tách rời nguồn lực tài nguyên thiên nhiên sẵn có mà mù quáng sao chép máy móc mô hình nơi khác.',
      '"因地制宜" là nguyên tắc quản trị chiến lược phát triển kinh tế phù hợp với thổ nhưỡng.'
    ),
    (
      v_gp_id,
      '经验丰富的名医给患者开药方总是因人而异，精准把握每个人的体质特异性。',
      'Jīngyàn fēngfù de míngyī gěi huànzhě kāi yàofāng zǒngshì yīnrén''éryì, jīngzhǔn bǎwò měi gè rén de tǐzhì tèyìxìng.',
      'Bậc danh y giàu kinh nghiệm khi bốc đơn thuốc cho người bệnh luôn tùy theo thể trạng từng người mà biến hóa, nắm bắt chuẩn xác tính dị biệt thể chất của mỗi người.',
      '"因人而异" phản ánh triết lý y học cổ truyền điều trị cá thể hóa.'
    );

  -- Điểm ngữ pháp #73: Giới từ mượn cớ nương nhờ văn ngôn "藉 / 借" (Mượn cơ hội / Nhờ cậy / Nhằm)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ mượn cớ nương nhờ văn ngôn "藉 / 借" (Mượn cơ hội / Nhờ cậy / Nhằm)',
    'Chủ ngữ + 藉 / 借 + Cớ/Công cụ + 以 + Đạt được mục đích ngầm (藉以 / 藉此)',
    'Giới từ',
    '"藉" (jiè) là dạng chữ cổ của "借", khi làm giới từ mang nghĩa "mượn cớ, nương vào một cơ hội hay hình thức để đạt tới một mục đích cụ thể". Cấu trúc kinh điển: "藉以..." (nhằm lấy đó để...), "藉此机会" (nhân cơ hội này).',
    'HSK 6',
    73,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '不法分子企图藉虚构的投资项目非法集资，广大群众对此务必提高防范警惕。',
      'Bùfǎ fènzǐ qǐtú jiè xūgòu de tóuzī xiàngmù fēifǎ jízī, guǎngdà qúnzhòng duì cǐ wùbì tígāo fángfàn jǐngtì.',
      'Những phần tử bất chính mưu toan mượn các dự án đầu tư hư cấu để huy động vốn phi pháp, đông đảo quần chúng nhân dân đối với điều này nhất thiết phải nâng cao tinh thần cảnh giác phòng ngừa.',
      '"藉虚构的投资项目" dùng "藉" vạch trần vỏ bọc che đậy thủ đoạn lừa đảo tài chính.'
    ),
    (
      v_gp_id,
      '两国元首在峰会期间举行了非正式漫步茶叙，藉以增进私人互信与战略沟通。',
      'Liǎng guó yuánshǒu zài fēnghuì qījiān jǔxíng le fēizhèngshì mànbù cháxù, jièyǐ zēngjìn sīrén hùxìn yǔ zhànlüè gōutōng.',
      'Nguyên thủ hai nước trong thời gian hội nghị thượng đỉnh đã tiến hành cuộc đi dạo uống trà không chính thức, nhằm lấy đó làm cầu nối tăng cường sự tin cậy cá nhân và giao lưu chiến lược.',
      '"藉以增进..." thể hiện nghệ thuật ngoại giao mềm mại thắt chặt quan hệ quốc tế.'
    );

  -- Điểm ngữ pháp #74: Giới từ ngoại giao lễ nghi cùng đi "偕同" (Cùng đi với / Cùng với)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ ngoại giao lễ nghi cùng đi "偕同" (Cùng đi với / Cùng với)',
    'Lãnh đạo / VIP + 偕同 + Phu nhân / Quan chức cấp cao + Động từ (访华 / 抵达 / 出席)',
    'Giới từ',
    '"偕同" (xiétóng) là giới từ ngoại giao nhà nước cực kỳ trang trọng tương đương với "一起, 带着" (cùng với, dẫn theo), chuyên dùng khi đưa tin về nguyên thủ quốc gia hoặc thủ tướng đi công du cùng phu nhân hoặc đoàn đại biểu cấp cao (như 偕同夫人 - cùng phu nhân tới thăm).',
    'HSK 6',
    74,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '应国家主席邀请，法国总统偕同夫人于今日下午乘专机抵达北京开始进行国事访问。',
      'Yìng guójiā zhǔxí yāoqǐng, Fǎguó zǒngtǒng xiétóng fūrén yú jīnrì xiàwǔ chéng zhuānjī dǐdá Běijīng kāishǐ jìnxíng guóshì fǎngwèn.',
      'Nhận lời mời của Chủ tịch nước, Tổng thống Pháp cùng phu nhân đã đáp chuyên cơ tới Bắc Kinh vào chiều nay bắt đầu chuyến thăm cấp nhà nước.',
      '"总统偕同夫人" là nghi thức xưng hô ngoại giao nghi lễ nhà nước chuẩn mực trong bản tin đối ngoại.'
    ),
    (
      v_gp_id,
      '联合国秘书长偕同主要随行高级官员，亲赴灾区实地视察难民救援安置营地。',
      'Liánhéguó mìshūzhǎng xiétóng zhǔyào suíxíng gāojí guānyuán, qīnfù zāiqū shídì shìchá nànmín jiùyuán ānzhì yíngdì.',
      'Tổng thư ký Liên Hợp Quốc cùng các quan chức cấp cao tháp tùng chủ chốt đã đích thân tới vùng thiên tai khảo sát thực tế khu trại cứu trợ tái định cư người tị nạn.',
      '"偕同...高级官员" thể hiện sự nghiêm cẩn trong tường thuật chuyến công tác quốc tế.'
    );

  -- Điểm ngữ pháp #75: Liên từ tăng tiến quy mô vĩ mô "乃至" (Cho đến / Thậm chí đến mức)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ tăng tiến quy mô vĩ mô "乃至" (Cho đến / Thậm chí đến mức)',
    'Phạm vi hẹp / Nhỏ, 乃至 + Phạm vi rộng lớn / Toàn cầu (本省乃至全国 / 全国乃至全世界)',
    'Liên từ',
    '"乃至" (nǎizhì) là liên từ tăng tiến chính luận trang trọng tương đương với "甚至, 以及", dùng để mở rộng quy mô từ phạm vi một khu vực, một quốc gia nâng cấp lên tới tầm vóc toàn cầu, hoặc từ một cá nhân nâng lên cả nhân loại (cho đến tận, thậm chí đến).',
    'HSK 6',
    75,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这不仅关乎本地区的发展繁荣，更直接影响到亚洲乃至整个世界的长治久安。',
      'Zhè bùjǐn guānhū běn dìqū de fāzhǎn fánróng, gèng zhíjiē yǐngxiǎng dào Yàzhōu nǎizhì zhěng gè shìjiè de chángzhìjiǔ''ān.',
      'Điều này không chỉ liên quan tới sự phát triển phồn vinh của khu vực này, mà càng trực tiếp ảnh hưởng tới sự bình yên ổn định lâu dài của châu Á cho tới cả toàn thế giới.',
      '"亚洲乃至整个世界" nâng tầm ảnh hưởng an ninh từ cấp độ châu lục lên quy mô toàn cầu.'
    ),
    (
      v_gp_id,
      '该项原始创新成果的问世，必将深刻重塑当前行业格局乃至整个人类社会的生产方式。',
      'Gāi xiàng yuánshǐ chuàngxīn chéngguǒ de wènshì, bìjiāng shēnkè zhòngsù dāngqián hángyè géjú nǎizhì zhěng gè rénlèi shèhuì de shēngchǎn fāngshì.',
      'Sự ra đời của thành quả sáng tạo gốc này nhất định sẽ định hình lại sâu sắc cục diện ngành nghề hiện tại cho tới cả phương thức sản xuất của toàn thể xã hội loài người.',
      '"行业格局乃至人类社会" làm nổi bật sức tác động mang tính cách mạng của công nghệ mới.'
    );

  -- Điểm ngữ pháp #76: Liên từ bổ sung lý do văn ngôn "兼之" (Lại thêm / Vả lại / Huống hồ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ bổ sung lý do văn ngôn "兼之" (Lại thêm / Vả lại / Huống hồ)',
    'Nguyên nhân 1, 兼之 + Nguyên nhân 2 (phức tạp hơn) + Dẫn đến kết quả',
    'Liên từ',
    '"兼之" (jiānzhī) là liên từ văn ngôn cổ nhã tương đương với "加之" hoặc "况且", dùng ở đầu phân câu sau để bổ sung thêm một lý do khách quan phụ họa vào lý do trước, làm cho kết quả xảy ra càng thêm tất yếu và hợp lý (lại thêm vào đó, vả lại).',
    'HSK 6',
    76,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '山高路险车辆难行，兼之暴雨连绵道路塌方，救援队伍只能徒步艰难挺进震中。',
      'Shāngāo lùxiǎn chēliàng nánxíng, jiānzhī bàoyǔ liánmián dàolù tāfāng, jiùyuán duìwù zhǐ néng túbù jiānnán tǐngjìn zhènzhōng.',
      'Núi cao đường hiểm xe cộ khó đi, lại thêm mưa bão kéo dài sạt lở đường sá, đội cứu hộ chỉ đành đi bộ gian nan hành quân vào tâm chấn.',
      '"兼之暴雨连绵..." bổ sung thêm điều kiện thời tiết khắc nghiệt giải thích sự khó khăn của công tác cứu hộ.'
    ),
    (
      v_gp_id,
      '他自幼聪慧过人勤奋好学，兼之名师悉心指点点拨，年纪轻轻便在画坛崭露头角。',
      'Tā zìyòu cōnghuì guòrén qínfèn hàoxué, jiānzhī míngshī xīxīn zhǐdiǎn diǎnbō, niánjì qīngqīng biàn zài huàtán zhǎnlùtóujiǎo.',
      'Anh từ nhỏ đã thông minh hơn người lại chăm chỉ hiếu học, lại thêm được danh sư ân cần chỉ bảo khai sáng, tuổi đời còn trẻ đã sớm nổi danh trên thi họa đàn.',
      '"兼之名师悉心指点" kết hợp thiên bẩm cá nhân với sự chỉ dạy của thầy giỏi làm nên thành tài.'
    );

  -- Điểm ngữ pháp #77: Cấu trúc nối tiếp hành động bài bản "继之以..." (Nối tiếp theo bằng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc nối tiếp hành động bài bản "继之以..." (Nối tiếp theo bằng...)',
    'Giai đoạn 1 tiến hành, 继之以 + Biện pháp giai đoạn 2 hoàn thiện',
    'Cấu trúc cố định',
    '"继之以..." (jì zhī yǐ...) là cấu trúc văn ngôn cao cấp biểu thị sau khi một hành động ban đầu kết thúc, chủ thể lập tức tiếp nối bằng một hành động khác có tính kế thừa hoặc nâng cao hơn để hoàn thiện chu trình (nối tiếp bằng cái gì, tiếp theo sau đó là biện pháp gì).',
    'HSK 6',
    77,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在考古发掘中，专家们先是进行精细的表层泥土剥离，继之以高科技的三维数字化建模扫描。',
      'Zài kǎogǔ fājué zhōng, zhuānjiāmen xiān shì jìnxíng jīngxì de biǎocéng nítǔ bōlí, jì zhī yǐ gāokējì de sānwéi shùzìhuà jiànmó sǎomiáo.',
      'Trong công tác khai quật khảo cổ, các chuyên gia thoạt tiên tiến hành bóc tách tinh vi lớp đất mặt, nối tiếp theo đó bằng thao tác quét mô hình kỹ thuật số 3D công nghệ cao.',
      '"继之以三维建模" kết hợp tuần tự nhịp nhàng giữa phương pháp khảo cổ truyền thống và công nghệ số.'
    ),
    (
      v_gp_id,
      '对于受灾群众的救助，首先当保障饮食饮水等温饱问题，继之以全面的灾后心理疏导与家园重建。',
      'Duìyú shòuzāi qúnzhòng de jiùzhù, shǒuxiān dāng bǎozhàng yǐnshí yǐnshuǐ děng wēnbǎo wèntí, jì zhī yǐ quánmiàn de zāihòu xīnlǐ shūdǎo yǔ jiāyuán chóngjiàn.',
      'Đối với việc cứu trợ quần chúng vùng thiên tai, trước hết cần bảo đảm vấn đề no ấm ăn uống, tiếp nối sau đó bằng sự khai thông tâm lý sau thảm họa toàn diện và tái thiết quê hương.',
      '"继之以心理疏导..." phân định lộ trình cứu trợ từ vật chất cấp bách đến chăm sóc tinh thần lâu dài.'
    );

  -- Điểm ngữ pháp #78: Cấu trúc nhượng bộ văn ngôn chặt chẽ "虽...亦..." (Tuy... nhưng cũng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc nhượng bộ văn ngôn chặt chẽ "虽...亦..." (Tuy... nhưng cũng...)',
    '虽 + Điều kiện khó khăn / Nhỏ bé, 亦 + Vẫn giữ nguyên giá trị / Quyết tâm',
    'Liên từ',
    '"虽...亦..." (suī... yì...) là cặp từ nối nhượng bộ Hán ngữ cổ đại tương đương với "虽然...但也...", nhưng mang tính hàm súc, biền ngẫu ngắn gọn (tuy rằng... thì cũng vẫn cứ). Thường dùng trong các câu danh ngôn chí hướng, thơ văn tự sự.',
    'HSK 6',
    78,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '前行道路虽千难万险，我们亦当一往无前、义无反顾。',
      'Qiánxíng dàolù suī qiānnánwànxiǎn, wǒmen yì dāng yìwǎngwúqián, yìwúfǎngù.',
      'Con đường tiến bước phía trước tuy muôn vàn gian nan nguy hiểm, chúng ta cũng phải dũng cảm tiến lên, quyết không chùn bước.',
      '"虽千难万险，亦当一往无前" thể hiện khí phách anh hùng không sợ hiểm nguy.'
    ),
    (
      v_gp_id,
      '个人的力量虽微不足道，但若汇聚到集体的大潮之中，亦能激荡起磅礴的伟力。',
      'Gèrén de lìliàng suī wēibùzúdào, dàn ruò huìjù dào jítǐ de dàcháo zhīzhōng, yì néng jīdàng qǐ pángbó de wěilì.',
      'Sức mạnh của cá nhân tuy nhỏ bé không đáng kể, nhưng nếu hòa vào làn sóng chung của tập thể, cũng có thể tạo nên sức mạnh vĩ đại dạt dào.',
      '"虽微不足道...亦能..." khẳng định giá trị to lớn của tinh thần đoàn kết tập thể.'
    );

  -- Điểm ngữ pháp #79: Cấu trúc giả thiết tột bực văn ngôn "纵使...亦..." (Dẫu cho... cũng vẫn...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc giả thiết tột bực văn ngôn "纵使...亦..." (Dẫu cho... cũng vẫn...)',
    '纵使 + Giả thiết khắc nghiệt nhất, (主语) 亦 + Kiên định lập trường / Bất biến',
    'Liên từ',
    '"纵使...亦..." (zòngshǐ... yì...) tương đương với "即使...也...", nhưng mang phong vị cổ điển bi tráng. Đặt ra một giả thiết hiểm nguy hoặc bất lợi tột cùng để làm nổi bật ý chí sắt son không hề lay chuyển (cho dù là thế... thì vẫn cứ).',
    'HSK 6',
    79,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '纵使历经沧海桑田的岁月变迁，中华民族对和平安宁的向往亦从未改变。',
      'Zòngshǐ lìjīng cānghǎisāngtián de suìyuè biànqiān, Zhōnghuá mínzú duì hépíng ānníng de xiàngwǎng yì cóngwèi gǎibiàn.',
      'Dẫu cho trải qua những biến thiên năm tháng dâu bể khôn lường, khát vọng của dân tộc Trung Hoa đối với hòa bình an lành cũng chưa từng thay đổi.',
      '"纵使...亦从未改变" khẳng định ước mơ hòa bình thiên niên kỷ bất biến của dân tộc.'
    ),
    (
      v_gp_id,
      '纵使面临千夫所指的巨大舆论压力，追求客观真理的勇士亦绝不后退半步。',
      'Zòngshǐ miànlín qiānfūsuǒzhǐ de jùdà yúlùn yālì, zhuīqiú kèguān zhēnlǐ de yǒngshì yì jué bú hòutuì bàn bù.',
      'Dẫu cho đối mặt với áp lực dư luận khổng lồ vạn người chỉ trích, người dũng sĩ mưu cầu chân lý khách quan cũng tuyệt đối không lùi nửa bước.',
      '"纵使...亦绝不后退" ca ngợi lòng quả cảm bảo vệ chân lý trước định kiến thời đại.'
    );

  -- Điểm ngữ pháp #80: Cấu trúc lựa chọn khí tiết văn ngôn "宁...毋..." (Thà rằng... chứ không...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc lựa chọn khí tiết văn ngôn "宁...毋..." (Thà rằng... chứ không...)',
    '宁 + Chấp nhận mất mát vật chất, 毋 + Làm tổn hại đạo đức / Nguyên tắc',
    'Liên từ',
    '"宁...毋..." (nìng... wú...) là dạng văn ngôn cổ kính của "宁可...也不...", thể hiện thái độ dứt khoát thà chấp nhận hy sinh quyền lợi chứ quyết không làm điều trái đạo lý (chữ 毋 nghĩa là chớ, không). Danh ngôn kinh điển: "宁缺毋滥" (thà thiếu chứ không lấy ẩu, thà ít mà chất lượng).',
    'HSK 6',
    80,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '选拔高精尖专业人才必须秉持严格标准，宁缺毋滥，确保队伍的高质量。',
      'Xuǎnbá gāojīngjiān zhuānyè réncái bìxū bǐngchí yángé biāozhǔn, nìngquēwúlàn, quèbǎo duìwù de gāo zhìliàng.',
      'Tuyển chọn nhân tài chuyên môn đỉnh cao tinh hoa bắt buộc phải giữ vững tiêu chuẩn nghiêm ngặt, thà thiếu còn hơn chọn ẩu, bảo đảm chất lượng cao của đội ngũ.',
      '"宁缺毋滥" là tiêu chuẩn vàng rèn quân chọn tướng của các tập đoàn hàng đầu.'
    ),
    (
      v_gp_id,
      '学者撰写论文当求字字有据，宁慢毋错，严防浮躁虚假风气滋生。',
      'Xuézhě zhuànxiě lùnwén dāng qiú zìzìyǒujù, nìng màn wú cuò, yánfáng fúzào xūjiǎ fēngqì zīshēng.',
      'Học giả khi viết luận văn phải cầu từng chữ đều có chứng cớ, thà chậm chứ không được sai, nghiêm phòng thói bốc đồng giả dối nảy sinh.',
      '"宁慢毋错" răn dạy đức tính cẩn trọng tỉ mỉ từng chi tiết trong nghiên cứu học thuật.'
    );

  -- Điểm ngữ pháp #81: Cấu trúc tăng tiến phủ định văn phong học thuật "非但...而且..." (Chẳng những... mà còn...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tăng tiến phủ định văn phong học thuật "非但...而且..." (Chẳng những... mà còn...)',
    'Chủ ngữ + 非但 + Không bị cản trở, 而且 / 反而 + Phát triển mạnh mẽ hơn',
    'Liên từ',
    '"非但...而且..." (fēidàn... érqiě...) có chữ "非但" là dạng văn ngôn của "不但/不仅". Dùng trong các bài nghị luận chính trị xã hội để bác bỏ quan niệm nghi ngờ trước khi chỉ ra sự phát triển vượt bậc (chẳng những không... mà còn...).',
    'HSK 6',
    81,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '外部的风雨施压非但没有压垮中国经济的筋骨，而且倒逼我们加快了科技自主创新的步伐。',
      'Wàibù de fēngyǔ shīyā fēidàn méiyǒu yākuǎ Zhōngguó jīngjì de jīngǔ, érqiě dàobī wǒmen jiākuài le kējì zìzhǔ chuàngxīn de bùfá.',
      'Những áp lực gió mưa chèn ép từ bên ngoài chẳng những không đè bẹp được gân cốt của kinh tế Trung Quốc, mà còn ép chúng ta đẩy nhanh bước chân đổi mới sáng tạo tự chủ công nghệ.',
      '"非但没有...而且倒逼..." khẳng định sức bền nội tại và khả năng biến thách thức thành động lực.'
    ),
    (
      v_gp_id,
      '严格的环保监管标准非但没有降低企业的利润，而且促使其提前完成了产业智能化绿色升级。',
      'Yángé de huánbǎo jiānguǎn biāozhǔn fēidàn méiyǒu jiàngdī qǐyè de lìrùn, érqiě cùshǐ qí tíqián wánchéng le chǎnyè zhìnénghuà lǜsè shēngjí.',
      'Tiêu chuẩn giám sát bảo vệ môi trường nghiêm ngặt chẳng những không làm giảm lợi nhuận của doanh nghiệp, mà còn thúc đẩy doanh nghiệp hoàn thành sớm việc nâng cấp xanh thông minh hóa ngành nghề.',
      '"非但没有...而且促使..." giải tỏa hiểu lầm cho rằng bảo vệ môi trường kìm hãm lợi nhuận.'
    );

  -- Điểm ngữ pháp #82: Cấu trúc kiểm chứng xác thực giả định "果真...就..." (Nếu quả thật... thì...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc kiểm chứng xác thực giả định "果真...就..." (Nếu quả thật... thì...)',
    '果真 + Như dự đoán/thực tế, 主语 + 就 + Hành động tương ứng',
    'Liên từ',
    '"果真" (guǒzhēn) vừa là liên từ giả định vừa là phó từ xác thực, tương đương với "如果真的, 果然" (nếu quả thực đúng như vậy). Dùng khi muốn đưa ra một hành động, quyết định dựa trên điều kiện tình huống được kiểm chứng là hoàn toàn có thật.',
    'HSK 6',
    82,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '如果技术参数果真能达到实验室预设的标准，这项产品就完全具备了颠覆市场的潜力。',
      'Rúguǒ jìshù cānshù guǒzhēn néng dádào shíyànshì yùshè de biāozhǔn, zhè xiàng chǎnpǐn jiù wánquán jùbèi le diānfù shìchǎng de qiánlì.',
      'Nếu thông số kỹ thuật quả thực có thể đạt tới tiêu chuẩn dự kiến trong phòng thí nghiệm, sản phẩm này liền hoàn toàn hội tụ tiềm năng làm đảo lộn thị trường.',
      '"果真能达到...就具备..." đặt ra điều kiện kiểm định tính năng trước khi đánh giá tiềm năng thương mại.'
    ),
    (
      v_gp_id,
      '事情果真如你所说的那样顺利，我们明天就可以提前召开项目结项庆功会了。',
      'Shìqing guǒzhēn rú nǐ suǒ shuō de nàyàng shùnlì, wǒmen míngtiān jiù kěyǐ tíqián zhàokāi xiàngmù jiéxiàng qìnggōnghuì le.',
      'Sự việc nếu quả thật suôn sẻ đúng như lời cậu nói, chúng ta ngày mai liền có thể mở tiệc mừng công tổng kết dự án sớm hơn dự kiến rồi.',
      '"果真如你所说..." thể hiện sự kiểm chứng tin tức với niềm vui mừng chờ đón.'
    );

  -- Điểm ngữ pháp #83: Cấu trúc câu hỏi tu từ khuyên can "既然...何必..." (Đã... hà tất phải...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc câu hỏi tu từ khuyên can "既然...何必..." (Đã... hà tất phải...)',
    '既然 + Sự thật đã ngã ngũ rõ ràng, 又 / 也 + 何必 + Làm điều thừa thãi/tổn thương + 呢？',
    'Cấu trúc cố định',
    '"既然...何必..." (jìrán... hébì...) phối hợp liên từ tiền đề "既然" và phó từ phản vấn "何必", tạo thành mẫu câu khuyên can thấu tình đạt lý: đã là một sự thật hiển nhiên hoặc đôi bên đều đã hiểu rõ nhau, vậy thì cần gì phải so đo, tranh cãi hay làm khổ nhau làm gì nữa.',
    'HSK 6',
    83,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '既然双方都怀揣着真诚的合作愿望，又何必在枝节问题上寸土必争以致伤了和气呢？',
      'Jìrán shuāngfāng dōu huáichuǎizhe zhēnchéng de hézuò yuànwàng, yòu hébì zài zhījié wèntí shang cùntǔbìzhēng yǐzhì shāng le héqì ne?',
      'Đã đôi bên đều ấp ủ nguyện vọng hợp tác chân thành, vậy cần gì phải tranh giành từng tấc trên những vấn đề râu ria đến nỗi làm tổn thương hòa khí chứ?',
      '"既然...又何必...呢？" khuyên nhủ sự nhượng bộ đại cục tránh tổn hại quan hệ ngoại giao đối tác.'
    ),
    (
      v_gp_id,
      '往事既然已经随风而逝无法挽回，我们又何必整天沉溺在过去的自责与痛苦之中呢？',
      'Wǎngshì jìrán yǐjīng suífēng''érshì wúfǎ wǎnhuí, wǒmen yòu hébì zhěngtiān chénnì zài guòqù de zìzé yǔ tòngkǔ zhīzhōng ne?',
      'Chuyện xưa đã theo gió thoảng trôi qua không thể cứu vãn, chúng ta cần gì phải suốt ngày chìm đắm trong nỗi tự trách và đau khổ của quá khứ cơ chứ?',
      '"又何必...呢" là lời an ủi tâm lý động viên đối phương buông bỏ gánh nặng quá khứ hướng về tương lai.'
    );

  -- Điểm ngữ pháp #84: Cấu trúc tương sinh bổ trợ hoàn mỹ "相辅相成" (Hỗ trợ bổ sung cho nhau / Song hành phát triển)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tương sinh bổ trợ hoàn mỹ "相辅相成" (Hỗ trợ bổ sung cho nhau / Song hành phát triển)',
    'A 与 / 和 B + 相辅相成, 缺一不可',
    'Cấu trúc cố định',
    '"相辅相成" (xiāngfǔ xiāngchéng) kết hợp chữ 辅 (giúp đỡ, tương trợ) và 成 (hoàn thành, phát triển), biểu thị hai sự vật hoặc phương diện bổ sung, nương tựa và thúc đẩy lẫn nhau cùng hoàn thiện, thiếu một trong hai thì bên kia không thể đứng vững (hỗ trợ lẫn nhau, tương sinh tương hợp). Thường đi với cụm "缺一不可".',
    'HSK 6',
    84,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经济的高质量发展与生态环境的高水平保护是相辅相成的辩证统一关系。',
      'Jīngjì de gāozhìliàng fāzhǎn yǔ shēngtài huánjìng de gāoshuǐpíng bǎohù shì xiāngfǔxiāngchéng de biànzhèng tǒngyī guānxì.',
      'Sự phát triển kinh tế chất lượng cao và việc bảo vệ môi trường sinh thái mức độ cao là mối quan hệ thống nhất biện chứng hỗ trợ bổ sung cho nhau.',
      '"相辅相成" làm sáng tỏ triết lý không đánh đổi môi trường lấy kinh tế ngắn hạn.'
    ),
    (
      v_gp_id,
      '扎实的理论知识传授与生动的动手实践操作相辅相成，共同构成了现代高等工程教育的基石。',
      'Zhāshi de lǐlùn zhīshi chuánshòu yǔ shēngdòng de dòngshǒu shíjiàn cāozuò xiāngfǔxiāngchéng, gòngtóng gòuchéng le xiàndài gāoděng gōngchéng jiàoyù de jīshí.',
      'Việc truyền thụ kiến thức lý luận vững chắc và thao tác thực hành sinh động hỗ trợ bổ sung cho nhau, cùng nhau cấu thành nền tảng của giáo dục kỹ thuật công trình đại học hiện đại.',
      '"相辅相成" kết hợp nhuần nhuyễn giữa học lý thuyết và hành thực tế trong đào tạo kỹ sư.'
    );

  -- Điểm ngữ pháp #85: Cấu trúc tương phản đối nghịch đi ngược chiều "背道而驰" (Đi ngược lại hoàn toàn / Trái chiều)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tương phản đối nghịch đi ngược chiều "背道而驰" (Đi ngược lại hoàn toàn / Trái chiều)',
    'Hành vi thực tế + 与 + Mục tiêu ban đầu / Xu thế thời đại + 背道而驰',
    'Cấu trúc cố định',
    '"背道而驰" (bèidào''érchí) kết hợp chữ 背 (quay lưng), 道 (con đường), 驰 (chạy ngựa), miêu tả hành động thực tế chạy theo hướng hoàn toàn trái ngược với mục tiêu, phương châm hoặc quy luật tiến bộ chung của thời đại (đi ngược lại, trái chiều hoàn toàn). Mang sắc thái phê phán mạnh mẽ.',
    'HSK 6',
    85,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '某些国家搞单边保护主义的逆流，与全球化深度发展的历史潮流显然是背道而驰的。',
      'Mǒuxiē guójiā gǎo dānbiān bǎohùzhǔyì de nìliú, yǔ quánqiúhuà shēndù fāzhǎn de lìshǐ cháoliú xiǎnrán shì bèidào''érchí de.',
      'Dòng nước ngược chủ nghĩa bảo hộ đơn phương của một số quốc gia rõ ràng là đi ngược lại hoàn toàn với trào lưu lịch sử phát triển sâu sắc của toàn cầu hóa.',
      '"与...潮流背道而驰" là lời bình luận quốc tế sắc sảo phê phán chính sách bảo hộ mậu dịch.'
    ),
    (
      v_gp_id,
      '如果口头上高喊减负口号，背地里却不断加码考试难度，这种做法完全与教育初衷背道而驰。',
      'Rúguǒ kǒutóushang gāohǎn jiǎnfù kǒuhào, bèidìlǐ què búduàn jiāmǎ kǎoshì nándù, zhè zhǒng zuòfǎ wánquán yǔ jiàoyù chūzhōng bèidào''érchí.',
      'Nếu ngoài miệng hô hào khẩu hiệu giảm tải áp lực, nhưng sau lưng lại không ngừng tăng độ khó của các kỳ thi, cách làm này hoàn toàn đi ngược lại ý định ban đầu của giáo dục.',
      '"与教育初衷背道而驰" vạch trần mâu thuẫn giữa khẩu hiệu và hành động thực tế trong nhà trường.'
    );

  -- Điểm ngữ pháp #86: Cấu trúc quy nạp đồng quy trăm sông về biển "殊途同归" (Khác đường cùng đích / Đều hướng về một mục tiêu)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc quy nạp đồng quy trăm sông về biển "殊途同归" (Khác đường cùng đích / Đều hướng về một mục tiêu)',
    'Phương pháp A và Phương pháp B tuy khác nhau, nhưng + 殊途同归',
    'Cấu trúc cố định',
    '"殊途同归" (shūtú tóngguī) kết hợp chữ 殊 (khác nhau), 途 (con đường), 同 (cùng), 归 (quy về một mối), mang nghĩa đi bằng những con đường, giải pháp, góc nhìn khác nhau nhưng cuối cùng đều dẫn tới cùng một kết quả hoặc chân lý tốt đẹp (khác đường cùng đích, trăm sông đổ về một biển).',
    'HSK 6',
    86,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '世界各大古老文明虽然起源地理环境迥异，但在追求人类社会公平正义的道德准则上却是殊途同归。',
      'Shìjiè gè dà gǔlǎo wénmíng suīrán qǐyuán dìlǐ huánjìng jiǒngyì, dàn zài zhuīqiú rénlèi shèhuì gōngpíng zhèngyì de dàodé zhǔnzé shang què shì shūtútóngguī.',
      'Các nền văn minh cổ đại lớn trên thế giới tuy môi trường địa lý khởi nguồn hoàn toàn khác biệt, nhưng trên chuẩn tắc đạo đức mưu cầu công bằng chính nghĩa cho xã hội loài người lại đều hướng về cùng một đích đến.',
      '"殊途同归" làm nổi bật sự hội tụ giá trị nhân loại phổ quát xuyên qua các nền văn minh.'
    ),
    (
      v_gp_id,
      '中西医在治病救人的机理体系上虽然各有侧重，但其维护人类生命健康的崇高使命殊途同归。',
      'Zhōngxīyī zài zhìbìngjiùrén de jīlǐ tǐxì shang suīrán gè yǒu cèzhòng, dàn qí wéihù rénlèi shēngmìng jiànkāng de chónggāo shǐmìng shūtútóngguī.',
      'Đông y và Tây y trên hệ thống cơ chế trị bệnh cứu người tuy mỗi bên có điểm nhấn riêng, nhưng sứ mệnh cao cả bảo vệ sức khỏe tính mạng nhân loại của đôi bên lại cùng hướng về một mục tiêu.',
      '"使命殊途同归" khẳng định sự giao thoa hài hòa giữa y học cổ truyền và y học hiện đại.'
    );

  -- Điểm ngữ pháp #87: Cấu trúc quy luật phát triển bài bản khoa học "循序渐进" (Tuần tự tiến bước / Theo trình tự khoa học)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc quy luật phát triển bài bản khoa học "循序渐进" (Tuần tự tiến bước / Theo trình tự khoa học)',
    'Học tập / Cải cách + 必须 + 循序渐进, 不可操之过急',
    'Cấu trúc cố định',
    '"循序渐进" (xúnxù jiànjìn) kết hợp chữ 循 (tuân theo), 序 (trình tự), 渐 (dần dần), 进 (tiến lên), biểu thị việc học tập, rèn luyện hoặc cải cách thể chế bắt buộc phải tiến hành từng bước theo đúng quy luật phát triển từ dễ đến khó, từ thấp đến cao, không được nôn nóng đốt cháy giai đoạn (tuần tự từng bước). Thường đi với "不可操之过急".',
    'HSK 6',
    87,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '掌握一门高难度外语必须遵循循序渐进的科学规律，绝不可能靠突击几天便一蹴而就。',
      'Zhǎowò yì mén gāonándù wàiyǔ bìxū zūnxún xúnxùjiànjìn de kēxué guīlǜ, jué bù kěnéng kào tūjī jǐ tiān biàn yícù''érjiù.',
      'Nắm vững một ngoại ngữ có độ khó cao bắt buộc phải tuân theo quy luật khoa học tuần tự từng bước, tuyệt đối không thể dựa vào vài ngày học nhồi nhét cấp tốc mà một bước thành tài ngay được.',
      '"遵循循序渐进的规律" răn dạy sự kiên nhẫn tích lũy trong việc tiếp thu ngôn ngữ.'
    ),
    (
      v_gp_id,
      '资本市场的全面对外开放当坚持稳中求进、循序渐进，有效防范跨境金融风险传染。',
      'Zīběn shìchǎng de quánmiàn duìwài kāifàng dāng jiānchí wěnzhōngqiújìn, xúnxùjiànjìn, yǒuxiào fángfàn kuàjìng jīnróng fēngxiǎn chuánrǎn.',
      'Việc mở cửa toàn diện thị trường vốn với bên ngoài cần kiên trì phương châm tìm kiếm tiến bộ trong sự ổn định, tuần tự từng bước, phòng ngừa hiệu quả sự lây lan rủi ro tài chính xuyên biên giới.',
      '"循序渐进" xác lập nguyên tắc thận trọng mở cửa hội nhập tài chính an toàn.'
    );

  -- Điểm ngữ pháp #88: Cấu trúc phán đoán lẽ tự nhiên đạo lý "理所当然" (Đương nhiên / Lẽ tất nhiên phải vậy)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc phán đoán lẽ tự nhiên đạo lý "理所当然" (Đương nhiên / Lẽ tất nhiên phải vậy)',
    'Chủ ngữ + 享受权利 / 履行义务, 是理所当然的',
    'Cấu trúc cố định',
    '"理所当然" (lǐ suǒ dāng rán) kết hợp chữ 理 (đạo lý), 当 (phải, nên), 然 (như vậy), mang nghĩa xét về mặt quy luật, đạo đức hoặc khế ước thì sự việc diễn ra như thế là hoàn toàn hợp tình hợp lý, hiển nhiên không cần phải bàn cãi (lẽ tất nhiên, đương nhiên là phải thế).',
    'HSK 6',
    88,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '子女在成年后赡养照顾年迈体弱的父母，无论从伦理道德还是法律义务上讲都是理所当然的。',
      'Zǐnǚ zài chéngnián hòu shànyǎng zhàogù niánmài tǐruò de fùmǔ, wúlùn cóng lúnlǐ dàodé háishì fǎlǜ yìwù shang jiǎng dōu shì lǐsuǒdāngrán de.',
      'Con cái sau khi trưởng thành phụng dưỡng chăm sóc cha mẹ già yếu, bất luận xét từ góc độ luân lý đạo đức hay nghĩa vụ pháp luật đều là điều hiển nhiên đương nhiên phải làm.',
      '"是理所当然的" khẳng định đạo hiếu phụng dưỡng cha mẹ là thiên chức đạo đức bất biến.'
    ),
    (
      v_gp_id,
      '在知识经济时代，创新者通过合法的知识产权保护获取商业回报是理所当然的权利。',
      'Zài zhīshi jīngjì shídài, chuàngxīnzhě tōngguò héfǎ de zhīshi chǎnquán bǎohù huòqǔ shāngyè huíbào shì lǐsuǒdāngrán de quánlì.',
      'Trong thời đại kinh tế tri thức, người đổi mới sáng tạo thông qua việc bảo hộ quyền sở hữu trí tuệ hợp pháp thu về lợi ích thương mại là quyền lợi đương nhiên chính đáng.',
      '"理所当然的权利" bảo vệ quyền sở hữu trí tuệ của nhà phát minh sáng chế.'
    );

  -- Điểm ngữ pháp #89: Cấu trúc phê phán hành vi trái quy luật tự nhiên "缘木求鱼" (Leo cây tìm cá / Làm chuyện ngược đời)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc phê phán hành vi trái quy luật tự nhiên "缘木求鱼" (Leo cây tìm cá / Làm chuyện ngược đời)',
    'Phương pháp sai lầm + 无异于 / 等同于 + 缘木求鱼',
    'Cấu trúc cố định',
    '"缘木求鱼" (yuán mù qiú yú) là tích xưa Mạnh Tử: leo lên cây để bắt cá (chữ 缘 nghĩa là leo). Dùng để chỉ phương hướng hoặc phương pháp tiếp cận hoàn toàn sai lầm, trái với quy luật khách quan nên vĩnh viễn không bao giờ đạt được mục đích (leo cây tìm cá, làm chuyện hão huyền trái quy luật).',
    'HSK 6',
    89,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '企图不经过刻苦踏实的日常积累而单凭考前突击押题取得优异成绩，无异于缘木求鱼。',
      'Qǐtú bù jīngguò kèkǔ tāshi de rìcháng jīlěi ér dān píng kǎoqián tūjī yātí qǔdé yōuyì chéngjì, wúyìyú yuánmùqiúyú.',
      'Mưu toan không qua sự tích lũy chăm chỉ vững chắc thường ngày mà chỉ dựa vào việc học tủ đoán đề trước thi để đạt thành tích xuất sắc, chẳng khác nào leo cây tìm cá.',
      '"无异于缘木求鱼" phê phán tâm lý ỷ lại vào học tủ may rủi trong thi cử.'
    ),
    (
      v_gp_id,
      '脱离群众的真实生活关切而关起门来搞所谓的文学艺术创作，终究只能是缘木求鱼。',
      'Tuōlí qúnzhòng de zhēnshí shēnghuó guānqiè ér guānqǐ mén lái gǎo suǒwèi de wénxué yìshù chuàngzuò, zhōngjiū zhǐ néng shì yuánmùqiúyú.',
      'Tách rời sự quan tâm đời sống chân thực của quần chúng mà đóng kín cửa làm cái gọi là sáng tác văn học nghệ thuật, rốt cuộc cũng chỉ có thể là leo cây tìm cá mà thôi.',
      '"终究只能是缘木求鱼" răn dạy nghệ sĩ không được thoát ly hiện thực đời sống nhân dân.'
    );

  -- Điểm ngữ pháp #90: Cấu trúc phòng ngừa rủi ro từ trong trứng nước "防患于未然" (Phòng ngừa hiểm họa từ lúc chưa phát sinh)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc phòng ngừa rủi ro từ trong trứng nước "防患于未然" (Phòng ngừa hiểm họa từ lúc chưa phát sinh)',
    '必须 + 建立健全机制 / 提高警惕, 防患于未然',
    'Cấu trúc cố định',
    '"防患于未然" (fáng huàn yú wèi rán) kết hợp chữ 防 (phòng ngừa), 患 (tai họa), 于 (ở, tại), 未然 (khi chưa xảy ra), mang nghĩa áp dụng mọi biện pháp phòng ngừa nghiêm ngặt trước khi sự cố hay thảm họa bộc phát để triệt tiêu mọi mầm mống rủi ro (phòng ngừa hiểm họa từ lúc chưa phát sinh, lo toan chu đáo trước).',
    'HSK 6',
    90,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '安全生产重在日常预防，企业必须建立全覆盖的排查监管机制，切实防患于未然。',
      'Ānquán shēngchǎn zhòng zài rìcháng yùfáng, qǐyè bìxū jiànlì quán fùgài de páichá jiānguǎn jīzhì, qièshí fánghuànyúwèirán.',
      'An toàn sản xuất cốt ở việc phòng ngừa thường nhật, doanh nghiệp bắt buộc phải thiết lập cơ chế rà soát giám sát bao phủ toàn diện, thiết thực phòng ngừa hiểm họa từ lúc chưa phát sinh.',
      '"防患于未然" là kim chỉ nam an toàn lao động trong quản lý sản xuất công nghiệp.'
    ),
    (
      v_gp_id,
      '在汛期到来之前提前加固水利大堤并疏浚河道，才能未雨绸缪、防患于未然。',
      'Zài xùnqī dàolái zhīqián tíqián jiāgù shuǐlì dàdī bìng shūjùn hédào, cái néng wèiyǔchóumóu, fánghuànyúwèirán.',
      'Trước khi mùa mưa lũ kéo tới gia cố trước đê điều thủy lợi và nạo vét lòng sông thì mới có thể lo toan chu đáo trước lúc mưa giông, phòng ngừa hiểm họa từ lúc chưa bùng phát.',
      '"未雨绸缪、防患于未然" là cặp thành ngữ đôi miêu tả nghệ thuật phòng chống thiên tai chủ động.'
    );

  -- Điểm ngữ pháp #91: Cấu trúc linh hoạt thích ứng tình huống "随机应变" (Tùy cơ ứng biến / Linh hoạt thích nghi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc linh hoạt thích ứng tình huống "随机应变" (Tùy cơ ứng biến / Linh hoạt thích nghi)',
    '面对瞬息万变的局势, 必须 + 善于 / 沉着 + 随机应变',
    'Cấu trúc cố định',
    '"随机应变" (suí jī yìng biàn) kết hợp chữ 随 (nương theo), 机 (thời cơ, hoàn cảnh biến đổi), 应变 (ứng phó với sự biến), biểu thị năng lực tư duy nhạy bén, biết tùy theo sự thay đổi của tình thế khách quan mà linh hoạt điều chỉnh chiến thuật hành động thích hợp, không dập khuôn máy móc.',
    'HSK 6',
    91,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '商场如战场，面对瞬息万变的市场供需形势，企业家必须具备沉着冷静、随机应变的高超指挥艺术。',
      'Shāngchǎng rú zhànchǎng, miànduì shùnxīwànbiàn de shìchǎng gōngxū xíngshì, qǐyèjiā bìxū jùbèi chénzhuó lěngjìng, suíjīyìngbiàn de gāochāo zhǐhuī yìshù.',
      'Thương trường như chiến trường, đối mặt với tình thế cung cầu thị trường biến đổi trong từng hơi thở, nhà doanh nghiệp bắt buộc phải hội tụ nghệ thuật chỉ huy tài ba trầm tĩnh bình thản và tùy cơ ứng biến.',
      '"随机应变的高超指挥艺术" tôn vinh sự linh hoạt nhạy bén của lãnh đạo doanh nghiệp.'
    ),
    (
      v_gp_id,
      '在野外突发恶劣极端天气时，领队要善于根据地形和风向随机应变，迅速带领队伍避险。',
      'Zài yěwài tūfā èliè jíduān tiānqì shí, lǐngduì yào shànyú gēnjù dìxíng hé fēngxiàng suíjīyìngbiàn, xùnsù dàilǐng duìwù bìxiǎn.',
      'Khi nơi hoang dã đột phát thời tiết cực đoan khắc nghiệt, người trưởng đoàn phải giỏi căn cứ theo địa hình và hướng gió để tùy cơ ứng biến, nhanh chóng dẫn dắt đoàn lánh nạn.',
      '"善于...随机应变" là kỹ năng sinh tồn then chốt bảo vệ an toàn tính mạng nơi thiên nhiên hoang dã.'
    );

  -- Điểm ngữ pháp #92: Cấu trúc tương khắc không thể dung hòa "水火不容" (Như nước với lửa / Tuyệt đối không đội trời chung)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tương khắc không thể dung hòa "水火不容" (Như nước với lửa / Tuyệt đối không đội trời chung)',
    'A 与 B + 犹如水火不容 / 矛盾双方 + 势同水火',
    'Cấu trúc cố định',
    '"水火不容" (shuǐ huǒ bù róng) dùng hình ảnh nước và lửa tương khắc triệt tiêu lẫn nhau để ẩn dụ cho hai lập trường, quan điểm hoặc hệ giá trị đối kháng gay gắt, mâu thuẫn đối kháng sâu sắc đến mức tuyệt đối không thể cùng tồn tại song hành hay dung hòa lẫn nhau.',
    'HSK 6',
    92,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '坚守公平正义的职业良知与追逐不正当私利的贪腐念头，是水火不容、绝不相容的。',
      'Jiānshǒu gōngpíng zhèngyì de zhíyè liángzhī yǔ zhuīzhú búzhengdàng sīlì de tānfǔ niàntou, shì shuǐhuǒbùróng, jué bù xiāngróng de.',
      'Lương tâm nghề nghiệp kiên định bảo vệ công bằng chính nghĩa và ý niệm tham nhũng theo đuổi tư lợi bất chính là điều như nước với lửa, tuyệt đối không thể dung hòa.',
      '"水火不容" phân định ranh giới đạo đức liêm chính không thể nhân nhượng.'
    ),
    (
      v_gp_id,
      '真正的学术自由探索与学术不端抄袭剽窃行为，本质上是势同水火、不可调和的。',
      'Zhēnzhèng de xuéshù zìyóu tànsuǒ yǔ xuéshù bùduān chāoxí piāoqiè xíngwéi, běnzhì shang shì shìtóngshuǐhuǒ, bùkě tiáohé de.',
      'Sự tự do tìm tòi học thuật chân chính và hành vi bất lương sao chép đạo văn học thuật về bản chất là như nước với lửa, không thể điều hòa.',
      '"势同水火" khẳng định sự đối lập tận gốc rễ giữa nghiên cứu chân chính và hành vi đạo văn.'
    );

  -- Điểm ngữ pháp #93: Cấu trúc đồng cam vinh nhục máu thịt "荣辱与共" (Vinh nhục có nhau / Cùng chia sẻ vinh quang và cay đắng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc đồng cam vinh nhục máu thịt "荣辱与共" (Vinh nhục có nhau / Cùng chia sẻ vinh quang và cay đắng)',
    'A 与 B + 风雨同舟, 荣辱与共',
    'Cấu trúc cố định',
    '"荣辱与共" (róngrǔ yǔgòng) kết hợp chữ 荣 (vinh quang), 辱 (tủi nhục, hoạn nạn), 与共 (cùng chia sẻ), mang nghĩa cùng nhau gánh vác mọi thành bại, cùng chia sẻ ánh hào quang vinh dự lẫn lúc chịu đựng gian nan thử thách (vinh nhục có nhau, chung lưng đấu cật). Thường đi với "风雨同舟".',
    'HSK 6',
    93,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '几十年来，各民主党派与中国共产党风雨同舟、荣辱与共，共同谱写了爱国统一战线的光辉篇章。',
      'Jǐshí nián lái, gè mínzhǔ dǎngpài yǔ Zhōngguó Gòngchǎndǎng fēngyǔtóngzhōu, róngrǔyǔgòng, gòngtóng pǔxiě le àiguó tǒngyī zhànxiàn de guānghuī piānzhāng.',
      'Mấy chục năm qua, các đảng phái dân chủ cùng Đảng Cộng sản Trung Quốc kề vai sát cánh cùng chung một con thuyền, vinh nhục có nhau, cùng viết nên thiên trang vẻ vang của mặt trận thống nhất yêu nước.',
      '"风雨同舟、荣辱与共" là phương châm hợp tác chính trị đa đảng đoàn kết thống nhất.'
    ),
    (
      v_gp_id,
      '全体员工同心协力把企业视作自己的大家庭，在市场风浪中与公司荣辱与共、患难相恤。',
      'Quántǐ yuángōng tóngxīnxiélì bǎ qǐyè shìzuò zìjǐ de dàjiātíng, zài shìchǎng fēnglàng zhōng yǔ gōngsī róngrǔyǔgòng, huànnàn xiāngxù.',
      'Toàn thể nhân viên đồng tâm hiệp lực coi doanh nghiệp như đại gia đình của mình, trước sóng gió thương trường cùng công ty vinh nhục có nhau, hoạn nạn đùm bọc lẫn nhau.',
      '"与公司荣辱与共" thể hiện sự gắn bó son sắt trung thành giữa người lao động và tập thể doanh nghiệp.'
    );

  -- Điểm ngữ pháp #94: Câu chữ 把 văn thư ngoại giao & tư pháp: "把...付诸..." (Đưa... vào thực tế / Đem ra...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 văn thư ngoại giao & tư pháp: "把...付诸..." (Đưa... vào thực tế / Đem ra...)',
    'Chủ ngữ + 把 + Phương án / Kế hoạch + 付诸 + (实施 / 表决 / 实践 / 东流)',
    'Câu chữ 把',
    'Trong các văn kiện chính trị, ngoại giao và nghị trường quốc tế, kết cấu "把...付诸..." (bǎ... fùzhū...) là mẫu câu trang trọng bậc nhất biểu thị hành động đem một ý niệm, hiệp định hoặc đề án chuyển hóa vào thực tiễn hành động (付诸实施 - đưa vào thực thi, 付诸表决 - đem ra biểu quyết thông qua). Chữ "诸" tương đương "之于".',
    'HSK 6',
    94,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '大会主席团一致决定把关于气候治理的联合宣言草案正式付诸全体大会表决。',
      'Dàhuì zhǔxítuán yízhì juédìng bǎ guānyú qìhòu zhìlǐ de liánhé xuānyán cǎofàn zhèngshì fùzhū quántǐ dàhuì biǎojué.',
      'Đoàn chủ tịch đại hội đã nhất trí quyết định đem bản dự thảo tuyên ngôn chung về quản trị khí hậu chính thức đưa ra toàn thể đại hội biểu quyết.',
      '"把...草案正式付诸表决" là thuật ngữ thủ tục nghị trường chuẩn xác trong các kỳ họp liên hợp quốc.'
    ),
    (
      v_gp_id,
      '青年科研人员应当敢于把书本上的前沿理论大胆付诸创新工程的实践探索之中。',
      'Qīngnián kēyán rényuán yīngdāng gǎnyú bǎ shūběn shang de qiányán lǐlùn dàdǎn fùzhū chuàngxīn gōngchéng de shíjiàn tànsuǒ zhīzhōng.',
      'Cán bộ nghiên cứu khoa học trẻ tuổi cần dũng cảm đem các lý luận tiên phong trên sách vở táo bạo áp dụng vào thực tiễn tìm tòi của công trình đổi mới.',
      '"把理论付诸实践" khuyên nhủ sự kết hợp giữa tri thức hàn lâm và thực nghiệm công nghệ.'
    );

  -- Điểm ngữ pháp #95: Câu chữ 把 công bố chân tướng toàn cầu: "把...公诸于世" (Công bố trước bàn dân thiên hạ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 công bố chân tướng toàn cầu: "把...公诸于世" (Công bố trước bàn dân thiên hạ)',
    'Chủ ngữ + 把 + Bằng chứng / Chân tướng lịch sử / Hồ sơ cơ mật + 公诸于世',
    'Câu chữ 把',
    '"把...公诸于世" (bǎ... gōngzhūyúshì) kết hợp chữ 公 (công khai), 诸 (đến), 世 (thế gian), mang nghĩa đem một sự thật bị che giấu bấy lâu, một hồ sơ tội ác lịch sử hoặc một phát hiện khảo cổ chấn động công bố rộng rãi trước bàn dân thiên hạ và toàn thế giới.',
    'HSK 6',
    95,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '国际调查委员会将历经三年秘密收集的战争罪证档案原件完整地公诸于世。',
      'Guójì diàochá wěiyuánhuì jiāng lìjīng sān nián mìmì shōují de zhànzhēng zuìzhèng dàng''àn yuánjiàn wánzhěng de gōngzhūyúshì.',
      'Ủy ban điều tra quốc tế đã công bố trọn vẹn trước bàn dân thiên hạ bản gốc hồ sơ bằng chứng tội ác chiến tranh trải qua 3 năm bí mật thu thập.',
      '"把档案原件完整地公诸于世" đặc tả thời khắc công lý phơi bày tội ác ra trước ánh sáng công luận.'
    ),
    (
      v_gp_id,
      '这位勇敢的科学家冒着巨大的职业风险，坚决把食品添加剂的真实毒理检测报告公诸于世。',
      'Zhè wèi yǒnggǎn de kēxuéjiā màozhe jùdà de zhíyè fēngxiǎn, jiānjué bǎ shípǐn tiānjiājì de zhēnshí dúlǐ jiǎncè bàogào gōngzhūyúshì.',
      'Nhà khoa học dũng cảm này đã bất chấp rủi ro nghề nghiệp khổng lồ, kiên quyết công bố bản báo cáo kiểm nghiệm độc lý chân thực của chất phụ gia thực phẩm ra trước công chúng.',
      '"把...报告公诸于世" ca ngợi đạo đức dũng cảm vì sức khỏe cộng đồng của người làm khoa học.'
    );

  -- Điểm ngữ pháp #96: Câu chữ 把 văn học cổ điển chỉ sự hủy diệt: "把...付之一炬" (Thiêu rụi trong ngọn lửa)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 văn học cổ điển chỉ sự hủy diệt: "把...付之一炬" (Thiêu rụi trong ngọn lửa)',
    'Chủ ngữ + 把 + Tác phẩm tâm huyết / Thư tịch / Thành trì + 付之一炬',
    'Câu chữ 把',
    '"把...付之一炬" (bǎ... fùzhīyījù) kết hợp chữ 付 (giao phó), 之 (nó), 一炬 (một ngọn đuốc, mồi lửa), mang nghĩa đem toàn bộ tác phẩm nghệ thuật, sách quý hoặc cơ nghiệp đốt sạch sành sanh trong một mồi lửa lớn (thiêu rụi hoàn toàn). Mang sắc thái bi tráng, tiếc nuối tột cùng.',
    'HSK 6',
    96,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '侵略者洗劫了这座宏伟的古代皇家园林，并在撤退前毫无人性地把它付之一炬。',
      'Qīnlüèzhě xǐjié le zhè zuò hóngwěi de gǔdài huángjiā yuánlín, bìng zài chètuì qián háowú rénxìng de bǎ tā fùzhīyījù.',
      'Những kẻ xâm lược đã cướp phá khu hoa viên hoàng gia cổ đại hùng vĩ này, và trước khi rút quân đã mất hết nhân tính thiêu rụi nó trong một biển lửa.',
      '"把它付之一炬" lên án tội ác man rợ tàn phá di sản văn hóa nhân loại của quân xâm lăng.'
    ),
    (
      v_gp_id,
      '这位追求完美的孤傲作家在临终前，亲手把未完成的几部手稿残卷付之一炬。',
      'Zhè wèi zhuīqiú wánměi de gū''ào zuòjiā zài línzhōng qián, qīnshǒu bǎ wèiwánchéng de jǐ bù shǒugǎo cánjuàn fùzhīyījù.',
      'Người nhà văn cô độc ngạo nghễ mưu cầu sự hoàn mỹ này trước lúc lâm chung đã tự tay thiêu rụi mấy tập bản thảo dang dở trong đống lửa.',
      '"把手稿付之一炬" khắc họa cá tính nghệ thuật cực đoan chỉ giữ lại kiệt tác hoàn hảo của tác giả.'
    );

  -- Điểm ngữ pháp #97: Câu chữ 把 chỉ sự gạt bỏ lãng quên: "把...抛诸脑后" (Vứt bỏ ra sau đầu / Lãng quên hoàn toàn)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 chỉ sự gạt bỏ lãng quên: "把...抛诸脑后" (Vứt bỏ ra sau đầu / Lãng quên hoàn toàn)',
    'Chủ ngữ + 把 + Lời dặn / An toàn / Phiền muộn + 抛诸脑后',
    'Câu chữ 把',
    '"把...抛诸脑后" (bǎ... pāozhū nǎohòu) kết hợp chữ 抛 (quẳng, ném), 诸 (đến), 脑后 (sau gáy), mang nghĩa vứt bỏ hoàn toàn, không thèm đoái hoài nhớ tới những lời răn dạy, sự an toàn hoặc những muộn phiền (quẳng ra sau đầu, lãng quên sạch sẽ).',
    'HSK 6',
    97,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '个别司机为了抢那一两秒的绿灯，竟然把最基本的交通安全规则完全抛诸脑后。',
      'Gèbié sījī wèile qiǎng nà yì liǎng miǎo de lǜdēng, jìngrán bǎ zuì jīběn de jiāotōng ānquán guīzé wánquán pāozhū nǎohòu.',
      'Một số ít tài xế vì muốn tranh thủ một hai giây đèn xanh mà lại vứt bỏ hoàn toàn quy tắc an toàn giao thông cơ bản nhất ra sau đầu.',
      '"把安全规则抛诸脑后" phê phán thái độ coi thường tính mạng khi tham gia giao thông.'
    ),
    (
      v_gp_id,
      '一踏入风景秀丽的宁静大自然，他便把平日里繁重工作带来的种种焦虑抛诸脑后。',
      'Yí tàrù fēngjǐng xiùlì de níngjìng dàzìrán, tā biàn bǎ píngrì lǐ fánzhòng gōngzuò dàilái de zhǒngzhǒng jiāolǜ pāozhū nǎohòu.',
      'Vừa bước chân vào thiên nhiên tĩnh lặng phong cảnh tươi đẹp, anh ấy liền quẳng sạch sẽ mọi nỗi âu lo do công việc bề bộn ngày thường đem lại ra sau đầu.',
      '"把种种焦虑抛诸脑后" miêu tả cảm giác thư thái trút bỏ gánh nặng tinh thần nơi thiên nhiên khoáng đạt.'
    );

  -- Điểm ngữ pháp #98: Câu chữ 把 nâng tầm tư duy chiến lược: "把...上升为 / 提升为..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 nâng tầm tư duy chiến lược: "把...上升为 / 提升为..."',
    'Chủ ngữ + 把 + Phương châm/Đề án + 上升为 / 提升为 + 国家战略 / 全球共识',
    'Câu chữ 把',
    '"把...上升为..." (bǎ... shàngshēngwéi...) là mẫu câu hoạch định chính sách cấp cao, biểu thị việc nâng tầm một vấn đề, một ý tưởng từ cấp độ cục bộ, kỹ thuật lên tầm vóc chiến lược quốc gia, luật pháp hiến định hoặc sứ mệnh lịch sử.',
    'HSK 6',
    98,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '国家正式把保护知识产权与鼓励原始创新上升为关乎经济命脉的核心国家战略。',
      'Guójiā zhèngshì bǎ bǎohù zhīshi chǎnquán yǔ gǔlì yuánshǐ chuàngxīn shàngshēng wéi guānhū jīngjì mìngmài de héxīn guójiā zhànlüè.',
      'Nhà nước đã chính thức nâng việc bảo hộ quyền sở hữu trí tuệ và khuyến khích sáng tạo gốc lên thành chiến lược quốc gia cốt lõi liên quan tới sinh mệnh kinh tế.',
      '"把...上升为国家战略" khẳng định tầm vóc chính trị cao nhất của chính sách sở hữu trí tuệ.'
    ),
    (
      v_gp_id,
      '企业董事会决定把数字化转型从单一的业务手段提升为驱动未来发展的根本动力。',
      'Qǐyè dǒngshìhuì juédìng bǎ shùzìhuà zhuǎnxíng cóng dānyī de yèwù shǒuduàn tíshēng wéi qūdòng wèilái fāzhǎn de gēnběn dònglì.',
      'Hội đồng quản trị doanh nghiệp quyết định nâng việc chuyển đổi số từ thủ đoạn nghiệp vụ đơn thuần lên thành động lực căn bản dẫn dắt sự phát triển tương lai.',
      '"把...提升为根本动力" định hình lại vai trò của công nghệ thông tin trong quản trị doanh nghiệp.'
    );

  -- Điểm ngữ pháp #99: Câu chữ 把 hòa nhập đa chiều hoàn mỹ: "把...融为一体"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 hòa nhập đa chiều hoàn mỹ: "把...融为一体"',
    'Chủ ngữ + 把 + Yếu tố A + 与 / 和 + Yếu tố B + 完美地融为一体',
    'Câu chữ 把',
    '"把...融为一体" (bǎ... róngwéi yītǐ) biểu thị hành động khéo léo kết hợp hai hay nhiều yếu tố tưởng chừng khác biệt (như truyền thống và hiện đại, nghệ thuật và kỹ thuật) hòa quyện chặt chẽ thành một chỉnh thể hữu cơ hoàn mỹ, không tì vết.',
    'HSK 6',
    99,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这栋地标性建筑巧妙地把古典东方美学意境与现代前沿环保科技完美地融为了一体。',
      'Zhè dòng dìbiāoxìng jiànzhù qiǎomiào de bǎ gǔdiǎn dōngfāng měixué yìjìng yǔ xiàndài qiányán huánbǎo kējì wánměi de róngwéi le yītǐ.',
      'Tòa kiến trúc biểu tượng này đã khéo léo hòa quyện ý cảnh mỹ học phương Đông cổ điển với công nghệ bảo vệ môi trường tiên phong hiện đại thành một thể thống nhất hoàn mỹ.',
      '"把...融为了一体" ca ngợi bàn tay tài hoa của kiến trúc sư kết hợp mỹ cảm truyền thống với công nghệ xanh.'
    ),
    (
      v_gp_id,
      '优秀的演员能够把自身的情感体验与角色的内心波澜深度交织，把生活与表演融为一体。',
      'Yōuxiù de yǎnyuán nénggòu bǎ zìshēn de qínggǎn tǐyàn yǔ juésè de nèixīn bōlán shēndù jiāozhī, bǎ shēnghuó yǔ biǎoyǎn róngwéi yītǐ.',
      'Người diễn viên xuất sắc có thể đan xen sâu sắc trải nghiệm cảm xúc của bản thân với những làn sóng ngầm nội tâm của nhân vật, hòa quyện đời sống và diễn xuất làm một.',
      '"把生活与表演融为一体" đạt tới cảnh giới nhập vai thần sầu trong nghệ thuật sân khấu điện ảnh.'
    );

  -- Điểm ngữ pháp #100: Câu bị động văn ngôn cổ điển với giới từ kép: "见...于..." (Bị / Được... bởi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu bị động văn ngôn cổ điển với giới từ kép: "见...于..." (Bị / Được... bởi)',
    'Chủ ngữ + 见 + Động từ + 于 + Tác nhân (见笑于 / 见疑于 / 见容于 / 见信于)',
    'Câu bị động',
    'Kết cấu "见 + Động từ + 于 + Tác nhân" là công thức câu bị động ngữ pháp hóa cổ xưa nhất trong Hán văn. Chữ "见" đứng trước động từ đóng vai trò trợ từ tiêu chí bị động, chữ "于" đứng sau dẫn ra tác nhân gây ra hành động (như 见信于人 - được người đời tin tưởng, 见疑于众 - bị mọi người nghi ngờ).',
    'HSK 6',
    100,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '为人处事唯有恪守诚信底线，方能在社会上立足长远，真正见信于广大公众。',
      'Wéirénchǔshì wéiyǒu kèshǒu chéngxìn dǐxiàn, fāngnéng zài shèhuì shang lìzú chángyuǎn, zhēnzhèng jiànxìn yú guǎngdà gōngzhòng.',
      'Đối nhân xử thế duy chỉ có giữ trọn lằn ranh chữ tín thì mới có thể đứng vững lâu dài trong xã hội, thực sự nhận được sự tin cậy từ đông đảo công chúng.',
      '"见信于广大公众" nghĩa là "được đông đảo công chúng tin yêu", dùng thể bị động văn ngôn cổ tao nhã.'
    ),
    (
      v_gp_id,
      '这篇立论荒谬且缺乏基本史实根据的历史小说，一经出版便见疑于学术界同仁。',
      'Zhè piān lìlùn huāngmiù qiě quēfá jīběn shǐshí gēnjù de lìshǐ xiǎoshuō, yījīng chūbǎn biàn jiànyí yú xuéshùjiè tóngrén.',
      'Cuốn tiểu thuyết lịch sử có luận điểm nực cười lại thiếu thốn căn cứ sự thật lịch sử cơ bản này, vừa mới xuất bản đã lập tức bị các đồng nghiệp trong giới học thuật hoài nghi chê trách.',
      '"见疑于学术界同仁" nghĩa là "bị giới học thuật hoài nghi chất vấn".'
    );

  -- Điểm ngữ pháp #101: Câu bị động văn ngôn ràng buộc kiểm soát: "受...于..." (Chịu sự... bởi / Bị khống chế)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu bị động văn ngôn ràng buộc kiểm soát: "受...于..." (Chịu sự... bởi / Bị khống chế)',
    'Chủ ngữ + 受 + Động từ + 于 + Đối tượng kìm kẹp (受制于 / 受惑于 / 受益于 / 受损于)',
    'Câu bị động',
    '"受 + Động từ + 于" biểu thị chủ thể bị ràng buộc, kiểm soát, hoặc thụ hưởng lợi ích/thiệt hại từ một nguồn bên ngoài (như 受制于人 - bị người khác kìm kẹp, 受惑于表象 - bị mê hoặc bởi hiện tượng bề ngoài, 受益于政策 - hưởng lợi từ chính sách).',
    'HSK 6',
    101,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们在做战略决策时决不能受惑于暂时的表面泡沫繁荣，必须看清深层的经济基本面。',
      'Wǒmen zài zuò zhànlüè juécè shí jué bù néng shòuhuò yú zànshí de biǎomiàn pàomò fánróng, bìxū kànqīng shēncéng de jīngjì jīběnmiàn.',
      'Chúng ta khi đưa ra quyết sách chiến lược quyết không thể bị mê hoặc bởi sự phồn vinh bong bóng bề ngoài tạm thời, bắt buộc phải nhìn rõ các yếu tố căn bản tầng sâu của nền kinh tế.',
      '"决不能受惑于表面的繁荣" cảnh báo lãnh đạo không để các số liệu ảo đánh lừa tư duy.'
    ),
    (
      v_gp_id,
      '广大普通老百姓深切受益于国家持续推进的医疗体制改革，看病报销门槛大幅降低。',
      'Guǎngdà pǔtōng lǎobǎixìng shēnqiè shòuyì yú guójiā chíxù tuījìn de yīliáo tǐzhì gǎigé, kànbìng bàoxiāo ménkǎn dàfú jiàngdī.',
      'Đông đảo người dân bình thường hưởng lợi sâu sắc từ công cuộc cải cách thể chế y tế mà nhà nước liên tục thúc đẩy, rào cản thanh toán viện phí đã giảm mạnh.',
      '"受益于...医疗体制改革" dùng thể bị động tích cực thể hiện quyền lợi người dân được hưởng từ chính sách an sinh.'
    );

  -- Điểm ngữ pháp #102: Câu bị động văn ngôn "为...所..." chuyên sâu kết hợp hư từ kép
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu bị động văn ngôn "为...所..." chuyên sâu kết hợp hư từ kép',
    'Chủ ngữ + 为 + Hoàn cảnh/Ảo tưởng + 所 + Động từ (困 / 左右 / 蒙蔽 / 折服 / 铭记)',
    'Câu bị động',
    'Ở HSK 6, cấu trúc bị động "为...所..." phát triển lên tầng cao hàm súc triết luận, thường đi kèm các động từ trừu tượng đơn âm tiết hoặc song âm tiết: 为贫困所困 (bị sự nghèo khó bủa vây), 不为物欲所左右 (không bị dục vọng vật chất thao túng), 为历史所铭记 (được lịch sử khắc ghi).',
    'HSK 6',
    102,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '真正有远大抱负的思想者，绝不会为眼前的名利诱惑所左右。',
      'Zhēnzhèng yǒu yuǎndà bàofù de sīxiǎngzhě, jué bú huì wéi yǎnqián de mínglì yòuhuò suǒ zuǒyòu.',
      'Người có tư tưởng hoài bão lớn lao thực sự tuyệt đối sẽ không bị những cám dỗ danh lợi trước mắt thao túng chi phối.',
      '"不为名利诱惑所左右" khẳng định bản lĩnh tự chủ độc lập kiên định của bậc thức giả.'
    ),
    (
      v_gp_id,
      '无数先烈为了国家独立和民族尊严抛头颅洒热血，他们的丰功伟绩必将永远为历史所铭记。',
      'Wúshù xiānliè wèile guójiā dúlì hé mínzú zūnyán pāotóulú sǎrèxiè, tāmen de fēnggōngwěijì bìjiāng yǒngyuǎn wéi lìshǐ suǒ míngjì.',
      'Vô số các bậc tiền liệt vì độc lập quốc gia và phẩm giá dân tộc đã dâng hiến đầu rơi máu chảy, công lao vĩ đại của họ nhất định sẽ mãi mãi được lịch sử khắc ghi.',
      '"为历史所铭记" là lời ngợi ca trang nghiêm thiêng liêng nhất dành cho công đức liệt sĩ.'
    );

  -- Điểm ngữ pháp #103: Câu phản vấn tu từ văn ngôn cổ phong: "安能...？" (Sao có thể...?)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu phản vấn tu từ văn ngôn cổ phong: "安能...？" (Sao có thể...?)',
    '安能 + Hành động hèn nhát / Trái đạo đức + 乎 / 哉 / 呢？',
    'Cấu trúc cố định',
    '"安能...？" (ān néng...?) là mẫu câu hỏi tu từ văn ngôn cổ đại (chữ 安 nghĩa là sao, lẽ nào, làm sao; 安能 = sao có thể). Bắt nguồn từ câu thơ Lý Bạch nổi tiếng "安能摧眉折腰事权贵，使我不得开心颜" (Sao có thể cúi mày khom lưng thờ quyền quý, khiến ta chẳng được nở nụ cười). Dùng để bộc lộ khí phách thanh cao kiên quyết cự tuyệt sự ô uế.',
    'HSK 6',
    103,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '知识分子当以兼济天下为己任，面对民生疾苦，安能闭目塞听、袖手旁观？',
      'Zhīshi fènzǐ dāng yǐ jiānjì tiānxià wéi jǐrèn, miànduì mínshēng jíkǔ, ān néng bìmùsètīng, xiùshǒupángguān?',
      'Người trí thức phải lấy việc giúp đỡ thiên hạ làm trách nhiệm của mình, đối mặt với nỗi cơ cực lầm than của muôn dân, sao có thể nhắm mắt bịt tai, khoanh tay đứng nhìn?',
      '"安能闭目塞听..." dùng câu phản vấn văn ngôn cổ đỉnh cao chất vấn lương tâm người có học.'
    ),
    (
      v_gp_id,
      '既立志献身于追求科学客观真理之崇高事业，安能因暂时的挫折嘲弄而中途退缩？',
      'Jì lìzhì xiànshēn yú zhuīqiú kēxué kèguān zhēnlǐ zhī chónggāo shìyè, ān néng yīn zànshí de cuòzhé cháonòng ér zhōngtú tuìsuō?',
      'Đã lập chí hiến thân cho sự nghiệp cao cả mưu cầu chân lý khách quan khoa học, sao có thể vì những thất bại và lời chế giễu tạm thời mà thoái lui nửa chừng?',
      '"安能...中途退缩" khẳng định ý chí kiên định theo đuổi con đường khoa học bất chấp gièm pha.'
    );

  -- Điểm ngữ pháp #104: Câu phản vấn tu từ tra hỏi nhân tâm: "孰能...？" (Ai có thể...?)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu phản vấn tu từ tra hỏi nhân tâm: "孰能...？" (Ai có thể...?)',
    '面对... / 在...面前, 孰能 + Không xúc động / Đứng ngoài cuộc + 呢？',
    'Cấu trúc cố định',
    '"孰能...？" (shú néng...?) kết hợp chữ "孰" (ai, cái nào) và "能" (có thể), mang nghĩa "ai có thể làm được việc đó / ai có thể thờ ơ được". Dùng để khẳng định một phản ứng nhân tính là phổ quát toàn nhân loại (ai có thể dửng dưng không động lòng).',
    'HSK 6',
    104,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '目睹同胞在灾难中守望相助、共克时艰的动人场景，身居华夏热土之人孰能不为之动容？',
      'Mùdǔ tóngbāo zài zāinàn zhōng shǒuwàngxiāngzhù, gòngkèshíjiān de dòngrén chǎngjǐng, shēnjū Huáxià rètǔ zhī rén shú néng bù wéizhī dòngróng?',
      'Tận mắt chứng kiến cảnh tượng xúc động đồng bào trong cơn hoạn nạn đùm bọc che chở lẫn nhau, cùng nhau vượt qua thời khắc gian nan, người sống trên mảnh đất Hoa Hạ này ai có thể không xúc động vì điều đó?',
      '"孰能不为之动容" dùng phản vấn khẳng định toàn thể nhân dân đều trào dâng niềm xúc động thiêng liêng.'
    ),
    (
      v_gp_id,
      '面对浩瀚无垠的宇宙星空与深邃永恒的时间长河，凡胎肉身之人类孰能不心怀敬畏？',
      'Miànduì hàohànwúyín de yǔzhòu xīngkōng yǔ shēnsuì yǒnghéng de shíjiān chánghé, fántāiròushēn zhī rénlèi shú néng bù xīnhuái jìngwèi?',
      'Đối mặt với bầu trời sao vũ trụ bao la vô tận và dòng sông dài thời gian vĩnh hằng thâm sâu, con người phàm trần này ai có thể không ôm giữ lòng kính sợ trong tim?',
      '"孰能不心怀敬畏" triết lý hóa sự nhỏ bé và lòng kính ngưỡng của nhân loại trước tạo hóa vĩ đại.'
    );

  -- Điểm ngữ pháp #105: Bổ ngữ mức độ hư hóa văn hóa nhã nhặn "不亦乐乎" (Vui xiết bao / Bận túi bụi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ mức độ hư hóa văn hóa nhã nhặn "不亦乐乎" (Vui xiết bao / Bận túi bụi)',
    'Động từ/Tính từ + 得 + 不亦乐乎 (忙 / 累 / 吵 / 玩 + 得不亦乐乎)',
    'Bổ ngữ',
    '"不亦乐乎" (búyìlèhū) có xuất xứ từ Luận Ngữ: "有朋自远方来，不亦乐乎" (có bạn từ phương xa tới, chẳng cũng vui sao). Trong ngữ pháp hiện đại, nó được hư hóa làm bổ ngữ mức độ sau "得" mang hai nghĩa: 1) Nghĩa gốc: vui mừng khôn xiết; 2) Nghĩa phái sinh phổ biến: miêu tả trạng thái bận rộn túi bụi hoặc cãi vã náo nhiệt đến mức tột cùng (như 忙得不亦乐乎 - bận túi bụi tối mắt).',
    'HSK 6',
    105,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '除夕之夜，全家人围在热气腾腾的厨房里包饺子贴春联，忙得不亦乐乎。',
      'Chúxī zhī yè, quán jiā rén wéi zài rèqìténgténg de chúfáng lǐ bāo jiǎozi tiē chūnlián, máng de búyìlèhū.',
      'Đêm trừ tịch, cả gia đình quây quần trong căn bếp ấm cúng nghi ngút khói gói sủi cảo dán câu đối xuân, bận rộn túi bụi mà ngập tràn niềm vui.',
      '"忙得不亦乐乎" miêu tả không khí tất bật đón giao thừa ấm áp hạnh phúc gia đình.'
    ),
    (
      v_gp_id,
      '周末的游乐场里到处洋溢着欢声笑语，孩子们在沙滩城堡边嬉戏打闹，玩得不亦乐乎。',
      'Zhōumò de yóulèchǎng lǐ dàochù yángyìzhe huānshēngxiàoyǔ, háizimen zài shātān chéngbǎo biān xīxì dǎjiào, wán de búyìlèhū.',
      'Khu vui chơi cuối tuần khắp nơi rộn rã tiếng cười nói, lũ trẻ con nô đùa rượt đuổi bên lâu đài cát, chơi đùa vui vẻ khôn xiết.',
      '"玩得不亦乐乎" đặc tả niềm vui chơi đùa thỏa thích quên hết âu lo của con trẻ.'
    );

  -- Điểm ngữ pháp #106: Bổ ngữ kết quả nghĩa triệt để cùng cực "殆尽" (Kiệt quệ / Không còn sót lại chút gì)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả nghĩa triệt để cùng cực "殆尽" (Kiệt quệ / Không còn sót lại chút gì)',
    'Động từ tiêu hao/hủy hoại + 殆尽 (消耗 / 丧失 / 破坏 / 掠夺 + 殆尽)',
    'Bổ ngữ',
    '"殆尽" (dàijìn) kết hợp chữ 殆 (gần như, hầu như) và 尽 (hết, cạn kiệt), làm bổ ngữ kết quả văn ngôn biểu thị sự vật, tài nguyên hoặc phẩm chất bị tiêu hao, cướp bóc hoặc phá hủy gần như hoàn toàn đến tận giọt cuối cùng, không còn lại một chút nào (cạn kiệt không còn gì). Thường dùng cảnh báo tài nguyên, đạo đức.',
    'HSK 6',
    106,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '掠夺式的无序开采致使该地区的地下矿产与水资源在短短几十年间消耗殆尽。',
      'Lüèduóshì de wúxù kāicǎi zhìshǐ gāi dìqū de dìxià kuàngchǎn yǔ shuǐ zīyuán zài duǎnduǎn jǐshí nián jiān xiāohào dàijìn.',
      'Việc khai thác bừa bãi mang tính vơ vét đã khiến tài nguyên khoáng sản và nước ngầm của khu vực này chỉ trong mấy chục năm ngắn ngủi đã bị tiêu hao cạn kiệt không còn lại gì.',
      '"消耗殆尽" gióng lên hồi chuông cảnh tỉnh về thảm họa kiệt quệ tài nguyên thiên nhiên.'
    ),
    (
      v_gp_id,
      '企业若为了短期暴利而肆意践踏社会道德良知，其积累多年的品牌声誉必将丧失殆尽。',
      'Qǐyè ruò wèile duǎnqī bàolì ér sìyì jiàntà shèhuì dàodé liángzhī, qí jīlěi duō nián de pǐnpái shēngyù bìjiāng sàngshī dàijìn.',
      'Doanh nghiệp nếu vì lợi nhuận kếch xù ngắn hạn mà ngang nhiên chà đạp lên lương tâm đạo đức xã hội thì danh tiếng thương hiệu tích lũy nhiều năm của nó nhất định sẽ mất sạch sành sanh.',
      '"丧失殆尽" cảnh báo cái giá tự hủy diệt uy tín thương hiệu khi làm ăn phi pháp.'
    );

  -- Điểm ngữ pháp #107: Bổ ngữ xu hướng trừu tượng vượt thoát nghịch cảnh: "走出来"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng trừu tượng vượt thoát nghịch cảnh: "走出来"',
    'Chủ ngữ + 从 + Bóng tối/Thất bại/Đau thương + 勇敢地走出来',
    'Bổ ngữ',
    '"走出来" (zǒuchūlai) khi làm bổ ngữ phái sinh trừu tượng biểu thị hành động dũng cảm vượt thoát ra khỏi một trạng thái u ám, đau buồn, thất bại hoặc bóng ma tâm lý trong quá khứ để bước vào ánh sáng tái sinh một cuộc đời mới (bước ra khỏi nghịch cảnh, vượt qua nỗi đau).',
    'HSK 6',
    107,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在心理咨询师和亲友的悉心关怀下，他终于勇敢地从抑郁症的灰暗阴霾中走了出来。',
      'Zài xīnlǐ zīxúnshī hé qīnyǒu de xīxīn guānhuái xià, tā zhōngyú yǒnggǎn de cóng yìyùzhèng de huī''àn yīnmái zhōng zǒuchū lai le.',
      'Dưới sự chăm sóc ân cần của chuyên gia tư vấn tâm lý và người thân bạn bè, anh ấy cuối cùng đã dũng cảm bước ra khỏi đám mây mù u ám của căn bệnh trầm cảm.',
      '"从...阴霾中走出来" ca ngợi nghị lực phục hồi tinh thần tái hòa nhập cuộc sống.'
    ),
    (
      v_gp_id,
      '受灾地区人民擦干眼泪重建家园，以坚韧不拔的顽强毅力从特大自然灾害的创伤中走了出来。',
      'Shòuzāi dìqū rénmín cāgān yǎnlèi chóngjiàn jiāyuán, yǐ jiānrènbùbá de wánqiáng yìlì cóng tèdà zìrán zāihài de chuāngshāng zhōng zǒuchū lai le.',
      'Người dân vùng bị thiên tai lau khô nước mắt tái thiết quê hương, bằng ý chí ngoan cường kiên định không dời đã bước ra khỏi nỗi đau thương của thảm họa thiên nhiên kinh hoàng.',
      '"从创伤中走出来" khắc họa sức sống quật cường vươn lên từ đổ nát của nhân dân.'
    );

  -- Điểm ngữ pháp #108: Bổ ngữ trạng thái tầng bậc cực tả: "形容词 + 到 + 令人发指 / 令人叹为观止"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ trạng thái tầng bậc cực tả: "形容词 + 到 + 令人发指 / 令人叹为观止"',
    'Tính từ (残暴 / 逼真 / 严密 / 丰富) + 到 + 令人发指 (tiêu cực) / 令人叹为观止 (tích cực)',
    'Bổ ngữ',
    'Trong HSK 6, bổ ngữ trạng thái mở rộng kết hợp với giới từ "到" dẫn ra các thành ngữ bốn chữ miêu tả cảm xúc tột cùng của con người: 1) Đạt mức tàn nhẫn phẫn nộ cùng cực: "残忍到令人发指" (tàn nhẫn đến mức khiến người ta dựng tóc gáy phẫn nộ); 2) Đạt mức nghệ thuật tuyệt mỹ đỉnh cao: "精美到令人叹为观止" (tinh xảo đến mức khiến người ta phải trầm trồ thán phục).',
    'HSK 6',
    108,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '侵略军在战争中所犯下的屠杀虐待平民暴行，其手段残酷野蛮到了令人发指的地步。',
      'Qīnlüèjūn zài zhànzhēng zhōng suǒ fànxià de túshā nüèdài píngmín bàoxíng, qí shǒuduàn cánkù yěmán dào le lìngrénfàzhǐ de dìbù.',
      'Những tội ác dã man tàn sát ngược đãi thường dân mà quân xâm lược phạm phải trong chiến tranh, thủ đoạn của nó tàn khốc dã man tới mức khiến người ta phải dựng tóc gáy phẫn nộ.',
      '"野蛮到了令人发指的地步" đanh thép lên án tội ác chiến tranh tột cùng phi nhân tính.'
    ),
    (
      v_gp_id,
      '这件镂空雕刻象牙球工艺品层层相套且转动自如，技艺之精湛奇绝令人叹为观止。',
      'Zhè jiàn lòukōng diāokè xiàngyáqiú gōngyìpǐn céngcéng xiāngtào qiě zhuàndòng zìrú, jìyì zhī jīngzhàn qíjué lìngréntànwéiguānzhǐ.',
      'Món đồ thủ công mỹ nghệ quả cầu ngà voi chạm khắc lọng này từng tầng lồng vào nhau lại xoay chuyển tự do, kỹ nghệ tinh xảo kỳ tuyệt đến mức khiến người xem phải trầm trồ thán phục.',
      '"令人叹为观止" ca ngợi đỉnh cao tuyệt kỹ điêu khắc thủ công dân gian.'
    );

  -- Điểm ngữ pháp #109: Cấu trúc so sánh tu từ không hề thua kém: "不亚于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc so sánh tu từ không hề thua kém: "不亚于"',
    'Chủ ngữ A + 对...的影响 / 价值 + 绝不亚于 + Đối tượng chuẩn mực B',
    'Câu so sánh',
    '"不亚于" (bùyàyú) kết hợp chữ 不 (không), 亚 (thứ hai, kém hơn), 于 (so với), mang nghĩa "mức độ, sức ảnh hưởng hoặc tầm quan trọng hoàn toàn ngang hàng, tuyệt đối không thua kém gì đối tượng mẫu mực hàng đầu" (không thua kém gì, chẳng khác nào). Dùng để nâng tầm một sự vật mới sánh vai cùng tượng đài đã được công nhận.',
    'HSK 6',
    109,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这支青年创业团队研发的新型超级电池技术，在能量密度指标上绝不亚于国际领军巨头。',
      'Zhè zhī qīngnián chuàngyè tuánduì yánfā de xīnxíng chāojí diànchí jìshù, zài néngliàng mìdù zhǐbiāo shang jué bú yàyú guójì lǐngjūn jùtóu.',
      'Công nghệ pin siêu cấp thế hệ mới do nhóm khởi nghiệp trẻ này nghiên cứu phát triển trên chỉ số mật độ năng lượng tuyệt đối không thua kém gì các tập đoàn khổng lồ đầu ngành quốc tế.',
      '"绝不亚于国际巨头" khẳng định chất lượng kỹ thuật ngang ngửa với các ông lớn toàn cầu.'
    ),
    (
      v_gp_id,
      '在现代社会中，无形的信息网络诈骗对人民财产安全造成的破坏力，绝不亚于传统实体盗窃。',
      'Zài xiàndài shèhuì zhōng, wúxíng de xìnxī wǎngluò zhàpiàn duì rénmín cáichǎn ānquán zàochéng de pòhuàilì, jué bú yàyú chuántǒng shítǐ dàoqiè.',
      'Trong xã hội hiện đại, sức tàn phá của nạn lừa đảo mạng thông tin vô hình đối với an toàn tài sản của nhân dân tuyệt đối không thua kém gì các vụ trộm cắp thực thể truyền thống.',
      '"不亚于传统盗窃" so sánh mức độ nguy hại của tội phạm công nghệ cao với tội phạm truyền thống.'
    );

  -- Điểm ngữ pháp #110: Cấu trúc định vị góc nhìn đối sánh học thuật: "相较于...而言"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc định vị góc nhìn đối sánh học thuật: "相较于...而言"',
    '相较于 + Đối tượng đối chứng A + 而言, Đối tượng B + Có ưu thế vượt trội',
    'Câu so sánh',
    '"相较于...而言" (xiāngjiàoyú... éryán) là công thức định vị góc nhìn so sánh đối chiếu chuẩn mực trong các luận văn nghiên cứu khoa học (so sánh đối chiếu với đối tượng A mà nói). Dùng để đặt một sự vật vào trong hệ quy chiếu cụ thể để rút ra ưu nhược điểm khách quan.',
    'HSK 6',
    110,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '相较于传统的化石能源消耗模式而言，太阳能光伏发电具有清洁低碳、取之不尽的巨大综合优势。',
      'Xiāngjiàoyú chuántǒng de huàshí néngyuán xiāohào móshì éryán, tàiyángnéng guāngfú fādiàn jùyǒu qīngjié dītàn, qǔzhībújìn de jùdà zōnghé yōushì.',
      'So với mô hình tiêu hao năng lượng hóa thạch truyền thống mà nói, phát điện quang điện mặt trời hội tụ ưu thế tổng hợp to lớn sạch sẽ giảm thiểu carbon và khai thác không bao giờ cạn.',
      '"相较于...而言" đặt năng lượng mặt trời lên bàn cân đối chiếu với năng lượng hóa thạch.'
    ),
    (
      v_gp_id,
      '相较于大刀阔斧的激进变革而言，循序渐进的渐进式改良往往更容易凝聚社会共识并降低转型成本。',
      'Xiāngjiàoyú dàdāokuòfǔ de jījìn biàngé éryán, xúnxùjiànjìn de jiànjìnshì gǎiliáng wǎngwǎng gèng róngyì níngjù shèhuì gòngshí bìng jiàngdī zhuǎnxíng chéngběn.',
      'So với sự biến cách cấp tiến làm mạnh tay rầm rộ mà nói, sự cải lương tiệm tiến từng bước thường dễ dàng quy tụ đồng thuận xã hội và giảm thiểu chi phí chuyển đổi hơn.',
      '"相较于...而言" phân tích so sánh hai phương pháp luận cải cách thể chế chính trị xã hội.'
    );

  -- Điểm ngữ pháp #111: Cấu trúc so sánh mức độ cách biệt cực xa: "远甚于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc so sánh mức độ cách biệt cực xa: "远甚于"',
    'Chủ ngữ A + 带来的危害 / 意义 + 远甚于 + Đối tượng B',
    'Câu so sánh',
    '"远甚于" (yuǎn shèn yú) kết hợp chữ 远 (xa, nhiều), 甚 (dữ dội, nặng nề), 于 (hơn), mang nghĩa "vượt xa hơn rất nhiều so với, mức độ nghiêm trọng hoặc to lớn hơn gấp bội phần đối tượng so sánh". Dùng khi phân tích mức độ chênh lệch cực lớn giữa hai yếu tố.',
    'HSK 6',
    111,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '重大虚假财务造假行为对资本市场健康生态造成的毁灭性打击，其恶劣程度远甚于普通商业违约。',
      'Zhòngdà xūjiǎ cáiwù zàojiǎ xíngwéi duì zīběn shìchǎng jiànkāng shēngtài zàochéng de huǐmièxìng dǎjī, qí èliè chéngdù yuǎn shèn yú pǔtōng shāngyè wéiyuē.',
      'Đòn đánh hủy diệt mà hành vi làm giả báo cáo tài chính trọng đại gây ra đối với hệ sinh thái lành mạnh của thị trường vốn, mức độ ác liệt của nó vượt xa hơn rất nhiều so với việc vi phạm hợp đồng thương mại thông thường.',
      '"远甚于普通商业违约" vạch rõ ranh giới hiểm họa của tội phạm gian lận tài chính vĩ mô.'
    ),
    (
      v_gp_id,
      '青年时代树立崇高理想对一生人格成长所起的潜移默化滋养作用，其深远意义远甚于一时的考试名次。',
      'Qīngnián shídài shùlì chónggāo lǐxiǎng duì yìshēng réngé chéngzhǎng suǒ qǐ de qiányímòhuà zīyǎng zuòyòng, qí shēnyuǎn yìyì yuǎn shèn yú yìshí de kǎoshì míngcì.',
      'Tác dụng nuôi dưỡng thẩm thấu âm thầm của việc xây dựng lý tưởng cao đẹp thời thanh xuân đối với sự trưởng thành nhân cách cả đời, ý nghĩa sâu xa của nó vượt xa hơn rất nhiều so với thứ hạng thi cử nhất thời.',
      '"远甚于一时的名次" định hướng triết lý giáo dục nhân cách cao hơn thành tích thi cử ngắn hạn.'
    );

  -- Điểm ngữ pháp #112: Cấu trúc điều kiện ràng buộc tiên quyết: "以...为前提"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc điều kiện ràng buộc tiên quyết: "以...为前提"',
    'Tiến hành hợp tác / Phát triển kinh tế, 必须 + 以...为前提',
    'Cấu trúc cố định',
    '"以...为前提" (yǐ... wéi qiántí) là cấu trúc pháp lý và ngoại giao chuẩn xác, biểu thị điều kiện A là tiền đề bắt buộc không thể thương lượng; nếu không đáp ứng được điều kiện tiên quyết A này thì toàn bộ thỏa thuận hoặc hành động tiếp theo đều trở nên vô nghĩa và không thể diễn ra.',
    'HSK 6',
    112,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '世界各国开展平等经贸往来的根本基石，必须以互相尊重国家主权与核心利益为前提。',
      'Shìjiè gèguó kāizhǎn píngděng jīngmào wǎnglái de gēnběn jīshí, bìxū yǐ hùxiāng zūnzhòng guójiā zhǔquán yǔ héxīn lìyì wéi qiántí.',
      'Nền tảng căn bản để các quốc gia trên thế giới triển khai giao lưu kinh tế thương mại bình đẳng bắt buộc phải lấy việc tôn trọng lẫn nhau về chủ quyền quốc gia và lợi ích cốt lõi làm tiền đề tiên quyết.',
      '"以互相尊重...为前提" xác lập nguyên tắc bang giao quốc tế không thể xâm phạm.'
    ),
    (
      v_gp_id,
      '任何商业模式的技术创新与利润追求，都必须以绝对保障消费者的生命财产安全为前提。',
      'Rènhé shāngyè móshì de jìshù chuàngxīn yǔ lìrùn zhuīqiú, dōu bìxū yǐ juéduì bǎozhàng xiāofèizhě de shēngmìng cáichǎn ānquán wéi qiántí.',
      'Bất kỳ sự đổi mới công nghệ và mưu cầu lợi nhuận nào của mô hình kinh doanh đều bắt buộc phải lấy việc bảo đảm tuyệt đối an toàn tính mạng và tài sản của người tiêu dùng làm tiền đề.',
      '"以绝对保障...安全为前提" đặt an toàn tính mạng con người lên trên mọi mưu cầu lợi nhuận.'
    );

  -- Điểm ngữ pháp #113: Cấu trúc điểm tựa nương tựa phát triển: "以...为依托"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc điểm tựa nương tựa phát triển: "以...为依托"',
    'Dự án / Doanh nghiệp + 以 + Điểm tựa vững chắc (实体产业 / 科技实力 / 广阔市场) + 为依托',
    'Cấu trúc cố định',
    '"以...为依托" (yǐ... wéi yītuō) kết hợp chữ 依托 (chỗ dựa, điểm tựa), biểu thị một tổ chức, một kế hoạch kinh doanh hoặc đề tài nghiên cứu lấy một thế mạnh sẵn có làm bệ đỡ vững chắc để sinh tồn và phát triển vươn lên (dựa vào, lấy... làm điểm tựa).',
    'HSK 6',
    113,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '该自由贸易试验区以粤港澳大湾区雄厚完整的制造业产业链为依托，打造世界级创新高地。',
      'Gāi zìyóu màoyì shìyànqū yǐ Yuè-Gǎng-Ào Dàwānqū xiónghòu wánzhěng de zhìzàoyè chǎnyèliàn wéi yītuō, dǎzào shìjièjí chuàngxīn gāodì.',
      'Khu thí điểm thương mại tự do này lấy chuỗi ngành chế tạo hùng hậu hoàn chỉnh của Vùng vịnh lớn Quảng Đông - Hồng Kông - Ma Cao làm điểm tựa vững chắc, kiến tạo nên vùng đất cao đổi mới cấp thế giới.',
      '"以...制造业产业链为依托" làm rõ bệ phóng công nghiệp giúp khu thương mại cất cánh.'
    ),
    (
      v_gp_id,
      '现代金融服务业必须始终坚持以实体经济为坚强依托，决不能脱实向虚搞自我循环的投机泡沫。',
      'Xiàndài jīnróng fúwùyè bìxū shǐzhōng jiānchí yǐ shítǐ jīngjì wéi jiānqiáng yītuō, jué bù néng tuōshíxiàngxū gǎo zìwǒ xúnhuán de tóujī pàomò.',
      'Ngành dịch vụ tài chính hiện đại bắt buộc phải luôn luôn kiên trì lấy nền kinh tế thực thể làm chỗ dựa vững chắc, quyết không thể rời xa thực tế hướng vào ảo để tạo ra những bong bóng đầu cơ tự tuần hoàn.',
      '"以实体经济为坚强依托" khẳng định mối quan hệ cộng sinh giữa dòng tiền tài chính và sản xuất thực.'
    );

  -- Điểm ngữ pháp #114: Cấu trúc định hướng kim chỉ nam hành động: "以...为导向"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc định hướng kim chỉ nam hành động: "以...为导向"',
    'Chính sách / Nghiên cứu / Giáo dục + 必须 + 以...为导向 (市场需求 / 问题 / 结果 / 人民满意)',
    'Cấu trúc cố định',
    '"以...为导向" (yǐ... wéi dǎoxiàng) biểu thị việc xác định mục tiêu hoặc nhu cầu thực tiễn làm kim chỉ nam chỉ đạo phương hướng cho toàn bộ quá trình hành động, nghiên cứu hay ban hành chính sách (lấy... làm kim chỉ nam định hướng). Thường gặp: 以市场需求为导向 (lấy nhu cầu thị trường làm định hướng).',
    'HSK 6',
    114,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '高校的人才培养方案必须紧密以国家重大战略需求和产业未来趋势为导向。',
      'Gāoxiào de réncái péiyǎng fāng''àn bìxū jǐnmì yǐ guójiā zhòngdà zhànlüè xūqiú hé chǎnyè wèilái qūshì wéi dǎoxiàng.',
      'Phương án đào tạo nhân tài của các trường đại học bắt buộc phải lấy nhu cầu chiến lược trọng đại của quốc gia và xu thế tương lai của ngành nghề làm kim chỉ nam định hướng chặt chẽ.',
      '"以...需求为导向" định hình mối liên kết giữa giảng dạy đại học và bài toán phát triển đất nước.'
    ),
    (
      v_gp_id,
      '各级政府部门深化放管服改革，必须始终坚持以人民群众的切身满意度为根本工作导向。',
      'Gèjí zhèngfǔ bùmén shēnhuà fàngguǎnfú gǎigé, bìxū shǐzhōng jiānchí yǐ rénmín qúnzhòng de qiēshēn mǎnyìdù wéi gēnběn gōngzuò dǎoxiàng.',
      'Các cấp ban ngành chính phủ làm sâu sắc cải cách tinh gọn thủ tục hành chính bắt buộc phải luôn luôn kiên trì lấy sự hài lòng thiết thân của quần chúng nhân dân làm kim chỉ nam công tác căn bản.',
      '"以人民满意度为导向" là chuẩn mực đánh giá chất lượng phục vụ công vụ nhà nước.'
    );

  -- Điểm ngữ pháp #115: Cấu trúc nguồn gốc quy nạp tính chất: "由...所决定"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc nguồn gốc quy nạp tính chất: "由...所决定"',
    'Bản chất của sự vật + 是由 + Nguyên nhân nội tại cốt lõi + 所决定的',
    'Cấu trúc cố định',
    '"由...所决定" (yóu... suǒ juédìng) là mẫu câu triết học chính luận kinh điển, dùng chữ "由" (do) kết hợp trợ từ "所" để khẳng định mạnh mẽ tính tất yếu: tính chất, quy luật hoặc vận mệnh của sự vật là do một yếu tố bản chất nội tại quyết định, chứ không phải ngẫu nhiên sinh ra.',
    'HSK 6',
    115,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '中国始终奉行防御性的国防政策，这是由我国社会主义国家性质和走和平发展道路的战略抉择所决定的。',
      'Zhōngguó shǐzhōng fèngxíng fángyùxìng de guófáng zhèngcè, zhè shì yóu wǒ guó shèhuìzhǔyì guójiā xìngzhì hé zǒu hépíng fāzhǎn dàolù de zhànlüè juézé suǒ juédìng de.',
      'Trung Quốc luôn luôn theo đuổi chính sách quốc phòng mang tính phòng ngự, điều này là do bản chất nhà nước xã hội chủ nghĩa và sự lựa chọn chiến lược đi theo con đường phát triển hòa bình của nước ta quyết định.',
      '"是由...所决定的" là lời tuyên bố lập trường đối ngoại khẳng định bản chất yêu chuộng hòa bình của quốc gia.'
    ),
    (
      v_gp_id,
      '物质生产方式在人类历史演进中所起的最终决定作用，是由人类生存必须获取生活资料的基本规律所决定的。',
      'Wùzhì shēngchǎn fāngshì zài rénlèi lìshǐ yǎnjìn zhōng suǒ qǐ de zuìzhōng juédìng zuòyòng, shì yóu rénlèi shēngcún bìxū huòqǔ shēnghuó zīliào de jīběn guīlǜ suǒ juédìng de.',
      'Tác dụng quyết định cuối cùng của phương thức sản xuất vật chất trong tiến trình lịch sử nhân loại là do quy luật cơ bản con người sinh tồn bắt buộc phải thu hoạch tư liệu sinh hoạt quyết định.',
      '"是由...规律所决定的" làm sáng tỏ nguyên lý duy vật lịch sử về vai trò của sản xuất vật chất.'
    );

  -- Điểm ngữ pháp #116: Cấu trúc quan hệ phụ thuộc hữu cơ: "附属于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc quan hệ phụ thuộc hữu cơ: "附属于"',
    'Chủ thể B + 始终附属于 / 绝不是附属于 + Chủ thể A',
    'Cấu trúc cố định',
    '"附属于" (fùshǔyú) kết hợp chữ 附属 (phụ thuộc, trực thuộc) và 于, mang nghĩa thuộc về, lệ thuộc vào một tổng thể lớn hơn, không thể tách rời tồn tại độc lập (trực thuộc, phụ thuộc vào).',
    'HSK 6',
    116,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这些小岛屿自古以来在地理、历史及法律管辖上都始终紧密附属于祖国大陆，是不可分割的一部分。',
      'Zhèxiē xiǎodǎoyǔ zìgǔyǐlái zài dìlǐ, lìshǐ jí fǎlǜ guǎnxiá shang dōu shǐzhōng jǐnmì fùshǔyú zǔguó dàlù, shì bùkě fēngē de yí bùfen.',
      'Những hòn đảo nhỏ này từ xưa đến nay trên phương diện địa lý, lịch sử và quyền tài phán pháp luật đều luôn luôn gắn kết phụ thuộc chặt chẽ vào đại lục tổ quốc, là một bộ phận không thể tách rời.',
      '"附属于祖国大陆" khẳng định chứng cứ chủ quyền lãnh thổ hải đảo thiêng liêng.'
    ),
    (
      v_gp_id,
      '文艺创作绝不是单纯附属于商业资本的赚钱工具，它拥有独立的审美追求与崇高的人文灵魂。',
      'Wényì chuàngzuò jué bú shì dānchún fùshǔyú shāngyè zīběn de zhuànqián gōngjù, tā yōngyǒu dúlì de shěnměi zhuīqiú yǔ chónggāo de rénwén línghún.',
      'Sáng tác văn nghệ tuyệt đối không phải là công cụ kiếm tiền đơn thuần phụ thuộc vào tư bản thương mại, nó nắm giữ sự theo đuổi thẩm mỹ độc lập và linh hồn nhân văn cao cả.',
      '"绝不是附属于商业资本" bảo vệ phẩm giá tự do sáng tạo nghệ thuật độc lập.'
    );

  -- Điểm ngữ pháp #117: Cấu trúc tích lũy theo thời gian tạo biến đổi về chất: "日积月累"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tích lũy theo thời gian tạo biến đổi về chất: "日积月累"',
    '经过 + 日积月累的 (努力 / 积累 / 钻研), 才能 + Gặt hái thành tựu',
    'Cấu trúc cố định',
    '"日积月累" (rì jī yuè lěi) kết hợp chữ 日 (ngày), 积 (tích cóp), 月 (tháng), 累 (chất chồng), miêu tả quá trình tích lũy kiến thức, kinh nghiệm hoặc rèn luyện kỹ năng qua từng ngày từng tháng lâu bền cho tới khi tạo nên bước nhảy vọt thần kỳ về lượng biến thành chất biến (ngày tích tháng dồn, tích tiểu thành đại).',
    'HSK 6',
    117,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '学问与技艺的真正大成绝无任何捷径可走，靠的完全是数十年如一日日积月累的苦功夫。',
      'Xuéwèn yǔ jìyì de zhēnzhèng dàchéng jué wú rènhé jiéjìng kě zǒu, kào de wánquán shì shùshí nián rú yí rì rìjīyuèlěi de kǔ gōngfu.',
      'Sự đại thành thực sự của học vấn và tay nghề tuyệt đối không có bất kỳ con đường tắt nào để đi, cái dựa vào hoàn toàn là công phu gian khổ ngày tích tháng dồn mấy chục năm như một ngày.',
      '"日积月累的苦功夫" khẳng định chân lý khổ luyện thành tài không có đường tắt.'
    ),
    (
      v_gp_id,
      '良好语言语感的培养源于每天坚持听读背诵，经过日积月累，自然能出口成章、下笔有神。',
      'Liánghǎo yǔyán yǔgǎn de péiyǎng yuányú měitiān jiānchí tīng dú bèisòng, jīngguò rìjīyuèlěi, zìrán néng chūkǒuchéngzhāng, xiàbǐyǒushén.',
      'Việc bồi dưỡng cảm thụ ngôn ngữ tốt đẹp bắt nguồn từ việc kiên trì nghe đọc học thuộc mỗi ngày, trải qua ngày tích tháng dồn, tự nhiên sẽ có thể mở miệng thành lời hay, hạ bút có thần sắc.',
      '"经过日积月累" động viên người học ngoại ngữ bền bỉ luyện tập tích lũy hằng ngày.'
    );

  -- Điểm ngữ pháp #118: Cấu trúc biến đổi vĩ đại long trời lở đất: "翻天覆地"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc biến đổi vĩ đại long trời lở đất: "翻天覆地"',
    'Nơi chốn / Đất nước + 发生了 + 翻天覆地的历史性巨变',
    'Cấu trúc cố định',
    '"翻天覆地" (fān tiān fù dì) kết hợp chữ 翻天 (lật trời) và 覆地 (đảo đất), là thành ngữ phóng đại hùng tráng miêu tả sự biến đổi, đổi thay mang tính cách mạng toàn diện, triệt để đến mức làm thay đổi hoàn toàn diện mạo của non sông, xã hội (long trời lở đất, thay trời đổi đất).',
    'HSK 6',
    118,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '改革开放四十多年来，这片曾经贫困闭塞的古老土地发生了翻天覆地的历史性巨变。',
      'Gǎigé kāifàng sìshí duō nián lái, zhè piàn céngjīng pínkùn bìsè de gǔlǎo tǔdì fāshēng le fāntiānfùdì de lìshǐxìng jùbiàn.',
      'Hơn 40 năm cải cách mở cửa đến nay, mảnh đất cổ xưa từng nghèo khó khép kín này đã xảy ra sự đổi thay lịch sử to lớn long trời lở đất.',
      '"翻天覆地的历史性巨变" ca ngợi thành tựu vĩ đại của công cuộc đổi mới hiện đại hóa đất nước.'
    ),
    (
      v_gp_id,
      '高新技术的迅猛发展正在以颠覆性的力量重构传统商业模式，给人们的生活方式带来了翻天覆地的变化。',
      'Gāoxīn jìshù de xùnměng fāzhǎn zhèngzài yǐ diānfùxìng de lìliàng chónggòu chuántǒng shāngyè móshì, gěi rénmen de shēnghuó fāngshì dàilái le fāntiānfùdì de biànhuà.',
      'Sự phát triển vũ bão của công nghệ cao mới đang bằng sức mạnh mang tính đảo lộn tái cấu trúc mô hình kinh doanh truyền thống, đem lại những biến đổi long trời lở đất cho lối sống của con người.',
      '"翻天覆地的变化" lột tả sức mạnh xoay chuyển càn khôn của cuộc cách mạng công nghệ số.'
    );

  -- Điểm ngữ pháp #119: Cấu trúc thành tựu vĩ đại khiến cả thế giới dõi theo: "举世瞩目"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc thành tựu vĩ đại khiến cả thế giới dõi theo: "举世瞩目"',
    '取得 / 创造了 + 举世瞩目的 (辉煌成就 / 伟大奇迹 / 巨大飞跃)',
    'Cấu trúc cố định',
    '"举世瞩目" (jǔshì zhǔmù) kết hợp chữ 举世 (toàn thế giới), 瞩目 (dõi mắt dõi theo ngắm nhìn), miêu tả một thành tựu khoa học, công trình kỳ tích hoặc sự trỗi dậy kinh tế đạt tới tầm vóc phi thường khiến toàn thể nhân loại trên trái đất đều phải ngước nhìn dõi theo thán phục.',
    'HSK 6',
    119,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经过几代人的艰辛探索与无私奉献，中国载人航天工程取得了举世瞩目的辉煌跨越。',
      'Jīngguò jǐ dài rén de jiānxīn tànsuǒ yǔ wúsī fèngxiàn, Zhōngguó zàirén hángtiān gōngchéng qǔdé le jǔshìzhǔmù de huīhuáng kuàyuè.',
      'Qua sự tìm tòi gian nan và cống hiến quên mình của mấy thế hệ, công trình hàng không vũ trụ có người lái của Trung Quốc đã giành được bước nhảy vọt huy hoàng khiến cả thế giới dõi theo ngưỡng mộ.',
      '"举世瞩目的辉煌跨越" tôn vinh kỳ tích chinh phục không gian vũ trụ của các nhà khoa học.'
    ),
    (
      v_gp_id,
      '我国在消除绝对贫困这一困扰人类数千年的历史性难题上，创造了令举世瞩目的伟大奇迹。',
      'Wǒ guó zài xiāochú juéduì pínkùn zhè yì kùnrǎo rénlèi shù qiān nián de lìshǐxìng nándí shang, chuàngzào le lìng jǔshìzhǔmù de wěidà qíjì.',
      'Nước ta trên bài toán khó lịch sử quấy rầy nhân loại suốt mấy nghìn năm qua là xóa bỏ đói nghèo tuyệt đối, đã kiến tạo nên một kỳ tích vĩ đại khiến toàn thế giới đều phải dõi mắt thán phục.',
      '"令举世瞩目的伟大奇迹" ghi nhận thành tựu xóa đói giảm nghèo vĩ đại cống hiến cho văn minh nhân loại.'
    );

  -- Điểm ngữ pháp #120: Cấu trúc mưa dầm thấm lâu thẩm thấu âm thầm: "潜移默化"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc mưa dầm thấm lâu thẩm thấu âm thầm: "潜移默化"',
    'Nền giáo dục / Môi trường gia đình + 起到了 + 潜移默化的熏陶作用',
    'Cấu trúc cố định',
    '"潜移默化" (qián yí mò huà) kết hợp chữ 潜 (ngấm ngầm, vô hình), 移 (chuyển dịch), 默 (lặng lẽ, không tiếng động), 化 (cải hóa, biến đổi), miêu tả sự hun đúc tư tưởng, đạo đức, thẩm mỹ hoặc thói quen diễn ra tự nhiên, từ từ như mưa dầm thấm đất, khiến con người biến đổi tính cách mà bản thân không hề hay biết.',
    'HSK 6',
    120,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '优秀的经典文学名著对青少年精神品格的塑造，起着春风化雨、潜移默化的深远滋养作用。',
      'Yōuxiù de jīngdiǎn wénxué míngzhù duì qīngshàonián jīngshén pǐngé de sùzào, qǐzhe chūnfēnghuàyǔ, qiányímòhuà de shēnyuǎn zīyǎng zuòyòng.',
      'Những danh tác văn học kinh điển xuất sắc đối với việc đắp nặn phẩm cách tinh thần của thanh thiếu niên đóng vai trò nuôi dưỡng sâu xa như gió xuân mơn man, mưa dầm thấm lâu biến đổi âm thầm.',
      '"潜移默化的滋养作用" khẳng định giá trị hun đúc nhân cách bền bỉ của việc đọc sách văn học cổ điển.'
    ),
    (
      v_gp_id,
      '父母在日常生活中言谈举止所展现的文明修养，正在潜移默化地深刻影响着孩子的行为习惯。',
      'Fùmǔ zài rìcháng shēnghuó zhōng yántánjǔzhǐ suǒ zhǎnxiàn de wénmíng xiūyǎng, zhèngzài qiányímòhuà de shēnkè yǐngxiǎngzhe háizi de xíngwéi xíguàn.',
      'Sự tu dưỡng văn minh thể hiện trong từng lời ăn tiếng nói cử chỉ hằng ngày của cha mẹ đang âm thầm ngấm dần ảnh hưởng sâu sắc tới thói quen hành vi của con cái.',
      '"潜移默化地影响" nêu bật vai trò làm gương mẫu mực của đấng sinh thành trong giáo dục gia đình.'
    );

  -- Điểm ngữ pháp #121: Cấu trúc chí nguyện thề son sắt không dời: "矢志不渝"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc chí nguyện thề son sắt không dời: "矢志不渝"',
    'Chủ ngữ + 始终 + 矢志不渝地 + Động từ (奋斗 / 坚守 / 追求 / 奉献)',
    'Cấu trúc cố định',
    '"矢志不渝" (shǐ zhì bù yú) kết hợp chữ 矢 (thề, bắn mũi tên thề), 志 (chí hướng, lý tưởng), 渝 (thay đổi, phụ bạc), biểu thị ý chí son sắt, lời thề thủy chung son sắt đối với lý tưởng, tình yêu hoặc sự nghiệp cách mạng, dù trải qua muôn trùng bão táp sinh tử cũng tuyệt đối không bao giờ phản bội hay đổi thay.',
    'HSK 6',
    121,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '老一辈革命家为了实现民族独立与人民解放的宏伟誓愿，抛家舍业、矢志不渝。',
      'Lǎoyíbèi gémìngjiā wèile shíxiàn mínzú dúlì yǔ rénmín jiěfàng de hóngwěi shìyuàn, pāojiāshěyè, shǐzhìbùyú.',
      'Các nhà cách mạng thế hệ tiền bối vì hiện thực hóa lời thề nguyện hùng vĩ độc lập dân tộc và giải phóng nhân dân đã gác lại gia đình dấn thân cống hiến, son sắt một lòng thề không đổi dời.',
      '"矢志不渝" ca ngợi lòng kiên trung bất khuất của các chiến sĩ tiền bối vì non sông.'
    ),
    (
      v_gp_id,
      '一代代塞罕坝务林人扎根荒漠六十年如一日，矢志不渝地在高原荒原上筑起了一道绿色生态屏障。',
      'Yídàidài Sàihǎnbà wùlínrén zhāgēn huāngmò liùshí nián rú yí rì, shǐzhìbùyú de zài gāoyuán huāngyuán shang zhùqǐ le yí dào lǜsè shēngtài píngzhàng.',
      'Bao thế hệ người trồng rừng Saihanba bám rễ nơi hoang mạc suốt 60 năm như một ngày, kiên định son sắt không đổi dời đã dựng nên một tấm bình phong sinh thái xanh biếc trên cao nguyên hoang cằn.',
      '"矢志不渝地筑起屏障" tôn vinh tinh thần trồng rừng bền bỉ cải tạo thiên nhiên của những người hùng thầm lặng.'
    );

  -- Điểm ngữ pháp #122: Cấu trúc cội nguồn văn hóa truyền thống sâu dày: "源远流长"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cội nguồn văn hóa truyền thống sâu dày: "源远流长"',
    'Chủ ngữ + 历史悠久, 源远流长 / 友谊源远流长',
    'Cấu trúc cố định',
    '"源远流长" (yuán yuǎn liú cháng) kết hợp chữ 源 (nguồn nước), 远 (xa xôi), 流 (dòng chảy), 长 (dài lâu), mang nghĩa nguồn cội xuất phát từ thời cổ đại xa xôi, dòng chảy kế thừa liên tục xuyên suốt ngàn năm mà không bao giờ đứt đoạn (nguồn xa dòng dài, có bề dày lịch sử ngàn năm). Chuyên dùng cho văn hóa, hữu nghị quốc tế.',
    'HSK 6',
    122,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '中华优秀传统文化源远流长、博大精深，是我们在世界文化激荡中站稳脚跟的坚实根基。',
      'Zhōnghuá yōuxiù chuántǒng wénhuà yuányuǎnliúcháng, bódàjīngshēn, shì wǒmen zài shìjiè wénhuà jīdàng zhōng zhànwěn jiǎogēn de jiānshí gēnjī.',
      'Văn hóa truyền thống xuất sắc của Trung Hoa nguồn xa dòng dài, uyên bác tinh thâm, chính là nền tảng vững chắc giúp chúng ta đứng vững gót chân giữa sự biến động sóng gió của văn hóa thế giới.',
      '"源远流长、博大精深" là cặp thành ngữ chuẩn mực nhất ca ngợi bề dày lịch sử của nền văn minh Trung Hoa.'
    ),
    (
      v_gp_id,
      '中非两国人民之间的深厚友谊源远流长，历经国际风云变幻的严峻考验而历久弥坚。',
      'Zhōng-Fēi liǎng guó rénmín zhījiān de shēnhòu yǒuyì yuányuǎnliúcháng, lìjīng guójì fēngyún biànhuàn de yánjùn kǎoyàn ér lìjiǔmíjiān.',
      'Tình hữu nghị sâu đậm giữa nhân dân hai nước Trung Quốc và châu Phi nguồn xa dòng dài, trải qua các thử thách ngặt nghèo của phong vân biến đổi quốc tế mà ngày càng thêm son sắt bền chặt.',
      '"友谊源远流长，历久弥坚" là công thức ngoại giao mẫu mực khẳng định tình bạn truyền thống quốc tế trường tồn.'
    );

  -- Điểm ngữ pháp #123: Cấu trúc gắn bó hòa hợp tự nhiên không tì vết: "天衣无缝"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc gắn bó hòa hợp tự nhiên không tì vết: "天衣无缝"',
    'Cấu trúc / Sự phối hợp / Kế hoạch + 严密到 + 天衣无缝',
    'Cấu trúc cố định',
    '"天衣无缝" (tiān yī wú fèng) bắt nguồn từ truyền thuyết: chiếc áo của tiên nữ trên trời dệt bằng mây ngũ sắc không hề có một đường kim mũi chỉ nào ráp nối. Dùng để khen ngợi một kế hoạch chu toàn, một kết cấu văn chương liền mạch hoặc sự phối hợp tác chiến ăn ý hoàn mỹ không một kẽ hở (kín kẽ không một kẽ hở, hoàn hảo tự nhiên).',
    'HSK 6',
    123,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这支双人花样滑冰组合在冰面上的动作编排行云流水，彼此默契配合得堪称天衣无缝。',
      'Zhè zhī shuāngrén huāyàng huábīng zǔhé zài bīngmiàn shang de dòngzuò biānpái xíngyúnliúshuǐ, bǐcǐ mòqì pèihé de kānchēng tiānyīwúfèng.',
      'Cặp đôi trượt băng nghệ thuật này trên mặt băng có sự dàn dựng động tác uyển chuyển như mây trôi nước chảy, sự phối hợp ăn ý ngầm của đôi bên đáng gọi là hoàn hảo không một tì vết.',
      '"配合得堪称天衣无缝" ca ngợi sự ăn ý tuyệt đỉnh của cặp vận động viên vô địch trượt băng.'
    ),
    (
      v_gp_id,
      '犯罪分子自以为作案计划设计得天衣无缝，殊不知在现代高科技刑侦技术面前漏洞百出。',
      'Fànzuì fènzǐ zìyǐwéi zuò''àn jìhuà shèjì de tiānyīwúfèng, shūbùzhī zài xiàndài gāokējì xíngzhēn jìshù miànqián lòudòngbǎichū.',
      'Kẻ phạm tội tự ngỡ kế hoạch gây án của mình được thiết kế kín kẽ không một kẽ hở, đâu ngờ rằng trước công nghệ điều tra hình sự công nghệ cao hiện đại lại lộ ra trăm nghìn sơ hở.',
      '"设计得天衣无缝" miêu tả sự tự mãn sai lầm của kẻ gian trước sự phá án tinh tường của công an.'
    );

END $$;

COMMIT;
