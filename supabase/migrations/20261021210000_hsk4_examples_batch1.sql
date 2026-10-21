-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 1 (100 TỪ)
-- Phạm vi: #1001 [啊] (ā) -> #1100 [此次] (cǐ cì)
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
  -- [啊] (ā) - a, chao ôi (thán từ ngạc nhiên, cảm thán) [Thán từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '啊' AND pinyin = 'ā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '啊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Thán từ',
      pinyin = 'ā',
      meaning_vi = 'a, chao ôi (thán từ ngạc nhiên, cảm thán)',
      example_hanzi = '啊，这里的风景真漂亮！',
      example_pinyin = 'Ā, zhèlǐ de fēngjǐng zhēn piàoliang!',
      example_vi = 'Chao ôi, phong cảnh ở đây đẹp thật đấy!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '啊，这里的风景真漂亮！', 'Ā, zhèlǐ de fēngjǐng zhēn piàoliang!', 'Chao ôi, phong cảnh ở đây đẹp thật đấy!', 'basic', 1),
        (v_id, '啊，我想起来了，原来昨天在地铁上遇到的人是你！', 'Ā, wǒ xiǎng qǐlái le, yuánlái zuótiān zài dìtiě shang yùdào de rén shì nǐ!', 'A, tôi nhớ ra rồi, hóa ra người gặp trên tàu điện ngầm hôm qua chính là bạn!', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [爱情] (àiqíng) - tình yêu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '爱情' AND pinyin = 'àiqíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '爱情'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'àiqíng',
      meaning_vi = 'tình yêu',
      example_hanzi = '他们俩经历了十年的爱情长跑，终于走进了婚姻的殿堂。',
      example_pinyin = 'Tāmen liǎ jīnglì le shí nián de àiqíng chángpǎo, zhōngyú zǒujìn le hūnyīn de diàntáng.',
      example_vi = 'Hai người họ trải qua mối tình kéo dài mười năm, cuối cùng đã bước vào lễ đường hôn nhân.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他们俩经历了十年的爱情长跑，终于走进了婚姻的殿堂。', 'Tāmen liǎ jīnglì le shí nián de àiqíng chángpǎo, zhōngyú zǒujìn le hūnyīn de diàntáng.', 'Hai người họ trải qua mối tình kéo dài mười năm, cuối cùng đã bước vào lễ đường hôn nhân.', 'basic', 1),
        (v_id, '真挚美好的爱情不仅需要彼此倾心，更需要漫长岁月里的互相理解与包容。', 'Zhēnzhì měihǎo de àiqíng bùjǐn xūyào bǐcǐ qīngxīn, gèng xūyào màncháng suìyuè lǐ de hùxiāng lǐjiě yǔ bāoróng.', 'Tình yêu chân thành tốt đẹp không chỉ cần sự say đắm của đôi bên, mà càng cần sự thấu hiểu và bao dung lẫn nhau qua năm tháng dài lâu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [爱心] (àixīn) - lòng nhân ái, tấm lòng yêu thương [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '爱心' AND pinyin = 'àixīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '爱心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'àixīn',
      meaning_vi = 'lòng nhân ái, tấm lòng yêu thương',
      example_hanzi = '全校师生为灾区小朋友们献出了一份爱心。',
      example_pinyin = 'Quán xiào shīshēng wèi zāiqū xiǎopéngyoumen xiànchū le yí fèn àixīn.',
      example_vi = 'Toàn thể thầy trò trong trường đã trao gửi một tấm lòng yêu thương tới các em nhỏ vùng thiên tai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '全校师生为灾区小朋友们献出了一份爱心。', 'Quán xiào shīshēng wèi zāiqū xiǎopéngyoumen xiànchū le yí fèn àixīn.', 'Toàn thể thầy trò trong trường đã trao gửi một tấm lòng yêu thương tới các em nhỏ vùng thiên tai.', 'basic', 1),
        (v_id, '这家慈善机构呼吁全社会奉献爱心，关爱那些需要帮助的孤寡老人。', 'Zhè jiā císhàn jīgòu hūyù quán shèhuì fèngxiàn àixīn, guān’ài nàxiē xūyào bāngzhù de gūguǎ lǎorén.', 'Cơ quan từ thiện này kêu gọi toàn xã hội chung tay đóng góp tình yêu thương, chăm lo cho những người già neo đơn cần được giúp đỡ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [安检] (ānjiǎn) - kiểm tra an ninh [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '安检' AND pinyin = 'ānjiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '安检'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'ānjiǎn',
      meaning_vi = 'kiểm tra an ninh',
      example_hanzi = '进入机场登机口前，所有旅客都要配合进行严格的安检。',
      example_pinyin = 'Jìnrù jīchǎng dēngjīkǒu qián, suǒyǒu lǚkè dōu yào pèihé jìnxíng yángé de ānjiǎn.',
      example_vi = 'Trước khi vào cửa lên máy bay ở sân bay, tất cả hành khách đều phải phối hợp kiểm tra an ninh nghiêm ngặt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '进入机场登机口前，所有旅客都要配合进行严格的安检。', 'Jìnrù jīchǎng dēngjīkǒu qián, suǒyǒu lǚkè dōu yào pèihé jìnxíng yángé de ānjiǎn.', 'Trước khi vào cửa lên máy bay ở sân bay, tất cả hành khách đều phải phối hợp kiểm tra an ninh nghiêm ngặt.', 'basic', 1),
        (v_id, '高峰期乘坐地铁时请尽量少带大件行李，以便迅速通过安检通道。', 'Gāofēngqī chéngzuò dìtiě shí qǐng jǐnliàng shǎo dài dàjiàn xíngli, yǐbiàn xùnsù tōngguò ānjiǎn tōngdào.', 'Khi đi tàu điện ngầm vào giờ cao điểm xin hãy hạn chế mang hành lý cồng kềnh để nhanh chóng đi qua lối kiểm tra an ninh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [安排] (ānpái) - sắp xếp, thu xếp; kế hoạch [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '安排' AND pinyin = 'ānpái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '安排'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'ānpái',
      meaning_vi = 'sắp xếp, thu xếp; kế hoạch',
      example_hanzi = '经理把这次商务洽谈的接待工作安排得井井有条。',
      example_pinyin = 'Jīnglǐ bǎ zhè cì shāngwù qiàtán de jiēdài gōngzuò ānpái de jǐngjǐng-yǒutiáo.',
      example_vi = 'Giám đốc đã thu xếp công việc tiếp đón đàm phán thương mại lần này vô cùng ngăn nắp chu đáo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经理把这次商务洽谈的接待工作安排得井井有条。', 'Jīnglǐ bǎ zhè cì shāngwù qiàtán de jiēdài gōngzuò ānpái de jǐngjǐng-yǒutiáo.', 'Giám đốc đã thu xếp công việc tiếp đón đàm phán thương mại lần này vô cùng ngăn nắp chu đáo.', 'basic', 1),
        (v_id, '合理的日程安排不仅能显著提高工作效率，还能留出充足的时间陪伴家人。', 'Hélǐ de rìchéng ānpái bùjǐn néng xiǎnzhù tígāo gōngzuò xiàolǜ, hái néng liú chū chōngzú de shíjiān péibàn jiārén.', 'Sắp xếp lịch trình hợp lý không những nâng cao rõ rệt hiệu quả công việc mà còn dành ra được đủ thời gian bên gia đình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [按] (àn) - ấn, bấm; theo, căn cứ vào [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '按' AND pinyin = 'àn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '按'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Giới từ',
      pinyin = 'àn',
      meaning_vi = 'ấn, bấm; theo, căn cứ vào',
      example_hanzi = '请按下电梯右侧的按钮前往五层。',
      example_pinyin = 'Qǐng àn xià diàntī yòucè de ànniǔ qiánwǎng wǔ céng.',
      example_vi = 'Xin hãy bấm nút bấm bên phải thang máy để lên tầng năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请按下电梯右侧的按钮前往五层。', 'Qǐng àn xià diàntī yòucè de ànniǔ qiánwǎng wǔ céng.', 'Xin hãy bấm nút bấm bên phải thang máy để lên tầng năm.', 'basic', 1),
        (v_id, '我们应该严格按合同规定的条款履行各自的责任与义务。', 'Wǒmen yīnggāi yángé àn hétong guīdìng de tiáokuǎn lǚxíng gèzì de zérèn yǔ yìwù.', 'Chúng ta nên thực hiện nghiêm túc trách nhiệm và nghĩa vụ của mỗi bên căn cứ theo các điều khoản trong hợp đồng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [按时] (ànshí) - đúng giờ [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '按时' AND pinyin = 'ànshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '按时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'ànshí',
      meaning_vi = 'đúng giờ',
      example_hanzi = '生病吃药一定要按时按量，切不可随意停药。',
      example_pinyin = 'Shēngbìng chī yào yídìng yào ànshí ànliàng, qiè bù kě suíyì tíng yào.',
      example_vi = 'Bị ốm uống thuốc nhất định phải đúng giờ đúng liều lượng, tuyệt đối không được tự ý ngừng thuốc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '生病吃药一定要按时按量，切不可随意停药。', 'Shēngbìng chī yào yídìng yào ànshí ànliàng, qiè bù kě suíyì tíng yào.', 'Bị ốm uống thuốc nhất định phải đúng giờ đúng liều lượng, tuyệt đối không được tự ý ngừng thuốc.', 'basic', 1),
        (v_id, '团队成员齐心协力赶进度，最终按时向客户交付了高质量的产品。', 'Tuánduì chéngyuán qíxīn-xiélì gǎn jìndù, zuìzhōng ànshí xiàng kèhù jiāofù le gāo zhìliàng de chǎnpǐn.', 'Các thành viên trong nhóm đồng lòng đẩy nhanh tiến độ, cuối cùng đã bàn giao sản phẩm chất lượng cao cho khách hàng đúng hạn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [按照] (ànzhào) - dựa theo, chiếu theo [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '按照' AND pinyin = 'ànzhào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '按照'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'ànzhào',
      meaning_vi = 'dựa theo, chiếu theo',
      example_hanzi = '请大家按照老师指导的步骤一步一步做实验。',
      example_pinyin = 'Qǐng dàjiā ànzhào lǎoshī zhǐdǎo de bùzhòu yí bù yí bù zuò shíyàn.',
      example_vi = 'Xin mọi người hãy làm thí nghiệm từng bước một theo đúng các bước thầy giáo đã hướng dẫn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请大家按照老师指导的步骤一步一步做实验。', 'Qǐng dàjiā ànzhào lǎoshī zhǐdǎo de bùzhòu yí bù yí bù zuò shíyàn.', 'Xin mọi người hãy làm thí nghiệm từng bước một theo đúng các bước thầy giáo đã hướng dẫn.', 'basic', 1),
        (v_id, '公司各项财务报销必须严格按照最新的财务制度执行。', 'Gōngsī gè xiàng cáiwù bàoxiāo bìxū yángé ànzhào zuìxīn de cáiwù zhìdù zhíxíng.', 'Mọi khoản thanh toán tài chính của công ty đều phải chấp hành nghiêm ngặt theo quy chế tài chính mới nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [白酒] (báijiǔ) - rượu trắng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '白酒' AND pinyin = 'báijiǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '白酒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'báijiǔ',
      meaning_vi = 'rượu trắng',
      example_hanzi = '中国传统宴席上往往少不了香醇浓厚的白酒。',
      example_pinyin = 'Zhōngguó chuántǒng yànxí shang wǎngwǎng shǎobuliǎo xiāngchún nónghòu de báijiǔ.',
      example_vi = 'Trên các bữa tiệc truyền thống Trung Hoa thường không thể thiếu món rượu trắng thơm nồng đậm đà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国传统宴席上往往少不了香醇浓厚的白酒。', 'Zhōngguó chuántǒng yànxí shang wǎngwǎng shǎobuliǎo xiāngchún nónghòu de báijiǔ.', 'Trên các bữa tiệc truyền thống Trung Hoa thường không thể thiếu món rượu trắng thơm nồng đậm đà.', 'basic', 1),
        (v_id, '虽然逢年过节饮用白酒有助兴的习俗，但为了身体健康仍需适量少饮。', 'Suīrán féngnián-guòjié yǐnyòng báijiǔ yǒu zhùxìng de xísú, dàn wèile shēntǐ jiànkāng réng xū shìliàng shǎo yǐn.', 'Dù ngày Tết có phong tục uống rượu trắng góp vui, nhưng vì sức khỏe vẫn nên uống chừng mực ít lại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [办公] (bàngōng) - làm việc tại văn phòng, xử lý công vụ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '办公' AND pinyin = 'bàngōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '办公'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bàngōng',
      meaning_vi = 'làm việc tại văn phòng, xử lý công vụ',
      example_hanzi = '王主任正在楼上的办公室办公，请您稍等片刻。',
      example_pinyin = 'Wáng zhǔrèn zhèngzài lóushang de bàngōngshì bàngōng, qǐng nín shāoděng piànkè.',
      example_vi = 'Chủ nhiệm Vương đang xử lý công vụ trong phòng làm việc trên tầng, xin ông đợi chốc lát.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '王主任正在楼上的办公室办公，请您稍等片刻。', 'Wáng zhǔrèn zhèngzài lóushang de bàngōngshì bàngōng, qǐng nín shāoděng piànkè.', 'Chủ nhiệm Vương đang xử lý công vụ trong phòng làm việc trên tầng, xin ông đợi chốc lát.', 'basic', 1),
        (v_id, '随着移动互联网技术的普及，越来越多企业开始推行灵活高效的远程居家办公模式。', 'Suízhe yídòng hùliánwǎng jìshù de pǔjí, yuè lái yuè duō qǐyè kāishǐ tuīxíng línghuó gāoxiào de yuǎnchéng jūjiā bàngōng móshì.', 'Cùng với sự phổ biến của công nghệ internet di động, ngày càng nhiều doanh nghiệp bắt đầu áp dụng mô hình làm việc từ xa tại nhà linh hoạt và hiệu quả.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [办理] (bànlǐ) - xử lý, giải quyết, làm thủ tục [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '办理' AND pinyin = 'bànlǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '办理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bànlǐ',
      meaning_vi = 'xử lý, giải quyết, làm thủ tục',
      example_hanzi = '请您带好身份证前往前台办理入住登记手续。',
      example_pinyin = 'Qǐng nín dài hǎo shēnfènzhèng qiánwǎng qiántái bànlǐ rùzhù dēngjì shǒuxù.',
      example_vi = 'Xin quý khách mang theo chứng minh thư tới quầy lễ tân để làm thủ tục đăng ký nhận phòng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请您带好身份证前往前台办理入住登记手续。', 'Qǐng nín dài hǎo shēnfènzhèng qiánwǎng qiántái bànlǐ rùzhù dēngjì shǒuxù.', 'Xin quý khách mang theo chứng minh thư tới quầy lễ tân để làm thủ tục đăng ký nhận phòng.', 'basic', 1),
        (v_id, '出国留学前，务必要提前准备好各项材料以便顺利办理签证。', 'Chūguó liúxué qián, wùbì yào tíqián zhǔnbèi hǎo gè xiàng cáiliào yǐbiàn shùnlì bànlǐ qiānzhèng.', 'Trước khi đi du học nước ngoài, nhất định phải chuẩn bị sẵn sàng các loại giấy tờ để làm visa thuận lợi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [办事] (bànshì) - làm việc, giải quyết công việc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '办事' AND pinyin = 'bànshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '办事'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bànshì',
      meaning_vi = 'làm việc, giải quyết công việc',
      example_hanzi = '他为人沉稳老练，办事一向非常认真踏实。',
      example_pinyin = 'Tā wéirén chénwěn lǎoliàn, bànshì yíxiàng fēicháng rènzhēn tāshi.',
      example_vi = 'Anh ấy đối nhân xử thế điềm đạm từng trải, làm việc luôn hết sức cẩn thận vững vàng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他为人沉稳老练，办事一向非常认真踏实。', 'Tā wéirén chénwěn lǎoliàn, bànshì yíxiàng fēicháng rènzhēn tāshi.', 'Anh ấy đối nhân xử thế điềm đạm từng trải, làm việc luôn hết sức cẩn thận vững vàng.', 'basic', 1),
        (v_id, '市民服务中心推行一站式服务，极大地方便了广大群众前来办事。', 'Shìmín fúwù zhōngxīn tuīxíng yízhànshì fúwù, jídà de fāngbiàn le guǎngdà qúnzhòng qiánlái bànshì.', 'Trung tâm dịch vụ công người dân triển khai dịch vụ một cửa, tạo thuận tiện tối đa cho đông đảo quần chúng tới giải quyết thủ tục hành chính.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [棒] (bàng) - giỏi, cừ, tuyệt vời; cây gậy [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '棒' AND pinyin = 'bàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '棒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'bàng',
      meaning_vi = 'giỏi, cừ, tuyệt vời; cây gậy',
      example_hanzi = '你在今天的汉语演讲比赛中表现得太棒了！',
      example_pinyin = 'Nǐ zài jīntiān de Hànyǔ yǎnjiǎng bǐsài zhōng biǎoxiàn de tài bàng le!',
      example_vi = 'Hôm nay bạn thể hiện trong cuộc thi hùng biện tiếng Trung cừ khôi quá!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你在今天的汉语演讲比赛中表现得太棒了！', 'Nǐ zài jīntiān de Hànyǔ yǎnjiǎng bǐsài zhōng biǎoxiàn de tài bàng le!', 'Hôm nay bạn thể hiện trong cuộc thi hùng biện tiếng Trung cừ khôi quá!', 'basic', 1),
        (v_id, '他不仅学习成绩拔尖，体育运动方面也很棒，是大家公认的榜样。', 'Tā bùjǐn xuéxí chéngjì bájiān, tǐyù yùndòng fāngmiàn yě hěn bàng, shì dàjiā gōngrèn de bǎngyàng.', 'Cậu ấy không chỉ có thành tích học tập xuất sắc mà phương diện thể thao cũng rất cừ, là tấm gương mẫu mực được mọi người công nhận.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [保护] (bǎohù) - bảo vệ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '保护' AND pinyin = 'bǎohù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '保护'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bǎohù',
      meaning_vi = 'bảo vệ',
      example_hanzi = '爱护树木、保护生态环境是每个公民应尽的责任。',
      example_pinyin = 'Àihù shùmù, bǎohù shēngtài huánjìng shì měi gè gōngmín yīng jìn de zérèn.',
      example_vi = 'Yêu quý cây xanh, bảo vệ môi trường sinh thái là trách nhiệm mà mỗi công dân cần thực hiện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爱护树木、保护生态环境是每个公民应尽的责任。', 'Àihù shùmù, bǎohù shēngtài huánjìng shì měi gè gōngmín yīng jìn de zérèn.', 'Yêu quý cây xanh, bảo vệ môi trường sinh thái là trách nhiệm mà mỗi công dân cần thực hiện.', 'basic', 1),
        (v_id, '日常使用手机和电脑时要注意用眼卫生，切实保护好自己的视力。', 'Rìcháng shǐyòng shǒujī hé diànnǎo shí yào zhùyì yòngyǎn wèishēng, qièshí bǎohù hǎo zìjǐ de shìlì.', 'Hàng ngày khi dùng điện thoại và máy tính cần chú ý vệ sinh mắt để bảo vệ tốt thị lực của mình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [保证] (bǎozhèng) - bảo đảm, cam đoan; sự bảo đảm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '保证' AND pinyin = 'bǎozhèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '保证'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'bǎozhèng',
      meaning_vi = 'bảo đảm, cam đoan; sự bảo đảm',
      example_hanzi = '我向大家保证，一定会在规定期限内保质保量完成任务。',
      example_pinyin = 'Wǒ xiàng dàjiā bǎozhèng, yídìng huì zài guīdìng qīxiàn nèi bǎozhì-bǎoliàng wánchéng rènwu.',
      example_vi = 'Tôi bảo đảm với mọi người, nhất định sẽ hoàn thành nhiệm vụ đúng hạn định cả về chất lẫn lượng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我向大家保证，一定会在规定期限内保质保量完成任务。', 'Wǒ xiàng dàjiā bǎozhèng, yídìng huì zài guīdìng qīxiàn nèi bǎozhì-bǎoliàng wánchéng rènwu.', 'Tôi bảo đảm với mọi người, nhất định sẽ hoàn thành nhiệm vụ đúng hạn định cả về chất lẫn lượng.', 'basic', 1),
        (v_id, '充足的睡眠和均衡的饮食是维持身体健康的最基本保证。', 'Chōngzú de shuìmián hé jūnhéng de yǐnshí shì wéichí shēntǐ jiànkāng de zuì jīběn bǎozhèng.', 'Giấc ngủ đầy đủ và chế độ ăn uống cân bằng là sự bảo đảm cơ bản nhất để duy trì sức khỏe cơ thể.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [抱] (bào) - ôm, ẵm, bế [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '抱' AND pinyin = 'bào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '抱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bào',
      meaning_vi = 'ôm, ẵm, bế',
      example_hanzi = '母亲温柔地把哭泣的婴儿抱在怀里轻声哄着。',
      example_pinyin = 'Mǔqīn wēnróu de bǎ kūqì de yīng’ér bào zài huái lǐ qīngshēng hǒng zhe.',
      example_vi = 'Người mẹ dịu dàng ôm đứa trẻ sơ sinh đang khóc vào lòng khẽ dỗ dành.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '母亲温柔地把哭泣的婴儿抱在怀里轻声哄着。', 'Mǔqīn wēnróu de bǎ kūqì de yīng’ér bào zài huái lǐ qīngshēng hǒng zhe.', 'Người mẹ dịu dàng ôm đứa trẻ sơ sinh đang khóc vào lòng khẽ dỗ dành.', 'basic', 1),
        (v_id, '久别重逢的两位挚友激动地紧紧拥抱在一起，久久不愿分开。', 'Jiǔbié-chóngféng de liǎng wèi zhìyǒu jīdòng de jǐnjǐn yōngbào zài yìqǐ, jiǔjiǔ bú yuàn fēnkāi.', 'Hai người bạn thân lâu ngày hội ngộ xúc động ôm chặt lấy nhau, mãi không nỡ rời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [报考] (bàokǎo) - đăng ký dự thi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '报考' AND pinyin = 'bàokǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '报考'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bàokǎo',
      meaning_vi = 'đăng ký dự thi',
      example_hanzi = '高中毕业后，他决定报考北京大学的中文系。',
      example_pinyin = 'Gāozhōng bìyè hòu, tā juédìng bàokǎo Běijīng Dàxué de Zhōngwén xì.',
      example_vi = 'Sau khi tốt nghiệp cấp ba, anh ấy quyết định đăng ký dự thi vào khoa Trung văn trường Đại học Bắc Kinh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '高中毕业后，他决定报考北京大学的中文系。', 'Gāozhōng bìyè hòu, tā juédìng bàokǎo Běijīng Dàxué de Zhōngwén xì.', 'Sau khi tốt nghiệp cấp ba, anh ấy quyết định đăng ký dự thi vào khoa Trung văn trường Đại học Bắc Kinh.', 'basic', 1),
        (v_id, '考生在报考研究生专业前，应当结合自身的学术兴趣和长远职业规划慎重抉择。', 'Kǎoshēng zài bàokǎo yánjiūshēng zhuānyè qián, yīngdāng jiéhé zìshēn de xuéshù xìngqù hé chángyuǎn zhíyè guīhuà shènzhòng juézé.', 'Thí sinh trước khi đăng ký dự thi chuyên ngành cao học nên kết hợp sở thích học thuật của bản thân và định hướng nghề nghiệp lâu dài để lựa chọn thận trọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [报名] (bàomíng) - ghi danh, đăng ký [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '报名' AND pinyin = 'bàomíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '报名'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bàomíng',
      meaning_vi = 'ghi danh, đăng ký',
      example_hanzi = '新学期的书法兴趣班明天上午开始正式报名。',
      example_pinyin = 'Xīn xuéqī de shūfǎ xìngqù bān míngtiān shàngwǔ kāishǐ zhèngshì bàomíng.',
      example_vi = 'Lớp học thư pháp năng khiếu của học kỳ mới sáng mai bắt đầu chính thức nhận đăng ký.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '新学期的书法兴趣班明天上午开始正式报名。', 'Xīn xuéqī de shūfǎ xìngqù bān míngtiān shàngwǔ kāishǐ zhèngshì bàomíng.', 'Lớp học thư pháp năng khiếu của học kỳ mới sáng mai bắt đầu chính thức nhận đăng ký.', 'basic', 1),
        (v_id, '听说了这次国际马拉松赛事的举办消息，许多运动爱好者纷纷踊跃报名参加。', 'Tīngshuō le zhè cì guójì mǎlāsōng sàishì de jǔbàn xiāoxi, xǔduō yùndòng àihàozhě fēnfēn yǒngyuè bàomíng cānjiā.', 'Nghe tin giải chạy marathon quốc tế lần này được tổ chức, đông đảo người yêu thể thao đã nô nức ghi danh tham gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [抱歉] (bàoqiàn) - xin lỗi, áy náy [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '抱歉' AND pinyin = 'bàoqiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '抱歉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'bàoqiàn',
      meaning_vi = 'xin lỗi, áy náy',
      example_hanzi = '非常抱歉，路上堵车耽误了时间，让您久等了。',
      example_pinyin = 'Fēicháng bàoqiàn, lù shang dǔchē dānwu le shíjiān, ràng nín jiǔ děng le.',
      example_vi = 'Vô cùng xin lỗi, trên đường kẹt xe làm lỡ mất thời gian khiến anh phải đợi lâu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '非常抱歉，路上堵车耽误了时间，让您久等了。', 'Fēicháng bàoqiàn, lù shang dǔchē dānwu le shíjiān, ràng nín jiǔ děng le.', 'Vô cùng xin lỗi, trên đường kẹt xe làm lỡ mất thời gian khiến anh phải đợi lâu.', 'basic', 1),
        (v_id, '由于天气突变导致航班延误，航空公司向全体乘客深表抱歉并妥善安排了食宿。', 'Yóuyú tiānqì tūbiàn dǎozhì hángbān yánwù, hángkōng gōngsī xiàng quántǐ chéngkè shēn biǎo bàoqiàn bìng tuǒshàn ānpái le shí-sù.', 'Do thời tiết thay đổi đột ngột làm chuyến bay bị hoãn, hãng hàng không bày tỏ sự xin lỗi sâu sắc tới toàn thể hành khách và thu xếp ăn ở chu đáo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [背] (bēi) - cõng, đeo, mang trên lưng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '背' AND pinyin = 'bēi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '背'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bēi',
      meaning_vi = 'cõng, đeo, mang trên lưng',
      example_hanzi = '小学生们每天早晨背着书包开开心心去上学。',
      example_pinyin = 'Xiǎoxuéshēngmen měitiān zǎochén bēi zhe shūbāo kāikāi-xīnxīn qù shàngxué.',
      example_vi = 'Các em học sinh tiểu học mỗi sáng đeo ba lô vui vẻ tới trường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小学生们每天早晨背着书包开开心心去上学。', 'Xiǎoxuéshēngmen měitiān zǎochén bēi zhe shūbāo kāikāi-xīnxīn qù shàngxué.', 'Các em học sinh tiểu học mỗi sáng đeo ba lô vui vẻ tới trường.', 'basic', 1),
        (v_id, '父亲背着年幼发烧的孩子冒着大雨匆匆赶往医院看急诊。', 'Fùqīn bēi zhe niányòu fāshāo de háizi mào zhe dàyǔ cōngcōng gǎnwǎng yīyuàn kàn jízhěn.', 'Người cha cõng đứa con nhỏ đang phát sốt đội mưa vội vã chạy tới bệnh viện cấp cứu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [背包] (bēibāo) - ba lô, túi đeo lưng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '背包' AND pinyin = 'bēibāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '背包'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bēibāo',
      meaning_vi = 'ba lô, túi đeo lưng',
      example_hanzi = '这个黑色双肩背包容量很大，适合旅行时使用。',
      example_pinyin = 'Zhè gè hēisè shuāngjiān bēibāo róngliàng hěn dà, shìhé lǚxíng shí shǐyòng.',
      example_vi = 'Chiếc ba lô hai quai màu đen này dung tích rất lớn, thích hợp dùng khi đi du lịch.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个黑色双肩背包容量很大，适合旅行时使用。', 'Zhè gè hēisè shuāngjiān bēibāo róngliàng hěn dà, shìhé lǚxíng shí shǐyòng.', 'Chiếc ba lô hai quai màu đen này dung tích rất lớn, thích hợp dùng khi đi du lịch.', 'basic', 1),
        (v_id, '出门徒步远足前，一定要仔细检查背包里的水壶、急救药品和充电宝是否带齐。', 'Chūmén túbù yuǎnzú qián, yídìng yào zǐxì jiǎnchá bēibāo lǐ de shuǐhú, jíjiù yàopǐn hé chōngdiànbǎo shìfǒu dài qí.', 'Trước khi ra ngoài đi bộ đường dài, nhất định phải kiểm tra kỹ lưỡng bình nước, thuốc sơ cứu và sạc dự phòng trong ba lô đã mang đủ chưa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [北部] (běibù) - miền bắc, phía bắc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '北部' AND pinyin = 'běibù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '北部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'běibù',
      meaning_vi = 'miền bắc, phía bắc',
      example_hanzi = '中国北部的冬天雪景壮丽，银装素裹。',
      example_pinyin = 'Zhōngguó běibù de dōngtiān xuějǐng zhuànglì, yínzhuāng-sùguǒ.',
      example_vi = 'Mùa đông miền bắc Trung Quốc cảnh tuyết hùng vĩ, khoác lên mình chiếc áo trắng bạc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国北部的冬天雪景壮丽，银装素裹。', 'Zhōngguó běibù de dōngtiān xuějǐng zhuànglì, yínzhuāng-sùguǒ.', 'Mùa đông miền bắc Trung Quốc cảnh tuyết hùng vĩ, khoác lên mình chiếc áo trắng bạc.', 'basic', 1),
        (v_id, '这家科技企业计划在国家北部各大重点城市设立区域研发中心。', 'Zhè jiā kējì qǐyè jìhuà zài guójiā běibù gè dà zhòngdiǎn chéngshì shèlì qūyù yánfā zhōngxīn.', 'Doanh nghiệp công nghệ này dự định thành lập các trung tâm nghiên cứu phát triển vùng tại các thành phố trọng điểm phía bắc đất nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [倍] (bèi) - lần, gấp bội (lượng từ số lần gấp) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '倍' AND pinyin = 'bèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '倍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'bèi',
      meaning_vi = 'lần, gấp bội (lượng từ số lần gấp)',
      example_hanzi = '今年我们果园的水果产量比去年增加了一倍。',
      example_pinyin = 'Jīnnián wǒmen guǒyuán de shuǐguǒ chǎnliàng bǐ qùnián zēngjiā le yí bèi.',
      example_vi = 'Sản lượng hoa quả của vườn chúng tôi năm nay tăng gấp đôi so với năm ngoái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今年我们果园的水果产量比去年增加了一倍。', 'Jīnnián wǒmen guǒyuán de shuǐguǒ chǎnliàng bǐ qùnián zēngjiā le yí bèi.', 'Sản lượng hoa quả của vườn chúng tôi năm nay tăng gấp đôi so với năm ngoái.', 'basic', 1),
        (v_id, '采用新型自动化流水线之后，工人们的生产效率整整提高了三倍。', 'Cǎiyòng xīnxíng zìdònghuà liúshuǐxiàn zhīhòu, gōngrénmen de shēngchǎn xiàolǜ zhěngzhěng tígāo le sān bèi.', 'Sau khi áp dụng dây chuyền tự động hóa kiểu mới, năng suất sản xuất của công nhân đã tăng trọn vẹn gấp ba lần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [本科] (běnkē) - đại học chính quy, hệ cử nhân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '本科' AND pinyin = 'běnkē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '本科'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'běnkē',
      meaning_vi = 'đại học chính quy, hệ cử nhân',
      example_hanzi = '完成四年本科学习后，他打算继续攻读硕士研究生。',
      example_pinyin = 'Wánchéng sì nián běnkē xuéxí hòu, tā dǎsuàn jìxù gōngdú shuòshì yánjiūshēng.',
      example_vi = 'Sau khi hoàn thành bốn năm học đại học chính quy, cậu ấy dự định tiếp tục học thạc sĩ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '完成四年本科学习后，他打算继续攻读硕士研究生。', 'Wánchéng sì nián běnkē xuéxí hòu, tā dǎsuàn jìxù gōngdú shuòshì yánjiūshēng.', 'Sau khi hoàn thành bốn năm học đại học chính quy, cậu ấy dự định tiếp tục học thạc sĩ.', 'basic', 1),
        (v_id, '这所知名综合性大学的本科教学注重理论基础与科研实践的有机结合。', 'Zhè suǒ zhīmíng zōnghéxìng dàxué de běnkē jiàoxué zhùzhòng lǐlùn jīchǔ yǔ kēyán shíjiàn de yǒujī jiéhé.', 'Chương trình giảng dạy hệ cử nhân của trường đại học tổng hợp danh tiếng này chú trọng sự kết hợp hữu cơ giữa nền tảng lý thuyết và thực hành nghiên cứu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [本来] (běnlái) - vốn dĩ, ban đầu [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '本来' AND pinyin = 'běnlái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '本来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Tính từ',
      pinyin = 'běnlái',
      meaning_vi = 'vốn dĩ, ban đầu',
      example_hanzi = '我本来打算今天去郊游，可是突如其来的大雨打乱了计划。',
      example_pinyin = 'Wǒ běnlái dǎsuàn jīntiān qù jiāoyóu, kěshì tūrúqílái de dàyǔ dǎluàn le jìhuà.',
      example_vi = 'Tôi vốn định đi dã ngoại hôm nay, nhưng cơn mưa lớn bất ngờ đã làm đảo lộn kế hoạch.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我本来打算今天去郊游，可是突如其来的大雨打乱了计划。', 'Wǒ běnlái dǎsuàn jīntiān qù jiāoyóu, kěshì tūrúqílái de dàyǔ dǎluàn le jìhuà.', 'Tôi vốn định đi dã ngoại hôm nay, nhưng cơn mưa lớn bất ngờ đã làm đảo lộn kế hoạch.', 'basic', 1),
        (v_id, '这件事情本来并不复杂，由于各方沟通不畅才演变成现在的僵局。', 'Zhè jiàn shìqing běnlái bìng bù fùzá, yóuyú gè fāng gōutōng bú chàng cái yǎnbiàn chéng xiànzài de jiāngjú.', 'Chuyện này vốn không hề phức tạp, do các bên trao đổi không thông suốt mới biến thành cục diện bế tắc hiện nay.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [笨] (bèn) - ngốc, vụng về, chậm chạp [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '笨' AND pinyin = 'bèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '笨'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'bèn',
      meaning_vi = 'ngốc, vụng về, chậm chạp',
      example_hanzi = '不要总觉得自己笨，只要肯下苦功夫就一定能学好。',
      example_pinyin = 'Bú yào zǒng juéde zìjǐ bèn, zhǐyào kěn xià kǔ gōngfu jiù yídìng néng xué hǎo.',
      example_vi = 'Đừng luôn nghĩ rằng mình ngốc, chỉ cần chịu khó khổ luyện thì nhất định sẽ học giỏi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '不要总觉得自己笨，只要肯下苦功夫就一定能学好。', 'Bú yào zǒng juéde zìjǐ bèn, zhǐyào kěn xià kǔ gōngfu jiù yídìng néng xué hǎo.', 'Đừng luôn nghĩ rằng mình ngốc, chỉ cần chịu khó khổ luyện thì nhất định sẽ học giỏi.', 'basic', 1),
        (v_id, '“笨鸟先飞早入林”，天资不够聪颖的人更应当凭借勤奋努力赢得成功。', '“Bènniǎo-xiānfēi zǎo rù lín”, tiānzī bú gòu cōngyǐng de rén gèng yīngdāng píngjiè qínfèn nǔlì yíngdé chénggōng.', '"Chim chậm bay trước vào rừng sớm", người có thiên tư chưa đủ thông minh càng nên dựa vào sự siêng năng cần cù để giành lấy thành công.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [鼻子] (bízi) - mũi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '鼻子' AND pinyin = 'bízi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '鼻子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bízi',
      meaning_vi = 'mũi',
      example_hanzi = '他感冒了，鼻子一直堵着很不舒服。',
      example_pinyin = 'Tā gǎnmào le, bízi yìzhí dǔ zhe hěn bù shūfu.',
      example_vi = 'Cậu ấy bị cảm cúm, mũi cứ nghẹt suốt rất khó chịu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他感冒了，鼻子一直堵着很不舒服。', 'Tā gǎnmào le, bízi yìzhí dǔ zhe hěn bù shūfu.', 'Cậu ấy bị cảm cúm, mũi cứ nghẹt suốt rất khó chịu.', 'basic', 1),
        (v_id, '警犬的鼻子拥有极其敏锐的嗅觉，能够迅速搜寻出隐藏的违禁物品。', 'Jǐngquǎn de bízi yōngyǒu jíqí mǐnruì de xiùjué, nénggòu xùnsù sōuxún chū yǐncáng de wéijìn wùpǐn.', 'Chiếc mũi của chó nghiệp vụ sở hữu khứu giác cực kỳ nhạy bén, có thể nhanh chóng đánh hơi ra các đồ vật cấm được giấu kỹ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [笔试] (bǐshì) - thi viết, bài thi viết [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '笔试' AND pinyin = 'bǐshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '笔试'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'bǐshì',
      meaning_vi = 'thi viết, bài thi viết',
      example_hanzi = '通过了第一轮笔试之后，他收到了下周面试的通知。',
      example_pinyin = 'Tōngguò le dì-yī lún bǐshì zhīhòu, tā shōudào le xià zhōu miànshì de tōngzhī.',
      example_vi = 'Sau khi qua vòng thi viết đầu tiên, anh ấy đã nhận được thông báo phỏng vấn vào tuần tới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '通过了第一轮笔试之后，他收到了下周面试的通知。', 'Tōngguò le dì-yī lún bǐshì zhīhòu, tā shōudào le xià zhōu miànshì de tōngzhī.', 'Sau khi qua vòng thi viết đầu tiên, anh ấy đã nhận được thông báo phỏng vấn vào tuần tới.', 'basic', 1),
        (v_id, '这次公务员招聘考核分为专业笔试和综合面试两个主要环节。', 'Zhè cì gōngwùyuán zhāopìn kǎohé fēnwéi zhuānyè bǐshì hé zōnghé miànshì liǎng gè zhǔyào huánjié.', 'Kỳ thi tuyển dụng công chức lần này được chia thành hai khâu then chốt: thi viết chuyên môn và phỏng vấn tổng hợp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [毕业] (bìyè) - tốt nghiệp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '毕业' AND pinyin = 'bìyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '毕业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bìyè',
      meaning_vi = 'tốt nghiệp',
      example_hanzi = '同学们穿着学士服在图书馆门前拍毕业合影。',
      example_pinyin = 'Tóngxuémen chuān zhe xuéshìfú zài túshūguǎn ménqián pāi bìyè héyǐng.',
      example_vi = 'Các bạn học sinh viên mặc áo cử nhân chụp ảnh kỷ yếu tốt nghiệp trước cửa thư viện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '同学们穿着学士服在图书馆门前拍毕业合影。', 'Tóngxuémen chuān zhe xuéshìfú zài túshūguǎn ménqián pāi bìyè héyǐng.', 'Các bạn học sinh viên mặc áo cử nhân chụp ảnh kỷ yếu tốt nghiệp trước cửa thư viện.', 'basic', 1),
        (v_id, '大学毕业不仅标志着一段学习生涯的结束，更意味着正式开启崭新的人生职场旅程。', 'Dàxué bìyè bùjǐn biāozhì zhe yí duàn xuéxí shēngyá de jiéshù, gèng yìwèizhe zhèngshì kāiqǐ zhǎnxīn de rénshēng zhíchǎng lǚchéng.', 'Tốt nghiệp đại học không chỉ đánh dấu kết thúc một chặng đường học tập, mà càng có ý nghĩa chính thức mở ra hành trình sự nghiệp đời người mới toanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [毕业生] (bìyèshēng) - sinh viên / học sinh tốt nghiệp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '毕业生' AND pinyin = 'bìyèshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '毕业生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bìyèshēng',
      meaning_vi = 'sinh viên / học sinh tốt nghiệp',
      example_hanzi = '每年六月份，高校毕业生们都会迎来繁忙的求职季。',
      example_pinyin = 'Měinián liù yuèfèn, gāoxiào bìyèshēngmen dōu huì yínglái fánmáng de qiúzhí jì.',
      example_vi = 'Vào tháng sáu hàng năm, các sinh viên tốt nghiệp đại học đều đón mùa tìm việc làm bận rộn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年六月份，高校毕业生们都会迎来繁忙的求职季。', 'Měinián liù yuèfèn, gāoxiào bìyèshēngmen dōu huì yínglái fánmáng de qiúzhí jì.', 'Vào tháng sáu hàng năm, các sinh viên tốt nghiệp đại học đều đón mùa tìm việc làm bận rộn.', 'basic', 1),
        (v_id, '为了促进优秀毕业生就业，学校特意邀请了上百家知名企业举办大型双选招聘会。', 'Wèile cùjìn yōuxiù bìyèshēng jiùyè, xuéxiào tèyì yāoqǐng le shàngbǎi jiā zhīmíng qǐyè jǔbàn dàxíng shuāngxuǎn zhāopìnhuì.', 'Nhằm thúc đẩy việc làm cho sinh viên tốt nghiệp ưu tú, nhà trường đã đặc biệt mời hàng trăm doanh nghiệp tên tuổi tổ chức hội chợ việc làm quy mô lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [便于] (biànyú) - thuận tiện cho, tiện bề [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '便于' AND pinyin = 'biànyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '便于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'biànyú',
      meaning_vi = 'thuận tiện cho, tiện bề',
      example_hanzi = '请把生词按照首字母顺序排列，便于日后查找复习。',
      example_pinyin = 'Qǐng bǎ shēngcí ànzhào shǒuzìmǔ shùnxù páiliè, biànyú rìhòu cházhǎo fùxí.',
      example_vi = 'Xin hãy xếp từ mới theo thứ tự chữ cái đầu tiên để thuận tiện cho việc tra cứu ôn tập sau này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把生词按照首字母顺序排列，便于日后查找复习。', 'Qǐng bǎ shēngcí ànzhào shǒuzìmǔ shùnxù páiliè, biànyú rìhòu cházhǎo fùxí.', 'Xin hãy xếp từ mới theo thứ tự chữ cái đầu tiên để thuận tiện cho việc tra cứu ôn tập sau này.', 'basic', 1),
        (v_id, '城市规划应当优先完善公共交通网络，以便于广大居民绿色低碳出行。', 'Chéngshì guīhuà yīngdāng yōuxiān wánshàn gōnggòng jiāotōng wǎngluò, yǐ biànyú guǎngdà jūmín lǜsè dītàn chūxíng.', 'Quy hoạch đô thị nên ưu tiên hoàn thiện mạng lưới giao thông công cộng nhằm tạo thuận tiện cho người dân đi lại xanh và giảm phát thải.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [标准] (biāozhǔn) - tiêu chuẩn, chuẩn mực; chuẩn [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '标准' AND pinyin = 'biāozhǔn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '标准'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'biāozhǔn',
      meaning_vi = 'tiêu chuẩn, chuẩn mực; chuẩn',
      example_hanzi = '他的普通话发音非常标准，听起来就像播音员一样。',
      example_pinyin = 'Tā de pǔtōnghuà fāyīn fēicháng biāozhǔn, tīng qǐlái jiù xiàng bōyīnyuán yíyàng.',
      example_vi = 'Phát âm tiếng phổ thông của anh ấy rất chuẩn xác, nghe hệt như phát thanh viên vậy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的普通话发音非常标准，听起来就像播音员一样。', 'Tā de pǔtōnghuà fāyīn fēicháng biāozhǔn, tīng qǐlái jiù xiàng bōyīnyuán yíyàng.', 'Phát âm tiếng phổ thông của anh ấy rất chuẩn xác, nghe hệt như phát thanh viên vậy.', 'basic', 1),
        (v_id, '严格的质量检验标准是企业赢得海内外客户长期信赖的核心保障。', 'Yángé de zhìliàng jiǎnyàn biāozhǔn shì qǐyè yíngdé hǎinèiwài kèhù chángqī xìnlài de héxīn bǎozhàng.', 'Tiêu chuẩn kiểm định chất lượng nghiêm ngặt là bảo đảm cốt lõi giúp doanh nghiệp chiếm trọn niềm tin lâu dài của khách hàng trong và ngoài nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [表] (biǎo) - đồng hồ; biểu mẫu, bảng kê [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '表' AND pinyin = 'biǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '表'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'biǎo',
      meaning_vi = 'đồng hồ; biểu mẫu, bảng kê',
      example_hanzi = '我的手表慢了五分钟，需要校对一下时间。',
      example_pinyin = 'Wǒ de shǒubiǎo màn le wǔ fēnzhōng, xūyào jiàoduì yíxià shíjiān.',
      example_vi = 'Đồng hồ đeo tay của tôi bị chậm năm phút, cần phải chỉnh lại giờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我的手表慢了五分钟，需要校对一下时间。', 'Wǒ de shǒubiǎo màn le wǔ fēnzhōng, xūyào jiàoduì yíxià shíjiān.', 'Đồng hồ đeo tay của tôi bị chậm năm phút, cần phải chỉnh lại giờ.', 'basic', 1),
        (v_id, '请新入职的员工仔细核对个人信息登记表中的各项内容。', 'Qǐng xīn rùzhí de yuángōng zǐxì héduì gèrén xìnxī dēngjì biǎo zhōng de gè xiàng nèiróng.', 'Xin các nhân viên mới vào làm kiểm tra kỹ các mục nội dung trong biểu mẫu đăng ký thông tin cá nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [表格] (biǎogé) - bảng biểu, mẫu đơn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '表格' AND pinyin = 'biǎogé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '表格'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'biǎogé',
      meaning_vi = 'bảng biểu, mẫu đơn',
      example_hanzi = '请在十分钟内把这张报名表格填写完整。',
      example_pinyin = 'Qǐng zài shí fēnzhōng nèi bǎ zhè zhāng bàomíng biǎogé tiánxiě wánzhěng.',
      example_vi = 'Xin hãy điền hoàn chỉnh mẫu đơn đăng ký này trong vòng mười phút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请在十分钟内把这张报名表格填写完整。', 'Qǐng zài shí fēnzhōng nèi bǎ zhè zhāng bàomíng biǎogé tiánxiě wánzhěng.', 'Xin hãy điền hoàn chỉnh mẫu đơn đăng ký này trong vòng mười phút.', 'basic', 1),
        (v_id, '财务人员使用电子表格软件对全年的收支数据进行了系统的汇总与分析。', 'Cáiwù rényuán shǐyòng diànzǐ biǎogé ruǎnjiàn duì quán nián de shōuzhī shùjù jìnxíng le xìtǒng de huìzǒng yǔ fēnxī.', 'Nhân viên kế toán đã dùng phần mềm bảng tính điện tử để tổng hợp và phân tích có hệ thống số liệu thu chi cả năm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [表示] (biǎoshì) - bày tỏ, biểu thị, cho thấy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '表示' AND pinyin = 'biǎoshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '表示'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'biǎoshì',
      meaning_vi = 'bày tỏ, biểu thị, cho thấy',
      example_hanzi = '客人们微笑着点头，对主人的热情款待表示由衷的感谢。',
      example_pinyin = 'Kèrénmen wēixiào zhe diǎntóu, duì zhǔrén de rèqíng kuǎndài biǎoshì yóuzhōng de gǎnxiè.',
      example_vi = 'Những vị khách mỉm cười gật đầu, bày tỏ lòng cảm ơn chân thành trước sự tiếp đãi nhiệt tình của chủ nhà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '客人们微笑着点头，对主人的热情款待表示由衷的感谢。', 'Kèrénmen wēixiào zhe diǎntóu, duì zhǔrén de rèqíng kuǎndài biǎoshì yóuzhōng de gǎnxiè.', 'Những vị khách mỉm cười gật đầu, bày tỏ lòng cảm ơn chân thành trước sự tiếp đãi nhiệt tình của chủ nhà.', 'basic', 1),
        (v_id, '专家在会上表示，只有坚持科技自主创新，才能在国际竞争中立于不败之地。', 'Zhuānjiā zài huì shang biǎoshì, zhǐyào jiānchí kējì zìzhǔ chuàngxīn, cái néng zài guójì jìngzhēng zhōng lìyú-búbàizhīdì.', 'Chuyên gia phát biểu tại hội nghị cho biết, chỉ khi kiên trì đổi mới công nghệ tự chủ mới có thể đứng vững trong cạnh tranh quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [表现] (biǎoxiàn) - thể hiện, biểu hiện [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '表现' AND pinyin = 'biǎoxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '表现'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'biǎoxiàn',
      meaning_vi = 'thể hiện, biểu hiện',
      example_hanzi = '他在这学期的几次中文测试中都表现得十分优异。',
      example_pinyin = 'Tā zài zhè xuéqī de jǐ cì Zhōngwén cèshì zhōng dōu biǎoxiàn de shífēn yōuyì.',
      example_vi = 'Cậu ấy trong các đợt kiểm tra tiếng Trung học kỳ này đều thể hiện vô cùng xuất sắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在这学期的几次中文测试中都表现得十分优异。', 'Tā zài zhè xuéqī de jǐ cì Zhōngwén cèshì zhōng dōu biǎoxiàn de shífēn yōuyì.', 'Cậu ấy trong các đợt kiểm tra tiếng Trung học kỳ này đều thể hiện vô cùng xuất sắc.', 'basic', 1),
        (v_id, '面对突如其来的紧急状况，机组人员临危不乱，表现出了极高的专业素养。', 'Miànduì tūrúqílái de jǐnjí zhuàngkuàng, jīzǔ rényuán línwēi-búluàn, biǎoxiàn chū le jí gāo de zhuānyè sùyǎng.', 'Trước tình huống khẩn cấp bất ngờ xảy ra, phi hành đoàn bình tĩnh ứng phó, thể hiện tố chất chuyên môn cực kỳ cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [表扬] (biǎoyáng) - khen ngợi, biểu dương [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '表扬' AND pinyin = 'biǎoyáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '表扬'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'biǎoyáng',
      meaning_vi = 'khen ngợi, biểu dương',
      example_hanzi = '老师在全班同学面前表扬了他助人为乐的精神。',
      example_pinyin = 'Lǎoshī zài quán bān tóngxué miànqián biǎoyáng le tā zhùrén-wéilè de jīngshén.',
      example_vi = 'Thầy giáo biểu dương tinh thần sẵn lòng giúp đỡ người khác của cậu ấy trước toàn thể lớp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师在全班同学面前表扬了他助人为乐的精神。', 'Lǎoshī zài quán bān tóngxué miànqián biǎoyáng le tā zhùrén-wéilè de jīngshén.', 'Thầy giáo biểu dương tinh thần sẵn lòng giúp đỡ người khác của cậu ấy trước toàn thể lớp.', 'basic', 1),
        (v_id, '受到领导的公开表扬之后，小李的工作积极性和责任感有了进一步提升。', 'Shòudào lǐngdǎo de gōngkāi biǎoyáng zhīhòu, Xiǎo Lǐ de gōngzuò jījíxìng hé zérèngǎn yǒu le jìn yí bù tíshēng.', 'Sau khi được lãnh đạo công khai khen ngợi, tính chủ động tích cực và tinh thần trách nhiệm trong công việc của Tiểu Lý lại càng được nâng cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [饼干] (bǐnggān) - bánh quy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '饼干' AND pinyin = 'bǐnggān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '饼干'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bǐnggān',
      meaning_vi = 'bánh quy',
      example_hanzi = '下午茶时间，吃几块酥脆的饼干配上一杯红茶非常惬意。',
      example_pinyin = 'Xiàwǔchá shíjiān, chī jǐ kuài sūcuì de bǐnggān pèi shàng yì bēi hóngchá fēicháng qièyì.',
      example_vi = 'Vào giờ trà chiều, ăn vài chiếc bánh quy giòn tan kèm một ly hồng trà thật khoan khoái dễ chịu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下午茶时间，吃几块酥脆的饼干配上一杯红茶非常惬意。', 'Xiàwǔchá shíjiān, chī jǐ kuài sūcuì de bǐnggān pèi shàng yì bēi hóngchá fēicháng qièyì.', 'Vào giờ trà chiều, ăn vài chiếc bánh quy giòn tan kèm một ly hồng trà thật khoan khoái dễ chịu.', 'basic', 1),
        (v_id, '妈妈亲手烘焙的巧克力夹心饼干香气扑鼻，深受邻里小朋友们的喜爱。', 'Māma qīnshǒu hōngbèi de qiǎokèlì jiāxīn bǐnggān xiāngqì pūbí, shēn shòu línlǐ xiǎopéngyoumen de xǐ’ài.', 'Mẻ bánh quy kẹp sô-cô-la do mẹ tự tay nướng thơm lừng nức mũi, được các em nhỏ hàng xóm rất yêu thích.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [并] (bìng) - đồng thời; thực sự, hoàn toàn (nhấn mạnh phủ định) [Phó từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '并' AND pinyin = 'bìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '并'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Liên từ',
      pinyin = 'bìng',
      meaning_vi = 'đồng thời; thực sự, hoàn toàn (nhấn mạnh phủ định)',
      example_hanzi = '这件事情并没有想象中那么复杂，放平心态就好。',
      example_pinyin = 'Zhè jiàn shìqing bìng méiyǒu xiǎngxiàng zhōng nàme fùzá, fàng píng xīntài jiù hǎo.',
      example_vi = 'Chuyện này thực sự không phức tạp như tưởng tượng, cứ giữ tâm thái bình thản là được.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这件事情并没有想象中那么复杂，放平心态就好。', 'Zhè jiàn shìqing bìng méiyǒu xiǎngxiàng zhōng nàme fùzá, fàng píng xīntài jiù hǎo.', 'Chuyện này thực sự không phức tạp như tưởng tượng, cứ giữ tâm thái bình thản là được.', 'basic', 1),
        (v_id, '大会认真总结了过去一年的辉煌成就，并明确制定了下一阶段的战略发展目标。', 'Dàhuì rènzhēn zǒngjié le guòqù yì nián de huīhuáng chéngjiù, bìng míngquè zhìdìng le xià yí jiēduàn de zhànlüè fāzhǎn mùbiāo.', 'Đại hội đã nghiêm túc tổng kết những thành tựu rực rỡ năm vừa qua, đồng thời xác lập rõ mục tiêu phát triển chiến lược cho giai đoạn kế tiếp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [并且] (bìngqiě) - đồng thời, hơn nữa [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '并且' AND pinyin = 'bìngqiě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '并且'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'bìngqiě',
      meaning_vi = 'đồng thời, hơn nữa',
      example_hanzi = '她不仅工作能力强，并且对待同事总是热情和善。',
      example_pinyin = 'Tā bùjǐn gōngzuò nénglì qiáng, bìngqiě duìdài tóngshì zǒngshì rèqíng héshàn.',
      example_vi = 'Cô ấy không chỉ năng lực công việc giỏi giang, mà hơn nữa đối xử với đồng nghiệp luôn nhiệt tình hòa nhã.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '她不仅工作能力强，并且对待同事总是热情和善。', 'Tā bùjǐn gōngzuò nénglì qiáng, bìngqiě duìdài tóngshì zǒngshì rèqíng héshàn.', 'Cô ấy không chỉ năng lực công việc giỏi giang, mà hơn nữa đối xử với đồng nghiệp luôn nhiệt tình hòa nhã.', 'basic', 1),
        (v_id, '项目团队在规定时间内圆满完成了研发任务，并且各项性能指标均超出了原定预期。', 'Xiàngmù tuánduì zài guīdìng shíjiān nèi yuánmǎn wánchéng le yánfā rènwu, bìngqiě gè xiàng xìngnéng zhǐbiāo jūn chāochū le yuándìng yùqī.', 'Nhóm dự án đã hoàn thành xuất sắc nhiệm vụ nghiên cứu phát triển trong thời gian quy định, đồng thời mọi chỉ số tính năng đều vượt mức kỳ vọng ban đầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [播放] (bōfàng) - phát sóng, mở (nhạc, video) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '播放' AND pinyin = 'bōfàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '播放'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bōfàng',
      meaning_vi = 'phát sóng, mở (nhạc, video)',
      example_hanzi = '广播电台正在播放一首优美舒缓的古典轻音乐。',
      example_pinyin = 'Guǎngbō diàntái zhèngzài bōfàng yì shǒu yōuměi shūhuǎn de gǔdiǎn qīngyīnyuè.',
      example_vi = 'Đài phát thanh đang phát một bản nhạc nhẹ cổ điển êm đềm du dương.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '广播电台正在播放一首优美舒缓的古典轻音乐。', 'Guǎngbō diàntái zhèngzài bōfàng yì shǒu yōuměi shūhuǎn de gǔdiǎn qīngyīnyuè.', 'Đài phát thanh đang phát một bản nhạc nhẹ cổ điển êm đềm du dương.', 'basic', 1),
        (v_id, '在历史课开始前，老师利用多媒体设备播放了一部生动精彩的纪录片。', 'Zài lìshǐ kè kāishǐ qián, lǎoshī lìyòng duōméitǐ shèbèi bōfàng le yí bù shēngdòng jīngcǎi de jìlùpiàn.', 'Trước khi tiết học lịch sử bắt đầu, thầy giáo dùng thiết bị đa phương tiện chiếu một bộ phim tài liệu sinh động hấp dẫn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [博士] (bóshì) - tiến sĩ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '博士' AND pinyin = 'bóshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '博士'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bóshì',
      meaning_vi = 'tiến sĩ',
      example_hanzi = '李博士在人工智能领域发表了许多具有国际影响力的高水平论文。',
      example_pinyin = 'Lǐ bóshì zài réngōng zhìnéng lǐngyù fābiǎo le xǔduō jùyǒu guójì yǐngxiǎnglì de gāo shuǐpíng lùnwén.',
      example_vi = 'Tiến sĩ Lý đã công bố nhiều bài báo khoa học chất lượng cao có tầm ảnh hưởng quốc tế trong lĩnh vực trí tuệ nhân tạo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '李博士在人工智能领域发表了许多具有国际影响力的高水平论文。', 'Lǐ bóshì zài réngōng zhìnéng lǐngyù fābiǎo le xǔduō jùyǒu guójì yǐngxiǎnglì de gāo shuǐpíng lùnwén.', 'Tiến sĩ Lý đã công bố nhiều bài báo khoa học chất lượng cao có tầm ảnh hưởng quốc tế trong lĩnh vực trí tuệ nhân tạo.', 'basic', 1),
        (v_id, '攻读博士学位不仅需要扎实深厚的学术功底，更需要长年累月潜心钻研的毅力。', 'Gōngdú bóshì xuéwèi bùjǐn xūyào zhāshi shēnhòu de xuéshù gōngdǐ, gèng xūyào chángnián-lěiyuè qiánxīn zuānyán de yìlì.', 'Học lấy bằng tiến sĩ không chỉ đòi hỏi nền tảng học thuật vững chắc sâu dày, mà càng cần nghị lực miệt mài nghiên cứu tháng ngày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不必] (búbì) - không cần thiết, không cần [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不必' AND pinyin = 'búbì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不必'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'búbì',
      meaning_vi = 'không cần thiết, không cần',
      example_hanzi = '这只是一件微不足道的小事，你完全不必放在心上。',
      example_pinyin = 'Zhè zhǐ shì yí jiàn wēibùzúdào de xiǎoshì, nǐ wánquán búbì fàng zài xīn shang.',
      example_vi = 'Đây chỉ là chuyện nhỏ không đáng bận tâm, bạn hoàn toàn không cần phải để bụng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这只是一件微不足道的小事，你完全不必放在心上。', 'Zhè zhǐ shì yí jiàn wēibùzúdào de xiǎoshì, nǐ wánquán búbì fàng zài xīn shang.', 'Đây chỉ là chuyện nhỏ không đáng bận tâm, bạn hoàn toàn không cần phải để bụng.', 'basic', 1),
        (v_id, '大家既然已经是多年的老朋友了，见面时就不必再如此拘谨客气。', 'Dàjiā jìrán yǐjīng shì duō nián de lǎo péngyou le, jiànmiàn shí jiù búbì zài rúcǐ jūjǐn kèqi.', 'Mọi người đã là bạn thân nhiều năm rồi, khi gặp mặt không cần phải câu nệ khách sáo đến thế nữa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不便] (búbiàn) - bất tiện, không thuận tiện [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不便' AND pinyin = 'búbiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不便'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'búbiàn',
      meaning_vi = 'bất tiện, không thuận tiện',
      example_hanzi = '道路施工期间给周边居民出行带来了诸多不便，敬请谅解。',
      example_pinyin = 'Dàolù shīgōng qījiān gěi zhōubiān jūmín chūxíng dài lái le zhūduō búbiàn, jìng qǐng liàngjiě.',
      example_vi = 'Trong thời gian thi công đường xá mang lại nhiều bất tiện cho việc đi lại của cư dân xung quanh, kính mong thông cảm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '道路施工期间给周边居民出行带来了诸多不便，敬请谅解。', 'Dàolù shīgōng qījiān gěi zhōubiān jūmín chūxíng dài lái le zhūduō búbiàn, jìng qǐng liàngjiě.', 'Trong thời gian thi công đường xá mang lại nhiều bất tiện cho việc đi lại của cư dân xung quanh, kính mong thông cảm.', 'basic', 1),
        (v_id, '老奶奶腿脚不便，邻居们经常主动帮她采购日常米面蔬菜。', 'Lǎonǎinai tuǐjiǎo búbiàn, línjūmen jīngcháng zhǔdòng bāng tā cǎigòu rìcháng mǐ-miàn shūcài.', 'Bà cụ chân cẳng đi lại bất tiện, hàng xóm thường chủ động giúp bà mua sắm gạo mì rau củ hàng ngày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不断] (búduàn) - không ngừng, liên tục [Phó từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不断' AND pinyin = 'búduàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不断'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Động từ',
      pinyin = 'búduàn',
      meaning_vi = 'không ngừng, liên tục',
      example_hanzi = '社会在不断发展进步，我们每个人也必须终身学习。',
      example_pinyin = 'Shèhuì zài búduàn fāzhǎn jìnbù, wǒmen měi gè rén yě bìxū zhōngshēn xuéxí.',
      example_vi = 'Xã hội đang không ngừng phát triển tiến bộ, mỗi chúng ta cũng phải học tập suốt đời.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '社会在不断发展进步，我们每个人也必须终身学习。', 'Shèhuì zài búduàn fāzhǎn jìnbù, wǒmen měi gè rén yě bìxū zhōngshēn xuéxí.', 'Xã hội đang không ngừng phát triển tiến bộ, mỗi chúng ta cũng phải học tập suốt đời.', 'basic', 1),
        (v_id, '经过多年不断的探索与技术改进，我国新能源汽车产业取得了举世瞩目的成就。', 'Jīngguò duō nián búduàn de tànsuǒ yǔ jìshù gǎijìn, wǒguó xīnnéngyuán qìchē chǎnyè qǔdé le jǔshì-zhǔmù de chéngjiù.', 'Trải qua nhiều năm không ngừng tìm tòi và cải tiến kỹ thuật, ngành công nghiệp xe năng lượng mới của nước ta đã đạt được những thành tựu khiến cả thế giới dõi theo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不够] (búgòu) - không đủ, chưa đủ [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不够' AND pinyin = 'búgòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不够'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Phó từ',
      pinyin = 'búgòu',
      meaning_vi = 'không đủ, chưa đủ',
      example_hanzi = '他今天的准备工作显然做得还不够充分。',
      example_pinyin = 'Tā jīntiān de zhǔnbèi gōngzuò xiǎnrán zuò de hái búgòu chōngfèn.',
      example_vi = 'Công tác chuẩn bị hôm nay của anh ấy rõ ràng làm vẫn chưa đủ chu tất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他今天的准备工作显然做得还不够充分。', 'Tā jīntiān de zhǔnbèi gōngzuò xiǎnrán zuò de hái búgòu chōngfèn.', 'Công tác chuẩn bị hôm nay của anh ấy rõ ràng làm vẫn chưa đủ chu tất.', 'basic', 1),
        (v_id, '如果仅仅掌握书本上的理论知识而缺乏一线实操经验，那是远远不够的。', 'Rúguǒ jǐnjǐn zhǎngwò shūběn shang de lǐlùn zhīshi ér quēfá yīxiàn shícāo jīngyàn, nà shì yuǎnyuǎn búgòu de.', 'Nếu chỉ nắm vững kiến thức lý thuyết trong sách vở mà thiếu kinh nghiệm thao tác thực tế tuyến đầu thì còn xa mới đủ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不过] (búguò) - nhưng, tuy nhiên; chẳng qua [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不过' AND pinyin = 'búguò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不过'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'búguò',
      meaning_vi = 'nhưng, tuy nhiên; chẳng qua',
      example_hanzi = '这件衣服版型很合身，不过价格稍微有点儿贵。',
      example_pinyin = 'Zhè jiàn yīfu bǎnxíng hěn héshēn, búguò jiàgé shāowēi yǒudiǎnr guì.',
      example_vi = 'Bộ quần áo này phom dáng rất vừa vặn, có điều giá cả hơi đắt một chút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这件衣服版型很合身，不过价格稍微有点儿贵。', 'Zhè jiàn yīfu bǎnxíng hěn héshēn, búguò jiàgé shāowēi yǒudiǎnr guì.', 'Bộ quần áo này phom dáng rất vừa vặn, có điều giá cả hơi đắt một chút.', 'basic', 1),
        (v_id, '虽然前进的道路上充满了艰难险阻，不过大家对达成最终目标依然充满信心。', 'Suīrán qiánjìn de dàolù shang chōngmǎn le jiānnán-xiǎnzǔ, búguò dàjiā duì dáchéng zuìzhōng mùbiāo yīrán chōngmǎn xìnxīn.', 'Tuy con đường phía trước tràn ngập gian nan trắc trở, thế nhưng mọi người vẫn tràn đầy niềm tin vào việc đạt được mục tiêu sau cùng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不论] (búlùn) - bất kể, cho dù [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不论' AND pinyin = 'búlùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不论'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'búlùn',
      meaning_vi = 'bất kể, cho dù',
      example_hanzi = '不论严寒酷暑，环卫工人们每天天不亮就走上街头清扫卫生。',
      example_pinyin = 'Búlùn yánhán kùshǔ, huánwèi gōngrénmen měitiān tiān bú liàng jiù zǒu shàng jiētóu qīngsǎo wèishēng.',
      example_vi = 'Bất kể đông lạnh hay hè gắt, những công nhân vệ sinh môi trường mỗi ngày trời chưa sáng đã ra đường quét dọn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '不论严寒酷暑，环卫工人们每天天不亮就走上街头清扫卫生。', 'Búlùn yánhán kùshǔ, huánwèi gōngrénmen měitiān tiān bú liàng jiù zǒu shàng jiētóu qīngsǎo wèishēng.', 'Bất kể đông lạnh hay hè gắt, những công nhân vệ sinh môi trường mỗi ngày trời chưa sáng đã ra đường quét dọn.', 'basic', 1),
        (v_id, '不论遇到多么复杂的棘手难题，他总能冷静理智地分析并找到妥善的破解方法。', 'Búlùn yù dào duōme fùzá de jíshǒu nántí, tā zǒng néng lěngjìng lǐzhì de fēnxī bìng zhǎodào tuǒshàn de pòjiě fāngfǎ.', 'Cho dù gặp bài toán hóc búa phức tạp đến đâu, anh ấy luôn có thể bình tĩnh sáng suốt phân tích và tìm ra phương án tháo gỡ ổn thỏa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [步] (bù) - bước, bước chân, bước đi [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '步' AND pinyin = 'bù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '步'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'bù',
      meaning_vi = 'bước, bước chân, bước đi',
      example_hanzi = '千里之行，始于足下，迈出第一步是最关键的。',
      example_pinyin = 'Qiān lǐ zhī xíng, shǐ yú zú xià, mài chū dì-yī bù shì zuì guānjiàn de.',
      example_vi = 'Hành trình ngàn dặm khởi đầu từ một bước chân, bước ra bước đầu tiên là then chốt nhất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '千里之行，始于足下，迈出第一步是最关键的。', 'Qiān lǐ zhī xíng, shǐ yú zú xià, mài chū dì-yī bù shì zuì guānjiàn de.', 'Hành trình ngàn dặm khởi đầu từ một bước chân, bước ra bước đầu tiên là then chốt nhất.', 'basic', 1),
        (v_id, '医生建议老年人每天饭后散步五千步，有助于强身健体促进消化。', 'Yīshēng jiànyì lǎoniánrén měitiān fànhòu sànbù wǔqiān bù, yǒuzhùyú qiángshēn-jiàntǐ cùjìn xiāohuà.', 'Bác sĩ khuyên người cao tuổi mỗi ngày sau bữa ăn đi bộ năm nghìn bước, rất có ích cho việc rèn luyện thân thể và thúc đẩy tiêu hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [部] (bù) - bộ phận; bộ (lượng từ phim ảnh, tiểu thuyết, xe cộ, máy móc) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '部' AND pinyin = 'bù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'bù',
      meaning_vi = 'bộ phận; bộ (lượng từ phim ảnh, tiểu thuyết, xe cộ, máy móc)',
      example_hanzi = '他今年主演的那部科幻电影在全国各大影院反响热烈。',
      example_pinyin = 'Tā jīnnián zhǔyǎn de nà bù kēhuàn diànyǐng zài quán guó gè dà yǐngyuàn fǎnxiǎng rèliè.',
      example_vi = 'Bộ phim khoa học viễn tưởng do anh ấy đóng chính năm nay đã tạo được tiếng vang lớn tại các rạp chiếu phim trên cả nước.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他今年主演的那部科幻电影在全国各大影院反响热烈。', 'Tā jīnnián zhǔyǎn de nà bù kēhuàn diànyǐng zài quán guó gè dà yǐngyuàn fǎnxiǎng rèliè.', 'Bộ phim khoa học viễn tưởng do anh ấy đóng chính năm nay đã tạo được tiếng vang lớn tại các rạp chiếu phim trên cả nước.', 'basic', 1),
        (v_id, '该学术著作共分上中下三部，系统梳理了汉字数千年的演变历史。', 'Gāi xuéshù zhùzuò gòng fēn shàng zhōng xià sān bù, xìtǒng shūlǐ le Hànzì shù qiān nián de yǎnbiàn lìshǐ.', 'Công trình học thuật này chia làm ba bộ thượng trung hạ, tổng kết có hệ thống lịch sử biến đổi hàng ngàn năm của chữ Hán.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不得不] (bùdébù) - buộc phải, không thể không [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不得不' AND pinyin = 'bùdébù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不得不'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'bùdébù',
      meaning_vi = 'buộc phải, không thể không',
      example_hanzi = '因为突发强台风，学校不得不暂时停课一天。',
      example_pinyin = 'Yīnwèi tūfā qiáng táifēng, xuéxiào bùdébù zànshí tíngkè yì tiān.',
      example_vi = 'Vì bão lớn đổ bộ bất ngờ, nhà trường buộc phải tạm thời cho nghỉ học một ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '因为突发强台风，学校不得不暂时停课一天。', 'Yīnwèi tūfā qiáng táifēng, xuéxiào bùdébù zànshí tíngkè yì tiān.', 'Vì bão lớn đổ bộ bất ngờ, nhà trường buộc phải tạm thời cho nghỉ học một ngày.', 'basic', 1),
        (v_id, '面对不可反驳的确凿事实与详实证据，对方不得不承认了自身的重大疏漏。', 'Miànduì bù kě fǎnbó de quèzáo shìshí yǔ xiángshí zhèngjù, duìfāng bùdébù chéngrèn le zìshēn de zhòngdà shūlòu.', 'Trước những sự thật chuẩn xác và bằng chứng chi tiết không thể chối cãi, đối phương buộc phải thừa nhận sai sót nghiêm trọng của chính mình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [部分] (bùfen) - bộ phận, phần [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '部分' AND pinyin = 'bùfen'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '部分'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bùfen',
      meaning_vi = 'bộ phận, phần',
      example_hanzi = '今天课堂上讲的第一部分内容大家都听懂了吗？',
      example_pinyin = 'Jīntiān kètáng shang jiǎng de dì-yī bùfen nèiróng dàjiā dōu tīng dǒng le ma?',
      example_vi = 'Nội dung phần thứ nhất giảng trên lớp hôm nay mọi người đều đã hiểu hết chưa?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天课堂上讲的第一部分内容大家都听懂了吗？', 'Jīntiān kètáng shang jiǎng de dì-yī bùfen nèiróng dàjiā dōu tīng dǒng le ma?', 'Nội dung phần thứ nhất giảng trên lớp hôm nay mọi người đều đã hiểu hết chưa?', 'basic', 1),
        (v_id, '阅读理解是HSK四级考试中占据分值很大的一部分核心题型。', 'Yuèdú lǐjiě shì HSK sì jí kǎoshì zhōng zhànjù fēnzhí hěn dà de yí bùfen héxīn tíxíng.', 'Đọc hiểu là một dạng bài trọng tâm chiếm tỷ trọng điểm số rất lớn trong kỳ thi HSK 4.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不管] (bùguǎn) - bất kể, dù cho [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不管' AND pinyin = 'bùguǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不管'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'bùguǎn',
      meaning_vi = 'bất kể, dù cho',
      example_hanzi = '不管明天天气好坏，我们的公益植树活动都会照常举行。',
      example_pinyin = 'Bùguǎn míngtiān tiānqì hǎo huài, wǒmen de gōngyì zhíshù huódòng dōu huì zhàocháng jǔxíng.',
      example_vi = 'Bất kể thời tiết ngày mai đẹp hay xấu, hoạt động trồng cây công ích của chúng tôi vẫn sẽ diễn ra như thường lệ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '不管明天天气好坏，我们的公益植树活动都会照常举行。', 'Bùguǎn míngtiān tiānqì hǎo huài, wǒmen de gōngyì zhíshù huódòng dōu huì zhàocháng jǔxíng.', 'Bất kể thời tiết ngày mai đẹp hay xấu, hoạt động trồng cây công ích của chúng tôi vẫn sẽ diễn ra như thường lệ.', 'basic', 1),
        (v_id, '不管遇到多大的挫折与委屈，回到温馨的家中总能感受到家人给予的无穷力量。', 'Bùguǎn yù dào duō dà de cuòzhé yǔ wěiqu, huí dào wēnxīn de jiā zhōng zǒng néng gǎnshòu dào jiārén jǐyǔ de wúqióng lìliang.', 'Dù gặp phải bao trắc trở hay ấm ức ngoài đời, khi trở về mái ấm gia đình luôn cảm nhận được nguồn sức mạnh vô bờ bến do người thân trao gửi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不光] (bùguāng) - không chỉ, không riêng [Phó từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不光' AND pinyin = 'bùguāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不光'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Liên từ',
      pinyin = 'bùguāng',
      meaning_vi = 'không chỉ, không riêng',
      example_hanzi = '这道菜不光外观色泽诱人，味道也非常可口鲜美。',
      example_pinyin = 'Zhè dào cài bùguāng wàiguān sèzé yòurén, wèidào yě fēicháng kěkǒu xiānměi.',
      example_vi = 'Món ăn này không chỉ hình thức màu sắc bắt mắt, mà hương vị cũng rất thơm ngon ngon miệng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这道菜不光外观色泽诱人，味道也非常可口鲜美。', 'Zhè dào cài bùguāng wàiguān sèzé yòurén, wèidào yě fēicháng kěkǒu xiānměi.', 'Món ăn này không chỉ hình thức màu sắc bắt mắt, mà hương vị cũng rất thơm ngon ngon miệng.', 'basic', 1),
        (v_id, '学习中文不光能够开阔国际视野，更能为未来的职场竞争增添一份独特优势。', 'Xuéxí Zhōngwén bùguāng nénggòu kāikuò guójì shìyě, gèng néng wèi wèilái de zhíchǎng jìngzhēng zēngtiān yí fèn dútè yōushì.', 'Học tiếng Trung không chỉ giúp mở rộng tầm nhìn quốc tế, mà càng tạo thêm lợi thế độc đáo cho sự cạnh tranh nghề nghiệp trong tương lai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不仅] (bùjǐn) - không những, không chỉ [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不仅' AND pinyin = 'bùjǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不仅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'bùjǐn',
      meaning_vi = 'không những, không chỉ',
      example_hanzi = '他不仅汉语口语表达流利，而且汉字书写也十分优美规范。',
      example_pinyin = 'Tā bùjǐn Hànyǔ kǒuyǔ biǎodá liúlì, érqiě Hànzì shūxiě yě shífēn yōuměi guīfàn.',
      example_vi = 'Cậu ấy không những diễn đạt khẩu ngữ tiếng Trung lưu loát, mà chữ viết Hán tự cũng rất đẹp mắt chuẩn mực.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他不仅汉语口语表达流利，而且汉字书写也十分优美规范。', 'Tā bùjǐn Hànyǔ kǒuyǔ biǎodá liúlì, érqiě Hànzì shūxiě yě shífēn yōuměi guīfàn.', 'Cậu ấy không những diễn đạt khẩu ngữ tiếng Trung lưu loát, mà chữ viết Hán tự cũng rất đẹp mắt chuẩn mực.', 'basic', 1),
        (v_id, '多参与社会志愿服务活动，不仅能够帮助弱势群体，而且能极大丰富自己的人生阅历。', 'Duō cānyù shèhuì zhìyuàn fúwù huódòng, bùjǐn nénggòu bāngzhù ruòshì qúntǐ, érqiě néng jídà fēngfù zìjǐ de rénshēng yuèlì.', 'Tích cực tham gia các hoạt động tình nguyện xã hội không chỉ giúp đỡ được những nhóm người yếu thế mà còn làm phong phú đáng kể vốn sống đời người.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不满] (bùmǎn) - bất mãn, không hài lòng; chưa đầy [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不满' AND pinyin = 'bùmǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不满'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'bùmǎn',
      meaning_vi = 'bất mãn, không hài lòng; chưa đầy',
      example_hanzi = '顾客对商场个别服务员冷漠怠慢的态度表示强烈不满。',
      example_pinyin = 'Gùkè duì shāngchǎng gèbié fúwùyuán lěngmò dàimàn de tàidu biǎoshì qiángliè bùmǎn.',
      example_vi = 'Khách hàng bày tỏ sự bất mãn gay gắt trước thái độ thờ ơ chểnh mảng của cá biệt nhân viên phục vụ tại trung tâm thương mại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '顾客对商场个别服务员冷漠怠慢的态度表示强烈不满。', 'Gùkè duì shāngchǎng gèbié fúwùyuán lěngmò dàimàn de tàidu biǎoshì qiángliè bùmǎn.', 'Khách hàng bày tỏ sự bất mãn gay gắt trước thái độ thờ ơ chểnh mảng của cá biệt nhân viên phục vụ tại trung tâm thương mại.', 'basic', 1),
        (v_id, '面对员工提出的合理意见与不满情绪，管理层应当主动倾听并积极改进。', 'Miànduì yuángōng tíchū de hélǐ yìjiàn yǔ bùmǎn qíngxù, guǎnlǐcéng yīngdāng zhǔdòng qīngtīng bìng jījí gǎijìn.', 'Trước những ý kiến hợp lý và cảm xúc bất mãn của nhân viên, ban quản lý nên chủ động lắng nghe và tích cực cải thiện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [部门] (bùmén) - phòng ban, bộ phận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '部门' AND pinyin = 'bùmén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '部门'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bùmén',
      meaning_vi = 'phòng ban, bộ phận',
      example_hanzi = '他是我们公司市场营销部门的核心骨干成员。',
      example_pinyin = 'Tā shì wǒmen gōngsī shìchǎng yíngxiāo bùmén de héxīn gǔgàn chéngyuán.',
      example_vi = 'Anh ấy là thành viên nòng cốt hạt nhân của bộ phận tiếp thị thị trường công ty chúng tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他是我们公司市场营销部门的核心骨干成员。', 'Tā shì wǒmen gōngsī shìchǎng yíngxiāo bùmén de héxīn gǔgàn chéngyuán.', 'Anh ấy là thành viên nòng cốt hạt nhân của bộ phận tiếp thị thị trường công ty chúng tôi.', 'basic', 1),
        (v_id, '大型跨国企业内部各业务部门之间的高效协同与顺畅沟通至关重要。', 'Dàxíng kuàguó qǐyè nèibù gè yèwù bùmén zhījiān de gāoxiào xiétóng yǔ shùnchàng gōutōng zhìguān zhòngyào.', 'Sự phối hợp hiệu quả và thông suốt giữa các phòng ban nghiệp vụ bên trong doanh nghiệp đa quốc gia lớn có ý nghĩa vô cùng sống còn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [不如] (bùrú) - không bằng; chi bằng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '不如' AND pinyin = 'bùrú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不如'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bùrú',
      meaning_vi = 'không bằng; chi bằng',
      example_hanzi = '与其在家里无聊看手机，不如约上朋友去户外打球运动。',
      example_pinyin = 'Yǐqí zài jiālǐ wúliáo kàn shǒujī, bùrú yuē shàng péngyou qù hùwài dǎqiú yùndòng.',
      example_vi = 'Thay vì ở nhà lướt điện thoại chán ngắt, chi bằng rủ bạn bè ra ngoài trời chơi bóng vận động.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '与其在家里无聊看手机，不如约上朋友去户外打球运动。', 'Yǐqí zài jiālǐ wúliáo kàn shǒujī, bùrú yuē shàng péngyou qù hùwài dǎqiú yùndòng.', 'Thay vì ở nhà lướt điện thoại chán ngắt, chi bằng rủ bạn bè ra ngoài trời chơi bóng vận động.', 'basic', 1),
        (v_id, '俗话说“百闻不如一见”，只有亲自到实地考察调研，才能掌握最真实的一手数据。', 'Súhuà shuō “bǎi wén bùrú yí jiàn”, zhǐyào qīnzì dào shídì kǎochá diàoyán, cái néng zhǎngwò zuì zhēnshí de yìshǒu shùjù.', 'Tục ngữ có câu "Trăm nghe không bằng một thấy", chỉ khi đích thân đến tận nơi khảo sát nghiên cứu mới nắm bắt được số liệu thực tế sơ cấp chính xác nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [擦] (cā) - lau, chùi, cọ sát [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '擦' AND pinyin = 'cā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '擦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'cā',
      meaning_vi = 'lau, chùi, cọ sát',
      example_hanzi = '下课后，值日生认真地把黑板上的粉笔字擦得干干净净。',
      example_pinyin = 'Xiàkè hòu, zhírìshēng rènzhēn de bǎ hēibǎn shang de fěnbǐ zì cā de gāngānjìngjìng.',
      example_vi = 'Sau giờ học, học sinh trực nhật cẩn thận lau sạch bóng những nét phấn trên bảng đen.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下课后，值日生认真地把黑板上的粉笔字擦得干干净净。', 'Xiàkè hòu, zhírìshēng rènzhēn de bǎ hēibǎn shang de fěnbǐ zì cā de gāngānjìngjìng.', 'Sau giờ học, học sinh trực nhật cẩn thận lau sạch bóng những nét phấn trên bảng đen.', 'basic', 1),
        (v_id, '运动出汗后记得及时用毛巾擦干汗水，以免吹风受凉引起感冒。', 'Yùndòng chūhàn hòu jìde jíshí yòng máojīn cā gān hànshuǐ, yǐmiǎn chuīfēng shòuliáng yǐnqǐ gǎnmào.', 'Sau khi vận động toát mồ hôi nhớ dùng khăn lau khô mồ hôi kịp thời, kẻo bị trúng gió nhiễm lạnh dẫn đến cảm cúm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [猜] (cāi) - đoán [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '猜' AND pinyin = 'cāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '猜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'cāi',
      meaning_vi = 'đoán',
      example_hanzi = '你猜猜看我身后藏着的神秘礼物到底是什么？',
      example_pinyin = 'Nǐ cāicai kàn wǒ shēnhòu cáng zhe de shénmì lǐwù dàodǐ shì shénme?',
      example_vi = 'Bạn đoán thử xem món quà bí mật giấu sau lưng tôi rốt cuộc là cái gì nào?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你猜猜看我身后藏着的神秘礼物到底是什么？', 'Nǐ cāicai kàn wǒ shēnhòu cáng zhe de shénmì lǐwù dàodǐ shì shénme?', 'Bạn đoán thử xem món quà bí mật giấu sau lưng tôi rốt cuộc là cái gì nào?', 'basic', 1),
        (v_id, '没有确凿的事实证据之前，请不要随意胡乱猜测他人的动机。', 'Méiyǒu quèzáo de shìshí zhèngjù zhīqián, qǐng bú yào suíyì húluàn cāicè tārén de dòngjī.', 'Trước khi chưa có chứng cứ thực tế xác thực, xin đừng tự tiện đoán mò bừa bãi động cơ của người khác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [材料] (cáiliào) - tài liệu; vật liệu, nguyên liệu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '材料' AND pinyin = 'cáiliào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '材料'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cáiliào',
      meaning_vi = 'tài liệu; vật liệu, nguyên liệu',
      example_hanzi = '办理签证前必须将所有申请材料准备齐全。',
      example_pinyin = 'Bànlǐ qiānzhèng qián bìxū jiāng suǒyǒu shēnqǐng cáiliào zhǔnbèi qíquán.',
      example_vi = 'Trước khi xin visa nhất thiết phải chuẩn bị đầy đủ toàn bộ hồ sơ tài liệu xin cấp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '办理签证前必须将所有申请材料准备齐全。', 'Bànlǐ qiānzhèng qián bìxū jiāng suǒyǒu shēnqǐng cáiliào zhǔnbèi qíquán.', 'Trước khi xin visa nhất thiết phải chuẩn bị đầy đủ toàn bộ hồ sơ tài liệu xin cấp.', 'basic', 1),
        (v_id, '这座新建的现代图书馆主体建筑广泛使用了绿色环保的新型建筑材料。', 'Zhè zuò xīnjiàn de xiàndài túshūguǎn zhǔtǐ jiànzhù guǎngfàn shǐyòng le lǜsè huánbǎo de xīnxíng jiànzhù cáiliào.', 'Công trình kiến trúc chính của thư viện hiện đại mới xây này sử dụng rộng rãi các loại vật liệu xây dựng mẫu mới thân thiện môi trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [参观] (cānguān) - tham quan [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '参观' AND pinyin = 'cānguān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '参观'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'cānguān',
      meaning_vi = 'tham quan',
      example_hanzi = '周末老师带领留学生们去故宫博物院参观展览。',
      example_pinyin = 'Zhōumò lǎoshī dàilǐng liúxuéshēngmen qù Gùgōng Bówùyuàn cānguān zhǎnlǎn.',
      example_vi = 'Cuối tuần thầy giáo dẫn các bạn du học sinh đi Bảo tàng Cố Cung tham quan triển lãm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末老师带领留学生们去故宫博物院参观展览。', 'Zhōumò lǎoshī dàilǐng liúxuéshēngmen qù Gùgōng Bówùyuàn cānguān zhǎnlǎn.', 'Cuối tuần thầy giáo dẫn các bạn du học sinh đi Bảo tàng Cố Cung tham quan triển lãm.', 'basic', 1),
        (v_id, '代表团一行先后深入参观了科技园区内的多家知名高新技术企业。', 'Dàibiǎotuán yì xíng xiānhòu shēnrù cānguān le kējì yuánqū nèi de duō jiā zhīmíng gāoxīn-jìshù qǐyè.', 'Đoàn đại biểu đã lần lượt đi sâu tham quan nhiều doanh nghiệp công nghệ cao tên tuổi bên trong khu công viên công nghệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [参赛] (cānsài) - tham gia thi đấu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '参赛' AND pinyin = 'cānsài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '参赛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'cānsài',
      meaning_vi = 'tham gia thi đấu',
      example_hanzi = '来自全国三十所高校的优秀辩手参加了此次辩论赛。',
      example_pinyin = 'Láizì quán guó sānshí suǒ gāoxiào de yōuxiù biànshǒu cānjiā le cǐ cì biànlùnsài.',
      example_vi = 'Các tranh biện viên ưu tú đến từ ba mươi trường đại học trên cả nước đã tham gia thi đấu tại giải tranh biện lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '来自全国三十所高校的优秀辩手参加了此次辩论赛。', 'Láizì quán guó sānshí suǒ gāoxiào de yōuxiù biànshǒu cānjiā le cǐ cì biànlùnsài.', 'Các tranh biện viên ưu tú đến từ ba mươi trường đại học trên cả nước đã tham gia thi đấu tại giải tranh biện lần này.', 'basic', 1),
        (v_id, '组委会在赛前为所有参赛选手详细解读了比赛的具体规则与安全注意事项。', 'Zǔwěihuì zài sài qián wèi suǒyǒu cānsài xuǎnshǒu xiángxì jiědú le bǐsài de jùtǐ guīzé yǔ ānquán zhùyì shìxiàng.', 'Ban tổ chức trước trận đấu đã giải thích cặn kẽ cho toàn thể tuyển thủ dự thi về luật thi đấu cụ thể và các điều cần lưu ý an toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [餐厅] (cāntīng) - nhà hàng, phòng ăn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '餐厅' AND pinyin = 'cāntīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '餐厅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cāntīng',
      meaning_vi = 'nhà hàng, phòng ăn',
      example_hanzi = '这家中餐厅做出的北京烤鸭味道极为地道正宗。',
      example_pinyin = 'Zhè jiā Zhōngcāntīng zuò chū de Běijīng kǎoyā wèidào jíwéi dìdao zhèngzōng.',
      example_vi = 'Món vịt quay Bắc Kinh do nhà hàng Trung Hoa này làm ra mang hương vị cực kỳ chuẩn vị chính tông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家中餐厅做出的北京烤鸭味道极为地道正宗。', 'Zhè jiā Zhōngcāntīng zuò chū de Běijīng kǎoyā wèidào jíwéi dìdao zhèngzōng.', 'Món vịt quay Bắc Kinh do nhà hàng Trung Hoa này làm ra mang hương vị cực kỳ chuẩn vị chính tông.', 'basic', 1),
        (v_id, '每逢节假日的就餐高峰期，市中心几家知名特色餐厅门口总是排着长长的等位队伍。', 'Měiféng jiéjiàrì de jiùcān gāofēngqī, shìzhōngxīn jǐ jiā zhīmíng tèsè cāntīng ménkǒu zǒngshì pái zhe chángcháng de děngwèi duìwǔ.', 'Mỗi dịp giờ ăn cao điểm ngày lễ tết, trước cửa vài nhà hàng đặc sản danh tiếng ở trung tâm thành phố lúc nào cũng xếp hàng dài đợi bàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [操场] (cāochǎng) - sân tập thể thao, sân trường [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '操场' AND pinyin = 'cāochǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '操场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cāochǎng',
      meaning_vi = 'sân tập thể thao, sân trường',
      example_hanzi = '每天下午放学后，很多同学都在操场上跑步踢球。',
      example_pinyin = 'Měitiān xiàwǔ fàngxué hòu, hěnduō tóngxué dōu zài cāochǎng shang pǎobù tīqiú.',
      example_vi = 'Mỗi buổi chiều sau khi tan học, rất nhiều bạn học đều ở trên sân thể thao chạy bộ đá bóng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天下午放学后，很多同学都在操场上跑步踢球。', 'Měitiān xiàwǔ fàngxué hòu, hěnduō tóngxué dōu zài cāochǎng shang pǎobù tīqiú.', 'Mỗi buổi chiều sau khi tan học, rất nhiều bạn học đều ở trên sân thể thao chạy bộ đá bóng.', 'basic', 1),
        (v_id, '学校新建的塑胶操场不仅平整舒适，而且大大降低了学生运动时摔倒受伤的风险。', 'Xuéxiào xīnjiàn de sùjiāo cāochǎng bùjǐn píngzhěng shūshì, érqiě dàdà jiàngdī le xuésheng yùndòng shí shuāidǎo shòushāng de fēngxiǎn.', 'Sân tập phủ nhựa tổng hợp mới xây của trường không chỉ bằng phẳng êm chân mà còn giảm thiểu đáng kể nguy cơ học sinh ngã bị thương khi vận động.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [厕所] (cèsuǒ) - nhà vệ sinh, toilet [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '厕所' AND pinyin = 'cèsuǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '厕所'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cèsuǒ',
      meaning_vi = 'nhà vệ sinh, toilet',
      example_hanzi = '请问商场二层的公共厕所在哪个方向？',
      example_pinyin = 'Qǐngwèn shāngchǎng èr céng de gōnggòng cèsuǒ zài nǎ gè fāngxiàng?',
      example_vi = 'Xin hỏi nhà vệ sinh công cộng ở tầng hai trung tâm thương mại nằm ở hướng nào vậy?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请问商场二层的公共厕所在哪个方向？', 'Qǐngwèn shāngchǎng èr céng de gōnggòng cèsuǒ zài nǎ gè fāngxiàng?', 'Xin hỏi nhà vệ sinh công cộng ở tầng hai trung tâm thương mại nằm ở hướng nào vậy?', 'basic', 1),
        (v_id, '高铁列车上的无障碍卫生间设施齐全，充分考虑了残障人士的使用需求。', 'Gāotiě lièchē shang de wúzhàng’ài wèishēngjiān shèshī qíquán, chōngfèn kǎolǜ le cánzhàng rénshì de shǐyòng xūqiú.', 'Nhà vệ sinh không rào cản trên tàu cao tốc tiện nghi đầy đủ, tính đến trọn vẹn nhu cầu sử dụng của người khuyết tật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [查看] (chákàn) - xem xét, kiểm tra [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '查看' AND pinyin = 'chákàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '查看'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chákàn',
      meaning_vi = 'xem xét, kiểm tra',
      example_hanzi = '医生正在仔细查看患者拍下的胸部X光片。',
      example_pinyin = 'Yīshēng zhèngzài zǐxì chákàn huànzhě pāi xià de xiōngbù X guāng piàn.',
      example_vi = 'Bác sĩ đang chăm chú xem xét tấm phim chụp X-quang lồng ngực của người bệnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '医生正在仔细查看患者拍下的胸部X光片。', 'Yīshēng zhèngzài zǐxì chákàn huànzhě pāi xià de xiōngbù X guāng piàn.', 'Bác sĩ đang chăm chú xem xét tấm phim chụp X-quang lồng ngực của người bệnh.', 'basic', 1),
        (v_id, '你可以随时登录手机银行应用程序，实时查看账户的每一笔收支明细。', 'Nǐ kěyǐ suíshí dēnglù shǒujī yínháng yìngyòng chéngxù, shíshí chákàn zhànghù de měi yì bǐ shōuzhī míngxì.', 'Bạn có thể đăng nhập ứng dụng ngân hàng di động mọi lúc để tra cứu thời gian thực từng giao dịch thu chi của tài khoản.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [茶叶] (cháyè) - lá trà, búp chè [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '茶叶' AND pinyin = 'cháyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '茶叶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cháyè',
      meaning_vi = 'lá trà, búp chè',
      example_hanzi = '西湖龙井是中国最具代表性的名贵绿茶茶叶之一。',
      example_pinyin = 'Xīhú lóngjǐng shì Zhōngguó zuì jù dàibiǎoxìng de míngguì lǜchá cháyè zhī yī.',
      example_vi = 'Long Tỉnh Tây Hồ là một trong những loại lá trà xanh quý giá mang tính đại diện nhất của Trung Quốc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '西湖龙井是中国最具代表性的名贵绿茶茶叶之一。', 'Xīhú lóngjǐng shì Zhōngguó zuì jù dàibiǎoxìng de míngguì lǜchá cháyè zhī yī.', 'Long Tỉnh Tây Hồ là một trong những loại lá trà xanh quý giá mang tính đại diện nhất của Trung Quốc.', 'basic', 1),
        (v_id, '上好的茶叶不仅冲泡出来的汤色清澈碧绿，而且入口回甘，令人回味悠长。', 'Shànghǎo de cháyè bùjǐn chōngpào chūlái de tāngsè qīngchè bìlǜ, érqiě rùkǒu huígān, lìng rén huíwèi yōucháng.', 'Lá trà thượng hạng không chỉ pha ra nước trà trong vắt xanh biếc mà khi nhấp vào miệng còn ngọt hậu, khiến người ta dư ba lắng đọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [查找] (cházhǎo) - tìm kiếm, tra cứu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '查找' AND pinyin = 'cházhǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '查找'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'cházhǎo',
      meaning_vi = 'tìm kiếm, tra cứu',
      example_hanzi = '在写毕业论文时，他花了两周时间在图书馆查找参考资料。',
      example_pinyin = 'Zài xiě bìyè lùnwén shí, tā huā le liǎng zhōu shíjiān zài túshūguǎn cházhǎo cānkǎo zīliào.',
      example_vi = 'Khi viết luận văn tốt nghiệp, cậu ấy đã dành hai tuần ở thư viện tra cứu tài liệu tham khảo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在写毕业论文时，他花了两周时间在图书馆查找参考资料。', 'Zài xiě bìyè lùnwén shí, tā huā le liǎng zhōu shíjiān zài túshūguǎn cházhǎo cānkǎo zīliào.', 'Khi viết luận văn tốt nghiệp, cậu ấy đã dành hai tuần ở thư viện tra cứu tài liệu tham khảo.', 'basic', 1),
        (v_id, '利用现代数字数据库的关键词检索功能，研究人员能够极其高效地查找相关学术文献。', 'Lìyòng xiàndài shùzì shùjùkù de guānjiàncí jiǎnsuǒ gōngnéng, yánjiū rényuán nénggòu jíqí gāoxiào de cházhǎo xiāngguān xuéshù wénxiàn.', 'Nhờ tính năng tra cứu từ khóa của các cơ sở dữ liệu số hiện đại, các nhà nghiên cứu có thể tìm kiếm tài liệu học thuật liên quan cực kỳ hiệu quả.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [差点儿] (chàdiǎnr) - suýt nữa, suýt chút nữa [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '差点儿' AND pinyin = 'chàdiǎnr'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '差点儿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'chàdiǎnr',
      meaning_vi = 'suýt nữa, suýt chút nữa',
      example_hanzi = '今天早晨路上太堵了，我差点儿就赶不上这班高铁。',
      example_pinyin = 'Jīntiān zǎochén lù shang tài dǔ le, wǒ chàdiǎnr jiù gǎn bu shàng zhè bān gāotiě.',
      example_vi = 'Sáng nay đường tắc quá, tôi suýt chút nữa thì không kịp bắt chuyến tàu cao tốc này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天早晨路上太堵了，我差点儿就赶不上这班高铁。', 'Jīntiān zǎochén lù shang tài dǔ le, wǒ chàdiǎnr jiù gǎn bu shàng zhè bān gāotiě.', 'Sáng nay đường tắc quá, tôi suýt chút nữa thì không kịp bắt chuyến tàu cao tốc này.', 'basic', 1),
        (v_id, '地面结了厚厚一层暗冰，走在前面的行人脚下一滑，差点儿摔倒在台阶上。', 'Dìmiàn jié le hòuhòu yì céng ànbīng, zǒu zài qiánmiàn de xíngrén jiǎoxià yì huá, chàdiǎnr shuāidǎo zài táijiē shang.', 'Mặt đất đóng một lớp băng mỏng trơn trượt, người đi bộ phía trước trượt chân một cái, suýt nữa ngã nhào trên bậc thang.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [产生] (chǎnshēng) - sinh ra, nảy sinh, xuất hiện [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '产生' AND pinyin = 'chǎnshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '产生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chǎnshēng',
      meaning_vi = 'sinh ra, nảy sinh, xuất hiện',
      example_hanzi = '经过长期的文化交流，两国青年之间产生了深厚的友谊。',
      example_pinyin = 'Jīngguò chángqī de wénhuà jiāoliú, liǎng guó qīngnián zhījiān chǎnshēng le shēnhòu de yǒuyì.',
      example_vi = 'Trải qua giao lưu văn hóa lâu dài, giữa thanh niên hai nước đã nảy sinh tình bạn sâu sắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过长期的文化交流，两国青年之间产生了深厚的友谊。', 'Jīngguò chángqī de wénhuà jiāoliú, liǎng guó qīngnián zhījiān chǎnshēng le shēnhòu de yǒuyì.', 'Trải qua giao lưu văn hóa lâu dài, giữa thanh niên hai nước đã nảy sinh tình bạn sâu sắc.', 'basic', 1),
        (v_id, '不合理的城市发展模式会对周边的水资源和生态系统产生不可逆转的负面影响。', 'Bù hélǐ de chéngshì fāzhǎn móshì huì duì zhōubiān de shuǐzīyuán hé shēngtài xìtǒng chǎnshēng bù kě nìzhuǎn de fùmiàn yǐngxiǎng.', 'Mô hình phát triển đô thị bất hợp lý sẽ gây ra những tác động tiêu cực không thể đảo ngược đối với nguồn nước và hệ sinh thái xung quanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [厂] (chǎng) - nhà máy, xưởng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '厂' AND pinyin = 'chǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '厂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chǎng',
      meaning_vi = 'nhà máy, xưởng',
      example_hanzi = '他的父亲在一家大型钢铁厂工作了三十多年。',
      example_pinyin = 'Tā de fùqīn zài yì jiā dàxíng gāngtiěchǎng gōngzuò le sānshí duō nián.',
      example_vi = 'Bố của anh ấy đã làm việc tại một nhà máy gang thép lớn suốt hơn ba mươi năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的父亲在一家大型钢铁厂工作了三十多年。', 'Tā de fùqīn zài yì jiā dàxíng gāngtiěchǎng gōngzuò le sānshí duō nián.', 'Bố của anh ấy đã làm việc tại một nhà máy gang thép lớn suốt hơn ba mươi năm.', 'basic', 1),
        (v_id, '该电子配件制造厂全面引进智能机器人，使车间的自动化生产水平迈上了新台阶。', 'Gāi diànzǐ pèijiàn zhìzàochǎng quánmiàn yǐnjìn zhìnéng jīqìrén, shǐ chējiān de zìdònghuà shēngchǎn shuǐpíng mài shàng le xīn táijiē.', 'Nhà máy chế tạo linh kiện điện tử này đã đưa vào sử dụng toàn diện robot thông minh, đưa trình độ tự động hóa phân xưởng lên tầm cao mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [场] (chǎng) - trận, buổi (lượng từ trận đấu, cơn mưa, vở kịch); sân bãi [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '场' AND pinyin = 'chǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'chǎng',
      meaning_vi = 'trận, buổi (lượng từ trận đấu, cơn mưa, vở kịch); sân bãi',
      example_hanzi = '昨天下午的那场足球比赛竞争异常激烈。',
      example_pinyin = 'Zuótiān xiàwǔ de nà chǎng zúqiú bǐsài jìngzhēng yìcháng jīliè.',
      example_vi = 'Trận bóng đá chiều hôm qua cạnh tranh kịch tính vô cùng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昨天下午的那场足球比赛竞争异常激烈。', 'Zuótiān xiàwǔ de nà chǎng zúqiú bǐsài jìngzhēng yìcháng jīliè.', 'Trận bóng đá chiều hôm qua cạnh tranh kịch tính vô cùng.', 'basic', 1),
        (v_id, '久旱逢甘霖，昨夜下了一场及时的大透雨，彻底缓解了当地严重的旱情。', 'Jiǔhàn-fénggānlín, zuóyè xià le yì chǎng jíshí de dà tòuyǔ, chèdǐ huǎnjiě le dāngdì yánzhòng de hànqíng.', 'Hạn hán lâu ngày gặp mưa rào, đêm qua trút xuống một trận mưa to kịp thời đã giải tỏa triệt để tình trạng hạn hán nghiêm trọng nơi đây.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [超过] (chāoguò) - vượt qua, vượt quá [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '超过' AND pinyin = 'chāoguò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '超过'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chāoguò',
      meaning_vi = 'vượt qua, vượt quá',
      example_hanzi = '今天市区的最高气温已经超过了三十八摄氏度。',
      example_pinyin = 'Jīntiān shìqū de zuìgāo qìwēn yǐjīng chāoguò le sānshíbā shèshìdù.',
      example_vi = 'Nhiệt độ cao nhất trong nội thành hôm nay đã vượt quá ba mươi tám độ C.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天市区的最高气温已经超过了三十八摄氏度。', 'Jīntiān shìqū de zuìgāo qìwēn yǐjīng chāoguò le sānshíbā shèshìdù.', 'Nhiệt độ cao nhất trong nội thành hôm nay đã vượt quá ba mươi tám độ C.', 'basic', 1),
        (v_id, '经过不懈奋斗，该高新技术企业的年销售额首次突破并超过了百亿元大关。', 'Jīngguò búxiè fèndòu, gāi gāoxīn-jìshù qǐyè de nián xiāoshòu’é shǒucì tūpò bìng chāoguò le bǎi yì yuán dàguān.', 'Nhờ nỗ lực không ngừng nghỉ, doanh số năm của doanh nghiệp công nghệ cao này lần đầu tiên bứt phá và vượt qua mốc chục tỷ nhân dân tệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [车速] (chēsù) - tốc độ xe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '车速' AND pinyin = 'chēsù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '车速'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chēsù',
      meaning_vi = 'tốc độ xe',
      example_hanzi = '雨天路滑，司机应当主动降低车速，保持安全车距。',
      example_pinyin = 'Yǔtiān lù huá, sījī yīngdāng zhǔdòng jiàngdī chēsù, bǎochí ānquán chējù.',
      example_vi = 'Trời mưa đường trơn, tài xế nên chủ động giảm tốc độ xe và giữ khoảng cách an toàn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '雨天路滑，司机应当主动降低车速，保持安全车距。', 'Yǔtiān lù huá, sījī yīngdāng zhǔdòng jiàngdī chēsù, bǎochí ānquán chējù.', 'Trời mưa đường trơn, tài xế nên chủ động giảm tốc độ xe và giữ khoảng cách an toàn.', 'basic', 1),
        (v_id, '高速公路上安装了精密测速摄像头，严厉查处任何超过规定车速的危险驾驶行为。', 'Gāosù gōnglù shang ānzhuāng le jīngmì cèsù shèxiàngtóu, yánlì cháchǔ rènhé chāoguò guīdìng chēsù de wēixiǎn jiàshǐ xíngwéi.', 'Trên đường cao tốc lắp đặt camera đo tốc độ tinh vi, xử lý nghiêm minh mọi hành vi lái xe nguy hiểm vượt quá tốc độ quy định.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [车位] (chēwèi) - chỗ đỗ xe, vị trí đỗ xe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '车位' AND pinyin = 'chēwèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '车位'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chēwèi',
      meaning_vi = 'chỗ đỗ xe, vị trí đỗ xe',
      example_hanzi = '地下停车场里还有不少空余的车位可以停靠。',
      example_pinyin = 'Dìxià tíngchēchǎng lǐ hái yǒu bùshǎo kōngyú de chēwèi kěyǐ tíngkào.',
      example_vi = 'Trong bãi đỗ xe dưới tầng hầm vẫn còn khá nhiều vị trí trống có thể đỗ xe.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '地下停车场里还有不少空余的车位可以停靠。', 'Dìxià tíngchēchǎng lǐ hái yǒu bùshǎo kōngyú de chēwèi kěyǐ tíngkào.', 'Trong bãi đỗ xe dưới tầng hầm vẫn còn khá nhiều vị trí trống có thể đỗ xe.', 'basic', 1),
        (v_id, '随着私家车保有量的激增，老旧小区的车位短缺问题成为了社区治理的一大难题。', 'Suízhe sījiāchē bǎoyǒuliàng de jīzēng, lǎojiù xiǎoqū de chēwèi duǎnquē wèntí chéngwéi le shèqū zhìlǐ de yí dà nántí.', 'Cùng với sự gia tăng đột biến của lượng xe hơi cá nhân, bài toán thiếu chỗ đỗ xe tại các khu chung cư cũ đã trở thành vấn đề nan giải trong quản trị khu dân cư.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [城] (chéng) - thành phố, đô thị, tường thành [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '城' AND pinyin = 'chéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '城'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chéng',
      meaning_vi = 'thành phố, đô thị, tường thành',
      example_hanzi = '西安是一座拥有数千年悠久历史的古城。',
      example_pinyin = 'Xī’ān shì yí zuò yōngyǒu shù qiān nián yōujiǔ lìshǐ de gǔchéng.',
      example_vi = 'Tây An là một cổ thành sở hữu lịch sử lâu đời hàng ngàn năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '西安是一座拥有数千年悠久历史的古城。', 'Xī’ān shì yí zuò yōngyǒu shù qiān nián yōujiǔ lìshǐ de gǔchéng.', 'Tây An là một cổ thành sở hữu lịch sử lâu đời hàng ngàn năm.', 'basic', 1),
        (v_id, '昔日偏僻落后的小渔村如今已经蜕变成了一座充满活力与现代气息的海滨新城。', 'Xīrì piānpì luòhòu de xiǎoyúcūn rújīn yǐjīng tuìbiàn chéng le yí zuò chōngmǎn huólì yǔ xiàndài qìxī de hǎibīn xīnhchéng.', 'Làng chài nhỏ hẻo lánh lạc hậu thuở nào nay đã lột xác thành một đô thị biển mới mẻ ngập tràn sức sống và hơi thở hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [乘] (chéng) - đi, đón (phương tiện); nhân (toán học); nhân cơ hội [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '乘' AND pinyin = 'chéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '乘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chéng',
      meaning_vi = 'đi, đón (phương tiện); nhân (toán học); nhân cơ hội',
      example_hanzi = '他每天早晨乘地铁去金融街上班。',
      example_pinyin = 'Tā měitiān zǎochén chéng dìtiě qù Jīnróngjiē shàngbān.',
      example_vi = 'Mỗi sáng anh ấy đều đi tàu điện ngầm đến Phố Tài Chính làm việc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他每天早晨乘地铁去金融街上班。', 'Tā měitiān zǎochén chéng dìtiě qù Jīnróngjiē shàngbān.', 'Mỗi sáng anh ấy đều đi tàu điện ngầm đến Phố Tài Chính làm việc.', 'basic', 1),
        (v_id, '我们要乘着国家大力支持科技创新的东风，乘势而上加快自主研发步伐。', 'Wǒmen yào chéng zhe guójiā dàlì zhīchí kējì chuàngxīn de dōngfēng, chéngshì-érshàng jiākuài zìzhǔ yánfā bùfá.', 'Chúng ta phải nhân ngọn gió đông nhà nước dốc sức ủng hộ đổi mới công nghệ, thuận đà vươn lên đẩy nhanh bước tiến tự chủ nghiên cứu phát triển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [成功] (chénggōng) - thành công [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '成功' AND pinyin = 'chénggōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '成功'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'chénggōng',
      meaning_vi = 'thành công',
      example_hanzi = '经过无数次实验与摸索，科学家们终于取得了成功。',
      example_pinyin = 'Jīngguò wúshù cì shíyàn yǔ mōsuǒ, kēxuéjiāmen zhōngyú qǔdé le chénggōng.',
      example_vi = 'Trải qua vô số lần thí nghiệm và tìm tòi, các nhà khoa học cuối cùng đã giành được thành công.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过无数次实验与摸索，科学家们终于取得了成功。', 'Jīngguò wúshù cì shíyàn yǔ mōsuǒ, kēxuéjiāmen zhōngyú qǔdé le chénggōng.', 'Trải qua vô số lần thí nghiệm và tìm tòi, các nhà khoa học cuối cùng đã giành được thành công.', 'basic', 1),
        (v_id, '每一次成功的背后都凝聚着无数个日夜默默挥洒的汗水与持之以恒的坚持。', 'Měi yí cì chénggōng de bèihòu dōu níngjù zhe wúshù gè rì-yè mòmò huīsǎ de hànshuǐ yǔ chízhīyǐhéng de jiānchí.', 'Đằng sau mỗi lần thành công đều ngưng kết bao mồ hôi âm thầm tuôn rơi ngày đêm và sự kiên trì bền bỉ không dứt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [乘客] (chéngkè) - hành khách [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '乘客' AND pinyin = 'chéngkè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '乘客'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chéngkè',
      meaning_vi = 'hành khách',
      example_hanzi = '请各位乘客在上车后主动往车厢中段走。',
      example_pinyin = 'Qǐng gèwèi chéngkè zài shàngchē hòu zhǔdòng wǎng chēxiāng zhōngduàn zǒu.',
      example_vi = 'Xin quý hành khách sau khi lên xe hãy chủ động tiến về phía giữa toa xe.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请各位乘客在上车后主动往车厢中段走。', 'Qǐng gèwèi chéngkè zài shàngchē hòu zhǔdòng wǎng chēxiāng zhōngduàn zǒu.', 'Xin quý hành khách sau khi lên xe hãy chủ động tiến về phía giữa toa xe.', 'basic', 1),
        (v_id, '列车长带领乘务组热心细致地为每一位有特殊困难的旅客提供周到的爱心服务。', 'Lièchēzhǎng dàilǐng chéngwùzǔ rèxīn xìzhì de wèi měi yí wèi yǒu tèshū kùnnan de lǚkè tígōng zhōudào de àixīn fúwù.', 'Trưởng tàu dẫn dắt đội tiếp viên nhiệt tình tỉ mỉ cung cấp dịch vụ yêu thương chu đáo cho mỗi hành khách gặp khó khăn đặc biệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [诚实] (chéngshí) - thành thật, trung thực [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '诚实' AND pinyin = 'chéngshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '诚实'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'chéngshí',
      meaning_vi = 'thành thật, trung thực',
      example_hanzi = '诚实守信是做人立足于社会最宝贵的美德。',
      example_pinyin = 'Chéngshí shǒuxìn shì zuòrén lìzú yú shèhuì zuì bǎoguì de měidé.',
      example_vi = 'Trung thực giữ chữ tín là đức tính quý báu nhất để làm người đứng vững trong xã hội.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '诚实守信是做人立足于社会最宝贵的美德。', 'Chéngshí shǒuxìn shì zuòrén lìzú yú shèhuì zuì bǎoguì de měidé.', 'Trung thực giữ chữ tín là đức tính quý báu nhất để làm người đứng vững trong xã hội.', 'basic', 1),
        (v_id, '面对自己无意犯下的过失，勇敢坦承错误远比编造谎言更能赢得他人的尊重与谅解。', 'Miànduì zìjǐ wúyì fànxià de guòshī, yǒnggǎn tǎnchéng cuòwù yuǎn bǐ biānzào huǎngyán gèng néng yíngdé tārén de zūnzhòng yǔ liàngjiě.', 'Đứng trước sai sót vô tình phạm phải, dũng cảm nhận lỗi tốt hơn nhiều so với việc thêu dệt lời nói dối để nhận lại sự tôn trọng và thứ tha của người khác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [成为] (chéngwéi) - trở thành, trở nên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '成为' AND pinyin = 'chéngwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '成为'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chéngwéi',
      meaning_vi = 'trở thành, trở nên',
      example_hanzi = '他的童年梦想是长大后成为一名杰出的宇航员。',
      example_pinyin = 'Tā de tóngnián mèngxiǎng shì zhǎngdà hòu chéngwéi yì míng jiéchū de yǔhángyuán.',
      example_vi = 'Ước mơ tuổi thơ của cậu ấy là lớn lên trở thành một phi hành gia kiệt xuất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的童年梦想是长大后成为一名杰出的宇航员。', 'Tā de tóngnián mèngxiǎng shì zhǎngdà hòu chéngwéi yì míng jiéchū de yǔhángyuán.', 'Ước mơ tuổi thơ của cậu ấy là lớn lên trở thành một phi hành gia kiệt xuất.', 'basic', 1),
        (v_id, '经过十几年的快速发展，这座沿海港口城市已经成为了具有全球影响力的国际航运中心。', 'Jīngguò shí jǐ nián de kuàisù fāzhǎn, zhè zuò yánhǎi gǎngkǒu chéngshì yǐjīng chéngwéi le jùyǒu quánqiú yǐngxiǎnglì de guójì hángyùn zhōngxīn.', 'Trải qua mười mấy năm phát triển nhanh chóng, thành phố cảng ven biển này đã trở thành một trung tâm vận tải biển quốc tế mang tầm ảnh hưởng toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [乘坐] (chéngzuò) - đi, ngồi (tàu xe, máy bay) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '乘坐' AND pinyin = 'chéngzuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '乘坐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chéngzuò',
      meaning_vi = 'đi, ngồi (tàu xe, máy bay)',
      example_hanzi = '乘坐高铁从北京到上海只需要四个多小时。',
      example_pinyin = 'Chéngzuò gāotiě cóng Běijīng dào Shànghǎi zhǐ xūyào sì gè duō xiǎoshí.',
      example_vi = 'Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải chỉ mất hơn bốn tiếng đồng hồ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '乘坐高铁从北京到上海只需要四个多小时。', 'Chéngzuò gāotiě cóng Běijīng dào Shànghǎi zhǐ xūyào sì gè duō xiǎoshí.', 'Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải chỉ mất hơn bốn tiếng đồng hồ.', 'basic', 1),
        (v_id, '在乘坐观光游轮夜游黄浦江时，两岸绚丽璀璨的摩天大楼夜景令人流连忘返。', 'Zài chéngzuò guānguāng yóulún yèyóu Huángpǔ Jiāng shí, liǎng’àn xuànlì cuǐcàn de mótiān-dàlóu yèjǐng lìng rén liúlián-wàngfǎn.', 'Khi đi du thuyền ngắm cảnh đêm trên sông Hoàng Phố, cảnh đêm rực rỡ lộng lẫy của các tòa nhà chọc trời hai bên bờ khiến lòng người xao xuyến không muốn rời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [吃惊] (chījīng) - kinh ngạc, giật mình, sửng sốt [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '吃惊' AND pinyin = 'chījīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '吃惊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'chījīng',
      meaning_vi = 'kinh ngạc, giật mình, sửng sốt',
      example_hanzi = '听到这个令人意外的比赛结果，大家都感到十分吃惊。',
      example_pinyin = 'Tīng dào zhè gè lìng rén yìwài de bǐsài jiéguǒ, dàjiā dōu gǎndào shífēn chījīng.',
      example_vi = 'Nghe kết quả thi đấu bất ngờ này, mọi người đều cảm thấy hết sức ngạc nhiên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到这个令人意外的比赛结果，大家都感到十分吃惊。', 'Tīng dào zhè gè lìng rén yìwài de bǐsài jiéguǒ, dàjiā dōu gǎndào shífēn chījīng.', 'Nghe kết quả thi đấu bất ngờ này, mọi người đều cảm thấy hết sức ngạc nhiên.', 'basic', 1),
        (v_id, '他在这短短半年内取得的巨大中文学习进步，确实让所有授课老师大为吃惊。', 'Tā zài zhè duǎnduǎn bàn nián nèi qǔdé de jùdà Zhōngwén xuéxí jìnbù, quèshí ràng suǒyǒu shòukè lǎoshī dàwéi chījīng.', 'Tiến bộ vượt bậc trong việc học tiếng Trung mà cậu ấy đạt được chỉ trong nửa năm ngắn ngủi thực sự làm tất cả thầy cô giảng dạy phải vô cùng kinh ngạc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [迟] (chí) - chậm, muộn, trễ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '迟' AND pinyin = 'chí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '迟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'chí',
      meaning_vi = 'chậm, muộn, trễ',
      example_hanzi = '现在开始努力学习任何知识都不算迟。',
      example_pinyin = 'Xiànzài kāishǐ nǔlì xuéxí rènhé zhīshi dōu bú suàn chí.',
      example_vi = 'Bây giờ bắt đầu chăm chỉ học bất kỳ kiến thức nào cũng chưa coi là muộn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '现在开始努力学习任何知识都不算迟。', 'Xiànzài kāishǐ nǔlì xuéxí rènhé zhīshi dōu bú suàn chí.', 'Bây giờ bắt đầu chăm chỉ học bất kỳ kiến thức nào cũng chưa coi là muộn.', 'basic', 1),
        (v_id, '因为突降大暴雨导致航班起飞延误，我们到达目的地酒店时已经是深夜迟暮了。', 'Yīnwèi tū jiàng dàbàoyǔ dǎozhì hángbān qǐfēi yánwù, wǒmen dàodá mùdìdì jiǔdiàn shí yǐjīng shì shēnyè chímù le.', 'Do mưa to bất ngờ trút xuống làm chuyến bay hoãn cất cánh, khi chúng tôi tới khách sạn đích thì trời đã vào đêm khuya muộn màng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [重] (chóng) - lại, một lần nữa; trùng điệp [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '重' AND pinyin = 'chóng'
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
      word_type = 'Phó từ',
      pinyin = 'chóng',
      meaning_vi = 'lại, một lần nữa; trùng điệp',
      example_hanzi = '电脑系统崩溃了，我们需要重新启动机器。',
      example_pinyin = 'Diànnǎo xìtǒng bēngkuì le, wǒmen xūyào chóngxīn qǐdòng jīqì.',
      example_vi = 'Hệ thống máy tính bị sập rồi, chúng ta cần phải khởi động lại máy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '电脑系统崩溃了，我们需要重新启动机器。', 'Diànnǎo xìtǒng bēngkuì le, wǒmen xūyào chóngxīn qǐdòng jīqì.', 'Hệ thống máy tính bị sập rồi, chúng ta cần phải khởi động lại máy.', 'basic', 1),
        (v_id, '虽然历经重重艰难挫折，但这支坚强的科研团队依然重整旗鼓迎难而上。', 'Suīrán lìjīng chóngchóng jiānnán cuòzhé, dàn zhè zhī jiānqiáng de kēyán tuánduì yīrán chóngzhěng-qígǔ yíngnán’érshàng.', 'Tuy trải qua muôn trùng gian nan trắc trở, đội ngũ nghiên cứu khoa học kiên cường này vẫn củng cố lực lượng xốc lại tinh thần đương đầu vượt khó.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [重新] (chóngxīn) - làm lại từ đầu, làm lại [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '重新' AND pinyin = 'chóngxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '重新'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'chóngxīn',
      meaning_vi = 'làm lại từ đầu, làm lại',
      example_hanzi = '老师建议他把这篇结构松散的文章重新修改一遍。',
      example_pinyin = 'Lǎoshī jiànyì tā bǎ zhè piān jiégòu sōngsǎn de wénzhāng chóngxīn xiūgǎi yí biàn.',
      example_vi = 'Thầy giáo khuyên cậu ấy nên chỉnh sửa lại một lượt bài văn có kết cấu lỏng lẻo này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师建议他把这篇结构松散的文章重新修改一遍。', 'Lǎoshī jiànyì tā bǎ zhè piān jiégòu sōngsǎn de wénzhāng chóngxīn xiūgǎi yí biàn.', 'Thầy giáo khuyên cậu ấy nên chỉnh sửa lại một lượt bài văn có kết cấu lỏng lẻo này.', 'basic', 1),
        (v_id, '跌倒了并不可怕，拍拍身上的尘土，调整好心态重新出发才是真正的强者。', 'Diēdǎo le bìng bù kěpà, pāipai shēn shang de chéntǔ, tiáozhěng hǎo xīntài chóngxīn chūfā cái shì zhēnzhèng de qiángzhě.', 'Vấp ngã không hề đáng sợ, phủi sạch bụi cát trên người, ổn định lại tâm thái để bắt đầu lại từ đầu mới thực sự là kẻ mạnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [出差] (chūchāi) - đi công tác [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '出差' AND pinyin = 'chūchāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '出差'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chūchāi',
      meaning_vi = 'đi công tác',
      example_hanzi = '李经理下周一要前往广州分公司出差三天。',
      example_pinyin = 'Lǐ jīnglǐ xià zhōuyī yào qiánwǎng Guǎngzhōu fēngōngsī chūchāi sān tiān.',
      example_vi = 'Thứ Hai tuần tới Giám đốc Lý phải đi chi nhánh Quảng Châu công tác ba ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '李经理下周一要前往广州分公司出差三天。', 'Lǐ jīnglǐ xià zhōuyī yào qiánwǎng Guǎngzhōu fēngōngsī chūchāi sān tiān.', 'Thứ Hai tuần tới Giám đốc Lý phải đi chi nhánh Quảng Châu công tác ba ngày.', 'basic', 1),
        (v_id, '外贸部门的业务员们一年到头频繁出差，足迹遍布各大海外新兴市场。', 'Wàimào bùmén de yèwùyuánmen yì nián dào tóu pínfán chūchāi, zújì biànbù gè dà hǎiwài xīnxīng shìchǎng.', 'Các nhân viên kinh doanh của bộ phận ngoại thương quanh năm đi công tác triền miên, dấu chân in khắp các thị trường mới nổi ở nước ngoài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [出口] (chūkǒu) - cửa ra; xuất khẩu [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '出口' AND pinyin = 'chūkǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '出口'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'chūkǒu',
      meaning_vi = 'cửa ra; xuất khẩu',
      example_hanzi = '沿着这条走廊直走到头就是地铁站的A出口。',
      example_pinyin = 'Yánzhe zhè tiáo zǒuláng zhí zǒu dào tóu jiù shì dìtiězhàn de A chūkǒu.',
      example_vi = 'Đi thẳng hết lối hành lang này chính là cửa ra A của ga tàu điện ngầm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '沿着这条走廊直走到头就是地铁站的A出口。', 'Yánzhe zhè tiáo zǒuláng zhí zǒu dào tóu jiù shì dìtiězhàn de A chūkǒu.', 'Đi thẳng hết lối hành lang này chính là cửa ra A của ga tàu điện ngầm.', 'basic', 1),
        (v_id, '近年来我国高科技电子产品和绿色新能源汽车的海外出口总额持续攀升。', 'Jìnniánlái wǒguó gāokējì diànzǐ chǎnpǐn hé lǜsè xīnnéngyuán qìchē de hǎiwài chūkǒu zǒng’é chíxù pānshēng.', 'Những năm gần đây tổng kim ngạch xuất khẩu ra nước ngoài của các sản phẩm điện tử công nghệ cao và xe năng lượng mới xanh của nước ta liên tục tăng vọt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [出现] (chūxiàn) - xuất hiện, nảy sinh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '出现' AND pinyin = 'chūxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '出现'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chūxiàn',
      meaning_vi = 'xuất hiện, nảy sinh',
      example_hanzi = '雨过天晴，天空中出现了一道美丽的七色彩虹。',
      example_pinyin = 'Yǔguò-tiānqíng, tiānkōng zhōng chūxiàn le yí dào měilì de qīsè cǎihóng.',
      example_vi = 'Mưa tạnh trời quang, giữa bầu trời xuất hiện một dải cầu vồng bảy sắc lung linh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '雨过天晴，天空中出现了一道美丽的七色彩虹。', 'Yǔguò-tiānqíng, tiānkōng zhōng chūxiàn le yí dào měilì de qīsè cǎihóng.', 'Mưa tạnh trời quang, giữa bầu trời xuất hiện một dải cầu vồng bảy sắc lung linh.', 'basic', 1),
        (v_id, '当项目开发过程中出现不可预见的技术故障时，工程师们总能在第一时间排查解决。', 'Dāng xiàngmù kāifā guòchéng zhōng chūxiàn bù kě yùjiàn de jìshù gùzhàng shí, gōngchéngshīmen zǒng néng zài dì-yī shíjiān páichá jiějué.', 'Khi trong quá trình phát triển dự án phát sinh sự cố kỹ thuật khó lường trước, các kỹ sư luôn có thể điều tra khắc phục ngay lập tức.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [出行] (chūxíng) - đi lại, xuất hành [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '出行' AND pinyin = 'chūxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '出行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'chūxíng',
      meaning_vi = 'đi lại, xuất hành',
      example_hanzi = '国庆长假期间各大交通枢纽迎来了市民出行的客流高峰。',
      example_pinyin = 'Guóqìng chángjià qījiān gè dà jiāotōng shūniǔ yínglái le shìmín chūxíng de kèliú gāofēng.',
      example_vi = 'Trong kỳ nghỉ lễ Quốc khánh dài ngày, các đầu mối giao thông lớn đón đợt cao điểm hành khách đi lại của người dân.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '国庆长假期间各大交通枢纽迎来了市民出行的客流高峰。', 'Guóqìng chángjià qījiān gè dà jiāotōng shūniǔ yínglái le shìmín chūxíng de kèliú gāofēng.', 'Trong kỳ nghỉ lễ Quốc khánh dài ngày, các đầu mối giao thông lớn đón đợt cao điểm hành khách đi lại của người dân.', 'basic', 1),
        (v_id, '完善的城市无障碍通道建设为老年人和行动不便人士的自主安全出行提供了有力保障。', 'Wánshàn de chéngshì wúzhàng’ài tōngdào jiànshè wèi lǎoniánrén hé xíngdòng búbiàn rénshì de zìzhǔ ānquán chūxíng tígōng le yǒulì bǎozhàng.', 'Việc xây dựng hoàn thiện lối đi không rào cản đô thị đã mang lại sự bảo đảm vững chắc cho việc đi lại an toàn tự chủ của người cao tuổi và người khó khăn vận động.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [出租] (chūzū) - cho thuê [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '出租' AND pinyin = 'chūzū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '出租'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chūzū',
      meaning_vi = 'cho thuê',
      example_hanzi = '房东打算把这套两室一厅的公寓长期出租给爱干净的租客。',
      example_pinyin = 'Fángdōng dǎsuàn bǎ zhè tào liǎngshì-yìtīng de gōngyù chángqī chūzū gěi ài gānjìng de zūkè.',
      example_vi = 'Chủ nhà định cho khách thuê chuộng sạch sẽ thuê lâu dài căn hộ hai phòng ngủ một phòng khách này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '房东打算把这套两室一厅的公寓长期出租给爱干净的租客。', 'Fángdōng dǎsuàn bǎ zhè tào liǎngshì-yìtīng de gōngyù chángqī chūzū gěi ài gānjìng de zūkè.', 'Chủ nhà định cho khách thuê chuộng sạch sẽ thuê lâu dài căn hộ hai phòng ngủ một phòng khách này.', 'basic', 1),
        (v_id, '我们在三亚旅游度假期间特意向汽车租赁公司出租了一辆敞篷越野车。', 'Wǒmen zài Sānyà lǚyóu dùjià qījiān tèyì xiàng qìchē zūlìn gōngsī chūzū le yí liàng chǎngpéng yuèyěchē.', 'Trong thời gian du lịch nghỉ mát ở Tam Á, chúng tôi đã thuê từ công ty cho thuê xe một chiếc xe việt dã mui trần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [厨房] (chúfáng) - nhà bếp, phòng bếp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '厨房' AND pinyin = 'chúfáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '厨房'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chúfáng',
      meaning_vi = 'nhà bếp, phòng bếp',
      example_hanzi = '妈妈正在厨房里忙着用砂锅煲一锅营养美味的鸡汤。',
      example_pinyin = 'Māma zhèngzài chúfáng lǐ máng zhe yòng shāguō bāo yì guō yíngyǎng měiwèi de jītāng.',
      example_vi = 'Mẹ đang bận rộn trong bếp dùng nồi đất hầm một nồi canh gà bổ dưỡng thơm ngon.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '妈妈正在厨房里忙着用砂锅煲一锅营养美味的鸡汤。', 'Māma zhèngzài chúfáng lǐ máng zhe yòng shāguō bāo yì guō yíngyǎng měiwèi de jītāng.', 'Mẹ đang bận rộn trong bếp dùng nồi đất hầm một nồi canh gà bổ dưỡng thơm ngon.', 'basic', 1),
        (v_id, '现代开放式厨房设计不仅大幅拓展了视觉空间，更增进了家人烹饪过程中的温馨互动。', 'Xiàndài kāifàngshì chúfáng shèjì bùjǐn dàfú tuòzhǎn le shìjué kōngjiān, gèng zēngjìn le jiārén pēngrèn guòchéng zhōng de wēnxīn hùdòng.', 'Thiết kế bếp mở hiện đại không những mở rộng không gian thị giác đáng kể mà còn tăng thêm sự tương tác ấm áp của cả nhà trong lúc nấu nướng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [厨师] (chúshī) - đầu bếp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '厨师' AND pinyin = 'chúshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '厨师'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chúshī',
      meaning_vi = 'đầu bếp',
      example_hanzi = '这家饭店聘请了特级川菜厨师主勺掌厨。',
      example_pinyin = 'Zhè jiā fàndiàn pìnqǐng le tèjí Chuāncài chúshī zhǔsháo zhǎngchú.',
      example_vi = 'Nhà hàng này đã thuê đầu bếp món Tứ Xuyên bậc đặc biệt về làm bếp trưởng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家饭店聘请了特级川菜厨师主勺掌厨。', 'Zhè jiā fàndiàn pìnqǐng le tèjí Chuāncài chúshī zhǔsháo zhǎngchú.', 'Nhà hàng này đã thuê đầu bếp món Tứ Xuyên bậc đặc biệt về làm bếp trưởng.', 'basic', 1),
        (v_id, '经验丰富的资深厨师不仅刀工精湛娴熟，更能巧妙运用各类香料激发食材的原汁原味。', 'Jīngyàn fēngfù de zīshēn chúshī bùjǐn dāogōng jīngzhàn xiánshú, gèng néng qiǎomiào yùnyòng gè lèi xiāngliào jīfā shícái de yuánzhī-yuánwèi.', 'Người đầu bếp kỳ cựu dày dặn kinh nghiệm không chỉ có kỹ nghệ dao thớt điêu luyện thuần thục, mà còn khéo léo dùng các loại gia vị để đánh thức vị nguyên bản của thực phẩm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [窗] (chuāng) - cửa sổ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '窗' AND pinyin = 'chuāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '窗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chuāng',
      meaning_vi = 'cửa sổ',
      example_hanzi = '推开窗，一阵清新芬芳的花草香气扑面而来。',
      example_pinyin = 'Tuī kāi chuāng, yí zhèn qīngxīn fēnfāng de huācǎo xiāngqì pūmiàn’érlái.',
      example_vi = 'Đẩy mở cánh cửa sổ, một làn hương hoa cỏ thơm ngát thanh khiết ùa vào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '推开窗，一阵清新芬芳的花草香气扑面而来。', 'Tuī kāi chuāng, yí zhèn qīngxīn fēnfāng de huācǎo xiāngqì pūmiàn’érlái.', 'Đẩy mở cánh cửa sổ, một làn hương hoa cỏ thơm ngát thanh khiết ùa vào.', 'basic', 1),
        (v_id, '“眼睛是心灵的窗”，透过一个人清澈真挚的目光往往能窥见其善良纯洁的内心世界。', '“Yǎnjing shì xīnlíng de chuāng”, tòuguò yí gè rén qīngchè zhēnzhì de mùguāng wǎngwǎng néng kuījiàn qí shànliáng chúnjié de nèixīn shìjiè.', '"Đôi mắt là cửa sổ tâm hồn", xuyên qua ánh nhìn trong trẻo chân thành của một con người thường có thể thấu tỏ thế giới nội tâm thiện lương thuần khiết của họ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [窗户] (chuānghu) - cửa sổ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '窗户' AND pinyin = 'chuānghu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '窗户'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chuānghu',
      meaning_vi = 'cửa sổ',
      example_hanzi = '房间里有点儿闷热，快把窗户打开通通风吧。',
      example_pinyin = 'Fángjiān lǐ yǒudiǎnr mēnrè, kuài bǎ chuānghu dǎkāi tōngtōngfēng ba.',
      example_vi = 'Trong phòng hơi ngột ngạt nóng nực, mau mở cửa sổ ra cho thoáng gió đi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '房间里有点儿闷热，快把窗户打开通通风吧。', 'Fángjiān lǐ yǒudiǎnr mēnrè, kuài bǎ chuānghu dǎkāi tōngtōngfēng ba.', 'Trong phòng hơi ngột ngạt nóng nực, mau mở cửa sổ ra cho thoáng gió đi.', 'basic', 1),
        (v_id, '擦得一尘不染的明亮玻璃窗户，将冬日午后温暖金黄的阳光尽数迎入室内。', 'Cā de yìchén-bùrǎn de míngliàng bōli chuānghu, jiāng dōngrì wǔhòu wēnnuǎn jīnhuáng de yángguāng jìnshù yíng rù shìnèi.', 'Cửa sổ kính sáng choang lau sạch không tì vết đón trọn ánh nắng vàng óng ấm áp ban trưa mùa đông vào bên trong phòng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [吹] (chuī) - thổi; chia tay (tình cảm); đổ bể (kế hoạch) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '吹' AND pinyin = 'chuī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '吹'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chuī',
      meaning_vi = 'thổi; chia tay (tình cảm); đổ bể (kế hoạch)',
      example_hanzi = '晚饭后漫步在海边，迎面吹来的海风格外凉爽惬意。',
      example_pinyin = 'Wǎnfàn hòu mànbù zài hǎibiān, yíngmiàn chuī lái de hǎifēng géwài liángshuǎng qièyì.',
      example_vi = 'Sau bữa tối đi dạo bờ biển, làn gió biển phả vào mặt mát rượi khoan khoái lạ thường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '晚饭后漫步在海边，迎面吹来的海风格外凉爽惬意。', 'Wǎnfàn hòu mànbù zài hǎibiān, yíngmiàn chuī lái de hǎifēng géwài liángshuǎng qièyì.', 'Sau bữa tối đi dạo bờ biển, làn gió biển phả vào mặt mát rượi khoan khoái lạ thường.', 'basic', 1),
        (v_id, '蜡烛被寿星一口气吹灭，在场的所有亲朋好友纷纷鼓掌送上真挚的生日祝福。', 'Làzhú bèi shòuxīng yì kǒu qì chuī miè, zàichǎng de suǒyǒu qīnpéng-hǎoyǒu fēnfēn gǔzhǎng sòng shàng zhēnzhì de shēngrì zhùfú.', 'Ngọn nến được chủ nhân bữa tiệc sinh nhật thổi tắt chỉ trong một hơi thở, toàn thể bạn bè người thân có mặt đồng loạt vỗ tay gửi lời chúc mừng sinh nhật chân thành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [词语] (cíyǔ) - từ ngữ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '词语' AND pinyin = 'cíyǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '词语'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cíyǔ',
      meaning_vi = 'từ ngữ',
      example_hanzi = '掌握丰富的核心词语是写出优美流畅中文作文的基石。',
      example_pinyin = 'Zhǎngwò fēngfù de héxīn cíyǔ shì xiě chū yōuměi liúchàng Zhōngwén zuòwén de jīshí.',
      example_vi = 'Nắm vững vốn từ ngữ trọng tâm phong phú là nền tảng để viết nên những bài văn tiếng Trung trau chuốt lưu loát.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '掌握丰富的核心词语是写出优美流畅中文作文的基石。', 'Zhǎngwò fēngfù de héxīn cíyǔ shì xiě chū yōuměi liúchàng Zhōngwén zuòwén de jīshí.', 'Nắm vững vốn từ ngữ trọng tâm phong phú là nền tảng để viết nên những bài văn tiếng Trung trau chuốt lưu loát.', 'basic', 1),
        (v_id, '在具体语境中准确辨析近义词语的细微差异，是提升高级汉语水平的关键所在。', 'Zài jùtǐ yǔjìng zhōng zhǔnquè biànxī jìnyì cíyǔ de xìwēi chāyì, shì tíshēng gāojí Hànyǔ shuǐpíng de guānjiàn suǒzài.', 'Phân biệt chuẩn xác sự khác biệt tinh tế của các từ ngữ gần nghĩa trong ngữ cảnh cụ thể là điểm then chốt để nâng cao trình độ Hán ngữ cao cấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [此] (cǐ) - này, đây [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '此' AND pinyin = 'cǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '此'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ',
      pinyin = 'cǐ',
      meaning_vi = 'này, đây',
      example_hanzi = '此地山清水秀，风景如画，吸引了众多远方游客。',
      example_pinyin = 'Cǐ dì shānqīng-shuǐxiù, fēngjǐng-rúhuà, xīyǐn le zhòngduō yuǎnfāng yóukè.',
      example_vi = 'Nơi này non xanh nước biếc, cảnh sắc như tranh vẽ, thu hút đông đảo du khách phương xa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '此地山清水秀，风景如画，吸引了众多远方游客。', 'Cǐ dì shānqīng-shuǐxiù, fēngjǐng-rúhuà, xīyǐn le zhòngduō yuǎnfāng yóukè.', 'Nơi này non xanh nước biếc, cảnh sắc như tranh vẽ, thu hút đông đảo du khách phương xa.', 'basic', 1),
        (v_id, '鉴于此项目的战略重要性，董事会决定追加专项资金支持其技术攻坚。', 'Jiànyú cǐ xiàngmù de zhànlüè zhòngyàoxìng, dǒngshìhuì juédìng zhuījiā zhuānxiàng zījīn zhīchí qí jìshù gōngjiān.', 'Xét đến tầm quan trọng chiến lược của dự án này, hội đồng quản trị quyết định cấp thêm nguồn vốn chuyên biệt để hỗ trợ đột phá công nghệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [此次] (cǐ cì) - lần này [Cụm từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '此次' AND pinyin = 'cǐ cì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '此次'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Cụm từ',
      pinyin = 'cǐ cì',
      meaning_vi = 'lần này',
      example_hanzi = '此次国际文化交流节共有来自五十多个国家的青年代表参加。',
      example_pinyin = 'Cǐ cì guójì wénhuà jiāoliú jié gòng yǒu láizì wǔshí duō gè guójiā de qīngnián dàibiǎo cānjiā.',
      example_vi = 'Ngày hội giao lưu văn hóa quốc tế lần này có tổng cộng đại diện thanh niên đến từ hơn năm mươi quốc gia tham dự.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '此次国际文化交流节共有来自五十多个国家的青年代表参加。', 'Cǐ cì guójì wénhuà jiāoliú jié gòng yǒu láizì wǔshí duō gè guójiā de qīngnián dàibiǎo cānjiā.', 'Ngày hội giao lưu văn hóa quốc tế lần này có tổng cộng đại diện thanh niên đến từ hơn năm mươi quốc gia tham dự.', 'basic', 1),
        (v_id, '此次实地考察调研不仅加深了双方的了解，更为下一阶段的深度经贸合作奠定了坚实的基础。', 'Cǐ cì shídì kǎochá diàoyán bùjǐn jiāshēn le shuāngfāng de liǎojiě, gèng wèi xià yí jiēduàn de shēndù jīngmào hézuò diàndìng le jiānshí de jīchǔ.', 'Chuyến khảo sát nghiên cứu thực địa lần này không chỉ làm sâu sắc thêm hiểu biết của đôi bên mà càng đặt nền móng vững chắc cho sự hợp tác kinh tế thương mại sâu rộng trong giai đoạn tiếp theo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 1: #1001 -> #1100)!', v_count;
END $$;
