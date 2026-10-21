-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 15 (100 TỪ TIẾP THEO)
-- Phạm vi: #3402 [由此] (yóu cǐ) -> #3501 [直] (zhí)
-- Tổng số câu ví dụ: 200 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Chuẩn hóa cột word_type (Từ loại) và meaning_vi (Nghĩa TV)
--   - Bảo tồn 100% UUID hiện có của từ vựng nếu đã tồn tại
--   - Chuyển cấp độ hsk_level = 'HSK 5' nếu từ đang ở cấp khác (HSK 6)
--   - Tự động thêm mới từ vựng nếu chưa có trong DB
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ các cột tương thích ngược example_hanzi, example_pinyin, example_vi
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
  -- [3402] [由此] (yóu cǐ) - do đó, từ đó, từ điều này [Cụm từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '由此' AND pinyin = 'yóu cǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '由此' AND pinyin = 'yóu cǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '由此'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '由此'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Cụm từ / Phó từ',
      pinyin = 'yóu cǐ',
      meaning_vi = 'do đó, từ đó, từ điều này',
      example_hanzi = '他在大学期间刻苦钻研算法并多次在国际竞赛中获奖，由此积累了扎实的专业技术功底。',
      example_pinyin = 'Tā zài dàxué qījiān kèkǔ zuānyán suànfǎ bìng duō cì zài guójì jìngsài zhōng huòjiǎng, yóucǐ jīlěi le zhāshi de zhuānyè jìshù gōngdǐ.',
      example_vi = 'Trong thời gian học đại học anh ấy đã khổ công nghiên cứu thuật toán và nhiều lần đoạt giải trong các cuộc thi quốc tế, từ đó tích lũy được nền tảng kỹ thuật chuyên môn vững chắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '由此',
      'yóu cǐ',
      'do đó, từ đó, từ điều này',
      'Cụm từ / Phó từ',
      'HSK 5',
      '他在大学期间刻苦钻研算法并多次在国际竞赛中获奖，由此积累了扎实的专业技术功底。',
      'Tā zài dàxué qījiān kèkǔ zuānyán suànfǎ bìng duō cì zài guójì jìngsài zhōng huòjiǎng, yóucǐ jīlěi le zhāshi de zhuānyè jìshù gōngdǐ.',
      'Trong thời gian học đại học anh ấy đã khổ công nghiên cứu thuật toán và nhiều lần đoạt giải trong các cuộc thi quốc tế, từ đó tích lũy được nền tảng kỹ thuật chuyên môn vững chắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在大学期间刻苦钻研算法并多次在国际竞赛中获奖，由此积累了扎实的专业技术功底。', 'Tā zài dàxué qījiān kèkǔ zuānyán suànfǎ bìng duō cì zài guójì jìngsài zhōng huòjiǎng, yóucǐ jīlěi le zhāshi de zhuānyè jìshù gōngdǐ.', 'Trong thời gian học đại học anh ấy đã khổ công nghiên cứu thuật toán và nhiều lần đoạt giải trong các cuộc thi quốc tế, từ đó tích lũy được nền tảng kỹ thuật chuyên môn vững chắc.', 'basic', 1),
      (v_id, '高精度数控机床关键核心主轴与轴承制造工艺取得了根本性突破，由此带动了高端装备制造全产业链的提质升级。', 'Gāojīngdù shùkòng jīchuáng guānjiàn héxīn zhǔzhóu yǔ zhóuchéng zhìzào gōngyì qǔdé le gēnběnxìng tūpò, yóucǐ dàidòng le gāoduān zhuāngbèi zhìzào quán-chǎnyèliàn de tízhì shēngjí.', 'Quy trình chế tạo trục chính và vòng bi then chốt cốt lõi của máy công cụ CNC độ chính xác cao đã đạt được bước đột phá mang tính căn bản, do đó thúc đẩy sự nâng cấp nâng cao chất lượng toàn bộ chuỗi công nghiệp chế tạo thiết bị cao cấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3403] [邮寄] (yóujì) - gửi qua bưu điện, gửi bưu phẩm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '邮寄' AND pinyin = 'yóujì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '邮寄' AND pinyin = 'yóujì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '邮寄'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '邮寄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yóujì',
      meaning_vi = 'gửi qua bưu điện, gửi bưu phẩm',
      example_hanzi = '请您将签署好的纸质商业合同原件妥善装入特快专递信封，并在今天下午下班前通过邮局邮寄出去。',
      example_pinyin = 'Qǐng nín jiāng qiānshǔ hǎo de zhǐzhì shāngyè hétong yuánjiàn tuǒshàn zhuāng rù tèkuài-zhuāndì xìnfēng, bìng zài jīntiān xiàwǔ xiàbān qián tōngguò yóujú yóujì chūqù.',
      example_vi = 'Xin quý vị hãy bỏ bản gốc hợp đồng thương mại dạng giấy đã ký vào phong bì chuyển phát nhanh cẩn thận và gửi qua đường bưu điện trước giờ tan làm chiều nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '邮寄',
      'yóujì',
      'gửi qua bưu điện, gửi bưu phẩm',
      'Động từ',
      'HSK 5',
      '请您将签署好的纸质商业合同原件妥善装入特快专递信封，并在今天下午下班前通过邮局邮寄出去。',
      'Qǐng nín jiāng qiānshǔ hǎo de zhǐzhì shāngyè hétong yuánjiàn tuǒshàn zhuāng rù tèkuài-zhuāndì xìnfēng, bìng zài jīntiān xiàwǔ xiàbān qián tōngguò yóujú yóujì chūqù.',
      'Xin quý vị hãy bỏ bản gốc hợp đồng thương mại dạng giấy đã ký vào phong bì chuyển phát nhanh cẩn thận và gửi qua đường bưu điện trước giờ tan làm chiều nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请您将签署好的纸质商业合同原件妥善装入特快专递信封，并在今天下午下班前通过邮局邮寄出去。', 'Qǐng nín jiāng qiānshǔ hǎo de zhǐzhì shāngyè hétong yuánjiàn tuǒshàn zhuāng rù tèkuài-zhuāndì xìnfēng, bìng zài jīntiān xiàwǔ xiàbān qián tōngguò yóujú yóujì chūqù.', 'Xin quý vị hãy bỏ bản gốc hợp đồng thương mại dạng giấy đã ký vào phong bì chuyển phát nhanh cẩn thận và gửi qua đường bưu điện trước giờ tan làm chiều nay.', 'basic', 1),
      (v_id, '涉外知识产权司法仲裁法庭严格规范法律文书与关键原始物证的跨国公证邮寄送达流程，确保送达行为具有无可辩驳的法定公信力。', 'Shèwài zhīshi chǎnquán sīfǎ zhòngcái fǎtíng yángé guīfàn fǎlǜ wénshū yǔ guānjiàn yuánshǐ wùzhèng de kuàguó gōngzhèng yóujì sòngdá liúchéng, quèbǎo sòngdá xíngwéi jùyǒu wúkě-biànbó de fǎdìng gōngxìnlì.', 'Tòa án trọng tài tư pháp sở hữu trí tuệ đối ngoại quy chuẩn nghiêm ngặt quy trình gửi chuyển bưu điện có công chứng xuyên quốc gia đối với các văn bản pháp lý và vật chứng gốc then chốt, bảo đảm hành vi tống đạt có độ tin cậy pháp định không thể tranh cãi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3404] [邮局] (yóujú) - bưu điện, bưu cục [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '邮局' AND pinyin = 'yóujú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '邮局' AND pinyin = 'yóujú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '邮局'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '邮局'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yóujú',
      meaning_vi = 'bưu điện, bưu cục',
      example_hanzi = '街道拐角处有一家历史悠久的老邮局，门口摆放的墨绿色老式邮筒承载了这座小镇几代人的美好回忆。',
      example_pinyin = 'Jiēdào guǎijiǎochù yǒu yī jiā lìshǐ yōujiǔ de lǎo yóujú, ménkǒu bǎifàng de mòlǜsè lǎoshì yóutǒng chéngzài le zhè zuò xiǎozhèn jǐ dài rén de měihǎo huíyì.',
      example_vi = 'Nơi góc phố có một bưu điện cũ lâu đời, thùng thư kiểu cũ màu xanh lục sẫm đặt trước cửa mang theo những ký ức tươi đẹp của bao thế hệ cư dân thị trấn nhỏ này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '邮局',
      'yóujú',
      'bưu điện, bưu cục',
      'Danh từ',
      'HSK 5',
      '街道拐角处有一家历史悠久的老邮局，门口摆放的墨绿色老式邮筒承载了这座小镇几代人的美好回忆。',
      'Jiēdào guǎijiǎochù yǒu yī jiā lìshǐ yōujiǔ de lǎo yóujú, ménkǒu bǎifàng de mòlǜsè lǎoshì yóutǒng chéngzài le zhè zuò xiǎozhèn jǐ dài rén de měihǎo huíyì.',
      'Nơi góc phố có một bưu điện cũ lâu đời, thùng thư kiểu cũ màu xanh lục sẫm đặt trước cửa mang theo những ký ức tươi đẹp của bao thế hệ cư dân thị trấn nhỏ này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '街道拐角处有一家历史悠久的老邮局，门口摆放的墨绿色老式邮筒承载了这座小镇几代人的美好回忆。', 'Jiēdào guǎijiǎochù yǒu yī jiā lìshǐ yōujiǔ de lǎo yóujú, ménkǒu bǎifàng de mòlǜsè lǎoshì yóutǒng chéngzài le zhè zuò xiǎozhèn jǐ dài rén de měihǎo huíyì.', 'Nơi góc phố có một bưu điện cũ lâu đời, thùng thư kiểu cũ màu xanh lục sẫm đặt trước cửa mang theo những ký ức tươi đẹp của bao thế hệ cư dân thị trấn nhỏ này.', 'basic', 1),
      (v_id, '国家在边远高原边境村寨统筹推进智慧绿色邮政便民示范工程，将传统乡村邮局全面升级为融汇政务便民、农产品寄递与农村电商的综合服务枢纽。', 'Guójiā zài biānyuǎn gāoyuán biānjìng cūnzhài tǒngchóu tuījìn zhìhuì lǜsè yóuzhèng biànmín shìfàn gōngchéng, jiāng chuántǒng xiāngcūn yóujú quánmiàn shēngjí wéi rónghuì zhèngwù biànmín, nóngchǎnpǐn jìdì yǔ nóngcūn diànshāng de zōnghé fúwù shūniǔ.', 'Nhà nước điều phối thúc đẩy công trình kiểu mẫu tiện dân bưu chính xanh thông minh tại các bản làng biên giới vùng cao hẻo lánh, nâng cấp toàn diện các bưu điện thôn quê truyền thống thành đầu mối dịch vụ tổng hợp kết hợp các thủ tục hành chính công tiện ích, chuyển phát nông sản và thương mại điện tử nông thôn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3405] [游览] (yóulǎn) - du lãm, tham quan, ngắm cảnh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '游览' AND pinyin = 'yóulǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '游览' AND pinyin = 'yóulǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '游览'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '游览'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yóulǎn',
      meaning_vi = 'du lãm, tham quan, ngắm cảnh',
      example_hanzi = '每年金秋十月，来自世界各地的数十万名游客都会来到北京，登临长城饱览壮丽的崇山峻岭与秋色美景。',
      example_pinyin = 'Měinián jīnqiū shíyuè, láizì shìjiè gèdì de shù shí wàn míng yóukè dōu huì lái dào Běijīng, dēnglín chángchéng bǎolǎn zhuànglì de chóngshān-jùnlǐng yǔ qiūsè měijǐng.',
      example_vi = 'Hàng năm vào tháng mười mùa thu vàng, hàng trăm nghìn du khách từ khắp nơi trên thế giới đều đến Bắc Kinh, trèo lên vạn lý trường thành thưởng lãm cảnh sắc mùa thu tuyệt đẹp cùng núi non trùng điệp hùng vĩ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '游览',
      'yóulǎn',
      'du lãm, tham quan, ngắm cảnh',
      'Động từ',
      'HSK 5',
      '每年金秋十月，来自世界各地的数十万名游客都会来到北京，登临长城饱览壮丽的崇山峻岭与秋色美景。',
      'Měinián jīnqiū shíyuè, láizì shìjiè gèdì de shù shí wàn míng yóukè dōu huì lái dào Běijīng, dēnglín chángchéng bǎolǎn zhuànglì de chóngshān-jùnlǐng yǔ qiūsè měijǐng.',
      'Hàng năm vào tháng mười mùa thu vàng, hàng trăm nghìn du khách từ khắp nơi trên thế giới đều đến Bắc Kinh, trèo lên vạn lý trường thành thưởng lãm cảnh sắc mùa thu tuyệt đẹp cùng núi non trùng điệp hùng vĩ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每年金秋十月，来自世界各地的数十万名游客都会来到北京，登临长城饱览壮丽的崇山峻岭与秋色美景。', 'Měinián jīnqiū shíyuè, láizì shìjiè gèdì de shù shí wàn míng yóukè dōu huì lái dào Běijīng, dēnglín chángchéng bǎolǎn zhuànglì de chóngshān-jùnlǐng yǔ qiūsè měijǐng.', 'Hàng năm vào tháng mười mùa thu vàng, hàng trăm nghìn du khách từ khắp nơi trên thế giới đều đến Bắc Kinh, trèo lên vạn lý trường thành thưởng lãm cảnh sắc mùa thu tuyệt đẹp cùng núi non trùng điệp hùng vĩ.', 'basic', 1),
      (v_id, '国家文旅数字化工程运用高精度空间数字孪生与全景视网膜漫游技术，为全球广大文博爱好者打造沉浸式在线深度游览世界文化遗产的新模式。', 'Guójiā wén-lǚ shùzìhuà gōngchéng yùnyòng gāojīngdù kōngjiān shùzì luànshēng yǔ quánjǐng shìwǎngmó mànyóu jìshù, wèi quánqiú guǎngdà wénbó àihàozhě dǎzào chénjìnshì zàixiàn shēndù yóulǎn shìjiè wénhuà yíchǎn de xīn móshì.', 'Công trình số hóa văn hóa du lịch quốc gia ứng dụng công nghệ bản sao số không gian độ chính xác cao và dạo chơi võng mạc toàn cảnh, tạo dựng mô hình mới tham quan chiều sâu trực tuyến đắm chìm các di sản văn hóa thế giới cho đông đảo người yêu thích bảo tàng trên toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3406] [邮票] (yóupiào) - tem bưu chính, con tem [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '邮票' AND pinyin = 'yóupiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '邮票' AND pinyin = 'yóupiào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '邮票'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '邮票'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yóupiào',
      meaning_vi = 'tem bưu chính, con tem',
      example_hanzi = '集邮爱好者的精美硬质集邮册里整齐地收藏着多枚纪念中国航天载人飞行圆满成功的珍贵邮票。',
      example_pinyin = 'Jíyóu àihàozhě de jīngměi yìngzhì jíyóucè lǐ zhěngqí de shōucáng zhe duō méi jìniàn Zhōngguó hángtiān zàirén fēixíng yuánmǎn chénggōng de zhēnguì yóupiào.',
      example_vi = 'Trong cuốn album sưu tầm tem bìa cứng tinh xảo của người đam mê sưu tầm tem lưu trữ ngay ngắn nhiều con tem quý giá kỷ niệm chuyến bay có người lái thành công tốt đẹp của ngành hàng không vũ trụ Trung Quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '邮票',
      'yóupiào',
      'tem bưu chính, con tem',
      'Danh từ',
      'HSK 5',
      '集邮爱好者的精美硬质集邮册里整齐地收藏着多枚纪念中国航天载人飞行圆满成功的珍贵邮票。',
      'Jíyóu àihàozhě de jīngměi yìngzhì jíyóucè lǐ zhěngqí de shōucáng zhe duō méi jìniàn Zhōngguó hángtiān zàirén fēixíng yuánmǎn chénggōng de zhēnguì yóupiào.',
      'Trong cuốn album sưu tầm tem bìa cứng tinh xảo của người đam mê sưu tầm tem lưu trữ ngay ngắn nhiều con tem quý giá kỷ niệm chuyến bay có người lái thành công tốt đẹp của ngành hàng không vũ trụ Trung Quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '集邮爱好者的精美硬质集邮册里整齐地收藏着多枚纪念中国航天载人飞行圆满成功的珍贵邮票。', 'Jíyóu àihàozhě de jīngměi yìngzhì jíyóucè lǐ zhěngqí de shōucáng zhe duō méi jìniàn Zhōngguó hángtiān zàirén fēixíng yuánmǎn chénggōng de zhēnguì yóupiào.', 'Trong cuốn album sưu tầm tem bìa cứng tinh xảo của người đam mê sưu tầm tem lưu trữ ngay ngắn nhiều con tem quý giá kỷ niệm chuyến bay có người lái thành công tốt đẹp của ngành hàng không vũ trụ Trung Quốc.', 'basic', 1),
      (v_id, '国家邮政行政部门正式发行一套融汇光学防伪微缩凹印工艺与嵌入式芯片防伪技术的重大历史工程纪念邮票，具有极高的艺术与历史收藏价值。', 'Guójiā yóuzhèng xíngzhèng bùmén zhèngshì fāxíng yī tào rónghuì guāngxué fángwěi wēisuō āoyìn gōngyì yǔ qiànrùshì xīnpiàn fángwěi jìshù de zhòngdà lìshǐ gōngchéng jìniàn yóupiào, jùyǒu jí gāo de yìshù yǔ lìshǐ shōucáng jiàzhí.', 'Cơ quan hành chính bưu chính quốc gia chính thức phát hành một bộ tem kỷ niệm công trình lịch sử trọng đại kết hợp công nghệ in lõm vi mô chống giả quang học và kỹ thuật chống giả bằng chip nhúng, có giá trị sưu tầm lịch sử và nghệ thuật rất cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3407] [油条] (yóutiáo) - quẩy, quẩy rán, giò cháo quẩy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '油条' AND pinyin = 'yóutiáo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '油条' AND pinyin = 'yóutiáo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '油条'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '油条'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yóutiáo',
      meaning_vi = 'quẩy, quẩy rán, giò cháo quẩy',
      example_hanzi = '冬日清晨，一碗热气腾腾的原汁磨制豆浆搭配两根刚刚出锅、色泽金黄香脆的油条，是极具烟火气的经典中式传统早餐。',
      example_pinyin = 'Dōngrì qīngchén, yī wǎn rèqì-téngténg de yuánzhī mózhì dòujiāng dāpèi liǎng gēn gānggāng chūguō, sèzé jīnhuáng xiāngcuì de yóutiáo, shì jí jù yānhuǒqì de jīngdiǎn Zhōngshì chuántǒng zǎocān.',
      example_vi = 'Sáng sớm ngày đông, một bát sữa đậu nành xay nguyên chất bốc khói nghi ngút kết hợp với hai chiếc quẩy vàng ươm giòn rụm vừa vớt ra khỏi chảo là bữa sáng truyền thống kiểu Trung kinh điển đậm đà hơi thở nhân sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '油条',
      'yóutiáo',
      'quẩy, quẩy rán, giò cháo quẩy',
      'Danh từ',
      'HSK 5',
      '冬日清晨，一碗热气腾腾的原汁磨制豆浆搭配两根刚刚出锅、色泽金黄香脆的油条，是极具烟火气的经典中式传统早餐。',
      'Dōngrì qīngchén, yī wǎn rèqì-téngténg de yuánzhī mózhì dòujiāng dāpèi liǎng gēn gānggāng chūguō, sèzé jīnhuáng xiāngcuì de yóutiáo, shì jí jù yānhuǒqì de jīngdiǎn Zhōngshì chuántǒng zǎocān.',
      'Sáng sớm ngày đông, một bát sữa đậu nành xay nguyên chất bốc khói nghi ngút kết hợp với hai chiếc quẩy vàng ươm giòn rụm vừa vớt ra khỏi chảo là bữa sáng truyền thống kiểu Trung kinh điển đậm đà hơi thở nhân sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬日清晨，一碗热气腾腾的原汁磨制豆浆搭配两根刚刚出锅、色泽金黄香脆的油条，是极具烟火气的经典中式传统早餐。', 'Dōngrì qīngchén, yī wǎn rèqì-téngténg de yuánzhī mózhì dòujiāng dāpèi liǎng gēn gānggāng chūguō, sèzé jīnhuáng xiāngcuì de yóutiáo, shì jí jù yānhuǒqì de jīngdiǎn Zhōngshì chuántǒng zǎocān.', 'Sáng sớm ngày đông, một bát sữa đậu nành xay nguyên chất bốc khói nghi ngút kết hợp với hai chiếc quẩy vàng ươm giòn rụm vừa vớt ra khỏi chảo là bữa sáng truyền thống kiểu Trung kinh điển đậm đà hơi thở nhân sinh.', 'basic', 1),
      (v_id, '传统特色面点工业化龙头企业通过自主研发低温急冻锁鲜与无铝环保膨松工艺配方，成功实现了非遗传统经典油条的全自动无菌洁净流水线生产。', 'Chuántǒng tèsè miàndiǎn gōngyèhuà lóngtóu qǐyè tōngguò zìzhǔ yánfā dīwēn jídòng suǒxiān yǔ wú-lǚ huánbǎo péngsōng gōngyì pèifāng, chénggōng shíxiàn le fēiyí chuántǒng jīngdiǎn yóutiáo de quán-zìdòng wújūn jiéjìng liúshuǐxiàn shēngchǎn.', 'Doanh nghiệp đầu ngành công nghiệp hóa bánh ngọt đặc sản truyền thống thông qua việc tự nghiên cứu phát triển công thức công nghệ làm nở thân thiện với môi trường không chứa nhôm và cấp đông nhiệt độ thấp giữ trọn độ tươi, đã thực hiện thành công việc sản xuất trên dây chuyền tự động hóa hoàn toàn vô trùng sạch sẽ cho món quẩy kinh điển truyền thống di sản phi vật thể.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3408] [犹豫] (yóuyù) - do dự, ngập ngừng, lưỡng lự [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '犹豫' AND pinyin = 'yóuyù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '犹豫' AND pinyin = 'yóuyù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '犹豫'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '犹豫'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'yóuyù',
      meaning_vi = 'do dự, ngập ngừng, lưỡng lự',
      example_hanzi = '面对眼前这个极为珍贵难得的国家公派海外顶尖学府进修深造名额，他没有丝毫犹豫，当即填写并递交了报名申请表。',
      example_pinyin = 'Miànduì yǎnqián zhè gè jíwéi zhēnguì nándé de guójiā gōngpài hǎiwài dǐngjiān xuéfǔ jìnxiū shēnzào míng’é, tā méiyǒu sīháo yóuyù, dāngjí tiánxiě bìng dìjiāo le bàomíng shēnqǐngbiǎo.',
      example_vi = 'Đối diện với suất cử đi tu nghiệp nâng cao tại trường đại học đỉnh cao hải ngoại theo diện công phái của nhà nước vô cùng quý giá hiếm có này, anh ấy không chút do dự, lập tức điền và nộp đơn đăng ký dự tuyển.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '犹豫',
      'yóuyù',
      'do dự, ngập ngừng, lưỡng lự',
      'Tính từ / Động từ',
      'HSK 5',
      '面对眼前这个极为珍贵难得的国家公派海外顶尖学府进修深造名额，他没有丝毫犹豫，当即填写并递交了报名申请表。',
      'Miànduì yǎnqián zhè gè jíwéi zhēnguì nándé de guójiā gōngpài hǎiwài dǐngjiān xuéfǔ jìnxiū shēnzào míng’é, tā méiyǒu sīháo yóuyù, dāngjí tiánxiě bìng dìjiāo le bàomíng shēnqǐngbiǎo.',
      'Đối diện với suất cử đi tu nghiệp nâng cao tại trường đại học đỉnh cao hải ngoại theo diện công phái của nhà nước vô cùng quý giá hiếm có này, anh ấy không chút do dự, lập tức điền và nộp đơn đăng ký dự tuyển.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对眼前这个极为珍贵难得的国家公派海外顶尖学府进修深造名额，他没有丝毫犹豫，当即填写并递交了报名申请表。', 'Miànduì yǎnqián zhè gè jíwéi zhēnguì nándé de guójiā gōngpài hǎiwài dǐngjiān xuéfǔ jìnxiū shēnzào míng’é, tā méiyǒu sīháo yóuyù, dāngjí tiánxiě bìng dìjiāo le bàomíng shēnqǐngbiǎo.', 'Đối diện với suất cử đi tu nghiệp nâng cao tại trường đại học đỉnh cao hải ngoại theo diện công phái của nhà nước vô cùng quý giá hiếm có này, anh ấy không chút do dự, lập tức điền và nộp đơn đăng ký dự tuyển.', 'basic', 1),
      (v_id, '在百年变局加速演进与前沿颠覆性技术竞争的关键战略抉择关口，科技领军实体企业绝不可犹豫不决、错失自主研发的黄金窗口期。', 'Zài bǎinián biànjú jiāsù yǎnjìn yǔ qiányán diānfùxìng jìshù jìngzhēng de guānjiàn zhànlüè juézé guānkǒu, kējì lǐngjūn shítǐ qǐyè jué bù kě yóuyù-bùjué, cuòshī zìzhǔ yánfā de huángjīn chuāngkǒuqī.', 'Tại ngã rẽ lựa chọn chiến lược then chốt của sự tiến biến tăng tốc trong biến cuộc trăm năm và cạnh tranh công nghệ đột phá tiền duyên, các doanh nghiệp thực thể công nghệ dẫn đầu tuyệt đối không thể do dự thiếu quyết đoán để tuột mất thời kỳ cửa sổ vàng của nghiên cứu phát triển tự chủ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3409] [有害] (yǒu hài) - có hại, độc hại, gây hại [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '有害' AND pinyin = 'yǒu hài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有害' AND pinyin = 'yǒu hài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '有害'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有害'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yǒu hài',
      meaning_vi = 'có hại, độc hại, gây hại',
      example_hanzi = '长期吸烟、过度酗酒以及经常熬夜，对人体的心血管循环系统与大脑神经健康都是极其有害的不良生活习惯。',
      example_pinyin = 'Chángqī xīyān, guòdù xùjiǔ yǐjí chángcháng áoyè, duì réntǐ de xīnxuèguǎn xúnhuán xìtǒng yǔ dànǎo shénjīng jiànkāng dōu shì jíqí yǒuhài de bùliáng shēnghuó xíguàn.',
      example_vi = 'Hút thuốc lâu năm, lạm dụng rượu bia quá đà cũng như thường xuyên thức khuya đều là những thói quen sinh hoạt xấu cực kỳ có hại đối với hệ tuần hoàn tim mạch và sức khỏe thần kinh não bộ của con người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '有害',
      'yǒu hài',
      'có hại, độc hại, gây hại',
      'Tính từ',
      'HSK 5',
      '长期吸烟、过度酗酒以及经常熬夜，对人体的心血管循环系统与大脑神经健康都是极其有害的不良生活习惯。',
      'Chángqī xīyān, guòdù xùjiǔ yǐjí chángcháng áoyè, duì réntǐ de xīnxuèguǎn xúnhuán xìtǒng yǔ dànǎo shénjīng jiànkāng dōu shì jíqí yǒuhài de bùliáng shēnghuó xíguàn.',
      'Hút thuốc lâu năm, lạm dụng rượu bia quá đà cũng như thường xuyên thức khuya đều là những thói quen sinh hoạt xấu cực kỳ có hại đối với hệ tuần hoàn tim mạch và sức khỏe thần kinh não bộ của con người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长期吸烟、过度酗酒以及经常熬夜，对人体的心血管循环系统与大脑神经健康都是极其有害的不良生活习惯。', 'Chángqī xīyān, guòdù xùjiǔ yǐjí chángcháng áoyè, duì réntǐ de xīnxuèguǎn xúnhuán xìtǒng yǔ dànǎo shénjīng jiànkāng dōu shì jíqí yǒuhài de bùliáng shēnghuó xíguàn.', 'Hút thuốc lâu năm, lạm dụng rượu bia quá đà cũng như thường xuyên thức khuya đều là những thói quen sinh hoạt xấu cực kỳ có hại đối với hệ tuần hoàn tim mạch và sức khỏe thần kinh não bộ của con người.', 'basic', 1),
      (v_id, '生态环境生态执法监察总队依法重拳惩处工业企业在未获许可情况下非法倾倒工业危废与持久性有机有害化学品的重大环境违法犯罪行为。', 'Shēngtài huánjìng shēngtài zhífǎ jiānchá zǒngduì yīfǎ zhòngquán chéngchǔ gōngyè qǐyè zài wèihuò xǔkě qíngkuàng xià fēifǎ qīngdào gōngyè wēifèi yǔ chíjiǔxìng yǒujī yǒuhài huàxuépǐn de zhòngdà huánjìng wéifǎ fànzuì xíngwéi.', 'Tổng đội thanh tra thực thi pháp luật môi trường sinh thái căn cứ theo luật định giáng đòn mạnh mẽ trừng trị hành vi phạm tội vi phạm môi trường nghiêm trọng của các doanh nghiệp công nghiệp khi đổ trộm chất thải nguy hại công nghiệp và hóa chất độc hại hữu cơ khó phân hủy mà không có giấy phép.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3410] [有力] (yǒulì) - có lực, mạnh mẽ, đắc lực [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '有力' AND pinyin = 'yǒulì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有力' AND pinyin = 'yǒulì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '有力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yǒulì',
      meaning_vi = 'có lực, mạnh mẽ, đắc lực',
      example_hanzi = '他在青年辩论赛决赛中的发言立论严密、论据充分详实，对反驳对手的片面观点起到了极其有力的说服作用。',
      example_pinyin = 'Tā zài qīngnián biànlùnsài juésài zhōng de fāyán lìlùn yánmì, lùnjù chōngfèn xiángshí, duì fǎnbó duìshǒu de piànmiàn guāndiǎn qǐdào le jíqí yǒulì de shuōfú zuòyòng.',
      example_vi = 'Phát biểu của anh ấy trong trận chung kết cuộc thi tranh biện thanh niên lập luận chặt chẽ, luận cứ đầy đủ xác thực, đã phát huy tác dụng thuyết phục vô cùng mạnh mẽ trong việc phản bác các quan điểm phiến diện của đối phương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '有力',
      'yǒulì',
      'có lực, mạnh mẽ, đắc lực',
      'Tính từ',
      'HSK 5',
      '他在青年辩论赛决赛中的发言立论严密、论据充分详实，对反驳对手的片面观点起到了极其有力的说服作用。',
      'Tā zài qīngnián biànlùnsài juésài zhōng de fāyán lìlùn yánmì, lùnjù chōngfèn xiángshí, duì fǎnbó duìshǒu de piànmiàn guāndiǎn qǐdào le jíqí yǒulì de shuōfú zuòyòng.',
      'Phát biểu của anh ấy trong trận chung kết cuộc thi tranh biện thanh niên lập luận chặt chẽ, luận cứ đầy đủ xác thực, đã phát huy tác dụng thuyết phục vô cùng mạnh mẽ trong việc phản bác các quan điểm phiến diện của đối phương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在青年辩论赛决赛中的发言立论严密、论据充分详实，对反驳对手的片面观点起到了极其有力的说服作用。', 'Tā zài qīngnián biànlùnsài juésài zhōng de fāyán lìlùn yánmì, lùnjù chōngfèn xiángshí, duì fǎnbó duìshǒu de piànmiàn guāndiǎn qǐdào le jíqí yǒulì de shuōfú zuòyòng.', 'Phát biểu của anh ấy trong trận chung kết cuộc thi tranh biện thanh niên lập luận chặt chẽ, luận cứ đầy đủ xác thực, đã phát huy tác dụng thuyết phục vô cùng mạnh mẽ trong việc phản bác các quan điểm phiến diện của đối phương.', 'basic', 1),
      (v_id, '国家适时出台一揽子有力度的宏观逆周期调节与扩大有效投资政策组合拳，为推动实体经济平稳健康向好发展提供了坚实有力的战略支撑。', 'Guójiā shìshí chūtái yī lǎn zi yǒu lìdù de hóngguān nì-zhōuqī tiáojié yǔ kuòdà yǒuxiào tóuzī zhèngcè zǔhéquán, wèi tuīdòng shítǐ jīngjì píngwěn jiànkāng xiànghǎo fāzhǎn tígōng le jiānshí yǒulì de zhànlüè zhīchēng.', 'Nhà nước kịp thời đưa ra gói giải pháp chính sách có độ lực mạnh mẽ kết hợp điều tiết nghịch chu kỳ vĩ mô và mở rộng đầu tư hiệu quả, cung cấp bệ đỡ chiến lược vững chắc và đầy uy lực để thúc đẩy nền kinh tế thực thể phát triển ổn định, lành mạnh và theo chiều hướng tích cực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3411] [有利] (yǒulì) - có lợi, thuận lợi, có ích [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '有利' AND pinyin = 'yǒulì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有利' AND pinyin = 'yǒulì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '有利'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有利'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yǒulì',
      meaning_vi = 'có lợi, thuận lợi, có ích',
      example_hanzi = '每天坚持在新鲜空气中进行半小时以上的轻度有氧运动，对于促进机体新陈代谢与保持心理健康极其有利。',
      example_pinyin = 'Měitiān jiānchí zài xīnxiān kōngqì zhōng jìnxíng bàn xiǎoshí yǐshàng de qīngdù yǒuyǎng yùndòng, duìyú cùjìn jītǐ xīnhéndàixiè yǔ bǎochí xīnlǐ jiànkāng jíqí yǒulì.',
      example_vi = 'Mỗi ngày kiên trì vận động hiếu khí nhẹ nhàng từ nửa giờ trở lên trong không khí trong lành là cực kỳ có lợi cho việc thúc đẩy trao đổi chất của cơ thể và duy trì sức khỏe tâm lý.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '有利',
      'yǒulì',
      'có lợi, thuận lợi, có ích',
      'Tính từ',
      'HSK 5',
      '每天坚持在新鲜空气中进行半小时以上的轻度有氧运动，对于促进机体新陈代谢与保持心理健康极其有利。',
      'Měitiān jiānchí zài xīnxiān kōngqì zhōng jìnxíng bàn xiǎoshí yǐshàng de qīngdù yǒuyǎng yùndòng, duìyú cùjìn jītǐ xīnhéndàixiè yǔ bǎochí xīnlǐ jiànkāng jíqí yǒulì.',
      'Mỗi ngày kiên trì vận động hiếu khí nhẹ nhàng từ nửa giờ trở lên trong không khí trong lành là cực kỳ có lợi cho việc thúc đẩy trao đổi chất của cơ thể và duy trì sức khỏe tâm lý.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天坚持在新鲜空气中进行半小时以上的轻度有氧运动，对于促进机体新陈代谢与保持心理健康极其有利。', 'Měitiān jiānchí zài xīnxiān kōngqì zhōng jìnxíng bàn xiǎoshí yǐshàng de qīngdù yǒuyǎng yùndòng, duìyú cùjìn jītǐ xīnhéndàixiè yǔ bǎochí xīnlǐ jiànkāng jíqí yǒulì.', 'Mỗi ngày kiên trì vận động hiếu khí nhẹ nhàng từ nửa giờ trở lên trong không khí trong lành là cực kỳ có lợi cho việc thúc đẩy trao đổi chất của cơ thể và duy trì sức khỏe tâm lý.', 'basic', 1),
      (v_id, '加快建设全国统一大市场并全面清理废除地方保护隐性壁垒，极其有利于各类先进生产要素在全国大市场空间内自由畅通流动与高效集聚。', 'Jiākuài jiànshè quánguó tǒngyī dà shìchǎng bìng quánmiàn qīnglǐ fèichú dìfāng bǎohù yǐnxìng bìlěi, jíqí yǒulì yú gè lèi xiānjìn shēngchǎn yàosù zài quánguó dà shìchǎng kōngjiān nèi zìyóu chàngtōng liúdòng yǔ gāoxiào jíjù.', 'Đẩy nhanh xây dựng thị trường lớn thống nhất trên toàn quốc và thanh lọc xóa bỏ triệt để các rào cản vô hình mang tính bảo hộ cục bộ địa phương là vô cùng thuận lợi để các loại yếu tố sản xuất tiên tiến lưu thông tự do thông suốt và quy tụ hiệu quả cao trong không gian thị trường lớn cả nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3412] [有限] (yǒuxiàn) - có hạn, hữu hạn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '有限' AND pinyin = 'yǒuxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有限' AND pinyin = 'yǒuxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '有限'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有限'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yǒuxiàn',
      meaning_vi = 'có hạn, hữu hạn',
      example_hanzi = '个人的时间与精力虽然是有限的，但一个人全心全意为社会奉献爱心、服务大众的精神与追求却是无限的。',
      example_pinyin = 'Gèrén de shíjiān yǔ jīnglì suīrán shì yǒuxiàn de, dàn yī gè rén quánxīn-quányì wèi shèhuì fèngxiàn àixīn, fúwù dàzhòng de jīngshén yǔ zhuīqiú què shì wúxiàn de.',
      example_vi = 'Thời gian và sức lực của mỗi cá nhân dẫu là có hạn, nhưng tinh thần và sự theo đuổi hết lòng hết dạ cống hiến tình thương cho xã hội, phụng sự quảng đại quần chúng của một con người lại là vô hạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '有限',
      'yǒuxiàn',
      'có hạn, hữu hạn',
      'Tính từ',
      'HSK 5',
      '个人的时间与精力虽然是有限的，但一个人全心全意为社会奉献爱心、服务大众的精神与追求却是无限的。',
      'Gèrén de shíjiān yǔ jīnglì suīrán shì yǒuxiàn de, dàn yī gè rén quánxīn-quányì wèi shèhuì fèngxiàn àixīn, fúwù dàzhòng de jīngshén yǔ zhuīqiú què shì wúxiàn de.',
      'Thời gian và sức lực của mỗi cá nhân dẫu là có hạn, nhưng tinh thần và sự theo đuổi hết lòng hết dạ cống hiến tình thương cho xã hội, phụng sự quảng đại quần chúng của một con người lại là vô hạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '个人的时间与精力虽然是有限的，但一个人全心全意为社会奉献爱心、服务大众的精神与追求却是无限的。', 'Gèrén de shíjiān yǔ jīnglì suīrán shì yǒuxiàn de, dàn yī gè rén quánxīn-quányì wèi shèhuì fèngxiàn àixīn, fúwù dàzhòng de jīngshén yǔ zhuīqiú què shì wúxiàn de.', 'Thời gian và sức lực của mỗi cá nhân dẫu là có hạn, nhưng tinh thần và sự theo đuổi hết lòng hết dạ cống hiến tình thương cho xã hội, phụng sự quảng đại quần chúng của một con người lại là vô hạn.', 'basic', 1),
      (v_id, '在极端水资源极为紧缺有限的干旱与半干旱内陆农耕区，农业水利科研团队全力攻克水肥一体化地下微孔渗灌技术以大幅提升水分利用率。', 'Zài jíduān shuǐzīyuán jíwéi jǐnquē yǒuxiàn de gānhàn yǔ bàn-gānhàn nèilù nónggēngqū, nóngyè shuǐlì kēyán tuánduì quánlì gōngkè shuǐ-féi yītǐhuà dìxià wēikǒng shènguàn jìshù yǐ dàfú tíshēng shuǐfèn lìyònglǜ.', 'Tại các vùng canh tác nông nghiệp nội địa khô hạn và bán khô hạn với nguồn tài nguyên nước cực kỳ khan hiếm có hạn, đội ngũ nghiên cứu thủy lợi nông nghiệp đã dốc toàn lực chinh phục kỹ thuật tưới thấm lỗ vi mô dưới lòng đất tích hợp nước và phân bón nhằm nâng cao mạnh mẽ tỷ lệ sử dụng nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3413] [有益] (yǒuyì) - có ích, có lợi ích, bổ ích [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '有益' AND pinyin = 'yǒuyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有益' AND pinyin = 'yǒuyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '有益'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有益'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yǒuyì',
      meaning_vi = 'có ích, có lợi ích, bổ ích',
      example_hanzi = '青少年多阅读中外古典文学经典与现代科学普及著作，对于涵养心智、开阔眼界与树立崇高人生理想大有益处。',
      example_pinyin = 'Qīngshàonián duō yuèdú zhōngwài gǔdiǎn wénxué jīngdiǎn yǔ xiàndài kēxué pǔjí zhùzuò, duìyú hányǎng xīnlì, kāikuò yǎnjiè yǔ shùlì chónggāo rénshēng lǐxiǎng dàyǒu-yìchù.',
      example_vi = 'Thanh thiếu niên đọc nhiều danh tác văn học cổ điển trong ngoài nước và các công trình phổ biến khoa học hiện đại đem lại lợi ích to lớn đối với việc bồi dưỡng tâm trí, mở rộng tầm mắt và thiết lập lý tưởng sống cao đẹp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '有益',
      'yǒuyì',
      'có ích, có lợi ích, bổ ích',
      'Tính từ',
      'HSK 5',
      '青少年多阅读中外古典文学经典与现代科学普及著作，对于涵养心智、开阔眼界与树立崇高人生理想大有益处。',
      'Qīngshàonián duō yuèdú zhōngwài gǔdiǎn wénxué jīngdiǎn yǔ xiàndài kēxué pǔjí zhùzuò, duìyú hányǎng xīnlì, kāikuò yǎnjiè yǔ shùlì chónggāo rénshēng lǐxiǎng dàyǒu-yìchù.',
      'Thanh thiếu niên đọc nhiều danh tác văn học cổ điển trong ngoài nước và các công trình phổ biến khoa học hiện đại đem lại lợi ích to lớn đối với việc bồi dưỡng tâm trí, mở rộng tầm mắt và thiết lập lý tưởng sống cao đẹp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青少年多阅读中外古典文学经典与现代科学普及著作，对于涵养心智、开阔眼界与树立崇高人生理想大有益处。', 'Qīngshàonián duō yuèdú zhōngwài gǔdiǎn wénxué jīngdiǎn yǔ xiàndài kēxué pǔjí zhùzuò, duìyú hányǎng xīnlì, kāikuò yǎnjiè yǔ shùlì chónggāo rénshēng lǐxiǎng dàyǒu-yìchù.', 'Thanh thiếu niên đọc nhiều danh tác văn học cổ điển trong ngoài nước và các công trình phổ biến khoa học hiện đại đem lại lợi ích to lớn đối với việc bồi dưỡng tâm trí, mở rộng tầm mắt và thiết lập lý tưởng sống cao đẹp.', 'basic', 1),
      (v_id, '积极搭建多边产学研用跨界协同创新联合体，对推动国家战略实验室的前沿基础科学理论成果高效率向现实生产力转化极为有益。', 'Jījí dājiàn duōbiān chǎn-xué-yán-yòng kuàjiè xiétóng chuàngxīn liánhétǐ, duì tuīdòng guójiā zhànlüè shíyànshì de qiányán jīchǔ kēxué lǐlùn chéngguǒ gāo-xiàolǜ xiàng xiànshí shēngchǎnlì zhuǎnhuà jíqí yǒuyì.', 'Chủ động xây dựng liên minh đổi mới hiệp đồng liên ngành đa phương giữa doanh nghiệp - viện trường - nghiên cứu - ứng dụng là cực kỳ có ích cho việc thúc đẩy các thành quả lý thuyết khoa học cơ bản tiền duyên của phòng thí nghiệm chiến lược quốc gia chuyển hóa với hiệu suất cao thành lực lượng sản xuất hiện thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3414] [有助于] (yǒuzhùyú) - có lợi cho, góp phần giúp, hỗ trợ cho [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '有助于' AND pinyin = 'yǒuzhùyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有助于' AND pinyin = 'yǒuzhùyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '有助于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '有助于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yǒuzhùyú',
      meaning_vi = 'có lợi cho, góp phần giúp, hỗ trợ cho',
      example_hanzi = '在面临学业压力或考试焦虑时多与师长、朋友倾心交谈，显著有助于及时疏导心理负面情绪并重塑昂扬自信。',
      example_pinyin = 'Zài miànlín xuéyè yālì huò kǎoshì jiāolǜ shí duō yǔ shīzhǎng, péngyou qīngxīn jiāotán, xiǎnzhù yǒuzhùyú jíshí shūdǎo xīnlǐ fùmiàn qíngxù bìng chóngsù ángyáng zìxìn.',
      example_vi = 'Khi đối mặt với áp lực học tập hoặc sự lo lắng trước thi cử nói chuyện cởi mở với thầy cô, bạn bè có tác dụng rõ rệt giúp giải tỏa kịp thời những cảm xúc tiêu cực tâm lý và tái tạo sự tự tin phấn chấn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '有助于',
      'yǒuzhùyú',
      'có lợi cho, góp phần giúp, hỗ trợ cho',
      'Động từ',
      'HSK 5',
      '在面临学业压力或考试焦虑时多与师长、朋友倾心交谈，显著有助于及时疏导心理负面情绪并重塑昂扬自信。',
      'Zài miànlín xuéyè yālì huò kǎoshì jiāolǜ shí duō yǔ shīzhǎng, péngyou qīngxīn jiāotán, xiǎnzhù yǒuzhùyú jíshí shūdǎo xīnlǐ fùmiàn qíngxù bìng chóngsù ángyáng zìxìn.',
      'Khi đối mặt với áp lực học tập hoặc sự lo lắng trước thi cử nói chuyện cởi mở với thầy cô, bạn bè có tác dụng rõ rệt giúp giải tỏa kịp thời những cảm xúc tiêu cực tâm lý và tái tạo sự tự tin phấn chấn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在面临学业压力或考试焦虑时多与师长、朋友倾心交谈，显著有助于及时疏导心理负面情绪并重塑昂扬自信。', 'Zài miànlín xuéyè yālì huò kǎoshì jiāolǜ shí duō yǔ shīzhǎng, péngyou qīngxīn jiāotán, xiǎnzhù yǒuzhùyú jíshí shūdǎo xīnlǐ fùmiàn qíngxù bìng chóngsù ángyáng zìxìn.', 'Khi đối mặt với áp lực học tập hoặc sự lo lắng trước thi cử nói chuyện cởi mở với thầy cô, bạn bè có tác dụng rõ rệt giúp giải tỏa kịp thời những cảm xúc tiêu cực tâm lý và tái tạo sự tự tin phấn chấn.', 'basic', 1),
      (v_id, '全面深化区域全面经济伙伴关系协定框架下的海关通关一体化协同改革，深度有助于大幅压缩区域内跨境物流通关时间与综合贸易成本。', 'Quánmiàn shēnhuà Qūyù Quánmiàn Jīngjì Huǒbàn Guānxì Xiédìng kuàngjià xià de hǎiguān tōngguān yītǐhuà xiétóng gǎigé, shēndù yǒuzhùyú dàfú yāsuō qūyù nèi kuàjìng wùliú tōngguān shíjiān yǔ zōnghé màoyì chéngběn.', 'Đi sâu cải cách phối hợp tích hợp thông quan hải quan toàn diện dưới khuôn khổ Hiệp định Đối tác Kinh tế Toàn diện Khu vực (RCEP) có ý nghĩa sâu sắc giúp rút ngắn đáng kể thời gian thông quan logistics xuyên biên giới và chi phí thương mại tổng hợp trong khu vực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3415] [幼儿园] (yòu’éryuán) - trường mầm non, nhà trẻ, mẫu giáo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '幼儿园' AND pinyin = 'yòu’éryuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '幼儿园' AND pinyin = 'yòu’éryuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '幼儿园'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '幼儿园'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yòu’éryuán',
      meaning_vi = 'trường mầm non, nhà trẻ, mẫu giáo',
      example_hanzi = '每天清晨，年轻的父母们面带微笑牵着孩子稚嫩的小手，将他们安全送到充满欢声笑语的现代化社区幼儿园。',
      example_pinyin = 'Měitiān qīngchén, niánqīng de fùmǔmen miàndài wēixiào qiān zhe háizi zhìnèn de xiǎoshǒu, jiāng tāmen ānquán sòng dào chōngmǎn huānshēng-xiàoyǔ de xiàndàihuà shèqū yòu’éryuán.',
      example_vi = 'Mỗi buổi sáng sớm, các bậc cha mẹ trẻ mỉm cười dắt đôi tay non nớt của con trẻ, đưa các con an toàn đến trường mầm non cộng đồng hiện đại ngập tràn tiếng cười vui.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '幼儿园',
      'yòu’éryuán',
      'trường mầm non, nhà trẻ, mẫu giáo',
      'Danh từ',
      'HSK 5',
      '每天清晨，年轻的父母们面带微笑牵着孩子稚嫩的小手，将他们安全送到充满欢声笑语的现代化社区幼儿园。',
      'Měitiān qīngchén, niánqīng de fùmǔmen miàndài wēixiào qiān zhe háizi zhìnèn de xiǎoshǒu, jiāng tāmen ānquán sòng dào chōngmǎn huānshēng-xiàoyǔ de xiàndàihuà shèqū yòu’éryuán.',
      'Mỗi buổi sáng sớm, các bậc cha mẹ trẻ mỉm cười dắt đôi tay non nớt của con trẻ, đưa các con an toàn đến trường mầm non cộng đồng hiện đại ngập tràn tiếng cười vui.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天清晨，年轻的父母们面带微笑牵着孩子稚嫩的小手，将他们安全送到充满欢声笑语的现代化社区幼儿园。', 'Měitiān qīngchén, niánqīng de fùmǔmen miàndài wēixiào qiān zhe háizi zhìnèn de xiǎoshǒu, jiāng tāmen ānquán sòng dào chōngmǎn huānshēng-xiàoyǔ de xiàndàihuà shèqū yòu’éryuán.', 'Mỗi buổi sáng sớm, các bậc cha mẹ trẻ mỉm cười dắt đôi tay non nớt của con trẻ, đưa các con an toàn đến trường mầm non cộng đồng hiện đại ngập tràn tiếng cười vui.', 'basic', 1),
      (v_id, '教育主管部门全面实施学前教育普惠优质安全发展规划，持续提升各级公办与普惠性民办幼儿园的科学保教保育专业化水平。', 'Jiàoyù zhǔguǎn bùmén quánmiàn shíshī xuéqián jiàoyù pǔhuì yōuzhì ānquán fāzhǎn guīhuà, chíxù tíshēng gè jí gōngbàn yǔ pǔhuìxìng mínbàn yòu’éryuán de kēxué bǎojiào bǎoyù zhuānyèhuà shuǐpíng.', 'Cơ quan chủ quản giáo dục thực thi toàn diện quy hoạch phát triển an toàn chất lượng phổ cập giáo dục mầm non, liên tục nâng cao trình độ chuyên môn hóa về nuôi dạy chăm sóc khoa học của các trường mẫu giáo công lập và tư thục phổ cập các cấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3416] [娱乐] (yúlè) - giải trí, tiêu khiển; trò tiêu khiển [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '娱乐' AND pinyin = 'yúlè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '娱乐' AND pinyin = 'yúlè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '娱乐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '娱乐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yúlè',
      meaning_vi = 'giải trí, tiêu khiển; trò tiêu khiển',
      example_hanzi = '在结束了一周繁重紧凑的工作之后，周五晚上和好友相约看一场精彩的话剧演出是一种极好的身心休闲娱乐方式。',
      example_pinyin = 'Zài jiéshù le yī zhōu fánzhòng jǐncòu de gōngzuò zhīhòu, zhōuwǔ wǎnshang hé hǎoyǒu xiāngyuē kàn yī chǎng jīngcǎi de huàjù yǎnchū shì yī zhǒng jí hǎo de shēnxīn xiūxián yúlè fāngshì.',
      example_vi = 'Sau khi kết thúc một tuần làm việc nặng nề căng thẳng, tối thứ sáu hẹn bạn thân cùng xem một vở kịch nói đặc sắc là một cách nghỉ ngơi giải trí thể chất tinh thần vô cùng tuyệt vời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '娱乐',
      'yúlè',
      'giải trí, tiêu khiển; trò tiêu khiển',
      'Động từ / Danh từ',
      'HSK 5',
      '在结束了一周繁重紧凑的工作之后，周五晚上和好友相约看一场精彩的话剧演出是一种极好的身心休闲娱乐方式。',
      'Zài jiéshù le yī zhōu fánzhòng jǐncòu de gōngzuò zhīhòu, zhōuwǔ wǎnshang hé hǎoyǒu xiāngyuē kàn yī chǎng jīngcǎi de huàjù yǎnchū shì yī zhǒng jí hǎo de shēnxīn xiūxián yúlè fāngshì.',
      'Sau khi kết thúc một tuần làm việc nặng nề căng thẳng, tối thứ sáu hẹn bạn thân cùng xem một vở kịch nói đặc sắc là một cách nghỉ ngơi giải trí thể chất tinh thần vô cùng tuyệt vời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在结束了一周繁重紧凑的工作之后，周五晚上和好友相约看一场精彩的话剧演出是一种极好的身心休闲娱乐方式。', 'Zài jiéshù le yī zhōu fánzhòng jǐncòu de gōngzuò zhīhòu, zhōuwǔ wǎnshang hé hǎoyǒu xiāngyuē kàn yī chǎng jīngcǎi de huàjù yǎnchū shì yī zhǒng jí hǎo de shēnxīn xiūxián yúlè fāngshì.', 'Sau khi kết thúc một tuần làm việc nặng nề căng thẳng, tối thứ sáu hẹn bạn thân cùng xem một vở kịch nói đặc sắc là một cách nghỉ ngơi giải trí thể chất tinh thần vô cùng tuyệt vời.', 'basic', 1),
      (v_id, '随着高分辨率空间计算与神经渲染生成技术的深度突破，现代数字文创娱乐产业正在向全沉浸式、超高清与人机自然互动的全新维度跃升。', 'Suízhe gāofēnbànlǜ kōngjiān jìsuàn yǔ shénjīng xuànrǎn shēngchéng jìshù de shēndù tūpò, xiàndài shùzì wénchuàng yúlè chǎnyè zhèngzài xiàng quán-chénjìnshì, chāogāoqīng yǔ rén-jī zìrán hùdòng de quánxīn wéidù yuèshēng.', 'Cùng với những đột phá sâu sắc của công nghệ tính toán không gian độ phân giải cao và kết xuất sinh nơ-ron, ngành công nghiệp sáng tạo văn hóa giải trí số hiện đại đang có bước nhảy vọt sang một chiều không gian hoàn toàn mới mang tính đắm chìm toàn cảnh, siêu nét và tương tác người - máy tự nhiên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3417] [语气] (yǔqì) - ngữ khí, giọng điệu, cách nói [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '语气' AND pinyin = 'yǔqì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '语气' AND pinyin = 'yǔqì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '语气'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '语气'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǔqì',
      meaning_vi = 'ngữ khí, giọng điệu, cách nói',
      example_hanzi = '在与他人就不同学术观点展开深入讨论时，我们应当始终保持客观理性、谦虚诚恳并充满尊重的交流语气。',
      example_pinyin = 'Zài yǔ tārén jiù bùtóng xuéshù guāndiǎn zhǎnkāi shēnrù tǎolùn shí, wǒmen yīngdāng shǐzhōng bǎochí kèguān lǐxìng, qiānxū chéngkěn bìng chōngmǎn zūnzhòng de jiāoliú yǔqì.',
      example_vi = 'Khi trao đổi thảo luận sâu sắc với người khác về những quan điểm học thuật khác biệt, chúng ta cần luôn giữ ngữ khí giao lưu khách quan lý tính, khiêm tốn chân thành và tràn đầy sự tôn trọng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '语气',
      'yǔqì',
      'ngữ khí, giọng điệu, cách nói',
      'Danh từ',
      'HSK 5',
      '在与他人就不同学术观点展开深入讨论时，我们应当始终保持客观理性、谦虚诚恳并充满尊重的交流语气。',
      'Zài yǔ tārén jiù bùtóng xuéshù guāndiǎn zhǎnkāi shēnrù tǎolùn shí, wǒmen yīngdāng shǐzhōng bǎochí kèguān lǐxìng, qiānxū chéngkěn bìng chōngmǎn zūnzhòng de jiāoliú yǔqì.',
      'Khi trao đổi thảo luận sâu sắc với người khác về những quan điểm học thuật khác biệt, chúng ta cần luôn giữ ngữ khí giao lưu khách quan lý tính, khiêm tốn chân thành và tràn đầy sự tôn trọng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在与他人就不同学术观点展开深入讨论时，我们应当始终保持客观理性、谦虚诚恳并充满尊重的交流语气。', 'Zài yǔ tārén jiù bùtóng xuéshù guāndiǎn zhǎnkāi shēnrù tǎolùn shí, wǒmen yīngdāng shǐzhōng bǎochí kèguān lǐxìng, qiānxū chéngkěn bìng chōngmǎn zūnzhòng de jiāoliú yǔqì.', 'Khi trao đổi thảo luận sâu sắc với người khác về những quan điểm học thuật khác biệt, chúng ta cần luôn giữ ngữ khí giao lưu khách quan lý tính, khiêm tốn chân thành và tràn đầy sự tôn trọng.', 'basic', 1),
      (v_id, '在应对复杂国际涉外争端多边磋商中，首席谈判代表以沉稳坚定、有理有利有节的政策表述语气，清晰传递了维护国家核心利益的坚决立场。', 'Zài yìngduì fùzá guójì shèwài zhēngduān duōbiān cuōshāng zhōng, shǒuxí tánpàn dàibiǎo yǐ chénwěn jiāndìng, yǒulǐ-yǒulì-yǒujié de zhèngcè biǎoshù yǔqì, qīngxī chuándì le wéihù guójiā héxīn lìyì de jiānjué lìchǎng.', 'Trong đàm phán hiệp thương đa phương ứng phó với các tranh chấp quốc tế phức tạp, trưởng đoàn đàm phán bằng ngữ khí phát biểu chính sách điềm tĩnh kiên định, có lý có lợi có chừng mực đã truyền đạt rõ ràng lập trường kiên quyết bảo vệ lợi ích cốt lõi quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3418] [雨水] (yǔshuǐ) - nước mưa; tiết Vũ Thủy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '雨水' AND pinyin = 'yǔshuǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '雨水' AND pinyin = 'yǔshuǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '雨水'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '雨水'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǔshuǐ',
      meaning_vi = 'nước mưa; tiết Vũ Thủy',
      example_hanzi = '春天初降的绵绵雨水格外滋润，无声地润泽着田野里沉睡了一冬的小麦麦苗与漫山遍野的绿树嫩草。',
      example_pinyin = 'Chūntiān chū jiàng de miánmián yǔshuǐ géwài zīrùn, wúshēng de rùnzé zhe tiányě lǐ chénshuì le yī dōng de xiǎomài màimiáo yǔ mànshān-biànyě de lǜshù nèncǎo.',
      example_vi = 'Làn nước mưa xuân lất phất mới rơi đặc biệt ngọt lành tươi tốt, lặng lẽ tưới tắm những mầm mạ lúa mì đã ngủ say suốt mùa đông cùng bạt ngàn cây xanh cỏ non trên khắp núi đồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '雨水',
      'yǔshuǐ',
      'nước mưa; tiết Vũ Thủy',
      'Danh từ',
      'HSK 5',
      '春天初降的绵绵雨水格外滋润，无声地润泽着田野里沉睡了一冬的小麦麦苗与漫山遍野的绿树嫩草。',
      'Chūntiān chū jiàng de miánmián yǔshuǐ géwài zīrùn, wúshēng de rùnzé zhe tiányě lǐ chénshuì le yī dōng de xiǎomài màimiáo yǔ mànshān-biànyě de lǜshù nèncǎo.',
      'Làn nước mưa xuân lất phất mới rơi đặc biệt ngọt lành tươi tốt, lặng lẽ tưới tắm những mầm mạ lúa mì đã ngủ say suốt mùa đông cùng bạt ngàn cây xanh cỏ non trên khắp núi đồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春天初降的绵绵雨水格外滋润，无声地润泽着田野里沉睡了一冬的小麦麦苗与漫山遍野的绿树嫩草。', 'Chūntiān chū jiàng de miánmián yǔshuǐ géwài zīrùn, wúshēng de rùnzé zhe tiányě lǐ chénshuì le yī dōng de xiǎomài màimiáo yǔ mànshān-biànyě de lǜshù nèncǎo.', 'Làn nước mưa xuân lất phất mới rơi đặc biệt ngọt lành tươi tốt, lặng lẽ tưới tắm những mầm mạ lúa mì đã ngủ say suốt mùa đông cùng bạt ngàn cây xanh cỏ non trên khắp núi đồi.', 'basic', 1),
      (v_id, '新型海绵城市地下基础设施规划全面构建集渗、滞、蓄、净、用、排于一体的现代化大型雨水循环利用综合调蓄系统。', 'Xīnxíng hǎimián chéngshì dìxià jīchǔ shèshī guīhuà quánmiàn gòujiàn jí shèn, zhì, xù, jìng, yòng, pái yú yītǐ de xiàndàihuà dàxíng yǔshuǐ xúnhuán lìyòng zōnghé tiáoxù xìtǒng.', 'Quy hoạch hạ tầng ngầm đô thị bọt biển kiểu mới xây dựng toàn diện hệ thống điều tiết tổng hợp tái sử dụng nước mưa tuần hoàn quy mô lớn hiện đại tích hợp các khâu thấm, giữ, trữ, lọc sạch, sử dụng và tiêu thoát nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3419] [语文] (yǔwén) - ngữ văn, môn văn học và tiếng mẹ đẻ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '语文' AND pinyin = 'yǔwén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '语文' AND pinyin = 'yǔwén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '语文'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '语文'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǔwén',
      meaning_vi = 'ngữ văn, môn văn học và tiếng mẹ đẻ',
      example_hanzi = '中小学语文课程教学不仅系统帮助学生掌握母语规范字词与阅读技巧，更能引导学生深刻领略中华传统文学的博大精深。',
      example_pinyin = 'Zhōng-xiǎoxué yǔwén kèchéng jiàoxué bùjǐn xìtǒng bāngzhù xuéshēng zhǎngwò mǔyǔ guīfàn zìcí yǔ yuèdú jìqiǎo, gèng néng yǐndǎo xuéshēng shēnkè lǐnglüè Zhōnghuá chuántǒng wénxué de bódà-jīngshēn.',
      example_vi = 'Giảng dạy môn ngữ văn trường tiểu học và trung học không chỉ giúp học sinh nắm vững chữ nghĩa ngữ pháp tiếng mẹ đẻ chuẩn mực và kỹ năng đọc hiểu một cách có hệ thống, mà còn có thể dẫn dắt học sinh cảm nhận sâu sắc sự uyên thâm bác đại của nền văn học truyền thống Trung Hoa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '语文',
      'yǔwén',
      'ngữ văn, môn văn học và tiếng mẹ đẻ',
      'Danh từ',
      'HSK 5',
      '中小学语文课程教学不仅系统帮助学生掌握母语规范字词与阅读技巧，更能引导学生深刻领略中华传统文学的博大精深。',
      'Zhōng-xiǎoxué yǔwén kèchéng jiàoxué bùjǐn xìtǒng bāngzhù xuéshēng zhǎngwò mǔyǔ guīfàn zìcí yǔ yuèdú jìqiǎo, gèng néng yǐndǎo xuéshēng shēnkè lǐnglüè Zhōnghuá chuántǒng wénxué de bódà-jīngshēn.',
      'Giảng dạy môn ngữ văn trường tiểu học và trung học không chỉ giúp học sinh nắm vững chữ nghĩa ngữ pháp tiếng mẹ đẻ chuẩn mực và kỹ năng đọc hiểu một cách có hệ thống, mà còn có thể dẫn dắt học sinh cảm nhận sâu sắc sự uyên thâm bác đại của nền văn học truyền thống Trung Hoa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中小学语文课程教学不仅系统帮助学生掌握母语规范字词与阅读技巧，更能引导学生深刻领略中华传统文学的博大精深。', 'Zhōng-xiǎoxué yǔwén kèchéng jiàoxué bùjǐn xìtǒng bāngzhù xuéshēng zhǎngwò mǔyǔ guīfàn zìcí yǔ yuèdú jìqiǎo, gèng néng yǐndǎo xuéshēng shēnkè lǐnglüè Zhōnghuá chuántǒng wénxué de bódà-jīngshēn.', 'Giảng dạy môn ngữ văn trường tiểu học và trung học không chỉ giúp học sinh nắm vững chữ nghĩa ngữ pháp tiếng mẹ đẻ chuẩn mực và kỹ năng đọc hiểu một cách có hệ thống, mà còn có thể dẫn dắt học sinh cảm nhận sâu sắc sự uyên thâm bác đại của nền văn học truyền thống Trung Hoa.', 'basic', 1),
      (v_id, '基础教育新课程标准紧扣语文核心素养培育体系，全面强化青少年在真实多样生活情境中的思辨性阅读、跨媒介表达与文学鉴赏素养。', 'Jīchǔ jiàoyù xīn kèchéng biāozhǔn jǐnkòu yǔwén héxīn sùyǎng péiyù tǐxì, quánmiàn qiánghuà qīngshàonián zài zhēnshí duōyàng shēnghuó qíngjìng zhōng de sībiànxìng yuèdú, kuà-méijiè biǎodá yǔ wénxué jiànshǎng sùyǎng.', 'Chuẩn chương trình giáo dục phổ thông mới bám sát hệ thống bồi dưỡng phẩm chất cốt lõi môn ngữ văn, tăng cường toàn diện năng lực đọc hiểu tư duy phản biện, diễn đạt đa phương tiện và phẩm chất thưởng thức văn học của thanh thiếu niên trong các bối cảnh đời sống thực tế đa dạng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3420] [语音] (yǔyīn) - ngữ âm, âm thanh tiếng nói, giọng nói [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '语音' AND pinyin = 'yǔyīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '语音' AND pinyin = 'yǔyīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '语音'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '语音'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǔyīn',
      meaning_vi = 'ngữ âm, âm thanh tiếng nói, giọng nói',
      example_hanzi = '这款最新研发的多语言在线翻译软件内置高精度声学模型，能够毫秒级准确识别用户的语音输入并输出流畅的翻译结果。',
      example_pinyin = 'Zhè kuǎn zuìxīn yánfā de duō yǔyán zàixiàn fānyì ruǎnjiàn nèizhì gāojīngdù shēngxué móxíng, nénggòu háomiǎojí zhǔnquè shíbié yònghù de yǔyīn shūrù bìng shūchū liúchàng de fānyì jiéguǒ.',
      example_vi = 'Phần mềm dịch thuật trực tuyến đa ngôn ngữ mới nghiên cứu phát triển này tích hợp mô hình âm học độ chính xác cao, có thể nhận dạng chuẩn xác đầu vào giọng nói của người dùng ở cấp độ mili giây và cho ra kết quả dịch thuật trôi chảy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '语音',
      'yǔyīn',
      'ngữ âm, âm thanh tiếng nói, giọng nói',
      'Danh từ',
      'HSK 5',
      '这款最新研发的多语言在线翻译软件内置高精度声学模型，能够毫秒级准确识别用户的语音输入并输出流畅的翻译结果。',
      'Zhè kuǎn zuìxīn yánfā de duō yǔyán zàixiàn fānyì ruǎnjiàn nèizhì gāojīngdù shēngxué móxíng, nénggòu háomiǎojí zhǔnquè shíbié yònghù de yǔyīn shūrù bìng shūchū liúchàng de fānyì jiéguǒ.',
      'Phần mềm dịch thuật trực tuyến đa ngôn ngữ mới nghiên cứu phát triển này tích hợp mô hình âm học độ chính xác cao, có thể nhận dạng chuẩn xác đầu vào giọng nói của người dùng ở cấp độ mili giây và cho ra kết quả dịch thuật trôi chảy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这款最新研发的多语言在线翻译软件内置高精度声学模型，能够毫秒级准确识别用户的语音输入并输出流畅的翻译结果。', 'Zhè kuǎn zuìxīn yánfā de duō yǔyán zàixiàn fānyì ruǎnjiàn nèizhì gāojīngdù shēngxué móxíng, nénggòu háomiǎojí zhǔnquè shíbié yònghù de yǔyīn shūrù bìng shūchū liúchàng de fānyì jiéguǒ.', 'Phần mềm dịch thuật trực tuyến đa ngôn ngữ mới nghiên cứu phát triển này tích hợp mô hình âm học độ chính xác cao, có thể nhận dạng chuẩn xác đầu vào giọng nói của người dùng ở cấp độ mili giây và cho ra kết quả dịch thuật trôi chảy.', 'basic', 1),
      (v_id, '端到端多模态大模型深度融合全双工实时语音交互与情感副语言感知算法，赋能新一代具身智能机器人实现高度拟人化的自然语音对话。', 'Duāndàoduān duōmótài dà móxíng shēndù rónghé quán-shuānggōng shíshí yǔyīn jiāohù yǔ qínggǎn fù-yǔyán gǎnzhī suànfǎ, fùnéng xīnyīdài jùshēn zhìnéng jīqìrén shíxiàn gāodù nǐrénhuà de zìrán yǔyīn duìhuà.', 'Mô hình lớn đa phương thức từ đầu đến cuối tích hợp sâu rộng thuật toán tương tác giọng nói thời gian thực song công toàn phần và cảm nhận cận ngôn ngữ cảm xúc, tiếp sức cho thế hệ robot thông minh hiện thân mới thực hiện các cuộc đối thoại giọng nói tự nhiên có tính mô phỏng con người cao độ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3421] [预报] (yùbào) - dự báo; bản tin dự báo [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '预报' AND pinyin = 'yùbào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预报' AND pinyin = 'yùbào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '预报'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预报'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yùbào',
      meaning_vi = 'dự báo; bản tin dự báo',
      example_hanzi = '出门前打开手机查看权威天气预报，根据气象台发布的降雨概率与气温提示及时携带雨具增减衣服，是良好的生活习惯。',
      example_pinyin = 'Chūmén qián dǎkāi shǒujī chákàn quánwēi tiānqì yùbào, gēnjù qìxiàngtái fābù de jiàngyǔ gàilǜ yǔ qìwēn tíshì jíshí xiédài yǔjù zēng-jiǎn yīfu, shì liánghǎo de shēnghuó xíguàn.',
      example_vi = 'Trước khi ra ngoài mở điện thoại xem bản tin dự báo thời tiết chuẩn xác, căn cứ vào xác suất mưa và nhiệt độ do đài khí tượng công bố để kịp thời mang theo áo mưa và mặc thêm bớt áo là một thói quen tốt trong cuộc sống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '预报',
      'yùbào',
      'dự báo; bản tin dự báo',
      'Động từ / Danh từ',
      'HSK 5',
      '出门前打开手机查看权威天气预报，根据气象台发布的降雨概率与气温提示及时携带雨具增减衣服，是良好的生活习惯。',
      'Chūmén qián dǎkāi shǒujī chákàn quánwēi tiānqì yùbào, gēnjù qìxiàngtái fābù de jiàngyǔ gàilǜ yǔ qìwēn tíshì jíshí xiédài yǔjù zēng-jiǎn yīfu, shì liánghǎo de shēnghuó xíguàn.',
      'Trước khi ra ngoài mở điện thoại xem bản tin dự báo thời tiết chuẩn xác, căn cứ vào xác suất mưa và nhiệt độ do đài khí tượng công bố để kịp thời mang theo áo mưa và mặc thêm bớt áo là một thói quen tốt trong cuộc sống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门前打开手机查看权威天气预报，根据气象台发布的降雨概率与气温提示及时携带雨具增减衣服，是良好的生活习惯。', 'Chūmén qián dǎkāi shǒujī chákàn quánwēi tiānqì yùbào, gēnjù qìxiàngtái fābù de jiàngyǔ gàilǜ yǔ qìwēn tíshì jíshí xiédài yǔjù zēng-jiǎn yīfu, shì liánghǎo de shēnghuó xíguàn.', 'Trước khi ra ngoài mở điện thoại xem bản tin dự báo thời tiết chuẩn xác, căn cứ vào xác suất mưa và nhiệt độ do đài khí tượng công bố để kịp thời mang theo áo mưa và mặc thêm bớt áo là một thói quen tốt trong cuộc sống.', 'basic', 1),
      (v_id, '国家气象中心依托全球数值天气预报超级算力集群与风云气象卫星云图同化算法，实现了对强对流突发灾害天气的公里级精细化网格预报。', 'Guójiā qìxiàng zhōngxīn yītuō quánqiú shùzhí tiānqì yùbào chāojí suànlì jíqún yǔ Fēngyún qìxiàng wèixīng yúntú tónghuà suànfǎ, shíxiàn le duì qiáng-duìliú tūfā zāihài tiānqì de gōnglǐjí jīngxìhuà wǎnggé yùbào.', 'Trung tâm khí tượng quốc gia dựa vào cụm siêu tính toán dự báo thời tiết dạng số toàn cầu và thuật toán đồng hóa ảnh mây vệ tinh khí tượng Phong Vân, đã thực hiện việc dự báo lưới tinh gọn cấp km đối với thời tiết thiên tai đột ngột đối lưu mạnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3422] [预测] (yùcè) - dự trắc, dự đoán, tiên lượng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '预测' AND pinyin = 'yùcè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预测' AND pinyin = 'yùcè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '预测'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预测'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yùcè',
      meaning_vi = 'dự trắc, dự đoán, tiên lượng',
      example_hanzi = '根据历年模拟测试的整体大数据表现，指导教师客观预测该班绝大部分同学在高考中都能达到理想的高校录取分数线。',
      example_pinyin = 'Gēnjù lìnián mónǐ cèshì de zhěngtǐ dàshùjù biǎoxiàn, zhǐdǎo jiàoshī kèguān yùcè gāi bān juédà-bùfen tóngxué zài gāokǎo zhōng dōu néng dádào lǐxiǎng de gāoxiào lùqǔ fēnshùxiàn.',
      example_vi = 'Căn cứ vào biểu hiện dữ liệu lớn tổng thể của các kỳ thi thử qua các năm, giáo viên hướng dẫn dự đoán khách quan rằng phần lớn các bạn học sinh trong lớp đều có thể đạt tới điểm chuẩn xét tuyển của trường đại học lý tưởng trong kỳ thi đại học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '预测',
      'yùcè',
      'dự trắc, dự đoán, tiên lượng',
      'Động từ / Danh từ',
      'HSK 5',
      '根据历年模拟测试的整体大数据表现，指导教师客观预测该班绝大部分同学在高考中都能达到理想的高校录取分数线。',
      'Gēnjù lìnián mónǐ cèshì de zhěngtǐ dàshùjù biǎoxiàn, zhǐdǎo jiàoshī kèguān yùcè gāi bān juédà-bùfen tóngxué zài gāokǎo zhōng dōu néng dádào lǐxiǎng de gāoxiào lùqǔ fēnshùxiàn.',
      'Căn cứ vào biểu hiện dữ liệu lớn tổng thể của các kỳ thi thử qua các năm, giáo viên hướng dẫn dự đoán khách quan rằng phần lớn các bạn học sinh trong lớp đều có thể đạt tới điểm chuẩn xét tuyển của trường đại học lý tưởng trong kỳ thi đại học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '根据历年模拟测试的整体大数据表现，指导教师客观预测该班绝大部分同学在高考中都能达到理想的高校录取分数线。', 'Gēnjù lìnián mónǐ cèshì de zhěngtǐ dàshùjù biǎoxiàn, zhǐdǎo jiàoshī kèguān yùcè gāi bān juédà-bùfen tóngxué zài gāokǎo zhōng dōu néng dádào lǐxiǎng de gāoxiào lùqǔ fēnshùxiàn.', 'Căn cứ vào biểu hiện dữ liệu lớn tổng thể của các kỳ thi thử qua các năm, giáo viên hướng dẫn dự đoán khách quan rằng phần lớn các bạn học sinh trong lớp đều có thể đạt tới điểm chuẩn xét tuyển của trường đại học lý tưởng trong kỳ thi đại học.', 'basic', 1),
      (v_id, '国际宏观经济计量监测模型通过系统拟合跨国进出口关税弹性与工业投资景气指数，高度精准预测全球半导体产业链周期的下行拐点。', 'Guójì hóngguān jīngjì jìliàng jiāncè móxíng tōngguò xìtǒng nǐhé kuàguó jìnchūkǒu guānshuì tánxìng yǔ gōngyè tóuzī jǐngqì zhǐshù, gāodù jīngzhǔn yùcè quánqiú bàndǎotǐ chǎnyèliàn zhōuqī de xiàxíng guǎidiǎn.', 'Mô hình giám sát kinh tế lượng vĩ mô quốc tế thông qua việc khớp nối có hệ thống độ co giãn thuế quan xuất nhập khẩu xuyên quốc gia và chỉ số triển vọng đầu tư công nghiệp, đã dự đoán chính xác cao điểm uốn đi xuống của chu kỳ chuỗi công nghiệp bán dẫn toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3423] [预订] (yùdìng) - đặt trước (phòng, vé, tour du lịch) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '预订' AND pinyin = 'yùdìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预订' AND pinyin = 'yùdìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '预订'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预订'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yùdìng',
      meaning_vi = 'đặt trước (phòng, vé, tour du lịch)',
      example_hanzi = '节假日期间各大热门风景名胜区周边的优质酒店客房十分紧俏，建议有出行计划的游客至少提前两周通过官方平台在线预订房间。',
      example_pinyin = 'Jiérì qījiān gè dà rèmén fēngjǐng míngshèngqū zhōubiān de yōuzhì jiǔdiàn kèfáng shífēn jǐnqiào, jiànyì yǒu chūxíng jìhuà de yóukè zhìshǎo tíqián liǎng zhōu tōngguò guānfāng píngtái zàixiàn yùdìng fángjiān.',
      example_vi = 'Trong các dịp lễ tết, phòng khách sạn chất lượng cao xung quanh các khu danh lam thắng cảnh du lịch nổi tiếng vô cùng khan hiếm, kiến nghị du khách có kế hoạch đi lại nên đặt phòng trực tuyến qua nền tảng chính thức trước ít nhất hai tuần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '预订',
      'yùdìng',
      'đặt trước (phòng, vé, tour du lịch)',
      'Động từ',
      'HSK 5',
      '节假日期间各大热门风景名胜区周边的优质酒店客房十分紧俏，建议有出行计划的游客至少提前两周通过官方平台在线预订房间。',
      'Jiérì qījiān gè dà rèmén fēngjǐng míngshèngqū zhōubiān de yōuzhì jiǔdiàn kèfáng shífēn jǐnqiào, jiànyì yǒu chūxíng jìhuà de yóukè zhìshǎo tíqián liǎng zhōu tōngguò guānfāng píngtái zàixiàn yùdìng fángjiān.',
      'Trong các dịp lễ tết, phòng khách sạn chất lượng cao xung quanh các khu danh lam thắng cảnh du lịch nổi tiếng vô cùng khan hiếm, kiến nghị du khách có kế hoạch đi lại nên đặt phòng trực tuyến qua nền tảng chính thức trước ít nhất hai tuần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '节假日期间各大热门风景名胜区周边的优质酒店客房十分紧俏，建议有出行计划的游客至少提前两周通过官方平台在线预订房间。', 'Jiérì qījiān gè dà rèmén fēngjǐng míngshèngqū zhōubiān de yōuzhì jiǔdiàn kèfáng shífēn jǐnqiào, jiànyì yǒu chūxíng jìhuà de yóukè zhìshǎo tíqián liǎng zhōu tōngguò guānfāng píngtái zàixiàn yùdìng fángjiān.', 'Trong các dịp lễ tết, phòng khách sạn chất lượng cao xung quanh các khu danh lam thắng cảnh du lịch nổi tiếng vô cùng khan hiếm, kiến nghị du khách có kế hoạch đi lại nên đặt phòng trực tuyến qua nền tảng chính thức trước ít nhất hai tuần.', 'basic', 1),
      (v_id, '国际民航联运数字化平台依托全球民航分销系统实现动态多航段无缝联运，为跨大洲旅客提供航班座位精准锁定与行李直挂联运全流程预订服务。', 'Guójì mínháng liányùn shùzìhuà píngtái yītuō quánqiú mínháng fēnxīao xìtǒng shíxiàn dòngtài duō-hángduàn wúfèng liányùn, wèi kuà-dàzhōu lǚkè tígōng hángbān zuòwèi jīngzhǔn suǒdìng yǔ xínglǐ zhíguà liányùn quán-liúchéng yùdìng fúwù.', 'Nền tảng số hóa vận tải liên vận hàng không dân dụng quốc tế dựa trên hệ thống phân phối hàng không toàn cầu thực hiện việc liên vận liền mạch nhiều chặng bay linh hoạt, cung cấp dịch vụ đặt trước toàn quy trình giữ chỗ chuyến bay chuẩn xác và gửi thẳng hành lý liên chặng cho hành khách bay xuyên lục địa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3424] [预防] (yùfáng) - dự phòng, phòng ngừa, phòng tránh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '预防' AND pinyin = 'yùfáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预防' AND pinyin = 'yùfáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '预防'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预防'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yùfáng',
      meaning_vi = 'dự phòng, phòng ngừa, phòng tránh',
      example_hanzi = '保持科学合理的膳食结构、适度规律的体育锻炼并按时规范接种疫苗，是有效预防各类季节性呼吸道传染病的最基础有效手段。',
      example_pinyin = 'Bǎochí kēxué hélǐ de shànshí jiégòu, shìdù guīlǜ de tǐyù duànliàn bìng ànshí guīfàn jiēzhòng yìmáo, shì yǒuxiào yùfáng gè lèi jìjiéxìng hūxīdào chuánrǎnbìng de zuì jīchǔ yǒuxiào shǒuduàn.',
      example_vi = 'Duy trì chế độ ăn uống khoa học hợp lý, tập luyện thể thao điều độ có quy luật và tiêm phòng vắc xin đúng hạn chuẩn mực là biện pháp cơ bản và hữu hiệu nhất để phòng ngừa hiệu quả các bệnh truyền nhiễm đường hô hấp theo mùa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '预防',
      'yùfáng',
      'dự phòng, phòng ngừa, phòng tránh',
      'Động từ',
      'HSK 5',
      '保持科学合理的膳食结构、适度规律的体育锻炼并按时规范接种疫苗，是有效预防各类季节性呼吸道传染病的最基础有效手段。',
      'Bǎochí kēxué hélǐ de shànshí jiégòu, shìdù guīlǜ de tǐyù duànliàn bìng ànshí guīfàn jiēzhòng yìmáo, shì yǒuxiào yùfáng gè lèi jìjiéxìng hūxīdào chuánrǎnbìng de zuì jīchǔ yǒuxiào shǒuduàn.',
      'Duy trì chế độ ăn uống khoa học hợp lý, tập luyện thể thao điều độ có quy luật và tiêm phòng vắc xin đúng hạn chuẩn mực là biện pháp cơ bản và hữu hiệu nhất để phòng ngừa hiệu quả các bệnh truyền nhiễm đường hô hấp theo mùa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '保持科学合理的膳食结构、适度规律的体育锻炼并按时规范接种疫苗，是有效预防各类季节性呼吸道传染病的最基础有效手段。', 'Bǎochí kēxué hélǐ de shànshí jiégòu, shìdù guīlǜ de tǐyù duànliàn bìng ànshí guīfàn jiēzhòng yìmáo, shì yǒuxiào yùfáng gè lèi jìjiéxìng hūxīdào chuánrǎnbìng de zuì jīchǔ yǒuxiào shǒuduàn.', 'Duy trì chế độ ăn uống khoa học hợp lý, tập luyện thể thao điều độ có quy luật và tiêm phòng vắc xin đúng hạn chuẩn mực là biện pháp cơ bản và hữu hiệu nhất để phòng ngừa hiệu quả các bệnh truyền nhiễm đường hô hấp theo mùa.', 'basic', 1),
      (v_id, '国家公共卫生发展战略始终坚持“预防为主、防治结合”根本方针，全面建立健全覆盖城乡基层的重大突发传染病常态化智慧预警与预防控制体系。', 'Guójiā gōnggòng wèishēng fāzhǎn zhànlüè shǐzhōng jiānchí “yùfáng wéizhǔ, fáng-zhì jiéhé” gēnběn fāngzhēn, quánmiàn jiànlì jiànquán fùgài chéng-xiāng jīcéng de zhòngdà tūfā chuánrǎnbìng chángtàihuà zhìhuì yùjǐng yǔ yùfáng kòngzhì tǐxì.', 'Chiến lược phát triển y tế công cộng quốc gia luôn kiên trì phương châm căn bản "lấy phòng ngừa làm trọng, kết hợp phòng và chữa", xây dựng hoàn thiện toàn diện hệ thống cảnh báo thông minh thường thái hóa và kiểm soát phòng ngừa các bệnh truyền nhiễm bùng phát trọng đại bao phủ cơ sở thành thị và nông thôn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3425] [预计] (yùjì) - dự tính, ước tính, dự kiến [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '预计' AND pinyin = 'yùjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预计' AND pinyin = 'yùjì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '预计'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预计'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yùjì',
      meaning_vi = 'dự tính, ước tính, dự kiến',
      example_hanzi = '经过全体工程施工建设人员两年来夜以继日的紧张攻坚，全长二十多公里的跨江高速公路特长隧道预计将于今年年底前全线贯通。',
      example_pinyin = 'Jīngguò quántǐ gōngchéng shīgōng jiànshè rényuán liǎng nián lái yèyǐjìrì de jǐnzhāng gōngjiān, quán cháng èrshí duō gōnglǐ de kuàjiāng gāosù gōnglù tècháng suìdào yùjì jiāng yú jīnnián niándǐ qián quánxiàn guàntōng.',
      example_vi = 'Trải qua hai năm nỗ lực thi công căng thẳng ngày đêm của toàn thể cán bộ công nhân công trình, đường hầm vượt sông siêu dài của tuyến đường cao tốc có tổng chiều dài hơn 20 km dự kiến sẽ thông tuyến toàn bộ trước cuối năm nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '预计',
      'yùjì',
      'dự tính, ước tính, dự kiến',
      'Động từ',
      'HSK 5',
      '经过全体工程施工建设人员两年来夜以继日的紧张攻坚，全长二十多公里的跨江高速公路特长隧道预计将于今年年底前全线贯通。',
      'Jīngguò quántǐ gōngchéng shīgōng jiànshè rényuán liǎng nián lái yèyǐjìrì de jǐnzhāng gōngjiān, quán cháng èrshí duō gōnglǐ de kuàjiāng gāosù gōnglù tècháng suìdào yùjì jiāng yú jīnnián niándǐ qián quánxiàn guàntōng.',
      'Trải qua hai năm nỗ lực thi công căng thẳng ngày đêm của toàn thể cán bộ công nhân công trình, đường hầm vượt sông siêu dài của tuyến đường cao tốc có tổng chiều dài hơn 20 km dự kiến sẽ thông tuyến toàn bộ trước cuối năm nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过全体工程施工建设人员两年来夜以继日的紧张攻坚，全长二十多公里的跨江高速公路特长隧道预计将于今年年底前全线贯通。', 'Jīngguò quántǐ gōngchéng shīgōng jiànshè rényuán liǎng nián lái yèyǐjìrì de jǐnzhāng gōngjiān, quán cháng èrshí duō gōnglǐ de kuàjiāng gāosù gōnglù tècháng suìdào yùjì jiāng yú jīnnián niándǐ qián quánxiàn guàntōng.', 'Trải qua hai năm nỗ lực thi công căng thẳng ngày đêm của toàn thể cán bộ công nhân công trình, đường hầm vượt sông siêu dài của tuyến đường cao tốc có tổng chiều dài hơn 20 km dự kiến sẽ thông tuyến toàn bộ trước cuối năm nay.', 'basic', 1),
      (v_id, '权威国际行业智库最新发布的全球可再生能源发展展望报告预计，未来五年内全球太阳能光伏与海上风电新增装机总量将超过以往十年的累计总和。', 'Quánwēi guójì hángyè zhìkù zuìxīn fābù de quánqiú kězàishēng néngyuán fāzhǎn zhǎnwàng bàogào yùjì, wèilái wǔ nián nèi quánqiú tàiyángnéng guāngfú yǔ hǎishàng fēngdiàn xīn-zēng zhuāngjī zǒngliàng jiāng chāoguò yǐwǎng shí nián de lěijì zǒnghé.', 'Báo cáo triển vọng phát triển năng lượng tái tạo toàn cầu mới nhất do viện nghiên cứu chính sách ngành uy tín quốc tế công bố dự tính, trong vòng 5 năm tới tổng công suất lắp đặt mới của điện mặt trời và điện gió ngoài khơi trên toàn cầu sẽ vượt quá tổng tích lũy của 10 năm trước đó.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3426] [玉米] (yùmǐ) - ngô, bắp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '玉米' AND pinyin = 'yùmǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '玉米' AND pinyin = 'yùmǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '玉米'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '玉米'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yùmǐ',
      meaning_vi = 'ngô, bắp',
      example_hanzi = '秋收时节走进广袤的大粮仓，一眼望不到边的金黄色玉米沉甸甸地挂在秸秆上，田野里洋溢着丰收的喜悦。',
      example_pinyin = 'Qiūshōu shíjié zǒu jìn guǎngmào de dà liángcāng, yī yǎn wàng bù dào biān de jīnhuángsè yùmǐ chéndiàndiàn de guà zài jiēgǎn shàng, tiányě lǐ yángyì zhe fēngshōu de xǐyuè.',
      example_vi = 'Bước vào vựa lúa bạt ngàn trong mùa thu hoạch thu, những bắp ngô màu vàng óng ả trĩu nặng treo trên thân cây nhìn hút tầm mắt, trên đồng ruộng ngập tràn niềm vui được mùa bội thu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '玉米',
      'yùmǐ',
      'ngô, bắp',
      'Danh từ',
      'HSK 5',
      '秋收时节走进广袤的大粮仓，一眼望不到边的金黄色玉米沉甸甸地挂在秸秆上，田野里洋溢着丰收的喜悦。',
      'Qiūshōu shíjié zǒu jìn guǎngmào de dà liángcāng, yī yǎn wàng bù dào biān de jīnhuángsè yùmǐ chéndiàndiàn de guà zài jiēgǎn shàng, tiányě lǐ yángyì zhe fēngshōu de xǐyuè.',
      'Bước vào vựa lúa bạt ngàn trong mùa thu hoạch thu, những bắp ngô màu vàng óng ả trĩu nặng treo trên thân cây nhìn hút tầm mắt, trên đồng ruộng ngập tràn niềm vui được mùa bội thu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '秋收时节走进广袤的大粮仓，一眼望不到边的金黄色玉米沉甸甸地挂在秸秆上，田野里洋溢着丰收的喜悦。', 'Qiūshōu shíjié zǒu jìn guǎngmào de dà liángcāng, yī yǎn wàng bù dào biān de jīnhuángsè yùmǐ chéndiàndiàn de guà zài jiēgǎn shàng, tiányě lǐ yángyì zhe fēngshōu de xǐyuè.', 'Bước vào vựa lúa bạt ngàn trong mùa thu hoạch thu, những bắp ngô màu vàng óng ả trĩu nặng treo trên thân cây nhìn hút tầm mắt, trên đồng ruộng ngập tràn niềm vui được mùa bội thu.', 'basic', 1),
      (v_id, '现代农业生物育种国家重大专项成功攻克耐密植、抗干旱抗倒伏转基因杂交玉米分子设计育种技术，为筑牢国家粮食主粮产能安全屏障提供了核心种源支撑。', 'Xiàndài nóngyè shēngwù yùzhǒng guójiā zhòngdà zhuānxiàng chénggōng gōngkè nài mìzhí, kàng gānhàn kàng dǎofú zhuǎnjīyīn zájiāo yùmǐ fēnzǐ shèjì yùzhǒng jìshù, wèi zhù láo guójiā liángshi zhǔliáng chǎnnéng ānquán píngzhàng tígōng le héxīn zhǒngyuán zhīchēng.', 'Đề án trọng đại quốc gia về chọn tạo giống sinh học nông nghiệp hiện đại đã chinh phục thành công công nghệ chọn giống thiết kế phân tử ngô lai chuyển gen chịu trồng dày, chịu hạn và chống gãy đổ, cung cấp nguồn giống cốt lõi làm điểm tựa đắp vững hàng rào an toàn năng lực sản xuất lương thực chủ lực quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3427] [预约] (yùyuē) - hẹn trước, đặt lịch hẹn, đặt chỗ trước [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '预约' AND pinyin = 'yùyuē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预约' AND pinyin = 'yùyuē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '预约'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '预约'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yùyuē',
      meaning_vi = 'hẹn trước, đặt lịch hẹn, đặt chỗ trước',
      example_hanzi = '如果你打算去那家三甲医院看专科门诊，一定要提前在手机应用程序上进行挂号预约。',
      example_pinyin = 'Rúguǒ nǐ dǎsuàn qù nà jiā sānjiǎ yīyuàn kàn zhuānkē ménzhěn, yídìng yào tíqián zài shǒujī yìngyòng chéngxù shang jìnxíng guàhào yùyuē.',
      example_vi = 'Nếu bạn có ý định đến bệnh viện hạng ba tuyến đầu đó khám chuyên khoa, nhất định phải đặt lịch hẹn đăng ký khám trước trên ứng dụng điện thoại di động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '预约',
      'yùyuē',
      'hẹn trước, đặt lịch hẹn, đặt chỗ trước',
      'Động từ / Danh từ',
      'HSK 5',
      '如果你打算去那家三甲医院看专科门诊，一定要提前在手机应用程序上进行挂号预约。',
      'Rúguǒ nǐ dǎsuàn qù nà jiā sānjiǎ yīyuàn kàn zhuānkē ménzhěn, yídìng yào tíqián zài shǒujī yìngyòng chéngxù shang jìnxíng guàhào yùyuē.',
      'Nếu bạn có ý định đến bệnh viện hạng ba tuyến đầu đó khám chuyên khoa, nhất định phải đặt lịch hẹn đăng ký khám trước trên ứng dụng điện thoại di động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果你打算去那家三甲医院看专科门诊，一定要提前在手机应用程序上进行挂号预约。', 'Rúguǒ nǐ dǎsuàn qù nà jiā sānjiǎ yīyuàn kàn zhuānkē ménzhěn, yídìng yào tíqián zài shǒujī yìngyòng chéngxù shang jìnxíng guàhào yùyuē.', 'Nếu bạn có ý định đến bệnh viện hạng ba tuyến đầu đó khám chuyên khoa, nhất định phải đặt lịch hẹn đăng ký khám trước trên ứng dụng điện thoại di động.', 'basic', 1),
      (v_id, '高端商务会所全面推行实名制高端私密专享预约制度，以确保为跨国企业高管提供安全且高效的洽谈环境。', 'Gāoduān shāngwù huìsuǒ quánmiàn tuīxíng shímíngzhì gāoduān sīmì zhuānxiǎng yùyuē zhìdù, yǐ quèbǎo wèi kuàguó qǐyè gāoguǎn tígōng ānquán qiě gāoxiào de qiàtán huánjìng.', 'Câu lạc bộ thương mại cao cấp triển khai toàn diện chế độ đặt lịch hẹn riêng tư bảo mật danh tính định danh, nhằm bảo đảm cung cấp môi trường đàm phán an toàn và hiệu quả cao cho các nhà quản lý cấp cao của doanh nghiệp đa quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3428] [原] (yuán) - nguyên bản, ban đầu, gốc; bình nguyên [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '原' AND pinyin = 'yuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '原' AND pinyin = 'yuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '原'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '原'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'yuán',
      meaning_vi = 'nguyên bản, ban đầu, gốc; bình nguyên',
      example_hanzi = '由于项目需求发生了紧急变更，我们不得不废弃上个月制定的原设计方案。',
      example_pinyin = 'Yóuyú xiàngmù xūqiú fāshēng le jǐnjí biàngēng, wǒmen bùdébù fèiqì shàng ge yuè zhìdìng de yuán shèjì fāng''àn.',
      example_vi = 'Do nhu cầu dự án phát sinh thay đổi khẩn cấp, chúng tôi buộc phải hủy bỏ phương án thiết kế ban đầu đã xây dựng từ tháng trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '原',
      'yuán',
      'nguyên bản, ban đầu, gốc; bình nguyên',
      'Tính từ / Danh từ',
      'HSK 5',
      '由于项目需求发生了紧急变更，我们不得不废弃上个月制定的原设计方案。',
      'Yóuyú xiàngmù xūqiú fāshēng le jǐnjí biàngēng, wǒmen bùdébù fèiqì shàng ge yuè zhìdìng de yuán shèjì fāng''àn.',
      'Do nhu cầu dự án phát sinh thay đổi khẩn cấp, chúng tôi buộc phải hủy bỏ phương án thiết kế ban đầu đã xây dựng từ tháng trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '由于项目需求发生了紧急变更，我们不得不废弃上个月制定的原设计方案。', 'Yóuyú xiàngmù xūqiú fāshēng le jǐnjí biàngēng, wǒmen bùdébù fèiqì shàng ge yuè zhìdìng de yuán shèjì fāng''àn.', 'Do nhu cầu dự án phát sinh thay đổi khẩn cấp, chúng tôi buộc phải hủy bỏ phương án thiết kế ban đầu đã xây dựng từ tháng trước.', 'basic', 1),
      (v_id, '分子遗传学实验证实，该稀有植物种群保留了大量未经人工杂交的野生原生态优良基因组特征。', 'Fēnzǐ yíchuánxué shíyàn zhèngshí, gāi xīyǒu zhíwù zhǒngqún bǎoliú le dàliàng wèijīng réngōng zájiāo de yěshēng yuán-shēngtài yōuliáng jīyīnzǔ tèzhēng.', 'Thí nghiệm di truyền học phân tử đã xác nhận rằng quần thể thực vật quý hiếm này vẫn lưu giữ một lượng lớn đặc trưng bộ gen ưu lương nguyên sinh thái hoang dã chưa từng trải qua lai tạo nhân tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3429] [圆] (yuán) - tròn, hình tròn, trọn vẹn, viên mãn [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '圆' AND pinyin = 'yuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '圆' AND pinyin = 'yuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '圆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '圆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'yuán',
      meaning_vi = 'tròn, hình tròn, trọn vẹn, viên mãn',
      example_hanzi = '中秋节的夜晚，一家人围坐在院子里一边欣赏皎洁的圆月，一边品尝美味的月饼。',
      example_pinyin = 'Zhōngqiūjié de yèwǎn, yìjiārén wéizuò zài yuànzi lǐ yìbiān xīnshǎng jiǎojié de yuányuè, yìbiān pǐncháng měiwèi de yuèbǐng.',
      example_vi = 'Đêm Tết Trung thu, cả gia đình quây quần ngồi trong sân vừa ngắm vầng trăng tròn vằng vặc vừa thưởng thức bánh trung thu thơm ngon.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '圆',
      'yuán',
      'tròn, hình tròn, trọn vẹn, viên mãn',
      'Tính từ / Danh từ',
      'HSK 5',
      '中秋节的夜晚，一家人围坐在院子里一边欣赏皎洁的圆月，一边品尝美味的月饼。',
      'Zhōngqiūjié de yèwǎn, yìjiārén wéizuò zài yuànzi lǐ yìbiān xīnshǎng jiǎojié de yuányuè, yìbiān pǐncháng měiwèi de yuèbǐng.',
      'Đêm Tết Trung thu, cả gia đình quây quần ngồi trong sân vừa ngắm vầng trăng tròn vằng vặc vừa thưởng thức bánh trung thu thơm ngon.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中秋节的夜晚，一家人围坐在院子里一边欣赏皎洁的圆月，一边品尝美味的月饼。', 'Zhōngqiūjié de yèwǎn, yìjiārén wéizuò zài yuànzi lǐ yìbiān xīnshǎng jiǎojié de yuányuè, yìbiān pǐncháng měiwèi de yuèbǐng.', 'Đêm Tết Trung thu, cả gia đình quây quần ngồi trong sân vừa ngắm vầng trăng tròn vằng vặc vừa thưởng thức bánh trung thu thơm ngon.', 'basic', 1),
      (v_id, '经过长达三轮艰难的跨国商务谈判，双方代表终于就关键条款达成共识，使合作项目画上了圆满的句号。', 'Jīngguò chángdá sān lún jiānnán de kuàguó shāngwù tánpàn, shuāngfāng dàibiǎo zhōngyú jiù guānjiàn tiáokuǎn dáchéng gòngshí, shǐ hézuò xiàngmù huà shàng le yuánmǎn de jùhào.', 'Trải qua ba vòng đàm phán thương mại xuyên quốc gia kéo dài và gian nan, đại diện hai bên rốt cuộc đã đạt được đồng thuận về các điều khoản then chốt, đặt dấu chấm hết trọn vẹn viên mãn cho dự án hợp tác.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3430] [原有] (yuányǒu) - vốn có, sẵn có, nguyên có [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '原有' AND pinyin = 'yuányǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '原有' AND pinyin = 'yuányǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '原有'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '原有'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'yuányǒu',
      meaning_vi = 'vốn có, sẵn có, nguyên có',
      example_hanzi = '为了满足广大市民的休闲运动需求，市政部门决定在原有公园绿地的基础上扩建跑道。',
      example_pinyin = 'Wèile mǎnzú guǎngdà shìmín de xiūxián yùndòng xūqiú, shìzhèng bùmén juédìng zài yuányǒu gōngyuán lǜdì de jīchǔ shang kuòjiàn pǎodào.',
      example_vi = 'Để đáp ứng nhu cầu tập luyện thể thao giải trí của đông đảo người dân, cơ quan quản lý đô thị đã quyết định mở rộng đường chạy trên cơ sở mảng xanh công viên vốn có.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '原有',
      'yuányǒu',
      'vốn có, sẵn có, nguyên có',
      'Tính từ / Động từ',
      'HSK 5',
      '为了满足广大市民的休闲运动需求，市政部门决定在原有公园绿地的基础上扩建跑道。',
      'Wèile mǎnzú guǎngdà shìmín de xiūxián yùndòng xūqiú, shìzhèng bùmén juédìng zài yuányǒu gōngyuán lǜdì de jīchǔ shang kuòjiàn pǎodào.',
      'Để đáp ứng nhu cầu tập luyện thể thao giải trí của đông đảo người dân, cơ quan quản lý đô thị đã quyết định mở rộng đường chạy trên cơ sở mảng xanh công viên vốn có.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了满足广大市民的休闲运动需求，市政部门决定在原有公园绿地的基础上扩建跑道。', 'Wèile mǎnzú guǎngdà shìmín de xiūxián yùndòng xūqiú, shìzhèng bùmén juédìng zài yuányǒu gōngyuán lǜdì de jīchǔ shang kuòjiàn pǎodào.', 'Để đáp ứng nhu cầu tập luyện thể thao giải trí của đông đảo người dân, cơ quan quản lý đô thị đã quyết định mở rộng đường chạy trên cơ sở mảng xanh công viên vốn có.', 'basic', 1),
      (v_id, '产业数字化转型不是彻底推翻原有实体工业体系，而是通过新一代信息技术对其进行全方位重塑与赋能。', 'Chǎnyè shùzìhuà zhuǎnxíng bú shì chèdǐ tuīfān yuányǒu shítǐ gōngyè tǐxì, ér shì tōngguò xīn-yídài xìnxī jìshù duì qí jìnxíng quán-fāngwèi chóngsù yǔ fùnéng.', 'Chuyển đổi số công nghiệp không phải là lật đổ hoàn toàn hệ thống công nghiệp thực thể vốn có, mà là thông qua công nghệ thông tin thế hệ mới để tái định hình và tiếp thêm sức mạnh toàn diện cho hệ thống đó.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3431] [元旦] (Yuándàn) - Tết Dương lịch, ngày đầu năm mới [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '元旦' AND pinyin = 'Yuándàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '元旦' AND pinyin = 'Yuándàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '元旦'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '元旦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'Yuándàn',
      meaning_vi = 'Tết Dương lịch, ngày đầu năm mới',
      example_hanzi = '元旦假期的第一天早晨，大街小巷都挂满了鲜艳的红旗和漂亮的彩灯，洋溢着节日的喜庆气氛。',
      example_pinyin = 'Yuándàn jiàqī de dì-yī tiān zǎochén, dàjiē-xiǎoxiàng dōu guà mǎn le xiānyàn de hóngqí hé piàoliang de cǎidēng, yángyì zhe jiérì de xǐqìng qìfēn.',
      example_vi = 'Sáng ngày đầu tiên của kỳ nghỉ Tết Dương lịch, khắp phố lớn ngõ nhỏ đều treo đầy cờ đỏ rực rỡ và đèn lồng hoa lệ, ngập tràn bầu không khí hân hoan của ngày lễ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '元旦',
      'Yuándàn',
      'Tết Dương lịch, ngày đầu năm mới',
      'Danh từ',
      'HSK 5',
      '元旦假期的第一天早晨，大街小巷都挂满了鲜艳的红旗和漂亮的彩灯，洋溢着节日的喜庆气氛。',
      'Yuándàn jiàqī de dì-yī tiān zǎochén, dàjiē-xiǎoxiàng dōu guà mǎn le xiānyàn de hóngqí hé piàoliang de cǎidēng, yángyì zhe jiérì de xǐqìng qìfēn.',
      'Sáng ngày đầu tiên của kỳ nghỉ Tết Dương lịch, khắp phố lớn ngõ nhỏ đều treo đầy cờ đỏ rực rỡ và đèn lồng hoa lệ, ngập tràn bầu không khí hân hoan của ngày lễ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '元旦假期的第一天早晨，大街小巷都挂满了鲜艳的红旗和漂亮的彩灯，洋溢着节日的喜庆气氛。', 'Yuándàn jiàqī de dì-yī tiān zǎochén, dàjiē-xiǎoxiàng dōu guà mǎn le xiānyàn de hóngqí hé piàoliang de cǎidēng, yángyì zhe jiérì de xǐqìng qìfēn.', 'Sáng ngày đầu tiên của kỳ nghỉ Tết Dương lịch, khắp phố lớn ngõ nhỏ đều treo đầy cờ đỏ rực rỡ và đèn lồng hoa lệ, ngập tràn bầu không khí hân hoan của ngày lễ.', 'basic', 1),
      (v_id, '国家统计局公布的元旦假期消费监测数据显示，文旅演艺、主题餐饮与冰雪旅游等文旅板块呈现强劲复苏势头。', 'Guójiā tǒngjìjú gōngbù de Yuándàn jiàqī xiāofèi jiāncè shùjù xiǎnshì, wénlǚ yǎnyì, zhǔtí cānyǐn yǔ bīngxuě lǚyóu děng wénlǚ bǎnkuài chéngxiàn qiángjìn fùsū shìtóu.', 'Số liệu giám sát tiêu dùng kỳ nghỉ Tết Dương lịch do Cục Thống kê Quốc gia công bố cho thấy các phân khúc văn hóa du lịch như biểu diễn nghệ thuật, ẩm thực chủ đề và du lịch băng tuyết thể hiện đà phục hồi mạnh mẽ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3432] [员工] (yuángōng) - nhân viên, cán bộ công nhân viên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '员工' AND pinyin = 'yuángōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '员工' AND pinyin = 'yuángōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '员工'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '员工'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yuángōng',
      meaning_vi = 'nhân viên, cán bộ công nhân viên',
      example_hanzi = '为了激发全体员工的工作积极性，公司管理层决定在年底设立优秀员工特别表彰奖项。',
      example_pinyin = 'Wèile jīfā quántǐ yuángōng de gōngzuò jījíxìng, gōngsī guǎnlǐcéng juédìng zài niándǐ shèlì yōuxiù yuángōng tèbié biǎozhāng jiǎngxiàng.',
      example_vi = 'Để khơi dậy tính tích cực làm việc của toàn thể nhân viên, ban lãnh đạo công ty đã quyết định thiết lập giải thưởng biểu dương đặc biệt dành cho nhân viên xuất sắc vào cuối năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '员工',
      'yuángōng',
      'nhân viên, cán bộ công nhân viên',
      'Danh từ',
      'HSK 5',
      '为了激发全体员工的工作积极性，公司管理层决定在年底设立优秀员工特别表彰奖项。',
      'Wèile jīfā quántǐ yuángōng de gōngzuò jījíxìng, gōngsī guǎnlǐcéng juédìng zài niándǐ shèlì yōuxiù yuángōng tèbié biǎozhāng jiǎngxiàng.',
      'Để khơi dậy tính tích cực làm việc của toàn thể nhân viên, ban lãnh đạo công ty đã quyết định thiết lập giải thưởng biểu dương đặc biệt dành cho nhân viên xuất sắc vào cuối năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了激发全体员工的工作积极性，公司管理层决定在年底设立优秀员工特别表彰奖项。', 'Wèile jīfā quántǐ yuángōng de gōngzuò jījíxìng, gōngsī guǎnlǐcéng juédìng zài niándǐ shèlì yōuxiù yuángōng tèbié biǎozhāng jiǎngxiàng.', 'Để khơi dậy tính tích cực làm việc của toàn thể nhân viên, ban lãnh đạo công ty đã quyết định thiết lập giải thưởng biểu dương đặc biệt dành cho nhân viên xuất sắc vào cuối năm.', 'basic', 1),
      (v_id, '集团人力资源战略委员会建立了覆盖员工全职业生涯发展周期的技能培训与敏捷晋升双通道评估机制。', 'Jítuán rénlì zīyuán zhànlüè wěiyuánhuì jiànlì le fùgài yuángōng quán zhíyè shēngyá fāzhǎn zhōuqī de jìnéng péixùn yǔ mǐnjié jìnshēng shuāng-tōngdào pínggū jīzhì.', 'Hội đồng chiến lược nhân sự của tập đoàn đã thiết lập cơ chế đánh giá song lộ trình thăng tiến linh hoạt và đào tạo kỹ năng bao phủ toàn bộ vòng đời phát triển sự nghiệp của nhân viên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3433] [原则] (yuánzé) - nguyên tắc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '原则' AND pinyin = 'yuánzé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '原则' AND pinyin = 'yuánzé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '原则'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '原则'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yuánzé',
      meaning_vi = 'nguyên tắc',
      example_hanzi = '无论在职场中遇到多么棘手的人际关系冲突，我们都要坚持实事求是的基本做人原则。',
      example_pinyin = 'Wúlùn zài zhíchǎng zhōng yù dào duōme jíshǒu de rénjì guānxì chōngtū, wǒmen dōu yào jiānchí shíshì-qiúshì de jīběn zuòrén yuánzé.',
      example_vi = 'Bất luận gặp phải xung đột quan hệ nhân sinh gai góc đến mức nào ở nơi làm việc, chúng ta đều phải kiên trì nguyên tắc làm người cơ bản là cầu thị, tôn trọng sự thật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '原则',
      'yuánzé',
      'nguyên tắc',
      'Danh từ',
      'HSK 5',
      '无论在职场中遇到多么棘手的人际关系冲突，我们都要坚持实事求是的基本做人原则。',
      'Wúlùn zài zhíchǎng zhōng yù dào duōme jíshǒu de rénjì guānxì chōngtū, wǒmen dōu yào jiānchí shíshì-qiúshì de jīběn zuòrén yuánzé.',
      'Bất luận gặp phải xung đột quan hệ nhân sinh gai góc đến mức nào ở nơi làm việc, chúng ta đều phải kiên trì nguyên tắc làm người cơ bản là cầu thị, tôn trọng sự thật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论在职场中遇到多么棘手的人际关系冲突，我们都要坚持实事求是的基本做人原则。', 'Wúlùn zài zhíchǎng zhōng yù dào duōme jíshǒu de rénjì guānxì chōngtū, wǒmen dōu yào jiānchí shíshì-qiúshì de jīběn zuòrén yuánzé.', 'Bất luận gặp phải xung đột quan hệ nhân sinh gai góc đến mức nào ở nơi làm việc, chúng ta đều phải kiên trì nguyên tắc làm người cơ bản là cầu thị, tôn trọng sự thật.', 'basic', 1),
      (v_id, '企业必须严格遵循透明合规、数据最小化以及用户知情同意的法定原则，防范人工智能算法歧视与隐私泄露风险。', 'Qǐyè bìxū yángé zūnxún tòumíng hégūi, shùjù zuìxiǎohuà yǐjí yònghù zhīqíng tóngyì de fǎdìng yuánzé, fángfàn réngōng zhìnéng suànfǎ qíshì yǔ yǐnsī xièlòu fēngxiǎn.', 'Doanh nghiệp bắt buộc phải tuân thủ nghiêm ngặt các nguyên tắc pháp định về minh bạch tuân thủ, tối thiểu hóa dữ liệu và sự đồng ý sau khi được thông báo của người dùng, phòng ngừa rủi ro phân biệt đối xử thuật toán AI và rò rỉ quyền riêng tư.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3434] [愿] (yuàn) - nguyện, mong muốn, sẵn lòng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '愿' AND pinyin = 'yuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '愿' AND pinyin = 'yuàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '愿'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '愿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yuàn',
      meaning_vi = 'nguyện, mong muốn, sẵn lòng',
      example_hanzi = '毕业离别之际，同学们在纪念册上写下最真挚的祝福：愿你历经千帆，归来仍是少年。',
      example_pinyin = 'Bìyè líbié zhī jì, tóngxuémen zài jìniàncè shang xiě xià zuì zhēnzhì de zhùfú: Yuàn nǐ lì jīng qiān fān, guīlái réng shì shàonián.',
      example_vi = 'Thời khắc chia tay tốt nghiệp, các bạn học cùng viết lại lời chúc chân thành nhất trên lưu bút: Nguyện chúc bạn trải qua muôn vàn cánh buồm sóng gió, khi trở về vẫn giữ trọn nét trẻ trung nhiệt huyết ngày nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '愿',
      'yuàn',
      'nguyện, mong muốn, sẵn lòng',
      'Động từ',
      'HSK 5',
      '毕业离别之际，同学们在纪念册上写下最真挚的祝福：愿你历经千帆，归来仍是少年。',
      'Bìyè líbié zhī jì, tóngxuémen zài jìniàncè shang xiě xià zuì zhēnzhì de zhùfú: Yuàn nǐ lì jīng qiān fān, guīlái réng shì shàonián.',
      'Thời khắc chia tay tốt nghiệp, các bạn học cùng viết lại lời chúc chân thành nhất trên lưu bút: Nguyện chúc bạn trải qua muôn vàn cánh buồm sóng gió, khi trở về vẫn giữ trọn nét trẻ trung nhiệt huyết ngày nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '毕业离别之际，同学们在纪念册上写下最真挚的祝福：愿你历经千帆，归来仍是少年。', 'Bìyè líbié zhī jì, tóngxuémen zài jìniàncè shang xiě xià zuì zhēnzhì de zhùfú: Yuàn nǐ lì jīng qiān fān, guīlái réng shì shàonián.', 'Thời khắc chia tay tốt nghiệp, các bạn học cùng viết lại lời chúc chân thành nhất trên lưu bút: Nguyện chúc bạn trải qua muôn vàn cánh buồm sóng gió, khi trở về vẫn giữ trọn nét trẻ trung nhiệt huyết ngày nào.', 'basic', 1),
      (v_id, '只要双方具备互利共赢的诚意，我方愿与贵国科研机构在深海勘探与绿色低碳能源领域开展全方位务实合作。', 'Zhǐyào shuāngfāng jùbèi hùlì gòngyíng de chéngyì, wǒfāng yuàn yǔ guìguó kēyán jīgòu zài shēnhǎi kāntàn yǔ lǜsè dītàn néngyuán lǐngyù kāizhǎn quán-fāngwèi wùshí hézuò.', 'Chỉ cần hai bên có thiện chí đôi bên cùng có lợi, phía chúng tôi sẵn lòng triển khai hợp tác thực chất toàn diện với cơ quan nghiên cứu khoa học của quý quốc trong các lĩnh vực thăm dò biển sâu và năng lượng carbon thấp xanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3435] [愿望] (yuànwàng) - nguyện vọng, ước mơ, mong ước [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '愿望' AND pinyin = 'yuànwàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '愿望' AND pinyin = 'yuànwàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '愿望'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '愿望'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yuànwàng',
      meaning_vi = 'nguyện vọng, ước mơ, mong ước',
      example_hanzi = '经过连续三年的勤奋备考，他终于实现了考入理想重点大学计算机科学系的强烈愿望。',
      example_pinyin = 'Jīngguò liánxù sān nián de qínfèn bèikǎo, tā zhōngyú shíxiàn le kǎorù lǐxiǎng zhòngdiǎn dàxué jìsuànjī kēxué xì de qiángliè yuànwàng.',
      example_vi = 'Trải qua ba năm liên tục ôn thi cần cù, anh ấy cuối cùng đã thực hiện được nguyện vọng cháy bỏng là đỗ vào khoa khoa học máy tính của trường đại học trọng điểm mơ ước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '愿望',
      'yuànwàng',
      'nguyện vọng, ước mơ, mong ước',
      'Danh từ',
      'HSK 5',
      '经过连续三年的勤奋备考，他终于实现了考入理想重点大学计算机科学系的强烈愿望。',
      'Jīngguò liánxù sān nián de qínfèn bèikǎo, tā zhōngyú shíxiàn le kǎorù lǐxiǎng zhòngdiǎn dàxué jìsuànjī kēxué xì de qiángliè yuànwàng.',
      'Trải qua ba năm liên tục ôn thi cần cù, anh ấy cuối cùng đã thực hiện được nguyện vọng cháy bỏng là đỗ vào khoa khoa học máy tính của trường đại học trọng điểm mơ ước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过连续三年的勤奋备考，他终于实现了考入理想重点大学计算机科学系的强烈愿望。', 'Jīngguò liánxù sān nián de qínfèn bèikǎo, tā zhōngyú shíxiàn le kǎorù lǐxiǎng zhòngdiǎn dàxué jìsuànjī kēxué xì de qiángliè yuànwàng.', 'Trải qua ba năm liên tục ôn thi cần cù, anh ấy cuối cùng đã thực hiện được nguyện vọng cháy bỏng là đỗ vào khoa khoa học máy tính của trường đại học trọng điểm mơ ước.', 'basic', 1),
      (v_id, '消除贫困并实现社会公平正义，是人类自古以来追求美好和平生活的共同崇高愿望。', 'Xiāochú pínkùn bìng shíxiàn shèhuì gōngpíng zhèngyì, shì rénlèi zìgǔ yǐlái zhuīqiú měihǎo hépíng shēnghuó de gòngtóng chónggāo yuànwàng.', 'Xóa bỏ đói nghèo và hiện thực hóa công bằng chính trực xã hội là nguyện vọng cao cả chung của nhân loại từ xưa đến nay trong hành trình mưu cầu cuộc sống hòa bình tươi đẹp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3436] [约定] (yuēdìng) - hẹn ước, quy ước, thỏa thuận [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '约定' AND pinyin = 'yuēdìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '约定' AND pinyin = 'yuēdìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '约定'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '约定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yuēdìng',
      meaning_vi = 'hẹn ước, quy ước, thỏa thuận',
      example_hanzi = '我和几位大学老同学约定好，每个周六下午都在市中心的体育馆一起打羽毛球健身。',
      example_pinyin = 'Wǒ hé jǐ wèi dàxué lǎo tóngxué yuēdìng hǎo, měi ge zhōuliù xiàwǔ dōu zài shìzhōngxīn de tǐyùguǎn yìqǐ dǎ yǔmáoqiú jiànshēn.',
      example_vi = 'Tôi và mấy người bạn đại học cũ đã thỏa thuận hẹn nhau, mỗi chiều thứ Bảy đều đến nhà thi đấu ở trung tâm thành phố để cùng chơi cầu lông rèn luyện sức khỏe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '约定',
      'yuēdìng',
      'hẹn ước, quy ước, thỏa thuận',
      'Động từ / Danh từ',
      'HSK 5',
      '我和几位大学老同学约定好，每个周六下午都在市中心的体育馆一起打羽毛球健身。',
      'Wǒ hé jǐ wèi dàxué lǎo tóngxué yuēdìng hǎo, měi ge zhōuliù xiàwǔ dōu zài shìzhōngxīn de tǐyùguǎn yìqǐ dǎ yǔmáoqiú jiànshēn.',
      'Tôi và mấy người bạn đại học cũ đã thỏa thuận hẹn nhau, mỗi chiều thứ Bảy đều đến nhà thi đấu ở trung tâm thành phố để cùng chơi cầu lông rèn luyện sức khỏe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我和几位大学老同学约定好，每个周六下午都在市中心的体育馆一起打羽毛球健身。', 'Wǒ hé jǐ wèi dàxué lǎo tóngxué yuēdìng hǎo, měi ge zhōuliù xiàwǔ dōu zài shìzhōngxīn de tǐyùguǎn yìqǐ dǎ yǔmáoqiú jiànshēn.', 'Tôi và mấy người bạn đại học cũ đã thỏa thuận hẹn nhau, mỗi chiều thứ Bảy đều đến nhà thi đấu ở trung tâm thành phố để cùng chơi cầu lông rèn luyện sức khỏe.', 'basic', 1),
      (v_id, '合同双方未就知识产权归属作出明确约定的，受托人交付的研发成果知识产权依法推定归受托方所有。', 'Hétong shuāngfāng wèi jiù zhīshi chǎnquán guīshǔ zuòchū míngquè yuēdìng de, shòutuōrén jiāofù de yánfā chéngguǒ zhīshi chǎnquán yīfǎ tuīdìng guī shòutuōfāng suǒyǒu.', 'Trường hợp các bên trong hợp đồng không đưa ra thỏa thuận rõ ràng về quyền sở hữu quyền sở hữu trí tuệ, quyền sở hữu trí tuệ đối với thành quả nghiên cứu phát triển do bên nhận ủy thác bàn giao được suy đoán theo pháp luật là thuộc về bên nhận ủy thác.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3437] [运] (yùn) - vận chuyển, vận hành; vận may, thời vận [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '运' AND pinyin = 'yùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运' AND pinyin = 'yùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '运'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yùn',
      meaning_vi = 'vận chuyển, vận hành; vận may, thời vận',
      example_hanzi = '工人们正在码头上忙碌地将成箱的新鲜热带水果从大型货船上卸下并运往冷链仓库。',
      example_pinyin = 'Gōngrénmen zhèngzài mǎtou shang mánglù de jiāng chéng xiāng de xīnxiān rèdài shuǐguǒ cóng dàxíng huòchuán shang xiè xià bìng yùn wǎng lěngliàn cāngkù.',
      example_vi = 'Các công nhân đang tất bật bốc dỡ từng thùng hoa quả nhiệt đới tươi ngon từ tàu chở hàng cỡ lớn xuống bến cảng và vận chuyển vào kho chuỗi cung ứng lạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '运',
      'yùn',
      'vận chuyển, vận hành; vận may, thời vận',
      'Động từ / Danh từ',
      'HSK 5',
      '工人们正在码头上忙碌地将成箱的新鲜热带水果从大型货船上卸下并运往冷链仓库。',
      'Gōngrénmen zhèngzài mǎtou shang mánglù de jiāng chéng xiāng de xīnxiān rèdài shuǐguǒ cóng dàxíng huòchuán shang xiè xià bìng yùn wǎng lěngliàn cāngkù.',
      'Các công nhân đang tất bật bốc dỡ từng thùng hoa quả nhiệt đới tươi ngon từ tàu chở hàng cỡ lớn xuống bến cảng và vận chuyển vào kho chuỗi cung ứng lạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '工人们正在码头上忙碌地将成箱的新鲜热带水果从大型货船上卸下并运往冷链仓库。', 'Gōngrénmen zhèngzài mǎtou shang mánglù de jiāng chéng xiāng de xīnxiān rèdài shuǐguǒ cóng dàxíng huòchuán shang xiè xià bìng yùn wǎng lěngliàn cāngkù.', 'Các công nhân đang tất bật bốc dỡ từng thùng hoa quả nhiệt đới tươi ngon từ tàu chở hàng cỡ lớn xuống bến cảng và vận chuyển vào kho chuỗi cung ứng lạnh.', 'basic', 1),
      (v_id, '跨国供应链的核心竞争力不仅在于能否将物资安全运达目的地，更在于如何通过数字化算法精准调配全球多式联运资源。', 'Kuàguó gōngyìngliàn de héxīn jìngzhēnglì bù jǐn zàiyú néng fǒu jiāng wùzī ānquán yùn dá mùdìdì, gèng zàiyú rúhé tōngguò shùzìhuà suànfǎ jīngzhǔn diàopèi quánqiú duō-shì-liányùn zīyuán.', 'Năng lực cạnh tranh cốt lõi của chuỗi cung ứng xuyên quốc gia không chỉ nằm ở việc có thể vận chuyển hàng hóa an toàn tới điểm đến hay không, mà quan trọng hơn là làm thế nào điều phối chuẩn xác các nguồn lực vận tải đa phương thức toàn cầu thông qua thuật toán số hóa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3438] [运费] (yùnfèi) - cước vận chuyển, phí vận chuyển [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '运费' AND pinyin = 'yùnfèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运费' AND pinyin = 'yùnfèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '运费'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yùnfèi',
      meaning_vi = 'cước vận chuyển, phí vận chuyển',
      example_hanzi = '这家电商平台正在举行年终促销活动，只要订单总额满九十九元就可以免除全部国内运费。',
      example_pinyin = 'Zhè jiā diànshāng píngtái zhèngzài jǔxíng niánzhōng cùxiāo huódòng, zhǐyào dìngdān zǒng''é mǎn jiǔshíjiǔ yuán jiù kěyǐ miǎnchú quánbù guónèi yùnfèi.',
      example_vi = 'Sàn thương mại điện tử này đang tổ chức đợt khuyến mãi cuối năm, chỉ cần tổng giá trị đơn hàng đạt từ 99 tệ trở lên là có thể được miễn toàn bộ phí vận chuyển nội địa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '运费',
      'yùnfèi',
      'cước vận chuyển, phí vận chuyển',
      'Danh từ',
      'HSK 5',
      '这家电商平台正在举行年终促销活动，只要订单总额满九十九元就可以免除全部国内运费。',
      'Zhè jiā diànshāng píngtái zhèngzài jǔxíng niánzhōng cùxiāo huódòng, zhǐyào dìngdān zǒng''é mǎn jiǔshíjiǔ yuán jiù kěyǐ miǎnchú quánbù guónèi yùnfèi.',
      'Sàn thương mại điện tử này đang tổ chức đợt khuyến mãi cuối năm, chỉ cần tổng giá trị đơn hàng đạt từ 99 tệ trở lên là có thể được miễn toàn bộ phí vận chuyển nội địa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家电商平台正在举行年终促销活动，只要订单总额满九十九元就可以免除全部国内运费。', 'Zhè jiā diànshāng píngtái zhèngzài jǔxíng niánzhōng cùxiāo huódòng, zhǐyào dìngdān zǒng''é mǎn jiǔshíjiǔ yuán jiù kěyǐ miǎnchú quánbù guónèi yùnfèi.', 'Sàn thương mại điện tử này đang tổ chức đợt khuyến mãi cuối năm, chỉ cần tổng giá trị đơn hàng đạt từ 99 tệ trở lên là có thể được miễn toàn bộ phí vận chuyển nội địa.', 'basic', 1),
      (v_id, '国际航运燃油附加费的大幅上涨直接推高了跨境集装箱的海运运费成本，对制造出口企业的利润空间造成了明显挤压。', 'Guójì hángyùn rányóu fùjiāfèi de dàfú shàngzhǎng zhíjiē tuīgāo le kuàjìng jízhuāngxiāng de hǎiyùn yùnfèi chéngběn, duì zhìzào chūkǒu qǐyè de lìrùn kōngjiān zàochéng le míngxiǎn jǐyā.', 'Việc phụ phí nhiên liệu vận tải biển quốc tế tăng vọt đã trực tiếp đẩy chi phí cước vận chuyển đường biển container xuyên biên giới lên cao, gây sức ép rõ rệt lên biên độ lợi nhuận của các doanh nghiệp sản xuất xuất khẩu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3439] [运气] (yùnqi) - vận may, số may, vận khí [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '运气' AND pinyin = 'yùnqi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运气' AND pinyin = 'yùnqi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '运气'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运气'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yùnqi',
      meaning_vi = 'vận may, số may, vận khí',
      example_hanzi = '他今天在超市抽奖活动中幸运地抽中了一等奖，大家都羡慕他的好运气。',
      example_pinyin = 'Tā jīntiān zài chāoshì chōujiǎng huódòng zhōng xìngyùn de chōu zhòng le yīděngjiǎng, dàjiā dōu xiànmù tā de hǎo yùnqi.',
      example_vi = 'Hôm nay trong hoạt động bốc thăm trúng thưởng ở siêu thị anh ấy may mắn trúng giải nhất, mọi người đều ngưỡng mộ vận may lớn của anh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '运气',
      'yùnqi',
      'vận may, số may, vận khí',
      'Danh từ',
      'HSK 5',
      '他今天在超市抽奖活动中幸运地抽中了一等奖，大家都羡慕他的好运气。',
      'Tā jīntiān zài chāoshì chōujiǎng huódòng zhōng xìngyùn de chōu zhòng le yīděngjiǎng, dàjiā dōu xiànmù tā de hǎo yùnqi.',
      'Hôm nay trong hoạt động bốc thăm trúng thưởng ở siêu thị anh ấy may mắn trúng giải nhất, mọi người đều ngưỡng mộ vận may lớn của anh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他今天在超市抽奖活动中幸运地抽中了一等奖，大家都羡慕他的好运气。', 'Tā jīntiān zài chāoshì chōujiǎng huódòng zhōng xìngyùn de chōu zhòng le yīděngjiǎng, dàjiā dōu xiànmù tā de hǎo yùnqi.', 'Hôm nay trong hoạt động bốc thăm trúng thưởng ở siêu thị anh ấy may mắn trúng giải nhất, mọi người đều ngưỡng mộ vận may lớn của anh.', 'basic', 1),
      (v_id, '创业者的商业成功固然离不开时代赋予的发展机遇与运气，但起决定性作用的始终是长期的战略定力与坚韧执行力。', 'Chuàngyèzhě de shāngyè chénggōng gùrán lí bù kāi shídài fùyǔ de fāzhǎn jīyù yǔ yùnqi, dàn qǐ juédìngxìng zuòyòng de shǐzhōng shì chángqī de zhànlüè dìnglì yǔ jiānrèn zhíxínglì.', 'Sự thành công trong kinh doanh của người khởi nghiệp tuy không thể tách rời thời cơ phát triển và vận may mà thời đại ban tặng, nhưng đóng vai trò mang tính quyết định vẫn luôn là định lực chiến lược dài hạn và năng lực thực thi bền bỉ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3440] [运输] (yùnshū) - vận tải, chuyên chở, vận chuyển [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '运输' AND pinyin = 'yùnshū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运输' AND pinyin = 'yùnshū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '运输'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运输'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yùnshū',
      meaning_vi = 'vận tải, chuyên chở, vận chuyển',
      example_hanzi = '铁路部门在春运期间增开了多趟临时旅客列车，全力保障广大返乡旅客的安全运输。',
      example_pinyin = 'Tiělù bùmén zài chūnyùn qījiān zēngkāi le duō tàng línshí lǚkè lièchē, quánlì bǎozhàng guǎngdà fǎnxiāng lǚkè de ānquán yùnshū.',
      example_vi = 'Ngành đường sắt đã tăng cường thêm nhiều chuyến tàu khách tạm thời trong dịp cao điểm Tết, dốc toàn lực bảo đảm việc vận chuyển an toàn cho đông đảo hành khách về quê.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '运输',
      'yùnshū',
      'vận tải, chuyên chở, vận chuyển',
      'Động từ / Danh từ',
      'HSK 5',
      '铁路部门在春运期间增开了多趟临时旅客列车，全力保障广大返乡旅客的安全运输。',
      'Tiělù bùmén zài chūnyùn qījiān zēngkāi le duō tàng línshí lǚkè lièchē, quánlì bǎozhàng guǎngdà fǎnxiāng lǚkè de ānquán yùnshū.',
      'Ngành đường sắt đã tăng cường thêm nhiều chuyến tàu khách tạm thời trong dịp cao điểm Tết, dốc toàn lực bảo đảm việc vận chuyển an toàn cho đông đảo hành khách về quê.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '铁路部门在春运期间增开了多趟临时旅客列车，全力保障广大返乡旅客的安全运输。', 'Tiělù bùmén zài chūnyùn qījiān zēngkāi le duō tàng línshí lǚkè lièchē, quánlì bǎozhàng guǎngdà fǎnxiāng lǚkè de ānquán yùnshū.', 'Ngành đường sắt đã tăng cường thêm nhiều chuyến tàu khách tạm thời trong dịp cao điểm Tết, dốc toàn lực bảo đảm việc vận chuyển an toàn cho đông đảo hành khách về quê.', 'basic', 1),
      (v_id, '液化天然气超低温专用运输船的核心绝热保温围护系统建造难度极高，代表着现代造船工业的顶尖工艺技术水准。', 'Yèhuà tiānránqì chāo-dīwēn zhuānyòng yùnshūchuán de héxīn juérè bǎowēn wéihù xìtǒng jiànzào nándù jí gāo, dàibiǎo zhe xiàndài zàochuán gōngyè de dǐngjiān gōngyì jìshù shuǐzhǔn.', 'Hệ thống bao che cách nhiệt giữ ấm cốt lõi của tàu chuyên dụng vận chuyển khí thiên nhiên hóa lỏng nhiệt độ siêu thấp có độ khó thi công cực cao, đại diện cho trình độ công nghệ kỹ thuật đỉnh cao của nền công nghiệp đóng tàu hiện đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3441] [运用] (yùnyòng) - vận dụng, áp dụng, sử dụng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '运用' AND pinyin = 'yùnyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运用' AND pinyin = 'yùnyòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '运用'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '运用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yùnyòng',
      meaning_vi = 'vận dụng, áp dụng, sử dụng',
      example_hanzi = '学完这些基本的语法知识之后，同学们应该多加练习，熟练运用到日常口语交流当中。',
      example_pinyin = 'Xué wán zhèxiē jīběn de yǔfǎ zhīshi zhīhòu, tóngxuémen yīnggāi duō jiā liànxí, shúliàn yùnyòng dào rìcháng kǒuyǔ jiāoliú dāngzhōng.',
      example_vi = 'Sau khi học xong những kiến thức ngữ pháp cơ bản này, các bạn học sinh nên tăng cường luyện tập, vận dụng thành thạo vào giao tiếp khẩu ngữ hằng ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '运用',
      'yùnyòng',
      'vận dụng, áp dụng, sử dụng',
      'Động từ',
      'HSK 5',
      '学完这些基本的语法知识之后，同学们应该多加练习，熟练运用到日常口语交流当中。',
      'Xué wán zhèxiē jīběn de yǔfǎ zhīshi zhīhòu, tóngxuémen yīnggāi duō jiā liànxí, shúliàn yùnyòng dào rìcháng kǒuyǔ jiāoliú dāngzhōng.',
      'Sau khi học xong những kiến thức ngữ pháp cơ bản này, các bạn học sinh nên tăng cường luyện tập, vận dụng thành thạo vào giao tiếp khẩu ngữ hằng ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学完这些基本的语法知识之后，同学们应该多加练习，熟练运用到日常口语交流当中。', 'Xué wán zhèxiē jīběn de yǔfǎ zhīshi zhīhòu, tóngxuémen yīnggāi duō jiā liànxí, shúliàn yùnyòng dào rìcháng kǒuyǔ jiāoliú dāngzhōng.', 'Sau khi học xong những kiến thức ngữ pháp cơ bản này, các bạn học sinh nên tăng cường luyện tập, vận dụng thành thạo vào giao tiếp khẩu ngữ hằng ngày.', 'basic', 1),
      (v_id, '宏观经济决策智库综合运用计量经济模型与大数据因果推断方法，对未来产业政策的实施效应进行多维情景模拟。', 'Hóngguān jīngjì juécè zhìkù zōnghé yùnyòng jìliàng jīngjì móxíng yǔ dà-shùjù yīnguǒ tuīduàn fāngfǎ, duì wèilái chǎnyè zhèngcè de shíshī xiàoyìng jìnxíng duō-wéi qíngjǐng mónǐ.', 'Viện nghiên cứu chính sách kinh tế vĩ mô đã vận dụng tổng hợp mô hình kinh tế lượng và phương pháp suy luận nhân quả dữ liệu lớn để tiến hành mô phỏng kịch bản đa chiều về hiệu ứng thực thi chính sách công nghiệp tương lai.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3442] [在场] (zàichǎng) - có mặt, hiện diện tại hiện trường/tại chỗ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '在场' AND pinyin = 'zàichǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在场' AND pinyin = 'zàichǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '在场'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zàichǎng',
      meaning_vi = 'có mặt, hiện diện tại hiện trường/tại chỗ',
      example_hanzi = '当主持人宣布最终的比赛获奖结果时，在场的所有观众和评委都情不自禁地起立鼓掌。',
      example_pinyin = 'Dāng zhǔchírén xuānbù zuìzhōng de bǐsài huòjiǎng jiéguǒ shí, zàichǎng de suǒyǒu guānzhòng hé píngwěi dōu qíngbùzìjīn de qǐlì gǔzhǎng.',
      example_vi = 'Khi người dẫn chương trình công bố kết quả đoạt giải chung cuộc của cuộc thi, tất cả khán giả và ban giám khảo có mặt tại hội trường đều không kìm được đã đứng dậy vỗ tay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '在场',
      'zàichǎng',
      'có mặt, hiện diện tại hiện trường/tại chỗ',
      'Động từ',
      'HSK 5',
      '当主持人宣布最终的比赛获奖结果时，在场的所有观众和评委都情不自禁地起立鼓掌。',
      'Dāng zhǔchírén xuānbù zuìzhōng de bǐsài huòjiǎng jiéguǒ shí, zàichǎng de suǒyǒu guānzhòng hé píngwěi dōu qíngbùzìjīn de qǐlì gǔzhǎng.',
      'Khi người dẫn chương trình công bố kết quả đoạt giải chung cuộc của cuộc thi, tất cả khán giả và ban giám khảo có mặt tại hội trường đều không kìm được đã đứng dậy vỗ tay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '当主持人宣布最终的比赛获奖结果时，在场的所有观众和评委都情不自禁地起立鼓掌。', 'Dāng zhǔchírén xuānbù zuìzhōng de bǐsài huòjiǎng jiéguǒ shí, zàichǎng de suǒyǒu guānzhòng hé píngwěi dōu qíngbùzìjīn de qǐlì gǔzhǎng.', 'Khi người dẫn chương trình công bố kết quả đoạt giải chung cuộc của cuộc thi, tất cả khán giả và ban giám khảo có mặt tại hội trường đều không kìm được đã đứng dậy vỗ tay.', 'basic', 1),
      (v_id, '涉及重大公司股权处置的公证法定程序，必须要求双方具备民事行为能力的法定代表人与独立见证律师同时在场签署。', 'Shèjí zhòngdà gōngsī gǔquán chǔzhì de gōngzhèng fǎdìng chéngxù, bìxū yāoqiú shuāngfāng jùbèi mínshì xíngwéi nénglì de fǎdìng dàibiǎorén yǔ dúlì jiànzhèng lǜshī tóngshí zàichǎng qiānshǔ.', 'Quy trình pháp định công chứng liên quan đến định đoạt cổ phần công ty trọng đại bắt buộc phải yêu cầu đại diện pháp luật có đủ năng lực hành vi dân sự của hai bên cùng luật sư làm chứng độc lập đồng thời có mặt tại chỗ để ký kết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3443] [在乎] (zàihu) - để tâm, bận tâm, coi trọng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '在乎' AND pinyin = 'zàihu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在乎' AND pinyin = 'zàihu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '在乎'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在乎'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zàihu',
      meaning_vi = 'để tâm, bận tâm, coi trọng',
      example_hanzi = '既然你已经为了梦想全力以赴，就不要太在乎个别人的冷言冷语和片面评价。',
      example_pinyin = 'Jìrán nǐ yǐjīng wèile mèngxiǎng quánlì-yǐfù, jiù bú yào tài zàihu gèbié rén de lěngyán-lěngyǔ hé piànmiàn píngjià.',
      example_vi = 'Một khi bạn đã dốc toàn lực vì ước mơ, thì đừng quá bận tâm đến những lời mỉa mai lạnh lùng hay những lời đánh giá phiến diện của vài cá nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '在乎',
      'zàihu',
      'để tâm, bận tâm, coi trọng',
      'Động từ',
      'HSK 5',
      '既然你已经为了梦想全力以赴，就不要太在乎个别人的冷言冷语和片面评价。',
      'Jìrán nǐ yǐjīng wèile mèngxiǎng quánlì-yǐfù, jiù bú yào tài zàihu gèbié rén de lěngyán-lěngyǔ hé piànmiàn píngjià.',
      'Một khi bạn đã dốc toàn lực vì ước mơ, thì đừng quá bận tâm đến những lời mỉa mai lạnh lùng hay những lời đánh giá phiến diện của vài cá nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '既然你已经为了梦想全力以赴，就不要太在乎个别人的冷言冷语和片面评价。', 'Jìrán nǐ yǐjīng wèile mèngxiǎng quánlì-yǐfù, jiù bú yào tài zàihu gèbié rén de lěngyán-lěngyǔ hé piànmiàn píngjià.', 'Một khi bạn đã dốc toàn lực vì ước mơ, thì đừng quá bận tâm đến những lời mỉa mai lạnh lùng hay những lời đánh giá phiến diện của vài cá nhân.', 'basic', 1),
      (v_id, '优秀的品牌建设战略极其在乎消费者的长期信任与情感共鸣，绝不会为追求短期眼前暴利而牺牲核心产品质量底线。', 'Yōuxiù de pǐnpái jiànshè zhànlüè jíqí zàihu xiāofèizhě de chángqī xìnrèn yǔ qínggǎn gòngmíng, jué bú huì wèi zhuīqiú duǎnqī yǎnqián bàolì ér xīshēng héxīn chǎnpǐn zhìliàng dǐxiàn.', 'Chiến lược xây dựng thương hiệu xuất sắc cực kỳ coi trọng sự tin tưởng dài hạn và sự đồng cảm cảm xúc của người tiêu dùng, tuyệt đối không vì mưu cầu món siêu lợi nhuận ngắn hạn trước mắt mà hy sinh ranh giới đáy về chất lượng sản phẩm cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3444] [在内] (zàinèi) - bao gồm bên trong, tính cả, kể cả [Cụm từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '在内' AND pinyin = 'zàinèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在内' AND pinyin = 'zàinèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '在内'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在内'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Cụm từ / Giới từ',
      pinyin = 'zàinèi',
      meaning_vi = 'bao gồm bên trong, tính cả, kể cả',
      example_hanzi = '这次户外徒步登山活动的全部费用，包括往返旅游巴士车票与午餐在内，每人一共需要交纳一百五十元。',
      example_pinyin = 'Zhè cì hùwài túbù dēngshān huódòng de quánbù fèiyong, bāokuò wǎngfǎn lǚyóu bāshì chēpiào yǔ wǔcān zàinèi, měi rén yígòng xūyào jiāonà yībǎi wǔshí yuán.',
      example_vi = 'Toàn bộ chi phí của hoạt động đi bộ leo núi ngoài trời lần này, bao gồm cả vé xe buýt du lịch khứ hồi và bữa trưa bên trong, mỗi người cần nộp tổng cộng 150 tệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '在内',
      'zàinèi',
      'bao gồm bên trong, tính cả, kể cả',
      'Cụm từ / Giới từ',
      'HSK 5',
      '这次户外徒步登山活动的全部费用，包括往返旅游巴士车票与午餐在内，每人一共需要交纳一百五十元。',
      'Zhè cì hùwài túbù dēngshān huódòng de quánbù fèiyong, bāokuò wǎngfǎn lǚyóu bāshì chēpiào yǔ wǔcān zàinèi, měi rén yígòng xūyào jiāonà yībǎi wǔshí yuán.',
      'Toàn bộ chi phí của hoạt động đi bộ leo núi ngoài trời lần này, bao gồm cả vé xe buýt du lịch khứ hồi và bữa trưa bên trong, mỗi người cần nộp tổng cộng 150 tệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这次户外徒步登山活动的全部费用，包括往返旅游巴士车票与午餐在内，每人一共需要交纳一百五十元。', 'Zhè cì hùwài túbù dēngshān huódòng de quánbù fèiyong, bāokuò wǎngfǎn lǚyóu bāshì chēpiào yǔ wǔcān zàinèi, měi rén yígòng xūyào jiāonà yībǎi wǔshí yuán.', 'Toàn bộ chi phí của hoạt động đi bộ leo núi ngoài trời lần này, bao gồm cả vé xe buýt du lịch khứ hồi và bữa trưa bên trong, mỗi người cần nộp tổng cộng 150 tệ.', 'basic', 1),
      (v_id, '世界贸易组织多边贸易协定框架要求各成员国全面履行关税减让承诺，将工业制造品与大宗农产品在内的上千种品类纳入平等待遇清单。', 'Shìjiè Màoyì Zǔzhī duōbiān màoyì xiédìng kuàngjià yāoqiú gè chéngyuánguó quánmiàn lǚxíng guānshuì jiǎnràng chéngnuò, jiāng gōngyè zhìzàopǐn yǔ dàzōng nóngchǎnpǐn zàinèi de shàng qiān zhǒng pǐnlèi nàrù píngděng dàiyù qīngdān.', 'Khung hiệp định thương mại đa phương của Tổ chức Thương mại Thế giới yêu cầu các quốc gia thành viên thực hiện toàn diện cam kết cắt giảm thuế quan, đưa hàng nghìn chủng loại hàng hóa kể cả sản phẩm công nghiệp chế tạo và nông sản số lượng lớn vào danh mục đãi ngộ bình đẳng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3445] [在线] (zàixiàn) - trực tuyến, online [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '在线' AND pinyin = 'zàixiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在线' AND pinyin = 'zàixiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '在线'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在线'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'zàixiàn',
      meaning_vi = 'trực tuyến, online',
      example_hanzi = '你如果对这款新手机的功能有任何疑问，可以随时联系全天二十四小时在线的官方客服人员。',
      example_pinyin = 'Nǐ rúguǒ duì zhè kuǎn xīn shǒujī de gōngnéng yǒu rènhé yíwèn, kěyǐ suíshí liánxì quántiān èrshísì xiǎoshí zàixiàn de guānfāng kèfù rényuán.',
      example_vi = 'Nếu bạn có bất kỳ thắc mắc nào về tính năng của chiếc điện thoại di động mới này, bạn có thể liên hệ bất cứ lúc nào với nhân viên chăm sóc khách hàng chính thức trực tuyến 24/7.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '在线',
      'zàixiàn',
      'trực tuyến, online',
      'Tính từ / Động từ',
      'HSK 5',
      '你如果对这款新手机的功能有任何疑问，可以随时联系全天二十四小时在线的官方客服人员。',
      'Nǐ rúguǒ duì zhè kuǎn xīn shǒujī de gōngnéng yǒu rènhé yíwèn, kěyǐ suíshí liánxì quántiān èrshísì xiǎoshí zàixiàn de guānfāng kèfù rényuán.',
      'Nếu bạn có bất kỳ thắc mắc nào về tính năng của chiếc điện thoại di động mới này, bạn có thể liên hệ bất cứ lúc nào với nhân viên chăm sóc khách hàng chính thức trực tuyến 24/7.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '你如果对这款新手机的功能有任何疑问，可以随时联系全天二十四小时在线的官方客服人员。', 'Nǐ rúguǒ duì zhè kuǎn xīn shǒujī de gōngnéng yǒu rènhé yíwèn, kěyǐ suíshí liánxì quántiān èrshísì xiǎoshí zàixiàn de guānfāng kèfù rényuán.', 'Nếu bạn có bất kỳ thắc mắc nào về tính năng của chiếc điện thoại di động mới này, bạn có thể liên hệ bất cứ lúc nào với nhân viên chăm sóc khách hàng chính thức trực tuyến 24/7.', 'basic', 1),
      (v_id, '金融云服务架构通过多中心双活集群部署与毫秒级容灾切换机制，保障了海量并发在线支付系统的高可用性与业务连续性。', 'Jīnróng yún-fúwù jiàgòu tōngguò duō-zhōngxīn shuānghuó jíqún bùshǔ yǔ háomiǎojí róngzāi qiēhuàn jīzhì, bǎozhàng le hǎiliàng bīngfā zàixiàn zhīfù xìtǒng de gāo kěyòngxìng yǔ yèwù liánxùxìng.', 'Kiến trúc dịch vụ đám mây tài chính thông qua việc triển khai cụm song hoạt đa trung tâm cùng cơ chế chuyển đổi dự phòng thảm họa cấp mili giây, đã bảo đảm tính sẵn sàng cao và tính liên tục nghiệp vụ cho hệ thống thanh toán trực tuyến đồng thời dung lượng lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3446] [在于] (zàiyú) - cốt ở, nằm ở, do ở [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '在于' AND pinyin = 'zàiyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在于' AND pinyin = 'zàiyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '在于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '在于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zàiyú',
      meaning_vi = 'cốt ở, nằm ở, do ở',
      example_hanzi = '读书的真正意义不仅在于获取应付考试的分数，更在于开阔个人的视野与涵养高尚的情操。',
      example_pinyin = 'Dúshū de zhēnzhèng yìyì bù jǐn zàiyú huòqǔ yìngfu kǎoshì de fēnshù, gèng zàiyú kāikuò gèrén de shìyě yǔ hányǎng gāoshàng de qíngcāo.',
      example_vi = 'Ý nghĩa chân chính của việc đọc sách không chỉ nằm ở việc đạt điểm số để ứng phó thi cử, mà quan trọng hơn là cốt ở việc mở rộng tầm nhìn cá nhân và bồi đắp tư tưởng tình cảm cao đẹp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '在于',
      'zàiyú',
      'cốt ở, nằm ở, do ở',
      'Động từ',
      'HSK 5',
      '读书的真正意义不仅在于获取应付考试的分数，更在于开阔个人的视野与涵养高尚的情操。',
      'Dúshū de zhēnzhèng yìyì bù jǐn zàiyú huòqǔ yìngfu kǎoshì de fēnshù, gèng zàiyú kāikuò gèrén de shìyě yǔ hányǎng gāoshàng de qíngcāo.',
      'Ý nghĩa chân chính của việc đọc sách không chỉ nằm ở việc đạt điểm số để ứng phó thi cử, mà quan trọng hơn là cốt ở việc mở rộng tầm nhìn cá nhân và bồi đắp tư tưởng tình cảm cao đẹp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '读书的真正意义不仅在于获取应付考试的分数，更在于开阔个人的视野与涵养高尚的情操。', 'Dúshū de zhēnzhèng yìyì bù jǐn zàiyú huòqǔ yìngfu kǎoshì de fēnshù, gèng zàiyú kāikuò gèrén de shìyě yǔ hányǎng gāoshàng de qíngcāo.', 'Ý nghĩa chân chính của việc đọc sách không chỉ nằm ở việc đạt điểm số để ứng phó thi cử, mà quan trọng hơn là cốt ở việc mở rộng tầm nhìn cá nhân và bồi đắp tư tưởng tình cảm cao đẹp.', 'basic', 1),
      (v_id, '企业技术创新战略的成败核心在于能否突破基础科学核心原理，并将其敏捷转化为具备全球市场定价权的自主终端产品。', 'Qǐyè jìshù chuàngxīn zhànlüè de chéngbài héxīn zàiyú néng fǒu tūpò jīchǔ kēxué héxīn yuánlǐ, bìng jiāng qí mǐnjié zhuǎnhuà wéi jùbèi quánqiú shìchǎng dìngjiàquán de zìzhǔ zhōngduān chǎnpǐn.', 'Cốt lõi quyết định sự thành bại trong chiến lược đổi mới công nghệ của doanh nghiệp nằm ở việc liệu có thể bứt phá nguyên lý cốt lõi của khoa học cơ bản và chuyển đổi linh hoạt thành sản phẩm đầu cuối tự chủ có quyền định giá trên thị trường toàn cầu hay không.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3447] [赞成] (zànchéng) - tán thành, đồng ý, ủng hộ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '赞成' AND pinyin = 'zànchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赞成' AND pinyin = 'zànchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '赞成'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赞成'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zànchéng',
      meaning_vi = 'tán thành, đồng ý, ủng hộ',
      example_hanzi = '在今天下午召开的班级全体会议上，大多数同学都举手赞成周末去郊外森林公园举行野餐活动。',
      example_pinyin = 'Zài jīntiān xiàwǔ zhàokāi de bānjí quántǐ huìyì shang, dàduōshù tóngxué dōu jǔshǒu zànchéng zhōumò qù jiāowài sēnlín gōngyuán jǔxíng yěcān huódòng.',
      example_vi = 'Trong cuộc họp toàn thể lớp học triệu tập chiều nay, đa số các bạn học đều giơ tay tán thành việc cuối tuần đi công viên rừng ngoại ô tổ chức buổi dã ngoại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '赞成',
      'zànchéng',
      'tán thành, đồng ý, ủng hộ',
      'Động từ',
      'HSK 5',
      '在今天下午召开的班级全体会议上，大多数同学都举手赞成周末去郊外森林公园举行野餐活动。',
      'Zài jīntiān xiàwǔ zhàokāi de bānjí quántǐ huìyì shang, dàduōshù tóngxué dōu jǔshǒu zànchéng zhōumò qù jiāowài sēnlín gōngyuán jǔxíng yěcān huódòng.',
      'Trong cuộc họp toàn thể lớp học triệu tập chiều nay, đa số các bạn học đều giơ tay tán thành việc cuối tuần đi công viên rừng ngoại ô tổ chức buổi dã ngoại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在今天下午召开的班级全体会议上，大多数同学都举手赞成周末去郊外森林公园举行野餐活动。', 'Zài jīntiān xiàwǔ zhàokāi de bānjí quántǐ huìyì shang, dàduōshù tóngxué dōu jǔshǒu zànchéng zhōumò qù jiāowài sēnlín gōngyuán jǔxíng yěcān huódòng.', 'Trong cuộc họp toàn thể lớp học triệu tập chiều nay, đa số các bạn học đều giơ tay tán thành việc cuối tuần đi công viên rừng ngoại ô tổ chức buổi dã ngoại.', 'basic', 1),
      (v_id, '公司董事会以全体赞成的表决结果审议通过了对高新技术研发中心追加两亿元资本性投入的专项议案。', 'Gōngsī dǒngshìhuì yǐ quántǐ zànchéng de biǎojué jiéguǒ shěnyì tōngguò le duì gāoxīn-jìshù yánfā zhōngxīn zhuījiā liǎng yì yuán zīběnxìng tóurù de zhuānxiàng yì''àn.', 'Hội đồng quản trị công ty với kết quả biểu quyết 100% tán thành đã thẩm nghị thông qua nghị quyết chuyên đề về việc rót thêm hai trăm triệu nhân dân tệ đầu tư mang tính vốn hóa cho trung tâm nghiên cứu phát triển công nghệ cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3448] [糟] (zāo) - hỏng, tồi tệ, nát bét; ôi thiu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '糟' AND pinyin = 'zāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '糟' AND pinyin = 'zāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '糟'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '糟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zāo',
      meaning_vi = 'hỏng, tồi tệ, nát bét; ôi thiu',
      example_hanzi = '出门时我突然发现天空中下起了倾盆大雨，而自己却忘记带雨伞，情况真是不巧又很糟。',
      example_pinyin = 'Chūmén shí wǒ tūrán fāxiàn tiānkōng zhōng xià qǐ le qīngpén dàyǔ, ér zìjǐ què wàngjì dài yǔsǎn, qíngkuàng zhēn shì bùqiǎo yòu hěn zāo.',
      example_vi = 'Lúc bước ra khỏi cửa tôi chợt phát hiện trời đổ cơn mưa như trút nước, mà bản thân lại quên mang theo ô dù, tình huống thật chẳng khéo mà lại quá tồi tệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '糟',
      'zāo',
      'hỏng, tồi tệ, nát bét; ôi thiu',
      'Tính từ',
      'HSK 5',
      '出门时我突然发现天空中下起了倾盆大雨，而自己却忘记带雨伞，情况真是不巧又很糟。',
      'Chūmén shí wǒ tūrán fāxiàn tiānkōng zhōng xià qǐ le qīngpén dàyǔ, ér zìjǐ què wàngjì dài yǔsǎn, qíngkuàng zhēn shì bùqiǎo yòu hěn zāo.',
      'Lúc bước ra khỏi cửa tôi chợt phát hiện trời đổ cơn mưa như trút nước, mà bản thân lại quên mang theo ô dù, tình huống thật chẳng khéo mà lại quá tồi tệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门时我突然发现天空中下起了倾盆大雨，而自己却忘记带雨伞，情况真是不巧又很糟。', 'Chūmén shí wǒ tūrán fāxiàn tiānkōng zhōng xià qǐ le qīngpén dàyǔ, ér zìjǐ què wàngjì dài yǔsǎn, qíngkuàng zhēn shì bùqiǎo yòu hěn zāo.', 'Lúc bước ra khỏi cửa tôi chợt phát hiện trời đổ cơn mưa như trút nước, mà bản thân lại quên mang theo ô dù, tình huống thật chẳng khéo mà lại quá tồi tệ.', 'basic', 1),
      (v_id, '在极端复杂的多方博弈谈判局势下，决策团队即便面对最糟的市场预期与制裁冲击，也必须制定周密的底线应急预案。', 'Zài jíduān fùzá de duōfāng bóyì tánpàn júshì xià, juécè tuánduì jíbiàn miànduì zuì zāo de shìchǎng yùqī yǔ zhìcái chōngjī, yě bìxū zhìdìng zhōumì de dǐxiàn yīngjí yù''àn.', 'Dưới cục diện đàm phán cờ bạc chiến lược đa bên cực kỳ phức tạp, đội ngũ ra quyết định dẫu phải đối mặt với dự báo thị trường tồi tệ nhất cùng cú sốc cấm vận trừng phạt, vẫn bắt buộc phải lập sẵn phương án ứng phó khẩn cấp ranh giới đỏ chu toàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3449] [糟糕] (zāogāo) - gay go, tồi tệ, hỏng bét [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '糟糕' AND pinyin = 'zāogāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '糟糕' AND pinyin = 'zāogāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '糟糕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '糟糕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zāogāo',
      meaning_vi = 'gay go, tồi tệ, hỏng bét',
      example_hanzi = '太糟糕了！我刚才由于匆忙下出租车，不小心将装有身份证与重要护照的文件包落在了后座上。',
      example_pinyin = 'Tài zāogāo le! Wǒ gāngcái yóuyú cōngmáng xià chūzūchē, bù xiǎoxīn jiāng zhuāng yǒu shēnfènzhèng yǔ zhòngyào hùzhào de wénjiànbāo là zài le hòuzuò shang.',
      example_vi = 'Gay go quá rồi! Vừa nãy do vội vã bước xuống xe taxi, tôi sơ ý để quên chiếc túi tài liệu đựng thẻ căn cước và hộ chiếu quan trọng ở ghế sau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '糟糕',
      'zāogāo',
      'gay go, tồi tệ, hỏng bét',
      'Tính từ',
      'HSK 5',
      '太糟糕了！我刚才由于匆忙下出租车，不小心将装有身份证与重要护照的文件包落在了后座上。',
      'Tài zāogāo le! Wǒ gāngcái yóuyú cōngmáng xià chūzūchē, bù xiǎoxīn jiāng zhuāng yǒu shēnfènzhèng yǔ zhòngyào hùzhào de wénjiànbāo là zài le hòuzuò shang.',
      'Gay go quá rồi! Vừa nãy do vội vã bước xuống xe taxi, tôi sơ ý để quên chiếc túi tài liệu đựng thẻ căn cước và hộ chiếu quan trọng ở ghế sau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '太糟糕了！我刚才由于匆忙下出租车，不小心将装有身份证与重要护照的文件包落在了后座上。', 'Tài zāogāo le! Wǒ gāngcái yóuyú cōngmáng xià chūzūchē, bù xiǎoxīn jiāng zhuāng yǒu shēnfènzhèng yǔ zhòngyào hùzhào de wénjiànbāo là zài le hòuzuò shang.', 'Gay go quá rồi! Vừa nãy do vội vã bước xuống xe taxi, tôi sơ ý để quên chiếc túi tài liệu đựng thẻ căn cước và hộ chiếu quan trọng ở ghế sau.', 'basic', 1),
      (v_id, '供应链突发中断叠加原材料价格剧烈震荡，使得该制造业龙头企业遭遇了近十年来最糟糕的单季度盈利衰退。', 'Gōngyìngliàn tūfā zhōngduàn diéjiā yuáncáiliào jiàgé jùliè zhèndàng, shǐde gāi zhìzàoyè lóngtóu qǐyè zāoyù le jìn shí nián lái zuì zāogāo de dān jìdù yínglì shuāituì.', 'Sự cố đứt gãy bất ngờ của chuỗi cung ứng cộng hưởng với biến động dữ dội của giá nguyên vật liệu thô đã khiến doanh nghiệp đầu ngành chế tạo này hứng chịu đợt suy thoái lợi nhuận quý tồi tệ nhất trong gần một thập kỷ qua.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3450] [早期] (zǎoqī) - thời kỳ đầu, giai đoạn đầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '早期' AND pinyin = 'zǎoqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '早期' AND pinyin = 'zǎoqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '早期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '早期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zǎoqī',
      meaning_vi = 'thời kỳ đầu, giai đoạn đầu',
      example_hanzi = '医生再三叮嘱大家，绝大多数慢性疾病在早期阶段如果能够做到早发现、早干预，康复的概率就会大大提高。',
      example_pinyin = 'Yīshēng zàisān dīngzhǔ dàjiā, jué dàduōshù mànxìng jíbìng zài zǎoqī jiēduàn rúguǒ nénggòu zuò dào zǎo fāxiàn, zǎo gānyù, kāngfù de gàilǜ jiù huì dàdà tígāo.',
      example_vi = 'Bác sĩ dặn dò mọi người hết lần này đến lần khác, tuyệt đại đa số các bệnh mãn tính trong giai đoạn đầu nếu phát hiện sớm, can thiệp sớm thì xác suất hồi phục sẽ tăng lên rất nhiều.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '早期',
      'zǎoqī',
      'thời kỳ đầu, giai đoạn đầu',
      'Danh từ',
      'HSK 5',
      '医生再三叮嘱大家，绝大多数慢性疾病在早期阶段如果能够做到早发现、早干预，康复的概率就会大大提高。',
      'Yīshēng zàisān dīngzhǔ dàjiā, jué dàduōshù mànxìng jíbìng zài zǎoqī jiēduàn rúguǒ nénggòu zuò dào zǎo fāxiàn, zǎo gānyù, kāngfù de gàilǜ jiù huì dàdà tígāo.',
      'Bác sĩ dặn dò mọi người hết lần này đến lần khác, tuyệt đại đa số các bệnh mãn tính trong giai đoạn đầu nếu phát hiện sớm, can thiệp sớm thì xác suất hồi phục sẽ tăng lên rất nhiều.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医生再三叮嘱大家，绝大多数慢性疾病在早期阶段如果能够做到早发现、早干预，康复的概率就会大大提高。', 'Yīshēng zàisān dīngzhǔ dàjiā, jué dàduōshù mànxìng jíbìng zài zǎoqī jiēduàn rúguǒ nénggòu zuò dào zǎo fāxiàn, zǎo gānyù, kāngfù de gàilǜ jiù huì dàdà tígāo.', 'Bác sĩ dặn dò mọi người hết lần này đến lần khác, tuyệt đại đa số các bệnh mãn tính trong giai đoạn đầu nếu phát hiện sớm, can thiệp sớm thì xác suất hồi phục sẽ tăng lên rất nhiều.', 'basic', 1),
      (v_id, '创业投资基金主要聚焦于硬科技领域的早期初创企业，为处于技术孵化阶段的科研成果转化提供至关重要的耐性资本支持。', 'Chuàngyè tóuzī jījīn zhǔyào jùjiāo yú yìng-kējì lǐngyù de zǎoqī chūchuàng qǐyè, wèi chǔyú jìshù fūhuà jiēduàn de kēyán chéngguǒ zhuǎnhuà tígōng zhìguān zhòngyào de nàixìng zīběn zhīchí.', 'Quỹ đầu tư mạo hiểm khởi nghiệp chủ yếu tập trung vào các doanh nghiệp khởi nghiệp giai đoạn đầu trong lĩnh vực công nghệ lõi cứng, cung cấp nguồn vốn kiên nhẫn tối quan trọng cho việc chuyển giao thành quả nghiên cứu khoa học đang trong giai đoạn ươm mầm công nghệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3451] [早晚] (zǎowǎn) - sớm muộn; sáng tối [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '早晚' AND pinyin = 'zǎowǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '早晚' AND pinyin = 'zǎowǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '早晚'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '早晚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Phó từ',
      pinyin = 'zǎowǎn',
      meaning_vi = 'sớm muộn; sáng tối',
      example_hanzi = '现在正值深秋换季时节，早晚温差比较大，大家出门时记得及时添一件保暖外套以防感冒。',
      example_pinyin = 'Xiànzài zhèng zhí shēnqiū huànjì shíjié, zǎowǎn wēnchā bǐjiào dà, dàjiā chūmén shí jìde jíshí tiān yí jiàn bǎonuǎn wàitào yǐfáng gǎnmào.',
      example_vi = 'Hiện nay đang đúng vào dịp chuyển mùa cuối thu, chênh lệch nhiệt độ sáng tối tương đối lớn, mọi người khi ra ngoài hãy nhớ mặc thêm một chiếc áo khoác ấm kịp thời để phòng ngừa cảm lạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '早晚',
      'zǎowǎn',
      'sớm muộn; sáng tối',
      'Danh từ / Phó từ',
      'HSK 5',
      '现在正值深秋换季时节，早晚温差比较大，大家出门时记得及时添一件保暖外套以防感冒。',
      'Xiànzài zhèng zhí shēnqiū huànjì shíjié, zǎowǎn wēnchā bǐjiào dà, dàjiā chūmén shí jìde jíshí tiān yí jiàn bǎonuǎn wàitào yǐfáng gǎnmào.',
      'Hiện nay đang đúng vào dịp chuyển mùa cuối thu, chênh lệch nhiệt độ sáng tối tương đối lớn, mọi người khi ra ngoài hãy nhớ mặc thêm một chiếc áo khoác ấm kịp thời để phòng ngừa cảm lạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现在正值深秋换季时节，早晚温差比较大，大家出门时记得及时添一件保暖外套以防感冒。', 'Xiànzài zhèng zhí shēnqiū huànjì shíjié, zǎowǎn wēnchā bǐjiào dà, dàjiā chūmén shí jìde jíshí tiān yí jiàn bǎonuǎn wàitào yǐfáng gǎnmào.', 'Hiện nay đang đúng vào dịp chuyển mùa cuối thu, chênh lệch nhiệt độ sáng tối tương đối lớn, mọi người khi ra ngoài hãy nhớ mặc thêm một chiếc áo khoác ấm kịp thời để phòng ngừa cảm lạnh.', 'basic', 1),
      (v_id, '不合规且漠视劳动者合法权益的高杠杆粗放扩张商业模式，在日益健全的法治监管和市场理性面前早晚会被彻底淘汰。', 'Bù hégūi qiě mòshì láodòngzhě héfǎ quányì de gāo-gànggǎn cūfàng kuòzhāng shāngyè móshì, zài rìyì jiànquán de fǎzhì jiānguǎn hé shìchǎng lǐxìng miànqián zǎowǎn huì bèi chèdǐ táotài.', 'Mô hình kinh doanh mở rộng tràn lan bằng đòn bẩy tài chính cao, không tuân thủ quy chuẩn và coi thường quyền lợi hợp pháp của người lao động, trước sự giám sát pháp trị ngày càng hoàn thiện và tính duy lý của thị trường sớm muộn cũng sẽ bị đào thải hoàn toàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3452] [早已] (zǎoyǐ) - đã... từ lâu, sớm đã [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '早已' AND pinyin = 'zǎoyǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '早已' AND pinyin = 'zǎoyǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '早已'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '早已'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'zǎoyǐ',
      meaning_vi = 'đã... từ lâu, sớm đã',
      example_hanzi = '当他匆匆赶到火车站候车大厅时，那趟前往北京的高铁列车早已停止检票了。',
      example_pinyin = 'Dāng tā cōngcōng gǎndào huǒchēzhàn hòuchē dàtīng shí, nà tàng qiánwǎng Běijīng de gāotiě lièchē zǎoyǐ tíngzhǐ jiǎnpiào le.',
      example_vi = 'Khi anh ấy vội vàng đến đại sảnh chờ của ga tàu hỏa, chuyến tàu cao tốc đi Bắc Kinh đó sớm đã ngừng soát vé rồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '早已',
      'zǎoyǐ',
      'đã... từ lâu, sớm đã',
      'Phó từ',
      'HSK 5',
      '当他匆匆赶到火车站候车大厅时，那趟前往北京的高铁列车早已停止检票了。',
      'Dāng tā cōngcōng gǎndào huǒchēzhàn hòuchē dàtīng shí, nà tàng qiánwǎng Běijīng de gāotiě lièchē zǎoyǐ tíngzhǐ jiǎnpiào le.',
      'Khi anh ấy vội vàng đến đại sảnh chờ của ga tàu hỏa, chuyến tàu cao tốc đi Bắc Kinh đó sớm đã ngừng soát vé rồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '当他匆匆赶到火车站候车大厅时，那趟前往北京的高铁列车早已停止检票了。', 'Dāng tā cōngcōng gǎndào huǒchēzhàn hòuchē dàtīng shí, nà tàng qiánwǎng Běijīng de gāotiě lièchē zǎoyǐ tíngzhǐ jiǎnpiào le.', 'Khi anh ấy vội vàng đến đại sảnh chờ của ga tàu hỏa, chuyến tàu cao tốc đi Bắc Kinh đó sớm đã ngừng soát vé rồi.', 'basic', 1),
      (v_id, '领先的跨国科技集团早已在下一代量子计算与可控核聚变前沿基础研究领域完成了深度战略布局。', 'Lǐngxiān de kuàguó kējì jítuán zǎoyǐ zài xià-yídài liàngzǐ jìsuàn yǔ kěkòng hé-jùbiàn qiányán jīchǔ yánjiū lǐngyù wánchéng le shēndù zhànlüè bùjú.', 'Tập đoàn công nghệ xuyên quốc gia hàng đầu từ lâu đã hoàn tất việc bố cục chiến lược sâu rộng trong các lĩnh vực nghiên cứu cơ bản mũi nhọn như điện toán lượng tử thế hệ mới và nhiệt hạch có thể kiểm soát.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3453] [造] (zào) - tạo, chế tạo, tạo dựng; gây nên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '造' AND pinyin = 'zào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '造' AND pinyin = 'zào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '造'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '造'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zào',
      meaning_vi = 'tạo, chế tạo, tạo dựng; gây nên',
      example_hanzi = '为了改善乡村地区的交通条件，政府决定在蜿蜒的小河上造一座结实的石拱桥。',
      example_pinyin = 'Wèile gǎishàn xiāngcūn dìqū de jiāotōng tiáojiàn, zhèngfǔ juédìng zài wānyán de xiǎohé shang zào yí zuò jiēshi de shí gǒngqiáo.',
      example_vi = 'Để cải thiện điều kiện giao thông của vùng nông thôn, chính quyền đã quyết định xây dựng một cây cầu vòm đá chắc chắn bắc qua con sông nhỏ uốn lượn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '造',
      'zào',
      'tạo, chế tạo, tạo dựng; gây nên',
      'Động từ',
      'HSK 5',
      '为了改善乡村地区的交通条件，政府决定在蜿蜒的小河上造一座结实的石拱桥。',
      'Wèile gǎishàn xiāngcūn dìqū de jiāotōng tiáojiàn, zhèngfǔ juédìng zài wānyán de xiǎohé shang zào yí zuò jiēshi de shí gǒngqiáo.',
      'Để cải thiện điều kiện giao thông của vùng nông thôn, chính quyền đã quyết định xây dựng một cây cầu vòm đá chắc chắn bắc qua con sông nhỏ uốn lượn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了改善乡村地区的交通条件，政府决定在蜿蜒的小河上造一座结实的石拱桥。', 'Wèile gǎishàn xiāngcūn dìqū de jiāotōng tiáojiàn, zhèngfǔ juédìng zài wānyán de xiǎohé shang zào yí zuò jiēshi de shí gǒngqiáo.', 'Để cải thiện điều kiện giao thông của vùng nông thôn, chính quyền đã quyết định xây dựng một cây cầu vòm đá chắc chắn bắc qua con sông nhỏ uốn lượn.', 'basic', 1),
      (v_id, '工业互联网赋能制造业打造柔性智能生产线，实现根据全球客户碎片化定制需求即时造出高精设备的能力。', 'Gōngyè hùliánwǎng fùnéng zhìzàoyè dǎzào róuxìng zhìnéng shēngchǎnxiàn, shíxiàn gēnjù quánqiú kèhù suìpiànhuà dìngzhì xūqiú jíshí zào chū gāojīng shèbèi de nénglì.', 'Internet công nghiệp tiếp sức cho ngành chế tạo xây dựng dây chuyền sản xuất thông minh linh hoạt, hiện thực hóa năng lực chế tạo tức thì các thiết bị có độ chính xác cao dựa trên nhu cầu tùy biến phân mảnh của khách hàng toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3454] [造成] (zàochéng) - gây ra, tạo thành, dẫn đến (kết quả xấu) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '造成' AND pinyin = 'zàochéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '造成' AND pinyin = 'zàochéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '造成'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '造成'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zàochéng',
      meaning_vi = 'gây ra, tạo thành, dẫn đến (kết quả xấu)',
      example_hanzi = '暴风雨天气导致路面积水严重，给早高峰期间出行的市民造成了极大的不便。',
      example_pinyin = 'Bàofēngyǔ tiānqì dǎozhì lùmiàn jīshuǐ yánzhòng, gěi zǎogāofēng qījiān chūxíng de shìmín zàochéng le jí dà de búbiàn.',
      example_vi = 'Thời tiết mưa bão dữ dội đã dẫn đến tình trạng ngập úng mặt đường nghiêm trọng, gây ra bất tiện vô cùng lớn cho người dân đi lại trong khung giờ cao điểm buổi sáng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '造成',
      'zàochéng',
      'gây ra, tạo thành, dẫn đến (kết quả xấu)',
      'Động từ',
      'HSK 5',
      '暴风雨天气导致路面积水严重，给早高峰期间出行的市民造成了极大的不便。',
      'Bàofēngyǔ tiānqì dǎozhì lùmiàn jīshuǐ yánzhòng, gěi zǎogāofēng qījiān chūxíng de shìmín zàochéng le jí dà de búbiàn.',
      'Thời tiết mưa bão dữ dội đã dẫn đến tình trạng ngập úng mặt đường nghiêm trọng, gây ra bất tiện vô cùng lớn cho người dân đi lại trong khung giờ cao điểm buổi sáng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '暴风雨天气导致路面积水严重，给早高峰期间出行的市民造成了极大的不便。', 'Bàofēngyǔ tiānqì dǎozhì lùmiàn jīshuǐ yánzhòng, gěi zǎogāofēng qījiān chūxíng de shìmín zàochéng le jí dà de búbiàn.', 'Thời tiết mưa bão dữ dội đã dẫn đến tình trạng ngập úng mặt đường nghiêm trọng, gây ra bất tiện vô cùng lớn cho người dân đi lại trong khung giờ cao điểm buổi sáng.', 'basic', 1),
      (v_id, '数据中心核心交换机未经安全审计的固件漏洞，极有可能对整个跨国金融清算网络造成灾难性瘫痪。', 'Shùjù zhōngxīn héxīn jiāohuànjī wèijīng ānquán shěnjì de gùjiàn lòudòng, jí yǒu kěnéng duì zhěnggè kuàguó jīnróng qīngsuàn wǎngluò zàochéng zāinànxìng tānhuàn.', 'Lỗ hổng phần sụn chưa qua kiểm toán an ninh trên thiết bị chuyển mạch cốt lõi của trung tâm dữ liệu rất có thể sẽ gây ra tình trạng tê liệt mang tính thảm họa đối với toàn bộ mạng lưới thanh toán bù trừ tài chính xuyên quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3455] [增] (zēng) - tăng, tăng thêm, gia tăng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '增' AND pinyin = 'zēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '增' AND pinyin = 'zēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '增'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '增'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zēng',
      meaning_vi = 'tăng, tăng thêm, gia tăng',
      example_hanzi = '随着初冬气温逐渐下降，医院门诊部患呼吸道感染的就诊人数有明显增多的趋势。',
      example_pinyin = 'Suízhe chūdōng qìwēn zhújiàn xiàjiàng, yīyuàn ménzhěnbù huàn hūxīdào gǎnrǎn de jiùzhěn rénshù yǒu míngxiǎn zēng duō de qūshì.',
      example_vi = 'Cùng với sự sụt giảm dần của nhiệt độ đầu đông, số lượng người đến khoa khám bệnh của bệnh viện vì nhiễm trùng đường hô hấp có xu hướng tăng rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '增',
      'zēng',
      'tăng, tăng thêm, gia tăng',
      'Động từ',
      'HSK 5',
      '随着初冬气温逐渐下降，医院门诊部患呼吸道感染的就诊人数有明显增多的趋势。',
      'Suízhe chūdōng qìwēn zhújiàn xiàjiàng, yīyuàn ménzhěnbù huàn hūxīdào gǎnrǎn de jiùzhěn rénshù yǒu míngxiǎn zēng duō de qūshì.',
      'Cùng với sự sụt giảm dần của nhiệt độ đầu đông, số lượng người đến khoa khám bệnh của bệnh viện vì nhiễm trùng đường hô hấp có xu hướng tăng rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着初冬气温逐渐下降，医院门诊部患呼吸道感染的就诊人数有明显增多的趋势。', 'Suízhe chūdōng qìwēn zhújiàn xiàjiàng, yīyuàn ménzhěnbù huàn hūxīdào gǎnrǎn de jiùzhěn rénshù yǒu míngxiǎn zēng duō de qūshì.', 'Cùng với sự sụt giảm dần của nhiệt độ đầu đông, số lượng người đến khoa khám bệnh của bệnh viện vì nhiễm trùng đường hô hấp có xu hướng tăng rõ rệt.', 'basic', 1),
      (v_id, '国家外汇管理局最新公布的数据表明，主权投资基金在全球多元化资产配置组合中稳步增持高评级绿色债券。', 'Guójiā Wàihuì Guǎnlǐjú zuìxīn gōngbù de shùjù biǎomíng, zhǔquán tóuzī jījīn zài quánqiú duōyuánhuà zīchǎn pèizhì zǔhé zhōng wěnbù zēng chí gāo-píngjí lǜsè zhàoquàn.', 'Số liệu mới nhất do Cục Quản lý Ngoại hối Quốc gia công bố chỉ rõ rằng quỹ đầu tư chủ quyền quốc gia đang gia tăng nắm giữ vững chắc các trái phiếu xanh xếp hạng tín nhiệm cao trong danh mục phân bổ tài sản đa dạng hóa toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3456] [增进] (zēngjìn) - tăng tiến, thúc đẩy, nâng cao (hiểu biết, tình hữu nghị) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '增进' AND pinyin = 'zēngjìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '增进' AND pinyin = 'zēngjìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '增进'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '增进'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zēngjìn',
      meaning_vi = 'tăng tiến, thúc đẩy, nâng cao (hiểu biết, tình hữu nghị)',
      example_hanzi = '两校青年学生联合举办的文化交流夏令营，极大地增进了彼此之间的相互了解与深厚友谊。',
      example_pinyin = 'Liǎng xiào qīngnián xuésheng liánhé jǔbàn de wénhuà jiāoliú xiàlìngyíng, jídà de zēngjìn le bǐcǐ zhījiān de xiānghù liǎojiě yǔ shēnhòu yǒuyì.',
      example_vi = 'Trại hè giao lưu văn hóa do học sinh thanh niên hai trường phối hợp tổ chức đã tăng cường rất lớn sự hiểu biết lẫn nhau và tình bạn sâu đậm giữa đôi bên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '增进',
      'zēngjìn',
      'tăng tiến, thúc đẩy, nâng cao (hiểu biết, tình hữu nghị)',
      'Động từ',
      'HSK 5',
      '两校青年学生联合举办的文化交流夏令营，极大地增进了彼此之间的相互了解与深厚友谊。',
      'Liǎng xiào qīngnián xuésheng liánhé jǔbàn de wénhuà jiāoliú xiàlìngyíng, jídà de zēngjìn le bǐcǐ zhījiān de xiānghù liǎojiě yǔ shēnhòu yǒuyì.',
      'Trại hè giao lưu văn hóa do học sinh thanh niên hai trường phối hợp tổ chức đã tăng cường rất lớn sự hiểu biết lẫn nhau và tình bạn sâu đậm giữa đôi bên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '两校青年学生联合举办的文化交流夏令营，极大地增进了彼此之间的相互了解与深厚友谊。', 'Liǎng xiào qīngnián xuésheng liánhé jǔbàn de wénhuà jiāoliú xiàlìngyíng, jídà de zēngjìn le bǐcǐ zhījiān de xiānghù liǎojiě yǔ shēnhòu yǒuyì.', 'Trại hè giao lưu văn hóa do học sinh thanh niên hai trường phối hợp tổ chức đã tăng cường rất lớn sự hiểu biết lẫn nhau và tình bạn sâu đậm giữa đôi bên.', 'basic', 1),
      (v_id, '常态化的高级别民间智库学术对话机制，对于消除地缘政治战略误判、增进大国战略互信发挥着不可替代的建设性作用。', 'Chángtàihuà de gāojíbié mínjiān zhìkù xuéshù duìhuà jīzhì, duìyú xiāochú dìyuán zhèngzhì zhànlüè wùpàn, zēngjìn dàguó zhànlüè hùxìn fāhuī zhe bùkě-tìdài de jiànshèxìng zuòyòng.', 'Cơ chế đối thoại học thuật viện chính sách phi chính phủ cấp cao được bình thường hóa phát huy vai trò mang tính xây dựng không thể thay thế đối với việc xóa bỏ sự phán đoán sai lầm chiến lược địa chính trị và củng cố sự tin cậy chiến lược lẫn nhau giữa các nước lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3457] [增强] (zēngqiáng) - tăng cường, củng cố, nâng cao (năng lực, thể chất) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '增强' AND pinyin = 'zēngqiáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '增强' AND pinyin = 'zēngqiáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '增强'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '增强'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zēngqiáng',
      meaning_vi = 'tăng cường, củng cố, nâng cao (năng lực, thể chất)',
      example_hanzi = '坚持每天进行半小时的有氧慢跑和规律作息，能够有效增强人体的新陈代谢与免疫力。',
      example_pinyin = 'Jiānchí měitiān jìnxíng bàn xiǎoshí de yǒuyǎng mànpǎo hé guīlǜ zuòxī, nénggòu yǒuxiào zēngqiáng réntǐ de xīnchén-dàixiè yǔ miǎnyìlì.',
      example_vi = 'Kiên trì chạy bộ chậm có oxy nửa giờ mỗi ngày cùng chế độ nghỉ ngơi sinh hoạt điều độ có thể tăng cường trao đổi chất và khả năng miễn dịch của cơ thể con người một cách hiệu quả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '增强',
      'zēngqiáng',
      'tăng cường, củng cố, nâng cao (năng lực, thể chất)',
      'Động từ',
      'HSK 5',
      '坚持每天进行半小时的有氧慢跑和规律作息，能够有效增强人体的新陈代谢与免疫力。',
      'Jiānchí měitiān jìnxíng bàn xiǎoshí de yǒuyǎng mànpǎo hé guīlǜ zuòxī, nénggòu yǒuxiào zēngqiáng réntǐ de xīnchén-dàixiè yǔ miǎnyìlì.',
      'Kiên trì chạy bộ chậm có oxy nửa giờ mỗi ngày cùng chế độ nghỉ ngơi sinh hoạt điều độ có thể tăng cường trao đổi chất và khả năng miễn dịch của cơ thể con người một cách hiệu quả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '坚持每天进行半小时的有氧慢跑和规律作息，能够有效增强人体的新陈代谢与免疫力。', 'Jiānchí měitiān jìnxíng bàn xiǎoshí de yǒuyǎng mànpǎo hé guīlǜ zuòxī, nénggòu yǒuxiào zēngqiáng réntǐ de xīnchén-dàixiè yǔ miǎnyìlì.', 'Kiên trì chạy bộ chậm có oxy nửa giờ mỗi ngày cùng chế độ nghỉ ngơi sinh hoạt điều độ có thể tăng cường trao đổi chất và khả năng miễn dịch của cơ thể con người một cách hiệu quả.', 'basic', 1),
      (v_id, '深化关键核心技术攻关是增强产业链供应链自主可控能力、抵御外部单边断供风险的根本战略举措。', 'Shēnhuà guānjiàn héxīn jìshù gōngguān shì zēngqiáng chǎnyèliàn gōngyìngliàn zìzhǔ kěkòng nénglì, dǐyù wàibù dānbiān duàngōng fēngxiǎn de gēnběn zhànlüè jǔcuò.', 'Đào sâu nghiên cứu đột phá công nghệ cốt lõi then chốt là biện pháp chiến lược căn bản nhằm tăng cường năng lực tự chủ kiểm soát được của chuỗi công nghiệp và chuỗi cung ứng, chống lại rủi ro bị cắt nguồn cung đơn phương từ bên ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3458] [赠] (zèng) - tặng, biếu, tặng kèm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '赠' AND pinyin = 'zèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赠' AND pinyin = 'zèng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '赠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zèng',
      meaning_vi = 'tặng, biếu, tặng kèm',
      example_hanzi = '在书店举办的新书签售会上，知名作者亲笔在扉页上题字并赠给远道而来的读者。',
      example_pinyin = 'Zài shūdiàn jǔbàn de xīnshū qiānshòuhuì shang, zhīmíng zuòzhě qīnbǐ zài fēiyè shang tízì bìng zèng gěi yuǎndào-érlái de dúzhě.',
      example_vi = 'Tại buổi ký tặng sách mới tổ chức ở hiệu sách, tác giả nổi tiếng đã tự tay đề chữ lên trang lót và tặng cho người độc giả lặn lội từ xa tới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '赠',
      'zèng',
      'tặng, biếu, tặng kèm',
      'Động từ',
      'HSK 5',
      '在书店举办的新书签售会上，知名作者亲笔在扉页上题字并赠给远道而来的读者。',
      'Zài shūdiàn jǔbàn de xīnshū qiānshòuhuì shang, zhīmíng zuòzhě qīnbǐ zài fēiyè shang tízì bìng zèng gěi yuǎndào-érlái de dúzhě.',
      'Tại buổi ký tặng sách mới tổ chức ở hiệu sách, tác giả nổi tiếng đã tự tay đề chữ lên trang lót và tặng cho người độc giả lặn lội từ xa tới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在书店举办的新书签售会上，知名作者亲笔在扉页上题字并赠给远道而来的读者。', 'Zài shūdiàn jǔbàn de xīnshū qiānshòuhuì shang, zhīmíng zuòzhě qīnbǐ zài fēiyè shang tízì bìng zèng gěi yuǎndào-érlái de dúzhě.', 'Tại buổi ký tặng sách mới tổ chức ở hiệu sách, tác giả nổi tiếng đã tự tay đề chữ lên trang lót và tặng cho người độc giả lặn lội từ xa tới.', 'basic', 1),
      (v_id, '该高新技术企业向国家重点实验室无偿捐赠一套价值千万的高精度电子显微成像检测系统，专项用于纳米材料科研攻坚。', 'Gāi gāoxīn-jìshù qǐyè xiàng guójiā zhòngdiǎn shíyànshì wúcháng juānzèng yí tào jiàzhí qiānwàn de gāojīngdù diànzǐ xiǎnwēi chéngxiàng jiǎncè xìtǒng, zhuānxiàng yòngyú nàmǐ cáiliào kēyán gōngjiān.', 'Doanh nghiệp công nghệ cao đó đã hiến tặng miễn phí cho phòng thí nghiệm trọng điểm quốc gia một hệ thống kiểm nghiệm chụp ảnh kính hiển vi điện tử độ chính xác cao trị giá hàng chục triệu tệ, chuyên dùng cho việc đột phá nghiên cứu vật liệu nano.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3459] [赠送] (zèngsòng) - trao tặng, gửi tặng, biếu tặng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '赠送' AND pinyin = 'zèngsòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赠送' AND pinyin = 'zèngsòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '赠送'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赠送'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zèngsòng',
      meaning_vi = 'trao tặng, gửi tặng, biếu tặng',
      example_hanzi = '凡是在本次商场店庆周末消费满五百元的顾客，均可获赠一套精美的陶瓷餐具礼盒。',
      example_pinyin = 'Fánshì zài běncì shāngchǎng diànqìng zhōumò xiāofèi mǎn wǔbǎi yuán de gùkè, jūnkě huò zèngsòng yí tào jīngměi de táocí cānjù lǐhé.',
      example_vi = 'Tất cả quý khách hàng tiêu dùng từ 500 tệ trở lên trong dịp cuối tuần kỷ niệm thành lập trung tâm thương mại lần này đều được tặng một bộ hộp quà đồ sứ gia dụng tinh xảo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '赠送',
      'zèngsòng',
      'trao tặng, gửi tặng, biếu tặng',
      'Động từ',
      'HSK 5',
      '凡是在本次商场店庆周末消费满五百元的顾客，均可获赠一套精美的陶瓷餐具礼盒。',
      'Fánshì zài běncì shāngchǎng diànqìng zhōumò xiāofèi mǎn wǔbǎi yuán de gùkè, jūnkě huò zèngsòng yí tào jīngměi de táocí cānjù lǐhé.',
      'Tất cả quý khách hàng tiêu dùng từ 500 tệ trở lên trong dịp cuối tuần kỷ niệm thành lập trung tâm thương mại lần này đều được tặng một bộ hộp quà đồ sứ gia dụng tinh xảo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '凡是在本次商场店庆周末消费满五百元的顾客，均可获赠一套精美的陶瓷餐具礼盒。', 'Fánshì zài běncì shāngchǎng diànqìng zhōumò xiāofèi mǎn wǔbǎi yuán de gùkè, jūnkě huò zèngsòng yí tào jīngměi de táocí cānjù lǐhé.', 'Tất cả quý khách hàng tiêu dùng từ 500 tệ trở lên trong dịp cuối tuần kỷ niệm thành lập trung tâm thương mại lần này đều được tặng một bộ hộp quà đồ sứ gia dụng tinh xảo.', 'basic', 1),
      (v_id, '代表团在结束正式友好访问时，向东道国国家博物馆正式赠送了代表本国非物质文化遗产顶尖工艺的双面丝绸刺绣艺术品。', 'Dàibiǎotuán zài jiéshù zhèngshì yǒuhǎo fǎngwèn shí, xiàng dōngdàoguó guójiā bówùguǎn zhèngshì zèngsòng le dàibiǎo běnguó fēi-wùzhì wénhuà yíchǎn dǐngjiān gōngyì de shuāngmiàn sīchóu cìxiù yìshùpǐn.', 'Đoàn đại biểu khi kết thúc chuyến thăm hữu nghị chính thức đã trao tặng chính thức cho viện bảo tàng quốc gia của nước chủ nhà tác phẩm nghệ thuật thêu tơ tằm hai mặt đại diện cho kỹ nghệ đỉnh cao di sản văn hóa phi vật thể của nước mình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3460] [炸] (zhá) - chiên, rán (ngập dầu) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '炸' AND pinyin = 'zhá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '炸' AND pinyin = 'zhá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '炸'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '炸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhá',
      meaning_vi = 'chiên, rán (ngập dầu)',
      example_hanzi = '这家街头小吃店刚出锅的香脆炸鸡块外焦里嫩，每天傍晚都吸引很多食客排队购买。',
      example_pinyin = 'Zhè jiā jiētóu xiǎochīdiàn gāng chūguō de xiāngcuì zhájī kuài wàijiāo-lǐnèn, měitiān bàngwǎn dōu xīyǐn hěn duō shíkè páiduì gòumǎi.',
      example_vi = 'Món thịt gà rán giòn rụm vừa mới vớt ra khỏi chảo của quán ăn vặt đường phố này bên ngoài giòn rụm bên trong mềm thơm, chiều tối nào cũng thu hút rất đông thực khách xếp hàng mua.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '炸',
      'zhá',
      'chiên, rán (ngập dầu)',
      'Động từ',
      'HSK 5',
      '这家街头小吃店刚出锅的香脆炸鸡块外焦里嫩，每天傍晚都吸引很多食客排队购买。',
      'Zhè jiā jiētóu xiǎochīdiàn gāng chūguō de xiāngcuì zhájī kuài wàijiāo-lǐnèn, měitiān bàngwǎn dōu xīyǐn hěn duō shíkè páiduì gòumǎi.',
      'Món thịt gà rán giòn rụm vừa mới vớt ra khỏi chảo của quán ăn vặt đường phố này bên ngoài giòn rụm bên trong mềm thơm, chiều tối nào cũng thu hút rất đông thực khách xếp hàng mua.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家街头小吃店刚出锅的香脆炸鸡块外焦里嫩，每天傍晚都吸引很多食客排队购买。', 'Zhè jiā jiētóu xiǎochīdiàn gāng chūguō de xiāngcuì zhájī kuài wàijiāo-lǐnèn, měitiān bàngwǎn dōu xīyǐn hěn duō shíkè páiduì gòumǎi.', 'Món thịt gà rán giòn rụm vừa mới vớt ra khỏi chảo của quán ăn vặt đường phố này bên ngoài giòn rụm bên trong mềm thơm, chiều tối nào cũng thu hút rất đông thực khách xếp hàng mua.', 'basic', 1),
      (v_id, '工业级食品油炸生产线通过智能传感器精确控制油温与油炸时长，严格抑制煎炸食用油脂中丙烯酰胺等副产物的过度生成。', 'Gōngyèjí shípǐn yóuzhá shēngchǎnxiàn tōngguò zhìnéng chuángǎnqì jīngquè kòngzhì yóuwēn yǔ yóuzhá shícháng, yángé yìzhì jiānzhá shíyòng yóuzhǐ zhōng bǐngxīxiān''àn děng fùchǎnwù de guòdù shēngchéng.', 'Dây chuyền chiên thực phẩm cấp công nghiệp thông qua cảm biến thông minh kiểm soát chuẩn xác nhiệt độ dầu và thời gian chiên rán, ức chế nghiêm ngặt sự sản sinh quá mức các phụ phẩm như acrylamide trong dầu mỡ ăn chiên rán.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3461] [摘] (zhāi) - hái, ngắt, tháo, trích dẫn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '摘' AND pinyin = 'zhāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摘' AND pinyin = 'zhāi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '摘'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhāi',
      meaning_vi = 'hái, ngắt, tháo, trích dẫn',
      example_hanzi = '金秋十月，果园里的苹果挂满枝头，农户们正抓紧晴好天气摘下一箱箱甜脆的水果。',
      example_pinyin = 'Jīnqiū shíyuè, guǒyuán lǐ de píngguǒ guà mǎn zhītóu, nónghùmen zhèng zhuājǐn qínghǎo tiānqì zhāi xià yì xiāng xiāng tiáncuì de shuǐguǒ.',
      example_vi = 'Tháng Mười mùa thu vàng, táo trong vườn trĩu trĩu cành cây, bà con nông dân đang tranh thủ thời tiết nắng đẹp hái xuống từng thùng trái cây ngọt giòn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '摘',
      'zhāi',
      'hái, ngắt, tháo, trích dẫn',
      'Động từ',
      'HSK 5',
      '金秋十月，果园里的苹果挂满枝头，农户们正抓紧晴好天气摘下一箱箱甜脆的水果。',
      'Jīnqiū shíyuè, guǒyuán lǐ de píngguǒ guà mǎn zhītóu, nónghùmen zhèng zhuājǐn qínghǎo tiānqì zhāi xià yì xiāng xiāng tiáncuì de shuǐguǒ.',
      'Tháng Mười mùa thu vàng, táo trong vườn trĩu trĩu cành cây, bà con nông dân đang tranh thủ thời tiết nắng đẹp hái xuống từng thùng trái cây ngọt giòn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '金秋十月，果园里的苹果挂满枝头，农户们正抓紧晴好天气摘下一箱箱甜脆的水果。', 'Jīnqiū shíyuè, guǒyuán lǐ de píngguǒ guà mǎn zhītóu, nónghùmen zhèng zhuājǐn qínghǎo tiānqì zhāi xià yì xiāng xiāng tiáncuì de shuǐguǒ.', 'Tháng Mười mùa thu vàng, táo trong vườn trĩu trĩu cành cây, bà con nông dân đang tranh thủ thời tiết nắng đẹp hái xuống từng thùng trái cây ngọt giòn.', 'basic', 1),
      (v_id, '学术论文写作要求作者在直接引用他人实验数据或学术论点时，必须如实摘录并逐一注明出处以恪守学术道德。', 'Xuéshù lùnwén xiězuò yāoqiú zuòzhě zài zhíjiē yǐnyòng tārén shíyàn shùjù huò xuéshù lùndiǎn shí, bìxū rúshí zhāilù bìng zhúyī zhùmíng chūchù yǐ kèshǒu xuéshù dàodé.', 'Viết luận văn học thuật đòi hỏi tác giả khi trích dẫn trực tiếp số liệu thực nghiệm hoặc luận điểm học thuật của người khác bắt buộc phải trích sao trung thực và chú thích rõ nguồn gốc từng mục nhằm nghiêm cẩn tuân thủ đạo đức học thuật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3462] [窄] (zhǎi) - hẹp, chật hẹp, eo hẹp [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '窄' AND pinyin = 'zhǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '窄' AND pinyin = 'zhǎi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '窄'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '窄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhǎi',
      meaning_vi = 'hẹp, chật hẹp, eo hẹp',
      example_hanzi = '老城区里这条巷道非常狭窄，不仅私家汽车无法驶入，就连两辆自行车交会都很困难。',
      example_pinyin = 'Lǎo chéngqū lǐ zhè tiáo xiàngdào fēicháng xiázhǎi, bù jǐn sījiā qìchē wúfǎ shǐrù, jiù lián liǎng liàng zìxíngchē jiāohuì dōu hěn kùnnan.',
      example_vi = 'Con ngõ này trong khu phố cổ vô cùng chật hẹp, không những ô tô riêng không thể chạy vào, mà ngay cả hai chiếc xe đạp tránh nhau cũng rất khó khăn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '窄',
      'zhǎi',
      'hẹp, chật hẹp, eo hẹp',
      'Tính từ',
      'HSK 5',
      '老城区里这条巷道非常狭窄，不仅私家汽车无法驶入，就连两辆自行车交会都很困难。',
      'Lǎo chéngqū lǐ zhè tiáo xiàngdào fēicháng xiázhǎi, bù jǐn sījiā qìchē wúfǎ shǐrù, jiù lián liǎng liàng zìxíngchē jiāohuì dōu hěn kùnnan.',
      'Con ngõ này trong khu phố cổ vô cùng chật hẹp, không những ô tô riêng không thể chạy vào, mà ngay cả hai chiếc xe đạp tránh nhau cũng rất khó khăn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老城区里这条巷道非常狭窄，不仅私家汽车无法驶入，就连两辆自行车交会都很困难。', 'Lǎo chéngqū lǐ zhè tiáo xiàngdào fēicháng xiázhǎi, bù jǐn sījiā qìchē wúfǎ shǐrù, jiù lián liǎng liàng zìxíngchē jiāohuì dōu hěn kùnnan.', 'Con ngõ này trong khu phố cổ vô cùng chật hẹp, không những ô tô riêng không thể chạy vào, mà ngay cả hai chiếc xe đạp tránh nhau cũng rất khó khăn.', 'basic', 1),
      (v_id, '如果商业银行长期过度依赖传统的存贷款利差业务，其未来的盈利成长通道与抗风险边界必将变得极其狭窄。', 'Rúguǒ shāngyè yínháng chángqī guòdù yīlài chuántǒng de cún-dàikuǎn lìchā yèwù, qí wèilái de yínglì chéngzhǎng tōngdào yǔ kàng-fēngxiǎn biānjiè bìjiāng biàn de jíqí xiázhǎi.', 'Nếu ngân hàng thương mại phụ thuộc quá mức trong thời gian dài vào nghiệp vụ chênh lệch lãi suất tiền gửi và cho vay truyền thống, thì hành lang tăng trưởng lợi nhuận và biên độ chống chịu rủi ro trong tương lai của ngân hàng đó chắc chắn sẽ trở nên vô cùng eo hẹp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3463] [展出] (zhǎnchū) - trưng bày, triển lãm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '展出' AND pinyin = 'zhǎnchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展出' AND pinyin = 'zhǎnchū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '展出'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǎnchū',
      meaning_vi = 'trưng bày, triển lãm',
      example_hanzi = '市美术馆本周正在展出当代著名画家的数十幅山水油画力作，吸引了成百上千位艺术爱好者前来参观。',
      example_pinyin = 'Shì měishùguǎn běnzhōu zhèngzài zhǎnchū dāngdài zhùmíng huàjiā de shùshí fú shānshuǐ yóuhuà lìzuò, xīyǐn le chéngbǎi-shàngqiān wèi yìshù àihàozhě qiánlái cānguān.',
      example_vi = 'Bảo tàng mỹ thuật thành phố tuần này đang trưng bày hàng chục tác phẩm tranh sơn dầu phong cảnh kiệt xuất của các họa sĩ đương đại nổi tiếng, thu hút hàng trăm hàng nghìn người yêu nghệ thuật đến tham quan.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '展出',
      'zhǎnchū',
      'trưng bày, triển lãm',
      'Động từ',
      'HSK 5',
      '市美术馆本周正在展出当代著名画家的数十幅山水油画力作，吸引了成百上千位艺术爱好者前来参观。',
      'Shì měishùguǎn běnzhōu zhèngzài zhǎnchū dāngdài zhùmíng huàjiā de shùshí fú shānshuǐ yóuhuà lìzuò, xīyǐn le chéngbǎi-shàngqiān wèi yìshù àihàozhě qiánlái cānguān.',
      'Bảo tàng mỹ thuật thành phố tuần này đang trưng bày hàng chục tác phẩm tranh sơn dầu phong cảnh kiệt xuất của các họa sĩ đương đại nổi tiếng, thu hút hàng trăm hàng nghìn người yêu nghệ thuật đến tham quan.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '市美术馆本周正在展出当代著名画家的数十幅山水油画力作，吸引了成百上千位艺术爱好者前来参观。', 'Shì měishùguǎn běnzhōu zhèngzài zhǎnchū dāngdài zhùmíng huàjiā de shùshí fú shānshuǐ yóuhuà lìzuò, xīyǐn le chéngbǎi-shàngqiān wèi yìshù àihàozhě qiánlái cānguān.', 'Bảo tàng mỹ thuật thành phố tuần này đang trưng bày hàng chục tác phẩm tranh sơn dầu phong cảnh kiệt xuất của các họa sĩ đương đại nổi tiếng, thu hút hàng trăm hàng nghìn người yêu nghệ thuật đến tham quan.', 'basic', 1),
      (v_id, '在国际防务科技装备博览会上，我国自主研制的第六代隐身战斗机全尺寸概念模型首次向全球公众正式展出。', 'Zài guójì fángwù kējì zhuāngbèi bólǎnhuì shang, wǒguó zìzhǔ yánzhì de dì-liù dài yǐnshēn zhàndòujī quán-chǐcùn gèiniàn móxíng shǒucì xiàng quánqiú gōngzhòng zhèngshì zhǎnchū.', 'Tại hội chợ triển lãm thiết bị khoa học công nghệ quốc phòng quốc tế, mô hình ý niệm kích thước thực tế của máy bay chiến đấu tàng hình thế hệ thứ sáu do nước ta tự chủ nghiên cứu chế tạo lần đầu tiên được triển lãm chính thức trước công chúng toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3464] [展开] (zhǎnkāi) - triển khai, mở rộng, phát động; xòe ra [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '展开' AND pinyin = 'zhǎnkāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展开' AND pinyin = 'zhǎnkāi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '展开'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展开'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǎnkāi',
      meaning_vi = 'triển khai, mở rộng, phát động; xòe ra',
      example_hanzi = '班主任微笑着展开手中的奖状，在全班同学热烈的掌声中向获得第一名的学习小组颁发荣誉证书。',
      example_pinyin = 'Bānzhǔrèn wēixiào zhe zhǎnkāi shǒuzhōng de jiǎngzhuàng, zài quán bān tóngxué rèliè de zhǎngshēng zhōng xiàng huòdé dì-yī míng de xuéxí xiǎozǔ bānfā róngyù zhèngshū.',
      example_vi = 'Giáo viên chủ nhiệm mỉm cười mở tấm bằng khen trong tay ra, trao giấy chứng nhận danh dự cho nhóm học tập đạt giải nhất trong tiếng vỗ tay nồng nhiệt của cả lớp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '展开',
      'zhǎnkāi',
      'triển khai, mở rộng, phát động; xòe ra',
      'Động từ',
      'HSK 5',
      '班主任微笑着展开手中的奖状，在全班同学热烈的掌声中向获得第一名的学习小组颁发荣誉证书。',
      'Bānzhǔrèn wēixiào zhe zhǎnkāi shǒuzhōng de jiǎngzhuàng, zài quán bān tóngxué rèliè de zhǎngshēng zhōng xiàng huòdé dì-yī míng de xuéxí xiǎozǔ bānfā róngyù zhèngshū.',
      'Giáo viên chủ nhiệm mỉm cười mở tấm bằng khen trong tay ra, trao giấy chứng nhận danh dự cho nhóm học tập đạt giải nhất trong tiếng vỗ tay nồng nhiệt của cả lớp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '班主任微笑着展开手中的奖状，在全班同学热烈的掌声中向获得第一名的学习小组颁发荣誉证书。', 'Bānzhǔrèn wēixiào zhe zhǎnkāi shǒuzhōng de jiǎngzhuàng, zài quán bān tóngxué rèliè de zhǎngshēng zhōng xiàng huòdé dì-yī míng de xuéxí xiǎozǔ bānfā róngyù zhèngshū.', 'Giáo viên chủ nhiệm mỉm cười mở tấm bằng khen trong tay ra, trao giấy chứng nhận danh dự cho nhóm học tập đạt giải nhất trong tiếng vỗ tay nồng nhiệt của cả lớp.', 'basic', 1),
      (v_id, '多国联合深海科考队借助深潜器，在马里亚纳海沟底部万米极限深渊全面展开了地质构造采样与未知微生物勘探。', 'Duōguó liánhé shēnhǎi kēkǎoduì jièzhù shēnqiǎnqì, zài Mǎlǐyànà Hǎigōu dǐbù wànmǐ jíxiàn shēnyuān quánmiàn zhǎnkāi le dìzhì gòuzào cǎiyàng yǔ wèizhī wēishēngwù kāntàn.', 'Đội khảo sát khoa học biển sâu liên hợp đa quốc gia nhờ có tàu lặn sâu đã triển khai toàn diện việc lấy mẫu cấu tạo địa chất và thăm dò vi sinh vật chưa từng biết dưới vực sâu cực hạn một vạn mét ở đáy rãnh Mariana.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3465] [展览] (zhǎnlǎn) - triển lãm, trưng bày [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '展览' AND pinyin = 'zhǎnlǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展览' AND pinyin = 'zhǎnlǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '展览'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展览'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhǎnlǎn',
      meaning_vi = 'triển lãm, trưng bày',
      example_hanzi = '科技馆下个月将举办一场关于太空探索与火箭发射的互动式科普展览，非常适合中小学生前来体验。',
      example_pinyin = 'Kējìguǎn xià ge yuè jiāng jǔbàn yì chǎng guānyú tàikōng tànsuǒ yǔ huǒjiàn fāshè de hùdòngshì kēpǔ zhǎnlǎn, fēicháng shìhé zhōng-xiǎoxuésheng qiánlái tǐyàn.',
      example_vi = 'Bảo tàng khoa học công nghệ tháng tới sẽ tổ chức một triển lãm phổ biến khoa học dạng tương tác về khám phá vũ trụ và phóng tên lửa, rất thích hợp cho học sinh tiểu học và trung học đến trải nghiệm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '展览',
      'zhǎnlǎn',
      'triển lãm, trưng bày',
      'Động từ / Danh từ',
      'HSK 5',
      '科技馆下个月将举办一场关于太空探索与火箭发射的互动式科普展览，非常适合中小学生前来体验。',
      'Kējìguǎn xià ge yuè jiāng jǔbàn yì chǎng guānyú tàikōng tànsuǒ yǔ huǒjiàn fāshè de hùdòngshì kēpǔ zhǎnlǎn, fēicháng shìhé zhōng-xiǎoxuésheng qiánlái tǐyàn.',
      'Bảo tàng khoa học công nghệ tháng tới sẽ tổ chức một triển lãm phổ biến khoa học dạng tương tác về khám phá vũ trụ và phóng tên lửa, rất thích hợp cho học sinh tiểu học và trung học đến trải nghiệm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '科技馆下个月将举办一场关于太空探索与火箭发射的互动式科普展览，非常适合中小学生前来体验。', 'Kējìguǎn xià ge yuè jiāng jǔbàn yì chǎng guānyú tàikōng tànsuǒ yǔ huǒjiàn fāshè de hùdòngshì kēpǔ zhǎnlǎn, fēicháng shìhé zhōng-xiǎoxuésheng qiánlái tǐyàn.', 'Bảo tàng khoa học công nghệ tháng tới sẽ tổ chức một triển lãm phổ biến khoa học dạng tương tác về khám phá vũ trụ và phóng tên lửa, rất thích hợp cho học sinh tiểu học và trung học đến trải nghiệm.', 'basic', 1),
      (v_id, '进博会设立了前沿生物医药创新技术核心展览专区，集中呈现了全球数十款突破性靶向抗癌创新药与基因编辑治疗设备。', 'Jìnbóhuì shèlì le qiányán shēngwù yīyào chuàngxīn jìshù héxīn zhǎnlǎn zhuānqū, jízhōng chéngxiàn le quánqiú shùshí kuǎn tūpòxìng bǎxiàng kàng''ái chuàngxīnyào yǔ jīyīn biānjí zhìliáo shèbèi.', 'Hội chợ nhập khẩu quốc tế đã thành lập khu chuyên đề triển lãm cốt lõi về công nghệ đổi mới y dược sinh học tiên phong, hội tụ trưng bày hàng chục loại thuốc kháng ung thư nhắm trúng đích đột phá và thiết bị điều trị chỉnh sửa gen trên toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3466] [展示] (zhǎnshì) - trưng bày, thể hiện, phô diễn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '展示' AND pinyin = 'zhǎnshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展示' AND pinyin = 'zhǎnshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '展示'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展示'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhǎnshì',
      meaning_vi = 'trưng bày, thể hiện, phô diễn',
      example_hanzi = '在今天下午的年终汇报会议上，小王用精心制作的幻灯片向客户生动展示了项目取得的丰硕成果。',
      example_pinyin = 'Zài jīntiān xiàwǔ de niánzhōng huìbào huìyì shang, Xiǎo Wáng yòng jīngxīn zhìzuò de huàndēngpiàn xiàng kèhù shēngdòng zhǎnshì le xiàngmù qǔdé de fēngshuò chéngguǒ.',
      example_vi = 'Trong cuộc họp báo cáo cuối năm chiều nay, Tiểu Vương đã dùng các slide trình chiếu chuẩn bị kỹ càng để trình diễn sinh động trước khách hàng những thành quả bội thu mà dự án đạt được.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '展示',
      'zhǎnshì',
      'trưng bày, thể hiện, phô diễn',
      'Động từ / Danh từ',
      'HSK 5',
      '在今天下午的年终汇报会议上，小王用精心制作的幻灯片向客户生动展示了项目取得的丰硕成果。',
      'Zài jīntiān xiàwǔ de niánzhōng huìbào huìyì shang, Xiǎo Wáng yòng jīngxīn zhìzuò de huàndēngpiàn xiàng kèhù shēngdòng zhǎnshì le xiàngmù qǔdé de fēngshuò chéngguǒ.',
      'Trong cuộc họp báo cáo cuối năm chiều nay, Tiểu Vương đã dùng các slide trình chiếu chuẩn bị kỹ càng để trình diễn sinh động trước khách hàng những thành quả bội thu mà dự án đạt được.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在今天下午的年终汇报会议上，小王用精心制作的幻灯片向客户生动展示了项目取得的丰硕成果。', 'Zài jīntiān xiàwǔ de niánzhōng huìbào huìyì shang, Xiǎo Wáng yòng jīngxīn zhìzuò de huàndēngpiàn xiàng kèhù shēngdòng zhǎnshì le xiàngmù qǔdé de fēngshuò chéngguǒ.', 'Trong cuộc họp báo cáo cuối năm chiều nay, Tiểu Vương đã dùng các slide trình chiếu chuẩn bị kỹ càng để trình diễn sinh động trước khách hàng những thành quả bội thu mà dự án đạt được.', 'basic', 1),
      (v_id, '智能网联新能源概念车在车展上集中展示了厘米级激光雷达多传感器融合、全场景自动泊车与端到端大模型赋能的高阶智驾系统。', 'Zhìnéng wǎnglián xīnnéngyuán gèiniànchē zài chēzhǎn shang jízhōng zhǎnshì le límǐjí jīguāng léidá duō-chuángǎnqì rónghé, quán-chǎnjǐng zìdòng bōchē yǔ duāndàoduān dà-móxíng fùnéng de gāojiē zhìjià xìtǒng.', 'Mẫu xe ý niệm năng lượng mới kết nối mạng thông minh tại triển lãm ô tô đã phô diễn tập trung hệ thống lái thông minh bậc cao được tiếp sức bởi mô hình lớn đầu cuối kết hợp đa cảm biến LiDAR cấp centimet và tự động đỗ xe toàn cảnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3467] [展现] (zhǎnxiàn) - thể hiện, bộc lộ, mở ra, phô bày [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '展现' AND pinyin = 'zhǎnxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展现' AND pinyin = 'zhǎnxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '展现'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '展现'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǎnxiàn',
      meaning_vi = 'thể hiện, bộc lộ, mở ra, phô bày',
      example_hanzi = '年轻一代运动员在奥运赛场上顽强拼搏、永不放弃，展现出了充满朝气与活力的青春风采。',
      example_pinyin = 'Niánqīng yídài yùndòngyuán zài Àoyùn sàichǎng shang wánqiáng pīnbó, yǒng bù fàngqì, zhǎnxiàn chū le chōngmǎn zhāoqì yǔ huólì de qīngchūn fēngcǎi.',
      example_vi = 'Thế hệ vận động viên trẻ kiên cường nỗ lực thi đấu trên đấu trường Olympic, không bao giờ bỏ cuộc, thể hiện phong thái thanh xuân tràn đầy sức sống và sinh lực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '展现',
      'zhǎnxiàn',
      'thể hiện, bộc lộ, mở ra, phô bày',
      'Động từ',
      'HSK 5',
      '年轻一代运动员在奥运赛场上顽强拼搏、永不放弃，展现出了充满朝气与活力的青春风采。',
      'Niánqīng yídài yùndòngyuán zài Àoyùn sàichǎng shang wánqiáng pīnbó, yǒng bù fàngqì, zhǎnxiàn chū le chōngmǎn zhāoqì yǔ huólì de qīngchūn fēngcǎi.',
      'Thế hệ vận động viên trẻ kiên cường nỗ lực thi đấu trên đấu trường Olympic, không bao giờ bỏ cuộc, thể hiện phong thái thanh xuân tràn đầy sức sống và sinh lực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '年轻一代运动员在奥运赛场上顽强拼搏、永不放弃，展现出了充满朝气与活力的青春风采。', 'Niánqīng yídài yùndòngyuán zài Àoyùn sàichǎng shang wánqiáng pīnbó, yǒng bù fàngqì, zhǎnxiàn chū le chōngmǎn zhāoqì yǔ huólì de qīngchūn fēngcǎi.', 'Thế hệ vận động viên trẻ kiên cường nỗ lực thi đấu trên đấu trường Olympic, không bao giờ bỏ cuộc, thể hiện phong thái thanh xuân tràn đầy sức sống và sinh lực.', 'basic', 1),
      (v_id, '大型全景历史纪录片运用超高清航拍与逼真三维特效，波澜壮阔地展现了古代海上丝绸之路繁荣多元的文明互鉴历史图景。', 'Dàxíng quánjǐng lìshǐ jìlùpiàn yùnyòng chāo-gāoqīng hángpāi yǔ bīzhēn sānwéi tèxiào, bōlán-zhuàngkuò de zhǎnxiàn le gǔdài hǎishàng sīchóuzhīlù fánróng duōyuán de wénmíng hùjiàn lìshǐ tújǐng.', 'Bộ phim tài liệu lịch sử toàn cảnh quy mô lớn vận dụng flycam siêu nét và kỹ xảo 3D chân thực, tái hiện lại một cách hoành tráng bức tranh lịch sử giao lưu học hỏi lẫn nhau của các nền văn minh phồn vinh đa nguyên trên con đường tơ lụa trên biển thời cổ đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3468] [占] (zhàn) - chiếm, chiếm lĩnh, chiếm cứ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '占' AND pinyin = 'zhàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '占' AND pinyin = 'zhàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '占'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '占'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhàn',
      meaning_vi = 'chiếm, chiếm lĩnh, chiếm cứ',
      example_hanzi = '这台笨重的大衣柜立在小卧室里太占地方，导致连一张简易书桌都摆放不下了。',
      example_pinyin = 'Zhè tái bènzhòng de dà yīguì lì zài xiǎo wòshì lǐ tài zhàn dìfang, dǎozhì lián yì zhāng jiǎnyì shūzhuō dōu bǎifàng bu xià le.',
      example_vi = 'Chiếc tủ quần áo cồng kềnh thô kệch này kê trong phòng ngủ nhỏ quá chiếm diện tích, dẫn đến việc ngay cả một chiếc bàn học đơn giản cũng không kê vừa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '占',
      'zhàn',
      'chiếm, chiếm lĩnh, chiếm cứ',
      'Động từ',
      'HSK 5',
      '这台笨重的大衣柜立在小卧室里太占地方，导致连一张简易书桌都摆放不下了。',
      'Zhè tái bènzhòng de dà yīguì lì zài xiǎo wòshì lǐ tài zhàn dìfang, dǎozhì lián yì zhāng jiǎnyì shūzhuō dōu bǎifàng bu xià le.',
      'Chiếc tủ quần áo cồng kềnh thô kệch này kê trong phòng ngủ nhỏ quá chiếm diện tích, dẫn đến việc ngay cả một chiếc bàn học đơn giản cũng không kê vừa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这台笨重的大衣柜立在小卧室里太占地方，导致连一张简易书桌都摆放不下了。', 'Zhè tái bènzhòng de dà yīguì lì zài xiǎo wòshì lǐ tài zhàn dìfang, dǎozhì lián yì zhāng jiǎnyì shūzhuō dōu bǎifàng bu xià le.', 'Chiếc tủ quần áo cồng kềnh thô kệch này kê trong phòng ngủ nhỏ quá chiếm diện tích, dẫn đến việc ngay cả một chiếc bàn học đơn giản cũng không kê vừa.', 'basic', 1),
      (v_id, '高技术制造业增加值在全部规模以上工业增加值中所占的比重持续提升，成为拉动国民经济高质量平稳增长的新引擎。', 'Gāojìshù zhìzàoyè zēngjiāzhí zài quánbù guīmó yǐshàng gōngyè zēngjiāzhí zhōng suǒ zhàn de bǐzhòng chíxù tíshēng, chéngwéi lādòng guómín jīngjì gāozhìliàng píngwěn zēngzhǎng de xīn yǐnqíng.', 'Tỷ trọng giá trị gia tăng của ngành công nghiệp chế tạo công nghệ cao trong toàn bộ giá trị gia tăng công nghiệp quy mô lớn liên tục tăng lên, trở thành động cơ mới kéo nền kinh tế quốc dân tăng trưởng chất lượng cao và vững chắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3469] [站台] (zhàntái) - sân ga, ke ga (tàu hỏa, tàu điện ngầm) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '站台' AND pinyin = 'zhàntái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '站台' AND pinyin = 'zhàntái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '站台'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '站台'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhàntái',
      meaning_vi = 'sân ga, ke ga (tàu hỏa, tàu điện ngầm)',
      example_hanzi = '列车即将进站，火车站广播反复提醒站台上的候车旅客退到黄色安全警戒线以内等候。',
      example_pinyin = 'Lièchē jíjiāng jìnzhàn, huǒchēzhàn guǎngbō fǎnfù tíxǐng zhàntái shang de hòuchē lǚkè tuì dào huángsè ānquán jǐngjièxiàn yǐnèi děnghòu.',
      example_vi = 'Tàu hỏa sắp vào ga, loa phát thanh của ga tàu hỏa liên tục nhắc nhở hành khách đứng đợi trên sân ga lùi vào phía trong vạch cảnh giới an toàn màu vàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '站台',
      'zhàntái',
      'sân ga, ke ga (tàu hỏa, tàu điện ngầm)',
      'Danh từ',
      'HSK 5',
      '列车即将进站，火车站广播反复提醒站台上的候车旅客退到黄色安全警戒线以内等候。',
      'Lièchē jíjiāng jìnzhàn, huǒchēzhàn guǎngbō fǎnfù tíxǐng zhàntái shang de hòuchē lǚkè tuì dào huángsè ānquán jǐngjièxiàn yǐnèi děnghòu.',
      'Tàu hỏa sắp vào ga, loa phát thanh của ga tàu hỏa liên tục nhắc nhở hành khách đứng đợi trên sân ga lùi vào phía trong vạch cảnh giới an toàn màu vàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '列车即将进站，火车站广播反复提醒站台上的候车旅客退到黄色安全警戒线以内等候。', 'Lièchē jíjiāng jìnzhàn, huǒchēzhàn guǎngbō fǎnfù tíxǐng zhàntái shang de hòuchē lǚkè tuì dào huángsè ānquán jǐngjièxiàn yǐnèi děnghòu.', 'Tàu hỏa sắp vào ga, loa phát thanh của ga tàu hỏa liên tục nhắc nhở hành khách đứng đợi trên sân ga lùi vào phía trong vạch cảnh giới an toàn màu vàng.', 'basic', 1),
      (v_id, '现代化综合智慧交通枢纽在地下高铁站台全面加装全封闭智能安全屏蔽门与毫米波客流防挤压监测传感装置。', 'Xiàndàihuà zōnghé zhìhuì jiāotōng shūniǔ zài dìxià gāotiě zhàntái quánmiàn jiāzhuāng quán-fēngbì zhìnéng ānquán píngbìmén yǔ háomǐbō kèliú fáng-jǐyā jiāncè chuángǎn zhuāngzhì.', 'Đầu mối giao thông thông minh tổng hợp hiện đại đã lắp đặt toàn diện cửa chắn an toàn thông minh khép kín hoàn toàn và thiết bị cảm biến giám sát chống chèn ép luồng hành khách bằng sóng milimet tại ke ga đường sắt cao tốc dưới lòng đất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3470] [占线] (zhànxiàn) - máy bận, đường dây bận [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '占线' AND pinyin = 'zhànxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '占线' AND pinyin = 'zhànxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '占线'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '占线'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhànxiàn',
      meaning_vi = 'máy bận, đường dây bận',
      example_hanzi = '我今天下午连续给经理打了好几个电话想要汇报工作，但话筒那端一直提示对方正在占线中。',
      example_pinyin = 'Wǒ jīntiān xiàwǔ liánxù gěi jīnglǐ dǎ le hǎo jǐ ge diànhuà xiǎng yào huìbào gōngzuò, dàn huàtǒng nà duān yìzhí tíshì duìfāng zhèngzài zhànxiàn zhōng.',
      example_vi = 'Chiều nay tôi liên tục gọi mấy cuộc điện thoại cho giám đốc muốn báo cáo công việc, nhưng đầu máy bên kia cứ liên tục thông báo đối phương đang bận máy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '占线',
      'zhànxiàn',
      'máy bận, đường dây bận',
      'Động từ',
      'HSK 5',
      '我今天下午连续给经理打了好几个电话想要汇报工作，但话筒那端一直提示对方正在占线中。',
      'Wǒ jīntiān xiàwǔ liánxù gěi jīnglǐ dǎ le hǎo jǐ ge diànhuà xiǎng yào huìbào gōngzuò, dàn huàtǒng nà duān yìzhí tíshì duìfāng zhèngzài zhànxiàn zhōng.',
      'Chiều nay tôi liên tục gọi mấy cuộc điện thoại cho giám đốc muốn báo cáo công việc, nhưng đầu máy bên kia cứ liên tục thông báo đối phương đang bận máy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我今天下午连续给经理打了好几个电话想要汇报工作，但话筒那端一直提示对方正在占线中。', 'Wǒ jīntiān xiàwǔ liánxù gěi jīnglǐ dǎ le hǎo jǐ ge diànhuà xiǎng yào huìbào gōngzuò, dàn huàtǒng nà duān yìzhí tíshì duìfāng zhèngzài zhànxiàn zhōng.', 'Chiều nay tôi liên tục gọi mấy cuộc điện thoại cho giám đốc muốn báo cáo công việc, nhưng đầu máy bên kia cứ liên tục thông báo đối phương đang bận máy.', 'basic', 1),
      (v_id, '在极端灾害天气引发电网故障的报修高峰期，智能云呼叫中心通过弹性动态话务路由分配策略，彻底消除了传统热线大面积占线拥堵难题。', 'Zài jíduān zāihài tiānqì yǐnfā diànwǎng gùzhàng de bàoxiū gāofēngqī, zhìnéng yún-hūjiào zhōngxīn tōngguò tánxìng dòngtài huàwù lùyóu fēnpèi cèlüè, chèdǐ xiāochú le chuántǒng rèxiàn dà-miànjī zhànxiàn yōngdǔ nántí.', 'Vào đợt cao điểm báo hỏng do thời tiết thiên tai cực đoan làm phát sinh sự cố lưới điện, trung tâm điều hành cuộc gọi đám mây thông minh thông qua chiến lược định tuyến lưu lượng cuộc gọi động co giãn linh hoạt đã loại bỏ triệt để vấn nạn nghẽn mạng bận máy diện rộng của đường dây nóng truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3471] [涨] (zhǎng) - tăng lên, dâng lên (giá cả, con nước) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '涨' AND pinyin = 'zhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '涨' AND pinyin = 'zhǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '涨'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '涨'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǎng',
      meaning_vi = 'tăng lên, dâng lên (giá cả, con nước)',
      example_hanzi = '经过连续几天的大暴雨，村头原本清澈见底的小河水位突然猛涨，漫过了两岸的堤坝。',
      example_pinyin = 'Jīngguò liánxù jǐ tiān de dà bàoyǔ, cūntóu yuánběn qīngchè-jiàndǐ de xiǎohé shuǐwèi tūrán měng zhǎng, màn guò le liǎng''àn de dībà.',
      example_vi = 'Trải qua mấy ngày mưa to liên tục, mực nước con sông nhỏ vốn trong vắt nhìn thấy đáy ở đầu thôn bỗng dâng vọt dữ dội, tràn qua bờ đê hai bên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '涨',
      'zhǎng',
      'tăng lên, dâng lên (giá cả, con nước)',
      'Động từ',
      'HSK 5',
      '经过连续几天的大暴雨，村头原本清澈见底的小河水位突然猛涨，漫过了两岸的堤坝。',
      'Jīngguò liánxù jǐ tiān de dà bàoyǔ, cūntóu yuánběn qīngchè-jiàndǐ de xiǎohé shuǐwèi tūrán měng zhǎng, màn guò le liǎng''àn de dībà.',
      'Trải qua mấy ngày mưa to liên tục, mực nước con sông nhỏ vốn trong vắt nhìn thấy đáy ở đầu thôn bỗng dâng vọt dữ dội, tràn qua bờ đê hai bên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过连续几天的大暴雨，村头原本清澈见底的小河水位突然猛涨，漫过了两岸的堤坝。', 'Jīngguò liánxù jǐ tiān de dà bàoyǔ, cūntóu yuánběn qīngchè-jiàndǐ de xiǎohé shuǐwèi tūrán měng zhǎng, màn guò le liǎng''àn de dībà.', 'Trải qua mấy ngày mưa to liên tục, mực nước con sông nhỏ vốn trong vắt nhìn thấy đáy ở đầu thôn bỗng dâng vọt dữ dội, tràn qua bờ đê hai bên.', 'basic', 1),
      (v_id, '在全球通胀高企与地缘冲突加剧的双重影响下，国际原油与工业有色金属期货结算价格呈现跳空暴涨态势。', 'Zài quánqiú tōngzhàng gāoqǐ yǔ dìyuán chōngtū jiājù de shuāngzhòng yǐngxiǎng xià, guójì yuányóu yǔ gōngyè yǒusè jīnshǔ qīhuò jiésuàn jiàgé chéngxiàn tiàokōng bàozhǎng tàishì.', 'Dưới tác động kép của lạm phát toàn cầu neo cao và xung đột địa chính trị leo thang, giá thanh toán hợp đồng tương lai dầu thô và kim loại màu công nghiệp quốc tế xuất hiện thế tăng dựng đứng bùng nổ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3472] [涨价] (zhǎngjià) - tăng giá, lên giá [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '涨价' AND pinyin = 'zhǎngjià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '涨价' AND pinyin = 'zhǎngjià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '涨价'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '涨价'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǎngjià',
      meaning_vi = 'tăng giá, lên giá',
      example_hanzi = '这家老字号面馆在店门口张贴告示，由于近期面粉和食用油成本上升，所有面食从下周起每碗涨价两元。',
      example_pinyin = 'Zhè jiā lǎozìhào miànguǎn zài diàn ménkǒu zhāngtiē gàoshì, yóuyú jìnqī miànfěn hé shíyòngyóu chéngběn shàngshēng, suǒyǒu miànshí cóng xià zhōu qǐ měi wǎn zhǎngjià liǎng yuán.',
      example_vi = 'Quán mì lâu đời này dán thông báo ở cửa tiệm, do chi phí bột mì và dầu ăn gần đây tăng lên, từ tuần sau tất cả các món mì mỗi bát sẽ tăng giá thêm hai tệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '涨价',
      'zhǎngjià',
      'tăng giá, lên giá',
      'Động từ',
      'HSK 5',
      '这家老字号面馆在店门口张贴告示，由于近期面粉和食用油成本上升，所有面食从下周起每碗涨价两元。',
      'Zhè jiā lǎozìhào miànguǎn zài diàn ménkǒu zhāngtiē gàoshì, yóuyú jìnqī miànfěn hé shíyòngyóu chéngběn shàngshēng, suǒyǒu miànshí cóng xià zhōu qǐ měi wǎn zhǎngjià liǎng yuán.',
      'Quán mì lâu đời này dán thông báo ở cửa tiệm, do chi phí bột mì và dầu ăn gần đây tăng lên, từ tuần sau tất cả các món mì mỗi bát sẽ tăng giá thêm hai tệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家老字号面馆在店门口张贴告示，由于近期面粉和食用油成本上升，所有面食从下周起每碗涨价两元。', 'Zhè jiā lǎozìhào miànguǎn zài diàn ménkǒu zhāngtiē gàoshì, yóuyú jìnqī miànfěn hé shíyòngyóu chéngběn shàngshēng, suǒyǒu miànshí cóng xià zhōu qǐ měi wǎn zhǎngjià liǎng yuán.', 'Quán mì lâu đời này dán thông báo ở cửa tiệm, do chi phí bột mì và dầu ăn gần đây tăng lên, từ tuần sau tất cả các món mì mỗi bát sẽ tăng giá thêm hai tệ.', 'basic', 1),
      (v_id, '半导体先进制程晶圆代工制造巨头正式向全球芯片设计客户发出全线涨价通知，以此转嫁上游关键特种化学材料与光刻机折旧压力。', 'Bàndǎotǐ xiānjìn zhìchéng jīngyuán dàigōng zhìzào jùtóu zhèngshì xiàng quánqiú xīnpiàn shèjì kèhù fāchū quánxiàn zhǎngjià tōngzhī, yǐcǐ zhuǎnjià shàngyóu guānjiàn tèzhǒng huàxué cáiliào yǔ guāngkèjī zhéjiù yālì.', 'Gã khổng lồ chế tạo gia công tấm bán dẫn tiến trình tiên tiến đã chính thức gửi thông báo tăng giá toàn diện tới các khách hàng thiết kế chip toàn cầu, nhằm chuyển giao áp lực khấu hao máy quang khắc và hóa chất đặc chủng then chốt ở thượng nguồn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3473] [掌声] (zhǎngshēng) - tiếng vỗ tay, tràng pháo tay [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '掌声' AND pinyin = 'zhǎngshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '掌声' AND pinyin = 'zhǎngshēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '掌声'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '掌声'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhǎngshēng',
      meaning_vi = 'tiếng vỗ tay, tràng pháo tay',
      example_hanzi = '当钢琴演奏家深情弹完最后一个音符并优雅起身鞠躬致谢时，音乐厅里响起了经久不息的热烈掌声。',
      example_pinyin = 'Dāng gāngqín yǎnzòujiā shēnqíng tán wán zuìhòu yí ge yīnfú bìng yōuyǎ qǐshēn jūgōng zhìxiè shí, yīnyuètīng lǐ xiǎng qǐ le jīngjiǔ-bùxī de rèliè zhǎngshēng.',
      example_vi = 'Khi nghệ sĩ dương cầm dạt dào cảm xúc đánh xong nốt nhạc cuối cùng và tao nhã đứng dậy cúi đầu cảm tạ, thính phòng âm nhạc vang lên những tràng pháo tay nồng nhiệt kéo dài không ngớt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '掌声',
      'zhǎngshēng',
      'tiếng vỗ tay, tràng pháo tay',
      'Danh từ',
      'HSK 5',
      '当钢琴演奏家深情弹完最后一个音符并优雅起身鞠躬致谢时，音乐厅里响起了经久不息的热烈掌声。',
      'Dāng gāngqín yǎnzòujiā shēnqíng tán wán zuìhòu yí ge yīnfú bìng yōuyǎ qǐshēn jūgōng zhìxiè shí, yīnyuètīng lǐ xiǎng qǐ le jīngjiǔ-bùxī de rèliè zhǎngshēng.',
      'Khi nghệ sĩ dương cầm dạt dào cảm xúc đánh xong nốt nhạc cuối cùng và tao nhã đứng dậy cúi đầu cảm tạ, thính phòng âm nhạc vang lên những tràng pháo tay nồng nhiệt kéo dài không ngớt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '当钢琴演奏家深情弹完最后一个音符并优雅起身鞠躬致谢时，音乐厅里响起了经久不息的热烈掌声。', 'Dāng gāngqín yǎnzòujiā shēnqíng tán wán zuìhòu yí ge yīnfú bìng yōuyǎ qǐshēn jūgōng zhìxiè shí, yīnyuètīng lǐ xiǎng qǐ le jīngjiǔ-bùxī de rèliè zhǎngshēng.', 'Khi nghệ sĩ dương cầm dạt dào cảm xúc đánh xong nốt nhạc cuối cùng và tao nhã đứng dậy cúi đầu cảm tạ, thính phòng âm nhạc vang lên những tràng pháo tay nồng nhiệt kéo dài không ngớt.', 'basic', 1),
      (v_id, '在联合国气候峰会闭幕全体会议上，具有里程碑意义的历史性减排共识决议草案获得全场代表起立致敬与雷鸣般的掌声通过。', 'Zài Liánhéguó qìhòu fēnghuì bìmù quántǐ huìyì shang, jùyǒu lǐchéngbēi yìyì de lìshǐxìng jiǎnpái gòngshí juéyì cǎo''àn huòdé quánchǎng dàibiǎo qǐlì zhìjìng yǔ léimíng bānde zhǎngshēng tōngguò.', 'Tại phiên bế mạc toàn thể hội nghị thượng đỉnh khí hậu của Liên Hợp Quốc, dự thảo nghị quyết đồng thuận cắt giảm phát thải mang tính lịch sử và có ý nghĩa cột mốc đã được toàn thể đại biểu đứng dậy bày tỏ lòng kính trọng và thông qua trong tiếng vỗ tay như sấm rền.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3474] [掌握] (zhǎngwò) - nắm vững, làm chủ, kiểm soát [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '掌握' AND pinyin = 'zhǎngwò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '掌握' AND pinyin = 'zhǎngwò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '掌握'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '掌握'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǎngwò',
      meaning_vi = 'nắm vững, làm chủ, kiểm soát',
      example_hanzi = '想要在激烈的就业市场中找到一份称心如意的工作，首先要扎实掌握自己的专业核心知识与技能。',
      example_pinyin = 'Xiǎng yào zài jīliè de jiùyè shìchǎng zhōng zhǎodào yí fèn chènxīn-rúyì de gōngzuò, shǒuxiān yào zhāshi zhǎngwò zìjǐ de zhuānyè héxīn zhīshi yǔ jìnéng.',
      example_vi = 'Muốn tìm được một công việc vừa ý trong thị trường việc làm cạnh tranh khốc liệt, trước tiên phải nắm vững thật chắc chắn kiến thức và kỹ năng chuyên môn cốt lõi của bản thân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '掌握',
      'zhǎngwò',
      'nắm vững, làm chủ, kiểm soát',
      'Động từ',
      'HSK 5',
      '想要在激烈的就业市场中找到一份称心如意的工作，首先要扎实掌握自己的专业核心知识与技能。',
      'Xiǎng yào zài jīliè de jiùyè shìchǎng zhōng zhǎodào yí fèn chènxīn-rúyì de gōngzuò, shǒuxiān yào zhāshi zhǎngwò zìjǐ de zhuānyè héxīn zhīshi yǔ jìnéng.',
      'Muốn tìm được một công việc vừa ý trong thị trường việc làm cạnh tranh khốc liệt, trước tiên phải nắm vững thật chắc chắn kiến thức và kỹ năng chuyên môn cốt lõi của bản thân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '想要在激烈的就业市场中找到一份称心如意的工作，首先要扎实掌握自己的专业核心知识与技能。', 'Xiǎng yào zài jīliè de jiùyè shìchǎng zhōng zhǎodào yí fèn chènxīn-rúyì de gōngzuò, shǒuxiān yào zhāshi zhǎngwò zìjǐ de zhuānyè héxīn zhīshi yǔ jìnéng.', 'Muốn tìm được một công việc vừa ý trong thị trường việc làm cạnh tranh khốc liệt, trước tiên phải nắm vững thật chắc chắn kiến thức và kỹ năng chuyên môn cốt lõi của bản thân.', 'basic', 1),
      (v_id, '国家唯有牢牢掌握深空通信与自主可控航天测控网络核心技术，才能确保星际深空探测器在亿万公里之外的精确测控与指令执行。', 'Guójiā wéiyǒu láoláo zhǎngwò shēnkōng tōngxìn yǔ zìzhǔ kěkòng hángtiān cèkòng wǎngluò héxīn jìshù, cáinéng quèbǎo xīngjì shēnkōng tàncèqì zài yìwàn gōnglǐ zhīwài de jīngquè cèkòng yǔ zhǐlìng zhíxíng.', 'Quốc gia chỉ khi nắm vững chắc chắn công nghệ cốt lõi của mạng lưới đo kiểm điều khiển vũ trụ tự chủ kiểm soát và thông tin vũ trụ sâu, mới có thể bảo đảm việc đo kiểm điều khiển chính xác và thực thi mệnh lệnh của tàu thăm dò không gian liên sao cách xa hàng ức cây số.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3475] [账号] (zhànghào) - số tài khoản, tên tài khoản (người dùng/đăng nhập) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '账号' AND pinyin = 'zhànghào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '账号' AND pinyin = 'zhànghào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '账号'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '账号'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhànghào',
      meaning_vi = 'số tài khoản, tên tài khoản (người dùng/đăng nhập)',
      example_hanzi = '为了保障您的个人财产与社交隐私安全，请切勿将您的网站登录账号和密码轻易透露给任何陌生人。',
      example_pinyin = 'Wèile bǎozhàng nín de gèrén cáichǎn yǔ shèjiāo yǐnsī ānquán, qǐng qièwù jiāng nín de wǎngzhàn dēnglù zhànghào hé mìmǎ qīngyì tòulù gěi rènhé mòshēngrén.',
      example_vi = 'Để bảo đảm an toàn tài sản cá nhân và quyền riêng tư mạng xã hội của quý vị, xin tuyệt đối đừng tùy tiện tiết lộ tài khoản đăng nhập và mật khẩu trang web của mình cho bất kỳ người lạ nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '账号',
      'zhànghào',
      'số tài khoản, tên tài khoản (người dùng/đăng nhập)',
      'Danh từ',
      'HSK 5',
      '为了保障您的个人财产与社交隐私安全，请切勿将您的网站登录账号和密码轻易透露给任何陌生人。',
      'Wèile bǎozhàng nín de gèrén cáichǎn yǔ shèjiāo yǐnsī ānquán, qǐng qièwù jiāng nín de wǎngzhàn dēnglù zhànghào hé mìmǎ qīngyì tòulù gěi rènhé mòshēngrén.',
      'Để bảo đảm an toàn tài sản cá nhân và quyền riêng tư mạng xã hội của quý vị, xin tuyệt đối đừng tùy tiện tiết lộ tài khoản đăng nhập và mật khẩu trang web của mình cho bất kỳ người lạ nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了保障您的个人财产与社交隐私安全，请切勿将您的网站登录账号和密码轻易透露给任何陌生人。', 'Wèile bǎozhàng nín de gèrén cáichǎn yǔ shèjiāo yǐnsī ānquán, qǐng qièwù jiāng nín de wǎngzhàn dēnglù zhànghào hé mìmǎ qīngyì tòulù gěi rènhé mòshēngrén.', 'Để bảo đảm an toàn tài sản cá nhân và quyền riêng tư mạng xã hội của quý vị, xin tuyệt đối đừng tùy tiện tiết lộ tài khoản đăng nhập và mật khẩu trang web của mình cho bất kỳ người lạ nào.', 'basic', 1),
      (v_id, '企业级零信任安全体系强制对特权管理账号实施基于硬件密匙的多因子身份认证与基于行为基线的动态权限审计。', 'Qǐyèjí líng-xìnrèn ānquán tǐxì qiángzhì duì tèquán guǎnlǐ zhànghào shíshī jīyú yìngjiàn mìshí de duō-yīnzǐ shēnfèn rènzhèng yǔ jīyú xíngwéi jīxiàn de dòngtài quánxián shěnjì.', 'Hệ thống an ninh không tin cậy (Zero Trust) cấp doanh nghiệp bắt buộc thực thi xác thực danh tính đa yếu tố dựa trên khóa cứng vật lý và kiểm toán phân quyền động dựa trên hành vi cơ sở đối với các tài khoản quản trị đặc quyền.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3476] [账户] (zhànghù) - tài khoản (ngân hàng, tài chính, thanh toán) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '账户' AND pinyin = 'zhànghù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '账户' AND pinyin = 'zhànghù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '账户'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '账户'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhànghù',
      meaning_vi = 'tài khoản (ngân hàng, tài chính, thanh toán)',
      example_hanzi = '如果需要将每个月的工资自动转入存折，你可以去银行柜台办理一张联名储蓄账户。',
      example_pinyin = 'Rúguǒ xūyào jiāng měi ge yuè de gōngzī zìdòng zhuǎnrù cúnzhé, nǐ kěyǐ qù yínháng guìtái bànlǐ yì zhāng liánmíng chǔxù zhànghù.',
      example_vi = 'Nếu cần tự động chuyển tiền lương hàng tháng vào sổ tiết kiệm, bạn có thể đến quầy giao dịch ngân hàng làm một tài khoản tiết kiệm đồng sở hữu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '账户',
      'zhànghù',
      'tài khoản (ngân hàng, tài chính, thanh toán)',
      'Danh từ',
      'HSK 5',
      '如果需要将每个月的工资自动转入存折，你可以去银行柜台办理一张联名储蓄账户。',
      'Rúguǒ xūyào jiāng měi ge yuè de gōngzī zìdòng zhuǎnrù cúnzhé, nǐ kěyǐ qù yínháng guìtái bànlǐ yì zhāng liánmíng chǔxù zhànghù.',
      'Nếu cần tự động chuyển tiền lương hàng tháng vào sổ tiết kiệm, bạn có thể đến quầy giao dịch ngân hàng làm một tài khoản tiết kiệm đồng sở hữu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果需要将每个月的工资自动转入存折，你可以去银行柜台办理一张联名储蓄账户。', 'Rúguǒ xūyào jiāng měi ge yuè de gōngzī zìdòng zhuǎnrù cúnzhé, nǐ kěyǐ qù yínháng guìtái bànlǐ yì zhāng liánmíng chǔxù zhànghù.', 'Nếu cần tự động chuyển tiền lương hàng tháng vào sổ tiết kiệm, bạn có thể đến quầy giao dịch ngân hàng làm một tài khoản tiết kiệm đồng sở hữu.', 'basic', 1),
      (v_id, '反洗钱监管中心利用图神经网络算法对涉嫌离岸洗钱的大额异常资金账户往来流水进行全链路实时穿透式追踪。', 'Fǎn-xǐqián jiānguǎn zhōngxīn lìyòng tú-shénjīng-wǎngluò suànfǎ duì shèxián lí''àn xǐqián de dà''é yìcháng zījīn zhànghù wǎnglái liúshuǐ jìnxíng quán-liànlù shíshí chuāntòushì zhuīzōng.', 'Trung tâm giám sát chống rửa tiền vận dụng thuật toán mạng nơ-ron đồ thị để thực hiện truy vết xuyên thấu theo thời gian thực trên toàn chuỗi đối với các dòng chu chuyển tài khoản vốn bất thường số lượng lớn nghi ngờ rửa tiền ở nước ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3477] [着凉] (zháoliáng) - bị cảm lạnh, nhiễm lạnh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '着凉' AND pinyin = 'zháoliáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '着凉' AND pinyin = 'zháoliáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '着凉'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '着凉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zháoliáng',
      meaning_vi = 'bị cảm lạnh, nhiễm lạnh',
      example_hanzi = '昨晚睡觉时他忘记关上卧室的窗户，夜里吹了冷风，今早起来就有些着凉流鼻涕。',
      example_pinyin = 'Zuówǎn shuìjiào shí tā wàngjì guān shang wòshì de chuānghu, yè lǐ chuī le lěngfēng, jīnzǎo qǐlái jiù yǒuxiē zháoliáng liú bítì.',
      example_vi = 'Đêm qua lúc ngủ anh ấy quên đóng cửa sổ phòng ngủ, trong đêm bị gió lạnh thổi vào, sáng nay thức dậy đã bị cảm lạnh và chảy nước mũi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '着凉',
      'zháoliáng',
      'bị cảm lạnh, nhiễm lạnh',
      'Động từ',
      'HSK 5',
      '昨晚睡觉时他忘记关上卧室的窗户，夜里吹了冷风，今早起来就有些着凉流鼻涕。',
      'Zuówǎn shuìjiào shí tā wàngjì guān shang wòshì de chuānghu, yè lǐ chuī le lěngfēng, jīnzǎo qǐlái jiù yǒuxiē zháoliáng liú bítì.',
      'Đêm qua lúc ngủ anh ấy quên đóng cửa sổ phòng ngủ, trong đêm bị gió lạnh thổi vào, sáng nay thức dậy đã bị cảm lạnh và chảy nước mũi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '昨晚睡觉时他忘记关上卧室的窗户，夜里吹了冷风，今早起来就有些着凉流鼻涕。', 'Zuówǎn shuìjiào shí tā wàngjì guān shang wòshì de chuānghu, yè lǐ chuī le lěngfēng, jīnzǎo qǐlái jiù yǒuxiē zháoliáng liú bítì.', 'Đêm qua lúc ngủ anh ấy quên đóng cửa sổ phòng ngủ, trong đêm bị gió lạnh thổi vào, sáng nay thức dậy đã bị cảm lạnh và chảy nước mũi.', 'basic', 1),
      (v_id, '野外地质勘探队在高原严寒无遮蔽环境下作业时，必须严格执行防寒保暖规程以防队员因失温与着凉引发肺水肿等高原重症。', 'Yěwài dìzhì kāntànduì zài gāoyuán yánhán wú-zhēbì huánjìng xià zuòyè shí, bìxū yángé zhíxíng fánghán bǎonuǎn guīchéng yǐfáng duìyuán yīn shīwēn yǔ zháoliáng yǐnfā fèishuǐzhǒng děng gāoyuán zhòngzhèng.', 'Đội thăm dò địa chất dã ngoại khi tác nghiệp trong môi trường giá rét không nơi che chắn ở vùng cao nguyên bắt buộc phải chấp hành nghiêm ngặt quy trình giữ ấm chống rét để phòng ngừa thành viên do hạ thân nhiệt và nhiễm lạnh mà phát sinh các bệnh hiểm nghèo vùng cao như phù phổi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3478] [召开] (zhàokāi) - triệu tập, tổ chức (hội nghị, đại hội) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '召开' AND pinyin = 'zhàokāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '召开' AND pinyin = 'zhàokāi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '召开'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '召开'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhàokāi',
      meaning_vi = 'triệu tập, tổ chức (hội nghị, đại hội)',
      example_hanzi = '学校定于明天下午三点在学术报告厅召开新学期全体教职工大会，部署教学任务。',
      example_pinyin = 'Xuéxiào dìng yú míngtiān xiàwǔ sān diǎn zài xuéshù bàogàotīng zhàokāi xīn-xuéqī quántǐ jiàozhígōng dàhuì, bùshǔ jiàoxué rènwù.',
      example_vi = 'Nhà trường ấn định vào ba giờ chiều mai tại hội trường báo cáo học thuật sẽ triệu tập đại hội toàn thể cán bộ giảng viên nhân viên học kỳ mới để triển khai nhiệm vụ giảng dạy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '召开',
      'zhàokāi',
      'triệu tập, tổ chức (hội nghị, đại hội)',
      'Động từ',
      'HSK 5',
      '学校定于明天下午三点在学术报告厅召开新学期全体教职工大会，部署教学任务。',
      'Xuéxiào dìng yú míngtiān xiàwǔ sān diǎn zài xuéshù bàogàotīng zhàokāi xīn-xuéqī quántǐ jiàozhígōng dàhuì, bùshǔ jiàoxué rènwù.',
      'Nhà trường ấn định vào ba giờ chiều mai tại hội trường báo cáo học thuật sẽ triệu tập đại hội toàn thể cán bộ giảng viên nhân viên học kỳ mới để triển khai nhiệm vụ giảng dạy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校定于明天下午三点在学术报告厅召开新学期全体教职工大会，部署教学任务。', 'Xuéxiào dìng yú míngtiān xiàwǔ sān diǎn zài xuéshù bàogàotīng zhàokāi xīn-xuéqī quántǐ jiàozhígōng dàhuì, bùshǔ jiàoxué rènwù.', 'Nhà trường ấn định vào ba giờ chiều mai tại hội trường báo cáo học thuật sẽ triệu tập đại hội toàn thể cán bộ giảng viên nhân viên học kỳ mới để triển khai nhiệm vụ giảng dạy.', 'basic', 1),
      (v_id, '联合国安全理事会应轮值主席国请求紧急召开闭门磋商会议，全面评估地区冲突升级对全球和平稳定的重大威胁。', 'Liánhéguó Ānquán Lǐshìhuì yīng lúnzhí zhǔxíguó qǐngqiú jǐnjí zhàokāi bìmén cuōshāng huìyì, quánmiàn pínggū dìqū chōngtū shēngjí duì quánqiú hépíng wěndìng de zhòngdà wēixié.', 'Hội đồng Bảo an Liên Hợp Quốc đáp ứng yêu cầu của quốc gia chủ tịch luân phiên đã triệu tập khẩn cấp cuộc họp tham vấn kín, nhằm đánh giá toàn diện mối đe dọa trọng đại của sự leo thang xung đột khu vực đối với hòa bình và ổn định toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3479] [折扣] (zhékòu) - mức chiết khấu, giảm giá [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '折扣' AND pinyin = 'zhékòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '折扣' AND pinyin = 'zhékòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '折扣'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '折扣'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhékòu',
      meaning_vi = 'mức chiết khấu, giảm giá',
      example_hanzi = '这家品牌专卖店在周末开展促销活动，会员凭借积分卡可以享受全场服装八折的优惠折扣。',
      example_pinyin = 'Zhè jiā pǐnpái zhuānmàidiàn zài zhōumò kāizhǎn cùxiāo huódòng, huìyuán píngjiè jīfēnkǎ kěyǐ xiǎngshòu quánchǎng fúzhuāng bā zhé de yōuhuì zhékòu.',
      example_vi = 'Cửa hàng chuyên doanh thương hiệu này cuối tuần triển khai hoạt động khuyến mãi, hội viên dựa vào thẻ tích điểm có thể được hưởng mức chiết khấu ưu đãi giảm giá 20% cho toàn bộ trang phục.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '折扣',
      'zhékòu',
      'mức chiết khấu, giảm giá',
      'Danh từ',
      'HSK 5',
      '这家品牌专卖店在周末开展促销活动，会员凭借积分卡可以享受全场服装八折的优惠折扣。',
      'Zhè jiā pǐnpái zhuānmàidiàn zài zhōumò kāizhǎn cùxiāo huódòng, huìyuán píngjiè jīfēnkǎ kěyǐ xiǎngshòu quánchǎng fúzhuāng bā zhé de yōuhuì zhékòu.',
      'Cửa hàng chuyên doanh thương hiệu này cuối tuần triển khai hoạt động khuyến mãi, hội viên dựa vào thẻ tích điểm có thể được hưởng mức chiết khấu ưu đãi giảm giá 20% cho toàn bộ trang phục.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家品牌专卖店在周末开展促销活动，会员凭借积分卡可以享受全场服装八折的优惠折扣。', 'Zhè jiā pǐnpái zhuānmàidiàn zài zhōumò kāizhǎn cùxiāo huódòng, huìyuán píngjiè jīfēnkǎ kěyǐ xiǎngshòu quánchǎng fúzhuāng bā zhé de yōuhuì zhékòu.', 'Cửa hàng chuyên doanh thương hiệu này cuối tuần triển khai hoạt động khuyến mãi, hội viên dựa vào thẻ tích điểm có thể được hưởng mức chiết khấu ưu đãi giảm giá 20% cho toàn bộ trang phục.', 'basic', 1),
      (v_id, '企业大宗采购框架合同中明确设定了阶梯式商业折扣比率，以采购总量的规模经济效应换取供应链的最优单价。', 'Qǐyè dàzōng cǎigòu kuàngjià hétong zhōng míngquè shèdìng le jiētīshì shāngyè zhékòu bǐlǜ, yǐ cǎigòu zǒngliàng de guīmó jīngjì xiàoyìng huànqǔ gōngyìngliàn de zuìyōu dānjià.', 'Hợp đồng khung mua sắm số lượng lớn của doanh nghiệp đã thiết lập rõ ràng tỷ lệ chiết khấu thương mại dạng bậc thang, lấy hiệu ứng kinh tế theo quy mô của tổng lượng mua để đổi lấy mức đơn giá tối ưu của chuỗi cung ứng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3480] [哲学] (zhéxué) - triết học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '哲学' AND pinyin = 'zhéxué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哲学' AND pinyin = 'zhéxué'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '哲学'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哲学'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhéxué',
      meaning_vi = 'triết học',
      example_hanzi = '他在大学期间选修了西方哲学概论课程，学会了用批判性思维去审视日常生活中的各种问题。',
      example_pinyin = 'Tā zài dàxué qījiān xuǎnxiū le xīfāng zhéxué gàilùn kèchéng, xuéhuì le yòng pīpànxìng sīwéi qù shěnshì rìcháng shēnghuó zhōng de gèzhǒng wèntí.',
      example_vi = 'Trong thời gian học đại học anh ấy đã học tự chọn môn khái luận triết học phương Tây, học được cách dùng tư duy phản biện để xem xét các vấn đề trong cuộc sống thường nhật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '哲学',
      'zhéxué',
      'triết học',
      'Danh từ',
      'HSK 5',
      '他在大学期间选修了西方哲学概论课程，学会了用批判性思维去审视日常生活中的各种问题。',
      'Tā zài dàxué qījiān xuǎnxiū le xīfāng zhéxué gàilùn kèchéng, xuéhuì le yòng pīpànxìng sīwéi qù shěnshì rìcháng shēnghuó zhōng de gèzhǒng wèntí.',
      'Trong thời gian học đại học anh ấy đã học tự chọn môn khái luận triết học phương Tây, học được cách dùng tư duy phản biện để xem xét các vấn đề trong cuộc sống thường nhật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在大学期间选修了西方哲学概论课程，学会了用批判性思维去审视日常生活中的各种问题。', 'Tā zài dàxué qījiān xuǎnxiū le xīfāng zhéxué gàilùn kèchéng, xuéhuì le yòng pīpànxìng sīwéi qù shěnshì rìcháng shēnghuó zhōng de gèzhǒng wèntí.', 'Trong thời gian học đại học anh ấy đã học tự chọn môn khái luận triết học phương Tây, học được cách dùng tư duy phản biện để xem xét các vấn đề trong cuộc sống thường nhật.', 'basic', 1),
      (v_id, '现代科技伦理学从哲学本体论的高度反思人工智能的发展边界，旨在构建以人类尊严为核心的技术向善演进路径。', 'Xiàndài kējì lúnlǐxué cóng zhéxué běntǐlùn de gāodù fǎnsī réngōng zhìnéng de fāzhǎn biānjiè, zhǐzài gòujiàn yǐ rénlèi zūnyán wéi héxīn de jìshù xiàngshàn yǎnjìn lùjìng.', 'Đạo đức học khoa học công nghệ hiện đại từ tầm cao bản thể luận triết học đã suy ngẫm sâu sắc về ranh giới phát triển của trí tuệ nhân tạo, nhằm xây dựng lộ trình tiến hóa công nghệ hướng thiện lấy phẩm giá con người làm cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3481] [真诚] (zhēnchéng) - chân thành, thành thật [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '真诚' AND pinyin = 'zhēnchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '真诚' AND pinyin = 'zhēnchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '真诚'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '真诚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhēnchéng',
      meaning_vi = 'chân thành, thành thật',
      example_hanzi = '在与朋友交往的过程中，只有保持一颗真诚待人的心，才能收获长久而深厚的友谊。',
      example_pinyin = 'Zài yǔ péngyou jiāowǎng de guòchéng zhōng, zhǐyǒu bǎochí yì kē zhēnchéng dài rén de xīn, cáinéng shōuhuò chángjiǔ ér shēnhòu de yǒuyì.',
      example_vi = 'Trong quá trình giao lưu kết bạn với mọi người, chỉ khi giữ một tấm lòng đối đãi chân thành, ta mới có thể gặt hái được tình bạn lâu dài và sâu đậm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '真诚',
      'zhēnchéng',
      'chân thành, thành thật',
      'Tính từ',
      'HSK 5',
      '在与朋友交往的过程中，只有保持一颗真诚待人的心，才能收获长久而深厚的友谊。',
      'Zài yǔ péngyou jiāowǎng de guòchéng zhōng, zhǐyǒu bǎochí yì kē zhēnchéng dài rén de xīn, cáinéng shōuhuò chángjiǔ ér shēnhòu de yǒuyì.',
      'Trong quá trình giao lưu kết bạn với mọi người, chỉ khi giữ một tấm lòng đối đãi chân thành, ta mới có thể gặt hái được tình bạn lâu dài và sâu đậm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在与朋友交往的过程中，只有保持一颗真诚待人的心，才能收获长久而深厚的友谊。', 'Zài yǔ péngyou jiāowǎng de guòchéng zhōng, zhǐyǒu bǎochí yì kē zhēnchéng dài rén de xīn, cáinéng shōuhuò chángjiǔ ér shēnhòu de yǒuyì.', 'Trong quá trình giao lưu kết bạn với mọi người, chỉ khi giữ một tấm lòng đối đãi chân thành, ta mới có thể gặt hái được tình bạn lâu dài và sâu đậm.', 'basic', 1),
      (v_id, '企业在面临公共危机公关舆情冲击时，迅速主动公开事实真相并展现真诚担当，是重建公众信任与社会美誉度的关键支点。', 'Qǐyè zài miànlín gōnggòng wēijī gōngguān yúqíng chōngjī shí, xùnsù zhǔdòng gōngkāi shìshí zhēnxiàng bìng zhǎnxiàn zhēnchéng dāndāng, shì chóngjiàn gōngzhòng xìnrèn yǔ shèhuì měiyùdù de guānjiàn zhīdiǎn.', 'Doanh nghiệp khi đứng trước cú sốc dư luận quan hệ công chúng khủng hoảng cộng đồng, việc nhanh chóng chủ động công khai sự thật và thể hiện tinh thần gánh vác chân thành là điểm tựa then chốt để tái thiết lập lòng tin của công chúng cùng uy tín xã hội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3482] [针对] (zhēnduì) - nhằm vào, hướng tới, căn cứ vào [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '针对' AND pinyin = 'zhēnduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '针对' AND pinyin = 'zhēnduì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '针对'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '针对'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Giới từ',
      pinyin = 'zhēnduì',
      meaning_vi = 'nhằm vào, hướng tới, căn cứ vào',
      example_hanzi = '老师针对同学们在期中考试中普遍犯错的几何证明题，利用晚自习时间进行了详尽的针对性辅导。',
      example_pinyin = 'Lǎoshī zhēnduì tóngxuémen zài qīzhōng kǎoshì zhōng pǔbiàn fàncuò de jǐhé zhèngmíngtí, lìyòng wǎnzìxí shíjiān jìnxíng le xiángjìn de zhēnduìxìng fǔdǎo.',
      example_vi = 'Thầy giáo căn cứ vào những bài toán chứng minh hình học mà các em học sinh thường mắc lỗi trong kỳ thi giữa kỳ, đã tận dụng giờ tự học buổi tối để hướng dẫn bổ trợ chi tiết có mục tiêu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '针对',
      'zhēnduì',
      'nhằm vào, hướng tới, căn cứ vào',
      'Động từ / Giới từ',
      'HSK 5',
      '老师针对同学们在期中考试中普遍犯错的几何证明题，利用晚自习时间进行了详尽的针对性辅导。',
      'Lǎoshī zhēnduì tóngxuémen zài qīzhōng kǎoshì zhōng pǔbiàn fàncuò de jǐhé zhèngmíngtí, lìyòng wǎnzìxí shíjiān jìnxíng le xiángjìn de zhēnduìxìng fǔdǎo.',
      'Thầy giáo căn cứ vào những bài toán chứng minh hình học mà các em học sinh thường mắc lỗi trong kỳ thi giữa kỳ, đã tận dụng giờ tự học buổi tối để hướng dẫn bổ trợ chi tiết có mục tiêu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老师针对同学们在期中考试中普遍犯错的几何证明题，利用晚自习时间进行了详尽的针对性辅导。', 'Lǎoshī zhēnduì tóngxuémen zài qīzhōng kǎoshì zhōng pǔbiàn fàncuò de jǐhé zhèngmíngtí, lìyòng wǎnzìxí shíjiān jìnxíng le xiángjìn de zhēnduìxìng fǔdǎo.', 'Thầy giáo căn cứ vào những bài toán chứng minh hình học mà các em học sinh thường mắc lỗi trong kỳ thi giữa kỳ, đã tận dụng giờ tự học buổi tối để hướng dẫn bổ trợ chi tiết có mục tiêu.', 'basic', 1),
      (v_id, '商务部针对部分进口商品低价倾销扰乱国内市场秩序的不正当竞争行为，依法依规启动了反倾销立案调查程序。', 'Shāngwùbù zhēnduì bùfen jìnkǒu shāngpǐn dījià qīngxiāo rǎoluàn guónèi shìchǎng zhìxù de bú-zhèngdàng jìngzhēng xíngwéi, yīfǎ-yīguī qǐdòng le fǎn-qīngxiāo lì''àn diàochá chéngxù.', 'Bộ Thương mại nhằm vào hành vi cạnh tranh không lành mạnh bán phá giá giá thấp làm rối loạn trật tự thị trường nội địa của một bộ phận hàng hóa nhập khẩu, đã khởi động quy trình lập án điều tra chống bán phá giá theo đúng pháp luật và quy chuẩn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3483] [珍贵] (zhēnguì) - quý giá, trân quý [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '珍贵' AND pinyin = 'zhēnguì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '珍贵' AND pinyin = 'zhēnguì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '珍贵'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '珍贵'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhēnguì',
      meaning_vi = 'quý giá, trân quý',
      example_hanzi = '爷爷珍藏着一张几十年前的老战友合影照片，对他而言这是一份无比珍贵的青春记忆。',
      example_pinyin = 'Yéye zhēncáng zhe yì zhāng jǐshí nián qián de lǎo zhànyǒu héyǐng zhàopiàn, duì tā éryán zhè shì yí fèn wúbǐ zhēnguì de qīngchūn jìyì.',
      example_vi = 'Ông nội trân quý cất giữ một bức ảnh chụp chung với những đồng đội cũ từ mấy chục năm trước, đối với ông đó là một kỷ niệm thanh xuân quý giá khôn xiết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '珍贵',
      'zhēnguì',
      'quý giá, trân quý',
      'Tính từ',
      'HSK 5',
      '爷爷珍藏着一张几十年前的老战友合影照片，对他而言这是一份无比珍贵的青春记忆。',
      'Yéye zhēncáng zhe yì zhāng jǐshí nián qián de lǎo zhànyǒu héyǐng zhàopiàn, duì tā éryán zhè shì yí fèn wúbǐ zhēnguì de qīngchūn jìyì.',
      'Ông nội trân quý cất giữ một bức ảnh chụp chung với những đồng đội cũ từ mấy chục năm trước, đối với ông đó là một kỷ niệm thanh xuân quý giá khôn xiết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '爷爷珍藏着一张几十年前的老战友合影照片，对他而言这是一份无比珍贵的青春记忆。', 'Yéye zhēncáng zhe yì zhāng jǐshí nián qián de lǎo zhànyǒu héyǐng zhàopiàn, duì tā éryán zhè shì yí fèn wúbǐ zhēnguì de qīngchūn jìyì.', 'Ông nội trân quý cất giữ một bức ảnh chụp chung với những đồng đội cũ từ mấy chục năm trước, đối với ông đó là một kỷ niệm thanh xuân quý giá khôn xiết.', 'basic', 1),
      (v_id, '国家重大科学装置获取的高能粒子对撞实验珍贵原始物理数据，由全球数十家科研院所组成的国际合作组实行开源共享。', 'Guójiā zhòngdà kēxué zhuāngzhì huòqǔ de gāonéng lìzǐ duìzhuàng shíyàn zhēnguì yuánshǐ wùlǐ shùjù, yóu quánqiú shùshí jiā kēyán yuànsuǒ zǔchéng de guójì hézuòzǔ shíxíng kāiyuán gòngxiǎng.', 'Dữ liệu vật lý gốc quý giá từ thí nghiệm va chạm hạt năng lượng cao thu thập được bởi thiết bị khoa học trọng đại quốc gia được nhóm hợp tác quốc tế gồm hàng chục viện nghiên cứu toàn cầu thực hiện chia sẻ mã nguồn mở.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3484] [真实] (zhēnshí) - chân thực, chân thật, có thật [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '真实' AND pinyin = 'zhēnshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '真实' AND pinyin = 'zhēnshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '真实'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '真实'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhēnshí',
      meaning_vi = 'chân thực, chân thật, có thật',
      example_hanzi = '这部根据真实历史事件改编的励志电影情节感人至深，给现场所有观众带来了巨大的心灵震撼。',
      example_pinyin = 'Zhè bù gēnjù zhēnshí lìshǐ shìjiàn gǎibiān de lìzhì diànyǐng qíngjié gǎnrén zhì shēn, gěi xiànchǎng suǒyǒu guānzhòng dài lái le jùdà de xīnlíng zhènhàn.',
      example_vi = 'Bộ phim truyền cảm hứng được cải biên dựa trên sự kiện lịch sử có thật này tình tiết vô cùng cảm động, đem lại chấn động tâm can to lớn cho toàn bộ khán giả tại rạp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '真实',
      'zhēnshí',
      'chân thực, chân thật, có thật',
      'Tính từ',
      'HSK 5',
      '这部根据真实历史事件改编的励志电影情节感人至深，给现场所有观众带来了巨大的心灵震撼。',
      'Zhè bù gēnjù zhēnshí lìshǐ shìjiàn gǎibiān de lìzhì diànyǐng qíngjié gǎnrén zhì shēn, gěi xiànchǎng suǒyǒu guānzhòng dài lái le jùdà de xīnlíng zhènhàn.',
      'Bộ phim truyền cảm hứng được cải biên dựa trên sự kiện lịch sử có thật này tình tiết vô cùng cảm động, đem lại chấn động tâm can to lớn cho toàn bộ khán giả tại rạp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这部根据真实历史事件改编的励志电影情节感人至深，给现场所有观众带来了巨大的心灵震撼。', 'Zhè bù gēnjù zhēnshí lìshǐ shìjiàn gǎibiān de lìzhì diànyǐng qíngjié gǎnrén zhì shēn, gěi xiànchǎng suǒyǒu guānzhòng dài lái le jùdà de xīnlíng zhènhàn.', 'Bộ phim truyền cảm hứng được cải biên dựa trên sự kiện lịch sử có thật này tình tiết vô cùng cảm động, đem lại chấn động tâm can to lớn cho toàn bộ khán giả tại rạp.', 'basic', 1),
      (v_id, '上市公司必须确保对外披露的财务报表与经营业绩信息真实、准确、完整，严禁任何形式的会计造假与虚假陈述。', 'Shàngshì gōngsī bìxū quèbǎo duìwài pīlù de cáiwù bàobiǎo yǔ jīngyíng yèjì xìnxī zhēnshí, zhǔnquè, wánzhěng, yánjìn rènhé xíngshì de kuàijì zàojiǎ yǔ xūjiǎ chénshù.', 'Công ty niêm yết bắt buộc phải bảo đảm các báo cáo tài chính và thông tin kết quả kinh doanh công bố ra bên ngoài là chân thực, chuẩn xác và đầy đủ, nghiêm cấm mọi hình thức gian lận làm giả kế toán và trình bày khống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3485] [珍惜] (zhēnxī) - trân trọng, quý trọng, giữ gìn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '珍惜' AND pinyin = 'zhēnxī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '珍惜' AND pinyin = 'zhēnxī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '珍惜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '珍惜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhēnxī',
      meaning_vi = 'trân trọng, quý trọng, giữ gìn',
      example_hanzi = '青春年华转瞬即逝，我们应该珍惜在校园里潜心求学的宝贵时光，努力提升自己。',
      example_pinyin = 'Qīngchūn niánhuá zhuǎnshùn-jíshì, wǒmen yīnggāi zhēnxī zài xiàoyuán lǐ qiánxīn qiúxué de bǎoguì shíguāng, nǔlì tíshēng zìjǐ.',
      example_vi = 'Năm tháng tuổi trẻ thoáng qua như chớp mắt, chúng ta nên trân trọng quãng thời gian quý báu chuyên tâm học tập nơi giảng đường để nỗ lực hoàn thiện bản thân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '珍惜',
      'zhēnxī',
      'trân trọng, quý trọng, giữ gìn',
      'Động từ',
      'HSK 5',
      '青春年华转瞬即逝，我们应该珍惜在校园里潜心求学的宝贵时光，努力提升自己。',
      'Qīngchūn niánhuá zhuǎnshùn-jíshì, wǒmen yīnggāi zhēnxī zài xiàoyuán lǐ qiánxīn qiúxué de bǎoguì shíguāng, nǔlì tíshēng zìjǐ.',
      'Năm tháng tuổi trẻ thoáng qua như chớp mắt, chúng ta nên trân trọng quãng thời gian quý báu chuyên tâm học tập nơi giảng đường để nỗ lực hoàn thiện bản thân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青春年华转瞬即逝，我们应该珍惜在校园里潜心求学的宝贵时光，努力提升自己。', 'Qīngchūn niánhuá zhuǎnshùn-jíshì, wǒmen yīnggāi zhēnxī zài xiàoyuán lǐ qiánxīn qiúxué de bǎoguì shíguāng, nǔlì tíshēng zìjǐ.', 'Năm tháng tuổi trẻ thoáng qua như chớp mắt, chúng ta nên trân trọng quãng thời gian quý báu chuyên tâm học tập nơi giảng đường để nỗ lực hoàn thiện bản thân.', 'basic', 1),
      (v_id, '国际社会呼吁各国珍惜难能可贵的和平发展环境，通过平等对话化解安全分歧，共同维护多边贸易体制与全球供应链稳定。', 'Guójì shèhuì hūyù gèguó zhēnxī nánnéng-kěguì de hépíng fāzhǎn huánjìng, tōngguò píngděng duìhuà huàjiě ānquán fēnqí, gòngtóng wéihù duōbiān màoyì tǐzhì yǔ quánqiú gōngyìngliàn wěndìng.', 'Cộng đồng quốc tế kêu gọi các quốc gia trân trọng môi trường phát triển hòa bình quý báu hiếm có, thông qua đối thoại bình đẳng để hóa giải bất đồng an ninh, cùng nhau gìn giữ thể chế thương mại đa phương và sự ổn định của chuỗi cung ứng toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3486] [诊断] (zhěnduàn) - chẩn đoán (bệnh lý, lỗi kỹ thuật) [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '诊断' AND pinyin = 'zhěnduàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '诊断' AND pinyin = 'zhěnduàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '诊断'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '诊断'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhěnduàn',
      meaning_vi = 'chẩn đoán (bệnh lý, lỗi kỹ thuật)',
      example_hanzi = '经过血液生化常规化验与胸部CT扫描，主治医师最终给出了非常明确的病情诊断结果。',
      example_pinyin = 'Jīngguò xiěyè shēnghuà chángguī huàyàn yǔ xiōngbù CT sǎomiáo, zhǔzhì yīshī zuìzhōng gěichū le fēicháng míngquè de bìngqíng zhěnduàn jiéguǒ.',
      example_vi = 'Trải qua xét nghiệm sinh hóa máu thông thường và chụp cắt lớp CT lồng ngực, bác sĩ điều trị chính cuối cùng đã đưa ra kết quả chẩn đoán bệnh trạng rất rõ ràng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '诊断',
      'zhěnduàn',
      'chẩn đoán (bệnh lý, lỗi kỹ thuật)',
      'Động từ / Danh từ',
      'HSK 5',
      '经过血液生化常规化验与胸部CT扫描，主治医师最终给出了非常明确的病情诊断结果。',
      'Jīngguò xiěyè shēnghuà chángguī huàyàn yǔ xiōngbù CT sǎomiáo, zhǔzhì yīshī zuìzhōng gěichū le fēicháng míngquè de bìngqíng zhěnduàn jiéguǒ.',
      'Trải qua xét nghiệm sinh hóa máu thông thường và chụp cắt lớp CT lồng ngực, bác sĩ điều trị chính cuối cùng đã đưa ra kết quả chẩn đoán bệnh trạng rất rõ ràng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过血液生化常规化验与胸部CT扫描，主治医师最终给出了非常明确的病情诊断结果。', 'Jīngguò xiěyè shēnghuà chángguī huàyàn yǔ xiōngbù CT sǎomiáo, zhǔzhì yīshī zuìzhōng gěichū le fēicháng míngquè de bìngqíng zhěnduàn jiéguǒ.', 'Trải qua xét nghiệm sinh hóa máu thông thường và chụp cắt lớp CT lồng ngực, bác sĩ điều trị chính cuối cùng đã đưa ra kết quả chẩn đoán bệnh trạng rất rõ ràng.', 'basic', 1),
      (v_id, '工业物联网设备搭载多轴高频振动传感器与AI声纹算法，能够实现对核电机组高速主轴轴承微米级磨损的远程智能在线早期诊断。', 'Gōngyè wùliánwǎng shèbèi dāzài duō-zhóu gāopín zhèndòng chuángǎnqì yǔ AI shēngwén suànfǎ, nénggòu shíxiàn duì hédiàn jīzǔ gāosù zhǔzhóu zhóuchéng wēimǐjí mósǔn de yuǎnchéng zhìnéng zàixiàn zǎoqī zhěnduàn.', 'Thiết bị IoT công nghiệp tích hợp cảm biến rung động cao tần đa trục và thuật toán vân âm thanh AI, có thể hiện thực hóa việc chẩn đoán sớm trực tuyến thông minh từ xa đối với độ hao mòn cấp micromet của vòng bi trục chính tốc độ cao trên tổ máy điện hạt nhân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3487] [阵] (zhèn) - trận, cơn, hồi (sự việc diễn ra trong thời gian ngắn) [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '阵' AND pinyin = 'zhèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '阵' AND pinyin = 'zhèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '阵'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '阵'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'zhèn',
      meaning_vi = 'trận, cơn, hồi (sự việc diễn ra trong thời gian ngắn)',
      example_hanzi = '午后天空突然乌云密布，伴随着一阵电闪雷鸣，窗外下起了一场痛痛快快的雷阵雨。',
      example_pinyin = 'Wǔhòu tiānkōng tūrán wūyún-mìbù, bànsuí zhe yí zhèn diànshǎn-léimíng, chuāngwài xià qǐ le yì chǎng tòngtòng-kuàikuài de léizhènyǔ.',
      example_vi = 'Sau buổi trưa bầu trời bỗng chốc mây đen giăng kín, kèm theo một hồi sấm chớp chớp nhoáng, ngoài cửa sổ đổ xuống một trận mưa rào sấm sét sảng khoái.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '阵',
      'zhèn',
      'trận, cơn, hồi (sự việc diễn ra trong thời gian ngắn)',
      'Lượng từ / Danh từ',
      'HSK 5',
      '午后天空突然乌云密布，伴随着一阵电闪雷鸣，窗外下起了一场痛痛快快的雷阵雨。',
      'Wǔhòu tiānkōng tūrán wūyún-mìbù, bànsuí zhe yí zhèn diànshǎn-léimíng, chuāngwài xià qǐ le yì chǎng tòngtòng-kuàikuài de léizhènyǔ.',
      'Sau buổi trưa bầu trời bỗng chốc mây đen giăng kín, kèm theo một hồi sấm chớp chớp nhoáng, ngoài cửa sổ đổ xuống một trận mưa rào sấm sét sảng khoái.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '午后天空突然乌云密布，伴随着一阵电闪雷鸣，窗外下起了一场痛痛快快的雷阵雨。', 'Wǔhòu tiānkōng tūrán wūyún-mìbù, bànsuí zhe yí zhèn diànshǎn-léimíng, chuāngwài xià qǐ le yì chǎng tòngtòng-kuàikuài de léizhènyǔ.', 'Sau buổi trưa bầu trời bỗng chốc mây đen giăng kín, kèm theo một hồi sấm chớp chớp nhoáng, ngoài cửa sổ đổ xuống một trận mưa rào sấm sét sảng khoái.', 'basic', 1),
      (v_id, '国家级天文台射电望远镜阵列成功捕捉到了来自遥远深空脉冲星的一阵高能快速射电暴信号，为揭开恒星演化之谜提供了关键观测证据。', 'Guójiājí tiānwéntái shèdiàn wàngyuǎnjìng zhènliè chénggōng bǔzhuō dào le láizì yáoyuǎn shēnkōng màichōngxīng de yí zhèn gāonéng kuàisù shèdiànbào xìnhào, wèi jiēkāi héngxīng yǎnhuà zhī mǐ tígōng le guānjiàn guāncè zhèngjù.', 'Mảng kính viễn vọng vô tuyến của đài thiên văn cấp quốc gia đã thu nhận thành công một đợt bùng nổ vô tuyến nhanh năng lượng cao đến từ ngôi sao xung ở vũ trụ xa xôi, cung cấp bằng chứng quan sát then chốt cho việc giải mã bí ẩn tiến hóa sao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3488] [争] (zhēng) - tranh, tranh giành, phấn đấu, tranh cãi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '争' AND pinyin = 'zhēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '争' AND pinyin = 'zhēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '争'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '争'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhēng',
      meaning_vi = 'tranh, tranh giành, phấn đấu, tranh cãi',
      example_hanzi = '同学们在课堂讨论中各抒己见，争着回答老师提出的问题，课堂气氛十分活跃。',
      example_pinyin = 'Tóngxuémen zài kètáng tǎolùn zhōng gèshū-jǐjiàn, zhēng zhe huídá lǎoshī tíchū de wèntí, kètáng qìfēn shífēn huóyuè.',
      example_vi = 'Các bạn học sinh trong buổi thảo luận trên lớp thi nhau bày tỏ quan điểm riêng, tranh nhau trả lời câu hỏi thầy giáo đưa ra, bầu không khí lớp học vô cùng sôi nổi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '争',
      'zhēng',
      'tranh, tranh giành, phấn đấu, tranh cãi',
      'Động từ',
      'HSK 5',
      '同学们在课堂讨论中各抒己见，争着回答老师提出的问题，课堂气氛十分活跃。',
      'Tóngxuémen zài kètáng tǎolùn zhōng gèshū-jǐjiàn, zhēng zhe huídá lǎoshī tíchū de wèntí, kètáng qìfēn shífēn huóyuè.',
      'Các bạn học sinh trong buổi thảo luận trên lớp thi nhau bày tỏ quan điểm riêng, tranh nhau trả lời câu hỏi thầy giáo đưa ra, bầu không khí lớp học vô cùng sôi nổi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '同学们在课堂讨论中各抒己见，争着回答老师提出的问题，课堂气氛十分活跃。', 'Tóngxuémen zài kètáng tǎolùn zhōng gèshū-jǐjiàn, zhēng zhe huídá lǎoshī tíchū de wèntí, kètáng qìfēn shífēn huóyuè.', 'Các bạn học sinh trong buổi thảo luận trên lớp thi nhau bày tỏ quan điểm riêng, tranh nhau trả lời câu hỏi thầy giáo đưa ra, bầu không khí lớp học vô cùng sôi nổi.', 'basic', 1),
      (v_id, '在全球新一轮科技革命中，主要经济体都在分秒必争地加大在人工智能芯片与量子信息等未来前沿产业的核心技术投入。', 'Zài quánqiú xīn-yì-lún kējì gémìng zhōng, zhǔyào jīngjìtǐ dōu zài fēnjiǎo-bìzhēng de jiādà zài réngōng zhìnéng xīnpiàn yǔ liàngzǐ xìnxī děng wèilái qiányán chǎnyè de héxīn jìshù tóurù.', 'Trong làn sóng cách mạng khoa học công nghệ mới toàn cầu, các nền kinh tế chủ chốt đều đang tranh từng phút từng giây tăng cường đầu tư công nghệ cốt lõi vào các ngành công nghiệp mũi nhọn tương lai như chip AI và thông tin lượng tử.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3489] [争取] (zhēngqǔ) - tranh thủ, nỗ lực đạt được, phấn đấu giành lấy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '争取' AND pinyin = 'zhēngqǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '争取' AND pinyin = 'zhēngqǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '争取'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '争取'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhēngqǔ',
      meaning_vi = 'tranh thủ, nỗ lực đạt được, phấn đấu giành lấy',
      example_hanzi = '既然报名前提条件已经完全符合，你就应该努力争取这次公派出国交流访学的难得机会。',
      example_pinyin = 'Jìrán bàomíng qiántí tiáojiàn yǐjīng wánquán fúhé, nǐ jiù yīnggāi nǔlì zhēngqǔ zhè cì gōngpài chūguó jiāoliú fǎngxué de nándé jīhuì.',
      example_vi = 'Một khi điều kiện tiên quyết đăng ký đã hoàn toàn đáp ứng, bạn nên nỗ lực tranh thủ cơ hội hiếm có này để được cử đi giao lưu học thuật ở nước ngoài bằng ngân sách nhà nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '争取',
      'zhēngqǔ',
      'tranh thủ, nỗ lực đạt được, phấn đấu giành lấy',
      'Động từ',
      'HSK 5',
      '既然报名前提条件已经完全符合，你就应该努力争取这次公派出国交流访学的难得机会。',
      'Jìrán bàomíng qiántí tiáojiàn yǐjīng wánquán fúhé, nǐ jiù yīnggāi nǔlì zhēngqǔ zhè cì gōngpài chūguó jiāoliú fǎngxué de nándé jīhuì.',
      'Một khi điều kiện tiên quyết đăng ký đã hoàn toàn đáp ứng, bạn nên nỗ lực tranh thủ cơ hội hiếm có này để được cử đi giao lưu học thuật ở nước ngoài bằng ngân sách nhà nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '既然报名前提条件已经完全符合，你就应该努力争取这次公派出国交流访学的难得机会。', 'Jìrán bàomíng qiántí tiáojiàn yǐjīng wánquán fúhé, nǐ jiù yīnggāi nǔlì zhēngqǔ zhè cì gōngpài chūguó jiāoliú fǎngxué de nándé jīhuì.', 'Một khi điều kiện tiên quyết đăng ký đã hoàn toàn đáp ứng, bạn nên nỗ lực tranh thủ cơ hội hiếm có này để được cử đi giao lưu học thuật ở nước ngoài bằng ngân sách nhà nước.', 'basic', 1),
      (v_id, '项目团队正分秒必争地推进核心代码自动化测试与系统集成，争取在下周一前全面上线跨境支付新版本系统。', 'Xiàngmù tuánduì zhèng fēnjiǎo-bìzhēng de tuījìn héxīn dàimǎ zìdònghuà cèshì yǔ xìtǒng jíchéng, zhēngqǔ zài xià zhōuyī qián quánmiàn shàngxiàn kuàjìng zhīfù xīn-bǎnběn xìtǒng.', 'Đội ngũ dự án đang tranh thủ từng giây từng phút đẩy mạnh việc kiểm thử tự động mã nguồn cốt lõi và tích hợp hệ thống, nỗ lực đưa hệ thống phiên bản mới về thanh toán xuyên biên giới lên mạng hoàn chỉnh trước thứ Hai tuần sau.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3490] [整齐] (zhěngqí) - ngay ngắn, gọn gàng, ngăn nắp, đồng đều [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '整齐' AND pinyin = 'zhěngqí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '整齐' AND pinyin = 'zhěngqí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '整齐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '整齐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhěngqí',
      meaning_vi = 'ngay ngắn, gọn gàng, ngăn nắp, đồng đều',
      example_hanzi = '图书管理员把阅览室书架上的所有参考书籍都摆放得整整齐齐，极大方便了师生们借阅查找。',
      example_pinyin = 'Túshū guǎnlǐyuán bǎ yuèlǎnshì shūjià shang de suǒyǒu cānkǎo shūjí dōu bǎifàng de zhěngzhěng-qíqí, jídà fāngbiàn le shīshēngmen jièyuè cházhǎo.',
      example_vi = 'Người quản thư sắp xếp toàn bộ sách tham khảo trên giá sách trong phòng đọc một cách ngay ngắn gọn gàng, tạo thuận lợi rất lớn cho thầy trò mượn đọc tra cứu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '整齐',
      'zhěngqí',
      'ngay ngắn, gọn gàng, ngăn nắp, đồng đều',
      'Tính từ',
      'HSK 5',
      '图书管理员把阅览室书架上的所有参考书籍都摆放得整整齐齐，极大方便了师生们借阅查找。',
      'Túshū guǎnlǐyuán bǎ yuèlǎnshì shūjià shang de suǒyǒu cānkǎo shūjí dōu bǎifàng de zhěngzhěng-qíqí, jídà fāngbiàn le shīshēngmen jièyuè cházhǎo.',
      'Người quản thư sắp xếp toàn bộ sách tham khảo trên giá sách trong phòng đọc một cách ngay ngắn gọn gàng, tạo thuận lợi rất lớn cho thầy trò mượn đọc tra cứu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '图书管理员把阅览室书架上的所有参考书籍都摆放得整整齐齐，极大方便了师生们借阅查找。', 'Túshū guǎnlǐyuán bǎ yuèlǎnshì shūjià shang de suǒyǒu cānkǎo shūjí dōu bǎifàng de zhěngzhěng-qíqí, jídà fāngbiàn le shīshēngmen jièyuè cházhǎo.', 'Người quản thư sắp xếp toàn bộ sách tham khảo trên giá sách trong phòng đọc một cách ngay ngắn gọn gàng, tạo thuận lợi rất lớn cho thầy trò mượn đọc tra cứu.', 'basic', 1),
      (v_id, '超洁净现代化半导体晶圆制造车间内，数百台自动化天车机械臂正在整齐划一的轨道上高效运送高精度光刻晶圆载具。', 'Chāo-jiéjìng xiàndàihuà bàndǎotǐ jīngyuán zhìzào chējiān nèi, shùbǎi tái zìdònghuà tiānchē jīxièbì zhèngzài zhěngqí-huàyī de guǐdào shang gāoxiào yùnsòng gāojīngdù guāngkè jīngyuán zàijù.', 'Bên trong phân xưởng chế tạo tấm wafer bán dẫn hiện đại siêu sạch, hàng trăm cánh tay robot xe trục tự động đang vận chuyển hộp chứa wafer quang khắc độ chính xác cao một cách hiệu quả trên các đường ray ngay ngắn tăm tắp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3491] [整体] (zhěngtǐ) - chỉnh thể, toàn bộ, tổng thể [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '整体' AND pinyin = 'zhěngtǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '整体' AND pinyin = 'zhěngtǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '整体'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '整体'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhěngtǐ',
      meaning_vi = 'chỉnh thể, toàn bộ, tổng thể',
      example_hanzi = '室内设计师在装修房屋时不仅注重局部细节的美观，更强调家具颜色与房屋整体风格的和谐统一。',
      example_pinyin = 'Shìnèi shèjìshī zài zhuāngxiū fángwū shí bù jǐn zhùzhòng júbù xìjié de měiguān, gèng qiángdiào jiājù yánsè yǔ fángwū zhěngtǐ fēnggé de héxié tǒngyī.',
      example_vi = 'Nhà thiết kế nội thất khi trang trí nhà cửa không chỉ chú trọng đến vẻ đẹp thẩm mỹ của từng chi tiết cục bộ, mà còn đặc biệt nhấn mạnh sự hài hòa thống nhất giữa màu sắc đồ nội thất với phong cách tổng thể của ngôi nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '整体',
      'zhěngtǐ',
      'chỉnh thể, toàn bộ, tổng thể',
      'Danh từ',
      'HSK 5',
      '室内设计师在装修房屋时不仅注重局部细节的美观，更强调家具颜色与房屋整体风格的和谐统一。',
      'Shìnèi shèjìshī zài zhuāngxiū fángwū shí bù jǐn zhùzhòng júbù xìjié de měiguān, gèng qiángdiào jiājù yánsè yǔ fángwū zhěngtǐ fēnggé de héxié tǒngyī.',
      'Nhà thiết kế nội thất khi trang trí nhà cửa không chỉ chú trọng đến vẻ đẹp thẩm mỹ của từng chi tiết cục bộ, mà còn đặc biệt nhấn mạnh sự hài hòa thống nhất giữa màu sắc đồ nội thất với phong cách tổng thể của ngôi nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '室内设计师在装修房屋时不仅注重局部细节的美观，更强调家具颜色与房屋整体风格的和谐统一。', 'Shìnèi shèjìshī zài zhuāngxiū fángwū shí bù jǐn zhùzhòng júbù xìjié de měiguān, gèng qiángdiào jiājù yánsè yǔ fángwū zhěngtǐ fēnggé de héxié tǒngyī.', 'Nhà thiết kế nội thất khi trang trí nhà cửa không chỉ chú trọng đến vẻ đẹp thẩm mỹ của từng chi tiết cục bộ, mà còn đặc biệt nhấn mạnh sự hài hòa thống nhất giữa màu sắc đồ nội thất với phong cách tổng thể của ngôi nhà.', 'basic', 1),
      (v_id, '推进国家现代化治理体系建设必须树立全国一盘棋思维，强化跨部门跨层级跨区域的整体协同与宏观政策取向一致性。', 'Tuījìn guójiā xiàndàihuà zhìlǐ tǐxì jiànshè bìxū shùlì quánguó-yìpánqí sīwéi, qiánghuà kuà-bùmén kuà-céngjí kuà-qūyù de zhěngtǐ xiétóng yǔ hóngguān zhèngcè qǔxiàng yízhìxìng.', 'Đẩy mạnh xây dựng hệ thống quản trị hiện đại hóa quốc gia bắt buộc phải xác lập tư duy toàn quốc một bàn cờ, tăng cường sự phối hợp tổng thể xuyên ban ngành, xuyên cấp bậc, xuyên vùng miền và tính nhất quán trong định hướng chính sách vĩ mô.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3492] [整整] (zhěngzhěng) - tròn trĩnh, ròng rã, đúng trọn [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '整整' AND pinyin = 'zhěngzhěng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '整整' AND pinyin = 'zhěngzhěng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '整整'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '整整'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'zhěngzhěng',
      meaning_vi = 'tròn trĩnh, ròng rã, đúng trọn',
      example_hanzi = '为了撰写完成这篇高质量的高中毕业论文，他在市图书馆查阅资料整整坐了一个下午。',
      example_pinyin = 'Wèile zhuànxiě wánchéng zhè piān gāozhìliàng de gāozhōng bìyè lùnwén, tā zài shì túshūguǎn chàyuè zīliào zhěngzhěng zuò le yí ge xiàwǔ.',
      example_vi = 'Để hoàn thành bài luận văn tốt nghiệp trung học phổ thông chất lượng cao này, anh ấy đã ngồi tra cứu tài liệu trong thư viện thành phố ròng rã suốt một buổi chiều.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '整整',
      'zhěngzhěng',
      'tròn trĩnh, ròng rã, đúng trọn',
      'Phó từ',
      'HSK 5',
      '为了撰写完成这篇高质量的高中毕业论文，他在市图书馆查阅资料整整坐了一个下午。',
      'Wèile zhuànxiě wánchéng zhè piān gāozhìliàng de gāozhōng bìyè lùnwén, tā zài shì túshūguǎn chàyuè zīliào zhěngzhěng zuò le yí ge xiàwǔ.',
      'Để hoàn thành bài luận văn tốt nghiệp trung học phổ thông chất lượng cao này, anh ấy đã ngồi tra cứu tài liệu trong thư viện thành phố ròng rã suốt một buổi chiều.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了撰写完成这篇高质量的高中毕业论文，他在市图书馆查阅资料整整坐了一个下午。', 'Wèile zhuànxiě wánchéng zhè piān gāozhìliàng de gāozhōng bìyè lùnwén, tā zài shì túshūguǎn chàyuè zīliào zhěngzhěng zuò le yí ge xiàwǔ.', 'Để hoàn thành bài luận văn tốt nghiệp trung học phổ thông chất lượng cao này, anh ấy đã ngồi tra cứu tài liệu trong thư viện thành phố ròng rã suốt một buổi chiều.', 'basic', 1),
      (v_id, '科研攻坚团队在荒无人烟的沙漠试验基地历经整整五年封闭攻关，终于成功研制出具有世界领先水平的新型耐高温航空复合材料。', 'Kēyán gōngjiān tuánduì zài huāngwúrényān de shāmò shìyàn jīdì lìjīng zhěngzhěng wǔ nián fēngbì gōngguān, zhōngyú chénggōng yánzhì chū jùyǒu shìjiè lǐngxiān shuǐpíng de xīnxíng nài-gāowēn hángkōng fùhé cáiliào.', 'Đội ngũ nghiên cứu khoa học đột phá tại căn cứ thử nghiệm giữa sa mạc không một bóng người đã trải qua ròng rã tròn năm năm nghiên cứu biệt lập khép kín, rốt cuộc đã chế tạo thành công loại vật liệu composite hàng không chịu nhiệt độ cao kiểu mới có trình độ dẫn đầu thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3493] [挣] (zhèng) - kiếm (tiền), kiếm sống [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '挣' AND pinyin = 'zhèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挣' AND pinyin = 'zhèng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '挣'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挣'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhèng',
      meaning_vi = 'kiếm (tiền), kiếm sống',
      example_hanzi = '许多大学生利用寒暑假在咖啡店或辅导机构做兼职，以此挣一些零花钱来补贴学费。',
      example_pinyin = 'Xǔduō dàxuéshēng lìyòng hán-shǔjià zài kāfēidiàn huò fǔdǎo jīgòu zuò jiānzhí, yǐcǐ zhèng yìxiē línghuāqián lái bǔtiē xuéfèi.',
      example_vi = 'Nhiều sinh viên đại học tận dụng kỳ nghỉ đông và hè để làm thêm tại các quán cà phê hoặc trung tâm gia sư, qua đó kiếm thêm một chút tiền tiêu vặt bù đắp học phí.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '挣',
      'zhèng',
      'kiếm (tiền), kiếm sống',
      'Động từ',
      'HSK 5',
      '许多大学生利用寒暑假在咖啡店或辅导机构做兼职，以此挣一些零花钱来补贴学费。',
      'Xǔduō dàxuéshēng lìyòng hán-shǔjià zài kāfēidiàn huò fǔdǎo jīgòu zuò jiānzhí, yǐcǐ zhèng yìxiē línghuāqián lái bǔtiē xuéfèi.',
      'Nhiều sinh viên đại học tận dụng kỳ nghỉ đông và hè để làm thêm tại các quán cà phê hoặc trung tâm gia sư, qua đó kiếm thêm một chút tiền tiêu vặt bù đắp học phí.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '许多大学生利用寒暑假在咖啡店或辅导机构做兼职，以此挣一些零花钱来补贴学费。', 'Xǔduō dàxuéshēng lìyòng hán-shǔjià zài kāfēidiàn huò fǔdǎo jīgòu zuò jiānzhí, yǐcǐ zhèng yìxiē línghuāqián lái bǔtiē xuéfèi.', 'Nhiều sinh viên đại học tận dụng kỳ nghỉ đông và hè để làm thêm tại các quán cà phê hoặc trung tâm gia sư, qua đó kiếm thêm một chút tiền tiêu vặt bù đắp học phí.', 'basic', 1),
      (v_id, '现代科技型企业必须彻底摆脱依靠消耗廉价劳动力和低端代工挣微薄辛苦钱的粗放模式，坚定转向以自主核心专利获取高技术溢价。', 'Xiàndài kējìxíng qǐyè bìxū chèdǐ bǎituō yīlài xiāohào liánjià láodònglì hé dīduān dàigōng zhèng wēibó xīnkǔqián de cūfàng móshì, jiāndìng zhuǎnhuàng yǐ zìzhǔ héxīn zhuānlì huòqǔ gāojìshù yìjià.', 'Doanh nghiệp thuộc loại hình khoa học công nghệ hiện đại bắt buộc phải thoát khỏi hoàn toàn mô hình thô sơ dựa vào tiêu hao lao động giá rẻ và gia công cấp thấp kiếm đồng tiền còm cõi nhọc nhằn, kiên định chuyển sang việc dùng sáng chế độc quyền cốt lõi tự chủ để thu về giá trị gia tăng công nghệ cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3494] [政府] (zhèngfǔ) - chính phủ, chính quyền [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '政府' AND pinyin = 'zhèngfǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '政府' AND pinyin = 'zhèngfǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '政府'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '政府'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhèngfǔ',
      meaning_vi = 'chính phủ, chính quyền',
      example_hanzi = '当地政府近年来大力投资兴建乡村硬化公路和自来水管网，显著改善了偏远村民的生活条件。',
      example_pinyin = 'Dāngdì zhèngfǔ jìnnián lái dàlì tóuzī xīngjiàn xiāngcūn yìnghuà gōnglù hé zìláishuǐ guǎnwǎng, xiǎnzhù gǎishàn le piānyuǎn cūnmín de shēnghuó tiáojiàn.',
      example_vi = 'Chính quyền địa phương những năm gần đây đã đầu tư mạnh mẽ xây dựng đường nhựa bê tông nông thôn và mạng lưới đường ống nước máy, cải thiện rõ rệt điều kiện sống của dân làng vùng sâu vùng xa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '政府',
      'zhèngfǔ',
      'chính phủ, chính quyền',
      'Danh từ',
      'HSK 5',
      '当地政府近年来大力投资兴建乡村硬化公路和自来水管网，显著改善了偏远村民的生活条件。',
      'Dāngdì zhèngfǔ jìnnián lái dàlì tóuzī xīngjiàn xiāngcūn yìnghuà gōnglù hé zìláishuǐ guǎnwǎng, xiǎnzhù gǎishàn le piānyuǎn cūnmín de shēnghuó tiáojiàn.',
      'Chính quyền địa phương những năm gần đây đã đầu tư mạnh mẽ xây dựng đường nhựa bê tông nông thôn và mạng lưới đường ống nước máy, cải thiện rõ rệt điều kiện sống của dân làng vùng sâu vùng xa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '当地政府近年来大力投资兴建乡村硬化公路和自来水管网，显著改善了偏远村民的生活条件。', 'Dāngdì zhèngfǔ jìnnián lái dàlì tóuzī xīngjiàn xiāngcūn yìnghuà gōnglù hé zìláishuǐ guǎnwǎng, xiǎnzhù gǎishàn le piānyuǎn cūnmín de shēnghuó tiáojiàn.', 'Chính quyền địa phương những năm gần đây đã đầu tư mạnh mẽ xây dựng đường nhựa bê tông nông thôn và mạng lưới đường ống nước máy, cải thiện rõ rệt điều kiện sống của dân làng vùng sâu vùng xa.', 'basic', 1),
      (v_id, '多国政府在联合国框架下联合签署了具有法律约束力的全球海洋塑料污染防治公约，承诺建立全生命周期的塑料废物循环回收法定监管机制。', 'Duōguó zhèngfǔ zài Liánhéguó kuàngjià xià liánhé qiānshǔ le jùyǒu fǎlǜ yuēshùlì de quánqiú hǎiyáng sùliào wūrǎn fángzhì gōngyuē, chéngnuò jiànlì quán-shēngmìng-zhōuqī de sùliào fèiwù xúnhuán huíshōu fǎdìng jiānguǎn jīzhì.', 'Chính phủ nhiều quốc gia dưới khuôn khổ Liên Hợp Quốc đã cùng ký kết công ước toàn cầu về phòng chống ô nhiễm rác thải nhựa đại dương có tính ràng buộc pháp lý, cam kết thiết lập cơ chế giám sát pháp định về thu gom tái chế rác thải nhựa trong toàn bộ vòng đời.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3495] [证据] (zhèngjù) - chứng cứ, bằng chứng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '证据' AND pinyin = 'zhèngjù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '证据' AND pinyin = 'zhèngjù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '证据'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '证据'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhèngjù',
      meaning_vi = 'chứng cứ, bằng chứng',
      example_hanzi = '交通警察调取了路口的高清监控录像，作为判定这起交通事故全责方的关键直接证据。',
      example_pinyin = 'Jiāotōng jǐngchá diàoqǔ le lùkǒu de gāoqīng jiānkòng lùxiàng, zuòwéi pàndìng zhè qǐ jiāotōng shìgù quánzéfāng de guānjiàn zhíjiē zhèngjù.',
      example_vi = 'Cảnh sát giao thông đã trích xuất đoạn video giám sát độ nét cao ở ngã tư, dùng làm bằng chứng trực tiếp then chốt để phán định bên chịu toàn bộ trách nhiệm trong vụ tai nạn giao thông này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '证据',
      'zhèngjù',
      'chứng cứ, bằng chứng',
      'Danh từ',
      'HSK 5',
      '交通警察调取了路口的高清监控录像，作为判定这起交通事故全责方的关键直接证据。',
      'Jiāotōng jǐngchá diàoqǔ le lùkǒu de gāoqīng jiānkòng lùxiàng, zuòwéi pàndìng zhè qǐ jiāotōng shìgù quánzéfāng de guānjiàn zhíjiē zhèngjù.',
      'Cảnh sát giao thông đã trích xuất đoạn video giám sát độ nét cao ở ngã tư, dùng làm bằng chứng trực tiếp then chốt để phán định bên chịu toàn bộ trách nhiệm trong vụ tai nạn giao thông này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '交通警察调取了路口的高清监控录像，作为判定这起交通事故全责方的关键直接证据。', 'Jiāotōng jǐngchá diàoqǔ le lùkǒu de gāoqīng jiānkòng lùxiàng, zuòwéi pàndìng zhè qǐ jiāotōng shìgù quánzéfāng de guānjiàn zhíjiē zhèngjù.', 'Cảnh sát giao thông đã trích xuất đoạn video giám sát độ nét cao ở ngã tư, dùng làm bằng chứng trực tiếp then chốt để phán định bên chịu toàn bộ trách nhiệm trong vụ tai nạn giao thông này.', 'basic', 1),
      (v_id, '国际司法仲裁严格坚持法定证据裁判原则，排除一切通过非法手段获取或缺乏合法区块链时间戳校验的电子取证证据。', 'Guójì sīfǎ zhòngcái yángé jiānchí fǎdìng zhèngjù cáipàn yuánzé, páichú yíqiè tōngguò fēifǎ shǒuduàn huòqǔ huò quēfá héfǎ qūkuàiliàn shíjiānchuō jiàoyàn de diànzǐ qǔzhèng zhèngjù.', 'Trọng tài tư pháp quốc tế kiên trì thực hiện nghiêm ngặt nguyên tắc phán quyết dựa trên bằng chứng theo luật định, loại trừ mọi chứng cứ thu thập điện tử thu được thông qua thủ đoạn phi pháp hoặc thiếu sự đối chiếu tem thời gian chuỗi khối hợp pháp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3496] [正如] (zhèngrú) - đúng như, hệt như, giống như [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '正如' AND pinyin = 'zhèngrú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '正如' AND pinyin = 'zhèngrú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '正如'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '正如'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhèngrú',
      meaning_vi = 'đúng như, hệt như, giống như',
      example_hanzi = '天气预报正如播报员所预测的那样，午后果然下起了入冬以来的第一场洁白大雪。',
      example_pinyin = 'Tiānqì yùbào zhèngrú bōbàoyuán suǒ yùcè de nàyàng, wǔhòu guǒrán xià qǐ le rùdōng yǐlái de dì-yī chǎng jiébái dàxuě.',
      example_vi = 'Dự báo thời tiết đúng như những gì phát thanh viên đã dự đoán, sau buổi trưa quả nhiên đã đổ xuống trận tuyết trắng xóa lớn đầu tiên kể từ khi vào đông.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '正如',
      'zhèngrú',
      'đúng như, hệt như, giống như',
      'Động từ',
      'HSK 5',
      '天气预报正如播报员所预测的那样，午后果然下起了入冬以来的第一场洁白大雪。',
      'Tiānqì yùbào zhèngrú bōbàoyuán suǒ yùcè de nàyàng, wǔhòu guǒrán xià qǐ le rùdōng yǐlái de dì-yī chǎng jiébái dàxuě.',
      'Dự báo thời tiết đúng như những gì phát thanh viên đã dự đoán, sau buổi trưa quả nhiên đã đổ xuống trận tuyết trắng xóa lớn đầu tiên kể từ khi vào đông.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天气预报正如播报员所预测的那样，午后果然下起了入冬以来的第一场洁白大雪。', 'Tiānqì yùbào zhèngrú bōbàoyuán suǒ yùcè de nàyàng, wǔhòu guǒrán xià qǐ le rùdōng yǐlái de dì-yī chǎng jiébái dàxuě.', 'Dự báo thời tiết đúng như những gì phát thanh viên đã dự đoán, sau buổi trưa quả nhiên đã đổ xuống trận tuyết trắng xóa lớn đầu tiên kể từ khi vào đông.', 'basic', 1),
      (v_id, '正如著名经济学家在年度宏观展望报告中所断言的那样，数字经济与实体经济的深度融合正成为驱动产业跨越式发展的最核心引擎。', 'Zhèngrú zhùmíng jīngjìxuéjiā zài niándù hóngguān zhǎnwàng bàogào zhōng suǒ duànyán de nàyàng, shùzì jīngjì yǔ shítǐ jīngjì de shēndù rónghé zhèng chéngwéi qūdòng chǎnyè kuàyuèshì fāzhǎn de zuì héxīn yǐnqíng.', 'Đúng như những gì nhà kinh tế học nổi tiếng đã khẳng định trong báo cáo triển vọng vĩ mô thường niên, sự dung hợp sâu sắc giữa kinh tế số và kinh tế thực thể đang trở thành động cơ cốt lõi nhất thúc đẩy sự phát triển nhảy vọt của ngành công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3497] [证书] (zhèngshū) - chứng thư, văn bằng, giấy chứng nhận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '证书' AND pinyin = 'zhèngshū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '证书' AND pinyin = 'zhèngshū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '证书'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '证书'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhèngshū',
      meaning_vi = 'chứng thư, văn bằng, giấy chứng nhận',
      example_hanzi = '经过半年的刻苦自学与模拟练习，他顺利通过了全国翻译专业资格考试并拿到了职业资格证书。',
      example_pinyin = 'Jīngguò bàn nián de kèkǔ zìxué yǔ mónǐ liànxí, tā shùnlì tōngguò le quánguó fānyì zhuānyè zīgé kǎoshì bìng ná dào le zhíyè zīgé zhèngshū.',
      example_vi = 'Trải qua nửa năm tự học khổ công và luyện thi thử, anh ấy đã vượt qua kỳ thi sát hạch tư cách chuyên ngành dịch thuật toàn quốc một cách thuận lợi và nhận được chứng chỉ hành nghề.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '证书',
      'zhèngshū',
      'chứng thư, văn bằng, giấy chứng nhận',
      'Danh từ',
      'HSK 5',
      '经过半年的刻苦自学与模拟练习，他顺利通过了全国翻译专业资格考试并拿到了职业资格证书。',
      'Jīngguò bàn nián de kèkǔ zìxué yǔ mónǐ liànxí, tā shùnlì tōngguò le quánguó fānyì zhuānyè zīgé kǎoshì bìng ná dào le zhíyè zīgé zhèngshū.',
      'Trải qua nửa năm tự học khổ công và luyện thi thử, anh ấy đã vượt qua kỳ thi sát hạch tư cách chuyên ngành dịch thuật toàn quốc một cách thuận lợi và nhận được chứng chỉ hành nghề.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过半年的刻苦自学与模拟练习，他顺利通过了全国翻译专业资格考试并拿到了职业资格证书。', 'Jīngguò bàn nián de kèkǔ zìxué yǔ mónǐ liànxí, tā shùnlì tōngguò le quánguó fānyì zhuānyè zīgé kǎoshì bìng ná dào le zhíyè zīgé zhèngshū.', 'Trải qua nửa năm tự học khổ công và luyện thi thử, anh ấy đã vượt qua kỳ thi sát hạch tư cách chuyên ngành dịch thuật toàn quốc một cách thuận lợi và nhận được chứng chỉ hành nghề.', 'basic', 1),
      (v_id, '国际公钥基础设施体系通过多级数字根证书信任链加密与在线证书状态协议，确保跨国金融机构间敏感交易指令的防篡改与不可抵赖。', 'Guójì gōngyào jīchǔ shèshī tǐxì tōngguò duōjí shùzì gēn-zhèngshū xìnrènliàn jiāmì yǔ zàixiàn zhèngshū zhuàngtài xiédìng, quèbǎo kuàguó jīnróng jīgòu jiān mǐngǎn jiāoyì zhǐlìng de fáng-cuàngǎi yǔ bùkě-dǐlài.', 'Hệ thống hạ tầng khóa công khai quốc tế thông qua mã hóa chuỗi ủy thác chứng thư gốc số đa cấp và giao thức trạng thái chứng thư trực tuyến, bảo đảm lệnh giao dịch nhạy cảm giữa các tổ chức tài chính xuyên quốc gia có khả năng chống giả mạo và không thể chối bỏ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3498] [政治] (zhèngzhì) - chính trị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '政治' AND pinyin = 'zhèngzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '政治' AND pinyin = 'zhèngzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '政治'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '政治'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhèngzhì',
      meaning_vi = 'chính trị',
      example_hanzi = '作为当代大学生，不仅要在专业课堂上学好专业知识，也要关心国家政治与社会民生大事。',
      example_pinyin = 'Zuòwéi dāngdài dàxuéshēng, bù jǐn yào zài zhuānyè kètáng shang xué hǎo zhuānyè zhīshi, yě yào guānxīn guójiā zhèngzhì yǔ shèhuì mínshēng dàshì.',
      example_vi = 'Là sinh viên đại học đương đại, không chỉ cần học tốt kiến thức chuyên môn trên giảng đường chuyên ngành, mà còn phải quan tâm đến những vấn đề lớn về chính trị quốc gia và dân sinh xã hội.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '政治',
      'zhèngzhì',
      'chính trị',
      'Danh từ',
      'HSK 5',
      '作为当代大学生，不仅要在专业课堂上学好专业知识，也要关心国家政治与社会民生大事。',
      'Zuòwéi dāngdài dàxuéshēng, bù jǐn yào zài zhuānyè kètáng shang xué hǎo zhuānyè zhīshi, yě yào guānxīn guójiā zhèngzhì yǔ shèhuì mínshēng dàshì.',
      'Là sinh viên đại học đương đại, không chỉ cần học tốt kiến thức chuyên môn trên giảng đường chuyên ngành, mà còn phải quan tâm đến những vấn đề lớn về chính trị quốc gia và dân sinh xã hội.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '作为当代大学生，不仅要在专业课堂上学好专业知识，也要关心国家政治与社会民生大事。', 'Zuòwéi dāngdài dàxuéshēng, bù jǐn yào zài zhuānyè kètáng shang xué hǎo zhuānyè zhīshi, yě yào guānxīn guójiā zhèngzhì yǔ shèhuì mínshēng dàshì.', 'Là sinh viên đại học đương đại, không chỉ cần học tốt kiến thức chuyên môn trên giảng đường chuyên ngành, mà còn phải quan tâm đến những vấn đề lớn về chính trị quốc gia và dân sinh xã hội.', 'basic', 1),
      (v_id, '在全球地缘政治格局深刻重塑的复杂背景下，坚持多边主义与维护以国际法为基础的国际秩序成为捍卫世界和平的核心共识。', 'Zài quánqiú dìyuán zhèngzhì géjú shēndù chóngsù de fùzá bèijǐng xià, jiānchí duōbiānzhǔyì yǔ wéihù yǐ guójìfǎ wéi jīchǔ de guójì zhìxù chéngwéi hànwèi shìjiè hépíng de héxīn gòngshí.', 'Trong bối cảnh phức tạp của sự tái định hình sâu sắc cục diện địa chính trị toàn cầu, kiên trì chủ nghĩa đa phương và gìn giữ trật tự quốc tế trên cơ sở luật pháp quốc tế trở thành đồng thuận cốt lõi bảo vệ hòa bình thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3499] [支] (zhī) - cây, que; chi đội; chi trả, chống đỡ [Lượng từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '支' AND pinyin = 'zhī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '支' AND pinyin = 'zhī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '支'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '支'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Động từ',
      pinyin = 'zhī',
      meaning_vi = 'cây, que; chi đội; chi trả, chống đỡ',
      example_hanzi = '这支黑色的签字笔不仅出水流畅、手感舒适，而且写出来的字迹清晰不容易褪色。',
      example_pinyin = 'Zhè zhī hēisè de qiānzìbǐ bù jǐn chūshuǐ liúchàng, shǒugǎn shūshì, érqiě xiě chūlái de zìjì qīngxī bù róngyì tuìsè.',
      example_vi = 'Cây bút ký màu đen này không chỉ ra mực trơn tru, cầm vừa tay dễ chịu, mà chữ viết ra còn sắc nét và khó phai màu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '支',
      'zhī',
      'cây, que; chi đội; chi trả, chống đỡ',
      'Lượng từ / Động từ',
      'HSK 5',
      '这支黑色的签字笔不仅出水流畅、手感舒适，而且写出来的字迹清晰不容易褪色。',
      'Zhè zhī hēisè de qiānzìbǐ bù jǐn chūshuǐ liúchàng, shǒugǎn shūshì, érqiě xiě chūlái de zìjì qīngxī bù róngyì tuìsè.',
      'Cây bút ký màu đen này không chỉ ra mực trơn tru, cầm vừa tay dễ chịu, mà chữ viết ra còn sắc nét và khó phai màu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这支黑色的签字笔不仅出水流畅、手感舒适，而且写出来的字迹清晰不容易褪色。', 'Zhè zhī hēisè de qiānzìbǐ bù jǐn chūshuǐ liúchàng, shǒugǎn shūshì, érqiě xiě chūlái de zìjì qīngxī bù róngyì tuìsè.', 'Cây bút ký màu đen này không chỉ ra mực trơn tru, cầm vừa tay dễ chịu, mà chữ viết ra còn sắc nét và khó phai màu.', 'basic', 1),
      (v_id, '国家紧急从全国抽调了一支由顶尖流行病学家与重症医学专家组成的国家级医疗队，日夜兼程奔赴震灾前线指导抢险救援。', 'Guójiā jǐnjí cóng quánguó chōudiào le yì zhī yóu dǐngjiān liúxíngbìngxuéjiā yǔ zhòngzhèng yīxué zhuānjiā zǔchéng de guójiājí yīliáoduì, rìyè-jiānchéng bēnfù zhènzāi qiánxiàn zhǐdǎo qiǎngxiǎn jiùyuán.', 'Nhà nước đã khẩn cấp điều động một đội ngũ y tế cấp quốc gia gồm các nhà dịch tễ học và chuyên gia y học hồi sức cấp cứu hàng đầu, ngày đêm không ngừng chạy đua tới tiền tuyến vùng thảm họa động đất để chỉ đạo công tác cứu hộ khẩn cấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3500] [知名] (zhīmíng) - nổi tiếng, có tiếng tăm, lừng danh [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '知名' AND pinyin = 'zhīmíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '知名' AND pinyin = 'zhīmíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '知名'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '知名'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhīmíng',
      meaning_vi = 'nổi tiếng, có tiếng tăm, lừng danh',
      example_hanzi = '几位国际知名建筑设计师受邀参与了市中心新地标博物馆的设计竞标方案评审。',
      example_pinyin = 'Jǐ wèi guójì zhīmíng jiànzhù shèjìshī shòuyāo cānyù le shìzhōngxīn xīn-dìbiāo bówùguǎn de shèjì jìngbiāo fāng''àn píngshěn.',
      example_vi = 'Mấy vị kiến trúc sư nổi tiếng quốc tế đã nhận lời mời tham gia buổi chấm điểm phương án đấu thầu thiết kế bảo tàng biểu tượng mới ở trung tâm thành phố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '知名',
      'zhīmíng',
      'nổi tiếng, có tiếng tăm, lừng danh',
      'Tính từ',
      'HSK 5',
      '几位国际知名建筑设计师受邀参与了市中心新地标博物馆的设计竞标方案评审。',
      'Jǐ wèi guójì zhīmíng jiànzhù shèjìshī shòuyāo cānyù le shìzhōngxīn xīn-dìbiāo bówùguǎn de shèjì jìngbiāo fāng''àn píngshěn.',
      'Mấy vị kiến trúc sư nổi tiếng quốc tế đã nhận lời mời tham gia buổi chấm điểm phương án đấu thầu thiết kế bảo tàng biểu tượng mới ở trung tâm thành phố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '几位国际知名建筑设计师受邀参与了市中心新地标博物馆的设计竞标方案评审。', 'Jǐ wèi guójì zhīmíng jiànzhù shèjìshī shòuyāo cānyù le shìzhōngxīn xīn-dìbiāo bówùguǎn de shèjì jìngbiāo fāng''àn píngshěn.', 'Mấy vị kiến trúc sư nổi tiếng quốc tế đã nhận lời mời tham gia buổi chấm điểm phương án đấu thầu thiết kế bảo tàng biểu tượng mới ở trung tâm thành phố.', 'basic', 1),
      (v_id, '知名跨国科技巨头设立的开源基础软件基金会，致力于资助全球开发者社区共同维护核心编译器与分布式操作系统内核。', 'Zhīmíng kuàguó kējì jùtóu shèlì de kāiyuán jīchǔ ruǎnjiàn jījīnhuì, zhìlì yú zīzhù quánqiú kāifāzhě shèqū gòngtóng wéihù héxīn biānyìqì yǔ fēnbùshì cāozuò xìtǒng nèihé.', 'Quỹ phần mềm nền tảng mã nguồn mở do tập đoàn công nghệ xuyên quốc gia lừng danh thành lập chuyên tâm tài trợ cộng đồng các nhà phát triển toàn cầu cùng duy trì trình biên dịch cốt lõi và nhân hệ điều hành phân tán.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3501] [直] (zhí) - thẳng; trực tiếp; cứ mãi, thẳng thắn [Tính từ / Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '直' AND pinyin = 'zhí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '直' AND pinyin = 'zhí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '直'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '直'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ / Phó từ',
      pinyin = 'zhí',
      meaning_vi = 'thẳng; trực tiếp; cứ mãi, thẳng thắn',
      example_hanzi = '沿着这条宽阔的人行道一直往东走五百米，你就能看到那座造型壮观的现代图书馆了。',
      example_pinyin = 'Yán zhe zhè tiáo kuānkuò de rénxíngdào yìzhí wǎng dōng zǒu wǔbǎi mǐ, nǐ jiù néng kàndào nà zuò zàoxíng zhuàngguān de xiàndài túshūguǎn le.',
      example_vi = 'Cứ men theo lối đi bộ rộng rãi này đi thẳng về hướng đông năm trăm mét, bạn sẽ thấy được thư viện hiện đại với tạo hình hoành tráng đó.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '直',
      'zhí',
      'thẳng; trực tiếp; cứ mãi, thẳng thắn',
      'Tính từ / Động từ / Phó từ',
      'HSK 5',
      '沿着这条宽阔的人行道一直往东走五百米，你就能看到那座造型壮观的现代图书馆了。',
      'Yán zhe zhè tiáo kuānkuò de rénxíngdào yìzhí wǎng dōng zǒu wǔbǎi mǐ, nǐ jiù néng kàndào nà zuò zàoxíng zhuàngguān de xiàndài túshūguǎn le.',
      'Cứ men theo lối đi bộ rộng rãi này đi thẳng về hướng đông năm trăm mét, bạn sẽ thấy được thư viện hiện đại với tạo hình hoành tráng đó.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '沿着这条宽阔的人行道一直往东走五百米，你就能看到那座造型壮观的现代图书馆了。', 'Yán zhe zhè tiáo kuānkuò de rénxíngdào yìzhí wǎng dōng zǒu wǔbǎi mǐ, nǐ jiù néng kàndào nà zuò zàoxíng zhuàngguān de xiàndài túshūguǎn le.', 'Cứ men theo lối đi bộ rộng rãi này đi thẳng về hướng đông năm trăm mét, bạn sẽ thấy được thư viện hiện đại với tạo hình hoành tráng đó.', 'basic', 1),
      (v_id, '该高新技术产业园区的直通高速物流通道实现了海关通关与国际空港口岸的直连直通，极大压缩了企业跨境进出口的物流周转周期。', 'Gāi gāoxīn-jìshù chǎnyè yuánqū de zhítōng gāosù wùliú tōngdào shíxiàn le hǎiguān tōngguān yǔ guójì kōnggǎng kǒu''àn de zhílián-zhítōng, jídà yāsuō le qǐyè kuàjìng jìn-chūkǒu de wùliú zhōuzhuǎn zhōuqī.', 'Hành lang logistics cao tốc thông suốt của khu công nghiệp công nghệ cao này đã hiện thực hóa việc kết nối thẳng trực tiếp giữa thông quan hải quan và cửa khẩu cảng hàng không quốc tế, rút ngắn rất lớn chu kỳ luân chuyển logistics xuất nhập khẩu xuyên biên giới của doanh nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn tất cập nhật HSK 5 - Batch 15! Tổng số từ đã xử lý: %', v_count;
END $$;
