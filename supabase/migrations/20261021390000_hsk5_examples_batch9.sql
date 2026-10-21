-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 9 (100 TỪ TIẾP THEO)
-- Phạm vi: #2802 [牛仔裤] (niúzǎikù) -> #2901 [全面] (quánmiàn)
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
  -- [2802] [牛仔裤] (niúzǎikù) - quần bò, quần jean [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '牛仔裤' AND pinyin = 'niúzǎikù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '牛仔裤' AND pinyin = 'niúzǎikù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '牛仔裤'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '牛仔裤'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'niúzǎikù',
      meaning_vi = 'quần bò, quần jean',
      example_hanzi = '这件简单的白T恤搭配经典蓝色牛仔裤，看起来既阳光又干练。',
      example_pinyin = 'Zhè jiàn jiǎndān de bái T-xù dāpèi jīngdiǎn lánsè niúzǎikù, kàn qǐlái jì yángguāng yòu gànliàn.',
      example_vi = 'Chiếc áo phông trắng đơn giản này phối cùng quần jean xanh kinh điển, trông vừa tươi sáng lại vừa năng động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '牛仔裤',
      'niúzǎikù',
      'quần bò, quần jean',
      'Danh từ',
      'HSK 5',
      '这件简单的白T恤搭配经典蓝色牛仔裤，看起来既阳光又干练。',
      'Zhè jiàn jiǎndān de bái T-xù dāpèi jīngdiǎn lánsè niúzǎikù, kàn qǐlái jì yángguāng yòu gànliàn.',
      'Chiếc áo phông trắng đơn giản này phối cùng quần jean xanh kinh điển, trông vừa tươi sáng lại vừa năng động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这件简单的白T恤搭配经典蓝色牛仔裤，看起来既阳光又干练。', 'Zhè jiàn jiǎndān de bái T-xù dāpèi jīngdiǎn lánsè niúzǎikù, kàn qǐlái jì yángguāng yòu gànliàn.', 'Chiếc áo phông trắng đơn giản này phối cùng quần jean xanh kinh điển, trông vừa tươi sáng lại vừa năng động.', 'basic', 1),
      (v_id, '现代环保纺织工业采用无水激光做旧与天然植物靛蓝染色技术，显著降低了传统牛仔裤加工过程中的水资源消耗与重金属污染。', 'Xiàndài huánbǎo fǎngzhī gōngyè cǎiyòng wúshuǐ jīguāng zuòjiù yǔ tiānrán zhíwù diànlán rǎnsè jìshù, xiǎnzhù jiàngdī le chuántǒng niúzǎikù jiāgōng guòchéng zhōng de shuǐzīyuán xiāohào yǔ zhòngjīnshǔ wūrǎn.', 'Ngành dệt may sinh thái hiện đại ứng dụng kỹ thuật làm cũ bằng laser không dùng nước và nhuộm chàm thực vật tự nhiên, giảm thiểu rõ rệt lượng tiêu hao tài nguyên nước và ô nhiễm kim loại nặng trong quy trình gia công quần jean truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2803] [浓] (nóng) - đậm, đặc, nồng (trà, cà phê, sương mù, tình cảm) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '浓' AND pinyin = 'nóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '浓' AND pinyin = 'nóng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '浓'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '浓'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'nóng',
      meaning_vi = 'đậm, đặc, nồng (trà, cà phê, sương mù, tình cảm)',
      example_hanzi = '早晨起床后，爸爸喜欢泡上一杯香气浓郁的热咖啡。',
      example_pinyin = 'Zǎochen qǐchuáng hòu, bàba xǐhuan pào shàng yì bēi xiāngqì nóngyù de rè kāfēi.',
      example_vi = 'Sau khi thức dậy vào buổi sáng, bố thích pha một tách cà phê nóng thơm nồng đậm đà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '浓',
      'nóng',
      'đậm, đặc, nồng (trà, cà phê, sương mù, tình cảm)',
      'Tính từ',
      'HSK 5',
      '早晨起床后，爸爸喜欢泡上一杯香气浓郁的热咖啡。',
      'Zǎochen qǐchuáng hòu, bàba xǐhuan pào shàng yì bēi xiāngqì nóngyù de rè kāfēi.',
      'Sau khi thức dậy vào buổi sáng, bố thích pha một tách cà phê nóng thơm nồng đậm đà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '早晨起床后，爸爸喜欢泡上一杯香气浓郁的热咖啡。', 'Zǎochen qǐchuáng hòu, bàba xǐhuan pào shàng yì bēi xiāngqì nóngyù de rè kāfēi.', 'Sau khi thức dậy vào buổi sáng, bố thích pha một tách cà phê nóng thơm nồng đậm đà.', 'basic', 1),
      (v_id, '浓厚的传统中医药文化底蕴与严谨的现代分子生物学研究深度融合，正在为攻克世界性难治性慢病提供独具东方智慧的创新方案。', 'Nónghòu de chuántǒng zhōng-yīyào wénhuà dǐyùn yǔ yánjǐn de xiàndài fēnzǐ shēngwùxué yánjiū shēndù rónghé, zhèngzài wèi gōngkè shìjièxìng nánzhìxìng mànbìng tígōng dú jù dōngfāng zhìhuì de chuàngxīn fāng’àn.', 'Chiều sâu văn hóa y dược cổ truyền đậm đà dung hợp sâu sắc với nghiên cứu sinh học phân tử hiện đại nghiêm ngặt, đang cung cấp những giải pháp đổi mới mang đậm trí tuệ phương Đông nhằm khắc phục các căn bệnh mãn tính nan y tầm thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2804] [农民] (nóngmín) - nông dân, người làm nông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '农民' AND pinyin = 'nóngmín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '农民' AND pinyin = 'nóngmín'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '农民'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '农民'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'nóngmín',
      meaning_vi = 'nông dân, người làm nông',
      example_hanzi = '金秋十月，辛勤耕耘的农民们迎来了稻谷大丰收的喜悦。',
      example_pinyin = 'Jīnqiū shí yuè, xīnqín gēngyún de nóngmínmen yínglái le dàogǔ dà fēngshōu de xǐyuè.',
      example_vi = 'Tháng 10 mùa thu vàng, những người nông dân một nắng hai sương đã đón nhận niềm vui được mùa lúa bội thu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '农民',
      'nóngmín',
      'nông dân, người làm nông',
      'Danh từ',
      'HSK 5',
      '金秋十月，辛勤耕耘的农民们迎来了稻谷大丰收的喜悦。',
      'Jīnqiū shí yuè, xīnqín gēngyún de nóngmínmen yínglái le dàogǔ dà fēngshōu de xǐyuè.',
      'Tháng 10 mùa thu vàng, những người nông dân một nắng hai sương đã đón nhận niềm vui được mùa lúa bội thu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '金秋十月，辛勤耕耘的农民们迎来了稻谷大丰收的喜悦。', 'Jīnqiū shí yuè, xīnqín gēngyún de nóngmínmen yínglái le dàogǔ dà fēngshōu de xǐyuè.', 'Tháng 10 mùa thu vàng, những người nông dân một nắng hai sương đã đón nhận niềm vui được mùa lúa bội thu.', 'basic', 1),
      (v_id, '国家大力培育有文化、懂技术、善经营的新型职业农民，有力推动了现代农业规模化、智慧化与绿色高质高效发展。', 'Guójiā dàlì péiyù yǒu wénhuà, dǒng jìshù, shàn jīngyíng de xīnxíng zhíyè nóngmín, yǒulì tuīdòng le xiàndài nóngyè guīmóhuà, zhìhuìhuà yǔ lǜsè gāozhì gāoxiào fāzhǎn.', 'Nhà nước đẩy mạnh đào tạo thế hệ nông dân nghề nghiệp kiểu mới có văn hóa, hiểu kỹ thuật và giỏi kinh doanh, thúc đẩy mạnh mẽ nền nông nghiệp hiện đại phát triển theo hướng quy mô, thông minh và xanh chất lượng cao hiệu quả cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2805] [农业] (nóngyè) - nông nghiệp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '农业' AND pinyin = 'nóngyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '农业' AND pinyin = 'nóngyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '农业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '农业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'nóngyè',
      meaning_vi = 'nông nghiệp',
      example_hanzi = '农业是国民经济的基础，关系到千家万户的粮食安全。',
      example_pinyin = 'Nóngyè shì guómín jīngjì de jīchǔ, guānxì dào qiānjiā-wànhù de liángshi ānquán.',
      example_vi = 'Nông nghiệp là nền tảng của nền kinh tế quốc dân, liên quan mật thiết tới an ninh lương thực của muôn nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '农业',
      'nóngyè',
      'nông nghiệp',
      'Danh từ',
      'HSK 5',
      '农业是国民经济的基础，关系到千家万户的粮食安全。',
      'Nóngyè shì guómín jīngjì de jīchǔ, guānxì dào qiānjiā-wànhù de liángshi ānquán.',
      'Nông nghiệp là nền tảng của nền kinh tế quốc dân, liên quan mật thiết tới an ninh lương thực của muôn nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '农业是国民经济的基础，关系到千家万户的粮食安全。', 'Nóngyè shì guómín jīngjì de jīchǔ, guānxì dào qiānjiā-wànhù de liángshi ānquán.', 'Nông nghiệp là nền tảng của nền kinh tế quốc dân, liên quan mật thiết tới an ninh lương thực của muôn nhà.', 'basic', 1),
      (v_id, '以卫星遥感、农机自动驾驶以及物联网精准水肥为特征的智慧农业，已成为推动农业农村现代化与乡村全面振兴的核心驱动力。', 'Yǐ wèixīng yáogǎn, nóngjī zìdòng jiàshǐ yǐjí wùliánwǎng jīngzhǔn shuǐféi wéi tèzhēng de zhìhuì nóngyè, yǐ chéngwéi tuīdòng nóngyè nóngcūn xiàndàihuà yǔ xiāngcūn quánmiàn zhènxīng de héxīn qūdònglì.', 'Nông nghiệp thông minh với các đặc trưng như viễn thám vệ tinh, máy nông nghiệp tự lái và tưới tiêu phân bón chính xác qua IoT đã trở thành động lực then chốt thúc đẩy hiện đại hóa nông nghiệp nông thôn và chấn hưng toàn diện làng quê.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2806] [女子] (nǚzǐ) - nữ giới, phụ nữ, nữ tử [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '女子' AND pinyin = 'nǚzǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '女子' AND pinyin = 'nǚzǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '女子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '女子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'nǚzǐ',
      meaning_vi = 'nữ giới, phụ nữ, nữ tử',
      example_hanzi = '我国女子排球队在国际赛场上展现出了顽强拼搏的女排精神。',
      example_pinyin = 'Wǒ guó nǚzǐ páiqiúduì zài guójì sàichǎng shang zhǎnxiàn chū le wánqiáng pīnbó de nǚpái jīngshén.',
      example_vi = 'Đội tuyển bóng chuyền nữ nước ta trên đấu trường quốc tế đã thể hiện tinh thần bóng chuyền nữ kiên cường chiến đấu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '女子',
      'nǚzǐ',
      'nữ giới, phụ nữ, nữ tử',
      'Danh từ',
      'HSK 5',
      '我国女子排球队在国际赛场上展现出了顽强拼搏的女排精神。',
      'Wǒ guó nǚzǐ páiqiúduì zài guójì sàichǎng shang zhǎnxiàn chū le wánqiáng pīnbó de nǚpái jīngshén.',
      'Đội tuyển bóng chuyền nữ nước ta trên đấu trường quốc tế đã thể hiện tinh thần bóng chuyền nữ kiên cường chiến đấu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我国女子排球队在国际赛场上展现出了顽强拼搏的女排精神。', 'Wǒ guó nǚzǐ páiqiúduì zài guójì sàichǎng shang zhǎnxiàn chū le wánqiáng pīnbó de nǚpái jīngshén.', 'Đội tuyển bóng chuyền nữ nước ta trên đấu trường quốc tế đã thể hiện tinh thần bóng chuyền nữ kiên cường chiến đấu.', 'basic', 1),
      (v_id, '现代社会高度尊重并全面保障广大女子在政治参与、科技创新、企业经营以及社会公益等各个领域的合法平等权益。', 'Xiàndài shèhuì gāodù zūnzhòng bìng quánmiàn bǎozhàng guǎngdà nǚzǐ zài zhèngzhì cānyù, kējì chuàngxīn, qǐyè jīngyíng yǐjí shèhuì gōngyì děng gègè lǐngyù de héfǎ píngděng quányì.', 'Xã hội hiện đại tôn trọng sâu sắc và bảo đảm toàn diện các quyền lợi bình đẳng hợp pháp của đông đảo nữ giới trong mọi lĩnh vực như tham chính, đổi mới công nghệ, quản trị doanh nghiệp và hoạt động công ích xã hội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2807] [哦] (ò) - ồ, à (nhận ra, hiểu ra) [Thán từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '哦' AND pinyin = 'ò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哦' AND pinyin = 'ò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '哦'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thán từ',
      pinyin = 'ò',
      meaning_vi = 'ồ, à (nhận ra, hiểu ra)',
      example_hanzi = '哦，听你这么一说，我终于弄明白这道题的解题思路了。',
      example_pinyin = 'Ò, tīng nǐ zhème yì shuō, wǒ zhōngyú nòng míngbai zhè dào tí de jiětí sīlù le.',
      example_vi = 'Ồ, nghe bạn giải thích như vậy, tôi cuối cùng đã hiểu ra hướng tư duy giải quyết bài toán này rồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '哦',
      'ò',
      'ồ, à (nhận ra, hiểu ra)',
      'Thán từ',
      'HSK 5',
      '哦，听你这么一说，我终于弄明白这道题的解题思路了。',
      'Ò, tīng nǐ zhème yì shuō, wǒ zhōngyú nòng míngbai zhè dào tí de jiětí sīlù le.',
      'Ồ, nghe bạn giải thích như vậy, tôi cuối cùng đã hiểu ra hướng tư duy giải quyết bài toán này rồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '哦，听你这么一说，我终于弄明白这道题的解题思路了。', 'Ò, tīng nǐ zhème yì shuō, wǒ zhōngyú nòng míngbai zhè dào tí de jiětí sīlù le.', 'Ồ, nghe bạn giải thích như vậy, tôi cuối cùng đã hiểu ra hướng tư duy giải quyết bài toán này rồi.', 'basic', 1),
      (v_id, '哦，原来这台进口高精密机床的核心控制器内置了多重防过载算法保护，难怪在超高负荷工况下依然能保持零故障稳定运行。', 'Ò, yuánlái zhè tái jìnkǒu gāo jīngmì jīchuáng de héxīn kòngzhìqì nèizhì le duōchóng fáng guòzài suànfǎ bǎohù, nánguài zài chāo gāo fùhè gōngkuàng xià yīrán néng bǎochí líng gùzhàng wěndìng yùnxíng.', 'Ồ, hóa ra bộ điều khiển cốt lõi của máy công cụ chính xác cao nhập khẩu này đã tích hợp thuật toán bảo vệ chống quá tải đa tầng, thảo nào trong điều kiện làm việc siêu tải trọng vẫn duy trì vận hành ổn định không lỗi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2808] [欧洲] (Ōuzhōu) - châu Âu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '欧洲' AND pinyin = 'Ōuzhōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '欧洲' AND pinyin = 'Ōuzhōu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '欧洲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '欧洲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'Ōuzhōu',
      meaning_vi = 'châu Âu',
      example_hanzi = '他利用毕业旅行的机会游历了欧洲的多个历史文化名城。',
      example_pinyin = 'Tā lìyòng bìyè lǚxíng de jīhuì yóulì le Ōuzhōu de duō gè lìshǐ wénhuà míngchéng.',
      example_vi = 'Anh ấy tận dụng cơ hội chuyến du lịch tốt nghiệp để đi du ngoạn nhiều thành phố lịch sử văn hóa nổi tiếng của châu Âu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '欧洲',
      'Ōuzhōu',
      'châu Âu',
      'Danh từ',
      'HSK 5',
      '他利用毕业旅行的机会游历了欧洲的多个历史文化名城。',
      'Tā lìyòng bìyè lǚxíng de jīhuì yóulì le Ōuzhōu de duō gè lìshǐ wénhuà míngchéng.',
      'Anh ấy tận dụng cơ hội chuyến du lịch tốt nghiệp để đi du ngoạn nhiều thành phố lịch sử văn hóa nổi tiếng của châu Âu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他利用毕业旅行的机会游历了欧洲的多个历史文化名城。', 'Tā lìyòng bìyè lǚxíng de jīhuì yóulì le Ōuzhōu de duō gè lìshǐ wénhuà míngchéng.', 'Anh ấy tận dụng cơ hội chuyến du lịch tốt nghiệp để đi du ngoạn nhiều thành phố lịch sử văn hóa nổi tiếng của châu Âu.', 'basic', 1),
      (v_id, '中欧班列作为亚欧大陆互联互通的重要陆路运输骨干通道，将共建一带一路国家紧密串联，有力促进了中国与欧洲多国双向经贸繁荣。', 'Zhōng-Ōu bānliè zuòwéi Yà-Ōu dàlù hùlián-hùtōng de zhòngyào lùlù yùnshū gǔgàn tōngdào, jiāng gòngjiàn Yídài-Yílù guójiā jǐnmì chuànlián, yǒulì cùjìn le Zhōngguó yǔ Ōuzhōu duō guó shuāngxiàng jīngmào fánróng.', 'Tuyến tàu hàng Trung Quốc - châu Âu với tư cách là hành lang vận tải đường bộ xương sống kết nối lục địa Á - Âu, đã kết nối chặt chẽ các quốc gia cùng xây dựng Vành đai và Con đường, thúc đẩy mạnh mẽ sự phồn vinh kinh tế thương mại hai chiều giữa Trung Quốc và nhiều nước châu Âu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2809] [偶然] (ǒurán) - ngẫu nhiên, tình cờ, bất ngờ [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '偶然' AND pinyin = 'ǒurán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '偶然' AND pinyin = 'ǒurán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '偶然'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '偶然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'ǒurán',
      meaning_vi = 'ngẫu nhiên, tình cờ, bất ngờ',
      example_hanzi = '今天在图书馆查资料时，我偶然翻到了一本寻找已久的绝版古籍。',
      example_pinyin = 'Jīntiān zài túshūguǎn chá zīliào shí, wǒ ǒurán fāndào le yì běn xúnzhǎo yǐ jiǔ de juébǎn gǔjí.',
      example_vi = 'Hôm nay khi tra cứu tài liệu ở thư viện, tôi tình cờ lật trúng cuốn sách cổ đã ngừng xuất bản mà mình tìm kiếm bấy lâu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '偶然',
      'ǒurán',
      'ngẫu nhiên, tình cờ, bất ngờ',
      'Tính từ / Phó từ',
      'HSK 5',
      '今天在图书馆查资料时，我偶然翻到了一本寻找已久的绝版古籍。',
      'Jīntiān zài túshūguǎn chá zīliào shí, wǒ ǒurán fāndào le yì běn xúnzhǎo yǐ jiǔ de juébǎn gǔjí.',
      'Hôm nay khi tra cứu tài liệu ở thư viện, tôi tình cờ lật trúng cuốn sách cổ đã ngừng xuất bản mà mình tìm kiếm bấy lâu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天在图书馆查资料时，我偶然翻到了一本寻找已久的绝版古籍。', 'Jīntiān zài túshūguǎn chá zīliào shí, wǒ ǒurán fāndào le yì běn xúnzhǎo yǐ jiǔ de juébǎn gǔjí.', 'Hôm nay khi tra cứu tài liệu ở thư viện, tôi tình cờ lật trúng cuốn sách cổ đã ngừng xuất bản mà mình tìm kiếm bấy lâu.', 'basic', 1),
      (v_id, '科学史上的许多重大突破看似源于偶然的灵感火花，但其背后无不凝聚着科研人员数十年如一日坚持不懈的深厚理论积淀与必然努力。', 'Kēxuéshǐ shang de xǔduō zhòngdà tūpò kànsì yuányú ǒurán de línggǎn huǒhuā, dàn qí bèihòu wúbù níngjù zhe kēyán rényuán shù shí nián rú yí rì jiānchí-búxiè de shēnhòu lǐlùn jīdiàn yǔ bìrán nǔlì.', 'Nhiều đột phá trọng đại trong lịch sử khoa học thoạt nhìn dường như bắt nguồn từ tia lửa cảm hứng ngẫu nhiên, nhưng ẩn sau đó đều kết tinh nền tảng lý luận sâu sắc cùng nỗ lực kiên trì bền bỉ hàng chục năm như một của giới nghiên cứu khoa học.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2810] [拍摄] (pāishè) - chụp ảnh, quay phim, ghi hình [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '拍摄' AND pinyin = 'pāishè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拍摄' AND pinyin = 'pāishè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '拍摄'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拍摄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pāishè',
      meaning_vi = 'chụp ảnh, quay phim, ghi hình',
      example_hanzi = '摄影师在风景优美的湖边为新婚夫妇拍摄了一组温馨浪漫的婚纱照。',
      example_pinyin = 'Shèyǐngshī zài fēngjǐng yōuměi de húbiān wèi xīnhūn fūfù pāishè le yì zǔ wēnxīn làngmàn de hūnshāzhào.',
      example_vi = 'Nhiếp ảnh gia bên bờ hồ phong cảnh hữu tình đã chụp cho đôi vợ chồng mới cưới một bộ ảnh cưới ấm áp và lãng mạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '拍摄',
      'pāishè',
      'chụp ảnh, quay phim, ghi hình',
      'Động từ',
      'HSK 5',
      '摄影师在风景优美的湖边为新婚夫妇拍摄了一组温馨浪漫的婚纱照。',
      'Shèyǐngshī zài fēngjǐng yōuměi de húbiān wèi xīnhūn fūfù pāishè le yì zǔ wēnxīn làngmàn de hūnshāzhào.',
      'Nhiếp ảnh gia bên bờ hồ phong cảnh hữu tình đã chụp cho đôi vợ chồng mới cưới một bộ ảnh cưới ấm áp và lãng mạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '摄影师在风景优美的湖边为新婚夫妇拍摄了一组温馨浪漫的婚纱照。', 'Shèyǐngshī zài fēngjǐng yōuměi de húbiān wèi xīnhūn fūfù pāishè le yì zǔ wēnxīn làngmàn de hūnshāzhào.', 'Nhiếp ảnh gia bên bờ hồ phong cảnh hữu tình đã chụp cho đôi vợ chồng mới cưới một bộ ảnh cưới ấm áp và lãng mạn.', 'basic', 1),
      (v_id, '该自然纪录片制作团队采用高空超高清红外遥感无人机系统，在人迹罕至的高原雪峰历时三年成功拍摄到了珍稀野生雪豹的完整繁育影像。', 'Gāi zìrán jìlùpiàn zhìzuò tuánduì cǎiyòng gāokōng chāogāoqīng hóngwài yáogǎn wúrénjī xìtǒng, zài rénjì-hǎnjià de gāoyuán xuěfēng lìshí sān nián chénggōng pāishè dào le zhēnxī yěshēng xuěbào de wánzhěng fányù yǐngxiàng.', 'Đoàn làm phim tài liệu tự nhiên này ứng dụng hệ thống flycam viễn thám hồng ngoại siêu nét trên tầm cao, trải qua 3 năm tại vùng núi tuyết cao nguyên hẻo lánh không bóng người đã ghi hình thành công thước phim sinh sản hoàn chỉnh của loài báo tuyết hoang dã quý hiếm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2811] [排列] (páiliè) - xếp hàng, sắp xếp, bài trí theo thứ tự [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '排列' AND pinyin = 'páiliè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '排列' AND pinyin = 'páiliè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '排列'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '排列'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'páiliè',
      meaning_vi = 'xếp hàng, sắp xếp, bài trí theo thứ tự',
      example_hanzi = '书架上的各类专业参考书都被图书管理员整齐有序地排列好了。',
      example_pinyin = 'Shūjià shang de gèlèi zhuānyè cānkǎoshū dōu bèi túshū guǎnlǐyuán zhěngqí yǒuxù de páiliè hǎo le.',
      example_vi = 'Các loại sách tham khảo chuyên ngành trên kệ sách đều đã được thủ thư sắp xếp ngay ngắn và có trật tự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '排列',
      'páiliè',
      'xếp hàng, sắp xếp, bài trí theo thứ tự',
      'Động từ',
      'HSK 5',
      '书架上的各类专业参考书都被图书管理员整齐有序地排列好了。',
      'Shūjià shang de gèlèi zhuānyè cānkǎoshū dōu bèi túshū guǎnlǐyuán zhěngqí yǒuxù de páiliè hǎo le.',
      'Các loại sách tham khảo chuyên ngành trên kệ sách đều đã được thủ thư sắp xếp ngay ngắn và có trật tự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '书架上的各类专业参考书都被图书管理员整齐有序地排列好了。', 'Shūjià shang de gèlèi zhuānyè cānkǎoshū dōu bèi túshū guǎnlǐyuán zhěngqí yǒuxù de páiliè hǎo le.', 'Các loại sách tham khảo chuyên ngành trên kệ sách đều đã được thủ thư sắp xếp ngay ngắn và có trật tự.', 'basic', 1),
      (v_id, '材料科学家通过精确调控二维纳米晶格中原子阵列的特定排列组合，成功研发出具有室温超导潜力与极高载流子迁移率的新型量子材料。', 'Cáiliào kēxuéjiā tōngguò jīngquè tiáokòng èrwéi nàmǐ jīnggé zhōng yuánzǐ zhènliè de tèdìng páiliè zǔhé, chénggōng yánfā chū jùyǒu shìwēn chāodǎo qiánlì yǔ jí gāo zàiliúzǐ qiānyílǜ de xīnxíng liàngzǐ cáiliào.', 'Các nhà khoa học vật liệu thông qua việc điều khiển chuẩn xác trật tự sắp xếp đặc định của chuỗi nguyên tử trong mạng tinh thể nano hai chiều đã chế tạo thành công loại vật liệu lượng tử mới mang tiềm năng siêu dẫn ở nhiệt độ phòng và độ linh động hạt tải điện cực cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2812] [派] (pài) - phái, cử, điều động; phe phái, trường phái [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '派' AND pinyin = 'pài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '派' AND pinyin = 'pài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '派'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '派'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'pài',
      meaning_vi = 'phái, cử, điều động; phe phái, trường phái',
      example_hanzi = '公司决定派三名经验丰富的资深工程师前往海外分公司指导项目施工。',
      example_pinyin = 'Gōngsī juédìng pài sān míng jīngyàn fēngfù de zīshēn gōngchéngshī qiánwǎng hǎiwài fēngōngsī zhǐdǎo xiàngmù shīgōng.',
      example_vi = 'Công ty quyết định cử ba kỹ sư kỳ cựu giàu kinh nghiệm sang chi nhánh hải ngoại để hướng dẫn thi công dự án.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '派',
      'pài',
      'phái, cử, điều động; phe phái, trường phái',
      'Động từ / Danh từ',
      'HSK 5',
      '公司决定派三名经验丰富的资深工程师前往海外分公司指导项目施工。',
      'Gōngsī juédìng pài sān míng jīngyàn fēngfù de zīshēn gōngchéngshī qiánwǎng hǎiwài fēngōngsī zhǐdǎo xiàngmù shīgōng.',
      'Công ty quyết định cử ba kỹ sư kỳ cựu giàu kinh nghiệm sang chi nhánh hải ngoại để hướng dẫn thi công dự án.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '公司决定派三名经验丰富的资深工程师前往海外分公司指导项目施工。', 'Gōngsī juédìng pài sān míng jīngyàn fēngfù de zīshēn gōngchéngshī qiánwǎng hǎiwài fēngōngsī zhǐdǎo xiàngmù shīgōng.', 'Công ty quyết định cử ba kỹ sư kỳ cựu giàu kinh nghiệm sang chi nhánh hải ngoại để hướng dẫn thi công dự án.', 'basic', 1),
      (v_id, '在深化学术百花齐放的学术生态中，不同学派之间围绕重大理论问题展开平等的学术争鸣，有力促进了科学理论体系的繁荣演进。', 'Zài shēnhuà xuéshù bǎihuā-qífàng de xuéshù shēngtài zhōng, bùtóng xuépài zhījiān wéirào zhòngdà lǐlùn wèntí zhǎnkāi píngděng de xuéshù zhēngmíng, yǒulì cùjìn le kēxué lǐlùn tǐxì de fánróng yǎnjìn.', 'Trong hệ sinh thái học thuật trăm hoa đua nở ngày càng sâu rộng, giữa các trường phái học thuật khác nhau cùng triển khai tranh luận học thuật bình đẳng xoay quanh các vấn đề lý luận lớn đã thúc đẩy mạnh mẽ sự tiến hóa phồn vinh của hệ thống lý luận khoa học.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2813] [派出所] (pàichūsuǒ) - đồn công an, trạm cảnh sát [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '派出所' AND pinyin = 'pàichūsuǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '派出所' AND pinyin = 'pàichūsuǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '派出所'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '派出所'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'pàichūsuǒ',
      meaning_vi = 'đồn công an, trạm cảnh sát',
      example_hanzi = '如果不慎丢失了身份证，需要尽快前往户籍所在地派出所申请补办。',
      example_pinyin = 'Rúguǒ búshèn diūshī le shēnfènzhèng, xūyào jǐnkuài qiánwǎng hùjí suǒzàidì pàichūsuǒ shēnqǐng bǔbàn.',
      example_vi = 'Nếu không may làm mất thẻ căn cước, cần nhanh chóng đến đồn công an nơi đăng ký hộ khẩu để xin cấp lại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '派出所',
      'pàichūsuǒ',
      'đồn công an, trạm cảnh sát',
      'Danh từ',
      'HSK 5',
      '如果不慎丢失了身份证，需要尽快前往户籍所在地派出所申请补办。',
      'Rúguǒ búshèn diūshī le shēnfènzhèng, xūyào jǐnkuài qiánwǎng hùjí suǒzàidì pàichūsuǒ shēnqǐng bǔbàn.',
      'Nếu không may làm mất thẻ căn cước, cần nhanh chóng đến đồn công an nơi đăng ký hộ khẩu để xin cấp lại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果不慎丢失了身份证，需要尽快前往户籍所在地派出所申请补办。', 'Rúguǒ búshèn diūshī le shēnfènzhèng, xūyào jǐnkuài qiánwǎng hùjí suǒzàidì pàichūsuǒ shēnqǐng bǔbàn.', 'Nếu không may làm mất thẻ căn cước, cần nhanh chóng đến đồn công an nơi đăng ký hộ khẩu để xin cấp lại.', 'basic', 1),
      (v_id, '基层公安派出所践行新时代“枫桥经验”，依靠群防群治网格化治理力量将矛盾纠纷化解在基层萌芽状态，切实守护一方百姓的平安。', 'Jīcéng gōng’ān pàichūsuǒ jiànxíng xīn shídài “Fēngqiáo jīngyàn”, yīkào qúnfáng-qúnzhì wǎnggéhuà zhìlǐ lìliàng jiāng máodùn jiūfēn huàjiě zài jīcéng méngyá zhuàngtài, qièshí shǒuhù yì fāng bǎixìng de píng’ān.', 'Đồn công an cơ sở thực hành "Kinh nghiệm Phong Kiều" thời đại mới, dựa vào sức mạnh quản trị mạng lưới quần chúng tự phòng tự quản để hóa giải mâu thuẫn tranh chấp ngay từ mầm mống cơ sở, bảo vệ thiết thực sự bình yên cho nhân dân một vùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2814] [跑道] (pǎodào) - đường chạy (thể thao); đường băng (sân bay); đường đua (ngành nghề) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '跑道' AND pinyin = 'pǎodào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '跑道' AND pinyin = 'pǎodào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '跑道'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '跑道'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'pǎodào',
      meaning_vi = 'đường chạy (thể thao); đường băng (sân bay); đường đua (ngành nghề)',
      example_hanzi = '运动员们站在起跑线上，专注地注视着前方平整红艳的塑胶跑道。',
      example_pinyin = 'Yùndòngyuánmen zhàn zài qǐpǎoxiàn shang, zhuānzhù de zhùshì zhe qiánfāng píngzhěng hóngyàn de sùjiāo pǎodào.',
      example_vi = 'Các vận động viên đứng tại vạch xuất phát, chăm chú nhìn đường chạy nhựa tổng hợp phẳng phiu đỏ thắm phía trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '跑道',
      'pǎodào',
      'đường chạy (thể thao); đường băng (sân bay); đường đua (ngành nghề)',
      'Danh từ',
      'HSK 5',
      '运动员们站在起跑线上，专注地注视着前方平整红艳的塑胶跑道。',
      'Yùndòngyuánmen zhàn zài qǐpǎoxiàn shang, zhuānzhù de zhùshì zhe qiánfāng píngzhěng hóngyàn de sùjiāo pǎodào.',
      'Các vận động viên đứng tại vạch xuất phát, chăm chú nhìn đường chạy nhựa tổng hợp phẳng phiu đỏ thắm phía trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '运动员们站在起跑线上，专注地注视着前方平整红艳的塑胶跑道。', 'Yùndòngyuánmen zhàn zài qǐpǎoxiàn shang, zhuānzhù de zhùshì zhe qiánfāng píngzhěng hóngyàn de sùjiāo pǎodào.', 'Các vận động viên đứng tại vạch xuất phát, chăm chú nhìn đường chạy nhựa tổng hợp phẳng phiu đỏ thắm phía trước.', 'basic', 1),
      (v_id, '随着新质生产力的加速培育，商业航天、低空经济以及类脑人形机器人等战略新兴赛道，正在成为各大科技领军企业竞逐的新跑道。', 'Suízhe xīnzhì shēngchǎnlì de jiāsù péiyù, shāngyè hángtiān, dīkōng jīngjì yǐjí lèinǎo rénxíng jīqìrén děng zhànlüè xīnxīng sàidào, zhèngzài chéngwéi gè dà kējì lǐngjūn qǐyè jìngzhú de xīn pǎodào.', 'Cùng với sự tăng tốc vun đắp lực lượng sản xuất chất lượng mới, các đường đua mới nổi chiến lược như hàng không vũ trụ thương mại, kinh tế tầm thấp và robot hình người giống não bộ đang trở thành những đường đua mới mà các doanh nghiệp công nghệ đầu ngành ráo riết cạnh tranh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2815] [赔] (péi) - bồi thường, đền bù; thua lỗ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '赔' AND pinyin = 'péi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赔' AND pinyin = 'péi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '赔'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赔'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'péi',
      meaning_vi = 'bồi thường, đền bù; thua lỗ',
      example_hanzi = '在超市购物时不慎打碎了玻璃杯，应当主动按价赔偿给商家。',
      example_pinyin = 'Zài chāoshì gòuwù shí búshèn dǎsuì le bōlibēi, yīngdāng zhǔdòng ànjià péicháng gěi shāngjiā.',
      example_vi = 'Khi mua sắm trong siêu thị sơ ý làm vỡ cốc thủy tinh, nên chủ động bồi thường theo đúng giá cho cửa hàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '赔',
      'péi',
      'bồi thường, đền bù; thua lỗ',
      'Động từ',
      'HSK 5',
      '在超市购物时不慎打碎了玻璃杯，应当主动按价赔偿给商家。',
      'Zài chāoshì gòuwù shí búshèn dǎsuì le bōlibēi, yīngdāng zhǔdòng ànjià péicháng gěi shāngjiā.',
      'Khi mua sắm trong siêu thị sơ ý làm vỡ cốc thủy tinh, nên chủ động bồi thường theo đúng giá cho cửa hàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在超市购物时不慎打碎了玻璃杯，应当主动按价赔偿给商家。', 'Zài chāoshì gòuwù shí búshèn dǎsuì le bōlibēi, yīngdāng zhǔdòng ànjià péicháng gěi shāngjiā.', 'Khi mua sắm trong siêu thị sơ ý làm vỡ cốc thủy tinh, nên chủ động bồi thường theo đúng giá cho cửa hàng.', 'basic', 1),
      (v_id, '依据我国合同法与民法典侵权责任编规定，故意违反商业保密协议窃取核心专有技术者，不仅须依法全额赔偿实际经济损失，还须承担惩罚性民事赔偿。', 'Yījù wǒ guó hétongfǎ yǔ mínfǎdiǎn qīnquán zérèn biān guīdìng, gùyì wéifǎn shāngyè bǎomì xiéyì qièqǔ héxīn zhuānyǒu jìshù zhě, bùjǐn xū yīfǎ quán’é péicháng shíjì jīngjì sǔnshī, hái xū chéngdān chéngfáxìng mínshì péicháng.', 'Căn cứ quy định Luật Hợp đồng và phần Trách nhiệm bồi thường thiệt hại ngoài hợp đồng trong Bộ luật Dân sự nước ta, người cố ý vi phạm thỏa thuận bảo mật thương mại đánh cắp bí quyết công nghệ cốt lõi không chỉ phải bồi thường toàn bộ thiệt hại kinh tế thực tế mà còn phải chịu mức bồi thường dân sự mang tính trừng phạt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2816] [陪伴] (péibàn) - bầu bạn, ở bên cạnh, đồng hành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '陪伴' AND pinyin = 'péibàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '陪伴' AND pinyin = 'péibàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '陪伴'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '陪伴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'péibàn',
      meaning_vi = 'bầu bạn, ở bên cạnh, đồng hành',
      example_hanzi = '父母给孩子最好的关爱，莫过于在成长过程中耐心的关怀与温暖的陪伴。',
      example_pinyin = 'Fùmǔ gěi háizi zuì hǎo de guān’ài, mò guòyú zài chéngzhǎng guòchéng zhōng nàixīn de guānhuái yǔ wēnnuǎn de péibàn.',
      example_vi = 'Tình yêu thương tuyệt vời nhất mà cha mẹ dành cho con cái không gì hơn sự chăm sóc kiên nhẫn và sự đồng hành ấm áp trong suốt quá trình trưởng thành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '陪伴',
      'péibàn',
      'bầu bạn, ở bên cạnh, đồng hành',
      'Động từ',
      'HSK 5',
      '父母给孩子最好的关爱，莫过于在成长过程中耐心的关怀与温暖的陪伴。',
      'Fùmǔ gěi háizi zuì hǎo de guān’ài, mò guòyú zài chéngzhǎng guòchéng zhōng nàixīn de guānhuái yǔ wēnnuǎn de péibàn.',
      'Tình yêu thương tuyệt vời nhất mà cha mẹ dành cho con cái không gì hơn sự chăm sóc kiên nhẫn và sự đồng hành ấm áp trong suốt quá trình trưởng thành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '父母给孩子最好的关爱，莫过于在成长过程中耐心的关怀与温暖的陪伴。', 'Fùmǔ gěi háizi zuì hǎo de guān’ài, mò guòyú zài chéngzhǎng guòchéng zhōng nàixīn de guānhuái yǔ wēnnuǎn de péibàn.', 'Tình yêu thương tuyệt vời nhất mà cha mẹ dành cho con cái không gì hơn sự chăm sóc kiên nhẫn và sự đồng hành ấm áp trong suốt quá trình trưởng thành.', 'basic', 1),
      (v_id, '在推动乡村教育优质均衡发展进程中，成千上万名支教青年教师扎根偏远山区，以无私奉献陪伴留守儿童点亮走出大山的梦想。', 'Zài tuīdòng xiāngcūn jiàoyù yōuzhì jūnhéng fāzhǎn jìnchéng zhōng, chéngqiān-shàngwàn míng zhījiào qīngnián jiàoshī zhāgēn piānyuǎn shānqū, yǐ wúsī fèngxiàn péibàn liúshǒu értóng diǎnliàng zǒuchū dàshān de mèngxiǎng.', 'Trong tiến trình thúc đẩy giáo dục nông thôn phát triển chất lượng cao và cân bằng, hàng vạn giáo viên trẻ tình nguyện dạy học đã cắm rễ nơi núi non hẻo lánh, bằng sự cống hiến quên mình đồng hành cùng các em nhỏ ở lại thắp sáng ước mơ bước ra khỏi đại ngàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2817] [培训] (péixùn) - đào tạo, tập huấn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '培训' AND pinyin = 'péixùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '培训' AND pinyin = 'péixùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '培训'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '培训'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'péixùn',
      meaning_vi = 'đào tạo, tập huấn',
      example_hanzi = '新员工入职后的第一个月，人事部会组织系统的专业技能与企业文化培训。',
      example_pinyin = 'Xīn yuángōng rùzhí hòu de dì-yī gè yuè, rénshìbù huì zǔzhī xìtǒng de zhuānyè jìnéng yǔ qǐyè wénhuà péixùn.',
      example_vi = 'Trong tháng đầu tiên sau khi nhân viên mới vào công ty, phòng nhân sự sẽ tổ chức các khóa tập huấn kỹ năng chuyên môn và văn hóa doanh nghiệp một cách bài bản.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '培训',
      'péixùn',
      'đào tạo, tập huấn',
      'Động từ / Danh từ',
      'HSK 5',
      '新员工入职后的第一个月，人事部会组织系统的专业技能与企业文化培训。',
      'Xīn yuángōng rùzhí hòu de dì-yī gè yuè, rénshìbù huì zǔzhī xìtǒng de zhuānyè jìnéng yǔ qǐyè wénhuà péixùn.',
      'Trong tháng đầu tiên sau khi nhân viên mới vào công ty, phòng nhân sự sẽ tổ chức các khóa tập huấn kỹ năng chuyên môn và văn hóa doanh nghiệp một cách bài bản.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新员工入职后的第一个月，人事部会组织系统的专业技能与企业文化培训。', 'Xīn yuángōng rùzhí hòu de dì-yī gè yuè, rénshìbù huì zǔzhī xìtǒng de zhuānyè jìnéng yǔ qǐyè wénhuà péixùn.', 'Trong tháng đầu tiên sau khi nhân viên mới vào công ty, phòng nhân sự sẽ tổ chức các khóa tập huấn kỹ năng chuyên môn và văn hóa doanh nghiệp một cách bài bản.', 'basic', 1),
      (v_id, '为加速产业工人队伍知识型、技能型、创新型转型升级，各级工会联合职业院校大力开展工业互联网与工业机器人实操专项技能培训。', 'Wèi jiāsù chǎnyè gōngrén duìwu zhīshìxíng, jìnéngxíng, chuàngxīnxíng zhuǎnxíng shēngjí, gè jí gōnghuì liánhé zhíyè yuànxiào dàlì kāizhǎn gōngyè hùliánwǎng yǔ gōngyè jīqìrén shícāo zhuānxiàng jìnéng péixùn.', 'Nhằm đẩy nhanh chuyển đổi nâng cấp đội ngũ công nhân công nghiệp theo hướng tri thức, kỹ năng và đổi mới sáng tạo, công đoàn các cấp phối hợp cùng các trường nghề đẩy mạnh tổ chức các đợt tập huấn kỹ năng thực hành chuyên đề về Internet công nghiệp và robot công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2818] [培养] (péiyǎng) - bồi dưỡng, đào tạo, nuôi dưỡng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '培养' AND pinyin = 'péiyǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '培养' AND pinyin = 'péiyǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '培养'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '培养'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'péiyǎng',
      meaning_vi = 'bồi dưỡng, đào tạo, nuôi dưỡng',
      example_hanzi = '学校不仅要传授文化知识，更要注重培养学生独立思考与创新的能力。',
      example_pinyin = 'Xuéxiào bùjǐn yào chuánshòu wénhuà zhīshi, gèng yào zhùzhòng péiyǎng xuésheng dúlì sīkǎo yǔ chuàngxīn de nénglì.',
      example_vi = 'Trường học không chỉ truyền thụ kiến thức văn hóa, mà càng phải coi trọng việc bồi dưỡng năng lực tư duy độc lập và đổi mới sáng tạo cho học sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '培养',
      'péiyǎng',
      'bồi dưỡng, đào tạo, nuôi dưỡng',
      'Động từ',
      'HSK 5',
      '学校不仅要传授文化知识，更要注重培养学生独立思考与创新的能力。',
      'Xuéxiào bùjǐn yào chuánshòu wénhuà zhīshi, gèng yào zhùzhòng péiyǎng xuésheng dúlì sīkǎo yǔ chuàngxīn de nénglì.',
      'Trường học không chỉ truyền thụ kiến thức văn hóa, mà càng phải coi trọng việc bồi dưỡng năng lực tư duy độc lập và đổi mới sáng tạo cho học sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校不仅要传授文化知识，更要注重培养学生独立思考与创新的能力。', 'Xuéxiào bùjǐn yào chuánshòu wénhuà zhīshi, gèng yào zhùzhòng péiyǎng xuésheng dúlì sīkǎo yǔ chuàngxīn de nénglì.', 'Trường học không chỉ truyền thụ kiến thức văn hóa, mà càng phải coi trọng việc bồi dưỡng năng lực tư duy độc lập và đổi mới sáng tạo cho học sinh.', 'basic', 1),
      (v_id, '建设教育强国、科技强国与人才强国，核心在于自主培养一大批具备家国情怀、深厚科学底蕴与全球竞争力的战略科学家及卓越工程师。', 'Jiànshè jiàoyù qiángguó, kējì qiángguó yǔ réncái qiángguó, héxīn zàiyú zìzhǔ péiyǎng yí dà pī jùbèi jiāguó qínghuái, shēnhòu kēxué dǐyùn yǔ quánqiú jìngzhēnglì de zhànlüè kēxuéjiā jí zhuóyuè gōngchéngshī.', 'Xây dựng cường quốc giáo dục, cường quốc khoa học công nghệ và cường quốc nhân tài, mấu chốt nằm ở chỗ tự chủ đào tạo bồi dưỡng một đội ngũ lớn các nhà khoa học chiến lược và kỹ sư xuất sắc mang nặng tấm lòng vì nước vì dân, nền tảng khoa học sâu sắc và sức cạnh tranh toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2819] [配] (pèi) - phối hợp, kết hợp, ghép đôi, tương xứng; xứng đôi [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '配' AND pinyin = 'pèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '配' AND pinyin = 'pèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '配'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '配'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'pèi',
      meaning_vi = 'phối hợp, kết hợp, ghép đôi, tương xứng; xứng đôi',
      example_hanzi = '这副新配的近视眼镜度数非常合适，看黑板上的字清晰多了。',
      example_pinyin = 'Zhè fù xīn pèi de jìnshì yǎnjìng dùshù fēicháng héshì, kàn hēibǎn shang de zì qīngxī duō le.',
      example_vi = 'Chiếc kính cận thị mới cắt này độ kính rất vừa vặn, nhìn chữ trên bảng đen rõ ràng hơn hẳn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '配',
      'pèi',
      'phối hợp, kết hợp, ghép đôi, tương xứng; xứng đôi',
      'Động từ / Tính từ',
      'HSK 5',
      '这副新配的近视眼镜度数非常合适，看黑板上的字清晰多了。',
      'Zhè fù xīn pèi de jìnshì yǎnjìng dùshù fēicháng héshì, kàn hēibǎn shang de zì qīngxī duō le.',
      'Chiếc kính cận thị mới cắt này độ kính rất vừa vặn, nhìn chữ trên bảng đen rõ ràng hơn hẳn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这副新配的近视眼镜度数非常合适，看黑板上的字清晰多了。', 'Zhè fù xīn pèi de jìnshì yǎnjìng dùshù fēicháng héshì, kàn hēibǎn shang de zì qīngxī duō le.', 'Chiếc kính cận thị mới cắt này độ kính rất vừa vặn, nhìn chữ trên bảng đen rõ ràng hơn hẳn.', 'basic', 1),
      (v_id, '在特种高强度复合合金铸造生产线上，各种微量稀土元素的配比精度必须达到微克级严苛标准，才能确保航天结构件优异的耐高温抗疲劳品质。', 'Zài tèzhǒng gāo qiángdù fùhé héjīn zhùzào shēngchǎnxiàn shang, gèzhǒng wēiliàng xītǔ yuánsù de pèibǐ jīngdù bìxū dádào wēikè jí yánkē biāozhǔn, cáinéng quèbǎo hángtiān jiégòujiàn yōuyì de nài gāowēn kàng píláo pǐnzhì.', 'Trên dây chuyền đúc hợp kim composite đặc chủng cường độ cao, độ chính xác trong tỷ lệ phối trộn các nguyên tố đất hiếm vi lượng bắt buộc phải đạt tiêu chuẩn khắt khe ở mức microgram thì mới có thể bảo đảm phẩm chất chịu nhiệt độ cao và kháng mỏi xuất sắc của cấu kiện hàng không.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2820] [配合] (pèihé) - phối hợp, ăn ý, cộng tác [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '配合' AND pinyin = 'pèihé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '配合' AND pinyin = 'pèihé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '配合'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '配合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pèihé',
      meaning_vi = 'phối hợp, ăn ý, cộng tác',
      example_hanzi = '在足球赛中，全队队员密切配合，通过精妙的传球打破了对方的球门。',
      example_pinyin = 'Zài zúqiúsài zhōng, quán duì duìyuán mìqiè pèihé, tōngguò jīngmiào de chuánqiú dǎpò le duìfāng de qiúmén.',
      example_vi = 'Trong trận bóng đá, các cầu thủ toàn đội phối hợp chặt chẽ, thông qua những đường chuyền bóng tinh tế đã xuyên thủng khung thành đối phương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '配合',
      'pèihé',
      'phối hợp, ăn ý, cộng tác',
      'Động từ',
      'HSK 5',
      '在足球赛中，全队队员密切配合，通过精妙的传球打破了对方的球门。',
      'Zài zúqiúsài zhōng, quán duì duìyuán mìqiè pèihé, tōngguò jīngmiào de chuánqiú dǎpò le duìfāng de qiúmén.',
      'Trong trận bóng đá, các cầu thủ toàn đội phối hợp chặt chẽ, thông qua những đường chuyền bóng tinh tế đã xuyên thủng khung thành đối phương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在足球赛中，全队队员密切配合，通过精妙的传球打破了对方的球门。', 'Zài zúqiúsài zhōng, quán duì duìyuán mìqiè pèihé, tōngguò jīngmiào de chuánqiú dǎpò le duìfāng de qiúmén.', 'Trong trận bóng đá, các cầu thủ toàn đội phối hợp chặt chẽ, thông qua những đường chuyền bóng tinh tế đã xuyên thủng khung thành đối phương.', 'basic', 1),
      (v_id, '在应对全球跨境金融洗钱犯罪中，央行与司法监管机关密切配合，构建起跨机构穿透式资金流向实时监测网络。', 'Zài yìngduì quánqiú kuàjìng jīnróng xǐqián fànzuì zhōng, yāngháng yǔ sīfǎ jiānguǎn jīguān mìqiè pèihé, gòujiàn qǐ kuà jīgòu chuāntòushì zījīn liúxiàng shíshí jiāncè wǎngluò.', 'Trong việc ứng phó với tội phạm rửa tiền tài chính xuyên biên giới toàn cầu, Ngân hàng Trung ương cùng cơ quan giám sát tư pháp phối hợp chặt chẽ, xây dựng mạng lưới giám sát thời gian thực dòng tiền có tính xuyên thấu liên cơ quan.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2821] [配送] (pèisòng) - giao hàng, phân phối hàng hóa, điều chuyển hàng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '配送' AND pinyin = 'pèisòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '配送' AND pinyin = 'pèisòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '配送'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '配送'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pèisòng',
      meaning_vi = 'giao hàng, phân phối hàng hóa, điều chuyển hàng',
      example_hanzi = '现代快递物流十分高效，同城网购生鲜商品当天就可以完成配送。',
      example_pinyin = 'Xiàndài kuàidì wùliú shífēn gāoxiào, tóngchéng wǎnggòu shēngxiān shāngpǐn dàngtiān jiù kěyǐ wánchéng pèisòng.',
      example_vi = 'Hậu cần chuyển phát nhanh hiện đại rất hiệu quả, mua sắm thực phẩm tươi sống qua mạng cùng thành phố có thể hoàn thành giao hàng ngay trong ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '配送',
      'pèisòng',
      'giao hàng, phân phối hàng hóa, điều chuyển hàng',
      'Động từ',
      'HSK 5',
      '现代快递物流十分高效，同城网购生鲜商品当天就可以完成配送。',
      'Xiàndài kuàidì wùliú shífēn gāoxiào, tóngchéng wǎnggòu shēngxiān shāngpǐn dàngtiān jiù kěyǐ wánchéng pèisòng.',
      'Hậu cần chuyển phát nhanh hiện đại rất hiệu quả, mua sắm thực phẩm tươi sống qua mạng cùng thành phố có thể hoàn thành giao hàng ngay trong ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现代快递物流十分高效，同城网购生鲜商品当天就可以完成配送。', 'Xiàndài kuàidì wùliú shífēn gāoxiào, tóngchéng wǎnggòu shēngxiān shāngpǐn dàngtiān jiù kěyǐ wánchéng pèisòng.', 'Hậu cần chuyển phát nhanh hiện đại rất hiệu quả, mua sắm thực phẩm tươi sống qua mạng cùng thành phố có thể hoàn thành giao hàng ngay trong ngày.', 'basic', 1),
      (v_id, '依托无人机集群与无人驾驶物流车协同作业，偏远海岛与高山村落实现了冷链医药与生活急需物资的常态化精准高效配送。', 'Yītuō wúrénjī jíqún yǔ wúrén jiàshǐ wùliúchē xiétóng zuòyè, piānyuǎn hǎidǎo yǔ gāoshān cūnluò shíxiàn le lěngliàn yīyào yǔ shēnghuó jíxū wùzī de chángtàihuà jīngzhǔn gāoxiào pèisòng.', 'Dựa vào sự phối hợp tác nghiệp giữa đàn flycam và xe hậu cần tự hành, các hải đảo xa xôi cùng thôn bản vùng núi cao đã hiện thực hóa việc phân phối định kỳ chuẩn xác và hiệu quả cao đối với dược phẩm chuỗi lạnh và vật tư thiết yếu đời sống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2822] [盆] (pén) - cái chậu, cái bồn; chậu (lượng từ) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '盆' AND pinyin = 'pén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '盆' AND pinyin = 'pén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '盆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '盆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'pén',
      meaning_vi = 'cái chậu, cái bồn; chậu (lượng từ)',
      example_hanzi = '书房窗台上摆放着一盆生机盎然的君子兰，给房间增添了不少清雅之气。',
      example_pinyin = 'Shūfáng chuāngtái shang bǎifàng zhe yì pén shēngjī-àngrán de jūnzǐlán, gěi fángjiān zēngtiān le bù shǎo qīngyǎ zhī qì.',
      example_vi = 'Trên bậu cửa sổ phòng đọc sách bày một chậu lan quân tử xanh tươi tràn trề sức sống, mang lại cho căn phòng không ít vẻ thanh nhã.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '盆',
      'pén',
      'cái chậu, cái bồn; chậu (lượng từ)',
      'Danh từ / Lượng từ',
      'HSK 5',
      '书房窗台上摆放着一盆生机盎然的君子兰，给房间增添了不少清雅之气。',
      'Shūfáng chuāngtái shang bǎifàng zhe yì pén shēngjī-àngrán de jūnzǐlán, gěi fángjiān zēngtiān le bù shǎo qīngyǎ zhī qì.',
      'Trên bậu cửa sổ phòng đọc sách bày một chậu lan quân tử xanh tươi tràn trề sức sống, mang lại cho căn phòng không ít vẻ thanh nhã.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '书房窗台上摆放着一盆生机盎然的君子兰，给房间增添了不少清雅之气。', 'Shūfáng chuāngtái shang bǎifàng zhe yì pén shēngjī-àngrán de jūnzǐlán, gěi fángjiān zēngtiān le bù shǎo qīngyǎ zhī qì.', 'Trên bậu cửa sổ phòng đọc sách bày một chậu lan quân tử xanh tươi tràn trề sức sống, mang lại cho căn phòng không ít vẻ thanh nhã.', 'basic', 1),
      (v_id, '地质科考队员在塔里木大型含油气构造盆地深层勘探中，成功钻探出埋深超过九千米的特深超深油气高产富集层。', 'Dìzhì kěkǎo duìyuán zài Tǎlǐmù dàxíng hán yóuqì gòuzào péndì shēncéng kāntàn zhōng, chénggōng zuàntàn chū máishēn chāoguò jiǔqiān mǐ de tèshēn chāoshēn yóuqì gāochǎn fùjí céng.', 'Đội khảo sát địa chất trong đợt thăm dò tầng sâu tại bồn địa kiến tạo chứa dầu khí lớn Tarim đã khoan thành công tới tầng trầm tích dầu khí năng suất cao siêu sâu có độ chôn vùi sâu hơn 9.000 mét.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2823] [碰] (pèng) - va chạm, chạm vào, đụng phải [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '碰' AND pinyin = 'pèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '碰' AND pinyin = 'pèng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '碰'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '碰'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pèng',
      meaning_vi = 'va chạm, chạm vào, đụng phải',
      example_hanzi = '走路看手机很容易不小心碰到路边的路灯柱子。',
      example_pinyin = 'Zǒulù kàn shǒujī hěn róngyì bù xiǎoxīn pèng dào lùbiān de lùdēng zhùzi.',
      example_vi = 'Vừa đi bộ vừa nhìn điện thoại rất dễ không cẩn thận va phải cột đèn đường bên lề.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '碰',
      'pèng',
      'va chạm, chạm vào, đụng phải',
      'Động từ',
      'HSK 5',
      '走路看手机很容易不小心碰到路边的路灯柱子。',
      'Zǒulù kàn shǒujī hěn róngyì bù xiǎoxīn pèng dào lùbiān de lùdēng zhùzi.',
      'Vừa đi bộ vừa nhìn điện thoại rất dễ không cẩn thận va phải cột đèn đường bên lề.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '走路看手机很容易不小心碰到路边的路灯柱子。', 'Zǒulù kàn shǒujī hěn róngyì bù xiǎoxīn pèng dào lùbiān de lùdēng zhùzi.', 'Vừa đi bộ vừa nhìn điện thoại rất dễ không cẩn thận va phải cột đèn đường bên lề.', 'basic', 1),
      (v_id, '在推进全面深化改革的攻坚期，必须敢于啃硬骨头、敢于涉险滩，决不能在触及深层次利益格局调整的核心问题面前不敢碰硬。', 'Zài tuījìn quánmiàn shēnhuà gǎigé de gōngjiānqī, bìxū gǎnyú kěn yìnggǔtou, gǎnyú shè xiǎntān, jué bùnéng zài chùjí shēncéngcì lìyì géjú tiáozhěng de héxīn wèntí miànqián bù gǎn pèngyìng.', 'Trong giai đoạn then chốt đẩy mạnh cải cách sâu rộng toàn diện, đòi hỏi phải dám gặm xương khó, dám lội bãi cạn nguy hiểm, tuyệt đối không được chùn bước không dám va chạm trước các vấn đề cốt lõi đụng chạm tới việc điều chỉnh cục diện lợi ích tầng sâu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2824] [碰见] (pèngjiàn) - tình cờ gặp, đụng mặt, bắt gặp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '碰见' AND pinyin = 'pèngjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '碰见' AND pinyin = 'pèngjiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '碰见'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '碰见'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pèngjiàn',
      meaning_vi = 'tình cờ gặp, đụng mặt, bắt gặp',
      example_hanzi = '昨天在市中心商业街散步时，我偶然碰见了好多年没联系的高中同桌。',
      example_pinyin = 'Zuótiān zài shì zhōngxīn shāngyèjiē sànbù shí, wǒ ǒurán pèngjiàn le hǎo duō nián méi liánxì de gāozhōng tóngzhuō.',
      example_vi = 'Hôm qua khi đi dạo trên phố thương mại trung tâm thành phố, tôi tình cờ đụng mặt người bạn cùng bàn cấp ba đã bao năm mất liên lạc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '碰见',
      'pèngjiàn',
      'tình cờ gặp, đụng mặt, bắt gặp',
      'Động từ',
      'HSK 5',
      '昨天在市中心商业街散步时，我偶然碰见了好多年没联系的高中同桌。',
      'Zuótiān zài shì zhōngxīn shāngyèjiē sànbù shí, wǒ ǒurán pèngjiàn le hǎo duō nián méi liánxì de gāozhōng tóngzhuō.',
      'Hôm qua khi đi dạo trên phố thương mại trung tâm thành phố, tôi tình cờ đụng mặt người bạn cùng bàn cấp ba đã bao năm mất liên lạc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '昨天在市中心商业街散步时，我偶然碰见了好多年没联系的高中同桌。', 'Zuótiān zài shì zhōngxīn shāngyèjiē sànbù shí, wǒ ǒurán pèngjiàn le hǎo duō nián méi liánxì de gāozhōng tóngzhuō.', 'Hôm qua khi đi dạo trên phố thương mại trung tâm thành phố, tôi tình cờ đụng mặt người bạn cùng bàn cấp ba đã bao năm mất liên lạc.', 'basic', 1),
      (v_id, '在重大工程技术攻关进程中，研发团队时常会碰见前所未有的极限物理参数瓶颈，这正是倒逼原始理论创新的关键契机。', 'Zài zhòngdà gōngchéng jìshù gōngjiān jìnchéng zhōng, yánfā tuánduì shícháng huì pèngjiàn qiánsuǒwèiyǒu de jíxiàn wùlǐ cānshù píngjǐng, zhè zhèngshì dàobī yuánshǐ lǐlùn chuàngxīn de guānjiàn qìjī.', 'Trong tiến trình đột phá công nghệ kỹ thuật công trình trọng đại, đội ngũ nghiên cứu phát triển thường xuyên bắt gặp những điểm nghẽn thông số vật lý cực hạn chưa từng có, đây chính là cơ duyên then chốt thúc ép đổi mới lý luận nguyên bản.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2825] [批] (pī) - mẻ, đợt, lô, chuyến (lượng từ cho hàng hóa, số lượng người) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '批' AND pinyin = 'pī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '批' AND pinyin = 'pī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '批'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '批'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ',
      pinyin = 'pī',
      meaning_vi = 'mẻ, đợt, lô, chuyến (lượng từ cho hàng hóa, số lượng người)',
      example_hanzi = '第一批经过严格检验的优质有机苹果即将打包发往全国各地超市。',
      example_pinyin = 'Dì-yī pī jīngguò yángé jiǎnyàn de yōuzhì yǒujī píngguǒ jíjiāng dǎbāo fāwǎng quánguó gèdì chāoshì.',
      example_vi = 'Lô táo hữu cơ hảo hạng đầu tiên trải qua kiểm định nghiêm ngặt sắp được đóng gói chuyển tới các siêu thị khắp các vùng miền toàn quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '批',
      'pī',
      'mẻ, đợt, lô, chuyến (lượng từ cho hàng hóa, số lượng người)',
      'Lượng từ',
      'HSK 5',
      '第一批经过严格检验的优质有机苹果即将打包发往全国各地超市。',
      'Dì-yī pī jīngguò yángé jiǎnyàn de yōuzhì yǒujī píngguǒ jíjiāng dǎbāo fāwǎng quánguó gèdì chāoshì.',
      'Lô táo hữu cơ hảo hạng đầu tiên trải qua kiểm định nghiêm ngặt sắp được đóng gói chuyển tới các siêu thị khắp các vùng miền toàn quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '第一批经过严格检验的优质有机苹果即将打包发往全国各地超市。', 'Dì-yī pī jīngguò yángé jiǎnyàn de yōuzhì yǒujī píngguǒ jíjiāng dǎbāo fāwǎng quánguó gèdì chāoshì.', 'Lô táo hữu cơ hảo hạng đầu tiên trải qua kiểm định nghiêm ngặt sắp được đóng gói chuyển tới các siêu thị khắp các vùng miền toàn quốc.', 'basic', 1),
      (v_id, '国家统筹选派的一大批具备丰富实战经验的高校科研专家与青年技术骨干，陆续深入中西部欠发达地区开展长期定点科技对口支援。', 'Guójiā tǒngchóu xuǎnpài de yí dà pī jùbèi fēngfù shízhàn jīngyàn de gāoxiào kēyán zhuānjiā yǔ qīngnián jìshù gǔgàn, lùxù shēnrù zhōng-xībù qiànfādá dìqū kāizhǎn chángqī dìngdiǎn kējì duìkǒu zhīyuán.', 'Một lực lượng đông đảo các chuyên gia nghiên cứu khoa học trường đại học và cán bộ kỹ thuật trẻ giàu kinh nghiệm thực chiến do nhà nước quy hoạch tuyển chọn đã lần lượt sâu sát về các vùng kém phát triển miền Trung và miền Tây để thực hiện chi viện đối ứng khoa học công nghệ dài hạn theo địa chỉ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2826] [批] (pī) - phê chuẩn, phê duyệt; phê bình, chỉ trích, phê phán [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '批' AND pinyin = 'pī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '批' AND pinyin = 'pī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '批'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '批'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pī',
      meaning_vi = 'phê chuẩn, phê duyệt; phê bình, chỉ trích, phê phán',
      example_hanzi = '教务处领导在认真审查后，正式在小李的出国留学申请书上批复同意。',
      example_pinyin = 'Jiàowùchù lǐngdǎo zài rènzhēn shěnchá hòu, zhèngshì zài Xiǎo Lǐ de chūguó liúxué shēnqǐngshū shang pīfù tóngyì.',
      example_vi = 'Lãnh đạo phòng đào tạo sau khi thẩm tra kỹ lưỡng đã chính thức phê chuẩn đồng ý trên lá đơn xin đi du học nước ngoài của Tiểu Lý.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '批',
      'pī',
      'phê chuẩn, phê duyệt; phê bình, chỉ trích, phê phán',
      'Động từ',
      'HSK 5',
      '教务处领导在认真审查后，正式在小李的出国留学申请书上批复同意。',
      'Jiàowùchù lǐngdǎo zài rènzhēn shěnchá hòu, zhèngshì zài Xiǎo Lǐ de chūguó liúxué shēnqǐngshū shang pīfù tóngyì.',
      'Lãnh đạo phòng đào tạo sau khi thẩm tra kỹ lưỡng đã chính thức phê chuẩn đồng ý trên lá đơn xin đi du học nước ngoài của Tiểu Lý.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '教务处领导在认真审查后，正式在小李的出国留学申请书上批复同意。', 'Jiàowùchù lǐngdǎo zài rènzhēn shěnchá hòu, zhèngshì zài Xiǎo Lǐ de chūguó liúxué shēnqǐngshū shang pīfù tóngyì.', 'Lãnh đạo phòng đào tạo sau khi thẩm tra kỹ lưỡng đã chính thức phê chuẩn đồng ý trên lá đơn xin đi du học nước ngoài của Tiểu Lý.', 'basic', 1),
      (v_id, '有关职能监管部门对个别上市公司虚构财务数据并恶意操纵股票交易价格的行为给予公开通报严厉批评，并依法实施巨额惩罚。', 'Yǒuguān zhíngnéng jiānguǎn bùmén duì gèbié shàngshì gōngsī xūgòu cáiwù shùjù bìng èyì cāozòng gǔpiào jiāoyì jiàgé de xíngwéi jǐyǔ gōngkāi tōngbào yánlì pīpíng, bìng yīfǎ shíshī jù’é chéngfá.', 'Cơ quan giám sát chức năng hữu quan đã thông báo công khai phê bình nghiêm khắc đối với hành vi ngụy tạo số liệu tài chính và thao túng giá giao dịch cổ phiếu một cách ác ý của một số công ty niêm yết, đồng thời xử phạt số tiền khổng lồ theo pháp luật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2827] [批准] (pīzhǔn) - phê chuẩn, chuẩn y, chấp thuận [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '批准' AND pinyin = 'pīzhǔn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '批准' AND pinyin = 'pīzhǔn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '批准'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '批准'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pīzhǔn',
      meaning_vi = 'phê chuẩn, chuẩn y, chấp thuận',
      example_hanzi = '董事会经过慎重讨论，正式批准了公司下半年的海外扩张预算。',
      example_pinyin = 'Dǒngshìhuì jīngguò shènzhòng tǎolùn, zhèngshì pīzhǔn le gōngsī xiàbànnián de hǎiwài kuòzhāng yùsuàn.',
      example_vi = 'Hội đồng quản trị sau khi thảo luận thận trọng đã chính thức phê chuẩn ngân sách mở rộng ra nước ngoài trong nửa cuối năm của công ty.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '批准',
      'pīzhǔn',
      'phê chuẩn, chuẩn y, chấp thuận',
      'Động từ',
      'HSK 5',
      '董事会经过慎重讨论，正式批准了公司下半年的海外扩张预算。',
      'Dǒngshìhuì jīngguò shènzhòng tǎolùn, zhèngshì pīzhǔn le gōngsī xiàbànnián de hǎiwài kuòzhāng yùsuàn.',
      'Hội đồng quản trị sau khi thảo luận thận trọng đã chính thức phê chuẩn ngân sách mở rộng ra nước ngoài trong nửa cuối năm của công ty.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '董事会经过慎重讨论，正式批准了公司下半年的海外扩张预算。', 'Dǒngshìhuì jīngguò shènzhòng tǎolùn, zhèngshì pīzhǔn le gōngsī xiàbànnián de hǎiwài kuòzhāng yùsuàn.', 'Hội đồng quản trị sau khi thảo luận thận trọng đã chính thức phê chuẩn ngân sách mở rộng ra nước ngoài trong nửa cuối năm của công ty.', 'basic', 1),
      (v_id, '国家药品监督管理部门依法严格审查临床试验数据，正式批准该款靶向创新药物进入市场流通与临床应用。', 'Guójiā yàopǐn jiāndū guǎnlǐ bùmén yīfǎ yángé shěnchá línchuáng shìyàn shùjù, zhèngshì pīzhǔn gāi kuǎn bǎxiàng chuàngxīn yàowù jìnrù shìchǎng liútōng yǔ línchuáng yìngyòng.', 'Cơ quan quản lý giám sát dược phẩm quốc gia thẩm tra nghiêm ngặt dữ liệu thử nghiệm lâm sàng theo luật định, chính thức phê chuẩn thuốc cải tiến nhắm trúng đích lưu hành thị trường và ứng dụng lâm sàng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2828] [匹] (pǐ) - con (ngựa, lừa...), cây / sấp (vải) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '匹' AND pinyin = 'pǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '匹' AND pinyin = 'pǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '匹'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '匹'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ',
      pinyin = 'pǐ',
      meaning_vi = 'con (ngựa, lừa...), cây / sấp (vải)',
      example_hanzi = '草原上一匹骏马飞快地奔跑，鬃毛在风中迎风飞扬。',
      example_pinyin = 'Cǎoyuán shang yì pǐ jùnmǎ fēikuài de bēnpǎo, zōngmáo zài fēng zhōng yíngfēng fēiyáng.',
      example_vi = 'Trên thảo nguyên một con ngựa tuấn mã phi nhanh vun vút, bờm tung bay trước gió.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '匹',
      'pǐ',
      'con (ngựa, lừa...), cây / sấp (vải)',
      'Lượng từ',
      'HSK 5',
      '草原上一匹骏马飞快地奔跑，鬃毛在风中迎风飞扬。',
      'Cǎoyuán shang yì pǐ jùnmǎ fēikuài de bēnpǎo, zōngmáo zài fēng zhōng yíngfēng fēiyáng.',
      'Trên thảo nguyên một con ngựa tuấn mã phi nhanh vun vút, bờm tung bay trước gió.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '草原上一匹骏马飞快地奔跑，鬃毛在风中迎风飞扬。', 'Cǎoyuán shang yì pǐ jùnmǎ fēikuài de bēnpǎo, zōngmáo zài fēng zhōng yíngfēng fēiyáng.', 'Trên thảo nguyên một con ngựa tuấn mã phi nhanh vun vút, bờm tung bay trước gió.', 'basic', 1),
      (v_id, '工匠们精心挑选了数匹上等苏绣丝绸，为国际文化交流博览会定制极具东方韵味的传统礼服。', 'Gōngjiàngmen jīngxīn tiāoxuǎn le shù pǐ shàngděng Sūxiù sīchóu, wèi guójì wénhuà jiāoliú bólǎnhuì dìngzhì jí jù dōngfāng yùnwèi de chuántǒng lǐfú.', 'Các nghệ nhân đã tỉ mỉ tuyển chọn nhiều cây lụa thêu Tô Châu thượng hạng để may đo lễ phục truyền thống đậm đà phong vị phương Đông cho hội chợ giao lưu văn hóa quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2829] [骗] (piàn) - lừa gạt, dối gạt, đánh lừa [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '骗' AND pinyin = 'piàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '骗' AND pinyin = 'piàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '骗'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '骗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'piàn',
      meaning_vi = 'lừa gạt, dối gạt, đánh lừa',
      example_hanzi = '做人要诚实守信，千万不能为了眼前的小利益去骗人。',
      example_pinyin = 'Zuòrén yào chéngshí shǒuxìn, qiānwàn bù néng wèile yǎnqián de xiǎo lìyì qù piàn rén.',
      example_vi = 'Làm người phải trung thực giữ chữ tín, tuyệt đối không được vì món lợi nhỏ trước mắt mà đi lừa gạt người khác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '骗',
      'piàn',
      'lừa gạt, dối gạt, đánh lừa',
      'Động từ',
      'HSK 5',
      '做人要诚实守信，千万不能为了眼前的小利益去骗人。',
      'Zuòrén yào chéngshí shǒuxìn, qiānwàn bù néng wèile yǎnqián de xiǎo lìyì qù piàn rén.',
      'Làm người phải trung thực giữ chữ tín, tuyệt đối không được vì món lợi nhỏ trước mắt mà đi lừa gạt người khác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '做人要诚实守信，千万不能为了眼前的小利益去骗人。', 'Zuòrén yào chéngshí shǒuxìn, qiānwàn bù néng wèile yǎnqián de xiǎo lìyì qù piàn rén.', 'Làm người phải trung thực giữ chữ tín, tuyệt đối không được vì món lợi nhỏ trước mắt mà đi lừa gạt người khác.', 'basic', 1),
      (v_id, '电信诈骗分子利用深度伪造技术与心理诱导手段，企图骗取受害者账户敏感信息与大额资金转账。', 'Diànxìn zhàpiàn fènzǐ lìyòng shēndù wěizào jìshù yǔ xīnlǐ yòudǎo shǒuduàn, qǐtú piànqǔ shòuhàizhě zhànghù mǐngǎn xìnxī yǔ dà’é zījīn zhuǎnzhàng.', 'Các đối tượng lừa đảo viễn thông lợi dụng công nghệ deepfake và thủ đoạn thao túng tâm lý nhằm mưu toan lừa đoạt thông tin tài khoản nhạy cảm và lệnh chuyển tiền giá trị lớn của nạn nhân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2830] [拼] (pīn) - ghép lại, liều mình, dốc sức chiến đấu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '拼' AND pinyin = 'pīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拼' AND pinyin = 'pīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '拼'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拼'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pīn',
      meaning_vi = 'ghép lại, liều mình, dốc sức chiến đấu',
      example_hanzi = '孩子们围坐在地毯上，专注地把零散的积木拼成一座美丽的城堡。',
      example_pinyin = 'Háizimen wéizuò zài dǐtǎn shang, zhuānzhù de bǎ língsǎn de jīmù pīn chéng yí zuò měilì de chéngbǎo.',
      example_vi = 'Những đứa trẻ ngồi vây quanh tấm thảm, chăm chú ghép các khối xếp hình rời rạc thành một tòa lâu đài xinh đẹp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '拼',
      'pīn',
      'ghép lại, liều mình, dốc sức chiến đấu',
      'Động từ',
      'HSK 5',
      '孩子们围坐在地毯上，专注地把零散的积木拼成一座美丽的城堡。',
      'Háizimen wéizuò zài dǐtǎn shang, zhuānzhù de bǎ língsǎn de jīmù pīn chéng yí zuò měilì de chéngbǎo.',
      'Những đứa trẻ ngồi vây quanh tấm thảm, chăm chú ghép các khối xếp hình rời rạc thành một tòa lâu đài xinh đẹp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '孩子们围坐在地毯上，专注地把零散的积木拼成一座美丽的城堡。', 'Háizimen wéizuò zài dǐtǎn shang, zhuānzhù de bǎ língsǎn de jīmù pīn chéng yí zuò měilì de chéngbǎo.', 'Những đứa trẻ ngồi vây quanh tấm thảm, chăm chú ghép các khối xếp hình rời rạc thành một tòa lâu đài xinh đẹp.', 'basic', 1),
      (v_id, '面对严峻的市场竞争与技术壁垒，年轻的科研团队勇于拼搏，终于在核心算法领域攻坚克难。', 'Miànduì yánjùn de shìchǎng jìngzhēng yǔ jìshù bìlěi, niánqīng de kēyán tuánduì yǒngyú pīnbó, zhōngyú zài héxīn suànfǎ lǐngyù gōngjiān-kènán.', 'Đối mặt với cạnh tranh thị trường gay gắt và rào cản kỹ thuật, đội ngũ nghiên cứu trẻ tuổi đã dũng cảm dốc sức phấn đấu, cuối cùng khắc phục khó khăn nan giải trong lĩnh vực thuật toán cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2831] [拼音] (pīnyīn) - đánh vần, phiên âm pinyin [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '拼音' AND pinyin = 'pīnyīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拼音' AND pinyin = 'pīnyīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '拼音'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拼音'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'pīnyīn',
      meaning_vi = 'đánh vần, phiên âm pinyin',
      example_hanzi = '初学汉语的外国留学生通常先通过拼音掌握正确的汉字发音。',
      example_pinyin = 'Chūxué Hànyǔ de wàiguó liúxuéshēng tōngcháng xiān tōngguò pīnyīn zhǎngwò zhèngquè de hànzì fāyīn.',
      example_vi = 'Du học sinh nước ngoài mới học tiếng Hán thường trước tiên thông qua pinyin để nắm vững phát âm chữ Hán chính xác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '拼音',
      'pīnyīn',
      'đánh vần, phiên âm pinyin',
      'Động từ / Danh từ',
      'HSK 5',
      '初学汉语的外国留学生通常先通过拼音掌握正确的汉字发音。',
      'Chūxué Hànyǔ de wàiguó liúxuéshēng tōngcháng xiān tōngguò pīnyīn zhǎngwò zhèngquè de hànzì fāyīn.',
      'Du học sinh nước ngoài mới học tiếng Hán thường trước tiên thông qua pinyin để nắm vững phát âm chữ Hán chính xác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '初学汉语的外国留学生通常先通过拼音掌握正确的汉字发音。', 'Chūxué Hànyǔ de wàiguó liúxuéshēng tōngcháng xiān tōngguò pīnyīn zhǎngwò zhèngquè de hànzì fāyīn.', 'Du học sinh nước ngoài mới học tiếng Hán thường trước tiên thông qua pinyin để nắm vững phát âm chữ Hán chính xác.', 'basic', 1),
      (v_id, '汉语拼音方案作为联合国通用的中文罗马字母拼写国际标准，极大便利了跨文化语言交流与现代信息化检索。', 'Hànyǔ pīnyīn fāng’àn zuòwéi Liánhéguó tōngyòng de Zhōngwén Luómǎ zìmǔ pīnxiě guójì biāozhǔn, jídà biànlì le kuà-wénhuà yǔyán jiāoliú yǔ xiàndài xìnxīhuà jiǎnsuǒ.', 'Phương án Bính âm Hán ngữ với tư cách là tiêu chuẩn quốc tế về phiên âm chữ La-tinh tiếng Trung được Liên Hợp Quốc sử dụng rộng rãi, đã tạo thuận tiện to lớn cho giao lưu ngôn ngữ đa văn hóa và tra cứu thông tin hóa hiện đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2832] [品] (pǐn) - loại hàng phẩm, vật phẩm; thưởng thức, nếm [Hậu tố / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '品' AND pinyin = 'pǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '品' AND pinyin = 'pǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '品'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Hậu tố / Động từ',
      pinyin = 'pǐn',
      meaning_vi = 'loại hàng phẩm, vật phẩm; thưởng thức, nếm',
      example_hanzi = '超市货架上整齐地陈列着各种日用品和健康食品。',
      example_pinyin = 'Chāoshì huòjià shang zhěngqí de chénliè zhe gè zhǒng rìyòngpǐn hé jiànkāng shípǐn.',
      example_vi = 'Trên các kệ hàng siêu thị xếp ngay ngắn đủ loại đồ dùng hàng ngày và thực phẩm có lợi cho sức khỏe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '品',
      'pǐn',
      'loại hàng phẩm, vật phẩm; thưởng thức, nếm',
      'Hậu tố / Động từ',
      'HSK 5',
      '超市货架上整齐地陈列着各种日用品和健康食品。',
      'Chāoshì huòjià shang zhěngqí de chénliè zhe gè zhǒng rìyòngpǐn hé jiànkāng shípǐn.',
      'Trên các kệ hàng siêu thị xếp ngay ngắn đủ loại đồ dùng hàng ngày và thực phẩm có lợi cho sức khỏe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '超市货架上整齐地陈列着各种日用品和健康食品。', 'Chāoshì huòjià shang zhěngqí de chénliè zhe gè zhǒng rìyòngpǐn hé jiànkāng shípǐn.', 'Trên các kệ hàng siêu thị xếp ngay ngắn đủ loại đồ dùng hàng ngày và thực phẩm có lợi cho sức khỏe.', 'basic', 1),
      (v_id, '学者们在清幽的茶室中细品明前龙井，深刻感悟中华茶道中蕴含的淡泊宁静与生命哲学。', 'Xuézhěmen zài qīngyōu de cháshì zhōng xì pǐn Míngqián Lóngjǐng, shēnkè gǎnwù Zhōnghuá chádào zhōng yùnhán de dànbó-níngjìng yǔ shēngmìng zhéxué.', 'Các học giả ngồi trong trà thất thanh tịnh nhâm nhi thưởng thức trà Long Tỉnh đầu xuân, cảm ngộ sâu sắc sự thanh đạm an yên và triết lý nhân sinh ẩn chứa trong trà đạo Trung Hoa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2833] [品牌] (pǐnpái) - thương hiệu, nhãn hiệu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '品牌' AND pinyin = 'pǐnpái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '品牌' AND pinyin = 'pǐnpái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '品牌'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '品牌'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'pǐnpái',
      meaning_vi = 'thương hiệu, nhãn hiệu',
      example_hanzi = '这家老字号点心铺凭借过硬的质量，树立了深受老百姓信赖的知名品牌。',
      example_pinyin = 'Zhè jiā lǎozìhào diǎnxinpù píngjiè guòyìng de zhìliàng, shùlì le shēnshòu lǎobǎixìng xìnlài de zhīmíng pǐnpái.',
      example_vi = 'Tiệm điểm tâm lâu đời này nhờ chất lượng vượt trội đã gây dựng nên một thương hiệu nổi tiếng được người dân hết sức tin yêu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '品牌',
      'pǐnpái',
      'thương hiệu, nhãn hiệu',
      'Danh từ',
      'HSK 5',
      '这家老字号点心铺凭借过硬的质量，树立了深受老百姓信赖的知名品牌。',
      'Zhè jiā lǎozìhào diǎnxinpù píngjiè guòyìng de zhìliàng, shùlì le shēnshòu lǎobǎixìng xìnlài de zhīmíng pǐnpái.',
      'Tiệm điểm tâm lâu đời này nhờ chất lượng vượt trội đã gây dựng nên một thương hiệu nổi tiếng được người dân hết sức tin yêu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家老字号点心铺凭借过硬的质量，树立了深受老百姓信赖的知名品牌。', 'Zhè jiā lǎozìhào diǎnxinpù píngjiè guòyìng de zhìliàng, shùlì le shēnshòu lǎobǎixìng xìnlài de zhīmíng pǐnpái.', 'Tiệm điểm tâm lâu đời này nhờ chất lượng vượt trội đã gây dựng nên một thương hiệu nổi tiếng được người dân hết sức tin yêu.', 'basic', 1),
      (v_id, '全球化企业不仅需要注重核心产品研发，更要通过文化赋能与合规经营塑造卓越的国际品牌声誉。', 'Quánqiúhuà qǐyè bùjǐn xūyào zhùzhòng héxīn chǎnpǐn yánfā, gèng yào tōngguò wénhuà fùnéng yǔ héguī jīngyíng shùzào zhuóyuè de guójì pǐnpái shēngyù.', 'Doanh nghiệp toàn cầu hóa không chỉ cần chú trọng nghiên cứu phát triển sản phẩm cốt lõi mà còn phải kiến tạo uy tín thương hiệu quốc tế vượt bậc thông qua nâng cao giá trị văn hóa và kinh doanh tuân thủ pháp luật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2834] [品质] (pǐnzhì) - chất lượng (hàng hóa), phẩm chất (con người) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '品质' AND pinyin = 'pǐnzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '品质' AND pinyin = 'pǐnzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '品质'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '品质'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'pǐnzhì',
      meaning_vi = 'chất lượng (hàng hóa), phẩm chất (con người)',
      example_hanzi = '购买电子产品时，他首先考虑的是设备的做工与使用品质。',
      example_pinyin = 'Gòumǎi diànzǐ chǎnpǐn shí, tā shǒuxiān kǎolǜ de shì shèbèi de zuògōng yǔ shǐyòng pǐnzhì.',
      example_vi = 'Khi mua đồ điện tử, điều anh ấy cân nhắc đầu tiên là độ tinh xảo gia công và chất lượng sử dụng của thiết bị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '品质',
      'pǐnzhì',
      'chất lượng (hàng hóa), phẩm chất (con người)',
      'Danh từ',
      'HSK 5',
      '购买电子产品时，他首先考虑的是设备的做工与使用品质。',
      'Gòumǎi diànzǐ chǎnpǐn shí, tā shǒuxiān kǎolǜ de shì shèbèi de zuògōng yǔ shǐyòng pǐnzhì.',
      'Khi mua đồ điện tử, điều anh ấy cân nhắc đầu tiên là độ tinh xảo gia công và chất lượng sử dụng của thiết bị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '购买电子产品时，他首先考虑的是设备的做工与使用品质。', 'Gòumǎi diànzǐ chǎnpǐn shí, tā shǒuxiān kǎolǜ de shì shèbèi de zuògōng yǔ shǐyòng pǐnzhì.', 'Khi mua đồ điện tử, điều anh ấy cân nhắc đầu tiên là độ tinh xảo gia công và chất lượng sử dụng của thiết bị.', 'basic', 1),
      (v_id, '高尚的人格品质、坚忍不拔的科研定力与勇于担当的奉献精神，是杰出科学家不可或缺的精神内核。', 'Gāoshàng de réngé pǐnzhì, jiānrěn-bùbá de kēyán dìnglì yǔ yǒngyú dāndāng de fèngxiàn jīngshén, shì jiéchū kēxuéjiā bùkě huòquē de jīngshén nèihé.', 'Phẩm chất nhân cách cao thượng, định lực nghiên cứu kiên định bất khuất và tinh thần cống hiến dám chịu trách nhiệm là hạt nhân tinh thần không thể thiếu của các nhà khoa học kiệt xuất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2835] [品种] (pǐnzhǒng) - chủng loại, giống (cây trồng, vật nuôi) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '品种' AND pinyin = 'pǐnzhǒng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '品种' AND pinyin = 'pǐnzhǒng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '品种'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '品种'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'pǐnzhǒng',
      meaning_vi = 'chủng loại, giống (cây trồng, vật nuôi)',
      example_hanzi = '农贸市场上蔬菜水果品种丰富，应有尽有。',
      example_pinyin = 'Nóngmào shìchǎng shang shūcài shuǐguǒ pǐnzhǒng fēngfù, yīngyǒu-jìnyǒu.',
      example_vi = 'Ở chợ nông sản các chủng loại rau củ và trái cây vô cùng phong phú, cái gì cũng có.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '品种',
      'pǐnzhǒng',
      'chủng loại, giống (cây trồng, vật nuôi)',
      'Danh từ',
      'HSK 5',
      '农贸市场上蔬菜水果品种丰富，应有尽有。',
      'Nóngmào shìchǎng shang shūcài shuǐguǒ pǐnzhǒng fēngfù, yīngyǒu-jìnyǒu.',
      'Ở chợ nông sản các chủng loại rau củ và trái cây vô cùng phong phú, cái gì cũng có.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '农贸市场上蔬菜水果品种丰富，应有尽有。', 'Nóngmào shìchǎng shang shūcài shuǐguǒ pǐnzhǒng fēngfù, yīngyǒu-jìnyǒu.', 'Ở chợ nông sản các chủng loại rau củ và trái cây vô cùng phong phú, cái gì cũng có.', 'basic', 1),
      (v_id, '农业科学家成功培育出抗旱耐盐碱的高产杂交水稻新品种，为保障国家乃至全球粮食安全做出了卓越贡献。', 'Nóngyè kēxuéjiā chénggōng péiyù chū kànghàn nài yánjiǎn de gāochǎn zájiāo shuǐdào xīn pǐnzhǒng, wèi bǎozhàng guójiā nǎizhì quánqiú liángshí ānquán zuòchū le zhuóyuè gòngxiàn.', 'Các nhà khoa học nông nghiệp đã nhân giống thành công giống lúa lai mới năng suất cao chịu hạn và chịu mặn phèn, đóng góp vượt bậc vào việc bảo đảm an ninh lương thực quốc gia cũng như toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2836] [聘请] (pìnqǐng) - mời, tuyển dụng (chuyên gia, cố vấn, giáo sư) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '聘请' AND pinyin = 'pìnqǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '聘请' AND pinyin = 'pìnqǐng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '聘请'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '聘请'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pìnqǐng',
      meaning_vi = 'mời, tuyển dụng (chuyên gia, cố vấn, giáo sư)',
      example_hanzi = '学校聘请了两位经验丰富的外籍教师担任口语训练导师。',
      example_pinyin = 'Xuéxiào pìnqǐng le liǎng wèi jīngyàn fēngfù de wàijí jiàoshī dānrèn kǒuyǔ xùnliàn dǎoshī.',
      example_vi = 'Nhà trường đã mời hai giáo viên nước ngoài giàu kinh nghiệm về đảm nhiệm vai trò hướng dẫn luyện tập khẩu ngữ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '聘请',
      'pìnqǐng',
      'mời, tuyển dụng (chuyên gia, cố vấn, giáo sư)',
      'Động từ',
      'HSK 5',
      '学校聘请了两位经验丰富的外籍教师担任口语训练导师。',
      'Xuéxiào pìnqǐng le liǎng wèi jīngyàn fēngfù de wàijí jiàoshī dānrèn kǒuyǔ xùnliàn dǎoshī.',
      'Nhà trường đã mời hai giáo viên nước ngoài giàu kinh nghiệm về đảm nhiệm vai trò hướng dẫn luyện tập khẩu ngữ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校聘请了两位经验丰富的外籍教师担任口语训练导师。', 'Xuéxiào pìnqǐng le liǎng wèi jīngyàn fēngfù de wàijí jiàoshī dānrèn kǒuyǔ xùnliàn dǎoshī.', 'Nhà trường đã mời hai giáo viên nước ngoài giàu kinh nghiệm về đảm nhiệm vai trò hướng dẫn luyện tập khẩu ngữ.', 'basic', 1),
      (v_id, '集团为了全面提升海外投资合规风险防控能力，特意聘请国际权威律师事务所担任常年法律顾问。', 'Jítuán wèile quánmiàn tíshēng hǎiwài tóuzī héguī fēngxiǎn fángkòng nénglì, tèyì pìnqǐng guójì quánwēi lǜshī shìwùsuǒ dānrèn chángnián fǎlǜ gùwèn.', 'Nhằm nâng cao toàn diện năng lực phòng ngừa và kiểm soát rủi ro tuân thủ đầu tư hải ngoại, tập đoàn đã đặc biệt mời văn phòng luật sư uy tín quốc tế đảm nhiệm cố vấn pháp lý thường niên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2837] [平] (píng) - bằng phẳng, ngang bằng, yên ổn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '平' AND pinyin = 'píng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平' AND pinyin = 'píng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '平'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'píng',
      meaning_vi = 'bằng phẳng, ngang bằng, yên ổn',
      example_hanzi = '这条新修的水泥马路又宽又平，车辆行驶非常平稳。',
      example_pinyin = 'Zhè tiáo xīn xiū de shuǐní mǎlù yòu kuān yòu píng, chēliàng xíngshǐ fēicháng píngwěn.',
      example_vi = 'Con đường bê tông mới làm này vừa rộng vừa bằng phẳng, xe cộ lưu thông vô cùng êm ái.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '平',
      'píng',
      'bằng phẳng, ngang bằng, yên ổn',
      'Tính từ',
      'HSK 5',
      '这条新修的水泥马路又宽又平，车辆行驶非常平稳。',
      'Zhè tiáo xīn xiū de shuǐní mǎlù yòu kuān yòu píng, chēliàng xíngshǐ fēicháng píngwěn.',
      'Con đường bê tông mới làm này vừa rộng vừa bằng phẳng, xe cộ lưu thông vô cùng êm ái.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这条新修的水泥马路又宽又平，车辆行驶非常平稳。', 'Zhè tiáo xīn xiū de shuǐní mǎlù yòu kuān yòu píng, chēliàng xíngshǐ fēicháng píngwěn.', 'Con đường bê tông mới làm này vừa rộng vừa bằng phẳng, xe cộ lưu thông vô cùng êm ái.', 'basic', 1),
      (v_id, '在经历了九十分钟激烈的加时赛后，两支冠军候选球队最终以平局收场，进入点球大战。', 'Zài jīnglì le jiǔshí fēnzhōng jīliè de jiāshísài hòu, liǎng zhī guànjūn hòuxuǎn qiúduì zuìzhōng yǐ píngjú shōuchǎng, jìnrù diǎnqiú dàzhàn.', 'Sau chín mươi phút thi đấu hiệp phụ căng thẳng, hai đội bóng ứng viên vô địch cuối cùng khép lại trận đấu với tỷ số hòa và bước vào loạt sút luân lưu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2838] [评] (píng) - bình luận, đánh giá, bình xét [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '评' AND pinyin = 'píng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '评' AND pinyin = 'píng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '评'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '评'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'píng',
      meaning_vi = 'bình luận, đánh giá, bình xét',
      example_hanzi = '下课后，几位同学聚在一起评起了昨晚那场精彩的足球决赛。',
      example_pinyin = 'Xiàkè hòu, jǐ wèi tóngxué jù zài yìqǐ píng qǐ le zuówǎn nà chǎng jīngcǎi de zúqiú juésài.',
      example_vi = 'Sau giờ tan học, mấy người bạn học tụ lại cùng nhau bình luận về trận chung kết bóng đá sôi nổi tối qua.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '评',
      'píng',
      'bình luận, đánh giá, bình xét',
      'Động từ',
      'HSK 5',
      '下课后，几位同学聚在一起评起了昨晚那场精彩的足球决赛。',
      'Xiàkè hòu, jǐ wèi tóngxué jù zài yìqǐ píng qǐ le zuówǎn nà chǎng jīngcǎi de zúqiú juésài.',
      'Sau giờ tan học, mấy người bạn học tụ lại cùng nhau bình luận về trận chung kết bóng đá sôi nổi tối qua.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '下课后，几位同学聚在一起评起了昨晚那场精彩的足球决赛。', 'Xiàkè hòu, jǐ wèi tóngxué jù zài yìqǐ píng qǐ le zuówǎn nà chǎng jīngcǎi de zúqiú juésài.', 'Sau giờ tan học, mấy người bạn học tụ lại cùng nhau bình luận về trận chung kết bóng đá sôi nổi tối qua.', 'basic', 1),
      (v_id, '评审委员会秉持客观公正原则，综合考量学术创新度与应用价值，依法评选年度杰出青年科学家奖项。', 'Píngshěn wěiyuánhuì bǐngchí kèguān gōngzhèng yuánzé, zōnghé kǎoliàng xuéshù chuàngxīndù yǔ yìngyòng jiàzhí, yīfǎ píngxguǎn niándù jiéchū qīngnián kēxuéjiā jiǎngxiàng.', 'Hội đồng thẩm định giữ vững nguyên tắc khách quan công bằng, xem xét tổng hợp tính đổi mới học thuật và giá trị ứng dụng để bình chọn giải thưởng nhà khoa học trẻ kiệt xuất của năm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2839] [凭] (píng) - dựa vào, căn cứ vào; bằng cớ [Giới từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '凭' AND pinyin = 'píng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '凭' AND pinyin = 'píng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '凭'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '凭'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Giới từ / Động từ',
      pinyin = 'píng',
      meaning_vi = 'dựa vào, căn cứ vào; bằng cớ',
      example_hanzi = '参赛选手需要凭有效身份证件进入考场参加考试。',
      example_pinyin = 'Cānsài xuǎnshǒu xūyào píng yǒuxiào shēnfèn zhèngjiàn jìnrù kǎochǎng cānjiā kǎoshì.',
      example_vi = 'Thí sinh tham dự cần dựa vào giấy tờ tùy thân hợp lệ để vào phòng thi làm bài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '凭',
      'píng',
      'dựa vào, căn cứ vào; bằng cớ',
      'Giới từ / Động từ',
      'HSK 5',
      '参赛选手需要凭有效身份证件进入考场参加考试。',
      'Cānsài xuǎnshǒu xūyào píng yǒuxiào shēnfèn zhèngjiàn jìnrù kǎochǎng cānjiā kǎoshì.',
      'Thí sinh tham dự cần dựa vào giấy tờ tùy thân hợp lệ để vào phòng thi làm bài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '参赛选手需要凭有效身份证件进入考场参加考试。', 'Cānsài xuǎnshǒu xūyào píng yǒuxiào shēnfèn zhèngjiàn jìnrù kǎochǎng cānjiā kǎoshì.', 'Thí sinh tham dự cần dựa vào giấy tờ tùy thân hợp lệ để vào phòng thi làm bài.', 'basic', 1),
      (v_id, '仅凭主观臆断与零星传言处理复杂的组织人际纷争，往往极易导致管理决策偏差与团队信任瓦解。', 'Jǐn píng zhǔguān yìduàn yǔ língxīng chuányán chǔlǐ fùzá de zǔzhī rénjì fēnzhēng, wǎngwǎng jíyì dǎozhì guǎnlǐ juécè piānchā yǔ tuánduì xìnlài wǎjiě.', 'Chỉ dựa vào võ đoán chủ quan và những lời đồn thổi vụn vặt để xử lý tranh chấp nhân sự phức tạp trong tổ chức thường rất dễ dẫn đến sai lệch trong quyết sách quản trị và làm tan rã niềm tin của đội ngũ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2840] [平安] (píng’ān) - bình an, an lành, yên ổn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '平安' AND pinyin = 'píng’ān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平安' AND pinyin = 'píng’ān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '平安'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平安'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'píng’ān',
      meaning_vi = 'bình an, an lành, yên ổn',
      example_hanzi = '出门在外的游子给家里打电话，第一句话总是报平安。',
      example_pinyin = 'Chūmén zàiwài de yóuzǐ gěi jiālǐ dǎ diànhuà, dì-yī jù huà zǒngshì bào píng’ān.',
      example_vi = 'Người con xa quê gọi điện thoại về nhà câu đầu tiên bao giờ cũng là báo bình an.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '平安',
      'píng’ān',
      'bình an, an lành, yên ổn',
      'Tính từ',
      'HSK 5',
      '出门在外的游子给家里打电话，第一句话总是报平安。',
      'Chūmén zàiwài de yóuzǐ gěi jiālǐ dǎ diànhuà, dì-yī jù huà zǒngshì bào píng’ān.',
      'Người con xa quê gọi điện thoại về nhà câu đầu tiên bao giờ cũng là báo bình an.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门在外的游子给家里打电话，第一句话总是报平安。', 'Chūmén zàiwài de yóuzǐ gěi jiālǐ dǎ diànhuà, dì-yī jù huà zǒngshì bào píng’ān.', 'Người con xa quê gọi điện thoại về nhà câu đầu tiên bao giờ cũng là báo bình an.', 'basic', 1),
      (v_id, '重大基础设施工程建设必须牢固树立安全红线意识，切实确保施工人员生命安全与工程平安顺利推进。', 'Zhòngdà jīchǔ shèshī gōngchéng jiànshè bìxū láogù shùlì ānquán hóngxiàn yìshí, qièshí quèbǎo shīgōng rényuán shēngmìng ānquán yǔ gōngchéng píng’ān shùnlì tuījìn.', 'Xây dựng công trình cơ sở hạ tầng trọng điểm phải thiết lập vững chắc ý thức ranh giới đỏ an toàn, bảo đảm thiết thực sinh mạng công nhân thi công và giúp công trình tiến triển bình an thuận lợi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2841] [平衡] (pínghéng) - cân bằng, thế cân bằng [Động từ / Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '平衡' AND pinyin = 'pínghéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平衡' AND pinyin = 'pínghéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '平衡'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平衡'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ / Tính từ',
      pinyin = 'pínghéng',
      meaning_vi = 'cân bằng, thế cân bằng',
      example_hanzi = '在紧张忙碌的工作之余，我们要学会平衡工作与个人生活。',
      example_pinyin = 'Zài jǐnzhāng mánglù de gōngzuò zhīyú, wǒmen yào xuéhuì pínghéng gōngzuò yǔ gèrén shēnghuó.',
      example_vi = 'Ngoài những lúc làm việc bận rộn căng thẳng, chúng ta cần học cách cân bằng giữa công việc và đời sống cá nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '平衡',
      'pínghéng',
      'cân bằng, thế cân bằng',
      'Động từ / Danh từ / Tính từ',
      'HSK 5',
      '在紧张忙碌的工作之余，我们要学会平衡工作与个人生活。',
      'Zài jǐnzhāng mánglù de gōngzuò zhīyú, wǒmen yào xuéhuì pínghéng gōngzuò yǔ gèrén shēnghuó.',
      'Ngoài những lúc làm việc bận rộn căng thẳng, chúng ta cần học cách cân bằng giữa công việc và đời sống cá nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在紧张忙碌的工作之余，我们要学会平衡工作与个人生活。', 'Zài jǐnzhāng mánglù de gōngzuò zhīyú, wǒmen yào xuéhuì pínghéng gōngzuò yǔ gèrén shēnghuó.', 'Ngoài những lúc làm việc bận rộn căng thẳng, chúng ta cần học cách cân bằng giữa công việc và đời sống cá nhân.', 'basic', 1),
      (v_id, '宏观调控政策应当在稳定经济增长速度与防范系统性金融风险之间寻求动态平衡。', 'Hóngguān tiáokòng zhèngcè yīngdāng zài wěndìng jīngjì zēngzhǎng sùdù yǔ fángfàn xìtǒngxìng jīnróng fēngxiǎn zhījiān xúnqiú dòngtài pínghéng.', 'Chính sách điều tiết vĩ mô cần phải tìm kiếm sự cân bằng động giữa duy trì tốc độ tăng trưởng kinh tế ổn định và phòng ngừa rủi ro tài chính mang tính hệ thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2842] [评价] (píngjià) - đánh giá, nhận xét; lời đánh giá [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '评价' AND pinyin = 'píngjià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '评价' AND pinyin = 'píngjià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '评价'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '评价'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'píngjià',
      meaning_vi = 'đánh giá, nhận xét; lời đánh giá',
      example_hanzi = '许多读者给这本新出版的历史小说写下了非常积极的正面评价。',
      example_pinyin = 'Xǔduō dúzhě gěi zhè běn xīn chūbǎn de lìshǐ xiǎoshuō xiě xià le fēicháng jījí de zhèngmiàn píngjià.',
      example_vi = 'Rất nhiều độc giả đã viết những đánh giá tích cực rất tốt về cuốn tiểu thuyết lịch sử mới xuất bản này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '评价',
      'píngjià',
      'đánh giá, nhận xét; lời đánh giá',
      'Động từ / Danh từ',
      'HSK 5',
      '许多读者给这本新出版的历史小说写下了非常积极的正面评价。',
      'Xǔduō dúzhě gěi zhè běn xīn chūbǎn de lìshǐ xiǎoshuō xiě xià le fēicháng jījí de zhèngmiàn píngjià.',
      'Rất nhiều độc giả đã viết những đánh giá tích cực rất tốt về cuốn tiểu thuyết lịch sử mới xuất bản này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '许多读者给这本新出版的历史小说写下了非常积极的正面评价。', 'Xǔduō dúzhě gěi zhè běn xīn chūbǎn de lìshǐ xiǎoshuō xiě xià le fēicháng jījí de zhèngmiàn píngjià.', 'Rất nhiều độc giả đã viết những đánh giá tích cực rất tốt về cuốn tiểu thuyết lịch sử mới xuất bản này.', 'basic', 1),
      (v_id, '现代企业人力资源体系运用多维度KPI与360度反馈机制，对中高层干部的履职能力做出全面科学的客观评价。', 'Xiàndài qǐyè rénlì zīyuán tǐxì yùnyòng duō-wéidù KPI yǔ 360 dù fǎnkuì jīzhì, duì zhōng-gāocéng gànbù de lǚzhí nénglì zuòchū quánmiàn kēxué de kèguān píngjià.', 'Hệ thống nhân sự doanh nghiệp hiện đại vận dụng chỉ số KPI đa chiều và cơ chế phản hồi 360 độ để đưa ra đánh giá khách quan, toàn diện và khoa học về năng lực thực thi nhiệm vụ của cán bộ trung cao cấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2843] [凭借] (píngjiè) - nhờ vào, dựa vào (tài năng, nỗ lực, uy tín) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '凭借' AND pinyin = 'píngjiè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '凭借' AND pinyin = 'píngjiè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '凭借'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '凭借'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'píngjiè',
      meaning_vi = 'nhờ vào, dựa vào (tài năng, nỗ lực, uy tín)',
      example_hanzi = '他凭借坚持不懈的努力，终于在比赛中获得了第一名。',
      example_pinyin = 'Tā píngjiè jiānchí-bùxiè de nǔlì, zhōngyú zài bǐsài zhōng huòdé le dì-yī míng.',
      example_vi = 'Anh ấy nhờ vào nỗ lực kiên trì bền bỉ, cuối cùng đã giành được giải nhất trong cuộc thi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '凭借',
      'píngjiè',
      'nhờ vào, dựa vào (tài năng, nỗ lực, uy tín)',
      'Động từ',
      'HSK 5',
      '他凭借坚持不懈的努力，终于在比赛中获得了第一名。',
      'Tā píngjiè jiānchí-bùxiè de nǔlì, zhōngyú zài bǐsài zhōng huòdé le dì-yī míng.',
      'Anh ấy nhờ vào nỗ lực kiên trì bền bỉ, cuối cùng đã giành được giải nhất trong cuộc thi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他凭借坚持不懈的努力，终于在比赛中获得了第一名。', 'Tā píngjiè jiānchí-bùxiè de nǔlì, zhōngyú zài bǐsài zhōng huòdé le dì-yī míng.', 'Anh ấy nhờ vào nỗ lực kiên trì bền bỉ, cuối cùng đã giành được giải nhất trong cuộc thi.', 'basic', 1),
      (v_id, '高新技术企业凭借自主研发的底层芯片架构和多项国际专利，在激烈的全球半导体市场竞争中赢得了核心主导权。', 'Gāoxīn jìshù qǐyè píngjiè zìzhǔ yánfā de dǐcéng xīanpiàn jiàgòu hé duō xiàng guójì zhuānlì, zài jīliè de quánqiú bàndǎotǐ shìchǎng jìngzhēng zhōng yíngdé le héxīn zhǔdǎoquán.', 'Doanh nghiệp công nghệ cao dựa vào kiến trúc chip nền tảng tự nghiên cứu và nhiều bằng sáng chế quốc tế, đã giành được quyền chi phối cốt lõi trong cạnh tranh thị trường bán dẫn toàn cầu khốc liệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2844] [平静] (píngjìng) - bình tĩnh, phẳng lặng, yên tĩnh [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '平静' AND pinyin = 'píngjìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平静' AND pinyin = 'píngjìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '平静'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平静'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'píngjìng',
      meaning_vi = 'bình tĩnh, phẳng lặng, yên tĩnh',
      example_hanzi = '微风拂过，清澈平静的湖面上泛起了一圈圈细小的波纹。',
      example_pinyin = 'Wēifēng fúguò, qīngchè píngjìng de húmiàn shang fàn qǐ le yì quānquān xìxiǎo de bōwén.',
      example_vi = 'Gió nhẹ thổi qua, trên mặt hồ trong veo phẳng lặng gợn lên từng vòng sóng nước lăn tăn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '平静',
      'píngjìng',
      'bình tĩnh, phẳng lặng, yên tĩnh',
      'Tính từ',
      'HSK 5',
      '微风拂过，清澈平静的湖面上泛起了一圈圈细小的波纹。',
      'Wēifēng fúguò, qīngchè píngjìng de húmiàn shang fàn qǐ le yì quānquān xìxiǎo de bōwén.',
      'Gió nhẹ thổi qua, trên mặt hồ trong veo phẳng lặng gợn lên từng vòng sóng nước lăn tăn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '微风拂过，清澈平静的湖面上泛起了一圈圈细小的波纹。', 'Wēifēng fúguò, qīngchè píngjìng de húmiàn shang fàn qǐ le yì quānquān xìxiǎo de bōwén.', 'Gió nhẹ thổi qua, trên mặt hồ trong veo phẳng lặng gợn lên từng vòng sóng nước lăn tăn.', 'basic', 1),
      (v_id, '面对突如其来的公关舆论风暴，企业新闻发言人以沉着平静的姿态从容回应各方关切，迅速稳定了公众信心。', 'Miànduì tūrúqílái de gōngguān yúlùn fēngbào, qǐyè xīnwén fāyánrén yǐ chénzhuó píngjìng de zītài cóngróng huìyìng gèfāng guānqiè, xùnsù wěndìng le gōngzhòng xìnxīn.', 'Đối mặt với cơn bão dư luận truyền thông bất ngờ ập đến, người phát ngôn tin tức của doanh nghiệp dùng phong thái bình tĩnh điềm đạm thong thả giải đáp quan ngại các bên, nhanh chóng ổn định lòng tin của công chúng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2845] [平均] (píngjūn) - bình quân, trung bình [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '平均' AND pinyin = 'píngjūn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平均' AND pinyin = 'píngjūn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '平均'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平均'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'píngjūn',
      meaning_vi = 'bình quân, trung bình',
      example_hanzi = '全班三十名同学的数学考试平均成绩达到了八十五分。',
      example_pinyin = 'Quán bān sānshí míng tóngxué de shùxué kǎoshì píngjūn chéngjì dádào le bāshíwǔ fēn.',
      example_vi = 'Điểm thi môn toán trung bình của ba mươi học sinh cả lớp đạt tám mươi lăm điểm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '平均',
      'píngjūn',
      'bình quân, trung bình',
      'Tính từ / Động từ',
      'HSK 5',
      '全班三十名同学的数学考试平均成绩达到了八十五分。',
      'Quán bān sānshí míng tóngxué de shùxué kǎoshì píngjūn chéngjì dádào le bāshíwǔ fēn.',
      'Điểm thi môn toán trung bình của ba mươi học sinh cả lớp đạt tám mươi lăm điểm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '全班三十名同学的数学考试平均成绩达到了八十五分。', 'Quán bān sānshí míng tóngxué de shùxué kǎoshì píngjūn chéngjì dádào le bāshíwǔ fēn.', 'Điểm thi môn toán trung bình của ba mươi học sinh cả lớp đạt tám mươi lăm điểm.', 'basic', 1),
      (v_id, '根据国家统计局公报，近年来全国居民人均可支配收入实现稳步增长，中等收入群体规模持续扩大。', 'Gēnjù guójiā tǒngjìjú gōngbào, jìnniánlái quánguó jūmín rénjūn kězhīpèi shōurù shíxiàn wěnbù zēngzhǎng, zhōngděng shōurù qúntǐ guīmó chíxù kuòdà.', 'Theo thông cáo của Tổng cục Thống kê quốc gia, những năm gần đây thu nhập khả dụng bình quân đầu người của cư dân toàn quốc tăng trưởng vững chắc, quy mô nhóm người thu nhập trung bình liên tục mở rộng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2846] [屏幕] (píngmù) - màn hình (máy tính, điện thoại, tivi) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '屏幕' AND pinyin = 'píngmù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '屏幕' AND pinyin = 'píngmù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '屏幕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '屏幕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'píngmù',
      meaning_vi = 'màn hình (máy tính, điện thoại, tivi)',
      example_hanzi = '长时间盯着手机屏幕容易引起眼睛疲劳和干涩。',
      example_pinyin = 'Cháng shíjiān dīng zhe shǒujī píngmù róngyì yǐnqǐ yǎnjing píláo hé gānsè.',
      example_vi = 'Nhìn chằm chằm vào màn hình điện thoại trong thời gian dài rất dễ gây mỏi và khô mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '屏幕',
      'píngmù',
      'màn hình (máy tính, điện thoại, tivi)',
      'Danh từ',
      'HSK 5',
      '长时间盯着手机屏幕容易引起眼睛疲劳和干涩。',
      'Cháng shíjiān dīng zhe shǒujī píngmù róngyì yǐnqǐ yǎnjing píláo hé gānsè.',
      'Nhìn chằm chằm vào màn hình điện thoại trong thời gian dài rất dễ gây mỏi và khô mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长时间盯着手机屏幕容易引起眼睛疲劳和干涩。', 'Cháng shíjiān dīng zhe shǒujī píngmù róngyì yǐnqǐ yǎnjing píláo hé gānsè.', 'Nhìn chằm chằm vào màn hình điện thoại trong thời gian dài rất dễ gây mỏi và khô mắt.', 'basic', 1),
      (v_id, '智能终端显示技术从传统液晶面板逐步向柔性OLED可折叠屏幕迭代，引领了全球消费电子形态的新一轮变革。', 'Zhìnéng zhōngduān xiǎnshì jìshù cóng chuántǒng yèjīng miànbǎn zhúbù xiàng róuxìng OLED kězhédié píngmù diédài, yǐnlǐng le quánqiú xiāofèi diànzǐ xíngtài de xīn yì lún biàngé.', 'Công nghệ màn hình thiết bị đầu cuối thông minh từng bước nâng cấp từ tấm nền tinh thể lỏng truyền thống sang màn hình gập OLED dẻo, dẫn dắt một làn sóng cải cách mới về hình thái điện tử tiêu dùng toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2847] [平台] (píngtái) - nền tảng, sân ga, bục giảng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '平台' AND pinyin = 'píngtái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平台' AND pinyin = 'píngtái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '平台'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '平台'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'píngtái',
      meaning_vi = 'nền tảng, sân ga, bục giảng',
      example_hanzi = '该在线学习平台为广大学生提供了海量优质的免费课程资源。',
      example_pinyin = 'Gāi zàixiàn xuéxí píngtái wèi guǎngdà xuéshēng tígōng le hǎiliàng yōuzhì de miǎnfèi kèchéng zīyuán.',
      example_vi = 'Nền tảng học tập trực tuyến này đã cung cấp lượng lớn tài nguyên khóa học miễn phí chất lượng cao cho đông đảo học sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '平台',
      'píngtái',
      'nền tảng, sân ga, bục giảng',
      'Danh từ',
      'HSK 5',
      '该在线学习平台为广大学生提供了海量优质的免费课程资源。',
      'Gāi zàixiàn xuéxí píngtái wèi guǎngdà xuéshēng tígōng le hǎiliàng yōuzhì de miǎnfèi kèchéng zīyuán.',
      'Nền tảng học tập trực tuyến này đã cung cấp lượng lớn tài nguyên khóa học miễn phí chất lượng cao cho đông đảo học sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '该在线学习平台为广大学生提供了海量优质的免费课程资源。', 'Gāi zàixiàn xuéxí píngtái wèi guǎngdà xuéshēng tígōng le hǎiliàng yōuzhì de miǎnfèi kèchéng zīyuán.', 'Nền tảng học tập trực tuyến này đã cung cấp lượng lớn tài nguyên khóa học miễn phí chất lượng cao cho đông đảo học sinh.', 'basic', 1),
      (v_id, '跨境数字贸易综合服务平台的搭建，有效打通了通关、外汇结算、跨境物流等全链条数字化监管与协同流程。', 'Kuàjìng shùzì màoyì zōnghé fúwù píngtái de dājiàn, yǒuxiào dǎtōng le tōngguān, wàihuì jiésuàn, kuàjìng wùliú děng quánliàntiáo shùzìhuà jiānguǎn yǔ xiétóng liúchéng.', 'Việc xây dựng nền tảng dịch vụ tổng hợp thương mại số xuyên biên giới đã khơi thông hiệu quả toàn bộ chuỗi quy trình giám sát số hóa và hiệp đồng bao gồm thông quan, quyết toán ngoại hối và logistics quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2848] [破坏] (pòhuài) - phá hoại, làm hư hại, hủy hoại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '破坏' AND pinyin = 'pòhuài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '破坏' AND pinyin = 'pòhuài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '破坏'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '破坏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'pòhuài',
      meaning_vi = 'phá hoại, làm hư hại, hủy hoại',
      example_hanzi = '乱砍滥伐树木会严重破坏森林植被和当地的生态平衡。',
      example_pinyin = 'Luànkǎn-lànfá shùmù huì yánzhòng pòhuài sēnlín zhíbèi hé dāngdì de shēngtài pínghéng.',
      example_vi = 'Việc chặt phá cây rừng bừa bãi sẽ phá hoại nghiêm trọng thảm thực vật rừng và sự cân bằng sinh thái địa phương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '破坏',
      'pòhuài',
      'phá hoại, làm hư hại, hủy hoại',
      'Động từ',
      'HSK 5',
      '乱砍滥伐树木会严重破坏森林植被和当地的生态平衡。',
      'Luànkǎn-lànfá shùmù huì yánzhòng pòhuài sēnlín zhíbèi hé dāngdì de shēngtài pínghéng.',
      'Việc chặt phá cây rừng bừa bãi sẽ phá hoại nghiêm trọng thảm thực vật rừng và sự cân bằng sinh thái địa phương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '乱砍滥伐树木会严重破坏森林植被和当地的生态平衡。', 'Luànkǎn-lànfá shùmù huì yánzhòng pòhuài sēnlín zhíbèi hé dāngdì de shēngtài pínghéng.', 'Việc chặt phá cây rừng bừa bãi sẽ phá hoại nghiêm trọng thảm thực vật rừng và sự cân bằng sinh thái địa phương.', 'basic', 1),
      (v_id, '严禁任何单位或个人私自破坏水利防汛基础设施，确保防汛抗旱应急安全体系万无一失。', 'Yánjìn rènhé dānwèi huò gèrén sīzì pòhuài shuǐlì fángxùn jīchǔ shèshī, quèbǎo fángxùn kànghàn yìngjí ānquán tǐxì wànwú-yìshī.', 'Nghiêm cấm bất kỳ đơn vị hoặc cá nhân nào tự ý phá hoại cơ sở hạ tầng thủy lợi phòng chống lụt bão, bảo đảm hệ thống an toàn khẩn cấp phòng chống bão hạn an toàn tuyệt đối không chút sơ suất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2849] [普及] (pǔjí) - phổ cập, phổ biến rộng rãi [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '普及' AND pinyin = 'pǔjí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '普及' AND pinyin = 'pǔjí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '普及'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '普及'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'pǔjí',
      meaning_vi = 'phổ cập, phổ biến rộng rãi',
      example_hanzi = '随着移动互联网的发展，手机移动支付在全国各大城市得到了迅速普及。',
      example_pinyin = 'Suízhe yídòng hùliánwǎng de fāzhǎn, shǒujī yídòng zhīfù zài quánguó gè dà chéngshì dédào le xùnsù pǔjí.',
      example_vi = 'Cùng với sự phát triển của Internet di động, thanh toán trên điện thoại di động đã được phổ biến nhanh chóng tại khắp các thành phố lớn trên toàn quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '普及',
      'pǔjí',
      'phổ cập, phổ biến rộng rãi',
      'Động từ / Tính từ',
      'HSK 5',
      '随着移动互联网的发展，手机移动支付在全国各大城市得到了迅速普及。',
      'Suízhe yídòng hùliánwǎng de fāzhǎn, shǒujī yídòng zhīfù zài quánguó gè dà chéngshì dédào le xùnsù pǔjí.',
      'Cùng với sự phát triển của Internet di động, thanh toán trên điện thoại di động đã được phổ biến nhanh chóng tại khắp các thành phố lớn trên toàn quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着移动互联网的发展，手机移动支付在全国各大城市得到了迅速普及。', 'Suízhe yídòng hùliánwǎng de fāzhǎn, shǒujī yídòng zhīfù zài quánguó gè dà chéngshì dédào le xùnsù pǔjí.', 'Cùng với sự phát triển của Internet di động, thanh toán trên điện thoại di động đã được phổ biến nhanh chóng tại khắp các thành phố lớn trên toàn quốc.', 'basic', 1),
      (v_id, '大力开展全民科学素质普及与青少年通识科普教育，是建设创新型国家不可或缺的基石工程。', 'Dàlì kāizhǎn quánmín kēxué sùzhì pǔjí yǔ qīng-shàonián tōngshí kēpǔ jiàoyù, shì jiànshè chuàngxīnxíng guójiā bùkě huòquē de jīshí gōngchéng.', 'Tích cực triển khai phổ cập tố chất khoa học toàn dân và giáo dục phổ biến tri thức khoa học đại chúng cho thanh thiếu niên là công trình nền móng không thể thiếu để xây dựng quốc gia sáng tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2850] [期待] (qīdài) - mong đợi, kỳ vọng, trông chờ [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '期待' AND pinyin = 'qīdài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '期待' AND pinyin = 'qīdài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '期待'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '期待'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'qīdài',
      meaning_vi = 'mong đợi, kỳ vọng, trông chờ',
      example_hanzi = '所有参赛选手都满怀期待地等待着评委公布最终的比赛结果。',
      example_pinyin = 'Suǒyǒu cānsài xuǎnshǒu dōu mǎnhuái qīdài de děngdài zhe píngwěi gōngbù zuìzhōng de bǐsài jiéguǒ.',
      example_vi = 'Tất cả các thí sinh dự thi đều mang đầy hy vọng mong đợi ban giám khảo công bố kết quả chung cuộc của cuộc thi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '期待',
      'qīdài',
      'mong đợi, kỳ vọng, trông chờ',
      'Động từ / Danh từ',
      'HSK 5',
      '所有参赛选手都满怀期待地等待着评委公布最终的比赛结果。',
      'Suǒyǒu cānsài xuǎnshǒu dōu mǎnhuái qīdài de děngdài zhe píngwěi gōngbù zuìzhōng de bǐsài jiéguǒ.',
      'Tất cả các thí sinh dự thi đều mang đầy hy vọng mong đợi ban giám khảo công bố kết quả chung cuộc của cuộc thi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '所有参赛选手都满怀期待地等待着评委公布最终的比赛结果。', 'Suǒyǒu cānsài xuǎnshǒu dōu mǎnhuái qīdài de děngdài zhe píngwěi gōngbù zuìzhōng de bǐsài jiéguǒ.', 'Tất cả các thí sinh dự thi đều mang đầy hy vọng mong đợi ban giám khảo công bố kết quả chung cuộc của cuộc thi.', 'basic', 1),
      (v_id, '国际社会高度期待本次全球气候治理峰会能够凝聚广泛共识，达成更具约束力与执行力的减排协议。', 'Guójì shèhuì gāodù qīdài běn cì quánqiú qìhòu zhìlǐ fēnghuì nénggòu níngjù guǎngfàn gòngshí, dáchéng gèng jù yuēshùlì yǔ zhíxínglì de jiǎnpái xiéyì.', 'Cộng đồng quốc tế hết sức kỳ vọng hội nghị thượng đỉnh quản trị khí hậu toàn cầu lần này có thể ngưng tụ sự đồng thuận rộng rãi, đạt được hiệp định giảm phát thải mang tính ràng buộc và khả thi cao hơn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2851] [期间] (qījiān) - khoảng thời gian, thời kỳ, trong thời gian [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '期间' AND pinyin = 'qījiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '期间' AND pinyin = 'qījiān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '期间'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '期间'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qījiān',
      meaning_vi = 'khoảng thời gian, thời kỳ, trong thời gian',
      example_hanzi = '大学期间，他不仅成绩优秀，还积极参加了许多志愿服务活动。',
      example_pinyin = 'Dàxué qījiān, tā bùjǐn chéngjì yōuxiù, hái jījí cānjiā le xǔduō zhìyuàn fúwù huódòng.',
      example_vi = 'Trong thời gian học đại học, anh ấy không những có thành tích xuất sắc mà còn tích cực tham gia nhiều hoạt động tình nguyện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '期间',
      'qījiān',
      'khoảng thời gian, thời kỳ, trong thời gian',
      'Danh từ',
      'HSK 5',
      '大学期间，他不仅成绩优秀，还积极参加了许多志愿服务活动。',
      'Dàxué qījiān, tā bùjǐn chéngjì yōuxiù, hái jījí cānjiā le xǔduō zhìyuàn fúwù huódòng.',
      'Trong thời gian học đại học, anh ấy không những có thành tích xuất sắc mà còn tích cực tham gia nhiều hoạt động tình nguyện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大学期间，他不仅成绩优秀，还积极参加了许多志愿服务活动。', 'Dàxué qījiān, tā bùjǐn chéngjì yōuxiù, hái jījí cānjiā le xǔduō zhìyuàn fúwù huódòng.', 'Trong thời gian học đại học, anh ấy không những có thành tích xuất sắc mà còn tích cực tham gia nhiều hoạt động tình nguyện.', 'basic', 1),
      (v_id, '在为期三天的国际经济论坛举行期间，各国代表围绕多边经贸合作与供应链韧性展开了多场深入研讨。', 'Zài wéiqī sān tiān de guójì jīngjì lùntán jǔxíng qījiān, gèguó dàibiǎo wéirào duōbiān jīngmào hézuò yǔ gōngyìngliàn rènxìng zhǎnkāi le duō chǎng shēnrù yántǎo.', 'Trong thời gian diễn ra diễn đàn kinh tế quốc tế kéo dài ba ngày, đại biểu các nước đã triển khai nhiều buổi hội thảo chuyên sâu xoay quanh hợp tác kinh tế thương mại đa phương và khả năng chống chịu của chuỗi cung ứng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2852] [齐] (qí) - ngay ngắn, đồng đều, đầy đủ tụ họp [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '齐' AND pinyin = 'qí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '齐' AND pinyin = 'qí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '齐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '齐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'qí',
      meaning_vi = 'ngay ngắn, đồng đều, đầy đủ tụ họp',
      example_hanzi = '大家到齐之后，班长便带领大家乘车出发前往植物园。',
      example_pinyin = 'Dàjiā dào qí zhīhòu, bānzhǎng biàn dàilǐng dàjiā chéngchē chūfā qiánwǎng zhíwùyuán.',
      example_vi = 'Sau khi mọi người đã tập hợp đông đủ, lớp trưởng liền dẫn cả đoàn lên xe khởi hành đi thảo cầm viên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '齐',
      'qí',
      'ngay ngắn, đồng đều, đầy đủ tụ họp',
      'Tính từ / Phó từ',
      'HSK 5',
      '大家到齐之后，班长便带领大家乘车出发前往植物园。',
      'Dàjiā dào qí zhīhòu, bānzhǎng biàn dàilǐng dàjiā chéngchē chūfā qiánwǎng zhíwùyuán.',
      'Sau khi mọi người đã tập hợp đông đủ, lớp trưởng liền dẫn cả đoàn lên xe khởi hành đi thảo cầm viên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大家到齐之后，班长便带领大家乘车出发前往植物园。', 'Dàjiā dào qí zhīhòu, bānzhǎng biàn dàilǐng dàjiā chéngchē chūfā qiánwǎng zhíwùyuán.', 'Sau khi mọi người đã tập hợp đông đủ, lớp trưởng liền dẫn cả đoàn lên xe khởi hành đi thảo cầm viên.', 'basic', 1),
      (v_id, '仪仗队迈着整齐划一的矫健步伐走过广场，展现出昂扬的军姿与严谨的纪律风貌。', 'Yízhàngduì mài zhe zhěngqí-huàyī de jiǎojiàn bùfá zǒu guò guǎngchǎng, zhǎnxiàn chū ángyáng de jūnzī yǔ yánjǐn de jìlǜ fēngmào.', 'Đội tiêu binh sải những bước đi mạnh mẽ ngay ngắn đều tăm tắp bước qua quảng trường, thể hiện tư thế quân đội hiên ngang và tác phong kỷ luật nghiêm ngặt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2853] [其] (qí) - của nó/họ/điều đó, trong số đó [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '其' AND pinyin = 'qí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '其' AND pinyin = 'qí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '其'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '其'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'qí',
      meaning_vi = 'của nó/họ/điều đó, trong số đó',
      example_hanzi = '这本百科全书图文并茂，其内容涵盖了天文、地理和历史等多门学科。',
      example_pinyin = 'Zhè běn bǎikē quánshū túwén-bìngmào, qí nèiróng hángài le tiānwén, dìlǐ hé lìshǐ děng duō mén xuékē.',
      example_vi = 'Cuốn bách khoa toàn thư này hình ảnh chữ viết phong phú, nội dung của nó bao quát nhiều môn học như thiên văn, địa lý và lịch sử.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '其',
      'qí',
      'của nó/họ/điều đó, trong số đó',
      'Đại từ',
      'HSK 5',
      '这本百科全书图文并茂，其内容涵盖了天文、地理和历史等多门学科。',
      'Zhè běn bǎikē quánshū túwén-bìngmào, qí nèiróng hángài le tiānwén, dìlǐ hé lìshǐ děng duō mén xuékē.',
      'Cuốn bách khoa toàn thư này hình ảnh chữ viết phong phú, nội dung của nó bao quát nhiều môn học như thiên văn, địa lý và lịch sử.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这本百科全书图文并茂，其内容涵盖了天文、地理和历史等多门学科。', 'Zhè běn bǎikē quánshū túwén-bìngmào, qí nèiróng hángài le tiānwén, dìlǐ hé lìshǐ děng duō mén xuékē.', 'Cuốn bách khoa toàn thư này hình ảnh chữ viết phong phú, nội dung của nó bao quát nhiều môn học như thiên văn, địa lý và lịch sử.', 'basic', 1),
      (v_id, '任何科学理论都必须置于实践中反复检验，方能证实其科学有效性与真理客观性。', 'Rènhé kēxué lǐlùn dōu bìxū zhìyú shíjiàn zhōng fǎnfù jiǎnyàn, fāng néng zhèngshí qí kēxué yǒuxiàoxìng yǔ zhēnlǐ kèguānxìng.', 'Bất kỳ lý luận khoa học nào cũng cần phải đặt vào trong thực tiễn để kiểm nghiệm lặp đi lặp lại thì mới có thể chứng minh tính hiệu lực khoa học và tính khách quan chân lý của nó.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2854] [奇迹] (qíjì) - kỳ tích, phép màu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '奇迹' AND pinyin = 'qíjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '奇迹' AND pinyin = 'qíjì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '奇迹'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '奇迹'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qíjì',
      meaning_vi = 'kỳ tích, phép màu',
      example_hanzi = '经过医护人员连续十几个小时的全力抢救，病人的病情终于奇迹般地好转了。',
      example_pinyin = 'Jīngguò yīhù rényuán liánxù shí jǐ ge xiǎoshí de quánlì qiǎngjiù, bìngrén de bìngqíng zhōngyú qíjì bān de hǎozhuǎn le.',
      example_vi = 'Sau hơn mười tiếng đồng hồ nỗ lực cấp cứu liên tục của đội ngũ y bác sĩ, bệnh tình của bệnh nhân cuối cùng đã chuyển biến tốt như một kỳ tích.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '奇迹',
      'qíjì',
      'kỳ tích, phép màu',
      'Danh từ',
      'HSK 5',
      '经过医护人员连续十几个小时的全力抢救，病人的病情终于奇迹般地好转了。',
      'Jīngguò yīhù rényuán liánxù shí jǐ ge xiǎoshí de quánlì qiǎngjiù, bìngrén de bìngqíng zhōngyú qíjì bān de hǎozhuǎn le.',
      'Sau hơn mười tiếng đồng hồ nỗ lực cấp cứu liên tục của đội ngũ y bác sĩ, bệnh tình của bệnh nhân cuối cùng đã chuyển biến tốt như một kỳ tích.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过医护人员连续十几个小时的全力抢救，病人的病情终于奇迹般地好转了。', 'Jīngguò yīhù rényuán liánxù shí jǐ ge xiǎoshí de quánlì qiǎngjiù, bìngrén de bìngqíng zhōngyú qíjì bān de hǎozhuǎn le.', 'Sau hơn mười tiếng đồng hồ nỗ lực cấp cứu liên tục của đội ngũ y bác sĩ, bệnh tình của bệnh nhân cuối cùng đã chuyển biến tốt như một kỳ tích.', 'basic', 1),
      (v_id, '在极端复杂的地质结构与恶劣气候条件下建成世界级跨海大桥，堪称人类现代土木工程史上的伟大奇迹。', 'Zài jíduān fùzá de dìzhì jiégòu yǔ èliè qìhòu tiáojiàn xià jiànchéng shìjièjí kuàhǎi dàqiáo, kānchēng rénlèi xiàndài tǔmù gōngchéng shǐ shang de wěidà qíjì.', 'Việc xây dựng thành công cây cầu vượt biển tầm cỡ thế giới dưới điều kiện địa chất cực kỳ phức tạp và thời tiết khắc nghiệt xứng đáng được coi là một kỳ tích vĩ đại trong lịch sử công trình xây dựng dân dụng hiện đại của nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2855] [其余] (qíyú) - phần còn lại, những cái khác, những người khác [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '其余' AND pinyin = 'qíyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '其余' AND pinyin = 'qíyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '其余'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '其余'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'qíyú',
      meaning_vi = 'phần còn lại, những cái khác, những người khác',
      example_hanzi = '除了两位请病假的同事之外，其余所有人员均已按时参加周会。',
      example_pinyin = 'Chúle liǎng wèi qǐng bìngjià de tóngshì zhīwài, qíyú suǒyǒu rényuán jūn yǐ ànshí cānjiā zhōuhuì.',
      example_vi = 'Ngoại trừ hai đồng nghiệp xin nghỉ ốm ra, tất cả những người còn lại đều đã tham gia cuộc họp tuần đúng giờ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '其余',
      'qíyú',
      'phần còn lại, những cái khác, những người khác',
      'Đại từ',
      'HSK 5',
      '除了两位请病假的同事之外，其余所有人员均已按时参加周会。',
      'Chúle liǎng wèi qǐng bìngjià de tóngshì zhīwài, qíyú suǒyǒu rényuán jūn yǐ ànshí cānjiā zhōuhuì.',
      'Ngoại trừ hai đồng nghiệp xin nghỉ ốm ra, tất cả những người còn lại đều đã tham gia cuộc họp tuần đúng giờ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '除了两位请病假的同事之外，其余所有人员均已按时参加周会。', 'Chúle liǎng wèi qǐng bìngjià de tóngshì zhīwài, qíyú suǒyǒu rényuán jūn yǐ ànshí cānjiā zhōuhuì.', 'Ngoại trừ hai đồng nghiệp xin nghỉ ốm ra, tất cả những người còn lại đều đã tham gia cuộc họp tuần đúng giờ.', 'basic', 1),
      (v_id, '项目组已圆满攻克核心算法与通信协议，其余外围界面的优化工作将在本月底前彻底收尾。', 'Xiàngmù zǔ yǐ yuánmǎn gōngkè héxīn suànfǎ yǔ tōngxìn xiéyì, qíyú wàiwéi jièmiàn de yōuhuà gōngzuò jiàng zài běnyuè dǐ qián chèdǐ shōuwěi.', 'Nhóm dự án đã khắc phục trọn vẹn thuật toán cốt lõi và giao thức truyền thông, công việc tối ưu hóa các giao diện ngoại vi còn lại sẽ hoàn tất triệt để trước cuối tháng này.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2856] [企业] (qǐyè) - doanh nghiệp, công ty, xí nghiệp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '企业' AND pinyin = 'qǐyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '企业' AND pinyin = 'qǐyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '企业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '企业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qǐyè',
      meaning_vi = 'doanh nghiệp, công ty, xí nghiệp',
      example_hanzi = '这家民营企业通过技术创新，在当地赢得了极好的口碑与信誉。',
      example_pinyin = 'Zhè jiā mínyíng qǐyè tōngguò jìshù chuàngxīn, zài dāngdì yíngdé le jí hǎo de kǒubēi yǔ xìnyù.',
      example_vi = 'Doanh nghiệp dân doanh này thông qua đổi mới công nghệ đã giành được tiếng vang và uy tín rất tốt tại địa phương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '企业',
      'qǐyè',
      'doanh nghiệp, công ty, xí nghiệp',
      'Danh từ',
      'HSK 5',
      '这家民营企业通过技术创新，在当地赢得了极好的口碑与信誉。',
      'Zhè jiā mínyíng qǐyè tōngguò jìshù chuàngxīn, zài dāngdì yíngdé le jí hǎo de kǒubēi yǔ xìnyù.',
      'Doanh nghiệp dân doanh này thông qua đổi mới công nghệ đã giành được tiếng vang và uy tín rất tốt tại địa phương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家民营企业通过技术创新，在当地赢得了极好的口碑与信誉。', 'Zhè jiā mínyíng qǐyè tōngguò jìshù chuàngxīn, zài dāngdì yíngdé le jí hǎo de kǒubēi yǔ xìnyù.', 'Doanh nghiệp dân doanh này thông qua đổi mới công nghệ đã giành được tiếng vang và uy tín rất tốt tại địa phương.', 'basic', 1),
      (v_id, '现代科技型企业必须深化机制改革，完善研发激励政策，持续增强自主创新核心竞争力。', 'Xiàndài kējìxíng qǐyè bìxū shēnhuà jīzhì gǎigé, wánshàn yánfā jīlì zhèngcè, chíxù zēngqiáng zìzhǔ chuàngxīn héxīn jìngzhēnglì.', 'Các doanh nghiệp kiểu công nghệ hiện đại bắt buộc phải đào sâu cải cách cơ chế, hoàn thiện chính sách đãi ngộ nghiên cứu phát triển nhằm không ngừng củng cố sức cạnh tranh cốt lõi về đổi mới tự chủ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2857] [气球] (qìqiú) - bóng bay, khí cầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '气球' AND pinyin = 'qìqiú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '气球' AND pinyin = 'qìqiú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '气球'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '气球'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qìqiú',
      meaning_vi = 'bóng bay, khí cầu',
      example_hanzi = '公园门口卖着五颜六色的卡通气球，吸引了许多小朋友驻足观看。',
      example_pinyin = 'Gōngyuán ménkǒu mài zhe wǔyán-liùsè de kǎtōng qìqiú, xīyǐn le xǔduō xiǎopéngyǒu zhùzú guānkàn.',
      example_vi = 'Cổng công viên bày bán những chùm bóng bay hoạt hình đủ màu sắc sặc sỡ, thu hút nhiều em nhỏ dừng chân ngắm nhìn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '气球',
      'qìqiú',
      'bóng bay, khí cầu',
      'Danh từ',
      'HSK 5',
      '公园门口卖着五颜六色的卡通气球，吸引了许多小朋友驻足观看。',
      'Gōngyuán ménkǒu mài zhe wǔyán-liùsè de kǎtōng qìqiú, xīyǐn le xǔduō xiǎopéngyǒu zhùzú guānkàn.',
      'Cổng công viên bày bán những chùm bóng bay hoạt hình đủ màu sắc sặc sỡ, thu hút nhiều em nhỏ dừng chân ngắm nhìn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '公园门口卖着五颜六色的卡通气球，吸引了许多小朋友驻足观看。', 'Gōngyuán ménkǒu mài zhe wǔyán-liùsè de kǎtōng qìqiú, xīyǐn le xǔduō xiǎopéngyǒu zhùzú guānkàn.', 'Cổng công viên bày bán những chùm bóng bay hoạt hình đủ màu sắc sặc sỡ, thu hút nhiều em nhỏ dừng chân ngắm nhìn.', 'basic', 1),
      (v_id, '气象科研人员在高空释放探空气球，实时采集对流层与平流层的大气温度、气压与风向湿度参数。', 'Qìxiàng kēyán rényuán zài gāokōng shìfàng tànkōng qìqiú, shíshí cǎijí duìliúcéng yǔ píngliúcéng de dàqì wēndù, qìyā yǔ fēngxiàng shīdù cānshù.', 'Các nhà nghiên cứu khí tượng thả khí cầu thám không lên không trung tầm cao để thu thập thời gian thực các thông số nhiệt độ, áp suất khí quyển, hướng gió và độ ẩm của tầng đối lưu và tầng bình lưu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2858] [汽油] (qìyóu) - xăng (nhiên liệu) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '汽油' AND pinyin = 'qìyóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '汽油' AND pinyin = 'qìyóu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '汽油'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '汽油'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qìyóu',
      meaning_vi = 'xăng (nhiên liệu)',
      example_hanzi = '长途自驾游出发之前，记得先去加油站把汽车加满汽油。',
      example_pinyin = 'Chángtú zìjiàyóu chūfā zhīqián, jìde xiān qù jiāyóuzhàn bǎ qìchē jiāmǎn qìyóu.',
      example_vi = 'Trước khi xuất phát cho chuyến tự lái xe đường dài, hãy nhớ ghé cây xăng đổ đầy bình xăng trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '汽油',
      'qìyóu',
      'xăng (nhiên liệu)',
      'Danh từ',
      'HSK 5',
      '长途自驾游出发之前，记得先去加油站把汽车加满汽油。',
      'Chángtú zìjiàyóu chūfā zhīqián, jìde xiān qù jiāyóuzhàn bǎ qìchē jiāmǎn qìyóu.',
      'Trước khi xuất phát cho chuyến tự lái xe đường dài, hãy nhớ ghé cây xăng đổ đầy bình xăng trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长途自驾游出发之前，记得先去加油站把汽车加满汽油。', 'Chángtú zìjiàyóu chūfā zhīqián, jìde xiān qù jiāyóuzhàn bǎ qìchē jiāmǎn qìyóu.', 'Trước khi xuất phát cho chuyến tự lái xe đường dài, hãy nhớ ghé cây xăng đổ đầy bình xăng trước.', 'basic', 1),
      (v_id, '随着新能源纯电动汽车渗透率快速攀升，全球传统成品汽油消费增速呈现逐步放缓的发展态势。', 'Suízhe xīnnéngyuán chún diàndòng qìchē shèntòulǜ kuàisù pānshēng, quánqiú chuántǒng chéngpǐn qìyóu xiāofèi zēngsù chéngxiàn zhúbù fànghuǎn de fāzhǎn tàishì.', 'Cùng với tỷ lệ thâm nhập của xe thuần điện năng lượng mới gia tăng nhanh chóng, tốc độ tăng trưởng tiêu thụ xăng thành phẩm truyền thống toàn cầu đang xuất hiện xu thế chậm dần từng bước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2859] [签] (qiān) - ký (tên, giấy tờ), dán nhãn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '签' AND pinyin = 'qiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '签' AND pinyin = 'qiān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '签'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '签'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiān',
      meaning_vi = 'ký (tên, giấy tờ), dán nhãn',
      example_hanzi = '快递小哥送来一个包裹，请收件人在回执单上签个名字。',
      example_pinyin = 'Kuàidì xiǎogē sòng lái yí ge bāoguǒ, qǐng shōujiànrén zài huízhídān shang qiān ge míngzi.',
      example_vi = 'Anh giao hàng gửi tới một kiện hàng, xin mời người nhận ký tên vào biên nhận chuyển phát.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '签',
      'qiān',
      'ký (tên, giấy tờ), dán nhãn',
      'Động từ',
      'HSK 5',
      '快递小哥送来一个包裹，请收件人在回执单上签个名字。',
      'Kuàidì xiǎogē sòng lái yí ge bāoguǒ, qǐng shōujiànrén zài huízhídān shang qiān ge míngzi.',
      'Anh giao hàng gửi tới một kiện hàng, xin mời người nhận ký tên vào biên nhận chuyển phát.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '快递小哥送来一个包裹，请收件人在回执单上签个名字。', 'Kuàidì xiǎogē sòng lái yí ge bāoguǒ, qǐng shōujiànrén zài huízhídān shang qiān ge míngzi.', 'Anh giao hàng gửi tới một kiện hàng, xin mời người nhận ký tên vào biên nhận chuyển phát.', 'basic', 1),
      (v_id, '双方首席谈判代表在庄严友好的国际会晤现场，正式在全面战略合作框架备忘录上签下名字。', 'Shuāngfāng shǒuxí tánpàn dàibiǎo zài zhuāngyán yǒuhǎo de guójì huìwù xiànchǎng, zhèngshì zài quánmiàn zhànlüè hézuò kuàngjià bèiwànglù shang qiān xià míngzi.', 'Trưởng đoàn đàm phán hai bên tại hiện trường cuộc hội đàm quốc tế trang nghiêm và hữu nghị đã chính thức đặt bút ký tên vào biên bản ghi nhớ khung hợp tác chiến lược toàn diện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2860] [签订] (qiāndìng) - ký kết (hợp đồng, hiệp ước, giao kèo) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '签订' AND pinyin = 'qiāndìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '签订' AND pinyin = 'qiāndìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '签订'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '签订'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiāndìng',
      meaning_vi = 'ký kết (hợp đồng, hiệp ước, giao kèo)',
      example_hanzi = '两家公司顺利签订了为期三年的技术合作与人才培训协议。',
      example_pinyin = 'Liǎng jiā gōngsī shùnlì qiāndìng le wéiqī sān nián de jìshù hézuò yǔ réncái péixùn xiéyì.',
      example_vi = 'Hai công ty đã thuận lợi ký kết thỏa thuận hợp tác kỹ thuật và đào tạo nhân tài trong thời hạn ba năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '签订',
      'qiāndìng',
      'ký kết (hợp đồng, hiệp ước, giao kèo)',
      'Động từ',
      'HSK 5',
      '两家公司顺利签订了为期三年的技术合作与人才培训协议。',
      'Liǎng jiā gōngsī shùnlì qiāndìng le wéiqī sān nián de jìshù hézuò yǔ réncái péixùn xiéyì.',
      'Hai công ty đã thuận lợi ký kết thỏa thuận hợp tác kỹ thuật và đào tạo nhân tài trong thời hạn ba năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '两家公司顺利签订了为期三年的技术合作与人才培训协议。', 'Liǎng jiā gōngsī shùnlì qiāndìng le wéiqī sān nián de jìshù hézuò yǔ réncái péixùn xiéyì.', 'Hai công ty đã thuận lợi ký kết thỏa thuận hợp tác kỹ thuật và đào tạo nhân tài trong thời hạn ba năm.', 'basic', 1),
      (v_id, '跨国财团在多国政府监管机构的共同见证下，正式签订了具有深远战略意义的高铁基建特许经营协议。', 'Kuàguó cáituán zài duō guó zhèngfǔ jiānguǎn jīgòu de gòngtóng jiànzhèng xià, zhèngshì qiāndìng le jùyǒu shēnyuǎn zhànlüè yìyì de gāotiě jījiàn tèxǔ jīngyíng xiéyì.', 'Tập đoàn tài chính đa quốc gia dưới sự chứng kiến chung của các cơ quan quản lý chính phủ nhiều nước, đã chính thức ký kết thỏa thuận nhượng quyền kinh doanh hạ tầng đường sắt cao tốc mang ý nghĩa chiến lược sâu xa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2861] [签名] (qiānmíng) - ký tên; chữ ký [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '签名' AND pinyin = 'qiānmíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '签名' AND pinyin = 'qiānmíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '签名'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '签名'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'qiānmíng',
      meaning_vi = 'ký tên; chữ ký',
      example_hanzi = '新书发布会结束后，许多热情的书迷排着长队等待作家的亲笔签名。',
      example_pinyin = 'Xīnshū fābùhuì jiéshù hòu, xǔduō rèqíng de shūmí pái zhe chángduì děngdài zuòjiā de qīnbǐ qiānmíng.',
      example_vi = 'Sau khi buổi ra mắt sách mới kết thúc, rất nhiều người hâm mộ nhiệt tình xếp thành hàng dài chờ đợi chữ ký tay của tác giả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '签名',
      'qiānmíng',
      'ký tên; chữ ký',
      'Động từ / Danh từ',
      'HSK 5',
      '新书发布会结束后，许多热情的书迷排着长队等待作家的亲笔签名。',
      'Xīnshū fābùhuì jiéshù hòu, xǔduō rèqíng de shūmí pái zhe chángduì děngdài zuòjiā de qīnbǐ qiānmíng.',
      'Sau khi buổi ra mắt sách mới kết thúc, rất nhiều người hâm mộ nhiệt tình xếp thành hàng dài chờ đợi chữ ký tay của tác giả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新书发布会结束后，许多热情的书迷排着长队等待作家的亲笔签名。', 'Xīnshū fābùhuì jiéshù hòu, xǔduō rèqíng de shūmí pái zhe chángduì děngdài zuòjiā de qīnbǐ qiānmíng.', 'Sau khi buổi ra mắt sách mới kết thúc, rất nhiều người hâm mộ nhiệt tình xếp thành hàng dài chờ đợi chữ ký tay của tác giả.', 'basic', 1),
      (v_id, '金融机构在电子合同线上签约过程中全面引入区块链防篡改存证与非对称加密电子签名技术。', 'Jīnróng jīgòu zài diànzǐ hétong xiànshàng qiānyuē guòchéng zhōng quánmiàn yǐnrù qūkuàiliàn fáng-cuàngǎi cúnzhèng yǔ fēiduìchèn jiāmì diànzǐ qiānmíng jìshù.', 'Các tổ chức tài chính trong quy trình ký kết hợp đồng điện tử trực tuyến đã đưa vào ứng dụng toàn diện công nghệ lưu trữ bằng chứng chống giả mạo blockchain và chữ ký điện tử mã hóa bất đối xứng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2862] [签字] (qiānzì) - ký tên, ký duyệt, bút tích [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '签字' AND pinyin = 'qiānzì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '签字' AND pinyin = 'qiānzì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '签字'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '签字'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'qiānzì',
      meaning_vi = 'ký tên, ký duyệt, bút tích',
      example_hanzi = '报销单据需要经过部门经理签字确认后才能提交给财务部门。',
      example_pinyin = 'Bàoxiāo dānjù xūyào jīngguò bùmén jīnglǐ qiānzì quèrèn hòu cái néng tíjiāo gěi cáiwù bùmén.',
      example_vi = 'Chứng từ thanh toán cần phải thông qua trưởng phòng ký duyệt xác nhận mới có thể nộp cho bộ phận tài vụ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '签字',
      'qiānzì',
      'ký tên, ký duyệt, bút tích',
      'Động từ / Danh từ',
      'HSK 5',
      '报销单据需要经过部门经理签字确认后才能提交给财务部门。',
      'Bàoxiāo dānjù xūyào jīngguò bùmén jīnglǐ qiānzì quèrèn hòu cái néng tíjiāo gěi cáiwù bùmén.',
      'Chứng từ thanh toán cần phải thông qua trưởng phòng ký duyệt xác nhận mới có thể nộp cho bộ phận tài vụ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '报销单据需要经过部门经理签字确认后才能提交给财务部门。', 'Bàoxiāo dānjù xūyào jīngguò bùmén jīnglǐ qiānzì quèrèn hòu cái néng tíjiāo gěi cáiwù bùmén.', 'Chứng từ thanh toán cần phải thông qua trưởng phòng ký duyệt xác nhận mới có thể nộp cho bộ phận tài vụ.', 'basic', 1),
      (v_id, '国际仲裁裁决书经全体首席仲裁员签字盖章后，立即发生不可撤销的终局法律约束力。', 'Guójì zhòngcái cáijuéshū jīng quántǐ shǒuxí zhòngcáiyuán qiānzì gàizhāng hòu, lìjí fāshēng bùkě chèxiāo de zhōngjú fǎlǜ yuēshùlì.', 'Phán quyết trọng tài quốc tế sau khi được toàn thể trọng tài viên trưởng ký tên đóng dấu sẽ lập tức phát sinh hiệu lực ràng buộc pháp lý chung thẩm không thể hủy bỏ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2863] [前进] (qiánjìn) - tiến lên, tiến bước, tiến về phía trước [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '前进' AND pinyin = 'qiánjìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '前进' AND pinyin = 'qiánjìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '前进'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '前进'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiánjìn',
      meaning_vi = 'tiến lên, tiến bước, tiến về phía trước',
      example_hanzi = '无论前方遇到多少困难挫折，我们都要坚定信念，勇往直前地前进。',
      example_pinyin = 'Wúlùn qiánfāng yùdào duōshao kùnnan cuòzhé, wǒmen dōu yào jiāndìng xìnniàn, yǒngwǎng-zhíqián de qiánjìn.',
      example_vi = 'Bất luận phía trước có gặp phải bao nhiêu khó khăn trắc trở, chúng ta đều phải kiên định niềm tin, dũng cảm tiến bước về phía trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '前进',
      'qiánjìn',
      'tiến lên, tiến bước, tiến về phía trước',
      'Động từ',
      'HSK 5',
      '无论前方遇到多少困难挫折，我们都要坚定信念，勇往直前地前进。',
      'Wúlùn qiánfāng yùdào duōshao kùnnan cuòzhé, wǒmen dōu yào jiāndìng xìnniàn, yǒngwǎng-zhíqián de qiánjìn.',
      'Bất luận phía trước có gặp phải bao nhiêu khó khăn trắc trở, chúng ta đều phải kiên định niềm tin, dũng cảm tiến bước về phía trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论前方遇到多少困难挫折，我们都要坚定信念，勇往直前地前进。', 'Wúlùn qiánfāng yùdào duōshao kùnnan cuòzhé, wǒmen dōu yào jiāndìng xìnniàn, yǒngwǎng-zhíqián de qiánjìn.', 'Bất luận phía trước có gặp phải bao nhiêu khó khăn trắc trở, chúng ta đều phải kiên định niềm tin, dũng cảm tiến bước về phía trước.', 'basic', 1),
      (v_id, '科技创新犹如强劲引擎，推动人类社会不断突破认知边界并沿着高质量发展道路阔步前进。', 'Kējì chuàngxīn yóurú qiángjìn yǐnqíng, tuīdòng rénlèi shèhuì búduàn tūpò rènzhī biānjiè bìng yánzhe gāo-zhìliàng fāzhǎn dàolù kuòbù qiánjìn.', 'Đổi mới khoa học công nghệ giống như động cơ mạnh mẽ, thúc đẩy xã hội loài người không ngừng đột phá ranh giới nhận thức và sải bước tiến lên trên con đường phát triển chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2864] [前来] (qiánlái) - đến, tìm đến, đến dự [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '前来' AND pinyin = 'qiánlái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '前来' AND pinyin = 'qiánlái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '前来'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '前来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiánlái',
      meaning_vi = 'đến, tìm đến, đến dự',
      example_hanzi = '每逢周末，许多市民都会前来这个新建的城市图书馆阅读自习。',
      example_pinyin = 'Měi féng zhōumò, xǔduō shìmín dōu huì qiánlái zhè ge xīn jiàn de chéngshì túshūguǎn yuèdú zìxí.',
      example_vi = 'Cứ mỗi dịp cuối tuần, rất nhiều người dân thành phố lại tìm đến thư viện thành phố mới xây này để đọc sách tự học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '前来',
      'qiánlái',
      'đến, tìm đến, đến dự',
      'Động từ',
      'HSK 5',
      '每逢周末，许多市民都会前来这个新建的城市图书馆阅读自习。',
      'Měi féng zhōumò, xǔduō shìmín dōu huì qiánlái zhè ge xīn jiàn de chéngshì túshūguǎn yuèdú zìxí.',
      'Cứ mỗi dịp cuối tuần, rất nhiều người dân thành phố lại tìm đến thư viện thành phố mới xây này để đọc sách tự học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每逢周末，许多市民都会前来这个新建的城市图书馆阅读自习。', 'Měi féng zhōumò, xǔduō shìmín dōu huì qiánlái zhè ge xīn jiàn de chéngshì túshūguǎn yuèdú zìxí.', 'Cứ mỗi dịp cuối tuần, rất nhiều người dân thành phố lại tìm đến thư viện thành phố mới xây này để đọc sách tự học.', 'basic', 1),
      (v_id, '来自三十余个国家和地区的专家学者应邀前来参加全球生物多样性治理高端闭门学术论坛。', 'Láizì sānshí yú ge guójiā hé dìqū de zhuānjiā xuézhě yīngyào qiánlái cānjiā quánqiú shēngwù duōyàngxìng zhìlǐ gāoduān bìmén xuéshù lùntán.', 'Các chuyên gia học giả đến từ hơn ba mươi quốc gia và vùng lãnh thổ nhận lời mời đến tham dự diễn đàn học thuật kín cấp cao về quản trị đa dạng sinh học toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2865] [前途] (qiántú) - tiền đồ, tương lai triển vọng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '前途' AND pinyin = 'qiántú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '前途' AND pinyin = 'qiántú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '前途'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '前途'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qiántú',
      meaning_vi = 'tiền đồ, tương lai triển vọng',
      example_hanzi = '只要脚踏实地努力工作，每个年轻人都拥有光明的奋斗前途。',
      example_pinyin = 'Zhǐyào jiǎotà-shídì nǔlì gōngzuò, měi ge niánqīngrén dōu yōngyǒu guāngmíng de fèndòu qiántú.',
      example_vi = 'Chỉ cần làm việc chăm chỉ vững bước thực tế, mỗi người trẻ tuổi đều sở hữu một tiền đồ phấn đấu xán lạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '前途',
      'qiántú',
      'tiền đồ, tương lai triển vọng',
      'Danh từ',
      'HSK 5',
      '只要脚踏实地努力工作，每个年轻人都拥有光明的奋斗前途。',
      'Zhǐyào jiǎotà-shídì nǔlì gōngzuò, měi ge niánqīngrén dōu yōngyǒu guāngmíng de fèndòu qiántú.',
      'Chỉ cần làm việc chăm chỉ vững bước thực tế, mỗi người trẻ tuổi đều sở hữu một tiền đồ phấn đấu xán lạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只要脚踏实地努力工作，每个年轻人都拥有光明的奋斗前途。', 'Zhǐyào jiǎotà-shídì nǔlì gōngzuò, měi ge niánqīngrén dōu yōngyǒu guāngmíng de fèndòu qiántú.', 'Chỉ cần làm việc chăm chỉ vững bước thực tế, mỗi người trẻ tuổi đều sở hữu một tiền đồ phấn đấu xán lạn.', 'basic', 1),
      (v_id, '在数字化和智能化的宏阔时代浪潮下，能够把握产业技术跃迁机遇的企业必定大有前途。', 'Zài shùzìhuà hé zhìnénghuà de hóngkuò shídài làngcháo xià, nénggòu bǎwò chǎnyè jìshù yuèqiān jīyù de qǐyè bìdìng dàyǒu-qiántú.', 'Dưới làn sóng thời đại số hóa và thông minh hóa rộng lớn, doanh nghiệp nào nắm bắt được cơ hội nhảy vọt về công nghệ sản xuất ắt sẽ có tiền đồ vô cùng xán lạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2866] [前往] (qiánwǎng) - đi đến, hướng tới, lên đường tới [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '前往' AND pinyin = 'qiánwǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '前往' AND pinyin = 'qiánwǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '前往'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '前往'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiánwǎng',
      meaning_vi = 'đi đến, hướng tới, lên đường tới',
      example_hanzi = '代表团今天清晨从北京首都国际机场出发，前往上海参加经贸洽谈会。',
      example_pinyin = 'Dàibiǎotuán jīntiān qīngchén cóng Běijīng Shǒudū Guójì Jīchǎng chūfā, qiánwǎng Shànghǎi cānjiā jīngmào qiàtánhuì.',
      example_vi = 'Đoàn đại biểu sáng sớm hôm nay đã xuất phát từ sân bay quốc tế Thủ Đô Bắc Kinh, lên đường tới Thượng Hải tham dự hội nghị xúc tiến kinh tế thương mại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '前往',
      'qiánwǎng',
      'đi đến, hướng tới, lên đường tới',
      'Động từ',
      'HSK 5',
      '代表团今天清晨从北京首都国际机场出发，前往上海参加经贸洽谈会。',
      'Dàibiǎotuán jīntiān qīngchén cóng Běijīng Shǒudū Guójì Jīchǎng chūfā, qiánwǎng Shànghǎi cānjiā jīngmào qiàtánhuì.',
      'Đoàn đại biểu sáng sớm hôm nay đã xuất phát từ sân bay quốc tế Thủ Đô Bắc Kinh, lên đường tới Thượng Hải tham dự hội nghị xúc tiến kinh tế thương mại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '代表团今天清晨从北京首都国际机场出发，前往上海参加经贸洽谈会。', 'Dàibiǎotuán jīntiān qīngchén cóng Běijīng Shǒudū Guójì Jīchǎng chūfā, qiánwǎng Shànghǎi cānjiā jīngmào qiàtánhuì.', 'Đoàn đại biểu sáng sớm hôm nay đã xuất phát từ sân bay quốc tế Thủ Đô Bắc Kinh, lên đường tới Thượng Hải tham dự hội nghị xúc tiến kinh tế thương mại.', 'basic', 1),
      (v_id, '地震灾情发生后，国家医疗应急救援队携带专业生命探测与手术救治装备星夜兼程前往震中灾区。', 'Dìzhèn zāiqíng fāshēng hòu, guójiā yīliáo yìngjí jiùyuánduì xiédài zhuānyè shēngmìng tàncè yǔ shǒushù jiùzhì zhuāngbèi xīngyè-jiānchéng qiánwǎng zhènzhōng zāiqū.', 'Sau khi thiên tai động đất xảy ra, đội cứu hộ y tế khẩn cấp quốc gia mang theo thiết bị dò tìm sự sống và phẫu thuật cấp cứu chuyên dụng đã ngày đêm lên đường đi tới tâm chấn vùng thảm họa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2867] [浅] (qiǎn) - nông, cạn; nhạt (màu sắc); nông cạn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '浅' AND pinyin = 'qiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '浅' AND pinyin = 'qiǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '浅'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '浅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'qiǎn',
      meaning_vi = 'nông, cạn; nhạt (màu sắc); nông cạn',
      example_hanzi = '这条小溪的水很浅，清澈见底，甚至能看清鹅卵石和游动的小鱼。',
      example_pinyin = 'Zhè tiáo xiǎoxī de shuǐ hěn qiǎn, qīngchè jiàn dǐ, shènzhì néng kàn qīng éluǎnshí hé yóudòng de xiǎoyú.',
      example_vi = 'Nước con suối nhỏ này rất nông cạn, trong veo thấy tận đáy, thậm chí nhìn rõ những viên sỏi cuội và đàn cá nhỏ bơi lội.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '浅',
      'qiǎn',
      'nông, cạn; nhạt (màu sắc); nông cạn',
      'Tính từ',
      'HSK 5',
      '这条小溪的水很浅，清澈见底，甚至能看清鹅卵石和游动的小鱼。',
      'Zhè tiáo xiǎoxī de shuǐ hěn qiǎn, qīngchè jiàn dǐ, shènzhì néng kàn qīng éluǎnshí hé yóudòng de xiǎoyú.',
      'Nước con suối nhỏ này rất nông cạn, trong veo thấy tận đáy, thậm chí nhìn rõ những viên sỏi cuội và đàn cá nhỏ bơi lội.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这条小溪的水很浅，清澈见底，甚至能看清鹅卵石和游动的小鱼。', 'Zhè tiáo xiǎoxī de shuǐ hěn qiǎn, qīngchè jiàn dǐ, shènzhì néng kàn qīng éluǎnshí hé yóudòng de xiǎoyú.', 'Nước con suối nhỏ này rất nông cạn, trong veo thấy tận đáy, thậm chí nhìn rõ những viên sỏi cuội và đàn cá nhỏ bơi lội.', 'basic', 1),
      (v_id, '对古典文献的解读绝不能停留在字面文字的浅显层面，而应深入探究其背后的思想史语境。', 'Duì gǔdiǎn wénxiàn de jiědú jué bù néng tíngliú zài zìmiàn wénzì de qiǎnxiǎn céngmiàn, ér yīng shēnrù tànjiū qí bèihòu de sīxiǎngshǐ yǔjìng.', 'Việc diễn giải văn hiến cổ điển tuyệt đối không thể dừng lại ở tầng mức nông cạn trên mặt câu chữ, mà cần phải tìm hiểu sâu sắc ngữ cảnh lịch sử tư tưởng ẩn sau nó.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2868] [欠] (qiàn) - nợ (tiền, ân tình); thiếu thốn, chưa đủ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '欠' AND pinyin = 'qiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '欠' AND pinyin = 'qiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '欠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '欠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiàn',
      meaning_vi = 'nợ (tiền, ân tình); thiếu thốn, chưa đủ',
      example_hanzi = '他把向朋友借来的钱全部还清了，现在终于不再欠别人的债了。',
      example_pinyin = 'Tā bǎ xiàng péngyou jiè lái de qián quánbù huánqīng le, xiànzài zhōngyú bú zài qiàn biérén de zhài le.',
      example_vi = 'Anh ấy đã trả hết toàn bộ số tiền mượn từ bạn bè, hiện tại cuối cùng không còn nợ nần ai nữa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '欠',
      'qiàn',
      'nợ (tiền, ân tình); thiếu thốn, chưa đủ',
      'Động từ',
      'HSK 5',
      '他把向朋友借来的钱全部还清了，现在终于不再欠别人的债了。',
      'Tā bǎ xiàng péngyou jiè lái de qián quánbù huánqīng le, xiànzài zhōngyú bú zài qiàn biérén de zhài le.',
      'Anh ấy đã trả hết toàn bộ số tiền mượn từ bạn bè, hiện tại cuối cùng không còn nợ nần ai nữa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他把向朋友借来的钱全部还清了，现在终于不再欠别人的债了。', 'Tā bǎ xiàng péngyou jiè lái de qián quánbù huánqīng le, xiànzài zhōngyú bú zài qiàn biérén de zhài le.', 'Anh ấy đã trả hết toàn bộ số tiền mượn từ bạn bè, hiện tại cuối cùng không còn nợ nần ai nữa.', 'basic', 1),
      (v_id, '该项可行性调研论证仍欠周密，亟需补充更详实的实证数据与行业合规风险评估支撑。', 'Gāi xiàng kěxíngxìng diàoyán lùnzhèng réng qiàn zhōumì, jíxū bǔchōng gèng xiángshí de shízhèng shùjù yǔ hángyè héguī fēngxiǎn pínggū zhīchēng.', 'Khảo sát luận chứng tính khả thi của dự án này vẫn còn thiếu chu đáo cẩn trọng, khẩn thiết cần bổ sung thêm dữ liệu thực chứng chi tiết và đánh giá rủi ro tuân thủ ngành để làm căn cứ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2869] [墙] (qiáng) - bức tường, bờ tường [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '墙' AND pinyin = 'qiáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '墙' AND pinyin = 'qiáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '墙'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '墙'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qiáng',
      meaning_vi = 'bức tường, bờ tường',
      example_hanzi = '客厅雪白的墙上挂着一幅描绘群山晨光的中国山水水墨画。',
      example_pinyin = 'Kètīng xuěbái de qiáng shang guà zhe yì fú miáohuì qúnshān chénguāng de Zhōngguó shānshuǐ shuǐmòhuà.',
      example_vi = 'Trên bức tường trắng như tuyết của phòng khách treo một bức tranh thủy mặc sơn thủy Trung Hoa miêu tả ánh ban mai trên những rặng núi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '墙',
      'qiáng',
      'bức tường, bờ tường',
      'Danh từ',
      'HSK 5',
      '客厅雪白的墙上挂着一幅描绘群山晨光的中国山水水墨画。',
      'Kètīng xuěbái de qiáng shang guà zhe yì fú miáohuì qúnshān chénguāng de Zhōngguó shānshuǐ shuǐmòhuà.',
      'Trên bức tường trắng như tuyết của phòng khách treo một bức tranh thủy mặc sơn thủy Trung Hoa miêu tả ánh ban mai trên những rặng núi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '客厅雪白的墙上挂着一幅描绘群山晨光的中国山水水墨画。', 'Kètīng xuěbái de qiáng shang guà zhe yì fú miáohuì qúnshān chénguāng de Zhōngguó shānshuǐ shuǐmòhuà.', 'Trên bức tường trắng như tuyết của phòng khách treo một bức tranh thủy mặc sơn thủy Trung Hoa miêu tả ánh ban mai trên những rặng núi.', 'basic', 1),
      (v_id, '现代数据中心在网络边界构筑起高强度的下一代软硬件防火墙体系，有效抵御恶意的分布式网络攻击。', 'Xiàndài shùjù zhōngxīn zài wǎngluò biānjiè gòuzhù qǐ gāo-qiángdù de xià-yí-dài ruǎnhàrjiàn fánghuǒqiáng tǐxì, yǒuxiào dǐyù èyì de fēnbùshì wǎngluò gōngjī.', 'Trung tâm dữ liệu hiện đại đã xây dựng hệ thống tường lửa phần mềm phần cứng thế hệ mới cường độ cao tại biên mạng, phòng ngự hữu hiệu các cuộc tấn công mạng phân tán hiểm độc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2870] [强大] (qiángdà) - hùng mạnh, lớn mạnh, to lớn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '强大' AND pinyin = 'qiángdà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '强大' AND pinyin = 'qiángdà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '强大'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '强大'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'qiángdà',
      meaning_vi = 'hùng mạnh, lớn mạnh, to lớn',
      example_hanzi = '一支强大的团队不仅需要优秀的领导者，更需要成员之间默契的配合。',
      example_pinyin = 'Yì zhī qiángdà de tuánduì bùjǐn xūyào yōuxiù de lǐngdǎozhě, gèng xūyào chéngyuán zhījiān mòqì de pèihé.',
      example_vi = 'Một đội ngũ lớn mạnh không chỉ cần có người lãnh đạo xuất sắc mà còn cần sự phối hợp ăn ý giữa các thành viên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '强大',
      'qiángdà',
      'hùng mạnh, lớn mạnh, to lớn',
      'Tính từ',
      'HSK 5',
      '一支强大的团队不仅需要优秀的领导者，更需要成员之间默契的配合。',
      'Yì zhī qiángdà de tuánduì bùjǐn xūyào yōuxiù de lǐngdǎozhě, gèng xūyào chéngyuán zhījiān mòqì de pèihé.',
      'Một đội ngũ lớn mạnh không chỉ cần có người lãnh đạo xuất sắc mà còn cần sự phối hợp ăn ý giữa các thành viên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一支强大的团队不仅需要优秀的领导者，更需要成员之间默契的配合。', 'Yì zhī qiángdà de tuánduì bùjǐn xūyào yōuxiù de lǐngdǎozhě, gèng xūyào chéngyuán zhījiān mòqì de pèihé.', 'Một đội ngũ lớn mạnh không chỉ cần có người lãnh đạo xuất sắc mà còn cần sự phối hợp ăn ý giữa các thành viên.', 'basic', 1),
      (v_id, '深厚的工业制造底蕴与完备的上下游供应链配套，构成了该区域抵御外部市场波动的强大经济韧性。', 'Shēnhòu de gōngyè zhìzào dǐyùn yǔ wánbèi de shàng-xiàyóu gōngyìngliàn pèitào, gòuchéng le gāi qūyù dǐyù wàibù shìchǎng bōdòng de qiángdà jīngjì rènxìng.', 'Bề dày nền tảng sản xuất công nghiệp và chuỗi cung ứng đồng bộ hoàn thiện từ thượng nguồn đến hạ nguồn đã cấu thành khả năng chống chịu kinh tế mạnh mẽ của khu vực này trước những biến động của thị trường bên ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2871] [强调] (qiángdiào) - nhấn mạnh, đặt trọng tâm vào [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '强调' AND pinyin = 'qiángdiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '强调' AND pinyin = 'qiángdiào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '强调'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '强调'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiángdiào',
      meaning_vi = 'nhấn mạnh, đặt trọng tâm vào',
      example_hanzi = '老师在课上反复强调，期末考试前大家一定要仔细复习课本重点。',
      example_pinyin = 'Lǎoshī zài kè shang fǎnfù qiángdiào, qīmò kǎoshì qián dàjiā yídìng yào zǐxì fùxí kèběn zhòngdiǎn.',
      example_vi = 'Thầy giáo trong giờ học đã nhắc đi nhắc lại nhấn mạnh rằng trước kỳ thi học kỳ mọi người nhất định phải ôn tập kỹ các trọng tâm trong sách giáo khoa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '强调',
      'qiángdiào',
      'nhấn mạnh, đặt trọng tâm vào',
      'Động từ',
      'HSK 5',
      '老师在课上反复强调，期末考试前大家一定要仔细复习课本重点。',
      'Lǎoshī zài kè shang fǎnfù qiángdiào, qīmò kǎoshì qián dàjiā yídìng yào zǐxì fùxí kèběn zhòngdiǎn.',
      'Thầy giáo trong giờ học đã nhắc đi nhắc lại nhấn mạnh rằng trước kỳ thi học kỳ mọi người nhất định phải ôn tập kỹ các trọng tâm trong sách giáo khoa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老师在课上反复强调，期末考试前大家一定要仔细复习课本重点。', 'Lǎoshī zài kè shang fǎnfù qiángdiào, qīmò kǎoshì qián dàjiā yídìng yào zǐxì fùxí kèběn zhòngdiǎn.', 'Thầy giáo trong giờ học đã nhắc đi nhắc lại nhấn mạnh rằng trước kỳ thi học kỳ mọi người nhất định phải ôn tập kỹ các trọng tâm trong sách giáo khoa.', 'basic', 1),
      (v_id, '世界卫生组织在最新卫生工作指引中再次强调，建立普惠均衡的公共卫生基层防治网络至关重要。', 'Shìjiè Wèishēng Zǔzhī zài zuìxīn wèishēng gōngzuò zhǐyǐn zhōng zàicì qiángdiào, jiànlì pǔhuì jīnhéng de gōnggòng wèishēng jīcéng fángzhì wǎngluò zhìguān-zhòngyào.', 'Tổ chức Y tế Thế giới trong chỉ dẫn công tác y tế mới nhất một lần nữa nhấn mạnh việc xây dựng mạng lưới phòng trị y tế công cộng cơ sở bao trùm và cân bằng là vô cùng trọng yếu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2872] [强度] (qiángdù) - cường độ (lao động, ánh sáng, chịu lực) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '强度' AND pinyin = 'qiángdù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '强度' AND pinyin = 'qiángdù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '强度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '强度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qiángdù',
      meaning_vi = 'cường độ (lao động, ánh sáng, chịu lực)',
      example_hanzi = '剧烈运动之后要注意适度休息，不能长时间保持高强度的训练。',
      example_pinyin = 'Jùliè yùndòng zhīhòu yào zhùyì shìdù xiūxi, bù néng cháng shíjiān bǎochí gāo-qiángdù de xùnliàn.',
      example_vi = 'Sau khi vận động mạnh cần chú ý nghỉ ngơi hợp lý, không được duy trì việc tập luyện cường độ cao trong thời gian dài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '强度',
      'qiángdù',
      'cường độ (lao động, ánh sáng, chịu lực)',
      'Danh từ',
      'HSK 5',
      '剧烈运动之后要注意适度休息，不能长时间保持高强度的训练。',
      'Jùliè yùndòng zhīhòu yào zhùyì shìdù xiūxi, bù néng cháng shíjiān bǎochí gāo-qiángdù de xùnliàn.',
      'Sau khi vận động mạnh cần chú ý nghỉ ngơi hợp lý, không được duy trì việc tập luyện cường độ cao trong thời gian dài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '剧烈运动之后要注意适度休息，不能长时间保持高强度的训练。', 'Jùliè yùndòng zhīhòu yào zhùyì shìdù xiūxi, bù néng cháng shíjiān bǎochí gāo-qiángdù de xùnliàn.', 'Sau khi vận động mạnh cần chú ý nghỉ ngơi hợp lý, không được duy trì việc tập luyện cường độ cao trong thời gian dài.', 'basic', 1),
      (v_id, '新研发的高性能航空航天碳纤维复合材料不仅重量极轻，而且抗拉伸强度和耐腐蚀极限远超传统合金。', 'Xīn yánfā de gāo-xìngnéng hángkōng hángtiān tànxiānwéi fùhé cáiliào bùjǐn zhòngliàng jí qīng, érqiě kàng-lāshēn qiángdù hé nài-fǔshí jíxiàn yuǎn chāo chuántǒng héjīn.', 'Vật liệu composite sợi carbon hiệu suất cao hàng không vũ trụ mới phát triển không chỉ có trọng lượng cực nhẹ mà còn có cường độ chịu kéo và giới hạn chống ăn mòn vượt xa các hợp kim truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2873] [强烈] (qiángliè) - mãnh liệt, dữ dội, gay gắt, mạnh mẽ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '强烈' AND pinyin = 'qiángliè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '强烈' AND pinyin = 'qiángliè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '强烈'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '强烈'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'qiángliè',
      meaning_vi = 'mãnh liệt, dữ dội, gay gắt, mạnh mẽ',
      example_hanzi = '正午的阳光非常强烈，出门前最好戴上太阳镜和遮阳帽。',
      example_pinyin = 'Zhèngwǔ de yángguāng fēicháng qiángliè, chūmén qián zuì hǎo dài shàng tàiyángjìng hé zhēyángmào.',
      example_vi = 'Ánh nắng giữa trưa vô cùng gay gắt, trước khi ra ngoài tốt nhất nên đeo kính râm và đội mũ che nắng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '强烈',
      'qiángliè',
      'mãnh liệt, dữ dội, gay gắt, mạnh mẽ',
      'Tính từ',
      'HSK 5',
      '正午的阳光非常强烈，出门前最好戴上太阳镜和遮阳帽。',
      'Zhèngwǔ de yángguāng fēicháng qiángliè, chūmén qián zuì hǎo dài shàng tàiyángjìng hé zhēyángmào.',
      'Ánh nắng giữa trưa vô cùng gay gắt, trước khi ra ngoài tốt nhất nên đeo kính râm và đội mũ che nắng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '正午的阳光非常强烈，出门前最好戴上太阳镜和遮阳帽。', 'Zhèngwǔ de yángguāng fēicháng qiángliè, chūmén qián zuì hǎo dài shàng tàiyángjìng hé zhēyángmào.', 'Ánh nắng giữa trưa vô cùng gay gắt, trước khi ra ngoài tốt nhất nên đeo kính râm và đội mũ che nắng.', 'basic', 1),
      (v_id, '该项充满争议的城市拆迁改造规划方案一经公示，便引发了社会公众和环保组织极其强烈的关注与质疑。', 'Gāi xiàng chōngmǎn zhēngyì de chéngshì chāiqiān gǎizào guīhuà fāng’àn yì jīng gōngshì, biàn yǐnfā le shèhuì gōngzhòng hé huánbǎo zǔzhī jíqí qiángliè de guānzhù yǔ zhìyí.', 'Phương án quy hoạch cải tạo giải tỏa đô thị đầy tranh cãi này vừa mới công bố đã khơi dậy sự quan tâm và nghi vấn cực kỳ gay gắt từ công chúng xã hội và các tổ chức bảo vệ môi trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2874] [抢] (qiǎng) - giành giật, cướp, tranh thủ khẩn trương [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '抢' AND pinyin = 'qiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抢' AND pinyin = 'qiǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '抢'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抢'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiǎng',
      meaning_vi = 'giành giật, cướp, tranh thủ khẩn trương',
      example_hanzi = '节假日火车票一开售，大家就守在手机前拼命抢票。',
      example_pinyin = 'Jiéjiàrì huǒchēpiào yì kāi shòu, dàjiā jiù shǒu zài shǒujī qián pīnmìng qiǎng piào.',
      example_vi = 'Vừa mở bán vé tàu kỳ nghỉ lễ, mọi người liền canh trước điện thoại dốc sức tranh nhau săn vé.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '抢',
      'qiǎng',
      'giành giật, cướp, tranh thủ khẩn trương',
      'Động từ',
      'HSK 5',
      '节假日火车票一开售，大家就守在手机前拼命抢票。',
      'Jiéjiàrì huǒchēpiào yì kāi shòu, dàjiā jiù shǒu zài shǒujī qián pīnmìng qiǎng piào.',
      'Vừa mở bán vé tàu kỳ nghỉ lễ, mọi người liền canh trước điện thoại dốc sức tranh nhau săn vé.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '节假日火车票一开售，大家就守在手机前拼命抢票。', 'Jiéjiàrì huǒchēpiào yì kāi shòu, dàjiā jiù shǒu zài shǒujī qián pīnmìng qiǎng piào.', 'Vừa mở bán vé tàu kỳ nghỉ lễ, mọi người liền canh trước điện thoại dốc sức tranh nhau săn vé.', 'basic', 1),
      (v_id, '农业技术人员抢抓雨后土壤墒情适宜的黄金农时，争分夺秒组织机械化大面积秋收秋种作业。', 'Nóngyè jìshù rényuán qiǎngzhuā yǔ hòu tǔrǎng shāngqíng shìyí de huángjīn nóngshí, zhēngfēn-duómiǎo zǔzhī jīxièhuà dà miànjī qiūshōu-qiūzhòng zuòyè.', 'Cán bộ kỹ thuật nông nghiệp khẩn trương chớp lấy thời vụ vàng khi độ ẩm đất sau mưa thích hợp, tranh thủ từng phút từng giây tổ chức hoạt động thu hoạch và gieo trồng vụ thu bằng cơ giới hóa trên diện tích lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2875] [抢救] (qiǎngjiù) - cấp cứu, cứu chữa khẩn cấp, cứu hộ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '抢救' AND pinyin = 'qiǎngjiù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抢救' AND pinyin = 'qiǎngjiù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '抢救'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抢救'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiǎngjiù',
      meaning_vi = 'cấp cứu, cứu chữa khẩn cấp, cứu hộ',
      example_hanzi = '救护车拉着警报呼啸而过，急忙将重伤患者送往医院进行抢救。',
      example_pinyin = 'Jiùhùchē lā zhe jǐngbào hūxiào ér guò, jímáng jiāng zhòngshāng huànzhě sòng wǎng yīyuàn jìnxíng qiǎngjiù.',
      example_vi = 'Xe cứu thương hú còi inh ỏi lao nhanh qua, gấp gáp đưa bệnh nhân chấn thương nặng đến bệnh viện để cấp cứu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '抢救',
      'qiǎngjiù',
      'cấp cứu, cứu chữa khẩn cấp, cứu hộ',
      'Động từ',
      'HSK 5',
      '救护车拉着警报呼啸而过，急忙将重伤患者送往医院进行抢救。',
      'Jiùhùchē lā zhe jǐngbào hūxiào ér guò, jímáng jiāng zhòngshāng huànzhě sòng wǎng yīyuàn jìnxíng qiǎngjiù.',
      'Xe cứu thương hú còi inh ỏi lao nhanh qua, gấp gáp đưa bệnh nhân chấn thương nặng đến bệnh viện để cấp cứu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '救护车拉着警报呼啸而过，急忙将重伤患者送往医院进行抢救。', 'Jiùhùchē lā zhe jǐngbào hūxiào ér guò, jímáng jiāng zhòngshāng huànzhě sòng wǎng yīyuàn jìnxíng qiǎngjiù.', 'Xe cứu thương hú còi inh ỏi lao nhanh qua, gấp gáp đưa bệnh nhân chấn thương nặng đến bệnh viện để cấp cứu.', 'basic', 1),
      (v_id, '文保专家对遭受暴雨洪涝浸泡的古村落珍贵壁画展开抢救性保护修复，竭力留住千年历史文化遗存。', 'Wénbǎo zhuānjiā duì zāoshòu bàoyǔ hónglào jìnpào de gǔcūnluò zhēnguì bìhuà zhǎnkāi qiǎngjiùxìng bǎohù xiūfù, jiélì liú zhù qiānnián lìshǐ wénhuà yícún.', 'Các chuyên gia bảo tồn di sản văn hóa đã triển khai công tác bảo vệ và phục chế mang tính cấp cứu đối với các bức bích họa quý giá tại ngôi làng cổ bị ngập trong mưa lũ, dốc hết sức mình lưu giữ di sản văn hóa lịch sử nghìn năm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2876] [悄悄] (qiāoqiāo) - lặng lẽ, khẽ khàng, lén lút [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '悄悄' AND pinyin = 'qiāoqiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '悄悄' AND pinyin = 'qiāoqiāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '悄悄'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '悄悄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'qiāoqiāo',
      meaning_vi = 'lặng lẽ, khẽ khàng, lén lút',
      example_hanzi = '为了不打扰正在休息的家人，他悄悄地关上房门走了出去。',
      example_pinyin = 'Wèile bù dǎrǎo zhèngzài xiūxi de jiārén, tā qiāoqiāo de guān shàng fángmén zǒu le chūqù.',
      example_vi = 'Để không làm phiền người nhà đang nghỉ ngơi, anh ấy khẽ khàng đóng cửa phòng lại rồi bước ra ngoài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '悄悄',
      'qiāoqiāo',
      'lặng lẽ, khẽ khàng, lén lút',
      'Phó từ',
      'HSK 5',
      '为了不打扰正在休息的家人，他悄悄地关上房门走了出去。',
      'Wèile bù dǎrǎo zhèngzài xiūxi de jiārén, tā qiāoqiāo de guān shàng fángmén zǒu le chūqù.',
      'Để không làm phiền người nhà đang nghỉ ngơi, anh ấy khẽ khàng đóng cửa phòng lại rồi bước ra ngoài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了不打扰正在休息的家人，他悄悄地关上房门走了出去。', 'Wèile bù dǎrǎo zhèngzài xiūxi de jiārén, tā qiāoqiāo de guān shàng fángmén zǒu le chūqù.', 'Để không làm phiền người nhà đang nghỉ ngơi, anh ấy khẽ khàng đóng cửa phòng lại rồi bước ra ngoài.', 'basic', 1),
      (v_id, '随着新一轮人工智能技术的深度赋能，智能化与低碳化理念正悄悄重塑传统制造业的底层生产组织模式。', 'Suízhe xīn yì lún réngōng zhìnéng jìshù de shēndù fùnéng, zhìnénghuà yǔ dītànhuà lǐniàn zhèng qiāoqiāo chóngshù chuántǒng zhìzàoyè de dǐcéng shēngchǎn zǔzhī móshì.', 'Cùng với sự tiếp sức sâu sắc của làn sóng công nghệ trí tuệ nhân tạo mới, quan niệm thông minh hóa và ít carbon đang lặng lẽ tái định hình mô hình tổ chức sản xuất nền tảng của ngành chế tạo truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2877] [切] (qiē) - cắt, thái, xắt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '切' AND pinyin = 'qiē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '切' AND pinyin = 'qiē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '切'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '切'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qiē',
      meaning_vi = 'cắt, thái, xắt',
      example_hanzi = '做饭时使用锋利的菜刀切洋葱，要特别当心不要切到手指。',
      example_pinyin = 'Zuòfàn shí shǐyòng fēnglì de càidāo qiē yángcōng, yào tèbié dāngxīn bú yào qiē dào shǒuzhǐ.',
      example_vi = 'Khi nấu ăn dùng con dao làm bếp sắc bén để thái hành tây, phải đặc biệt cẩn thận kẻo cắt vào ngón tay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '切',
      'qiē',
      'cắt, thái, xắt',
      'Động từ',
      'HSK 5',
      '做饭时使用锋利的菜刀切洋葱，要特别当心不要切到手指。',
      'Zuòfàn shí shǐyòng fēnglì de càidāo qiē yángcōng, yào tèbié dāngxīn bú yào qiē dào shǒuzhǐ.',
      'Khi nấu ăn dùng con dao làm bếp sắc bén để thái hành tây, phải đặc biệt cẩn thận kẻo cắt vào ngón tay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '做饭时使用锋利的菜刀切洋葱，要特别当心不要切到手指。', 'Zuòfàn shí shǐyòng fēnglì de càidāo qiē yángcōng, yào tèbié dāngxīn bú yào qiē dào shǒuzhǐ.', 'Khi nấu ăn dùng con dao làm bếp sắc bén để thái hành tây, phải đặc biệt cẩn thận kẻo cắt vào ngón tay.', 'basic', 1),
      (v_id, '现代数控超高压水刀能够以数倍音速精准切割钛合金和防弹装甲材料，切口平整且不产生任何热变形。', 'Xiàndài shùkòng chāo-gāoyā shuǐdāo nénggòu yǐ shù bèi yīnsù jīngzhǔn qiēgē tàihéjīn hé fángdàn zhuāngjiǎ cáiliào, qiēkǒu píngzhěng qiě bù chǎnshēng rènhé rè-biànxíng.', 'Dao cắt tia nước siêu áp CNC hiện đại có thể cắt chính xác hợp kim titan và vật liệu giáp chống đạn với tốc độ gấp nhiều lần vận tốc âm thanh, vết cắt phẳng phiu và không tạo ra bất kỳ biến dạng nhiệt nào.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2878] [亲] (qīn) - thân thiết, ruột thịt; hôn [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亲' AND pinyin = 'qīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲' AND pinyin = 'qīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'qīn',
      meaning_vi = 'thân thiết, ruột thịt; hôn',
      example_hanzi = '母亲温柔地抱起刚刚睡醒的小宝宝，在孩子红润的脸蛋上轻轻亲了一下。',
      example_pinyin = 'Mǔqīn wēnróu de bào qǐ gānggāng shuìxǐng de xiǎo bǎobao, zài háizi hóngrùn de liǎndàn shang qīngqīng qīn le yíxià.',
      example_vi = 'Người mẹ dịu dàng bế đứa bé vừa tỉnh giấc lên, khẽ hôn một cái lên gò má ửng hồng của con.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亲',
      'qīn',
      'thân thiết, ruột thịt; hôn',
      'Tính từ / Động từ',
      'HSK 5',
      '母亲温柔地抱起刚刚睡醒的小宝宝，在孩子红润的脸蛋上轻轻亲了一下。',
      'Mǔqīn wēnróu de bào qǐ gānggāng shuìxǐng de xiǎo bǎobao, zài háizi hóngrùn de liǎndàn shang qīngqīng qīn le yíxià.',
      'Người mẹ dịu dàng bế đứa bé vừa tỉnh giấc lên, khẽ hôn một cái lên gò má ửng hồng của con.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '母亲温柔地抱起刚刚睡醒的小宝宝，在孩子红润的脸蛋上轻轻亲了一下。', 'Mǔqīn wēnróu de bào qǐ gānggāng shuìxǐng de xiǎo bǎobao, zài háizi hóngrùn de liǎndàn shang qīngqīng qīn le yíxià.', 'Người mẹ dịu dàng bế đứa bé vừa tỉnh giấc lên, khẽ hôn một cái lên gò má ửng hồng của con.', 'basic', 1),
      (v_id, '驻村工作队干部扎根高山贫困山村，与父老乡亲同吃同住同劳动，结下了亲如一家的深厚鱼水深情。', 'Zhù cūn gōngzuòduì gànbù zhāgēn gāoshān pínkùn shāncūn, yǔ fùlǎo-xiāngqīn tóng chī tóng zhù tóng láodòng, jié xià le qīn rú yì jiā de shēnhòu yúshuǐ shēnqíng.', 'Các cán bộ đội công tác cắm bản bám rễ tại các thôn làng miền núi nghèo khó, cùng ăn cùng ở cùng lao động với bà con lối xóm, kết nên mối ân tình quân dân thắm thiết thân thiết như một nhà.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2879] [亲爱] (qīn’ài) - thân ái, yêu quý, thân yêu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亲爱' AND pinyin = 'qīn’ài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲爱' AND pinyin = 'qīn’ài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亲爱'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲爱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'qīn’ài',
      meaning_vi = 'thân ái, yêu quý, thân yêu',
      example_hanzi = '每逢教师节，同学们都会给亲爱的老师送上鲜花并写下真挚的祝福卡片。',
      example_pinyin = 'Měi féng Jiàoshījié, tóngxuémen dōu huì gěi qīn’ài de lǎoshī sòng shàng xiānhuā bìng xiě xià zhēnzhì de zhùfú kǎpiàn.',
      example_vi = 'Cứ mỗi dịp ngày Nhà giáo, các bạn học sinh đều gửi tặng hoa tươi và viết những tấm thiệp chúc mừng chân thành gửi tới thầy cô giáo kính yêu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亲爱',
      'qīn’ài',
      'thân ái, yêu quý, thân yêu',
      'Tính từ',
      'HSK 5',
      '每逢教师节，同学们都会给亲爱的老师送上鲜花并写下真挚的祝福卡片。',
      'Měi féng Jiàoshījié, tóngxuémen dōu huì gěi qīn’ài de lǎoshī sòng shàng xiānhuā bìng xiě xià zhēnzhì de zhùfú kǎpiàn.',
      'Cứ mỗi dịp ngày Nhà giáo, các bạn học sinh đều gửi tặng hoa tươi và viết những tấm thiệp chúc mừng chân thành gửi tới thầy cô giáo kính yêu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每逢教师节，同学们都会给亲爱的老师送上鲜花并写下真挚的祝福卡片。', 'Měi féng Jiàoshījié, tóngxuémen dōu huì gěi qīn’ài de lǎoshī sòng shàng xiānhuā bìng xiě xià zhēnzhì de zhùfú kǎpiàn.', 'Cứ mỗi dịp ngày Nhà giáo, các bạn học sinh đều gửi tặng hoa tươi và viết những tấm thiệp chúc mừng chân thành gửi tới thầy cô giáo kính yêu.', 'basic', 1),
      (v_id, '在百年校庆庆典致辞中，校长深情缅怀了为学校建设倾注毕生心血的亲爱先辈师生们。', 'Zài bǎinián xiàoqìng qìngdiǎn zhìcí zhōng, xiàozhǎng shēnqíng miǎnhuái le wèi xuéxiào jiànshè qīngzhù bìshēng xīnxuè de qīn’ài xiānbèi shīshēngmen.', 'Trong bài diễn văn lễ kỷ niệm 100 năm thành lập trường, hiệu trưởng đã xúc động tưởng nhớ các bậc tiền bối thầy trò thân yêu đã dốc cạn tâm huyết cả đời cho công cuộc xây dựng nhà trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2880] [亲朋好友] (qīnpéng-hǎoyǒu) - bà con bạn bè, người thân bạn hữu [Cụm từ cố định]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亲朋好友' AND pinyin = 'qīnpéng-hǎoyǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲朋好友' AND pinyin = 'qīnpéng-hǎoyǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亲朋好友'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲朋好友'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Cụm từ cố định',
      pinyin = 'qīnpéng-hǎoyǒu',
      meaning_vi = 'bà con bạn bè, người thân bạn hữu',
      example_hanzi = '农历新年除夕夜，大家与亲朋好友欢聚一堂，共享丰盛温馨的年夜饭。',
      example_pinyin = 'Nónglì xīnnián chúxī yè, dàjiā yǔ qīnpéng-hǎoyǒu huānjù yì táng, gòngxiǎng fēngshèng wēnxīn de niányèfàn.',
      example_vi = 'Đêm giao thừa Tết Âm lịch, mọi người vui vẻ quây quần cùng người thân bạn bè, cùng nhau thưởng thức bữa cơm tất niên ấm áp thịnh soạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亲朋好友',
      'qīnpéng-hǎoyǒu',
      'bà con bạn bè, người thân bạn hữu',
      'Cụm từ cố định',
      'HSK 5',
      '农历新年除夕夜，大家与亲朋好友欢聚一堂，共享丰盛温馨的年夜饭。',
      'Nónglì xīnnián chúxī yè, dàjiā yǔ qīnpéng-hǎoyǒu huānjù yì táng, gòngxiǎng fēngshèng wēnxīn de niányèfàn.',
      'Đêm giao thừa Tết Âm lịch, mọi người vui vẻ quây quần cùng người thân bạn bè, cùng nhau thưởng thức bữa cơm tất niên ấm áp thịnh soạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '农历新年除夕夜，大家与亲朋好友欢聚一堂，共享丰盛温馨的年夜饭。', 'Nónglì xīnnián chúxī yè, dàjiā yǔ qīnpéng-hǎoyǒu huānjù yì táng, gòngxiǎng fēngshèng wēnxīn de niányèfàn.', 'Đêm giao thừa Tết Âm lịch, mọi người vui vẻ quây quần cùng người thân bạn bè, cùng nhau thưởng thức bữa cơm tất niên ấm áp thịnh soạn.', 'basic', 1),
      (v_id, '在新人庄重典雅的婚礼现场，来自各地的亲朋好友纷纷送上真挚美好的新婚祝愿。', 'Zài xīnrén zhuāngzhòng diǎnyǎ de hūnlǐ xiànchǎng, láizì gèdì de qīnpéng-hǎoyǒu fēnfēn sòng shàng zhēnzhì měihǎo de xīnhūn zhùyuàn.', 'Tại hiện trường hôn lễ trang trọng nhã nhặn của đôi tân nhân, bạn bè người thân từ khắp nơi tấp nập gửi gắm những lời chúc phúc tân hôn chân thành và tốt đẹp nhất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2881] [亲切] (qīnqiè) - thân thiết, niềm nở, ân cần [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亲切' AND pinyin = 'qīnqiè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲切' AND pinyin = 'qīnqiè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亲切'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲切'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'qīnqiè',
      meaning_vi = 'thân thiết, niềm nở, ân cần',
      example_hanzi = '老校长脸上带着亲切和蔼的笑容，耐心地倾听新老师的心声。',
      example_pinyin = 'Lǎo xiàozhǎng liǎn shang dài zhe qīnqiè hé’ǎi de xiàoróng, nàixīn de qīngtīng xīn lǎoshī de xīnshēng.',
      example_vi = 'Trên gương mặt vị hiệu trưởng già nở nụ cười ân cần đôn hậu, kiên nhẫn lắng nghe tâm tư của các giáo viên mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亲切',
      'qīnqiè',
      'thân thiết, niềm nở, ân cần',
      'Tính từ',
      'HSK 5',
      '老校长脸上带着亲切和蔼的笑容，耐心地倾听新老师的心声。',
      'Lǎo xiàozhǎng liǎn shang dài zhe qīnqiè hé’ǎi de xiàoróng, nàixīn de qīngtīng xīn lǎoshī de xīnshēng.',
      'Trên gương mặt vị hiệu trưởng già nở nụ cười ân cần đôn hậu, kiên nhẫn lắng nghe tâm tư của các giáo viên mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老校长脸上带着亲切和蔼的笑容，耐心地倾听新老师的心声。', 'Lǎo xiàozhǎng liǎn shang dài zhe qīnqiè hé’ǎi de xiàoróng, nàixīn de qīngtīng xīn lǎoshī de xīnshēng.', 'Trên gương mặt vị hiệu trưởng già nở nụ cười ân cần đôn hậu, kiên nhẫn lắng nghe tâm tư của các giáo viên mới.', 'basic', 1),
      (v_id, '基层社区工作人员用亲切朴实、通俗易懂的家常语言，向老年居民细致讲解养老保险新政策的具体受惠流程。', 'Jīcéng shèqū gōngzuò rényuán yòng qīnqiè pǔshí, tōngsú-yìdǒng de jiācháng yǔyán, xiàng lǎonián jūmín xìzhì jiǎngjiě yǎnglǎo bǎoxiǎn xīn zhèngcè de jùtǐ shòuhuì liúchéng.', 'Nhân viên công tác cộng đồng cơ sở dùng ngôn ngữ gần gũi mộc mạc, dễ hiểu đời thường để giải thích cặn kẽ cho các cư dân cao tuổi về quy trình thụ hưởng cụ thể của chính sách bảo hiểm dưỡng lão mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2882] [亲情] (qīnqíng) - tình thân, tình ruột thịt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亲情' AND pinyin = 'qīnqíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲情' AND pinyin = 'qīnqíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亲情'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲情'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qīnqíng',
      meaning_vi = 'tình thân, tình ruột thịt',
      example_hanzi = '无论我们走得多远，家人之间血浓于水的深厚亲情永远不会改变。',
      example_pinyin = 'Wúlùn wǒmen zǒu de duō yuǎn, jiārén zhījiān xuè nóng yú shuǐ de shēnhòu qīnqíng yǒngyuǎn bú huì gǎibiàn.',
      example_vi = 'Bất luận chúng ta có đi xa đến đâu, tình thân ruột thịt sâu nặng như giọt máu đào hơn ao nước lã giữa người nhà sẽ mãi mãi không bao giờ đổi thay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亲情',
      'qīnqíng',
      'tình thân, tình ruột thịt',
      'Danh từ',
      'HSK 5',
      '无论我们走得多远，家人之间血浓于水的深厚亲情永远不会改变。',
      'Wúlùn wǒmen zǒu de duō yuǎn, jiārén zhījiān xuè nóng yú shuǐ de shēnhòu qīnqíng yǒngyuǎn bú huì gǎibiàn.',
      'Bất luận chúng ta có đi xa đến đâu, tình thân ruột thịt sâu nặng như giọt máu đào hơn ao nước lã giữa người nhà sẽ mãi mãi không bao giờ đổi thay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论我们走得多远，家人之间血浓于水的深厚亲情永远不会改变。', 'Wúlùn wǒmen zǒu de duō yuǎn, jiārén zhījiān xuè nóng yú shuǐ de shēnhòu qīnqíng yǒngyuǎn bú huì gǎibiàn.', 'Bất luận chúng ta có đi xa đến đâu, tình thân ruột thịt sâu nặng như giọt máu đào hơn ao nước lã giữa người nhà sẽ mãi mãi không bao giờ đổi thay.', 'basic', 1),
      (v_id, '现代快节奏的都市生活虽然压缩了物理陪伴时间，但维系健康亲情依然是构建家庭心理支持防线的核心锚点。', 'Xiàndài kuài-jiézòu de dūshì shēnghuó suīrán yāsuō le wùlǐ péibàn shíjiān, dàn wéixì jiànkāng qīnqíng yīrán shì gòujiàn jiātíng xīnlǐ zhīchí fángxiàn de héxīn máodiǎn.', 'Nhịp sống đô thị gấp gáp hiện đại tuy đã thu hẹp thời gian ở bên nhau ngoài đời thực, nhưng gìn giữ tình thân lành mạnh vẫn là điểm tựa cốt lõi để xây dựng lá chắn hỗ trợ tâm lý gia đình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2883] [亲人] (qīnrén) - người thân, người ruột thịt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亲人' AND pinyin = 'qīnrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲人' AND pinyin = 'qīnrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亲人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qīnrén',
      meaning_vi = 'người thân, người ruột thịt',
      example_hanzi = '在火车站出站口，他远远看到了前来迎接自己的父母亲人。',
      example_pinyin = 'Zài huǒchēzhàn chūzhànkǒu, tā yuǎnyuǎn kàn dào le qiánlái yíngjiē zìjǐ de fùmǔ qīnrén.',
      example_vi = 'Ở cửa ra ga xe lửa, anh ấy từ xa đã nhìn thấy bố mẹ và người thân đến đón mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亲人',
      'qīnrén',
      'người thân, người ruột thịt',
      'Danh từ',
      'HSK 5',
      '在火车站出站口，他远远看到了前来迎接自己的父母亲人。',
      'Zài huǒchēzhàn chūzhànkǒu, tā yuǎnyuǎn kàn dào le qiánlái yíngjiē zìjǐ de fùmǔ qīnrén.',
      'Ở cửa ra ga xe lửa, anh ấy từ xa đã nhìn thấy bố mẹ và người thân đến đón mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在火车站出站口，他远远看到了前来迎接自己的父母亲人。', 'Zài huǒchēzhàn chūzhànkǒu, tā yuǎnyuǎn kàn dào le qiánlái yíngjiē zìjǐ de fùmǔ qīnrén.', 'Ở cửa ra ga xe lửa, anh ấy từ xa đã nhìn thấy bố mẹ và người thân đến đón mình.', 'basic', 1),
      (v_id, '在抗洪救灾一线，广大官兵不畏艰险勇挑重担，被受灾群众深情地赞誉为最可信赖的人民子弟兵和至爱亲人。', 'Zài kànghóng jiùzāi yíxiàn, guǎngdà guānbīng búwèi-jiānxiǎn yǒng tiāo zhòngdàn, bèi shòuzāi qúnzhòng shēnqíng de zànyù wèi zuì kě xìnlài de rénmín zǐdìbīng hé zhì’ài qīnrén.', 'Tại tuyến đầu chống lũ cứu nạn, đông đảo cán bộ chiến sĩ không quản ngại gian khổ dũng cảm gánh vác trọng trách, được quần chúng vùng thiên tai trìu mến ca ngợi là bộ đội con em nhân dân đáng tin cậy nhất và là người thân ruột thịt yêu quý nhất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2884] [亲自] (qīnzì) - đích thân, tự mình [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亲自' AND pinyin = 'qīnzì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲自' AND pinyin = 'qīnzì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亲自'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亲自'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'qīnzì',
      meaning_vi = 'đích thân, tự mình',
      example_hanzi = '总经理今天亲自到车间视察新生产线的调试运行情况。',
      example_pinyin = 'Zǒngjīnglǐ jīntiān qīnzì dào chējiān shìchá xīn shēngchǎnxiàn de tiáoshì yùnxíng qíngkuàng.',
      example_vi = 'Tổng giám đốc hôm nay đã đích thân xuống phân xưởng thị sát tình hình vận hành căn chỉnh của dây chuyền sản xuất mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亲自',
      'qīnzì',
      'đích thân, tự mình',
      'Phó từ',
      'HSK 5',
      '总经理今天亲自到车间视察新生产线的调试运行情况。',
      'Zǒngjīnglǐ jīntiān qīnzì dào chējiān shìchá xīn shēngchǎnxiàn de tiáoshì yùnxíng qíngkuàng.',
      'Tổng giám đốc hôm nay đã đích thân xuống phân xưởng thị sát tình hình vận hành căn chỉnh của dây chuyền sản xuất mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '总经理今天亲自到车间视察新生产线的调试运行情况。', 'Zǒngjīnglǐ jīntiān qīnzì dào chējiān shìchá xīn shēngchǎnxiàn de tiáoshì yùnxíng qíngkuàng.', 'Tổng giám đốc hôm nay đã đích thân xuống phân xưởng thị sát tình hình vận hành căn chỉnh của dây chuyền sản xuất mới.', 'basic', 1),
      (v_id, '项目总设计师亲自主持多轮系统架构可行性评审会，确保每一项技术指标均达到国际尖端标准。', 'Xiàngmù zǒngshèjìshī qīnzì zhǔchí duō lún xìtǒng jiàgòu kěxíngxìng píngshěnhuì, quèbǎo měi yì xiàng jìshù zhǐbiāo jūn dádào guójì jiānduān biāozhǔn.', 'Tổng công trình sư dự án đã đích thân chủ trì nhiều vòng hội nghị thẩm định tính khả thi của kiến trúc hệ thống, bảo đảm mọi chỉ tiêu kỹ thuật đều đạt tiêu chuẩn tiên tiến quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2885] [勤奋] (qínfèn) - cần cù, siêng năng, cần mẫn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '勤奋' AND pinyin = 'qínfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '勤奋' AND pinyin = 'qínfèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '勤奋'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '勤奋'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'qínfèn',
      meaning_vi = 'cần cù, siêng năng, cần mẫn',
      example_hanzi = '天才出于勤奋，不付出辛勤的汗水是很难取得优异成绩的。',
      example_pinyin = 'Tiāncái chūyú qínfèn, bù fùchū xīnqín de hànshuǐ shì hěn nán qǔdé yōuyì chéngjì de.',
      example_vi = 'Thiên tài bắt nguồn từ cần cù, không bỏ ra những giọt mồ hôi công sức thì rất khó gặt hái được thành tích xuất sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '勤奋',
      'qínfèn',
      'cần cù, siêng năng, cần mẫn',
      'Tính từ',
      'HSK 5',
      '天才出于勤奋，不付出辛勤的汗水是很难取得优异成绩的。',
      'Tiāncái chūyú qínfèn, bù fùchū xīnqín de hànshuǐ shì hěn nán qǔdé yōuyì chéngjì de.',
      'Thiên tài bắt nguồn từ cần cù, không bỏ ra những giọt mồ hôi công sức thì rất khó gặt hái được thành tích xuất sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天才出于勤奋，不付出辛勤的汗水是很难取得优异成绩的。', 'Tiāncái chūyú qínfèn, bù fùchū xīnqín de hànshuǐ shì hěn nán qǔdé yōuyì chéngjì de.', 'Thiên tài bắt nguồn từ cần cù, không bỏ ra những giọt mồ hôi công sức thì rất khó gặt hái được thành tích xuất sắc.', 'basic', 1),
      (v_id, '青年科研工作者秉承勤奋严谨、求真务实的治学风骨，夜以继日地在基础前沿学科领域潜心耕耘。', 'Qīngnián kēyán gōngzuòzhě bǐngchéng qínfèn yánjǐn, qiúzhēn-wùshí de zhìxué fēnggǔ, yèyǐjìrì de zài jīchǔ qiányán xuékē lǐngyù qiánxīn gēngyún.', 'Các nhà nghiên cứu khoa học trẻ kế thừa khí phách học thuật cần cù nghiêm cẩn và cầu thị thực chất, miệt mài đêm ngày dày công cày cuốc trên mảnh đất các ngành khoa học cơ bản mũi nhọn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2886] [青] (qīng) - xanh (lá, biếc), thanh xuân [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '青' AND pinyin = 'qīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '青' AND pinyin = 'qīng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '青'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '青'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'qīng',
      meaning_vi = 'xanh (lá, biếc), thanh xuân',
      example_hanzi = '春天来了，山坡上的小草脱下了枯黄的外衣，换上了一身嫩青色。',
      example_pinyin = 'Chūntiān lái le, shānpō shang de xiǎocǎo tuō xià le kūhuáng de wàiyī, huàn shàng le yì shēn nènqīngsè.',
      example_vi = 'Mùa xuân đã đến, cỏ non trên sườn núi cởi bỏ tấm áo vàng úa, khoác lên mình một sắc xanh non mơn mởn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '青',
      'qīng',
      'xanh (lá, biếc), thanh xuân',
      'Tính từ',
      'HSK 5',
      '春天来了，山坡上的小草脱下了枯黄的外衣，换上了一身嫩青色。',
      'Chūntiān lái le, shānpō shang de xiǎocǎo tuō xià le kūhuáng de wàiyī, huàn shàng le yì shēn nènqīngsè.',
      'Mùa xuân đã đến, cỏ non trên sườn núi cởi bỏ tấm áo vàng úa, khoác lên mình một sắc xanh non mơn mởn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春天来了，山坡上的小草脱下了枯黄的外衣，换上了一身嫩青色。', 'Chūntiān lái le, shānpō shang de xiǎocǎo tuō xià le kūhuáng de wàiyī, huàn shàng le yì shēn nènqīngsè.', 'Mùa xuân đã đến, cỏ non trên sườn núi cởi bỏ tấm áo vàng úa, khoác lên mình một sắc xanh non mơn mởn.', 'basic', 1),
      (v_id, '以“绿水青山就是金山银山”理念为统领，该地区大力发展生态旅游与绿色循环经济，实现了生态效益与经济效益双赢。', 'Yǐ “lǜshuǐ-qīngshān jiùshì jīnshān-yínshān” lǐniàn wéi tǒnglǐng, gāi dìqū dàlì fāzhǎn shēngtài lǚyóu yǔ lǜsè xúnhuán jīngjì, shíxiàn le shēngtài xiàoyì yǔ jīngjì xiàoyì shuāngyíng.', 'Lấy quan niệm "non xanh nước biếc chính là núi vàng núi bạc" làm kim chỉ nam, địa phương này đã đẩy mạnh phát triển du lịch sinh thái và kinh tế tuần hoàn xanh, thực hiện thắng lợi kép về cả hiệu quả sinh thái và hiệu quả kinh tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2887] [轻易] (qīngyì) - dễ dàng, khinh suất, tùy tiện [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '轻易' AND pinyin = 'qīngyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '轻易' AND pinyin = 'qīngyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '轻易'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '轻易'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Tính từ',
      pinyin = 'qīngyì',
      meaning_vi = 'dễ dàng, khinh suất, tùy tiện',
      example_hanzi = '在遇到挫折时，我们绝对不能轻易放弃最初的理想。',
      example_pinyin = 'Zài yùdào cuòzhé shí, wǒmen juéduì bù néng qīngyì fàngqì zuìchū de lǐxiǎng.',
      example_vi = 'Khi gặp phải khó khăn trắc trở, chúng ta tuyệt đối không được dễ dàng từ bỏ lý tưởng ban đầu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '轻易',
      'qīngyì',
      'dễ dàng, khinh suất, tùy tiện',
      'Phó từ / Tính từ',
      'HSK 5',
      '在遇到挫折时，我们绝对不能轻易放弃最初的理想。',
      'Zài yùdào cuòzhé shí, wǒmen juéduì bù néng qīngyì fàngqì zuìchū de lǐxiǎng.',
      'Khi gặp phải khó khăn trắc trở, chúng ta tuyệt đối không được dễ dàng từ bỏ lý tưởng ban đầu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在遇到挫折时，我们绝对不能轻易放弃最初的理想。', 'Zài yùdào cuòzhé shí, wǒmen juéduì bù néng qīngyì fàngqì zuìchū de lǐxiǎng.', 'Khi gặp phải khó khăn trắc trở, chúng ta tuyệt đối không được dễ dàng từ bỏ lý tưởng ban đầu.', 'basic', 1),
      (v_id, '在未经全面充分的临床验证与同行评议前，任何前沿医学发现都不应轻易应用于普遍临床推广。', 'Zài wèijīng quánmiàn chōngfèn de línchuáng yànzhèng yǔ tóngháng píngyì qián, rènhé qiányán yīxué fāxiàn dōu bù yīng qīngyì yìngyòng yú pǔbiàn línchuáng tuīguǎng.', 'Trước khi trải qua thẩm định đồng nghiệp và kiểm chứng lâm sàng đầy đủ toàn diện, không một phát hiện y học mũi nhọn nào nên khinh suất đem ra áp dụng phổ quát trong lâm sàng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2888] [轻重] (qīngzhòng) - độ nặng nhẹ, mức độ nghiêm trọng, sự nông sâu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '轻重' AND pinyin = 'qīngzhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '轻重' AND pinyin = 'qīngzhòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '轻重'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '轻重'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qīngzhòng',
      meaning_vi = 'độ nặng nhẹ, mức độ nghiêm trọng, sự nông sâu',
      example_hanzi = '医生在给病人包扎伤口时，手上的轻重拿捏得恰到好处。',
      example_pinyin = 'Yīshēng zài gěi bìngrén bāozā shāngkǒu shí, shǒu shang de qīngzhòng nániē de qiàdào-hǎochù.',
      example_vi = 'Khi bác sĩ băng bó vết thương cho bệnh nhân, lực tay mạnh nhẹ được điều chỉnh vừa vặn khéo léo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '轻重',
      'qīngzhòng',
      'độ nặng nhẹ, mức độ nghiêm trọng, sự nông sâu',
      'Danh từ',
      'HSK 5',
      '医生在给病人包扎伤口时，手上的轻重拿捏得恰到好处。',
      'Yīshēng zài gěi bìngrén bāozā shāngkǒu shí, shǒu shang de qīngzhòng nániē de qiàdào-hǎochù.',
      'Khi bác sĩ băng bó vết thương cho bệnh nhân, lực tay mạnh nhẹ được điều chỉnh vừa vặn khéo léo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医生在给病人包扎伤口时，手上的轻重拿捏得恰到好处。', 'Yīshēng zài gěi bìngrén bāozā shāngkǒu shí, shǒu shang de qīngzhòng nániē de qiàdào-hǎochù.', 'Khi bác sĩ băng bó vết thương cho bệnh nhân, lực tay mạnh nhẹ được điều chỉnh vừa vặn khéo léo.', 'basic', 1),
      (v_id, '优秀的行政管理者必须分清轻重缓急，合理配置资源，确保全局关键节点的战略任务优先落地。', 'Yōuxiù de xíngzhèng guǎnlǐzhě bìxū fēnqīng qīngzhòng-huǎnjí, hélǐ pèizhì zīyuán, quèbǎo quánjú guānjiàn jiédiǎn de zhànlüè rènwù yōuxiān luòdì.', 'Nhà quản lý hành chính xuất sắc bắt buộc phải phân định rõ mức độ quan trọng khẩn cấp nhẹ nặng, phân bổ tài nguyên hợp lý, bảo đảm các nhiệm vụ chiến lược tại các nút thắt then chốt của toàn cục được ưu tiên triển khai thực tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2889] [情感] (qínggǎn) - tình cảm, xúc cảm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '情感' AND pinyin = 'qínggǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '情感' AND pinyin = 'qínggǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '情感'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '情感'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qínggǎn',
      meaning_vi = 'tình cảm, xúc cảm',
      example_hanzi = '这首优美动听的钢琴曲蕴含着作曲家对故乡无比深厚的情感。',
      example_pinyin = 'Zhè shǒu yōuměi dòngtīng de gāngqínqǔ yùnhán zhe zuòqǔjiā duì gùxiāng wúbǐ shēnhòu de qínggǎn.',
      example_vi = 'Bản nhạc dương cầm êm dịu du dương này chứa đựng tình cảm vô cùng sâu nặng của nhà soạn nhạc đối với quê hương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '情感',
      'qínggǎn',
      'tình cảm, xúc cảm',
      'Danh từ',
      'HSK 5',
      '这首优美动听的钢琴曲蕴含着作曲家对故乡无比深厚的情感。',
      'Zhè shǒu yōuměi dòngtīng de gāngqínqǔ yùnhán zhe zuòqǔjiā duì gùxiāng wúbǐ shēnhòu de qínggǎn.',
      'Bản nhạc dương cầm êm dịu du dương này chứa đựng tình cảm vô cùng sâu nặng của nhà soạn nhạc đối với quê hương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这首优美动听的钢琴曲蕴含着作曲家对故乡无比深厚的情感。', 'Zhè shǒu yōuměi dòngtīng de gāngqínqǔ yùnhán zhe zuòqǔjiā duì gùxiāng wúbǐ shēnhòu de qínggǎn.', 'Bản nhạc dương cầm êm dịu du dương này chứa đựng tình cảm vô cùng sâu nặng của nhà soạn nhạc đối với quê hương.', 'basic', 1),
      (v_id, '在多模态人机交互设计中，构建具备情感计算与共情理解能力的人工智能系统已成为行业前沿课题。', 'Zài duō-mótài rénjī jiāohù shèjì zhōng, gòujiàn jùbèi qínggǎn jìsuàn yǔ gòngqíng lǐjiě nénglì de réngōng zhìnéng xìtǒng yǐ chéngwéi hángyè qiányán kètí.', 'Trong thiết kế tương tác người-máy đa phương thức, việc xây dựng hệ thống trí tuệ nhân tạo có năng lực tính toán cảm xúc và thấu cảm đồng cảm đã trở thành đề tài mũi nhọn của ngành.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2890] [情景] (qíngjǐng) - cảnh tượng, tình cảnh, quang cảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '情景' AND pinyin = 'qíngjǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '情景' AND pinyin = 'qíngjǐng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '情景'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '情景'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qíngjǐng',
      meaning_vi = 'cảnh tượng, tình cảnh, quang cảnh',
      example_hanzi = '童年时和小伙伴在乡间田野捉蟋蟀的情景，至今依然历历在目。',
      example_pinyin = 'Tóngnián shí hé xiǎohuǒbàn zài xiāngjiān tiányě zhuō xīshuài de qíngjǐng, zhìjīn yīrán lìlì-zài-mù.',
      example_vi = 'Cảnh tượng thời thơ ấu cùng các bạn nhỏ bắt dế trên đồng ruộng quê hương đến nay vẫn còn hiện rõ mồn một trước mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '情景',
      'qíngjǐng',
      'cảnh tượng, tình cảnh, quang cảnh',
      'Danh từ',
      'HSK 5',
      '童年时和小伙伴在乡间田野捉蟋蟀的情景，至今依然历历在目。',
      'Tóngnián shí hé xiǎohuǒbàn zài xiāngjiān tiányě zhuō xīshuài de qíngjǐng, zhìjīn yīrán lìlì-zài-mù.',
      'Cảnh tượng thời thơ ấu cùng các bạn nhỏ bắt dế trên đồng ruộng quê hương đến nay vẫn còn hiện rõ mồn một trước mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '童年时和小伙伴在乡间田野捉蟋蟀的情景，至今依然历历在目。', 'Tóngnián shí hé xiǎohuǒbàn zài xiāngjiān tiányě zhuō xīshuài de qíngjǐng, zhìjīn yīrán lìlì-zài-mù.', 'Cảnh tượng thời thơ ấu cùng các bạn nhỏ bắt dế trên đồng ruộng quê hương đến nay vẫn còn hiện rõ mồn một trước mắt.', 'basic', 1),
      (v_id, '语言外语教学普遍倡导沉浸式真实情景模拟，通过生活化与职场化语境有效提升学习者的实际言语交际效能。', 'Yǔyán wàiyǔ jiàoxué pǔbiàn chàngdǎo chénjìnrù shì zhēnshí qíngjǐng mónǐ, tōngguò shēnghuóhuà yǔ zhíchǎnghuà yǔjìng yǒuxiào tíshēng xuéxízhě de shíjì yányǔ jiāojì xiàonéng.', 'Giảng dạy ngoại ngữ nói chung luôn cổ vũ mô phỏng tình cảnh thực tế dạng đắm chìm, thông qua ngữ cảnh đời sống hóa và nơi làm việc để nâng cao hiệu quả giao tiếp ngôn ngữ thực tế của người học một cách hữu hiệu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2891] [情绪] (qíngxù) - tâm trạng, cảm xúc, tinh thần [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '情绪' AND pinyin = 'qíngxù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '情绪' AND pinyin = 'qíngxù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '情绪'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '情绪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qíngxù',
      meaning_vi = 'tâm trạng, cảm xúc, tinh thần',
      example_hanzi = '感到压力很大时，听听轻柔的音乐有助于舒缓紧张的情绪。',
      example_pinyin = 'Gǎndào yālì hěn dà shí, tīngting qīngróu de yīnyuè yǒuzhùyú shūhuǎn jǐnzhāng de qíngxù.',
      example_vi = 'Khi cảm thấy áp lực lớn, nghe một chút âm nhạc nhẹ nhàng sẽ giúp xoa dịu tâm trạng căng thẳng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '情绪',
      'qíngxù',
      'tâm trạng, cảm xúc, tinh thần',
      'Danh từ',
      'HSK 5',
      '感到压力很大时，听听轻柔的音乐有助于舒缓紧张的情绪。',
      'Gǎndào yālì hěn dà shí, tīngting qīngróu de yīnyuè yǒuzhùyú shūhuǎn jǐnzhāng de qíngxù.',
      'Khi cảm thấy áp lực lớn, nghe một chút âm nhạc nhẹ nhàng sẽ giúp xoa dịu tâm trạng căng thẳng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '感到压力很大时，听听轻柔的音乐有助于舒缓紧张的情绪。', 'Gǎndào yālì hěn dà shí, tīngting qīngróu de yīnyuè yǒuzhùyú shūhuǎn jǐnzhāng de qíngxù.', 'Khi cảm thấy áp lực lớn, nghe một chút âm nhạc nhẹ nhàng sẽ giúp xoa dịu tâm trạng căng thẳng.', 'basic', 1),
      (v_id, '在高度波动的资本市场中，成熟的基金经理必须保持理性客观的研判，有效克服追涨杀跌的群体恐慌情绪。', 'Zài gāodù bōdòng de zīběn shìchǎng zhōng, chéngshú de jījīn jīnglǐ bìxū bǎochí lǐxìng kèguān de yánpàn, yǒuxiào kèfú zhuīzhǎng-shādiē de qúntǐ kǒnghuāng qíngxù.', 'Trong thị trường vốn biến động cao độ, một nhà quản lý quỹ trưởng thành bắt buộc phải duy trì nhận định khách quan lý tính, khắc phục hữu hiệu cảm xúc hoảng loạn đám đông mua đỉnh bán đáy.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2892] [请教] (qǐngjiào) - thỉnh giáo, xin chỉ dạy, hỏi ý kiến [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '请教' AND pinyin = 'qǐngjiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '请教' AND pinyin = 'qǐngjiào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '请教'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '请教'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qǐngjiào',
      meaning_vi = 'thỉnh giáo, xin chỉ dạy, hỏi ý kiến',
      example_hanzi = '遇到不懂的难题时，我们应当虚心地向老师和成绩优秀的同学请教。',
      example_pinyin = 'Yùdào bù dǒng de nántí shí, wǒmen yīngdāng xūxīn de xiàng lǎoshī hé chéngjì yōuxiù de tóngxué qǐngjiào.',
      example_vi = 'Khi gặp câu hỏi khó không hiểu, chúng ta nên khiêm tốn thỉnh giáo thầy cô giáo và những bạn học có thành tích xuất sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '请教',
      'qǐngjiào',
      'thỉnh giáo, xin chỉ dạy, hỏi ý kiến',
      'Động từ',
      'HSK 5',
      '遇到不懂的难题时，我们应当虚心地向老师和成绩优秀的同学请教。',
      'Yùdào bù dǒng de nántí shí, wǒmen yīngdāng xūxīn de xiàng lǎoshī hé chéngjì yōuxiù de tóngxué qǐngjiào.',
      'Khi gặp câu hỏi khó không hiểu, chúng ta nên khiêm tốn thỉnh giáo thầy cô giáo và những bạn học có thành tích xuất sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '遇到不懂的难题时，我们应当虚心地向老师和成绩优秀的同学请教。', 'Yùdào bù dǒng de nántí shí, wǒmen yīngdāng xūxīn de xiàng lǎoshī hé chéngjì yōuxiù de tóngxué qǐngjiào.', 'Khi gặp câu hỏi khó không hiểu, chúng ta nên khiêm tốn thỉnh giáo thầy cô giáo và những bạn học có thành tích xuất sắc.', 'basic', 1),
      (v_id, '在制定重大区域生态环境保护纲领过程中，地方主管部门主动向两院院士及资深水利专家登门请教。', 'Zài zhìdìng zhòngdà qūyù shēngtài huánbǎo gānglǐng guòchéng zhōng, dìfāng zhǔguǎn bùmén zhǔdòng xiàng liǎngyuàn yuànshì jí zīshēn shuǐlì zhuānjiā dēngmén qǐngjiào.', 'Trong quá trình xây dựng cương lĩnh bảo vệ môi trường sinh thái khu vực trọng điểm, cơ quan chủ quản địa phương đã chủ động tới tận nơi thỉnh giáo các viện sĩ hai viện hàn lâm và chuyên gia thủy lợi kỳ cựu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2893] [请求] (qǐngqiú) - thỉnh cầu, yêu cầu, đề nghị [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '请求' AND pinyin = 'qǐngqiú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '请求' AND pinyin = 'qǐngqiú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '请求'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '请求'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'qǐngqiú',
      meaning_vi = 'thỉnh cầu, yêu cầu, đề nghị',
      example_hanzi = '他向公司提出了延长一周假期的书面请求，希望能留在家中照顾生病的母亲。',
      example_pinyin = 'Tā xiàng gōngsī tíchū le yáncháng yì zhōu jiàqī de shūmiàn qǐngqiú, xīwàng néng liú zài jiā zhōng zhàogù shēngbìng de mǔqīn.',
      example_vi = 'Anh ấy đã đệ trình lên công ty đơn xin bằng văn bản yêu cầu kéo dài kỳ nghỉ thêm một tuần, hy vọng có thể ở nhà chăm sóc mẹ ốm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '请求',
      'qǐngqiú',
      'thỉnh cầu, yêu cầu, đề nghị',
      'Động từ / Danh từ',
      'HSK 5',
      '他向公司提出了延长一周假期的书面请求，希望能留在家中照顾生病的母亲。',
      'Tā xiàng gōngsī tíchū le yáncháng yì zhōu jiàqī de shūmiàn qǐngqiú, xīwàng néng liú zài jiā zhōng zhàogù shēngbìng de mǔqīn.',
      'Anh ấy đã đệ trình lên công ty đơn xin bằng văn bản yêu cầu kéo dài kỳ nghỉ thêm một tuần, hy vọng có thể ở nhà chăm sóc mẹ ốm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他向公司提出了延长一周假期的书面请求，希望能留在家中照顾生病的母亲。', 'Tā xiàng gōngsī tíchū le yáncháng yì zhōu jiàqī de shūmiàn qǐngqiú, xīwàng néng liú zài jiā zhōng zhàogù shēngbìng de mǔqīn.', 'Anh ấy đã đệ trình lên công ty đơn xin bằng văn bản yêu cầu kéo dài kỳ nghỉ thêm một tuần, hy vọng có thể ở nhà chăm sóc mẹ ốm.', 'basic', 1),
      (v_id, '因突遇不可抗力导致的供应链中断，签约供应商依据商法典有关免责条款正式向仲裁庭提出延期履约请求。', 'Yīn tū yù bùkěkànglì dǎozhì de gōngyìngliàn zhōngduàn, qiānyuē gōngyìngshāng yījù shāngfǎdiǎn yǒuguān miǎnzé tiáokuǎn zhèngshì xiàng zhòngcáitíng tíchū yánqī lǚyuē qǐngqiú.', 'Do sự cố bất khả kháng bất ngờ làm gián đoạn chuỗi cung ứng, nhà cung cấp ký hợp đồng đã căn cứ vào các điều khoản miễn trừ trách nhiệm của luật thương mại để chính thức đệ trình yêu cầu gia hạn thực hiện nghĩa vụ lên hội đồng trọng tài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2894] [穷] (qióng) - nghèo, cùng kiệt, cạn kiệt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '穷' AND pinyin = 'qióng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '穷' AND pinyin = 'qióng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '穷'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '穷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'qióng',
      meaning_vi = 'nghèo, cùng kiệt, cạn kiệt',
      example_hanzi = '虽然过去的家境十分贫穷，但他始终坚强自立，从未放弃读书求学的志向。',
      example_pinyin = 'Suīrán guòqù de jiājìng shífēn pínqióng, dàn tā shǐzhōng jiānqiáng zìlì, cóngwèi fàngqì dúshū qiúxué de zhìxiàng.',
      example_vi = 'Mặc dù hoàn cảnh gia đình ngày trước vô cùng nghèo khó, nhưng anh ấy luôn tự lập kiên cường, chưa từng từ bỏ chí hướng đọc sách học hành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '穷',
      'qióng',
      'nghèo, cùng kiệt, cạn kiệt',
      'Tính từ',
      'HSK 5',
      '虽然过去的家境十分贫穷，但他始终坚强自立，从未放弃读书求学的志向。',
      'Suīrán guòqù de jiājìng shífēn pínqióng, dàn tā shǐzhōng jiānqiáng zìlì, cóngwèi fàngqì dúshū qiúxué de zhìxiàng.',
      'Mặc dù hoàn cảnh gia đình ngày trước vô cùng nghèo khó, nhưng anh ấy luôn tự lập kiên cường, chưa từng từ bỏ chí hướng đọc sách học hành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '虽然过去的家境十分贫穷，但他始终坚强自立，从未放弃读书求学的志向。', 'Suīrán guòqù de jiājìng shífēn pínqióng, dàn tā shǐzhōng jiānqiáng zìlì, cóngwèi fàngqì dúshū qiúxué de zhìxiàng.', 'Mặc dù hoàn cảnh gia đình ngày trước vô cùng nghèo khó, nhưng anh ấy luôn tự lập kiên cường, chưa từng từ bỏ chí hướng đọc sách học hành.', 'basic', 1),
      (v_id, '国家实施精准扶贫战略，彻底消除绝对贫困现象，让昔日山大沟深的穷乡僻壤迎来了乡村振兴的历史性巨变。', 'Guójiā shíshī jīngzhǔn fúpín zhànlüè, chèdǐ xiāochú juéduì pínkùn xiànxiàng, ràng xīrì shāndà-gōushēn de qióngxiāng-pìrǎng yínglái le xiāngcūn zhènxīng de lìshǐxìng jùbiàn.', 'Nhà nước triển khai chiến lược xóa đói giảm nghèo chuẩn xác, xóa bỏ triệt để hiện tượng nghèo cùng cực, khiến những chốn hẻo lánh nghèo nàn rừng sâu núi thẳm ngày nào đón nhận bước chuyển mình lịch sử của công cuộc phục hưng nông thôn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2895] [趋势] (qūshì) - xu thế, xu hướng, chiều hướng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '趋势' AND pinyin = 'qūshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '趋势' AND pinyin = 'qūshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '趋势'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '趋势'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qūshì',
      meaning_vi = 'xu thế, xu hướng, chiều hướng',
      example_hanzi = '从图表中可以看出，近五年来本市空气质量整体呈现逐年改善的良好趋势。',
      example_pinyin = 'Cóng túbiǎo zhōng kàn chū, jìn wǔ nián lái běn shì kōngqì zhìliàng zhěngtǐ chéngxiàn zhúnián gǎishàn de liánghǎo qūshì.',
      example_vi = 'Từ biểu đồ có thể thấy rằng trong năm năm trở lại đây chất lượng không khí toàn thành phố nhìn chung có xu thế tốt lên rõ rệt qua từng năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '趋势',
      'qūshì',
      'xu thế, xu hướng, chiều hướng',
      'Danh từ',
      'HSK 5',
      '从图表中可以看出，近五年来本市空气质量整体呈现逐年改善的良好趋势。',
      'Cóng túbiǎo zhōng kàn chū, jìn wǔ nián lái běn shì kōngqì zhìliàng zhěngtǐ chéngxiàn zhúnián gǎishàn de liánghǎo qūshì.',
      'Từ biểu đồ có thể thấy rằng trong năm năm trở lại đây chất lượng không khí toàn thành phố nhìn chung có xu thế tốt lên rõ rệt qua từng năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '从图表中可以看出，近五年来本市空气质量整体呈现逐年改善的良好趋势。', 'Cóng túbiǎo zhōng kàn chū, jìn wǔ nián lái běn shì kōngqì zhìliàng zhěngtǐ chéngxiàn zhúnián gǎishàn de liánghǎo qūshì.', 'Từ biểu đồ có thể thấy rằng trong năm năm trở lại đây chất lượng không khí toàn thành phố nhìn chung có xu thế tốt lên rõ rệt qua từng năm.', 'basic', 1),
      (v_id, '产业数字化、绿色低碳化转型与全球价值链重构，构成了当前世界经济中长期不可逆转的宏观发展大趋势。', 'Chǎnyè shùzìhuà, lǜsè dītànhuà zhuǎnxíng yǔ quánqiú jiàzhíliàn chónggòu, gòuchéng le dāngqián shìjiè jīngjì zhōng-chángqī bùkě nìzhuǎn de hóngguān fāzhǎn dà qūshì.', 'Số hóa sản xuất, chuyển đổi xanh ít carbon và tái cấu trúc chuỗi giá trị toàn cầu đã cấu thành đại xu thế phát triển vĩ mô trung dài hạn không thể đảo ngược của kinh tế thế giới hiện nay.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2896] [区域] (qūyù) - khu vực, vùng, miền [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '区域' AND pinyin = 'qūyù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '区域' AND pinyin = 'qūyù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '区域'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '区域'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qūyù',
      meaning_vi = 'khu vực, vùng, miền',
      example_hanzi = '商场在一层专门设立了儿童休闲玩耍的互动体验区域。',
      example_pinyin = 'Shāngchǎng zài yī céng zhuānmén shèlì le értóng xiūxián wánshuǎ de hùdòng tǐyàn qūyù.',
      example_vi = 'Trung tâm thương mại đặc biệt bố trí một khu vực trải nghiệm tương tác dành riêng cho trẻ em vui chơi giải trí ở tầng một.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '区域',
      'qūyù',
      'khu vực, vùng, miền',
      'Danh từ',
      'HSK 5',
      '商场在一层专门设立了儿童休闲玩耍的互动体验区域。',
      'Shāngchǎng zài yī céng zhuānmén shèlì le értóng xiūxián wánshuǎ de hùdòng tǐyàn qūyù.',
      'Trung tâm thương mại đặc biệt bố trí một khu vực trải nghiệm tương tác dành riêng cho trẻ em vui chơi giải trí ở tầng một.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '商场在一层专门设立了儿童休闲玩耍的互动体验区域。', 'Shāngchǎng zài yī céng zhuānmén shèlì le értóng xiūxián wánshuǎ de hùdòng tǐyàn qūyù.', 'Trung tâm thương mại đặc biệt bố trí một khu vực trải nghiệm tương tác dành riêng cho trẻ em vui chơi giải trí ở tầng một.', 'basic', 1),
      (v_id, '推进区域协调发展战略旨在打破行政壁垒，促进要素自由流动与重大公共基础设施互联互通。', 'Tuījìn qūyù xiétóng fāzhǎn zhànlüè zhǐ zài dǎpò xíngzhèng bìlěi, cùjìn yàosù zìyóu liúdòng yǔ zhòngdà gōnggòng jīchǔ shèshī hùlián-hùtōng.', 'Thúc đẩy chiến lược phát triển hiệp đồng giữa các khu vực nhằm mục tiêu xóa bỏ rào cản hành chính, thúc đẩy sự lưu chuyển tự do của các yếu tố nguồn lực và kết nối liên thông hạ tầng cơ sở công cộng trọng điểm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2897] [去世] (qùshì) - qua đời, mất, tạ thế [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '去世' AND pinyin = 'qùshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '去世' AND pinyin = 'qùshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '去世'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '去世'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'qùshì',
      meaning_vi = 'qua đời, mất, tạ thế',
      example_hanzi = '听到这位德高望重的退休老教授因病不幸去世的消息，大家的心情十分沉痛。',
      example_pinyin = 'Tīng dào zhè wèi dégāo-wàngzhòng de tuìxiū lǎo jiàoshòu yīnbìng búxìng qùshì de xiāoxi, dàjiā de xīnqíng shífēn chéntòng.',
      example_vi = 'Khi nghe tin vị giáo sư già về hưu đức cao vọng trọng này không may lâm bệnh qua đời, tâm trạng của mọi người vô cùng đau buồn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '去世',
      'qùshì',
      'qua đời, mất, tạ thế',
      'Động từ',
      'HSK 5',
      '听到这位德高望重的退休老教授因病不幸去世的消息，大家的心情十分沉痛。',
      'Tīng dào zhè wèi dégāo-wàngzhòng de tuìxiū lǎo jiàoshòu yīnbìng búxìng qùshì de xiāoxi, dàjiā de xīnqíng shífēn chéntòng.',
      'Khi nghe tin vị giáo sư già về hưu đức cao vọng trọng này không may lâm bệnh qua đời, tâm trạng của mọi người vô cùng đau buồn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听到这位德高望重的退休老教授因病不幸去世的消息，大家的心情十分沉痛。', 'Tīng dào zhè wèi dégāo-wàngzhòng de tuìxiū lǎo jiàoshòu yīnbìng búxìng qùshì de xiāoxi, dàjiā de xīnqíng shífēn chéntòng.', 'Khi nghe tin vị giáo sư già về hưu đức cao vọng trọng này không may lâm bệnh qua đời, tâm trạng của mọi người vô cùng đau buồn.', 'basic', 1),
      (v_id, '尽管伟大的先驱科学家早已与世长辞，但他倾其一生留存下来的科学精神与经典著作永远铭刻在历史丰碑之上。', 'Jǐnguǎn wěidà de xiānqū kēxuéjiā zǎoyǐ yǔshì-chángcí, dàn tā qīng qí yìshēng liúcún xiàlái de kēxué jīngshén yǔ jīngdiǎn zhùzuò yǒngyuǎn míngkè zài lìshǐ fēngbēi zhī shàng.', 'Dẫu nhà khoa học tiên phong vĩ đại đã tạ thế từ lâu, nhưng tinh thần khoa học và những tác phẩm kinh điển mà người để lại suốt cuộc đời sẽ mãi mãi khắc sâu trên tượng đài lịch sử.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2898] [权] (quán) - quyền, quyền hạn, quyền thế [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '权' AND pinyin = 'quán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '权' AND pinyin = 'quán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '权'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '权'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'quán',
      meaning_vi = 'quyền, quyền hạn, quyền thế',
      example_hanzi = '公民在法律框架内依法享有知情权和表达自己意见的权。',
      example_pinyin = 'Gōngmín zài fǎlǜ kuàngjià nèi yīfǎ xiǎngyǒu zhīqíngquán hé biǎodá zìjǐ yìjiàn de quán.',
      example_vi = 'Công dân trong khuôn khổ pháp luật được hưởng quyền được biết thông tin và quyền bày tỏ ý kiến của bản thân theo luật định.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '权',
      'quán',
      'quyền, quyền hạn, quyền thế',
      'Danh từ',
      'HSK 5',
      '公民在法律框架内依法享有知情权和表达自己意见的权。',
      'Gōngmín zài fǎlǜ kuàngjià nèi yīfǎ xiǎngyǒu zhīqíngquán hé biǎodá zìjǐ yìjiàn de quán.',
      'Công dân trong khuôn khổ pháp luật được hưởng quyền được biết thông tin và quyền bày tỏ ý kiến của bản thân theo luật định.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '公民在法律框架内依法享有知情权和表达自己意见的权。', 'Gōngmín zài fǎlǜ kuàngjià nèi yīfǎ xiǎngyǒu zhīqíngquán hé biǎodá zìjǐ yìjiàn de quán.', 'Công dân trong khuôn khổ pháp luật được hưởng quyền được biết thông tin và quyền bày tỏ ý kiến của bản thân theo luật định.', 'basic', 1),
      (v_id, '必须建立健全权责对等、规范透明的行政监督制约体系，切实把权力关进制度的笼子里。', 'Bìxū jiànlì jiànquán quán-zé duìděng, guīfàn tòumíng de xíngzhèng jiāndū zhìyuē tǐxì, qièshí bǎ quánlì guān jìn zhìdù de lóngzi lǐ.', 'Bắt buộc phải xây dựng và hoàn thiện hệ thống giám sát chế ước hành chính quyền trách tương xứng, quy chuẩn và minh bạch, thiết thực nhốt quyền lực vào trong chiếc lồng của thể chế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2899] [权利] (quánlì) - quyền lợi, quyền được hưởng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '权利' AND pinyin = 'quánlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '权利' AND pinyin = 'quánlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '权利'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '权利'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'quánlì',
      meaning_vi = 'quyền lợi, quyền được hưởng',
      example_hanzi = '每一个公民都享有平等的受教育权利和劳动的权利。',
      example_pinyin = 'Měi yí ge gōngmín dōu xiǎngyǒu píngděng de shòujiàoyù quánlì hé láodòng de quánlì.',
      example_vi = 'Mỗi một người công dân đều được thụ hưởng quyền bình đẳng về học tập giáo dục và quyền lao động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '权利',
      'quánlì',
      'quyền lợi, quyền được hưởng',
      'Danh từ',
      'HSK 5',
      '每一个公民都享有平等的受教育权利和劳动的权利。',
      'Měi yí ge gōngmín dōu xiǎngyǒu píngděng de shòujiàoyù quánlì hé láodòng de quánlì.',
      'Mỗi một người công dân đều được thụ hưởng quyền bình đẳng về học tập giáo dục và quyền lao động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每一个公民都享有平等的受教育权利和劳动的权利。', 'Měi yí ge gōngmín dōu xiǎngyǒu píngděng de shòujiàoyù quánlì hé láodòng de quánlì.', 'Mỗi một người công dân đều được thụ hưởng quyền bình đẳng về học tập giáo dục và quyền lao động.', 'basic', 1),
      (v_id, '知识产权法为原创性发明专利与文学艺术作品赋予了合法垄断排他的专有权利，切实激发了全社会科技创新活力。', 'Zhīshi chǎnyuán fǎ wèi yuánchuàngxìng fāmíng zhuānlì yǔ wénxué yìshù zuòpǐn fùyǔ le héfǎ lǒngduàn páitā de zhuānyǒu quánlì, qièshí jīfā le quán shèhuì kējì chuàngxīn huólì.', 'Luật sở hữu trí tuệ trao quyền độc quyền hợp pháp mang tính bài trừ cho các bằng sáng chế phát minh và tác phẩm văn học nghệ thuật mang tính nguyên bản, kích hoạt thiết thực sức sống đổi mới khoa học công nghệ của toàn xã hội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2900] [全力] (quánlì) - hết sức, toàn lực, dốc toàn lực [Phó từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '全力' AND pinyin = 'quánlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '全力' AND pinyin = 'quánlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '全力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '全力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Danh từ',
      pinyin = 'quánlì',
      meaning_vi = 'hết sức, toàn lực, dốc toàn lực',
      example_hanzi = '面对即将到来的升学考试，所有高三学生都在全力以赴地备战。',
      example_pinyin = 'Miànduì jíjiāng dàolái de shēngxué kǎoshì, suǒyǒu gāosān xuéshēng dōu zài quánlì-yǐfù de bèizhàn.',
      example_vi = 'Đối mặt với kỳ thi chuyển cấp sắp tới, tất cả học sinh lớp 12 đều đang dốc toàn lực chuẩn bị thi đấu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '全力',
      'quánlì',
      'hết sức, toàn lực, dốc toàn lực',
      'Phó từ / Danh từ',
      'HSK 5',
      '面对即将到来的升学考试，所有高三学生都在全力以赴地备战。',
      'Miànduì jíjiāng dàolái de shēngxué kǎoshì, suǒyǒu gāosān xuéshēng dōu zài quánlì-yǐfù de bèizhàn.',
      'Đối mặt với kỳ thi chuyển cấp sắp tới, tất cả học sinh lớp 12 đều đang dốc toàn lực chuẩn bị thi đấu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对即将到来的升学考试，所有高三学生都在全力以赴地备战。', 'Miànduì jíjiāng dàolái de shēngxué kǎoshì, suǒyǒu gāosān xuéshēng dōu zài quánlì-yǐfù de bèizhàn.', 'Đối mặt với kỳ thi chuyển cấp sắp tới, tất cả học sinh lớp 12 đều đang dốc toàn lực chuẩn bị thi đấu.', 'basic', 1),
      (v_id, '在发生重大自然灾害时，各级政府部门紧急调集救援力量，全力以赴保障人民群众生命财产安全。', 'Zài fāshēng zhòngdà zìrán zāihài shí, gè jí zhèngfǔ bùmén jǐnjí diàojí jiùyuán lìliàng, quánlì-yǐfù bǎozhàng rénmín qúnzhòng shēngmìng cáichǎn ānquán.', 'Khi xảy ra thiên tai thảm họa nghiêm trọng, các cấp cơ quan chính quyền khẩn cấp điều động lực lượng cứu hộ, dốc toàn lực bảo đảm an toàn tính mạng và tài sản của quần chúng nhân dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2901] [全面] (quánmiàn) - toàn diện, bao quát mọi mặt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '全面' AND pinyin = 'quánmiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '全面' AND pinyin = 'quánmiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '全面'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '全面'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'quánmiàn',
      meaning_vi = 'toàn diện, bao quát mọi mặt',
      example_hanzi = '学校不仅重视学生的文化课成绩，还倡导德智体美劳的全面发展。',
      example_pinyin = 'Xuéxiào bùjǐn zhòngshì xuéshēng de wénhuàkè chéngjì, hái chàngdǎo dé-zhì-tǐ-měi-láo de quánmiàn fāzhǎn.',
      example_vi = 'Nhà trường không chỉ coi trọng điểm số môn văn hóa của học sinh mà còn cổ vũ sự phát triển toàn diện cả đức, trí, thể, mỹ, lao động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '全面',
      'quánmiàn',
      'toàn diện, bao quát mọi mặt',
      'Tính từ',
      'HSK 5',
      '学校不仅重视学生的文化课成绩，还倡导德智体美劳的全面发展。',
      'Xuéxiào bùjǐn zhòngshì xuéshēng de wénhuàkè chéngjì, hái chàngdǎo dé-zhì-tǐ-měi-láo de quánmiàn fāzhǎn.',
      'Nhà trường không chỉ coi trọng điểm số môn văn hóa của học sinh mà còn cổ vũ sự phát triển toàn diện cả đức, trí, thể, mỹ, lao động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校不仅重视学生的文化课成绩，还倡导德智体美劳的全面发展。', 'Xuéxiào bùjǐn zhòngshì xuéshēng de wénhuàkè chéngjì, hái chàngdǎo dé-zhì-tǐ-měi-láo de quánmiàn fāzhǎn.', 'Nhà trường không chỉ coi trọng điểm số môn văn hóa của học sinh mà còn cổ vũ sự phát triển toàn diện cả đức, trí, thể, mỹ, lao động.', 'basic', 1),
      (v_id, '全面深化要素市场化配置改革是构建高水平社会主义市场经济体制的核心支柱，有助于大幅提升全要素生产率。', 'Quánmiàn shēnhuà yàosù shìchǎnghuà pèizhì gǎigé shì gòujiàn gāoshuǐpíng shèhuìzhǔyì shìchǎng jīngjì tǐzhì de héxīn zhīzhù, yǒuzhùyú dàfú tíshēng quán yàosù shēngchǎnlǜ.', 'Đào sâu toàn diện cải cách phân bổ theo định hướng thị trường các yếu tố sản xuất là trụ cột cốt lõi để xây dựng thể chế kinh tế thị trường xã hội chủ nghĩa trình độ cao, giúp nâng cao mạnh mẽ năng suất nhân tố tổng hợp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn tất cập nhật HSK 5 - Batch 9! Tổng số từ đã xử lý: %', v_count;
END $$;
