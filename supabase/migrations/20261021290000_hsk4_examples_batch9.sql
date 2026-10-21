-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 9 (100 TỪ)
-- Phạm vi: #1801 [现有] (xiànyǒu) -> #1900 [原来] (yuánlái)
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
  -- [现有] (xiànyǒu) - hiện có, có sẵn [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '现有' AND pinyin = 'xiànyǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '现有'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'xiànyǒu',
      meaning_vi = 'hiện có, có sẵn',
      example_hanzi = '学校正在充分利用现有的体育设施，为同学们开展丰富多彩的课外锻炼活动。',
      example_pinyin = 'Xuéxiào zhèngzài chōngfèn lìyòng xiànyǒu de tǐyù shèshī, wèi tóngxuémen kāizhǎn fēngfù-duōcǎi de kèwài duànliàn huódòng.',
      example_vi = 'Nhà trường đang tận dụng đầy đủ các cơ sở vật chất thể thao hiện có, triển khai các hoạt động rèn luyện ngoại khóa phong phú đa dạng cho các bạn học sinh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学校正在充分利用现有的体育设施，为同学们开展丰富多彩的课外锻炼活动。', 'Xuéxiào zhèngzài chōngfèn lìyòng xiànyǒu de tǐyù shèshī, wèi tóngxuémen kāizhǎn fēngfù-duōcǎi de kèwài duànliàn huódòng.', 'Nhà trường đang tận dụng đầy đủ các cơ sở vật chất thể thao hiện có, triển khai các hoạt động rèn luyện ngoại khóa phong phú đa dạng cho các bạn học sinh.', 'basic', 1),
        (v_id, '在推进产业数智化转型升级过程中，传统企业必须立足现有生产要素禀赋，稳步推进智能化设备改造与技术融合。', 'Zài tuījìn chǎnyè shùzhìhuà zhuǎnxíng shēngjí guòchéng zhōng, chuántǒng qǐyè bìxū lìzú xiànyǒu shēngchǎn yàosù bǐngfù, wěnbù tuījìn zhìnénghuà shèbèi gǎizào yǔ jìshù rónghé.', 'Trong quá trình thúc đẩy chuyển đổi nâng cấp số hóa và thông minh hóa ngành nghề, các doanh nghiệp truyền thống bắt buộc phải dựa trên các yếu tố sản xuất hiện có, tiến hành cải tạo thiết bị thông minh và hội nhập kỹ thuật một cách vững chắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [香] (xiāng) - thơm, thơm ngon [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '香' AND pinyin = 'xiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '香'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xiāng',
      meaning_vi = 'thơm, thơm ngon',
      example_hanzi = '院子里桂花盛开，微风吹过，到处都飘散着醉人的清香。',
      example_pinyin = 'Yuànzi lǐ guìhuā shèngkāi, wēifēng chuī guò, dàochù dōu piāosànzhe zuìrén de qīngxiāng.',
      example_vi = 'Hoa quế trong sân nở rộ, làn gió nhẹ thoảng qua, khắp nơi đều bay tỏa hương thơm ngát mê đắm lòng người.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '院子里桂花盛开，微风吹过，到处都飘散着醉人的清香。', 'Yuànzi lǐ guìhuā shèngkāi, wēifēng chuī guò, dàochù dōu piāosànzhe zuìrén de qīngxiāng.', 'Hoa quế trong sân nở rộ, làn gió nhẹ thoảng qua, khắp nơi đều bay tỏa hương thơm ngát mê đắm lòng người.', 'basic', 1),
        (v_id, '中华传统烹饪讲究色香味俱佳，通过精准掌握火候与香料搭配，使每一道佳肴都散发出诱人独特的醇厚浓香。', 'Zhōnghuá chuántǒng pēngrèn jiǎngjiu sè-xiāng-wèi jùjiā, tōngguò jīngzhǔn zhǎngwò huǒhou yǔ xiāngliào dāpèi, shǐ měi yí dào jiāyáo dōu sànfā chū yòurén dútè de chúnhòu nóngxiāng.', 'Nghệ thuật nấu ăn truyền thống Trung Hoa coi trọng sắc hương vị vẹn toàn, thông qua việc nắm bắt chuẩn xác nhiệt độ lửa và phối hợp gia vị, khiến từng món ăn ngon đều tỏa ra hương thơm nồng đượm độc đáo quyến rũ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [相比] (xiāngbǐ) - so sánh, so với [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '相比' AND pinyin = 'xiāngbǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '相比'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xiāngbǐ',
      meaning_vi = 'so sánh, so với',
      example_hanzi = '与去年同期相比，今年我国新能源汽车的产销量有了大幅度的跨越式增长。',
      example_pinyin = 'Yǔ qùnián tóngqī xiāngbǐ, jīnnián wǒ guó xīnnéngyuán qìchē de chǎn-xiāoliàng yǒu le dàfúdù de kuàyuèshì zēngzhǎng.',
      example_vi = 'So với cùng kỳ năm ngoái, sản lượng và lượng tiêu thụ xe năng lượng mới của nước ta năm nay đã có sự tăng trưởng nhảy vọt với biên độ lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '与去年同期相比，今年我国新能源汽车的产销量有了大幅度的跨越式增长。', 'Yǔ qùnián tóngqī xiāngbǐ, jīnnián wǒ guó xīnnéngyuán qìchē de chǎn-xiāoliàng yǒu le dàfúdù de kuàyuèshì zēngzhǎng.', 'So với cùng kỳ năm ngoái, sản lượng và lượng tiêu thụ xe năng lượng mới của nước ta năm nay đã có sự tăng trưởng nhảy vọt với biên độ lớn.', 'basic', 1),
        (v_id, '相比于传统的粗放型经济增长方式，创新驱动的高质量发展模式更加注重资源节约与生态环境保护。', 'Xiāngbǐ yú chuántǒng de cūfàngxíng jīngjì zēngzhǎng fāngshì, chuàngxīn qūdòng de gāozhìliàng fāzhǎn móshì gèngjiā zhùzhòng zīyuán jiéyuē yǔ shēngtài huánjìng bǎohù.', 'So với phương thức tăng trưởng kinh tế thô sơ theo diện rộng truyền thống, mô hình phát triển chất lượng cao do đổi mới dẫn dắt càng chú trọng hơn đến việc tiết kiệm tài nguyên và bảo vệ môi trường sinh thái.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [相反] (xiāngfǎn) - ngược lại, tương phản [Tính từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '相反' AND pinyin = 'xiāngfǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '相反'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Liên từ',
      pinyin = 'xiāngfǎn',
      meaning_vi = 'ngược lại, tương phản',
      example_hanzi = '这两位双胞胎兄弟不仅外貌长得很像，性格却截然相反。',
      example_pinyin = 'Zhè liǎng wèi shuāngbāotāi xiōngdì bùjǐn wàimào zhǎng de hěn xiàng, xìnggé què jiérán xiāngfǎn.',
      example_vi = 'Hai anh em sinh đôi này không chỉ diện mạo trông rất giống nhau, nhưng tính cách lại hoàn toàn trái ngược.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这两位双胞胎兄弟不仅外貌长得很像，性格却截然相反。', 'Zhè liǎng wèi shuāngbāotāi xiōngdì bùjǐn wàimào zhǎng de hěn xiàng, xìnggé què jiérán xiāngfǎn.', 'Hai anh em sinh đôi này không chỉ diện mạo trông rất giống nhau, nhưng tính cách lại hoàn toàn trái ngược.', 'basic', 1),
        (v_id, '面对严峻的外部经济挑战，企业不仅没有缩减研发经费预算，相反却持续加大了在前沿核心技术领域的战略性投资。', 'Miànduì yánjùn de wàibù jīngjì tiǎozhàn, qǐyè bùjǐn méiyǒu suōjiǎn yánfā jīngfèi yùsuàn, xiāngfǎn què chíxù jiàdà le zài qiányán héxīn jìshù lǐngyù de zhànlüèxìng tóuzī.', 'Đối mặt trước những thách thức kinh tế bên ngoài nghiêm trọng, doanh nghiệp không những không cắt giảm dự toán kinh phí nghiên cứu phát triển, ngược lại còn tiếp tục tăng cường đầu tư mang tính chiến lược trong các lĩnh vực công nghệ cốt lõi mũi nhọn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [相互] (xiānghù) - lẫn nhau, tương hỗ, cùng nhau [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '相互' AND pinyin = 'xiānghù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '相互'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'xiānghù',
      meaning_vi = 'lẫn nhau, tương hỗ, cùng nhau',
      example_hanzi = '在日常团队协作中，成员之间应当相互信任、相互支持，共同攻克各项业务难关。',
      example_pinyin = 'Zài rìcháng tuánduì xiézuò zhōng, chéngyuán zhījiān yīngdāng xiānghù xìnrèn, xiānghù zhīchí, gòngtóng gōngkè gè xiàng yèwù nánguān.',
      example_vi = 'Trong sự cộng tác nhóm hàng ngày, giữa các thành viên nên tin tưởng lẫn nhau, hỗ trợ lẫn nhau, cùng nhau vượt qua các cửa ải khó khăn của công việc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在日常团队协作中，成员之间应当相互信任、相互支持，共同攻克各项业务难关。', 'Zài rìcháng tuánduì xiézuò zhōng, chéngyuán zhījiān yīngdāng xiānghù xìnrèn, xiānghù zhīchí, gòngtóng gōngkè gè xiàng yèwù nánguān.', 'Trong sự cộng tác nhóm hàng ngày, giữa các thành viên nên tin tưởng lẫn nhau, hỗ trợ lẫn nhau, cùng nhau vượt qua các cửa ải khó khăn của công việc.', 'basic', 1),
        (v_id, '国家间在处理国际经贸争端时，唯有坚持相互尊重主权与核心关切、平等协商，才能达成互利共赢的经贸协定。', 'Guójiā jiān zài chǔlǐ guójì jīng-mào zhēngduān shí, wéiyǒu jiānchí xiānghù zūnzhòng zhǔquán yǔ héxīn guānqiè, píngděng xiéshāng, cái néng dáchéng hùlì-gòngyíng de jīng-mào xiédìng.', 'Giữa các quốc gia khi xử lý tranh chấp kinh tế thương mại quốc tế, chỉ có kiên trì tôn trọng lẫn nhau về chủ quyền và quan ngại cốt lõi, hiệp thương bình đẳng thì mới có thể đạt được các hiệp định kinh tế thương mại cùng có lợi cùng thắng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [相同] (xiāngtóng) - giống nhau, như nhau, tương đồng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '相同' AND pinyin = 'xiāngtóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '相同'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xiāngtóng',
      meaning_vi = 'giống nhau, như nhau, tương đồng',
      example_hanzi = '我和室友有着相同的兴趣爱好，平时都特别喜欢踢足球和听古典音乐。',
      example_pinyin = 'Wǒ hé shìyǒu yǒuzhe xiāngtóng de xìngqù àihào, píngshí dōu tèbié xǐhuan tī zúqiú hé tīng gǔdiǎn yīnyuè.',
      example_vi = 'Tôi và bạn cùng phòng có sở thích giống nhau, ngày thường đều rất thích đá bóng và nghe nhạc cổ điển.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我和室友有着相同的兴趣爱好，平时都特别喜欢踢足球和听古典音乐。', 'Wǒ hé shìyǒu yǒuzhe xiāngtóng de xìngqù àihào, píngshí dōu tèbié xǐhuan tī zúqiú hé tīng gǔdiǎn yīnyuè.', 'Tôi và bạn cùng phòng có sở thích giống nhau, ngày thường đều rất thích đá bóng và nghe nhạc cổ điển.', 'basic', 1),
        (v_id, '在相同外部宏观经济环境下，具备核心技术壁垒与敏捷组织治理能力的企业展现出了远超行业平均水平的强劲抗风险能力。', 'Zài xiāngtóng wàibù hóngguān jīngjì huánjìng xià, jùbèi héxīn jìshù bìlěi yǔ mǐnjié zǔzhī zhìlǐ nénglì de qǐyè zhǎnxiàn chū le yuǎn chāo hángyè píngjūn shuǐpíng de qiángjìng kàng-fēngxiǎn nénglì.', 'Dưới cùng một môi trường kinh tế vĩ mô bên ngoài, những doanh nghiệp sở hữu rào cản kỹ thuật cốt lõi và năng lực quản trị tổ chức linh hoạt đã thể hiện năng lực chống chịu rủi ro mạnh mẽ vượt xa mức bình quân ngành nghề.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [详细] (xiángxì) - chi tiết, tường tận, cặn kẽ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '详细' AND pinyin = 'xiángxì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '详细'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xiángxì',
      meaning_vi = 'chi tiết, tường tận, cặn kẽ',
      example_hanzi = '请您在合同签署前详细阅读每一条权利与义务条款。',
      example_pinyin = 'Qǐng nín zài hétong qiānshǔ qián xiángxì yuèdú měi yì tiáo quánlì yǔ yìwù tiáokuǎn.',
      example_vi = 'Xin quý khách trước khi ký kết hợp đồng hãy đọc kỹ chi tiết từng điều khoản quyền lợi và nghĩa vụ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请您在合同签署前详细阅读每一条权利与义务条款。', 'Qǐng nín zài hétong qiānshǔ qián xiángxì yuèdú měi yì tiáo quánlì yǔ yìwù tiáokuǎn.', 'Xin quý khách trước khi ký kết hợp đồng hãy đọc kỹ chi tiết từng điều khoản quyền lợi và nghĩa vụ.', 'basic', 1),
        (v_id, '专家评审委员会对该项国家重大科技基础设施建设项目的可行性研究报告进行了全面详细的综合论证与质询。', 'Zhuānjiā píngshěn wěiyuánhuì duì gāi xiàng guójiā zhòngdà kējì jīchǔ shèshī jiànshè xiàngmù de kěxíngxìng yánjiū bàogào jìnxíng le quánmiàn xiángxì de zōnghé lùnzhèng yǔ zhìxún.', 'Hội đồng thẩm định chuyên gia đã tiến hành chất vấn và chứng minh tổng hợp toàn diện chi tiết đối với báo cáo nghiên cứu tính khả thi của dự án xây dựng cơ sở hạ tầng khoa học công nghệ trọng điểm cấp quốc gia này.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [响] (xiǎng) - vang lên, kêu; to, rõ ràng [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '响' AND pinyin = 'xiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '响'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'xiǎng',
      meaning_vi = 'vang lên, kêu; to, rõ ràng',
      example_hanzi = '清脆的下课铃声响了，校园操场上顿时充满了同学们欢快的笑声。',
      example_pinyin = 'Qīngcuì de xiàkè língshēng xiǎng le, xiàoyuán cāochǎng shang dùnshí chōngmǎn le tóngxuémen huānkuài de xiàoshēng.',
      example_vi = 'Tiếng chuông tan học trong trẻo vang lên, sân thể dục nhà trường lập tức tràn ngập tiếng cười nói vui tươi của các bạn học sinh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清脆的下课铃声响了，校园操场上顿时充满了同学们欢快的笑声。', 'Qīngcuì de xiàkè língshēng xiǎng le, xiàoyuán cāochǎng shang dùnshí chōngmǎn le tóngxuémen huānkuài de xiàoshēng.', 'Tiếng chuông tan học trong trẻo vang lên, sân thể dục nhà trường lập tức tràn ngập tiếng cười nói vui tươi của các bạn học sinh.', 'basic', 1),
        (v_id, '历史的警钟必须长鸣，我们要牢记历史经验教训，让和平发展的时代强音响彻寰宇。', 'Lìshǐ de jǐngzhōng bìxū cháng míng, wǒmen yào láojì lìshǐ jīngyàn jiàoxun, ràng hépíng fāzhǎn de shídài qiángyīn xiǎng chè huányǔ.', 'Hồi chuông cảnh báo của lịch sử phải luôn gióng lên, chúng ta cần ghi nhớ bài học kinh nghiệm lịch sử, để âm vang mạnh mẽ của thời đại hòa bình và phát triển vang rền khắp cõi trần gian.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [想法] (xiǎngfǎ) - cách nghĩ, ý tưởng, quan điểm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '想法' AND pinyin = 'xiǎngfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '想法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiǎngfǎ',
      meaning_vi = 'cách nghĩ, ý tưởng, quan điểm',
      example_hanzi = '如果你对这次班级活动有什么新的想法，随时欢迎找班长一起交流讨论。',
      example_pinyin = 'Rúguǒ nǐ duì zhè cì bānjí huódòng yǒu shénme xīn de xiǎngfǎ, suíshí huānyíng zhǎo bānzhǎng yìqǐ jiāoliú tǎolùn.',
      example_vi = 'Nếu bạn có cách nghĩ hay ý tưởng mới nào về hoạt động lớp lần này, luôn hoan nghênh tìm lớp trưởng cùng trao đổi thảo luận.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如果你对这次班级活动有什么新的想法，随时欢迎找班长一起交流讨论。', 'Rúguǒ nǐ duì zhè cì bānjí huódòng yǒu shénme xīn de xiǎngfǎ, suíshí huānyíng zhǎo bānzhǎng yìqǐ jiāoliú tǎolùn.', 'Nếu bạn có cách nghĩ hay ý tưởng mới nào về hoạt động lớp lần này, luôn hoan nghênh tìm lớp trưởng cùng trao đổi thảo luận.', 'basic', 1),
        (v_id, '在激烈的市场营销策划竞争中，唯有敢于打破常规思维定式、提出极具颠覆性的创新想法，才能在同质化竞争中脱颖而出。', 'Zài jīliè de shìchǎng yíngxiāo cèhuà jìngzhēng zhōng, wéiyǒu gǎnyú dǎpò chángguī sīwéi dìngshì, tíchū jí jù diānfùxìng de chuàngxīn xiǎngfǎ, cái néng zài tóngzhìhuà jìngzhēng zhōng tuōyǐng-érchū.', 'Trong cuộc cạnh tranh lập kế hoạch tiếp thị thị trường khốc liệt, chỉ có dám phá vỡ lối mòn tư duy thông thường, đưa ra những ý tưởng đổi mới mang tính đảo lộn thì mới có thể nổi trội vươn lên giữa cuộc cạnh tranh đồng nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [项] (xiàng) - hạng mục, điều, khoản [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '项' AND pinyin = 'xiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '项'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'xiàng',
      meaning_vi = 'hạng mục, điều, khoản',
      example_hanzi = '为切实减轻中小学生过重课业负担，教育部门联合出台了多项切实可行的减负举措。',
      example_pinyin = 'Wèi qièshí jiǎnqīng zhōng-xiǎoxuéshēng guòzhòng kèyè fùdān, jiàoyù bùmén liánhé chūtái le duō xiàng qièshí-kěxíng de jiǎnfù jǔcuò.',
      example_vi = 'Nhằm thiết thực giảm bớt gánh nặng bài vở quá sức của học sinh tiểu học và trung học, các ban ngành giáo dục đã liên hiệp ban hành nhiều biện pháp giảm tải thiết thực khả thi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为切实减轻中小学生过重课业负担，教育部门联合出台了多项切实可行的减负举措。', 'Wèi qièshí jiǎnqīng zhōng-xiǎoxuéshēng guòzhòng kèyè fùdān, jiàoyù bùmén liánhé chūtái le duō xiàng qièshí-kěxíng de jiǎnfù jǔcuò.', 'Nhằm thiết thực giảm bớt gánh nặng bài vở quá sức của học sinh tiểu học và trung học, các ban ngành giáo dục đã liên hiệp ban hành nhiều biện pháp giảm tải thiết thực khả thi.', 'basic', 1),
        (v_id, '国家科技奖励大会对在量子信息、人工智能以及航空航天核心关键技术攻关中取得重大突破的数十项科技成果进行了隆重表彰。', 'Guójiā Kējì Jiǎnglì Dàhuì duì zài liàngzǐ xìnxī, réngōng zhìnéng yǐjí hángkōng hángtiān héxīn guānjiàn jìshù gōngguān zhōng qǔdé zhòngdà tūpò de shùshí xiàng kējì chéngguǒ jìnxíng le lóngzhòng biǎozhāng.', 'Đại hội Khen thưởng Khoa học Công nghệ Quốc gia đã long trọng biểu dương mấy chục hạng mục thành quả khoa học công nghệ đạt được đột phá to lớn trong công phá các công nghệ then chốt cốt lõi về thông tin lượng tử, trí tuệ nhân tạo và hàng không vũ trụ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [消息] (xiāoxi) - tin tức, thông tin [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '消息' AND pinyin = 'xiāoxi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '消息'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiāoxi',
      meaning_vi = 'tin tức, thông tin',
      example_hanzi = '听到同学们都顺利通过了汉语水平考试的好消息，大家都兴奋地欢呼起来。',
      example_pinyin = 'Tīngdào tóngxuémen dōu shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì de hǎo xiāoxi, dàjiā dōu xīngfèn de huānhū qǐlai.',
      example_vi = 'Nghe được tin vui các bạn học sinh đều thuận lợi vượt qua kỳ thi năng lực Hán ngữ HSK, mọi người đều phấn khích reo hò lên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到同学们都顺利通过了汉语水平考试的好消息，大家都兴奋地欢呼起来。', 'Tīngdào tóngxuémen dōu shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì de hǎo xiāoxi, dàjiā dōu xīngfèn de huānhū qǐlai.', 'Nghe được tin vui các bạn học sinh đều thuận lợi vượt qua kỳ thi năng lực Hán ngữ HSK, mọi người đều phấn khích reo hò lên.', 'basic', 1),
        (v_id, '在互联网新媒体时代，权威官方部门必须第一时间发布重大突发事件的权威调查消息，以挤压网络虚假不实谣言的滋生空间。', 'Zài hùliánwǎng xīn méitǐ shídài, quánwēi guānfāng bùmén bìxū dì-yī shíjiān fābù zhòngdà tūfā shìjiàn de quánwēi diàochá xiāoxi, yǐ jǐyā wǎngluò xūjiǎ bùshí yáoyán de zīshēng kōngjiān.', 'Trong thời đại truyền thông mới Internet, các cơ quan chức năng có thẩm quyền bắt buộc phải phát đi thông tin tin tức điều tra chuẩn xác về các sự cố bất ngờ trọng đại ngay thời khắc đầu tiên để thu hẹp không gian sinh sôi của những tin đồn sai sự thật trên mạng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [小吃] (xiǎochī) - đồ ăn vặt, món ăn nhẹ đặc sản [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '小吃' AND pinyin = 'xiǎochī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '小吃'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiǎochī',
      meaning_vi = 'đồ ăn vặt, món ăn nhẹ đặc sản',
      example_hanzi = '来到成都旅游，一定要去宽窄巷子品尝一下担担面、龙抄手等特色传统小吃。',
      example_pinyin = 'Lái dào Chéngdū lǚyóu, yídìng yào qù Kuānzhǎi Xiàngzi pǐncháng yíxià dàndànmiàn, lóngchāoshǒu děng tèsè chuántǒng xiǎochī.',
      example_vi = 'Đến Thành Đô du lịch, nhất định phải tới ngõ Rộng Hẹp thưởng thức các món ăn vặt đặc sản truyền thống như mì Đan Đan, sủi cảo Long sao thủ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '来到成都旅游，一定要去宽窄巷子品尝一下担担面、龙抄手等特色传统小吃。', 'Lái dào Chéngdū lǚyóu, yídìng yào qù Kuānzhǎi Xiàngzi pǐncháng yíxià dàndànmiàn, lóngchāoshǒu děng tèsè chuántǒng xiǎochī.', 'Đến Thành Đô du lịch, nhất định phải tới ngõ Rộng Hẹp thưởng thức các món ăn vặt đặc sản truyền thống như mì Đan Đan, sủi cảo Long sao thủ.', 'basic', 1),
        (v_id, '特色地方风味小吃是传承中华优秀饮食文脉的重要载体，政府积极扶持地方传统小吃制作技艺申报各级非物质文化遗产名录。', 'Tèsè dìfāng fēngwèi xiǎochī shì chuánchéng Zhōnghuá yōuxiù yǐnshí wénmài de zhòngyào zàitǐ, zhèngfǔ jījí fúchí dìfāng chuántǒng xiǎochī zhìzuò jìyì shēnbào gè jí fēiwùzhì wénhuà yíchǎn mínglù.', 'Các món ăn nhẹ đặc sản phong vị địa phương là cầu nối quan trọng kế thừa mạch văn hóa ẩm thực ưu tú Trung Hoa, chính quyền tích cực hỗ trợ kỹ nghệ chế biến món ăn vặt truyền thống địa phương đăng ký vào danh mục di sản văn hóa phi vật thể các cấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [小伙子] (xiǎohuǒzi) - chàng trai, chàng thanh niên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '小伙子' AND pinyin = 'xiǎohuǒzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '小伙子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiǎohuǒzi',
      meaning_vi = 'chàng trai, chàng thanh niên',
      example_hanzi = '那个身材高大阳光帅气的小伙子是大学篮球队的核心主力队员。',
      example_pinyin = 'Nàge shēncái gāodà yángguāng shuàiqi de xiǎohuǒzi shì dàxué lánqiúduì de héxīn zhǔlì duìyuán.',
      example_vi = 'Chàng trai cao ráo sáng sủa đẹp trai đằng kia là cầu thủ chủ lực nòng cốt của đội bóng rổ trường đại học.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '那个身材高大阳光帅气的小伙子是大学篮球队的核心主力队员。', 'Nàge shēncái gāodà yángguāng shuàiqi de xiǎohuǒzi shì dàxué lánqiúduì de héxīn zhǔlì duìyuán.', 'Chàng trai cao ráo sáng sủa đẹp trai đằng kia là cầu thủ chủ lực nòng cốt của đội bóng rổ trường đại học.', 'basic', 1),
        (v_id, '在抢险救援救灾一线，这群风华正茂的年轻小伙子挺身而出、向险而行，用无畏青春担当筑起坚不可摧的生命防护长堤。', 'Zài qiǎngxiǎn jiùyuán jiùzāi yíxiàn, zhè qún fēnghuá-zhèngmào de niánqīng xiǎohuǒzi tǐngshēn-érchū, xiàng xiǎn ér xíng, yòng wúwèi qīngchūn dāndāng zhù qǐ jiānbùkěcuī de shēngmìng fánghù chángdī.', 'Nơi tuyến đầu cứu nạn cứu hộ ứng phó thiên tai, nhóm chàng thanh niên trẻ trung tràn trề sức sống này đã hiên ngang bước tới, dấn thân vào hiểm nguy, dùng sự dũng cảm gánh vác của tuổi thanh xuân xây nên con đê dài phòng hộ sự sống kiên cố không thể phá hủy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [小说] (xiǎoshuō) - tiểu thuyết [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '小说' AND pinyin = 'xiǎoshuō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '小说'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiǎoshuō',
      meaning_vi = 'tiểu thuyết',
      example_hanzi = '长假期间他呆在书房里一口气读完了两本精彩的历史长篇小说。',
      example_pinyin = 'Chángjià qījiān tā dāi zài shūfáng lǐ yì kǒuqì dú wán le liǎng běn jīngcǎi de lìshǐ chángpiān xiǎoshuō.',
      example_vi = 'Trong kỳ nghỉ dài anh ấy ở lại phòng đọc sách đọc một mạch xong hai cuốn tiểu thuyết dài tập lịch sử đặc sắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '长假期间他呆在书房里一口气读完了两本精彩的历史长篇小说。', 'Chángjià qījiān tā dāi zài shūfáng lǐ yì kǒuqì dú wán le liǎng běn jīngcǎi de lìshǐ chángpiān xiǎoshuō.', 'Trong kỳ nghỉ dài anh ấy ở lại phòng đọc sách đọc một mạch xong hai cuốn tiểu thuyết dài tập lịch sử đặc sắc.', 'basic', 1),
        (v_id, '中国古典四大名著长篇小说凭借跌宕起伏的宏大叙事与深刻的人性艺术剖析，成为全人类世界文学宝库中永放光芒的璀璨明珠。', 'Zhōngguó gǔdiǎn sì dà míngzhù chángpiān xiǎoshuō píngjiè diēdàng-qǐfú de hóngdà xùshì yǔ shēnkè de rénxìng yìshù pōuxī, chéngwéi quán rénlèi shìjiè wénxué bǎokù zhōng yǒng fàng guāngmáng de cuǐcàn míngzhū.', 'Bốn đại danh tác tiểu thuyết trường thiên cổ điển Trung Hoa nhờ vào lối tự sự hùng vĩ nhấp nhô lôi cuốn cùng phân tích nghệ thuật nhân tính sâu sắc, đã trở thành viên minh châu sáng ngời mãi tỏa hào quang trong kho tàng văn học thế giới của toàn nhân loại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [小组] (xiǎozǔ) - tổ nhỏ, nhóm nhỏ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '小组' AND pinyin = 'xiǎozǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '小组'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiǎozǔ',
      meaning_vi = 'tổ nhỏ, nhóm nhỏ',
      example_hanzi = '为了完成这次历史调研报告，全班同学自愿分成了五个兴趣合作小组。',
      example_pinyin = 'Wèile wánchéng zhè cì lìshǐ diàoyán bàogào, quánbān tóngxué zìyuàn fēnchéng le wǔ gè xìngqù hézuò xiǎozǔ.',
      example_vi = 'Để hoàn thành bản báo cáo nghiên cứu lịch sử lần này, cả lớp đã tự nguyện chia thành năm nhóm nhỏ hợp tác theo sở thích.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了完成这次历史调研报告，全班同学自愿分成了五个兴趣合作小组。', 'Wèile wánchéng zhè cì lìshǐ diàoyán bàogào, quánbān tóngxué zìyuàn fēnchéng le wǔ gè xìngqù hézuò xiǎozǔ.', 'Để hoàn thành bản báo cáo nghiên cứu lịch sử lần này, cả lớp đã tự nguyện chia thành năm nhóm nhỏ hợp tác theo sở thích.', 'basic', 1),
        (v_id, '国务院成立跨部门重大科技攻关专项领导小组，统筹推进国家战略科技力量布局与体制机制创新。', 'Guówùyuàn chénglì kuà-bùmén zhòngdà kējì gōngguān zhuānxiàng lǐngdǎo xiǎozǔ, tǒngchóu tuījìn guójiā zhànlüè kējì lìliàng bùjú yǔ tǐzhì jīzhì chuàngxīn.', 'Quốc vụ viện thành lập tổ lãnh đạo chuyên trách đột phá khoa học công nghệ trọng đại liên ngành, điều phối tổng thể việc bố trí lực lượng khoa học công nghệ chiến lược quốc gia và đổi mới thể chế cơ chế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [效果] (xiàoguǒ) - hiệu quả, kết quả [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '效果' AND pinyin = 'xiàoguǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '效果'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiàoguǒ',
      meaning_vi = 'hiệu quả, kết quả',
      example_hanzi = '坚持每天早晨慢跑半小时，对增强心肺功能有非常显著的良好效果。',
      example_pinyin = 'Jiānchí měi tiān zǎochén mànpǎo bàn xiǎoshí, duì zēngqiáng xīnfèi gōngnéng yǒu fēicháng xiǎnzhù de liánghǎo xiàoguǒ.',
      example_vi = 'Kiên trì mỗi sáng sớm chạy chậm nửa tiếng có hiệu quả tốt rất rõ rệt đối với việc tăng cường chức năng tim phổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '坚持每天早晨慢跑半小时，对增强心肺功能有非常显著的良好效果。', 'Jiānchí měi tiān zǎochén mànpǎo bàn xiǎoshí, duì zēngqiáng xīnfèi gōngnéng yǒu fēicháng xiǎnzhù de liánghǎo xiàoguǒ.', 'Kiên trì mỗi sáng sớm chạy chậm nửa tiếng có hiệu quả tốt rất rõ rệt đối với việc tăng cường chức năng tim phổi.', 'basic', 1),
        (v_id, '国家通过推行大规模增值税留抵退税与专项研发加计扣除政策，对激发科技实体企业创新活力产生了极为显著的乘数带动效果。', 'Guójiā tōngguò tuīxíng dà guīmó zēngzhíshuì liúdǐ tuìshuì yǔ zhuānxiàng yánfā jiājì kòuchú zhèngcè, duì jīfā kējì shítǐ qǐyè chuàngxīn huólì chǎnshēng le jíwéi xiǎnzhù de chéngshù dàidòng xiàoguǒ.', 'Nhà nước thông qua việc áp dụng chính sách hoàn thuế giá trị gia tăng lũy kế quy mô lớn và khấu trừ bổ sung chi phí nghiên cứu phát triển chuyên biệt, đã tạo ra hiệu ứng đòn bẩy cấp số nhân vô cùng rõ rệt đối với việc khơi dậy sức sống đổi mới của các doanh nghiệp thực thể công nghệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [笑话] (xiàohua) - truyện cười, chuyện cười; chê cười, trò cười [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '笑话' AND pinyin = 'xiàohua'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '笑话'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'xiàohua',
      meaning_vi = 'truyện cười, chuyện cười; chê cười, trò cười',
      example_hanzi = '班长在联欢会上讲了几个幽默风趣的小笑话，逗得大家捧腹大笑。',
      example_pinyin = 'Bānzhǎng zài liánhuānhuì shang jiǎng le jǐ gè yōumò fēngqù de xiǎo xiàohua, dòu de dàjiā pěngfù-dàxiào.',
      example_vi = 'Lớp trưởng trong buổi liên hoan đã kể vài mẩu chuyện cười nhỏ hài hước thú vị, chọc cho mọi người cười bò vỡ bụng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '班长在联欢会上讲了几个幽默风趣的小笑话，逗得大家捧腹大笑。', 'Bānzhǎng zài liánhuānhuì shang jiǎng le jǐ gè yōumò fēngqù de xiǎo xiàohua, dòu de dàjiā pěngfù-dàxiào.', 'Lớp trưởng trong buổi liên hoan đã kể vài mẩu chuyện cười nhỏ hài hước thú vị, chọc cho mọi người cười bò vỡ bụng.', 'basic', 1),
        (v_id, '在严肃的外交谈判与商业法律公文中，必须严格审查语法规范与术语准确性，切忌因低级文字疏漏贻笑大方闹出国际笑话。', 'Zài yánsù de wàijiāo tánpàn yǔ shāngyè fǎlǜ gōngwén zhōng, bìxū yángé shěnchá yǔfǎ guīfàn yǔ shùyǔ zhǔnquèxìng, qièjì yīn dījí wénzì shūlòu yíxiào-dàfāng nào chū guójì xiàohua.', 'Trong văn bản đàm phán ngoại giao và công văn pháp luật thương mại nghiêm túc, bắt buộc phải thẩm tra nghiêm ngặt quy chuẩn ngữ pháp và độ chuẩn xác của thuật ngữ, tránh vì sơ sót câu chữ sơ đẳng mà để người đời chê cười gây nên trò cười quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [血] (xiě) - máu, huyết [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '血' AND pinyin = 'xiě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '血'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiě',
      meaning_vi = 'máu, huyết',
      example_hanzi = '他不小心划破了手指，鲜红的血立刻从伤口渗了出来。',
      example_pinyin = 'Tā bù xiǎoxīn huápò le shǒuzhǐ, xiānhóng de xiě lìkè cóng shāngkǒu shèn le chūlái.',
      example_vi = 'Anh ấy không may làm trầy ngón tay, máu tươi đỏ thắm lập tức rỉ ra từ vết thương.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他不小心划破了手指，鲜红的血立刻从伤口渗了出来。', 'Tā bù xiǎoxīn huápò le shǒuzhǐ, xiānhóng de xiě lìkè cóng shāngkǒu shèn le chūlái.', 'Anh ấy không may làm trầy ngón tay, máu tươi đỏ thắm lập tức rỉ ra từ vết thương.', 'basic', 1),
        (v_id, '无偿献血不仅是拯救临床危重病患生命的崇高人道主义奉献善举，也是一座城市精神文明水平的重要体现。', 'Wúcháng xiànxiě bùjǐn shì zhěngjiù línchuáng wēizhòng bìnghuàn shēngmìng de chónggāo réndàozhǔyì fèngxiàn shànjǔ, yě shì yí zuò chéngshì jīngshén wénmíng shuǐpíng de zhòngyào tǐxiàn.', 'Hiến máu tình nguyện không chỉ là nghĩa cử nhân đạo cao đẹp cống hiến cứu sống tính mạng người bệnh nguy kịch trong điều trị lâm sàng, mà còn là biểu hiện quan trọng về trình độ văn minh tinh thần của một thành phố.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [心] (xīn) - tim, lòng, tâm trí [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '心' AND pinyin = 'xīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xīn',
      meaning_vi = 'tim, lòng, tâm trí',
      example_hanzi = '听到医生的检查结果一切正常，妈妈悬着的一颗心终于踏实地放了下来。',
      example_pinyin = 'Tīngdào yīshēng de jiǎnchá jiéguǒ yíqiè zhèngcháng, māma xuánzhe de yì kē xīn zhōngyú tàshi de fàng le xiàlái.',
      example_vi = 'Nghe bác sĩ thông báo kết quả khám mọi thứ đều bình thường, trái tim đang thấp thỏm của mẹ cuối cùng cũng yên lòng buông xuống được.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到医生的检查结果一切正常，妈妈悬着的一颗心终于踏实地放了下来。', 'Tīngdào yīshēng de jiǎnchá jiéguǒ yíqiè zhèngcháng, māma xuánzhe de yì kē xīn zhōngyú tàshi de fàng le xiàlái.', 'Nghe bác sĩ thông báo kết quả khám mọi thứ đều bình thường, trái tim đang thấp thỏm của mẹ cuối cùng cũng yên lòng buông xuống được.', 'basic', 1),
        (v_id, '医者仁心，广大医务工作者将保障人民身体健康与生命安全的崇高初心化作日夜坚守救死扶伤的无私奉献。', 'Yīzhě rénxīn, guǎngdà yīwù gōngzuòzhě jiāng bǎozhàng rénmín shēntǐ jiànkāng yǔ shēngmìng ānquán de chónggāo chūxīn huà zuò rì yè jiānshǒu jiùsǐ-fúshāng de wúsī fèngxiàn.', 'Lương y như từ mẫu, đội ngũ cán bộ y tế đông đảo đã biến tấm lòng ban đầu cao cả bảo vệ sức khỏe thể chất và an toàn tính mạng của nhân dân thành sự cống hiến quên mình ngày đêm bám trụ cứu người chữa bệnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [辛苦] (xīnkǔ) - vất vả, cực nhọc [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '辛苦' AND pinyin = 'xīnkǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '辛苦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xīnkǔ',
      meaning_vi = 'vất vả, cực nhọc',
      example_hanzi = '环卫工人们每天清晨迎着寒风清扫城市街道，工作十分辛苦。',
      example_pinyin = 'Huánwèi gōngrénmen měi tiān qīngchén yíngzhe hánfēng qīngsǎo chéngshì jiēdào, gōngzuò shífēn xīnkǔ.',
      example_vi = 'Các công nhân vệ sinh môi trường mỗi sáng sớm đón gió lạnh quét dọn đường phố đô thị, công việc vô cùng vất vả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '环卫工人们每天清晨迎着寒风清扫城市街道，工作十分辛苦。', 'Huánwèi gōngrénmen měi tiān qīngchén yíngzhe hánfēng qīngsǎo chéngshì jiēdào, gōngzuò shífēn xīnkǔ.', 'Các công nhân vệ sinh môi trường mỗi sáng sớm đón gió lạnh quét dọn đường phố đô thị, công việc vô cùng vất vả.', 'basic', 1),
        (v_id, '全体医护人员与科研人员夜以继日奋战在救治与疫苗研发一线，用长年累月的辛勤付出守护着人民群众的生命安全与身体健康。', 'Quántǐ yīhù rényuán yǔ kēyán rényuán yèyǐjìrì fènzhàn zài jiùzhì yǔ yìmiáo yánfā yíxiàn, yòng chángnián-lěiyuè de xīnqín fùchū shǒuhùzhe rénmín qúnzhòng de shēngmìng ānquán yǔ shēntǐ jiànkāng.', 'Toàn thể đội ngũ y bác sĩ và cán bộ nghiên cứu ngày đêm chiến đấu nơi tuyến đầu điều trị và nghiên cứu chế tạo vắc-xin, dùng sự cống hiến vất vả năm này qua tháng khác bảo vệ an toàn tính mạng và sức khỏe thể chất cho quần chúng nhân dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [心情] (xīnqíng) - tâm trạng, tâm tình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '心情' AND pinyin = 'xīnqíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '心情'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xīnqíng',
      meaning_vi = 'tâm trạng, tâm tình',
      example_hanzi = '周末漫步在繁花盛开的公园湖畔，微风吹拂，心情感到格外舒畅愉悦。',
      example_pinyin = 'Zhōumò mànbù zài fánhuā shèngkāi de gōngyuán húbàn, wēifēng chuīfú, xīnqíng gǎndào géwài shūchàng yúyuè.',
      example_vi = 'Cuối tuần tản bộ bên bờ hồ công viên trăm hoa đua nở, gió nhẹ thổi qua, tâm trạng cảm thấy đặc biệt thư thái vui vẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末漫步在繁花盛开的公园湖畔，微风吹拂，心情感到格外舒畅愉悦。', 'Zhōumò mànbù zài fánhuā shèngkāi de gōngyuán húbàn, wēifēng chuīfú, xīnqíng gǎndào géwài shūchàng yúyuè.', 'Cuối tuần tản bộ bên bờ hồ công viên trăm hoa đua nở, gió nhẹ thổi qua, tâm trạng cảm thấy đặc biệt thư thái vui vẻ.', 'basic', 1),
        (v_id, '职场人士应当学会科学的情绪调节与心理疏导技巧，保持平稳阳光的积极心情，以便从容应对各种高强度的工作压力。', 'Zhíchǎng rénshì yīngdāng xuéhuì kēxué de qíngxù tiáojié yǔ xīnlǐ shūdǎo jìqiǎo, bǎochí píngwěn yángguāng de jījí xīnqíng, yǐbiàn cóngróng yìngduì gèzhǒng gāo qiángdù de gōngzuò yālì.', 'Người làm việc nơi công sở nên học các kỹ năng điều tiết cảm xúc và giải tỏa tâm lý một cách khoa học, giữ vững tâm trạng tích cực tươi sáng bình hòa để ung dung đối phó với các loại áp lực công việc cường độ cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [信号] (xìnhào) - tín hiệu, sóng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '信号' AND pinyin = 'xìnhào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '信号'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xìnhào',
      meaning_vi = 'tín hiệu, sóng',
      example_hanzi = '列车进入长长的山区隧道后，手机的网络信号突然变得非常微弱。',
      example_pinyin = 'Lièchē jìnrù chángcháng de shānqū suìdào hòu, shǒujī de wǎngluò xìnhào tūrán biàn de fēicháng wēiruò.',
      example_vi = 'Sau khi đoàn tàu đi vào đường hầm miền núi dài hun hút, sóng mạng điện thoại đột nhiên trở nên rất yếu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '列车进入长长的山区隧道后，手机的网络信号突然变得非常微弱。', 'Lièchē jìnrù chángcháng de shānqū suìdào hòu, shǒujī de wǎngluò xìnhào tūrán biàn de fēicháng wēiruò.', 'Sau khi đoàn tàu đi vào đường hầm miền núi dài hun hút, sóng mạng điện thoại đột nhiên trở nên rất yếu.', 'basic', 1),
        (v_id, '央行下调金融机构存款准备金率，向宏观经济释放了坚定实施稳健宽松货币政策、全力支持实体经济复苏的积极信号。', 'Yāngháng xiàtiáo jīnróng jīgòu cúnkuǎn zhǔnbèijīnlǜ, xiàng hóngguān jīngjì shìfàng le jiāndìng shíshī wěnjiàn kuānsōng huòbì zhèngcè, quánlì zhīchí shítǐ jīngjì fùsū de jījí xìnhào.', 'Ngân hàng Trung ương hạ tỷ lệ dự trữ bắt buộc của các tổ chức tài chính, giải phóng tín hiệu tích cực tới nền kinh tế vĩ mô về việc kiên định thực thi chính sách tiền tệ nới lỏng thận trọng, dốc toàn lực hỗ trợ sự phục hồi của kinh tế thực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [信息] (xìnxī) - thông tin [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '信息' AND pinyin = 'xìnxī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '信息'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xìnxī',
      meaning_vi = 'thông tin',
      example_hanzi = '在浏览网页新闻时，我们要提高甄别能力，学会辨别网络信息的真伪。',
      example_pinyin = 'Zài liúlǎn wǎngyè xīnwén shí, wǒmen yào tígāo zhēnbié nénglì, xuéhuì biànbié wǎngluò xìnxī de zhēnwěi.',
      example_vi = 'Khi lướt xem tin tức trên trang web, chúng ta cần nâng cao năng lực sàng lọc, học cách phân biệt thông tin trên mạng là thật hay giả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在浏览网页新闻时，我们要提高甄别能力，学会辨别网络信息的真伪。', 'Zài liúlǎn wǎngyè xīnwén shí, wǒmen yào tígāo zhēnbié nénglì, xuéhuì biànbié wǎngluò xìnxī de zhēnwěi.', 'Khi lướt xem tin tức trên trang web, chúng ta cần nâng cao năng lực sàng lọc, học cách phân biệt thông tin trên mạng là thật hay giả.', 'basic', 1),
        (v_id, '国家加快构建全国一体化政务大数据体系，依法加强个人信息保护与关键信息基础设施网络安全防护屏障建设。', 'Guójiā jiākuài gòujiàn quánguó yītǐhuà zhèngwù dà shùjù tǐxì, yīfǎ jiāqiáng gèrén xìnxī bǎohù yǔ guānjiàn xìnxī jīchǔ shèshī wǎngluò ānquán fánghù píngzhàng jiànshè.', 'Nhà nước đẩy nhanh việc kiến tạo hệ thống dữ liệu lớn chính vụ tích hợp toàn quốc, tăng cường bảo vệ thông tin cá nhân theo đúng pháp luật và xây dựng bức bình phong phòng hộ an ninh mạng cho cơ sở hạ tầng thông tin trọng yếu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [信心] (xìnxīn) - niềm tin, lòng tự tin [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '信心' AND pinyin = 'xìnxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '信心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xìnxīn',
      meaning_vi = 'niềm tin, lòng tự tin',
      example_hanzi = '老师温暖鼓励的话语，让我对即将到来的口语考试充满了信心。',
      example_pinyin = 'Lǎoshī wēnnuǎn gǔlì de huàyǔ, ràng wǒ duì jíjiāng dàolái de kǒuyǔ kǎoshì chōngmǎn le xìnxīn.',
      example_vi = 'Những lời động viên ấm áp của thầy cô khiến tôi tràn đầy niềm tin vào kỳ thi vấn đáp sắp tới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师温暖鼓励的话语，让我对即将到来的口语考试充满了信心。', 'Lǎoshī wēnnuǎn gǔlì de huàyǔ, ràng wǒ duì jíjiāng dàolái de kǒuyǔ kǎoshì chōngmǎn le xìnxīn.', 'Những lời động viên ấm áp của thầy cô khiến tôi tràn đầy niềm tin vào kỳ thi vấn đáp sắp tới.', 'basic', 1),
        (v_id, '随着国家一揽子稳经济、扩内需、促民营经济高质量发展政策的精准发力，资本市场与民营企业家对未来长期向好发展的信心显著增强。', 'Suízhe guójiā yìlǎnzi wěn jīngjì, kuò nèixū, cù mínyíng jīngjì gāozhìliàng fāzhǎn zhèngcè de jīngzhǔn fālì, zīběn shìchǎng yǔ mínyíng qǐyèjiā duì wèilái chángqī xiànghǎo fāzhǎn de xìnxīn xiǎnzhù zēngqiáng.', 'Cùng với việc một gói các chính sách ổn định kinh tế, mở rộng nội cầu, thúc đẩy kinh tế tư nhân phát triển chất lượng cao của nhà nước phát huy sức mạnh chuẩn xác, niềm tin của thị trường vốn và giới doanh nhân tư nhân vào sự phát triển khởi sắc lâu dài trong tương lai đã tăng lên rõ rệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [兴奋] (xīngfèn) - hưng phấn, phấn khích [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '兴奋' AND pinyin = 'xīngfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '兴奋'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xīngfèn',
      meaning_vi = 'hưng phấn, phấn khích',
      example_hanzi = '得知自己被重点大学录取的消息后，弟弟兴奋得一整晚都没睡着觉。',
      example_pinyin = 'Dézhī zìjǐ bèi zhòngdiǎn dàxué lùqǔ de xiāoxi hòu, dìdi xīngfèn de yì zhěng wǎn dōu méi shuìzháo jiào.',
      example_vi = 'Sau khi biết tin mình được trường đại học trọng điểm tuyển thẳng, em trai phấn khích đến nỗi cả đêm không ngủ nổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '得知自己被重点大学录取的消息后，弟弟兴奋得一整晚都没睡着觉。', 'Dézhī zìjǐ bèi zhòngdiǎn dàxué lùqǔ de xiāoxi hòu, dìdi xīngfèn de yì zhěng wǎn dōu méi shuìzháo jiào.', 'Sau khi biết tin mình được trường đại học trọng điểm tuyển thẳng, em trai phấn khích đến nỗi cả đêm không ngủ nổi.', 'basic', 1),
        (v_id, '当探月工程返回舱成功着陆并带回珍贵月壤样本的瞬间，北京航天飞行控制中心现场的所有科研人员全都兴奋地欢呼拥抱。', 'Dāng tànyuè gōngchéng fǎnhuícāng chénggōng zhuólù bìng dài huí zhēnguì yuè rǎng yàngběn de shùnjiān, Běijīng hángtiān fēixíng kòngzhì zhōngxīn xiànchǎng de suǒyǒu kēyán rényuán quándōu xīngfèn de huānhū yōngbào.', 'Vào khoảnh khắc khoang đổ bộ của công trình thám hiểm mặt trăng hạ cánh thành công mang về các mẫu đất mặt trăng quý giá, toàn thể các nhà nghiên cứu khoa học có mặt tại Trung tâm điều khiển bay hàng không vũ trụ Bắc Kinh đều phấn khích reo hò ôm chầm lấy nhau.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [星星] (xīngxing) - ngôi sao [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '星星' AND pinyin = 'xīngxing'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '星星'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xīngxing',
      meaning_vi = 'ngôi sao',
      example_hanzi = '夏天的夜晚躺在草地上，抬头能看见天空中闪烁着无数明亮的星星。',
      example_pinyin = 'Xiàtiān de yèwǎn tǎng zài cǎodì shang, táitóu néng kànjiàn tiānkōng zhōng shǎnshuòzhe wúshù míngliàng de xīngxing.',
      example_vi = 'Đêm hè nằm trên bãi cỏ, ngẩng đầu lên có thể nhìn thấy vô số ngôi sao sáng lấp lánh trên bầu trời.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夏天的夜晚躺在草地上，抬头能看见天空中闪烁着无数明亮的星星。', 'Xiàtiān de yèwǎn tǎng zài cǎodì shang, táitóu néng kànjiàn tiānkōng zhōng shǎnshuòzhe wúshù míngliàng de xīngxing.', 'Đêm hè nằm trên bãi cỏ, ngẩng đầu lên có thể nhìn thấy vô số ngôi sao sáng lấp lánh trên bầu trời.', 'basic', 1),
        (v_id, '“星星之火，可以燎原”，中国革命历史雄辩地证明，只要植根人民群众，微小的力量终将汇聚成不可阻挡的磅礴伟力。', '“Xīngxing zhī huǒ, kěyǐ liáoyuán”, Zhōngguó gémìng lìshǐ xióngbiàn de zhèngmíng, zhǐyào zhígēn rénmín qúnzhòng, wēixiǎo de lìliàng zhōng jiāng huìjù chéng bùkě zǔdǎng de pángbó wěilì.', '"Đốm lửa nhỏ có thể làm cháy cả cánh đồng", lịch sử cách mạng Trung Quốc đã chứng minh một cách hùng hồn rằng chỉ cần bén rễ sâu trong quần chúng nhân dân, sức mạnh dù nhỏ bé cuối cùng cũng sẽ hội tụ thành sức mạnh vĩ đại cuồn cuộn không thể ngăn cản.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [醒] (xǐng) - tỉnh lại, thức giấc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '醒' AND pinyin = 'xǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '醒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xǐng',
      meaning_vi = 'tỉnh lại, thức giấc',
      example_hanzi = '早晨闹钟一响，他就立刻睁开眼睛清醒地爬起床来。',
      example_pinyin = 'Zǎochén nàozhōng yì xiǎng, tā jiù lìkè zhēng kāi yǎnjīng qīngxǐng de pá qǐ chuáng lái.',
      example_vi = 'Sáng sớm đồng hồ báo thức vừa reo, anh ấy liền lập tức mở mắt tỉnh táo leo ra khỏi giường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '早晨闹钟一响，他就立刻睁开眼睛清醒地爬起床来。', 'Zǎochén nàozhōng yì xiǎng, tā jiù lìkè zhēng kāi yǎnjīng qīngxǐng de pá qǐ chuáng lái.', 'Sáng sớm đồng hồ báo thức vừa reo, anh ấy liền lập tức mở mắt tỉnh táo leo ra khỏi giường.', 'basic', 1),
        (v_id, '面对突发复杂国际金融市场剧烈波动，监管机构必须时刻保持清醒头脑，精准防范和化解系统性金融风险。', 'Miànduì tūfā fùzá guójì jīnróng shìchǎng jùliè bōdòng, jiānguǎn jīgòu bìxū shíkè bǎochí qīngxǐng tóunǎo, jīngzhǔn fángfàn hé huàjiě xìtǒngxìng jīnróng fēngxiǎn.', 'Đối mặt trước sự biến động dữ dội bất ngờ của thị trường tài chính quốc tế phức tạp, các cơ quan giám sát bắt buộc phải luôn luôn giữ cái đầu tỉnh táo, phòng ngừa và hóa giải chuẩn xác các rủi ro tài chính mang tính hệ thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [性] (xìng) - tính chất, tính cách [Hậu tố / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '性' AND pinyin = 'xìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '性'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Hậu tố / Danh từ',
      pinyin = 'xìng',
      meaning_vi = 'tính chất, tính cách',
      example_hanzi = '棉质面料具有良好的透气性和吸湿性，穿在身上非常舒适。',
      example_pinyin = 'Miánzhì miànliào jùyǒu liánghǎo de tòuqìxìng hé xīshīxìng, chuān zài shēn shang fēicháng shūshì.',
      example_vi = 'Vải chất liệu cotton có độ thông thoáng và khả năng hút ẩm rất tốt, mặc trên người vô cùng dễ chịu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '棉质面料具有良好的透气性和吸湿性，穿在身上非常舒适。', 'Miánzhì miànliào jùyǒu liánghǎo de tòuqìxìng hé xīshīxìng, chuān zài shēn shang fēicháng shūshì.', 'Vải chất liệu cotton có độ thông thoáng và khả năng hút ẩm rất tốt, mặc trên người vô cùng dễ chịu.', 'basic', 1),
        (v_id, '在推进重大行政决策法定程序中，全面开展合法性、合理性与社会稳定风险评估是确保决策科学民主的必由之路。', 'Zài tuījìn zhòngdà xíngzhèng juécè fǎdìng chéngxù zhōng, quánmiàn kāizhǎn héfǎxìng, hélǐxìng yǔ shèhuì wěndìng fēngxiǎn pínggū shì quèbǎo juécè kēxué mínzhǔ de bìyóuzhīlù.', 'Trong quy trình theo luật định khi thúc đẩy các quyết sách hành chính trọng đại, việc triển khai toàn diện đánh giá tính hợp pháp, tính hợp lý và rủi ro ổn định xã hội là con đường tất yếu để bảo đảm quyết sách mang tính khoa học và dân chủ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [性别] (xìngbié) - giới tính [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '性别' AND pinyin = 'xìngbié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '性别'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xìngbié',
      meaning_vi = 'giới tính',
      example_hanzi = '在填写求职申请表时，请按照身份证如实注明自己的姓名、年龄与性别。',
      example_pinyin = 'Zài tiánxiě qiúzhí shēnqǐngbiǎo shí, qǐng ànzhào shēnfènzhèng rúshí zhùmíng zìjǐ de xìngmíng, niánlíng yǔ xìngbié.',
      example_vi = 'Khi điền vào đơn xin việc, xin vui lòng ghi rõ họ tên, tuổi tác và giới tính của bản thân một cách trung thực theo đúng căn cước công dân.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在填写求职申请表时，请按照身份证如实注明自己的姓名、年龄与性别。', 'Zài tiánxiě qiúzhí shēnqǐngbiǎo shí, qǐng ànzhào shēnfènzhèng rúshí zhùmíng zìjǐ de xìngmíng, niánlíng yǔ xìngbié.', 'Khi điền vào đơn xin việc, xin vui lòng ghi rõ họ tên, tuổi tác và giới tính của bản thân một cách trung thực theo đúng căn cước công dân.', 'basic', 1),
        (v_id, '国家出台多项有力举措坚决消除就业市场中的性别歧视，切实保障女性劳动者在职业晋升与薪酬福利方面的平等合法权益。', 'Guójiā chūtái duō xiàng yǒulì jǔcuò jiānjué xiāochú jiùyè shìchǎng zhōng de xìngbié qíshì, qièshí bǎozhàng nǚxìng láodòngzhě zài zhíyè jìnshēng yǔ xīnchóu fúlì fāngmiàn de píngděng héfǎ quányì.', 'Nhà nước đã ban hành nhiều biện pháp mạnh mẽ kiên quyết xóa bỏ sự phân biệt đối xử về giới tính trên thị trường việc làm, thiết thực bảo vệ quyền lợi bình đẳng hợp pháp của người lao động nữ trong thăng tiến sự nghiệp và chế độ lương thưởng phúc lợi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [幸福] (xìngfú) - hạnh phúc [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '幸福' AND pinyin = 'xìngfú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '幸福'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'xìngfú',
      meaning_vi = 'hạnh phúc',
      example_hanzi = '一家人团聚在一起其乐融融地吃年夜饭，就是最温馨简单的幸福。',
      example_pinyin = 'Yì jiā rén tuánjù zài yìqǐ qílè-róngróng de chī niányèfàn, jiùshì zuì wēnxīn jiǎndān de xìngfú.',
      example_vi = 'Cả gia đình quây quần bên nhau vui vẻ ấm cúng cùng ăn bữa cơm tất niên chính là niềm hạnh phúc đơn giản và ấm áp nhất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '一家人团聚在一起其乐融融地吃年夜饭，就是最温馨简单的幸福。', 'Yì jiā rén tuánjù zài yìqǐ qílè-róngróng de chī niányèfàn, jiùshì zuì wēnxīn jiǎndān de xìngfú.', 'Cả gia đình quây quần bên nhau vui vẻ ấm cúng cùng ăn bữa cơm tất niên chính là niềm hạnh phúc đơn giản và ấm áp nhất.', 'basic', 1),
        (v_id, '人民对美好生活的向往就是我们的奋斗目标，不断增强广大人民群众的获得感、幸福感与安全感是检验一切工作的最高标准。', 'Rénmín duì měihǎo shēnghuó de xiàngwǎng jiùshì wǒmen de fèndòu mùbiāo, búduàn zēngqiáng guǎngdà rénmín qúnzhòng de huòdégǎn, xìngfúgǎn yǔ ānquángǎn shì jiǎnyàn yíqiè gōngzuò de zuìgāo biāozhǔn.', 'Sự khao khát của nhân dân đối với cuộc sống tươi đẹp chính là mục tiêu phấn đấu của chúng ta, không ngừng tăng cường cảm giác đạt được, cảm giác hạnh phúc và an toàn của đông đảo quần chúng nhân dân là tiêu chuẩn tối cao kiểm nghiệm mọi công việc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [性格] (xìnggé) - tính cách, tính tình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '性格' AND pinyin = 'xìnggé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '性格'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xìnggé',
      meaning_vi = 'tính cách, tính tình',
      example_hanzi = '他性格开朗外向，非常乐于助人，在班级里人缘特别好。',
      example_pinyin = 'Tā xìnggé kāilǎng wàixiàng, fēicháng lèyú zhùrén, zài bānjí lǐ rényuán tèbié hǎo.',
      example_vi = 'Anh ấy tính cách cởi mở hướng ngoại, rất hay giúp đỡ người khác, ở trong lớp có mối quan hệ với mọi người rất tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他性格开朗外向，非常乐于助人，在班级里人缘特别好。', 'Tā xìnggé kāilǎng wàixiàng, fēicháng lèyú zhùrén, zài bānjí lǐ rényuán tèbié hǎo.', 'Anh ấy tính cách cởi mở hướng ngoại, rất hay giúp đỡ người khác, ở trong lớp có mối quan hệ với mọi người rất tốt.', 'basic', 1),
        (v_id, '在现代人力资源管理与关键岗位胜任力模型中，求职者的性格特质与岗位职责要求高度契合往往是决定长期卓越绩效的关键因素。', 'Zài xiàndài rénlì zīyuán guǎnlǐ yǔ guānjiàn gǎngwèi shèngrènlì móxíng zhōng, qiúzhízhě de xìnggé tèzhì yǔ gǎngwèi zhízé yāoqiú gāodù qìhé wǎngwǎng shì juédìng chángqī zhuōyuè jìxiào de guānjiàn yīnsù.', 'Trong quản lý nhân sự hiện đại và mô hình năng lực đáp ứng vị trí công tác then chốt, đặc điểm tính cách của người ứng tuyển có sự ăn khớp cao với yêu cầu chức trách công việc thường là yếu tố then chốt quyết định hiệu suất vượt trội lâu dài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [兄弟] (xiōngdì) - huynh đệ, anh em [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '兄弟' AND pinyin = 'xiōngdì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '兄弟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiōngdì',
      meaning_vi = 'huynh đệ, anh em',
      example_hanzi = '他们俩从小一起在胡同里长大，亲密得就像亲兄弟一样。',
      example_pinyin = 'Tāmen liǎ cóngxiǎo yìqǐ zài hútòng lǐ zhǎngdà, qīnmì de jiù xiàng qīn xiōngdì yíyàng.',
      example_vi = 'Hai người họ từ nhỏ đã cùng nhau lớn lên trong ngõ nhỏ, thân thiết hệt như anh em ruột thịt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他们俩从小一起在胡同里长大，亲密得就像亲兄弟一样。', 'Tāmen liǎ cóngxiǎo yìqǐ zài hútòng lǐ zhǎngdà, qīnmì de jiù xiàng qīn xiōngdì yíyàng.', 'Hai người họ từ nhỏ đã cùng nhau lớn lên trong ngõ nhỏ, thân thiết hệt như anh em ruột thịt.', 'basic', 1),
        (v_id, '在推进区域协调发展与对口帮扶协作中，东部沿海发达省份与中西部兄弟省区守望相助，携手谱写了共同繁荣发展的时代新篇。', 'Zài tuījìn qūyù xiétiáo fāzhǎn yǔ duìkǒu bāngfú xiézuò zhōng, dōngbù yánhǎi fādá shěngfèn yǔ zhōng-xībù xiōngdì shěng-qū shǒuwàng-xiāngzhù, xiéshǒu pǔxiě le gòngtóng fánhuá fāzhǎn de shídài xīnpiān.', 'Trong việc thúc đẩy phát triển liên vùng hài hòa và hỗ trợ tương trợ theo cặp, các tỉnh phát triển ven biển phía đông cùng các tỉnh anh em miền Trung Tây đã đùm bọc giúp đỡ lẫn nhau, chung tay viết nên chương mới của thời đại về phát triển phồn vinh chung.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [熊] (xióng) - con gấu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '熊' AND pinyin = 'xióng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '熊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xióng',
      meaning_vi = 'con gấu',
      example_hanzi = '大熊猫是中国特有的珍稀国宝动物，深受全世界人民的喜爱。',
      example_pinyin = 'Dàxióngmāo shì Zhōngguó tèyǒu de zhēnxī guóbǎo dòngwù, shēn shòu quán shìjiè rénmín de xǐ’ài.',
      example_vi = 'Gấu trúc lớn là loài quốc bảo quý hiếm đặc hữu của Trung Quốc, được nhân dân toàn thế giới vô cùng yêu thích.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大熊猫是中国特有的珍稀国宝动物，深受全世界人民的喜爱。', 'Dàxióngmāo shì Zhōngguó tèyǒu de zhēnxī guóbǎo dòngwù, shēn shòu quán shìjiè rénmín de xǐ’ài.', 'Gấu trúc lớn là loài quốc bảo quý hiếm đặc hữu của Trung Quốc, được nhân dân toàn thế giới vô cùng yêu thích.', 'basic', 1),
        (v_id, '国家大熊猫公园等自然保护区的全面设立与生态走廊联通，为野生棕熊、黑熊等大型哺乳动物的繁衍生息提供了广阔安全的生态庇护所。', 'Guójiā Dàxióngmāo Gōngyuán děng zìrán bǎohùqū de quánmiàn shèlì yǔ shēngtài zǒuláng liántōng, wèi yěshēng zōngxióng, hēixióng děng dàxíng bǔrǔ dòngwù de fányǎn-shēngxī tígōng le guǎngkuò ānquán de shēngtài bìhùsuǒ.', 'Việc thành lập toàn diện và kết nối hành lang sinh thái của các khu bảo tồn thiên nhiên như Công viên Quốc gia Gấu trúc đã mang lại nơi trú ẩn sinh thái an toàn và rộng lớn cho sự sinh sôi nảy nở của các loài thú có vú cỡ lớn như gấu nâu, gấu đen hoang dã.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [修] (xiū) - sửa chữa, tu bổ, xây dựng; tu dưỡng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '修' AND pinyin = 'xiū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '修'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xiū',
      meaning_vi = 'sửa chữa, tu bổ, xây dựng; tu dưỡng',
      example_hanzi = '家里的自来水管有点漏水，爸爸找来工具自己动手修好了。',
      example_pinyin = 'Jiā lǐ de zìláishuǐguǎn yǒudiǎnr lòushuǐ, bàba zhǎo lái gōngjù zìjǐ dòngshǒu xiū hǎo le.',
      example_vi = 'Đường ống nước máy trong nhà hơi bị rò rỉ, bố đã tìm đồ nghề tự tay sửa xong xuôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '家里的自来水管有点漏水，爸爸找来工具自己动手修好了。', 'Jiā lǐ de zìláishuǐguǎn yǒudiǎnr lòushuǐ, bàba zhǎo lái gōngjù zìjǐ dòngshǒu xiū hǎo le.', 'Đường ống nước máy trong nhà hơi bị rò rỉ, bố đã tìm đồ nghề tự tay sửa xong xuôi.', 'basic', 1),
        (v_id, '国家加大对农村基础设施建设的投入力度，因地制宜在崇山峻岭间修通了数万公里四通八达的高标准便民硬化公路。', 'Guójiā jiàdà duì nóngcūn jīchǔ shèshī jiànshè de tóurù lìdù, yīndìzhìyí zài chóngshān-jùnlǐng jiān xiū tōng le shù wàn gōnglǐ sìtōng-bādá de gāo biāozhǔn biànmín yìnghuà gōnglù.', 'Nhà nước gia tăng mức độ đầu tư vào xây dựng cơ sở hạ tầng nông thôn, tùy theo địa hình mà mở đường xây thông hàng vạn ki-lô-mét đường nhựa bê tông tiện ích tiêu chuẩn cao nối dài muôn phương giữa trập trùng núi non hiểm trở.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [修理] (xiūlǐ) - sửa chữa, bảo trì [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '修理' AND pinyin = 'xiūlǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '修理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xiūlǐ',
      meaning_vi = 'sửa chữa, bảo trì',
      example_hanzi = '他的笔记本电脑键盘有些按键失灵了，拿到售后服务中心去修理。',
      example_pinyin = 'Tā de bǐjìběn diànnǎo jiànpán yǒuxiē ànjiàn shīlíng le, ná dào shòuhòu fúwù zhōngxīn qù xiūlǐ.',
      example_vi = 'Bàn phím máy tính xách tay của anh ấy có vài phím bị liệt, đã mang tới trung tâm dịch vụ hậu mãi để sửa chữa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的笔记本电脑键盘有些按键失灵了，拿到售后服务中心去修理。', 'Tā de bǐjìběn diànnǎo jiànpán yǒuxiē ànjiàn shīlíng le, ná dào shòuhòu fúwù zhōngxīn qù xiūlǐ.', 'Bàn phím máy tính xách tay của anh ấy có vài phím bị liệt, đã mang tới trung tâm dịch vụ hậu mãi để sửa chữa.', 'basic', 1),
        (v_id, '高速铁路动车组列车在运行指定里程后，必须驶入专业动车段由资深检修技师进行精密探伤与全方位深度部件修理维护。', 'Gāosù tiělù dòngchēzǔ lièchē zài yùnxíng zhǐdìng lǐchéng hòu, bìxū shǐrù zhuānyè dòngchēduàn yóu zīshēn jiǎnxiū jìshī jìnxíng jīngmì tānshāng yǔ quánfāngwèi shēndù bùjiàn xiūlǐ wéihù.', 'Đoàn tàu cao tốc EMU sau khi vận hành đạt số ki-lô-mét quy định bắt buộc phải chạy vào ga bảo dưỡng kỹ thuật chuyên dụng để các kỹ sư kiểm tra dò khuyết tật tinh vi và tiến hành sửa chữa bảo dưỡng linh kiện có chiều sâu toàn diện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [许多] (xǔduō) - nhiều, rất nhiều [Số từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '许多' AND pinyin = 'xǔduō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '许多'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Số từ',
      pinyin = 'xǔduō',
      meaning_vi = 'nhiều, rất nhiều',
      example_hanzi = '在这次国际文化交流节上，同学们结识了来自五湖四海的许多新朋友。',
      example_pinyin = 'Zài zhè cì guójì wénhuà jiāoliú jié shang, tóngxuémen jiéshí le láizì wǔhú-sìhǎi de xǔduō xīn péngyou.',
      example_vi = 'Trong lễ hội giao lưu văn hóa quốc tế lần này, các bạn học sinh đã làm quen được với rất nhiều người bạn mới đến từ khắp bốn phương trời.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在这次国际文化交流节上，同学们结识了来自五湖四海的许多新朋友。', 'Zài zhè cì guójì wénhuà jiāoliú jié shang, tóngxuémen jiéshí le láizì wǔhú-sìhǎi de xǔduō xīn péngyou.', 'Trong lễ hội giao lưu văn hóa quốc tế lần này, các bạn học sinh đã làm quen được với rất nhiều người bạn mới đến từ khắp bốn phương trời.', 'basic', 1),
        (v_id, '许多具备自主知识产权与核心竞争力的中国高科技企业，正在全球产业格局重构的大潮中扮演着举足轻重的引领角色。', 'Xǔduō jùbèi zìzhǔ zhīshi chǎnquán yǔ héxīn jìngzhēnglì de Zhōngguó gāokējì qǐyè, zhèngzài quánqiú chǎnyè géjú chónggòu de dàcháo zhōng bànyǎnzhe jǔzú-qīngzhòng de yǐnlǐng juésè.', 'Rất nhiều doanh nghiệp công nghệ cao của Trung Quốc sở hữu quyền sở hữu trí tuệ tự chủ và sức cạnh tranh cốt lõi đang đóng vai trò dẫn dắt vô cùng quan trọng trong làn sóng tái cấu trúc cục diện ngành nghề toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [学费] (xuéfèi) - học phí, tiền học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '学费' AND pinyin = 'xuéfèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '学费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xuéfèi',
      meaning_vi = 'học phí, tiền học',
      example_hanzi = '新学期开学前，同学们都可以通过手机银行直接在线缴纳大学学费。',
      example_pinyin = 'Xīn xuéqī kāixué qián, tóngxuémen dōu kěyǐ tōngguò shǒujī yínháng zhíjiē zàixiàn jiǎonà dàxué xuéfèi.',
      example_vi = 'Trước khi bước vào học kỳ mới, các bạn học sinh đều có thể thông qua ứng dụng ngân hàng di động nộp học phí đại học trực tuyến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '新学期开学前，同学们都可以通过手机银行直接在线缴纳大学学费。', 'Xīn xuéqī kāixué qián, tóngxuémen dōu kěyǐ tōngguò shǒujī yínháng zhíjiē zàixiàn jiǎonà dàxué xuéfèi.', 'Trước khi bước vào học kỳ mới, các bạn học sinh đều có thể thông qua ứng dụng ngân hàng di động nộp học phí đại học trực tuyến.', 'basic', 1),
        (v_id, '国家建立了覆盖各教育阶段的资助政策体系，通过国家奖学金、助学贷款以及全额免除学费，确保家庭经济困难学生绝不因贫失学。', 'Guójiā jiànlì le fùgài gè jiàoyù jiēduàn de zīzhù zhèngcè tǐxì, tōngguò guójiā jiǎngxuéjīn, zhùxué dàikuǎn yǐjí quán’é miǎnchú xuéfèi, quèbǎo jiātíng jīngjì kùnnan xuésheng jué bù yīn pín shīxué.', 'Nhà nước đã xây dựng hệ thống chính sách trợ cấp bao phủ khắp các giai đoạn giáo dục, thông qua học bổng nhà nước, vay vốn trợ học cũng như miễn trừ toàn bộ học phí để bảo đảm sinh viên có hoàn cảnh kinh tế khó khăn quyết không vì nghèo mà bỏ học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [学院] (xuéyuàn) - học viện, khoa đại học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '学院' AND pinyin = 'xuéyuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '学院'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xuéyuàn',
      meaning_vi = 'học viện, khoa đại học',
      example_hanzi = '哥哥目前在北京一所知名大学的国际经贸管理学院攻读硕士研究生。',
      example_pinyin = 'Gēge mùqián zài Běijīng yì suǒ zhīmíng dàxué de guójì jīng-mào guǎnlǐ xuéyuàn gōngdú shuòshì yánjiūshēng.',
      example_vi = 'Anh trai hiện tại đang theo học cao học thạc sĩ tại Học viện Quản lý Kinh tế Thương mại Quốc tế của một trường đại học danh tiếng tại Bắc Kinh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '哥哥目前在北京一所知名大学的国际经贸管理学院攻读硕士研究生。', 'Gēge mùqián zài Běijīng yì suǒ zhīmíng dàxué de guójì jīng-mào guǎnlǐ xuéyuàn gōngdú shuòshì yánjiūshēng.', 'Anh trai hiện tại đang theo học cao học thạc sĩ tại Học viện Quản lý Kinh tế Thương mại Quốc tế của một trường đại học danh tiếng tại Bắc Kinh.', 'basic', 1),
        (v_id, '高校积极推进现代产业学院与未来技术学院建设，通过深化产教融合与校企协同育人，精准培养复合型卓越工程师人才。', 'Gāoxiào jījí tuījìn xiàndài chǎnyè xuéyuàn yǔ wèilái jìshù xuéyuàn jiànshè, tōngguò shēnhuà chǎn-jiào rónghé yǔ xiào-qǐ xiétóng yùrén, jīngzhǔn péiyǎng fùhéxíng zhuōyuè gōngchéngshī réncái.', 'Các trường đại học tích cực thúc đẩy việc xây dựng Học viện Ngành nghề Hiện đại và Học viện Công nghệ Tương lai, thông qua làm sâu sắc liên kết giáo dục sản xuất và hiệp đồng đào tạo giữa trường học - doanh nghiệp để bồi dưỡng chuẩn xác các kỹ sư ưu tú phức hợp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [压] (yā) - đè, nén, ép; đè nặng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '压' AND pinyin = 'yā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '压'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yā',
      meaning_vi = 'đè, nén, ép; đè nặng',
      example_hanzi = '刮大风的时候，请找几块厚重的鹅卵石把阳台上的画纸压住。',
      example_pinyin = 'Guā dàfēng de shíhou, qǐng zhǎo jǐ kuài hòuzhòng de éluǎnshí bǎ yángtái shang de huàzhǐ yā zhù.',
      example_vi = 'Khi nổi gió lớn, xin hãy tìm vài hòn đá cuội dày nặng đè giữ chặt các tờ giấy vẽ ngoài ban công.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '刮大风的时候，请找几块厚重的鹅卵石把阳台上的画纸压住。', 'Guā dàfēng de shíhou, qǐng zhǎo jǐ kuài hòuzhòng de éluǎnshí bǎ yángtái shang de huàzhǐ yā zhù.', 'Khi nổi gió lớn, xin hãy tìm vài hòn đá cuội dày nặng đè giữ chặt các tờ giấy vẽ ngoài ban công.', 'basic', 1),
        (v_id, '面对突如其来的市场剧烈下行冲击，企业管理层顶住巨大经营亏损压力，坚决不裁员并持续加大关键核心零部件的攻关研发。', 'Miànduì tūrúqílái de shìchǎng jùliè xiàxíng chōngjī, qǐyè guǎnlǐcéng dǐng zhù jùdà jīngyíng kuīsǔn yālì, jiānjué bù cáiyuán bìng chíxù jiàdà guānjiàn héxīn língbùjiàn de gōngguān yánfā.', 'Đối mặt trước cú sốc sụt giảm dữ dội bất ngờ của thị trường, ban quản lý doanh nghiệp đã chống đỡ áp lực thua lỗ kinh doanh to lớn, kiên quyết không sa thải nhân viên và tiếp tục gia tăng nghiên cứu đột phá các linh kiện then chốt cốt lõi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [压力] (yālì) - áp lực [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '压力' AND pinyin = 'yālì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '压力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yālì',
      meaning_vi = 'áp lực',
      example_hanzi = '适当的体育锻炼和听音乐能够有效缓解考试带来的心理压力。',
      example_pinyin = 'Shìdàng de tǐyù duànliàn hé tīng yīnyuè nénggòu yǒuxiào huǎnjiě kǎoshì dàilái de xīnlǐ yālì.',
      example_vi = 'Rèn luyện thể thao điều độ và nghe nhạc có thể giải tỏa hiệu quả áp lực tâm lý do thi cử mang lại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '适当的体育锻炼和听音乐能够有效缓解考试带来的心理压力。', 'Shìdàng de tǐyù duànliàn hé tīng yīnyuè nénggòu yǒuxiào huǎnjiě kǎoshì dàilái de xīnlǐ yālì.', 'Rèn luyện thể thao điều độ và nghe nhạc có thể giải tỏa hiệu quả áp lực tâm lý do thi cử mang lại.', 'basic', 1),
        (v_id, '面对世界经济复苏动能不足与全球产业链供应链重构的多重外部压力，我国经济凭借强大的发展韧性持续巩固回升向好态势。', 'Miànduì shìjiè jīngjì fùsū dòngnéng bùzú yǔ quánqiú chǎnyèliàn gōngyìngliàn chónggòu de duōchóng wàibù yālì, wǒ guó jīngjì píngjiè qiángdà de fāzhǎn rènxìng chíxù gǒnggù huíshēng xiànghǎo tàishì.', 'Đối mặt trước đa tầng áp lực bên ngoài từ việc động lực phục hồi kinh tế thế giới thiếu hụt và chuỗi cung ứng công nghiệp toàn cầu tái cấu trúc, nền kinh tế nước ta nhờ vào độ dẻo dai phát triển mạnh mẽ đã tiếp tục củng cố xu thế phục hồi khởi sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [牙膏] (yágāo) - kem đánh răng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '牙膏' AND pinyin = 'yágāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '牙膏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yágāo',
      meaning_vi = 'kem đánh răng',
      example_hanzi = '牙医建议每天早晚使用含氟防蛀牙膏认真刷牙三分钟以上。',
      example_pinyin = 'Yáyī jiànyì měi tiān zǎo-wǎn shǐyòng hán fú fángzhù yágāo rènzhēn shuāyá sān fēnzhōng yǐshàng.',
      example_vi = 'Nha sĩ khuyên mỗi sáng tối nên dùng kem đánh răng chứa flo chống sâu răng đánh răng cẩn thận từ ba phút trở lên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '牙医建议每天早晚使用含氟防蛀牙膏认真刷牙三分钟以上。', 'Yáyī jiànyì měi tiān zǎo-wǎn shǐyòng hán fú fángzhù yágāo rènzhēn shuāyá sān fēnzhōng yǐshàng.', 'Nha sĩ khuyên mỗi sáng tối nên dùng kem đánh răng chứa flo chống sâu răng đánh răng cẩn thận từ ba phút trở lên.', 'basic', 1),
        (v_id, '日化消费品监管部门全面加强对中草药功效型牙膏的临床功效验证与重金属微生物指标检测，切实维护消费者口腔健康。', 'Rìhuà xiāofèipǐn jiānguǎn bùmén quánmiàn jiāqiáng duì zhōngcǎoyào gōngxiàoxíng yágāo de línchuáng gōngxiào yànzhèng yǔ zhòngjīnshǔ wēishēngwù zhǐbiāo jiǎncè, qièshí wéihù xiāofèizhě kǒuqiāng jiànkāng.', 'Cơ quan giám sát hóa mỹ phẩm tiêu dùng hàng ngày tăng cường toàn diện việc kiểm nghiệm hiệu năng lâm sàng và đo lường chỉ số kim loại nặng vi sinh vật đối với các loại kem đánh răng công năng thảo dược Trung Hoa, thiết thực bảo vệ sức khỏe răng miệng cho người tiêu dùng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [亚洲] (Yàzhōu) - châu Á [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '亚洲' AND pinyin = 'Yàzhōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '亚洲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'Yàzhōu',
      meaning_vi = 'châu Á',
      example_hanzi = '亚洲是世界上人口最多、陆地面积最大的大洲，孕育了丰富多彩的文明。',
      example_pinyin = 'Yàzhōu shì shìjiè shang rénkǒu zuì duō, lùdì miànjī zuìdà de dàzhōu, yùnyù le fēngfù-duōcǎi de wénmíng.',
      example_vi = 'Châu Á là châu lục đông dân nhất và có diện tích đất liền lớn nhất trên thế giới, đã nuôi dưỡng những nền văn minh phong phú đa sắc màu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '亚洲是世界上人口最多、陆地面积最大的大洲，孕育了丰富多彩的文明。', 'Yàzhōu shì shìjiè shang rénkǒu zuì duō, lùdì miànjī zuìdà de dàzhōu, yùnyù le fēngfù-duōcǎi de wénmíng.', 'Châu Á là châu lục đông dân nhất và có diện tích đất liền lớn nhất trên thế giới, đã nuôi dưỡng những nền văn minh phong phú đa sắc màu.', 'basic', 1),
        (v_id, '随着区域全面经济伙伴关系协定（RCEP）的高水平实施，亚洲区域内部贸易与产业链供应链一体化合作正展现出前所未有的蓬勃生机。', 'Suízhe Qūyù Quánmiàn Jīngjì Huǒbàn Guānxi Xiédìng (RCEP) de gāo shuǐpíng shíshī, Yàzhōu qūyù nèibù màoyì yǔ chǎnyèliàn gōngyìngliàn yītǐhuà hézuò zhèng zhǎnxiàn chū qiánsuǒwèiyǒu de péngbó shēngjī.', 'Cùng với việc thực thi hiệp định Đối tác Kinh tế Toàn diện Khu vực (RCEP) ở trình độ cao, thương mại nội khối khu vực châu Á và sự hợp tác tích hợp chuỗi ngành nghề chuỗi cung ứng đang thể hiện sức sống phơi phới chưa từng có.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [烟] (yān) - khói; thuốc lá [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '烟' AND pinyin = 'yān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '烟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yān',
      meaning_vi = 'khói; thuốc lá',
      example_hanzi = '为了自己和家人的身体健康，爸爸终于下定决心把多年的烟戒掉了。',
      example_pinyin = 'Wèile zìjǐ hé jiārén de shēntǐ jiànkāng, bàba zhōngyú xiàdìng juéxīn bǎ duō nián de yān jiè diào le.',
      example_vi = 'Vì sức khỏe của bản thân và người nhà, bố cuối cùng đã hạ quyết tâm cai hẳn khói thuốc lá gắn bó nhiều năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了自己和家人的身体健康，爸爸终于下定决心把多年的烟戒掉了。', 'Wèile zìjǐ hé jiārén de shēntǐ jiànkāng, bàba zhōngyú xiàdìng juéxīn bǎ duō nián de yān jiè diào le.', 'Vì sức khỏe của bản thân và người nhà, bố cuối cùng đã hạ quyết tâm cai hẳn khói thuốc lá gắn bó nhiều năm.', 'basic', 1),
        (v_id, '工业环保监管平台运用物联网传感器与无人机巡航技术，对重点钢铁冶炼厂区排放的工业烟尘进行全天候全天时自动监测预警。', 'Gōngyè huánbǎo jiānguǎn píngtái yùnyòng wùliánwǎng chuángǎnqì yǔ wúrénjī xúnháng jìshù, duì zhòngdiǎn gāngtiě yěliàn chǎngqū páifàng de gōngyè yānchén jìnxíng quántiānhòu quántiānshí zìdòng jiāncè yùjǐng.', 'Nền tảng giám sát bảo vệ môi trường công nghiệp áp dụng cảm biến vạn vật kết nối IoT và công nghệ tuần tra máy bay không người lái để giám sát cảnh báo tự động 24/7 đối với khói bụi công nghiệp thải ra từ các khu nhà máy luyện gang thép trọng điểm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [盐] (yán) - muối, muối ăn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '盐' AND pinyin = 'yán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '盐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yán',
      meaning_vi = 'muối, muối ăn',
      example_hanzi = '煮排骨汤时一定要等肉炖烂后再放少量的盐，这样汤味更鲜美。',
      example_pinyin = 'Zhǔ páigǔ tāng shí yídìng yào děng ròu dùn làn hòu zài fàng shǎoliàng de yán, zhèyàng tāngwèi gèng xiānměi.',
      example_vi = 'Khi nấu canh sườn nhất định phải chờ thịt hầm nhừ rồi mới nêm một chút muối, như vậy nước canh sẽ ngọt thơm hơn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '煮排骨汤时一定要等肉炖烂后再放少量的盐，这样汤味更鲜美。', 'Zhǔ páigǔ tāng shí yídìng yào děng ròu dùn làn hòu zài fàng shǎoliàng de yán, zhèyàng tāngwèi gèng xiānměi.', 'Khi nấu canh sườn nhất định phải chờ thịt hầm nhừ rồi mới nêm một chút muối, như vậy nước canh sẽ ngọt thơm hơn.', 'basic', 1),
        (v_id, '国家严格推行全民食用碘盐政策，有力阻断了碘缺乏病这一曾危害数亿群众身体与智力健康的重大地方病的发生流行。', 'Guójiā yángé tuīxíng quánmín shíyòng diǎnyán zhèngcè, yǒulì zǔduàn le diǎn quēfábìng zhè yí céng wēihài shù yì qúnzhòng shēntǐ yǔ zhìlì jiànkāng de zhòngdà dìfāngbìng de fāshēng liúxíng.', 'Nhà nước triển khai nghiêm ngặt chính sách toàn dân sử dụng muối i-ốt, ngăn chặn hữu hiệu sự phát sinh lưu hành của căn bệnh địa phương nghiêm trọng thiếu i-ốt từng đe dọa sức khỏe thể chất và trí tuệ của hàng trăm triệu người dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [严格] (yángé) - nghiêm khắc, nghiêm ngặt [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '严格' AND pinyin = 'yángé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '严格'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'yángé',
      meaning_vi = 'nghiêm khắc, nghiêm ngặt',
      example_hanzi = '王教练在平时的体育技能训练中对队员们要求极其严格。',
      example_pinyin = 'Wáng jiàoliàn zài píngshí de tǐyù jìnéng xùnliàn zhōng duì duìyuánmen yāoqiú jíqí yángé.',
      example_vi = 'Huấn luyện viên Vương trong các buổi huấn luyện kỹ năng thể thao thường ngày có yêu cầu cực kỳ nghiêm khắc đối với các đội viên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '王教练在平时的体育技能训练中对队员们要求极其严格。', 'Wáng jiàoliàn zài píngshí de tǐyù jìnéng xùnliàn zhōng duì duìyuánmen yāoqiú jíqí yángé.', 'Huấn luyện viên Vương trong các buổi huấn luyện kỹ năng thể thao thường ngày có yêu cầu cực kỳ nghiêm khắc đối với các đội viên.', 'basic', 1),
        (v_id, '食品药品监督管理机构严格实行全链条追溯与最严厉的问责查处机制，坚决守护好人民群众舌尖上的每一处安全防线。', 'Shípǐn yàopǐn jiāndū guǎnlǐ jīgòu yángé shíxíng quánliàntiáo zhuīsù yǔ zuì yánlì de wènzé cháchǔ jīzhì, jiānjué shǒuhù hǎo rénmín qúnzhòng shéjiān shang de měi yí chù ānquán fángxiàn.', 'Cơ quan quản lý giám sát dược phẩm và thực phẩm thực thi nghiêm ngặt việc truy xuất nguồn gốc toàn chuỗi và cơ chế truy cứu trách nhiệm xử lý nghiêm khắc nhất, kiên quyết chở che từng phòng tuyến an toàn trên đầu lưỡi của quần chúng nhân dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [研究] (yánjiū) - nghiên cứu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '研究' AND pinyin = 'yánjiū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '研究'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'yánjiū',
      meaning_vi = 'nghiên cứu',
      example_hanzi = '李教授带领年轻学生们在国家重点实验室认真进行细胞生物学实验研究。',
      example_pinyin = 'Lǐ jiàoshòu dàilǐng niánqīng xuéshengmen zài guójiā zhòngdiǎn shíyànshì rènzhēn jìnxíng xìbāo shēngwùxué shíyàn yánjiū.',
      example_vi = 'Giáo sư Lý dẫn dắt các sinh viên trẻ chăm chỉ tiến hành nghiên cứu thí nghiệm sinh học tế bào tại phòng thí nghiệm trọng điểm quốc gia.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '李教授带领年轻学生们在国家重点实验室认真进行细胞生物学实验研究。', 'Lǐ jiàoshòu dàilǐng niánqīng xuéshengmen zài guójiā zhòngdiǎn shíyànshì rènzhēn jìnxíng xìbāo shēngwùxué shíyàn yánjiū.', 'Giáo sư Lý dẫn dắt các sinh viên trẻ chăm chỉ tiến hành nghiên cứu thí nghiệm sinh học tế bào tại phòng thí nghiệm trọng điểm quốc gia.', 'basic', 1),
        (v_id, '基础科学研究是整个科学技术的源头活水，国家持续加大对数学、物理等基础前沿研究的长期稳定支持力度。', 'Jīchǔ kēxué yánjiū shì zhěnggè kēxué jìshù de yuántóu-huóshuǐ, guójiā chíxù jiàdà duì shùxué, wùlǐ děng jīchǔ qiányán yánjiū de chángqī wěndìng zhīchí lìdù.', 'Nghiên cứu khoa học cơ bản là dòng nước đầu nguồn của toàn bộ khoa học kỹ thuật, nhà nước không ngừng tăng cường mức độ hỗ trợ ổn định lâu dài cho các nghiên cứu mũi nhọn cơ bản như toán học, vật lý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [研究生] (yánjiūshēng) - nghiên cứu sinh, học viên cao học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '研究生' AND pinyin = 'yánjiūshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '研究生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yánjiūshēng',
      meaning_vi = 'nghiên cứu sinh, học viên cao học',
      example_hanzi = '大学毕业后，他选择继续留校攻读材料工程专业的硕士研究生。',
      example_pinyin = 'Dàxué bìyè hòu, tā xuǎnzé jìxù liú xiào gōngdú cáiliào gōngchéng zhuānyè de shuòshì yánjiūshēng.',
      example_vi = 'Sau khi tốt nghiệp đại học, anh ấy chọn tiếp tục ở lại trường theo học cao học thạc sĩ chuyên ngành kỹ thuật vật liệu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大学毕业后，他选择继续留校攻读材料工程专业的硕士研究生。', 'Dàxué bìyè hòu, tā xuǎnzé jìxù liú xiào gōngdú cáiliào gōngchéng zhuānyè de shuòshì yánjiūshēng.', 'Sau khi tốt nghiệp đại học, anh ấy chọn tiếp tục ở lại trường theo học cao học thạc sĩ chuyên ngành kỹ thuật vật liệu.', 'basic', 1),
        (v_id, '教育部积极推进专业学位研究生教育分类培养模式综合改革，全面强化高层次应用型专门人才的核心创新实践能力培养。', 'Jiàoyù Bù jījí tuījìn zhuānyè xuéwèi yánjiūshēng jiàoyù fēnlèi péiyǎng móshì zōnghé gǎigé, quánmiàn qiánghuà gāo céngcì yìngyòngxíng zhuānmén réncái de héxīn chuàngxīn shíjiàn nénglì péiyǎng.', 'Bộ Giáo dục tích cực thúc đẩy cải cách tổng hợp mô hình đào tạo phân loại học viên cao học theo định hướng bằng chuyên nghiệp, tăng cường toàn diện việc bồi dưỡng năng lực thực tiễn đổi mới cốt lõi của nhân tài chuyên môn ứng dụng trình độ cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [严重] (yánzhòng) - nghiêm trọng, trầm trọng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '严重' AND pinyin = 'yánzhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '严重'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yánzhòng',
      meaning_vi = 'nghiêm trọng, trầm trọng',
      example_hanzi = '由于昨天突降暴雪，部分山区高速公路出现了严重的交通堵塞。',
      example_pinyin = 'Yóuyú zuótiān tū jiàng bàoxuě, bùfen shānqū gāosù gōnglù chūxiàn le yánzhòng de jiāotōng dǔsè.',
      example_vi = 'Do hôm qua bão tuyết bất ngờ đổ xuống, một số đoạn đường cao tốc miền núi đã xuất hiện tình trạng ùn tắc giao thông nghiêm trọng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '由于昨天突降暴雪，部分山区高速公路出现了严重的交通堵塞。', 'Yóuyú zuótiān tū jiàng bàoxuě, bùfen shānqū gāosù gōnglù chūxiàn le yánzhòng de jiāotōng dǔsè.', 'Do hôm qua bão tuyết bất ngờ đổ xuống, một số đoạn đường cao tốc miền núi đã xuất hiện tình trạng ùn tắc giao thông nghiêm trọng.', 'basic', 1),
        (v_id, '全球气候变暖引发的极端干旱与洪涝灾害频发，已对全球脆弱生态平衡与发展中国家的粮食安全构成了极其严重的现实威胁。', 'Quánqiú qìhòu biànnuǎn yǐnfā de jíduān gānhàn yǔ hónglào zāihài pínfā, yǐ duì quánqiú cuìruò shēngtài pínghéng yǔ fāzhǎnzhōng guójiā de liángshi ānquán gòuchéng le jíqí yánzhòng de xiànshí wēixié.', 'Hạn hán và lũ lụt khắc nghiệt thường xuyên xảy ra do sự ấm lên của khí hậu toàn cầu đã tạo nên mối đe dọa thực tế cực kỳ nghiêm trọng đối với sự cân bằng sinh thái mong manh toàn cầu và an ninh lương thực của các nước đang phát triển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [演] (yǎn) - diễn, đóng phim, biểu diễn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '演' AND pinyin = 'yǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '演'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yǎn',
      meaning_vi = 'diễn, đóng phim, biểu diễn',
      example_hanzi = '这部新上映的儿童历史情景剧演得非常生动感人，吸引了成千上万的小朋友观赏。',
      example_pinyin = 'Zhè bù xīn shàngyìng de értóng lìshǐ qíngjǐngjù yǎn de fēicháng shēngdòng gǎnrén, xīyǐn le chéngqiān-shàngwàn de xiǎopéngyou guānshǎng.',
      example_vi = 'Vở kịch tình huống lịch sử thiếu nhi mới công chiếu này diễn rất sinh động và xúc động, thu hút hàng vạn em nhỏ đến thưởng thức.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这部新上映的儿童历史情景剧演得非常生动感人，吸引了成千上万的小朋友观赏。', 'Zhè bù xīn shàngyìng de értóng lìshǐ qíngjǐngjù yǎn de fēicháng shēngdòng gǎnrén, xīyǐn le chéngqiān-shàngwàn de xiǎopéngyou guānshǎng.', 'Vở kịch tình huống lịch sử thiếu nhi mới công chiếu này diễn rất sinh động và xúc động, thu hút hàng vạn em nhỏ đến thưởng thức.', 'basic', 1),
        (v_id, '老一辈表演艺术家通过细腻入微的情感刻画与精湛深厚的台词功底，在话剧舞台上将经典历史人物形象演得栩栩如生、入木三分。', 'Lǎoyíbèi biǎoyǎn yìshùjiā tōngguò xìnì-rùwēi de qínggǎn kèhuà yǔ jīngzhàn shēnhòu de táicí gōngdǐ, zài huàjù wǔtái shang jiāng jīngdiǎn lìshǐ rénwù xíngxiàng yǎn de xǔxǔ-rúshēng, rùmù-sānfēn.', 'Thế hệ nghệ sĩ biểu diễn tiền bối thông qua sự khắc họa cảm xúc tỉ mỉ đến từng chi tiết và công phu thoại kịch tinh thâm điêu luyện, đã diễn xuất hình tượng nhân vật lịch sử kinh điển trên sân khấu kịch nói sống động như thật, sâu sắc đến mức khắc sâu vào tâm khảm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [演唱] (yǎnchàng) - hát, biểu diễn ca hát [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '演唱' AND pinyin = 'yǎnchàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '演唱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yǎnchàng',
      meaning_vi = 'hát, biểu diễn ca hát',
      example_hanzi = '在新年音乐晚会上，著名青年歌唱家深情演唱了中国经典民歌《茉莉花》。',
      example_pinyin = 'Zài xīnnián yīnyuè wǎnhuì shang, zhùmíng qīngnián gēchàngjiā shēnqíng yǎnchàng le Zhōngguó jīngdiǎn míngē “Mòlìhuā”.',
      example_vi = 'Trong đêm dạ hội âm nhạc đón năm mới, ca sĩ trẻ nổi tiếng đã biểu diễn ca khúc dân ca kinh điển Trung Quốc "Hoa Nhài" đầy truyền cảm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在新年音乐晚会上，著名青年歌唱家深情演唱了中国经典民歌《茉莉花》。', 'Zài xīnnián yīnyuè wǎnhuì shang, zhùmíng qīngnián gēchàngjiā shēnqíng yǎnchàng le Zhōngguó jīngdiǎn míngē “Mòlìhuā”.', 'Trong đêm dạ hội âm nhạc đón năm mới, ca sĩ trẻ nổi tiếng đã biểu diễn ca khúc dân ca kinh điển Trung Quốc "Hoa Nhài" đầy truyền cảm.', 'basic', 1),
        (v_id, '千人少年合唱团在大型国际盛会开幕式上以天籁般的清澈童声激昂演唱主题歌曲，向全世界传递了携手共建人类命运共同体的美好愿景。', 'Qiān rén shàonián héchàngtuán zài dàxíng guójì shènghuì kāimùshì shang yǐ tiānlài bān de qīngchè tóngshēng jī’áng yǎnchàng zhǔtí gēqǔ, xiàng quán shìjiè chuándì le xiéshǒu gòngjiàn rénlèi mìngyùn gòngtóngtǐ de měihǎo yuànjǐng.', 'Dàn hợp xướng thiếu niên ngàn người trong lễ khai mạc đại hội quốc tế lớn bằng giọng hát trẻ thơ trong trẻo tựa thanh âm của trời đã cất cao bài hát chủ đề đầy hào hùng, truyền tải tới toàn thế giới viễn cảnh tốt đẹp về việc chung tay xây dựng cộng đồng chung vận mệnh nhân loại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [演出] (yǎnchū) - biểu diễn, buổi biểu diễn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '演出' AND pinyin = 'yǎnchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '演出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'yǎnchū',
      meaning_vi = 'biểu diễn, buổi biểu diễn',
      example_hanzi = '今晚大剧院有一场精彩的交响乐演出，我们早点出发吧。',
      example_pinyin = 'Jīnwǎn dàjùyuàn yǒu yì chǎng jīngcǎi de jiāoxiǎngyuè yǎnchū, wǒmen zǎodiǎn chūfā ba.',
      example_vi = 'Tối nay tại nhà hát lớn có một buổi biểu diễn giao hưởng đặc sắc, chúng ta xuất phát sớm chút nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今晚大剧院有一场精彩的交响乐演出，我们早点出发吧。', 'Jīnwǎn dàjùyuàn yǒu yì chǎng jīngcǎi de jiāoxiǎngyuè yǎnchū, wǒmen zǎodiǎn chūfā ba.', 'Tối nay tại nhà hát lớn có một buổi biểu diễn giao hưởng đặc sắc, chúng ta xuất phát sớm chút nhé.', 'basic', 1),
        (v_id, '青年交响乐团圆满完成赴海外交流演出任务，以高水准的艺术表现赢得了国际舆论的高度赞誉。', 'Qīngnián jiāoxiǎng yuètuán yuánmǎn wánchéng fù hǎiwài jiāoliú yǎnchū rènwu, yǐ gāo shuǐzhǔn de yìshù biǎoxiàn yíngdé le guójì yúlùn de gāodù zànyù.', 'Dàn nhạc giao hưởng thanh niên đã hoàn thành viên mãn chuyến lưu diễn giao lưu tại nước ngoài, giành được sự ngợi khen cao độ của dư luận quốc tế nhờ màn trình diễn nghệ thuật đỉnh cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [眼镜] (yǎnjìng) - kính mắt, kính đeo mắt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '眼镜' AND pinyin = 'yǎnjìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '眼镜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yǎnjìng',
      meaning_vi = 'kính mắt, kính đeo mắt',
      example_hanzi = '奶奶经常找不到自己的老花眼镜，总是需要孩子们帮忙寻找。',
      example_pinyin = 'Nǎinai jīngcháng zhǎobudào zìjǐ de lǎohuā yǎnjìng, zǒngshì xūyào háizimen bāngmáng xúnzhǎo.',
      example_vi = 'Bà nội thường không tìm thấy kính lão của mình, lúc nào cũng cần các cháu giúp tìm kiếm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '奶奶经常找不到自己的老花眼镜，总是需要孩子们帮忙寻找。', 'Nǎinai jīngcháng zhǎobudào zìjǐ de lǎohuā yǎnjìng, zǒngshì xūyào háizimen bāngmáng xúnzhǎo.', 'Bà nội thường không tìm thấy kính lão của mình, lúc nào cũng cần các cháu giúp tìm kiếm.', 'basic', 1),
        (v_id, '长期面对电脑和手机屏幕的上班族应佩戴防蓝光眼镜，并定期进行视力健康检查以保护用眼健康。', 'Chángqī miànduì diànnǎo hé shǒujī píngmù de shàngbānzú yīng pèidài fáng lánguāng yǎnjìng, bìng dìngqī jìnxíng shìlì jiànkāng jiǎnchá yǐ bǎohù yòngyǎn jiànkāng.', 'Dân công sở thường xuyên đối diện với màn hình máy tính và điện thoại nên đeo kính chống ánh sáng xanh, đồng thời khám thị lực định kỳ để bảo vệ sức khỏe mắt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [眼前] (yǎnqián) - trước mắt, hiện tại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '眼前' AND pinyin = 'yǎnqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '眼前'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yǎnqián',
      meaning_vi = 'trước mắt, hiện tại',
      example_hanzi = '穿过茂密的松树林，眼前顿时出现了一片碧绿平静的湖泊。',
      example_pinyin = 'Chuānguò màomì de sōngshùlín, yǎnqián dùnshí chūxiàn le yí piàn bìlǜ píngjìng de húpò.',
      example_vi = 'Đi xuyên qua rừng thông rậm rạp, trước mắt lập tức hiện ra một hồ nước xanh biếc và tĩnh lặng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '穿过茂密的松树林，眼前顿时出现了一片碧绿平静的湖泊。', 'Chuānguò màomì de sōngshùlín, yǎnqián dùnshí chūxiàn le yí piàn bìlǜ píngjìng de húpò.', 'Đi xuyên qua rừng thông rậm rạp, trước mắt lập tức hiện ra một hồ nước xanh biếc và tĩnh lặng.', 'basic', 1),
        (v_id, '面对眼前复杂多变的经济转型困难，我们既要立足当前解决突出矛盾，更要着眼长远谋划高质量发展。', 'Miànduì yǎnqián fùzá duōbiàn de jīngjì zhuǎnxíng kùnnan, wǒmen jì yào lìzú dāngqián jiějué tūchū máodùn, gèng yào zhuóyǎn chángyuǎn móuhuà gāo zhìliàng fāzhǎn.', 'Đối mặt với những khó khăn phức tạp trước mắt trong quá trình chuyển đổi kinh tế, chúng ta vừa phải xuất phát từ hiện tại giải quyết các mâu thuẫn nổi cộm, vừa phải hướng tầm nhìn dài hạn quy hoạch phát triển chất lượng cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [演员] (yǎnyuán) - diễn viên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '演员' AND pinyin = 'yǎnyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '演员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yǎnyuán',
      meaning_vi = 'diễn viên',
      example_hanzi = '他从小就梦想成为一名出色的电影演员，给观众带来快乐和感动。',
      example_pinyin = 'Tā cóngxiǎo jiù mèngxiǎng chéngwéi yì míng chūsè de diànyǐng yǎnyuán, gěi guānzhòng dàilái kuàilè hé gǎndòng.',
      example_vi = 'Từ nhỏ anh ấy đã mơ ước trở thành một diễn viên điện ảnh xuất sắc, mang lại niềm vui và sự xúc động cho khán giả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他从小就梦想成为一名出色的电影演员，给观众带来快乐和感动。', 'Tā cóngxiǎo jiù mèngxiǎng chéngwéi yì míng chūsè de diànyǐng yǎnyuán, gěi guānzhòng dàilái kuàilè hé gǎndòng.', 'Từ nhỏ anh ấy đã mơ ước trở thành một diễn viên điện ảnh xuất sắc, mang lại niềm vui và sự xúc động cho khán giả.', 'basic', 1),
        (v_id, '优秀的影视演员不仅需要具备深厚的专业艺术修养，更应坚守职业道德，以德艺双馨赢得广大观众的尊重。', 'Yōuxiù de yǐngshì yǎnyuán bùjǐn xūyào jùbèi shēnhòu de zhuānyè yìshù xiūyǎng, gèng yīng jiānshǒu zhíyè dàodé, yǐ dé-yì shuāngxīn yíngdé guǎngdà guānzhòng de zūnzhòng.', 'Diễn viên truyền hình và điện ảnh xuất sắc không chỉ cần có hàm dưỡng nghệ thuật chuyên nghiệp sâu sắc, mà còn phải giữ vững đạo đức nghề nghiệp, dùng tài đức vẹn toàn để giành lấy sự tôn trọng của đông đảo khán giả.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [阳光] (yángguāng) - ánh nắng; lạc quan, rạng rỡ [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '阳光' AND pinyin = 'yángguāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '阳光'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'yángguāng',
      meaning_vi = 'ánh nắng; lạc quan, rạng rỡ',
      example_hanzi = '清晨温暖的阳光透过窗户洒在桌子上，让人感到十分惬意。',
      example_pinyin = 'Qīngchén wēnnuǎn de yángguāng tòuguò chuānghu sǎ zài zhuōzi shang, ràng rén gǎndào shífēn qièyì.',
      example_vi = 'Ánh nắng ấm áp ban sớm xuyên qua cửa sổ chiếu rọi lên mặt bàn, khiến người ta cảm thấy vô cùng khoan khoái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清晨温暖的阳光透过窗户洒在桌子上，让人感到十分惬意。', 'Qīngchén wēnnuǎn de yángguāng tòuguò chuānghu sǎ zài zhuōzi shang, ràng rén gǎndào shífēn qièyì.', 'Ánh nắng ấm áp ban sớm xuyên qua cửa sổ chiếu rọi lên mặt bàn, khiến người ta cảm thấy vô cùng khoan khoái.', 'basic', 1),
        (v_id, '建立健全阳光高效的现代政务服务机制，旨在全面提升行政审批公开透明度与群众满意度。', 'Jiànlì jiànquán yángguāng gāoxiào de xiàndài zhèngwù fúwù jīzhì, zhǐ zài quánmiàn tíshēng xíngzhèng shěnpī gōngkāi tòumíngdù yǔ qúnzhòng mǎnyìdù.', 'Xây dựng và hoàn thiện cơ chế dịch vụ hành chính hiện đại minh bạch và hiệu quả nhằm nâng cao toàn diện tính công khai, minh bạch trong phê duyệt hành chính và sự hài lòng của quần chúng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [养成] (yǎngchéng) - hình thành, rèn luyện (thói quen) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '养成' AND pinyin = 'yǎngchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '养成'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yǎngchéng',
      meaning_vi = 'hình thành, rèn luyện (thói quen)',
      example_hanzi = '每天晚上按时睡觉并坚持早起晨读，有助于养成良好的生活习惯。',
      example_pinyin = 'Měitiān wǎnshang ànshí shuìjiào bìng jiānchí zǎoqǐ chéndú, yǒu zhù yú yǎngchéng liánghǎo de shēnghuó xíguàn.',
      example_vi = 'Mỗi tối đi ngủ đúng giờ và kiên trì dậy sớm đọc sách buổi sáng giúp hình thành thói quen sinh hoạt tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天晚上按时睡觉并坚持早起晨读，有助于养成良好的生活习惯。', 'Měitiān wǎnshang ànshí shuìjiào bìng jiānchí zǎoqǐ chéndú, yǒu zhù yú yǎngchéng liánghǎo de shēnghuó xíguàn.', 'Mỗi tối đi ngủ đúng giờ và kiên trì dậy sớm đọc sách buổi sáng giúp hình thành thói quen sinh hoạt tốt.', 'basic', 1),
        (v_id, '青年学者应在长期的严谨学术训练中养成独立思考与勇于创新的优良科学素养。', 'Qīngnián xuézhě yīng zài chángqī de yánjǐn xuéshù xùnliàn zhōng yǎngchéng dúlì sīkǎo yǔ yǒngyú chuàngxīn de yōuliáng kēxué sùyǎng.', 'Học giả trẻ cần rèn luyện năng lực tư duy độc lập và tố chất khoa học xuất sắc dám nghĩ dám làm trong quá trình rèn luyện học thuật nghiêm cẩn lâu dài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [样子] (yàngzi) - dáng vẻ, diện mạo, bộ dạng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '样子' AND pinyin = 'yàngzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '样子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yàngzi',
      meaning_vi = 'dáng vẻ, diện mạo, bộ dạng',
      example_hanzi = '看到弟弟吃西瓜时满脸是汁的可爱样子，全家人都忍不住笑了。',
      example_pinyin = 'Kàndào dìdi chī xīguā shí mǎn liǎn shì zhī de kě’ài yàngzi, quán jiā rén dōu rěnbuzhù xiào le.',
      example_vi = 'Nhìn thấy bộ dạng đáng yêu mặt dính đầy nước khi ăn dưa hấu của em trai, cả nhà đều nhịn không được bật cười.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '看到弟弟吃西瓜时满脸是汁的可爱样子，全家人都忍不住笑了。', 'Kàndào dìdi chī xīguā shí mǎn liǎn shì zhī de kě’ài yàngzi, quán jiā rén dōu rěnbuzhù xiào le.', 'Nhìn thấy bộ dạng đáng yêu mặt dính đầy nước khi ăn dưa hấu của em trai, cả nhà đều nhịn không được bật cười.', 'basic', 1),
        (v_id, '看这阴沉的天气和剧降的气温，似乎很快就要迎来入冬以来的第一场暴风雪了。', 'Kàn zhè yīnchén de tiānqì hé jù jiàng de qìwēn, sìhū hěn kuài jiù yào yínglái rùdōng yǐlái de dì-yī chǎng bàofēngxuě le.', 'Nhìn thời tiết u ám này cùng nhiệt độ sụt giảm mạnh, dường như sắp đón đợt bão tuyết đầu tiên kể từ đầu mùa đông rồi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [邀请] (yāoqǐng) - mời, lời mời [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '邀请' AND pinyin = 'yāoqǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '邀请'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'yāoqǐng',
      meaning_vi = 'mời, lời mời',
      example_hanzi = '他热情邀请所有大学同班同学参加周末举办的生日聚会。',
      example_pinyin = 'Tā rèqíng yāoqǐng suǒyǒu dàxué tóngbān tóngxué cānjiā zhōumò jǔbàn de shēngrì jùhuì.',
      example_vi = 'Anh ấy nhiệt tình mời tất cả các bạn học cùng lớp đại học tham dự buổi tiệc sinh nhật tổ chức vào cuối tuần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他热情邀请所有大学同班同学参加周末举办的生日聚会。', 'Tā rèqíng yāoqǐng suǒyǒu dàxué tóngbān tóngxué cānjiā zhōumò jǔbàn de shēngrì jùhuì.', 'Anh ấy nhiệt tình mời tất cả các bạn học cùng lớp đại học tham dự buổi tiệc sinh nhật tổ chức vào cuối tuần.', 'basic', 1),
        (v_id, '主办方正式邀请国际顶尖人工智能领域专家学者，共同出席全球前沿科技发展高层论坛并作主旨报告。', 'Zhǔbànfāng zhèngshì yāoqǐng guójì dǐngjiān réngōng zhìnéng lǐngyù zhuānjiā xuézhě, gòngtóng chūxí quánqiú qiányán kējì fāzhǎn gāocéng lùntán bìng zuò zhǔzhǐ bàogào.', 'Ban tổ chức chính thức mời các chuyên gia, học giả hàng đầu thế giới trong lĩnh vực trí tuệ nhân tạo cùng tham dự diễn đàn cấp cao về phát triển khoa học công nghệ tiên phong toàn cầu và trình bày báo cáo chủ đề.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [要是] (yàoshi) - nếu, nếu như [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '要是' AND pinyin = 'yàoshi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '要是'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'yàoshi',
      meaning_vi = 'nếu, nếu như',
      example_hanzi = '要是明天下大雨，我们计划好的郊外野餐活动就只能推迟到下周了。',
      example_pinyin = 'Yàoshi míngtiān xià dàyǔ, wǒmen jìhuà hǎo de jiāowài yěcān huódòng jiù zhǐ néng tuīchí dào xià zhōu le.',
      example_vi = 'Nếu ngày mai trời đổ mưa to, hoạt động dã ngoại ngoài trời chúng ta lên kế hoạch đành phải hoãn lại sang tuần sau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '要是明天下大雨，我们计划好的郊外野餐活动就只能推迟到下周了。', 'Yàoshi míngtiān xià dàyǔ, wǒmen jìhuà hǎo de jiāowài yěcān huódòng jiù zhǐ néng tuīchí dào xià zhōu le.', 'Nếu ngày mai trời đổ mưa to, hoạt động dã ngoại ngoài trời chúng ta lên kế hoạch đành phải hoãn lại sang tuần sau.', 'basic', 1),
        (v_id, '企业要是忽视产品质量把控与售后服务，就难以在日趋激烈的全球市场竞争中立足并获得长远发展。', 'Qǐyè yàoshi hūshì chǎnpǐn zhìliàng bǎkòng yǔ shòuhòu fúwù, jiù nányǐ zài rìqū jīliè de quánqiú shìchǎng jìngzhēng zhōng lìzú bìng huòdé chángyuǎn fāzhǎn.', 'Doanh nghiệp nếu lơ là việc kiểm soát chất lượng sản phẩm và dịch vụ sau bán hàng, sẽ rất khó đứng vững và đạt được sự phát triển lâu dài trong cuộc cạnh tranh thị trường toàn cầu ngày càng khốc liệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [钥匙] (yàoshi) - chìa khóa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '钥匙' AND pinyin = 'yàoshi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '钥匙'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yàoshi',
      meaning_vi = 'chìa khóa',
      example_hanzi = '临出门前一定要检查清楚，千万不要把家里的大门钥匙忘在玄关柜子上。',
      example_pinyin = 'Lín chūmén qián yídìng yào jiǎnchá qīngchu, qiānwàn bú yào bǎ jiā lǐ de dàmén yàoshi wàng zài xuánguān guìzi shang.',
      example_vi = 'Trước khi ra khỏi nhà nhất định phải kiểm tra kỹ càng, tuyệt đối đừng để quên chìa khóa cửa chính trên tủ lối vào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '临出门前一定要检查清楚，千万不要把家里的大门钥匙忘在玄关柜子上。', 'Lín chūmén qián yídìng yào jiǎnchá qīngchu, qiānwàn bú yào bǎ jiā lǐ de dàmén yàoshi wàng zài xuánguān guìzi shang.', 'Trước khi ra khỏi nhà nhất định phải kiểm tra kỹ càng, tuyệt đối đừng để quên chìa khóa cửa chính trên tủ lối vào.', 'basic', 1),
        (v_id, '坚持自主创新与全面深化科技体制改革，是打开高质量发展新局面、突破核心技术瓶颈的“金钥匙”。', 'Jiānchí zìzhǔ chuàngxīn yǔ quánmiàn shēnhuà kējì tǐzhì gǎigé, shì dǎkāi gāo zhìliàng fāzhǎn xīn júmiàn, tūpò héxīn jìshù píngjǐng de “jīnyàoshi”.', 'Kiên trì tự chủ đổi mới và đi sâu cải cách toàn diện thể chế khoa học công nghệ là "chìa khóa vàng" mở ra cục diện mới phát triển chất lượng cao và đột phá điểm nghẽn công nghệ cốt lõi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [也许] (yěxǔ) - có lẽ, có thể [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '也许' AND pinyin = 'yěxǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '也许'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'yěxǔ',
      meaning_vi = 'có lẽ, có thể',
      example_hanzi = '他今天一直没有回复消息，也许是因为工作太忙还没有顾上看手机。',
      example_pinyin = 'Tā jīntiān yìzhí méiyǒu huífù xiāoxi, yěxǔ shì yīnwèi gōngzuò tài máng hái méiyǒu gùshang kàn shǒujī.',
      example_vi = 'Hôm nay anh ấy mãi không trả lời tin nhắn, có lẽ là do công việc bận rộn quá chưa kịp xem điện thoại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他今天一直没有回复消息，也许是因为工作太忙还没有顾上看手机。', 'Tā jīntiān yìzhí méiyǒu huífù xiāoxi, yěxǔ shì yīnwèi gōngzuò tài máng hái méiyǒu gùshang kàn shǒujī.', 'Hôm nay anh ấy mãi không trả lời tin nhắn, có lẽ là do công việc bận rộn quá chưa kịp xem điện thoại.', 'basic', 1),
        (v_id, '在探索宇宙未知领域的漫长征程中，一次次偶然的实验失败也许正是孕育重大科技突破的前奏与催化剂。', 'Zài tànsuǒ yǔzhòu wèizhī lǐngyù de màncháng zhēngchéng zhōng, yícì cì ǒurán de shíyàn shībài yěxǔ zhèng shì yùnyù zhòngdà kējì tūpò de qiánzòu yǔ cuīhuàjì.', 'Trong hành trình dài khám phá những lĩnh vực chưa biết của vũ trụ, từng thất bại ngẫu nhiên trong các thí nghiệm có lẽ chính là khúc dạo đầu và chất xúc tác ấp ủ những đột phá công nghệ trọng đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [夜] (yè) - đêm, ban đêm [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '夜' AND pinyin = 'yè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '夜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'yè',
      meaning_vi = 'đêm, ban đêm',
      example_hanzi = '临近考试周，图书馆里整夜都亮着温暖的灯光，很多学生在刻苦复习。',
      example_pinyin = 'Línjìn kǎoshìzhōu, túshūguǎn lǐ zhěng yè dōu liàngzhe wēnnuǎn de dēngguāng, hěn duō xuésheng zài kèkǔ fùxí.',
      example_vi = 'Gần tới tuần thi cử, trong thư viện suốt đêm đều sáng rực ánh đèn ấm áp, nhiều học sinh đang chăm chỉ ôn tập.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '临近考试周，图书馆里整夜都亮着温暖的灯光，很多学生在刻苦复习。', 'Línjìn kǎoshìzhōu, túshūguǎn lǐ zhěng yè dōu liàngzhe wēnnuǎn de dēngguāng, hěn duō xuésheng zài kèkǔ fùxí.', 'Gần tới tuần thi cử, trong thư viện suốt đêm đều sáng rực ánh đèn ấm áp, nhiều học sinh đang chăm chỉ ôn tập.', 'basic', 1),
        (v_id, '边防战士日夜坚守在祖国海拔数千米的雪域高原边防哨所，忠诚捍卫着国家领土主权与边境安全。', 'Biānfáng zhànshì rì yè jiānshǒu zài zǔguó hǎibá shù qiān mǐ de xuěyù gāoyuán biānfáng shàosuǒ, zhōngchéng hànwèi zhe guójiā lǐngtǔ zhǔquán yǔ biānjìng ānquán.', 'Các chiến sĩ biên phòng ngày đêm kiên trì bám trụ chốt canh biên ải trên vùng cao nguyên phủ tuyết cao hàng ngàn mét so với mực nước biển của tổ quốc, trung thành bảo vệ chủ quyền lãnh thổ và an ninh biên giới quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [夜晚] (yèwǎn) - ban đêm, buổi tối [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '夜晚' AND pinyin = 'yèwǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '夜晚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yèwǎn',
      meaning_vi = 'ban đêm, buổi tối',
      example_hanzi = '夏天的夜晚，公园的湖边凉风习习，很多市民在这里散步聊天。',
      example_pinyin = 'Xiàtiān de yèwǎn, gōngyuán de hú biān liángfēng-xíxí, hěn duō shìmín zài zhèlǐ sànbù liáotiān.',
      example_vi = 'Ban đêm mùa hè, bên bờ hồ công viên gió mát hiu hiu, rất nhiều người dân đi dạo và trò chuyện tại đây.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夏天的夜晚，公园的湖边凉风习习，很多市民在这里散步聊天。', 'Xiàtiān de yèwǎn, gōngyuán de hú biān liángfēng-xíxí, hěn duō shìmín zài zhèlǐ sànbù liáotiān.', 'Ban đêm mùa hè, bên bờ hồ công viên gió mát hiu hiu, rất nhiều người dân đi dạo và trò chuyện tại đây.', 'basic', 1),
        (v_id, '随着现代文旅产业深度融合，繁荣多元的城市“夜间经济”为激发消费潜力与丰富市民夜晚文化生活注入了崭新动能。', 'Suízhe xiàndài wén-lǚ chǎnyè shēndù rónghé, fánróng duōyuán de chéngshì “yèjiān jīngjì” wèi jīfā xiāofèi qiánlì yǔ fēngfù shìmín yèwǎn wénhuà shēnghuó zhùrù le zhǎnxīn dòngnéng.', 'Cùng với sự dung hợp sâu rộng của ngành văn hóa - du lịch hiện đại, "kinh tế ban đêm" đa dạng và phồn vinh của thành phố đã truyền động năng hoàn toàn mới để khơi dậy tiềm năng tiêu dùng và làm phong phú thêm đời sống văn hóa ban đêm của người dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [叶子] (yèzi) - lá cây, chiếc lá [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '叶子' AND pinyin = 'yèzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '叶子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yèzi',
      meaning_vi = 'lá cây, chiếc lá',
      example_hanzi = '秋天到了，银杏树上的绿叶子渐渐变成了金黄色，纷纷飘落在大地上。',
      example_pinyin = 'Qiūtiān dào le, yínxìngshù shang de lǜ yèzi jiànjiàn biàn chéng le jīnhuángsè, fēnfēn piāoluò zài dàdì shang.',
      example_vi = 'Mùa thu đến rồi, lá xanh trên cây ngân hạnh dần ngả sang màu vàng óng, rợp trời bay rụng xuống mặt đất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '秋天到了，银杏树上的绿叶子渐渐变成了金黄色，纷纷飘落在大地上。', 'Qiūtiān dào le, yínxìngshù shang de lǜ yèzi jiànjiàn biàn chéng le jīnhuángsè, fēnfēn piāoluò zài dàdì shang.', 'Mùa thu đến rồi, lá xanh trên cây ngân hạnh dần ngả sang màu vàng óng, rợp trời bay rụng xuống mặt đất.', 'basic', 1),
        (v_id, '植物学家通过分析古老树种叶子化石的气孔密度与化学成分，精准反演了千万年前地球古气候与大气环境演变规律。', 'Zhíwùxuéjiā tōngguò fēnxī gǔlǎo shùzhǒng yèzi huàshí de qìkǒng mìdù yǔ huàxué chéngfèn, jīngzhǔn fǎnyǎn le qiānwàn nián qián Dìqiú gǔ qìhòu yǔ dàqì huánjìng yǎnbiàn guīlǜ.', 'Các nhà thực vật học thông qua việc phân tích mật độ khí khổng và thành phần hóa học của hóa thạch lá của các loài cây cổ thụ, đã tái hiện chuẩn xác quy luật tiến hóa của khí hậu cổ đại và môi trường khí quyển Trái Đất hàng chục triệu năm trước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [一切] (yíqiè) - tất cả, tất thảy, toàn bộ [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '一切' AND pinyin = 'yíqiè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '一切'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ',
      pinyin = 'yíqiè',
      meaning_vi = 'tất cả, tất thảy, toàn bộ',
      example_hanzi = '只要全家人健康平安，生活中的一切困难我们都有信心克服。',
      example_pinyin = 'Zhǐyào quán jiā rén jiànkāng píng’ān, shēnghuó zhōng de yíqiè kùnnan wǒmen dōu yǒu xìnxīn kèfú.',
      example_vi = 'Chỉ cần cả nhà khỏe mạnh bình an, mọi khó khăn trong cuộc sống chúng tôi đều có lòng tin khắc phục.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '只要全家人健康平安，生活中的一切困难我们都有信心克服。', 'Zhǐyào quán jiā rén jiànkāng píng’ān, shēnghuó zhōng de yíqiè kùnnan wǒmen dōu yǒu xìnxīn kèfú.', 'Chỉ cần cả nhà khỏe mạnh bình an, mọi khó khăn trong cuộc sống chúng tôi đều có lòng tin khắc phục.', 'basic', 1),
        (v_id, '地方各级政府必须牢固树立以人民为中心的发展思想，把实现好、维护好、发展好最广大人民根本利益作为一切工作的出发点。', 'Dìfāng gè jí zhèngfǔ bìxū láogù shùlì yǐ rénmín wéi zhōngxīn de fāzhǎn sīxiǎng, bǎ shíxiàn hǎo, wéihù hǎo, fāzhǎn hǎo zuì guǎngdà rénmín gēnběn lìyì zuòwéi yíqiè gōngzuò de chūfādiǎn.', 'Chính quyền các cấp ở địa phương bắt buộc phải xác lập vững chắc tư tưởng phát triển lấy nhân dân làm trung tâm, lấy việc thực hiện tốt, bảo vệ tốt và phát triển tốt lợi ích căn bản của đông đảo nhân dân làm điểm xuất phát cho mọi công tác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [已] (yǐ) - đã, rồi [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '已' AND pinyin = 'yǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '已'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'yǐ',
      meaning_vi = 'đã, rồi',
      example_hanzi = '收到录取通知书时，他悬着的一颗心已彻底放了下来。',
      example_pinyin = 'Shōudào lùqǔ tōngzhīshū shí, tā xuánzhe de yì kē xīn yǐ chèdǐ fàng le xiàlái.',
      example_vi = 'Lúc nhận được giấy báo trúng tuyển, trái tim đang treo lơ lửng của anh ấy đã hoàn toàn buông bỏ được âu lo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '收到录取通知书时，他悬着的一颗心已彻底放了下来。', 'Shōudào lùqǔ tōngzhīshū shí, tā xuánzhe de yì kē xīn yǐ chèdǐ fàng le xiàlái.', 'Lúc nhận được giấy báo trúng tuyển, trái tim đang treo lơ lửng của anh ấy đã hoàn toàn buông bỏ được âu lo.', 'basic', 1),
        (v_id, '历经多年攻坚克难，该国家级重点工程已全面进入系统调试阶段，即将正式并网投入商业运营。', 'Lìjīng duō nián gōngjiān-kènán, gāi guójiā-jí zhòngdiǎn gōngchéng yǐ quánmiàn jìnrù xìtǒng tiáoshì jiēduàn, jíjiāng zhèngshì bìngwǎng tóurù shāngyè yùnyíng.', 'Trải qua nhiều năm khắc phục khó khăn gian khổ, dự án trọng điểm cấp quốc gia này đã tiến vào giai đoạn chạy thử hệ thống toàn diện, sắp chính thức hòa lưới điện vận hành thương mại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [以内] (yǐnèi) - trong vòng, dưới, trong phạm vi [Danh từ / Phương vị từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '以内' AND pinyin = 'yǐnèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '以内'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phương vị từ',
      pinyin = 'yǐnèi',
      meaning_vi = 'trong vòng, dưới, trong phạm vi',
      example_hanzi = '从我们家步行到地铁站，时间一般都在十分钟以内，出行非常便利。',
      example_pinyin = 'Cóng wǒmen jiā bùxíng dào dìtiězhàn, shíjiān yībān dōu zài shí fēnzhōng yǐnèi, chūxíng fēicháng biànlì.',
      example_vi = 'Đi bộ từ nhà chúng tôi đến ga tàu điện ngầm thời gian thường trong vòng mười phút, đi lại vô cùng thuận tiện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '从我们家步行到地铁站，时间一般都在十分钟以内，出行非常便利。', 'Cóng wǒmen jiā bùxíng dào dìtiězhàn, shíjiān yībān dōu zài shí fēnzhōng yǐnèi, chūxíng fēicháng biànlì.', 'Đi bộ từ nhà chúng tôi đến ga tàu điện ngầm thời gian thường trong vòng mười phút, đi lại vô cùng thuận tiện.', 'basic', 1),
        (v_id, '按照国际环保公约最新要求，沿海工业园区必须将主要污染物排放浓度严格控制在法定允许标准以内。', 'Ànzhào guójì huánbǎo gōngyuē zuìxīn yāoqiú, yánhǎi gōngyè yuánqū bìxū jiāng zhǔyào wūrǎnwù páifàng nóngdù yángé kòngzhì zài fǎdìng yǔnxǔ biāozhǔn yǐnèi.', 'Chiếu theo các yêu cầu mới nhất của công ước bảo vệ môi trường quốc tế, các khu công nghiệp ven biển phải kiểm soát nghiêm ngặt nồng độ phát thải các chất ô nhiễm chính trong phạm vi tiêu chuẩn cho phép của pháp luật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [意见] (yìjiàn) - ý kiến, quan điểm; bất đồng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '意见' AND pinyin = 'yìjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '意见'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yìjiàn',
      meaning_vi = 'ý kiến, quan điểm; bất đồng',
      example_hanzi = '开会时大家畅所欲言，各抒己见，提出了许多很有建设性的好意见。',
      example_pinyin = 'Kāihuì shí dàjiā chàngsuǒyùyán, gèshūjǐjiàn, tíchū le xǔduō hěn yǒu jiànshèxìng de hǎo yìjiàn.',
      example_vi = 'Khi họp mọi người nói năng thoải mái, bày tỏ quan điểm của riêng mình, nêu ra rất nhiều ý kiến hay mang tính xây dựng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '开会时大家畅所欲言，各抒己见，提出了许多很有建设性的好意见。', 'Kāihuì shí dàjiā chàngsuǒyùyán, gèshūjǐjiàn, tíchū le xǔduō hěn yǒu jiànshèxìng de hǎo yìjiàn.', 'Khi họp mọi người nói năng thoải mái, bày tỏ quan điểm của riêng mình, nêu ra rất nhiều ý kiến hay mang tính xây dựng.', 'basic', 1),
        (v_id, '司法行政机关在制定重要法规草案过程中，广泛听取社会各界的立法征求意见，全面推进科学民主依法立法。', 'Sīfǎ xíngzhèng jīgòu zài zhìdìng zhòngyào fǎguī cǎo’àn guòchéng zhōng, guǎngfàn tīngqǔ shèhuì gèjiè de lìfǎ zhēngqiú yìjiàn, quánmiàn tuījìn kēxué mínzhǔ yīfǎ lìfǎ.', 'Các cơ quan tư pháp và hành chính trong quá trình soạn thảo dự thảo văn bản pháp quy quan trọng đã lắng nghe rộng rãi ý kiến đóng góp lập pháp của các giới xã hội, thúc đẩy toàn diện việc lập pháp khoa học, dân chủ và theo đúng pháp luật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [一生] (yìshēng) - cả đời, trọn đời [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '一生' AND pinyin = 'yìshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '一生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yìshēng',
      meaning_vi = 'cả đời, trọn đời',
      example_hanzi = '爷爷一生勤勤恳恳、省吃俭用，把几个子女都培养成了对社会有用的人才。',
      example_pinyin = 'Yéye yìshēng qínqín-kěnkěn, shěngchī-jiǎnyòng, bǎ jǐ gè zǐnǚ dōu péiyǎng chéng le duì shèhuì yǒuyòng de réncái.',
      example_vi = 'Ông nội cả đời cần cù chăm chỉ, ăn dè hà tiện, đã nuôi dạy mấy người con đều trở thành nhân tài có ích cho xã hội.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爷爷一生勤勤恳恳、省吃俭用，把几个子女都培养成了对社会有用的人才。', 'Yéye yìshēng qínqín-kěnkěn, shěngchī-jiǎnyòng, bǎ jǐ gè zǐnǚ dōu péiyǎng chéng le duì shèhuì yǒuyòng de réncái.', 'Ông nội cả đời cần cù chăm chỉ, ăn dè hà tiện, đã nuôi dạy mấy người con đều trở thành nhân tài có ích cho xã hội.', 'basic', 1),
        (v_id, '这位享誉国内外的医学大师将自己的一生毫无保留地奉献给了传染病防治科研与临床救治事业。', 'Zhè wèi xiǎngyù guónèi-wài de yīxué dàshī jiāng zìjǐ de yìshēng háowú bǎoliú de fèngxiàn gěi le chuánrǎnbìng fángzhì kēyán yǔ línchuáng jiùzhì shìyè.', 'Vị đại sư y học danh tiếng lẫy lừng trong và ngoài nước này đã cống hiến trọn đời mình không chút giữ lại cho sự nghiệp nghiên cứu khoa học phòng chống và điều trị lâm sàng các bệnh truyền nhiễm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [艺术] (yìshù) - nghệ thuật [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '艺术' AND pinyin = 'yìshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '艺术'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yìshù',
      meaning_vi = 'nghệ thuật',
      example_hanzi = '参观现代艺术展览不仅能开阔眼界，还能大大提升个人的审美情趣。',
      example_pinyin = 'Cānguān xiàndài yìshù zhǎnlǎn bùjǐn néng kāikuò yǎnjiè, hái néng dàdà tíshēng gèrén de shěnměi qíngqù.',
      example_vi = 'Đi tham quan triển lãm nghệ thuật hiện đại không chỉ có thể mở rộng tầm mắt, mà còn nâng cao đáng kể thị hiếu thẩm mỹ cá nhân.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '参观现代艺术展览不仅能开阔眼界，还能大大提升个人的审美情趣。', 'Cānguān xiàndài yìshù zhǎnlǎn bùjǐn néng kāikuò yǎnjiè, hái néng dàdà tíshēng gèrén de shěnměi qíngqù.', 'Đi tham quan triển lãm nghệ thuật hiện đại không chỉ có thể mở rộng tầm mắt, mà còn nâng cao đáng kể thị hiếu thẩm mỹ cá nhân.', 'basic', 1),
        (v_id, '优秀文艺作品应当把思想性、艺术性和观赏性有机统一起来，以高尚的精神品格引领社会文明风尚。', 'Yōuxiù wényì zuòpǐn yīngdāng bǎ sīxiǎngxìng, yìshùxìng hé guānshǎngxìng yǒujī tǒngyī qǐlái, yǐ gāoshàng de jīngshén pǐngé yǐnlǐng shèhuì wénmíng fēngshàng.', 'Các tác phẩm văn học nghệ thuật xuất sắc nên thống nhất hữu cơ tính tư tưởng, tính nghệ thuật và tính thưởng thức, dùng phẩm cách tinh thần cao thượng để dẫn dắt phong khí văn minh xã hội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [因此] (yīncǐ) - vì vậy, do đó, cho nên [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '因此' AND pinyin = 'yīncǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '因此'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'yīncǐ',
      meaning_vi = 'vì vậy, do đó, cho nên',
      example_hanzi = '他平时坚持每天锻炼身体并保证充足睡眠，因此几乎很少生病感冒。',
      example_pinyin = 'Tā píngshí jiānchí měitiān duànliàn shēntǐ bìng bǎozhèng chōngzú shuìmián, yīncǐ jīhū hěn shǎo shēngbìng gǎnmào.',
      example_vi = 'Ngày thường anh ấy kiên trì rèn luyện thân thể mỗi ngày và đảm bảo giấc ngủ đầy đủ, vì vậy hầu như rất ít khi ốm đau cảm cúm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他平时坚持每天锻炼身体并保证充足睡眠，因此几乎很少生病感冒。', 'Tā píngshí jiānchí měitiān duànliàn shēntǐ bìng bǎozhèng chōngzú shuìmián, yīncǐ jīhū hěn shǎo shēngbìng gǎnmào.', 'Ngày thường anh ấy kiên trì rèn luyện thân thể mỗi ngày và đảm bảo giấc ngủ đầy đủ, vì vậy hầu như rất ít khi ốm đau cảm cúm.', 'basic', 1),
        (v_id, '新一代数字信息技术正在重塑全球产业链格局，因此加快推进产业数字化转型升级已成为当务之急。', 'Xīn yídài shùzì xìnxī jìshù zhèngzài chóngshù quánqiú chǎnyèliàn géjú, yīncǐ jiākuài tuījìn chǎnyè shùzìhuà zhuǎnxíng shēngjí yǐ chéngwéi dāngwùzhījí.', 'Công nghệ thông tin kỹ thuật số thế hệ mới đang định hình lại cấu trúc chuỗi công nghiệp toàn cầu, do đó việc đẩy nhanh thúc đẩy nâng cấp chuyển đổi số ngành nghề đã trở thành nhiệm vụ cấp bách hàng đầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [引起] (yǐnqǐ) - gây nên, dấy lên, dẫn đến [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '引起' AND pinyin = 'yǐnqǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '引起'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yǐnqǐ',
      meaning_vi = 'gây nên, dấy lên, dẫn đến',
      example_hanzi = '这部关于青少年心理成长的感人纪录片播出后，立刻引起了家长们的广泛讨论。',
      example_pinyin = 'Zhè bù guānyú qīngshàonián xīnlǐ chéngzhǎng de gǎnrén jìlùpiàn bōchū hòu, lìkè yǐnqǐ le jiāzhǎngmen de guǎngfàn tǎolùn.',
      example_vi = 'Bộ phim tài liệu cảm động về sự trưởng thành tâm lý của thanh thiếu niên này sau khi phát sóng, lập tức dấy lên sự thảo luận rộng rãi trong các bậc phụ huynh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这部关于青少年心理成长的感人纪录片播出后，立刻引起了家长们的广泛讨论。', 'Zhè bù guānyú qīngshàonián xīnlǐ chéngzhǎng de gǎnrén jìlùpiàn bōchū hòu, lìkè yǐnqǐ le jiāzhǎngmen de guǎngfàn tǎolùn.', 'Bộ phim tài liệu cảm động về sự trưởng thành tâm lý của thanh thiếu niên này sau khi phát sóng, lập tức dấy lên sự thảo luận rộng rãi trong các bậc phụ huynh.', 'basic', 1),
        (v_id, '全球大宗商品价格异常剧烈震荡引起了国际金融市场普遍恐慌，促使多国央行紧急调整货币政策基调。', 'Quánqiú dàzōng shāngpǐn jiàgé yìcháng jùliè zhèndàng yǐnqǐ le guójì jīnróng shìchǎng pǔbiàn kǒnghuāng, cùshǐ duō guó yāngháng jǐnjí tiáozhěng huòbì zhèngcè jīdiào.', 'Sự biến động dữ dội bất thường của giá cả hàng hóa thương phẩm lớn toàn cầu đã gây ra nỗi hoang mang phổ biến trên thị trường tài chính quốc tế, thúc đẩy ngân hàng trung ương nhiều nước khẩn cấp điều chỉnh định hướng chính sách tiền tệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [印象] (yìnxiàng) - ấn tượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '印象' AND pinyin = 'yìnxiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '印象'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yìnxiàng',
      meaning_vi = 'ấn tượng',
      example_hanzi = '第一次见到这位温和谦逊的新老师时，他就给我们留下了极其深刻的良好印象。',
      example_pinyin = 'Dì-yī cì jiàndào zhè wèi wēnhé qiānxùn de xīn lǎoshī shí, tā jiù gěi wǒmen liúxià le jíqí shēnkè de liánghǎo yìnxiàng.',
      example_vi = 'Lần đầu tiên gặp gỡ người thầy giáo mới ôn hòa khiêm tốn này, thầy đã để lại cho chúng tôi ấn tượng tốt đẹp vô cùng sâu sắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '第一次见到这位温和谦逊的新老师时，他就给我们留下了极其深刻的良好印象。', 'Dì-yī cì jiàndào zhè wèi wēnhé qiānxùn de xīn lǎoshī shí, tā jiù gěi wǒmen liúxià le jíqí shēnkè de liánghǎo yìnxiàng.', 'Lần đầu tiên gặp gỡ người thầy giáo mới ôn hòa khiêm tốn này, thầy đã để lại cho chúng tôi ấn tượng tốt đẹp vô cùng sâu sắc.', 'basic', 1),
        (v_id, '这座历史文化名城不仅以秀美的山水风光闻名遐迩，更以开放包容的人文精神给海内外游客留下恒久的深刻印象。', 'Zhè zuò lìshǐ wénhuà míngchéng bùjǐn yǐ xiùměi de shānshuǐ fēngguāng wénmíng-xiá’ěr, gèng yǐ kāifàng bāoróng de rénwén jīngshén gěi hǎi-nèiwài yóukè liúxià héngjiǔ de shēnkè yìnxiàng.', 'Danh thành lịch sử văn hóa này không chỉ vang danh gần xa nhờ phong cảnh non nước tươi đẹp, mà còn để lại ấn tượng sâu sắc vĩnh cửu trong lòng du khách trong và ngoài nước nhờ tinh thần nhân văn cởi mở bao dung.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [赢] (yíng) - thắng, chiến thắng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '赢' AND pinyin = 'yíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赢'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yíng',
      meaning_vi = 'thắng, chiến thắng',
      example_hanzi = '经过全队队员的顽强拼搏，我们学校足球队终于赢了这场关键的决赛。',
      example_pinyin = 'Jīngguò quánduì duìyuán de wánqiáng pīnbó, wǒmen xuéxiào zúqiúduì zhōngyú yíng le zhè chǎng guānjiàn de juésài.',
      example_vi = 'Trải qua sự nỗ lực kiên cường của toàn thể thành viên đội bóng, đội bóng đá trường chúng tôi cuối cùng đã chiến thắng trận chung kết then chốt này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全队队员的顽强拼搏，我们学校足球队终于赢了这场关键的决赛。', 'Jīngguò quánduì duìyuán de wánqiáng pīnbó, wǒmen xuéxiào zúqiúduì zhōngyú yíng le zhè chǎng guānjiàn de juésài.', 'Trải qua sự nỗ lực kiên cường của toàn thể thành viên đội bóng, đội bóng đá trường chúng tôi cuối cùng đã chiến thắng trận chung kết then chốt này.', 'basic', 1),
        (v_id, '在激烈的国际高端装备制造市场竞标中，该企业凭借核心自主专利与卓越的性价比一举赢得了数十亿美元的订单。', 'Zài jīliè de guójì gāoduān zhuāngbèi zhìzào shìchǎng jìngbiāo zhōng, gāi qǐyè píngjiè héxīn zìzhǔ zhuānlì yǔ zhuóyuè de xìngjiàbǐ yì jǔ yíngdé le shù shí yì Měiyuán de dìngdān.', 'Trong đợt đấu thầu thị trường chế tạo thiết bị cao cấp quốc tế khốc liệt, doanh nghiệp này nhờ vào sáng chế cốt lõi tự chủ và tỷ lệ hiệu năng trên giá thành vượt trội đã thắng lớn đơn hàng trị giá hàng chục tỷ USD.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [赢得] (yíngdé) - giành được, nhận được, chiếm được [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '赢得' AND pinyin = 'yíngdé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赢得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yíngdé',
      meaning_vi = 'giành được, nhận được, chiếm được',
      example_hanzi = '只要你诚恳待人、信守诺言，就一定能够赢得周围所有朋友的真心信任。',
      example_pinyin = 'Zhǐyào nǐ chéngkěn dài rén, xìnshǒu nuòyán, jiù yídìng nénggòu yíngdé zhōuwéi suǒyǒu péngyou de zhēnxīn xìnrèn.',
      example_vi = 'Chỉ cần bạn đối đãi chân thành với mọi người, giữ trọn lời hứa, nhất định sẽ có thể giành được sự tin tưởng chân thành của tất cả bạn bè xung quanh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '只要你诚恳待人、信守诺言，就一定能够赢得周围所有朋友的真心信任。', 'Zhǐyào nǐ chéngkěn dài rén, xìnshǒu nuòyán, jiù yídìng nénggòu yíngdé zhōuwéi suǒyǒu péngyou de zhēnxīn xìnrèn.', 'Chỉ cần bạn đối đãi chân thành với mọi người, giữ trọn lời hứa, nhất định sẽ có thể giành được sự tin tưởng chân thành của tất cả bạn bè xung quanh.', 'basic', 1),
        (v_id, '中国积极参与全球气候治理并率先作出双碳战略承诺，展现了大国担当并赢得了国际社会的普遍赞赏。', 'Zhōngguó jījí cānyù quánqiú qìhòu zhìlǐ bìng shuàixiān zuòchū shuāngtàn zhànlüè chéngnuò, zhǎnxiàn le dàguó dāndāng bìng yíngdé le guójì shèhuì de pǔbiàn zànshǎng.', 'Trung Quốc tích cực tham gia quản trị khí hậu toàn cầu và tiên phong đưa ra cam kết chiến lược phát thải kép (đạt đỉnh và trung hòa carbon), thể hiện tinh thần gánh vác của một nước lớn và giành được sự tán thưởng phổ biến của cộng đồng quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [应聘] (yìngpìn) - ứng tuyển, xin việc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '应聘' AND pinyin = 'yìngpìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '应聘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yìngpìn',
      meaning_vi = 'ứng tuyển, xin việc',
      example_hanzi = '毕业前夕，他精心准备了中英文个人简历并前往几家大型互联网公司应聘。',
      example_pinyin = 'Bìyè qiánxī, tā jīngxīn zhǔnbèi le Zhōng-Yīngwén gèrén jiǎnlì bìng qiánwǎng jǐ jiā dàxíng hùliánwǎng gōngsī yìngpìn.',
      example_vi = 'Trước khi tốt nghiệp, anh ấy đã chuẩn bị chu đáo sơ yếu lý lịch cá nhân bằng tiếng Trung và tiếng Anh rồi đến ứng tuyển tại một vài công ty internet lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '毕业前夕，他精心准备了中英文个人简历并前往几家大型互联网公司应聘。', 'Bìyè qiánxī, tā jīngxīn zhǔnbèi le Zhōng-Yīngwén gèrén jiǎnlì bìng qiánwǎng jǐ jiā dàxíng hùliánwǎng gōngsī yìngpìn.', 'Trước khi tốt nghiệp, anh ấy đã chuẩn bị chu đáo sơ yếu lý lịch cá nhân bằng tiếng Trung và tiếng Anh rồi đến ứng tuyển tại một vài công ty internet lớn.', 'basic', 1),
        (v_id, '跨国高科技企业面向全球公开招聘顶尖研发工程师，吸引了数百名海外知名高校博士前来应聘。', 'Kuàguó gāo kējì qǐyè miànxiàng quánqiú gōngkāi zhāopìn dǐngjiān yánfā gōngchéngshī, xīyǐn le shù bǎi míng hǎiwài zhīmíng gāoxiào bóshì qiánlái yìngpìn.', 'Doanh nghiệp công nghệ cao đa quốc gia tuyển dụng công khai kỹ sư nghiên cứu phát triển hàng đầu trên toàn cầu, thu hút hàng trăm tiến sĩ từ các trường đại học danh tiếng nước ngoài đến ứng tuyển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [勇敢] (yǒnggǎn) - dũng cảm [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '勇敢' AND pinyin = 'yǒnggǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '勇敢'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yǒnggǎn',
      meaning_vi = 'dũng cảm',
      example_hanzi = '面对湍急的河流，消防员勇敢地跳入水中救起了落水的小女孩。',
      example_pinyin = 'Miànduì tuānjí de héliú, xiāofángyuán yǒnggǎn de tiào rù shuǐ zhōng jiùqǐ le luòshuǐ de xiǎo nǚhái.',
      example_vi = 'Đối mặt với dòng sông chảy xiết, người lính cứu hỏa đã dũng cảm nhảy xuống nước cứu bé gái bị rơi xuống nước.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '面对湍急的河流，消防员勇敢地跳入水中救起了落水的小女孩。', 'Miànduì tuānjí de héliú, xiāofángyuán yǒnggǎn de tiào rù shuǐ zhōng jiùqǐ le luòshuǐ de xiǎo nǚhái.', 'Đối mặt với dòng sông chảy xiết, người lính cứu hỏa đã dũng cảm nhảy xuống nước cứu bé gái bị rơi xuống nước.', 'basic', 1),
        (v_id, '在面对生死考验与重大自然灾害救援中，人民子弟兵展现出了英勇顽强、不怕牺牲的崇高勇敢精神。', 'Zài miànduì shēngsǐ kǎoyàn yǔ zhòngdà zìrán zāihài jiùyuán zhōng, rénmín zǐdìbīng zhǎnxiàn chū le yīngyǒng wánqiáng, bú pà xīshēng de chónggāo yǒnggǎn jīngshén.', 'Khi đối mặt với thử thách sinh tử và công tác cứu hộ thiên tai nghiêm trọng, bộ đội đã thể hiện tinh thần dũng cảm cao cả anh dũng kiên cường, không sợ hy sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [永远] (yǒngyuǎn) - mãi mãi, vĩnh viễn [Phó từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '永远' AND pinyin = 'yǒngyuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '永远'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Danh từ',
      pinyin = 'yǒngyuǎn',
      meaning_vi = 'mãi mãi, vĩnh viễn',
      example_hanzi = '无论时光如何流逝，我们都永远忘不了老师们的悉心教导与关怀。',
      example_pinyin = 'Wúlùn shíguāng rúhé liúshì, wǒmen dōu yǒngyuǎn wàngbuliǎo lǎoshīmen de xīxīn jiàodǎo yǔ guānhuái.',
      example_vi = 'Bất kể thời gian trôi qua thế nào, chúng tôi đều sẽ mãi mãi không quên sự dạy dỗ và quan tâm ân cần của các thầy cô giáo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '无论时光如何流逝，我们都永远忘不了老师们的悉心教导与关怀。', 'Wúlùn shíguāng rúhé liúshì, wǒmen dōu yǒngyuǎn wàngbuliǎo lǎoshīmen de xīxīn jiàodǎo yǔ guānhuái.', 'Bất kể thời gian trôi qua thế nào, chúng tôi đều sẽ mãi mãi không quên sự dạy dỗ và quan tâm ân cần của các thầy cô giáo.', 'basic', 1),
        (v_id, '为中国人民谋幸福、为中华民族谋复兴，是中国共产党人永远不变的崇高初心与历史使命。', 'Wèi Zhōngguó rénmín móu xìngfú, wèi Zhōnghuá mínzú móu fùxīng, shì Zhōngguó Gòngchǎndǎngrén yǒngyuǎn bú biàn de chónggāo chūxīn yǔ lìshǐ shǐmìng.', 'Mưu cầu hạnh phúc cho nhân dân Trung Quốc, mưu cầu phục hưng cho dân tộc Trung Hoa, là tâm nguyện ban đầu cao cả và sứ mệnh lịch sử vĩnh viễn không thay đổi của những người Cộng sản Trung Quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [用来] (yònglái) - dùng để, dùng làm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '用来' AND pinyin = 'yònglái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '用来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yònglái',
      meaning_vi = 'dùng để, dùng làm',
      example_hanzi = '这个大容量便携式保温杯是妈妈买来专门给我冬天用来喝热水的。',
      example_pinyin = 'Zhè ge dà róngliàng biànxiéshì bǎowēnbēi shì māma mǎi lái zhuānmén gěi wǒ dōngtiān yònglái hē rèshuǐ de.',
      example_vi = 'Chiếc bình giữ nhiệt cầm tay dung tích lớn này là mẹ mua dành riêng cho tôi dùng để uống nước ấm vào mùa đông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个大容量便携式保温杯是妈妈买来专门给我冬天用来喝热水的。', 'Zhè ge dà róngliàng biànxiéshì bǎowēnbēi shì māma mǎi lái zhuānmén gěi wǒ dōngtiān yònglái hē rèshuǐ de.', 'Chiếc bình giữ nhiệt cầm tay dung tích lớn này là mẹ mua dành riêng cho tôi dùng để uống nước ấm vào mùa đông.', 'basic', 1),
        (v_id, '地方政府依法发行的专项债券资金将全额用来支持重大基础设施建设与民生改善项目。', 'Dìfāng zhèngfǔ yīfǎ fāxíng de zhuānxiàng zhànduì zījīn jiāng quán’é yònglái zhīchí zhòngdà jīchǔ shèshī jiànshè yǔ mínshēng gǎishàn xiàngmù.', 'Nguồn vốn trái phiếu chuyên dụng do chính quyền địa phương phát hành theo luật sẽ được dùng toàn bộ để hỗ trợ xây dựng cơ sở hạ tầng trọng điểm và các dự án cải thiện dân sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [用于] (yòngyú) - dùng cho, dùng vào [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '用于' AND pinyin = 'yòngyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '用于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yòngyú',
      meaning_vi = 'dùng cho, dùng vào',
      example_hanzi = '每年获得的这笔奖学金，他都主要用于购买专业书籍和参加学术培训。',
      example_pinyin = 'Měi nián huòdé de zhè bǐ jiǎngxuéjīn, tā dōu zhǔyào yòngyú gòumǎi zhuānyè shūjí hé cānjiā xuéshù péixùn.',
      example_vi = 'Khoản tiền học bổng nhận được mỗi năm, anh ấy đều chủ yếu dùng vào việc mua sách chuyên ngành và tham gia các khóa đào tạo học thuật.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年获得的这笔奖学金，他都主要用于购买专业书籍和参加学术培训。', 'Měi nián huòdé de zhè bǐ jiǎngxuéjīn, tā dōu zhǔyào yòngyú gòumǎi zhuānyè shūjí hé cānjiā xuéshù péixùn.', 'Khoản tiền học bổng nhận được mỗi năm, anh ấy đều chủ yếu dùng vào việc mua sách chuyên ngành và tham gia các khóa đào tạo học thuật.', 'basic', 1),
        (v_id, '该项国家重点实验室研发的先进智能传感技术已广泛用于高速铁路轨道安全监测与预警系统。', 'Gāi xiàng guójiā zhòngdiǎn shíyànshì yánfā de xiānjìn zhìnéng chuángǎn jìshù yǐ guǎngfàn yòngyú gāosù tiělù guǐdào ānquán jiāncè yǔ yùjǐng xìtǒng.', 'Công nghệ cảm biến thông minh tiên tiến do phòng thí nghiệm trọng điểm quốc gia nghiên cứu phát triển đã được ứng dụng rộng rãi vào hệ thống giám sát và cảnh báo an toàn đường ray đường sắt cao tốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [优点] (yōudiǎn) - ưu điểm, điểm mạnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '优点' AND pinyin = 'yōudiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '优点'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yōudiǎn',
      meaning_vi = 'ưu điểm, điểm mạnh',
      example_hanzi = '善于倾听别人的意见并及时改正自己的缺点，是他最突出的人格优点。',
      example_pinyin = 'Shànyú qīngtīng biérén de yìjiàn bìng jíshí gǎizhèng zìjǐ de quēdiǎn, shì tā zuì tūchū de réngé yōudiǎn.',
      example_vi = 'Giỏi lắng nghe ý kiến của người khác và kịp thời sửa đổi khuyết điểm của bản thân là ưu điểm nhân cách nổi bật nhất của anh ấy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '善于倾听别人的意见并及时改正自己的缺点，是他最突出的人格优点。', 'Shànyú qīngtīng biérén de yìjiàn bìng jíshí gǎizhèng zìjǐ de quēdiǎn, shì tā zuì tūchū de réngé yōudiǎn.', 'Giỏi lắng nghe ý kiến của người khác và kịp thời sửa đổi khuyết điểm của bản thân là ưu điểm nhân cách nổi bật nhất của anh ấy.', 'basic', 1),
        (v_id, '新型新能源重型卡车具有零排放、低能耗、大扭矩等显著优点，在绿色智慧物流领域拥有广阔的推广前景。', 'Xīnxíng xīn néngyuán zhòngxíng kǎchē jùyǒu líng páifàng, dī nénghào, dà niǔjù děng xiǎnzhù yōudiǎn, zài lǜsè zhìhuì wùliú lǐngyù yōngyǒu guǎngkuò de tuīguǎng qiánjǐng.', 'Xe tải hạng nặng năng lượng mới kiểu mới có các ưu điểm vượt trội như không phát thải, tiêu hao năng lượng thấp, mô-men xoắn lớn, sở hữu triển vọng ứng dụng rộng rãi trong lĩnh vực logistics thông minh xanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [幽默] (yōumò) - hài hước, hóm hỉnh [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '幽默' AND pinyin = 'yōumò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '幽默'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yōumò',
      meaning_vi = 'hài hước, hóm hỉnh',
      example_hanzi = '他说话非常风趣幽默，经常用简短生动的比喻把大家逗得哈哈大笑。',
      example_pinyin = 'Tā shuōhuà fēicháng fēngqù yōumò, jīngcháng yòng jiǎnduǎn shēngdòng de bǐyù bǎ dàjiā dòu de hāhā dàxiào.',
      example_vi = 'Anh ấy ăn nói rất thú vị hóm hỉnh, thường dùng những phép so sánh ngắn gọn sinh động chọc mọi người cười nắc nẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他说话非常风趣幽默，经常用简短生动的比喻把大家逗得哈哈大笑。', 'Tā shuōhuà fēicháng fēngqù yōumò, jīngcháng yòng jiǎnduǎn shēngdòng de bǐyù bǎ dàjiā dòu de hāhā dàxiào.', 'Anh ấy ăn nói rất thú vị hóm hỉnh, thường dùng những phép so sánh ngắn gọn sinh động chọc mọi người cười nắc nẻ.', 'basic', 1),
        (v_id, '知名作家在国际文化交流论坛上发表了机智幽默的主题演讲，以生动的生活轶事化解了跨文化交流的隔阂。', 'Zhīmíng zuòjiā zài guójì wénhuà jiāoliú lùntán shang fābiǎo le jīzhì yōumò de zhǔtí yǎnjiǎng, yǐ shēngdòng de shēnghuó yìshì huàjiě le kuà wénhuà jiāoliú de géhé.', 'Nhà văn nổi tiếng đã phát biểu bài diễn thuyết chủ đề đầy cơ trí hóm hỉnh tại diễn đàn giao lưu văn hóa quốc tế, dùng những mẩu chuyện đời thường sinh động để hóa giải khoảng cách trong giao lưu đa văn hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [优秀] (yōuxiù) - ưu tú, xuất sắc [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '优秀' AND pinyin = 'yōuxiù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '优秀'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yōuxiù',
      meaning_vi = 'ưu tú, xuất sắc',
      example_hanzi = '她在校期间学习勤奋、品行端正，连续三年被评为学校的优秀三好学生。',
      example_pinyin = 'Tā zài xiào qījiān xuéxí qínfèn, pǐnxíng duānzhèng, liánxù sān nián bèi píng wéi xuéxiào de yōuxiù sānhào xuésheng.',
      example_vi = 'Trong thời gian ở trường cô ấy học tập cần cù, phẩm hạnh đoan trang, ba năm liên tiếp được bình chọn là học sinh ba tốt xuất sắc của trường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '她在校期间学习勤奋、品行端正，连续三年被评为学校的优秀三好学生。', 'Tā zài xiào qījiān xuéxí qínfèn, pǐnxíng duānzhèng, liánxù sān nián bèi píng wéi xuéxiào de yōuxiù sānhào xuésheng.', 'Trong thời gian ở trường cô ấy học tập cần cù, phẩm hạnh đoan trang, ba năm liên tiếp được bình chọn là học sinh ba tốt xuất sắc của trường.', 'basic', 1),
        (v_id, '实施新时代人才强国战略，必须全面建立科学多元的评价机制，不拘一格选拔培养更多杰出的优秀青年科学家。', 'Shíshī xīn shídài réncái qiángguó zhànlüè, bìxū quánmiàn jiànlì kēxué duōyuán de píngjià jīzhì, bùjū-yìgé xuǎnbá péiyǎng gèng duō jiéchū de yōuxiù qīngnián kēxuéjiā.', 'Thực thi chiến lược cường quốc nhân tài thời đại mới bắt buộc phải thiết lập toàn diện cơ chế đánh giá khoa học và đa dạng, không câu nệ khuôn mẫu để tuyển chọn và bồi dưỡng thêm nhiều nhà khoa học trẻ xuất sắc kiệt xuất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [由] (yóu) - do, bởi, từ [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '由' AND pinyin = 'yóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '由'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'yóu',
      meaning_vi = 'do, bởi, từ',
      example_hanzi = '这次中秋节班级联欢晚会的所有文艺节目，都由文艺委员统一负责组织排练。',
      example_pinyin = 'Zhè cì Zhōngqiūjié bānjí liánhuān wǎnhuì de suǒyǒu wényì jiémù, dōu yóu wényì wěiyuán tǒngyī fùzé zǔzhī páiliàn.',
      example_vi = 'Tất cả các tiết mục văn nghệ trong buổi liên hoan lớp dịp Tết Trung thu này đều do ủy viên văn nghệ phụ trách thống nhất tổ chức tập luyện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这次中秋节班级联欢晚会的所有文艺节目，都由文艺委员统一负责组织排练。', 'Zhè cì Zhōngqiūjié bānjí liánhuān wǎnhuì de suǒyǒu wényì jiémù, dōu yóu wényì wěiyuán tǒngyī fùzé zǔzhī páiliàn.', 'Tất cả các tiết mục văn nghệ trong buổi liên hoan lớp dịp Tết Trung thu này đều do ủy viên văn nghệ phụ trách thống nhất tổ chức tập luyện.', 'basic', 1),
        (v_id, '这一具有里程碑意义的国际联合深海科考项目，由多国科研机构共同投资组建的专家团队联合攻关完成。', 'Zhè yí jùyǒu lǐchéngbēi yìyì de guójì liánhé shēnhǎi kěkǎo xiàngmù, yóu duō guó kēyán jīgòu gòngtóng tóuzī zǔjiàn de zhuānjiā tuánduì liánhé gōngguān wánchéng.', 'Dự án khảo sát khoa học biển sâu liên hợp quốc tế có ý nghĩa cột mốc này do đội ngũ chuyên gia được thành lập từ sự đầu tư chung của các cơ quan nghiên cứu khoa học nhiều nước phối hợp đột phá hoàn thành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [油] (yóu) - dầu, mỡ, xăng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '油' AND pinyin = 'yóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '油'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yóu',
      meaning_vi = 'dầu, mỡ, xăng',
      example_hanzi = '医生建议中老年人日常饮食要保持清淡，少吃高油高盐高热量的油腻食品。',
      example_pinyin = 'Yīshēng jiànyì zhōng-lǎonián rén rìcháng yǐnshí yào bǎochí qīngdàn, shǎo chī gāo yóu gāo yán gāo rèliàng de yóunì shípǐn.',
      example_vi = 'Bác sĩ khuyên người trung niên và cao tuổi chế độ ăn uống hằng ngày nên giữ thanh đạm, ít ăn thực phẩm dầu mỡ nhiều dầu nhiều muối nhiều calo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '医生建议中老年人日常饮食要保持清淡，少吃高油高盐高热量的油腻食品。', 'Yīshēng jiànyì zhōng-lǎonián rén rìcháng yǐnshí yào bǎochí qīngdàn, shǎo chī gāo yóu gāo yán gāo rèliàng de yóunì shípǐn.', 'Bác sĩ khuyên người trung niên và cao tuổi chế độ ăn uống hằng ngày nên giữ thanh đạm, ít ăn thực phẩm dầu mỡ nhiều dầu nhiều muối nhiều calo.', 'basic', 1),
        (v_id, '面对国际原油市场价格剧烈波动，国家能源局多措并举加强国内油气资源勘探开发与国家战略石油储备基地建设。', 'Miànduì guójì yuányóu shìchǎng jiàgé jùliè bōdòng, Guójiā Néngyuán Jú duō cuò bìng jǔ jiāqiáng guónèi yóuqì zīyuán kāntàn kāifā yǔ guójiā zhànlüè shíyóu chǔbèi jīdì jiànshè.', 'Đối mặt với sự biến động dữ dội của giá dầu thô trên thị trường quốc tế, Cục Năng lượng Quốc gia áp dụng đồng bộ nhiều biện pháp nhằm tăng cường thăm dò khai thác tài nguyên dầu khí trong nước và xây dựng các căn cứ dự trữ dầu mỏ chiến lược quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [尤其] (yóuqí) - đặc biệt, nhất là [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '尤其' AND pinyin = 'yóuqí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '尤其'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'yóuqí',
      meaning_vi = 'đặc biệt, nhất là',
      example_hanzi = '他平时非常热爱各类体育运动，尤其擅长踢足球和在游泳池里畅游。',
      example_pinyin = 'Tā píngshí fēicháng rè’ài gè lèi tǐyù yùndòng, yóuqí shàncháng tī zúqiú hé zài yóuyǒngchí lǐ chàngyóu.',
      example_vi = 'Ngày thường anh ấy rất yêu thích các môn thể thao vận động, đặc biệt sở trường là đá bóng và bơi lội thỏa thích trong bể bơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他平时非常热爱各类体育运动，尤其擅长踢足球和在游泳池里畅游。', 'Tā píngshí fēicháng rè’ài gè lèi tǐyù yùndòng, yóuqí shàncháng tī zúqiú hé zài yóuyǒngchí lǐ chàngyóu.', 'Ngày thường anh ấy rất yêu thích các môn thể thao vận động, đặc biệt sở trường là đá bóng và bơi lội thỏa thích trong bể bơi.', 'basic', 1),
        (v_id, '推进乡村全面振兴必须因地制宜发展特色优势富民产业，尤其要在巩固拓展脱贫攻坚成果上持续精准发力。', 'Tuījìn xiāngcūn quánmiàn zhènxīng bìxū yīndì-zhìyí fāzhǎn tèsè yòushì fùmín chǎnyè, yóuqí yào zài gǒnggù tuòzhǎn tuōpín gōngjiān chéngguǒ shang chíxù jīngzhǔn fālì.', 'Thúc đẩy chấn hưng nông thôn toàn diện bắt buộc phải tùy theo điều kiện địa phương phát triển các ngành nghề làm giàu cho dân có lợi thế đặc thù, đặc biệt phải liên tục tạo sức bật chuẩn xác trong việc củng cố mở rộng thành quả xóa đói giảm nghèo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [游玩] (yóuwán) - đi chơi, du ngoạn, dạo chơi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '游玩' AND pinyin = 'yóuwán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '游玩'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yóuwán',
      meaning_vi = 'đi chơi, du ngoạn, dạo chơi',
      example_hanzi = '每年春暖花开的四月，很多家庭都会趁着周末带上孩子前往郊外公园踏青游玩。',
      example_pinyin = 'Měi nián chūnnuǎn-huākāi de sìyuè, hěn duō jiātíng dōu huì chènzhe zhōumò dài shang háizi qiánwǎng jiāowài gōngyuán tàqīng yóuwán.',
      example_vi = 'Hằng năm vào tháng tư tiết trời ấm áp hoa nở, nhiều gia đình đều nhân dịp cuối tuần dẫn theo con nhỏ đến các công viên ngoại ô du ngoạn ngắm cảnh xuân.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年春暖花开的四月，很多家庭都会趁着周末带上孩子前往郊外公园踏青游玩。', 'Měi nián chūnnuǎn-huākāi de sìyuè, hěn duō jiātíng dōu huì chènzhe zhōumò dài shang háizi qiánwǎng jiāowài gōngyuán tàqīng yóuwán.', 'Hằng năm vào tháng tư tiết trời ấm áp hoa nở, nhiều gia đình đều nhân dịp cuối tuần dẫn theo con nhỏ đến các công viên ngoại ô du ngoạn ngắm cảnh xuân.', 'basic', 1),
        (v_id, '国家级风景名胜区全面推行智慧化分时段预约购票制度，有效提升了游客实地游玩的舒适度与生态安全保障水平。', 'Guójiā-jí fēngjǐng míngshèngqū quánmiàn tuīxíng zhìhuìhuà fēn shíduàn yùyuē gòupiào zhìdù, yǒuxiào tíshēng le yóukè shídì yóuwán de shūshìdù yǔ shēngtài ānquán bǎozhàng shuǐpíng.', 'Khu danh lam thắng cảnh cấp quốc gia triển khai toàn diện chế độ đặt mua vé thông minh theo từng khung giờ, nâng cao hiệu quả mức độ thoải mái khi du ngoạn thực tế của du khách và bảo đảm an toàn sinh thái.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [由于] (yóuyú) - do, bởi vì [Giới từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '由于' AND pinyin = 'yóuyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '由于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ / Liên từ',
      pinyin = 'yóuyú',
      meaning_vi = 'do, bởi vì',
      example_hanzi = '由于最近连续几天加班赶工，他的脸上露出了掩盖不住的深深疲惫。',
      example_pinyin = 'Yóuyú zuìjìn liánxù jǐ tiān jiābān gǎngōng, tā de liǎn shang lùchū le yǎngài bu zhù de shēnshēn píbèi.',
      example_vi = 'Do mấy ngày liên tiếp gần đây tăng ca chạy đua tiến độ, trên khuôn mặt anh ấy lộ rõ vẻ mệt mỏi sâu sắc không thể che giấu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '由于最近连续几天加班赶工，他的脸上露出了掩盖不住的深深疲惫。', 'Yóuyú zuìjìn liánxù jǐ tiān jiābān gǎngōng, tā de liǎn shang lùchū le yǎngài bu zhù de shēnshēn píbèi.', 'Do mấy ngày liên tiếp gần đây tăng ca chạy đua tiến độ, trên khuôn mặt anh ấy lộ rõ vẻ mệt mỏi sâu sắc không thể che giấu.', 'basic', 1),
        (v_id, '由于全球气候极端事件发生频次急剧增加，国际跨政府间组织敦促各成员国加快制定更加积极的气候减排行动方案。', 'Yóuyú quánqiú qìhòu jíduān shìjiàn fāshēng píncì jíjù zēngjiā, guójì kuà zhèngfǔ jiān zǔzhī dūncù gè chéngyuánguó jiākuài zhìdìng gèngjiā jījí de qìhòu jiǎnpái xíngdòng fāng’àn.', 'Do tần suất xảy ra các hiện tượng thời tiết cực đoan toàn cầu gia tăng nhanh chóng, tổ chức liên chính phủ quốc tế đã thúc giục các quốc gia thành viên đẩy nhanh việc xây dựng các kế hoạch hành động giảm phát thải khí hậu tích cực hơn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [友好] (yǒuhǎo) - hữu nghị, thân thiện [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '友好' AND pinyin = 'yǒuhǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '友好'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yǒuhǎo',
      meaning_vi = 'hữu nghị, thân thiện',
      example_hanzi = '小区里的邻居们平日里见面总是互相微笑打招呼，关系十分融洽友好。',
      example_pinyin = 'Xiǎoqū lǐ de línjūmen píngrì lǐ jiànmiàn zǒngshì hùxiāng wēixiào dǎ zhāohu, guānxi shífēn róngqià yǒuhǎo.',
      example_vi = 'Những người hàng xóm trong khu dân cư ngày thường gặp nhau luôn mỉm cười chào hỏi, mối quan hệ vô cùng hòa thuận và thân thiện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小区里的邻居们平日里见面总是互相微笑打招呼，关系十分融洽友好。', 'Xiǎoqū lǐ de línjūmen píngrì lǐ jiànmiàn zǒngshì hùxiāng wēixiào dǎ zhāohu, guānxi shífēn róngqià yǒuhǎo.', 'Những người hàng xóm trong khu dân cư ngày thường gặp nhau luôn mỉm cười chào hỏi, mối quan hệ vô cùng hòa thuận và thân thiện.', 'basic', 1),
        (v_id, '两国领导人在亲切友好的会谈中达成广泛共识，一致同意共同深化全面战略伙伴关系与全方位务实合作。', 'Liǎng guó lǐngdǎorén zài qīnqiè yǒuhǎo de huìtán zhōng dáchéng guǎngfàn gòngshí, yízhì tóngyì gòngtóng shēnhuà quánmiàn zhànlüè huǒbàn guānxi yǔ quán fāngwèi wùshí hézuò.', 'Các nhà lãnh đạo hai nước trong cuộc hội đàm thân mật hữu nghị đã đạt được nhận thức chung sâu rộng, nhất trí cùng làm sâu sắc thêm quan hệ đối tác chiến lược toàn diện và hợp tác thực chất trên mọi phương diện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [友情] (yǒuqíng) - tình bạn, tình hữu nghị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '友情' AND pinyin = 'yǒuqíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '友情'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yǒuqíng',
      meaning_vi = 'tình bạn, tình hữu nghị',
      example_hanzi = '即使大学毕业后大家各奔东西，我们之间真挚纯洁的同窗友情也永远不会褪色。',
      example_pinyin = 'Jíshǐ dàxué bìyè hòu dàjiā gèbèndōngxī, wǒmen zhījiān zhēnzhì chúnjié de tóngchuāng yǒuqíng yě yǒngyuǎn bú huì tuìsè.',
      example_vi = 'Dẫu cho sau khi tốt nghiệp đại học mỗi người một ngả, tình bạn bạn học chân thành thuần khiết giữa chúng tôi cũng sẽ vĩnh viễn không phai mờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '即使大学毕业后大家各奔东西，我们之间真挚纯洁的同窗友情也永远不会褪色。', 'Jíshǐ dàxué bìyè hòu dàjiā gèbèndōngxī, wǒmen zhījiān zhēnzhì chúnjié de tóngchuāng yǒuqíng yě yǒngyuǎn bú huì tuìsè.', 'Dẫu cho sau khi tốt nghiệp đại học mỗi người một ngả, tình bạn bạn học chân thành thuần khiết giữa chúng tôi cũng sẽ vĩnh viễn không phai mờ.', 'basic', 1),
        (v_id, '历经半个多世纪的风雨同行与考验，中法两国人民之间结下了弥足珍贵的深厚友情与文明互鉴典范。', 'Lìjīng bàn gè duō shìjì de fēngyǔ tóngxíng yǔ kǎoyàn, Zhōng-Fǎ liǎng guó rénmín zhījiān jiéxià le mǐzú-zhēnguì de shēnhòu yǒuqíng yǔ wénmíng hùjiàn diǎnfàn.', 'Trải qua hơn nửa thế kỷ cùng vượt qua mưa gió và thử thách, nhân dân hai nước Trung - Pháp đã kết nên tình bạn sâu sắc vô cùng quý giá và tấm gương điển hình về sự giao lưu học hỏi văn minh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [有趣] (yǒuqù) - thú vị, có ý vị [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '有趣' AND pinyin = 'yǒuqù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '有趣'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yǒuqù',
      meaning_vi = 'thú vị, có ý vị',
      example_hanzi = '物理老师在课堂上设计了几个好玩有趣的科学小实验，把抽象的物理原理讲得通俗生动。',
      example_pinyin = 'Wùlǐ lǎoshī zài kètáng shang shèjì le jǐ gè hǎowán yǒuqù de kēxué xiǎo shíyàn, bǎ chōuxiàng de wùlǐ yuánlǐ jiǎng de tōngsú shēngdòng.',
      example_vi = 'Giáo viên Vật lý trong giờ học đã thiết kế một vài thí nghiệm khoa học nhỏ vui nhộn thú vị, giảng giải các nguyên lý vật lý trừu tượng một cách dễ hiểu và sinh động.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '物理老师在课堂上设计了几个好玩有趣的科学小实验，把抽象的物理原理讲得通俗生动。', 'Wùlǐ lǎoshī zài kètáng shang shèjì le jǐ gè hǎowán yǒuqù de kēxué xiǎo shíyàn, bǎ chōuxiàng de wùlǐ yuánlǐ jiǎng de tōngsú shēngdòng.', 'Giáo viên Vật lý trong giờ học đã thiết kế một vài thí nghiệm khoa học nhỏ vui nhộn thú vị, giảng giải các nguyên lý vật lý trừu tượng một cách dễ hiểu và sinh động.', 'basic', 1),
        (v_id, '新一代沉浸式虚拟现实博物馆通过有趣的数字化互动体验，让沉睡千年的珍贵出土文物在观众眼前鲜活起来。', 'Xīn yídài chénjìnshì xūnǐ xiànshí bówùguǎn tōngguò yǒuqù de shùzìhuà hùdòng tǐyàn, ràng chénsùiqiānnián de zhēnguì chūtǔ wénwù zài guānzhòng yǎnqián xiānhuó qǐlái.', 'Bảo tàng thực tế ảo đắm chìm thế hệ mới thông qua những trải nghiệm tương tác kỹ thuật số thú vị đã làm sống dậy trước mắt khán giả các hiện vật khảo cổ quý giá ngủ say ngàn năm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [有效] (yǒuxiào) - có hiệu lực, hiệu quả [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '有效' AND pinyin = 'yǒuxiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '有效'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'yǒuxiào',
      meaning_vi = 'có hiệu lực, hiệu quả',
      example_hanzi = '这种温和的中成药对缓解季节性风寒引起的咳嗽和咽喉肿痛非常有效。',
      example_pinyin = 'Zhè zhǒng wēnhé de zhōngchéngyào duì huǎnjiě jìjiéxìng fēnghán yǐnqǐ de késou hé yānhóu zhǒngtòng fēicháng yǒuxiào.',
      example_vi = 'Loại thuốc đông y thành phẩm dịu nhẹ này rất hiệu quả trong việc làm dịu cơn ho và sưng đau họng do phong hàn theo mùa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这种温和的中成药对缓解季节性风寒引起的咳嗽和咽喉肿痛非常有效。', 'Zhè zhǒng wēnhé de zhōngchéngyào duì huǎnjiě jìjiéxìng fēnghán yǐnqǐ de késou hé yānhóu zhǒngtòng fēicháng yǒuxiào.', 'Loại thuốc đông y thành phẩm dịu nhẹ này rất hiệu quả trong việc làm dịu cơn ho và sưng đau họng do phong hàn theo mùa.', 'basic', 1),
        (v_id, '各级监督检查部门必须采取切实有效管用的精准管控举措，从源头上坚决杜绝任何形式主义和铺张浪费倾向。', 'Gè jí jiāndū jiǎnchá bùmén bìxū cǎiqǔ qièshí yǒuxiào guǎnyòng de jīngzhǔn guǎnkòng jǔcuò, cóng yuántóu shang jiānjué dùjué rènhé xíngshìzhǔyì hé pūzhāng làngfèi qīngxiàng.', 'Các bộ phận giám sát kiểm tra các cấp bắt buộc phải áp dụng các biện pháp quản lý kiểm soát chuẩn xác thiết thực, hiệu quả và hữu dụng, kiên quyết chấm dứt từ gốc rễ mọi khuynh hướng chủ nghĩa hình thức và phô trương lãng phí.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [友谊] (yǒuyì) - tình hữu nghị, tình bạn bè [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '友谊' AND pinyin = 'yǒuyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '友谊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yǒuyì',
      meaning_vi = 'tình hữu nghị, tình bạn bè',
      example_hanzi = '尽管离开故乡多年，他和童年挚友之间的真挚友谊依然像陈年老酒一样甘甜醇厚。',
      example_pinyin = 'Jǐnguǎn líkāi gùxiāng duō nián, tā hé tóngnián zhìyǒu zhījiān de zhēnzhì yǒuyì yīrán xiàng chénnián lǎojiǔ yíyàng gāntián chúnhòu.',
      example_vi = 'Dù đã rời xa quê hương nhiều năm, tình bạn chân thành giữa anh ấy và người bạn thân thuở nhỏ vẫn ngọt ngào đậm đà như rượu ủ lâu năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '尽管离开故乡多年，他和童年挚友之间的真挚友谊依然像陈年老酒一样甘甜醇厚。', 'Jǐnguǎn líkāi gùxiāng duō nián, tā hé tóngnián zhìyǒu zhījiān de zhēnzhì yǒuyì yīrán xiàng chénnián lǎojiǔ yíyàng gāntián chúnhòu.', 'Dù đã rời xa quê hương nhiều năm, tình bạn chân thành giữa anh ấy và người bạn thân thuở nhỏ vẫn ngọt ngào đậm đà như rượu ủ lâu năm.', 'basic', 1),
        (v_id, '国际奥委会倡导“相互理解、友谊、团结和公平竞争”的奥林匹克崇高精神，在全球青年心中播撒和平的种子。', 'Guójì Àowěihuì chàngdǎo “xiānghù lǐjiě, yǒuyì, tuánjié hé gōngpíng jìngzhēng” de Àolínpǐkè chónggāo jīngshén, zài quánqiú qīngnián xīnzhōng bōsǎ hépíng de zhǒngzi.', 'Ủy ban Olympic Quốc tế khởi xướng tinh thần Olympic cao cả "hiểu biết lẫn nhau, hữu nghị, đoàn kết và cạnh tranh công bằng", gieo hạt giống hòa bình vào lòng thanh niên toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [有着] (yǒuzhe) - có, mang (ý nghĩa, vai trò, truyền thống...) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '有着' AND pinyin = 'yǒuzhe'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '有着'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yǒuzhe',
      meaning_vi = 'có, mang (ý nghĩa, vai trò, truyền thống...)',
      example_hanzi = '这座有着几百年悠久历史的古朴村落，至今依然完好地保留着明清时期的徽派建筑风貌。',
      example_pinyin = 'Zhè zuò yǒuzhe jǐ bǎi nián yōujiǔ lìshǐ de gǔpǔ cūnluò, zhìjīn yīrán wánhǎo de bǎoliúzhe Míng-Qīng shíqī de Huīpài jiànzhù fēngmào.',
      example_vi = 'Ngôi làng cổ kính mang lịch sử lâu đời mấy trăm năm này đến nay vẫn bảo tồn nguyên vẹn phong cách kiến trúc phái Huy thời Minh - Thanh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这座有着几百年悠久历史的古朴村落，至今依然完好地保留着明清时期的徽派建筑风貌。', 'Zhè zuò yǒuzhe jǐ bǎi nián yōujiǔ lìshǐ de gǔpǔ cūnluò, zhìjīn yīrán wánhǎo de bǎoliúzhe Míng-Qīng shíqī de Huīpài jiànzhù fēngmào.', 'Ngôi làng cổ kính mang lịch sử lâu đời mấy trăm năm này đến nay vẫn bảo tồn nguyên vẹn phong cách kiến trúc phái Huy thời Minh - Thanh.', 'basic', 1),
        (v_id, '全面推进高水平对外开放与拓展国际经贸合作空间，对稳定我国外贸外资基本盘有着至关重要的战略意义。', 'Quánmiàn tuījìn gāo shuǐpǐng duìwài kāifàng yǔ tuòzhǎn guójì jīng-mào hézuò kōngjiān, duì wěndìng wǒguó wàimào wàizī jīběnpán yǒuzhe zhìguān zhòngyào de zhànlüè yìyì.', 'Thúc đẩy toàn diện mở cửa đối ngoại trình độ cao và mở rộng không gian hợp tác kinh tế thương mại quốc tế có ý nghĩa chiến lược vô cùng quan trọng đối với việc ổn định nền tảng ngoại thương và vốn đầu tư nước ngoài của nước ta.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [愉快] (yúkuài) - vui vẻ, vui sướng, hân hoan [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '愉快' AND pinyin = 'yúkuài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '愉快'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yúkuài',
      meaning_vi = 'vui vẻ, vui sướng, hân hoan',
      example_hanzi = '结束了一整周紧张繁忙的工作，周末与三五好友聚餐品茗度过了一段十分愉快的时光。',
      example_pinyin = 'Jiéshù le yì zhěng zhōu jǐnzhāng fánmáng de gōngzuò, zhōumò yǔ sān-wǔ hǎoyǒu jùcān pǐnmíng dùguò le yí duàn shífēn yúkuài de shíguāng.',
      example_vi = 'Kết thúc một tuần lễ công việc căng thẳng bận rộn, cuối tuần cùng ba năm người bạn thân tụ tập ăn uống thưởng trà đã trải qua khoảng thời gian vô cùng vui vẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '结束了一整周紧张繁忙的工作，周末与三五好友聚餐品茗度过了一段十分愉快的时光。', 'Jiéshù le yì zhěng zhōu jǐnzhāng fánmáng de gōngzuò, zhōumò yǔ sān-wǔ hǎoyǒu jùcān pǐnmíng dùguò le yí duàn shífēn yúkuài de shíguāng.', 'Kết thúc một tuần lễ công việc căng thẳng bận rộn, cuối tuần cùng ba năm người bạn thân tụ tập ăn uống thưởng trà đã trải qua khoảng thời gian vô cùng vui vẻ.', 'basic', 1),
        (v_id, '双方代表团在坦诚务实、热烈愉快的友好氛围中，就深化双边全面经贸战略投资达成了多项积极共识。', 'Shuāngfāng dàibiǎotuán zài tǎnchéng wùshí, rèliè yúkuài de yǒuhǎo fēnwéi zhōng, jiù shēnhuà shuāngbiān quánmiàn jīng-mào zhànlüè tóuzī dáchéng le duō xiàng jījí gòngshí.', 'Phái đoàn hai bên trong bầu không khí hữu nghị thẳng thắn, thực chất, sôi nổi và vui vẻ đã đạt được nhiều đồng thuận tích cực về việc làm sâu sắc đầu tư chiến lược kinh tế thương mại toàn diện song phương.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [于是] (yúshì) - thế là, do đó, liền [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '于是' AND pinyin = 'yúshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '于是'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'yúshì',
      meaning_vi = 'thế là, do đó, liền',
      example_hanzi = '看到天边突然乌云密布狂风大作，于是我们赶紧收拾好帐篷提前结束了露营。',
      example_pinyin = 'Kàndào tiānbiān tūrán wūyún-mìbù kuángfēng dàzuò, yúshì wǒmen gǎnjǐn shōushi hǎo zhàngpeng tíqián jiéshù le lùyíng.',
      example_vi = 'Thấy chân trời đột nhiên mây đen giăng kín gió giật dữ dội, thế là chúng tôi vội vàng thu dọn lều bạt kết thúc chuyến cắm trại sớm hơn dự kiến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '看到天边突然乌云密布狂风大作，于是我们赶紧收拾好帐篷提前结束了露营。', 'Kàndào tiānbiān tūrán wūyún-mìbù kuángfēng dàzuò, yúshì wǒmen gǎnjǐn shōushi hǎo zhàngpeng tíqián jiéshù le lùyíng.', 'Thấy chân trời đột nhiên mây đen giăng kín gió giật dữ dội, thế là chúng tôi vội vàng thu dọn lều bạt kết thúc chuyến cắm trại sớm hơn dự kiến.', 'basic', 1),
        (v_id, '传统粗放型工业制造模式已难以为继，于是该老工业基地率先启动绿色数字化技改，成功实现了涅槃重生。', 'Chuántǒng cūfàngxíng gōngyè zhìzào móshì yǐ nányǐ-wèijì, yúshì gāi lǎo gōngyè jīdì shuàixiān qǐdòng lǜsè shùzìhuà jìgǎi, chénggōng shíxiàn le nièpán chóngshēng.', 'Mô hình sản xuất công nghiệp phát triển theo chiều rộng kiểu truyền thống đã khó lòng duy trì, thế là khu căn cứ công nghiệp cũ này đã tiên phong khởi động cải tiến kỹ thuật số hóa xanh, thành công thực hiện bước tái sinh rực rỡ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [与] (yǔ) - cùng, và, với [Giới từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '与' AND pinyin = 'yǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '与'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ / Liên từ',
      pinyin = 'yǔ',
      meaning_vi = 'cùng, và, với',
      example_hanzi = '遇到生活与学业上的困惑时，多主动与父母和师长沟通交流能够获得宝贵的建议。',
      example_pinyin = 'Yùdào shēnghuó yǔ xuéyè shang de kùnhuò shí, duō zhǔdòng yǔ fùmǔ hé shīzhǎng gōutōng jiāoliú nénggòu huòdé bǎoguì de jiànyì.',
      example_vi = 'Khi gặp khúc mắc trong cuộc sống và học tập, chủ động trao đổi nhiều hơn với cha mẹ và thầy cô có thể nhận được những lời khuyên quý báu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到生活与学业上的困惑时，多主动与父母和师长沟通交流能够获得宝贵的建议。', 'Yùdào shēnghuó yǔ xuéyè shang de kùnhuò shí, duō zhǔdòng yǔ fùmǔ hé shīzhǎng gōutōng jiāoliú nénggòu huòdé bǎoguì de jiànyì.', 'Khi gặp khúc mắc trong cuộc sống và học tập, chủ động trao đổi nhiều hơn với cha mẹ và thầy cô có thể nhận được những lời khuyên quý báu.', 'basic', 1),
        (v_id, '坚持依法治国与以德治国相结合，是推进国家治理体系和治理能力现代化的内在客观要求与重要制度保障。', 'Jiānchí yīfǎ zhìguó yǔ yǐ dé zhìguó xiāng jiéhé, shì tuījìn guójiā zhìlǐ tǐxì hé zhìlǐ nénglì xiàndàihuà de nèizài kèguān yāoqiú yǔ zhòngyào zhìdù bǎozhàng.', 'Kiên trì kết hợp giữa quản lý đất nước theo pháp luật và quản lý đất nước bằng đạo đức là yêu cầu khách quan nội tại và sự bảo đảm thể chế quan trọng để thúc đẩy hiện đại hóa hệ thống và năng lực quản trị quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [语法] (yǔfǎ) - ngữ pháp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '语法' AND pinyin = 'yǔfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '语法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yǔfǎ',
      meaning_vi = 'ngữ pháp',
      example_hanzi = '学习一门新的外语时，不仅要死记单词，更要在实际对话中灵活掌握并运用常用语法规则。',
      example_pinyin = 'Xuéxí yì mén xīn de wàiyǔ shí, bùjǐn yào sǐjì dāncí, gèng yào zài shíjì duìhuà zhōng línghuó zhǎngwò bìng yùnyòng chángyòng yǔfǎ guīzé.',
      example_vi = 'Khi học một ngoại ngữ mới, không những phải học thuộc lòng từ vựng mà quan trọng hơn là phải nắm vững và vận dụng linh hoạt các quy tắc ngữ pháp thông dụng trong hội thoại thực tế.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学习一门新的外语时，不仅要死记单词，更要在实际对话中灵活掌握并运用常用语法规则。', 'Xuéxí yì mén xīn de wàiyǔ shí, bùjǐn yào sǐjì dāncí, gèng yào zài shíjì duìhuà zhōng línghuó zhǎngwò bìng yùnyòng chángyòng yǔfǎ guīzé.', 'Khi học một ngoại ngữ mới, không những phải học thuộc lòng từ vựng mà quan trọng hơn là phải nắm vững và vận dụng linh hoạt các quy tắc ngữ pháp thông dụng trong hội thoại thực tế.', 'basic', 1),
        (v_id, '现代计算语言学专家通过构建深度神经网络模型，对复杂自然语言的句法树与语义语法结构进行精确解析。', 'Xiàndài jìsuàn yǔyánxué zhuānjiā tōngguò gòujiàn shēndù shénjīng wǎngluò móxíng, duì fùzá zìrán yǔyán de jùfǎshù yǔ yǔyì yǔfǎ jiégòu jìnxíng jīngquè jiěxī.', 'Các chuyên gia ngôn ngữ học tính toán hiện đại thông qua việc xây dựng mô hình mạng nơ-ron sâu đã tiến hành phân tích chính xác cây cú pháp và cấu trúc ngữ pháp ngữ nghĩa của ngôn ngữ tự nhiên phức tạp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [预习] (yùxí) - chuẩn bị bài trước, soạn bài [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '预习' AND pinyin = 'yùxí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '预习'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yùxí',
      meaning_vi = 'chuẩn bị bài trước, soạn bài',
      example_hanzi = '每天上课前认真预习新课文并圈出不懂的生词，能让第二天的听课效率成倍提高。',
      example_pinyin = 'Měitiān shàngkè qián rènzhēn yùxí xīn kèwén bìng quānchū bù dǒng de shēngcí, néng ràng dì-èr tiān de tīngkè xiàolǜ chéngbèi tígāo.',
      example_vi = 'Mỗi ngày trước giờ lên lớp chăm chỉ chuẩn bị bài khóa mới và khoanh tròn những từ mới chưa hiểu có thể nâng cao hiệu suất nghe giảng ngày hôm sau lên gấp bội.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天上课前认真预习新课文并圈出不懂的生词，能让第二天的听课效率成倍提高。', 'Měitiān shàngkè qián rènzhēn yùxí xīn kèwén bìng quānchū bù dǒng de shēngcí, néng ràng dì-èr tiān de tīngkè xiàolǜ chéngbèi tígāo.', 'Mỗi ngày trước giờ lên lớp chăm chỉ chuẩn bị bài khóa mới và khoanh tròn những từ mới chưa hiểu có thể nâng cao hiệu suất nghe giảng ngày hôm sau lên gấp bội.', 'basic', 1),
        (v_id, '基础教育学校全面推广“导学案预习”与“翻转课堂”教学实验，旨在充分唤醒学生的自主探究学习潜能。', 'Jīchǔ jiàoyù xuéxiào quánmiàn tuīguǎng “dǎoxué’àn yùxí” yǔ “fānzhuǎn kètáng” jiàoxué shíyàn, zhǐ zài chōngfèn huànxǐng xuésheng de zìzhǔ tànjiū xuéxí qiánnéng.', 'Các trường giáo dục phổ thông triển khai rộng rãi thử nghiệm giảng dạy "chuẩn bị bài theo đề cương định hướng" và "lớp học đảo ngược", nhằm đánh thức trọn vẹn tiềm năng học tập tìm tòi tự chủ của học sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [原来] (yuánlái) - ban đầu, vốn dĩ, hóa ra [Danh từ / Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '原来' AND pinyin = 'yuánlái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '原来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ / Phó từ',
      pinyin = 'yuánlái',
      meaning_vi = 'ban đầu, vốn dĩ, hóa ra',
      example_hanzi = '找了半天没找到眼镜，原来一直戴在自己的头顶上，真让人哭笑不得。',
      example_pinyin = 'Zhǎo le bàntiān méi zhǎodào yǎnjìng, yuánlái yìzhí dài zài zìjǐ de tóudǐng shang, zhēn ràng rén kūxiàobùdé.',
      example_vi = 'Tìm nửa ngày không thấy kính mắt, hóa ra bấy lâu nay vẫn đeo trên đỉnh đầu mình, thật khiến người ta dở khóc dở cười.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '找了半天没找到眼镜，原来一直戴在自己的头顶上，真让人哭笑不得。', 'Zhǎo le bàntiān méi zhǎodào yǎnjìng, yuánlái yìzhí dài zài zìjǐ de tóudǐng shang, zhēn ràng rén kūxiàobùdé.', 'Tìm nửa ngày không thấy kính mắt, hóa ra bấy lâu nay vẫn đeo trên đỉnh đầu mình, thật khiến người ta dở khóc dở cười.', 'basic', 1),
        (v_id, '随着城市有机更新与生态修复工程扎实推进，原来黑臭脏乱的护城河如今蜕变成了市民休闲健身的生态绿色景观廊道。', 'Suízhe chéngshì yǒujī gēngxīn yǔ shēngtài xiūfù gōngchéng zhāshí tuījìn, yuánlái hēichòu zāngluàn de hùchénghé rújīn tuìbiàn chéng le shìmín xiūxián jiànshēn de shēngtài lǜsè jǐngguān lángdào.', 'Cùng với việc thúc đẩy vững chắc các dự án chỉnh trang đô thị hữu cơ và phục hồi sinh thái, con sông bao quanh thành phố vốn ô nhiễm đen đục bẩn thỉu ngày nào nay đã lột xác thành hành lang cảnh quan xanh sinh thái cho người dân nghỉ ngơi thư giãn và rèn luyện thể thao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 9: #1801 -> #1900)!', v_count;
END $$;
