-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 10 (100 TỪ CUỐI CÙNG)
-- Phạm vi: #1901 [原谅] (yuánliàng) -> #2000 [作者] (zuòzhě) - CÁN ĐÍCH 100%
-- Tổng số câu ví dụ: 200 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Không tạo từ mới hay bản ghi trùng trong vocabularies
--   - Cập nhật chuẩn hóa cột word_type (Từ loại) và meaning_vi (Nghĩa TV)
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ các cột tương thích ngược example_hanzi, example_pinyin, example_vi
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
  -- [原谅] (yuánliàng) - tha thứ, lượng thứ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '原谅' AND pinyin = 'yuánliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '原谅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yuánliàng',
      meaning_vi = 'tha thứ, lượng thứ',
      example_hanzi = '既然他已经真诚地向大家道歉认错，我们就原谅他这次无心的过失吧。',
      example_pinyin = 'Jìrán tā yǐjīng zhēnchéng de xiàng dàjiā dàoqiàn rèncuò, wǒmen jiù yuánliàng tā zhè cì wúxīn de guòshī ba.',
      example_vi = 'Đã là anh ấy đã chân thành xin lỗi nhận lỗi với mọi người rồi, chúng ta hãy tha thứ cho sai sót vô tình lần này của anh ấy đi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '既然他已经真诚地向大家道歉认错，我们就原谅他这次无心的过失吧。', 'Jìrán tā yǐjīng zhēnchéng de xiàng dàjiā dàoqiàn rèncuò, wǒmen jiù yuánliàng tā zhè cì wúxīn de guòshī ba.', 'Đã là anh ấy đã chân thành xin lỗi nhận lỗi với mọi người rồi, chúng ta hãy tha thứ cho sai sót vô tình lần này của anh ấy đi.', 'basic', 1),
        (v_id, '在处理民商事纠纷调解中，司法人员引导当事人互谅互让，用宽广包容之心化解多年的深重矛盾。', 'Zài chǔlǐ mín-shāngshì jiūfēn tiáojiě zhōng, sīfǎ rényuán yǐndǎo dāngshìrén hùliàng-hùràng, yòng kuānguǎng bāoróng zhī xīn huàjiě duō nián de shēnzhòng máodùn.', 'Trong quá trình hòa giải các tranh chấp dân sự và thương mại, cán bộ tư pháp hướng dẫn các bên đương sự thông cảm nhường nhịn lẫn nhau, dùng tấm lòng bao dung rộng lượng để hóa giải những mâu thuẫn sâu nặng nhiều năm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [原因] (yuányīn) - nguyên nhân, lý do [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '原因' AND pinyin = 'yuányīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '原因'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yuányīn',
      meaning_vi = 'nguyên nhân, lý do',
      example_hanzi = '经过细致排查，技术人员终于找到了家用电脑突然无法开机的真正原因。',
      example_pinyin = 'Jīngguò xìzhì páichá, jìshù rényuán zhōngyú zhǎodào le jiāyòng diànnǎo tūrán wúfǎ kāijī de zhēnzhèng yuányīn.',
      example_vi = 'Trải qua sự rà soát tỉ mỉ, nhân viên kỹ thuật cuối cùng đã tìm ra nguyên nhân thực sự khiến chiếc máy tính gia đình đột nhiên không thể mở máy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过细致排查，技术人员终于找到了家用电脑突然无法开机的真正原因。', 'Jīngguò xìzhì páichá, jìshù rényuán zhōngyú zhǎodào le jiāyòng diànnǎo tūrán wúfǎ kāijī de zhēnzhèng yuányīn.', 'Trải qua sự rà soát tỉ mỉ, nhân viên kỹ thuật cuối cùng đã tìm ra nguyên nhân thực sự khiến chiếc máy tính gia đình đột nhiên không thể mở máy.', 'basic', 1),
        (v_id, '宏观经济分析师通过大量翔实的数据建模，深入剖析了本轮国际能源价格大幅波动的深层次结构性原因。', 'Hóngguān jīngjì fēnxīshī tōngguò dàliàng xiángshí de shùjù jiànmó, shēnrù pōuxī le běn lún guójì néngyuán jiàgé dàfú bōdòng de shēncéngcì jiégòuxìng yuányīn.', 'Chuyên gia phân tích kinh tế vĩ mô thông qua lượng lớn mô hình dữ liệu xác thực, đã mổ xẻ sâu sắc những nguyên nhân mang tính cơ cấu sâu xa của đợt biến động mạnh giá năng lượng quốc tế lần này.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [远离] (yuǎnlí) - tránh xa, rời xa [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '远离' AND pinyin = 'yuǎnlí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '远离'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yuǎnlí',
      meaning_vi = 'tránh xa, rời xa',
      example_hanzi = '为了身体健康和心理阳光，青少年在日常生活中应当自觉远离网络游戏沉迷。',
      example_pinyin = 'Wèile shēntǐ jiànkāng hé xīnlǐ yángguāng, qīngshàonián zài rìcháng shēnghuó zhōng yīngdāng zìjué yuǎnlí wǎngluò yóuxì chénmí.',
      example_vi = 'Vì sức khỏe thể chất và tâm lý lành mạnh, thanh thiếu niên trong sinh hoạt hằng ngày cần tự giác tránh xa việc đắm chìm vào trò chơi điện tử trực tuyến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了身体健康和心理阳光，青少年在日常生活中应当自觉远离网络游戏沉迷。', 'Wèile shēntǐ jiànkāng hé xīnlǐ yángguāng, qīngshàonián zài rìcháng shēnghuó zhōng yīngdāng zìjué yuǎnlí wǎngluò yóuxì chénmí.', 'Vì sức khỏe thể chất và tâm lý lành mạnh, thanh thiếu niên trong sinh hoạt hằng ngày cần tự giác tránh xa việc đắm chìm vào trò chơi điện tử trực tuyến.', 'basic', 1),
        (v_id, '领导干部必须恪守廉洁自律各项准则，自觉远离形形色色的利益圈子与权力寻租诱惑。', 'Lǐngdǎo gànbù bìxū kèshǒu liánjié-zìlǜ gè xiàng zhǔnzé, zìjué yuǎnlí xíngxíng-sèsè de lìyì quānzi yǔ quánlì xúnzū yòuhuò.', 'Cán bộ lãnh đạo bắt buộc phải khắc cốt ghi tâm các chuẩn tắc liêm khiết tự kỷ luật, tự giác tránh xa đủ mọi vòng tròn lợi ích và cám dỗ trục lợi quyền lực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [院长] (yuànzhǎng) - viện trưởng, hiệu trưởng trường trực thuộc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '院长' AND pinyin = 'yuànzhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '院长'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yuànzhǎng',
      meaning_vi = 'viện trưởng, hiệu trưởng trường trực thuộc',
      example_hanzi = '在今天的大学毕业典礼上，医学院院长亲切地为每一位优秀毕业生拨穗颁发学位证书。',
      example_pinyin = 'Zài jīntiān de dàxué bìyè diǎnlǐ shang, Yīxuéyuàn yuànzhǎng qīnqiè de wèi měi yí wèi yōuxiù bìyèshēng bōsuì bānfā xuéwèi zhèngshū.',
      example_vi = 'Trong lễ tốt nghiệp đại học hôm nay, Viện trưởng Viện Y học đã thân mật gạt tua nón và trao bằng tốt nghiệp cho từng sinh viên tốt nghiệp xuất sắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在今天的大学毕业典礼上，医学院院长亲切地为每一位优秀毕业生拨穗颁发学位证书。', 'Zài jīntiān de dàxué bìyè diǎnlǐ shang, Yīxuéyuàn yuànzhǎng qīnqiè de wèi měi yí wèi yōuxiù bìyèshēng bōsuì bānfā xuéwèi zhèngshū.', 'Trong lễ tốt nghiệp đại học hôm nay, Viện trưởng Viện Y học đã thân mật gạt tua nón và trao bằng tốt nghiệp cho từng sinh viên tốt nghiệp xuất sắc.', 'basic', 1),
        (v_id, '中国工程院院长在国际高端工程科技论坛上指出，必须加快构建国家战略科技力量自主创新生态体系。', 'Zhōngguó Gōngchéngyuàn yuànzhǎng zài guójì gāoduān gōngchéng kējì lùntán shang zhǐchū, bìxū jiākuài gòujiàn guójiā zhànlüè kējì lìliàng zìzhǔ chuàngxīn shēngtài tǐxì.', 'Viện trưởng Viện Kỹ thuật Công trình Trung Quốc tại diễn đàn khoa học công nghệ công trình cao cấp quốc tế đã chỉ ra rằng, bắt buộc phải đẩy nhanh việc kiến tạo hệ sinh thái đổi mới tự chủ lực lượng khoa học công nghệ chiến lược quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [院子] (yuànzi) - cái sân, khuôn viên sân vườn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '院子' AND pinyin = 'yuànzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '院子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yuànzi',
      meaning_vi = 'cái sân, khuôn viên sân vườn',
      example_hanzi = '奶奶在老家宽敞安静的院子里种满了各种娇艳的花草和绿油油的蔬菜。',
      example_pinyin = 'Nǎinai zài lǎojiā kuānchǎng ānjìng de yuànzi lǐ zhòng mǎn le gè zhǒng jiāoyàn de huācǎo hé lǜyóuyóu de shūcài.',
      example_vi = 'Bà nội trồng đầy các loài hoa cỏ kiều diễm và rau xanh mơn mởn trong khuôn viên sân vườn rộng rãi yên tĩnh ở quê nhà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '奶奶在老家宽敞安静的院子里种满了各种娇艳的花草和绿油油的蔬菜。', 'Nǎinai zài lǎojiā kuānchǎng ānjìng de yuànzi lǐ zhòng mǎn le gè zhǒng jiāoyàn de huācǎo hé lǜyóuyóu de shūcài.', 'Bà nội trồng đầy các loài hoa cỏ kiều diễm và rau xanh mơn mởn trong khuôn viên sân vườn rộng rãi yên tĩnh ở quê nhà.', 'basic', 1),
        (v_id, '传统北京四合院的四方院子不仅体现了中国古人“天人合一”的居住哲学，更承载着数百年悠久的市井文化记忆。', 'Chuántǒng Běijīng sìhéyuàn de sìfāng yuànzi bùjǐn tǐxiàn le Zhōngguó gǔrén “tiān-rén-hé-yī” de jūzhù zhéxué, gèng chéngzàizhe shù bǎi nián yōujiǔ de shìjǐng wénhuà jìyì.', 'Cái sân vuông vức của tứ hợp viện Bắc Kinh truyền thống không chỉ thể hiện triết lý cư trú "thiên nhân hợp nhất" của người xưa Trung Hoa, mà còn chuyên chở ký ức văn hóa phố thị lâu đời mấy trăm năm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [约] (yuē) - hẹn; khoảng chừng, ước chừng [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '约' AND pinyin = 'yuē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '约'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Phó từ',
      pinyin = 'yuē',
      meaning_vi = 'hẹn; khoảng chừng, ước chừng',
      example_hanzi = '既然周末大家都难得休息，不如我们约几个要好的朋友一起去郊外露营烧烤。',
      example_pinyin = 'Jìrán zhōumò dàjiā dōu nándé xiūxi, bùrú wǒmen yuē jǐ gè yàohǎo de péngyou yìqǐ qù jiāowài lùyíng shāokǎo.',
      example_vi = 'Đã là cuối tuần mọi người đều hiếm khi được nghỉ ngơi, chi bằng chúng ta hẹn mấy người bạn thân cùng nhau đi cắm trại nướng thịt ngoài ngoại ô.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '既然周末大家都难得休息，不如我们约几个要好的朋友一起去郊外露营烧烤。', 'Jìrán zhōumò dàjiā dōu nándé xiūxi, bùrú wǒmen yuē jǐ gè yàohǎo de péngyou yìqǐ qù jiāowài lùyíng shāokǎo.', 'Đã là cuối tuần mọi người đều hiếm khi được nghỉ ngơi, chi bằng chúng ta hẹn mấy người bạn thân cùng nhau đi cắm trại nướng thịt ngoài ngoại ô.', 'basic', 1),
        (v_id, '这座具有千年悠久历史的古桥全长约三百余米，历经多次特大洪水冲击依然保存完好。', 'Zhè zuò jùyǒu qiān nián yōujiǔ lìshǐ de gǔqiáo quán cháng yuē sān bǎi yú mǐ, lìjīng duō cì tèdà hóngshuǐ chōngjī yīrán bǎocún wánhǎo.', 'Cây cầu cổ mang lịch sử lâu đời ngàn năm này có tổng chiều dài ước khoảng hơn ba trăm mét, trải qua nhiều đợt lũ lụt đặc biệt lớn va đập vẫn bảo tồn nguyên vẹn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [约会] (yuēhuì) - hẹn hò, cuộc hẹn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '约会' AND pinyin = 'yuēhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '约会'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'yuēhuì',
      meaning_vi = 'hẹn hò, cuộc hẹn',
      example_hanzi = '他特意提前换上了崭新的西装并订好了浪漫的烛光晚餐，准备迎接今晚的重要约会。',
      example_pinyin = 'Tā tèyì tíqián huàn shang le zhǎnxīn de xīzhuāng bìng dìng hǎo le làngmàn de zhúguāng wǎncān, zhǔnbèi yíngjiē jīnwǎn de zhòngyào yuēhuì.',
      example_vi = 'Anh ấy đặc biệt thay bộ vest mới tinh từ sớm và đặt sẵn bữa tối dưới ánh nến lãng mạn, chuẩn bị đón nhận cuộc hẹn hò quan trọng tối nay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他特意提前换上了崭新的西装并订好了浪漫的烛光晚餐，准备迎接今晚的重要约会。', 'Tā tèyì tíqián huàn shang le zhǎnxīn de xīzhuāng bìng dìng hǎo le làngmàn de zhúguāng wǎncān, zhǔnbèi yíngjiē jīnwǎn de zhòngyào yuēhuì.', 'Anh ấy đặc biệt thay bộ vest mới tinh từ sớm và đặt sẵn bữa tối dưới ánh nến lãng mạn, chuẩn bị đón nhận cuộc hẹn hò quan trọng tối nay.', 'basic', 1),
        (v_id, '国际湿地保护组织专家与全球候鸟迁徙监测网络约定下月在沿海滩涂开展联合科考约会。', 'Guójì shīdì bǎohù zǔzhī zhuānjiā yǔ quánqiú hòuniǎo qiānxǐ jiāncè wǎngluò yuēdìng xià yuè zài yánhǎi tāntú kāizhǎn liánhé kěkǎo yuēhuì.', 'Các chuyên gia của tổ chức bảo tồn vùng đất ngập nước quốc tế và mạng lưới giám sát chim di cư toàn cầu đã hẹn tháng tới cùng hội ngộ triển khai đợt khảo sát khoa học liên hợp tại các bãi triều ven biển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [月饼] (yuèbing) - bánh trung thu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '月饼' AND pinyin = 'yuèbing'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '月饼'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yuèbing',
      meaning_vi = 'bánh trung thu',
      example_hanzi = '每逢中秋佳节，全家人围坐在一起一边赏月一边品尝香甜可口的传统蛋黄月饼。',
      example_pinyin = 'Měi féng Zhōngqiū jiājié, quán jiā rén wéizuò zài yìqǐ yìbiān shǎng yuè yìbiān pǐncháng xiāngtián-kěkǒu de chuántǒng dànhuáng yuèbing.',
      example_vi = 'Mỗi dịp tết Trung thu, cả nhà quây quần ngồi bên nhau vừa ngắm trăng vừa thưởng thức bánh trung thu nhân trứng muối truyền thống thơm ngọt ngon miệng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每逢中秋佳节，全家人围坐在一起一边赏月一边品尝香甜可口的传统蛋黄月饼。', 'Měi féng Zhōngqiū jiājié, quán jiā rén wéizuò zài yìqǐ yìbiān shǎng yuè yìbiān pǐncháng xiāngtián-kěkǒu de chuántǒng dànhuáng yuèbing.', 'Mỗi dịp tết Trung thu, cả nhà quây quần ngồi bên nhau vừa ngắm trăng vừa thưởng thức bánh trung thu nhân trứng muối truyền thống thơm ngọt ngon miệng.', 'basic', 1),
        (v_id, '传统中华老字号烘焙企业积极推动月饼生产工艺绿色健康改良，大幅降低糖分与油脂配比以适应现代健康消费需求。', 'Chuántǒng Zhōnghuá lǎozìhào hōngbèi qǐyè jījí tuīdòng yuèbing shēngchǎn gōngyì lǜsè jiànkāng gǎiliáng, dàfú jiàngdī tángfèn yǔ yóuzhī pèibǐ yǐ shìyìng xiàndài jiànkāng xiāofèi xūqiú.', 'Các doanh nghiệp làm bánh lâu đời truyền thống của Trung Hoa tích cực thúc đẩy cải tiến công nghệ sản xuất bánh trung thu theo hướng xanh lành mạnh, hạ thấp đáng kể tỷ lệ đường và chất béo để thích ứng với nhu cầu tiêu dùng vì sức khỏe hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [阅读] (yuèdú) - đọc, đọc hiểu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '阅读' AND pinyin = 'yuèdú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '阅读'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yuèdú',
      meaning_vi = 'đọc, đọc hiểu',
      example_hanzi = '每天睡觉前坚持阅读半小时优秀文学书籍，能够让人放松身心并拓宽知识眼界。',
      example_pinyin = 'Měitiān shuìjiào qián jiānchí yuèdú bàn xiǎoshí yōuxiù wénxué shūjí, nénggòu ràng rén fàngsōng shēnxīn bìng tuòkuān zhīshi yǎnjiè.',
      example_vi = 'Mỗi ngày trước khi đi ngủ kiên trì đọc sách văn học ưu tú nửa tiếng có thể giúp con người thư thái thân tâm và mở rộng tầm nhìn tri thức.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天睡觉前坚持阅读半小时优秀文学书籍，能够让人放松身心并拓宽知识眼界。', 'Měitiān shuìjiào qián jiānchí yuèdú bàn xiǎoshí yōuxiù wénxué shūjí, nénggòu ràng rén fàngsōng shēnxīn bìng tuòkuān zhīshi yǎnjiè.', 'Mỗi ngày trước khi đi ngủ kiên trì đọc sách văn học ưu tú nửa tiếng có thể giúp con người thư thái thân tâm và mở rộng tầm nhìn tri thức.', 'basic', 1),
        (v_id, '国家大力倡导全民阅读并深入推进“书香中国”建设，旨在全面厚植全民族思想文化根基与精神力量。', 'Guójiā dàlì chàngdǎo quánmín yuèdú bìng shēnrù tuījìn “Shūxiāng Zhōngguó” jiànshè, zhǐ zài quánmiàn hòuzhí quán mínzú sīxiǎng wénhuà gēnjī yǔ jīngshén lìliàng.', 'Nhà nước hết sức khởi xướng việc đọc sách cho toàn dân và đi sâu thúc đẩy xây dựng "Nước Trung Hoa thơm ngát hương sách", nhằm bồi dưỡng dày thêm căn cơ văn hóa tư tưởng và sức mạnh tinh thần của toàn dân tộc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [月份] (yuèfèn) - tháng (trong năm) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '月份' AND pinyin = 'yuèfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '月份'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yuèfèn',
      meaning_vi = 'tháng (trong năm)',
      example_hanzi = '七月份和八月份是国内许多中小学放暑假的高峰期，各大热门旅游景区游人如织。',
      example_pinyin = 'Qī yuèfèn hé bā yuèfèn shì guónèi xǔduō zhōng-xiǎoxué fàng shǔjià de gāofēngqī, gè dà rèmén lǚyóu jǐngqū yóurén-rúzhī.',
      example_vi = 'Tháng bảy và tháng tám là thời kỳ cao điểm nghỉ hè của nhiều trường tiểu học và trung học trong nước, các khu danh lam thắng cảnh du lịch nổi tiếng người đi lại đông như mắc cửi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '七月份和八月份是国内许多中小学放暑假的高峰期，各大热门旅游景区游人如织。', 'Qī yuèfèn hé bā yuèfèn shì guónèi xǔduō zhōng-xiǎoxué fàng shǔjià de gāofēngqī, gè dà rèmén lǚyóu jǐngqū yóurén-rúzhī.', 'Tháng bảy và tháng tám là thời kỳ cao điểm nghỉ hè của nhiều trường tiểu học và trung học trong nước, các khu danh lam thắng cảnh du lịch nổi tiếng người đi lại đông như mắc cửi.', 'basic', 1),
        (v_id, '国家统计局最新发布的三月份经济运行数据显示，全国规模以上工业增加值与高技术制造业投资均呈现出超预期的良好复苏态势。', 'Guójiā Tǒngjì Jú zuìxīn fābù de sān yuèfèn jīngjì yùnxíng shùjù xiǎnshì, quánguó guīmó yǐshàng gōngyè zēngjiāzhí yǔ gāo jìshù zhìzàoyè tóuzī jūn chéngxiàn chū chāo yùqī de liánghǎo fùsū tàishì.', 'Dữ liệu vận hành kinh tế tháng ba mới nhất do Cục Thống kê Quốc gia công bố cho thấy, giá trị gia tăng công nghiệp trên quy mô toàn quốc và đầu tư vào ngành chế tạo công nghệ cao đều thể hiện xu thế phục hồi tốt đẹp vượt ngoài dự kiến.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [云] (yún) - mây [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '云' AND pinyin = 'yún'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '云'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yún',
      meaning_vi = 'mây',
      example_hanzi = '蔚蓝的天空中飘浮着几朵洁白的白云，在阳光的照耀下宛如一朵朵柔软的棉花糖。',
      example_pinyin = 'Wèilán de tiānkōng zhōng piāofúzhe jǐ duǒ jiébái de báiyún, zài yángguāng de zhàoyào xià wǎnrú yì duǒ duǒ róuruǎn de miánhuatáng.',
      example_vi = 'Trên bầu trời xanh biếc lơ lửng vài đám mây trắng muốt, dưới ánh nắng mặt trời chiếu rọi tựa như những bông kẹo bông mềm mại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '蔚蓝的天空中飘浮着几朵洁白的白云，在阳光的照耀下宛如一朵朵柔软的棉花糖。', 'Wèilán de tiānkōng zhōng piāofúzhe jǐ duǒ jiébái de báiyún, zài yángguāng de zhàoyào xià wǎnrú yì duǒ duǒ róuruǎn de miánhuatáng.', 'Trên bầu trời xanh biếc lơ lửng vài đám mây trắng muốt, dưới ánh nắng mặt trời chiếu rọi tựa như những bông kẹo bông mềm mại.', 'basic', 1),
        (v_id, '随着云计算、大数据与人工智能深度融合，“上云用数赋智”已成为推动传统制造业数字化转型的核心战略引擎。', 'Suízhe yúnjìsuàn, dà shùjù yǔ réngōng zhìnéng shēndù rónghé, “shàng yún yòng shù fù zhì” yǐ chéngwéi tuīdòng chuántǒng zhìzàoyè shùzìhuà zhuǎnxíng de héxīn zhànlüè yǐnqíng.', 'Cùng với sự dung hợp sâu rộng của điện toán đám mây, dữ liệu lớn và trí tuệ nhân tạo, "lên mây - dùng số - truyền trí" đã trở thành động cơ chiến lược cốt lõi thúc đẩy sự chuyển đổi số của ngành sản xuất chế tạo truyền thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [允许] (yǔnxǔ) - cho phép, chấp thuận [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '允许' AND pinyin = 'yǔnxǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '允许'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yǔnxǔ',
      meaning_vi = 'cho phép, chấp thuận',
      example_hanzi = '图书馆阅览室内要求保持绝对安静，未经工作人员许可严禁大声喧哗和允许携带外卖食品。',
      example_pinyin = 'Túshūguǎn yuèlǎnshì nèi yāoqiú bǎochí juéduì ānjìng, wèijīng gōngzuò rényuán xǔkě yánjìn dàshēng xuānhuá hé yǔnxǔ xiédài wàimài shípǐn.',
      example_vi = 'Bên trong phòng đọc thư viện yêu cầu giữ yên tĩnh tuyệt đối, khi chưa có sự cho phép của nhân viên nghiêm cấm làm ồn lớn tiếng và không cho phép mang thức ăn nhanh từ ngoài vào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '图书馆阅览室内要求保持绝对安静，未经工作人员许可严禁大声喧哗和允许携带外卖食品。', 'Túshūguǎn yuèlǎnshì nèi yāoqiú bǎochí juéduì ānjìng, wèijīng gōngzuò rényuán xǔkě yánjìn dàshēng xuānhuá hé yǔnxǔ xiédài wàimài shípǐn.', 'Bên trong phòng đọc thư viện yêu cầu giữ yên tĩnh tuyệt đối, khi chưa có sự cho phép của nhân viên nghiêm cấm làm ồn lớn tiếng và không cho phép mang thức ăn nhanh từ ngoài vào.', 'basic', 1),
        (v_id, '我国全面实施外商投资准入负面清单管理制度，凡清单之外的领域均依法允许外资企业平等公平进入参与竞争。', 'Wǒ guó quánmiàn shíshī wàishāng tóuzī zhǔnrù fùmiàn qīngdān guǎnlǐ zhìdù, fán qīngdān zhī wài de lǐngyù jūn yīfǎ yǔnxǔ wàizī qǐyè píngděng gōngpíng jìnrù cānyù jìngzhēng.', 'Nước ta thực thi toàn diện chế độ quản lý danh mục tiêu cực tiếp cận đầu tư nước ngoài, mọi lĩnh vực ngoài danh mục đều được pháp luật cho phép doanh nghiệp có vốn đầu tư nước ngoài bình đẳng, công bằng gia nhập tham gia cạnh tranh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [杂志] (zázhì) - tạp chí [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '杂志' AND pinyin = 'zázhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '杂志'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zázhì',
      meaning_vi = 'tạp chí',
      example_hanzi = '爸爸平时有订阅读报的良好习惯，客厅的茶几上整整齐齐地摆放着几本当季的地理杂志。',
      example_pinyin = 'Bàba píngshí yǒu dìngyuè dúbào de liánghǎo xíguàn, kètīng de chájī shang zhěngzhěng-qíqí de bǎifàngzhe jǐ běn dāngjì de dìlǐ zázhì.',
      example_vi = 'Bố ngày thường có thói quen tốt đặt mua đọc báo, trên bàn trà phòng khách xếp đặt ngay ngắn chỉnh tề vài cuốn tạp chí địa lý số mùa này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爸爸平时有订阅读报的良好习惯，客厅的茶几上整整齐齐地摆放着几本当季的地理杂志。', 'Bàba píngshí yǒu dìngyuè dúbào de liánghǎo xíguàn, kètīng de chájī shang zhěngzhěng-qíqí de bǎifàngzhe jǐ běn dāngjì de dìlǐ zázhì.', 'Bố ngày thường có thói quen tốt đặt mua đọc báo, trên bàn trà phòng khách xếp đặt ngay ngắn chỉnh tề vài cuốn tạp chí địa lý số mùa này.', 'basic', 1),
        (v_id, '中国科研团队在国际权威学术期刊《科学》杂志上发表重大科研成果，首次揭示了深海极端环境下生物进化的特殊分子机制。', 'Zhōngguó kēyán tuánduì zài guójì quánwēi xuéshù qīkān “Kēxué” zázhì shang fābiǎo zhòngdà kēyán chéngguǒ, shǒucì jiēshì le shēnhǎi jíduān huánjìng xià shēngwù jìnhuà de tèshū fēnzǐ jīzhì.', 'Đội ngũ nghiên cứu khoa học Trung Quốc đã công bố thành quả nghiên cứu khoa học trọng đại trên tạp chí học thuật uy tín quốc tế "Science", lần đầu tiên hé lộ cơ chế phân tử đặc thù của quá trình tiến hóa sinh vật dưới môi trường biển sâu cực đoan.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [再次] (zàicì) - một lần nữa, lại [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '再次' AND pinyin = 'zàicì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '再次'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'zàicì',
      meaning_vi = 'một lần nữa, lại',
      example_hanzi = '经过全队同学几周来的刻苦训练，我们学校的合唱团再次荣获了全市中学生艺术比赛一等奖。',
      example_pinyin = 'Jīngguò quánduì tóngxué jǐ zhōu lái de kèkǔ xùnliàn, wǒmen xuéxiào de héchàngtuán zàicì rónghuò le quán shì zhōngxuéshēng yìshù bǐsài yīděngjiǎng.',
      example_vi = 'Trải qua sự khổ luyện mấy tuần qua của toàn đội, dàn hợp xướng trường chúng tôi một lần nữa vinh dự đoạt giải nhất cuộc thi nghệ thuật học sinh trung học toàn thành phố.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全队同学几周来的刻苦训练，我们学校的合唱团再次荣获了全市中学生艺术比赛一等奖。', 'Jīngguò quánduì tóngxué jǐ zhōu lái de kèkǔ xùnliàn, wǒmen xuéxiào de héchàngtuán zàicì rónghuò le quán shì zhōngxuéshēng yìshù bǐsài yīděngjiǎng.', 'Trải qua sự khổ luyện mấy tuần qua của toàn đội, dàn hợp xướng trường chúng tôi một lần nữa vinh dự đoạt giải nhất cuộc thi nghệ thuật học sinh trung học toàn thành phố.', 'basic', 1),
        (v_id, '联合国大会通过决议，再次敦促国际社会各方秉持多边主义原则，共同携手防范全球人道主义危机进一步恶化。', 'Liánhéguó Dàhuì tōngguò juéyì, zàicì dūncù guójì shèhuì gè fāng bǐngchí duōbiānzhǔyì yuánzé, gòngtóng xiéshǒu fángfàn quánqiú réndàozhǔyì wēijī jǐnyíbù èhuà.', 'Đại hội đồng Liên Hợp Quốc thông qua nghị quyết, một lần nữa thúc giục các bên trong cộng đồng quốc tế giữ vững nguyên tắc chủ nghĩa đa phương, cùng chung tay phòng ngừa cuộc khủng hoảng nhân đạo toàn cầu tiếp tục xấu đi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [再说] (zàishuō) - bàn sau; vả lại, hơn nữa [Động từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '再说' AND pinyin = 'zàishuō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '再说'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Liên từ',
      pinyin = 'zàishuō',
      meaning_vi = 'bàn sau; vả lại, hơn nữa',
      example_hanzi = '今天外面的雨下得实在太大了，天色也晚了，这件事情我们明天见面再说吧。',
      example_pinyin = 'Jīntiān wàimiàn de yǔ xià de shízài tài dà le, tiānsè yě wǎn le, zhè jiàn shìqing wǒmen míngtiān jiànmiàn zàishuō ba.',
      example_vi = 'Hôm nay ngoài trời mưa rơi thực sự quá to rồi, trời cũng tối rồi, việc này ngày mai chúng ta gặp mặt rồi hẵng bàn sau nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天外面的雨下得实在太大了，天色也晚了，这件事情我们明天见面再说吧。', 'Jīntiān wàimiàn de yǔ xià de shízài tài dà le, tiānsè yě wǎn le, zhè jiàn shìqing wǒmen míngtiān jiànmiàn zàishuō ba.', 'Hôm nay ngoài trời mưa rơi thực sự quá to rồi, trời cũng tối rồi, việc này ngày mai chúng ta gặp mặt rồi hẵng bàn sau nhé.', 'basic', 1),
        (v_id, '当前该项目的核心技术验证尚未彻底成熟，再说外部市场配套产业链尚不健全，盲目大规模量产投产势必增加企业财务风险。', 'Dāngqián gāi xiàngmù de héxīn jìshù yànzhèng shàngwèi chèdǐ chéngshú, zàishuō wàibù shìchǎng pèitào chǎnyèliàn shàng bù jiànquán, mángmù dà guīmó liàngchǎn tóuchǎn shìbì zēngjiā qǐyè cáiwù fēngxiǎn.', 'Hiện tại việc kiểm nghiệm công nghệ cốt lõi của dự án này vẫn chưa hoàn toàn chín muồi, vả lại chuỗi công nghiệp phụ trợ thị trường bên ngoài cũng chưa hoàn thiện, việc mù quáng đưa vào sản xuất hàng loạt quy mô lớn chắc chắn sẽ làm tăng thêm rủi ro tài chính cho doanh nghiệp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [暂时] (zànshí) - tạm thời, trước mắt [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '暂时' AND pinyin = 'zànshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '暂时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Tính từ',
      pinyin = 'zànshí',
      meaning_vi = 'tạm thời, trước mắt',
      example_hanzi = '暴风雨导致部分路段出现积水，交警部门已暂时封闭了通往山区的两条快速干道。',
      example_pinyin = 'Bàofēngyǔ dǎozhì bùfen lùduàn chūxiàn jīshuǐ, jiāojǐng bùmén yǐ zànshí fēngbì le tōngwǎng shānqū de liǎng tiáo kuàisù gàndào.',
      example_vi = 'Mưa bão dẫn đến một số đoạn đường bị ngập úng, lực lượng cảnh sát giao thông đã tạm thời phong tỏa hai tuyến đường huyết mạch dẫn vào vùng núi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '暴风雨导致部分路段出现积水，交警部门已暂时封闭了通往山区的两条快速干道。', 'Bàofēngyǔ dǎozhì bùfen lùduàn chūxiàn jīshuǐ, jiāojǐng bùmén yǐ zànshí fēngbì le tōngwǎng shānqū de liǎng tiáo kuàisù gàndào.', 'Mưa bão dẫn đến một số đoạn đường bị ngập úng, lực lượng cảnh sát giao thông đã tạm thời phong tỏa hai tuyến đường huyết mạch dẫn vào vùng núi.', 'basic', 1),
        (v_id, '面对外部地缘政治风险加剧引起的短期市场震荡，管理层采取了暂时平准基金调控举措以维护资本市场平稳运行。', 'Miànduì wàibù dìyuán zhèngzhì fēngxiǎn jiājù yǐnqǐ de duǎnqī shìchǎng zhèndàng, guǎnlǐcéng cǎiqǔ le zànshí píngzhǔn jījīn tiáokòng jǔcuò yǐ wéihù zīběn shìchǎng píngwěn yùnxíng.', 'Đối mặt với sự chấn động thị trường ngắn hạn do rủi ro địa chính trị bên ngoài gia tăng, ban điều hành đã áp dụng biện pháp điều tiết quỹ bình ổn tạm thời để duy trì sự vận hành ổn định của thị trường vốn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [暂停] (zàntíng) - tạm dừng, ngưng tạm thời [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '暂停' AND pinyin = 'zàntíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '暂停'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zàntíng',
      meaning_vi = 'tạm dừng, ngưng tạm thời',
      example_hanzi = '篮球比赛进入到了最关键的第四节，教练在球队落后两分时果断请求了暂停来重新布置防守战术。',
      example_pinyin = 'Lánqiú bǐsài jìnrù dào le zuì guānjiàn de dì-sì jié, jiàoliàn zài qiúduì luòhòu liǎng fēn shí guǒduàn qǐngqiú le zàntíng lái chóngxīn bùzhì fángshǒu zhànshù.',
      example_vi = 'Trận thi đấu bóng rổ bước vào hiệp thứ tư then chốt nhất, huấn luyện viên khi đội nhà bị dẫn trước hai điểm đã dứt khoát xin tạm dừng hội ý để bố trí lại chiến thuật phòng thủ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '篮球比赛进入到了最关键的第四节，教练在球队落后两分时果断请求了暂停来重新布置防守战术。', 'Lánqiú bǐsài jìnrù dào le zuì guānjiàn de dì-sì jié, jiàoliàn zài qiúduì luòhòu liǎng fēn shí guǒduàn qǐngqiú le zàntíng lái chóngxīn bùzhì fángshǒu zhànshù.', 'Trận thi đấu bóng rổ bước vào hiệp thứ tư then chốt nhất, huấn luyện viên khi đội nhà bị dẫn trước hai điểm đã dứt khoát xin tạm dừng hội ý để bố trí lại chiến thuật phòng thủ.', 'basic', 1),
        (v_id, '证券监管机构依法对涉嫌严重信息披露违规的上市公司股票实施暂停上市交易程序，以严肃维护广大中小投资者的合法权益。', 'Zhèngquàn jiānguǎn jīgòu yīfǎ duì shèxián yánzhòng xìnxī pīlù wéiguī de shàngshì gōngsī gǔpiào shíshī zàntíng shàngshì jiāoyì chéngxù, yǐ yánsù wéihù guǎngdà zhōng-xiǎo tóuzīzhě de héfǎ quányì.', 'Cơ quan quản lý giám sát chứng khoán theo đúng pháp luật áp dụng quy trình tạm dừng giao dịch niêm yết đối với cổ phiếu của công ty niêm yết có dấu hiệu vi phạm nghiêm trọng quy định công bố thông tin, nhằm bảo vệ nghiêm túc quyền lợi hợp pháp của đông đảo các nhà đầu tư vừa và nhỏ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [早餐] (zǎocān) - bữa sáng, điểm tâm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '早餐' AND pinyin = 'zǎocān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '早餐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zǎocān',
      meaning_vi = 'bữa sáng, điểm tâm',
      example_hanzi = '营养学医生建议大家每天早晨都要按时吃早餐，并注意摄入富含优质蛋白质与维生素的均衡食物。',
      example_pinyin = 'Yíngyǎngxué yīshēng jiànyì dàjiā měitiān zǎochén dōu yào ànshí chī zǎocān, bìng zhùyì shèrù fùhán yōuzhì dànbáizhì yǔ wéishēngsù de jūnhéng shíwù.',
      example_vi = 'Bác sĩ chuyên khoa dinh dưỡng khuyên mọi người mỗi sáng đều phải ăn sáng đúng giờ và chú ý nạp các thực phẩm cân bằng giàu protein chất lượng cao cùng vitamin.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '营养学医生建议大家每天早晨都要按时吃早餐，并注意摄入富含优质蛋白质与维生素的均衡食物。', 'Yíngyǎngxué yīshēng jiànyì dàjiā měitiān zǎochén dōu yào ànshí chī zǎocān, bìng zhùyì shèrù fùhán yōuzhì dànbáizhì yǔ wéishēngsù de jūnhéng shíwù.', 'Bác sĩ chuyên khoa dinh dưỡng khuyên mọi người mỗi sáng đều phải ăn sáng đúng giờ và chú ý nạp các thực phẩm cân bằng giàu protein chất lượng cao cùng vitamin.', 'basic', 1),
        (v_id, '市政部门持续推进便民惠民工程，在核心居民区与商务园区高标准打造连锁品牌“早餐示范工程”，全面守护市民舌尖上的早餐安全。', 'Shìzhèng bùmén chíxù tuījìn biànmín-huìmín gōngchéng, zài héxīn jūmínqū yǔ shāngwù yuánqū gāo biāozhǔn dǎzào liánsuǒ pǐnpái “zǎocān shìfàn gōngchéng”, quánmiàn shǒuhù shìmín shéjiān shang de zǎocān ānquán.', 'Ban ngành chính quyền thành phố liên tục thúc đẩy các dự án tiện dân vì dân, xây dựng "dự án điểm bữa sáng" theo chuỗi thương hiệu tiêu chuẩn cao tại các khu dân cư cốt lõi và khu công viên thương mại, bảo vệ toàn diện sự an toàn của bữa sáng trên đầu lưỡi của người dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [早晨] (zǎochen) - buổi sáng sớm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '早晨' AND pinyin = 'zǎochen'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '早晨'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zǎochen',
      meaning_vi = 'buổi sáng sớm',
      example_hanzi = '初春的早晨空气格外清新宜人，很多退休老人已经在公园的绿道上慢跑健身了。',
      example_pinyin = 'Chūchūn de zǎochen kōngqì géwài qīngxīn yírén, hěn duō tuìxiū lǎorén yǐjīng zài gōngyuán de lǜdào shang mànpǎo jiànshēn le.',
      example_vi = 'Không khí buổi sáng đầu xuân đặc biệt trong lành dễ chịu, rất nhiều người cao tuổi đã nghỉ hưu đã chạy bộ tập thể dục trên lối đi dạo xanh của công viên rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '初春的早晨空气格外清新宜人，很多退休老人已经在公园的绿道上慢跑健身了。', 'Chūchūn de zǎochen kōngqì géwài qīngxīn yírén, hěn duō tuìxiū lǎorén yǐjīng zài gōngyuán de lǜdào shang mànpǎo jiànshēn le.', 'Không khí buổi sáng đầu xuân đặc biệt trong lành dễ chịu, rất nhiều người cao tuổi đã nghỉ hưu đã chạy bộ tập thể dục trên lối đi dạo xanh của công viên rồi.', 'basic', 1),
        (v_id, '农业科技特派员迎着清晨的第一缕晨曦深入田间地头，实地指导农户科学开展农作物春耕播种与病虫害绿色防控。', 'Nóngyè kējì tèpàiyuán yíngzhe qīngchén de dì-yī lǚ chénxī shēnrù tiánjiān-dìtóu, shídì zhǐdǎo nónghù kēxué kāizhǎn nóngzuòwù chūngēng bōzhǒng yǔ bìngchónghài lǜsè fángkòng.', 'Phái viên đặc biệt khoa học công nghệ nông nghiệp đón ánh nắng ban mai đầu tiên của buổi sáng sớm đi sâu xuống tận ruộng đồng ngõ xóm, trực tiếp hướng dẫn nông dân gieo trồng vụ xuân cho cây trồng một cách khoa học và phòng trừ sâu bệnh xanh an toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [责任] (zérèn) - trách nhiệm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '责任' AND pinyin = 'zérèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '责任'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zérèn',
      meaning_vi = 'trách nhiệm',
      example_hanzi = '作为这个班级的一名班长，组织好每一次班会与服务好每一位同学是我的光荣责任。',
      example_pinyin = 'Zuòwéi zhè ge bānjí de yì míng bānzhǎng, zǔzhī hǎo měi yí cì bānhuì yǔ fúwù hǎo měi yí wèi tóngxué shì wǒ de guāngróng zérèn.',
      example_vi = 'Với tư cách là lớp trưởng của lớp học này, tổ chức tốt mỗi buổi sinh hoạt lớp và phục vụ tốt từng bạn học sinh là trách nhiệm quang vinh của tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '作为这个班级的一名班长，组织好每一次班会与服务好每一位同学是我的光荣责任。', 'Zuòwéi zhè ge bānjí de yì míng bānzhǎng, zǔzhī hǎo měi yí cì bānhuì yǔ fúwù hǎo měi yí wèi tóngxué shì wǒ de guāngróng zérèn.', 'Với tư cách là lớp trưởng của lớp học này, tổ chức tốt mỗi buổi sinh hoạt lớp và phục vụ tốt từng bạn học sinh là trách nhiệm quang vinh của tôi.', 'basic', 1),
        (v_id, '国有骨干企业必须坚决履行好保障国家能源安全、促进产业链供应链自主可控的重大政治责任与历史使命。', 'Guóyǒu gǔgàn qǐyè bìxū jiānjué lǚxíng hǎo bǎozhàng guójiā néngyuán ānquán, cùjìn chǎnyèliàn gōngyìngliàn zìzhǔ kěkòng de zhòngdà zhèngzhì zérèn yǔ lìshǐ shǐmìng.', 'Các doanh nghiệp rường cột nhà nước bắt buộc phải kiên quyết thực hiện tốt trách nhiệm chính trị to lớn và sứ mệnh lịch sử về bảo đảm an ninh năng lượng quốc gia, thúc đẩy tính tự chủ kiểm soát được của chuỗi công nghiệp và chuỗi cung ứng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [增加] (zēngjiā) - tăng thêm, gia tăng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '增加' AND pinyin = 'zēngjiā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '增加'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zēngjiā',
      meaning_vi = 'tăng thêm, gia tăng',
      example_hanzi = '随着冬季气温急剧下降，妈妈在我的床上增加了一床厚厚柔软的羊毛被子。',
      example_pinyin = 'Suízhe dōngjì qìwēn jíjù xiàjiàng, māma zài wǒ de chuáng shang zēngjiā le yì chuáng hòuhòu róuruǎn de yángmáo bèizi.',
      example_vi = 'Cùng với việc nhiệt độ mùa đông sụt giảm nhanh chóng, mẹ đã đắp thêm trên giường của tôi một chiếc chăn lông cừu mềm mại dày dặn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着冬季气温急剧下降，妈妈在我的床上增加了一床厚厚柔软的羊毛被子。', 'Suízhe dōngjì qìwēn jíjù xiàjiàng, māma zài wǒ de chuáng shang zēngjiā le yì chuáng hòuhòu róuruǎn de yángmáo bèizi.', 'Cùng với việc nhiệt độ mùa đông sụt giảm nhanh chóng, mẹ đã đắp thêm trên giường của tôi một chiếc chăn lông cừu mềm mại dày dặn.', 'basic', 1),
        (v_id, '地方各级政府持续增加民生领域财政支出预算占比，重点用于提升基层公共医疗卫生与普惠性学前教育保障水平。', 'Dìfāng gè jí zhèngfǔ chíxù zēngjiā mínshēng lǐngyù cáizhèng zhīchū yùsuàn zhànbǐ, zhòngdiǎn yòngyú tíshēng jīcéng gōnggòng yīliáo wèishēng yǔ pǔhuìxìng xuéqián jiàoyù bǎozhàng shuǐpíng.', 'Chính quyền các cấp ở địa phương liên tục tăng tỷ trọng dự toán chi ngân sách trong lĩnh vực dân sinh, trọng điểm dùng vào việc nâng cao mức độ bảo đảm y tế vệ sinh công cộng cơ sở và giáo dục mầm non phổ cập.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [增长] (zēngzhǎng) - tăng trưởng, phát triển thêm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '增长' AND pinyin = 'zēngzhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '增长'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zēngzhǎng',
      meaning_vi = 'tăng trưởng, phát triển thêm',
      example_hanzi = '坚持广泛阅读和勤于思考，不仅能让人的知识面成倍扩展，更能让个人的心智与眼界实现持续健康增长。',
      example_pinyin = 'Jiānchí guǎngfàn yuèdú hé qín yú sīkǎo, bùjǐn néng ràng rén de zhīshimiàn chéngbèi kuòzhǎn, gèng néng ràng gèrén de xīnlì yǔ yǎnjiè shíxiàn chíxù jiànkāng zēngzhǎng.',
      example_vi = 'Kiên trì đọc sách rộng rãi và chăm chỉ tư duy không chỉ làm cho vốn hiểu biết của con người mở rộng gấp bội, mà còn giúp tâm trí và tầm mắt của mỗi cá nhân thực hiện sự tăng trưởng lành mạnh bền vững.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '坚持广泛阅读和勤于思考，不仅能让人的知识面成倍扩展，更能让个人的心智与眼界实现持续健康增长。', 'Jiānchí guǎngfàn yuèdú hé qín yú sīkǎo, bùjǐn néng ràng rén de zhīshimiàn chéngbèi kuòzhǎn, gèng néng ràng gèrén de xīnlì yǔ yǎnjiè shíxiàn chíxù jiànkāng zēngzhǎng.', 'Kiên trì đọc sách rộng rãi và chăm chỉ tư duy không chỉ làm cho vốn hiểu biết của con người mở rộng gấp bội, mà còn giúp tâm trí và tầm mắt của mỗi cá nhân thực hiện sự tăng trưởng lành mạnh bền vững.', 'basic', 1),
        (v_id, '依托数字经济与绿色新能源双轮驱动，该国家级高新区实现了地区生产总值与高新技术制造业产值双位数的强劲增长。', 'Yītuō shùzì jīngjì yǔ lǜsè xīn néngyuán shuānglún qūdòng, gāi guójiā-jí gāoxīnqū shíxiàn le dìqū shēngchǎn zǒngzhí yǔ gāoxīn jìshù zhìzàoyè chǎnzhí shuāng wèishù de qiángjìng zēngzhǎng.', 'Dựa vào động lực kép của nền kinh tế số và năng lượng mới xanh, khu công nghệ cao cấp quốc gia này đã đạt được mức tăng trưởng mạnh mẽ hai con số về cả tổng sản phẩm trên địa bàn (GRDP) và giá trị sản lượng ngành chế tạo công nghệ cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [招聘] (zhāopìn) - tuyển dụng, chiêu mộ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '招聘' AND pinyin = 'zhāopìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '招聘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhāopìn',
      meaning_vi = 'tuyển dụng, chiêu mộ',
      example_hanzi = '每年春季和秋季，很多知名企业都会走进大学校园举办大型专场校园招聘会。',
      example_pinyin = 'Měi nián chūnjì hé qiūjì, hěn duō zhīmíng qǐyè dōu huì zǒu jìn dàxué xiàoyuán jǔbàn dàxíng zhuānchǎng xiàoyuán zhāopìnhuì.',
      example_vi = 'Hằng năm vào mùa xuân và mùa thu, rất nhiều doanh nghiệp có tiếng đều bước vào các khuôn viên đại học tổ chức các ngày hội tuyển dụng sinh viên quy mô lớn chuyên đề.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年春季和秋季，很多知名企业都会走进大学校园举办大型专场校园招聘会。', 'Měi nián chūnjì hé qiūjì, hěn duō zhīmíng qǐyè dōu huì zǒu jìn dàxué xiàoyuán jǔbàn dàxíng zhuānchǎng xiàoyuán zhāopìnhuì.', 'Hằng năm vào mùa xuân và mùa thu, rất nhiều doanh nghiệp có tiếng đều bước vào các khuôn viên đại học tổ chức các ngày hội tuyển dụng sinh viên quy mô lớn chuyên đề.', 'basic', 1),
        (v_id, '国家重点实验室面向海内外公开招聘顶尖学科带头人与青年学术骨干，以优厚科研保障待遇广聚天下英才。', 'Guójiā zhòngdiǎn shíyànshì miànxiàng hǎi-nèiwài gōngkāi zhāopìn dǐngjiān xuékē dàitóurén yǔ qīngnián xuéshù gǔgàn, yǐ yōuhòu kēyán bǎozhàng dàiyù guǎng jù tiānxià yīngcái.', 'Phòng thí nghiệm trọng điểm quốc gia tuyển dụng công khai người đứng đầu bộ môn đỉnh cao và cán bộ học thuật nòng cốt trẻ tuổi trong và ngoài nước, dùng chế độ đãi ngộ bảo đảm nghiên cứu khoa học ưu hậu rộng mở tập hợp hiền tài khắp thiên hạ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [着] (zháo) - ngủ (say), trúng, bén, bị (nhiễm lạnh, cảm) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '着' AND pinyin = 'zháo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '着'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zháo',
      meaning_vi = 'ngủ (say), trúng, bén, bị (nhiễm lạnh, cảm)',
      example_hanzi = '昨晚由于白天户外徒步过于劳累，他刚一躺到床上闭上眼睛就立刻睡着了。',
      example_pinyin = 'Zuówǎn yóuyú báitiān hùwài túbù guòyú láolèi, tā gāng yì tǎng dào chuáng shang bì shang yǎnjing jiù lìkè shuìzháo le.',
      example_vi = 'Tối qua do ban ngày đi bộ leo núi ngoài trời quá mệt mỏi, anh ấy vừa mới nằm lên giường nhắm mắt lại là lập tức ngủ say rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昨晚由于白天户外徒步过于劳累，他刚一躺到床上闭上眼睛就立刻睡着了。', 'Zuówǎn yóuyú báitiān hùwài túbù guòyú láolèi, tā gāng yì tǎng dào chuáng shang bì shang yǎnjing jiù lìkè shuìzháo le.', 'Tối qua do ban ngày đi bộ leo núi ngoài trời quá mệt mỏi, anh ấy vừa mới nằm lên giường nhắm mắt lại là lập tức ngủ say rồi.', 'basic', 1),
        (v_id, '天气转凉时一定要及时添衣保暖以免着凉感冒，从而确保身体时刻处于最佳的健康竞技状态。', 'Tiānqì zhuǎn liáng shí yídìng yào jíshí tiān yī bǎonuǎn yǐmiǎn zháoliáng gǎnmào, cóng’ér quèbǎo shēntǐ shíkè chǔyú zuìjiā de jiànkāng jìngjì zhuàngtài.', 'Khi thời tiết chuyển lạnh nhất định phải kịp thời mặc thêm áo giữ ấm để tránh bị nhiễm lạnh cảm cúm, qua đó đảm bảo cơ thể luôn luôn ở trong trạng thái thi đấu sức khỏe tối ưu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [着火] (zháohuǒ) - bốc cháy, bén lửa, cháy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '着火' AND pinyin = 'zháohuǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '着火'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zháohuǒ',
      meaning_vi = 'bốc cháy, bén lửa, cháy',
      example_hanzi = '遇到厨房炒菜油锅不慎着火时，千万不要用水泼浇，而应立即盖上锅盖阻隔氧气灭火。',
      example_pinyin = 'Yùdào chúfáng chǎocài yóuguō búshèn zháohuǒ shí, qiānwàn bú yào yòng shuǐ pō jiāo, ér yīng lìjí gài shang guōgài zǔgé yǎngqì mièhuǒ.',
      example_vi = 'Khi gặp tình huống chảo dầu xào nấu trong bếp bất cẩn bốc cháy, tuyệt đối không được dùng nước tạt vào, mà nên lập tức đậy nắp vung lại ngăn cách oxy để dập lửa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到厨房炒菜油锅不慎着火时，千万不要用水泼浇，而应立即盖上锅盖阻隔氧气灭火。', 'Yùdào chúfáng chǎocài yóuguō búshèn zháohuǒ shí, qiānwàn bú yào yòng shuǐ pō jiāo, ér yīng lìjí gài shang guōgài zǔgé yǎngqì mièhuǒ.', 'Khi gặp tình huống chảo dầu xào nấu trong bếp bất cẩn bốc cháy, tuyệt đối không được dùng nước tạt vào, mà nên lập tức đậy nắp vung lại ngăn cách oxy để dập lửa.', 'basic', 1),
        (v_id, '消防应急管理部门全面开展老旧住宅小区电气线路隐患专项排查，坚决杜绝因线路老化引发严重电气着火事故。', 'Xiāofáng yīngjí guǎnlǐ bùmén quánmiàn kāizhǎn lǎojiù zhùzhái xiǎoqū diànqì xiànlù yǐnhuàn zhuānxiàng páichá, jiānjué dùjué yīn xiànlù lǎohuà yǐnfā yánzhòng diànqì zháohuǒ shìgù.', 'Ban ngành quản lý ứng phó khẩn cấp phòng cháy chữa cháy triển khai toàn diện đợt rà soát chuyên đề về hiểm họa đường dây điện tại các khu chung cư nhà ở cũ, kiên quyết chấm dứt các sự cố cháy nổ điện nghiêm trọng do đường dây bị lão hóa gây ra.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [者] (zhě) - người, kẻ, người mà... [Trợ từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '者' AND pinyin = 'zhě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '者'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Trợ từ / Danh từ',
      pinyin = 'zhě',
      meaning_vi = 'người, kẻ, người mà...',
      example_hanzi = '无论在学业还是在运动场上，只有勇于拼搏者才能最终收获胜利的喜悦。',
      example_pinyin = 'Wúlùn zài xuéyè hái shì zài yùndòngchǎng shang, zhǐyǒu yǒng yú pīnbózhě cái néng zuìzhōng shōuhuò shènglì de xǐyuè.',
      example_vi = 'Bất kể trong học tập hay trên sân thể thao, chỉ có những người dũng cảm nỗ lực phấn đấu mới có thể cuối cùng gặt hái được niềm vui chiến thắng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '无论在学业还是在运动场上，只有勇于拼搏者才能最终收获胜利的喜悦。', 'Wúlùn zài xuéyè hái shì zài yùndòngchǎng shang, zhǐyǒu yǒng yú pīnbózhě cái néng zuìzhōng shōuhuò shènglì de xǐyuè.', 'Bất kể trong học tập hay trên sân thể thao, chỉ có những người dũng cảm nỗ lực phấn đấu mới có thể cuối cùng gặt hái được niềm vui chiến thắng.', 'basic', 1),
        (v_id, '广大科技工作者要自觉践行科学家精神，勇攀世界科学高峰，争当高水平科技自立自强的排头兵。', 'Guǎngdà kējì gōngzuòzhě yào zìjué jiànxíng kēxuéjiā jīngshén, yǒng pān shìjiè kēxué gāofēng, zhēng dāng gāo shuǐpǐng kējì zìlì-zìqiáng de páitóubīng.', 'Đông đảo đội ngũ người làm công tác khoa học công nghệ phải tự giác thực hành tinh thần nhà khoa học, dũng cảm leo lên đỉnh cao khoa học thế giới, phấn đấu trở thành người lính tiên phong trong tự lực tự cường công nghệ trình độ cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [真正] (zhēnzhèng) - chân chính, đích thực, thực sự [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '真正' AND pinyin = 'zhēnzhèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '真正'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'zhēnzhèng',
      meaning_vi = 'chân chính, đích thực, thực sự',
      example_hanzi = '唯有在患难时刻依然对你施以援手的人，才是你一生中真正知心的挚友。',
      example_pinyin = 'Wéiyǒu zài huànnàn shíkè yīrán duì nǐ shī yǐ yuánshǒu de rén, cái shì nǐ yìshēng zhōng zhēnzhèng zhīxīn de zhìyǒu.',
      example_vi = 'Chỉ có người trong lúc hoạn nạn khó khăn vẫn dang rộng cánh tay giúp đỡ bạn, mới là người bạn tri kỷ thực sự trong suốt cuộc đời bạn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '唯有在患难时刻依然对你施以援手的人，才是你一生中真正知心的挚友。', 'Wéiyǒu zài huànnàn shíkè yīrán duì nǐ shī yǐ yuánshǒu de rén, cái shì nǐ yìshēng zhōng zhēnzhèng zhīxīn de zhìyǒu.', 'Chỉ có người trong lúc hoạn nạn khó khăn vẫn dang rộng cánh tay giúp đỡ bạn, mới là người bạn tri kỷ thực sự trong suốt cuộc đời bạn.', 'basic', 1),
        (v_id, '检验一项改革政策是否成功的唯一标准，是看其能否真正为广大人民群众带来实实在在的获得感与幸福感。', 'Jiǎnyàn yí xiàng gǎigé zhèngcè shìfǒu chénggōng de wéiyī biāozhǔn, shì kàn qí néng fǒu zhēnzhèng wèi guǎngdà rénmín qúnzhòng dàilái shíshí-zàizài de huòdégǎn yǔ xìngfúgǎn.', 'Tiêu chuẩn duy nhất kiểm nghiệm một chính sách cải cách có thành công hay không là xem chính sách đó có thể thực sự mang lại cảm giác thụ hưởng và hạnh phúc thiết thực cho đông đảo quần chúng nhân dân hay không.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [整] (zhěng) - trọn vẹn, toàn bộ; chỉnh lý, thu dọn [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '整' AND pinyin = 'zhěng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '整'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'zhěng',
      meaning_vi = 'trọn vẹn, toàn bộ; chỉnh lý, thu dọn',
      example_hanzi = '他在周末花了一整天的时间，把堆满杂物的储藏室清理得井井有条。',
      example_pinyin = 'Tā zài zhōumò huā le yì zhěng tiān de shíjiān, bǎ duī mǎn záwù de chǔcángshì qīnglǐ de jǐngjǐng-yǒutiáo.',
      example_vi = 'Anh ấy đã dành trọn một ngày cuối tuần dọn dẹp căn phòng chứa đồ chất đầy đồ đạc lộn xộn trở nên ngăn nắp gọn gàng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在周末花了一整天的时间，把堆满杂物的储藏室清理得井井有条。', 'Tā zài zhōumò huā le yì zhěng tiān de shíjiān, bǎ duī mǎn záwù de chǔcángshì qīnglǐ de jǐngjǐng-yǒutiáo.', 'Anh ấy đã dành trọn một ngày cuối tuần dọn dẹp căn phòng chứa đồ chất đầy đồ đạc lộn xộn trở nên ngăn nắp gọn gàng.', 'basic', 1),
        (v_id, '推动区域经济协同发展必须坚持全国一盘棋思想，强化各部门政策取向的统筹兼顾与有机整合同步发力。', 'Tuīdòng qūyù jīngjì xiétóng fāzhǎn bìxū jiānchí quánguó yìpánqí sīxiǎng, qiánghuà gè bùmén zhèngcè qǔxiàng de tǒngchóu-jiāngù yǔ yǒujī zhěnghé tóngbù fālì.', 'Thúc đẩy kinh tế vùng phối hợp phát triển bắt buộc phải kiên trì tư tưởng toàn quốc như một bàn cờ, tăng cường việc tính toán đồng bộ định hướng chính sách của các ban ngành và tạo sức bật đồng bộ trong sự chỉnh hợp hữu cơ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [整个] (zhěnggè) - toàn bộ, cả, trọn vẹn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '整个' AND pinyin = 'zhěnggè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '整个'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'zhěnggè',
      meaning_vi = 'toàn bộ, cả, trọn vẹn',
      example_hanzi = '听到中国女排在奥运会决赛中反败为胜夺冠的喜讯，整个居民楼顿时响起了热烈的欢呼声。',
      example_pinyin = 'Tīngdào Zhōngguó nǚpái zài Àoyùnhuì juésài zhōng fǎnbàiwéishèng duóguàn de xǐxùn, zhěnggè jūmínlóu dùnshí xiǎngqǐ le rèliè de huānhūshēng.',
      example_vi = 'Nghe tin mừng đội bóng chuyền nữ Trung Quốc lội ngược dòng giành chức vô địch trong trận chung kết Thế vận hội Olympic, cả tòa nhà chung cư lập tức vang lên những tiếng reo hò cuồng nhiệt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到中国女排在奥运会决赛中反败为胜夺冠的喜讯，整个居民楼顿时响起了热烈的欢呼声。', 'Tīngdào Zhōngguó nǚpái zài Àoyùnhuì juésài zhōng fǎnbàiwéishèng duóguàn de xǐxùn, zhěnggè jūmínlóu dùnshí xiǎngqǐ le rèliè de huānhūshēng.', 'Nghe tin mừng đội bóng chuyền nữ Trung Quốc lội ngược dòng giành chức vô địch trong trận chung kết Thế vận hội Olympic, cả tòa nhà chung cư lập tức vang lên những tiếng reo hò cuồng nhiệt.', 'basic', 1),
        (v_id, '新一代数字智能技术的革命性突破，正在全方位重构整个现代高端装备制造业的生产流程与全球价值链。', 'Xīn yídài shùzì zhìnéng jìshù de gémìngxìng tūpò, zhèngzài quán fāngwèi chónggòu zhěnggè xiàndài gāoduān zhuāngbèi zhìzàoyè de shēngchǎn liúchéng yǔ quánqiú jiàzhíliàn.', 'Đột phá mang tính cách mạng của công nghệ số thông minh thế hệ mới đang tái cấu trúc toàn diện toàn bộ quy trình sản xuất và chuỗi giá trị toàn cầu của ngành chế tạo thiết bị cao cấp hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [整理] (zhěnglǐ) - thu dọn, chỉnh lý, sắp xếp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '整理' AND pinyin = 'zhěnglǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '整理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhěnglǐ',
      meaning_vi = 'thu dọn, chỉnh lý, sắp xếp',
      example_hanzi = '临近学期末，同学们都在安静的书房里认真归纳整理各科课堂笔记以备期末考试。',
      example_pinyin = 'Línjìn xuéqīmò, tóngxuémen dōu zài ānjìng de shūfáng lǐ rènzhēn guīnà zhěnglǐ gè kē kètáng bǐjì yǐ bèi qīmò kǎoshì.',
      example_vi = 'Gần tới cuối học kỳ, các bạn học sinh đều ở trong phòng học yên tĩnh chăm chỉ quy nạp sắp xếp lại ghi chép bài giảng các môn học để chuẩn bị cho kỳ thi cuối kỳ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '临近学期末，同学们都在安静的书房里认真归纳整理各科课堂笔记以备期末考试。', 'Línjìn xuéqīmò, tóngxuémen dōu zài ānjìng de shūfáng lǐ rènzhēn guīnà zhěnglǐ gè kē kètáng bǐjì yǐ bèi qīmò kǎoshì.', 'Gần tới cuối học kỳ, các bạn học sinh đều ở trong phòng học yên tĩnh chăm chỉ quy nạp sắp xếp lại ghi chép bài giảng các môn học để chuẩn bị cho kỳ thi cuối kỳ.', 'basic', 1),
        (v_id, '国家文物保护部门组织顶尖历史学者历时数载，系统整理出版了浩瀚的珍贵出土简牍文献古籍。', 'Guójiā wénwù bǎohù bùmén zǔzhī dǐngjiān lìshǐ xuézhě lìshí shù zǎi, xìtǒng zhěnglǐ chūbǎn le hàohàn de zhēnguì chūtǔ jiǎndú wénxiàn gǔjí.', 'Ban ngành bảo tồn di tích văn vật quốc gia tổ chức các học giả lịch sử hàng đầu kéo dài trong nhiều năm, chỉnh lý xuất bản một cách có hệ thống kho tàng sách cổ tư liệu thẻ tre quý giá khai quật đồ sộ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [证] (zhèng) - chứng minh; giấy chứng nhận, thẻ [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '证' AND pinyin = 'zhèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '证'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'zhèng',
      meaning_vi = 'chứng minh; giấy chứng nhận, thẻ',
      example_hanzi = '前往市民服务中心办理各类公共业务时，务必携带好本人有效身份证原件及相关证明材料。',
      example_pinyin = 'Qiánwǎng shìmín fúwù zhōngxīn bànlǐ gè lèi gōnggòng yèwù shí, wùbì xiédài hǎo běnrén yǒuxiào shēnfènzhèng yuánjiàn jí xiāngguān zhèngmíng cáiliào.',
      example_vi = 'Khi tới trung tâm dịch vụ công dân làm các thủ tục công, nhất thiết phải mang theo bản gốc căn cước công dân còn hiệu lực và các giấy tờ chứng minh liên quan.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '前往市民服务中心办理各类公共业务时，务必携带好本人有效身份证原件及相关证明材料。', 'Qiánwǎng shìmín fúwù zhōngxīn bànlǐ gè lèi gōnggòng yèwù shí, wùbì xiédài hǎo běnrén yǒuxiào shēnfènzhèng yuánjiàn jí xiāngguān zhèngmíng cáiliào.', 'Khi tới trung tâm dịch vụ công dân làm các thủ tục công, nhất thiết phải mang theo bản gốc căn cước công dân còn hiệu lực và các giấy tờ chứng minh liên quan.', 'basic', 1),
        (v_id, '深化“放管服”改革的核心举措之一，就是大力推行“减证便民”行动，坚决消除各类奇葩证明与重复循环证明。', 'Shēnhuà “fàng-guǎn-fú” gǎigé de héxīn jǔcuò zhīyī, jiù shì dàlì tuīxíng “jiǎn zhèng biànmín” xíngdòng, jiānjué xiāochú gè lèi qípā zhèngmíng yǔ chóngfù xúnhuán zhèngmíng.', 'Một trong những giải pháp cốt lõi nhằm đi sâu cải cách hành chính tinh giản là hết sức đẩy mạnh phong trào "giảm bớt giấy tờ chứng nhận tiện lợi cho dân", kiên quyết xóa bỏ các loại giấy xác nhận quái gở và giấy tờ xác nhận vòng quanh trùng lặp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [正常] (zhèngcháng) - bình thường, thông thường [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '正常' AND pinyin = 'zhèngcháng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '正常'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'zhèngcháng',
      meaning_vi = 'bình thường, thông thường',
      example_hanzi = '经过医生几天的精心治疗与调理，生病病人的体温已经恢复到了完全正常状态。',
      example_pinyin = 'Jīngguò yīshēng jǐ tiān de jīngxīn zhìliáo yǔ tiáolǐ, shēngbìng bìngrén de tǐwēn yǐjīng huìfù dào le wánquán zhèngcháng zhuàngtài.',
      example_vi = 'Trải qua vài ngày điều trị và bồi bổ chu đáo của bác sĩ, thân nhiệt của người bệnh đã hồi phục về trạng thái hoàn toàn bình thường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过医生几天的精心治疗与调理，生病病人的体温已经恢复到了完全正常状态。', 'Jīngguò yīshēng jǐ tiān de jīngxīn zhìliáo yǔ tiáolǐ, shēngbìng bìngrén de tǐwēn yǐjīng huìfù dào le wánquán zhèngcháng zhuàngtài.', 'Trải qua vài ngày điều trị và bồi bổ chu đáo của bác sĩ, thân nhiệt của người bệnh đã hồi phục về trạng thái hoàn toàn bình thường.', 'basic', 1),
        (v_id, '面对全球供应链局域性中断冲击，交通运输部门多措并举确保国际物流通道与港口正常通关运转。', 'Miànduì quánqiú gōngyìngliàn júyùxìng zhōngduàn chōngjī, jiāotōng yùnshū bùmén duō cuò bìng jǔ quèbǎo guójì wùliú tōngdào yǔ gǎngkǒu zhèngcháng tōngguān yùnzhuǎn.', 'Đối mặt với cú sốc đứt gãy mang tính cục bộ của chuỗi cung ứng toàn cầu, ngành giao thông vận tải áp dụng nhiều giải pháp đồng bộ nhằm đảm bảo các hành lang logistics quốc tế và cảng biển vận hành thông quan bình thường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [正好] (zhènghǎo) - vừa vặn, đúng lúc, vừa hay [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '正好' AND pinyin = 'zhènghǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '正好'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'zhènghǎo',
      meaning_vi = 'vừa vặn, đúng lúc, vừa hay',
      example_hanzi = '我刚想出门去超市买菜，正好在电梯门口碰见了刚下班回家的妻子。',
      example_pinyin = 'Wǒ gāng xiǎng chūmén qù chāoshì mǎi cài, zhènghǎo zài diàntī ménkǒu pèngjiàn le gāng xiàbān huíjiā de qīzi.',
      example_vi = 'Tôi vừa định ra ngoài đến siêu thị mua rau thì vừa hay gặp ngay vợ mới tan sở về nhà ở cửa thang máy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我刚想出门去超市买菜，正好在电梯门口碰见了刚下班回家的妻子。', 'Wǒ gāng xiǎng chūmén qù chāoshì mǎi cài, zhènghǎo zài diàntī ménkǒu pèngjiàn le gāng xiàbān huíjiā de qīzi.', 'Tôi vừa định ra ngoài đến siêu thị mua rau thì vừa hay gặp ngay vợ mới tan sở về nhà ở cửa thang máy.', 'basic', 1),
        (v_id, '这项国家新出台的科技型中小企业税收减免红利，正好有效缓解了初创科创企业现阶段面临的流动资金压力。', 'Zhè xiàng guójiā xīn chūtái de kējìxíng zhōng-xiǎo qǐyè shuìshōu jiǎnmiǎn hónglì, zhènghǎo yǒuxiào huǎnjiě le chūchuàng kē-chuàng qǐyè xiànjiēduàn miànlín de liúdòng zījīn yālì.', 'Lợi ích giảm miễn thuế dành cho doanh nghiệp vừa và nhỏ loại hình khoa học công nghệ mới ban hành của nhà nước lần này, đúng lúc đã làm dịu hiệu quả áp lực vốn lưu động mà các doanh nghiệp khởi nghiệp đổi mới sáng tạo đang đối mặt ở giai đoạn hiện tại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [证件] (zhèngjiàn) - giấy tờ tùy thân, giấy chứng nhận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '证件' AND pinyin = 'zhèngjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '证件'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhèngjiàn',
      meaning_vi = 'giấy tờ tùy thân, giấy chứng nhận',
      example_hanzi = '出境旅游乘坐国际航班前，请务必核对自己和随行家人的护照及签证等证件是否齐全有效。',
      example_pinyin = 'Chūjìng lǚyóu chéngzuò guójì hángbān qián, qǐng wùbì héduì zìjǐ hé suíxíng jiārén de hùzhào jí qiānzhèng děng zhèngjiàn shìfǒu qíquán yǒuxiào.',
      example_vi = 'Trước khi đi du lịch nước ngoài ngồi máy bay quốc tế, xin vui lòng kiểm tra kỹ lưỡng các giấy tờ như hộ chiếu và thị thực của bản thân và người nhà đi cùng xem có đầy đủ và còn hiệu lực hay không.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出境旅游乘坐国际航班前，请务必核对自己和随行家人的护照及签证等证件是否齐全有效。', 'Chūjìng lǚyóu chéngzuò guójì hángbān qián, qǐng wùbì héduì zìjǐ hé suíxíng jiārén de hùzhào jí qiānzhèng děng zhèngjiàn shìfǒu qíquán yǒuxiào.', 'Trước khi đi du lịch nước ngoài ngồi máy bay quốc tế, xin vui lòng kiểm tra kỹ lưỡng các giấy tờ như hộ chiếu và thị thực của bản thân và người nhà đi cùng xem có đầy đủ và còn hiệu lực hay không.', 'basic', 1),
        (v_id, '全国一体化数字政务平台全面实现居民电子身份证件互通互认，极大提升了跨省异地办事便捷度。', 'Quánguó yītǐhuà shùzì zhèngwù píngtái quánmiàn shíxiàn jūmín diànzǐ shēnfèn zhèngjiàn hùtōng-hùrèn, jídà tíshēng le kuàshěng yìdì bànshì biànjiédù.', 'Nền tảng chính vụ số tích hợp toàn quốc đã thực hiện toàn diện việc liên thông và công nhận lẫn nhau các giấy tờ tùy thân điện tử của người dân, nâng cao rất lớn mức độ thuận tiện khi làm thủ tục hành chính liên tỉnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [证明] (zhèngmíng) - chứng minh; giấy chứng nhận [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '证明' AND pinyin = 'zhèngmíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '证明'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhèngmíng',
      meaning_vi = 'chứng minh; giấy chứng nhận',
      example_hanzi = '事实充分证明，只要坚持每天脚踏实地刻苦积累，就一定能在期末考试中取得理想的好成绩。',
      example_pinyin = 'Shìshí chōngfèn zhèngmíng, zhǐyào jiānchí měi tiān jiǎotà-shídì kèkǔ jīlěi, jiù yídìng néng zài qīmò kǎoshì zhōng qǔdé lǐxiǎng de hǎo chéngjì.',
      example_vi = 'Sự thật chứng minh đầy đủ rằng, chỉ cần mỗi ngày kiên trì tích lũy chăm chỉ từng bước vững chắc thì nhất định có thể giành được thành tích tốt lý tưởng trong kỳ thi cuối kỳ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '事实充分证明，只要坚持每天脚踏实地刻苦积累，就一定能在期末考试中取得理想的好成绩。', 'Shìshí chōngfèn zhèngmíng, zhǐyào jiānchí měi tiān jiǎotà-shídì kèkǔ jīlěi, jiù yídìng néng zài qīmò kǎoshì zhōng qǔdé lǐxiǎng de hǎo chéngjì.', 'Sự thật chứng minh đầy đủ rằng, chỉ cần mỗi ngày kiên trì tích lũy chăm chỉ từng bước vững chắc thì nhất định có thể giành được thành tích tốt lý tưởng trong kỳ thi cuối kỳ.', 'basic', 1),
        (v_id, '改革开放四十多年来的伟大实践雄辩地证明，开放带来进步，封闭必然落后。', 'Gǎigé kāifàng sìshí duō nián lái de wěidà shíjiàn xióngbiàn de zhèngmíng, kāifàng dàilái jìnbù, fēngbì bìrán luòhòu.', 'Thực tiễn vĩ đại hơn bốn mươi năm qua của công cuộc cải cách mở cửa đã chứng minh một cách hùng hồn rằng, mở cửa đem lại tiến bộ, khép kín tất yếu lạc hậu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [正确] (zhèngquè) - chính xác, đúng đắn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '正确' AND pinyin = 'zhèngquè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '正确'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'zhèngquè',
      meaning_vi = 'chính xác, đúng đắn',
      example_hanzi = '在做数学逻辑分析题时，掌握科学正确的解题思路远比单纯死记硬背公式更为重要。',
      example_pinyin = 'Zài zuò shùxué luójí fēnxī tí shí, zhǎngwò kēxué zhèngquè de jiětí sīlù yuǎn bǐ dānchún sǐjì-yìngbèi gōngshì yuǎn wéi zhòngyào.',
      example_vi = 'Khi làm các bài toán phân tích logic học, việc nắm bắt hướng tư duy giải đề khoa học đúng đắn quan trọng hơn nhiều so với việc đơn thuần học vẹt ghi nhớ công thức.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在做数学逻辑分析题时，掌握科学正确的解题思路远比单纯死记硬背公式更为重要。', 'Zài zuò shùxué luójí fēnxī tí shí, zhǎngwò kēxué zhèngquè de jiětí sīlù yuǎn bǐ dānchún sǐjì-yìngbèi gōngshì yuǎn wéi zhòngyào.', 'Khi làm các bài toán phân tích logic học, việc nắm bắt hướng tư duy giải đề khoa học đúng đắn quan trọng hơn nhiều so với việc đơn thuần học vẹt ghi nhớ công thức.', 'basic', 1),
        (v_id, '坚持正确政治方向与遵循科学客观规律有机统一，是确保各项宏观重大公共决策经得起实践检验的坚实基石。', 'Jiānchí zhèngquè zhèngzhì fāngxiàng yǔ zūnxún kēxué kèguān guīlǜ yǒujī tǒngyī, shì quèbǎo gè xiàng hóngguān zhòngdà gōnggòng juécè jīngdeqǐ shíjiàn jiǎnyàn de jiānshí jīshí.', 'Kiên trì định hướng chính trị đúng đắn kết hợp hữu cơ với việc tuân thủ các quy luật khách quan khoa học là nền tảng vững chắc để đảm bảo mọi quyết sách công lớn mang tính vĩ mô vượt qua được sự kiểm nghiệm của thực tiễn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [正式] (zhèngshì) - chính thức [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '正式' AND pinyin = 'zhèngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '正式'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'zhèngshì',
      meaning_vi = 'chính thức',
      example_hanzi = '经过全校师生近一年的精心筹建，新校园现代数字化图书馆今天正式向全体师生开放借阅。',
      example_pinyin = 'Jīngguò quán xiào shīshēng jìn yì nián de jīngxīn chóujiàn, xīn xiàoyuán xiàndài shùzìhuà túshūguǎn jīntiān zhèngshì xiàng quántǐ shīshēng kāifàng jièyuè.',
      example_vi = 'Trải qua gần một năm dày công chuẩn bị xây dựng của toàn thể giáo viên và học sinh toàn trường, thư viện số hóa hiện đại của khuôn viên trường mới hôm nay đã chính thức mở cửa phục vụ mượn đọc cho mọi người.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全校师生近一年的精心筹建，新校园现代数字化图书馆今天正式向全体师生开放借阅。', 'Jīngguò quán xiào shīshēng jìn yì nián de jīngxīn chóujiàn, xīn xiàoyuán xiàndài shùzìhuà túshūguǎn jīntiān zhèngshì xiàng quántǐ shīshēng kāifàng jièyuè.', 'Trải qua gần một năm dày công chuẩn bị xây dựng của toàn thể giáo viên và học sinh toàn trường, thư viện số hóa hiện đại của khuôn viên trường mới hôm nay đã chính thức mở cửa phục vụ mượn đọc cho mọi người.', 'basic', 1),
        (v_id, '两国元首共同见证并正式签署双边全面自由贸易协定，标志着双边经贸务实合作迈入历史新纪元。', 'Liǎng guó yuánshǒu gòngtóng jiànzhèng bìng zhèngshì qiānshǔ shuāngbiān quánmiàn zìyóu màoyì xiédìng, biāozhì zhe shuāngbiān jīng-mào wùshí hézuò màirù lìshǐ xīn jìyuán.', 'Nguyên thủ hai nước cùng chứng kiến và chính thức ký kết hiệp định thương mại tự do toàn diện song phương, đánh dấu sự hợp tác kinh tế thương mại thực chất song phương bước sang kỷ nguyên lịch sử mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [之] (zhī) - của; (đại từ: nó, người đó) [Trợ từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '之' AND pinyin = 'zhī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Trợ từ',
      pinyin = 'zhī',
      meaning_vi = 'của; (đại từ: nó, người đó)',
      example_hanzi = '桂林山水甲天下，碧绿澄澈的漓江水宛如一条环绕在翠绿群山之中的青色绸带。',
      example_pinyin = 'Guìlín shānshuǐ jiǎ tiānxià, bìlǜ chéngchè de Líjiāng shuǐ wǎnrú yì tiáo huánrào zài cuìlǜ qúnshān zhī zhōng de qīngsè chóudài.',
      example_vi = 'Non nước Quế Lâm đẹp nhất thiên hạ, dòng nước sông Ly xanh biếc trong vắt tựa như một dải lụa xanh biếc uốn lượn giữa những dãy núi xanh rì.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '桂林山水甲天下，碧绿澄澈的漓江水宛如一条环绕在翠绿群山之中的青色绸带。', 'Guìlín shānshuǐ jiǎ tiānxià, bìlǜ chéngchè de Líjiāng shuǐ wǎnrú yì tiáo huánrào zài cuìlǜ qúnshān zhī zhōng de qīngsè chóudài.', 'Non nước Quế Lâm đẹp nhất thiên hạ, dòng nước sông Ly xanh biếc trong vắt tựa như một dải lụa xanh biếc uốn lượn giữa những dãy núi xanh rì.', 'basic', 1),
        (v_id, '坚持以人民为中心的发展思想，是中国特色社会主义理论体系的核心要义与力量之源。', 'Jiānchí yǐ rénmín wéi zhōngxīn de fāzhǎn sīxiǎng, shì Zhōngguó tèsè shèhuìzhǔyì lǐlùn tǐxì de héxīn yàoyì yǔ lìliàng zhī yuán.', 'Kiên trì tư tưởng phát triển lấy nhân dân làm trung tâm là cốt lõi chủ yếu và cội nguồn sức mạnh của hệ thống lý luận chủ nghĩa xã hội đặc sắc Trung Quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [支持] (zhīchí) - ủng hộ, hỗ trợ [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '支持' AND pinyin = 'zhīchí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '支持'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhīchí',
      meaning_vi = 'ủng hộ, hỗ trợ',
      example_hanzi = '在我决定跨专业报考研究生时，父母和最好的朋友都给予了我最坚定的理解与支持。',
      example_pinyin = 'Zài wǒ juédìng kuà zhuānyè bàokǎo yánjiūshēng shí, fùmǔ hé zuì hǎo de péngyou dōu jǐyǔ le wǒ zuì jiāndìng de lǐjiě yǔ zhīchí.',
      example_vi = 'Khi tôi quyết định đăng ký thi cao học trái ngành, cha mẹ và người bạn thân nhất đều đã dành cho tôi sự thấu hiểu và ủng hộ kiên định nhất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在我决定跨专业报考研究生时，父母和最好的朋友都给予了我最坚定的理解与支持。', 'Zài wǒ juédìng kuà zhuānyè bàokǎo yánjiūshēng shí, fùmǔ hé zuì hǎo de péngyou dōu jǐyǔ le wǒ zuì jiāndìng de lǐjiě yǔ zhīchí.', 'Khi tôi quyết định đăng ký thi cao học trái ngành, cha mẹ và người bạn thân nhất đều đã dành cho tôi sự thấu hiểu và ủng hộ kiên định nhất.', 'basic', 1),
        (v_id, '国家设立千亿元级重大科技成果转化引导基金，全力支持前沿颠覆性原创技术的孵化与产业化落地。', 'Guójiā shèlì qiān yì yuán jí zhòngdà kējì chéngguǒ zhuǎnhuà yǐndǎo jījīn, quánlì zhīchí qiányán diānfùxìng yuánchuàng jìshù de fūhuà yǔ chǎnyèhuà luòdì.', 'Nhà nước thành lập quỹ định hướng chuyển giao thành quả khoa học công nghệ trọng đại quy mô ngàn tỷ nhân dân tệ, dốc toàn lực ủng hộ việc ươm tạo và hiện thực hóa công nghiệp hóa cho các công nghệ sáng tạo đột phá tiên phong.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [支付] (zhīfù) - chi trả, thanh toán [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '支付' AND pinyin = 'zhīfù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '支付'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhīfù',
      meaning_vi = 'chi trả, thanh toán',
      example_hanzi = '随着移动数字技术的广泛普及，现在出门买菜和乘坐公交都可以直接使用手机扫码支付。',
      example_pinyin = 'Suízhe yídòng shùzì jìshù de guǎngfàn pǔjí, xiànzài chūmén mǎi cài hé chéngzuò gōngjiāo dōu kěyǐ zhíjiē shǐyòng shǒujī sǎomǎ zhīfù.',
      example_vi = 'Cùng với sự phổ cập rộng rãi của công nghệ số di động, hiện nay ra ngoài mua rau hay đi xe buýt đều có thể trực tiếp dùng điện thoại quét mã thanh toán.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着移动数字技术的广泛普及，现在出门买菜和乘坐公交都可以直接使用手机扫码支付。', 'Suízhe yídòng shùzì jìshù de guǎngfàn pǔjí, xiànzài chūmén mǎi cài hé chéngzuò gōngjiāo dōu kěyǐ zhíjiē shǐyòng shǒujī sǎomǎ zhīfù.', 'Cùng với sự phổ cập rộng rãi của công nghệ số di động, hiện nay ra ngoài mua rau hay đi xe buýt đều có thể trực tiếp dùng điện thoại quét mã thanh toán.', 'basic', 1),
        (v_id, '跨国电商综合试验区全面支持跨境贸易本币结算与多样化国际第三方数字支付清算服务。', 'Kuàguó diànshāng zōnghé shìyànqū quánmiàn zhīchí kuàjìng màoyì běnbì jiésuàn yǔ duōyànghuà guójì dì-sān fāng shùzì zhīfù qīngsuàn fúwù.', 'Khu thí nghiệm tổng hợp thương mại điện tử xuyên biên giới hỗ trợ toàn diện việc thanh toán thương mại xuyên biên giới bằng đồng nội tệ và các dịch vụ thanh toán bù trừ số bên thứ ba quốc tế đa dạng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [之后] (zhīhòu) - sau khi, sau đó [Danh từ / Phương vị từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '之后' AND pinyin = 'zhīhòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之后'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phương vị từ',
      pinyin = 'zhīhòu',
      meaning_vi = 'sau khi, sau đó',
      example_hanzi = '结束了为期一周紧张忙碌的期末考试之后，全班同学相约一起去郊外爬山放松身心。',
      example_pinyin = 'Jiéshù le wéiqī yì zhōu jǐnzhāng mánglù de qīmò kǎoshì zhīhòu, quánbān tóngxué xiāngyuē yìqǐ qù jiāowài páshān fàngsōng shēnxīn.',
      example_vi = 'Sau khi kết thúc kỳ thi cuối kỳ căng thẳng bận rộn kéo dài một tuần, cả lớp rủ nhau cùng đi leo núi ở ngoại ô để thư giãn tâm hồn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '结束了为期一周紧张忙碌的期末考试之后，全班同学相约一起去郊外爬山放松身心。', 'Jiéshù le wéiqī yì zhōu jǐnzhāng mánglù de qīmò kǎoshì zhīhòu, quánbān tóngxué xiāngyuē yìqǐ qù jiāowài páshān fàngsōng shēnxīn.', 'Sau khi kết thúc kỳ thi cuối kỳ căng thẳng bận rộn kéo dài một tuần, cả lớp rủ nhau cùng đi leo núi ở ngoại ô để thư giãn tâm hồn.', 'basic', 1),
        (v_id, '在经历了长达数年的全面重组之后，该老牌重工装备企业成功焕发新生并重新领跑高端制造市场。', 'Zài jīnglì le cháng dá shù nián de quánmiàn chóngzǔ zhīhòu, gāi lǎopái zhònggōng zhuāngbèi qǐyè chénggōng huànfā xīnshēng bìng chóngxīn lǐngpǎo gāoduān zhìzào shìchǎng.', 'Sau khi trải qua quá trình tái cơ cấu toàn diện kéo dài suốt mấy năm, doanh nghiệp trang thiết bị công nghiệp nặng lâu đời này đã thành công tái sinh và tiếp tục dẫn đầu thị trường chế tạo cao cấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [之间] (zhījiān) - giữa, trong khoảng [Danh từ / Phương vị từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '之间' AND pinyin = 'zhījiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之间'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phương vị từ',
      pinyin = 'zhījiān',
      meaning_vi = 'giữa, trong khoảng',
      example_hanzi = '朋友之间若是遇到了误会与矛盾，一定要面对面心平气和地坦诚交流，不要互相猜忌。',
      example_pinyin = 'Péngyou zhījiān ruòshì yùdào le wùhuì yǔ máodùn, yídìng yào miànduìmiàn xīnpíng-qìhé de tǎnchéng jiāoliú, bú yào hùxiāng cāijì.',
      example_vi = 'Giữa bạn bè nếu như nảy sinh hiểu lầm và mâu thuẫn, nhất định phải trực tiếp mặt đối mặt bình tâm hòa khí trao đổi thẳng thắn, đừng nghi kỵ lẫn nhau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '朋友之间若是遇到了误会与矛盾，一定要面对面心平气和地坦诚交流，不要互相猜忌。', 'Péngyou zhījiān ruòshì yùdào le wùhuì yǔ máodùn, yídìng yào miànduìmiàn xīnpíng-qìhé de tǎnchéng jiāoliú, bú yào hùxiāng cāijì.', 'Giữa bạn bè nếu như nảy sinh hiểu lầm và mâu thuẫn, nhất định phải trực tiếp mặt đối mặt bình tâm hòa khí trao đổi thẳng thắn, đừng nghi kỵ lẫn nhau.', 'basic', 1),
        (v_id, '加强城市群之间以及大中小城市之间的高效基础设施互联互通，是优化全国国土空间开发保护格局的内在要求。', 'Jiāqiáng chéngshìqún zhījiān yǐjí dà-zhōng-xiǎo chéngshì zhījiān de gāoxiào jīchǔ shèshī hùlián-hùtōng, shì yōuhuà quánguó guótǔ kōngjiān kāifā bǎohù géjú de nèizài yāoqiú.', 'Tăng cường sự kết nối liên thông cơ sở hạ tầng hiệu quả cao giữa các cụm đô thị cũng như giữa các đô thị lớn, vừa và nhỏ là yêu cầu nội tại để tối ưu hóa cục diện bảo vệ và khai thác không gian lãnh thổ toàn quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [之前] (zhīqián) - trước khi, trước đó [Danh từ / Phương vị từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '之前' AND pinyin = 'zhīqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之前'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phương vị từ',
      pinyin = 'zhīqián',
      meaning_vi = 'trước khi, trước đó',
      example_hanzi = '在每次正式登台演讲或者参加口语考试之前，他都会在镜子前深呼吸反复练习几次。',
      example_pinyin = 'Zài měi cì zhèngshì dēngtái yǎnjiǎng huòzhě cānjiā kǒuyǔ kǎoshì zhīqián, tā dōu huì zài jìngzi qián shēn hūxī fǎnfù liànxí jǐ cì.',
      example_vi = 'Trước mỗi lần chính thức bước lên sân khấu diễn thuyết hay tham gia thi vấn đáp, anh ấy đều đứng trước gương hít thở sâu và luyện tập lặp đi lặp lại vài lần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在每次正式登台演讲或者参加口语考试之前，他都会在镜子前深呼吸反复练习几次。', 'Zài měi cì zhèngshì dēngtái yǎnjiǎng huòzhě cānjiā kǒuyǔ kǎoshì zhīqián, tā dōu huì zài jìngzi qián shēn hūxī fǎnfù liànxí jǐ cì.', 'Trước mỗi lần chính thức bước lên sân khấu diễn thuyết hay tham gia thi vấn đáp, anh ấy đều đứng trước gương hít thở sâu và luyện tập lặp đi lặp lại vài lần.', 'basic', 1),
        (v_id, '重大外商投资项目正式核准开工建设之前，必须严格履行用地预审、环境影响评价等法定前置审批程序。', 'Zhòngdà wàishāng tóuzī xiàngmù zhèngshì hézhǔn kāigōng jiànshè zhīqián, bìxū yángé lǚxíng yòngdì yùshěn, huánjìng yǐngxiǎng píngjià děng fǎdìng qiánzhì shěnpī chéngxù.', 'Trước khi dự án đầu tư nước ngoài trọng đại chính thức được phê chuẩn khởi công xây dựng, bắt buộc phải thực hiện nghiêm ngặt các quy trình thẩm duyệt tiền khả thi theo luật định như thẩm định trước sử dụng đất, đánh giá tác động môi trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [知识] (zhīshi) - kiến thức, tri thức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '知识' AND pinyin = 'zhīshi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '知识'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhīshi',
      meaning_vi = 'kiến thức, tri thức',
      example_hanzi = '读书能够开阔眼界、启迪智慧，让我们在浩瀚的书海中汲取源源不断的新知识。',
      example_pinyin = 'Dúshū nénggòu kāikuò yǎnjiè, qǐdí zhìhuì, ràng wǒmen zài hàohàn de shūhǎi zhōng jíqǔ yuányuán-bùduàn de xīn zhīshi.',
      example_vi = 'Đọc sách có thể mở rộng tầm mắt, khơi dậy trí tuệ, giúp chúng ta tiếp thu những tri thức mới bất tận trong biển sách mênh mông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '读书能够开阔眼界、启迪智慧，让我们在浩瀚的书海中汲取源源不断的新知识。', 'Dúshū nénggòu kāikuò yǎnjiè, qǐdí zhìhuì, ràng wǒmen zài hàohàn de shūhǎi zhōng jíqǔ yuányuán-bùduàn de xīn zhīshi.', 'Đọc sách có thể mở rộng tầm mắt, khơi dậy trí tuệ, giúp chúng ta tiếp thu những tri thức mới bất tận trong biển sách mênh mông.', 'basic', 1),
        (v_id, '保护知识产权就是保护创新，我国全面强化对关键核心技术专利与数字版权的司法协同保护力度。', 'Bǎohù zhīshi chǎnquán jiù shì bǎohù chuàngxīn, wǒ guó quánmiàn qiánghuà duì guānjiàn héxīn jìshù zhuānlì yǔ shùzì bǎnyuán de sīfǎ xiétóng bǎohù lìdù.', 'Bảo vệ quyền sở hữu trí tuệ chính là bảo vệ sự đổi mới sáng tạo, nước ta tăng cường toàn diện mức độ bảo vệ phối hợp tư pháp đối với bằng sáng chế công nghệ then chốt cốt lõi và bản quyền số.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [之中] (zhīzhōng) - trong, ở giữa [Danh từ / Phương vị từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '之中' AND pinyin = 'zhīzhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之中'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phương vị từ',
      pinyin = 'zhīzhōng',
      meaning_vi = 'trong, ở giữa',
      example_hanzi = '清晨漫步在绿树成荫的幽静公园之中，呼吸着花草泥土的芬芳，整个人感到心旷神怡。',
      example_pinyin = 'Qīngchén mànbù zài lǜshù-chéngyīn de yōujìng gōngyuán zhī zhōng, hūxī zhe huācǎo nítǔ de fēnfāng, zhěng gè rén gǎndào xīnkuàng-shényí.',
      example_vi = 'Sáng sớm tản bộ trong công viên thanh tĩnh rợp bóng cây xanh, hít thở hương thơm thoang thoảng của cỏ hoa bùn đất, cả con người cảm thấy tâm hồn thư thái sảng khoái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清晨漫步在绿树成荫的幽静公园之中，呼吸着花草泥土的芬芳，整个人感到心旷神怡。', 'Qīngchén mànbù zài lǜshù-chéngyīn de yōujìng gōngyuán zhī zhōng, hūxī zhe huācǎo nítǔ de fēnfāng, zhěng gè rén gǎndào xīnkuàng-shényí.', 'Sáng sớm tản bộ trong công viên thanh tĩnh rợp bóng cây xanh, hít thở hương thơm thoang thoảng của cỏ hoa bùn đất, cả con người cảm thấy tâm hồn thư thái sảng khoái.', 'basic', 1),
        (v_id, '在世界百年未有之大变局加速演进的宏阔历史浪潮之中，唯有坚定推进科技自立自强才能牢牢掌握发展主动权。', 'Zài shìjiè bǎinián wèiyǒu zhī dà biànjú jiāsù yǎnjìn de hóngkuò lìshǐ làngcháo zhī zhōng, wéiyǒu jiāndìng tuījìn kējì zìlì-zìqiáng cái néng láoláo zhǎngwò fāzhǎn zhǔdòngquán.', 'Trong làn sóng lịch sử bao la của cục diện biến chuyển lớn trăm năm chưa từng có của thế giới đang tăng tốc diễn tiến, chỉ có kiên định thúc đẩy tự lực tự cường về khoa học công nghệ thì mới có thể nắm chắc quyền chủ động phát triển trong tay.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [值] (zhí) - đáng, có giá trị; giá trị, trị số [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '值' AND pinyin = 'zhí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '值'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhí',
      meaning_vi = 'đáng, có giá trị; giá trị, trị số',
      example_hanzi = '这种纯手工制作的优质紫砂茶壶工艺极其精湛，无论用来沏茶还是收藏都十分值钱。',
      example_pinyin = 'Zhè zhǒng chún shǒugōng zhìzuò de yōuzhì zǐshā cháhú gōngyì jíqí jīngzhàn, wúlùn yònglái qīchá hái shì shōucáng dōu shífēn zhíqián.',
      example_vi = 'Loại ấm trà tử sa thượng hạng chế tác hoàn toàn thủ công này tay nghề vô cùng tinh xảo, dù dùng để pha trà hay sưu tầm đều rất có giá trị.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这种纯手工制作的优质紫砂茶壶工艺极其精湛，无论用来沏茶还是收藏都十分值钱。', 'Zhè zhǒng chún shǒugōng zhìzuò de yōuzhì zǐshā cháhú gōngyì jíqí jīngzhàn, wúlùn yònglái qīchá hái shì shōucáng dōu shífēn zhíqián.', 'Loại ấm trà tử sa thượng hạng chế tác hoàn toàn thủ công này tay nghề vô cùng tinh xảo, dù dùng để pha trà hay sưu tầm đều rất có giá trị.', 'basic', 1),
        (v_id, '坚持绿水青山就是金山银山的重要理念，加快健全生态产品总值核算机制与生态保护补偿制度。', 'Jiānchí lǜshuǐ qīngshān jiù shì jīnshān yínshān de zhòngyào lǐniàn, jiākuài jiànquán shēngtài chǎnpǐn zǒngzhí hésuàn jīzhì yǔ shēngtài bǎohù bǔcháng zhìdù.', 'Kiên trì quan niệm quan trọng nước biếc non xanh chính là núi vàng núi bạc, đẩy nhanh việc kiện toàn cơ chế hạch toán tổng giá trị sản phẩm sinh thái và chế độ đền bù bảo vệ sinh thái.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [值得] (zhídé) - đáng, xứng đáng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '值得' AND pinyin = 'zhídé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '值得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhídé',
      meaning_vi = 'đáng, xứng đáng',
      example_hanzi = '这部获得国际电影节大奖的感人纪录片深刻探讨了人与自然的共生关系，非常值得全家人一起观赏。',
      example_pinyin = 'Zhè bù huòdé guójì diànyǐngjié dàjiǎng de gǎnrén jìlùpiàn shēnkè tàntǎo le rén yǔ zìrán de gòngshēng guānxi, fēicháng zhídé quán jiā rén yìqǐ guānshǎng.',
      example_vi = 'Bộ phim tài liệu cảm động đoạt giải thưởng lớn tại liên hoan phim quốc tế này đã đào sâu tìm hiểu mối quan hệ cộng sinh giữa con người và tự nhiên, rất xứng đáng để cả gia đình cùng nhau thưởng thức.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这部获得国际电影节大奖的感人纪录片深刻探讨了人与自然的共生关系，非常值得全家人一起观赏。', 'Zhè bù huòdé guójì diànyǐngjié dàjiǎng de gǎnrén jìlùpiàn shēnkè tàntǎo le rén yǔ zìrán de gòngshēng guānxi, fēicháng zhídé quán jiā rén yìqǐ guānshǎng.', 'Bộ phim tài liệu cảm động đoạt giải thưởng lớn tại liên hoan phim quốc tế này đã đào sâu tìm hiểu mối quan hệ cộng sinh giữa con người và tự nhiên, rất xứng đáng để cả gia đình cùng nhau thưởng thức.', 'basic', 1),
        (v_id, '青年科技攻关团队攻坚克难所展现出的顽强拼搏奉献品格，值得在全社会各行业广泛宣传学习推广。', 'Qīngnián kējì gōngguān tuánduì gōngjiān-kènán suǒ zhǎnxiàn chū de wánqiáng pīnbó fèngxiàn pǐngé, zhídé zài quán shèhuì gè hángyè guǎngfàn xuānchuán xuéxí tuīguǎng.', 'Phẩm cách cống hiến nỗ lực kiên cường mà đội ngũ thanh niên công phá khoa học công nghệ thể hiện khi vượt khó vượt khổ rất xứng đáng được tuyên truyền, học tập và nhân rộng rộng rãi trong mọi ngành nghề toàn xã hội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [直接] (zhíjiē) - trực tiếp [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '直接' AND pinyin = 'zhíjiē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '直接'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'zhíjiē',
      meaning_vi = 'trực tiếp',
      example_hanzi = '如果你在日常学习中遇到了不懂的专业问题，可以直接去办公室向任课老师当面请教。',
      example_pinyin = 'Rúguǒ nǐ zài rìcháng xuéxí zhōng yùdào le bù dǒng de zhuānyè wèntí, kěyǐ zhíjiē qù bàngōngshì xiàng rènkè lǎoshī dāngmiàn qǐngjiào.',
      example_vi = 'Nếu bạn trong học tập hằng ngày gặp phải vấn đề chuyên ngành chưa hiểu, có thể trực tiếp đến văn phòng thỉnh giáo trực diện thầy cô phụ trách môn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如果你在日常学习中遇到了不懂的专业问题，可以直接去办公室向任课老师当面请教。', 'Rúguǒ nǐ zài rìcháng xuéxí zhōng yùdào le bù dǒng de zhuānyè wèntí, kěyǐ zhíjiē qù bàngōngshì xiàng rènkè lǎoshī dāngmiàn qǐngjiào.', 'Nếu bạn trong học tập hằng ngày gặp phải vấn đề chuyên ngành chưa hiểu, có thể trực tiếp đến văn phòng thỉnh giáo trực diện thầy cô phụ trách môn.', 'basic', 1),
        (v_id, '地方财政资金通过直达机制直接拨付至基层县区与具体项目，有效减少了中间流转环节以提高资金使用效能。', 'Dìfāng cáizhèng zījīn tōngguò zhídá jīzhì zhíjiē bōfù zhì jīcéng xiànqū yǔ jùtǐ xiàngmù, yǒuxiào jiǎnshǎo le zhōngjiān liúzhuǎn huánjié yǐ tígāo zījīn shǐyòng xiàonéng.', 'Nguồn vốn tài chính ngân sách địa phương thông qua cơ chế phân bổ thẳng trực tiếp giải ngân tới tận các quận huyện cơ sở và các dự án cụ thể, giảm bớt hiệu quả các khâu trung chuyển trung gian để nâng cao hiệu quả sử dụng nguồn vốn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [植物] (zhíwù) - thực vật, cây cối [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '植物' AND pinyin = 'zhíwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '植物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhíwù',
      meaning_vi = 'thực vật, cây cối',
      example_hanzi = '植物园里引种培育了来自世界各地的数千种珍稀热带植物，一年四季繁花似锦。',
      example_pinyin = 'Zhíwùyuán lǐ yǐnzhǒng péiyù le láizì shìjiè gèdì de shù qiān zhǒng zhēnxī rèdài zhíwù, yì nián sìjì fánhuā-sìjǐn.',
      example_vi = 'Trong vườn thực vật du nhập và ươm trồng hàng ngàn loài thực vật nhiệt đới quý hiếm đến từ khắp nơi trên thế giới, bốn mùa quanh năm hoa nở rực rỡ như gấm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '植物园里引种培育了来自世界各地的数千种珍稀热带植物，一年四季繁花似锦。', 'Zhíwùyuán lǐ yǐnzhǒng péiyù le láizì shìjiè gèdì de shù qiān zhǒng zhēnxī rèdài zhíwù, yì nián sìjì fánhuā-sìjǐn.', 'Trong vườn thực vật du nhập và ươm trồng hàng ngàn loài thực vật nhiệt đới quý hiếm đến từ khắp nơi trên thế giới, bốn mùa quanh năm hoa nở rực rỡ như gấm.', 'basic', 1),
        (v_id, '国家级自然保护区建立了涵盖濒危野生动植物基因库与生态走廊的完整保护系统，筑牢了区域生物多样性安全屏障。', 'Guójiā-jí zìrán bǎohùqū jiànlì le hángài bīnwēi yèshēng dòng-zhíwù jīyīnkù yǔ shēngtài zǒuláng de wánzhěng bǎohù xìtǒng, zhù láo le qūyù shēngwù duōyàngxìng ānquán píngzhàng.', 'Khu bảo tồn thiên nhiên cấp quốc gia đã thiết lập hệ thống bảo tồn hoàn chỉnh bao gồm ngân hàng gen động thực vật hoang dã nguy cấp và hành lang sinh thái, củng cố vững chắc bức bình phong an toàn đa dạng sinh học khu vực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [职业] (zhíyè) - nghề nghiệp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '职业' AND pinyin = 'zhíyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '职业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhíyè',
      meaning_vi = 'nghề nghiệp',
      example_hanzi = '高中毕业前夕，学校专门组织了职业生涯规划指导讲座，帮助学生们科学确立未来的大学专业方向。',
      example_pinyin = 'Gāozhōng bìyè qiánxī, xuéxiào zhuānmén zǔzhī le zhíyè shēngyá guīhuà zhǐdǎo jiǎngzuò, bāngzhù xuéshengmen kēxué quèlì wèilái de dàxué zhuānyè fāngxiàng.',
      example_vi = 'Trước thềm tốt nghiệp trung học phổ thông, nhà trường đã đặc biệt tổ chức buổi tọa đàm hướng dẫn quy hoạch nghề nghiệp tương lai, giúp học sinh xác định định hướng chuyên ngành đại học tương lai một cách khoa học.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '高中毕业前夕，学校专门组织了职业生涯规划指导讲座，帮助学生们科学确立未来的大学专业方向。', 'Gāozhōng bìyè qiánxī, xuéxiào zhuānmén zǔzhī le zhíyè shēngyá guīhuà zhǐdǎo jiǎngzuò, bāngzhù xuéshengmen kēxué quèlì wèilái de dàxué zhuānyè fāngxiàng.', 'Trước thềm tốt nghiệp trung học phổ thông, nhà trường đã đặc biệt tổ chức buổi tọa đàm hướng dẫn quy hoạch nghề nghiệp tương lai, giúp học sinh xác định định hướng chuyên ngành đại học tương lai một cách khoa học.', 'basic', 1),
        (v_id, '职业教育是培养高素质技术技能人才的重要途径，国家大力推进产教深度融合与现代职业教育高质量发展体系建设。', 'Zhíyè jiàoyù shì péiyǎng gāo sùzhì jìshù jìnéng réncái de zhòngyào tújìng, guójiā dàlì tuījìn chǎn-jiào shēndù rónghé yǔ xiàndài zhíyè jiàoyù gāozhìliàng fāzhǎn tǐxì jiànshè.', 'Giáo dục nghề nghiệp là con đường quan trọng để đào tạo nhân tài kỹ thuật tay nghề tố chất cao, nhà nước hết sức thúc đẩy gắn kết sâu rộng giữa đào tạo và sản xuất và xây dựng hệ thống phát triển chất lượng cao giáo dục nghề nghiệp hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [指] (zhǐ) - chỉ, trỏ; ngón tay; nhằm vào [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '指' AND pinyin = 'zhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '指'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhǐ',
      meaning_vi = 'chỉ, trỏ; ngón tay; nhằm vào',
      example_hanzi = '站在高高的山顶上极目远眺，老师用手指着山脚下蜿蜒流淌的美丽小河。',
      example_pinyin = 'Zhàn zài gāogāo de shāndǐng shang jímù yuǎntiào, lǎoshī yòng shǒuzhǐ zhǐzhe shānjiǎo xià wānyán liútǎng de měilì xiǎohé.',
      example_vi = 'Đứng trên đỉnh núi cao phóng tầm mắt ra xa, thầy giáo dùng ngón tay chỉ vào con sông nhỏ tuyệt đẹp đang uốn lượn chảy dưới chân núi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '站在高高的山顶上极目远眺，老师用手指着山脚下蜿蜒流淌的美丽小河。', 'Zhàn zài gāogāo de shāndǐng shang jímù yuǎntiào, lǎoshī yòng shǒuzhǐ zhǐzhe shānjiǎo xià wānyán liútǎng de měilì xiǎohé.', 'Đứng trên đỉnh núi cao phóng tầm mắt ra xa, thầy giáo dùng ngón tay chỉ vào con sông nhỏ tuyệt đẹp đang uốn lượn chảy dưới chân núi.', 'basic', 1),
        (v_id, '新一代国家经济发展规划明确指出，“高质量发展”是指不仅追求经济规模的扩张，更要追求发展效益与生态和谐。', 'Xīn yídài guójiā jīngjì fāzhǎn guīhuà míngquè zhǐchū, “gāo zhìliàng fāzhǎn” shì zhǐ bùjǐn zhuīqiú jīngjì guīmó de kuòzhāng, gèng yào zhuīqiú fāzhǎn xiàoyì yǔ shēngtài héxié.', 'Quy hoạch phát triển kinh tế quốc gia thế hệ mới chỉ rõ, "phát triển chất lượng cao" nhằm chỉ việc không chỉ mưu cầu mở rộng quy mô kinh tế, mà còn phải mưu cầu hiệu quả phát triển và sự hài hòa sinh thái.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [指出] (zhǐchū) - chỉ ra, nêu rõ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '指出' AND pinyin = 'zhǐchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '指出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhǐchū',
      meaning_vi = 'chỉ ra, nêu rõ',
      example_hanzi = '在批改语文作文时，老师十分耐心地指出了我文章结构上的几处不足。',
      example_pinyin = 'Zài pīgǎi yǔwén zuòwén shí, lǎoshī shífēn nàixīn de zhǐchū le wǒ wénzhāng jiégòu shang de jǐ chù bùzú.',
      example_vi = 'Khi chấm chữa bài tập làm văn ngữ văn, thầy giáo đã vô cùng kiên nhẫn chỉ ra vài điểm thiếu sót trong cấu trúc bài viết của tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在批改语文作文时，老师十分耐心地指出了我文章结构上的几处不足。', 'Zài pīgǎi yǔwén zuòwén shí, lǎoshī shífēn nàixīn de zhǐchū le wǒ wénzhāng jiégòu shang de jǐ chù bùzú.', 'Khi chấm chữa bài tập làm văn ngữ văn, thầy giáo đã vô cùng kiên nhẫn chỉ ra vài điểm thiếu sót trong cấu trúc bài viết của tôi.', 'basic', 1),
        (v_id, '国际货币基金组织在最新全球经济展望报告中深刻指出，加快推进绿色低碳转型是全球经济走出低迷增长的核心钥匙。', 'Guójì Huòbì Jījīn Zǔzhī zài zuìxīn quánqiú jīngjì zhǎnwàng bàogào zhōng shēnkè zhǐchū, jiākuài tuījìn lǜsè dītàn zhuǎnxíng shì quánqiú jīngjì zǒuchū dīmí zēngzhǎng de héxīn yàoshi.', 'Quỹ Tiền tệ Quốc tế trong báo cáo triển vọng kinh tế toàn cầu mới nhất đã chỉ ra sâu sắc rằng, đẩy nhanh chuyển đổi xanh phát thải thấp là chìa khóa cốt lõi để kinh tế toàn cầu thoát khỏi tình trạng tăng trưởng ảm đạm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [只好] (zhǐhǎo) - đành phải, đành lòng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '只好' AND pinyin = 'zhǐhǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '只好'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'zhǐhǎo',
      meaning_vi = 'đành phải, đành lòng',
      example_hanzi = '由于突发雷阵雨导致航班严重延误，滞留在候机厅的旅客们只好耐心等待改签。',
      example_pinyin = 'Yóuyú tūfā léizhènyǔ dǎozhì hángbān yánzhòng yánwù, zhìliú zài hòujītīng de lǚkèmen zhǐhǎo nàixīn děngdài gǎiqiān.',
      example_vi = 'Do giông bão bất ngờ làm cho chuyến bay bị trễ nghiêm trọng, hành khách đang bị kẹt tại phòng chờ đành phải kiên nhẫn chờ đổi vé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '由于突发雷阵雨导致航班严重延误，滞留在候机厅的旅客们只好耐心等待改签。', 'Yóuyú tūfā léizhènyǔ dǎozhì hángbān yánzhòng yánwù, zhìliú zài hòujītīng de lǚkèmen zhǐhǎo nàixīn děngdài gǎiqiān.', 'Do giông bão bất ngờ làm cho chuyến bay bị trễ nghiêm trọng, hành khách đang bị kẹt tại phòng chờ đành phải kiên nhẫn chờ đổi vé.', 'basic', 1),
        (v_id, '在传统高能耗工业增长模式已触及环境资源承载红线的严峻形势下，沿江高污染化工企业只好彻底转型停产搬迁。', 'Zài chuántǒng gāo nénghào gōngyè zēngzhǎng móshì yǐ chùjí huánjìng zīyuán chéngzài hóngxiàn de yánjùn xíngshì xià, yánjiāng gāo wūrǎn huàgōng qǐyè zhǐhǎo chèdǐ zhuǎnxíng tíngchǎn bānqiān.', 'Dưới tình thế nghiêm trọng khi mô hình tăng trưởng công nghiệp tiêu hao nhiều năng lượng truyền thống đã chạm vạch đỏ sức chịu tải tài nguyên môi trường, các doanh nghiệp hóa chất gây ô nhiễm cao dọc bờ sông đành phải chuyển đổi triệt để, ngừng sản xuất và di dời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [纸巾] (zhǐjīn) - khăn giấy, giấy lau [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '纸巾' AND pinyin = 'zhǐjīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '纸巾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhǐjīn',
      meaning_vi = 'khăn giấy, giấy lau',
      example_hanzi = '吃完麻辣火锅后满头大汗，服务员贴心地为每一位顾客送上了清凉湿润的抽纸巾。',
      example_pinyin = 'Chī wán málà huǒguō hòu mǎn tóu dà hàn, fúwùyuán tiēxīn de wèi měi yí wèi gùkè sòng shang le qīngliáng shīrùn de chōuzhǐjīn.',
      example_vi = 'Ăn xong nồi lẩu cay tê mồ hôi nhễ nhại khắp đầu, nhân viên phục vụ đã chu đáo mang lên cho từng vị khách hộp khăn giấy rút mát lạnh ẩm dịu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '吃完麻辣火锅后满头大汗，服务员贴心地为每一位顾客送上了清凉湿润的抽纸巾。', 'Chī wán málà huǒguō hòu mǎn tóu dà hàn, fúwùyuán tiēxīn de wèi měi yí wèi gùkè sòng shang le qīngliáng shīrùn de chōuzhǐjīn.', 'Ăn xong nồi lẩu cay tê mồ hôi nhễ nhại khắp đầu, nhân viên phục vụ đã chu đáo mang lên cho từng vị khách hộp khăn giấy rút mát lạnh ẩm dịu.', 'basic', 1),
        (v_id, '环保部门倡导全社会减少使用一次性原生木浆纸巾，大力推广使用环保竹纤维制品以保护森林生态资源。', 'Huánbǎo bùmén chàngdǎo quán shèhuì jiǎnshǎo shǐyòng yícìxìng yuánshēng mùjiāng zhǐjīn, dàlì tuīguǎng shǐyòng huánbǎo zhúxiānwéi zhìpǐn yǐ bǎohù sēnlín shēngtài zīyuán.', 'Ban ngành bảo vệ môi trường kêu gọi toàn xã hội giảm bớt sử dụng khăn giấy bột gỗ nguyên sinh dùng một lần, hết sức quảng bá sử dụng sản phẩm sợi tre thân thiện môi trường để bảo vệ tài nguyên sinh thái rừng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [质量] (zhìliàng) - chất lượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '质量' AND pinyin = 'zhìliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '质量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhìliàng',
      meaning_vi = 'chất lượng',
      example_hanzi = '这件纯羊毛大衣不仅面料保暖舒适，而且做工极其精致，整体质量非常好。',
      example_pinyin = 'Zhè jiàn chún yángmáo dàyī bùjǐn miànliào bǎonuǎn shūshì, érqiě zuògōng jíqí jīngzhì, zhěngtǐ zhìliàng fēicháng hǎo.',
      example_vi = 'Chiếc áo khoác dạ cừu nguyên chất này không những chất vải giữ ấm dễ chịu, mà đường may cũng vô cùng tinh xảo, chất lượng tổng thể rất tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这件纯羊毛大衣不仅面料保暖舒适，而且做工极其精致，整体质量非常好。', 'Zhè jiàn chún yángmáo dàyī bùjǐn miànliào bǎonuǎn shūshì, érqiě zuògōng jíqí jīngzhì, zhěngtǐ zhìliàng fēicháng hǎo.', 'Chiếc áo khoác dạ cừu nguyên chất này không những chất vải giữ ấm dễ chịu, mà đường may cũng vô cùng tinh xảo, chất lượng tổng thể rất tốt.', 'basic', 1),
        (v_id, '实施质量强国建设是推动经济由高速增长转向高质量发展的战略抉择，必须全面健全全产业链现代质量管理体系。', 'Shíshī zhìliàng qiángguó jiànshè shì tuīdòng jīngjì yóu gāosù zēngzhǎng zhuǎnxiàng gāo zhìliàng fāzhǎn de zhànlüè juézé, bìxū quánmiàn jiànquán quán chǎnyèliàn xiàndài zhìliàng guǎnlǐ tǐxì.', 'Thực thi xây dựng cường quốc chất lượng là sự lựa chọn chiến lược thúc đẩy nền kinh tế chuyển từ tăng trưởng tốc độ cao sang phát triển chất lượng cao, bắt buộc phải kiện toàn toàn diện hệ thống quản lý chất lượng hiện đại trên toàn chuỗi công nghiệp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [至少] (zhìshǎo) - ít nhất, tối thiểu [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '至少' AND pinyin = 'zhìshǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '至少'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'zhìshǎo',
      meaning_vi = 'ít nhất, tối thiểu',
      example_hanzi = '医生建议成年人每天至少要保证七到八小时的充足睡眠，以维持充沛的精力。',
      example_pinyin = 'Yīshēng jiànyì chéngnián rén měitiān zhìshǎo yào bǎozhèng qī dào bā xiǎoshí de chōngzú shuìmián, yǐ wéichí chōngpèi de jīnglì.',
      example_vi = 'Bác sĩ khuyên người trưởng thành mỗi ngày ít nhất phải đảm bảo ngủ đủ giấc từ bảy đến tám tiếng để duy trì năng lượng dồi dào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '医生建议成年人每天至少要保证七到八小时的充足睡眠，以维持充沛的精力。', 'Yīshēng jiànyì chéngnián rén měitiān zhìshǎo yào bǎozhèng qī dào bā xiǎoshí de chōngzú shuìmián, yǐ wéichí chōngpèi de jīnglì.', 'Bác sĩ khuyên người trưởng thành mỗi ngày ít nhất phải đảm bảo ngủ đủ giấc từ bảy đến tám tiếng để duy trì năng lượng dồi dào.', 'basic', 1),
        (v_id, '按照国际环保公约新要求，全球航运业主要枢纽港口至少要将百分之五十的岸电设施全面投入常态化清洁运营。', 'Ànzhào guójì huánbǎo gōngyuē xīn yāoqiú, quánqiú hángyùnyè zhǔyào shūniǔ gǎngkǒu zhìshǎo yào jiāng bǎi fēn zhī wǔshí de àndiàn shèshī quánmiàn tóurù chángtàihuà qīngjié yùnyíng.', 'Chiếu theo yêu cầu mới của công ước bảo vệ môi trường quốc tế, các cảng trung chuyển huyết mạch của ngành vận tải biển toàn cầu ít nhất phải đưa năm mươi phần trăm cơ sở điện bờ vào vận hành sạch thường thái hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [中餐] (zhōngcān) - món ăn Trung Hoa, cơm Trung Quốc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '中餐' AND pinyin = 'zhōngcān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '中餐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhōngcān',
      meaning_vi = 'món ăn Trung Hoa, cơm Trung Quốc',
      example_hanzi = '许多外国留学生来到中国之后，很快就深深爱上了色香味俱全的正宗传统中餐。',
      example_pinyin = 'Xǔduō wàiguó liúxuéshēng lái dào Zhōngguó zhīhòu, hěn kuài jiù shēnshēn ài shang le sè-xiāng-wèi jùquán de zhèngzōng chuántǒng zhōngcān.',
      example_vi = 'Nhiều lưu học sinh nước ngoài sau khi tới Trung Quốc đã nhanh chóng say mê sâu sắc những món ăn Trung Hoa truyền thống chính tông sắc hương vị vẹn toàn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '许多外国留学生来到中国之后，很快就深深爱上了色香味俱全的正宗传统中餐。', 'Xǔduō wàiguó liúxuéshēng lái dào Zhōngguó zhīhòu, hěn kuài jiù shēnshēn ài shang le sè-xiāng-wèi jùquán de zhèngzōng chuántǒng zhōngcān.', 'Nhiều lưu học sinh nước ngoài sau khi tới Trung Quốc đã nhanh chóng say mê sâu sắc những món ăn Trung Hoa truyền thống chính tông sắc hương vị vẹn toàn.', 'basic', 1),
        (v_id, '推动中国传统中餐文化走向世界，不仅有助于繁荣国际餐饮服务贸易，更是向世界生动讲好中国故事的重要文化载体。', 'Tuīdòng Zhōngguó chuántǒng zhōngcān wénhuà zǒuxiàng shìjiè, bùjǐn yǒu zhù yú fánróng guójì cānyǐn fúwù màoyì, gèng shì xiàng shìjiè shēngdòng jiǎng hǎo Zhōngguó gùshi de zhòngyào wénhuà zàitǐ.', 'Thúc đẩy văn hóa ẩm thực Trung Hoa truyền thống bước ra thế giới không chỉ giúp làm phồn vinh thương mại dịch vụ ẩm thực quốc tế, mà còn là cầu nối văn hóa quan trọng kể câu chuyện Trung Quốc sinh động cho thế giới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [中年] (zhōngnián) - trung niên, tuổi trung niên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '中年' AND pinyin = 'zhōngnián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '中年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhōngnián',
      meaning_vi = 'trung niên, tuổi trung niên',
      example_hanzi = '人到中年常常面临着上有老下有小的家庭压力，因此保持身心健康显得尤为重要。',
      example_pinyin = 'Rén dào zhōngnián chángcháng miànlín zhe shàng yǒu lǎo xià yǒu xiǎo de jiātíng yālì, yīncǐ bǎochí shēnxīn jiànkāng xiǎnde yóuwéi zhòngyào.',
      example_vi = 'Con người khi bước vào tuổi trung niên thường đối mặt với áp lực gia đình trên có già dưới có trẻ, vì vậy giữ gìn sức khỏe thể chất và tâm hồn trở nên đặc biệt quan trọng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '人到中年常常面临着上有老下有小的家庭压力，因此保持身心健康显得尤为重要。', 'Rén dào zhōngnián chángcháng miànlín zhe shàng yǒu lǎo xià yǒu xiǎo de jiātíng yālì, yīncǐ bǎochí shēnxīn jiànkāng xiǎnde yóuwéi zhòngyào.', 'Con người khi bước vào tuổi trung niên thường đối mặt với áp lực gia đình trên có già dưới có trẻ, vì vậy giữ gìn sức khỏe thể chất và tâm hồn trở nên đặc biệt quan trọng.', 'basic', 1),
        (v_id, '面对人口深度老龄化趋势，国家积极推动终身职业技能培训，全面赋能中年再就业群体适应新兴数字经济岗位需求。', 'Miànduì rénkǒu shēndù lǎolínghuà qūshì, guójiā jījí tuīdòng zhōngshēn zhíyè jìnéng péixùn, quánmiàn fùnéng zhōngnián zàijiùyè qúntǐ shìyìng xīnxīng shùzì jīngjì gǎngwèi xūqiú.', 'Đối mặt với xu thế già hóa dân số sâu sắc, nhà nước tích cực thúc đẩy đào tạo kỹ năng nghề nghiệp suốt đời, nâng cao toàn diện năng lực cho nhóm đối tượng trung niên tái gia nhập thị trường lao động thích ứng với nhu cầu vị trí việc làm kinh tế số mới nổi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [种] (zhòng) - trồng, trồng trọt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '种' AND pinyin = 'zhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '种'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhòng',
      meaning_vi = 'trồng, trồng trọt',
      example_hanzi = '每年春暖花开的三月植树节，全校师生都会前往郊外山坡义务种下一排排绿树。',
      example_pinyin = 'Měi nián chūnnuǎn-huākāi de sān yuè zhíshùjié, quán xiào shīshēng dōu huì qiánwǎng jiāowài shānpō yiwù zhòng xià yì pái pái lǜshù.',
      example_vi = 'Mỗi năm vào tết Trồng cây tháng ba tiết xuân ấm áp hoa nở, thầy và trò toàn trường đều đến sườn đồi ngoại ô trồng nên từng hàng cây xanh nghĩa vụ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年春暖花开的三月植树节，全校师生都会前往郊外山坡义务种下一排排绿树。', 'Měi nián chūnnuǎn-huākāi de sān yuè zhíshùjié, quán xiào shīshēng dōu huì qiánwǎng jiāowài shānpō yiwù zhòng xià yì pái pái lǜshù.', 'Mỗi năm vào tết Trồng cây tháng ba tiết xuân ấm áp hoa nở, thầy và trò toàn trường đều đến sườn đồi ngoại ô trồng nên từng hàng cây xanh nghĩa vụ.', 'basic', 1),
        (v_id, '农业科研团队深入盐碱地开展耐盐碱超级水稻种繁育实验，成功探索出在荒滩上规模化种稻的生态农业新路径。', 'Nóngyè kēyán tuánduì shēnrù yánjiǎndì kāizhǎn nàiyánjiǎn chāojí shuǐdào zhǒng fányù shíyàn, chénggōng tànsuǒ chū zài huāngtān shang guīmóhuà zhòng dào de shēngtài nóngyè xīn lùjìng.', 'Đội ngũ nghiên cứu khoa học nông nghiệp đi sâu vào vùng đất phèn mặn triển khai thí nghiệm nhân giống lúa siêu năng suất chịu mặn, thành công tìm tòi ra con đường mới cho nông nghiệp sinh thái trồng lúa quy mô lớn trên bãi hoang.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [重] (zhòng) - nặng, quan trọng, nghiêm trọng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '重' AND pinyin = 'zhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '重'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'zhòng',
      meaning_vi = 'nặng, quan trọng, nghiêm trọng',
      example_hanzi = '这个装满专业厚重书籍的旅行箱太重了，小丽一个人根本提不动它。',
      example_pinyin = 'Zhè ge zhuāng mǎn zhuānyè hòuzhòng shūjí de lǚxíngxiāng tài zhòng le, Xiǎolì yí gè rén gēnběn tíbudòng tā.',
      example_vi = 'Chiếc vali du lịch đựng đầy những cuốn sách chuyên ngành dày cộp này nặng quá, một mình Tiểu Lệ căn bản không thể nhấc nổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个装满专业厚重书籍的旅行箱太重了，小丽一个人根本提不动它。', 'Zhè ge zhuāng mǎn zhuānyè hòuzhòng shūjí de lǚxíngxiāng tài zhòng le, Xiǎolì yí gè rén gēnběn tíbudòng tā.', 'Chiếc vali du lịch đựng đầy những cuốn sách chuyên ngành dày cộp này nặng quá, một mình Tiểu Lệ căn bản không thể nhấc nổi.', 'basic', 1),
        (v_id, '推进国家治理现代化必须着重解决群众急难愁盼的民生痛点，把保障民生作为各项工作的重中之重。', 'Tuījìn guójiā zhìlǐ xiàndàihuà bìxū zhuózhòng jiějué qúnzhòng jínán-chóupàn de mínshēng tòngdiǎn, bǎ bǎozhàng mínshēng zuòwéi gè xiàng gōngzuò de zhòngzhōngzhīzhòng.', 'Thúc đẩy hiện đại hóa quản trị quốc gia bắt buộc phải chú trọng giải quyết các điểm nghẽn dân sinh cấp thiết mà quần chúng đang trông đợi, lấy việc bảo đảm dân sinh làm nhiệm vụ trọng tâm hàng đầu trong mọi công tác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [重点] (zhòngdiǎn) - trọng điểm, then chốt [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '重点' AND pinyin = 'zhòngdiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '重点'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'zhòngdiǎn',
      meaning_vi = 'trọng điểm, then chốt',
      example_hanzi = '老师在黑板上用红粉笔圈出的几个物理公式是本周复习考试的核心重点。',
      example_pinyin = 'Lǎoshī zài hēibǎn shang yòng hóng fěnbǐ quān chū de jǐ gè wùlǐ gōngshì shì běn zhōu fùxí kǎoshì de héxīn zhòngdiǎn.',
      example_vi = 'Mấy công thức vật lý mà thầy giáo dùng phấn đỏ khoanh tròn trên bảng đen là trọng tâm cốt lõi của kỳ thi ôn tập tuần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师在黑板上用红粉笔圈出的几个物理公式是本周复习考试的核心重点。', 'Lǎoshī zài hēibǎn shang yòng hóng fěnbǐ quān chū de jǐ gè wùlǐ gōngshì shì běn zhōu fùxí kǎoshì de héxīn zhòngdiǎn.', 'Mấy công thức vật lý mà thầy giáo dùng phấn đỏ khoanh tròn trên bảng đen là trọng tâm cốt lõi của kỳ thi ôn tập tuần này.', 'basic', 1),
        (v_id, '国家发展改革委印发重大工程规划，明确将战略性新兴产业与未来产业列为区域投资布局的重点方向。', 'Guójiā Fāzhǎn Gǎigé Wěi yìnfā zhòngdà gōngchéng guīhuà, míngquè jiāng zhànlüèxìng xīnxīng chǎnyè yǔ wèilái chǎnyè liè wéi qūyù tóuzī bùjú de zhòngdiǎn fāngxiàng.', 'Ủy ban Cải cách và Phát triển Quốc gia ban hành quy hoạch công trình trọng đại, xác định rõ việc đưa các ngành công nghiệp mới nổi mang tính chiến lược và ngành công nghiệp tương lai vào phương hướng trọng điểm trong bố trí đầu tư khu vực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [重视] (zhòngshì) - coi trọng, chú trọng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '重视' AND pinyin = 'zhòngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '重视'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhòngshì',
      meaning_vi = 'coi trọng, chú trọng',
      example_hanzi = '现代家庭越来越重视培养孩子的独立自理能力与健康的心理素质。',
      example_pinyin = 'Xiàndài jiātíng yuè lái yuè zhòngshì péiyǎng háizi de dúlì zìlǐ nénglì yǔ jiànkāng de xīnlǐ sùzhì.',
      example_vi = 'Các gia đình hiện đại ngày càng coi trọng việc bồi dưỡng năng lực tự lập tự quản và tố chất tâm lý lành mạnh cho con cái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '现代家庭越来越重视培养孩子的独立自理能力与健康的心理素质。', 'Xiàndài jiātíng yuè lái yuè zhòngshì péiyǎng háizi de dúlì zìlǐ nénglì yǔ jiànkāng de xīnlǐ sùzhì.', 'Các gia đình hiện đại ngày càng coi trọng việc bồi dưỡng năng lực tự lập tự quản và tố chất tâm lý lành mạnh cho con cái.', 'basic', 1),
        (v_id, '各级政府必须高度重视保护民营经济产权与企业家合法权益，营造国际一流的市场化法治化营商环境。', 'Gè jí zhèngfǔ bìxū gāodù zhòngshì bǎohù mínyíng jīngjì chǎnquán yǔ qǐyèjiā héfǎ quányì, yíngzào guójì yīliú de shìchǎnghuà fǎzhìhuà yíngshāng huánjìng.', 'Chính quyền các cấp bắt buộc phải hết sức coi trọng việc bảo vệ quyền sở hữu tài sản của kinh tế tư nhân và quyền lợi hợp pháp của doanh nhân, kiến tạo môi trường kinh doanh pháp trị hóa và thị trường hóa hạng nhất quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [周围] (zhōuwéi) - xung quanh, chung quanh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '周围' AND pinyin = 'zhōuwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '周围'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhōuwéi',
      meaning_vi = 'xung quanh, chung quanh',
      example_hanzi = '我们的大学校园依山傍水，周围环绕着茂密的竹林和清澈的湖泊，环境非常优美宜人。',
      example_pinyin = 'Wǒmen de dàxué xiàoyuán yīshān-bàngshuǐ, zhōuwéi huánràozhe màomì de zhúlín hé qīngchè de húpò, huánjìng fēicháng yōuměi yírén.',
      example_vi = 'Khuôn viên trường đại học của chúng tôi tựa núi nhìn sông, xung quanh bao bọc bởi rừng trúc rậm rạp và hồ nước trong veo, môi trường vô cùng tươi đẹp dễ chịu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们的大学校园依山傍水，周围环绕着茂密的竹林和清澈的湖泊，环境非常优美宜人。', 'Wǒmen de dàxué xiàoyuán yīshān-bàngshuǐ, zhōuwéi huánràozhe màomì de zhúlín hé qīngchè de húpò, huánjìng fēicháng yōuměi yírén.', 'Khuôn viên trường đại học của chúng tôi tựa núi nhìn sông, xung quanh bao bọc bởi rừng trúc rậm rạp và hồ nước trong veo, môi trường vô cùng tươi đẹp dễ chịu.', 'basic', 1),
        (v_id, '随着中心城市辐射带动能力持续增强，周边卫星城市及周围县域经济呈现出深度融合一体化发展的崭新格局。', 'Suízhe zhōngxīn chéngshì fúshè dàidòng nénglì chíxù zēngqiáng, zhōubiān wèixīng chéngshì jí zhōuwéi xiànyù jīngjì chéngxiàn chū shēndù rónghé yītǐhuà fāzhǎn de zhǎnxīn géjú.', 'Cùng với năng lực lan tỏa dẫn dắt của đô thị trung tâm liên tục tăng cường, các đô thị vệ tinh vùng ven và kinh tế cấp huyện xung quanh thể hiện cấu trúc mới hoàn toàn về sự phát triển hợp nhất dung hợp sâu sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [主意] (zhǔyi) - ý kiến, chủ ý, sáng kiến [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '主意' AND pinyin = 'zhǔyi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '主意'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhǔyi',
      meaning_vi = 'ý kiến, chủ ý, sáng kiến',
      example_hanzi = '听到大家为了野餐地点争论不休，班长突然提出了一个去近郊生态果园采摘的好主意。',
      example_pinyin = 'Tīngdào dàjiā wèile yěcān dìdiǎn zhēnglùn-bùxiū, bānzhǎng tūrán tíchū le yí gè qù jìnjiāo shēngtài guǒyuán cǎizhāi de hǎo zhǔyi.',
      example_vi = 'Nghe mọi người tranh cãi không dứt về địa điểm dã ngoại, lớp trưởng đột nhiên nêu ra một chủ ý hay là đến vườn cây ăn quả sinh thái ngoại ô hái quả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到大家为了野餐地点争论不休，班长突然提出了一个去近郊生态果园采摘的好主意。', 'Tīngdào dàjiā wèile yěcān dìdiǎn zhēnglùn-bùxiū, bānzhǎng tūrán tíchū le yí gè qù jìnjiāo shēngtài guǒyuán cǎizhāi de hǎo zhǔyi.', 'Nghe mọi người tranh cãi không dứt về địa điểm dã ngoại, lớp trưởng đột nhiên nêu ra một chủ ý hay là đến vườn cây ăn quả sinh thái ngoại ô hái quả.', 'basic', 1),
        (v_id, '青年创业者要敢于打破墨守成规的思维定式，把天马行空的创新金主意转化为切合市场需求的商业模式。', 'Qīngnián chuàngyèzhě yào gǎnyú dǎpò mòshǒu-chéngguī de sīwéi dìngshì, bǎ tiānmǎ-xíngkōng de chuàngxīn jīnzhǔyi zhuǎnhuà wéi qièhé shìchǎng xūqiú de shāngyè móshì.', 'Các nhà khởi nghiệp trẻ tuổi cần dám phá vỡ lối mòn tư duy bảo thủ theo khuôn cũ, biến những ý tưởng vàng đổi mới bay bổng thành mô hình kinh doanh phù hợp với nhu cầu thị trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [祝] (zhù) - chúc, chúc tụng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '祝' AND pinyin = 'zhù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '祝'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhù',
      meaning_vi = 'chúc, chúc tụng',
      example_hanzi = '在新年钟声敲响的美好时刻，让我们共同举杯祝愿全家人身体健康、吉祥如意！',
      example_pinyin = 'Zài xīnnián zhōngshēng qiāoxiǎng de měihǎo shíkè, ràng wǒmen gòngtóng jǔbēi zhùyuàn quán jiā rén shēntǐ jiànkāng, jíxiáng-rúyì!',
      example_vi = 'Trong khoảnh khắc tốt đẹp khi tiếng chuông năm mới điểm vang, chúng ta hãy cùng nhau nâng ly chúc toàn thể gia đình dồi dào sức khỏe, cát tường như ý!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在新年钟声敲响的美好时刻，让我们共同举杯祝愿全家人身体健康、吉祥如意！', 'Zài xīnnián zhōngshēng qiāoxiǎng de měihǎo shíkè, ràng wǒmen gòngtóng jǔbēi zhùyuàn quán jiā rén shēntǐ jiànkāng, jíxiáng-rúyì!', 'Trong khoảnh khắc tốt đẹp khi tiếng chuông năm mới điểm vang, chúng ta hãy cùng nhau nâng ly chúc toàn thể gia đình dồi dào sức khỏe, cát tường như ý!', 'basic', 1),
        (v_id, '中方愿与国际社会携手并进，共同祝愿世界各国人民早日摆脱战乱贫困，共享和平发展与繁荣成果。', 'Zhōngfāng yuàn yǔ guójì shèhuì xiéshǒu bìngjìn, gòngtóng zhùyuàn shìjiè gè guó rénmín zǎorì bǎituō zhànluàn pínkùn, gòngxiǎng hépíng fāzhǎn yǔ fánróng chéngguǒ.', 'Phía Trung Quốc sẵn sàng cùng cộng đồng quốc tế kề vai sát cánh, cùng chúc nhân dân các nước trên thế giới sớm thoát khỏi chiến tranh nghèo khó, cùng chia sẻ thành quả hòa bình phát triển và phồn vinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [祝贺] (zhùhè) - chúc mừng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '祝贺' AND pinyin = 'zhùhè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '祝贺'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhùhè',
      meaning_vi = 'chúc mừng',
      example_hanzi = '听到好友在国际钢琴比赛中荣获金奖的消息，我第一时间发去信息向他表示热烈祝贺。',
      example_pinyin = 'Tīngdào hǎoyǒu zài guójì gāngqín bǐsài zhōng rónghuò jīnjiǎng de xiāoxi, wǒ dì-yī shíjiān fā qù xiāoxi xiàng tā biǎoshì rèliè zhùhè.',
      example_vi = 'Nghe tin người bạn thân đoạt giải vàng tại cuộc thi dương cầm quốc tế, tôi đã nhắn tin chúc mừng nồng nhiệt đến bạn ấy ngay thời điểm đầu tiên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到好友在国际钢琴比赛中荣获金奖的消息，我第一时间发去信息向他表示热烈祝贺。', 'Tīngdào hǎoyǒu zài guójì gāngqín bǐsài zhōng rónghuò jīnjiǎng de xiāoxi, wǒ dì-yī shíjiān fā qù xiāoxi xiàng tā biǎoshì rèliè zhùhè.', 'Nghe tin người bạn thân đoạt giải vàng tại cuộc thi dương cầm quốc tế, tôi đã nhắn tin chúc mừng nồng nhiệt đến bạn ấy ngay thời điểm đầu tiên.', 'basic', 1),
        (v_id, '多国国家元首与国际组织领导人纷纷致电致函，热烈祝贺中国在深空探测与月球科考领域取得历史性卓越突破。', 'Duō guó guójiā yuánshǒu yǔ guójì zǔzhī lǐngdǎorén fēnfēn zhìdiàn zhìhán, rèliè zhùhè Zhōngguó zài shēnkōng tàncè yǔ yuèqiú kěkǎo lǐngyù qǔdé lìshǐxìng zhuóyuè tūpò.', 'Nguyên thủ nhiều quốc gia và lãnh đạo các tổ chức quốc tế đã tới tấp gửi điện và thư chúc mừng, nồng nhiệt chúc mừng Trung Quốc đạt được đột phá lịch sử xuất sắc trong lĩnh vực thám hiểm không gian sâu và nghiên cứu khoa học mặt trăng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [著名] (zhùmíng) - nổi tiếng, trứ danh [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '著名' AND pinyin = 'zhùmíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '著名'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'zhùmíng',
      meaning_vi = 'nổi tiếng, trứ danh',
      example_hanzi = '杭州西湖是中国最著名的风景旅游胜地之一，以秀丽的湖光山色和丰富的历史传说闻名天下。',
      example_pinyin = 'Hángzhōu Xīhú shì Zhōngguó zuì zhùmíng de fēngjǐng lǚyóu shèngdì zhīyī, yǐ xiùlì de húguāng-shānsè hé fēngfù de lìshǐ chuánshuō wénmíng tiānxià.',
      example_vi = 'Tây Hồ Hàng Châu là một trong những danh lam thắng cảnh du lịch nổi tiếng nhất Trung Quốc, vang danh thiên hạ nhờ cảnh sắc non nước hữu tình và các truyền thuyết lịch sử phong phú.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '杭州西湖是中国最著名的风景旅游胜地之一，以秀丽的湖光山色和丰富的历史传说闻名天下。', 'Hángzhōu Xīhú shì Zhōngguó zuì zhùmíng de fēngjǐng lǚyóu shèngdì zhīyī, yǐ xiùlì de húguāng-shānsè hé fēngfù de lìshǐ chuánshuō wénmíng tiānxià.', 'Tây Hồ Hàng Châu là một trong những danh lam thắng cảnh du lịch nổi tiếng nhất Trung Quốc, vang danh thiên hạ nhờ cảnh sắc non nước hữu tình và các truyền thuyết lịch sử phong phú.', 'basic', 1),
        (v_id, '著名战略科学家钱学森将毕生心血无私倾注于祖国国防科技事业，为“两弹一星”超级工程作出了不可磨灭的历史贡献。', 'Zhùmíng zhànlüè kēxuéjiā Qián Xuésēn jiāng bìshēng xīnxuè wúsī qīngzhù yú zǔguó guófáng kējì shìyè, wèi “liǎng dàn yì xīng” chāojí gōngchéng zuòchū le bùkě mómì de lìshǐ gòngxiàn.', 'Nhà khoa học chiến lược nổi tiếng Tiền Học Sâm đã dồn hết tâm huyết cả đời quên mình cho sự nghiệp khoa học công nghệ quốc phòng của tổ quốc, đóng góp công lao lịch sử không thể phai mờ cho siêu công trình "Hai quả bom một vệ tinh".', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [专门] (zhuānmén) - chuyên môn, chuyên biệt, đặc biệt [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '专门' AND pinyin = 'zhuānmén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '专门'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'zhuānmén',
      meaning_vi = 'chuyên môn, chuyên biệt, đặc biệt',
      example_hanzi = '叔叔趁着出差北京的机会，专门去琉璃厂古玩街为喜爱书法的爷爷精心挑选了一套优质宣纸和毛笔。',
      example_pinyin = 'Shūshu chènzhe chūchāi Běijīng de jīhuì, zhuānmén qù Liúlíchǎng gǔwán jiē wèi xǐ’ài shūfǎ de yéye jīngxīn tiāoxuǎn le yí tào yōuzhì xuānzhǐ hé máobǐ.',
      example_vi = 'Chú nhân dịp đi công tác Bắc Kinh đã đặc biệt đến phố đồ cổ Lưu Ly Xưởng tỉ mỉ chọn mua một bộ giấy xuyến và bút lông thượng hạng gửi tặng ông nội yêu thích thư pháp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '叔叔趁着出差北京的机会，专门去琉璃厂古玩街为喜爱书法的爷爷精心挑选了一套优质宣纸和毛笔。', 'Shūshu chènzhe chūchāi Běijīng de jīhuì, zhuānmén qù Liúlíchǎng gǔwán jiē wèi xǐ’ài shūfǎ de yéye jīngxīn tiāoxuǎn le yí tào yōuzhì xuānzhǐ hé máobǐ.', 'Chú nhân dịp đi công tác Bắc Kinh đã đặc biệt đến phố đồ cổ Lưu Ly Xưởng tỉ mỉ chọn mua một bộ giấy xuyến và bút lông thượng hạng gửi tặng ông nội yêu thích thư pháp.', 'basic', 1),
        (v_id, '国家发展改革委设立专门工作机构，全天候统筹协调跨区域重大能源战略输送管道与特高压输电走廊建设。', 'Guójiā Fāzhǎn Gǎigé Wěi shèlì zhuānmén gōngzuò jīgòu, quántiānhòu tǒngchóu xiétáo kuà-qūyù zhòngdà néngyuán zhànlüè shūsòng guǎndào yǔ tè-gāoyā shūdiàn zǒuláng jiànshè.', 'Ủy ban Cải cách và Phát triển Quốc gia thành lập cơ quan làm việc chuyên trách, điều phối tổng thể suốt ngày đêm việc xây dựng các đường ống dẫn năng lượng chiến lược trọng đại liên vùng và hành lang truyền tải điện siêu cao áp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [专业] (zhuānyè) - chuyên ngành; chuyên nghiệp [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '专业' AND pinyin = 'zhuānyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '专业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'zhuānyè',
      meaning_vi = 'chuyên ngành; chuyên nghiệp',
      example_hanzi = '大学毕业后，他凭借深厚的计算机软件工程专业知识，顺利入职了一家知名科技企业担任前端工程师。',
      example_pinyin = 'Dàxué bìyè hòu, tā píngjiè shēnhòu de jìsuànjī ruǎnjiàn gōngchéng zhuānyè zhīshi, shùnlì rùzhí le yì jiā zhīmíng kējì qǐyè dānrèn qiánduān gōngchéngshī.',
      example_vi = 'Sau khi tốt nghiệp đại học, anh ấy nhờ vào kiến thức chuyên ngành kỹ thuật phần mềm máy tính sâu rộng đã thuận lợi gia nhập một công ty công nghệ có tiếng đảm nhiệm vị trí kỹ sư frontend.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大学毕业后，他凭借深厚的计算机软件工程专业知识，顺利入职了一家知名科技企业担任前端工程师。', 'Dàxué bìyè hòu, tā píngjiè shēnhòu de jìsuànjī ruǎnjiàn gōngchéng zhuānyè zhīshi, shùnlì rùzhí le yì jiā zhīmíng kējì qǐyè dānrèn qiánduān gōngchéngshī.', 'Sau khi tốt nghiệp đại học, anh ấy nhờ vào kiến thức chuyên ngành kỹ thuật phần mềm máy tính sâu rộng đã thuận lợi gia nhập một công ty công nghệ có tiếng đảm nhiệm vị trí kỹ sư frontend.', 'basic', 1),
        (v_id, '深化高校学科专业结构综合改革，必须紧密对接国家重大科技战略与现代化产业体系建设的紧迫需求。', 'Shēnhuà gāoxiào xuékē zhuānyè jiégòu zōnghé gǎigé, bìxū jǐnmì duìjiē guójiā zhòngdà kējì zhànlüè yǔ xiàndàihuà chǎnyè tǐxì jiànshè de jǐnpò xūqiú.', 'Đi sâu cải cách tổng hợp cơ cấu chuyên ngành bộ môn tại các trường đại học bắt buộc phải kết nối chặt chẽ với nhu cầu cấp bách của các chiến lược khoa học công nghệ trọng đại quốc gia và xây dựng hệ thống ngành nghề hiện đại hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [转] (zhuǎn) - chuyển, quay, chuyển dịch [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '转' AND pinyin = 'zhuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '转'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhuǎn',
      meaning_vi = 'chuyển, quay, chuyển dịch',
      example_hanzi = '走出地铁站后沿着林荫大道往前直走两百米，再向右转就能看到宏伟的市图书馆了。',
      example_pinyin = 'Zǒuchū dìtiězhàn hòu yánzhe línyīn dàdào wǎng qián zhí zǒu liǎng bǎi mǐ, zài xiàng yòu zhuǎn jiù néng kànjiào hóngwěi de shì túshūguǎn le.',
      example_vi = 'Sau khi bước ra khỏi ga tàu điện ngầm men theo đại lộ rợp bóng cây đi thẳng hai trăm mét, sau đó rẽ sang phải là có thể nhìn thấy thư viện thành phố nguy nga rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '走出地铁站后沿着林荫大道往前直走两百米，再向右转就能看到宏伟的市图书馆了。', 'Zǒuchū dìtiězhàn hòu yánzhe línyīn dàdào wǎng qián zhí zǒu liǎng bǎi mǐ, zài xiàng yòu zhuǎn jiù néng kànjiào hóngwěi de shì túshūguǎn le.', 'Sau khi bước ra khỏi ga tàu điện ngầm men theo đại lộ rợp bóng cây đi thẳng hai trăm mét, sau đó rẽ sang phải là có thể nhìn thấy thư viện thành phố nguy nga rồi.', 'basic', 1),
        (v_id, '坚持稳中求进工作总基调，加快推动经济增长由要素驱动向创新驱动全面转变，筑牢高质量发展根基。', 'Jiānchí wěnzhōng-qiújìn gōngzuò zǒng jīdiào, jiākuài tuīdòng jīngjì zēngzhǎng yóu yàosù qūdòng xiàng chuàngxīn qūdòng quánmiàn zhuǎnbiàn, zhù láo gāo zhìliàng fāzhǎn gēnjī.', 'Kiên trì định hướng chung công tác giữ vững ổn định để cùng tiến bộ, đẩy nhanh thúc đẩy tăng trưởng kinh tế chuyển biến toàn diện từ dựa vào các yếu tố sang dựa vào đổi mới sáng tạo, củng cố vững chắc nền tảng phát triển chất lượng cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [转发] (zhuǎnfā) - chuyển tiếp, chia sẻ lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '转发' AND pinyin = 'zhuǎnfā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '转发'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhuǎnfā',
      meaning_vi = 'chuyển tiếp, chia sẻ lại',
      example_hanzi = '看到关于防范网络诈骗的安全提示科普文章，爸爸立即在家庭微信群里进行了转发提醒。',
      example_pinyin = 'Kàndào guānyú fángfàn wǎngluò zhàpiàn de ānquán tíshì kēpǔ wénzhāng, bàba lìjí zài jiātíng Wēixìn qún lǐ jìnxíng le zhuǎnfā tíxǐng.',
      example_vi = 'Thấy bài viết phổ biến khoa học nhắc nhở an toàn về việc phòng tránh lừa đảo qua mạng, bố lập tức chuyển tiếp vào nhóm chat WeChat gia đình để nhắc nhở.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '看到关于防范网络诈骗的安全提示科普文章，爸爸立即在家庭微信群里进行了转发提醒。', 'Kàndào guānyú fángfàn wǎngluò zhàpiàn de ānquán tíshì kēpǔ wénzhāng, bàba lìjí zài jiātíng Wēixìn qún lǐ jìnxíng le zhuǎnfā tíxǐng.', 'Thấy bài viết phổ biến khoa học nhắc nhở an toàn về việc phòng tránh lừa đảo qua mạng, bố lập tức chuyển tiếp vào nhóm chat WeChat gia đình để nhắc nhở.', 'basic', 1),
        (v_id, '官方主流媒体通过融合多端传播矩阵广泛转发国家重大科技成果纪实，全方位凝聚起全民族团结奋进的精神伟力。', 'Guānfāng zhǔliú méitǐ tōngguò rónghé duō duān chuánbō jùzhèn guǎngfàn zhuǎnfā guójiā zhòngdà kējì chéngguǒ jìshí, quán fāngwèi níngjù qǐ quán mínzú tuánjié fènjìn de jīngshén wěilì.', 'Các cơ quan truyền thông chính thống chính thức thông qua ma trận truyền thông đa nền tảng tích hợp đã chia sẻ rộng rãi phóng sự tư liệu về thành quả khoa học công nghệ trọng đại quốc gia, quy tụ toàn diện sức mạnh tinh thần vĩ đại đoàn kết phấn đấu của toàn dân tộc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [转机] (zhuǎnjī) - chuyển máy bay, quá cảnh; bước ngoặt [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '转机' AND pinyin = 'zhuǎnjī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '转机'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhuǎnjī',
      meaning_vi = 'chuyển máy bay, quá cảnh; bước ngoặt',
      example_hanzi = '这次飞往欧洲的国际航班需要在迪拜国际机场经停并转机，我们可以在候机楼逛逛免税店。',
      example_pinyin = 'Zhè cì fēi wǎng Ōuzhōu de guójì hángbān xūyào zài Díbài guójì jīchǎng jīngtíng bìng zhuǎnjī, wǒmen kěyǐ zài hòujīlóu guàngguang miǎnshuìdiàn.',
      example_vi = 'Chuyến bay quốc tế tới châu Âu lần này cần dừng chân và chuyển tiếp máy bay tại sân bay quốc tế Dubai, chúng ta có thể dạo quanh các cửa hàng miễn thuế tại nhà ga chờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这次飞往欧洲的国际航班需要在迪拜国际机场经停并转机，我们可以在候机楼逛逛免税店。', 'Zhè cì fēi wǎng Ōuzhōu de guójì hángbān xūyào zài Díbài guójì jīchǎng jīngtíng bìng zhuǎnjī, wǒmen kěyǐ zài hòujīlóu guàngguang miǎnshuìdiàn.', 'Chuyến bay quốc tế tới châu Âu lần này cần dừng chân và chuyển tiếp máy bay tại sân bay quốc tế Dubai, chúng ta có thể dạo quanh các cửa hàng miễn thuế tại nhà ga chờ.', 'basic', 1),
        (v_id, '随着全球多边贸易谈判迎来关键历史转机，各成员国代表一致同意加快重启陷入僵局的关税减让磋商进程。', 'Suízhe quánqiú duōbiān màoyì tánpàn yínglái guānjiàn lìshǐ zhuǎnjī, gè chéngyuánguó dàibiǎo yízhì tóngyì jiākuài chóngqǐ xiànrù jiāngjú de guānshuì jiǎnràng cuōshāng jìnchéng.', 'Cùng với việc đàm phán thương mại đa phương toàn cầu đón nhận bước ngoặt lịch sử then chốt, đại biểu các quốc gia thành viên nhất trí đồng ý đẩy nhanh tái khởi động tiến trình đàm phán cắt giảm thuế quan đang rơi vào bế tắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [赚] (zhuàn) - kiếm (tiền), kiếm được [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '赚' AND pinyin = 'zhuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhuàn',
      meaning_vi = 'kiếm (tiền), kiếm được',
      example_hanzi = '他利用寒暑假勤工俭学帮导师做科研课题，不仅赚到了自己的学费，还积累了丰富的实践经验。',
      example_pinyin = 'Tā lìyòng hán-shǔjià qíngōng-jiǎnxué bāng dǎoshī zuò kēyán kètí, bùjǐn zhuàndào le zìjǐ de xuéfèi, hái jīlěi le fēngfù de shíjiàn jīngyàn.',
      example_vi = 'Anh ấy tận dụng các kỳ nghỉ đông và hè vừa học vừa làm giúp người hướng dẫn làm đề tài nghiên cứu khoa học, không những kiếm được tiền học phí cho bản thân mà còn tích lũy được kinh nghiệm thực tiễn phong phú.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他利用寒暑假勤工俭学帮导师做科研课题，不仅赚到了自己的学费，还积累了丰富的实践经验。', 'Tā lìyòng hán-shǔjià qíngōng-jiǎnxué bāng dǎoshī zuò kēyán kètí, bùjǐn zhuàndào le zìjǐ de xuéfèi, hái jīlěi le fēngfù de shíjiàn jīngyàn.', 'Anh ấy tận dụng các kỳ nghỉ đông và hè vừa học vừa làm giúp người hướng dẫn làm đề tài nghiên cứu khoa học, không những kiếm được tiền học phí cho bản thân mà còn tích lũy được kinh nghiệm thực tiễn phong phú.', 'basic', 1),
        (v_id, '高新技术企业依靠自主核心技术创新与优质品牌赋能，在全球产业链高端环节赚取了丰厚的高附加值利润。', 'Gāoxīn jìshù qǐyè yīkào zìzhǔ héxīn jìshù chuàngxīn yǔ yōuzhì pǐnpái fùnéng, zài quánqiú chǎnyèliàn gāoduān huánjié zhuànqǔ le fēnghòu de gāo fùjiāzhí lìrùn.', 'Các doanh nghiệp công nghệ cao dựa vào đổi mới công nghệ cốt lõi tự chủ và trợ lực của thương hiệu chất lượng cao, đã thu về lợi nhuận giá trị gia tăng cao dồi dào tại các khâu cao cấp của chuỗi công nghiệp toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [装] (zhuāng) - chứa, đựng; lắp ráp, trang bị; giả vờ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '装' AND pinyin = 'zhuāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '装'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhuāng',
      meaning_vi = 'chứa, đựng; lắp ráp, trang bị; giả vờ',
      example_hanzi = '搬家前夕，全家人把书房里珍贵的藏书和字画分门别类整齐地装进了结实的纸箱里。',
      example_pinyin = 'Bānjiā qiánxī, quán jiā rén bǎ shūfáng lǐ zhēnguì de cángshū hé zìhuà fēnmén-biélèi zhěngqí de zhuāng jìn le jiēshi de zhǐxiāng lǐ.',
      example_vi = 'Trước thềm chuyển nhà, cả gia đình đã phân loại rành mạch và đóng gói ngay ngắn sách quý cùng tranh chữ trong phòng đọc vào những thùng carton chắc chắn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '搬家前夕，全家人把书房里珍贵的藏书和字画分门别类整齐地装进了结实的纸箱里。', 'Bānjiā qiánxī, quán jiā rén bǎ shūfáng lǐ zhēnguì de cángshū hé zìhuà fēnmén-biélèi zhěngqí de zhuāng jìn le jiēshi de zhǐxiāng lǐ.', 'Trước thềm chuyển nhà, cả gia đình đã phân loại rành mạch và đóng gói ngay ngắn sách quý cùng tranh chữ trong phòng đọc vào những thùng carton chắc chắn.', 'basic', 1),
        (v_id, '新型智能重型卡车全系标配高精度激光雷达与先进驾驶辅助系统，整车组装工艺已全面达到国际领先水平。', 'Xīnxíng zhìnéng zhòngxíng kǎchē quán xì biāopèi gāo jīngdù jīguāng léidá yǔ xiānjìn jiàshǐ fùzhù xìtǒng, zhěngchē zǔzhuāng gōngyì yǐ quánmiàn dádào guójì lǐngxiān shuǐpíng.', 'Dòng xe tải hạng nặng thông minh kiểu mới được trang bị tiêu chuẩn radar laser độ chính xác cao và hệ thống hỗ trợ lái xe tiên tiến, kỹ nghệ lắp ráp toàn bộ xe đã hoàn toàn đạt trình độ dẫn đầu quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [准] (zhǔn) - chuẩn, chính xác; chuẩn phép [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '准' AND pinyin = 'zhǔn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '准'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'zhǔn',
      meaning_vi = 'chuẩn, chính xác; chuẩn phép',
      example_hanzi = '爸爸看了一眼手腕上的石英手表，笑着对大家说：“这只手表走时非常准，一秒都不差。”',
      example_pinyin = 'Bàba kàn le yì yǎn shǒuwàn shang de shíyīng shǒubiǎo, xiàozhe duì dàjiā shuō: “Zhè zhī shǒubiǎo zǒushí fēicháng zhǔn, yì miǎo dōu bù chà.”',
      example_vi = 'Bố nhìn lướt qua chiếc đồng hồ thạch anh trên cổ tay, mỉm cười nói với mọi người: "Chiếc đồng hồ này chạy giờ vô cùng chuẩn, không sai lấy một giây".'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爸爸看了一眼手腕上的石英手表，笑着对大家说：“这只手表走时非常准，一秒都不差。”', 'Bàba kàn le yì yǎn shǒuwàn shang de shíyīng shǒubiǎo, xiàozhe duì dàjiā shuō: “Zhè zhī shǒubiǎo zǒushí fēicháng zhǔn, yì miǎo dōu bù chà.”', 'Bố nhìn lướt qua chiếc đồng hồ thạch anh trên cổ tay, mỉm cười nói với mọi người: "Chiếc đồng hồ này chạy giờ vô cùng chuẩn, không sai lấy một giây".', 'basic', 1),
        (v_id, '随着我国北斗三号全球卫星导航系统全面建成，高精度定位授时服务已达到亚米级乃至毫米级精准基准。', 'Suízhe wǒ guó Běidǒu Sānhào quánqiú wèixīng dǎoháng xìtǒng quánmiàn jiànchéng, gāo jīngdù dìngwèi shòushí fúwù yǐ dádào yàmǐ-jí nǎizhì háomǐ-jí jīngzhǔn jīzhǔn.', 'Cùng với việc hệ thống định vị vệ tinh toàn cầu Bắc Đẩu 3 của nước ta được hoàn thành toàn diện, dịch vụ định vị và cung cấp thời gian độ chính xác cao đã đạt chuẩn mực mốc chuẩn xác cấp dưới một mét thậm chí đến cấp milimet.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [准确] (zhǔnquè) - chính xác, chuẩn xác [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '准确' AND pinyin = 'zhǔnquè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '准确'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'zhǔnquè',
      meaning_vi = 'chính xác, chuẩn xác',
      example_hanzi = '经过反复校对，小李准确无误地填写好了所有的英文报名申请表格。',
      example_pinyin = 'Jīngguò fǎnfù jiàoduì, Xiǎo Lǐ zhǔnquè-wúwù de tiánxiě hǎo le suǒyǒu de Yīngwén bàomíng shēnqǐng biàogé.',
      example_vi = 'Trải qua việc đối chiếu lặp đi lặp lại, Tiểu Lý đã điền chính xác không một lỗi sai tất cả các biểu mẫu đơn đăng ký bằng tiếng Anh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过反复校对，小李准确无误地填写好了所有的英文报名申请表格。', 'Jīngguò fǎnfù jiàoduì, Xiǎo Lǐ zhǔnquè-wúwù de tiánxiě hǎo le suǒyǒu de Yīngwén bàomíng shēnqǐng biàogé.', 'Trải qua việc đối chiếu lặp đi lặp lại, Tiểu Lý đã điền chính xác không một lỗi sai tất cả các biểu mẫu đơn đăng ký bằng tiếng Anh.', 'basic', 1),
        (v_id, '现代气象卫星雷达监测网全面提升了对台风路径与突发极端暴雨灾害的准确预报与科学预警水平。', 'Xiàndài qìxiàng wèixīng léidá jiāncè wǎng quánmiàn tíshēng le duì táifēng lùjìng yǔ tūfā jíduān bàoyǔ zāihài de zhǔnquè yùbào yǔ kēxué yùjǐng shuǐpíng.', 'Mạng lưới giám sát radar vệ tinh khí tượng hiện đại đã nâng cao toàn diện trình độ dự báo chuẩn xác và cảnh báo khoa học đối với đường đi của bão và thiên tai mưa bão cực đoan bất ngờ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [准时] (zhǔnshí) - đúng giờ, chuẩn giờ [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '准时' AND pinyin = 'zhǔnshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '准时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'zhǔnshí',
      meaning_vi = 'đúng giờ, chuẩn giờ',
      example_hanzi = '高速动车组列车运行极其准时，每天都按时刻表分秒不差地准时发车与进站。',
      example_pinyin = 'Gāosù dòngchēzǔ lièchē yùnxíng jíqí zhǔnshí, měitiān dōu àn shíkèbiǎo fēnmiǎo-bùchà de zhǔnshí fāchē yǔ jìnzhàn.',
      example_vi = 'Đoàn tàu hỏa điện cao tốc vận hành vô cùng đúng giờ, mỗi ngày đều chạy và vào ga đúng giờ theo biểu đồ giờ tàu chạy không sai một phân một giây.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '高速动车组列车运行极其准时，每天都按时刻表分秒不差地准时发车与进站。', 'Gāosù dòngchēzǔ lièchē yùnxíng jíqí zhǔnshí, měitiān dōu àn shíkèbiǎo fēnmiǎo-bùchà de zhǔnshí fāchē yǔ jìnzhàn.', 'Đoàn tàu hỏa điện cao tốc vận hành vô cùng đúng giờ, mỗi ngày đều chạy và vào ga đúng giờ theo biểu đồ giờ tàu chạy không sai một phân một giây.', 'basic', 1),
        (v_id, '国际重大经贸外事磋商活动要求所有参会代表严格遵守外事礼仪并准时出席各项多边闭门会谈。', 'Guójì zhòngdà jīng-mào wàishì cuōshāng huódòng yāoqiú suǒyǒu cānhuì dàibiǎo yángé zūnshǒu wàishì lǐyí bìng zhǔnshí chūxí gè xiàng duōbiān bìmén huìtán.', 'Các hoạt động đàm phán đối ngoại kinh tế thương mại quốc tế trọng đại yêu cầu tất cả đại biểu tham dự phải nghiêm túc tuân thủ nghi thức ngoại giao và tham dự đúng giờ các cuộc hội đàm kín đa phương.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [资料] (zīliào) - tài liệu, tư liệu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '资料' AND pinyin = 'zīliào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '资料'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zīliào',
      meaning_vi = 'tài liệu, tư liệu',
      example_hanzi = '为了准备下周的学术报告，他在图书馆电子阅览室检索查阅了大量的珍贵历史文献资料。',
      example_pinyin = 'Wèile zhǔnbèi xià zhōu de xuéshù bàogào, tā zài túshūguǎn diànzǐ yuèlǎnshì jiǎnsuǒ cháyuè le dàliàng de zhēnguì lìshǐ wénxiàn zīliào.',
      example_vi = 'Để chuẩn bị cho bản báo cáo học thuật tuần tới, anh ấy đã tra cứu lượng lớn tư liệu tài liệu văn hiến lịch sử quý giá tại phòng đọc điện tử của thư viện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了准备下周的学术报告，他在图书馆电子阅览室检索查阅了大量的珍贵历史文献资料。', 'Wèile zhǔnbèi xià zhōu de xuéshù bàogào, tā zài túshūguǎn diànzǐ yuèlǎnshì jiǎnsuǒ cháyuè le dàliàng de zhēnguì lìshǐ wénxiàn zīliào.', 'Để chuẩn bị cho bản báo cáo học thuật tuần tới, anh ấy đã tra cứu lượng lớn tư liệu tài liệu văn hiến lịch sử quý giá tại phòng đọc điện tử của thư viện.', 'basic', 1),
        (v_id, '依托国家大数据综合试验区建设，各部门依法合规加速推动跨层级跨区域政务数据资料共享互认。', 'Yītuō guójiā dà shùjù zōnghé shìyànqū jiànshè, gè bùmén yīfǎ hégī jiāsù tuīdòng kuà céngjí kuà qūyù zhèngwù shùjù zīliào gòngxiǎng hùrèn.', 'Dựa vào việc xây dựng khu thí nghiệm tổng hợp dữ liệu lớn quốc gia, các ban ngành đẩy nhanh thúc đẩy việc chia sẻ và công nhận lẫn nhau các dữ liệu tài liệu chính vụ liên cấp và liên vùng theo đúng pháp luật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [仔细] (zǐxì) - tỉ mỉ, cẩn thận, kỹ lưỡng [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '仔细' AND pinyin = 'zǐxì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '仔细'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'zǐxì',
      meaning_vi = 'tỉ mỉ, cẩn thận, kỹ lưỡng',
      example_hanzi = '临交卷前的十分钟里，一定要静下心来仔细检查每一道数学题的计算过程与最终答案。',
      example_pinyin = 'Lín jiāojuàn qián de shí fēnzhōng lǐ, yídìng yào jìng xià xīn lái zǐxì jiǎnchá měi yí dào shùxué tí de jìsuàn guòchéng yǔ zuìzhōng dá’àn.',
      example_vi = 'Trong mười phút trước khi nộp bài, nhất định phải bình tâm lại cẩn thận kiểm tra quá trình tính toán và đáp án cuối cùng của từng bài toán.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '临交卷前的十分钟里，一定要静下心来仔细检查每一道数学题的计算过程与最终答案。', 'Lín jiāojuàn qián de shí fēnzhōng lǐ, yídìng yào jìng xià xīn lái zǐxì jiǎnchá měi yí dào shùxué tí de jìsuàn guòchéng yǔ zuìzhōng dá’àn.', 'Trong mười phút trước khi nộp bài, nhất định phải bình tâm lại cẩn thận kiểm tra quá trình tính toán và đáp án cuối cùng của từng bài toán.', 'basic', 1),
        (v_id, '评审专家组对国家重点科研基础设施建设方案进行了全面科学严谨与仔细深入的技术可行性论证。', 'Píngshěn zhuānjiāzǔ duì guójiā zhòngdiǎn kēyán jīchǔ shèshī jiànshè fāng’àn jìnxíng le quánmiàn kēxué yánjǐn yǔ zǐxì shēnrù de jìshù kěxíngxìng lùnzhèng.', 'Tổ chuyên gia thẩm định đã tiến hành chứng minh tính khả thi kỹ thuật tỉ mỉ sâu sắc, nghiêm cẩn khoa học và toàn diện đối với phương án xây dựng cơ sở hạ tầng nghiên cứu khoa học trọng điểm quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [自] (zì) - từ, tự, từ khi [Giới từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '自' AND pinyin = 'zì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '自'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ / Phó từ',
      pinyin = 'zì',
      meaning_vi = 'từ, tự, từ khi',
      example_hanzi = '自去年九月份入校以来，他在老师们的悉心教导下取得了令人瞩目的优异学业成绩。',
      example_pinyin = 'Zì qùnián jiǔ yuèfèn rù xiào yǐlái, tā zài lǎoshīmen de xīxīn jiàodǎo xià qǔdé le lìngrén-zhǔmù de yōuyì xuéyè chéngjì.',
      example_vi = 'Từ khi nhập học vào tháng chín năm ngoái đến nay, dưới sự dạy dỗ ân cần của các thầy cô, cậu ấy đã đạt được thành tích học tập xuất sắc khiến mọi người phải chú ý.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '自去年九月份入校以来，他在老师们的悉心教导下取得了令人瞩目的优异学业成绩。', 'Zì qùnián jiǔ yuèfèn rù xiào yǐlái, tā zài lǎoshīmen de xīxīn jiàodǎo xià qǔdé le lìngrén-zhǔmù de yōuyì xuéyè chéngjì.', 'Từ khi nhập học vào tháng chín năm ngoái đến nay, dưới sự dạy dỗ ân cần của các thầy cô, cậu ấy đã đạt được thành tích học tập xuất sắc khiến mọi người phải chú ý.', 'basic', 1),
        (v_id, '自国家实施区域协调发展战略以来，中西部地区基础设施条件显著改善，特色产业集聚效应日益凸显。', 'Zì guójiā shíshī qūyù xiétóng fāzhǎn zhànlüè yǐlái, zhōng-xībù dìqū jīchǔ shèshī tiáojiàn xiǎnzhù gǎishàn, tèsè chǎnyè jíjù xiàoyì rìyì tūxiǎn.', 'Kể từ khi nhà nước triển khai chiến lược phát triển phối hợp vùng đến nay, điều kiện cơ sở hạ tầng khu vực miền Trung và miền Tây đã được cải thiện rõ rệt, hiệu ứng tập tụ các ngành nghề thế mạnh đặc thù ngày một nổi bật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [自然] (zìrán) - tự nhiên, thiên nhiên; đương nhiên [Danh từ / Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '自然' AND pinyin = 'zìrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '自然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ / Phó từ',
      pinyin = 'zìrán',
      meaning_vi = 'tự nhiên, thiên nhiên; đương nhiên',
      example_hanzi = '假期里我们远离喧嚣的繁华都市，走进大自然去呼吸森林中清新的泥土与树木芬芳。',
      example_pinyin = 'Jiàqī lǐ wǒmen yuǎnlí xuānxiāo de fánhuā dūshì, zǒu jìn dàzìrán qù hūxī sēnlín zhōng qīngxīn de nítǔ yǔ shùmù fēnfāng.',
      example_vi = 'Trong kỳ nghỉ chúng tôi rời xa thành phố phồn hoa ồn ào náo nhiệt, bước vào thiên nhiên hít thở hương thơm trong lành của cây cối và bùn đất trong rừng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '假期里我们远离喧嚣的繁华都市，走进大自然去呼吸森林中清新的泥土与树木芬芳。', 'Jiàqī lǐ wǒmen yuǎnlí xuānxiāo de fánhuā dūshì, zǒu jìn dàzìrán qù hūxī sēnlín zhōng qīngxīn de nítǔ yǔ shùmù fēnfāng.', 'Trong kỳ nghỉ chúng tôi rời xa thành phố phồn hoa ồn ào náo nhiệt, bước vào thiên nhiên hít thở hương thơm trong lành của cây cối và bùn đất trong rừng.', 'basic', 1),
        (v_id, '牢固树立并践行尊重自然、顺应自然、保护自然的生态文明理念，坚定不移走人与自然和谐共生的中国式现代化道路。', 'Láogù shùlì bìng jiànxíng zūnzhòng zìrán, shùnyìng zìrán, bǎohù zìrán de shēngtài wénmíng lǐniàn, jiāndìng-bùyí zǒu rén yǔ zìrán héxié-gòngshēng de Zhōngguóshì xiàndàihuà dàolù.', 'Xác lập vững chắc và thực hành quan niệm văn minh sinh thái tôn trọng tự nhiên, thuận ứng tự nhiên, bảo vệ tự nhiên, kiên định không dời bước đi trên con đường hiện đại hóa kiểu Trung Quốc con người và thiên nhiên cùng chung sống hài hòa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [自习] (zìxí) - tự học, tự ôn tập [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '自习' AND pinyin = 'zìxí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '自习'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zìxí',
      meaning_vi = 'tự học, tự ôn tập',
      example_hanzi = '每天晚上七点到九点半是学校规定的晚自习时间，教室里极其安静，同学们都在专心做作业。',
      example_pinyin = 'Měitiān wǎnshang qī diǎn dào jiǔ diǎn bàn shì xuéxiào guīdìng de wǎnzìxí shíjiān, jiàoshì lǐ jíqí ānjìng, tóngxuémen dōu zài zhuānxīn zuò zuòyè.',
      example_vi = 'Mỗi tối từ bảy giờ đến chín giờ rưỡi là thời gian tự học buổi tối theo quy định của nhà trường, trong phòng học vô cùng yên tĩnh, các bạn học sinh đều đang tập trung làm bài tập.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天晚上七点到九点半是学校规定的晚自习时间，教室里极其安静，同学们都在专心做作业。', 'Měitiān wǎnshang qī diǎn dào jiǔ diǎn bàn shì xuéxiào guīdìng de wǎnzìxí shíjiān, jiàoshì lǐ jíqí ānjìng, tóngxuémen dōu zài zhuānxīn zuò zuòyè.', 'Mỗi tối từ bảy giờ đến chín giờ rưỡi là thời gian tự học buổi tối theo quy định của nhà trường, trong phòng học vô cùng yên tĩnh, các bạn học sinh đều đang tập trung làm bài tập.', 'basic', 1),
        (v_id, '现代高校图书馆通过建设多功能静音自习空间与沉浸式研讨舱，全方位满足学生自主研学与学术探索需求。', 'Xiàndài gāoxiào túshūguǎn tōngguò jiànshè duō gōngnéng jìngyīn zìxí kōngjiān yǔ chénjìnshì yántǎocāng, quán fāngwèi mǎnzú xuésheng zìzhǔ yánxué yǔ xuéshù tànsuǒ xūqiú.', 'Thư viện các trường đại học hiện đại thông qua việc xây dựng không gian tự học cách âm đa chức năng và khoang nghiên cứu thảo luận đắm chìm, đáp ứng toàn diện nhu cầu tự nghiên cứu học tập và tìm tòi học thuật của sinh viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [自信] (zìxìn) - tự tin, lòng tự tin [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '自信' AND pinyin = 'zìxìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '自信'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'zìxìn',
      meaning_vi = 'tự tin, lòng tự tin',
      example_hanzi = '只要你平时做好了充分的复习准备，走上考场时就一定会充满从容与自信。',
      example_pinyin = 'Zhǐyào nǐ píngshí zuòhǎo le chōngfèn de fùxí zhǔnbèi, zǒu shang kǎochǎng shí jiù yídìng huì chōngmǎn cóngróng yǔ zìxìn.',
      example_vi = 'Chỉ cần ngày thường bạn đã chuẩn bị ôn tập đầy đủ, bước vào phòng thi nhất định sẽ tràn đầy sự ung dung và tự tin.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '只要你平时做好了充分的复习准备，走上考场时就一定会充满从容与自信。', 'Zhǐyào nǐ píngshí zuòhǎo le chōngfèn de fùxí zhǔnbèi, zǒu shang kǎochǎng shí jiù yídìng huì chōngmǎn cóngróng yǔ zìxìn.', 'Chỉ cần ngày thường bạn đã chuẩn bị ôn tập đầy đủ, bước vào phòng thi nhất định sẽ tràn đầy sự ung dung và tự tin.', 'basic', 1),
        (v_id, '坚定文化自信是实现中华民族伟大复兴的强大精神支撑，必须传承弘扬中华优秀传统文化的精神内核。', 'Jiāndìng wénhuà zìxìn shì shíxiàn Zhōnghuá mínzú wěidà fùxīng de qiángdà jīngshén zhīchēng, bìxū chuánchéng hóngyáng Zhōnghuá yōuxiù chuántǒng wénhuà de jīngshén nèihé.', 'Kiên định tự tin văn hóa là điểm tựa tinh thần vững mạnh để thực hiện sự phục hưng vĩ đại của dân tộc Trung Hoa, bắt buộc phải kế thừa và phát huy hạt nhân tinh thần của văn hóa truyền thống ưu tú Trung Hoa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [自学] (zìxué) - tự học, tự mày mò học tập [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '自学' AND pinyin = 'zìxué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '自学'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zìxué',
      meaning_vi = 'tự học, tự mày mò học tập',
      example_hanzi = '他在课余时间通过网络精品公开课自学了多门实用的计算机编程语言与办公软件。',
      example_pinyin = 'Tā zài kèyú shíjiān tōngguò wǎngluò jīngpǐn gōngkāikè zìxué le duō mén shíyòng de jìsuànjī biānchéng yǔyán yǔ bàngōng ruǎnjiàn.',
      example_vi = 'Vào thời gian rảnh rỗi sau giờ học, anh ấy đã tự học nhiều ngôn ngữ lập trình máy tính thực dụng và phần mềm văn phòng thông qua các khóa học trực tuyến chất lượng cao.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在课余时间通过网络精品公开课自学了多门实用的计算机编程语言与办公软件。', 'Tā zài kèyú shíjiān tōngguò wǎngluò jīngpǐn gōngkāikè zìxué le duō mén shíyòng de jìsuànjī biānchéng yǔyán yǔ bàngōng ruǎnjiàn.', 'Vào thời gian rảnh rỗi sau giờ học, anh ấy đã tự học nhiều ngôn ngữ lập trình máy tính thực dụng và phần mềm văn phòng thông qua các khóa học trực tuyến chất lượng cao.', 'basic', 1),
        (v_id, '终身教育体系全面畅通自学考试与成人高等学历互认渠道，持续为广大学习型社会建设搭建成才立交桥。', 'Zhōngshēn jiàoyù tǐxì quánmiàn chàngtōng zìxué kǎoshì yǔ chéngrén gāoděng xuélì hùrèn qúdào, chíxù wèi guǎngdà xuéxíxíng shèhuì jiànshè dājiàn chéngcái lìjiāoqiáo.', 'Hệ thống giáo dục suốt đời khai thông toàn diện các kênh thi tự học và công nhận lẫn nhau văn bằng cao đẳng đại học dành cho người lớn, liên tục bắc nhịp cầu vượt thành tài cho công cuộc xây dựng xã hội học tập rộng lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [总结] (zǒngjié) - tổng kết, bản tổng kết [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '总结' AND pinyin = 'zǒngjié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '总结'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zǒngjié',
      meaning_vi = 'tổng kết, bản tổng kết',
      example_hanzi = '每次大考结束之后，老师都会指导大家认真总结解题得失，并及时把易错题整理在笔记本上。',
      example_pinyin = 'Měi cì dàkǎo jiéshù zhīhòu, lǎoshī dōu huì zhǐdǎo dàjiā rènzhēn zǒngjié jiětí dé-shī, bìng jíshí bǎ yìcuò tí zhěnglǐ zài bǐjìběn shang.',
      example_vi = 'Sau mỗi kỳ thi lớn kết thúc, thầy cô đều hướng dẫn mọi người chăm chỉ tổng kết những được mất trong giải đề, và kịp thời sắp xếp các câu hỏi dễ sai vào cuốn sổ tay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每次大考结束之后，老师都会指导大家认真总结解题得失，并及时把易错题整理在笔记本上。', 'Měi cì dàkǎo jiéshù zhīhòu, lǎoshī dōu huì zhǐdǎo dàjiā rènzhēn zǒngjié jiětí dé-shī, bìng jíshí bǎ yìcuò tí zhěnglǐ zài bǐjìběn shang.', 'Sau mỗi kỳ thi lớn kết thúc, thầy cô đều hướng dẫn mọi người chăm chỉ tổng kết những được mất trong giải đề, và kịp thời sắp xếp các câu hỏi dễ sai vào cuốn sổ tay.', 'basic', 1),
        (v_id, '认真总结党领导人民长期探索形成的宝贵历史经验，对于在新征程上开创党和国家事业发展新局面具有至关重要的指导意义。', 'Rènzhēn zǒngjié Dǎng lǐngdǎo rénmín chángqī tànsuǒ xíngchéng de bǎoguì lìshǐ jīngyàn, duìyú zài xīn zhēngchéng shang kāichuàng dǎng hé guójiā shìyè fāzhǎn xīn júmiàn jùyǒu zhìguān zhòngyào de zhǐdǎo yìyì.', 'Chăm chú tổng kết những kinh nghiệm lịch sử quý báu mà Đảng lãnh đạo nhân dân tìm tòi hình thành trong thời gian dài có ý nghĩa chỉ đạo vô cùng quan trọng đối với việc mở ra cục diện phát triển mới cho sự nghiệp của Đảng và đất nước trên chặng đường mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [租] (zū) - thuê, cho thuê [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '租' AND pinyin = 'zū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '租'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zū',
      meaning_vi = 'thuê, cho thuê',
      example_hanzi = '大学毕业刚参加工作时，他和大学同班同学在地铁站附近合租了一套两室一厅的温馨公寓。',
      example_pinyin = 'Dàxué bìyè gāng cānjiā gōngzuò shí, tā hé dàxué tóngbān tóngxué zài dìtiězhàn fùjìn hézū le yí tào liǎng shì yì tīng de wēnxīn gōngyù.',
      example_vi = 'Khi vừa tốt nghiệp đại học mới đi làm, anh ấy cùng người bạn học cùng lớp đại học đã thuê chung một căn hộ ấm cúng gồm hai phòng ngủ một phòng khách ở gần ga tàu điện ngầm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大学毕业刚参加工作时，他和大学同班同学在地铁站附近合租了一套两室一厅的温馨公寓。', 'Dàxué bìyè gāng cānjiā gōngzuò shí, tā hé dàxué tóngbān tóngxué zài dìtiězhàn fùjìn hézū le yí tào liǎng shì yì tīng de wēnxīn gōngyù.', 'Khi vừa tốt nghiệp đại học mới đi làm, anh ấy cùng người bạn học cùng lớp đại học đã thuê chung một căn hộ ấm cúng gồm hai phòng ngủ một phòng khách ở gần ga tàu điện ngầm.', 'basic', 1),
        (v_id, '地方政府加快完善保障性租赁住房供给体系，多渠道筹集小户型低租金房源，切实解决新市民与青年人阶段性住房困难。', 'Dìfāng zhèngfǔ jiākuài wánshàn bǎozhàngxìng zūlìn zhùfáng gōnggǐ tǐxì, duō qúdào chóují xiǎo hùxíng dī zūjīn fángyuán, qièshí jiějué xīn shìmín yǔ qīngnián rén jiēduànxìng zhùfáng kùnnan.', 'Chính quyền địa phương đẩy nhanh hoàn thiện hệ thống cung ứng nhà ở cho thuê mang tính bảo đảm, huy động nguồn nhà diện tích nhỏ giá thuê thấp qua nhiều kênh, giải quyết thiết thực khó khăn nhà ở mang tính giai đoạn của cư dân đô thị mới và thanh niên trẻ tuổi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [组] (zǔ) - tổ, nhóm, cụm; tổ chức [Danh từ / Lượng từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '组' AND pinyin = 'zǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '组'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ / Động từ',
      pinyin = 'zǔ',
      meaning_vi = 'tổ, nhóm, cụm; tổ chức',
      example_hanzi = '在科学实验课上，化学老师把全班同学分成四个小组，分别操作不同的酸碱中和实验。',
      example_pinyin = 'Zài kēxué shíyàn kè shang, huàxué lǎoshī bǎ quánbān tóngxué fēnchéng sì gè xiǎozǔ, fēnbié cāozuò bùtóng de suān-jiǎn zhōnghé shíyàn.',
      example_vi = 'Trong giờ thực nghiệm khoa học, giáo viên Hóa học chia cả lớp thành bốn nhóm nhỏ, lần lượt thao tác các thí nghiệm trung hòa axit - bazơ khác nhau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在科学实验课上，化学老师把全班同学分成四个小组，分别操作不同的酸碱中和实验。', 'Zài kēxué shíyàn kè shang, huàxué lǎoshī bǎ quánbān tóngxué fēnchéng sì gè xiǎozǔ, fēnbié cāozuò bùtóng de suān-jiǎn zhōnghé shíyàn.', 'Trong giờ thực nghiệm khoa học, giáo viên Hóa học chia cả lớp thành bốn nhóm nhỏ, lần lượt thao tác các thí nghiệm trung hòa axit - bazơ khác nhau.', 'basic', 1),
        (v_id, '国家科研攻关项目打破传统学科壁垒，跨部门组建联合专家技术攻关组开展多学科协同攻关。', 'Guójiā kēyán gōngguān xiàngmù dǎpò chuántǒng xuékē bìlěi, kuà-bùmén zǔjiàn liánhé zhuānjiā jìshù gōngguānzǔ kāizhǎn duō xuékē xiétóng gōngguān.', 'Dự án công phá nghiên cứu khoa học cấp quốc gia phá vỡ các rào cản bộ môn truyền thống, liên bộ ngành thành lập tổ công phá kỹ thuật chuyên gia liên hợp để triển khai phối hợp đồng bộ liên môn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [最终] (zuìzhōng) - cuối cùng, rốt cuộc [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '最终' AND pinyin = 'zuìzhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '最终'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phó từ',
      pinyin = 'zuìzhōng',
      meaning_vi = 'cuối cùng, rốt cuộc',
      example_hanzi = '经过全队队员长达两个小时的顽强拼搏与密切配合，我们学校足球队最终荣获了冠军奖杯。',
      example_pinyin = 'Jīngguò quánduì duìyuán cháng dá liǎng gè xiǎoshí de wánqiáng pīnbó yǔ mìqiè pèihé, wǒmen xuéxiào zúqiúduì zuìzhōng rónghuò le guànjūn jiǎngbēi.',
      example_vi = 'Trải qua sự nỗ lực kiên cường và phối hợp chặt chẽ suốt hai giờ đồng hồ của toàn thể thành viên đội bóng, đội bóng đá trường chúng tôi cuối cùng đã vinh dự giành được chiếc cúp vô địch.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全队队员长达两个小时的顽强拼搏与密切配合，我们学校足球队最终荣获了冠军奖杯。', 'Jīngguò quánduì duìyuán cháng dá liǎng gè xiǎoshí de wánqiáng pīnbó yǔ mìqiè pèihé, wǒmen xuéxiào zúqiúduì zuìzhōng rónghuò le guànjūn jiǎngbēi.', 'Trải qua sự nỗ lực kiên cường và phối hợp chặt chẽ suốt hai giờ đồng hồ của toàn thể thành viên đội bóng, đội bóng đá trường chúng tôi cuối cùng đã vinh dự giành được chiếc cúp vô địch.', 'basic', 1),
        (v_id, '任何重大公共政策的出台与调整，都必须经过深入调查研究、科学论证与广泛听取民意，最终服务于广大人民群众的根本福祉。', 'Rènhé zhòngdà gōnggòng zhèngcè de chūtái yǔ tiáozhěng, dōu bìxū jīngguò shēnrù diàochá yánjiū, kēxué lùnzhèng yǔ guǎngfàn tīngqǔ mínyì, zuìzhōng fúwù yú guǎngdà rénmín qúnzhòng de gēnběn fúzhǐ.', 'Mọi chính sách công lớn được ban hành và điều chỉnh đều bắt buộc phải trải qua điều tra nghiên cứu sâu sắc, chứng minh khoa học và lắng nghe rộng rãi ý nguyện của nhân dân, cuối cùng phục vụ cho phúc lợi căn bản của đông đảo quần chúng nhân dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [尊重] (zūnzhòng) - tôn trọng, kính trọng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '尊重' AND pinyin = 'zūnzhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '尊重'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zūnzhòng',
      meaning_vi = 'tôn trọng, kính trọng',
      example_hanzi = '在与他人交流探讨不同观点时，我们一定要学会认真倾听并充分尊重他人的独立思考。',
      example_pinyin = 'Zài yǔ tārén jiāoliú tàntǎo bùtóng guāndiǎn shí, wǒmen yídìng yào xuéhuì rènzhēn qīngtīng bìng chōngfèn zūnzhòng tārén de dúlì sīkǎo.',
      example_vi = 'Khi cùng người khác trao đổi tìm hiểu các quan điểm khác nhau, chúng ta nhất định phải học cách chăm chú lắng nghe và tôn trọng đầy đủ tư duy độc lập của người khác.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在与他人交流探讨不同观点时，我们一定要学会认真倾听并充分尊重他人的独立思考。', 'Zài yǔ tārén jiāoliú tàntǎo bùtóng guāndiǎn shí, wǒmen yídìng yào xuéhuì rènzhēn qīngtīng bìng chōngfèn zūnzhòng tārén de dúlì sīkǎo.', 'Khi cùng người khác trao đổi tìm hiểu các quan điểm khác nhau, chúng ta nhất định phải học cách chăm chú lắng nghe và tôn trọng đầy đủ tư duy độc lập của người khác.', 'basic', 1),
        (v_id, '国际社会各成员国应当严格遵守以联合国宪章宗旨和原则为基础的国际关系基本准则，相互尊重主权与领土完整。', 'Guójì shèhuì gè chéngyuánguó yīngdāng yángé zūnshǒu yǐ Liánhéguó Xiànzhāng zōngzhǐ hé yuánzé wéi jīchǔ de guójì guānxi jīběn zhǔnzé, xiānghù zūnzhòng zhǔquán yǔ lǐngtǔ wánzhěng.', 'Các quốc gia thành viên trong cộng đồng quốc tế cần nghiêm chỉnh tuân thủ các chuẩn tắc cơ bản của quan hệ quốc tế dựa trên tôn chỉ và nguyên tắc của Hiến chương Liên Hợp Quốc, tôn trọng lẫn nhau về chủ quyền và toàn vẹn lãnh thổ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [左右] (zuǒyòu) - khoảng chừng; chi phối; trái phải [Danh từ / Phương vị từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '左右' AND pinyin = 'zuǒyòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '左右'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phương vị từ / Động từ',
      pinyin = 'zuǒyòu',
      meaning_vi = 'khoảng chừng; chi phối; trái phải',
      example_hanzi = '我们学校距离市中心的现代化图书馆大约有三公里左右，骑共享单车十五分钟即可到达。',
      example_pinyin = 'Wǒmen de dàxué xiàoyuán jùlí shì zhōngxīn de xiàndàihuà túshūguǎn dàyuē yǒu sān gōnglǐ zuǒyòu, qí gòngxiǎng dānchē shíwǔ fēnzhōng jíkě dàodá.',
      example_vi = 'Trường học của chúng tôi cách thư viện hiện đại ở trung tâm thành phố ước chừng khoảng ba cây số, đạp xe đạp công cộng mười lăm phút là có thể tới nơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们学校距离市中心的现代化图书馆大约有三公里左右，骑共享单车十五分钟即可到达。', 'Wǒmen de dàxué xiàoyuán jùlí shì zhōngxīn de xiàndàihuà túshūguǎn dàyuē yǒu sān gōnglǐ zuǒyòu, qí gòngxiǎng dānchē shíwǔ fēnzhōng jíkě dàodá.', 'Trường học của chúng tôi cách thư viện hiện đại ở trung tâm thành phố ước chừng khoảng ba cây số, đạp xe đạp công cộng mười lăm phút là có thể tới nơi.', 'basic', 1),
        (v_id, '面对日趋复杂多变的国际地缘政治环境，我们要坚定不移走自己的路，决不受任何外部遏制施压干扰左右。', 'Miànduì rìqū fùzá duōbiàn de guójì dìyuán zhèngzhì huánjìng, wǒmen yào jiāndìng-bùyí zǒu zìjǐ de lù, jué bú shòu rènhé wàibù èzhì shīyā gānrǎo zuǒyòu.', 'Đối mặt với môi trường địa chính trị quốc tế ngày càng phức tạp khó lường, chúng ta cần kiên định không dời bước đi trên con đường của chính mình, quyết không chịu sự chi phối can thiệp chèn ép kiềm chế từ bất kỳ bên ngoài nào.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [座] (zuò) - tòa, ngọn (núi), cây (cầu); chỗ ngồi [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '座' AND pinyin = 'zuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '座'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'zuò',
      meaning_vi = 'tòa, ngọn (núi), cây (cầu); chỗ ngồi',
      example_hanzi = '穿过茂密的绿树林，眼前顿时出现了一座古色古香、飞檐翘角的传统木质凉亭。',
      example_pinyin = 'Chuānguò màomì de lǜshùlín, yǎnqián dùnshí chūxiàn le yí zuò gǔsè-gǔxiāng, fēiyán-qiàojiǎo de chuántǒng mùzhì liángtíng.',
      example_vi = 'Đi xuyên qua rừng cây xanh rậm rạp, trước mắt lập tức hiện ra một ngôi đình nghỉ mát bằng gỗ truyền thống mang nét cổ kính trầm mặc với mái hiên cong vút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '穿过茂密的绿树林，眼前顿时出现了一座古色古香、飞檐翘角的传统木质凉亭。', 'Chuānguò màomì de lǜshùlín, yǎnqián dùnshí chūxiàn le yí zuò gǔsè-gǔxiāng, fēiyán-qiàojiǎo de chuántǒng mùzhì liángtíng.', 'Đi xuyên qua rừng cây xanh rậm rạp, trước mắt lập tức hiện ra một ngôi đình nghỉ mát bằng gỗ truyền thống mang nét cổ kính trầm mặc với mái hiên cong vút.', 'basic', 1),
        (v_id, '这座跨越百里海湾的现代化跨海超长公铁两用特大桥梁，展示了我国在大型桥梁超级工程建设领域的雄厚实力。', 'Zhè zuò kuàyuè bǎi lǐ hǎiwān de xiàndàihuà kuàhǎi chāocháng gōng-tiě liǎngyòng tèdà qiáoliáng, zhǎnshì le wǒ guó zài dàxíng qiáoliáng chāojí gōngchéng jiànshè lǐngyù de xiónghòu shílì.', 'Cây cầu đặc biệt lớn dùng chung cho đường sắt và đường bộ vượt biển siêu dài hiện đại bắc qua vịnh biển trăm dặm này đã thể hiện sức mạnh to lớn của nước ta trong lĩnh vực xây dựng siêu công trình cầu lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [做法] (zuòfǎ) - cách làm, phương pháp làm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '做法' AND pinyin = 'zuòfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '做法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zuòfǎ',
      meaning_vi = 'cách làm, phương pháp làm',
      example_hanzi = '奶奶做红烧肉的传统烹饪做法十分讲究，先用冰糖炒出红亮糖色，再用文火慢炖入味。',
      example_pinyin = 'Nǎinai zuò hóngshāoròu de chuántǒng pēngrèn zuòfǎ shífēn jiǎngjiu, xiān yòng bīngtáng chǎo chū hóngliàng tángsè, zài yòng wénhuǒ màn dùn rùwèi.',
      example_vi = 'Cách làm nấu nướng truyền thống món thịt kho tàu của bà nội rất cầu kỳ, trước hết dùng đường phèn xào tạo màu nước hàng đỏ bóng, sau đó dùng lửa nhỏ ninh chậm cho ngấm đều gia vị.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '奶奶做红烧肉的传统烹饪做法十分讲究，先用冰糖炒出红亮糖色，再用文火慢炖入味。', 'Nǎinai zuò hóngshāoròu de chuántǒng pēngrèn zuòfǎ shífēn jiǎngjiu, xiān yòng bīngtáng chǎo chū hóngliàng tángsè, zài yòng wénhuǒ màn dùn rùwèi.', 'Cách làm nấu nướng truyền thống món thịt kho tàu của bà nội rất cầu kỳ, trước hết dùng đường phèn xào tạo màu nước hàng đỏ bóng, sau đó dùng lửa nhỏ ninh chậm cho ngấm đều gia vị.', 'basic', 1),
        (v_id, '地方各级政府要及时总结推广基层在优化营商环境、深化政务数字化改革中探索出的成功先进做法与典型经验。', 'Dìfāng gè jí zhèngfǔ yào jíshí zǒngjié tuīguǎng jīcéng zài yōuhuà yíngshāng huánjìng, shēnhuà zhèngwù shùzìhuà gǎigé zhōng tànsuǒ chū de chénggōng xiānjìn zuòfǎ yǔ diǎnxíng jīngyàn.', 'Chính quyền các cấp ở địa phương cần kịp thời tổng kết nhân rộng những cách làm tiên tiến thành công và kinh nghiệm điển hình mà cơ sở tìm tòi ra được trong việc tối ưu hóa môi trường kinh doanh và đi sâu cải cách số hóa chính vụ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [作家] (zuòjiā) - nhà văn, tác gia [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '作家' AND pinyin = 'zuòjiā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作家'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zuòjiā',
      meaning_vi = 'nhà văn, tác gia',
      example_hanzi = '这位当代知名儿童文学作家擅长用童趣盎然的笔触，为全国少年儿童创作了许多优秀的童话故事。',
      example_pinyin = 'Zhè wèi dāngdài zhīmíng értóng wénxué zuòjiā shàncháng yòng tóngqù-àngrán de bǐchù, wèi quánguó shàonián értóng chuàngzuò le xǔduō yōuxiù de tónghuà gùshi.',
      example_vi = 'Nhà văn văn học thiếu nhi đương đại nổi tiếng này có sở trường dùng ngòi bút đượm vẻ hồn nhiên trẻ thơ sáng tác nên nhiều câu chuyện cổ tích xuất sắc cho thiếu niên nhi đồng cả nước.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这位当代知名儿童文学作家擅长用童趣盎然的笔触，为全国少年儿童创作了许多优秀的童话故事。', 'Zhè wèi dāngdài zhīmíng értóng wénxué zuòjiā shàncháng yòng tóngqù-àngrán de bǐchù, wèi quánguó shàonián értóng chuàngzuò le xǔduō yōuxiù de tónghuà gùshi.', 'Nhà văn văn học thiếu nhi đương đại nổi tiếng này có sở trường dùng ngòi bút đượm vẻ hồn nhiên trẻ thơ sáng tác nên nhiều câu chuyện cổ tích xuất sắc cho thiếu niên nhi đồng cả nước.', 'basic', 1),
        (v_id, '广大文艺工作者与青年作家要自觉扎根人民群众生产生活火热实践，努力创作出无愧于伟大时代的精品力作。', 'Guǎngdà wényì gōngzuòzhě yǔ qīngnián zuòjiā yào zìjué zhāgēn rénmín qúnzhòng shēngchǎn shēnghuó huǒrè shíjiàn, nǔlì chuàngzuò chū wúkuì yú wěidà shídài de jīngpǐn lìzuò.', 'Đông đảo đội ngũ người làm văn học nghệ thuật và các nhà văn trẻ cần tự giác bám rễ sâu vào thực tiễn sản xuất sinh hoạt sôi động của quần chúng nhân dân, nỗ lực sáng tác nên những tác phẩm tinh hoa xứng đáng với thời đại vĩ đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [做梦] (zuòmèng) - nằm mơ, mơ màng; mơ mộng hão huyền [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '做梦' AND pinyin = 'zuòmèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '做梦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zuòmèng',
      meaning_vi = 'nằm mơ, mơ màng; mơ mộng hão huyền',
      example_hanzi = '弟弟昨晚做梦梦见自己变成了一只在辽阔太空中自由翱翔的小雄鹰，醒来后开心地跟全家人分享。',
      example_pinyin = 'Dìdi zuówǎn zuòmèng mèngjiàn zìjǐ biàn chéng le yì zhī zài liáokuò tàikōng zhōng zìyóu áoxiáng de xiǎo xióngyīng, xǐng lái hòu kāixīn de gēn quán jiā rén fēnxiǎng.',
      example_vi = 'Tối qua em trai nằm mơ thấy mình biến thành một chú đại bàng nhỏ tự do bay lượn trên bầu trời bao la, sau khi thức giấc đã vui vẻ chia sẻ cùng cả nhà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '弟弟昨晚做梦梦见自己变成了一只在辽阔太空中自由翱翔的小雄鹰，醒来后开心地跟全家人分享。', 'Dìdi zuówǎn zuòmèng mèngjiàn zìjǐ biàn chéng le yì zhī zài liáokuò tàikōng zhōng zìyóu áoxiáng de xiǎo xióngyīng, xǐng lái hòu kāixīn de gēn quán jiā rén fēnxiǎng.', 'Tối qua em trai nằm mơ thấy mình biến thành một chú đại bàng nhỏ tự do bay lượn trên bầu trời bao la, sau khi thức giấc đã vui vẻ chia sẻ cùng cả nhà.', 'basic', 1),
        (v_id, '那些企图通过外部单边制裁与极限施压阻滞中国繁荣发展历史进程的图谋，纯属痴心做梦、绝不可能得逞。', 'Nàxiē qǐtú tōngguò wàibù dānbiān zhìcái yǔ jíxiàn shīyā zǔzhì Zhōngguó fánróng fāzhǎn lìshǐ jìnchéng de túmóu, chúnshǔ chīxīn-zuòmèng, jué bù kěnéng déchěng.', 'Những mưu toan hòng thông qua trừng phạt đơn phương bên ngoài và gây sức ép tột cùng để ngăn chặn tiến trình lịch sử phát triển phồn vinh của Trung Quốc hoàn toàn chỉ là giấc mộng hão huyền, tuyệt đối không thể nào đạt được.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [作品] (zuòpǐn) - tác phẩm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '作品' AND pinyin = 'zuòpǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zuòpǐn',
      meaning_vi = 'tác phẩm',
      example_hanzi = '美术馆本周展出了一批来自全国各大美术学院青年艺术家的优秀油画与雕塑新作品。',
      example_pinyin = 'Měishùguǎn běn zhōu zhǎnchū le yì pī láizì quánguó gè dà měishù xuéyuàn qīngnián yìshùjiā de yōuxiù yóuhuà yǔ diāosù xīn zuòpǐn.',
      example_vi = 'Bảo tàng mỹ thuật tuần này trưng bày một loạt các tác phẩm mới tranh sơn dầu và điêu khắc xuất sắc của các nghệ sĩ trẻ đến từ các học viện mỹ thuật lớn trên toàn quốc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '美术馆本周展出了一批来自全国各大美术学院青年艺术家的优秀油画与雕塑新作品。', 'Měishùguǎn běn zhōu zhǎnchū le yì pī láizì quánguó gè dà měishù xuéyuàn qīngnián yìshùjiā de yōuxiù yóuhuà yǔ diāosù xīn zuòpǐn.', 'Bảo tàng mỹ thuật tuần này trưng bày một loạt các tác phẩm mới tranh sơn dầu và điêu khắc xuất sắc của các nghệ sĩ trẻ đến từ các học viện mỹ thuật lớn trên toàn quốc.', 'basic', 1),
        (v_id, '衡量一部优秀文艺作品的最高标准是看其精神高度、文化内涵与艺术价值，绝不能沦为单纯迎合低俗感官的商业附庸。', 'Héngliáng yí bù yōuxiù wényì zuòpǐn de zuìgāo biāozhǔn shì kàn qí jīngshén gāodù, wénhuà nèihán yǔ yìshù jiàzhí, jué bù néng lúnwéi dānchún yínghé dīsú gǎnguān de shāngyè fùyōng.', 'Tiêu chuẩn cao nhất để đo lường một tác phẩm văn học nghệ thuật xuất sắc là xem tầm cao tinh thần, hàm lượng văn hóa và giá trị nghệ thuật của nó, tuyệt đối không được biến thành phụ dung thương mại đơn thuần xu nịnh các giác quan thô tục.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [作为] (zuòwéi) - với tư cách là, làm; hành vi, việc làm [Giới từ / Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '作为' AND pinyin = 'zuòwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作为'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ / Động từ / Danh từ',
      pinyin = 'zuòwéi',
      meaning_vi = 'với tư cách là, làm; hành vi, việc làm',
      example_hanzi = '作为一名当代大学生，我们应当把个人的青春奋斗主动融入到建设祖国的宏伟事业之中。',
      example_pinyin = 'Zuòwéi yì míng dāngdài dàxuésheng, wǒmen yīngdāng bǎ gèrén de qīngchūn fèndòu zhǔdòng róngrù dào jiànshè zǔguó de hóngwěi shìyè zhī zhōng.',
      example_vi = 'Với tư cách là một sinh viên đại học đương đại, chúng ta nên chủ động hòa nhập sự phấn đấu của tuổi trẻ cá nhân vào sự nghiệp xây dựng tổ quốc vĩ đại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '作为一名当代大学生，我们应当把个人的青春奋斗主动融入到建设祖国的宏伟事业之中。', 'Zuòwéi yì míng dāngdài dàxuésheng, wǒmen yīngdāng bǎ gèrén de qīngchūn fèndòu zhǔdòng róngrù dào jiànshè zǔguó de hóngwěi shìyè zhī zhōng.', 'Với tư cách là một sinh viên đại học đương đại, chúng ta nên chủ động hòa nhập sự phấn đấu của tuổi trẻ cá nhân vào sự nghiệp xây dựng tổ quốc vĩ đại.', 'basic', 1),
        (v_id, '中国作为联合国安理会常任理事国和负责任的发展中大国，始终是世界和平的建设者与全球发展的贡献者。', 'Zhōngguó zuòwéi Liánhéguó Ānlǐhuì chángrèn lǐshìguó hé fùzérèn de fāzhǎnzhōng dàguó, shǐzhōng shì shìjiè hépíng de jiànshèzhě yǔ quánqiú fāzhǎn de gòngxiànzhě.', 'Trung Quốc với tư cách là Ủy viên thường trực Hội đồng Bảo an Liên Hợp Quốc và là nước đang phát triển lớn có trách nhiệm, luôn là người xây dựng nền hòa bình thế giới và là người đóng góp cho sự phát triển toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [座位] (zuòwèi) - chỗ ngồi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '座位' AND pinyin = 'zuòwèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '座位'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zuòwèi',
      meaning_vi = 'chỗ ngồi',
      example_hanzi = '在拥挤的地铁列车和公交车上，青年人应当主动给有需要的孕妇、老年人和抱婴儿的乘客让出座位。',
      example_pinyin = 'Zài yōngjǐ de dìtiě lièchē hé gōngjiāochē shang, qīngnián rén yīngdāng zhǔdòng gěi yǒu xūyào de yùnfù, lǎonián rén hé bào yīng’ér de chéngkè ràng chū zuòwèi.',
      example_vi = 'Trên các chuyến tàu điện ngầm và xe buýt đông đúc, thanh niên trẻ tuổi nên chủ động nhường chỗ ngồi cho phụ nữ mang thai, người cao tuổi và hành khách bế em bé khi họ cần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在拥挤的地铁列车和公交车上，青年人应当主动给有需要的孕妇、老年人和抱婴儿的乘客让出座位。', 'Zài yōngjǐ de dìtiě lièchē hé gōngjiāochē shang, qīngnián rén yīngdāng zhǔdòng gěi yǒu xūyào de yùnfù, lǎonián rén hé bào yīng’ér de chéngkè ràng chū zuòwèi.', 'Trên các chuyến tàu điện ngầm và xe buýt đông đúc, thanh niên trẻ tuổi nên chủ động nhường chỗ ngồi cho phụ nữ mang thai, người cao tuổi và hành khách bế em bé khi họ cần.', 'basic', 1),
        (v_id, '高速铁路系统全面推广应用无接触式电子客票与智能选座服务，大幅提升了广大旅客购票乘车的舒适体验。', 'Gāosù tiělù xìtǒng quánmiàn tuīguǎng yìngyòng wú jiēchùshì diànzǐ kèpiào yǔ zhìnéng xuǎnzùo fúwù, dàfú tíshēng le guǎngdà lǚkè gòupiào chéngchē de shūshì tǐyàn.', 'Hệ thống đường sắt cao tốc triển khai áp dụng rộng rãi vé hành khách điện tử không tiếp xúc và dịch vụ tự chọn chỗ ngồi thông minh, nâng cao rất lớn trải nghiệm thoải mái khi mua vé đi tàu của đông đảo hành khách.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [作文] (zuòwén) - bài văn, viết văn [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '作文' AND pinyin = 'zuòwén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作文'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'zuòwén',
      meaning_vi = 'bài văn, viết văn',
      example_hanzi = '语文老师经常叮嘱我们平时要多留心观察身边的日常生活细节，这样写出来的作文才会生动感人。',
      example_pinyin = 'Yǔwén lǎoshī jīngcháng dīngzhǔ wǒmen píngshí yào duō liúxīn guānchá shēnbiān de rìcháng shēnghuó xìjié, zhèyàng xiě chūlái de zuòwén cái huì shēngdòng gǎnrén.',
      example_vi = 'Thầy giáo dạy Ngữ văn thường dặn dò chúng tôi ngày thường phải chú ý quan sát nhiều hơn các chi tiết sinh hoạt hằng ngày xung quanh, như vậy bài văn viết ra mới sinh động và cảm động.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '语文老师经常叮嘱我们平时要多留心观察身边的日常生活细节，这样写出来的作文才会生动感人。', 'Yǔwén lǎoshī jīngcháng dīngzhǔ wǒmen píngshí yào duō liúxīn guānchá shēnbiān de rìcháng shēnghuó xìjié, zhèyàng xiě chūlái de zuòwén cái huì shēngdòng gǎnrén.', 'Thầy giáo dạy Ngữ văn thường dặn dò chúng tôi ngày thường phải chú ý quan sát nhiều hơn các chi tiết sinh hoạt hằng ngày xung quanh, như vậy bài văn viết ra mới sinh động và cảm động.', 'basic', 1),
        (v_id, '基础语文教育课程改革倡导把命题作文与社会实践调查紧密结合，全面培养中小学生的批判性逻辑思维与文字表达素养。', 'Jīchǔ yǔwén jiàoyù kèchéng gǎigé chàngdǎo bǎ mìngtí zuòwén yǔ shèhuì shíjiàn diàochá jǐnmì jiéhé, quánmiàn péiyǎng zhōng-xiǎoxuéshēng de pīpànxìng luójí sīwéi yǔ wénzì biǎodá sùyǎng.', 'Cải cách chương trình giáo dục ngữ văn cơ sở khởi xướng việc gắn kết chặt chẽ bài tập làm văn theo đề tài với khảo sát thực tiễn xã hội, bồi dưỡng toàn diện tư duy logic phản biện và tố chất diễn đạt câu chữ của học sinh tiểu học và trung học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [作用] (zuòyòng) - tác dụng, vai trò; ảnh hưởng [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '作用' AND pinyin = 'zuòyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'zuòyòng',
      meaning_vi = 'tác dụng, vai trò; ảnh hưởng',
      example_hanzi = '坚持每天清晨早起进行半小时有氧户外运动，对增强人体免疫力与改善睡眠质量具有十分明显的积极作用。',
      example_pinyin = 'Jiānchí měitiān qīngchén zǎoqǐ jìnxíng bàn xiǎoshí yǒuyǎng hùwài yùndòng, duì zēngqiáng réntǐ miǎnyìlì yǔ gǎishàn shuìmián zhìliàng jùyǒu shífēn míngxiǎn de jījí zuòyòng.',
      example_vi = 'Kiên trì mỗi sáng sớm dậy sớm vận động ngoài trời có oxy nửa tiếng có tác dụng tích cực vô cùng rõ rệt đối với việc tăng cường khả năng miễn dịch của cơ thể và cải thiện chất lượng giấc ngủ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '坚持每天清晨早起进行半小时有氧户外运动，对增强人体免疫力与改善睡眠质量具有十分明显的积极作用。', 'Jiānchí měitiān qīngchén zǎoqǐ jìnxíng bàn xiǎoshí yǒuyǎng hùwài yùndòng, duì zēngqiáng réntǐ miǎnyìlì yǔ gǎishàn shuìmián zhìliàng jùyǒu shífēn míngxiǎn de jījí zuòyòng.', 'Kiên trì mỗi sáng sớm dậy sớm vận động ngoài trời có oxy nửa tiếng có tác dụng tích cực vô cùng rõ rệt đối với việc tăng cường khả năng miễn dịch của cơ thể và cải thiện chất lượng giấc ngủ.', 'basic', 1),
        (v_id, '充分发挥我国超大规模市场优势与内需潜力，对畅通国内大循环并带动国际双循环发挥着不可替代的重要压舱石作用。', 'Chōngfèn fāhuī wǒ guó chāo dà guīmó shìchǎng yōushì yǔ nèixū qiánlì, duì chàngtōng guónèi dà xúnhuán bìng dàidòng guójì shuāng xúnhuán fāhuī zhe bùkě tìdài de zhòngyào yācāngshí zuòyòng.', 'Phát huy đầy đủ ưu thế thị trường quy mô siêu lớn và tiềm năng nội cầu của nước ta đóng vai trò hòn đá tảng dằn tàu quan trọng không thể thay thế đối với việc khơi thông đại tuần hoàn trong nước và dẫn dắt tuần hoàn kép quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [作者] (zuòzhě) - tác giả [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '作者' AND pinyin = 'zuòzhě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作者'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zuòzhě',
      meaning_vi = 'tác giả',
      example_hanzi = '在新书首发读者见面会上，深受读者喜爱的青年小说作者热情地为每一位热心读者签名并合影留念。',
      example_pinyin = 'Zài xīnshū shǒufā dúzhě jiànmiànhuì shang, shēn shòu dúzhě xǐ’ài de qīngnián xiǎoshuō zuòzhě rèqíng de wèi měi yí wèi rèxīn dúzhě qiānmíng bìng héyǐng liúniàn.',
      example_vi = 'Tại buổi giao lưu gặp gỡ bạn đọc ra mắt sách mới, tác giả tiểu thuyết trẻ được đông đảo độc giả yêu mến đã nhiệt tình ký tặng và chụp ảnh lưu niệm cùng từng người bạn đọc tâm huyết.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在新书首发读者见面会上，深受读者喜爱的青年小说作者热情地为每一位热心读者签名并合影留念。', 'Zài xīnshū shǒufā dúzhě jiànmiànhuì shang, shēn shòu dúzhě xǐ’ài de qīngnián xiǎoshuō zuòzhě rèqíng de wèi měi yí wèi rèxīn dúzhě qiānmíng bìng héyǐng liúniàn.', 'Tại buổi giao lưu gặp gỡ bạn đọc ra mắt sách mới, tác giả tiểu thuyết trẻ được đông đảo độc giả yêu mến đã nhiệt tình ký tặng và chụp ảnh lưu niệm cùng từng người bạn đọc tâm huyết.', 'basic', 1),
        (v_id, '司法行政机关深入实施著作权法，加大对学术论文与数字文艺作品作者合法署名权与版权收益的司法保护力度。', 'Sīfǎ xíngzhèng jīgòu shēnrù shíshī zhùzuòquánfǎ, jiàdà duì xuéshù lùnwén yǔ shùzì wényì zuòpǐn zuòzhě héfǎ shǔmíngquán yǔ bǎnyuán shòuyì de sīfǎ bǎohù lìdù.', 'Các cơ quan tư pháp và hành chính thực thi sâu rộng Luật Bản quyền, tăng cường mức độ bảo hộ tư pháp đối với quyền đứng tên hợp pháp và lợi ích bản quyền của các tác giả luận văn học thuật và tác phẩm văn học nghệ thuật số.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 10: #1901 -> #2000 - HOÀN TẤT 100%% HSK 4)!', v_count;
END $$;
